unit frmInvoice;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 04/04/05  1.00.01 BJ   CourseUpdation : a dynamic function implemeted in the template and
                        initialised in the marketting enquiry form which is required
                        for the course date updation when the form is opened
                        from the marketing package for a course.
 20/04/05  1.00.02 IJB  Added three TfrmCommissionReportGUI fields to Registration.
 18/05/05  1.00.03 IJB  Added TfmForeignSalesList to registration.
 14/06/05  1.00.04 IJB  Modified to show to transfer 'Docket Number'  from
                        customer costs form if
                        AppEnv.CompanyPrefs.ShowDocketNumberColumnOnSales enabled.
 13/07/05  1.00.05DMS  1. Modified function GetBackOrderItemsCount to use
                        the ADO query.
 15/07/05  1.00.06 BJ   Fields added for warranty end date and warranty perioed in the grid
                        The field names are customisable.
 15/07/05  1.00.07 DMS  1. Resetting the shipped quantity after moving BO qty
                           will restore BO field value.
 02/08/05  1.00.08 IJB  Modified copy to smart order code to set costs from line
                        cost if CostonSalesToPO pref is set.
 04/08/05  1.00.09 BJ   Serial form invoked using the SerialNoObj.
 10/08/05  1.00.10 DSP  'Unknown' exceptions are now handled by Exception
                        Magic.
 12/08/05  1.00.11 BJ   Serialno object inroduced. Serialno fieldtype is changed to mediumtext
 30/08/05  1.00.12 DSP  Reconnected grdTransactions OnTitleButtonClick event.
 08/09/05  1.00.13 DSP  Fixed problem where PrintFlag field was not being set
                        when an invoice is printed.
 09/09/05  1.00.14 BJ   Cusotemr lock implemented before saving to update the customer's balance amt

 09/09/05  1.10.00 IJB  Rewrite form to use new Business Objects.
 15/12/05  1.10.01 MV   Fixed issue of printflag error, added printflag persistant fields to
                        tblMaster.
 03/01/06  1.10.02 IJB  Modified btnPickUpFromClick tp use frm variable rather
                        than a mixture of With statement and frm variable.
 05/01/06  1.10.03 IJB  Modified CopyToSmart to copy across Unit Of Measure
                        (this was previously defaulting to 'Units').
 05/01/06  1.10.04 IJB  Added code to BusinessObject to check for unique
                        Customer PO Number and DoBusinessObjectEvent to set
                        focus back to input field.
 09/01/06  1.10.05 BJ   Trying to edit a readonly invoice will open the BO after
                        a user confirmation.
 12/01/06  1.10.06 BJ   canelling 1.10.01 printflag field is deleted from the table
                        and should use the tblPrintdocs table instead.
 30/01/06  1.10.07 DSP  Resized TDBMemo controls.
 03/02/06  1.10.08 DSP  Removed some fields from the grid display.
 09/02/06  1.10.09 DSP  Changed HiddenFields to HideField.
 03/03/06  1.10.10  AL  Commented in ProductxCloseUp the following line:
                        Invoice.Lines.ProductID := cboProductQry.fieldByname('PartsID').asInteger;
                        because it worked wrong if adding related products
 27/04/06  1.10.11  AL  Added RegisterMe(TInvoiceGUI, 'TAccountsReceivableNotes_*=SaleID');
 10/08/06  1.10.12  BJ  onfieldchange of the business object updates the clietnId to 0 if the client is
                        locked and client has 'Use Individual Invoice No.' set to True.
 15/08/06  1.00.13  BJ  using the client object of the invoice object to get the report templateID.
 05/02/07  1.00.14 DSP  Added fbFormAlreadyShown field to prevent the FormShow
                        method from being executed more than once.

}

interface
{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Sales, DB,   wwdbdatetimepicker, wwdblook, StdCtrls,
  DBCtrls, Mask, ExtCtrls, wwcheckbox, Buttons, DNMSpeedButton, DNMPanel,
  Wwdbigrd, Grids, Wwdbgrid, ActnList, SelectionDialog, Menus, AdvMenus,
  {Psock,} ImgList, AppEvnts, CustomerCostForm,wwdbedit,
  MemDS, DBAccess, MyAccess,ERPdbComponents, MessageInterface,ComCtrls,AdvOfficeStatusBar, DataState, DMComps,
  {EmailUtils,}IdGlobal,BusObjBase, BusObjSales, Wwdotdot, Shader,
  ProgressDialog, ERPDbLookupCombo, DNMAction;
const
    SX_OpenINVofBO= WM_USER + 200;
type
  TInvoiceGUI = class(TBaseSaleGUI)
    Label3: TLabel;
    pnlWholesale: TDNMPanel;
    lblWholesale: TLabel;
    cboShipDate: TwwDBDateTimePicker;
    btnPickUpFrom: TDNMSpeedButton;
    lblPickUpFrom: TLabel;
    DNMPanel1: TDNMPanel;
    Label7: TLabel;
    chkManifest: TwwCheckBox;
    DNMPanel2: TDNMPanel;
    wwCheckBox1: TwwCheckBox;
    tmrMonitor: TTimer;
    N2: TMenuItem;
    BatchCreateInvoices1: TMenuItem;
    actBatchInvoices: TAction;
    cmdTimecost: TDNMSpeedButton;
    actCopyToSmart: TAction;
    tblDetailsLastUpdated: TDateTimeField;
    tblDetailsHireID: TIntegerField;
    tblDetailsHireSerials: TWideMemoField;
    tblDetailsIsQuote: TWideStringField;
    tblDetailsHireToBeReturned: TDateField;
    tblDetailsDocketNumber: TWideStringField;
    tblDetailsWarrantyEndsOn: TDateField;
    tblDetailsWarrantyPeriod: TWideStringField;
    chkWholesalePrice: TCheckBox;
    Bevel1: TBevel;
    qryContacts: TERPQuery;
    tblMasterAutoSmartOrderRef: TWideStringField;
    tblDetailsSmartOrderCreated: TWideStringField;
    tblDetailsAutoSmartOrder: TWideStringField;
    tblMasterPOCreated: TWideStringField;
    dtShipContainerETA: TwwDBDateTimePicker;
    lblInvoicePaid: TLabel;
    btnPayment: TDNMSpeedButton;
    Bevel2: TBevel;
    Bevel3: TBevel;
    btnSalesShippingDetailForm: TDNMSpeedButton;
    Label2: TLabel;
    Label4: TLabel;
    wwDBEdit1: TwwDBEdit;
    tblMasterSaleConfirmed: TWideStringField;
    DNMPanel3: TDNMPanel;
    Label9: TLabel;
    wwCheckBox2: TwwCheckBox;
    tblMasterSOProgressPaymentGlobalRef: TWideStringField;
    lblProgressPayment: TLabel;
    tblDetailsProgresspaymentRef: TWideStringField;
    tblMasterSOProgressPaymentOriginalRef: TWideStringField;
    lblInvoice: TLabel;
    DNMSpeedButton3: TDNMSpeedButton;
    actCopyInvoice: TDNMAction;
    tblMasterTotalInvoicePayment: TFloatField;
    tblMasterInvoiceBalance: TFloatField;
    Label13: TLabel;
    dssalesdeliverydetails: TDataSource;
    qrysalesdeliverydetails: TERPQuery;
    qrysalesdeliverydetailsGlobalRef: TWideStringField;
    qrysalesdeliverydetailsID: TIntegerField;
    qrysalesdeliverydetailsSaleID: TIntegerField;
    qrysalesdeliverydetailsPlannedDelfromDt: TDateField;
    qrysalesdeliverydetailsPlannedDelfromTime: TWideStringField;
    qrysalesdeliverydetailsPlannedDelToDt: TDateField;
    qrysalesdeliverydetailsPlannedDeltotime: TWideStringField;
    qrysalesdeliverydetailsPlannedDelFrom: TDateTimeField;
    qrysalesdeliverydetailsPlannedDelto: TDateTimeField;
    qrysalesdeliverydetailsPromisedDelDt: TDateField;
    qrysalesdeliverydetailsPromisedDeltime: TWideStringField;
    qrysalesdeliverydetailsPromisedDel: TDateTimeField;
    qrysalesdeliverydetailsCauseofDelayID: TIntegerField;
    qrysalesdeliverydetailsCauseofDelay: TWideStringField;
    qrysalesdeliverydetailsActualDelDt: TDateField;
    qrysalesdeliverydetailsActualDeltime: TWideStringField;
    qrysalesdeliverydetailsActualDel: TDateTimeField;
    qrysalesdeliverydetailsFeedBack: TWideMemoField;
    qrysalesdeliverydetailsmstimestamp: TDateTimeField;
    qrysalesdeliverydetailsSalesglobalref: TWideStringField;
    Label14: TLabel;
    tblDetailsBOMGroupedLine: TWideStringField;
    tblDetailsBOMProductionLine: TWideStringField;
    tblDetailsAssembled: TWideStringField;
    btnsplitPay: TDNMSpeedButton;
    tblMasterProgressPaymentInvRef: TWideStringField;
    tblMasterProgressPaymentSeqno: TIntegerField;
    mnuPrintAddressLabel: TMenuItem;
    tblDetailsExcludeFromSmartOrder: TWideStringField;
    tblDetailsVoucherNo: TWideStringField;
    tblMasterSOInvoiced: TWideStringField;
    tblMasterSOInvoiceRef: TWideStringField;
    tblDetailsSOInvoiceLineRef: TWideStringField;
    tblMasterIsInternalOrder: TWideStringField;
    tbldetailsPPGInvoiced: TWideStringField;
    tbldetailsPPGRef: TWideStringField;
    procedure actBatchInvoicesExecute(Sender: TObject);
    procedure actBatchInvoicesUpdate(Sender: TObject);
    procedure actDelDocketExecute(Sender: TObject);
    procedure actPickExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnPickUpFromClick(Sender: TObject);
    procedure cboEmployeeNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    //procedure cboProductXCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboTermsNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure cmdDeliveryDocketClick(Sender: TObject);
    procedure cmdFaxClick(Sender: TObject);
    procedure cmdTimecostClick(Sender: TObject);
    procedure ConsolidateCustBO;
    procedure edtCompanySearchFilterExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure grdTransactionsTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure smtpInvoiceAuthenticationFailed(var Handled: boolean);
    procedure smtpInvoiceConnect(Sender: TObject);
    procedure smtpInvoiceInvalidHost(var Handled: boolean);
    procedure tmrMonitorTimer(Sender: TObject);
    procedure grdTransactionsKeyPress(Sender: TObject; var Key: Char);
    procedure ETAInfoClick(Sender: TObject);
    procedure grdTransactionsEnter(Sender: TObject);
    procedure grdTransactionsCalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure cboProductRChange(Sender: TObject);
    procedure cboCreationDateCloseUp(Sender: TObject);
    procedure btnPaymentClick(Sender: TObject);
    procedure btnSalesShippingDetailFormClick(Sender: TObject);
    procedure lblProgressPaymentDblClick(Sender: TObject);
    procedure tblMasterAfterInsert(DataSet: TDataSet);
    procedure lblInvoiceClick(Sender: TObject);
    procedure actCopyInvoiceExecute(Sender: TObject);
    procedure actCopyInvoiceUpdate(Sender: TObject);
    procedure doShowPayments(Sender: TObject);
    procedure tblMasterCalcFields(DataSet: TDataSet);
    procedure btnPDFClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure tblMasterAfterOpen(DataSet: TDataSet);
    procedure cmdEmailClick(Sender: TObject);
    procedure btnsplitPayClick(Sender: TObject);
//    procedure actSignatureExecute(Sender: TObject);
//    procedure actSignatureUpdate(Sender: TObject);
    procedure grdTransactionsRowChanged(Sender: TObject);
    procedure tblDetailsAfterInsert(DataSet: TDataSet);
    procedure mnuPrintAddressLabelClick(Sender: TObject);
    procedure cboCreationDateExit(Sender: TObject);
    procedure actconsmartExecute(Sender: TObject);
    procedure actconsmartUpdate(Sender: TObject);
    procedure doShowPrepayments(Sender: TObject);Override;
    procedure cboClassEnter(Sender: TObject);
    procedure txtCustomIDDblClick(Sender: TObject);

  private
    { Private declarations }
    bInitialiseStartup: boolean;
    bShipToOverride: boolean;
    ConsolidateCustBOonInvoiceOnce: boolean;
    CustomerCostGUI: TCustomerCostGUI;
//    FEmailSender: T2cEmailSender;
    iCustomerID: integer;

    //fbGrdDblClickSerials :boolean;
    fbNoConvertQuestion: Boolean;
    fbFormAlreadyShown: Boolean;
    CreditInvocieID:Integer;
    DeletingAllBomGroup:Boolean;
    procedure MoveBOQuantitiesToShipped;
    Function ProcessBackOrderInvoiceItems :Boolean;
    procedure HandleInvoiceErrors;
    Procedure OpenINVOfBO(Var Msg :TMessage); message SX_OpenINVofBO;
    Procedure CreatePayment;
    //Procedure InitcustPayment(Sender:TObject);
    function InvoiceReportName:String;
    procedure PrintDeldocket;
    function DeleteAllBomGroup(LineID:Integer): Boolean;
    function ProgressPaymentSOConverted(const SOREf: String): Boolean;
    function SendPrintSMS: boolean;
    function SendPrintSMSSilent: boolean;
    function SendPrintEmail: boolean;
    //function SendPrintEmailAttach: boolean;
    function SendPrintEmailSilent: boolean;
    function IstobeApprovednNotApproved: Boolean;
    procedure BackOrdersListbeforeShow(Sender: TObject);
    procedure OnSelectBackOrders(Sender: TwwDbGrid);
    (*Procedure DoOnDoNotAskMsgCheck(Sender:TObject);Overload;Override;*)
  protected
    function EmailTransaction(const RecipientAddress :String ='';ASilent: boolean=True; ASecret : boolean=True): boolean;Override;
    function ReturnType:String;Override;
    function GetReportTypeID: Integer; override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); override;
    function Saverecord :boolean; override;
    Function IstransLineLocked:Boolean; Override;
    procedure PaymentLockValidate; Override;
    procedure DoOnClientchange;Override;
    procedure SetDatasetconn;Override;
    {$IFDEF FORM_BASED_SELECT_SQL}
    function TransSpecificSQL :String;Override;
    {$ENDIF}
    function DeleteLinerecord:Boolean;Override;
    procedure CommitAndNotify;Override;
    function SaveTransToPDF: boolean; override;
    procedure Lockcomponents;override;
    procedure NewTransBusObjinstance;override;
    procedure SetDirty(aDirty : boolean);override;
    procedure AfterSubFormShow(Sender: TObject);override;
    procedure beforeSubFormShow(Sender: TObject); Override;
    (*procedure InitreportOptionsform(Sender: TObject);Override;*)
    function Save4NewTrans: Boolean;Override;

  public
    Invoice: TInvoice;
    bIgnoreEvent: boolean;
    function IsOkToSave: boolean; override;
    class procedure CloseMe; override;
    property NoConvertQuestion: Boolean read fbNoConvertQuestion write fbNoConvertQuestion;
    procedure DoOnProductchange;Override;
    procedure UpdateMe(const Cancelled: Boolean; const aObject: TObject = nil); override;
    procedure UpdateMe; override;
    function SaveSalesRecord: boolean;Override;
    procedure DoOnDoNotAskMsgCheck(Sender: TObject; Checked: boolean);Overload;Override;
    Procedure DoOnDoNotAskMsgCheck(Sender:TObject);Overload;Override;
    //procedure SendEmailCallback(const ACommaContactEmails : string; ASilent, ASecret : boolean); override;
  published
    function InitialiseCustomerID(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
    property CustomerID: integer read iCustomerID write iCustomerID;
    property InitialiseStartup: boolean read bInitialiseStartup write bInitialiseStartup; //write bInitialiseStartup;
  end;

implementation

{$R *.dfm}

uses
  FormFactory,  DNMExceptions, CommonDbLib, DateUtils,frmPickupFromAddressPopup,
  FaxObj, BaseTransForm,BackOrderListForm, QueryManipulationObj,frmBatchInvoiceCreationGUI,
  frmSmartOrderFrm,frmProductETAInfo,ShippingOptions, tcTypes, Math, Types,
  BusObjTrans, BusObjPrintDoc, BusObjConst, CommonLib,
  tcDataUtils,BaseInputForm, XMLEmailObj,
  AppEnvironment, FastFuncs, BusobjSaleBase, DNMLib, tcConst, MySQLConst,
  BaseFormForm, busobjPQA, frmAllocation,frmProductQtysBinsETAs,
  frmShippingContainerGUI, LogUtils, frmCustPayments, CommonFormLib,
  BusobjSalesShippingDetails, frmShippingDetails, busobjSalesDelDetails,
  frmSalesDeliveryDetails,  saleslib, BusObjClient,
  frmReportingOptions, frmMobileNumberInput, BusObjContact,
  frmShippingAllocation, IdFTP, URLObj, frmSplitInvoicePayment, XMLIntf, XMLDoc,
  SalesXMLUtils, CorrespondenceObj, EmailLib, EmailUtils, EmailExtraUtils,
  frmSignatureEdit, EmployeeAccesses, DbSharedObjectsObj, TemplateReportsLib,
  BusObjFeTransLines, UserLockBaseObj;

function TInvoiceGUI.SaveSalesRecord: boolean;
begin
  result := True;
  if not invoice.dirty then exit;
  try
    if FullBackOrder then
      if (not invoice.IsTotalBackOrder) and (invoice.cleancustomer <> '') then begin
        invoice.SaleDate := now;
        invoice.Shipdate := now;
        invoice.Saledatetime := now;
        invoice.PostDB;
      end;

//    if accesslevel = 5 then begin
//      Invoice.CancelDb;
//      exit;
//    end;
    lblProcessMessage.Caption := 'Saving....';
    lblProcessMessage.visible := true;
    Try
      SetControlFocus(btnCompleted);
      if AccessLevel >= 5 then begin
        Invoice.Dirty := False;
      end else begin
        if Invoice.Dirty then begin
          Invoice.ResultStatus.Clear;
            if Appenv.companyPrefs.EnableAvaTax then   Result := CalcAvaTax;
            if not result then exit;
            if Invoice.Save then begin
              Invoice.Dirty := false;
            end else begin
              Result := false;
              //HandleInvoiceErrors;
            end;
        end;
      end;
    finally
      if result then else HandleInvoiceErrors;
      lblProcessMessage.visible := False;
    end;
  finally
    Invoice.ResultStatus.clear;
  end;
end;


function TInvoiceGUI.SaveTransToPDF: boolean;
begin
  result := true;
  DisableForm;
  try
    if SaveSalesRecord then begin
      fbReportSQLSupplied :=   False;
      if chkChooseRpt.checked = False then  ReportToPrint := InvoiceReportName;
      Self.CommitAndNotify;
      try
        Invoice.Dirty:= false;
        inherited;
      except
        on E:Exception do begin
            commonlib.MessageDlgXP_Vista('Export to PDF failed.' +CHR(13) +CHR(13) + E.Message , mtWarning, [mbok] , 0);
            self.BeginTransaction;
        end;
      end;
      self.BeginTransaction;
    end;
  finally
    EnableForm;
  end;
end;

function TInvoiceGUI.SendPrintEmail: boolean;
var
  recip: string;
begin
  recip := GetContactEmails(Invoice.ClientId, 'MainContactForInvoice');
  result := TCorrespondenceGui.EmailCustomerSale(recip, GetSalesEmails,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.InvoiceMailSubject, PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.InvoiceMailText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger);
end;


function TInvoiceGUI.SendPrintEmailSilent: boolean;
var
  toEmail: string;
begin
  toEmail := GetContactEmails(Invoice.ClientId, 'MainContactForInvoice');

  Result := TCorrespondenceGui.EmailCustomerSale(toEmail, GetSalesEmails,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.InvoiceMailSubject, PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.InvoiceMailText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger, True);
end;

function TInvoiceGUI.SendPrintSMS: boolean;
var
  number: string;
begin
  result := false;
  number := GetOrAddMobileNumber;
  if number = '' then exit;

  result := TCorrespondenceGui.SMSCustomer(number,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.InvoicePrintSMSText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger);
end;

function TInvoiceGUI.SendPrintSMSSilent: boolean;
var
  toMobile: string;
begin
  toMobile := Invoice.ContactMobile;
  if toMobile = '' then
    toMobile := Invoice.Customer.Mobile;

  result := TCorrespondenceGui.SMSCustomer(toMobile,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.InvoicePrintSMSText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger, true);
end;

procedure TInvoiceGUI.SetDatasetconn;
begin
  inherited;
  qrysalesdeliverydetails.connection := MyConnection;
end;

procedure TInvoiceGUI.SetDirty(aDirty: boolean);
begin
  inherited;
  self.Invoice.Dirty := aDirty;
end;

procedure TInvoiceGUI.CommitAndNotify;
var
  MsgObj: TMsgObj;
  ClientID: integer;
begin
  ClientID:= Invoice.ClientID;
  CommitTransaction;
  AfterCommit; // virtual method used in decendants
  Notify;

  MsgObj := TMsgObj.Create;
  MsgObj.SetAddress('TfmMarketingLead', 'InvoiceSaved');
  MsgObj.IntValue := ClientID;
  fMsgHandler.Send(MsgObj);
end;


procedure TInvoiceGUI.HandleInvoiceErrors;
var
  FatalStatusItem: TResultStatusItem;
begin
  FatalStatusItem := Invoice.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    case FatalStatusItem.Code of
      BOR_Sales_Err_InvalidDepartment: SetControlFocus(cboClass);
      BOR_Sales_InvalidPONumber: begin
        if (txtPONumber.visible) and (txtPONumber.enabled) then Activecontrol :=txtPONumber;

      end;
    end;
  end;
end;

procedure TInvoiceGUI.btnCompletedClick(Sender: TObject);
var
  msgTo: string;
begin
  DisableForm;
  try
        {change record pointer before Calling Save from the Progress payment record as it makes the record readonly}
          if Sametext(invoice.lines.ProductName, PART_PROGRESSPAYMENT_TERMS) then begin
            if invoice.lines.count >1 then begin
              if invoice.lines.dataset.recno < invoice.lines.dataset.recordcount then invoice.lines.Next
              else if invoice.lines.dataset.recno > 1 then invoice.lines.Prior;
              LockSales;
            end;
          end;


    Invoice.Signed := not tblMasterClientSignature.IsNull and (tblMasterClientSignature.BlobSize > 0);

    if not SaveSalesRecord then Exit;

    CommitAndNotify;
    if AppEnv.CompanyPrefs.AutomaticDeliveryDocketPrint then (* actDelDocketExecute(nil) *)PrintDeldocket;
    if AppEnv.CompanyPrefs.EmailInvoiceInfoToCustomer then self.DoEmailTransaction;
    if AppEnv.CompanyPrefs.EnableInvoiceSaveMail and ((Invoice.ContactEmail <> '') or (Invoice.Customer.Email <> '')) then begin
      msgTo := Invoice.ContactEmail;
      if msgTo = '' then msgTo := Invoice.Customer.Email;

      TCorrespondenceGui.EmailCustomerSale(msgTo,GetSalesEmails,
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.InvoiceSaveEmailSubject, PopulateMessageSubstituteList),
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.InvoiceSaveEmailText, PopulateMessageSubstituteList),
        self.tblMasterClientID.AsInteger, True);

    end;
    if AppEnv.CompanyPrefs.SMSEnabled and
       AppEnv.CompanyPrefs.EnableInvoiceSaveSMS and
       ((Invoice.ContactMobile <> '') or (Invoice.Customer.Mobile <> '')) then begin

      msgTo := Invoice.ContactMobile;
      if msgTo = '' then msgTo := Invoice.Customer.Mobile;

      { send SMS silently }
      TCorrespondenceGui.SMSCustomer(msgTo,
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.InvoiceSaveSMSText, PopulateMessageSubstituteList),
        self.tblMasterClientID.AsInteger, true);
    end;

    if Invoice.ShippedQtyChanged then begin

      if AppEnv.CompanyPrefs.EnableInvShipChangeEmail and ((Invoice.ContactEmail <> '') or (Invoice.Customer.Email <> '')) then begin
        msgTo := Invoice.ContactEmail;
        if msgTo = '' then msgTo := Invoice.Customer.Email;

        TCorrespondenceGui.EmailCustomerSale(msgTo, GetSalesEmails,
          TMailUtils.SubstituteText(AppEnv.CompanyPrefs.InvShipChangeEmailSubject, PopulateMessageSubstituteList),
          TMailUtils.SubstituteText(AppEnv.CompanyPrefs.InvShipChangeEmailText, PopulateMessageSubstituteList),
          self.tblMasterClientID.AsInteger);

      end;
      if AppEnv.CompanyPrefs.SMSEnabled and
         AppEnv.CompanyPrefs.EnableInvShipChangeSMS and
         ((Invoice.ContactMobile <> '') or (Invoice.Customer.Mobile <> '')) then begin

        msgTo := Invoice.ContactMobile;
        if msgTo = '' then msgTo := Invoice.Customer.Mobile;

        { send SMS silently }
        TCorrespondenceGui.SMSCustomer(msgTo,
          TMailUtils.SubstituteText(AppEnv.CompanyPrefs.InvShipChangeSMSText, PopulateMessageSubstituteList),
          self.tblMasterClientID.AsInteger, true);
      end;

    end;
    Invoice.Dirty := False;
    if fsModal in Self.FormState then ModalResult := mrOk
    else Close; // close the form
  finally
    EnableForm;
  end;
end;

procedure TInvoiceGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TInvoiceGUI.FormShow(Sender: TObject);
var
  qryEmailedList: TERPQuery;
begin
mnuconvertedToList.Enabled := False;
stepProgressbar;
try
  DisableForm;
  try
      //fbGrdDblClickSerials := false;
    if not fbFormAlreadyShown then begin
      fbFormAlreadyShown := True;
      try
        grdTransactionsTitleButtonClick(grdTransactions, 'LinePrice');
        bCreditCheckOn := AppEnv.CompanyPrefs.CreditCheckInv;

        if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnGiveDiscount') >= 3 then
          GuiPrefs.DbGridElement[grdTransactions].AddreadonlyField('DiscountPercent');

        inherited;
        Invoice.Lines.DataSet.Filter := Invoice.Lines.DataSet.Filter +' and BOMProductionLine <> '+Quotedstr('T');

        with qryShipContainerSaleLookup do begin
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('`SC`.`ContainerName`,');
          SQL.Add('`SD`.`PurchaseLineID`,');
          SQL.Add('`SC`.`ETA`,');
          SQL.Add('`SC`.`Active`,');
          SQL.Add('`invlines`.`SaleLineID`');
          SQL.Add('FROM');
          SQL.Add('`tblshippingcontainer` AS `SC`');
          SQL.Add('Inner Join `tblshipcontainerdetails` AS `SD` ON `SC`.`ShippingContainerID` = `SD`.`ShippingContainerID`');
          SQL.Add('Inner Join `tblpurchaselines` AS `polines` ON `SD`.`PurchaseLineID` = `polines`.`PurchaseLineID`');
          SQL.Add('Inner Join `tblsaleslines` AS `solines` ON `solines`.`SaleLineID` = `polines`.`SaleLineID`');
          SQL.Add('Inner Join `tblsaleslines` AS `invlines` ON `solines`.`ProductID` = `invlines`.`ProductID` AND `solines`.`SeqNo` = `invlines`.`SeqNo`');
          SQL.Add('Where invlines.SaleId = ' + IntToStr(KeyId));
          SQL.Add('and solines.saleId = ' + IntToStr(tinvoice.idtoggle(invoice.salesorderGlobalref)));
          Open;
        end;

          if keyId <> 0 then begin
            if (Invoice.IsBOInvoiced) then begin
             (*CommonLib.MessageDlgXP_Vista('Please be Aware that Access to This '+
                                TypeToDescription(ClassNameToTranType(Self.ClassName))+
                                ' Record is Read-Only.', mtWarning, [mbOK], 0);*)
             TransAccessMsg:= 'Grid is Read-Only.  Back Order already invoiced';
             TransTimerMsg(TransAccessMsg , 5);
             fLockSalesInitialized:= false;
              TransAccesslevel := 5;
              Locksales;
            end;

              if (Accesslevel >3 )  then begin
                {Set the form to read only because we don't want to allow edits when a backorder has been invoiced}
                if dgEditing in grdTransactions.Options then
                    grdTransactions.Options := grdTransactions.Options - [dgEditing];

                if dgAllowInsert in grdTransactions.KeyOptions then
                  grdTransactions.KeyOptions := grdTransactions.KeyOptions - [dgAllowInsert] ;
                // cboProductX.ReadOnly := True;
                cboclientR.ReadOnly := True;
                cboClass.ReadOnly := True;
                cboEmployee.ReadOnly := True;
                cboTaxCode.ReadOnly := True;
                if Invoice.IsBOInvoiced then begin
                  TransAccessMsg :='This invoice''s BackOrder already ''Shipped''';
                  Caption := TitleLabel.Caption + '(Frozen) - ' + TransAccessMsg ;
                end;
              end;

              { 2/7/2014  The following was removed at Federal Wages request,
                          they want to be able to edit an invoice that has been sent!! }
(*
              else if accesslevel = 1 then
                 if (Invoice.Shipment.Count > 0) and (Invoice.Shipment.Status = 'Processed') then begin
                  Caption := TitleLabel.Caption + '(Frozen) - This Invoice''s Shipment(s) Processed';
                  accesslevel:= 5;
                end;
*)
          end else begin
            //Locksales;
          end;

        if (Invoice.ShipmentList.Count > 0) and (Invoice.ShipmentList.Status = 'Processed') then
          btnShipment.Color := $0077ff77;


        if (accesslevel <= 3) and (TransAccesslevel <= 3) then self.SaleBase.DoCalcOrderTotals;

        lblEstimatedFinalAmt.Caption:=
          FloatToStrF(SaleBase.TotalEstimatedAmountInc, ffCurrency, 15, CurrencyRoundPlaces);
        btnPickUpFrom.Visible := true;
        lblPickUpFrom.Visible := true;
        if (AppEnv.CompanyPrefs.ManifestType = 'INVOICE') or (AppEnv.CompanyPrefs.ManifestType = 'BOTH') then begin
          Label7.Visible := true;
          chkManifest.Visible := true;
          DNMPanel1.Visible := true;
        end;

        if KeyID = 0 then begin
          iClientID := 0;
          btnPickUpFrom.Enabled := false;
        end else begin
          iClientID := Invoice.CustomerID;
          If not Empty(Invoice.DocNumber) then begin
            qryEmailedList := TERPQuery.Create(nil);
            qryEmailedList.Options.FlatBuffers := True;
            try
              qryEmailedList.Connection := CommonDbLib.GetSharedMyDacConnection;
              qryEmailedList.Sql.Clear;
              qryEmailedList.Sql.Add('SELECT * FROM tblEmailedReports WHERE reporttype = "Invoice" and TransactionID = ');
              qryEmailedList.Sql.Add(Quotedstr(Invoice.DocNumber));
              qryEmailedList.Open;
              if qryEmailedList.FieldByName('ContactID').asinteger <> 0 then begin
                EmailContactID := qryEmailedList.FieldByName('ContactID').asinteger;
              end;
            finally
              FreeAndNil(qryEmailedList);
            end;
          end;
          showRedeemPoints(Invoice.SaleDate);
        end;

        if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnShowMargin') = ACCESS_ALLOWED then begin
          lblMargin.Visible := true;
          lblMarginLabel.Visible := true;
          lblCost.Visible := true;
          lblCostLabel.Visible := true;
        end
        else begin
          lblMargin.Visible := false;
          lblMarginLabel.Visible := false;
          lblCost.Visible := false;
          lblCostLabel.Visible := false;
        end;



        if AppEnv.CompanyPrefs.BarcodePickingInSOMode then begin
          DNMPanel2.Visible := false;
        end;

        // Are we opening up with given parameters?
        if InitialiseStartup then begin
//          Invoice.CustomerName := GetClientName(CustomerID);
          Invoice.ClientId := CustomerID;
          Invoice.PostDB;
          Invoice.EditDB;

          cboClientR.SearchMode := TERPLookupComboSearchMode.smStartsWith;
          cboClientR.Text := GetClientName(CustomerID);
          cboClientR.F6Search;
          cboClientR.LookupTable.Locate('ClientID', CustomerID, []);

//          cboClientR.LookupTable.Locate('ClientID',Invoice.ClientId,[]);
//          cboClientR.Text := GetClientName(CustomerID);
          InitialiseStartup := False;
        end;

        grdTransactions.RemoveField('BOMGroupedLine');
        GuiPrefs.DbGridElement[grdTransactions].HideField('BOMGroupedLine');
        grdTransactions.RemoveField('BOMProductionLine');
        GuiPrefs.DbGridElement[grdTransactions].HideField('BOMProductionLine');


        if not AppEnv.CompanyPrefs.ShowDocketNumberColumnOnSales then
        begin
          grdTransactions.RemoveField('DocketNumber');
          GuiPrefs.DbGridElement[grdTransactions].HideField('DocketNumber');
        end
        else
          grdTransactions.AddField('DocketNumber');


        lblBaseForeignCurrencyCode.Enabled := AppEnv.CompanyPrefs.UseForeignCurrencyOnSales;
        cboBaseForeignCurrencyCode.Enabled := AppEnv.CompanyPrefs.UseForeignCurrencyOnSales;
        lblBaseExchangeRate.Enabled := AppEnv.CompanyPrefs.UseForeignCurrencyOnSales;
        edtBaseExchangeRate.Enabled := AppEnv.CompanyPrefs.UseForeignCurrencyOnSales;

        btnSignature.Enabled := AccessLevel < 3;

      except
        on EAbort do HandleEAbortException;

        on e: ENoAccess do begin
          HandleNoAccessException(e);
          Exit;
        end;

        on e: Exception do raise;
      end;

        // Put these after try block cuz we want these to be executed regardless of access level

      {Showing/hiding the warranty fields based on the preference
      change the caption of the warranty fields based on the Preference}
      if AppEnv.CompanyPrefs.ShowSalesWarrantyEndsOn = false then
      begin
        grdTransactions.RemoveField('WarrantyEndsOn');
        GuiPrefs.DbGridElement[grdTransactions].HideField('WarrantyEndsOn');
      end
      else
        grdTransactions.AddField('WarrantyEndsOn');

      if AppEnv.CompanyPrefs.ShowSalesWarrantyPeriod = false then
      begin
        grdTransactions.RemoveField('WarrantyPeriod');
        GuiPrefs.DbGridElement[grdTransactions].HideField('WarrantyPeriod');
      end
      else
        grdTransactions.AddField('WarrantyEndsOn');

      if Trim(AppEnv.CompanyPrefs.SalesWarrantyEndsOnCaption) <> '' then
        grdTransactions.ColumnByName('WarrantyEndsOn').DisplayLabel :=
          Trim(AppEnv.CompanyPrefs.SalesWarrantyEndsOnCaption);

      if Trim(AppEnv.CompanyPrefs.SalesWarrantyPeriodCaption) <> '' then
        grdTransactions.ColumnByName('WarrantyPeriod').DisplayLabel :=
          Trim(AppEnv.CompanyPrefs.SalesWarrantyPeriodCaption);

      grdTransactions.ColumnByName('Discounts').DisplayLabel := 'Discount ('+AppEnv.RegionalOptions.CurrencySymbol+')';

//      SaveFieldPrefs(GuiPrefs);
      Invoice.Dirty := false;

    end;
    AddRewardPointmenuITems;
  finally

    EnableForm;
    SetControlFocus(cboClientR);

  end;

//  if FileExists('c:\p1\dev\Temp_Grid.txt') then
//    grdTransactions.Selected.LoadFromFile('c:\p1\dev\Temp_Grid.txt');
finally
  CheckshiptoAccess;
  Enabledisable;
  hideProgressbar;
  ShowGridLockMsg;
  Lockcomponents;
end;
end;

//procedure TInvoiceGUI.cboProductXCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
//begin
//  if (modified = false) then exit;
//  if Matrixshown then exit;
//
//  inherited;
//  if chkWholesalePrice.Checked then begin
//    tblDetails.FieldByName('LinePrice').AsFloat :=
//      cboProductX.LookupTable.FieldByName('WholeSalePrice').AsFloat;
//  end;
//end;

procedure TInvoiceGUI.btnPrintClick(Sender: TObject);
var
  OptsForm: TfmReportingOptions;
  IsEnabled: boolean;
begin
  if not SaveSalesRecord then Exit;

  if not(IstobeApprovednNotApproved) then exit;
  if not EmployeeAccesses.AllowPrintInvoiceduplicate then
    if Invoice.isPrinted then begin
      MessageDlgXP_Vista('This Invoice is Already Printed.  You Don''t have Access to Print Dupilcate of Invoice.', mtWarning, [mbOK], 0);
      Exit;
    end;
  OptsForm := EmailOptsForm;//TfmReportingOptions.Create(nil);
  try
    OptsForm.ActionList.AddDivider('Print');
    OptsForm.ActionList.Add('Print', 'Print an invoice', actPrintExecute, True, True);
    OptsForm.ActionList.Add('Preview', 'Preview an invoice', self.actPreviewExecute, True, True);
    OptsForm.ActionList.Add('Picking', 'Print a picking slip', self.actPickExecute, False, True);
    OptsForm.ActionList.Add('Delivery', 'Print a delivery docket', self.actDelDocketExecute, false, true);
    OptsForm.ActionList.Add('Save PDF','Save a PDF Invoice to your computer', SaveTransToPDF, true, true);
    if Invoice.AnylineIsBatchEnabled then OptsForm.ActionList.Add('Dispatch Barcode', 'Print Sales Dispatch Batch Barcode', PrintSalesDispatchBarcode, true, true);

    OptsForm.ActionList.AddDivider('Email', 'Email to the Customer and CC to Employees Tracking Sales Emails');
    OptsForm.ActionList.Add('Email Invoice', 'Email a copy of the Invoice', DoEmailTransaction, true, true);
    OptsForm.ActionList.Add('Email Silently', 'Email a copy of the Invoice Silently', DoEmailTransactionSilentnSecret, true, true);
    OptsForm.ActionList.Add('Email Invoice (Edit)', 'Edit Email Message Before Sending, With a Copy of the Invoice', DoEmailTransactionnonsilent, true, true);
    //OptsForm.ActionList.Add('Email Invoice (Edit)', 'Edit email message before sending, with a copy of the Invoice', self.SendPrintEmailAttach, true, true);
    OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without Invoice', self.SendPrintEmailSilent, true, true);
    OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without Invoice', self.SendPrintEmail, true, true);

    OptsForm.ActionList.AddDivider('SMS');
    IsEnabled := AppEnv.CompanyPrefs.SMSEnabled and
       AppEnv.CompanyPrefs.EnableInvoicePrintSMS and
       ((Invoice.ContactMobile <> '') or (Invoice.Customer.Email <> ''));
    OptsForm.ActionList.Add('SMS', 'Just send SMS', self.SendPrintSMSSilent, true, IsEnabled);
    OptsForm.ActionList.Add('SMS (Edit)', 'Edit SMS before sending', self.SendPrintSMS, true, AppEnv.CompanyPrefs.SMSEnabled);
    //OptsForm.InitforParent := InitreportOptionsform;
    OptsForm.ShowModal;
    CloseAfterPrint(OptsForm.CloseWhenDone);
  finally
    OptsForm.Free;
  end;
end;
(*Procedure TInvoiceGUI.InitreportOptionsform(Sender:TObject);
begin
  inherited;
  if sender is TfmReportingOptions then begin
    TfmReportingOptions(Sender).chkEmailprogramconfrmation.visible := True;
    TfmReportingOptions(Sender).chkEmailprogramconfrmation.checked := DoNotAskMsg;
    TfmReportingOptions(Sender).chkEmailprogramconfrmation.onclick := DoOnDoNotAskMsgCheck;
    if DoNotAskMsg then
      TfmReportingOptions(Sender).chkEmailprogramconfrmation.caption := TfmReportingOptions(Sender).chkEmailprogramconfrmation.caption +' (' + EmailOptiontoStr(MessageOption)+')';

  end;
end;*)

procedure TInvoiceGUI.actPrintExecute(Sender: TObject);
begin
  if ((Invoice.TotalBalance - Invoice.TotalPrePayments) > 0) and (not EmployeeHasAccess('FnAllowInvoicePrintWithNonZeroBalance')) then begin
    CommonLib.MessageDlgXP_Vista('You do not have Access to Print Invoicess with an Outstanding Balance.', mtWarning, [mbOK], 0);
    exit;
  end;
  ReportToPrint := '';
  DisableForm;
  try
    if SaveSalesRecord then begin
      fbReportSQLSupplied :=   False;
      if chkChooseRpt.checked = False then  ReportToPrint := InvoiceReportName;
      self.CommitAndNotify;
      try

        Invoice.Dirty:= false;

        inherited;
//        if (AppEnv.Employee.CloseOnPrint and not DontCloseAfterPrint) or (CloseByPicking and not DontCloseAfterPrint) then begin
//          closeAfterPrint;
//        end;
      finally
//        if ReEnable then
          self.BeginTransaction;
      end;
    end;

    // Send auto email
    if AppEnv.CompanyPrefs.EnableInvoiceMail and ((Invoice.ContactEmail <> '') or (Invoice.Customer.Email <> '')) then
      SendPrintEmailSilent;

  finally
//    if ReEnable then
      EnableForm;
  end;
end;
(*
procedure TInvoiceGUI.actSignatureExecute(Sender: TObject);
begin
  inherited;
  if frmSignatureEdit.GetClientSignature(self.tblMasterClientSignature) then
    self.Invoice.Dirty := true;
end;
(*
procedure TInvoiceGUI.actSignatureUpdate(Sender: TObject);
begin
  inherited;
  if self.tblMasterClientSignature.BlobSize > 0 then
    btnSignature.Color := $0077ff77
  else
    btnSignature.Color := clBtnFace;
end;
*)
procedure TInvoiceGUI.btnPreviewClick(Sender: TObject);
begin
  if not EmployeeAccesses.AllowPrintInvoiceduplicate then
    if Invoice.IsPrinted then begin
      MessageDlgXP_Vista('This Invoice is Already Printed.  You Don''t have Access to Print Dupilcate of Invoice.', mtWarning, [mbOK], 0);
      Exit;
    end;

  actPreviewExecute(nil);
  CloseAfterPrint;
end;

function TInvoiceGUI.IstobeApprovednNotApproved:Boolean;
begin
  REsult:= True;
  if Appenv.CompanyPrefs.InvoiceHasToBeApproved and (not(Sametext(Invoice.SalesStatus , 'Approved'))) then begin
      MessageDlgXP_vista('The invoice has to be ''Approved'' inorder to Print / Preview / Email / Payment and the current status is ' +Quotedstr(Invoice.SalesStatus)+'. '+ NL+
                        'Please change status to ''Approved''.', mtWarning, [mbOK], 0);
      REsult := False;
      Exit;
  end;
end;

procedure TInvoiceGUI.actPreviewExecute(Sender: TObject);
begin
  if not SaveSalesRecord then Exit;
  if ((Invoice.TotalBalance - Invoice.TotalPrePayments) > 0) and (not EmployeeHasAccess('FnAllowInvoicePrintWithNonZeroBalance')) then begin
    CommonLib.MessageDlgXP_Vista('You do not have Access to Print Invoicess with an Outstanding Balance.', mtWarning, [mbOK], 0);
    Exit;
  end;

  ReportToPrint := '';
  if not(IstobeApprovednNotApproved) then Exit;

  DisableForm;
  try
    fbReportSQLSupplied :=   False;
    if chkChooseRpt.Checked = False then ReportToPrint := InvoiceReportName;
    Self.CommitAndNotify;
    try
      Invoice.Dirty:= false;
      inherited;
    finally
      self.BeginTransaction;
    end;
  finally
    EnableForm;
  end;
end;

procedure TInvoiceGUI.actPickExecute(Sender: TObject);
begin
    ReportToPrint := '';
  DisableForm;
  try
    if SaveSalesRecord then Begin
      Self.CommitAndNotify;
      if PrintSalesPickingSlip then begin
//        if (AppEnv.Employee.CloseOnPrint and not DontCloseAfterPrint) or (CloseByPicking and not DontCloseAfterPrint) then
//          closeAfterPrint
//        else
//          self.BeginTransaction;
      end;
//      else
//        self.BeginTransaction;
    end;
  finally
    self.BeginTransaction;
    EnableForm;
  end;
end;

procedure TInvoiceGUI.cmdDeliveryDocketClick(Sender: TObject);
begin
  if IsOkToSaveSale() then inherited;
end;

procedure TInvoiceGUI.cmdEmailClick(Sender: TObject);
begin
  if not(IstobeApprovednNotApproved) then exit;
  inherited;
end;

Function  TInvoiceGUI.Save4NewTrans:Boolean;
begin
  // If user does not have access to this form don't process any further
  Result := False;
  DisableForm;
  try
    if Invoice.Dirty then begin
      case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
        mrYes:
          begin
            if SaveSalesRecord then begin
               CommitAndNotify;  // current record should be commited before inserting new reocrd
               Result := True;
            end else Exit;
          end;
        mrNo:
          begin
            // Cancel edits and Rollback changes
            RollbackTransaction;
            Result := True;
          end;
        mrCancel:
          begin
            Exit;
          end;
      end;
    end else begin
      REsult := True;
    end;

  finally
    EnableForm;
  end;
end;

Procedure TInvoiceGUI.NewTransBusObjinstance;
begin
  Freeandnil(Invoice);
  Invoice := TInvoice.Create(Self);
  Invoice.Name:= 'InvoiceObj';
  Invoice.DoProductallocation := DoProductallocation;
  SaleBase := Invoice;  // point business object on BaseSales form to instantiated invoice object.
  inherited;
end;

procedure TInvoiceGUI.FormCreate(Sender: TObject);
begin
  Showcontrolhint(cboShipDate , 'Changing Shiped Quantity on Lines will update this to the Current Date' );
  Showcontrolhint(cboCreationDate , 'Changing Shiped Quantity on Lines will update this to the Current Date' );
  DeletingAllBomGroup:= False;
  AllowCustomiseGrid := True;
  fbFormAlreadyShown := False;
  inherited;
  bIgnoreEvent := false;
  ConsolidateCustBOonInvoiceOnce := false;
  bShipToOverride := false;
  if FormStillOpen('TCustomersOnSupportListGUI') then begin
    if (TForm(FindExistingComponent('TCustomersOnSupportListGUI')).Visible) then begin
      tmrMonitor.Enabled := true;
    end else begin
      tmrMonitor.Enabled := false;
    end
  end else begin
    tmrMonitor.Enabled := false;
  end;

//  FEmailSender := T2cEmailSender.Create;

  if qryContacts.Active = True then qryContacts.Close;
  qryContacts.Params.ParamByName('xCompany').asString := cboClientR.Text;
  qryContacts.Open;
  btnAddFreight.Visible := AppEnv.CompanyPrefs.StateFreightChargeEnabled;

end;

procedure TInvoiceGUI.FormDestroy(Sender: TObject);
begin
//  FreeandNil(FEmailSender);
  //FreeAndNil(Invoice);
  Invoice := nil;
  self.SaleBase := nil;
  inherited;
end;

procedure TInvoiceGUI.cboTermsNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
begin
  Accept := false;
  NotInListWarning(Sender);; // stop not in list processing for this combo, for now
end;

procedure TInvoiceGUI.cboEmployeeNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
begin
  Accept := false;// stop not in list processing for this combo, for now
end;

function TInvoiceGUI.GetReportTypeID: integer;
begin
  Result := 11;
end;

procedure TInvoiceGUI.cmdTimecostClick(Sender: TObject);

  procedure RemoveJobCostLines;
  begin
    tblDetails.DisableControls;
    Try
      tblDetails.First;
      while not tblDetails.Eof do begin
        if tblDetailsTimecostused.AsBoolean then begin
          tblDetails.Delete;
        end else begin
          tblDetails.Next;
        end;
      end;
    Finally
      tblDetails.EnableControls;
    end;
  end;

begin
  if not samevalue(invoice.totalamountinc , invoice.totalbalance, 0.0001) then begin
    MessageDlgXP_Vista('This invoice is partially paid. It is not possible to add costs to it', mtWarning, [mbOK], 0);
    Exit;
  end;
  CustomerCostGUI := TCustomerCostGUI.Create(Self);
  CustomerCostGUI.FormStyle := fsNormal;
  with CustomerCostGUI do try
      CustomerCostOwner := Self;
      CustomerName := Invoice.CustomerName;
      CustomerID := Invoice.CustomerID;
      KeyID := Invoice.ID;
      if ShowModal = mrOk then begin
        Application.ProcessMessages;
        If (Invoice.Lines.Dataset.Recordcount>0) then RemoveJobCostLines;
        Application.ProcessMessages;
        if not cdsResults.IsEmpty then begin
          cdsResults.First;
          while not cdsResults.Eof do begin
            If cdsResultsProductName.AsString='' then continue;
            if Not(Invoice.Lines.Dataset.State in [dsInsert]) then Invoice.Lines.New;
            Invoice.Lines.ProductName := cdsResultsProductName.AsString;
            Invoice.Lines.Timecostused := true;
            Invoice.Lines.SearchFilter := cdsResultsProductName.AsString;
            Invoice.Lines.SearchFilterCopy := cdsResultsProductName.AsString;
            Invoice.Lines.ProductName := cdsResultsProductName.AsString;
            if (cdsResultsEntryType.AsString = 'Timesheet') and
              AppEnv.PayPrefs.SummariseTSForInvoiceCost then begin
              Invoice.Lines.QtySold := 1;
              Invoice.Lines.QtyShipped := 1;
              Invoice.Lines.UOMQtySold := 1;
              Invoice.Lines.UOMQtyShipped  := 1;
              Invoice.Lines.UOMMultiplier := 1;
            end else begin
              Invoice.Lines.QtySold := cdsResultsShipped.AsFloat;
              Invoice.Lines.QtyShipped := cdsResultsShipped.AsFloat;
              Invoice.Lines.UOMQtySold := cdsResultsShipped.AsFloat;
              Invoice.Lines.UOMQtyShipped := cdsResultsShipped.AsFloat;
              Invoice.Lines.UOMMultiplier := 1;
              if AppEnv.CompanyPrefs.ShowDocketNumberColumnOnSales then begin
                Invoice.Lines.DocketNumber := cdsResultsDocketNumber.AsString;
              end;
            end;

            if not isinvProduct(tblDetailsPartType.AsString) then begin
              Invoice.Lines.LineCost := 0.00;
              Invoice.Lines.LineCostInc := 0.00;
              if cdsResultsProduct_Description.AsString <> '' then begin
                Invoice.Lines.ProductDescription := cdsResultsProduct_Description.AsString;
              end;
              if cdsResultsEntryType.AsString = 'Timesheet' then begin
                Self.fbUsingTimesheetCosting := true;
                if AppEnv.PayPrefs.SummariseTSForInvoiceCost then begin
                  Invoice.Lines.ProductDescription :=
                    Invoice.Lines.ProductDescription + 'Services Performed / Rendered';
                end else begin
                  Invoice.Lines.ProductDescription := Invoice.Lines.ProductDescription + '  ' +
                                                       DateToStr(cdsResultsOrderDate.AsDateTime);
                end;
                Invoice.Lines.LinePrice := GetAmountEx(CustomerCostGUI.cdsResultsTimeCostPrice.AsFloat, GetTaxRate('GST'));
                Invoice.Lines.LinePriceInc := CustomerCostGUI.cdsResultsTimeCostPrice.AsFloat;
                Self.fbUsingTimesheetCosting := false;
              end else begin
                if Invoice.Lines.LinePrice < cdsResultsLineCost.AsFloat then begin
                  Invoice.Lines.LinePrice := CustomerCostGUI.cdsResultsLineCost.AsFloat;
                  Invoice.Lines.LinePriceInc := CustomerCostGUI.cdsResultsLineCostInc.AsFloat;
                end;
              end;
            end;

            if (uppercase(cdsResultsProductName.AsString) = 'TIME/COST EXP') and
              (cdsResultsEntryType.AsString <> 'Timesheet') then begin
              Invoice.Lines.LinePrice := cdsResultsTimeCostPrice.AsFloat;
              Invoice.Lines.LineCost := 0.00;
              Invoice.Lines.LineCostInc := 0.00;
            end else begin
              Invoice.Lines.LineCost := cdsResultsLineCost.AsFloat;
              Invoice.Lines.LineCostInc := cdsResultsLineCostInc.AsFloat;
            end;
            cdsResults.Edit;
            Invoice.Lines.Postdb;
            cdsResultsSaleLineId.AsInteger := Invoice.Lines.SaleLineID;
            cdsResults.Post;
            if not cdsResults.Eof then cdsResults.Next;
          end;
        end;
      end;
      UpdateTablesFromClientDataset;
    finally
      if Assigned(CustomerCostGUI) then
        FreeandNil(CustomerCostGUI);
    end;
end;

function TInvoiceGUI.EmailTransaction(const RecipientAddress :String ='';ASilent: boolean=True; ASecret : boolean=True): boolean;
var
  ReportType, OutGoingFileName: string;
  recipients : string;
  qryEmailedList: TERPQuery;
  TransactionID, UserID, TransactionDescription: string;
  EmailDate: TDateTime;
  intResult: integer;
  strResult: string;
//  XMLEmailObj :TXMLEmailObj;
  sXMLAddress:string;

  ftp: TIdFTP;
  stream: TMemoryStream;
  url: TURLObj;
  fileName: string;
  StringStream: TStringStream;
  sl: TStringList;
  bodyText: string;
  InvoiceDoc: IXMLDocument;
  ReportAttachmentfiles: String;
  Corres: TCorrespondenceGui;

begin
  result := false;

  if ReportToPrint = '' then if chkChooseRpt.checked = False then  ReportToPrint := InvoiceReportName;
  DisableForm;
  try
    if not self.SaveSalesRecord then Exit;
    Self.CommitAndNotify;
    Corres := TCorrespondenceGui.Create;
    Corres.CorrespondenceType := ctEmail;

    try
      if invoice.Customer.SendXMLInvoices then begin
        sXMLAddress := ClientXMLEmail(Invoice.CustomerID );
        if sXMLAddress <> '' then begin
          InvoiceDoc := SalesXMLUtils.CustomerXMLInvoiceDoc(Invoice.XMLDoc);
          try
            { use XMLDoc.SaveToStream to force inclusion of "encoding" .. Invoice.XML removes encoding for default UTF-8 }
            StringStream := TStringStream.Create;
            try
              InvoiceDoc.SaveToStream(StringStream);
              StringStream.Position := 0;
              StringStream.SavetoFile(EmailLib.EmailTempAttachmentDir + 'XMLData.xml');
              Corres.AttachmentList.Add(EmailLib.EmailTempAttachmentDir + 'XMLData.xml');
            finally
              StringStream.Free;
            end;

            Corres.CustomerId := Invoice.CustomerID;
            Corres.RecipientList := sXMLAddress;
            Corres.Subject := 'XML Invoice';
            Corres.MessageText := 'Invoice XML in attached file';
            Corres.Execute(true, true);
          finally
            InvoiceDoc := nil;
          end;
        end;
      end;

      if Invoice.Customer.SendFTPXMLInvoices then begin
        ftp := TIdFTP.Create(nil);
        stream := TMemoryStream.Create;
        url := TURLObj.Create(Invoice.Customer.FTPAddress);
        InvoiceDoc := SalesXMLUtils.CustomerXMLInvoiceDoc(Invoice.XMLDoc);
        try
          ftp.Host := url.Host;  //PO.Supplier.FTPAddress;
          ftp.Username := Invoice.Customer.FTPUserName;
          ftp.Password := Invoice.Customer.FTPPassword;
          InvoiceDoc.SaveToStream(stream);
          stream.Position := 0;
          try
            fileNAme := url.Path;
            if (fileName <> '') and (copy(fileName,Length(fileName),1) <> '/') then
              fileName := fileName + '/';
            fileName := fileName + 'TrueERP_Invoice_' + IntToStr(Invoice.ID) + '.xml';
            ftp.Connect;
            ftp.Put(stream,fileName);
            ftp.Disconnect;
          except
            on e: exception do begin
              CommonLib.MessageDlgXP_Vista('Error sending XML Invoice to FTP site: ' + e.Message,mtWarning,[mbOK],0);
            end;
          end;
        finally
          ftp.Free;
          stream.Free;
          url.Free;
          InvoiceDoc := nil;
        end;
      end;

      ReportType := '';
      OutGoingFileName := '';

      (*
      if RecipientAddress = '' then
        Recipients := GetContactEmailsForSales(Invoice.ClientId, 'MainContactForInvoice')
      else
      begin
        Recipients := TStringList.Create;
        Recipients.Add(RecipientAddress);
      end;
      *)
      Recipients := GetContactEmails(Invoice.ClientId, 'MainContactForInvoice');
      if RecipientAddress <> '' then
        Recipients := AddEmailToList(RecipientAddress, RecipientAddress);

      if Recipients = '' then
        if AppEnv.CompanyPrefs.UseDefaultMailClient then begin
          if CommonLib.MessageDlgXP_Vista(Invoice.CustomerName + ' does not have an email address.' + #13 + #10 +
            'Do you wish to load the email program anyway?',mtConfirmation, [mbYes,mbNo], 0) = mrNo then exit;
        end else begin
          if CommonLib.MessageDlgXP_Vista(Invoice.CustomerName +
          ' does not have an email address to send to.' + #13 + #10 + #13 + #10 +
          'Do you wish to load the email program anyway?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
        end;

      ReportType := 'Invoice';
      // String defined here because it is easy to change when this code is applied to
      // other forms. (ie, Quote instead of Invoice etc)

      // Ask the user if they want to specify a new subject
      intResult := CommonLib.MessageDlgXP_Vista('You are about to Email this ' + ReportType + ' to ' +
        Invoice.Customer.PrintName+ '.' + #13 + #10 + #13 + #10 +
        'Would you like to specify a subject for this email?' + #13 + #10 + #13 + #10 +
        'Please select Yes to enter new email subject line. No to use standard subject line.', mtConfirmation,
        [mbYes, mbNo, mbCancel], 0);


      sl:= TStringList.Create;
      try
        PopulateMessageSubstituteList(sl);
        BodyText := TMailUtils.SubstituteText(AppEnv.CompanyPrefs.InvoiceMailAttachmentBodyText,sl);
        strResult := TMailUtils.SubstituteText(AppEnv.CompanyPrefs.InvoiceMailAttachmentSubject,sl);
        if intResult = mrYes then begin
          strResult := InputBox('SUBJECT DECLARATION','Please specify subject for this email', strResult);
        end else if intResult = mrNo then begin
        end else begin
          Exit;
        end;
      finally
        sl.Free;
      end;

      try
        lblEmailMsg.Caption := 'Emailing, ' + WAITMSG;
        lblEmail.Visible := true;

        Try
          if not LoadTemplate(true, true) then begin
            CommonLib.MessageDlgXP_Vista('Can''t Create Attachment'+NL+NL+'Email Failed !', mtWarning, [mbOK], 0);
            exit;
          end;

          lblEmailMsg.Caption := 'Emailing, ' + WAITMSG;

          OutGoingFileName := getOutGoingFileName('',' ' + ReportType + ' #' + Invoice.DocNumber, '.PDF');
          if not FileExists(Commonlib.TempDir +  'EmailReport.PDF') then begin
            CommonLib.MessageDlgXP_Vista('Can''t Find Attachment'+#13+#10+#13+#10+'Email Failed !', mtWarning, [mbOK], 0);
            Exit;
          end;

          Corres.Clear;
          Corres.CustomerId := Invoice.CustomerID;
          Corres.Subject := strResult;
          Corres.RecipientList := Recipients;

          Corres.MessageText := BodyText;
          Copyfile(PChar(Commonlib.TempDir + 'EmailReport.PDF'),
            PChar(Commonlib.TempDir  + OutGoingFileName), false);
          Corres.AttachmentList.Add(Commonlib.TempDir  + OutGoingFileName);
          Corres.CCList := GetSalesEmails;
          { this asks user if they want to send any of the sales attachments }
          CheckForMailAttachments(Corres);
          { any attachments defined for template }
          ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres , GetTemplate(ReportToPrint));

          Result := Corres.Execute(ASilent, ASecret);

        Finally
          DeleteFiles(ExtractFilePath(ParamStr(0)), '*.PDF');
          DeleteMultipleFiles(Commonlib.TempDir , ReportAttachmentfiles);
          lblEmail.Visible := false;
        end;

        TransactionID := Invoice.DocNumber;
        UserID := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
        EmailDate := Now;

        // ReportType already defined at start of procedure
        TransactionDescription := GetCompanyName + ' ' + ReportType + ' #' +
          Invoice.DocNumber + ' for ' + Invoice.CustomerName;

        qryEmailedList := TERPQuery.Create(nil);
        qryEmailedList.Connection := CommonDbLib.GetSharedMyDacConnection;
        try
          qryEmailedList.Sql.Clear;
          qryEmailedList.Sql.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports (TransactionID, UserID, Date, ReportType,');
          qryEmailedList.SQL.Add(' TransactionDescription,ContactID,EmailAddressUsed) Values ("' +
            TransactionID + '","' + UserID + '", "' + FormatDateTime(MysqlDateFormat,
            EmailDate) + '", "' + ReportType + '", "' + TransactionDescription + '", "' + IntToStr(EmailContactID) +
            '", "' + RecipientAddress + '")');
          qryEmailedList.Execute;

        finally
          DeleteFile(Commonlib.TempDir + 'EmailReport.PDF');
          DeleteFile(OutGoingFileName);
          FreeandNil(qryEmailedList);
        end;
      except
        lblEmail.Visible := false;
        CommonLib.MessageDlgXP_Vista('There was an error sending email', mtWarning, [mbOK], 0);
      end;

    finally
      LogEmailed(result , ReportToPrint);
      self.BeginTransaction;
      //ReportToPrint := '';
      Corres.Free;
    end;
  finally
    EnableForm;
  end;
end;


procedure TInvoiceGUI.smtpInvoiceAuthenticationFailed(var Handled: boolean);
begin
  inherited;
  CommonLib.MessageDlgXP_Vista('Email connection to SMTP host failed. Please check your user authentication for SMTP', mtInformation , [mbOK], 0);
end;

procedure TInvoiceGUI.actDelDocketExecute(Sender: TObject);
begin
  ReportToPrint := '';
  if (Appenv.CompanyPrefs.ShowDeliveryDetailsformonDeldocketprint) and (Appenv.Employee.ShowDeliveryDetailsformonDeldocketprint) then
    TfmSalesDeliveryDetails.DoExtrainfoPopup(Self, Invoice.SalesDeliveryDetails ,PrintDeldocket)
  else begin
    PrintDeldocket;
    //SendInvoiceDelEmail(TClient.ClientEmailAddress(Invoice.CustomerId) , '');
  end;
end;


procedure TInvoiceGUI.PrintDeldocket;
begin
  DisableForm;
  try
    if Invoice.Dirty and (not Self.SaveSalesRecord) then Exit;
    Self.CommitAndNotify;
    try
      fbReportSQLSupplied :=   False;

      inherited actDelDocketExecute(actDelDocket);
      Invoice.Printdoc.Printdoc(Invoice.ClassName, Invoice.ID, dtDelDock, Self.Classname ,PreviewToDocumentOutputType(AppEnv.Employee.ShowPreview) , reporttoPrint);
      PrintAddressLabel;
    finally
      (* if (AppEnv.Employee.CloseOnPrint) and (not DontCloseAfterPrint) and (sender = actDelDocket) then
        Close
      else *)
        self.BeginTransaction;
    end;
  finally
    EnableForm;
  end;
end;

Procedure TInvoiceGUI.DoOnClientchange;
begin
  {onfieldchange of the business object updates the clietnId to 0 if the client is
  locked and client has 'Use Individual Invoice No.' set to True.}
  if invoice.ClientId = 0 then exit;

  if Empty(cboClientR.Text) then Exit;
  inherited;
  btnPickUpFrom.Enabled := true;
  if AppEnv.CompanyPrefs.UseManifest then begin
    Invoice.Ismanifest := True;
  end;



  Invoice.ShipDate:= IncDay(Invoice.SaleDate, AppEnv.CompanyPrefs.ShippedDaysAfterCreate);
  cboTerms.OnCloseUp(nil, cboTermsQry, tblMaster, true);

  Invoice.PickupFromDesc := Invoice.InvoiceToDesc;

  if AppEnv.CompanyPrefs.ConsolidateCustBOonInvoice and not ConsolidateCustBOonInvoiceOnce then begin
    If not AppEnv.CompanyPrefs.CombinedInvoiceBO then
      ConsolidateCustBO
    else
      MessageDlgXP_Vista('Cannot ''Consolidate BO'' if ''Combined BO'' Preference is ON !', mtInformation, [mbOK], 0);
    ConsolidateCustBOonInvoiceOnce := true;
  end;


  if qryContacts.Active = True then qryContacts.Close;
  qryContacts.Params.ParamByName('xCompany').asString := cboClientR.Text;
  qryContacts.Open;

  RefreshProductQry;

  showRedeemPoints(Invoice.SaleDate);

end;


(*procedure TInvoiceGUI.DoOnDoNotAskMsgCheck(Sender: TObject);
begin
  if Sender is TwwCheckBox then
    DoOnDoNotAskMsgCheck(Sender , TwwCheckBox(Sender).checked);
end;*)
procedure TInvoiceGUI.DoOnDoNotAskMsgCheck(Sender: TObject; Checked: boolean);
begin
  inherited;
end;
Procedure TInvoiceGUI.DoOnDoNotAskMsgCheck(Sender:TObject);
begin
  inherited;
end;

procedure TInvoiceGUI.DoOnProductchange;
begin
  inherited;
  // TfrmProductETAInfoGUI calls this function -so reclaring in public section
end;

(*procedure TInvoiceGUI.SendEmailCallback(const ACommaContactEmails: string; ASilent, ASecret : boolean);
var
  OutGoingFileName: string;
  RepType: string;
  Corres: TCorrespondenceGui;
  sl : TStringList;
  idx : integer;
begin
  if ACommaContactEmails = '' then
    exit;

  sl := TStringList.Create;
  sl.CommaText := ACommaContactEmails;
  try
    if not self.SaveSalesRecord then Exit;
    Self.CommitAndNotify;

    if sl.Count = 0 then
      exit;

    for idx := 0 to sl.Count - 1 do
    begin
      LoadTemplate(true, true);
      RepType := 'Invoice';

      OutGoingFileName := getOutGoingFileName('',' ' + RepType + ' #' + Invoice.DocNumber, '.PDF');

      if not FileExists(Commonlib.TempDir +  'EmailReport.PDF') then
      begin
        CommonLib.MessageDlgXP_Vista('Can''t Find Attachment'+#13+#10+#13+#10+'Email Failed !', mtWarning, [mbOK], 0);
        Exit;
      end;

      Copyfile(PChar(Commonlib.TempDir + 'EmailReport.PDF'), PChar(Commonlib.TempDir  + OutGoingFileName), false);

      Corres := TCorrespondenceGui.Create;
      try
        Corres.CorrespondenceType := ctEmail;
        Corres.CCList := GetSalesEmails;
        Corres.RecipientList := sl[idx];
        Corres.Subject := RepType + ' #' + Invoice.DocNumber + ' for ' + Invoice.CustomerName;
        Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;
        Corres.CustomerId := self.tblMasterClientID.AsInteger;
        Corres.AttachmentList.Add(Commonlib.TempDir + OutGoingFileName);
        Corres.Execute(ASilent, ASecret);

      finally
        Corres.Free;
        ReportToPrint := '';
      end;
    end;
  finally
    sl.Free;
    Self.BeginTransaction;
  end;
end;*)

procedure TInvoiceGUI.btnPickUpFromClick(Sender: TObject);
var
  frm: TPickFromPopupGUI;
  tmpComponent:TComponent;
begin
  inherited;
  if self.AccessLevel > 3 then exit;
  tmpComponent:=  GetComponentByClassName('TPickFromPopupGUI');
  if not assigned(tmpComponent) then exit;
  frm := TPickFromPopupGUI(tmpComponent);
  frm.CallingFormType := ftInvoice;
  frm.CallingForm := Self;

  frm.ClientDetails := Invoice.PickupFromDesc;

  frm.ShowModal;
end;

procedure TInvoiceGUI.cmdFaxClick(Sender: TObject);
var
  Fax: TFaxObj;
  FaxNo: string;
  Faxed:Boolean;
begin
  if not(IstobeApprovednNotApproved) then exit;

  DisableForm;
  Faxed := False;
  try
  (*ReportToPrint := tcDataUtils.GetTemplate(invoice.client.DefaultInvTemplateID);*)
  if chkChooseRpt.checked = False then  ReportToPrint := InvoiceReportName;
    inherited;

    if not self.SaveSalesRecord then Exit;
    Self.CommitAndNotify;
    try
      FaxNo := Invoice.Customer.Faxnumber;

      if Empty(FaxNo) then begin
        CommonLib.MessageDlgXP_Vista(Invoice.CustomerName+
          ' does not have an Fax Number to Send to.' + #13 + #10 + #13 + #10 +
          'Please Review Customer information to Add an Fax Number.', mtWarning,
          [mbOK], 0);
      end else begin
        lblEmail.Visible := true;
        lblEmailMsg.Caption := 'Adding to Fax Spool...';
        fsFax          := true;
        LoadTemplate(true, true, true, 'Invoice_' + Invoice.Globalref);

        Fax := TFaxObj.Create;
        try
          Fax.AddToFaxSpool(Invoice.EmployeeName,
            Invoice.CustomerName, FaxNo, 'Invoice',
            Invoice.GlobalRef, '',
            ExtractFilePath(ParamStr(0)) + 'IMG0001.BMP', Now());
            Faxed := True;
        finally
          if Assigned(Fax) then
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

procedure TInvoiceGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if Invoice.Dirty then begin
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
          Invoice.Dirty := false;
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
procedure TInvoiceGUI.ConsolidateCustBO;
var
  fi:Integer;
begin
  fi := CustomerBOCount(Invoice.CustomerID , 'I');
  if fi>0 then
      if CommonLib.MessageDlgXP_Vista('This Customer Has ' + IntToStr(fi) +
        ' Outstanding BackOrder''s' + #13 + #10 + '' + #13 + #10 +
        'Do You Wish To Add Any Of These ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
         OpenERPListFormultiselectModal('TBackOrdersListGUI', BackOrdersListbeforeShow, OnSelectBackOrders);
      end;
end;
Procedure TInvoiceGUI.BackOrdersListbeforeShow(Sender:TObject);
begin
  if sender is TBackOrdersListGUI then begin
    TBackOrdersListGUI(Sender).CustomerId := Invoice.CustomerID;
    TBackOrdersListGUI(Sender).chkIgnoreDates.Checked:= True;
    TBackOrdersListGUI(Sender).btnSmartOrder.enabled := False;
    TBackOrdersListGUI(Sender).btnInvoiceList.enabled := False;
    //TBackOrdersListGUI(Sender).fbDateRangeSupplied := True;
  end;
end;
Procedure TInvoiceGUI.OnSelectBackOrders(Sender: TwwDbGrid);
var
  i, j,idx: integer;
  ExistingBOInvoice: TInvoice;
  SaleIds, saleLineIds:TStringlist;
  SavedSilentMode:Boolean;
  filinesAdded:Integer;
begin
  if (Sender.SelectedList.Count > 0) and (CommonLib.MessageDlgXP_Vista('Do You Wish To Add The ' +
        IntToStr(Sender.SelectedList.Count) + ' Selected BO''s To Your Invoice ?', mtConfirmation, [mbYes, mbNo], 0) = mrno ) then exit;
  filinesAdded:=0;
  saleIds := TStringList.Create;
  saleLineIds := TStringList.Create;
(*  ExistingBOInvoice := TInvoice.Create(nil);*)
  try
    try
(*        ExistingBOInvoice.Connection := TMyDacDataConnection.Create(ExistingBOInvoice);
        ExistingBOInvoice.Connection.connection := invoice.Connection.connection;
        ExistingBOInvoice.SilentMode := True;
        ExistingBOInvoice.CopyingToInvoice := true;*)
        Invoice.CopyingToInvoice := true;
        SavedSilentMode := invoice.SilentMode;
        invoice.SilentMode := True;
        (*ExistingBOInvoice.UserLock := invoice.UserLock;*)
        SelectedIDs(sender, 'SaleId', saleIds, True);
        SelectedIDs(sender, 'SaleLineId', saleLineIds , True);

        if saleIds.Count =0 then exit;

        {get the selected sale and sale line IDs: note that its possible to select few lines from a back order not the whole back order}
        for i := 0 to saleIds.Count - 1 do begin
            ExistingBOInvoice := TInvoice.Create(nil);
            try
                ExistingBOInvoice.Connection := TMyDacDataConnection.Create(ExistingBOInvoice);
                ExistingBOInvoice.Connection.connection := invoice.Connection.connection;
                ExistingBOInvoice.SilentMode := True;
                ExistingBOInvoice.CopyingToInvoice := true;
                ExistingBOInvoice.UserLock := invoice.UserLock;
                    ExistingBOInvoice.Load(strtoint(saleIds[i]));
                    //if not invoice.UserLock.Lock(ExistingBOInvoice.BusObjectTableName , ExistingBOInvoice.ID) then begin
                    if  (ValidateClosingDate(ExistingBOInvoice.SaleDate)) then begin
                      CommonLib.MessageDlgXP_Vista(    'Could not Add Existing Back Order:' + IntToStr(ExistingBOInvoice.ID) + NL+NL+'It has Sale Date (' + FormatDateTime(FormatSettings.ShortDateformat, ExistingBOInvoice.SaleDate) + ')' + ' Prior to the Closing Date (' +
                                                        FormatDateTime(FormatSettings.ShortDateformat, AppEnv.CompanyPrefs.ClosingDateAR) + ').'+NL+NL+
                                                        'To fix this, Under Preferences -> Accounts, Change the 4 Global Closing Dates to Prior to the The Sale Date(' + FormatDateTime(FormatSettings.ShortDateformat, ExistingBOInvoice.SaleDate) + ')', mtWarning, [mbOK], 0);
                      continue;
                    end;
                    if not ExistingBOInvoice.Lock then begin
                      CommonLib.MessageDlgXP_Vista(CustomiseLockMessage(ExistingBOInvoice.UserLock.LockMessage, ['Unable to update data.' + #13#10 ],['Unable to Add Lines from Back Order #' + inttostr(ExistingBOInvoice.ID)+'.'+NL] ), mtWarning, [mbOK], 0);
                      continue;
                    end;
                      (*ExistingBOInvoice.dirty := true;
                      if not ExistingBOInvoice.Save then begin
                            CommonLib.MessageDlgXP_Vista('Could not Add Existing Back Order Invoices.'+NL + ExistingBOInvoice.ResultStatus.Messages, mtWarning, [mbOK], 0);
                            continue;
                      end;*)

                      invoice.Connection.BeginNestedTransaction;
                      Try
                        for j := 0 to saleLineIds.Count - 1 do begin
                            if ExistingBOInvoice.Lines.Dataset.Locate('SaleLineID',strtoint(saleLineIds[j]),[]) then begin
                              invoice.Lines.new;
                              ExistingBOInvoice.Lines.copyobjRec('SaleId' ,invoice.ID , invoice.Lines);
                              ExistingBOInvoice.Lines.QtySold := 0;{ 4. set line qty to zero }
                              ExistingBOInvoice.Lines.PostDb;
                            end;
                        end;

                        ExistingBOInvoice.ResultStatus.Clear;{ 5. validate/Save invoices }
                        if not ExistingBOInvoice.Save then begin
                            CommonLib.MessageDlgXP_Vista('Could not Add Existing Back Order Invoices.'+NL + ExistingBOInvoice.ResultStatus.Messages, mtWarning, [mbOK], 0);
                            invoice.Lines.Canceldb;
                            invoice.Lines.Closedb;
                            invoice.Closedb;
                            invoice.Connection.RollbackNestedTransaction;
                            invoice.opendb;
                            invoice.Lines;
                            continue;
                        end;
                        filinesAdded:= filinesAdded+1;
                        invoice.connection.CommitNestedTransaction;
                        ExistingBOInvoice.Closedb;
                      Except
                        on E:Exception do begin
                          invoice.Connection.RollbackNestedTransaction;
                        end;
                      end;
          finally
            ExistingBOInvoice.Userlock := nil;
            FreeAndNil(ExistingBOInvoice);
          end;
        end;

        invoice.ResultStatus.Clear;
        invoice.PostDB;
        invoice.Connection.CommitNestedTransaction;
        if filinesAdded>0 then
          CommonLib.MessageDlgXP_Vista('Lines are Added from '+inttostr(filinesAdded)+' Selected Back Order(s).', mtInformation, [mbOK], 0);

    except
              on E:Exception do begin
                invoice.Connection.RollbackNestedTransaction;
              end;
    end;
  finally
    //FreeAndNil(ExistingBOInvoice);
    invoice.SilentMode := SavedSilentMode;
    Freeandnil(SaleIds);
    Freeandnil(SaleLineIds);
  end;
end;
(*procedure TInvoiceGUI.ConsolidateCustBO;
var
  qryTemp: TERPQuery;
  MAXDATE: TDateTime;
  MINDATE: TDateTime;
  QueryManipulationObj: TQueryManipulationObj;
  BackOrdersList: TComponent;
begin
  qryTemp := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    Closedb(qryTemp);
    qryTemp.Sql.text := 'SELECT  Count(tblSalesLines.SaleLineID) as ctr, '+
                               ' EndOfTheDay( Max(SaleDate))  as MaxDate,   '+
                               ' date(Min(SaleDate)) as MinDate   '+
                               ' FROM tblSales INNER JOIN tblSalesLines USING(SaleID)   '+
                               ' WHERE tblSales.IsInvoice="T" AND tblSales.Deleted="F"  AND tblSales.ClientID= ' +IntToStr(Invoice.CustomerID) +'  '+
                               ' AND IFNULL(TBLSALES.BOID , "") = ""  AND tblSalesLines.BackOrder > 0  AND tblSalesLines.Invoiced = "F" AND tblSalesLines.Shipped = 0 ';
    opendb(qryTemp);
    if qryTemp.fieldbyname('ctr').asInteger>0 then begin
      MAXDATE := qryTemp.FieldByName('MaxDate').AsDateTime;
      MINDATE := qryTemp.FieldByName('MinDate').AsDateTime;
      if CommonLib.MessageDlgXP_Vista('This Customer Has ' + IntToStr(qryTemp.fieldbyname('ctr').asInteger) +
        ' Outstanding BackOrder''s' + #13 + #10 + '' + #13 + #10 +
        'Do You Wish To Add Any Of These ?', mtConfirmation, [mbYes, mbNo], 0) =
        mrYes then begin


        BackOrdersList := FindExistingComponent('TBackOrdersListGUI');
        if Assigned(BackOrdersList) then begin
          TBackOrdersListGUI(BackOrdersList).Close;
          Application.ProcessMessages;
        end;

        BackOrdersList := GetComponentByClassName('TBackOrdersListGUI',False,Self);
        if assigned(BackOrdersList) then begin
            TBackOrdersListGUI(BackOrdersList).ConsolidateMode := true;
            TBackOrdersListGUI(BackOrdersList).NewSaleID := Invoice.ID;
            TBackOrdersListGUI(BackOrdersList).dtFrom.DateTime := MINDATE;
            TBackOrdersListGUI(BackOrdersList).dtTo.DateTime := MAXDATE;
            TBackOrdersListGUI(BackOrdersList).chkIgnoreDates.Checked := True;
            TBackOrdersListGUI(BackOrdersList).fbDateRangeSupplied := true;
        end;
        QueryManipulationObj := TQueryManipulationObj.Create(TBackOrdersListGUI(BackOrdersList).qryMain.SQL.Text);

        try
          QueryManipulationObj.ProcessSearch('ClientID',IntToStr(Invoice.CustomerID));
          TBackOrdersListGUI(BackOrdersList).qryMain.SQL.Text := QueryManipulationObj.ModifiedSQL;
          TBackOrdersListGUI(BackOrdersList).RefreshOrignalSQL(false);
        finally
          FreeandNil(QueryManipulationObj);
        end;

        TBackOrdersListGUI(BackOrdersList).Position := poScreenCenter;
        TBackOrdersListGUI(BackOrdersList).ShowModal;

        EditNoAbort(tblDetails);
      end;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryTemp);
  end;
end;*)

procedure TInvoiceGUI.smtpInvoiceInvalidHost(var Handled: boolean);
begin
  inherited;
  CommonLib.MessageDlgXP_Vista('Bad Host was supplied', mtWarning, [mbOK], 0);
end;

procedure TInvoiceGUI.smtpInvoiceConnect(Sender: TObject);
begin
  inherited;
  lblEmailMsg.Caption := 'Connecting...';
end;

procedure TInvoiceGUI.tmrMonitorTimer(Sender: TObject);
var
  Buffer: array[0..255] of char;
  A: PChar;
begin
  // Was this invoice raised from the Customer Support
  if (TForm(FindExistingComponent('TCustomersOnSupportListGUI')).Visible) and not (bShipToOverride) then begin
    // Yes, then setup our class and ShipTo Information
    // and execute this only once! We disable this timer
    // after we are complete.
    txtShipTo.Lines.Clear;
    if AppEnv.CompanyPrefs.SuppressJobNamesOnInvoices then begin
      ZeroMemory(@buffer, SizeOf(buffer));
      StrPCopy(Buffer, cboClientR.Text);
      A := StrPos(Buffer, '^');
      if Assigned(A) then begin
        A[0] := #0;
      end;

      txtShipTo.Lines.Add(string(Buffer));
    end else begin
      txtShipTo.Lines.Add(cboClientR.Text);
    end;

    // State that we had overridden our ShipTo Information.
    bShipToOverride := true;

    // Override ShipTo details.
    if AppEnv.CompanyPrefs.SuppressJobNamesOnInvoices then begin
      Invoice.ShipToDesc := string(Buffer);
    end else begin
      Invoice.ShipToDesc := cboClientR.Text;
    end;

    Invoice.PostDb;


    // Retrieve our Class.
    cboClassQry.Open;
    cboClass.Text := cboClassQry.FieldValues['ClassName'];
    // Disable Timer.
    tmrMonitor.Enabled := false;
    // Process Messages.
    Application.ProcessMessages;
  end;
end;

procedure TInvoiceGUI.txtCustomIDDblClick(Sender: TObject);
begin
  inherited;

end;

{$IFDEF FORM_BASED_SELECT_SQL}
function TInvoiceGUI.TransSpecificSQL: String;
begin
  if fbReportSQLSupplied then begin
    //Result :=  '~|||~{EarlyPayment}  Select totallineamountinc EarlyPaymentDiscountAmount from tblsaleslines SL where Sl.ProductName = '+Quotedstr(EARLY_PAYMENT_DISCOUNT_PRODUCT) +' and SaleId = ' + inttostr(Transbase.ID);
     Result :=  '~|||~{EarlyPayment} Select S.SAleID  , '+
                ' abs(totallineamountinc) EarlyPaymentDiscountAmount , '+
                ' if(ifnull(SL.SaleLineId,0)=0 , if(ifnull(T.EarlyPaymentDiscount ,0)=0 , 0 , S.totalamountinc*T.EarlyPaymentDiscount/100) , 0)    '+
                        ' from tblSales S   Left join tblsaleslines SL on  Sl.ProductName = '+Quotedstr(EARLY_PAYMENT_DISCOUNT_PRODUCT) +'    '+
                        ' and SL.sAleId = s.SAleID    '+
                ' Left join tblterms T on S.Terms = T.Terms  '+
                ' Where S.SaleId = ' + inttostr(Transbase.ID);
  end else begin
    Result :=  '~|||~ Where S.SaleId = ' + inttostr(Transbase.ID);
  end;

  Result := Result + inherited TransSpecificSQL;
end;
{$ENDIF}

procedure TInvoiceGUI.UpdateMe(const Cancelled: Boolean;
  const aObject: TObject);
begin
  inherited;
  if Cancelled then exit;
  if (aObject is TfmShippingAllocation) then begin
    Invoice.ShipmentList.RefreshDB;
    if accesslevel = 1 then
              { 2/7/2014  The following was removed at Federal Wages request,
                          they want to be able to edit an invoice that has been sent!! }
(*
     if (Invoice.ShipmentList.Count > 0) and (Invoice.ShipmentList.Status = 'Processed') then begin
      Caption := TitleLabel.Caption + '(Frozen) - This Invoice''s Shipment(s) Processed';
      accesslevel:= 5;
    end;
*)
    if (Invoice.ShipmentList.Count > 0) and (Invoice.ShipmentList.Status = 'Processed') then
      btnShipment.Color := $0077ff77;
  end;
end;

procedure TInvoiceGUI.UpdateMe;
begin
  inherited;
end;

procedure TInvoiceGUI.edtCompanySearchFilterExit(Sender: TObject);
var
  iX: integer;
begin
  inherited;
  // Is the client using a base Invoice Number?
  if KeyID = 0 then begin
    iX :=
      GetNextInvoiceBaseNo(cboClientLookup.FieldByName('ClientID').AsInteger);
    if cboClientLookup.FieldByName('UseInvBase').AsString = 'T' then begin
        Invoice.DocNumber:= IntToStr(iX);
        Invoice.PostDB;
        Invoice.EditDB;
    end;
  end;
end;

procedure TInvoiceGUI.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  inherited;
  if key = VK_F8 then begin
    if not Empty(Invoice.Customername) then begin
      if AppEnv.CompanyPrefs.ConsolidateCustBOonInvoice then begin
        If not AppEnv.CompanyPrefs.CombinedInvoiceBO then
          ConsolidateCustBO
        else
          MessageDlgXP_Vista('Cannot ''Consolidate BO'' if ''Combined BO'' Preference is ON !', mtInformation, [mbOK], 0);
      end;
    end;
  end
end;

procedure TInvoiceGUI.actBatchInvoicesExecute(Sender: TObject);
var
  BatchCreationGUI: TBatchInvoiceCreationGUI;
begin
  if not self.SaveSalesRecord then Exit;

  begin
    inherited;
    BatchCreationGUI :=
    TBatchInvoiceCreationGUI(GetComponentByClassName('TBatchInvoiceCreationGUI'));
    if assigned(BatchCreationGUI) then begin
        with BatchCreationGUI do begin
          CreateFromSaleID := Invoice.ID;
          InvoiceMasterRecord := tblMaster;
          InvoiceDetailRecords := tblDetails;
          Position := poScreenCenter;
          FormStyle := fsNormal;
          ShowModal;
        end;
    end;
  end;
end;

procedure TInvoiceGUI.actBatchInvoicesUpdate(Sender: TObject);
begin
  inherited;
  actBatchInvoices.Enabled := (KeyID <> 0) and (tblDetails.RecordCount > 0) and (tblMaster.State <> dsInsert);
end;

procedure TInvoiceGUI.actconsmartExecute(Sender: TObject);
begin
  inherited;
(*var
  SOID:Integer;
begin
      if not IsOkToCopyToSMart then exit;

      if not SaveSalesRecord then Exit;
      if not ConfirmForPOcost then exit;

      lblProcessMessage.Visible := true;
      try
        Invoice.Connection.CommitTransaction;
        Invoice.LineIdToconvert (SelectedLineIds);
        try
          SOID:= Invoice.CopyInvoiceToSmartOrder;
        finally
          Invoice.CleanLineIdsToconvert;
        end;
      finally
          lblProcessMessage.Visible := False;
      end;
      Application.ProcessMessages;
      if SOID <> 0 then begin
        NewAuditTrialentry('Smart Order Created');
        Self.close;
      end else begin
        Invoice.Connection.beginTransaction;
      end;*)

end;

procedure TInvoiceGUI.actconsmartUpdate(Sender: TObject);
begin
  inherited;
(*//  if KeyID = 0 then btnCopyToSmart.Enabled := false;
  actCopyToSmart.Enabled := (tblDetails.RecordCount > 0) {and (KeyID <> 0)} and (Accesslevel <=3) and
        (not (AppEnv.CompanyPrefs.DisableInvCopyToSmartIfPOCreated and
        tblMaster.FieldByName('POCreated').AsBoolean));

  if not actCopyToSmart.Enabled and Not Sysutils.SameText(btnCopyToSmart.Caption,'SM/O Created') then
    if (Keyid <> 0) and (tblMaster.FieldByName('POCreated').AsBoolean) then btnCopyToSmart.Caption := 'SM/O Created';*)

end;

function TInvoiceGUI.ProgressPaymentSOConverted(const SOREf:String):Boolean;
begin
  With Invoice.getNewDataset('Select SaleId, converted from tblsales where globalref = ' +quotedstr(SOREF) , true) do try
    REsult:= fieldbyname('converted').AsBoolean;
  finally
    if active then close;
    Free;
  end;
end;
procedure TInvoiceGUI.actCopyInvoiceExecute(Sender: TObject);
var
  iNewID:Integer;
begin
  DisableForm;
  try
      if not SaveSalesRecord then exit;
      Invoice.connection.CommitTransaction;
      invoice.Accessmanager.AccessLevel:= Appenv.AccessLevels.GetEmployeeAccessLevel(Self.classname);
      Invoice.Connection.BeginTransaction;
      iNewID:= Invoice.CopyInvoiceToInvoice;
      if iNewID <> 0 then begin
        NewAuditTrialentry('Invoice Created(Copied)');
        Invoice.connection.CommitTransaction;
        (*Invoice.Load(iNewID);
        if not Invoice.UserLock.Lock(Invoice.ID) then accessLevel := 5;*)
        (*KeyId := iNewID;
        showProgressbar(WaitMsg, 2);
        try
          LoadTransRec;
          Invoice.Connection.BeginTransaction;
          SetcontrolFocus(cboClientR);
        finally
          HideProgressbar;
        end;*)
        Invoice.Dirty := False;
        OpenERPForm('TInvoiceGUI', iNewID, nil, nil, False, false); // opne invoice in a differnet instance of the form
        closewait;
      end else begin
        Invoice.connection.RollbackTransaction;
        Invoice.Connection.BeginTransaction;
        MessageDlgXP_Vista('Copying Invoice Failed' , mtWarning, [mbok] ,0 );
      end;
  finally
    EnableForm;
  end;

end;

procedure TInvoiceGUI.actCopyInvoiceUpdate(Sender: TObject);
begin
  inherited;
  actCopyInvoice.Enabled :=
   (Appenv.AccessLevels.GetEmployeeAccessLevel('FnCanCopyInvoice') =    1) and
          (tblDetails.RecordCount > 0) and (KeyID <> 0) and
   (Appenv.AccessLevels.GetEmployeeAccessLevel(Self.classname) <=3);
          (*and (Accesslevel <=3)*);
end;

class procedure TInvoiceGUI.CloseMe;
begin
  inherited;
  if FormStillOpen('TInvoiceGUI') then begin
    TInvoiceGUI(FindExistingComponent('TInvoiceGUI')).Close;
    Application.ProcessMessages;
  end;
end;
procedure TInvoiceGUI.grdTransactionsTitleButtonClick(Sender: TObject; AFieldName: string);
begin
  if Sysutils.SameText(AFieldName ,tblDetailsUnitofMeasureShipped.fieldname) then begin
    showStock;
    Exit;
  end else if Sysutils.SameText(AFieldName, 'UnitOfMeasureBackOrder') then begin
    if ProcessBackOrderInvoiceItems then exit;
  end;
  inherited;
end;

Function TInvoiceGUI.ProcessBackOrderInvoiceItems:Boolean;
begin
  REsult := False;
  if Invoice.BOCount = 0 then exit;
  REsult := True;

  case GetShippingOption of
    soShipAnyway: MoveBOQuantitiesToShipped;
    soShipInStock: AutoShippingRun;
    else result := False;
  end;
end;

function TInvoiceGUI.ReturnType: String;
begin
  Result := 'Invoice';
end;

procedure TInvoiceGUI.MoveBOQuantitiesToShipped;
begin
  Invoice.shipall;
  grdTransactions.Refresh;

end;

function TInvoiceGUI.IsOkToSave: boolean;
begin
  Result := inherited IsOkToSave;
end;

{ Handle events from business object }
procedure TInvoiceGUI.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TFESalesLines then TFESalesLines(Sender).Dataset                           := tblFESalesLines
        else if Sender is TFESaleslinesRelatedPrs then TFESaleslinesRelatedPrs(Sender).Dataset  := tblFESaleslinesRelatedPrs
        else if Sender is TSalesShippingDetails then TSalesShippingDetails(Sender).Dataset  := Qrysalesshippingdetails
        else if Sender is TSalesDeliveryDetails then TSalesDeliveryDetails(Sender).Dataset  := qrysalesdeliverydetails;
    end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_QtyShipped) and (Sender is TinvoiceLine) then begin
      if not(Invoice.SilentMode) and  (TinvoiceLine(Sender).QtyShipped <>0) then begin
        TinvoiceLine(Sender).PostDB;
        TfmAllocation.DoBinBatchform(TinvoiceLine(Sender).PQA, self);
      end;
    end Else If (EventType = BusObjEvent_Change) And (Value = BusobjEvent_Invoicestatus) Then Begin
      if (SameText (Invoice.SalesStatus , 'Approved')) and (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCanApproveInvoice')<> 1) then begin
          MessageDlgXP_vista('You don''t have access to ''Approve'' the Invoice', mtWarning, [mbOK], 0);
          try
            Invoice.SalesStatus := tblMasterquoteStatus.OldValue;
          Except
            on E:EXception do begin
              Invoice.SalesStatus := '';
            end;
          end;
      end else if (SameText (Invoice.SalesStatus , 'Prepared')) and (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCanPrepareInvoice')<> 1) then begin
          MessageDlgXP_vista('You don''t have access to ''Prepare'' the Invoice', mtWarning, [mbOK], 0);
          try
            Invoice.SalesStatus := tblMasterquoteStatus.OldValue;
          Except
            on E:EXception do begin
              Invoice.SalesStatus := '';
            end;
          end;

      end;
    end else if (EventType = BusObjEvent_Change) and  (Value = BusObjEventVal_CustomerChanged) then begin
      if AppEnv.CompanyPrefs.PreventInvoiceOnStopCredit and (Invoice.Customer.StopCredit) then
        MessageDlgXP_vista('This Customer is on Stop Credit!', mtWarning, [mbOK], 0);
    end else If (EventType = BusObjEvent_Warning) then begin
      if (Value = BusobjEventVal_StopCredit) and AppEnv.CompanyPrefs.PreventInvoiceOnStopCredit then begin
        Invoice.Dirty := false;
        self.CloseWait;
        Abort;
      end;
    (*end else If (EventType = BusObjEvent_Dataset) and (Sender.IsdataIdchangeEvent(Value)) then begin
      if isformshown then
        if Sender is TInvoiceLine then begin
          if Sametext(invoice.lines.ProductName, PART_PROGRESSPAYMENT_TERMS) then begin
            if invoice.lines.dataset.recno < invoice.lines.dataset.recordcount then invoice.lines.Next
            else if invoice.lines.dataset.recno > 1 then invoice.lines.Prior;
          end;
        end;*)
    end else if (EventType = BusObjEvent_Change) and  (Value = BusObjEvent_PickupFrom) then begin
        Showcontrolhint(lblPickUpFrom ,Invoice.PickupFromDesc);
    end else if (EventType = BusObjEvent_Dataset) and  (Value = BusObjEvent_OnDataIDChange) and (Sender is TSalesBase) then begin
        Showcontrolhint(lblPickUpFrom ,Invoice.PickupFromDesc);
    end;
End;

{open the BO record when trying to edit a readonly invoice. }
procedure TInvoiceGUI.grdTransactionsKeyPress(Sender: TObject;
  var Key: Char);
var
    ErrMsg :String ;
    Editable :Boolean;
    SaleID :Integer;
    saleLineID :Integer;
begin
    if key = #27 then {esc} exit;
    if (Sysutils.SameText(tblDetailsProductName.asString , REDEEM_POINTS)) then begin
        Key := chr(0);
        Exit;
    end;
    inherited;
    if CheckForfieldsinGridKeyPress(Sender, key) then exit;

    if (grdTransactions.GetActiveField = tblDetailsUnitofMeasureBackOrder) then begin
        if (Key >= '0') and (Key <= '9') then Key := chr(0);
        Exit;
    end;
    if grdTransactions.GetActiveField = tblDetailsUnitofMeasureShipped then begin
        if tblDetailsUnitofMeasureShipped.readonly then begin
            if (Key >= '0') and (Key <= '9') then begin
                {this method of he objects checks for any open backorder for the current PO for the
                selected product, and if found returns the PurchaseOrderId of the record.
                If the record not found, it returns the message the ErrMsg.}
                SaleID := Invoice.Lines.getCurrentBackOrderId(ErrMsg, Editable, SaleLineID);
                if Editable = False then begin
                    CommonLib.MessageDlgXP_Vista(ErrMsg, mtWarning, [mbOk], 0);
                    Exit;
                end;

            if SaleId = Invoice.ID then begin
            end else begin
                if CommonLib.MessageDlgXP_Vista('The Invoice is locked as it has a invoiced Back Order. ' +chr(13) +
                              'The quantity can be changed only in the Back Order.' + chr(13) +
                              'Do you want to open the Back Order of this Invoice?' ,
                              mtConfirmation , [mbYes, mbNo], 0) = mrYes then begin
                    Postmessage(Self.handle, SX_OpenINVofBO, SaleID, SaleLineID);
                    Exit;
                end;
            end;
        end;
    end;
  end else if (grdTransactions.GetActiveField = tblDetailsUnitofMeasureQtySold) and (Key = TAB)then begin
  end
  else if (grdTransactions.ColumnByName(grdTransactions.getActiveField.FieldName).ReadOnly) and (Key <> TAB) then begin
    CommonLib.MessageDlgXP_Vista(trim('You do not have Access to change "' +
      grdTransactions.ColumnByName(grdTransactions.getActiveField.FieldName).DisplayLabel +
      '"'+NL+NL+TransAccessMsg), mtWarning, [mbOK], 0);
  end ;
end;
procedure TInvoiceGUI.grdTransactionsRowChanged(Sender: TObject);
begin
  inherited;
    {relocate the record pointer to unlock the lines to be updated}
end;
(*procedure TInvoiceGUI.initProductQtyBinETA(Sender: TObject);
begin
    with TfrmProductQtyBinETA(Sender) do begin
      TfrmProductQtyBinETA(Sender).KeyID := tblDetails.FieldByName('ProductID').AsInteger;
      TfrmProductQtyBinETA(Sender).SaleLineID := tblDetails.FieldByName('SaleLineID').AsInteger;

      TfrmProductQtyBinETA(Sender).ClassID := tblMasterClassID.AsInteger;
      TfrmProductQtyBinETA(Sender).SalesOrderMode := false;
      TfrmProductQtyBinETA(Sender).BlockMode := true;
    end;
end;*)
procedure TInvoiceGUI.ETAInfoClick(Sender: TObject);
begin
  inherited;
    //OpenERPFormModal('TfrmProductQtyBinETA' , 0 , initProductQtyBinETA);
end;

Procedure TInvoiceGUI.OpenINVOfBO(Var Msg :TMessage);
begin
    if not SaveSalesRecord then Exit;
    CommitAndNotify;
    tblMaster.Close;
    tblDetails.Close;
    DEtachAll;
    Self.Close;
    with  TInvoiceGUI.Create(application) do begin
        KeyId := msg.wParam;
        FormStyle := fsMDIChild;
        BringtoFront;
        SetcontrolFocus(grdTransactions);
        if Msg.Lparam <> 0 then begin
            tblDetails.Locate('SaleLineID' , Msg.LParam , []);
            grdTransactions.SetActivefield('UnitofMeasureShipped');
        end;
    End;
end;

function TInvoiceGUI.InitialiseCustomerID(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
begin
  InitialiseStartup := True;
  CustomerID := MsgObj.IntValue;
  Result := True;
end;

function TInvoiceGUI.InvoiceReportName: String;
begin
   Result := ClientDefaultTemplate(Self.Classname, Invoice.ID);
  //result :=tcDataUtils.InvoiceReportName(invoice.ID);
(*  Result := tcDataUtils.GetTemplate(invoice.Customer.DefaultInvTemplateID);
  if (Invoice.HoldSale) and not AppEnv.CompanyPrefs.UseTemplateDefaultInvoice then Result := 'Invoice Held';
//  if (Invoice.RepairID <> 0) or (invoice.Repairglobalref <> '') then REsult := 'Invoice (Repair)';*)
end;

procedure TInvoiceGUI.grdTransactionsEnter(Sender: TObject);
begin
  inherited;
  fLockSalesInitialized:= False;
    Locksales;
end;




procedure TInvoiceGUI.grdTransactionsCalcTitleAttributes(Sender: TObject;
  AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
//  if SameText(AFieldName , 'LineTaxCode') then begin
//    ABrush.Color := grdTransactions.TitleColor;
//  end;
  inherited grdTransactionsCalcTitleAttributes(Sender, AFieldName , AFont , ABrush, ATitleAlignment);
  if AccessLevel = 1 then begin
    if Invoice.TotalQtyBackOrdered <> 0 then
      if Sysutils.SameText(AFieldName ,tblDetailsUnitofMeasureShipped.fieldname) then begin
        Afont.Color := clmaroon;
        ATitleAlignment := taCenter;
        ABrush.Color := pnlTitle.color;
      end;
    if Sysutils.SameText(AFieldName ,tblDetailsUnitofMeasureBackorder.fieldname) then begin
      Afont.Color := clmaroon;
      ATitleAlignment := taCenter;
      ABrush.Color := pnlTitle.color;
    end;
  end;
end;

procedure TInvoiceGUI.cboProductRChange(Sender: TObject);
begin
  LogD('TInvoiceGUI.cboProductRChange',lbBegin);
  try
    inherited;
  finally
    LogD('',lbEnd);
  end;
end;

procedure TInvoiceGUI.cboClassEnter(Sender: TObject);
begin
  inherited;
  if cboTerms.ReadOnly and (cboTerms.Hint <> '') then
    CommonLib.MessageDlgXP_Vista(cboTerms.Hint,mtInformation,[mbOk],0);
end;

procedure TInvoiceGUI.cboCreationDateCloseUp(Sender: TObject);
begin
  inherited;
  showRedeemPoints(cboCreationDate.date);
end;

procedure TInvoiceGUI.cboCreationDateExit(Sender: TObject);
begin
  if not ValidateCreationDateWithAccess('fnAllowFutureDateForInvoiceDate', 'fnAllowPastDateForInvoiceDate') then
    Invoice.SaleDate := fdCreationDate;
    ;
//    Invoice.CancelDb;
end;

procedure TInvoiceGUI.CreatePayment;
begin
  Openrecord(0 , 'TfmCustPayments');
end;

procedure TInvoiceGUI.AfterSubFormShow(Sender: TObject);
begin
  inherited AfterSubFormShow(Sender);
end;
procedure TInvoiceGUI.beforeSubFormShow(Sender: TObject);
begin
  inherited;
  if (Sender is TfmCustPayments) then  begin
      TfmCustPayments(Sender).AttachObserver(Self);
      TfmCustPayments(Sender).OpenForSalesId := Invoice.ID;
  end else if sender is TfmSplitInvoicePayment then begin
      TfmSplitInvoicePayment(Sender).saleId := Invoice.ID;
  end;
end;
procedure TInvoiceGUI.doShowPayments(Sender: TObject);
begin
  inherited;
  btnPayments.Click;
end;

function TInvoiceGUI.DeleteAllBomGroup(LineID:Integer):Boolean;
var
  s:String;
  bm:TBookmark;
begin
  result := False;
  s:= 'Select BOMGroupedLineID lineID  ' +
        ' from tblsalesgroupedlines  ' +
        ' where  BOMProductionLineID in (select BOMProductionLineID from tblsalesgroupedlines where BOMGroupedLineID=' +inttostr(LineID) +') ' +
        ' union ' +
        ' select BOMProductionLineID lineID from tblsalesgroupedlines where BOMGroupedLineID=' +inttostr(LineID) +' ';
  With Invoice.GetNewDataSet(s , true) do try
    if recordcount =0 then begin
      Result := true;
      Exit;
    end;
    First;
    bm := tbldetails.GetBookmark;
    try
      While Eof = False do begin
        if Invoice.Lines.Locate('salelineID' , fieldbyname('lineID').AsInteger , []) then begin
            (*Invoice.Lines.Deleted:= true;
            Invoice.Lines.postDB;*)
            DeleteLinerecord;
        end;
        Next;
      end;
    finally
      tbldetails.GotoBookmark(bm);
      tbldetails.FreeBookmark(bm);
    end;
  finally
    if active then close;
    Free;
  end;
end;
function TInvoiceGUI.DeleteLinerecord: Boolean;
begin
  REsult:= False;

  if DeletingAllBomGroup then begin
    result := inherited DeleteLinerecord;
    Exit;
  end;
  DeletingAllBomGroup:= True;
  try
    //if IstransLineLocked then Exit;
    if not IsOktodeleteLine then Exit;
    if invoice.Lines.BOMGroupedLine then result:= DeleteAllBomGroup(invoice.Lines.ID)
    else result := inherited DeleteLinerecord;
  finally
    DeletingAllBomGroup := False;
  end;
end;

procedure TInvoiceGUI.btnPaymentClick(Sender: TObject);
begin
  inherited;
  DisableForm;
  try
    invoice.OverrideHoldSale := True;
    if not SaveSalesRecord then Exit;
    invoice.HoldSale := False;
    invoice.PostDb;
    invoice.Dirty:= False;
    CommitAndNotify;
    CreatePayment;
    DetachAll;
    CloseWait;
  finally
    EnableForm;
  end;
end;

procedure TInvoiceGUI.btnPDFClick(Sender: TObject);
begin
  DisableForm;
  try
    if SaveSalesRecord then begin
      fbReportSQLSupplied :=   False;
      if chkChooseRpt.checked = False then  ReportToPrint := InvoiceReportName;
      Self.CommitAndNotify;
      try
        Invoice.Dirty:= false;
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

procedure TInvoiceGUI.btnSalesShippingDetailFormClick(Sender: TObject);
begin
  inherited;
  if self.AccessLevel > 3 then exit;
  SalesShippingDetailForm.Showmodal;
end;

procedure TInvoiceGUI.btnsplitPayClick(Sender: TObject);
begin
  inherited;
  if Invoice.TotalAmountInc = 0 then begin
    CommonLib.MessageDlgXP_Vista('The Invoice Total is Zero.',mtInformation,[mbOk],0);
    exit;
  end;
  DisableForm;
  try
    if not SaveSalesRecord then Exit;
    CommitAndNotify;
    Openrecord(0 , 'TfmSplitInvoicePayment');
    DEtachAll;
    Close;
  finally
    EnableForm;
  end;

end;

function TInvoiceGUI.Saverecord: boolean;
begin
  result := SaveSalesRecord;
  if result then result := inherited Saverecord;
end;

procedure TInvoiceGUI.lblProgressPaymentDblClick(Sender: TObject);
begin
  inherited;
  if Invoice.SOProgressPaymentGlobalRef='' then exit;
  if Invoice.dirty then
    if MessageDlgXP_Vista('This Will Save The Changes and Close Sales Order.  Do You Wish To Proceed?' , mtConfirmation, [mbyes,mbno],0) = mrno then exit;

  DisableForm;
  try
    if not SaveSalesRecord then Exit;
    CommitAndNotify;
    OpenERPForm('TSalesOrderGUI' , TSalesOrder.IDToggle(Invoice.SOProgressPaymentGlobalRef));
    DEtachAll;
    Close;
  finally
    EnableForm;
  end;
end;

procedure TInvoiceGUI.Lockcomponents;
begin
  inherited;
  if accesslevel <> 1 then
//  else if Invoice.CleanID =0 then begin
//    cboTerms.ReadOnly := False;
//    cboTerms.hint :='';
//    cboTerms.showhint := True;
//  end
  else if AppEnv.AccessLevels.GetEmployeeAccessLevel('change Terms-Invoice') <> 1 then begin
    cboTerms.ReadOnly := True;
    cboTerms.hint :='You don''t have access to change Terms';
    cboTerms.showhint := True;
  end else if (Invoice.DueDate > 0) and (Invoice.CustomerID > 0) and (AppEnv.Companyprefs.AllowchangeofTermAfterDueDate=False) and (Invoice.DueDate <Date) then begin
    cboTerms.ReadOnly := True;
    cboTerms.hint :='You have exceeded the terms due date (' + formatdatetime(FormatSettings.shortDateformat , Invoice.DueDate) +') and now the terms cannot be changed. ' +
    #13#10 + 'To disable this tick "Invoice: Allow Change of Terms After Due Date" in Preferences, Sales, General Section' ;
    cboTerms.showhint := True;
  end else begin
    cboTerms.ReadOnly := False;
    cboTerms.hint :='';
    cboTerms.showhint := True;
  end;

  if AppEnv.AccessLevels.GetEmployeeAccessLevel('ChooseTemplate-Invoice') <> 1 then begin
    chkChooseRpt.Enabled := False;
    chkChooseRpt.hint :='You don''t have access to choose template';
  end else chkChooseRpt.Enabled := True;

end;

procedure TInvoiceGUI.mnuPrintAddressLabelClick(Sender: TObject);
var
//  I: Integer;
  lSql : string;
begin
  fbReportSQLSupplied := true;
  try
    lSql := 'SELECT S.*, PRODUCT_DESCRIPTION as Description from tblSales S inner join tblSalesLines L on S.SaleId=L.SaleId ' +
            'WHERE S.SaleId = ' + tblDetails.FieldByName('SaleId').asString + ' AND L.SaleLineId=' + tblDetails.FieldByName('SaleLineId').asString;
    lSQL := companyInfoSQL('CompanyInfo') +
              ' ~|||~{Details}' + lSQL +
              '~|||~{Products}Select  SaleLineID,ProductName,Product_Description,Product_Description_Memo,UnitofMeasureQtySold,UnitofMeasureShipped,'+
                                      ' UnitofMeasureBackorder,concat(UnitofMeasureSaleLines,"(" , UnitofMeasureMultiplier,")") as UOM, TotalLineAmount,'+
                                      ' TotalLineAmountInc '+
                                      ' from tblsaleslines Where SaleId = ' + tblDetails.FieldByName('SaleId').asString +
                                      ' AND SaleLineId=' + tblDetails.FieldByName('SaleLineId').asString;
//      PrintTemplateReport('Address Labels', lSql, not(Appenv.Employee.ShowPreview) and not(devmode), 1);
      PrintTemplateReport('Address Line', lSql, not(Appenv.Employee.ShowPreview) and not(devmode), 1);
  finally
    fbReportSQLSupplied := false;
  end;
end;

function TInvoiceGUI.IstransLineLocked: Boolean;
begin
  Result := inherited IstransLineLocked;
  if result then exit;
  if (invoice.lines.IsProgressPayment) and ProgressPaymentSOConverted(Invoice.SOProgressPaymentGlobalRef)  then begin
    result := True;
    LineLockMsg :='This is a progress payment record and the sales order of this payment is already converted to an invoice - cannot be deleted';
    Exit;
  end;
  if invoice.lines.Dispatchstarted then begin
    result := True;
    LineLockMsg :='This product is already started dispatching - cannot be modified';
    Exit;
  end;
  if Sametext(invoice.lines.ProductName, PART_PROGRESSPAYMENT_TERMS) then begin
    result := True;
    if invoice.lines.TotalLineAmount < 0 then
         LineLockMsg :='This is the Sales Adjustment for Term Progress Payment'
    else LineLockMsg :='This is a Term Progress Payment';
    Exit;
  end;
  if invoice.lines.SOInvoiceLineRef <> '' then begin
    result := True;
    if SOInvoiceLineExists(invoice.lines.SOInvoiceLineRef) then begin
      LineLockMsg :='This is the Partial Build Invoice';
      Exit;
    end;
  end;
  if invoice.lines.PPGRef <> '' then begin
    if PPGExists(invoice.lines.PPGREF) then begin
      result := True;
      LineLockMsg :='This is the Partial Build Invoice';
      Exit;
    end;
  end;
end;


procedure TInvoiceGUI.PaymentLockValidate;
var
  s:String;
  Qry :TERPQuery;
begin
  inherited;

  (*s:= 'Select SaleId from tblSaleslines  '+
      ' where ifnull(ProgresspaymentRef,"") in  '+
      ' (select Globalref from tblsaleslines where saleId = '+intToStr(invoice.ID)+')';*)

     s:= 'Select SL.SaleId from tblSaleslines   SL ' +
              ' inner join tblSaleslines  PPL on (not IsNull(SL.ProgresspaymentRef)) and  (SL.ProgresspaymentRef = PPL.globalref)  ' +
              ' where PPL.saleId = '+intToStr(invoice.ID);
    Qry :=Invoice.GetSharedDataSet(s, true);
    //with Invoice.GetNewDataSet(s,true) do try
    Try
      if Qry.recordcount > 0 then begin
        lblInvoice.visible := true;
        CreditInvocieID :=Qry.fieldbyname('SaleID').asInteger;
        lblInvoice.caption := 'Invoice :' +intToStr(CreditInvocieID);
        if not fbPaymentLock then begin
          fbPaymentLock := True;
          ftLockType := ltProgressPaymentApplied;
        end;
      end;
    finally
      DbSharedObj.ReleaseObj(Qry);
    end;

  if not fbPaymentLock then begin
    s:= 'Select * from tblsales where (Globalref = '+Quotedstr(Invoice.GlobalRef) +' or  ProgressPaymentInvRef = '+Quotedstr(Invoice.GlobalRef) +') and ifnull(Payment,0)<>0';
    Qry :=Invoice.GetSharedDataSet(s, true);
    try
      if Qry.RecordCount>0 then begin
          fbPaymentLock := True;
          ftLockType := ltTermProgressTransPaid;
      end;
    finally
      DbSharedObj.ReleaseObj(Qry);
    end;
  end;
end;

procedure TInvoiceGUI.tblDetailsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  //Locksales;
end;

procedure TInvoiceGUI.tblMasterAfterInsert(DataSet: TDataSet);
begin
  inherited;
  lblInvoice.visible := False;
  lblProgressPayment.visible := False;
end;

procedure TInvoiceGUI.tblMasterAfterOpen(DataSet: TDataSet);
begin
  inherited;
    lblProgressPayment.visible :=Invoice.SOProgressPaymentGlobalRef<> '';
    if Invoice.SOProgressPaymentGlobalRef<> '' then begin
      lblProgressPayment.caption := 'Sales Order :' + intToStr(Tsalesorder.IDToggle(Invoice.SOProgressPaymentGlobalRef));
    end;
    try
      lblInvoicePaid.Visible := Invoice.IsPaid and not (Self.FullBackOrder and (Self.KeyID <> 0));
    except
    end;

end;

procedure TInvoiceGUI.tblMasterCalcFields(DataSet: TDataSet);
var
  TotalPrePayments ,  TotalPaid:double;
begin
  inherited;
  if Dataset.State = dsBrowse then
    exit;
  if Invoice.ID = 0 then
    exit;
  TotalPaid :=Invoice.TotalPaid;
  TotalPrePayments := Invoice.TotalPrePayments;

  tblMasterTotalInvoicePayment.asFloat := TotalPrePayments +TotalPaid;
  tblMasterInvoiceBalance.asFloat := Invoice.TotalAmountinc - tblMasterTotalInvoicePayment.asFloat ;
  edtPayment.hint := 'Total Customer Payment : ' +FloatToStrF(TotalPaid, ffCurrency, 15, CurrencyRoundPlaces)+ chr(13) +
                     'Total Customer Pre-Payment To be Applied: ' +FloatToStrF(TotalPrePayments, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TInvoiceGUI.lblInvoiceClick(Sender: TObject);
begin
  inherited;
  if Invoice.SOProgressPaymentGlobalRef='' then exit;
  if Invoice.dirty then
    if MessageDlgXP_Vista('This Will Save The Changes and Close Sales Order.  Do You Wish To Proceed?' , mtConfirmation, [mbyes,mbno],0) = mrno then exit;

  DisableForm;
  try
    if not SaveSalesRecord then Exit;
    CommitAndNotify;
    OpenERPForm('TInvoiceGUI' ,CreditInvocieID , nil, nil, False, False);
    DEtachAll;
    Self.close;
  finally
    EnableForm;
  end;
end;
procedure TInvoiceGUI.doShowPrepayments(Sender: TObject);
begin
  inherited;
  OpenPrepaylist;
end;

initialization
  RegisterClassOnce(TInvoiceGUI);
  with FormFact do begin
    RegisterMe(TInvoiceGUI, 'TfrmCustomerExtraDetails_*=SaleId');
    RegisterMe(TInvoiceGUI, 'TDispatchesReportGUI_*=SaleId');
    RegisterMe(TInvoiceGUI, 'TInvoiceListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TWooCommerceOrdersGUI_*=ERPSalesRef');
    RegisterMe(TInvoiceGUI, 'TSaleconvertedToListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TOverdueInvoicesGUI_*=SaleID');
    RegisterMe(TInvoiceGUI, 'TSalesDispatchesGUI_SaleID=SaleID');
    RegisterMe(TInvoiceGUI, 'TSalesDispatchBatchesGUI_*=SaleID');
    RegisterMe(TInvoiceGUI, 'TSalesDispatchBatchesGUI*=SaleID');
    RegisterMe(TInvoiceGUI, 'TCustPaymentListDettailsGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TInvoicesPrnGUI_*_Invoice=SaleID');
//    RegisterMe(TInvoiceGUI, 'TInvoicesPrnGUI_*=SaleID');
    RegisterMe(TInvoiceGUI, 'TColesInvoicelistExpressGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TInvoicelistExpressGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TNonERPSalesListGUI_*_Invoice=ERPTransId');
    RegisterMe(TInvoiceGUI, 'TWooCommerceInvoicesGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TInvoiceInternalOrderlistExressGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TSalesAddressLabelPrnGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TSalesAddressLabelPrnGUI_*_Refund=SaleID');
    RegisterMe(TInvoiceGUI, 'TSalesToRefundListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TCashProfitandLossGUI_*_Invoice=TRansId');
    RegisterMe(TInvoiceGUI, 'TSalesDashboardPnLdetailsGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TSalesDashBoardTopTenSalesManDetailsGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TSalesDashBoardTopTenProductsDetailsGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TSalesDashBoardTopTenCustomersDetailsGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TTransAccountDetailsGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TSalesTotalAmountMisMatchGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TBackOrdersListGUI_*=SaleID');
    RegisterMe(TInvoiceGUI, 'TbackorderInvoiceExpressGUI_*=SaleID');
    RegisterMe(TInvoiceGUI, 'TSOProgresspaymentsGUI_*=SaleID');
    RegisterMe(TInvoiceGUI, 'TPickingSlipGUI*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TSalesReportGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TSalesReportSaleslinescustomFieldListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TSalesReportCustomercustomFieldListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TSalesReportProductcustomFieldListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TWeeklySalesreportGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TProductSalesReportGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TProductSalesReportGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TSalesListwithCommisionGUI_SaleID_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TSalesListReportGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TSalesListOutstandingGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TAccountsReceiveListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TAccountsReceiveListDebugGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TStatementListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TStatementListGUI_*_Invoice Payment=SaleID');
    RegisterMe(TInvoiceGUI, 'TSerialListGUI_Type_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TSerialListGUI_DateSold_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TMemTransListGUI_*_TInvoiceGUI=TransID');
    RegisterMe(TInvoiceGUI, 'TBalTransListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TInventoryAssetVsStockStautsGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TToBeReconciledGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TReconListDetailFormGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TTrialBalTransListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TTransactionListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TBASTransReturnListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TNZTransReturnListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TVATTransReturnListGUI_*_Invoice=SaleID');

    RegisterMe(TInvoiceGUI, 'TGlobalsearchGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TGlobalsearchGUI_*_INVBO=SaleID');
    RegisterMe(TInvoiceGUI, 'TGlobalsearchGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TTransAccountDetailsGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TCustomerSummaryListingGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TEmployeeReportGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TEmployeeReportGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TJobProfitabilityGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TJobProfitabilityforCustomerGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TRepairProfitabilityGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TBackOrderPurchaseListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TCustomerBalanceDetailGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TGeneralLedgerReportGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TEmailedReportsList_*_Invoice=Transaction');
    RegisterMe(TInvoiceGUI, 'TManifestAllocationListGUI_*_INV=SaleID');
    RegisterMe(TInvoiceGUI, 'TFaxSpoolListingGUI_TransGlobal_Invoice=TransGlobal');
    RegisterMe(TInvoiceGUI, 'TFaxSpoolListingGUI_TransType_Invoice=TransGlobal');
    RegisterMe(TInvoiceGUI, 'TBarcodePickingListGUI_*_INV-NotPicked=SaleID');
    RegisterMe(TInvoiceGUI, 'TBackOrdersListGUI_OriginalNo=OriginalNo');
    RegisterMe(TInvoiceGUI, 'TfrmDeletedInvoicesListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TfmSalesCommissionList_*=SaleId');
    RegisterMe(TInvoiceGUI, 'TfmSalesRewardPointsList_*=SaleId');
    RegisterMe(TInvoiceGUI, 'TTransactionswith0QtyGUI_*_Invoice=TrasnsId');
    RegisterMe(TInvoiceGUI, 'TSalescommissionListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TSalescommissionListGUI_*=SaleId');
    RegisterMe(TInvoiceGUI, 'TSalescommissionListGUI_SaleDate=SaleId');
    RegisterMe(TInvoiceGUI, 'TCashBasisDetailsGUI_TransType_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TfmForeignSalesList_*=SaleID');
    RegisterMe(TInvoiceGUI, 'TAccountsReceivableNotes_*=SaleID');
    RegisterMe(TInvoiceGUI, 'TRepairInvoiceListGUI_InvoicedocNumber=SaleID');
    RegisterMe(TInvoiceGUI, 'TStockStatusRoling_*_Invoice=TransactionNo');
    RegisterMe(TInvoiceGUI, 'TTillSummaryReportGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TPickSlipGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TPickSlipManifestGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TSoldProductsReport_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TWorkOrderStatusListGUI_Invoice #=Invoice #');
    RegisterMe(TInvoiceGUI, 'TfmMarketingLead_*_Invoice=ActionID');
    RegisterMe(TInvoiceGUI, 'TDeliveryDocketListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TsalesOrderConvertedsalesListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TQuoteConvertedSalesListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TPickingSlipListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TAllTransactionGUI_*_Invoice=TransNo');
    RegisterMe(TInvoiceGUI, 'TCustomerSalesOnProductListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TBarcodePickListGUI_invoiceno_Invoice=invoiceno');
    RegisterMe(TInvoiceGUI, 'TBarcodePickListGUI_customername_Invoice=invoiceno');
    RegisterMe(TInvoiceGUI, 'TBarcodePickListGUI_Status_Invoice=invoiceno');
    RegisterMe(TInvoiceGUI, 'TRewardPointsGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TRewardPointsDetailsGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TRewardPointsDueToExpireGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TMemTransListGUI_*_Invoice=TransID');
    RegisterMe(TInvoiceGUI, 'TOrdersFromStockGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'THireSalesListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TBOMSalesListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TTransactionSequenceGUI_*_INV=TransID');
    RegisterMe(TInvoiceGUI, 'TNumberSequenceListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TSalesPrepaymentsGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TTransMissingBOList_*_Invoice=ID');
    RegisterMe(TInvoiceGUI, 'THourlySalesReportGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TsalesreportDetailsGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TPnLEmployeereportGUI_*_Invoice=TransID');
    RegisterMe(TInvoiceGUI, 'TDeldocketListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TSalesTaxReportGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TProcesseswithNotimeGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TRefundSalesListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TTranswithBOMissingGUI_*_Invoice=ID');
    RegisterMe(TInvoiceGUI, 'TPickedSalesListGUI_*_Invoice=SaleID');
    RegisterMe(TInvoiceGUI, 'TProductTransactionListGUI_*_Invoice=TransID');
    RegisterMe(TInvoiceGUI, 'TIncomingOrdersList_*_Invoice=SaleId');
    RegisterMe(TInvoiceGUI, 'TEBayOrdersGUI_*_Invoice=InvoiceID');
    RegisterMe(TInvoiceGUI, 'TMagentoOrdersGUI_*_Invoice=ID');
    //RegisterMe(TInvoiceGUI, 'TSalesAnalysisGraphDrilldownSalesGUI_*_Invoice=ID');
  end;

finalization
  UnRegisterClass(TInvoiceGUI);
end.







