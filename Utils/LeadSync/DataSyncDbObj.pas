unit DataSyncDbObj;

interface

uses
  ERPDbComponents;

type

  TDataSyncRec = record
    ID: integer;
    ClassName: string;
    SourceID: integer;
    SourceMsTimeStamp: TDateTime;
    DestGlobalRef: string;
  end;

  TDataSyncDb = class
  private
    Conn: TERPConnection;
    fDatabaseName: string;
    procedure SetActive(const Value: boolean);
    function GetActive: boolean;
    procedure SetConnectionProps(connection: TERPConnection;
      Database: string = ''; Server: string = 'localhost');
  public
    constructor Create;
    destructor Destroy; override;
    property Active: boolean read GetActive write SetActive;
    property DatabaseName: string read fDatabaseName write fDatabaseName;
    function RecordExists(aClassName: string; aId: integer; var Rec: TDataSyncRec): boolean;
  end;

implementation

uses
  sysutils, forms, DbConst, classes;

{ TDataSyncDb }

constructor TDataSyncDb.Create;
begin
  fDatabaseName:= ChangeFileExt(ExtractFileName(Application.ExeName),'');
  Conn:= TErpConnection.Create(nil);
  SetConnectionProps(Conn);
end;

destructor TDataSyncDb.Destroy;
begin
  Conn.Free;
  inherited;
end;

function TDataSyncDb.GetActive: boolean;
begin

end;

function TDataSyncDb.RecordExists(aClassName: string; aId: integer;
  var Rec: TDataSyncRec): boolean;
var
  qry: TERPQuery;
begin
  result:= false;
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= Conn;
    qry.SQL.Add('select * from tblRemoteData');
    qry.SQL.Add('where ClassName = ' + QuotedStr(aClassName));
    qry.SQL.Add('and SourceID = ' + IntToStr(aID));
    qry.Open;
    if not qry.IsEmpty then begin
      result:= true;
      Rec.ID:= qry.FieldByName('ID').AsInteger;
      Rec.ClassName:= qry.FieldByName('ClassName').AsString;
      Rec.SourceID:= qry.FieldByName('SourceID').AsInteger;
      Rec.SourceMsTimeStamp:= qry.FieldByName('SourceMsTimeStamp').AsDateTime;
      rec.DestGlobalRef:= qry.FieldByName('DestGlobalRef').AsString;
    end;
  finally
    qry.Free;
  end;
end;

procedure TDataSyncDb.SetActive(const Value: boolean);
var
  sl: TStringList;
  qry: TERPQuery;
begin
  if Value then begin
    sl:= TStringList.Create;
    try
      Conn.Connected:= false;
      Conn.Database:= MYSQL_DATABASE;
      Conn.Connected:= true;
      Conn.GetDatabaseNames(sl);
      if sl.IndexOf(DatabaseName) < 0 then begin
        { create the database }
        qry:= TERPQuery.Create(nil);
        try
          qry.Connection:= Conn;
          qry.SQL.Text:= 'Create Database ' + DatabaseName;
          qry.Execute;
        finally
          qry.Free;
        end;
      end;
      Conn.Disconnect;
      Conn.Database:= DatabaseName;
      Conn.Connect;
      Conn.GetTableNames(sl);
      if sl.IndexOf('tblRemoteData') < 0 then begin
        { create }
        qry:= TERPQuery.Create(nil);
        try
          qry.Connection:= Conn;
          qry.SQL.Add('create table tblRemoteData (');
          qry.SQL.Add('ID int(11) not null auto_increment,');
          qry.SQL.Add('ClassName varchar(255) null default null,');
          qry.SQL.Add('SourceID int(11) null default null,');
          qry.SQL.Add('SourceMsTimeStamp TimeStamp null default null,');
          qry.SQL.Add('DestGlobalRef varchar(255) null default null,');
          qry.SQL.Add('primary key (ID),');
          qry.SQL.Add('index ClassIdx (ClassName, SourceID)');
          qry.SQL.Add(') engine = InnoDB;');
          qry.Execute;
        finally
          qry.Free;
        end;
      end;
    finally
      sl.Free;
    end;
  end
  else begin
    Conn.Connected:= false;
  end;
end;

procedure TDataSyncDb.SetConnectionProps(connection: TERPConnection; Database,
  Server: string);
begin
  Connection.Port:= DbConst.SERVER_PORT;
  Connection.Options.Compress:= DbConst.MYDAC_OPTIONS_COMPRESS;
  Connection.Options.Protocol:= DbConst.MYDAC_OPTIONS_PROTOCOL;
  Connection.Username:= DbConst.SYSDB_USER;
  Connection.Password:= DbConst.SYSDB_PASS;
  Connection.LoginPrompt:= false;
  Connection.Server:= Server;
  Connection.Database:= Database;
end;

end.
