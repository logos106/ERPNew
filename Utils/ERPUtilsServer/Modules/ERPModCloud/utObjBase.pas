unit utObjBase;

interface

uses
  JsonObject, ConTnrs, Classes, DB, MyAccess;

type

  SchemaBase = class;
  ObjBaseClass = class of ObjBase;
  ObjBase = class(TPersistent)
  private
    fData: TJsonObject;
  protected
    function GetSchema: SchemaBase; virtual; abstract;
  public
    constructor Create;
    destructor Destroy; override;
    property Data: TJsonObject read fData write fData;
    property Schema: SchemaBase read GetSchema;
    procedure Load(aDataset: TDataSet); overload;
    procedure Load(const aID: Integer; aConnection: TMyConnection); overload;
  end;

  TPropertyDef = class;

  TPropertyDefType = (ptString, ptBoolean, ptInteger, ptFloat, ptObjectList, ptObject);

  SchemaBase = class(TPersistent)
  private
    fPropList: TObjectList;
    function GetProperties(const idx: integer): TPropertyDef;
    function GetPropertyCount: integer;
  protected
    function GetDbFilterStr: string; virtual;
    function GetDbIdFieldName: string; virtual; abstract;
    function GetDbTableName: string;  virtual; abstract;
    procedure AddProp(aType: TPropertyDefType; const aPropName, aFieldName: string; const aRequired: boolean = false; const aDesc: string = '');
    procedure AddStringProp(const aPropName, aFieldName: string; const aRequired: boolean = false; const aDesc: string = '');
    procedure AddIntegerProp(const aPropName, aFieldName: string; const aRequired: boolean = false; const aDesc: string = '');
    procedure AddFloatProp(const aPropName, aFieldName: string; const aRequired: boolean = false; const aDesc: string = '');
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property DbTableName: string read GetDbTableName;
    property DbFilterStr: string read GetDbFilterStr;
    property DbIdFieldName: string read GetDbIdFieldName;
    property PropertyCount: integer read GetPropertyCount;
    property Properties[const idx: integer]: TPropertyDef read GetProperties;
  end;

  TPropertyDef = class(TObject)
  private
    fPropertyName: string;
    fRequired: boolean;
    fPropertyDesc: string;
    fPropertyType: TPropertyDefType;
  public
    property PropertyName: string read fPropertyName write fPropertyName;
    property PropertyType: TPropertyDefType read fPropertyType write fPropertyType;
    property PropertyDescription: string read fPropertyDesc write fPropertyDesc;
    property Required: boolean read fRequired write fRequired;
  end;

  TFieldPropertyDef = class(TPropertyDef)
  private
    fDbFieldName: string;
  public
    property DbFieldName: string read fDbFieldName write fDbFieldName;
  end;

implementation

uses
  SysUtils;

{ ObjBase }

constructor ObjBase.Create;
begin
  inherited;
  fData := JO;
end;

destructor ObjBase.Destroy;
begin
  fData.Free;
  inherited;
end;

procedure ObjBase.Load(const aID: Integer; aConnection: TMyConnection);
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := aConnection;
    qry.SQL.Text := 'select * from ' + Schema.DbTableName + ' where ' + Schema.DbIdFieldName + ' = ' + IntToStr(aID);
    qry.Open;
    Load(qry);
  finally
    qry.Free;
  end;
end;

procedure ObjBase.Load(aDataset: TDataSet);
var
  x: integer;
  prop: TPropertyDef;
begin
  Data.Clear;
  Data.S['_Type'] := ClassName;
  if aDataset.IsEmpty then
    exit;
  for x := 0 to Schema.PropertyCount -1 do begin
    prop := Schema.Properties[x];
    if prop is TFieldPropertyDef then begin
      case prop.fPropertyType of
        ptString: Data.S[prop.fPropertyName] := aDataset.FieldByName(TFieldPropertyDef(prop).DbFieldName).AsString;
        ptBoolean: Data.B[prop.fPropertyName] := aDataset.FieldByName(TFieldPropertyDef(prop).DbFieldName).AsBoolean;
        ptInteger: Data.I[prop.fPropertyName] := aDataset.FieldByName(TFieldPropertyDef(prop).DbFieldName).AsInteger;
        ptFloat: Data.F[prop.fPropertyName] := aDataset.FieldByName(TFieldPropertyDef(prop).DbFieldName).AsFloat;
        ptObjectList: ;
        ptObject: ;
      end;

    end;


  end;
end;

{ SchemaBase }

procedure SchemaBase.AddFloatProp(const aPropName, aFieldName: string;
  const aRequired: boolean; const aDesc: string );
begin
  addProp(ptFloat, aPropName, aFieldName, aRequired, aDesc);
end;

procedure SchemaBase.AddIntegerProp(const aPropName, aFieldName: string;
  const aRequired: boolean; const aDesc: string);
begin
  addProp(ptInteger, aPropName, aFieldName, aRequired, aDesc);
end;

procedure SchemaBase.AddProp(aType: TPropertyDefType;
  const aPropName, aFieldName: string;
  const aRequired: boolean; const aDesc: string);
var
  prop: TPropertyDef;
begin
  if aFieldName <> '' then begin
    prop := TFieldPropertyDef.Create;
    TFieldPropertyDef(Prop).DbFieldName := aFieldName;
  end
  else
    prop := TPropertyDef.Create;
  prop.PropertyType := aType;
  prop.PropertyName := aPropName;
  prop.PropertyDescription := aDesc;
  prop.Required := aRequired;
  fPropList.Add(prop);
end;

procedure SchemaBase.AddStringProp(const aPropName, aFieldName: string;
  const aRequired: boolean; const aDesc: string);
begin
  addProp(ptString, aPropName, aFieldName, aRequired, aDesc);
end;

constructor SchemaBase.Create;
begin
  fPropList := TObjectList.Create;
end;

destructor SchemaBase.Destroy;
begin
  fPropList.Free;
  inherited;
end;

function SchemaBase.GetDbFilterStr: string;
begin
  result := '';
end;

function SchemaBase.GetProperties(const idx: integer): TPropertyDef;
begin
  result := TPropertyDef(fPropList[idx]);
end;

function SchemaBase.GetPropertyCount: integer;
begin
  result := fPropList.Count;
end;

end.
