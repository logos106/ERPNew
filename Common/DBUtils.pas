unit DBUtils;

interface

uses
  Classes, MyAccess, DbConst, DBAccess, DB, ERPDbComponents;

type

  TMySQLWebConnectionMan = class
  private
    fInst: TObject;
  public
    procedure DoBeforeConnect(Sender: TObject);
    procedure DoOnAfterConnect(Sender: TObject);
    procedure DoOnError(Sender: TObject; E: EDAError; var Fail: boolean);
  end;

  function GetNewDbConnection(ServerName: string = ''; DatabaseName: string = ''): TERPConnection;
  function GetDefaultSiteCode(Conn: TMyConnection): string;
  function GetDatabaseList(aServer: string; ErpOnly: boolean = true): string;

  procedure CloseDB(Ds: TDataset);
  procedure OpenDB(Ds: TDataset);
  procedure EditDB(const Ds: TDataset);
  procedure PostDB(const Ds: TDataset);


implementation

uses
  MySQLErrors, MyClasses, SysUtils;

var
  fMySQLWebConnectionMan: TMySQLWebConnectionMan;

function WebConnectionMan: TMySQLWebConnectionMan;
begin
  if not Assigned(fMySQLWebConnectionMan) then
    fMySQLWebConnectionMan:= TMySQLWebConnectionMan.Create;
  result:= fMySQLWebConnectionMan;
end;

{ TMySQLWebConnectionMan }

procedure TMySQLWebConnectionMan.DoOnAfterConnect(Sender: TObject);
begin
  fInst:= nil;
end;

procedure TMySQLWebConnectionMan.DoBeforeConnect(Sender: TObject);
begin
  if Lowercase(TMyConnection(Sender).Server) = 'www.trueerp.com' then begin
      TMyConnection(Sender).Username:= 'erpint';
      TMyConnection(Sender).Password:= 'karl1karl1';
      TMyConnection(Sender).Port:= 3306;
  end
  else begin
      TMyConnection(Sender).Username:= SYSDB_USER;
      TMyConnection(Sender).Password:= SYSDB_PASS;
      TMyConnection(Sender).Port:= SERVER_PORT;
  end;
end;

procedure TMySQLWebConnectionMan.DoOnError(Sender: TObject; E: EDAError;
  var Fail: boolean);
begin
  Fail:= false;
  if (fInst = Sender) and (not TMyConnection(Sender).Connected) then begin
    if TMyConnection(Sender).Username <> SYSDB_USER then begin
      TMyConnection(Sender).Username:= SYSDB_USER;
      TMyConnection(Sender).Password:= SYSDB_PASS;
      TMyConnection(Sender).Port:= SERVER_PORT;
    end
    else begin
      TMyConnection(Sender).Username:= 'erpint';
      TMyConnection(Sender).Password:= 'karl1karl1';
      TMyConnection(Sender).Port:= 3306;
    end;
    TMyConnection(Sender).Connected:= true;
  end;
end;

function GetNewDbConnection(ServerName: string = ''; DatabaseName: string = ''): TERPConnection;
begin
  result:= TERPConnection.Create(nil);
  result.Username:= SYSDB_USER;
  result.Password:= SYSDB_PASS;
  result.Options.Compress := MYDAC_OPTIONS_COMPRESS;
  result.Options.Protocol := MYDAC_OPTIONS_PROTOCOL;
  result.Port := SERVER_PORT;
  result.LoginPrompt:= false;
  result.Server:= ServerName;
  result.Database:= DatabaseName;
  result.BeforeConnect:= WebConnectionMan.DoBeforeConnect;
end;

function GetDefaultSiteCode(Conn: TMyConnection): string;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection:= conn;
    qry.SQL.Text:= 'select SiteCode from tblmsbackendid where BEDefault = "T"';
    qry.Open;
    result:= qry.Fields[0].AsString;
  finally
    qry.Free;
  end;
end;

function GetDatabaseList(aServer: string; ErpOnly: boolean = true): string;
var
  conn: TMyConnection;
  q1, q2: TMyQuery;
begin
  result:= '';
  conn:= GetNewDbConnection(aServer);
  q1:= TMyQuery.Create(nil);
  q2:= TMyQuery.Create(nil);
  try
    conn.Database:= DbConst.MYSQL_DATABASE;
    conn.Connect;
    q1.Connection:= conn;
    q2.Connection:= conn;
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

procedure CloseDB(Ds: TDataset);
begin
  if Ds.Active then
    Ds.Close;
end;

procedure OpenDB(Ds: TDataset);
begin
  if not Ds.Active then
    Ds.Active := true;
end;

procedure EditDB(const Ds: TDataset);
begin
  if ds.active = False then exit;
  if not(ds.state in [dsEdit , dsInsert]) then ds.Edit;
end;

procedure PostDB(const Ds: TDataset);
begin
  if ds.active = False then exit;
  if ds.state in [dsEdit , dsInsert] then ds.Post;
end;

initialization

finalization
  fMySQLWebConnectionMan.Free;

end.
