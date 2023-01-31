unit BusobjSalesDispatch;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  07/07/15  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, ERPdbComponents, BusObjSales;


type

  TSalesDispatchLines = class(TMSBusObj)
  private
    function GetSaleID              : Integer   ;
    function GetDispatchID          : Integer   ;
    function GetSaleLineID          : Integer   ;
    function GetUOMID               : Integer   ;
    function GetBatchNo             : String ;
    function GetProductID           : Integer   ;
    function GetProductName         : String ;
    function GetQty                 : Double    ;
    function GetUOMQty              : Double    ;
    function GetUOMMultiplier       : Double    ;
    Function getShipFromInvoice     : Boolean   ;
    procedure SetSaleID              (const Value: Integer   );
    procedure SetDispatchID          (const Value: Integer   );
    procedure SetSaleLineID          (const Value: Integer   );
    procedure SetUOMID               (const Value: Integer   );
    procedure SetBatchNo             (const Value: String);
    procedure SetProductID           (const Value: Integer   );
    procedure SetProductName         (const Value: String);
    procedure SetQty                 (const Value: Double    );
    procedure SetUOMQty              (const Value: Double    );
    procedure SetUOMMultiplier       (const Value: Double    );
    Procedure SetShipFromInvoice     (Const Value: Boolean   );
    function getInvoiceLine: TInvoiceLine;
    //function getInvoice: TInvoice;
    procedure ValidateQty;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property InvoiceLine :TInvoiceLine read getInvoiceLine;
    //Property Invoice :TInvoice read getInvoice;
    function Lock :Boolean ; override;

  published
    property DispatchID           :Integer     read GetDispatchID         write SetDispatchID      ;
    property SaleLineID           :Integer     read GetSaleLineID         write SetSaleLineID      ;
    property UOMID                :Integer     read GetUOMID              write SetUOMID           ;
    property BatchNo              :String      read GetBatchNo            write SetBatchNo         ;
    property ProductID            :Integer     read GetProductID          write SetProductID       ;
    property ProductName          :String      read GetProductName        write SetProductName     ;
    property Qty                  :Double      read GetQty                write SetQty             ;
    property UOMQty               :Double      read GetUOMQty             write SetUOMQty          ;
    property UOMMultiplier        :Double      read GetUOMMultiplier      write SetUOMMultiplier   ;
    Property ShipFromInvoice      :Boolean     read getShipFromInvoice    write SetShipFromInvoice ;
    property SaleID               :Integer     read GetSaleID             write SetSaleID          ;
  end;

  TSalesDispatch = class(TMSBusObj)
  private
    fQryTobedispatched :TERPQuery;
    AllLinesValid:Boolean;
    function GetEmployeeID           : Integer   ;
    function GetEmployeeName         : String ;
    function GetDispatchDate          : TDateTime ;
    procedure SetDispatchDate          (const Value: TDateTime );
    procedure SetEmployeeID           (const Value: Integer   );
    procedure SetEmployeeName         (const Value: String);
    function getLines: Tsalesdispatchlines;
    Function QryTobedispatched :TERPQuery;
    Procedure ValidateLinesCallback(const Sender: TBusObj; var Abort: Boolean);
    Function ShipInvoiceQty(saleLineID: Integer; var fdQty: Double):Boolean;
    function updateInvoices: Boolean;
    function updateInvoicesCallback(const aSaleID: Integer): Boolean;

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    function QtyTobedispatched(saleLineID:Integer; batchno:String;SDLID:Integer; ZeroWhenNegative:Boolean =True):Double;
    function QtyTobeShipped(saleLineID:Integer; batchno:String;SDLID:Integer; ZeroWhenNegative:Boolean =True):Double;
    Procedure NewDispatchEntry(saleLineID:Integer; Batchno:String; fdQty:Double; aShipFromInvoice :Boolean =False);
    Function NewInvoiceDispatchEntry(saleLineID:Integer; Batchno:String; fdQty:Double) :Boolean;
  published
    Property Lines: TSalesDispatchLines read getLines;
    property DispatchDate           :TDateTime   read GetDispatchDate         write SetDispatchDate     ;
    property EmployeeID            :Integer     read GetEmployeeID          write SetEmployeeID       ;
    property EmployeeName          :String      read GetEmployeeName        write SetEmployeeName     ;
  end;


implementation


uses Sysutils, tcDataUtils, CommonLib, BusObjConst, AppEnvironment, tcConst,
  LogLib, DbSharedObjectsObj;



  {Tsalesdispatch}

constructor Tsalesdispatch.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fQryTobedispatched  := nil;
  fBusObjectTypeDescription:= 'salesdispatch';
  fSQL := 'SELECT * FROM tblsalesdispatch';
end;


destructor Tsalesdispatch.Destroy;
begin
  inherited;
end;


procedure Tsalesdispatch.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(node,'DispatchDate');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'EmployeeName');
end;
Function  Tsalesdispatch.ShipInvoiceQty(saleLineID:Integer; var fdQty:Double):Boolean;
var
  fInvoice :TInvoice;
begin
  fInvoice := TInvoice.create(self);
  try
    fInvoice.connection := Self.connection;
    fInvoice.load(tcdatautils.SaleID(SaleLineId));   fInvoice.SilentMode := true;
    if fInvoice.count =0 then begin
      Resultstatus.AddItem(False , rssWarning , 0,  'This is not a valid Dispatch Barcode - Sale not found', True);
      REsult := False;
      Exit;
    end;
    if not fInvoice.lock then begin
      Resultstatus.AddItem(False , rssWarning , 0,  Replacestr(fInvoice.UserLock.LockMessage, 'Unable to update data.' , 'Unable to Update the Invoice # ' + inttostr(fInvoice.id) +'.' ) , True);
      REsult := False;
      Exit;
    end;
    if fInvoice.lines.locate('saleLineId' , saleLineID , []) = false then begin
      Resultstatus.AddItem(False , rssWarning , 0,  'This is not a valid Dispatch Barcode - Product not found in Invoice # ' + inttostr(fInvoice.id) +'.' , True);
      REsult := False;
      Exit;
    end;
    if fInvoice.lines.QtyBackOrder  =0 then begin
      Resultstatus.AddItem(False , rssWarning , 0,  'Product ' +quotedstr(fInvoice.lines.productname)+' in Invoice # ' + inttostr(fInvoice.id) +' is completely Shipped.' , True);
      REsult := False;
      Exit;
    end;

    if fInvoice.lines.QtyBackOrder  < fdQty then fdQty :=fInvoice.lines.QtyBackOrder ;
    result := True;
    (*fInvoice.connection.beginnestedTransaction;
    try
      if fInvoice.lines.QtyBackOrder  < fdQty then fdQty :=fInvoice.lines.QtyBackOrder ;
      fInvoice.lines.QtyShipped := fInvoice.lines.QtyShipped + fdQty;
      fInvoice.lines.PostDB;
      if not fInvoice.save then begin
        Result := False;
        Exit;
      end;
      fInvoice.connection.CommitnestedTransaction;
      Result := True;
    Except
      on E:Exception do begin
        fInvoice.connection.RollbacknestedTransaction;
        Resultstatus.AddItem(False , rssWarning , 0,  'Update Failed for Invoice # ' + inttostr(fInvoice.id) +'.'+ NL + Nl + E.message, True);
        REsult := False;
        Exit;
      end;
    end;*)

  finally
    FreeandNil(fInvoice);
  end;

end;
Function Tsalesdispatch.NewInvoiceDispatchEntry(saleLineID:Integer; Batchno:String; fdQty:Double) :Boolean ;
begin
    Result := False;
   if ShipInvoiceQty(saleLineID , fdQty) then begin
    NewDispatchEntry( saleLineID ,  Batchno , fdQty , true);
    Result := True;
   end;
end;

procedure Tsalesdispatch.NewDispatchEntry((*SaleId, *)saleLineID: Integer;Batchno: String; fdQty: Double; aShipFromInvoice :Boolean =False);
begin
  Lines.PostDb;
  if Lines.Count >0 then begin
    Lines.First;
    while Lines.EOF = False do begin
      if (Lines.SaleLineID = SaleLineID) (*and (Lines.SaleID = SaleID) *)and (Lines.Batchno = Batchno) then begin
        Lines.Qty := Lines.Qty  + fdQty;
        Lines.ShipFromInvoice := aShipFromInvoice;
        Lines.PostDB;
        Exit;
      end;
      Lines.Next;
    end;
  end;
  Lines.new;
  (*Lines.SaleId :=SaleID;*)
  Lines.SaleLineID := saleLineID;
  Lines.Batchno := Batchno;
  Lines.ShipFromInvoice := aShipFromInvoice;
  Lines.Qty := fdQty;
  Lines.Postdb;
end;

procedure Tsalesdispatch.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'DispatchDate' ,DispatchDate);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
end;


function Tsalesdispatch.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if DispatchDate = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'DispatchDate should not be blank' , True );
    Exit;
  end;
  AllLinesValid := True;
  Lines.IterateRecords(ValidateLinesCallback);
  Result := AllLinesValid;
  if not (result) then exit;

  Result := True;
end;


procedure Tsalesdispatch.ValidateLinesCallback(const Sender: TBusObj;  var Abort: Boolean);
begin
  if not(Sender is TsalesdispatchLines) then exit;
  if not(TsalesdispatchLines(SendER).ValidateData) then begin
    AllLinesValid:= False;
    Abort := TRue;
  end;
end;

function Tsalesdispatch.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
  if not result then exit;
  Result := updateInvoices;
end;
Function Tsalesdispatch.updateInvoicesCallback(const aSaleID:Integer):Boolean;
var
  fInvoice : TInvoice;
begin
  fInvoice := TInvoice.create(self);
  try
    fInvoice.connection := Self.connection;
    fInvoice.Load(aSaleID);fInvoice.SilentMode := true;

    fInvoice.connection.beginnestedTransaction;
    try
      Lines.First;
      While Lines.Eof =False do begin
        if (lines.saleId = fInvoice.ID) and (lines.ShipFromInvoice) then begin
          if finvoice.lines.locate('SaleLineId' , Lines.SaleLineID , []) then begin

            if fInvoice.lines.PQA.PQABAtch.locate('Value' , Lines.BatchNo , []) = false then begin
              fInvoice.lines.PQA.PQABAtch.New;
              fInvoice.lines.PQA.PQABAtch.Batchno := Lines.BatchNo ;
            end;
            fInvoice.lines.PQA.PQABAtch.Qty := fInvoice.lines.PQA.PQABAtch.Qty + Lines.Qty;
            fInvoice.lines.PQA.PQABAtch.boQty := fInvoice.lines.PQA.PQABAtch.boQty - Lines.Qty;
            fInvoice.lines.PQA.PQABAtch.PostDB;

            fInvoice.lines.QtyShipped := fInvoice.lines.QtyShipped + Lines.Qty;
            fInvoice.lines.PostDB;

          end;
        end;
        Lines.next;
      end;
      if not fInvoice.save then begin
        fInvoice.connection.RollbacknestedTransaction;
        Result := False;
        Exit;
      end;
      fInvoice.connection.CommitnestedTransaction;
      Result := True;
    Except
      on E:Exception do begin
        fInvoice.connection.RollbacknestedTransaction;
        Resultstatus.AddItem(False , rssWarning , 0,  'Update Failed for Invoice # ' + inttostr(fInvoice.id) +'.'+ NL + Nl + E.message, True);
        REsult := False;
        Exit;
      end;
    end;
  finally
    FreeandNil(fInvoice);

  end;


end;
Function Tsalesdispatch.updateInvoices:Boolean;
var
  qry: TERPQuery;
begin
  Result := True;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.connection.connection);
  try
    qry.SQL.text := 'Select distinct SaleId from tblsalesdispatchlines where DispatchID =' + inttostr(ID)+' and ShipFromInvoice ="T"';
    qry.open;
    if qry.recordcount = 0 then exit;
    qry.first;
    While qry.Eof = False do begin
        if not updateInvoicesCallback(Qry.fieldbyname('SaleId').asInteger) then begin
          REsult := False;
          Exit;
        end;
        qry.next;
    end;
    Result := True;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure Tsalesdispatch.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tsalesdispatch.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tsalesdispatch.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tsalesdispatch.GetIDField: string;
begin
  Result := 'ID'
end;


function Tsalesdispatch.getLines: Tsalesdispatchlines;
begin
  Result := Tsalesdispatchlines(getContainercomponent(Tsalesdispatchlines, 'DispatchID = ' + inttostr(ID)));
end;

class function Tsalesdispatch.GetBusObjectTablename: string;
begin
  Result:= 'tblsalesdispatch';
end;


function Tsalesdispatch.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not(Result) then exit;
  DispatchDate := Date;
  EmployeeId := Appenv.Employee.EmployeeID;
  EmployeeName := Appenv.Employee.EmployeeName;
end;

function Tsalesdispatch.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function Tsalesdispatch.QryTobedispatched: TERPQuery;
begin
  if  fQryTobedispatched = nil then begin
    fQryTobedispatched := TERPQuery.Create(Self);
    fQryTobedispatched.connection := Self.connection.connection;
    fQryTobedispatched.SQL.Text := 'Select '+
                ' (select sum(qty)   '+
                        ' from tblsalesdispatchlines SDL   '+
                        ' where SDL.SaleLineID = :SaleLineID and SDL.BatchNo = :Batchno and SDL.ID <> :SDLID) as DispatchedQty , '+ NL+
                ' (Select Sum(pqad.qty)  '+
                        ' from tblpqa pqa  '+
                        ' inner join tblpqadetails pqad on pqa.pqaid = pqad.PQAID  '+
                        ' where pqa.transLineId = :SaleLineID and pqa.transtype ="TInvoiceLine" and pqa.alloctype ="OUT" and pqad.Value = :Batchno and pqad.PQAType ="Batch") as totalBatchqty, '+ NL+
                ' (Select ' +
                        ' Sum(pqad.boqty)  '+
                        ' From tblsaleslines SL inner join tblsales S on SL.saleId = S.saleId  '+
                        ' inner join (Select  '+
                        ' SL.productId, SL.seqno , S.originalno  '+
                        ' From tblsaleslines SL inner join tblsales S on SL.saleId = S.saleId  '+
                        ' Where SL.saleLineId = :SaleLineID) Originalsale  on Originalsale.originalno = S.OriginalNo and ifnull(S.BOID , "")="" and SL.productId = Originalsale.ProductId and SL.Seqno = Originalsale.Seqno  '+
                        ' inner join tblPQA pqa on pqa.transId = S.saleId and pqa.translineId = SL.saleLIneID and pqa.transtype ="TInvoiceLine" and pqa.alloctype ="OUT"  '+
                        ' inner join tblpqadetails pqad on pqa.pqaid = pqad.PQAID    and pqad.Value = :Batchno and pqad.PQAType ="Batch" and ifnull(pqad.boqty,0)<>0) as totalBatchboqty';
                (*' (Select Sum(pqad.boqty)  '+
                        ' from tblpqa pqa  '+
                        ' inner join tblpqadetails pqad on pqa.pqaid = pqad.PQAID  '+
                        ' where pqa.transLineId = :SaleLineID and pqa.transtype ="TInvoiceLine" and pqa.alloctype ="OUT" and pqad.Value = :Batchno and pqad.PQAType ="Batch" and ifnull(pqad.qty,0)=0) as totalBatchboqty';*)
  end;
  REsult := fQryTobedispatched;
end;

function Tsalesdispatch.QtyTobedispatched(saleLineID: Integer; batchno: String; SDLID: Integer; ZeroWhenNegative: Boolean): Double;
begin
  With QryTobedispatched do begin
    {close and reopen again to force any change in the quantities}
    if active then close;
    Parambyname('SaleLineID').AsInteger := SaleLineID;
    Parambyname('Batchno').asString     := batchno;
    Parambyname('SDLID').AsInteger      := SDLID;
    open;
    Result := FieldByName('totalBatchqty').AsFloat - FieldByName('DispatchedQty').AsFloat;
    if ZeroWhenNegative and (Result <0) then Result := 0;
  end;
end;
function Tsalesdispatch.QtyTobeShipped(saleLineID:Integer; batchno:String;SDLID:Integer; ZeroWhenNegative:Boolean =True):Double;
begin
  With QryTobedispatched do begin
    {close and reopen again to force any change in the quantities}
    if active then close;
    Parambyname('SaleLineID').AsInteger := SaleLineID;
    Parambyname('Batchno').asString     := batchno;
    Parambyname('SDLID').AsInteger      := SDLID;
    open;
    clog(SQLtext);
    Result := FieldByName('totalBatchboqty').AsFloat - FieldByName('DispatchedQty').AsFloat;
    Logtext(floattostr(FieldByName('totalBatchboqty').AsFloat )+'-' +floattostr(FieldByName('DispatchedQty').AsFloat));
    if ZeroWhenNegative and (Result <0) then Result := 0;
  end;
end;

{Property Functions}
function  Tsalesdispatch.GetDispatchDate      : TDateTime ; begin Result := GetDateTimeField('DispatchDate');end;
function  Tsalesdispatch.GetEmployeeID       : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  Tsalesdispatch.GetEmployeeName     : String    ; begin Result := GetstringField('EmployeeName');end;
procedure Tsalesdispatch.SetDispatchDate      (const Value: TDateTime ); begin SetDateTimeField('DispatchDate'  , Value);end;
procedure Tsalesdispatch.SetEmployeeID       (const Value: Integer   ); begin SetIntegerField('EmployeeID'    , Value);end;
procedure Tsalesdispatch.SetEmployeeName     (const Value: String    ); begin SetStringField('EmployeeName'   , Value);end;


  {Tsalesdispatchlines}
constructor Tsalesdispatchlines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'salesdispatchlines';
  fSQL := 'SELECT * FROM tblsalesdispatchlines';
end;


destructor Tsalesdispatchlines.Destroy;
begin
  inherited;
end;

(*function TsalesdispatchLines.getInvoice: TInvoice;
begin
  Result := TInvoice(getContainercomponent(TInvoice, 'SaleID = ' + inttostr(SaleID)));
end;*)

procedure Tsalesdispatchlines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'DispatchID');
  SetPropertyFromNode(node,'SaleLineID');
  SetPropertyFromNode(node,'UOMID');
  SetPropertyFromNode(node,'BatchNo');
  SetPropertyFromNode(node,'ProductID');
  SetPropertyFromNode(node,'ProductName');
  SetPropertyFromNode(node,'Qty');
  SetPropertyFromNode(node,'UOMQty');
  SetPropertyFromNode(node,'UOMMultiplier');
  SetbooleanPropertyFromNode(node,'ShipFromInvoice');
  SetPropertyFromNode(node,'SaleID');
end;


function Tsalesdispatchlines.Lock: Boolean;
begin
  { use an ID of 0 to only allow one person to do dispatch at
    any one time }
  UserLock.Enabled:= true;
  result:= UserLock.Lock(BusObjectTableName,0, BusObjectTypeDescription);
end;

procedure Tsalesdispatchlines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'DispatchID' ,DispatchID);
  AddXMLNode(node,'SaleLineID' ,SaleLineID);
  AddXMLNode(node,'UOMID' ,UOMID);
  AddXMLNode(node,'BatchNo' ,BatchNo);
  AddXMLNode(node,'ProductID' ,ProductID);
  AddXMLNode(node,'ProductName' ,ProductName);
  AddXMLNode(node,'Qty' ,Qty);
  AddXMLNode(node,'UOMQty' ,UOMQty);
  AddXMLNode(node,'UOMMultiplier' ,UOMMultiplier);
  AddXMLNode(node,'ShipFromInvoice' ,ShipFromInvoice);
  AddXMLNode(node,'SaleID' ,SaleID);
end;


function Tsalesdispatchlines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if DispatchID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'DispatchID should not be 0' , True);
    Exit;
  end;
  if SaleID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'SaleID should not be 0' , True);
    Exit;
  end;
  if SaleLineID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'SaleLineID should not be 0' , True);
    Exit;
  end;
  if BatchNo = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'BatchNo should not be blank' , True);
    Exit;
  end;
  if Qty = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Qty should not be 0' , True);
    Exit;
  end;
  if UOMQty = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'UOMQty should not be 0' , True);
    Exit;
  end;
  Result := True;
end;


function Tsalesdispatchlines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tsalesdispatchlines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tsalesdispatchlines.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'uomqty') then begin
    if uomQty =0 then Qty:=0
    else Qty := uomQty* UOMMultiplier ;
    SendEvent(BusObjEvent_Change , BusObjEventVal_TransQtyChanged , self);
    ValidateQty;
  end else if Sysutils.SameText(Sender.FieldName, 'qty') then begin
    if Qty =0 then uomQty:=0
    else uomQty := divzer(Qty, UOMMultiplier);
    ValidateQty;
  end else if Sysutils.SameText(Sender.FieldName, 'SaleLineId') then begin
    //with Invoice.Lines do begin
     With InvoiceLine do begin
      Self.SaleID         := SaleID;
      Self.ProductID      := ProductID;
      Self.ProductName    := ProductName;
      Self.UOMID          := UnitOfMeasureID;
      Self.UOMMultiplier  := UOMMultiplier;
    end;
  end;
end;
Procedure Tsalesdispatchlines.ValidateQty;
var
  fdQty :Double;
begin
  if not(Assigned(Owner)) then exit;
  if not(owner is Tsalesdispatch) then exit;
  if ShipFromInvoice then fdQty := Tsalesdispatch(Owner).QtyTobeShipped(SaleLineID,batchno,ID)
  else fdQty := Tsalesdispatch(Owner).QtyTobedispatched(SaleLineID,batchno,ID);
  if fdQty < Qty then begin
    Qty := fdQty;
    if Qty =0 then uomQty:=0 else uomQty := divzer(Qty, UOMMultiplier);
  end;
end;

function Tsalesdispatchlines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tsalesdispatchlines.GetIDField: string;
begin
  Result := 'ID'
end;


function Tsalesdispatchlines.getInvoiceLine: TInvoiceLine;
begin
  Result := TInvoiceLine(getContainercomponent(TInvoiceLine, 'SaleLineId = ' + inttostr(SaleLineId)));
end;

class function Tsalesdispatchlines.GetBusObjectTablename: string;
begin
  Result:= 'tblsalesdispatchlines';
end;


function Tsalesdispatchlines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not(Result) then exit;
  if Assigned(Owner) then
    if owner is Tsalesdispatch then begin
      Tsalesdispatch(OwneR).PostDB;
      DispatchId := Tsalesdispatch(Owner).ID;
    end;
  ShipFromInvoice := False;
end;

function Tsalesdispatchlines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tsalesdispatchlines.GetDispatchID      : Integer   ; begin Result := GetIntegerField('DispatchID');end;
function  Tsalesdispatchlines.GetSaleLineID      : Integer   ; begin Result := GetIntegerField('SaleLineID');end;
function  Tsalesdispatchlines.GetUOMID           : Integer   ; begin Result := GetIntegerField('UOMID');end;
function  Tsalesdispatchlines.GetBatchNo         : String    ; begin Result := GetstringField('BatchNo');end;
function  Tsalesdispatchlines.GetProductID       : Integer   ; begin Result := GetIntegerField('ProductID');end;
function  Tsalesdispatchlines.GetProductName     : String    ; begin Result := GetstringField('ProductName');end;
function  Tsalesdispatchlines.GetQty             : Double    ; begin Result := GetFloatField('Qty');end;
function  Tsalesdispatchlines.GetUOMQty          : Double    ; begin Result := GetFloatField('UOMQty');end;
function  Tsalesdispatchlines.GetUOMMultiplier   : Double    ; begin Result := GetFloatField('UOMMultiplier');end;
Function  Tsalesdispatchlines.GetShipFromInvoice : Boolean   ; begin Result := GetBooleanField('ShipFromInvoice');end;
function  TsalesdispatchLines.GetSaleID          : Integer   ; begin Result := GetIntegerField('SaleID');end;

procedure Tsalesdispatchlines.SetDispatchID      (const Value: Integer   ); begin SetIntegerField('DispatchID'   , Value);end;
procedure Tsalesdispatchlines.SetSaleLineID      (const Value: Integer   ); begin SetIntegerField('SaleLineID'   , Value);end;
procedure Tsalesdispatchlines.SetUOMID           (const Value: Integer   ); begin SetIntegerField('UOMID'        , Value);end;
procedure Tsalesdispatchlines.SetBatchNo         (const Value: String    ); begin SetStringField('BatchNo'       , Value);end;
procedure Tsalesdispatchlines.SetProductID       (const Value: Integer   ); begin SetIntegerField('ProductID'    , Value);end;
procedure Tsalesdispatchlines.SetProductName     (const Value: String    ); begin SetStringField('ProductName'   , Value);end;
procedure Tsalesdispatchlines.SetQty             (const Value: Double    ); begin SetFloatField('Qty'            , Value);end;
procedure Tsalesdispatchlines.SetUOMQty          (const Value: Double    ); begin SetFloatField('UOMQty'         , Value);end;
procedure Tsalesdispatchlines.SetUOMMultiplier   (const Value: Double    ); begin SetFloatField('UOMMultiplier'  , Value);end;
procedure Tsalesdispatchlines.SetShipFromInvoice (Const Value: Boolean   ); begin SetbooleanField('ShipFromInvoice',Value);end;
procedure TsalesdispatchLines.SetSaleID          (const Value: Integer   ); begin SetIntegerField('SaleID'       , Value);end;

initialization
  RegisterClass(Tsalesdispatchlines);
  RegisterClass(Tsalesdispatch);


end.
