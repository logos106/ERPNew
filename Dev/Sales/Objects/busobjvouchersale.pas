unit busobjvouchersale;

interface
uses BusObjSales, BusObjBase,BusObjSaleBase, db, classes, XMLDoc, XMLIntf, busobjtrans, busobjpos, busobjvoucher , BusObjPOSSale;

type
  TVoucherInvoiceLine = Class(TInvoiceLine)
    Private
      function getVoucher: TVoucher;
      function getVouchernotoAdd: String;
      procedure setVouchernotoAdd(const Value: String);
      function Validvoucherno(const sVoucherNo: String; var errmsg: String;VoucherLineID: Integer): Boolean;
      function Generatingvouchers:Boolean;
    Protected
      function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
      function DoBeforeInsert(Sender: TDatasetBusObj): Boolean; override;
      function DoAfterOpen(Sender: TDatasetBusObj): Boolean; override;
      function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
      function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
      procedure DoFieldOnChange(Sender: TField); override;
    Public
      procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
      Property Voucher:TVoucher read getVoucher;
      Property VouchernotoAdd:String read getVouchernotoAdd write setVouchernotoAdd;
      function ValidateData: Boolean; override;
  End;

  TVoucherInvoice = class(TInvoice)
    Private
      fsVouchernotoAdd: String;
      fbGeneratingvouchers: boolean;
      function GeTVoucherInvoiceslines: TVoucherInvoiceLine;
    Protected
      function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
      function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
      function GetInvoiceLines: TInvoiceLine; override;
    Public
      function GetSaleLines: TSalesLineBase; override;
      function GetLines: TTransLineBase; override;
      function Save: Boolean; override;
      Procedure MakeVouchers(const Sender: TBusObj; var Abort: Boolean);
      Function LockTrans(var ErrMsg :String):Boolean;Override;
      Property VouchernotoAdd :String read fsVouchernotoAdd write fsVouchernotoAdd;
      Property Generatingvouchers :boolean read fbGeneratingvouchers write fbGeneratingvouchers;
    Published
      property Lines: TVoucherInvoiceLine Read GeTVoucherInvoiceslines;
  end;
  TVoucherCashSaleLine = Class(TPOSCashSaleLine)
    Private
      function getVoucher: TVoucher;
      function getVouchernotoAdd: String;
      procedure setVouchernotoAdd(const Value: String);
      function Validvoucherno(const sVoucherNo: String; var errmsg: String;VoucherLineID: Integer): Boolean;
      function Generatingvouchers:Boolean;
    Protected
      function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
      function DoAfterOpen(Sender: TDatasetBusObj): Boolean; override;
      function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
      function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
      procedure DoFieldOnChange(Sender: TField); override;
    Public
      procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
      Property Voucher:TVoucher read getVoucher;
      Property VouchernotoAdd:String read getVouchernotoAdd write setVouchernotoAdd;
      function ValidateData: Boolean; override;
  End;

  TVoucherCashSale = class(TPOSCashSale)
    Private
      fsVouchernotoAdd: String;
      fbGeneratingvouchers: boolean;
      function GeTVoucherCashSaleslines: TVoucherCashSaleLine;
    Protected
      function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
      function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
      procedure DoFieldOnChange(Sender: TField); override;
    Public
      function GetSaleLines: TSalesLineBase; override;
      function GetLines: TTransLineBase; override;
      function Save: Boolean; override;
      Procedure MakeVouchers(const Sender: TBusObj; var Abort: Boolean);
      Function LockTrans(var ErrMsg :String):Boolean;Override;
      Property VouchernotoAdd :String read fsVouchernotoAdd write fsVouchernotoAdd;
      Property Generatingvouchers :boolean read fbGeneratingvouchers write fbGeneratingvouchers;
    Published
      property Lines: TVoucherCashSaleLine Read GeTVoucherCashSaleslines;
  end;
implementation

uses sysutils, VoucherLib, tcConst, ERPdbComponents  , BusObjConst, tcDataUtils,
  CommonLib;

{ TVoucherInvoiceLine }
function TVoucherInvoiceLine.getVoucher: TVoucher;
begin
  result := TVoucher(getContainerComponent(TVoucher, 'VoucherNo=' + Quotedstr(VoucherNo)));
end;
function TVoucherInvoiceLine.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforeInsert(Sender);
  if not result then Exit;

end;

function TVoucherInvoiceLine.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then Exit;
  IsVoucher   := True;
  if VouchernotoAdd = '' then
       Voucherno   := Inttostr(NextVoucherno(TERPConnection(Self.Connection.Connection)))
  else begin
    Voucherno   := VouchernotoAdd;
    VouchernotoAdd := '';
  end;
  ProductName := PART_VOUCHER;
  Productdescription := 'Voucher No: '+VoucherNo;
  QtySold     := 1;
  Qtyshipped  := 1;
  CreationDate:= Date;
  SendEvent(BusobjEvent_Event, BusobjEvent_AfterInsert, self);
end;
function TVoucherInvoiceLine.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterOpen(Sender);
  if not result then exit;
end;

function TVoucherInvoiceLine.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterPost(Sender);
  if not result then exit;
  if eof then exit;
  if (trim(voucherno) = '')and (self.ProductID < 1) and (Deleted =False) then begin
    Deleted:= True;
    PostDb;
  end;
end;

function TVoucherInvoiceLine.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoBeforePost(Sender);
  if not result then exit;
end;

procedure TVoucherInvoiceLine.DoFieldOnChange(Sender: TField);
var
  ErrMsg:String;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'VoucherNo') then begin
    if not(Generatingvouchers) then {when generating vouchers, its already validates}
      if not Validvoucherno(voucherno , ErrMsg , ID) then begin
        ResultStatus.AddItem(False, rsswarning, 0, ErrMsg+NL+NL+'Automatially allocated the next Available voucher Number. Please change it if required.');
        VoucherNo:= Inttostr(NextVoucherno(TERPConnection(Self.Connection.Connection)));
      end else begin
        Productdescription := 'Voucher No: '+VoucherNo;
      end;
  end;
end;

function TVoucherInvoiceLine.Generatingvouchers: Boolean;
begin
  result:= False;
  if assigned(Owner) then
    if owner is TVoucherInvoice then
      result:= TVoucherInvoice(Self.Owner).Generatingvouchers;
end;

function TVoucherInvoiceLine.getVouchernotoAdd: String;
begin
  result:= '';
  if assigned(Self.owner) then
    if self.owner is TVoucherInvoice then
      result:= TVoucherInvoice(self.owner).VouchernotoAdd;
end;

procedure TVoucherInvoiceLine.OnDataIdChange(  const ChangeType: TBusObjDataChangeType);
begin
  inherited OnDataIdChange(ChangeType);
end;


procedure TVoucherInvoiceLine.setVouchernotoAdd(const Value: String);
begin
  if assigned(Self.owner) then
    if self.owner is TVoucherInvoice then
      TVoucherInvoice(self.owner).VouchernotoAdd:= Value;
end;

function TVoucherInvoiceLine.ValidateData: Boolean;
begin
  result := inherited ValidateData;
  if not result then exit;

end;

function TVoucherInvoiceLine.Validvoucherno(const sVoucherNo:String; var errmsg:String;VoucherLineID:Integer):Boolean;
begin
      errmsg:= '';
      with GEtNewDataset('SELECT * FROM tblvouchers where voucherno = '+quotedStr(sVoucherNo), true) do try
        Open;
        result := recordcount = 0 ;
        if not result then begin
          errmsg:='Voucher:' + sVoucherNo +' is already issued to ' +tcdatautils.GetClientName(FieldByname('clientID').asInteger)+' on ' +FormatDateTime(FormatSettings.ShortDateformat , Fieldbyname('DateIssued').asDateTime )+chr(13)+chr(13);
          exit;
        end;

        if Active then close;
        SQL.clear;
        SQL.Add('Select * from tblsaleslines where SaleLineId <>  '+inttostr(ID) +' and voucherno = '+quotedstr(sVoucherNo) );
        open;
        result := recordcount = 0 ;
        if not result then begin
          errmsg:='Voucher:' + sVoucherNo +' is already issued in this sale';
          exit;
        end;
      finally
          if active then close;
          Free;
      end;
end;

{ TVoucherInvoice }

function TVoucherInvoice.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then Exit;
  IsInvoice := True;
  IsVoucher := True;
end;

function TVoucherInvoice.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforePost(Sender);
  if not result then Exit;

end;

function TVoucherInvoice.GetLines: TTransLineBase;
begin
  result := GetSaleLines;
end;
function TVoucherInvoice.GetInvoiceLines: TInvoiceLine;
begin
  result :=GeTVoucherInvoiceslines;
end;
function TVoucherInvoice.GetSaleLines: TSalesLineBase;
begin
  result:= GeTVoucherInvoiceslines;
end;

function TVoucherInvoice.GeTVoucherInvoiceslines: TVoucherInvoiceLine;
begin
  result := TVoucherInvoiceLine(getContainerComponent(TVoucherInvoiceLine, 'SaleId = ' + IntToStr(ID)));
end;


function TVoucherInvoice.LockTrans(var ErrMsg: String): Boolean;
begin
  result:= inherited LockTrans(ErrMsg);
  if not result then exit;
    if not (userlock.Lock('tblvouchers' , 0, LockGroupName)) then begin
        {alter the lock message for the locked record
        the locked record can be the current record, any of the BO record, or the parent record}
        ErrMsg := Replacestr(ReplaceStr(ReplaceStr(userlock.LockMessage, 'Unable to update data.' , 'Unable to make/Edit voucher.' ) , 'this record' , 'Vouchers') , 'Record' , 'Vouchers');
        Result:= False;
    end;

end;

procedure TVoucherInvoice.MakeVouchers(const Sender: TBusObj;
  var Abort: Boolean);
begin
  if not(Sender is TVoucherInvoiceLine) then exit;

  if TVoucherInvoiceLine(Sender).Isvoucher then
      if (TVoucherInvoiceLine(Sender).Voucherno <> '') then begin
          if TVoucherInvoiceLine(Sender).Voucher.count=0 then begin
            TVoucherInvoiceLine(Sender).Voucher.New;
            TVoucherInvoiceLine(Sender).Voucher.Voucherno := TVoucherInvoiceLine(Sender).Voucherno;
            TVoucherInvoiceLine(Sender).Voucher.Clientid := Clientid;
            TVoucherInvoiceLine(Sender).Voucher.Classid := SaleClassId;
            TVoucherInvoiceLine(Sender).Voucher.Isissued :=True;
            TVoucherInvoiceLine(Sender).Voucher.Saleid := ID;
          end else begin
          end;
          TVoucherInvoiceLine(Sender).Voucher.Value := TVoucherInvoiceLine(Sender).TotalLineAmountInc;
          TVoucherInvoiceLine(Sender).Voucher.Dateissued := Self.SaleDate;
          TVoucherInvoiceLine(Sender).Voucher.postdb;
          TVoucherInvoiceLine(Sender).Voucher.Save;
      end;
end;

function TVoucherInvoice.Save: Boolean;
begin
  postdb;
  result := inherited Save;
  if not result then Exit;
  Lines.IterateRecords(MakeVouchers);
end;

{ TVoucherCashSale }

function TVoucherCashSale.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then Exit;
  IsCashSale := True;
  IsPOS := True;
  EOP_POS := True;
  IsVoucher := True;
end;

function TVoucherCashSale.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforePost(Sender);
  if not result then Exit;
end;

procedure TVoucherCashSale.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
end;

function TVoucherCashSale.GetLines: TTransLineBase;
begin
  result := GetSaleLines;
end;

function TVoucherCashSale.GetSaleLines: TSalesLineBase;
begin
  result:= GeTVoucherCashSaleslines;
end;

function TVoucherCashSale.GeTVoucherCashSaleslines: TVoucherCashSaleLine;
begin
  result := TVoucherCashSaleLine(getContainerComponent(TVoucherCashSaleLine, 'SaleId = ' + IntToStr(ID)));
end;


function TVoucherCashSale.LockTrans(var ErrMsg: String): Boolean;
begin
  result:= inherited LockTrans(ErrMsg);
  if not result then exit;
    if not (userlock.Lock('tblvouchers' , 0, LockGroupName)) then begin
        {alter the lock message for the locked record
        the locked record can be the current record, any of the BO record, or the parent record}
        ErrMsg := Replacestr(ReplaceStr(ReplaceStr(userlock.LockMessage, 'Unable to update data.' , 'Unable to make/Edit voucher.' ) , 'this record' , 'Vouchers') , 'Record' , 'Vouchers');
        Result:= False;
    end;

end;

procedure TVoucherCashSale.MakeVouchers(const Sender: TBusObj;
  var Abort: Boolean);
begin
  if not(Sender is TVoucherCashSaleLine) then exit;

  if TVoucherCashSaleLine(Sender).Isvoucher then
      if (TVoucherCashSaleLine(Sender).Voucherno <> '') then begin
          if TVoucherCashSaleLine(Sender).Voucher.count=0 then begin
            TVoucherCashSaleLine(Sender).Voucher.New;
            TVoucherCashSaleLine(Sender).Voucher.Voucherno := TVoucherCashSaleLine(Sender).Voucherno;
            TVoucherCashSaleLine(Sender).Voucher.Clientid := Clientid;
            TVoucherCashSaleLine(Sender).Voucher.Classid := SaleClassId;
            TVoucherCashSaleLine(Sender).Voucher.Isissued :=True;
            TVoucherCashSaleLine(Sender).Voucher.Saleid := ID;
          end else begin
          end;
          TVoucherCashSaleLine(Sender).Voucher.Value := TVoucherCashSaleLine(Sender).TotalLineAmountInc;
          TVoucherCashSaleLine(Sender).Voucher.Dateissued := Self.SaleDate;
          TVoucherCashSaleLine(Sender).Voucher.postdb;
          TVoucherCashSaleLine(Sender).Voucher.Save;
      end;
end;

function TVoucherCashSale.Save: Boolean;
begin
  postdb;
  result := inherited Save;
  if not result then Exit;
  Lines.IterateRecords(MakeVouchers);
end;


{ TVoucherCashSaleLine }
function TVoucherCashSaleLine.getVoucher: TVoucher;
begin
  result := TVoucher(getContainerComponent(TVoucher, 'VoucherNo=' + Quotedstr(VoucherNo)));
end;

function TVoucherCashSaleLine.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then Exit;
  if TVoucherCashSale(Owner).clonedId <> 0 then
    exit;
  IsVoucher   := True;
  if VouchernotoAdd = '' then
       Voucherno   := Inttostr(NextVoucherno(TERPConnection(Self.Connection.Connection)))
  else begin
    Voucherno   := VouchernotoAdd;
    VouchernotoAdd := '';
  end;
  ProductName := PART_VOUCHER;
  Productdescription := 'Voucher No: '+VoucherNo;
  QtySold     := 1;
  Qtyshipped  := 1;
  CreationDate:= Date;
  SendEvent(BusobjEvent_Event, BusobjEvent_AfterInsert, self);
end;
function TVoucherCashSaleLine.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterOpen(Sender);
  if not result then exit;
end;

function TVoucherCashSaleLine.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterPost(Sender);
  if not result then exit;
  if eof then exit;
  if (trim(voucherno) = '') and (self.ProductID < 1) and (Deleted =False) then begin
    Deleted:= True;
    PostDb;
  end;
end;

function TVoucherCashSaleLine.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoBeforePost(Sender);
  if not result then exit;
end;

procedure TVoucherCashSaleLine.DoFieldOnChange(Sender: TField);
var
  ErrMsg:String;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'VoucherNo') then begin
    if not(Generatingvouchers) then {when generating vouchers, its already validates}
      if not Validvoucherno(voucherno , ErrMsg , ID) then begin
        ResultStatus.AddItem(False, rsswarning, 0, ErrMsg+NL+NL+'Automatially allocated the next Available voucher Number. Please change it if required.');
        VoucherNo:= Inttostr(NextVoucherno(TERPConnection(Self.Connection.Connection)));
      end else begin
        Productdescription := 'Voucher No: '+VoucherNo;
      end;
  end;
end;

function TVoucherCashSaleLine.Generatingvouchers: Boolean;
begin
  result:= False;
  if assigned(Owner) then
    if owner is TVoucherCashSale then
      result:= TVoucherCashSale(Self.Owner).Generatingvouchers;
end;

function TVoucherCashSaleLine.getVouchernotoAdd: String;
begin
  result:= '';
  if assigned(Self.owner) then
    if self.owner is TVoucherCashSale then
      result:= TVoucherCashSAle(self.owner).VouchernotoAdd;
end;

procedure TVoucherCashSaleLine.OnDataIdChange(  const ChangeType: TBusObjDataChangeType);
begin
  inherited OnDataIdChange(ChangeType);
end;


procedure TVoucherCashSaleLine.setVouchernotoAdd(const Value: String);
begin
  if assigned(Self.owner) then
    if self.owner is TVoucherCashSale then
      TVoucherCashSAle(self.owner).VouchernotoAdd:= Value;
end;

function TVoucherCashSaleLine.ValidateData: Boolean;
begin
  result := inherited ValidateData;
  if not result then exit;

end;

function TVoucherCashSaleLine.Validvoucherno(const sVoucherNo:String; var errmsg:String;VoucherLineID:Integer):Boolean;
begin
      errmsg:= '';
      with GEtNewDataset('SELECT * FROM tblvouchers where voucherno = '+quotedStr(sVoucherNo), true) do try
        Open;
        result := recordcount = 0 ;
        if not result then begin
          errmsg:='Voucher:' + sVoucherNo +' is already issued to ' +tcdatautils.GetClientName(FieldByname('clientID').asInteger)+' on ' +FormatDateTime(FormatSettings.ShortDateformat , Fieldbyname('DateIssued').asDateTime )+chr(13)+chr(13);
          exit;
        end;

        if Active then close;
        SQL.clear;
        SQL.Add('Select * from tblsaleslines where SaleLineId <>  '+inttostr(ID) +' and voucherno = '+quotedstr(sVoucherNo) );
        open;
        result := recordcount = 0 ;
        if not result then begin
          errmsg:='Voucher:' + sVoucherNo +' is already issued in this sale';
          exit;
        end;


      finally
          if active then close;
          Free;
      end;
end;

end.

