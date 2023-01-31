unit CustomFieldConfigObj;

interface

uses
  MyAccess,ERPdbComponents, CommonDbLib, BusObjBase, Contnrs;

type

  TCustFieldType = (cftUnknown, cftEmployee, cftCustomer, cftSupplier, cftAsset,
    cftProspect, cftAppointment, cftProduct);

  TCustFieldConfigList = class;
  TCustFieldConfigItem = class(TObject)
  private
    FList: TCustFieldConfigList;
    procedure SetCaption(const Value: string);
    procedure SetCombo(const Value: boolean);
    procedure SetEnabled(const Value: boolean);
    procedure SetList(const Value: TCustFieldConfigList);
    procedure SetRequired(const Value: boolean);
    function GetCaption: string;
    function GetCombo: boolean;
    function GetEnabled: boolean;
    function GetRequired: boolean;
  public
    property List: TCustFieldConfigList read FList write SetList;
    property Caption: string read GetCaption write SetCaption;
    property Required: boolean read GetRequired write SetRequired;
    property Enabled: boolean read GetEnabled write SetEnabled;
    property Combo: boolean read GetCombo write SetCombo;
  end;

  TCustFieldConfigList = class(TObject)
  private
    fCount: integer;
    fCustFieldType: TCustFieldType;
    fItem: TCustFieldConfigItem;
    function GetCount: integer;
    function GetItem(index: integer): TCustFieldConfigItem;
    function GetCustFieldType: TCustFieldType;
    procedure SetCustFieldType(const Value: TCustFieldType);
  public
    qry: TERPQuery;
    ObjName: string;
    CurrentIdx: integer;
    constructor Create(aCustFieldType: TCustFieldType= cftUnknown);
    destructor Destroy; override;
    property Count: integer read GetCount;
    property Item[index: integer]: TCustFieldConfigItem read GetItem; default;
    property CustFieldType: TCustFieldType read GetCustFieldType write SetCustFieldType;
    function FieldRequired(const index: integer): boolean;
    function FieldCaption(const index: integer): string;
  end;

  procedure AssignCustomFields(srcObj, destObj: TBusObj; destType: TCustFieldType);


implementation

uses
  DB, TypInfo, sysutils;

procedure AssignCustomFields(srcObj, destObj: TBusObj; destType: TCustFieldType);
var
  x: integer;
  s: string;
  FldObj:  TCustFieldConfigList;
begin
  FldObj:=  TCustFieldConfigList.Create(destType);
  try
    for x:= 1 to 15 do begin
      s:= 'CustFld' + IntToStr(x);
      if Assigned(GetPropInfo(srcObj,s)) and Assigned(GetPropInfo(destObj,s)) and FldObj[x].Enabled then
        SetStrProp(destObj,s,GetStrProp(srcObj,s));
    end;
    for x:= 1 to 3 do begin
      s:= 'CustDate' + IntToStr(x);
      if Assigned(GetPropInfo(srcObj,s)) and Assigned(GetPropInfo(destObj,s)) and FldObj[x].Enabled then
        SetFloatProp(destObj,s,GetFloatProp(srcObj,s));
    end;
  finally
    FldObj.Free;
  end;
end;


{ TCustFieldConfigItem }

function TCustFieldConfigItem.GetCaption: string;
begin
  result:= List.qry.FieldByName('CFLabel'+IntToStr(List.CurrentIdx)).AsString;
end;

function TCustFieldConfigItem.GetCombo: boolean;
begin
  result:= List.qry.FieldByName('CFIsCombo'+IntToStr(List.CurrentIdx)).AsBoolean;
end;

function TCustFieldConfigItem.GetEnabled: boolean;
begin
  result:= List.qry.FieldByName('CF'+List.ObjName+IntToStr(List.CurrentIdx)).AsBoolean;
end;

function TCustFieldConfigItem.GetRequired: boolean;
begin
  result:= Enabled and List.qry.FieldByName('CFIsREquired'+IntToStr(List.CurrentIdx)).AsBoolean;
end;

procedure TCustFieldConfigItem.SetCaption(const Value: string);
begin
  List.qry.Edit;
  List.qry.FieldByName('CFLabel'+IntToStr(List.CurrentIdx)).AsString:= Value;
  List.qry.Post;
end;

procedure TCustFieldConfigItem.SetCombo(const Value: boolean);
begin
  List.qry.Edit;
  List.qry.FieldByName('CFIsCombo'+IntToStr(List.CurrentIdx)).AsBoolean:= Value;
  List.qry.Post;
end;

procedure TCustFieldConfigItem.SetEnabled(const Value: boolean);
begin
  List.qry.Edit;
  List.qry.FieldByName('CF'+List.ObjName+IntToStr(List.CurrentIdx)).AsBoolean:= Value;
  List.qry.Post;
end;

procedure TCustFieldConfigItem.SetList(const Value: TCustFieldConfigList);
begin
  fList:= Value;
end;

procedure TCustFieldConfigItem.SetRequired(const Value: boolean);
begin
  List.qry.Edit;
  List.qry.FieldByName('CFIsREquired'+IntToStr(List.CurrentIdx)).AsBoolean:= Value;
  List.qry.Post;
end;

{ TCustFieldConfigList }

constructor TCustFieldConfigList.Create(aCustFieldType: TCustFieldType = cftUnknown);
begin
  fCount:= 0;
  CurrentIdx:= 0;
  fItem:= TCustFieldConfigItem.Create;
  fItem.List:= self;
  qry:= TERPQuery.Create(nil);
  qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
  qry.SQL.Text:= 'select * from tblCustomFields';
  qry.Open;
  CustFieldType:= aCustFieldType;
end;

destructor TCustFieldConfigList.Destroy;
begin
  fItem.Free;
  qry.Free;
  inherited;
end;

function TCustFieldConfigList.FieldCaption(const index: integer): string;
var
  fld: TField;
begin
  result:= '';
  fld:= qry.FindField('CFLabel' + IntToStr(index));
  if Assigned(fld) then
    result:= fld.AsString;
end;

function TCustFieldConfigList.FieldRequired(const index: integer): boolean;
var
  fld: TField;
begin
  fld:= qry.FindField('CFIsRequired' + IntToStr(index));
  result:= Assigned(fld) and fld.AsBoolean;
end;

function TCustFieldConfigList.GetCount: integer;
begin
  result:= fCount;
end;

function TCustFieldConfigList.GetCustFieldType: TCustFieldType;
begin
  result:= fCustFieldType;
end;

function TCustFieldConfigList.GetItem(
  index: integer): TCustFieldConfigItem;
begin
  if index < self.Count then begin
    CurrentIdx:= index;
    result:=  fItem;
  end
  else
    result:= nil;
end;

procedure TCustFieldConfigList.SetCustFieldType(
  const Value: TCustFieldType);
var
  x: integer;
begin
  fCustFieldType:= Value;
  case Value of
    cftUnknown: ObjName:= '';
    cftEmployee: ObjName:= 'Emp';
    cftCustomer: ObjName:= 'Cust';
    cftSupplier: ObjName:= 'Supp';
    cftAsset: ObjName:= 'Assets';
    cftProspect: ObjName:= 'Cust';
    cftAppointment: ObjName:= 'Appointment';
    cftProduct: ObjName:= 'Product';
  end;
  if ObjName <> '' then begin
    x:= 1;
    while Assigned(qry.FindField('CF'+ObjName+ IntToStr(x))) do
      inc(x);
    fCount:= x -1;
  end
  else
    fCount:= 0;
end;

end.
