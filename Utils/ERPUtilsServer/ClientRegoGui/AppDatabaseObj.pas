unit AppDatabaseObj;

interface

uses
  classes, MyAccess, AppConfigObj;

type
  TAppDatabase = class(TPersistent)
  private
    procedure SetDatabaseName(const Value: string);
    procedure SetServerName(const Value: string);
    function GetDatabaseName: string;
    function GetServerName: string;
    procedure DoBeforeConnect(Sender: TObject);
  public
    Connection: TMyConnection;
    constructor Create;
    destructor Destroy; override;
    property ServerName: string read GetServerName write SetServerName;
    property DatabaseName: string read GetDatabaseName write SetDatabaseName;
    procedure AssignConnectionProps(aConn: TMyConnection);
  end;

var
  AppDatabase: TAppDatabase;

implementation

uses
  sysutils, forms, DbConst, JsonToObject;

{ TAppDatabase }

procedure TAppDatabase.AssignConnectionProps(aConn: TMyConnection);
begin
  aConn.LoginPrompt:= false;
  aConn.Port:= Connection.Port;
  aConn.Options.Compress:= Connection.Options.Compress;
  aConn.Options.Protocol:= Connection.Options.Protocol;
  aConn.Username:= Connection.Username;
  aConn.Password:= Connection.Password;
  aConn.Server:= Connection.Server;
  aConn.Database:= Connection.Database;
end;

constructor TAppDatabase.Create;
begin
  inherited;
//  if ServerName = '' then
//    ServerName:= 'server1';
  if DatabaseName = '' then
    DatabaseName:= SERVICES_DATABASE;
  Connection:= TMyConnection.Create(nil);
  Connection.Port:= SERVER_PORT;
  Connection.Options.Compress:= MYDAC_OPTIONS_COMPRESS;
  Connection.Options.Protocol:= MYDAC_OPTIONS_PROTOCOL;
  Connection.LoginPrompt:= false;
  Connection.Username:= SYSDB_USER;
  Connection.Password:= SYSDB_PASS;
//  Connection.Server:= ServerName;
//  Connection.Database:= DatabaseName;
  Connection.BeforeConnect:= DoBeforeConnect;
  try
    Connection.Connect;
  except
  end;
end;

destructor TAppDatabase.Destroy;
begin
  Connection.Free;
  inherited;
end;

procedure TAppDatabase.DoBeforeConnect(Sender: TObject);
begin
  Connection.Server:= ServerName;
  Connection.Database:= DatabaseName;
end;

function TAppDatabase.GetDatabaseName: string;
begin
  result:= AppConfig.Data.O['database'].S['databasename'];
end;

function TAppDatabase.GetServerName: string;
begin
  result:= AppConfig.Data.O['database'].S['servername'];
end;

procedure TAppDatabase.SetDatabaseName(const Value: string);
begin
  AppConfig.Data.O['database'].S['databasename'] := Value;
end;

procedure TAppDatabase.SetServerName(const Value: string);
begin
  AppConfig.Data.O['database'].S['servername'] := Value;
end;

initialization
  AppDatabase:= TAppDatabase.Create;

finalization
  AppDatabase.Free;

end.
