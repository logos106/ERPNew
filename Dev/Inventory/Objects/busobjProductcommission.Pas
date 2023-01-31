unit busobjProductcommission;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  09/07/09  1.00.00  BJ  Initial Version.
}

interface

uses busobjbase, DB, Classes, XMLDoc, XMLIntf;

type
  TEmpNoCommsProducts = class(TMSBusObj)
  private
    function GetEmployeeID: Integer;
    function GetProductID: Integer;
    function GetProductName: string;
    procedure SetEmployeeID(const Value: Integer);
    procedure SetProductID(const Value: Integer);
    procedure SetProductName(const Value: string);
    function getActive: Boolean;
    procedure setActive(const Value: Boolean);
    function GetEmployeeName: string;
    procedure SetEmployeeName(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function _Schema: string; override;
  published
    property EmployeeID: Integer read GetEmployeeID write SetEmployeeID;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    property ProductID: Integer read GetProductID write SetProductID;
    property ProductName: string read GetProductName write SetProductName;
    property Active: Boolean read getActive write setActive;
  end;

  TProductCommission = class(TMSBusObj)
  private
    function GetPartsId: Integer;
    function GetIsPercentage: Boolean;
    function GetCommissionRate: Double;
    function getActive: Boolean;
    procedure SetPartsId(const Value: Integer);
    procedure SetIsPercentage(const Value: Boolean);
    procedure SetCommissionRate(const Value: Double);
    procedure setActive(const Value: Boolean);
    function GetEmployeeID: Integer;
    procedure SetEmployeeID(const Value: Integer);
    function getPartname: string;
    procedure setPartname(const Value: string);
    function getForAllEmployees: Boolean;
    procedure setForAllEmployees(const Value: Boolean);
    procedure setEmployeeName(const Value: string);
    function getOverheadbaserate: Double;
    procedure setOverheadbaserate(const Value: Double);
    function GetCommissionon: string;
    procedure SetCommissionon(const Value: string);
    function GetCommissioninvoiceexprice: Boolean;
    procedure SetCommissioninvoiceexprice(const Value: Boolean);
    function GetIsCommissiononpaidInvoice: Boolean;
    procedure SetIsCommissiononpaidInvoice(const Value: Boolean);
    function GetEmployeeName: string;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    procedure AddNewifMissing(const fHeader, fDataline: TStringList); overload; override;
    procedure AddNewifMissing(const fiPartsID, fiEmployeeID: Integer; const fsForAllEmployees: string); reintroduce; overload;
    class function _Schema: string; override;
  published
    property PartsId: Integer read GetPartsId write SetPartsId;
    property PartName: string read getPartname write setPartname;
    property IsPercentage: Boolean read GetIsPercentage write SetIsPercentage;
    property CommissionRate: Double read GetCommissionRate write SetCommissionRate;
    property Active: Boolean read getActive write setActive;
    property EmployeeID: Integer read GetEmployeeID write SetEmployeeID;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    property ForAllEmployees: Boolean read getForAllEmployees write setForAllEmployees;
    property IsCommissionOnPaidInvoice: Boolean read GetIsCommissiononpaidInvoice write SetIsCommissiononpaidInvoice;
    property CommissionInvoiceExPrice: Boolean read GetCommissioninvoiceexprice write SetCommissioninvoiceexprice;
    property Commissionon: string read GetCommissionon write SetCommissionon;
    property OverheadBaseRate: Double read getOverheadbaserate write setOverheadbaserate;

  end;

implementation

uses Variants, tcDataUtils, CommonLib, BusObjConst, SysUtils, BusObjEmployee,
  BusObjStock, BusObjSchemaLib, SystemLib;

{ TProductCommission }

constructor TProductCommission.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'ProductCommission';
  fSQL := 'SELECT * FROM tblproductcommission';
  fSQLOrder := 'EmployeeID DESC';
  self.ExportExcludeList.Add('partsid');
  self.ExportExcludeList.Add('employeeid');
  self.fIsList:= true;
end;

destructor TProductCommission.Destroy;
begin
  inherited;
end;

procedure TProductCommission.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'PartsId');
  SetBooleanPropertyFromNode(node, 'IsPercentage');
  SetPropertyFromNode(node, 'CommissionRate');
  SetBooleanPropertyFromNode(node, 'Active');
  SetBooleanPropertyFromNode(node, 'ForAllEmployees');
  SetPropertyFromNode(node, 'Partname');
  SetPropertyFromNode(node, 'EmployeeId');
  SetPropertyFromNode(node, 'Overheadbaserate');
  SetBooleanPropertyFromNode(node, 'IsCommissiononpaidInvoice');
  SetPropertyFromNode(node, 'Commissionon');
  SetBooleanPropertyFromNode(node, 'Commissioninvoiceexprice');
end;

procedure TProductCommission.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'PartsId', PartsId);
  AddXMLNode(node, 'IsPercentage', IsPercentage);
  AddXMLNode(node, 'CommissionRate', CommissionRate);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'ForAllEmployees', ForAllEmployees);
  AddXMLNode(node, 'EmployeeId', EmployeeID);
  AddXMLNode(node, 'Partname', Partname);
  AddXMLNode(node, 'IsCommissiononpaidInvoice', IsCommissiononpaidInvoice);
  AddXMLNode(node, 'Commissioninvoiceexprice', Commissioninvoiceexprice);
  AddXMLNode(node, 'Commissionon', Commissionon);
  AddXMLNode(node, 'Overheadbaserate', Overheadbaserate);
end;

function TProductCommission.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if PartsId = 0 then begin
    Resultstatus.AddItem(False, rssError, 0, 'Product should not be blank');
    Exit;
  end;
  if PartsId < 0 then begin
    Resultstatus.AddItem(False, rssError, 0, 'Product not found');
    Exit;
  end;
  if ForAllEmployees = False then begin
    if EmployeeID = 0 then begin
      Resultstatus.AddItem(False, rssError, 0, 'Employee should not be blank');
      Exit;
    end;
    if EmployeeID < 0 then begin
      Resultstatus.AddItem(False, rssError, 0, 'Employee not found');
      Exit;
    end;
  end;
  Result := true;
end;

class function TProductCommission._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TEmployee','EmployeeObj','EmployeeID','ID');
  TBOSchema.AddRefType(result,'TEmployee','EmployeeObj','EmployeeName','EmployeeName');
  TBOSchema.AddRefType(result,'TProductWeb','ProductObj','PartsID','ID');
  TBOSchema.AddRefType(result,'TProductWeb','ProductObj','PartName','ProductName');
end;

function TProductCommission.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  PostDB;
  Result := inherited Save;
  if Result then dirty := False;
end;

procedure TProductCommission.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TProductCommission.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SysUtils.SameText(Sender.FieldName, 'ForAllEmployees') then begin
    if not RawMode then begin
      if ForAllEmployees then begin
        EmployeeID := 0;
      end else begin
        SendEvent(BusObjEvent_Change, BusobjEventVal_ForAllEmployees, self);
      end;
    end;
  end
  else if SysUtils.SameText(Sender.FieldName, 'Partname') then begin
    if PartName <> '' then begin
      PartsId := TProduct.IDToggle(PartName,Connection.Connection);
      if PartsId = 0 then
        PartsId:= -1;
    end
    else
      PartsId:= 0;
  end
  else if SysUtils.SameText(Sender.FieldName, 'PartsID') then begin

  end
  else if SysUtils.SameText(Sender.FieldName, 'IsPercentage') then begin
    if not RawMode then begin
      SendEvent(BusObjEvent_Change, BusobjEventVal_IsPercentage, self);
    end;
  end;
end;

function TProductCommission.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TProductCommission.GetIDField: string;
begin
  Result := 'ProductCommissionId'
end;

class function TProductCommission.GetBusObjectTablename: string;
begin
  Result := 'tblproductcommission';
end;

function TProductCommission.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TProductCommission.GetPartsId: Integer;
begin
  Result := GetIntegerField('PartsId');
end;

function TProductCommission.GetIsPercentage: Boolean;
begin
  Result := GetBooleanField('IsPercentage');
end;

function TProductCommission.GetCommissionRate: Double;
begin
  Result := GetFloatField('CommissionRate');
end;

function TProductCommission.getActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

procedure TProductCommission.SetPartsId(const Value: Integer);
begin
  SetIntegerField('PartsId', Value);
end;

procedure TProductCommission.SetIsPercentage(const Value: Boolean);
begin
  SetBooleanField('IsPercentage', Value);
end;

procedure TProductCommission.SetCommissionRate(const Value: Double);
begin
  SetFloatField('CommissionRate', Value);
end;

procedure TProductCommission.setActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

function TProductCommission.GetCommissionon: string;
begin
  Result := getstringfield('Commissionon');
end;

procedure TProductCommission.SetCommissionon(const Value: string);
begin
  SetstringField('Commissionon', Value);
end;

function TProductCommission.GetCommissioninvoiceexprice: Boolean;
begin
  Result := GetBooleanField('Commissioninvoiceexprice');
end;

procedure TProductCommission.SetCommissioninvoiceexprice(const Value: Boolean);
begin
  SetBooleanField('Commissioninvoiceexprice', Value);
end;

function TProductCommission.getOverheadbaserate: Double;
begin
  Result := GetFloatField('Overheadbaserate');
end;

procedure TProductCommission.setOverheadbaserate(const Value: Double);
begin
  SetFloatField('Overheadbaserate', Value);
end;

function TProductCommission.GetIsCommissiononpaidInvoice: Boolean;
begin
  Result := GetBooleanField('Commissiononpaid');
end;

procedure TProductCommission.SetIsCommissiononpaidInvoice(const Value: Boolean);
begin
  SetBooleanField('Commissiononpaid', Value);
end;

function TProductCommission.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  Active := true;
  if Assigned(Owner) and (Owner is TProduct) then
    self.PartsId:= TProduct(Owner).ID;
end;

function TProductCommission.GetEmployeeID: Integer;
begin
  Result := GetIntegerField('EmployeeId');
end;

function TProductCommission.GetEmployeeName: string;
begin
  result:= TEmployee.IDToggle(EmployeeID, Connection.Connection);
end;

procedure TProductCommission.SetEmployeeID(const Value: Integer);
begin
  SetIntegerField('EmployeeId', Value);
end;

function TProductCommission.getPartname: string;
begin
  Result := getstringfield('Partname');
end;

procedure TProductCommission.setPartname(const Value: string);
begin
  SetstringField('Partname', Value);
end;

function TProductCommission.getForAllEmployees: Boolean;
begin
  Result := GetBooleanField('ForAllEmployees');
end;

procedure TProductCommission.setForAllEmployees(const Value: Boolean);
begin
  SetBooleanField('ForAllEmployees', Value);
end;

function TProductCommission.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not Result then Exit;

  if not IsUnique(ID, 'ifnull(PartsId,0) = ' + intToStr(PartsId) + ' and ForAllEmployees = ' + QuotedStr(BooleanToStr(ForAllEmployees)) + ' and ifnull(EmployeeId,0) = ' + intToStr(EmployeeID)) then
  begin
    Result := False;
    Resultstatus.AddItem(False, rssError, 0, 'Commission already exists for this Product', true);
    abort;
    Exit;
  end;
end;

procedure TProductCommission.SetEmployeeName(const Value: string);
begin
  if Value <> '' then begin
    EmployeeID:= TEmployee.IDToggle(Value, Connection.Connection);
    if EmployeeID = 0 then
      EmployeeID := -1;
  end
  else
    EmployeeID:= 0;
end;

(* function TProductCommission.DoOnUpdateError(DataSet: TDataSet;
  E: EDatabaseError; UpdateKind: TUpdateKind;
  var UpdateAction: TUpdateAction): Boolean;
  var
  fiEmployeeId,fiPartsID:integer;
  curRecord:String;
  begin
  if not DataImportMode then Exit;
  fiEmployeeId := employeeID;
  fiPartsID := PartsId;
  curRecord:= XMLDoc.XML.Text;
  UpdateAction := uaAbort;
  Dataset.Cancel;
  if Dataset.Locate('EmployeeId;PartsID' , varArrayof([fiEmployeeId, fiPartsID]) , []) then
  Updaterecord(CurREcord);


  end; *)

procedure TProductCommission.AddNewifMissing(const fHeader, fDataline: TStringList);
var
  fiEmployeeID, fiPartsID: Integer;
  fsForAllEmployees: string;
begin
  fiEmployeeID := tcDataUtils.GetEmployeeID(Trim(fDataline[SearchStringList(fHeader, 'EmployeeName')]));
  fiPartsID := tcDataUtils.getProduct(Trim(fDataline[SearchStringList(fHeader, 'PartName')]));
  fsForAllEmployees := Trim(fDataline[SearchStringList(fHeader, 'ForAllEmployees')]);
  AddNewifMissing(fiPartsID, fiEmployeeID, fsForAllEmployees);
  (* LoadSelect('ifnull(employeeID,0) = ' +IntToStr(fiEmployeeID) +
    ' and  ifnull(partsId,0) = ' +IntToStr(fiPartsID) +
    ' and ifnull(ForAllEmployees,"F") = ' +Quotedstr(fsForAllEmployees));
    if count = 0 then new; *)
end;

procedure TProductCommission.AddNewifMissing(const fiPartsID, fiEmployeeID: Integer; const fsForAllEmployees: string);
begin
  LoadSelect('ifnull(employeeID,0) = ' + intToStr(fiEmployeeID) + ' and  ifnull(partsId,0) = ' + intToStr(fiPartsID) + ' and ifnull(ForAllEmployees,"F") = ' + QuotedStr(fsForAllEmployees));
  if count = 0 then new;
end;

{ TEmpNoCommsProducts }

constructor TEmpNoCommsProducts.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'EmpNoCommsProducts';
  fSQL := 'SELECT * FROM tblempnocommsproducts';
  self.ExportExcludeList.Add('productid');
  self.ExportExcludeList.Add('employeeid');
end;

destructor TEmpNoCommsProducts.Destroy;
begin
  inherited;
end;

procedure TEmpNoCommsProducts.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'EmployeeID');
  SetPropertyFromNode(node, 'ProductID');
  SetPropertyFromNode(node, 'ProductName');
  SetBooleanPropertyFromNode(node, 'Active');
end;

procedure TEmpNoCommsProducts.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'EmployeeID', EmployeeID);
  AddXMLNode(node, 'ProductID', ProductID);
  AddXMLNode(node, 'ProductName', ProductName);
  AddXMLNode(node, 'Active', Active);
end;

function TEmpNoCommsProducts.ValidateData: Boolean;
begin
  Resultstatus.Clear;
  Result := false;
  if EmployeeId = 0 then begin
    Resultstatus.AddItem(False, rssError, 0, 'Employee should not be blank');
    Exit;
  end;
  if EmployeeId < 0 then begin
    Resultstatus.AddItem(False, rssError, 0, 'Employee not found');
    Exit;
  end;
  if (ProductId = 0) and (ProductName = '') then begin
    Resultstatus.AddItem(False, rssError, 0, 'Product should not be blank');
    Exit;
  end;
  if (ProductId > 0) and (ProductName = '') then begin
    Resultstatus.AddItem(False, rssError, 0, 'Product not found for Product ID: ' + IntToStr(ProductID));
    Exit;
  end;
  if (ProductId = 0) and (ProductName <> '') then begin
    Resultstatus.AddItem(False, rssError, 0, 'Product ID not found for product "' + ProductName + '"');
    Exit;
  end;
  Result := true;
end;

class function TEmpNoCommsProducts._Schema: string;
begin
  TBOSchema.AddRefType(result,'TEmployee','EmployeeObj','EmployeeID','ID');
  TBOSchema.AddRefType(result,'TEmployee','EmployeeObj','EmployeeName','EmployeeName');
  TBOSchema.AddRefType(result,'TProductWeb','ProductObj','ProductID','ID');
  TBOSchema.AddRefType(result,'TProductWeb','ProductObj','ProductName','ProductName');
end;

function TEmpNoCommsProducts.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TEmpNoCommsProducts.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TEmpNoCommsProducts.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SysUtils.SameText(Sender.FieldName, 'ProductID') then begin
    ProductName:= TProduct.IDToggle(ProductID, Connection.Connection);
  end
  else if SysUtils.SameText(Sender.FieldName, 'ProductName') then begin
    ProductID:= TProduct.IDToggle(ProductName, Connection.Connection);
  end;
end;

function TEmpNoCommsProducts.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TEmpNoCommsProducts.GetIDField: string;
begin
  Result := 'ID'
end;

class function TEmpNoCommsProducts.GetBusObjectTablename: string;
begin
  Result := 'tblempnocommsproducts';
end;

function TEmpNoCommsProducts.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TEmpNoCommsProducts.GetEmployeeID: Integer;
begin
  Result := GetIntegerField('EmployeeID');
end;

function TEmpNoCommsProducts.GetEmployeeName: string;
begin
  result:= TEmployee.IDToggle(EmployeeId, Connection.Connection);
end;

function TEmpNoCommsProducts.GetProductID: Integer;
begin
  Result := GetIntegerField('ProductID');
end;

function TEmpNoCommsProducts.GetProductName: string;
begin
  Result := getstringfield('ProductName');
end;

procedure TEmpNoCommsProducts.SetEmployeeID(const Value: Integer);
begin
  SetIntegerField('EmployeeID', Value);
end;

procedure TEmpNoCommsProducts.SetEmployeeName(const Value: string);
begin
  if Value <> '' then begin
    EmployeeID:= TEmployee.IDToggle(Value, Connection.Connection);
    if EmployeeID = 0 then
      EmployeeID:= -1;
  end
  else
    EmployeeID:= 0;
end;

procedure TEmpNoCommsProducts.SetProductID(const Value: Integer);
begin
  SetIntegerField('ProductID', Value);
end;

procedure TEmpNoCommsProducts.SetProductName(const Value: string);
begin
  SetstringField('ProductName', Value);
end;

function TEmpNoCommsProducts.getActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

procedure TEmpNoCommsProducts.setActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

initialization

RegisterClass(TEmpNoCommsProducts);
RegisterClass(TProductCommission);

end.
