unit BackupThreadTaskObj;

interface

uses
  ThreadTaskObj;

type

  TBackupThreadTask = class(TThreadTaskBase)
  private
    LastTask,
    LastSubTask,
    LastDetail: string;
    procedure DoOnBackupProgress(Sender: TObject);
  protected
    procedure DoWork; override;
  end;


implementation

uses
  ModuleUserUtilsObj, ModuleConst, JsonObject, LogThreadBase, LogMessageTypes,
  DBBackupObj, sysutils;

{ TBackupThreadTask }

procedure TBackupThreadTask.DoOnBackupProgress(Sender: TObject);
var
  Backup: TDBBackup;
  IsError: boolean;
begin
  Backup:= TDBBackup(Sender);
  if TaskStatus <> tsRunning then begin
    Backup.Active:= false;
    exit;
  end;
  with TJsonObject.Create do begin
    try
      IsError:= false;
      S['Task']:= Backup.Progress.OperationName;
      if SameText(Backup.Progress.SubOperationName,'Error') then begin
        S['Result']:= 'Error';
        IsError:= true;
      end
      else begin
        if Backup.Progress.SubOperationName <> '' then
          S['SubTask']:= Backup.Progress.SubOperationName;
      end;
      if Backup.Progress.Detail <> '' then
        S['Detail']:= Backup.Progress.Detail;
      if not ((Backup.Progress.StepNo = 1) and (Backup.Progress.StepCount = 1)) then begin
        I['StepNo']:= Backup.Progress.StepNo;
        I['StepCount']:= Backup.Progress.StepCount;
      end;
      if (LastTask <> Backup.Progress.OperationName) and (Backup.Progress.OperationName <> '') then begin
        LastTask:= Backup.Progress.OperationName;
        if IsError then
          Log(LastTask,ltError)
        else
          Log(LastTask,ltDetail);
      end;
      if (LastSubTask <> Backup.Progress.SubOperationName) and (Backup.Progress.SubOperationName <> '') then begin
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


      UpdateStatus(AsString);
    finally
      Free;
    end;
  end;
end;

procedure TBackupThreadTask.DoWork;
var
  UtilsModule: TModuleUserUtils;
  UserName: string;
  msg: string;
  UserCount: integer;
  json{, item, UpdateCheckJson}: TJsonObject;
  Logger: TLoggerBase;
  Backup: TDBBackup;
  UserAdded: boolean;
begin
  UtilsModule:= TModuleUserUtils(fServerModule);
  Logger:= UtilsModule.Logger;
//  UpdateCheckJson:= nil;
  if fParams.StringExists('UserName') then
    UserName:= fParams.S['UserName']
  else
    UserName:= ERP_ADMIN_USER;
  Logger.Log('Database ' + fParams.S['Operation'] + ' for ' + fParams.S['DatabaseName']+ ': Started.', ltInfo);

  UserAdded:= false;
  UtilsModule.Lock;
  if not UtilsModule.AppUserList.UserExists(UserName,fParams.S['DatabaseName']) then begin
    if not UtilsModule.AppUserList.AddUser(msg,UserName,fParams.S['DatabaseName']) then begin
      json:= JO;
      try
        json.S['Task']:= 'Database ' + fParams.S['Operation'];
        json.S['Result']:= 'Fail';
        json.S['Detail']:= 'Could not add user :' + msg;
        Logger.Log(json.S['TaskName'] + ' failed for ' + fParams.S['DatabaseName']+ ': ' + json.S['Detail'], ltError);
        Lock;
        fWasError:= true;
        UnLock;
        UpdateStatus(json.AsString);
      finally
        json.Free;
      end;
      exit;
    end;
    UserAdded := true;
  end;
  if UtilsModule.AppUserList.LockLogon(msg, UserName,fParams.S['DatabaseName'],'Performing a Database ' + fParams.S['Operation']) then begin
    UserCount:= UtilsModule.AppUserList.DatabaseUserCount(fParams.S['DatabaseName']);
    UtilsModule.Unlock;
    try
      if UserCount > 1 then begin
        json:= JO;
        try
          json.S['Task']:= 'Database ' + fParams.S['Operation'];
          json.S['Result']:= 'Fail';
          json.S['Detail']:= 'Users in database';
          Logger.Log(json.S['TaskName'] + ' failed for ' + fParams.S['DatabaseName']+ ': ' + json.S['Detail'], ltError);
          Lock;
          fWasError:= true;
          UnLock;
          UpdateStatus(json.AsString);
        finally
          json.Free;
        end;
        exit;
      end;
      { ok to proceed }
      Backup:= TDBBackup.Create;
      try
        Backup.OnProgress:= DoOnBackupProgress;
        if fParams.StringExists('ServerName') then
          Backup.ServerName:= fParams.S['ServerName']
        else
          Backup.ServerName:= 'localhost';

        if SameText(fParams.S['Operation'],'Backup') then begin
          Backup.DatabaseName:= fParams.S['DatabaseName'];
          if not Backup.Backup then begin
            Lock;
            fWasError:= true;
            UnLock;
          end;
        end
        else if SameText(fParams.S['Operation'],'Restore') then begin
          Backup.DatabaseName:= fParams.S['DatabaseName'];
          if fParams.B['BackupFirst'] and Backup.DbExists(Backup.DatabaseName) then begin
            if not Backup.Backup then begin
              Lock;
              fWasError:= true;
              UnLock;
              exit;
            end;
          end;
          if not Backup.Restore(Backup.BackupPath + fParams.S['archivename']) then begin
            Lock;
            fWasError:= true;
            UnLock;
          end
          else begin
            { make adjustments for time zone }
            Backup.CheckAndAdjustTimeZone;
            { need to check for updates }
//            UpdateCheckJson:= JO;
//            try
//              item:= JO;
//              item.S['DatabaseName']:= fParams.S['DatabaseName'];
//              item.B['SkipBackup']:= true;
//              item.S['ArchiveName']:= fParams.S['archivename'];
//              UpdateCheckJson.A['List'].Add(item);
////              UtilsModule.ForceUpdate(json.AsString);
//            finally
////              json.Free;
//            end;
          end;
        end
        else if SameText(fParams.S['Operation'],'Remove') then begin
          Backup.DatabaseName:= fParams.S['DatabaseName'];
          if not Backup.Remove then begin
            Lock;
            fWasError:= true;
            UnLock;
          end;
        end
        else if SameText(fParams.S['Operation'],'Copy') then begin
          Backup.DatabaseName:= fParams.S['DatabaseName'];
          if not Backup.Clone(fParams.S['NewDatabaseName']) then begin
            Lock;
            fWasError:= true;
            UnLock;
          end;
        end
        else if SameText(fParams.S['Operation'],'CopyRo') then begin
          Backup.DatabaseName:= fParams.S['DatabaseName'];
          if not Backup.Clone(fParams.S['NewDatabaseName'],true) then begin
            Lock;
            fWasError:= true;
            UnLock;
          end;
        end
        else if SameText(fParams.S['Operation'],'Optimise') then begin
          Backup.DatabaseName:= fParams.S['DatabaseName'];
          if not Backup.Optimise then begin
            Lock;
            fWasError:= true;
            UnLock;
          end;
        end

      finally
        backup.Free;
      end;

      Logger.Log('Database ' + fParams.S['Operation'] + ' for ' + fParams.S['DatabaseName']+ ': Finished.', ltInfo);
    finally
      UtilsModule.Lock;
      UtilsModule.AppUserList.UnlockLogon(UserName,fParams.S['DatabaseName']);
      if UserAdded then
        UtilsModule.AppUserList.RemoveUser(UserName,fParams.S['DatabaseName']);
      UtilsModule.Unlock;
    end;
    json:= JO;
    try
//      json.S['Task']:= 'Database ' + fParams.S['Operation'];
      if fWasError then begin
        json.S['Result']:= 'Fail';
        json.S['Detail']:= 'Operation failed';
        Logger.Log(json.S['TaskName'] + ' failed for ' + fParams.S['DatabaseName'], ltError);
      end
      else begin
        json.S['Result']:= 'Ok';
        json.S['Detail']:= 'Operation completed ok';
        Logger.Log(json.S['TaskName'] + ' completed ok for ' + fParams.S['DatabaseName'], ltInfo);
//        if Assigned(UpdateCheckJson) then begin
//          UtilsModule.ForceUpdate(UpdateCheckJson.AsString);
//        end;
      end;
      UpdateStatus(json.AsString);
    finally
      json.Free;
//      UpdateCheckJson.Free;
    end;
  end
  else begin
    UtilsModule.Unlock;
    json:= JO;
    try
      json.S['Task']:= 'Database ' + fParams.S['Operation'];
      json.S['Result']:= 'Fail';
      json.S['Detail']:= 'Could not Lock Logon - ' + msg;
      Logger.Log(json.S['TaskName'] + ' failed for ' + fParams.S['DatabaseName']+ ': ' + json.S['Detail'], ltError);
      Lock;
      fWasError:= true;
      UnLock;
      UpdateStatus(json.AsString);
    finally
      json.Free;
    end;
  end;
end;

end.
