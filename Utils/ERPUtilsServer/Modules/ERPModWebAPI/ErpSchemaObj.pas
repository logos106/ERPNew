unit ErpSchemaObj;

interface

uses
  JsonObject, SyncObjs;

type
  TErpSchema = class(TObject)
  private
    Lock: TCriticalSection;
    Data: TJsonObject;
  public
    constructor Create;
    destructor Destroy; override;
    function DbSchema(const aDatabaseName: string = ''): TJsonObject;
  end;

  function ErpSchema: TErpSchema;

implementation

uses
  SysUtils, AppEnvironment, MyAccess, MySQLUtils, VersionUtils, DbConst;

var
  fErpSchema: TErpSchema;

function ErpSchema: TErpSchema;
begin
  if not Assigned(fErpSchema) then
    fErpSchema := TErpSchema.Create;
  result := fErpSchema;
end;


{ TErpSchema }

constructor TErpSchema.Create;
begin
  Lock := TCriticalSection.Create;
  Data := JO;
end;

function TErpSchema.DbSchema(const aDatabaseName: string): TJsonObject;
var
  dbName: string;
  qry: TMyQuery;
  conn: TMyConnection;
  ver: string;
  obj: TJsonObject;
  x: integer;
begin
  Lock.Acquire;
  try
    dbName := aDatabaseName;
    if dbName = '' then dbName := AppEnv.AppDb.Database;
    result := Data.O[dbName];
    if result.IsBlank then begin
      conn := TMyConnection.Create(nil);
      qry := TMyQuery.Create(nil);
      try
        qry.Connection := conn;
        SetConnectionProps(conn,dbName);
        conn.Connect;
        qry.SQL.Text := 'select * from tblupdatedetails';
        qry.Open;
        result.S['Version'] := qry.FieldByName('Version').AsString;
        ver := VersionUtils.VersionToSortString(qry.FieldByName('Version').AsString);
        qry.Close;
        conn.Disconnect;
        conn.Database := SERVICES_DATABASE;
        conn.Connect;
        { get the info on all of the classes for this db }
        qry.SQL.Clear;
        qry.SQL.Add('select Max(ERPVersion) as MaxVersion, S.*');
        qry.SQL.Add('from tblSchema as S');
        qry.SQL.Add('where ERPVersion <= ' +QuotedStr(ver));
        qry.SQL.Add('and Active = "T"');
        qry.SQL.Add('group by ClassName');
        qry.Open;
        while not qry.Eof do begin
          obj := result.O[qry.FieldByName('ClassName').AsString];
          obj.S['ERPVersion'] := qry.FieldByName('ERPVersion').AsString;
          obj.S['DbTableDef'] := qry.FieldByName('DbTableDef').AsString;
          obj.B['ReadOnly'] := qry.FieldByName('ReadOnly').AsBoolean;
          obj.S['Description'] := qry.FieldByName('Description').AsString;
          qry.Next;
        end;
        qry.Close;
        { get property infor fo each class }
        for x := 0 to result.Count -1 do begin
          if result.Items[x].ValueType = valObject then begin
            obj := TJsonObject(result.Items[x].Value);
            qry.SQL.Clear;
            qry.SQL.Add('select Max(ERPVersion) as MaxVersion, SP.*');
            qry.SQL.Add('from tblSchemaProp as SP');
            qry.SQL.Add('where ClassName = ' +QuotedStr(result.Items[x].Name));
            qry.SQL.Add('and ERPVersion <= ' +QuotedStr(ver));
            qry.SQL.Add('and Active = "T"');
            qry.SQL.Add('group by PropName');
            qry.SQL.Add('order by PropName');
            qry.Open;
            while not qry.Eof do begin
              with obj.O['Props'].O[qry.FieldByName('PropName').AsString] do begin
                S['ERPVersion'] := qry.FieldByName('ERPVersion').AsString;
                S['DbFieldName'] := qry.FieldByName('DbFieldName').AsString;
                S['PropName'] := qry.FieldByName('PropName').AsString;
                S['PropType'] := qry.FieldByName('PropType').AsString;
                B['ReadOnly'] := qry.FieldByName('ReadOnly').AsBoolean;
                S['Description'] := qry.FieldByName('Description').AsString;
                S['LinkSQL'] := qry.FieldByName('LinkSQL').AsString;
              end;
              qry.Next;
            end;
            qry.Close;
          end;
        end;
      finally
        qry.Free;
      end;
    end;
  finally
    Lock.Release;
  end;
end;

destructor TErpSchema.Destroy;
begin
  Data.Free;
  Lock.Free;
  inherited;
end;


initialization
  fErpSchema := nil;

finalization
  FreeAndNil(fErpSchema);

end.
