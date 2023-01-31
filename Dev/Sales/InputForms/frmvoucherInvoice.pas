unit frmvoucherInvoice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Sales, ProgressDialog, ImgList, Wwdbgrid, DMComps, DB, Menus,
  AdvMenus, DNMAction, ActnList, DataState, DBAccess, MyAccess, ERPdbComponents,
  SelectionDialog, AppEvnts, ExtCtrls, MemDS, ComCtrls, Buttons, Wwdbigrd,
  Grids, ERPDbLookupCombo, Shader, StdCtrls, wwdblook, wwdbdatetimepicker,
  wwdbedit, DBCtrls, DNMSpeedButton, wwcheckbox, Mask, DNMPanel,
  busobjvouchersale, BusObjBase;

type
  TfmvoucherInvoice = class(TBaseSaleGUI)
    btnPayment: TDNMSpeedButton;
    btnGroupVoucher: TDNMSpeedButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    tblDetailsVoucherNo: TWideStringField;
    procedure btnGroupVoucherClick(Sender: TObject);
    procedure btnPaymentClick(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnPDFClick(Sender: TObject);
  private
     VoucherInvoice:TVoucherInvoice;
    function VoucherNoRange(var VNOFrom, VNOto: int64; var VAmt: double;
      MaxVouchersCancreate: Int64): Boolean;
    procedure CreatePayment;
    procedure InitcutPayment(Sender: TObject);
  Protected
    function GetReportTypeID: integer;Override;
    procedure CommitAndNotify;Override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); override;
    procedure SetDirty(ADirty : boolean);override;
    function Save4NewTrans: Boolean;override;
  public
    function SaveSalesRecord: boolean;Override;
  end;


implementation

uses VoucherLib, frmMessage, tcConst, frmMessageBase, CommonLib,
  frmVoucehrNumberRangeEntry, FormFactory, tcDataUtils, AppEnvironment,
  frmCustPayments, CommonFormLib , MessageInterface, BusObjConst;


{$R *.dfm}

procedure TfmvoucherInvoice.actPreviewExecute(Sender: TObject);
begin
  DisableForm;
  try
    if SaveSalesRecord then begin
      fbReportSQLSupplied :=   False;
      VoucherInvoice.Connection.CommitTransaction;
      try
        VoucherInvoice.Dirty:= false;
        inherited;
		    CloseAfterPrint;
      finally
        if not AppEnv.Employee.CloseOnPrint then
          self.BeginTransaction;
      end;
    end;
  finally
    EnableForm;
  end;

end;

procedure TfmvoucherInvoice.actPrintExecute(Sender: TObject);
var
  ReEnable: boolean;
begin
  ReEnable:= true;
  DisableForm;
  try
    if SaveSalesRecord then begin
        fbReportSQLSupplied :=   False;
        VoucherInvoice.Connection.CommitTransaction;
        VoucherInvoice.Dirty:= false;
        inherited;
        CloseAfterPrint;
    end;
  finally
    if ReEnable then
      EnableForm;
  end;
end;

procedure TfmvoucherInvoice.btnCompletedClick(Sender: TObject);
begin
  inherited;
  DisableForm;
  try
      if not SaveSalesRecord then Exit;
      VoucherInvoice.Connection.CommitTransaction;
      Close;
  finally
    EnableForm;
  end;
end;

function TfmvoucherInvoice.Save4NewTrans: Boolean;
begin
  Result := False;
  // If user does not have access to this form don't process any further
  DisableForm;
  try
    if VoucherInvoice.Dirty then begin
      case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
        mrYes:
          begin
            if SaveSalesRecord then begin
               CommitAndNotify;  // current record should be commited before inserting new reocrd
               Result := true;
            end else Exit;
          end;
        mrNo:
          begin
            // Cancel edits and Rollback changes
            RollbackTransaction;
            Result := true;
          end;
        mrCancel:
          begin
            Exit;
          end;
      end;
    end else begin
      REsult := True;
    end;
    inherited;
  finally
    EnableForm;
  end;
end;

function TfmvoucherInvoice.SaveSalesRecord: boolean;
begin
  result := True;
  try
    if FullBackOrder then
      if (VoucherInvoice.cleancustomer <> '') then begin
        VoucherInvoice.SaleDate := now;
        VoucherInvoice.Shipdate := now;
        VoucherInvoice.Saledatetime := now;
        VoucherInvoice.PostDB;
      end;

    lblProcessMessage.Caption := 'Saving....';
    lblProcessMessage.visible := true;
    Try
      SetControlFocus(btnCompleted);
      if AccessLevel >= 5 then begin
        VoucherInvoice.Dirty := False;
      end else begin
        if VoucherInvoice.Dirty then begin
          VoucherInvoice.ResultStatus.Clear;
            if VoucherInvoice.Save then begin
              VoucherInvoice.Dirty := false;
            end else begin
              Result := false;
            end;
        end;
      end;
    finally
      lblProcessMessage.visible := False;
    end;
  finally
    VoucherInvoice.ResultStatus.clear;
  end;
end;
procedure TfmvoucherInvoice.SetDirty(ADirty: boolean);
begin
  inherited;
  VoucherInvoice.Dirty:= ADirty;
end;

procedure TfmvoucherInvoice.CommitAndNotify;
var
  MsgObj: TMsgObj;
  ClientID: integer;
begin
  ClientID:= VoucherInvoice.ClientID;
  CommitTransaction;
  AfterCommit; // virtual method used in decendants
  Notify;

  MsgObj := TMsgObj.Create;
  MsgObj.SetAddress('TfmMarketingLead', 'InvoiceSaved');
  MsgObj.IntValue := ClientID;
  fMsgHandler.Send(MsgObj);
end;

procedure TfmvoucherInvoice.CreatePayment;
begin
  OpenERPForm('TfmCustPayments' , 0, nil, InitcutPayment);
end;
procedure TfmvoucherInvoice.InitcutPayment(Sender: TObject);
begin
  if sender is TfmCustPayments then

    TfmCustPayments(Sender).OpenForSalesId := VoucherInvoice.ID;
end;

procedure TfmvoucherInvoice.btnPaymentClick(Sender: TObject);
begin
  inherited;
  DisableForm;
  try
    if not SaveSalesRecord then Exit;
    VoucherInvoice.Connection.CommitTransaction;
    CreatePayment;
    Close;
  finally
    EnableForm;
  end;

end;

procedure TfmvoucherInvoice.btnPDFClick(Sender: TObject);
begin
  inherited;
  DisableForm;
  try
    if SaveSalesRecord then begin
        fbReportSQLSupplied :=   False;
        VoucherInvoice.Connection.CommitTransaction;
        VoucherInvoice.Dirty:= false;
        inherited;
		    CloseAfterPrint;
    end;
  finally
    EnableForm;
  end;

end;

function TfmvoucherInvoice.GetReportTypeID: integer;
begin
  Result := TemplateTypeID('Voucher');
end;

procedure TfmvoucherInvoice.btnGroupVoucherClick(Sender: TObject);
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
      ErrMsgs.add(errMsg);
  end;
begin
  inherited;
  ErrMsgs:=TStringList.create;
  try
    fiVouchersAdded:= 0;
    if VoucherInvoice.Lines.Count >= MaxRecordsToGenerate then begin
        MessageDlgXP_Vista('You can have a maximum of ' +inttostr(MaxRecordsToGenerate)+' records at a time.'+NL+
                          'This Voucher transaction already has '+inttostr(VoucherInvoice.lines.count)+'.'+NL+
                          'It is not possible to add any more vouchers to this transaction.'+NL+
                          'Please create a new transaction for it', mtWarning, [mbOK], 0);
        exit;
    end;
    if not VoucherNoRange(VNOFrom, VNOto , vAmt,MaxRecordsToGenerate- VoucherInvoice.Lines.Count) then exit;
    VoucherValidate :=TVoucherValidate.Create(Self);
    try
      VoucherValidate.connection := TERPConnection(tblMaster.Connection);
      VoucherValidate.Validvoucherno('_',VNOFrom , VNOto ,ErrMsg );
      DoShowProgressbar(VNOto-VNOFrom, WAITMSG);
      try
        VoucherInvoice.Generatingvouchers:= True;
        VoucherInvoice.DisableCalcOrderTotals := true;
        VoucherInvoice.Lines.ClearContainerListOnNew := false;
        try
          //for ctr:= VNOFrom to  VNOto do begin
          ctr:= VNOFrom;
          while ctr <= VNOto do begin
            //if VoucherInvoice.Validvoucherno(inttostr(ctr) , ErrMsg , 0) then begin
            if VoucherValidate.Validvoucherno(inttostr(ctr) ,VNOFrom , VNOto ,ErrMsg ) then begin
              VoucherInvoice.VouchernotoAdd :=inttostr(ctr);
              VoucherInvoice.Lines.New;
              VoucherInvoice.Lines.ProductName := PART_VOUCHER;
              VoucherInvoice.Lines.voucherno := inttostr(ctr);
              VoucherInvoice.Lines.TotalLineAmountInc :=vAmt;
              VoucherInvoice.Lines.PostDB;
              fiVouchersAdded:= fiVouchersAdded +1;
            end else begin
              AddError;
            end;
             doStepProgressbar('voucher No: ' +inttostr(ctr));
            ctr:= ctr+1;
          end;
        finally
          VoucherInvoice.Lines.ClearContainerListOnNew := true;
          VoucherInvoice.DisableCalcOrderTotals := false;
          VoucherInvoice.CalcOrderTotals;
          VoucherInvoice.Generatingvouchers:= False;
        end;
      finally
        DoHideProgressbar;
        if ErrMsgs.count >0 then begin
          if (fiVouchersAdded =0) then s:= 'None of the vouchers are created for the Range of ' + inttostr(VNOFrom)+' to ' + inttostr(VNOto) + '. '
          else s:= 'Following vouchers are not created for the Range of ' + inttostr(VNOFrom)+' to ' + inttostr(VNOto);
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
procedure TfmvoucherInvoice.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited;
  if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_ClientID) then begin
    btnGroupVoucher.Enabled := VoucherInvoice.ClientId > 0;
    btnPrepayment.Enabled := btnGroupVoucher.Enabled;
    btnPayment.Enabled := btnGroupVoucher.Enabled;
  end;
end;

procedure TfmvoucherInvoice.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := cafree;
end;

procedure TfmvoucherInvoice.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
  if ErrorOccurred then Exit;

  CanClose := false;
  if VoucherInvoice.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveSalesRecord then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          VoucherInvoice.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          btnClose.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;
end;

procedure TfmvoucherInvoice.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid:= False;
  VoucherInvoice := TVoucherInvoice.Create(Self);
  VoucherInvoice.Name:= 'InvoiceObj';
  VoucherInvoice.DoProductallocation := DoProductallocation;
  SaleBase := VoucherInvoice;
  inherited;
  VoucherInvoice.Connection := TMyDacDataConnection.Create(VoucherInvoice);
  TMyDacDataConnection(VoucherInvoice.Connection).MyDacConnection := MyConnection;
  btnGroupVoucher.Enabled := false;
  btnPrepayment.Enabled := false;
  btnPayment.Enabled := false;
end;

procedure TfmvoucherInvoice.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    bCreditCheckOn := AppEnv.CompanyPrefs.CreditCheckInv;
    inherited;
    VoucherInvoice.Load(KeyID);
    VoucherInvoice.Connection.BeginTransaction;
    if VoucherInvoice.count =0 then VoucherInvoice.New;
    VoucherInvoice.lines;
    OpenQueries;
  finally
    EnableForm;
    hideProgressbar;
  end;
end;

Function TfmvoucherInvoice.VoucherNoRange(var VNOFrom, VNOto:int64;var VAmt :double;MaxVouchersCancreate:Int64):Boolean;
begin
    With TfmVoucehrNumberRangeEntry.Create(Self) do try
      color := Self.Color;
      VNOfrom := 0;
      VNOTo:= 0;
      NextVoucherno :=     voucherlib.NextVoucherno(TERPConnection(VoucherInvoice.connection.connection));
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
  RegisterClassOnce(TfmvoucherInvoice);
  with FormFact do begin
    RegisterMe(TfmvoucherInvoice, 'TInvoiceListGUI_*_Invoice Voucher=SaleID');
    RegisterMe(TfmvoucherInvoice, 'TInvoicelistExpressGUI_*_Invoice Voucher=SaleID');
    RegisterMe(TfmvoucherInvoice, 'TNonERPSalesListGUI_*_Invoice Voucher=ERPTransId');
    RegisterMe(TfmvoucherInvoice, 'TSalesDashboardPnLdetailsGUI_*_Invoice Voucher=SaleID');
    RegisterMe(TfmvoucherInvoice, 'TSalesDashBoardTopTenSalesManDetailsGUI_*_Invoice Voucher=SaleID');
    RegisterMe(TfmvoucherInvoice, 'TSalesDashBoardTopTenProductsDetailsGUI_*_Invoice Voucher=SaleID');
    RegisterMe(TfmvoucherInvoice, 'TSalesDashBoardTopTenCustomersDetailsGUI_*_Invoice Voucher=SaleID');
  end;

end.


