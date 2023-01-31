unit BusObjSchemaLib;

interface

uses
  JsonObject, classes, contnrs;

type

  TBOSchema = class
  private
    fJson: TJsonObject;
    function GetSchemaAsString: string;
    procedure SetSchemaAsString(const Value: string);
    function GetRefType(index: integer): TJsonObject;
  public
    IgnoreFieldList: TStringList;
    constructor Create;
    destructor Destroy; override;
    property SchemaAsString: string read GetSchemaAsString write SetSchemaAsString;
    property Schema: TJsonObject read fJson;
    function IsRefProp(aPropName: string): boolean;
    function RefTypeByProperty(aPropName: string): TJsonObject;
    function GetKeyStringPropertyName(aKeyStringProperty: string; Ref: TJsonObject): string;
    function GetIdPropertyName(Ref: TJsonObject): string;
    class procedure AddRefType(var s: string; const RefType, RefProperty, LinkProperty, LinkRefProperty: string); //overload;
//    class procedure AddPropSeqList(var s: string; PropList: string);
    function RefTypesCount: integer;
    property RefType[index: integer]: TJsonObject read GetRefType;
  end;

  TBOSchemaList = class
  private
    fList: TObjectList;
  public
    constructor Create;
    destructor Destroy; override;
    function ByTypeName(aTypeName: string): TBOSchema;
    function Add(SchemaText: string): TBOSchema;
  end;

implementation

uses
  sysutils;

{ TBOSchema }

//class procedure TBOSchema.AddPropSeqList(var s: string; PropList: string);
//var
//  obj: TJsonObject;
//  sl: TStringList;
//  x: integer;
//begin
//  obj:= JO(s);
//  sl:= TStringList.Create;
//  try
//    sl.CommaText:= PropList;
//    for x:= 0 to sl.Count -1 do
//      obj.A['FieldOrderList'].Add(sl[x]);
//
//    s:= obj.AsString;
//  finally
//    obj.Free;
//    sl.Free;
//  end;
//end;

class procedure TBOSchema.AddRefType(var s: string; const RefType, RefProperty,
  LinkProperty, LinkRefProperty: string);
var
  obj, ref: TJsonObject;
  x: integer;
begin
  ref:= nil;
  obj:= JO(s);
  try
    for x := 0 to obj.A['RefTypes'].Count -1 do begin
      if SameText(obj.A['RefTypes'].Items[x].AsObject.S['Type'],RefType) and
         SameText(obj.A['RefTypes'].Items[x].AsObject.S['Property'],RefProperty) then begin
        ref:= obj.A['RefTypes'].Items[x].AsObject;
        break;
      end;
    end;
    if not Assigned(ref) then begin
      ref:= JO('{"Type":"' + RefType + '"}');
      ref.S['Property']:= RefProperty;
      obj.A['RefTypes'].Add(ref);
    end;
    ref.A['Links'].Add(JO('{"Property":"'+LinkProperty+'","RefProperty":"'+LinkRefProperty+'"}'));

    s:= obj.AsString;
  finally
    obj.Free;
  end;
end;

constructor TBOSchema.Create;
begin
  fJson:= TJsonObject.Create;
  IgnoreFieldList:= TStringList.Create;
end;

destructor TBOSchema.Destroy;
begin
  fJson.Free;
  IgnoreFieldList.Free;
  inherited;
end;

function TBOSchema.GetSchemaAsString: string;
begin
  result:= fJson.AsString;
end;

function TBOSchema.IsRefProp(aPropName: string): boolean;
var
  Ref: TJsonObject;
begin
  Ref:= RefTypeByProperty(aPropName);
  result := Assigned(Ref);
end;

function TBOSchema.GetIdPropertyName(Ref: TJsonObject): string;
var
  LinkIdx: integer;
  Link: TJsonObject;
begin
  result:= '';
  for LinkIdx := 0 to Ref.A['Links'].Count -1 do begin
    Link:= Ref.A['Links'].Items[LinkIdx].AsObject;
    if SameText(Link.S['RefProperty'],'ID') then begin
      result:= Link.S['Property'];
      exit;
    end;
  end;
end;

function TBOSchema.GetKeyStringPropertyName(aKeyStringProperty: string;
  Ref: TJsonObject): string;
var
  LinkIdx: integer;
  Link: TJsonObject;
begin
  result:= '';
  for LinkIdx := 0 to Ref.A['Links'].Count -1 do begin
    Link:= Ref.A['Links'].Items[LinkIdx].AsObject;
    if SameText(Link.S['RefProperty'],aKeyStringProperty) then begin
      result:= Link.S['Property'];
      exit;
    end;
  end;
end;

function TBOSchema.GetRefType(index: integer): TJsonObject;
begin
  result:= fJson.A['RefTypes'].Items[index].AsObject;
end;

function TBOSchema.RefTypeByProperty(aPropName: string): TJsonObject;
var
  x, y: integer;
  Ref, Link: TJsonObject;
begin
  result:= nil;
  for x := 0 to Schema.A['RefTypes'].Count -1 do begin
    Ref:= Schema.A['RefTypes'].Items[x].AsObject;
    for y := 0 to Ref.A['Links'].Count -1 do begin
      Link:= Ref.A['Links'].Items[y].AsObject;
      if SameText(Link.S['Property'], aPropName) then begin
        result:= Ref;
        exit;
      end;
    end;
  end;
end;

function TBOSchema.RefTypesCount: integer;
begin
  result:= fJson.A['RefTypes'].Count;
end;

procedure TBOSchema.SetSchemaAsString(const Value: string);
var
  x: integer;
begin
  fJson.AsString:= Value;
  IgnoreFieldList.Clear;
  for x := 0 to fJson.A['RefTypes'].Count -1 do begin
    IgnoreFieldList.Add(fJson.A['RefTypes'].Items[x].AsObject.S['Property']);
  end;
end;

{ TBOSchemaList }

function TBOSchemaList.Add(SchemaText: string): TBOSchema;
begin
  result:= TBOSchema.Create;
  result.SchemaAsString:= SchemaText;
  fList.Add(result);
end;

function TBOSchemaList.ByTypeName(aTypeName: string): TBOSchema;
var
  x: integer;
  obj: TBOSchema;
begin
  result:= nil;
  for x := 0 to fList.Count -1 do begin
    obj:= TBOSchema(fList[x]);
    if SameText(aTypeName,obj.Schema.S['type']) then begin
      result:= obj;
      break;
    end;
  end;
end;

constructor TBOSchemaList.Create;
begin
  fList:= TObjectList.Create(true);
end;

destructor TBOSchemaList.Destroy;
begin
  fList.Free;
  inherited;
end;

end.
