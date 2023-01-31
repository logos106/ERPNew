unit BatchUpdateThreadTaskObj;

interface

uses
  ThreadTaskObj;

type
  TBatchUpdateThreadTask = class(TThreadTaskBase)
  private
    procedure DoOnScriptBeforeExecute(Sender: TObject; var SQL: string; var Omit: boolean);
  protected
    procedure DoWork; override;
  end;


implementation

uses
  Classes, ERPDbComponents, DbConst, MySQLUtils,
  sysutils, AppEnvironmentVirtual, DBUtils, TransactionsTable,
  ModuleUserUtilsObj, LogMessageTypes, MyScript;

{ TBackupThreadTask }

procedure TBatchUpdateThreadTask.DoOnScriptBeforeExecute(Sender: TObject;
  var SQL: string; var Omit: boolean);
begin
  if TaskStatus <> tsRunning then begin
    Omit := true;
    TMyScript(Sender).BreakExec;
  end;
end;

procedure TBatchUpdateThreadTask.DoWork;
var
  Conn: TERPConnection;
  UtilsModule: TModuleUserUtils;
  sl: TStringList;
  x: integer;
  UserCount: integer;
  TransactionTableObj: TTransactionTableObj;
begin
  inherited;
  self.fWasError := false;
  UtilsModule:= TModuleUserUtils(fServerModule);

  Conn:= TERPConnection(GetNewDbConnection());
  sl:= TStringList.Create;
  try

    Conn.Server := 'localhost';
    Conn.Database:= MYSQL_DATABASE;
  //  Conn.Connect;

    sl.CommaText := MySQLUtils.DatabaseList(Conn,true);
    Log('Starting Batch Update on all databases.', ltInfo);
    for x := 0 to sl.Count -1 do begin
      if SameText(sl[x],'erpnewdb') then continue;
      Log('Starting Batch Update on Database ' +  sl[x] + '.', ltInfo);
      if TaskStatus <> tsRunning then begin
        Log('Stopping Batch Update, task is terminating.', ltInfo);
        exit;
      end;
      Conn.Disconnect;
      Conn.Database := sl[x];
      Conn.Connect;
      try
        { shared connection used by app env }
        TAppEnvVirtualGUI(AppEnvVirt).SharedDbConnection := Conn;
        try

          UtilsModule.Lock;
          try
            UserCount:= UtilsModule.AppUserList.DatabaseUserCount(sl[x]);
          finally
            UtilsModule.Unlock;
          end;

          if (not AppEnvVirt.Bool['CompanyPrefs.BatchUpdateInProgress']) or (UserCount < 1) then begin

            AppEnvVirt.Bool['CompanyPrefs.BatchUpdateInProgress'] := false;
            TransactionTableObj := TTransactionTableObj.Create(False);
            try
              TransactionTableObj.BeforeScriptExecute := DoOnScriptBeforeExecute;
              if (UserCount < 1) then
                TransactionTableObj.SetEmptyGlobalRef;
                if TaskStatus <> tsRunning then begin
                  Log('Stopping Batch Update, task is terminating.', ltInfo);
                  exit;
                end;
                TransactionTableObj.CleanRefreshTrnsTable(true, false, true, true);
            finally
              FreeandNil(TransactionTableObj);
            end;

            //  Debuglib.RecalculateproductAvgcost;
             Log('... Finished Batch Update on Database ' +  sl[x] + '.', ltInfo);

          end
          else begin
            Log('Could not run Batch Update on Database ' +  sl[x] + ' as Batch Upadte is already in progress.', ltWarning);
          end;

        finally
          fAppEnvVirt.Free;
          fAppEnvVirt:= nil;
        end;

      except
        on e: exception do begin
          Log('Error: ' + e.Message,ltError);
          self.fStatusMessage:= 'Error: ' + e.Message;
          self.fWasError := true;
          exit;
        end;
      end;


    end;
    Log('Batch Update Finished.', ltInfo);
    self.fStatusMessage := 'Batch Update Finished.';
  finally
    Conn.Free;
    sl.Free;
    self.fFinishTime := now;
  end;
end;

end.
