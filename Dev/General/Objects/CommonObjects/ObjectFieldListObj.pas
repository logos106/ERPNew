unit ObjectFieldListObj;

{
  Maintains a list of Business Objects and the field (property) names that are
  to be used when exporting BO XML.

  A minimum set of fields to include in XML is stored in tblBusObjExportProp
  that will be used by default and TObjectFieldList provides methods to
  add to or replace this field list.

  A TObjectFieldList global inastance will me added to AppEnv so all business
  objects can access it from there.
}

interface

uses
  Contnrs;

type

  TObjectFieldItem = class(TObject)
  private
    FObjectClassId: integer;
    FObjectFieldName: string;
    procedure SetObjectClassId(const Value: integer);
    procedure SetObjectFieldName(const Value: string);
  public
    property ObjectClassId: integer read FObjectClassId write SetObjectClassId;
    property ObjectFieldName: string read FObjectFieldName write SetObjectFieldName;
  end;

  TObjectClassItem = class(TObject)
  private
    FObjectClassId: integer;
    FObjectClassName: string;
    FEmpty: boolean;
    procedure SetObjectClassId(const Value: integer);
    procedure SetObjectClassName(const Value: string);
    procedure SetEmpty(const Value: boolean);
  public
    property ObjectClassId: integer read FObjectClassId write SetObjectClassId;
    property ObjectClassName: string read FObjectClassName write SetObjectClassName;
    property Empty: boolean read FEmpty write SetEmpty;
  end;


  TObjectFieldList = class(TObject)
  private
    FieldList: TObjectList;
    ObjectList: TObjectList;
    fLastId: integer;
    function GetObjectClassItem(const aObjectClassName: string): TObjectClassItem;
    function AddObjectClassItem(const aObjectClassName: string): TObjectClassItem;
    function NextId: integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddObjectField(const aObjectClassName, aFieldName: string);
    function InList(const aObjectClassName, aFieldName: string): boolean;
    function ListEmpty(const aObjectClassName: string): boolean;
    procedure AddObjectFields(const aObjectClassName, aFieldList: string);
    procedure ClearObjectFields(const aObjectClassName: string);
    procedure LoadObjectDefaults(const aObjectClassName: string);
    property ObjectClassItem[const aObjectClassName: string]: TObjectClassItem read GetObjectClassItem;
  end;



implementation

uses
  CommonDbLib, MyAccess,ERPdbComponents, SysUtils, Classes;


{ TObjectFieldItem }

procedure TObjectFieldItem.SetObjectClassId(const Value: integer);
begin
  FObjectClassId := Value;
end;

procedure TObjectFieldItem.SetObjectFieldName(const Value: string);
begin
  FObjectFieldName := Value;
end;

{ TObjectClassItem }

procedure TObjectClassItem.SetEmpty(const Value: boolean);
begin
  FEmpty := Value;
end;

procedure TObjectClassItem.SetObjectClassId(const Value: integer);
begin
  FObjectClassId := Value;
end;

procedure TObjectClassItem.SetObjectClassName(const Value: string);
begin
  FObjectClassName := Value;
end;

{ TObjectFieldList }

constructor TObjectFieldList.Create;
begin
  inherited;
  FieldList:= TObjectList.Create(true);
  ObjectList:= TObjectList.Create(true);
  fLastId:= 0;
end;

destructor TObjectFieldList.Destroy;
begin
  FreeAndNil(FieldList);
  FreeAndNil(ObjectList);
  inherited;
end;

procedure TObjectFieldList.AddObjectField(const aObjectClassName, aFieldName: string);
var
  ClassItem: TObjectClassItem;
  FieldItem: TObjectFieldItem;
begin
  ClassItem:= ObjectClassItem[aObjectClassName];
  FieldItem:= TObjectFieldItem.Create;
  FieldItem.ObjectClassId:= ClassItem.ObjectClassId;
  FieldItem.ObjectFieldName:= LowerCase(aFieldName);
  FieldList.Add(FieldItem);
  ClassItem.Empty:= false;
end;

{ aFieldList format: "FieldOne|FieldTwo|FieldThree" }
procedure TObjectFieldList.AddObjectFields(const aObjectClassName, aFieldList: string);
var
  SL: TStringList;
  x: integer;
begin
  SL:= TStringList.Create;
  try
    SL.Delimiter:= '|';
    SL.DelimitedText:= aFieldList;
    for x:= 0 to SL.Count -1 do begin
      self.AddObjectField(aObjectClassName, SL[x]);
    end;
  finally
    FreeAndNil(SL);
  end;
end;

procedure TObjectFieldList.ClearObjectFields(const aObjectClassName: string);
var
  ClassItem: TObjectClassItem;
  x: integer;
begin
  ClassItem:= self.ObjectClassItem[aObjectClassName];
  x:= 0;
  while x < FieldList.Count do begin
    if (TObjectFieldItem(FieldList[x]).ObjectClassId = ClassItem.ObjectClassId) then
      FieldList.Delete(x)
    else
      Inc(x);
  end;
  ClassItem.Empty:= true;
end;

function TObjectFieldList.InList(const aObjectClassName,  aFieldName: string): boolean;
var
  ObjectClassId: integer;
  x: integer;
begin
  result:= false;
  ObjectClassId:= ObjectClassItem[aObjectClassName].ObjectClassId;
  for x:= 0 to FieldList.Count -1 do begin
    if (TObjectFieldItem(FieldList[x]).ObjectClassId = ObjectClassId) and
      (TObjectFieldItem(FieldList[x]).ObjectFieldName = LowerCase(aFieldName)) then begin
      result:= true;
      break;
    end;
  end;
end;

function TObjectFieldList.ListEmpty(const aObjectClassName: string): boolean;
begin
  result:= ObjectClassItem[aObjectClassName].Empty;
end;

procedure TObjectFieldList.LoadObjectDefaults(const aObjectClassName: string);
var
  qry: TERPQuery;
begin
  ClearObjectFields(aObjectClassName);
  qry:= CommonDbLib.TempMyQuery;
  try
    qry.SQL.Text:=
      'SELECT PropertyName FROM tblBusObjExportProp ' +
      'WHERE BusinessObjectName = ' + QuotedStr(aObjectClassName);
    qry.Open;
    while not qry.Eof do begin
      self.AddObjectField(aObjectClassName, qry.FieldByName('PropertyName').AsString);
      qry.Next;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TObjectFieldList.GetObjectClassItem(const aObjectClassName: string): TObjectClassItem;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to ObjectList.Count -1 do begin
    if TObjectClassItem(ObjectList[x]).ObjectClassName = LowerCase(aObjectClassName) then begin
      result:= TObjectClassItem(ObjectList[x]);
      break;
    end;
  end;
  if not Assigned(result) then begin
    result:= AddObjectClassItem(aObjectClassName);
    LoadObjectDefaults(aObjectClassName);
  end;
end;

function TObjectFieldList.AddObjectClassItem(const aObjectClassName: string): TObjectClassItem;
begin
  result:= TObjectClassItem.Create;
  result.ObjectClassId:= NextId;
  result.ObjectClassName:= LowerCase(aObjectClassName);
  result.Empty:= false;
  ObjectList.Add(result);
end;

function TObjectFieldList.NextId: integer;
begin
  Inc(fLastId);
  result:= fLastId;
end;

end.
