unit LogThreadDbLib;

interface

uses
  LogMessageTypes, SyncObjs, MultiEventObj, Classes, LogThreadBase,
  DbGen, JsonObject;


type

  TLoggerDbThread = class;

  TDbLogger = class(TLoggerBase)
  private
    fDatabaseServer: string;
    fFirstLog: boolean;
    procedure SetDatabaseServer(const Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property DatabaseServer: string read fDatabaseServer write SetDatabaseServer;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank); override;
    procedure LogStr(const msg: string; const aType: string = ''); //override;
    class function Inst: TDbLogger;
    class procedure CheckDbExists(const aServer: string);
  end;

  TLoggerDbThread = class(TLoggerThreadBase)
  private
    Connection: TDbConnection;
    Cmd: TDbQuery;
    MsgObj: TJsonObject;
    FLastLogTime: TDateTime;
  protected
    procedure Process; override;
  public
    constructor Create(Logger: TLoggerBase);
    destructor Destroy; override;
  end;

const
  LOGGING_DATABASE = 'services';

  tblLog_SQL =
    'CREATE TABLE tbllog ( ' +
    'LogID BIGINT UNSIGNED NOT NULL AUTO_INCREMENT, ' +
	  'Module VARCHAR(50) NULL DEFAULT NULL, ' +
	  'LogTime DATETIME NULL DEFAULT NULL, ' +
	  'LogType VARCHAR(20) NULL DEFAULT NULL, ' +
	  'Log TEXT NULL, ' +
//	  'INDEX LogIdIdx (LogID), ' +
    'PRIMARY KEY (LogID), ' +
	  'INDEX LogModuleIdx (Module), ' +
	  'INDEX LogTypeIdx (LogType), ' +
	  'INDEX LogTimeIdx (LogTime) ' +
	  ') ' +
	  'ENGINE=MyISAM;';

  WaitForReconnectInterval = (1/24/60) * 2; {2 minutes}


implementation

uses
  DbConst, sysutils, forms;

var
  DbLogger: TDbLogger;

{ TDbLogger }

class procedure TDbLogger.CheckDbExists(const aServer: string);
var
  sl: TStringList;
  Conn: TDbConnection;
begin
  Conn:= TDbConnection.Create(nil);
  try
    Conn.Server := aServer;
    Conn.Database := MYSQL_DATABASE;
    try
      Conn.Connect;
      sl:= TStringList.Create;
      try
        Conn.GetDatabaseNames(sl);
        if sl.IndexOf(LOGGING_DATABASE) < 0 then begin
          Conn.ExecSQL('create database ' + LOGGING_DATABASE,[]);
          Conn.Disconnect;
          Conn.Database:= LOGGING_DATABASE;
          Conn.Connect;
          Conn.ExecSQL(tblLog_SQL,[]);
        end
        else begin
          Conn.Disconnect;
          Conn.Database:= LOGGING_DATABASE;
          Conn.Connect;
        end;
        Conn.GetTableNames(sl);
        if sl.IndexOf('tbllog') < 0 then begin
          Conn.ExecSQL(tblLog_SQL,[]);
        end;


      finally
        sl.Free;
      end;
    except

    end;
  finally
    Conn.Free;
  end;

end;

constructor TDbLogger.Create(AOwner: TComponent);
begin
  inherited;
  fFirstLog:= true;
  fDatabaseServer:= 'localhost';

  {kick off the thread}
  fLoggerThread:= TLoggerDbThread.Create(self);
end;

destructor TDbLogger.Destroy;
begin

  inherited;
end;

class function TDbLogger.Inst: TDbLogger;
begin
  if not Assigned(DbLogger) then begin
    { NOTE: Logger must be created with application as owner so DLL's that
            use the logger can get a reference to the global instance }
    DbLogger:= TDbLogger.Create(Application);
  end;
  result:= DbLogger;
end;

procedure TDbLogger.LogStr(const msg, aType: string);
begin
  fLock.Acquire;
  try
    if Active then begin
       if fFirstLog then begin
         fFirstLog:= false;
         CheckDbExists(fDatabaseServer);
       end;

      Buffer.Add(
        '{"Module":"' + LogName + '",' +
        '"LogType":"' + aType + '",'+
        '"LogTime":"' + FormatDateTime('yyyy-mm-dd hh:nn:ss',now) + '",' +
        '"Log":"' + JSONObject.EncodeString(msg) + '"}'
      );
    end;
  finally
    fLock.Release;
  end;
end;

procedure TDbLogger.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  inherited;
  fLock.Acquire;
  try
    if Active and (LogMessageType in LogMessageTypes) then begin
       if fFirstLog then begin
         fFirstLog:= false;
         CheckDbExists(fDatabaseServer);
       end;

      Buffer.Add(
        '{"Module":"' + LogName + '",' +
        '"LogType":"' + LogMessageTypeToStr(LogMessageType) + '",'+
        '"LogTime":"' + FormatDateTime('yyyy-mm-dd hh:nn:ss',now) + '",' +
        '"Log":"' + JSONObject.EncodeString(msg) + '"}'
      );
    end;
  finally
    fLock.Release;
  end;
end;

procedure TDbLogger.SetDatabaseServer(const Value: string);
begin
  if fDatabaseServer <> Value then begin
    fDatabaseServer := Value;
    CheckDbExists(fDatabaseServer);
  end;
end;

{ TLoggerDbThread }

constructor TLoggerDbThread.Create(Logger: TLoggerBase);
begin
  inherited Create(Logger);
  FLastLogTime:= 0;
  MsgObj:= JO;
  Connection:= TDbConnection.Create(nil);
  Cmd:= TDbQuery.Create(nil);
  Cmd.SQL.Add('insert into tbllog (Module,LogType,LogTime,Log)');
  Cmd.SQL.Add('values (:aModule,:aLogType,:aLogTime,:aLog)');
  Cmd.DbConnection:= Connection;
  Connection.Database := LOGGING_DATABASE;
  Connection.Server := TDbLogger(Logger).DatabaseServer;
end;

destructor TLoggerDbThread.Destroy;
begin
  Cmd.Free;
  try
    Connection.Free;
  except
  end;
  MsgObj.Free;
  inherited;
end;

procedure TLoggerDbThread.Process;
var
  msg: string;
//  sl: TStringList;
  sql: string;
begin
  if Terminated then
    exit;
  MsgObj.AsString:= fLogger.Buffer.Remove;
  if not fLogger.Active then begin
    exit;
  end;
  if TDbLogger(fLogger).DatabaseServer <> Connection.Server then begin
    try
      Connection.Disconnect;
      Connection.Server:= TDbLogger(fLogger).DatabaseServer;
      Connection.Connect;
    except

    end;
  end;
  if not Connection.Connected then begin
    if now > (FLastLogTime + WaitForReconnectInterval) then begin
      try
        Connection.Connect;
      except

      end;
      FLastLogTime:= now;
    end;
  end;
  if Connection.Connected then begin
    try
      FLastLogTime:= now;
      (*
      Cmd.ParamByName('aModule').AsString:= MsgObj.S['Module'];
      Cmd.ParamByName('aLogType').AsString:= MsgObj.S['LogType'];
      Cmd.ParamByName('aLogTime').AsDateTime:= MsgObj.DT['LogTime'];
      Cmd.ParamByName('aLog').AsString:= MsgObj.S['Log'];
      Cmd.Prepare;
      Cmd.Execute;
      *)
      sql :=
        'insert into tbllog (Module,LogTime,LogType,Log) Values ('+
//        '(select MAX(L.LogID) from tbllog as L) + 1,' +
        QuotedStr(MsgObj.S['Module']) + ',' +
        QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss',MsgObj.DT['LogTime'])) + ',' +
        QuotedStr(MsgObj.S['LogType']) + ',' +
        QuotedStr(MsgObj.S['Log']) + ')';

      Connection.ExecSQL(sql, []);

    except
      on e: exception do begin
//        sl := TStringList.Create;
//        try
//          if fileexists('c:\temp\errlog.txt') then sl.LoadFromFile('c:\temp\errlog.txt');
//          sl.Add('Error: ' + e.message);
//          try
//            sl.Add(MsgObj.AsString);
//          except
//            sl.Add('Exception reading MsgObj');
//          end;
//
//        finally
//          sl.SaveToFile('c:\temp\errlog.txt');
//          sl.Free;
//        end;
      end;
    end;
  end;


  if fLogger.LogToEvent then begin
    msg:= MsgObj.S['LogType'] + ' > ' + MsgObj.S['Log'];
    if fLogger.LogTime then
      msg:= FormatDateTime(fLogger.LogTimeFormat,MsgObj.DT['LogTime']) + '  '  + Msg;
    try
      fLogger.Events.FireEvent(fLogger,'Log',msg);
    except
    end;
  end;
end;

end.
