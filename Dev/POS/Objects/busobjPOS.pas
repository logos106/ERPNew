unit busobjPOS;

{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/05/07   1.00.01 BS   Initial Version.
}
interface

uses BusObjBase, DB, Classes, busobjPOSOrders, BusObjTrans, BusobjCash, busobjsalebase, XMLDoc, XMLIntf, SalesConst, BusObjSalesRedeemPoints, busobjvoucher;

type
  TPCCSalesLines = class(TMSBusObj)
  private
    function GetSaleslinesid: Integer;
    function GetTankno: Integer;
    function GetHoseno: Integer;
    function GetDispenserno: Integer;
    function GetVolume: Double;
    function GetActive: Boolean;
    function GetClienttype: Integer;
    procedure SetSaleslinesid(const Value: Integer);
    procedure SetTankno(const Value: Integer);
    procedure SetHoseno(const Value: Integer);
    procedure SetDispenserno(const Value: Integer);
    procedure SetVolume(const Value: Double);
    procedure SetActive(const Value: Boolean);
    procedure SetClienttype(const Value: Integer);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
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
  published
    property Saleslinesid: Integer read GetSaleslinesid write SetSaleslinesid;
    property Tankno: Integer read GetTankno write SetTankno;
    property Hoseno: Integer read GetHoseno write SetHoseno;
    property Dispenserno: Integer read GetDispenserno write SetDispenserno;
    property Volume: Double read GetVolume write SetVolume;
    property Active: Boolean read GetActive write SetActive;
    property Clienttype: Integer read GetClienttype write SetClienttype;
  end;


  TPOSLine = class(TSaleslineBase)
  private
    fiSalesLineID: Integer;
    fPCCSalesLines: TPCCSalesLines;
    function GetPCCSalesLines: TPCCSalesLines;
    function GetIsSummarySale: Boolean;
    function GetSaleid: Integer;
    function getBarTabId: Integer;
    function getBarTabLineId: Integer;

    procedure SetSaleid(const Value: Integer);
    function GetIsvoucher: Boolean;
    function GetIsRedeeming: Boolean;
    function GetVoucherno: string;
    procedure SetIsvoucher(const Value: Boolean);
    procedure SetIsRedeeming(const Value: Boolean);
    procedure SetVoucherno(const Value: string);
    procedure SetBarTabId(const Value: Integer);
    procedure SetBarTabLineID(const Value: Integer);
    function getGUIID: Integer;
    function getLineID: Integer;
    function getGUIRelatedParentID: Integer;
    function getRelatedParentQty: double;
    function getRelatedQtyMultiplier: Double;
    procedure setGUIID(const Value: Integer);
    procedure setLineID(const Value: Integer);
    procedure setGUIRelatedParentID(const Value: Integer);
    procedure setRelatedParentQty(const Value: double);
    procedure setRelatedQtyMultiplier(const Value: Double);
  protected
    function GetSQL: string; override;
    procedure DoFieldOnChange(Sender: TField); override;
    (* function  GetcleanQtyBO          : Double;               Override; *)
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    procedure CreateInstance; override;
    procedure ClonePropertyObjects; override;
    function GetIsPQAItem: Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    property IsSummarySale: Boolean read GetIsSummarySale;
    Property GUIID :Integer read getGUIID write setGUIID;
    Property LineID :Integer read getLineID write setLineID;
    Property GUIRelatedParentID :Integer read getGUIRelatedParentID write setGUIRelatedParentID;
    Property RelatedQtyMultiplier :Double read getRelatedQtyMultiplier write setRelatedQtyMultiplier;
    Property RelatedParentQty :double read getRelatedParentQty write setRelatedParentQty;
  published
    property SalesLineID: Integer read fiSalesLineID write fiSalesLineID;
    property Saleid: Integer read GetSaleid write SetSaleid;
    property PCCSalesLines: TPCCSalesLines read GetPCCSalesLines write fPCCSalesLines;
    property Isvoucher: Boolean read GetIsvoucher write SetIsvoucher;
    property IsRedeeming: Boolean read GetIsRedeeming write SetIsRedeeming;
    property Voucherno: string read GetVoucherno write SetVoucherno;
    property BarTabId: Integer read getBarTabId write SetBarTabId;
    property BarTabLineId: Integer read getBarTabLineId write SetBarTabLineID;
  end;

  TPOSPayments = class(TSalesPayments)
  private
  protected
    function GetSQL: string; override;
    procedure CreateInstance; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TPosRedeemPoints = class(TSalesRedeemPoints)
  private
  protected
    procedure CreateInstance; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TPOS = class(TSalesBase)
  private
    fPOSorder: TPOSOrder;
    fbPOSSuccess: Boolean;
    fiOrderId: Integer;
    fiCustDocketRef: Integer;
    fbHasProcessedItem: Boolean;
    SaleObjSaleID: Integer;
    // fPOSpayments                        : TPOSpayments;
    // fVouchers                           : TVouchers;
    (* fSalesObj                           : TSalesBase; *)
    fbAllLinesValid: Boolean;
    // fAfterSave                          : TGeneralProc;

    function GetPOSLines: TPOSLine;
    function GetCleanIsLayby: Boolean;
    function GetIsSummarySale: Boolean;
    function GetIsposinvoice: Boolean;
    function GetAppointid: Integer;
    // Function GetRepairid                : Integer   ;
    function GetQuoteid: Integer;
    function GeTPOSGroupID: Integer;
    function GetIsendofsplittab: Boolean;
    function GetIsbartab: Boolean;
    function GetIssplittab: Boolean;
    function GetIslaybyreversal: Boolean;
    function GetIsAnyAccountPayments: Boolean;
    function GetIsAnyPaymentsByCheque: Boolean;
    function GetisAnyPaysByVoucher: Boolean;
    function GetIssntracking: Boolean;
    function GetIsanycashout: Boolean;
    function GetOrderid: Integer;
    function GetCustdocketref: string;
    function GetHasprocesseditem: Boolean;
    function GetPOSSeqNo: Integer;
    function GetPOSorder: TPOSOrder;
    function GetSaleType: TSaletype;
    function GetPOSpayments: TPOSPayments;
    function GetVouchers: TVoucher;
    function GetsalesObj: TSalesBase;
    function GetQuoteREf: string;
    // Function GetRepairRef               : string    ;
    function GetSaleGlobalREf: string;
    function GetFieldsNotToclone: string;
    function GetSalesId: Integer;

    // procedure UpdateRepairTbl;
    procedure UpdateQuoteTbl;
    procedure UpdateAppointTbl;
    procedure GetPartProcessInfo(OrderLineId, PartId: Integer; var NextStepID: Integer; var ProcessedItem: Boolean);
    procedure CreateOrderLines(const Sender: TBusObj; var Abort: Boolean);
    procedure SetIsposinvoice(const Value: Boolean);
    procedure SetAppointid(const Value: Integer);
    // Procedure SetRepairid                     (Const Value :Integer   );
    procedure SetQuoteid(const Value: Integer);
    procedure SeTPOSGroupId(const Value: Integer);
    procedure SetIsendofsplittab(const Value: Boolean);
    procedure SetIsbartab(const Value: Boolean);
    procedure SetIssplittab(const Value: Boolean);
    procedure SetIslaybyreversal(const Value: Boolean);
    procedure SetIsAnyAccountPayments(const Value: Boolean);
    procedure SetIsAnyPaymentsByCheque(const Value: Boolean);
    procedure SetisAnyPaysByVoucher(const Value: Boolean);
    procedure SetIssntracking(const Value: Boolean);
    procedure SetIsanycashout(const Value: Boolean);
    procedure SetOrderid(const Value: Integer);
    procedure SetCustdocketref(const Value: string);
    procedure SetHasprocesseditem(const Value: Boolean);
    procedure SetSalesId(const Value: Integer);
    procedure ClonePayments(const Sender: TBusObj; var Abort: Boolean);
    procedure cloneRedeemPoints(const Sender: TBusObj; var Abort: Boolean);
    procedure CommitintoSalestable(const Sender: TBusObj; var Abort: Boolean);
    (*function Lockvoucher: Boolean;*)
    function getPosRedeemPoints: TPosRedeemPoints;
    function GetIsPosQuote: boolean;
    procedure SetIsPosQuote(const Value: boolean);
    function GetIsPOSSalesOrder: boolean;
    procedure setIsPOSSalesOrder(const Value: boolean);

  protected
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function GetSQL: string; override;
    function GetSaleLines: TSaleslineBase; override;
    function GetLines: TTransLineBase; override;
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure ClonePropertyObjects; override;
    procedure CreateInstance; override;
    procedure DoFieldOnChange(Sender: TField); override;
    procedure CloneLines(const Sender: TBusObj; var Abort: Boolean); override;
    Procedure AfterCloneBusObj; Override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CreateOrdersFromPos(OnlyCreateProcessed: Boolean = true): Integer;
    function Save: Boolean; override;
    function ValidateData: Boolean; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    property Lines: TPOSLine read GetPOSLines;
    property POSorder: TPOSOrder read GetPOSorder write fPOSorder;
    property Saletype: TSaletype read GetSaleType;
    property POSpayments: TPOSPayments read GetPOSpayments;
    property PosRedeemPoints: TPosRedeemPoints read getPosRedeemPoints;
    property Vouchers: TVoucher read GetVouchers;
    property salesObj: TSalesBase read GetsalesObj;
    procedure LineValidateCallbackProc(Const Sender: TBusObj; var Abort: boolean);override;
    function AllLinesvoucher:Boolean;
  published
    property Isposinvoice: Boolean read GetIsposinvoice write SetIsposinvoice;
    property IsPosQuote : boolean read GetIsPosQuote write SetIsPosQuote;
    property IsPOSSalesOrder : boolean read GetIsPOSSalesOrder write setIsPOSSalesOrder;
    property Appointid: Integer read GetAppointid write SetAppointid;
    // Property Repairid                           : Integer           Read GetRepairid                Write SetRepairid        ;
    property Quoteid: Integer read GetQuoteid write SetQuoteid;
    property POSGroupID: Integer read GeTPOSGroupID write SeTPOSGroupId;
    property Isendofsplittab: Boolean read GetIsendofsplittab write SetIsendofsplittab;
    property Isbartab: Boolean read GetIsbartab write SetIsbartab;
    property Issplittab: Boolean read GetIssplittab write SetIssplittab;
    property Islaybyreversal: Boolean read GetIslaybyreversal write SetIslaybyreversal;
    property IsAnyAccountPayments: Boolean read GetIsAnyAccountPayments write SetIsAnyAccountPayments;
    property IsAnyPaymentsByCheque: Boolean read GetIsAnyPaymentsByCheque write SetIsAnyPaymentsByCheque;
    property isAnyPaysByVoucher: Boolean read GetisAnyPaysByVoucher write SetisAnyPaysByVoucher;
    property Issntracking: Boolean read GetIssntracking write SetIssntracking;
    property Isanycashout: Boolean read GetIsanycashout write SetIsanycashout;
    property Orderid: Integer read GetOrderid write SetOrderid;
    property SalesId: Integer read GetSalesId write SetSalesId;
    property Custdocketref: string read GetCustdocketref write SetCustdocketref;
    property Hasprocesseditem: Boolean read GetHasprocesseditem write SetHasprocesseditem;
    property CleanIsLayby: Boolean read GetCleanIsLayby;
    property OrderFromPOSSuccess: Boolean read fbPOSSuccess write fbPOSSuccess;
    property OrderFromPOSOrderId: Integer read fiOrderId write fiOrderId;
    property OrderFromPOSCustDocketRef: Integer read fiCustDocketRef write fiCustDocketRef;
    property OrderFromPOSContainsProcessedItems: Boolean read fbHasProcessedItem write fbHasProcessedItem;
    property IsSummarySale: Boolean read GetIsSummarySale;
    property Salesglobalref: string read GetSaleGlobalREf;
    property QuoteRef: string read GetQuoteREf;
    // Property RepairRef                          : String            read GetRepairRef;
    // Property AfterSave                          : TGeneralProc      Read fAfterSave                 Write fAfterSave;
  end;

  TPOSGroup = class(TMSBusObj)
  private
    fPOSObj: TPOS;
    sGroupname: string;
    function GeTPOSGroupname: string;
    function GetuserID: Integer;
    procedure SeTPOSGroupname(const Value: string);
    procedure SetuserID(const Value: Integer);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforeInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function GetPOSObj: TPOS;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    property POSObj: TPOS read GetPOSObj;
    function ExportsubClasses(const node: IXMLNode): Boolean; override;
    procedure New; override;
    // Function    ImportsubClasses(const node: IXMLNode):Boolean; Override;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    procedure DeleteAllTempPOSRecords;

  published
    property Posgroupname: string read GeTPOSGroupname write SeTPOSGroupname;
    property userID: Integer read GetuserID write SetuserID;
  end;

implementation

uses Sysutils, tcDataUtils, tcConst, BusObjCommon, AppEnvironment, BusObjSales,
  CommonLib, busobjPOSSale, BusObjClient, CommonDbLib, BusObjSchemaLib;

{ TPOS }
destructor TPOS.Destroy;
begin
  inherited;
end;

constructor TPOS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblPOS';
end;

function TPOS.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

function TPOS.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
  if DocNumber = '' then DocNumber := IntToStr(ID);
end;

function TPOS.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  inherited DoAfterInsert(Sender);
  IsCashSale := true;
  IsRefund := False;
  IsInvoice := False;
  IsSalesOrder := False;
  IsQuote := False;
  IsPOS := true;
  EOP_POS := False;
  IsLayby := False;
  IsLaybyPayment := False;
  IsLaybyTOS := False;
  Isvoucher := False;
  postdb;
  Result := true;
  Clientid := tcDataUtils.GetCashCustID;
  CustomerName := CLIENT_CASH;
  GLAccountName := UNDEPOSITED_FUNDS;
  GLAccountID := tcDataUtils.GetAccountID(UNDEPOSITED_FUNDS);
  SaleObjSaleID := 0;
  if Assigned(Self.Owner) then
    if Self.Owner is TPOSGroup then POSGroupID := TPOSGroup(Self.Owner).ID;
end;

procedure TPOS.GetPartProcessInfo(OrderLineId, PartId: Integer; var NextStepID: Integer; var ProcessedItem: Boolean);
var
  // qry: TERPQuery;
  ProcStep: Integer;
  strSQL: string;
begin
  NextStepID := 0;
  ProcessedItem := False;
  if OrderLineId < 1 then begin
    strSQL := 'SELECT * FROM tblProcessPart WHERE PartId = ' + IntToStr(PartId) + ' ORDER BY ProcessStepSeq';
    with GetNewdataset(strSQL, False) do
      try
        if RecordCount > 0 then begin
          First;
          NextStepID := FieldByName('ProcessStepId').AsInteger;
          ProcessedItem := true;
        end;
      finally
        if Active then close;
        Free;
      end;
  end else begin
    ProcStep := GetCurrentProcStep(OrderLineId);
    strSQL := 'SELECT * FROM tblProcessPart WHERE PartId = ' + IntToStr(PartId) + ' ORDER BY ProcessStepSeq';
    with GetNewdataset(strSQL, False) do
      try
        if RecordCount > 0 then begin
          ProcessedItem := true;
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

procedure TPOS.CreateOrderLines(const Sender: TBusObj; var Abort: Boolean);
var
  CurProcStep: Integer;
  ProcReq: Boolean;
begin
  if not(Sender is TPOSLine) then Exit;
  GetPartProcessInfo(0, TPOSLine(Sender).ProductID, CurProcStep, ProcReq);
  if ProcReq then OrderFromPOSContainsProcessedItems := true;
  POSorder.Lines.New;
  POSorder.Lines.SalesLineID := TPOSLine(Sender).SalesLineID;
  POSorder.Lines.PartId := TPOSLine(Sender).ProductID;
  POSorder.Lines.Description := TPOSLine(Sender).Product_Description;
  POSorder.Lines.Qty := TPOSLine(Sender).Qtysold;
  POSorder.Lines.RequiresProcessing := ProcReq;
  POSorder.Lines.Status := 1;
  POSorder.Lines.CurrentProcStep := CurProcStep;
  POSorder.Lines.Complete := False;
  POSorder.Lines.postdb;
end;

function TPOS.GetPOSSeqNo: Integer;
begin
  (* with TSeqNumbers.Create(Self) do try
    result:= FastFuncs.StrToInt(GetSequenceNumber(SEQ_ORDER_CUSTDOCKETREF));
    finally
    Free;
    end; *)
  Result := StrToInt(GetSequenceNumber(SEQ_ORDER_CUSTDOCKETREF));
end;

function TPOS.GetVouchers: TVoucher;
begin
  Result := TVoucher(getContainerComponent(TVoucher));
end;

function TPOS.GetPOSpayments: TPOSPayments;
begin
  Result := TPOSPayments(getContainerComponent(TPOSPayments, 'SaleId=' + IntToStr(Self.ID)));
end;

function TPOS.GetIsSummarySale: Boolean;
begin
  Result := False;
  if AppEnv.CompanyPrefs.POSSummarise and not Isendofsplittab and (Isbartab or (not Issplittab and not IsLayby and not Islaybyreversal and not IsLaybyPayment and not Isposinvoice and not Isvoucher and
    not Issntracking and
    { (RepairID = 0) and }
    (Appointid = 0) and (Quoteid = 0) and ((Clientid = 0) or (Clientid = tcDataUtils.GetCashCustID)) and not Isanycashout and not isAnyPaysByVoucher and not IsAnyAccountPayments and
    not IsAnyPaymentsByCheque)) then begin
    Result := true;
  end;
end;

function TPOS.GetSaleType: TSaletype;
begin
  if IsSummarySale then Result := stpos
  else if Isposinvoice then Result := stinvoice
  else if IsPosQuote then Result := stQuote
  else if IsPosSalesOrder then result := stSalesOrder
  else if IsLayby then Result := stPOSLayby
  else if IsLaybyPayment then Result := stPOSLaybyPayment
  else Result := stCashSale;
end;

function TPOS.GetPOSorder: TPOSOrder;
begin
  Result := TPOSOrder(getContainerComponent(TPOSOrder, 'SaleID=' + IntToStr(Self.ID)));
end;

function TPOS.CreateOrdersFromPos(OnlyCreateProcessed: Boolean = true): Integer;
begin
  Result := 0;
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
    else OrderFromPOSCustDocketRef := GetPOSSeqNo;
    POSorder.New;
    POSorder.Saleid := Self.Saleid;
    POSorder.Createtime := now;
    POSorder.Custdocketref := IntToStr(OrderFromPOSCustDocketRef);
    POSorder.postdb;
    OrderFromPOSOrderId := POSorder.ID;
    Lines.IterateREcords(CreateOrderLines);
    OrderFromPOSSuccess := true;
    if OnlyCreateProcessed then
      if OrderFromPOSContainsProcessedItems then begin
        OrderFromPOSCustDocketRef := GetPOSSeqNo;
        POSorder.Custdocketref := IntToStr(OrderFromPOSCustDocketRef);
      end;
    POSorder.Save;
  finally
    OrderFromPOSOrderId := POSorder.ID;
    Result := POSorder.ID;
  end;
end;
function TPOS.GetsalesObj: TSalesBase;
begin
  Result := nil;
  case Saletype of
    stpos                   : Result := TPOSSale(getContainerComponent(TPOSSale, 'SaleId = ' + IntToStr(SaleObjSaleID)));
    stinvoice               : Result := TInvoice(getContainerComponent(TInvoice, 'SaleId = ' + IntToStr(SaleObjSaleID)));
    stQuote                 : Result := TQuote(getContainerComponent(TQuote,  'SaleId = ' + IntToStr(SaleObjSaleID)));
    stSalesOrder            : Result := TSalesOrder(getContainerComponent(TSalesOrder, 'SaleId = ' + IntToStr(SaleObjSaleID)));
    stCashSale,stPOSCashSale: Result := TPOSCashSale(getContainerComponent(TPOSCashSale, 'SaleId = ' + IntToStr(SaleObjSaleID)));
    stPOSLayby              : Result := TPOSLayby(getContainerComponent(TPOSLayby, 'SaleId = ' + IntToStr(SaleObjSaleID)));
    stPOSLaybyPayment       : Result := TPOSLaybyPayment(getContainerComponent(TPOSLaybyPayment, 'SaleId = ' + IntToStr(SaleObjSaleID)));
  end;

  if Assigned(Result) then begin
    { these flags are Set from the object.new which should not be overwritten }
    Result.LogChangesOnSave := AppEnv.CompanyPrefs.UseAuditTrail;
    Result.FieldsnotToclone := GetFieldsNotToclone;
    if Saletype = stpos then TPOSSale(Result).Isbartab := Isbartab;
    Result.DoProductallocation := DoProductallocation;
  end;

end;

procedure TPOS.LineValidateCallbackProc(const Sender: TBusObj;
  var Abort: boolean);
begin
  inherited;
  Show_Status('Validating Pos Lines : ' + IntToStr(Sender.Dataset.recno) + ' of ' + IntToStr(Sender.Dataset.recordcount));
  if not TPOSLine(Sender).ValidateData then
  begin
    AllLinesValid:= false;
    Abort:= true;
  end;
end;

procedure TPOS.LoadFromXMLNode(const node: IXMLNode);
var
  LinesNode: IXMLNode;
  x: Integer;
begin
  inherited;
  SetBooleanPropertyFromNode(node, 'Isposinvoice');
  SetBooleanPropertyFromNode(node, 'Isendofsplittab');
  SetBooleanPropertyFromNode(node, 'Isbartab');
  SetBooleanPropertyFromNode(node, 'Issplittab');
  SetBooleanPropertyFromNode(node, 'Islaybyreversal');
  SetBooleanPropertyFromNode(node, 'IsAnyAccountPayments');
  SetBooleanPropertyFromNode(node, 'IsAnyPaymentsByCheque');
  SetBooleanPropertyFromNode(node, 'isAnyPaysByVoucher');
  SetBooleanPropertyFromNode(node, 'Issntracking');
  SetBooleanPropertyFromNode(node, 'Isanycashout');
  postdb;
  while Lines.count > 0 do Lines.Delete;
  LinesNode := node.ChildNodes.FindNode('lines');
  if Assigned(LinesNode) then begin
    for x := 0 to LinesNode.ChildNodes.count - 1 do begin
      Lines.New;
      Lines.LoadFromXMLNode(LinesNode.ChildNodes[x]);
      Lines.postdb;
    end;
  end;
end;

procedure TPOS.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'Isposinvoice', Isposinvoice);
  AddXMLNode(node, 'Isendofsplittab', Isendofsplittab);
  AddXMLNode(node, 'Isbartab', Isbartab);
  AddXMLNode(node, 'Issplittab', Issplittab);
  AddXMLNode(node, 'Islaybyreversal', Islaybyreversal);
  AddXMLNode(node, 'IsAnyAccountPayments', IsAnyAccountPayments);
  AddXMLNode(node, 'IsAnyPaymentsByCheque', IsAnyPaymentsByCheque);
  AddXMLNode(node, 'isAnyPaysByVoucher', isAnyPaysByVoucher);
  AddXMLNode(node, 'Issntracking', Issntracking);
  AddXMLNode(node, 'Isanycashout', Isanycashout);

end;

function TPOS.ValidateData: Boolean;
begin
  Result := False;
  if Isbartab then
    if not AppEnv.CompanyPrefs.POSSummarise then begin
      ResultStatus.AddItem(true, rssWarning, 0, 'You Must have Summarised POS preference ON to use the Bar Tab function');
      Exit;
    end;

  if Lines.count = 0 then begin
    ResultStatus.AddItem(False, rssWarning, 0, 'At least a single product should be selected');
    Exit;
  end;
  if not ValidateLines then begin
    exit;
  end;
  Result := true;
end;

function TPOS.Save: Boolean;
begin
  // should not have inherited
  // inherited
  if EmployeeID <> 0 then Enteredby := tcDataUtils.getemployeeName(EmployeeID)
  else Enteredby := AppEnv.Employee.EmployeeName;
  EnteredAt := TimeToStr(now);

  if IsLayby then begin
    (*if AppEnv.CompanyPrefs.TOSLaybys then begin
      IsCashSale := true;
    end else begin*)
      IsLayby := true;
      IsCashSale := False;
    (*end;*)
    IsLaybyTOS := true; // is layby at Time-Of-Sale (will be displayed in layby list)
    EOP_POS := False;
  end;
  if IsLaybyPayment then IsLaybyPayment := true;
  if Islaybyreversal then begin
    IsLaybyPayment := true;
    EOP_POS := False;
    IsRefund := False;
  end;
  // if IsVoucher then IsVoucher:= True;
  postdb;
  Lines.postdb;
  FieldsnotToclone := GetFieldsNotToclone;
  fbAllLinesValid := true;
  Self.connection.BeginTransaction;
  IteraterecordProgressbarMsg:= 'Saving the Transaction';
  Self.IterateREcords(CommitintoSalestable); // CloneBusObj('' , '', False , '');
  Result := fbAllLinesValid;

  (* CompareXMLDocs(CleanXMLDoc, XMLDoc); *)
end;

procedure TPOS.CommitintoSalestable(const Sender: TBusObj; var Abort: Boolean);
var
  SourceStream: TStream;
  DestinationStream: TStream;
begin
  CloneBusObj('', '', False, '');
  if not(Assigned(ObjInstanceToClone)) then Exit;

  ObjInstanceToClone.postdb;
  //SaleObjSaleID := ObjInstanceToClone.ID;
  salesObj.Lines.postdb;
  SalesId := salesObj.ID;
  postdb;
//  if Saletype = stinvoice then begin
  if SaleType in [stInvoice, stQuote, stSalesOrder] then
  begin
    salesObj.TermsName := tcDataUtils.GetTerms(salesObj.Customer.TermsID);
    if AppEnv.CompanyPrefs.UseShippedDateForTerms then salesObj.SetPaymentTerms(salesObj.ShipDate)
    else salesObj.SetPaymentTerms(salesObj.SaleDate);
  end;
  if not self.Dataset.FieldByName('ClientSignature').IsNull then begin
    SourceStream := self.Dataset.CreateBlobStream(TBlobField(self.Dataset.FieldByName('ClientSignature')), bmRead);
    salesObj.EditDB;
    DestinationStream := salesObj.Dataset.CreateBlobStream(TBlobField(salesObj.Dataset.FieldByName('ClientSignature')), bmWrite);
    salesObj.PostDB;
    try
      DestinationStream.CopyFrom(SourceStream,0);
    finally
      SourceStream.Free;
      DestinationStream.Free;
    end;
  end;

  if Sender.dataset.Recno = 1 then begin
    salesObj.QuoteGlobalRef := QuoteRef;
    // SalesObj.RepairGlobalRef := RepairRef;
    salesObj.postdb;
    // UpdateRepairTbl;
    UpdateAppointTbl;
    UpdateQuoteTbl;
  end;
  if AppEnv.CompanyPrefs.POSCreateOrders then CreateOrdersFromPos;

  With GetNewdataset('select ' +
                      ' concat ("update ' + salesObj.Lines.BusObjectTableName +' Set ' +
                      ' IsrelatedProduct      = ""T"" , ' +
                      ' RelatedProductQty     = " , PL.RelatedQtyMultiplier ,  ", ' +
                      ' RelatedParentLineRef  = """  , SL.globalref , """ , ' +
                      ' RelatedParentProductID= " , SL.ProductID ,  ' +
                      ' " Where  SaleLineID = " , PL.LineID , ";") updatesql ' +
                      ' from tblposlines PL inner join tblPOSLines PLP on PL.GUIRelatedParentID = PLP.GUIID ' +
                      ' inner join ' + salesObj.Lines.BusObjectTableName +' SL on SL.SaleLineID = PLP.LineID' , true ) do try
    if recordcount >0 then begin
      First;
      While Eof = False do begin
        Postlist.AddQuery(fieldbyname('updatesql').AsString );
        Next;
      end;
      Postlist.Execute;
    end;
  finally
    if Active then close;
    Free;
  end;

  if salesObj.Save then begin
    salesObj.RewardPoints;
  end else begin
    fbAllLinesValid := False;
    Abort := true;
  end;

end;

function TPOS.GetFieldsNotToclone: string;
begin
  Result := ExcludeFromclone + ',' + QuotedStr('IsInvoice') + ',' + QuotedStr('IsCashSale') + ',' + QuotedStr('IsRefund') + ',' + QuotedStr('IsSalesOrder') + ',' + QuotedStr('IsPos') + ',' +
    QuotedStr('IsLayby') + ',' + QuotedStr('IsLaybyTOS') + ',' + QuotedStr('IsLaybyPayment') + ',' + QuotedStr('IsQuote');
end;

procedure TPOS.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'SaleDate') then begin
    ShipDate := SaleDate;
    duedate := SaleDate;
  end;
end;

procedure TPOS.CreateInstance;
begin
  ObjInstanceToClone := salesObj;
end;

procedure TPOS.ClonePropertyObjects;
begin
  // inherited shouldn't be here
  // inherited;
  Lines.PostList.clear;
  Lines.IterateREcords(CloneLines);
  if not IsLayby then begin
    POSpayments.IterateREcords(ClonePayments);
  end;
  PosRedeemPoints.IterateREcords(cloneRedeemPoints);
  Lines.PostList.Execute;
  Lines.PostList.clear;
end;

procedure TPOS.AfterCloneBusObj;
begin
  inherited;
  SaleObjSaleID := ObjInstanceToClone.ID;
end;

function TPOS.AllLinesvoucher: Boolean;
begin
  with getNewdataset('select saleLineId from ' +Lines.BusObjectTableName +' where '+idfieldname +'=' +inttostr(Id)+' and (Isvoucher="F" or ifnull(VoucherNo,"")="") ' , true) do try
    result:= recordcount=0;
  finally
    if active then close;
    free;
  end;
end;

procedure TPOS.CloneLines(const Sender: TBusObj; var Abort: Boolean);
var
  ProdAlloc: Boolean;
begin
  Sender.CloneBusObj(ObjInstanceToClone.IDFieldNAme, ObjInstanceToClone.ID, False);
  if Assigned(DoProductallocation) then begin
    ProdAlloc := DoProductallocation(TTransLineBase(Sender.ObjInstanceToClone));
    if (not ProdAlloc) then begin
      fbObjectCopied := False;
      Exit;
    end;
  end;
  if Sender is TPOSLine then
    TPOSLine(Sender).LineID := TPOSLine(Sender).ObjInstanceToClone.ID;
    TPOSLine(Sender).PostDB;
    if TPOSLine(Sender).Isvoucher then
      if (TPOSLine(Sender).Voucherno <> '') then begin
        (*if Lockvoucher then begin*)
        (*if not vouchers.Dataset.Locate('voucherID' , FastFuncs.StrToInt(TPosLine(Sender).voucherNo) , []) then begin*)
          if not Vouchers.dataset.Locate('voucherNo', TPOSLine(Sender).Voucherno, []) then begin
            Vouchers.New;
            Vouchers.Voucherno := TPOSLine(Sender).Voucherno;
            Vouchers.Clientid := salesObj.Clientid;
            Vouchers.Classid := salesObj.SaleClassId;
            Vouchers.Isissued := not(TPOSLine(Sender).IsRedeeming);
            Vouchers.Saleid := salesObj.ID;
            if Vouchers.Isissued then begin
              Vouchers.Value := salesObj.Lines.TotalLineAmountInc;
              Vouchers.Dateissued := Date;
            end else begin
              Vouchers.Issuedby := AppEnv.Employee.EmployeeName;
              Vouchers.Value := -salesObj.Lines.TotalLineAmountInc; // cuz amount is -ve
            end;
            Vouchers.postdb;
          end else begin
             vouchers.Dataset.Locate('voucherNo' , TPosLine(Sender).voucherNo , []);
          end;
          Vouchers.Save;
        end;
      (*end;*)
end;

procedure TPOS.ClonePayments(const Sender: TBusObj; var Abort: Boolean);
begin
  if (salesObj is TPOSSale) or (salesObj is TCashBase) then Sender.CloneBusObj(ObjInstanceToClone.IDFieldNAme, ObjInstanceToClone.ID, False);
  if Sender is TPOSPayments then
    if TPOSPayments(Sender).ref <> '' then begin
      if Vouchers.dataset.Locate('voucherno', TPOSPayments(Sender).ref, []) then begin
        //if Lockvoucher then begin
          Vouchers.Redeemedsaleid := salesObj.ID;
          Vouchers.Dateredeemed := Date;
          Vouchers.Isredeemed := true;
          Vouchers.Save;
        //end else Abort := true;
      end;
    end;
end;

(*function TPOS.Lockvoucher: Boolean;
var
  Msg: string;
begin
  Result := true;
  if not Vouchers.Lock then begin
    Msg := 'Unable to update Layby Sales record as it is being updated by "' + Vouchers.UserLock.LockInfo.UserName + '" with: ' + Vouchers.UserLock.LockInfo.LockingForm;
    ResultStatus.AddItem(true, rssWarning, 0, Msg);
    Result := False;
  end;
end;*)

procedure TPOSLine.ClonePropertyObjects;
begin
  inherited;
end;

constructor TPOSLine.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM tblPOSLines';
end;

procedure TPOSLine.CreateInstance;
begin
  if Owner is TPOS then
    if Assigned(TPOS(Owner).ObjInstanceToClone) then ObjInstanceToClone := TSalesBase(TPOS(Owner).ObjInstanceToClone).Lines
end;

function TPOS.GetCleanIsLayby: Boolean;
begin
  Result := False;
  if Assigned(Owner) and (Owner is TBusObj) then Result := GetXMLNodeBooleanValue(TBusObj(Owner).CleanXMLNOde, 'ISLayby');
end;

procedure TPOS.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  if Assigned(fPOSorder) then begin
    if (not fPOSorder.ExternalDatasetAssigned) then FreeAndNil(fPOSorder)
    else fPOSorder.dataset.close;
  end;
  SaleObjSaleID := 0;
  (* FreeAndNil(fSalesObj); *)
end;

class function TPOS.GetIDField: string;
begin
  Result := 'SaleID';
end;

class function TPOS.GetBusObjectTablename: string;
begin
  Result := 'tblPOS';
end;

function TPOS.GetLines: TTransLineBase;
begin
  Result := GetSaleLines;
end;

function TPOS.GetSaleLines: TSaleslineBase;
begin
  Result := GetPOSLines;
end;

function TPOS.GetPOSLines: TPOSLine;
begin
  Result := TPOSLine(getContainerComponent(TPOSLine, 'SaleID=' + IntToStr(Self.ID)));
end;

// procedure TPOS.UpdateRepairTbl;
// var
// strSQL :STring;
// begin
// if RepairID = 0 then Exit;
// strSQL := 'UPDATE tblRepairs Set SaleID=' + IntToStr(Self.saleID) +', ' +
// ' Done = ''T'', ' +
// ' Converted = ''T'' ' +
// ' WHERE RepairID = ' + IntToStr(RepairID);
// GetNewDataSet(strSQL , TRue);
// end;
procedure TPOS.UpdateQuoteTbl;
var
  strSQL: string;
begin
  if Quoteid = 0 then Exit;
  strSQL := 'UPDATE tblSales Set Converted = ''T'' ' + ' WHERE SaleID =' + IntToStr(Quoteid);
  GetNewdataset(strSQL, true);
end;

procedure TPOS.UpdateAppointTbl;
var
  strSQL: string;
begin
  if Appointid = 0 then Exit;
  if Assigned(salesObj) then begin
    strSQL := 'UPDATE tblAppointments Set Converted = ''T'' , PosID = ' + IntToStr(salesObj.id) + ' WHERE AppointID = ' + IntToStr(Appointid);
    GetNewdataset(strSQL, true);
  end;
end;

function TPOS.GetQuoteREf: string;
begin
  Result := '';
  if Quoteid = 0 then Exit;
  Result := tcDataUtils.GetGlobalref('tblsales', 'SaleID', Quoteid);
end;

// Function TPOS.GetRepairRef               : string;
// begin
// Result := '';
// if Repairid = 0 then exit;
// Result := tcDatautils.GetGlobalref('tblrepairs' , 'RepairID' , Repairid);
// end;
function TPOS.GetSaleGlobalREf: string;begin  Result := '';  if Assigned(salesObj) then Result := salesObj.GlobalRef;end;
procedure TPOS.SetIsposinvoice(const Value: Boolean);
begin
  SetBooleanField('Isposinvoice', Value);
end;

procedure TPOS.SetIsPosQuote(const Value: boolean);
begin
  SetBooleanField('IsQuote', Value);
end;

procedure TPOS.setIsPOSSalesOrder(const Value: boolean);
begin
  SetBooleanField('IsSalesOrder', Value);
end;

procedure TPOS.SetAppointid(const Value: Integer);begin  SetIntegerField('Appointid', Value);end;
procedure TPOS.SetSalesId(const Value: Integer);begin  SetIntegerField('SalesId', Value);end;
procedure TPOS.SetQuoteid(const Value: Integer);begin  SetIntegerField('Quoteid', Value);end;
procedure TPOS.SeTPOSGroupId(const Value: Integer);begin  SetIntegerField('POSGroupID', Value);end;
procedure TPOS.SetIsendofsplittab(const Value: Boolean);begin  SetBooleanField('Isendofsplittab', Value);end;
procedure TPOS.SetIsbartab(const Value: Boolean);begin  SetBooleanField('Isbartab', Value);end;
procedure TPOS.SetIssplittab(const Value: Boolean);begin  SetBooleanField('Issplittab', Value);end;
procedure TPOS.SetisAnyPaysByVoucher(const Value: Boolean);begin  SetBooleanField('isAnyPaysByVoucher', Value);end;
procedure TPOS.SetIslaybyreversal(const Value: Boolean);begin  SetBooleanField('Islaybyreversal', Value);end;
procedure TPOS.SetIsAnyAccountPayments(const Value: Boolean);begin  SetBooleanField('IsAnyAccountPayments', Value);end;
procedure TPOS.SetIsAnyPaymentsByCheque(const Value: Boolean);begin  SetBooleanField('IsAnyPaymentsByCheque', Value);end;
procedure TPOS.SetIssntracking(const Value: Boolean);begin  SetBooleanField('Issntracking', Value);end;
procedure TPOS.SetIsanycashout(const Value: Boolean);begin  SetBooleanField('Isanycashout', Value);end;
procedure TPOS.SetOrderid(const Value: Integer);begin  SetIntegerField('Orderid', Value);end;
procedure TPOS.SetCustdocketref(const Value: string);begin  SetStringField('Custdocketref', Value);end;
procedure TPOS.SetHasprocesseditem(const Value: Boolean);begin  SetBooleanField('Hasprocesseditem', Value);end;
function TPOS.GetIsposinvoice: Boolean;
begin
  Result := GetBooleanField('Isposinvoice');
end;

function TPOS.GetIsPosQuote: boolean;
begin
  Result := GetBooleanField('IsQuote');
end;

function TPOS.GetIsPOSSalesOrder: boolean;
begin
  Result := GetBooleanField('IsSalesOrder');
end;

function TPOS.GetAppointid: Integer;begin  Result := GetIntegerField('Appointid');end;
function TPOS.GetSalesId: Integer;begin  Result := GetIntegerField('SalesId');end;
function TPOS.GetQuoteid: Integer;begin  Result := GetIntegerField('Quoteid');end;
function TPOS.GeTPOSGroupID: Integer;begin  Result := GetIntegerField('POSGroupID');end;
function TPOS.GetIsendofsplittab: Boolean;begin  Result := GetBooleanField('Isendofsplittab');end;
function TPOS.GetIsbartab: Boolean;begin  Result := GetBooleanField('Isbartab');end;
function TPOS.GetIssplittab: Boolean;begin  Result := GetBooleanField('Issplittab');end;
function TPOS.GetIslaybyreversal: Boolean;begin  Result := GetBooleanField('Islaybyreversal');end;
function TPOS.GetIsAnyAccountPayments: Boolean;begin  Result := GetBooleanField('IsAnyAccountPayments');end;
function TPOS.GetIsAnyPaymentsByCheque: Boolean;begin  Result := GetBooleanField('IsAnyPaymentsByCheque');end;
function TPOS.GetisAnyPaysByVoucher: Boolean;begin  Result := GetBooleanField('isAnyPaysByVoucher');end;
function TPOS.GetIssntracking: Boolean;begin  Result := GetBooleanField('Issntracking');end;
function TPOS.GetIsanycashout: Boolean;begin  Result := GetBooleanField('Isanycashout');end;
function TPOS.GetOrderid: Integer;begin  Result := GetIntegerField('Orderid');end;
function TPOS.GetCustdocketref: string;begin  Result := GetStringField('Custdocketref');end;
function TPOS.GetHasprocesseditem: Boolean;begin  Result := GetBooleanField('Hasprocesseditem');end;

{ ========================================================
  TPOSLine
  ======================================================== }
function TPOSLine.GetSaleid: Integer;begin  Result := GetIntegerField('SaleID');end;
function TPOSLine.GetIsvoucher: Boolean;begin  Result := GetBooleanField('IsVoucher');end;
function TPOSLine.GetIsRedeeming: Boolean;begin  Result := GetBooleanField('IsRedeeming');end;
function TPOSLine.GetVoucherno: string;begin  Result := GetStringField('VoucherNo');end;
function TPOSLine.getBarTabId: Integer;begin  Result := GetIntegerField('BarTabId');end;
function TPOSLine.getBarTabLineId: Integer;begin  Result := GetIntegerField('BarTabLineId');end;
function TPOSLine.getRelatedParentQty: double;begin  Result := GetFloatfield('RelatedParentQty');end;
function TPOSLine.getRelatedQtyMultiplier: Double;begin  REsult := GetfloatField('RelatedQtyMultiplier');end;
class function TPOSLine.GetIDField: string;begin  Result := 'SaleLineID';end;
class function TPOSLine.GetBusObjectTablename: string;begin  Result := 'tblPOSLines';end;
function TPOSLine.getGUIID: Integer;begin  REsult :=  GetintegerField('GUIID');end;
function TPOSLine.getLineID: Integer;begin  REsult :=  GetintegerField('LineID');end;
function TPOSLine.getGUIRelatedParentID: Integer;begin  REsult := GetIntegerField('GUIRelatedParentID');end;
procedure TPOSLine.SetBarTabId(const Value: Integer);begin  SetIntegerField('BarTabId', Value);end;
procedure TPOSLine.SetBarTabLineID(const Value: Integer);begin  SetIntegerField('BartabLineId', Value);end;
procedure TPOSLine.SetIsvoucher(const Value: Boolean);begin  SetBooleanField('IsVoucher', Value);end;
procedure TPOSLine.SetIsRedeeming(const Value: Boolean);begin  SetBooleanField('IsRedeeming', Value);end;
procedure TPOSLine.SetVoucherno(const Value: string);begin  SetStringField('VoucherNo', Value);end;
procedure TPOSLine.SetSaleid(const Value: Integer);begin  SetIntegerField('SaleID', Value);end;
procedure TPOSLine.setGUIID(const Value: Integer);begin  Setintegerfield('GUIID' , Value);end;
procedure TPOSLine.setLineID(const Value: Integer);begin  Setintegerfield('LineID' , Value);end;
procedure TPOSLine.setGUIRelatedParentID(const Value: Integer);begin  SetIntegerfield('GUIRelatedParentID' , Value);end;
procedure TPOSLine.setRelatedParentQty(const Value: double);begin  Setfloatfield('RelatedParentQty' , Value);end;
procedure TPOSLine.setRelatedQtyMultiplier(const Value: Double);begin  Setfloatfield('RelatedQtyMultiplier' , Value);end;


function TPOSLine.GetPCCSalesLines: TPCCSalesLines;
begin
  { this object is used only for adding records, so dataset opened for 0 records }
  if not Assigned(fPCCSalesLines) then begin
    fPCCSalesLines := TPCCSalesLines.Create(Self);
    if Assigned(Self.connection) then fPCCSalesLines.connection := Self.connection;
    fPCCSalesLines.Load(ID);
  end;
  Result := fPCCSalesLines;
end;


function TPOSLine.GetIsSummarySale: Boolean;
begin
  Result := False;
  if Assigned(Self.Owner) then
    if Self.Owner is TPOS then Result := TPOS(Self.Owner).IsSummarySale;
end;

(* function TPOSLine.GetcleanQtyBO          : Double;
  begin
  result := 0;
  end; *)
function TPOSLine.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  if Assigned(Self.Owner) then
    if Self.Owner is TPOS then Saleid := TPOS(Self.Owner).ID;
  CreationDate := Date;
  Deleted := False;
end;


procedure TPOSLine.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'ProductID') then begin
    ProductType := Product.ProductType;
    ProductGroup := Product.ProductGroup;
    if Product.AverageCost <> 0 then LineCost := Product.AverageCost
    else LineCost := Product.BuyQty1Cost;
    Product_Description := Product.SalesDescription;
    if Product_Description = '' then Product_Description := ProductName;
    IncomeAccount := Product.IncomeAccount;
    AssetAccount := Product.AssetAccount;
    CogsAccount := Product.CogsAccount;
    LineTaxCode := Product.TaxCodeSales;
  end
  else if Sysutils.SameText(Sender.FieldName, 'ProductName') then begin
    DoFieldOnChange(dataset.findField('ProductID'));
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

function TPOSLine.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

{ ========================================================
  TPOSPayments
  ======================================================== }
function TPOSPayments.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

constructor TPOSPayments.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblpospayments';
end;

function TPOSPayments.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;

  if Assigned(Self.Owner) then
    if Self.Owner is TPOS then Saleid := TPOS(Self.Owner).ID;
end;

procedure TPOSPayments.CreateInstance;
begin
  if Owner is TPOS then
    if Assigned(TPOS(Owner).ObjInstanceToClone) then
      if (TPOS(Owner).ObjInstanceToClone is TPOSSale) then ObjInstanceToClone := TPOSSale(TPOS(Owner).ObjInstanceToClone).SalesPayments
      else if (TPOS(Owner).ObjInstanceToClone is TCashBase) then ObjInstanceToClone := TCashBase(TPOS(Owner).ObjInstanceToClone).SalesPayments;
end;

{ ========================================================
  TPCCSalesLines
  ======================================================== }
constructor TPCCSalesLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblpccsaleslines';
end;

destructor TPCCSalesLines.Destroy;
begin
  inherited;
end;

procedure TPCCSalesLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'Saleslinesid');
  SetPropertyFromNode(node, 'Tankno');
  SetPropertyFromNode(node, 'Hoseno');
  SetPropertyFromNode(node, 'Dispenserno');
  SetPropertyFromNode(node, 'Volume');
  SetPropertyFromNode(node, 'Active');
  SetPropertyFromNode(node, 'Clienttype');
end;

procedure TPCCSalesLines.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'Saleslinesid', Saleslinesid);
  AddXMLNode(node, 'Tankno', Tankno);
  AddXMLNode(node, 'Hoseno', Hoseno);
  AddXMLNode(node, 'Dispenserno', Dispenserno);
  AddXMLNode(node, 'Volume', Volume);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'Clienttype', Clienttype);
end;

function TPCCSalesLines.ValidateData: Boolean;
begin
  ResultStatus.clear;
  Result := true;
end;

function TPCCSalesLines.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TPCCSalesLines.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TPCCSalesLines.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TPCCSalesLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TPCCSalesLines.GetIDField: string;
begin
  Result := 'Pccsaleslinesid'
end;

class function TPCCSalesLines.GetBusObjectTablename: string;
begin
  Result := 'tblpccsaleslines';
end;

function TPCCSalesLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TPCCSalesLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  if Assigned(Self.Owner) then
    if Self.Owner is TPOSLine then Saleslinesid := TPOSLine(Self.Owner).SalesLineID;
end;

{ Property functions }
function TPCCSalesLines.GetSaleslinesid: Integer;
begin
  Result := GetIntegerField('Saleslinesid');
end;

function TPCCSalesLines.GetTankno: Integer;
begin
  Result := GetIntegerField('Tankno');
end;

function TPCCSalesLines.GetHoseno: Integer;
begin
  Result := GetIntegerField('Hoseno');
end;

function TPCCSalesLines.GetDispenserno: Integer;
begin
  Result := GetIntegerField('Dispenserno');
end;

function TPCCSalesLines.GetVolume: Double;
begin
  Result := GetFloatField('Volume');
end;

function TPCCSalesLines.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

function TPCCSalesLines.GetClienttype: Integer;
begin
  Result := GetIntegerField('Clienttype');
end;

procedure TPCCSalesLines.SetSaleslinesid(const Value: Integer);
begin
  SetIntegerField('Saleslinesid', Value);
end;

procedure TPCCSalesLines.SetTankno(const Value: Integer);
begin
  SetIntegerField('Tankno', Value);
end;

procedure TPCCSalesLines.SetHoseno(const Value: Integer);
begin
  SetIntegerField('Hoseno', Value);
end;

procedure TPCCSalesLines.SetDispenserno(const Value: Integer);
begin
  SetIntegerField('Dispenserno', Value);
end;

procedure TPCCSalesLines.SetVolume(const Value: Double);
begin
  SetFloatField('Volume', Value);
end;

procedure TPCCSalesLines.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TPCCSalesLines.SetClienttype(const Value: Integer);
begin
  SetIntegerField('Clienttype', Value);
end;

{ ========================================================
  TPOSGroup
  ======================================================== }
constructor TPOSGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblposgroup';
  sGroupname := GetTemporaryTableNameSuffix;
end;

destructor TPOSGroup.Destroy;
begin
  self.ResultStatus.Clear;
  if Assigned(fPOSObj) then
    if (not fPOSObj.ExternalDatasetAssigned) then FreeAndNil(fPOSObj)
    else fPOSObj.dataset.close;

  connection.CommitTransaction; // this is to commit the deletion of the pos records done in the line above
  DeleteAllTempPOSRecords; { this was getting mysql lock wait timeout so moved after commit }
  inherited;
end;

procedure TPOSGroup.LoadFromXMLNode(const node: IXMLNode);
var
  POSNode: IXMLNode;
  x: Integer;
begin
  inherited;
  SetPropertyFromNode(node, 'Posgroupname');
  postdb;
  while POSObj.count > 0 do POSObj.Delete;
  POSNode := node.ChildNodes.FindNode('Sales');
  if Assigned(POSNode) then begin
    for x := 0 to POSNode.ChildNodes.count - 1 do begin
      POSObj.New;
      POSObj.LoadFromXMLNode(POSNode.ChildNodes[x]);
      POSObj.postdb;
    end;
  end;
end;

procedure TPOSGroup.New;
begin
  try
    inherited;
  Except
      //kill the exception
  end;

end;

procedure TPOSGroup.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'Posgroupname', Posgroupname);
  if not SavingXMLTofile then Exit;
  ExportsubClasses(node);
end;

function TPOSGroup.ExportsubClasses(const node: IXMLNode): Boolean;
begin
  POSObj.XMLPropertyNode := node.AddChild('Sales');
  POSObj.XMLPropertyName := POSObj.XMLNodeName;
  POSObj.IterateREcords(GetPropertyXMLCallback);
  Result := true;
end;

function TPOSGroup.ValidateData: Boolean;
begin
  ResultStatus.clear;
  Result := POSObj.ValidateData
end;

function TPOSGroup.Save: Boolean;
begin
  Result := False;
  postdb;
  if not ValidateData then Exit;
  Result := POSObj.Save;
end;

procedure TPOSGroup.DeleteAllTempPOSRecords;
var
  strSQL: string;
  ctr: Integer;
begin
  { don't use 'delete from' SQL to delete the records that locks the table }
  for ctr := 1 to 5 do begin
    strSQL:='';
         if ctr = 1 then strSQL := ' Select * from tblproducttrans Where transID    in (select  tblPOS.SaleId from tblPOS inner join tblPOSGroup on tblPOSGroup.POSGroupID = tblPOS.POSGroupID where tblPOSGroup.POSGroupname='  + QuotedStr(sGroupname) + ') and transType = ' +Quotedstr('TPOSLine')+';'
    else if ctr = 2 then strSQL := ' select * from tblpospayments  Where SaleId     in (select  tblPOS.SaleId from tblPOS inner join tblPOSGroup on tblPOSGroup.POSGroupID = tblPOS.POSGroupID where tblPOSGroup.POSGroupname='  + QuotedStr(sGroupname) + ');'
    else if ctr = 3 then strSQL := ' select * from tblPOSLines     Where SaleId     in (select  tblPOS.SaleId from tblPOS inner join tblPOSGroup on tblPOSGroup.POSGroupID = tblPOS.POSGroupID where tblPOSGroup.POSGroupname='  + QuotedStr(sGroupname) + ');'
    else if ctr = 4 then strSQL := ' select * from tblPOS 	       Where POSGroupID in (select  tblPOSGroup.POSGroupID from tblPOSGroup where tblPOSGroup.POSGroupname=' + QuotedStr(sGroupname) + ');'
    else if ctr = 5 then strSQL := ' select * from tblposgroup     Where tblPOSGroup.POSGroupname=' + QuotedStr(sGroupname) + ';';

    if strSQL<> '' then
      with GetNewdataset(strSQL, true) do
        try
          if RecordCount > 0 then begin
            try
              First;
              while RecordCount > 0 do begin
                Delete;
                First;
              end;
            except
              on e: Exception do begin
                raise Exception.Create('Error in TPOSGroup.DeleteAllTempPOSRecords using sql: "' + strSQL + '" with exception: ' + e.Message);
              end;
            end;
          end;
        finally
          if Active then close;
          Free;
        end;
  end;
  // OpenDB;
  RefreshDB;
end;

procedure TPOSGroup.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  if Assigned(fPOSObj) then begin
    if (not fPOSObj.ExternalDatasetAssigned) then FreeAndNil(fPOSObj)
    else fPOSObj.dataset.close;
  end;
end;

procedure TPOSGroup.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TPOSGroup.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TPOSGroup.GetIDField: string;
begin
  Result := 'Posgroupid'
end;

class function TPOSGroup.GetBusObjectTablename: string;
begin
  Result := 'tblposgroup';
end;

function TPOSGroup.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TPOSGroup.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  Posgroupname := sGroupname;
end;

function TPOSGroup.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforeInsert(Sender);
  if not Result then Exit;
  DeleteAllTempPOSRecords;
end;

function TPOSGroup.GetPOSObj: TPOS;
begin
  postdb;
  if not Assigned(fPOSObj) then begin
    fPOSObj := TPOS.Create(Self);
    fPOSObj.connection := Self.connection;
  end;
  if (fPOSObj.SQLSelect <> 'PosGroupID= ' + IntToStr(ID)) or (fPOSObj.dataset.Active = False) then fPOSObj.LoadSelect('PosGroupID= ' + IntToStr(ID));
  Result := fPOSObj;
end;

{ Property functions }
function TPOSGroup.GetuserID: Integer;
begin
  Result := GetIntegerField('userID');
end;

function TPOSGroup.GeTPOSGroupname: string;
begin
  Result := GetStringField('Posgroupname');
end;

procedure TPOSGroup.SetuserID(const Value: Integer);
begin
  SetIntegerField('userID', Value);
end;

procedure TPOSGroup.SeTPOSGroupname(const Value: string);
begin
  SetStringField('Posgroupname', Value);
end;

function TPOSLine.GetIsPQAItem: Boolean;
begin
  Result := False;
end;

function TPOS.getPosRedeemPoints: TPosRedeemPoints;
begin
  Result := TPosRedeemPoints(getContainerComponent(TPosRedeemPoints, 'SaleId=' + IntToStr(Self.ID)));
end;

procedure TPOS.cloneRedeemPoints(const Sender: TBusObj; var Abort: Boolean);
begin
  if (salesObj is TPOSSale) or (salesObj is TCashBase) then Sender.CloneBusObj(ObjInstanceToClone.IDFieldNAme, ObjInstanceToClone.ID, False);
end;

{ TPosRedeemPoints }

constructor TPosRedeemPoints.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblPosredeempoints';
end;

procedure TPosRedeemPoints.CreateInstance;
begin
  if Owner is TPOS then
    if Assigned(TPOS(Owner).ObjInstanceToClone) then
      if (TPOS(Owner).ObjInstanceToClone is TPOSSale) then ObjInstanceToClone := TPOSSale(TPOS(Owner).ObjInstanceToClone).SalesRedeemPoints
      else if (TPOS(Owner).ObjInstanceToClone is TCashBase) then ObjInstanceToClone := TCashBase(TPOS(Owner).ObjInstanceToClone).SalesRedeemPoints;

end;

function TPosRedeemPoints.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;

  if Assigned(Self.Owner) then
    if Self.Owner is TPOS then Saleid := TPOS(Self.Owner).ID;
end;

initialization

RegisterClassOnce(TPOSGroup);
RegisterClassOnce(TPOS);
RegisterClassOnce(TVoucher);

end.
