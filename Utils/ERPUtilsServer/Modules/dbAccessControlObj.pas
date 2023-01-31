unit dbAccessControlObj;

interface

uses
  MyAccess, DbConst, JsonObject;

type

  TDatabaseStatus = (dsAvailable, dsNotAvailable);

  TDbAccessControl = class
  private
    FMySQLServer: string;
    DbConnection: TMyConnection;
    qry: TMyQuery;
    Schema: TJsonObject;
    procedure SetMySQLServer(const Value: string);
    function Connect(var msg: string): boolean;
  public
    constructor Create;
    destructor Destroy; override;
    property MySQLServer: string read FMySQLServer write SetMySQLServer;
    procedure SetDatabaseStatus(const aDatabaseName, aMessage: string;
      aStatus: TDatabaseStatus);
    function GetDatabaseStatus(const aDatabaseName: string;
      var aMessage: string; var aTimeFrom: TDateTime): TDatabaseStatus;
    function RegisterDbUser(const aDatabaseName, aModuleName, aUserName: string;
      aInst: integer; var msg: string; OnlyIfDbAvailable: boolean = true): boolean;
    procedure UnRegisterDbUser(const aDatabaseName, aModuleName, aUserName: string; aInst: integer);
  end;

implementation

uses
  sysutils, DBSchemaObj;

{ TDbAccessControl }

function TDbAccessControl.Connect(var msg: string): boolean;
begin
  msg:= '';
  if DbConnection.Connected then begin
    result:= true;
    exit;
  end;
  result:= false;
  if FMySQLServer = '' then
    msg:= 'Database Server Name is blank'
  else
  begin
    if not TDBSchema.ValidateDbSchema(fMySQLServer,DBConnection.Database,Schema,msg) then
      exit;
    DbConnection.Server:= FMySQLServer;
    try
      DbConnection.Connect;
    except
      on e: Exception do begin
        msg:= 'Could not connect to MySQL server - error message: ' + e.Message;
      end;
    end;
  end;
  result:= DbConnection.Connected;
end;

constructor TDbAccessControl.Create;
begin
  DbConnection:= TMyConnection.Create(nil);
  DbConnection.Username:= SYSDB_USER;
  DbConnection.Password:= SYSDB_PASS;
  DbConnection.Options.Compress := MYDAC_OPTIONS_COMPRESS;
  DbConnection.Options.Protocol := MYDAC_OPTIONS_PROTOCOL;
  DbConnection.Port := SERVER_PORT;
  DbConnection.LoginPrompt:= false;
  DbConnection.Database:= SERVICES_DATABASE;
  qry:= TMyQuery.Create(nil);
  qry.Connection:= DbConnection;
  Schema:= JO(
    '{' +
    '  "tables": {                          ' +
    '    "tbldatabasestatus": {             ' +
    '      "fields": {                      ' +
    '        "databasename" {               ' +
    '          "datatype": "string",        ' +
    '          "size": 255,                 ' +
    '          "allownull": false           ' +
    '        },                             ' +
    '        "status" {                     ' +
    '          "datatype": "integer",       ' +
    '          "allownull": false,          ' +
    '          "default": "0"               ' +
    '        },                             ' +
    '        "message" {                    ' +
    '          "datatype": "string",        ' +
    '          "size": 255,                 ' +
    '          "allownull": false           ' +
    '        },                             ' +
    '        "datetime" {                   ' +
    '          "datatype": "datetime",      ' +
    '          "allownull": false           ' +
    '        }                              ' +
    '      },                               ' +
    '      "indexes": {                     ' +
    '        "primaryidx": {                ' +
    '          "fields": "databasename",    ' +
    '          "isprimary": true            ' +
    '        }                              ' +
    '      },                               ' +
    '      "engine": "myisam"               ' +
    '    },                                 ' +
    '    "tbldatabasesusers": {             ' +
    '      "fields": {                      ' +
    '        "databasename" {               ' +
    '          "datatype": "string",        ' +
    '          "size": 255,                 ' +
    '          "allownull": false           ' +
    '        },                             ' +
    '        "username" {                   ' +
    '          "datatype": "string",        ' +
    '          "size": 255,                 ' +
    '          "allownull": false           ' +
    '        },                             ' +
    '        "modulename" {                 ' +
    '          "datatype": "string",        ' +
    '          "size": 255,                 ' +
    '          "allownull": false           ' +
    '        },                             ' +
    '        "instance" {                   ' +
    '          "datatype": "integer",       ' +
    '          "allownull": false           ' +
    '        },                             ' +
    '        "datetime" {                   ' +
    '          "datatype": "datetime",      ' +
    '          "allownull": false           ' +
    '        }                              ' +
    '      },                               ' +
    '      "indexes": {                     ' +
    '        "databaseidx": {               ' +
    '          "fields": "databasename"     ' +
    '        },                             ' +
    '        "instanceidx": {               ' +
    '          "fields": "instance"         ' +
    '        }                              ' +
    '      },                               ' +
    '      "engine": "myisam"               ' +
    '    }                                  ' +
    '  }                                    ' +
    '}                                      '
  );
end;

destructor TDbAccessControl.Destroy;
begin
  Schema.Free;
  qry.Free;
  DbConnection.Free;
  inherited;
end;

function TDbAccessControl.GetDatabaseStatus(const aDatabaseName: string;
  var aMessage: string; var aTimeFrom: TDateTime): TDatabaseStatus;
var
  msg: string;
begin
  aMessage:= '';
  result:= dsAvailable;
  if not self.Connect(msg) then
    raise Exception.Create('Error while getting database status: ' + msg);
  qry.SQL.Text:=
    'select * from tbldatabasestatus where ' +
    'databasename = ' + QuotedStr(aDatabaseName);
  qry.Open;
  try
    if not qry.IsEmpty then begin
      result:= TDatabaseStatus(qry.FieldByName('status').AsInteger);
      aMessage:= qry.FieldByName('message').AsString;
      aTimeFrom:= qry.FieldByName('datetime').AsDateTime;
    end;
  finally
    qry.Close;
  end;
end;

function TDbAccessControl.RegisterDbUser(const aDatabaseName, aModuleName,
  aUserName: string; aInst: integer; var msg: string; OnlyIfDbAvailable: boolean = true): boolean;
var
  s: string;
  dt: TDateTime;
begin
  result:= true;
  msg:= '';
  if OnlyIfDbAvailable then begin
    if GetDatabaseStatus(aDatabaseName, s, dt) <> dsAvailable then begin
      result:= false;
      msg:= s;
      exit;
    end;
  end;
  qry.SQL.Text:=
    'insert into tbldatabasesusers set' +
    ' databasename = ' + QuotedStr(aDatabaseName) +
    ', username = ' + QuotedStr(aUserName) +
    ', modulename = ' + QuotedStr(aModuleName) +
    ', instance = ' + IntToStr(aInst) +
    ', datetime = ' + QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss',now)) + ';';
  qry.Execute;
end;

procedure TDbAccessControl.UnRegisterDbUser(const aDatabaseName,
  aModuleName, aUserName: string; aInst: integer);
begin
  qry.SQL.Text:=
    'delete from tbldatabasesusers where' +
    ' databasename = ' + QuotedStr(aDatabaseName) +
    ' and username = ' + QuotedStr(aUserName) +
    ' and modulename = ' + QuotedStr(aModuleName) +
    ' and instance = ' + IntToStr(aInst);
  qry.Execute;
end;

procedure TDbAccessControl.SetDatabaseStatus(const aDatabaseName, aMessage: string;
      aStatus: TDatabaseStatus);
var
  msg: string;      
begin
  if not self.Connect(msg) then
    raise Exception.Create('Error while setting database status: ' + msg);
  qry.SQL.Text:=
    'select * from tbldatabasestatus where ' +
    'databasename = ' + QuotedStr(aDatabaseName);
  qry.Open;
  try
    if qry.IsEmpty then begin
      qry.Insert;
      qry.FieldByName('databasename').AsString:= aDatabaseName;
    end
    else
      qry.Edit;
    qry.FieldByName('databasename').AsString:= aDatabaseName;
    qry.FieldByName('status').AsInteger:= Ord(aStatus);
    qry.FieldByName('message').AsString:= aMessage;
    qry.FieldByName('datetime').AsDateTime:= now;
    qry.Post;
  finally
    qry.Close;
  end;
end;

procedure TDbAccessControl.SetMySQLServer(const Value: string);
begin
  FMySQLServer := Value;
  if DbConnection.Connected then
    DbConnection.Disconnect;
end;

end.
