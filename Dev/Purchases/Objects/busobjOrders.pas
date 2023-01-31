unit busobjOrders;

interface

uses
  BusObjBase, Classes, DB, Variants,
  BusObjTrans, busobjOrderBase,UserLockObj, XMLDoc, XMLIntf,
  BusObjShipContainerDetails,
  BusObjStock, contnrs, busobjEmployee, BusObjAttachment;

type

  TReturnAuthorityLine = class(TOrderLineBase)
  Private
    (*procedure AdjustRAQty;*)
    function getConvertingToPO: Boolean;
  Protected
    procedure DoFieldOnChange(Sender: TField);                Override;
    Function DoAfterInsert(Sender :TDatasetBusobj) :Boolean ; override;
    Function DoAfterPost(Sender :TDatasetBusobj) :Boolean ;   override;
    Function DoBeforePost(Sender:TDatasetBusobj) :Boolean ;   override;
    Function  GetIsPQAItem:Boolean; override;
    function GetOrderQty         :Double;    override;
    procedure SetOrderQty(const Value: Double);override;
    function GetUOMOrderQty         :Double;    override;
    procedure SetUOMOrderQty(const Value: Double);override;
    Procedure CreateInstance;override;
    function GetLineDesc: String ; override;
    //Function GetIsPQAItem:Boolean; override;
  Public
    constructor Create(AOwner: TComponent);                     Override;
    Property ConvertingToPO:Boolean read getConvertingToPO;
    function ValidateData:boolean; override;
  End;

  TReturnAuthority = Class(TOrderBase)
  Private
    fbConvertingToPO:Boolean;
    fbCreditRef: String;
      function GetRALines : TReturnAuthorityLine;
      Procedure AssignETADate(const Sender: TBusObj; var Abort: boolean);
  Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);  Override;
      procedure DoFieldOnChange(Sender: TField);  Override;
      function GetLines: TTransLineBase;          override;
      Function DoAfterInsert(Sender :TDatasetBusobj)  :Boolean; override;
      function DoAfterPost(Sender :TDatasetBusobj)    :Boolean; override;
      Procedure CreateInstance;override;
      procedure CloneLines(const Sender: TBusObj; var Abort: boolean);Override;
      function getOrderLines: TOrderLineBase;Override;
  Public
      procedure   New;                                             Override;
      property Lines                  : TReturnAuthorityLine Read GetRALines;
      function Save :Boolean; override;
      function ConvertToPO:Integer;
      constructor Create(AOwner: TComponent);                     Override;
      Property ConvertingToPO :Boolean read fbConvertingToPO write fbConvertingToPO;
      Property CreditRef :String read fbCreditRef;
      procedure PopulateMessageSubstituteList(SL: TStringList); override;
      function ValidateData: boolean; override;
      Class Function XMLNodeName :String; Override;
  End;

  TPurchaseLinePackWeightLines = class(TPackWeightLinesBase)
  private
  protected
    function getTranslineIDField:String; Override;
  public
    Constructor Create(AOwner: TComponent); Override;
    class function GetBusObjectTablename: string; Override;
  end;
  TPurchaseLinePackWeightLinesSum = class(TPurchaseLinePackWeightLines)
  private
    function getPurchaseOrderId: Integer;
  protected
  public
    Constructor Create(AOwner: TComponent);Override;
  Published
    Property PurchaseOrderId :Integer read getPurchaseOrderId ;
  end;

  TPurchaseOrderLine = class(TOrderLineBase)
  private
    fdProdInStockQty            : Double;
    fProductId                  : Integer;
    fbNew                       : Boolean;
    fShipment                   : TShipContainerDetails;
    UpdateAllProductForeignBuyPrice: boolean;
    AddAllProductForeignBuyPrice: boolean;
    fChangeQty :Double;
    fdSmalletstETADate:Tdatetime;
    fBoxesPerItem: integer;
    function  GetProdInStockQty : Double;
    Function  GetBOCleanQty     : Double;
    //Procedure UpdateproductAverageCost(var Tempcost :Double; intrans:Boolean);
    Function  getIsPOForeign:Boolean;
    function getShipment: TShipContainerDetails;
    function getSmalletstETADate: TDatetime;
    Procedure SmalletstETADateCallback(const Sender: TBusObj; var Abort: boolean);
    Function CopyingToPO: Boolean;
    Function CopyingToRA: Boolean;
    function getPurchaseLinePackWeight: TPurchaseLinePackWeightLines;
    function getPurchaseLinePackWeightSum: TPurchaseLinePackWeightLinesSum;
    function GetGeneralNotes: string;
    function GetLineDescription: string;
    procedure SetGeneralNotes(const Value: string);
    procedure SetLineDescription(const Value: string);
    function GetBoxesReceived: integer;
    procedure SetBoxesReceived(const Value: integer);
    function GetBoxesOrdered: integer;
    procedure SetBoxesOrdered(const Value: integer);
    function getCleanReceivedDate: TDatetime;
    function getCleanETADate: TDatetime;
    function getpackweightField: Double;
    (*Procedure callbackChangeOrderQty(Const Sender: TBusObj; var Abort: Boolean);*)

  protected
    procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);  Override;
    function  GetSQL                                : String;   Override;
    Function  DoAfterOpen(Sender :TDatasetBusObj )  : Boolean;  Override;
    function  DoBeforeDelete(Sender: TDatasetBusObj): Boolean;  Override;
    function  DoBeforePost(Sender: TDatasetBusObj)  : Boolean;  Override;
    function  DoAfterInsert(Sender: TDatasetBusObj) : Boolean;  Override;
    function  DoBeforeInsert(Sender: TDatasetBusObj): Boolean;  Override;
    Function  DoAfterPost(Sender :TDatasetBusObj )  : Boolean;  Override;
    Function  DoNewRecord(Sender :TDatasetBusObj )  : Boolean;  Override;
    function  GetTransDate                          : TDateTime;Override;
    procedure SetTransDate      (const Value: TDatetime ); override;
    procedure DoFieldOnChange(Sender: TField);                  Override;
    procedure GetProductDetails;                                Override;
    procedure InitializeNewObject;                              Override;
    function GetLineDesc: String ; override;
    Procedure CreateInstance;override;
    Function  GetIsPQAItem:Boolean; Override;
    Procedure EquipmentAreaforline(const Value :String);
  public
    ChangingETADate:Boolean;
    Constructor Create(AOwner: TComponent);                     Override;
    Class function GetBusObjectTablename: string; Override;
    destructor  Destroy;                                         Override;
    Function    ValidateData                        : Boolean;  Override;
    Function    CalcBaseLineAmount                  : Double;   Override;
    Function    getCurrentBackOrderId(var ErrMsg: String; var Editable: Boolean; var POLineId :Integer): Integer;
    Function    CloneBusObj(const Changefield :String; const ChangeValue :Variant; const SaveAfterCopy : Boolean = True; const FilterFields :String = ''):TBusObj; Override;
    Procedure   AfterCloneBusObj; Override;
    procedure   CheckAndUpdateProductForeignBuyPrice;override;
    procedure   CalcLineTotals;                                 Override;
    procedure   CalcLineForeignTotals;
    procedure   New;                                            Override;
    Procedure   ChangeOrderQty;
    Property    IsPOForeign  :Boolean read getIsPOForeign;
    Property    Shipment :TShipContainerDetails read getShipment;
    Procedure ApplyPODiscountPercent;
    Property SmalletstETADate :TDatetime read getSmalletstETADate;
    procedure CalcLineCostFromTotal;                            Override;
    Function isOKTODelete:Boolean;
    procedure LoadBoxesPerItem;
    property BoxesPerItem : integer read fBoxesPerItem write fBoxesPerItem;
    Property cleanReceivedDate  : TDatetime read getCleanReceivedDate;
    Property CleanETADate  : TDatetime read getCleanETADate;
    procedure   SaveToXMLNode(Const Node: IXMLNode);    Override;
    procedure   LoadFromXMLNode(Const Node: IXMLNode);  Override;
  Published
    Property    ProdInStockQty          :   Double      Read getProdInStockQty;
    Property    CleanBOQty              :   Double      Read GetBOCleanQty;
    Property PurchaseLinePackWeight: TPurchaseLinePackWeightLines read getPurchaseLinePackWeight;
    Property PurchaseLinePackWeightSum: TPurchaseLinePackWeightLinesSum read getPurchaseLinePackWeightSum;
    property GeneralNotes : string read GetGeneralNotes write SetGeneralNotes;
    property LineDescription : string read GetLineDescription write SetLineDescription;
    property BoxesReceived : integer read GetBoxesReceived write SetBoxesReceived;
    property BoxesOrdered : integer read GetBoxesOrdered write SetBoxesOrdered;
    Property packweightField : Double read getpackweightField;
  end;

  TPurchaseOrder = class(TOrderBase)
  private
    fdPercentageUseImportCost   : Double;
    fdImportCosts               : Double;
    tmpTotalQtyShipped          : Double;
    tmpNonBOMtotalQtyShipped    : double;
    tmpTotalQtyOrdered          : Double;
    tmpTotalQtyBackOrdered      : Double;
    tmpTotalForeignAmount       : Double;
    tmpTotalEstimatedAmountInc  : Double;
    tmpEstimatedForeignAmountInc: Double;
    fTotalQtyShipped            : Double;
    fNonBOMtotalQtyShipped      : Double;
    fTotalQtyOrdered            : Double;
    fTotalEstimatedAmountInc    : Double;
    fEstimatedForeignAmountInc  : double;
    fTotalQtyBackOrdered        : Double;
    fsBackOrderFilter           : String;
    fOriginalOrder              : TPurchaseOrder;
    fBackOrder                  : TPurchaseOrder;
    AllLinesSavedOK             : Boolean;
    fbValidated                 : Boolean;
    fbGoodsReceived             : Boolean;
    Sale                        : TTransBase;
    LinedLinkedtosalesfound     : Boolean;
    fdDiscountPercent: double;
    fConvertingRepairFromSmartOrder: boolean;
    fbCheckingForShipTo :Boolean;
    (*fPOLinesofGroup             : TPurchaseOrderLine;*)
    function  GetSeqNo                      : Integer;
    function  GetOriginalPurchaseOrder      : TPurchaseOrder;
    function  GetBackOrderPurchaseOrder     : TPurchaseOrder;
    function  GetLastOrderOfGroup           : TPurchaseOrder;
    Function  GetPercentageUseImportCost    : Double;
    function  getBuildBackOrderFilter       : String;
    function  GetHasImportCosts             : Boolean;
    Function  getGoodsReceived              : Boolean;
    function  getbinGoodsReceived           : Boolean;
    Function  CheckBackorders(BOPO:TPurchaseOrder)               : Boolean;
    procedure SetSeqNo                      (const Value: Integer);
    procedure LineSaveCallbackProc          (Const Sender: TBusObj; var Abort: Boolean);
    //procedure LineSaveRepairParts           (const Sender: TBusObj; var Abort: Boolean);
    procedure CheckGoodsReceived            (Const Sender: TBusObj; var Abort: Boolean);
    procedure CalcPercentageUseImportCost   (Const Sender: TBusObj; var Abort: Boolean);
    procedure ProductBackOrderIds           (Const Sender: TBusObj; var Abort: Boolean);
    procedure FindImportCosts               (Const Sender: TBusObj; var Abort: Boolean);
    procedure COGSValueUpdate;
    procedure UpdateLineAvgCost             (Const Sender: TBusObj; var Abort: Boolean);
    procedure CalcAllForeignLineTotals;
    function UpdateLinkedSale: boolean;
    Function IsLinkedtoSales:Boolean;
    Procedure checklinesLinkedtoSales       (Const Sender: TBusObj; var Abort: Boolean);
    Procedure UpdateLinkedSaleCallback      (Const Sender: TBusObj; var Abort: Boolean);
    Procedure SetShiptofromLines      (Const Sender: TBusObj; var Abort: Boolean);

    function getsalesGlobalref: String;
    function getEquipmentname: String;
    function GetEquipmentId :Integer;
    procedure setsalesGlobalref(const Value: String);
    procedure setEquipmentname(const Value: String);
    Procedure SetEquipmentId(Const Value:Integer);
    function getSaleLineRef: String;
    procedure setSaleLineRef(const Value: String);
    function getInvoiceID: Integer;
    function getSalesORderID: Integer;
    function getTEmployee: TEmployee;
    function GetCreatedFromSO: integer;
    function GetSOApprovedBy: integer;
    procedure SetCreatedFromSO(const Value: integer);
    procedure SetSOApprovedBy(const Value: integer);
    function getFuturePo: boolean;
    procedure SetFuturePo(const Value: boolean);
    function getPurchaseLinePackWeightLinesSum: TPurchaseLinePackWeightLinesSum;
    function getLinkPORef: String;
    procedure setLinkPORef(const Value: String);
    Function CheckForShipToFlags(Sender :Tfield):Boolean;
    function ShiptoCustomerAddress: String;

    (*function getPOLinesofGroup: TPurchaseOrderLine;*)
  protected
    function  GetSQL                        : String;                                   Override;
    function  GetLines                      : TTransLineBase ;                          Override;
    procedure CalcTotalsCallback            (Const Sender: TBusObj; var Abort: Boolean);Override;
    procedure OnDataIdChange                (Const ChangeType: TBusObjDataChangeType);  Override;
    function  DoBeforePost                  (Sender: TDatasetBusObj): Boolean;          Override;
    Function  DoAfterOpen                   (Sender :TDatasetBusObj )  : Boolean;  Override;
    procedure DoFieldOnChange               (Sender: TField);                           Override;
    procedure LineBalanceCallbackProc       (Const Sender: TBusObj; var Abort: Boolean);Override;
    function  UpdateAccounts                 : Boolean;                                  override;
    function  DoAfterPost                   (Sender :TDatasetBusobj)    :Boolean;       override;
    procedure LineValidateCallbackProc      (Const Sender: TBusObj; var Abort: Boolean); override;
    Procedure NewBOInit(BackOrder:TTransBase); override;
    Procedure BOLinesInit(BackOrder:TTransBase); override;
    Procedure ProcessDeletedLine; override;
    function DeleteFlaggedLines: boolean; override;
    Procedure ProcessLine; override;
    function getOrderLines: TOrderLineBase;Override;
    function AmountToApprove:Double;Override;
    Procedure CreateInstance;override;
    procedure CloneLines(const Sender: TBusObj; var Abort: boolean);Override;
    Function DoAfterInsert(Sender :TDatasetBusobj)  :Boolean; override;
    function  GetPOLines                    : TPurchaseOrderLine; virtual;
    function getApprovaltype: String;override;

  public
    ChangingETADate:Boolean;
    CopyingToPO :Boolean;
    CopyingToRA :Boolean;
    constructor Create                      (AOwner: TComponent);Override;
    class function GetBusObjectTablename: string; Override;
    destructor  Destroy;                                         Override;
//    function    ValidateApproval : boolean; override;
    Function    CloneBusObj(const Changefield :String; const ChangeValue :Variant; const SaveAfterCopy : Boolean = True; const FilterFields :String = ''):TBusObj; Override;
    Function    LineAlReadyExixts4Product(fiProductID, fiLineID:Integer):Boolean;
    function    ValidateData                : Boolean;           Override;
    function    Save                        : Boolean;           Override;
    procedure   CalcOrderTotals;                                 Override;
    procedure   SetPaymentTerms(const BaseDate: TDateTime);      Override;
    procedure   Load(Const aId: Integer;const fIsReadonly:boolean =False);Override;
    procedure   Load(const fIsReadonly:boolean =False); Override;
    procedure   New;                                             Override;
    procedure   LoadXML;
    procedure   UpdateProductAvgCosts;
    function LockTrans(var ErrMsg: String): Boolean;Override;
    class function GetKeyStringField: string; override;
    Class function LockLinkedPOs(const SaleLineID:Integer; const UserLock :TUserLock;const LockGroupName,ProductName :STring;var Msg:STring):Boolean;
    Class Function DeleteLinkToPO(const SaleLineID:Integer):String;
    function CopyPOToPO: Integer;
    function CopyPOToRA: integer;

    property OriginalPurchaseOrder  : TPurchaseOrder Read GetOriginalPurchaseOrder;
    property BackOrderPurchaseOrder : TPurchaseOrder Read GetBackOrderPurchaseOrder;
    property LastOrderOfGroup       : TPurchaseOrder Read GetLastOrderOfGroup;
    Property EstimatedForeignAmountInc:Double        Read fEstimatedForeignAmountInc write fEstimatedForeignAmountInc;
    property TotalQtyOrdered        : Double         Read fTotalQtyOrdered          write fTotalQtyOrdered;
    property TotalQtyBackOrdered    : Double         Read fTotalQtyBackOrdered      write fTotalQtyBackOrdered;
    property TotalQtyShipped        : Double         Read fTotalQtyShipped          write fTotalQtyShipped;
    Property NonBOMtotalQtyShipped  : Double         Read fNonBOMtotalQtyShipped    write fNonBOMtotalQtyShipped;
    Property PercentageUseImportCost: Double         Read GetPercentageUseImportCost;
    Property HasImportCosts         : Boolean        Read GetHasImportCosts;
    Property BuildBackOrderFilter   : String         Read GetBuildBackOrderFilter;
    Property Validated              : Boolean        Read fbValidated               Write fbValidated;
    Property GoodsReceived          : Boolean        Read getGoodsReceived;
    Property binGoodsReceived       : Boolean        Read getbinGoodsReceived;
    procedure   SaveToXMLNode(Const Node: IXMLNode);    Override;
    procedure   LoadFromXMLNode(Const Node: IXMLNode);  Override;
    Property DiscountPercent :double read fdDiscountPercent write fdDiscountPercent;
    (*Property    POLinesofGroup :TPurchaseOrderLine read getPOLinesofGroup;*)
    procedure UpdateForeignRateForDate;
    Property SalesORderID :Integer read getSalesORderID;
    Property InvoiceID :Integer read getInvoiceID;
    property  Employee : TEmployee read getTEmployee;
    property SeqNo: Integer Read getSeqNo write setSeqNo;
    procedure ReDistributeLineLandedCost;
    procedure CalcAllLineTotals;Override;
    function HasEquipnSerailProduct:Boolean;

    property ConvertingRepairFromSmartOrder : boolean read fConvertingRepairFromSmartOrder write fConvertingRepairFromSmartOrder;
    Property PurchaseLinePackWeightSum : TPurchaseLinePackWeightLinesSum read getPurchaseLinePackWeightLinesSum;
    procedure Shiptodept(aClassID: Integer);
  Published
    property CreatedFromSmartOrder: integer read GetCreatedFromSO write SetCreatedFromSO;
    property SmartOrderApprovedBy : integer read GetSOApprovedBy write SetSOApprovedBy;
    Property SalesGlobalref :String read getsalesGlobalref Write setsalesGlobalref;
    Property Equipmentname :String read getEquipmentname Write setEquipmentname;
    Property EquipmentId :Integer read getEquipmentId write setEquipmentId;
    Property SaleLineRef :String read getSaleLineRef Write setSaleLineRef;
    property FuturePo : boolean read getFuturePo write SetFuturePo;
    property TotalEstimatedAmountInc: Double         Read fTotalEstimatedAmountInc  write fTotalEstimatedAmountInc;
    property Lines                  : TPurchaseOrderLine Read GetPOLines;
    Property LinkPORef :String read getLinkPORef Write setLinkPORef;

  end;

  TPurchaseOrderBackOrder = class(TPurchaseOrder)
  public
    constructor Create (AOwner: TComponent); override;
    class function GetBusObjectTablename: string; Override;
  end;

  TPurchaseOrderNonBackOrder = class(TPurchaseOrder)
  public
    constructor Create (AOwner: TComponent); override;
  end;

  TProductTotalQty = class(TObject)
  public
    ProductId: integer;
    TotalQtyShipped: double;
    TotalQtyToAllocate: double;
    TotalQtyInStock: double;
  end;

  TProductTotalQtyList = class(TObject)
  private
    fList: TObjectList;
    function GetItem(index: integer): TProductTotalQty;
    function GetItemById(aProductId: integer): TProductTotalQty;
  public
    constructor Create;
    destructor Destroy; override;
    function Count: integer;
    property Item[index: integer]: TProductTotalQty read GetItem;
    property ItemById[aId: integer]: TProductTotalQty read GetItemById;
    procedure Add(aProduct: TProduct; aQty: double);
  end;

  TPurchaseOrderEx = class(TPurchaseOrder)
  private
  published
    property Attachments;
  end;

  TReturnAuthorityEx = class(TReturnAuthority)
  private
  published
    property Attachments;
  end;
//const
  //RALineStatusCommaText = '"Awaiting RA No.","In Transit",Returned,"Send To Supplier",Testing,"With Supplier"';

implementation

uses
  SysUtils, Dialogs, Controls,CommonLib,   MyAccess,ERPdbComponents,
  tcDataUtils, DateUtils,BusObjConst,
   tcConst,BusObjGeneral,
   DNMLib, AppEnvironment,
  BusObjGLAccount, BusObjClient, DNMAccessManager, DecimalRounding,
  BusObjSaleBase, BusObjSales, SalesConst, CommonDbLib,
  busobjAreaCodes, Math, Forms, BusObjProductClass, DbSharedObjectsObj,
  ApprovalObj, LogLib, BusObjApprovals, BusObjClass, BusObjShippingAddress;


  { TReturnAuthority }

function TReturnAuthority.GetRALines : TReturnAuthorityLine;
begin
    result := TReturnAuthorityLine(Getcontainercomponent(TReturnAuthorityLine ,'PurchaseOrderId = ' + IntToStr(Self.ID)));
end;
function TReturnAuthority.GetLines: TTransLineBase;
begin
    result:= GetRALines;
end;
Function TReturnAuthority.DoAfterPost(Sender :TDatasetBusobj) :Boolean ;
begin
    Result := inherited DoAfterPost(Sender);
    if not result then Exit;
    if DocNumber = '' then begin
        DocNumber := IntToStr(ID);
        PostDB;
    end;
end;

Function TReturnAuthority.DoAfterInsert(Sender :TDatasetBusobj) :Boolean ;
begin
    Result := inherited DoAfterInsert(Sender);
    if not result then Exit;
    OrderDate   := Date;
    IsPO        := False;
    IsRA        := True;
    IsPOCredit  := False;
    InitAPAccount;
end;
function TReturnAuthority.Save :Boolean;
begin
  if not dirty then begin
      result := true;
      Exit;
  end;
  ResultStatus.Clear;
  result := ValidateData;
  if not result then exit;

  Result := false;
  try
    postdb;
    CalcOrderTotals;
    REsult := (inherited Save);
  finally
    if result then  result :=  Validtocommit;
  end;
  if result then begin
    if DeleteFlaggedLines then    Dirty := False else result := False;
  end;

end;

function TReturnAuthority.ValidateData: boolean;
begin
  Result := inherited ValidateData;
  if Result = False then Exit;
  if AppEnv.CompanyPrefs.EnforceConNoteOnRA then
    if ConNote = '' then begin
      ResultStatus.Additem(False, rssWarning, 0, 'Con Note Number must be specified.' );
      Result := false;
      Exit;
    end;
  result := true;
end;

class function TReturnAuthority.XMLNodeName: String;
begin
  result := 'ReturnAuthority';
end;

procedure TReturnAuthority.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.fieldName , 'clientID' ) then begin
      if ClientID > 0 then begin
        DueDate := Now +  Supplier.ShipTime;
        InitAPAccount;
        Shipping := Supplier.ShippingMethodName;
        DoFieldOnChange(Dataset.findfield('Shipping'));
        if TermsName = '' then TermsName :=TERMS_ON_RCPT;
        DoFieldOnChange(Dataset.findfield('terms'));
        OrderTo := Supplier.ShipToAddress;
        PostDB;
      end;
    end else if Sysutils.SameText(Sender.fieldName , 'AccountName') then begin
        GLAccountId := tcDatautils.getaccountId(GLAccountName);
        DoFieldOnChange(Dataset.findfield('AccountID'));
    end else if Sysutils.SameText(Sender.fieldName , 'AccountId') then begin
        if GLAccountName= '' then GLAccountName := GLAccount.AccountName;
    end else if Sysutils.SameText(Sender.fieldName , 'SupplierName') then begin
        ClientId:=0;
        if self.SupplierName <> '' then
          ClientId := Supplier.ID;
        DoFieldOnChange(DAtaset.findfield('clientID'));
    end;
end;

  // -----------------------------------------------------------------------------
  { TReturnAuthorityLine }
  // -----------------------------------------------------------------------------
//Function TReturnAuthorityLine.GetIsPQAItem:Boolean; begin Result := False; end;
Function TReturnAuthorityLine.DoAfterPost(Sender :TDatasetBusobj) :Boolean ;
begin
    Result := inherited DoAfterPost(Sender);
    if not result then exit;

end;
Function TReturnAuthorityLine.DoAfterInsert(Sender :TDatasetBusobj) :Boolean ;
begin
    Result := inherited DoAfterInsert(Sender);
    if not REsult then Exit;
    if Assigned(Self.Owner) then
        if Self.Owner is TReturnAuthority then begin
            PurchaseOrderId  := TReturnAuthority(Self.Owner).ID;
            if AppEnv.CompanyPrefs.RALineDefaultStatus <> '' then
              self.RAstatus:= AppEnv.CompanyPrefs.RALineDefaultStatus;
        end;
end;

(*procedure TReturnAuthorityLine.AdjustRAQty;
begin
        if RAQty <= 0 then begin
            RAQty           := 0;
            QtyShipped      := 0;
            Qtysold         := 0;
            UOMQtySold      := 0;
            UOMQtyShipped   := 0;
        end else if RAQty > 0 then begin {Negate the values}
            QtyShipped      := -(RAQty);
            QtySold         := -(RAQty);
            UOMQtySold      := -(RAQty);
            UOMQtyShipped   := -(RAQty);
        end;
end;*)

procedure TReturnAuthorityLine.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
        inherited;
    if Sysutils.SameText(Sender.FieldName , 'TotalLineAmountInc') then begin
        if QtyShipped = 0 then begin
          PostDb;
          TotalLineAmountInc := 0;
          TotalLineAmount := 0;
          LineTaxTotal:= 0;
          PostDb;
        end
        else begin
          TotalLineAmount := Round(TotalLineAmountInc / (1 + LineTaxRate),(*self.RoundPlacesGeneral*)CurrencyRoundPlaces);
          LineTaxTotal    := TotalLineAmountInc - TotalLineAmount;
        end
{-->} end else if Sysutils.SameText(Sender.fieldName , 'RAQty' ) then begin
//        AdjustRAQty;
        UOMQtySold:= - Sender.AsFloat;
        QtySold := CommonLib.Round(UOMQtySold * UOMMultiplier, self.RoundPlacesGeneral);
        OriginalCost := Round(self.CalcBaseLineAmount,RoundPlacesGeneral);
        Linecost := GetAmountEx(OriginalCost,DiscountPercent/100);
        LineCostInc := Round(LineCost * (1 + LineTaxRate),RoundPlacesGeneral);

        FormulaQtyShippedValue := FormulaQtySoldValue;
        FormulaQtyShippedValue1:= FormulaQtySoldValue1;
        FormulaQtyShippedValue2 := FormulaQtySoldValue2;
        FormulaQtyShippedValue3 := FormulaQtySoldValue3;
        FormulaQtyShippedValue4 := FormulaQtySoldValue4;
        FormulaQtyShippedValue5 := FormulaQtySoldValue5;

        UOMQtyShipped:= - Sender.AsFloat;
        QtyShipped := CommonLib.Round(UOMQtyShipped * UOMMultiplier, self.RoundPlacesGeneral);

        CalcLineTotals;
        if Assigned(Owner) and (Owner is TOrderBase) then TOrderBase(Owner).DoCalcOrderTotals;

        Invoiced := QtyShipped <> 0;
        if ReceivedDate  =0 then
          ReceivedDate    := Now
    end else if Sysutils.SameText(Sender.FieldName , 'UnitofMeasurePOLines') then begin
        DoFieldOnChange(Dataset.findField('RAQty'));
    end else if Sysutils.SameText(Sender.fieldName , 'ProductID') then begin
        RAQty := 1;
        DoFieldOnChange(Dataset.findField('RAQty'));
    end else if Sysutils.SameText(Sender.fieldName , 'Linecost') then begin
        LinecostInc := GetamountInc(linecost , LineTaxRate);
        CalcLineTotals;
    end else if Sysutils.SameText(Sender.fieldName , 'LinecostInc') then begin
        Linecost := GetamountEx(linecostInc , LineTaxRate);
        CalcLineTotals;
    end else if Sysutils.SameText(Sender.FieldName , 'ProductName') then begin
        if Sender.AsString = '' then
          exit;
        if ProductId <> 0 then begin
          RAQty := 1;
          DoFieldOnChange(Dataset.findField('RAQty'));
        end;
    end;
end;

// -----------------------------------------------------------------------------
  { TPurchaseOrderLine }
  // -----------------------------------------------------------------------------
procedure TPurchaseOrderLine.InitializeNewObject;
begin
    inherited;
    CogsAccntId := tcDataUtils.getAccountID('Cost of Goods Sold');
    CogsAccount := 'Cost of Goods Sold';
    AccountName := 'Accounts Payable';
end;
function TPurchaseOrderLine.isOKTODelete: Boolean;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(connection.Connection);
  try
    qry.SQL.Text := 'Select '+
                    ' count(E.EquipmentID) as ctr '+
                    ' from tblpurchaselines PL '+
                    ' inner join tblpqa PQA on PL.PurchaseLineID = PQA.TransLineID and PL.PurchaseOrderID = PQA.TransID and PQA.transtype = "TPurchaseOrderLine" '+
                    ' inner join tblpqadetails PQASN on PQASN.pqaid = PQA.PQAID and PQASN.PQAType ="SN" and ifnull(PQASN.Value,"")<>"" '+
                    ' inner join tblequipment E on E.SerialNumber = PQASN.Value and ifnull(E.SerialNumber, "") <> ""  and E.active ="T"'+
                    ' Where PL.PurchaseLineID = '+ inttostr(id);
     qry.open;
     result := qry.fieldbyname('ctr').AsInteger=0;
     if not result then
      ResultStatus.AddItem(true, rssWarning, 1, 'It is not Possible to Delete ' + Quotedstr(ProductName)+'. Some of the Serial Numbers of this Order is Assigned to Equipment.' , true);
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TPurchaseOrderLine.LoadBoxesPerItem;
var
  qry : TERPQuery;
begin
  if ProductId = 0 then
    exit;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := GetSharedMyDACConnection;
    qry.sql.text := 'select NoOfBoxes from tblUnitsOfMeasure where UnitId=' + IntToStr(UnitOfMeasureID);//PartId='+IntToStr(ProductId);
    qry.Open;
    if qry.RecordCount = 0 then
      BoxesPerItem := 1
    else if qry.Fields[0].asInteger = 0 then
      BoxesPerItem := 1
    else
      BoxesPerItem := qry.Fields[0].asInteger;
//    BoxesReceived := 0;
    BoxesReceived := Trunc(UOMQtyShipped * BoxesPerItem);
    BoxesOrdered := trunc(UOMQtySold * BoxesPerItem);
  finally
    qry.Free;
  end;

end;

procedure TPurchaseOrderLine.LoadFromXMLNode(const Node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node, 'GeneralNotes');
end;

Function  TPurchaseOrderLine.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
  inherited DoAfterPost(Sender);
  if fbNew then
    Dataset.REfresh; // sort purpose
  Result := True;
end;

//Function  TPurchaseOrderLine.DoAfterInsert(Sender :TDatasetBusObj):Boolean;
//begin
//  if Assigned(Self.Owner) then
//    if Self.Owner is TPurchaseOrder then begin
//      TPurchaseOrderLine(Self).ETADate := IncWeek(Now,1); //EmployeePaySettings.Employeeid;
//     // DepartmentName := Temployeepay(Self.Owner).EmployeeDetails.Defaultclassname;
//     // ClassID := DnMLib.GetClassID(DepartmentName);
//    end;
//    Result := inherited DoAfterInsert(Sender);
//end;

//procedure TPurchaseOrderLine.CalcProdInStockQty(Const Sender: TBusObj; var Abort: Boolean);
//begin
//    if fProductId =  Self.ProductID then
//        fdProdInStockQty := fdProdInStockQty + CleanQty;
//end;

function TPurchaseOrderLine.GetProdInStockQty: Double;
begin
    fdProdInStockQty := 0;
    fProductId := Self.ProductID;
    //Self.IterateRecords(CalcProdInStockQty);
    //Result := Self.Product.TotalQtyInStock - fdProdInStockQty;
    with getNewDataset('Select Sum(shipped) as Qtyshipped ' +
                        ' from tblPurchaseLines ' +
                        ' where ProductId = ' +IntToStr(Self.ProductID) +
                        ' and PurchaseOrderID = ' + IntToStr(self.HeaderID)) do try
        Result := Self.Product.TotalQtyInStock - FieldByname('Qtyshipped').asFloat;
    finally
        close;
        Free;
    end;
end;
function TPurchaseOrderLine.GetBOCleanQty: Double;
begin
  Result := GetXMLNodeFloatValue(CleanXMLNode, 'QtyBackOrder');
end;

function TPurchaseOrderLine.GetBoxesOrdered: integer;
begin
  Result := GetIntegerField('BoxesOrdered');
end;

function TPurchaseOrderLine.GetBoxesReceived: integer;
begin
  Result := GetIntegerField('BoxesReceived');
end;

constructor TPurchaseOrderLine.Create(AOwner: TComponent);
begin
  inherited;
  ChangingETADate := False;
  fBusObjectTypeDescription := 'Purchase Order Line Object';
  UpdateAllProductForeignBuyPrice:= false;
  AddAllProductForeignBuyPrice:= false;
  {separate access level for the lines}
  if not Assigned(fAccessManager) then Begin
    fAccessManager := TDNMAccessManager.Create(Self);
    fAccessManager.Accesslevel := AppEnv.AccessLevels.GetEmployeeAccessLevel('FnPurchaseLines');
    if fAccessManager.Accesslevel = 6 then fAccessManager.Accesslevel := 5;
  end;
  self.ExportExcludeList.Add('accountgroup');
  self.ExportExcludeList.Add('assetaccntid');
  self.ExportExcludeList.Add('batch');
  self.ExportExcludeList.Add('cleanboqty');
  self.ExportExcludeList.Add('cogsaccntid');
  self.ExportExcludeList.Add('customerjobid');
  self.ExportExcludeList.Add('employeeid');
  self.ExportExcludeList.Add('incomeaccntid');
  self.ExportExcludeList.Add('isempty');
  self.ExportExcludeList.Add('isvoucher');
  self.ExportExcludeList.Add('keyvalue');
  self.ExportExcludeList.Add('lastlienid');
  self.ExportExcludeList.Add('lineclassid');
  self.ExportExcludeList.Add('originalcost');
  self.ExportExcludeList.Add('originalqtyordered');
  self.ExportExcludeList.Add('purchaselineid');
  self.ExportExcludeList.Add('purchaseorderid');
  self.ExportExcludeList.Add('rainvoiceno');
  self.ExportExcludeList.Add('ralineref');
  self.ExportExcludeList.Add('raqty');
  self.ExportExcludeList.Add('rastatus');
  self.ExportExcludeList.Add('relatedpoid');
  self.ExportExcludeList.Add('relatedpoidused');
  self.ExportExcludeList.Add('sortid');
  self.ExportExcludeList.Add('usetimecost');
  self.ExportExcludeList.Add('voucherno');
end;

procedure TPurchaseOrderLine.CreateInstance;
begin
    if Owner is TPurchaseOrder then
        if Assigned(TPurchaseOrder(Owner).ObjInstanceToClone) then
          if TPurchaseOrder(Owner).ObjInstanceToClone is TPurchaseOrder then
            ObjInstanceToClone :=TPurchaseOrder(TPurchaseOrder(Owner).ObjInstanceToClone).Lines
          else if TPurchaseOrder(Owner).ObjInstanceToClone is TReturnAuthority then
            ObjInstanceToClone := TReturnAuthority(TPurchaseOrder(Owner).ObjInstanceToClone).Lines;
end;

function TPurchaseOrderLine.getCleanReceivedDate: TDatetime;
begin
  Result := GetXMLNodeDatetimeValue(CleanXMLNode, 'ReceivedDate');
end;
function TPurchaseOrderLine.getCleanETADate: TDatetime;
begin
  Result := GetXMLNodeDatetimeValue(CleanXMLNode, 'ETADate');
end;

function TPurchaseOrderLine.getCurrentBackOrderId(var ErrMsg: String; var Editable: Boolean; var POLineId :Integer): Integer;
var
  //Qry: TERPQuery;
  iId :Integer;
  strSQL :String;
begin
  ErrMsg := '';
  Editable := false;
    {The functionality is only for Purchase order and the object expects to
    have a PurchaseOrder which owns the lines. }
  if not (Self.Owner is TPurchaseOrder) then begin
    ErrMsg   := 'Not a Purchase Order';
    Editable := false;
    Result   := 0;
    Exit;
  end;
    {if BOID is blank, there is no back order and the current PO is editable for the qty
    This is when the shipmnet was made completely}
  if Trim(TPurchaseOrder(Self.Owner).GetBackOrderGlobalRef) = '' then begin
    Editable := true;
    Result   := TPurchaseOrder(Self.Owner).PurchaseOrderId;
    Exit;
  end;
  strSQL :=      'Select Max(PurchaseLineID) as PurchaseLineID ' +
                    'from tblPurchaseLines ';
  if baselineno <> 0 then
        strSQL := strSQL + 'where baselineno = ' + IntToStr(BaselineNo)
  else strSQL := strSQL + 'where baselineno = ' + IntToStr(Self.ID);
  With getNewDataset(strSQL , True) do try
      if recordcount = 0 then begin
        Editable := true;
        Result   := TPurchaseOrder(Self.Owner).PurchaseOrderId;
        Exit;
      end;
      if FieldByname('PurchaseLineID').asInteger  = self.Id then begin
        Editable := true;
        Result   := TPurchaseOrder(Self.Owner).PurchaseOrderId;
        Exit;
      end;
      iid :=FieldByname('PurchaseLineID').asInteger ;
  Finally
      if Active then Close;
      Free;
  End;
  strSQL := 'Select PurchaseOrderId, purchaseLineId, QtySold, backorder, shipped ' +
        'from tblPurchaseLines where purchaseLineID= ' + IntToStr(iid);
  With getnewDataset(strSQL , TRue) do try
      if fieldByname('QtySold').asFloat = fieldByname('Shipped').asFloat  then begin
          ErrMsg := 'The shipment of this product is completed, so cannot modify the quantity';
          Editable := false;
          Result := fieldByname('PurchaseOrderID').asInteger;
          POLineId := FieldByname('PurchaseLineID').asInteger;
          Exit;
      end;
      Result := fieldByname('PurchaseOrderID').asInteger;
      POLineId := FieldByname('PurchaseLineID').asInteger ;
      Editable := true;
  finally
      if Active then Close;
      Free;
  end;
end;


function TPurchaseOrderLine.GetGeneralNotes: string;
begin
  Result := GetStringField('GeneralNotes');
end;
function TPurchaseOrderLine.GetLineDescription: string;
begin
  Result := GetStringField('LineDescription');
end;

function TPurchaseOrderLine.CalcBaseLineAmount: Double;
var
  ForeignAmount: Double;
begin
      DiscountPercent:= 0;
      DiscountAmount:= 0;
  Result := 0.00;
  ForeignAmount := 0.00;

  // now foreign amounts
  if (AppEnv.CompanyPrefs.UseForeignCurrencyonPO) AND (IsPOForeign) then begin
    if Assigned(Owner) and (Owner is TPurchaseOrder) then begin
        {foreign price is the inc - done for UK}
      ForeignAmount := Product.ForeignPriceBuy.GetBuyPrice(TPurchaseOrder(Owner).SupplierId,
        TPurchaseOrder(Owner).FXObj.GetCurrencyID(TPurchaseOrder(Owner).ForeignExchangeCode), QtyShipped, unitofmeasureId);
    end;

    if ForeignAmount <> 0 then begin
      // is the price for this currency

      if TPurchaseOrder(Owner).ForeignExchangeCode = Product.ForeignPriceBuy.CurrencyCode then begin
        // set the foreign amount on the invoice
        ForeignLineCost := ForeignAmount;

        // convert to AUD line cost using todays rate
        {foreign price is the inc - done for UK}
        Result := GetAmounteX(CommonLib.ForeignToLocal(ForeignLineCost, TPurchaseOrder(Owner).ForeignExchangeRate, RoundPlacesGeneral), LineTaxRate);

      end;
    end else begin
      // No foreign currency buy price found for this product so get AUD cost
      // and convert this to foreign amount
      Result := inherited CalcBaseLineAmount; // get AUD amount

      // Set the foreign line cost
      ForeignLineCost := GetAmountInc(CommonLib.LocalToForeign(Result, TPurchaseOrder(Owner).ForeignExchangeRate, RoundPlacesGeneral), LineTaxRate);
    end;
  end else begin
    // We are not using foreign currency so use costs from product
    Result := inherited CalcBaseLineAmount;
  end;
end;

Function TPurchaseOrderLine.DoAfterOpen(Sender :TDatasetBusObj ):Boolean;
begin
  inherited DoAfterOpen(Sender);
  if Assigned(Owner) and (Owner is TPurchaseOrder) then TPurchaseOrder(Owner).CalcOrderTotals;
  Result := True;
end;

procedure TPurchaseOrderLine.CheckAndUpdateProductForeignBuyPrice;
var
  PriceExists: boolean;
  CurrId: integer;
  SaveIsReadOnly: boolean;
  msg :String;
  Prod: TProduct;

  function ConfirmUpdate: boolean;
  var str: string; resp: word;
  begin
    result:= false;
    if UpdateAllProductForeignBuyPrice then
      result:= true
    else begin
      str:= Suppliername +'''s buy price for ' +TPurchaseOrder(Owner).ForeignExchangeCode +': ' ;
      str:= str+  FloatToStr(Round(Prod.ForeignPriceBuy.Price1,RoundPlacesGeneral));
      str := str+ chr(13) +'Prices for "' + Prod.ProductName + '" have changed to '+ floattoStr(Round(self.ForeignLineCost,RoundPlacesGeneral)) ;
      str := str+ chr(13) +chr(13) +'Do you want to update these prices?';
      resp:= CommonLib.MessageDlgXP_Vista(str,mtConfirmation, [mbYes, mbAll, mbNo], 0);
      case resp of
        mrYes: result:= true;
        100:   begin
                 result:= true;
                 UpdateAllProductForeignBuyPrice:= true;
               end;
      end;
    end;
  end;

  function ConfirmAdd: boolean;
  var str: string; resp: word;
  begin
    result:= false;
    if AddAllProductForeignBuyPrice then
      result:= true
    else begin
      str:= 'Do you want to add this foreign currency value to product "'+ Prod.ProductName + '"?';
      resp:= CommonLib.MessageDlgXP_Vista(str,mtConfirmation, [mbYes, mbAll, mbNo], 0);
      case resp of
        mrYes: result:= true;
        100:   begin
                 result:= true;
                 AddAllProductForeignBuyPrice:= true;
               end;
      end;
    end;
  end;

begin
  Prod := Product;
  if AppEnv.CompanyPrefs.StoreForeignCurrencyValue and (ISPOForeign) then
  begin
    // Does user want to Save new foreign prices for this product
    if (self.QtyShipped <> 0) then begin
      if Assigned(Owner) and (Owner is TPurchaseOrder) then begin

        if Prod.Lock =false then begin
          msg := 'Unable to update ' + Prod.ProductName + '''s cost record as product is being updated by "' +
          Prod.UserLock.LockInfo.UserName + '" with: ' + Prod.UserLock.LockInfo.LockingForm;
          ResultStatus.AddItem(true, rssWarning, 1, msg, False);
          Exit;
        end;
        SaveIsReadOnly:= Prod.IsReadonly;
        Prod.IsReadonly:= false;
        try
          CurrId:= TPurchaseOrder(Owner).FXObj.GetCurrencyID(TPurchaseOrder(Owner).ForeignExchangeCode);
          PriceExists:= Prod.ForeignPriceBuy.LocateBuyPrice(TPurchaseOrder(Owner).SupplierId, CurrId , self.unitofmeasureid);
          try
              if PriceExists then begin
                // Found foreign buy prices for this supplier.
                // Are they different
                if Prod.ForeignPriceBuy.Price1 <> self.ForeignLineCost then begin
                  // ask user if they want to update
                  if silentmode or ConfirmUpdate then begin
                    Prod.IsReadonly:= false;
                    Prod.ForeignPriceBuy.Qty1 := 1;
                    {foreign price is the inc - done for UK}
                    Prod.ForeignPriceBuy.Price1 := self.ForeignLineCost;
                    Prod.ForeignPriceBuy.LogChangesOnSave := AppEnv.CompanyPrefs.UseAuditTrail;
                    Prod.ForeignPriceBuy.Save;
                  end;
                end;
              end else begin
                // No foreign prices found for this supplier, does the user want
                // to add them?
                if ForeignLineCost > 0 then begin
                  if silentmode or ConfirmAdd then begin
                    Prod.IsReadonly:= false;
                    Prod.ForeignPriceBuy.New;
                    Prod.ForeignPriceBuy.ProductId := Prod.Id;
                    Prod.ForeignPriceBuy.ClientId := TPurchaseOrder(Owner).SupplierId;
                    Prod.ForeignPriceBuy.IsSellPrice := false;
                    Prod.ForeignPriceBuy.Qty1 := 1;
                    Prod.ForeignPriceBuy.uomid := self.unitofmeasureid;
                    Prod.ForeignPriceBuy.Price1 := self.ForeignLineCost;
                    Prod.ForeignPriceBuy.CurrencyCode:= TPurchaseOrder(Owner).ForeignExchangeCode;
                    Prod.ForeignPriceBuy.LogChangesOnSave :=  AppEnv.CompanyPrefs.UseAuditTrail;
                    Prod.ForeignPriceBuy.Save;
                  end;
                end;
              end;
          Except
            //kill the exception
          end;
        finally
          Prod.IsReadonly:= SaveIsReadOnly;
        end;
      end;
    end;
  end;
end;

(*Procedure TPurchaseOrderLine.UpdateproductAverageCost(var Tempcost :Double; intrans:Boolean);
var
    msg :String;
    conn : TMyDacDataConnection;
begin
    if Product.Lock then begin
        Try
          if intrans then conn := Self.connection else conn := GetSharedMyDAcDataconnection;
//            if AppEnv.CompanyPrefs.StandardCostPurchaseAdjustmentAccountID > 0 then
           if (AppEnv.CompanyPrefs.UseInventoryStandardCosting) and
             (AppEnv.CompanyPrefs.StandardCostPurchaseAdjustmentAccountID > 0) then
                TempCost := TProduct.UpdateAvgCosts(Self, conn, Product.ID, self.StandardCost)
            else
                TempCost := TProduct.UpdateAvgCosts(Self, conn, Product.ID);
        Finally
          if not intrans then Product.Unlock;
        end;
    end else begin
        msg := 'Unable to update ' + Product.ProductName + '''s cost record as product is being updated by "' +
          Product.UserLock.LockInfo.UserName + '" with: ' + Product.UserLock.LockInfo.LockingForm;
          ResultStatus.AddItem(true, rssWarning, 1, msg, False);
    end;
end;*)

procedure TPurchaseOrderLine.DoFieldOnChange(Sender: TField);
var
  BuyRate, SellRate: Double;
  Msg :String;
  Tempcost :Double;
  LineCostOld: double;
begin

    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
            if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
    LineCostOld := 0;
    if (Sysutils.SameText(Sender.FieldName , 'LineCost')) or (Sysutils.SameText(Sender.FieldName , 'LineCostInc')) then begin
      if not VarIsNull(sender.OldValue) then
        LineCostOld := sender.OldValue;
    end;

      // check Purchase Order Line specific stuff here first before Inherited
      // calls TOrderLineBase.DoFieldOnChange
    if (Sysutils.SameText(Sender.FieldName , 'ETADate'))  then begin
        SendEvent(BusObjEvent_Change,BusObjEvent_POLinesETADateChanged, self);
      end else if Sysutils.SameText(Sender.FieldName , 'UnitofMeasureShipped') then begin
        if Abs(UOMQtyShipped) > Abs(UOMQtySold) then begin
          // this message is specific to PO lines
          ResultStatus.AddItem(false, rssWarning, 0,'Quantity Received can not be greater than Quantity Ordered.');
          if UOMQtyShipped <>  UOMQtySold then
          begin
            UOMQtyShipped := UOMQtySold;
            if formulaQtyShippedValue <> 0 then
              formulaQtyShippedValue :=0;
          end;
        end;
        if Assigned(Owner) and (Owner is TPurchaseOrder) then if ((UOMQtyShipped > 0) and (UOMQtySold < 0)) or
            ((UOMQtyShipped < 0) and (UOMQtySold > 0)) then begin
            ResultStatus.AddItem(false, rssWarning, 0,'Both Quantity Ordered and shipped should be either positive or negative');
            if UOMQtyShipped <> 0 then UOMQtyShipped := 0;
        end;
        BoxesReceived := trunc(UOMQtyShipped * BoxesPerItem);
        inherited;
        CheckAndUpdateProductForeignBuyPrice;
        Exit;
      end;

      if SameText(Sender.FieldName, 'BoxesReceived') then begin
//        if (BoxesReceived div BoxesPerItem) > QtySold then
        if BoxesReceived > BoxesOrdered then begin
          ResultStatus.AddItem(false, rssWarning, 0, 'Boxes Received Cannot Be Greater Than Boxes Ordered');
          if UOMQtyShipped <> UOMQtySold then begin
            UOMQtyShipped := UOMQtySold;
            if formulaQtyShippedValue <> 0 then formulaQtyShippedValue :=0;
            BoxesReceived := BoxesOrdered;
            UOMQtyShipped := UOMQtySold;
          end;
        end else if (BoxesReceived<>0) and (BoxesOrdered <>0) then begin
          UOMQtyShipped := Round((BoxesReceived / BoxesOrdered) * UOMQtySold, Self.RoundPlacesGeneral);
          UOMQtyBackOrder := Round(UOMQtySold - UOMQtyShipped, Self.RoundPlacesGeneral);
        end;
        AddEvent(BusObjEvent_Change, BusObjEventVal_BoxesShipped, Self.ID);
      end;

      inherited;
      if SameText(Sender.FieldName, 'UnitOfMeasurePoLines') then
      begin
        LoadBoxesPerItem;   // reload...
      end else
      if Sysutils.SameText(Sender.FieldName , 'TotalLineAmountInc') then begin
        if QtyShipped = 0 then begin
          PostDb;
          TotalLineAmountInc := 0;
          TotalLineAmount := 0;
          LineTaxTotal:= 0;
          PostDb;
        end
        else begin
          TotalLineAmount := Round(TotalLineAmountInc / (1 + LineTaxRate),(*self.RoundPlacesGeneral*)CurrencyRoundPlaces);
          LineTaxTotal    := TotalLineAmountInc - TotalLineAmount;
        end
{-->} end else if Sysutils.SameText(Sender.FieldName , 'ProductID') then begin
        //DoLog('TPurchaseOrderLine.DoFieldOnChange_' + Sender.FieldName);
        //if assigned(ftUpdatePrefSupp) then ftUpdatePrefSupp;
        If self.ProductId<>0 then Begin
          Product.Load(productID);
          LoadBoxesPerItem;
          Productname := Product.Productname;
          PostDB;
          UpdateproductAverageCost(Tempcost , False);
            if Assigned(Owner) and (Owner is TPurchaseOrder) then begin

              if AppEnv.CompanyPrefs.UseForeignCurrencyonPO then begin
                // Set the foreign currency stuff for this line.

                if TPurchaseOrder(Owner).ForeignExchangeCode = '' then TPurchaseOrder(Owner).ForeignExchangeCode :=
                    TPurchaseOrder(Owner).Supplier.ForeignExchangeCode;

                if TPurchaseOrder(Owner).ForeignExchangeRate = 0 then begin
                  // get the rate for this new currency
                  TPurchaseOrder(Owner).FXObj.GetForeignExchangeRatesForDate(TPurchaseOrder(Owner).ForeignExchangeCode,
                    TPurchaseOrder(Owner).OrderDate,BuyRate,SellRate);

                  // NOTE use the banks sell rate, ie we have to buy the foreign
                  // currency from the bank (they are selling to us)
                  // to pay for the foreign purchased goods.
                  TPurchaseOrder(Owner).ForeignExchangeRate := BuyRate;//SellRate;
                end;
              end;
            end;
          end;
          if Appenv.CompanyPrefs.PurchaseETAFromProductNormalDeliveryTime then begin
              Self.ETADate := IncDay(now,trunc(Product.NormalDeliveryTime));
              if Assigned(Self.Owner) then
                if owner is TPurchaseOrder then
                  TPurchaseOrder(Owner).ETAdate :=IncDay(now,trunc(Product.NormalDeliveryTime));
          end;

{-->} end else if Sysutils.SameText(Sender.FieldName , 'ProductName') then begin
        // Product was loaded in the call to inherited, now just adjusting PO specific stuff
        if ProductId <> 0 then
          LoadBoxesPerItem;
//            if Sender.AsString = '' then  //@@
//              exit;                       //@@
//            Product.LoadSelect('PartName = ' + QuotedStr(self.ProductName));
//            ProductID := Product.ID;
//            DoFieldOnChange(dataset.findfield('ProductID'));
{-->} end   else if Sysutils.SameText(Sender.FieldName , 'UnitofMeasureQtySold') then begin
        if BaseLineno<> 0 then
            if CleanQtyTotal < 0 then begin
                if UOMQtySold >0 then UOMQtySold := 0;
            end else if UOMQtySold <0 then UOMQtySold := 0;
        if Abs(UOMQtyShipped) > Abs(UOMQtySold) then begin
          // this message is specific to PO lines
          ResultStatus.AddItem(false, rssWarning, 0,'Quantity Ordered can not be less than Quantity Received.');
          UOMQtyShipped := UOMQtySold;
          DoFieldOnChange(Self.Dataset.FieldByName('UnitofMeasureShipped'));
          //if (AppEnv.CompanyPrefs.UseApprovalLevels) then TPurchaseOrder(Self.Owner).ValidateApproval;
//          TApprovalCheck.Approved(TPurchaseOrder(self.Owner));
        end;
        if Assigned(Owner) and (Owner is TPurchaseOrder) then if ((UOMQtyShipped > 0) and (UOMQtySold < 0)) or
            ((UOMQtyShipped < 0) and (UOMQtySold > 0)) then begin
            ResultStatus.AddItem(false, rssWarning, 0,'Both Quantity Ordered and shipped should be either positive or negative');
            UOMQtyShipped := UOMQtySold;
          end;
        if Product.ProductSpecs.Dataset.Locate('PartSpecID', PartSpecID, []) then begin
          if (UOMQtySold <> 0.00) and IsNumeric(Product.ProductSpecs.SpecValue) then
            SpecValue := Round(DivZer(UOMQtySold, UOMMultiplier) * StrToFloat(Product.ProductSpecs.SpecValue), Self.RoundPlacesGeneral);
        end;
        { check for supplier minimum order qty ... }
        if Product.ExtraBuyPrice.LocateSupplier(TPurchaseOrder(Owner).ClientId,UnitOfMeasureID,false) then begin
          if (Product.ExtraBuyPrice.MinimumOrderQty > 0) and (UOMQtySold < Product.ExtraBuyPrice.MinimumOrderQty) then begin
            SendEvent(BusObjEvent_Warning, BusobjEventVal_OrderQtyLessThanSuppMinOrderQty, self);
          end;
        end;
        BoxesOrdered := Trunc(UOMQtySold * BoxesPerItem);
        BoxesReceived := trunc(UOMQtyShipped * BoxesPerItem);
{-->} end else if (Sysutils.SameText(Sender.FieldName , 'LineCost')) or (Sysutils.SameText(Sender.FieldName , 'LineCostInc')) then begin
//        if VarIsNull(Sender.OldValue) or (Sender.OldValue <> Sender.Value) then begin
        if LineCostOld <> Sender.AsFloat then begin

          if (Sysutils.SameText(Sender.FieldName , 'LineCostInc')) then
            Linecost := GetamountEx(linecostInc , LineTaxRate)
          else if (Sysutils.SameText(Sender.FieldName , 'LineCost')) then
            LinecostInc := GetamountInc(linecost , LineTaxRate);

          // does user want to update product with new cost
//          if (not SilentMode) and (not AppEnv.CompanyPrefs.DisableAltSaveCost) then
//              UpdateProductBuyCostFromLineCost;

          if (not SilentMode) and (not AppEnv.CompanyPrefs.DisableAltSaveCost) then begin
              if (Sender.AsFloat <> LineCostOld) then begin
                if self.Product.CostUpdateFromPurchase then
                  UpdateProductBuyCostFromLineCost;
              end;
          end;


          if TProductClass.QtyInStock(ProductID,ClassId) = 0 then
            Self.AverageCost := Self.LineCost;

          if (AppEnv.CompanyPrefs.UseForeignCurrencyonPO) AND (IsPOForeign) then begin
            CalcLineTotals; { this will update the foreign amounts }
            CheckAndUpdateProductForeignBuyPrice;
            Exit; { don't need to go through inherited ... already calculated line totals }
          end;
        end;
        // CalcLineTotals will be called in inherited below
{-->} end else if Sysutils.SameText(Sender.FieldName , 'ForeignCurrencyLineCost') then begin
        // User has keyed in a new foreign amount

        // calculate new line cost using line exchange rate
        {foreign price is the inc - done for UK}

        CalcLineForeignTotals; { this will also recalculate LineCost/LineCostInc }
        CheckAndUpdateProductForeignBuyPrice;

        if Assigned(Owner) and (Owner is TPurchaseOrder) then TPurchaseOrder(Owner).DoCalcOrderTotals;
{-->} end else if Sysutils.SameText(Sender.FieldName , 'LandedCostsPercentage') then begin
        // Calc Item LC (Landed Cost)
        //
        //             ( Total LC * Percentage Of LC )
        //  Item LC =  -------------------------------
        //                       Qty Shipped

       UnitLandedCost := CommonLib.Round(Divzer((self.TotalOrderLandedCost * (TotalLineLandedCostPerc / 100)), QtyShipped), // QtySold),//QtyShipped),
          RoundPlacesGeneral);

        // now update the product
        if Product.Lock then begin
          TProduct.UpdateLandedCost(self.ProductID, self.UnitLandedCost, self.Connection.Connection);
        end else begin
            msg := 'Unable to update ' + Product.ProductName + '''s cost record as product is being updated by "' +
                Product.UserLock.LockInfo.UserName + '" with: ' + Product.UserLock.LockInfo.LockingForm;
            ResultStatus.AddItem(true, rssWarning, 1, msg );
        end;

        { force ReCalc of landed cost calculated field }
        DoCalcFields(self);

{-->} end else if Sysutils.SameText(Sender.FieldName , 'LandedCostsPerItem') then begin

//        TotalLineLandedCostPerc:= CommonLib.Round(Divzer(UnitLandedCost * QtySold, TotalOrderLandedCost) * 100, self.CurrencyRoundPlaces);
        TotalLineLandedCostPerc:= CommonLib.Round(Divzer(UnitLandedCost * QtyShipped, TotalOrderLandedCost) * 100, self.CurrencyRoundPlaces);

        // now update the product
        if Product.Lock then begin
          TProduct.UpdateLandedCost(self.ProductID, self.UnitLandedCost, self.Connection.Connection);
        end else begin
            msg := 'Unable to update ' + Product.ProductName + '''s cost record as product is being updated by "' +
                Product.UserLock.LockInfo.UserName + '" with: ' + Product.UserLock.LockInfo.LockingForm;
            ResultStatus.AddItem(true, rssWarning, 1, msg );
        end;

        { force ReCalc of landed cost calculated field }
        DoCalcFields(self);

{-->} end else if Sysutils.SameText(Sender.FieldName , 'SpecDescription') then begin
        if Product.ProductSpecs.Dataset.Locate('SpecDescription', Sender.AsString, [loCaseInsensitive]) then begin
          PartSpecID := Product.ProductSpecs.PartSpecID;
          if (UOMQtySold <> 0.00) and IsNumeric(Product.ProductSpecs.SpecValue) then
            SpecValue := Round(DivZer(UOMQtySold, UOMMultiplier) * StrToFloat(Product.ProductSpecs.SpecValue), Self.RoundPlacesGeneral);
          // Round it ??
        end;
{-->} end else if Sysutils.SameText(Sender.FieldName , 'SpecValue') then begin
        if Product.ProductSpecs.Dataset.Locate('PartSpecID', PartSpecID, []) then begin
          if (SpecValue <> 0.00) and IsNumeric(Product.ProductSpecs.SpecValue) then
            UOMQtySold := Round(DivZer(SpecValue, StrToFloat(Product.ProductSpecs.SpecValue)), Self.RoundPlacesGeneral) * UOMMultiplier;
          // Round it ??
          DoFieldOnChange(Self.Dataset.FieldByName('UnitofMeasureQtySold'));
        end;
{-->} end else if Sysutils.SameText(Sender.FieldName , 'ReceivedDate') then begin
        if (QtyShipped <> 0.00) and (ReceivedDate = 0) then ReceivedDate := Sender.OldValue;
      end;

      // now call main event proCessing in TOrderLineBase
//      inherited;
end;

procedure TPurchaseOrderLine.GetProductDetails;
var
  ForeignAmount, BuyRate, SellRate: Double;
begin
  Inc(GetProductDetailsCount);
  try

    ForeignAmount := 0.00;
    inherited; // base class gets most of the product data

    // get foreign currency specific data if required
      if TPurchaseOrder(Owner).ForeignExchangeCode = '' then begin
          TPurchaseOrder(Owner).ForeignExchangeCode := AppEnv.RegionalOptions.ForeignExDefault;
          TPurchaseOrder(Owner).ForeignExchangeRate := 1;
      end;

      // get foreign currency stuff
      if Assigned(Owner) and (Owner is TPurchaseOrder) then begin
        // we need to do this to position on required record
          {foreign price is the inc - done for UK}
          ForeignAmount := Product.ForeignPriceBuy.GetBuyPrice(TPurchaseOrder(Owner).SupplierId,
              TPurchaseOrder(Owner).FXObj.GetCurrencyID(TPurchaseOrder(Owner).ForeignExchangeCode), QtyShipped, unitofmeasureId);
      end;


      if ForeignAmount <> 0 then begin
        self.ForeignLineCost := ForeignAmount;

        //self.LineCost:= 0; // this will be set when qty

        if TPurchaseOrder(Owner).ForeignExchangeCode = '' then begin
          // get the default currency code for this supplier
          TPurchaseOrder(Owner).ForeignExchangeCode := Product.ForeignPriceBuy.CurrencyCode;

          // now get the current rate for this code and the order date
          if Assigned(Owner) and (Owner is TPurchaseOrder) then begin
            TPurchaseOrder(Owner).FXObj.GetForeignExchangeRatesForDate(TPurchaseOrder(Owner).ForeignExchangeCode,
              TPurchaseOrder(Owner).OrderDate,BuyRate, SellRate);
            // NOTE use the banks sell rate, ie we have to buy the foreign
            // currency from the bank (they are selling to us)
            // to pay for the foreign purchased goods.
            TPurchaseOrder(Owner).ForeignExchangeRate := BuyRate;//SellRate;
          end;
        end;
    end;
  finally
    Dec(GetProductDetailsCount);
  end;
end;

function TPurchaseOrderLine.GetSQL: String;
begin
  //inherited;
  if Assigned(Owner) and (Owner is TPurchaseOrder) then begin
    fSQL := 'SELECT tblPurchaseLines.* FROM tblPurchaseLines WHERE PurchaseOrderId = ' + IntToStr(TPurchaseOrder(Owner).Id);// + ' ORDER BY SORTID';
  end else begin
    fSQL := 'SELECT tblPurchaseLines.* FROM tblPurchaseLines ';//WHERE PurchaseLineId = ' + IntToStr(fId) + ' ORDER BY SORTID';
  end;
  Result := inherited GetSQL;
  if Pos('ORDER BY', Uppercase(Result)) = 0 then Result := Result +' ORDER BY SORTID';
end;
procedure TPurchaseOrderLine.CalcLineCostFromTotal;
begin
  // User has entered a line total amount
  // Call inherited to calc line AUD costs
  inherited;

  // now calculate foreign amount if required
  if AppEnv.CompanyPrefs.UseForeignCurrencyonPO then begin
    // make sure we have a currency selected
    if TPurchaseOrder(Owner).ForeignExchangeCode = '' then begin
      TPurchaseOrder(Owner).ForeignExchangeCode := AppEnv.RegionalOptions.ForeignExDefault;
    end;
    // and rate can't be zero
    if TPurchaseOrder(Owner).ForeignExchangeRate = 0 then begin
      TPurchaseOrder(Owner).ForeignExchangeRate := 1;
    end;
    CalcLineForeingAmount;
  end;
end;



procedure TPurchaseOrderLine.CalcLineTotals;
begin
  if self.Id = 0 then
    exit;
  inherited;
  if (AppEnv.CompanyPrefs.UseForeignCurrencyonPO) AND (IsPOForeign) then begin
    ForeignTotalLineAmount:= LocalToForeign(TotalLineAmountInc, TPurchaseOrder(Owner).ForeignExchangeRate, (*RoundPlacesGeneral*)CurrencyRoundPlaces);
    if QtyShipped <> 0 then
      ForeignLineCost:= Round(ForeignTotalLineAmount/ QtyShipped, RoundPlacesGeneral)
    else
      ForeignLineCost:= LocalToForeign(LineCostInc, TPurchaseOrder(Owner).ForeignExchangeRate, RoundPlacesGeneral);
  end
  else
    ForeignLineCost:= 0;
end;

procedure TPurchaseOrderLine.CalcLineForeignTotals;
begin
  if IsPOForeign then begin
    ForeignTotalLineAmount:= CommonLib.Round(ForeignLineCost * QtyShipped, (*RoundPlacesGeneral*)CurrencyRoundPlaces);
    TotalLineAmountInc:= ForeignToLocal(ForeignTotalLineAmount, TPurchaseOrder(Owner).ForeignExchangeRate, (*RoundPlacesGeneral*)CurrencyRoundPlaces);
    TotalLineAmount:= TotalLineAmountInc / (1 + LineTaxRate);
    LineTaxTotal:= TotalLineAmountInc - TotalLineAmount;
    if QtyShipped <> 0 then begin
      LineCost:= Round(TotalLineAmount / QtyShipped, RoundPlacesGeneral);
      LineCostInc:= Round(TotalLineAmountInc / QtyShipped, RoundPlacesGeneral);
    end
    else begin
      if ForeignLineCost <> 0 then begin
        LineCost:= ForeignToLocal(ForeignLineCost, TPurchaseOrder(Owner).ForeignExchangeRate, RoundPlacesGeneral);
        LinecostInc := GetamountInc(linecost , LineTaxRate);
      end
      else begin
        LineCost:= 0;
        LineCostInc:= 0;
      end;
    end;
    Attrib1Purchase       := Product.Attrib1Purchase * self.QtyShipped;
    Attrib2Purchase       := Product.Attrib2Purchase * self.QtyShipped;
    Attrib1PurchaseRate   := Product.Attrib1PurchaseRate;
    Attrib1PurchaseEst    := Product.Attrib1Purchase * self.QtySold;
    Attrib2PurchaseEst    := Product.Attrib2Purchase * self.QtySold;
  end;
end;

Function TPurchaseOrderLine.GetIsPOForeign:Boolean;
begin
    Result := False;
    if assigned(Self.Owner) then
        if Self.Owner is TPurchaseOrder then
            Result := (TPurchaseOrder(Owner).ForeignExchangeCode <> AppEnv.RegionalOptions.ForeignExDefault);
end;
function TPurchaseOrderLine.GetIsPQAItem: Boolean;
begin
  REsult:=inherited GetIsPQAItem;
  if result then
    if (CopyingToPO or CopyingToRA)  then result := False;
end;

function TPurchaseOrderLine.GetLineDesc: String;
begin
  REsult := inherited GetLineDesc;
  Result := result + NL+'Product :' + Productname;
end;


function TPurchaseOrderLine.getpackweightField: Double;
begin
  REsult := GetFloatfield('packweightField');
end;

Procedure TPurchaseOrderLine.ChangeOrderQty;
var
    fOrgNo :String;
    StrSQL:String;
    strSQLUpdate:string;
begin
    fOrgNo := '';
    if (baselineno = 0) or
        ((CleanQtytotal = Qtysold) and (Deleted = False) ) or
        (CleanQtytotal = 0) then Exit;

    if Assigned(Self.Owner) and (Self.Owner is TPurchaseorder) then
        fOrgNo := TPurchaseOrder(Self.Owner).OriginalDocNumber
    else with getNewDataset('Select OriginalNo from tblpurchaseorders where PurchaseOrderID = ' + IntToStr(PurchaseOrderID)) do Try
        if recordcount <> 0 then fOrgNo := FieldByname('OriginalNo').asString;
    Finally
        Close;
        Free;
    end;
    if fOrgNo = '' then Exit;
    if Deleted then fChangeQty := cleanQtyTotal
    else fchangeQty := cleanQtyTotal-  QtySold;
    PostDB;
    if fChangeQty = 0 then exit;

    if Assigned(Self.Owner) then
      if Self.Owner is TPurchaseOrder then begin
        (*TPurchaseOrder(Self.Owner).POLinesofGroup.IterateRecords(callbackChangeOrderQty);*)

        strSQL:= 'Select PurchaseLineID From tblpurchaselines PL ' +
                  ' inner join tblPurchaseOrders P on P.PurchaseOrderID = PL.PurchaseOrderID and P.Originalno = '+QuotedStr(fOrgNo)+
                  ' and P.Globalref <> ' +quotedstr(TPurchaseOrder(Self.Owner).Globalref) + ' and P.Globalref <> ' + QuotedStr( TPurchaseOrder(Self.Owner).backorderGlobalref)+
                  ' where PL.SeqNo = ' +IntToStr(Seqno) +
                  ' and PL.ProductId = ' +IntToStr(ProductId);
        With getNewdataset(strSQL) do try
          if recordcount > 0 then begin
              First;
              strSQL:=       'update tblpurchaselines Set QtySold                = QtySold   -'+floatToStr(fchangeQty) +' where PurchaseLineID = :PurchaseLineID;';
              strSQL:=strSQL+'update tblpurchaselines Set BackOrder              = BackOrder -'+floatToStr(fchangeQty) +' where PurchaseLineID = :PurchaseLineID;';
              strSQL:=strSQL+'update tblpurchaselines Set UnitofMeasureQtySold   = QtySold  /UnitofMeasureMultiplier where PurchaseLineID = :PurchaseLineID;';
              strSQL:=strSQL+'update tblpurchaselines Set UnitofMeasureBackorder = BackOrder/UnitofMeasureMultiplier where PurchaseLineID = :PurchaseLineID;';
              strSQLUpdate := '';
              while Eof = False do begin
                strSQLUpdate := strSQLUpdate + replaceStr(StrSQL, ':PurchaseLineID' , IntToStr(fieldbyname('PurchaseLineID').asInteger));
                next;
              end;
          end;
        finally
            if active then close;
            Free;
        end;
        if strSQLUpdate <> '' then GetNewDataSet(strSQLUpdate,true);
      end;
end;
(*procedure TPurchaseOrderLine.callbackChangeOrderQty(const Sender: TBusObj;  var Abort: Boolean);
begin
  if not(Sender is TPurchaseOrderLine) then exit;
  if TPurchaseOrderLine(Sender).Seqno = Self.Seqno then
    if TPurchaseOrderLine(Sender).ID <> Self.ID then begin
        {TPurchaseOrderLine(Sender).QtySold:= TPurchaseOrderLine(Sender).QtySold -fchangeQty;
        TPurchaseOrderLine(Sender).UOMQtySold:= DivZer(TPurchaseOrderLine(Sender).QtySold , TPurchaseOrderLine(Sender).UOMMultiplier);
        TPurchaseOrderLine(Sender).QtyBackOrder        := TPurchaseOrderLine(Sender).QtyBackOrder -fchangeQty;
        TPurchaseOrderLine(Sender).UOMqtyBackOrder:= DivZer(TPurchaseOrderLine(Sender).QtyBackOrder , TPurchaseOrderLine(Sender).UOMMultiplier);
        Sender.postDB;}
        SQLForIteraterecords:=SQLForIteraterecords + 'update tblpurchaseLines Set QtySold = ' +FloattoStr(TPurchaseOrderLine(Sender).QtySold -fchangeQty) +
                  ' where PurchaseLineID = ' +IntToStr(TSalesLine(Sender).ID)+';';
        SQLForIteraterecords:=SQLForIteraterecords +'update tblpurchaseLines Set UnitofMeasureQtySold = ' +FloattoStr(DivZer(TPurchaseOrderLine(Sender).QtySold , TPurchaseOrderLine(Sender).UOMMultiplier)) +
                  ' where PurchaseLineID = ' +IntToStr(TSalesLine(Sender).ID)+';';
        SQLForIteraterecords:=SQLForIteraterecords +'update tblpurchaseLines Set BackOrder = ' +FloattoStr(TPurchaseOrderLine(Sender).QtyBackOrder -fchangeQty) +
                  ' where PurchaseLineID = ' +IntToStr(TSalesLine(Sender).ID)+';';
        SQLForIteraterecords:=SQLForIteraterecords +'update tblpurchaseLines Set UnitofMeasureBackorder = ' +FloattoStr(DivZer(TPurchaseOrderLine(Sender).QtyBackOrder , TPurchaseOrderLine(Sender).UOMMultiplier)) +
                  ' where PurchaseLineID = ' +IntToStr(TSalesLine(Sender).ID)+';';
    end;
end;*)

Function TPurchaseOrderLine.CloneBusObj(const Changefield :String; const ChangeValue :Variant; const SaveAfterCopy : Boolean = True; const FilterFields :String = ''):TBusObj;
var
  x: integer;
  LineCount: integer;
begin
  result := nil;
  LineCount := 1;
  if TPurchaseOrder(Owner).ObjInstanceToClone is TReturnAuthority then begin
    LineCount := System.Round(self.UOMQtyShipped);
  end;
  for x := 1 to LineCount do begin

    Result := inherited CloneBusObj(ChangeField, changeValue, SaveAfterCopy,FilterFields);
    if Result = nil then Exit;
    Result := ObjInstanceToClone;
    if Assigned(result.Owner) then
      if result.Owner is  TPurchaseOrder then
        TPurchaseOrderLine(Result).Receiveddate := TPurchaseOrder(TPurchaseOrderLine(Result).Owner).OrderDate;
    if TPurchaseOrderLine(Result).BaselineNo <> 0 then TPurchaseOrderLine(Result).BaselineNo := 0;
    if TPurchaseOrder(Owner).ObjInstanceToClone is TReturnAuthority then begin
      TReturnAuthorityLine(result).RAQty := 1;
    end;

    TPurchaseOrderLine(Result).PostDB;
  end;
end;

function TPurchaseOrderLine.CopyingToPO: Boolean;
begin
  result:= False;
  if assigned(Owner) then
    if owner is TPurchaseOrder then
      result := TPurchaseOrder(Owner).CopyingToPO;
end;

function TPurchaseOrderLine.CopyingToRA: Boolean;
begin
  result:= False;
  if assigned(Owner) then
    if owner is TPurchaseOrder then
      result := TPurchaseOrder(Owner).CopyingToRA;
end;

procedure TPurchaseOrderLine.SaveToXMLNode(const Node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'GeneralNotes',GeneralNotes);
end;

procedure TPurchaseOrderLine.SetBoxesOrdered(const Value: integer);
begin
  SetIntegerField('BoxesOrdered', Value);
end;

procedure TPurchaseOrderLine.SetBoxesReceived(const Value: integer);
begin
  SetIntegerField('BoxesReceived', Value);
end;

procedure TPurchaseOrderLine.SetGeneralNotes(const Value: string);
begin
  SetStringField('GeneralNotes', Value);
end;
procedure TPurchaseOrderLine.SetLineDescription(const Value: string);
begin
  SetStringField('LineDescription', Value);
end;

procedure TPurchaseOrderLine.SetTransDate(const Value: TDatetime);
begin
  ReceivedDate := Value;
end;

function TPurchaseOrderLine.GetTransDate: TDateTime;
begin
    Result := ReceivedDate;
    if result = 0 then {for back orders take the order date}
        if Assigned(Self.Owner) then
            if Self.Owner is TOrderbase then
                Result := TOrderbase(Self.Owner).OrderDate;
end;

Function TPurchaseOrderLine.DoNewRecord(Sender :TDatasetBusObj ):Boolean;
begin
  REsult:= inherited;
end;

procedure TPurchaseOrderLine.EquipmentAreaforline(const Value: String);
begin
  if Value = '' then exit;
  if TAreaCode.MakeNewArea(value , connection)>0 then
    AreaCode:= Value;
end;

destructor TPurchaseOrderLine.Destroy;
begin
  inherited;
end;

function TPurchaseOrderLine.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
   Result := inherited DoAfterInsert(Sender);
  if not result then Exit;
    if assigned(Self.Owner) then
        if self.Owner is TPurchaseOrder then begin
            //if TPurchaseOrder(Self.Owner).BackOrderGlobalRef <> '' then begin
            //if  POBackOrderIsInvoiced(TPurchaseOrder(Self.Owner).BackOrderGlobalRef) then begin
            if AllowNewRecordWhenLocked = False then
              if TPurchaseOrder(Self.Owner).IsBOInvoiced then begin
                  Dataset.Cancel;
                  Exit;
              end;
            ForeignExchangeRate :=TPurchaseOrder(Self.Owner).ForeignExchangeRate;

            { Dene/Microlink change to get ETA from Product NormalDeliveryTime }
            if Appenv.CompanyPrefs.PurchaseETAFromSupplierShippingtime then begin
              ChangingETADate := True;
              try
                Self.ETADate := IncDay(now,TPurchaseOrder(Self.Owner).Supplier.ShipTime);
              finally
                ChangingETADate := False;
              end;
            end;
        end;
    InitializeNewObject;
    sortId := fiSortID;
    LinesOrder := fiLinesOrder;

end;

function TPurchaseOrderLine.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
    result := inherited;
    if not result then
      exit;
    {record should not be posted if productId is null - is a blank record}
    if {(not DatasetPosting) and} ((ProductId = 0) and (ProductName = '')) then begin
        Deleted := True;
        Exit;
    end;

    if AssetAccount <> '' then
        if AssetAccntId = 0 then
            AssetAccntId := tcDataUtils.getAccountID(AssetAccount);

    if IncomeAccount <> '' then
        if IncomeAccntId = 0 then
            IncomeAccntId := tcDataUtils.getAccountID(IncomeAccount);

    if CogsAccount <> '' then
        if CogsAccntId = 0 then
            CogsAccntId := tcDataUtils.getAccountID(CogsAccount);
    fbNew := dataset.State = dsInsert;

//    DiscountAmount := Round(OriginalCost*QtyShipped * (1 + LineTaxRate),CurrencyRoundPlaces)  - TotalLineAmountInc;
    if AreaCode = '' then
      if Assigned(Owner) then
        if Owner is TPurchaseorder then
          if (TPurchaseorder(Owner).equipmentname <> '') and (TPurchaseorder(Owner).EquipmentID<>0) then begin
            EquipmentAreaforline(TPurchaseorder(Owner).equipmentname +'#' + inttostr(TPurchaseorder(Owner).ID));
          end;
end;

function TPurchaseOrderLine.DoBeforeDelete(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforeDelete(Sender);
  if not result then exit;
end;

function TPurchaseOrderLine.DobeforeInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DobeforeInsert(Sender);
end;

(*var
  SenderPO: TPurchaseOrder;
  PoObj: TPurchaseOrder;
  //fLocked: Boolean;
  SeqNo: Integer;
  QtySold: Double;
begin
  SenderPO := nil;
  Result := false;
  if Assigned(Owner) then if Owner is tPurchaseOrder then SenderPO := TPurchaseOrder(Owner);

  if not Assigned(SenderPO) then Exit;

  if SenderPO.deleted then Exit;// Binny :this is deleting BO internally when the original trans' qty is changed


  {process the qty for all the related records}
  PoObj := SenderPO;
  if PoObj.Deleted then Exit; // deleted back order
  SeqNo := PoObj.Lines.DataSet.FieldByName('SeqNo').AsInteger;
  QtySold := PoObj.Lines.DataSet.FieldByName('QtySold').AsFloat;
  PoObj := SenderPO.GetOriginalPurchaseOrder;
  while (PoObj <> nil) do begin
    {if the product is changed the changes line also will have teh same sequence number}
    if PoObj.Lines.Dataset.Locate('SeqNo;ProductID', VarArrayof([SeqNo,ProductID]), []) then begin
      if PoObj.Lines.Dataset.FieldByName('QtySold').AsFloat <> PoObj.Lines.Dataset.FieldByName('Shipped').AsFloat then begin
        if not (PoObj.Lines.Dataset.State in [dsEdit, dsInsert]) then PoObj.Lines.Dataset.edit;
        PoObj.Lines.Dataset.FieldByName('QtySold').AsFloat := PoObj.Lines.Dataset.FieldByName('QtySold').AsFloat - Qtysold;
        if not (PoObj.Lines.Dataset.State in [dsEdit, dsInsert]) then PoObj.Lines.Dataset.edit;
        PoObj.Lines.Dataset.FieldByName('UnitofMeasureQtySold').AsFloat :=
          PoObj.Lines.Dataset.FieldByName('QtySold').AsFloat * PoObj.Lines.Dataset.FieldByName('UnitofMeasureMultiplier').AsFloat;
        if not (PoObj.Lines.Dataset.State in [dsEdit, dsInsert]) then PoObj.Lines.Dataset.edit;
        PoObj.Lines.Dataset.FieldByName('BackOrder').AsFloat := 0;
        if not (PoObj.Lines.Dataset.State in [dsEdit, dsInsert]) then PoObj.Lines.Dataset.edit;
        PoObj.Lines.Dataset.FieldByName('UnitofMeasureBackorder').AsFloat := 0;
        PoObj.Lines.PostDB;
        PoObj := PoObj.GetOriginalPurchaseOrder;
      end else begin
        PoObj := nil;
      end;
    end else begin
      PoObj := nil;
    end;
  end;
end;*)

function TPurchaseOrderLine.ValidateData: Boolean;
begin
  Result := inherited ValidateData;
  if Result = False then Exit;
  if classId = 0 then begin
    ResultStatus.AddItem(False, rssWarning, 0, appenv.DefaultClass.ClassHeading +' Cannot Be Blank' );
    Result := False;
    Exit;
  end;
end;


procedure TPurchaseOrderLine.New;
begin
    inherited;
end;
  //------------------------------------------------------------------------------
  { TPurchaseOrder }
  //------------------------------------------------------------------------------

constructor TPurchaseOrder.Create(AOwner: TComponent);
begin
  inherited;
  fbCheckingForShipTo := False;
  CopyingToPO:= False;
  CopyingToRA:= False;
  ChangingETADate:= false;
  fdDiscountPercent := 0;
  fSQL := 'SELECT * FROM tblPurchaseOrders where IsPO = "T"';
  fTotalQtyShipped := 0;
  fNonBOMtotalQtyShipped:= 0;
  fTotalQtyOrdered := 0;
  fTotalQtyBackOrdered := 0;
  fTotalEstimatedAmountInc := 0;
  fEstimatedForeignAmountInc :=0;
  fOriginalOrder := nil;
  //ftUpdatePrefSupp:= nil;
  fBusObjectTypeDescription := 'Purchase Order Object';
  fbValidated := False;
  (*fPOLinesofGroup :=  nil;*)
  self.ExportExcludeList.Add('baseno');
  self.ExportExcludeList.Add('cleanapproved');
  self.ExportExcludeList.Add('expenseclaimemployee');
  self.ExportExcludeList.Add('isbill');
  self.ExportExcludeList.Add('ischeque');
  self.ExportExcludeList.Add('iscredit');
  self.ExportExcludeList.Add('isempty');
  self.ExportExcludeList.Add('ispo');
  self.ExportExcludeList.Add('ispocredit');
  self.ExportExcludeList.Add('isra');
  self.ExportExcludeList.Add('paymethod'); { not used? }
  self.ExportExcludeList.Add('printedat');
  self.ExportExcludeList.Add('printedby');
  self.ExportExcludeList.Add('printedon');
  self.ExportExcludeList.Add('printedflag');
  self.ExportExcludeList.Add('paysactionauthorisations');
  self.ExportExcludeList.Add('saleslineref');
  self.ExportExcludeList.Add('raref');
  self.ExportExcludeList.Add('refno');
  //self.ExportExcludeList.Add('supplierid');
end;

procedure TPurchaseOrder.CreateInstance;
begin
  inherited;
  if CopyingToPO then begin
      ObjInstanceToClone := TPurchaseOrder.Create(nil);
      ObjInstanceToClone.connection := self.connection;
      ObjInstanceToClone.Load(0); // this is to avoid loading the whole table
      (*no need for allocation as it has to be copied as a BO
      if Assigned(DoProductallocation) then
          TPurchaseOrder(ObjInstanceToClone).DoProductallocation := DoProductallocation;*)
  end
  else if CopyingToRA then begin
      ObjInstanceToClone := TReturnAuthority.Create(nil);
      ObjInstanceToClone.connection := self.connection;
      ObjInstanceToClone.Load(0); // this is to avoid loading the whole table
  end;
end;

destructor TPurchaseOrder.Destroy;
begin
  inherited;
end;

function TPurchaseOrder.GetSQL: String;
begin
  Result := inherited GetSQL;
  //  result:= 'SELECT * FROM tblPurchaseOrders WHERE PurchaseOrderId = ' + IntToStr(fId);
  //  result:= 'SELECT * FROM tblPurchaseOrders';
end;

function TPurchaseOrder.getTEmployee: TEmployee;
begin
    result := TEmployee(Getcontainercomponent(TEmployee ,'EmployeeID = ' + IntToStr(Self.EmployeeID)));
end;

function TPurchaseOrder.HasEquipnSerailProduct: Boolean;
var
  Qry :TERPQuery;
begin
  Qry := dbsharedobj.GetQuery(self.Connection.Connection);
  try
    Commondblib.closedb(Qry);
    Qry.SQL.Clear;
    Qry.SQL.Add(' select count(PL.PurchaseLineID) as ctr '+
                ' from tblpurchaselines PL inner join tblparts p on PL.ProductID = p.partsId and p.isEquipment="T" and P.sntracking ="T" '+
                ' where PL.deleted ="F" and  PL.PurchaseOrderID = '+inttostr(ID));
    Qry.open;
    result := Qry.fieldbyname('ctr').AsInteger >0;
  finally
    DbSharedobj.ReleaseObj(Qry);
  end;

end;

procedure TPurchaseOrder.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  FreeAndNil(fOriginalOrder);
  FreeAndNil(fBackOrder);
  (*FreeAndNil(fPOLinesofGroup);*)
  fbValidated := False;
  fdDiscountPercent :=0;
end;

Function TPurchaseOrder.LineAlReadyExixts4Product(fiProductID, fiLineID:Integer):Boolean;
var
  strSQL:String;
begin
   strSQL:= 'select productID ' +
                ' from tblPurchaseLines ' +
                ' where PurchaseOrderId = ' + IntToStr(Self.ID) +
                ' and purchaseLineId <> ' + IntToStr(fiLineID) +
                ' and ProductId = ' + IntToStr(fiProductID);
	with getNewDataset(strSQL,True)do try
        REsult := RecordCount >0;
	finally
    	if active then close;
        Free;
	end;
end;

Function TPurchaseOrder.CloneBusObj(const Changefield :String; const ChangeValue :Variant; const SaveAfterCopy : Boolean = True; const FilterFields :String = ''):TBusObj;
begin
    Result := inherited CloneBusObj(ChangeField, changeValue, SaveAfterCopy,FilterFields);
    if Result = nil then Exit;
    Result := ObjInstanceToClone;
    if result is TPurchaseOrder then begin

      TPurchaseOrder(Result).DueDate := TPurchaseOrder(Result).OrderDate + (TPurchaseOrder(Self).OrderDate - TPurchaseOrder(self).dueDate);
      IF TPurchaseOrder(Result).BaseNo <> '' then  TPurchaseOrder(Result).BaseNo:='';
      TPurchaseOrder(REsult).CalcOrderTotals;
    end
    else if Result is TReturnAuthority then begin

      TReturnAuthority(result).CalcOrderTotals;
    end;
end;
procedure TPurchaseOrder.CloneLines(const Sender: TBusObj; var Abort: boolean);
begin
  inherited CloneLines(Sender , Abort);
  if abort then exit;
  if not(Sender is TPurchaseOrderLine) then exit;
  if Sender.ObjInstanceToClone is TTranslinebase then
      TTranslinebase(Sender.ObjInstanceToClone).CalcLineTotals;
end;

function TPurchaseOrder.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := true;
    if GLAccountName <> '' then
        if Glaccountid = 0 then
            Glaccountid := tcDataUtils.getAccountID(GLAccountName);

end;
procedure TPurchaseOrder.SetFuturePo(const Value: boolean);
begin
  if Value then
    SetStringField('FuturePo', 'T')
  else
    SetStringField('FuturePo', 'F');
end;

procedure TPurchaseOrder.SetPaymentTerms(const BaseDate: TDateTime);
begin
    if basedate = 0 then Exit;
    Inherited;
end;
Function TPurchaseOrder.CheckForShipToFlags(Sender :Tfield):Boolean;
  function ShiptoFlagchanged :Boolean;
  begin
    result :=  (Sysutils.SameText(Sender.FieldName , 'ShiptoCustomer')) or
               (Sysutils.SameText(Sender.FieldName , 'ShipToDefaultAddress')) or
               (Sysutils.SameText(Sender.FieldName , 'ShipToClass')) ;
  end;
begin
  Result := False;
  if fbCheckingForShipTo then exit;
  fbCheckingForShipTo:= true;
  try
    if (sender = nil) or (ShiptoFlagchanged) then ShipTo := '';
    if sender <> nil then begin
      if (Sysutils.SameText(Sender.FieldName , 'ShiptoCustomer')) then begin
            if ShiptoCustomer         then begin
              if ShipToDefaultAddress then ShipToDefaultAddress := False;
              if ShipToClass          then ShipToClass := False;
            end;
            Result := True;
      end else if (Sysutils.SameText(Sender.FieldName , 'ShipToDefaultAddress')) then begin
            if ShipToDefaultAddress   then begin
              if ShiptoCustomer       then ShiptoCustomer := False;
              if ShipToClass          then ShipToClass := False;
            end;
            Result := True;
      end else if (Sysutils.SameText(Sender.FieldName , 'ShipToClass')) then begin
            if ShipToClass            then begin
              if ShiptoCustomer       then ShiptoCustomer := False;
              if ShipToDefaultAddress then ShipToDefaultAddress:= False;
            end;
            Result := True;
      end;
      if ShiptoFlagchanged then begin
           if not(ShiptoCustomer) and not(ShipToDefaultAddress) and not(ShipToClass) then
            ShipToDefaultAddress := True;
           if ShiptoCustomer then begin
              Shipto   := ShiptoCustomerAddress;
              ShipToId := 0;
           end else if ShipToClass then begin
              SendEvent(BusObjEvent_Change, BusObjEvent_POShipToClass, self);
           end else begin
           end;
           SendEvent(BusObjEvent_Change, BusObjEvent_POShipTo, self);
      end;
    end;

    if (sender = nil) or (ShiptoFlagchanged) then
      if (Shipto = '' ) then begin
            if Appenv.CompanyPrefs.UseEmployeeDeptAddressinPOShipto then begin
              if Employee.DefaultClass.useAddress then begin
                //ShipTo:= Employee.DefaultClass.Address;
                Shiptodept(Employee.DefaultClass.ID);
              end;
            end else if AppEnv.DefaultClass.ShipToAddress <> '' then begin
              //ShipTo:= AppEnv.DefaultClass.ShipToAddress;
              Shiptodept(AppEnv.DefaultClass.classID);
            end else begin
              ShipTo:= getCompanyAddress;
              ShipToID:= 0;
            end;

      end;

  finally
    fbCheckingForShipTo := False;
  end;
end;




Procedure TPurchaseOrder.Shiptodept(aClassID:Integer);
var
  s:String;
  DeptClassObj : TDeptClass;
  ShippingAddressObj :TShippingAddress;
begin
    if aClassID <> 0 then begin
      ShiptoClassID := aClassID;
      PostDB;
      DeptClassObj := TDeptClass.create(Self);
      try
          DeptClassObj.connection := connection;
          DeptClassObj.Load(aClassID);
          ShippingAddressObj := TShippingAddress.create(Self);
          try
            ShippingAddressObj.connection := connection;
            ShippingAddressObj.LoadSelect('DeptID=' + inttostr(DeptClassObj.Id)+' and DeptAddresstype =' + iif(DeptClassObj.UseAddress , '"D"', '"C"'));

            ShippingAddressObj.connection.beginNestedTransaction;
            try
              if ShippingAddressObj.count =0 then begin
                  ShippingAddressObj.New;
                  ShippingAddressObj.DeptID         := DeptClassObj.ID;
                  ShippingAddressObj.CompanyName := Appenv.CompanyInfo.Companyname;
              end;
              if DeptClassObj.UseAddress then begin
                  ShippingAddressObj.DeptAddresstype  := 'D';
                  ShippingAddressObj.ShipAddress      := DeptClassObj.Street;
                  ShippingAddressObj.ShipAddress1     := DeptClassObj.Street2;
                  ShippingAddressObj.ShipAddress2     := DeptClassObj.Street3;
                  ShippingAddressObj.ShipCity         := DeptClassObj.Suburb;
                  ShippingAddressObj.ShipPostCode     := DeptClassObj.Postcode;
                  ShippingAddressObj.ShipState        := DeptClassObj.State;
                  ShippingAddressObj.ShipCountry      := DeptClassObj.Country;
                  ShippingAddressObj.Locationcode     := DeptClassObj.Locationcode;
                  ShippingAddressObj.AddressValidated := true;
              end else begin
                 ShippingAddressObj.DeptAddresstype   := 'C';
                  ShippingAddressObj.ShipAddress      := Appenv.CompanyInfo.Address;
                  ShippingAddressObj.ShipAddress1     := Appenv.CompanyInfo.Address2;
                  ShippingAddressObj.ShipAddress2     := Appenv.CompanyInfo.Address3;
                  ShippingAddressObj.ShipCity         := Appenv.CompanyInfo.City;
                  ShippingAddressObj.ShipPostCode     := Appenv.CompanyInfo.Postcode;
                  ShippingAddressObj.ShipState        := Appenv.CompanyInfo.State;
                  ShippingAddressObj.ShipCountry      := Appenv.CompanyInfo.Country;
                  ShippingAddressObj.Locationcode     := Appenv.CompanyInfo.Locationcode;
                  ShippingAddressObj.AddressValidated := true;
              end;
              ShippingAddressObj.PostDB;
              if ShippingAddressObj.Save then begin
                ShippingAddressObj.connection.commitNestedTransaction;
              end else begin
                ShippingAddressObj.connection.RollbackNestedTransaction;
              end;
            Except
              on E:Exception do begin
                  ShippingAddressObj.connection.RollbackNestedTransaction;
              end;
            end;
            if ShippingAddressObj.count >0 then begin
              ShiptoId :=ShippingAddressObj.ID;
              ShipTo := ShippingAddressObj.CompanyName + #13#10 +  ShippingAddressObj.AddressAsString;
              PostDB;
              Exit;
            end;
          finally
            Freeandnil(ShippingAddressObj);
          end;

          s:= DeptClassObj.Address;
          if s<> '' then begin
            shipto := s;
            PostDB;
          end;
      finally
        Freeandnil(DeptClassObj);
      end;
    end;
end;


Function TPurchaseOrder.ShiptoCustomerAddress:String;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection.Connection);
  try
  qry.SQL.TExt := 'SELECT POL.CustomerJob,'+
                  ' if(IFNULL(inv.saleID,0)<>0 , Inv.Shipto , if(IFNULL(SO.saleID,0)<>0 , SO.Shipto , if(IFNULL(S.saleID,0)<>0 , S.Shipto ,'+
                  ' CONCAT_WS("\n" , C.Company , C.street, C.street2, C.street3 ,CONCAT(C.Suburb , C.State , C.Postcode)  )))) AS Shipto'+
                  ' FROM tblpurchaselines POL'+
                  ' LEFT JOIN tblsaleslines SL ON POL.SaleLineID = SL.SaleLineID'+
                  ' LEFT JOIN tblSales S ON SL.SaleID =S.saleID'+
                  ' LEFT JOIN tblsales SO ON (S.isquote ="T" AND SO.QuoteGlobalRef = S.globalref)'+
                  ' LEFT JOIN tblsales inv ON ((S.ISSalesOrder ="T" AND inv.SalesORderglobalref= S.globalref) OR'+
                  ' 					(SO.ISSalesOrder ="T" AND inv.SalesORderglobalref= SO.globalref))'+
                  ' LEFT JOIN tblclients C ON C.clientId = POL.CustomerJobID'+
                  ' WHERE POL.PurchaseOrderID = '+inttostr(ID)+
                  ' HAVING shipto <> ""'+
                  ' ORDER BY POL.LinesOrder';
    qry.Open;
    REsult := qry.Fieldbyname('Shipto').asString;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TPurchaseOrder.DoFieldOnChange(Sender: TField);
var
  fs:String;
//    BuyRate, SellRate: Double;
begin
    fbValidated := False;

    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
    inherited;
    if CheckForShipToFlags(Sender) then begin
    end else if (Sysutils.SameText(Sender.FieldName , 'EquipmentName'))  then begin
        EquipmentId := tcdatautils.getEquipmentId(EquipmentName);
        DoFieldOnChange(dataset.findfield('EquipmentId'));
    end else if (Sysutils.SameText(Sender.FieldName , 'EquipmentId'))  then begin
      if EquipmentId =0 then Equipmentname :=''
      else begin
        Equipmentname := tcdatautils.getEquipmentName(equipmentId);
        SendEvent(BusObjEvent_Change,BusObjEventVal_Equipment, self);
      end;
{->}end else if (Sysutils.SameText(Sender.FieldName , 'ETADate'))  then begin
        SendEvent(BusObjEvent_Change,BusObjEvent_POETADateChanged, self);
{->}end else if (Sysutils.SameText(Sender.FieldName , 'ShipToCustomer'))  then begin
        if ShipToCustomer then Lines.Iteraterecords(SetShiptofromLines)
        else begin
          if Appenv.CompanyPrefs.UseEmployeeDeptAddressinPOShipto then begin
            if Employee.DefaultClass.useAddress then
              //ShipTo:= Employee.DefaultClass.Address;
              Shiptodept(Employee.DefaultClass.ID);
          end else if AppEnv.DefaultClass.ShipToAddress <> '' then
            //ShipTo:= AppEnv.DefaultClass.ShipToAddress
            Shiptodept(AppEnv.DefaultClass.classID)
          else begin
            ShipTo:= getCompanyAddress;
            ShipToID:= 0;
          end;
        end;
{->}end else if (Sysutils.SameText(Sender.FieldName , 'ClientID'))  then begin
      if ClientID > 0 then begin
        if (AppEnv.CompanyPrefs.UseForeignCurrencyonPO) then begin
          if (Self.Supplier.ForeignExchangeCode <> '') then begin
            if Self.ForeignExchangeCode <> Self.Supplier.ForeignExchangeCode then begin
              Self.ForeignExchangeCode := Self.Supplier.ForeignExchangeCode;
            end;
          end else begin
            Self.ForeignExchangeCode := AppEnv.RegionalOptions.ForeignExDefault;
            Self.ForeignExchangeRate:= 1;
          end;
          SetPaymentTerms(SupplierInvoiceDate);
          // Prepare to set the foreign exchange rate
          if Self.ForeignExchangeCode <> AppEnv.RegionalOptions.ForeignExDefault then begin
            UpdateForeignRateForDate;
          end else begin
            Self.ForeignExchangeRate:= 1;
          end;
        end
        else begin
          Self.ForeignExchangeCode:= AppEnv.RegionalOptions.ForeignExDefault;
          Self.ForeignExchangeRate:= 1;
        end;
        OrderTo := supplier.ShipToAddress;
        InitAPAccount;
        CheckForShipToFlags(nil);
        if Appenv.CompanyPrefs.PurchaseETAFromSupplierShippingtime then begin
          ETADate := Now + supplier.ShipTime;
          DoFieldOnChange(Dataset.findfield('ETADate'));
        end;
        if TermsName = '' then begin
          if Supplier.TermsName <> '' then
            TermsName := Supplier.TermsName
          else
            TermsName:= TERMS_ON_RCPT;
        end;
        SendEvent(BusObjEvent_Change , BusObjEventVal_SupplierChanged , self);
      end;
    end else if Sysutils.SameText(Sender.fieldName , 'AccountName') then begin
        GLAccountId := tcDatautils.getaccountId(GLAccountName);
        DoFieldOnChange(Dataset.findfield('AccountID'));
    end else if Sysutils.SameText(Sender.fieldName , 'AccountId') then begin
        if GLAccountName= '' then GLAccountName := GLAccount.AccountName;
    end else if Sysutils.SameText(Sender.FieldName, 'Approved') then
    begin
        TApprovalCheck.Approved(self,Sender);
        if approved then ApproverId := AppEnv.Employee.EmployeeID;
        PostDB;
{-->}end else if Sysutils.SameText(Sender.FieldName , 'OrderDate') then begin
        CheckOrderDate;
        SetPaymentTerms(SupplierInvoiceDate);
{-->}end else if Sysutils.SameText(Sender.FieldName , 'ForeignExchangeCode') then begin
        // Process change in ForeignExchangeCode field

        if (AppEnv.CompanyPrefs.UseForeignCurrencyonPO) then begin
          // Revert currency code if there are pre existing purchase lines
          if Self.Lines.Count > 0 then begin
            // Set the foreign exchange code
            if not Sender.IsNull then Self.ForeignExchangeCode := Sender.Value;
            UpdateForeignRateForDate;
          end else begin
            // Prepare to set the foreign exchange rate
            if Self.ForeignExchangeCode <> AppEnv.RegionalOptions.ForeignExDefault then begin
              UpdateForeignRateForDate;
            end else self.ForeignExchangeRate := 1;
          end;
        end;
{-->}end else if Sysutils.SameText(Sender.FieldName , 'ForeignExchangeRate') then begin
        // Process change in ForeignExchangeRate field

        if (AppEnv.CompanyPrefs.UseForeignCurrencyonPO) then begin
          // Recalculate any purchase line records
          //Self.ProcessLineChange(Sender);
//          CalcAllLineTotals;
          CalcAllForeignLineTotals;
        end;
{-->}end else if Sysutils.SameText(Sender.FieldName , 'Terms') then begin
        SetPaymentTerms(SupplierInvoiceDate);
{-->}end else if Sysutils.SameText(Sender.FieldName , 'SupplierName') then begin
        ClientID := 0;
        SetPaymentTerms(SupplierInvoiceDate);
        if ClientID = 0 then begin
            clientId := TClient.IDToggle(SupplierName, Connection.Connection);;
            DoFieldOnChange(Dataset.findField('clientID'));
        end;
{-->}end else if Sysutils.SameText(Sender.FieldName , 'InvoiceDate') then begin
        SetPaymentTerms(SupplierInvoiceDate);
{-->}end else if Sysutils.SameText(Sender.FieldName , 'InvoiceNumber')  then begin
        if AppEnv.CompanyPrefs.MatchInvoiceDateToETADate then
          if (ETADate <> 0) and (SupplierInvoiceDate=0) then
            SupplierInvoiceDate := ETADAte;
{-->}end else if Sysutils.SameText(Sender.FieldName , 'LinkPORef') then begin
        if LinkPORef <> '' then begin
          Suppliername := POSupplierName(LinkPORef);
          DoFieldOnChange(dataset.findfield('SupplierName'));
          Comments := 'Link PO for PO#' + inttostr(TPurchaseOrder.IDToggle(LinkPORef));
        end;
      End;
end;

procedure TPurchaseOrder.UpdateForeignRateForDate;
var
  BuyRate, SellRate: Double;
begin
  // Validate date
  if Self.OrderDate = 0 then Self.OrderDate := Now;

  // Get the foreign exchange rates
  Self.FXObj.GetForeignExchangeRatesForDate(Self.ForeignExchangeCode,
    Self.OrderDate,BuyRate, SellRate);

  // validate the BuyRate
  if BuyRate <= 0 then BuyRate := 1;

  // Set the purchase order foreign exchange rate
  self.ForeignExchangeRate := BuyRate;
  if Self.Lines.Count > 0 then
    CalcAllLineTotals;
end;
function TPurchaseOrder.LockTrans(var ErrMsg: String): Boolean;
begin
  result := inherited LockTrans(ErrMsg);
  if  not result then exit;
end;

function TPurchaseOrder.GetLines: TTransLineBase;
begin
  result := GetPOLines;
end;
function  TPurchaseOrder.GetPOLines : TPurchaseOrderLine;
begin
    REsult := TPurchaseOrderLine(Getcontainercomponent(TPurchaseOrderLine ,'PurchaseOrderId = ' + IntToStr(Self.ID)));
end;

function TPurchaseOrder.GetSeqNo: Integer;
begin
  Result := GetIntegerField('SeqNo');
end;

function TPurchaseOrder.GetSOApprovedBy: integer;
begin
  Result := GetIntegerField('SOApprovedBy');
end;

procedure TPurchaseOrder.SetSeqNo(const Value: Integer);
begin
  SetIntegerField('SeqNo', Value);
end;

procedure TPurchaseOrder.CalcOrderTotals;
var
    fdForeignTotalAmount :Double;
    fdForeignBalanceAmount :Double;
begin
  Show_Status('Calculating Order totals.');
  try
    if DisableCalcOrderTotals then Exit;
    tmpTotalQtyShipped          := 0;
    tmpNonBOMtotalQtyShipped    := 0;
    tmpTotalQtyOrdered          := 0;
    tmpTotalQtyBackOrdered      := 0;
    tmpTotalForeignAmount       := 0;
    tmpTotalEstimatedAmountInc  := 0;
    tmpEstimatedForeignAmountInc:= 0;

    inherited; // calls CalcTotalsCallback

      TotalQtyShipped         := tmpTotalQtyShipped;
      NonBOMtotalQtyShipped   := tmpNonBOMtotalQtyShipped;
      TotalQtyOrdered         := tmpTotalQtyOrdered;
      TotalQtyBackOrdered     := tmpTotalQtyBackOrdered;
      TotalEstimatedAmountInc := RoundCurrency(tmpTotalEstimatedAmountInc);
      EstimatedForeignAmountInc:= RoundCurrency(tmpEstimatedForeignAmountInc);
      // set the field values only if they are different, this will help not to change the table
      // into edit mode when the record is loaded
      fdForeignTotalAmount      := CommonLib.Round(tmpTotalForeignAmount, CurrencyRoundPlaces);
      if fdForeignTotalAmount <> ForeignTotalAmount then ForeignTotalAmount := fdForeignTotalAmount;
      fdForeignBalanceAmount := self.ForeignTotalAmount - self.ForeignPaidAmount;
      if fdForeignBalanceAmount <> ForeignBalanceAmount then ForeignBalanceAmount := fdForeignBalanceAmount;
      postDB;
      AddEvent(BusObjEvent_Change, BusObjEventVal_OrderTotalsCalculated, Self.ID);
//      if Lines.Count > 0 then
//        TApprovalCheck.Approved(self);
  finally
    Show_Status('');
  end;
end;

procedure TPurchaseOrder.CalcTotalsCallback(Const Sender: TBusObj; var Abort: Boolean);
begin
  if TPurchaseOrderline(Sender).Deleted then Exit;
  inherited;
  // sum up PO specific fields
  if sametext(TPurchaseOrderLine(Sender).Productname , PART_SOPROGRESSPAYMENT) or Sametext(TPurchaseOrderLine(Sender).ProductName, PART_PROGRESSShipment) then
  else begin
    tmpTotalQtyShipped := tmpTotalQtyShipped + TPurchaseOrderLine(Sender).QtyShipped;
    if TPurchaseOrderLine(Sender).proctreeId=0 then
      tmpNonBOMtotalQtyShipped := tmpNonBOMtotalQtyShipped + TPurchaseOrderLine(Sender).QtyShipped;
    tmpTotalQtyOrdered := tmpTotalQtyOrdered + TPurchaseOrderLine(Sender).QtySold;
    tmpTotalQtyBackOrdered := tmpTotalQtyBackOrdered + TPurchaseOrderLine(Sender).QtyBackOrder;
  end;
  tmpTotalForeignAmount := tmpTotalForeignAmount + TPurchaseOrderLine(Sender).ForeignTotalLineAmount;
  tmpTotalEstimatedAmountInc := tmpTotalEstimatedAmountInc + (TPurchaseOrderLine(Sender).QtySold *
    TPurchaseOrderLine(Sender).LineCostInc);
//  tmpEstimatedForeignAmountInc := tmpEstimatedForeignAmountInc +(TPurchaseOrderLine(Sender).QtySold *
//    TPurchaseOrderLine(Sender).ForeignExchangeRate*TPurchaseOrderLine(Sender).LineCostInc);
  tmpEstimatedForeignAmountInc := tmpEstimatedForeignAmountInc +
    (Round(TPurchaseOrderLine(Sender).QtySold * TPurchaseOrderLine(Sender).ForeignLineCost * (1 + TPurchaseOrderLine(Sender).LineTaxRate),self.RoundPlacesGeneral));

end;

function TPurchaseOrder.GetOriginalPurchaseOrder: TPurchaseOrder;
begin
  if self.OriginalDocNumber = '' then Result := nil
  else if self.OriginalDocNumber = Self.GlobalRef then Result := nil
  else if Trim(Self.OriginalDocNumber) = Trim(IntToStr(Self.PurchaseOrderId)) then Result := nil
  else begin
    if not Assigned(fOriginalOrder) then begin
      fOriginalOrder := TPurchaseOrder.Create(nil);
      if ConnectionAssigned then fOriginalOrder.Connection := Self.Connection;
      fOriginalOrder.Load(0);
    end;
    if fOriginalOrder.GlobalRef <> self.OriginalDocNumber then begin
      fOriginalOrder.LoadSelect('GlobalRef = ' + QuotedStr(OriginalDocNumber));
    end;
    Result := fOriginalOrder;
  end;
end;

function TPurchaseOrder.GetBackOrderPurchaseOrder: TPurchaseOrder;
begin
  if Self.GetBackOrderGlobalRef = '' then Result := nil
  else begin
    if not Assigned(fBackOrder) then begin
      fBackOrder := TPurchaseOrder.Create(Self);
      if ConnectionAssigned then fBackOrder.Connection := Self.Connection;
    end;
    if fBackOrder.GlobalRef <> self.GetBackOrderGlobalRef then begin
      fBackOrder.LoadSelect('GlobalRef = ' + QuotedStr(self.GetBackOrderGlobalRef));
    end;
    Result := fBackOrder;
  end;
end;
function TPurchaseOrder.GetLastOrderOfGroup: TPurchaseOrder;
begin
  if Self.GetBackOrderGlobalRef = '' then Result := Self
  else REsult := BackOrderPurchaseOrder.LastOrderOfGroup;
end;

procedure TPurchaseOrder.Load(Const aId: Integer;const fIsReadonly:boolean =False);
begin
  self.fSQLSelect := 'PurchaseOrderID = ' + IntToStr(aId);
  inherited Load(aId , fIsReadonly);
end;

procedure TPurchaseOrder.Load(const fIsReadonly:boolean =False);
begin
  inherited Load;
  //LoadXML;
  // if the PO is creted from a convert, the SORTID may be blank. Generate the SORTID from seq no if its blank
  //getNewDataset('update tblPurchaseLines set SortID = Seqno*10  where ifnull(SORTID,0) = 0  and purchaseOrderId = ' + IntToStr(Self.ID) , True);
end;

{TEMPORARY SOLUTION
the PurchaseOrder form doesn;t call Object.Load but only
assigns the quyery to the object, so the xml is not getting created.
So leaving LoadXML procedure and the form calls it after assigning the dataset property.}
procedure TPurchaseOrder.LoadXML;
begin
  fCleanXMLDoc.LoadFromXML(XMLDoc.XML.Text);
  fCleanXMLDoc.Active := true;
end;
procedure TPurchaseOrder.New;
begin
    inherited;
    OrderDate           := Now;
    TotalQtyOrdered     :=0;
    TotalQtyShipped     :=0;
    NonBOMtotalQtyShipped:=0;
    TotalQtyBackOrdered := 0;
    InitAPAccount;
    PostDB;
    if self.OrderDate = 0 then begin
        OrderDate:= Date;
        CheckOrderDate;
    end;
    Lines; {acces the lines to lead it for the newly added PO record}
end;


function TPurchaseOrder.ValidateData: Boolean;
var
  Msg: String;
  LandedPercentage:Double;
begin
  Resultstatus.Clear;
  Show_Status('Validating PO.');
  {post both the object and lines if its in edit/insert mode}
  PostDB;
  lines.PostDb;

  Result := inherited ValidateData;
  if not Result then Exit;

  if SupplierId = 0 then begin
        ResultStatus.Additem(False, rssWarning, 0,'Supplier should not be blank.' );
        Result := false;
        Exit;
  end;
  if SupplierInvoiceNumber <> '' then
    if SupplierInvoiceDate = 0 then begin
        ResultStatus.Additem(False, rssWarning, 0,'Invoice Date must be specified.' );
        Result := false;
        Exit;
    end;

  if AppEnv.CompanyPrefs.POenforceETA then
    if ETADate = 0  then begin
        ResultStatus.Additem(False, rssWarning, 0, 'ETA Date must be specified.' );
        Result := false;
        Exit;
    end;
  if AppEnv.CompanyPrefs.EnforceConNoteOnPO then
    if GoodsReceived then
      if ConNote = '' then begin
        ResultStatus.Additem(False, rssWarning, 0, 'Con Note Number must be specified.' );
        Result := false;
        Exit;
      end;
  if self.TermsName = '' then begin
    ResultStatus.Additem(False, rssWarning, 0, 'Terms must be specified.' );
    Result := false;
    Exit;
  end;

  if Approved and (not TApprovalCheck.Approved(self)) then begin
    result := false;
    exit;
  end;

  if Lines.Dataset.RecordCount = 0 then Exit;
  Result := ValidateLines;
  if not Result then Exit;
  if AppEnv.CompanyPrefs.UseForeignCurrencyonPO then
    if HasImportCosts then  begin
        LandedPercentage := PercentageUseImportCost;
        if (100 - LandedPercentage) > 0.02 then    begin
        {Ship container now can spread the auxilary costs over multiple POs}
          //  Msg := 'You Have Only Allocated ' + FloatToStrF(LandedPercentage,ffNumber, 15, 2) +
          //         '% Of the Landed Costs !' ;
          //  self.ResultStatus.AddItem(false, rssWarning, BOR_Order_Warn_Landedcost, Msg);
        end else if (LandedPercentage - 100) > 0.02 then begin
            result := false;
            if Owner is TForm then
              SendEvent(BusObjEvent_Error,BusobjEventVal_FailedLandedCostValidation,self)
            else begin
              Msg := 'You Have Allocated ' + FloatToStrF(LandedPercentage, ffNumber, 15, 2) +
                     '% Of the Landed Costs, 100% should be the Maximum Allocated.'  ;
              AddResult(false, rssWarning, BOR_Order_Warn_Landedcost, Msg);
            end;
        end;
    end;
end;

function TPurchaseOrder.CheckBackOrders(BOPO:TPurchaseOrder): Boolean;
var
  combinedTransRef:String;
  //strSQL:String;
begin

  Show_Status('Update Back Orders.');
  result:= true;
  //if (self.BackOrderGlobalRef = self.GlobalRef) or (TotalQtyShipped = 0) or (TotalQtyBackOrdered = 0) then begin
  If (Self.BackOrderGlobalRef = Self.GlobalRef) Or (Not Lines.AnyLineShipped) Or (Not Lines.AnyLineBackOrdered) Then Begin
      DeleteBackOrder(BOPO);
      Lines.Iteraterecords(AfterBODeleteCallback);
      exit;
  end;
  if IsBOInvoiced then Exit;
  if UpdatingBo then Exit;
    BOPO.SilentMode:= true;
    BOPO.Connection:= self.Connection;
//    combinedTransRef := Supplier.CombinedPurchaseBOID;
    combinedTransRef := ' ';
    ReadBO(BOPO,False {AppEnv.CompanyPrefs.CombinedPurchaseBO},combinedTransRef);
    BOPO.Lines.AccessManager.AccessLevel := Lines.AccessManager.AccessLevel;
    UpdateBO(BOPO);
    //if (AppEnv.CompanyPrefs.CombinedPurchaseBO) and (combinedTransRef <> Supplier.CombinedPurchaseBOID) then begin
//      strSQL :='Update tblClients Set CombinedPurchaseBOID = ' +quotedStr(combinedTransRef) + ' where clientId = ' + IntToStr(Supplier.ID);
//      PostList.AddQuery(strSQL , Supplier.ID , Supplier.BusObjectTableName , True);
//      (*Supplier.CombinedPurchaseBOID := combinedTransRef;
//      Supplier.PostDB;*)
//    end;
end;

function TPurchaseOrder.Save: Boolean;
var
  iAccesslevel :Integer;
  BOPO: TPurchaseOrder;
//     Fbfiltered:Boolean;
begin
  ResultStatus.Clear;
  try
      if not dirty then begin
          result := true;
          Exit;
      end;
        { TODO -obinny : Issues when Changing Ordered Qty of a PO with BO(with the full qty shipped) :
        The Ordered Qty of all related records are updated , but new BO is not created

        PO#1 --> BO#1 --> BO#2
        if payment is made for BO#1, BO#1 will be locked and is possible to edit PO#1 }
        Result := false;
        try
          iAccesslevel := Lines.AccessManager.AccessLevel;
          Lines.AccessManager.AccessLevel := AccessManager.AccessLevel;
          Try
              postdb;
              //PostList.Clear;
              if not Validated then //validation alReady done when called from the form
                  if not ValidateData then Exit;

              if not SaveGUIValidate then exit;

              CalcOrderTotals;
              if OrderDate = 0 then OrderDate := Date;
              if SupplierInvoiceNumber = '' then begin
                  {make these fields null - should not be empty String or 0 instead of null (for the reports)}
                if dataset.State in [dsEdit,dsInsert] then else Dataset.Edit;
                if Dataset.fieldByname('InvoiceDate').asVariant <> null then
                      Dataset.fieldByname('InvoiceDate').asVariant := null;
                if dataset.State in [dsEdit,dsInsert] then else Dataset.Edit;
                if Dataset.fieldByname('InvoiceNumber').asVariant <> null then
                      Dataset.fieldByname('InvoiceNumber').asVariant := null;
                PostDB;
              end;
              if AppEnv.CompanyPrefs.UpdateSaleShippedFromPOReceived then begin
                if (not UpdateLinkedSale) then
                  exit;
              end;

              AllLinesSavedOK := true;
              COGSValueUpdate;

              CalcOrderTotals;

              UpdateAccounts;

              UpdateProductAvgCosts; // updates the average costs in the po lines before the qty is updated
                              // the forms aftercommit updates the product's average costs after the qty is updates

              AllLinesSavedOK:= true;
              Lines.IterateRecords(LineSaveCallbackProc, True);

              (*Fbfiltered := Lines.filtered;
              Lines.filtered:= False;
              try
                Lines.IterateRecords(LineSaveCallbackProc, true);
              finally
                Lines.filtered:= Fbfiltered;
              end;*)

              Result := AllLinesSavedOK;
              if not result then exit;

              (*Lines.IterateRecords(LineSaveRepairParts, True);
              Result := AllLinesSavedOK;
              if not result then exit;*)

              result:= inherited Save;
              if not result then exit;

              if CleanApproved <> Approved then
                if AppEnv.CompanyPrefs.UseApprovalLevels then AddToPayAuthorisations;

              if Result then begin
                if UpdatingBo = False then begin
    //              BOPO := TPurchaseOrder.Create(nil);
                  { use the same class as self which could be a descendent of TPurchaseOrder .. }
                  BOPO := TPurchaseOrder(TComponentClass(FindClass(Self.ClassName)).Create(nil));
                  Try
                    BOPO.connection := Self.Connection; // this connection expected to be wihtin transaction
                    BOPO.LoadSelect('GlobalRef = ' + QuotedStr(self.BackOrderGlobalRef));
                    (*BOPO.IgnoreAccesslevel := True;*)
                    BOPO.AccessManager.AccessLevel := 1;
                    CheckBackOrders(BOPO);
                  finally
                      FreeandNil(BOPO);
                  end;
                end;
                if not PostList.Execute then begin
                    REsult := False;
                    Exit;
                end;
                UpdateBORefs;
              End;
          Finally
              Lines.AccessManager.AccessLevel := iAccesslevel;
          end;
          SendAllEvents;
      finally
        PostList.Clear;
        if result then  result :=  Validtocommit;
        if updatingBo = False then
            Show_Status('');
      end;
      if result then begin
        if DeleteFlaggedLines then
          Dirty := False
        else
          result := False;
      end;
  finally
    Show_Status('');
  end;

end;

//procedure TPurchaseOrder.ProcessLineChange(Sender: TField);
//var
//  bm: TbookMark;
//begin
//  // process changes to purchase order lines
//  if Self.Lines.Count > 0 then begin
//    bm := Self.Lines.DataSet.getBookMark;
//    try
//      Self.Lines.First;
//      while Self.Lines.Eof = false do begin
//        Self.Lines.ReCalculateLineAmounts;
//        Self.Lines.Next;
//      end;
//    finally
//      self.Lines.Dataset.gotoBookMark(bm);
//      self.Lines.Dataset.FreeBookmark(bm);
//    end;
//    self.CalcOrderTotals;
//  end;
//end;

procedure TPurchaseOrder.CalcAllForeignLineTotals;
var
  bm: TbookMark;
  saveDoFieldChange: boolean;
begin
  // process changes to purchase order lines
  if Self.Lines.Count > 0 then begin
    bm := Self.Lines.DataSet.getBookMark;
    try
      Self.Lines.First;
      while Self.Lines.Eof = false do begin
        saveDoFieldChange:= Self.Lines.DoFieldChange;
        Self.Lines.DoFieldChange:= false;
        try
          TPurchaseOrderLine(Self.Lines).CalcLineForeignTotals;
        finally
          Self.Lines.DoFieldChange:= saveDoFieldChange;
        end;
        Self.Lines.Next;
      end;
    finally
      try
        self.Lines.Dataset.gotoBookMark(bm);
        self.Lines.Dataset.FreeBookmark(bm);
      except

      end;
    end;
    self.CalcOrderTotals;
  end;
end;

procedure TPurchaseOrder.CalcAllLineTotals;
var
  bm: TbookMark;
  saveDoFieldChange: boolean;
begin
  //inherited;
  // process changes to purchase order lines
  if Self.Lines.Count > 0 then begin
    bm := Self.Lines.DataSet.getBookMark;
    try
      Self.Lines.First;
      while Self.Lines.Eof = false do begin
        saveDoFieldChange:= Self.Lines.DoFieldChange;
        Self.Lines.DoFieldChange:= false;
        try
          TPurchaseOrderLine(Self.Lines).CalcLineTotals;
        finally
          Self.Lines.DoFieldChange:= saveDoFieldChange;
        end;
        Self.Lines.Next;
      end;
    finally
      try
        self.Lines.Dataset.gotoBookMark(bm);
        self.Lines.Dataset.FreeBookmark(bm);
      except

      end;
    end;
    self.CalcOrderTotals;
  end;
end;

Function TPurchaseOrder.getGoodsReceived :Boolean;
begin
    fbGoodsReceived := False;
    Lines.IterateREcords(CheckGoodsReceived);
    Result := fbGoodsReceived;
end;
function TPurchaseOrder.getbinGoodsReceived:Boolean;
var
    strSQL :String;
begin
    Result := False;
    strSQL := 'SELECT tblpurchaselines.PurchaseLineID FROM tblpurchaselines ' +
                ' Inner Join tblparts ON tblpurchaselines.ProductID = tblparts.PARTSID ' +
                ' where ifnull(tblparts.MultipleBins,"T") = "T" ' +
                ' and tblpurchaselines.PurchaseOrderID = ' + IntToStr(ID);
    with getNewdataset(strSQL , True) do try
        if recordcount = 0 then exit;
        first;
        while Eof = False do begin
            if Lines.Dataset.Locate('PurchaseLineID' , fieldbyname('PurchaseLineID').asInteger , []) then begin
                if Lines.QtyShipped <> lines.CleanQty then Result := True;
            end else Result := true;
            Next;
        end;
    finally
        if active then close;
        Free;
    end;

end;
function TPurchaseOrder.GetHasImportCosts: Boolean;
begin
    fdImportCosts := 0;
    Lines.Iteraterecords(FindImportCosts);
    Result := fdImportCosts > 0;
end;
function TPurchaseOrder.getInvoiceID: Integer;
begin
  result:= 0;
  if SalesGlobalref = '' then exit;
  with GetNewdataset('select s.SAleID, S.Isinvoice, S.ISSalesorder from tblSales S where Globalref = ' +Quotedstr(SalesGlobalref), true) do try
    if FieldByname('Isinvoice').AsBoolean then result := Fieldbyname('SAleId').AsInteger;
  finally
    if active then close;
    free;
  end;
end;
function TPurchaseOrder.getSalesORderID: Integer;
begin
  result:= 0;
  if SalesGlobalref = '' then exit;
  with GetNewdataset('select s.SAleID, S.Isinvoice, S.ISSalesorder from tblSales S where Globalref = ' +Quotedstr(SalesGlobalref), true) do try
    if FieldByname('ISSalesorder').AsBoolean then result := Fieldbyname('SAleId').AsInteger;
  finally
    if active then close;
    free;
  end;
end;
function TPurchaseOrder.getsalesGlobalref: String;begin  Result := GetStringField('salesGlobalref');end;
function TPurchaseOrder.getLinkPORef: String;begin  Result := GetStringField('LinkPORef');end;
function TPurchaseOrder.getEquipmentname: String;begin  Result := GetStringField('Equipmentname');end;
function TPurchaseOrder.getFuturePo: boolean;begin  Result := GetStringField('FuturePO') = 'T';end;
Function TPurchaseOrder.getEquipmentId :Integer ; begin result := GetIntegerField('EquipmentId');end;
procedure TPurchaseOrder.setsalesGlobalref(const Value: String);begin  SetStringField('salesGlobalref' , Value); end;
procedure TPurchaseOrder.setLinkPORef(const Value: String);begin  SetStringField('LinkPORef' , Value); end;

procedure TPurchaseOrder.setEquipmentname(const Value: String);begin  SetStringField('Equipmentname' , Value); end;
procedure TPurchaseOrder.SetCreatedFromSO(const Value: integer);begin  SetIntegerField('CreatedFromSO', Value);end;
Procedure TPurchaseOrder.SetEquipmentId(const Value:Integer); begin SetIntegerField('EquipmentId' , value);end;
function  TPurchaseOrder.getSaleLineRef: String;begin  Result := GetStringField('SaleLineRef');end;
procedure TPurchaseOrder.setSaleLineRef(const Value: String);begin  SetStringField('SaleLineRef' , Value); end;

function TPurchaseOrder.GetPercentageUseImportCost: Double;
begin
    fdPercentageUseImportCost := 0;
    Lines.Iteraterecords(CalcPercentageUseImportCost);
    Result :=fdPercentageUseImportCost;
end;
function TPurchaseOrder.getPurchaseLinePackWeightLinesSum: TPurchaseLinePackWeightLinesSum;
begin
  Result := TPurchaseLinePackWeightLinesSum(GetContainerComponent(TPurchaseLinePackWeightLinesSum, 'PurchaseOrderId = ' + IntToStr(Self.Id)));
end;

function TPurchaseOrder.getBuildBackOrderFilter: String;
begin
  fsBackOrderFilter := '';
  Lines.IterateRecords(ProductBackOrderIds) ;
  Result :=fsBackOrderFilter;
end;

procedure TPurchaseOrder.UpdateProductAvgCosts;
begin
  Lines.IterateRecords(UpdateLineAvgCost);
  Show_Status('');
end;

procedure TPurchaseOrder.LineBalanceCallbackProc(Const Sender: TBusObj; var Abort: Boolean);
begin
    inherited;
end;

procedure TPurchaseOrder.UpdateLineAvgCost(Const Sender: TBusObj; var Abort: Boolean);
var
  TempCost : Double;
begin
  ProgressProcesswithRecno(sender);
  Show_Status('Updating Product''s average Cost : ' + IntToStr(Sender.Dataset.recno) + ' of ' + IntToStr(Sender.Dataset.recordcount));
  if Commonlib.IsInvProduct(TPurchaseOrderLine(Sender).ProductType) then begin
    TPurchaseOrderLine(Sender).UpdateproductAverageCost(TempCost , true);
    if TPurchaseOrderLine(sender).AverageCost = 0 then
        TPurchaseOrderLine(sender).AverageCost := Tempcost;
    TPurchaseOrderLine(sender).PostDB;
  End;
end;

procedure TPurchaseOrder.FindImportCosts(Const Sender: TBusObj; var Abort: Boolean);
begin
    fdImportCosts:= fdImportCosts  + TPurchaseOrderLine(Sender).TotalOrderLandedCost;
end;
function TPurchaseOrder.getApprovaltype: String;
begin
  REsult := ApprovalTypePurchaseOrder;
end;

procedure TPurchaseOrder.ProductBackOrderIds(Const Sender: TBusObj; var Abort: Boolean);
begin
    ProgressProcesswithRecno(sender);
    With getNewDataset('Select s.SaleID , Sl.ProductId from tblsales s, tblSalesLines sl ' +
        ' Where s.SaleID = sl.SaleID  ' +
        ' and (IsInvoice = "T" Or IsSalesOrder = "T")  ' +
        ' and sl.ProductID =  ' +IntToStr(TPurchaseOrderLine(sender).ProductID) +
        ' and sl.BackOrder > 0') do Try
        First;
        While Eof = False do begin
            if fsBackOrderFilter <> '' then fsBackOrderFilter := fsBackOrderFilter +' OR ';
            fsBackOrderFilter := fsBackOrderFilter + '(SaleID = ' + IntToStr(FieldByname('SaleID').asInteger)+' and ProductId = ' + IntToStr(Fieldbyname('ProductID').asInteger) +')';
            Next;
        end;
    finally
        if Active then close;
        free;
    end;
end;
procedure TPurchaseOrder.ReDistributeLineLandedCost;
var
  bm: TBookmark;
  totalPercent, percent, total: double;
  SaveDoFieldChangewhenDisabled: boolean;
begin
  ShowProgressBar(Lines.Count, 'Calculating Costs');
  SaveDoFieldChangewhenDisabled := Lines.DoFieldChangewhenDisabled;
  Lines.DoFieldChangewhenDisabled := true;
  Lines.Dataset.DisableControls;
  try
    bm := Lines.Dataset.GetBookmark;
    try
      Lines.First;
      total := 0;
      while not Lines.EOF do begin
        if not Lines.Deleted then begin
          total := total + (Lines.LineCostInc * Lines.QtySold);
        end;
        StepProgressBar();
        Lines.Next;
      end;
      Lines.First;
      totalPercent := 0;
      while not Lines.EOF do begin
        if not Lines.Deleted then begin

          percent := Round(DivZer(Lines.LineCostInc * Lines.QtySold, total) * 100,2);
          Lines.TotalLineLandedCostPerc := percent;
          Lines.PostDb;
          totalPercent := totalPercent + percent;

        end;
        StepProgressBar();
        Lines.Next;
        if Lines.EOF then begin
          if not Math.SameValue(totalPercent, 100, 0.001) then begin
            Lines.TotalLineLandedCostPerc := Lines.TotalLineLandedCostPerc + (100 - totalPercent);
          end;
        end;
      end;
      Lines.PostDb;
      Lines.Dataset.GotoBookmark(bm);
    finally
      Lines.Dataset.FreeBookmark(bm);
    end;
  finally
    Lines.Dataset.EnableControls;
    Lines.DoFieldChangewhenDisabled := SaveDoFieldChangewhenDisabled;
    HideProgressBar;
  end;
end;

procedure TPurchaseOrder.CalcPercentageUseImportCost(Const Sender: TBusObj; var Abort: Boolean);
begin
    fdPercentageUseImportCost := fdPercentageUseImportCost +
        TPurchaseOrderLine(Sender).TotalLineLandedCostPerc;
end;
procedure TPurchaseOrder.CheckGoodsReceived(Const Sender: TBusObj; var Abort: Boolean);
begin
    if TPurchaseOrderLine(Sender).QtyShipped <> TPurchaseOrderLine(Sender).CleanQty then
        fbGoodsReceived := True;
end;
procedure TPurchaseOrder.LineSaveCallBackProc(Const Sender: TBusObj; var Abort: Boolean);
begin
  ProgressProcesswithRecno(sender);
  Show_Status('Updating Product''s Quantity : ' + IntToStr(Sender.Dataset.recno) + ' of ' + IntToStr(Sender.Dataset.recordcount));
  if UpdatingBo = False then TPurchaseOrderLine(Sender).ChangeOrderQty;
  if not TPurchaseOrderLine(Sender).Save then begin
    AllLinesSavedOK := false;
    Abort           := true;
  end;
end;

(*

changing po shouldnt update the repair - so is removed
Also teh update should use business object , not queries
procedure TPurchaseOrder.LineSaveRepairParts(const Sender: TBusObj; var Abort: Boolean);
var
  qryScript :TERPScript;
  lStr : string;
  qry1,
  qry : TERPQuery;
  lineId : string;
  oldId,
  newId : integer;
  lDate : TDateTime;
  tblDetails : TCustomMyDataSet; //TERPQuery;

  function fld(const Name : string) : string;
  begin
    Result := tblDetails.FieldByName(Name).AsString + ',';
  end;

  function flds(const Name : string) : string;
  begin
    Result := '"' + tblDetails.FieldByName(Name).AsString + '",';
  end;

begin
  // Only on Save click
//  if not Saving  then exit;
try


  tblDetails := TPurchaseOrderLine(Sender).Dataset;
  qryScript := DbSharedObj.GetScript(Connection.Connection);
  try
    qryScript.Connection := Connection.Connection; //tblDetails.Connection;
    qry := TERPQuery.Create(self);
    qry1 := TERPQuery.Create(self);
    try
      qry.Connection := Connection.Connection;
      qry1.Connection := Connection.Connection;
      qryScript.SQL.Clear;
      if tblDetails.FieldByName('OldRepairId').IsNull then oldId := 0
      else oldId := tblDetails.FieldByName('OldRepairId').AsInteger;
      if oldId <> 0 then
        if not UserLock.Lock(TRepairs.BusObjectTableName, oldId, lockGroupName) then begin
           AllLinesSavedOK := false;
           ResultStatus.AddItem(False, rssWarning, 0 , StringReplace(UserLock.LockMessage, 'Unable to update data.' ,  'Unable to update the linked Repair#' + IntToStr(oldId) , [rfIgnoreCase]));
           Exit;
        end;
      if tblDetails.FieldByName('RepairId').IsNull then newId := 0
      else newId := tblDetails.FieldByName('RepairId').AsInteger;
      if newId <> 0 then
        if not UserLock.Lock(TRepairs.BusObjectTableName, newId, lockGroupName) then begin
            ResultStatus.AddItem(False, rssWarning, 0 , StringReplace(UserLock.LockMessage, 'Unable to update data.' ,  'Unable to update the linked Repair#' + IntToStr(newId) , [rfIgnoreCase]));
           AllLinesSavedOK := false;
           Exit;
        end;

      lineId := tblDetails.FieldByName('PurchaseLineId').AsString;

      qry.Close;
      qry1.Close;

      if (oldId > 0) or (newId > 0) then begin
        qry.SQL.Clear;
        qry.SQL.Add('select * from tblRepairParts where PurchaseLineId = ' + lineId);
        qry.Open;
      end else exit;

      if (qry.RecordCount > 0) then begin
            qry.First;
            While qry.Eof = False do begin
              if not UserLock.Lock(TRepairs.BusObjectTableName, qry.fieldbyname('RepairID').asInteger, lockGroupName) then begin
                 AllLinesSavedOK := false;
                 ResultStatus.AddItem(False, rssWarning, 0 , StringReplace(UserLock.LockMessage, 'Unable to update data.' ,  'Unable to update the linked Repair#' + IntToStr(qry.fieldbyname('RepairID').asInteger) , [rfIgnoreCase]));
                 Exit;
              end;
              qry.Next;
            end;
      end;

      if (qry.RecordCount > 0) then begin
        if (tblDetails.FieldByName('Deleted').asBoolean) or (newId = 0) or
           (tblDetails.FieldByName('CustomerEquipmentId').AsInteger > 0) then begin // was product - became equipment
            qryScript.SQL.Add('delete from tblRepairParts where PurchaseLineId = ' + lineId + ';');
           end;
      end;

      if (oldId = 0) and (newId = 0) and (qry.RecordCount = 0) then exit;

        // newId > 0 here
      closedb(qry);
      opendb(qry);
      if (qry.RecordCount > 0) then begin  // line exists
        if newId <> oldId then
          qryScript.SQL.Add('update tblRepairParts set RepairId = ' + IntToStr(newId) + ' where PurchaseLineId = ' + lineId + ';');
      end else  begin // count = 0
        if ConvertingRepairFromSmartOrder then begin
          qry.Close;
          qry.SQL.Text := 'select * from tblRepairParts where RepairId='+IntToStr(newId) + ' and PartsId=' +
             tblDetails.FieldByName('ProductId').asString + ' AND PurchaseLineId is null and Qty=' +
             tblDetails.FieldByName('QtySold').AsString;
          qry.Open;
          if qry.RecordCount > 0 then begin  // need to update existing
            qryScript.SQL.Add('update tblRepairParts set PurchaseLineId = ' + inttostr(tblDetails.FieldByName('PurchaseLineId').asInteger) +', '+
                                                         ' PurchaseOrderId = '+ inttostr(tblDetails.FieldByName('PurchaseOrderId').asInteger) +
                                                         ' where RepairPartsId=' + inttostr(qry.FieldByName('RepairPartsId').asInteger) + ';');
            qry.Close;
            qryScript.Execute;  // do not need other stuff
            exit;
          end;
          qry.Close;
          qry.SQL.Text := 'select * from tblRepairParts where RepairId='+IntToStr(newId) + ' and PartsId=' +
             tblDetails.FieldByName('ProductId').asString + ' AND Qty=' +
             tblDetails.FieldByName('QtySold').AsString;
          qry.Open;
        end;
        // duplicating - either from normal PO or from smart order when need to duplicate
        qryScript.SQL.Add('INSERT INTO tblRepairParts');
        qryScript.SQL.Add('(RepairId, PartsId, PurchaseOrderId, PurchaseLineId) VALUES');
        qryScript.SQL.Add('(' + fld('RepairId') + fld('ProductId') + fld('PurchaseOrderId') + fld('PurchaseLineId'));
        lSTr := qryScript.SQL[qryScript.SQL.Count - 1];
        lStr[length(lStr)] := ')';
        qryScript.SQL[qryScript.SQL.Count - 1] := lStr;
        qryScript.SQL.Add(';');
      end;

      qry1.SQL.Text := 'SELECT Price1, Priceinc1, PartType, CUSTFLD1, CUSTFLD2, CUSTFLD3, CUSTFLD4, CUSTFLD5, CUSTFLD6, '#13#10 +
         'CUSTFLD7, CUSTFLD8, CUSTFLD9, CUSTFLD10'#13#10 +
         'FROM tblParts where PartsId = ' + tblDetails.FieldByName('ProductId').AsString;
      qry1.Open;
      // Now just update - the record already exists
      qryScript.SQL.Add('update tblRepairParts set');
      qryscript.SQL.Add('PartName = ' + flds('ProductName'));
      qryScript.SQL.Add('Qty = ' +  fld('qtySold'));
      qryScript.SQL.Add('Description = ' + flds('product_description'));
      qryScript.SQL.Add('TaxCode = ' + flds('LineTaxCode'));
      qryScript.SQL.Add('TaxRate = ' + fld('LineTaxRate'));
      qrySCript.SQL.Add('ClassId=' + fld('ClassId'));
      qryScript.SQL.Add('ClassName=' + flds('Class'));

      if ConvertingRepairFromSmartOrder then
            qryScript.SQL.Add('LineCost=' + qry.FieldByName('LineCost').AsString + ',')
      else  qryScript.SQL.Add('LineCost=' + fld('LineCost'));

      qryScript.SQL.Add('UnitOfMeasureId=' + fld('UnitOfMeasureId'));
      qryScript.SQL.Add('UnitOfMeasureMultiplier=' + fld('UnitOfMeasureMultiplier'));
      qryScript.SQL.Add('UnitOfMeasure=' + flds('UnitOfMeasurePOLines'));
      qryScript.SQL.Add('UOMQty=' + fld('UnitOfMeasureQtySold'));
      qryScript.SQL.Add('PartType = "' + qry1.FieldByName('PartType').AsString + '",');
      if ConvertingRepairFromSmartOrder then begin
        qryScript.SQL.Add('PriceEx = ' + qry.FieldByName('PriceEx').AsString + ',');
        qryScript.SQL.Add('PriceInc = ' + qry.FieldByName('PriceInc').AsString + ',');
        qryScript.SQL.Add('LineTotalEx = ' + qry.FieldByName('LineTotalEx').AsString + ',');
        qryScript.SQL.Add('CustFld1 = "' + qry.FieldByName('CustFld1').AsString + '",');
        qryScript.SQL.Add('CustFld2 = "' + qry.FieldByName('CustFld2').AsString + '",');
        qryScript.SQL.Add('CustFld3 = "' + qry.FieldByName('CustFld3').AsString + '",');
        qryScript.SQL.Add('CustFld4 = "' + qry.FieldByName('CustFld4').AsString + '",');
        qryScript.SQL.Add('CustFld5 = "' + qry.FieldByName('CustFld5').AsString + '",');
        qryScript.SQL.Add('CustFld6 = "' + qry.FieldByName('CustFld6').AsString + '",');
        qryScript.SQL.Add('CustFld7 = "' + qry.FieldByName('CustFld7').AsString + '",');
        qryScript.SQL.Add('CustFld8 = "' + qry.FieldByName('CustFld8').AsString + '",');
        qryScript.SQL.Add('CustFld9 = "' + qry.FieldByName('CustFld9').AsString + '",');
        qryScript.SQL.Add('CustFld10 = "' + qry.FieldByName('CustFld10').AsString + '",');
      end else begin
        qryScript.SQL.Add('PriceEx = ' + qry1.FieldByName('Price1').AsString + ',');
        qryScript.SQL.Add('PriceInc = ' + qry1.FieldByName('PriceInc1').AsString + ',');
        qrySCript.SQL.Add('LineTotalEx=' + FloatToStr(qry1.FieldByName('Price1').AsFloat * tblDetails.FieldByName('QtySold').asFloat)+',');
        qryScript.SQL.Add('CustFld1 = "' + qry1.FieldByName('CustFld1').AsString + '",');
        qryScript.SQL.Add('CustFld2 = "' + qry1.FieldByName('CustFld2').AsString + '",');
        qryScript.SQL.Add('CustFld3 = "' + qry1.FieldByName('CustFld3').AsString + '",');
        qryScript.SQL.Add('CustFld4 = "' + qry1.FieldByName('CustFld4').AsString + '",');
        qryScript.SQL.Add('CustFld5 = "' + qry1.FieldByName('CustFld5').AsString + '",');
        qryScript.SQL.Add('CustFld6 = "' + qry1.FieldByName('CustFld6').AsString + '",');
        qryScript.SQL.Add('CustFld7 = "' + qry1.FieldByName('CustFld7').AsString + '",');
        qryScript.SQL.Add('CustFld8 = "' + qry1.FieldByName('CustFld8').AsString + '",');
        qryScript.SQL.Add('CustFld9 = "' + qry1.FieldByName('CustFld9').AsString + '",');
        qryScript.SQL.Add('CustFld10 = "' + qry1.FieldByName('CustFld10').AsString + '",');
      end;
      qryScript.SQL.Add('ConvertToInvoice="F", msUpdateSiteCode="DEF",');
      lDate := tblDetails.FieldByName('ReceivedDate').asDateTime;
      lStr := FormatDateTime('YYYY/MM/DD  hh:mm:ss', lDate);
      qryScript.SQL.Add('PartIssuedOn = ' + '"' + lStr + '",');
      lSTr := qryScript.SQL[qryScript.SQL.Count - 1];
      qryScript.SQL[qryScript.SQL.Count - 1] := copy(lStr,1,length(lStr) - 1);
      qrySCript.sql.Add('where PurchaseLineId = ' + lineId + ';');

      if qrySCript.sql.Count > 0 then
        qryScript.Execute;

    finally
      qry.Free;
      qry1.Free;
    end;
  finally
    DbSharedObj.ReleaseObj(qrySCript);
  end;
Except
  on Exception do
  begin
    AllLinesSavedOK := false;
    Abort           := true;
  end;
end;

end;*)

procedure TPurchaseOrder.LineValidateCallBackProc(Const Sender: TBusObj; var Abort: Boolean);
var
     x:Integer;
begin
  Show_Status('Validating PO Lines : ' + IntToStr(Sender.Dataset.recno) + ' of ' + IntToStr(Sender.Dataset.recordcount));
  if ((TPurchaseOrderLine(Sender).ProductId = 0) and (TPurchaseOrderLine(Sender).ProductName = '')) then
    TPurchaseOrderLine(Sender).Deleted := True;
  if (not TPurchaseOrderLine(Sender).Deleted) and (not TPurchaseOrderLine(Sender).ValidateData) then begin
    for x:= 0 to Lines.ResultStatus.Count -1 do
       Resultstatus.AddItem(TResultStatusItem(Lines.ResultStatus.Items[x]).OperationOk ,
                            TResultStatusItem(Lines.ResultStatus.Items[x]).Severity ,
                            TResultStatusItem(Lines.ResultStatus.Items[x]).Code ,
                            TResultStatusItem(Lines.ResultStatus.Items[x]).Message , False);
    AllLinesValid := false;
    Abort         := true;
  end;
end;

procedure TPurchaseOrder.COGSValueUpdate;
var
  QtyList: TProductTotalQtyList;
  QtyItem: TProductTotalQty;
  x: integer;
  qty: double;
begin
  if Lines.Dataset.RecordCount < 1 then exit;
  QtyList:= TProductTotalQtyList.Create;
  Lines.Dataset.DisableControls;
  try
    { get totals for each procuct id, (product could be on more than one line on PO) }
    Lines.Dataset.First;
    while not Lines.Dataset.Eof do begin
      if (not Lines.Deleted) and Commonlib.IsInvProduct(Lines.ProductType) then
        QtyList.Add(Lines.Product,Lines.QtyShipped);
      Lines.Dataset.Next;
    end;

    { update the TotalQtyToAllocate, this is the qty that we need to bring this
      stock item back to zero from a negative qty on hand }
    for x:= 0 to QtyList.Count -1 do begin
      QtyItem:= QtyList.Item[x];
      if (QtyItem.TotalQtyInStock - QtyItem.TotalQtyShipped) < 0 then
        QtyItem.TotalQtyToAllocate:= Abs(QtyItem.TotalQtyInStock - QtyItem.TotalQtyShipped)
      else
        QtyItem.TotalQtyToAllocate:= 0;
    end;

    { now update the lines }
    Lines.Dataset.First;
    while not Lines.Dataset.Eof do begin
      ProgressProcesswithRecno(Lines);
      if not Lines.Deleted then begin
        if Commonlib.IsInvProduct(Lines.ProductType) then begin
          QtyItem:= QtyList.ItemById[Lines.ProductId];
          if Assigned(QtyItem) and (QtyItem.TotalQtyToAllocate > 0) then begin
            if Lines.QtyShipped <= QtyItem.TotalQtyToAllocate then
              Qty:= Lines.QtyShipped
            else
              Qty:= QtyItem.TotalQtyToAllocate;
            Lines.COGSTotalLineAmount:= Qty * (Lines.LineCost - Lines.AverageCost);
            Lines.COGSTotalLineAmountInc:= Qty * (Lines.LineCostInc - (Lines.AverageCost + (Lines.AverageCost * Lines.LineTaxRate)));
            QtyItem.TotalQtyToAllocate:= QtyItem.TotalQtyToAllocate - Qty;
          end
          else begin
            Lines.COGSTotalLineAmount:= 0;
            Lines.COGSTotalLineAmountInc:= 0;
          end;
        end
        else begin
          Lines.COGSTotalLineAmount:= Lines.QtyShipped * Lines.LineCost;
          Lines.COGSTotalLineAmountInc:= Lines.QtyShipped * Lines.LineCostInc;
        end;
      end;
      Lines.Dataset.Next;
    end;
  finally
    Lines.Dataset.EnableControls;
    QtyList.Free;
  end;
end;

function TPurchaseOrder.CopyPOToPO: Integer;
begin
    Result := 0;
    CopyingToPO:= True;
    try
       Progressbarmsg:= 'Copying Purchase Order';
       SendEvent(BusobjEvent_ToDo,BusobjEvent_ProgressbarProgress);
       FieldsnotToclone:=
                QuotedStr('IsPaid') + ',' +
                QuotedStr('TotalBalance') + ',' +
                QuotedStr('TotalPaid') + ',' +
                QuotedStr('ForeignPaidAmount') + ',' +
                QuotedStr('ForeignBalanceAmount') + ',' +
                QuotedStr('BOID') + ',' +
                QuotedStr('Originalno') + ',' +
                QuotedStr('baseno') + ',' +
                QuotedStr('SupplierInvoiceNumber') + ',' +
                QuotedStr('SupplierInvoiceDate') + ',' +
                QuotedStr('DueDate');
        if Self.CloneBusObj('Orderdate',DateOf(now),False, 'PurchaseOrderId') <> nil then begin
            Progressbarmsg:= 'Saving Purchase Order';SendEvent(BusobjEvent_ToDo,BusobjEvent_ProgressbarProgress);
            TPurchaseOrder(ObjInstanceToClone).Deleted := False;
            { todays date }
            TPurchaseOrder(ObjInstanceToClone).OrderDate := Date;
            { not approved }
            TPurchaseOrder(ObjInstanceToClone).Approved := false;
            TPurchaseOrder(ObjInstanceToClone).PostDb;
            SendEvent(BusobjEvent_ToDo,BusobjEvent_ProgressbarProgress);
            TPurchaseOrder(ObjInstanceToClone).Save;
            SendEvent(BusobjEvent_ToDo,BusobjEvent_ProgressbarProgress);
            Result := TPurchaseOrder(ObjInstanceToClone).ID;
            UserLock.UnlockAllCurrentInstance;
            TPurchaseOrder(ObjInstanceToClone).UserLock.UnlockAllCurrentInstance;
        end;
    finally
        CopyingToPO := False;
    end;
end;

function TPurchaseOrder.CopyPOToRA: integer;
begin
    Result := 0;
    CopyingToRA:= True;
    try
       Progressbarmsg:= 'Copying Purchase Order';
       SendEvent(BusobjEvent_ToDo,BusobjEvent_ProgressbarProgress);
       FieldsnotToclone:=
                QuotedStr('IsPaid') + ',' +
                QuotedStr('TotalBalance') + ',' +
                QuotedStr('TotalPaid') + ',' +
                QuotedStr('ForeignPaidAmount') + ',' +
                QuotedStr('ForeignBalanceAmount') + ',' +
                QuotedStr('BOID') + ',' +
                QuotedStr('Originalno') + ',' +
                QuotedStr('baseno') + ',' +
                QuotedStr('SupplierInvoiceNumber') + ',' +
                QuotedStr('SupplierInvoiceDate') + ',' +
                QuotedStr('IsPO') + ',' +
                QuotedStr('IsRA') + ',' +
                QuotedStr('DueDate');

        if Self.CloneBusObj('Orderdate',DateOf(now),False, 'PurchaseOrderId') <> nil then begin
            Progressbarmsg:= 'Saving Return Authority';SendEvent(BusobjEvent_ToDo,BusobjEvent_ProgressbarProgress);
            TReturnAuthority(ObjInstanceToClone).Deleted := False;
            { todays date }
            TReturnAuthority(ObjInstanceToClone).OrderDate := Date;
            { not approved }
            TReturnAuthority(ObjInstanceToClone).Approved := false;
            TReturnAuthority(ObjInstanceToClone).Comments := 'Created from Purchase Order '+ IntToStr(ID);
            TReturnAuthority(ObjInstanceToClone).PostDb;
            SendEvent(BusobjEvent_ToDo,BusobjEvent_ProgressbarProgress);
            TReturnAuthority(ObjInstanceToClone).Save;
            SendEvent(BusobjEvent_ToDo,BusobjEvent_ProgressbarProgress);
            Result := TReturnAuthority(ObjInstanceToClone).ID;
            UserLock.UnlockAllCurrentInstance;//UnlockAllCurrentUser //Binny -UnlockAllCurrentUser removes locking from other forms are well;
        end;
    finally
        CopyingToRA := False;
    end;
end;

function TPurchaseOrder.UpdateAccounts: Boolean;
begin

    Result := inherited UpdateAccounts;
    {  TODO -cIANOS:Check 2clix -oBinny :
        UninvoicedPO.balance is not getting updated
        InventoryAsset.balance is updated only when the PO is invoiced -
        if PO created as uninvoiced and invoice at a later stage doesn't
        update the balance at all, -> cleanamount cancelling the updation
        IANOS will check 2clix for the actual process}
end;

function TPurchaseOrder.DoAfterInsert(Sender: TDatasetBusobj): Boolean;
begin
    Result := inherited DoAfterInsert(Sender);
    if not result then Exit;
    IsPO                := True;
    IsRA                := False;
    IsPOCredit          := False;
    InitAPAccount;
end;

function TPurchaseOrder.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterOpen(Sender);
end;

Function TPurchaseOrder.DoAfterPost(Sender :TDatasetBusobj) :Boolean ;
begin
    Result := inherited DoAfterPost(Sender);
    if not result then Exit;
    if DocNumber = '' then begin
        DocNumber := IntToStr(ID);
        PostDB;
    end;
end;
constructor TReturnAuthorityLine.Create(AOwner: TComponent);
begin
  inherited;
end;

function TReturnAuthorityLine.GetIsPQAItem: Boolean;
begin
//    REsult := False;
  REsult:=inherited GetIsPQAItem;
end;


function TReturnAuthorityLine.GetLineDesc: String;
begin
  REsult := inherited GetLineDesc;
  Result := result + NL+'Product :' + Productname;
end;


class function TPurchaseOrder.GetKeyStringField: string;
begin
  Result := 'GlobalRef'
end;

class function TPurchaseOrder.GetBusObjectTablename: string;
begin
  result := 'tblPurchaseOrders';
end;

function TPurchaseOrder.GetCreatedFromSO: integer;
begin
  Result := GetIntegerField('CreatedFromSO');
end;

class function TPurchaseOrderLine.GetBusObjectTablename: string;
begin
  REsult :='tblpurchaselines';
end;

function TReturnAuthorityLine.DoBeforePost(Sender: TDatasetBusobj): Boolean;
begin
  result := inherited DoBeforePost(Sender);
  if not result then exit;
  if {(not DatasetPosting) and} (ProductId = 0) and (Productname = '') then
    if not deleted then begin
      Deleted := true;
    end;
end;

function TReturnAuthorityLine.GetOrderQty: Double;
begin
    REsult := -(QtyShipped);
end;

function TReturnAuthorityLine.GetUOMOrderQty: Double;
begin
   REsult := RAQty;
end;

procedure TReturnAuthorityLine.SetOrderQty(const Value: Double);
begin
  QtyShipped := -(Value);
end;

procedure TReturnAuthorityLine.SetUOMOrderQty(const Value: Double);
begin
  RAQty := Value;
end;

function TReturnAuthorityLine.ValidateData: boolean;
begin
  result := inherited validateData;
  if not result then exit;
  FormulaQtyShippedValue := FormulaQtySoldValue;
  FormulaQtyShippedValue1:= FormulaQtySoldValue1;
  FormulaQtyShippedValue2 := FormulaQtySoldValue2;
  FormulaQtyShippedValue3 := FormulaQtySoldValue3;
  FormulaQtyShippedValue4 := FormulaQtySoldValue4;
  FormulaQtyShippedValue5 := FormulaQtySoldValue5;
end;

function TPurchaseOrder.UpdateLinkedSale: boolean;

  function checklinkedSale(const aLineId: integer):Boolean;
  var
    SaleType: TSaleType;
    aSaleId: integer;
    str:STring;
  begin
      Result :=False;
      if not IsLinkedtoSales then exit;
      SaleType:= TSalesBase.SaleTypeAndId(salesGlobalref, aSaleId, self.Connection.connection);
      if SaleType = stSalesOrder   then Sale:= TSalesOrder.Create(nil)
      else if SaleType = stInvoice then Sale:= TInvoice.Create(nil)
      else exit;
      if AppEnv.AccessLevels.GetEmployeeAccessLevel(Sale.classname) <> 1 then begin
          ResultStatus.addItem(False, rssWarning  ,0,  'You don''t have enough access rights to update the Shipped Quantity on the ' +Sale.XMLNodeName +'#' + IntToStr(aSaleId) +' for the received Quantity.');
          exit;
      end;
      Sale.Connection:= self.Connection;
      Sale.Load(aSaleId);
      if (TSales(Sale).IsPaid) or (TSales(Sale).Converted) then begin
          if TSales(Sale).Converted then str := 'Converted' else if TSales(Sale).IsPaid then str:= 'Paid' ;
          ResultStatus.addItem(False, rssWarning  ,0,  'This Purchase Order is linked to ' +Sale.XMLNodeName +'#' + IntToStr(Sale.ID) +'.' +chr(13)+'Unable to update the ' +Sale.XMLNodeName +
                ' as it is already ' +str+'.');
          exit;
      end;
      if not UserLock.Lock(Sale.BusObjectTableName, Sale.ID, lockGroupName) then begin
          ResultStatus.AddItem(False, rssWarning, 0 , StringReplace(UserLock.LockMessage, 'Unable to update data.' ,  'Unable to update the linked Sales record#' + IntToStr(Sale.Id) , [rfIgnoreCase]));
          Result := False;
          Exit;
      end;
      if Assigned(confirmFromGUI) then begin
          str:= 'Do You Wish to Ship the Quantity Received From This Purchase Order ' + NL +
                'for ' +Sale.XMLNodeName +' # ' +IntToStr(Sale.ID) +' of Customer ' + Quotedstr(TSales(Sale).CustomerName) +'?';
          if fConfirmFromGUI(str, [ mbNo, mbYes]) = mrNo then exit;
      end else begin
          result := False;
          Exit;
      end;
      Result := true;
  end;
begin
  result:= true;
  if TotalQtyShipped = 0 then Exit;
  if NonBOMtotalQtyShipped =0 then exit;
  Sale:= nil;
    try
      if not checklinkedSale(Lines.SaleLineID) then Exit;
      Lines.Iteraterecords(UpdateLinkedSaleCallback);
      if not Sale.Save then result:= false;
      if Sale is TSalesOrder then  AddEvent(BusObjEvent_OpenSOform, IntToStr(Sale.ID) , Self.ID)
      else AddEvent(BusObjEvent_OpenInvForm, IntToStr(Sale.ID) , Self.ID);
      Result := True;
    finally
      Freeandnil(Sale);
    end;
end;

procedure TPurchaseOrder.UpdateLinkedSaleCallback(const Sender: TBusObj;  var Abort: Boolean);
var
  qtyReceived: double;
  qry: TERPQuery;

  procedure UpdateSale(const aLineId: integer; aQty: double);
  begin
      if (not (Sale.Lines.Dataset.Locate('SaleLineId',aLineId,[]))) and
        (not (Sale.Lines.Dataset.Locate('baselineno',aLineId,[]))) then begin
        qry:= TERPQuery.Create(nil);
        try
          qry.Connection:= self.Connection.Connection;

          qry.SQL.Add('select InvLine.SaleLineID');
          qry.SQL.Add('from tblSalesLines InvLine, tblSales Inv, tblSalesLines SOLine, tblSales SO');
          qry.SQL.Add('where InvLine.SaleID = Inv.SaleID');
          qry.SQL.Add('and Inv.SalesOrderGlobalRef = ' + QuotedStr(salesGlobalref));
          qry.SQL.Add('and SOLine.SaleID = SO.SaleID');
          qry.SQL.Add('and SO.GlobalRef = ' + QuotedStr(salesGlobalref));
          qry.SQL.Add('and SOLine.SeqNo = InvLine.SEqNo and SOLine.ProductID = InvLine.ProductID');
          qry.SQL.Add('order by InvLine.SaleID desc');
          qry.Open;
          if (not (Sale.Lines.Dataset.Locate('SaleLineId',qry.FieldByName('SaleLineID').AsInteger,[]))) and
             (not (Sale.Lines.Dataset.Locate('baselineno',qry.FieldByName('SaleLineID').AsInteger,[]))) then
            exit;

        finally
          qry.Free;
        end;
      end;

    if aQty > 0 then begin
      if Sale.Lines.QtyBackOrder < aQty then
        Sale.Lines.QtyShipped:= Sale.Lines.QtySold
      else
        Sale.Lines.QtyShipped:= Sale.Lines.QtyShipped + aQty;
    end else begin
      if (Sale.Lines.QtyShipped + aQty) < 0 then
        Sale.Lines.QtyShipped:= 0
      else
        Sale.Lines.QtyShipped:= Sale.Lines.QtyShipped + aQty;
    end;
    Sale.PostDB;
  end;
begin
  if TPurchaseOrderLine(Sender).ProcTreeid <> 0 then exit;
  qtyReceived:= TPurchaseOrderLine(Sender).QtyShipped - TPurchaseOrderLine(Sender).CleanQty;
  if qtyReceived <> 0 then UpdateSale(TPurchaseOrderLine(Sender).SaleLineID, qtyReceived);
end;

function TPurchaseOrder.IsLinkedtoSales: Boolean;
begin
  result := (salesGlobalref <> '');
  if result then begin
    LinedLinkedtosalesfound := False;
    Lines.Iteraterecords(checklinesLinkedtoSales);
    result := LinedLinkedtosalesfound;
  end;
  if not result then begin
      salesGlobalref := '';
      PostDB;
  end;
end;
procedure TPurchaseOrder.checklinesLinkedtoSales(const Sender: TBusObj;var Abort: Boolean);
begin
  if not(Sender is TPurchaseOrderLine) then exit;
  if TPurchaseOrderLine(Sender).SaleLineID <> 0 then  begin
      LinedLinkedtosalesfound := true;
      abort := TRue;
  end;
end;

class function TPurchaseOrder.LockLinkedPOs(const SaleLineID: Integer;const UserLock :TUserLock;const LockGroupName,ProductName :STring; var Msg:STring): Boolean;
var
  strSQL:String;
begin
  Msg := '';
  Result := TRue;
  strSQL:= 'SELECT  ' +  GetIDField + '     FROM ' + TPurchaseOrderLine.GetBusObjectTablename+
            '  WHERE SaleLineID = ' + IntToStr(SaleLineID);
  With TempMyQuery do try
    SQL.add(strSQL);
    Open;
    if recordcount = 0 then exit;
    First;
    While Eof = False do begin
      if UserLock.Lock(GetBusObjectTablename , Fieldbyname(GetIDField).asInteger, LockGroupName)= False then begin
          MSg := ReplaceStr(userlock.LockMessage, 'Unable to update data' ,
                        'Deleted Product ' + ProductName +' is Linked to PurchaseOrder#' +IntToStr(Fieldbyname(GetIDField).asInteger)+'.' ) +chr(13)+chr(13)+
                        'Unable to delete the link.';
          Result := False;
          Exit;
      end;
      Next;
    end;
    //Result := Fieldbyname('PurchaseOrderID').asInteger;
  finally
      if Active then close;
      Free;
  end;
end;

class Function TPurchaseOrder.DeleteLinkToPO(const SaleLineID: Integer):String;
var
  strSQL:String;
begin
  Result := '';
  strSQL:= 'SELECT  ' + TPurchaseOrderLine.GetIDField + '     FROM ' + TPurchaseOrderLine.GetBusObjectTablename+
            '  WHERE SaleLineID = ' + IntToStr(SaleLineID);
  With TempMyQuery do try
    SQL.add(strSQL);
    Open;
    if recordcount = 0 then exit;
    First;
    strSQL:='';
    While Eof = False do begin
      if strSQL<> '' then strSQL:= strSQL+',';
      strSQL := strSQL + IntToStr(Fieldbyname(TPurchaseOrderLine.GetIDField).asInteger);
      next;
    end;
    IF strSQL<> '' THEN
      result := 'update ' + TPurchaseOrderLine.GetBusObjectTablename +
                ' set  SaleLineID = 0  , proctreeID =0,  Product_Description = concat(Product_Description ," :Sales line deleted")' +
                ' where '  + TPurchaseOrderLine.GetIDField +' in (' + strSQL+')';
  finally
      if Active then close;
      Free;
  end;
end;
Procedure TPurchaseOrder.LoadFromXMLNode(const Node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node, 'SalesGlobalref');
  SetPropertyFromNode(Node, 'Equipmentname');
  SetPropertyFromNode(Node, 'EquipmentId');
  SetPropertyFromNode(Node, 'SaleLineRef');
  SetPropertyFromNode(Node, 'TotalEstimatedAmountInc');
  SetPropertyFromNode(Node, 'LinkPORef');
  SetPropertyFromNode(Node, 'SmartOrderApprovedBy');
end;

procedure TPurchaseOrder.SaveToXMLNode(const Node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SalesGlobalref',SalesGlobalref);
  AddXMLNode(node,'Equipmentname',Equipmentname);
  AddXMLNode(node,'EquipmentId',EquipmentId);
  AddXMLNode(node,'SaleLineRef',SaleLineRef);
  AddXMLNode(node,'TotalEstimatedAmountInc',TotalEstimatedAmountInc);
  AddXMLNode(node,'LinkPORef',LinkPORef);
  AddXMLNode(node,'SmartOrderApprovedBy',SmartOrderApprovedBy);
end;


procedure TPurchaseOrder.NewBOInit(BackOrder: TTransBase);
begin
      TPurchaseOrder(BackOrder).SupplierInvoiceNumber := '';
      TPurchaseOrder(BackOrder).Dataset.fieldByname('InvoiceDate').AsVariant := null; // this shouldn;t be 0 as the 0 is 31st dec of 1989
      TPurchaseOrder(BackOrder).SeqNo := Self.SeqNo +1 ;
end;


function TPurchaseOrder.AmountToApprove: Double;
begin
  REsult:= TotalEstimatedAmountInc;
end;

procedure TPurchaseOrder.BOLinesInit(BackOrder: TTransBase);
begin
  inherited;
  TPurchaseOrder(BackOrder).Lines.NullWhenDateIs0 := True;
  TPurchaseOrder(BackOrder).Lines.ReceivedDate := 0;
  TPurchaseOrder(BackOrder).Lines.LineClassName := Lines.LineClassName;
  if TPurchaseOrder(BackOrder).Lines.BaseLineno = 0 then
      TPurchaseOrder(BackOrder).Lines.BaseLineno := Lines.Id;
  if TPurchaseOrder(BackOrder).Lines.UOMQtySold = 0 then TPurchaseOrder(BackOrder).Lines.Deleted := True; // this is when a PO of a BO is edited and ship the complete qty, the BO lines should be deleted
  TPurchaseOrder(BackOrder).Lines.LineCostInc := Lines.LineCostInc;
  TPurchaseOrder(BackOrder).Lines.PostDB;
  Lines.Invoiced := True;
  if (lines.qtyshipped=0)and (Lines.Shipment.count > 0) then begin
    if TPurchaseOrder(BackOrder).Lines.Shipment.count > 0 then begin
      TPurchaseOrder(BackOrder).PostList.AddQuery('Delete from tblShipContainerDetails where ShipContainerDetailID = ' +IntToStr(Lines.Shipment.ID)+';');
    end else begin
      TPurchaseOrder(BackOrder).PostList.AddQuery('update tblShipContainerDetails Set PurchaseLineID   = ' + IntToStr(TPurchaseOrder(BackOrder).Lines.ID)+' where ShipContainerDetailID = ' +IntToStr(Lines.Shipment.ID)+';');
    end;
  end;
  Lines.PostDB;
end;

procedure TPurchaseOrder.ProcessDeletedLine;
begin
  inherited;
  lines.Shipment.Delete;
end;

function TPurchaseOrderLine.getPurchaseLinePackWeight: TPurchaseLinePackWeightLines;
begin
  Result := TPurchaseLinePackWeightLines(Getcontainercomponent(TPurchaseLinePackWeightLines, 'PurchaseLineID = ' + IntToStr(ID), True, True));
end;
function TPurchaseOrderLine.getPurchaseLinePackWeightSum: TPurchaseLinePackWeightLinesSum;
begin
  TPurchaseOrder(Owner).PurchaseLinePackWeightSum.locate('PurchaseLineId' , ID , []);
  REsult :=TPurchaseOrder(Owner).PurchaseLinePackWeightSum;
end;

function TPurchaseOrderLine.getShipment: TShipContainerDetails;
begin
  if not Assigned(fShipment) then begin
    fShipment := TShipContainerDetails.CReate(Self);
    fShipment.connection := Self.Connection;
    fShipment.silentMode := Self.SilentMode;
    fShipment.IgnoreAccesslevel:= True;
  end;
    //if (fShipment.Dataset.Recordcount = 0) or (fShipment.SaleslineId <> Self.ID) then
    if (fShipment.SQLSelect <> 'PurchaseLineID = ' + IntToStr(Self.ID)) or (fShipment.Dataset.Active = False) then
        fShipment.LoadSelect('PurchaseLineID = ' + IntToStr(Self.ID));
  result:= fShipment;
end;

function TPurchaseOrderLine.getSmalletstETADate: TDatetime;
begin
  fdSmalletstETADate :=0;
  Iteraterecords(SmalletstETADateCallback);
  REsult := fdSmalletstETADate;
end;
Procedure TPurchaseOrderLine.SmalletstETADateCallback(const Sender: TBusObj; var Abort: boolean);
begin
  if not(Sender is TPurchaseOrderLine) then Exit;
  if TPurchaseOrderLine(Sender).ETADate <>0 then
    if (fdSmalletstETADate > TPurchaseOrderLine(Sender).ETADate) or (fdSmalletstETADate =0) then
      fdSmalletstETADate := TPurchaseOrderLine(Sender).ETADate;
end;

function TPurchaseOrder.DeleteFlaggedLines: boolean;
begin
  result := inherited DeleteFlaggedLines;
end;

procedure TPurchaseOrder.ProcessLine;
begin
  inherited;
  { don't delete the shipment, it has already been updated to poiunt to new backorder line }
//  if Lines.QtyShipped = 0 then
//    if BackOrderGlobalRef <> '' then
//      if Lines.Shipment.count > 0 then begin
//        Lines.Shipment.delete;
//      end;
end;

procedure TPurchaseOrderLine.OnDataIdChange(
  const ChangeType: TBusObjDataChangeType);
begin
  inherited;
   Freeandnil(fShipment);
end;

procedure TPurchaseOrder.SetShiptofromLines(const Sender: TBusObj;var Abort: Boolean);
begin
  if not (Sender is TPurchaseOrderLine) then exit;
  if TPurchaseOrderLine(SendeR).CustomerJobID<> 0 then begin
      ShipTo := TPurchaseOrderLine(SendeR).CustomerJobobj.ShipToAddress;
      Abort := True;
  end;
end;

procedure TPurchaseOrder.SetSOApprovedBy(const Value: integer);
begin
  SetIntegerField('SOApprovedBy', Value);
end;

(*function TPurchaseOrder.getPOLinesofGroup: TPurchaseOrderLine;
begin
  if assigned(fPOLinesofGroup) then else begin
    fPOLinesofGroup := TPurchaseOrderLine.create(nil);
    fPOLinesofGroup.connection := self.connection;
    fPOLinesofGroup.LoadSelect('PurchaseOrderID in ' +
                           ' (select purchaseOrderId from tblpurchaseorders ' +
                           ' where Originalno = ' +QuotedStr(OriginalDocNumber) +
                           ' and Globalref <> ' +QuotedStr(Globalref) +')');
  end;
  Result := fPOLinesofGroup;

end;*)

procedure TReturnAuthority.AssignETADate(const Sender: TBusObj;
  var Abort: boolean);
begin
  inherited;
  if not(Sender is TPurchaseOrderLine) then exit;
  if TPurchaseOrderLine(Sender).ETADate = 0 then begin
    if DueDate>= date then TPurchaseOrderLine(Sender).ETADate := duedate else TPurchaseOrderLine(Sender).ETADate := Date;
    PostDb;
  end;
end;


function TReturnAuthority.ConvertToPO: Integer;
begin
  REsult := 0;
  Self.ConvertingToPO:= True;
  try
  Connection.BeginTransaction;
  try
    if CloneBusObj('OrderDate',now,False, 'PurchaseOrderID') <> nil then begin
      TPurchaseOrder(ObjInstanceToClone).Comments := 'Negative Purchase Order Created for Return Authority #' +
        IntToStr(ID) + ' (Supplier RA No: ' +  self.SupplierInvoiceNumber + ')';
      TPurchaseOrder(ObjInstanceToClone).SupplierInvoiceNumber:= '';
      TPurchaseOrder(ObjInstanceToClone).RARef := Self.Globalref;
      TPurchaseOrder(ObjInstanceToClone).IsRA:= False;
      TPurchaseOrder(ObjInstanceToClone).IsPO:= True;
      if DueDate >= date then TPurchaseOrder(ObjInstanceToClone).ETADate :=DueDate else TPurchaseOrder(ObjInstanceToClone).ETADate :=Date;
      TPurchaseOrder(ObjInstanceToClone).Lines.Iteraterecords(AssignETADate);
      TPurchaseOrder(ObjInstanceToClone).PostDB;
      if TPurchaseOrder(ObjInstanceToClone).Save then begin
        Result:= ObjInstanceToClone.ID;
        Connection.CommitTransaction;
      end else begin
        connection.RollbackTransaction;
        REsult := 0;
      end;
    end;
  except
      on E:Exception do begin
          connection.RollbackTransaction;
      end;
  end;
  finally
    ConvertingToPO:= False;
  end;
end;
procedure TReturnAuthority.CloneLines(const Sender: TBusObj;  var Abort: boolean);
begin
  inherited CloneLines(Sender , Abort);
  if abort then exit;
  if not(Sender is TReturnAuthorityLine) then exit;
  TReturnAuthorityLine(Sender).RAstatus := 'Returned';
  TReturnAuthorityLine(Sender).Postdb;
  if TReturnAuthorityLine(Sender).FormulaQtySoldValue <> 0 then  begin
    TPurchaseOrderLine(TReturnAuthorityLine(Sender).ObjInstanceToClone).FormulaQtySoldValue := 0 - TReturnAuthorityLine(Sender).FormulaQtySoldValue;
    TPurchaseOrderLine(TReturnAuthorityLine(Sender).ObjInstanceToClone).FormulaQtyShippedValue := 0 - TReturnAuthorityLine(Sender).FormulaQtySoldValue;
  end;

  TPurchaseOrderLine(TReturnAuthorityLine(Sender).ObjInstanceToClone).RALineREf :=TReturnAuthorityLine(Sender).Globalref;
  TPurchaseOrderLine(TReturnAuthorityLine(Sender).ObjInstanceToClone).PostDb;
end;

constructor TReturnAuthority.Create(AOwner: TComponent);
begin
  inherited;
  fbConvertingToPO:= False;
  fSQL := 'Select * from tblPurchaseOrders where IsRA = "T"';
end;

procedure TReturnAuthority.CreateInstance;
begin
  inherited;
  if fbConvertingToPO then begin
      ObjInstanceToClone := TPurchaseOrder.Create(nil);
      ObjInstanceToClone.connection := self.connection;
      ObjInstanceToClone.Load(0); // this is to avoid loading the whole table
      if Assigned(DoProductallocation) then
          TPurchaseOrder(ObjInstanceToClone).DoProductallocation := DoProductallocation;
  end;
end;

function TReturnAuthorityLine.getConvertingToPO: Boolean;
begin
  result := False;
  if Assigned(Self.Owner) then
    if self.Owner is TReturnAuthority then
      result := TReturnAuthority(Self.Owner).ConvertingToPO;
end;

procedure TReturnAuthorityLine.CreateInstance;
begin
  inherited;
    if Owner is TReturnAuthority then
        if Assigned(TReturnAuthority(Owner).ObjInstanceToClone) then
          if TReturnAuthority(Owner).ObjInstanceToClone is TPurchaseOrder then
            ObjInstanceToClone :=TPurchaseOrder(TReturnAuthority(Owner).ObjInstanceToClone).Lines
          else if TReturnAuthority(Owner).ObjInstanceToClone is TReturnAuthority then
            ObjInstanceToClone := TReturnAuthority(TReturnAuthority(Owner).ObjInstanceToClone).Lines;
end;

procedure TReturnAuthority.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  With getNewDataset('Select Globalref from tblpurchaseorders where RAREf= ' +QuotedStr(globalref)+' Order by OrderDate Desc' , true) do try
    fbCreditRef := fieldByname('Globalref').asString;
  finally
      if active then close;
      free;
  end;

end;

procedure TReturnAuthority.PopulateMessageSubstituteList(SL: TStringList);
var
  s: string;
begin
  inherited;
  s:=
    'Select p.PurchaseOrderId ,  ' +
    ' C.FirstName, ' +
    ' P.ShipTo, ' +
    ' concat(PL.Productname ,"     : " ,  PL.UnitofMeasureShipped , "  of  " ,   concat(PL.UnitofMeasurePOLines , " (" , PL.UnitofMeasureMultiplier , ")" )) details ' +
    ' from tblpurchaseorders p ' +
    ' inner join tblpurchaselines PL on P.PurchaseOrderId = PL.PurchaseOrderId   ' +
    ' inner join tblclients c on c.clientId = p.clientID' +
    ' where ifnull(PL.UnitofMeasureShipped,0) <> 0 and P.PurchaseOrderId = ' + IntToStr(ID);
  with TERPQuery(GetNewDataset(s)) do try
    SL.Values['#RAID#'] := IntToStr(ID);
    SL.Values['#ReturnAddress#'] := Fieldbyname('ShipTo').asString;
    SL.Values['#Products#'] := Groupconcat('Details' , '' , False, #13#10 );
    SL.Values['#FirstName#'] := Fieldbyname('FirstName').asString;
  finally
    Free;
  end;
end;

procedure TReturnAuthority.New;
begin
  inherited;
    OrderDate           := Now;
    IsPO                := False;
    IsRA                := TRue;
    IsPOCredit          := False;
    PostDB;
    if self.OrderDate = 0 then begin
        OrderDate:= Date;
        CheckOrderDate;
    end;
    Lines; {acces the lines to lead it for the newly added PO record}
end;


function TReturnAuthority.getOrderLines: TOrderLineBase;
begin
    Result := TOrderLineBase(Lines);
end;

{ TProductTotalQtyList }

procedure TProductTotalQtyList.Add(aProduct: TProduct; aQty: double);
var
  newItem: TProductTotalQty;
begin
  newItem:= ItemById[aProduct.Id];
  if not Assigned(newItem) then begin
    newItem:= TProductTotalQty.Create;
    newItem.ProductId:= aProduct.Id;
    newItem.TotalQtyShipped:= 0;
    newItem.TotalQtyToAllocate:= 0;
    newItem.TotalQtyInStock:= aProduct.TotalQtyInStock;
    fList.Add(newItem);
  end;
  newItem.TotalQtyShipped:= newItem.TotalQtyShipped + aQty;
end;

function TProductTotalQtyList.Count: integer;
begin
  result:= fList.Count;
end;

constructor TProductTotalQtyList.Create;
begin
  fList:= TObjectList.Create(true);
end;

destructor TProductTotalQtyList.Destroy;
begin
  fList.Free;
  inherited;
end;

function TProductTotalQtyList.GetItem(index: integer): TProductTotalQty;
begin
  result:= TProductTotalQty(fList[index]);
end;

function TProductTotalQtyList.GetItemById(aProductId: integer): TProductTotalQty;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to fList.Count -1 do begin
    if Item[x].ProductId = aProductId then begin
      result:= Item[x];
      Break;
    end;
  end;
end;

function TPurchaseOrder.getOrderLines: TOrderLineBase;
begin
 Result := TOrderLineBase(Lines);
end;

procedure TPurchaseOrderLine.AfterCloneBusObj;
begin
  inherited;
  if CopyingToPO then begin
    {when PO is copiedinto another PO, it has to be a backorder }
    TPurchaseOrderLine(ObjInstanceToClone).UOMQtyShipped := 0;
    TPurchaseOrderLine(ObjInstanceToClone).QtyShipped := 0;
    TPurchaseOrderLine(ObjInstanceToClone).Qtybackorder := TPurchaseOrderLine(ObjInstanceToClone).Qtysold;
    TPurchaseOrderLine(ObjInstanceToClone).UOMQtybackorder := TPurchaseOrderLine(ObjInstanceToClone).UOMQtysold;
    TPurchaseOrderLine(ObjInstanceToClone).CalcLineTotals;
    //ObjInstanceToClone.DoFieldOnChange(TPurchaseOrderLine(ObjInstanceToClone).Dataset.FindField('UnitofMeasureShipped'));
    TPurchaseOrderLine(ObjInstanceToClone).PostDB;
  end;
end;

procedure TPurchaseOrderLine.ApplyPODiscountPercent;
begin
  if not(Assigned(Owner)) then exit;
  if not(Owner is TPurchaseOrder) then exit;
  DiscountPercent := TPurchaseOrder(Owner).DiscountPercent;
  PostDB;
end;
  {TPurchaseLinePackWeightLines}

constructor TPurchaseLinePackWeightLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'purchaselinepackweightlines';
  fSQL := 'SELECT * FROM tblpurchaselinepackweightlines';
end;
class function TPurchaseLinePackWeightLines.GetBusObjectTablename: string;
begin
  Result:= 'tblpurchaselinepackweightlines';
end;
{Property Functions}
function TPurchaseLinePackWeightLines.getTranslineIDField: String;
begin
  Result := 'PurchaseLineID';
end;

{ TPurchaseLinePackWeightLinesSum }

constructor TPurchaseLinePackWeightLinesSum.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Purchaselinepackweightlines';
  fSQL := 'SELECT POL.PurchaseOrderId, POLPW.PurchaseLineId, sum(POLPW.AttribValue1*Packcount) as AttribValue1 , Sum(POLPW.AttribValue2*Packcount) as AttribValue2 , sum(Packcount) as Packcount' +
          ' FROM tblPurchaselinepackweightlines POLPW ' +
          ' inner join tblPurchaselines POL on POLPW.PurchaselineId = POL.PurchaseLineID ' ;
  fSQLGroup := 'PurchaseLineId';
end;

function TPurchaseLinePackWeightLinesSum.getPurchaseOrderId: Integer;
begin
  REsult := GetIntegerField('PurchaseOrderId');
end;

{ TPurchaseOrderBackOrder }

constructor TPurchaseOrderBackOrder.Create(AOwner: TComponent);
begin
  inherited;
  fbIsReadonly := True;
  fSQL := 'select * from vPurchaseOrderBackOrder';
//    'SELECT distinct PO.* FROM tblPurchaseLines PL ' +
//    ' INNER JOIN tblPurchaseOrders PO ON PO.PurchaseOrderID=PL.PurchaseOrderID' +
//    ' WHERE PO.IsPO = "T" AND PL.Invoiced = "F" AND IfNull(PO.BOID, "") = ""';
end;

class function TPurchaseOrderBackOrder.GetBusObjectTablename: string;
begin
  result := 'vPurchaseOrderBackOrder';
end;

{ TPurchaseOrderNonBackOrder }

constructor TPurchaseOrderNonBackOrder.Create(AOwner: TComponent);
begin
  inherited;
  fSQL :=
    'select distinct PO.*' +
    ' from tblPurchaseOrders as PO' +
    ' inner join tblPurchaseLines POL on POL.PurchaseOrderID = PO.PurchaseOrderID' +
    ' and IfNull(POL.Shipped,0) <> 0' +
    ' where PO.IsPO = "T"';
end;


initialization
  RegisterClass(TPurchaseLinePackWeightLines);
  RegisterClassOnce(TPurchaseOrderline);
  RegisterClassOnce(TPurchaseOrder);
  RegisterClassOnce(TPurchaseOrderBackOrder);
  RegisterClassOnce(TPurchaseOrderNonBackOrder);
  RegisterClassOnce(TPurchaseOrderEx);
  RegisterClassOnce(TReturnAuthorityEx);
end.





