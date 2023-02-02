unit BatchUpdateModuleThreadTask;

interface

uses
  ServerModuleThreadTask, DBBackupObj;

type

  TBatchUpdateModuleThreadTask = class(TServerModuleThreadTask)
  private
    LastTask: string;
    IsError: boolean;
    LastSubTask: string;
    LastDetail: string;
    procedure DoOnScriptBeforeExecute(Sender: TObject; var SQL: string; var Omit: boolean);
    procedure DoBackupOnProgress(Sender: TObject);
    procedure DoExportOnProgress(Sender: TObject);
    procedure DoExternalOnProgress(Sender: TObject);
  protected
    procedure DoWork; override;
  public
    constructor Create; override;
  end;


implementation

uses
  SysUtils, MyScript, ERPDbComponents, classes, TransactionsTable, DbUtils,
  DbConst, MySQLUtils, LogMessageTypes, AppEnvironmentVirtual,
  SharedAppUserListObj, UserLockObj, ExportToReportDBObj, ExportERPDBExternal;

{ TBatchUpdateModuleThreadTask }

procedure TBatchUpdateModuleThreadTask.DoExportOnProgress(Sender: TObject);
var
  ExportToreportDB: TExportToreportDB;
begin
  ExportToreportDB:= TExportToreportDB(Sender);
  if SameText(ExportToreportDB.Progress.SubOperationName, 'Error') then Log(ExportToreportDB.Progress.Detail,ltError)
  else Log(ExportToreportDB.Progress.Detail, ltDetail);
end;

procedure TBatchUpdateModuleThreadTask.DoExternalOnProgress(Sender: TObject);
var
  ExportExternal: TExportToExternal;
begin
  ExportExternal := TExportToExternal(Sender);
  if SameText(ExportExternal.Progress.SubOperationName, 'Error') then Log(ExportExternal.Progress.Detail,ltError)
  else Log(ExportExternal.Progress.Detail, ltDetail);
end;

constructor TBatchUpdateModuleThreadTask.Create;
begin
  inherited;
  Log('BATCH UPDATE MODULE THREAD TASK CREATE', ltinfo)
end;

procedure TBatchUpdateModuleThreadTask.DoBackupOnProgress(Sender: TObject);
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

procedure TBatchUpdateModuleThreadTask.DoOnScriptBeforeExecute(Sender: TObject;
  var SQL: string; var Omit: boolean);
begin
  if Terminated then begin
    Omit := true;
    TMyScript(Sender).BreakExec;
  end;

end;

procedure TBatchUpdateModuleThreadTask.DoWork;
var
  Conn: TERPConnection;
  sl: TStringList;
  x: integer;
  UserCount: integer;
  TransactionTableObj: TTransactionTableObj;
  DbBackup: TDBBackup;
  ExportToreportDB: TExportToreportDB;
  //ExportExternal : TExportToExternal;
  qry: TERPQuery;
  doBackup: boolean;
  DoNonERPClone: boolean;
  doExport: boolean;
  //doExternal: boolean;
begin
  inherited;

  Conn := TERPConnection(GetNewDbConnection());
  sl := TStringList.Create;
  DbBackup := TDBBackup.Create;
  ExportToreportDB := TExportToreportDB.Create;
  //ExportExternal := TExportToExternal.Create;

  qry := TERPQuery.Create(nil);
  try
    DbBackup.OnProgress := Self.DoBackupOnProgress;
    ExportToreportDB.OnProgress := Self.DoExportOnProgress;
    //ExportExternal.OnProgress := self.DoExternalOnProgress;
    Conn.Database := MYSQL_DATABASE;
    MySQLUtils.SetConnectionServer(Conn, MySQLServer);
  //  Conn.Connect;
//    qry.SQL.Text := 'select FieldValue from tbldbpreferences where Name = "BackupAfterRestart"';

    sl.CommaText := MySQLUtils.DatabaseList(Conn, True);
    Log('Starting Batch Update, Optimize and Backup Check on all databases.', ltInfo);
    for x := 0 to sl.Count - 1 do begin
      if SameText(sl[x],'erpnewdb') then Continue;
      Log('Starting To Check and Run "Batch Update", "Backup", "NonERPClone" and "Export", IN DATABASE ' +  sl[x] + '.', ltInfo);
      Self.StatusMessage := 'Database: ' + sl[x];
      if Terminated then begin
        Log('Stopping Batch Update, task is terminating.', ltInfo);
        Exit;
      end;
      Conn.Disconnect;
      Conn.Database := sl[x];
      Conn.Connect;
      try
        { shared connection used by app env }
        DbBackup.ServerName := Conn.Server;
        DbBackup.DatabaseName := Conn.Database;

        ExportToreportDB.ServerName := Conn.Server;
        ExportToreportDB.DatabaseName := Conn.Database;

        TAppEnvVirtualGUI(AppEnvVirt).SharedDbConnection := Conn;
        try
          UserCount := TSharedAppUserList.ExDatabaseUserCount(sl[x], MySQLServer);
          if (not AppEnvVirt.Bool['CompanyPrefs.BatchUpdateInProgress']) then begin
            Log('Starting Backup / export.', ltInfo);
            //if TSharedAppUserList.ExLockLogon(msg, UserName, Params.S['DatabaseName'],'Performing a Database ' + Params.S['Operation']) then begin
            if (UserCount < 1) then begin
              qry.Connection := Conn;
              qry.SQL.Text := 'SELECT FieldValue FROM tbldbpreferences WHERE Name = "BackupAfterRestart"';
              qry.Open;
              doBackup := qry.FieldByName('FieldValue').AsString = 'T';
              qry.Close;

              qry.SQL.Text := 'SELECT FieldValue FROM tbldbpreferences WHERE Name = "ExporttoReportDBAfterRestart"';
              qry.Open;
              doExport := qry.FieldByName('FieldValue').AsString = 'T';
              qry.Close;

              qry.SQL.Text := 'SELECT FieldValue FROM tbldbpreferences WHERE Name = "NonERPCloneAfterRestart"';
              qry.Open;
              DoNonERPClone := qry.FieldByName('FieldValue').AsString = 'T';
              qry.Close;

              {optimise before backup batch update}
              Self.StatusMessage := 'Optimise: ' + DbBackup.DatabaseName;
              DbBackup.Optimise;
              if doBackup then begin
                Self.StatusMessage := 'Backup: ' + DbBackup.DatabaseName;
                DbBackup.Backup();
              end else Log(Conn.Database + ' : Backup after Update is not Enabled', ltInfo);

              if doExport then begin
                Self.StatusMessage := 'Exporting: ' + ExportToreportDB.DatabaseName;
                ExportToreportDB.ExportToreport();
              end else Log(Conn.Database + ' : Export to Report DB after Update is not Enabled', ltInfo);

              if DoNonERPClone then begin
                Self.StatusMessage := 'Cloning: ' + DbBackup.DatabaseName;
                DbBackup.Clone(DbBackup.DatabaseName + '_NonERPClone', False, True)
              end else Log(Conn.Database + ' : NonERPCloning database is not Enabled', ltInfo);

              LastTask := '';
              IsError := False;
              LastSubTask := '';
              LastDetail := '';

              try
                AppEnvVirt.Bool['CompanyPrefs.BatchUpdateInProgress'] := False;
                TransactionTableObj := TTransactionTableObj.Create(False);
                try
                  TransactionTableObj.BeforeScriptExecute := DoOnScriptBeforeExecute;
                  if (UserCount < 1) then
                    TransactionTableObj.SetEmptyGlobalRef;
                    if Terminated then begin
                      Log('Stopping Batch Update, task is terminating.', ltInfo);
                      exit;
                    end;
                     Self.StatusMessage := 'Batch Update: ' + Conn.Database;
                    TransactionTableObj.CleanRefreshTrnsTable(True, False, True, True);
                finally
                  FreeandNil(TransactionTableObj);
                end;

                //  Debuglib.RecalculateproductAvgcost;
                Log('... Finished Batch Update on Database ' +  sl[x] + '.', ltInfo);
              except
                on e: exception do begin
                  Log('Batch Update Error: ' + e.Message,ltError);
                  self.StatusMessage:= 'Error: ' + e.Message;
                  try
                    with UserLockObj.TUserLock.Create(nil) do begin
                      Connection := Conn;
                      UnlockAllCurrentUser;
                    end;
                  except

                  end;
                end;
              end;
            end
            else begin
              Log('Could not run Batch Update on Database ' +  sl[x] + ' as there are users in the system.', ltWarning);
            end;
          end
          else begin
            Log('Could not run Batch Update on Database ' +  sl[x] + ' as Batch Update is already in progress.', ltWarning);
          end;

        finally
          fAppEnvVirt.Free;
          fAppEnvVirt:= nil;
        end;

      except
        on e: exception do begin
          Log('Batch Update Error: ' + e.Message,ltError);
          self.StatusMessage:= 'Error: ' + e.Message;
          exit;
        end;
      end;


    end;

    Log('Batch Update, Optimise, Backup Finished.', ltInfo);
    self.StatusMessage := 'Batch Update, Optimise, Backup Finished.';

  finally
    Conn.Free;
    sl.Free;
    DbBackup.Free;
    ExportToreportDB.Free;
    //Freeandnil(ExportExternal);
    qry.Free;
  end;
end;

end.
