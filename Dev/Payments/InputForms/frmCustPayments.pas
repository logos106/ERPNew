{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 03/05/05  1.00.01 BJ   when the bank details are accepted, update the customer's
                        bank details if they are empty.
                        field updated : bankaccountname, bankaccountbsb, bankaccountno

 16/05/05  1.00.02 DJH  Added support to track a till number from POS when invoked.
 25/05/05  1.00.03 IJB  Added foreign currency handling.
 08/06/05  1.00.04 IJB  Changed so that total amount is not re-calculated when
                        user changes payment date if currency is AUD or blank.
 22/06/05  1.00.04 IJB  Added Discount and Withholding functionality.
 22/06/05  1.00.05 DSP  Added functionality for use with the NAB CardFast
                        payment method
 01/07/05  1.00.06 BJ   Bug fixed :When  calling from the cutomer Payment list,
                        the form breakes.
 06/07/05  1.00.07 DMS  1. Disabled checkbox Deleted when user creates new
                           payment.
                        2. Formatted unit's source code.
 07/07/05  1.00.08 DSP  Fixed bug where clicking 'Apply Discount' while 'Apply'
                        checkboxes were ticked cleared the checkbox but left
                        the 'Payment Amount' set.
 09/08/05  1.00.09 DSP  Added RegisterClass.
 30/08/05  1.00.10 IJB  Added code in SubfrmPaymentsCheckBoxClick to reduce
                        payment amount when user un-ticks items.
 14/09/05  1.00.11 DSP  Added 'Deposit' button.
 30/09/05  1.00.12 IJB  Modified to use new procedure
                        (PaymentsLibGUI.ShowReconciledListForm and
                        ShowDepositedListForm) to replace
                        procedure removed from TransLockManagementObj.
 14/10/05  1.00.13 MV   Implimentation of Foreign Currency, added new procedure
                        OnDataFieldChange for processing data field changes.
                        Also removed depricated methods from the implementation
                        of the original foreign currency requirements.
 13/12/05  1.00.14 MV   Fixed issue of foreign currency not being updated when
                        changing customer.
 11/04/06  1.00.15 BJ   Locking all the transaction records when the customer is selected
                        corrected the dicount calculation - 'Apply discount' uses the invoice object
 29/01/07  1.00.16 DSP  Added the ability to email customer payments.
 20/04/07  1.00.17 IJB  Changed all StrToInt and StrToFloat to StringToInt and StringToFloat.

}

unit frmCustPayments;

interface
{$I ERP.inc}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, DB, StdCtrls, Mask, DBCtrls, ExtCtrls, DBCGrids,
    BaseInputForm, Grids, BaseGrid, AdvGrid, wwcheckbox,
  wwdbdatetimepicker, wwdblook, Buttons, DNMSpeedButton, StrUtils,
  SelectionDialog, AppEvnts, MyAccess,ERPdbComponents, MemDS, DBAccess, DataState,
  frmBulkPaymentsPrintOptions, wwdbedit, Menus, AdvMenus,
  Shader, DNMPanel, BusObjPayments, Wwdbigrd, Wwdbgrid,busobjbase,
  ActnList, DNMAction, ImgList, ERPDbLookupCombo, ProgressDialog, CreditCardObj,
  JsonObject;

const
    EARLY_PAYMENT = WM_USER +100;
type
  TCardPaymentResult = (cprNotCardPayment, cprSuccess, cprFail);


  TfmCustPayments = class(TBaseInputGUI)
    Notes: TDBMemo;
    Label28: TLabel;
    Label2: TLabel;
    txtAmount: TDBEdit;
    Label3: TLabel;
    Label1: TLabel;
    txtBalance: TDBEdit;
    Label5: TLabel;
    Label23: TLabel;
    cboPayMethod_Label: TLabel;
    RefenceNo: TDBEdit;
    Label29: TLabel;
    Box30: TBevel;
    Box31: TBevel;
    txtUnapplied: TDBEdit;
    Label36: TLabel;
    txtApplied: TDBEdit;
    Label44: TLabel;
    ClassLabel: TLabel;
    Box60: TBevel;
    Label81: TLabel;
    cmdPrint: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    DSMaster: TDataSource;
    lblDeleted: TLabel;
    cboCreationDate: TwwDBDateTimePicker;
    cboClass: TwwDBLookupCombo;
    cboAccount: TwwDBLookupCombo;
    cboPaymentMethod: TwwDBLookupCombo;
    chkDeleted: TwwCheckBox;
    cmdNew: TDNMSpeedButton;
    txtRecordID: TDBEdit;
    tblMaster: TERPQuery;
    tblDetails: TERPQuery;
    tblSalesDetails: TERPQuery;
    tblMasterGlobalRef: TWideStringField;
    tblMasterPaymentID: TAutoIncField;
    tblMasterPaymentNo: TIntegerField;
    tblMasterEmployeeID: TIntegerField;
    tblMasterCusID: TIntegerField;
    tblMasterPaymentDate: TDateField;
    tblMasterAmount: TFloatField;
    tblMasterPayMethodID: TIntegerField;
    tblMasterNotes: TWideStringField;
    tblMasterReferenceNo: TWideStringField;
    tblMasterCardholdersName: TWideStringField;
    tblMasterCreditCardNumber: TWideStringField;
    tblMasterCreditCardExpDate: TDateField;
    tblMasterPrintFlag: TWideStringField;
    tblMasterPrintedBy: TIntegerField;
    tblMasterEditedFlag: TWideStringField;
    tblMasterClassID: TIntegerField;
    tblMasterAccountID: TIntegerField;
    tblMasterCustomer: TWideStringField;
    tblMasterSupplier: TWideStringField;
    tblMasterEmployee: TWideStringField;
    tblMasterContact: TWideStringField;
    tblMasterDeposit: TWideStringField;
    tblMasterCustomerPayment: TWideStringField;
    tblMasterCompanyName: TWideStringField;
    tblMasterAppliedCredits: TWideStringField;
    tblMasterDeleted: TWideStringField;
    tblMasterReconciled: TWideStringField;
    tblMasterDeposited: TWideStringField;
    tblMasterBalance: TFloatField;
    tblMasterDepositedBalance: TFloatField;
    tblMasterCredit: TFloatField;
    tblMasterUnApplied: TFloatField;
    tblMasterApplied: TFloatField;
    tblMasterDepositID: TIntegerField;
    tblMasterReconciliationID: TIntegerField;
    tblMasterFinished: TWideStringField;
    tblMasterStatement: TIntegerField;
    tblMasterMSReceived: TWideStringField;
    tblSalesDetailsSaleID: TAutoIncField;
    tblSalesDetailsGlobalRef: TWideStringField;
    tblSalesDetailsInvoiceDocNumber: TWideStringField;
    tblSalesDetailsOriginalNo: TWideStringField;
    tblSalesDetailsAccount: TWideStringField;
    tblSalesDetailsAccountID: TIntegerField;
    tblSalesDetailsBOID: TWideStringField;
    tblSalesDetailsCustomerName: TWideStringField;
    tblSalesDetailsClientID: TIntegerField;
    tblSalesDetailsInvoiceTo: TWideStringField;
    tblSalesDetailsShipTo: TWideStringField;
    tblSalesDetailsSaleDate: TDateField;
    tblSalesDetailsTotalTax: TFloatField;
    tblSalesDetailsTotalAmount: TFloatField;
    tblSalesDetailsTotalAmountInc: TFloatField;
    tblSalesDetailsTotalMarkup: TFloatField;
    tblSalesDetailsTotalDiscount: TFloatField;
    tblSalesDetailsEmployeeName: TWideStringField;
    tblSalesDetailsEmployeeID: TIntegerField;
    tblSalesDetailsClassID: TIntegerField;
    tblSalesDetailsClass: TWideStringField;
    tblSalesDetailsOrderNumber: TWideStringField;
    tblSalesDetailsPONumber: TWideStringField;
    tblSalesDetailsChequeNo: TWideStringField;
    tblSalesDetailsShipDate: TDateField;
    tblSalesDetailsDueDate: TDateField;
    tblSalesDetailsConNote: TWideStringField;
    tblSalesDetailsMemo: TWideMemoField;
    tblSalesDetailsComments: TWideMemoField;
    tblSalesDetailsInvoicePrintDesc: TWideStringField;
    tblSalesDetailsPickMemo: TWideMemoField;
    tblSalesDetailsPrintHold: TWideStringField;
    tblSalesDetailsShipping: TWideStringField;
    tblSalesDetailsTerms: TWideStringField;
    tblSalesDetailsPayMethod: TWideStringField;
    tblSalesDetailsPayDueDate: TWideStringField;
    tblSalesDetailsPaid: TWideStringField;
    tblSalesDetailsBalance: TFloatField;
    tblSalesDetailsSOBalance: TFloatField;
    tblSalesDetailsPayment: TFloatField;
    tblSalesDetailsApplyFlag: TWideStringField;
    tblSalesDetailsAmountDue: TFloatField;
    tblSalesDetailsTimeOfSale: TWideStringField;
    tblSalesDetailsIsPOS: TWideStringField;
    tblSalesDetailsPOS: TWideStringField;
    tblSalesDetailsIsRefund: TWideStringField;
    tblSalesDetailsIsCashSale: TWideStringField;
    tblSalesDetailsIsInvoice: TWideStringField;
    tblSalesDetailsIsQuote: TWideStringField;
    tblSalesDetailsIsSalesOrder: TWideStringField;
    tblSalesDetailsIsVoucher: TWideStringField;
    tblSalesDetailsIsLayby: TWideStringField;
    tblSalesDetailsIsLaybyTOS: TWideStringField;
    tblSalesDetailsIsLaybyPayment: TWideStringField;
    tblSalesDetailsDeleted: TWideStringField;
    tblSalesDetailsEditedFlag: TWideStringField;
    tblSalesDetailsTotalQuoteAmount: TFloatField;
    tblSalesDetailsLaybyID: TWideStringField;
    tblSalesDetailsDeposited: TWideStringField;
    tblSalesDetailsTillID: TSmallintField;
    tblSalesDetailsHoldSale: TWideStringField;
    tblSalesDetailsFreezeQuoteAmount: TWideStringField;
    tblSalesDetailsConverted: TWideStringField;
    tblSalesDetailsEnteredBy: TWideStringField;
    tblSalesDetailsEnteredAt: TWideStringField;
    tblSalesDetailsCommissionPaid: TWideStringField;
    btnPopup: TDNMSpeedButton;
    tblMasterForeignExchangeRate: TFloatField;
    tblMasterForeignExchangeCode: TWideStringField;
    tblMasterForeignCurrencyAmount: TFloatField;
    tblMasterBankAccountName: TWideStringField;
    tblMasterBankAccountBSB: TWideStringField;
    tblMasterBankAccountNo: TWideStringField;
    tblPrepayments: TERPQuery;
    UseAccNo: TDNMSpeedButton;
    qryPayMethod: TERPQuery;
    cboAccountQry: TERPQuery;
    cboClassQry: TERPQuery;
    cboClientlookup: TERPQuery;
    cboClientlookupClientID: TIntegerField;
    cboClientlookupCompany: TWideStringField;
    cboClientlookupBalance: TFloatField;
    cboClientlookupPayMethodID: TIntegerField;
    cboClientlookupClientNo: TWideStringField;
    btnReconciled: TDNMSpeedButton;
    cboClientlookupBankAccountName: TWideStringField;
    cboClientlookupBankAccountBSB: TWideStringField;
    cboClientlookupBankAccountNo: TWideStringField;
    Bevel2: TBevel;
    lblForeignCurrency: TLabel;
    cboForeignCurrencyCode: TwwDBLookupCombo;
    lblCurrencyAmount: TLabel;
    ForeignAmount: TDBEdit;
    qryForeignCurrency: TERPQuery;
    btnApply: TDNMSpeedButton;
    btnDeposit: TDNMSpeedButton;
    Bevel3: TBevel;
    Label10: TLabel;
    Label12: TLabel;
    txtForeignApplied: TDBEdit;
    txtForeignUnapplied: TDBEdit;
    lblExchangeRate: TLabel;
    edtExchangeRate: TwwDBEdit;
    lblVariationAmount: TLabel;
    edtVariationAmount: TwwDBEdit;
    lblVariationAccount: TLabel;
    cboVariationAccount: TwwDBLookupCombo;
    tblMasterForeignVariationAccountID: TIntegerField;
    tblMasterForeignVariationAmount: TFloatField;
    tblMastermsTimeStamp: TDateTimeField;
    tblMasterForeignUnApplied: TFloatField;
    tblMasterForeignApplied: TFloatField;
    qryVariationAccount: TERPQuery;
    tblSalesDetailsForeignPaidAmount: TFloatField;
    tblSalesDetailsForeignBalanceAmount: TFloatField;
    cboClientlookupForeignExchangeSellCode: TWideStringField;
    btnEmail: TDNMSpeedButton;
    lblEmail: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Panel2: TPanel;
    grdPayments: TwwDBGrid;
    ActionList: TActionList;
    actSave: TDNMAction;
    actapplyDiscount: TDNMAction;
    actNew: TDNMAction;
    actPrintReceipt: TDNMAction;
    actEmail: TDNMAction;
    actCancel: TDNMAction;
    tblGuiDetails: TERPQuery;
    tblGuiDetailsType: TWideStringField;
    tblGuiDetailsCustomerName: TWideStringField;
    tblGuiDetailsSaleDate: TDateField;
    tblGuiDetailsGlobalRef: TWideStringField;
    tblGuiDetailsInvoiceDocNumber: TWideStringField;
    tblGuiDetailsOriginalAmount: TFloatField;
    tblGuiDetailsBalance: TFloatField;
    tblGuiDetailsAmountOutstanding: TFloatField;
    tblGuiDetailsPaid: TWideStringField;
    tblGuiDetailsSaleID: TIntegerField;
    tblGuiDetailsForeignExchangeCode: TWideStringField;
    tblGuiDetailsForeignExchangeRate: TFloatField;
    tblGuiDetailsForeignOriginalAmt: TFloatField;
    tblGuiDetailsForeignBalanceAmount: TFloatField;
    tblGuiDetailsForeignAmountOutstanding: TFloatField;
    tblGuiDetailsPayment: TFloatField;
    tblGuiDetailsForeignPayment: TFloatField;
    tblGuiDetailsDiscount: TFloatField;
    tblGuiDetailsWithholding: TFloatField;
    tblGuiDetailsRefunding: TFloatField;
    tblGuiDetailsRefundPercent: TFloatField;
    tblGuiDetailsApply: TWideStringField;
    tblGuiDetailsIsEarlyPaymentDiscount: TWideStringField;
    tblGuiDetailsRefNo: TWideStringField;
    dsGuiDetails: TDataSource;
    tblGuiDetailsID: TIntegerField;
    tblGuiDetailsEnteredBy: TWideStringField;
    cmdsave: TDNMSpeedButton;
    Bevel1: TBevel;
    lblEnteredHead: TLabel;
    lblEnteredBy: TDBText;
    lblEnteredAt: TDBText;
    lblEnteredAtHead: TLabel;
    qryEmployeeLookup: TERPQuery;
    tblMasterEnteredBy: TWideStringField;
    tblMasterEnteredAt: TDateTimeField;
    lblVariation: TLabel;
    lblMinus: TLabel;
    txtVariationAmount2: TwwDBEdit;
    lblEqual: TLabel;
    txtApplied2: TwwDBEdit;
    lblApplied: TLabel;
    btnSelectall: TDNMSpeedButton;
    actAddSurcharge: TAction;
    btnAddSurcharge: TDNMSpeedButton;
    lblMsg: TLabel;
    btnAddDate: TDNMSpeedButton;
    cboclientR: TERPDbLookupCombo;
    tblMasterSplitPaymentID: TIntegerField;
    tblMasterSplitPaymentLineID: TIntegerField;
    tblGuiDetailsConNote: TStringField;
    qryConnote: TERPQuery;
    AutoIncField1: TAutoIncField;
    WideStringField14: TWideStringField;
    tblMasterClientPrintName: TWideStringField;
    btnCardPayment: TDNMSpeedButton;
    tblMastermsUpdateSiteCode: TWideStringField;
    lblDisableCalc: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cboClientRCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintAndEmailClick(Sender: TObject);
    procedure NotesExit(Sender: TObject);
    procedure NotesEnter(Sender: TObject);
    procedure btnPopupClick(Sender: TObject);
    procedure UseAccNoClick(Sender: TObject);
    procedure cboClientlookupAfterOpen(DataSet: TDataSet);
    procedure cboPaymentMethodCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure btnReconciledClick(Sender: TObject);
    procedure btnDepositClick(Sender: TObject);
    procedure cboClientlookupBeforeOpen(DataSet: TDataSet);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actSaveUpdate(Sender: TObject);
    procedure actPrintReceiptUpdate(Sender: TObject);
    procedure actEmailUpdate(Sender: TObject);
    procedure actNewUpdate(Sender: TObject);
    procedure actCancelUpdate(Sender: TObject);
    procedure actapplyDiscountUpdate(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actapplyDiscountExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure grdPaymentsDblClick(Sender: TObject);
    procedure cboForeignCurrencyCodeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdPaymentsEnter(Sender: TObject);
    procedure grdPaymentsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure chkDeletedClick(Sender: TObject);
    procedure txtAmountChange(Sender: TObject);
    procedure FeldSetTextDontAllowNulls(Sender: TField;const Text: String); override;
    procedure ForeignAmountChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure grdPaymentsTitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure btnSelectallClick(Sender: TObject);
    procedure actAddSurchargeExecute(Sender: TObject);
    procedure actAddSurchargeUpdate(Sender: TObject);
    procedure btnAddDateClick(Sender: TObject);
    procedure RefenceNoEnter(Sender: TObject);
    procedure RefenceNoExit(Sender: TObject);
    procedure cboCreationDateChange(Sender: TObject);
    procedure cboCreationDateExit(Sender: TObject);
    procedure tblGuiDetailsConNoteGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure btnCardPaymentClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tblGuiDetailsAfterOpen(DataSet: TDataSet);
    procedure lblDisableCalcClick(Sender: TObject);
  private
    { Private declarations }
    SettingFieldTextDontAllowNulls:boolean;
    slTranID                    : TStringList;
    iBulkProcessCount           : integer;
    oPrintOptions               : PPrintOptions;
    fbAbortBulkPay              : boolean;
    dPaymentAmount              : double;
    bIndiffProblem              : boolean;
    fsChequeNumber              : string;
    InAccountNoMode             : boolean;
    fsBankAccountName           : string;
    fsBankAccountBSB            : string;
    fsBankAccountNo             : string;
    DiscountsApplied            : boolean;

    fbPOSInitiated              : boolean; //This Should be In Private Dan Had POS
    fiPOSClientID               : integer;
    fdPOSAmount                 : currency;     // set AND returned to POS
    fiPOSPayMethodID            : integer; // returned to POS
    fiPOSPaymentID              : integer;   // returned to POS
    fbPOSPaymentMade            : boolean;
    UserChangedPaymentAmount: boolean;
    fiOpenForSalesId: Integer;
    OriginalAccesslevel: integer;
//    SavedAccessLevel: integer;
    PaymentCard: TCreditCard;
    GrdPaymentJson: TJsonObject;
    Procedure ChangeDisplayLabel;
    procedure Print(const ID: Integer; EmailReport: Boolean = False);
    procedure ManipulateRequiredControls;
    Procedure ManipulateFCControls;
    procedure SendReportEmail;
    procedure Arrangecolwidth;
    procedure DoEarlyPayment; overload;
    procedure DoEarlyPayment(var Msg: TMessage); overload;message EARLY_PAYMENT;
    procedure SetForeignFieldDisplayFormat;
    function SaveData(var CardPaymentResult: TCardPaymentResult): boolean;
    {$IFDEF DevMode}
    Procedure ApplyCallback(Const Sender: TBusObj; var Abort: Boolean);
    {$ENDIF}
    procedure SetGridAccess;
    procedure CheckCardPaymentBankAccount;
    procedure AfterDepositedList(Sender: TObject);
    procedure initDepositedList(Sender: TObject);
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Procedure UnlockRelatedTables; Override;
    Procedure InitGuiPrefsReadonlyFields;Override;
    Procedure InitERPLookupCombonFields; Override;
  public
    { Public declarations }
    CustPayment : TCustPayments;
    Property POSInitiated           : boolean       Read fbPOSInitiated     Write fbPOSInitiated; //This Should be In Private Dan Had POS
    Property POSClientID            : integer       read fiPOSClientID      Write fiPOSClientID;
    Property POSAmount              : currency      read fdPOSAmount        Write fdPOSAmount;     // set AND returned to POS
    Property POSPayMethodID         : integer       Read fiPOSPayMethodID   Write fiPOSPayMethodID; // returned to POS
    Property POSPaymentID           : integer       read fiPOSPaymentID     Write fiPOSPaymentID;   // returned to POS
    Property POSPaymentMade         : boolean       Read fbPOSPaymentMade   Write fbPOSPaymentMade;
    property BankAccountName        : string        read fsBankAccountName  write fsBankAccountName;
    property BankAccountBSB         : string        read fsBankAccountBSB   write fsBankAccountBSB;
    property BankAccountNo          : string        read fsBankAccountNo    write fsBankAccountNo;
    property ChequeNumber           : string        read fsChequeNumber     write fsChequeNumber;
    property AbortBulkPay           : boolean       read fbAbortBulkPay     write fbAbortBulkPay;
    property TranIDs                : TStringList   read slTranID           write slTranID;
    property BulkPrintOptions       : PPrintOptions read oPrintOptions      write oPrintOptions;
    property PaymentAmount          : double        read dPaymentAmount     write dPaymentAmount;
    property IndiffProblem          : boolean       read bIndiffProblem     write bIndiffProblem;
    Property OpenForSalesId         : Integer       read fiOpenForSalesId   Write fiOpenForSalesId;
    constructor Create(AOwner: TComponent); override;
    Procedure ApplyTransactionSelection(GrdTransactionSelection:TwwDBGrid);
    Procedure ChooseCustomer(aclientID:Integer; acompanyname:String );
    Procedure ChooseForeignExchangeCode(aFXCode:String);
  end;

implementation

uses
  FormFactory, Math,DNMExceptions,
  frmPaymentsChequeDetails,
  EmailExtraUtils,
  PaymentsLibGUI,tcDataUtils, FastFuncs, tcConst,
  AppEnvironment, BusObjConst, CommonLib, DNMLib, UserLockObj, MySQLConst,
  BusObjCurrency, frmDelayMessageDlg, CommonFormLib,
  frmPaymentSurchargePercentInput, CorrespondenceObj, SystemLib, TimedHint,
  frmPaymentCardDetails, BusObjGLAccount, frmCardPayment, BusObjPaymethods,
  CustPaymentDepositList, BaseListingForm, LogLib;

  {$R *.DFM}

var
  LastActiveControl: TWinControl = nil;


Procedure TfmCustPayments.ManipulateFCControls;
begin
    ForeignAmount.Enabled       := CustPayment.IsFCSelected;
    lblCurrencyAmount.Visible   := CustPayment.ISFCSelected;
    ForeignAmount.Visible       := CustPayment.ISFCSelected;
    lblExchangeRate.Visible     := CustPayment.ISFCSelected;
    edtExchangeRate.Visible     := CustPayment.ISFCSelected;
    lblVariationAmount.Visible  := CustPayment.ISFCSelected;
    edtVariationAmount.Visible  := CustPayment.ISFCSelected;
    lblVariationAccount.Visible := CustPayment.ISFCSelected;
    cboVariationAccount.Visible := CustPayment.ISFCSelected;
    SetForeignFieldDisplayFormat;
    lblMinus.Visible            := CustPayment.ISFCSelected;
    lblVariation.Visible        := CustPayment.ISFCSelected;
    lblApplied.Visible          := CustPayment.ISFCSelected;
    lblEqual.Visible            := CustPayment.ISFCSelected;
    txtVariationAmount2.Visible := CustPayment.ISFCSelected;
    txtApplied2.Visible         := CustPayment.ISFCSelected;
end;

procedure TfmCustPayments.ManipulateRequiredControls;
var
    x:Integer;
    qry: TERPQuery;
begin
    ManipulateFCControls;
    chkDeleted.visible            := KeyID <> 0;
    lblDeleted.visible            := KeyID <> 0;
    chkDeleted.Enabled            := (KeyID <> 0) and (AccessLevel < 5);
    lblDeleted.Enabled            := (KeyID <> 0) and (AccessLevel < 5);
    for x := 0 to ComponentCount - 1 do begin
        if Components[x] = btnCardPayment then continue;
        if Components[x] is TwwDBLookupCombo    then TwwDBLookupCombo(Components[x]).Enabled     := (AccessLevel < 5) AND (KeyID  = 0);
        if Components[x] is TDBEdit then  begin
          if Components[x] = RefenceNo then begin
            TDBEdit(Components[x]).Enabled := (OriginalAccessLevel < 5);
            if TDBEdit(Components[x]).Enabled then
              TDBEdit(Components[x]).ReadOnly := false;
          end
          else
            TDBEdit(Components[x]).Enabled              := (AccessLevel < 5) AND (KeyID  = 0);
        end;
        if Components[x] is TwwDBEdit           then TwwDBEdit(Components[x]).Enabled            := (AccessLevel < 5) AND (KeyID  = 0);
        if Components[x] is TwwDBDateTimePicker then TwwDBDateTimePicker(Components[x]).Enabled  := (AccessLevel < 5) AND (KeyID  = 0);
        if Components[x] is TDNMSpeedButton     then TDNMSpeedButton(Components[x]).Enabled      := (AccessLevel < 5) AND (KeyID  = 0);
    end;

    txtVariationAmount2.Enabled:= false;
    txtApplied2.Enabled:= false;
    btnReconciled.Visible         := CustPayment.PaymentOnHold or CustPayment.PaymentReconciled;
    btnDeposit.Visible            := CustPayment.IsPaymentDeposited;
    btnReconciled.Enabled         := not(Self.owner.ClassName = 'TReconciliationGUI');
    btnDeposit.Enabled            := btnDeposit.Visible;
//    cmdPrint.Enabled:= (KeyID <> 0);
//    btnEmail.Enabled:= (KeyID <> 0);

    cmdCancel.Enabled   := True;
    cmdNew.Enabled      := True;
    txtForeignApplied.enabled := False;
    txtForeignUnapplied.enabled := False;
    txtApplied.enabled := False;
    txtUnapplied.enabled := False;

    if (KeyID = 0) then begin
        cboForeignCurrencyCode.Enabled  := (AccessLevel < 5) AND (CustPayment.UseFC)     ;
        ForeignAmount.Enabled           := (AccessLevel < 5) AND (ForeignAmount.Visible) AND (CustPayment.UseFC) ;
    end
    else begin
      { enable buton to view linked card payment }
      try
        qry := TERPQuery.Create(nil);
        try
          qry.Connection := MyConnection;
          qry.SQL.Add('select * from tblCardPayment');
          qry.SQL.Add('where ERPTransType = ' + QuotedStr(CustPayment.ClassName));
          qry.SQL.Add('and ERPTransID = ' + IntToStr(KeyID));
          qry.Open;
          btnCardPayment.Visible := not qry.IsEmpty;
        finally
          qry.Free;
        end;
      except
      end;
    end;
    Notes.Enabled                       := accesslevel < 5;
    btnAddDate.Enabled                  := (accesslevel < 5) ;
    SetGridAccess;
end;

procedure TfmCustPayments.SetGridAccess;
begin
  if (AccessLevel = 5) or (KeyID  <> 0) or (CustPayment.GUILines.TransID = 0) then
    grdPayments.Options   := grdPayments.Options - [dgEditing]
  else
    grdPayments.Options   := grdPayments.Options + [dgEditing];
end;

procedure TfmCustPayments.FormShow(Sender: TObject);
var
    QueryNamesNotToOpen : array of String;
begin
  DisableForm;
  try
    try
        inherited;
        ClassLabel.Caption := AppEnv.DefaultClass.ClassHeading;
        CustPayment.Load(KeyId);
        BeginTransaction;
        if KeyID <> 0 then begin

        end else begin
            CustPayment.New;
            if OpenForSalesId<> 0 then begin
              CustPayment.ClientID := GetClientIDforSale(OpenForSalesId);
              CustPayment.OpenForSalesId := OpenForSalesId;
              cboclientR.InitnOpenLookup;
            end;
            if Appenv.CompanyPrefs.InvoiceHasToBeApproved then TimerMsg(lblMsg, 'Please note that only ''Approved'' Invoices can be paid. Please change the ''Status'' of the Invoice to ''Approved'' inorder to pay.');
        end;
        CustPayment.PostDB;
        CustPayment.guiLines;


        cboAccountQry.Params.ParamByName('CurrentID').AsInteger := CustPayment.AccountID;
        Setlength(QueryNamesNotToOpen , 3);
        QueryNamesNotToOpen[0]  := 'tblMaster';
        QueryNamesNotToOpen[1]  := 'TblDetails';
        QueryNamesNotToOpen[2]  := 'tblGuiDetails';
        OpenQueries(QueryNamesNotToOpen);

        TFloatField(cboClientLookup.FieldByName('Balance')).currency := True;
        OriginalAccesslevel := Accesslevel;
        if Custpayment.LockMsg <> '' then begin
            Self.Caption := self.Caption + '     {' + Custpayment.LockMsg +'}';
            Accesslevel  := 5;
        end;
        ManipulateRequiredControls;
        tblGuiDetailsOriginalAmount.DisplayFormat   := Appenv.RegionalOptions.CurrencySymbol +DOUBLE_FIELD_MASK;
        tblGuiDetailsAmountOutstanding.DisplayFormat:= Appenv.RegionalOptions.CurrencySymbol +DOUBLE_FIELD_MASK;
        tblGuiDetailsPayment.DisplayFormat          := Appenv.RegionalOptions.CurrencySymbol +DOUBLE_FIELD_MASK;
        tblGuiDetailsBalance.DisplayFormat          := Appenv.RegionalOptions.CurrencySymbol +DOUBLE_FIELD_MASK;
        tblGuiDetailsDiscount.DisplayFormat         := Appenv.RegionalOptions.CurrencySymbol +DOUBLE_FIELD_MASK;
        tblGuiDetailsWithholding.DisplayFormat      := Appenv.RegionalOptions.CurrencySymbol +DOUBLE_FIELD_MASK;
        tblGuiDetailsRefunding.DisplayFormat      := Appenv.RegionalOptions.CurrencySymbol +DOUBLE_FIELD_MASK;
        if POSInitiated then begin
          cboCreationDate.Enabled := false;
          if POSClientID <> 0 then begin
            CustPayment.ClientID:= POSClientID;
            cboClientR.Enabled := false;
          end;
          if POSAmount <> 0 then CustPayment.Amount := POSAmount;
        end;

//        if AppEnv.Employee.UseClientAccountNoOnPayments then UseAccNo.Click;

        SetControlFocus(cboClientR);
        InAccountNoMode := false;
        CustPayment.Dirty:= false;
        UserChangedPaymentAmount:= false;
        if CustPayment.ClientID <> 0 then
          if cboclientR.lookuptable.Fieldbyname(cboclientR.Lookupidfield).asInteger <> CustPayment.ClientID then
              cboclientR.lookuptable.locate(cboclientR.Lookupidfield ,CustPayment.ClientID , []);// this is to locate the correct record in the lookup table

        if OpenForSalesId<> 0 then begin

          SetControlFocus(grdPayments);
          if CustPayment.guiLines.Dataset.locate('SaleID' , OpenForSalesId , []) then begin
              CustPayment.guiLines.Applied := true;
              // this applies the early payment and refreshes the grid and relocates the record pointer - so relocate the record
              application.ProcessMessages;
              if CustPayment.guiLines.Dataset.locate('SaleID' , OpenForSalesId , [])  then begin
                CustPayment.guiLines.Applied := true;
                SetControlFocus(grdPayments);
                grdPayments.SetActiveField('Payment');
              end;
           end;
        end;
        tblMasterEnteredAt.DisplayFormat := FormatSettings.ShortDateformat;
//        RefenceNo.ReadOnly := false;
        if keyid =0 then
          CustPayment.Editdb;

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
  finally
    Application.ProcessMessages;
    EnableForm;
  end;
end;

procedure TfmCustPayments.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CustPayment.userLock.UnlockAllCurrentInstance;
(*  if OpenForSalesId <> 0 then
    OpenERPForm('TInvoiceGUI' ,OpenForSalesId );*)
  Action := caFree;
  FreeAndNil(PaymentCard);
end;

procedure TfmCustPayments.cboClientRCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if (not modified)  then exit;

  ManipulateFCControls;
  UserChangedPaymentAmount:= false;
end;

procedure TfmCustPayments.cboCreationDateChange(Sender: TObject);
begin
  inherited;
               if not (EmployeeHasAccess('AllowFutureDateinCustomerPayment')) and (cbocreationdate.date >date) then begin cbocreationdate.date := date; ShowTimedHint(cbocreationdate ,  'You Do not Have Access to Create Payments for Future Date.' +NL +'Date is Set back to Current Date'+NL, true );
      end else if not (EmployeeHasAccess('AllowPastDateinCustomerPayment'  )) and (cbocreationdate.date <date) then begin cbocreationdate.date := date; ShowTimedHint(cbocreationdate ,  'You Do not Have Access to Create Payments for Past Date.' +NL +'Date is Set back to Current Date'  +NL, true );
      end;
end;

procedure TfmCustPayments.cboCreationDateExit(Sender: TObject);
begin
  inherited;
  Hidehint(Sender);
end;

Procedure TfmCustPayments.ChangeDisplayLabel;
var
    DC, FC :String;
    Procedure ChangeLabel(Const DCFieldName,FCFieldName , GroupName :String);
    begin
        //if (CustPayment.ForeignExchangeCode = AppEnv.RegionalOptions.ForeignExDefault) or (CustPayment.ForeignExchangeCode = '') then begin
        if not CustPayment.isfcSelected then begin
            if DCFieldName <> '' then begin
                if tblGuiDetails.Findfield(DCFieldName)            <> nil then begin
                    grdPayments.ColumnByName(DCFieldName).DisplayLabel  := groupname;
                    grdPayments.ColumnByName(DCFieldName).Groupname     := '';
                end;
            end;
            if FCFieldName <> '' then
                if tblGuiDetails.Findfield(FCFieldName)        <> nil then
                    grdPayments.RemoveField(FCFieldname);
        end else begin
            if DCFieldName <> '' then
                if tblGuiDetails.Findfield(DCFieldName)            <> nil then begin
                    grdPayments.ColumnByName(DCFieldName).DisplayLabel  := DC;
                    grdPayments.ColumnByName(DCFieldName).GroupName     :=  AnsiReplaceStr(groupname , '~' , ' ');
                    grdPayments.ColumnByName(DCFieldName).DisplayWidth  := 10;
                end;
            if FCFieldName <> '' then
                if tblGuiDetails.Findfield(FCFieldName)        <> nil then begin
                    grdPayments.AddField(FCFieldname);
                    grdPayments.ColumnByName(FCFieldName).DisplayLabel  := FC;
                    grdPayments.ColumnByName(FCFieldName).GroupName     := AnsiReplaceStr(groupname , '~' , ' ');
                    grdPayments.ColumnByName(FCFieldName).DisplayWidth  := 10;
                    grdPayments.ColumnByName(FCFieldName).Index := grdPayments.ColumnByName(DCFieldName).Index+1;
                end;
        End;
    end;
begin
    FC := 'Foreign';
    DC := AppEnv.RegionalOptions.ForeignExDefault;
    ChangeLabel('OriginalAmount','ForeignOriginalAmt','Original~Amount');
    ChangeLabel('AmountOutstanding','ForeignAmountOutstanding','Outstanding~Amount');
    ChangeLabel('Payment','ForeignPayment','Payment~Amount');
    ChangeLabel('Balance','ForeignBalanceAmount','Amount~Due');
    FC := 'Foreign~Exchange Rate';ChangeLabel('','ForeignExchangeRate','');
    grdPayments.ColumnByName('ForeignPayment').ReadOnly := not(CustPayment.IsFCSelected);
    ArrangeColWidth;
end;

procedure TfmCustPayments.CheckCardPaymentBankAccount;
var
  qry: TERPQuery;
begin
  if CustPayment.ReferenceNo = '' then begin
    CustPayment.ReferenceNo := 'Card Payment';
    CustPayment.PostDb;
    CustPayment.Dirty := false;
  end;

  qry := TERPQuery.Create(nil);
  try
    qry.Connection := MyConnection;
    qry.SQL.Add('select * from tblcardpayment');
    qry.SQL.Add('where ERPTransType = ' + QuotedStr(CustPayment.ClassName));
    qry.SQL.Add('and ERPTransID = ' + IntToStr(CustPayment.ID));
    qry.SQL.Add('and PaymentStatus = 1');
    qry.Open;
    if not qry.IsEmpty then begin
      if (qry.FieldByName('ERPBankAccount').AsString <> '') and
         (qry.FieldByName('ERPBankAccount').AsString <> CustPayment.AccountName)  then begin

        CustPayment.AccountName := qry.FieldByName('ERPBankAccount').AsString;
        CustPayment.PostDB;
        CustPayment.Dirty := false;
        CommonLib.MessageDlgXP_Vista('The Payment Bank Account has been changed to match the Bank Account used by the ' +
          qry.FieldByName('Gateway').AsString + ' Payment Gateway (' + qry.FieldByName('ERPBankAccount').AsString + ')',mtInformation,[mbOk],0);

      end;
    end;
  finally
    qry.Free;
  end;

  if Assigned(PaymentCard) and (PaymentCard.CardType <> '') then begin
    if not SameText(CustPayment.PayMethodName,PaymentCard.CardType) then begin
      if TPaymentMethod.IDToggle(PaymentCard.CardType) > 0 then begin
        CustPayment.PayMethodName := PaymentCard.CardType;
        CustPayment.PostDB;
        CustPayment.Dirty := false;
        CommonLib.MessageDlgXP_Vista('The Payment Method has been changed to match the Card Type',mtInformation,[mbOk],0);
      end;
    end;
  end;
end;

procedure TfmCustPayments.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
var
  msg: string;
  json, rec: TJsonObject;


  function SavedRec: TJsonObject;
  var
    idx: integer;
  begin
    result := nil;
    for idx := 0 to GrdPaymentJson.A['Lines'].Count -1 do begin
      if (GrdPaymentJson.A['Lines'][idx].AsObject.S['TransType'] = CustPayment.GUILines.TransType) and
         (GrdPaymentJson.A['Lines'][idx].AsObject.I['TransID'] = CustPayment.GUILines.TransID) then begin
        result := GrdPaymentJson.A['Lines'][idx].AsObject;
        break;
      end;
    end;
  end;

begin
    inherited;
(*  if (EventType=BusobjEvent_Event) then
    if (Value =BusobjEvent_IteratereRecords) then begin
        ShowProgressbar(Sender.Count, Sender.IteraterecordProgressbarMsg);
    end else if (Value = BusobjEvent_IteratereRecordDone) then begin
      HideProgressbar;
    end else if (Value = BusobjEvent_IteratereRecordLoop) then begin
      StepProgressbar;
    end;*)

    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TCustPayments              then TCustPayments(Sender).DataSet          := tblMaster
        else if Sender is TCustPaymentLines     then TCustPaymentLines(Sender).DataSet      := tblDetails
        else if Sender is TGuiCustPaymentLines  then TGuiCustPaymentLines(Sender).DataSet   := tblguiDetails;
    end else if (Eventtype = BusObjEvent_Change) and (Value = BusobjEventVal_applied) then begin
              if CustPayment.guiLines.ForeignExchangeCode <> CustPayment.guiLines.HeaderForeignExchangeCode then begin
                MessageDlgXP_Vista( 'The currency [' + CustPayment.guiLines.ForeignExchangeCode + '] of ' + CustPayment.guiLines.TransType + '# ' + CustPayment.guiLines.TransNumber +
                                    ' doesn''t match with the currency [' + CustPayment.guiLines.HeaderForeignExchangeCode+'] you are paying in.', mtWarning, [mbOK], 0);
                CustPayment.guiLines.Applied := False;
            end
    end else if (Eventtype = BusObjEvent_Change) then begin
      if Value = BusobjEventVal_SalesDiscountApplied then begin
        grdPayments.ColumnByName('Discount').Readonly := true; // once discount applied, can't apply again
      end else if (Value = BusObjEvent_TotalsChanged) then begin
        if not UserChangedPaymentAmount then begin
          try
            if CustPayment.IsFCSelected then begin
              CustPayment.ForeigncurrencyAmount:= CustPayment.ForeignApplied;
            end else begin
              CustPayment.Amount:= CustPayment.Applied;
            end;
          finally
            UserChangedPaymentAmount:= false;
          end;
        end;
      end  else if (Value = BusobjEventVal_ClientUserLockFail) then begin
        msg:= 'User ' + Sender.UserLock.LockInfo.UserName +
          ' is processing payments for this customer.' + #13#10 + #13#10 +
          'In use since ' + FormatDateTime('hh:nn:ss dd:mm:yyyy',Sender.UserLock.LockInfo.TimeLocked);
        DelayMessageDlg(msg, mtInformation, [mbOk], 0)
      end else if (Value = BusObjEventVal_ClientID) then begin
        ManipulateFCControls;
        SetGridAccess;
      end else if value = BusObjEvent_PaymentRefno then begin
        if AppEnv.AccessLevels.GetEmployeeAccessLevel('CanAlterRefinCustPayment')<> 1 then
          if (tblMasterReferenceNo.OldValue <>  '') then
            MessageDlgXP_vista('You don''t have access to change ''Reference  No'' on a Customer Payment', mtWarning, [mbOK], 0);
            CustPayment.ReferenceNo :=tblMasterReferenceNo.OldValue ;
      end;
    end
    else if (Eventtype = BusobjEvent_Event) then begin
      if (Value = BusObjEventVal_BeforeRefreshGuiLines) then begin
        if GrdPaymentJson.I['ClientID'] <> CustPayment.ClientID then begin
          { new client .. clear lines from previous client }
          GrdPaymentJson.Clear;
        end
        else begin
          { save the status of the lines for this client before they ar refreshed }
          GrdPaymentJson.Clear;
          GrdPaymentJson.I['ClientID'] := CustPayment.ClientID;
          CustPayment.GUILines.First;
          while not CustPayment.GUILines.EOF do begin
            with GrdPaymentJson.A['Lines'].AddObject do begin
              S['TransType'] := CustPayment.GUILines.TransType;
              I['TransID'] := CustPayment.GUILines.TransID;
              B['Applied'] := CustPayment.GUILines.Applied;
              F['Payment'] := CustPayment.GUILines.Payment;
            end;
            CustPayment.GUILines.Next;
          end;
        end;

      end
      else if (Value = BusObjEventVal_AfterRefreshGuiLines) then begin
        ShowProgressbar('Refresh Lines for the Customer', CustPayment.GUILines.Count+5);
        try
              if CustPayment.GUILines.Count > 0 then begin
                json := JO;
                try
                  { reinstate selections plus add any new refunds created .. }
                  StepProgressbar;
                  json.I['ClientID'] := CustPayment.ClientID;
                  CustPayment.GUILines.First;
                  StepProgressbar;
                  while not CustPayment.GUILines.EOF do begin
                    { build a new list .. }
                    with json.A['Lines'].AddObject do begin
                      S['TransType'] := CustPayment.GUILines.TransType;
                      I['TransID'] := CustPayment.GUILines.TransID;
                      B['Applied'] := CustPayment.GUILines.Applied;
                      F['Payment'] := CustPayment.GUILines.Payment;
                    end;

                    { only do this if we have some saved lines }
                    if (GrdPaymentJson.A['Lines'].Count > 0) and (GrdPaymentJson.I['ClientID'] = CustPayment.ClientID) then begin
                      rec := SavedRec;
                      if Assigned(rec) then begin
                        if rec.B['Applied'] then begin
                          CustPayment.GUILines.Applied := true;
                          if CustPayment.GUILines.Payment > rec.F['Payment'] then
                            CustPayment.GUILines.Payment := rec.F['Payment'];
                        end;
                      end
                      else begin
                        { if its a new refund .. select it }
                        if SameText(CustPayment.GUILines.TransType,'Refund') then
                          CustPayment.GUILines.Applied := true;

                      end;
                      Application.ProcessMessages;
                    end;
                    CustPayment.GUILines.Next;
                    StepProgressbar;
                  end;
                finally
                  StepProgressbar;
                  GrdPaymentJson.Assign(json);
                  json.Free;
                end;
              end;
        finally
          hideProgressbar;
        end;
      end;
    end  else if (Eventtype = BusobjEvent_ToDo ) and (Value =  BusobjEvent_CalculationsDisabled) then begin
        lblDisableCalc.visible := CustPayment.GUILines.count > appenv.CompanyPrefs.CustPayLinesToDisableCalcs;
    end;
end;

procedure TfmCustPayments.FormCreate(Sender: TObject);
begin

    GrdPaymentJson := JO;
    btnAddDate.Visible :=   not(UserPreferenceOn(lcdOnCustPayComments));
    AllowCustomiseGrid := True;
    ShowCustomisemenu:= False;
    AllowGridSorting  := True;
    CustPayment                     := TcustPayments.Create(Self);
    CustPayment.BusObjEvent         := DoBusinessObjectEvent;
    CustPayment.ChangeDisplayLabel  := ChangeDisplayLabel;
    CustPayment.DoEarlyPayment      := DoEarlyPayment;
    CustPayment.GUIMode := True;
    inherited;
    lblDisableCalc.visible := False;
    CustPayment.ConfirmFromGUI := ConfirmFromGUI;
    CustPayment.Connection := TMyDacDataConnection.Create(CustPayment);
    TMyDacDataConnection(CustPayment.Connection).MyDacConnection := MyConnection;

    POSInitiated                := false;
    iBulkProcessCount           := 0;
    POSClientID                 := 0;
    POSAmount                   := 0;
    POSPayMethodID              := 0;
    POSPaymentID                := 0;
    POSPaymentMade              := false;
    tblMaster.Connection        := MyConnection;
    tblDetails.Connection       := MyConnection;
    tblguiDetails.Connection    := MyConnection;
    tblSalesDetails.Connection  := MyConnection;
    qryConnote.Connection := MyConnection;
    DiscountsApplied            := false;
//    fbAllowNotInList            := False;
    cboClientR.Selected.Text     := Commonlib.ReplaceStr(cboClientR.Selected.Text,'$',AppEnv.RegionalOptions.CurrencySymbol);
    fiOpenForSalesId            := 0;
    PaymentCard := nil;
end;

procedure TfmCustPayments.FormDestroy(Sender: TObject);
begin
  inherited;
  GrdPaymentJson.Free;
end;

procedure TfmCustPayments.cmdPrintAndEmailClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    if CustPayment.Dirty and (not CustPayment.Save) then
      exit;
    CustPayment.Connection.CommitTransaction;
    Print(CustPayment.Id, TDnmAction(Sender) = actEmail);
    Self.Close;
  finally
    EnableForm;
  end;
end;

constructor TfmCustPayments.Create(AOwner: TComponent);
begin
  inherited;
  SettingFieldTextDontAllowNulls := False;
end;

procedure TfmCustPayments.Print(const ID: Integer; EmailReport: Boolean);
var
  sSQL: string;
begin
//  sSQL := Format(' WHERE tblDeposits.PaymentID = %d', [ID]);
  sSQL := Format(' WHERE D.PaymentID = %d', [ID]);

  if EmailReport then begin
    SaveTemplateReport(CustPayment.TransType, sSQL, False, 'PDF' );
    SendReportEmail;
  end else begin
      PrintTemplateReport(CustPayment.TransType, sSQL, not AppEnv.Employee.ShowPreview, 1);
  end;
end;

procedure TfmCustPayments.RefenceNoEnter(Sender: TObject);
begin
  inherited;
//  SavedAccessLevel := AccessLevel;
//  if (OriginalAccessLevel < 5) then
//    AccessLevel := 1;
end;

procedure TfmCustPayments.RefenceNoExit(Sender: TObject);
begin
  inherited;
//  AccessLevel := SavedAccessLevel;
end;

procedure TfmCustPayments.NotesExit(Sender: TObject);
begin
  inherited;
    //Notes.text := AddDateTime(lcdOnCustPayComments, Notes.text , False);
    AddDateTime(lcdOnCustPayComments, Notes , False);
end;
procedure TfmCustPayments.btnAddDateClick(Sender: TObject);
begin
  inherited;
  //Notes.text := AddDateTime(lcdOnLoganyway, Notes.text , False);
  AddDateTime(lcdOnLoganyway, Notes.text , False);
end;

procedure TfmCustPayments.btnCardPaymentClick(Sender: TObject);
var
  CardPaymentResult: TCardPaymentResult;
begin
  inherited;

  if CustPayment.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do you want to save your changes first?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
      mrYes: if not SaveData(CardPaymentResult) then exit
             else if CardPaymentResult = cprFail then exit;
      mrNo: CustPayment.Cancel;
      mrCancel: exit;
    end;
  end;

  { NOTE: we allow user access to Card Payment details here for information only
          ie to see payment details .. NOT to prcess mayments }

  self.CommitTransaction;
  try
    DoCardPayment(TCustPayments,CustPayment.ID,5,PaymentCard);

//    if DoCardPayment(TCustPayments,CustPayment.ID,AccessLevel,PaymentCard) then begin
//      CheckCardPaymentBankAccount;
//      CustPayment.RefreshDB;
//    end
//    else begin
//      { delete the saved payment .. }
//      self.BeginTransaction;
//      CustPayment.Deleted := true;
//      if SaveData(CardPaymentResult) then begin
//        CommitTransaction;
//        Close;
//      end
//      else begin
//
//
//      end;
//    end;
  finally
    self.BeginTransaction
  end;

end;

procedure TfmCustPayments.NotesEnter(Sender: TObject);
begin
  inherited;
  Custpayment.EditDB;
  with Notes do Lines.Strings[Lines.Count - 1] := StripDateTime(Lines.Strings[Lines.Count - 1]);
end;

procedure TfmCustPayments.btnPopupClick(Sender: TObject);
var
  GatewayList: TStringList;
  BankAccountName: string;
  msg: string;
begin
  inherited;
  if AppEnv.UtilsClient.ServerModuleActive('ERPModPaymentGateway') then begin
    if (CustPayment.PayMethodName <> '') and CustPayment.PaymentMethod.IsCreditCard then begin
      GatewayList := TStringList.Create;
      try
        GatewayList.CommaText := AppEnv.UtilsClient.PayGateway.EnabledGatewayList;

        if GatewayList.Count > 0 then begin
          if not Assigned(PaymentCard) then
            PaymentCard := TCreditCard.Create;
          if GetCreditCard(PaymentCard,GatewayList,CustPayment.ClientID) then begin
            { we now have card details for payment .. }
            if CustPayment.ReferenceNo = '' then
              CustPayment.ReferenceNo := 'Card Payment';
            if PaymentCard.CardType <> '' then begin
              if CustPayment.PayMethodName <> PaymentCard.CardType then begin
                if TPaymentMethod.IDToggle(PaymentCard.CardType) > 0 then
                  CustPayment.PayMethodName := PaymentCard.CardType;
              end;
            end;
            BankAccountName := AppEnv.UtilsClient.PayGateway.BankAccountForCurrency(MyConnection.Database,PaymentCard.GatewayName,CustPayment.ForeignExchangeCode,msg);
            if BankAccountName <> '' then begin
              CustPayment.AccountID := TAccount.IDToggle(BankAccountName);
            end
            else begin
              if msg <> '' then begin
                FreeAndNil(PaymentCard);
                CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
              end;
            end;


            exit;
          end
          else begin
            FreeAndNil(PaymentCard);
          end;
        end
        else begin
          CommonLib.MessageDlgXP_Vista('There are currently no Payment Gateways enabled to handle this payment.' + #13#10 + #13#10 +
          'Please open Preferences and check the Payment Gatway settings in the EDI and Integration section.',mtInformation,[mbOk],0);
        end;

      finally
        GatewayList.Free;
      end;

      exit;
    end
    else
      FreeAndNil(PaymentCard);
  end;

  BankAccountName := CustPayment.BankAccountName;
  BankAccountBSB  := CustPayment.BankAccountBSB;
  BankAccountNo   := CustPayment.BankAccountNo;
  ChequeNumber    := CustPayment.ReferenceNo;

  if Empty(BankAccountName) and Empty(BankAccountBSB) and Empty(BankAccountNo) and Empty(ChequeNumber) then begin
    BankAccountName   := cboClientlookup.FieldByName('BankAccountName').AsString;
    BankAccountBSB    := cboClientlookup.FieldByName('BankAccountBSB').AsString;
    BankAccountNo     := cboClientlookup.FieldByName('BankAccountNo').AsString;
    ChequeNumber      := '';
  end;

  with TPaymentChequeDetails.Create(self) do begin
    ClientID            := cboClientLookup.FieldByName('ClientID').AsInteger;
    ChequeBankAccountName:= CustPayment.BankAccountName;
    ChequeBankAccountBSB := CustPayment.BankAccountBSB;
    ChequeBankAccountNo  := CustPayment.BankAccountNo;
    ChequeChequeNumber   := CustPayment.ReferenceNo;

    if (ShowModal = mrOk) then begin
      if CustPayment.client.BankAccountBSB = '' then
          if BankAccountBSB <> '' then
              CustPayment.client.BankAccountBSB := BankAccountBSB;
      if CustPayment.client.BankAccountNo = '' then
          if BankAccountNo <> '' then
              CustPayment.client.BankAccountNo := BankAccountNo;
      if CustPayment.client.BankAccountName = '' then
          if BankAccountName <> '' then
              CustPayment.client.BankAccountName := BankAccountName;
      CustPayment.client.PostDB;
    End;
    CustPayment.BankAccountName := BankAccountName;
    CustPayment.BankAccountBSB  := BankAccountBSB;
    CustPayment.BankAccountNo   := BankAccountNo;
    CustPayment.ReferenceNo     := ChequeNumber;
    CustPayment.PostDB;
  end;
end;

procedure TfmCustPayments.UseAccNoClick(Sender: TObject);
//var
//    TempText: string;
//    Searchfield :String;
//    Displayfield:String;
//
begin
//  DisableForm;
//  try
//    inherited;
//    TempText := cboClientR.Text;
//    cboClientLookup.Close;
//    if not InAccountNoMode then begin
//        Label1.Caption :='Customer Account No';
//        cboclientLookUp.SQL.text := AnsiReplaceStr(cboclientLookUp.SQL.text , ' GROUP BY ClientID ORDER BY C.Company' ,'AND ifnull(C.ClientNo,"") <> ""  GROUP BY ClientID ORDER BY C.Company;');
//        Searchfield := 'company';
//        Displayfield:= 'clientNo';
//    end else begin
//        Label1.Caption := 'Customer / Job';
//        cboclientLookUp.SQL.text := AnsiReplaceStr(cboclientLookUp.SQL.text , 'AND ifnull(C.ClientNo,"") <> ""  GROUP BY ClientID ORDER BY C.Company;' , ' GROUP BY ClientID ORDER BY C.Company;');
//        Searchfield := 'clientNo';
//        Displayfield:= 'company';
//    end;
//    cboClientLookup.Open;
//    if not InAccountNoMode then
//         cboClientR.Selected.Insert(0,'ClientNo' + #9 + '5' + #9 + 'Account No' + #9 + 'F' + #9)
//    else cboClientR.Selected.Delete(0);
//
//    Application.ProcessMessages;
//    if cboClientLookup.Locate(searchField, TempText, [loCaseInsensitive, loPartialKey]) and not Empty(TempText) then begin
//        cboClientR.Text := cboClientLookup.FieldByName(Displayfield).AsString;
//        cboClientR.LookupValue := cboClientLookup.FieldByName('ClientID').AsString;
//        cboClientR.Value := cboClientLookup.FieldByName('ClientID').AsString;
//    end else begin
//        cboClientR.Clear;
//        cboClientR.LookupValue := '';
//        cboClientR.Value := '';
//        cboClientR.Text := '';
//        cboClientRCloseUp(cboClientR, cboClientR.lookupTable, cboClientR.DataSource.DataSet, True);
//    end;
//
//    InAccountNoMode := not(InAccountNoMode);
//  finally
//    EnableForm;
//  end;
end;

procedure TfmCustPayments.cboClientlookupAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TFloatField(cboClientLookup.FieldByName('Balance')).currency := True;
  if (CustPayment.ClientID <> 0) and (CustPayment.ClientID <> cboClientlookupClientID.asInteger) then
    cboClientlookup.Locate('ClientID' ,CustPayment.ClientID , []);
end;

procedure TfmCustPayments.cboPaymentMethodCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if cboPaymentMethod.Text = '' then Exit;
  if cboPaymentMethod.Text = 'Cheque' then begin
    btnPopup.Click;
    Application.ProcessMessages;
  end;
end;

procedure TfmCustPayments.btnReconciledClick(Sender: TObject);
begin
  inherited;
  PaymentsLibGUI.ShowReconciledListForm(CustPayment.ID, CustPayment.TransType);
end;


procedure TfmCustPayments.btnDepositClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormModal('TCustPaymentDepositListGUI' , nil, initDepositedList);
  //OpenERPListForm('TCustPaymentDepositListGUI' , initDepositedList , AfterDepositedList);
  //PaymentsLibGUI.ShowDepositedListForm(CustPayment.ID);
end;
procedure TfmCustPayments.initDepositedList(Sender: TObject);
begin
  if sender is TCustPaymentDepositListGUI then begin
    TCustPaymentDepositListGUI(Sender).SearchMode:= smFullList;
    TCustPaymentDepositListGUI(Sender).paymentId :=CustPayment.ID;
    TCustPaymentDepositListGUI(Sender).UpdateCustPayDepositFlag := AfterDepositedList;
  end;
end;
procedure TfmCustPayments.AfterDepositedList(Sender: TObject);
var
  fi:Integer;
begin
  if sender is TCustPaymentDepositListGUI then begin
    TCustPaymentDepositListGUI(Sender).ListActiveDeposits;
    if TCustPaymentDepositListGUI(Sender).qrymain.recordcount >0 then
      if CustPayment.deposited =False then begin
        if (accesslevel <= 3) or CustPayment.userLock.lock('tbldeposits' , CustPayment.ID) then begin
          if MessageDlgXP_Vista('This Payment is Already Deposited.'+NL+
                                'This Will Save Current Changes and will Flag as Deposited.'+NL+NL+
                                'Do you wish to continue?', mtconfirmation, [mbyes,mbno], 0) = mrno then exit;
          self.CommitTransaction;
          try
            try
              fi := CustPayment.Accessmanager.accesslevel;
              CustPayment.Accessmanager.accesslevel := 1;
              try
                CustPayment.Deposited := True;
                CustPayment.PostDB;
                CustPayment.Dirty := False;
              finally
                CustPayment.Accessmanager.accesslevel := fi;
              end;
            Except
              on E:Exception do begin
                CustPayment.executeSQL('udpate tbldeposits set Deposited ="T" where PaymentID = ' + inttostr(CustPayment.ID) , True);
                MessageDlgXP_Vista('This Payment is Already Deposited, Flagging it as deposited.', mtInformation, [mbOK], 0);
              end;
            end;
          finally
            cmdsave.enabled := False;
            self.BeginTransaction
          end;
        end else begin
          MessageDlgXP_Vista('Customer Payment #' + inttostr(CustPayment.ID) +
                             ' is already Deposited.'+NL+
                             'Please Close all Forms and Open Customer Payment  #' + inttostr(CustPayment.ID) +' from the Customer Payment List and Choose "Deposit".', mtInformation, [mbOK], 0);

        end;
      end;
  end;
end;

procedure TfmCustPayments.ApplyTransactionSelection(GrdTransactionSelection:TwwDBGrid);
var
  i:Integer;
begin
  if Custpayment.GuiLines.count >0 then exit;
  TERPQuery(GrdTransactionSelection.datasource.dataset).Disablecontrols;
  try
      Custpayment.DisableCalcOrderTotals := true;
      try
          for i := 0 to GrdTransactionSelection.SelectedList.Count - 1 do begin
              TERPQuery(GrdTransactionSelection.Datasource.dataset).GoToBookmark(GrdTransactionSelection.SelectedList.Items[i]);
              with TGuiCustPaymentLines(Custpayment.GuiLines) do begin
                  New;
                  //ID                         := GrdTransactionSelection.Datasource.dataset.Fieldbyname('ID').asinteger;
                  Try TransType                  := GrdTransactionSelection.Datasource.dataset.Fieldbyname('Type').asString;                          Except  on E:Exception do begin logtext(E.message);end;End;
                  Try ClientName                 := GrdTransactionSelection.Datasource.dataset.Fieldbyname('CustomerName').asString;                  Except  on E:Exception do begin logtext(E.message);end;End;
                  Try TransDate                  := GrdTransactionSelection.Datasource.dataset.Fieldbyname('SaleDate').asDatetime;                    Except  on E:Exception do begin logtext(E.message);end;End;
                  Try GlobalRef                  := GrdTransactionSelection.Datasource.dataset.Fieldbyname('GlobalRef').asString;                     Except  on E:Exception do begin logtext(E.message);end;End;
                  Try TransNumber                := GrdTransactionSelection.Datasource.dataset.Fieldbyname('InvoiceDocNumber').asString;              Except  on E:Exception do begin logtext(E.message);end;End;
                  Try TransID                    := GrdTransactionSelection.Datasource.dataset.Fieldbyname('SaleID').asInteger;                       Except  on E:Exception do begin logtext(E.message);end;End;

                  Try AmountDue                  := GrdTransactionSelection.Datasource.dataset.Fieldbyname('Balance').asFloat;                        Except  on E:Exception do begin logtext(E.message);end;End;
                  Try AmountOutstanding          := GrdTransactionSelection.Datasource.dataset.Fieldbyname('AmountOutstanding').asFloat;              Except  on E:Exception do begin logtext(E.message);end;End;

                  Try ForeignExchangeCode        := GrdTransactionSelection.Datasource.dataset.Fieldbyname('ForeignExchangeCode').asString;           Except  on E:Exception do begin logtext(E.message);end;End;
                  Try ForeignExchangeRate        := GrdTransactionSelection.Datasource.dataset.Fieldbyname('ForeignExchangeRate').asFloat;            Except  on E:Exception do begin logtext(E.message);end;End;
                  Try ForeignOriginalAmt         := GrdTransactionSelection.Datasource.dataset.Fieldbyname('ForeignTotalAmount').asfloat;             Except  on E:Exception do begin logtext(E.message);end;End;
                  Try ForeignAmountDue           := GrdTransactionSelection.Datasource.dataset.Fieldbyname('ForeignBalanceAmount').asFloat;           Except  on E:Exception do begin logtext(E.message);end;End;
                  Try ForeignOutStanding         := GrdTransactionSelection.Datasource.dataset.Fieldbyname('ForeignAmountOutstanding').asFloat;       Except  on E:Exception do begin logtext(E.message);end;End;

                  (*              Try SplitForeignExchangeCode   := GrdTransactionSelection.Datasource.dataset.Fieldbyname('SplitForeignExchangeCode').asString;      Except  on E:Exception do begin logtext(E.message);end;End;
                  Try SplitForeignExchangeRate   := GrdTransactionSelection.Datasource.dataset.Fieldbyname('SplitForeignExchangeRate').asFloat;       Except  on E:Exception do begin logtext(E.message);end;End;
                  Try SplitForeignPayment        := GrdTransactionSelection.Datasource.dataset.Fieldbyname('SplitForeignPayment').asfloat;            Except  on E:Exception do begin logtext(E.message);end;End;*)

                  Try Discount                   := GrdTransactionSelection.Datasource.dataset.Fieldbyname('Discount').asFloat;                       Except  on E:Exception do begin logtext(E.message);end;End;
                  Try Withholding                := GrdTransactionSelection.Datasource.dataset.Fieldbyname('Withholding').asfloat;                    Except  on E:Exception do begin logtext(E.message);end;End;
                  Try Refunding                  := GrdTransactionSelection.Datasource.dataset.Fieldbyname('Refunding').asfloat;                      Except  on E:Exception do begin logtext(E.message);end;End;
                  Try RefundPercent              := GrdTransactionSelection.Datasource.dataset.Fieldbyname('RefundPercent').asfloat;                  Except  on E:Exception do begin logtext(E.message);end;End;
                  Try Applied                    := GrdTransactionSelection.Datasource.dataset.Fieldbyname('Apply').asBoolean;                        Except  on E:Exception do begin logtext(E.message);end;End;
                  (*Try IsEarlyPaymentDiscount     := GrdTransactionSelection.Datasource.dataset.Fieldbyname('IsEarlyPaymentDiscount').asBoolean;       Except  on E:Exception do begin logtext(E.message);end;End;*)
                  Try RefNo                      := GrdTransactionSelection.Datasource.dataset.Fieldbyname('RefNo').asString;                         Except  on E:Exception do begin logtext(E.message);end;End;
                      Applied                    := true;
                  PostDB;
            end;
            Application.processMessages;
          end;
      finally
         Custpayment.DisableCalcOrderTotals := False;
         Custpayment.DoCalcOrderTotals;
         TGuiCustPaymentLines(Custpayment.GuiLines).first;
         SetGridAccess;
      end;
  finally
    TERPQuery(GrdTransactionSelection.datasource.dataset).enablecontrols;
  end;
  SetFocusedcontrol(grdPayments);
end;

procedure TfmCustPayments.SendReportEmail;
var
  strSQL:STring;
  Corres: TCorrespondenceGui;
  lSilent, lSecret : boolean;
begin
  inherited;
  try
    lblEmail.Caption := 'Emailing, ' + WAITMSG;
    lblEmail.Show;
    lblEmail.Update;
    cmdNew.Enabled    := False;
    actSave.Enabled   := False;
    cmdPrint.Enabled  := False;
    btnEmail.Enabled  := False;
    cmdCancel.Enabled := False;
    Corres := TCorrespondenceGui.Create;
    try
      Corres.RecipientList := CustPayment.Client.Email;
      Corres.Subject := CustPayment.Transtype + ' #' + IntToStr(CustPayment.PaymentNo) + ' for ' + CustPayment.client.ClientName;
      Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;
      Corres.AttachmentList.Add(SystemLib.WinTempDir + 'EmailReport.PDF'); //   getOutGoingFileName('',' ' + CustPayment.TransType + ' #' + IntToStr(CustPayment.PaymentNo), '.PDF'));
      Corres.CustomerId := CustPayment.ClientID;

      if not EmailShortSendMode(lSilent, lSecret) then
        exit;

      if Corres.Execute(lSilent, lSecret) then begin
        strSQL:='INSERT HIGH_PRIORITY INTO tblEmailedReports ' +
                ' (TransactionID, UserID, Date, ReportType, TransactionDescription)  ' +
                ' Values  (' +
                    QuotedStr(IntToStr(CustPayment.PaymentNo))                           + ', ' +
                    QuotedStr(AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName)+ ', ' +
                    Quotedstr(FormatDateTime(MysqlDateFormat,Now))                    + ', ' +
                    Quotedstr(CustPayment.TransType)                                     + ', ' +
                    Quotedstr(AppEnv.CompanyInfo.Companyname + ' ' + CustPayment.TransType + ' #' + IntToStr(CustPayment.PaymentNo) + ' for ' + CustPayment.CompanyName)+ ')';
        CustPayment.getnewdataset(strSQL , false);
      end;
      DeleteFiles( Commonlib.TempDir , '*.PDF');
    finally
        Corres.Free;
        lblEmail.Hide;
        cmdNew.Enabled := True;
        //cmdSave.Enabled := True;
        actSave.Enabled := True;
        cmdPrint.Enabled := True;
        btnEmail.Enabled := True;
        cmdCancel.Enabled := True;
    end;
  except
    CommonLib.MessageDlgXP_Vista('There was an error sending the email', mtWarning, [mbOK], 0);
  end;
end;

procedure TfmCustPayments.cboClientlookupBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  (*if tblMaster.Active then
    cboClientlookup.Params.ParamByName('xClientID').asInteger := tblMaster.FieldByName('CusID').asInteger
  else
    cboClientLookup.Params.ParamByName('xClientID').asInteger := 0;*)
    //cboClientlookup.Params.ParamByName('xClientID').asInteger := CustPayment.ClientID;
end;
procedure TfmCustPayments.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
    if not CustPayment.Dirty then begin
        canclose := True;
        Exit;
    end;
    case CommonLib.MessageDlgXP_Vista('Do you wish to keep these changes you have made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
    mrYes:
        begin
          if custPayment.Save then begin
            notify(False);
            CanClose := True;
          end else Canclose := False;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          CustPayment.Dirty := false;
          CanClose := True;
          notify(True);
        end;
      mrCancel:
        begin
          CanClose := false;
        end;
    end;
end;

procedure TfmCustPayments.actSaveUpdate(Sender: TObject);
begin
  inherited;
        actSave.Enabled := (CustPayment.dirty)  and
    (((CustPayment.IsFCSelected) and IsZero(CustPayment.ForeignUnApplied, 0.00001))
        or
    ((not(CustPayment.IsFCSelected)) and SameValue(CustPayment.Applied,CustPayment.Amount,0.00001)));

end;

procedure TfmCustPayments.actPrintReceiptUpdate(Sender: TObject);
begin
  inherited;
  cmdPrint.Enabled := (CustPayment.ID <> 0);
end;

procedure TfmCustPayments.actEmailUpdate(Sender: TObject);
begin
  inherited;
  btnEmail.Enabled := (CustPayment.Id <> 0);
end;

procedure TfmCustPayments.actNewUpdate(Sender: TObject);
begin
  inherited;
    actNew.Enabled := True;
end;

procedure TfmCustPayments.actCancelUpdate(Sender: TObject);
begin
  inherited;
    ActCancel.Enabled := True;
end;

procedure TfmCustPayments.actapplyDiscountUpdate(Sender: TObject);
begin
  inherited;
  actapplyDiscount.Enabled := (CustPayment.TotalDiscount <> 0) or (CustPayment.TotalWithholding<>0) or (CustPayment.TotalRefunding<>0);
end;

procedure TfmCustPayments.actNewExecute(Sender: TObject);
var
  CardPaymentResult: TCardPaymentResult;
begin
  DisableForm;
  try
    inherited;
    if CustPayment.Dirty and (not SaveData(CardPaymentResult)) then Exit;
    if CardPaymentResult = cprFail then exit;

    CustPayment.userLock.UnlockAllCurrentInstance;

    cboClientlookup.Close;
    cboClientlookup.Open;
    CustPayment.Connection.CommitTransaction;
    CustPayment.connection.BeginTransaction;
    CustPayment.New;
    CustPayment.GuiLines;
    KeyId := 0;
    OpenForSalesId:=0;
    ManipulateRequiredControls;
    SetControlFocus(cboClientR);
    UserChangedPaymentAmount:= false;
    grdPayments.ColumnByName('Discount').Readonly := False;
  finally
    EnableForm;
  end;
  SetControlFocus(cboClientR);
end;

procedure TfmCustPayments.actSaveExecute(Sender: TObject);
var
  CardPaymentResult: TCardPaymentResult;
begin
  DisableForm;
  try
    if SaveData(CardPaymentResult) then begin
      if CardPaymentResult = cprFail then exit;

      notify(False);
      self.Close;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmCustPayments.actAddSurchargeExecute(Sender: TObject);
var
  Percent: double;
begin
  DisableForm;
  try
    //  first get surcharge
    Percent := CustPayment.TenderAccountPrefs.SurchargePercent;
    if Percent = 0 then begin
      if GetSurchargePercentage(self.CustPayment.PaymentMethod.PaymentMethodName,Percent) then begin
        if CustPayment.TenderAccountPrefs.Count = 0 then begin
          CustPayment.TenderAccountPrefs.New;
          CustPayment.TenderAccountPrefs.PayMethodID := self.CustPayment.PayMethodID;
          CustPayment.TenderAccountPrefs.AccountID := AppEnv.CompanyPrefs.DefaultCustPaymentAccount
        end;
        CustPayment.TenderAccountPrefs.SurchargePercent := Percent;
        CustPayment.TenderAccountPrefs.Active := true;
        CustPayment.TenderAccountPrefs.Save;
      end
      else
        exit;

    end;
    CustPayment.AddSurchargeToSale(Percent);
  finally
    EnableForm;
  end;
end;

procedure TfmCustPayments.actAddSurchargeUpdate(Sender: TObject);
begin
  inherited;
  if CustPayment.ClientID = 0 then  actAddSurcharge.Enabled := False
  else actAddSurcharge.Enabled := (CustPayment.TotalLinesAmount <> 0) and (CustPayment.PayMethodID > 0);
end;

procedure TfmCustPayments.actapplyDiscountExecute(Sender: TObject);
var
  msg: string;
begin
  DisableForm;
  try
    inherited;
    if not CustPayment.AddDiscountToSale(msg) then
      CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
  finally
    EnableForm;
  end;
end;

procedure TfmCustPayments.actCancelExecute(Sender: TObject);
begin
  inherited;
    Self.Close;
end;

procedure TfmCustPayments.grdPaymentsDblClick(Sender: TObject);
var
    TransForm :TBaseInputGUI;
    doRefresh: boolean;
begin
  inherited;
    doRefresh:= true;
    if (CustPayment.GUILines.TransID = 0)  Then Exit;

    if MessageDlgXP_Vista ('This will open the selected transaction for editing which will clean all the selections you have made.' + Nl +NL+'Do you wish to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
    CustPayment.userLock.unLock('tblClients', custPayment.clientID, custPayment.LockGroupname);
    try
        if Sysutils.SameText(CustPayment.GuiLines.TransType, PrePayType) then begin
          CustPayment.userLock.UnLock('tblPrePayments' , custPayment.GuiLines.TransID , custPayment.LockGroupname);
          try
            if FormStillOpen('TfmCustPrepayments') then begin
              TransForm:= TBaseInputGUI(GetComponentByClassName('TfmCustPrepayments'));
              TransForm.CloseMe;
              Application.ProcessMessages;//Don't remove it , needs to Destroy the transform before finally
            end;
            if not FormStillOpen('TfmCustPrepayments') then begin
              TransForm := TBaseInputGUI(GetComponentByClassName('TfmCustPrepayments'));
              TransForm.KeyId :=custPayment.GuiLines.TransID;
              TransForm.showmodal;
              Application.ProcessMessages;//Don't remove it , needs to Destroy the transform before finally
            end;
          finally
            CustPayment.userLock.Lock('tblPrePayments' , custPayment.GuiLines.TransID , custPayment.LockGroupname);
          end;
        end else begin
            CustPayment.userLock.unLock('tblsales' , custPayment.GuiLines.TransID , custPayment.LockGroupname);
            try
                if Sysutils.SameText(CustPayment.GuiLines.TransType , RefundType) then begin
                    if FormStillOpen('TRefundGUI') then begin
                      TransForm:= TBaseInputGUI(GetComponentByClassName('TRefundGUI'));
                      TransForm.CloseMe;
                      Application.ProcessMessages;//Don't remove it , needs to Destroy the transform before finally
                    end;
                    if not FormStillOpen('TRefundGUI') then begin
                      if CustPayment.UpdatedSalesList.InList(custPayment.GuiLines.TransID) then begin
                        MessageDlgXP_Vista('This Refund has been updated (discount or surcharge applied) so can not be opened untill payment has been saved.', mtInformation, [mbOK], 0);
                        doRefresh:= false;
                      end else begin
                        TransForm:= TBaseInputGUI(GetComponentByClassName('TRefundGUI'));
                        TransForm.KeyId :=custPayment.GuiLines.TransID;
                        TransForm.Showmodal;
                        Application.ProcessMessages;//Don't remove it , needs to Destroy the transform before finally
                      end;
                    end;
                end else if Sysutils.SameText(CustPayment.GuiLines.TransType , InvType) then begin
                    if FormStillOpen('TInvoiceGUI') then begin
                      TransForm:= TBaseInputGUI(GetComponentByClassName('TInvoiceGUI'));
                      TransForm.CloseMe;
                      Application.ProcessMessages;//Don't remove it , needs to Destroy the transform before finally
                    end;
                    if not FormStillOpen('TInvoiceGUI') then begin
                      if CustPayment.UpdatedSalesList.InList(custPayment.GuiLines.TransID) then begin
                        MessageDlgXP_Vista('This Invoice has been updated (discount or surcharge applied) so can not be opened untill payment has been saved.', mtInformation, [mbOK], 0);
                        doRefresh:= false;
                      end
                      else begin
                        TransForm:= TBaseInputGUI(GetComponentByClassName('TInvoiceGUI'));
                        TransForm.KeyId :=custPayment.GuiLines.TransID;
                        TransForm.showmodal;
                        Application.ProcessMessages;//Don't remove it , needs to Destroy the transform before finally
                      end;
                    end;
                end;
            finally
                CustPayment.userLock.Lock('tblsales' , custPayment.GuiLines.TransID , custPayment.LockGroupname);
            end;
        end;
    finally
        CustPayment.userLock.Lock('tblClients', custPayment.clientID, custPayment.LockGroupname);
        if doRefresh then
          CustPayment.RefreshguiLines;
    end;
end;

procedure TfmCustPayments.cboForeignCurrencyCodeCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  ManipulateFCControls;
end;
procedure TfmCustPayments.DoEarlyPayment(var Msg: TMessage);
begin
    if CustPayment.UpdatedSalesList.InList(CustPayment.GuiLines.TransID) then
      exit;

    TGuiCustPaymentLines(CustPayment.GuiLines).PostDB;
    TGuiCustPaymentLines(CustPayment.GuiLines).EarlyPayment;
    grdPayments.RefreshDisplay;
end;
procedure TfmCustPayments.DoEarlyPayment;
begin
    PostMessage(self.Handle, EARLY_PAYMENT, 0,0)
end;
procedure TfmCustPayments.ArrangeColWidth;
var
    ctr:Integer;
    TotColwidth:Integer;
begin
    grdPayments.columnbyname('Type').DisplayWidth                       := 10;
    grdPayments.columnbyname('SaleDate').DisplayWidth                   := 10;
    grdPayments.columnbyname('InvoiceDocNumber').DisplayWidth           := 10;
    grdPayments.columnbyname('OriginalAmount').DisplayWidth             := 8;
    grdPayments.columnbyname('ForeignOriginalAmt').DisplayWidth         := 8;
    grdPayments.columnbyname('Balance').DisplayWidth                    := 8;
    grdPayments.columnbyname('ForeignBalanceAmount').DisplayWidth       := 8;
    grdPayments.columnbyname('Payment').DisplayWidth                    := 8;
    grdPayments.columnbyname('ForeignPayment').DisplayWidth             := 8;
    grdPayments.columnbyname('Apply').DisplayWidth                      := 8;
    grdPayments.columnbyname('AmountOutstanding').DisplayWidth          := 8;
    grdPayments.columnbyname('ForeignAmountOutstanding').DisplayWidth   := 8;
    grdPayments.columnbyname('Discount').DisplayWidth                   := 8;
    grdPayments.columnbyname('ForeignExchangeRate').DisplayWidth        := 8;
    grdPayments.columnbyname('RefNo').DisplayWidth                      := 10;

    if Custpayment.ISFCSelected then Exit;

    TotColwidth := 0;
    for ctr := 0 to grdPayments.GetColCount-1 do
            TotColwidth:= TotColwidth + grdPayments.columnbyname(grdPayments.columns[ctr].FieldName).DisplayWidth ;
    while TotColwidth < 120 do
        for ctr := 0 to grdPayments.GetColCount-1 do begin
            if TotColwidth < 120 then begin
                grdPayments.columnbyname(grdPayments.columns[ctr].FieldName).DisplayWidth := grdPayments.columnbyname(grdPayments.columns[ctr].FieldName).DisplayWidth +1;
                TotColwidth:= TotColwidth + 1;
            end
            else
              break;
        end;
end;

procedure TfmCustPayments.grdPaymentsEnter(Sender: TObject);
begin
  inherited;
    CustPayment.PostDB;
end;

procedure TfmCustPayments.grdPaymentsCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if CustPayment.ClientID=0 then exit;
    if CustPayment.GUILines.ForeignExchangeCode = CustPayment.ForeignExchangeCode then
        Afont.color := clblack
    else afont.color := clgray;

    If tblGuiDetailsApply.asBoolean then
      ABrush.Color := $00C4FFE1;

end;

procedure TfmCustPayments.chkDeletedClick(Sender: TObject);
begin
  inherited;
  if (Sender = chkDeleted) and (CustPayment.Deleted <> chkDeleted.checked) then begin
    CustPayment.Deleted := chkDeleted.checked;
    cmdSave.Enabled := True;
  end;
end;
procedure TfmCustPayments.SetForeignFieldDisplayFormat;
var
  fmt: string;
begin
  fmt:= TCurrency.CurrencySymbolForCode(self.CustPayment.ForeignExchangeCode, self.MyConnection);
  fmt:= fmt + '#,##0.00';
  if tblSalesDetails.Active then begin
    tblSalesDetailsForeignPaidAmount.DisplayFormat:= fmt;
    tblSalesDetailsForeignBalanceAmount.DisplayFormat:= fmt;
  end;
  if tblGuiDetails.Active then begin
    tblGuiDetailsForeignOriginalAmt.index       := tblGuiDetails.fields.count;
    tblGuiDetailsForeignBalanceAmount.index     := tblGuiDetails.fields.count;
    tblGuiDetailsForeignPayment.index           := tblGuiDetails.fields.count;
    tblGuiDetailsForeignAmountOutstanding.index := tblGuiDetails.fields.count;

    tblGuiDetailsForeignOriginalAmt.DisplayFormat       := fmt;
    tblGuiDetailsForeignBalanceAmount.DisplayFormat     := fmt;
    tblGuiDetailsForeignPayment.DisplayFormat           := fmt;
    tblGuiDetailsForeignAmountOutstanding.DisplayFormat := fmt;
  end;
  if tblMaster.Active then begin
    tblMasterForeignCurrencyAmount.DisplayFormat:= fmt;
    tblMasterForeignApplied.DisplayFormat:= fmt;
    tblMasterForeignUnApplied.DisplayFormat:= fmt;
  end;
end;

procedure TfmCustPayments.tblGuiDetailsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  lblDisableCalc.visible := CustPayment.GUILines.count > appenv.CompanyPrefs.CustPayLinesToDisableCalcs;
end;

procedure TfmCustPayments.tblGuiDetailsConNoteGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := Sender.AsString;
//
end;

procedure TfmCustPayments.txtAmountChange(Sender: TObject);
begin
  inherited;
  if Assigned(LastActiveControl) and (LastActiveControl = txtAmount) then
    UserChangedPaymentAmount:= true;
  if txtAmount.Text = '' then
    txtAmount.Text:= '0';
end;

procedure TfmCustPayments.FeldSetTextDontAllowNulls(Sender: TField;
      const Text: String);
begin
  if SettingFieldTextDontAllowNulls  then Exit;
  SettingFieldTextDontAllowNulls:= True;
  try
    inherited;
    EditDB(sender.dataset);
    if text = '' then
      Sender.AsString:= '0'
    else
      Sender.AsString:= text;
  finally
    SettingFieldTextDontAllowNulls := False;
  end;
end;

procedure TfmCustPayments.ForeignAmountChange(Sender: TObject);
begin
  inherited;
  if Assigned(LastActiveControl) and (LastActiveControl = ForeignAmount) then
    UserChangedPaymentAmount:= true;
end;

procedure TfmCustPayments.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  LastActiveControl:= self.ActiveControl;
end;

function TfmCustPayments.SaveData(var CardPaymentResult: TCardPaymentResult): boolean;
var
  ProcessCardPayment: boolean;
  msg: string;
begin
  result:= false;
  if lblDisableCalc.visible then lblDisableCalcClick(lblDisableCalc);
  CardPaymentResult := TCardPaymentResult.cprNotCardPayment;
//  if AccessLevel = 5 then begin
//    result := true;
//    CustPayment.PostDb;
//    CustPayment.Connection.CommitTransaction;
//    CustPayment.Dirty := false;
//    Exit;
//  end;
  if (CustPayment.Amount < 0) then begin
    if MessageDlgXP_Vista('The payment amount is a negative value, ' +
      'do you wish to Save this payment anyway?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
      exit;
  end;
  CustPayment.UpdateFCHistory;
  if (CustPayment.TotalDiscount <> 0) or (CustPayment.TotalWithholding <>0) or (CustPayment.TotalRefunding <>0) then begin
      if commonlib.MessageDlgXP_Vista('Do you wish to apply the Discounts/Withholding/Refunding? ' , mtConfirmation , [mbYes, mbNo], 0) = mrYes then begin
        if not  CustPayment.AdddiscounttoSale(msg) then begin // if discount/withholding exists, the payment should not be saved
          CommonLib.MessageDlgXP_Vista(msg, mtInformation, [mbOk],0);
        end;
      end;
      Exit;
  end;


  if POSInitiated then begin
    POSPaymentMade:= True;
    POSAmount     := CustPayment.amount;
    POSPayMethodID:= CustPayment.PayMethodID;
    POSPaymentID  := CustPayment.ID;
  end;

  if CustPayment.Save then begin
    CustPayment.Connection.CommitTransaction;
    result:= true;
    ProcessCardPayment := false;

    if (not CustPayment.Deleted) then begin
      if Assigned(PaymentCard) then begin
        ProcessCardPayment := true;
      end
      else if AppEnv.UtilsClient.PayGateway.Installed and
        (CustPayment.PayMethodName <> '') and CustPayment.PaymentMethod.IsCreditCard and
        (AppEnv.UtilsClient.PayGateway.EnabledGatewayList <> '') then begin
        ProcessCardPayment := true;
      end;
      if ProcessCardPayment then begin
        { process the CC payment through the gaateway }
        if DoCardPayment(TCustPayments,CustPayment.ID,AccessLevel,PaymentCard) then begin
          CardPaymentResult := TCardPaymentResult.cprSuccess;
          { check bank account .. }
          CheckCardPaymentBankAccount;
        end
        else begin
          CardPaymentResult := TCardPaymentResult.cprFail;
          self.BeginTransaction;
          CustPayment.Deleted := true;
          CustPayment.Save;
          self.CommitTransaction;
          self.KeyID := CustPayment.ID;
          ManipulateRequiredControls;
        end;
      end;
    end;

  end;
end;

procedure TfmCustPayments.UnlockRelatedTables;
begin
  inherited;
  UserLock.Unlock(custPayment.Lockgroupname );
end;

procedure TfmCustPayments.grdPaymentsTitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  inherited;
  if AFieldName = 'Apply' then begin
      {$IFDEF DevMode}
      CustPayment.GUILines.DoFieldChangewhenDisabled:= true;
      try
        CustPayment.GUILines.IterateRecords(ApplyCallback);
      finally
          CustPayment.GUILines.DoFieldChangewhenDisabled:= False;
      end;
      {$ENDIF}
  end;
end;

procedure TfmCustPayments.InitERPLookupCombonFields;
begin
  inherited;
  if tblmaster.active then
       NamenPrintNameGridObj.ClientLookupQueryWithSearchengine(CustPayment.clientId,  cboclientR,False, True, False, True, true, 'ClientPrintName' , nil, True)
  else NamenPrintNameGridObj.ClientLookupQueryWithSearchengine(0                   ,  cboclientR,False, True, False, True, true, 'ClientPrintName' , nil, True);

end;

procedure TfmCustPayments.InitGuiPrefsReadonlyFields;
begin
  inherited;
  guiprefs.AddreadonlyField('Type'                    , tblguiDetails);
  guiprefs.AddreadonlyField('SaleDate'                , tblguiDetails);
  guiprefs.AddreadonlyField('InvoiceDocNumber'        , tblguiDetails);
  guiprefs.AddreadonlyField('OriginalAmount'          , tblguiDetails);
  guiprefs.AddreadonlyField('ForeignOriginalAmt'      , tblguiDetails);
  guiprefs.AddreadonlyField('Balance'                 , tblguiDetails);
  guiprefs.AddreadonlyField('ForeignBalanceAmount'    , tblguiDetails);
  guiprefs.AddreadonlyField('AmountOutstanding'       , tblguiDetails);
  guiprefs.AddreadonlyField('ForeignAmountOutstanding', tblguiDetails);
  guiprefs.AddreadonlyField('ForeignExchangeRate'     , tblguiDetails);
  guiprefs.AddreadonlyField('RefNo'                   , tblguiDetails);
end;

procedure TfmCustPayments.lblDisableCalcClick(Sender: TObject);
begin
  inherited;
  CustPayment.CalcTotals;
end;

{$IFDEF DevMode}
procedure TfmCustPayments.ApplyCallback(const Sender: TBusObj;
  var Abort: Boolean);
begin
  TGuiCustPaymentLines(Sender).Applied := true;
  TGuiCustPaymentLines(Sender).PostDB;
end;
{$ENDIF}
(*procedure TfmCustPayments.SelectAllCallback(Const Sender: TBusObj; var Abort: Boolean);
begin
    CustPayment.guilines.Applied := true;
    CustPayment.guilines.PostDb;
end;*)
procedure TfmCustPayments.btnSelectallClick(Sender: TObject);
begin
  CustPayment.SelectAll;
(*  CustPayment.SelectingAll := true;
  try
    CustPayment.guilines.Iteraterecords(SelectAllCallback);
  finally
    CustPayment.SelectingAll := False;
  end;*)
(*var
  bm: TBookmark;
begin
  inherited;
  bm:= tblGuiDetails.GetBookmark;
  try
    tblGuiDetails.First;
    while not tblGuiDetails.EOF do begin
      EditDb(tblGuiDetails);
      tblGuiDetails.FieldByName('Apply').AsBoolean:= true;
      PostDb(tblGuiDetails);
      tblGuiDetails.Next;
    end;
  finally
    tblGuiDetails.GotoBookmark(bm);
  end;*)
end;
procedure TfmCustPayments.ChooseCustomer(aclientID: Integer; acompanyname:String );
begin
  if aclientID =0 then exit;
    Closedb(cboClientlookup);
    cboClientlookup.Parambyname('SearchValue').asString :=  acompanyname;
    opendb(cboClientlookup);
    if cboClientlookup.locate('clientID', aclientID , []) then begin
      cboclientR.text :=cboClientlookupcompany.asString;
      CustPayment.ClientID := aclientID;
      CustPayment.CompanyName :=cboClientlookupcompany.asString;
      cboClientR.Text :=cboClientlookupcompany.asString;
      CustPayment.PostDB;
      (*cboClientRCloseUp(cboclientR,
                        cboClientlookup,
                        tblMaster,True);*)
      Setcontrolfocus(cboForeignCurrencyCode);
      Application.processMessages;
    end;
end;

procedure TfmCustPayments.ChooseForeignExchangeCode(aFXCode: String);
begin
  if aFXCode <> '' then begin
    closedb(qryForeignCurrency);
    qryForeignCurrency.sql.text := 'SELECT CurrencyID, Country, Currency, Code, BuyRate , Active  FROM tblcurrencyconversion where Code = ' + quotedstr(aFXCode);
    opendb(qryForeignCurrency);
    if qryForeignCurrency.locate('Code' , aFXCode , []) then begin
        CustPayment.ForeignExchangeCode := qryForeignCurrency.Fieldbyname('Code').asString;
        CustPayment.PostDB;
        ManipulateFCControls;
        cboForeignCurrencyCode.Text :=qryForeignCurrency.Fieldbyname('Code').asString;
        (*cboForeignCurrencyCodeCloseUp(cboForeignCurrencyCode,
                                      qryForeignCurrency,
                                      tblMaster,True);*)
        Setcontrolfocus(grdPayments);
        application.processmessages;
    end;
  end;
end;

initialization
  RegisterClassOnce(TfmCustPayments);

  with FormFact do begin
    RegisterMe(TfmCustPayments, 'TPaymentsofDeletedsalesGUI_*=PaymentID');
    RegisterMe(TfmCustPayments, 'TCustPaymentListGUI_*=PaymentID');
    RegisterMe(TfmCustPayments, 'TCustPaymentListDettailsGUI_*=PaymentID');
    RegisterMe(TfmCustPayments, 'TStatementListGUI_*_Payment=Receipt #');
    RegisterMe(TfmCustPayments, 'TBankAccountListGUI_*_Customer Payment=PaymentID');
    RegisterMe(TfmCustPayments, 'TCashProfitandLossGUI_*_Customer Payment=PaymentId');
    RegisterMe(TfmCustPayments, 'TBalTransListGUI_*_Customer Payment=PaymentID');
    RegisterMe(TfmCustPayments, 'TToBeReconciledGUI_*_Customer Payment=PaymentID');
    RegisterMe(TfmCustPayments, 'TReconListDetailFormGUI_*_Customer Payment=PaymentID');
    RegisterMe(TfmCustPayments, 'TTrialBalTransListGUI_*_Customer Payment=PaymentID');
    RegisterMe(TfmCustPayments, 'TTransactionListGUI_*_Customer Payment=PaymentID');
    RegisterMe(TfmCustPayments, 'TBASTransReturnListGUI_*_Customer Payment=PaymentID');
    RegisterMe(TfmCustPayments, 'TNZTransReturnListGUI_*_Customer Payment=PaymentID');
    RegisterMe(TfmCustPayments, 'TVATTransReturnListGUI_*_Customer Payment=PaymentID');
    RegisterMe(TfmCustPayments, 'TGlobalsearchGUI_*_Customer Payment=PaymentID');
    RegisterMe(TfmCustPayments, 'TTransAccountDetailsGUI_*_Customer Payment=PaymentID');
    RegisterMe(TfmCustPayments, 'TCustomerBalanceDetailGUI_*_Customer Payment=PaymentID');
    RegisterMe(TfmCustPayments, 'TGeneralLedgerReportGUI_*_Customer Payment=PaymentID');
    RegisterMe(TfmCustPayments, 'TTransPaymentListGUI_*_Customer Payment=PaymentID');
    //RegisterMe(TfmCustPayments, 'TTransPaymentListGUI_*_Customer Prepayment=PaymentID');
    RegisterMe(TfmCustPayments, 'TCashBasisDetailsGUI_*_Customer Payment=PaymentID');
    RegisterMe(TfmCustPayments, 'TAllTransactionGUI_*_Customer Payment=TransNo');
    RegisterMe(TfmCustPayments, 'TAccountsReceiveListGUI_*_Customer Payment=SaleID');
    RegisterMe(TfmCustPayments, 'TPaymentListGUI_*_'+CUSTOMER_PAYMENT+'=PaymentID');
  end;
end.






