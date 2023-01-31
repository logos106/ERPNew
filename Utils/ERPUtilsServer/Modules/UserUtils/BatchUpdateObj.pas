unit BatchUpdateObj;

interface

uses
  LogThreadBase, LogMessageTypes, MyAccess, ModuleBaseServerObj;

type
  TBatchUpdate = class
  private
//    fLogger: TLoggerBase;
    fDatabaseName: string;
    fServerName: string;
    Connection: TMyConnection;
    fModule: TModuleBaseServer;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
  public
    constructor Create;
    destructor Destroy; override;
    property ServerName: string read fServerName write fServerName;
    property DatabaseName: string read fDatabaseName write fDatabaseName;
    property Module: TModuleBaseServer read fModule write fModule;
    function UpdateBatch: boolean;
  end;

implementation

uses
  sysutils, AppEnvironmentVirtual, DBUtils, TransactionsTable, ModuleUserUtilsObj;

{ TBatchUpdate }

constructor TBatchUpdate.Create;
begin
  Connection:= GetNewDbConnection();

  { shared connection used by app env }
  AppEnvVirt.Obj['SharedDbConnection'] := Connection;



end;

destructor TBatchUpdate.Destroy;
begin
  Connection.Free;
  inherited;
end;

procedure TBatchUpdate.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(Module) then
    Module.Logger.Log(msg,LogMessageType);
end;

function TBatchUpdate.UpdateBatch: boolean;
var
  TransactionTableObj: TTransactionTableObj;
  UserCount: integer;
begin
  result := true;
  Log('Starting Batch Update on Database ' +  DatabaseName + '.', ltInfo);
  Connection.Server := fServerName;
  Connection.Database := fDatabaseName;
  Connection.Connect;

  if not AppEnvVirt.Bool['CompanyPrefs.BatchUpdateInProgress'] then begin

    TModuleUserUtils(Module).Lock;
    try
      UserCount:= TModuleUserUtils(Module).AppUserList.DatabaseUserCount(DatabaseName);
    finally
      TModuleUserUtils(Module).Unlock;
    end;

    TransactionTableObj := TTransactionTableObj.Create(False);
    try
      if (UserCount <= 1) then
        TransactionTableObj.SetEmptyGlobalRef;
        TransactionTableObj.CleanRefreshTrnsTable(true, false, true, true);
    finally
      FreeandNil(TransactionTableObj);
    end;

  //  Debuglib.RecalculateproductAvgcost;
  end
  else begin
    result := false;
    Log('Could not run Batch Update on Database ' +  DatabaseName + ' as Batch Upadte is already in progress.', ltWarning);


  end;

  Connection.Disconnect;
end;

end.
