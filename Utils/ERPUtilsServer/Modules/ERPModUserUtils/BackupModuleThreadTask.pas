unit BackupModuleThreadTask;

interface

uses
  ServerModuleThreadTask;

type

  TBackupModuleThreadTask = class(TServerModuleThreadTask)
  private
    LastTask,
    LastSubTask,
    LastDetail: string;
    procedure DoOnBackupProgress(Sender: TObject);
    procedure DoOnDatabase(Sender: TObject);
  protected
    procedure DoWork; override;
  end;


implementation

uses
  DBBackupObj, JsonObject, SysUtils, LogMessageTypes, ModuleConst,
  SharedAppUserListObj;

{ TBackupModuleThreadTask }

procedure TBackupModuleThreadTask.DoOnBackupProgress(Sender: TObject);
var
  Backup: TDBBackup;
  IsError: boolean;
begin
  Backup:= TDBBackup(Sender);
  if Terminated then begin
    Backup.Active:= false;
    exit;
  end;
  with TJsonObject.Create do begin
    try
      S['TaskId'] := self.TaskId;
      IsError:= false;

      S['Task']:= Backup.Progress.OperationName;
      if SameText(Backup.Progress.SubOperationName,'Error') then begin
        S['Result']:= 'Error';
        IsError:= true;
      end
      else if SameText(Backup.Progress.SubOperationName,'Done') then begin
        S['Result']:= 'Ok';
        S['SubTask']:= Backup.Progress.SubOperationName;
        S['Detail']:= Backup.Progress.Detail;
        I['StepNo']:= Backup.Progress.StepNo;
        I['StepCount']:= Backup.Progress.StepCount;
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


      UpdateStatus(AsString);
    finally
      Free;
    end;
  end;
end;

procedure TBackupModuleThreadTask.DoOnDatabase(Sender: TObject);
begin
  if Sender is TDBBackup then
    self.StatusMessage := TDBBackup(Sender).DatabaseName;
end;

procedure TBackupModuleThreadTask.DoWork;
var
  UserName: string;
  msg: string;
  UserCount: integer;
  json{, item, UpdateCheckJson}: TJsonObject;
  Backup: TDBBackup;
  UserLoggedIn: boolean;
begin
//  RemoveWhenComplete := false;
  if Params.StringExists('UserName') then
    UserName:= Params.S['UserName']
  else
    UserName:= ERP_ADMIN_USER;
  Log('Database ' + Params.S['Operation'] + ' for ' + Params.S['DatabaseName']+ ': Started.', ltInfo);

  msg:= '';
  UserLoggedIn := TSharedAppUserList.ExUserExists(UserName, Params.S['DatabaseName'], MySQLServer);
//  if (not TSharedAppUserList.ExUserExists(UserName, Params.S['DatabaseName'], MySQLServer)) and
//     (not TSharedAppUserList.ExAddUser(msg, UserName, Params.S['DatabaseName'],MySQLServer)) then begin
  if (not UserLoggedIn) and
    (not TSharedAppUserList.ExAddUser(msg, UserName, Params.S['DatabaseName'],MySQLServer,'','','',false,true)) then begin
    { could not add user .. report and exit }
    json:= JO;
    try
      json.S['Task']:= 'Database ' + Params.S['Operation'];
      json.S['Result']:= 'Fail';
      json.S['Detail']:= 'Could not add user';
      if msg <> '' then
        json.S['Detail'] := json.S['Detail'] + ': ' + msg;
      Log(json.S['TaskName'] + ' failed for ' + Params.S['DatabaseName']+ ': ' + json.S['Detail'], ltError);
      UpdateStatus(json.AsString);
    finally
      json.Free;
    end;
    exit;
  end;
  try
    if not TSharedAppUserList.ExLockLogon(msg, UserName, Params.S['DatabaseName'],'Performing a Database ' + Params.S['Operation'],MySQLServer, 60) then begin
      { could not lock logon .. report and exit }
      json:= JO;
      try
        json.S['Task']:= 'Database ' + Params.S['Operation'];
        json.S['Result']:= 'Fail';
        json.S['Detail']:= 'Could not Lock Logon - ' + msg;
        Log(json.S['TaskName'] + ' failed for ' + Params.S['DatabaseName']+ ': ' + json.S['Detail'], ltError);
        UpdateStatus(json.AsString);
      finally
        json.Free;
      end;
      exit;
    end;
    try
      UserCount := TSharedAppUserList.ExDatabaseUserCount(Params.S['DatabaseName'], MySQLServer);
      { users in database .. report and exit }
      if UserCount > 1 then begin
        json:= JO;
        try
          json.S['Task']:= 'Database ' + Params.S['Operation'];
          json.S['Result']:= 'Fail';
          json.S['Detail']:= 'Users in database';
          Log(json.S['TaskName'] + ' failed for ' + Params.S['DatabaseName']+ ': ' + json.S['Detail'], ltError);
          UpdateStatus(json.AsString);
        finally
          json.Free;
        end;
        exit;
      end;

      { ok to proceed }
      Backup:= TDBBackup.Create;
      try
        Backup.OnDatabase := DoOnDatabase;
        Backup.OnProgress:= DoOnBackupProgress;
        Backup.OnLog := Log;
        if Params.StringExists('ServerName') then
          Backup.ServerName:= Params.S['ServerName']
        else
          Backup.ServerName:= MySQLServer;

        if SameText(Params.S['Operation'],'Backup') then begin
          Backup.DatabaseName:= Params.S['DatabaseName'];
          self.StatusMessage := 'Backup: ' + Backup.DatabaseName;
          if not Backup.Backup then begin

          end;
        end
        else if SameText(Params.S['Operation'],'Restore') then begin
          Backup.DatabaseName:= Params.S['DatabaseName'];
          self.StatusMessage := 'Restore: ' + Backup.DatabaseName;
          if Params.B['BackupFirst'] and Backup.DbExists(Backup.DatabaseName) then begin
            if not Backup.Backup(false) then begin
              exit;
            end;
          end;
          if not Backup.Restore(Backup.BackupPath + Params.S['archivename']) then begin

          end
          else begin
            { make adjustments for time zone }
            Backup.CheckAndAdjustTimeZone;
          end;
        end
        else if SameText(Params.S['Operation'],'Remove') then begin
          Backup.DatabaseName:= Params.S['DatabaseName'];
          self.StatusMessage := 'Remove: ' + Backup.DatabaseName;
          if Params.B['BackupFirst'] and Backup.DbExists(Backup.DatabaseName) then begin
            if not Backup.Remove then begin

            end;
          end else begin
            if not Backup.DoRemovedb(nil) then begin
            end;
          end;
        end
        else if SameText(Params.S['Operation'],'Copy') then begin
          Backup.DatabaseName:= Params.S['DatabaseName'];
          self.StatusMessage := 'Copy: ' + Backup.DatabaseName;
          if not Backup.Clone(Params.S['NewDatabaseName']) then begin

          end;
        end
        else if SameText(Params.S['Operation'],'NonERPClone') then begin
          Backup.DatabaseName:= Params.S['DatabaseName'];
          self.StatusMessage := 'Copy: ' + Backup.DatabaseName;
          if not Backup.Clone(Params.S['NewDatabaseName'], False, True) then begin
          end else begin

          end;
        end
        else if SameText(Params.S['Operation'],'CopyRo') then begin
          Backup.DatabaseName:= Params.S['DatabaseName'];
          self.StatusMessage := 'Copy (readonly): ' + Backup.DatabaseName;
          if not Backup.Clone(Params.S['NewDatabaseName'],true) then begin

          end;
        end
        else if SameText(Params.S['Operation'],'Optimise') then begin
          Backup.DatabaseName:= Params.S['DatabaseName'];
          self.StatusMessage := 'Optimise: ' + Backup.DatabaseName;
          if not Backup.Optimise then begin

          end;
        end
      finally
        backup.Free;
      end;

    finally
      TSharedAppUserList.ExUnlockLogon(UserName, Params.S['DatabaseName'], MySQLServer);
    end;
  finally
    if not UserLoggedIn then
      TSharedAppUserList.ExRemoveUser(UserName,MySQLServer,Params.S['DatabaseName']);
    self.StatusMessage := '';
  end;
end;

end.
