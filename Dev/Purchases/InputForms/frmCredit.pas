unit frmCredit;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 18/07/05  1.00.01 DSP  Added functionality to recall last account name used
                        after a supplier is selected.
 11/10/05  1.00.02 AL   Moved some controls to make a better look
 19/10/05  1.00.03 DLS  Added RegisterClass
 06/04/06  1.00.04 AL   Added call of AddToPayAuthorisations on Save
 10/04/06  1.00.05 DSP  Added customise grid option.
 15/08/06  1.00.06 BJ   Print options does the validations only if the form is not in readonly state
                        as the form is non-editable when readonly, so nothing will be changed

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Expenses, DB,  StdCtrls, wwcheckbox, Buttons, DNMSpeedButton, wwdbdatetimepicker,
  wwdblook, DBCtrls, Mask, ExtCtrls, DNMPanel, Wwdbigrd, Grids,
  Wwdbgrid, ActnList, Menus, AdvMenus, ImgList, SelectionDialog, AppEvnts, MemDS,
  DBAccess, MyAccess,ERPdbComponents, DataState, DMComps, wwdbedit, Shader, busobjExpenses, BusObjBase,
  ProgressDialog, ERPDbLookupCombo, DNMAction;

type
  TCreditGUI = class(TBaseExpenseGUI)
    tblMasterApproved   : TWideStringField;
    Shape1: TShape;
    Label5: TLabel;
    cboInvoiceDate: TwwDBDateTimePicker;
    pnlApprover: TDNMPanel;
    lblApprover: TLabel;
    cboApprover: TwwDBLookupCombo;
    chkSendEmail: TwwCheckBox;
    qryApproverLookup: TERPQuery;
    tblMasterApproverID: TIntegerField;
    chkApproved: TwwCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCompletedClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure txtInvNumberExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboBaseForeignCurrencyCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboTermsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboTaxCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure btnCloseClick(Sender: TObject);
    procedure actCustomerContactsExecute(Sender: TObject);
    procedure btnAttachmentsClick(Sender: TObject);
    procedure btnPDFClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure chkApprovedClick(Sender: TObject);
  private
    fbShowingOrClosing: Boolean;
    function SendPrintEmailSilent: boolean;
    function SendPrintEmail: boolean;
    function SendPrintSMSSilent: boolean;
    function SendPrintSMS: boolean;
  protected
    CreditObj :TCredit;
    function GetReportTypeID: integer; override;
    procedure   DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); override;
    procedure CommitAndNotify;override;
    function TransStatustype:String ;override;
    procedure NewTransBusObjinstance;override;
    function SaveTrans:Boolean ; Override;
    function Save4NewTrans: Boolean;Override;
  public

    { Public declarations }
    class procedure CloseMe; override;
  end;

implementation

{$R *.dfm}

uses
  BaseInputForm, FormFactory, DNMExceptions,  DNMLib, CommonLib,
   AppEnvironment,tcDataUtils, FastFuncs, tcTypes, tcconst,
   frmReportingOptions, EmailUtils, SMSUtils,
   CorrespondenceObj, BusObjConst, BusObjApprovals, ApprovalNotificationLib,
  LookupcomboLib;

procedure  TCreditGUI.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (EventType = BusObjEvent_Change) and (Value = BusObjEvent_OnCalcOrderTotals) then begin
    if AppEnv.CompanyPrefs.UseApprovalLevels then begin
      //qryApproverLookup.ParamByName('ApprovalType').AsString := ApprovalTypeCredit;
      qryApproverLookup.ParamByName('OrderTotal').AsFloat := CreditObj.TotalAmountInc;
      qryApproverLookup.Refresh;
      if CreditObj.ApproverID > 0 then begin
        qryApproverLookup.Locate('EmployeeID',CreditObj.ApproverID,[]);
        cboApprover.Text := qryApproverLookup.FieldByName('EmployeeName').AsString;
      end;
    end;
  end;
end;

procedure TCreditGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  fbShowingOrClosing := True;
end;

procedure TCreditGUI.btnCompletedClick(Sender: TObject);
begin
  DisableForm;
  try
    if CreditObj.Save then begin
        inherited;
        CommitAndNotify;
        if AppEnv.CompanyPrefs.UseApprovalLevels then begin
          if chkSendEmail.Checked and (CreditObj.ApproverID > 0) then begin
            TApprovalNotification.Notify(self);
          end;
        end;
        Self.close;
    end;
  finally
    EnableForm;
  end;
end;

function TCreditGUI.GetReportTypeID: integer;
begin
  Result := 8;
end;

procedure TCreditGUI.NewTransBusObjinstance;
begin
  Freeandnil(CreditObj);
  CreditObj := TCredit.Create(Self);
  CreditObj.Name:= 'CreditObj';
  ExpenseBase := CreditObj;
  inherited;
end;

function TCreditGUI.SaveTrans: Boolean;
begin
  result := CreditObj.Save;
end;

function TCreditGUI.SendPrintEmail: boolean;
var
  recip: string;
begin
  recip := CreditObj.ContactEmail;
  if recip = '' then
    recip := CreditObj.Supplier.Email;
  result := TCorrespondenceGui.EmailSupplier(recip,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.CreditPrintEmailSubject, PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.CreditPrintEmailText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger);
end;

function TCreditGUI.SendPrintEmailSilent: boolean;
var
  toEmail: string;
begin
  toEmail := CreditObj.ContactEmail;
  if toEmail = '' then
    toEmail := CreditObj.Supplier.Email;

  result := TCorrespondenceGui.EmailSupplier(toEmail,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.CreditPrintEmailSubject, PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.CreditPrintEmailText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger, true);
end;

function TCreditGUI.SendPrintSMS: boolean;
var
  number: string;
begin
  result := false;
  number := GetOrAddMobileNumber;
  if number = '' then exit;

  result := TCorrespondenceGui.SMSSupplier(number,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.CreditPrintSMSText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger);
end;

function TCreditGUI.SendPrintSMSSilent: boolean;
var
  toMobile: string;
begin
  toMobile := CreditObj.ContactMobile;
  if toMobile = '' then
    toMobile := CreditObj.Supplier.Mobile;

  result := TCorrespondenceGui.SMSSupplier(toMobile,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.CreditPrintSMSText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger, true);
end;

function TCreditGUI.TransStatustype: String;
begin
  Result:= SimpleTypes_Credit;
end;

procedure TCreditGUI.FormShow(Sender: TObject);
begin
stepProgressbar;
try
  DisableForm;
  try
    try
      try
        inherited;
        CreditObj.Lines.Dataset.Filter := CreditObj.TranslineFilter(false);
        CreditObj.Lines.Dataset.Filtered:= true;
        GuiPrefs.DbGridElement[grdTransactions].RemoveFields('SortId');
        GuiPrefs.DbGridElement[grdTransactions].RemoveFields('LinesOrder');

        pnlApprover.Visible :=  AppEnv.CompanyPrefs.UseApprovalLevels;
        if AppEnv.CompanyPrefs.UseApprovalLevels then
          DoBusinessObjectEvent(CreditObj, BusObjEvent_Change, BusObjEvent_OnCalcOrderTotals);

      finally
        fbShowingOrClosing := False;
      end;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
finally
  Enabledisable;
  HideProgressbar;
  lblProcessMessage.visible :=False;
end;
end;

function TCreditGUI.Save4NewTrans: Boolean;
begin
  Result := False;
  DisableForm;
  try
    if CreditObj.Dirty then begin
        case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
            mrYes   : if CreditObj.Save then begin
              CommitAndNotify;  // current record should be commited before inserting new reocrd
              Result := True;
            end;
            mrNo    : begin
                        RollbackTransaction;
                        Notify(true);
                        Result := True;
                      end;
            mrCancel: Exit;
        end;
    end else begin
      REsult := True;
    end;
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TCreditGUI.btnPDFClick(Sender: TObject);
begin
  DisableForm;
  try
    if CreditObj.Save then begin
        Self.CommitAndNotify;
        try
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

procedure TCreditGUI.btnPrintClick(Sender: TObject);
var
  OptsForm: TfmReportingOptions;
  IsEnabled: boolean;
begin
  if not CreditObj.Save  then exit;
  Self.CommitAndNotify;
  OptsForm := EmailOptsForm;//TfmReportingOptions.Create(nil);
  try
    OptsForm.ActionList.AddDivider('Print');
    OptsForm.ActionList.Add('Print' ,'Print a Credit',actPrintExecute, true, true);
    OptsForm.ActionList.Add('Preview', 'Preview a Credit', self.actPreviewExecute, true, true);
    OptsForm.ActionList.Add('Save PDF','Save a PDF Credit to your computer', SaveTransToPDF, true, true);

    OptsForm.ActionList.AddDivider('Email');
    if AppEnv.CompanyPrefs.EnableInvoiceMail and ((CreditObj.ContactEmail <> '') or (CreditObj.Supplier.Email <> '')) then begin
      OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without Bill', self.SendPrintEmailSilent, true, true);
    end
    else begin
      OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without Bill', self.SendPrintEmailSilent, true, false);
    end;
    OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without Bill', self.SendPrintEmail, true, true);

    OptsForm.ActionList.AddDivider('SMS');
    IsEnabled := AppEnv.CompanyPrefs.SMSEnabled and
       AppEnv.CompanyPrefs.EnableCreditPrintSMS and
       ((CreditObj.ContactMobile <> '') or (CreditObj.Supplier.Email <> ''));
    OptsForm.ActionList.Add('SMS', 'Just send SMS', self.SendPrintSMSSilent, true, IsEnabled);
    OptsForm.ActionList.Add('SMS (Edit)', 'Edit SMS before sending', self.SendPrintSMS, true, AppEnv.CompanyPrefs.SMSEnabled);

    OptsForm.ShowModal;
    CloseAfterPrint(OptsForm.CloseWhenDone);
  finally
    OptsForm.Free;
  end;
end;

procedure TCreditGUI.actPreviewExecute(Sender: TObject);
begin
  DisableForm;
  try
    if CreditObj.Save then begin
        Self.CommitAndNotify;
        try
          inherited;
//          closeAfterPrint;
          self.BeginTransaction;
        except
        on E:Exception do begin
            commonlib.MessageDlgXP_Vista('Print failed.' +CHR(13) +CHR(13) + E.Message , mtWarning, [mbok] , 0);
            self.BeginTransaction;
        end;
        end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TCreditGUI.actPrintExecute(Sender: TObject);
begin
  DisableForm;
  try
    if CreditObj.Save then begin
      Self.CommitAndNotify;
      try
        inherited;
//        closeAfterPrint;
        self.BeginTransaction;
      except
        on E:Exception do begin
            commonlib.MessageDlgXP_Vista('Print failed.' +CHR(13) +CHR(13) + E.Message , mtWarning, [mbok] , 0);
            self.BeginTransaction;
        end;
      end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TCreditGUI.txtInvNumberExit(Sender: TObject);
begin
    CreditObj.ISInvNoUnique;
end;

class procedure TCreditGUI.CloseMe;
begin
  inherited;
  if FormStillOpen('TCreditGUI') then begin
    TCreditGUI(FindExistingComponent('TCreditGUI')).Close;
    Application.ProcessMessages;
  end;
end;

procedure TCreditGUI.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid:= True;
  inherited;
  //chkApproved.Visible := AppEnv.CompanyPrefs.UseApprovalLevels;
  //TransApprovalInit(chkApproved ,  ApprovalTypeCredit , CreditObj, 'TotalAmountInc',true);
    TransApprovalInit(chkApproved ,  CreditObj.Approvaltype , CreditObj, 'TotalAmountInc',true, cboApprover,lblApprover,chkSendEmail);

  //ApproverLookupQrySQL(qryApproverLookup);
  ApproverCombo.ApproverLookupQrySQL(cboApprover , ApprovalTypeCredit);
end;

procedure TCreditGUI.cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
end;

procedure TCreditGUI.cboBaseForeignCurrencyCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
  Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
end;

procedure TCreditGUI.cboTermsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
end;

procedure TCreditGUI.chkApprovedClick(Sender: TObject);
begin
  inherited;
(*  if TwwCheckBox(Sender).Focused then
    TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsBoolean := TwwCheckBox(Sender).Checked;*)
end;

procedure TCreditGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
end;

procedure TCreditGUI.cboTaxCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
end;
procedure TCreditGUI.CommitAndNotify;
begin
  CommitTransaction;
  AfterCommit;
  Notify;
end;
procedure TCreditGUI.btnCloseClick(Sender: TObject);
begin
  DisableForm;
  try
    Notify(true);
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TCreditGUI.actCustomerContactsExecute(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TCreditGUI.btnAttachmentsClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TCreditGUI);
  with FormFact do begin
    RegisterMe(TCreditGUI, 'TBillListGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TBankAccountListGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TBillDetailsListGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TTransAccountDetailsGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TSupplierReportGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TAccountsPayListGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TMemTransListGUI_*_TCreditGUI=TransID');
    RegisterMe(TCreditGUI, 'TApprovalListGUI_*_Credit=PurchaseOrderId');
    RegisterMe(TCreditGUI, 'TSupplierProductReportGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TBalTransListGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TToBeReconciledGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TReconListDetailFormGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TTrialBalTransListGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TTransactionListGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TBASTransReturnListGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TNZTransReturnListGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TVATTransReturnListGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TGlobalsearchGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TTransAccountDetailsGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TGeneralLedgerReportGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TUnpaidBillGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TJobProfitabilityGUI_*_Credit=SaleID');
    RegisterMe(TCreditGUI, 'TJobProfitabilityforCustomerGUI_*_Credit=SaleID');
    RegisterMe(TCreditGUI, 'TRepairProfitabilityGUI_*_Credit=SaleId');
    RegisterMe(TCreditGUI, 'TSupplierStatementGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TCashBasisDetailsGUI_TransType_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TAccountsPayableNotes_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TExpenseClaimListGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TApprovalReminderListGUI_*_Credit=PurchaseOrderID');
    (*RegisterMe(TCreditGUI, 'TRemindersListGUI_*_Credit=ID');*)
    RegisterMe(TCreditGUI, 'TReminderListGUI_*_Credit=ID');
    RegisterMe(TCreditGUI, 'TAllTransactionGUI_*_Credit=TransNo');
    RegisterMe(TCreditGUI, 'TMemTransListGUI_*_Credit=TransID');
    RegisterMe(TCreditGUI, 'TBillsnCheque_LinesDeletedGUI_*_Credit=PurchaseOrderId');
    RegisterMe(TCreditGUI, 'TNumberSequenceListGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TPnLEmployeereportGUI_*_Credit=TransID');
    RegisterMe(TCreditGUI, 'TExpenseClaimListGUI_*_Credit=PurchaseOrderID');
    RegisterMe(TCreditGUI, 'TNonERPPOListGUI_*_Credit=ERPTransId');
  end;
end.
