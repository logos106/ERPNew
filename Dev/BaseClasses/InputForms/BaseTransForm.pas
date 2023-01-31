unit BaseTransForm;
{

Basetrans
  - Cash
    - Refund
      - Customer Return
    - CashSalebase
      - quickOPos
      - CashSale
      - Layby
      - PosCashSale
      - Voucher
  - Sales
    - invoice
    - sales Order
    - Quote
    - Voucherinvoice
  - Order
    - PurchaseOrder
    - RA
  - Expenses
    - Cheque
    - Bill
    - Credit

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 16/03/05  1.00.01 IJB Changed to call BeginTransaction and RollbackTransaction
                       from BaseInput to put both ADO and MyDac in trans.
 23/03/05  1.00.02 IJB Added AfterCommit virtual method.
 03/05/05  1.00.03 BJ  SaveTransaction: changed the 'if fbPayrmnyloc..' to
                       'if not fbpaymentlock...' to update the printedby field.
 16/05/05  1.00.04 IJB Removed RefreshCalcs call in btnDeleteClick event as
                       this was causing inorrect foreign currency calc in sales.
 27/05/05  1.00.05 BJ  cboclinetOncloseup :Tryinf to locate for the cbo.text
                       in the llouptable.company andif nt found, it is invalid.
                       Changed this locate to 'lopartialKey'. When the Repair
                       is invoiced, the client name is in the format of
                       company^JobName. The data is trimmed off to company
                       name's width in such a case the company^JobName will
                       not findan exact match.
 24/06/05  1.00.06 BJ  A new field is added in the saleslines table. This field
                       is used to track the creation date of the back order.
                       Function 'PrepareBODetailsParameters' is moving the
                       Value to this field from the original salesline -
                       only if it is invoiceform.
 30/06/05  1.00.07 IJB Enabled new UserLock object introduced into BaseInput.
 06/07/05  1.00.08 DMS 1. Formatted unit's source code.
                       2. Modified cboClientCloseUp event when default data
                          will be applied if tblmaster is not in browse mode.
 12/07/05  1.00.09 DSP Added 'Abs' for summing the shipping field in the
                       method TotalBackOrder
 22/07/05  1.00.10 IJB Modified UserLock behaviour.
 26/07/05  1.00.11 IJB Removed use of AuditObj.
 28/07/05  1.00.12 IJB Removed client from User Locking, decendant forms
                       should only lock client if they need to update client
                       data eg on Save.
 04/08/05  1.00.12 IJB Changed UpdateCombinedBOID to use ADO & form connection
                       to prevent lock timeouts when converting BOSO to Inv
                       (only when user chabges line data then concerts).
 12/08/05  1.00.13 BJ  Serialno object inroduced
 29/08/05  1.00.14 DSP Added (F6) to 'Company Search Filter'.
 01/08/05  1.00.14 DSP Added check that creation date is after closing date on
                       form activate.
 06/09/05  1.00.15 DSP Added check for KeyID being non-zero before creation date
                       is verified.
 07/09/05  1.00.16 ISB Bug With Disabled Controls In New Button Click
 16/09/05  1.00.17 MV  Added GuiPrefsObj to support customisation of grdTransactions
                       component.
 19/09/05  1.00.18 DSP cboCreationDateExit is now only called if
                       cboCreationDate.OnExit is assigned.
 23/09/05  1.00.19 BJ  assignOrigValues was creating the memory tbale only of the
                        table is in dsEditmode. When the form is opened in RO mode
                        the table will not be in dsEdit, but need to store it for
                        'Copy to Invoice' eg:Sales Order
 29/09/05  1.00.20 IJB Various changes to allow removal of child froms from uses
                       clause;
 12/12/05  1.00.21 BJ  AssignOrigValues is not required for invoice but PO still
                        requires the memory table - so storing it only if PO
 04/01/06  1.00.22 AL  Added new search like mode (changes in FormKeyUP - VK_F7)
 17/01/06  1.00.23 DSP 1. Implemented the use of GuiPrefs for customising the
                          fields of the grid.
                       2. Modified the way fields are switched when the title
                          button of the grid is pressed.
 18/01/06  1.00.24 DSP Added calls to GuiPrefs of AddFieldPair.
 25/01/06  1.00.25 DSP 1. Added the watermark 'Right-click for options' to the grid
                          when is first displayed.
                       2. The 'Save' button was not being enabled when a
                          'Copy to ...' occurred from another form. This has
                          been fixed.
 31/01/06  1.00.26 DSP The TX_GridPaint message has been added to allow a
                       the watermark to be painted on the grid of all
                       descendants of this form.
 31/01/06  1.00.27 IJB Changed LoadTemplate to use the new "Credit Return"
                       template for negative purchase orders.
 31/01/06  1.00.28 DSP Added the fPaintTimer field as the watermark image was
                       not being displayed on all descendant forms.
 09/02/06  1.00.29 DSP Moved handling of grid customisation and the drawing of
                       the grid watermark to the BaseInputForm unit.
 17/02/06  1.00.30 DSP Removed redundant 'GuiPrefs.Active := True' statement.
 07/04/06  1.00.31 DSP Removed 'Application.ProcessMessages' statement from
                       grdTransactionsExit.
 28/04/06  1.00.32 DSP Added check for TReturnAGUI class in FormShow to prevent
                       missing ForeignExchangeCode field error.
 09/05/06  1.00.33 DSP Moved SetActiveField from the beginning of
                       grdTransactionsTitleButtonClick to the end and also
                       tested if the active field already matched the specified
                       AFieldName.
 11/05/06  1.00.34 DSP Added test for fsShowing in btnCloseClick.
 14/08/06  1.00.35 BJ  FormActivate was checking for the salesdate/Orderdate against the companypref.closing date
                       Opening an old record prior to the Closingdates should open [the form without
                       this validation] as reaconly - Applicable for all descendants.
                       AssignOrigValues :stores the data into the memory table - which was done for
                       PurchaseOrder too. PO doesn't need it as it uses object.
 15/08/06  1.00.36 BJ  only applicable for the forms with businessobjects
                       Saving a record uses object of TBalancePostList to update the ralated tables
                       These tables are locked at the time of saving and should be released once the transaction is commited/rolled back
                       formconnection's aftercommit and afterrollback releases the related tables from lock
 25/08/06 1.00.37 BJ   AssignOrigValues : this was done only for returnA and Bill, but as the other
                       forms are not using busobj at the moment I think should be there for all
                       those forms. Refund was causing problem
 29/08/06 1.00.38 BJ   Commented the BackOrder related coding as all the transactions with BackOrder
                       (Purchase order , invoice and salesorder) are using objects
 23/01/07 1.00.39 BJ   ShowStatus function and the label for the message is moved into
                       this baseform from the purchaseorder and all transactions using it.
                       Readonly fields are displayed as grayed -
                       basically for a SO/invoice with a group buid record associated with it
 06/02/07 1.00.40 DSP  Added method grdTransactionsColEnter to automatically
                       pop-up the 'Ordering Matrix' form when the 'Ordered'
                       field is entered by the user.
 20/04/07 1.00.41 IJB  Added code to prevent calling of SetTerms if cass is TPurchaseGUI,
                       terms calcualtions are handled by PO business object logic.
}

{$I ERP.inc}
interface

Uses TypesLib,
  Windows, Forms, SysUtils, Dialogs, DateUtils, DB,   wwdblook,
  DBCtrls, wwdbdatetimepicker, StdCtrls, Mask, Controls, Classes, ExtCtrls,
  wwcheckbox, Buttons, DNMSpeedButton, BaseInputForm, Messages, Registry, DNMPanel,
  Grids, Wwdbigrd, Wwdbgrid, Graphics, ActnList, Menus, AdvMenus, ImgList,
  SelectionDialog, AppEvnts, wwdbcomb, wwdbedit, Variants, MyAccess,ERPdbComponents, DBAccess,
  MemDS, DataState,Commonlib,Systemlib,
  BusObjTrans,busobjPQA, BusObjBase, StrUtils, Shader, dmGUIStylers, tcTypes,
  BusObjStock,JSONObject, frmRepairs, ProgressDialog, ERPDbLookupCombo, types , messageDlgXP_Vistaobj,
  frmReportingOptions;

type

  TBaseTransGUI = class(TBaseInputGUI)
    DSDetails: TDataSource;
    DSMaster: TDataSource;
    pnlHeader: TDNMPanel;
    Label38: TLabel;
    lblClientDetails: TLabel;
    txtClientDetails: TDBMemo;
    SaleDate_Label: TLabel;
    cboCreationDate: TwwDBDateTimePicker;
    Label160: TLabel;
    txtCustomID: TDBEdit;
    Label48: TLabel;
    cboEmployee: TwwDBLookupCombo;
    btnNext: TDNMSpeedButton;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    btnPreview: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    pnlFooter: TDNMPanel;
    lblComments: TLabel;
    Label142: TLabel;
    txtSubTotal: TDBEdit;
    Label54: TLabel;
    txtTotalTax: TDBEdit;
    Label56: TLabel;
    txtTotalAmount: TDBEdit;
    pnlDetail: TDNMPanel;
    grdTransactions: TwwDBGrid;
    btnDelete: TwwIButton;
    lsTDNMSpeedButtonActions: TActionList;
    actPreview: TAction;
    actPrint: TAction;
    popDscntMrkup: TAdvPopupMenu;
    mnuDiscountDollar: TMenuItem;
    mnuDiscountPerc: TMenuItem;
    mnuMarkupDollar: TMenuItem;
    mnuMarkupPerc: TMenuItem;
    popMemTrans: TAdvPopupMenu;
    MemorizeTransaction1: TMenuItem;
    actMemTrans: TAction;
    actMemTransAuto: TAction;
    MemorizeAutoTransaction1: TMenuItem;
    lbMemTrans: TLabel;
    pnlChooseRpt: TDNMPanel;
    chkChooseRpt: TCheckBox;
    actNew: TAction;
    actSave: TAction;
    tblMaster: TERPQuery;
    tblDetails: TERPQuery;
    btnContacts: TDNMSpeedButton;
    actCustomerContacts: TAction;
    cboClientLookup: TERPQuery;
    cboEmployeeLookup: TERPQuery;
    cboClassQry: TERPQuery;
    actDelete: TAction;
    lblBaseForeignTotal: TLabel;
    edtBaseForeignTotal: TDBEdit;
    lblBaseForeignCurrencyCode: TLabel;
    cboBaseForeignCurrencyCode: TwwDBLookupCombo;
    lblBaseExchangeRate: TLabel;
    edtBaseExchangeRate: TwwDBEdit;
    qryBaseForeignCurrency: TERPQuery;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cboClientR: TERPDbLookupCombo;
    qryClientLookup: TERPQuery;
    qryClientLookupCompany: TWideStringField;
    qryClientLookupClientId: TIntegerField;
    imgPopup: TImageList;
    lblRedeemPoints: TLabel;
    ProgDialog: TProgressDialog;
    mnuDeleteemptyLines: TMenuItem;
    imgSearch: TImage;
    btnPayments: TDNMSpeedButton;
    lblDisableCalc: TDNMSpeedButton;
    DNMPanel5: TDNMPanel;
    lblEnteredbyHead: TLabel;
    lblEnteredBy: TDBText;
    lblPrintHead: TLabel;
    lblPrintedBy: TLabel;
    lblPrintedOnCaption: TLabel;
    lblPrintedOn: TLabel;
    lblPrintedAtCaption: TLabel;
    lblPrintedAt: TLabel;
    lblEmail: TDNMPanel;
    lblEmailMsg: TLabel;
    mnuAuditTrial: TMenuItem;
    mnuTransactionSequence: TMenuItem;
    mnuStockTransferEntrylist: TMenuItem;
    mnuReturns: TMenuItem;
    QryAreaCodeLk: TERPQuery;
    QryAreaCodeLkAreaCode: TWideStringField;
    QryAreaCodeLkAreaName: TWideStringField;
    cboLinesAreaCode: TwwDBLookupCombo;
    cmdEmail: TDNMSpeedButton;
    btnPDF: TDNMSpeedButton;
    btnEdit: TDNMSpeedButton;
    SaveDialog1: TSaveDialog;
    lblStatus: TLabel;
    QryTransStatus: TERPQuery;
    cbTaxCodeQry: TERPQuery;
    cboTaxCode: TERPDbLookupCombo;
    cbTaxCodeQryTaxCodeID: TIntegerField;
    cbTaxCodeQryName: TWideStringField;
    cbTaxCodeQryDescription: TWideStringField;
    cbTaxCodeQryRate: TFloatField;
    cbTaxCodeQryLocation: TWideStringField;
    cbTaxCodeQrycRate: TFloatField;
    pnlComments: TDNMPanel;
    txtComments: TDBMemo;
    LblCommentsHint: TLabel;
    TmrCommentshint: TTimer;
    pnlProcessMessage: TDNMPanel;
    lblProcessMessage: TLabel;
    cboCurrentTransStatus: TwwDBLookupCombo;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtCommentsDblClick(Sender: TObject);
    procedure grdTransactionsTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure grdTransactionsEnter(Sender: TObject);
    procedure grdTransactionsCalcTitleAttributes(Sender: TObject; const AFieldName: string;
      const AFont: TFont; const ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure actPreviewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewUpdate(Sender: TObject);
    procedure actPrintUpdate(Sender: TObject);
    procedure mnuDiscountDollarClick(Sender: TObject);
    procedure mnuDiscountPercClick(Sender: TObject);
    procedure mnuMarkupDollarClick(Sender: TObject);
    procedure mnuMarkupPercClick(Sender: TObject);
    procedure actMemTransUpdate(Sender: TObject);
    procedure actMemTransExecute(Sender: TObject);
    procedure actSaveUpdate(Sender: TObject);
    procedure actNewUpdate(Sender: TObject);
    procedure grdTransactionsExit(Sender: TObject);
    procedure grdTransactionsRowChanged(Sender: TObject);
    procedure grdTransactionsCalcTitleImage(Sender: TObject; Field: TField;
      var TitleImageAttributes: TwwTitleImageAttributes);
    procedure cboClientRNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure cboCreationDateExit(Sender: TObject);
    procedure tblMasterAfterOpen(DataSet: TDataSet);
  //  procedure edtCompanySearchFilterExit(Sender: TObject);
    procedure btnPaymentsClick(Sender: TObject);
    procedure actCustomerContactsUpdate(Sender: TObject);
    procedure actCustomerContactsExecute(Sender: TObject);
    //procedure edtCompanySearchFilterKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    //procedure edtCompanySearchFilterDblClick(Sender: TObject);
    //procedure edtCompanySearchFilterChange(Sender: TObject);
    procedure tblMasterBeforeDelete(DataSet: TDataSet);
    procedure tblDetailsBeforeDelete(DataSet: TDataSet);
    procedure cboClientLookupAfterOpen(DataSet: TDataSet);
    procedure actDeleteUpdate(Sender: TObject);
    procedure cboClientREnter(Sender: TObject);
    procedure tblDetailsBeforePost(DataSet: TDataSet);
    procedure cboBaseForeignCurrencyCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure txtClientDetailsEnter(Sender: TObject);
    procedure txtClientDetailsExit(Sender: TObject);
    procedure OverrideAccessLevel(Sender: TObject);
    procedure RestoreOverridenAccessLevel(Sender: TObject);
    procedure grdTransactionsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdTransactionsDblClick(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure tblDetailsCalcFields(DataSet: TDataSet);
    procedure grdTransactionsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tblDetailsAfterOpen(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cboClientLookupBeforeOpen(DataSet: TDataSet);
    procedure tblMasterAfterPost(DataSet: TDataSet);
    procedure tblDetailsBeforeClose(DataSet: TDataSet);
    procedure FeldSetTextDontAllowNulls(Sender: TField;      const Text: String);override;
    procedure grdTransactionsColEnter(Sender: TObject);
    procedure mnuDeleteemptyLinesClick(Sender: TObject);
    procedure grdTransactionsKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure lblDisableCalcClick(Sender: TObject);
    procedure mnuAuditTrialClick(Sender: TObject);
    procedure txtCustomIDDblClick(Sender: TObject);
    procedure txtTotalTaxDblClick(Sender: TObject);
    procedure StockTransferList(Sender: TObject);
    procedure mnuReturnsClick(Sender: TObject);
    procedure cboCreationDateEnter(Sender: TObject);
    procedure btnPDFClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure QryTransStatusBeforeOpen(DataSet: TDataSet);
    procedure cboCurrentStatusNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure cboCurrentStatusDblClick(Sender: TObject);
    procedure ChangeToDefaultOrder(Sender: TObject);
    Procedure showcurrentOrder(Sender: TObject);
    procedure Inserline(Sender: TObject);
    procedure cbTaxCodeQryBeforeOpen(DataSet: TDataSet);
    procedure cbTaxCodeQryCalcFields(DataSet: TDataSet);
    procedure grdTransactionsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    Procedure doCalculate(Sender :Tobject);Overload;
    Procedure doReCalculate(Sender :Tobject);
    procedure TmrCommentshintTimer(Sender: TObject);
    procedure lblProcessMessageDblClick(Sender: TObject);
    procedure lblCommentsDblClick(Sender: TObject);
  private
    { Private declarations }
    recDeleted: boolean;
    Old_Caption: string;
    fbCancelClicked: boolean;
    fiBackOrderSalesID: integer;
    fiProductID: integer;
    fiAccountID: integer;
    fiReportType: integer;
    fiClientID: integer;
    fbGroupReportByClass: boolean;
    emptyLinesDeleted:boolean;
    xLinecount :Integer ;
    xTransname :String;
    fsRElatedPartIDs :String;
    fRelatedProductObj : TRelatedProduct;
    StartTime, FinishedTime: TDateTime;
    TimerRunOnce: boolean;
    NewCombinedBO: boolean;
    CombinedBORef: string;
    CombinedBOClientID: integer;
    LastSelectedClientName: string;
    fiEmailContactID: integer;
    fiLineId :Integer;
    totalRedeemedPoints :Double;
    totalRedeemedAmount:Double;
    RedeemedPointsDesc:String;
    fbDeleteEmptyLinesAftershow: Boolean;
    {$IFDEF FORM_BASED_SELECT_SQL}
    Tablename1, Tablename2:String;
    {$ENDIF}
    tablename:String;
    function GetIsInvoiced: boolean;
    procedure SetProductID(const iValue: integer);
    procedure SetClientID(const iValue: integer);
    procedure SetAccountID(const iValue: integer);

    function showMatrixform:Boolean;
    function ShowProductQtybinETA:Boolean;
    function GetIsProductTransaction: boolean;
    procedure DoOnGridDataSelect(Sender: TwwDbGrid);
    procedure SetForeignFieldDisplayFormat;
    Function  ShowallocationForm:Boolean;
//    Function  ShoRPDetailsForm:Boolean;Virtual;
    function InsertSpaces(SourceStr:String):String;
    procedure GridFieldsEditable;
    {$IFDEF FORM_BASED_SELECT_SQL}
    function InvoiceGroupSQL:String;
    {$ENDIF}
    Procedure totalPointsCallback(Const Sender: TBusObj; var Abort: boolean);
    function deleteline: boolean;
    Procedure DeleteallLines;
    procedure DeleteSelectedLines;
    {$IFDEF FORM_BASED_SELECT_SQL}
    function SalesOrderManufactureReportSQL(Includeallocation:Boolean =False):String;
    {$ENDIF}
    {$IFDEF FORM_BASED_SELECT_SQL}
    procedure MyScriptBeforeExecute(Sender: TObject; var SQL: String; var Omit: Boolean);
    {$ENDIF}
    procedure CreateBarCodeForProduct(Sender: TObject);
    Procedure TransAuditTrialbeforeShow(Sender:TObject);
    procedure OnshowTransTaxDetails(Sender: TObject);
    function ProcessPQADetailClasses(Const Sender: TDatasetBusObj): STring;
    procedure BeforeshowStockTransferList(Sender: TObject);
    procedure beforeOpenTransReturnDetails(Sender: TObject);
    procedure SetLineLockMsg(const Value: String);
    {$IFDEF FORM_BASED_SELECT_SQL}
    function IstoExcludeBoFromPrint: Boolean;
    {$ENDIF}
    function isPurchaseform: boolean;
    function isSalesform: boolean;
    Procedure UpdateFromContact(Sender: TwwDbGrid);
    function getEmailContactID: integer;
    Procedure AddCalculatormenuitem;
    Procedure AddCalcMenuForDevMode;
    Procedure AddCommentsMenu;
    Function doCalculate:Boolean ;Overload;
    procedure DoLockSortingClick(Sender: TObject);
    procedure initTransComments(Sender: TObject);
    procedure OnTransCommentsSave(Sender: TObject);
    procedure DoMultiplecommnets(Sender: TObject);
    Procedure DoSinglecommnet(Sender: TObject);
    procedure updatecomments(Sender: TwwDbGrid);
    procedure OncommentSelect(Sender: TwwDbGrid);
    procedure initcommentList(Sender: TObject);
    procedure Swapfields(Field1, Field2, DisplayLabel: String;
      Proc: TGeneralProc);
    procedure RecalculateAll;
    procedure DoOnRelatedProductsSelect(Sender: TwwDbGrid);
    procedure initRelatedProducts(Sender: TObject);
    procedure SelectallCallback(const Sender: TBusObj; var Abort: boolean);
    Procedure AddCopyPasteMenu;
    procedure ClipBoardtoQry(Sender: TObject);
    procedure QryToClipBoard(Sender: TObject);
    procedure setTransAccessMsg(const Value: String);
    procedure StepProgressFunc();
    procedure ShowProgressFunc(ProgressBarCaption: String; ProgressCount: Integer = 0);
    procedure HideProgressFunc();
    function UserConfirmFunc(aConfirmType: string; var Handled: boolean): boolean;
    procedure check4VoucherLock(const aMsg: String);

  protected
    OldMasterAccountID, OldClientID: integer; {For Accounting Obj}
    fbFilterError: boolean;
    fbPaymentLock: boolean;
    ftLockType: TTransLockType;
    fsFax: boolean;
    fbCreatingNewClient: boolean;
    fbIsModified: boolean;
    fbSaveClicked: boolean;
    fbClosingForm :Boolean;
    foCombo: TObject;
    bDontDropProductList: boolean;
    fbFutureOrder: boolean;
    fsinvoicingErrMsg :String;
    SavedAccessLevel :Integer;
    fbRecEditable :Boolean;
    NewBarcode:string;
    fdCreationdate:TDatetime;
    fiLockedLines:Integer;
    fLineLockMsg:String;
    TransAccessLevel:Integer;
    fsTransAccessMsg:String;
    fPrintBtnCllick, fPreviewbtnclick, fEmailBtnCllick, fPDFBtnclick:TNotifyEvent;
    NewTransStatus: string;
    mnuLockSorting: TMenuItem;

    Function TransName:String;
    procedure ShowForeignCurrencycomponnets;Virtual;//(const Value: boolean);
    function DocPrintedBy: string;
    {Virtual methods expected to be overwritten in descendants}
    {Descendant classes can use this method to perform Before Save Checks.}
    procedure AutoShippingRun; virtual;
    {Virtual methods expected to be overwritten in descendants}
    {Descendant classes can use this method to perform Before Save Checks.}
    procedure IsOK_to_Print(var IsOk: boolean); virtual;

    procedure EnableDisableTranFunctions; virtual;

    {These methods are used to update the Tax account according to the class type}
    function GetTaxAccountName: string; virtual;
    function GetDocumentNoName: string; virtual;

    {Shared amongst all classes}
    procedure SetTerms(const LookupTable, FillTable: TDataset); overload;
    procedure SetTerms(const LookupTable, FillTable: TDataset; const dtBaseDate: TDateTime); overload;
    {Set the totals for the header portion of the transaction, expected to be done in descendants}
    procedure RefreshCalcs;

    {Used to open the productlist from double clicking the product combo}
    procedure DivertComboDblClick(Sender: TObject); override;


    function SetShippingAddress: string;
    function SetPhysicalAddress: string;

    {Loads the prinatable templates}
    Function LoadTemplate(const bPrint, bSave: boolean; const DoClose: boolean = true; const FileName: string = '') :Boolean ; reintroduce;
    {If the transaction is a backorder, we disable the ability to delete}
    function IsBackOrder: boolean;

    {Checks to determine the transaction occurs after closing date}
    function ValidateClosingDate(const TransDate: TDateTime): boolean; virtual;

    property Invoiced: boolean read GetIsInvoiced;
    property BackOrderSalesID: integer read fiBackOrderSalesID write fiBackOrderSalesID;
    property ReportType: integer read fiReportType write fiReportType;
    property GroupReportByClass: boolean read fbGroupReportByClass write fbGroupReportByClass;
    {Checks to determine the transaction Has a Payment Against it}
    procedure PaymentLockValidate; virtual;
    {Override in decendants to update any data after a memory transaction creation}
    procedure UpdateAfterMemTrans; virtual;

    procedure DoGridDataSelect(Sender: TwwDbGrid);

    // override in decendents to perform any processing after data has been
    // committed to database
    procedure AfterCommit; virtual;
    procedure KeyIdChanged(const NewKeyId: integer); override;
    procedure SetUserLocking;virtual;

    function GetFormClassDescription: string;

    { NOTE:
      This form makes reference to controls on descendant forms so the following
      functions have been introduced so that these descendant forms can be
      removed the uses clause, eventually the code using these descendant form
      controls needs to be moved onto the descendant forms AND / OR inherited
      procedures introduced that perform the required tasks. }
    function GetComboByName(Const ComponentName: string): TwwDbLookupCombo;
    function GetMyQueryByName(Const ComponentName: string): TERPQuery;
    function GetDBEditByName(Const ComponentName: string): TwwDbEdit;
    function GetLabelByName(Const ComponentName: string): TLabel;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Function DoProductallocation(const LineObj :TProdQty):Boolean ;virtual;
    Procedure UnlockRelatedTables; override;
    Procedure DeleteEmptyLines(const AMemo :TDBMemo);
    Procedure LoadTransRec; virtual;
//    Procedure ShowStatus(const Value :String);Override;
    Procedure SetLimit0(qry :TERPQuery);
    Function  PrintSalesPickingSlip:Boolean;
    Function Matrixshown:Boolean;Virtual;
    Function ProductOptionsShown:Integer;Virtual;
    function ValidData: boolean; Virtual;
    function Validdatamsg: boolean;Virtual;
    Procedure BeforeAllocationformShow; virtual;
    function getcontactType:TContactType;virtual;abstract;
    //Procedure UpdateFromContact(const value :Tdataset); Overload; virtual;abstract;
    function FieldsToExecludeFromsorting: String ; override;
    procedure MemoScrollUp(Memo: TDBMemo) ;
    Procedure ApplyPricelock;
    Procedure RedeemPoints;
    function PointsRedeemd(const saleID:Integer):boolean;
    Procedure OnSelectPoints(Sender:TObject); virtual;
    Procedure AddRewardPointmenuITems;
    procedure mnuRedeemPointsClick(Sender: TObject);
    Procedure showRedeemPoints(const SaleDate:TdateTime);Virtual;
    procedure showProgressbar(Progressbarcaption:String; Progresscount:Integer = 0);
    procedure stepProgressbar(ProgressMsg: String='');
    procedure HideProgressbar;
    Procedure AfterFormShow; Override;
    function ConfirmZeroTax: boolean;
    Procedure OpenTransactionSequence;
    Procedure TransactionSequenceBeforeshow(Sender: TObject);
    function Saverecord :boolean; virtual;
    procedure SetKeyId(const Value: integer); override;
    Procedure CreateBarcode(NewValue:String);virtual;
    function HasAssociatedrecords: boolean;Virtual;
    Procedure LogEmailed(Const Emailed:Boolean;TemplName:string);
    Procedure LogFaxed(Const Faxed:Boolean;TemplName:string);
    Procedure NewAuditTrialentry(EventDescription:String);
    Function PrintMatrixSQL(Reporttemplname:String; Transtype:String;ID:Integer):String; virtual;
    Function PrintMatrixYSQL(const ID:Integer ; var ReportTablename :String; IsYMode:Boolean;IncludeBOM:Boolean; var Json: TJsonObject):String;
    function MatrixReporttype:String ;Virtual;
    Procedure DoOnClientchange;Virtual;
    Procedure DoOnProductchange;Virtual;
    Procedure ShowtaxDetails;Virtual;
    Function ShowLineTaxDetails :boolean ; virtual;
    procedure SetDatasetconn;Virtual;
    function ReturnType:String;virtual;
    {$IFDEF FORM_BASED_SELECT_SQL}
    function TransSpecificSQL :String;virtual;
    {$ENDIF}
    Function RepairSalesSQL:String;virtual;
    Function showformuladetails:Boolean ; virtual;
    function ProductHasCalcformula: Boolean;virtual;
    procedure LockPartCalcformulafields;
    procedure SkipReadonlyfield;virtual;
    function IsOktodelete:Boolean ; virtual;
    procedure IsOktodeleteCallback(const Sender: TBusObj; var Abort: boolean);Virtual;
    function IstransLineLocked: Boolean; Virtual;
    function IsOktodeleteLine: Boolean; Virtual;
    function DeleteLinerecord:Boolean;Virtual;
    procedure ValidateCreationDateforFuturedate;
    Procedure ReadExtraGuipref;virtual;
    Procedure WriteExtraGuiPref;virtual;
    procedure ValidateCreationDate;
    function ValidateCreationDateWithAccess(const aFuture,APast : string)  : boolean;
    Procedure ShowGridLockMsg;virtual;
    procedure ApplyTransAccesslevel(TransLocked, TranslineLocked: Boolean);virtual;
    procedure TranslockComponents(var lockComponents: TStringDynArray );virtual;
    procedure AddTranslockComponent(var lockComponents: TStringDynArray;comp: TWincontrol);
    function Iscolvisible(const fieldname: String): Boolean;
    Procedure DefaultValueForAreaFromHint(const PreferenceValue:String);
//    Procedure TransApprovalInit(checkApproved: TwwCheckBox);
//    Procedure CapturenReplaceReportbtnclicks;Virtual;
//    Procedure DoReportOptions(Sender:TObject); virtual;
    function SaveTransToPDF: boolean; virtual;
    procedure PopulateMessageSubstituteList(SL: TStringList); virtual;
    function ActiveFieldname :String;
    Procedure NewTransBusObjRecord(aId: integer = 0); virtual;
    Procedure NewTransBusObjinstance;virtual;
    function TransStatustype:String;Virtual;
    procedure AddDefaultOrdermenuITems;Virtual;
    function ClientState:String; virtual;abstract;
    function Clientcountry:String; virtual;abstract;
    function clientLocation:String; virtual;abstract;
    function ClientPostcode:String; virtual;abstract;
    Procedure Readonlyfield(fieldname:String; REadonly:Boolean);virtual;
    procedure GridTitleButtonClick(Sender: TObject;AFieldName: String);Override;
    procedure AssignAreacolumnName;virtual;
    //Procedure OnNewTransRecord;virtual;
    function GetCancelGridSort: Boolean; override;
    procedure initcontactList(Sender: TObject);Virtual;
    Procedure AddExtraMenuItems;Virtual;
    function NewMenuForTransGrid(menuCaption:String;MenuEvent:TNotifyEvent; hasSeparator:Boolean; menuhint:String='') : TMenuItem;
    function NewMenuForTrans(menuCaption:String;MenuEvent:TNotifyEvent; hasSeparator:Boolean; menuhint:String='') : TMenuItem;

    procedure TransTimerMsg(const Value: String; Secondstoshow: Integer=5; msgColor:TColor = clred);
    Function CanEditTransPricenCost:Boolean;Virtual;
    function SaveTrans:Boolean ; virtual;abstract;
    //Procedure checkForDupPQA;Virtual;
    procedure ChooseRelatedParts(Sender: TDatasetBusObj);Virtual;
    procedure CustomiseUOMField;virtual;
    Procedure InitERPLookupCombonFields; Override;
    function EmailTransaction(const RecipientAddress :String ='';ASilent: boolean=True; ASecret : boolean=True): boolean;virtual;
    Procedure DoEmailTransaction;
    Procedure DoEmailTransactionSilentnSecret;
    procedure DoEmailTransactionnonsilent;
    function DisfieldstoRemove:String;virtual;
    procedure ChangeCurfield(const FldName: String);
    Procedure SelectAllLines;
    procedure OnCopySelection(var Key: word);Override;
    procedure OnPasteSelection(var Key: word);Override;
    //Function getTransAccessMsg(const fieldname:String ):String;Overload;Virtual;
    Property TransAccessMsg:String read fsTransAccessMsg write setTransAccessMsg;
    function CheckForfieldsinGridKeyPress(Sender: TObject;  var Key: Char):boolean;virtual;
    function Save4NewTrans: Boolean;Virtual;
    procedure ShowFormulafields;virtual;
    procedure InitClientLookupCombonFields;
    function EmailOptsForm: TfmReportingOptions;
    procedure InitreportOptionsform(Sender: TObject);Virtual;
    procedure DoOnDoNotAskMsgCheck(Sender: TObject; Checked: boolean);Overload;Override;
    Procedure DoOnDoNotAskMsgCheck(Sender:TObject);Overload;Virtual;
    Procedure AddProductOptionsProduct(const OldProductId, newProductID:Integer); virtual;
  public
    { Public declarations }
    FullBackOrder: boolean;
    bIsInitialising: boolean;
    bDropDownClients: boolean;
    fbFiringExitEvent: boolean;
    fbDblClickActivated: boolean;
    fbResetEnteredBy: boolean;
    TransBase: TTransBase;
    {this has to be a public property as the form is called from different forms - salesorder etc
    and the srno is accepted by salesorder form}
    function IsOkToSave: boolean; override;

    procedure SendEmailCallback(const ACommaContactEmails : string; ASilent, ASecret : boolean); virtual;

    property PaymentLock: boolean read fbPaymentLock;
    property ProductIDFromList: integer read fiProductID write SetProductID;
    property ClientIDFromList: integer read fiClientID write SetClientID;
    property AccountIDFromList: integer read fiAccountID write SetAccountID;
    property SetCombo: TObject read foCombo write foCombo;
    procedure UpdateMe; override;
    procedure UpdateMe(const Cancelled: Boolean; const aObject: TObject = nil); override;
    Property IsProductTransaction :boolean read GetIsProductTransaction;
    property EmailContactID: integer read getEmailContactID write fiEmailContactID;
    Property DeleteEmptyLinesAftershow:Boolean read fbDeleteEmptyLinesAftershow write fbDeleteEmptyLinesAftershow;
    procedure Setcolumn(columnVisible: Boolean; columnName: string; displaylabel:String = '');
    Property LineLockMsg :String read fLineLockMsg write SetLineLockMsg;
    constructor Create(AOwner: TComponent); override;

  end;
  {ML - NOTE :- Access Level 3 is diverted to 5 (Read Only) due to time frame}
implementation

{$R *.dfm}

uses
   Math,  CommonDbLib,
  CommentsListFrm, BaseClassFuncs,
   ComCtrls,AdvOfficeStatusBar,
  frmRepeat,
  TransLockManagementObj,
  ContactSelectorFrm,
  QueryManipulationObj,
  GlobalEventsObj, GuiPrefsObj,Expenses,
  tcDataUtils, BaseListingForm, TypInfo, tcConst,frmPrintPickingSlips,
  DNMAccessManager, BusObjSales, AppEnvironment, FastFuncs, BusObjConst,
  DNMLib, frmAllocation,
  frmProductQtysBinsETAs, frmShippingContainerGUI ,BusObjShippingContainer,
  frmProdAttribmatrix, BusObjCurrency, BusobjCash,frmCustomerFrm, LogUtils,
  ProductQtyLib, BaseFormForm,BusObjOrderBase,
  BusObjSaleBase, saleslib, CommonFormLib,
  TransactionSequence, BusObjSalesRedeemPoints,
  ProductListExpressForm, frmPartsFrm, BusObjClient, sndkey32, BusObjGLAccount, RewardPointsDetails,
  BusObjPrintDoc, TransAuditTrail, BusObjAudit,  TransTaxDetails,
  busobjstockTransferentry, SalesStockTransferList, TransReturnList , GraphUtil,
  PartCalcFormulaObj, Sales, Cash, frmVoucherSale, frmvoucherInvoice,
  ManufactureLib, frmSelectProduct , ShellAPI, frmSimpleTypes, frmBOMAllocation,
  TaxCodeListForm, ContactList, EmployeeAccesses, MatrixObj, frmCalculator,
  TimedHint, frmTransComments, LogLib, commonGuiLib, DbSharedObjectsObj,
  AppDatabase, BusObjOrders, ERPErrorEmailUtils, RelatedProductSelection,
  Order, EmailExtraUtils, TemplateReportsLib, clipboardLib, MemoDialog,
  PrintPickingSlipsLib, TemplateReportSelectObj, frmPurchaseOrders, ProductOptionsDEsignGUI;

const
  LockSortingCaption = 'Lock Sorting';
  EnableSortingCaption = 'Enable Sorting';


Procedure TBaseTransGUI.SetDatasetconn;
begin
    qryMemTrans.Connection   := MyConnection; //Stop Mem Trans on Cancel
    tblMaster.Connection     := MyConnection;
    tblDetails.Connection    := MyConnection;
end;
procedure TBaseTransGUI.FormCreate(Sender: TObject);
begin
  With TERPQuery(cboTaxCode.Lookuptable).sql do begin
    Clear;
    Add(NamenPrintNameGridObj.TaxcodeLookupSQL(0, true));
  end;
  if (not AppEnv.companyprefs.filterTaxcodeforClient) and (AppEnv.RegionalOptions.RegionType <> rUSA) then begin
    cboTaxCode.SpcialLookupItemList.Clear;
  end;
  fPrintBtnCllick:= nil;
  fPDFBtnClick := nil;
  fPreviewbtnclick:= nil;
  fEmailBtnCllick:= nil;
  fbExludeInactiveProductinProductcombo:= TRue;
  mnuReturns.Visible := ReturnType<> '';
  if mnuReturns.Visible then begin
    if AppEnv.RegionalOptions.RegionType = rNZ then mnuReturns.caption :='BAS Return(s)'
    else if AppEnv.RegionalOptions.RegionType = rAust then mnuReturns.caption :='GST Return(s)'
    else if AppEnv.RegionalOptions.RegionType = rUK then mnuReturns.caption :='VAT Return(s)'
    else mnuReturns.visible := False;
  end;
  lblDisableCalc.visible := False;
  AllowGridSorting  := True;
  fbDeleteEmptyLinesAftershow := False;
  emptyLinesDeleted:= False;

  if Assigned(TransBase) then begin
    TransBase.BusObjEvent := DoBusinessObjectEvent;
    transbase.ConfirmFromGUI := ConfirmFromGUI;
  end;
  FullBackOrder       := false;
  fbResetEnteredBy    := false;
  bIsInitialising     := true;
  fbFiringExitEvent   := false;
  fbFilterError       := false;
  fbDblClickActivated := false;
  NewCombinedBO       := false;
  CombinedBORef       := '';
  CombinedBOClientID  := 0;
  TimerRunOnce        := false;
  StartTime           := Now;
  ProcessingCursor(True);
  // Regional Options $ TO Pound
  mnuDiscountDollar.Caption := ReplaceStr(mnuDiscountDollar.Caption,'$',AppEnv.RegionalOptions.CurrencySymbol);
  mnuMarkupDollar.Caption := ReplaceStr(mnuMarkupDollar.Caption,'$',AppEnv.RegionalOptions.CurrencySymbol);

  mnuLockSorting := TMenuItem.Create(self);
  mnuLockSorting.Caption := LockSortingCaption;
  mnuLockSorting.OnClick := DoLockSortingClick;

  Showcontrolhint (txtComments, 'Type In A Comment For The Warehouse.' +NL +'Right Click for "Multiple Comments" Option'+NL);
  try
    inherited;
    AddDisablescontrolforHint(pnlHeader , btnEdit , '');

    NewTransBusObjinstance;
    GuiPrefs.AddreadonlyField('RepairID' , tblDetails);
    GuiPrefs.AddreadonlyField('MatrixPrice' , tblDetails);
    GuiPrefs.AddreadonlyField('MatrixDesc' , tblDetails);
    With TPartCalcFormula.Create(Self) do try ShowFormulaQtyFields(Self);finally Free;end;
    GuiPrefs.Active := True;
    if Appenv.Employee.DefaultOrderinTransForms then ChangeToDefaultOrder(nil);
    UserLock.Enabled := true;
    SetConnectionString(false);
    SetDatasetconn;
    MyConnection.Connected := true;
    BeginTransaction;
    fbCreatingNewClient := false;
  finally
    ProcessingCursor(False);
  end;

  bDropDownClients := true;
  if AllowCustomiseGrid then begin
    GuiPrefs.AddFieldPair('LineCost', 'LineCostInc', tblDetails);
    GuiPrefs.AddFieldPair('LinePrice', 'LinePriceInc', tblDetails);
    GuiPrefs.AddFieldPair('CalcProfit', 'CalcProfitEx', tblDetails);
    GuiPrefs.AddFieldPair('CalcProfitPercent', 'CalcProfitPercentEx', tblDetails);
    GuiPrefs.AddFieldPair('LatestCostPrice', 'LatestCostPriceInc', tblDetails);
    GuiPrefs.AddFieldPair('TotalLineAmount', 'TotalLineAmountInc', tblDetails);
  end;
  EmailContactID := 0;

  With TPartCalcFormula.Create(Self) do try    SetdisplayLabel(self);  finally    Free;  end;
  CustomiseUOMField;
  AssignAreacolumnName;
  pnlProcessMessage.Top := (grdTransactions.Top + grdTransactions.Height) - (pnlProcessMessage.Height + 5);
  pnlProcessMessage.Width := grdTransactions.Width; // - 50;
  pnlProcessMessage.Left := 0; //(grdTransactions.Width - pnlProcessMessage.Width) div 2;
end;
Procedure TBaseTransGUI.AssignAreacolumnName;
var
  comp:TComponent;
begin
    if Trim(AppEnv.CompanyPrefs.Areacolumnname) <> '' then begin
      if tbldetails.Findfield('AreaCode')<> nil then tbldetails.FieldByName('AreaCode').DisplayLabel:=  AppEnv.CompanyPrefs.Areacolumnname;
      if tbldetails.Findfield('Area')    <> nil then tbldetails.FieldByName('Area').DisplayLabel    :=  AppEnv.CompanyPrefs.Areacolumnname;
      if tbldetails.Findfield('ExpenseProductSelected')    <> nil then tbldetails.FieldByName('ExpenseProductSelected').DisplayLabel    :=  AppEnv.CompanyPrefs.Areacolumnname +' - Product';

      comp := findcomponent('cboAreacode');
      if Assigned(comp) and (comp is TwwDBLookupCombo) then begin
          TwwDBLookupCombo(comp).options := TwwDBLookupCombo(comp).options +[lotitles];
          UpdateSelectedProp(TwwDBLookupCombo(comp).Selected, 'Areacode', AppEnv.CompanyPrefs.Areacolumnname+' Code', sptUpdateLabel);
          UpdateSelectedProp(TwwDBLookupCombo(comp).Selected, 'AreaName', AppEnv.CompanyPrefs.Areacolumnname+' Name', sptUpdateLabel);
      end;
      comp := findcomponent('cboLinesAreaCode');
      if Assigned(comp) and (comp is TwwDBLookupCombo) then begin
          TwwDBLookupCombo(comp).options := TwwDBLookupCombo(comp).options +[lotitles];
          UpdateSelectedProp(TwwDBLookupCombo(comp).Selected, 'Areacode', AppEnv.CompanyPrefs.Areacolumnname+' Code', sptUpdateLabel);
          UpdateSelectedProp(TwwDBLookupCombo(comp).Selected, 'AreaName', AppEnv.CompanyPrefs.Areacolumnname+' Name', sptUpdateLabel);
      end;
  end;
end;
function TBaseTransGUI.DisfieldstoRemove: String;
begin
  result := '';
end;

procedure TBaseTransGUI.DivertComboDblClick(Sender: TObject);
var
  Listing: TBaseListingGUI;
begin
  if Sender is TwwDBLookupCombo then begin
    if (uppercase(TwwDBLookupCombo(Sender).DataField) = 'SUPPLIERNAME') then begin
      Listing:= BaseClassFuncs.GetBaseListingByClassName('TSupplierListGUI');
      if Assigned(Listing) then begin
        Listing.FormStyle := fsMDIChild;
        Listing.OnGridDataSelect := DoGridDataSelect;
        Listing.BringToFront;
      end;
      foCombo := Sender;
    end;

    if (uppercase(TwwDBLookupCombo(Sender).DataField) = 'CUSTOMERNAME') then begin
      Listing:= BaseClassFuncs.GetBaseListingByClassName('TCustomerListGUI');
      if Assigned(Listing) then begin
        Listing.FormStyle := fsMDIChild;
        Listing.OnGridDataSelect := DoGridDataSelect;
        Listing.BringToFront;
      end;

      foCombo := Sender;
    end else if (uppercase(TwwDBLookupCombo(Sender).DataField) = 'PRODUCTNAME') then begin
      Listing:= GetBaseListingByClassName('TProductListGUI', true);
      if Assigned(Listing) then begin
        Listing.FormStyle := fsMDIChild;
        Listing.OnGridDataSelect := DoGridDataSelect;
        Listing.BringToFront;
      end;
      foCombo := Sender;
    end else if uppercase(TwwDBLookupCombo(Sender).DataField) = 'ACCOUNTNAME' then begin
      Listing:= GetBaseListingByClassName('TChartOfAccountsListGUI', true);
      if Assigned(Listing) then begin
        Listing.FormStyle := fsMDIChild;
        Listing.OnGridDataSelect := DoGridDataSelect;
        Listing.BringToFront;
      end;
      foCombo := Sender;
    end;
  end else if (Sender is TwwDBEdit) then begin
    if uppercase(TwwDBEdit(Sender).DataField) = 'SEARCHFILTER' then begin
      Listing:= GetBaseListingByClassName('TProductListGUI', true);
      if Assigned(Listing) then begin
        Listing.FormStyle := fsMDIChild;
        Listing.OnGridDataSelect := DoGridDataSelect;
        Listing.BringToFront;
        Listing.edtSearch.Text := TwwDBLookupCombo(Sender).DataSource.DataSet.FieldByName('SearchFilterCopy').AsString + '*';
        Listing.GoSearch;
      end;
      foCombo := Sender;
    end;
  end;
end;

procedure TBaseTransGUI.DoGridDataSelect(Sender: TwwDbGrid);
begin
  if Sender.Owner.ClassNameIs('TSupplierListGUI') then begin
    ClientIDFromList :=Sender.DataSource.DataSet.FieldByName('ClientID').AsInteger;
  end else if Sender.Owner.ClassNameIs('TCustomerListGUI') then  begin
    ClientIDFromList :=Sender.DataSource.DataSet.FieldByName('ClientID').AsInteger
  end else if Sender.Owner.ClassNameIs('TProductListGUI') then  begin
    ProductIDFromList := Sender.DataSource.DataSet.FieldByName('PARTSID').AsInteger
  end else if Sender.Owner.ClassNameIs('TChartOfAccountsListGUI') then  begin
    AccountIDFromList := Sender.DataSource.DataSet.FieldByName('AccountID').AsInteger;
  end;
end;


procedure TBaseTransGUI.DoLockSortingClick(Sender: TObject);
begin
  if mnuLockSorting.Caption = LockSortingCaption then
    mnuLockSorting.Caption := EnableSortingCaption
  else
    mnuLockSorting.Caption := LockSortingCaption;
end;

procedure TBaseTransGUI.SetClientID(const iValue: integer);
var
  fsClientName:String;
begin
  fiClientID := iValue;
  fsClientName:= TClient.IDToggle(fiClientId,MyConnection);
  if foCombo is TwwDBLookupCombo then begin
    if not TwwDBLookupCombo(foCombo).LookupTable.Locate('ClientID', iValue, [loCaseInsensitive]) then begin
      TwwDBLookupCombo(foCombo).Text:= fsClientName;
      Self.BringToFront;
      SetControlFocus(TwwDBLookupCombo(foCombo));
      SendKeys('{F6}',true);
      if not TwwDBLookupCombo(foCombo).LookupTable.Locate('ClientID', iValue, [loCaseInsensitive]) then
        exit;
    end;
    TwwDBLookupCombo(foCombo).DataSource.DataSet.Edit;

    If EditNoAbort(TwwDBLookupCombo(foCombo).DataSource.DataSet) then
      TwwDBLookupCombo(foCombo).DataSource.DataSet.FieldByName(TwwDBLookupCombo(foCombo).DataField).AsString :=fsClientName;
    if Assigned(TwwDBLookupCombo(foCombo).OnCloseUp) then
      TwwDBLookupCombo(foCombo).OnCloseUp(foCombo, TwwDBLookupCombo(foCombo).LookupTable,
        TwwDBLookupCombo(foCombo).DataSource.DataSet, true);

    SetControlFocus(TwwDBLookupCombo(foCombo));
  end;
end;

procedure TBaseTransGUI.SetProductID(const iValue: integer);
var
  fsProductname:String;
begin
  fiProductID := iValue;
  fsProductname :=TProduct.IDToggle(fiProductID,MyConnection);
  if foCombo is TwwDBLookupCombo then begin
    if not TwwDBLookupCombo(foCombo).LookupTable.Locate('PartsID', iValue, [loCaseInsensitive]) then begin
      TwwDBLookupCombo(foCombo).Text:= fsProductname;
      Self.bringtofront;
      SetControlFocus(TwwDBLookupCombo(foCombo));
      SendKeys('{F6}',true);
      if not TwwDBLookupCombo(foCombo).LookupTable.Locate('PartsID', iValue, [loCaseInsensitive]) then
        exit;
    end;
    TwwDBLookupCombo(foCombo).DataSource.DataSet.Edit;

    If EditNoAbort(TwwDBLookupCombo(foCombo).DataSource.DataSet) then
      TwwDBLookupCombo(foCombo).DataSource.DataSet.FieldByName(TwwDBLookupCombo(foCombo).DataField).AsString :=fsProductname;
    if Assigned(TwwDBLookupCombo(foCombo).OnCloseUp) then
      TwwDBLookupCombo(foCombo).OnCloseUp(foCombo, TwwDBLookupCombo(foCombo).LookupTable,
        TwwDBLookupCombo(foCombo).DataSource.DataSet, true);

    SetControlFocus(grdTransactions);
  end else if foCombo is TwwDBEdit then begin
    if TwwDBEdit(foCombo).DataSource.DataSet.Locate('PartsID', iValue, [loCaseInsensitive]) then begin
      tblDetails.FieldByName(TwwDBEdit(foCombo).DataField).AsString :=
        TwwDBEdit(foCombo).DataSource.DataSet.FieldByName(TwwDBLookupCombo(foCombo).LookupField).AsString;
      SetControlFocus(grdTransactions);
    end;
  end;
end;

procedure TBaseTransGUI.SetAccountID(const iValue: integer);
var
  fsAccountname :String;
begin
  fiAccountID := iValue;
  fsAccountname  :=TAccount.IDToggle(fiAccountID,MyConnection);
  if foCombo is TwwDBLookupCombo then begin
    if not TwwDBLookupCombo(foCombo).LookupTable.Locate('AccountID', iValue, [loCaseInsensitive]) then begin
      TwwDBLookupCombo(foCombo).Text:= fsAccountname;
      Self.bringtofront;
      SetControlFocus(TwwDBLookupCombo(foCombo));
      SendKeys('{F6}',true);
      if not TwwDBLookupCombo(foCombo).LookupTable.Locate('AccountID', iValue, [loCaseInsensitive]) then
        exit;
    end;
    TwwDBLookupCombo(foCombo).DataSource.DataSet.Edit;

    If EditNoAbort(TwwDBLookupCombo(foCombo).DataSource.DataSet) then
      TwwDBLookupCombo(foCombo).DataSource.DataSet.FieldByName(TwwDBLookupCombo(foCombo).DataField).AsString :=fsAccountname;

    if Assigned(TwwDBLookupCombo(foCombo).OnCloseUp) then
      TwwDBLookupCombo(foCombo).OnCloseUp(foCombo, TwwDBLookupCombo(foCombo).LookupTable,
        TwwDBLookupCombo(foCombo).DataSource.DataSet, true);

    SetControlFocus(grdTransactions);
  end;
end;

procedure TBaseTransGUI.btnCloseClick(Sender: TObject);
begin
  //
  // Don't allow a close when the window state is changing. This can be done
  // by hitting the escape key before the form is displayed.
  //
  if not ((fsShowing in Self.FormState) or (fsCreating in Self.FormState))  then begin
    btnClose.Enabled := false; //Stops Save Twice
    fbSaveClicked := false;
    fbCancelClicked := true;
//    Self.Close;
    CloseWait;
  end;
end;

function TBaseTransGUI.SetShippingAddress: string;
begin
  Result := '';
  if cboClientLookup.RecordCount > 0 then
    Result := cboClientLookup.FieldByName('Company').AsString + Chr(13) + Chr(10) +
      cboClientLookup.FieldByName('BillStreet').AsString + Chr(13) + Chr(10) +
      cboClientLookup.FieldByName('BillStreet2').AsString + Chr(13) + Chr(10) +
      cboClientLookup.FieldByName('BillStreet3').AsString + Chr(13) + Chr(10) +
      cboClientLookup.FieldByName('BillSuburb').AsString + ' ' + cboClientLookup.FieldByName('BillState').AsString +
      ' ' + cboClientLookup.FieldByName('BillPostCode').AsString + Chr(13) + Chr(10) +
      cboClientLookup.FieldByName('BillCountry').AsString;
end;

function TBaseTransGUI.SetPhysicalAddress: string;
begin
  result:= '';
  if cboClientLookup.RecordCount > 0 then
    Result := cboClientLookup.FieldByName('Company').AsString + Chr(13) + Chr(10) +
      cboClientLookup.FieldByName('Street').AsString + Chr(13) + Chr(10) +
      cboClientLookup.FieldByName('Street2').AsString + #13#10 +
      cboClientLookup.FieldByName('Street3').AsString + #13#10 +
      cboClientLookup.FieldByName('Suburb').AsString + ' ' + cboClientLookup.FieldByName('State').AsString + ' ' + cboClientLookup.FieldByName('PostCode').AsString +
      Chr(13) + Chr(10) + cboClientLookup.FieldByName('Country').AsString;
end;

Procedure TBaseTransGUI.DoOnClientchange;
var
  Buffer: array[0..255] of char;
  A: PChar;
begin
  try
    if cboClientR.LookupTable.FieldByName('company').asString <> cboClientR.Text then
      cboClientR.LookupTable.locate('company', cboClientR.Text , []);
  Except
    // kill the exception
  end;


  if cboClientR.LookupTable.FieldByName('ClientID').AsInteger < 1 then
    exit;

  if AppEnv.CompanyPrefs.SuppressJobNamesOnInvoices then begin
    ZeroMemory(@buffer, SizeOf(buffer));
    StrPCopy(Buffer, cboClientR.Text);
    A := StrPos(Buffer, '^');
    if Assigned(A) then begin
      A[0] := #0;
    end;
  end;
  ShowForeignCurrencycomponnets;
  closedb(cbTaxCodeQry);
  opendb(cbTaxCodeQry);
end;
procedure TBaseTransGUI.DoOnDoNotAskMsgCheck(Sender: TObject; Checked: boolean);
begin
  inherited;
end;
procedure TBaseTransGUI.DoOnDoNotAskMsgCheck(Sender: TObject);
begin
  if Sender is TwwCheckBox then
    DoOnDoNotAskMsgCheck(Sender , TwwCheckBox(Sender).checked);
end;

Function TBaseTransGUI.PrintMatrixYSQL(const ID:Integer ; var ReportTablename :String; IsYMode:Boolean;IncludeBOM:Boolean; var Json: TJsonObject):String;
begin
  with TMatrixsale.Create(Self) do try
    YMode := ISYMode;
    DeleteMatrixTableOnDestroy:= False;
    SaleID := ID;
    MakeMatrixTable(IsYMode);
    ReportTablename := Matrixtablename;
    result := SalesMatrixReportSQL(TransBase is TInvoice, IncludeBOM);
    Json:= SaleaMtrixMasterDetailLink(Stringcontains(ReportToPrint,'(BOM)'));
  finally
    free;
  end;
end;
Function TBaseTransGUI.PrintMatrixSQL(Reporttemplname:String; Transtype:String;ID:Integer):String;
var
  s:String;
  Qryx, Qryy :TERpQuery;
  QryTemp, QryTempCaptions,QryDetails :TERpQuery;
  colcount,ctr:Integer;
  //SaleLineId:Integer;
  //xValue,yvalue:String;
  //Sold,Shipped, BO:Double;
  //PAGID:Integer;
  //uom:String;

  function TransLineuom       :String; begin if SameText(Transtype , 'Sales') then result := 'UnitofMeasureSaleLines' else result := 'UnitofMeasurePOLines';end;
  function TransTable         :String; begin if SameText(Transtype , 'Sales') then result := 'tblsales'               else result := 'tblPurchaseOrders';   end;
  function TransLineTable     :String; begin if SameText(Transtype , 'Sales') then result := 'tblsaleslines'          else result := 'tblPurchaseLines';    end;
  function TransIDfield       :String; begin if SameText(Transtype , 'Sales') then result := 'saleId'                 else result := 'PurchaseOrderId';     end;
  function TransLineIDfield   :String; begin if SameText(Transtype , 'Sales') then result := 'SaleLineID'             else result := 'PurchaseLineID';      end;
  function YValueTocolcount(yValue:String;PagID:Integer):Integer;
  var
    i:Integer;
  begin
    result :=0;
    QryTempCaptions.Locate('Pag_ID' ,PagID, []);
    for i := 1 to colcount do begin
      if Sametext(QryTempCaptions.fieldByname('column'+inttostr(i)).asString , yValue) then begin
        result := i;
        break;
      end;
    end;
  end;
begin
  if ID=0 then exit;

{get Y attribute count}
  With TempMyQuery(Self.Myconnection) do Try
    SQL.add( 'Select distinct PAG.Name , count(PAV.value) ctr ' +
      ' from tblproductattributegroups PAG ' +
      ' inner join tblproductattributenames PAN on PAN.PAG_ID = PAG.PAG_ID and PAN.PAN_ID = PAG.yAxisAttribute ' +
      ' inner join tblproductattributevalues PAV on PAV.PAN_ID = PAN.PAN_ID '+
      ' Where PAG.PAG_ID in (Select PAP.PAG_ID ' +
      ' From tblproductattributeproducts PAP  ' +
      ' inner join '+TransLineTable+' SL on SL.ProductID = PAP.ProductID and SL.'+TransIDfield+' ='+inttostr(ID)+') ' +
      ' group by PAG.Name order by ctr desc');
    open;
    First;
    colcount:= FieldByname('ctr').asInteger;
  finally
    closenFree;
  end;
  if colcount =0 then colcount:= AppEnv.companyPrefs.MaxNoOfAttributes;

{Make Temporary table}
    tablename:= GetUserTemporaryTableName(Self.Classname+'PrintMatrix');
    s:= 'Drop table if exists ' + tablename +';'+
        'CREATE TABLE '+tablename + ' (  ID INT(10) NULL AUTO_INCREMENT,  ';
    s:= s +'Groupname varchar(255) DEFAULT "" ,';
    s:= s +'PAG_ID int(11) DEFAULT 0 ,';
    s:= s +'xName varchar(255) DEFAULT "" ,';
    s:= s +'xValue varchar(255) DEFAULT "" ,';
    s:= s +'yName varchar(255) DEFAULT "" ,';
    for ctr := 1 to colcount do begin
      s:= s +'Sold'   + inttostr(ctr)+' DOUBLE NULL DEFAULT 0 ,';
      s:= s +'Shipped'+ inttostr(ctr)+' DOUBLE NULL DEFAULT 0 ,';
      s:= s +'BO'     + inttostr(ctr)+' DOUBLE NULL DEFAULT 0 ,';
      s:= s +'UOM'    + inttostr(ctr)+' varchar(100) NULL DEFAULT "" ,';
    end;
    s:= s+' PRIMARY KEY (ID) ) ENGINE=MyISAM ;';

    s:= s+'Drop table if exists ' + tablename +'Captions;'+
        'CREATE TABLE '+tablename + 'Captions (  ID INT(10) NULL AUTO_INCREMENT,  ';
    s:= s +'Groupname varchar(255) DEFAULT "" ,';
    s:= s +'PAG_ID int(11) DEFAULT 0 ,';
    for ctr := 1 to colcount do s:= s +'Column'+inttostr(ctr)+' varchar(255) DEFAULT "" ,';
    s:= s+' PRIMARY KEY (ID) ) ENGINE=MyISAM ;';
    With TempMyScript do try
      SQL.add(s);
      execute;
    finally
      Free;
    end;

{xaxis attributes}
    s:= 'Select distinct PAG.PAG_ID,PAG.Name groupname, PAN.Name , PAV.Value ,' +
        ' (Select Pany.name  from tblproductattributenames PANy where  PANy.PAG_ID = PAG.PAG_ID and PANy.PAN_ID = PAG.yAxisAttribute ) as yname '+
        ' from tblproductattributegroups PAG ' +
        ' inner join tblproductattributenames PAN on PAN.PAG_ID = PAG.PAG_ID and PAN.PAN_ID = PAG.XAxisAttribute ' +
        ' inner join tblproductattributevalues PAV on PAV.PAN_ID = PAN.PAN_ID ' +
        ' Where PAG.PAG_ID in (Select PAP.PAG_ID ' +
        ' From tblproductattributeproducts PAP  ' +
        ' inner join '+TransLineTable+' SL on SL.ProductID = PAP.ProductID and SL.'+TransIDfield+' ='+inttostr(ID)+')'+
        ' order by groupname';
    Qryx:= TempMyQuery(Self.MyConnection);
    Qryx.SQL.add(s);
    Qryx.open;
{Yaxis attributes}
    s:= 'Select distinct PAG.PAG_ID, PAG.Name groupname, PAN.NAme, PAV.value ' +
        ' from tblproductattributegroups PAG ' +
        ' Left join tblproductattributenames PAN on PAN.PAG_ID = PAG.PAG_ID and PAN.PAN_ID = PAG.yAxisAttribute ' +
        ' Left join tblproductattributevalues PAV on PAV.PAN_ID = PAN.PAN_ID '+
        ' Where PAG.PAG_ID in (Select PAP.PAG_ID ' +
        ' From tblproductattributeproducts PAP  ' +
        ' inner join '+TransLineTable+' SL on SL.ProductID = PAP.ProductID and SL.'+TransIDfield+' ='+inttostr(ID)+')'+
        ' order by groupname';
    Qryy:= TempMyQuery(Self.MyConnection);
    Qryy.SQL.add(s);
    Qryy.open;
{Flat table with yaxis names as columns}
    QryTempCaptions:= TempMyQuery(Self.MyConnection);
    QryTempCaptions.SQL.add('Select * from ' +tablename+'captions');
    QryTempCaptions.open;
      Qryy.first;
      ctr:= 1;
      while Qryy.eof = False do begin
        if s<>Qryy.fieldByname('groupname').asString then begin
          if QryTempCaptions.State in [dsEdit,dsInsert] then QryTempCaptions.Post;
          QryTempCaptions.append;
          QryTempCaptions.Fieldbyname('groupname').asString :=  Qryy.fieldByname('groupname').asString;
          QryTempCaptions.Fieldbyname('PAG_ID').asInteger   :=  Qryy.fieldByname('PAG_ID').asInteger;
          s:= Qryy.fieldByname('groupname').asString;
          ctr:= 1;
        end;
        QryTempCaptions.fieldbyname('column' +inttostr(ctr)).AsString :=Qryy.fieldbyname('Value').asString;
        ctr:= ctr+1;
        Qryy.next;
      end;
    if QryTempCaptions.State in [dsEdit,dsInsert] then QryTempCaptions.Post;

{Flat table with xaxis names as Rows}
    QryTemp:= TempMyQuery(Self.MyConnection);
    QryTemp.SQL.add('Select * from ' +tablename);
    QryTemp.open;
    Qryx.First;
    While Qryx.eof = False do begin
      QryTemp.Append;
      QryTemp.fieldbyname('Groupname').asString :=Qryx.fieldbyname('Groupname').asString;
      QryTemp.fieldbyname('PAG_ID').asInteger :=Qryx.fieldbyname('PAG_ID').asInteger;
      QryTemp.fieldbyname('xName').asString :=Qryx.fieldbyname('Name').asString;
      QryTemp.fieldbyname('xValue').asString :=Qryx.fieldbyname('Value').asString;
      QryTemp.fieldbyname('yname').asString :=Qryx.fieldbyname('yname').asString;
      QryTemp.Post;
      Qryx.Next;
    End;

    s:= 'Select distinct TL.'+TransLineIDfield+', TL.ProductID, TL.ProductName ,  '+
        ' TL.Shipped , TL.QtySold , TL.BackOrder , TL.UnitofMeasureQtySold , TL.UnitofMeasureShipped ,  '+
        ' TL.UnitofMeasureBackorder , concat(TL.' +TransLineuom+'  , "(" , TL.UnitofMeasureMultiplier , ")") as uom , '+
        '(Select min(PAG.PAG_ID) from tblproductattributegroups PAG ' +
            ' inner join tblproductattributeproducts PAP on PAG.PAG_ID = PAP.PAG_ID ' +
            ' where pap.productId = TL.ProductID) as PAG_ID,'+
        '(Select PAP.attribValue from  tblproductattributegroups PAG   '+
            ' inner join tblproductattributenames PAN on PAN.PAG_ID = PAG.PAG_ID and PAN.PAN_ID = PAG.XAxisAttribute '+
            ' inner join tblproductattributeproducts PAP on PAN.PAG_ID = PAP.PAG_ID and PAP.AttribName = PAN.Name '+
            ' where pap.productId = TL.ProductID) as xValue, '+
        '(Select PAP.attribValue  from tblproductattributegroups PAG '+
            ' inner join tblproductattributenames PAN on PAN.PAG_ID = PAG.PAG_ID and PAN.PAN_ID = PAG.yAxisAttribute '+
            ' inner join tblproductattributeproducts PAP on PAN.PAG_ID = PAP.PAG_ID and PAP.AttribName = PAN.Name '+
            ' where pap.productId = TL.ProductID) as yValue '+
        ' from '+TransLineTable+' TL '+
        ' where TL.' +TransIDfield+' = '+inttostr(ID);
    if sametext(Transtype , 'Sales') then
      s:= s + ' and ifnull(TL.BOMProductionLine, "F") ="F"';

    QryDetails:=TempMyQuery(Self.MyConnection);
    QryDetails.sQL.add(s);
    QryDetails.open;
    QryDetails.First;
    While QryDetails.Eof = False do begin
      ctr:= YValueTocolcount(QryDetails.fieldbyname('yValue').asString, QryDetails.fieldbyname('PAG_ID').asInteger);
      if ctr>0 then begin
          if QryTemp.Locate('PAG_ID;xValue' ,VarArrayof([QryDetails.fieldbyname('PAG_ID').asInteger,QryDetails.fieldbyname('xValue').asString]) , []) then begin
            editDB(QryTemp);
            QryTemp.fieldbyname('sold'+inttostr(ctr)).AsFloat :=  QryDetails.fieldbyname('UnitofMeasureQtySold').asFloat;
            QryTemp.fieldbyname('shipped'+inttostr(ctr)).AsFloat :=  QryDetails.fieldbyname('UnitofMeasureShipped').asFloat;
            QryTemp.fieldbyname('BO'+inttostr(ctr)).AsFloat :=  QryDetails.fieldbyname('UnitofMeasureBackorder').asFloat;
            QryTemp.fieldbyname('uom'+inttostr(ctr)).asString :=  QryDetails.fieldbyname('uom').asString;
            PostDB(QryTemp);
          end;
      end;
      QryDetails.Next;
    end;
  s:= '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO'+
      '~|||~{Header}Select T.*  , ' +
            'C.Phone , C.FaxNumber , C.AltPhone , C.Mobile, C.email, C.Street , C.Street2 , C.Suburb , C.State , C.Postcode ,  ' +
            'IFNULL(CC.ContactPH,C.Phone)       AS ContactPH    ,' +
            'IFNULL(`ContactAltPH`,C.AltPhone)  AS ContactAltPH ,' +
            'IFNULL(`ContactMOB`,C.Mobile)      AS ContactMOB   ,' +
            'IFNULL(`ContactFax`,C.FaxNumber)   AS ContactFax   ,' +
            'IFNULL(`ContactEmail`,C.email)     AS ContactEmail  ' ;
  if transbase is TInvoice then
    s:= s+ ', (Select Sum(PP.Balance) TotalBalance ' +
                  ' from tblSalesPrepayments  SP  '+
                  ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef   '+
                  ' Where PP.Deleted = "F" and SP.SalesRef = T.Globalref or SP.SalesRef = T.salesorderglobalref) as Prepayments,   '+
                ' (Select Sum(PP.Balance) TotalBalance  '+
                  ' from tblSalesPrepayments  SP  '+
                  ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef   '+
                  ' Where PP.Deleted = "F" and SP.SalesRef = T.Globalref or SP.SalesRef = T.salesorderglobalref) +T.payment as Totalpayment,  '+
                ' T.totalamountinc - (Select Sum(PP.Balance) TotalBalance  '+
                  ' from tblSalesPrepayments  SP  '+
                  ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef   '+
                  ' Where PP.Deleted = "F" and SP.SalesRef = T.Globalref or SP.SalesRef = T.salesorderglobalref) -payment as Invoicebalance';
  if transbase is Tsalesorder then
    s:= s+ ',(Select Sum(PP.Balance) TotalBalance  '+
                    ' from tblSalesPrepayments  SP  '+
                    ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef   '+
                    ' Where PP.Deleted = "F" and SP.SalesRef = T.Globalref ) as Prepayments,   '+
                  ' (Select Sum(PP.Balance) TotalBalance  '+
                    ' from tblSalesPrepayments  SP  '+
                    ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef   '+
                  ' Where PP.Deleted = "F" and SP.SalesRef = T.Globalref ) +T.payment as Totalpayment,'+
                  ' T.totalamountinc - (Select Sum(PP.Balance) TotalBalance  '+
                    ' from tblSalesPrepayments  SP  '+
                    ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef   '+
                    ' Where PP.Deleted = "F" and SP.SalesRef = T.Globalref ) -payment as SalesOrderbalance';
  if transbase is TSalesbase then s:= s+    ', C.Manufacture , C.JobRegistration , C.Colour , C.BodyType , C.SerialNumber , '+
                        ' C.InsuranceCompanyName , C.JobNumber , C.ExcessAmount, C.CustomerJobNumber ' ;
  s:= s+    ' from '+TransTable+' T   ' +
            'inner join tblClients C on T.ClientID = C.ClientID  ' +
            'Left join tblcontacts CC on CC.ContactID = T.contactID where '+TransIDfield+' = '+inttostr(ID) +
    '~|||~{Details}Select Captions.* , Data.* from '+tablename +' Data ' +
    'inner join '+tablename +'captions Captions on Data.PAG_ID =Captions.pag_id ' +
    '~|||~{NonAttribProducts}Select * from ' +TransLineTable+' where '+TransIDfield+' = '+inttostr(ID) +
      ' and productId not in (Select ProductId from tblproductattributeproducts) ';
    if transbase is tsalesbase then
      s:= s+'~|||~{TaxDetails}Select TTCL.`SubTaxCode`, TTCL.Percentage,    '+
              ' Sum(TTCL.`TaxAmount`) TaxAmount   '+
              ' from tblsalestaxcodelines TTCL   '+
              ' inner join tblsalestaxcodes TTC on TTCL.SalesTaxCodeID = TTC.ID '+
              ' Where TTC.SaleId = ' + inttostr(Transbase.ID) +' group by TTCL.`SubTaxCode` '+
          '~|||~{ClientCustomFields}Select  CFL.Description , CCV.Value  '+
              ' from  tblsales Trans   '+
              ' inner join tblcustomfieldvaluesClients CCV on Trans.ClientID = CCV.MasterID  '+
              ' inner join tblcustomfieldlist CFL on CFL.CFID = CCV.CustomFieldlistId  '+
              ' where ifnull(CCV.Value,"")<>"" and CFL.ListType = "ltCustomer" And Trans.SaleId = ' + inttostr(Transbase.ID)

    else
      s:= s+'~|||~{TaxDetails}Select TTCL.`SubTaxCode`, TTCL.Percentage,    '+
              ' Sum(TTCL.`TaxAmount`) TaxAmount   '+
              ' from tblpurchasetaxcodelines TTCL   '+
              ' inner join tblpurchasetaxcodes TTC on TTCL.PurchaseTaxCodeID = TTC.ID  '+
              ' Where TTC.PurchaseOrderID = ' + inttostr(Transbase.ID) +' group by TTCL.`SubTaxCode` '+
          '~|||~{ClientCustomFields}Select  CFL.Description , CCV.Value  '+
              ' from  tblpurchaseorders Trans   '+
              ' inner join tblcustomfieldvaluesClients CCV on Trans.ClientID = CCV.MasterID  '+
              ' inner join tblcustomfieldlist CFL on CFL.CFID = CCV.CustomFieldlistId  '+
              ' where ifnull(CCV.Value,"")<>"" and CFL.ListType = "ltSupplier"  And Trans.PurchaseOrderID = ' + inttostr(Transbase.ID);
    Result := s;
end;

Function TBaseTransGUI.PrintSalesPickingSlip:Boolean;
var
  reportname :STring;
begin
  reportName := tcdatautils.GetDefaultReport(30);
  if Saleslib.printsalesPickingslip(reportname,TransBase.ID, TransBase.Lines.Classname,self ,  AppEnv.Employee.ShowPreview) then begin
    TransBAse.Printdoc.PrintDoc(TransBAse.Classname,TransBAse.ID, dtPickSlip, Self.Classname , PreviewToDocumentOutputType(AppEnv.Employee.ShowPreview) , reportName);
    lblPrintedBy.Caption := DocPrintedBy;
    lblPrintedOn.Caption := transBase.Printedon;
    lblPrintedAt.Caption := transBase.PrintedAt;
  end;
  Result := true;
end;
Procedure TBaseTransGUI.SetLimit0(qry :TERPQuery);
begin
    Qry.SQL.Text := ReplaceStr(Qry.SQL.Text, 'UNION ALL', ' Limit 0 UNION ALL ' );
    Qry.SQL.Text := ReplaceStr(Qry.SQL.Text, 'Limit 0 Limit 0 UNION ALL', ' Limit 0 UNION ALL ' );
    if not Sysutils.SameText(Qry.SQL.Strings[Qry.SQL.Count - 1] , 'LIMIT 0') then Qry.SQL.Add('LIMIT 0');
end;
procedure TBaseTransGUI.SetLineLockMsg(const Value: String);
begin
  fLineLockMsg := Value;
  //TimerMsg(lblProcessMessage , Value , 2);
end;
procedure TBaseTransGUI.ShowFormulafields;
begin
  // descendants will override;
end;
procedure TBaseTransGUI.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
  QrySeconds: integer;
  MainFormToolBarHeight: integer;
  comp: TComponent;
  i:Integer;
  FldAttribfield :  TWideStringField;
  Function IsSalesForm :Boolean ;
  begin
      Result := (ClassNameIs('TInvoiceGUI')) or (ClassNameIs('TQuoteGUI')) or
                (ClassNameIs('TSalesOrderGUI')) ;
  end;
  Function IsCashSaleform :Boolean ;
  begin
      Result := (ClassNameIs('TCashSaleGUI')) or (ClassNameIs('TRefundGUI'));
  end;
  Function IsOrderform:Boolean ;
  begin
      Result := (ClassNameIs('TPurchaseGUI')) or (ClassNameIs('TReturnAGUI'));
  end;
  Function IsExpenseform :Boolean ;
  begin
      Result := (ClassNameIs('TBillGUI')) or (ClassNameIs('TfmCheque')) or
                (Classnameis('TCreditGUI'))  ;
  end;
begin
//    CapturenReplaceReportbtnclicks;

//    With TPartCalcFormula.Create(Self) do try ShowFormulaQtyFields(Self);finally Free;end;
    LblCommentsHint.Color := Self.Color;
    if chkChooseRpt.width < 120 then chkChooseRpt.width := 120;
    if (accesslevel = 2) and (KeyId = 0) then accesslevel := 1;
    stepProgressbar('Opening ' + SeparateWords(TransBase.XMLNodename)+'.');
    fbClosingForm := False;
    Processingcursor(True);
    try
      if IsProductTransaction then
        if Appenv.CompanyPrefs.ShowProductAttributes then
          if Appenv.CompanyPrefs.NoOfAttribstodisplay > 0 then begin
            CloseDB(tblDetails); { db must be cloesed before messing with fields .. so make sure }
            for i := 1 to Appenv.CompanyPrefs.NoOfAttribstodisplay do begin
              FldAttribfield :=  TWideStringField.Create(Self);
              FldAttribfield.FieldKind           := fkCalculated;
              FldAttribfield.FieldName           := 'Attrib' +IntToStr(i);
              FldAttribfield.Size                := 100;
              FldAttribfield.Name                := 'tblDetailsAttrib' +IntToStr(i);
              FldAttribfield.DataSet             := tbldetails;
              FldAttribfield.DisplayWidth        := 10;
              grdTransactions.AddField(FldAttribfield.fieldName);
            end;
          end;

      if Assigned(TransBase) then transBase.ShowStatus := ShowStatus;

      {opening an old record prior to the closing date should open the record as readonly}

      inherited;
      //CustomiseUOMField;
      ReadExtraGuiPref;
      GuiPrefs.DbGridElement[grdTransactions].RemoveFields('mstimeStamp,msUpdateSitecode,EmployeeId'+disfieldstoRemove);
      if Transbase.DatasetActive then begin
        Self.Caption := Old_Caption;
        if not fbPaymentLock then begin
          fbSaveClicked := true;
          TransBase.Save;
        end;
        Transbase.lines.closedb;
        Transbase.closedb;
        Transbase.connection.BeginTransaction;
        FormShow(nil);
        SetControlFocus(cboClientR);
      end;


      fbAllowNotInList := true; // enable default combo not-in-list processing
      fbIsModified := true;
      cboClientLookup.Connection := CommonDbLib.GetSharedMyDacConnection;
      Setlength(QueryNamesNotToOpen, 17);
      QueryNamesNotToOpen[0] := 'tblMaster';
      QueryNamesNotToOpen[1] := 'tblDetails';
      QueryNamesNotToOpen[2] := 'qrySupplier';
      QueryNamesNotToOpen[3] := 'tblFESalesLines';
      QueryNamesNotToOpen[4] := 'tblFESaleslinesRelatedPrs';
      QueryNamesNotToOpen[5] := 'qryPayments'; // applicable only for refund and cashsale
      QueryNamesNotToOpen[6] := 'qryShipContainerSaleLookup';
      QueryNamesNotToOpen[7] := 'Qrysalesshippingdetails';
      QueryNamesNotToOpen[8] := 'qrysalesdeliverydetails';
      QueryNamesNotToOpen[9] := 'qrySaleLookup';
      QueryNamesNotToOpen[10] := 'qryPONumber';
      QueryNamesNotToOpen[11] := 'qrySalesSeqno';
      QueryNamesNotToOpen[12] := 'QrySalesLinePackWeightLinesSum';
      QueryNamesNotToOpen[13] := 'QryPurchaseLinePackWeightLinesSum';
      QueryNamesNotToOpen[14] := 'tblFEPOLines';
      QueryNamesNotToOpen[15] := 'tblFEPOlinesRelatedPrs';
      QueryNamesNotToOpen[16] := 'qryPOSeqno';

      OpenQueries(QueryNamesNotToOpen);

      btnDelete.Enabled := (AccessLevel = 1) and (transAccesslevel=1);

      LoadTransRec;

      MainFormToolBarHeight := 0;
      comp := CommonLib.FindControlClass(Application.MainForm, 'TToolBar');
      if Assigned(comp) then MainFormToolBarHeight := TToolBar(comp).Height;
      Top         := ((Application.MainForm.ClientHeight - MainFormToolBarHeight - 20) - Self.Height) shr 1;
      Left        := (Application.MainForm.ClientWidth - Self.Width) div 2;
      If Empty(Old_Caption) then
        Old_Caption := Self.Caption;
    finally
      Processingcursor(False);
      grdTransactions.SetActiveField('Product');
    end;

    TimerRunOnce := true;
    actNew.Enabled :=  (((tblDetails.Active) and (tblDetails.RecordCount <> 0)) or (KeyID <> 0));
    //To Form Slow Timer (Leave at bottom On OnShow)
    FinishedTime := Now;
    if (Self.Name <> 'TBillGUI') and (Self.Name <> 'TfmCheque') and (Self.Name <> 'TCreditGUI') and not TimerRunOnce then
    begin
      QrySeconds := SecondsBetween(FinishedTime, StartTime) + 1;
      if (QrySeconds >= 7) then begin
      end;
    end;
    GlobalEvents.Notify(Self, GEVENT_FormShow);


    stepProgressbar('Opening '+TransBase.XMLNodename+'.');
    Setcolumn(true, 'LineTax' , 'Tax (Dbl Click)');
    if tbldetails.findfield('LinesOrder') <> nil then grdtransactions.ColumnByName('LinesOrder').ReadOnly := true;
    AddDefaultOrdermenuITems;
    AddCalculatormenuitem;
    AddcommentsMenu;
    AddExtraMenuItems;
    AddCalcMenuForDevMode;
    AddCopyPasteMenu;
    { NOTE: this field is used to link to back orders, it should not be available for user to change }
    grdTransactions.RemoveField('SeqNo');
    ShowFormulafields;
    //With TPartCalcFormula.Create(Self) do try ShowFormulaQtyFields(Self);finally Free;end;
end;

procedure TBaseTransGUI.ShowtaxDetails;
begin
  OpenERPListFormModal('TTransTaxDetailsGUI' , nil , OnshowTransTaxDetails);
end;

Procedure TBaseTransGUI.OnshowTransTaxDetails(Sender:TObject);
begin
  if not(Sender is   TTransTaxDetailsGUI) then exit;
  if Transbase is TSalesBase then
    TTransTaxDetailsGUI(Sender).Transtype :='S' else TTransTaxDetailsGUI(Sender).Transtype :='P';
  TTransTaxDetailsGUI(Sender).TransID:=Transbase.ID;
  if Screen.activecontrol = grdTransactions then
    TTransTaxDetailsGUI(Sender).TransLineID:=Transbase.Lines.ID;
  TTransTaxDetailsGUI(Sender).TransName := TransName;
  TTransTaxDetailsGUI(Sender).qryMain.Connection := MyConnection;
end;

Procedure TBaseTransGUI.LoadTransRec;
begin
    if KeyID <> 0 then begin
        TransBase.Load(KeyID);
        stepProgressbar('Loading '+TransBase.XMLNodeName +'#'+IntToStr(KeyID));
        TransBase.Lines;
        if TransBase.Lines.accessmanager.accesslevel = 3 then
            TransBase.Lines.accessmanager.accesslevel:= 5;
    end else begin
        TransBase.Load(KeyID);
        stepProgressbar('Adding New '+TransBase.XMLNodeName +'.');
        TransBase.New;
        TransBase.Lines;
        if TransBase.Lines.accessmanager.accesslevel = 3 then
            TransBase.Lines.accessmanager.accesslevel:= 2;
    end;
    stepProgressbar;
    if (not ClassNameIs('TCashSaleGUI')) and (not ClassNameIs('TReturnAGUI'))  then
        ShowForeignCurrencycomponnets;
    lblPrintedBy.Caption := DocPrintedBy;
    lblPrintedOn.Caption := transBase.Printedon;
    lblPrintedAt.Caption := transBase.PrintedAt;
    EnableDisableTranFunctions;
    If Empty(Old_Caption) then Old_Caption := Self.Caption;
    btnPayments.Visible := False;
    Self.Caption := Old_Caption;
    grdTransactions.Options := grdTransactions.Options + [dgEditing];
    stepProgressbar;
    TransAccessLevel:= Accesslevel;
    TransAccessMsg:= '';
    if KeyID = 0 then
        fbPaymentLock := false
    else begin
      If (TransBase is TSalesBase) and (PointsRedeemd(TransBase.ID)) then begin
            TransAccessLevel := 5;
            TransAccessMsg:='Product Reward Points Are Already Redeemed!';
      end else if (ClassNameIs('TCashSaleGUI')) and  (TCashSale(TransBase).ISPOs) and
        ((TCashSale(TransBase).paymethod = 'Layby') or (TCashSale(TransBase).islayby) or (TCashSale(TransBase).islaybyPayment)) then begin
          Self.Caption := Self.Caption + '     { Layby Transaction! - Cannot Modify }';

          fbPaymentLock := True;
      end else if (ClassNameIs('TInvoiceGUI')) and  (TSalesBase(TransBase).IsInternalOrder) then begin
          Self.Caption := Self.Caption + '     { Materials Sold for Internal Order - Cannot Modify }';

          fbPaymentLock := True;
      end else begin
        fbPaymentLock := false;
        ftLockType := ltNone;
        PaymentLockValidate;
        if fbPaymentLock then begin
            if (Self.ClassName = 'TfmCheque') then begin
                if ftLockType = ltOnHoldRec then begin
                    TransAccessLevel := 5;
                    TransAccessMsg:='Reconcile On Hold Cheque !';
                end else begin
                    TransAccessLevel := 5;
                    TransAccessMsg:='Reconciled Cheque !';
                end;
            end else
                if ClassNameIs('TCashSaleGUI') or ClassNameIs('TRefundGUI') then begin
                    if tblMaster.FieldByName('PayMethod').AsString = CHEQUE then begin
                        TransAccessLevel := 5;
                        TransAccessMsg:='Refund Cheque Has Been Deposited !';
                    end else if not Empty(tblMaster.FieldByName('PayMethod').AsString) then begin
                        TransAccessLevel := 5;
                        TransAccessMsg:='Has Been Deposited !';
                    end else begin
                        TransAccessLevel := 5;
                        TransAccessMsg:='Payment Has Been Applied !';
                        btnPayments.Visible := true;
                    end;

                end else begin
                  if ftLockType = ltProgressPaymentApplied then begin
                    TransAccessLevel := 5;
                    TransAccessMsg:='Progress Payment Has Been Applied !';
                  end else if ftLockType = ltTermProgressTransPaid then begin
                    TransAccessLevel := 5;
                    TransAccessMsg:='Progress Payment Transaction Has Been Paid!';
                  end else begin
                    if TransBase.TotalPaid <> 0 then
                      TransAccessMsg := 'Payment Has Been Applied !'
                    else if (TransBase is TPurchaseOrder) and TPurchaseOrder(TransBase).Approved then
                      TransAccessMsg := 'PO ' + APPROVEDDESC +' !'
                    else
                      TransAccessMsg := 'Unknown Reason !';
                    TransAccessLevel := 5;
                    btnPayments.Visible := true;
                  end;
                end;
                cboClientR.Enabled := false;
                grdTransactions.Options := grdTransactions.Options - [dgEditing];
            end;

      end;
      if TransAccessMsg <> '' then TransAccessMsg := 'Grid is Read-Only.  ' + TransAccessMsg;
      stepProgressbar;
        if not fbPaymentLock then begin
            if Sysutils.SameText(TransBase.BusObjectTablename , 'tblsales') then begin
                fbPaymentLock := ValidateClosingDate(tblMaster.FieldByName('SaleDate').AsDateTime);
            end else if Sysutils.SameText(TransBase.BusobjectTablename , 'tblpurchaseorders') then begin
                if Self.ClassName = 'TPurchaseGUI' then begin
                    if tblMaster.FieldByName('InvoiceDate').AsDateTime <> 0 then begin
                        fbPaymentLock := ValidateClosingDate(tblMaster.FieldByName('InvoiceDate').AsDateTime);
                    end;
                end else begin
                    fbPaymentLock := ValidateClosingDate(tblMaster.FieldByName('OrderDate').AsDateTime) ;
                end;
            end;

            if fbPaymentLock then begin
                Self.Caption := Self.Caption + '     { '+LockMsgClosingDate+' ! - Cannot Modify }';
                cboClientR.Enabled := false;
                AccessLevel := 5;
                grdTransactions.Options := grdTransactions.Options - [dgEditing];
            end;
        end;
    end;
    if AccessLevel > TransAccessLevel then TransAccessLevel := AccessLevel;

    stepProgressbar;
    fbRecEditable := True;

    //if (accesslevel <= 2) and (TransAccessLevel<=2) then SetUserLocking;
    SetUserLocking;

    Btncompleted.Enabled := True; // this should be enabled always as the comments fields are always editable;

    if AccessLevel < 5 then begin
        if tblMaster.State in [dsEdit] then tblMaster.post;
        if tblDetails.State in [dsEdit] then tblDetails.post;
    end else begin
        // this will enforce to call before edit when trying to change the data in the form - which will lock the record .
        // otherwise as the table is already in edit mode, will not lock the record
        // so don't delete
        if tblMaster.State in [dsEdit] then tblMaster.Cancel;
        if tblDetails.State in [dsEdit] then tblDetails.Cancel;
    end;
    stepProgressbar;
    if Assigned(TransBase) then TransBase.Dirty := False;

        {to lock the dataset so the form}

    with grdTransactions do begin
//      ColumnByName('UnitofMeasureSaleLines').ReadOnly := true;
//      ColumnByName('UnitofMeasurePOLines').ReadOnly := true;
      ColumnByName('CalcProfit').ReadOnly := true;
      ColumnByName('CalcProfitPercent').ReadOnly := true;
    end;
    stepProgressbar;
    Self.FullBackOrder := TransBase.IsTotalBackOrder;

    if (TransBase.ClassParent.ClassName <> 'TExpenseBase') and Self.FullBackOrder and (Self.KeyID <> 0) then begin
      if FastFuncs.PosEx('(BO)', TitleLabel.Caption) = 0 then
        TitleLabel.Caption := TitleLabel.Caption + ' (BO)';
    end;
   stepProgressbar;

end;
procedure TBaseTransGUI.NewAuditTrialentry(EventDescription:String);
var
  Audit: TAudit;
begin
      Audit:= TAudit.Create(nil);
      try
        Audit.Load(0);
        Audit.New;
        Audit.TransType:= Transbase.XMLNodeName;
        Audit.DataDescription:= 'Main';
        Audit.AuditDate:= now;
        Audit.TransGlobalref := Transbase.Globalref;
        Audit.ChangeDescription:= EventDescription;
        try
            Audit.Save;
        Except
            // kill the exception when ChangeDescription is more than 255 chars
        end;

      finally
        FreeandNil(Audit);
      end;
end;

function TBaseTransGUI.NewMenuForTrans(menuCaption:String;MenuEvent:TNotifyEvent; hasSeparator:Boolean; menuhint:String='') : TMenuItem;
begin
  result := NewMenuItem(menuCaption,MenuEvent,hasSeparator,pnlHeader.Popupmenu , menuhint);
end;
function TBaseTransGUI.NewMenuForTransGrid(menuCaption: String;  MenuEvent: TNotifyEvent; hasSeparator: Boolean; menuhint:String='') : TMenuItem;
begin
  result := NewMenuItem(menuCaption,MenuEvent,hasSeparator,grdTransactions.Popupmenu , menuhint);
end;

procedure TBaseTransGUI.NewTransBusObjinstance;
begin
  Transbase.Connection := TMyDacDataConnection.Create(Transbase);
  TMyDacDataConnection(Transbase.Connection).MyDacConnection := MyConnection;
  Transbase.BusObjEvent := DoBusinessObjectEvent;
  transbase.ConfirmFromGUI := ConfirmFromGUI;
end;

procedure TBaseTransGUI.NewTransBusObjRecord(aId: integer = 0);
begin
    CloseQueries;
    KeyID:= aId;
    NewTransBusObjinstance;
    Transbase.Load(KeyID);
    self.BeginTransaction;
    AccessLevel:= AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName);
    if aId = 0 then
      Transbase.New;
    Transbase.Lines;
    Openqueries;
    Transbase.Dirty := false;
    Caption:= TitleLabel.Caption + AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel);
    Setcontrolfocus(cboClientR);
    TransAccesslevel := Accesslevel;
    if Accesslevel <= 2 then begin
      cboClientR.Enabled := true;
      grdTransactions.Options := grdTransactions.Options + [dgEditing];
    end;
end;

procedure TBaseTransGUI.LogEmailed(const Emailed: Boolean;TemplName:string);
begin
  if not(Emailed) then exit;
  Transbase.Printdoc.PrintDoc(Transbase.className,Transbase.ID, dtmain, Self.Classname ,dotEmail,TemplName);
  if not Transbase.Connection.Connection.InTransaction then
    Transbase.Dirty := false;
end;

procedure TBaseTransGUI.LogFaxed(const Faxed: Boolean;TemplName:string);
begin
  if not(Faxed) then exit;
  Transbase.Printdoc.PrintDoc(Transbase.className,Transbase.ID, dtmain, Self.Classname ,dotFax,TemplName);
end;

procedure TBaseTransGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  xLinecount := Transbase.Lines.count;
  xTransname :=Transbase.XMLnodename;
  Self.Enabled := false;
  WriteExtraGuiPref;
  inherited;
  RollbackTransaction;
end;

function TBaseTransGUI.GetIsInvoiced: boolean;
var
  iIndex: integer;
begin
  inherited;
  Result := false;
  with tblDetails do begin
    First;
    for iIndex := 0 to RecordCount - 1 do begin
      if FieldByName('Shipped').AsFloat <> 0 then begin
        Result := true;
        Break;
      end;
      Next;
    end;
  end;
end;

procedure TBaseTransGUI.SetTerms(const LookupTable, FillTable: TDataset);
  { assumes that the base date is the creation date }
begin
  // termes are handled by PO business object
  if (self.ClassName = 'TPurchaseGUI') then
    exit;
  SetTerms(LookupTable, FillTable, cboCreationDate.Date);
  PostDB(FillTable);
end;


procedure TBaseTransGUI.SetTerms(const LookupTable, FillTable: TDataset; const dtBaseDate: TDateTime);
  var
    EOM: Boolean;
    EOMPlus: Boolean;
begin
    If (Self.ClassNameis('TBillGUI')) Or (Self.ClassNameis('TCreditGUI')) or (Self.classnameis('TQuoteGUI'))  or (Self.classnameis('TInvoiceGUI')) then exit;
    if dtBaseDate = 0 then begin
      Exit;
    end;
    EOM := LookupTable.FieldByName('EOM').AsBoolean;
    EOMPlus := LookupTable.FieldByName('EOMPlus').AsBoolean;
    if not EOM then begin // + Days
      if EditNoAbort(FillTable) then
        FillTable.FieldByName('DueDate').AsDateTime := IncDay(dtBaseDate, LookupTable.FieldByName('TermsAmount').AsInteger);
    end;

    if EOM then begin
      if not EOMPlus then begin //EOM + Days
        if EditNoAbort(FillTable) then
          FillTable.FieldByName('DueDate').AsDateTime := IncDay(IncHour(EndOfTheMonth(dtBaseDate), -1), LookupTable.FieldByName('TermsAmount').AsInteger);
      end;
    end;

    if EOM then begin // EOM + EOM + Day
      if EOMPlus then begin
        if EditNoAbort(FillTable) then
          FillTable.FieldByName('DueDate').AsDateTime := IncDay(IncHour(EndOfTheMonth(IncMonth(dtBaseDate, 1)), -1), LookupTable.FieldByName('TermsAmount').AsInteger);
      end;
    end;
end;

procedure TBaseTransGUI.setTransAccessMsg(const Value: String);
begin
  if value = '' then begin
    fsTransAccessMsg := Value;
    Exit;
  end;
  if pos(value ,fsTransAccessMsg)>0 then exit;
  fsTransAccessMsg := trim(fsTransAccessMsg + NL+Value);
end;

procedure TBaseTransGUI.RefreshCalcs;
begin
  if tblDetails.state in [dsEdit,dsInsert] then else tblDetails.Edit;
  if (Self.ClassName <> 'TInvoiceGUI') and (Self.ClassName <> 'TQuoteGUI') and (Self.ClassName <> 'TSalesOrderGUI') and
    (Self.ClassName <> 'TCashSaleGUI') and (Self.ClassName <> 'TRefundGUI') and (Self.ClassName <> 'TPurchaseGUI') then begin
    tblDetails.FieldByName('LineCostInc').AsFloat := tblDetails.FieldByName('LineCost').AsFloat *
      (1 + tblDetails.FieldByName('LineTaxRate').AsFloat);
    if tblDetails.state in [dsEdit,dsInsert] then else tblDetails.Edit;
    tblDetails.FieldByName('Invoiced').AsBoolean  := (tblDetails.FieldByName('Shipped').AsFloat > 0);
  end else begin
    if Assigned(TransBase) then begin
      transbase.Lines.Invoiced := (transbase.Lines.QtyShipped<> 0) ;
    end else
      tblDetails.FieldByName('Invoiced').AsBoolean := (tblDetails.FieldByName('Shipped').AsFloat <> 0);
  end;
end;

procedure TBaseTransGUI.AddProductOptionsProduct(const OldProductId, newProductID:Integer);
begin

end;

function TBaseTransGUI.RepairSalesSQL: String;
begin
  REsult := '';
end;

procedure TBaseTransGUI.actPreviewUpdate(Sender: TObject);
begin
  actPreview.Enabled := (tblDetails.Active) and (tblDetails.RecordCount > 0);
end;

procedure TBaseTransGUI.actPreviewExecute(Sender: TObject);
begin
  LoadTemplate(false, false);
  TransBase.Printdoc.Printdoc(TransBase.ClassName, TransBase.ID, dtmain, Self.Classname ,dotPreview , ReportToPrint);
  ReportToPrint := '';
  TransBase.Dirty:= false;
end;

procedure TBaseTransGUI.actPrintUpdate(Sender: TObject);
begin
  actPrint.Enabled := (tblDetails.Active) and (tblDetails.RecordCount > 0);
end;

procedure TBaseTransGUI.actPrintExecute(Sender: TObject);
begin
  if (Self.ClassName = 'TInvoiceGUI') and (AppEnv.CompanyPrefs.PrintPickSlipWithInvoice or AppEnv.CompanyPrefs.PrintDelDocketWithInvoice) then
    LoadTemplate(not AppEnv.Employee.ShowPreview, false, false) //Don't Close Inoice
  else LoadTemplate(not AppEnv.Employee.ShowPreview, false);
  TransBase.Printdoc.Printdoc(TransBase.ClassName, TransBase.ID, dtmain, Self.Classname ,dotPrint , ReportToPrint);
  TransBase.Dirty:= false;
  ReportToPrint:= '';
end;

{$IFDEF FORM_BASED_SELECT_SQL}
function TBaseTransGUI.IstoExcludeBoFromPrint:Boolean;
begin
  result := ((TransBase is TOrderBase) and (AppEnv.CompanyPrefs.ExcludeBOFromPrintinPO)    and (tblMaster.FieldByName('TotalAmountInc').AsFloat <> 0) )
                    or
           (((TransBase is Tsales)    and (AppEnv.CompanyPrefs.ExcludeBOFromPrintinSales) and (tblMaster.FieldByName('TotalAmountInc').AsFloat <> 0) and (not SameText(TransBase.TransName,'Quote')))  ) ;
  if result then
    result:= MessageDlgXP_Vista('Do You Wish to Exclude the Back Ordered Items From Print?' , mtConfirmation , [mbyes, mbno] , 0 ) = mryes;
end;
{$ENDIF}

Function TBaseTransGUI.LoadTemplate(const bPrint, bSave: boolean; const DoClose: boolean = true; const FileName: string = '') :Boolean ;
var
  TRTSel: TRTSelBaseTrans;
  msgoption :Word;
  sSQL: string;
  {$IFDEF FORM_BASED_SELECT_SQL}
  ExcludeBOSQL:String;
  Json: TJsonObject;
  x: integer;
  Jsonctr :Integer;
  {$ENDIF}

  {$IFDEF FORM_BASED_SELECT_SQL}
  Procedure AddMasterSourceDetails(masterds, detailds, masterfields , detailfields:String);
  begin
    if Jsonctr =0 then  Json:= JO;
    Jsonctr := Jsonctr +1;
    Json.O[IntToStr(Jsonctr)].S['master']:= masterds;
    Json.O[IntToStr(Jsonctr)].S['detail']:= detailds;
    Json.O[IntToStr(Jsonctr)].S['masterfields']:=masterfields;
    Json.O[IntToStr(Jsonctr)].S['detailfields']:= detailfields;
  end;

  Function SLPrefix:String;
  begin
    if (PosEx('with Customer Ref' , ReportToPrint)<>0) then
      result := 'SL'
    else result := 'd3';
  end;

  Procedure MakeExcludeBOSQL;
  begin
    if ExcludeBOSQL = '' then begin
      ExcludeBOSQL:= '  ';
      if IsToExcludeBoFromPrint then ExcludeBOSQL := ' AND ifnull('+SLPrefix+'.shipped,0) <> 0 ';
      if transbase is TSalesbase then
        if appenv.CompanyPrefs.RemoveHideOnPrintProductFromReports then
          ExcludeBOSQL := ExcludeBOSQL +' AND (P.HideOnPrint = "F"  and   ('+SLPrefix+'.IsRelatedProduct = "F" or ( '+SLPrefix+'.IsRelatedProduct = "T" and ifnull(d5.HideRelated,"F")  <> "T")))';
    end;

  end;
  {$ENDIF}


begin

  result := True;
  {$IFDEF FORM_BASED_SELECT_SQL}
  Tablename1 := '';
  Tablename2 :='';
  Jsonctr := 0;
  Json := nil;
  try
    ExcludeBOSQL := '';
  {$ENDIF}

    {template name }

    if REportToPrint = '' then begin
        if self is TBaseSaleGUI then ReportToPrint := ClientDefaultTemplate(self.Classname, transbase.Id)
        else if self is TPurchaseGUI then ReportToPrint := GetTemplate(TClient.ClientDefaultPOTemplateID(transbase.clientID, nil));

        if chkChooseRpt.Checked then begin
          LoadReportTypes;
          if dlgReportSelect.Execute then begin
            ReportToPrint := dlgReportSelect.SelectedItems.Text;
            inherited LoadTemplate (bPrint, bsave , Doclose, filename);
          end;
        end else if REportToPrint = '' then begin
          if self.ClassNameIs('TPurchaseGUI') and
          (tblMaster.FieldByName('TotalAmountInc').AsFloat < 0) then begin
            ReportToPrint:= 'Credit Return';
          end;
          inherited LoadTemplate (bPrint, bsave , Doclose, filename);
        end;
    end;


  {$IFDEF FORM_BASED_SELECT_SQL}
    ExcludeBOSQL := '';

    {where clause}
{----}if  Stringcontains(ReportToPrint,'(Matrix)') then begin
        ssql := PrintMatrixSQL(ReportToPrint , MatrixReporttype , TRansbase.ID);
        fbReportSQLSupplied := true;
        sSQL := sSQL + TransSpecificSQL;
{----}end else if  (Stringcontains(ReportToPrint,'(Matrix-X)')) or (Stringcontains(ReportToPrint,'(Matrix-Y)'))  then begin
        ssql := PrintMatrixYSQL(TRansbase.ID, TableName1 , Stringcontains(ReportToPrint,'(Matrix-Y)'), Stringcontains(ReportToPrint,'(BOM)') , Json);
        TableName2 := TableName1+'BOM';
        fbReportSQLSupplied := true;
{----}end else if (Self.ClassName = 'TInvoiceGUI' ) and (Sysutils.SameText(ReportToPrint , 'Invoice with details')) then begin
        sSQL:= PrintPickingSlipsLib.SQL4PickingSlipreport(ReportToPrint,json , IntToStr(TransBase.ID), TransBase.Lines.Classname);
        fbReportSQLSupplied := true;
        sSQL := sSQL + TransSpecificSQL;
{----}end else if (PosEx('with Customer Ref' , ReportToPrint)<>0) then begin
        AddMasterSourceDetails('Sales','SalesLines'       ,'SaleId'   ,'SaleID'     );
        AddMasterSourceDetails('Sales','CustomerReferals' ,'ClientID' ,'C.clientID' );
        AddMasterSourceDetails('Sales','ShippingDetails'  ,'SaleID'   ,'Sd.SalesID' );
        AddMasterSourceDetails('Sales','ProductDetails'   ,'SaleId'   ,'S.SaleId'   );
        {Sales}
        sSQL := ' Where S.' + TRansBase.IDFieldName +' = '+ IntToStr(TransBase.ID);

        {SalesLines}
        MakeExcludeBOSQL;
        sSQL := sSQL +' ~|||~ Where '+SLPrefix+'.' + TRansBase.IDFieldName +' = '+ IntToStr(TransBase.ID)+ ' and ifnull('+SLPrefix+'.BOMProductionLine, "F") ="F"  ' + ExcludeBOSQL  ;
        if (Transbase is TSales) and ( Appenv.companyprefs.SalesPrintOrderBy <> '' ) then
          sSQL := sSQL +' order by '+SLPrefix+'.' +trim(Appenv.companyprefs.SalesPrintOrderBy )+','+SLPrefix+'.sortID'
        else  sSQL := sSQL +' order by '+SLPrefix+'.sortID';

        {CustomerReferals}
        sSQL := sSQL +' ~|||~ Where R.ClientID = ' +IntToStr(Transbase.ClientId) ;
        {ShippingDetails}
        sSQL := sSQL +' ~|||~ Where SD.salesid = ' + IntToStr(TransBase.ID)+ ' Group by SD.SalesID' ;

        {ProductDetails}
        sSQL := sSQL +' ~|||~ Where '+SLPrefix+'.SaleID = ' + IntToStr(TransBase.ID)+' group by P.CommodityCode , P.Description , P.ProductUOM , P.countryofOriginID ';
        {companyInfo}
        sSQL := sSQL +' ~|||~ ';

        {TaxDetails}
        if (TemplateContainsSection('TaxDetails',ReportToPrint,x))  then
          sSQL := sSQL +'~|||~ where TTC.' +TRim(Transbase.IDFieldname)+' = ' +inttostr(Transbase.ID) +' group by TTCL.`SubTaxCode`';
        {ClientCustomFields}
        sSQL := sSQL +' ~|||~ and Trans.' +TRim(Transbase.IDFieldname)+' = ' +inttostr(Transbase.ID);

        {ShippingAddress}
        sSQL := sSQL +' ~|||~ Where S.saleId = '+ IntToStr(TransBase.ID);

        {ShippingDetails}
        sSQL := sSQL +'  ~|||~ Where salesId = '+ IntToStr(TransBase.ID);

{----}end else  if Sametext(Reporttoprint, 'Sale Tree') or Sametext(Reporttoprint, 'Quote Tree') or Sametext(Reporttoprint, 'Invoice Tree')  then begin
            if tablename1 = '' then tablename1 := GetUserTemporaryTableName(StripQuotes(Reporttoprint)+'_PrintTreeSQL');
            sSQL :=  '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN ' +
                  ' FROM tblCompanyInformation AS CO ' +
                  ' ~|||~{Details}' + salesPrintTreeSQLWithNodeSelected(Tablename1, salesPrintTreeSQL(inttostr(Transbase.ID) ))+
                  '~|||~{Sales}Select S.* , C.Phone , C.FaxNumber , C.Mobile from tblSales S inner join tblclients C on C.clientId = S.clientId where S.SaleId =  ' +IntToStr(Transbase.ID)+
                  '~|||~{TaxDetails}Select TTCL.`SubTaxCode`, TTCL.Percentage,   Sum(TTCL.`TaxAmount`) TaxAmount from tblsalestaxcodelines TTCL  inner join tblsalestaxcodes TTC on TTCL.SalesTaxCodeID = TTC.ID  '+
                        ' Where TTC.SaleId = ' + IntToStr(Transbase.ID) +' group by TTCL.`SubTaxCode` '+
                  '~|||~{ClientCustomFields}Select  CFL.Description , CCV.Value  '+
                        ' from  tblsales Trans   '+
                        ' inner join tblcustomfieldvaluesClients CCV on Trans.ClientID = CCV.MasterID  '+
                        ' inner join tblcustomfieldlist CFL on CFL.CFID = CCV.CustomFieldlistId  '+
                        ' where ifnull(CCV.Value,"")<>"" and CFL.ListType = "ltCustomer" And Trans.SaleId = ' + inttostr(Transbase.ID);
            fbReportSQLSupplied := true;
            sSQL := sSQL + TransSpecificSQL;
{----}end else if (Sysutils.SameText(ReportToPrint , 'Sales Order With Options')) or (Sysutils.SameText(ReportToPrint , 'Sales Order Manufacture')) then begin
        fbReportSQLSupplied := true;
        ssql := SalesOrderManufactureReportSQL;
        sSQL := sSQL + TransSpecificSQL;
        sSQL := sSQL + '~|||~{CompanyInfo}'
               +' SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN '
               +' FROM tblCompanyInformation AS CO';
{----}end else if (Sysutils.SameText(ReportToPrint , 'Sales Order With Options')) or (Sysutils.SameText(ReportToPrint , 'Sales Order Manufacture(Alloc)')) then begin
        fbReportSQLSupplied := true;
        ssql := SalesOrderManufactureReportSQL(true);
        sSQL := sSQL + TransSpecificSQL;
        sSQL := sSQL + '~|||~{CompanyInfo}'
               +' SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN '
               +' FROM tblCompanyInformation AS CO';
{----}end else if (PosEx('Customer Return' , ReportToPrint)= 1) then begin//end else if (Sysutils.SameText(ReportToPrint , 'Customer Return')) then begin
          fbReportSQLSupplied := False;
          ssql := ' AND d2.saleId = ' + inttostr(Transbase.ID) + '~|||~'+
                    ' AND trans.saleId = ' + inttostr(Transbase.ID)+'~|||~' ;
{----}end else if (GetReportTypeID = 106) then begin {voucher}
         sSQL :=  '~|||~ and d2.SaleID = ' + inttostr(Transbase.ID) +
                  '~|||~ where TTC.' +TRim(Transbase.IDFieldname)+' = ' +inttostr(Transbase.ID) +' group by TTCL.`SubTaxCode`'+
                  '~|||~ and Trans.' +TRim(Transbase.IDFieldname)+' = ' +inttostr(Transbase.ID);
         sSQL := sSQL + TransSpecificSQL;
         fbReportSQLSupplied := False;
{----}end else if ((Self.ClassName = 'TInvoiceGUI') or  (Self.ClassName = 'TSalesOrderGUI') ) and  (PosEx('(Repair Details)' , ReportToPrint)<>0) then begin
         fbReportSQLSupplied := TRue;
         sSQL := RepairSalesSQL;
{----}end else begin
        MakeExcludeBOSQL;
{------------}if Sysutils.SameText(ReportToPrint , 'Purchase Order (Store Away)') or Sysutils.SameText(ReportToPrint ,  'Purchase Order(Alloc)') then begin
                sSQL := ' ~|||~ WHERE PO.'+TRansBase.IDFieldName+ ' = '+IntToStr(TRansBase.ID)+ ExcludeBOSQL ;
{------------}end else if  Assigned(StrPos(PChar(ReportToPrint), PChar('Purchase Order ShipTo'))) then begin
                sSQL := ' ~|||~ WHERE P.'+TRansBase.IDFieldName+ ' = '+IntToStr(TRansBase.ID)+ ExcludeBOSQL ;
{------------}end else begin
                sSQL := ExcludeBOSQL  + ' AND d2.' + TRansBase.IDFieldName +' = '+ IntToStr(TransBase.ID);
                if transbase is TSalesorder  then sSQL := sSQL +' and ifnull('+SLPrefix+'.BOMProductionLine, "F") ="F"';
{------------}end;
              {purchase order specific}
{------------}if Self.ClassName = 'TPurchaseGUI' then begin
                          if fbGroupReportByClass then begin ReportToPrint := 'Purchase Order(Produc group)'; end;

                          if Sysutils.SameText(ReportToPrint , 'Purchase Order (Store Away)') or Sysutils.SameText(ReportToPrint ,  'Purchase Order(Alloc)') then begin
                            sSQL := sSQL + ' Group by  PurchaseLineId, '+
                                            ' ifnull(PQABatch.Value,"") ,ifnull(PQABatch.TruckLoadNo,"") , ifnull(PQABatch.ExpiryDate,0),'+
                                            ' ifnull(PBin.binnumber,""), ifnull(PBin.Binlocation,"") ';
                            if Sysutils.SameText(ReportToPrint ,  'Purchase Order(Alloc)') then sSQL := sSQL + ',ifnull(PQASn.Value,"")';
                            sSQL := sSQL + ' Order by PurchaseLineId, '+
                                            ' ifnull(PQABatch.Value,"")  ,ifnull(PQABatch.TruckLoadNo,""), ifnull(PQABatch.ExpiryDate,0),'+
                                            ' ifnull(PBin.binnumber,""), ifnull(PBin.Binlocation,"") ';
                            if Sysutils.SameText(ReportToPrint ,  'Purchase Order(Alloc)') then sSQL := sSQL + ',ifnull(PQASn.Value,"")';
                          end else begin
                            if not Assigned(StrPos(PChar(ReportToPrint), PChar('Purchase Order ShipTo'))) then begin
                              sSQL := sSQL + ' Group by PurchaseLineID ';
                            end;
                            if fbGroupReportByClass then begin
                              sSQL := sSQL + ' order by classId, productID, sortID';
                            end else begin
                              sSQL := sSQL + ' order by SortID';
                            end;
                          end;
                {invoice}
{------------}end else if Self.ClassName = 'TQuoteGUI' then begin
                       if (Sysutils.SameText(ReportToPrint , 'Quote_GroupOnCatg2')) or
                              (Sysutils.SameText(ReportToPrint , 'Invoice_GroupOnCatg2Det')) then begin
                            sSQL := ExcludeBOSQL + ' AND d2.SaleId ='+ IntToStr(TransBase.ID);
                            sSQL := sSQL +  ' Order by SecondColumn,Firstcolumn,Thirdcolumn';
                       end;
{------------}end else if Self.ClassName = 'TInvoiceGUI' then begin

                          if Sametext(Trim(ReportToPrint) ,'Invoice Grouped') or (sametext(Trim(reporttoPrint) , 'InvoiceGroup')) then begin
                            sSQL:= ExcludeBOSQL + invoicegroupSQL;
                          end else if (Sysutils.SameText(ReportToPrint , 'Invoice_GroupOnCatg3')) or
                              (Sysutils.SameText(ReportToPrint , 'Invoice_GroupOnCatg3Det')) then begin
                            sSQL := ExcludeBOSQL + ' AND d2.SaleId ='+ IntToStr(TransBase.ID);
                            sSQL := sSQL + //' Group by ' + ProductQtylib.Thirdcolumn(SLPrefix)+',' +ProductQtylib.SecondColumn(SLPrefix)+',' +ProductQtylib.Firstcolumn(SLPrefix)+
                                          ' Order by Thirdcolumn,SecondColumn,Firstcolumn';
                          end else if (Sysutils.SameText(ReportToPrint , 'Invoice_GroupOnCatg2')) or
                              (Sysutils.SameText(ReportToPrint , 'Invoice_GroupOnCatg2Det')) then begin
                            sSQL := ExcludeBOSQL + ' AND d2.SaleId ='+ IntToStr(TransBase.ID);
                            sSQL := sSQL + //' Group by ' + ProductQtylib.SecondColumn(SLPrefix)+',' +ProductQtylib.Firstcolumn(SLPrefix)+',' +ProductQtylib.Thirdcolumn(SLPrefix)+
                                            ' Order by SecondColumn,Firstcolumn,Thirdcolumn';
                          end else if (Sysutils.SameText(ReportToPrint , 'Invoice_GroupOnCatg')) or
                              (Sysutils.SameText(ReportToPrint , 'Invoice_GroupOnCatgDet')) then begin
                            sSQL := ExcludeBOSQL + ' AND d2.SaleId ='+ IntToStr(TransBase.ID);
                            sSQL := sSQL + //' Group by ' + ProductQtylib.Firstcolumn(SLPrefix)+',' +ProductQtylib.SecondColumn(SLPrefix)+',' +ProductQtylib.Thirdcolumn(SLPrefix)+
                                           ' Order by Firstcolumn,SecondColumn,Thirdcolumn';
                          end;
                {Cash Sale}
{------------}end else if Self.ClassName = 'TCashSaleGUI' then begin
                          if ReportToPrint = 'Cash Sale Grouped' then begin
                            sSQL := sSQL + ' AND '+SLPrefix+'.ProductName <> "Memo Only"';
                            sSQL := sSQL + ' GROUP By d2.SaleID,ProductID,'+SLPrefix+'.LinePrice,'+SLPrefix+'.UnitofMeasureSaleLines  order by '+SLPrefix+'.sortID';
                          end;
{------------}end;

{------------}if pos(uppercase('Order by') , upperCase(sSQL)) = 0 then begin
                    if (Transbase is Tsales) and ( Appenv.companyprefs.SalesPrintOrderBy <> '' ) then
                      sSQL := sSQL +' order by '+SLPrefix+'.' + trim(Appenv.companyprefs.SalesPrintOrderBy )+','+SLPrefix+'.sortID'
                    else if SameText(ReportToPrint, 'Invoice Summary Grouped') then
                      sSql := sSql + ' ORDER BY ProductGroup, ' + SLPrefix+'.sortID'
                    else
                      sSQL := sSQL +' order by '+SLPrefix+'.sortID';
{------------}end;

             sSQL := sSQL +'~|||~ where TTC.' +TRim(Transbase.IDFieldname)+' = ' +inttostr(Transbase.ID) +' group by TTCL.`SubTaxCode`'+
             '~|||~ and Trans.' +TRim(Transbase.IDFieldname)+' = ' +inttostr(Transbase.ID) ;
             sSQL := sSQL + TransSpecificSQL;


            {adding the repair details if its the (Repair) template for Sales Order or invoice}
{----}end;
    if Pos(uppercase('Purchase Order Est FX') , upperCase(reporttoprint))>0  then ssql := ssql+'~|||~';

    {TransComments}
{----}if (fbReportSQLSupplied) then begin
          ssql := ssql+'~|||~{TransComments}SELECT C.Comments ' +
                  ' FROM tblComments C ' +
                  ' inner join tbltranscomments TC on C.CommentsID = TC.CommentID ' +
                  ' where TC.Transtype = ' + quotedstr(transbase.xmlnodename)+' and TC.TransId = ' + inttostr(transbase.ID) +
                  ' ORDER BY seqno';
                if (Self.ClassNameis('TInvoiceGUI') and (Sysutils.SameText(ReportToPrint , 'Invoice with details'))) OR
                   (Self.ClassNameis('TSalesOrderGUI')) then begin
                      sSQL := sSQL + '~|||~{FormulaDetails}Select  SL.saleId, ifnull(fe.formulaId,0) formulaId, describeformula(fe.formula) dformula, fe.formula , fe.formulaname  '+
                                     ' from tblsaleslines  SL  '+
                                     ' Left join tblfeFormula fe  on SL.formulaid = fe.FormulaId '+
                                     ' Where SL.SaleId = ' + inttostr(Transbase.ID);
                      sSQL := sSQL + '~|||~' + ColumnHeadingsSQL('columnHeadings' );
                end;
                if (Self.ClassName = 'TInvoiceGUI' ) and (Sysutils.SameText(ReportToPrint , 'Invoice with details')) then begin
                      sSQL := sSQL + '~|||~{InvioceSalesOrder}Select SO.* from tblsales SO inner join tblSales Invoice on So.globalref = ifnull(Invoice.salesorderglobalref , "")  where invoice.saleId = ' + IntToStr(TransBase.ID);
                end;
{----}end else begin
{------------}if TemplateContainsSection('TransComments',self.ReportToPrint,x)  then
                ssql := ssql+'~|||~where TC.Transtype = ' + quotedstr(transbase.xmlnodename)+' and TC.TransId = ' + inttostr(transbase.ID) +
                          ' ORDER BY seqno';

{------------}if SameText(GetReportType,'Cash Sale') and TemplateContainsSection('Payments',self.ReportToPrint,x) then begin
                 AddSQLPortion(sSQL , x , 'and SaleID = ' + IntToStr(Transbase.ID) );
              end;

{------------}if SameText(ReportToPrint, 'Invoice Summary Grouped') then begin
                sSQL := sSQL + '~|||~  AND d2.SaleId ='+ IntToStr(TransBase.ID) + ' GROUP BY partsublevel2';
              end;

{------------}if TemplateContainsSection('StockLevels',self.ReportToPrint,x) and (Self is TBaseSaleGUI)  then begin
                  AddSQLPortion(sSQL , x , ' and SL.SaleID = ' + IntToStr(TransBase.ID) +
                                  ' group by PC.ClassID, PC.ClassName , PC.ProductID ' +
                                  ' Order by  ClassName , PartName');
                  if TemplateContainsSection('SQL',self.ReportToPrint,x)  then AddMasterSourceDetails('SQL','StockLevels','ProductId','PartsID');
              end;

{------------}if TemplateContainsSection('ETADetails',self.ReportToPrint,x) and (Self is TBaseSaleGUI)  then begin
                  AddSQLPortion(sSQL , x , ' and SL.SaleID = ' + IntToStr(TransBase.ID) +
                                  ' GROUP BY PL.PurchaseOrderID , PL.Class , PL.ProductID;');
                  if TemplateContainsSection('SQL',self.ReportToPrint,x)  then AddMasterSourceDetails('SQL','ETADetails','ProductId','PL.ProductID');
              end;
{------------}if TemplateContainsSection('Packages',self.ReportToPrint,x) then begin
                  AddSQLPortion(sSQL , x , ' and SL.SaleID = ' + IntToStr(TransBase.ID));
                  if TemplateContainsSection('SQL',self.ReportToPrint,x)  then AddMasterSourceDetails('SQL','Packages','saleLineId','pack.saleLineId')
              end;
//
{------------}if TemplateContainsSection('FormulaDetails',self.ReportToPrint,x)  then begin
                    AddSQLPortion(sSQL , x , ' Where SL.SaleID = ' + IntToStr(TransBase.ID) );
                    if TemplateContainsSection('SQL',self.ReportToPrint,x)  then AddMasterSourceDetails('SQL','FormulaDetails','SaleLineId','sl.saleLineId')
              end;
{------------}if  SameText(GetReportType,'Invoice') and TemplateContainsSection('InvioceSalesOrder',self.ReportToPrint,x) then begin
                AddSQLPortion(sSQL , x ,  ' where invoice.saleId = ' + IntToStr(TransBase.ID) );
              end;
        end;
{------}if Self is TBaseSaleGUI then
                if TemplateContainsSection('DiscountTotals',self.ReportToPrint,x)  then
                  if fbReportSQLSupplied then begin
                     ssql := ssql+'~|||~{DiscountTotals}Select MasterSale.saleId  , (select 0-S.TotalDiscount  '+
                                                                      ' from tblsales S  '+
                                                                      ' where saleid = MasterSale.SaleId ) as totalProductDiscount,  '+
                                                             ' (select (Sum(ifnull(TotalLineamountinc,0))) '+
                                                                      ' from tblsaleslines SL  '+
                                                                      ' where saleid = MasterSale.SaleId  '+
                                                                      ' and productname = ' + quotedstr(PAYMENT_DISCOUNT_PRODUCT) +') as PaymentDiscount,    '+
                                                             ' (select (Sum(ifnull(TotalLineamountinc,0)))  '+
                                                                      ' from tblsaleslines SL  '+
                                                                      ' where saleid = MasterSale.SaleId  '+
                                                                      ' and productname = ' + Quotedstr(EARLY_PAYMENT_DISCOUNT_PRODUCT) +' ) as Earlypaymentdiscount,   '+
                                                             ' (select (Sum(ifnull(TotalLineamountinc,0)))  '+
                                                                      ' from tblsaleslines SL  '+
                                                                      ' where saleid = MasterSale.SaleId  '+
                                                                      ' and productname = ' + Quotedstr(TOTALDISCOUNT_PRODUCT) +'  ) as TotalSaleDiscount,   '+
                                                             ' (Select Totalamountinc - S.totalmarkup -(0- S.TotalDiscount + (select (Sum(ifnull(TotalLineamountinc,0)))   '+
                                                                                                                                    ' from tblsaleslines SL  '+
                                                                                                                                    ' where Sl.saleid = S.SaleID   '+
                                                                                                                                    ' and (productname = ' + quotedstr(PAYMENT_DISCOUNT_PRODUCT) +
                                                                                                                                    '  or productname = ' + Quotedstr(EARLY_PAYMENT_DISCOUNT_PRODUCT) +
                                                                                                                                    ' or productname = ' + Quotedstr(TOTALDISCOUNT_PRODUCT) +'  )))  	  '+
                                                                      ' from tblsales S   '+
                                                                      ' where saleid = MasterSale.SaleId  ) as TotalSaleExdiscount,   '+
                                                             ' (select S.totalmarkup  '+
                                                                      ' from tblsales S  '+
                                                                      ' where saleid = MasterSale.SaleId ) as TotalMarkup,    '+
                                                             ' (Select 0- S.TotalDiscount + (select (Sum(ifnull(TotalLineamountinc,0)))   '+
                                                                                                    ' from tblsaleslines SL  '+
                                                                                                    ' where Sl.saleid = S.SaleID   '+
                                                                                                    ' and (productname = ' + quotedstr(PAYMENT_DISCOUNT_PRODUCT) +
                                                                                                    '  or productname = ' + Quotedstr(EARLY_PAYMENT_DISCOUNT_PRODUCT) +
                                                                                                    ' or productname = ' + Quotedstr(TOTALDISCOUNT_PRODUCT) +'  ))   '+
                                                                       ' from tblsales S  where saleid = MasterSale.SaleId ) as TotalDiscount,   '+
                                                             ' (Select S.TotalAmountInc   '+
                                                                       ' from tblsales S   '+
                                                                       ' where saleid = MasterSale.SaleId ) as SalesTotalincdisc   '+
                                                        ' from tblsales MasterSale     '+
                                                                       ' Where MasterSale.saleId = ' + IntToStr(TransBase.ID);
                    end else begin
                        AddSQLPortion(sSQL , x ,  '  Where MasterSale.saleId = ' + IntToStr(TransBase.ID) );
                    end;
    {$ENDIF}

    TRTSel := nil;
    try
      if TransBase.ClassNameIS('TInvoice') then
        TRTSel := TRTSelInvoice.Create
      else if TransBase.ClassNameIS('TQuote') then
        TRTSel := TRTSelQuote.Create
      else if TransBase.ClassNameIS('TSalesOrder') then
        TRTSel := TRTSelSalesOrder.Create
      else if TransBase.ClassNameIS('TPOSCashSale') then
        TRTSel := TRTSelPOSCashSale.Create
      else if TransBase.ClassNameIS('TCashSale') then
        TRTSel := TRTSelCashSale.Create
      else if TransBase.ClassNameIS('TRefundSale') then
        TRTSel := TRTSelRefund.Create
      else if TransBase.InheritsFrom(TSalesBase) then
        TRTSel := TRTSelSale.Create
      else if TransBase.ClassNameIS('TPurchaseOrder') then
        TRTSel := TRTSelPurchaseOrder.Create
      else if TransBase.InheritsFrom(TOrderBase) then
        TRTSel := TRTSelOrder.Create;

     if Assigned(TRTSel) then begin
       TRTSel.ID := TransBase.ID;
       TRTSel.ReportToPrint := ReportToPrint;
       TRTSel.ReportSQLSupplied := fbReportSQLSupplied;
       TRTSel.GroupReportByClass := fbGroupReportByClass;
       TRTSel.TransType := TransBase.XMLNodeName;
       TRTSel.OnUserConfirm := UserConfirmFunc;

       TRTSel.OnStepProgress := StepProgressFunc;
       TRTSel.OnShowProgressBar := ShowProgressFunc;
       TRTSel.OnHideProgressBar := HideProgressFunc;
     end
     else begin
       raise Exception.Create('Error - No Template Report Select class found for Form ' + ClassName + ' and Busininess Object ' + TransBase.ClassName);
     end;

//     with TStringList.Create do begin
//       Text := sSQL;
//       SavetoFile('c:\temp\temp1.sql');
//       free;
//     end;
      ssql := TRTSel.SelectSQL;
      if TRTSel.ReportToPrint <> '' then ReportToPrint := TRTSel.ReportToPrint;
      fbReportSQLSupplied := TRTSel.ReportSQLSupplied ;
      if not bSave then begin
//        PrintTemplateReport(ReportToPrint, sSQL, bPrint, 1 , Json);
        PrintTemplateReport(ReportToPrint, ssql, bPrint, 1 , TRTSel.Json);
      end else begin
        if Empty(FileName) then begin
//          if not SaveTemplateReport(ReportToPrint, sSQL, bPrint, 'PDF','EmailReport' , Json) then begin
          if not SaveTemplateReport(ReportToPrint, ssql, bPrint, 'PDF', 'EmailReport', TRTSel.Json) then begin
            REsult := False;
            exit;
          end;
        end else begin
          if fsFax then begin
//            SaveTemplateReport(ReportToPrint, sSQL, bPrint, 'GraphicFile', FileName, Json );
            SaveTemplateReport(ReportToPrint, ssql, bPrint, 'GraphicFile', FileName, TRTSel.Json );
          end else begin
//            SaveTemplateReport(ReportToPrint, sSQL, bPrint, 'PDF', FileName, Json);
            SaveTemplateReport(ReportToPrint, ssql, bPrint, 'PDF', FileName, TRTSel.Json);
            msgoption := MessageDlgXP_Vista('The report is exported to ' + Quotedstr(FileName), mtInformation, [mbOK], 0 , nil , '' , '' , False, nil , 'Open File Location,Open File');
            if msgoption = 100 then ShellExecute(Handle, 'Open', PChar(ExtractFilePath(fileName)) , '', '', SW_SHOWNORMAL)
            else if msgoption = 101 then ShellExecute(Handle, 'Open', PChar(fileName) , '', '', SW_SHOWNORMAL);
          end;
        end;
      end;


    finally
//      TRTSel.SQLStringList.SavetoFile('c:\temp\temp2.sql');
      TRTSel.Free;
    end;
    fbReportSQLSupplied := False;
    {$IFDEF FORM_BASED_SELECT_SQL}
    DestroyUserTemporaryTable(Tablename1);
    DestroyUserTemporaryTable(Tablename2);
    {$ENDIF}

  {$IFDEF FORM_BASED_SELECT_SQL}
  finally
      Json.Free;
      //ReportToPrint := ''; // don't initliasize it to blank - for email the template attachments are added after wards - also the print doc is written
  end;
  {$ENDIF}
end;

function TBaseTransGUI.IsBackOrder: boolean;
begin
    REsult := not Empty(TRansbase.OriginalDocNumber);
end;

function TBaseTransGUI.GetTaxAccountName: string;
begin
  {Descendant classes can use this method to determine tax account to post to.
  Default value below}
  Result := 'Tax Collected'
end;

function TBaseTransGUI.GetDocumentNoName: string;
begin
  {Descendant classes can use this method to determine the document no field.
  Default value below}
  Result := 'InvoiceDocNumber';
end;

function TBaseTransGUI.getEmailContactID: integer;
begin
  Result := fiEmailContactID;
  if result =0 then
    result := tblmaster.FieldByName('ContactID').AsInteger;
end;
procedure TBaseTransGUI.updatecomments(Sender: TwwDbGrid);
begin
   Transbase.Editdb;
   txtComments.Lines.Add(Sender.DataSource.DataSet.FieldByName('Comments').AsString);
   MemoScrollUp(txtComments);
   Application.ProcessMessages;
   Transbase.PostDB;
end;
procedure TBaseTransGUI.txtCommentsDblClick(Sender: TObject);
begin
  if accesslevel >3 then exit;
  OpenERPListFormSingleselectModal('TCommentsListGUI' , updatecomments);
end;

procedure TBaseTransGUI.MemoScrollUp(Memo: TDBMemo) ;
var
  ScrollMessage:TWMVScroll;
  i:integer;
begin
  ScrollMessage.Msg:=WM_VScroll;
  for i := 0 to Memo.Lines.Count do
  begin
   ScrollMessage.ScrollCode:=sb_LineUp;
   ScrollMessage.Pos:=0;
   Memo.Dispatch(ScrollMessage) ;
  end;
end;
procedure TBaseTransGUI.SelectAllLines;
begin
  Transbase.Lines.Iteraterecords(SelectallCallback);
end;
procedure TBaseTransGUI.SelectallCallback(const Sender: TBusObj;      var Abort: boolean);
begin
  grdTransactions.selectRecord;
end;
procedure TBaseTransGUI.SendEmailCallback(const ACommaContactEmails: string; ASilent, ASecret : boolean);
begin
  if ACommaContactEmails  <> '' then EmailTransaction(ACommaContactEmails , ASilent, ASecret );
end;

Procedure TBaseTransGUI.DoSinglecommnet(Sender: TObject);
begin
  OpenERPListFormSingleselectModal('TCommentsListGUI' , OncommentSelect , initcommentList);
end;
procedure TBaseTransGUI.OncommentSelect(Sender: TwwDbGrid);
begin
  if txtComments.DataField ='' then exit;
  if sender.DataSource.DataSet.FindField('Comments') = nil then exit;
  editDB(txtComments.datasource.DataSet);
  txtComments.datasource.DataSet.FieldByName(txtComments.DataField).AsString := trim(txtComments.datasource.DataSet.FieldByName(txtComments.DataField).AsString +NL+  sender.DataSource.DataSet.FindField('Comments').AsString);
  PostDB(txtComments.datasource.DataSet);
end;
procedure TBaseTransGUI.initcommentList(Sender: TObject);
begin
  if not(Sender is TCommentsListGUI) then exit;
end;
procedure TBaseTransGUI.DoMultiplecommnets(Sender: TObject);
begin
  inherited;
  Transbase.PostDB;
  if Transbase.Id =0 then exit;
  OpenERPFormModal('TfmTransComments' , 0 , initTransComments , true , OnTransCommentsSave)
end;
procedure TBaseTransGUI.OnTransCommentsSave(Sender: TObject);
begin
  if not (Sender is  TfmTransComments) then exit;
end;
procedure TBaseTransGUI.initTransComments(Sender: TObject);
begin
  if not (Sender is  TfmTransComments) then exit;
  TfmTransComments(Sender).Transtype := Transbase.XMLNodeName;
  TfmTransComments(Sender).TransId :=Transbase.ID;
  TfmTransComments(Sender).TransConnection := Self.Myconnection;
  TfmTransComments(Sender).formcolor := Self.color;
end;
procedure TBaseTransGUI.Swapfields(Field1, Field2, DisplayLabel:String;      Proc :TGeneralProc);
begin
    commonGuiLib.Swapfields(self ,grdTransactions ,Field1, Field2, DisplayLabel,Proc);
end;
procedure TBaseTransGUI.grdTransactionsTitleButtonClick(Sender: TObject; AFieldName: string);
var
  IsReadOnly: boolean;
  ActiveField: TField;
begin
  // Post B4 Sort Etc
  If tblDetails.Active then
    if Transbase.AccessManager.AccessLevel = 1 then begin
      if (tblDetails.RecordCount > 0) then begin
        If EditNoAbort(tblDetails) then Begin
          Try
            tblDetails.Post;
          except
            {}
          end;
          tblDetails.Edit;
        end;
      end;
    end;

  with TwwDBGrid(Sender) do begin
    if (Sametext(AFieldName , 'QtySold') or Sametext(AFieldName , 'UnitofMeasureQtySold')) and (showformuladetails) then begin
      Exit;
    end else if AFieldName = 'LinePriceInc' then begin
      Swapfields('LinePriceInc','LinePrice', 'Price (Ex)',      ApplyPricelock);
    end else if AFieldName = 'LinePrice' then begin
      Swapfields('LinePrice','LinePriceInc','Price (Inc)',ApplyPricelock);
    end else if AFieldName = 'UOMLinePriceInc' then begin
      Swapfields('UOMLinePriceInc','UOMLinePrice','UOM Price (Ex)',ApplyPricelock);
    end else if AFieldName = 'UOMLinePrice' then begin
      Swapfields('UOMLinePrice','UOMLinePriceInc','UOM Price (Inc)',ApplyPricelock);
    end else if AFieldName = 'LineCostInc' then begin
      if (Self.ClassName = 'TBillGUI') or (Self.ClassName = 'TCreditGUI') or
        (Self.ClassName = 'TfmCheque') then begin
        Swapfields('LineCostInc','LineCost','Amount (Ex)',nil);
      end else begin
        IsReadOnly:= ColumnByName('LineCostInc').ReadOnly;
        Swapfields('LineCostInc','LineCost','Cost (Ex)',nil);
        ColumnByName('LineCost').ReadOnly:= IsReadOnly;
      end;
    end else if AFieldName = 'LineCost' then begin
      if (Self.ClassName = 'TBillGUI') or (Self.ClassName = 'TCreditGUI') or
        (Self.ClassName = 'TfmCheque') then begin
        Swapfields('LineCost','LineCostInc','Amount (Inc)',nil);
      end else begin
        IsReadOnly:= ColumnByName('LineCost').ReadOnly;
        Swapfields('LineCost','LineCostInc','Cost (Inc)',nil);
        ColumnByName('LineCostInc').ReadOnly:= IsReadOnly;
      end;
    end else if AFieldName = 'UOMLineCostInc' then begin
      if (Self.ClassName = 'TBillGUI') or (Self.ClassName = 'TCreditGUI') or
        (Self.ClassName = 'TfmCheque') then begin
        Swapfields('UOMLineCostInc','UOMLineCost','UOM Amount (Ex)',nil);
      end else begin
        IsReadOnly:= ColumnByName('UOMLineCostInc').ReadOnly;
        Swapfields('UOMLineCostInc','UOMLineCost','UOM Cost (Ex)',nil);
        ColumnByName('UOMLineCost').ReadOnly:= IsReadOnly;
      end;
    end else if AFieldName = 'UOMLineCost' then begin
      if (Self.ClassName = 'TBillGUI') or (Self.ClassName = 'TCreditGUI') or
        (Self.ClassName = 'TfmCheque') then begin
        Swapfields('UOMLineCost','UOMLineCostInc','UOM Amount (Inc)',nil);
      end else begin
        IsReadOnly:= ColumnByName('UOMLineCost').ReadOnly;
        Swapfields('UOMLineCost','UOMLineCostInc','UOM Cost (Inc)',nil);
        ColumnByName('UOMLineCostInc').ReadOnly:= IsReadOnly;
      end;
      //Sales Profits
    end else if AFieldName = 'CalcProfitEx' then begin
      if (Self.ClassParent.ClassName = 'TBaseSaleGUI') then begin
        Swapfields('CalcProfitEx','CalcProfit','Profit (Inc)',nil);
      end;
    end else if AFieldName = 'CalcProfit' then begin
      if (Self.ClassParent.ClassName = 'TBaseSaleGUI') then begin
        Swapfields('CalcProfit','CalcProfitEx','Profit (Ex)',nil);
      end;
    end else if AFieldName = 'CalcProfitPercentEx' then begin
      if (Self.ClassParent.ClassName = 'TBaseSaleGUI') then begin
        Swapfields('CalcProfitPercentEx','CalcProfitPercent','% Profit (Inc)',nil);
      end;
    end else if AFieldName = 'CalcProfitPercent' then begin
      if (Self.ClassParent.ClassName = 'TBaseSaleGUI') then begin
        Swapfields('CalcProfitPercent','CalcProfitPercentEx','% Profit (Ex)',nil);
      end;
    end else if AFieldName = 'TotalLineAmount' then begin
      Swapfields('TotalLineAmount','TotalLineAmountInc','Amount (Inc)',ApplyPricelock);
    end else if AFieldName = 'TotalLineAmountInc' then begin
      Swapfields('TotalLineAmountInc','TotalLineAmount','Amount (Ex)',ApplyPricelock);
    end else if ((AFieldName = 'UnitofMeasureBackorder') and (Self.ClassName = 'TInvoiceGUI') and  IsBackOrder) then begin
      if FullBackOrder then begin
        AutoShippingRun;
      end;
    end;
  end;

  ActiveField := TwwDBGrid(Sender).GetActiveField;

  if Assigned(ActiveField) and (ActiveField.FieldName <> AFieldName) then
    TwwDBGrid(Sender).SetActiveField(AFieldName);

  TwwDBGrid(Sender).RefreshDisplay;
end;

procedure TBaseTransGUI.grdTransactionsEnter(Sender: TObject);
begin
  inherited;
  if TransBase.Lines.count = 0 then begin
          grdTransactions.Invalidate;
          imgGridWatermark.Picture:= imgSearch.Picture;
          grdTransactions.OnBeforePaint :=GridBeforePaint;
  end;

  if not (AccessLevel in [1, 2]) or not (TransAccessLevel in [1, 2]) then begin
    grdTransactions.Options    := grdTransactions.Options - [Wwdbigrd.dgEditing];
    grdTransactions.KeyOptions := grdTransactions.KeyOptions - [Wwdbigrd.dgAllowInsert];
  end;
  ApplyPricelock;
end;

procedure TBaseTransGUI.grdTransactionsCalcTitleAttributes(Sender: TObject; const AFieldName: string;  const AFont: TFont; const ABrush: TBrush; var ATitleAlignment: TAlignment);
begin
  if SameText(AFieldName , 'UnitofMeasureBackorder') then begin
    if sametext(Self.ClassName , 'TInvoiceGUI') and FullBackOrder then
      ABrush.Color := GRIDBUTTONWHITE;
  end;
  if
    SameText(AFieldName , 'LinePriceInc') or SameText(AFieldName , 'LinePrice') or
    SameText(AFieldName , 'LineCostInc') or SameText(AFieldName , 'LineCost') or
    SameText(AFieldName , 'CalcProfitEx') or SameText(AFieldName , 'CalcProfit') or
    SameText(AFieldName , 'CalcProfitPercentEx') or SameText(AFieldName , 'CalcProfitPercent') or
    SameText(AFieldName , 'TotalLineAmount') or SameText(AFieldName , 'TotalLineAmountInc') or
    SameText(AFieldName , 'Discounts') or SameText(AFieldName , 'Markup') or
    SameText(AFieldName , 'DiscountPercent') or SameText(AFieldName , 'MarkupPercent')  or
    SameText(AFieldName , 'Margin') or SameText(AFieldName , 'MarginPercent') then begin
    ABrush.Color := GRIDBUTTONWHITE;
  end;

  if SameText(AFieldName , 'LineTaxCode') then begin
    ABrush.Color := self.Color;   { default }
      ABrush.Color := GRIDBUTTONWHITE;
  end;

  With TPartCalcFormula.create(Self) do try   gridCalcTitleAttributes(Sender,AFieldName,AFont,ABrush,ATitleAlignment );  finally   Free;  end;

  if ProductHasCalcformula and (Sysutils.SameText(AFieldName ,'UnitofMeasureQtySold')) then begin
    Afont.Color := clmaroon;
    ATitleAlignment := taCenter;
    ABrush.Color := pnlTitle.color;
  end;
end;

function TBaseTransGUI.ValidateClosingDate(const TransDate: TDateTime): boolean;
var
  bValidDate: boolean;
begin
  bValidDate := true;
  if (TransDate <= AppEnv.CompanyPrefs.ClosingDate) then begin
    bValidDate := false;
  end else if Self.ClassParent.ClassNameIs('TBaseSaleGUI') or Self.ClassParent.ClassNameIs('TBaseCashGUI') then begin
    if (TransDate <= AppEnv.CompanyPrefs.ClosingDateAR) then begin
      bValidDate := false;
    end;
  end else if Self.ClassParent.ClassNameIs('TBaseOrderGUI') or Self.ClassParent.ClassNameIs('TBaseExpenseGUI') then begin
    if (TransDate <= AppEnv.CompanyPrefs.ClosingDateAP) then begin
      bValidDate := false;
    end;
  end;
  if not bValidDate then begin
    Result := true;
  end else begin
    Result := false;
  end;
end;

procedure TBaseTransGUI.actMemTransUpdate(Sender: TObject);
begin
  If Self.tblDetails.Active and Self.tblMaster.Active then
    actMemTrans.Enabled := (Self.tblDetails.RecordCount > 0) and (Self.tblMaster.State <> dsInsert)
  else
    actMemTrans.Enabled := False;
  actMemTransAuto.Enabled := actMemTrans.Enabled;
end;

procedure TBaseTransGUI.actMemTransExecute(Sender: TObject);
begin
  SavedAccessLevel := Accesslevel;
  try
    if tblMaster.FieldByName('Paid').AsBoolean then begin
      MessageDlgXP_Vista('This transaction has been paid so can not be memorised.',
        mtInformation, [mbOk], 0);
      exit;
    end
    else if tblMaster.FieldByName('Payment').AsFloat <> 0 then begin
      MessageDlgXP_Vista('This transaction has been partially paid so can not be memorised.',
        mtInformation, [mbOk], 0);
      exit;
    end;

    if Sender = actMemTransAuto then begin
        if AppEnv.CompanyPrefs.MemTransPriceUpdate then begin
            if CommonLib.MessageDlgXP_Vista('Any future Price Changes will NOT be Reflected in Memorised Auto Transactions.'#10#13 +
                'Continue?', mtWarning, [mbYes, mbNo], 0) <> mrYes then begin
                Exit;
            end;
        end;
    end;
    cboClientLookup.Locate('Company',cboClientR.Text, [loCaseInsensitive]) ;
    DoMemoriseTrans(TransBase.ID ,   cboClientLookup.FieldByName('ClientID').AsInteger , sender = actMemTransAuto , TitleLabel.Caption);
    if qryMemTrans.RecordCount > 0 then self.TransBase.Dirty:= true;
  finally
     if Accesslevel <> SavedAccessLevel then Accesslevel := SavedAccessLevel;
  end;
end;

function TBaseTransGUI.EmailTransaction(const RecipientAddress :String ='';ASilent: boolean=True; ASecret : boolean=True):Boolean;
begin
   Result := TRue;
end;

procedure TBaseTransGUI.EnableDisableTranFunctions;
var
  iIndex: integer;
begin
  for iIndex := 0 to ComponentCount - 1 do begin
    if Components[iIndex] is TWinControl then begin
      if Components[iIndex] is TwwDBLookupCombo then begin
        if Sysutils.SameText(TwwDBLookupCombo(Components[iIndex]).Name, 'cboclass') then begin
          TwwDBLookupCombo(Components[iIndex]).Enabled :=
              (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnChangeClass') in [1, 2]);
        end;
      end;
    end;
  end;
end;


procedure TBaseTransGUI.actSaveUpdate(Sender: TObject);
begin
  inherited;
  {Binny : this form needs Save button eneabled allways as the comments fields are always editable }
  //actSave.Enabled := IsOkToSave() and (((tblDetails.Active) and (tblDetails.RecordCount <> 0)) or (KeyID <> 0));
  actSave.Enabled :=  fbRecEditable and (((tblDetails.Active) and (tblDetails.RecordCount <> 0)) or (KeyID <> 0));
end;

procedure TBaseTransGUI.actNewUpdate(Sender: TObject);
begin
  inherited;
  actNew.Enabled := actSave.Enabled;
end;


procedure TBaseTransGUI.grdTransactionsExit(Sender: TObject);
begin
  inherited;

 // if tblDetails.RecordCount > 0 then begin
//    tblDetails.Edit;
//    tblDetails.Post;
//    tblDetails.Edit;
//  end;
  TransBase.Lines.PostDb;
end;

procedure TBaseTransGUI.grdTransactionsRowChanged(Sender: TObject);
begin
  inherited;
  if Assigned(Transbase) then fiLineId := Transbase.lines.ID;
  ApplyPricelock;
  LockPartCalcformulafields;
end;
procedure TBaseTransGUI.LockPartCalcformulafields;
begin
  With TPartCalcFormula.Create(Self) do try    LockPartCalcformulafields(grdtransactions , ProductHasCalcformula );  finally    Free;  end;
end;

procedure TBaseTransGUI.PaymentLockValidate;
var
  PaymentsManagement: TLockManagement;
  fiRefundChequeID:Integer;
begin
  fbPaymentLock := false;
  PaymentsManagement := TLockManagement.Create;
  try
    if Sysutils.SameText(TransBase.BusObjectTableName , 'tblsales') then begin
      if ClassNameIs('TCashSaleGUI') or ClassNameIs('TRefundGUI') or ClassnameIs('TPOSCashSaleGUI') then begin
        if not Empty(tblMaster.FieldByName('PayMethod').AsString) then begin
          fbPaymentLock := PaymentsManagement.CashSale_Locked(TransBase.ID,ftLockType);
        end else begin
          fbPaymentLock := PaymentsManagement.SaleHasPayment_Locked(TransBase.ID,ftLockType);
        end;
        if not(fbPaymentLock) and ClassNameIs('TRefundGUI') then begin
          if (Transbase <> nil) and (Transbase is TRefundSale) and (TRefundSale(TransBase).HAscheque)  then begin
            fiRefundChequeID := RefundChequeID(TRefundSale(Transbase).Globalref);
            if fiRefundChequeID <> 0 then
              fbPaymentLock := PaymentsManagement.IsChequeLocked(fiRefundChequeID, ftLockType);
          end;
        end;
      end else begin
        fbPaymentLock := PaymentsManagement.SaleHasPayment_Locked(TransBase.ID,ftLockType);
      end;
    end else if Sysutils.SameText(TransBase.BusObjectTableName , 'tblpurchaseorders') then begin
      if tblMaster.FieldByName('IsCheque').AsBoolean then begin
        fbPaymentLock := PaymentsManagement.IsChequeLocked(TransBase.ID, ftLockType);
      end else begin
        fbPaymentLock := PaymentsManagement.POHasPayment_Locked(TransBase.ID,ftLockType);
          { 3-Nov-16 Simon requested removal of this ie still allow user to edit if it ' + APPROVEDDESC +' }
//        if not(fbPaymentLock) then
//          if Appenv.CompanyPrefs.UseApprovalLevels then
//            fbPaymentLock:= PaymentsManagement.IsPOApproved(TransBase.ID);
      end;
    end;
  finally
    FreeandNil(PaymentsManagement);
  end;
end;


procedure TBaseTransGUI.grdTransactionsCalcTitleImage(Sender: TObject; Field: TField;
  var TitleImageAttributes: TwwTitleImageAttributes);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if Field.FieldName <> JOBNUMBER_MAINGRIDFIELD then begin
    if FastFuncs.PosEx('[' + Field.FieldName + ']' + ' ASC', tblDetails.IndexFieldNames) > 0 then begin
      TitleImageAttributes.ImageIndex := 0;
    end else if FastFuncs.PosEx('[' + Field.FieldName + ']' + ' DESC', tblDetails.IndexFieldNames) > 0 then begin
      TitleImageAttributes.ImageIndex := 1;
    end else begin
      // Dont show sort image.
      TitleImageAttributes.ImageIndex := -1;
    end;
  end else begin
    // Dont show sort image.
    TitleImageAttributes.ImageIndex := -1;
  end;
end;

procedure TBaseTransGUI.IsOK_to_Print(var IsOk: boolean);
begin

  if Accesslevel = 5 then begin
      IsOk := true;
      Exit;
  end;

  {Descendant classes can use this method to perform Before Save Checks.}
  fbSaveClicked := true; // set so that we can tell on the closequery event.
  try
    EditNoAbort(tblMaster);
    tblMaster.Post;
    EditNoAbort(tblMaster);
  except
  end;
end;
Procedure TBaseTransGUI.AddTranslockComponent(var lockComponents :TStringDynArray ; comp:TWincontrol);
var
  filockComponents:Integer;
begin
  filockComponents:=length(lockComponents);
  SetLength(lockComponents , filockComponents+1);
  lockComponents[filockComponents]:= comp.name;
end;
Procedure TBaseTransGUI.TranslockComponents(var lockComponents :TStringDynArray );
begin
    SetLength(lockComponents, 0);
    AddTranslockComponent(lockComponents, cboClientR);
    AddTranslockComponent(lockComponents, cboBaseForeignCurrencyCode);
    AddTranslockComponent(lockComponents, edtBaseExchangeRate);
    AddTranslockComponent(lockComponents, grdTransactions);
end;

Procedure TBaseTransGUI.ApplyTransAccesslevel(TransLocked , TranslineLocked:Boolean);
var
  fTranslockComponents :TStringDynArray ;
  ctr:Integer;
  comp:TComponent;
begin
    TranslockComponents(fTranslockComponents);
    if TransAccesslevel< AccessLevel then TransAccesslevel := Accesslevel;
    for ctr:= low(fTranslockComponents) to high(fTranslockComponents) do begin
      comp := Findcomponent(fTranslockComponents[ctr]);
      if comp <> nil then begin
           if Comp is TERPDBLookupCombo   then TERPDBLookupCombo(Comp).ReadOnly := (TransAccesslevel>2) or  TransLocked
      else if Comp is TwwDBLookupcombo    then TwwDBLookupcombo(Comp).ReadOnly  := (TransAccesslevel>2) or  TransLocked
      else if Comp is TwwDBEdit           then TwwDBEdit(Comp).ReadOnly         := (TransAccesslevel>2) or  TransLocked
      else if Comp is TwwDBGrid           then begin
        if (TransAccesslevel>2) or  TransLocked or   TranslineLocked then begin
          if dgEditing      in TwwDBGrid(Comp).Options    then TwwDBGrid(Comp).Options    := TwwDBGrid(Comp).Options    - [Wwdbigrd.dgEditing];
          if dgAllowInsert  in TwwDBGrid(Comp).KeyOptions then TwwDBGrid(Comp).Keyoptions := TwwDBGrid(Comp).KeyOptions - [Wwdbigrd.dgAllowInsert];
        end else begin
          if dgEditing      in TwwDBGrid(Comp).Options    then TwwDBGrid(Comp).Options    := TwwDBGrid(Comp).Options    + [Wwdbigrd.dgEditing];
          if dgAllowInsert  in TwwDBGrid(Comp).KeyOptions then TwwDBGrid(Comp).Keyoptions := TwwDBGrid(Comp).KeyOptions + [Wwdbigrd.dgAllowInsert];
        end;
      end;
      end;
    end;
end;

function TBaseTransGUI.IsOktodeleteLine: Boolean;
begin
  result:= not IstransLineLocked;
end;

function TBaseTransGUI.IstransLineLocked: Boolean;
begin
  LineLockMsg := '';
  Result := False;
  if not tblMaster.Active then begin
    REsult:= True;
    Exit;
  end;
  if ((TransBAse.CleanID <> 0) and (Accesslevel > 2)) or ((TransBAse.CleanID = 0) and (Accesslevel > 3)) then begin
    REsult:= True;
    LineLockMsg :='you don''t have access to delete';
    Exit;
  end;
  if not(self is TfmVoucherSale) and not(Self is TfmvoucherInvoice) then
    if (trim(Transbase.Lines.VoucherNo) <> '')  then begin
      REsult:= True;
      LineLockMsg :='Voucher # ' + Transbase.Lines.VoucherNo +' is Applied , the Item is Locked';
      Exit;
    end;
    if (Transbase.Lines.Isvoucher) then begin
      REsult:= True;
      LineLockMsg :='Voucher Record is locked';
      Exit;
    end;
end;

procedure TBaseTransGUI.AutoShippingRun;
begin
  {Descendant TBaseSaleGUI is used to perform Auto Shipping Run.}
end;
Procedure TBaseTransGUI.UnlockRelatedTables;
begin
    inherited;
    if Assigned(Transbase) then Transbase.UserLock.Unlock(Transbase.LockGroupName);
end;
function TBaseTransGUI.DocPrintedBy: string;
begin
    Result := TransBase.PrintedBy;
end;
function TBaseTransGUI.EmailOptsForm : TfmReportingOptions;
begin
  Result := TfmReportingOptions.Create(nil);
  Result.InitforParent := InitreportOptionsform;
end;
Procedure TBaseTransGUI.InitreportOptionsform(Sender:TObject);
begin
  inherited;
  if sender is TfmReportingOptions then begin
    TfmReportingOptions(Sender).chkEmailprogramconfrmation.visible := True;
    TfmReportingOptions(Sender).chkEmailprogramconfrmation.checked := DoNotAskMsg;
    TfmReportingOptions(Sender).chkEmailprogramconfrmation.onclick := DoOnDoNotAskMsgCheck;
    if DoNotAskMsg then
      TfmReportingOptions(Sender).chkEmailprogramconfrmation.caption := TfmReportingOptions(Sender).chkEmailprogramconfrmation.caption +' (' + EmailOptiontoStr(MessageOption)+')';

  end;
end;

procedure TBaseTransGUI.DoEmailTransaction;
var
  ASilent, ASecret:Boolean;
  Function ReportMessgaeOption:Integer;
  begin
    if not(DoNotAskMsg) then result := 0
    else result := MessageOption;
  end;
begin
  ReporttoPrint :='';
  try
    if not EmailShortSendMode(ASilent, ASecret , ReportMessgaeOption , DoNotAskMsg ,DoOnDoNotAskMsgCheck) then exit;
    Emailtransaction('' , ASilent, ASecret);
  finally
    REporttoPrint  :='';
  end;
end;
procedure TBaseTransGUI.DoEmailTransactionnonsilent;
begin
   Emailtransaction('' , False, False);
end;
procedure TBaseTransGUI.DoEmailTransactionSilentnSecret;
begin
   Emailtransaction('' , True, True);
end;

procedure TBaseTransGUI.cboClientRNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
  // we do not want this combos close up event to fire in the event of a new client
  // .. so we disable it.  We will resurect this event when the client form
  // .. returns.  This will be done via the update me procedure.
begin
  OnComboNotInList(Sender, LookupTable, NewValue, Accept);
end;

procedure TBaseTransGUI.UpdateMe;
begin
  inherited;
end;

procedure TBaseTransGUI.UpdateAfterMemTrans;
  // doesn't do anything here, override in desendent to perform any tasks after a
  // .. transation has been created from a Memorised-Transaction. eg update prices
begin
end;
procedure TBaseTransGUI.UpdateFromContact(Sender: TwwDbGrid);
begin
  inherited;
  if AccessLevel > 3 then    exit;
  Transbase.contactId := Sender.Datasource.dataset.FieldByName('ContactID').AsInteger;
  Transbase.PostDB;
  EmailContactID := Sender.Datasource.dataset.FieldByName('ContactID').AsInteger;
end;

procedure TBaseTransGUI.UpdateMe(const Cancelled: Boolean; const aObject: TObject);
begin
  if Cancelled then begin Exit;
    (*if Assigned(fLastComboAccessed) then     begin
      fLastComboAccessed.DataSource.DataSet.Edit;
      fLastComboAccessed.DataSource.DataSet.FieldByName(fLastComboAccessed.DataField).Clear;
      SetControlFocus(fLastComboAccessed);
      if Sysutils.SameText(fLastComboAccessed.Name, 'cboAccountLineX') then begin
        fLastComboAccessed.LookupTable.Close;
        fLastComboAccessed.LookupTable.Open;
      end;
    end;*)
  end else begin
      if LastComboAccessed = cboCurrentTransStatus then begin
        closenopendb(LastComboAccessed.LookupTable);
        if LastComboAccessed.LookupTable.Locate('Name', NewTransStatus, []) then begin
          transbase.TransStatus := NewTransStatus;
          transbase.PostDB;
        end;
      end;
  end;
end;

function TBaseTransGUI.UserConfirmFunc(aConfirmType: string;
  var Handled: boolean): boolean;
begin
  result := false;
  if SameText(aConfirmType, 'ExcludeBOFromPrint') then begin
    Handled := true;
    result:= MessageDlgXP_Vista('Do You Wish to Exclude the Back Ordered Items From Print?' , mtConfirmation , [mbyes, mbno] , 0 ) = mryes;
  end;
end;

function TBaseTransGUI.isSalesform:boolean;
begin
  result := (Self is TBaseSaleGUI) or (Self is TBaseCashGUI)
end;
function TBaseTransGUI.isPurchaseform:boolean;
begin
  result:= not(isSalesform);
end;

procedure TBaseTransGUI.ValidateCreationDate;
begin
  if fdCreationdate <> cboCreationDate.Date  then
    if cboCreationDate.Date > now then
      if ((isSalesform) and (Appenv.companyprefs.WarnWhenSalesCreationdateisfuture)) or
          ((isPurchaseform) and (Appenv.companyprefs.WarnWhenPurchaseCreationDateisfuture)) then
        CommonLib.MessageDlgXP_Vista('You Have Set This Date to the future!', mtWarning, [mbOK], 0);
  fdCreationdate:=cboCreationDate.Date;
end;

procedure TBaseTransGUI.ValidateCreationDateforFuturedate;
begin
  inherited;
  if SameText(Self.ClassName, 'TInvoiceGUI') then
    exit;

  ValidateCreationDate;
end;

function TBaseTransGUI.ValidateCreationDateWithAccess(const aFuture,APast : string) : boolean;
begin
  Result := true;
  If cboCreationDate.Date > Now then
  begin
//    if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAllowFutureDateForPODate') < 5 then
    if EmployeeHasAccess(aFuture) then
      CommonLib.MessageDlgXP_Vista('You Have Set This Date to the future!', mtWarning, [mbOk], 0)
    else begin
      CommonLib.MessageDlgXP_Vista('You don''t have access to set this date to the future!', mtWarning, [mbOk], 0);
      Result := False;
    end;
  end
  else if cboCreationDate.Date < Today() then
  begin
//    if AppEnv.AccessLevels.GetEmployeeAccessLevel('fnAllowReverseDateForPODate') < 5 then
    if EmployeeHasAccess(APast)  then
      MessageDlgXP_Vista('You Have Set This Date To The Past!', mtWarning, [mbOk], 0)
    else
    begin
      MessageDlgXP_Vista('You Don''t Have Access To Set This Date To The Past!', mtWarning, [mbOk], 0);
      Result := false;
    end;
  end;
  if Result then
    fdCreationdate:=cboCreationDate.Date
  else
    cboCreationDate.Date := fdCreationDate;
end;

procedure TBaseTransGUI.cboCreationDateEnter(Sender: TObject);
begin
  inherited;
  fdCreationdate:=cboCreationDate.Date;
end;

procedure TBaseTransGUI.cboCreationDateExit(Sender: TObject);
begin
  inherited;
  if tblMaster.FieldByName(cboCreationDate.DataField).AsDateTime = 0 then begin {date can not be blank}
    if not (tblMaster.State in [dsEdit,dsInsert]) then tblMaster.Edit;
    tblMaster.FieldByName(cboCreationDate.DataField).AsDateTime := Now;
  end;

  if tblMaster.Active and (tblMaster.State in [dsEdit, dsInsert]) and
    (not (tblMaster.FieldByName(cboCreationDate.DataField).AsDateTime = Null)) then begin
    if (tblMaster.FieldByName(cboCreationDate.DataField).AsDateTime <= AppEnv.CompanyPrefs.ClosingDate) then begin
      CommonLib.MessageDlgXP_Vista('You Have Set This Date Before The Closing Date !' + #13 + #10 + '' + #13 + #10 +
        'The Date Will Automatically be Set To Today''s Date ' + #13 + #10 + '' + #13 + #10 + 'OR' + #13 +
        #10 + '' + #13 + #10 + 'Reset The Closing Date In Preferences.', mtWarning, [mbOK], 0);
      EditDB(tblMaster);
      tblMaster.FieldByName(cboCreationDate.DataField).AsDateTime := Now;
    end else begin
      if (Self.ClassParent.ClassName = 'TBaseExpenseGUI') or (Self.ClassParent.ClassName = 'TBaseOrderGUI') then begin
        if (tblMaster.FieldByName(cboCreationDate.DataField).AsDateTime <= AppEnv.CompanyPrefs.ClosingDateAP) then begin
          CommonLib.MessageDlgXP_Vista('You Have Set This Date Before The Closing Date !' + #13 + #10 + '' + #13 +
            #10 + 'The Date Will Automatically be Set To Today''s Date ' + #13 + #10 + '' + #13 + #10 + 'OR' +
            #13 + #10 + '' + #13 + #10 + 'Reset The Closing Date In Preferences.', mtWarning, [mbOK], 0);
          EditDB(tblMaster);
          tblMaster.FieldByName(cboCreationDate.DataField).AsDateTime := Now;
        end;
      end else begin
        if (tblMaster.FieldByName(cboCreationDate.DataField).AsDateTime <= AppEnv.CompanyPrefs.ClosingDateAR) then begin
          CommonLib.MessageDlgXP_Vista('You Have Set This Date Before The Closing Date !' + #13 + #10 + '' + #13 +
            #10 + 'The Date Will Automatically be Set To Today''s Date ' + #13 + #10 + '' + #13 + #10 + 'OR' +
            #13 + #10 + '' + #13 + #10 + 'Reset The Closing Date In Preferences.', mtWarning, [mbOK], 0);
          EditDB(tblMaster);
          tblMaster.FieldByName(cboCreationDate.DataField).AsDateTime := Now;
        end;
      end;
    end;
  end;
end;


procedure TBaseTransGUI.tblMasterAfterOpen(DataSet: TDataSet);
var
  fld: TField;
begin
  inherited;
  { this will force reload for correct company }
  closedb(qryClientLookup);
  InitERPLookupCombonFields;
  opendb(qryClientLookup);

  {Old Master Values For Accounting Obj}
  //ClientID
  if tblMaster.Findfield('ClientID') <> nil then begin
    OldClientID := tblMaster.FieldByName('ClientID').AsInteger;
  end else begin
    OldClientID := 0;
  end;
  //AccountID
  if tblMaster.Findfield('AccountID') <> nil then begin
    OldMasterAccountID := tblMaster.FieldByName('AccountID').AsInteger;
  end else begin
    OldMasterAccountID := 0;
  end;
  fld:= tblMaster.FindField('OrderDate');
  if Assigned(fld) then
    TDateTimeField(fld).DisplayFormat:= FormatSettings.ShortDateformat;
  SetForeignFieldDisplayFormat;
end;

procedure TBaseTransGUI.btnPaymentsClick(Sender: TObject);
var
  TempSQL : string;
  TransPaymentList: TBaseListingGUI;
begin
  inherited;
  if (Self.ClassName = 'TInvoiceGUI') or (Self.ClassName = 'TRefundGUI')  or (Self.ClassName = 'TfmvoucherInvoice') then begin
    TempSQL      := ' SELECT "Customer Payment" DblClickType ,  Concat_ws("",PaymentNo) as "Receipt No",PaymentDate as "Payment Date",Payment as "Payment Amount", ' +
                    ' ReferenceNo as "Reference No",tbldepositline.PaymentID ' +
                    ' FROM tbldeposits INNER JOIN tbldepositline Using(PaymentID) ' +
                    ' WHERE CustomerPayment="T" AND tbldeposits.Customer="T" AND Deleted="F" AND TrnType<>"Prepayment" ' +
                    ' AND SaleID=  '+inttostr(TransBase.Id) ;
    if transbase is TInvoice then
      TempSQL := TempSQL +' union all ' +
      ' Select '+quotedstr(CUSTOMER_PREPAYMENT) +' DblClickType , Concat("Prepayment of " , if(S.IsInvoice="T" , "Inv" , "SO") , "#" , S.sAleID) , PP.PrePaymentDate , PP.Balance , PP.ReferenceNo , PP.PrePaymentID ' +
      ' FRom tblPrepayments PP ' +
      ' inner join tblsalesprepayments SP on PP.globalref = SP.PrepayRef ' +
      ' inner join tblsales S on S.GlobalRef = SP.SalesRef ' +
      ' where ifnull(PP.Balance,0)<>0 and PP.Deleted = "F" and SP.SalesRef in ('+ Quotedstr(TInvoice(transbase).globalref)+' , '+ Quotedstr(TInvoice(transbase).SalesOrderGlobalRef)+') ' ;
    TempSQL := TempSQL +' ORDER BY "Payment Date" DESC;';

  end else if (Self.ClassName = 'TBillGUI') or (Self.ClassName = 'TCreditGUI') or (Self.ClassName = 'TPurchaseGUI') then
  begin
    TempSQL      := 'SELECT "Supplier Payment" DblClickType , Concat_ws("",PaymentNo) as "Receipt No",PaymentDate as "Payment Date",Payment as "Payment Amount", ' +
      'ReferenceNo as "Reference No",tblwithdrawallines.PaymentID ' +
      'FROM tblwithdrawal INNER JOIN tblwithdrawallines Using(PaymentID) ' +
      'WHERE SupplierPayment="T" AND tblwithdrawal.Supplier="T" AND Deleted="F" AND TrnType<>"Prepayment" ' +
      'AND POID=' + IntToStr(TRansBase.ID) + ' ' + 'ORDER BY PaymentDate DESC;';

  end else begin
    Exit;
  end;

  // get a new instance of the payment list form
  TransPaymentList := GetBaseListingByClassName('TTransPaymentListGUI', false, Self);
  TransPaymentList.qryMain.SQL.Text := TempSQL;
  TransPaymentList.RefreshOrignalSQL;
  //TypInfo.SetStrProp(TransPaymentList, 'DblClickType', DblClickType);
  TransPaymentList.FormStyle := fsMdiChild;
  TransPaymentList.titleLabel.Caption  := Transbase.XMLNodeName +' # ' + inttostr(Transbase.ID);
  TransPaymentList.BringToFront;
end;

procedure TBaseTransGUI.btnPDFClick(Sender: TObject);
var
  filename :String;
begin
  inherited;
  //if PDFReportDialog.Execute then        filename := PDFReportDialog.Filename    else exit;
  filename := transbase.xmlnodename +'#' + inttostr(transbase.ID) +'.PDF';
  if SaveDialog1.Execute then begin
    filename :=  SaveDialog1.FileName;
  end else begin
    Exit;
  end;


  LoadTemplate(false, True, True , filename);
  TransBase.Printdoc.Printdoc(TransBase.ClassName, TransBase.ID, dtmain, Self.Classname ,dotPDF , ReportToPrint);
  TransBase.Dirty:= false;
  ReportToPrint := '';
end;

function TBaseTransGUI.CanEditTransPricenCost: Boolean;
begin
  REsult:= True;
end;
procedure TBaseTransGUI.actCustomerContactsUpdate(Sender: TObject);
begin
  inherited;

  if cboClientR.Visible then begin
    // Has there been a customer specified?
    if cboClientR.Text = '' then begin
      // Yes, Disable contact button.
      if btnContacts.Enabled then begin
        btnContacts.Enabled := false;
      end;
    end else begin
      // Otherwise, Enable it.
      if not btnContacts.Enabled then begin
        btnContacts.Enabled := true;
      end;
    end;
  end else begin
    // Otherwise, disable it.
    if btnContacts.Enabled then begin
      btnContacts.Enabled := false;
    end;
  end;
end;
procedure TBaseTransGUI.initcontactList(Sender: TObject);
begin
  if not(Sender is   TContactListGUI) then exit;
  TContactListGUI(Sender).clientId := tblMaster.FieldByName('ClientID').AsInteger;
  TContactListGui(Sender).Caller := self;
end;
procedure TBaseTransGUI.actCustomerContactsExecute(Sender: TObject);
begin
  OpenERPListFormSingleselectModal('TContactListGUI' ,UpdateFromContact , initcontactList );
end;

procedure TBaseTransGUI.tblMasterBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  GlobalEventsObj.GlobalEvents.Notify(tblMaster, GEVENT_BeforeDelete);
end;

procedure TBaseTransGUI.TmrCommentshintTimer(Sender: TObject);
begin
  inherited;
  lblCommentsHint.Visible := False;
  lblCommentsHint.Refresh;
  TmrCommentshint.Enabled := fAlse;
end;

procedure TBaseTransGUI.tblDetailsBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  GlobalEventsObj.GlobalEvents.Notify(tblDetails, GEVENT_BeforeDelete);
end;

procedure TBaseTransGUI.cboClientLookupAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cboClientLookup.IndexFieldNames := 'Company ASC CIS';
end;

procedure TBaseTransGUI.actDeleteUpdate(Sender: TObject);
begin
  inherited;
  if fbPaymentLock then begin
    btnDelete.Enabled := false;
  end else begin
    btnDelete.Enabled := true;
  end;
end;

function TBaseTransGUI.ActiveFieldname: String;begin  Result := TField(grdTransactions.GetActiveField).fieldname;end;

// override in decendents to perform any processing after data has been
  // committed to database

procedure TBaseTransGUI.AfterCommit;
begin
end;


procedure TBaseTransGUI.KeyIdChanged(const NewKeyId: integer);
begin
  logInuseform;
  // override to prevent default behaviour - DO NOT REMOVE THIS.
end;

procedure TBaseTransGUI.SetUserLocking;
begin

    if fbRecEditable then
      if assigned(Transbase) then begin
          if NOT Transbase.LockRec then begin
              AccessLevel := 5; // read only
              CommonLib.MessageDlgXP_Vista(Transbase.UserLock.LockMessage + #13 + #10 + #13 + #10 + GetFormClassDescription +
                ' access will be changed to read-only.', mtWarning, [mbOK], 0);
              fbRecEditable:= False;
          end;
      End;

  if UserLock.Enabled and  fbRecEditable then begin
    // remove all existing locks
    UserLock.UnlockAllCurrentInstance;

    if (KeyId > 0) and tblMaster.Active and (tblMaster.FieldByName('ClientId').AsInteger > 0) then begin
      if assigned(TransBase) then begin
          if not TransBase.Lock then AccessLevel := 5; // message is displayed in the busobj

      end else
        if not UserLock.Lock(TransBase.BusObjectTableName, KeyId, GetFormClassDescription) then begin
        AccessLevel := 5; // read only
        CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + #13 + #10 + #13 + #10 + GetFormClassDescription +
          ' access will be changed to read-only.', mtWarning, [mbOK], 0);
      end;
    end;
  end;
  //if Accesslevel = 5 then begin
    EnableDisable;
  //end;
end;

function TBaseTransGUI.GetFormClassDescription: string;
begin
  Result := TypeToDescription(ClassNameToTranType(Self.ClassName));
end;

procedure TBaseTransGUI.cboClientREnter(Sender: TObject);
begin
  inherited;
  if Assigned(cboClientR.DataSource.DataSet) and
     cboClientR.DataSource.DataSet.Active and
     (not cboClientR.SpecialItemSelected) then
    LastSelectedClientName := cboClientR.DataSource.DataSet.FieldByName(cboClientR.DataField).AsString;
end;

function TBaseTransGUI.GetMyQueryByName(Const ComponentName: string): TERPQuery;
begin
  Result := TERPQuery(FindComponent(ComponentName));
  if not Assigned(Result) then raise Exception.Create('Could not find component "' + ComponentName + '"');
end;

function TBaseTransGUI.GetCancelGridSort: Boolean;
begin
  result := inherited;
  if not result then
    result := (mnuLockSorting.Caption <> LockSortingCaption);
end;

function TBaseTransGUI.GetComboByName(Const ComponentName: string): TwwDbLookupCombo;
begin
  Result := TwwDbLookupCombo(FindComponent(ComponentName));
  if not Assigned(Result) then raise Exception.Create('Could not find component "' + ComponentName + '"');
end;

function TBaseTransGUI.GetDBEditByName(Const ComponentName: string): TwwDbEdit;
begin
  Result := TwwDbEdit(FindComponent(ComponentName));
  if not Assigned(Result) then raise Exception.Create('Could not find component "' + ComponentName + '"');
end;

function TBaseTransGUI.GetLabelByName(Const ComponentName: string): TLabel;
begin
  Result := TLabel(FindComponent(ComponentName));
  if not Assigned(Result) then raise Exception.Create('Could not find component "' + ComponentName + '"');
end;
Procedure TBaseTransGUI.ChooseRelatedParts(Sender: TDatasetBusObj);
begin
  if not (Sender is TRelatedProduct) then exit;
  if TRelatedProduct(Sender).Count =0 then exit;

  fsRElatedPartIDs := '';
  fRelatedProductObj :=TRelatedProduct(Sender);
  try
    OpenERPListFormultiselectModal('TRelatedProductSelectionGUI',initRelatedProducts, DoOnRelatedProductsSelect);
    if fsRElatedPartIDs = '' then fsRElatedPartIDs := '0';
    Sender.LoadSelect('RelatedID in ( ' + fsRElatedPartIDs +')');
  finally
    fRelatedProductObj := nil;
  end;
end;
procedure TBaseTransGUI.initRelatedProducts(Sender: TObject);
begin
  if not (Sender is TRelatedProductSelectionGUI) then exit;
  TRelatedProductSelectionGUI(Sender).FilterString := 'ParentID = ' + inttostr(fRelatedProductObj.ParentProductID);
  TRelatedProductSelectionGUI(Sender).SelectCannotDeleteProducts := False;
  TRelatedProductSelectionGUI(Sender).SelectAllProducts := True;
  TRelatedProductSelectionGUI(Sender).ListTimerMsg('Choose the Products to be added to ' + transbase.xmlnodename +' for the Product ' + transbase.Lines.productname +' as it''s Related Parts');
  if Transbase.Lines is TSalesLineBase then
  TRelatedProductSelectionGUI(Sender).SelectedProductIds := TSalesLineBase(Transbase.Lines).SelectedProductIds;
end;
procedure TBaseTransGUI.DoOnRelatedProductsSelect(Sender: TwwDbGrid);
begin
  fsRElatedPartIDs := SelectedIDs(sender, 'RelatedID');
end;
procedure TBaseTransGUI.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited;

    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TTransBase         then TTransBase(Sender).DataSet     := tblMaster;
        if Sender is TTransLineBase     then TTransLineBase(Sender).DataSet := tblDetails;
    end  else if (Eventtype = BusobjEvent_ToDo ) and (Value =  BusobjEvent_AddRelatedParts) then begin
        if Appenv.Employee.ShowRelatedProductSelectioninSale and Appenv.Companyprefs.ShowRelatedProductSelectioninSale  then begin
          ChooseRelatedParts(Sender);
          showProgressbar('Related Parts' , Sender.Count);
        end;
    end  else if (Eventtype = BusobjEvent_ToDo ) and (Value =  BusobjEvent_AddedRelatedParts) then begin
      HideProgressbar;
    end  else if (Eventtype = BusobjEvent_ToDo ) and (Value =  BusobjEvent_AddingRelatedParts) then begin
      StepProgressbar;
(*    end  else if (Eventtype = BusobjEvent_ToDo ) and (Value =  BusobjEvent_CalculationsDisabled) then begin
      lblDisableCalc.visible := TransBase.Lines.count > appenv.CompanyPrefs.TransLinesToDisableCalcs;*)
    end else if (EventType = BusobjEvent_ToDo) and (Value = BusObjEvent_PartBarcodeNotfound)  then begin
      Createbarcode(transbase.lines.Partbarcode);
    end else if (EventType = BusobjEvent_ToDo) and (Value = BusobjProcessPQADetailClasses)  then begin
      ProcessPQADetailClasses(Sender);
    end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_ProductChanged)  then begin
      if Sender  = transbase.lines then begin
          LockPartCalcformulafields;
          if ProductHasCalcformula then   begin
            transbase.lines.FormulaQtySoldValue := 1;
            With TPartCalcFormula.Create(Self) do try InitformulaQtyValues(transbase.Lines); finally Free; end;
          end;
      end;
    end else if (EventType = BusobjEvent_Event) and (Value = BusObjEventVal_ShipAllFormula)  then begin
      if (screen.activecontrol = grdTransactions) and ProductHasCalcformula then begin
        grdTransactions.SetActiveField('formulaQtyShippedValue');
      end;
    end else if (EventType = BusobjEvent_Event) and (Value = BusObjEventVal_ShipAllQty)  then begin
      if (screen.activecontrol = grdTransactions)  then begin
        grdTransactions.SetActiveField('UnitofMeasureShipped');
      end;
    end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_TransQtyChanged)  then begin
      if (screen.activecontrol = grdTransactions) and ProductHasCalcformula then begin
          if  (sametext(GrdTransactions.getActiveField.fieldname , 'UnitofMeasureQtySold')) then begin
              Transbase.Lines.FormulaQtySoldValue := 0;
          end else if  (sametext(GrdTransactions.getActiveField.fieldname , 'UnitofMeasureShipped')) then begin
            Transbase.Lines.FormulaQtyShippedValue := 0;
          end;
      end;
    end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_CreationDate)  then begin
      ValidateCreationDateforFuturedate
    end else if (EventType = BusObjEvent_todo) and (Value = BusObjEventVal_SaveValidate)  then begin
            transbase.fbSaveGUIValidate := True;
            if not Validdatamsg then begin
                transbase.fbSaveGUIValidate := False;
                Exit;
            end;
    end else if (EventType = BusobjEvent_Event) and (Value = BusObjEventVal_maincontactDisabled) then begin
      if Transbase.DisabledMaincontactName <> '' then
        //TimerMsg(lblProcessMessage , Transbase.DisabledMaincontactName+'  of ' + Transbase.ClientName + ' is Selected as the main contact for ' + Transbase.XMLNodeName +', but is flagged as "Do not use as any Main contact".' , 20);
        ShowTimedHint(grdtransactions ,   Transbase.DisabledMaincontactName+'  of ' + Transbase.ClientName + ' is Selected as the main contact for ' + Transbase.XMLNodeName +', '+
                                      ' but is flagged as "Do not use as any Main contact".'  , false, 5000 , grdtransactions.Width-4 , 0 , Self.color, clred);
    end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_FCChanged) and (Sender is TTransBase) then begin
      SetForeignFieldDisplayFormat;
    end else begin
      BusObjProgressbarEvent(Sender,EventType, Value);
    end;
end;
procedure TBaseTransGUI.doCalculate(Sender: Tobject);
begin
  doCalculate;
end;
function TBaseTransGUI.doCalculate:Boolean;
var
  fd:double;fs:String;
  ActiveField: TField;
begin
  Result:= False;
  ActiveField := grdTransactions.GetActiveField;
  if not Assigned(ActiveField)        then begin
    TransTimerMsg('Please choose the field to calculate.' , 5);
    exit;
  end;
  if not(ActiveField is TFloatfield ) then begin
    TransTimerMsg('Please choose the field to calculate. Only numeric fields can be calculated.' , 5);
    Exit;
  end;
  if ActiveField.readonly             then begin
    TransTimerMsg(ActiveField.fieldname + ' that you have selected is read-only.' , 5);
    Exit;
  end;
  if Sysutils.SameText(grdTransactions.GetActiveField.FieldName , 'LineTax') then begin
    TransTimerMsg('Tax cannot be Calculated, its Automatically Calculated from the Price/Cost and the Taxcode Selected.' , 5);
    exit;// linetax is a calculated field
  end;
  if Accesslevel >3                   then begin
    TransTimerMsg('You don''t have enough access to change.' , 5);
    exit;
  end;
  DoCalc(fd , fs);
  result := True;
  if fd=0 then exit;
  transbase.lines.editdb;
  ActiveField.asFloat := fd;
  //transbase.lines.ProductDescription := transbase.lines.ProductDescription  + fs;
  transbase.lines.PostDB;
end;


function TBaseTransGUI.ProcessPQADetailClasses(Const Sender: TDatasetBusObj): STring;
var
  strSql:String;
  FromClassId:Integer;
  StockTransfer:TStockTransferEntry;
  StockTransferIds:String;
  Qry:TERPQuery;
begin
  REsult := '';
  StockTransferIds:= '';
  strSQL:= ProductTables(tDetailswithSno, false);
  strSQL:= 'Select  ' +
            ' distinct PQA.PQAID, PQA.transdate,PQADC.ClassID fromclassId,  PQA.transId,  PQA.transLineId,   ' +
            ' PQA.DepartmentID toclassId ,  PQA.ProductID,  PQA.productname,  PQA.UOMID ,  PQA.uom ,  PQA.uommultiplier, ' +
            ' PQABatch.Value as Batchno,  PQABatch.ExpiryDate as ExpiryDate, ' +
            ' PQABins.binId as binID,  PBin.BinLocation,  PBin.BinNumber, ' +
            ' PQASN.value as Serialno , ' +
            ' PQADC.PQAType,'+
            ' PQADBatch.Value BatchFrom ,PQADBatch.ExpiryDate ExpiryDateFrom,  '+
            ' BinFrom.Binlocation as Binlocationfrom, BinFrom.Binnumber as binnumberFrom ,   '+
            ' PQADSn.Value Serialnofrom ,   ' +
            ' /*ifnull(ifnull(PQASN.UOMQty, ifnull(PQABins.UOMQty , PQABAtch.UOMQty)),0)*/ PQADC.uomqty -   ' +
                          ' ifnull((Select Sum(STL.UOMTransferQty)   ' +
                          ' from tblstocktransferentrylines STL    ' +
                          ' inner join tblstocktransferentry ST on ST.TransferEntryID = STL.TransferEntryID   ' +
                          ' where ST.Processed="T"  and STL.PQADetailClassRef = PQADC.GlobalRef),0) uomQty, ' +
            '  PQADC.GlobalRef  ' +
            ' From ' +strSQL +
            ' Left  join  tblpqadetailsclass PQADBatch  on PQADBatch.PQADetailID  = PQABAtch.PQADetailID  and PQADBatch.PQAID   = PQABAtch.PQAID ' +
            ' Left  join  tblpqadetailsclass PQADBin    on PQADBin.PQADetailID    = PQABins.PQADetailID   and PQADBin.PQAID     = PQABins.PQAID ' +
            ' Left  join  tblProductbin      BinFrom    on BinFrom.binId          = PQADBin.Value         and PQADBin.PQAType   = "Bin" '+
            ' Left  join  tblpqadetailsclass PQADSn     on PQADSn.PQADetailID     = PQASN.PQADetailID     and PQADSn.PQAID      = PQASN.PQAID ' +
            ' inner join  tblpqadetailsclass PQADC      on PQADC.PQADetailID      = ifnull(PQASN.PQADetailID, ifnull(PQABins.PQADetailID , PQABAtch.PQADetailID)) and PQADC.PQAID = ifnull(PQASN.PQAID, ifnull(PQABins.PQAID , PQABAtch.PQAID)) ' +
            ' inner join  ' +TTransbase(Sender).lines.BusObjectTableName+ ' L on PQA.transId = L.' + TTransbase(Sender).idfieldname +' and PQA.translineID = L.'+TTransbase(Sender).lines.IDFieldname+' and PQA.transtype = ' +quotedstr(TTransbase(Sender).lines.classname) +
            ' where L.Deleted = "F" and PQA.transId = ' + inttostr(TTransbase(Sender).id) + ' order by fromclassId ' ;
  try
  Qry := TERPQuery(Transbase.getNewDataset(strSQL,true));
  With qry do try
    filter := 'uomQty<>0';
    Filtered:= true;
    if recordcount =0 then exit;

    TTransbase(Sender).Connection.BeginNestedTransaction;
    try
      First;
      FromClassId:= 0;
      StockTransfer:=nil;
      while Eof = False do begin
        if FromClassId <>  FieldByname('FromClassId').asInteger then begin
          if StockTransfer<> nil then begin
            if (StockTransfer.lines.count> 0) and (StockTransfer.Save) and (StockTransfer.Process) then begin
              if result <> '' then result := result +',';
              result := result + inttostr(StockTransfer.ID);
              StockTransfer.Connection.CommitNestedTransaction;
            end else begin
              StockTransfer.Connection.RollbackNestedTransaction;
            end;
            Freeandnil(StockTransfer);
          end;
        end;
        if StockTransfer = nil then begin
          StockTransfer:=TStockTransferEntry.create(Self);
          StockTransfer.connection := TTransbase(Sender).connection;
          StockTransfer.loadSelect('SalesRef = ' +quotedstr(TTransbase(Sender).Globalref)+' and TransferFromClassID = ' +inttostr(FieldByname('FromClassId').asInteger)+ ' and Processed ="F"');
          StockTransfer.Connection.BeginNestedTransaction;
          if StockTransfer.count=0 then begin
            StockTransfer.New;
            StockTransfer.AccountID := Appenv.Companyprefs.DefPartsAssetAccount;
            StockTransfer.TransferFromClassName := tcDatautils.GetClassName(FieldByname('FromClassId').asInteger);
            StockTransfer.DateTransferred := now;
            StockTransfer.Description := 'Stock Transfer for ' +TTransbase(Sender).XMLNodename+' # ' +inttostr(TTransbase(Sender).ID);
            StockTransfer.SalesRef := TTransbase(Sender).Globalref;
            StockTransfer.PostDB;
            FromClassId :=FieldByname('FromClassId').asInteger;
          end;
        end;
        if not StockTransfer.lines.locate('PQADetailClassRef' ,  Fieldbyname('GlobalRef').AsString , []) then begin
          StockTransfer.Lines.New;
          StockTransfer.Lines.PQADetailClassRef :=Fieldbyname('GlobalRef').AsString;
        end;
        StockTransfer.Lines.ProductId       := Fieldbyname('ProductID').asInteger;
        StockTransfer.Lines.UnitOfMeasure   := Fieldbyname('UOM').asString;
        StockTransfer.Lines.ClassIDTo       := Fieldbyname('toclassId').asInteger;
        StockTransfer.Lines.UOMTransferQty  := Fieldbyname('UOMQty').asFloat;
        if StockTransfer.Lines.product.batch then begin
          TSTELinesFlat(StockTransfer.Lines).BatchNoFrom     := Fieldbyname('BatchFrom').asString;
          TSTELinesFlat(StockTransfer.Lines).ExpiryDateFrom  := Fieldbyname('ExpiryDateFrom').asDatetime;
        end;
        if StockTransfer.Lines.product.multiplebins then begin
          TSTELinesFlat(StockTransfer.Lines).binlocationFrom := Fieldbyname('Binlocationfrom').asString;
          TSTELinesFlat(StockTransfer.Lines).BinnumberFrom   := Fieldbyname('binnumberFrom').asString;
        end;
        if StockTransfer.Lines.product.sntracking then begin
          TSTELinesFlat(StockTransfer.Lines).SerialNumbers   := Fieldbyname('Serialnofrom').asString;
        end;
        if StockTransfer.Lines.product.batch then begin
          TSTELinesFlat(StockTransfer.Lines).BatchNoto       := Fieldbyname('BAtchno').asString;
          TSTELinesFlat(StockTransfer.Lines).ExpiryDateto    := Fieldbyname('ExpiryDate').asDatetime;
        end;
        if StockTransfer.Lines.product.multiplebins then begin
          TSTELinesFlat(StockTransfer.Lines).binlocationto   := Fieldbyname('Binlocation').asString;
          TSTELinesFlat(StockTransfer.Lines).Binnumberto     := Fieldbyname('Binnumber').asString;
        end;
        TSTELinesFlat(StockTransfer.Lines).TransferUOMAllocatedQty:= Fieldbyname('UOMQty').asFloat;
        StockTransfer.Lines.PostDB;
        Next;
      end;
      if StockTransfer<> nil then begin
            if (StockTransfer.lines.count> 0) and (StockTransfer.Save) and (StockTransfer.Process) then begin
              if result <> '' then result := result +',';
              result := result + inttostr(StockTransfer.ID);
              StockTransfer.Connection.CommitNestedTransaction;
            end else begin
              StockTransfer.Connection.RollbackNestedTransaction;
            end;
            Freeandnil(StockTransfer);
      end;

    Except
       on E:Exception do begin
         TTransbase(Sender).Connection.RollbackNestedTransaction;
       end;
    end;
  finally
    closenFree;
  end;
  finally
    Freeandnil(StockTransfer);
  end;
end;

procedure TBaseTransGUI.tblDetailsBeforePost(DataSet: TDataSet);
begin
  inherited;
  RecDeleted:= false;
  if Dataset.RecordCount > 0 then
    RecDeleted := Dataset.Fieldbyname('Deleted').AsBoolean;
end;

procedure TBaseTransGUI.cboBaseForeignCurrencyCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
  Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  ShowForeignCurrencycomponnets;
  TRansBase.PostDb;
end;

procedure TBaseTransGUI.ShowForeignCurrencycomponnets;//(const Value: boolean);
var
    Value :Boolean;
begin
    Value := False;
    if Transbase.ForeignExchangeCode <> '' then
        if transBase.ForeignExchangeCode <> AppEnv.RegionalOptions.ForeignExDefault then
            Value := true;
    lblBaseForeignTotal.Visible := Value;
    edtBaseForeignTotal.Visible := Value;
    SetForeignFieldDisplayFormat;
end;


procedure TBaseTransGUI.ShowGridLockMsg;
begin
  if TransAccessMsg <> '' then
      TransTimerMsg(TransAccessMsg , 5);
end;

function TBaseTransGUI.ShowLineTaxDetails: boolean;
begin
  Result := False;
  if SameText(grdTransactions.GetActiveField.fieldname ,'LineTax') then begin
    OpenERPListFormModal('TTransTaxDetailsGUI' , nil , OnshowTransTaxDetails);
    Result := True;
  end;
end;
Procedure TBaseTransGUI.check4VoucherLock(const aMsg:String);
begin
      if MessageDlgXP_Vista(trim(aMsg + NL + LineLockMsg), mtWarning, [mbok], 0, nil, '', '', false, nil,
        iif((trim(Transbase.Lines.VoucherNo) <> '') and (isinteger(Transbase.Lines.VoucherNo)), 'Open Voucher #' + trim(Transbase.Lines.VoucherNo), '')) = 100 then
        if SaleIDForCoucher(Transbase.Lines.VoucherNo) <> 0 then OpenERPForm('TfmVoucherSale', SaleIDForCoucher(Transbase.Lines.VoucherNo), nil, nil, false, false)
        else if accesslevel < 3 then
          if MessageDlgXP_Vista('The Voucher  #' + trim(Transbase.Lines.VoucherNo) + ' is Deleted, Do You Wish to Remove the Link?', mtWarning, [mbyes, mbno], 0) = mrYes then begin
            Transbase.Lines.EnablePropertySetWhenReadonly := true;
            try
              Transbase.Lines.VoucherNo := '';
              Transbase.Lines.PostDB;
              grdTransactions.AddField('Voucherno');
              grdTransactions.SetActiveField('Voucherno');
            finally
              Transbase.Lines.EnablePropertySetWhenReadonly := False;
            end;
          end
          else MessageDlgXP_Vista('The Voucher  #' + trim(Transbase.Lines.VoucherNo) + ' is Deleted', mtWarning, [mbok], 0);
end;
function TBaseTransGUI.IsOktodelete: Boolean;
begin
  REsult := True;
      if Transbase.lines.count = 1 then begin
        if not IsOktodeleteLine then begin
          Result := False;
          check4VoucherLock(trim(Transbase.lines.Productname) +' is Locked and Cannot be Deleted.');
        end;
      end else begin
        fiLockedLines := 0;
        Transbase.Lines.IterateRecords(IsOktodeleteCallback);
        if fiLockedLines = Transbase.lines.count then begin
          if not IsOktodeleteLine then begin
            Result := False;
            MessageDlgXP_Vista('All lines are locked in this record and cannot be deleted' , mtWarning,[mbok] , 0 );
          end;
        end;
      end;
end;

procedure TBaseTransGUI.IsOktodeleteCallback(const Sender: TBusObj;  var Abort: boolean);
begin
  if not IsOktodeleteLine then
    fiLockedLines := fiLockedLines +1;
end;

function TBaseTransGUI.IsOkToSave: boolean;
begin
  if (AccessLevel <= 3) then
    Result := True
  else
    Result := inherited IsOkToSave;
end;

Function TBaseTransGUI.DoProductallocation(const LineObj :TProdQty):Boolean ;
begin
  TfmAllocation.ShowProductDetails(True);
  try
    LineObj.PostDB;
    Result := TfmAllocation.DoBinBatchform(LineObj.PQA , Self);
  finally
    TfmAllocation.ShowProductDetails(False);
  end;
end;


procedure TBaseTransGUI.doReCalculate(Sender: Tobject);

var
  iAL:Integer;
begin
  inherited;
  iAL:= TransBase.AccessManager.AccessLevel;
  try
    if devmode then TransBase.AccessManager.AccessLevel:= 1;
    try
      lblDisableCalc.Click;
    Except
      on E:Exception do begin
        Transbase.connection.RollbackTransaction;
        Transbase.connection.BeginTransaction;
        MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
        Exit;
      end;
    end;
    Transbase.Lines.PostDb;
    Transbase.PostDb;
    Transbase.connection.CommitTransaction;
    Transbase.Dirty := False;
    Self.Close;
  finally
    TransBase.AccessManager.AccessLevel := iAL;
  end;
end;


Procedure TBaseTransGUI.DeleteEmptyLines(const AMemo :TDBMemo);
var
  i: Integer;
begin
  inherited;
  if AccessLevel >= 5 then Exit;
  if not tblMaster.Active then Exit;

  If EditNoAbort(tblMaster) then
  Try
    if AMemo.Lines.Count > 0 then  begin
      i := 0;
      while i < AMemo.Lines.Count do    begin
          if AMemo.Lines[i] = '' then       begin
              AMemo.lines.Delete(i);
              i := i - 1;
          end;
          i := i + 1;
      end;
    end;
  Finally
      if (tblMaster.State in [dsEdit]) then tblMaster.Post;
  End;
end;

procedure TBaseTransGUI.txtClientDetailsEnter(Sender: TObject);
begin
  inherited;
    DeleteEmptyLines(TDBMemo(sender));
end;

procedure TBaseTransGUI.txtClientDetailsExit(Sender: TObject);
begin
  inherited;
    DeleteEmptyLines(TDBMemo(sender));
end;

procedure TBaseTransGUI.OverrideAccessLevel(Sender: TObject);
begin
  inherited;
  TmrCommentshintTimer(TmrCommentshint);
  if Assigned(tblMaster.FindField('IsLayby')) and tblMaster.Fieldbyname('IsLayby').AsBoolean then
    exit;
  SavedAccessLevel := Accesslevel;
  if fbRecEditable  then begin
    AccessLevel := AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName) ;
    if assigned(TransBase) then
      TransBase.AccessManager.AccessLevel := AccessLevel;
    if AccessLevel < 3 then begin
      if sender is TDBEdit  then
        TDBEdit(Sender).ReadOnly := false;
      if sender is TDBMemo  then
        TDBMemo(Sender).ReadOnly := false;
    end;
  end;
end;

procedure TBaseTransGUI.RestoreOverridenAccessLevel(Sender: TObject);
begin
  inherited;
  if Assigned(tblMaster.FindField('IsLayby')) and tblMaster.Fieldbyname('IsLayby').AsBoolean then
    exit;
  if Accesslevel = SavedAccessLevel then Exit;
  if assigned(Transbase) then     begin
      Transbase.postDB;
      if (btnCompleted.enabled = False) and (TransBase.dirty) then btnCompleted.enabled := true;
      TransBase.AccessManager.AccessLevel := SavedAccessLevel;
      if TransBase.AccessManager.AccessLevel=1 then Transbase.EditDB;
  end else if tblmaster.state in [dsedit,dsInsert] then tblMaster.Post;
  AccessLevel := SavedAccessLevel;
end;

procedure TBaseTransGUI.txtCustomIDDblClick(Sender: TObject);
begin
  inherited;
  if trim(LineLockMsg) <> '' then
    check4VoucherLock(trim(Transbase.lines.Productname) +' is Locked.' );
end;

procedure TBaseTransGUI.txtTotalTaxDblClick(Sender: TObject);
begin
  inherited;
  ShowtaxDetails;
end;


procedure TBaseTransGUI.grdTransactionsCalcCellColors(Sender: TObject;  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;ABrush: TBrush);
begin
  inherited;
  if (not Assigned(field)) or (grdTransactions.DataSource.DataSet.RecordCount = 0) then exit; { just in case user switches off all fields in gui prefs }
  if Assigned(Transbase) then
        if Field.REadonly then
            if TransBase.Lines.Id = fiLineId then
                AFont.Color := $00695678; // clInactiveCaption;
  With TPartCalcFormula.create(Self) do
  try
    gridCalcCellColors(ProductHasCalcformula , Sender,Field,State,Highlight,AFont,ABrush);
  finally
    Free;
  end;

  if screen.ActiveForm = self then
    try
      if Sametext(Field.FieldName ,'PQA') then
        if (Transbase.Lines.ProductID>0) and (Transbase.Lines.Product.batch or Transbase.Lines.Product.Multiplebins or Transbase.Lines.Product.SNtracking) then
          if Transbase.Lines.IsPQAItem then
                 if (Appenv.CompanyPrefs.IndicateifBatchAllocated) and (Transbase.Lines.PQABatches.Count  > 0)  then ABrush.Color := Appenv.CompanyPrefs.BatchAllocationColour
            else if (Appenv.CompanyPrefs.IndicateifBinAllocated  ) and (Transbase.Lines.PQABins.Count     > 0)  then ABrush.Color := Appenv.CompanyPrefs.BinAllocationColour
            else if (Appenv.CompanyPrefs.IndicateifSNAllocated   ) and (Transbase.Lines.PQASNs.Count      > 0)  then ABrush.Color := Appenv.CompanyPrefs.SNAllocationColour;
    Except
      // kill the exception if not PQAitem
    end;

    if Transbase.Lines is TSalesLineBase then begin
      if Appenv.companyprefs.IndicateContainerRelatedProduct then
        if TSalesLineBase(Transbase.Lines).isContainer then
          ABrush.Color := Appenv.CompanyPrefs.ContainerRelatedProductColour;
      if Appenv.companyprefs.IndicatePalletRelatedProduct then
        if TSalesLineBase(Transbase.Lines).IsPallet then
          ABrush.Color := Appenv.CompanyPrefs.PalletRelatedProductColour;
    end;

end;

procedure TBaseTransGUI.grdTransactionsDblClick(Sender: TObject);
begin
   if Showallocationform then exit;
   if showMatrixform then exit;
   if ShowProductQtybinETA then exit;
   if ShowLineTaxDetails then exit;
   if showformuladetails then exit;
end;
function TBaseTransGUI.showMatrixform: Boolean;
var
    fsFieldname :STring;
begin
  Result := False;
  fsFieldname := StringReplace(grdTransactions.GetActiveField.Fieldname , 'Attrib' , '' , [rfIgnoreCase]);
  if IsInteger(fsFieldname) then
    result := (strtoInt(fsFieldname) >= 1) and (strtoInt(fsFieldname) <= Appenv.CompanyPrefs.NoOfAttribstodisplay);
  if result then
    TfmProdAttribmatrix.DoproductAttribute(Self, Transbase.Lines, Transbase.Lines.Product.ProductAttributeProduct.PAG_ID, True);
    //TDelayDoProductMatrix.DoProductAttribute(Self, Transbase.Lines, Transbase.Lines.Product.ProductAttributeProduct.PAG_ID, True);
end;

//Function TBaseTransGUI.ShoRPDetailsForm:Boolean;
//begin
//   Result := True;
//end;

function TBaseTransGUI.Showallocationform:Boolean;
var
    fsFieldname :STring;
    islocked:Boolean;
begin
Result := False;
try
  fsFieldname := grdTransactions.GetActiveField.Fieldname;
  if Sysutils.SameText(fsFieldname , 'PQA') then begin
    if accesslevel >2 then begin
      MessageDlgXP_Vista('You have readonly access', mtWarning, [mbOK], 0);
      Exit;
    end;
      if (transbase.lines.ProductId =0) then exit;
      if not (IsInvProduct(transbase.lines.Product.Producttype)) then begin
        MessageDlgXP_Vista(transbase.lines.productname + ' is ' + quotedstr(Producttypename(transbase.lines.product.ProductType)) +' type.  Allocation is only for inventory products', mtWarning, [mbOK], 0);
        exit;
      end;
      if (transbase.lines.product.Batch = False) and ( transbase.lines.product.Multiplebins = False) and ( transbase.lines.product.SnTracking = False) Then begin
        MessageDlgXP_Vista(transbase.lines.productname + ' has none of the allocations  - Batch / Bin / Serial Number tracking - turned on', mtWarning, [mbOK], 0);
        exit;
      end;
      REsult := True;
        transbase.lines.PQAlloation := '-';
        try
          islocked := (AccessLevel >= 5 ) OR
                    ((tblDetails.findField('UnitofMeasureShipped') <> nil) and (tblDetails.findField('UnitofMeasureShipped').readonly)) OR
                    (not(dgEditing in grdTransactions.Options));
          BeforeAllocationformShow;
          transbase.Lines.PostDB;
          if (transbase is TsalesOrder) and (TSalesOrder(transbase).Lines.isTreeItem) then begin
              if TSalesOrder(transbase).lines.ID =0 then exit;
                TfmBOMAllocation.DoAllocation(TSalesOrder(transbase).ID, TSalesOrder(transbase).lines.ID , TSalesOrder(transbase));
          end else
            TfmAllocation.DoBinBatchform(transbase.Lines.PQA, self, islocked, true);
        finally
            transbase.lines.PQAlloation := '+';
        End;
  end;
Except
  on E:EXception do begin
    MessageDlgXP_Vista('1:' +E.Message, mtWarning, [mbOK], 0);
  end;
end;
end;

procedure TBaseTransGUI.btnCompletedClick(Sender: TObject);
begin
  inherited;
  // binny :DONOT REMOVE. The action associated with the button has this event in the execute and
  // descendants having the definition. removing this will loose the link between the action and
  // the event handler
end;

procedure TBaseTransGUI.btnDeleteClick(Sender: TObject);
var
  msgOption:Integer;
  Flag:Boolean;
begin
  inherited;
    msgOption:= 102;
    self.ActiveControl:= nil;
    if not(IsOktodelete) then exit;
    if TransBase.Lines.Count > 0 then begin
      if (transbase.lines.count = 1) and (IsOktodeleteLine ) then begin
        if MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation,[mbyes,mbno] , 0 ) = mryes then
                  msgOption:=101;
      end else  if  not IsOktodeleteLine then begin
        if MessageDlgXP_Vista(QuotedStr(Transbase.lines.Linedescription) +' is locked.  Do You Wish To Delete all unlocked Lines?', mtConfirmation,[mbYes,mbNo] , 0 ) = mryes then msgOption:= 101 else msgOption:=  102;
      end else begin
//        msgOption:= MessageDlgXP_Vista('Do You Wish To Delete This Line or Delete all Lines?', mtConfirmation,[] , 0 ,nil , '' , '' , False, nil , 'This Line,All Lines,Cancel' );
        msgOption:= MessageDlgXP_Vista('What Do You Wish To Delete?', mtConfirmation,[] , 0 ,nil , '' , '' , False, nil , 'This Line,All Lines,Selected Lines,Cancel' );
      end;
      if msgOption = 103 then exit;

      Flag := transbase.Lines.DoFieldChangewhenDisabled ;
      transbase.Lines.DoFieldChangewhenDisabled := TRue;
      try
        transbase.Lines.dataset.disableControls;
        try
               if (msgOption = 100) or (transbase.lines.count = 1) then begin
                 if transbase.Lines.dataset.State in [dsInsert] then
                   transbase.Lines.CancelDb
                 else
                   DeleteLine;
               end
          else if msgOption = 101 then DeleteallLines
          else if msgOption = 102 then DeleteSelectedLines
          else Exit;
        finally
          TransBase.DoCalcOrderTotals;
          transbase.Lines.dataset.EnableControls;
        end;
      finally
        transbase.Lines.DoFieldChangewhenDisabled := Flag;
      end;

    end;
end;

procedure TBaseTransGUI.btnEditClick(Sender: TObject);
begin
  inherited;
  transbase.connection.BeginTransaction;
  transbase.connection.BeginNestedTransaction;
  try
    if TfmSelectProduct.SelectProduct(Self) then begin
      transbase.Lines.PostDB;
      transbase.connection.CommitNestedTransaction;
    end else begin
      transbase.Lines.canceldb;
      transbase.connection.RollbackNestedTransaction;
    end;
  Except
    on E:Exception do begin
      transbase.connection.RollbackNestedTransaction;
    end;
  end;
end;

procedure TBaseTransGUI.btnNextClick(Sender: TObject);
begin
  inherited;
  if not Save4NewTrans then exit;
  transbase.Dirty := False;
  OpenERPForm(classname, 0, nil, nil, False, false);
  closewait;
end;

procedure TBaseTransGUI.tblDetailsCalcFields(DataSet: TDataSet);
var
  i:Integer;
  FldAttribfield :  TField;
begin
  inherited;
  if Dataset.state <> dsCalcFields then exit;
    if not(Assigned(transbase)) then exit;
    transbase.lines.PQAlloation := '+';
    if (IsProductTransaction)  and (TransBase.Lines.ProductID <> 0) then
      if Appenv.CompanyPrefs.ShowProductAttributes and (TransBase.Lines.ProductId <> 0) then
        if (Appenv.CompanyPrefs.NoOfAttribstodisplay > 0) and (TransBase.Lines.Product.ProductAttributeProduct.count > 0) then begin
          TransBase.Lines.Product.ProductAttributeProduct.Dataset.first;
          for i := 1 to Appenv.CompanyPrefs.NoOfAttribstodisplay do begin
            FldAttribfield := Dataset.FindField('Attrib' +IntToStr(i));
            if (assigned(FldAttribfield))  then
              TWideStringField(FldAttribfield).AsString :=TransBase.Lines.Product.ProductAttributeProduct.attribValue;
            TransBase.Lines.Product.ProductAttributeProduct.Dataset.Next;
            if TransBase.Lines.Product.ProductAttributeProduct.Dataset.Eof then break;
          end;
        end;
end;

procedure TBaseTransGUI.grdTransactionsMouseUp(Sender: TObject;  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Button <> mbLeft then exit;
  Showallocationform;
end;
procedure TBaseTransGUI.mnuMarkupPercClick(Sender     : TObject);begin  inherited;  ChangeCurfield('MarkupPercent')  ;end;
procedure TBaseTransGUI.mnuMarkupDollarClick(Sender   : TObject);begin  inherited;  ChangeCurfield('Markup')         ;end;
procedure TBaseTransGUI.mnuDiscountDollarClick(Sender : TObject);begin  inherited;  ChangeCurfield('Discounts')      ;end;
procedure TBaseTransGUI.mnuDiscountPercClick(Sender   : TObject);begin  inherited;  ChangeCurfield('DiscountPercent');end;

Procedure TBaseTransGUI.ChangeCurfield(const FldName:String);
var
  PreviousFieldName: string;
begin
  inherited;
  PreviousFieldName := grdTransactions.SelectedField.FieldName;
  if PreviousFieldName <> FldName then begin
    grdTransactions.RemoveField(PreviousFieldName);
    grdTransactions.AddField(FldName);
    tblDetails.FieldByName(FldName).Index := tblDetails.FieldByName(PreviousFieldName).Index;

    if SameText(FldName , 'Margin')           then grdTransactions.ColumnByName(FldName).DisplayLabel := 'Margin ('  +AppEnv.RegionalOptions.CurrencySymbol+')';
    if SameText(FldName , 'Markup')           then grdTransactions.ColumnByName(FldName).DisplayLabel := 'Markup ('  +AppEnv.RegionalOptions.CurrencySymbol+')';
    if SameText(FldName , 'Discounts')        then grdTransactions.ColumnByName(FldName).DisplayLabel := 'Discount ('+AppEnv.RegionalOptions.CurrencySymbol+')';

    if SameText(FldName , 'MarginPercent')    then grdTransactions.ColumnByName(FldName).DisplayLabel := 'Margin (%)';
    if SameText(FldName , 'MarkupPercent')    then grdTransactions.ColumnByName(FldName).DisplayLabel := 'Markup (%)';
    if SameText(FldName , 'DiscountPercent')  then grdTransactions.ColumnByName(FldName).DisplayLabel := 'Discount (%)';
  end;

end;


function TBaseTransGUI.MatrixReporttype: String;
begin
  REsult := 'Sales';
end;

function TBaseTransGUI.Matrixshown: Boolean;
begin
  result := False;
  if ((Appenv.CompanyPrefs.ShowProductAttributes ) and (Transbase.Lines.Product.isAttribProduct)) then begin
        //TfmProdAttribmatrix.DoproductAttribute(Self, Transbase.Lines, Transbase.Lines.Product.ProductAttributeProduct.PAG_ID);
        TDelayDoProductMatrix.DoproductAttribute(Self, Transbase.Lines,Transbase.Lines.Product.ProductAttributeProduct.PAG_ID);
        REsult := True;
  end;
end;

function TBaseTransGUI.ProductOptionsShown: Integer;
begin
  result := -1;
  if Transbase.Lines is TSalesLineBase then begin
    if ((Appenv.CompanyPrefs.ShowProductOptions ) and (Transbase.Lines.Product.HasProductOptions)) then begin
        Result:= TfrmProductOptionsDesignGUI.DoProductOption(self, TSalesLineBase(Transbase.Lines));
    end;
  end
  else
  if Transbase.Lines is TPurchaseOrderLine then begin
    if ((Appenv.CompanyPrefs.ShowProductOptions ) and (Transbase.Lines.Product.HasProductOptions)) then begin
        Result:= TfrmProductOptionsDesignGUI.DoProductOption(self, TSalesLineBase(Transbase.Lines));
    end;
  end;
end;

function TBaseTransGUI.GetIsProductTransaction: boolean;
begin
  result:= False;
  if tblDetails.findfield('Productname') <> nil then
    Result := tblDetails.findfield('Productname').Visible;
end;


function TBaseTransGUI.ShowProductQtybinETA: Boolean;
Var
  Frm : TComponent;
  SelectForm: TBaseListingGUI;
  i:integer;
  Procedure ShowShippingContainer;
  begin
    frm:= GetComponentByClassName('TfrmShipContainer');
    if assigned(frm) then begin
      with TfrmShipContainer(frm) do begin
        Connection := MyConnection;
        TfrmShipContainer(frm).KeyID := tcDataUtils.getShipContainerID(tblDetails.Fieldbyname('ShipContainerName').AsString);
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
        Exit;
      end;
    end;
  end;

begin
  Result := False;
  i := 0;
  if IsProductTransaction then
    if not AppEnv.Employee.NoQtyDrillDownOnSales then begin
      if Sysutils.SameText(TField(grdTransactions.GetActiveField).FieldName , 'ShipContainerName') then begin
        if grdTransactions.GetActiveField.DisplayName = 'Ship Container' then begin
          if tblDetails.Fieldbyname('ShipContainerName').AsString <> '' then begin
            i := CommonLib.MessageDlgXP_Vista('This Product has already been assigned to a container. Do you wish to change to another container?', mtconfirmation, [mbyes,mbNo,mbCancel], 0,nil,'' ,'' ,False ,nil,'View Existing');

            if i  = 100 then begin  {hard coded because this custom button does not have a constant}
              ShowShippingContainer;
              exit;
            end;
          end;

          if i = mrYes then begin
            SelectForm:= TBaseListingGUI(GetComponentByClassName('TfrmShippingContainerList', false));
            If not Assigned(SelectForm) then Exit;
            SelectForm.OnGridDataSelect:= DoOnGridDataSelect;
            SelectForm.grdMain.Options:= SelectForm.grdMain.Options + [dgRowSelect];
            SelectForm.ShowModal;

            grdTransactions.DataSource.DataSet.Fieldbyname('ShipContainerName').LookupDataSet.Close;
            grdTransactions.DataSource.DataSet.Fieldbyname('ShipContainerName').LookupDataSet.Open;
            grdTransactions.DataSource.DataSet.Refresh;
          end;
        end;
      end else if Sysutils.SameText(TField(grdTransactions.GetActiveField).FieldName , 'ShipContainerETA') then begin
        if TField(grdTransactions.GetActiveField).FieldName = 'ShipContainerETA' then begin
          if grdTransactions.DataSource.DataSet.Fieldbyname('ShipContainerETA').AsDateTime  <> 0  then  ShowShippingContainer;
        end;
      end;
    end;
end;

procedure TBaseTransGUI.DoOnGridDataSelect(Sender: TwwDbGrid);
var
  ShipContainer                 :TShippingContainer;
  sSelectedContainerName        :string;
  sExistingAssignment           :string;
  iAssignedShipContainerID      :integer;
  iPurchaseLineID               :integer;
begin
  iAssignedShipContainerID := 0;
  sExistingAssignment := tblDetails.Fieldbyname('ShipContainerName').AsString;
  sSelectedContainerName := Sender.DataSource.DataSet.Fieldbyname('ContainerName').AsString;

  if sExistingAssignment = sSelectedContainerName then exit;

  ShipContainer:= TShippingContainer.Create(nil);
  ShipContainer.Connection := TMyDacDataConnection.Create(ShipContainer);
  try
    ShipContainer.Connection.MyDacConnection := Self.MyConnection;

    if sExistingAssignment <> '' then begin
      iAssignedShipContainerID := tcDataUtils.getShipContainerID(sExistingAssignment);
      ShipContainer.Load(iAssignedShipContainerID);
      ShipContainer.ContainerDetails;
    end;
    if grdTransactions.DataSource.DataSet.Fieldbyname('SaleLineID').AsInteger > 0 then begin
      iPurchaseLineID := tcDataUtils.GetPurchaseLineIDLinkedToSale(grdTransactions.DataSource.DataSet.Fieldbyname('SaleLineID').AsInteger);
    end else begin
      iPurchaseLineID := grdTransactions.DataSource.DataSet.Fieldbyname('PurchaseLineID').AsInteger
    end;

    {if existing assignment delete }
    if iAssignedShipContainerID <> 0 then begin
      ShipContainer.Load(iAssignedShipContainerID);
      ShipContainer.ContainerDetails;
      ShipContainer.ContainerDetails.Dataset.Locate('PurchaseLineID',iPurchaseLineID,[loCaseInsensitive]);
      ShipContainer.ContainerDetails.Delete;
      ShipContainer.Save;
    end;
    {add new assignment }
    iAssignedShipContainerID := tcDataUtils.getShipContainerID(sSelectedContainerName);
    ShipContainer.Load(iAssignedShipContainerID);
    ShipContainer.ContainerDetails;

    ShipContainer.ContainerDetails.New;
    ShipContainer.ContainerDetails.PurchaseLineID := iPurchaseLineID;
    ShipContainer.Save;
  finally
    FreeAndNil(ShipContainer);
  end;
end;


procedure TBaseTransGUI.DoOnProductchange;
begin
// descendants will override;
end;

procedure TBaseTransGUI.SetForeignFieldDisplayFormat;
var
  CurrencySymbol,fmt,fmt5: string;
  fld: TField;
begin
  CurrencySymbol:= TCurrency.CurrencySymbolForCode(TransBase.ForeignExchangeCode, MyConnection);

  fmt:= CurrencySymbol + '#,##0.00;(' + CurrencySymbol + '#,##0.00)';
  fmt5:= CurrencySymbol + '#,##0.00000;(' + CurrencySymbol + '#,##0.00000)';
  if tblDetails.Active then begin
    fld:= tblDetails.FindField('ForeignCurrencyLineCost');
    if Assigned(fld) then TFloatField(fld).DisplayFormat:= fmt5;
    fld:= tblDetails.FindField('ForeignCurrencyLinePrice');
    if Assigned(fld) then TFloatField(fld).DisplayFormat:= fmt5;
    fld:= tblDetails.FindField('ForeignTotalLineAmount');
    if Assigned(fld) then TFloatField(fld).DisplayFormat:= fmt5;
    fld:= tblDetails.FindField('ForeignUOMLineCost');
    if Assigned(fld) then TFloatField(fld).DisplayFormat:= fmt5;
  end;
  if tblMaster.Active then begin
    fld:= tblMaster.FindField('ForeignTotalAmount');
    if Assigned(fld) then TFloatField(fld).DisplayFormat:= fmt5;
  end;
end;

procedure TBaseTransGUI.tblDetailsAfterOpen(DataSet: TDataSet);
var
  fld: TField;
begin
  inherited;

  SetForeignFieldDisplayFormat;
  fld:= DataSet.FindField('ReceivedDate');
  if Assigned(fld) then
    TDateTimeField(fld).DisplayFormat:= FormatSettings.ShortDateformat;
  fld:= DataSet.FindField('shipDate');
  if Assigned(fld) then
    TDateTimeField(fld).DisplayFormat:= FormatSettings.ShortDateformat;
//  lblDisableCalc.visible := TransBase.Lines.count >appenv.CompanyPrefs.TransLinesToDisableCalcs;
  //checkForDupPQA;
end;

function TBaseTransGUI.ValidData: boolean;
begin
  Transbase.InvalidAllocationLine     := 0;
  TransBase.inCompleteAllocationLine  := 0;

  REsult := TransBase.ValidateData;
  Validdatamsg;
end;

function TBaseTransGUI.Validdatamsg: boolean;
var
  Msg :STring;
  MsgOption :Word;
begin
  Result:= True;
  Msg := Transbase.Resultstatus.GetAllMessages(BOR_ProdQty_BatchBinAllocFailed, Chr(13));
  if Msg <> '' then begin
      CommonLib.MessageDlgXP_Vista('The Allocation has the following Errors.'
                  + Chr(13)+ Chr(13) + Msg + Chr(13) + Chr(13)+'This should be fixed in order to Save the '+ InsertSpaces(Transbase.XMLNodeName)    , mtInformation, [mbok], 0);
      if Transbase.InvalidAllocationLine <> 0 then
        if Transbase.Lines.Dataset.Locate(Transbase.Lines.IDFieldName ,Transbase.InvalidAllocationLine, []) then begin
            Transbase.lines.PostDB;
            TfmAllocation.DoBinBatchform(Transbase.lines.PQA , Self);
        end;
      Result := False;
      Exit;
  end;

  Msg := Transbase.Resultstatus.GetAllMessages(BOR_ProdQty_Warn, Chr(13));
  if Msg <> '' then
    if CommonLib.MessageDlgXP_Vista('The Allocation has the following Errors.'
                  + Chr(13)+ Chr(13) + Msg + Chr(13) + Chr(13)+'Do you wish to fix them now? ', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
        if Transbase.inCompleteAllocationLine <> 0 then begin
          if Transbase.Lines.Dataset.Locate(Transbase.Lines.IDFieldName ,Transbase.inCompleteAllocationLine, []) then begin
            Transbase.lines.Postdb;
            TfmAllocation.DoBinBatchform(Transbase.lines.PQA , Self);
          end;
        end;
        Result := False;
        Exit;
    end;

  {take a confirmation to Save the products in the PO with 0 Qty}
  Msg := Transbase.Resultstatus.GetAllMessages(BOR_ProdQty_Info, Chr(13));
  if Msg <> '' then begin

        MsgOption := CommonLib.MessageDlgXP_Vista('Ordered Quanitity is 0 for the following Product(s).' + chr(13) + Msg ,
                 mtConfirmation, [], 0 , nil , '', '' , False , nil , 'Save As It Is,Delete Where Ordered Qty =0 and Save,Cancel');
        if MsgOption= 100 then begin
          Result := True;
        end else if MsgOption = 101 then begin
          Result := TransBase.DeleteWith0Qty;
        end else begin
            Result := False;
        end;
        if not result then begin
            if grdTransactions.Enabled then
                if    dgEditing in grdTransactions.Options then
                    if (tblDetails.findfield('UnitofMeasureQtySold') <> nil) and
                      (not (tblDetails.findfield('UnitofMeasureQtySold').Readonly)) then begin
                        SetControlFocus(grdTransactions);
                        grdTransactions.setActivefield('UnitofMeasureQtySold');
                    end;
        end;
  end;
  //Result := True;
end;

procedure TBaseTransGUI.WriteExtraGuiPref;
begin
  GuiPrefs.Node['General.ChooseTemplate'].AsString            := BooleanToStr(chkChooseRpt.checked);
  GuiPrefs.Node['General.LockGridSorting'].AsBoolean := (mnuLockSorting.Caption <> LockSortingCaption);
end;

procedure TBaseTransGUI.BeforeAllocationformShow;
begin
  //descendants will override;
end;

procedure TBaseTransGUI.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = vk_insert) and (Screen.activecontrol = grdTransactions) then begin
    transbase.LineInserting := true;
  end;
    if (Key = 119) and ( (ssShift in Shift)) then begin  // f8
      if tblDetails.FindField('PartBarcode') <> nil then begin
        grdTransactions.AddField('PartBarcode');
        tblDetails.FindField('PartBarcode').index := 0;
        grdTransactions.SetActivefield('PartBarcode');
      end;
      Exit;
    end;


  if (Key = VK_DELETE) and
          (self.ActiveControl = grdTransactions) and
          (grdTransactions.GetActiveField.FieldName = 'LineTax') then begin
    if ConfirmZeroTax then begin
      TransBase.Lines.LineTaxRate :=0;
      TransBase.Lines.PostDB;
      TransBase.Lines.CalcLineTotals;
    end;
      key:= 0;
  end;


  //fLastKeyPressed := Key;
  { the following is to prevent field values being set to null }
  if (Key = VK_DELETE) and (self.ActiveControl = grdTransactions) and
     ((grdTransactions.GetActiveField.FieldName = 'UnitofMeasureQtySold') or
      (grdTransactions.GetActiveField.FieldName = 'UnitofMeasureShipped') or
      (grdTransactions.GetActiveField.FieldName = 'DiscountPercent')) then begin
      Key := 0;
  end;

  if Shift = [ssShift,ssCtrl,ssAlt] then begin
    If Key = VK_F7 then begin
      Recalculateall;
    end;
  end;
end;
Procedure TBaseTransGUI.RecalculateAll;
var
  fdTotEx, fdTotInc, fdTax:double;
begin
  if MessageDlgXP_vista('This will save the current changes. Do you wish to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
  if not SaveTrans then exit;
  Self.CommitAndNotify;
  try
    if SameText(CustomInputPassword('Password' , 'RecalcTransTotal' , iif(devmode ,'RecalcTransTotal' , '')), 'RecalcTransTotal') then begin
          fdTotEx:= TransBase.TotalAmount;
          fdTotInc:= TransBase.TotalAmountinc;
          fdTax:= TransBase.TotalTax;
           TransBase.Recalculateall;
          if  not(sameValue(fdTotEx,TransBase.TotalAmount, 0.00001)) or
              not(sameValue(fdTotInc,TransBase.TotalAmountinc, 0.00001)) or
              not(sameValue(fdTax, TransBase.TotalTax, 0.00001)) then
              MessageDlgXP_vista('Totals Recalculated.'+NL+
                                  '         Ex: ' + floattostrF(fdTotEx ,ffCurrency, 15,2) +' - ' + floattostrF(TransBase.TotalAmount   ,ffCurrency, 15,2) +NL+
                                  '        Tax: ' + floattostrF(fdTax   , ffCurrency, 15,2)+' - ' + floattostrF(TransBase.TotalTax      ,ffCurrency, 15,2) +NL+
                                  '        Inc: ' + floattostrF(fdTotInc, ffCurrency, 15,2)+' - ' + floattostrF(TransBase.TotalAmountinc,ffCurrency, 15,2), mtWarning, [mbOK], 0);
    end;
  finally
    self.BeginTransaction;
  end;
end;
procedure TBaseTransGUI.cboClientLookupBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if tblMaster.Active then {shows inActive Customer On Exsiting Sales}
    cboClientLookup.Params.ParamByName('xClientID').asInteger := tblMaster.Fieldbyname('ClientID').asInteger
  else
    cboClientLookup.Params.ParamByName('xClientID').asInteger := 0;
end;

procedure TBaseTransGUI.tblMasterAfterPost(DataSet: TDataSet);
begin
  inherited;
  if cboClientLookup.ParamByName('xClientID').asInteger <> tblMaster.Fieldbyname('ClientID').asInteger then begin
    cboClientLookup.Close;
    cboClientLookup.Open;
  end;
end;

function TBaseTransGUI.InsertSpaces(SourceStr:String):String;
var
  tmpStr,charStr:String;
  iLength,i :integer;
  currentChar:char;
  function isUpper(ch: char): boolean;
  begin
    if CharInSet(ch,['A'..'Z']) then
      isUpper := true
    else
      isUpper := false;
  end;
begin
  Result := '';
  try
    iLength := char_length(SourceStr);
    tmpStr := '';
    for i := 1 to (iLength) do begin
      charStr := Copy(SourceStr,i,1);
      currentChar := charStr[1];
      if isUpper(currentChar) then begin
        tmpStr := tmpStr + ' ' + currentChar;
      end else begin
        tmpStr := tmpStr + currentChar;
      end;
    end;
    Result := tmpStr;
  except
  end;
end;




procedure TBaseTransGUI.tblDetailsBeforeClose(DataSet: TDataSet);
begin
  inherited;
  GridFieldsEditable;
end;

procedure TBaseTransGUI.GridFieldsEditable;
begin
  grdTransactions.ColumnByName('UnitofMeasureShipped').ReadOnly:= false;
  grdTransactions.ColumnByName('UnitofMeasureSaleLines').ReadOnly:= false;
end;

procedure TBaseTransGUI.GridTitleButtonClick(Sender: TObject; AFieldName: String);
begin
  inherited GridTitleButtonClick(Sender, AFieldName);
  showcurrentOrder(nil);
end;

{$IFDEF FORM_BASED_SELECT_SQL}
function TBaseTransGUI.InvoiceGroupSQL: String;
begin
   result :=' AND d3.ProductName <>"Memo Only" ' +
     ' AND d2.SaleId = '+IntToStr(TransBase.ID) +
     ' GROUP By d2.SaleID,ProductID,d3.LinePrice,d3.UnitofMeasureSaleLines'+
     ' Order by d3.Sortid '+
     ' ~|||~' +' and saleId = '+IntToStr(TransBase.ID) ;
end;
{$ENDIF}

function TBaseTransGUI.ReturnType: String;
begin
  Result := '';
end;

function TBaseTransGUI.FieldsToExecludeFromsorting: String;
begin
  result:=
    'grdTransactions:LinePriceInc;'+
    'grdTransactions:LinePrice;' +
    'grdTransactions:LineCostInc;' +
    'grdTransactions:LineCost;' +
    'grdTransactions:CalcProfitEx;' +
    'grdTransactions:CalcProfit;' +
    'grdTransactions:CalcProfitPercentEx;' +
    'grdTransactions:CalcProfitPercent;' +
    'grdTransactions:TotalLineAmount;' +
    'grdTransactions:TotalLineAmountInc;' +
    'grdTransactions:Discounts;' +
    'grdTransactions:Markup;' +
    'grdTransactions:Margin;' +
    'grdTransactions:DiscountPercent;' +
    'grdTransactions:MarkupPercent;' +
    'grdTransactions:MarginPercent;' +
    inherited FieldsToExecludeFromsorting;
end;

procedure TBaseTransGUI.FeldSetTextDontAllowNulls(Sender: TField;
  const Text: String);
begin
  if (Sysutils.SameText(Sender.FieldName , 'ForeignExchangeRate') ) or
     (Sysutils.SameText(Sender.FieldName , 'ForeignExchangeCode' )) then begin
    if text = '' then Sender.Value := Sender.OldValue else Sender.AsString:= text;
  end else
    inherited;
end;

procedure TBaseTransGUI.ApplyPricelock;
var
  PriceLocked:Boolean;
begin
  if tbldetails.findfield('Productname') = nil then exit;

  PriceLocked :=(not(CanEditPrice)) and
                (tbldetails.Fieldbyname('ProductName').asString <>PART_PCENT_SURCH) and
                (tbldetails.Fieldbyname('ProductName').asString <>PART_DOL_SURCH) and
                (tbldetails.Fieldbyname('ProductName').asString <>PART_PCENT_DISC) and
                (tbldetails.Fieldbyname('ProductName').asString <>PART_DOL_DISC);
  if not PriceLocked then
      PriceLocked := not(CanEditTransPricenCost);

  grdTransactions.columnbyname('LinePrice').readonly          := PriceLocked;
  grdTransactions.columnbyname('LinePriceInc').readonly       := PriceLocked;
  grdTransactions.columnbyname('TotalLineAmountInc').readonly := PriceLocked;
  grdTransactions.columnbyname('TotalLineAmount').readonly    := PriceLocked;

end;

procedure TBaseTransGUI.grdTransactionsColEnter(Sender: TObject);
begin
  inherited;
  if SameText(grdTransactions.GetActiveField.fieldname ,'LineTax') then
    //TimerMsg(lblProcessMessage, 'Double Click on ''Tax Value'' to see break up of taxes charged');
    //ShowTimedHint(grdtransactions,  'Double Click on ''Tax Value'' to see break up of taxes charged' , false, 5000 , grdtransactions.Width-4, 0 , Self.color, clred);
    TransTimerMsg('Double Click on ''Tax Value'' to see break up of taxes charged');
  ApplyPricelock;
  SkipReadonlyField;
end;

Procedure TBaseTransGUI.SkipReadonlyfield;
begin
end;

procedure TBaseTransGUI.ReadExtraGuipref;
begin
    if GuiPrefs.Node.Exists('General') then begin
      chkChooseRpt.checked:= StrToBoolean(GuiPrefs.Node['General.ChooseTemplate'].AsString);
      if GuiPrefs.Node['General.LockGridSorting'].AsBoolean then
        mnuLockSorting.Caption := EnableSortingCaption
      else
        mnuLockSorting.Caption := LockSortingCaption;
    end else begin
      chkChooseRpt.checked:= False;
      mnuLockSorting.Caption := LockSortingCaption;
    end;
end;

procedure TBaseTransGUI.Readonlyfield(fieldname: String; REadonly: Boolean);
begin
  if tbldetails.findfield(fieldname) <> nil then begin
    tbldetails.findfield(fieldname).ReadOnly := Readonly;
    grdtransactions.ColumnByName(FieldName).ReadOnly := Readonly;
  end;
end;

procedure TBaseTransGUI.RedeemPoints;
begin
  if not(TransBase is TSalesBase) then exit;
  if TSalesBase(TransBase).CustomerID     =0 then exit;
  if TSalesBase(TransBase).TotalAmountInc =0 then exit;
  TRewardPointsDetailsGUI.GetPoints(TSalesBase(TransBase).CustomerID , OnSelectPoints, TSalesBase(TransBase).Saledate, Self.MyConnection);
end;


procedure TBaseTransGUI.OnSelectPoints(Sender: TObject);
var
  Qrymain:TDataset;
  i:Integer;
  grdmain :TwwDbgrid;
  totalamountinc:Double;
  MaxPointsToRedeem:Double;
  PointsRedeemed:double;
  PointsToredeem:Double;
begin

  if not(Sender is twwDBgrid) then exit;
  grdMain :=TwwDBGrid(Sender);
  Qrymain := grdmain.Datasource.dataset;
  if not assigned(Qrymain) then exit;

  totalamountinc :=TSalesBase(TransBase).TotalAmountInc;

  {calculate multiples of the points can be redeemed}
  MaxPointsToRedeem:= 0;
  for i := 0 to grdMain.SelectedList.Count - 1 do begin
      qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
      MaxPointsToRedeem:= MaxPointsToRedeem + qryMain.Fieldbyname('AvailablePoints').asFloat;
  end;

  if trunc(MaxPointsToRedeem / appenv.CompanyPrefs.MultiplesofPointstoRedeem)  =0 then begin
    CommonLib.MessageDlgXP_Vista('Only multiples of ' + IntToStr(appenv.CompanyPrefs.MultiplesofPointstoRedeem) +'s can be redeemed.  Selected points[' + FloattoStr(MaxPointsToRedeem) + '] is  not enough to redeem.' , mtWarning, [mbok],0  );
    exit;
  end;

  MaxPointsToRedeem := trunc(MaxPointsToRedeem / appenv.CompanyPrefs.MultiplesofPointstoRedeem)*appenv.CompanyPrefs.MultiplesofPointstoRedeem;
  PointsRedeemed:= 0;
  for i := 0 to grdMain.SelectedList.Count - 1 do begin
      qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
      PointsToredeem :=qryMain.Fieldbyname('AvailablePoints').asFloat;
      if PointsToredeem >  MaxPointsToRedeem -PointsRedeemed then PointsToredeem := MaxPointsToRedeem -PointsRedeemed;

      if (PointsToredeem * qryMain.Fieldbyname('ValueforRewardPoint').asFloat <0) or
          (TotalAmountinc>0) then begin
          if not TSalesBase(TransBase).SalesRedeemPoints.Locate('SalesLinesPointsId' , Qrymain.Fieldbyname('SalesLinesPointsId').asInteger , []) then begin
            TSalesBase(TransBase).SalesRedeemPoints.New;
            TSalesBase(TransBase).SalesRedeemPoints.SalesLinesPointsId := Qrymain.Fieldbyname('SalesLinesPointsId').asInteger ;
            TSalesBase(TransBase).SalesRedeemPoints.PointsfromSaleId :=Qrymain.Fieldbyname('SaleID').asInteger;
            TSalesBase(TransBase).SalesRedeemPoints.PointsFromSalelineId:=Qrymain.Fieldbyname('SaleLineID').asInteger;
            TSalesBase(TransBase).SalesRedeemPoints.ProductId:=Qrymain.Fieldbyname('ProductId').asInteger;
            TSalesBase(TransBase).SalesRedeemPoints.ProductName:=Qrymain.Fieldbyname('ProductName').asString;
          end;
          TSalesBase(TransBase).SalesRedeemPoints.SaleID := TSalesBase(TransBase).ID;
          if TotalamountInc >= PointsToredeem * qryMain.Fieldbyname('ValueforRewardPoint').asFloat then begin
            TSalesBase(TransBase).SalesRedeemPoints.ValueforRewardPoints  := qryMain.Fieldbyname('ValueforRewardPoint').asFloat;
            TSalesBase(TransBase).SalesRedeemPoints.Redeemamount := PointsToredeem * qryMain.Fieldbyname('ValueforRewardPoint').asFloat ;
            TSalesBase(TransBase).SalesRedeemPoints.UsedPoints :=PointsToredeem ;
          end else begin
            TSalesBase(TransBase).SalesRedeemPoints.ValueforRewardPoints  := qryMain.Fieldbyname('ValueforRewardPoint').asFloat;
            TSalesBase(TransBase).SalesRedeemPoints.Redeemamount := TotalamountInc;
            TSalesBase(TransBase).SalesRedeemPoints.UsedPoints :=Round(TotalamountInc/TSalesBase(TransBase).SalesRedeemPoints.ValueforRewardPoints ,Appenv.CompanyPrefs.RoundUpPoints) ;
          end;
          PointsRedeemed := PointsRedeemed +TSalesBase(TransBase).SalesRedeemPoints.UsedPoints;
          totalAmountInc := totalAmountInc - TSalesBase(TransBase).SalesRedeemPoints.UsedPoints*TSalesBase(TransBase).SalesRedeemPoints.ValueforRewardPoints;
        end;
      TSalesBase(TransBase).SalesRedeemPoints.PostDB;
  end;
  totalRedeemedPoints :=0;
  totalRedeemedAmount :=0;
  RedeemedPointsDesc := 'Points Details';
  TSalesBase(TransBase).SalesRedeemPoints.Iteraterecords(totalPointsCallback);
  if (totalRedeemedPoints <>0) or (totalRedeemedAmount <>0) then begin
    if not (TSalesBase(TransBase).lines.Locate('ProductName' , REDEEM_POINTS , [])) then begin
      TSalesBase(TransBase).lines.NEw;
      TSalesBase(TransBase).lines.ProductName := REDEEM_POINTS;
      TSalesBase(TransBase).lines.QtySold:=1;
      TSalesBase(TransBase).lines.QtyShipped :=1;
      TSalesBase(TransBase).lines.TotalLineAmountInc :=  0;
      TSalesBase(TransBase).lines.Product_Description_Memo := RedeemedPointsDesc;
    end;
    TSalesBase(TransBase).lines.TotalLineAmountInc :=  0-totalRedeemedAmount;
  end;

end;


procedure TBaseTransGUI.totalPointsCallback(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not (Sender is TSalesRedeemPoints) then exit;

  totalRedeemedPoints := totalRedeemedPoints + TSalesRedeemPoints(Sender).UsedPoints;
  totalRedeemedAmount := totalRedeemedAmount + TSalesRedeemPoints(Sender).RedeemAmount;
  RedeemedPointsDesc := RedeemedPointsDesc+chr(13) +
      '    ' +FloatToStr(TSalesRedeemPoints(Sender).UsedPoints) + ' Points Redeemed From Sale#' +IntToStr(TSalesRedeemPoints(Sender).PointsfromSaleId)+
      '  For Product:' + TSalesRedeemPoints(Sender).ProductName;

end;

function TBaseTransGUI.PointsRedeemd(const saleID: Integer): boolean;
var
  strSQL:string;
begin
  strSQL:= 'Select * from tblsalesredeempoints where PointsfromSaleId = ' + intToStr(saleID) +' and active = "T"' ;
  with TransBase.GetNewDataSet(strSQL) do try
    result := recordcount > 0;
  finally
      if active then close;
      free;
  end;

end;


procedure TBaseTransGUI.PopulateMessageSubstituteList(SL: TStringList);
begin

end;
Procedure TBaseTransGUI.AddCalcMenuForDevMode;
begin
  if devmode then begin
    NewMenuForTransGrid('Recalculate'  , doReCalculate , true);
  end;
end;
procedure TBaseTransGUI.AddCalculatormenuitem;
begin
  NewMenuForTransGrid('Calculator (F9)'  , doCalculate , true);

end;

procedure TBaseTransGUI.AddCommentsMenu;
var
  mnu: TMenuItem;
begin
  if not (Assigned(txtComments.Popupmenu)) then exit;
  mnu := TMenuItem.Create(self);
  mnu.Caption := '-';
  txtComments.Popupmenu.Items.Add(mnu);

  mnu := TMenuItem.Create(self);
  mnu.Caption := 'Choose a Comment from List';
  mnu.OnClick := DoSinglecommnet;
  txtComments.Popupmenu.Items.Add(mnu);

  mnu := TMenuItem.Create(self);
  mnu.Caption := 'Multiple Comments';
  mnu.OnClick := DoMultiplecommnets;
  txtComments.Popupmenu.Items.Add(mnu);
end;

procedure TBaseTransGUI.AddDefaultOrdermenuITems;
begin
  NewMenuForTransGrid('Insert Line'        , Inserline , true);
  NewMenuForTransGrid('Default Order'      , ChangeToDefaultOrder , False);
  NewMenuForTransGrid('Show Current Order' , showcurrentOrder , False);

end;
procedure TBaseTransGUI.AddExtraMenuItems;
begin

end;

procedure TBaseTransGUI.AddRewardPointmenuITems;
begin
  NewMenuForTransGrid('Redeem Points'        , mnuRedeemPointsClick , true);
end;
Procedure TBaseTransGUI.showcurrentOrder(Sender: TObject);
var
  s:String;
begin
  s:= GridsortDescription(grdtransactions);
  if s<> '' then TransTimerMsg(s, 5);
end;
procedure TBaseTransGUI.ChangeToDefaultOrder(Sender: TObject);
begin
  inherited;
  tbldetails.IndexFieldNames:= 'LinesOrder ASC CIS;';
  if guiprefs <> nil then
    if guiprefs.Active then
      if guiprefs.DbGridElement[grdTransactions] <> nil then
        guiprefs.DbGridElement[grdTransactions].Node['IndexFieldNames'].asString := tbldetails.IndexFieldNames;

  showcurrentOrder(nil);
end;
function TBaseTransGUI.CheckForfieldsinGridKeyPress(Sender: TObject;  var Key: Char): boolean;
begin
  Result := False;
end;

procedure TBaseTransGUI.Inserline(Sender: TObject);
begin
  SetFocusedControl(grdTransactions);
  SendKeys('{INS}', true);
end;
procedure TBaseTransGUI.mnuRedeemPointsClick(Sender: TObject);
begin
  RedeemPoints;
end;
procedure TBaseTransGUI.beforeOpenTransReturnDetails(Sender: TObject);
begin
  if not(Sender is TTransReturnListGUI) then exit;
  TTransReturnListGUI(Sender).TransType  := ReturnType;
  TTransReturnListGUI(Sender).transRef   := Transbase.globalref;
  TTransReturnListGUI(Sender).ID         := 0;
  TTransReturnListGUI(Sender).REturnCode := '';
end;
procedure TBaseTransGUI.mnuReturnsClick(Sender: TObject);
begin
  inherited;
  if Appenv.RegionalOptions.Regiontype= rUK then
    OpenErpListform('TVATTransReturnListGUI' , beforeOpenTransReturnDetails)
  else  if Appenv.RegionalOptions.Regiontype=  rNZ then
    OpenErpListform('TNZTransReturnListGUI' , beforeOpenTransReturnDetails)
  else
    OpenErpListform('TBASTransReturnListGUI' , beforeOpenTransReturnDetails);
end;

procedure TBaseTransGUI.showRedeemPoints(const SaleDate:TdateTime);
var
  AvailablePoints :Double;
begin
  AvailablePoints := 0;
  if TransBase.ClientId = 0 then exit;
  {no points for cash cuctomers}
  if Sysutils.SameText(TransBase.ClientName , CLIENT_CASH) then begin
  end else begin
    AvailablePoints := TransBase.AvailableRewardPoints(TransBase.ClientId,SaleDate);
  end;

  lblRedeemPoints.visible     := (AvailablePoints <> 0) ;
  lblRedeemPoints.Caption     := FloattoStr(Round(AvailablePoints, Appenv.CompanyPrefs.RoundUpPoints)) +' Points';
  lblRedeemPoints.Refresh;

  if findComponent('mnuRedeemPoints') <> nil then
    TMenuItem(findComponent('mnuRedeemPoints')).visible     := lblRedeemPoints.visible;
  if findComponent('mnuRedeemPointssep') <> nil then
    TMenuItem(findComponent('mnuRedeemPointssep')).visible     := lblRedeemPoints.visible;

end;

procedure TBaseTransGUI.showProgressbar(Progressbarcaption: String;Progresscount: Integer);
begin
  ProgDialog.Message := Progressbarcaption;
  ProgDialog.MaxValue := Progresscount;
  ProgDialog.minValue:= 0;
  ProgDialog.Execute;
end;

procedure TBaseTransGUI.ShowProgressFunc(ProgressBarCaption: String;
  ProgressCount: Integer);
begin
  self.showProgressbar(ProgressBarCaption, ProgressCount);
end;

procedure TBaseTransGUI.stepProgressbar(ProgressMsg: String='');
begin
  if ProgressMsg <> '' then ProgDialog.Message :=ProgressMsg;
  ProgDialog.StepIt;
end;




procedure TBaseTransGUI.StepProgressFunc;
begin
  self.stepProgressbar();
end;

procedure TBaseTransGUI.StockTransferList(Sender: TObject);
begin
  inherited;
   OpenERPListform('TSalesStockTransferListGUI' , BeforeshowStockTransferList);
end;
procedure TBaseTransGUI.BeforeshowStockTransferList(Sender:TObject);
begin
  if not(Sender is TSalesStockTransferListGUI) then exit;
  TSalesStockTransferListGUI(Sender).SAleID :=Transbase.ID;
end;
procedure TBaseTransGUI.HideProgressbar;
begin
  ProgDialog.CloseDialog;
end;

procedure TBaseTransGUI.HideProgressFunc;
begin
  self.HideProgressbar;
end;

procedure TBaseTransGUI.mnuAuditTrialClick(Sender: TObject);
begin
  inherited;
  if transbase.Id =0 then exit;
  OpenErpListform('TTransAuditTrailGUI' ,TransAuditTrialbeforeShow);
end;
procedure TBaseTransGUI.TransAuditTrialbeforeShow(Sender: TObject);
begin
  if not(Sender is TTransAuditTrailGUI) then exit;
  TTransAuditTrailGUI(Sender).DocName       := Transbase.classname;
  TTransAuditTrailGUI(Sender).DocId         := Transbase.ID;
  TTransAuditTrailGUI(Sender).TransGlobalref:= Transbase.Globalref;
  TTransAuditTrailGUI(Sender).DocDescription:=Transbase.XMLNodename;
  TTransAuditTrailGUI(Sender).Formname      := Self.Classname;
end;

function TBaseTransGUI.TransName: String;
begin
  result :=TransBase.XMLNodeName;
end;

{$IFDEF FORM_BASED_SELECT_SQL}
function TBaseTransGUI.TransSpecificSQL: String;
begin
  REsult := '';
end;
{$ENDIF}

function TBaseTransGUI.TransStatustype: String;
begin
  REsult:= '';
end;


procedure TBaseTransGUI.TransTimerMsg(const Value: String;Secondstoshow: Integer; msgColor: TColor);
begin
//  TimerMsg(lblProcessMessage , Value, Secondstoshow, msgColor);
  if Value = '' then exit;
  TimerMsg(pnlProcessMessage, lblProcessMessage , Value, Secondstoshow, msgColor);
end;

procedure TBaseTransGUI.mnuDeleteemptyLinesClick(Sender: TObject);
begin
  inherited;
  if not(Assigned(TransBase)) then exit;
  if TransBase.count =0 then exit;
  if CommonLib.MessageDlgXP_Vista('Do You Wish To Delete All Lines With 0 Ordered and Shipped Quantity From ' + Transbase.XMLNodename +'#' + IntToStr(transBase.ID) +' ?' , mtconfirmation , [mbyes,mbno],0) = mrNo then exit;
  emptyLinesDeleted := TransBase.DeleteWith0Qty ;
end;

procedure TBaseTransGUI.AfterformShow;
begin
  inherited;
  if fbDeleteEmptyLinesAftershow then begin
    if AccessLevel = 1 then begin
      mnuDeleteemptyLinesClick(mnuDeleteemptyLines);
      if emptyLinesDeleted then
        btnCompleted.click;
    end;
  end;
  emptyLinesDeleted := False;
end;

function TBaseTransGUI.ConfirmZeroTax: boolean;
begin
  result:= CommonLib.MessageDlgXP_Vista('Are you sure you wish to set the tax amount to zero?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes;

end;

procedure TBaseTransGUI.grdTransactionsKeyPress(Sender: TObject;  var Key: Char);
begin
  inherited;
  if Sysutils.SameText(grdTransactions.GetActiveField.FieldName , 'LineTax') then begin
      if (Key = '0') or (Key = '') then begin
        if ConfirmZeroTax then begin
          TransBase.Lines.LineTaxRate :=0;
          TransBase.Lines.PostDB;
          TransBase.Lines.CalcLineTotals;
        end;
        Key := chr(0);
      end
      else if ((Key >= '1') and (Key <= '9')) or (Key = chr(VK_BACK)) then begin
        Key := chr(0);
      end;
      Exit;
  end;
end;
procedure TBaseTransGUI.grdTransactionsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_f9 then
      doCalculate;

end;

function TBaseTransGUI.HasAssociatedrecords:boolean;
begin
  REsult := TRue;
  if (transbase.BackOrderGlobalRef = '') and (transbase.BaseNo = '') then begin
    MessageDlgXP_Vista(TransBase.XMLNodename +' # ' +IntToStr(TransBase.ID) +' Has No BackOrder Associated with it' , mtInformation , [mbok],0);
    REsult := False;
  end;
end;
procedure TBaseTransGUI.OpenTransactionSequence;
begin
  if not Saverecord then exit;
  if not (HasAssociatedrecords) then exit;

  if FormStillOpen('TTransactionSequenceGUI') then begin
    Try
        TransactionSequenceBeforeshow(TTransactionSequenceGUI(GetComponentByClassName('TTransactionSequenceGUI')));
        TTransactionSequenceGUI(GetComponentByClassName('TTransactionSequenceGUI')).BringToFront;
        Exit;
    Except
        // kill exception
    end;
    //MessageDlgXP_Vista('Please Close the Opened Transaction Sequence to Open the Transaction Sequence of ' + Transbase.XMLNodename +'#' + IntToStr(TransBAse.ID) +'.' , mtwarning, [mbok], 0);
    //Exit;
  end;
  CreatenOpenERPListForm('TTransactionSequenceGUI' , TransactionSequenceBeforeshow);
end;

procedure TBaseTransGUI.TransactionSequenceBeforeshow(Sender: TObject);
begin
   if not(Sender is TTransactionSequenceGUI) then exit;
   TTransactionSequenceGUI(Sender).Originalglobalref := Transbase.OriginalDocNumber;
   TTransactionSequenceGUI(Sender).GlobalRef := TransBase.globalref;
   if ClassNameIs('TPurchaseGUI') then    TTransactionSequenceGUI(Sender).Transtype := 'PO'
   else if ClassNameIs('TSalesOrderGUI') then    TTransactionSequenceGUI(Sender).Transtype := 'SO'
   else if ClassNameIs('TInvoiceGUI') then    TTransactionSequenceGUI(Sender).Transtype := 'INV'
   else if ClassNameIs('TQuoteGUI') then    TTransactionSequenceGUI(Sender).Transtype := 'QUOTE'
end;


function TBaseTransGUI.Save4NewTrans: Boolean;
begin
  Result := true;
end;

function TBaseTransGUI.Saverecord: boolean;
begin
  CommitTransaction;
  BeginTransaction;
  Result := true;
end;

function TBaseTransGUI.SaveTransToPDF: boolean;
var
  filename :String;
begin
  inherited;
  Result:= False;
  SaveDialog1.FileName := StrToValidFileName(TransBase.ClientName + ' ' + transbase.xmlnodename,' ') +' #' + inttostr(transbase.ID) +'.PDF';
  if SaveDialog1.Execute then begin
    filename :=  SaveDialog1.FileName;
  end else begin
    Exit;
  end;

  LoadTemplate(false, True, True , filename);
  TransBase.Printdoc.Printdoc(TransBase.ClassName, TransBase.ID, dtmain, Self.Classname ,dotPDF , ReportToPrint);
  TransBase.Dirty:= false;
  Result:= True;
  ReportToPrint := '';
end;

procedure TBaseTransGUI.DefaultValueForAreaFromHint(const PreferenceValue: String);
begin
  if PreferenceValue ='C' then
    cboLinesAreaCode.Hint := 'Bases on Preferences ''Area'' gets it''s default value from the Customer''s Area'
  else if PreferenceValue ='S' then
    cboLinesAreaCode.Hint := 'Bases on Preferences ''Area'' gets it''s default value from the Supplier''s Area'
  else if PreferenceValue ='P' then
    cboLinesAreaCode.Hint := 'Bases on Preferences ''Area'' gets it''s default value from the Product''s Area';
  cboLinesAreaCode.showhint := True;

end;

procedure TBaseTransGUI.DeleteallLines;
var
    isFiltered :Boolean;
begin
  isFiltered :=TransBase.Lines.dataset.filtered;
  try
    TransBase.Lines.Dataset.filtered := False;
    TransBase.Lines.first;
    DoShowProgressbar(TransBase.Lines.count , 'Deleting All Lines');
    try
      While TransBase.Lines.Eof = False do begin
          if TransBase.Lines.deleted then else DeleteLineRecord ;
          TransBase.Lines.next;
          DoStepProgressbar;
      end;
    finally
        DoHideProgressbar;
    end;
  finally
      TransBase.Lines.Dataset.filtered := isFiltered;
  end;
end;

procedure TBaseTransGUI.DeleteSelectedLines;
var
  isFiltered :Boolean;
  x: integer;
begin
  isFiltered :=TransBase.Lines.dataset.filtered;
  try
    TransBase.Lines.Dataset.filtered := False;
//    TransBase.Lines.first;
    DoShowProgressbar(TransBase.Lines.count , 'Deleting Lines');
    try
      for x := 0 to grdTransactions.SelectedList.Count -1 do begin
        grdTransactions.DataSource.DataSet.GotoBookmark(grdTransactions.SelectedList.Items[x]);
        if TransBase.Lines.deleted then else DeleteLineRecord ;
        DoStepProgressbar;
      end;
    finally
      DoHideProgressbar;
    end;
  finally
    TransBase.Lines.Dataset.filtered := isFiltered;
  end;
end;

function TBaseTransGUI.deleteline: boolean;
var
    isFiltered :Boolean;
    fId :Integer;
begin
  isFiltered :=TransBase.Lines.dataset.filtered;
  try
      fId :=TransBase.Lines.ID;
      TransBase.Lines.Dataset.filtered := False;
      TransBase.Lines.Dataset.Locate(TransBase.Lines.IDFieldName , fId , []);
      TransBase.Lines.DoFieldChangewhenDisabled := TRue;
      try
          Result := DeleteLineRecord;
      finally
          TransBase.Lines.DoFieldChangewhenDisabled := False;
      end;
      if TransBase.Lines.Count > 0 then TransBase.Lines.PostDB;
  finally
      TransBase.Lines.Dataset.filtered := isFiltered;
  end;
end;

{$IFDEF FORM_BASED_SELECT_SQL}
function TBaseTransGUI.SalesOrderManufactureReportSQL(Includeallocation:Boolean =False): String;
var
  s:String;
  filename:String;
  st:TStringList;
  i:Integer;
  function SalesfieldList:String;
  begin
      result := 'State,Postcode,PhoneNumber,FaxNumber,ABN,CompanyName,Address,Address2,City,SaleID,SalesGlobalRef,InvoiceDocNumber,'+
                  'OriginalNo,BaseNo,Account,AccountID,BOID,CustomerName,ClientID,InvoiceTo,ShipTo,PickupFrom,SaleDate,TotalTax,'+
                  'TotalWETTax,TotalWEGTax,TotalAmount,TotalAmountInc,TotalMarkup,TotalDiscount,EmployeeName,EmployeeID,ClassID,'+
                  'Class,OrderNumber,PONumber,ChequeNo,SaleShipDate,FutureSO,DueDate,ConNote,Memo,Comments,InvoicePrintDesc,PickMemo,'+
                  'PrintHold,Shipping,Terms,PayMethod,PayDueDate,Paid,Balance,SOBalance,Payment,ApplyFlag,AmountDue,TimeOfSale,IsPOS,'+
                  'POS,IsRefund,IsCashSale,IsInvoice,IsQuote,IsSalesOrder,IsVoucher,IsLayby,IsLaybyTOS,IsLaybyPayment,TotalQuoteAmount,'+
                  'Deposited,TillID,HoldSale,FreezeQuoteAmount,Converted,EnteredBy,EnteredAt,CommissionPaid,IsManifest,'+
                  'UsedOnManifest,AddToManifest,SalesOrderGlobalRef,QuoteGlobalRef,RepairGlobalRef,IsBarcodePicking,BarcodePickingDone,'+
                  'ARNotes,OriginalCreationDate,QuoteStatus,DespatchID,RunID,RunName,Reference,POCreated,ForeignExchangeCode,'+
                  'ForeignExchangeRate,ForeignTotalAmount,ForeignPaidAmount,ForeignBalanceAmount,IsGeneratedFromHire,BlindBalancePeriodID,'+
                  'SaleDateTime,AutoSmartOrderRef,IsInternalOrder,ShippingCost,contactID,ContactName,POSPostCode,RepairID,MedtypeID,'+
                  'Medtype,NoOfBoxes,SaleLineID,ProductID,PARTTYPE,INCOMEACCNT,ASSETACCNT,COGSACCNT,ProductGroup,ProductName,'+
                  'Product_Description,Product_Description_Memo,OrgLinePrice,LinePrice,LinePriceInc,LineWholesalePrice,LineTaxRate,'+
                  'LineCost,LineCostInc,LineTaxCode,LineTax,QtySold,UnitofMeasureQtySold,Shipped,UnitofMeasureShipped,'+
                  'UnitofMeasureLinePrice,UnitofMeasureLinePriceInc,BackOrder,UnitofMeasureBackorder,UnitofMeasure,UnitOfMeasureID,'+
                  'UnitofMeasureMultiplier,Invoiced,Discounts,Markup,Margin,MarkupPercent,MarginPercent,DiscountPercent,Timecostused,TotalLineAmount,'+
                  'TotalLineAmountInc,RefundQty,SoldSerials,Attrib1Sale,Attrib2Sale,Attrib1SaleRate,LastLineID,DescAttrib3,'+
                  'DescAttrib1,DescAttrib2,Supplier,SupplierContact,DescAttrib4,DescAttrib5,ForeignExchangeSellRate,ForeignExchangeSellCode,'+
                  'ForeignCurrencyLinePrice,ForeignTotalLineAmount,Area,SearchFilter,SearchFilterCopy,IsRelatedProduct,RelatedParentProductID,'+
                  'CostCentreId,ClonedFromId,DocketNumber,UseHedging,PartSpecID,SpecDescription,SpecValue,CreationDate,WarrantyPeriod,'+
                  'WarrantyEndsOn,SalesLinesCustField1,SalesLinesCustField2,SalesLinesCustField3,SalesLinesCustField4,SalesLinesCustField5,'+
                  'SalesLinesCustField6,SalesLinesCustField7,SalesLinesCustField8,SalesLinesCustField9,SalesLinesCustField10,LineNotes,'+
                  'CustomData,INCOMEACCNTID,ASSETACCNTID,COGSACCNTID,SortId,MemoLine,SeqNo,RelatedParentLineRef,RelatedProductQty,'+
                  'IsFormulaRElatedProduct,FormulaID,AutoSmartOrder,SmartOrderCreated,LineShipDate,BaseLineno,PartBarcode,'+
                  'TotalOrglinePrice , TotalOrglinePriceInc, TotalOrgEstlinePrice,TotalOrgEstlinePriceInc,  CompanyContact,'+
                  'TotalForeignCurrencyLinePrice,CustJobName,CustABN,CustTitle,CustFirstName,CustMiddleName,CustLastName,CustStreet,'+
                  'CustStreet2,CustSuburb,CustState,CustCountry,CustPostcode,CustBillStreet,CustBillStreet2,CustBillSuburb,CustBillState,'+
                  'CustBillCountry,CustBillPostcode,CustPOBox,CustPOSuburb,CustPOState,CustPOCountry,CustPOPostcode,CustPhone,CustFaxNumber,'+
                  'CustMobile,CustEmail,CustAltContact,CustAltPhone,ClientNo,DeliveryNotes,SuppProdCode,ProductHideOnPrint,Prepayments,Totalpayment,SalesOrderBalance,'+
                  'Manufacture,JobRegistration,Colour,BodyType,SerialNumber,InsuranceCompanyName,JobNumber,ExcessAmount,CustomerJobNumber ';
  end;
  function SalesSQL:String;
  begin
        REsult := '  SELECT'+
                ' d1.State, d1.Postcode, d1.PhoneNumber AS PhoneNumber, '+
                ' d1.FaxNumber AS FaxNumber, d1.ABN,   CompanyName, Address, '+
                ' Address2, City,'+
                'S.SaleID	as 	SaleID	,'+
                'S.GlobalRef	as 	SalesGlobalRef	,'+
                'S.InvoiceDocNumber	as 	InvoiceDocNumber	,'+
                'S.OriginalNo	as 	OriginalNo	,'+
                'S.BaseNo	as 	BaseNo	,'+
                'S.Account	as 	Account	,'+
                'S.AccountID	as 	AccountID	,'+
                'S.BOID	as 	BOID	,'+
                'S.CustomerName	as 	CustomerName	,'+
                'S.ClientID	as 	ClientID	,'+
                'S.InvoiceTo	as 	InvoiceTo	,'+
                'S.ShipTo	as 	ShipTo	,'+
                'S.PickupFrom	as 	PickupFrom	,'+
                'S.SaleDate	as 	SaleDate	,'+
                'S.TotalTax	as 	TotalTax	,'+
                'S.TotalWETTax	as 	TotalWETTax	,'+
                'S.TotalWEGTax	as 	TotalWEGTax	,'+
                'S.TotalAmount	as 	TotalAmount	,'+
                'S.TotalAmountInc	as 	TotalAmountInc	,'+
                'S.TotalMarkup	as 	TotalMarkup	,'+
                'S.TotalDiscount	as 	TotalDiscount	,'+
                'S.EmployeeName	as 	EmployeeName	,'+
                'S.EmployeeID	as 	EmployeeID	,'+
                'S.ClassID	as 	ClassID	,'+
                'S.Class	as 	Class	,'+
                'S.OrderNumber	as 	OrderNumber	,'+
                'S.PONumber	as 	PONumber	,'+
                'S.ChequeNo	as 	ChequeNo	,'+
                'S.ShipDate	as 	SaleShipDate	,'+
                'S.FutureSO	as 	FutureSO	,'+
                'S.DueDate	as 	DueDate	,'+
                'S.ConNote	as 	ConNote	,     '+
                'S.Memo	as 	Memo	,'+
                'S.Comments	as 	Comments	,'+
                'S.InvoicePrintDesc	as 	InvoicePrintDesc	,'+
                'S.PickMemo	as 	PickMemo	,'+
                'S.PrintHold	as 	PrintHold	,'+
                'S.Shipping	as 	Shipping	,'+
                'S.Terms	as 	Terms	,'+
                'S.PayMethod	as 	PayMethod	,'+
                'S.PayDueDate	as 	PayDueDate	,'+
                'S.Paid	as 	Paid	,'+
                'S.Balance	as 	Balance	,'+
                'S.SOBalance	as 	SOBalance	,'+
                'S.Payment	as 	Payment	,'+
                'S.ApplyFlag	as 	ApplyFlag	,'+
                'S.AmountDue	as 	AmountDue	,'+
                'S.TimeOfSale	as 	TimeOfSale	,'+
                'S.IsPOS	as 	IsPOS	,'+
                'S.POS	as 	POS	,'+
                'S.IsRefund	as 	IsRefund	,'+
                'S.IsCashSale	as 	IsCashSale	,'+
                'S.IsInvoice	as 	IsInvoice	,'+
                'S.IsQuote	as 	IsQuote	,'+
                'S.IsSalesOrder	as 	IsSalesOrder	,'+
                'S.IsVoucher	as 	IsVoucher	,'+
                'S.IsLayby	as 	IsLayby	,'+
                'S.IsLaybyTOS	as 	IsLaybyTOS	,'+
                'S.IsLaybyPayment	as 	IsLaybyPayment	,'+
                'S.TotalQuoteAmount	as 	TotalQuoteAmount	,'+
                'S.Deposited	as 	Deposited	,'+
                'S.TillID	as 	TillID	,'+
                'S.HoldSale	as 	HoldSale	,'+
                'S.FreezeQuoteAmount	as 	FreezeQuoteAmount	,'+
                'S.Converted	as 	Converted	,'+
                'S.EnteredBy	as 	EnteredBy	,'+
                'S.EnteredAt	as 	EnteredAt	,'+
                'S.CommissionPaid	as 	CommissionPaid	,'+
                'S.IsManifest	as 	IsManifest	,'+
                'S.UsedOnManifest	as 	UsedOnManifest	,'+
                'S.AddToManifest	as 	AddToManifest	,'+
                'S.SalesOrderGlobalRef	as 	SalesOrderGlobalRef	,'+
                'S.QuoteGlobalRef	as 	QuoteGlobalRef	,'+
                'S.RepairGlobalRef	as 	RepairGlobalRef	,'+
                'S.IsBarcodePicking	as 	IsBarcodePicking	,'+
                'S.BarcodePickingDone	as 	BarcodePickingDone	,'+
                'S.ARNotes	as 	ARNotes	,'+
                'S.OriginalCreationDate	as 	OriginalCreationDate	,'+
                'S.QuoteStatus	as 	QuoteStatus	,'+
                'S.DespatchID	as 	DespatchID	,'+
                'S.RunID	as 	RunID	,'+
                'S.RunName	as 	RunName	,'+
                'S.Reference	as 	Reference	,'+
                'S.POCreated	as 	POCreated	,'+
                'S.ForeignExchangeCode	as 	ForeignExchangeCode	,'+
                'S.ForeignExchangeRate	as 	ForeignExchangeRate	,'+
                'S.ForeignTotalAmount	as 	ForeignTotalAmount	,'+
                'S.ForeignPaidAmount	as 	ForeignPaidAmount	,'+
                'S.ForeignBalanceAmount	as 	ForeignBalanceAmount	,'+
                'S.IsGeneratedFromHire	as 	IsGeneratedFromHire	,'+
                'S.BlindBalancePeriodID	as 	BlindBalancePeriodID	,'+
                'S.SaleDateTime	as 	SaleDateTime	,'+
                'S.AutoSmartOrderRef	as 	AutoSmartOrderRef	,'+
                'S.IsInternalOrder	as 	IsInternalOrder	,'+
                'S.ShippingCost	as 	ShippingCost	,'+
                'S.contactID	as 	contactID	,'+
                'S.ContactName	as 	ContactName	,'+
                'S.POSPostCode	as 	POSPostCode	,'+
                'S.RepairID	as 	RepairID	,'+
                'S.MedtypeID	as 	MedtypeID	,'+
                'S.Medtype	as 	Medtype	,'+
                'S.NoOfBoxes	as 	NoOfBoxes	,'+
                'SL.SaleLineID	as	SaleLineID	,'+
                'SL.ProductID	as	ProductID	,'+
                'SL.PARTTYPE	as	PARTTYPE	,'+
                'SL.INCOMEACCNT	as	INCOMEACCNT	,'+
                'SL.ASSETACCNT	as	ASSETACCNT	,'+
                'SL.COGSACCNT	as	COGSACCNT	,'+
                'SL.ProductGroup	as	ProductGroup	,'+
                'SL.ProductName	as	ProductName	,'+
                'SL.Product_Description	as	Product_Description	,'+
                'SL.Product_Description_Memo	as	Product_Description_Memo	,'+
                'SL.OrgLinePrice	as	OrgLinePrice	,'+
                'SL.LinePrice	as	LinePrice	,'+
                'SL.LinePriceInc	as	LinePriceInc	,'+
                'SL.LineWholesalePrice	as	LineWholesalePrice	,'+
                'SL.LineTaxRate	as	LineTaxRate	,'+
                'SL.LineCost	as	LineCost	,'+
                'SL.LineCostInc	as	LineCostInc	,'+
                'SL.LineTaxCode	as	LineTaxCode	,'+
                'SL.LineTax	as	LineTax	,'+
                'SL.QtySold	as	QtySold	,'+
                'SL.UnitofMeasureQtySold	as	UnitofMeasureQtySold	,'+
                'SL.Shipped	as	Shipped	,'+
                'SL.UnitofMeasureShipped	as	UnitofMeasureShipped	,'+
                'SL.TotalLineAmount/SL.UnitofMeasureShipped as UnitofMeasureLinePrice,'+
                'SL.TotalLineAmountInc/SL.UnitofMeasureShipped as UnitofMeasureLinePriceInc,'+
                'SL.BackOrder	as	BackOrder	,'+
                'SL.UnitofMeasureBackorder	as	UnitofMeasureBackorder,'+
                'SL.UnitofMeasureSaleLines	as	UnitofMeasure	,'+
                'SL.UnitOfMeasureID	as	UnitOfMeasureID	,'+
                'SL.UnitofMeasureMultiplier	as	UnitofMeasureMultiplier	,'+
                'SL.Invoiced	as	Invoiced	,'+
                'SL.Discounts	as	Discounts	,'+
                'SL.Markup	as	Markup	,'+
                'SL.MarkupPercent	as	MarkupPercent	,'+
                'SL.Margin	as	Margin	,'+
                'SL.MarginPercent	as	MarginPercent	,'+
                'SL.DiscountPercent	as	DiscountPercent	,'+
                'SL.Timecostused	as	Timecostused	,'+
                'SL.TotalLineAmount	as	TotalLineAmount	,'+
                'SL.TotalLineAmountInc	as	TotalLineAmountInc	,'+
                'SL.RefundQty	as	RefundQty	,'+
                'SL.SoldSerials	as	SoldSerials	,'+
                'SL.Attrib1Sale	as	Attrib1Sale	,'+
                'SL.Attrib2Sale	as	Attrib2Sale	,'+
                'SL.Attrib1SaleRate	as	Attrib1SaleRate	,'+
                'SL.LastLineID	as	LastLineID	,'+
                'SL.DescAttrib3	as	DescAttrib3	,'+
                'SL.DescAttrib1	as	DescAttrib1	,'+
                'SL.DescAttrib2	as	DescAttrib2	,'+
                'SL.Supplier	as	Supplier	,'+
                'SL.SupplierContact	as	SupplierContact	,'+
                'SL.DescAttrib4	as	DescAttrib4	,'+
                'SL.DescAttrib5	as	DescAttrib5	,'+
                'SL.ForeignExchangeSellRate	as	ForeignExchangeSellRate	,'+
                'SL.ForeignExchangeSellCode	as	ForeignExchangeSellCode	,'+
                'SL.ForeignCurrencyLinePrice	as	ForeignCurrencyLinePrice	,'+
                'SL.ForeignTotalLineAmount	as	ForeignTotalLineAmount	,'+
                'SL.Area	as	Area	,'+
                'SL.SearchFilter	as	SearchFilter	,'+
                'SL.SearchFilterCopy	as	SearchFilterCopy	,'+
                'SL.IsRelatedProduct	as	IsRelatedProduct	,'+
                'SL.RelatedParentProductID	as	RelatedParentProductID	,'+
                'SL.CostCentreId	as	CostCentreId	,'+
                'SL.ClonedFromId	as	ClonedFromId	,'+
                'SL.DocketNumber	as	DocketNumber	,'+
                'SL.UseHedging	as	UseHedging	,'+
                'SL.PartSpecID	as	PartSpecID	,'+
                'SL.SpecDescription	as	SpecDescription	,'+
                'SL.SpecValue	as	SpecValue	,'+
                'SL.CreationDate	as	CreationDate	,'+
                'SL.WarrantyPeriod	as	WarrantyPeriod	,'+
                'SL.WarrantyEndsOn	as	WarrantyEndsOn	,'+
                'SL.SalesLinesCustField1	as	SalesLinesCustField1	,'+
                'SL.SalesLinesCustField2	as	SalesLinesCustField2	,'+
                'SL.SalesLinesCustField3	as	SalesLinesCustField3	,'+
                'SL.SalesLinesCustField4	as	SalesLinesCustField4	,'+
                'SL.SalesLinesCustField5	as	SalesLinesCustField5	,'+
                'SL.SalesLinesCustField6	as	SalesLinesCustField6	,'+
                'SL.SalesLinesCustField7	as	SalesLinesCustField7	,'+
                'SL.SalesLinesCustField8	as	SalesLinesCustField8	,'+
                'SL.SalesLinesCustField9	as	SalesLinesCustField9	,'+
                'SL.SalesLinesCustField10	as	SalesLinesCustField10	,'+
                'SL.LineNotes	as	LineNotes	,'+
                'SL.CustomData	as	CustomData	,'+
                'SL.INCOMEACCNTID	as	INCOMEACCNTID	,'+
                'SL.ASSETACCNTID	as	ASSETACCNTID	,'+
                'SL.COGSACCNTID	as	COGSACCNTID	,'+
                'SL.SortId	as	SortId	,'+
                'SL.MemoLine	as	MemoLine	,'+
                'SL.SeqNo	as	SeqNo	,'+
                'SL.RelatedParentLineRef	as	RelatedParentLineRef	,'+
                'SL.RelatedProductQty	as	RelatedProductQty	,'+
                'SL.IsFormulaRElatedProduct	as	IsFormulaRElatedProduct	,'+
                'SL.FormulaID	as	FormulaID	,'+
                'SL.AutoSmartOrder	as	AutoSmartOrder	,'+
                'SL.SmartOrderCreated	as	SmartOrderCreated	,'+
                'SL.ShipDate	as	LineShipDate	,'+
                'SL.BaseLineno	as	BaseLineno	,'+
                'SL.PartBarcode	as	PartBarcode	,'+
                'SL.OrgLinePrice * SL.Shipped TotalOrglinePrice,'+
                'SL.OrgLinePrice * SL.Shipped+ SL.OrgLinePrice * SL.Shipped * SL.LineTaxRate TotalOrglinePriceInc,'+
                'SL.OrgLinePrice * SL.QtySold TotalOrgEstlinePrice,'+
                'SL.OrgLinePrice * SL.QtySold+ SL.OrgLinePrice * SL.QtySold * SL.LineTaxRate TotalOrgEstlinePriceInc,'+
                '  CONCAT_WS(" ", C.Title, C.FirstName, C.LastName) as CompanyContact,'+
                '  (SL.shipped*SL.ForeignCurrencyLinePrice) as TotalForeignCurrencyLinePrice,'+
                '  C.JobName as CustJobName,    C.ABN as CustABN,  C.Title as CustTitle,'+
                      'C.FirstName as CustFirstName,    C.MiddleName as CustMiddleName, '+
                      'C.LastName as CustLastName,      C.Street as CustStreet, C.Street2 as CustStreet2, '+
                      'C.Suburb as CustSuburb, C.State as CustState, C.Country as CustCountry,   '+
                      'C.Postcode as CustPostcode,  C.BillStreet as CustBillStreet, '+
                      'C.BillStreet2 as CustBillStreet2,  C.BillSuburb as CustBillSuburb,      '+
                      'C.BillState as CustBillState,    C.BillCountry as CustBillCountry,  '+
                      'C.BillPostcode as CustBillPostcode,        C.POBox as CustPOBox,    '+
                      'C.POSuburb as CustPOSuburb,  C.POState as CustPOState,    '+
                      'C.POCountry as CustPOCountry,      C.POPostcode as CustPOPostcode,  '+
                      'C.Phone as CustPhone,      C.FaxNumber as CustFaxNumber,      '+
                      'C.Mobile as CustMobile,  C.Email as CustEmail,    C.AltContact as CustAltContact,    '+
                      'C.AltPhone as CustAltPhone,   C.ClientNo,      C.DeliveryNotes,'+
                '  P.supplierproductcode as SuppProdCode ,'+
                '  P.HideOnPrint ProductHideOnPrint,'+
                ' (Select Sum(PP.Balance) TotalBalance '+
                '     from tblSalesPrepayments  SP '+
                '     inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef  '+
                '     Where PP.Deleted = "F" and SP.SalesRef = S.Globalref ) as Prepayments,  '+
                '  (Select Sum(PP.Balance) TotalBalance '+
                '     from tblSalesPrepayments  SP inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef  '+
                '     Where PP.Deleted = "F" and SP.SalesRef = S.Globalref ) +S.payment as Totalpayment,'+
                ' S.totalamountinc - (Select Sum(PP.Balance) TotalBalance  '+
                  ' from tblSalesPrepayments  SP  '+
                  ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef   '+
                  ' Where PP.Deleted = "F" and SP.SalesRef = S.Globalref ) -payment as SalesOrderbalance , '+
                  'C.Manufacture , C.JobRegistration , C.Colour , C.BodyType , C.SerialNumber , C.InsuranceCompanyName , C.JobNumber , C.ExcessAmount, C.CustomerJobNumber ' +
                '  FROM tblCompanyInformation d1,'+
                '  tblSales S'+
                '  INNER JOIN tblSalesLines SL on S.SaleId = Sl.saleID and ifnull(SL.BOMProductionLine, "F") ="F" '+
                '  INNER JOIN tblparts P on SL.ProductID=PartsID'+
                '  INNER JOIN tblClients C ON S.ClientID = C.ClientID'+
                '  WHERE IsSalesOrder = "T"  and S.SaleId = ' +  IntToStr(TRansbase.Id);
          end;
begin
st:=TStringList.create;
try
  Tablename1 := '';
  Tablename2 := '';
  With CommonDbLib.TempMyScript do try
    BeforeExecute := MyScriptBeforeExecute;
    try
      SQL.add(CreateTemporaryTableusingfile('tmp_salesordermanufacturereport1' , SalesSQL , Salesfieldlist , Tablename1 , filename , '' , 'MyISAM'));
        st.add(fileName);
        s:= Tablename1 +'_1';
        SQL.add('DROP TABLE IF EXISTS ' + s +' ;');
        SQL.add('CREATE TABLE  ' + s +' (' +
                        'AutoId int(11) NOT NULL auto_increment,' +
                        'HideRelated enum("T","F") NOT NULL default "F",' +
                        'ProductID int(11) default 0,' +
                        'ParentID int(11) default 0,' +
                        'PRIMARY KEY  (AutoId)' +
                      ') ENGINE=myIsam;' );


      SQL.add(CreateTemporaryTableusingfile(s , 'Select RP.HideRelated , RP.ProductID , RP.ParentID ' +
                        ' from ' +Tablename1 +' T  ' +
                        ' inner join tblrelatedparts AS RP on ' +
                        ' (T.ProductID=RP.ProductID AND T.RelatedParentProductID=RP.ParentID)' ,'HideRelated , ProductID, ParentID' ,
                        s, filename));
        st.add(fileName);

        SQL.add('  update '+Tablename1+' T inner join '+
                    s+ ' AS RP on (T.ProductID=RP.ProductID AND T.RelatedParentProductID=RP.ParentID)'+
                    '  Set UnitofMeasure        ="" ,'+
                    '  UnitofMeasureShipped     =NULL,'+
                    '  UnitofMeasureBackorder   =NULL,'+
                    '  UnitofMeasureLinePrice   =NULL,'+
                    '  UnitofMeasureLinePriceInc=NULL,'+
                    '  ProductName              ="*",'+
                    '  Shipped                  =null,'+
                    '  BackOrder                =null,'+
                    '  Product_Description      =NULL,'+
                    '  LinePrice                =null,'+
                    '  LineTax                  =null,'+
                    '  ProductHideOnPrint       ="T",'+
                    '  TotalLineAmountInc       =null'+
                    '  Where (T.IsRelatedProduct ="T" and RP.HideRelated ="T") ;');
        SQL.add('  update '+Tablename1+' T'+
                    '  Set UnitofMeasure        = "" ,'+
                    '  UnitofMeasureShipped     = NULL,'+
                    '  UnitofMeasureBackorder   = NULL,'+
                    '  UnitofMeasureLinePrice   = NULL,'+
                    '  UnitofMeasureLinePriceInc= NULL,'+
                    '  ProductName              ="*",'+
                    '  Shipped                  = null,'+
                    '  BackOrder                =null,'+
                    '  Product_Description      =NULL,'+
                    '  LinePrice                =null,'+
                    '  LineTax                  =null,'+
                    '  TotalLineAmountInc       = null'+
                    '  Where  (T.ProductHideOnPrint ="T");');

        {remioving the product picture for the time being }
        //St.Add('  update '+Tablename1+'  T inner join tblpartspics pp on pp.partID = T.ProductID   Set T.PartPic  = pp.PartPic;');
        s:=  Tablename1 + '_2';
        SQL.add('DROP TABLE IF EXISTS ' + s +' ;');
        SQL.add('CREATE TABLE ' + s+ ' ('+
                  ' autoID int(11) NOT NULL auto_increment,'+
                  ' ContactID int(11) NOT NULL default "0",'+
                  ' contactemail varchar(255) default NULL,'+
                  ' contacttitle varchar(32) default NULL,'+
                  ' contactfirstname varchar(30) default NULL,'+
                  ' contactsurname varchar(30) default NULL,'+
                  ' contactaddress varchar(255) default NULL,'+
                  ' contactaddress2 varchar(255) default NULL,'+
                  ' contactaddress3 varchar(255) default NULL,'+
                  ' contactcity varchar(255) default NULL,'+
                  ' contactstate varchar(255) default NULL,'+
                  ' contactpcode varchar(255) default NULL,'+
                  ' contactcountry varchar(255) default NULL,'+
                  ' contactph varchar(255) default NULL,'+
                  ' contactaltph varchar(255) default NULL,'+
                  ' contactmob varchar(255) default NULL,'+
                  ' contactfax varchar(255) default NULL,'+
                  ' PRIMARY KEY  (autoID),'+
                  ' KEY ContactId (ContactID)'+
                  ' ) ENGINE=myisam;');

      SQL.add(CreateTemporaryTableusingfile(s ,'Select ct.ContactID,ct.contactemail,ct.contacttitle ,ct.contactfirstname ,'+
                ' ct.contactsurname ,ct.contactaddress ,ct.contactaddress2 ,ct.contactaddress3 ,'+
                ' ct.contactcity ,ct.contactstate ,ct.contactpcode ,ct.contactcountry ,'+
                ' ct.contactph ,ct.contactaltph ,ct.contactmob ,ct.contactfax'+
                ' from '+Tablename1+' T'+
                ' inner JOIN tblcontacts AS ct on ifnull(T.ContactID,0)=ct.ContactID'+
                ' where ifnull(T.ContactID,0)<> 0' ,
                'ContactID,contactemail,contacttitle,contactfirstname,contactsurname, '+
                  ' contactaddress,contactaddress2,contactaddress3,contactcity,contactstate, '+
                  ' contactpcode,contactcountry,contactph,contactaltph,contactmob,contactfax' ,
                s,filename));
        st.add(fileName);

        SQL.add('  update '+Tablename1+' T'+
        '  inner JOIN  ' + s +'  AS ct on ifnull(T.ContactID,0)=ct.ContactID'+
        '  Set T.ContEmail=ct.contactemail,'+
        '  T.ContTitle = ct.contacttitle ,'+
        '  T.ContFirstName = ct.contactfirstname ,'+
        '  T.ContSurname = ct.contactsurname ,'+
        '  T.ContAddress = ct.contactaddress ,'+
        '  T.ContAddress2 = ct.contactaddress2 ,'+
        '  T.ContAddress3 = ct.contactaddress3 ,'+
        '  T.ContCity = ct.contactcity ,'+
        '  T.ContState = ct.contactstate ,'+
        '  T.ContPostcode = ct.contactpcode ,'+
        '  T.ContCountry = ct.contactcountry ,'+
        '  T.ContPh = ct.contactph ,'+
        '  T.ContAltPh = ct.contactaltph ,'+
        '  T.ContMob = ct.contactmob ,'+
        '  T.ContactFax    = ct.contactfax'+
        '  where ifnull(T.ContactID,0)<> 0;');


      SQL.add(CreateTemporaryTableusingfile('tmp_salesordermanufacturereport2' ,
            ' Select  T.SaleLineId , pt.ProcTreeId , Caption as "OptionName",'+
            ' PT.Description, Convert(TreeNodeCaption(PT.Level, PT.caption ), char(255)) treeItem ,'+
            ' Quantity as OptionQty, TotalQty as OptionTotalQty , pt.info, PT.parentID ,'+
            ' Pt.Selected, PT.inputtype, PT.info, tblPartsPics.PartPic as OptionProductPicture, tblprocessstep.ExtraInfo as OptionProcessDetail'+
            ' from tblProcTree pt'+
            ' inner join '+Tablename1+' T on  pt.MasterId = T.SaleLineId and pt.MasterType <> "mtProduct" ' +
            ' left join tblPartsPics on tblPartsPics.PartId = pt.PartsID' +
            ' left join tblprocesspart on tblprocesspart.ProcTreeID = pt.ProcTreeId '+
            ' left join tblprocessstep on tblprocessstep.Id = tblprocesspart.ProcessStepID ',  // /* and pt.parentId <> 0 and pt.InputType = "itOption"  */

            ' SaleLineId , ProcTreeId , OptionName ,' +
            ' Description , TreeItem ,' +
            ' OptionQty , OptionTotalQty, OptionInfo,parentID,' +
            ' selected, inputtype ,info, OptionProductPicture, OptionProcessDetail' ,
            tablename2 ,filename,'' , 'MYISAM'));
        st.add(fileName);
        SQL.add('alter Table ' + tablename2 +' Add column nodeselected Enum ("T","F") default "F";');

        s:=  Tablename1 + '_3';
        SQL.add('DROP TABLE IF EXISTS ' + s+' ;');
        SQL.add('CREATE TABLE  ' + s+' ('+
                  ' AutoID int(11) NOT NULL auto_increment,'+
                  '  ParentId int(11) default NULL,'+
                  '  Selected enum("T","F") NOT NULL default "F",'+
                  ' Caption varchar(255) default NULL,'+
                  '  PRIMARY KEY  (AutoID)'+
                  ') ENGINE=myisam ;');


      SQL.add(CreateTemporaryTableusingfile(s ,
            'Select pt.ParentId , pt.Selected , pt.Caption'+
            ' from '+tablename2+' T inner join  tblProcTree pt on pt.ParentId = T.ProcTreeId and pt.Selected = "T"' ,
            ' ParentId ,Selected , Caption' , s , filename));


        SQL.Add('  update '+Tablename2+' T '+
                ' inner join '+s + ' pt on pt.ParentId = T.ProcTreeId and pt.Selected = "T"     '+
                ' Set T.OptionItem = pt.Caption;');

        showProgressbar('Please Wait' , 30);
        try
          execute;
        finally
            HideProgressbar;
        end;
      finally
          Free;
      end;
      DestroyUserTemporaryTable(Tablename1+'_1');
      DestroyUserTemporaryTable(Tablename1+'_2');
      DestroyUserTemporaryTable(Tablename1+'_3');
    finally
    end;
  finally
    for i := 0 to st.count-1 do AppEnv.UtilsClient.DeleteServerFiles(replaceStr(st[i], '.tmp' , '*.tmp'));
    Freeandnil(st);
  end;

  ChecknUpdateInTreeNodesSelected(tablename2  , 'nodeselected');

  if appenv.CompanyPrefs.HideSelectedSubnodesinReport then begin
    ExecuteSQL('delete from ' + Tablename2 +' where Selected ="T" and NodeSelected ="T";');
    With TERPQuery(TempMyquery) do try
      SQL.Add('Select Distinct ProctreeId from ' + Tablename2 + ' where ifnull(ParentID,0) <> 0 and ifnull(ParentID,0) not in (Select ProctreeId from ' + Tablename2  +')');
      open;
      s:= GroupConcat('ProctreeId');
      while s<> '' do begin
        ExecuteSQL('delete from ' + Tablename2 +' where proctreeId in (' + s +');');
        close;
        open;
        s:= GroupConcat('ProctreeId');
      end;
    finally
      ClosenFree;
    end;
  end;
  if Includeallocation then
    result := 'Select T1.* , T2.* , PBin.Binlocation,  PBin.binnumber,PQABatch.Value as batchno, PQABatch.TruckLoadNo , PQABatch.ExpiryDate, PQASN.Value as SoldSerials,  '+
              ' C.Manufacture , C.JobRegistration , C.Colour , C.BodyType , C.SerialNumber , C.InsuranceCompanyName , C.JobNumber , C.ExcessAmount, C.CustomerJobNumber , C.Jobname , C.ModelNumber  , '+
              ' salesProduct.ProductionNotes as ProductionNotes,' +
              '  Left(SUBSTRING_INDEX(salesProduct.Productgroup,"^",1),255) as firstcolumn,'+
              '  Left(substring(substring_index(salesProduct.Productgroup,"^",2),char_length(substring_index(salesProduct.Productgroup,"^",1))+1),255) as SecondColumn,'+
              '  Left(substring(substring_index(salesProduct.Productgroup,"^",2),char_length(substring_index(salesProduct.Productgroup,"^",1))+2),255) as thirdcolumn '+
              ' from  '+Tablename1+' T1 '+
              ' inner join tblparts salesProduct on salesProduct.PARTSID = T1.productID '+
              ' Left join '+Tablename2+' T2 on T1.saleLineID = T2.saleLineID  and T2.NodeSelected ="T"  and T2.parentId <> 0 '+
              ' left join tblClients C on C.clientId = T1.ClientId '+
              ' left join (tblproctreePart PTP inner join tblparts P on P.partsId = PTP.productID '+
              ' inner join tblpqa pqa on pqa.translineId = ptp.proctreepartId and pqa.transtype in ("TProctreePart")   and ((P.multiplebins = "F" and P.Batch="F" and P.SNTracking = "F")   OR (PQA.PQAID in (Select PQAID from `tblPQADetails`))) '+
              ' left join `tblPqaDetails` PQABatch  on PQABatch.PQAId  = PQA.PQAID and PQABatch.PQAType = "Batch"  and PQABatch.Active= "T" '+
              ' left join `tblPqaDetails` PQABins   on PQABins.PQAId  = PQA.PQAID   and PQABins.PQAType = "Bin" and PQABins.Active = "T"  '+
              ' and    ( (PQABatch.globalref = IFNULL(PQABins.ParentRef,"") and P.Batch="T"   and P.multiplebins = "T") or (ifnull(PQABins.Parentref ,"") = "" AND P.Batch="F" and P.multiplebins = "T")) '+
              ' Left join `tblProductBin` PBin      on PBin.binId  = PQABins.BinID '+
              ' left join `tblPqaDetails` PQASN     on (PQASN.PQAId  = PQA.PQAID and PQASN.PQAType = "SN"    '+
              ' and PQASN.Active = "T"  and ((PQABatch.globalref = IFNULL(PQASN.ParentRef,"") and P.Batch="T" and P.multiplebins = "F" and P.SNTracking = "T")   '+
              ' or (PQAbins.Globalref = IFNULL(PQASn.ParentRef,"") and P.Multiplebins = "T" and P.SNTracking = "T") or  (ifnull(PQASN.Parentref ,"") = "") and P.Batch="F" and P.Multiplebins = "F" and P.SNTracking = "T" ))        ) on PTP.proctreeId = T2.proctreeId '
  else
    result := 'Select T1.* , T2.*   , '+
              ' C.Manufacture , C.JobRegistration , C.Colour , C.BodyType , C.SerialNumber , C.InsuranceCompanyName , C.JobNumber , C.ExcessAmount, C.CustomerJobNumber , C.Jobname , C.ModelNumber  , '+
              ' salesProduct.ProductionNotes as ProductionNotes,' +
              '  Left(SUBSTRING_INDEX(salesProduct.Productgroup,"^",1),255) as firstcolumn,'+
              '  Left(substring(substring_index(salesProduct.Productgroup,"^",2),char_length(substring_index(salesProduct.Productgroup,"^",1))+1),255) as SecondColumn,'+
              '  Left(substring(substring_index(salesProduct.Productgroup,"^",2),char_length(substring_index(salesProduct.Productgroup,"^",1))+2),255) as thirdcolumn '+
              ' from  '+Tablename1+' T1 '+
              ' inner join tblparts salesProduct on salesProduct.PARTSID = T1.productID '+
              ' Left join '+Tablename2+' T2 on T1.saleLineID = T2.saleLineID  and T2.NodeSelected ="T"  and T2.parentId <> 0 '+
              ' left join tblClients C on C.clientId = T1.ClientId ';

  if appenv.CompanyPrefs.RemoveHideOnPrintProductFromReports then result := result + ' where T1.ProductHideOnPrint <>"T"';


  if ( Appenv.companyprefs.SalesPrintOrderBy <> '' ) then
    result := result + ' order by ' + trim(Appenv.companyprefs.SalesPrintOrderBy )+',sortID'
  else  result := result + ' Order by SortID';

  result:= result+'~|||~{TaxDetails}Select TTCL.`SubTaxCode`, TTCL.Percentage,  '+
              ' Sum(TTCL.`TaxAmount`) TaxAmount from tblsalestaxcodelines TTCL  '+
              ' inner join tblsalestaxcodes TTC on TTCL.SalesTaxCodeID = TTC.ID  '+
              ' Where TTC.SaleId = ' + inttostr(Transbase.ID) +' group by TTCL.`SubTaxCode` '+
              '~|||~{ClientCustomFields}Select  CFL.Description , CCV.Value  '+
                  ' from  tblsales Trans   '+
                  ' inner join tblcustomfieldvaluesClients CCV on Trans.ClientID = CCV.MasterID  '+
                  ' inner join tblcustomfieldlist CFL on CFL.CFID = CCV.CustomFieldlistId  '+
                  ' where ifnull(CCV.Value,"")<>"" and CFL.ListType = "ltCustomer" And Trans.SaleId = ' + inttostr(Transbase.ID);
end;
{$ENDIF}

{$IFDEF FORM_BASED_SELECT_SQL}
procedure TBaseTransGUI.MyScriptBeforeExecute(Sender: TObject;
  var SQL: String; var Omit: Boolean);
begin
  stepProgressbar();
end;
{$ENDIF}

procedure TBaseTransGUI.SetKeyId(const Value: integer);
begin
  inherited;
  showProgressbar('Opening ' +TransBase.XMLNodeName, 22);
end;

procedure TBaseTransGUI.FormDestroy(Sender: TObject);
begin
  showProgressbar('Closing '+xTransname ,xLinecount);
  try
    FreeandNil(transBase);
  finally
      HideProgressbar;
  end;
  DestroyUserTemporaryTable(tablename);
  inherited;
end;

procedure TBaseTransGUI.lblCommentsDblClick(Sender: TObject);
begin
  inherited;
  DoDBMemoDialog('','Comments',txtComments.DataSource.DataSet.FieldByName(txtComments.DataField));
end;

procedure TBaseTransGUI.lblDisableCalcClick(Sender: TObject);
var
  bm:  Tbookmark;
begin
  inherited;
  if TransBase is TSalesbase then begin
    TSalesbase(TransBase).Lines.PostDB;

    if TSalesbase(TransBase).CalcAvaTax then exit;

    if Appenv.companyPrefs.EnableAvaTax then begin
        TransTimerMsg('Avalara Tax not Calculated', 10);
        exit;
    end;


    if TSalesbase(TransBase).Lines.Count = 0 then exit;

    bm := tblDetails.GetBookmark;
    try
      //ShowProgressBar('Calculating Totals',TSalesbase(TransBase).Lines.Count);
      try
        TSalesbase(TransBase).CalcAllLineTotals;
        TSalesbase(TransBase).CalcOrderTotals;
      finally
//        HideProgressBar;
        tblDetails.GotoBookmark(bm);
        tblDetails.FreeBookmark(bm);
      end;
    Except
        tblDetails.FreeBookmark(bm);
    end;
  end
  else if TransBase is TOrderBase then begin
    TOrderBase(TransBase).Lines.PostDB;
    if TOrderBase(TransBase).Lines.Count = 0 then exit;

    bm := tblDetails.GetBookmark;
    try
      try
        TOrderBase(TransBase).CalcAllLineTotals;
        TOrderBase(TransBase).CalcOrderTotals;
      finally
        tblDetails.GotoBookmark(bm);
        tblDetails.FreeBookmark(bm);
      end;
    Except
        tblDetails.FreeBookmark(bm);
    end;
  end
end;

procedure TBaseTransGUI.lblProcessMessageDblClick(Sender: TObject);
begin
  inherited;
  pnlProcessMessage.Visible := not(pnlProcessMessage.Visible);
end;

procedure TBaseTransGUI.CreateBarCodeForProduct(Sender: TObject);
begin
  with TwwDBGrid(Sender).Datasource.dataset do begin
    if active      = False then exit;
    if RecordCount = 0 then exit;
    if findfield('PartsId') = nil then exit;
    if Fieldbyname('PartsID').asInteger = 0 then exit;
    TProduct.AssignBarCode(Fieldbyname('PartsID').asInteger, transbase.Lines.partbarcode);
  end;
end;

procedure TBaseTransGUI.CustomiseUOMField;
begin
  if tbldetails.findfield('UOM_Width')  <> nil then tbldetails.findfield('UOM_Width').displayLabel := 'Width';
  if tbldetails.findfield('UOM_Length') <> nil then tbldetails.findfield('UOM_Length').displayLabel := 'Length';
  if tbldetails.findfield('UOM_Weight') <> nil then tbldetails.findfield('UOM_Weight').displayLabel := 'Weight';
  if tbldetails.findfield('UOM_Volume') <> nil then tbldetails.findfield('UOM_Volume').displayLabel := 'Volume';
  if tbldetails.findfield('UOM_Height') <> nil then tbldetails.findfield('UOM_Height').displayLabel := 'Height';
  if tbldetails.findfield('TotalUOM_WeightSold')    <> nil then tbldetails.findfield('TotalUOM_WeightSold').displayLabel    := 'Total Ordered Weight';
  if tbldetails.findfield('TotalUOM_WeightShipped') <> nil then tbldetails.findfield('TotalUOM_WeightShipped').displayLabel := 'Total Shipped Weight';
  if tbldetails.findfield('TotalUOM_WeightBO')      <> nil then tbldetails.findfield('TotalUOM_WeightBO').displayLabel      := 'Total BO Weight';
  if tbldetails.findfield('TotalUOM_LengthSold')    <> nil then tbldetails.findfield('TotalUOM_LengthSold').displayLabel    := 'Total Sold Width';
  if tbldetails.findfield('TotalUOM_LengthShipped') <> nil then tbldetails.findfield('TotalUOM_LengthShipped').displayLabel := 'Total Shipped Width';
  if tbldetails.findfield('TotalUOM_LengthBO')      <> nil then tbldetails.findfield('TotalUOM_LengthBO').displayLabel      := 'Total BO Width';
end;

constructor TBaseTransGUI.Create(AOwner: TComponent);
begin
  inherited;
end;

Procedure TBaseTransGUI.CreateBarcode(NewValue: String);
var
  frm  :TfrmParts;
  ans :word;
begin
  inherited;
  ans:= CommonLib.MessageDlgXP_Vista('This Barcode not found. Would you like to create?',
      mtConfirmation, [], 0  , nil , '' , '' , False, nil , 'Create New Product,Add Barcode to a Product,Cancel');
      try
  if ans = 102 then begin
  end else if ans = 101 then begin
    with TProductListExpressGUI(GetComponentByClassName('TProductListExpressGUI', true)) do begin
          ExpresslistPopup('Choose Product' , CreateBarCodeForProduct, False);
          Showmodal;
    end;
  end else begin
        if TfrmParts.FormActive then begin
          TfrmParts.CloseMe;
        end;

        frm := TfrmParts(GetComponentByClassName('TfrmParts'));
        if assigned(frm) then begin
            TfrmParts(frm).fsBarcode := transbase.lines.Partbarcode;
            frm.Position := poScreenCenter;
            if not frm.Visible then
              frm.ShowModal;
        end;
    end
  finally
    transbase.Lines.productname := tcdatautils.GetProductForbarCode(transbase.lines.Partbarcode);
    if transbase.Lines.productname = '' then transbase.lines.Partbarcode:= '';
  end;
end;

function TBaseTransGUI.DeleteLinerecord: Boolean;
begin
  REsult:= False;
  if  not IsOktodeleteLine then Exit;
  TransBase.Lines.Deleted:= true;
  TransBase.Lines.PostDB;
  Result := True;
end;

procedure TBaseTransGUI.Setcolumn(columnVisible: Boolean; columnName: string;  displaylabel:String = '');
begin
  if columnVisible then begin
    if displaylabel <> '' then begin
      if grdTransactions.ColumnByName(columnName) = nil then begin
        if tbldetails.findfield(columnName) <> nil then
          tbldetails.fieldbyname(columnName).DisplayLabel :=DisplayLabel;
      end else begin
        grdTransactions.ColumnByName(columnName).DisplayLabel := DisplayLabel;
      end;
    end;
  end else begin
    guiprefs.DbGridElement[grdTransactions].RemoveField(columnName);
  end;
end;
Function TBaseTransGUI.ProductHasCalcformula:Boolean;
begin
  Result := False;
  if (Transbase.lines.count =0) then exit;
  REsult := Transbase.lines.Hasformula;
end;
procedure TBaseTransGUI.QryTransStatusBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  QryTransStatus.parambyname('TransStatustype').AsString := TransStatustype;
  QryTransStatus.parambyname('SelectedStatus').AsString  := transbase.TransStatus;
end;

function TBaseTransGUI.showformuladetails: Boolean;
begin
  Result := False;
    if  (grdTransactions.GetActiveField = tbldetails.findfield('UnitOfMeasureShipped'))  or
        (grdTransactions.GetActiveField = tbldetails.findfield('FormulaQtyShippedValue'))  or
        (grdTransactions.GetActiveField = tbldetails.findfield('FormulaQtyShippedValue1'))  or
        (grdTransactions.GetActiveField = tbldetails.findfield('FormulaQtyShippedValue2'))  or
        (grdTransactions.GetActiveField = tbldetails.findfield('FormulaQtyShippedValue3'))  or
        (grdTransactions.GetActiveField = tbldetails.findfield('FormulaQtyShippedValue4'))  or
        (grdTransactions.GetActiveField = tbldetails.findfield('FormulaQtyShippedValue5'))  then begin
        if ProductHasCalcFormula = False then exit;
        Result := true;
        With TPartCalcFormula.Create(Self) do try          FormulaDetails(Transbase.Lines , Transbase.Lines.Product , False);          Exit;        finally          Free;        end;
    end;
    if  (grdTransactions.GetActiveField = tbldetails.findfield('UnitOfMeasureQtySold'))  or
        (grdTransactions.GetActiveField = tbldetails.findfield('FormulaQtySoldValue'))  or
        (grdTransactions.GetActiveField = tbldetails.findfield('FormulaQtySoldValue1'))  or
        (grdTransactions.GetActiveField = tbldetails.findfield('FormulaQtySoldValue2'))  or
        (grdTransactions.GetActiveField = tbldetails.findfield('FormulaQtySoldValue3'))  or
        (grdTransactions.GetActiveField = tbldetails.findfield('FormulaQtySoldValue4'))  or
        (grdTransactions.GetActiveField = tbldetails.findfield('FormulaQtySoldValue5'))  then begin
        if ProductHasCalcFormula = False then exit;
        Result := true;
        With TPartCalcFormula.Create(Self) do try          FormulaDetails(Transbase.Lines , Transbase.Lines.Product , True);        finally          Free;        end;
    end;
end;

function TBaseTransGUI.Iscolvisible(const fieldname: String): Boolean;
begin
  result := grdtransactions.columnbyname(fieldname).visible;
end;

procedure TBaseTransGUI.cboCurrentStatusDblClick(Sender: TObject);
begin
  inherited;
  LastComboAccessed := cboCurrentTransStatus;
  TfmSimpleTypes.DoSimpleTypesEdit(TransStatustype, TransBase.TransStatus,self);
end;

procedure TBaseTransGUI.cboCurrentStatusNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
    LastComboAccessed := cboCurrentTransStatus;
    NewTransStatus     := cboCurrentTransStatus.Text;
    If CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtconfirmation, [mbyes, mbno], 0) = mrYes Then Begin
      TfmSimpleTypes.DoSimpleTypesEdit(TransStatustype, NewValue, Self);
    End;
    Accept := False;
end;

procedure TBaseTransGUI.cbTaxCodeQryBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  cbTaxCodeQry.ParamByName('xRegionID').asInteger              := AppEnv.RegionalOptions.ID;
  cbTaxCodeQry.ParamByName('Clientcountry').asString          := Clientcountry;
  cbTaxCodeQry.ParamByName('ClientState').asString            := ClientState;
  cbTaxCodeQry.ParamByName('clientLocation').asString         := clientLocation;
  cbTaxCodeQry.ParamByName('ClientPostcode').asString         := ClientPostcode;
  cbTaxCodeQry.ParamByName('filterTaxcodeforClient').asString := BooleanToStr(AppEnv.companyprefs.filterTaxcodeforClient);
  TaxCodecomboHint(cboTaxCode);
end;

procedure TBaseTransGUI.cbTaxCodeQryCalcFields(DataSet: TDataSet);
begin
  inherited;
  cbTaxCodeQrycRate.AsFloat := cbTaxCodeQryRate.AsFloat * 100;
end;

procedure TBaseTransGUI.InitERPLookupCombonFields;
begin
  try
    inherited;
      InitClientLookupCombonFields
  Except

  end;
end;
procedure TBaseTransGUI.InitClientLookupCombonFields;
begin
try
    if tblmaster.active then
      NamenPrintNameGridObj.ClientLookupQueryWithSearchengine(transbase.ClientId,  cboClientR,
                                            (Self is TBaseExpenseGUI) or (self is TBaseOrderGUI),
                                            (self is TBaseSaleGUI) or (self is TBaseCashGUI),
                                            False ,
                                            (self is TBaseSaleGUI) or (self is TBaseCashGUI) , True , 'ClientPrintName' , nil , False);
  Except

  end;
end;
procedure TBaseTransGUI.OnPasteSelection(var Key: word);
begin
  if (Screen.activecontrol = grdTransactions) or (Screen.activecontrol.Parent =grdTransactions.Parent ) then begin
    ClipBoardtoQry(self);
  end;
end;
procedure TBaseTransGUI.OnCopySelection(var Key: word);
begin
  if (Screen.activecontrol = grdTransactions) or (Screen.activecontrol.Parent =grdTransactions.Parent ) then begin
       QryToClipBoard(self);
  end;
end;
Procedure TBaseTransGUI.ClipBoardtoQry(Sender:TObject);
begin
   clipboardLib.ClipBoardtoQry(tbldetails);
end;
Procedure TBaseTransGUI.QryToClipBoard(Sender:TObject);
begin
   clipboardLib.QryToClipBoard(tbldetails);
end;
Procedure TBaseTransGUI.AddCopyPasteMenu;
begin
  NewMenuForTransGrid('Copy All Lines to Clipboard', QryToClipBoard , true);
  NewMenuForTransGrid('Paste Lines From ClipBoard' , ClipBoardtoQry , False);

end;
end.




