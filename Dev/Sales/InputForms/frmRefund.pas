unit frmRefund;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 29/04/05  1.00.01 BJ   Bug Fixed : Fields 'Entered by' and 'entered at'
                        are not getting updated.
 12/08/05  1.00.02 BJ  Serialno object inroduced. Serialno fieldtype is changed to mediumtext
 24/08/05  1.00.04 DSP  Added RegisterClass for TRefundGUI.
 25/08/05  1.00.05 BJ   HireQty is removed from this form - Asked by ward                \
 26/08/05  1.00.06 IJB  Added UserLOck code to Save to lock the client record
                        (to prevent Lock wait timeout).
 19/12/05  1.00.08  AL   Removed "Instance", added RegisterClass  *Task306*
 06/01/06  1.00.09 IJB  Added foreign currency fields to tblMaster as these are
                        used on BaseTransForm.
 17/02/06  1.00.10 DSP  Changed cmdEmailClick to use the email object in place
                        of the TNMSMTP component.
 15/08/06  1.00.11 BJ   Print options does the validations only if the form is not in readonly state
                        as the form is non-editable when readonly, so nothing will be changed
 18/09/06  1.00.12 BJ   business object introduced
}

{$I ERP.inc}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Cash, DB,   StdCtrls, wwcheckbox, Buttons, DNMSpeedButton, wwdbdatetimepicker,
  wwdblook, DBCtrls, Mask, ExtCtrls, DNMPanel, Wwdbigrd,
  Grids, Wwdbgrid, ActnList, Menus, AdvMenus, ImgList, SelectionDialog, AppEvnts,
  BusObjBase, {Psock, NMsmtp,}  wwdbedit, MemDS, DBAccess, MyAccess,ERPdbComponents,
  DataState, IdSMTP , BusobjCash, Shader, ProgressDialog, ERPDbLookupCombo,
  DNMAction;

type
  TRefundGUI = class(TBaseCashGUI)
    tblDetailsIsQuote: TWideStringField;
    tblMasterSaleDateTime: TDateTimeField;
    cmdFax: TDNMSpeedButton;
    Bevel3: TBevel;
    bvelFX: TBevel;
    btnselectSale: TDNMSpeedButton;
    actSelectSales: TDNMAction;
    tblDetailsRefundedSalesLineID: TIntegerField;
    btnCheque: TDNMSpeedButton;
    btnSignature: TDNMSpeedButton;
    actSignature: TAction;
    tblMasterClientSignature: TBlobField;
    tblMasterSignatureTime: TDateTimeField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCompletedClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure chkInvoiceClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure cmdEmailClick(Sender: TObject);
    procedure cmdFaxClick(Sender: TObject);
    procedure edtCompanySearchFilterKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure actSplitPayUpdate(Sender: TObject);
    procedure grdTransactionsDblClick(Sender: TObject);
    procedure btnDepositClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure actSplitPayExecute(Sender: TObject);
    procedure btnCashDrawerClick(Sender: TObject);
    procedure actCustomerContactsExecute(Sender: TObject);
    procedure cboCurrentStatusNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure btnPDFClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnselectSaleClick(Sender: TObject);
    procedure actSelectSalesUpdate(Sender: TObject);
    procedure actSelectSalesExecute(Sender: TObject);
    procedure pnlDetailEnter(Sender: TObject);
    procedure cboPaymentMethodChange(Sender: TObject);
    procedure btnChequeClick(Sender: TObject);
    procedure actSignatureExecute(Sender: TObject);
    procedure actSignatureUpdate(Sender: TObject);

  private
    fbGrdDblClickSerials :Boolean;
    saleIdtoRefund:Integer;
    fbChoosingsale:Boolean;
    procedure CheckInvoiceTypeState;
    Function SaveRefund :Boolean;
    procedure MatrixshownCallBack(Const Sender: TBusObj; var Abort: boolean);
    function SendPrintSMS: boolean;
    function SendPrintSMSSilent: boolean;
    function SendPrintEmail: boolean;
    function SendPrintEmailSilent: boolean;
    procedure ApplySaletoRefund(Sender: TwwDBGrid);
    procedure inintSoldnRefundQtyofSales(Sender: TObject);
    procedure SelectSalesLinesToRefund(Sender: twwDBGrid);
    procedure LockGridforRestrictedRefund;
    procedure DoOnChequeAfterShow(Sender: TObject);
    Procedure Deletecheque(Sender:TObject);
  protected
    function EmailTransaction(const RecipientAddress :String ='';ASilent: boolean=True; ASecret : boolean=True): boolean;Override;
    function ReturnType:String;Override;
    function GetReportTypeID: integer; override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);override;
    Function Matrixshown:Boolean;Override;
    procedure DoOnClientchange;Override;
    procedure CommitAndNotify;override;
    procedure NewTransBusObjinstance;override;
    function IstransLineLocked: Boolean; Override;
    procedure Locksales;Override;
    procedure MakeCheque;
    function SaveTrans:Boolean ; Override;
    procedure SetUserLocking;Override;
    Procedure NewTransBusObjRecord(aId: integer = 0); Override;
    Procedure LoadTransRec; Override;
    function Save4NewTrans: Boolean;Override;
  public
    bIgnoreEvent: boolean;
    bRefundSerials: boolean;
    Refund: TRefundSale;
    class procedure CloseMe; override;
    Procedure UpdateMe(Const Cancelled: Boolean;        Const aObject: TObject = Nil); Override;
  end;

implementation

{$R *.dfm}
uses
  FormFactory,  CommonDbLib, BaseTransForm,
  BusObjPrintDoc, DateUtils, CommonLib,  FaxObj,
  BaseInputForm, DNMLib, BusObjConst,
  BusobjSaleBase, AppEnvironment, tcDataUtils, BusObjTrans, BusObjClient,
  PaymentsLibGUI, FastFuncs, MySQLConst, frmAllocation, tcTypes, frmSimpleTypes,
  BusObjSimpleTypes, tcConst, frmReportingOptions, SMSUtils,
  EmailUtils, CommonFormLib, SoldnRefundQtyofSales, frmCheque,
  CorrespondenceObj, SystemLib, busobjExpenses,frmSignatureEdit, EmailExtraUtils,
  DbSharedObjectsObj, BusObjSales, BusObjPOSSale;


Function TRefundGUI.SaveRefund :Boolean;
begin
    Result := True;
    if not fbPaymentLock then begin
        if Refund.Dirty then begin
          Refund.ResultStatus.Clear;
          Refund.PostDB;
          Refund.Lines.PostDB;
          Refund.Salespayments.PostDB;
          //if Refund.ValidateData then begin
            if Refund.Save then begin
              Refund.Dirty := false;
            end else begin
              Result := false;
              Exit;
            end;

        end;
        Result := True;
    end;
end;

function TRefundGUI.SaveTrans: Boolean;
begin
  REsult := SaveRefund;
end;

function TRefundGUI.SendPrintEmail: boolean;
var
  recip: string;
begin

  recip := Refund.ContactEmail;
  if recip = '' then
    recip := Refund.Customer.Email;
  result := TCorrespondenceGui.EmailCustomer(recip,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.RefundPrintEmailSubject, PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.RefundPrintEmailText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger);

end;

function TRefundGUI.SendPrintEmailSilent: boolean;
var
  toEmail: string;
begin
  toEmail := Refund.ContactEmail;
  if toEmail = '' then
    toEmail := Refund.Customer.Email;

  result := TCorrespondenceGui.EmailCustomer(toEmail,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.RefundPrintEmailSubject, PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.RefundPrintEmailText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger, true);
end;

function TRefundGUI.SendPrintSMS: boolean;
var
  number: string;
begin
  result := false;
  number := GetOrAddMobileNumber;
  if number = '' then exit;

  result := TCorrespondenceGui.SMSCustomer(number,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.RefundPrintSMSText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger);
end;

function TRefundGUI.SendPrintSMSSilent: boolean;
var
  toMobile: string;
begin
  toMobile := Refund.ContactMobile;
  if toMobile = '' then
    toMobile := Refund.Customer.Mobile;

  result := TCorrespondenceGui.SMSCustomer(toMobile,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.RefundPrintSMSText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger, true);
end;

procedure TRefundGUI.SetUserLocking;
begin
  inherited;

end;

procedure TRefundGUI.UpdateMe(const Cancelled: Boolean; const aObject: TObject);
begin
  if Cancelled then Exit;
(*    if Assigned(LastComboAccessed) then begin
      LastComboAccessed.Text := '';
      closenopendb(LastComboAccessed.LookupTable);
      Exit;
    end;
    end;*)
  inherited UpdateMe(cancelled, aObject);
  if (aObject is TfmCheque) then begin
    if not Cancelled then begin
      Refund.ChequeNumber := TfmCheque(aObject).ChequeObj.SupplierInvoiceNumber;
      if Refund.PayMethod <> CHEQUE then begin
        Refund.PayMethod := CHEQUE;
        cboPaymentMethod.Refresh;
      end;
      Refund.PostDb;
      self.CommitAndNotify;
      self.BeginTransaction;
    end;
  end;

end;

procedure TRefundGUI.CommitAndNotify;
begin
  CommitTransaction;
  AfterCommit; // virtual method used in decendants
  Notify;
end;

procedure TRefundGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TRefundGUI.btnCompletedClick(Sender: TObject);
begin
  DisableForm;
  try
    if SaveRefund then begin
      CommitAndNotify;
      Close;
    end;
  finally
    EnableForm;
  end;
end;

function TRefundGUI.GetReportTypeID: integer;
begin
  Result := 22;
end;

procedure TRefundGUI.FormShow(Sender: TObject);
begin
  inherited;
  // If any errors occurred in base then exit.
stepProgressbar;
try
  if Self.ErrorOccurred then Exit;

  if KeyId > 0 then  begin
    if Empty(cboPaymentMethod.Text) then chkInvoice.Checked := true;

  end else chkInvoice.Checked := true;

  CheckInvoiceTypeState;

  GuiPrefs.DbGridElement[grdTransactions].RemoveFields('Shipped,UnitOfMeasureShipped');
finally
  hideProgressbar;
  ShowGridLockMsg;
end;
end;

procedure TRefundGUI.actPreviewExecute(Sender: TObject);
begin
  DisableForm;
  try
    if SaveRefund then Begin
      CommitAndNotify;
      try
        fbReportSQLSupplied :=   False;

        Refund.Dirty:= false;
        inherited;
        //CloseAfterPrint;
      except
        on E:Exception do begin
          Commonlib.MessageDlgXP_Vista('Print failed.' + CHR(13) + CHR(13) + E.Message, mtWarning, [mbok], 0);
          Self.BeginTransaction;
        end;
      end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TRefundGUI.actPrintExecute(Sender: TObject);
begin
  DisableForm;
  try
    if not SaveRefund then Exit;
    CommitAndNotify;
    try
      fbReportSQLSupplied := False;

      Refund.Dirty := False;
      inherited;
//      CloseAfterPrint;
    except
      on E:Exception do begin
        Commonlib.MessageDlgXP_Vista('Print failed.' + CHR(13) + CHR(13) + E.Message, mtWarning, [mbok], 0);
        Self.BeginTransaction;
      end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TRefundGUI.DoOnChequeAfterShow(Sender: TObject);
var
 cheque: TfmCheque;
begin
  if not (Sender is TfmCheque) then exit;
  cheque := TfmCheque(Sender);
  cheque.ChequeObj.SupplierId := Refund.CustomerID;
  cheque.ChequeObj.IsREfundCheque := TRue;
  cheque.ChequeObj.RefundGlobalref := Refund.GlobalRef;
  cheque.ChequeObj.Comments := 'Payment for Refund Number: ' + Refund.DocNumber;
  cheque.ChequeObj.PostDB;
  while cheque.ChequeObj.Lines.Count > 0 do
    if not cheque.ChequeObj.Lines.Delete then break;
  cheque.ChequeObj.Lines.New;
  cheque.ChequeObj.Lines.AccountName := Refund.GLAccountName;
  cheque.ChequeObj.Lines.LineTaxCode := AppEnv.RegionalOptions.TaxCodeNoTax;
  cheque.ChequeObj.Lines.LineCostInc := - Refund.TotalAmountInc;
  cheque.ChequeObj.Lines.ProductDescription:= 'Refund Number ' + Refund.DocNumber;
  cheque.ChequeObj.Lines.PostDb;

end;

Procedure TRefundGUI.DoOnClientchange;
begin
  if (Empty(cboClientR.Text)) or (Refund.CustomerID =0) then Exit;
  inherited;
  cboTermsQry.Locate('Terms', Refund.TermsName, [loCaseInsensitive, loPartialKey]);
  DeleteEmptyLines(txtClientDetails);
  CheckInvoiceTypeState;
end;

procedure TRefundGUI.cboCurrentStatusNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin

  If Appenv.AccessLevels.GetEmployeeAccessLevel('FnCanCreateSalesStatus') <>
      1 Then Begin
      MessageDlgXP_Vista('You are not Allowed to Create New Status',
        mtInformation, [mbOK], 0);
      Accept := False;
      Exit;
  End;
  inherited cboCurrentStatusNotInList(Sender,LookupTable,NewValue,Accept);
end;

procedure TRefundGUI.cboPaymentMethodChange(Sender: TObject);
begin
  inherited;
 (* if not cboPaymentMethod.Focused then
    exit;
  if cboPaymentMethod.Text = CHEQUE then begin
    Refund.paymethod :=cboPaymentMethod.Text;
    Refund.PostDB;
    self.MakeCheque;
  end;*)
end;

procedure TRefundGUI.CheckInvoiceTypeState;
begin
  If (Refund.AccessManager.AccessLevel  in [1..3]) then begin
    Refund.InvoiceRefund := chkInvoice.Checked;
    //btnCheque.Enabled := TransAccessLevel<5;
    if  chkInvoice.Checked then begin
      cboAccountQry.Filter   := '[AccountType] = ''AR''';
      cboAccountQry.Filtered := true;
      chkInvoice.Enabled     := true;
      lblInvoice.Enabled     := true;
      cboAccountQry.Locate('AccountID', Refund.GLAccountID, [loCaseInsensitive]);
      cboAccount.LookupValue := Refund.GLAccountname;
      cboAccount.Enabled := true;
      cboAccount.Visible := (cboAccountQry.RecordCount > 1);
      lblAccount.Visible := cboAccount.Visible;
    end else begin
      cboAccount.Visible     := true;
      lblAccount.Visible     := cboAccount.Visible;
      cboAccountQry.Filtered := false;
      cboAccountQry.Filter   := '';
      chkInvoice.Enabled     := false;
      lblInvoice.Enabled     := false;
      chkInvoice.Checked     := false;
      cboAccount.Enabled     := false;
    end;
  end
  else begin
    btnCheque.Enabled := false;
    btnselectSale.Enabled := false;
  end;
  btnselectSale.Enabled := (TransAccessLevel<5) and (AccessLevel<5) ;
end;

procedure TRefundGUI.chkInvoiceClick(Sender: TObject);
begin
  inherited;
  if Sysutils.SameText(Screen.activecontrol.name , 'chkInvoice') then CheckInvoiceTypeState;
end;

procedure TRefundGUI.Deletecheque(Sender: TObject);
//var
//  ChequeObj :TCheque;
begin
     if btnCheque.tag <=0 then exit;
     if MessageDlgXP_VIsta('Are you Sure You want to Delete this Refund and its Cheque # ', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;

     Refund.Lines.DeleteAll;
     Refund.CalcOrderTotals;
     btnCompleted.click;



end;

procedure TRefundGUI.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_SpecialPrice) and (fbChoosingsale) then Exit; // ignore price override msg
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TSalesPayments         then TSalesPayments(Sender).DataSet     := qryPayments;
    end else if (EventType = BusObjEvent_Change) and
            ((Value = BusObjEventVal_QtyShipped) or (Value = BusObjEventVal_LineDeleted)) then begin
            if fbChoosingsale = False then begin
              Refund.Lines.PostDB;
              TfmAllocation.DoBinBatchform(Refund.Lines.PQA, Self);
            end;
    end;
end;


procedure TRefundGUI.FormCreate(Sender: TObject);
begin
  fbChoosingsale:=False;
  saleIdtoRefund:= 0;
  AllowCustomiseGrid := True;
  inherited;
  bIgnoreEvent := false;
  bRefundSerials := false;
end;

procedure TRefundGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if ErrorOccurred then Exit;
  CanClose := false;
  if Refund.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:if SaveRefund then CanClose := true;
      mrNo:begin
          RollbackTransaction;
          Refund.Dirty := false;
          CanClose := true;
        end;
      mrCancel:CanClose := false;
    End;
  end else begin
    CanClose := true;
  end;

end;

procedure TRefundGUI.cmdEmailClick(Sender: TObject);
var
  ReportType, CustomerName: string;
  InvoiceNumber: string;
  qryEmailedList: TERPQuery;
  TransactionID, UserID, TransactionDescription: string;
  EmailDate: TDateTime;
  Emailed:Boolean;
  Corres: TCorrespondenceGui;
  lSilent, lSecret : boolean;
begin
  Emailed:=False;
  DisableForm;
  try
    if not SaveRefund then Exit;
    CommitAndNotify;
    try
      qryEmailedList := TERPQuery.Create(nil);
      qryEmailedList.Options.FlatBuffers := True;
      try
        ReportType := 'Refund';
        CustomerName := tblMaster.FieldByName('CustomerName').AsString;
        InvoiceNumber := tblMaster.FieldByName('InvoiceDocNumber').AsString;

        Corres := TCorrespondenceGui.Create;
        try
          lblEmailMsg.Caption := 'Emailing, ' + WAITMSG;
          lblEmail.Show;

          // Disable buttons before sending email
          btnNext.Enabled := false;
          btnCompleted.Enabled := false;
          btnClose.Enabled := false;
          btnPreview.Enabled := false;
          btnPrint.Enabled := false;
          cmdEmail.Enabled := false;

          inherited;

          Corres.RecipientList := GetContactEmails(tblMaster.FieldByName('ClientID').AsInteger,'MainContactForRefund');

          Corres.Subject := 'Refund' + ' #' + InvoiceNumber + ' for ' + CustomerName;
          LoadTemplate(true, true);

          lblEmailMsg.Caption := 'Emailing, ' + WAITMSG;
          Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;
          Corres.CustomerId := tblMaster.FieldByName('ClientID').AsInteger;
          Corres.AttachmentList.Add(getOutGoingFileName('',' ' + ReportType + ' #' + InvoiceNumber, '.PDF'));

          if not EmailShortSendMode(lSilent, lSecret) then
            exit;

          if Corres.Execute(lSilent, lSecret) then begin
            Emailed:=True;

            TransactionID := tblMaster.FieldByName('InvoiceDocNumber').AsString;
            UserID := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
            EmailDate := Now;

            // ReportType already defined at start of procedure
            TransactionDescription := GetCompanyName + ' ' + ReportType + ' #' +
              tblMaster.FieldByName('InvoiceDocNumber').AsString + ' for ' + tblMaster.FieldByName('CustomerName').AsString;

            qryEmailedList.Connection := CommonDbLib.GetSharedMyDACConnection;
            qryEmailedList.Sql.Clear;
            qryEmailedList.Sql.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports (TransactionID, UserID, Date, ReportType, TransactionDescription) Values ("' +
              TransactionID + '","' + UserID + '", "' + FormatDateTime(MysqlDateFormat, EmailDate) + '", "' +
              ReportType + '", "' + TransactionDescription + '")');
            qryEmailedList.Execute;
          end;
        finally
          // Enable buttons after email has been sent
          lblEmail.Hide;
          btnNext.Enabled := true;
          btnCompleted.Enabled := true;
          btnClose.Enabled := true;
          btnPreview.Enabled := true;
          btnPrint.Enabled := true;
          cmdEmail.Enabled := true;
          ReportToPrint := '';
          DeleteFiles( Commonlib.TempDir , '*.PDF');
          FreeandNil(qryEmailedList);
          Corres.Free;
        end;

      except
        CommonLib.MessageDlgXP_Vista('There was an error sending email', mtWarning, [mbOK], 0);
      end;
    finally
      LogEmailed(Emailed , ReportType);
      closeAfterPrint(Emailed);
    end;

  finally
    EnableForm;
  end;
end;

procedure TRefundGUI.cmdFaxClick(Sender: TObject);
var
  Fax: TFaxObj;
  FaxNo: string;
  Faxed:Boolean;
begin
  Faxed:= False;
  DisableForm;
  try
    inherited;
    if not SaveRefund then Exit;
    CommitAndNotify;
    try
      //FaxNo := GetClientFaxNumber(tblMaster.FieldByName('ClientID').AsInteger);
      FaxNo := Refund.Customer.Faxnumber;

      if Empty(FaxNo) then begin
        CommonLib.MessageDlgXP_Vista(tblMaster.FieldByName('CustomerName').AsString + ' does not have an Fax Number to Send to.' +
          #13 + #10 + #13 + #10 + 'Please Review Customer information to Add an Fax Number.', mtWarning, [mbOK], 0);
      end else begin
        lblEmail.Visible := true;
        lblEmailMsg.Caption := 'Adding to Fax Spool...';
        fsFax          := true;
        LoadTemplate(true, true, true, 'Invoice_' + tblMasterGlobalRef.AsString);
        Fax := TFaxObj.Create;

        try
          Fax.AddToFaxSpool(tblMaster.FieldByName('EmployeeName').AsString, tblMaster.FieldByName('CustomerName').AsString,
            FaxNo, 'Invoice', tblMaster.FieldByName('GlobalRef').AsString, '', ExtractFilePath(ParamStr(0)) + 'IMG0001.BMP', Now());
          Faxed:= True;
        finally
          FreeandNil(Fax);
        end;

        lblEmail.Visible := false;
        DeleteFiles(ExtractFilePath(ParamStr(0)), '*.BMP');
      end;
    finally
      LogFaxed(Faxed , ReportToPrint);
      ReportToPrint:= '';
      closeAfterPrint(Faxed);
    end;

  finally
    EnableForm;
  end;
end;

procedure TRefundGUI.edtCompanySearchFilterKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  inherited;
  //
end;

function TRefundGUI.EmailTransaction(const RecipientAddress :String ='';ASilent: boolean=True; ASecret : boolean=True): boolean;
var
  ReportType, CustomerName: string;
  InvoiceNumber: string;
  qryEmailedList: TERPQuery;
  TransactionID, UserID, TransactionDescription: string;
  EmailDate: TDateTime;
  Corres: TCorrespondenceGui;
  Recipients : string;
begin
  reportToPrint := '';
  result:=False;
  if not SaveRefund then Exit;
  CommitAndNotify;
  try
    qryEmailedList := TERPQuery.Create(nil);
    qryEmailedList.Options.FlatBuffers := True;
    try
      ReportType := 'Refund';
      CustomerName := tblMaster.FieldByName('CustomerName').AsString;
      InvoiceNumber := tblMaster.FieldByName('InvoiceDocNumber').AsString;

      Corres := TCorrespondenceGui.Create;
      try
        Recipients := GetContactEmails(tblMaster.FieldByName('ClientID').AsInteger, 'MainContactForRefund');
        if RecipientAddress <> '' then
          Recipients := AddEmailToList(RecipientAddress, RecipientAddress);

        // Corres.RecipientList := RecipientAddress;
        Corres.RecipientList := Recipients;
        lblEmailMsg.Caption := 'Emailing, ' + WAITMSG;
        lblEmail.Show;
        Corres.Subject := ReportType + ' #' + InvoiceNumber + ' for ' + CustomerName;


        inherited;

        LoadTemplate(true, true);
        RenameFile(SystemLib.WinTempDir + 'EmailReport.pdf',SystemLib.WinTempDir + 'Refund.pdf');

        lblEmailMsg.Caption := 'Emailing, ' + WAITMSG;

        Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;
        Corres.CustomerId := tblMaster.FieldByName('ClientID').AsInteger;
        Corres.AttachmentList.Add(SystemLib.WinTempDir + 'Refund.pdf');
        if Corres.Execute(ASilent, ASecret) then begin
          result := True;

          TransactionID := tblMaster.FieldByName('InvoiceDocNumber').AsString;
          UserID := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
          EmailDate := Now;

          // ReportType already defined at start of procedure
          TransactionDescription := GetCompanyName + ' ' + ReportType + ' #' +
            tblMaster.FieldByName('InvoiceDocNumber').AsString + ' for ' + tblMaster.FieldByName('CustomerName').AsString;

          qryEmailedList.Connection := CommonDbLib.GetSharedMyDACConnection;
          qryEmailedList.Sql.Clear;
          qryEmailedList.Sql.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports (TransactionID, UserID, Date, ReportType, TransactionDescription) Values ("' +
            TransactionID + '","' + UserID + '", "' + FormatDateTime(MysqlDateFormat, EmailDate) + '", "' +
            ReportType + '", "' + TransactionDescription + '")');
          qryEmailedList.Execute;
        end;
      finally
        // Enable buttons after email has been sent
        lblEmail.Hide;

//        DeleteFiles( Commonlib.TempDir , '*.PDF');
        DeleteFile(SystemLib.WinTempDir + 'Refund.pdf');
        FreeandNil(qryEmailedList);
        Corres.Free;
        ReportToPrint := '';
      end;
    except
      CommonLib.MessageDlgXP_Vista('There was an error sending email', mtWarning, [mbOK], 0);
    end;
  finally
    LogEmailed(result , ReportType);
    self.BeginTransaction;
  end;
end;

class procedure TRefundGUI.CloseMe;
begin
  inherited;
  if FormStillOpen('TRefundGUI') then begin
      TRefundGUI(FindExistingComponent('TRefundGUI')).Close;
      Application.ProcessMessages;
  end;
end;

procedure TRefundGUI.FormDestroy(Sender: TObject);
begin
  //FreeAndNil(Refund);
  Refund:= nil;
  self.CashBase := nil;
  inherited;
end;

function TRefundGUI.Save4NewTrans: Boolean;
begin
  Result := False;
  DisableForm;
  try
    if ErrorOccurred then Exit;

    if Refund.Dirty then begin
      case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
        mrYes:
          if SaveRefund then begin
            CommitAndNotify;  // current record should be commited before inserting new reocrd
            Result := True;
          end;
        mrNo: begin
            RollbackTransaction;
            Result := true;
        end;
        mrCancel:
            Exit;
      end;
    end else begin
      REsult := True;
    End;
  finally
    EnableForm;
  end;
end;

procedure TRefundGUI.btnPDFClick(Sender: TObject);
begin
  DisableForm;
  try
    if SaveRefund then Begin
      CommitAndNotify;
      try
        fbReportSQLSupplied :=   False;

        Refund.Dirty:= false;
        inherited;
        CloseAfterPrint;
      except
        on E:Exception do begin
            commonlib.MessageDlgXP_Vista('Export to PDF failed.' +CHR(13) +CHR(13) + E.Message , mtWarning, [mbok] , 0);
            self.BeginTransaction;
        end;
      end;
    end;
  finally
    EnableForm;
  end;

end;

procedure TRefundGUI.btnPrintClick(Sender: TObject);
var
  OptsForm: TfmReportingOptions;
  IsEnabled: boolean;
begin
  if not(SaveRefund) then exit;
  Self.CommitAndNotify;
  OptsForm := EmailOptsForm;//TfmReportingOptions.Create(nil);
  try
    OptsForm.ActionList.AddDivider('Print');
    OptsForm.ActionList.Add('Print', 'Print a refund', actPrintExecute, False, True);
    OptsForm.ActionList.Add('Preview', 'Preview a refund', self.actPreviewExecute, False, True);
    OptsForm.ActionList.Add('Save PDF', 'Save a PDF Quote to your computer', SaveTransToPDF, True, True);

    OptsForm.ActionList.AddDivider('Email');
    OptsForm.ActionList.Add('Email Refund', 'Email a copy of the refund', DoEmailTransaction, true, true);
    OptsForm.ActionList.Add('Email Silently', 'Email a copy of the refund silently', DoEmailTransactionSilentnSecret, true, true);
    OptsForm.ActionList.Add('Email Refund (Edit)', 'Edit email Message before sending, With a copy of the refund', DoEmailTransactionnonsilent, true, true);
    if AppEnv.CompanyPrefs.EnablerefundPrintEmail and ((Refund.ContactEmail <> '') or (Refund.Customer.Email <> '')) then begin
      OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without refund', self.SendPrintEmailSilent, true, true);
//      OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without Refund', self.SendPrintEmail, true, true);
    end
    else begin
      OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without refund', self.SendPrintEmailSilent, true, false);
//      OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without refund', self.SendPrintEmail, true, false);
    end;
    OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without refund', self.SendPrintEmail, true, true);
    OptsForm.ActionList.AddDivider('SMS');

    IsEnabled := AppEnv.CompanyPrefs.SMSEnabled and
       AppEnv.CompanyPrefs.EnableRefundPrintSMS and
       ((refund.ContactMobile <> '') or (refund.Customer.Email <> ''));
    OptsForm.ActionList.Add('SMS', 'Just send SMS', self.SendPrintSMSSilent, true, IsEnabled);
    OptsForm.ActionList.Add('SMS (Edit)', 'Edit SMS before sending', self.SendPrintSMS, true, AppEnv.CompanyPrefs.SMSEnabled);

    OptsForm.ShowModal;
    CloseAfterPrint(OptsForm.CloseWhenDone);
  finally
    OptsForm.Free;
  end;
end;

procedure TRefundGUI.btnselectSaleClick(Sender: TObject);
begin
  inherited;
  if REfund.Lines.ISEmpty =False  then exit;

end;

procedure TRefundGUI.actSplitPayUpdate(Sender: TObject);
begin
  inherited; // don;t remove inherited
  if not PaymentLock then begin
    chkInvoice.Enabled     := (REfund.PayMethod = '') and (REfund.SalesPayments.Count = 0);
    lblInvoice.Enabled     := (REfund.PayMethod = '') and (REfund.SalesPayments.Count = 0);
  end;
end;

procedure TRefundGUI.grdTransactionsDblClick(Sender: TObject);
begin
    fbGrdDblClickSerials := true;
    try
      if TField(grdTransactions.GetActiveField).FieldName = 'UnitofMeasureShipped' then
            DoBusinessObjectEvent(Refund.Lines, BusObjEvent_Change, BusObjEventVal_QtyShipped);
      inherited;
    finally
        fbGrdDblClickSerials := False;
    end;
end;

procedure TRefundGUI.MakeCheque;
var
 cheque: TfmCheque;
 cust: TCustomer;
 fiRefundChequeID :Integer;
begin
//  fiRefundChequeID := 0;
  try
    if Refund.TotalAmountInc = 0 then exit;
    if Refund.CustomerID < 1 then exit;
    if chkInvoice.Checked then begin
      MessageDlgXP_Vista('You have ticked "Invoice", can not create a refund Cheque when this is ticked.',mtInformation,[mbOk],0);
      exit;
    end;
    if not Refund.Save then
      exit;
    if Refund.ChequeNumber <> '' then begin
      { already have a cheque number against this refund .. }
      if MessageDlgXP_Vista('This Refund already has a Reference Number ' +
        'recordered against it, do you wish to create a Cheque for this Refund?',
        mtConfirmation, [mbYes,mbNo],0) = mrNo then
      exit;
    end
    else begin
      if MessageDlgXP_Vista('Do you wish to create a Cheque for this Refund?',
        mtConfirmation, [mbYes,mbNo],0) = mrNo then
      exit;
    end;
    cheque := TfmCheque(GetComponentByClassName('TfmCheque',false));
    if not Assigned(cheque) then exit;
    if not Refund.Customer.IsSupplier then begin
      { need to make this customer a supplier so we can pay them .. }
      cust := TCustomer.CreateWithNewConn(nil);
      try
        cust.Load(Refund.CustomerID);
        if cust.Lock then begin
          try
            cust.Supplier := true;
            cust.PostDb;
          finally
            cust.UnLock;
          end;
        end
        else begin
          MessageDlgXP_Vista('Unable to lock ' + cust.ClientName +
            ' for conversion to supplier: ' + cust.UserLock.LockMessage, mtWarning, [mbOk], 0);
          exit;
        end;
      finally
        cust.Free;
      end;
    end;

    { now the cheque ... }
    cheque.KeyID := 0;
    cheque.OnAfterShow := self.DoOnChequeAfterShow;
    cheque.AttachObserver(self);
    self.CommitAndNotify;
    cheque.ShowModal;
  finally
    fiRefundChequeID := RefundChequeID(Refund.Globalref);
    if fiRefundChequeID <> 0 then
      Userlock.Lock(TCheque.GetBusObjectTablename , fiRefundChequeID );
    self.BeginTransaction;
  end;
  if fiRefundChequeID >0 then self.Close;
end;

function TRefundGUI.Matrixshown: Boolean;
begin
  REsult := inherited Matrixshown;
  if not result then exit;
  Refund.Lines.Iteraterecords(MatrixshownCallBack);
end;
procedure TRefundGUI.MatrixshownCallBack(const Sender: TBusObj;var Abort: boolean);
begin
  if not (Sender is TRefundSaleLine) then exit;
  if (TRefundSaleLine(SendeR).QtyShipped <> 0) and (TRefundSaleLine(Sender).REfundQty = 0) then begin
    TRefundSaleLine(Sender).RefundQty := abs(TRefundSaleLine(Sender).QtyShipped);
    TRefundSaleLine(Sender).PostDB;
  end;
end;
procedure TRefundGUI.NewTransBusObjinstance;
begin
  if Self.ClassNameIs('TRefundGUI') then begin // Customer Return inherites from this form and has a different class
    Freeandnil(Refund);
    Refund := TRefundSale.Create(Self);
    Refund.Name:= 'Refund';
  end;
  CashBase := Refund;
  inherited;
end;

procedure TRefundGUI.NewTransBusObjRecord(aId: integer);
begin
  inherited;
  btnPayments.visible := (aid >0) and (Refund.hascheque);
end;

procedure TRefundGUI.pnlDetailEnter(Sender: TObject);
begin
  inherited;
  if AppEnv.CompanyPrefs.RestrictRefund  then begin
    if REfund.Lines.ISEmpty then begin
      MessageDlgXP_Vista('You have selected ''Enforce Refund Verification'' in the preference (Company Preference -> Sales -> General)'+#13+#10+'So please Select the Sales record to be refunded and you can only change the Quantity to be refunded', mtWarning, [mbOK], 0);
      SetControlFocus(btnselectSale);
      Exit;
    end;
  end;
  LockGridforRestrictedRefund;
end;

function TRefundGUI.ReturnType: String;
begin
  Result := 'Refund';
end;

procedure TRefundGUI.btnDepositClick(Sender: TObject);
begin
  inherited;
  PaymentsLibGUI.ShowDepositedListForm(CashBase.ID,'Refund');
end;

procedure TRefundGUI.btnCloseClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TRefundGUI.actSelectSalesExecute(Sender: TObject);
begin
  inherited;
  fbChoosingsale:= True;
  try
    OpenERPListFormSingleselectModal('TSalesToRefundListGUI' , ApplySaletoRefund , nil);
  finally
    fbChoosingsale:= False;
  end;
end;

procedure TRefundGUI.ApplySaletoRefund(Sender: TwwDBGrid);
var
  LinesAdded:Boolean;
  SaveLockLineFields: boolean;
  qry: TERPQuery;
  SalesBaseobj :TSalesBase;
  Function  initRefundfromSalesBaseobj:Boolean;
  begin
    result := True;
     if sender.Datasource.DataSet.fieldbyname('IsPOS').asBoolean then begin
        SalesBaseobj := TPosCashSale.create(nil);
     end else if sender.Datasource.DataSet.fieldbyname('IsCashSale').asBoolean then begin
      SalesBaseobj := TCashSale.create(nil);
     end else if sender.Datasource.DataSet.fieldbyname('IsInvoice').asBoolean then begin
      SalesBaseobj := TInvoice.create(nil);
     end else begin
      REsult := False;
     end;
     if result then
      SalesBaseobj.Load( saleIdtoRefund);
  end;
begin
  try
    //if sender.SelectedList.Count = 0 then exit;
     if sender.Datasource.DataSet.fieldbyname('SaleId').AsInteger = 0 then exit;
        //sender.Datasource.DataSet.GoToBookmark(Sender.SelectedList.Items[0]);

        if Refund.ClientId<> sender.Datasource.DataSet.fieldbyname('ClientID').AsInteger then
          Refund.ClientId := sender.Datasource.DataSet.fieldbyname('ClientID').AsInteger;
        Refund.PostDB;

        saleIdtoRefund := sender.Datasource.DataSet.fieldbyname('SaleId').AsInteger;
        SaveLockLineFields := LockLineFields;
        LockLineFields := false;
        qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
        if not initRefundfromSalesBaseobj then exit;
        try
          with qry do begin
              SQL.add('SELECT SL.SaleLineID, SL.ProductID , SL.Productname, SL.Product_Description, SL.LinePrice,SL.QtySold,SL.UnitOfMeasureID , SL.UnitofMeasureSaleLines, SL.LineTaxCode, '+
                      ' SL.shipped - ifnull((Select 0 - Sum(Shipped) refunded from tblsaleslines inner join tblsales using (SaleID) where RefundedSalesLineID= SL.saleLineID and converted ="F"),0) qtytorefund  '+
                      ' FROM tblSalesLines  SL   '+
                      ' WHERE SaleID = '+ inttostr(saleIdtoRefund));
              open;
              if recordcount > 0 then begin
                LinesAdded:=False;
                First;
                try
                  While Eof = False do begin
                    if fieldbyname('qtytorefund').AsFloat > 0 then begin
                      if SalesBaseobj.Lines.locate(SalesBaseobj.Lines.IDfieldname,fieldByname('SaleLineID').asInteger , []) then begin
                        refund.Lines.New;
                        refund.Lines.productname      := fieldByname('ProductName').AsString;
                        LockLineFields := false;
                        refund.Lines.LineTaxCode := fieldByname('LineTaxCode').AsString;
                        //refund.Lines.UnitOfMeasureID  := fieldByname('UnitOfMeasureID').AsInteger;
                        refund.Lines.UnitOfMeasure    := fieldByname('UnitofMeasureSaleLines').asString;
                        refund.Lines.RefundQty        := DivZer(fieldByname('qtytorefund').asFloat,refund.Lines.UOMMultiplier);
                        refund.Lines.LinePrice        := fieldbyname('LinePrice').AsFloat;
                        refund.Lines.RefundedSalesLineID := FieldByname('SaleLineID').AsInteger;
                        refund.Lines.PostDB;
                        SalesBaseobj.Lines.PQA.CopyAllocation(refund.Lines.PQA.ID, false);
                        LinesAdded:=True;
                      end;
                    end;
                    Next;
                  end;
                except
                  on e: exception do begin
                    CommonLib.MessageDlgXP_Vista('Error while adding lines to the Refund: ' + e.Message,mtWarning,[mbOk],0);
                    exit;
                  end;
                end;
                if LinesAdded = false then begin
                  if CommonLib.MessageDlgXP_Vista('Sale #' + inttostr(saleIdtoRefund) +' is completely Refunded. '+
                          'Do you want to see the product(s) and qty of this sale?', mtconfirmation , [mbyes, mbno],0)= mrYes then
                          OpenERPListFormModal('TSoldnRefundQtyofSalesGUI' , SelectSalesLinesToRefund , inintSoldnRefundQtyofSales);
                end;
              end;
          end;
        finally
          LockLineFields := SaveLockLineFields;
          if qry.Active then qry.close;
          DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
        end;

  finally
    saleIdtoRefund:= 0;
  end;
end;
procedure TRefundGUI.SelectSalesLinesToRefund(Sender: twwDBGrid);
var
  i:Integer;
begin
  if sender.SelectedList.Count > 0 then begin
      for i := 0 to sender.SelectedList.Count - 1 do begin
          sender.Datasource.DataSet.GoToBookmark(Sender.SelectedList.Items[i]);
          refund.Lines.New;
          refund.Lines.productname          := sender.Datasource.DataSet.fieldByname('ProductName').AsString;
          refund.Lines.UnitOfMeasureID      := sender.Datasource.DataSet.fieldByname('UnitOfMeasureID').AsInteger;
          refund.Lines.RefundQty            := sender.Datasource.DataSet.FieldByName('shipped').AsFloat;
          refund.Lines.LinePrice            := sender.Datasource.DataSet.fieldbyname('LinePrice').AsFloat;
          refund.Lines.RefundedSalesLineID  := sender.Datasource.DataSet.FieldByname('SaleLineID').AsInteger;
          refund.Lines.PostDB;
      end;
    end;
end;
procedure TRefundGUI.inintSoldnRefundQtyofSales(Sender: TObject);
begin
   if not(Sender is TSoldnRefundQtyofSalesGUI) then exit;
   TSoldnRefundQtyofSalesGUI(Sender).SaleId := saleIdtoRefund;
   TSoldnRefundQtyofSalesGUI(Sender).caption := 'Sold n Refund Qty of Sale # ' + inttostr(saleIdtoRefund);
   TSoldnRefundQtyofSalesGUI(Sender).lblNote.Caption := 'Choose Product(s) to be refunded and ''Select'' option to add the selected Product(s) and its ''Shipped Quantity'' to refund.';
   TSoldnRefundQtyofSalesGUI(Sender).HighlightControl(TSoldnRefundQtyofSalesGUI(Sender).cmdPrint);
end;
function TRefundGUI.IstransLineLocked: Boolean;
begin
  REsult :=inherited IstransLineLocked;
  if result then exit;
end;

procedure TRefundGUI.Locksales;
begin
  inherited;
  if IstransLineLocked or (AccessLevel>3)  then exit;
  LockGridforRestrictedRefund;
end;
procedure TRefundGUI.LoadTransRec;
var
  fiRefundChequeID :Integer;
begin
  btnCheque.caption := 'Create'+NL+'Cheque';
  inherited;
  if (KeyId >0) and (Refund.hascheque) then btnCheque.caption := 'Save and View'+NL+'Cheque'
  else btnCheque.caption := 'Create and View'+NL+'Cheque';
  if (AccessLevel <5) or (TransAccessLevel<5) then
    fiRefundChequeID := RefundChequeID(Refund.Globalref)
  else
    fiRefundChequeID := 0;
    if fiRefundChequeID <> 0 then begin
      TransAccessLevel:= 5;
      CommonLib.MessageDlgXP_Vista('A Cheque is already created for this Refund and access will be changed to read-only.', mtWarning, [mbOK], 0);
      if fbPaymentLock =False then begin
        if Refund.hasCheque then begin
          btnCheque.caption := 'Delete Refund and'+NL+'Cheque #' + inttostr( fiRefundChequeID);
          btnCheque.Tag :=fiRefundChequeID;
          btnCheque.Onclick := Deletecheque;
        end else begin
          btnCheque.Enabled := false;
        end;
      end else begin
          btnCheque.Enabled := False;
      end;
    end;

end;

procedure TRefundGUI.LockGridforRestrictedRefund;
var
  ctr:Integer;
begin
if AppEnv.CompanyPrefs.RestrictRefund  then begin
      for ctr:= 0 to grdTransactions.GetColCount-1 do begin
        if sametext(grdTransactions.columns[ctr].FieldName , tblDetailsRefundQty.FieldName) or
           sametext(grdTransactions.columns[ctr].FieldName , tblDetailsProduct_Description.FieldName) then
        else grdTransactions.columns[ctr].Readonly := true;
      end;
      for ctr:= 0 to componentcount -1 do begin
        if (Components[ctr] <> grdTransactions) and (Components[ctr] is twincontrol) and  ((twincontrol(Components[ctr]).parent = grdTransactions.parent) or (twincontrol(Components[ctr]).parent = grdTransactions))  then begin
                 if  (Components[ctr] is TwwDBLookupcombo)          then begin TwwDBLookupcombo(Components[ctr]).readonly     := True;
            end else if  (Components[ctr] is TwwDBDateTimePicker)   then begin TwwDBDateTimePicker(Components[ctr]).readonly  := True;
            end else if  (Components[ctr] is TwwDBEdit)             then begin TwwDBEdit(Components[ctr]).readonly            := True;
            end;
        end;
      end;
      if dgAllowInsert in grdTransactions.KeyOptions then grdTransactions.KeyOptions := grdTransactions.KeyOptions - [dgAllowInsert];
  end;
end;
procedure TRefundGUI.actSelectSalesUpdate(Sender: TObject);
begin
  inherited;
  actSelectSales.Enabled := (accesslevel=1) (*and (refund.clientID <> 0) *)and ((refund.Lines.ISEmpty) or (AppEnv.CompanyPrefs.RestrictRefund) );
end;

procedure TRefundGUI.actSignatureExecute(Sender: TObject);
begin
  if frmSignatureEdit.GetClientSignature(self.tblMasterClientSignature, self.tblMasterSignatureTime) then
    self.Refund.Dirty := true;
end;

procedure TRefundGUI.actSignatureUpdate(Sender: TObject);
begin
  inherited;
  if self.tblMasterClientSignature.BlobSize > 0 then
    btnSignature.Color := $0077ff77
  else
    btnSignature.Color := clBtnFace;
end;

procedure TRefundGUI.actSplitPayExecute(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TRefundGUI.btnCashDrawerClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TRefundGUI.btnChequeClick(Sender: TObject);
var
  fiRefundChequeID :Integer;
begin
  inherited;
//  fiRefundChequeID := 0;
  if MessageDlgXP_vista('This will save the current changes. Do you wish to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;

  if Refund.Paymethod <> CHEQUE then begin
    Refund.Paymethod := CHEQUE;
    Refund.Postdb;
  end;
  REfund.InvoiceRefund := false;
  REfund.PostDB;
  if not REfund.Save then exit;
  Refund.Connection.CommitTransaction;
  try
    REfund.UserLock.UnlockAllCurrentInstance;
    fiRefundChequeID := RefundChequeID(Refund.Globalref);
    if fiRefundChequeID <> 0 then OpenERPFormModal('TfmCheque' ,fiRefundChequeID);
  finally
    Refund.Connection.BeginTransaction;
  end;
  if fiRefundChequeID <> 0 then Self.close;
  //self.MakeCheque;
end;

procedure TRefundGUI.actCustomerContactsExecute(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TRefundGUI);

  with FormFact do begin
    RegisterMe(TRefundGUI, 'TInvoiceListGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TInvoicelistExpressGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TNonERPSalesListGUI_*_Refund=ERPTransId');
    RegisterMe(TRefundGUI, 'TSalesAddressLabelPrnGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TSalesDashboardPnLdetailsGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TSalesDashBoardTopTenSalesManDetailsGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TCashProfitandLossGUI_*_Refund=TRansId');
    RegisterMe(TRefundGUI, 'TSalesDashBoardTopTenProductsDetailsGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TSalesDashBoardTopTenCustomersDetailsGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TTransAccountDetailsGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TSalesReportGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TSalesReportSaleslinescustomFieldListGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TSalesReportCustomercustomFieldListGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TSalesReportProductcustomFieldListGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TWeeklySalesreportGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TProductSalesReportGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TProductSalesReportGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TSalesListwithCommisionGUI_SaleID_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TSalesListReportGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TSalesListOutstandingGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TAccountsReceiveListGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TAccountsReceiveListDebugGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TStatementListGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TSerialListGUI_Type_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TSerialListGUI_DateSold_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TMemTransListGUI_*_TRefundGUI=TransID');
    RegisterMe(TRefundGUI, 'TBalTransListGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TInventoryAssetVsStockStautsGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TToBeReconciledGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TReconListDetailFormGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TTrialBalTransListGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TTransactionListGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TBASTransReturnListGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TNZTransReturnListGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TVATTransReturnListGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TGlobalsearchGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TTransAccountDetailsGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TCustomerSummaryListingGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TEmployeeReportGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TJobProfitabilityGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TJobProfitabilityforCustomerGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TRepairProfitabilityGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TCustomerBalanceDetailGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TGeneralLedgerReportGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TfrmDeletedInvoicesListGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TCashBasisDetailsGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TCashBasisDetailsGUI_TransType_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TStockStatusRoling_*_Refund=TransactionNo');
    RegisterMe(TRefundGUI, 'TAllTransactionGUI_*_Refund=TransNo');
    RegisterMe(TRefundGUI, 'TSoldProductsReport_*_Refund=SaleID');
    (*RegisterMe(TRefundGUI, 'TSalescommissionListGUI_SaleID_Refund=SaleID');*)
    RegisterMe(TRefundGUI, 'TSalescommissionListGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TCustomerSalesOnProductListGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TCashSaleDepositGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TMemTransListGUI_*_Refund=TransID');
    RegisterMe(TRefundGUI, 'TTransactionswith0QtyGUI_*_Refund=TrasnsId');
    RegisterMe(TRefundGUI, 'TSalesTotalAmountMisMatchGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TNumberSequenceListGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TPnLEmployeereportGUI_*_Voucher=TransID');
    RegisterMe(TRefundGUI, 'TSalesTaxReportGUI_*_Refund=SaleID');
    RegisterMe(TRefundGUI, 'TRefundSalesListGUI_*_Refund=RefundID');
  end;
end.








