unit busobjSalesorderInvoice;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  31/01/14  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf , busobjPQA, busobjSales;


type
   TSalesOrderInvoices = class;

  TSalesOrderInvoiceLines = class(TProdQty)
  private
    function GetSOInvoiceID         : Integer   ;
    function GetSalesOrderLineID    : Integer   ;
    procedure SetSOInvoiceID         (const Value: Integer   );
    procedure SetSalesOrderLineID    (const Value: Integer   );
    function GetUOMID               : Integer   ;
    procedure SetUOMID               (const Value: Integer   );

    function SalesOrderInvoice :TSalesOrderInvoices;

    Function salesclassId:Integer;
    function getProctreePQA: TPQA;
    function getPQAllocation: String;
    procedure setPQAllocation(const Value: String);
    function getQtytoInvoice: Double;
    procedure setQtytoInvoice(const Value: Double);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;

    function GetClassID: Integer; Override;
    function GetAllocType: string; Override;
    function GetTransDate: TdateTime; Override;
    function GetQty: Double; Override;
    function GetBOQty: Double; Override;
    function GetBOUOMQty: Double; Override;
    function GetUOMQty: Double; Override;
    function GetSerialnos: string; Override;
    function GetCleanClassID: Integer; Override;
    function GetcleanProductId: Integer; Override;
    function GetOrderQty: Double; Override;
    function GetUOMOrderQty: Double; Override;
    function GetMatrixRef: string; Override;
    function GetMatrixDesc: string; Override;
    function GetMatrixPrice: Double; Override;

    procedure SetActive(const Value: Boolean); Override;
    function GetActive: Boolean; Override;
    function GetUnitOfMeasureID: Integer; Override;
    procedure SetUnitOfMeasureID(const Value: Integer); Override;
    function GetUOMMultiplier: Double; Override;
    procedure SetUOMMultiplier(const Value: Double); Override;
    function GetUnitOfMeasure: string; Override;
    procedure SetUnitOfMeasure(const Value: string); Override;

    function GetProductID: Integer; Override;
    function GetProductName: string; Override;
    procedure SetProductID(const Value: Integer); Override;
    procedure SetProductName(const Value: string); Override;

    procedure SetSerialNos(const Value: string); Override;
    procedure SetBOQty(const Value: Double); Override;
    procedure SetQty(const Value: Double); Override;
    procedure SetTransDate(const Value: TdateTime); Override;
    procedure SetUOMQty(const Value: Double); Override;
    procedure SetOrderQty(const Value: Double); Override;
    procedure SetUOMOrderQty(const Value: Double); Override;
    function GetProductType: string; Override;
    procedure SetProductType(const Value: string); Override;
    procedure SetMatrixRef(const Value: string); Override;
    procedure SetMatrixDesc(const Value: string); Override;
    procedure SetMatrixPrice(const Value: Double); Override;

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property ProctreePQA: TPQA read getProctreePQA;
    Property PQAllocation :String read getPQAllocation write setPQAllocation;
    Property QtytoInvoice :Double read getQtytoInvoice write setQtytoInvoice;
    Function SalesOrder :TSalesOrder;
    function SalesOrderLine:TSalesOrderLine;
  published
    property SOInvoiceID          :Integer     read GetSOInvoiceID        write SetSOInvoiceID     ;
    property ProductId            :Integer     read GetProductId          write SetProductID       ;
    property SalesOrderLineID     :Integer     read GetSalesOrderLineID   write SetSalesOrderLineID;
    property UOMID                :Integer     read GetUOMID              write SetUOMID           ;
    property Qty                  :Double      read GetQty                write SetQty             ;
    property UOMQty               :Double      read GetUOMQty             write SetUOMQty          ;
  end;
  TSalesOrderInvoices = class(TMSBusObj)
  private
    AllLinesValis:Boolean;
    AnylineHasQtyToInvoice:Boolean;
    fiInvoiceID:Integer;
    InvoiceObj :TInvoice;
    function GetSalesOrderID        : Integer   ;
    function GetInvoicedBy          : Integer   ;
    function GetInvoicedOn          : TDateTime ;
    function getNotes               : String;
    procedure SetSalesOrderID        (const Value: Integer   );
    procedure SetInvoicedBy          (const Value: Integer   );
    procedure SetInvoicedOn          (const Value: TDateTime );
    Procedure SetNotes               (Const Value: String);
    function getLines: TSalesOrderInvoiceLines;
    Function getSalesOrder :TSalesOrder;
    procedure ValidateDataCallback(const Sender: TBusObj; var Abort: Boolean);
    function MakeInvoice: Boolean;
    procedure MakeInvoiceCallback(const Sender: TBusObj; var Abort: Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property InvoiceID:Integer read  fiInvoiceID write fiInvoiceID;
    Property SalesOrder :TSalesOrder read getSalesOrder;
  published
    property SalesOrderID         :Integer     read GetSalesOrderID       write SetSalesOrderID    ;
    property InvoicedBy           :Integer     read GetInvoicedBy         write SetInvoicedBy      ;
    property InvoicedOn           :TDateTime   read GetInvoicedOn         write SetInvoicedOn      ;
    Property Notes                :String      read getNotes              Write setNotes;
    Property Lines                :TSalesOrderInvoiceLines read getLines;
  end;


implementation


uses tcDataUtils, CommonLib, sysutils, dateutils, AppEnvironment, tcConst;



  {TSalesOrderInvoiceLines}

constructor TSalesOrderInvoiceLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SalesOrderInvoiceLines';
  fSQL := 'SELECT * FROM tblsalesorderinvoicelines';
end;


destructor TSalesOrderInvoiceLines.Destroy;
begin
  inherited;
end;


procedure TSalesOrderInvoiceLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SOInvoiceID');
  SetPropertyFromNode(node,'ProductId');
  SetPropertyFromNode(node,'SalesOrderLineID');
  SetPropertyFromNode(node,'UOMID');
  SetPropertyFromNode(node,'UOMMultiplier');
  SetPropertyFromNode(node,'Qty');
  SetPropertyFromNode(node,'UOMQty');
end;


procedure TSalesOrderInvoiceLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SOInvoiceID' ,SOInvoiceID);
  AddXMLNode(node,'ProductId' ,ProductId);
  AddXMLNode(node,'SalesOrderLineID' ,SalesOrderLineID);
  AddXMLNode(node,'UOMID' ,UOMID);
  AddXMLNode(node,'UOMMultiplier' ,UOMMultiplier);
  AddXMLNode(node,'Qty' ,Qty);
  AddXMLNode(node,'UOMQty' ,UOMQty);
end;


function TSalesOrderInvoiceLines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if SOInvoiceID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Header# should not be 0', True);
    Exit;
  end;
  if ProductId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Product should not be blank', True);
    Exit;
  end;
  if UOMID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'UOM should not be blank', True);
    Exit;
  end;
  if UOMMultiplier = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'UOM Multiplier should not be blank', True);
    Exit;
  end;
  (*Result := True;// *)  Result := inherited ValidateData;
end;


function TSalesOrderInvoiceLines.SalesOrder: TSalesOrder;
begin
  REsult:= nil;
  try
    result:= SalesOrderInvoice.SalesOrder;
  Except
    // kill the exception if owner is not assigned;
  end;
end;

function TSalesOrderInvoiceLines.SalesOrderInvoice: TSalesOrderInvoices;
begin
  REsult:= nil;
  if Assigned(Owner) then
    if owner is TSalesOrderInvoices then
      result := TSalesOrderInvoices(Owner);
end;

function TSalesOrderInvoiceLines.SalesOrderLine: TSalesOrderLine;
begin
  Result:= nil;
  if SalesOrder <> nil then begin
    REsult:= Salesorder.Lines;
    SalesOrder.Lines.Locate('SaleLineID' , SalesOrderLineID , []);
  end;
end;

function TSalesOrderInvoiceLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSalesOrderInvoiceLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


function TSalesOrderInvoiceLines.salesclassId: Integer;
begin
  With getNewDataset('Select ClassID from tblsales S inne rjoin tblsaleslines SL on s.saleId = Sl.saleId where SL.SaleLineID = ' + inttostr(SalesOrderLineID) , true) do try
    result:= FieldByname('ClassID').asInteger;
  finally
    if active then close;
    free;
  end;
end;

procedure TSalesOrderInvoiceLines.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SameText(Sender.fieldname, 'Qty') then begin
    if not RawMode then begin
      UOMQty := Qty / UOMMultiplier;
    end;
  end
  else if SameText(Sender.fieldname, 'UOMQty') then begin
    if not RawMode then begin
      Qty := UOMQty * UOMMultiplier;
    end;
  end;
end;


function TSalesOrderInvoiceLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;



function TSalesOrderInvoiceLines.getProctreePQA: TPQA;
var
  s:String;
begin
    Self.PostDB;
    s:='TRansLineID = '+ IntToStr(Self.Id)+ ' and ifnull(TransType,"") = '+QuotedStr(Self.Classname+'IN') ;
    Result := TPQA(getContainerComponent(TPQA, s));
    if (ID<> 0) and (Result.count = 0) and (ISPQAItem)  then begin
        Result.New;
    end;
end;

function TSalesOrderInvoiceLines.GetTransDate     : TdateTime;begin  REsult:= Salesorderinvoice.InvoicedOn;end;
class function TSalesOrderInvoiceLines.GetIDField : string;begin  Result := 'SOInvoiceLineID'end;
function TSalesOrderInvoiceLines.GetActive: Boolean; begin Result:= True; end;

function TSalesOrderInvoiceLines.GetAllocType     : string;begin  result:= 'IN';end;
function TSalesOrderInvoiceLines.GetBOQty         : Double;begin  REsult:= 0;end;
function TSalesOrderInvoiceLines.GetBOUOMQty      : Double;begin  REsult:= 0;end;
function TSalesOrderInvoiceLines.GetMatrixDesc    : string;begin  REsult:= '';end;
function TSalesOrderInvoiceLines.GetMatrixPrice   : Double;begin  REsult:= 0;end;
function TSalesOrderInvoiceLines.GetMatrixRef     : string;begin  result:= '';end;
function TSalesOrderInvoiceLines.GetOrderQty      : Double;begin  REsult:= Qty;end;
function TSalesOrderInvoiceLines.GetCleanClassID  : Integer;begin  result:= SalesOrderLine.cleanClassId;end;
function TSalesOrderInvoiceLines.GetcleanProductId: Integer;begin  result:= SalesOrderLine.cleanProductID;end;

function TSalesOrderInvoiceLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if Owner is TSalesOrderInvoices then
      SOInvoiceID := TSalesOrderInvoices(Owner).ID;
end;

function TSalesOrderInvoiceLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

class function TSalesOrderInvoiceLines.GetBusObjectTablename: string;begin  Result:= 'tblsalesorderinvoicelines';end;

function TSalesOrderInvoiceLines.GetClassID: Integer;
begin
  if SalesOrder <> nil then
    result:= SalesOrder.SaleClassId
  else result := salesclassId;
end;



{Property Functions}

function  TSalesOrderInvoiceLines.GetSOInvoiceID     : Integer   ; begin Result := GetIntegerField('SOInvoiceID');end;
function  TSalesOrderInvoiceLines.GetProductId       : Integer   ; begin Result := GetIntegerField('ProductId');end;
function TSalesOrderInvoiceLines.GetUnitOfMeasureID  : Integer   ; begin REsult := UOMId;end;
function  TSalesOrderInvoiceLines.GetUOMID           : Integer   ; begin Result := GetIntegerField('UOMID');end;
function  TSalesOrderInvoiceLines.GetSalesOrderLineID: Integer   ; begin Result := GetIntegerField('SalesOrderLineID');end;
function  TSalesOrderInvoiceLines.GetUOMMultiplier   : Double    ; begin Result := GetFloatField('UOMMultiplier');end;
function  TSalesOrderInvoiceLines.GetQty             : Double    ; begin Result := GetFloatField('Qty');end;
function TSalesOrderInvoiceLines.getQtytoInvoice     : Double    ; begin  Result := Getfloatfield('QtytoInvoice');end;
function  TSalesOrderInvoiceLines.GetUOMQty          : Double    ; begin Result := GetFloatField('UOMQty');end;
function TSalesOrderInvoiceLines.GetProductName      : string    ; begin result := tcdatautils.getProduct(ProductID); end;
function TSalesOrderInvoiceLines.GetUnitOfMeasure    : string    ; begin result := GetUOMName(UOMID) ;end;
function TSalesOrderInvoiceLines.GetSerialnos        : string    ; begin REsult := '';end;
function TSalesOrderInvoiceLines.GetProductType      : string    ; begin REsult := SaleSOrderline.productType;end;
function TSalesOrderInvoiceLines.GetUOMOrderQty      : Double    ; begin REsult := UOMQty;end;
function TSalesOrderInvoiceLines.getPQAllocation     : String    ; begin REsult := getStringfield('PQA');end;
procedure TSalesOrderInvoiceLines.SetSOInvoiceID     (const Value: Integer   ); begin SetIntegerField('SOInvoiceID'      , Value);end;
procedure TSalesOrderInvoiceLines.SetProductID       (const Value: Integer   ); begin SetIntegerField('ProductId'        , Value);end;
procedure TSalesOrderInvoiceLines.SetSalesOrderLineID(const Value: Integer   ); begin SetIntegerField('SalesOrderLineID' , Value);end;
procedure TSalesOrderInvoiceLines.SetUOMID           (const Value: Integer   ); begin SetIntegerField('UOMID'            , Value);end;
procedure TSalesOrderInvoiceLines.SetUOMMultiplier   (const Value: Double    ); begin SetFloatField  ('UOMMultiplier'    , Value);end;
procedure TSalesOrderInvoiceLines.SetQty             (const Value: Double    ); begin SetFloatField  ('Qty'              , Value);end;
procedure TSalesOrderInvoiceLines.setQtytoInvoice    (const Value: Double    ); begin SetfloatField  ('QtytoInvoice', value);end;
procedure TSalesOrderInvoiceLines.SetUOMQty          (const Value: Double    ); begin SetFloatField  ('UOMQty'           , Value);end;
procedure TSalesOrderInvoiceLines.setPQAllocation    (const Value: String    ); begin SetStringfield ('PQA'      , Value);end;
procedure TSalesOrderInvoiceLines.SetSerialNos       (const Value: string    ); begin  inherited;end;
procedure TSalesOrderInvoiceLines.SetActive          (const Value: Boolean   ); begin  inherited;end;
procedure TSalesOrderInvoiceLines.SetBOQty           (const Value: Double    ); begin  inherited;end;
procedure TSalesOrderInvoiceLines.SetMatrixDesc      (const Value: string    ); begin  inherited;end;
procedure TSalesOrderInvoiceLines.SetMatrixPrice     (const Value: Double    ); begin  inherited;end;
procedure TSalesOrderInvoiceLines.SetMatrixRef       (const Value: string    ); begin  inherited;end;
procedure TSalesOrderInvoiceLines.SetOrderQty        (const Value: Double    ); begin  inherited;end;
procedure TSalesOrderInvoiceLines.SetTransDate       (const Value: TdateTime ); begin  inherited;end;
procedure TSalesOrderInvoiceLines.SetProductType     (const Value: string    ); begin  inherited;end;
procedure TSalesOrderInvoiceLines.SetUOMOrderQty     (const Value: Double    ); begin  inherited;end;
procedure TSalesOrderInvoiceLines.SetUnitOfMeasure   (const Value: string    ); begin  inherited; UOMID := tcdatautils.GetUnitOfMeasureID(ProductId, value, uommultiplier);end;
procedure TSalesOrderInvoiceLines.SetUnitOfMeasureID (const Value: Integer   ); begin  inherited; UOMId := Value;end;
procedure TSalesOrderInvoiceLines.SetProductName     (const Value: string    ); begin  inherited; ProductId := tcdatautils.getProduct(Value);end;

  {TSalesOrderInvoices}

constructor TSalesOrderInvoices.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SalesOrderInvoices';
  fSQL := 'SELECT * FROM tblsalesorderinvoices';
end;


destructor TSalesOrderInvoices.Destroy;
begin
  inherited;
end;


procedure TSalesOrderInvoices.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SalesOrderID');
  SetPropertyFromNode(node,'InvoicedBy');
  SetDateTimePropertyFromNode(node,'InvoicedOn');
  SetPropertyFromNode(node,'Notes');
end;


procedure TSalesOrderInvoices.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SalesOrderID' ,SalesOrderID);
  AddXMLNode(node,'InvoicedBy' ,InvoicedBy);
  AddXMLNode(node,'InvoicedOn' ,InvoicedOn);
  AddXMLNode(node,'Notes' ,Notes);

end;


function TSalesOrderInvoices.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if SalesOrderID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'SalesOrder#  should not be 0 ', True);
    Exit;
  end;
  if InvoicedBy = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Invoiced By should not be blank', True);
    Exit;
  end;
  if InvoicedOn = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Invoiced On should not be blank', True);
    Exit;
  end;
  AllLinesValis:=True;
  AnylineHasQtyToInvoice:= False;
  Lines.IterateRecords(ValidateDataCallback);
  Result := AllLinesValis;
  if not(Result) then exit;


  if AnylineHasQtyToInvoice =false then begin
    Resultstatus.AddItem(False , rssError , 0,  'None of the product in the transaction has a qty to Invoice', True);
    Result:= False;
    Exit;
  end;

  REsult:= True;
end;
procedure TSalesOrderInvoices.ValidateDataCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TSalesOrderInvoiceLines) then exit;
  if not TSalesOrderInvoiceLines(Sender).ValidateData then begin
    AllLinesValis:=False;
    Abort := True;
  end;
  if TSalesOrderInvoiceLines(Sender).Qty >0 then
    AnylineHasQtyToInvoice := True;
end;
function TSalesOrderInvoices.getSalesOrder: TSalesOrder;
begin
  Result := nil;
  if Assigned(Owner) and (Owner is TSalesorder) then
    result := TSalesOrder(Owner);
  if result = nil then
    Result := TSalesOrder(getContainerComponent(TSalesOrder, 'SaleId = ' + inttostr(Self.SalesOrderID)));
end;
Procedure TSalesOrderInvoices.MakeInvoiceCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TSalesOrderInvoiceLines) then exit;
  if TSalesOrderInvoiceLines(Sender).Qty=0 then exit;
  if not(SalesOrder.lines.locate(SalesOrder.Lines.idfieldname, TSalesOrderInvoiceLines(Sender).SalesOrderLineID , [])) then exit;
  InvoiceObj.Lines.New;
  SalesOrder.lines.copyobjRec(SalesOrder.IDFieldname, InvoiceObj.Id,InvoiceObj.lines );
  InvoiceObj.Saledatetime :=incsecond(InvoicedOn);
  InvoiceObj.PostDB;
  InvoiceObj.lines.transDate :=incsecond(invoicedon);
  InvoiceObj.lines.PostDB;
  InvoiceObj.lines.SOInvoiceLineRef := TSalesOrderInvoiceLines(Sender).Globalref;
  InvoiceObj.lines.qtysold := TSalesOrderInvoiceLines(Sender).qty;
  InvoiceObj.lines.qtyshipped := TSalesOrderInvoiceLines(Sender).qty;
  InvoiceObj.lines.PostDB;
  TSalesOrderInvoiceLines(Sender).PQA.CopyAllocation(InvoiceObj.lines.PQa.ID, False);
end;
function TSalesOrderInvoices.MakeInvoice:Boolean;
begin
  REsult:= False;


    if not SalesOrder.LockRec then begin
      resultStatus.AddItem(False ,  rssWarning, 0, replacestr(SalesOrder.UserLock.LockMessage , 'Unable to update data.' , 'Unable to Invoice SalesOrder #' + inttostr(SalesOrder.ID) +'.'), true);
      Exit;
    end;
    InvoiceObj := TInvoice.Create(nil);
    try
      InvoiceObj.IgnoreAccesslevel := TRue;
      InvoiceObj.CreatingsalesOrderInvoice := True;
      InvoiceObj.silentMode := True;
      InvoiceObj.Connection := SalesOrder.Connection;
      InvoiceObj.LoadSelect('SOInvoiceRef = '  +Quotedstr(globalref)+' and SOInvoiced="T"');
      if InvoiceObj.count =0 then InvoiceObj.New;
      SalesOrder.copyobjRec('Saledatetime', incsecond(InvoicedOn),InvoiceObj );
      InvoiceObj.DocNumber  := inttostr(InvoiceObj.ID);
      InvoiceObj.Saledatetime :=incsecond(InvoicedOn,1);
      InvoiceObj.PostDB;
      InvoiceObj.SaleDate := incsecond(InvoicedOn);
      InvoiceObj.SOInvoiced:= True;
      InvoiceObj.SOInvoiceRef:= Globalref;
      InvoiceObj.postDB;
      InvoiceObj.SalesOrderGlobalRef := SalesOrder.globalref;//SOGlobalRef;
      InvoiceObj.RepairGlobalref := SalesOrder.RepairGlobalref; // if repair's Salesorder is converted the invoice should also be linked to the sales order
      InvoiceObj.IsSalesOrder := False;
      InvoiceObj.IsInvoice := True;
      InvoiceObj.OriginalDocNumber :='';
      InvoiceObj.BaseNo := '';
      InvoiceObj.BackOrderGlobalRef := '';
      InvoiceObj.Comments := 'Sales Order # ' + Quotedstr(SaleSOrder.GlobalRef)+' is partially invoiced' + NL +InvoiceObj.Comments;
      if AppEnv.CompanyPrefs.UseBarcodePicking and not (AppEnv.CompanyPrefs.BarcodePickingInSOMode) then InvoiceObj.IsBarcodePicking:= True;
      if InvoiceObj.ShipDate < InvoiceObj.SaleDate then InvoiceObj.ShipDate:= InvoiceObj.SaleDate;
      InvoiceObj.postDB;
      InvoiceObj.Lines.DeleteAll;
      Lines.IterateRecords(MakeInvoiceCallback);
      InvoiceObj.Lines.closedb;  // to refresh the pqa allocations table as its not done in bus obj, but using queries
      REsult := InvoiceObj.Save;
      if result then invoiceId :=InvoiceObj.ID
      else if InvoiceObj.REsultStatus.HasError then
        REsultStatus.AddItem(False , rssWarning, 0 ,InvoiceObj.REsultStatus.Allmessages);


      if Appenv.CompanyPrefs.ApplyPrepaymentsOnSOConversion then
        SalesOrder.ApplyPrepayment(InvoiceObj);


    finally
      FreeandNil(InvoiceObj);
    end;
end;

function TSalesOrderInvoices.Save: Boolean ;
begin
  InvoiceID:= 0;
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
  if not result then exit;
  if SalesOrder.IsInternalOrder =False then
    REsult:= MakeInvoice;
end;

procedure TSalesOrderInvoices.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSalesOrderInvoices.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TSalesOrderInvoices.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSalesOrderInvoices.GetIDField: string;
begin
  Result := 'SOInvoiceID'
end;


class function TSalesOrderInvoices.GetBusObjectTablename: string;
begin
  Result:= 'tblsalesorderinvoices';
end;


function TSalesOrderInvoices.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TSalesOrderInvoices.GetSalesOrderID    : Integer   ; begin Result := GetIntegerField('SalesOrderID');end;
function  TSalesOrderInvoices.GetInvoicedBy      : Integer   ; begin Result := GetIntegerField('InvoicedBy');end;
function  TSalesOrderInvoices.GetInvoicedOn      : TDateTime ; begin Result := GetDateTimeField('InvoicedOn');end;
function  TSalesOrderInvoices.GetNotes           : String    ; begin Result := GetStringField('Notes');end;
procedure TSalesOrderInvoices.SetSalesOrderID    (const Value: Integer   ); begin SetIntegerField('SalesOrderID'     , Value);end;
procedure TSalesOrderInvoices.SetInvoicedBy      (const Value: Integer   ); begin SetIntegerField('InvoicedBy'       , Value);end;
procedure TSalesOrderInvoices.SetInvoicedOn      (const Value: TDateTime ); begin SetDateTimeField('InvoicedOn'       , Value);end;
Procedure TSalesOrderInvoices.SetNotes           (Const Value: String    ); begin SetStringField('Notes'            , Value);end;

function TSalesOrderInvoices.getLines: TSalesOrderInvoiceLines;
begin
   result:=TSalesOrderInvoiceLines( getContainerComponent(TSalesOrderInvoiceLines, 'SOInvoiceID = ' + inttostr(ID)));
end;


initialization
  RegisterClass(TSalesOrderInvoices);
  RegisterClass(TSalesOrderInvoiceLines);

end.
