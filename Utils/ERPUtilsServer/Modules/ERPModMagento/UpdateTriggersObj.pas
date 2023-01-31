unit UpdateTriggersObj;

interface

uses
  ERPDbComponents;

type
  TUpdateTriggers = class
  private
    FDatabaseName: string;
    FConnection: TERPConnection;
    function Connection: TERPConnection;
    procedure SetDatabaseName(const Value: string);
  public
    destructor Destroy; overload;
    property DatabaseName: string read FDatabaseName write SetDatabaseName;
    procedure Generate(TriggerFor, ObjectType: string);
    class procedure GenerateTriggers(aDatabaseName, aTriggerFor, aObjectType: string);
  end;

const
  ObjectType_Product = 'Product';

implementation

uses
  MySQLUtils, DbSharedObjectsObj, SysUtils, MySQLConst;


{ TUpdateTriggers }

function TUpdateTriggers.Connection: TERPConnection;
begin
  if (not Assigned(fConnection)) then begin
    fConnection := TERPConnection.Create(nil);
    SetConnectionProps(fConnection,DatabaseName);
    FConnection.Connect;
  end
  else if FConnection.Database <> DatabaseName then begin
    if FConnection.Connected then FConnection.Disconnect;
    FConnection.Database := DatabaseName;
    FConnection.Connect;
  end;
  result := fConnection;
end;

destructor TUpdateTriggers.Destroy;
begin
  FConnection.Free;
end;

class procedure TUpdateTriggers.GenerateTriggers(aDatabaseName, aTriggerFor,
  aObjectType: string);
begin
  with TUpdateTriggers.Create do begin
    try
      DatabaseName := aDatabaseName;
      Generate(aTriggerFor,aObjectType);
    finally
      Free;
    end;
  end;
end;

procedure TUpdateTriggers.Generate(TriggerFor, ObjectType: string);
var
  qry: TERPQuery;
  cmd: TERPCommand;
  dt: TDateTime;
  id: integer;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection);
  cmd := DbSharedObjectsObj.DbSharedObj.GetCommand(Connection);
  try
    cmd.SQL.Add('insert into tblchangetrigger (TriggerFor,ObjectType,InstId,msTimeStamp,msUpdateSiteCode)');
    cmd.SQL.Add('values (' + QuotedStr(TriggerFor) + ',:ObjectType,:InstId,:msTimeStamp,:msUpdateSiteCode)');
    cmd.SQL.Add('on duplicate key update msTimeStamp = :msTimeStamp, msUpdateSiteCode = :msUpdateSiteCode');
    if SameText(ObjectType,ObjectType_Product) then begin
      qry.SQL.Clear;
      qry.SQL.Add('select msTimeStamp, InstId from tblchangetriggerdone');
      qry.SQL.Add('where TriggerFor = ' + QuotedStr(TriggerFor));
      qry.SQL.Add('and ObjectType = ' + QuotedStr(ObjectType_Product));
      qry.SQL.Add('order by msTimeStamp DESC LIMIT 1');
      qry.Open;
      dt := qry.FieldByName('msTimeStamp').AsDateTime;
      id := qry.FieldByName('InstId').AsInteger;
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('select msTimeStamp, PartsId as InstId, msUpdateSiteCode from tblparts');
      qry.SQL.Add('where msTimeStamp >= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,dt)));
      qry.SQL.Add('and PartsID <> ' + IntToStr(id));
      qry.Open;
      while not qry.Eof do begin
        cmd.ParamByName('ObjectType').AsString := ObjectType_Product;
        cmd.ParamByName('InstId').AsInteger := qry.FieldByName('InstId').AsInteger;
        cmd.ParamByName('msTimeStamp').AsDAteTime := qry.FieldByName('msTimeStamp').AsDateTime;
        cmd.ParamByName('msUpdateSiteCode').AsString := qry.FieldByName('msUpdateSiteCode').AsString;
        cmd.Execute;
        qry.Next;
      end;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(cmd);
  end;
end;

procedure TUpdateTriggers.SetDatabaseName(const Value: string);
begin
  FDatabaseName := Value;
end;

end.
