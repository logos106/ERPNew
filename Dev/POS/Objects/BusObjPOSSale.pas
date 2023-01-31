unit BusObjPOSSale;

{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  16/05/07   1.00.01   A.   Initial Version.
}

interface

uses BusObjBase, DB, Classes, BusObjTrans, BusObjSaleBase, BusObjCash, BusObjPOSOrders, XMLDoc, XMLIntf, busobjvoucher;

type

  TPOSEOPPayments = class(TMSBusObj)
  private
    function GetDate: TDatetime;
    function GetTillid: Integer;
    function GetPaymethod: string;
    function GetAmount: Double;
    procedure SetDate(const Value: TDatetime);
    procedure SetTillid(const Value: Integer);
    procedure SetPaymethod(const Value: string);
    procedure SetAmount(const Value: Double);

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

  published
    property Date: TDatetime read GetDate write SetDate;
    property TillId: Integer read GetTillid write SetTillid;
    property PayMethod: string read GetPaymethod write SetPaymethod;
    property Amount: Double read GetAmount write SetAmount;
  end;

  TPOSSalePayments = class(TSalesPayments)
  private
  public
    constructor Create(AOwner: TComponent); override;
  protected
    function GetSQL: string; override;
  end;

  TPOSSaleLine = class(TCashLineBase)
  private
  protected
    function GetSQL: string; override;
    procedure DoFieldOnChange(Sender: TField); override;
    (* function getcleanQtyBO          : Double;           override; *)
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    (* function GetStockAffected       : Boolean; Override; *)
    (* function GetEnableAllc      : Boolean; override; *)
    (* function GetIsInvProduct    : Boolean; override; *)

  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
  end;

  TPOSLaybyLines = class(TCashSaleLine)
  private
  public
    constructor Create(AOwner: TComponent); override;
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    function ISFullyPaid: Boolean;
  protected
    function GetIsPQAItem: Boolean; override;
    (* function GetEnableAllc: Boolean; override; *)
    (* function GetIsInvProduct    : Boolean; override; *)
    (* function GetStockAffected       : Boolean; override; *)

  end;

  TPOSSale = class(TCashBase)
  private
    fPOSPayments: Tposeoppayments;
    fbPOSSuccess: Boolean;
    fiOrderId: Integer;
    fiCustDocketRef: Integer;
    fbHasProcessedItem: Boolean;
    fPOSorder: TPOSOrder;
    fPOSSalePayments: TPOSSalePayments;
    fbIsBarTab: Boolean;

    function GetPOSSaleLines: TPOSSaleLine;
    function getPOSPayments: Tposeoppayments;
    // function GetCleanIsLayby    : Boolean;

    procedure CreateOrderLines(const Sender: TBusObj; var Abort: Boolean);
    procedure GetPartProcessInfo(OrderLineId, PartId: Integer; var NextStepID: Integer; var ProcessedItem: Boolean);
    function getPOSSeqNo: Integer;
    function getPOSorder: TPOSOrder;
    // function  getPOSSalePayments:TPOSSalePayments;
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function GetSQL: string; override;
    function GetSaleLines: TSalesLineBase; override;
    function GetLines: TTransLineBase; override;
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    function getSalesPayments: TSalesPayments; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    function CreateOrdersFromPos(OnlyCreateProcessed: Boolean = True): Integer;
    function Save: Boolean; override;
    property Lines: TPOSSaleLine read GetPOSSaleLines;
    property POSPayments: Tposeoppayments read getPOSPayments write fPOSPayments;
    property POSorder: TPOSOrder read getPOSorder write fPOSorder;
    // Property CleanIsLayby                       : Boolean            Read GetCleanIsLayby;
  published
    property OrderFromPOSSuccess: Boolean read fbPOSSuccess write fbPOSSuccess;
    property OrderFromPOSOrderId: Integer read fiOrderId write fiOrderId;
    property OrderFromPOSCustDocketRef: Integer read fiCustDocketRef write fiCustDocketRef;
    property OrderFromPOSContainsProcessedItems: Boolean read fbHasProcessedItem write fbHasProcessedItem;
    property IsBarTab: Boolean read fbIsBarTab write fbIsBarTab;
    // Property POSSalePayments                     : TPOSSalePayments    read getPOSSalePayments  Write fPOSSalePayments;
  end;

  TPOSLayby = class(TCashBase)
  private
    fbconvertingSO: Boolean;
    fbCompletedlayby: Boolean;
    // fPOSLaybylines   : TPOSLaybylines;
    function GetPOSLaybylines: TPOSLaybylines;
    procedure ClonePayments(const Sender: TBusObj; var Abort: Boolean);

  public
    property Lines: TPOSLaybylines read GetPOSLaybylines;
    property convertingSO: Boolean read fbconvertingSO write fbconvertingSO;
    property Completedlayby: Boolean read fbCompletedlayby write fbCompletedlayby;

    constructor Create(AOwner: TComponent); override;
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function GetSaleLines: TSalesLineBase; override;
    function GetLines: TTransLineBase; override;
    procedure ClonePropertyObjects; override;
    function GetCleanXMLNode: IXMLNode; override;
  end;

  TPOSLaybyPaymentLines = class(TCashSaleLine)
  private
    fPOSLayby: TPOSLayby;
    function getPOSLayby: TPOSLayby;
  public
    property POSLayby: TPOSLayby read getPOSLayby write fPOSLayby;
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
  protected
    function GetIsPQAItem: Boolean; override;
  end;

  TPOSLaybyPayment = class(TCashBase)
  private
    // fPOSLaybyPaymentlines : TPOSLaybyPaymentlines;
    fscomments: string;
    allLinesOnk: Boolean;
    function GetPOSLaybyPaymentslines: TPOSLaybyPaymentlines;
    procedure check4Completedlaybys(const Sender: TBusObj; var Abort: Boolean);
    procedure ActivatePQA(const Sender: TBusObj; var Abort: Boolean);
  public
    function Save: Boolean; override;
    function GetSaleLines: TSalesLineBase; override;
    function GetLines: TTransLineBase; override;
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    function GetCleanXMLNode: IXMLNode; override;
  end;

  TPOSCashSaleLine = class(TCashSaleLine)
  private
  public
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
  protected
  end;

  TPOSCashSale = class(TCashBase)
  private
    // fPOSCashSalelines : TPOSCashSaleline;
    function GeTPOSCashSaleslines: TPOSCashSaleline;
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    function Save: Boolean; override;
    function GetSaleLines: TSalesLineBase; override;
    function GetLines: TTransLineBase; override;
  end;

implementation

uses tcDataUtils, CommonLib, Sysutils, tcConst, MyAccess, ERPdbComponents, BusObjStock, AppEnvironment, BusObjCommon, CommonDbLib (*, BusObjProductQty*),
   VoucherLib, BusObjConst;
{ ========================================================
  TPOSSaleLine
  ======================================================== }

(* function TPOSSaleLine.getcleanQtyBO          : Double;
  begin
  result := 0;
  end; *)
(* function TPOSSaleLine.GetStockAffected       : Boolean;
  begin
  result := inherited GetStockAffected;
  if Assigned(Self.Owner) then
  if Self.Owner is TPOSSale then
  if TPOSSale(Self.Owner).IsBarTab then Result := False;
  end; *)
(* function TPOSSaleLine.GetIsInvProduct    : Boolean;
  begin
  Result := false;
  end; *)
(* function TPOSSaleLine.GetEnableAllc      : Boolean;
  begin
  Result := false;
  end; *)
function TPOSSaleLine.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforePost(Sender);
end;

function TPOSSaleLine.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterPost(Sender);
end;

constructor TPOSSaleLine.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM tblsaleslines_POS';
end;

function TPOSSaleLine.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then Exit;
  if Assigned(Self.Owner) then
    if Self.Owner is TPOSSale then saleId := TPOSSale(Self.Owner).ID;
  CreationDate := Date;
end;

class function TPOSSaleLine.GetIDField: string;
begin
  result := 'SaleLineID';
end;

class function TPOSSaleLine.GetBusObjectTablename: string;
begin
  result := 'tblsaleslines_POS';
end;

procedure TPOSSaleLine.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'ProductID') then begin
    Product.Load(ProductID);
    ProductName := Product.ProductName;
    ProductType := Product.ProductType;
    ProductGroup := Product.ProductGroup;
    LineCost := Product.AverageCost;
    Product_Description := Product.SalesDescription;
    if Product_Description = '' then Product_Description := ProductName;
    IncomeAccount := Product.IncomeAccount;
    AssetAccount := Product.AssetAccount;
    CogsAccount := Product.CogsAccount;
    LineTaxCode := Product.TaxCodeSales;
  end
  else if Sysutils.SameText(Sender.FieldName, 'ProductName') then begin
    ProductID := (*tcDataUtils.GetProduct(ProductName)*)TProduct.IDToggle(ProductName, Connection.Connection);
    DoFieldOnChange(Dataset.findField('ProductID'));
  end
  else if Sysutils.SameText(Sender.FieldName, 'Shipped') then begin
    Self.LineCostInc := GetAmountInc(LineCost, LineTaxRate);
  end
  else if Sysutils.SameText(Sender.FieldName, 'UnitofMeasureShipped') then begin
    Self.LineCostInc := GetAmountInc(LineCost, LineTaxRate);
  end
  else if Sysutils.SameText(Sender.FieldName, 'LineTaxRate') then begin
    Self.LineCostInc := GetAmountInc(LineCost, LineTaxRate);
  end;
end;

function TPOSSaleLine.GetSQL: string;
begin
  result := inherited GetSQL;
end;

{ ========================================================
  TPOSSale
  ======================================================== }
constructor TPOSSale.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblsales_pos';
  IsBarTab := False;
end;

function TPOSSale.GetSQL: string;
begin
  result := inherited GetSQL;
end;

function TPOSSale.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterPost(Sender);
  if not result then Exit;
  if DocNumber = '' then DocNumber := IntToStr(ID);
end;

function TPOSSale.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  inherited DoAfterInsert(Sender);
  IsCashSale := True;
  IsRefund := False;
  IsInvoice := False;
  IsSalesOrder := False;
  IsQuote := False;
  IsPOS := True;
  EOP_POS := False;
  IsLayby := False;
  IsLaybyPayment := False;
  IsLaybyTOS := False;
  IsVoucher := False;
  postdb;
  result := True;
  ClientID := tcDataUtils.GetCashCustID;
  CustomerName := CLIENT_CASH;
end;

procedure TPOSSale.GetPartProcessInfo(OrderLineId, PartId: Integer; var NextStepID: Integer; var ProcessedItem: Boolean);
var
  // qry: TERPQuery;
  ProcStep: Integer;
  strSQL: string;
begin
  NextStepID := 0;
  ProcessedItem := False;
  if OrderLineId < 1 then begin
    strSQL := 'SELECT * FROM tblProcessPart WHERE PartId = ' + IntToStr(PartId) + ' ORDER BY ProcessStepSeq';
    with getNewdataset(strSQL, False) do
      try
        if RecordCount > 0 then begin
          First;
          NextStepID := FieldByName('ProcessStepId').AsInteger;
          ProcessedItem := True;
        end;
      finally
        if Active then close;
        Free;
      end;
  end else begin
    ProcStep := getCurrentProcStep(OrderLineId);
    strSQL := 'SELECT * FROM tblProcessPart WHERE PartId = ' + IntToStr(PartId) + ' ORDER BY ProcessStepSeq';
    with getNewdataset(strSQL, False) do
      try
        if RecordCount > 0 then begin
          ProcessedItem := True;
          First;
          while (not Eof) and (FieldByName('ProcessStepSeq').AsInteger <= ProcStep) do Next;
          if FieldByName('ProcessStepSeq').AsInteger <= ProcStep then NextStepID := FieldByName('ProcessStepId').AsInteger;
        end;
      finally
        if Active then close;
        Free;
      end;
  end;
end;

procedure TPOSSale.CreateOrderLines(const Sender: TBusObj; var Abort: Boolean);
var
  CurProcStep: Integer;
  ProcReq: Boolean;
begin
  if not(Sender is TPOSSaleLine) then Exit;
  GetPartProcessInfo(0, TPOSSaleLine(Sender).ProductID, CurProcStep, ProcReq);
  if ProcReq then OrderFromPOSContainsProcessedItems := True;
  POSorder.Lines.New;
  POSorder.Lines.SalesLineID := Sender.ID;
  POSorder.Lines.PartId := TPOSSaleLine(Sender).ProductID;
  POSorder.Lines.Description := TPOSSaleLine(Sender).Product_Description;
  POSorder.Lines.Qty := TPOSSaleLine(Sender).Qtysold;
  POSorder.Lines.RequiresProcessing := ProcReq;
  POSorder.Lines.Status := 1;
  POSorder.Lines.CurrentProcStep := CurProcStep;
  POSorder.Lines.Complete := False;
  POSorder.Lines.postdb;
end;

function TPOSSale.getPOSSeqNo: Integer;
begin
  (* with TSeqNumbers.Create(Self) do try
    result:= FastFuncs.StrToInt(GetSequenceNumber(SEQ_ORDER_CUSTDOCKETREF));
    finally
    Free;
    end; *)
  result := StrToInt(GetSequenceNumber(SEQ_ORDER_CUSTDOCKETREF));
end;

function TPOSSale.getSalesPayments: TSalesPayments;
begin
  if not Assigned(fPOSSalePayments) then begin
    fPOSSalePayments := TPOSSalePayments.Create(Self);
    fPOSSalePayments.connection := Self.connection;
    fPOSSalePayments.LoadSelect('SaleId=' + IntToStr(ID));
  end
  else if fPOSSalePayments.Dataset.Active = False then fPOSSalePayments.LoadSelect('SaleId=' + IntToStr(ID))
  else if fPOSSalePayments.saleId <> ID then fPOSSalePayments.LoadSelect('SaleId=' + IntToStr(ID));
  result := fPOSSalePayments;
end;

function TPOSSale.getPOSorder: TPOSOrder;
begin
  if not(Assigned(fPOSorder)) then begin
    fPOSorder := TPOSOrder.Create(Self);
    if Assigned(Self.connection) then fPOSorder.connection := Self.connection;
  end;
  if (fPOSorder.SQLSelect <> 'SaleId=' + IntToStr(Self.ID)) or (fPOSorder.Dataset.Active = False) then fPOSorder.LoadSelect('SaleId=' + IntToStr(Self.ID));
  result := fPOSorder;
end;

function TPOSSale.CreateOrdersFromPos(OnlyCreateProcessed: Boolean = True): Integer;
begin
  result := 0;
  try
    if POSorder.count > 0 then Exit;

    OrderFromPOSOrderId := 0;
    OrderFromPOSSuccess := False;
    OrderFromPOSCustDocketRef := 0;
    OrderFromPOSContainsProcessedItems := False;

    if Self.count = 0 then Exit;
    if Self.Lines.count = 0 then Exit;

    Self.connection.BeginTransaction;

    if OnlyCreateProcessed then OrderFromPOSCustDocketRef := 0
    else OrderFromPOSCustDocketRef := getPOSSeqNo;
    POSorder.New;
    POSorder.saleId := Self.ID;
    POSorder.Createtime := now;
    POSorder.CustDocketRef := IntToStr(OrderFromPOSCustDocketRef);
    POSorder.postdb;
    OrderFromPOSOrderId := POSorder.ID;
    Lines.IterateREcords(CreateOrderLines);
    OrderFromPOSSuccess := True;
    if OnlyCreateProcessed then
      if OrderFromPOSContainsProcessedItems then begin
        OrderFromPOSCustDocketRef := getPOSSeqNo;
        POSorder.CustDocketRef := IntToStr(OrderFromPOSCustDocketRef);
      end;
    POSorder.Save;
  finally
    OrderFromPOSOrderId := POSorder.ID;
    result := POSorder.ID;
  end;
end;

function TPOSSale.Save: Boolean;
begin
  result := False;
  postdb;
  Lines.postdb;
  if not ValidateData then Exit;
  result := inherited Save;
  IsPOS := True;
  IsCashSale := True;
  IsPaid := True;
  totalBalance := 0;
  EOP_POS := True;
  if IsBarTab then begin
    IsInvoice := True;
    IsCashSale := False;
  end;
  postdb;
end;

function TPOSSale.getPOSPayments: Tposeoppayments;
begin
  { this object is used only for adding records, so dataset opened for 0 records }
  if not Assigned(fPOSPayments) then begin
    fPOSPayments := Tposeoppayments.Create(Self);
    if Assigned(Self.connection) then fPOSPayments.connection := Self.connection;
    fPOSPayments.Load(0);
  end;
  result := fPOSPayments;
end;

procedure TPOSSale.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  if Assigned(fPOSorder) then begin
    if (not fPOSorder.ExternalDatasetAssigned) then FreeAndNil(fPOSorder)
    else fPOSorder.Dataset.close;
  end;
end;

class function TPOSSale.GetIDField: string;
begin
  result := 'SaleID';
end;

class function TPOSSale.GetBusObjectTablename: string;
begin
  result := 'tblsales_pos';
end;

function TPOSSale.GetLines: TTransLineBase;
begin
  result := GetSaleLines;
end;

function TPOSSale.GetSaleLines: TSalesLineBase;
begin
  result := GetPOSSaleLines;
end;

function TPOSSale.GetPOSSaleLines: TPOSSaleLine;
begin
  result := TPOSSaleLine(getContainerComponent(TPOSSaleLine, 'SaleID=' + IntToStr(Self.ID)));
end;

{ ========================================================
  Tposeoppayments
  ======================================================== }
constructor Tposeoppayments.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblposeoppayments';
end;

destructor Tposeoppayments.Destroy;
begin
  inherited;
end;

procedure Tposeoppayments.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetDatetimePropertyFromNode(node, 'Date');
  SetPropertyFromNode(node, 'Tillid');
  SetPropertyFromNode(node, 'Paymethod');
  SetPropertyFromNode(node, 'Amount');
end;

procedure Tposeoppayments.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'Date', Date);
  AddXMLNode(node, 'Tillid', Tillid);
  AddXMLNode(node, 'Paymethod', Paymethod);
  AddXMLNode(node, 'Amount', Amount);
end;

function Tposeoppayments.ValidateData: Boolean;
begin
  result := False;
  Resultstatus.Clear;
  if Date = 0 then begin
    Resultstatus.AddItem(False, rssError, 0, 'Date should not be blank', False);
    Exit;
  end;
  if Tillid = 0 then begin
    Resultstatus.AddItem(False, rssError, 0, 'Tillid should not be 0', False);
    Exit;
  end;
  if Paymethod = '' then begin
    Resultstatus.AddItem(False, rssError, 0, 'Payment method should not be blank', False);
    Exit;
  end;
  if Amount = 0 then begin
    Resultstatus.AddItem(False, rssError, 0, 'Amount should not be 0', False);
    Exit;
  end;
  result := True;
end;

function Tposeoppayments.Save: Boolean;
begin
  result := False;
  if not ValidateData then Exit;
  result := inherited Save;
end;

procedure Tposeoppayments.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure Tposeoppayments.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function Tposeoppayments.GetSQL: string;
begin
  result := inherited GetSQL;
end;

class function Tposeoppayments.GetIDField: string;
begin
  result := 'Id'
end;

class function Tposeoppayments.GetBusObjectTablename: string;
begin
  result := 'tblposeoppayments';
end;

function Tposeoppayments.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterPost(Sender);
end;

{ Property functions }
function Tposeoppayments.GetDate: TDatetime;
begin
  result := GetDatetimeField('Date');
end;

function Tposeoppayments.GetTillid: Integer;
begin
  result := GetIntegerField('Tillid');
end;

function Tposeoppayments.GetPaymethod: string;
begin
  result := GetStringField('Paymethod');
end;

function Tposeoppayments.GetAmount: Double;
begin
  result := GetFloatField('Amount');
end;

procedure Tposeoppayments.SetDate(const Value: TDatetime);
begin
  SetDatetimeField('Date', Value);
end;

procedure Tposeoppayments.SetTillid(const Value: Integer);
begin
  SetIntegerField('Tillid', Value);
end;

procedure Tposeoppayments.SetPaymethod(const Value: string);
begin
  SetStringField('Paymethod', Value);
end;

procedure Tposeoppayments.SetAmount(const Value: Double);
begin
  SetFloatField('Amount', Value);
end;

{ ========================================================
  TPOSSalePayments
  ======================================================== }
constructor TPOSSalePayments.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * From tblsalespayments_pos';
end;

function TPOSSalePayments.GetSQL: string;
begin
  result := inherited GetSQL;
end;

{ ========================================================
  TPOSLayby
  ======================================================== }
procedure TPOSLayby.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  Completedlayby := False;
end;

constructor TPOSLayby.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fbconvertingSO := False;
  Completedlayby := False;
  fSQL:= 'SELECT * From tblSales';
  fSQLSelect := 'IsPos = "T" and IsLayby = "T"'
end;

function TPOSLayby.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then Exit;
  IsLayby := True;
  IsPOS := True;
  IsLaybyTOS := True;
  IsCashSale := False;
end;

function TPOSLayby.GetPOSLaybylines: TPOSLaybylines;
begin
  result := TPOSLaybylines(getContainerComponent(TPOSLaybylines, 'SaleId=' + IntToStr(ID)));
end;

procedure TPOSLayby.ClonePayments(const Sender: TBusObj; var Abort: Boolean);
begin
  Sender.CloneBusObj(ObjInstanceToClone.IDFieldNAme, ObjInstanceToClone.ID, False);
end;

procedure TPOSLayby.ClonePropertyObjects;
begin
  inherited;
  SalesPayments.IterateREcords(ClonePayments);
end;

function TPOSLayby.GetCleanXMLNode: IXMLNode;
begin
  result := inherited GetCleanXMLNode;
  if GetXMLNodebooleanValue(result, 'IsPaid') = False then
    if IsPaid = True then result := nil;
end;

function TPOSLayby.GetLines: TTransLineBase;
begin
  result := GetSaleLines;
end;

function TPOSLayby.GetSaleLines: TSalesLineBase;
begin
  result := Self.GetPOSLaybylines;
end;

{ ========================================================
  TPOSLaybyPaymentlines
  ======================================================== }
procedure TPOSLaybyPaymentlines.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  if Assigned(fPOSLayby) then begin
    if (not fPOSLayby.ExternalDatasetAssigned) then FreeAndNil(fPOSLayby)
    else fPOSLayby.Dataset.close;
  end;
end;

function TPOSLaybyPaymentlines.getPOSLayby: TPOSLayby;
begin
  if not Assigned(fPOSLayby) then begin
    fPOSLayby := TPOSLayby.Create(Self);
    fPOSLayby.connection := Self.connection;
  end;
  if (fPOSLayby.SQLSelect <> 'globalref = ' + QuotedSTr(LaybyID)) or (fPOSLayby.Dataset.Active = False) then begin
    fPOSLayby.LoadSelect('globalref = ' + QuotedSTr(LaybyID));
  end;
  result := fPOSLayby;
end;

{ ========================================================
  TPOSLaybyPayment
  ======================================================== }
function TPOSLaybyPayment.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then Exit;
  IsPOS := True;
  IsCashSale := True;
  IsLaybyPayment := True;
  IsLayby := False;
  IsLaybyTOS := False;
  IsPaid := True;
end;

function TPOSLaybyPayment.GetLines: TTransLineBase;
begin
  result := GetSaleLines;
end;

function TPOSLaybyPayment.GetSaleLines: TSalesLineBase;
begin
  result := GetPOSLaybyPaymentslines;
  // fLines := result;
end;

function TPOSLaybyPayment.GetPOSLaybyPaymentslines: TPOSLaybyPaymentlines;
begin
  result := TPOSLaybyPaymentlines(getContainerComponent(TPOSLaybyPaymentlines, 'SaleId=' + IntToStr(ID)));
end;

procedure TPOSLaybyPayment.check4Completedlaybys(const Sender: TBusObj; var Abort: Boolean);
var
  msg: string;
  fscomments: string;
  fsglobalref: string;
  ffPOSLayby: TPOSLayby;
  strSQL: string;
  Qry: TERPQuery;
begin
  if not(Sender is TPOSLaybyPaymentlines) then Exit;
  if (TPOSLaybyPaymentlines(Sender).LaybyID = '') or (TPOSLaybyPaymentlines(Sender).LinePriceInc = 0) then Exit;
  if (TPOSLaybyPaymentlines(Sender).POSLayby.count = 0) then Exit;
  if not TPOSLaybyPaymentlines(Sender).POSLayby.Lock then begin
    allLinesOnk := False;
    Abort := True;
    msg := 'Unable to update Layby Sales record as it is being updated by "' + TPOSLaybyPaymentlines(Sender).POSLayby.UserLock.LockInfo.UserName + '" with: ' + TPOSLaybyPaymentlines(Sender)
      .POSLayby.UserLock.LockInfo.LockingForm;
    Resultstatus.AddItem(True, rssWarning, 0, msg);
    Exit;
  end;
  { update the balance in the original lay by record }
  if TPOSLaybyPaymentlines(Sender).POSLayby.totalBalance - TPOSLaybyPaymentlines(Sender).LinePriceInc < 0.00999 then TPOSLaybyPaymentlines(Sender).POSLayby.totalBalance := 0
  else TPOSLaybyPaymentlines(Sender).POSLayby.totalBalance := TPOSLaybyPaymentlines(Sender).POSLayby.totalBalance - TPOSLaybyPaymentlines(Sender).LinePriceInc;

  TPOSLaybyPaymentlines(Sender).POSLayby.postdb;
  if TPOSLaybyPaymentlines(Sender).POSLayby.totalBalance = 0 then begin
    ffPOSLayby := TPOSLaybyPaymentlines(Sender).POSLayby;
    ffPOSLayby.DoProductallocation := DoProductallocation;
    ffPOSLayby.IsCashSale := True;
    ffPOSLayby.IsLayby := False;
    ffPOSLayby.IsLaybyTOS := False;
    ffPOSLayby.IsPaid := True;
    ffPOSLayby.TotalPaid := ffPOSLayby.TotalAmountInc;
    ffPOSLayby.postdb;
    ffPOSLayby.convertingSO := True;
    ffPOSLayby.SalesPayments.New;
    ffPOSLayby.SalesPayments.saleId := ffPOSLayby.ID;
    ffPOSLayby.SalesPayments.Paymethod := 'Layby';
    ffPOSLayby.SalesPayments.Deleted := False;
    ffPOSLayby.SalesPayments.Amount := ffPOSLayby.TotalAmountInc;
    ffPOSLayby.SalesPayments.postdb;

    ffPOSLayby.UserLock.IgnoreClassnameinLock := True;
    try
      strSQL := ' Select  tblPQA.PQAID, tblPQA.Alloctype, ' + ' tblPQA.Active ' + ' From tblPQA ' + ' inner join tblSaleslines on ' + ' tblSaleslines.saleId =tblPQA.transId ' +
        ' and tblSaleslines.salelineId =tblPQA.translineId   ' + ' and tblPQA.Transtype = ' + QuotedSTr(ffPOSLayby.Lines.Classname) + ' and tblSaleslines.SaleId = ' + IntToStr(ffPOSLayby.ID);

      Qry := TERPQuery(getNewdataset(strSQL, True));
      with Qry do
        try
          if Qry.RecordCount > 0 then begin
            Qry.First;
            while Qry.Eof = False do begin
              if not(Qry.state in [dsEdit, dsinsert]) then Qry.Edit;
              if (AppEnv.CompanyPrefs.BarcodePickingInSOMode) then Qry.FieldByName('Alloctype').asString := 'OUT'
              else Qry.FieldByName('Active').asBoolean := False;
              if (Qry.state in [dsEdit, dsinsert]) then Qry.Post;
              Qry.Next;
            end;
          end;
        finally
          if Qry.Active then Qry.close;
          FreeAndNil(Qry);
        end;
      ffPOSLayby.Completedlayby := True;
      ffPOSLayby.Lines.First;
      while ffPOSLayby.Lines.Dataset.Eof = False do begin
        if Assigned(ffPOSLayby.DoProductallocation) then ffPOSLayby.DoProductallocation(ffPOSLayby.Lines);
        ffPOSLayby.Lines.Dataset.Next;
      end;

      ffPOSLayby.Save;
      ffPOSLayby.postdb;
    finally ffPOSLayby.UserLock.IgnoreClassnameinLock := False;
    end;

    { reverse the payment }
    ffPOSLayby.CloneBusObj('', '', False, '');
    fscomments := 'Layby no: ' + IntToStr(ffPOSLayby.ID) + ' of ' + ffPOSLayby.ClientName;
    fsglobalref := ffPOSLayby.globalref;
    ffPOSLayby.postdb;
    ffPOSLayby.Lines.IterateREcords(ActivatePQA);
    ffPOSLayby := TPOSLayby(ffPOSLayby.ObjInstanceToClone);
    ffPOSLayby.Completedlayby := True;
    ffPOSLayby.dofieldchange := False;
    try
      ffPOSLayby.InvoiceToDesc := '';
      ffPOSLayby.ShipToDesc := '';
      ffPOSLayby.TotalAmountInc := 0 - ffPOSLayby.TotalAmountInc;
      ffPOSLayby.TotalAmount := 0 - ffPOSLayby.TotalAmount;
      ffPOSLayby.TotalTax := 0 - ffPOSLayby.TotalTax;
      ffPOSLayby.totalBalance := 0;
      ffPOSLayby.comments := fscomments;
      ffPOSLayby.IsPaid := True;
      ffPOSLayby.Memo := fscomments;
      ffPOSLayby.IsLaybyPayment := True;
      ffPOSLayby.postdb;
      ffPOSLayby.SalesPayments.Amount := 0 - ffPOSLayby.SalesPayments.Amount;
      ffPOSLayby.SalesPayments.postdb;
      ffPOSLayby.IsLaybyPayment := True;
      ffPOSLayby.SalesPayments.dofieldchange := False;
      try
        ffPOSLayby.SalesPayments.Amount := 0 - ffPOSLayby.SalesPayments.Amount;
        ffPOSLayby.SalesPayments.postdb;
      finally ffPOSLayby.SalesPayments.dofieldchange := True;
      end;
      ffPOSLayby.Lines.First;
      while ffPOSLayby.Lines.Dataset.RecordCount > 0 do begin
        ffPOSLayby.Lines.Delete;
        ffPOSLayby.Lines.Dataset.First;
      end;
      ffPOSLayby.Lines.New;
      ffPOSLayby.Lines.dofieldchange := False;
      try
        ffPOSLayby.Lines.ProductName := PART_LAYBY_PAY;
        ffPOSLayby.Lines.ProductID := tcDataUtils.GetProduct(ffPOSLayby.Lines.ProductName);
        ffPOSLayby.Lines.ProductGroup := ffPOSLayby.Lines.Product.ProductGroup;
        ffPOSLayby.Lines.ProductDescription := 'Layby Completion Reversal';
        ffPOSLayby.Lines.Product_Description_Memo := ffPOSLayby.Lines.Product.SalesDescriptionMemo;
        ffPOSLayby.Lines.ProductType := 'OTHER';
        ffPOSLayby.Lines.IncomeAccount := ffPOSLayby.Lines.Product.IncomeAccount;
        ffPOSLayby.Lines.AssetAccount := ffPOSLayby.Lines.Product.AssetAccount;
        ffPOSLayby.Lines.CogsAccount := ffPOSLayby.Lines.Product.CogsAccount;
        ffPOSLayby.Lines.AutoSmartOrder := ffPOSLayby.Lines.Product.AutoSmartOrder;
        ffPOSLayby.Lines.LineTaxRate := ffPOSLayby.Lines.Product.TaxSales.Rate;
        ffPOSLayby.Lines.LineTaxCode := ffPOSLayby.Lines.Product.TaxSales.CodeName;
        ffPOSLayby.Lines.LinePriceInc := ffPOSLayby.TotalAmountInc;
        ffPOSLayby.Lines.LinePrice := ffPOSLayby.TotalAmount;
        ffPOSLayby.Lines.OriginalLinePrice := ffPOSLayby.TotalAmount;
        ffPOSLayby.Lines.LineTaxTotal := ffPOSLayby.TotalTax;
        ffPOSLayby.Lines.UnitOfMeasure := AppEnv.DefaultClass.DefaultUOM;
        ffPOSLayby.Lines.UOMMultiplier := 1;
        ffPOSLayby.Lines.UnitOfMeasureID := tcDataUtils.GetUnitOfMeasureID(AppEnv.DefaultClass.DefaultUOM, 0);
        ffPOSLayby.Lines.TotalLineAmountInc := ffPOSLayby.TotalAmountInc;
        ffPOSLayby.Lines.TotalLineAmount := ffPOSLayby.TotalAmount;
        ffPOSLayby.Lines.CreationDate := now;
        ffPOSLayby.Lines.LaybyID := fsglobalref;
        ffPOSLayby.Lines.dofieldchange := False;
        // try
        (* ffPOSLayby.Lines.LineTaxRate        := 0; *)
        ffPOSLayby.Lines.LineCost := 0;
        ffPOSLayby.Lines.LineCostInc := 0;
        (* ffPOSLayby.Lines.LineTaxTotal       := 0; *)
        ffPOSLayby.Lines.Qtysold := 1;
        ffPOSLayby.Lines.QtyShipped := 1;
        ffPOSLayby.Lines.UOMQtyShipped := 1;
        ffPOSLayby.Lines.UOMQtySold := 1;
        ffPOSLayby.Lines.Invoiced := True;
        // finally
        // ffPOSLayby.Lines.DoFieldChange      := True;
        // end;
        ffPOSLayby.Lines.postdb;
        ffPOSLayby.SalesPayments.Amount := 0 - ffPOSLayby.SalesPayments.Amount;
        ffPOSLayby.SalesPayments.postdb;
        ffPOSLayby.convertingSO := False;
      finally ffPOSLayby.Lines.dofieldchange := True;
      end;
    finally ffPOSLayby.dofieldchange := True;
    end;
    // ffPOSLayby.UserLock.UnlockAllCurrentUser;
    ffPOSLayby.UserLock.IgnoreClassnameinLock := True;
    try
      ffPOSLayby.DisableCalcOrderTotals := True;
      ffPOSLayby.Save;
    finally ffPOSLayby.UserLock.IgnoreClassnameinLock := False;
    end;
    ffPOSLayby.totalBalance := 0;
    ffPOSLayby.IsPaid := True;
    ffPOSLayby.postdb;
  end;
end;

procedure TPOSLaybyPayment.ActivatePQA(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TTransLineBase) then Exit;
  if not TTransLineBase(Sender).IsPQAItem then Exit;
  if TTransLineBase(Sender).PQA.Active = False then begin
    TTransLineBase(Sender).PQA.Active := True;
    TTransLineBase(Sender).PQA.postdb;
  end;

end;

function TPOSLaybyPayment.Save: Boolean;
begin

  // IsPos            := False;
  result := inherited Save;
  if not result then Exit;
  IsPOS := True;
  EOP_POS := True;
  IsCashSale := True;
  IsLaybyPayment := True;
  IsLayby := False;
  IsLaybyTOS := False;
  IsPaid := True;
  totalBalance := 0;
  IsPaid := True;
  postdb;

  fscomments := '';
  allLinesOnk := True;
  Lines.IterateREcords(check4Completedlaybys);
  result := allLinesOnk;

  if fscomments <> '' then begin
    comments := fscomments;
    Memo := fscomments;
  end;
end;

procedure TPOSLaybyPayment.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

function TPOSLaybyPayment.GetCleanXMLNode: IXMLNode;
begin
  result := inherited GetCleanXMLNode;
end;

{ ========================================================
  TPOSCashSaleline
  ======================================================== }
procedure TPOSCashSaleline.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

function TPOSCashSale.GeTPOSCashSaleslines: TPOSCashSaleline;
begin
  Result := TPOSCashSaleline(getContainerComponent(TPOSCashSaleline, 'SaleID = '+ IntToStr(Self.Id)));
end;

function TPOSCashSale.Save: Boolean;
begin
  postdb;
  result := inherited Save;
  if not result then Exit;
end;

function TPOSCashSale.GetSaleLines: TSalesLineBase;
begin
  result := GeTPOSCashSaleslines;
  // fLines := result;
end;

function TPOSCashSale.GetLines: TTransLineBase;
begin
  result := GetSaleLines;
end;

constructor TPOSCashSale.Create(AOwner: TComponent);
begin
  inherited;
//  fSQLSelect := ' IsCashSale = "T" and IsPos = "T"';
end;

function TPOSCashSale.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then Exit;
  IsCashSale := True;
  IsPOS := True;
  EOP_POS := True;
end;

{ ========================================================
  TPOSLaybylines
  ======================================================== }
constructor TPOSLaybylines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

(* function TPOSLaybylines.GetEnableAllc: Boolean;
  begin
  result := False;
  if (Product.Batch = false) and (Product.Multiplebins = false) then
  else  if (not (Assigned(Self.Owner))) or ( not (Self.Owner.ClassnameIS('TPOSLayby'))) then
  else
  if (AppEnv.CompanyPrefs.BarcodePickingInSOMode = False)
  and (TPOSLayby(Self.Owner).Completedlayby ) then Result := True
  else if (AppEnv.CompanyPrefs.BarcodePickingInSOMode )
  and (TPOSLayby(Self.Owner).Completedlayby = False ) then Result := True;
  end; *)
function TPOSLaybylines.GetIsPQAItem: Boolean;
begin
  result := CommonLib.IsInvProduct(Product.ProductType);
end;

function TPOSLaybylines.ISFullyPaid: Boolean;
begin
  result := False;

  if Assigned(Self.Owner) then
    if Self.Owner is TPOSLayby then result := TPOSLayby(Self.Owner).totalBalance = 0;
end;

procedure TPOSLaybylines.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited OnDataIdChange(ChangeType);
end;

(* function TPOSLaybylines.GetStockAffected       : Boolean;
  begin
  result := inherited GetStockAffected;
  end; *)
(* function TPOSLaybylines.GetIsInvProduct    : Boolean;
  begin
  REsult := inherited GetIsInvProduct;
  end; *)
function TPOSLaybyPaymentlines.GetIsPQAItem: Boolean;
begin
  result := False;
end;


initialization

RegisterClassOnce(Tposeoppayments);
RegisterClassOnce(TPOSSale);
RegisterClassOnce(TPOSSaleLine);
RegisterClassOnce(TPOSLayby);
RegisterClassOnce(TPOSLaybyLines);
RegisterClassOnce(TPOSCashSale);
RegisterClassOnce(TPOSCashSaleline);

end.
