unit CustomPropConfigObj;

interface

uses
  MyAccess, CommonDbLib, Contnrs, classes;


type

  TCustomPropItem = class(TObject)
  private
    fCombo: boolean;
    fEnabled: boolean;
    fCaption: string;
    fRequired: boolean;
    fPropName: string;
  public
    property Caption: string read fCaption write fCaption;
    property PropName: string read fPropName write fPropName;
    property Required: boolean read fRequired write fRequired;
    property Enabled: boolean read fEnabled write fEnabled;
    property Combo: boolean read fCombo write fCombo;
  end;

  TCustomPropConfig = class(TObject)
  private
    fList: TObjectList;
    fObj: TObject;
    fLastClassName: string;
    procedure LoadList;
    function GetCount: integer;
    function GetItem(index: integer): TCustomPropItem;
  public
    constructor Create(aObject: TObject);
    destructor Destroy; override;
    property Count: integer read GetCount;
    property Item[index: integer]: TCustomPropItem read GetItem; default;
    procedure AddDisabledPropsToList(lst: TStrings); overload;
    procedure DoAddDisabledPropsToList(obj: TObject);
    class procedure AddDisabledPropsToList(obj: TObject); overload;
    class function ClassToCustFieldType(aClassName: string): string;
  end;

  function CustPropConfigForObject(aObject: TObject): TCustomPropConfig;
  function ValidateCustomFields(aObject: TObject): boolean;


implementation

uses
  TypInfo, SysUtils, BusObjBase, DbSharedObjectsObj, ERPDbComponents;

var
  fCustomPropConfig: TCustomPropConfig;

function CustPropConfigForObject(aObject: TObject): TCustomPropConfig;
var
  PropInfo: PPropInfo;
begin
  result:= nil;
  PropInfo:= GetPropInfo(aObject,'CUSTFLD1');
  if Assigned(PropInfo) then
    { this object has custom fields }
    result:= TCustomPropConfig.Create(aObject);
end;

function ValidateCustomFields(aObject: TObject): boolean;
var
  config: TCustomPropConfig;
  PropInfo: PPropInfo;
  x: integer;
begin
  result:= true;
  config:= CustPropConfigForObject(aObject);
  if not Assigned(config) then exit;
  try
    for x:= 0 to Config.Count -1 do begin
      if config[x].Enabled and config[x].Required then begin
        PropInfo:= GetPropInfo(aObject,config[x].PropName);
        if ((PropInfo.PropType^.Kind in [tkChar,tkString,tkWChar,tkLString,tkWString]) and
            (GetStrProp(aObject,PropInfo) = '')) or
          ((PropInfo.PropType^.Kind in [tkFloat]) and
           (GetFloatProp(aObject,PropInfo) = 0)) then begin
          if aObject is TBusObjBase then begin
            TBusObjBase(aObject).AddResult(false,rssWarning,0,'Custom field ' +
              config[x].Caption + ' (' + config[x].PropName + ') can not be blank');
          end;
          result:= false;
          exit;
        end;
      end;
    end;
  finally
    config.Free;
  end;  
end;


{ TCustomPropConfig }

procedure TCustomPropConfig.AddDisabledPropsToList(lst: TStrings);
var
  x: integer;
begin
  for x:= 0 to Count-1 do begin
    if not Item[x].Enabled then
      lst.Add(Lowercase(Item[x].PropName));
  end;
end;

class procedure TCustomPropConfig.AddDisabledPropsToList(obj: TObject);
begin
  if not Assigned(GetPropInfo(obj,'CUSTFLD1')) then exit;
  if not Assigned(fCustomPropConfig) then
    fCustomPropConfig := TCustomPropConfig.Create(obj);
  fCustomPropConfig.DoAddDisabledPropsToList(obj);
end;

class function TCustomPropConfig.ClassToCustFieldType(aClassName: string): string;
begin
  result := '';
  if SameText(aClassName,'TEmployeeDetails') then result := 'Empl'
  else if SameText(aClassName,'TCustomer') then result := 'Cust'
  else if SameText(aClassName,'TSupplier') then result := 'Supp'
  else if SameText(aClassName,'TOtherProspect') then result := 'Cust'
  else if SameText(aClassName,'TOtherContact') then result := 'Cust'
  else if SameText(aClassName,'TOtherFollowUps') then result := 'Cust'
  else if SameText(aClassName,'TProspect') then result := 'Cust'
  else if SameText(aClassName,'TJob') then result := 'Cust'
  else if SameText(aClassName,'TFixedAsset') then result := 'Assets'
  else if SameText(aClassName,'TProduct') then result := 'Product'
  else if SameText(aClassName,'TAppointment') then result := 'Appointment'
  else if SameText(aClassName,'TmarketingContact') then result := 'MC';
end;

constructor TCustomPropConfig.Create(aObject: TObject);
begin
  fObj:= aObject;
  fList:= TObjectList.Create(true);
  fLastClassName := aObject.ClassName;
  LoadList;
end;

destructor TCustomPropConfig.Destroy;
begin
  fList.Free;
  inherited;
end;

procedure TCustomPropConfig.DoAddDisabledPropsToList(obj: TObject);
begin
  if not (obj is TBusObjBase) then exit;
  if not SameText(obj.ClassName,fLastClassName) then begin
    fObj := obj;
    LoadList;
  end;
  AddDisabledPropsToList(TBusObjBase(obj).ExportExcludeList);
end;

function TCustomPropConfig.GetCount: integer;
begin
  result:= fList.Count;
end;

function TCustomPropConfig.GetItem(index: integer): TCustomPropItem;
begin
  result:= TCustomPropItem(fList[index]);
end;

procedure TCustomPropConfig.LoadList;
var
  s, aPropName: string;
  custCount, dateCount: integer;
  qry: TERPQuery;
  PropInfo: PPropInfo;
  newItem: TCustomPropItem;
begin
  fList.Clear;
  fLastClassName := fObj.ClassName;
  s := ClassToCustFieldType(fLastClassName);
  if s = '' then exit;
  qry:= DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Text:= 'select * from tblcustomfields';
    qry.Open;
    custCount:= 0;
    while true do begin
      inc(custCount);
      aPropName:= 'CUSTFLD' + IntToStr(custCount);
      PropInfo:= GetPropInfo(fObj,aPropName);
      if Assigned(PropInfo) then begin
        newItem:= TCustomPropItem.Create;
        newItem.PropName:= aPropName;
        newItem.Caption:= qry.FieldByName('CFLabel' + IntToStr(custCount)).AsString;
        newItem.Required:= qry.FieldByName('CFIsRequired' + IntToStr(custCount)).AsBoolean;
        newItem.Enabled:= qry.FieldByName('CF' + s + IntToStr(custCount)).AsBoolean;
        newItem.Combo:= qry.FieldByName('CFIsCombo' + IntToStr(custCount)).AsBoolean;
        fList.Add(newItem);
      end
      else
        break;
    end;
    Dec(custCount);
    dateCount:= 0;
    while true do begin
      inc(DateCount);
      aPropName:= 'CUSTDATE' + IntToStr(dateCount);
      PropInfo:= GetPropInfo(fObj,aPropName);
      if Assigned(PropInfo) then begin
        newItem:= TCustomPropItem.Create;
        newItem.PropName:= aPropName;
        newItem.Caption:= qry.FieldByName('CFLabel' + IntToStr(dateCount + custCount)).AsString;
        newItem.Required:= qry.FieldByName('CFIsRequired' + IntToStr(dateCount + custCount)).AsBoolean;
        newItem.Enabled:= qry.FieldByName('CF' + s + IntToStr(dateCount + custCount)).AsBoolean;
        newItem.Combo:= false;
        fList.Add(newItem);
      end
      else
        break;
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

initialization
  fCustomPropConfig := nil;

finalization
  fCustomPropConfig.Free;

end.
