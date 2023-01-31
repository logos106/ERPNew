unit DbGen;

interface

uses
  {$IfDef VER220}
  Classes,
  Db,
  MyAccess
  {$Else}
  System.Classes,
  Data.Db,
  FireDAC.Comp.Client,
  FireDAC.Stan.Def,
  FireDAC.DApt,
  FireDAC.Phys.MySQL,
  FireDAC.Stan.Async,
  FireDAC.Stan.Param
  {$EndIf}
  ;

type
  TDbConnection = class;
//  TDbQuery = class;


  TDbGen = class(TObject)
  public
    class function NewConnection(const aDatabase: string; const aServer: string = '127.0.0.1'): TDbConnection;
    class function GetDatabaseList(aServer: string; ErpOnly: boolean = true): string;
  end;

  TDbConnection = class(TComponent)
  private
    {$IfDef VER220}
    fConn: TMyConnection;
    {$Else}
    fConn: TFDConnection;
    {$EndIf}
    fPort: integer;
    fDatabase: string;
    fServer: string;
    function GetConnected: boolean;
    procedure SetConnected(const Value: boolean);
    procedure SetDatabase(const Value: string);
    procedure SetPort(const Value: integer);
    procedure SetServer(const Value: string);
    function GetInternalConnection: TComponent;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Server: string read fServer write SetServer;
    property Database: string read fDatabase write SetDatabase;
    property Connected: boolean read GetConnected write SetConnected;
    property Port: integer read fPort write SetPort;
    procedure ExecSQL(const aSQL: string; const aParams: array of Variant);
    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;
    function InTransaction: boolean;
    property InternalConnection: TComponent read GetInternalConnection;
    procedure Connect;
    procedure Disconnect;
    procedure GetDatabaseNames(aList: TStrings);
    procedure GetTableNames(aList: TStrings);
  end;

  IDbQuery = interface(IInterface)
    procedure SetDbConnection(const value: TDbConnection);
    function GetDbConnection: TDbConnection;

    property DBConnection: TDbConnection read GetDbConnection write SetDbConnection;
    procedure ExecuteSQL(const aSQL: string = '');
  end;


  {$IfDef VER220}
  TDbQuery = class(TMyQuery, IDbQuery)
  {$Else}
  TDbQuery = class(TFDQuery, IDbQuery)
  {$EndIf}
  private
    fConnection: TDbConnection;
    procedure SetDBConnection(const Value: TDbConnection);
    function GetDBConnection: TDbConnection;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property DBConnection: TDbConnection read GetDBConnection write SetDBConnection;
    procedure ExecuteSQL(const aSQL: string = '');
  end;


implementation

uses
  {$IfDef VER220}
  SysUtils,
  MySQLUtils,
  {$Else}
  System.SysUtils,
  {$EndIf}
  DbConst;

{ TDbConnection }

procedure TDbConnection.Commit;
begin
  fConn.Commit;
end;

procedure TDbConnection.Connect;
begin
  Connected := true;
end;

constructor TDbConnection.Create(AOwner: TComponent);
begin
  inherited;
  fPort := DbConst.SERVER_PORT;
  fServer := '127.0.0.1';
  {$IfDef VER220}
  if AOwner is TMyConnection then begin
    fConn := TMyConnection(AOwner);
  end
  else begin
    fConn := TMyConnection.Create(self);
    fConn.Port:= fPort;
    fConn.Options.Compress:= DbConst.MYDAC_OPTIONS_COMPRESS;
    fConn.Options.Protocol:= DbConst.MYDAC_OPTIONS_PROTOCOL;
    fConn.Username:= DbConst.SYSDB_USER;
    fConn.Password:= DbConst.SYSDB_PASS;
    fConn.LoginPrompt:= false;
    fConn.Options.UseUnicode := true;
  end;
  {$Else}
  if AOwner is TFDConnection then begin
    fConn := TFDConnection(AOwner);
  end
  else begin
    fConn := TFDConnection.Create(Self);
    fConn.LoginPrompt := false;
    fConn.Params.DriverID := 'MySQL';
    fConn.Params.Add('Server=' + fServer);
    fConn.Params.Database := fDatabase;
    fConn.Params.Add('Port=' + IntToStr(fPort));
    fConn.Params.UserName := DbConst.SYSDB_USER;
    fConn.Params.Password := DbConst.SYSDB_PASS;
  end;
  {$EndIf}
end;

destructor TDbConnection.Destroy;
begin

  inherited;
end;

procedure TDbConnection.Disconnect;
begin
  Connected := false;
end;

procedure TDbConnection.ExecSQL(const aSQL: string;
  const aParams: array of Variant);
begin
  fConn.ExecSQL(aSQL,aParams);
end;

function TDbConnection.GetConnected: boolean;
begin
  result := fConn.Connected;

end;

procedure TDbConnection.GetDatabaseNames(aList: TStrings);
{$IfDef VER220}
{$Else}
var
  qry: TDbQuery;
{$EndIf}
begin
    {$IfDef VER220}
    fConn.GetDatabaseNames(aList);
    {$Else}
    aLIst.Clear;
    qry := TDbQuery.Create(nil);
    try
      qry.Connection := TFDConnection(self.InternalConnection);
      qry.SQL.Text := 'show databases';
      qry.Open;
      while not qry.Eof do begin
        aList.Add(qry.Fields[0].AsString);
        qry.Next;
      end;
    finally
      qry.Free;
    end;
    {$EndIf}
end;

function TDbConnection.GetInternalConnection: TComponent;
begin
  result := fConn;
end;

procedure TDbConnection.GetTableNames(aList: TStrings);
{$IfDef VER220}
{$Else}
var
  qry: TDbQuery;
{$EndIf}
begin
    {$IfDef VER220}
    fConn.GetTableNames(aList);
    {$Else}
    aLIst.Clear;
    qry := TDbQuery.Create(nil);
    try
      qry.Connection := TFDConnection(self.InternalConnection);
      qry.SQL.Text := 'show full tables';
      qry.Open;
      while not qry.Eof do begin
        if SameText(qry.Fields[1].AsString,'BASE TABLE') then
          aList.Add(qry.Fields[0].AsString);
        qry.Next;
      end;
    finally
      qry.Free;
    end;
    {$EndIf}
end;

function TDbConnection.InTransaction: boolean;
begin
  result := fConn.InTransaction;
end;

procedure TDbConnection.Rollback;
begin
  fConn.Rollback;
end;

procedure TDbConnection.SetConnected(const Value: boolean);
begin
  if Value then begin
    {$IfDef VER220}
    //fConn.Server := fServer;
    fConn.Database := fDatabase;
    fConn.Port := fPort;
    MySQLUtils.SetConnectionServer(fConn, Server);
    {$Else}
    fConn.Params.Values['Server'] := fServer;
    fConn.Params.Database := fDatabase;
    fConn.Params.Values['Port'] := IntToStr(fPort);
    {$EndIf}
  end;
  fConn.Connected := Value;
end;

procedure TDbConnection.SetDatabase(const Value: string);
begin
  fDatabase := Value;
  Connected := false;
end;

procedure TDbConnection.SetPort(const Value: integer);
begin
  fPort := Value;
  Connected := false;
end;

procedure TDbConnection.SetServer(const Value: string);
begin
  fServer := Value;
  Connected := false;
end;

procedure TDbConnection.StartTransaction;
begin
  fConn.StartTransaction;
end;

{ TDbQuery }


{ TDbGen }

class function TDbGen.GetDatabaseList(aServer: string;
  ErpOnly: boolean): string;
var
  conn: TDbConnection;
  q1, q2: TDbQuery;
begin
  result:= '';
  conn:= TDbConnection.Create(nil);
  conn.Server := aServer;
  q1:= TDbQuery.Create(nil);
  q2:= TDbQuery.Create(nil);
  try
    conn.Database:= DbConst.MYSQL_DATABASE;
    conn.Connect;
    q1.DbConnection:= conn;
    q2.DbConnection:= conn;
    q1.SQL.Add('select distinct table_schema');
    q1.SQL.Add('from information_schema.TABLES');
    if ErpOnly then
      q1.SQL.Add('where TABLE_NAME = "tblupdatedetails"');
    q2.SQL.Add('select count(TABLE_SCHEMA) as TableCount');
    q2.SQL.Add('from information_schema.TABLES');
    q2.SQL.Add('where table_schema = :DbName');

    q1.Open;
    while not q1.Eof do begin
      if ErpOnly then begin
        q2.ParamByName('DbName').AsString:= q1.Fields[0].AsString;
        q2.Open;
        try
          if q2.Fields[0].AsInteger > 300 then begin
            if result <> '' then result:= result + ',';
            result:= result + '"' +  q1.Fields[0].AsString + '"';
          end;
        finally
          q2.Close;
        end;

      end
      else begin
        if result <> '' then result:= result + ',';
        result:= result + '"' +  q1.Fields[0].AsString + '"';
      end;
      q1.Next;
    end;
  finally
    q1.Free;
    q2.Free;
    conn.Free;
  end;
end;

class function TDbGen.NewConnection(const aDatabase,
  aServer: string): TDbConnection;
begin
  result := TDbConnection.Create(nil);
  result.Server := aServer;
  result.Database := aDatabase;
end;

{ TDbQuery }

constructor TDbQuery.Create(AOwner: TComponent);
begin
  inherited;
  if AOwner is TDbConnection then
    self.DBConnection := TDbConnection(AOwner);
end;

destructor TDbQuery.Destroy;
begin

  inherited;
end;

procedure TDbQuery.ExecuteSQL(const aSQL: string);
begin
  if aSQL <> '' then
    self.SQL.Text := aSQL;
  {$IfDef VER220}
  self.Execute
  {$Else}
  self.ExecSQL;
  {$EndIf}
end;

function TDbQuery.GetDBConnection: TDbConnection;
begin
  result := fConnection;
end;

procedure TDbQuery.SetDBConnection(const Value: TDbConnection);
begin
  fConnection := Value;
  {$IfDef VER220}
  self.Connection := TMyConnection(fConnection.InternalConnection);
  {$Else}
  self.Connection := TFDConnection(fConnection.InternalConnection);
  {$EndIf}
end;

end.
