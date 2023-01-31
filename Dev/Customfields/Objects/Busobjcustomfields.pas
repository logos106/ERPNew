unit Busobjcustomfields;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  21/10/11  1.00.00  BJ  Initial Version.
}

interface

uses BusObjBase, DB, Classes, XMLIntf, BusObjDeletedItem;

type
  TListType =
    (ltNone, ltCustomer, ltSalesLines, ltOrderLines, ltSupplier, ltRepairParts,
      ltEquipment , ltCAR, ltContact, ltRepair, ltSales, ltLeads,
      ltSmartorderLines, ltProducts, ltSupportLines,ltCash , ltCashlines, ltExpenseLines,
      ltAccountsOverview, ltAppointmentList, ltAppointmentTimeLog, ltDepositList, ltChequeList,
      ltReconciliationlist, ltStockAdjustmentList, ltStockTransferList, ltPaymentList, ltCustomerPaymentList,
      ltSupplierPaymentList, ltStatementList, ltPayrollOverview, ltTimesheetList, ltReceiptClaimList,
      ltPurchaseOrderList, ltCreditList, ltPurchaseOverview, ltSalesOverview, ltSalesOrderList,
      ltInvoiceList, ltQuoteList, ltRefundList, ltContactOverview, ltEmployeeList, ltCustomerLIst,
      ltSupplierList, ltLeadList, ltTaskList, ltCRMList, ltInventoryOverview, ltProductList, ltOrder);

  TCustomFieldListDropDown = class(TMSBusObj)
  private
    function GetCustomFieldlistId: Integer;
    function GetText: string;
    procedure SetCustomFieldlistId(const Value: Integer);
    procedure SetText(const Value: string);
    function GetActive: Boolean;
    procedure SetActive(const Value: Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterOpen(Sender: TDatasetBusObj): Boolean; override;
  public
    procedure DoFieldOnChange(Sender: TField); override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    function Delete: boolean; overload; override;
  published
    property CustomFieldlistId: Integer read GetCustomFieldlistId write SetCustomFieldlistId;
    property Text: string read GetText write SetText;
    property Active: Boolean read GetActive write SetActive;
  end;

//  TDeletedCFListDropDown = class(TDeletedItem)
//  public
//    class function GetDeletedTablename: string; override;
//  end;

  TCustomFieldList = class(TMSBusObj)
  private
    AddingNew: Boolean;
    fsAlldata :String;
    function GetDescription: string;
    function GetisCombo: Boolean;
    function GetActive: Boolean;
    function GetListType: String;
    function GetDatatype: string;
    function GetWidth: string;

    procedure SetDescription(const Value: string);
    procedure SetisCombo(const Value: Boolean);
    procedure SetActive(const Value: Boolean);
    procedure SetListType(const Value: String);
    procedure SetDatatype(const Value: string);
    procedure SetWidth(const Value: string);
    function GetDropdown: TCustomFieldListDropDown;
    procedure TableStructureSQLCallback(const Sender: TBusObj;      var Abort: Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
  public
    procedure DoFieldOnChange(Sender: TField); override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    class function GetKeyStringField: string; override;
    class function GetKeyStringProperty: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    Function TableStructureSQL:String;
  published
    property Description: string read GetDescription write SetDescription;
    property IsCombo: Boolean read GetisCombo write SetisCombo;
    property Active: Boolean read GetActive write SetActive;
    property ListType: String read GetListType write SetListType;
    property DataType: string read GetDatatype write SetDatatype;
    property Width: string read GetWidth write SetWidth;
    property Dropdown: TCustomFieldListDropDown read GetDropdown;
  end;

  TSaleSLinesCustomFieldList  = class(TCustomFieldList)
  Public
    constructor Create(AOwner: TComponent); override;
  end;

  TSmartOrderlinesCustomFieldList  = class(TCustomFieldList)
  Public
    constructor Create(AOwner: TComponent); override;
  end;

  TSupportLinesCustomFieldList  = class(TCustomFieldList)
  Public
    constructor Create(AOwner: TComponent); override;
  end;

  TCustomFieldValues = class(TMSBusObj)
  private
    fbPopulatingAll: Boolean;
    function GetMasterID: Integer;
    function GetCustomFieldlistId: Integer;
    function GetValue: string;
    procedure SetMasterID(const Value: Integer);
    procedure SetCustomFieldlistId(const Value: Integer);
    procedure SetValue(const Value: string);
    function GetCustomFieldEntry: TCustomFieldList;
    function GetDescription: string;
    procedure SetDescription(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterOpen(Sender: TDatasetBusObj): Boolean; override;
    function GetMastername: String; Virtual;
    procedure SetMasterName(const Value: String); Virtual;
  public
    procedure DoFieldOnChange(Sender: TField); override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    Procedure PopulateAll(TransMasterID: Integer);
    Property CustomFieldEntry: TCustomFieldList REad GetCustomFieldEntry;
    procedure OnBeforeDataIdChange; Override;
    Property PopulatingAll: Boolean read fbPopulatingAll write fbPopulatingAll;
    class function _Schema: string; override;
    property MasterID: Integer read GetMasterID write SetMasterID;
  published
    Property MasterName :String read GetMastername write SetMasterName;
    property CustomFieldlistId: Integer read GetCustomFieldlistId write SetCustomFieldlistId;
    property Description: string read GetDescription write SetDescription;
    property Value: string read GetValue write SetValue;

  end;

  TClientCustomFieldValues = class(TCustomFieldValues)
  Private
  Protected
    function GetMastername: String; Override;
    procedure SetMasterName(const Value: String); Override;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetBusObjectTablename: string; override;
  end;

  TContactCustomFieldValues = class(TCustomFieldValues)
  Private
  Protected
    function GetMastername: String; Override;
    procedure SetMasterName(const Value: String); Override;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetBusObjectTablename: string; override;
  end;

  TRepairCustomFieldValues = class(TCustomFieldValues)
  Private
  Protected
    function GetMastername: String; Override;
    procedure SetMasterName(const Value: String); Override;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetBusObjectTablename: string; override;
  end;

  TSupplierCustomFieldValues = class(TClientCustomfieldValues)
  Private
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TCustomerCustomFieldValues = class(TClientCustomfieldValues)
  Private
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TProductCustomFieldValues = class(TCustomFieldValues)
  Private
  Protected
    function GetMastername: String;Override;
    procedure SetMasterName(const Value: String);Override;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetBusObjectTablename: string; override;
  end;

 TEquipmentCustomfieldValues = class(TCustomFieldValues)
  Private
  Protected
    function GetMastername: String; Override;
    procedure SetMasterName(const Value: String); Override;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetBusObjectTablename: string; override;
  end;

 TCAROutComeReviewOptions = class(TCustomFieldValues)
  Private
    function getValueSelected: Boolean;
    procedure SetValueSelected(const Value: Boolean);
  Protected
    function GetMastername: String; Override;
    procedure SetMasterName(const Value: String); Override;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetBusObjectTablename: string; override;
  Published
    Property ValueSelected :Boolean read getValueSelected Write SetValueSelected;
  end;

 TLeadCustomfieldValues = class(TCustomFieldValues)
  Private
  Protected
    function GetMastername: String; Override;
    procedure SetMasterName(const Value: String); Override;
  public
    constructor Create(AOwner: TComponent); override;
    class function GetBusObjectTablename: string; override;
  end;

//  TSupportLogLinesCustomFieldValues = class(TCustomFieldValues)
//  Private
//  Protected
//    function GetMastername: String; Override;
//    procedure SetMasterName(const Value: String); Override;
//  public
//    constructor Create(AOwner: TComponent); override;
//    class function GetBusObjectTablename: string; override;
//  end;



function ListTypetoString(fListtype: TListType): string;
function ListTypetoTablename(fListtype: TListType): string;
function StringToListType(s: string): TListType;

implementation

uses tcDataUtils, CommonLib, sysutils, BusObjConst, variants, BusObjSchemaLib,
  BusObjClient, BusObjContact, BusObjRepairs, BusobjProduct, BusObjEquipment,
  BusobjCAR, BusObjMarketingLeads, BusObjectListObj;

type
  TListTypeToStringArray = array[TListType] of string;
const
  ListTypeToStringArray : TListTypeToStringArray =
    ('ltNone', 'ltCustomer', 'ltSalesLines', 'ltOrderLines', 'ltSupplier',
    'ltRepairParts' , 'ltEquipment' , 'ltCAR', 'ltContact', 'ltRepair',
    'ltSales', 'ltLeads' , 'ltSmartorderLines' , 'ltProducts', 'ltSupportLines', 'ltCash' , 'ltCashlines', 'ltExpenseLines',
    'ltAccountsOverview', 'ltAppointmentList', 'ltAppointmentTimeLog', 'ltDepositList', 'ltChequeList',
    'ltReconciliationlist', 'ltStockAdjustmentList', 'ltStockTransferList', 'ltPaymentList', 'ltCustomerPaymentList',
    'ltSupplierPaymentList', 'ltStatementList', 'ltPayrollOverview', 'ltTimesheetList', 'ltReceiptClaimList',
    'ltPurchaseOrderList', 'ltCreditList', 'ltPurchaseOverview', 'ltSalesOverview', 'ltSalesOrderList',
    'ltInvoiceList', 'ltQuoteList', 'ltRefundList', 'ltContactOverview', 'ltEmployeeList', 'ltCustomerLIst',
    'ltSupplierList', 'ltLeadList', 'ltTaskList', 'ltCRMList', 'ltInventoryOverview', 'ltProductList', 'ltOrder');

Function ListTypetoString(fListtype: TListType): String;
begin
  Result := ListTypeToStringArray[fListType];
end;
function ListTypetoTablename(fListtype: TListType): string;
begin
         if fListtype = ltCustomer  then result := TCustomerCustomFieldValues.GetBusObjectTablename
    else if fListtype = ltSupplier  then result := TSupplierCustomFieldValues.GetBusObjectTablename
    else if fListtype = ltEquipment then result := TEquipmentCustomfieldValues.GetBusObjectTablename
    else if fListtype = ltContact   then result := TContactCustomFieldValues.GetBusObjectTablename
    else if fListtype = ltRepair    then result := TRepairCustomFieldValues.GetBusObjectTablename
    else if fListtype = ltLeads     then result := TLeadCustomfieldValues.GetBusObjectTablename
    else if fListtype = ltProducts  then result := TProductCustomFieldValues.GetBusObjectTablename
    else if fListtype = ltCAR       then result := TCAROutComeReviewOptions.GetBusObjectTablename
//    else if fListType = ltSupportLines then result := TSupportLogLinesCustomFieldValues.GetBusObjectTablename
    else result := '';
end;
function StringToListType(s: string): TListType;
var
  idx : TListType;
begin
  for idx := Low(TListType) to High(TListType) do
    if SameText(ListTypeToStringArray[idx], s) then
    begin
      Result := idx;
      exit;
    end;
  raise Exception.Create('Unknown Custom Field type: "' + s + '"');
end;

{ TCustomFieldList }

constructor TCustomFieldList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AddingNew := False;
  fBusObjectTypeDescription := 'CustomFieldList';
  fSQL := 'SELECT * FROM tblcustomfieldlist';
end;

destructor TCustomFieldList.Destroy;
begin
  inherited;
end;

procedure TCustomFieldList.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'Description');
  SetBooleanPropertyFromNode(node, 'isCombo');
  SetBooleanPropertyFromNode(node, 'Active');
  SetBooleanPropertyFromNode(node, 'ListType');
  SetPropertyFromNode(node, 'Datatype');
end;

procedure TCustomFieldList.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'Description', Description);
  AddXMLNode(node, 'isCombo', IsCombo);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'ListType', ListType);
  AddXMLNode(node, 'Datatype', DataType);
end;

function TCustomFieldList.ValidateData: Boolean;
begin
  result := False;
  Resultstatus.Clear;
  if DataType = '' then begin
    AddResult(False, rssWarning, 0, 'Data Type is blank');
    Exit;
  end;
  if not((DataType = 'ftString') or (DataType = 'ftBoolean') or (DataType = 'ftFloat') or
    (DataType = 'ftDateTime')) then begin
    AddResult(False, rssWarning, 0, 'Unknown Data Type "' + DataType + '"');
    Exit;
  end;
//  if not (StringToListType(ListType) in [ltCustomer, ltSalesLines, ltOrderLines, ltSupplier, ltRepairParts , ltEquipment, ltCAR, ltContact, ltRepair, ltSales, ltLeads , ltSmartorderLines , ltProducts, ltSupportLines,ltCash, ltCashlines, ltExpenseLines]) then begin
  if ((StringToListType(ListType) < ltNone) or (StringToListType(ListType) > ltOrder)) then begin
    AddResult(False, rssWarning, 0, 'Unknown List Type "' + ListType + '"');
    Exit;
  end;
  if Description = '' then begin
    AddResult(False, rssWarning, 0, 'Description cannot be blank');
    Exit;
  end;
  if IsCombo then
    if Dropdown.count = 0 then begin
      AddResult(False, rssWarning, 0, 'Drop down is enabled for ' + quotedstr(Description) +
        ' and none provided. Please Provide the Dropdown');
      Exit;
    end;

  result := True;
end;

function TCustomFieldList.Save: Boolean;
begin
  result := False;
  if not ValidateData then
    Exit;
  result := inherited Save;
end;

procedure TCustomFieldList.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  if ID <> 0 then begin
    Dropdown.closedb;
    Dropdown;
  end;
end;

procedure TCustomFieldList.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then
      Exit; // we are only interested in data fields.
  inherited;

end;

function TCustomFieldList.GetSQL: string;
begin
  result := inherited GetSQL;
end;

class function TCustomFieldList.GetIDField: string;
begin
  result := 'CFID'
end;

class function TCustomFieldList.GetBusObjectTablename: string;
begin
  result := 'tblcustomfieldlist';
end;

function TCustomFieldList.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  AddingNew := True;
  try
    result := inherited DoAfterInsert(Sender);
    if not result then
      Exit;
    DataType := 'ftString';
    PostDb;
    Dropdown;
    Description := '';
  finally
    AddingNew := False;
  end;
end;

function TCustomFieldList.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := True;
  if AddingNew then
    Exit;
  result := inherited DoAfterPost(Sender);
  if not result then
    Exit;
  if (trim(Description) = '') and ((DataType = '') or (DataType = 'ftString')) and
    (Dropdown.count = 0) then begin
    Delete;
    result := False;
    Exit;
  end;
end;

function TCustomFieldList.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := True;
  if AddingNew then
    Exit;
  result := inherited DoBeforePost(Sender);
end;

{ Property Functions }
function TCustomFieldList.GetDescription: string;
begin
  result := GetStringField('Description');
end;

function TCustomFieldList.GetDropdown: TCustomFieldListDropDown;
begin
  result := TCustomFieldListDropDown(GetcontainerComponent(TCustomFieldListDropDown,
    'CustomFieldlistId = ' + IntToStr(ID)));
end;

function TCustomFieldList.GetisCombo: Boolean;
begin
  result := GetBooleanField('isCombo');
end;
function TCustomFieldList.GetActive: Boolean;
begin
  result := GetBooleanField('Active');
end;

class function TCustomFieldList.GetKeyStringField: string;
begin
  result := 'Description';
end;

class function TCustomFieldList.GetKeyStringProperty: string;
begin
  result := 'Description';
end;

function TCustomFieldList.GetListType: String;
begin
  result := GetStringField('ListType');
end;

function TCustomFieldList.GetDatatype: string;
begin
  result := GetStringField('Datatype');
end;

function TCustomFieldList.GetWidth: string;
begin
  result := GetStringField('Width');
end;

procedure TCustomFieldList.SetDescription(const Value: string);
begin
  SetStringField('Description', Value);
end;

procedure TCustomFieldList.SetisCombo(const Value: Boolean);
begin
  SetBooleanField('isCombo', Value);
end;
procedure TCustomFieldList.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TCustomFieldList.SetListType(const Value: String);
begin
  SetStringField('ListType', Value);
end;

function TCustomFieldList.TableStructureSQL: String;
begin
  fsAlldata := '';
  IterateRecords(TableStructureSQLCallback);
  Result := fsAlldata;
end;
procedure TCustomFieldList.TableStructureSQLCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if Sender is TCustomFieldList then begin
    fsAlldata  := fsAlldata  + 'CUSTFLDLIST' + trim(inttostr(ID))+'  VARCHAR(255) NULL DEFAULT NULL,';
          (*if DataType = 'ftString'   then fsAlldata  := fsAlldata  + 'CUSTFLDLIST' + trim(inttostr(ID))+'  VARCHAR(255) NULL DEFAULT NULL,'
     else if DataType = 'ftBoolean'  then fsAlldata  := fsAlldata  + 'CUSTFLDLIST' + trim(inttostr(ID))+'  ENUM("T","F") default "T",'
     else if DataType = 'ftFloat'    then fsAlldata  := fsAlldata  + 'CUSTFLDLIST' + trim(inttostr(ID))+'  DOUBLE NOT NULL DEFAULT 0,'
     else if DataType = 'ftDateTime' then fsAlldata  := fsAlldata  + 'CUSTFLDLIST' + trim(inttostr(ID))+'  DATETime NULL DEFAULT NULL,'*)
  end;
end;

procedure TCustomFieldList.SetDatatype(const Value: string);
begin
  SetStringField('Datatype', Value);
end;

procedure TCustomFieldList.SetWidth(const Value: string);
begin
  SetStringField('Width', Value);
end;

{ TCustomFieldListDropDowns }

constructor TCustomFieldListDropDown.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'CustomFieldListDropDowns';
  fSQL := 'SELECT * FROM tblcustomfieldlistdropdowns';
  self.fIsChild := True;
  self.ExportExcludeList.Add('customfieldlistid');
  fIsList := True;
end;

function TCustomFieldListDropDown.Delete: boolean;
var
  msg: string;
begin
  result:= true;
  if (not CanDelete) then
  begin
    self.ResultStatus.AddItem(false, rssError, 0, NoRigtsMsg('Delete'));
      Result := False;
    exit;
  end;
  if not TDeletedItem.AddDeleted(self,msg) then
    result := false;
end;

destructor TCustomFieldListDropDown.Destroy;
begin
  inherited;
end;

procedure TCustomFieldListDropDown.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'CustomFieldlistId');
  SetPropertyFromNode(node, 'Text');
  SetBooleanPropertyFromNode(node, 'Active');
end;

procedure TCustomFieldListDropDown.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'CustomFieldlistId', CustomFieldlistId);
  AddXMLNode(node, 'Text', Text);
  AddXMLNode(node, 'Active', Active);
end;

function TCustomFieldListDropDown.ValidateData: Boolean;
begin
  result := False;
  if self.CustomFieldlistId = 0 then begin
    AddResult(False, rssWarning, 0, 'Custom Field List ID is blank');
    Exit;
  end;
  if Text = '' then begin
    AddResult(False, rssWarning, 0, 'Text is blank');
    Exit;
  end;
  result := True;
end;

function TCustomFieldListDropDown.Save: Boolean;
begin
  result := False;
  if not ValidateData then
    Exit;
  result := inherited Save;
end;

procedure TCustomFieldListDropDown.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TCustomFieldListDropDown.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TCustomFieldListDropDown.GetSQL: string;
begin
  result := inherited GetSQL;
end;

class function TCustomFieldListDropDown.GetIDField: string;
begin
  result := 'DropDownID'
end;

class function TCustomFieldListDropDown.GetBusObjectTablename: string;
begin
  result := 'tblcustomfieldlistdropdowns';
end;

function TCustomFieldListDropDown.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then
    Exit;
  if Assigned(self.Owner) then
    if self.Owner is TCustomFieldList then
      CustomFieldlistId := TCustomFieldList(self.Owner).ID;
end;

function TCustomFieldListDropDown.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterOpen(Sender);
  if not result then
    Exit;

end;

function TCustomFieldListDropDown.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterPost(Sender);
  if not result then
    Exit;
  if count > 0 then
    if Assigned(self.Owner) then
      if self.Owner is TCustomFieldList then begin
        if not TCustomFieldList(self.Owner).IsCombo then
          TCustomFieldList(self.Owner).IsCombo := True;
        if TCustomFieldList(self.Owner).DataType <> 'ftString' then
          TCustomFieldList(self.Owner).DataType := 'ftString';
        TCustomFieldList(self.Owner).PostDb;
      end;
end;

{ Property Functions }
function TCustomFieldListDropDown.GetCustomFieldlistId: Integer;
begin
  result := GetIntegerField('CustomFieldlistId');
end;

function TCustomFieldListDropDown.GetText: string;
begin
  result := GetStringField('Text');
end;
function TCustomFieldListDropDown.GetActive: Boolean;
begin
  result := GetBooleanField('Active');
end;
procedure TCustomFieldListDropDown.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;
procedure TCustomFieldListDropDown.SetCustomFieldlistId(const Value: Integer);
begin
  SetIntegerField('CustomFieldlistId', Value);
end;

procedure TCustomFieldListDropDown.SetText(const Value: string);
begin
  SetStringField('Text', Value);
end;

{ TCustomFieldValues }

constructor TCustomFieldValues.Create(AOwner: TComponent);
begin
  fbPopulatingAll := False;
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'CustomFieldValues';
  fIsList := True;
  ExportExcludeList.Add('customfieldlistid');
end;

destructor TCustomFieldValues.Destroy;
begin
  inherited;
end;

procedure TCustomFieldValues.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'MasterID');
  SetPropertyFromNode(node, 'CustomFieldlistId');
  SetPropertyFromNode(node, 'Value');
end;

procedure TCustomFieldValues.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'MasterID', MasterID);
  AddXMLNode(node, 'CustomFieldlistId', CustomFieldlistId);
  AddXMLNode(node, 'Value', Value);
end;

function TCustomFieldValues.ValidateData: Boolean;
begin
  Resultstatus.Clear;
  result := False;
  if CustomFieldlistId = 0 then begin
    AddResult(False, rssWarning, 0, 'Custom field list is blank');
    Exit;
  end;
  if CustomFieldlistId < 0 then begin
    AddResult(False, rssWarning, 0, 'Custom field list value not found');
    Exit;
  end;
  result := True;
end;

class function TCustomFieldValues._Schema: string;
begin
  result := inherited;
  TBOSchema.AddRefType(result, 'TCustomFieldList', 'CustFieldListObj', 'CustomFieldListID', 'CFID');
  TBOSchema.AddRefType(result, 'TCustomFieldList', 'CustFieldListObj', 'Description',
    'Description');
end;

function TCustomFieldValues.Save: Boolean;
begin
  result := False;
  if not ValidateData then
    Exit;
  result := inherited Save;
end;

procedure TCustomFieldValues.OnBeforeDataIdChange;
begin
  inherited;
  SendEvent(BusObjEvent_Dataset, BusObjEvent_BeforeIDChanged, self);
end;

procedure TCustomFieldValues.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  SendEvent(BusObjEvent_Dataset, BusObjEvent_IDChanged, self);
end;

procedure TCustomFieldValues.PopulateAll(TransMasterID: Integer);
var
  s: String;
begin
  fbPopulatingAll := True;
  try
    s := 'Select ' + IntToStr(TransMasterID) + ' MasterId,CFID from tblcustomfieldlist where ';
         if self is TCustomerCustomfieldValues  then s := s + ' ListType = ' + quotedstr('ltCustomer')
    else if self is TSupplierCustomfieldValues  then s := s + ' ListType = ' + quotedstr('ltsupplier')
    else if self is TProductCustomfieldValues   then s := s + ' ListType = ' + quotedstr('LtProducts')
    else if Self is TEquipmentCustomFieldValues then s := s + ' LisTtype = ' + quotedstr('ltEquipment')
    else if Self is TCAROutComeReviewOptions    then s := s + ' LisTtype = ' + quotedstr('ltCAR')
    else if Self is TContactCustomFieldValues   then s := s + ' ListType = ' + QuotedStr('ltContact') + ' ORDER BY cfID'
    else if Self is TRepairCustomFieldValues    then s := s + ' ListType = ' + QuotedStr('ltRepair')
    else if Self is TLeadCustomFieldValues      then s := s + ' ListType = ' + QuotedStr('ltLeads');
    //else if self is TSupportLogLinesCustomFieldValues then s := s + ' ListType = ' + QuotedStr('ltSupportLines');





    (* s:= 'insert ignore into ' + GetBusObjectTablename +' (MasterID , CustomFieldlistId) ' + s;
      ExecuteSQL(s , true); *)
    With getNewdataset(s, True) do
      try
        if recordcount > 0 then begin
          first;
          while eof = False do begin
            if not self.Locate('MasterId;CustomFieldlistId',
              VarArrayof([FieldByname('MasterID').asInteger, FieldByname('CFID').asInteger]), []) then
            begin
              New;
              MasterID := FieldByname('MasterID').asInteger;
              CustomFieldlistId := FieldByname('CFID').asInteger;
              PostDb;
              if SameText(CustomFieldEntry.DataType, 'ftdatetime') then begin
                Value := FormatDateTime(FormatSettings.shortdateformat, 0);
                PostDb;
              end;
            end;
            Next;
          end;
        end;
      finally
        if active then
          close;
        free;
      end;
  finally
    fbPopulatingAll := False;
  end;
end;

procedure TCustomFieldValues.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then
      Exit; // we are only interested in data fields.
  inherited;
  if SameText(Sender.fieldname, 'Value') then
    if SameText(CustomFieldEntry.DataType, 'ftDatetime') then
      if Value = '' then
        Value := FormatDateTime(FormatSettings.shortdateformat, date);
end;

function TCustomFieldValues.GetSQL: string;
begin
  result := inherited GetSQL;
end;

function TCustomFieldValues.GetCustomFieldEntry: TCustomFieldList;
begin
  result := TCustomFieldList(GetcontainerComponent(TCustomFieldList,
    'CFID = ' + IntToStr(CustomFieldlistId)));
end;

class function TCustomFieldValues.GetIDField: string;
begin
  result := 'Id'
end;

class function TCustomFieldValues.GetBusObjectTablename: string;
begin
  // Result:= 'tblcustomfieldvaluesClients';
end;

function TCustomFieldValues.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterOpen(Sender);
  if not result then
    Exit;
end;

function TCustomFieldValues.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TCustomFieldValues.GetMasterID: Integer;
begin
  result := GetIntegerField('MasterID');
end;


function TCustomFieldValues.GetCustomFieldlistId: Integer;
begin
  result := GetIntegerField('CustomFieldlistId');
end;

function TCustomFieldValues.GetDescription: string;
var
  fld: TField;
begin
  if self.CustomFieldlistId > 0 then begin
    fld := Dataset.FindField('Description');
    if Assigned(fld) then
      result := fld.AsString
    else
      result := TCustomFieldList.IDToggle(CustomFieldlistId, Connection.Connection);
  end
  else
    result := '';
end;

function TCustomFieldValues.GetValue: string;
begin
  result := GetStringField('Value');
end;

procedure TCustomFieldValues.SetMasterID(const Value: Integer);
begin
  SetIntegerField('MasterID', Value);
end;


procedure TCustomFieldValues.SetCustomFieldlistId(const Value: Integer);
begin
  SetIntegerField('CustomFieldlistId', Value);
end;

procedure TCustomFieldValues.SetDescription(const Value: string);
begin
  if Value <> '' then begin
    CustomFieldlistId := TCustomFieldList.IDToggle(Value, Connection.Connection);
    if CustomFieldlistId = 0 then
      CustomFieldlistId := -1;
  end
  else
    CustomFieldlistId := 0;
end;

procedure TCustomFieldValues.SetValue(const Value: string);
begin
  SetStringField('Value', Value);
end;

{ TClientCustomfieldValues }
constructor TClientCustomfieldValues.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM tblcustomfieldvaluesClients';
end;

class function TClientCustomfieldValues.GetBusObjectTablename: string;
begin
  result := 'tblcustomfieldvaluesClients';
end;
{ TCustomerCustomfieldValues }

constructor TCustomerCustomfieldValues.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT CFV.* /*, CFL.Description */ FROM tblcustomfieldvaluesClients CFV inner join tblcustomfieldlist  CFL on CFV.CustomFieldlistId = CFL.CFID and CFL.ListType = "ltcustomer" ';
end;

{ TSupplierCustomfieldValues }
constructor TSupplierCustomfieldValues.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT CFV.* /*, CFL.Description */ FROM tblcustomfieldvaluesClients CFV inner join tblcustomfieldlist  CFL on CFV.CustomFieldlistId = CFL.CFID and CFL.ListType = "ltsupplier" ';
end;

{ TEquipmentCustomfieldValues }

constructor TEquipmentCustomfieldValues.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM tblCustomfieldvaluesEquipment';
end;

class function TEquipmentCustomfieldValues.GetBusObjectTablename: string;
begin
  result := 'tblCustomfieldvaluesEquipment';
end;

//{ TDeletedCFListDropBown }
//
//class function TDeletedCFListDropDown.GetDeletedTablename: string;
//begin
//  result := 'tblcustomfieldlistdropdowns';
//end;

{ TCAROutComeReviewOptions }

constructor TCAROutComeReviewOptions.Create(AOwner: TComponent);
begin
  inherited;
    fSQL := 'SELECT * FROM tblcarOutComeReviewOptions';
end;

class function TCAROutComeReviewOptions.GetBusObjectTablename: string;
begin
  result := 'tblcarOutComeReviewOptions';
end;

function TCAROutComeReviewOptions.getValueSelected: Boolean;begin  Result := getBooleanfield('ValueSelected');end;
procedure TCAROutComeReviewOptions.SetValueSelected(const Value: Boolean);begin  SetBooleanField('ValueSelected' , Value);end;

{ TSaleSLinesCustomFieldList }

constructor TSaleSLinesCustomFieldList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'SaleslinesCustomFieldList';
  fSQL := 'SELECT * FROM tblcustomfieldlist where Listtype = "ltSaleslines"';
end;

{ TContactCustomFieldValues }

constructor TContactCustomFieldValues.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM ' + GetBusObjectTablename; //tblcustomfieldvaluescontact';
end;

class function TContactCustomFieldValues.GetBusObjectTablename: string;
begin
  result := 'tblcustomfieldvaluescontact';
end;

{ TRepairCustomFieldValues }

constructor TRepairCustomFieldValues.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM ' + GetBusObjectTablename;
end;

class function TRepairCustomFieldValues.GetBusObjectTablename: string;
begin
  result := 'tblcustomfieldvaluesRepair';
end;

{ TLeadCustomfieldValues }

constructor TLeadCustomfieldValues.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM ' + GetBusObjectTablename;
end;

class function TLeadCustomfieldValues.GetBusObjectTablename: string;
begin
  result := 'tblcustomfieldvaluesLead';
end;

{ TSmartOrderlinesCustomFieldList }

constructor TSmartOrderlinesCustomFieldList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'SmartorderLinesCustomFieldList';
  fSQL := 'SELECT * FROM tblcustomfieldlist where Listtype = "ltSmartorderLines"';

end;

{ TProductCustomFieldValues }

constructor TProductCustomFieldValues.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT CFV.* /*, CFL.Description */ FROM tblcustomfieldvaluesproducts CFV inner join tblcustomfieldlist  CFL on CFV.CustomFieldlistId = CFL.CFID and CFL.ListType = "ltProducts" ';

end;

class function TProductCustomFieldValues.GetBusObjectTablename: string;
begin
  result := 'tblcustomfieldvaluesproducts';
end;

function TCustomFieldValues.GetMastername         : String; begin end;
function TClientCustomFieldValues.GetMastername   : String;begin Inherited; Result := TClient.idToggle(MasterID)                 ;end;
function TContactCustomFieldValues.GetMastername  : String;begin Inherited; Result := Tcontact.idToggle(MasterID)                ;end;
function TRepairCustomFieldValues.GetMastername   : String;begin Inherited; Result := TREpairs.idToggle(MasterID)                ;end;
function TProductCustomFieldValues.GetMastername  : String;begin Inherited; Result := TProductSimple.idToggle(MasterID)          ;end;
function TEquipmentCustomfieldValues.GetMastername: String;begin Inherited; Result := TEquipment.idToggle(MasterID)              ;end;
function TCAROutComeReviewOptions.GetMastername   : String;begin Inherited; Result := TCorrectiveActionReports.idToggle(MasterID);end;
function TLeadCustomfieldValues.GetMastername     : String;begin Inherited; Result := TLeads.idToggle(MasterID)                  ;end;

procedure TCustomFieldValues.SetMasterName          (const Value: String);begin end;
procedure TClientCustomFieldValues.SetMasterName    (const Value: String);begin Inherited; MasterId := TClient.idToggle(Value)                  ;end;
procedure TContactCustomFieldValues.SetMasterName   (const Value: String);begin Inherited; MasterId := Tcontact.idToggle(Value)                 ;end;
procedure TRepairCustomFieldValues.SetMasterName    (const Value: String);begin Inherited; MasterId := TREpairs.idToggle(Value)                 ;end;
procedure TProductCustomFieldValues.SetMasterName   (const Value: String);begin Inherited; MasterId := TProductSimple.idToggle(Value)           ;end;
procedure TEquipmentCustomfieldValues.SetMasterName (const Value: String);begin Inherited; MasterId := TEquipment.idToggle(Value)               ;end;
procedure TCAROutComeReviewOptions.SetMasterName    (const Value: String);begin Inherited; MasterId := TCorrectiveActionReports.idToggle(Value) ;end;
procedure TLeadCustomfieldValues.SetMasterName      (const Value: String);begin Inherited; MasterId := TLeads.idToggle(Value)                     ;end;

//{ TLogLinesCustomFieldValues }
//
//constructor TSupportLogLinesCustomFieldValues.Create(AOwner: TComponent);
//begin
//  inherited Create(AOwner);
//  fBusObjectTypeDescription := 'SupportLinesCustomFieldList';
//  fSQL := 'SELECT * FROM ' + GetBusObjectTablename;
//end;
//
//class function TSupportLogLinesCustomFieldValues.GetBusObjectTablename: string;
//begin
//  result := 'tblcustomfieldvaluessupportlines';
//end;
//
//function TSupportLogLinesCustomFieldValues.GetMastername: String;
//begin
//  inherited;
//  //result :=
//end;
//
//procedure TSupportLogLinesCustomFieldValues.SetMasterName(const Value: String);
//begin
//  inherited;
//
//end;

{ TSupportLinesCustomFieldList }

constructor TSupportLinesCustomFieldList.Create(AOwner: TComponent);
begin
  inherited;
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'SupportLinesCustomFieldList';
  fSQL := 'SELECT * FROM tblcustomfieldlist where Listtype = "ltSupportLines"';

end;

initialization

RegisterClass(TCustomFieldListDropDown);
RegisterClass(TCustomFieldList);
RegisterClass(TSaleSLinesCustomFieldList);
RegisterClass(TSmartorderLinesCustomFieldList);
RegisterClass(TCustomerCustomfieldValues);
RegisterClass(TSupplierCustomfieldValues);
RegisterClass(TProductCustomFieldValues);
//RegisterClass(TDeletedCFListDropDown);
RegisterClass(TContactCustomFieldValues);
RegisterClass(TRepairCustomFieldValues);
RegisterClass(TLeadCustomfieldValues);

BusObjectListObj.TBusObjInfoList.Inst.Add('Customisable List - Products','TProductCustomFieldValues'  ,'TCustomFieldValuesProductsGUI');
BusObjectListObj.TBusObjInfoList.Inst.Add('Customisable List - Customer','TCustomerCustomFieldValues' ,'TCustomFieldValuesCustomerGUI');
BusObjectListObj.TBusObjInfoList.Inst.Add('Customisable List - Supplier','TSupplierCustomFieldValues' ,'TCustomFieldValuesSupplierGUI');

end.
