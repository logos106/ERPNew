unit frmVoucherSale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmCashSale, ProgressDialog, ImgList, DB, Menus, AdvMenus, DNMAction,
  ActnList, DataState, DBAccess, MyAccess, ERPdbComponents, SelectionDialog,
  AppEvnts, MemDS, ExtCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  ERPDbLookupCombo, Shader, wwdbedit, StdCtrls, wwdblook, wwdbdatetimepicker,
  DBCtrls, DNMSpeedButton, Mask, DNMPanel , busobjvoucherSale,
  CashSaleBase,BusObjBase;

type
  TfmVoucherSale = class(TCashSaleBaseGUI)
    btnGroupVoucher: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGroupVoucherClick(Sender: TObject);
    procedure grdTransactionsEnter(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
  private
    VoucherCashSale :TVoucherCashSale;
    function VoucherNoRange(var VNOFrom, VNOto: int64;var VAmt :double;MaxVouchersCancreate:int64): Boolean;
    function voucherredeemed(const voucherno:String;const SaleID:Integer): Boolean;
    function SendPrintSMS: boolean;
    function SendPrintSMSSilent: boolean;
    function SendPrintEmail: boolean;
    function SendPrintEmailSilent: boolean;
  Protected
    procedure SetUserLocking;Override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); override;
    Function IstransLineLocked:Boolean; Override;
    function GetReportTypeID: integer; override;
    procedure NewTransBusObjinstance;override;

  public
    { Public declarations }
  end;


implementation

uses BusobjCash, FrmPOSInput, tcDataUtils,
  frmVoucehrNumberRangeEntry, tcConst,  VoucherLib, CommonLib,
  BusObjConst, FormFactory, frmMessage, frmMessageBase, frmReportingOptions,
  AppEnvironment, EmailUtils, SMSUtils, CorrespondenceObj ;

{$R *.dfm}

procedure TfmVoucherSale.btnGroupVoucherClick(Sender: TObject);
var
  VNOFrom, VNOto:int64;
  ctr:int64;
  vAmt :Double;
  ErrMsg:String;
  ErrMsgs:TStringList;
  VoucherValidate :TVoucherValidate;
  fiVouchersAdded:Integer;
  s:string;
  Procedure ShowallMsgs;
  begin
      InitMsgParams;
      PopupMsgParams.Msgcaption    :='Voucher Sale';
      PopupMsgParams.MsgText       := s+NL+NL+ErrMsgs.Text;
      PopupMsgParams.Msg1          := 'Failed To Create Vouchers';
      PopupMsgParams.Custombuttons :='"Ok"' ;
      PopupMsgParams.MsgHeight     :=450;
      PopupMsgParams.MsgWidth      :=825;
      TfmMessage.MsgDlg;
  end;
  function TrimMsg:String;
  begin
    if ErrMsgs.count >10 then
      Result:=ErrMsgs[0]+NL+
              ErrMsgs[1]+NL+
              ErrMsgs[2]+NL+
              ErrMsgs[3]+NL+
              ErrMsgs[4]+NL+
              ErrMsgs[5]+NL+
              ErrMsgs[6]+NL+
              ErrMsgs[7]+NL+
              ErrMsgs[8]+NL+
              ErrMsgs[9]+NL+
              'More....'
      else result :=ErrMsgs.text;

  end;
  Function Extrabutton:String;
  begin
    REsult:= '';
    if ErrMsgs.count >10 then result := 'Show All Warnings';
  end;
  Procedure Adderror;
  begin
(*            if StrCount(Nl, ErrMsgs) >10 then begin
              if pos('More.....',ErrMsgs)=0 then ErrMsgs := ErrMsgs +nl +'More.....';
              exit;
            end ;
            if ErrMsgs <> '' then ErrMsgs := ErrMsgs +nl;
            ErrMsgs := ErrMsgs + ErrMsg;*)
      ErrMsgs.add(errMsg);
  end;
begin
  inherited;
  ErrMsgs:=TStringList.create;
  try
    fiVouchersAdded:= 0;
    if VoucherCashSale.Lines.Count >= MaxRecordsToGenerate then begin
        MessageDlgXP_Vista('You can have a maximum of ' +inttostr(MaxRecordsToGenerate)+' records at a time.'+NL+
                          'This Voucher transaction already has '+inttostr(VoucherCashSale.lines.count)+'.'+NL+
                          'It is not possible to add any more vouchers to this transaction.'+NL+
                          'Please create a new transaction for it', mtWarning, [mbOK], 0);
        exit;
    end;
    if not VoucherNoRange(VNOFrom, VNOto , vAmt,MaxRecordsToGenerate- VoucherCashSale.Lines.Count) then exit;
    VoucherValidate :=TVoucherValidate.Create(Self);
    try
      VoucherValidate.connection := TERPConnection(tblMaster.Connection);
      VoucherValidate.Validvoucherno('_',VNOFrom , VNOto ,ErrMsg );
      DoShowProgressbar(VNOto-VNOFrom, WAITMSG);
      try
        VoucherCashSale.Generatingvouchers:= True;
        VoucherCashSale.DisableCalcOrderTotals := true;
        VoucherCashSale.Lines.ClearContainerListOnNew := false;
        try
          //for ctr:= VNOFrom to  VNOto do begin
          ctr:= VNOFrom;
          while ctr <= VNOto do begin
            //if VoucherCashSale.Validvoucherno(inttostr(ctr) , ErrMsg , 0) then begin
            if VoucherValidate.Validvoucherno(inttostr(ctr) ,VNOFrom , VNOto ,ErrMsg ) then begin
              VoucherCashSale.VouchernotoAdd :=inttostr(ctr);
              VoucherCashSale.Lines.New;
              VoucherCashSale.Lines.ProductName := PART_VOUCHER;
              VoucherCashSale.Lines.voucherno := inttostr(ctr);
              VoucherCashSale.Lines.UOMQtySold := 1;
              VoucherCashSale.Lines.UOMQtyShipped := 1;
              VoucherCashSale.Lines.TotalLineAmountInc :=vAmt;
              VoucherCashSale.Lines.PostDB;
              fiVouchersAdded:= fiVouchersAdded +1;
            end else begin
              AddError;
            end;
             doStepProgressbar('voucher No: ' +inttostr(ctr));
            ctr:= ctr+1;
          end;
        finally
          VoucherCashSale.Lines.ClearContainerListOnNew := true;
          VoucherCashSale.DisableCalcOrderTotals := false;
          VoucherCashSale.CalcOrderTotals;
          VoucherCashSale.Generatingvouchers:= False;
        end;
      finally
        DoHideProgressbar;
        if ErrMsgs.count >0 then begin
          if (fiVouchersAdded =0) then s:= 'None of the vouchers are created for the Range of ' + inttostr(VNOFrom)+' to ' + inttostr(VNOto) + '. ' (*+ NL+Nl+ ErrMsgs*)
          else s:= 'Following vouchers are not created for the Range of ' + inttostr(VNOFrom)+' to ' + inttostr(VNOto) (*+ Nl+ NL+ErrMsgs*);
          if MessageDlgXP_Vista(s + NL+NL+TrimMsg, mtWarning, [mbOK], 0 , nil, '','',False,nil,Extrabutton,'',400 ) = 100 then
            ShowallMsgs;
        end;
      end;
    finally
      freeandnil(VoucherValidate);
    end;
  finally
      freeandnil(ErrMsgs);
  end;
end;

procedure TfmVoucherSale.btnPrintClick(Sender: TObject);
var
  OptsForm: TfmReportingOptions;
  IsEnabled: boolean;
begin
  if not(SaveCashSAle) then exit;
  Self.CommitAndNotify;
  OptsForm := EmailOptsForm;//TfmReportingOptions.Create(nil);
  try
    OptsForm.ActionList.AddDivider('Print');
    OptsForm.ActionList.Add('Print' ,'Print a Voucher Sale',actPrintExecute, true, true);
    OptsForm.ActionList.Add('Preview', 'Preview a Voucher Sale', self.actPreviewExecute, true, true);
    OptsForm.ActionList.Add('Save PDF','Save a PDF Voucher Sale to your computer', SaveTransToPDF, true, true);

    OptsForm.ActionList.AddDivider('Email');
    if AppEnv.CompanyPrefs.EnableVoucherSalePrintEmail and ((VoucherCashSale.ContactEmail <> '') or (VoucherCashSale.Customer.Email <> '')) then begin
      OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without Voucher Sale', self.SendPrintEmailSilent, true, true);
    end
    else begin
      OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without Voucher Sale', self.SendPrintEmailSilent, true, false);
    end;
    OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without Voucher Sale', self.SendPrintEmail, true, true);

    OptsForm.ActionList.AddDivider('SMS');
    IsEnabled := AppEnv.CompanyPrefs.SMSEnabled and
       AppEnv.CompanyPrefs.EnableVoucherSalePrintSMS and
       ((VoucherCashSale.ContactMobile <> '') or (VoucherCashSale.Customer.Email <> ''));
    OptsForm.ActionList.Add('SMS', 'Just send SMS', self.SendPrintSMSSilent, true, IsEnabled);
    OptsForm.ActionList.Add('SMS (Edit)', 'Edit SMS before sending', self.SendPrintSMS, true, AppEnv.CompanyPrefs.SMSEnabled);

    OptsForm.ShowModal;
    CloseAfterPrint(OptsForm.CloseWhenDone);
  finally
    OptsForm.Free;
  end;
end;

function TfmVoucherSale.SendPrintEmail: boolean;
var
  recip: string;
begin

  recip := VoucherCashSale.ContactEmail;
  if recip = '' then
    recip := VoucherCashSale.Customer.Email;
  result := TCorrespondenceGui.EmailCustomer(recip,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.VoucherSalePrintEmailSubject, PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.VoucherSalePrintEmailText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger, false);

end;

function TfmVoucherSale.SendPrintEmailSilent: boolean;
var
  toEmail: string;
begin
  toEmail := VoucherCashSale.ContactEmail;
  if toEmail = '' then
    toEmail := VoucherCashSale.Customer.Email;

  result := TCorrespondenceGui.EmailCustomer(toEmail,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.VoucherSalePrintEmailSubject, PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.VoucherSalePrintEmailText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger,true);

end;

function TfmVoucherSale.SendPrintSMS: boolean;
var
  number: string;
begin
  result := false;
  number := GetOrAddMobileNumber;
  if number = '' then exit;

  result := TCorrespondenceGui.SMSCustomer(number,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.VoucherSalePrintSMSText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger);
end;

function TfmVoucherSale.SendPrintSMSSilent: boolean;
var
  toMobile: string;
begin
  toMobile := VoucherCashSale.ContactMobile;
  if toMobile = '' then
    toMobile := VoucherCashSale.Customer.Mobile;

  result := TCorrespondenceGui.SMSCustomer(toMobile,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.VoucherSalePrintSMSText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger, true);
end;

procedure TfmVoucherSale.DoBusinessObjectEvent(const Sender: TDatasetBusObj;  const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusobjEvent_Event) and (Value = BusobjEvent_AfterInsert) and (sender is TVoucherCashSaleLine) then begin
    if not VoucherCashSale.Generatingvouchers then
      TransTimerMsg('Next voucher number - ' + Quotedstr(TVoucherCashSaleLine(Sender).VoucherNo) +' - is automatically assigned to the voucher number of the newly added line.  Please change it if required',10);
  end
  else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_ClientID) then begin
    btnGroupVoucher.Enabled := VoucherCashSale.ClientId > 0;
  end;
end;


procedure TfmVoucherSale.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := True;
  inherited;
  CashBase.LogChangesOnSave := False;
  btnGroupVoucher.Enabled := false;
end;
procedure TfmVoucherSale.FormShow(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  for ctr:= 0 to tbldetails.fieldcount-1 do begin
    if sametext(tbldetails.fields[ctr].fieldname , tbldetailsvoucherno.fieldName) or
       sametext(tbldetails.fields[ctr].fieldname , tbldetailstotallineamountinc.fieldName) or
       sametext(tbldetails.fields[ctr].fieldname , tbldetailsProduct_Description.fieldName) then
      else begin
        grdTransactions.RemoveField(tbldetails.fields[ctr].fieldname);
        GuiPrefs.DbGridElement[grdTransactions].HideField(tbldetails.fields[ctr].fieldname);
      end;
  end;
  grdTransactions.AddField(tbldetailsvoucherno.fieldName);
  grdTransactions.AddField(tbldetailstotallineamountinc.fieldName);
  grdTransactions.AddField(tbldetailsProduct_Description.fieldName);
  chkInvoice.Visible := False;
end;

function TfmVoucherSale.GetReportTypeID: integer;
begin
  REsult:= 106;
end;

procedure TfmVoucherSale.grdTransactionsEnter(Sender: TObject);
begin
  inherited;
  grdTransactions.SetActiveField(tbldetailsvoucherno.FieldName);
end;
function TfmVoucherSale.voucherredeemed(const voucherno:String;const SaleID:Integer):Boolean;
begin
  with VoucherCashSale.GetNewDataSet('Select IsRedeemed from tblvouchers where VoucherNo = ' +quotedstr(VoucherNo) +' and saleId = ' + inttostr(SaleID) , true) do try
    result:= fieldbyname('IsRedeemed').AsBoolean;
  finally
    if active then close;
    free;
  end;
end;
function TfmVoucherSale.IstransLineLocked: Boolean;
begin
  Result := inherited IstransLineLocked;
  if result then exit;
  if voucherredeemed(VoucherCashSale.Lines.VoucherNo , VoucherCashSale.Id)  then begin
    result := True;
    LineLockMsg :='This is a progress payment record and the sales order of this payment is already converted to an invoice - cannot be deleted';
  end;
end;

procedure TfmVoucherSale.NewTransBusObjinstance;
begin
  Freeandnil(VoucherCashSale);
  VoucherCashSale :=TVoucherCashSale.Create(self);
  VoucherCashSale.Name:= 'VoucherCashSale';
  CashBase := TCashSale(VoucherCashSale);
  inherited;
end;

procedure TfmVoucherSale.SetUserLocking;
var
    ErrMsg :String;
begin
    if AccessLevel >=5 then exit;
    if keyID >0 then exit; // already done
      if not (userlock.Lock('tblvouchers' , 0, Cashbase.LockGroupName)) then begin
      ErrMsg := Replacestr(ReplaceStr(ReplaceStr(userlock.LockMessage, 'Unable to update data.' , 'Unable to make/Edit voucher.' ) , 'this record' , 'Vouchers') , 'Record' , 'Vouchers');
      AccessLevel := 5;
      CommonLib.MessageDlgXP_Vista(ErrMsg +NL+NL+GetFormClassDescription +' Access will be changed to read-only.', mtWarning, [mbOK], 0);
    end;
end;

Function TfmVoucherSale.VoucherNoRange(var VNOFrom, VNOto:int64;var VAmt :double;MaxVouchersCancreate:Int64):Boolean;
begin
    With TfmVoucehrNumberRangeEntry.Create(Self) do try
      color := Self.Color;
      VNOfrom := 0;
      VNOTo:= 0;
      NextVoucherno :=     voucherlib.NextVoucherno(TERPConnection(CashBase.connection.connection));
      MaxVoucherscount :=MaxVouchersCancreate;
      IF showModal = mrok then begin
        VNOfrom := Vouchernofrom;
        VNOTo:= VouchernoTo;
        VAmt:= Voucheramount;
      end;
      result := (Vnofrom<>0) and (VNoTo<>0) and (VAmt <> 0);
    finally
      Free;
    end;
end;
initialization
  RegisterClass(TfmVoucherSale);
  with FormFact do begin
    RegisterMe(TfmVoucherSale, 'TInvoicelistExpressGUI_*_Voucher=SaleID');
    RegisterMe(TfmVoucherSale, 'TNonERPSalesListGUI_*_Voucher=ERPTransId');
    RegisterMe(TfmVoucherSale, 'TSalesDashboardPnLdetailsGUI_*_Voucher=SaleID');
    RegisterMe(TfmVoucherSale, 'TSalesDashBoardTopTenSalesManDetailsGUI_*_Voucher=SaleID');
    RegisterMe(TfmVoucherSale, 'TSalesDashBoardTopTenProductsDetailsGUI_*_Voucher=SaleID');
    RegisterMe(TfmVoucherSale, 'TSalesDashBoardTopTenCustomersDetailsGUI_*_Voucher=SaleID');
    RegisterMe(TfmVoucherSale, 'TInvoiceListGUI_*_Voucher=SaleID');
    RegisterMe(TfmVoucherSale, 'TPnLEmployeereportGUI_*_Voucher=TransID');
  end;

end.

