unit AppDatabase;

interface
{$I ERP.inc}
uses
  Classes, MyAccess,ERPdbComponents, MyClasses, extctrls, LogThreadLib, LogMessageTypes;

Const
//  TABLE_VERSION = '2017.9.0.0'; Moved to ERPVersionConst
  SYSDB_PASS = '1w$p&LD07';
  SYSDB_USER = 'P_One';
  CONFIG_FILE = 'Connection.ini';
  MYSQL_DATABASE = 'mysql';
  MYSQL_PORT = 3309;

var
  MIN_TABLE_VERSION: string = '';


type

  TDatabaseRec = class(TObject)
  private
    fVersionOk: boolean;
    fVersion  : string;
    fName     : string;
    function GetVersionDesc: string;
  public
    constructor Create;
    property Name: string read fName write fName;
    property Version: string read fVersion write fVersion;
    property VersionDesc: string read GetVersionDesc;
    property VersionOk: boolean read fVersionOk write fVersionOk;
  end;

  TAppDatabase = class(TObject)
  private
    fLastDatabase: string;
    fDatabase: string;
    fServer: string;
    fLastConnectServer: string;
    fConnection: TERPConnection;
    fServerList: TStringList;
    fDatabaseList: TStringList;
    FUserName: string;
    FUserPass: string;
    FEmployeeID: Integer;
    DoingUserConnect: boolean;
    FDirty: boolean;
    fOnUserConnect: TNotifyEvent;
    fDatabaseOk: boolean;
    fVersionOk: boolean;
    fServerOk: boolean;
    fServerPort: integer;
    fbAcceptBlankPassword: boolean;
    fConfigFileAccessOk: boolean;
    fConfigFileAccessOkChecked: boolean;
    fKeepAwakeQuery: TERPQuery;
    fKeepAwakeTimer: TTimer;
    fTransConnection: TERPConnection;
    fAPIMode: boolean;
    fVersionOkReason: string;
    fAllowSave: boolean;
    fIgnoreDbVersion: boolean;
    fLogger: TLogger;
    procedure DoOnKeekAwakeTimer(sender: TObject);
    procedure SetDatabase(const Value: string);
    procedure SetServer(const Value: string);
    procedure Load;
    procedure ClearDatabaseList;
    function Connect(var msg: string; Const myCon: TERPConnection;
                     Const aServer: string {= ''};
                     Const aDatabase: string = ''): boolean;
    function IsAppServer(Const aServer: string): boolean;
    function IsAppDatabase(Const aDatabase: string; Const DataBaseRec: TDatabaseRec): boolean;
    procedure SetUserName(const Value: string);
    procedure SetUserPass(const Value: string);
    procedure DoBeforeUserConnect(Sender: TObject);
    procedure DoAfterUserConnect(Sender: TObject);
    procedure DoBeforeUserDisConnect(Sender: TObject);
    procedure SetDirty(const Value: boolean);
    function GetConfigFileAccessOk: boolean;
    function GetDatabaseRecord(aDatabaseName: string): TDatabaseRec;
    procedure Log(msg: string;const aLogMessageType: TLogMessageType = ltBlank);
    Procedure DevmodeServers;
    function GetTransConnection: TERPConnection;
    function getTableVersion: String;
    function getIsDBconnected: Boolean;
    function Logger: TLogger;
    procedure LogConnectionCount(const EventMsg:String);

  public
    constructor Create(aAPIMode: boolean); overload;
    constructor Create(Const aServer, aDatabase: string; aAPIMode: boolean); overload;
    destructor Destroy; override;
    procedure Save;
    property ConfigFileAccessOk: boolean read GetConfigFileAccessOk;
    property Connection: TERPConnection read fConnection;
    property TransConnection: TERPConnection read GetTransConnection;
    property Server: string read FServer write SetServer;
    property LastConnectServer: string read fLastConnectServer;
    property ServerPort: integer read fServerPort write fServerPort;
    property Database: string read fDatabase write SetDatabase;
    property LastDatabase: string read fLastDatabase write fLastDatabase;
    property ServerList: TStringList read fServerList;
    property DatabaseList: TStringList read fDatabaseList;
    property UserName: string read FUserName write SetUserName;
    property UserPass: string read FUserPass write SetUserPass;
    property EmployeeID: integer read FEmployeeID;
    procedure ConnectUser(Const User, Pass: string; aLogger:TLogger = nil);

    procedure GetUserList(Const List: TStrings);
    property Dirty: boolean read FDirty write SetDirty;
    property OnUserConnect: TNotifyEvent read fOnUserConnect write fOnUserConnect;
    property DatabaseOk: boolean read fDatabaseOk;
    property ServerOk: boolean read fServerOk;
    Property AcceptBlankPassword:boolean read fbAcceptBlankPassword Write fbAcceptBlankPassword default False;
    property VersionOk: boolean read fVersionOk;
    property VersionOkReason: string read fVersionOkReason;
    function DatabaseExists(const aDatabaseName: string): boolean;
    procedure PopulateDatabaseList;
    property DatabaseRecord[aDatabaseName: string]: TDatabaseRec read GetDatabaseRecord;
    Property TableVersion :String read  getTableVersion;
    function PasswordExpiryDays(var DaysTillExpiry: integer): boolean;
    Property IsDBConnected :Boolean read getIsDBconnected;
    property APIMode: boolean read fAPIMode write fAPIMode;
    property AllowSave: boolean read fAllowSave write fAllowSave;
    property IgnoreDbVersion: boolean read fIgnoreDbVersion write fIgnoreDbVersion;
  end;

implementation

uses
  IniFiles,
  SysUtils,
  Forms, //Application
  DB,
  CommonLib, VersionUtils,
  tcConst, DNMLib,SystemLib, SimpleEncrypt, MySQLUtils, DBUtils,
  ERPVersionConst,
  AppEnvironmentVirtual;

const
  KEY          = 'z';
  SECTION_LASTDB = 'Last_Database';
  SECTION_SERVERS = 'Servers';
  ITEM_DATABASE = 'Database';
  ITEM_SERVER = 'Server';
  ITEM_LAST_CONNECT_SERVER = 'LastConnectServer';
  ITEM_USERNAME = 'UserName';
  DEFAULT_DATABASE = 'sample_company';
  DEFAULT_NEWDATABASE = 'erpnewdb';
  DEFAULT_SERVER = 'Localhost';
  {FastFuncs Switch}
  SECTION_SPEED = 'Speed';
  ITEM_CPU = 'CPU';

{ TAppDatabase }

constructor TAppDatabase.Create(aAPIMode: boolean);
begin
  inherited Create;
  fAllowSave := true;
  fIgnoreDbVersion := false;
  fAPIMode := aAPIMOde;
  fLogger:= nil;
  fLastConnectServer:= fLastConnectServer;
  fConfigFileAccessOk:= false;
  fConfigFileAccessOkChecked:= false;
  DoingUserConnect:= false;
  fServerList:= TStringList.Create;
  fDatabaseList:= TStringList.Create;
  fConnection:= TERPConnection.Create(nil);
  fConnection.BeforeConnect:= DoBeforeUserConnect;
  fConnection.AfterConnect:= DoAfterUserConnect;
  fConnection.BeforeDisConnect:= DoBeforeUserDisConnect;
  fKeepAwakeQuery:= TERPQuery.Create(nil);
  fKeepAwakeQuery.Connection:= fConnection;
  fKeepAwakeQuery.SQL.Text:= 'SELECT NOW() FROM DUAL';
  fKeepAwakeTimer:= TTimer.Create(nil);
  fKeepAwakeTimer.OnTimer:= self.DoOnKeekAwakeTimer;
  fKeepAwakeTimer.Interval:= 5 * 60000; // one minute
  fKeepAwakeTimer.Enabled:= true;
  fDatabaseOk:= false;
  fVersionOk:= false;
  fVersionOkReason := '';
  fServerOk:= false;
  fServerPort:= MYSQL_PORT;
  FEmployeeID := 0;
  TAppEnvVirtualGUI(AppEnvVirt).SharedDbConnection := fConnection;
  if not APIMode then
    Load;
end;

constructor TAppDatabase.Create(Const aServer, aDatabase: string; aAPIMode: boolean);
begin
//  inherited
  Create(aAPIMode);
//  DoingUserConnect:= false;
//  fServerList:= TStringList.Create;
//  fDatabaseList:= TStringList.Create;
//  fConnection:= TERPConnection.Create(nil);
//  fConnection.BeforeConnect:= DoBeforeUserConnect;
//  fKeepAwakeQuery:= TERPQuery.Create(nil);
//  fKeepAwakeQuery.Connection:= fConnection;
//  fKeepAwakeQuery.SQL.Text:= 'SELECT NOW() FROM DUAL';
//  fKeepAwakeTimer:= TTimer.Create(nil);
//  fKeepAwakeTimer.OnTimer:= self.DoOnKeekAwakeTimer;
//  fKeepAwakeTimer.Interval:= 5 * 60000; // 5 minutes
//  fKeepAwakeTimer.Enabled:= true;

  if aServer <> '' then
    fServer:= aServer;
  if aDatabase <> '' then
    fDatabase:= aDatabase;
//  FEmployeeID := 0;
end;

destructor TAppDatabase.Destroy;
begin
//  Save;
  FreeAndNil(fKeepAwakeTimer);
  FreeAndNil(fKeepAwakeQuery);
  FreeandNil(fConnection);
  ClearDatabaseList;
  FreeandNil(fDatabaseList);
  FreeandNil(fServerList);
  FreeAndNil(fTransConnection);
  fLogger.Free;
  inherited;
end;

procedure TAppDatabase.ConnectUser(Const User, Pass: string; aLogger: TLogger = nil);
begin
  if aLogger <> nil then fLogger := aLogger;
  fConnection.Disconnect;
  fUserName := User;
  fUserPass := Pass;
  fConnection.Connect;
  if fConnection.Connected then begin
    if (fLastDatabase <> fDatabase) or (fLastConnectServer <> fServer) then begin
      fLastDatabase := fDatabase;
      fLastConnectServer := fServer;
      Save;
    end;
    if Assigned(fOnUserConnect) then
      fOnUserConnect(Self);
  end;
end;

procedure TAppDatabase.SetDatabase(const Value: string);
var
  DbRec: TDatabaseRec;
  sl: TStringLIst;
begin
//  Log('TAppDatabase.SetDatabase - Value: "' + Value + '"  Server: "'+ fDatabase +'" ServerOk: ' + BoolToStr(fServerOk,true));
  fDatabaseOk := false;
  fVersionOk := false;
  fVersionOkReason := '';
  if self.fServerOk then begin
    sl := TStringList.Create;
    try
      sl.CaseSensitive := false;
      sl.CommaText := MySQLUtils.DatabaseList(self.Server,true);
      if sl.IndexOf(Value) < 0 then begin
        fDatabaseOk:= false;
        fVersionOk:= false;
        fVersionOkReason := 'Database not found - ' + Value +'.';
        fDatabase:= '';
        exit;
      end;
    finally
      sl.Free;
    end;
    fDatabaseOk:= true;
    fVersionOk:= true;
    fDatabase:= Value;
    fDirty:= true;
    if (fDatabase <> '') and (fServer <> '') then begin
      DbRec:= TDatabaseRec.Create;
      try
        if (not IsAppDatabase(fDatabase, DbRec)) then begin
          fDatabase:= '';
          FDatabaseOk:= false;
          fVersionOkReason := Value +' is not an ERP database.';
        end
        else if (not DbRec.VersionOk) then begin
          fDatabase:= '';
          FVersionOk:= false;
        end;
      finally
        FreeandNil(DbRec);
      end;
    end;
  end;
end;

procedure TAppDatabase.SetServer(const Value: string);
var
  DbRec: TDatabaseRec;
begin

  if (fServer <> Value) or (not fServerOk) then begin
    fServer:= Value;
    fDatabaseOk:= true;
    fVersionOk:= true;
    fVersionOkReason := '';
//    fServerOk:= true;
    fDirty:= true;
    if fServer <> '' then begin
      fServerOk:= true;
      { we check that this is a valid server name by trying to connect to the mysql database }
      if IsAppServer(fServer) then begin
        { server ok, now make sure the currently selected database exists and is current version }
        fLastConnectServer:= fServer;
        if fDatabase <> '' then begin
          DbRec:= TDatabaseRec.Create;
          try
            if (not IsAppDatabase(fDatabase, DbRec)) then begin
              fDatabase:= '';
              FDatabaseOk:= false;
              fVersionOkReason := 'Not an ERP database.';
            end
            else if (not DbRec.VersionOk) then begin
              fDatabase:= '';
              FVersionOk:= false;
              fVersionOkReason := '';
            end;
          finally
            FreeandNil(DbRec);
          end;
        end;
        PopulateDatabaseList;
      end
      else begin
//        fServer:= '';
        fServerOk:= false;
      end;
    end;
  end;
end;

function TAppDatabase.PasswordExpiryDays(var DaysTillExpiry: integer): boolean;
var
  conn: TERPConnection;
  qry: TERPQuery;
  ExpDays: integer;
begin
  result := false;
  if (fServer = '') or (fDatabase = '') or (FUserName = '') then  exit;

  conn := DBUtils.GetNewDbConnection(fServer,fDatabase);
  qry := TERPQuery.Create(nil);
  try
    try
      conn.Connect;
    except
      exit;
    end;
    qry.Connection := Conn;
    qry.SQL.Add('select * from tbldbPreferences where PrefType = "ptCompany"');
    qry.SQL.Add('and Name = "LoginExpireDays"');
    qry.Open;
    ExpDays := StrToIntDef(qry.FieldByName('FieldValue').AsString,0);
    if ExpDays = 0 then exit;

    result := true;

    qry.Close;

    qry.SQL.Text := 'select * from tblpassword where Logon_Name = ' + QuotedStr(FUserName);
    qry.Open;
    if qry.FieldByName('PasswordDate').AsDateTime = 0 then begin
      qry.Edit;
      qry.FieldByName('PasswordDate').AsDateTime := Trunc(now);
      qry.Post;
    end;

    DaysTillExpiry := (Trunc(qry.FieldByName('PasswordDate').AsDateTime) + ExpDays) - Trunc(Date);

  finally
    qry.Free;
    conn.Free;
  end;
end;

procedure TAppDatabase.PopulateDatabaseList;
var
//  qryDB: TERPQuery;
  DbRec: TDatabaseRec;
  DbConn: TERPConnection;
  dbList: TStringList;
  x: integer;
  qry: TERPQuery;
begin
  ClearDatabaseList;

  DbConn:= TERPConnection.Create(nil);
  qry := TERPQuery.Create(nil);
  dbList := TStringList.Create;
  try
    MySQLUtils.SetConnectionProps(DbConn, MYSQL_DATABASE, fServer);
    try
      DbConn.Connect;
    except
      exit;
    end;
    qry.Connection := DbConn;
    dbList.CommaText := MySQLUtils.DatabaseList(DbConn,true);
    for x := 0 to dbList.Count -1 do begin
      if not SameText(dbList[x], DEFAULT_NEWDATABASE) then begin
        DbRec := TDatabaseRec.Create;
        DbRec.Name:= dbList[x]; //  qryDB.FieldByName('Database').AsString;
        qry.SQL.Text := 'select Version from ' + DbRec.Name + '.tblUpdateDetails';
        qry.Open;
        DbRec.Version := qry.FieldByName('Version').AsString;
        qry.Close;
        DbRec.VersionOk := IgnoreDbVersion or (DbRec.Version = TABLE_VERSION);
        fDatabaseList.AddObject(DbRec.Name, DbRec);
      end;
    end;
  finally
    qry.Free;
    dbList.Free;
    DbConn.Free;
  end;



//  qryDB:= TERPQuery.Create(nil);
//  qryDB.SQL.Text := 'Show Databases';
//  DbConn:= TERPConnection.Create(nil);
//  try
//    if Connect(msg, DbConn, Server) then begin
//      qryDB.Connection:= DbConn;
//      qryDB.Open;
//      while not qryDB.Eof do begin
//        DbRec := TDatabaseRec.Create;
//        DbRec.Name:= qryDB.FieldByName('Database').AsString;
//        if (DbRec.Name <> DEFAULT_NEWDATABASE) and IsAppDatabase(DbRec.Name,DbRec) then begin
//          fDatabaseList.AddObject(DbRec.Name, DbRec);
//        end else begin
//          FreeandNil(DbRec);
//        end;
//        qryDB.Next;
//      end;
//      qryDb.Close;
//      DbConn.Disconnect;
//    end;
//  finally
//    FreeandNil(qryDB);
//    FreeandNil(DbConn);
//  end;
end;

function TAppDatabase.Connect(var msg: string; Const myCon: TERPConnection;
                              Const aServer: string {= ''};
                              Const aDatabase: string = ''): boolean;
begin
  myCon.Connected:= false;
  try
//    if aServer <> '' then
//      myCon.Server:= aServer
//    else
//      myCon.Server:= fServer;
    if aDatabase <> '' then
      myCon.Database:= aDatabase
    else
      myCon.Database:= fDatabase;
    myCon.Username:= SYSDB_USER;
    myCon.Password:= SYSDB_PASS;
    myCon.Options.Compress := MYDAC_OPTIONS_COMPRESS;
    myCon.Options.Protocol := MYDAC_OPTIONS_PROTOCOL;
    myCon.Port := fServerPort;
    myCon.LoginPrompt:= false;
    MySQLUtils.SetConnectionServer(myCon, aServer);
    myCon.Connected:= true;
  except
    on E: Exception do
      msg:= Trim(E.Message);
  end;
  result:= myCon.Connected;
end;

procedure TAppDatabase.Load;
var
  ini: TMemIniFile;
  s: string;
  x: integer;
begin
  if ConfigFileAccessOk then begin
    ini := TMemIniFile.Create(SystemLib.ExeDir + CONFIG_FILE);
    try
      { NOTE: get server first to ensure correct chain of events }
      Server := ini.ReadString(SECTION_LASTDB, ITEM_SERVER, DEFAULT_SERVER);
      fLastConnectServer := ini.ReadString(SECTION_LASTDB, ITEM_LAST_CONNECT_SERVER, '');
      LastDatabase := ini.ReadString(SECTION_LASTDB, ITEM_DATABASE, DEFAULT_DATABASE);
      Database := ini.ReadString(SECTION_LASTDB, ITEM_DATABASE, DEFAULT_DATABASE);
      UserName := ini.ReadString(SECTION_LASTDB, ITEM_USERNAME, '');
      fServerList.Clear;
      x := 0;
      repeat
        s:= ini.ReadString(SECTION_SERVERS, ITEM_SERVER + IntToStr(x), '');
        if s <> '' then
          fServerList.Add(s);
        Inc(x);
      until s = '';
        if (fServer <> '') and (fServerList.IndexOf(fServer) < 0) then
          fServerList.Insert(0,fServer);
      fDirty:= false;
    finally
      FreeandNil(ini);
    end;
  end
  else begin
//    Server:= DEFAULT_SERVER;
//    LastDatabase:= DEFAULT_DATABASE;
//    Database:= DEFAULT_DATABASE;
//    UserName:= '';
//    fServerList.Clear;
  end;
  if devmode then
    DevmodeServers;
end;

procedure TAppDatabase.Log(msg: string;const aLogMessageType: TLogMessageType = ltBlank);
begin
  //if Assigned(Logger) then
  try
    Logger.Log(msg , aLogMessageType);
  Except
  end;
end;

function TAppDatabase.Logger: TLogger;
begin
  if fLogger = nil then
    fLogger := TLogger.Create(nil);
  result := fLogger;
end;

Procedure TAppDatabase.DevmodeServers;
var
  x,y:Integer;
  flag:Boolean;
  st:tStringList;
begin
  if not devmode then exit;
  st:=TStringList.create;
  try
    st.add('DEV1');
    st.add('Denedesk-pc');
    st.add('Demo-pc');
    for y := 0 to st.count-1 do begin
      Flag := False;
      for x:= 0 to fServerList.count-1 do begin
          if SameText(fServerList[x] , st[y]) then begin
            Flag:= true;
            break;
          end;
      end;
      if not flag then fServerList.add(st[y]);
    end;
  finally
    Freeandnil(st);
  end;
end;

procedure TAppDatabase.Save;
var
  ini: TMemIniFile;
  x: integer;
begin
  if (not AllowSave) or (not ConfigFileAccessOk) then
    exit;

  ini:= TMemIniFile.Create(SystemLib.ExeDir + CONFIG_FILE);
  try
    if Pos('(', fDatabase) = 1 then
      ini.WriteString(SECTION_LASTDB, ITEM_DATABASE, '')
    else
      ini.WriteString(SECTION_LASTDB, ITEM_DATABASE, fDatabase);
    ini.WriteString(SECTION_LASTDB, ITEM_SERVER, fServer);
    ini.WriteString(SECTION_LASTDB, ITEM_USERNAME, fUserName);
    ini.WriteString(SECTION_LASTDB, ITEM_LAST_CONNECT_SERVER, fLastConnectServer);

    //ini.EraseSection(SECTION_SERVERS);
    x:= 0;
    while true do begin
      if ini.ValueExists(SECTION_SERVERS, ITEM_SERVER + IntToStr(x)) then begin
        ini.DeleteKey(SECTION_SERVERS, ITEM_SERVER + IntToStr(x));
        inc(x);
      end
      else
        break;
    end;
    for x:= 0 to fServerlist.Count -1 do begin
      ini.WriteString(SECTION_SERVERS, ITEM_SERVER + IntToStr(x), fServerList[x]);
    end;

    ini.UpdateFile;
    fDirty:= false;
  finally
    FreeandNil(ini);
  end;
end;

procedure TAppDatabase.ClearDatabaseList;
var
  x: integer;
begin
  for x:= 0 to fDatabaseList.Count -1 do begin
    if Assigned(fDatabaseList.Objects[x]) then
      fDatabaseList.Objects[x].Free;
  end;
  fDatabaseList.Clear;
end;

function TAppDatabase.IsAppServer(Const aServer: string): boolean;
var
  DbConn: TERPConnection;
  msg: string;
begin
  result:= false;
  DbConn:= TERPConnection.Create(nil);
  try
    if Connect(msg, DbConn, aServer, MYSQL_DATABASE) then begin
      result:= true;
      DbConn.Disconnect;
    end;
  finally
    FreeandNil(DbConn);
  end;
end;

function TAppDatabase.IsAppDatabase(Const aDatabase: string; Const DatabaseRec: TDatabaseRec): boolean;
var
  DbConn: TERPConnection;
  qryTables: TERPQuery;
  qryUpdateDetails: TERPQuery;
  msg: string;
begin
  result:= false;
  if (fServer <> '') then begin
    DbConn:= TERPConnection.Create(nil);
    try
      if Connect(msg, DbConn, fServer, aDatabase) then begin
        qryTables:= TERPQuery.Create(nil);
        qryTables.Connection:= DbConn;
        qryUpdateDetails:= TERPQuery.Create(nil);
        qryUpdateDetails.Connection:= DbConn;
        qryUpdateDetails.SQL.Text:= 'SELECT * FROM tblUpdateDetails';
        try
          qryTables.SQL.Text := 'Show Tables From ' + aDatabase;
          qryTables.Open;

          if {(uppercase(aDatabase) <> uppercase(DEFAULT_NEWDATABASE)) and}
            (qryTables.RecordCount > 170) and
            (qryTables.Locate(qryTables.Fields[0].FieldName, 'TBLUPDATEDETAILS', [loCaseInsensitive])) then begin


            qryTables.Close;
            { if this database is being restored any query on the db will hang
              untill restore complete because of write lock .. so check for locks here }
            qryTables.SQL.Text := 'SHOW OPEN TABLES WHERE `Table` LIKE "TBLUPDATEDETAILS" AND `Database` LIKE "'+aDatabase+'" AND In_use > 0';
            qryTables.Open;
            if not qryTables.IsEmpty then begin
              result:= true;
              DatabaseRec.Version:= 'Locked';
              DatabaseRec.VersionOk:= true;
              exit;
            end;

            result:= true;

            if Assigned(DatabaseRec) then begin
              qryUpdateDetails.Open;
              if qryUpdateDetails.FindField('Current') <> nil then begin
                if qryUpdateDetails.Locate('Current', 'T', [loCaseInsensitive]) then begin
                  DatabaseRec.Version:= qryUpdateDetails.FieldByName('Version').AsString;
                  if IgnoreDbVersion then
                    DatabaseRec.VersionOk := true
                  else begin
                    if MIN_TABLE_VERSION <> '' then
                      DatabaseRec.VersionOk := VersionComp(DatabaseRec.Version, MIN_TABLE_VERSION) >= 0
                    else
                      DatabaseRec.VersionOk:= (qryUpdateDetails.FieldByName('Version').AsString = TABLE_VERSION)
                  end;
                end;
              end;
              qryUpdateDetails.Close;
            end;
          end;
          qryTables.Close;
        finally
          FreeandNil(qryTables);
          FreeandNil(qryUpdateDetails);
        end;
        DbConn.Disconnect;
      end
      else
        raise Exception.Create('Cant connect to database: '+ msg);
    finally
      FreeandNil(DbConn);
    end;
  end;
  if result then
  else
end;

procedure TAppDatabase.SetUserName(const Value: string);
begin
  if fUserName <> Value then begin
    FUserName := Value;
    fDirty:= true;
  end;
end;

procedure TAppDatabase.SetUserPass(const Value: string);
begin
  FUserPass := Value;
end;

procedure TAppDatabase.DoBeforeUserDisConnect(Sender: TObject);
begin
  try
    Log('fServer :' + fServer);
    Log('fDatabase :' + fDatabase);
    Log('FUserName :' + FUserName);
    Log('FUserPass :' + FUserPass);
    Log('Disconnecting');
    LogConnectionCount('Before Disconnect');
  Except
    on E:EXception do begin
      // kill the exceptionf
    end;
  end;
end;
procedure TAppDatabase.DoAfterUserConnect(Sender: TObject);
begin
  LogConnectionCount('After Connect');
end;
procedure TAppDatabase.LogConnectionCount(const EventMsg:String);
var
  Qry: TERPQuery;
begin
  if fConnection = nil then exit;
  if fConnection.connected = false then exit;
  try
        Qry:= TERPQuery.Create(nil);
        try
          Log('===========Connection Count=================',ltDetail);
          Log(EventMsg,ltDetail);
          Qry.Connection:= fConnection;
          Qry.SQL.text:= ' show status where `variable_name` = "Threads_connected"';
          Qry.open;
          Log('Connection Count :' + inttostr(Qry.Fieldbyname('Value').AsInteger),ltDetail);
          Qry.close;
          Qry.SQL.text:= ' SHOW VARIABLES LIKE "max_connections"';
          Qry.open;
          Log('max_connections :' + inttostr(Qry.Fieldbyname('Value').AsInteger),ltDetail);
          Log('===========Connection Count=================',ltDetail);
        finally
          FreeandNil(Qry);
        end;
  Except
    on E:Exception do begin 
      Logger.Log('LogConnectionCount Error :' + E.Message,ltDetail);
    end;
  end;

end;

procedure TAppDatabase.DoBeforeUserConnect(Sender: TObject);
var
  msg: string;
  qryLogon: TERPQuery;
  passFound: boolean;
begin
  if DoingUserConnect then
    Exit;
  DoingUserConnect:= true;
  try
    Log('fServer :' + fServer);
    Log('fDatabase :' + fDatabase);
    Log('FUserName :' + FUserName);
    Log('FUserPass :' + FUserPass);
    if (fServer = '') then begin
      Log('No database server name specified.');
      raise Exception.Create('No database server name specified.');
    end
    else if (fDatabase = '') then begin
      Log('No database name specified.');
      raise Exception.Create('No database name specified.');
    end
    else if (Self.FUserName = '') then begin
      Log('No user name specified.');
      raise Exception.Create('No user name specified.');
    end
    else if (Self.FUserPass = '') AND (AcceptBlankPassword = False ) then begin
      Log('No user password specified.');
      raise Exception.Create('No user password specified.');
    end
    else begin
      if Connect(msg, fConnection, fServer) then begin
        qryLogon := TERPQuery.Create(nil);
        try
          qryLogon.Connection := fConnection;
          qryLogon.SQL.Text :=
            'SELECT p.Pswd_ID, p.Logon_Name, p.Logon_Password, e.EmployeeID ' +
            'FROM tblEmployees e ' +
            'INNER JOIN tblPassword p ON e.EmployeeID = p.EmployeeId ' +
            'WHERE Not IsNull(p.Logon_Name) AND p.Logon_Name <> "" ' +
            'And e.Active = "T" ' +
//            'ORDER BY p.Logon_Name;';
            'AND trim(p.Logon_Name) = ' + QuotedStr(trim(fUserName));
          Log(qryLogon.SQL.Text);
          qryLogon.Open;
//          if not qryLogon.Locate('Logon_Name', fUserName, [loCaseInsensitive]) then begin
          if qryLogon.IsEmpty then begin
            Log('Invalid user name.');
            raise Exception.Create('Invalid user name.');
          end
          else begin
            if AcceptBlankPassword then begin
              fUserPass := LowerCase(DeCrypt(qryLogon.Fields.FieldByName('Logon_Password').AsString, KEY));
            end else begin
              { could be more than one user with this lohon name .. }
              passFound := False;
              while not qryLogon.Eof do begin
                if LowerCase(fUserPass) =
                  LowerCase(DeCrypt(qryLogon.Fields.FieldByName('Logon_Password').AsString, KEY)) then begin
                    passFound := True;
                    Break;
                end;
                qryLogon.Next;
              end;
              if not passFound then begin
                fConnection.Connected := False;
                Log('Invalid user password.');
                raise Exception.Create('Invalid user password.');
              end;
            end;
          end;
          FEmployeeID := qryLogon.Fields.FieldByName('EmployeeID').asInteger;
        finally
          FreeandNil(qryLogon);
        end;
      end
      else begin
        raise Exception.Create(msg);
      end;
    end;
  finally;
    DoingUserConnect := false;
  end;
end;

procedure TAppDatabase.GetUserList(Const List: TStrings);
var
  DbConn: TERPConnection;
  qryUsers: TERPQuery;
  msg: string;
begin
  List.Clear;
  if (fServer <> '') and (fDatabase <> '') then begin
    DbConn:= TERPConnection.Create(nil);
    qryUsers:= TERPQuery.Create(nil);
    qryUsers.Connection:= DbConn;
    qryUsers.SQL.Text:=
      'SELECT p.Logon_Name, e.EmployeeID ' +
      'FROM tblEmployees e ' +
      'INNER JOIN tblPassword p ON e.EmployeeID=p.EmployeeId ' +
      'WHERE Not IsNull(p.Logon_Name) AND p.Logon_Name<>"" ' +
      'And e.Active="T" ' +
      'ORDER BY p.Logon_Name;';
    try
      if Connect(msg, DbConn, fServer) then begin
        qryUsers.Open;
        while not qryUsers.Eof do begin
          List.AddObject(qryUsers.FieldByName('Logon_Name').AsString, TObject(qryUsers.FieldByName('EmployeeID').AsInteger));
          qryUsers.Next;
        end;
        qryUsers.Close;
      end;
      DbConn.Disconnect;
    finally
      FreeandNil(qryUsers);
      FreeandNil(DbConn);
    end;
  end;
end;

procedure TAppDatabase.SetDirty(const Value: boolean);
begin
  FDirty := Value;
end;

function TAppDatabase.DatabaseExists(const aDatabaseName: string): boolean;
var
  x: integer;
  db: string;
begin
  result:= false;
  db:= Lowercase(aDatabaseName);
  for x:= 0 to fDatabaseList.Count -1 do begin
    if db = Lowercase(fDatabaseList[x]) then begin
      result:= true;
      break;
    end;
  end;
end;

{ this makes sure user has windows access to config file }
function TAppDatabase.GetConfigFileAccessOk: boolean;
var
//  configFile: string;
//  F: Text;
  ini: TMemIniFile;

  (*
  function FileIsThere: boolean;
  begin
    {$I-}
    AssignFile(F, configFile);
    FileMode:= 0; {Sets access to read only}
    try
      Reset(F);
      CloseFile(F);
      {$I+}
    finally
      FileMode:= 2;
    end;
    result:= (IOResult = 0);
  end;
  *)

begin
  result:= fConfigFileAccessOk;
  try
    if not fConfigFileAccessOkChecked then begin
      fConfigFileAccessOkChecked:= true;
      (*
      {$I-}
      fConfigFileAccessOk:= false;
      configFile:= SystemLib.ExeDir + CONFIG_FILE;
//      if not FileIsThere then begin
      if not FileExists(configFile) then begin
        AssignFile(F, configFile);
        IOResult;
        Rewrite(F);
        if IOResult <> 0 then exit;
        try
          WriteLn(F,'[General]');
          if IOResult <> 0 then exit;
          fConfigFileAccessOk:= true;
        finally
          CloseFile(F);
        end;
      end
      else begin
        AssignFile(F, configFile);
        IOResult;
        Reset(F);
        if IOResult <> 0 then exit;
        CloseFile(F);
        fConfigFileAccessOk:= true;
      end;
      {$I+}
      *)
      try
        fConfigFileAccessOk := true;
        ini:= TMemIniFile.Create(SystemLib.ExeDir + CONFIG_FILE);
        try
          ini.WriteString('Temp','Time',FormatDateTime('yyyy-mm-dd_hh-nn-ss-zzz',now));
          ini.UpdateFile;
          ini.EraseSection('Temp');
          ini.UpdateFile;
        finally
          ini.Free;
        end;
      except
        fConfigFileAccessOk := false;
      end;

    end;
  finally
    result:= fConfigFileAccessOk;
  end;
end;


procedure TAppDatabase.DoOnKeekAwakeTimer(sender: TObject);
begin
  fKeepAwakeTimer.Enabled:= false;
  try
    if fKeepAwakeQuery.Connection.Connected then begin
      fKeepAwakeQuery.Open;
      fKeepAwakeQuery.Close;
    end;
  finally
    fKeepAwakeTimer.Enabled:= true;
  end;
end;

function TAppDatabase.GetDatabaseRecord(
  aDatabaseName: string): TDatabaseRec;
var x: integer;
begin
  result:= nil;
  x:= fDatabaseList.IndexOf(aDatabaseName);
  if x > -1 then
    result:= TDatabaseRec(fDatabaseList.Objects[x]);
end;

function TAppDatabase.getIsDBconnected: Boolean;
begin
  result := Assigned(fconnection) and
            (fconnection.connected);
end;

function TAppDatabase.getTableVersion: String;
begin
  result := TABLE_VERSION;
end;

function TAppDatabase.GetTransConnection: TERPConnection;
begin
  if not Assigned(fTransConnection) then begin
    fTransConnection := TERPConnection.Create(nil);
    SetConnectionProps(fTransConnection);
  end;
  if (fTransConnection.Server <> Connection.Server) or
     (fTransConnection.Database <> Connection.Database) then begin
    fTransConnection.Close;
    fTransConnection.Server := Connection.Server;
    fTransConnection.Database := Connection.Database;
  end;
  if Connection.Connected and (not fTransConnection.Connected) then
    fTransConnection.Connect;
  result := fTransConnection;
end;

{ TDatabaseRec }

constructor TDatabaseRec.Create;
begin
  inherited;
  fVersionOk:= true;
  fVersion:= '';
  fName:= '';
end;

function TDatabaseRec.GetVersionDesc: string;
begin
  if VersionOk then
    result:= Name + #9 + 'Version ' + Version
  else
    result:= '(' + Name + ')' + #9 + 'Version ' + Version;
end;

initialization

finalization

end.
