{

 Date     Version  Who What
 -------- -------- --- ------------------------------------------------------
 26/05/05  1.00.01 BJ  The name of the Client combo box is changed in the
                       repair form not to open the client form when double
                       clicked. The reference to the Repairs.Client combo
                       is changed.
 13/07/05  1.00.03 BJ  Invoicing(completing) the SO should create the job -This should
                       happen only if the companyRef.RepairEquipListLimit = 'C'
 15/07/05  1.00.04 BJ  Fields added for warranty end date and warranty perioed in the grid
                       The field names are customisable.
 20/07/05  1.00.05 DSP Re-entered grdTransactions OnTitleButtonClick event
                       which was blank.
 28/07/05  1.00.06 IJB Added code to unlock (UserLock) on conversion
       epson                to Invoice.
 12/08/05  1.00.07 BJ  Serialno object inroduced. Serialno fieldtype is changed to mediumtext
 19/09/05  1.00.08.DSP ValidateCreationDate changed to always return 'False'
 27/09/05  1.00.09 DSP Added 'Copy to Refund' functionality.
 28/09/05  1.00.10 DSP Added functionality to allow sending of an email when
                       printing the picking slip.
 01/11/05  1.00.11 BJ  Field added for Future Order. Future Order doesn;t
                       allocate the qty, it stores the qty in unallocated SO.
 09/11/05  1.00.12 MV  Added functionality to prompt for client P.O.Number reuse.
 09/11/05  1.00.13 BJ  if the due date is > "FutureSODays" from today and if the
                        current record is not marked as  a Future SO, a confirmation is '
                        taken to mark it as FutureSO.
                        FutureSODays is employee.PendingSOAppeardays when given, otherwise 5

 09/12/05  1.10.00 IJB  Rewrite form to use new Business Objects.
 19/12/05  1.10.01 AL   Removed "Instance", *Task306*
 03/01/06  1.10.02 IJB  Moved SalesOrder object to Public.
 05/01/06  1.10.03 IJB  Added code to BusinessObject to check for unique
                        Customer PO Number and DoBusinessObjectEvent to set
                        focus back to input field.
 09/01/06  1.10.04 BJ   Trying to edit a readonly SO will open the BO after
                        a user confirmation.
 11/01/06  1.10.05 IJB  Fixed bug with Back Ordered SO opening blank
                        SO when user clicks on Copy To Invoice.
 02/02/06  1.10.06 DSP  Moved test for AppEnv.CompanyPrefs.SingleQtySO from here to
                        Sales unit.
 09/02/06  1.10.07 DSP  Changed HiddenFields to HideField.
 22/02/06  1.10.08 DSP  Fixed problem with copying to repairs.
 24/02/06  1.10.09 DSP  Added the copying of the custom fields when copying to
                        a smart order.
 10/03/06  1.10.10  AL  Added SalesOrder.Lines.ProductDescription := self.sInvDesc;
                        for progress payment description
 16/03/06  1.10.11 BJ   A sales order cannot be invoiced while the invoice form is opened.
 29/03/06  1.10.12 DSP  Added 'Notify' to actInvoiceExecute.
 03/04/06  1.10.13 DSP  When company preference 'SingleQtySO' is set then
                        remove 'Shipped' and 'BO' columns and change 'Ordered'
                        to 'Qty'.
 26/04/06  1.10.14 DSP  Disabled btnConRefund if it is a new sales order.
 29/05/06  1.10.15 AL   Invoicing: check for the assembly lines and if exists take confirmation
                        to proceed as after invoicing the assembly products in the SO
                        will not appears in Assembly Progress.
 23/01/07   1.10.16 BJ  Progressbar at Save is replaced with the messagelabel.

}

unit frmSalesOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Sales, DB,   wwdbdatetimepicker, wwdblook, StdCtrls,
  DBCtrls, Mask, ExtCtrls, wwcheckbox, Buttons, DNMSpeedButton, DNMPanel,
  Wwdbigrd, Grids, Wwdbgrid, ActnList, SelectionDialog, Menus, AdvMenus, wwdbedit,
  {Psock,} ImgList, AppEvnts, frmInvoice,  MemDS, DBAccess, MyAccess,ERPdbComponents,
  DataState, DMComps, EmailUtils, BusObjBase, BusObjSales,
  IdGlobal,ComCtrls,AdvOfficeStatusBar, MessageInterface, Shader,
  ProgressDialog, TeeProcs, TeEngine, Chart, ERPDbLookupCombo, DNMAction, busobjPQA;
const
    SX_OpenInv= WM_USER + 201;
    SX_OpenSO= WM_USER + 202;
    //SOApprovedStatus = 'Approved For Invoicing';
type
  pPrjLineRec = ^TPrjLineRec;

  TPrjLineRec = record
    LineNum: Integer;
    EndDate: TDateTime;
  end;

type
  TSalesOrderGUI = class(TBaseSaleGUI)
    Label3: TLabel;
    cboShipDate: TwwDBDateTimePicker;
    actInvoice: TAction;
    actConCash: TAction;
    qryPartsTemplate: TERPQuery;
    DNMPanel2: TDNMPanel;
    wwCheckBox1: TwwCheckBox;
    btnCopyToRepair: TDNMSpeedButton;
    actConRepair: TAction;
    lblPickUpFrom: TLabel;
    btnPickUpFrom: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    Label7: TLabel;
    chkManifest: TwwCheckBox;
    tblDetailsLastUpdated: TDateTimeField;
    actConComplete: TAction;
    btnCompleteNoInvoice: TDNMSpeedButton;
    tblDetailsIsQuote: TWideStringField;
    tblMasterPOCreated: TWideStringField;
    tblDetailsDocketNumber: TWideStringField;
    tblDetailsWarrantyEndsOn: TDateField;
    tblDetailsWarrantyPeriod: TWideStringField;
    tblMasterFutureSO: TWideStringField;
    bvlForeign: TBevel;
    pnlFutureOrder: TDNMPanel;
    chkFutureSO: TwwCheckBox;
    Label2: TLabel;
    tblDetailsForeignExchangeSellCode: TWideStringField;
    actProgressPayment: TAction;
    tblDetailsAutoSmartOrder: TWideStringField;
    tblMasterAutoSmartOrderRef: TWideStringField;
    tblDetailsSmartOrderCreated: TWideStringField;
    qryWorkOrderPriority: TERPQuery;
    qryWorkOrderPriorityText: TWideStringField;
    qryGetPriority: TERPQuery;
    qryWorkOrderPriorityColor: TLargeintField;
    tblMasterIsInternalOrder: TWideStringField;
    btnCash: TDNMSpeedButton;
    btninv: TDNMSpeedButton;
    dtShipETA: TwwDBDateTimePicker;
    Bevel6: TBevel;
    Bevel5: TBevel;
    DNMPanel4: TDNMPanel;
    chkIsInternalOrder: TwwCheckBox;
    lblConverted: TLabel;
    btnShipmentDetails: TDNMSpeedButton;
    wwDBEdit1: TwwDBEdit;
    Label13: TLabel;
    btnProgressPayment: TDNMSpeedButton;
    tblDetailsProgresspaymentRef: TWideStringField;
    tblMasterSOProgressPaymentGlobalRef: TWideStringField;
    tblMasterSOProgressPaymentOriginalRef: TWideStringField;
    lblconvertedtoRepairs: TLabel;
    DNMSpeedButton2: TDNMSpeedButton;
    actCopyOrder: TDNMAction;
    tblMasterTotalProgressPayments: TFloatField;
    tblMasterBalanceAmount: TFloatField;
    Label4: TLabel;
    qrysalesdeliverydetails: TERPQuery;
    dssalesdeliverydetails: TDataSource;
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
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    Label14: TLabel;
    tblDetailsTreeFinalized: TWideStringField;
    tblDetailsBOMGroupedLine: TWideStringField;
    tblDetailsBOMProductionLine: TWideStringField;
    actTakeFromStock: TDNMAction;
    actcomplnInvoice: TDNMAction;
    btnComplnInvoice: TDNMSpeedButton;
    btnTakeFromStock: TDNMSpeedButton;
    btnFinalizeOrder: TDNMSpeedButton;
    actfinalizeBuild: TAction;
    mnuPartialShipments: TMenuItem;
    actPartialInvoice: TDNMAction;
    mnuPartialInvoice: TMenuItem;
    mnuPartialShipmentLine: TMenuItem;
    N5: TMenuItem;
    tblDetailsAssembled: TWideStringField;
    tblDetailsExcludeFromSmartOrder: TWideStringField;
    procedure actConCashExecute(Sender: TObject);
    procedure actConCompleteExecute(Sender: TObject);
    procedure actInvoiceExecute(Sender: TObject);
    procedure actInvoiceUpdate(Sender: TObject);
//    procedure actConRepairExecute(Sender: TObject);
//    procedure actConRepairUpdate(Sender: TObject);
    procedure actConSmartExecute(Sender: TObject);
    procedure actDelDocketExecute(Sender: TObject);
    procedure actPickExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnPickUpFromClick(Sender: TObject);
    procedure cboEmployeeNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure cboProductXNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure cmdFaxClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tblDetailsBeforePost(DataSet: TDataSet);
    procedure tblDetailsUnitofMeasureQtySoldChange(Sender: TField);
    procedure tblMasterAfterOpen(DataSet: TDataSet);
    procedure cboShipDateExit(Sender: TObject);
    procedure cboShipDateEnter(Sender: TObject);
    procedure cboDueDateEnter(Sender: TObject);
    procedure cboDueDateExit(Sender: TObject);
    procedure grdTransactionsKeyPress(Sender: TObject; var Key: Char);
    procedure actConSmartUpdate(Sender: TObject);
    procedure grdTransactionsDblClick(Sender: TObject);
    procedure chkIsInternalOrderClick(Sender: TObject);
    procedure grdTransactionsEnter(Sender: TObject);
    procedure actConCashUpdate(Sender: TObject);
    procedure grdTransactionsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure btnCloseClick(Sender: TObject);
    procedure btnCopyToRepairClick(Sender: TObject);
    procedure btnFreightTNTClick(Sender: TObject);
    procedure actCustomerContactsExecute(Sender: TObject);
    procedure grdTransactionsTitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure grdTransactionsCalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure actProgressPaymentExecute(Sender: TObject);
    Procedure SOProgresspaymentsbeforeopen(Sender:TObject);

    procedure actCopyOrderUpdate(Sender: TObject);
    procedure actCopyOrderExecute(Sender: TObject);
    procedure tblMasterCalcFields(DataSet: TDataSet);
    procedure doShowPrepayments(Sender: TObject);Override;
    procedure mnuconvertedToListClick(Sender: TObject);
    procedure actConCompleteUpdate(Sender: TObject);
    procedure txtShipToEnter(Sender: TObject);
    procedure txtShipToExit(Sender: TObject);
    procedure actcomplnInvoiceUpdate(Sender: TObject);
    procedure actcomplnInvoiceExecute(Sender: TObject);
    procedure actTakeFromStockExecute(Sender: TObject);
    procedure actTakeFromStockUpdate(Sender: TObject);
    procedure qrysalesdeliverydetailsAfterOpen(DataSet: TDataSet);
    procedure actfinalizeBuildExecute(Sender: TObject);
    procedure tblDetailsAfterPost(DataSet: TDataSet);
    procedure tblDetailsAfterOpen(DataSet: TDataSet);
    procedure mnuPartialShipmentsClick(Sender: TObject);
    procedure actPartialInvoiceExecute(Sender: TObject);
    procedure qryClientLookupAfterOpen(DataSet: TDataSet);
    procedure cboProductQryAfterOpen(DataSet: TDataSet);
    procedure btnPrepaymentClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnShipmentDetailsClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }
    iCustomerID         : Integer;
    bInitialiseStartup  : Boolean;
    ffrmConvertedFrm    : TInvoiceGUI;
    fbNoConvertQuestion : Boolean;
    OldShipmentdate     : TDateTime;
    oldDueDate          : TDatetime;
    FirstSOId           : Integer;
    FnSOToInvoice       : Integer;
    //FnCompleteSO        : Integer;
    fOpenedFromShipContainer: Boolean;
    fShipContainerSaleLineID:integer;
    fbHasProcess :boolean;
    fbDofinalisenClose: boolean;
    fbDoCalcTreePrice: boolean;

    function    JobCreated:Boolean;
    function    getjobTitle:String;
    procedure   UpdateButtonActions;
    procedure   SetButtonState(const Value: Boolean);
    procedure   HandleSalesOrderErrors;
    Procedure   OpenInv(Var Msg :TMessage); message SX_OpenInv;
    Procedure   OpenSO(Var Msg :TMessage); message SX_OpenSO;

    procedure   SaveProcessData;
    //Function ChecknValidateInternalOrder:Boolean;
    procedure DeleteNonTreeLinesCallback(const Sender: TBusObj; var Abort: Boolean);

    (*procedure   SetPriorityCombo;*)
    Function    IsOktoconvert(Sender: TObject; CopyTo: TBusobjClass) :Boolean;
    procedure   SetTitle;
    function AnyProcessScheduled:Boolean;
    function ToBeApprovedNApproved: Boolean;

    procedure initConvertingFromRef(Sender: TObject);
    procedure PrintDeldocket;
    procedure LinesFinaliseTreeCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure DeleteTreeCallback(const Sender: TBusObj; var Abort: Boolean);
    function HasProcess: Boolean;
    procedure DeleteAllTreesofSO;
    procedure ShowmanufactureSummary(IgnorePref: boolean);
    Procedure OpenTree;

    Procedure SaveTree;
    (*procedure SearchLinesForBOMEntries(IdListManufacture,
      IDListFromStock: TIntegerList);*)

    Function SOHasLines         (const Msg:String; const ShowMsg:Boolean = True):Boolean;
    Function SOhasProcess       (const Msg:String; const ShowMsg:Boolean = True):Boolean;
    Function IsaSavedSO         (const Msg:String; const ShowMsg:Boolean = True):Boolean;
    Function HasAccesstoInvoice (const Msg:String; const ShowMsg:Boolean = True):Boolean;
    //Function IsRepairSO         (const Msg:String; const ShowMsg:Boolean = True):Boolean;
    Function IsSoLayby          (const Msg:String; const ShowMsg:Boolean = True):Boolean;
    Function hasScheduledProcess(const Msg:String; const ShowMsg:Boolean = True):Boolean;
    Function HasAccess          (const Msg:String; const ShowMsg:Boolean = True; AccessLevelreqd:Integer = 3):boolean;
    Function IsSOCompleted      (const Msg:String; const ShowMsg:Boolean = True; Extracon:Boolean =true):Boolean;
    Function IsSOConverted      (const Msg:String; const ShowMsg:Boolean = True):Boolean;
    function SoHasnoProcess     (const Msg:String; const ShowMsg:Boolean = True): Boolean;
    Function IsnotSOCompleted   (const Msg:String; const ShowMsg:Boolean = True):Boolean;
    function SendPrintSMS: boolean;
    function SendPrintSMSSilent: boolean;
    function SendPrintEmail: boolean;
    function SendPrintEmailSilent: boolean;
    function SOCompleted: Boolean;
    procedure EnableComplete;
    procedure beforeshowsalesOrderInvoicesGUI(Sender: TObject);
    procedure initSalesorderInvoice(Sender: TObject);
    Procedure PrintManufacturesummary(Sender: TObject);
    Procedure DeleteBOMClick(Sender: TObject);
    function FinaliseBuild: Boolean;
    procedure PrintJobDetailsCallback(const Sender: TBusObj;      var Abort: Boolean);
    Procedure EmailSalesOrder;
    procedure EmailSalesOrderSilent;
    procedure CheckfinalisenClose;

    //Procedure PrintBOMBarcode(Sender: TObject);

    //function HasToAndIsApproved: Boolean;
  protected
    WasConvertedTrans: Boolean;
    HasAsseblyLines     : boolean;
    function EmailTransaction(const RecipientAddress :String ='';ASilent: boolean=True; ASecret : boolean=True): boolean;Override;
    procedure   IsOK_to_Print(var IsOk: Boolean); override;
    function    GetReportTypeID: Integer; override;
    function    ValidateClosingDate(const TransDate: TDateTime): Boolean; override;
    procedure   DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); override;
    Procedure BeforeAllocationformShow; override;
    function Saverecord :boolean; override;
    Procedure recalcInvoicesamount;Override;
    procedure SetDatasetconn;Override;
    function IstransLineLocked: Boolean; Override;
    function SaveTransToPDF: boolean; override;
    procedure Lockcomponents;override;
    procedure NewTransBusObjinstance;override;
    procedure KeyIdChanged(const NewKeyId: integer); Override;
    procedure AddProductPriceMenu;Override;
    Procedure WriteExtraGuiPref; override;
    procedure SetDirty(ADirty : boolean);override;
    procedure InitGridDisplay;
    procedure DoAfterShowCustomiseForm; override;
    Function  Save4NewTrans:Boolean;Override;
  public
    SalesOrder                : TSalesOrder;
    ProcessAlreadyStarted:Boolean;
    property NoConvertQuestion: Boolean     read fbNoConvertQuestion write fbNoConvertQuestion;
    property ConvertedFrm     : TInvoiceGUI read ffrmConvertedFrm;
    property CustomerID       : Integer     read iCustomerID         write iCustomerID;
    property InitialiseStartup: Boolean     read bInitialiseStartup  write bInitialiseStartup;
    property OpenedFromShipContainer: Boolean read fOpenedFromShipContainer write fOpenedFromShipContainer;
    property ShipContainerSaleLineID:integer read fShipContainerSaleLineID write fShipContainerSaleLineID;
    procedure CommitAndNotify;Override;
    procedure UpdateMe(const Cancelled: boolean; const aObject: TObject);Override;
    procedure UpdateMe; override;
    procedure DoOnClientchange;Override;
    function SaveSalesRecord: boolean;Override;
    procedure PrintJobDetails;
    procedure PrintJobDetailsofLine;
    Property DofinalisenClose  :boolean read fbDofinalisenClose  write fbDofinalisenClose ;
    Property DoCalcTreePrice  :boolean read fbDoCalcTreePrice  write fbDoCalcTreePrice ;
    //procedure SendEmailCallback(const ACommaContactEmails : string; ASilent, ASecret : boolean); override;
  published
    function InitialiseCustomerID(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
    procedure PerformInvoiceConversion(MsgObj: TMsgObj);
  end;

implementation

{$R *.dfm}

uses
    FormFactory,  frmSmartOrderFrm, DNMExceptions,
    CommonDbLib, FaxObj,
    frmPickupFromAddressPopup,
    GlobalEventsObj,  frmCustomerFrm,
    frmJob, tcDataUtils, Dateutils,
    BusObjConst, CommonLib,
     BaseInputForm, frmCashSale,
    BaseTransForm, BusObjTrans, tcTypes,
    AppEnvironment, FastFuncs, BusObjSaleBase, BusObjClient, BusobjCash,
  BusObjSmartOrder, DNMLib, tcConst, frmAllocation, BaseFormForm,
  BusobjSalesShippingDetails, CommonFormLib,
  SOProgresspayments,  BusObjPrintDoc, frmCustPrepayments,
  salesOrderConvertedsalesList, busobjSalesDelDetails,
  frmSalesDeliveryDetails, MySQLConst, ProcessDataUtils, BusObjProcess,
  frmsaleslineManufactureSummary, frmReportingOptions, SMSUtils,
  ProcessUtils , IntegerListObj,  SystemLib, salesOrderInvoices,
  frmSalesorderInvoice, frmShippingAllocation, LogLib, CorrespondenceObj, EmailExtraUtils,
  DbSharedObjectsObj, ManufactureLib, TempTableUtils, PQALib, AlternateProducts,
  BusObjFeTransLines, EmployeeAccesses, Preferences, MessageDlgXP_forPreference,
  frmSalesExt, BOMLib, Menulib, BusobjExternalXRef;


procedure TSalesOrderGUI.btnCompletedClick(Sender: TObject);
var
  msgTo: string;
begin
  DisableForm;
  try
    if SaveSalesRecord then begin
      CommitAndNotify;

      if Salesorder.Anylinehastree then
        if AppEnv.CompanyPrefs.CompleteBOMOrderOnSave then
              FinaliseBuild;

      if AppEnv.CompanyPrefs.EnableInvoiceSaveMail and ((SalesOrder.ContactEmail <> '') or (SalesOrder.Customer.Email <> '')) then begin

        msgTo := SalesOrder.ContactMobile;
        if msgTo = '' then msgTo := SalesOrder.Customer.Mobile;
        TCorrespondenceGui.EmailCustomerSale(msgTo, GetSalesEmails,
          TMailUtils.SubstituteText(AppEnv.CompanyPrefs.SOSaveEmailSubject, PopulateMessageSubstituteList),
          TMailUtils.SubstituteText(AppEnv.CompanyPrefs.SOSaveEmailText, PopulateMessageSubstituteList),
          self.tblMasterClientID.AsInteger);

      end;
      if AppEnv.CompanyPrefs.SMSEnabled and
         AppEnv.CompanyPrefs.EnableSOSaveSMS and
         ((SalesOrder.ContactMobile <> '') or (SalesOrder.Customer.Mobile <> '')) then begin
        { send SMS silently }

        msgTo := SalesOrder.ContactMobile;
        if msgTo = '' then msgTo := SalesOrder.Customer.Mobile;

        { send SMS silently }
        TCorrespondenceGui.SMSCustomer(msgTo,
          TMailUtils.SubstituteText(AppEnv.CompanyPrefs.SOSaveSMSText, PopulateMessageSubstituteList),
          self.tblMasterClientID.AsInteger, true);

      end;

      if SalesOrder.ShippedQtyChanged then begin

        if AppEnv.CompanyPrefs.EnableSOShipChangeEmail and ((SalesOrder.ContactEmail <> '') or (SalesOrder.Customer.Email <> '')) then begin

          msgTo := SalesOrder.ContactEmail;
          if msgTo = '' then msgTo := SalesOrder.Customer.Email;

          TCorrespondenceGui.EmailCustomerSale(msgTo, GetSalesEmails,
            TMailUtils.SubstituteText(AppEnv.CompanyPrefs.SOShipChangeEmailSubject, PopulateMessageSubstituteList),
            TMailUtils.SubstituteText(AppEnv.CompanyPrefs.SOShipChangeEmailText, PopulateMessageSubstituteList),
            self.tblMasterClientID.AsInteger);

        end;
        if AppEnv.CompanyPrefs.SMSEnabled and
           AppEnv.CompanyPrefs.EnableSOShipChangeSMS and
           ((SalesOrder.ContactMobile <> '') or (SalesOrder.Customer.Mobile <> '')) then begin

          msgTo := SalesOrder.ContactMobile;
          if msgTo = '' then msgTo := SalesOrder.Customer.Mobile;

          { send SMS silently }
          TCorrespondenceGui.SMSCustomer(msgTo,
            TMailUtils.SubstituteText(AppEnv.CompanyPrefs.SOShipChangeSMSText, PopulateMessageSubstituteList),
            self.tblMasterClientID.AsInteger, true);
        end;

      end;

      if AppEnv.CompanyPrefs.AutomaticSODeliveryDocketPrint then
        PrintDeldocket;

      Salesorder.Dirty := false;
      Close;
    end;
  finally
    EnableForm;
  end;
end;

procedure TSalesOrderGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  inherited;
  fbHasProcess:= False;
end;

procedure TSalesOrderGUI.cboEmployeeNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  Accept := False;
  // stop not in list processing for this combo, for now
end;

procedure TSalesOrderGUI.FormShow(Sender: TObject);
var
  qryEmailedList: TERPQuery;
begin

stepProgressbar;
try
  DisableForm;
  try
    try
      if (AppEnv.CompanyPrefs.ManifestType = 'SALESORDER') or (AppEnv.CompanyPrefs.ManifestType = 'BOTH') then begin
        Label7.Visible := True;
        chkManifest.Visible := True;
        DNMPanel1.Visible := True;
      end;
      btnPickUpFrom.Visible := true;
      lblPickUpFrom.Visible := true;


      if KeyID <> 0 then
      begin
        btnPickUpFrom.Enabled := True;
        qryEmailedList := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
        try
          qryEmailedList.Sql.Clear;
          qryEmailedList.Sql.Add('SELECT * FROM tblEmailedReports WHERE  reporttype = "Sales Order" and TransactionID = ');
          qryEmailedList.Sql.Add(IntToStr(KeyID));

          qryEmailedList.Open;

          if qryEmailedList.FieldByName('ContactID').asinteger <> 0 then begin
            EmailContactID := qryEmailedList.FieldByName('ContactID').asinteger;
          end;
        finally
          DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryEmailedList);
        end;
      end
      else
      begin
        btnPickUpFrom.Enabled := False;
      end;

      bCreditCheckOn := AppEnv.CompanyPrefs.CreditCheckSO;

      inherited;
      SalesOrder.Lines.DataSet.Filter := SalesOrder.Lines.DataSet.Filter +' and BOMProductionLine <> '+Quotedstr('T');
      mnuconvertedToList.Enabled := SalesOrder.Converted;
      if accesslevel = 1 then
        if tblMaster.fieldByname('converted').asBoolean then begin
          TransAccessMsg:= 'This Sales Order Already Converted';
          Caption := TitleLabel.Caption + '(Frozen) - ' + TransAccessMsg ;
          accesslevel:= 5;
        end;
              { 2/7/2014  The following was removed at Federal Wages request,
                          they want to be able to edit an SO that has been sent!! }
(*
        else if (SalesOrder.Shipment.Count > 0) and (SalesOrder.Shipment.Status = 'Processed') then begin
          Caption := TitleLabel.Caption + '(Frozen) - This Sales Order''s Shipment(s) Processed';
          accesslevel:= 5;
        end;
*)


      if (SalesOrder.ShipmentList.Count > 0) and (SalesOrder.ShipmentList.Status = 'Processed') then
        btnShipment.Color := $0077ff77;

      if qryShipContainerSaleLookup.active then qryShipContainerSaleLookup.close; {keep lookup in transaction}
      qryShipContainerSaleLookup.Connection := MyConnection;
      qryShipContainerSaleLookup.Open;

      if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnShowMargin') = ACCESS_ALLOWED then begin
        lblMargin.Visible := true;
        lblMarginLabel.Visible := true;
        lblCost.Visible := true;
        lblCostLabel.Visible := true;
      end    else begin
        lblMargin.Visible := false;
        lblMarginLabel.Visible := false;
        lblCost.Visible := false;
        lblCostLabel.Visible := false;
      end;


      if keyId <> 0 then begin

          if SalesOrder.IsLayby then begin
            Self.Caption := 'Layby';
            btnNext.Enabled:= false;
            btnProgressPayment.Visible:= false;
          end;

          if accesslevel <5 then begin
            if SalesOrder.IsLayby then begin
//              Self.Caption := Self.Caption + '     { Layby Transaction - Readonly}';
              accesslevel := 5;
            end else if AnyProcessScheduled then begin
              Self.Caption := Self.Caption + '     { Process(s) Already Started}';
              accesslevel := 5;
              ProcessAlreadyStarted:= true;
            end else if SalesOrder.HasAnyshippednInvoiced then begin
              Self.Caption := Self.Caption + '     { Product(s) Already Shipped and Invoiced}';
              accesslevel := 5;
              ProcessAlreadyStarted:= true;
            end;
          end;
          if accesslevel <5 then begin
            if (SalesOrder.IsBOInvoiced) or (SalesOrder.IsLayby) then begin
              (*CommonLib.MessageDlgXP_Vista('Please be Aware that Access to This '+
                                TypeToDescription(ClassNameToTranType(Self.ClassName))+
                                ' Record is Read-Only.', mtWarning, [mbOK], 0);*)
              TransAccessMsg:= 'Grid is Read-Only.  Back Order already invoiced';
              TransTimerMsg(TransAccessMsg , 5);
              fLockSalesInitialized:= false;
              TransAccesslevel := 5;
            end;
          end;


          if (Accesslevel >3 )  then begin
            {Set the form to read only because we don't want to allow edits when a backorder has been invoiced}
            if dgEditing in grdTransactions.Options then
                grdTransactions.Options := grdTransactions.Options - [dgEditing];

            if dgAllowInsert in grdTransactions.KeyOptions then
              grdTransactions.KeyOptions := grdTransactions.KeyOptions - [dgAllowInsert] ;
         //   cboProductX.ReadOnly := True;
            cboclientR.ReadOnly := True;
            cboClass.ReadOnly := True;
            cboEmployee.ReadOnly := True;
            cboTaxCode.ReadOnly := True;
            if SalesOrder.IsBOInvoiced then begin
                  TransAccessMsg :='This Sales Order''s BackOrder already ''Shipped''';
                  Caption := TitleLabel.Caption + '(Frozen) - ' + TransAccessMsg;
            end;
//            if SalesOrder.IsLayby then
//              Caption := TitleLabel.Caption + '(Frozen) - Layby Transaction';
          end;

      end else begin
        //Locksales;
      end;

      if (accesslevel <> 3) and (accesslevel <> 5) and (KeyId =0) then self.SaleBase.CalcOrderTotals;
      lblEstimatedFinalAmt.Caption:=
        FloatToStrF(SaleBase.TotalEstimatedAmountInc, ffCurrency, 15, CurrencyRoundPlaces);

      InitGridDisplay;

      if tblDetails.Recordcount > 0 then
        tblDetails.First;

      Locksales;

      btnConSmart.Enabled := not fbPaymentLock;
      actProgressPayment.Enabled := not fbPaymentLock;
//      btnFreightTNT.Enabled := not fbPaymentLock;

      FnSOToInvoice := AppEnv.AccessLevels.GetEmployeeAccessLevel('FnSOToInvoice') ;
      //FnCompleteSO:= AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCanCompleteSalesOrder') ;

      if KeyID = 0 then
      begin
        tblMaster.Edit;
        tblMaster.FieldByName('POCreated').AsBoolean := False;
      end;

      // Are we opening up with given parameters?
      if InitialiseStartup then
      begin
        SalesOrder.Customername :=
          GetClientName(CustomerID);
        tblMaster.FieldByName('ClientID').AsInteger := CustomerID;
        cboClientR.SearchMode := TERPLookupComboSearchMode.smStartsWith;
        cboClientR.Text := GetClientName(CustomerID);
        cboClientR.F6Search;
        cboClientR.LookupTable.Locate('ClientID', CustomerID, []);
        tblMaster.Post;
        tblMaster.Edit;
        cboClientR.Text := GetClientName(CustomerID);
        InitialiseStartup := False;
      end;

      if not AppEnv.CompanyPrefs.ShowDocketNumberColumnOnSales then
      begin
        grdTransactions.RemoveField('DocketNumber');
        GuiPrefs.DbGridElement[grdTransactions].HideField('DocketNumber');
      end
      else
        grdTransactions.AddField('DocketNumber');

      IsFormshown := true;

      if not AppEnv.CompanyPrefs.BarcodePickingInSOMode then begin
        DNMPanel2.Visible := False;
        grdTransactions.RemoveField('Assembled');
      end;

      UpdateButtonActions;
      if KeyID = 0 then
      begin // disable on new record
        actConComplete.Enabled := False;
        actConSmart.Enabled := False;
        actProgressPayment.Enabled := False;
      end;

      grdTransactions.ColumnByName('Discounts').DisplayLabel := 'Discount ('+AppEnv.RegionalOptions.CurrencySymbol+')';

      (*SetPriorityCombo;*)
      SalesOrder.Dirty:= false;

      lblBaseForeignCurrencyCode.Enabled := AppEnv.CompanyPrefs.UseForeignCurrencyOnSales;
      cboBaseForeignCurrencyCode.Enabled := AppEnv.CompanyPrefs.UseForeignCurrencyOnSales;
      lblBaseExchangeRate.Enabled := AppEnv.CompanyPrefs.UseForeignCurrencyOnSales;
      edtBaseExchangeRate.Enabled := AppEnv.CompanyPrefs.UseForeignCurrencyOnSales;
      //actProgressPayment.enabled := not(Salesorder.Converted) and (SalesOrder.TotalProgressPayments >0);
      SetTitle;
      SetControlFocus(cboClientR);
    except
      on EAbort do
        HandleEAbortException;
      on e: ENoAccess do
      begin
        HandleNoAccessException(e);
        exit;
      end;
      else Raise;
    end;

    btnCopyToRepair.enabled :=True; (*(SalesOrder.RepairID= 0) and (Accesslevel <=3) ;*)
    btnPrepayment.enabled := true; (*(Accesslevel <=3) ;*)
  finally
    EnableForm;
    SetControlFocus(cboClientR);
  end;
  CheckfinalisenClose;
finally
  if SalesOrder.IsLayby then if Accesslevel <5 then Accesslevel := 5;
  CheckshiptoAccess;
  Enabledisable;
  hideProgressbar;
  ShowGridLockMsg;
  hideProgressbar;
  Lockcomponents;
end;
Logtime('Form Shown');
end;
Procedure TSalesOrderGUI.CheckfinalisenClose;
begin
  if dofinalisenClose then begin
    actfinalizeBuildExecute(actfinalizeBuild);
  end;
  if DoCalcTreePrice then begin
        if Salesorder.Lines.hastree then
            if Salesorder.Lines.Qtyshipped <> 0 then
              SaveTree;
        Self.close;
  end;
end;
Function TSalesOrderGUI.getjobTitle:String;
begin
   if Trim(AppEnv.CompanyPrefs.JobNameHeader) <> '' then
    Result :=AppEnv.CompanyPrefs.JobNameHeader
   else
    Result := ' Customer Job.';
end;

procedure TSalesOrderGUI.actInvoiceUpdate(Sender: TObject);
begin
    TAction(Sender).Enabled := TRue;
    chkIsInternalOrder.Enabled:= not SalesOrder.Converted;
end;
procedure TSalesOrderGUI.actConCompleteUpdate(Sender: TObject);
begin
  inherited;
//  EnableComplete;
//  TAction(Sender).Enabled := true;
  //btnCompleteNoInvoice.Caption :=TAction(Sender).Caption ;

  (*(SalesOrder.converted) and
      (SAlesOrder.convertedtoInvoicecount =0) ;*)

  (*if SalesOrder.converted then begin
      TAction(Sender).Enabled := SAlesOrder.convertedtoInvoiceCount =0;
      if SAlesOrder.convertedtoInvoicecount =0 then begin
        TAction(Sender).Caption := 'Cancel Complt';
        btnCompleteNoInvoice.Caption :=TAction(Sender).Caption ;
        TAction(Sender).Visible := TRue;
      end;
  end else begin
    TAction(Sender).Enabled := ((tblDetails.RecordCount > 0) and (KeyID <> 0) and (Accesslevel <=3)
                            and (FnSOToInvoice = 1) and (FnCompleteSO =1) and (not SalesOrder.IsInternalOrder))
                            and (SalesOrder.RepairID = 0) and (not(SalesOrder.islayby));
  end;*)
  chkIsInternalOrder.Enabled:= not SalesOrder.Converted;

end;

Function TSalesOrderGUI.JobCreated:Boolean;
var
  msgOption :Integer;
  Form : TComponent;
begin
  msgOption := mrOk;
  {invoice should be created only when the preference is set}
//  if AppEnv.CompanyPrefs.RepairEquipListLimit = 'C' then
//      msgOption := mrYes;
  {When invoicing the SO again, make sure that the machine is not created last time.
  This is an option to invoice the SO again without duplicating the Machine.}
  if msgOption = mrYes then
    if tblMaster.FieldByname('Converted').ASSTring = 'T' then
        if CommonLib.MessageDlgXP_Vista('Was the ' + getjobTitle + ' created when invoiced last time?' , mtConfirmation, [mbYes, mbNo], 0) = mrYes then
            msgOption := mrOk;
  While MsgOption = mrYes do begin

      If FormStillOpen('TJobGUI') then begin
        TJobGUI(FindExistingComponent('TJobGUI')).Close;
        Application.ProcessMessages;
      end;

      Form := GetComponentByClassName('TJobGUI');
      if Assigned(Form) then begin //if has acess
        with TJobGUI(Form) do begin
          KeyId := -(getClientID(CLIENT_WORKSHOP));
          Position := poScreenCenter;
          ShowModal;
          if ModalResult <> mrOk then begin
                MsgOption := CommonLib.MessageDlgXP_Vista('This Sales Order cannot be invoiced/completed without creating '+
                                          getjobTitle +'.' + chr(13) + 'Do you wish to Create it now?',
                                          mtconfirmation , [mbYes,mbNo], 0);
          end else MsgOption := mrok;
        end;
      end;
  end;
  Result := (MsgOption <> mrNo); // or (AppEnv.CompanyPrefs.RepairEquipListLimit <> 'C');
end;

procedure TSalesOrderGUI.KeyIdChanged(const NewKeyId: integer);
begin
  inherited;

end;


procedure TSalesOrderGUI.mnuconvertedToListClick(Sender: TObject);
begin
begin
  inherited;
  OpenERPListFormSingleselect('TsalesOrderConvertedsalesListGUI' , nil, initConvertingFromRef);
end;
end;
procedure TSalesOrderGUI.NewTransBusObjinstance;
begin
  Freeandnil(SalesOrder);
  SalesOrder := TSalesOrder.Create(Self);
  SalesOrder.Name:= 'SalesOrderObj';
  SalesOrder.DoProductallocation := DoProductallocation;
  SaleBase := SalesOrder;
  inherited;
end;

procedure TSalesOrderGUI.initConvertingFromRef(Sender:TObject);
begin
  if not(Sender is TsalesOrderConvertedsalesListGUI) then exit;
  TsalesOrderConvertedsalesListGUI(Sender).ConvertingFromRef:= Salesorder.Globalref;
    TsalesOrderConvertedsalesListGUI(Sender).ConvertingFromId := SalesOrder.ID;
end;

Function  TSalesOrderGUI.IsOktoconvert(Sender: TObject; CopyTo: TBusobjClass) :Boolean;
var
    strMessage:String;
begin
    REsult := False;

    if LineEmpty then Exit;

    if  ((Sysutils.SameText(Copyto.classname , 'TInvoice'))  and (Isformvisible('TInvoiceGUI')))  or
        ((Sysutils.SameText(Copyto.classname , 'TCashSale')) and (Isformvisible('TCashSaleGUI'))) then begin
            CommonLib.MessageDlgXP_Vista('The ' + CopyTo.XMLNodename + ' form is already opened.' +
                                        ' Please Save/cancel the opened ' + CopyTo.XMLNodename +
                                        ' record before converting the Sales Oder' , mtWarning, [mbOk] , 0);
            Exit;
        end;
    firstSOID := Salesorder.Id;
    if SalesOrder.IsBo then
        firstSOID := SalesOrder.GetBackOrderMainSOId;
    if  (Sysutils.SameText(Copyto.classname , 'TInvoice'))    or
        (Sysutils.SameText(Copyto.classname , 'TCashSale'))  then begin
        if SalesOrder.HasalreadyConvertedBinBatchSRProduct(firstSOID) then begin
            CommonLib.MessageDlgXP_Vista('This Sales Order or one of its Back Orders has either Bins, Baches or Serial Numbers allocated to it and has already been converted.' + chr(13) + chr(13) +'It is not possible to convert this Sales Order again.', mtWarning, [mbOk] , 0);
            Exit;
        end;
    end;
    fsinvoicingErrMsg :='';
    if not SaveSalesRecord then exit;
    //CommitAndNotify;
    CommitTransaction;

    try
      if AnyProcessScheduled then strMessage := 'Process(s) are already started in this Sales Order.'+NL +
        'Are you sure you want to Complete and Invoice this Sales Order to ' + copyTo.XMLNodeName
      else
        strMessage:=  'Are you sure you want to convert this Sales Order to ' + copyTo.XMLNodeName ;

      if  ((Sysutils.SameText(Copyto.classname , 'TInvoice')) or (Sysutils.SameText(Copyto.classname , 'TCashSale'))) then
          if SalesOrder.IsBo then begin
              StrMessage := 'This is a Back Order, will convert the Sales order and all its back orders.' +chr(13) + strMessage ;
          end else if salesorder.Backorderglobalref <> '' then
              StrMessage := 'This will convert the Sales order and all its back orders.' +chr(13) + strMessage ;

      if FormStillOpen('TfrmCustomer') then begin
          TfrmCustomer(FindExistingComponent('TfrmCustomer')).closeme;
          Application.ProcessMessages;
      end;

      if SalesOrder.converted then
          strMessage := 'This Sales order is already being converted.' + chr(13)+  strMessage + ' again ?'
      else strMessage := strMessage +'?';

      if (Sysutils.SameText(Copyto.classname , 'TInvoice')) then
          if (AppEnv.CompanyPrefs.CombinedSaleOrderBO) then
              strMessage := 'You have the preference selected to combine all the Sales Order''s BOs ' +
                      'of the client. So converting the Sales Order will not convert the Backorder.' + chr(13) + strMessage;
      if not fbNoConvertQuestion then
          if (CommonLib.MessageDlgXP_Vista(strMessage , mtConfirmation , [mbYes,mbno] , 0) = mrno) then Exit;

      if (Sysutils.SameText(Copyto.classname , 'TInvoice')) then
          if not jobCreated then Exit;

      GlobalEvents.Notify(Sender, GEVENT_OnExecute);
      Salesorder.Lines.First;
      REsult := true;
    finally
      self.BeginTransaction;
    end;
end;



Function TSalesOrderGUI.ToBeApprovedNApproved:Boolean;
begin
    (*if  (Appenv.Companyprefs.StatustoMakeInvoice<> '') then
      if not (SameText(Appenv.Companyprefs.StatustoMakeInvoice ,SalesOrder.SalesStatus)) then begin
          MessageDlgXP_Vista('Sales Order can be Converted to Invoice Only When Status is ' + Quotedstr(Appenv.Companyprefs.StatustoMakeInvoice)+'.', mtWarning , [mbok], 0) ;
          SetcontrolFocus(cboCurrentTransStatus);
          REsult := False;
          Exit;
      end;*)
  Result := true;

  (* Result := true;
  if Appenv.CompanyPrefs.enableQuoteVariation then
        if SalesOrder.SalesStatus <> 'Approved' then begin
          MessageDlgXP_Vista('Sales Order can be Converted Only After Approval(Status).', mtWarning , [mbok], 0) ;
          REsult := False;
        end; *)
end;

procedure TSalesOrderGUI.txtShipToEnter(Sender: TObject);
begin
  inherited;
  self.SavedAccessLevel:= AccessLevel;
  self.SalesOrder.AccessManager.AccessLevel := 1;
end;

procedure TSalesOrderGUI.txtShipToExit(Sender: TObject);
begin
  inherited;
  if Accesslevel = SavedAccessLevel then Exit;
  if Assigned(SalesOrder) then begin
    SalesOrder.postDB;
    if (btnCompleted.enabled = False) and (SalesOrder.dirty) then btnCompleted.enabled := true;
    SalesOrder.AccessManager.AccessLevel := SavedAccessLevel;
    if SalesOrder.AccessManager.AccessLevel=1 then SalesOrder.EditDB;
  end else if tblmaster.state in [dsedit,dsInsert] then
    tblMaster.Post;
  AccessLevel := SavedAccessLevel;
end;

procedure TSalesOrderGUI.actInvoiceExecute(Sender: TObject);
var
    inewId :Integer;
    oldAccessLevel :Integer;
    MsgObj: TMsgObj;
    x: integer;
  LExtID: string;
  LIntID: integer;
  LStatus: string;
begin
  if Salesorder.Anylinehastree then begin
      MessageDlgXP_vista('This Order has BOM Product(s). It is not possible to convert to Invoice. Please do a ''finalize'' build', mtWarning, [mbOK], 0);
      Exit;
  end;

  if SalesOrder.Customer.StopCredit and AppEnv.CompanyPrefs.PreventInvoiceOnStopCredit then begin
      MessageDlgXP_Vista('This Customer is on Stop Credit so it is not possible to convert this Sales Order to an Invoice for this customer.', mtWarning, [mbOK], 0);
    exit;
  end;

  if not SOHasLines('Copy to Invoice') then exit;
  if not IsaSavedSO('Copy to Invoice') then exit;

  //if not HasToAndIsApproved then exit;

  if not SalesOrder.CanLockAllManifest then exit;

  if (Appenv.CompanyPrefs.ConvertConvertedSalesOrder = False) and ( SalesOrder.converted) then begin
(*    if MessageDlgXP_Vista('This Sales Order is already converted.'+NL+NL+
                      'It is not possible to Copy to Invoice Again as  '+NL+'"Allow Conversion of a Converted Sales Order" '+NL+'is Turned Off in the Preference.' , mtWarning, [], 0 , nil, '', '' , false, nil, 'Open Preference,Cancel') = 100 then
                      OpenPrefform('Sales' ,  'chkConvertConvertedSalesOrder' , AppEnv.AccessLevels.GetEmployeeAccessLevel('TPreferencesGUI') , true , '' , '' ,'');*)
    MessageDlgXP_VistaWithPrefoption('This Sales Order is already converted.'+NL+NL+
                      'It is not possible to Copy to Invoice Again as  '+NL+'"Allow Conversion of a Converted Sales Order" '+NL+'is Turned Off in the Preference.' , mtWarning, [], 0 ,
                      PrefOptionObj( 'Sales' ,  'chkConvertConvertedSalesOrder' , AppEnv.AccessLevels.GetEmployeeAccessLevel('TPreferencesGUI') , true , '' , '' ,''),
                      nil, '', '' , false, nil);

    Exit;
  end;


  if (Appenv.CompanyPrefs.ConvertConvertedSalesOrder ) and (Salesorder.Converted) then
  else if not HasAccess('Copy to Invoice', true, 3) then exit;

  if not HasAccesstoInvoice('Copy to Invoice') then exit;
  if SalesOrder.IsInternalOrder then begin
    MessageDlgXP_Vista('It is an internal Sales Order. It is not possible to Copy to Invoice', mtWarning, [mbOk], 0);
    Exit;
  end;

  if IsSoLayby('Copy to Invoice') then exit;
  if not SoHasnoProcess('Copy to Invoice') then exit;


  if not ToBeApprovedNApproved then Exit;

  DisableForm;
  try
    iNEwID:= 0;

    if not IsOktoconvert(Sender , TInvoice) then Exit;

    OldAccessLevel := AccessLevel;
    Try
        AccessLevel := 1;
        lblProcessMessage.Caption := 'Converting Sales order.';
        lblProcessMessage.Visible := True;
        Try
            SalesOrder.Connection.BeginTransaction;
            try
              tbldetails.disablecontrols;
              tblmaster.disablecontrols;
              try
                //iNewId := SalesOrder.CopySalesOrderToInvoice(FirstSOId) ;
                ShowProgressbar('Converting SO to Invoice' , SalesOrder.TotalLinesingroup);
                try
                  iNewId := SalesOrder.CopyToInvoice(FirstSOId) ;
                  LIntID := FirstSOId;
                  if TExternalXRef.Exists('Coles', 'ORDRSP', LExtID, LIntID, LStatus) and (LStatus = 'Done') then
                  with TExternalXRef.NewInstance(nil) do
                  try
                    New;
                    ExternalType := 'Coles';
                    ObjectType := 'INVOIC';
                    ExternalID := LExtID;
                    ERPID := iNewId;
                    PostDB;
                  finally
                    Free;
                  end;
                  //SalesOrder.DocNumber := LExtID;
                Finally
                    HideProgressbar;
                end;
                if iNEwID > 0 then begin
                    NewAuditTrialentry('Invoice Created');
                    SalesOrder.dirty:= False;
                    SalesOrder.connection.CommitTransaction;
                    DEtachAll;
                    Notify;
                    If AppEnv.CompanyPrefs.LeaveOpenOnCopyToINV then
                        Postmessage(Self.handle, SX_OpenInv, iNewID,0);
                    if Sender = nil then begin
                        MsgObj := TMsgObj.Create;
                        MsgObj.ClassStr := 'TBarcodeProcessQueries';
                        MsgObj.MethodStr := 'SaveNewInvoiceID';
                        MsgObj.IntValue := iNewId;
                        MsgObj.StrValue := IntToStr(KeyID);
                        FMsgHandler.Send(MsgObj);
                    end;
                end else   begin
                  if not SalesOrder.ResultStatus.OperationOk then begin
                    for x := 0 to SalesOrder.ResultStatus.Count - 1 do begin
                      if not TResultStatusItem(SalesOrder.ResultStatus.Items[x]).OperationOk then begin
                        if fsinvoicingErrMsg <> '' then fsinvoicingErrMsg := fsinvoicingErrMsg + #13#10;
                        fsinvoicingErrMsg := fsinvoicingErrMsg + TResultStatusItem(SalesOrder.ResultStatus.Items[x]).Message;
                      end;
                    end;
                  end;
                    if fsinvoicingErrMsg <> '' then
                        fsinvoicingErrMsg  := 'Conversion of SalesOrder to Invoice is cancelled  because '
                                              + chr(13) +fsinvoicingErrMsg
                    else fsinvoicingErrMsg := 'Conversion of SalesOrder to Invoice is Cancelled';
                    CommonLib.MessageDlgXP_Vista(fsinvoicingErrMsg, mtWarning, [mbOk] , 0);
                end;
              finally
                  tbldetails.enablecontrols;
                  tblmaster.enablecontrols;
              end;
            except
                on e:Exception do begin
                    SalesOrder.Connection.RollbackTransaction;
                end;
            end;
        finally
            lblProcessMessage.Visible := False;
        end;
    Finally
        AccessLevel := oldAccessLevel;
        if iNEwID > 0 then begin

          Self.close;
        end;
    end;
  finally
    EnableForm;
  end;
end;
(*procedure TSalesOrderGUI.SearchLinesForBOMEntries(IdListManufacture , IDListFromStock:TIntegerList);
begin
  with TERPQuery(salesorder.getnewdataset('Select  distinct SL.sAleLineID ' +
            ' from tblSaleslines SL ' +
            ' inner join tblprocTree PT on SL.SaleLineId	= PT.masterID and 	PT.Mastertype <> "mtProduct" ' +
            ' where SL.SaleId = ' +IntToStr(salesOrder.ID))) do try
    IdListManufacture.commatext := Groupconcat('sAleLineID');
  finally
    closenFree;
  end;

  with TERPQuery(salesorder.getnewdataset('Select  distinct SL.sAleLineID ' +
            ' from tblSaleslines SL ' +
            ' Left join tblprocTree PT on SL.SaleLineId	= PT.masterID and 	PT.Mastertype <> "mtProduct" ' +
            ' where SL.SaleId = ' +IntToStr(salesOrder.ID)+' and  ifnull(PT.proctreeId,0)=0' )) do try
    IDListFromStock.commatext := Groupconcat('sAleLineID');
  finally
    closenFree;
  end;

end;*)
procedure TSalesOrderGUI.actcomplnInvoiceExecute(Sender: TObject);
var
  Msg:TStringlist;
  iNEwID:Integer;
  OldAccessLevel:Integer;
  fSalesRelatedObj:TSalesRelated;
  Function SalesRelatedObj: TSalesRelated;
  begin
    fSalesRelatedObj:= TSalesRelated.Create(Self);
    REsult := fSalesRelatedObj;
  end;
begin
  inherited;
  if not IsaSavedSO('Complete n Invoice') then exit;
  if AnyProcessScheduled=False then if not HasAccess('Complete n Invoice', true, 3) then exit;
  if not HasAccesstoInvoice('Complete n Invoice') then exit;
  if IsSOConverted('Complete n Invoice') then exit;
//  if IsRepairSO('Complete n Invoice') then exit;
  if IsSoLayby('Complete n Invoice') then exit;

  if not ToBeApprovedNApproved then Exit;

  DisableForm;
  try
    iNEwID:= 0;
    if not IsOktoconvert(Sender , TInvoice) then Exit;
    OldAccessLevel := AccessLevel;
    Try
        AccessLevel := 1;
        lblProcessMessage.Caption := 'Converting Sales order.';
        lblProcessMessage.Visible := True;
        Try
          //if MessageDlgXP_Vista('Do you like to Complete and Convert this ',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
          tbldetails.disablecontrols;
          tblmaster.disablecontrols;
          try
              Msg:=TStringlist.Create;
              try
                try
                    if docompletenconvert(SalesRelatedObj.DoConfirmQtysOnfinalise , SalesOrder,True , Msg ,iNEwID, true) then begin
                        if iNEwID > 0 then begin
                            NewAuditTrialentry('Invoice Created');
                            SalesOrder.dirty:= False;
                            SalesOrder.connection.CommitTransaction;
                            DEtachAll;
                            Notify;
                            If AppEnv.CompanyPrefs.LeaveOpenOnCopyToINV then Postmessage(Self.handle, SX_OpenInv, iNewID,0);
                        end else   begin
                            if Msg.count>0 then
                              CommonLib.MessageDlgXP_Vista('Conversion of SalesOrder to Invoice is cancelled  because '+NL+Msg.Text, mtWarning, [mbOk] , 0);
                        end;
                    end;
                finally
                  FreeandNil(fSalesRelatedObj);
                end;
              finally
                Freeandnil(Msg);
              end;
          finally
                  tbldetails.enablecontrols;
                  tblmaster.enablecontrols;
          end;
        finally
          lblProcessMessage.Visible := False;
        end;
    Finally

        AccessLevel := oldAccessLevel;
        if iNEwID > 0 then begin

          Self.close;
        end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TSalesOrderGUI.actcomplnInvoiceUpdate(Sender: TObject);
begin
  inherited;
  if not(HasProcess) then begin
    actcomplnInvoice.visible:= false;
    actInvoice.visible := TRue;
    Exit;
  end;

  actInvoice.visible := False;
  TAction(Sender).visible:= True;
  TAction(Sender).Enabled := TAction(Sender).visible;
end;

procedure TSalesOrderGUI.actConCashExecute(Sender: TObject);
var
  iNewID: Integer;
  CashSaleGUI: TCashSaleGUI;
begin
  if not SOHasLines('Copy To Cash Sale') then exit;
  if not IsaSavedSO('Copy To Cash Sale') then exit;
  if not HasAccess('Copy To Cash Sale',  True, 3) then exit;

  if not IsOktoconvert(Sender , TCashSale) then Exit;

  if grdTransactions.SelectedList.Count > 0 then
    SalesOrder.LineIdToconvert(SelectedLineIds);

  iNewId := SalesOrder.CopyToInvoice(FirstSOId,true) ;

  {open the form unconditionally as the Paymethod is blank when converted}
  if iNewID > 0 then begin
    SalesOrder.connection.CommitTransaction;
    NewAuditTrialentry('Cash Sale Created');
      CashSaleGUI := TCashSaleGUI(GetComponentByClassName('TCashSaleGUI'));
      if Assigned(CashSaleGUI) then begin
          CashSaleGUI.KeyID := iNewID;
          CashSaleGUI.FormStyle := fsMDIChild;
          CashSaleGUI.BringToFront;
          CashSaleGUI.CashSale.dirty := True; // this is to enforce the Save  and so validation for the paymethod
          DEtachAll;
          Self.Close;
      end;
  end;

end;

procedure TSalesOrderGUI.actConSmartExecute(Sender: TObject);
begin
  inherited;
(*var
  iSavedAccessLevel:integer;
  SOID: Integer;
  qry: TERPQuery;
  ID: integer;
begin
  fbPOshown := False;
  try
    if not SOHasLines('Copy To Smart Order') then exit;

    if  (KeyID = 0) then begin
      MessageDlgXP_Vista('Please Save the Sales Order before Creating the Smart Order for it', mtWarning, [mbOK], 0);
      exit;
    end else if  (Accesslevel >3) then begin
      MessageDlgXP_Vista('You don''t have enough Access to Create the Smart Order for this Sales Order', mtWarning, [mbOK], 0);
      exit;
    end else if (AppEnv.CompanyPrefs.DisableCopyToSmartwhenSOCreate and tblMaster.FieldByName('POCreated').AsBoolean) then begin
      if MessageDlgXP_Vista('A Smart Order is already Created for this Sales Order, do you wish to view the Smart Order?', mtInformation, [mbYes,mbNo], 0) = mrYes then begin
        qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
        try
          qry.SQL.Add('select SmartOrderID from tblsmartorder where GlobalRef = ' + QuotedStr(tblMasterAutoSmartOrderRef.AsString));
          qry.Open;
          ID := qry.FieldByName('SmartOrderID').AsInteger;
        finally
          qry.Free;
        end;
        if ID > 0 then
          OpenERPForm('TSmartOrderGUI',ID);
      end;
      if Sysutils.SameText(btnConSmart.Caption,'SM/O Created') then btnConSmart.Caption := 'SM/O Created';
      Exit;
    end;


    DisableForm;
    iSavedAccessLevel := Self.AccessManager.AccessLevel;
    Self.AccessManager.AccessLevel := 1;
    try
      if not SalesOrder.LineHasInvProduct(SalesOrder.ID) then begin
        CommonLib.MessageDlgXP_Vista('Smart Order Cannot be created for Sales Order #' +inttostr(SalesOrder.ID) +' as it Doesn''t Have Any Inventory Products.' , mtInformation, [mbOk] , 0);
        Exit;
      end;
      if not ConfirmForPOcost then exit;

      if not IsOkToCopyToSMart then exit;
      if not IsOktoconvert(sender , TSmartOrder) then Exit;
      lblProcessMessage.Visible := True;
      SalesOrder.LineIdToconvert (SelectedLineIds);
      try
          SalesOrder.Connection.CommitTransaction;
          SOID := SalesOrder.CopySalesOrderToSmartOrder;
      finally
        SalesOrder.CleanLineIdsToconvert;
        lblProcessMessage.Visible := False;
      end;
      if SOID <> 0 then begin
        if not fbPOshown then begin
          NewAuditTrialentry('Smart Order Created');
          OpenERPForm('TSmartOrderGUI' , SOID);
        end;
        Self.close;
      end else begin
          SalesOrder.Connection.beginTransaction;
      end;

    finally
      Self.AccessManager.AccessLevel := iSavedAccessLevel;
      EnableForm;
    end;
  finally
    fbPOshown := False;
  end;*)
end;

Procedure TSalesOrderGUI.DoOnClientchange;
begin
  if (Empty(cboClientR.text)) or (SalesOrder.CustomerID =0) then Exit;

  try
    if cboClientR.LookupTable.FieldByName('company').asString <> cboClientR.Text then
      cboClientR.LookupTable.locate('company', cboClientR.Text , []);
  Except
    // kill the exception
  end;

  cboShipDate.date := now;
  inherited;
  Salesorder.ShipDate:= IncDay(SAlesorder.SaleDate, AppEnv.CompanyPrefs.ShippedDaysAfterCreate);
  if cboViaQry.Active and (cboVia.LookupValue = '') then begin
    cboViaQry.Locate('ShippingMethod', 'Client Arranged', [loCaseInsensitive]);
    cboVia.LookupValue := 'Client Arranged';
  end;
  cboDueDateExit(cboClientR);
  btnPickUpFrom.Enabled := True;
  RefreshProductQry;
end;


function TSalesOrderGUI.GetReportTypeID: Integer;
begin
  Result := 25;
end;

procedure TSalesOrderGUI.actPreviewExecute(Sender: TObject);
var
  IsOK: Boolean;
begin
  if not SaveSalesRecord then Exit;

  if ((SalesOrder.TotalBalance - SalesOrder.TotalProgressPayments - SalesOrder.TotalPrePayments)  > 0) and (not EmployeeHasAccess('FnAllowSOPrintWithNonZeroBalance')) then begin
    CommonLib.MessageDlgXP_Vista('You do not have Access to Preview/Print Sales Orders with an Outstanding Balance.', mtWarning, [mbOK], 0);
    exit;
  end;

  DisableForm;
  try


    fbReportSQLSupplied :=   False;
    fbReportSQLSupplied := False;
    IsOK_to_Print(IsOK);
    if IsOK then
    begin
      if tblMaster.FieldByName('HoldSale').AsString = 'T' then
      begin
        if chkChooseRpt.checked = False then  ReportToPrint := 'Sales Order Held';
      end;
      Self.CommitAndNotify;
      try
        inherited;
//        closeAfterPrint;
      except
        on E:Exception do begin
            commonlib.MessageDlgXP_Vista('Print failed.' +CHR(13) +CHR(13) + E.Message , mtWarning, [mbok] , 0);
        end;
      end;
      end;
  finally
    self.BeginTransaction;
    EnableForm;
  end;
end;

procedure TSalesOrderGUI.actPrintExecute(Sender: TObject);
var
  IsOK: Boolean;
begin
  if ((SalesOrder.TotalBalance - SalesOrder.TotalProgressPayments - SalesOrder.TotalPrePayments) > 0) and (not EmployeeHasAccess('FnAllowSOPrintWithNonZeroBalance')) then begin
    CommonLib.MessageDlgXP_Vista('You do not have Access to Print Sales Orders with an Outstanding Balance.', mtWarning, [mbOK], 0);
    exit;
  end;
  ReportToPrint := '';
  DisableForm;
  try
    if not SaveSalesRecord then
      exit;
    fbReportSQLSupplied :=   False;
    IsOK_to_Print(IsOK);
    if IsOK then    begin
      if (tblMaster.FieldByName('HoldSale').AsString = 'T')  then begin
        if chkChooseRpt.checked = False then  ReportToPrint := 'Sales Order Held';
      end;
      Self.CommitAndNotify;
      try
        inherited;
      except
        on E:Exception do begin
            commonlib.MessageDlgXP_Vista('Print failed.' +CHR(13) +CHR(13) + E.Message , mtWarning, [mbok] , 0);
        end;
      end;
//      closeAfterPrint;
    end;
  finally
    self.BeginTransaction;
    EnableForm;
  end;
end;

procedure TSalesOrderGUI.actPartialInvoiceExecute(Sender: TObject);
begin
  inherited;
  try
    Salesorder.PostDB;
    Salesorder.Lines.postDB;
  Except
  end;
  if (Salesorder.lines.count=0) then  begin
      MessageDlgXP_vista('Please select product(s).', mtWarning, [mbOK], 0);
      Exit;
  end;
  if (Salesorder.converted) then  begin
      MessageDlgXP_vista('This Sales Order is already converted.', mtWarning, [mbOK], 0);
      Exit;
  end;

  if (Salesorder.Lines.AnyLineShipped =False) then begin
      MessageDlgXP_vista('This is a backorder', mtWarning, [mbOK], 0);
      Exit;
  end;

  if Salesorder.AnyLineHasTree = False then begin
      MessageDlgXP_vista('The Order has no BOM Product', mtWarning, [mbOK], 0);
      Exit;
  end;
  if MessageDlg('This will save and close this Sales Order to Make a Partial Shipment of it. Do you wish to continue?', mtConfirmation, [mbYes, mbNo], 0) = mryes then
    if SaveSalesRecord then begin
      CommitTransaction;
      OpenERPForm('TfmSalesorderInvoice' , 0 , nil,initSalesorderInvoice);
      Self.Close;
    end;

end;
procedure TSalesOrderGUI.initSalesorderInvoice(Sender: TObject);
begin
  if not(Sender is   TfmSalesorderInvoice) then exit;
  TfmSalesorderInvoice(Sender).saleID     := SalesOrder.ID;
  TfmSalesorderInvoice(Sender).SaleLineID := SalesOrder.Lines.ID;
end;

procedure TSalesOrderGUI.actPickExecute(Sender: TObject);
var
  IsOK: Boolean;
begin
  DisableForm;
  try
    if not SaveSalesRecord then
      exit;

    IsOK_to_Print(IsOK);

    if IsOK then
    begin
      if AppEnv.CompanyPrefs.EmailWhenPrintingPickingSlip then
      begin
        lblEmailMsg.Caption := 'Emailing, ' + WAITMSG;
        lblEmail.Visible := True;
        lblEmailMsg.Refresh;
        SetButtonState(False);

        try
          try
            TCorrespondenceGui.EmailCustomerSale(
              AppEnv.CompanyPrefs.PickingSlipEmailRecipient, GetSalesEmails,
              'Sales Order Company: ' + SalesOrder.Customername + ' - Sales Order #: ' + SalesOrder.DocNumber,
              'This email has been sent to you from ' + GetCompanyName,
              self.SalesOrder.CustomerID);
          finally
            SetButtonState(True);
            lblEmail.Visible := False;
          end;
        except
          CommonLib.MessageDlgXP_Vista('There was an error sending email', mtInformation, [mbOK], 0);
        end;
      end;
      Self.CommitAndNotify;
      try
        inherited;
        PrintSalesPickingSlip;
      finally
        self.BeginTransaction;
      end;

    end;
  finally
    EnableForm;
  end;
end;

procedure TSalesOrderGUI.tblMasterAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if tblMasterConverted.AsBoolean then WasConvertedTrans := True;
end;
Procedure TSalesOrderGUI.EnableComplete;
begin

  actfinalizeBuild.Visible:= Salesorder.AnyLineHasTree;
  actConComplete.Visible:= not(Salesorder.AnyLineHasTree);
  if actfinalizeBuild.Enabled then actfinalizeBuild.Enabled := KeyID<>0;
  if actConComplete.Enabled   then actConComplete.Enabled   := KeyID<>0;
  if Salesorder.Converted then actConComplete.Caption :=  'Un-Convert'
  else actConComplete.Caption :=  'Co&mplt no Invc';

end;
procedure TSalesOrderGUI.tblMasterCalcFields(DataSet: TDataSet);
(*var
  qry: TERPQuery;
  SeqNo: string;*)
begin
  inherited;


  if (Dataset.State = dsCalcFields) and (KeyId > 0) then begin
    tblMasterTotalProgressPayments.asFloat := SalesOrder.TotalProgressPayments + SalesOrder.TotalPrepayments;
    tblMAsterBalanceAmount.asFloat := SalesOrder.TotalAmountinc-tblMasterTotalProgressPayments.asFloat (*(SalesOrder.TotalProgressPayments + SalesOrder.TotalPrepayments)*);


    (*SeqNo := '';
    qry := DbSharedObj.GetQuery(MyConnection);
    try
      qry.SQL.Add('select Count( * )  as SeqNo from tblsales where OriginalNo = ' + QuotedStr(SalesOrder.OriginalDocNumber));
      qry.SQL.Add('and SaleID <= ' + IntToStr(SalesOrder.ID));
      qry.Open;
      if qry.FieldByName('SeqNo').AsInteger > 1 then
        SeqNo := IntToStr(qry.FieldByName('SeqNo').AsInteger -1);
    finally
      DbSharedObj.ReleaseObj(qry);
    end;

    if SeqNo <> '' then
        DataSet.FieldByName('SaleNum_Seq').AsString  := Trim(DataSet.FieldByName('OriginalSaleId').AsString) + '-' + SeqNo
    else
      DataSet.FieldByName('SaleNum_Seq').AsString := '';


    edt_SaleNum_Seq.Visible := SeqNo <> '';
//    if edt_SaleNum_Seq.Visible then
//      edt_SaleNum_Seq.Caption := DataSet.FieldByName('SaleNum_Seq').AsString;*)

  end;
end;

procedure TSalesOrderGUI.EmailSalesOrder;
var
  ASilent, ASecret:Boolean;
begin
  ReporttoPrint :='';
  try
    if not EmailShortSendMode(ASilent, ASecret) then exit;
    Emailtransaction('' , ASilent, ASecret);
  finally
    REporttoPrint  :='';
  end;
end;

procedure TSalesOrderGUI.EmailSalesOrderSilent;
begin
  EmailTransaction('', true, true);
end;

function TSalesOrderGUI.EmailTransaction(const RecipientAddress :String ='';ASilent: boolean=True; ASecret : boolean=True): boolean;
var
  ReportType, OutGoingFileName: string;
  EmailDate: TDateTime;
  qryEmailedList: TERPQuery;
  TransactionID, UserID, TransactionDescription: string;
  intResult: Integer;
  strResult: string;
  ReportAttachmentfiles:String;
  Corres: TCorrespondenceGui;
  Recipients : string;
begin
  result := false;
  ReportToPrint := '';
  DisableForm;
  try

    if not self.SaveSalesRecord then Exit;
    Self.CommitAndNotify;
    Corres := TCorrespondenceGui.Create;
    try

      // Clear all previous params/data
      //RecipientAddress  := '';
      ReportType        := '';
      OutGoingFileName  := '';

      Recipients := GetContactEmails(tblMaster.FieldByName('ClientID').AsInteger, 'MainContactForSalesOrder');

      if RecipientAddress <> '' then
        Recipients := AddEmailToList(RecipientAddress, RecipientAddress);

      if Recipients = '' then
        if AppEnv.CompanyPrefs.UseDefaultMailClient then begin
          if CommonLib.MessageDlgXP_Vista(SalesOrder.CustomerName + ' does not have an email address.' + #13 + #10 +
            'Do you wish to load the email program anyway?',mtConfirmation, [mbYes,mbNo], 0) = mrNo then exit;
        end else begin
          if CommonLib.MessageDlgXP_Vista(SalesOrder.CustomerName +
          ' does not have an email address to send to.' + #13 + #10 + #13 + #10 +
          'Do you wish to load the email program anyway?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
        end;

      ReportType := 'Sales Order';
      // String defined here because it is easy to change when this code is applied to
      // other forms. (ie, Quote instead of Invoice etc)

      // Ask the user if they want to specify a new subject
      intResult := CommonLib.MessageDlgXP_Vista('You are about to Email this ' + ReportType + ' to '
        + SalesOrder.customer.printname  + '.' + #13 + #10 + #13 +
        #10 + 'Would you like to specify a subject for this email?' + #13 + #10 + #13
        + #10 +'Please select Yes to enter new email subject line. No to use standard subject line.',
          mtConfirmation, [mbYes, mbNo, mbCancel], 0);
      if intresult = mrcancel then exit;

      if intResult = mrYes then begin
        strResult := InputBox('SUBJECT DECLARATION',
          'Please specify subject for this email', ReportType + ' #' + Salesorder.DocNumber+' for ' + SalesOrder.customer.printname);
      end else if intResult = mrNo then
        strResult := ReportType + ' #' + SalesOrder.DocNumber + ' for ' + SalesOrder.customer.printname;

//      Corres.RecipientList := RecipientAddress;
      Corres.RecipientList := Recipients;
      Corres.CCList := GetSalesEmails;
      try
        lblEmailMsg.Caption := 'Emailing, ' + WAITMSG;
        lblEmailMsg.Refresh;
        lblEmail.Visible := True;

        // TURN OFF BUTTONS WHILE EMAIL IS BEING SENT
        SetButtonState(False);

        LoadTemplate(True, True);

        Corres.Subject := strResult;

        Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;

        OutGoingFileName := //GetCompanyName + ' ' + ReportType + ' #' + SalesOrder.DocNumber + '.PDF';
                            getOutGoingFileName('',' ' + ReportType + ' #' + SalesOrder.DocNumber, '.PDF');

        if not FileExists( Commonlib.TempDir  + OutGoingFileName) then
        begin
          CopyFile(PChar( Commonlib.TempDir  + 'EmailReport.PDF'),
                   PChar( Commonlib.TempDir  + OutGoingFileName), False);
        end;

        Corres.CustomerId := SalesOrder.CustomerID;
        Corres.AttachmentList.Add(Commonlib.TempDir + OutGoingFileName);
        ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres , GetTemplate(ReportToPrint));
        try
          Result := false;

          result := Corres.Execute(ASilent, ASecret);
        finally
          DeleteFiles( Commonlib.TempDir , '*.PDF');
          DeleteMultipleFiles(Commonlib.TempDir , ReportAttachmentfiles);
        end;
        lblEmail.Visible := False;

        // TURN ON BUTTONS AFTER EMAIL HAS BEEN SENT
        SetButtonState(True);

        /////////////////////////

        TransactionID := SalesOrder.DocNumber;
        UserID := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
        EmailDate := Now;

        // ReportType already defined at start of procedure
        TransactionDescription := GetCompanyName + ' ' + ReportType + ' #' +
          SalesOrder.DocNumber + ' for ' +
          SalesOrder.Customername;

        qryEmailedList := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);

        try
          qryEmailedList.Sql.Clear;
          qryEmailedList.Sql.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports (TransactionID, UserID, Date, ReportType,' +
          'TransactionDescription,ContactID,EmailAddressUsed ) Values ("' + TransactionID + '","' + UserID + '", "' +
          FormatDateTime(MysqlDateFormat, EmailDate) + '", "' + ReportType + '", "' + TransactionDescription +
          '", "' + IntToStr(EmailContactID) +  '", "' + RecipientAddress + '")');

          qryEmailedList.Execute;
        finally
          DeleteFiles( Commonlib.TempDir , '*.PDF');
          DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryEmailedList);
          ReportToPrint := '';
        end;
      except
        lblEmail.Visible := False;
        CommonLib.MessageDlgXP_Vista('There was an error sending email', mtWarning, [mbOK], 0);

        // TURN ON BUTTONS AFTER EMAIL HAS BEEN SENT
        SetButtonState(True);
      end;
    finally
      Corres.Free;
      LogEmailed(result , ReportType);
    end;
  finally
    self.BeginTransaction;
    EnableForm;
  end;
end;


Function  TSalesOrderGUI.Save4NewTrans:Boolean;
begin
  Result := False;
  DisableForm;
  try
    // If user does not have access to this form don't process any further
    if ErrorOccurred then exit;

    if SalesOrder.Dirty then begin
      case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes,mbNo,mbCancel], 0) of
        mrYes :    begin
                     if SaveSalesRecord then begin
                       CommitAndNotify;
                       Result := True;
                     end;
                   end;
        mrNo  :    begin
                     // Cancel edits and Rollback changes
                     RollbackTransaction;
                     Result := True;
                   end;
        mrCancel : begin
                     exit;
                   end;
      end;
    end else begin
      REsult := True;
    end;
  finally
    EnableForm;
  end;
end;

procedure TSalesOrderGUI.IsOK_to_Print(var IsOk: Boolean);
begin
  IsOk := False;
  if (Accesslevel = 5) then
  begin
    IsOk := True;
    Exit;
  end;
  inherited;
  if IsOkToSaveSale() then
  begin
    if IsOkToSave() then
    begin
      IsOk := True;
    end;
  end;
end;

function TSalesOrderGUI.IstransLineLocked: Boolean;
begin
  REsult :=inherited IstransLineLocked;
(*  if result then exit; // the line is already readonly
  if SalesOrder.Lines.BOMGroupedLine then begin
    result := True;
    LineLockMsg := Quotedstr(SalesOrder.Lines.LineDescription)+ ' is already grouped in the production';
  end;

  if SalesOrder.Lines.BOMGroupedLine or Salesorder.Lines.BOMProductionLine then begin
    result := True;
    LineLockMsg := Quotedstr(SalesOrder.Lines.LineDescription)+ ' is a grouped entry in the production';
  end;*)
end;

procedure TSalesOrderGUI.actDelDocketExecute(Sender: TObject);
begin
  if (Appenv.CompanyPrefs.ShowDeliveryDetailsformonDeldocketprint) and (Appenv.Employee.ShowDeliveryDetailsformonDeldocketprint) then
    TfmSalesDeliveryDetails.DoExtrainfoPopup(Self, SalesOrder.SalesDeliveryDetails ,PrintDeldocket)
  else
    PrintDeldocket;
end;

procedure TSalesOrderGUI.actfinalizeBuildExecute(Sender: TObject);
begin
  inherited;
  if FinaliseBuild then Self.close
  else self.BeginTransaction;
end;
(*function TSalesOrderGUI.FinaliseBuild(CloseAfteFinalize:Boolean):Boolean;
var
  SOList:TIntegerList;
  msg:String;
  fbConvertCurrent :Boolean;
begin

    Result := False;
    if Salesorder.Converted then begin
      MessageDlgXP_vista('The Order is already Converted', mtWarning, [mbOK], 0);
      Exit;
    end;


    if not SaveSalesRecord then exit;
    Self.CommitAndNotify;

    try

      if Salesorder.AnyLineHasTree = False then begin
        MessageDlgXP_vista('The Order has no BOM Product', mtWarning, [mbOK], 0);
        Exit;
      end;

      if not SalesOrder.allBuilt then begin
        case MessageDlgXP_Vista('This Order is NOT completely Built. Do You Wish To Finalise and Convert? ', mtConfirmation, [], 0 , nil , '' , '' , False, nil , 'Finalise n Convert,Convert Built Stock,Cancel') of
          100: fbConvertCurrent :=False;
          101: fbConvertCurrent :=true;
          102: exit;
        end;
      end else begin
        fbConvertCurrent := False;
      end;

      SOList:= TIntegerList.create;
      try
          SOList.add(SalesORder.ID);
          BeginTransaction;
          try
              if ProcessDataUtils.CompleteAndConvertOrders(SOList, TERPConnection(SalesORder.Connection.Connection), msg, true , fbConvertCurrent) then begin
                Salesorder.Connection.CommitTransaction;
                MessageDlgXP_Vista('Sales Order #' +inttostr(Salesorder.ID) +' Is Finalised.' , mtInformation, [mbOK], 0);
                result := True;
              end else begin
                Salesorder.Connection.RollbackTransaction;
                if msg <> '' then MessageDlgXP_Vista('Finalising Sales Order #' +inttostr(Salesorder.ID) +' Failed.' + Nl +  msg + Nl+NL+'It is not possible to finalise this build.', mtWarning, [mbOK], 0);
                result := False;
                Exit;
              end;
          finally
            CommitTransaction;
          end;

      finally
          freeandnil(soList);
      end;
    finally
      Self.BeginTransaction;
    end;

end;*)

function TSalesOrderGUI.FinaliseBuild:Boolean;
begin
    Result := False;
    if Salesorder.Converted then begin
      MessageDlgXP_vista('The Order is already Converted', mtWarning, [mbOK], 0);
      Exit;
    end;


  if not SaveSalesRecord then exit;
  Salesorder.Postdb;
  Salesorder.Dirty := False;
  Self.CommitAndNotify;
  try
    if Salesorder.AnyLineHasTree = False then begin
      MessageDlgXP_vista('The Order has no BOM Product', mtWarning, [mbOK], 0);
      Exit;
    end;


    if not SOCompleted then exit;
    Result := True;


    //if CloseAfteFinalize then Self.Close;
  finally
    Self.BeginTransaction;
  end;
end;

Function TSalesOrderGUI.SOCompleted:Boolean;
var
  SOList:TIntegerList;
  msg:String;
  mnu: TMenuItem;
  fSalesRelatedObj:TSalesRelated;
  Function SalesRelatedObj: TSalesRelated;
  begin
    fSalesRelatedObj:= TSalesRelated.Create(Self);
    REsult := fSalesRelatedObj;
  end;
begin
  REsult := True;

  if SalesOrder.Converted then exit;

  try
      mnu := MenuItemByname(TAdvPopupMenu(grdTransactions.popupmenu) , 'Process Tree Hidden');
      if Assigned(mnu) then begin
        BeginTransaction;
        try
          mnu.onClick(mnu);
          if accesslevel <=3 then Salesorder.Postdb
          else Salesorder.canceldb;
         Salesorder.Dirty := False;
         Self.CommitAndNotify;
        Except
          on E:Exception do begin
            CommonLib.MessageDlgXP_Vista('Changing Tree Failed - ' + NL+E.message, mtWarning, [mbOK], 0);
            RollbackTransaction;
            Exit;
          end;
        end;
      end;
  Except
    // kill exception
  end;

  if DofinalisenClose then // no confirmation required
  else if MessageDlgXP_Vista('Do You Wish to Finalise the build for SalesOrder # ' + inttostr(Salesorder.ID) +'?', mtConfirmation, [mbYes, mbNo], 0) = mrno then begin
      REsult:= False;
      Exit;
    end;

  SOList:= TIntegerList.create;
  try
      SOList.add(SalesORder.ID);
      BeginTransaction;
      try
        try
            if ProcessDataUtils.CompleteAndConvertOrders(SalesRelatedObj.DoConfirmQtysOnfinalise, SOList, TERPConnection(SalesORder.Connection.Connection), msg, true) then begin
              CommitTransaction;
            end else begin
              RollbackTransaction;
              if msg <> '' then MessageDlgXP_Vista('Finalising Sales Order #' +inttostr(Salesorder.ID) +' Failed.' + Nl +  msg + Nl+NL+'It is not possible to finalise this build.', mtWarning, [mbOK], 0);
              result := False;
              Exit;
            end;
        finally
          FreeandNil(fSalesRelatedObj);
        end;
      finally
        Salesorder.Postdb;
        Salesorder.Dirty := False;
        CommitTransaction;
      end;

  finally
      freeandnil(soList);
  end;
end;
procedure TSalesOrderGUI.PrintDeldocket;
var
  IsOK: Boolean;
begin
  DisableForm;
  try
    if not SaveSalesRecord then
      exit;
    fbReportSQLSupplied :=   False;

    IsOK_to_Print(IsOK);
    if IsOK then
    begin
      Self.CommitAndNotify;
      try
        inherited actDelDocketExecute(actDelDocket);
        SalesOrder.Printdoc.Printdoc(SalesOrder.ClassName, tblMasterSaleId.AsInteger, dtDelDock, Self.Classname ,PreviewToDocumentOutputType(AppEnv.Employee.ShowPreview) , reportToPrint);
        PrintAddressLabel;
      finally
        self.BeginTransaction;
      end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TSalesOrderGUI.PrintManufacturesummary(Sender: TObject);
var
  REportToPrint:String;
begin
  inherited;
  REportToPrint := '';
  if chkChooseRpt.Checked then begin
    LoadReportTypes(131);
    if dlgReportSelect.Execute then
      ReportToPrint := dlgReportSelect.SelectedItems.Text
    else
      exit;
  end;
  if ReportToPrint  = '' then ReportToPrint := tcdatautils.GetDefaultReport(131);
  if ReportToPrint = '' then exit;
  fbReportSQLSupplied := True;
  try
    PrintTemplateReport(ReportToPrint, companyinfoSQLfortemplate +
                      '~|||~{Details}'+ MainSQL +' where masterId in ( ' + SalesOrder.BOMLineIDs +') group by  PT.proctreeID order by PT.masterID',
                      not(Devmode) and not(Appenv.Employee.ShowPreview), 1);
  finally
    fbReportSQLSupplied:= False;
  end;
  Salesorder.dirty := False;
  Self.Close;


end;

procedure TSalesOrderGUI.qryClientLookupAfterOpen(DataSet: TDataSet);
begin
  inherited;
  //logtext('2:'+cboClientR.Text + '->'+ qryClientLookup.SQLtext(true));
end;

procedure TSalesOrderGUI.qrysalesdeliverydetailsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  lblConverted.Visible := tblMaster.FieldByName('Converted').AsBoolean;
  lblconvertedtoRepairs.visible := SalesOrder.RepairID<> 0;
end;

procedure TSalesOrderGUI.cmdFaxClick(Sender: TObject);
var
  Fax: TFaxObj;
  FaxNo: string;
  Faxed:Boolean;
begin
  Faxed:= False;
  DisableForm;
  try

    if not self.SaveSalesRecord then Exit;
    Self.CommitAndNotify;
    try
      inherited;
      FaxNo := Salesorder.Customer.Faxnumber;

      if Empty(FaxNo) then begin
        CommonLib.MessageDlgXP_Vista(salesorder.CustomerName +
          ' does not have an Fax Number to Send to.' + #13 + #10 + #13 + #10 +
          'Please Review Customer information to Add an Fax Number.', mtWarning,
          [mbOK], 0);
        Exit;
      end;

      lblEmailMSg.Caption := 'Adding to Fax Spool...';
      lblEmail.Visible := True;
      fsFax := True;
      LoadTemplate(True, True, True, 'SO_' + tblMasterGlobalRef.AsString);
      Fax := TFaxObj.Create;
      try
        Fax.AddToFaxSpool(SalesOrder.EmployeeName,SalesOrder.CustomerName,FaxNo, 'Sales Order',
                          SalesOrder.globalref,'',
                          ExtractFilePath(ParamStr(0)) + 'IMG0001.BMP', Now());
        Faxed := True;
      finally
        lblEmail.Visible := False;
        FreeandNil(Fax);
      end;
      DeleteFiles(ExtractFilePath(Paramstr(0)), '*.BMP');
    finally
      LogFaxed(Faxed, ReportToPrint);
      ReportToPrint:= '';
      closeAfterPrint(Faxed);
    end;
  finally
    EnableForm;
  end;
end;

procedure TSalesOrderGUI.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if SalesOrder.IsLayby then begin
       RollbackTransaction;
       SalesOrder.Dirty:= false;
       CanClose:= true;
       Notify(true);
  end;

  // If user does not have access to this form don't process any further
  if ErrorOccurred then exit;

  CanClose:= false;
  if SalesOrder.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes,mbNo,mbCancel], 0) of
      mrYes :    begin
                   if SaveSalesRecord then begin
                     CommitAndNotify;
                     CanClose:= true;
                   end;
                 end;
      mrNo  :    begin
                   // Cancel edits and Rollback changes
                   RollbackTransaction;
                   SalesOrder.Dirty:= false;
                   CanClose:= true;
                   Notify(true);
                 end;
      mrCancel : begin
                   CanClose:= false;
                   btnClose.Enabled := True;
                 end;
      end;
  end
  else begin
    RollbackTransaction;
    CanClose:= true;
    Notify(false);
  end;
  { make sure form is still in transaction if it is not going to close }
  if not CanClose then
    self.BeginTransaction;
end;


procedure TSalesOrderGUI.cboProductQryAfterOpen(DataSet: TDataSet);
begin
  inherited;
  //logtext('1:'+cboProductR.Text + '->'+ cboProductQry.SQLtext(true));
end;

procedure TSalesOrderGUI.cboProductXNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  //
end;

procedure TSalesOrderGUI.tblDetailsUnitofMeasureQtySoldChange(
  Sender: TField);
begin
  inherited;
  //
end;
function TSalesOrderGUI.SaveTransToPDF: boolean;
var
  IsOK: Boolean;
begin
  ReportToPrint := '';
  result := false;
  DisableForm;
  try
    if not SaveSalesRecord then
      exit;
    fbReportSQLSupplied := False;
    fbReportSQLSupplied := False;
    IsOK_to_Print(IsOK);
    if IsOK then
    begin
      if tblMaster.FieldByName('HoldSale').AsString = 'T' then
      begin
        if chkChooseRpt.checked = False then  ReportToPrint := 'Sales Order Held';
      end;
      Self.CommitAndNotify;
      try
        inherited;
        result := true;
//        closeAfterPrint;
      except
        on E:Exception do begin
          commonlib.MessageDlgXP_Vista('Export to PDF failed.' +CHR(13) +CHR(13) + E.Message , mtWarning, [mbok] , 0);
        end;
      end;
      end;
  finally
    self.BeginTransaction;
    EnableForm;
  end;
end;

procedure TSalesOrderGUI.btnPickUpFromClick(Sender: TObject);
var
  frm: TPickFromPopupGUI;
begin
  inherited;
  with TPickFromPopupGUI(GetComponentByClassName('TPickFromPopupGUI')) do
  begin
    // Set these required form parameters.
    frm := TPickFromPopupGUI(GetComponentByClassName('TPickFromPopupGUI'));
    frm.CallingFormType := ftSalesOrder;
    frm.CallingForm     := Self;
    ClientDetails       := tblMasterPickupFrom.AsString;
    // Show PickFrom popup form.
    ShowModal;
  end;
end;

procedure TSalesOrderGUI.actConCompleteExecute(Sender: TObject);
var
  fiAL:Integer;
begin
 if Sametext(actconComplete.Caption , 'Co&mplt no Invc') then begin
    if not IsnotSOCompleted('Complete SO' ,true) then exit;
 end else
    if not IsSOCompleted('Un - Convert' , true) then exit;

fiAL:= Accesslevel;
Accesslevel:= 1;
try
  DisableForm;
  try
    inherited;
    if LineEmpty then Exit;
    GlobalEvents.Notify(actConComplete, GEVENT_OnExecute);

    if not (SalesOrder.IsInternalOrder) and (SalesOrder.Converted) then begin
      if CommonLib.MessageDlgXP_Vista('This Sales Order has been converted to either a '+NL+'        ->  ''Complete No Invoice'' Status or  '+NL+'        ->  It''s Invoice is being Deleted.' + NL+NL+
                'Do you wish to cancel this status and make the Sales Order Active? ' , mtWarning, [mbYes, mbNo], 0) <> mrYes then
        exit;
    end else if (SalesOrder.Converted = true) and (SalesOrder.convertedtoInvoiceCount=0 ) then begin
        if MessageDlgXP_Vista('This Sales Order has been converted to a "Complete No Invoice" Status.' + NL +
                              'Do you wish to cancel this status amd make the Sales Order Active? ' , mtConfirmation ,[mbyes,mbno],0) = mrno then
          exit;
//        exit;
    end else begin
      if SalesOrder.Converted = true then
        exit;
    end;

    if (SalesOrder.Converted = False) and not(JobCreated) then      Exit;

    SalesOrder.Converted:= not(SalesOrder.Converted);
    if SalesOrder.Converted then
      NewAuditTrialentry('Sales Order Completed Without Invoice')
    else
      NewAuditTrialentry('Sales Order In-Completed ');

    if not SaveSalesRecord then exit;

  //    if not tblDetails.IsEmpty then begin
  //      SalesOrder.Converted:= true;
  //    end;
    SalesOrder.PostDB;
    SalesOrder.Dirty:= false;

    CommitAndNotify;
    Self.Close;
  finally
    EnableForm;
  end;
finally
  Accesslevel:= fiAL;
end;
end;


procedure TSalesOrderGUI.FormDestroy(Sender: TObject);
begin
  self.SaleBase:= nil;
  Salesorder := nil;
  inherited;
end;

procedure TSalesOrderGUI.FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
var
  LineXML:String;
begin
  if (accesslevel<=3) and (Shift = [ssCtrl]) and (Key = VK_down) then begin
        Salesorder.Lines.PostDB;
    if  (Salesorder.lines.count >0) then begin
        LineXML :=Salesorder.Lines.XMLTocopyLine;
        Salesorder.Lines.New;
        Salesorder.Lines.XML:=LineXML;
        if Salesorder.Lines.FESalesLines.count >0 then
          ProductformulaEntry(nil);
        Exit;
    end;
  end;


  inherited;

end;

procedure TSalesOrderGUI.tblDetailsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  EnableComplete;
end;

procedure TSalesOrderGUI.tblDetailsAfterPost(DataSet: TDataSet);
begin
  inherited;
  EnableComplete;
end;

procedure TSalesOrderGUI.tblDetailsBeforePost(DataSet: TDataSet);
begin
  inherited;
  tblDetails.Edit;
  tblDetails.FieldByName('IsQuote').AsString := 'F';
end;

procedure TSalesOrderGUI.FormCreate(Sender: TObject);
begin
  fbDofinalisenClose  := False;


  mnuPartialShipmentLine.visible := not(Appenv.CompanyPrefs.EnableBoinBOMsalesOrder);
  mnuPartialInvoice.visible := not(Appenv.CompanyPrefs.EnableBoinBOMsalesOrder);
  mnuPartialShipments.visible := not(Appenv.CompanyPrefs.EnableBoinBOMsalesOrder);

  btnCompleteNoInvoice.Left := btnFinalizeOrder.Left;
  btnCompleteNoInvoice.top  := btnFinalizeOrder.top;
  ProcessAlreadyStarted:= False;
  ffrmConvertedFrm := Nil;
  fbNoConvertQuestion:= false;
  AllowCustomiseGrid := True;
  btnAddFreight.Visible := AppEnv.CompanyPrefs.StateFreightChargeEnabled;
  inherited;
  {Delphi Bug}
end;

procedure TSalesOrderGUI.UpdateButtonActions;
begin
//  actConRepairUpdate(nil);

  btnCopyToRepair.enabled := true; (*accesslevel<3;*)
end;

procedure TSalesOrderGUI.UpdateMe;
begin
  inherited;
end;

function TSalesOrderGUI.ValidateClosingDate(const TransDate: TDateTime): Boolean;
begin
  //
  // Don't ever lock payment due to closing date , but display the message at top
  //
  if (TransDate <= AppEnv.CompanyPrefs.ClosingDate) or (TransDate <= AppEnv.CompanyPrefs.ClosingDateAR)  then begin
      Self.Caption := Self.Caption + '     { '+LockMsgClosingDate+' ! }';
  end;

  Result := False;
end;

procedure TSalesOrderGUI.WriteExtraGuiPref;
begin
  inherited;
//  GuiPrefs.Node['Options.sizeMode'].asString := SizeMode;
end;

(*procedure TSalesOrderGUI.SendEmailCallback(const ACommaContactEmails: string;
  ASilent, ASecret: boolean);
var
  RecipientAddress, ReportType, OutGoingFileName: string;
  strResult: string;
  ReportAttachmentfiles:String;
  Corres: TCorrespondenceGui;

  sl : TStringList;
  idx : integer;

begin
  ReportToPrint := '';

  sl := TStringList.Create;
  sl.CommaText := ACommaContactEmails;
  try
    if not self.SaveSalesRecord then
      Exit;
    Self.CommitAndNotify;
    for idx := 0 to sl.Count - 1 do
    begin
      Corres := TCorrespondenceGui.Create;
      try

      // Clear all previous params/data
      RecipientAddress  := sl[idx];
      OutGoingFileName  := '';
      ReportType := 'Sales Order';

      Corres.RecipientList := RecipientAddress;
      Corres.CCList := GetSalesEmails;
      try

        LoadTemplate(True, True);

        Corres.Subject := strResult;

        Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;

        OutGoingFileName := //GetCompanyName + ' ' + ReportType + ' #' + SalesOrder.DocNumber + '.PDF';
                            getOutGoingFileName('',' ' + ReportType + ' #' + SalesOrder.DocNumber, '.PDF');

        if not FileExists( Commonlib.TempDir  + OutGoingFileName) then
        begin
          CopyFile(PChar( Commonlib.TempDir  + 'EmailReport.PDF'),
                   PChar( Commonlib.TempDir  + OutGoingFileName), False);
        end;

        Corres.CustomerId := SalesOrder.CustomerID;
        Corres.AttachmentList.Add(Commonlib.TempDir + OutGoingFileName);
        ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres , GetTemplate(ReportToPrint));
        try
          Corres.Execute(ASilent, ASecret);
        finally
          DeleteFiles( Commonlib.TempDir , '*.PDF');
          DeleteMultipleFiles(Commonlib.TempDir , ReportAttachmentfiles);
        end;

      except
        CommonLib.MessageDlgXP_Vista('There was an error sending email', mtWarning, [mbOK], 0);
      end;
    finally
      Corres.Free;
    end;
    end;  // for idx
  finally
    sl.Free;
    self.BeginTransaction;
  end;
end;*)

function TSalesOrderGUI.SendPrintEmail: boolean;
var
  recip: string;
begin
  recip := SalesOrder.ContactEmail;
  if recip = '' then
    recip := SalesOrder.Customer.Email;
  result := TCorrespondenceGui.EmailCustomerSale(recip, GetSalesEmails,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.SOPrintEmailSubject, PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.SOPrintEmailText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger);
end;

function TSalesOrderGUI.SendPrintEmailSilent: boolean;
var
  toEmail: string;
begin
  toEmail := SalesOrder.ContactEmail;
  if toEmail = '' then
    toEmail := SalesOrder.Customer.Email;

  result := TCorrespondenceGui.EmailCustomerSale(toEmail, GetSalesEmails,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.SOPrintEmailSubject, PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.SOPrintEmailText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger,true);
end;

function TSalesOrderGUI.SendPrintSMS: boolean;
var
  number: string;
begin
  result := false;
  number := GetOrAddMobileNumber;
  if number = '' then exit;

  result := TCorrespondenceGui.SMSCustomer(number,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.SOPrintSMSText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger);
end;

function TSalesOrderGUI.SendPrintSMSSilent: boolean;
var
  toMobile: string;
begin
  toMobile := SalesOrder.ContactMobile;
  if toMobile = '' then
    toMobile := SalesOrder.Customer.Mobile;

  result := TCorrespondenceGui.SMSCustomer(toMobile,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.SOPrintSMSText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger);
end;

procedure TSalesOrderGUI.SetButtonState(const Value: Boolean);
begin
  btnNext.Enabled := Value;
  btnCompleted.Enabled := Value;
  btnClose.Enabled := Value;
  btnPreview.Enabled := Value;
  btnPrint.Enabled := Value;
  cmdPrintPick.Enabled := Value;
  cmdDeliveryDocket.Enabled := Value;
  cmdEmail.Enabled := Value;
//  btnCopyToRepair.Enabled := Value;
  //btnCompleteNoInvoice.Enabled := Value;
  EnableComplete;
  btnPrepayment.Enabled := Value;

  actConCash.Enabled := Value;
  btnConSmart.Enabled := Value;
  actProgressPayment.Enabled := Value;
//  btnFreightTNT.Enabled := Value;
end;

procedure TSalesOrderGUI.SetDatasetconn;
begin
  inherited;
  qrysalesdeliverydetails.connection := MyConnection;
end;

procedure TSalesOrderGUI.SetDirty(ADirty: boolean);
begin
  inherited;
  SalesOrder.Dirty:= ADirty;
end;

procedure TSalesOrderGUI.cboShipDateExit(Sender: TObject);
begin
  inherited;
    if OldShipmentdate <> tblMasterShipDate.asDateTime then
        if chkFutureSO.Checked then
            if CommonLib.MessageDlgXP_Vista('This is a Future Sales Order, Do you want to make it current?' ,
                        mtconfirmation , [mbYes, mbNo] , 0) = mrYes then begin
               if tblMaster.state in [dsEdit,dsInsert] then else tblMaster.Edit;
               tblMasterFutureSO.asString := 'F';
            end;
end;

procedure TSalesOrderGUI.cboShipDateEnter(Sender: TObject);
begin
  If not Self.tblmaster.active then Exit;
  inherited;
  OldShipmentdate := tblMasterShipDate.asDateTime;
end;
procedure TSalesOrderGUI.cboDueDateEnter(Sender: TObject);
begin
  If not Self.tblmaster.active then Exit;
  inherited;
  oldDuedate := tblMasterDueDate.AsDatetime;
end;

procedure TSalesOrderGUI.cboDueDateExit(Sender: TObject);
begin
  inherited;
  if Not chkFutureSO.Checked AND AppEnv.CompanyPrefs.UseFutureSO then
    if OldDueDate <> tblMasterDueDate.asDateTime then
        if tblMasterDueDate.asDateTime  - DateOf(now) > AppEnv.CompanyPrefs.FutureSODays then
            if CommonLib.MessageDlgXP_Vista('Is this a Future Sales Order?' ,
                        mtconfirmation , [mbYes, mbNo] , 0) = mrYes then begin
               if tblMaster.state in [dsEdit,dsInsert] then else tblMaster.Edit;
               tblMasterFutureSO.asString := 'T';
            end;
end;

function TSalesOrderGUI.SaveSalesRecord: boolean;
begin
    result := true;
    try
      if SalesOrder.IsLayby then begin
        SalesOrder.CancelDb;
        SalesOrder.Dirty:= false;
        exit;
      end;
      if accesslevel = 5 then begin
        SalesOrder.CancelDb;
        SalesOrder.Dirty:= false;
        exit;
      end;
      lblProcessMessage.Caption := 'Saving....';
      lblProcessMessage.visible := true;

      try
        SetControlFocus(btnCompleted);
        if AccessLevel >= 5 then begin
            Salesorder.postDB;
            Salesorder.Dirty := False;
            Exit;
        end;
        if SalesOrder.Dirty then  begin
          SalesOrder.ResultStatus.Clear;
            if Appenv.companyPrefs.EnableAvaTax then   Result := CalcAvaTax;
            if not result then exit;
            if SalesOrder.Save then begin
              (*if Accesslevel <=3 then
                if not ChecknValidateInternalOrder then begin
                  result := False;
                  Exit;
                end;*)
              SaveProcessData;
              SalesOrder.Dirty:= false;
            end else begin
              result:= false;
              HandleSalesOrderErrors;
            end;
        end;
      finally
          lblProcessMessage.Visible := false;
          SalesOrder.ResultStatus.Clear;
      end;
    finally
    end;
end;


procedure TSalesOrderGUI.SaveTree;
  function SalesLineTree: TProctreenode;
  begin
    SalesOrder.Lines.InstantiateTree;
    result:= TSalesLineProcTree(SalesOrder.Lines.Container.ItemByClass(TSalesLineProcTree));
  end;
  var
    ProcTree: TProctreenode;
begin
  ProcTree:=SalesLineTree;
  if Assigned(ProcTree) then begin
    ProcTree.CalcCost;
    ProcTree.CalcPrice;
    ProcTree.SaveNoCheck;
  end;
end;

procedure TSalesOrderGUI.CommitAndNotify;
var
  MsgObj: TMsgObj;
begin
  CommitTransaction;
  AfterCommit; // virtual method used in decendants
  Notify;

  MsgObj := TMsgObj.Create;
  MsgObj.SetAddress('TfmMarketingLead', 'SalesOrderSaved');
  MsgObj.IntValue := SalesOrder.ClientID;
  fMsgHandler.Send(MsgObj);
end;

procedure TSalesOrderGUI.DoAfterShowCustomiseForm;
begin
  inherited;
  InitGridDisplay;
end;

procedure TSalesOrderGUI.DoBusinessObjectEvent(Const Sender: TDatasetBusObj;
  const EventType, Value: string);
begin
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TFESalesLines then TFESalesLines(Sender).Dataset                           := tblFESalesLines
        else if Sender is TFESaleslinesRelatedPrs then TFESaleslinesRelatedPrs(Sender).Dataset  := tblFESaleslinesRelatedPrs
        else if Sender is TSalesShippingDetails then TSalesShippingDetails(Sender).Dataset  := Qrysalesshippingdetails
        else if Sender is TSalesDeliveryDetails then TSalesDeliveryDetails(Sender).Dataset  := qrysalesdeliverydetails;
    end else if (EventType = BusObjEvent_Change) and (Value = BusObjEvent_TreePartSourcefromstockforSales) then begin
        TransTimerMsg(quotedstr(Salebase.Lines.ProductName) +' has taken from stock based on the preference : ' +Quotedstr('Manufacture Part Source from Stock By Default') , 5);
    end else if (EventType = BusObjEvent_Change) and  (Value = BusObjEventVal_QtyShipped)  then begin
      if  SalesOrder.Lines.isTreeItem = False then begin
        if AppEnv.CompanyPrefs.BarcodePickingInSOMode then begin
          SalesOrder.Lines.PostDB;
          TfmAllocation.DoBinBatchform(SalesOrder.Lines.PQA , Self, (IsSalesLocked) or (IstransLineLocked) or (SalesOrder.Converted=True));
        end;
      end;
      ShowmanufactureSummary(false);
    end else if (EventType = BusObjEvent_Change) and  (Value = BusObjEvent_OnTreeCreated)  then begin
        ShowManufactureSummary(False);
    end else if (EventType = BusObjEvent_Change) and  (Value = BusObjEventVal_LineDeleted) then begin
      //if  SalesOrder.Lines.isTreeItem = False then begin
        SalesOrder.Lines.PostDB;
        TfmAllocation.DoBinBatchform(SalesOrder.Lines.PQA , Self, (IsSalesLocked) or (IstransLineLocked) or (SalesOrder.Converted=True))
      //end;
    end else if (EventType = BusObjEvent_Change) and  (Value = BusObjEventVal_CustomerChanged) then begin
      if SalesOrder.Customer.IsInternal then begin
        SalesOrder.IsInternalOrder := true;
      end;
    end else if (EventType = BusObjEvent_Change) and  (Value = BusObjEventVal_ShippingTreeItem) then begin
      if not Appenv.CompanyPrefs.SingleQtySO then TransTimerMsg('BOM product can no longer be backordered due to the ability to partial invoice a build', 5);
    end else if (EventType = BusObjEvent_Cancelchange) and  (Value = BusobjEventVal_InternalOrder) then begin
      TransTimerMsg('As this Sales order is a part of a group having back orders, the ''Internal Order'' cannot be changed', 5);
    end
    else if (EventType = BusObjEvent_Change) and  (Value = BusObjEventVal_CustomerChanged) then begin
      if AppEnv.CompanyPrefs.PreventSalesOrderOnStopCredit and (SalesOrder.Customer.StopCredit) then
        MessageDlgXP_vista('This Customer is on Stop Credit!', mtWarning, [mbOK], 0);
    end else If (EventType = BusObjEvent_Warning) then begin
      if (Value = BusobjEventVal_StopCredit) and AppEnv.CompanyPrefs.PreventSalesOrderOnStopCredit then begin
        SalesOrder.Dirty := false;
        self.CloseWait;
        Abort;
      end;
    end else if (EventType = BusObjEvent_Change) and  (Value = BusObjEvent_PickupFrom) then begin
        Showcontrolhint(lblPickUpFrom ,SalesOrder.PickupFromDesc);
    end else if (EventType = BusObjEvent_Dataset) and  (Value = BusObjEvent_OnDataIDChange) and (Sender is TSalesBase) then begin
      Showcontrolhint(lblPickUpFrom ,SalesOrder.PickupFromDesc);
    end;
end;

Procedure TSalesOrderGUI.ShowmanufactureSummary(IgnorePref:boolean);
begin
    if Salesorder.Lines.hastree then
      if IgnorePref or ((Appenv.CompanyPrefs.ShowManufacutresummarywhenchangedfromSales) and (Appenv.Employee.ShowManufacutresummarywhenchangedfromSales)) then
        if Salesorder.Lines.Qtyshipped <> 0 then begin
          SaveTree;
          if TfmsaleslineManufactureSummary.ShowSaleslineManufactureSummary(TERpconnection(Salesorder.Lines.Connection.Connection) , Salesorder.Lines.ID, true ) = mrOk then
            OpenTree;
        end;
end;

procedure TSalesOrderGUI.HandleSalesOrderErrors;
var
  FatalStatusItem: TResultStatusItem;
begin
  FatalStatusItem:= SalesOrder.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then
  begin
    case FatalStatusItem.Code of
      BOR_Sales_Err_InvalidDepartment : SetControlFocus(cboClass);
      BOR_Sales_InvalidPONumber : SetControlFocus(txtPONumber);
    end;
  end;
end;
{open the BO record when trying to edit a readonly invoice. }
procedure TSalesOrderGUI.grdTransactionsKeyPress(Sender: TObject;  var Key: Char);
var
    ErrMsg :String ;
    Editable :Boolean;
    SaleID :Integer;
    saleLineID :Integer;
begin
    inherited;
    if CheckForfieldsinGridKeyPress(Sender, key) then exit;
    if (grdTransactions.GetActiveField  = tblDetailsUnitofMeasureBackOrder) or
        (grdTransactions.GetActiveField = tblDetailsLineTax) then begin
        if (Key >= '0') and (Key <= '9') then Key := chr(0);
        Exit;
    end;
    if grdTransactions.GetActiveField = tblDetailsUnitofMeasureShipped then begin
        if tblDetailsUnitofMeasureShipped.readonly then begin
            if (Key >= '0') and (Key <= '9') then begin
                {this method of he objects checks for any open backorder for the current PO for the
                selected product, and if found returns the PurchaseOrderId of the record.
                If the record not found, it returns the message the ErrMsg.}
                SaleID := SalesOrder.Lines.getCurrentBackOrderId(ErrMsg, Editable, SaleLineID);
                if Editable = False then begin
                    CommonLib.MessageDlgXP_Vista(ErrMsg, mtWarning, [mbOk], 0);
                    Exit;
                end;

            if SaleId = SalesOrder.ID then begin
            end else begin
                if CommonLib.MessageDlgXP_Vista('The SalesOrder is locked as it has a invoiced Back Order. ' +chr(13) +
                              'The quantity can be changed only in the Back Order.' + chr(13) +
                              'Do you want to open the Back Order of this SalesOrder?' ,
                              mtConfirmation , [mbYes, mbNo], 0) = mrYes then begin
                    Postmessage(Self.handle, SX_OpenINVofBO, SaleID, SaleLineID);
                    Exit;
                end;
            end;
        end;
    end;
  end else if (grdTransactions.GetActiveField = tblDetailsUnitofMeasureQtySold) and (Key = TAB)then begin
  end else if (grdTransactions.ColumnByName(grdTransactions.getActiveField.FieldName).ReadOnly) and (Key <> TAB) then begin
    CommonLib.MessageDlgXP_Vista('You do not have Access to change "' +
      grdTransactions.ColumnByName(grdTransactions.getActiveField.FieldName).DisplayLabel +'"', mtWarning, [mbOK], 0 , );

  end;
end;


procedure TSalesOrderGUI.btnPrepaymentClick(Sender: TObject);
begin
  //if not HasAccess('Make Prepayment') then exit;
  if SalesOrder.converted then begin
    MessageDlgXP_Vista('Sales Order #' + inttostr(SalesOrder.ID) +' is already converted. ', mtWarning, [mbOK], 0);
    Exit;
  end;
  if not SOHasLines('Make Prepayment') then exit;
  if AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.classname)> 2 then begin
    MessageDlgXP_Vista('You don''t have enough access to Sales Orders to make Progress payment. ', mtWarning, [mbOK], 0);
    Exit;
  end;

  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;


procedure TSalesOrderGUI.btnPreviewClick(Sender: TObject);
begin
  actPreviewExecute(nil);
  CloseAfterPrint;
end;

procedure TSalesOrderGUI.btnPrintClick(Sender: TObject);
var
  OptsForm: TfmReportingOptions;
  IsEnabled: boolean;
begin
  if not SaveSalesRecord then Exit;
  Self.CommitAndNotify;
  OptsForm := EmailOptsForm;//TfmReportingOptions.Create(nil);
  try
    OptsForm.ActionList.AddDivider('Print');
    OptsForm.ActionList.Add('Print','Print a Sales Order',actPrintExecute, true, true);
    OptsForm.ActionList.Add('Preview', 'Preview a Sales Order', self.actPreviewExecute, true, true);
    OptsForm.ActionList.Add('Picking', 'Print a Picking Slip',self.actPickExecute, false, true);
    if Salesorder.Anylinehastree then OptsForm.ActionList.Add('Job Details', 'Print Job Details',PrintJobDetails, false, true);
    OptsForm.ActionList.Add('Delivery', 'Print a Delivery Docket',self.actDelDocketExecute, false, true);
    OptsForm.ActionList.Add('Save PDF', 'Save a PDF Sales Order to your computer', SaveTransToPDF, true, true);
    if SalesOrder.AnylineIsBatchEnabled then OptsForm.ActionList.Add('Dispatch Barcode', 'Print Sales Dispatch Batch Barcode', PrintSalesDispatchBarcode, true, true);
    //if Salesorder.Anylinehastree then OptsForm.ActionList.Add('BOM Barcode', 'Print Batch numbers assigned to the Manufactured Product', PrintBOMBarcode, true, true);
    OptsForm.ActionList.AddDivider('Email' ,'Email to the Customer and CC to Employees Tracking Sales Emails');
    OptsForm.ActionList.Add('Email Sales Order', 'Email a copy of the Sales Order', EmailSalesOrder, true, true);
    OptsForm.ActionList.Add('Email Silently', 'Email a copy of the Sales Order Silently', EmailSalesOrderSilent, true, true);
    OptsForm.ActionList.Add('Email Sales Order (Edit)', 'Edit Email Message Before Sending, With a Copy of the Sales Order`', DoEmailTransactionnonsilent, true, true);


    if AppEnv.CompanyPrefs.EnableSOPrintEmail and ((SalesOrder.ContactEmail <> '') or (SalesOrder.Customer.Email <> '')) then begin
      OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without Sales Order', self.SendPrintEmailSilent, true, true);
      OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without Sales Order', self.SendPrintEmail, true, true);
    end
    else begin
      OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without Sales Order', self.SendPrintEmailSilent, true, false);
      OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without Sales Order', self.SendPrintEmail, true, false);
    end;

    OptsForm.ActionList.AddDivider('SMS');

    IsEnabled := AppEnv.CompanyPrefs.SMSEnabled and
       AppEnv.CompanyPrefs.EnableSOPrintSMS and
       ((SalesOrder.ContactMobile <> '') or (SalesOrder.Customer.Email <> ''));
    OptsForm.ActionList.Add('SMS', 'Just send SMS', self.SendPrintSMSSilent, true, IsEnabled);
    OptsForm.ActionList.Add('SMS (Edit)', 'Edit SMS before sending', self.SendPrintSMS, true, AppEnv.CompanyPrefs.SMSEnabled);
    if Salesorder.Anylinehastree then begin
      OptsForm.ActionList.AddDivider('Manufacture');
      OptsForm.ActionList.Add('BOM Summary', 'Print Summary of all BOM Products in the order', PrintManufacturesummary, true, true);
    end;

    OptsForm.ShowModal;
    CloseAfterPrint(OptsForm.CloseWhenDone );
  finally
    OptsForm.Free;
  end;
end;

procedure TSalesOrderGUI.OpenInv(var Msg: TMessage);
var
  frm: TInvoiceGUI;
begin
  frm := TInvoiceGUI(GetComponentByClassName('TInvoiceGUI'));
  if Assigned(frm) then begin
    frm.KeyID := msg.wParam;
    frm.FormStyle := fsMDIChild;
    frm.BringToFront;
    ffrmConvertedFrm := frm;
  end;
end;

procedure TSalesOrderGUI.actConSmartUpdate(Sender: TObject);
begin
  inherited;
(*  actConSmart.Enabled := (tblDetails.RecordCount > 0) and (KeyID <> 0) and (Accesslevel <=3) and
        (not (AppEnv.CompanyPrefs.DisableCopyToSmartwhenSOCreate and
        tblMaster.FieldByName('POCreated').AsBoolean));
  if not actConSmart.Enabled and Not Sysutils.SameText(btnConSmart.Caption,'SM/O Created') then
  if Keyid <> 0 then btnConSmart.Caption := 'SM/O Created';*)
  actconSmart.Enabled:= True;
end;

procedure TSalesOrderGUI.actCopyOrderExecute(Sender: TObject);
var
  iNewID:Integer;
begin
  if not (Appenv.AccessLevels.GetEmployeeAccessLevel('FnCancopySalesOrder') =    1)  then begin
    MessageDlgXP_Vista('You don''t have access to copy to sales order', mtWarning, [mbOk], 0);
    exit;
  end;
  if not SOHasLines('Copy To Sales Order') then exit;
  if not IsaSavedSO('Copy To Sales Order')  then exit;
  //if not HasAccess('Copy To Sales Order', true, 1) then exit;

  DisableForm;
  try
      if not SaveSalesRecord then exit;
      showProgressbar(WaitMsg, 4);
      try
        SalesOrder.connection.CommitTransaction;
        StepProgressbar;
        SalesOrder.Connection.BeginTransaction;
        StepProgressbar;
        iNewID:= SalesOrder.CopySalesorderToSalesorder;
        StepProgressbar;
      finally
        HideProgressbar;
      end;
      if iNewID <> 0 then begin
        Accesslevel := Appenv.AccessLevels.GetEmployeeAccessLevel(Self.classname);
        NewAuditTrialentry('Sales Order Created(Copied)');
        SalesOrder.connection.CommitTransaction;
//        CloseQueries;
        MessageDlgXP_Vista('Sales Order #' + inttoStr(SalesOrder.ID) +' is copied and made a new Sales Order #' + inttoStr(iNewID) +'', mtInformation, [mbOK], 0);
        KeyId := iNewID;

        showProgressbar(WaitMsg, 2);
        try
          LoadTransRec;
          SalesOrder.MakeCleanTree;
          SalesOrder.Connection.BeginTransaction;
          SetcontrolFocus(cboClientR);

        finally
          HideProgressbar;
        end;

      end else begin
        SalesOrder.connection.RollbackTransaction;
        SalesOrder.Connection.BeginTransaction;
        MessageDlgXP_Vista('Copying Sales Order Failed' , mtWarning, [mbok] ,0 );
      end;
  finally
    EnableForm;
  end;
end;

procedure TSalesOrderGUI.actCopyOrderUpdate(Sender: TObject);
begin
  inherited;
  actCopyOrder.Enabled := True;
end;


procedure TSalesOrderGUI.LinesFinaliseTreeCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TsalesOrderline) then exit;
  TsalesOrderline(Sender).FinaliseTree;
end;
procedure TSalesOrderGUI.Lockcomponents;
begin
  inherited;
  if accesslevel <> 1 then
    { do nothing }
//  else if SalesOrder.CleanID =0 then begin
//    cboTerms.ReadOnly := False;
//    cboTerms.hint :='';
//    cboTerms.showhint := True;
//  end
  else if AppEnv.AccessLevels.GetEmployeeAccessLevel('change Terms-Sales Order') <> 1 then begin
    cboTerms.ReadOnly := True;
    cboTerms.hint :='You don''t have access to change Terms';
    cboTerms.showhint := True;
  end
  else begin
    cboTerms.ReadOnly := False;
    cboTerms.hint :='';
    cboTerms.showhint := True;
  end;


  if AppEnv.AccessLevels.GetEmployeeAccessLevel('ChooseTemplate-Sales Order') <> 1 then begin
    chkChooseRpt.Enabled := False;
    chkChooseRpt.hint :='You don''t have access to choose template';
  end else chkChooseRpt.Enabled := True;
end;
(*Function TSalesOrderGUI.ChecknValidateInternalOrder:Boolean;
var
  msgoption :WOrd;
  fiNonTreeLines:Integer;
begin
  REsult := True;
  if SalesOrder.isinternalOrder = False then Exit;
  fiNonTreeLines := SalesOrder.NonTreeLines;
  if fiNonTreeLines =0 then exit;
  msgoption := MessageDlgXP_vista('Internal Sales Order # ' + inttostr(Salesorder.ID) +' has ' +inttostr(fiNonTreeLines)+' Non-Tree Product(s). '+NL+
                                  'These Non Tree Products will not be Used and Will not Affect the Stock When the Order is Completed.', mtConfirmation, [], 0 ,nil , '' , '' , False, nil , 'Chane to Non-Internal Order,Delete '+inttostr(fiNonTreeLines)+' Non-Tree Product(s), Cancel' );
  if msgoption = 102 then exit;
  if msgoption = 100 then begin
    SalesOrder.IsInternalOrder := False;
    SalesOrder.PostDB;
    Result := SalesOrder.Save;
  end else if msgoption = 101 then begin
    SalesOrder.Lines.IterateRecords(DeleteNonTreeLinesCallback);
    Result := SalesOrder.Save;
  end;
end;*)
procedure TSalesOrderGUI.DeleteNonTreeLinesCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TsalesOrderline) then exit;
  If Not(TsalesOrderline(Sender).IsTreeItem) Then Begin
    TsalesOrderline(Sender).Deleted := True;
    TsalesOrderline(Sender).PostDB;
  End;
end;
procedure TSalesOrderGUI.SaveProcessData;
var
  ProcessID: Integer;
  qrySteps: TERPQuery;
  qryProcess: TERPQuery;
begin
//  if ProcPrefs.WastageCalculationEnabled  then
    if SalesOrder.CleanID =0 then
      SalesOrder.Lines.IterateRecords(LinesFinaliseTreeCallback);

  qrySteps := DbSharedObjectsObj.DbSharedObj.GetQuery(MyConnection);
  qryProcess := DbSharedObjectsObj.DbSharedObj.GetQuery(MyConnection);

  try
    tblDetails.DisableControls;
    tblDetails.First;

    while not tblDetails.Eof do begin
      qrySteps.SQL.Text := 'SELECT * FROM tblprocesspart WHERE PartID = ' + tblDetails.FieldByName('ProductID').AsString;
      qrySteps.Open;
      qrySteps.First;

      if not qrySteps.IsEmpty then begin
        qryProcess.SQL.Text := 'SELECT * FROM tblprocess WHERE SaleLineID = ' + tblDetails.FieldByName('SaleLineID').AsString;
        qryProcess.Open;

        if qryProcess.IsEmpty then begin
          qryProcess.Append;
          qryProcess.FieldByName('SaleID').AsInteger := tblMaster.FieldByName('InvoiceDocNumber').AsInteger;
          qryProcess.FieldByName('SaleLineID').AsInteger := tblDetails.FieldByName('SaleLineID').AsInteger;
          qryProcess.FieldByName('ProductID').AsInteger := tblDetails.FieldByName('ProductID').AsInteger;
          qryProcess.Post;
          ProcessID := qryProcess.FieldByName('ProcessID').AsInteger;
          qryProcess.Close;
          qryProcess.SQL.Text := 'SELECT * FROM tblprocesslines WHERE ProcessID = ' + IntToStr(ProcessID);
          qryProcess.Open;

          while not qrySteps.Eof do begin
            qryProcess.Append;
            qryProcess.FieldByName('ProcessID').AsInteger := ProcessID;
            qryProcess.FieldByName('ProcessStepID').AsInteger := qrySteps.FieldByName('ProcessStepID').AsInteger;
            qryProcess.FieldByName('LineColor').AsInteger := qryWorkOrderPriority.FieldByName('Color').AsInteger;
            qryProcess.Post;
            qrySteps.Next;
          end;
        end;
      end;

      qrySteps.Close;
      qryProcess.Close;
      tblDetails.Next;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qrySteps);
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryProcess);
    tblDetails.EnableControls;
  end;
end;

(*procedure TSalesOrderGUI.SetPriorityCombo;
var
  PriorityText: string;
begin
  if KeyID <> 0 then begin
    qryGetPriority.Close;
    qryGetPriority.ParamByName('SaleID').AsInteger := KeyID;
    qryGetPriority.Open;

    if not qryGetPriority.IsEmpty then begin
      PriorityText := qryGetPriority.FieldByName('Text').AsString;
      qryWorkOrderPriority.Locate('Text', PriorityText, [loCaseInsensitive]);
      cboWorkOrderPriority.LookupValue := PriorityText;
    end;
  end;
end;*)

procedure TSalesOrderGUI.mnuPartialShipmentsClick(Sender: TObject);
begin
  inherited;
  try
    Salesorder.PostDB;
    Salesorder.Lines.postDB;
  Except
  end;

  if Salesorder.AnyLineHasTree = False then begin
      MessageDlgXP_vista('The Order has no BOM Product', mtWarning, [mbOK], 0);
      Exit;
  end;

  OpenERPListForm('TsalesOrderInvoicesGUI', beforeshowsalesOrderInvoicesGUI);

end;

procedure TSalesOrderGUI.beforeshowsalesOrderInvoicesGUI(Sender: TObject);
begin
  if not(Sender is TsalesOrderInvoicesGUI) then exit;
  TsalesOrderInvoicesGUI(Sender).SaleID     := SalesOrder.ID;
  TsalesOrderInvoicesGUI(Sender).SalelineID := SalesOrder.Lines.ID;
end;
procedure TSalesOrderGUI.PerformInvoiceConversion(MsgObj: TMsgObj);
begin
  KeyID := MsgObj.IntValue;
  FormStyle := fsMDIChild;
  actInvoiceExecute(nil);
  FreeAndNil(MsgObj);
end;

procedure TSalesOrderGUI.recalcInvoicesamount;
begin
  inherited;
  SalesOrder.TotalPrePayment.refresh;
  editDB(tblMaster);
  tblMasterTotalProgressPayments.asFloat := SalesOrder.TotalProgressPayments + SalesOrder.TotalPrepayments;
  tblMAsterBalanceAmount.asFloat := SalesOrder.TotalAmountinc-(SalesOrder.TotalProgressPayments + SalesOrder.TotalPrepayments);
  if ((SalesOrder.TotalBalance - SalesOrder.TotalProgressPayments - SalesOrder.TotalPrePayments) <= 0) and SalesOrder.HoldSale then
    SalesOrder.HoldSale := false;
  PostDB(tblMaster);
end;

procedure TSalesOrderGUI.InitGridDisplay;
begin
  grdTransactions.RemoveField('BOMGroupedLine');
  GuiPrefs.DbGridElement[grdTransactions].HideField('BOMGroupedLine');
  grdTransactions.RemoveField('BOMProductionLine');
  GuiPrefs.DbGridElement[grdTransactions].HideField('BOMProductionLine');

  if AppEnv.CompanyPrefs.SingleQtySO then
  begin
    grdTransactions.ColumnByName('UnitOfMeasureQtySold').DisplayLabel := 'Qty';
    //grdTransactions.ColumnByName('Attrib1Sale').DisplayLabel :=AppEnv.CompanyPrefs.ProductAttrib1Name;;
    grdTransactions.ColumnByName('Product_Description').DisplayWidth := 30;
    grdTransactions.ColumnByName('TotalLineAmountInc').DisplayWidth := 14;
    grdTransactions.RemoveField('UnitOfMeasureShipped');
    GuiPrefs.DbGridElement[grdTransactions].HideField('UnitOfMeasureShipped');
    grdTransactions.RemoveField('UnitOfMeasureBackOrder');
    GuiPrefs.DbGridElement[grdTransactions].HideField('UnitOfMeasureBackOrder');
  end
  else
  begin
    grdTransactions.ColumnByName('UnitOfMeasureQtySold').DisplayLabel := 'Ordered';
    grdTransactions.AddField('UnitOfMeasureShipped');
    grdTransactions.AddField('UnitOfMeasureBackOrder');
  end;
  grdTransactions.RemoveField('ForeignExchangeSellCode');
  GuiPrefs.DbGridElement[grdTransactions].HideField('ForeignExchangeSellCode');
end;

function TSalesOrderGUI.InitialiseCustomerID(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
begin
  InitialiseStartup := True;
  CustomerID := MsgObj.IntValue;
  Result := True;
end;

procedure TSalesOrderGUI.grdTransactionsDblClick(Sender: TObject);
begin
    if TField(grdTransactions.GetActiveField).FieldName = 'UnitofMeasureShipped' then
            DoBusinessObjectEvent(SalesOrder.Lines, BusObjEvent_Change, BusObjEventVal_QtyShipped);
    inherited;
end;

procedure TSalesOrderGUI.chkIsInternalOrderClick(Sender: TObject);
begin
  inherited;
  if chkIsInternalOrder.DataSource.DataSet.Active  and
    (chkIsInternalOrder.DataSource.DataSet.State in [dsEdit, dsInsert]) then begin
    SalesOrder.IsInternalOrder:= chkIsInternalOrder.Checked;
    SetTitle;
  end;
end;

procedure TSalesOrderGUI.SetTitle;
begin
  if self.SalesOrder.IsInternalOrder then begin


    TitleLabel.Caption:= 'Internal Sales Order';
  end
  else begin
    if SalesOrder.IsLayby then
      TitleLabel.Caption:= 'Layby'
    else
      TitleLabel.Caption:= 'Sales Order';
  end;

  InvalidateComponents(Self);
end;


procedure TSalesOrderGUI.grdTransactionsEnter(Sender: TObject);
begin
  inherited;
  fLockSalesInitialized:= False;
    Locksales;
end;

procedure TSalesOrderGUI.actConCashUpdate(Sender: TObject);
begin
    actConCash.Enabled := True;
end;

procedure TSalesOrderGUI.grdTransactionsCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if (OpenedFromShipContainer = True)
    and (tblDetails.FieldByName('SaleLineID').AsInteger = ShipContainerSaleLineID) then
      ABrush.Color := $00C4FFE1;
end;

Procedure TSalesOrderGUI.BeforeAllocationformShow;
begin
  if AppEnv.CompanyPrefs.BarcodePickingInSOMode=False  then
    MessageDlgXP_Vista('Your picking type in the Preference is set to ''Invoice''.' +chr(13)+
                       'So NO allocation will be done outside an Invoice unless you Save each time in the Allocation form'  ,mtInformation , [mbOk] , 0);
end;

procedure TSalesOrderGUI.btnCloseClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TSalesOrderGUI.btnCopyToRepairClick(Sender: TObject);
begin
  if  (SalesOrder.RepairID <>0) then begin
    MessageDlgXP_Vista('This is a repair Sales Order of repair #' + inttostr(SalesOrder.RepairID) +', cannot create another Repair for it', mtWarning, [mbOK], 0);
    exit;
  end;
  if (Accesslevel >3)  then begin
    MessageDlgXP_Vista('You don''t have enough Access to convert the Sales order into a Repair', mtWarning, [mbOK], 0);
    exit;
  end;

  if not convertToRepair then Exit;
  NewAuditTrialentry('Repair Created');
  CommitAndNotify;
  DEtachAll;
  close;
end;

procedure TSalesOrderGUI.btnDeleteClick(Sender: TObject);
var
  mnu :TMenuItem;
begin
  if SalesOrder.lines.IsTreeItem  and ProcessAlreadyStarted then begin
    if MessageDlgXP_Vista('Some of the Process(s) in this Sales Order is Already Started.'+NL+
                            'It is not Possible to Delete this Item.  '+NL+
                            'Do you Wish to Open the Capacity Planner to View The Schedule of this Order?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
    mnu:= menuItem(grdtransactions.Popupmenu , 'Capacity Planner');
    if assigned(mnu) then begin
      mnu.onclick(mnu);
      Exit;
    end;
  end;
  inherited;

end;

procedure TSalesOrderGUI.btnFreightTNTClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TSalesOrderGUI.actCustomerContactsExecute(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TSalesOrderGUI.grdTransactionsTitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  if Sysutils.SameText(AFieldName ,tblDetailsUnitofMeasureShipped.fieldname) then begin
    showStock;
  end else inherited;
end;

procedure TSalesOrderGUI.grdTransactionsCalcTitleAttributes(Sender: TObject; AFieldName: String; AFont: TFont; ABrush: TBrush;var ATitleAlignment: TAlignment);
begin
  inherited grdTransactionsCalcTitleAttributes(Sender, AFieldName , AFont , ABrush, ATitleAlignment);

  if AccessLevel = 1 then
//    if salesOrder.HasBOLine then
    if SalesOrder.TotalQtyBackOrdered <> 0 then
      if Sysutils.SameText(AFieldName ,tblDetailsUnitofMeasureShipped.fieldname) then begin
        Afont.Color := clmaroon;
        ATitleAlignment := taCenter;
        ABrush.Color := pnlTitle.color;
      end;

end;

procedure TSalesOrderGUI.doShowPrepayments(Sender: TObject);
var
  Choice:Word;
begin
  inherited;
  //if tblMasterTotalProgressPayments.asFloat = 0 then exit;
  if (SalesOrder.TotalProgressPayments = 0) and  (SalesOrder.TotalPrepayments = 0) then exit;

  if SalesOrder.TotalProgressPayments=0 (*SalesOrder.TotalPrepayments = tblMasterTotalProgressPayments.asFloat*) then
    choice := 101
  else if SalesOrder.TotalPrepayments =0 (*SalesOrder.TotalPrepayments = tblMasterTotalProgressPayments.asFloat*) then
    choice := 100
  else
    Choice := MessageDlgXP_Vista('Invoiced Amount :' + FloatToStrF(SalesOrder.TotalProgressPayments + SalesOrder.TotalPrepayments , ffCurrency, 15, CurrencyRoundPlaces) + ' Comprises of '+ #13+#10+
                            '    Progress Payment(s) :' + FloatTostrF(SalesOrder.TotalProgressPayments, ffCurrency, 15, CurrencyRoundPlaces)       + ' and '         + #13+#10+
                            '    Prepayment(s)       :' + FloattoStrF(SalesOrder.TotalPrePayments, ffCurrency, 15, CurrencyRoundPlaces)            + '.'             + #13+#10+#13+#10+
          'Please Select the List You Wish to Open.', mtConfirmation, [] , 0 , nil , '' , '' , False , nil ,
                  'Progress Payment List,Pre-Payment List,Cancel');

  if choice = 100 then
    actProgressPaymentExecute(actProgressPayment)
  else if choice = 101 then OpenPrepaylist
  else begin
    exit;
  end;
end;

procedure TSalesOrderGUI.OpenSO(var Msg: TMessage);
begin
  OpenERPForm('TSalesOrderGUI' , msg.wParam);
end;

procedure TSalesOrderGUI.OpenTree;
var
  ctr:Integer;
begin
  for ctr:= 0 to   mnuDiscountTotal.Items.Count -1 do begin
    if sametext(mnuDiscountTotal.Items[ctr].Caption , 'Process Tree')  then begin
      if mnuDiscountTotal.Items[ctr].Visible  then begin
        if not(mnuDiscountTotal.Items[ctr].Enabled) and (AccessLevel =1) then
          mnuDiscountTotal.Items[ctr].Enabled := TRue;
        mnuDiscountTotal.Items[ctr].click;
        exit;
      end;
    end;
  end;
end;

procedure TSalesOrderGUI.btnShipmentDetailsClick(Sender: TObject);
begin
  inherited;
  SalesShippingDetailForm.Showmodal;
end;
procedure TSalesOrderGUI.AddProductPriceMenu;
begin
  inherited;
  NewMenuForTransGrid('Delete BOM' , DeleteBOMClick , FAlse);
  NewMenuForTransGrid('Delete All' , DeleteBOMClick , FAlse);
(*var
  mnu : TMenuItem;
begin
  inherited;
  if devmode then begin
    if Salesorder.isinternalOrder and Salesorder.Converted then
      if Assigned(grdTransactions.Popupmenu) then begin
        mnu := TMenuItem.Create(self);
        mnu.Caption := 'Delete BOM';
        mnu.OnClick := DeleteBOMClick;
        grdTransactions.Popupmenu.Items.Add(mnu);

        mnu := TMenuItem.Create(self);
        mnu.Caption := 'Delete All';
        mnu.OnClick := DeleteBOMClick;
        grdTransactions.Popupmenu.Items.Add(mnu);
      end;
  end;*)
end;


function TSalesOrderGUI.AnyProcessScheduled: Boolean;
begin
  REsult := tcDatautils.AnyProcessScheduled(salesOrder.ID);
(*var
  strSQL:string;
begin
  strSQL:= 'Select  PP.ID ' +
            ' from tblSaleslines SL ' +
            ' inner join tblprocTree PT on SL.SaleLineId	= PT.masterID and 	PT.Mastertype <> "mtProduct" ' +
            ' inner join tblProcessPart PP on PP.ProcTreeId = PT.ProcTreeId and  ' +
                        ' (PP.timestart > "1899-12-30 00:00:00" or PP.timeend > "1899-12-30 00:00:00") ' +
            ' where SL.SaleId = ' +IntToStr(salesOrder.ID);
  with salesOrder.GetNewDataSet(strSQL, true) do try
    result := Recordcount > 0;
  finally
      if active then close;
      free;
  end;*)
end;


function TSalesOrderGUI.HasProcess: Boolean;
var
  strSQL:string;
begin
  if fbHasProcess then begin
      result := True;
      exit;
  end;
  strSQL:= 'Select  SL.sAleLineID ' +
            ' from tblSaleslines SL ' +
            ' inner join tblprocTree PT on SL.SaleLineId	= PT.masterID and 	PT.Mastertype <> "mtProduct" ' +
            ' where SL.SaleId = ' +IntToStr(salesOrder.ID)+' limit 1';
  with salesOrder.GetNewDataSet(strSQL, true) do try
    result := Recordcount > 0;
  finally
      if active then close;
      free;
  end;
end;


function TSalesOrderGUI.Saverecord: boolean;
begin
  result := SaveSalesRecord;
  if result then result := inherited Saverecord;
end;
procedure TSalesOrderGUI.UpdateMe(const Cancelled: boolean; const aObject: TObject);
begin
  if Cancelled then Exit;
(*    if Assigned(fLastComboAccessed) then begin
      fLastComboAccessed.Text := '';
      closenopendb(fLastComboAccessed.LookupTable);
    end;
    end;*)
  inherited UpdateMe(cancelled, aObject);
  if Cancelled then exit;

  if (aObject is TfmShippingAllocation) then begin
    SalesOrder.ShipmentList.RefreshDB;
    if accesslevel = 1 then
              { 2/7/2014  The following was removed at Federal Wages request,
                          they want to be able to edit an SO that has been sent!! }
(*
      if (SalesOrder.Shipment.Count > 0) and (SalesOrder.Shipment.Status = 'Processed') then begin
        Caption := TitleLabel.Caption + '(Frozen) - This Sales Order''s Shipment(s) Processed';
        accesslevel:= 5;
      end;
*)
    if (SalesOrder.ShipmentList.Count > 0) and (SalesOrder.ShipmentList.Status = 'Processed') then
      btnShipment.Color := $0077ff77;
  end;

end;
procedure TSalesOrderGUI.actProgressPaymentExecute(Sender: TObject);
begin
    if SalesOrder.dirty then
      if MessageDlgXP_Vista('This Will Save The Changes and Close Sales Order.  Do You Wish To Proceed?' , mtConfirmation, [mbyes,mbno],0) = mrno then exit;

    if not SaveSalesRecord then exit;

    if (salesorder.TotalAmountInc = 0) then begin
        MessageDlgXP_Vista('Progress Payment Cannot be Made as Total Sales amount is 0 ' , mtWarning, [mbok],0);
        Exit;
    end;
    if (Salesorder.TotalAmountInc-Salesorder.TotalProgressPayments<=0) then begin
        MessageDlgXP_Vista('New Progress Payment Cannot be Made as Progress Payment(s) have Already been Made for the Total Sales Amount' , mtWarning, [mbok],0);
        //Exit;
    end;
    DEtachAll;
    CommitAndNotify;
    OpenERPListForm('TSOProgresspaymentsGUI' , SOProgresspaymentsBeforeOpen);

    Self.Close;
end;

procedure TSalesOrderGUI.actTakeFromStockExecute(Sender: TObject);
begin
  inherited;
  if not SOhasProcess('Change Product Source to take from stock') then exit;
  if not  IsaSavedSO('Change Product Source to take from stock') then exit;
  if not HasAccess('Change Product Source to take from stock', True , 3) then exit;
  if not  HasAccesstoInvoice('Change Product Source to take from stock') then exit;
  if IsSOConverted('Change Product Source to take from stock') then exit;
//  if IsRepairSO('Change Product Source to take from stock') then exit;
  if IsSoLayby('Change Product Source to take from stock') then exit;
  if hasScheduledProcess('Change Product Source to take from stock') then exit;
  if MessageDlgXP_Vista('Are you sure you want to flag all lines of this Order to ''Take from stock'' instead of ''Building''.'+
                      NL+ 'This means that the stock will be decreased for the Product being sold and no stock movement for the BOM products.' , mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  DeleteAllTreesofSO;
  SalesOrder.Lines.IterateRecords(DeleteTreeCallback);
end;
procedure TSalesOrderGUI.actTakeFromStockUpdate(Sender: TObject);
begin
  inherited;
  actTakeFromStock.Enabled := True;
end;

procedure TSalesOrderGUI.DeleteTreeCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TSalesOrderLine) then exit;
  TSalesOrderLine(Sender).DeleteTree;
end;
procedure TSalesOrderGUI.DeleteAllTreesofSO;
var
  s:String;
  //Qry :TERPQuery;
  ProcTreeIds, ProctreePartIDs,PQAIds:String;
begin
  inherited;

  ProcTreeIds:='';
  ProctreePartIDs:='';
  PQAIds:='';
  if SALesOrder.lines.count > 0 then begin
    with TERPQuery(SALesOrder.getnewDataset('SELECT `ProcTreeId` FROM `tblProcTree` WHERE mastertype <> "mtProduct" and `MasterId` in ( ' + TERPQuery(SaleSOrder.Lines.dataset).GroupConcat('SaleLineID') +')' , true)) do try
      ProcTreeIds:= groupconcat('ProcTreeId');
      if ProcTreeIds <> '' then begin
        s:= 'Select  ProctreePartID from `tblProctreePart`  WHERE `ProcTreeId` IN   (' + ProcTreeIds +')';
        ProctreePartIDs:= OpennGroupconcat(s, 'ProctreePartID');
      end;

      if ProctreePartIDs<> '' then begin
        s:= 'Select PQAID from tblPQA where TRanstype in(' + ManufactureTypes +') and TransLineId in (' + ProctreePartIDs +')';
        PQAIds:= OpennGroupconcat(s,'PQAID');
      end;
      s:= '';
      if PQAIds          <> '' then  s:=    'Delete from tblPQA           where PQAID           in (' + PQAIds          +');';
      if ProctreePartIDs <> '' then  s:= s+ 'Delete from tblProctreePart  where ProctreePartID  in (' + ProctreePartIDs +');';
      if ProcTreeIds <> '' then  s:= s+ 'Delete from tblProcTree  where ProcTreeId  in (' + ProcTreeIds +');';
    finally
      if s<> '' then SalesOrder.executeSql(s);
      closenFree;
    end;
  end;
end;
procedure TSalesOrderGUI.DeleteBOMClick(Sender: TObject);
var
  fbDeleteAll:Boolean;
begin
  if MessageDlgXP_vista('This will permanently delete the selected Product including its BOM.'+NL+
                        'It is not possible to recover it.'+NL+NL+
                        'Are you sure you want to delete it ?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  fbDeleteAll:= sametext(TMenuItem(Sender).caption , 'Delete All');
  With TempMyScript do try
    Connection := Salesorder.connection.connection;
      With SQL do begin
        SQL.add(SQLToMakeERPFIXTable('tblsales'));
        SQL.add(SQLToMakeERPFIXTable('tblsaleslines'));
        SQL.add(SQLToMakeERPFIXTable('tblproctree'));
        SQL.add(SQLToMakeERPFIXTable('tblproctreepart'));
        SQL.add(SQLToMakeERPFIXTable('tblpqa'));
        SQL.add(SQLToMakeERPFIXTable('tblprocessparttimesheet'));
        SQL.add(SQLToMakeERPFIXTable('tblprocesspart'));
        SQL.add(SQLToMakeERPFIXTable('tblprocesstime'));
        SQL.add(SQLToMakeERPFIXTable('tblproctreenodes'));
        With SalesOrder.getnewDataset(' select group_concat(distinct S.saleId) as saleId, '+
                                      ' group_concat(distinct SL.saleLineId) as saleLineId, '+
                                      ' group_concat(distinct PT.ProcTreeId) as ProcTreeId, '+
                                      ' group_concat(distinct PTP.ProcTreePartId) as ProcTreePartId, '+
                                      ' group_concat(distinct pqa.pqaid) as pqaid '+
                                      ' from tblsales S '+
                                      ' inner join tblsaleslines SL on S.saleId = SL.saleId '+
                                      ' left join tblproctree PT on PT.MasterId = SL.saleLineId and PT.mastertype <> "mtProduct" '+
                                      ' left join tblproctreepart PTP on PT.proctreeId = PTP.ProcTreeId '+
                                      ' left join tblpqa pqa on pqa.TransID = S.saleId and pqa.transtype in ("TSalesOrderLine" , ' + ManufactureTypes +') '+
                                      ' where S.saleId = ' + inttostr(SalesOrder.ID) +iif(fbDeleteAll , ' and SL.saleLineID = ' + inttostr(Salesorder.lines.ID) , '')+' ', true) do try

          if fieldbyname('saleLineId').asString     <> '' then Add('Delete  from tblsaleslines   where saleLineId      in ('  +fieldbyname('saleLineId').asString+');');
          if fieldbyname('ProcTreeId').asString     <> '' then Add('Delete  from tblproctree     where ProcTreeId      in ('  +fieldbyname('ProcTreeId').asString+');');
          if fieldbyname('ProcTreePartId').asString <> '' then Add('Delete  from tblproctreepart where ProcTreePartId  in ('  +fieldbyname('ProcTreePartId').asString+');');
          if fieldbyname('pqaid').asString          <> '' then Add('Delete  from tblpqa          where pqaid           in ('  +fieldbyname('pqaid').asString+');');
        finally
           if Active then close;Free;
        end;


        With SalesOrder.getnewDataset(' select  group_concat(distinct PPT.ID) ID '+
                                      ' from tblsales S '+
                                      ' inner join tblsaleslines SL on S.saleId = SL.saleId '+
                                      ' left join tblproctree PT on PT.MasterId = SL.saleLineId and PT.mastertype <> "mtProduct" '+
                                      ' left join tblprocesspart PTP on PT.proctreeId = PTP.ProcTreeId '+
                                      ' Left join  tblprocessparttimesheet PPT on PPT.ProcessPartID = PPT.ID '+
                                      ' where S.saleId = ' + inttostr(SalesOrder.ID) +iif(fbDeleteAll , ' and SL.saleLineID = ' + inttostr(Salesorder.lines.ID) , '')+'; ', true) do try
          if fieldbyname('ID').asString     <> '' then Add('Delete  from tblprocessparttimesheet where ID        in ('  +fieldbyname('ID').asString+');');
        finally
           if Active then close;Free;
        end;


        With SalesOrder.getnewDataset(' select group_concat(distinct PRT.ProcesstimeID) ProcesstimeID'+
                                      ' from tblsales S '+
                                      ' inner join tblsaleslines SL on S.saleId = SL.saleId '+
                                      ' left join tblproctree PT on PT.MasterId = SL.saleLineId and PT.mastertype <> "mtProduct" '+
                                      ' left join tblprocesspart PTP on PT.proctreeId = PTP.ProcTreeId '+
                                      ' Left join  tblprocesstime PRT on PRT.ProcessPartId = PTP.ID '+
                                      ' where S.saleId = ' + inttostr(SalesOrder.ID) +iif(fbDeleteAll , ' and SL.saleLineID = ' + inttostr(Salesorder.lines.ID) , '')+';' , true ) do try
          if fieldbyname('ProcesstimeID').asString     <> '' then Add('Delete  from tblprocesstime where ProcesstimeID        in ('  +fieldbyname('ProcesstimeID').asString+');');
        finally
           if Active then close;Free;
        end;

        With SalesOrder.getnewDataset(' select group_concat(distinct PTN.ID) ID'+
                                      ' from tblsales S '+
                                      ' inner join tblsaleslines SL on S.saleId = SL.saleId '+
                                      ' left join tblproctree PT on PT.MasterId = SL.saleLineId and PT.mastertype <> "mtProduct" '+
                                      ' left join tblproctreenodes PTN on PT.ProcTreeId = PTN.ProctreeId '+
                                      ' where S.saleId = ' + inttostr(SalesOrder.ID) +iif(fbDeleteAll , ' and SL.saleLineID = ' + inttostr(Salesorder.lines.ID) , '')+';' , true) do try
          if fieldbyname('ID').asString     <> '' then Add('Delete  from tblproctreenodes where ID        in ('  +fieldbyname('ID').asString+');');
        finally
           if Active then close;Free;
        end;


        With SalesOrder.getnewDataset(' select  group_concat(distinct AP.AccountPostingId) as AccountPostingId,'+
                                      ' group_concat(distinct APD.AccountPostingDetailId) as AccountPostingDetailId'+
                                      ' from tblsales S'+
                                      ' inner join tblsaleslines SL on S.saleId = SL.saleId'+
                                      ' left join tblproctree PT on PT.MasterId = SL.saleLineId and PT.mastertype <> "mtProduct"'+
                                      ' left join tblaccountposting AP on AP.SourceId = PT.ProcTreeId'+
                                      ' left join tblaccountpostingdetail APD on AP.AccountPostingId = APD.AccountPostingId '+
                                      ' where S.saleId = ' + inttostr(SalesOrder.ID) +iif(fbDeleteAll , ' and SL.saleLineID = ' + inttostr(Salesorder.lines.ID) , '')+';' , true) do try
          if fieldbyname('AccountPostingId').asString           <> '' then Add('Delete  from tblaccountposting       where AccountPostingId        in ('  +fieldbyname('AccountPostingId').asString+');');
          if fieldbyname('AccountPostingDetailId').asString     <> '' then Add('Delete  from tblaccountpostingdetail where AccountPostingDetailId  in ('  +fieldbyname('AccountPostingDetailId').asString+');');
        finally
           if Active then close;Free;
        end;



      end;
      clog(SQL.text);
      Execute;
  finally
    Free;
  end;
end;

procedure TSalesOrderGUI.SOProgresspaymentsbeforeopen(Sender: TObject);
begin
     if not(sender is TSOProgresspaymentsGUI) then exit;
     TSOProgresspaymentsGUI(Sender).SOGlobalref := Salesorder.globalref;
     (*TSOProgresspaymentsGUI(Sender).NewProgresspayment := self.NewProgresspayment;*)
end;
Function TSalesOrderGUI.SOHasLines(const Msg:String; const ShowMsg:Boolean =True):Boolean;
begin
  REsult:= true;
  if (tblDetails.RecordCount = 0) then begin
    if ShowMsg then MessageDlgXP_Vista('The Sales order has no products in it. It is not possible to ' +MSG, mtWarning, [mbOK], 0);
    Result:= False;
  end
end;
Function TSalesOrderGUI.HasAccess(const Msg:String; const ShowMsg:Boolean = True; AccessLevelreqd:Integer = 3):boolean;
begin
  Result := True;
  if (Accesslevel >AccessLevelreqd) then begin
    if ShowMsg then MessageDlgXP_Vista('You don''t have enough Access.  Your current access is ' + AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel)+'. It is not possible to ' +MSG+NL+NL+TransAccessMsg  , mtWarning, [mbOK], 0);
    Result:= False;
  end;
end;
Function TSalesOrderGUI.IsSOCompleted(const Msg:String; const ShowMsg:Boolean = True; Extracon:Boolean =true):Boolean;
var
  iInvID:Integer;
begin
  Result := (SalesOrder.converted = true) and  (SAlesOrder.convertedtoInvoicecount=0);
  if result then exit;
  if (SalesOrder.converted = False) and (SAlesOrder.convertedtoInvoicecount=0) then begin
      if ShowMsg then MessageDlgXP_Vista('This Sales Order was never completed. It is not possible to ' +MSG, mtWarning, [mbOK], 0);
      Result:= False;
  end else if (SalesOrder.converted )  and (SAlesOrder.convertedtoInvoicecount<>0) then begin
      iInvID:=SAlesOrder.convertedtoInvoicecID;
      if ShowMsg then if MessageDlgXP_Vista('This Sales Order is already converted to an Invoice. It is not possible to ' +MSG+NL+NL+
                    'Do you Wish To Open its Invoice # ' + inttostr(iInvID) +'?', mtconfirmation, [mbYes,MbNo], 0) = mryes then
        OpenERPForm('TInvoiceGUI' , iInvId);
      Result:= False;
  end;
end;
Function TSalesOrderGUI.IsnotSOCompleted(const Msg:String; const ShowMsg:Boolean = True):Boolean;
begin
  Result := True;
  if (SalesOrder.converted )  then begin
      if ShowMsg then MessageDlgXP_Vista('This Sales Order was already completed/converted. It is not possible to ' +MSG, mtWarning, [mbOK], 0);
      Result:= False;
  end;
end;

Function TSalesOrderGUI.IsSOConverted(const Msg:String; const ShowMsg:Boolean = True):Boolean;
begin
  Result := False;
  if (SalesOrder.converted = True)  then begin
      if ShowMsg then MessageDlgXP_Vista('This Sales Order is already converted. It is not possible to ' +MSG, mtWarning, [mbOK], 0);
      Result:= True;
  end;
end;

Function TSalesOrderGUI.SOhasProcess(const Msg:String; const ShowMsg:Boolean =True):Boolean;
begin
  Result:= true;
  if not HasProcess then begin
    if ShowMsg then MessageDlgXP_Vista('This is not a manufacture Transaction. It is not possible to ' +MSG, mtWarning, [mbOk], 0);
    REsult:= False;
  end;
end;
Function TSalesOrderGUI.SoHasnoProcess(const Msg:String; const ShowMsg:Boolean =True):Boolean;
begin
  Result:= true;
  if HasProcess then begin
    if ShowMsg then MessageDlgXP_Vista('This is a manufacture Transaction. It is not possible to ' +MSG, mtWarning, [mbOk], 0);
    REsult:= False;
  end;
end;
(*function TSalesOrderGUI.HasToAndIsApproved:Boolean;
begin
  REsult:= False;
  if Appenv.CompanyPrefs.SOHasToBeApprovedforInvoicing then
    if not sametext(SalesOrder.SalesStatus , SOApprovedStatus) then begin
      MessageDlgXP_Vista('As per the preferences, the Sales Order has to be approved to Invoice and it is not approved(Status).'+NL+
                          'Please change the status to ' + SOApprovedStatus +' to be able to invoice.', MtWarning, [MbOK], 0);
      SetControlFocus(cboCurrentTransStatus);
      Exit;
    end;
  REsult:= True;
end;*)

Function TSalesOrderGUI.IsaSavedSO(const Msg:String; const ShowMsg:Boolean =True):Boolean;
begin
  Result:= True;
  if KeyId = 0 then begin
    if ShowMsg then MessageDlgXP_Vista('This is a new Sales Order, Please Save it. It is not possible to ' +MSG, mtWarning, [mbOk], 0);
    Result:= False;
  end;
end;

Function TSalesOrderGUI.HasAccesstoInvoice(const Msg:String; const ShowMsg:Boolean =True):Boolean;
begin
  Result:= True;
  if FnSOToInvoice <> 1 then begin
    if ShowMsg then MessageDlgXP_Vista('You don''t have enough access to convert into invoice (' + AppEnv.AccessLevels.GetAccessLevelDescription(FnSOToInvoice)+'). It is not possible to ' +MSG, mtWarning, [mbOk], 0);
    Result:= false;
  end;
end;
(*Function TSalesOrderGUI.IsRepairSO(const Msg:String; const ShowMsg:Boolean =True):Boolean;
begin
  Result:= False;
  if SalesOrder.RepairID <> 0 then begin
    if ShowMsg then MessageDlgXP_Vista('This is a repair sales order of Repair #' + inttostr(SalesOrder.RepairID) +'. It is not possible to ' +MSG, mtWarning, [mbOk], 0);
    Result:= True;
  end;
end;*)

Function TSalesOrderGUI.IsSoLayby(const Msg:String; const ShowMsg:Boolean =True):Boolean;
begin
  Result:= False;
  if SalesOrder.islayby then begin
    if ShowMsg then MessageDlgXP_Vista('This is a Layby sales order, not possible to change product source. It is not possible to ' +MSG, mtWarning, [mbOk], 0);
    Result:= TRue;
  end;
end;
Function TSalesOrderGUI.hasScheduledProcess(const Msg:String; const ShowMsg:Boolean =True):Boolean;
begin
  Result:= False;
  if AnyProcessScheduled then begin
    if ShowMsg then MessageDlgXP_Vista('Process(es) are already scheduled. It is not possible to ' +MSG, mtWarning, [mbOk], 0);
    REsult := True;
  end;
end;

Procedure TSalesOrderGUI.PrintJobDetails;
begin
  inherited;
  if not SaveSalesRecord then Exit;
  CommitTransaction;
  try
    SalesOrder.Lines.IterateRecords(PrintJobDetailsCallback);
  finally
    BeginTransaction;
  end;
end;
Procedure TSalesOrderGUI.PrintJobDetailsCallback(const Sender: TBusObj; var Abort: Boolean);
var
  StrSQL:String;
  fsTablename :String;
begin
    if (SalesOrder.Lines.ID =0) or  (SalesOrder.Lines.QtyShipped =0) or (SalesOrder.Lines.IsTreeItem =False) then exit;
    fsTablename := UniqueTableName('CPJobDetails');
    StrSQL :=ProductJobDEtailsSQL(fsTablename,  SalesOrder.Lines.ID,  SalesOrder.Lines.ProductID,SalesOrder.Lines.QtyShipped);
    fbReportSQLSupplied := True;
    PrintTemplateReport('Product Job Details' , strSQL , False, 1);
end;
Procedure TSalesOrderGUI.PrintJobDetailsofLine;
var
  Abort: Boolean;
begin
  if not SaveSalesRecord then Exit;
  CommitTransaction;
  try
    PrintJobDetailsCallback(salesOrder.Lines, abort);
  finally
    BeginTransaction;
  end;

end;

initialization
  RegisterClassOnce(TSalesOrderGUI);
  with FormFact do
  begin
    RegisterControl(TSalesOrderGUI, '*_cbosalesID=SaleID');
    RegisterMe(TSalesOrderGUI, 'TSalesOrderListGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBOMDailyProcessSalesGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBOMSalesSubProductsListGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBOMSalesSubProductsDetailListGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBOMSalesOrdersGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TProductionTonnesGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TProductionTonnesDetailsGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBOMProgressbuildListGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBOMOrdersGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBOMWorkOrdersEmployeesGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBOMWorkOrdersProcessGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBOMWorkOrdersProductGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBOMWorkOrdersSalesOrderGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBOMWorkOrdersSummaryGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBOMWorkOrdersExtraDetailsGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TSalesOrderPrnGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBOMWastageReportGUI_SaleId=SaleID');
    RegisterMe(TSalesOrderGUI, 'TSalesorderListExpressGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TWalmartSalesOrdersGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TEBaySalesOrdersGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TProductionOrdersGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TProductionOrderMaterialListGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBOMOrderStatusGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TLaybyListGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TReminderListGUI_*_SalesOrder=ID');
    RegisterMe(TSalesOrderGUI, 'TIncomingOrdersList_*_Sales Order=SaleId');
    RegisterMe(TSalesOrderGUI, 'TSalesPrepaymentsGUI_*_SalesOrder=SaleID');
    RegisterMe(TSalesOrderGUI, 'TSalesOrderReportGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TSaleconvertedToListGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TReminderListGUI_*_Finished Progress Build=ID');
    RegisterMe(TSalesOrderGUI, 'TPickedSalesListGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TMemTransListGUI_*_TSalesOrderGUI=TransID');
    RegisterMe(TSalesOrderGUI, 'TBackOrderSOGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBackOrderSOExpressGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TEmailedReportsList_*_Sales Order=Transaction');
    RegisterMe(TSalesOrderGUI, 'TManifestAllocationListGUI_*_SO=SaleID');
    RegisterMe(TSalesOrderGUI, 'TInvoiceListGUI_ConvertFromSO_Invoice=ConvertFromSO');
    RegisterMe(TSalesOrderGUI, 'TFaxSpoolListingGUI_TransGlobal_Sales Order=TransGlobal');
    RegisterMe(TSalesOrderGUI, 'TFaxSpoolListingGUI_TransType_Sales Order=TransGlobal');
    RegisterMe(TSalesOrderGUI, 'TCustSalesOrdersReportGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBarcodePickingListGUI_*_SO-NotPicked=SaleID');
    RegisterMe(TSalesOrderGUI, 'TSalesListReportGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TSalesListOutstandingGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TOrdersFromStockGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'THireSalesListGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBOMSalesListGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TSalesOrderStatusReportGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TTranswithBOMissingGUI_*_Sales Order=ID');
    RegisterMe(TSalesOrderGUI, 'TBackOrderPurchaseListGUI_*_Sales Order=SaleID');
    //RegisterMe(TSalesOrderGUI, 'TBackOrdersListGUI_ConvertFromSO=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBackOrdersListGUI_ConvertFromSO=ConvertFromSO');
    RegisterMe(TSalesOrderGUI, 'TBackOrderSOGUI_OriginalNo=OriginalNo');
    RegisterMe(TSalesOrderGUI, 'TTransAccountDetailsGUI_*_UnInvoiced SO=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBalTransListGUI_*_UnInvoiced SO=SaleID');
    RegisterMe(TSalesOrderGUI, 'TInventoryAssetVsStockStautsGUI_*_UnInvoiced SO=SaleID');
    RegisterMe(TSalesOrderGUI, 'TToBeReconciledGUI_*_UnInvoiced SO=SaleID');
    RegisterMe(TSalesOrderGUI, 'TReconListDetailFormGUI_*_UnInvoiced SO=SaleID');
    RegisterMe(TSalesOrderGUI, 'TTrialBalTransListGUI_*_UnInvoiced SO=SaleID');
    RegisterMe(TSalesOrderGUI, 'TTransactionListGUI_*_UnInvoiced SO=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBASTransReturnListGUI_*_UnInvoiced SO=SaleID');
    RegisterMe(TSalesOrderGUI, 'TNZTransReturnListGUI_*_UnInvoiced SO=SaleID');
    RegisterMe(TSalesOrderGUI, 'TVATTransReturnListGUI_*_UnInvoiced SO=SaleID');
    RegisterMe(TSalesOrderGUI, 'TGlobalsearchGUI_*_UnInvoiced SO=SaleID');
    RegisterMe(TSalesOrderGUI, 'TGlobalsearchGUI_*_SOBO=SaleID');
    RegisterMe(TSalesOrderGUI, 'TGlobalsearchGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TTransactionListGUI_*_Manufacturing=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBASTransReturnListGUI_*_Manufacturing=SaleID');
    RegisterMe(TSalesOrderGUI, 'TNZTransReturnListGUI_*_Manufacturing=SaleID');
    RegisterMe(TSalesOrderGUI, 'TVATTransReturnListGUI_*_Manufacturing=SaleID');
    RegisterMe(TSalesOrderGUI, 'TGlobalsearchGUI_*_Manufacturing=SaleID');
    RegisterMe(TSalesOrderGUI, 'TTransAccountDetailsGUI_*_UnInvoiced SO=SaleID');
    RegisterMe(TSalesOrderGUI, 'TWorkOrderStatusListGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TPickSlipGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TPickSlipManifestGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TDeliveryDocketListGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TPickingSlipListGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TInvoiceListGUI_ConvertFromSO_Cash Sale=ConvertFromSO');
    RegisterMe(TSalesOrderGUI, 'TSoldProductsReport_*_SalesOrder=SaleID');
    RegisterMe(TSalesOrderGUI, 'TSerialListGUI_Type_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TfmMarketingLead_*_SalesOrder=ActionID');
    RegisterMe(TSalesOrderGUI, 'TAllTransactionGUI_*_SalesOrder=TransNo');
    RegisterMe(TSalesOrderGUI, 'TfmProcProductionPartsList_*=ProdSaleId');
    RegisterMe(TSalesOrderGUI, 'TRepairsList_SOGlobalRef=SOGlobalRef');
    RegisterMe(TSalesOrderGUI, 'TRepairListParts_SOGlobalRef=SOGlobalRef');
    RegisterMe(TSalesOrderGUI, 'TRepairListTimesheet_SOGlobalRef=SOGlobalRef');
    RegisterMe(TSalesOrderGUI, 'TRepairListEquipment_SOGlobalRef=SOGlobalRef');
    RegisterMe(TSalesOrderGUI, 'TRepairInvoiceListGUI_SOGlobalRef=SOGlobalRef');
    RegisterMe(TSalesOrderGUI, 'TBarcodePickListGUI_invoiceno_SalesOrder=invoiceno');
    RegisterMe(TSalesOrderGUI, 'TBarcodePickListGUI_customername_SalesOrder=invoiceno');
    RegisterMe(TSalesOrderGUI, 'TBarcodePickListGUI_Status_Salesorder=invoiceno');
    RegisterMe(TSalesOrderGUI, 'TMemTransListGUI_*_Sales Order=TransID');
    RegisterMe(TSalesOrderGUI, 'TTransactionswith0QtyGUI_*_Sales Order=TrasnsId');
    RegisterMe(TSalesOrderGUI, 'TProductionJobStatusGUI_*=SaleId');
    RegisterMe(TSalesOrderGUI, 'TProductionjobstatusdetailsList_*=SaleId');
    RegisterMe(TSalesOrderGUI, 'TSalesTotalAmountMisMatchGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TJobtimeSheetsGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TProductionPartStatusGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TTransactionSequenceGUI_*_SO=TransID');
    RegisterMe(TSalesOrderGUI, 'TIncompleteproctreepartGUI_*_SO=TransID');
    RegisterMe(TSalesOrderGUI, 'TNumberSequenceListGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TTransMissingBOList_*_Sales Order=ID');
    RegisterMe(TSalesOrderGUI, 'TQuoteConvertedSalesListGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TSalesPurchaseOrderListGUI_*_Sales Order=SmartOrderId');
    RegisterMe(TSalesOrderGUI, 'TJobProfitabilityGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TEBayOrdersGUI_*=SalesOrderID');
    RegisterMe(TSalesOrderGUI, 'TPnLEmployeereportGUI_*_Sales Order=TransID');
    RegisterMe(TSalesOrderGUI, 'TDeldocketListGUI_*_Sales Order=SaleId');
    RegisterMe(TSalesOrderGUI, 'TProcesseswithNotimeGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBalTransListGUI_*_Manufacturing=SaleID');
    RegisterMe(TSalesOrderGUI, 'TInventoryAssetVsStockStautsGUI_*_Manufacturing=SaleID');
    RegisterMe(TSalesOrderGUI, 'TSalesAddressLabelPrnGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TSalesAddressLabelPrnGUI_*_Layby=SaleID');
    RegisterMe(TSalesOrderGUI, 'TProductTransactionListGUI_*_Sales Order=TransID');
    RegisterMe(TSalesOrderGUI, 'TBOMSalesList_ProductGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBOMSalesList_Level1GUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBOMSalesList_Level2GUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBOMSalesList_DetailsGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TBOMSalesList_ExtraDetailsGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TProductionOrderListGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TUnallocatedBatchSalesListGUI_*_Sales Order=SaleID');
    RegisterMe(TSalesOrderGUI, 'TMagentoOrdersGUI_*=Sales Order=ID');
    RegisterMe(TSalesOrderGUI, 'TAmazonSalesOrderExpressGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TColesSaleslistExpressGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TColesORDRSPExpressListGUI_*=SaleID');
    RegisterMe(TSalesOrderGUI, 'TColesDESADVExpressListGUI_*=SaleID');
    //RegisterMe(TSalesOrderGUI, 'TSalesAnalysisGraphDrilldownSalesGUI_*_Sales Order=SaleID');
  end;

end.


