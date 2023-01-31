unit OffsiteBackupThreadTask;
{$I ERP.inc}
interface

uses
  ServerModuleThreadTask, JsonRpcTcpClient, JsonObject, OffsiteBackupConfigObj,
  LogMessageTypes, OffsiteRestoreConfigObj;

type

  TOffsiteBackupThreadTask = class(TServerModuleThreadTask)
  private
    OffsiteBackupConfig: TOffsiteBackupConfig;
    OffsiteRestoreConfig: TOffsiteRestoreConfig;
    LastTask: string;
    LastSubTask: string;
    LastDetail: string;
    IsError: boolean;
    procedure DoBackup;
    procedure DoDownload;
    procedure DoRestore;
    procedure DoBackupOnProgress(Sender: TObject);
  protected
    procedure SetParams(const Value: TJsonObject); override;
    procedure DoWork; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;


implementation

uses
  FtpFileSyncObj, InstallConst, UpdaterConst, FileDownloadFuncs,
  ModuleFileNameUtils, JsonToObject, SysUtils, ModUserUtils, ERPDbListObj,
  ERPDbComponents, DbBackupUtils, Types, IOUtils, StringUtils, SystemLib,
  DBBackupObj, SharedAppUserListObj;

const
  OneSec = 1/24/60/60;

{ TOffsiteBackupThreadTask }

constructor TOffsiteBackupThreadTask.Create;
begin
  inherited;
  OffsiteBackupConfig := TOffsiteBackupConfig.Create;
  OffsiteRestoreConfig := TOffsiteRestoreConfig.Create;
end;

destructor TOffsiteBackupThreadTask.Destroy;
begin
  OffsiteBackupConfig.Free;
  OffsiteRestoreConfig.Free;
  inherited;
end;

procedure TOffsiteBackupThreadTask.DoBackup;
var
  FtpSync: TFtpFileSync;
  ModPath: string;
  ServerConfig: TJsonObject;
  x: integer;

  function CompanyName: string;
  var
    j: TJsonObject;
  begin
    result := 'unknown';
    j := JO;
    try
      j.AsString := Params.S['ConfigText'];
      if j.O['ClientConfig'].S['ERPClientName'] <> '' then
        result := j.O['ClientConfig'].S['ERPClientName']
      else if j.O['ClientConfig'].S['Name'] <> '' then
        result := j.O['ClientConfig'].S['Name'];
    finally
      j.Free;
    end;
  end;

begin
  inherited;
  if not OffsiteBackupConfig.OffsiteBackupEnabled then Exit;
  ModPath := ModuleFileNameUtils.GetCurrentModulePath;
  if not TFileDownloader.DownloadFile(WebUpdatesURL + ERPServerDetailsFile,
           ModPath + ERPServerDetailsFile, frReplaceIfNewer, False) then begin
    Log('Unable to download FTP Server Information file (' + ERPServerDetailsFile +
      ') from ' + WebUpdatesURL, ltError);
    exit;
  end;
  ServerConfig := JO;
  try
    EncryptedFileToJson(ServerConfig,ModPath + ERPServerDetailsFile);

    FtpSync := TFtpFileSync.Create;
    try
      FtpSync.OnLog := self.Log;
      FtpSync.LocalPath := ERP_SERVER_ROOT_DIR + 'Backup\';
      if OffsiteBackupConfig.OffsiteBackupTarget = obCustomServer then begin

        FtpSync.FTPHost := OffsiteBackupConfig.FTPHost;
        FtpSync.FTPUser := OffsiteBackupConfig.FTPUser;
        FtpSync.FTPPass := OffsiteBackupConfig.FTPPass;
        FtpSync.FTPPath := OffsiteBackupConfig.FTPPath;
      end
      else begin
        FtpSync.FTPPath := ServerConfig.O['erp_backup'].S['BackupDir'] + '/' + CompanyName;
        FtpSync.FTPHost := ServerConfig.O['erp_backup'].O['FTP'].S['Host'];
        FtpSync.FTPUser := ServerConfig.O['erp_backup'].O['FTP'].S['User'];
        FtpSync.FTPPass := ServerConfig.O['erp_backup'].O['FTP'].S['Pass'];
      end;
      for x := 0 to OffsiteBackupConfig.DatabaseItems.Count -1 do
        FtpSync.FileMaskList.Add(OffsiteBackupConfig.DatabaseItems[x] + '*.*');

      Params.B['Result'] := FtpSync.UploadCheckFiles;

      Randomize;
      if Params.B['Result'] then
        {$IFDEF NewUserUtils}
          TModUserUtils(ServerModule).ReInitTaskTime(utTaskOffsiteBackup )
        {$ELSE}
          TModUserUtils(ServerModule).NextOffsiteBackupCheckTime :=
                now + OFFSITE_BACKUP_CHECK_INTERVAL + (Random(180) * OneSec)
          {$ENDIF}
      else
       {$IFDEF NewUserUtils}
          TModUserUtils(ServerModule).ReInitTaskTime(utTaskOffsiteBackup , now + (5 * OneMinute));
       {$ELSE}
          TModUserUtils(ServerModule).NextOffsiteBackupCheckTime :=
                now + (5 * OneMinute) + (Random(180) * OneSec);
       {$ENDIF}
    finally
      FtpSync.Free;
    end;
  finally
    ServerConfig.Free;
  end;
end;

procedure TOffsiteBackupThreadTask.DoBackupOnProgress(Sender: TObject);
var
  Backup: TDBBackup;
//  IsError: boolean;
begin
  Backup:= TDBBackup(Sender);
  if SameText(Backup.Progress.SubOperationName,'Error') then begin
    IsError:= true;
  end;
  if (LastTask <> Backup.Progress.OperationName) and (Backup.Progress.OperationName <> '') then begin
    LastTask:= Backup.Progress.OperationName;
    if IsError then
      Log(LastTask,ltError)
    else
      Log(LastTask,ltDetail);
  end;
  if (Backup.Progress.SubOperationName <> '') and (LastSubTask <> Backup.Progress.SubOperationName) then begin
    LastSubTask:= Backup.Progress.SubOperationName;
    if IsError then
      Log(LastSubTask,ltError)
    else
      Log(LastSubTask,ltDetail);
  end;
  if (LastDetail <> Backup.Progress.Detail) and (Backup.Progress.Detail <> '') then begin
    LastDetail:= Backup.Progress.Detail;
    if IsError then
      Log(LastDetail,ltError)
    else
      Log(LastDetail,ltDetail);
  end;
end;

procedure TOffsiteBackupThreadTask.DoDownload;
var
  FtpSync: TFtpFileSync;
  x, y: integer;
begin
  y := -1;
  if not OffsiteRestoreConfig.OffsiteRestoreEnabled then exit;
  try
    FtpSync := TFtpFileSync.Create;
    try
      FtpSync.OnLog := self.Log;
      FtpSync.LocalPath := OffsiteRestoreConfig.LocalPath;

      FtpSync.FTPHost := OffsiteRestoreConfig.FTPHost;
      FtpSync.FTPPath := OffsiteRestoreConfig.FTPPath;
      FtpSync.FTPUser := OffsiteRestoreConfig.FTPUser;
      FtpSync.FTPPass := OffsiteRestoreConfig.FTPPass;

      try
      for x := 0 to OffsiteRestoreConfig.DatabaseItems.Count -1 do begin
        y := x;
        FtpSync.FileMaskList.Add(Lowercase(OffsiteRestoreConfig.DatabaseItems[x]));
      end;
      except
        on e: exception do begin
          Log('An error occured while adding a database name to the list of databases to download.' +  #13#10 +
            ' There are ' + IntToStr(OffsiteRestoreConfig.DatabaseItems.Count) +
            ' databases selected.' + #13#10 +
            'The current value of x is ' + IntToStr(y)  + #13#10 +
            'The exception message returned: ' + #13#10 + e.Message, ltError);
        end;
      end;

      FtpSync.DownloadCheckFiles;

    finally
      FtpSync.Free;
    end;
  except
    on e: exception do begin
      Log('Unable to download file from FTP Server: ' + e.Message, ltError);
    end;
  end;
end;

procedure TOffsiteBackupThreadTask.DoRestore;
var
  x, y: integer;
  dbList: TERPDbList;
  db, Version: string;
  qry: TERPQuery;
  ControlFile: TJsonObject;
  backName: string;
  FileList: TStringDynArray;
  parts: integer;
  ReadOk: boolean;
  Backup: TDBBackup;
  msg: string;
  dt1, dt2: TDateTime;
  fileExt: string;
  timeOk: boolean;
  ArcName: string;

  { returns the name without an extension }
  function GetLatestBackupName(aNamePrefix: string): string;
  var
    i: integer;
    obj: TJsonObject;
    dt, dtTemp, dtRestored: TDateTime;
  begin
    result := '';
    dt := 0;
    dtRestored := 0;
    for i := 0 to ControlFile.A['RemoteFiles'].Count -1 do begin
      obj := ControlFile.A['RemoteFiles'].Items[i].AsObject;
      if Pos(Lowercase(aNamePrefix),Lowercase(obj.S['FileName'])) = 1 then begin
        if (not obj.BooleanExists('Restored')) or (not obj.B['Restored']) then begin
          dtTemp := TDbBackupUtils.ExtractBackupTime(obj.S['FileName']);
          if dtTemp > dt then begin
            dt := dtTemp;
            result := ChangeFileExt(obj.S['FileName'],'');
          end;
        end;
        if obj.BooleanExists('Restored') and obj.B['Restored'] then begin
          dtTemp := TDbBackupUtils.ExtractBackupTime(obj.S['FileName']);
          if dtTemp > dtRestored then
            dtRestored := dtTemp;
        end;
      end;
    end;
    if dtRestored > dt then
      result := '';
  end;

  procedure FlagAsRestored(aFileName: string);
  var
    i: integer;
    obj: TJsonObject;
  begin
    for i := 0 to ControlFile.A['RemoteFiles'].Count -1 do begin
      obj := ControlFile.A['RemoteFiles'].Items[i].AsObject;
      if Pos(Lowercase(aFileName),Lowercase(obj.S['FileName'])) = 1 then begin
        obj.B['Restored'] := true;
        ControlFile.SaveToFile(OffsiteRestoreConfig.LocalPath + FtpFileSyncObj.ControlFileName);
      end;
    end;
  end;

  function FileDownloaded(aFileName: string): boolean;
  var
    i: integer;
    obj: TJsonObject;
    s: string;
  begin
    result := false;
    s := ExtractFileName(aFileName);
    for i := 0 to ControlFile.A['RemoteFiles'].Count -1 do begin
      obj := ControlFile.A['RemoteFiles'].Items[i].AsObject;
      if SameText(obj.S['FileName'],s) then begin
        result := true;
        break;
      end;
    end;
  end;

begin
  if not OffsiteRestoreConfig.OffsiteRestoreEnabled then exit;
  try
    Log('Checking for Remote Databases that need to be restored', ltDetail);
    timeOk := false;
    dt1 := Frac(OffsiteRestoreConfig.TimeStart);
    dt2 := Frac(OffsiteRestoreConfig.TimeEnd);

    if (dt2 > dt1) then begin
      { two times on same day }
      if (Frac(Now) >= dt1) and (Frac(Now) <= dt2) then
        timeOk := true;
    end
    else if (dt2 < dt1) then begin
      { dt2 is next day .. }
      if (Frac(Now) >= dt1) or (Frac(Now) <= dt2) then
        timeOk := true;
    end;

    if not timeOk then begin
      Log('Current time ' + FormatDateTime('hh:nn:ss',now) +
        ' is outside the selected time frame to restore files of ' +
        FormatDateTime('hh:nn:ss',dt1) + ' to ' + FormatDateTime('hh:nn:ss',dt2) +
        ' Will not check for files.',ltDetail);
      exit;
    end;
    dbList := TERPDbList.Create(MySQLServer);
    qry := TERPQuery.Create(nil);
    ControlFile := JO;
    Backup:= TDBBackup.Create;
    try
      qry.SQL.Add('select Version from tblupdatedetails where Current = "T"');
      ControlFile.LoadFromFile(OffsiteRestoreConfig.LocalPath + FtpFileSyncObj.ControlFileName);
      Backup.ServerName := MySQLServer;
      Backup.OnLog := Log;
      Backup.OnProgress := self.DoBackupOnProgress;
      for x := 0 to OffsiteRestoreConfig.DatabaseItems.Count -1 do begin
        fileExt := '.zip';
        db := OffsiteRestoreConfig.DatabaseItems[x];
        if not dbList.GoToDatabase(db) then begin
          Log('Database ' + db + ' is selected to for Remote Restore but does not exist on this server.',ltWarning);
          continue;
        end;
        Log('Checking Database ' + db + ' for new backups.',ltDetail);
        qry.Connection := dbList.Connection;
        qry.Open;
        try
          Version := qry.FieldByName('Version').AsString;
        finally
          qry.Close;
        end;
        if Version = '' then begin
          Log('The Version number for Database ' + db + ' is blank.',ltError);
          continue;
        end;
        db := db + '_' + Version + '_Backup_';
        backName := GetLatestBackupName(db);
        if backName <> '' then begin
          Log('New backup file found ' + backName,ltDetail);
          FileList := TDirectory.GetFiles(OffsiteRestoreConfig.LocalPath,backName + '.*');
          if High(FileList) >= 0 then begin
            { we have more than one file in the backup set, make sure we have them all }
            if StringUtils.IndexOf(OffsiteRestoreConfig.LocalPath + backName + '.txt',FileList) > -1 then begin
              parts := TDbBackupUtils.NumberOfParts(OffsiteRestoreConfig.LocalPath + backName + '.txt');
              if parts < 1 then begin
                Log('Could not read number of archive files from: ' + backName + '.txt',ltError);
                Continue;
              end;
              if parts <> High(FileList) then begin
                Log('Number of file parts does not match, actual: ' + IntToStr(High(FileList)) + ' expected: ' + IntToStr(parts),ltWarning);
                Continue;
              end;
              { we should have all the parts, try locking them to make sure none are still downloading }
              ReadOk := true;
              for y := Low(FileList) to High(FileList) do begin
                if not SameText(ExtractFileExt(FileList[y]),'.txt') then begin
                  if not SystemLib.FileCanBeOpendForReading(FileList[y]) then begin
                    ReadOk := false;
                    break;
                  end;
                end;
              end;
              if not ReadOk then begin
                Log('At least one of the files in the backup set is in use, can not restore at this time.',ltWarning);
                Continue;
              end;
            end
            else if StringUtils.IndexOf(OffsiteRestoreConfig.LocalPath + backName + '.7z',FileList) > -1 then begin
              // this is new 7z style backup
              fileExt := '.7z';
            end
            else begin
              Log('This is a multipart backup but the following file is missing: ' + backName + '.txt',ltWarning);
              continue;
            end;
          end;
          { now we can restore }


          if (not TSharedAppUserList.ExUserExists('ERP_Admin_Restore_User', OffsiteRestoreConfig.DatabaseItems[x], MySQLServer)) and
             (not TSharedAppUserList.ExAddUser(msg, 'ERP_Admin_Restore_User', OffsiteRestoreConfig.DatabaseItems[x],MySQLServer,'','','',false,true)) then begin
            { could not add user .. report and exit }
            Log('Could not add user (ERP_Admin_Restore_User)',ltWarning);
            continue;
          end;
          try

            if not TSharedAppUserList.ExLockLogon(msg, 'ERP_Admin_Restore_User', OffsiteRestoreConfig.DatabaseItems[x],'Performing a Database Restore',MySQLServer) then begin
              { could not lock logon .. report and exit }
              Log('Could not lock database ' + backName + ' to restore it: ' + msg,ltWarning);
              continue;
            end;
            try
              if TSharedAppUserList.ExDatabaseUserCount(OffsiteRestoreConfig.DatabaseItems[x], MySQLServer) > 1 then begin
                Log('Could not restore database ' + backName + ', users in the system',ltWarning);
                continue;
              end;


              dt1 := now;
              Backup.DatabaseName := OffsiteRestoreConfig.DatabaseItems[x];

              if not Backup.Backup(false) then begin
                Log('Failed to backup database before restoring offsite backup', ltError);
                Continue;
              end;
              ArcName := Backup.BackupArchiveFileName;

              if Backup.Restore(OffsiteRestoreConfig.LocalPath + backName + fileExt) then begin
                FlagAsRestored(backName);
                Log('Restore of ' + backName + ' complete, time taken ' +
                  FormatDateTime('hh',now-dt1) + ' hours ' +
                  FormatDateTime('nn',now-dt1) + ' minutes ' +
                  FormatDateTime('ss',now-dt1) + ' seconds',ltInfo);
              end
              else begin
                Log('Failed to restore offsite backup, will now restore previous version', ltError);
                if not Backup.Restore(ArcName) then begin
                  Log('Failed to restore backup', ltError);
                end;
              end;
            finally
              TSharedAppUserList.ExUnlockLogon('ERP_Admin_Restore_User', OffsiteRestoreConfig.DatabaseItems[x], MySQLServer);

            end;
          finally
            TSharedAppUserList.ExRemoveUser('ERP_Admin_Restore_User', MySQLServer, OffsiteRestoreConfig.DatabaseItems[x]);
          end;
        end;
      end;
    finally
      qry.Free;
      dbList.Free;
      ControlFile.Free;
      Backup.Free;
    end;
  except
    on e: exception do begin
      Log('Error restoring offsite backup: ' + e.Message,ltError);
    end;
  end;
end;

procedure TOffsiteBackupThreadTask.DoWork;
begin
  try
    DoBackup;
  except
  end;
  try
    DoDownload;
  except
  end;
  try
    DoRestore;
  except
  end;
end;

procedure TOffsiteBackupThreadTask.SetParams(const Value: TJsonObject);
begin
  inherited;
  OffsiteBackupConfig.AsString := Value.S['OffsiteBackupConfigText'];
  OffsiteRestoreConfig.AsString := Value.S['OffsiteRestoreConfigText'];
end;

end.
