unit ErpDbMaintObj;

interface

uses
  LogThreadBase, LogMessageTypes, JsonObject, ModuleConst, Classes;

type

  TErpMaint = class(TObject)
  private
    FLogger: TLoggerBase;
    fOnLog: LogThreadBase.TOnLogEvent;
    fMySQLServer: string;
    fCurrentDatabase: string;
    fOnDatabase: TNotifyEvent;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
  public
    DatabaseList: TJsonObject;
    constructor Create(aMySQLServer: string = '127.0.0.1');
    destructor Destroy; override;
    property Logger: TLoggerBase read FLogger write FLogger;
    procedure DoMaint;
    property CurrentDatabase: string read fCurrentDatabase write fCurrentDatabase;
    property OnDatabase: TNotifyEvent read fOnDatabase write fOnDatabase;
    property OnLog: LogThreadBase.TOnLogEvent read fOnLog write fOnLog;
  end;

const
  ERP_ADMIN_USER_DB_MAINT = ERP_ADMIN_USER +  '_DB_Maint';

implementation

uses
  DbConst, DbUtils, DataFixLib,
  sysutils, SharedAppUserListObj;


{ TErpMaint }

constructor TErpMaint.Create(aMySQLServer: string);
begin
  fMySQLServer := aMySQLServer;
  DatabaseList:= TJsonObject.Create;
end;

destructor TErpMaint.Destroy;
begin
  DatabaseList.Free;
  inherited;
end;

procedure TErpMaint.DoMaint;
var
  DbList: TStringList;
  DbIdx: integer;
//  CurrentDatabase: string;
  ErrMsg, InfoMsg: string;
  json: TJsonObject;
  UserAdded: boolean;

  function LockDb(aDatabase: string): boolean;
  var
    s: string;
    LockedUser, LockedReason: string;
  begin
    result:= true;
    UserAdded := false;
    if TSharedAppUserList.ExLocked(aDatabase,fMySQLServer,LockedReason,LockedUser) then begin
      result := false;
      Log('Could not check ' + aDatabase + ', could not lock database login: ' + LockedReason,ltWarning);
      exit;
    end;
    if not TSharedAppUserList.ExAddUser(s,ERP_ADMIN_USER_DB_MAINT,aDatabase,fMySQLServer,'','','',false) then begin
      result:= false;
      Log('Could not check ' + aDatabase + ': ' + s,ltWarning);
      exit;
    end;
    UserAdded := true;
    if not TSharedAppUserList.ExLockLogon(s, ERP_ADMIN_USER_DB_MAINT, aDatabase, 'Performing Database Maintenance',fMySQLServer) then begin
      result:= false;
      TSharedAppUserList.ExRemoveUser(ERP_ADMIN_USER_DB_MAINT,fMySQLServer,aDatabase);
      Log('Could not check ' + aDatabase + ', could not lock database login: ' + s,ltWarning);
    end
  end;

  procedure UnlockDb(aDatabase: string);
  begin
    { this also unlocks user logon }
    TSharedAppUserList.ExRemoveUser(ERP_ADMIN_USER_DB_MAINT,fMySQLServer,aDatabase);
  end;

begin
  Log('', ltInfo);
  Log('**** Db maintenance check started ****', ltInfo);
  try
    if DatabaseList.A['List'].Count = 0 then begin
      { if nothing specified, get list of all databases }
      dbList:= TStringList.Create;
      try
        dbList.CommaText:= DbUtils.GetDatabaseList(fMySQLServer,true);
        for dbIdx:= 0 to dbList.Count -1 do begin
          json:= Jo;
          json.S['DatabaseName']:= dbList[dbIdx];
          DatabaseList.A['List'].Add(json);
        end;
      finally
        dbList.Free;
      end;
    end;
      for dbIdx:= 0 to DatabaseList.A['List'].Count -1 do begin
        CurrentDatabase:= DatabaseList.A['List'].Items[dbIdx].AsObject.S['DatabaseName'];
        if Assigned(fOnDatabase) then fOnDatabase(Self);

        if LockDb(CurrentDatabase) then begin
          Log('', ltInfo);
          Log('Checking Database: ' + CurrentDatabase,ltInfo);
          try
            ErrMsg:= '';
            InfoMsg:= '';
            try
              if DataFixLib.DoDatafix(fMySQLServer,CurrentDatabase,ErrMsg,InfoMsg) then begin
                { worked ok }
                if InfoMsg <> '' then
                  Log(InfoMsg,ltInfo);
              end
              else begin
                Log(ErrMsg,ltError);
              end;
            except
              on e: exception do begin
                 Log(e.Message,ltError);
              end;
            end;
          finally
            if UserAdded then
              UnlockDb(CurrentDatabase);
            Log(CurrentDatabase + ' done.',ltInfo);
          end;
        end
        else begin
          Log('Unable to lock logon for database: ' + CurrentDatabase + ', Maintenance Check not Done',ltWarning);
        end;
      end;
  finally
    Log('**** Db maintenance check finished ****', ltInfo);
  end;
  CurrentDatabase := '';
  if Assigned(fOnDatabase) then fOnDatabase(Self);
end;

procedure TErpMaint.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(fLogger) then
    fLogger.Log(msg,LogMessageType);
  if Assigned(fOnLog) then
    fOnLog(msg,LogMessageType);
end;

end.
