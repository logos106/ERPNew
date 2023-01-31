unit DataItem;

interface

(*
drop table if exists tblErpObjectMapping;
CREATE TABLE if not exists `tblErpObjectMapping` (
	`ID` INT(11) NOT NULL AUTO_INCREMENT,
	`ObjectName` VARCHAR(255) NULL DEFAULT NULL,
	`DbTableName` VARCHAR(255) NULL DEFAULT NULL,
	`DbFilter` VARCHAR(255) NULL DEFAULT "",
	`Mapping` LongText NULL DEFAULT NULL,
	`ApiEnabled` ENUM("T","F") NOT NULL DEFAULT "F",
	`ReadOnly` ENUM("T","F") NOT NULL DEFAULT "F",
	PRIMARY KEY (`ID`),
	INDEX ObjectNAmeIdx (ObjectNAme)
)ENGINE=MyISAM;
*)

uses
  JSONObject, ConTnrs, DB, MyAccess;

type

  TDataItemClass = class of TDataItem;
  TDataItem = class(TObject)
  private
    fItemTypeName: string;
  public
    constructor Create(const aItemTypeName: string);
    destructor Destroy; override;
    property ItemTypeName: string read fItemTypeName;
//    class function NewData(const aItemTypeName: string): TJsonObject;
//    class procedure Load(const aItemTypeName: string; data: TJsonObject; aConnection: TMyConnection); overload;
//    class procedure Load(const aItemTypeName: string; data: TJsonObject; Id: integer); overload;
//    class function PropToField(const aItemTypeName, aPropName: string): string;
//    class function TableName(const aItemTypeName: string): string;
//    class function List(const aItemTypeName: string; sql: string = ''): TJsonArray;
  end;

  //TInvoice = class(TDataItem)
  //end;

  TMappingItem = class
  private
    FTypeName: string;
    FJson: TJsonObject;
//    fMaps: TJsonObject;
//    fFields: TJsonObject;
    procedure SetTypeName(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    property Json: TJsonObject read FJson;
//    property Maps: TJsonObject read fMaps;
//    property Fields: TJsonObject read fFields;
    property TypeName: string read FTypeName write SetTypeName;
  end;

  TMappingList = class(TObject)
  private
    fList: TObjectList;
    function GetItemByName(aName: string; aConnection: TMyConnection): TMappingItem;
    procedure LoadMappings;
  public
    constructor Create;
    destructor Destroy; override;
    property ItemByName[aName: string; aConnection: TMyConnection]: TMappingItem read GetItemByName;
    class function GetMapping(const aName: string; aConnection: TMyConnection): TJsonObject;
  end;



implementation

uses
  SysUtils,
  MySQLUtils;

var
  fMappingList: TMappingList;

{ TMappingItem }

constructor TMappingItem.Create;
begin
  fJson := JO;
//  fFields := Jo;
//  fMaps := Jo;
end;

destructor TMappingItem.Destroy;
begin
  fJson.Free;
  inherited;
end;

procedure TMappingItem.SetTypeName(const Value: string);
begin
  FTypeName := Value;
end;

{ TMappingList }

constructor TMappingList.Create;
begin
  fList := TObjectList.Create;
  //LoadMappings;
end;

destructor TMappingList.Destroy;
begin
  fList.Free;
  inherited;
end;

function TMappingList.GetItemByName(aName: string; aConnection: TMyConnection): TMappingItem;
var
  x: integer;
  MI: TMappingItem;
begin
  MI := nil;
  for x := 0 to fList.Count -1 do begin
    if SameText(TMappingItem(fList[x]).TypeName, aName) then begin
      MI := TMappingItem(fList[x]);
      break;
    end;
  end;
  if not Assigned(MI) then begin


  end;
  result := MI;
end;

class function TMappingList.GetMapping(const aName: string; aConnection: TMyConnection): TJsonObject;
var
  MI: TMappingItem;
begin
  result := nil;
  if not Assigned(fMappingList) then
    fMappingList := TMappingList.Create;
  MI := fMappingList.ItemByName[aName, aConnection];
  if Assigned(MI) then
    result := MI.Json;
end;

procedure TMappingList.LoadMappings;
var
  MI: TMappingItem;
begin
  MI := TMappingItem.Create;
  MI.TypeName := 'Invoice';
  { POPULATE THE MAPPING DATA! .. }
  MI.Json.S['TableName']:= 'tblSales';
  MI.Json.S['Filter']:= 'IsInvoice = "T" and Deleted = "F"';
  with MI.Json.A['Mapping'].AddObject do begin
    S['Prop'] := 'ID';
    S['Field'] := 'SaleID';
    S['Type'] := 'Int';
  end;
  with MI.Json.A['Mapping'].AddObject do begin
    S['Prop'] := 'DocumentNumber';
    S['Field'] := 'InvoiceDocNumber';
    S['Type'] := 'String';
    I['Size'] := 30;
  end;
  with MI.Json.A['Mapping'].AddObject do begin
    S['Prop'] := 'CustomerID';
    S['Field'] := 'ClientID';
    S['Type'] := 'Int';
  end;
  with MI.Json.A['Mapping'].AddObject do begin
    S['Prop'] := 'CustomerName';
    S['Field'] := 'CustomerName';
    S['Type'] := 'String';
    I['Size'] := 255;
  end;
  with MI.Json.A['Mapping'].AddObject do begin
    S['Prop'] := 'CustomerPrintName';
    S['Field'] := 'ClientPrintName';
    S['Type'] := 'String';
    I['Size'] := 255;
  end;
  with MI.Json.A['Mapping'].AddObject do begin
    S['Prop'] := 'TotalAmountInc';
    S['Field'] := 'TotalAmountInc';
    S['Type'] := 'Float';
  end;
  with MI.Json.A['Mapping'].AddObject do begin
    S['Prop'] := 'Lines';
    S['Field'] := 'InvoiceLine';
    S['Type'] := 'ObjectList';
    S['PropLink'] := 'SaleID';
  end;
  fList.Add(MI);

  MI := TMappingItem.Create;
  MI.TypeName := 'InvoiceLine';
  { POPULATE THE MAPPING DATA! .. }
  MI.Json.S['TableName']:= 'tblSalesLines';
  with MI.Json.A['Mapping'].AddObject do begin
    S['Prop'] := 'ID';
    S['Field'] := 'SaleLineID';
    S['Type'] := 'Int';
  end;
  with MI.Json.A['Mapping'].AddObject do begin
    S['Prop'] := 'SaleID';
    S['Field'] := 'SaleID';
    S['Type'] := 'Int';
  end;
  with MI.Json.A['Mapping'].AddObject do begin
    S['Prop'] := 'ProductName';
    S['Field'] := 'ProductName';
    S['Type'] := 'String';
    I['Size'] := 255;
  end;
  with MI.Json.A['Mapping'].AddObject do begin
    S['Prop'] := 'ProductPrintName';
    S['Field'] := 'ProductPrintName';
    S['Type'] := 'String';
    I['Size'] := 255;
  end;
  with MI.Json.A['Mapping'].AddObject do begin
    S['Prop'] := 'LinePriceInc';
    S['Field'] := 'LinePriceInc';
    S['Type'] := 'Float';
  end;
  with MI.Json.A['Mapping'].AddObject do begin
    S['Prop'] := 'QuantityShippedUOM';
    S['Field'] := 'UnitOfMeasureShipped';
    S['Type'] := 'Float';
  end;
  with MI.Json.A['Mapping'].AddObject do begin
    S['Prop'] := 'TotalLineAmount';
    S['Field'] := 'TotalLineAmount';
    S['Type'] := 'Float';
  end;
  fList.Add(MI);
end;

{ TDataItem }

constructor TDataItem.Create(const aItemTypeName: string);
begin
  fItemTypeName := aItemTypeName;
end;

destructor TDataItem.Destroy;
begin

  inherited;
end;

(*
class procedure TDataItem.Load(const aItemTypeName: string; data: TJsonObject;
  Id: integer);
var
  conn: TMyConnection;
  qry: TMyQuery;
  map, prop: TJsonObject;
  x: integer;
begin
  conn := TMyConnection.Create(nil);
  qry := TMyQuery.Create(nil);
  try
    SetConnectionProps(conn,'aus_sample_company');
    conn.Connect;
    map := TMappingList.GetMapping(aItemTypeName, conn);
    qry.SQL.Add('select * from ' + map.S['TableName']);
    qry.SQL.Add('where ' + PropToField(aItemTypeName,'ID') + ' = ' + IntToStr(ID));
    qry.Open;
    TDataItem.Load(aItemTypeName,data,conn);
    map := TMappingList.GetMapping(aItemTypeName, conn);
    for x := 0 to map.A['Mapping'].Count -1 do begin
      prop := map.A['Mapping'][x].AsObject;



    end;
  finally
    qry.Free;
    conn.Free;
  end;
end;
*)

(*
class procedure TDataItem.Load(const aItemTypeName: string; data: TJsonObject;
   aConnection: TMyConnection);
var
  map, prop: TJsonObject;
  x: integer;
begin
  data.Clear;
  data.S['_TypeName'] := aItemTypeName;
  map := TMappingList.GetMapping(aItemTypeName,aConnection);
  for x := 0 to map.A['Mapping'].Count -1 do begin
    prop := map.A['Mapping'][x].AsObject;
    if SameText(prop.S['Type'],'Int') then begin
      data.I[prop.S['Prop']] := ds.FieldByName(prop.S['Field']).AsInteger;
    end
    else if SameText(prop.S['Type'],'Float') then begin
      data.F[prop.S['Prop']] := ds.FieldByName(prop.S['Field']).AsFloat;
    end
    else if SameText(prop.S['Type'],'Bool') then begin
      data.B[prop.S['Prop']] := ds.FieldByName(prop.S['Field']).AsBoolean;
    end
    else if SameText(prop.S['Type'],'String') then begin
      data.S[prop.S['Prop']] := ds.FieldByName(prop.S['Field']).AsString;
    end
    else if SameText(prop.S['Type'],'ObjectList') then begin
     // data.A[prop.S['Prop']];
    end
  end;
end;
*)
(*
class function TDataItem.NewData(const aItemTypeName: string): TJsonObject;
var
  map, prop: TJsonObject;
  x: integer;
begin
  result := JO;
  result.S['_TypeName'] := aItemTypeName;
  map := TMappingList.GetMapping(aItemTypeName);
  for x := 0 to map.A['Mapping'].Count -1 do begin
    prop := map.A['Mapping'][x].AsObject;
    if SameText(prop.S['Type'],'Int') then begin
      result.I[prop.S['Prop']] := 0;
    end
    else if SameText(prop.S['Type'],'Float') then begin
      result.F[prop.S['Prop']] := 0;
    end
    else if SameText(prop.S['Type'],'Bool') then begin
      result.B[prop.S['Prop']] := false;
    end
    else if SameText(prop.S['Type'],'String') then begin
      result.S[prop.S['Prop']] := '';
    end
    else if SameText(prop.S['Type'],'ObjectList') then begin
      result.A[prop.S['Prop']];
    end
  end;
end;
*)

(*
class function TDataItem.PropToField(const aItemTypeName,
  aPropName: string): string;
var
  map, prop: TJsonObject;
  x: integer;
begin
  result := '';
  map := TMappingList.GetMapping(aItemTypeName);
  for x := 0 to map.A['Mapping'].Count -1 do begin
    prop := map.A['Mapping'][x].AsObject;
    if SameText(prop.S['Prop'],aPropName) then begin
      result := prop.S['Field'];
      exit;
    end;
  end;
end;
*)

(*
class function TDataItem.TableName(const aItemTypeName: string): string;
begin
  result := TMappingList.GetMapping(aItemTypeName).S['TableName'];
end;
*)

(*
class function TDataItem.List(const aItemTypeName: string; sql: string): TJsonArray;
var
  select, subSql: string;
  conn: TMyConnection;
  qry: TMyQuery;
  map, prop: TJsonObject;
  x: integer;
  obj: TJsonObject;
begin
  result := TJsonArray.Create;
  map := TMappingList.GetMapping(aItemTypeName);
  if sql <> '' then
    select := sql
  else begin
    select := 'select * from ' + map.S['TableName'];
    if map.StringExists('Filter') then
      select := select + #13#10 + 'where ' + map.S['Filter'];
  end;
  conn := TMyConnection.Create(nil);
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := conn;
    SetConnectionProps(conn,'aus_sample_company');
    conn.Connect;
    qry.SQL.Text := select;
    qry.Open;
    while not qry.Eof do begin
      obj := JO;
      obj.S['_TypeName'] := aItemTypeName;
      for x := 0 to map.A['Mapping'].Count -1 do begin
        prop := map.A['Mapping'][x].AsObject;
        if SameText(prop.S['Type'],'Int') then begin
          obj.I[prop.S['Prop']] := qry.FieldByName(prop.S['Field']).AsInteger;
        end
        else if SameText(prop.S['Type'],'Float') then begin
          obj.F[prop.S['Prop']] := qry.FieldByName(prop.S['Field']).AsFloat;
        end
        else if SameText(prop.S['Type'],'Bool') then begin
          obj.B[prop.S['Prop']] := qry.FieldByName(prop.S['Field']).AsBoolean;
        end
        else if SameText(prop.S['Type'],'String') then begin
          obj.S[prop.S['Prop']] := qry.FieldByName(prop.S['Field']).AsString;
        end
        else if SameText(prop.S['Type'],'ObjectList') then begin
          {"Prop":"Lines","Field":"InvoiceLine","Type":"ObjectList","LinkProp":"SaleID"}
          subSql :=
            'select * from ' + TDataItem.TableName(prop.S['Field']) +
            ' where ' + TDataItem.PropToField(prop.S['Field'],'SaleID') +
            ' = ' + IntToStr(qry.FieldByName(TDataItem.PropToField(aItemTypeName,'ID')).AsInteger);

          obj.A[prop.S['Prop']] := TDataItem.List(prop.S['Field'],subSQL);
        end
      end;
      result.Add(obj);
      qry.Next;
    end;

  finally
    qry.Free;
    conn.Free;
  end;
end;
*)

initialization
  fMappingList := nil;


finalization
  fMappingList.Free;

end.
