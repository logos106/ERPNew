{ Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
  18/04/05  1.00.01 BJ  (1)When EFT is checked and the account information is
                         not available for the supplier, the supplier form is
                         opened to provide those information
                         (2)When EFT is checked and the bank of the selected
                         supplier does not have the complete account detailes,
                         the bank form is opened.
  04/05/05  1.00.02 BJ  Repaint the supplier form when called from chkEFTclick to
                         refresh with the background image.
                         Same done for ChartOfAccounts form
  21/09/05  1.00.03 DSP Added TDivertCreate for a temporary fix for entries
                         being prevented on the controls after clicking 'New'.
  12/10/05  1.00.04 AL  Added Foreign Currency Exchange functionality
  13/10/05  1.00.05 AL  Moved Forerign Currency Exchange functionaliti to ancestor
                         (BasePrepaymentGUI)
  19/10/05  1.00.06 DLS Added RegisterClass
  25/11/05  1.00.07 DSP Removed TDivertCreate as fault was in ProcessEditedFlag
                         in DNMLib.
  11/04/06  1.00.08 BJ  Implemented userlocks}
unit frmSuppPrepayments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BasePrepayment, DB, kbmMemTable,  SelectionDialog,AppEvnts, StdCtrls,
  wwcheckbox, DBCtrls, ExtCtrls, DNMPanel, Buttons, DNMSpeedButton,wwdbdatetimepicker,
  wwdblook, Mask, MemDS, DBAccess,MyAccess,ERPdbComponents, DataState, wwdbedit, Menus,
  AdvMenus, Shader, busobjPrepayments, ImgList, ERPDbLookupCombo, ProgressDialog;

type
  TfmSuppPrepayments = class(TBasePrepaymentGUI)
    UseAccNo: TDNMSpeedButton;
    Bevel4: TBevel;
    Label4: TLabel;
    cboClientlookupCompany: TWideStringField;
    cboClientlookupApprovedImage: TIntegerField;
    imgPopup: TImageList;
    cboClientlookupAll_Approved: TWideStringField;
    cboClientlookupClientId: TIntegerField;
    cboClientlookupBalance: TFloatField;
    cboClientlookupPayMethodID: TIntegerField;
    cboClientlookupClientNo: TWideStringField;
    cboClientlookupForeignExchangeSellCode: TWideStringField;
    lblEnteredAtHead: TLabel;
    lblEnteredBy: TDBText;
    qryEmployeeLookup: TERPQuery;
    tblMasterEnteredBy: TWideStringField;
    lblEnteredAt: TDBText;
    tblMasterChequePrinted: TWideStringField;
    tblMastermsTimeStamp: TDateTimeField;
    tblMasterRepId: TIntegerField;
    tblMasterRepName: TWideStringField;
    tblMastermsUpdateSiteCode: TWideStringField;
    btnPrintCheque: TDNMSpeedButton;
    btnEmail: TDNMSpeedButton;
    procedure cboClientlookupAfterOpen(DataSet: TDataSet);
    procedure chkEFTClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure UseAccNoClick(Sender: TObject);
    procedure cboForeignCurrencyCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cmdSaveClick(Sender: TObject);
    procedure cboClientlookupCalcFields(DataSet: TDataSet);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cboForeignCurrencyCodeExit(Sender: TObject);
    procedure cboPaymentMethodExit(Sender: TObject);
    procedure cboClassExit(Sender: TObject);
    procedure cboAccountExit(Sender: TObject);
    procedure tblMasterPayAmountChange(Sender: TField);
    procedure cmdCancelClick(Sender: TObject);
    procedure btnPrintChequeClick(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
  private
    fsLinkToOrderOriginalRef: string;
    fsLinkToOrderRef: string;
    Procedure GetEFTDetails;
    procedure PrintCheque(ID: integer);
    procedure EMailCheque(ID : integer);
    procedure LinkToOrder;
  protected
    Procedure InitERPLookupCombonFields; Override;
  public
    SuppPrePayment: TsuppPrePayments;
    Property LinkToOrderRef: string read fsLinkToOrderRef write fsLinkToOrderRef;
    Property LinkToOrderOriginalRef: string read fsLinkToOrderOriginalRef write fsLinkToOrderOriginalRef;
  end;

implementation

uses
  FormFactory,frmSupplier, frmChartOfAccountsFrm,
  Commonlib, BaseInputForm, tcDataUtils,AppEnvironment, BusObjBase, tcConst,
  FastFuncs, DNMLib, chequeLib, BusObjOrderPayments, CommonDBLib,
  CorrespondenceObj, PrintTemplateObj, EmailExtraUtils;

{$R *.dfm}

{ TfmSuppPrepayments }

procedure TfmSuppPrepayments.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmSuppPrepayments.FormCreate(Sender: TObject);
begin
    SuppPrePayment  := TSuppPrePayments.Create(Self);
    PrePayment      := SuppPrePayment;
    inherited;
    SuppPrePayment.Connection := TMyDacDataConnection.Create(SuppPrePayment);
    TMyDacDataConnection(SuppPrePayment.Connection).MyDacConnection := MyConnection;
    SuppPrePayment.GetEFTDetails := GetEFTDetails;
    userLock.Enabled := True;
end;

procedure TfmSuppPrepayments.UseAccNoClick(Sender: TObject);
//var
//  TempText: string;
begin
//  DisableForm;
//  try
//    inherited;
//    TempText := cboClient.Text;
//    if not InAccountNoMode then begin
//        InAccountNoMode := true;
//        Label1.Caption  := 'Supplier Account No';
//        cboClientLookup.Close;
//        cboClientLookup.SQL.Clear;
//        cboClientLookup.SQL.Add(' SELECT ClientId,Company,Balance,PayMethodID,ClientNo,' +
//                                ' ForeignExchangeSellCode,' +
//                                ' IF((SELECT Count(*) FROM tblPurchaseOrders WHERE tblPurchaseOrders.Approved = "F" AND tblPurchaseOrders.ClientID = tblClients.ClientId) > 0,"F","T")  as All_Approved' +
//                                ' FROM tblclients ' +
//                                ' WHERE tblclients.Company Is Not Null  ' +
//                                ' And tblclients.Active <>"F" And tblclients.Supplier  = "T" ' +
//                                ' AND ifnull(tblclients.ClientNo,0)<>0 ' +
//                                ' ORDER BY tblclients.ClientNo;');
//        cboClientLookup.Open;
//        cboClient.Selected.Clear;
//        cboClient.Selected.Add('ClientNo' + #9 + '5' + #9 + 'Account No' + #9 + 'F' + #9);
//        cboClient.Selected.Add('Company' + #9 + '30' + #9 + 'Company'#9'T' + #9);
//        cboClient.Selected.Add('Balance' + #9 + '10' + #9 + 'Balance ('+AppEnv.RegionalOptions.CurrencySymbol+')' + #9 + 'T' + #9);
//    end else begin
//        InAccountNoMode := false;
//        Label1.Caption  := 'Supplier';
//        cboClientLookup.Close;
//        cboClientLookup.SQL.Clear;
//        cboClientLookup.SQL.Add(' SELECT ClientId,Company,Balance,PayMethodID,ClientNo,' +
//                                ' ForeignExchangeSellCode,' +
//                                ' IF((SELECT Count(*) FROM tblPurchaseOrders WHERE tblPurchaseOrders.Approved = "F" AND tblPurchaseOrders.ClientID = tblClients.ClientId) > 0,"F","T")  as All_Approved' +
//                                ' FROM tblclients ' +
//                                ' WHERE tblclients.Company Is Not Null  ' +
//                                ' And tblclients.Active <>"F" And tblclients.Supplier  = "T" ' +
//                                ' ORDER BY tblclients.Company;');
//        cboClientLookup.Open;
//        cboClient.Selected.Clear;
//        cboClient.Selected.Add('Company' + #9 + '30' + #9 + 'Company'#9'T' + #9);
//        cboClient.Selected.Add('Balance' + #9 + '10' + #9 + 'Balance ('+AppEnv.RegionalOptions.CurrencySymbol+')' + #9 + 'T' + #9);
//    end;
//    if cboClientLookup.Locate('Company', TempText, [loCaseInsensitive]) and not Empty(TempText) then begin
//      cboClient.Text := cboClientLookup.FieldByName('ClientNo').AsString;
//    end else begin
//      cboClient.Clear;
//      cboClient.LookupValue := '';
//      cboClient.Value := '';
//      cboClient.Text := '';
//      cboClientCloseUp(cboClient, cboClient.lookupTable, cboClient.DataSource.DataSet, true);
//    end;
//  finally
//    EnableForm;
//  end;
end;

procedure TfmSuppPrepayments.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
//    if AppEnv.Employee.UseClientAccountNoOnPayments then UseAccNo.Click;
    if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAddToEFT') <> 1 then begin
      lblEFT.Visible := false;
      chkEFT.Visible := false;
    end  else begin
      lblEFT.Visible := true;
      chkEFT.Visible := true;
      chkEFT.Checked := AppEnv.CompanyPrefs.PaymentsAddToEFT and (KeyID = 0);
//    UseAccNo.Enabled:= cboClient.Enabled;

    //if tblMaster.FieldByName('EmployeeID').AsInteger = 0 then tblMaster.FieldByName('EmployeeID').AsInteger := AppEnv.Employee.EmployeeID;
  //  lblEnteredBy.Caption := GetEmployeeName(tblMaster.FieldByName('EmployeeID').AsInteger);
  end;
  finally
    EnableForm;
  end;
end;

procedure TfmSuppPrepayments.cboClientlookupAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TFloatField(cboClientLookup.FieldByName('Balance')).currency := true;
end;

procedure TfmSuppPrepayments.chkEFTClick(Sender: TObject);
begin
    SuppPrepayment.AddToEFT := chkEFT.Checked;
    if chkEFT.Checked then SuppPrepayment.Valid4EFT(true);
end;

Procedure TfmSuppPrepayments.GetEFTDetails;
var
  SupForm: TfmSupplier;
  COAForm: TfrmChartOfAccounts;
begin
    inherited;
    if SuppPrepayment.ClientInvalid4EFT then begin
        SupForm := TfmSupplier(GetComponentByClassName('TfmSupplier'));
        if Assigned(SupForm) then
            with  SupForm do begin
                KeyId       := SuppPrepayment.ClientID;
                SupForm.AttachObserver(Self);
                FormStyle   := fsMDIChild;
                BringToFront;
                SupForm.Update;
                TabCtl20.ActivePageIndex := 2;
                SupForm.Update;
                SetControlFocus(edtBankAccName);
            end;
    end;

    if SuppPrepayment.BankAccountInvalid4EFT then begin
        COAForm := TfrmChartOfAccounts(GetComponentByClassName('TfrmChartOfAccounts'));
        if Assigned(COAForm) then
            with  COAForm do begin
                AttachObserver(Self);
                KeyId       := SuppPrepayment.BankAccountID;
                COAForm.AttachObserver(Self);
                FormStyle   := fsMDIChild;
                BringToFront;
                COAForm.Update;
                COAForm.Update;
                if edtBankAccName.Enabled = false then edtBankAccName.Enabled := true;
                SetControlFocus(edtBankAccName);
            end;
    end;
end;

procedure TfmSuppPrepayments.InitERPLookupCombonFields;
begin
  inherited;
 (*
  NamenPrintNameGridObj.ClientLookupQueryWithSearchengine(
    tblMasterClientID.AsInteger,
    cboClient,
    // supplierList, CustomerList, ProspectList, JobList
    true,
    false,
    False,
    false,
    true, 'ClientPrintName' , nil , true);
 *)
end;

procedure TfmSuppPrepayments.LinkToOrder;
begin
  if LinkToOrderRef <> '' then begin
    With TOrderPrepayment.Create(Self) do try
      Connection := SuppPrePayment.Connection;
      Load(0);
      New;
      OrderRef := LinkToOrderRef;
      OrderOriginalRef := LinkToOrderOriginalRef;
      PrepayRef := SuppPrePayment.Globalref;
      PostDB;
    finally
      Free;
    end;
  end;
end;

procedure TfmSuppPrepayments.cboForeignCurrencyCodeCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
end;

procedure TfmSuppPrepayments.cmdSaveClick(Sender: TObject);
begin
  DisableForm;
  try
    if  SuppPrePayment.Save then begin
      LinkToOrder;
      SuppPrePayment.connection.CommitTransaction;
      Notify;
      Self.Close;
    End;
  finally
    EnableForm;
  end;
end;

procedure TfmSuppPrepayments.EMailCheque(ID: integer);
var
  ssql:String;
  ReportType : string;
  lSilent, lSecret : boolean;
begin
  if Prepayment.Client.Email = '' then
  begin
    MessageDlgXP_Vista('This Supplier Does Not Have An Email Address.'#13#10'Cannot Send Email', mtWarning, [mbOk], 0);
    Exit;
  end;

  if not EmailSilentSecret(1, false, lSilent, lSecret) then
    exit;


  ssql:= chequeLib.SupplierPrePaychequeSQL(ID, SuppPrePayment.PayAmount);
  fbReportSQLSupplied := true;
  ReportType := 'Supplier Prepayment Cheque';
  EmailReport(id, GetClientName(Prepayment.ClientID), GetContactEmails(Prepayment.ClientID,'MainContactForCheque'), ReportType, ReportType,
   ssql, true, true, true, lSilent, lSecret);
  fbReportSQLSupplied := false;
end;

procedure TfmSuppPrepayments.cboClientlookupCalcFields(DataSet: TDataSet);
begin
  inherited;
  if cboClientlookup.FieldByName('All_Approved').asString = 'T' then
     cboClientlookup.FieldByName('ApprovedImage').AsInteger := 3
  else cboClientlookup.FieldByName('ApprovedImage').AsInteger := 2;
end;

procedure TfmSuppPrepayments.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Notify(true);
end;

procedure TfmSuppPrepayments.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfmSuppPrepayments.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfmSuppPrepayments.cboForeignCurrencyCodeExit(Sender: TObject);
begin
  inherited;
  if cboForeignCurrencyCode.Text = '' then begin
    cboForeignCurrencyCode.DropDown;
    SetControlFocus(cboForeignCurrencyCode);
  end;
end;

procedure TfmSuppPrepayments.cboPaymentMethodExit(Sender: TObject);
begin
  inherited;
  if  cboPaymentMethod.Text = '' then begin
    cboPaymentMethod.DropDown;
  end;
end;

procedure TfmSuppPrepayments.cboClassExit(Sender: TObject);
begin
  inherited;
  if cboClass.Text = '' then begin
    cboClass.DropDown;
  end;
end;

procedure TfmSuppPrepayments.btnEmailClick(Sender: TObject);
begin
  if not SaveAndCommit then
    Exit;
  PrePayment.connection.BeginTransaction;
  try
    EMailCheque(PrePayment.Id);
    PrePayment.Connection.CommitTransaction;
  Except
    PrePayment.Connection.RollbackTransaction;
  end;
  CloseAfterPrint;
end;

procedure TfmSuppPrepayments.btnPrintChequeClick(Sender: TObject);
begin
  if not SaveAndCommit then Exit;
  PrePayment.connection.BeginTransaction;
  try
    Printcheque(PrePayment.Id);
    PrePayment.Connection.CommitTransaction;
  Except
    PrePayment.Connection.RollbackTransaction;
  end;
  CloseAfterPrint;
end;

procedure TfmSuppPrepayments.PrintCheque(ID: integer);
var
  ssql:String;
begin
  ssql:= chequeLib.SupplierPrePaychequeSQL(ID, SuppPrePayment.PayAmount);
  fbReportSQLSupplied := true;
  PrintTemplateReport('Supplier Prepayment Cheque', sSQL, not AppEnv.Employee.ShowPreview, 1);
  SuppPrePayment.ChequePrinted := True;
  SuppPrePayment.Save;
  fbReportSQLSupplied := false;
end;
procedure TfmSuppPrepayments.cboAccountExit(Sender: TObject);
begin
  inherited;
  if cboAccount.Text = '' then begin
    cboAccount.DropDown;
  end;
end;

procedure TfmSuppPrepayments.tblMasterPayAmountChange(Sender: TField);
begin
  inherited;
  if Abs(Sender.AsFloat) - Abs(Round(Sender.AsFloat,CurrencyRoundPlaces)) > 0 then begin
    CommonLib.MessageDlgXP_Vista('Invalid value for ' + Sender.DisplayLabel +
      ': ' + Sender.AsString, mtInformation, [mbOK], 0);
    Abort;
  end;
end;

initialization
  RegisterClassOnce(TfmSuppPrepayments);
  with FormFact do begin
    RegisterMe(TfmSuppPrepayments, 'TSuppPrepaymentListGUI_*=ReceiptNo');
    RegisterMe(TfmSuppPrepayments, 'TAccountsPayListGUI_*_Supplier Prepayment=PurchaseOrderID');
    RegisterMe(TfmSuppPrepayments, 'TBankAccountListGUI_*_Supplier Prepayment=PrepaymentID');
    RegisterMe(TfmSuppPrepayments, 'TBalTransListGUI_*_Supplier Prepayment=PrepaymentID');
    RegisterMe(TfmSuppPrepayments, 'TToBeReconciledGUI_*_Supplier Prepayment=PrepaymentID');
    RegisterMe(TfmSuppPrepayments, 'TReconListDetailFormGUI_*_Supplier Prepayment=PrepaymentID');
    RegisterMe(TfmSuppPrepayments, 'TTrialBalTransListGUI_*_Supplier Prepayment=PrepaymentID');
    RegisterMe(TfmSuppPrepayments, 'TTransactionListGUI_*_Supplier Prepayment=PrepaymentID');
    RegisterMe(TfmSuppPrepayments, 'TBASTransReturnListGUI_*_Supplier Prepayment=PrepaymentID');
    RegisterMe(TfmSuppPrepayments, 'TNZTransReturnListGUI_*_Supplier Prepayment=PrepaymentID');
    RegisterMe(TfmSuppPrepayments, 'TVATTransReturnListGUI_*_Supplier Prepayment=PrepaymentID');
    RegisterMe(TfmSuppPrepayments, 'TGlobalsearchGUI_*_Supplier Prepayment=PrepaymentID');
    RegisterMe(TfmSuppPrepayments, 'TTransAccountDetailsGUI_*_Supplier Prepayment=PrepaymentID');
    RegisterMe(TfmSuppPrepayments, 'TGeneralLedgerReportGUI_*_Supplier Prepayment=PrepaymentID');
    RegisterMe(TfmSuppPrepayments, 'TAllTransactionGUI_*_Suppliler Pre-payment=TransNo');
    RegisterMe(TfmSuppPrepayments, 'TSupplierStatementGUI_*_Supplier Prepayment=PurchaseOrderID');
    RegisterMe(TfmSuppPrepayments, 'TPrintchequesGUI_*_Prepayment=TransID');
    RegisterMe(TfmSuppPrepayments, 'TOrderPrepaymentsGUI_*_Supplier Prepayment=PrepaymentID');
    RegisterMe(TfmSuppPrepayments, 'TPaymentListGUI_*_'+SUPPLIER_PREPAYMENT+'=PaymentID');
  end;
end.






