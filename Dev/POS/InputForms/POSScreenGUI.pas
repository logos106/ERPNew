unit POSScreenGUI;
{Discount Calculation

The largest Discount wins.
Following are the discounts
1. :Extra Sell discount   :Product.Extra Sell Price
2. Permanent discount     :client.Permanent Discount(In Discount Tab)
3. special Discount       :If Product.SpecialDistount -> client.special Discount(In Discount tab)
4. Special Price discount :Client.Special Price(In Discount Tab
5. group discount         :Client.Group discount (In Discoun tab)}
{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 02/06/05  1.00.01 IJB  Fixed floating point error, LineItem DiscRatio was not
                        being initialised.
 07/06/05  1.00.02 IJB  Added logic to prevent the selection of Vouchers that
                        have already been installed.
 15/07/05  1.00.03 DSP  Corrected the values of 'Count' (NumOfTrans) and
                        'Quantity' (Qty) on the EOP balance report.
 19/07/05  1.00.04 IJB  Added calls to SalesLib to calc points/commission
                        on products sold, moved CLIENT_CASH const to tcConst.
 21/07/05  1.00.05 DSP  The new property for the component TAdvStringGrid
                        called 'ControlLook.NoDisabledButtonLook' needed
                        to be set to 'True' to allow the delete row button
                        to work.
 28/07/05  1.00.06 DSP  Code changed to use PickingSlipOrder in place of
                        PickingSlipOrderByBins.
 12/08/05  1.00.07 BJ   Serialno object inroduced. Serialno fieldtype is changed to mediumtext
 29/08/05  1.00.08 BJ   Note : There is no validation to stop the Refund of an
                        already refunded item. Same in invoice too.
 08/09/05  1.00.09 ISB  bLoadedRefund to track type of refund.
 08/09/05  1.00.10 ISB  Stop Interrupt on Bar Tab.
 09/09/05  1.00.11 DSP  Added setting of 'Paid' field on tblsales.
 19/09/05  1.00.12 ISB  Try fix lstPayments list out Of Bounds Error
 19/09/05  1.00.13 IJB  Added function IsAnyAccoutPayments and modified Layby
                        to stop processing is user has selected account payment.
                        Replaced use of GlobalRefToIDToggleObj with new funtions
                        in tcDataUtils (GlobalRefToIDToggleObj.GetSaleID was
                        used to find sales for refund but failed because it was
                        only looking for unpaid sales).
                        Removed AuditObj, fixed exception handling.
 05/01/06  1.00.14 BJ   Records writen into tblproductqtyallocation table for the picking
                        slip report to work. this is a temporary solution, should be removed
                        When implement the bin-Batch functionality
 09/01/06  1.00.15 IJB  Cheque number was not showing up in To Be Deposited list,
                        sRef was being cleared in PostPayment so removed this
                        and now clear it in CleanUp procedure.
 10/01/06  1.00.16 IJB  Modified Split Bar Tab to allow part of the split to go
                        back to a Bar Tab for same customer (previously it
                        would delete all customer Bar Tab records on completion
                        of Split)
 25/01/06  1.00.17 IJB  Modified CreateInvoice so that it does not do
                        cboClient.OnCloseUp (this was changing the rep on the invoice).
 26/04/06  1.00.18 BJ   Refund was not accepting the serial number because the flag which stores the
                        Refund status was getting intialised when the product is selected.
 27/04/06  1.00.18 BJ   (1) In order to have a  serialised product in the POS transaction,
                        a non-cash customer should be selected. Selection of a serialised product is
                        discarded where there is no access to the customer list.
                        (2) Discout/surcharge can be only given if at least a product is selected.
 15/05/06  1.00.08  AL  moved pLineItemRec to tcTypes
 29/05/06  1.00.09  AL  UnitID in LoadProdRec was always 0 and PriceMatrix did not work, fixed!

 }

interface
{$I ERP.inc}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  POSBtnMatrixObj, ExtCtrls, StdCtrls, FnBtnMatrixObj, Grids, DBGrids,
  BaseGrid, AdvGrid, DB, ReceiptPrinterObj, ComCtrls,AdvOfficeStatusBar, BaseInputForm,
  DateUtils, ppCtrls, Menus, AdvMenus,  ClientDiscountObj,
  ProductPriceObj, ComCounterRecorderXControl_TLB, {ComObj,} ActiveX, Buttons, DNMSpeedButton,
  ToolWin, rwButtonArray, OleCtrls, CSDEFTLib_TLB, MyAccess,ERPdbComponents, MemDS, DBAccess,
  BusObjBase,SelectionDialog, AppEvnts, POSCustomerDisplay, DataState, WwDbGrid,
  AdvMenuStylers, DNMPanel, ExtActns, tcTypes, busobjPOS,
  BusObjStock, busobjClient, BusObjTrans, AdvPanel, Shader, XMLDoc,
  OposScale_CCO_TLB, frmPOSExtraDetails,ImgList, AdvObj, ProgressDialog, customInputBox,
  AdvUtil, frmSmartOrderFrm, BusObjSmartOrder, frmCalculator, MPlayer, tcVideoUtils,
  BaseListingForm;

type
  pProcessedBarTabs = ^TProcessedBarTabs; // used in POS Screen and POS Customer Display
  TProcessedBarTabs = record
    BarTabId: integer;
    BartabLineID :Integer;
    ProductID :Integer;
  end;

  pLaybyItemRec = ^TLaybyItemRec;
  TLaybyItemRec = record
    LaybyID: integer;
    Amount: currency;
  end;

  pRedeemPoints = ^TRedeemPoints;
  TRedeemPoints= record
    ValueforRewardPoints  :double;
    SalesLinesPointsId    :Integer;
    PointsfromSaleId      :Integer;
    PointsFromSalelineId  :Integer;
    ProductId             :Integer;
    ProductName           :String;
    UsedPoints            :double ;
    RedeemAmount          :double;
    ValueforRewardPoint   :double;
  end;

  pPaymentRec = ^TPaymentRec;
  TPaymentRec = record
    PaymentType: string;
    Amount: currency;
    Tendered: currency;
    Ref: string;
    Id: integer;
    LaybyID: integer;           // used if creating a total payment for an ORIGIAL layby
    VoucherID: integer;         // ID of the voucher to redeem in the voucher table
    IssuedBy: string;           // store the voucher was issued by
    SplitTabID: integer;        // Split tab ID group - used to group all the payments made for a paricular split
    IsBarTab: boolean;
    // At this stage this only used for Split tab payments.  We do not normally bother with associating a payment with a Bar Tab
    ClientID: integer;          // ditto
  end;

  pRcptPayRec = ^TRcptPayRec;
  TRcptPayRec = record
    PaymentType: string;
    Amount: currency;
    Tendered: currency;
    Ref: string;
  end;

  TSavedContext = record
    flstLineItems: TList;
    fbChqNoEntered: boolean;
    fbPrevTransWasLayby: boolean;
    fiRepairID: integer;
    fiQuoteID: integer;
    fiHireID: integer;
    fiAppointID: integer;
    fedtPOSMemoText: string;
    frQuantOfProd: double;
    flblMemoTextCaption: string;
    fsRef: string;
    fiClientID: integer;  // will need to LoadCustInfo
    fbMustEnterIdNow: boolean;
    flblSalesPersonCaption: string;
    fiEmployeeID: integer;
  end;

type
  TPOSScreenForm = class(TBaseInputGUI)
    Panel1: TDNMPanel;
    lblRunTot: TLabel;
    lblSubLabel: TLabel;
    lblDefaultFont: TLabel;
    edtPOSMemo: TMemo;
    Bevel6: TBevel;
    lblMemoText: TLabel;
    edtClientID: TEdit;
    edtPartID: TEdit;
    edtLaybyID: TEdit;
    POSMenu: TAdvMainMenu;
    File1: TMenuItem;
    mnuExitPOS: TMenuItem;
    mnuCustomPOS: TMenuItem;
    N2: TMenuItem;
    Repair: TMenuItem;
    RepairList: TMenuItem;
    Appointment: TMenuItem;
    lblOnHold: TLabel;
    dlgPassword: TCustomInputBox;
    edtReceipt: TMemo;
    lblSplit: TLabel;
    lblSplitLabel: TLabel;
    pnlImage1: TDNMPanel;
    Image1: TImage;
    pnlVC: TDNMPanel;
    qryProduct: TERPQuery;
    pnlPOSBtns: TDNMPanel;
    pnlFnKeyBtns: TDNMPanel;
    pnlNumericKeyPad: TDNMPanel;
    btnKeyPad: TDNMSpeedButton;
    btnNum2: TDNMSpeedButton;
    btnNum3: TDNMSpeedButton;
    btnNum4: TDNMSpeedButton;
    btnNum5: TDNMSpeedButton;
    btnNumDot: TDNMSpeedButton;
    btnNum6: TDNMSpeedButton;
    btnNum7: TDNMSpeedButton;
    btnNum8: TDNMSpeedButton;
    btnNum9: TDNMSpeedButton;
    btnNum0: TDNMSpeedButton;
    btnNumBS: TDNMSpeedButton;
    Bevel5: TShader;
    pnlCustomer: TShader;
    Label6: TLabel;
    lblCustomer: TLabel;
    Label3: TLabel;
    lblCustDisc: TLabel;
    Label4: TLabel;
    lblSpecDisc: TLabel;
    lblTotCustDisc: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    lblStore: TLabel;
    lblSalesPerson: TLabel;
    lblSaleNo: TLabel;
    lblDate: TLabel;
    lblTime: TLabel;
    lblTillHead: TLabel;
    Bevel7: TBevel;
    lblTillName: TLabel;
    Label5: TLabel;
    Bevel8: TBevel;
    lblPrn: TLabel;
    MainMenuStyler: TAdvMenuFantasyStyler;
    DrillDownLists1: TMenuItem;
    ProductList1: TMenuItem;
    CustomerList1: TMenuItem;
    lblLineDetails: TLabel;
    FontDialog: TFontDialog;
    eft: TCsdEft;
    lblTotalQuantity: TLabel;
    grdTrans: TAdvStringGrid;
    imgDelete: TImage;
    CompletedSmallPic: TImage;
    Completedpic: TImage;
    edtVoucherID: TEdit;
    edtUnitID: TEdit;
    btnNum1: TDNMSpeedButton;
    mnuCustomiseList: TMenuItem;
    Label1: TLabel;
    pnlMediaHost: TPanel;
    pnlDisplay: TPanel;
    Player: TMediaPlayer;
    tmrMedia: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure pnlPOSBtnsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure pnlFnKeyBtnsClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure edtMemoEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtClientIDChange(Sender: TObject);
    procedure edtLaybyIDChange(Sender: TObject);
    procedure edtPartIDChange(Sender: TObject);
    Procedure edtUnitIDChange(Sender: TObject);
    procedure mnuExitPOSClick(Sender: TObject);
    procedure mnuCustomPOSClick(Sender: TObject);
    procedure ProductListClick(Sender: TObject);
//    procedure RepairClick(Sender: TObject);
//    procedure RepairListClick(Sender: TObject);
    procedure AppointmentClick(Sender: TObject);
//    procedure Repairs1Click(Sender: TObject);
    procedure edtVoucherIDChange(Sender: TObject);
    procedure lblTillHeadMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure pnlNumericKeyPadClick(Sender: TObject);
    procedure btnNumPadClick(Sender: TObject);
    procedure btnKeyPadClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure eftGetLastTransactionEvent(Sender: TObject);
    procedure eftTransactionEvent(Sender: TObject);
    procedure eftPrintReceiptEvent(Sender: TObject; const ReceiptType: WideString);
    procedure eftReprintReceiptEvent(Sender: TObject);
    procedure eftGetLastReceiptEvent(Sender: TObject);
    procedure grdTransDblClickCell(Sender: TObject; ARow, ACol: integer);
    procedure btnNumDblClick(Sender: TObject);
    procedure grdTransClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure ProductList1Click(Sender: TObject);
    procedure CustomerList1Click(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure mnuCustomiseListClick(Sender: TObject);
    procedure pnlDisplayMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PlayerNotify(Sender: TObject);
    procedure tmrMediaTimer(Sender: TObject);
    procedure grdTransMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure grdTransDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private

    Product :TProduct;
    fExtraDetailItem: TExtraDetailItem;
    { Private declarations }
    //Stop 2 Payment Methods Pressed At Once
    PaymethodPressedInProgress: boolean;

    // these variables are accessed via a property
    iEmployeeID: integer;
//    iRepairID: integer;
    iAppointID: integer;
    iQuoteID: integer;
    iHireID: integer;
    iDummySaleID: integer;
    iFuncBookingID: integer;

    xiTillID: integer;               // The ID of the POS Till
    iPrimaryPad: integer;           // The Primary keypad for this Till

    dAppointmentTotalHours: double; // Total Hours for Appointment.  Used when converting.
    dAppointmentFreeHours : double; // Free Hours for Appointment.  Used when converting.
    dAppointmentRate: double;       // Charge Rate in Appointment.  Used when Converting.

    rQuantOfProd: double;           // Quantity of product
    rRunTot: currency;              // Running total so far
    rRunTotNoTax: currency;         // Running total so far
    rCash: currency;                // cash tendered
    rChangeGiven: currency;         // amount of change given to customer
    rPriceChange: currency;         // Overrides the actual price
    rLaybyPayment: currency;        // Layby deposit
    sBarcode: string;               // barcode last entered
    sRef: string;                   // eg cheque no.
    sPayType: string;               // Payment type (eg Credit card)
    sClient: string;                // Client Name
    bOnhold:Boolean;
    iClientID: integer;             // Client ID
    iCashCustID: integer;           // Client ID of cash customer
    iTabsClientID: integer;         // Client ID Of The Bar Tab
    sClientPHAddress: string;         // Client Physical Address
    sClientBTAddress: string;         // Client Bill To Address
    rCustDisc: double;              // Customer Discount percentage
    rTotCustDisc: currency;         // Dollar discount as a result of rCustDisc
    rSpecDisc: double;              // Customer Special product Discount percentage
    iCustOriginator: integer;       // ID of fn that indirectly originated event
    iProdOriginator: integer;       // ID of fn that indirectly originated event
    iLaybyOriginator: integer;      // ID of fn that indirectly originated event
    iSaleID: integer;               // id of last sale
    PickingSlipOnComplete: boolean;
    iOrderNo: integer;              // id of last sale
    iLaybyID: integer;              // sale id just created layby sale
    //sGlobalRef: string;
    sLaybyCustomer: string;         // store layby customer after layby
    //iRoundUp: integer;              // Round up rules
    sPrnDev: string;                // printer device/port
    sPrnType: string;               // printer type
    sPrnname :String;
    sVoucherNo: string;
    lstLaybyTerms: TStringList;
    lstFooter: TStringList;
    lstRewardPoints: TStringList;
    sDiscTooBig: string;            //  "Discount too big" message
    currentItem: pLineItemRec;      // used for SerialNum processing - points line item
    iPayID: integer;                // Payment ID reference - if required
    sCardNumber: string;            // swipe card number
    iRemoteTillID: integer;         // the ID of the till that will print my spooled receipts
    bIsSpooler: boolean;            // tru if this till is a print spooler
    bUseSpooler: boolean;           // true if want to use remote print spooler
    sAccountNo: string;             // customer Account No
    bRefundMode: boolean;           // True if refund is required
    bLoadedRefund: boolean;
    fbEnteringNum: boolean;
    bPriceChange: boolean;             // True if price is to be overridden
    bApplyDiscToPriceChange: boolean;
    // Normally, no discount is applied to parts that have had a price change applied - us this to override
    bUpdateDate: boolean;              // UPdate the date on next sale item
    bIsLocked: boolean;                // True if terminal locked
    bMultiSalesMan: boolean;           // True if salesman per transaction
    bMultiTills: boolean;              // True if supports more than one POS till
    bMustEnterIdNow: boolean;          // forces ID entry prior to transaction
    bChqNoEntered: boolean;            // Cheque number has been entered
    bIsLayby: boolean;                 // True if creating a Layby transaction
    bIsVoucher: boolean;               // True if creating a voucher sale
    bIsLaybyReversal: boolean;         // True if creating a Layby reversal transaction
    bPrevTransWasLayby: boolean;       // True is the previous transaction was a layby
    bIsLaybyPayment: boolean;          // True if this is a Layby Payment sale
    bIsInvoice: boolean;               // True if invoice transaction
    bIsQuote : boolean;                // true if quote txn
    bIsSalesOrder : boolean;           // TRUE if sales order txn
    bKeypadChange: boolean;            // True if we change from the primary keypad
    bIsTraining: boolean;              // True if in training mode
    bProcessingLaybyCompletion: boolean;
    {customer discount is always applicable as by default CASH CUSTOMER is selected and the discount is appliable for CASH CUSTOMER as well.}
    bIsCalcDiscDone: boolean;       // true if cust discount has been applied, this sale
    bSwipeCardInProgress: boolean;
    bIsUsingReceiptPrinter: boolean;// true if this pref is turned on for this till
    bIsPrinterToggledOn: boolean;   // driven by toggle function and state saved in back end
    bOkToOpenCashDrawer: boolean;
    bOkToOpenRemoteCashDrawer: boolean;
    bIsBarTab: boolean;             // is this sale to be posted to bar tab
    bIsPayTab: boolean;             // is Pay Tab
    bIsTransferTab: boolean;
    bIsCloseTab: boolean;          // Close tab in progress;
    bIsSplitAccount: boolean;      // Split tab amongst customers by product
    bIsSplitTab: boolean;          // Split tab payment amoungst customers
    bIsEndOfSplitTab: boolean;     // End Of Split Tab

    bPrintReceipt: boolean;        // Won't print receipts if false
    rRcptRunTot: currency;         // Total for printing receipts
    rRcptRunTotNoTax: currency;    // Total Ex tax for printing receipts

    // Details for locked functionality
    iLockedRow: integer;
    iLockedCol: integer;
    iLockedHotKey: char;
    sLockedLine1: string;
    sLockedLine2: string;

    DelBitMap: TBitmap;       // For Delete button on string grid
    CompletedBitMap: TBitmap; // displayed on grid when completed
    NullBitMap: TBitmap;

    LineItem: pLineItemRec;    // line item list
    lstLineItems: TList;

    lstPayments: TList;
    lstSplitTabPayments: TList;
    lstRcptPayments: TList;
    lstRedeemPoints:TList;

    LaybyItem: pLaybyItemRec;
    lstLaybyItems: TList;

    ProcessedBarTabItem :pProcessedBarTabs;
    lstProcessedBarTabs :TList;

    SavedContext: TSavedContext;
    bTransOnHold: boolean;

    // Company Info
    sCompanyName: string;
    sAddress: string;
    sAddress2: string;
    sCity: string;
    sState: string;
    sPostCode: string;
    sCountry: string;
    sABN: string;
    sPhoneNumber: string;
    sFaxNumber: string;


    oDiscount: TClientDiscountObj;
    oPrice: TProductPriceObj;
    ProductRec: TSubProductRec;
    bDebugTrafficPro: boolean;

    // related parts
    dRelatedQtyMultiplier: double;

    bIsEft: boolean;
    sEftTxnRef: string;          // EFT Transaction reference for the last EFT transaction
    bIsEftCashOutOnly: boolean;  // true if this sale is an EFT cashout without any purchases

    oRcptPrn: TReceiptPrinter;
    oCashDrawer: TReceiptPrinter;
    lstReceipt: TStringList;

    iCashCustomerID: integer;  // client ID of Cash Customer

    rSplitTabToPayAmount: currency;  // Amount remaining to pay on split tab
    iSplitTabGroupID: integer;       // All payments within the same bar split have the same group ID
    rAmountThisSplit: currency;      // Represents the payment Split required for the current split
    bSplitInProgress: boolean;       // Current split in progress
    sSplitParentID: string;          // the root ID for the split
    iTabClientID: integer;           // ClientID of Tab

    dtTabCreateDate: TDateTime;
    sTabCreateTime: string;

    //SrNoTransObj: TSrNoTrans;
    oBarTabIDList: TStringList;      // List of SaleId (tblSale_pos) for current Bar Tab
    HasAccessToCustomerlist :Boolean;

    bPOSPrintReceiptOnlyOnCompleteSale : boolean;
    bPOSPrintDescriptionMultipleLines : boolean;

    bPrintReceiptCount : integer; //need to know if receipt is duplicate

    bUseAlphaNumericBarcodes : boolean;
    fClient :TClient;
    sPOSPCode:STring;
    sCustPONumber:String;
    sMedtype:String;
    iMedTypeID:Integer;
    POSGroupObj: Tposgroup;
    fsBankAccountName :String;
    fsBankAccountBSB  :String;
    fsBankAccountNo   :String;
    fsChequeNumber    :String;
    CrashOut: boolean;
    RedeemedPointsDesc :String;
    totalRedeemedPoints :double;
    totalRedeemedAmount :double;

    Poledisplayenabled:Boolean;
    currentPoledisplay:String;
    PolePort:String;
    OPOSScanning:Boolean;
    OPOSScale:TOPOSScale;
    DateTimeOfSale: TDateTime;
    fbCreditCardPayment:boolean;
    saleIdtoRefund:Integer;
    // Getters & Setters
    oPOSBtnMatrix: TPOSBtnMatrix;
    oFnBtnMatrix: TFnBtnMatrix;
    SelectedTaxCodeId: integer;
    SignatureStream: TMemoryStream;
    fOldIdleEvent: TIdleEvent;
    fStopTime: TTime;
    fStartTime: TTime;
    fOldMessageEvent: TMessageEvent;
    fVideoFiles: TWMVFileIterator;
    fPosVideoDelay: integer;
    TempProductID, TempClassID: integer;
    fIsSaleSplit: boolean;
    FormKeys : Array of word;
    fbSendingFormKeys :Boolean;
    fsUserTempName :STring;
//    fQueryWork: TERPQuery;
    Procedure OpenPole;
    Procedure OpenOPOS;
    Procedure CloseOPOS;
    Procedure OpenCustomerDisplay;
    Procedure totalPointsCallback(Const Sender: TBusObj; var Abort: boolean);
    function PosObj: TPOS;
    Procedure setIsPOSInvoice(Const Value:Boolean);
    procedure SetFuncBookingID(const iFuncBookingID: integer);
//    procedure SetRepairID(const iRepairID: integer);
    procedure SetQuoteID(const iQuoteID: integer);
    procedure SetHireID(const iHireID: integer);
    procedure SetAppointID(const iAppointID: integer);
    function GetQuantity: integer;
    function GetProductID: integer;
    function GetDummySaleID: integer;
    function GetClientID: integer;
    function getClient :Tclient;
    procedure HandleNoAccessException(const e: Exception); reintroduce;
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;


    procedure AddDigitToViewer(const cDigit: char);
    procedure DoHotKey(const chHotKey: char);
    procedure StripCurrStr(var sCurr: string);
    procedure DisplayRunTot(const rTotal: currency);
    procedure ReCalcRunTot(Showinviewer:Boolean =True); // Calculates the running total from the grid
    procedure RefreshCustomerDisplay;
    procedure TopOfViewer;   // Scrolls to the top of the viewer
    procedure UpdateDate;
    procedure ClearAll;    // Clears the grid and the memo
    Function  PostSaleItem(const sDescriptions: string; const rPrice: currency; const rQuantitys: double;
      const iLaybyID: integer; const rLbyBal: currency; const rLbyAmount: currency; const bShow: boolean;
      const bIsTaxInc: boolean; const bApplyDisc: boolean;
      const bIsDiscount: boolean = false; const bIsChild: boolean = false; const iUnitID: integer = 0; fiRefundedSalesLineID:Integer=0) :Boolean; Overload;
    Function  PostSaleItem(var  ItemRec: pLineItemRec;const sDescriptions: string;const rPrice :double;
        const rQuantitys: double; const iLaybyID: integer; const rLbyBal: currency; const rLbyAmount: currency;
        const bShow: boolean; const bIsTaxInc: boolean;  // price includes tax
        const bApplyDisc: boolean; const bIsDiscount: boolean = false;
        const bIsChild: boolean = false; const iUnitID: integer = 0;
        const fiRefundedSalesLineID:Integer = 0):Boolean; Overload;
    function POSRoundTo5C(const rMoney: currency): currency;
    procedure LaybyPayment;
    procedure ShowLaybyList;
    procedure UpdateLaybyBalance(const iSaleID_: integer; const rLaybyBal: currency);
    procedure FinishNewLayby;
    procedure FinishInvoice;
    procedure FinishQuote;
    procedure FinishSalesOrder;
    procedure PerformFunction(const FnID: integer);
    function PostToDB: boolean;
    function PostSaleToDB:Boolean;
    Function SavePOS:boolean;
    procedure PostSaleHeaderToDB;
    Procedure AcceptExtraDetails;
    procedure PostLineItemsToDB;
    procedure PrintReceipt(PrintingOnCancel:Boolean =False;PrintingOnEroror:Boolean =False);
    procedure GetCompanyInfo;
    procedure CleanUp;
    function IsLineItems: boolean;
    function idOk: boolean;
    procedure AddLineToMemo(const sText: string);
    //procedure UpdateKeypad;
    procedure FindAndPostPart(const PartNumber: integer; Showinviewer:boolean = True);
    Function FindAndAddPart(const PartNumber: integer; Showinviewer:boolean = False):boolean;
    procedure ShowCustList(Const AllowCustomerSelection:Boolean = True);
    function GetTaxRate(const sTaxCode: string): double;
    function AccountID(const sAccount: string): integer;
    procedure SetPeripherals;
    function IsAccessAllowed(const sFnName: string; const iEmployeeID: integer = 0): boolean;
    procedure CreateLineItem(const bIsDiscount: boolean; const iUnitID: integer);
    function FilterPartsByName(const sName: string): boolean;
    function FilterPartsByID(const iPartsID: integer): boolean;
//    function FilterSalesLinesByID(const iSaleID: integer): boolean;
    procedure DisplayLineItem(const pItemRec: pLineItemRec);
    procedure RefreshDisplayLine(const pItemRec : pLineItemRec; RowNum : integer);
    procedure ProcessLaybyCompletion;
//    procedure UpdateAccounts(const iSaleID: integer; const bUpdateSnTracking: boolean = true);
//    procedure UpdateAvgCosts;
    function GetTillName(const iTillID: integer): string;
    function GetPrimaryPad(const iTillID: integer): integer;

    procedure ResetCustInfo;
    procedure PostAndDisplayAnyProductDisc;
    Procedure RefreshMatrixPrice;
    procedure CalcAndPostCustDisc;
    procedure DullDisplay;
    procedure NormalDisplay;
    procedure HighlightDiscCustomer;
    //procedure UnHighlightDiscCustomer;
    procedure CustomizePOS;
    procedure RebuildGrid;
//    function IsProduct(const pItem: pLineItemRec): boolean;
    //function IsSpecDiscount(pItem: pLineItemRec): Boolean;
    function LoadCustomer(const iCustID: integer): boolean;
    function LoadSalesCustomer(const SalesFlobalRef:String): boolean;
    function LoadSalesman(const iSalesmanID: integer): boolean;
    function IsTotalDiscOk(ASource : integer = 0) : boolean;
    procedure DisplayInViewer(const sText1: string; const sText2: string = '');
    function GetUpdatedLaybyBal(const iLaybyId: integer; const rMasterBal: currency): currency;
    function GetLaybyBal(const iLaybyId: integer): currency;
    procedure RemoveLine(const iRow: integer);
    procedure RemoveLaybyLines(const iLaybyID: integer);
//    procedure UpdateSNTracking(const iDummyID, iSaleID: integer);
    procedure DoPayment(const sDescription: string; const sPayType: string); overload;
    procedure DoPayment(const rTendered: currency; const sDescription: string; const sPayType: string); overload;
    function PostPayment(const Tendered: currency; const sDescription: string; const sPayType: string): integer;
    function IsValidAmount(const bShowMessage: boolean = true): boolean;
    function GetAmount: currency;
    function GetPayments: currency;
    procedure PostPaymentsToDB;
    procedure SaveContext;
    procedure LoadSavedContext;
    function IsVoucherAlreadySelected(const iVoucherID: integer): boolean;
    function IsVoucherAllowed: boolean;
    function IsProductAllowed: boolean;
    function IsLaybyPayAllowed: boolean;
    procedure AddAnyVoucherReversals;
    function IsAnyLaybyPayments: boolean;
    function AssignBarcode(const iPartNumber: integer): boolean;
    function AssignSwipeCard(const sCardNum: string; const iCustID: integer): boolean;
    function AssignAccountNumber(const sAccountNum: string; const iCustID: integer): boolean;

    function IsPrinterToggledOn: boolean;
    procedure SetPrnStatus(const bStatus: boolean);
    procedure IndicatePrnStatus;
    function LoadRefund(const sGblRef: string): boolean;
    function GetPartIDFromPartNubmer(const PartNubmer: string): integer;
//    procedure MonitorTraffic;
    procedure POSKeyDown(const wKey: word; const Shift: TShiftState);
    procedure AddPaymentToList(const sPayType, sRef: string; const rAmount, rTendered: currency;
      const iID, iLaybyID: integer);
    function IsAnyPaymentsByCheque: boolean;
    function IsAnyPaymentsByVoucher: boolean;
    function IsAnyAccountPayments: boolean;
    function IsAnyCashOut: boolean;
    procedure SummariseSales;
    procedure OpenCashDrawer;
    procedure AddCharToCardNumber(const cChar: char);
    procedure EndSwipeCard;
    function SetTill: integer;
    procedure LoadRelatedParts(const iParentID: integer; const dQty: double; const ParentID:Integer; ParentProductHidden:boolean;issubrelated:Boolean =False );
    procedure updateRelatedProductsQty(RelatedParentID:Integer; RelatedParentQty:Double);
    procedure DoEftTransaction(const sCommand: string; const rCashOut: currency);
    procedure InsertEftRcptText(const Text: string);
    procedure PrintEftReceipt;
    function IsValidCashAmount(const rAmount: currency): boolean;
    function FinaliseAndCheckSale: boolean;
    function GetNextEftID: string;
    procedure SetEftInProgress(const bState: boolean);
    function IsEftInProgress: boolean;
    procedure CompleteEftInProgress;
    procedure LoadProductRec(const iPartID, iUnitID: integer; const rQty: double);
    function IsUsingReceiptPrinter: boolean;
    function OkToOpenRemoteCashDrawer: boolean;
    procedure OpenRemoteDrawer;
    function IsCreditOk(const iClientID: integer): boolean;
    procedure FinishAddToTab;
    procedure FinishPayTab;
    procedure FinishSplitAccount;
    function LoadBarTab(const iClientID: integer): boolean;
    procedure DeleteBarTab(const iClientID: integer);
    procedure CreateBarTabInvoice(const iClientID: integer);
    procedure CreateTabLineItem(const qryLines: TDataset);
    procedure CreateMemoPartLine(const sText: string; const dAmount: currency = 0.0);
    procedure CompleteBarTabInvoice;
    procedure GenerateAllBarTabInvoices;
    function IsAnyBarTabs: boolean;
    function GetLastProduct: integer;
    function IsValidCustomer(const iClientID: integer): boolean;
    function GetFloatValue(var Value: currency): boolean;
    procedure FinishPayAccount;
    procedure FinishPrepayAccount;
    procedure AdjustPayments;
    procedure CreateEOPPayment(const rAmount: double; const sPayMethod: string);
    procedure CreateReceiptLists;
    procedure ClearReceiptLists;
    function IsAnySalesOnProduct(const iClientID, IProductID: integer): boolean;
    procedure FinishCustSales;
    procedure SalesListAfterShow(Sender : TObject);
    procedure PerformEndOfSplitTab;
    procedure CreateSplitTabSales;
    procedure FinishTabList;
    procedure ChangeClientOnBarTabInvoice(const OldiClient, iClient: integer);
    function IsAnyAccoutPayments: boolean;
    Function SavePeriodDetails:Integer;
    procedure LoadImage(ProductID: Integer);
    procedure ClearImage;
    procedure TableSelectorFn;
    procedure RefundFn;
    procedure BarcodeFn;
    procedure ProdCodeFn;
    procedure QuantityFn;
    procedure ChequeNoFn;
    procedure NoSaleFn;
    procedure CancelFn;
    procedure ClearFn;
    function CashFn:boolean;
    Procedure UOMFn;
    Procedure SelectUOMFn;
    procedure TaxCodeFn;
    Function RedeemPoints:Boolean;
    procedure showRedeemPoints;
    procedure CreditCardFn;
    procedure VisaFn;
    procedure EFTFn;
    procedure EftCashOutFn;
    procedure AmexFn;
    procedure DinerFn;
    procedure MasterCardFn;
    procedure InvoiceFn;
    procedure ChequeFn;
    procedure ProductFn;
    procedure PriceChangeFn;
    Procedure ChoosenPrintsale;
    procedure AfterpayFn;

    procedure QuoteFn;
    procedure SalesOrderFn;
    procedure SmartOrderFn;
    procedure SmartOrderBeforeShow(Sender : TObject);
    procedure SmartOrderAfterShow(Sender : TObject);
    procedure InvoiceListFn;
    procedure InvoiceListAfterShow(Sender : TObject);
    procedure CalculatorFn;


    {dollar discount}
    procedure DollarDiscFn;
    procedure DollarDiscFnFixed;
    Procedure Applydiscount(rDiscount:Double);

    {dollar surcharge}
    procedure DollarSurchargeFn;
    procedure DollarSurchargeFnFixed;
    Procedure DoDevmodeTesting;
    Procedure ReadWeight;
    Procedure doPriceMAtrix;
    Procedure EnableOPOSScanner;
    Procedure EnableOPOSScale;
    Procedure OPOSScannerEvent(ASender: TObject; Status: Integer);
    Procedure OPOSOnErrorEvent(ASender: TObject; ResultCode: Integer;
                                                       ResultCodeExtended: Integer;
                                                       ErrorLocus: Integer;
                                                       var pErrorResponse: Integer) ;

    Procedure ApplySurcharge(rsurcharge:Double);

    {%Discount for item}
    procedure PercentDiscItemFn;
    procedure PercentDiscItemFnFixed;
    Procedure ApplyPercentDiscountOnItem(rDiscount:Double);

    {%Discount for total}
    procedure PercentDiscTotalFn;
    procedure PercentDiscTotalFnFixed;
    Procedure ApplyPercentDiscountonTotal(rDiscount:Double);

    {%Surcharge for item}
    procedure PercentSurchargeItemFn;
    procedure PercentSurchargeItemFnFixed;
    Procedure ApplySurchargeOnItem(rSurcharge:Double);

    {%Surcharge for total}
    procedure PercentSurchargeTotalFn;
    procedure PercentSurchargeTotalFnFixed;
    Procedure ApplySurchargeonTotal(rSurcharge:Double);

    Function LineEntry(Caption:String; Amount:double; ProductName:String; Isdiscount:Boolean = False):Boolean;
    procedure LockFn;
    procedure PrintInvFn;
    function SalesmanFn: boolean;
    procedure SalesmanIdFn;
    procedure PrnLfFn;
    procedure PrnToggleFn;
    procedure MemoFn;
    procedure MemoPresetFn;
    procedure ProdListFn;
    procedure CustListFn;
    procedure LayByFn;
    procedure VoucherFn(fnID:Integer);
    procedure VoucherIssueFn;
    Function VoucherRedeemFn:Boolean;
    procedure ChgPadFn;
    procedure MainPadFn;
    procedure TrainModeFn;
    procedure EOPFn(All: boolean);
    procedure InterruptFn;
    procedure CompleteSaleFn;
    procedure CashOutFn;
    procedure SubProductFn;
    procedure PickingSlipFn;
    procedure PrintPickingSlip(const SaleID: integer);
    procedure FixedAmountFn;
    procedure MemoLineFn;
    procedure SwipeCardFn;
    procedure ReprintEftFn;
    procedure LineFeedFn;
    procedure EFTSettlementFn;
    procedure EFTControlFn;
    procedure CustAccountFn;
    procedure BarTabFn;
    procedure PayTabFn;
    procedure CloseAllTabsFn;
    procedure CustSalesFn;
    procedure PayAccountFn;
    procedure PrepayAccountFn;
    procedure SplitAccountFn;
    procedure SplitTabFn;
    procedure TabListFn;
    procedure TransferTabFn;
    procedure OnCustomerSelect(Sender: TwwDBGrid);
    procedure OnrewardPointSelect(Sender: TObject);
    Procedure SearchnRefreshRedeemPoints;
    procedure OnProductSelect(Sender: TwwDBGrid);
    procedure OnLaybySelect(Sender: TwwDBGrid);
    procedure OnVoucherSelect(Sender: TwwDBGrid);
    procedure OnBarTabSelect(Sender: TwwDBGrid);
    procedure OnUOMSelect(Sender: TwwDBGrid);
    procedure OnTaxCodeSelect(Sender: TwwDBGrid);
    Procedure UpdateAppt;
    Procedure MatchPrevQtyFn;
    procedure DebitCardFn;
    procedure MaestroFn;
    procedure CustomerSignatureFn;

    procedure DeleteTempTable;
    function GetUserTempName: string;
    procedure CreateTempTable;
    Procedure OpenInvoice(Const Sender: TBusObj; var Abort: Boolean);
    Procedure GetChequeDetails;
    procedure POSCommandHandler(const Sender: TObject; const Event: string; const Data: Pointer);
    Procedure Createtransrec(const Matrixform :Tcomponent);
    procedure setiTillID(const Value: Integer);
    function  MemoInput(const memoCaption: String; var sResult: String; Required: boolean = false): Boolean;
    Procedure EnteringNum(const Value:Boolean);overload;
    function EnteringNum:Boolean; overload;
    Function ProductPrice:Double;
    Function ValueFromLine1(PosBtn:TPosBtn):double;
    function CurrentRow:PLineItemRec;
    procedure RefreshCurrentlineitem(const pItemRec: pLineItemRec);
    procedure DisplayItemoonPole(const pItemRec: pLineItemRec);
    Procedure RefreshforCustomer;
    procedure CaluclateDiscount(pItem: pLineItemRec);
    Function DiscountDescription:String;
    Function GetVouchernumber:Boolean;
    function Validvoucherno(const sVoucherNo:String; var errmsg:String):Boolean;
    Procedure ShowDetails;
    function UnitDescription(const UnitID:Integer):String;
    Procedure PrintSaleinA4(const posSaleId:Integer);
    procedure DisplayWelcomeOnPole;
    Procedure DisplayMemoFirstLineOnPole;
    Function CancelOnError:boolean;
    function canConnect:Boolean;
    function CurrencyToStrF(Value: Currency; Format: TFloatFormat): string;
    procedure ProcessBarCode;
    function GetTotalDiscountAmount: double;
    function MaxDiscountPercentageExceeded(DiscountAmount: double = 0): boolean;
    procedure DisplayProductOnPole(ProductName:String; Amount:Double);
    procedure DisplayOnPole(Value: String);
    Function LockAllTills(QryTills:TErpQuery):Boolean;
    Procedure unlockallTills;
    procedure SetMatrixDetails(pItem: pLineItemRec;sMatrixDesc, sMatrixRef: String;      dMatrixPrice: double);
    procedure PrintPos;
    function ItemForGridIndex(const Gridindex: Integer): pLineItemRec;
    procedure NewLineItem;
    procedure LogAllProducts;
    procedure Logit(PItem: pLineItemRec);
    procedure RemoveRelatedItems(const ItemId: integer);
    function indexof(pItem: pLineItemRec): Integer;
    procedure TotalinCustomerdisplay(const TotalAmount: Double);
    function VoucherNoRange(var VNOFrom, VNOto: Int64): Boolean;
//    function EnteredNumAsinteger: Integer;
    function EnteredNumAsFloat: Double;
    procedure MakeVoucherforRange;
    function IteraterecordProgressbarMsg(Sender: TDatasetBusObj): String;
    function LockVoucher: boolean;
    function PrintPOSTemplateReport(fiPOSID:Integer; IsToBesummarised:Boolean =False): Boolean; Overload;
    function PrintPOSTemplateReport: Boolean;Overload;
    procedure beforeshowProductList(Sender: TObject);
    procedure inintSoldnRefundQtyofSales(Sender: TObject);
    procedure SelectSalesLinesToRefund(Sender: twwDBGrid);
    function TillPOStemplateID(const fiTillID: Integer): String;
    function TillA4templateID(const fiTillID: Integer): String;
    function ISoktoShip(var Qty:Double;pItem: pLineItemRec):Boolean;
    function ShippedinCurSale(prodID: Integer): Double;
    procedure SetGridcolumns;
    Procedure hideColumn(colindex:Integer; ShowColumn:Boolean);
    procedure DoPrintSale(Sender: TwwDbGrid);
    procedure PrintEOPProductGroupreport(const TillIDs: String);
    procedure setIsPosQuote(const Value: boolean);
    procedure setIsPOSSalesOrder(const Value: boolean);
    procedure SetPosVideoDelay(const Value: integer);
    function AutoRoundRelatedQty(aLineItemRec: pLineItemRec;      ParentQty: Double): Double;
    procedure initProductQtyBinETA(Sender: TObject);
    procedure initPOSform;
    procedure ClearInputMemo;
    procedure LogKey(Key: word);
    function anySelected: Boolean;
    procedure DoSelectAll;
    function UnLockVoucher: boolean;
    property OldIdleEvent : TIdleEvent read fOldIdleEvent write fOldIdleEvent;
    property OldMessageEvent : TMessageEvent read fOldMessageEvent write fOldMessageEvent;
    property StartTime : TTime read fStartTime write fStartTime;
    property StopTime : TTime read fStopTime write fStopTime;
    Procedure CheckForCashDrop(checkforLotsOf:Boolean =True);
    function AnyLinesSelected: boolean;
    procedure SelectAllLines(Select: boolean = true);
    function CheckSelectedLines(const ACaller : string) : boolean;
    function MakeBankDepositsForCardPayments(const aSaleId: integer): boolean;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Procedure AfterFormShow; override;
    // Hooking SalesList
    procedure HookListForm(aForm : TBaseListingGui);
    procedure ListFormDataSelect(Sender: TwwDbGrid);
    procedure FillLinesBySaleId(aSaleId : integer);

    // Split transactions - Layby
    procedure BackupUnselected(ALayBy : boolean);  // delete unselected lines and push them into temp storage
    procedure RestoreUnselected; // Restore lines from tem storage
    procedure MergeUnselected;
//    function isSaleSplit : boolean;
    property isSaleSplit : boolean read fIsSaleSplit write fIsSaleSplit;

    //
    // Video player stuff
    procedure AppIdle(Sender: TObject; var Done: Boolean);
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
    procedure StopPlayer;
    procedure PlayFile;
    procedure CalcVideoDisplayRatio;
    procedure SavePosVideoDelay;
    procedure ReadPosVideoDelay;
    property VideoFiles : TWMVFileIterator read fVideoFiles write fVideoFiles;
    property PosVideoDelay : integer read fPosVideoDelay write SetPosVideoDelay;

  public
    { Public declarations }
    fbNoActivate: boolean;
    ftblSalesLinesDetails: TERPQuery;
    bTransComplete: boolean;
    CustomerDisplay: TPOSCustomerDisplayGUI;
    constructor Create(AOwner: TComponent); override;
    procedure SetPOSScreenActive;
    property FuncBookingID: integer read iFuncBookingID write SetFuncBookingID;
    property QuoteID: integer read iQuoteID write SetQuoteID;
    property HireID: integer read iHireID write SetHireID;
    property AppointID: integer read iAppointID write SetAppointID;
    property Quantity: integer read GetQuantity;
    property DummySaleID: integer read GetDummySaleID;
    property ProductID: integer read GetProductID;
    property ClientID: integer read GetClientID;
    property VoucherNo: string write sVoucherNo;
    property NoActivate: boolean read fbNoActivate write fbNoActivate;
    property AppointmentTotalHours: double read dAppointmentTotalHours write dAppointmentTotalHours;
    property AppointmentFreeHours: double read dAppointmentFreeHours write dAppointmentFreeHours;
    property AppointmentRate: double read dAppointmentRate write dAppointmentRate;
    Property IsPOSInvoice :Boolean read bIsInvoice Write setIsPOSInvoice;
    property IsPosQuote : boolean read bIsQuote write setIsPosQuote;
    property IsPOSSalesOrder : boolean read bIsSalesOrder write setIsPOSSalesOrder;
    Property BankAccountName :String Read fsBankAccountName write fsBankAccountName;
    Property BankAccountBSB  :String Read fsBankAccountBSB  write fsBankAccountBSB;
    Property BankAccountNo   :String Read fsBankAccountNo   write fsBankAccountNo;
    Property ChequeNumber    :String Read fsChequeNumber    write fsChequeNumber;
    Property client          :TClient REad getClient;
    Property iTillID         :Integer REad xiTillID Write setiTillID;
  end;

//var
//  oPOSBtnMatrix: TPOSBtnMatrix;
//  oFnBtnMatrix: TFnBtnMatrix;


implementation

{$R *.DFM}

uses FastFuncs, CommonDbLib,
  DNMExceptions,   DNMLib, Math,  ppTypes,
  RemotePrnObj,  DecimalRounding,
  MAIN, tcConst, tcDataUtils, CommonLib, dmMainGUI,
  POSSalesmanGUI, POSChequeGUI, POSMemoGUI, POSGetTillGUI,
  POSSplitAccountGUI, POSTableSelector,POSCreditGUI,
  CustomizePOSGUI, CustomerDisplayObj,
  CustomerSalesOnProductList, frmcustPayments, frmProductQtysBinsETAs,//frmProductQtyBinGUI,
  frmCustPrepayments, frmInvoice, POSCashierEOP, ReportTemplates,
  ShellAPI, AppEnvironment,
  BusobjSaleBase, MySQLConst,
  frmPaymentsChequeDetails, BusobjCash,  GlobalEventsObj,
  ComObj, PrintPickingSlipsLib, frmProdAttribmatrix, frmPOSCancelDialog,
   CompanyPrefObj, UnitOfMeasureforProduct, BusObjSalesRedeemPoints,
  GuiPrefsObj, DataTreeObj, PoledisplayObj, busobjcompinfo , OPOSConfigObj,
  sndkey32,OposScanner_CCO_TLB , RewardPointsDetails, UserLockObj,
  PartsPriceMatrixLib, frmproductPrices, frmpartsPriceMatrixInput,
  BusObjPOSSale, CommonFormLib, FrmPOSInput , IntegerListObj, BusObjConst,
  VoucherLib, BusObjPosTill, SystemLib, SoldnRefundQtyofSales,
  BusobjStockAdjustEntry, frmPOSCustomizeGrid, DBSharedObjectsObj, ImagesLib,
  ProductQtyLib, LogLib, POSConst, POSLIB, BusObjProductClass,
  SalesDiscountValidationObj, BusobjHire, frmSignatureEdit, IniFiles,
  BusobjCustomFilter, Printers, BusObjCashDrop, TemplateReportsLib, PQALib,
  frmCardPayment, BusObjBankDepost, BusObjGLAccount, JSONObject;

const
  POS_ERROR   = -1;
  POS_SUCCESS = 1;

  FINAL_PAYMENT  = 2;
  ACCESS_ALLOWED = 1;
  PRICE_LEN      = 13;
  ASCII_0        = 48;
  DOT_KEY        = 190;
  ENTER_KEY      = 13;
  CHR_BS         = #8;
  DEFAULT_PAD    = 1;
  MAX_INTEGER    = 2147483647;
  LAST_ITEM      = -1;

  FN_SWIPECARD   = 998;

  BS  = #8;
  ESC = #27;
  LF  = #10;
  CR  = #13;

  // Transaction States
  TRN_COMPLETE  = 1;
  TRN_INPROCESS = 2;
  TRN_NONE      = 3;



  // Payment Types
  //PAY_CASH         = 'Cash';
  PAY_CREDITCARD   = 'Credit Card';
  PAY_DEBITCARD    = 'Debit Card';
  PAY_CHEQUE       = 'Cheque';
  PAY_AMEX         = 'Amex';
  PAY_MASTERCARD   = 'Master Card';
  PAY_DINER        = 'Diners Club';
  PAY_EFT          = 'E.F.T.';
  PAY_VISA         = 'VISA';
  PAY_Maestro      = 'Maestro';
  PAY_LAYBY        = 'Layby';
  PAY_VOUCHER      = 'Voucher';
  PAY_VOUCHER_REVERSAL = 'Voucher Reversal';
  PAY_POS_ACNT_PAY = 'POS Account Payment';
  PAY_AFTERPAY     = 'Afterpay';
  PAY_NONE         = '';
  // The following are not strictly payment methods, they are never
  // .. used to log payments in the payment table.  But they are require
  // .. by the logic
  PAY_COMPLETE = 'Complete';
  //PAY_CASH_OUT = 'Cash Out';
  PAY_TAB      = 'Tab';


  // Part Descriptions
  DESC_SPEC_DISC = 'Special Product Discount';

  ACNT_ACNTS_RCV         = 'Accounts Receivable';

  VK_PLUS      = 187;    // this is the +/= buttons key code
  VK_SEMICOLON = 186;    // this is the +/= buttons key code

  // Grid columns
  COL_BTN       = 0;
  COL_QTY       = 1;
  COL_NAME      = 2;
  COL_DESC      = 3;
  COL_PRICE     = 4;
//  COL_UOMPRICE  = 5;
  COL_AMOUNT    = 5;
  COL_PROFITPERCENT = 6;
  COL_PROFITDOLLAR = 7;


  MAX_ROWS = 12;   // Grid rows before commence scrolling

  CL_FUNKY_BLUE = $00EFE8CF;

  VisualConsoleName = 'Visual Console';
  PrepayStr = ' -= Prepaid =-';
  RefundStr = ' -= Refund =-';

function IsCardPayment(const aPaymentType: string): boolean;
begin
  result :=
    SameText(aPaymentType,PAY_CREDITCARD) or
    SameText(aPaymentType,PAY_DEBITCARD) or
    SameText(aPaymentType,PAY_AMEX) or
    SameText(aPaymentType,PAY_MASTERCARD) or
    SameText(aPaymentType,PAY_DINER) or
    SameText(aPaymentType,PAY_VISA) or
    SameText(aPaymentType,PAY_Maestro);
end;

procedure TPOSScreenForm.TotalinCustomerdisplay(const TotalAmount:Double);
begin
  if Assigned(CustomerDisplay) then CustomerDisplay.RefreshTotal(TotalAmount);
end;

procedure TPOSScreenForm.FormCreate(Sender: TObject);
begin
fsUserTempName := '';
try
  pnlMediaHost.Visible := false;
  fbSendingFormKeys := False;
  saleIdtoRefund:= 0;
  // Create the Function Key button matrix
  // This must be done before inherited so foreign language stuff works
  oFnBtnMatrix := TFnBtnMatrix.Create(pnlFnKeyBtns);
  inherited;
//  pnlNumericKeyPad.Left := lblMemoText.Left;
//  pnlNumericKeyPad.top := lblMemoText.top;
  pnlNumericKeyPad.Left := grdTrans.Left;
  pnlNumericKeyPad.top := grdTrans.top + grdTrans.Height + 8;
  fbCreditCardPayment := False;
  OPOSScanning := False;
  Poledisplayenabled := False;
  currentPoledisplay := '';
  PolePort := '';
  //PoleDisplayWidth:=29;
  fExtraDetailItem := ediNone;
  CrashOut:= false;
  bOnhold:= False;

  HasAccessTocustomerList := AppEnv.AccessLevels.GetEmployeeAccessLevel('TCustomerListGUI') < 6;
  PaymethodPressedInProgress := false;



  // Initialize some globals
  dAppointmentTotalHours := 0;
  dAppointmentRate := 0;

  rQuantOfProd := 1.0;
  rRunTot := 0.0;
  rRunTotNoTax := 0.0;
  rPriceChange := 0.0;
  sRef := '';
  sPayType := '';
  bRefundMode := false;
  bLoadedRefund := false;
  EnteringNum(false);
  bTransComplete := true;

  bPrintReceiptCount := 0; // reset counter


  bPriceChange := false;
  bApplyDiscToPriceChange := false;
  bUpdateDate := true;
  bIsLocked := false;
  iCustOriginator := FN_NONE;
  iProdOriginator := FN_NONE;
  bDebugTrafficPro := false;
  dRelatedQtyMultiplier := 1;

  sPrnDev := 'COM1:';
  sPrnType := 'EPSON';
  sPrnname:= '';
  bMustEnterIdNow := false;
  bChqNoEntered := false;
  bProcessingLaybyCompletion := false;
  iCashCustomerID := tcDatautils.GetClientID(CLIENT_CASH);


  KeyPreview := true;  // we want control of all keystrokes

  // Open DB for price and description
  Product := TProduct.Create(Self);
  Product.IsReadonly:= true;
  qryProduct.Connection := CommonDbLib.GetSharedMyDacConnection;
  Product.Dataset := qryProduct;

  // This table is used to pass data to inventory object
  ftblSalesLinesDetails := TERPQuery.Create(Self);
  ftblSalesLinesDetails.Connection := CommonDbLib.GetSharedMyDacConnection;

  // Create the POS button matrix with buttons which don't stay down
  oPOSBtnMatrix := TPOSBtnMatrix.Create(pnlPOSBtns, lblDefaultFont.Font, false);

  // Load variable button details from file
  oPOSBtnMatrix.LoadFromDB;

  // Select Top Left button
  //oPOSBtnMatrix.SelectButton(1, 1);


//  // Create the Function Key button matrix
//  oFnBtnMatrix := TFnBtnMatrix.Create(pnlFnKeyBtns);

  oPrice := TProductPriceObj.Create;
  oDiscount := TClientDiscountObj.Create;

  lstLaybyTerms := TStringList.Create;
  lstFooter := TStringList.Create;
  lstRewardPoints:= TStringList.Create;
  lstReceipt := TStringList.Create;


  iCashCustID := tcDatautils.GetCashCustID;

  GetCompanyInfo;


  // Init Transaction Grid
  with grdTrans do begin
    Cells[COL_QTY   , 0]  := 'Qty';
    Cells[COL_NAME  , 0]  := AppEnv.DefaultClass.PartColumn;
    Cells[COL_DESC  , 0]  := 'Description';
    Cells[COL_PRICE , 0]  := 'Unit Price';
//    Cells[COL_UOMPRICE , 0]  := 'UOM Price';
    Cells[COL_AMOUNT, 0]  := '    Amount';
    Cells[COL_PROFITPERCENT, 0] := ' Profit, %';
    Cells[COL_PROFITDOLLAR, 0] := ' Profit, $';
    RowCount           := 2;
    Background.Cells   := bcNormal;
    Background.Display := bdFixed;
    Background.Left    := 150;
    Background.Top     := 0;
  end;

  CompletedBitMap := TBitmap.Create;
  NullBitMap      := TBitmap.Create;
  CompletedBitMap.Assign(Completedpic.Picture);
  CompletedBitMap.Transparent := true;

  // Init 'Delete' Bit map
  DelBitMap := TBitmap.Create;
  DelBitMap.Assign(imgDelete.Picture);
  DelBitMap.Transparent := true;


  lblRunTot.Caption :=  CurrencyToStrF(0, ffCurrency); // AppEnv.RegionalOptions.CurrencySymbol+'0.00';
  TotalinCustomerdisplay(0);
  lblTotalQuantity.Caption:= '0';
  lblSaleNo.Caption := '';
  lblMemoText.Caption := '';

  // tag Product record as invalid at this stage
  ProductRec.Valid := false;

  UpdateDate;   // Update the date

  FormatSettings.NegCurrFormat := 1;  // Set Currency format as -$9,999.00


  ClearInputMemo;

//  lblStore.Caption := AppEnv.Branch.SiteDesc;

  lblSalesPerson.Caption:= AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
  iEmployeeID           := AppEnv.Employee.EmployeeID;
  lstLineItems          := TList.Create;
  lstPayments           := TList.Create;
  lstRedeemPoints       := TList.Create;
  lstSplitTabPayments   := TList.Create;
  lstRcptPayments       := TList.Create;
  lstLaybyItems         := TList.Create;
  lstProcessedBarTabs   := TList.Create;
  SavedContext.flstLineItems := TList.Create;

  iTillID               := SetTill;
  lblStore.Caption := GetTillClassName(iTillID);

  //Customer Display
  openCustomerDisplay;
  openPole;
  OpenOPOS;

  iPrimaryPad := GetPrimaryPad(iTillID);

  try
    SetPeripherals;
  Except
    on E:Exception do begin
      if devmode then
        MessageDlgXP_Vista('DEVMODE:' +NL+NL+E.message, mtWarning, [mbOK], 0);
    end;
  end;

  bIsUsingReceiptPrinter := IsUsingReceiptPrinter;
  bIsPrinterToggledOn := IsPrinterToggledOn;
  bOkToOpenCashDrawer := OkToOpenCashDrawer(iTillID);
  bOkToOpenRemoteCashDrawer := OkToOpenRemoteCashDrawer;

  bPrintReceipt := bIsUsingReceiptPrinter and bIsPrinterToggledOn;
  IndicatePrnStatus;

  btnKeyPad.Visible := AppEnv.CompanyPrefs.POSNumKeyPad;

  // Intitialize the random number generator
  Randomize;

  pnlPOSBtns.Enabled := false;

  POSGroupObj := nil;

  ClearAll;
  CleanUp;
  pnlPOSBtns.Enabled := true;

  NormalDisplay;

  bUseAlphaNumericBarcodes := AppEnv.CompanyPrefs.UseAlphaNumericBarcodes;


  GlobalEvents.RegisterHandler(self,'','','',GEVENT_POS_DoRebuildGrid,POSCommandHandler);
  fbnoSAvesound := True;
  fbNoCanelsound:= True;

  // Video stuff
  VideoFiles := TWMVFileIterator.Create(csPosVideoFiles);
  if VideoFiles.Count > 0 then
  begin
    OldIdleEvent := Application.OnIdle;
    OldMessageEvent := Application.OnMessage;

    Application.OnMessage := AppMessage;
    Application.OnIdle := AppIdle;
    ReadPosVideoDelay;
  end;
finally

end;
end;

//======================== CALL BACK FUNCTION TO FIND Visual Console and change Parent
function MyEnumChildProc(ChildHandle: hWND; NewParentHandle: LPARAM): longbool; stdcall;
Var lpBuffer : PChar;
begin
  GetMem(lpBuffer, 255);
  Try
    if GetWindowText(ChildHandle, lpBuffer, 255) > 0 then begin
      if FastFuncs.PosEx(VisualConsoleName, StrPas(lpBuffer)) > 0 then
      windows.SetParent(ChildHandle, NewParentHandle);
      result := false;
    end else
      result := true;
  finally
    FreeMem(lpBuffer, sizeof(lpBuffer^));
  end;
end;
//======================== CALL BACK FUNCTION TO FIND Visual Console and change Parent

procedure TPOSScreenForm.FormDblClick(Sender: TObject);
begin
  inherited;
  LogAllProducts;
end;
procedure TPOSScreenForm.LogAllProducts;
var
  I:Integer;
  s:String;
begin
  if lstLineItems.Count = 0 then begin
    Exit;
  end;
  s:= 'ProductID' +#9 +
      'Qty' +#9 +
      'ProductDescription' +#9 +
      'DiscountDetails' +#9 +
      'ProductName' +#9 +
      'PartType' +#9 +
      'Amount' +#9 +
      'LinePrice' +#9 +
      'Multiplier' +#9 +
      'LinePriceInc' +#9 +
      'LaybyId' +#9 +
      'LaybyBal' +#9 +
      'LaybyAmount' +#9 +
      'TaxCode' +#9 +
      'TaxRate' +#9 +
      'GlobalRef' +#9 +
      'IncomeAccnt' +#9 +
      'AssetAccnt' +#9 +
      'CogsAccnt' +#9 +
    'ProductGroup' +#9 +
    'LineCost' +#9 +
    'LineCostInc' +#9 +
    'ApplyDisc' +#9 +
    'IsProduct' +#9 +
    'IsDiscount' +#9 +
    'DiscRatio' +#9 +
    'IsChild' +#9 +
    'PriceChanged' +#9 +
    'IsSNTracking' +#9 +
    'SoldSerials' +#9 +
    'IsVoucher' +#9 +
    'IsRedeeming' +#9 +
    'VoucherNo' +#9 +
    'IssuedBy' +#9 +
    'IsToBeDeleted' +#9 +
    'FixedPrice' +#9 +
    'UnitID' +#9 +
    'IsFrozen' +#9 +
    'IsAccountPayment' +#9 +
    'AcntPayMethodID' +#9 +
    'AcntPaymentID' +#9 +
    'Area' +#9 +
    'SuppClientID' +#9 +
    'PCCTransHandle' +#9 +
    'PCCDispenser' +#9 +
    'PCCTankNo' +#9 +
    'PCCHoseNo' +#9 +
    'PCCVolume' +#9 +
    'PCCValue' +#9 +
    'PCCClientType' +#9 +
    'PCCGradeDesc' +#9 +
    'PCCVolumeName' +#9 +
    'PCCUnitPrice' +#9 +
    'BarTabID' +#9 +
    'BarTabLineID' +#9 +
    'CustomData' +#9 +
    'MatrixDesc' +#9 +
    'MatrixRef' +#9 +
    'MatrixPrice' +#9 +
    'CanDeleteRelated' +#9 +
    'CanDeleteInPOS'+#9+
    'IsrelatedHidden' +#9 +
    'GridIndex' +#9 +
    'ID' +#9 +
    'RelatedParentID' +#9 +
    'RelatedQtyMultiplier' +#9 +
    'RelatedParentQty';
  for i :=  0 to lstLineItems.Count - 1 do begin
    Logit(pLineItemRec(lstLineItems[i]));
  end;
end;
Procedure TPOSScreenForm.Logit(PItem:pLineItemRec);
var
  s:String;
begin
    With pItem^ do begin
       s:=intToStr(ProductID)+#9+
            FloatTostr(Qty)+#9+
            ProductDescription+#9+
            DiscountDetails+#9+
            ProductName+#9+
            PartType+#9+
            FloatTostr(Amount)+#9+
            FloatTostr(LinePrice)+#9+
            FloatTostr(Multiplier)+#9+
            FloatTostr(LinePriceInc)+#9+
            intToStr(LaybyId)+#9+
            FloatTostr(LaybyBal)+#9+
            FloatTostr(LaybyAmount)+#9+
            TaxCode+#9+
            FloatTostr(TaxRate)+#9+
            intToStr(GlobalRef)+#9+
            IncomeAccnt+#9+
            AssetAccnt+#9+
            CogsAccnt+#9+
            ProductGroup+#9+
            FloatTostr(LineCost)+#9+
            FloatTostr(LineCostInc)+#9+
            BooleantoStr(ApplyDisc)+#9+
            BooleantoStr(IsProduct)+#9+
            BooleantoStr(IsDiscount)+#9+
            FloatTostr(DiscRatio)+#9+
            BooleantoStr(IsChild)+#9+
            BooleantoStr(PriceChanged)+#9+
            BooleantoStr(IsSNTracking)+#9+
            SoldSerials+#9+
            BooleantoStr(IsVoucher)+#9+
            BooleantoStr(IsRedeeming)+#9+
            VoucherNo+#9+
            IssuedBy+#9+
            BooleantoStr(IsToBeDeleted)+#9+
            BooleantoStr(FixedPrice)+#9+
            intToStr(UnitID)+#9+
            BooleantoStr(IsFrozen)+#9+
            BooleantoStr(IsAccountPayment)+#9+
            intToStr(AcntPayMethodID)+#9+
            intToStr(AcntPaymentID)+#9+
            Area+#9+
            intToStr(SuppClientID)+#9+
            intToStr(PCCTransHandle )+#9+
            intToStr(PCCDispenser )+#9+
            intToStr(PCCTankNo )+#9+
            intToStr(PCCHoseNo )+#9+
            FloatTostr(PCCVolume )+#9+
            FloatTostr(PCCValue )+#9+
            intToStr(PCCClientType )+#9+
            PCCGradeDesc +#9+
            PCCVolumeName +#9+
            FloatTostr(PCCUnitPrice )+#9+
            intToStr(BarTabID)+#9+
            intToStr(BarTabLineID)+#9+
            CustomData+#9+
            MatrixDesc+#9+
            MatrixRef+#9+
            FloatTostr(MatrixPrice)+#9+
            BooleantoStr(CanDeleteRelated)+#9+
            BooleantoStr(CanDeleteInPOS)+#9+
            BooleantoStr(IsrelatedHidden)+#9+
            intToStr(GridIndex)+#9+
            intToStr(ID)+#9+
            intToStr(RelatedParentID )+#9+
            FloatTostr(RelatedQtyMultiplier)+#9+
            FloatTostr(RelatedParentQty);
  end;
end;

procedure TPOSScreenForm.FormDestroy(Sender: TObject);
begin
  try
      CloseOPOS;
      try FreeandNil(POSGroupObj);                  Except end;
      if Assigned(CustomerDisplay) then FreeandNil(CustomerDisplay);
      DisplayOnPole('POS Closed');
      PoleDisplayObjSetting.DisplayLineOnPole;
      Sleep(1000);
      try FreeandNil(oDiscount);                    Except end;
      try FreeandNil(oPrice);                       Except end;
      try FreeandNil(oPOSBtnMatrix);                Except end;
      try FreeandNil(oFnBtnMatrix);                 Except end;
      try ReceiptPrinterList.FreePrinter(oRcptPrn); Except end;
      try freeandnil(oRcptPrn ); Except end;
      try FreeAndNil(SavedContext.flstLineItems);   Except end;
      if bIsSpooler or bUseSpooler then begin
        // if using the remote printer then the cash drawer is local and will need to be freed
        try ReceiptPrinterList.FreePrinter(oCashDrawer);Except end;
      end;
      try FreeReceiptPrinterList; Except end;
      try FreeandNil(lstLaybyTerms);                Except end;
      try FreeandNil(lstFooter);                    Except end;
      try Freeandnil(lstRewardPoints);              Except end;
      try FreeandNil(lstLineItems);                 Except end;
      try FreeandNil(lstPayments);                  Except end;
      try FreeandNil(lstRedeemPoints);              Except end;
      try FreeandNil(lstSplitTabPayments);          Except end;
      try ClearReceiptLists;                        Except end;
      try FreeandNil(lstRcptPayments);              Except end;
      try FreeandNil(lstReceipt);                   Except end;

      try FreeandNil(NullBitMap);                   Except end;
      try FreeandNil(CompletedBitMap);              Except end;
      try FreeandNil(DelBitMap);                    Except end;
      try if Assigned(oBarTabIDList) then FreeandNil(oBarTabIDList);Except end;
      FreeAndNil(SignatureStream);

      if VideoFiles.Count > 0 then
      begin
        Application.OnIdle := OldIdleEvent;
        Application.OnMessage := OldMessageEvent;
      end;
      FreeAndNil(fVideoFiles);
      inherited;
  Except

  end;
end;

procedure TPOSScreenForm.FormActivate(Sender: TObject);
begin
  Self.WindowState := wsMaximized;
  Self.Menu := nil;
  MainForm.Menu := POSMenu;
  if not fbNoActivate then begin
    // Load button attributes from DB, just incase they have been into customize
    iPrimaryPad := GetPrimaryPad(iTillID);
    if Assigned(oPOSBtnMatrix) then begin
      oPOSBtnMatrix.KeypadID := iPrimaryPad;
      oPOSBtnMatrix.LoadFromDB;
      oPOSBtnMatrix.RemoveStars;
    end;
  end;
  SetPOSScreenActive;
end;

procedure TPOSScreenForm.pnlPOSBtnsClick(Sender: TObject);
  // Get here when the POS buttons are clicked
var
  bAllowed: boolean;
begin
  if not PaymethodPressedInProgress then begin
    PaymethodPressedInProgress := true;
    bAllowed := true;
    bSwipeCardInProgress := false;  // any mouse click will end SwipeCard recognition

    // Ignore if termianl is locked
    if bIsLocked then begin
      // check if 'lock' has been hit to unlock
      oPOSBtnMatrix.SelectButton(Sender);
      if (oPOSBtnMatrix.SelRow = iLockedRow) and (oPOSBtnMatrix.SelCol = iLockedCol) then begin
        bAllowed := true; // lock hit  - so unlock
      end else begin
        bAllowed := false;
        oPOSBtnMatrix.SelectButton(iLockedRow, iLockedCol);
      end;
    end;

    if bAllowed then begin
      // Define button clicked as 'Selected'
      oPOSBtnMatrix.SelectButton(Sender);
      if oPOSBtnMatrix.Selected = nil then begin
        PaymethodPressedInProgress := false;
        Exit;
      end;
      PerformFunction(oPOSBtnMatrix.Selected.Func.FnID);
    end;
    PaymethodPressedInProgress := false;
  end;
end;

procedure TPOSScreenForm.PerformFunction(const FnID: integer);
begin
  // clear the viewer
  case FnID of
      // there are some functions that you don't want to clear the viewer, add them here
      FN_PRINT_RCPT,
      FN_PRN_TOGGLE,
      FN_LINEFEED,
      FN_REPRINT_EFT,
      FN_PRINT_INV:  ;
    else if bTransComplete = true then begin
        ClearAll;
        bTransComplete := false;
      end;
  end;

  if (((FnID = FN_PRODUCT) or (fnID = FN_BARCODE) or (fnID = FN_PROD_CODE) or
    (fnID = FN_PROD_LIST)) and not IsProductAllowed()) then begin
    CommonLib.MessageDlgXP_Vista('You cannot mix a Product and a Layby in the same sale', mtWarning, [mbOK], 0);
  end else begin
    try
      case FnID of
        FN_TABLE_SELECTOR : TableSelectorFn;
        FN_PRODUCT        : ProductFn;
        FN_PRICE_CHANGE   : PriceChangeFn;
        FN_BARCODE        : BarCodeFn;
        FN_CANCEL         : CancelFn;
        FN_CASH           : CashFn;
        FN_UOM            : UOMFn;
        FN_DINER          : DinerFn;
        FN_AMEX           : AmexFn;
        FN_MASTERCARD     : MasterCardFn;
        FN_INVOICE        : InvoiceFn;
        FN_CHEQUE         : ChequeFn;
        FN_CREDIT_CARD    : CreditCardFn;
        FN_QUANT          : QuantityFn;
        FN_DOL_DISC       : DollarDiscFn;
        FN_FIXED_DISC     : DollarDiscFnFixed;
        FN_DOL_SURCH      : DollarSurchargeFn;
        FN_FIXED_SURCH    : DollarSurchargeFnFixed;
        FN_EFTPOS         : EFTFn;
        FN_EFTPOS_CASHOUT : EftCashOutFn;
        FN_LOCK           : LockFn;
        FN_PCENT_DISC_ITM : PercentDiscItemFn;
        FN_FIXED_PCENT_DISC_ITM: PercentDiscItemFnFixed;
        FN_PCENT_DISC_TOT : PercentDiscTotalFn;
        FN_PCENT_SURCH_ITM: PercentSurchargeItemFn;
        FN_PCENT_SURCH_TOT: PercentSurchargeTotalFn;
        FN_PRN_TOGGLE     : PrnToggleFn;
        FN_PRINT_INV      : PrintInvFn;
        FN_SALESMAN       : SalesmanFn;
        FN_SALESMAN_ID    : SalesmanIdFn;
        FN_REFUND         : RefundFn;
        FN_NO_SALE        : NoSaleFn;
        FN_RCPT_LF        : PrnLfFn;
        FN_VISA           : VisaFn;
        FN_CLEAR          : ClearFn;
        FN_CHQ_NO         : ChequeNoFn;
        FN_PROD_CODE      : ProdCodeFn;
        FN_MEMO           : MemoFn;
        FN_LAYBY          : LaybyFn;
        FN_CHG_PAD        : ChgPadFn;
        FN_MAIN_PAD       : MainPadFn;
        FN_TRAIN          : TrainModeFn;
        FN_EOP            : EOPFn(false);
        FN_EOP_ALL        : EOPFn(true);
        FN_PROD_LIST      : ProdListFn;
        FN_CUST_LIST      : CustListFn;
        FN_INTERRUPT      : InterruptFn;
        FN_VOUCHER        : VoucherFn(FnID);
        FN_VOUCHER_REDEEM : VoucherRedeemFn;
        FN_VOUCHER_ISSUE  : VoucherIssueFn;
        FN_COMPLETE_SALE  : CompleteSaleFn;
        FN_CASH_OUT       : CashOutFn;
        FN_FIXED_AMOUNT   : FixedAmountFn;
        FN_MEMO_LINE      : MemoLineFn;
        FN_PRESETMEMO     : MemoPresetFn;
        FN_SUB_PRODUCT    : SubProductFn;
        FN_PICK_SLIP      : PickingSlipFn;
        FN_REPRINT_EFT    : ReprintEftFn;
        FN_LINEFEED       : LineFeedFn;
        FN_EFT_SETTLEMENT : EftSettlementFn;
        FN_EFT_CONTROL    : EftControlFn;
        FN_CUST_ACNT      : CustAccountFn;
        FN_BAR_TAB        : BarTabFn;
        FN_PAY_TAB        : PayTabFn;
        FN_CLOSE_TABS     : CloseAllTabsFn;
        FN_CUST_SALES     : CustSalesFn;
        FN_PAY_ACCOUNT    : PayAccountFn;
        FN_SPLIT_ACCOUNT  : SplitAccountFn;
        FN_SPLIT_TAB      : SplitTabFn;
        FN_TAB_LIST       : TabListFn;
        FN_TRANSFER_TAB   : TransferTabFn;
        FN_PREPAY_ACCOUNT : PrepayAccountFn;
        FN_NONE           :;   // Do nothing, remove this entry to get error message below
        FN_MATCH_PREV_QTY : MatchPrevQtyFn;
        FN_DEBIT_CARD     : DebitCardFn;
        FN_MAESTRO        : MaestroFn;
        FN_DEVMODE        : DoDevmodeTesting;
        FN_READWEIGHT     : ReadWeight;
        FN_PRICEMATRIX    : doPriceMAtrix;
        FN_FIXED_PCENT_DISC_TOT : PercentDiscTotalFnFixed;
        FN_FIXED_PCENT_SURCH_ITM:PercentSurchargeItemFnFixed;
        FN_FIXED_PCENT_SURCH_TOT:PercentSurchargeTotalFnFixed;
        FN_TAX_CODE             : TaxCodeFn;
        FN_PRINT_SALE           : ChoosenPrintsale;
        FN_SINGLE_UOM           : SelectUOMFn;
        FN_SIGNATURE            : CustomerSignatureFn;
        FN_QUOTE           : QuoteFn;
        FN_SALES_ORDER     : SalesOrderFn;
        FN_INVOICE_LIST    : InvoiceListFn;
        FN_SMART_ORDER     : SmartOrderFn;
        FN_CALCULATOR      : CalculatorFn;
        FN_CASHDROP        : CheckForCashDrop(False);
        FN_SELECTALL       : DoSelectAll;
        FN_AFTERPAY        : AfterpayFn;

        FN_CUSTOMERDETAILS:AcceptExtraDetails;
        FN_PRINT_RCPT     : begin
            CreateReceiptLists;
            if bPOSPrintReceiptOnlyOnCompleteSale then
              begin
                if bTransComplete then
                  PrintReceipt;
              end
            else
              PrintReceipt;
          end;
        FN_REDEEMPOINTS: RedeemPoints;
        FN_VOUCHER_GROUP: VoucherFn(FnID);
      else if FnId = FN_NONE then CommonLib.MessageDlgXP_Vista('No Function Assigned',
              mtWarning, [mbOK], 0)
           else CommonLib.MessageDlgXP_Vista('Function ID: ' + IntToStr(FnID) + ' - Unknown Function',
              mtWarning, [mbOK], 0);
      end;
      if (FnId <> FN_FIXED_AMOUNT) and
        (FnId <> FN_PREPAY_ACCOUNT) and
        (FnId <> FN_CHG_PAD) and
        (FnId <> FN_MAIN_PAD) and
        (FnId <> FN_PAY_ACCOUNT) then begin
        EnteringNum(false);
      end;
    except
      on e: ENoAccess do HandleNoAccessException(e);
    end;
  end;
  // Revert back to primary keypad if required
  if not bIsLocked then
      if not bKeyPadChange then begin
        if oPOSBtnMatrix.KeypadID <> iPrimaryPad then begin
          if not AppEnv.CompanyPrefs.NoReturntoPrimaryKeypad then begin
            oPOSBtnMatrix.KeypadID := iPrimaryPad;
            oPOSBtnMatrix.LoadFromDB;
            oPOSBtnMatrix.RemoveStars;
          end;
        end;
      end else begin
        bKeyPadChange := false;
      end;
end;

Procedure TPOSScreenForm.NewLineItem;
begin
  New(LineItem);
  FillChar(LineItem^,SizeOf(LineItem^), #0);
  LineItem^.ID:=lstLineItems.Count+1;
  LineItem^.GridIndex := 0;
  LineItem^.PriceChanged := False;
end;

procedure TPOSScreenForm.CreateLineItem(const bIsDiscount: boolean; const iUnitID: integer);
begin
  // Creates line items record for posting to DB later it assumes the parts table
  // .. is filtered to the required part.
  // The line is created, some items are populated, and it is added to the lines
  // .. Tlist.
  NewLineItem;
  with LineItem^ do begin
    DiscRatio  := 0;
    UnitID     := iUnitID;
    //ProductID  := qryProduct.FieldByName('PARTSID').AsInteger;
    ProductID := PRoduct.ID;
    Linecost := Product.Averagecost;
    CanDeleteInPOS := Product.CanDeleteInPOS;
    SubProduct := ProductRec;     // even if this product rec is not valid we still need to assign it
    if ProductRec.Valid then begin   // product rec is filled from barcodefn
      //ProductID := ProductRec.ProductID;
      ProductDescription := ProductRec.SubProductDesc;
      Multiplier := ProductRec.UnitsMultiplier;
    end else begin
      //ProductDescription := qryProduct.FieldByName('PARTSDESCRIPTION').AsString;
      ProductDescription := Product.SalesDescription;
      Multiplier := getUnitMultiplier(UnitID);//1;
    end;

    ProductName := Product.ProductName;
    ProductPrintName := Product.ProductPrintName;
    LinePrice   := ProductPrice;

    if (bIsDiscount) and (lstLineItems.Count > 0) then begin
      TaxCode := appenv.CompanyPrefs.DefaultSalesTaxCode;
      TaxRate := GetTaxRate(appenv.CompanyPrefs.DefaultSalesTaxCode);
    end else begin
      TaxRate := GetTaxRate(Product.TaxCodeSales);
      TaxCode := Product.TaxCodeSales;
    end;

    IsToBeDeleted := false;
    IsChild := false;
    IsFrozen := false;
    IsAccountPayment := false;
    Area := Product.Area;
  end;
  lstLineItems.Add(LineItem);

  // tag Product record as invalid, for next time
  ProductRec.Valid := false;
end;
Function  TPOSScreenForm.PostSaleItem(
  const sDescriptions: string;
  const rPrice: currency;
  const rQuantitys: double;
  const iLaybyID: integer;
  const rLbyBal: currency;
  const rLbyAmount: currency;
  const bShow: boolean;
  const bIsTaxInc: boolean;  // price includes tax
  const bApplyDisc: boolean;
  const bIsDiscount: boolean = false;
  const bIsChild: boolean = false;
  const iUnitID: integer = 0;
  fiRefundedSalesLineID:Integer = 0): Boolean;
var
   ItemRec: pLineItemRec;
begin
  CreateLineItem(bIsDiscount, iUnitID);
  ItemRec := lstLineItems.Last;
  REsult := PostSaleItem(ItemRec,sDescriptions,rPrice, rQuantitys,iLaybyID,rLbyBal,rLbyAmount,
                bShow,bIsTaxInc,bApplyDisc,bIsDiscount,bIsChild,iUnitID, fiRefundedSalesLineID);
end;

Function  TPOSScreenForm.PostSaleItem(
  var ItemRec: pLineItemRec;
  const sDescriptions: string;
  const rPrice :double;
  const rQuantitys: double;
  const iLaybyID: integer;
  const rLbyBal: currency;
  const rLbyAmount: currency;
  const bShow: boolean;
  const bIsTaxInc: boolean;  // price includes tax
  const bApplyDisc: boolean;
  const bIsDiscount: boolean = false;
  const bIsChild: boolean = false;
  const iUnitID: integer = 0;
  const fiRefundedSalesLineID:Integer = 0):Boolean;
var
  rAmount: currency;
  rAmountNoTax: currency;
  rPriceInc: currency;
  rPriceNoTax: currency;
  rPriceGiven: double;
  sExtraSellPartDesc: string;
  iClient: integer;
  rQuantity: double;
  sDescription, sMsg: string;
  fbApplyDisc:Boolean;
  qry: TERPQuery;
  x: integer;
  ExistingRec: pLineItemRec;
begin
{line should not be processed at all when has no access to the customer list and the selected
item is serialised}
  Try

    if SelectedTaxCodeId > 0 then begin
      qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
      try
        qry.SQL.Text := 'select Rate, Name from tblTaxCodes where TaxCodeId = ' + IntToStr(SelectedTaxCodeId);
        qry.Open;
        ItemRec^.TaxCode := qry.FieldByName('Name').AsString;
        ItemRec^.TaxRate := qry.FieldByName('Rate').AsFloat;
      finally
        DbSharedObj.ReleaseObj(qry);
      end;
    end;

    fbApplyDisc := bApplyDisc;
    sDescription := sDescriptions;
    rQuantity := rQuantitys;
    rPriceGiven := rPrice;
    // First check to see that the price has been overwritten
    if (bPriceChange) and (AppointID = 0) then begin
      rPriceGiven := rPriceChange;    // note that this price must include any discounts
      if bApplyDiscToPriceChange then begin
        ItemRec^.DiscRatio := rCustDisc;
      end else begin
        ItemRec^.DiscRatio := 0;
        fbApplyDisc:= False; // as user has entered the price the discount should not be applied
      end;
    end else if fbApplyDisc then begin
      if iClientID = 0 then begin
        iClient := iCashCustID;
      end else begin
        iClient := iClientID;
      end;

      if AppointID = 0 then begin
        if ItemRec^.LinePrice <> 0 then rPricegiven := ItemRec^.LinePrice;
        if  (ItemRec^.PriceChanged) then
        else begin oDiscount.ClientPrice_Discounts(iClient,'', ItemRec^.ProductID, ItemRec^.UnitID,  tcDatautils.GetTillClassID(iTillID),
          rQuantity, Date(),
          false,
          rPriceGiven, ItemRec^.DiscRatio,
          sExtraSellPartDesc, sMsg, False , ItemRec^.MatrixRef);
          if (ItemRec^.DiscRatio = 0) and (oDiscount.DiscountType=SPEC_PRICE_DISC) then   fbApplyDisc := False;
        end;
        rPriceGiven := rPriceGiven * ItemRec^.Multiplier;
      end;

      if not Empty(sExtraSellPartDesc) then begin
        sDescription := sExtraSellPartDesc;
      end;
    end;

    if bPriceChange or bIsTaxInc then begin
      rPriceInc   := rPriceGiven;
      //rPriceNoTax := RoundCurrency(rPriceInc / (1.0 + ItemRec^.TaxRate));
      rPriceNoTax := rPriceInc / (1.0 + ItemRec^.TaxRate);
    end else begin
      rPriceNoTax := rPriceGiven;
      //rPriceInc   := RoundCurrency(rPriceNoTax + rPriceNoTax * ItemRec^.TaxRate);
      rPriceInc   := rPriceNoTax + rPriceNoTax * ItemRec^.TaxRate;
    end;
    if (bRefundMode or bLoadedRefund) then begin
      rQuantity  := -rQuantity;
    end;
    rAmount := RoundCurrency(rPriceInc * rQuantity);

    rAmountNoTax := RoundCurrency(rPriceNoTax * rQuantity);
    // Update the global run totals
    rRunTot := rRunTot + rAmount;
    rRunTotNoTax := rRunTotNoTax + rAmountNoTax;
                                 // Update Line item in list
    with ItemRec^ do begin
      Qty := rQuantity;

      if char_length(sDescription) <> 0 then begin
        ProductDescription := sDescription;
      end;

      LinePrice    := rPriceNoTax;
      LinePriceInc := rPriceInc;
      Amount       := rAmount;
      LaybyId      := iLaybyID;
      LaybyBal     := rLbyBal;
      LaybyAmount  := rLbyAmount;
      ApplyDisc    := fbApplyDisc;
      IsProduct    := bApplyDisc;  // for now, this will do but be careful!!!
      IsDiscount   := bIsDiscount;
      if not PriceChanged then PriceChanged := bPriceChange;
      qty          := rQuantity;
      if ProductName = PART_VOUCHER then begin
        VoucherNo := sVoucherNo;
        IsVoucher := (Qty > 0);
        IsRedeeming := (Qty < 0);
      end else begin
        IsVoucher := false;
        IsRedeeming := false;
      end;
      IsChild    := IsChild or bIsChild;  // make sure we don't wipe previous value
      FixedPrice := bPriceChange;
      if fiRefundedSalesLineID <> 0 then RefundedSalesLineID := fiRefundedSalesLineID;
    end;
    ReCalcRunTot(bShow);

    if AppEnv.CompanyPrefs.CombinePOSQuntities then begin
      for x := 0 to lstLineItems.count - 2 do begin
        if (ItemRec^.ProductID = pLineItemRec(lstLineItems[x])^.ProductID) and (ItemRec^.ID <> pLineItemRec(lstLineItems[x])^.ID) then begin
          ExistingRec := pLineItemRec(lstLineItems[x]);
          ExistingRec^.Qty := ExistingRec^.Qty + ItemRec^.Qty;
          ExistingRec^.Amount := ExistingRec^.Amount + ItemRec^.Amount;
          ExistingRec^.LaybyBal := ExistingRec^.LaybyBal + ItemRec^.LaybyBal;
          ExistingRec^.LaybyAmount := ExistingRec^.LaybyAmount + ItemRec^.LaybyAmount;
          ItemRec := ExistingRec;
          Dispose(lstLineItems.Items[lstLineItems.count-1]);
          lstLineItems.Delete(lstLineItems.count-1);
//          grdTrans.RowCount := grdTrans.RowCount -1;
          RebuildGrid;
          break;
        end;

      end;


    end;


    CurrentItem := nil;

    GlobalEvents.Notify(self, GEVENT_POS_AfterSaleListPriceChange, lstLineItems);

    // Write details to viewer
    if bShow then begin
      DisplayInViewer(ItemRec^.ProductDescription,  CurrencyToStrF(RoundTo1C(ItemRec^.Amount), ffCurrency));
    end;

    // Reset some globals for next one
    bRefundMode := false;
    EnteringNum(false);
    bPriceChange := false;
    bApplyDiscToPriceChange := false;
  Finally
    Result := True;
  end;
end;

procedure TPOSScreenForm.ReadPosVideoDelay;
var
  RegIni: TMemIniFile;
begin
  RegIni := TMemIniFile.Create(SystemLib.ExeDir + csCustomerDisplayFile);
  try
    RegIni.DeleteKey(csPOSVideoSection, 'Delay');
    RegIni.UpdateFile;
    PosVideoDelay := RegIni.ReadInteger(csPOSVideoSection, csPOSVideoIdent, -1);
  finally
    FreeAndNil(RegIni);
  end;
end;

procedure TPOSScreenForm.ReadWeight;
var
  fiWeight, fiTimeOut, prc:Integer;
  pItem: pLineItemRec;
  //itemIndex :Integer;
  fdWeight:Double;

begin
  if OPOSScale = nil then exit;

  fiTimeOut:= 1000;
  OPOSScale.ReadWeight(fiWeight, fiTimeOut, prc);
  if fiWeight =0 then Exit;
  fdWeight := fiWeight * Appenv.CompanyPrefs.OPOSScaleMultiplier;
  if fdWeight =0 then Exit;

  ClearInputMemo;
  if lstLineItems.Count = 0 then begin
    Exit;
  end;

  if idOk() then begin
      if pLineItemRec(lstLineItems.Last)^.IsAccountPayment then begin
        //
      end else begin
        try
          edtPOSMemo.Lines[0] :=  FloattoStr(fdWeight);
          pItem := CurrentRow;
          if not Assigned(pItem) then exit;

          if Sysutils.SameText(pItem^.ProductName , REDEEM_POINTS) then begin
            CommonLib.MessageDlgXP_Vista('You cannot Change the Quantity of Redeem Points', mtWarning, [mbOK], 0);
            Exit;
          End;

          if (pItem^.Qty < 0) then begin
              bRefundMode := true;  // set global if in refund mode
          end;

          pItem^.Qty := pItem^.Multiplier*fdWeight;
          rQuantOfProd:=pItem^.Qty ;


          PostSaleItem(pItem ,PItem^.ProductDescription ,PItem^.LinePriceinc, rQuantOfProd , 0, 0.0, 0.0, False, False , True , False, False, PItem^.UnitID);
          RebuildGrid;
        except
          on EConvertError do begin
            CommonLib.MessageDlgXP_Vista('Not a valid Quatity', mtWarning, [mbOK], 0);
            rQuantOfProd := 1.0;
          end;
        end;
      end;
      EnteringNum(false);  // Let the world know
    end;
  rQuantOfProd := 1.0;


end;

procedure TPOSScreenForm.RebuildGrid;
var
  i: integer;
  firow, ficol :Integer;
begin
  //Clear Customer Display
  fiRow :=  grdTrans.row;
  ficol := grdTrans.col;
  try
    if Assigned(CustomerDisplay) then begin
      CustomerDisplay.ClearDisplay;
      SetPOSScreenActive;
    end;
    //DisplayOnPole;

    grdTrans.RemoveRows(1, grdTrans.RowCount - 2);
    for i := 0 to self.lstLineItems.Count - 1 do begin
      if pLineItemRec(lstLineItems.Items[i])^.GridIndex > 0 then
        pLineItemRec(lstLineItems.Items[i])^.GridIndex := 0;
      DisplayLineItem(lstLineItems.Items[i]);
    end;
  finally
    try
      if fiRow >= grdTrans.RowCount then
        fiRow := grdTrans.RowCount -1;
      grdTrans.row:= fiRow;
      grdTrans.col:= ficol;
      Showdetails;
    except
      // kill the exceptionif the row is not valid after refresh
    end;
  end;
end;

//function TPOSScreenForm.IsProduct(const pItem: pLineItemRec): boolean;
//begin
//  if pItem^.IsProduct then begin
//    Result := true;
//  end else begin
//    Result := false;
//  end;
//end;

procedure TPOSScreenForm.DisplayLineItem(const pItemRec: pLineItemRec);
var
  lProfit : double;
  lCost : currency;
begin
  if pItemRec^.GridIndex <> 0 then exit;

  if (pItemRec^.Ischild)  and (pItemRec^.IsrelatedHidden ) then begin
    pItemRec^.GridIndex := -1;
    exit;;// this should not be shown
  end;


  if not pItemRec^.IsFrozen then begin
    grdTrans.AddBitmap (COL_BTN, grdTrans.RowCount - 1, DelBitMap,True, haLeft, vaCenter);
  end;
  grdTrans.Cells[COL_QTY, grdTrans.RowCount - 1] := FloatToStrF(pItemRec^.Qty, ffGeneral , 5, 2);

  //grdTrans.Cells[COL_NAME, grdTrans.RowCount - 1] := pItemRec^.ProductName;
  grdTrans.Cells[COL_NAME, grdTrans.RowCount - 1] := pItemRec^.ProductPrintName;

  if pItemRec^.DiscountDetails =  '' then
    grdTrans.Cells[COL_DESC, grdTrans.RowCount - 1] := pItemRec^.ProductDescription
  else
    grdTrans.Cells[COL_DESC, grdTrans.RowCount - 1] := pItemRec^.ProductDescription + ' ' + pItemRec^.DiscountDetails;

  grdTrans.Cells[COL_PRICE, grdTrans.RowCount - 1] := CurrToStrRJ(pItemRec^.LinePriceInc, 13);

//  grdTrans.Cells[COL_UOMPRICE, grdTrans.RowCount - 1] := CurrToStrRJ(pItemRec^.LinePriceInc * pItemRec^.Multiplier, 13);

  grdTrans.Cells[COL_AMOUNT, grdTrans.RowCount - 1] := CurrToStrRJ(pItemRec^.Amount, 13);

  // The code almost as it is in TSalesLineBase, but with changes - say, LineCostInc is 0 here
  lCost := pItemRec^.LineCostInc;
  if lCost = 0 then
    lCost := Round(GetAmountInc(pItemRec^.LineCost, pItemRec^.TaxRate), tcConst.GeneralRoundPlaces);

  lProfit := CommonLib.Round((pItemRec^.LinePriceInc - lCost) * pItemRec^.Qty, CurrencyRoundPlaces);
  grdTrans.Cells[COL_PROFITDOLLAR, grdTrans.RowCount - 1] := '$' + FloatToStrF(lProfit, ffGeneral, 7, 2);
//    CommonLib.Round((pItemRec^.LinePrice - pItemRec^.LineCost) * pItemRec^.Qty, CurrencyRoundPlaces);

  if pItemRec^.LinePriceInc = 0 then
    lProfit := -100
  else if lCost = 0 then
    lProfit := 100
  else
    lProfit := Round(DivZer((pItemRec^.LinePriceInc - lCost), lCost) * 100, CurrencyRoundPlaces);
  grdTrans.Cells[COL_PROFITPERCENT, grdTrans.RowCount - 1] := FloatToStrF(lProfit, ffGeneral, 7, 2) + '%';

  pItemRec^.GridIndex := grdTrans.RowCount - 1;

  { Move to next row and clear it }
  grdTrans.RowCount := grdTrans.RowCount + 1;
  grdTrans.Row:= grdTrans.RowCount -2;
  RefreshCurrentlineitem(pItemRec);
end;

Procedure TPOSScreenForm.RefreshCurrentlineitem(const pItemRec:pLineItemRec);
begin
  grdTrans.ClearRows(grdTrans.RowCount - 1, 1);
  grdTrans.ScrollInView(COL_QTY, grdTrans.RowCount - 1);

  ReCalcRunTot;
  DisplayRunTot(rRunTot);

  if bUpdateDate = true then begin
    UpdateDate;
    bUpdateDate := false;
  end;

  // unselect any cell for customer sales list function
  grdTrans.Row := 0;
  grdTrans.Col := 0;

  if Assigned(CustomerDisplay) then
  begin
    if not(pItemRec^.IsrelatedHidden) then
      CustomerDisplay.AddItemToDisplay(pItemRec^.ID, pItemRec^.ProductID, pItemRec^.Qty, pItemRec^.ProductDescription, pItemRec^.Amount, pItemRec);
    SetPOSScreenActive;
  end;
  //DisplayOnPole(pItemRec^.ProductDescription + ' ' + pItemRec^.DiscountDetails , CurrToStrRJ(pItemRec^.Amount, 13));
  DisplayItemoonPole(pItemRec);
  if AppEnv.CompanyPrefs.POSShowProductPic then LoadImage(pItemRec^.ProductID);
  ShowDetails;
end;

procedure TPOSScreenForm.ClearImage;
begin
  Image1.Picture:= nil;
  Image1.Visible := False;
  pnlImage1.Visible := False;
  edtPOSMemo.Left := 17;
  edtPOSMemo.Width := 985;
end;

procedure TPOSScreenForm.LoadImage(ProductID: integer);
var
  qry: TERPQuery;
begin
  //qry  :=tcdatautils.Datautilsdataset( 'SELECT PartID,partPic,Pictype FROM tblpartspics WHERE Ifnull(IsDefault,"F") = "T" AND PartID = ' + IntToStr(ProductID));
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
        if Qry.active then Qry.Close;
        Qry.SQL.Text :='SELECT PartID,partPic,Pictype FROM tblpartspics WHERE Ifnull(IsDefault,"F") = "T" AND PartID = ' + IntToStr(ProductID);
        Qry.open;
        if Qry.RecordCount >0 then begin
          ImagesLib.RefreshDsImage(Qry, 'partPic', 'Pictype' , Image1,  pnlImage1 , nil);
            Image1.BringToFront;
            Image1.Visible := True;
            pnlImage1.Visible := True;
            edtPOSMemo.Left := 201;
            edtPOSMemo.Width := 800;
          end else begin
            Image1.Picture:= nil;
            Image1.Visible := False;
            pnlImage1.Visible := False;
            edtPOSMemo.Left := 17;
            edtPOSMemo.Width := 985;
        end;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;

procedure TPOSScreenForm.pnlDisplayMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
//  StopPlayer;
end;

procedure TPOSScreenForm.pnlFnKeyBtnsClick(Sender: TObject);
var
  bAllowed: boolean;
  iFnIndex: integer;
  fi1:Integer;
begin
  if bIsLocked then begin
    fi1 :=iLockedRow-1;
    if fi1 <1 then fi1 := 2;
    oPOSBtnMatrix.SelectButton(fi1, iLockedCol);
    pnlPOSBtnsClick(pnlPOSBtns);
    Exit;
  end;

  if not PaymethodPressedInProgress then begin
    PaymethodPressedInProgress := true;
    bAllowed := true;
    if bIsLocked then bAllowed := false;
    // Get Select button
    oFnBtnMatrix.SelectButton(Sender);
    if (oFnBtnMatrix.fiSelRow = 0) and (oFnBtnMatrix.fiSelCol = 0) then begin
      PaymethodPressedInProgress := false;
      Exit;
    end;
    // Obtain function for this button by converting row & column into an index
    iFnIndex := (oFnBtnMatrix.fiSelRow - 1) * MAX_COL + oFnBtnMatrix.fiSelCol;
    if bAllowed then begin
      // Remove last transaction details
      if (bTransComplete = true) and (iFnIndex <> 4) then begin //4 is print receipt
        ClearAll;
        bTransComplete := false;
      end;
      try
        case iFnIndex of
          1: SalesmanFn;
          2: ProdListFn;
          3: CustListFn;
          4:
            begin
              CreateReceiptLists;  //Ianos
              if bPOSPrintReceiptOnlyOnCompleteSale then begin
                if bTransComplete then
                  PrintReceipt;
              end else
                PrintReceipt;
            end;
          5: QuantityFn;
          6: NoSaleFn;
          7: RefundFn;
          8: CancelFn;
          9: ChequeFn;
          10: CreditCardFn;
          11: EFTFn;
          12: CashFn;
          else CommonLib.MessageDlgXP_Vista('Error with Button Selection', mtWarning, [mbOK], 0);
        end;
        GlobalEvents.Notify(self, GEVENT_POS_CheckForListRedisplay, lstLineItems);
      except
        on e: ENoAccess do HandleNoAccessException(e);
      end;
    end;
    PaymethodPressedInProgress := false;
  end;
end;

procedure TPOSScreenForm.AddDigitToViewer(const cDigit: char);
  { Adds the numeric digit to the views screen }
var
  sTemp: string;
begin
  if not EnteringNum then begin
    EnteringNum(True);
    ClearInputMemo;
  end;

  if cDigit = '.' then begin
    if FastFuncs.PosEx('.', edtPOSMemo.Lines[0]) <> 0 then Exit
    else edtPOSMemo.Lines[0] := edtPOSMemo.Lines[0] + '.';
  end else if cDigit = CHR_BS then begin
    sTemp := edtPOSMemo.Lines[0];
    Setlength(sTemp, char_length(sTemp) - 1);
    edtPOSMemo.Lines[0] := sTemp;
  end else edtPOSMemo.Lines[0] := edtPOSMemo.Lines[0] + cDigit;
  if char_length(edtPOSMemo.Lines[0]) = 0 then begin
    EnteringNum(false);
    ClearInputMemo;
  end;
end;

procedure TPOSScreenForm.UpdateDate;
begin
  lblDate.Caption := DateToStr(Date);
  lblTime.Caption := TimeToStr(Time);
  DateTimeOfSale:= now;
end;

procedure TPOSScreenForm.DoHotKey(const chHotKey: char);
begin
  if oPOSBtnMatrix.SelectButton(chHotKey) then PerformFunction(oPOSBtnMatrix.Selected.Func.FnID);
end;

procedure TPOSScreenForm.BackupUnselected(ALayBy : boolean);
var
  pItem: pLineItemRec;
  i: integer;
begin
  isSaleSplit := false;
  with SavedContext do
  begin
    fbChqNoEntered := bChqNoEntered;
    if ALayBy then
      fbPrevTransWasLayby := ALayBy
    else
      fbPrevTransWasLayby := bPrevTransWasLayby;
    fiQuoteID    := iQuoteID;
    fiHireID    := iHireID;
    fiAppointID  := iAppointID;
    fedtPOSMemoText := edtPOSMemo.Text;
    frQuantOfProd := rQuantOfProd;
    flblMemoTextCaption := lblMemoText.Caption;
    fsRef        := sRef;
    fiClientID   := iClientID;
    fbMustEnterIdNow := bMustEnterIdNow;
    flblSalesPersonCaption := lblSalesPerson.Caption;
    fiEmployeeID := iEmployeeID;
    flstLineItems.Clear;
  end;

  for i := lstLineItems.Count - 1 downto 0 do
  begin
    pItem := lstLineItems[i];
    if not pItem.Selected then
    begin
      SavedContext.flstLineItems.Add(pItem);
      lstLineItems.Delete(lstLineItems.IndexOf(pItem));
      pItem.ID:=SavedContext.flstLineItems.Count+1;
      isSaleSplit := true;
    end;
  end;
end;

procedure TPOSScreenForm.BarcodeFn;
begin
  if EnteringNum = true then begin
    if idOk() then begin
      // Assume it's a Barcode
      if not OPOSScanning then
        sBarcode := Trim(edtPOSMemo.Lines[0]);
      fbenteringnum := False;
      ProcessBarCode;
    end;
  end;
end;

procedure TPOSScreenForm.ProcessBarCode;
var
  bOk: boolean;
  iBarcode: int64;
  mrResult: integer;
  sDescription: string;
  rPrice: currency;
  rPriceInc: currency;
  MessageStr, specialProduct: string;
  specialAmountInt: integer;
  specialAmount: currency;
  isSpecial: boolean;
begin
  bOk := false;
  try
    SpecialAmount := 0.0;
    bOk := true;
    If not bUseAlphaNumericBarcodes then Begin
      // Check that it is valid
      try
        iBarcode := StrToInt64(sBarCode);
        if iBarcode = 0 then;
      except
        on EConvertError do begin
          CommonLib.MessageDlgXP_Vista('Not a valid Barcode: ' + edtPOSMemo.Lines[0],
            mtWarning, [mbOK], 0);
          bOk := false;
        end;
      end;
    end;

    // Match in DB

    if bOk = true then begin

      ProductRec := oPrice.GetProductIDFromBarcode(sBarCode, tcDatautils.GetTillClassID(iTillID), iClientID);

      // Special Barcode
      //isSpecial := not ProductRec.Valid and (AppEnv.CompanyPrefs.SpecialBarcodeLen = char_length(sBarcode));
      isSpecial := not ProductRec.Valid and (AppEnv.CompanyPrefs.SpecialBarcodeProductLen>0) and (char_length(sBarcode)> AppEnv.CompanyPrefs.SpecialBarcodeProductLen);
      if isSpecial   then begin
        specialProduct := Copy(sBarcode, AppEnv.CompanyPrefs.SpecialBarcodeProductPos, AppEnv.CompanyPrefs.SpecialBarcodeProductLen);
        specialAmount := 0.0;
        if AppEnv.CompanyPrefs.SpecialBarcodeAmountPos > 0 then begin
          specialAmountInt := StrToIntDef(Copy(sBarcode, AppEnv.CompanyPrefs.SpecialBarcodeAmountPos,AppEnv.CompanyPrefs.SpecialBarcodeAmountLen), 0);
          specialAmount := SpecialAmountInt /  Appenv.RegionalOptions.DecimalValue ;
        end;
        ProductRec := oPrice.GetProductIDFromBarcode(specialProduct, tcDatautils.GetTillClassID(iTillID), iClientID);
      end;

      if ProductRec.ProductID = 0 then begin
          mrResult := CommonLib.MessageDlgXP_Vista('No product has the Barcode of ' + edtPOSMemo.Lines[0] +NL+NL+
            iif(isSpecial, 'Special barcode Format is ' +NL+ Appenv.CompanyPrefs.Specialbarcodeformat +NL+NL, '') +
            'Do you wish to assign this Barcode to a Product?', mtWarning, [mbYes, mbNo], 0);
          if mrResult = mrYes then begin
            iProdOriginator := FN_BARCODE;
            ProdListFn;
          end;
          bOk := false;
          exit;
      end;

      Product.Load(ProductRec.ProductID);
      if Product.count >0 then begin
        if Product.Active = False then begin
          //CommonLib.MessageDlgXP_Vista('Product (' +Product.Productname +') Selected With Barcode (' + sBarCode +') is Inactive.' , mtWarning, [mbok], 0);
          CommonLib.MessageDlgXP_Vista('Product (' +Product.ProductPrintName +') Selected With Barcode (' + sBarCode +') is Inactive.' , mtWarning, [mbok], 0);
          bOk := false;
        end else begin
          rPrice := ProductPrice;
          sDescription := Product.SalesDescription;

          if not isSpecial then begin
              if not PostSaleItem(sDescription, rPrice, rQuantOfProd, 0, 0.0, 0.0,
                true, false, true, false, false, ProductRec.UnitsID)then Exit;
          end else begin
            rPriceInc := rPrice + rPrice * GetTaxRate(Product.TaxCodeSales);
            if (SpecialAmount = 0.0) then SpecialAmount := rPriceInc;    // shouldn't happen ---> make qty 1
            rQuantOfProd := DecimalRoundDbl(SpecialAmount / rPriceInc, 3);
//            if not PostSaleItem(sDescription, rPriceInc, rQuantOfProd, 0, 0.0, 0.0,
//              true, true, false) then Exit;
            if not PostSaleItem(sDescription, rPrice, rQuantOfProd, 0, 0.0, 0.0,
              true, true, false, false, false, ProductRec.UnitsID)then Exit;
          end;
          DisplayLineItem(lstLineItems.Last);
          PostAndDisplayAnyProductDisc;
          grdTrans.Row:= grdTrans.RowCount -2;
          ReadWeight;
          //LoadRelatedParts(ProductRec.ProductID, rQuantOfProd);
          LoadRelatedParts(ProductRec.ProductID, rQuantOfProd *pLineItemRec(lstLineItems.Last)^.Multiplier, pLineItemRec(lstLineItems.Last)^.Id , False);
//            RebuildGrid; // added For A Display bug on first record, removed to fix flicker in customer display
          // Parts Popup Message
          if GetProductReminderPopup(ProductRec.ProductID, MessageStr) then begin
            CommonLib.MessageDlgXP_Vista(MessageStr, mtInformation, [mbOK], 0);
          end;
        end;
      end else begin
          mrResult := CommonLib.MessageDlgXP_Vista('No product has the Barcode of ' + edtPOSMemo.Lines[0] +
            #10#13'Do you wish to assign this Barcode to a Product?', mtWarning, [mbYes, mbNo], 0);
          if mrResult = mrYes then begin
            iProdOriginator := FN_BARCODE;
            ProdListFn;
          end;
          bOk := false;
      end;
      if bOk then EnteringNum(false);
    end;
  finally
    if bOk = false then begin
      ClearInputMemo;
      EnteringNum(false);
    end;
  end;
end;

procedure TPOSScreenForm.ProdCodeFn;
var
  bOk: boolean;
  //MessageStr,
  sProdCode: string;
  iProductID: integer;
begin
  if idOk() then begin
    bOk := true;
    if EnteringNum = true then begin
      // Assume it's a Product Code
      sProdCode := edtPOSMemo.Lines[0];

      // find in DB
      if bOk = true then begin
        iProductID := GetPartIDFromPartNubmer(sProdCode);
          Product.Load(iProductID);

          if Product.count > 0 then begin
            edtPartID.text := IntToStr(Product.ID);
          end else begin
            CommonLib.MessageDlgXP_Vista('No product has the Product Code of ' + edtPOSMemo.Lines[0],
              mtWarning, [mbOK], 0);
            bOk := false;
          end;
        if bOk then EnteringNum(false);
      end;
    end;
    if bOk = false then ClearInputMemo;
  end;
end;
Function TPOSScreenForm.ShippedinCurSale(prodID:Integer):Double;
var
  i:Integer;
begin
  REsult:= 0;
   for i := 0 to self.lstLineItems.Count - 1 do
    if pLineItemRec(lstLineItems.Items[i])^.ProductID = prodID then
      result := result +pLineItemRec(lstLineItems.Items[i])^.qty;
end;
Function TPOSScreenForm.ISoktoShip(var Qty:Double;pItem: pLineItemRec):Boolean;
var
  fdAvailQty:Double;
begin
  result:= True;

  if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAllowInvoiceStockToNegative') =1 then
    Exit;

  if appenv.CompanyPrefs.NegativeStockcheckinInvoicebasedon = 'A' then
       fdAvailQty := TProductClass.AvailableQty(pItem^.ProductID,tcDatautils.GetTillClassID(iTillID))
  else fdAvailQty := TProductClass.ProductInStockQty(pItem^.ProductID,tcDatautils.GetTillClassID(iTillID));

  fdAvailQty := fdAvailQty - ShippedinCurSale(pItem^.ProductID);
  fdAvailQty := fdAvailQty + pItem^.Qty;

  if fdAvailQty < Qty then begin

    Result:= False;
    //MessageDlgXP_Vista('The Stock on Hand for product '+pItem^.ProductName +' is ' +floattoStr(fdAvailQty)+'.'+
    MessageDlgXP_Vista('The Stock on Hand for product '+pItem^.ProductPrintName +' is ' +floattoStr(fdAvailQty)+'.'+
                          chr(13)+'Shipping ' +floattoStr(Qty) +' will cause a negative stock in your Product List.' +
                          chr(13) +chr(13) +'No rights to create negative stock transaction' , mtWarning, [mbOK], 0);
    if fdAvailQty <0 then Qty :=0 else Qty :=fdAvailQty;

    PostSaleItem(pItem,pItem^.ProductDescription,pItem^.linePrice, 0,pItem^.LaybyID,pItem^.LaybyBal,pItem^.LaybyAmount,
                True,True,False,False,pItem^.IsChild,pItem^.UnitID, pItem^.RefundedSalesLineID);
  end;
end;

procedure TPOSScreenForm.QuantityFn;
var
  pItem: pLineItemRec;
  //itemIndex :Integer;
begin
  if lstLineItems.Count = 0 then begin
    Exit;
  end;

  if idOk() then begin
    if EnteringNum = true then begin
      if pLineItemRec(lstLineItems.Last)^.IsAccountPayment then begin
        CommonLib.MessageDlgXP_Vista('You cannot Change the Quantity of an Account Payment', mtWarning, [mbOK], 0);
      end else begin
        // Convert to float
        try
          rQuantOfProd := StrToFloat(edtPOSMemo.Lines[0]);

          pItem := CurrentRow;
          if not Assigned(pItem) then exit;

          if rQuantOfProd >0 then
            ISoktoShip(rQuantOfProd ,pItem);




          if not Assigned(pItem) then
            exit;

          if Sysutils.SameText(pItem^.ProductName , REDEEM_POINTS) then begin
            CommonLib.MessageDlgXP_Vista('You cannot Change the Quantity of Redeem Points', mtWarning, [mbOK], 0);
            Exit;
          End;

          if (pItem^.Qty < 0) then begin
              bRefundMode := true;  // set global if in refund mode
          end;

          //if bRefundMode then rQuantOfProd := 0-rQuantOfProd;

          pItem^.Qty := rQuantOfProd;


          PostSaleItem(pItem ,PItem^.ProductDescription ,PItem^.LinePriceinc, rQuantOfProd , 0, 0.0, 0.0, False, False , True , False, False, PItem^.UnitID);
          updateRelatedProductsQty(PItem^.ID, PItem^.Qty*PItem^.Multiplier);
          RebuildGrid;
        except
          on EConvertError do begin
            CommonLib.MessageDlgXP_Vista('Not a valid Quatity', mtWarning, [mbOK], 0);
            rQuantOfProd := 1.0;
          end;
        end;
      end;
      EnteringNum(false);  // Let the world know
    end;
  end;
  rQuantOfProd := 1.0;
end;

procedure TPOSScreenForm.QuoteFn;
begin
  if idOk() then begin
    if not bIsSplitTab then begin
      if IsLineItems then begin
        if IsTotalDiscOK() then begin
          if (char_length(sClient) = 0) or (sClient = CLIENT_CASH) then begin
            iCustOriginator := FN_QUOTE; // used in edtClientIDChange to identify
            ShowCustList; // get the client name
            { The processing of this transaction is completed in the edtClientIDChange as
              this OnChange event marks the return from the customer list.
              edtClientIDChange will recognize that it needs to initiate
              'FinishQuote'  from the value of iCustOriginator }
          end else begin
            // We know client name so continue with process
            FinishQuote;
          end;
        end;
      end;
    end else begin
      CommonLib.MessageDlgXP_Vista('You cannot Quote a Split directly, Please Assign to Customer''s Tab.', mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TPOSScreenForm.ChequeNoFn;
var
  bOk: boolean;
begin
    sREf := '';
  if idOk() then begin
    if EnteringNum = true then begin
      bOk := true;

      // Get Cheque No
      if bOK then begin
        sRef := edtPOSMemo.Lines[0];
        //DisplayInViewer('Cheque No.: ' + sRef);
      end;
      bChqNoEntered := true;
      EnteringNum(false);  // Let the world know
    end;
    GetchequeDetails;
    if sRef <> '' then
        DisplayInViewer('Cheque No.: ' + sRef);
  end;

end;

procedure TPOSScreenForm.DollarDiscFn;
var
  bOk: boolean;
  rDiscount: currency;
begin
  if (idOk()) and (IsAccessAllowed('FnDolDisc')) and (lstLineItems.count > 0 ) then begin
    if EnteringNum = true then begin
      bOk := true;

      // Convert to float
      try
        rDiscount := StrToCurr(edtPOSMemo.Lines[0]);
      except
        on EConvertError do begin
          bOk := false;
          rDiscount := 0.0;
        end;
      end;

      if not bOK then begin
        CommonLib.MessageDlgXP_Vista('Not a valid Amount', mtWarning, [mbOK], 0);
      end else begin
        Applydiscount(rDiscount);
      end;
    end;
  end else if lstLineItems.count = 0  then
    CommonLib.MessageDlgXP_Vista('Total amount is 0. Discount cannot be applied' , mtInformation , [mbok] , 0);
end;

procedure TPOSScreenForm.PercentDiscItemFn;
var
  bOk: boolean;
  rPercent: double;
begin
  if idOk() and IsAccessAllowed('FnPcentDiscItm') then begin
    if EnteringNum = true then begin
      bOk := true;

      // Convert to float
      try
        rPercent := StrToCurr(edtPOSMemo.Lines[0]);
      except
        on EConvertError do begin
          bOk := false;
          rPercent := 0.0;
        end;
      end;

      if not bOK then begin
        CommonLib.MessageDlgXP_Vista('Not a valid Amount', mtWarning, [mbOK], 0);
        // Check that discount entered is allowed
      end else begin
        ApplyPercentDiscountOnItem(rPercent);
      end;
    end;
  end;
end;

procedure TPOSScreenForm.PercentDiscTotalFn;
var
  bOk: boolean;
  rPercent: double;
begin
  rPercent := 0.0;
  if idOk() and IsAccessAllowed('FnPcentDiscTot') then begin
    if EnteringNum = true then begin
      bOk := true;

      // Convert to float
      try
        rPercent := StrToCurr(edtPOSMemo.Lines[0]);
      except
        on EConvertError do begin
          bOk := false;
        end;
      end;

      if not bOK then begin
        CommonLib.MessageDlgXP_Vista('Not a valid Amount', mtWarning, [mbOK], 0);
        // Check that discount entered is allowed
      end else begin
          ApplyPercentDiscountonTotal(rPercent);
      end;

    end;
  end;
end;

procedure TPOSScreenForm.PercentSurchargeItemFn;
var
  bOk: boolean;
  rPercent: double;
begin
  if idOk() and IsAccessAllowed('FnPcentSurchItm') then begin
    if EnteringNum = true then begin
      bOk := true;

      // Convert to float
      try
        rPercent := StrToCurr(edtPOSMemo.Lines[0]);
      except
        on EConvertError do begin
          CommonLib.MessageDlgXP_Vista('Not a valid Amount', mtWarning, [mbOK], 0);
          bOk := false;
          rPercent := 0.0;
        end;
      end;
      if not bOk then begin
        CommonLib.MessageDlgXP_Vista('Not a valid Amount', mtWarning, [mbOK], 0);
      end else begin
        ApplySurchargeOnItem(rPercent);
      end;
    end;
  end;
end;

procedure TPOSScreenForm.PercentSurchargeTotalFn;
var
  bOk: boolean;
  rPercent: double;
begin
  if idOk() and IsAccessAllowed('FnPcentSurchTot') then begin
    if EnteringNum = true then begin
      bOk := true;

      // Convert to float
      try
        rPercent := StrToCurr(edtPOSMemo.Lines[0]);
      except
        on EConvertError do begin
          CommonLib.MessageDlgXP_Vista('Not a valid Amount', mtWarning, [mbOK], 0);
          bOk := false;
          rPercent := 0.0;
        end;
      end;

     if not bOk then begin
        CommonLib.MessageDlgXP_Vista('Not a valid Amount', mtWarning, [mbOK], 0);
      end else begin
        ApplySurchargeOnTotal(rPercent);
      end;

    end;
  end;
end;

procedure TPOSScreenForm.DollarSurchargeFn;
var
  bOk: boolean;
  rSurcharge: currency;
begin
  if (idOk()) and (IsAccessAllowed('FnDolSurch')) and  (lstLineItems.count > 0 ) then begin
    if EnteringNum = true then begin
      bOk := true;

      // Convert to float
      try
        rSurcharge := StrToCurr(edtPOSMemo.Lines[0]);
      except
        on EConvertError do begin
          CommonLib.MessageDlgXP_Vista('Not a valid Amount', mtWarning, [mbOK], 0);
          bOk := false;
          rSurcharge := 0.0;
        end;
      end;

      // Now post surcharge
      if not bOK then begin
      end else begin
        ApplySurcharge(rSurcharge);
      end;

    end;
  end else if lstLineItems.count = 0  then
    CommonLib.MessageDlgXP_Vista('Total amount is 0. Surcharge cannot be applied' , mtInformation , [mbok] , 0);
end;

procedure TPOSScreenForm.CancelFn;
var
  CustomDialog: TfrmPOSDialog;
begin
  if (IsAnyAccountPayments()) then begin
    CommonLib.MessageDlgXP_Vista('You Cannot Cancel this Sale!' + #13 + #10 + 'A Customer Account Payment has been made.', mtWarning, [mbOK], 0);
  end else begin
    CustomDialog := TfrmPOSDialog.Create(nil);
    try
      CustomDialog.Position := poScreenCenter;
      if CustomDialog.ShowModal = mrYes then begin
         if bPrintReceiptCount>0 then
            Printreceipt(True);
        ClearAll;
        CleanUp;
        RollbackTransaction;
        BeginTransaction;
        if Assigned(CustomerDisplay) then begin
          CustomerDisplay.ClearDisplay;
          SetPOSScreenActive;
        end;
        DisplayWelcomeOnPole;
        ClearImage;
        PlayCancelsound;
      end;
    finally
      FreeandNil(CustomDialog);
    end;
  end;
end;

function  TPOSScreenForm.CancelOnError:Boolean;
begin
  Result := False;
  if (IsAnyAccountPayments()) then begin
  end else begin
      try
        ClearAll;
        CleanUp;
        RollbackTransaction;
        DisplayWelcomeOnPole;
        ClearImage;
      except
          // kill exception if any as its already called on erorr
      end;
        Result := true;
  end;
end;
function TPOSScreenForm.canConnect:Boolean;
begin
  //can connect is true if can read from the db
  Result := False;
  try
    With TempMyQuery do try
      SQL.add('Select SetupID from tblcompanyinformation where Setupid = ' + IntToStr(appenv.CompanyInfo.ID));
      open;
      Result := true;
    finally
      if active then close;
      Free;
    end;
  Except
    //kill the exception
  end;
end;

procedure TPOSScreenForm.ClearFn;
begin
  // may have to do a bit more than this at some stage
  ClearInputMemo;
  EnteringNum(false);
end;

procedure TPOSScreenForm.NoSaleFn;
begin
  if IsAccessAllowed('FnNoSale') then begin
    CancelFn;
    OpenCashDrawer;
  end;
end;

procedure TPOSScreenForm.DisplayRunTot(const rTotal: currency);
{ Displays the running total provided the individual grid values are valid and
  non-zero ie provided everything looks ok }
var
  i: integer;
  bOk: boolean;
  rCheck: currency;
  sCheck: string;
begin
  with grdTrans do begin
    bOk := true;

    // For each amount in column, Check validity
    for i := 1 to grdTrans.RowCount - 2 do begin

      sCheck := grdTrans.Cells[COL_AMOUNT, i];  // get amount
      StripCurrStr(sCheck);

      // use StrToCurr to check validity
      rCheck := 0.0;
      if rCheck = 0.0 then; //Stop Hint
      try
        rCheck := StrToCurr(sCheck);
        if rCheck = 0.0 then; //Stop Hint
      except
        on EConvertError do begin
          bOk := false;
        end;
      end;
    end;
  end;

  // Display total (or error)
  if bOk = true then begin
    lblRunTot.Caption := CurrencyToStrF(rRunTot, ffCurrency);
    TotalinCustomerdisplay(rRunTot);
  end else begin
    lblRunTot.Caption := '** Error **';
    TotalinCustomerdisplay(0);
  end;


  // Now Display discount
    lblTotCustDisc.Caption := CurrencyToStrF(0-rTotCustDisc, ffCurrency);
    Label4.visible := rTotCustDisc <> 0;
end;

procedure TPOSScreenForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if bTransOnHold then begin
    CommonLib.MessageDlgXP_Vista('Transaction on hold'#13'You cannot exit',
      mtWarning, [mbOK], 0);
    CanClose := false;
  end else if (bTransComplete = true) or (grdTrans.RowCount <= 2) then begin
    CanClose := true;
  end else begin
    CommonLib.MessageDlgXP_Vista('POS Transaction not complete'#13'You cannot exit',
      mtWarning, [mbOK], 0);
    CanClose := false;
  end;
  if CrashOut then
    CanClose:= true;
end;


procedure TPOSScreenForm.RefundFn;
var
  sGblRef: string;
begin
  if idOk() and IsAccessAllowed('FnRefund') then begin
        if AppEnv.CompanyPrefs.POSRestrictRefund =False then begin
          // get here if enforecement prefrence not enabled - it will just negate the next sale line
          bRefundMode := true;
          Exit;
        end;

        // I think this flag should be intialised to true here too to negate the Qty
        // as it is a refund record.
        bRefundMode := true;
        // get here if we are enforcing Refund verification - ie must enter receipt number

        if IsLineItems() then begin
          CommonLib.MessageDlgXP_Vista('You must first Complete the Current Sale', mtWarning, [mbOK], 0);
          Exit;
        end;


        MemoInput('Enter Receipt Number:', sGblRef, false);
        if Empty(sGblRef) then begin
          bRefundMode:= false;
          Exit;
        end;

        if (char_length(sGblRef) <= 3) then begin
          CommonLib.MessageDlgXP_Vista('You must enter a valid Receipt Number (eg DEF1057)', mtWarning, [mbOK], 0);
          Exit;
        end;

        if not LoadSalesCustomer(sGblRef)  then exit;// loads the client of the selected pos record
        if not LoadRefund(sGblRef) then begin
            bRefundMode:= false;
            CommonLib.MessageDlgXP_Vista('Cannot locate this Sale', mtWarning, [mbOK], 0);
            Exit;
        end;

        DisplayInViewer('Refund Receipt:   ' + sGblRef, '');

  end;
end;
function TPOSScreenForm.indexof(pItem:pLineItemRec):Integer;
var
    i:Integer;
begin
    Result :=-1;
   for i := 0 to self.lstLineItems.Count - 1 do begin
    if pLineItemRec(lstLineItems.Items[i])^.ID = pItem^.iD then begin
      REsult := i;
      Exit;
    end;
   end;
end;
procedure TPOSScreenForm.RemoveLine(const iRow: integer);
  // deletes the sale line from the grid and line items list,
  // ..note that iRow is the grid row
var
  pItem: pLineItemRec;
  j:Integer;
begin
  pItem := ItemForGridIndex(iRow); //lstLineItems[iRow - 1];
  if pItem = nil then exit;

  if pItem^.LaybyID <> 0 then begin
    RemoveLaybyLines(pItem^.LaybyID);
  end else begin
    if Sysutils.SameText(pItem^.ProductName , REDEEM_POINTS) then begin
      for j := 0 to lstRedeemPoints.Count - 1 do Dispose(lstRedeemPoints.Items[j]);
        lstRedeemPoints.Clear;
    end;
    RemoveRelatedItems(pItem^.ID);
    //grdTrans.RemoveRows(iRow, 1);
    lstLineItems.Delete(indexof(pItem));
    if iRow > MAX_ROWS then begin
      grdTrans.ScrollInView(COL_QTY, iRow - 1);
    end else begin
      grdTrans.ScrollInView(COL_QTY, 0);
    end;
  end;
  ClearImage;
//  if grdTrans.SelectedRow[0] > lstLineItems.Count then begin
//    grdTrans.SelectRows(grdTrans.SelectedRow[0] -1, 1);
//  end;
end;

procedure TPOSScreenForm.RemoveRelatedItems(const ItemId: integer);
  // removes all layby payments of id iLaybyId
var
  pItem: pLineItemRec;
  i: integer;
begin
   for i := lstLineItems.Count - 1 downto 0 do begin
    pItem := lstLineItems[i];
    if pItem^.RelatedParentID = ItemId then begin
//      RemoveRelatedItems(pItem^.ID);
      lblMemoText.Caption := '';
      lstLineItems.Delete(i);
    end;
  end;
end;


procedure TPOSScreenForm.RemoveLaybyLines(const iLaybyID: integer);
  // removes all layby payments of id iLaybyId
var
  pItem: pLineItemRec;
  i: integer;
  iItemsRemoved: integer;
begin
  iItemsRemoved := 0;
  for i := lstLineItems.Count - 1 downto 0 do begin
    pItem := lstLineItems[i];
    if pItem^.LaybyId = iLaybyID then begin
      lblMemoText.Caption := '';
      Inc(iItemsRemoved);
      if iItemsRemoved = 2 then begin
        CommonLib.MessageDlgXP_Vista('Any other Layby Payments for THIS layby recorded on THIS ' +
          #13 + #10 + 'sale will also be removed.', mtWarning, [mbOK], 0);
      end;
      //grdTrans.RemoveRows(i + 1, 1);
      lstLineItems.Delete(i);
    end;
  end;
end;

procedure TPOSScreenForm.RefreshCustomerDisplay;
var
  i: integer;
  LineItem: pLineItemRec;
begin
  CustomerDisplay.ClearDisplay;
  for i := 0 to lstLineItems.Count - 1 do begin
    LineItem := lstLineItems.Items[i];
    if Assigned(CustomerDisplay) then begin
      if not(LineItem^.IsrelatedHidden) then  CustomerDisplay.AddItemToDisplay(LineItem^.ID, LineItem^.ProductID, LineItem^.Qty, LineItem^.ProductDescription, LineItem^.Amount, LineItem);
      SetPOSScreenActive;
    end;
  end;
end;

procedure TPOSScreenForm.RefreshDisplayLine(const pItemRec: pLineItemRec;
  RowNum: integer);
begin
  grdTrans.Cells[COL_QTY, RowNum] := FloatToStrF(pItemRec^.Qty, ffGeneral , 5, 2);

  //grdTrans.Cells[COL_NAME, RowNum] := pItemRec^.ProductName;
  grdTrans.Cells[COL_NAME, RowNum] := pItemRec^.ProductPrintName;

  if pItemRec^.DiscountDetails =  '' then
    grdTrans.Cells[COL_DESC, RowNum] := pItemRec^.ProductDescription
  else
    grdTrans.Cells[COL_DESC, RowNum] := pItemRec^.ProductDescription + ' ' + pItemRec^.DiscountDetails;

  grdTrans.Cells[COL_PRICE, RowNum] := CurrToStrRJ(pItemRec^.LinePriceInc, 13);

  grdTrans.Cells[COL_AMOUNT, RowNum] := CurrToStrRJ(pItemRec^.Amount, 13);
end;

procedure TPOSScreenForm.ReCalcRunTot(Showinviewer:Boolean =True);
  { ReCalculates the running total }
var
  i: integer;
  rValue: currency;
  rDisc: currency;
  LineItem: pLineItemRec;
  totQuantity: double;
begin
  rRunTot := 0.0;
  rTotCustDisc := 0.0;
  rRunTotNoTax := 0.0;
  totQuantity:= 0;

  // Add each amount in AMOUNT column
  for i := 0 to lstLineItems.Count - 1 do begin
    LineItem := lstLineItems.Items[i];

    if LineItem^.IsProduct then
      totQuantity:= totQuantity + LineItem^.Qty;

    // Retrieve amount
    rValue := LineItem^.Amount;
    rDisc := 0;
    if LineItem^.ApplyDisc then begin
      if (LineItem^.DiscRatio = 0) and (rCustDisc <> 0) then
        LineItem^.DiscRatio := rCustDisc;
      rValue := rValue - rValue * LineItem^.DiscRatio;
      rDisc := LineItem^.Amount - rValue;
    end;

    rRunTot      := rRunTot + rValue;
    rRunTotNoTax := rRunTotNoTax + rValue / (1.0 + LineItem^.TaxRate);
    rTotCustDisc := rTotCustDisc + rDisc;
  end;

  rRunTot := RoundTo1C(rRunTot);
  rRunTotNoTax := RoundTo1C(rRunTotNoTax);
  rTotCustDisc := RoundTo1C(rTotCustDisc);
  if Showinviewer then begin
    if Assigned(CustomerDisplay) then
      CustomerDisplay.CustomerDiscount:= rTotCustDisc;
    lblTotalQuantity.Caption:= FloatToStr(totQuantity);
  end;

end;


procedure TPOSScreenForm.StopPlayer;
begin
  if assigned(CustomerDisplay) then
    CustomerDisplay.StopPlay;

  Player.Stop;
  if VideoFiles.Count > 1 then
    Player.Close;
  pnlMediaHost.Visible := false;
  StartTime := time;
end;

procedure TPOSScreenForm.StripCurrStr(var sCurr: string);
  { Removes commas and $ from a currency string }
var
  iIndex: integer;
begin
  // Remove $ sign
  iIndex := FastFuncs.PosEx(AppEnv.RegionalOptions.CurrencySymbol, sCurr);
  Delete(sCurr, iIndex, char_length(AppEnv.RegionalOptions.CurrencySymbol));

  // Remove Commas
  while FastFuncs.PosEx(',', sCurr) > 0 do begin
    iIndex := FastFuncs.PosEx(',', sCurr);
    Delete(sCurr, iIndex, 1);
  end;
end;

function TPOSScreenForm.CashFn:boolean;
begin
  result := False;
  try
    Processingcursor(true);
    try
      if idOk() then begin
        DoPayment('Cash Tendered', PAY_CASH);
        result := True;
      end;
    finally
      ProcessingCursor(False);
    end;
  except
      on E:Exception do begin
         MessageDlgXP_Vista('Failed to Save.' + chr(13) +E.message  +chr(13)+chr(13) +'Current Transaction will Be Cancelled.', mtWarning , [mbOK] , 0);
      end;
  end;
end;

procedure TPOSScreenForm.CreditCardFn;
begin
fbCreditCardPayment:= True;
try
  if idOk() then begin
    if AppEnv.CompanyPrefs.IntegratedEFTPOS then begin
      if rRunTot > 0 then begin
        DoEftTransaction('P', 0.00);
      end else if rRunTot < 0 then begin
        DoEftTransaction('R', 0);
      end;
    end else begin
      DoPayment('Credit Card', PAY_CREDITCARD);
    end;
  end;
finally
  fbCreditCardPayment:= False;
end;
end;

procedure TPOSScreenForm.VisaFn;
begin
  if idOk() then begin
    DoPayment('VISA', PAY_VISA);
  end;
end;

procedure TPOSScreenForm.EFTFn;
begin
try
  if idOk() then begin
    if AppEnv.CompanyPrefs.IntegratedEFTPOS then begin
      if rRunTot > 0 then begin
        DoEftTransaction('P', 0.00);
      end else if rRunTot < 0 then begin
        DoEftTransaction('R', 0);
      end;
    end else begin
      DoPayment('EFTPOS', PAY_EFT);
    end;
  end;
Except
    on E:Exception do begin
       MessageDlgXP_Vista('Failed to Save.' + chr(13) +E.message  +chr(13)+chr(13) +'Current Transaction will Be Cancelled.', mtWarning , [mbOK] , 0);
       CancelFn;
    end;
end;
end;

procedure TPOSScreenForm.EftCashOutFn;
var
  rCash: currency;
begin
  //rCash := 0.0;
  if idOk() and IsAccessAllowed('FnEftCashOut') then begin
    if AppEnv.CompanyPrefs.IntegratedEFTPOS then begin
      if (EnteringNum = true) and (char_length(edtPOSMemo.Lines[0]) > 0) then begin
        if IsValidAmount() then begin
          rCash := GetAmount;
          if IsValidCashAmount(rCash) then begin
            if rCash > 0 then begin
              if rRunTot = 0 then begin
                // Cash out only
                DoEftTransaction('C', rCash);
              end else begin
                // purchase and cash out
                DoEftTransaction('P', rCash);
              end;
            end;
          end;
        end;
      end;
    end else begin
      CommonLib.MessageDlgXP_Vista('You do not have the Integrated EFTPOS Option Enabled', mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TPOSScreenForm.AmexFn;
begin
  if idOk() then begin
    DoPayment('Amex', PAY_AMEX);
  end;
end;

function TPOSScreenForm.AnyLinesSelected: boolean;
var
  x: integer;
begin
  result := false;
  for x:= 0 to lstLineItems.Count -1 do begin
    if pLineItemRec(lstLineItems[x])^.Selected then begin
      result := true;
      exit;
    end;
  end;
end;

procedure TPOSScreenForm.DinerFn;
begin
  if idOk() then begin
    DoPayment('Diners', PAY_DINER);
  end;
end;

procedure TPOSScreenForm.MasterCardFn;
begin
  if idOk() then begin
    DoPayment('MasterCard', PAY_MASTERCARD);
  end;
end;

procedure TPOSScreenForm.DebitCardFn;
begin
  if idOk() then begin
    DoPayment('DebitCard', PAY_DEBITCARD);
  end;
end;

procedure TPOSScreenForm.MaestroFn;
begin
  if idOk() then begin
    DoPayment('Maestro', PAY_MAESTRO);
  end;
end;

procedure TPOSScreenForm.CompleteSaleFn;
{ Used to complete the sale when then payment amount exceeds the run total and
  we do not wish to issue a cash out.  We 'sell' the customer the 'Completion'
  part. }
begin
  if idOk() then begin
    if GetPayments() > rRunTot then begin
      FilterPartsByName(PART_COMPLETION);
      if not PostSaleItem('Complete Sale', GetPayments() - rRunTot,
        1, 0, 0.0, 0.0, true, true, false) then Exit;
      DisplayLineItem(lstLineItems.Last);
      DoPayment('Complete Sale', PAY_COMPLETE);
    end else begin
      CommonLib.MessageDlgXP_Vista('Cannot complete Sale - There is an amount still owing.', mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TPOSScreenForm.CashOutFn;
{ There are 2 situations with cash out
  1. We simply wish to use the till to issue cash (eg petty cash), in this
     instance an amount is provided.  We 'sell' the Cash-Out part and pay with
     a negative Cash amount.
  2. The payment amount is greater than the run total and we wish to cash out
     the remainder to the customer (perhaps on redemption of a voucher).
     In this instance no amount
     should be provided since it is assumed to be the differnce between the
     payments and run total.  We simply make a -ve cash payment of the
     difference. }
var
  rAmount: currency;
  s:String;
begin
  if idOk() then begin
    // if amount is supplied then this is a simple cash out
    if EnteringNum then begin
      if IsLineItems() then begin
        CommonLib.MessageDlgXP_Vista('You cannot include a Cash-Out with any other Items', mtWarning, [mbOK], 0);
      end else if IsValidAmount(true) then begin
        rAmount := GetAmount;
        // they buy a cash-out part (-ve amount)
        FilterPartsByName(PART_CASH_OUT);
        s:= '';
        if Appenv.CompanyPrefs.MustProvideDetailsforCashout then
          if MemoInput('Cash Out Details:' , s) then s:= ':' +s;

        if not PostSaleItem(PART_CASH_OUT + s, - rAmount, 1, 0, 0.0, 0.0, true, true, false) then Exit;
        DisplayLineItem(lstLineItems.Last);
        DoPayment(-rAmount, PART_CASH_OUT, PAY_CASH);
      end;

      // if no amount then we assume we are completing this transaction with a
      // .. cash out (eg. to pay back difference from an excess voucher payment)
    end else if GetPayments() > rRunTot then begin
      rAmount := rRunTot - GetPayments;   // rAmount should be -ve
      DoPayment(rAmount, PART_CASH_OUT, PAY_CASH);
    end else begin
      CommonLib.MessageDlgXP_Vista('Cannot Cash Out - Enter Amount first.', mtWarning, [mbOK], 0);
    end;
  end;
end;
function TPOSScreenForm.anySelected:Boolean;
var
  pItem: pLineItemRec;
  i: integer;
begin
  result := False;
  for i := lstLineItems.Count - 1 downto 0 do begin
    pItem := lstLineItems[i];
    if pItem.Selected then    begin
      Result := True;
      Exit;
    end;
  end;

end;
procedure TPOSScreenForm.InvoiceFn;
  { Creates an invoice from the POS lines - note: POS not completed at this stage}
begin
  if bIsTraining then begin
    CommonLib.MessageDlgXP_Vista('Invoicing can not be done in training mode', mtInformation,  [mbOk], 0);
    exit;
  end;

  if Not(anySelected) then begin
    CommonLib.MessageDlgXP_Vista('Please Select Records to be Invoiced.'+NL+
                                'Hold Down CTRL and Click on the Item to Select.', mtInformation,  [mbOk], 0);
    exit;

  end;

  if idOk() then begin
    if not bIsSplitTab then begin
      if IsLineItems then begin
        if IsTotalDiscOK() then begin
          if (char_length(sClient) = 0) or (sClient = CLIENT_CASH) then begin
            iCustOriginator := FN_INVOICE; // used in edtClientIDChange to identify
            ShowCustList; // get the client name
            { The processing of this transaction is completed in the edtClientIDChange as
              this OnChange event marks the return from the customer list.
              edtClientIDChange will recognize that it needs to initiate
              'FinishInvoice'  from the value of iCustOriginator }
          end else begin
            // We know client name so continue with process
            FinishInvoice;
          end;
        end;
      end;
    end else begin
      CommonLib.MessageDlgXP_Vista('You cannot Invoice a Split directly, Please Assign to Customer''s Tab.', mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TPOSScreenForm.InvoiceListAfterShow(Sender: TObject);
begin
  (Sender as TForm).FormStyle := fsNormal; //fsStayOnTop; //fsNormal; @@@@
  (Sender as TBaseListingGui).chkIgnoreDates.checked := true;
  // Need to manually switch SearchModes - after setting filters, we will switch to the FullList
  (Sender as TBaseListingGui).SearchMode := smSearchEngine;
  if iClientId > 0 then
  begin

    TERPQuery((Sender as TBaseListingGui).qryMain).Filter := '(ClientId = ' + IntToStr(iClientId) + ')';
    TERPQuery((Sender as TBaseListingGui).qryMain).Filtered := true;

//  (Sender as TBaseListingGui).Customfilter.Addfilter('ClientId = ' + IntToStr(iClientId), AndFilter);
  end;
  (Sender as TBaseListingGui).SearchMode := smFullList;
  // do not know why, but at this point qryMain has already been closed. Need to open it
  if not TERPQuery((Sender as TBaseListingGui).qryMain).Active then
     (Sender as TBaseListingGui).DoRefreshQuery;
  HookListForm(Sender as TBaseListingGui);
end;

procedure TPOSScreenForm.InvoiceListFn;
begin

  iSaleId := 0;

  openERPListform('TInvoiceListGUI', nil, InvoiceListAfterShow);// , beforeshowProductList);

  while FormStillOpen('TInvoiceListGUI') do begin
    Sleep(10);
    Application.ProcessMessages;
  end;

  if iSaleId = 0 then
    exit;
  FillLinesBySaleId(iSaleId);
end;

procedure TPOSScreenForm.FinishInvoice;
var
  rBalance: currency;
  rPrevBal: currency;
  rCreditLimit: currency;
  bOk: boolean;
  rBarTabBal: currency;
begin
try
  if (char_length(sClient) = 0) or (sClient = CLIENT_CASH) then begin
    CommonLib.MessageDlgXP_Vista('You must provide a customer name for Invoice',
      mtWarning, [mbOK], 0);
    IsPOSInvoice := false;
    Exit;
  end;

  BackupUnselected(false);
  bOk := false;
  try
    CalcAndPostCustDisc;
    GetCredit(iClientID, rCreditLimit, rPrevBal);
    rBarTabBal := GetBarTabBalance(iClientID);
    rBalance   := rRunTot + rPrevBal + rBarTabBal;

    if rBalance <= rCreditLimit then begin
      bOk := true;
    end else begin
      if appenv.CompanyPrefs.CreditCheckInv then begin
        with TPOSCreditPopUp.Create(Self) do try
            lblCredit.Caption := CurrencyToStrF(rCreditLimit, ffCurrency);
            lblPrevBal.Caption := CurrencyToStrF(rPrevBal, ffCurrency);
            lblNewBal.Caption := CurrencyToStrF(rBalance, ffCurrency);
            lblDiff.Caption := CurrencyToStrF(rBalance - rCreditLimit, ffCurrency);
            if ShowModal = mrOk then begin
              if IsAccessAllowed('FnCreditOverride', fiEmployeeID) then begin
                bOnhold:=True;
                bOk := true;
              end;
            end;
        finally
          Free;
        end;
      end else bOk := true;
    end;

    if bOk then begin
      bOk := false;
      IsPOSInvoice := true;
      sPayType := PAY_NONE;
      if not PostToDB then exit;
      if SavePOS then begin
        CleanUp;
        DisplayInViewer('Invoice  ' + CurrToStrRJ(rRunTot, 13));
        bOk := true;
      end else begin
        IsPOSInvoice := False;
      end;
    end;
  finally
    if IsSaleSplit then
      if bOk then
        RestoreUnselected
      else
        MergeUnselected;
  end;
  finally
      bOnhold:=False;
  end;
end;


Procedure TPOSScreenForm.GetChequeDetails;
begin
    with TPaymentChequeDetails.Create(self) do begin
        client;
        if Assigned(fClient) then begin
            ClientID := client.Id;
            edtChequeNo.Text    := sREf;
        end;
        if ShowModal = mrOk then begin
          sRef := fsChequeNumber;
        end;
    end;
end;
procedure TPOSScreenForm.DoSelectAll;
var
  pItem: pLineItemRec;
  i: integer;
begin
  for i := lstLineItems.Count - 1 downto 0 do begin
    pItem := lstLineItems[i];
    if not pItem.Selected then pItem.Selected  := True;
  end;
  RebuildGrid;
end;
procedure TPOSScreenForm.CheckForCashDrop(checkforLotsOf:Boolean =True);
var
  qry: TERPQuery;
  fdSaleAmt1, fdsaleamt2, fdCashdropedamt, amttobedropped :Double;
  sSQl:String;
  cdId:Integer;

  Function AmttoDrop:Double;
  begin
    // Result := 0;
    if amttobedropped> Appenv.companyprefs.CashDropLotsOf then
      result := trunc(amttobedropped/ Appenv.companyprefs.CashDropLotsOf)*Appenv.companyprefs.CashDropLotsOf
    else
      result :=amttobedropped;
  end;
begin

  if Appenv.CompanyPrefs.UseCashDrop = False then exit;
  if Appenv.CompanyPrefs.CashDropLotsOf =0 then exit;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    closedb(qry);
    qry.sql.text := 'select  ' +
                    'Sum(Amount) as Amount ' +
                    ' from tblsales_POS S  ' +
                    ' inner join tblsalespayments_pos SP on SP.SaleID = S.saleID  and SP.paymethod ="Cash"' +
                    ' Where S.tillid =' + inttostr(itillId);
    opendb(qry);
    fdSaleAmt1 := qry.fieldbyname('Amount').asfloat;

    closedb(qry);
    qry.sql.text := 'select  ' +
                    'Sum(Amount) as Amount ' +
                    ' from tblsales S  ' +
                    '  inner join tblsalespayments SP on SP.SaleID = S.saleID  and SP.paymethod ="Cash" ' +
                    ' Where S.POS ="T" and S.IsLayby = "F"  ' +
                    ' and S.isPOS = "T" and S.tillid =' + inttostr(itillId);
    opendb(qry);
    fdSaleAmt2 := qry.fieldbyname('Amount').asfloat;

    closedb(qry);
    qry.sql.text := 'Select sum(Amount) as CashDropped from tblCashDrop where EOPDOne ="F" and tillid =' + inttostr(itillId);
    opendb(qry);
    fdCashdropedamt := qry.fieldbyname('CashDropped').asInteger;
    amttobedropped := fdSaleAmt1 + fdSaleAmt2 -fdCashdropedamt;

    if (checkforLotsOf and (amttobedropped>= Appenv.companyprefs.CashDropLotsOf)) or
       (not(checkforLotsOf) and (amttobedropped> 0)) then begin
      if MessageDlgXP_Vista('You have ' +floatTostrf(amttobedropped, ffcurrency, 15 , 2)+' in the Cash Drawer.' + NL +
                            '(Preference to Do Cash Drops in Lots of ' + floattostrf(Appenv.CompanyPrefs.CashDropLotsOf , ffCurrency , 15, 2) +')' + Nl + NL +
                            'Do you Wish to Add ' + floatTostrf(AmttoDrop, ffcurrency, 15 , 2)+' in the Cash Safe?', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
          cdID:= TCashDrop.DoCashDrop(self, AmttoDrop , itillID, iEmployeeID);
          if cdID >0 then begin
          ssql := companyInfoSQL('',0,0) +
                    '~|||~{Details}Select CD.CashDropAt,   E.employeename,   T.tillname,   CD.Amount   '+
                    ' from tblcashdrop CD     '+
                    ' inner join tblemployees E on E.employeeId = CD.employeeId    '+
                    ' inner join tblPOSTills T on CD.tillId = T.tillID  '+
                    ' Where CD.Id = '+inttostr(cdId);
            fbReportSQLSupplied:= TRue;
            PrintTemplateReport('Cash Drop Receipt' ,ssql , not(devmode) , 1 , nil , Appenv.CompanyPrefs.USBPrinterName);
          end;
      end;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function TPOSScreenForm.CheckSelectedLines(const ACaller: string): boolean;
var
  idx : integer;
begin
  Result := false;
  if lstLineItems.Count = 0 then
  begin
    MessageDlgXP_Vista('Please enter at least one product', mtWarning, [mbOk], 0);
    exit;
  end;

  for idx := 0 to lstLineItems.Count - 1 do
    if pLineItemRec(lstLineItems[idx]).Selected  then
    begin
      Result := true;
      exit;
    end;
  MessageDlgXP_Vista('Please Select At Least One Product for ' + ACaller, mtWarning, [mbOk], 0);
end;

procedure TPOSScreenForm.ChequeFn;
var
  option :Word;
begin
  if idOk() then begin
    if not bChqNoEntered then begin
      option := CommonLib.MessageDlgXP_Vista('Do you Wish to Enter a Cheque No.',
        mtConfirmation, [mbYes, mbNo, mbCancel], 0);
      if option = mrcancel then Exit;

      if option  = mrYes then begin
            GetchequeDetails;
      end else begin
        sRef := '';
      end;

    end;
    DoPayment('Chq Tendered', PAY_CHEQUE);
  end;
end;

procedure TPOSScreenForm.MemoFn;
begin
  with TPOSMemoPopUpFrm.Create(Self) do try
      edtMemo.Text := Self.lblMemoText.Caption;
      if ShowModal = mrOk then begin
        Self.lblMemoText.Caption := edtMemo.Text;
      end;
    finally
      Free;
    end;
end;


procedure TPOSScreenForm.MemoPresetFn;
var
  POSBtnMatrixSelected: TPosBtn;
begin
  POSBtnMatrixSelected := oPOSBtnMatrix.Selected;
  if (POSBtnMatrixSelected = nil) then Exit;
  if idOk() then begin
    if not Empty(Self.lblMemoText.Caption) then begin
      Self.lblMemoText.Caption := Self.lblMemoText.Caption + #13#10 + string(POSBtnMatrixSelected.Func.Memo);
    end else begin
      Self.lblMemoText.Caption := string(POSBtnMatrixSelected.Func.Memo);
    end;
  end;
end;

procedure TPOSScreenForm.MergeUnselected;
begin
  if not IsSaleSplit then
    exit;


  with SavedContext do begin
    bChqNoEntered := fbChqNoEntered;
    bPrevTransWasLayby := fbPrevTransWasLayby;
    iQuoteID    := fiQuoteID;
    iHireID    := fiHireID;
    iAppointID  := fiAppointID;
    edtPOSMemo.Text := fedtPOSMemoText;
    rQuantOfProd := frQuantOfProd;
    lblMemoText.Caption := flblMemoTextCaption;
    sRef        := fsRef;
    iClientID   := fiClientID;  // will need to LoadCustInfo
    bMustEnterIdNow := fbMustEnterIdNow;
    lblSalesPerson.Caption := flblSalesPersonCaption;
    iEmployeeID := fiEmployeeID;
  end;

  if iClientID <> 0 then begin
    LoadCustomer(iClientID);
  end;

  while SavedContext.flstLineItems.Count {- 1} > 0 do
  begin
    lstLineItems.Add(SavedContext.flstLineItems[SavedContext.flstLineItems.Count - 1]);
    SavedContext.flstLineItems.Delete(SavedContext.flstLineItems.Count - 1);
  end;

  IsSaleSplit := false;
  RebuildGrid;
//  ClearInputMemo;
  bTransOnHold := false;
  bTransComplete := false;
  bPrintReceiptCount := 0; // reset counter
  lblOnHold.Visible := false;
end;

procedure TPOSScreenForm.TopOfViewer;
  { Scrolls to the top of the memo veiwer }
begin
  edtPOSMemo.SelStart := 0;
  SendMessage(edtPOSMemo.Handle, EM_SCROLLCARET, 0, -1);
end;


procedure TPOSScreenForm.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
var
  i:Integer;
  wkey : pchar;
begin
      if not PaymethodPressedInProgress then begin
        if not fbSendingFormKeys then SetLength(FormKeys , 0);
        PaymethodPressedInProgress := true;
        POSKeyDown(Key, Shift);
        PaymethodPressedInProgress := false;
        if not(fbSendingFormKeys) and (length(FormKeys) >0) then begin
          fbSendingFormKeys := true;
          try
            try
              GetMem(wkey, 1);
              try
                for i := low(FormKeys) to high(FormKeys) do begin
                  wkey^ :=char(FormKeys[i]);
                  SendKeys(wkey,True);
                end;
              finally
                   FreeMem(wkey, sizeof(wkey^));
              end;
            Except
              on E:Exception do begin
              end;
            end;
          finally
            fbSendingFormKeys := False;
          end;
          Finalize(FormKeys);
        end;
            //FormKeyDown(Sender ,FormKeys[i] , shift);
            //POSKeyDown(FormKeys[i], Shift);
      end else begin
        SetLength(FormKeys , length(FormKeys)+1);
        FormKeys[high(FormKeys)] := key;
        Key := 0;
      end;
end;

procedure TPOSScreenForm.ProductFn;
  // Process a product selection when product is associated with a button
var
  tmpPartNumber: integer;
  POSBtnMatrixSelected: TPosBtn;
begin
  POSBtnMatrixSelected := oPOSBtnMatrix.Selected;
  if (POSBtnMatrixSelected = nil) then Exit;
  if IsProductAllowed() then begin
    if idOk() then begin
      // Retrieve details from parts tabel using part number on button
      tmpPartNumber := POSBtnMatrixSelected.Func.PartNumber;
      if tmpPartNumber > 0 then begin
        GlobalEvents.Notify(self, GEVENT_POS_CheckForListRedisplay, lstLineItems);
        edtPartID.text := ''; { to make sure onChange event fires }
        edtPartID.text := IntToStr(tmpPartNumber);
      end;
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('You cannot mix a Product and a Voucher or Layby in the same sale', mtWarning, [mbOK], 0);
  end;
end;

procedure TPOSScreenForm.PriceChangeFn;
var
  bOk: boolean;
  i : integer;
  Item : pLineItemRec;
begin
  if idOk() and IsAccessAllowed('FnPriceChange') then begin
    bOk := true;
    //---
    if lstLineItems.Count = 0 then begin
      ShowWarning('Please Add a Product to the Sale First');
      exit;
    end;

    if grdTrans.RowSelectCount = 0 then
    begin
      ShowWarning('Please Select the Product To Override Price');
      exit;
    end;
    if grdTrans.RowSelectCount > 1 then
    begin
      ShowWarning('Please Select Only One Product For Price Overriding');
      exit;
    end;

//    i := grdTrans.SelectedRow[0] - 1;
    i := grdTrans.Row - 1;
    if i > lstLineItems.Count -1 then
      i := lstLineItems.Count -1;

    if not EnteringNum then
    begin
      //ShowWarning('Enter New Price for ' + pLineItemRec(lstLineItems[i]).ProductName + ' and then Click Price Override');
      ShowWarning('Enter New Price for ' + pLineItemRec(lstLineItems[i]).ProductPrintName + ' and then Click Price Override');
      exit;
    end;


    //---
    if EnteringNum = true then begin
      // Convert to float
      try
        rPriceChange := StrToFloat(edtPOSMemo.Lines[0]);
      except
        on EConvertError do begin
          CommonLib.MessageDlgXP_Vista('Not a valid amount', mtWarning, [mbOK], 0);
          bOk := false;
        end;
      end;
      if bOK then begin
        EnteringNum(false);
        bPriceChange := true;
        Item := pLineItemRec(lstLineItems[i]);
        PostSaleItem(Item, Item^.ProductDescription, rPriceChange, Item.Qty,
           Item.LaybyId, Item.LaybyBal, Item.LaybyAmount, true, true, False, false, false, Item.UnitID);
        RefreshDisplayLine(Item, i+1);
        RefreshCurrentlineitem(Item);
      end;
    end;
  end;
  EnteringNum(false);
end;

function TPOSScreenForm.POSRoundTo5C(const rMoney: currency): currency;
begin
  if (AppEnv.RegionalOptions.RegionType = rUK) then
    Result := rMoney
  else
    Result := RoundTo5C(rMoney);
end;

function TPOSScreenForm.PostToDB: boolean;
begin
  result := true;
  //bIsSummarySale := IsSummarySale;
  Processingcursor(true);
  try
    if not bIsTraining then begin
//      if not IsPOSInvoice and not IsPosQuote and not IsPosSalesOrder and
      if not (IsPosInvoice or isPosQuote or IsPosSalesOrder) and
         not bIsLayby and not bIsBarTab and not bIsSplitTab then begin
        try
          OpenCashDrawer;
        Except
          on e:Exception do begin
            MessageDlgXP_Vista('Open Cash Draw Failed'+NL+NL+E.Message, mtWarning, [mbOK], 0);
          end;
        end;
      end;
      CreateReceiptLists;  // to avoid any changes, do this now
      result:= PostSaleToDB;
   end;
  finally
    Processingcursor(False);
  end;
end;

function TPOSScreenForm.IsTotalDiscOk(ASource : integer): boolean;
  { Check total discounts given do not exceed compamy prefrence max }
var
  i: integer;
  pItem: pLineItemRec;
  rDiscTot: Double;
  rTotalGoods: Double;
  MaxDiscountPercent: double;
  rtotCost, ADiscPrice:double;
  aMsg:String;
begin
  rDiscTot := 0.0;
  rTotalGoods := 0.0;
  rtotCost:= 0;

  for i := 0 to lstLineItems.Count - 1 do begin
    pItem := lstLineItems[i];
    if pItem^.IsDiscount then begin
      rDiscTot := rDiscTot + pItem^.Amount;
    end else begin
      rTotalGoods := rTotalGoods + pItem^.Amount;
      rtotCost := rtotCost + PItem^.LineCost * PItem^.Qty;
    end;;
  end;
  MaxDiscountPercent:=0;    ADiscPrice:=0; rDiscTot := abs(rDiscTot);
  if not TSalesDiscountValidationObj.ValidateDiscount(Self, rDiscTot  , MaxDiscountPercent, rtotCost , rTotalGoods  , ADiscPrice ,1.0 , 0 , False, False, aMsg) then begin
    CommonLib.MessageDlgXP_Vista(aMsg, mtWarning, [mbOK], 0);
    REsult := False;
  end else begin
//    REsult := True;
    if (ASource <> FN_SALES_ORDER) and (AppEnv.CompanyPrefs.PosConfirmTotalPayment) then
      Result := MessageDlgXP_Vista('Total Payment is ' + FormatSettings.CurrencyString + FormatFloat('######.##', rTotalGoods) + #13#10'Is it Ok?', mtConfirmation, [mbOk,mbCancel], 0) = mrOk
    else
      Result := true;
  end;

end;


function TPOSScreenForm.PostSaleToDB: Boolean;
begin
    Result := false;
    TRy
        POSObj.connection.BeginTransaction;
        try
            if IsAnyAccountPayments() then begin
                AdjustPayments;
            end;
            PostSaleHeaderToDB;
            POSObj.PostDB;
            PostLineItemsToDB;
            if POSObj.Isvoucher then POSObj.Isvoucher :=POSObj.AllLinesvoucher;
            POSObj.PostDB;
            if not POSObj.ValidateData then begin
              RollbackTransaction;
              exit;
            end;
            PostPaymentsToDB;
            if not POSObj.ValidateData then begin
              RollbackTransaction;
              exit;
            end;
            result := true;
        except
            RollbackTransaction;
            raise;
            Exit;
        end;
    Except
        // kill the exceoption, and result is the defualt false
    end;
end;
Procedure TPOSScreenForm.OpenInvoice(Const Sender: TBusObj; var Abort: Boolean);
begin
    if not (Sender is TPOS) then Exit;

    if TPos(Sender).isPOSInvoice then begin
        if not AppEnv.CompanyPrefs.POSCloseInvoiceAfterCreate then begin
            if not OpenERPFormModal('TInvoiceGUI' , TPos(Sender).dataset.fieldbyname('SalesID').asInteger) >=0 then begin
            end;
        end;
    end
    else if TPos(Sender).isPOSQuote then begin
      if not OpenERPFormModal('TQuoteGUI' , TPos(Sender).dataset.fieldbyname('SalesID').asInteger) >=0 then begin
      end;
    end
    else if TPos(Sender).isPOSSalesOrder then begin
      if not OpenERPFormModal('TSalesOrderGUI' , TPos(Sender).dataset.fieldbyname('SalesID').asInteger) >=0 then begin
      end;
    end;

   if bIsPayTab then
     DeleteBarTab(iClientID);  // remove all sales in the POSObj Sales tables for this client
end;


function TPOSScreenForm.SavePOS:boolean;
begin
    try
      result := False;
      try
        ProcessingCursor(True);
        try
          POSGroupObj.IteraterecordProgressbarMsg := 'Saving the POS transacion';
          if not POSGroupObj.Save then begin
            MessageDlgXP_Vista(POSGroupObj.resultstatus.messages, mtWarning, [mbOK], 0);
            RollbackTransaction;
            exit;
          end;
        finally
          ProcessingCursor(False);
        end;
      finally
        POSGroupObj.ResultStatus.Clear;
      end;
      iSaleID :=POSObj.SalesId;

      if not POSObj.ISSummarySale then begin
        lblSaleNo.Caption := POSObj.SalesGlobalREf;
        lblSaleNo.ShowHint := False;
      end else begin
        lblSaleNo.Caption := 'Sum of ' + POSObj.Salesglobalref;; // Indicate that this is a summary
        lblSaleNo.Hint := 'Indicates that the ''POS Preference'' is set to summary';
        lblSaleNo.ShowHint := True;
      end;
      iOrderNo := POSObj.OrderFromPOSOrderId;

      if Assigned(CustomerDisplay) then begin
          if iOrderNo <> 0 then begin
            CustomerDisplay.DisplayOrderNo(IntToStr(iOrderNo));
          end else begin
              if AppEnv.CompanyPrefs.POSCreateOrders then begin
                  CustomerDisplay.DisplayOrderNo('-');
              end else begin
                  RefreshCustomerDisplay;
              end;
          end;
          SetPOSScreenActive;
      end;
      Printpos;
      CommitTransaction;
      PlaySavesound;
      REsult := True;
    Except
      on e:Exception do begin
        MessageDlgXP_Vista('Save Failed'+NL+NL+E.Message, mtWarning, [mbOK], 0);
        Result := False;
      end;
    end;

      {this should be after commit transaction
      as the invoice form uses a different connection }
      posobj.UserLock.UnlockAllCurrentInstance;//UnlockAllCurrentUser //Binny -UnlockAllCurrentUser removes locking from other forms are well;
      posobj.Salesobj.UserLock.Unlock(posobj.LockGroupName);

      POSObj.IterateRecords(OpenInvoice);

      TRy
        if Assigned(POSGroupObj) then begin
          POSGroupObj.DeleteAllTempPOSRecords;
        end;
      Except
          //kill the exception
      end;
end;

procedure TPOSScreenForm.SavePosVideoDelay;
var
  RegIni: TIniFile;
begin
  RegIni := TIniFile.Create(SystemLib.ExeDir + csCustomerDisplayFile);
  try
    RegIni.WriteInteger(csPOSVideoSection, csPOSVideoIdent, PosVideoDelay);
  finally
    FreeAndNil(RegIni);
  end;
end;

Procedure TPOSScreenForm.PrintPos;
begin
  if not (IsPOSInvoice or IsPosQuote or IsPosSalesOrder) and not bIsBarTab and not bIsSplitTab then begin
    try
      if bPrintReceipt then
        PrintReceipt;
    Except
      on e:Exception do begin
        //logtext('18:' + E.Message);
        MessageDlgXP_Vista('Print Failed'+NL+NL+E.Message, mtWarning, [mbOK], 0);
      end;
    end;

    try
      if lstLaybyItems.Count <> 0 then
        ProcessLaybyCompletion;
    Except
      on e:Exception do begin
        MessageDlgXP_Vista('Process Layby completion'+NL+NL+E.Message, mtWarning, [mbOK], 0);
      end;
    end;

    try
      PrintSaleinA4(iSaleID);
    Except
      on e:Exception do begin
        MessageDlgXP_Vista('A4 printing failed.'+NL+NL+E.Message, mtWarning, [mbOK], 0);
      end;
    end;
  end;
end;
procedure TPOSScreenForm.ProcessLaybyCompletion;
{ Creates the entire layby completion reversal transacation and posts -
  both header and line item }
var
  pItem: pLaybyItemRec;
  i, j: integer;
begin
{ TODO :
If the user wants to print a receipt at the end of this process then he will
not get what he expects - if required, we will need to Save every al the
line details etc. :-o }

  for i := 0 to lstLaybyItems.Count - 1 do begin
    rRunTot      := 0.0;
    rRunTotNoTax := 0.0;
    CleanUp;

    // Clear line items list
    for j := 0 to lstLineItems.Count - 1 do Dispose(lstLineItems.Items[j]);
    lstLineItems.Clear;

    // Clear payments list
    for j := 0 to lstPayments.Count - 1 do Dispose(lstPayments.Items[j]);
    lstPayments.Clear;

    for j := 0 to lstRedeemPoints.Count - 1 do Dispose(lstRedeemPoints.Items[j]);
    lstRedeemPoints.Clear;



    pItem := lstLaybyItems[i];
    FilterPartsByName(PART_LAYBY_PAY);
    if not PostSaleItem('Layby Completion Reversal', - pItem^.Amount, 1, pItem^.LaybyID,
      0.0, 0.0, false, true, false) then Exit;
    sPayType := PAY_LAYBY;
    AddPaymentToList(sPayType, '', pItem^.Amount, 0, 0, pItem^.LaybyID);  // create a payment for original layby
    AddPaymentToList(sPayType, '', - pItem^.Amount, 0, 0, 0);  // create a payment for layby reversal
    bIsLaybyReversal := true;
    //PostSaleToDB;
  end;
end;


procedure TPOSScreenForm.CleanUp;
  // Does housekeeping - after completion of a sale.
begin
  // Clean up
  TopOfViewer;
  EnteringNum(false); // We've stopped entering a number
  bTransComplete        := true;   // The transaction is complete
  iDummySaleID          := 0;
  bUpdateDate           := true;   // Next sale item will update date
  bChqNoEntered         := false;
  bIsCalcDiscDone       := false;
  bPrevTransWasLayby    := bIsLayby;
  bIsLayby              := false;
  bIsVoucher            := false;
  bIsLaybyPayment       := false;
  bIsLaybyReversal      := false;
  //bIsSummarySale        := false;
  bLoadedRefund         := false;
  bRefundMode           := false;
  iLaybyID              := 0;
//  iRepairID             := 0;
  iQuoteID              := 0;
  iHireID               := 0;
  iAppointID            := 0;
  bIsEft                := false;
  bIsBarTab             := false;
  bIsTransferTab        := false;
  bIsPayTab             := false;
  bIsSplitAccount       := false;
  bIsSplitTab           := false;
  bSplitInProgress      := false;
  bIsEndOfSplitTab      := false;
  sEftTxnRef            := '';
  bIsEftCashOutOnly     := false;
  DullDisplay;
  IsPOSInvoice          := false;
  IsPosSalesOrder       := false;
  IsPosQuote            := false;
  bIsCloseTab           := false;
  rSplitTabToPayAmount  := 0;
  iSplitTabGroupID      := 0;
  iCustOriginator       := 0;
  iProdOriginator       := 0;
  iLaybyOriginator      := 0;
  sRef:= '';
  sPOSPCode:='';
  sCustPONumber:= '';
  sMedtype:='';
  iMedTypeID:=0;
  Freeandnil(fClient);
  FreeAndNil(SignatureStream);
  SelectAllLines(false);
  UnlockVoucher;
end;

procedure TPOSScreenForm.ClearAll;
  // Clears the grid and the memo (usually used to start a new sale)
var
  i: integer;
begin
  // Clear the Viewer
  ClearInputMemo;

  // Clear the grid
  grdTrans.RemoveRows(1, grdTrans.RowCount - 2);
  grdTrans.Col := 0;
  grdTrans.Row := 0;

  //Clear Customer Display
  if Assigned(CustomerDisplay) then begin
    CustomerDisplay.ClearDisplay;
    SetPOSScreenActive;
  end;
  DisplayWelcomeOnPole;


  SelectedTaxCodeId := 0;

  // Reset totals etc
  rQuantOfProd := 1.0;
  rRunTot := 0.0;
  rRunTotNoTax := 0.0;
  lblRunTot.Caption :=  CurrencyToStrF(0, ffCurrency); // AppEnv.RegionalOptions.CurrencySymbol+'0.00';;
  TotalinCustomerdisplay(0);
  lblTotalQuantity.Caption:= '0';
  lblMemoText.Caption := '';
  EnteringNum(false);

  lblSubLabel.Visible := true;
  lblSplit.Visible := false;
  lblSplitLabel.Visible := false;

  // reset sales info
  iSaleID := 0;
  PickingSlipOnComplete := false;
  iOrderNo := 0;
  lblSaleNo.Caption := '';
  sRef := '';
  sPayType := '';

  // clear out list form return edt's
  edtClientId.Text := '';
  edtVoucherId.Text := '';
  edtLaybyId.Text := '';
  edtPartId.Text := '';

  ResetCustInfo;

  iTabsClientID := 0;  //Tab Client Reset;

  if bMultiSalesMan then begin
    bMustEnterIdNow := true;
    lblSalesPerson.Caption := '';
    iEmployeeID := 0;
  end;
  sLaybyCustomer := '';

  // Clear line items list
  for i := 0 to lstLineItems.Count - 1 do Dispose(lstLineItems.Items[i]);
  lstLineItems.Clear;

  // Clear payments list
  for i := 0 to lstPayments.Count - 1 do Dispose(lstPayments.Items[i]);
  lstPayments.Clear;

  for i := 0 to lstRedeemPoints.Count - 1 do Dispose(lstRedeemPoints.Items[i]);
    lstRedeemPoints.Clear;


  // Clear split tab payments list
  for i := 0 to lstSplitTabPayments.Count - 1 do Dispose(lstSplitTabPayments.Items[i]);
  lstSplitTabPayments.Clear;

  // Clear Layby-completed items list
  for i := 0 to lstLaybyItems.Count - 1 do Dispose(lstLaybyItems.Items[i]);
  lstLaybyItems.Clear;

  //clear bartabs used
  for i := 0 to lstProcessedBarTabs.Count - 1 do Dispose(lstProcessedBarTabs.Items[i]);
  lstProcessedBarTabs.Clear;

  bPrintReceiptCount := 0; // reset counter
  NormalDisplay;
  TRy
    if Assigned(POSGroupObj) then begin
      POSGroupObj.DeleteAllTempPOSRecords;
      POSGroupObj.New;
      POSGroupObj.UserID := AppEnv.Employee.EmployeeID;
      POSGroupObj.PostDB;
    end;
  Except
      //kill the exception
  end;

end;


procedure TPOSScreenForm.CompleteBarTabInvoice;
var
  frmInv: TInvoiceGUI;
begin
  frmInv := TInvoiceGUI(GetComponentByClassName('TInvoiceGUI'));
  If not Assigned(frmInv) then Exit;
  frmInv.KeyID := self.iSaleID;
  frmInv.FormStyle := fsMDIChild;
  frmInv.btnClose.Enabled := false;
  frmInv.SilentMode := true;

  {Recalculates the totals - not sure if we need 2 bites of the cherry - try removing one}
  PostMessage(frmInv.Handle, SX_CalcTotalsMsg, 0, 0);

//  if AppEnv.Employee.UseSearchCompanies then begin
//    // Yes, Set the company name as the filter
//    // and with that we can then fill in the
//    // upper half of the form details.
//    frmInv.edtCompanySearchFilter.Text := sClient;
//
//    // Execute Search Filter Exit Event.
//    frmInv.bDropDownClients := false;
//    frmInv.edtCompanySearchFilterExit(nil);
//  end else begin
    {Fire off the CloseUp event of the client combo to populate all other data}
    frmInv.cboClientR.LookupTable.Locate('Company', sClient, [loCaseInsensitive]);
    frmInv.cboClientR.Text := sClient;
    frmInv.cboClientR.OnCloseUp(Self, frmInv.cboClientLookup, frmInv.tblMaster, true);
//  end;

  // Close the invoice
  if frmInv.btnCompleted.Enabled then begin
    frmInv.btnCompletedClick(nil);
  end;

  // make sure the invoice form is dead and gone
  while FormStillOpen('TInvoiceGUI', frmInv) do begin
    Sleep(10);
    Application.ProcessMessages;
  end;
end;



procedure TPOSScreenForm.PostSaleHeaderToDb;
var
  //qry: TERPQuery;
  rLaybyBal: currency;
  qry: TERPQuery;
  PictureStream: TStream;


  Procedure InitialiseFlags;
  begin
        POSObj.IsPOSInvoice           := bISInvoice;
        POSObj.IsPosQuote             := bIsQuote;
        POSObj.IsPOSSalesOrder        := bIsSalesOrder;
//        POSObj.RepairID               := iRepairID;
        POSObj.QuoteID                := iQuoteID;
        POSObj.HireGlobalref          := THire.idToggle(iHireID);
        POSObj.appointId              := iAppointId;
        POSObj.IsEndOfSplitTab        := bIsEndOfSplitTab;
        POSObj.IsBarTab               := bIsBarTab;
        POSObj.IsSplitTab             := bIsSplitTab;
        POSObj.IsLayby                := bIsLayby;
        POSObj.IsLaybyReversal        := bIsLaybyReversal;
        POSObj.IsLaybyPayment         := bIsLaybyPayment;
        POSObj.IsVoucher              := bIsVoucher;
        POSObj.IsAnyCashOut           := IsAnyCashOut;
        POSObj.isAnyPaysByVoucher     := IsAnyPaymentsByVoucher;
        POSObj.IsAnyAccountPayments   := IsAnyAccountPayments;
        POSObj.IsAnyPaymentsByCheque  := IsAnyPaymentsByCheque;
        POSObj.POSPostCode            := sPOSPCode;
        POSObj.CustPONumber           := sCustPONumber;
        POSObj.Medtype                := sMedtype;
        PosObj.MedtypeId              := iMedtypeId;
        PosObj.IsPosQuote             := bIsQuote;
        PosObj.IsPosSalesOrder        := bIsSalesOrder;
  end;

  procedure InitialiseFields;
  var
    iTermsID: integer;
    sTerms: string;
    dtDueDate: TDateTime;
  begin
    try
    ReCalcRunTot;
    if iClientID = 0 then iClientID := tcdatautils.getclientID(sClient);
    POSObj.SaleDate         := Date;
    POSObj.ShipDate         := Date;
    POSObj.TotalAmount      := RoundTo1C(rRunTotNoTax);
    POSObj.TotalAmountInc   := RoundTo1C(rRunTot);
    POSObj.TotalTax         := RoundTo1C(rRunTot - rRunTotNoTax);
    POSObj.TotalBalance     := rLaybyBal;
    POSObj.EmployeeName     := lblSalesPerson.Caption;
    POSObj.EmployeeID       := iEmployeeID;
    POSObj.PayMethod        := sPayType;
    POSObj.TimeOfSale       := lblTime.Caption;
    POSObj.Saledatetime     := POSObj.SaleDate + StrToTime(POSObj.TimeOfSale);
    POSObj.CustomerName     := sClient;
    POSObj.ClientID         := iClientID;
    POSObj.contactId        := client.MainContactIDforPOS;
    if POSObj.contactId <> 0 then
      POSObj.InvoiceToDesc    := trim(client.clientName + #13+#10+ POSObj.contactName +#13+#10+ client.BillingAddress)
    else POSObj.InvoiceToDesc    := client.BillingAddressWithName;
    POSObj.ShipToDesc       := client.StreetAddressWithName;
    POSObj.EOP_POS          := True;          // used for End-Of-Period tagging
    POSObj.ChequeNumber     := sRef;
    POSObj.Memo             := lblMemoText.Caption;
    PosObj.HoldSale         := bOnhold;
    if appenv.CompanyPrefs.CopyClientDetailsFromPOStoSalesComments then
      POSObj.Comments         := lblMemoText.Caption;
//    POSObj.LaybyID          := tcDatautils.getGlobalref('tblSales' , 'SalesId' , iLaybyID);
    POSObj.SaleClassName    := GetClassName(tcDatautils.GetTillClassID(iTillID));
    POSObj.SaleClassId      := tcDatautils.GetTillClassID(iTillID);
    POSObj.TillID           := iTillID;
    POSObj.GLAccountName    := UNDEPOSITED_FUNDS;
    POSObj.GLAccountId      := AccountID(UNDEPOSITED_FUNDS);
    POSObj.TermsName        := '';
    POSObj.DueDate          := Date;
//    POSObj.IsPaid           := not IsPOSInvoice;
    POSObj.IsPaid           := not (IsPOSInvoice or IsPOSSalesOrder or IsPosQuote);
    if bIsLaybyPayment then begin
        if assigned(client) then POSObj.POSPostCode      := client.Postcode;
    end else begin
      if (Appenv.CompanyPrefs.MustProvidePOSPostCode and (POSObj.POSPostCode='')) then begin
          fExtraDetailItem := ediPOSPostCode;
          AcceptExtraDetails;
      end else if    (Appenv.CompanyPrefs.MustProvidePOSSource and (POsObj.medtypeID=0)) then begin
          fExtraDetailItem := ediPOSSource;
          AcceptExtraDetails;
      end;
    end;
      // Exceptions to the rule
      // NOTE: if you change any of these then you will need to make correction to
      // .. the SalesType document, which documents these flags

//    if IsPOSInvoice then begin
    if IsPOSInvoice or IsPOSSalesOrder or IsPosQuote then begin
        POSObj.GLAccountName  := ACNT_ACNTS_RCV;
        POSObj.GLAccountId    := tcDataUtils.GetAccountID(ACNT_ACNTS_RCV);
//        POSObj.IsInvoice      := True;
        POSObj.IsInvoice      := IsPosInvoice;
        POSObj.IsQuote        := IsPOSQuote;
        POSObj.IsSalesOrder   := IsPOSSalesOrder;
        POSObj.IsCashSale     := False;
        POSObj.ISPos          := False;
        POSObj.EOP_POS        := False;
        tcDatautils.GetClientTerms(iClientID, iTermsID, sTerms, dtDueDate, TERMS_ON_RCPT);
        POSObj.TermsName      := sTerms;
        POSObj.DueDate        := dtDueDate;
        POSObj.TotalBalance   := RoundTo1C(rRunTot);
        if POSObj.Customer.ForcePONumOnInvoice and (POSObj.CustPONumber = '') then begin
          fExtraDetailItem := ediPOSPONumber;
          AcceptExtraDetails;
        end;
    end;

    if bIsBarTab then begin
        // To add to customer's bar tab, we set Invoice = 'T'
        POSObj.GLAccountName  := ACNT_ACNTS_RCV;
        POSObj.GLAccountId    := tcDataUtils.GetAccountID(ACNT_ACNTS_RCV);
        POSObj.IsInvoice      := True;
        POSObj.IsCashSale     := False;
    end;
      // if we are finalising a Bar Tab by creating a Sale for all the tab lines

    if bIsPayTab then begin
       // Set date and times to match the creation of the tab
        POSObj.SaleDate       := dtTabCreateDate;
        POSObj.ShipDate       := dtTabCreateDate;
        POSObj.DueDate        := dtTabCreateDate;
        POSObj.TimeOfSale     := sTabCreateTime;
        POSObj.Saledatetime   := POSObj.SaleDate + StrToTime(POSObj.TimeOfSale);
    end;
      { There are 2 instances of layby processing according to preferences TOSLaybys
        1. The layby is counted as a sale at timeOfSale
        2. The layby is only coounted as a sale when the Layby is paid out

        There are 2 layby fields
        1 Layby: Indicates that this sale is to be treated as a layby and should NOT be
          included in sales reports
        2 LaybyTOS: Indicates that this is a layby which has not yet been paid off

        It is possible to have LaybyTOS set to TRUE and Layby set to FALSE if the TOSLayby
        option is selected in preferences.

      }

    if bIsEft then begin
        // if this is a Auto EFT then Save transaction ref in the Con Note  (for now???)
        // .. at least it will make it to the lists
        POSObj.ConNote := sEftTxnRef;
    end;
      // check if this is a split payment  -- note that a layby reversal will
      // .. have 2 payments (the reversal and the original layby payment),   but
      // .. only one of these is attributed to the revesal.   It is not split!!!
    if not bIsLaybyReversal then begin
        if lstPayments.Count > 1 then begin
          POSObj.PayMethod := 'Split';
          POSObj.ChequeNumber := '';
        end;
    end;
    POSObj.PostDB;
    Except
      on E:Exception do begin
        MessageDlgXP_Vista('Saving POS Failed'+NL+NL+E.Message, mtWarning, [mbOK], 0);
      end;
    end;
  end;

begin   // PostSaleHeaderToDB
  if bIsLayby then rLaybyBal := rRunTot
  else rLaybyBal := 0.0;
  while POSObj.Count > 0 do
    POSObj.Delete;
  POSObj.New;
  InitialiseFlags;
  InitialiseFields;
  POSObj.EmployeeId := iEmployeeID;
  POSObj.PostDB;
  POSObj.OriginalDocNumber := POSObj.globalref;

  if Assigned(SignatureStream) then begin
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := POSOBJ.Connection.Connection;
      POSObj.EditDB;
      PictureStream := POSOBJ.Dataset.CreateBlobStream(TBlobField(POSOBJ.Dataset.FieldByName('ClientSignature')), bmReadWrite);
      try
        PictureStream.CopyFrom(SignatureStream,0);
      finally
        PictureStream.Free;
      end;
    finally
      qry.Free;
    end;
    FreeAndNil(SignatureStream);
  end;

  POSObj.PostDB;
end;

procedure TPOSScreenForm.PostLineItemsToDB;
var
  iRow: integer;
  Item: pLineItemRec;

  procedure PerformInsert;
  var
    rNumSingles: double;
    oInfo: TProductInfo;
    rLinePrice: currency;
  begin
    // NOTE: Add Any field changes here to SummariseSales if appropriate
    Item := lstLineItems.Items[iRow - 1];
      if Item^.IsAccountPayment then begin
        // if this is an account payment line then set amounts to zero - we don't want to post
        Item^.Amount := 0.0;
        Item^.Qty := 0;
      end;
      POSObj.Lines.New;
      POSObj.Lines.ProductId := tcDatautils.getProduct(Item^.ProductName);
      POSObj.Lines.Product_Description := Item^.ProductDescription;
      oInfo := GetProductInfo(Product.ID);
      POSObj.Lines.UnitOfMeasureID := Item^.UnitId; //GetUnitOfMeasureID(POSObj.Lines.UnitOfMeasure, oInfo.PartID);
      POSObj.Lines.UnitOfMeasure := tcdatautils.GetUOMName(Item^.UnitId);
      POSObj.Lines.LineTaxCode := Item^.TaxCode;
      rNumSingles := Item.Qty * Item^.Multiplier;
      POSObj.Lines.UOMMultiplier := Item^.Multiplier;

      if AppointID = 0 then begin
        POSObj.Lines.QtySold := rNumSingles;
        POSObj.Lines.QtyShipped := rNumSingles;
        POSObj.Lines.UOMQtySold:= Item^.Qty;
        POSObj.Lines.UOMQtyShipped:= Item^.Qty;
      end else begin
        POSObj.Lines.QtySold := AppointmentTotalHours;
        POSObj.Lines.QtyShipped := AppointmentTotalHours;
        POSObj.Lines.UOMQtySold:= AppointmentTotalHours;
        POSObj.Lines.UOMQtyShipped:= AppointmentTotalHours;
      end;
      rLinePrice := DivZer(Item^.LinePrice, POSObj.Lines.UOMMultiplier);
      POSObj.Lines.LinePrice := rLinePrice;
      POSObj.Lines.LinePriceInc := DivZer(Item^.LinePriceInc, POSObj.Lines.UOMMultiplier);

      POSObj.Lines.OriginalLinePrice := POSObj.Lines.LinePrice;
      POSObj.Lines.LineTaxRate  := Item^.TaxRate;
      POSObj.Lines.LineTaxTotal := POSObj.Lines.UOMQtyShipped * POSObj.Lines.LineTaxRate *  POSObj.Lines.LinePrice;
      POSObj.Lines.Invoiced             := True;
      POSObj.Lines.DiscountPercent      := Item^.DiscRatio*100;
      POSObj.Lines.TotalLineAmount      :=RoundCurrency(Item^.LinePrice * Item^.Qty);
      POSObj.Lines.TotalLineAmountInc   := RoundTo1C(Item^.Amount);
      POSObj.Lines.LaybyID              := GetSaleGlobalRef(Item^.LaybyId);
      POSObj.Lines.SupplierName         := GetClientName(Item^.SuppClientID);
      POSObj.Lines.Isvoucher            := Item^.IsVoucher;
      POSObj.Lines.IsRedeeming          := Item^.IsRedeeming;
      POSObj.Lines.VoucherNo            := Item^.VoucherNo;
      POSObj.Lines.BarTabId             := Item^.BarTabID;
      POSObj.Lines.BarTabLineId         := Item^.BarTablineID;
      POSObj.Lines.CustomData           := Item^.CustomData;
      POSObj.Lines.MAtrixDesc           := Item^.MatrixDesc;
      POSObj.Lines.MatrixRef            := Item^.MatrixRef;
      POSObj.Lines.MatrixPrice          := Item^.MatrixPrice;
      POSObj.Lines.GUIID                := Item^.ID;
      POSObj.Lines.GUIRelatedParentID   := Item^.RelatedParentID;
      POSObj.Lines.RelatedQtyMultiplier := Item^.RelatedQtyMultiplier;
      POSObj.Lines.RelatedParentQty     := Item^.RelatedParentQty;
      POSObj.Lines.RefundedSalesLineID  := Item^.RefundedSalesLineID;
      //POSObj.Lines.ISvoucherPay
      POSObj.Lines.PostDB;
  end;
  Procedure SaveRedeemPoints;
  var
    i:Integer;
    pRedeemPointsRec: pRedeemPoints;
  begin
    totalRedeemedAmount := 0;
    for i := 0 to lstRedeemPoints.Count - 1 do begin
      pRedeemPointsRec := lstRedeemPoints[i];
      POSObj.PosRedeemPoints.New;
      POSObj.PosRedeemPoints.SalesLinesPointsId  := pRedeemPointsRec^.SalesLinesPointsId;
      POSObj.PosRedeemPoints.PointsfromSaleId    := pRedeemPointsRec^.PointsfromSaleId;
      POSObj.PosRedeemPoints.PointsFromSalelineId:= pRedeemPointsRec^.PointsFromSalelineId;
      POSObj.PosRedeemPoints.ProductId           := pRedeemPointsRec^.ProductId;
      POSObj.PosRedeemPoints.ProductName         := pRedeemPointsRec^.ProductName;
      POSObj.PosRedeemPoints.ValueforRewardPoints:= pRedeemPointsRec^.ValueforRewardPoints;
      POSObj.PosRedeemPoints.SaleID              := POSObj.ID;
      POSObj.PosRedeemPoints.UsedPoints          := pRedeemPointsRec^.UsedPoints;
      POSObj.PosRedeemPoints.PostDB;
      totalRedeemedAmount:=totalRedeemedAmount + POSObj.PosRedeemPoints.RedeemAmount;
    end;
    if totalRedeemedAmount <> 0 then begin
      totalRedeemedPoints :=0;
      totalRedeemedAmount :=0;
      RedeemedPointsDesc := 'Points Details';
      POSObj.PosRedeemPoints.Iteraterecords(totalPointsCallback);
      if (totalRedeemedPoints <>0) or (totalRedeemedAmount <>0) then begin
        if not (POSObj.lines.Locate('ProductName' , REDEEM_POINTS , [])) then begin
          POSObj.lines.NEw;
          POSObj.lines.ProductName := REDEEM_POINTS;
          POSObj.lines.QtySold:=1;
          POSObj.lines.QtyShipped :=1;
          POSObj.lines.TotalLineAmountInc :=  0;
          POSObj.lines.Product_Description_Memo := RedeemedPointsDesc;
        end;
        POSObj.lines.TotalLineAmountInc :=  0-totalRedeemedAmount;
        POSObj.lines.PostDB;
      end;
    end;
  end;

begin  // PostLineItemsToDB
    doShowProgressbar(lstLineItems.Count, WAITMSG);
    try
      for iRow := 1 to lstLineItems.Count do begin
        try
          PerformInsert;
        except
          on E:Exception do begin
          end;
        end;
        doStepProgressbar;
        Application.ProcessMessages;
      end;
    finally
      dohideProgressbar;
    end;
    SaveRedeemPoints;

  doShowProgressbar(lstLineItems.Count, WAITMSG);
  try
    for iRow := 1 to lstLineItems.Count do begin
      Item := lstLineItems.Items[iRow - 1];
      if (Item^.LaybyId <> 0) and (Item^.LaybyAmount <> 0.0) then begin
        UpdateLaybyBalance(Item^.LaybyID, Item^.LaybyBal);
        if Item^.LaybyBal = 0.0 then begin  // if layby complete then

          // Add any completed layby's to the list
          New(LaybyItem);
          LaybyItem^.LaybyID := Item^.LaybyID;
          LaybyItem^.Amount := Item^.LaybyAmount;
          lstLaybyItems.Add(LaybyItem);
        end;
      end;
      doStepProgressbar;
      //PostRelatedtables;
    end;
  finally
      dohideProgressbar;
  end;
end;

function TPOSScreenForm.IsLineItems: boolean;
begin
  Result := lstLineItems.Count <> 0;
end;

procedure TPOSScreenForm.PrintReceipt(PrintingOnCancel:Boolean =False;PrintingOnEroror:Boolean =False);
var
  SavePrinter, NewPrinter: TPrinter;

  procedure ReceiptHeader;
    var
      abn:String;
  begin
    with oRcptPrn do begin
      if PrintingOnCancel then begin
        Justify(CJ);
        Format(char(FMT_HIGH or FMT_BOLD));
        Print('==============================');
        Print('TRANSACTION CANCELLED');
        if PrintingOnEroror then Print('ERROR PROCESSING TRANSACTION');
        Print('==============================');
        Format(char(FMT_NORMAL));
        NewLine(1);
        NewLine(1);
      end;
      Justify(CJ);
      Format(char(FMT_HIGH or FMT_BOLD));
      Print(sCompanyName);
      Format(char(FMT_NORMAL));
      NewLine(1);
      Print(sAddress + ', ' + sAddress2);
      Print(sCity);
      Print(sState + ' ' + sPostCode);
      Print(sCountry);
      abn:=AppEnv.RegionalOptions.BusinessTaxNoLabel;
      While char_length(abn)<5 do ABN:=' ' +abn;
      Print(abn +':  ' + sABN);
      Format(char(FMT_NORMAL or FMT_BOLD));

      Print(ReplicateStr(' ' , char_length(abn)-5)+ 'Phone:  ' + sPhoneNumber);
      Format(char(FMT_NORMAL));
      Print(ReplicateStr(' ' , char_length(abn)-5)+'  Fax:  ' + sFaxNumber);
      Justify(LJ);
      NewLine(1);
    end
  end;

  procedure ReceiptSaleDetails;
  begin
    with oRcptPrn do begin
      Justify(CJ);
      Format(char(FMT_NORMAL));
      PrintLine;
      Justify(LJ);
      NewLine(1);
      Print('Receipt No : ' + lblSaleNo.Caption);
      Print('Date       : ' + lblDate.Caption + '   ' + lblTime.Caption);
      Print('Store      : ' + lblStore.Caption);
      Print('Person     : ' + ExtractStrPortion(lblSalesPerson.Caption, ' ', 0));
      if iOrderNo <> 0 then begin
        Justify(CJ);
        Format(char(FMT_NORMAL));
        NewLine(1);
        Print('####################');
        Print('ORDER NO. - ' + IntToStr(iOrderNo));
        Print('####################');
        NewLine(1);
      end;
      Justify(CJ);
      Format(char(FMT_WIDE + FMT_BOLD));
      NewLine(1);
      Print(AppEnv.RegionalOptions.POSDocName);

      if bPrintReceiptCount > 1 then
        Print('DUPLICATE RECEIPT');

      Justify(LJ);
      Format(char(FMT_NORMAL));
      NewLine(2);
    end;
  end;

  Function SwapAsciiPound(const InStr:String):String;
  begin
    If (Appenv.RegionalOptions.RegionType = rUK) then
       Result := StringReplace(InStr,#163,#156,[])
    else
        Result := InStr;
  end;

  Function  concat2(Part1, Part2:String):String;
  var
    s:String;
    i:Integer ;
    ctr:Integer;
  begin
    oRcptPrn.Format(char(FMT_NORMAL));
    Setlength(s, oRcptPrn.fiWidth);
    for i := 1 to oRcptPrn.fiWidth do s[i] := ' ';

    for i := 1 to char_length(Part1) do s[i-1] := part1[i-1];

    ctr:= char_length(Part2);
    for i := char_length(s) downto char_length(s)-char_length(Part2)   do begin
      s[i-1] := part2[ctr];
      ctr:= ctr-1;
    end;
    result := s;
  end;

  procedure ReceiptLineDetails;
  var
    iRow: integer;
    sBuf: string;
    i, k, iLen: integer;
  begin
    oRcptPrn.Justify(LJ);
    oRcptPrn.Format(char(FMT_NORMAL));
    iRow := 1;
    Setlength(sBuf, oRcptPrn.fiwidth);
    while char_length(grdTrans.Cells[COL_QTY, iRow]) <> 0 do begin
      // Set line buffer to spaces
      for i := 1 to oRcptPrn.fiwidth do begin
        sBuf[i] := ' ';
      end;

      // Copy the quantiies to the line buf
      iLen := char_length(grdTrans.Cells[COL_QTY, iRow]);
      for i := 1 to iLen do begin
        sBuf[i] := grdTrans.Cells[COL_QTY, iRow][i];
      end;

      k := 0;
      while k < char_length(grdTrans.Cells[COL_DESC, iRow])-1 do begin
        if k > 0 then begin
          oRcptPrn.Print(sBuf);
          sBuf := StringOfChar(' ',oRcptPrn.fiwidth);
        end;
        // Copy the product description to the line buf
        for i := 1 to char_length(grdTrans.Cells[COL_DESC, iRow]) - k do begin
          if (i + iLen + 1) >= char_length(sBuf) then begin
            // get here if we fill past the end of the line buffer
            Break;
          end;
          sBuf[i + iLen + 1] := grdTrans.Cells[COL_DESC, iRow][k + i];
        end;
        k := k + i - 1;
        if not bPOSPrintDescriptionMultipleLines then
          Break; // don't need to print rest lines
      end;

      grdTrans.Cells[COL_AMOUNT, iRow] := TrimLeft(grdTrans.Cells[COL_AMOUNT, iRow]);
      //sBuf :=concat2(grdTrans.Cells[COL_QTY, iRow] +' ' + grdTrans.Cells[COL_DESC, iRow] , TrimLeft(grdTrans.Cells[COL_AMOUNT, iRow]));
      // if Amount is going to cut description then print description line and print amount on the next line
      if (oRcptPrn.fiwidth - char_length(TrimRight(sBuf)) - 1 < char_length(grdTrans.Cells[COL_AMOUNT, iRow])) AND bPOSPrintDescriptionMultipleLines then begin
          oRcptPrn.Print(sBuf);
          sBuf := StringOfChar(' ',oRcptPrn.fiwidth);
      end;

      // copy the amount to the end of the line buffer
      if (not (bIsLayby and AppEnv.CompanyPrefs.POSHideLaybyRcptAmnt)) and
        (not AppEnv.CompanyPrefs.POSHideSalesRcptAmnt) and
        (not bIsSplitTab) then begin
        iLen := char_length(grdTrans.Cells[COL_AMOUNT, iRow]);
        for i := iLen downto 1 do begin
          sBuf[oRcptPrn.fiwidth - (iLen - i)] := grdTrans.Cells[COL_AMOUNT, iRow][i];
        end;
        // Leave a bit of separation btw description and amount
        sBuf[oRcptPrn.fiwidth - (iLen)] := ' ';
      end;

      sBuf:= SwapAsciiPound(sBuf);
      oRcptPrn.Print(sBuf);
      Inc(iRow);
    end;
    oRcptPrn.Justify(LJ);
    oRcptPrn.Format(char(FMT_NORMAL));
  end;

  procedure ReceiptSaleSummary;
  const
    SPACES = '                       ';
  var
    pPayment: pRcptPayRec;
    i: integer;
    sPayText: string;
    TaxName:String;
  begin
    with oRcptPrn do begin
      NewLine(1);
      Format(Chr(FMT_NORMAL or FMT_BOLD));
      Justify(LJ);

      If (Appenv.RegionalOptions.RegionType = rUK) then
        TaxName  := 'VAT'
      else If (Appenv.RegionalOptions.RegionType = rAust) then
        TaxName  := 'GST'
      else
        TaxName  := 'Tax';

      if rRcptRunTot <> rRcptRunTotNoTax then begin
        sPayText := SwapAsciiPound(Combine('         Total '+TaxName, Trim(CurrToStrRJ(rRcptRunTot - rRcptRunTotNoTax, 13))));
        Print(sPayText);
      end;
      sPayText := SwapAsciiPound(Combine('         Total Amount', Trim(CurrToStrRJ(rRcptRunTot, 13))));
      Print(sPayText);

      NewLine(1);
      for i := 0 to lstRcptPayments.Count - 1 do begin
        pPayment := lstRcptPayments[i];
        Justify(LJ);
        sPayText := '         ' + pPayment^.PaymentType + ' ' + pPayment^.Ref;
        DoCR;
        // if cash and final payment
        if (pPayment^.PaymentType = PAY_CASH) and (i = lstRcptPayments.Count - 1) then begin
          Print(SwapAsciiPound(Combine(sPayText, CurrToStrRJ(pPayment^.Tendered, 13))));
          Print(SwapAsciiPound(Combine('         Change', CurrToStrRJ(rChangeGiven, 13))));
        end else begin
          Print(SwapAsciiPound(Combine(sPayText, CurrToStrRJ(pPayment^.Amount, 13))));
        end;
      end;
      Justify(CJ);
      PrintLine;
      Justify(LJ);
      Format(char(FMT_NORMAL));
    end;
  end;


  procedure ReceiptLaybySummary;
  const
    SPACES = '                       ';
  var
    TaxName:String;
  begin
    with oRcptPrn do begin
      NewLine(1);
      Format(Chr(FMT_NORMAL));
      Justify(LJ);
      If (Appenv.RegionalOptions.RegionType = rUK) then
        TaxName  := 'VAT'
      else If (Appenv.RegionalOptions.RegionType = rAust) then
        TaxName  := 'GST'
      else
        TaxName  := 'Tax';
      if (rRunTot <> rRunTotNoTax) then
        Print(SwapAsciiPound(Combine('         Total '+TaxName, CurrToStrRJ(rRunTot - rRunTotNoTax, 13))));
      Print(SwapAsciiPound(Combine('   Total Layby Amount', CurrToStrRJ(rRunTot, 13))));
      Justify(CJ);
      PrintLine;
      Justify(LJ);
      Format(char(FMT_NORMAL));
    end;
  end;

  procedure ReceiptLaybyTerms;
  var
    i: integer;
  begin
    with oRcptPrn do begin
      NewLine(1);
      Justify(CJ);
      Format(char(FMT_HIGH or FMT_BOLD));
      Print('LAYBY TERMS AND CONDITIONS');
      Justify(LJ);
      Format(char(FMT_NORMAL));
      NewLine(1);
      Print('Customer' + sClient);
      Print('Layby No: ' + lblSaleNo.Caption);
      NewLine(1);
      for i := 0 to lstLaybyTerms.Count - 1 do Print(lstLaybyTerms.Strings[i]);
      Justify(CJ);
      Format(char(FMT_NORMAL));
      PrintLine;
      Justify(LJ);
      NewLine(1);
    end
  end;

  procedure ReceiptFooter;
  var
    i: integer;
  begin
    if lstFooter.Count <> 0 then begin
      with oRcptPrn do begin
        Justify(LJ);
        Format(char(FMT_NORMAL));
        NewLine(1);
        for i := 0 to lstFooter.Count - 1 do
          If Empty(lstFooter.Strings[i]) then
            NewLine(1)
          else
            Print(lstFooter.Strings[i]);
        Justify(CJ);
        PrintLine;
        Justify(LJ);
        //        oRcptPrn.PrintNoLf(#28 + #112 + #03 + #00);  // hero bitmap
      end;
    end;
  end;

  function RedeemedPoints:Double;
  begin
    result := Round(posobj.Salesobj.redeemedPoints, Appenv.CompanyPrefs.RoundUpPoints);
  end;

  function customerPoints:Double;
  begin
    result := Round(tcdatautils.Availablerewardpoints(iclientID, date ), Appenv.CompanyPrefs.RoundUpPoints);
  end;

  function salespoints:Double;
  begin
    result := Round(posobj.Salesobj.salePoints, Appenv.CompanyPrefs.RoundUpPoints);
  end;

  Procedure ReceiptRewardPoints;
  var
    i: integer;
  begin

  {$IFDEF DevMode}
      lstRewardPoints.Text:= 'Reward Points'+chr(13) + '**** Dev Mode ****';
  {$ELSE}
      lstRewardPoints.Text:= AppEnv.CompanyPrefs.POSRewardPointTemplate;
  {$ENDIF}

    lstRewardPoints.text := StringReplace(lstRewardPoints.text , '<CustomerName>'         ,Trim(lblCustomer.Caption)    ,[rfReplaceAll]);
    lstRewardPoints.text := StringReplace(lstRewardPoints.text , '<SaleDate>'             ,FormatDateTime(FormatSettings.ShortDateformat , date) ,[rfReplaceAll]);
    lstRewardPoints.text := StringReplace(lstRewardPoints.text , '<OpeningBalancePoints>' ,floatToStr(customerPoints)   ,[rfReplaceAll]);
    lstRewardPoints.text := StringReplace(lstRewardPoints.text , '<RedeemedPoints>'       ,floatToStr(RedeemedPoints)     ,[rfReplaceAll]);
    lstRewardPoints.text := StringReplace(lstRewardPoints.text , '<SalePoints>'           ,floatToStr(salespoints)        ,[rfReplaceAll]);
    lstRewardPoints.text := StringReplace(lstRewardPoints.text , '<CompanyName>'          ,sCompanyName                           ,[rfReplaceAll]);
    if lstRewardPoints.Count <> 0 then begin
      with oRcptPrn do begin
        Justify(LJ);
        Format(char(FMT_NORMAL));
        NewLine(1);
        for i := 0 to lstRewardPoints.Count - 1 do begin
          If Empty(lstRewardPoints.Strings[i]) then
            lstRewardPoints.Strings[i]:= '';
          Print(lstRewardPoints.Strings[i]);
        end;
        Justify(CJ);
        PrintLine;
        Justify(LJ);
      end;
    end;

  end;

  procedure ReceiptMemo;
  var
    i: integer;
    sLine: string;
  begin
    if not Empty(lblMemoText.Caption) then begin
      with oRcptPrn do begin
        Format(char(FMT_NORMAL));
        Justify(LJ);
        NewLine(1);
        sLine := '';
        for i := 1 to char_length(lblMemoText.Caption) do begin
          if lblMemoText.Caption[i] = CR then begin
            Print(sLine);
            sLine := '';
          end else if lblMemoText.Caption[i] = LF then begin; // ignore
          end else begin
            sLine := sLine + lblMemoText.Caption[i];
          end;
        end;
        if not Empty(sLine) then begin
          Print(sLine);
        end;
        Format(char(FMT_NORMAL));
        NewLine(2);
        Justify(CJ);
        Printline;
      end;
    end;
  end;

begin // PrintReceipt
  if bIsEftCashOutOnly then begin
    Exit;
  end;

  if PrintPOSTemplatereport then Exit;

  try
    { we have a problem with EPSON USB printers only printing one receipt after
      each application restart .. so we create a new Printer object to use for
      each receipt. }

    NewPrinter := TPrinter.Create;
    try
      { select the same printer as currently selected in the global Printer object }
      NewPrinter.PrinterIndex := Printer.PrinterIndex;
      { replace the global printer object with our new one .. and save the old global one }
      SavePrinter := SetPrinter(NewPrinter);                                                                                //logtext('1');
      try
        if not PrintingOnEroror then Inc(bPrintReceiptCount);                                                               //logtext('2');
        oRcptPrn.OpenPort;                                                                                                  //logtext('3');
        oRcptPrn.Printercharset := edtPOSMemo.font.Charset;                                                                 //logtext('4');
        ReceiptHeader;                                                                                                      //logtext('5');
        ReceiptSaleDetails;                                                                                                 //logtext('6');
        ReceiptLineDetails;                                                                                                 //logtext('7');
        if bIsLayby then begin
          ReceiptLaybySummary;                                                                                              //logtext('8');
          ReceiptLaybyTerms;                                                                                                //logtext('9');
        end else begin
          ReceiptSaleSummary;                                                                                               //logtext('10');
        end;
        ReceiptRewardPoints;                                                                                                //logtext('11');
        ReceiptMemo;                                                                                                        //logtext('12');
        ReceiptFooter;                                                                                                      //logtext('13');
        oRcptPrn.FeedPaperForCut;                                                                                           //logtext('14');
        try
          oRcptPrn.ClosePort;                                                                                               //logtext('15');
        Except
          on E:Exception do begin
            //logtext('16:' + E.Message);
          end;
        end;
      finally
        { set global Printer object back }
        SetPrinter(SavePrinter);
      end;
    finally
      NewPrinter.Free;
    end;
  except
      on E:Exception do begin
          //logtext('17:' + E.Message);
          //if devmode then CommonLib.MessageDlgXP_Vista('Print Failed:' +E.message , mtWarning, [mbok], 0);
      end;
  end;
end;

function TPOSScreenForm.PrintPOSTemplateReport: Boolean;
begin
  result:= False;
  if (Appenv.CompanyPrefs.USBPrinterName<>'') and (Appenv.CompanyPrefs.PrintPOSTemplateReport) and (iSaleID>0) and  (POsObj.Salesobj.Id = iSaleID)  then begin
    REsult := PrintPOSTemplateReport(iSaleID , sametext(POsObj.Salesobj.classname , 'TPOSSale'));
  end;
end;

function TPOSScreenForm.PrintPOSTemplateReport(fiPOSID:Integer; IsToBesummarised:Boolean =False):Boolean;
var
  s:STring;
begin
    Result := False;
    ReportToPrint := TillPOStemplateID(iTillID); //GetDefaultReport(GetReportTypeIDForTypeName('POS - Receipt Printer'));
    if ReportToPrint = '' then ReportToPrint:= tcdatautils.GetDefaultReport('POS - Receipt Printer');
    if ReportToPrint = '' then exit;
    try
      fbReportSQLSupplied:= TRue;
      s:= '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode,' +
        ' CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO' +
        ' ~|||~{Sales}Select' +
        ' S.*, SL.*,' +
        ' if(S.IsLayby="T" , "Layby Transaction" , ' +
        ' if(S.IsLaybyPayment="T" , "Layby Payment" , ' +
        ' if(S.IsLaybyTOS="T" , "Layby Return" , ' +
        ' if(S.IsVoucher="T" , "Voucher" , ' +
        ' if(S.IsRefund="T" , "Refund" ,  ' +
        ' if(S.IsInvoice="T" , "Invoice" , ' +
        ' if(S.IsCashSale="T" , "Cash Sale" , ' +
        ' if(S.IsBarcodePicking="T" , "Bar Code Picking" , ' +
        ' if(S.IsManifest="T" , "Manifest" ,  ' +
        ' if(S.IsSalesOrder="T" , "Sales Order" , ' +
        ' if(S.IsQuote="T" , "Quote" ,"POS"))))))))))) SalesDescription,  '+
        ' sl.LinePrice * sl.UnitOfMeasureMultiplier as UOMLinePrice, ' +
        ' sl.LinePriceInc * sl.UnitOfMeasureMultiplier as UOMLinePriceInc   ' +
        ' from ' + iif(IsToBesummarised, 'tblsales_pos' , 'tblsales') +' S '+
        ' inner join ' + iif(IsToBesummarised, 'tblsaleslines_POS', 'tblsaleslines') +' SL on S.saleId = Sl.saleID'+
        ' where S.SaleId = ' + inttostr(fiPOSID);
      s := s + '~|||~{TransComments}SELECT C.CommentsID,C.Comments  FROM tblComments C'+
        '  inner join tbltranscomments TC on C.CommentsID = TC.CommentID Where TC.TransID =  ' + inttostr(fiPOSID);
      s :=  s +
        '~|||~{Payments} select PayMethod, Ref, Amount,  AmountTendered, if(AmountTendered <> 0,(AmountTendered - Amount),0) as AmountChange' +
          ' from tblsalespayments where Deleted = "F" and SaleID = ' + IntToStr(fiPOSID);
      PrintTemplateReport(ReportToPrint ,s , true , 1 , nil , Appenv.CompanyPrefs.USBPrinterName);
      Result:= True;
    Except
      on E:EXception do begin
        MessageDlgXP_Vista('Failed to Print the ''POS - Receipt Printer'' Template report.'+NL+NL+e.Message, mtWarning, [mbOK], 0);
      end;
    end;
end;

procedure TPOSScreenForm.PrnLfFn;
begin
  oRcptPrn.OpenPort;
  oRcptPrn.NewLine(1);
  oRcptPrn.ClosePort;
end;

procedure TPOSScreenForm.PrnToggleFn;
begin
  if bIsUsingReceiptPrinter then begin
    //  if AppEnv.CompanyPrefs.ReceiptPrinterON and not AppEnv.CompanyPrefs.POSCashDrawerOnly then begin
    bIsPrinterToggledOn := not bIsPrinterToggledOn;
    bPrintReceipt       := bIsPrinterToggledOn;
    SetPrnStatus(bIsPrinterToggledOn);
    IndicatePrnStatus;
  end;
end;

procedure TPOSScreenForm.GetCompanyInfo;
var
  strSQL:String;
begin
  if Appenv.CompanyInfo.count = 0 then
        CommonLib.MessageDlgXP_Vista('Error Accessing Company Information Table'#13 +
                    'Some of the Company Information will be missing from receipts',mtWarning, [mbOK], 0);

    strSQL := 'SELECT Company, Address1, Address2, city, state , Postcode, phonenumber, FaxNumber' +
              ' FROM tblPOSTills WHERE TillID = ' + IntToStr(iTillID);
    With TempMyQuery do try
        SQL.add(strSQL);
        open;
        if recordcount > 0 then begin
          sCompanyName:= Fieldbyname('Company').asString;
          sAddress    := Fieldbyname('Address1').asString;
          sAddress2   := Fieldbyname('Address2').asString;
          sCity       := Fieldbyname('City').asString;
          sState      := Fieldbyname('State').asString;
          sPostcode   := Fieldbyname('Postcode').asString;
          sPhoneNumber:= Fieldbyname('Phonenumber').asString;
          sFaxNumber  := Fieldbyname('Faxnumber').asString;
        end else begin
          sCompanyName:= Appenv.CompanyInfo.Companyname;
          sAddress    := Appenv.CompanyInfo.Address;
          sAddress2   := Appenv.CompanyInfo.Address2;
          sCity       := Appenv.CompanyInfo.City;
          sState      := Appenv.CompanyInfo.State;
          sPostcode   := Appenv.CompanyInfo.Postcode;
          sPhoneNumber:= Appenv.CompanyInfo.Phonenumber;
          sFaxNumber  := Appenv.CompanyInfo.Faxnumber;
        end;
    finally
        if active then close;
        Free;
    end;
    sCountry    := Appenv.CompanyInfo.Country;
    sABN        := Appenv.CompanyInfo.Abn;

    try
        bMultiSalesMan      := AppEnv.CompanyPrefs.MultiSalesPerson;
        bMultiTills         := AppEnv.CompanyPrefs.MultiTills;
        //iRoundUp            := AppEnv.CompanyPrefs.RoundUp;
        sPrnDev             := AppEnv.CompanyPrefs.ReceiptPrinterPort;
        sPrnType            := AppEnv.CompanyPrefs.ReceiptPrinterType;
        sPrnname            := AppEnv.CompanyPrefs.USBPrintername;
        lstLaybyTerms.Text  := AppEnv.CompanyPrefs.LaybyTerms;
        {$IFDEF DevMode}
          lstFooter.Text      := 'Refund Policy'+chr(13) + '**** Dev Mode ****';
          lstRewardPoints.Text:= 'Reward Points'+chr(13) + '**** Dev Mode ****';
        {$ELSE}
          lstFooter.Text      := AppEnv.CompanyPrefs.ReceiptFooter;
          lstRewardPoints.Text:= AppEnv.CompanyPrefs.POSRewardPointTemplate;
        {$ENDIF}
        if AppEnv.CompanyPrefs.MaxDiscountPercentage <= AppEnv.Employee.EmployeemaxDiscountPercentage then
          sDiscTooBig         := 'Max Percentage Discount ( %' + FloatToStr(AppEnv.CompanyPrefs.MaxDiscountPercentage * 100) + ') Exceeded'
        else
          sDiscTooBig         := 'Max Employee Percentage Discount ( %' + FloatToStr(AppEnv.Employee.EmployeemaxDiscountPercentage * 100) + ') Exceeded';
    except
        CommonLib.MessageDlgXP_Vista('Error Accessing Company Preferences Table'#13 +
                   'Will default to Printer:ON, Type: STAR, and COM1:',
                   mtWarning, [mbOK], 0);
    end;


end;

function TPOSScreenForm.LockAllTills(QryTills: TErpQuery): Boolean;
begin
  result := true;
  if QryTills.recordcount=0 then exit;

  with TUSerLock.Create(Self) do try
    QryTills.first;
    While QryTills.eof = False do begin
      if not Lock('tblpostills' , QryTills.fieldbyname('tillID').asInteger, 'POS-Till-EOP') then begin
        MessageDlgXP_Vista('EOP Cannot be Performed.' +chr(13) +chr(13) +
                          replacestr(replacestr(LockMessage,'Unable to update data.' + #13#10 , '') , 'accessing this record' , 'Accessing Till ' + Qrytills.fieldbyname('tillname').asString) ,
                          mtwarning, [mbok] , 0);
        result := False;
        exit;
      end;
      QryTills.NExt;
    end;
  finally
    if not result then begin
      unlockallTills;
    end;
    Free;
  end;

end;

procedure TPOSScreenForm.LockFn;
begin
  if not bIsLocked then begin
    bIsLocked  := true;
    iLockedRow := oPOSBtnMatrix.SelRow;
    iLockedCol := oPOSBtnMatrix.SelCol;
    if not Empty(oPOSBtnMatrix.Selected.HotKey.Caption) then begin // To Stop Empty HotKey Error
      iLockedHotKey := oPOSBtnMatrix.Selected.HotKey.Caption[1];
    end else begin
      iLockedHotKey := #0;
    end;
    sLockedLine1 := edtPOSMemo.Lines[0];
    sLockedLine2 := edtPOSMemo.Lines[1];
    ClearInputMemo;
    edtPOSMemo.Lines.Add('Keyboard Locked');
  end else begin
    bIsLocked := false;
    ClearInputMemo;
    edtPOSMemo.Lines.Add(sLockedLine1);
    edtPOSMemo.Lines.Add(sLockedLine2);
    TopOfViewer;
  end;
end;




procedure TPOSScreenForm.ChgPadFn;
var
  iOldKeypadID: integer;
begin
  try
    if not (csDestroying in Self.ComponentState) then begin
      iOldKeypadID := oPOSBtnMatrix.KeypadID;
      oPOSBtnMatrix.KeypadID := oPOSBtnMatrix.Selected.Func.SubFn;
      if oPOSBtnMatrix.LoadFromDB() then begin
        oPOSBtnMatrix.RemoveStars;
        bKeyPadChange := true;
      end else begin
        CommonLib.MessageDlgXP_Vista('This Keypad is not Active', mtWarning, [mbOK], 0);
        oPOSBtnMatrix.KeypadID := iOldKeypadID;
        oPOSBtnMatrix.LoadFromDB;
        oPOSBtnMatrix.RemoveStars;
      end;
    end;
  except
  end;
end;

procedure TPOSScreenForm.ChoosenPrintsale;
begin
  OpenERPListFormSingleselectModal('TPOSListGUI' , DoPrintSale);
end;
procedure TPOSScreenForm.DoPrintSale(Sender:TwwDbGrid);
begin
  PrintPOSTemplateReport(Sender.DataSource.DataSet.FindField('SAleID').AsInteger , Sender.DataSource.DataSet.FindField('ISInPOS').AsBoolean);
end;
procedure TPOSScreenForm.PrintEOPProductGroupreport(const TillIDs:String);
var
  s:String;
  reportName:String;
begin
  if not Appenv.companyprefs.PrintEOPProductGroupreport then exit;
  reportName := tcdatautils.GetDefaultReport('Sales Collated by Item');
  s:= SalesCollatedByItemReportSQL(TillIds , reportname);
  fbReportSQLSupplied := True;
  PrintTemplateReport(reportName, s , False, 1);
end;
procedure TPOSScreenForm.EOPFn(All: boolean);
  // performs End Of Day stuff
var
  qryPOSFlag: TERPCommand;
  qry: TERPCommand;
  sReportName: string;
  mrResult: integer;
  sTempTblName: string;
  sQMessage: string;
  qryTills: TERPQuery;
  QtyExRounding: integer;
  NumOfTransactions: integer;
  frmCashierEOP: TComponent;
  Templates :TReportTemplates;
  UserCount: integer;
  iPeriodID:Integer;

  procedure CreateTempPaymentsTable;
  var
    qry: TERPCommand;
  begin
    sTempTblName := 'tmp_tblposeoppayments_' + IntToStr(iTillID);

    qry := TERPCommand.Create(nil);
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    try
      // delete previos temp table, if exists
      qry.Sql.Add('DROP TABLE IF EXISTS ' + sTempTblName + '; ');
      qry.Execute;

      // create temp payments table
      qry.Sql.Clear;

      qry.SQL.Add(' CREATE TABLE ' + sTempTblName + ' ( ');
      qry.SQL.Add('  `ID` int(10) NOT NULL auto_increment, ');
      qry.SQL.Add('  PRIMARY KEY  (`ID`)) ');
      qry.Sql.Add('SELECT p.PayMethod, p.Amount from tblSalesPayments as p ' +
        'INNER JOIN tblSales ' +
        'ON p.SaleID = tblSales.SaleID ' +
        'where IsLayby <> "T" AND IsInvoice <> "T" and tblSales.Deleted <> "T" and ' +
        'p.Deleted <> "T" and POS = "T" ' +
        'AND TillID = ' + IntToStr(iTillID));
      qry.SQL.Add('UNION ALL');
      qry.Sql.Add('SELECT PayMethod, Amount from tblPosEopPayments ' +
        'WHERE TillID = ' + IntToStr(iTillID));
      qry.Execute;

    finally
      FreeAndNil(qry);
    end;
  end;

  procedure DeleteTempPaymentsTable;
  var
    qry: TERPCommand;
  begin
    sTempTblName := 'tmp_tblposeoppayments_' + IntToStr(iTillID);

    qry := TERPCommand.Create(nil);
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    try
      // delete previos temp table, if exists
      qry.Sql.Add('DROP TABLE IF EXISTS ' + sTempTblName + '; ');
      qry.Execute;

    finally
      FreeAndNil(qry);
    end;
  end;
Procedure PrintEOPReport1;
  begin
    sReportName := 'Pos - Summary';
    Templates := TReportTemplates.Create;
    with Templates do try
                    if not CreatedOk then exit;
                    with GetMyQuery(1) do begin
                      Close;
                      GetSQLForReport(sReportName); // creates  report stream
                      Sql.Clear;
                      Sql.Add('SELECT Count(*) AS NumOfTrans FROM tblSales ' +
                        'WHERE IsLayby = "F" AND Deleted = "F" ' +
                        'AND POS = "T" ' + 'AND TillID = ' + IntToStr(iTillID));
                      Open;
                      NumOfTransactions := FieldByName('NumOfTrans').AsInteger;

                      Sql.Clear;
                      Sql.Add('SELECT "Net Sales" as Title, Count(*) as NumOfTrans, ' +
                        '"        " as Percent, SUM(Shipped) as Qty, ' +
                        'Concat(' + QuotedStr(AppEnv.RegionalOptions.CurrencySymbol) + ',Format(SUM(TotalLineAmountInc),2)) as AmountInc, ' +
                        '"       " as Percent2, ' +

                        'Concat(' +  QuotedStr(AppEnv.RegionalOptions.CurrencySymbol) + ',Format(SUM(TotalLineAmount),2)) as AmountEx, "       " as Percent3, ' +
                        '"1" as Dummy, ' + QuotedStr(lblTillName.Caption) + ' as Till, ' +
                        'ProductName,ProductPrintName ' +
                        'from tblSalesLines INNER JOIN tblSales ' +
                        'ON tblSalesLines.SaleID = tblSales.SaleID ' +
                        'where IsLayby = "F" and tblSales.Deleted = "F" ' +
                        'and tblSalesLines.Deleted = "F" and POS = "T" ' +
                        'AND TillID = ' + IntToStr(iTillID) + ' AND ProductName <> '+QuotedStr(PART_ROUNDING)+' GROUP BY Title');
                      Open;
                      QtyExRounding := FieldByName('Qty').AsInteger;

                      Sql.Clear;
                      Sql.Add('SELECT "                           " as Title, ' +
                        '"          " as NumOfTrans, "        " as Percent, ' +
                        '"        " as Qty, ' +
                        '"            " as AmountInc, "       " as Percent2, ' +
                        '"            " as AmountEx, "       " as Percent3, ' +
                        '"1" as Dummy, ');
                      Sql.Add(QuotedStr(lblTillName.Caption) +
                        'as Till');//from tblSalesLines ');
                      Sql.Add('UNION ');

                      // net sales
                      Sql.Add('SELECT "Net Sales" as Title, ' + IntToStr(NumOfTransactions) + ' as NumOfTrans, ' +
                        '"        " as Percent, ' + IntToStr(QtyExRounding) + ' as Qty, ' +
                        'Concat(' +  QuotedStr(AppEnv.RegionalOptions.CurrencySymbol) + ',Format(SUM(TotalLineAmountInc),2)) as AmountInc, ' +
                        '"       " as Percent2, ' +
                        'Concat(' +  QuotedStr(AppEnv.RegionalOptions.CurrencySymbol) + ',Format(SUM(TotalLineAmount),2)) as AmountEx, "       " as Percent3, ' +
                        '"2" as Dummy, ' + QuotedStr(lblTillName.Caption) + ' as Till ' +
                        'from tblSalesLines INNER JOIN tblSales ' +
                        'ON tblSalesLines.SaleID = tblSales.SaleID ' +
                        'where IsLayby = "F" and tblSales.Deleted = "F" ' +
                        'and tblSalesLines.Deleted = "F" and POS = "T" ' +
                        'AND TillID = ' + IntToStr(iTillID) + ' GROUP BY Title');
                      Sql.Add(' UNION ');

                      // blank line
                      Sql.Add('SELECT "" as Title, "" as NumOfTrans, "" as Percent, ' +
                        '"" as Qty, "" as AmountInc, "" as Percent2, ' +
                        '"" as AmountEx, "" as Percent3, "3" As Dummy, ' +
                        '' + QuotedStr(lblTillName.Caption) + ' as Till ');//from tblSalesLines ');
                      Sql.Add(' UNION ');

                      // taxable sales
                      Sql.Add('SELECT "Taxable Sales" as Title, "" as NumOfTrans, ' +
                        '" " as Percent, " " as Qty, ' +
                        'Concat(' +  QuotedStr(AppEnv.RegionalOptions.CurrencySymbol) + ',Format(SUM(TotalLineAmountInc),2)) as AmountInc, "100%" as Percent2, ' +
                        'Concat(' +  QuotedStr(AppEnv.RegionalOptions.CurrencySymbol) + ',Format(SUM(TotalLineAmount),2)) as AmountEx, "100%" as Percent3, ' +
                        '"4" as Dummy, ' + QuotedStr(lblTillName.Caption) + ' AS Till ' +
                        ' from tblSalesLines INNER JOIN tblSales ' +
                        'ON tblSalesLines.SaleID = tblSales.SaleID ' +
                        'where IsLayby = "F" and tblSales.Deleted = "F" and ' +
                        'tblSalesLines.Deleted = "F" and POS = "T" and ' +
                        'LineTaxRate <> 0.0 AND TillID = ' + IntToStr(iTillID));
                      Sql.Add(' UNION  ');

                      // Tax Collected
                      Sql.Add('SELECT "Tax Collected" as Title, "" as NumOfTrans, ' +
                        '"" as Percent, "" as Qty, "" as AmountInc, "" as Percent2, ' +
                        'Concat(' +  QuotedStr(AppEnv.RegionalOptions.CurrencySymbol) + ',Format((SUM(LineTax)*100/100),2)) as AmountEx, ' +
                        '"10%" as Percent3, "5" as Dummy, ' + QuotedStr(lblTillName.Caption) + ' as Till ' +
                        ' from tblSalesLines ' +
                        'INNER JOIN tblSales ' +
                        'ON tblSalesLines.SaleID = tblSales.SaleID ' +
                        'where IsLayby = "F" and tblSales.Deleted = "F" and ' +
                        'tblSalesLines.Deleted = "F" and POS = "T" and ' +
                        'TillID = ' + IntToStr(iTillID));
                      Sql.Add(' UNION  ');

                      // Account Payments
                      Sql.Add('SELECT "Account Payments" as Title, Count(*) as NumOfTrans, ' +
                        '"" as Percent, " " as Qty, ' +
                        'Concat(' +  QuotedStr(AppEnv.RegionalOptions.CurrencySymbol) + ',Format(SUM(Amount),2)) as AmountInc, ' +
                        '"" as Percent2, ' +
                        '"" as AmountEx, "       " as Percent3, ' +
                        '"6" as Dummy, ' + QuotedStr(lblTillName.Caption) + ' as Till ' +
                        'from tblPosEopPayments ' +
                        'WHERE TillID = ' + IntToStr(iTillID) + ' GROUP BY Title');
                      Sql.Add(' UNION ');

                      // blank line
                      Sql.Add('SELECT "" as Title, "" as NumOfTrans, ' +
                        '"" as Percent, "" as Qty, ' +
                        '"" as AmountInc, "" as Percent2, ' +
                        '"" as AmountEx, "" as Percent3, "7" As Dummy, ' + QuotedStr(lblTillName.Caption) + ' As Till ');
                      Sql.Add(' UNION ');

                      // payments
                      Sql.Add('SELECT PayMethod as Title, Count(*) as NumOfTrans, ' +
                        '"" as Percent, "" as Qty, ' +
                        'Concat(' +  QuotedStr(AppEnv.RegionalOptions.CurrencySymbol) + ',Format(SUM(Amount),2)) as AmountInc, "" as Percent2, ' +
                        '"" as AmountEx, "" as Percent3, "8" as Dummy, ' + QuotedStr(lblTillName.Caption) + ' as Till ' +
                        'FROM ' + sTempTblName +
                        ' GROUP BY PayMethod UNION ');

                      // total in drawer
                      Sql.Add('SELECT "Total in Drawer" as Title, "" as NumOfTrans,  ' +
                        '"" as Percent, "" as Qty, ' +
                        'Concat(' +  QuotedStr(AppEnv.RegionalOptions.CurrencySymbol) + ',Format(SUM(Amount),2)) as AmountInc, "" as Percent2, ' +
                        '"" as AmountEx, "" as Percent3, "9" As Dummy, ' + QuotedStr(lblTillName.Caption) + ' as Till ' +
                        'FROM ' + sTempTblName);
                      Open;
                      Application.ProcessMessages;
                    end;

                    Report.Template.LoadFromStream(ReportStream);
                    Report.ShowPrintDialog := AppEnv.Employee.ShowPrintDialog;

                    if ALL then Report.DeviceType := 'Printer';

                    Try
                      Report.Print;
                    except
                      on E: Exception do begin
                        If Sysutils.SameText(E.Message,'Screen printer does not support printing') then begin
                          CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
                        end else
                          raise;
                      end;
                    end;

                    Application.ProcessMessages;
                  finally
                    FreeandNil(Templates);
                  end;
  end;
  Procedure PrintEOPreport2;
  begin
    if not All then CommonLib.MessageDlgXP_Vista('Click OK to print EOP Product Sales Report', mtInformation, [mbOK], 0);

                // Print Sale Report

                sReportName := 'Pos';
                Templates := TReportTemplates.Create;
                with Templates do try
                    if not CreatedOk then exit;
                    with GetMyQuery(2) do begin
                      Close;
                      GetSQLForReport(sReportName); // creates report stream
                      Sql.Clear;
                      Sql.Add('SELECT SaleDate, TimeOfSale, tblSales.GlobalRef, ' +
                        'TotalLineAmountInc, PayMethod, ProductName, ProductPrintName, QtySold,Product_Description, ' +
                        QuotedStr(lblTillName.Caption) + ' AS TillName ' +
                        'from tblSalesLines INNER JOIN tblSales ' +
                        'ON tblSalesLines.SaleID = tblSales.SaleID ' +
                        'where IsLayby = "F" and POS = "T" ' +
                        'AND TillID = ' + IntToStr(iTillID));
                      Open;
                      Application.ProcessMessages;

                    end;

                    Report.Template.LoadFromStream(ReportStream);
                    Report.ShowPrintDialog := AppEnv.Employee.ShowPrintDialog;

                    if ALL then Report.DeviceType := 'Printer';

                    Try
                      Report.Print;
                    except
                      on E: Exception do begin
                        If Sysutils.SameText(E.Message,'Screen printer does not support printing') then begin
                          CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
                        end else
                          raise;
                      end;
                    end;

                    Application.ProcessMessages;

                  finally
                    FreeandNil(Templates);
                  end;
  end;
  Procedure PrintEOPReport3;
  begin
                if not AppEnv.CompanyPrefs.UseBlindBalance then begin
                    if not All then CommonLib.MessageDlgXP_Vista('Click OK to print Daily Balance Work Sheet', mtInformation, [mbOK], 0);

                    // Print Daily Balance Work Sheet
                    sReportName := 'Pos - Cash';
                    Templates := TReportTemplates.Create;
                    with Templates do try
                        if not CreatedOk then exit;
                        with GetMyQuery(1) do begin
                          GetSQLForReport(sReportName); // creates  report stream
                          Close;
                          Sql.Clear;
                          SQL.add(companyInfoSQL('',0,0,False , ',CONCAT(CompanyName, " - ", "' +  lblStore.Caption +'") AS Company, ' + QuotedStr(lblTillName.Caption) +' AS Till'));
                          Open;
                          Application.ProcessMessages;
                        end;
                        with GetMyQuery(2) do begin
                          GetSQLForReport(sReportName); // creates  report stream
                          Close;
                          Sql.Clear;
                          Sql.Add(POSTillEOPConfigSQL('', '', False));
                          Open;
                          Application.ProcessMessages;
                        end;

                        Report.Template.LoadFromStream(ReportStream);
                        Report.ShowPrintDialog := AppEnv.Employee.ShowPrintDialog;

                        if ALL then Report.DeviceType := 'Printer';

                        Try
                          Report.Print;
                        except
                          on E: Exception do begin
                            If Sysutils.SameText(E.Message,'Screen printer does not support printing') then begin
                              CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
                            end else
                              raise;
                          end;
                        end;

                        Application.ProcessMessages;
                    finally
                      FreeandNil(Templates);
                    end;
                  end;
  end;
  Procedure PrintEOPReport4;
  begin
      if AppEnv.CompanyPrefs.UseCashDrop  then begin
                   if hasCashDropsforPeriod(iPeriodID) then begin
                      if not All then CommonLib.MessageDlgXP_Vista('Click OK to print Cash Drop Report', mtInformation, [mbOK], 0);
                    sReportName := 'Cash Drops';
                    Templates := TReportTemplates.Create;
                    with Templates do try
                        if not CreatedOk then exit;
                        with GetMyQuery(1) do begin
                          GetSQLForReport(sReportName); // creates  report stream
                          Close;
                          Sql.Clear;
                          SQL.Add(companyInfoSQL('',0,0,False));
                          Open;
                          Application.ProcessMessages;
                        end;
                        with GetMyQuery(2) do begin
                          GetSQLForReport(sReportName); // creates  report stream
                          Close;
                          Sql.Clear;
                          Sql.Add('Select CD.CashDropAt, ' +
                                  ' E.employeename, ' +
                                  ' T.tillname, ' +
                                  ' EOP.StartDate, ' +
                                  ' EOP.EndDate, ' +
                                  ' CD.Amount ' +
                                  ' from tblcashdrop CD ' +
                                  ' inner join tblposeop EOP on CD.EOP_Id = EOP.PeriodID ' +
                                  ' inner join tblemployees E on E.employeeId = CD.employeeId ' +
                                  ' inner join tblPOSTills T on CD.tillId = T.tillID ' +
                                  ' Where EOP.PeriodID = ' + inttostr(iPeriodID));
                          Open;
                          Application.ProcessMessages;
                        end;
                        Report.Template.LoadFromStream(ReportStream);
                        Report.ShowPrintDialog := AppEnv.Employee.ShowPrintDialog;

                        if ALL then Report.DeviceType := 'Printer';

                        Try
                          Report.Print;
                        except
                          on E: Exception do begin
                            If Sysutils.SameText(E.Message,'Screen printer does not support printing') then begin
                              CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
                            end else
                              raise;
                          end;
                        end;

                        Application.ProcessMessages;
                    finally
                      FreeandNil(Templates);
                    end;
                   end;
                end;
      end;
begin
  sQMessage:= '';
  try
    if not IsLineItems() and IsAccessAllowed('FnEOP') and idOk() then begin
      sQMessage := 'Do you wish to Continue End Of Period On This Till ?';
      //### Traffic Pro ########
      if AppEnv.CompanyPrefs.UseTrafficMonitor then begin
//        MonitorTraffic;
      end;

      //### Check No Forms Open Or Connection ########
      if All then begin
        MyConnection.Disconnect;
        if MainForm.RemoveAllConnectionsToDB('TPOSScreenForm') then begin
          UserCount:= AppEnv.UtilsClient.GetLoggedOnUserCount(AppEnv.AppDb.Database);
          if UserCount > 1 then  begin
            MainForm.GetCurrentUserCount; //populate dlgCurrentUsers
            dtmMainGUI.dlgCurrentUsers.Caption := CommonDbLib.GetActiveDatabaseName + ' End Of Period';
            dtmMainGUI.dlgCurrentUsers.Color := $00D7F5FF;
            dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
            dtmMainGUI.dlgCurrentUsers.Execute;
            Exit;
          end
          else if UserCount < 0 then begin
            MessageDlgXP_Vista('Unable to retrieve list of logged on users at this time, unable to perform End of Period.', mtInformation, [mbOk], 0);
            exit;
          end;

        end
        else begin
          Exit;
        end;
        //qryProduct.Connection := CommonDbLib.GetSharedMyDacConnection;
  //      ftblSalesLinesDetails.Connection := CommonDbLib.GetSharedMyDacConnection;
        MyConnection.Connect;
      end else begin

      end;

      if (CommonLib.MessageDlgXP_Vista(sQMessage, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
        qryTills := TERPQuery.Create(nil);
        qryTills.Options.FlatBuffers := True;
        qryTills.Connection := CommonDbLib.GetSharedMyDacConnection;
        try
          qryTills.SQL.Clear;
          qryTills.SQL.Add('SELECT TillID, tillname FROM tblpostills WHERE Active="T" ');
          if not All then qryTills.SQL.Add('AND TillID=' + IntToStr(iTillID));
          qryTills.Open;
          qryTills.First;
          PrintEOPProductGroupreport(qryTills.GroupConcat('TillID'));
          if LockAlltills(qryTills) then try
            qryTills.First;
            while not qryTills.Eof do begin
                iTillID := qryTills.Fields[0].AsInteger;
                lblTillName.Caption := qryTills.Fieldbyname('tillname').asString;
                UnSetBarTabsConvertStarted;
                //### Bar Tab Invoices ########
                if AppEnv.CompanyPrefs.POSSummarise and IsAnyBarTabs() AND not HasBarTabsConvertStarted then begin
                  mrResult := CommonLib.MessageDlgXP_Vista('Current Bar Tab transactions exist.' + #13 + #10 +
                    'Do you wish to Create Invoices for them?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);

                  if All then mrResult := mrYes;
                  if mrResult = mrCancel then Exit;
                  if mrResult = mrYes then begin
                    if not HasBarTabsConvertStarted then begin
                      SetBarTabsConvertStarted;
                      try GenerateAllBarTabInvoices;finally UnSetBarTabsConvertStarted; end;
                    end;
                  end;
                end;

                iPeriodID := SavePeriodDetails;   //Save period details for eop report form
                if AppEnv.CompanyPrefs.POSSummarise then begin
                  SummariseSales;
                end;
                CreateTempPaymentsTable;

                if AppEnv.CompanyPrefs.UseBlindBalance then begin
                            //Blind Balance
                  frmCashierEOP := GetComponentByClassName('TfrmPOSCashierEOP',false);
                  if not assigned(frmCashierEOP) then exit;
                  with  TfrmPOSCashierEOP(frmCashierEOP) do begin
                    EmployeeID := AppEnv.Employee.EmployeeID;
                    EmployeeName := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
                    TillID := iTillID;
                  end;
                  if TForm(frmCashierEOP).ShowModal = mrCancel then begin
                    CommonLib.MessageDlgXP_Vista('The current Period will not be terminated.', mtInformation, [mbOK], 0);
                    exit;
                  end;
                end else begin
                //### Print Summary Report ########
                  PrintEOPReport1;
                  PrintEOPReport2;
                end;
                PrintEOPreport3;
                PrintEOPReport4;
                DeleteTempPaymentsTable;
                qryTills.Next;
            end;
              qryTills.First;
              while not qryTills.Eof do begin
                iTillID := qryTills.Fields[0].AsInteger;
                lblTillName.Caption := qryTills.Fieldbyname('tillname').asString;

                // Remove POS flag from all sales
                qryPOSFlag := TERPCommand.Create(nil);
                qryPOSFlag.Connection := CommonDbLib.GetSharedMyDacConnection;
                try
                  with qryPOSFlag do begin
                    SQL.Clear;
                    // Remove POS flag
                    SQL.Add('UPDATE tblSales SET POS = "F" WHERE POS = "T" ' +
                      'AND TillID = ' + IntToStr(iTillID)+';');
                    Execute;
                  end;
                finally
                  FreeandNil(qryPOSFlag);
                end;
                // remove all payments for this till in the POS EOP Payments table
                // .. this table currently holds customer Account Payments ONLY
                qry := TERPCommand.Create(nil);
                qry.Connection := CommonDbLib.GetSharedMyDacConnection;
                try
                  with qry do begin
                    SQL.Clear;
                    SQL.Add('DELETE FROM tblposeoppayments  WHERE TillID = ' + IntToStr(iTillID));
                    Execute;
                    // delete the temp table
                    qry.Sql.Clear;
                    qry.Sql.Add('DROP TABLE IF EXISTS ' + sTempTblName);
                    qry.Execute;
                  end;
                finally
                  FreeAndNil(qry);
                end;
                qryTills.Next;
              end;
              self.HideLocalProgressbar;
              CommonLib.MessageDlgXP_Vista('End of Period Complete.', mtInformation, [mbOK], 0);
          finally
             unlockalltills;
          end;
          finally
            FreeandNil(qryTills);
          end;
        //end;
      end;
    end;
  except
    on e: exception do begin
      if Pos('Lock wait timeout',e.Message) > 0 then begin
        CommonLib.MessageDlgXP_Vista('Unable to process POS end of period.' + #10#13 + #10#13 +
          'Sales records used by POS are locked by other open transactions in ERP.' + #10#13 +
          'POS will now close, please try again shortly.', mtInformation, [mbOK], 0);
        if MyConnection.intransaction then MyConnection.Rollback;
        CrashOut:= true;
        Close;
      end
      else begin
        raise;
      end;
    end;
  end;
end;

procedure TPOSScreenForm.MainPadFn;
begin
  // Revert back to primary keypad if required
  if not bKeyPadChange then begin
    if oPOSBtnMatrix.KeypadID <> iPrimaryPad then begin
      oPOSBtnMatrix.KeypadID := iPrimaryPad;
      oPOSBtnMatrix.LoadFromDB;
      oPOSBtnMatrix.RemoveStars;
    end;
  end else begin
    bKeyPadChange := false;
  end;
end;

procedure TPOSScreenForm.TrainModeFn;
begin
  if bIsTraining then begin
    CommonLib.MessageDlgXP_Vista('You have chosen to Leave Training Mode. ' +
      'Transactions will be posted from now on.',
      mtWarning, [mbOK], 0);
    edtPOSMemo.Color     := clWindow;
    lblSaleNo.Font.Color := clBlack;
    lblSaleNo.Caption    := '';
    bIsTraining          := false;
  end else begin
    CommonLib.MessageDlgXP_Vista('You have entered Training Mode. ' +
      'No transactions will be posted from now on.',
      mtWarning, [mbOK], 0);
    edtPOSMemo.Color     := clYellow;
    lblSaleNo.Font.Color := clRed;
    lblSaleNo.Caption    := 'TRAINING MODE';
    bIsTraining          := true;
  end
end;

procedure TPOSScreenForm.PrintInvFn;
var
  DefaultCashSaleTemplate: string;
begin
  // Print Invoice
  if not AppEnv.CompanyPrefs.POSSummarise then begin
    if bTransComplete then begin
      with TReportTemplates.Create do try
          if not CreatedOk then exit;
          with GetMyQuery(1) do begin
            Close;
            DefaultCashSaleTemplate :=TillA4templateID(iTillID);
            if DefaultCashSaleTemplate = '' then DefaultCashSaleTemplate := tcdatautils.GetDefaultReport(6); //6 = Cash Sale Template Type
            Sql.Add(GetSQLForReport(DefaultCashSaleTemplate));
            Sql.Add(Format(' AND d2.SaleID = %d', [iSaleID]));
            Open;
          end;
          Report.Template.LoadFromStream(ReportStream);
          Report.ShowPrintDialog := AppEnv.Employee.ShowPrintDialog;
          Report.DeviceType := dtPrinter;

          Try
            fbReportSQLSupplied := False;
            Self.PrintTemplateReport(DefaultCashSaleTemplate,'AND SaleID = ' + IntToStr(iSaleID)+  {SQL}
                                                              '~|||~ WHERE TTC.SaleID = ' + IntToStr(iSaleID)+ {TaxDetails}
                                                              '~|||~ and Trans.SaleID= ' + IntToStr(iSaleID)+ {ClientCustomFields}
                                                              '~|||~ where TC.Transtype = ' + quotedstr('POS')+' and TC.TransId = ' + inttostr(iSaleID)+ {TRanscomments}
                                                              '~|||~ and SaleID= ' + IntToStr(iSaleID)+{Payments}
                                                              '~|||~ WHERE SL.SaleID= ' + IntToStr(iSaleID)+{FormulaDetails}
                                                              ''{columnHeadings},
                                                              not(appEnv.Employee.PreviewAllreport) and not(Devmode),1 );
         //   Report.Print;
          except
            on E: Exception do begin
              If Sysutils.SameText(E.Message,'Screen printer does not support printing') then begin
                CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
              end else
                raise;
            end;
          end;

        finally
          Free;
        end;
    end else
      MessageDlgXP_Vista('You have to Complete the transaction to Print it', mtInformation, [mbOK], 0);
  end else begin
    CommonLib.MessageDlgXP_Vista('You Must have Summarised POS preference OFF to use this Print function', mtWarning, [mbOK], 0);
  end;
end;

procedure TPOSScreenForm.SalesListAfterShow(Sender: TObject);
begin
  (Sender as TForm).FormStyle := fsStayOnTop;
  if iClientId > 0 then
  begin

    TERPQuery((Sender as TBaseListingGui).qryMain).Filter := '(ClientId = ' + IntToStr(iClientId) + ')';
    TERPQuery((Sender as TBaseListingGui).qryMain).Filtered := true;

//  (Sender as TBaseListingGui).Customfilter.Addfilter('ClientId = ' + IntToStr(iClientId), AndFilter);
  end;

  (Sender as TBaseListingGui).SearchMode := smFullList;
  HookListForm(Sender as TBaseListingGui);
end;

function TPOSScreenForm.SalesmanFn: boolean;
var
//  qry: TERPQuery;
  sPwd: string;
  bOk: boolean;
  iCode: integer;
  strSQL:STring;
  Qry:TERPQuery;
//  iPreviousCashierID: integer;
begin
 // iPreviousCashierID :=  Self.iEmployeeID;
  sPwd := '';
  bOk := false;
  Result := false;
  if AppEnv.CompanyPrefs.MultiSalesPerson AND AppEnv.CompanyPrefs.POSPassword  then begin
    SetPOSScreenActive;
  {$IFDEF DevMode}
      sPwd :=appenv.Employee.LogonPassword;
  {$ELSE}
    if dlgPassword.Execute then begin
      sPwd := dlgPassword.InputResult;
    end;
  {$ENDIF}

    if not Empty(sPwd) then begin
      sPwd := Encrypt(sPwd, 'z');
      strSQL := 'SELECT Emp.EmployeeID, Concat(FirstName," ", LastName) as Name ' +
            'FROM tblEmployees as Emp LEFT JOIN tblPassword ' +
            'ON Emp.EmployeeID = tblPassword.EmployeeID ' +
            'WHERE Logon_Password = ' + quotedstr(sPwd) + ' AND Active = "T"';

      //with tcdatautils.Datautilsdataset(strSQL) do begin
      Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
      try
        if Qry.active then Qry.Close;
        Qry.SQL.Text :=strSQL;
        Qry.open;

        if Qry.recordcount > 0 then begin
            Result := true;
            lblSalesPerson.Caption := Qry.FieldByName('Name').AsString;
            Self.iEmployeeID := Qry.FieldByName('EmployeeID').AsInteger;
            bOk := true;
        end;
      finally
        DbSharedObj.ReleaseObj(Qry);
      end;
     if not bOk then CommonLib.MessageDlgXP_Vista('Invalid Password', mtWarning, [mbOK], 0);
    end;
  end else begin
    SetPOSScreenActive;
    with TPOSSalesmanPopUp.Create(Self) do try
        if ShowModal = mrOk then begin
          Result := true;
          Val(edtEmpID.Text, Self.iEmployeeID, iCode);
          if iCode <> 0 then begin
            CommonLib.MessageDlgXP_Vista('Invalid Employee ID', mtWarning, [mbOK], 0);
            Self.iEmployeeID := 0;
          end else begin
            lblSalesPerson.Caption := sName;
            Self.iEmployeeID := FastFuncs.StrToInt(edtEmpID.Text);
          end;
        end;
      finally
        Free;
      end;
  end;
end;

procedure TPOSScreenForm.SalesmanIdFn;
begin
  LoadSalesman(oPOSBtnMatrix.Selected.Func.SubFn);
end;

procedure TPOSScreenForm.SalesOrderFn;
begin
  if idOk() then begin
    if not bIsSplitTab then begin
      if IsLineItems then begin
        if IsTotalDiscOK(FN_SALES_ORDER) then begin
          if (char_length(sClient) = 0) or (sClient = CLIENT_CASH) then begin
            iCustOriginator := FN_SALES_ORDER; // used in edtClientIDChange to identify
            ShowCustList; // get the client name
            { The processing of this transaction is completed in the edtClientIDChange as
              this OnChange event marks the return from the customer list.
              edtClientIDChange will recognize that it needs to initiate
              'FinishSalesOrder'  from the value of iCustOriginator }
          end else begin
            // We know client name so continue with process
            FinishSalesOrder;
          end;
        end;
      end;
    end else begin
      CommonLib.MessageDlgXP_Vista('You cannot Quote a Split directly, Please Assign to Customer''s Tab.', mtWarning, [mbOK], 0);
    end;
  end;
end;

function TPOSScreenForm.LoadSalesman(const iSalesmanID: integer): boolean;
var
    strSQL :String;
    Qry:TERPQuery;
begin
    strSQL := 'SELECT FirstName, LastName FROM tblEmployees where EmployeeID = ' + IntToStr(iSalesmanID);
    //with tcDataUtils.Datautilsdataset(strSQL) do begin
      Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
      try
        if Qry.active then Qry.Close;
        Qry.SQL.Text :=strSQL;
        Qry.open;
        if Qry.recordcount > 0 then begin
            lblSalesPerson.Caption := Qry.FieldByName('FirstName').AsString + ' ' + Qry.FieldByName('LastName').AsString;
            iEmployeeID := iSalesmanID;
            if bMultiSalesMan and (iEmployeeID <> 0) then bMustEnterIdNow := false;
        end else begin
            CommonLib.MessageDlgXP_Vista('Employee not found, ID: ' + IntToStr(oPOSBtnMatrix.Selected.Func.SubFn), mtWarning, [mbOK], 0);
        end;
      finally
        DbSharedObj.ReleaseObj(Qry);
      end;
    Result := true;
end;


function TPOSScreenForm.idOk: boolean;
begin
  Result := true;
  if bMultiSalesMan and bMustEnterIdNow then begin
    if not (SalesManFn()) then begin
      Result := false;
      Exit;
    end;
    bMustEnterIdNow := not Result;
  end;

end;

procedure TPOSScreenForm.edtMemoEnter(Sender: TObject);
begin
  // Don't want the memo  to get focus  so send it to a dummy
  SetPOSScreenActive;
end;

procedure TPOSScreenForm.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    MainForm.MainToolBar.Visible := false;  // make the toolbar disapear
    MainForm.StatusBar.Visible := false;
    try
      if AccessLevel < 6 then AccessLevel := 1;
      inherited;
      MyConnection.Connected := true;
      BeginTransaction;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do inherited HandleNoAccessException(e);
      else raise;
    end;
    POSGroupObj :=   Tposgroup.create(Self);
    POSGroupObj.connection := TmyDacDataconnection.create(POSGroupObj);
    TmyDacDataconnection(POSGroupObj.connection).mydacconnection := MyConnection;
    POSGroupobj.BusObjEvent := DoBusinessObjectEvent;

    if Assigned(POSGroupObj) then begin
      POSGroupObj.load(0);
      POSGroupObj.New;
      POSGroupObj.UserID := AppEnv.Employee.EmployeeID;
      POSGroupObj.PostDB;
    end;

    if AppEnv.CompanyPrefs.IntegratedEFTPOS then begin
      if IsEftInProgress() then begin
        CompleteEftInProgress;
      end;
    end;
    if Assigned(CustomerDisplay) then CustomerDisplay.Show;
    //SetPOSScreenActive;
    GuiPrefs.Active:= true;
    if GuiPrefs.Node.Exists('edtPOSMemo.Font') then
      NodeToFont(TDataTreeNode(GuiPrefs.Node['edtPOSMemo.Font']),edtPOSMemo.Font);
    if GuiPrefs.Node.Exists('grdTrans.Font') then
      NodeToFont(TDataTreeNode(GuiPrefs.Node['grdTrans.Font']),grdTrans.Font);
    lblMemoText.font.Charset :=edtPOSMemo.font.Charset;
    lblLineDetails.font.Charset :=edtPOSMemo.font.Charset;
    SetGridcolumns;

    StartTime := Time;
    Self.WindowState := wsMaximized;
    CheckForCashDrop(True);
  finally
    EnableForm;
    initPOSform;
    SetPOSScreenActive;
    Setcontrolfocus(edtPOSMemo);
    //try PrintReceipt;Except end;
    //bTransComplete := False;
  end;
end;
Procedure TPOSScreenForm.initPOSform;
begin
      //lblLog.visible := devmode ;
end;
procedure TPOSScreenForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if userlock.Enabled then
    userlock.UnlockAllCurrentInstance;
  CloseQueries;
  Action := caFree;
  MainForm.Menu := dtmMainGUI.MainMenu;
  MainForm.MainToolBar.Visible := true;
  MainForm.StatusBar.Visible := true;
  SavePosVideoDelay;
  inherited;
end;

procedure TPOSScreenForm.edtClientIDChange(Sender: TObject);
{ This edit box was introduced to be populated from other
forms eg CustomerListFrm }
begin
  Application.ProcessMessages;
  if char_length(edtClientID.Text) <> 0 then begin
    if LoadCustomer(FastFuncs.StrToInt(edtClientID.Text)) then begin
      if iCustOriginator = FN_LAYBY then begin
        FinishNewLayby;
      end else if iCustOriginator = FN_INVOICE then begin
        FinishInvoice;
      end else if iCustOriginator = FN_BAR_TAB then begin
        FinishAddToTab;
      end else if iCustOriginator = FN_TRANSFER_TAB then begin
        bIsTransferTab := true;
        FinishAddToTab;
      end else if iCustOriginator = FN_PAY_TAB then begin
        iTabsClientID := iClientID;// Ian Trying To Track Orginal Bar Tab Owner
        FinishPayTab;
      end else if iCustOriginator = FN_SPLIT_ACCOUNT then begin
        FinishSplitAccount;
      end else if iCustOriginator = FN_PAY_ACCOUNT then begin
        iTabsClientID := iClientID;// Ian Trying To Track Orginal Bar Tab Owner
        FinishPayAccount;
      end else if iCustOriginator = FN_PREPAY_ACCOUNT then begin
        iTabsClientID := iClientID;// Ian Trying To Track Orginal Bar Tab Owner
        FinishPrepayAccount;
      end else if iCustOriginator = FN_CUST_SALES then begin
        FinishCustSales;
      end else if iCustOriginator = FN_TAB_LIST then begin
        FinishTabList;
        iTabsClientID := iClientID;// Ian Trying To Track Orginal Bar Tab Owner
      end else if iCustOriginator = FN_CUST_ACNT then begin
        AssignAccountNumber(sAccountNo, iClientID);
      end else if iCustOriginator = FN_SWIPECARD then begin
        AssignSwipeCard(sCardNumber, iClientID);
      end else if iCustOriginator = FN_REDEEMPOINTS then begin
        showRedeemPoints
      end else if iCustOriginator = FN_QUOTE then begin
        FinishQuote
      end else if iCustOriginator = FN_SALES_ORDER then begin
        FinishSalesOrder;
      end;
    end;
  end;
  StartTime := time;
end;

function TPOSScreenForm.LoadSalesCustomer(const SalesFlobalRef:String): boolean;
var
  strSQL :String;
  Qry :TERPQuery;
begin
  result:= false;
  strSQL :='Select SaleID , ClientId, ISInvoice, iscashsale, isrefund, issalesorder, isquote  from tblSales where Globalref = ' + QuotedStr(SalesFlobalRef);
    //with tcDatautils.Datautilsdataset(strSQL) do begin
      Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
      try
        if Qry.active then Qry.Close;
        Qry.SQL.Text :=strSQL;
        Qry.open;
        if Qry.recordcount > 0 then
               if Qry.fieldbyname('issalesorder').asBoolean then MessageDlgXP_Vista('Sale # '+ inttostr(Qry.fieldbyname('SaleID').asInteger)+' is a ''Sales Order'' and cannot be refunded', mtWarning, [mbOK], 0)
          else if Qry.fieldbyname('isrefund').asBoolean     then MessageDlgXP_Vista('Sale # '+ inttostr(Qry.fieldbyname('SaleID').asInteger)+' is a ''Refund''      and cannot be refunded', mtWarning, [mbOK], 0)
          else if Qry.fieldbyname('isquote').asBoolean      then MessageDlgXP_Vista('Sale # '+ inttostr(Qry.fieldbyname('SaleID').asInteger)+' is a ''Quote''       and cannot be refunded', mtWarning, [mbOK], 0)
          else if Qry.fieldbyname('ISInvoice').asBoolean or Qry.fieldbyname('iscashsale').asBoolean  then result:= LoadCustomer(Qry.fieldbyname('ClientID').asInteger)
          else MessageDlgXP_Vista('Sale # '+ inttostr(Qry.fieldbyname('SaleID').asInteger)+' is not an ''Invoice'' or ''Cash sale'' and cannot be refunded', mtWarning, [mbOK], 0);
      finally
        DbSharedObj.ReleaseObj(Qry);
      end;
end;

function TPOSScreenForm.LoadCustomer(const iCustID: integer): boolean;
var
    oldclientID :Integer;
begin
  Result := false;
  ResetCustInfo;
  if iCustID <= 0 then Exit;
  oldclientID :=iclientId;
  iclientId :=iCustID;
  //With TClient.Create(Self) do try
      //Load(iCustID);
      if client.count > 0 then begin
        //iClientID := iCustID;
        sClient := client.ClientName;
        POSObj.POSPostCode :=client.Postcode;
        POsObj.medtypeID := client.MedtypeID;
        POsObj.Medtype :=   getMediatype(POsObj.MedTypeID);
        sPOSPCode:= POSObj.POSPostCode;
        imedtypeID := POsObj.medtypeID;
        sMedtype := POsObj.Medtype;

        sClientPHAddress := client.StreetAddressWithName;
        sClientBTAddress := client.BillingAddressWithName;
        lblMemoText.Caption := ''; // wipe out any other text - dene said
        AddLineToMemo(sClientPHAddress);
        rCustDisc := client.Discount;
        rSpecDisc := client.SpecialDiscount;
        lblCustomer.Caption := sClient;
        if rCustDisc <> 0.0 then begin
          lblCustDisc.Caption := '%' + FloatToStrF(rCustDisc * 100.0, ffGeneral, 5, 2);
        end;
        if rSpecDisc <> 0.0 then begin
          lblSpecDisc.Caption := '%' + FloatToStrF(rSpecDisc * 100.0, ffGeneral, 5, 2);
        end;


        if rCustDisc <> 0.0 then begin
          HighLightDiscCustomer;
        end;
        //iClientID := iCustID;
        iclientId := client.ID;
        Result := true;
      end else begin
        iclientId := oldclientID;
        // CommonLib.MessageDlgXP_Vista('Customer Does not Exist', mtWarning, [mbOK], 0);
      end;
      RefreshforCustomer;
end;

procedure TPOSScreenForm.AddLineToMemo(const sText: string);
begin
  if char_length(lblMemoText.Caption) <> 0 then lblMemoText.Caption := lblMemoText.Caption + CR;
  lblMemoText.Caption := lblMemoText.Caption + sText;
end;

procedure TPOSScreenForm.CustListFn;
begin
  iCustOriginator := FN_NONE;  // used to determine the id of the caller
  ShowCustList;
end;
procedure TPOSScreenForm.beforeshowProductList(Sender:TObject);
begin
   if not(Sender is TBaselistingGUI) then exit;
//   TBaselistingGUI(Sender).OnGridDataSelect := OnProductSelect;
   TBaselistingGUI(Sender).grpfilters.ItemIndex := 0;
   TBaselistingGUI(Sender).grpfilters.enabled:= False;
   TBaselistingGUI(Sender).GrpfilterSupplied := TRue;
//   TimerMsg(TBaselistingGUI(Sender).FilterLabel , 'As you can only Select the Active customers for POS, the list if filtered for Active Customers');
end;

procedure TPOSScreenForm.ProdListFn;
begin
  edtPartID.Text := '';
  if AppEnv.CompanyPrefs.UseExpressProductList then begin
//    openERPListform('TProductListExpressGUI' , beforeshowProductList);
    OpenERPListFormultiselect('TProductListExpressGUI' , beforeshowProductList, true, OnProductSelect);
  end else begin
//    openERPListform('TProductListGUI' , beforeshowProductList);
    OpenERPListFormultiselect('TProductListGUI' , beforeshowProductList, true, OnProductSelect);
  end;
end;

procedure TPOSScreenForm.OnProductSelect(Sender: TwwDBGrid);
var
  i:Integer;
begin

  showProgressbar(WAITMSG, Sender.Selected.Count);
  try
    if Sender.SelectedList.Count > 0 then begin
      for i := 0 to Sender.SelectedList.Count - 1 do begin
        Sender.datasource.dataset.GoToBookmark(Sender.SelectedList.Items[i]);
        edtPartID.text := ''; { to make sure onChange event fires }
        edtPartID.Text := Sender.DataSource.DataSet.FieldByName('PARTSID').AsString;
        stepProgressbar;
      end;
    end;
  finally
    HideProgressbar;
  end;



end;

procedure TPOSScreenForm.LaybyFn;

begin
  if bIsTraining then begin
    CommonLib.MessageDlgXP_Vista('Laybying can not be done in training mode', mtInformation,  [mbOk], 0);
    exit;
  end;

  if IsAnyAccoutPayments then Exit;
  if EnteringNum then
  begin
    if IsLaybyPayAllowed then begin  // payment
      if idOk() then begin
        if char_length(edtLaybyID.Text) = 0 then
          ShowLaybyList;
        LaybyPayment;
      end;
      EnteringNum(false);
    end else
      CommonLib.MessageDlgXP_Vista('Layby Payments must be made on a seperate sale', mtWarning, [mbOK], 0);
  end else if IsLineItems then
  begin
    // this must be a new Layby - we'll create it
    if lstPayments.Count = 0 then begin
      if not IsAnyLaybyPayments then begin
        if idOk() then begin
          if IsTotalDiscOK() then begin
            if not AnyLinesSelected then begin
              SelectAllLines;
            end;
            // get the client name
            if (char_length(sClient) = 0) or (sClient = CLIENT_CASH) then begin
              iCustOriginator := FN_LAYBY; // used in edtClientIDChange to identify
              ShowCustList; // get the client name
             { The processing of this layby is completed in the edtClientIDChange as
               this OnChange event marks the return from the customer list.
               edtClientIDChange will recognize that it need to complete the layby
               from the value of iCustOriginator }
            end else begin
              // We know client name so continue with process
              FinishNewLayby;
            end;
          end;
        end;
      end else begin
        CommonLib.MessageDlgXP_Vista('You cannot Layby a Layby Payment!!!', mtWarning, [mbOK], 0);
      end;
    end else begin
      CommonLib.MessageDlgXP_Vista('You cannot use a Layby in  a Split Payment.', mtWarning, [mbOK], 0);
    end;
  end else begin
    // Assume that they just want to look at the layby list
    iLaybyOriginator := FN_NONE;
    ShowLaybyList;
    // See you in edtLaybyIDChange where we just ignore any reponse
  end;
end;

procedure TPOSScreenForm.FinishNewLayby;
begin
  if (char_length(sClient) = 0) or (sClient = CLIENT_CASH) then begin
    CommonLib.MessageDlgXP_Vista('You must provide a customer name' + CR +
      'Please try the Layby key Again', mtWarning, [mbOK], 0);
    bIsLayBy := false;
  end else begin
    BackupUnselected(true);
    //GetLaybyDeposit; //still to do - maybe this is not the best way to achieve it anyway
    CalcAndPostCustDisc;
    bIsLayby := true;
    sPayType := PAY_LAYBY;
    PostToDB;
    SavePOS;
    iLayByID := iSaleID;
    if not IsSaleSplit then
    begin
      lblMemoText.Caption := '';
      AddLineToMemo('Layby For: ' + sClient);
      AddLineToMemo('Layby:     ' + IntToStr(iLaybyID));
      AddLineToMemo('Balance:   ' +
        CurrencyToStrF(rRunTot, ffCurrency));
    end
    else
    begin
      MessageDlgXP_Vista('Created Layby For: ' + sClient +
                         #13#10'Layby No: ' + IntToStr(iLaybyId) +
                         #13#10'Balance: ' + CurrencyToStrF(rRunTot, ffCurrency), mtInformation, [mbOk], 0);
    end;

    if AppEnv.CompanyPrefs.POSLaybyPickSlip then
        PickingSlipFn;
    if not IsSaleSplit then
    begin
      CleanUp;
      DisplayInViewer('Layby Amount:  ' + CurrToStrRJ(rRunTot, 13));
    end
    else
      RestoreUnselected;
  end;
end;

procedure TPOSScreenForm.LaybyPayment;
var
  bOK: boolean;
begin
  bOK := true;
  bIsLaybyPayment := true;
  rLaybyPayment := 0.0;
  // Convert to float
  try
    rLaybyPayment := StrToFloat(edtPOSMemo.Lines[0]);
  except
    on EConvertError do begin
      CommonLib.MessageDlgXP_Vista('Not a valid cash amount', mtWarning, [mbOK], 0);
      bOK := false;
    end;
  end;

  if bOK then begin
    // need to ask user to select layby to pay against
    iLaybyOriginator := FN_LAYBY;
//@@@    ShowLaybyList;
    { The processing of the layby will now be completed in edtLaybyIDChange
      after control returns from the LaybyList}
    edtLaybyIDChange(self);
  end;
end;

procedure TPOSScreenForm.ShowLaybyList;
  { Opens the LaybyListGUI form which returns the selcted laybyID in edtLaybyID }
Var
  tmpComponent: TComponent;
begin
  edtLaybyID.Text := '';
  if not FormStillOpen('TLayByListGUI') then begin
    tmpComponent := GetComponentByClassName('TLayByListGUI');
    If not Assigned(tmpComponent) then Exit;
    with TBaseListingGUI(tmpComponent) do begin
        FormStyle := fsMDIChild;
        OnGridDataSelect := OnLaybySelect;
    end
  end else begin
    TForm(FindExistingComponent('TLayByListGUI')).Show;
  end;
 { processing is completed in the edtLaybyIDChange procedure }
end;


procedure TPOSScreenForm.OnLaybySelect(Sender: TwwDBGrid);
begin
  edtLaybyID.Text := Sender.DataSource.DataSet.Fields.FieldByName('SaleID').AsString;
end;

procedure TPOSScreenForm.edtLaybyIDChange(Sender: TObject);
{ This edit box associated with this event was introduced to be populated
 from other forms eg LaybyListFrm
 This function completes a Layby payment line transaction}
var
  //qry: TERPQuery;
  bOK: boolean;
  rTotAmount: currency;
  rLaybyBalance: currency;
  strSQL:String;
  qry: TERPQuery;
begin
  inherited;
  Application.ProcessMessages;
  rLaybyBalance := 0.0;
  // Just make sure that we asked to get here
  if (iLaybyOriginator <> FN_NONE) then begin
    // check that a Layby was selected for payment
    if char_length(edtLaybyID.Text) <> 0 then begin
      rTotAmount := 0.0;
      strSQL :='SELECT Balance, CustomerName, TotalAmountInc, ClientID ' +
                ' FROM tblSales  WHERE SaleID = ' + edtLaybyID.Text;
      qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
      try
        qry.SQL.Text := strSQL;
        qry.Open;
        if ((iClientID <> 0) and (iClientID <> qry.FieldByName('ClientID').AsInteger)) then begin
          CommonLib.MessageDlgXP_Vista('This Layby is for a different customer, please use a seperate sale.', mtWarning, [mbOK], 0);
          bOK := false;
        end else if not qry.IsEmpty then begin
          // populate this layby's details and display
          if RoundTo1C(qry.FieldByName('Balance').AsFloat) >=RoundTo1C(rLaybyPayment) then begin
            sClient               := qry.FieldByName('CustomerName').AsString;
            iClientID             := qry.FieldByName('ClientID').AsInteger;
            lblMemoText.Caption   := '';
            AddLineToMemo('Layby No: ' + edtLaybyId.Text + '   ' + sClient);
            rLaybyBalance         := GetUpdatedLaybyBal(FastFuncs.StrToInt(edtLaybyID.Text),
            GetLaybyBal(FastFuncs.StrToInt(edtLaybyID.Text)));
            AddLineToMemo('Old Balance:  ' +CurrencyToStrF(rLayByBalance, ffCurrency));
            AddLineToMemo('This Payment: ' +CurrencyToStrF(rLaybyPayment, ffCurrency));
            rLaybyBalance         := RoundTo1C(rLaybyBalance - rLaybyPayment);
            AddLineToMemo('New Balance:  ' + CurrencyToStrF(rLaybyBalance, ffCurrency));
            rTotAmount            := qry.FieldByName('TotalAmountInc').AsFloat;
            bOK                   := true;
          end else begin
            CommonLib.MessageDlgXP_Vista('Layby Payment is greater than balance, Try again',mtWarning, [mbOK], 0);
            bOK := false;
          end;
        end else begin
          sClient         := '';
          iClientID       := 0;
          CommonLib.MessageDlgXP_Vista('Original Sale ID does not Exist',mtWarning, [mbOK], 0);
          bOK := false;
        end;
      finally
        DbSharedObj.ReleaseObj(qry);
      end;
      // POst layby payment
      if bOk = true then begin
        FilterPartsByName(PART_LAYBY_PAY);
        if not PostSaleItem('Layby Payment', rLayByPayment,1, FastFuncs.StrToInt(edtLaybyID.Text),rLaybyBalance, rTotAmount, true, true, false) then Exit;
        DisplayLineItem(lstLineItems.Last);
        bIsLaybyPayment := true;
      end;
    end;
  end;
end;

procedure TPOSScreenForm.UpdateLaybyBalance(const iSaleID_: integer; const rLaybyBal: currency);
begin
    {this proc should use the object to be within the same transaction}
    if rLaybyBal < 0.00999 then begin
      POSObj.TotalBalance   := 0.0;
      POSObj.SaleDate       := Date;
      POSObj.EditedFlag     := true;
      POSObj.IsLayby        := False;
      POSObj.IsLaybyTOS     := False;
      POSObj.IsCashSale     := true;
      iLaybyID              := iSaleID_; //Ian's need Global iLaybyID
    end else begin
      POSObj.TotalBalance := rLaybyBal;
      POSObj.EditedFlag := True;
    end;

end;

procedure TPOSScreenForm.edtPartIDChange(Sender: TObject);
{ get here when return from product list form after selecting a part from
 the prod list}
 var
  PAG_ID:Integer;

  function isAttribproduct:Boolean; begin
      REsult := TProduct.isAttribProduct(FastFuncs.StrToInt(edtPartID.Text) ,PAG_ID);
  end;
begin
  inherited;
    if char_length(edtPartID.Text) <> 0 then begin
      if iProdOriginator = FN_BARCODE then begin
        try
        // get here if user has asked to assign a barcode to the returned product
          if AssignBarcode(FastFuncs.StrToInt(edtPartID.Text)) then begin
            if idOk() then begin
                iProdOriginator := FN_NONE;
                FindAndPostPart(FastFuncs.StrToInt(edtPartID.Text));
                grdTrans.Row:= grdTrans.RowCount -2;
                ReadWeight;
                LoadRelatedParts(FastFuncs.StrToInt(edtPartID.Text), rQuantOfProd*pLineItemRec(lstLineItems.Last)^.Multiplier,pLineItemRec(lstLineItems.Last)^.Id , False);
            end;
          end;
        finally
            iProdOriginator := 0;
        end;
      end else begin
        if idOk() then begin
          Processingcursor(True);
          try
            iProdOriginator := FN_NONE;
            FindAndPostPart(FastFuncs.StrToInt(edtPartID.Text));
            grdTrans.Row:= grdTrans.RowCount -2;
            //ShowDetails;
            ReadWeight;
            LoadRelatedParts(FastFuncs.StrToInt(edtPartID.Text), rQuantOfProd *pLineItemRec(lstLineItems.Last)^.Multiplier, pLineItemRec(lstLineItems.Last)^.Id , False);
            grdTrans.Row:= grdTrans.RowCount -2;
          finally
            Processingcursor(False);
          end;
        end;
      end;
    end;
end;

function TPOSScreenForm.GetPartIDFromPartNubmer(const PartNubmer: string): integer;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT PARTSID FROM tblparts WHERE PRODUCTCODE = ' + QuotedStr(PartNubmer) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('PARTSID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function TPOSScreenForm.FindAndAddPart(const PartNumber: integer; Showinviewer:boolean = False):boolean;
var
  rPriceEx: currency;
  sPartDesc: string;
  UnitID: integer;
  pItem: pLineItemRec;
begin
    result:= False;
    {Dene - bin batch product not allowed in POS}
    UnitID:= 0;
    Product.Load(PartNumber);
    if Product.count > 0 then begin
      // if a number has been entered then assume this is a price change
      if EnteringNum and
        (Product.ProductType = 'OTHER') then begin
        PriceChangeFn;
      end;

      if Trim(Product.SalesDescription) <> '' then
        sPartDesc := Product.SalesDescription
      else
        sPartDesc := Product.ProductName;
      rPriceEx := ProductPrice;

      if UnitID = 0 then begin
        unitId := Product.UOMSalesID;
        //UnitID := tcDataUtils.GetProductUoMID(PartNumber);
        //UnitID := tcDataUtils.GetUnitOfMeasureID(DEFAULT_UOM , 0);
      end;
      if UnitID <> 0 then begin
        LoadProductRec(PartNumber, UnitID, 1);
        if ProductRec.Valid then begin
          if (not Empty(ProductRec.SubProductDesc)) then begin
            sPartDesc := ProductRec.SubProductDesc;
          end;
          rPriceEx := ProductRec.PriceEx;
        end;
      end;

      if not PostSaleItem(sPartDesc, rPriceEx,
        rQuantOfProd * dRelatedQtyMultiplier, 0, 0.0, 0.0, Showinviewer, false,
        true, false, false, UnitID) then Exit;
      pItem := lstLineItems.Last;
      if not ISoktoShip(rQuantOfProd ,pItem) then begin
        pItem.Qty :=rQuantOfProd;
        RefreshCurrentlineitem(pItem);
      end;

      result:= True;
    end else begin
      CommonLib.MessageDlgXP_Vista('No such Product with ID: ' +
        IntToStr(PartNumber),
        mtWarning, [mbOK], 0);
      result:= False;
    end;
end;
procedure TPOSScreenForm.FindAndPostPart(const PartNumber: integer; Showinviewer:boolean = True);
var
  MessageStr: string;
begin
   if FindAndAddPart(PartNumber,Showinviewer) then begin
     DisplayLineItem(lstLineItems.Last);
      RefreshMatrixPrice;
      PostAndDisplayAnyProductDisc;

      // Parts Popup Message
      if GetProductReminderPopup(PartNumber, MessageStr) then begin
        CommonLib.MessageDlgXP_Vista(MessageStr, mtInformation, [mbOK], 0);
      end;
   end;
end;

procedure TPOSScreenForm.FinishSalesOrder;
var
  bOk : boolean;
begin
  if (char_length(sClient) = 0) or (sClient = CLIENT_CASH) then begin
    CommonLib.MessageDlgXP_Vista('You must provide a customer name for Sales Order',
      mtWarning, [mbOK], 0);
    IsPosSalesOrder := false;
    Exit;
  end;

  if not CheckSelectedLines('Sales Order') then
    exit;

  BackupUnselected(false);
  bOk := false;
  try
    CalcAndPostCustDisc;

    IsPOSSalesOrder := true;
    sPayType := PAY_NONE;
    if not PostToDB then
      exit;
//    if SavePOS then begin
    try
      bOk := SavePos;
    except
      bOk := false;
    end;
    if bOk then
    begin
      CleanUp;
      DisplayInViewer('Sales Order ' + CurrToStrRJ(rRunTot, 13));
      bOk := true;
    end
    else
      IsPOSSalesOrder := False;
  finally
    if bOk then
      RestoreUnselected
    else
      MergeUnselected;
    bOnhold:=False;
  end;
end;


procedure TPOSScreenForm.FinishSplitAccount;
Var
  tmpComponent: TComponent;
begin
  if (char_length(sClient) = 0) or (sClient = CLIENT_CASH) then begin
    CommonLib.MessageDlgXP_Vista('You must provide a Customer Name for Tab',mtWarning, [mbOK], 0);
    bIsSplitAccount := false;
  end else begin
    bIsSplitAccount := true;
    if FormStillOpen('TCustomerListGUI') then begin
      TForm(FindExistingComponent('TCustomerListGUI')).WindowState := wsMinimized;
    end;
    Application.ProcessMessages;
    tmpComponent := GetComponentByClassName('TPOSSplitAccount');
    If not Assigned(tmpComponent) then Exit;
    with TPOSSplitAccount(tmpComponent) do begin
      FromClientID := iClientID;
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;
procedure TPOSScreenForm.CustomerList1Click(Sender: TObject);
begin
  ShowCustList(False);
end;

procedure TPOSScreenForm.CustomerSignatureFn;
var
  tempStream: TMemoryStream;
begin
  tempStream := TMemoryStream.Create;
  try
    if Assigned(SignatureStream) then
      tempStream.LoadFromStream(SignatureStream);

//   if not Assigned(SignatureStream) then
//     SignatureStream := TMemoryStream.Create;
//   SignatureStream.LoadFromFile('c:\temp\signature.bmp');
//   SignatureStream.Position := 0;
//   exit;

    if GetClientSignature(tempStream) then begin
      if not Assigned(SignatureStream) then
        SignatureStream := TMemoryStream.Create;
      SignatureStream.Clear;
      SignatureStream.LoadFromStream(tempStream);
    end;
  finally
    tempStream.Free;
  end;
end;

procedure TPOSScreenForm.ShowCustList(Const AllowCustomerSelection:Boolean = True);
Var
  tmpComponent: TComponent;
begin
  edtClientID.Text := '';
  if FormStillOpen('TCustomerListGUI') then TForm(FindExistingComponent('TCustomerListGUI')).Close;
  Application.ProcessMessages;
  if not FormStillOpen('TCustomerListGUI') then begin
    tmpComponent := GetComponentByClassName('TCustomerListGUI');
    If not Assigned(tmpComponent) then Exit;
    with TBaseListingGUI(tmpComponent) do begin
      if AllowCustomerSelection then begin
        grpfilters.ItemIndex := 0;
        grpfilters.visible:= False;
        GrpfilterSupplied := True;
        OnGridDataSelect := OnCustomerSelect;
      end;
      FormStyle := fsMDIChild;
    end;
  end;
end;

procedure TPOSScreenForm.OnCustomerSelect(Sender: TwwDBGrid);
begin
  edtClientID.Text := Sender.DataSource.DataSet.FieldByName('ClientID').AsString;
end;

function TPOSScreenForm.AccountID(const sAccount: string): integer;
begin
    REsult:= tcdatautils.GetAccountID(sAccount);
    if result = 0 then
        CommonLib.MessageDlgXP_Vista('Account "' + sAccount + '" not found',mtWarning, [mbOK], 0);
end;

function TPOSScreenForm.GetTaxRate(const sTaxCode: string): double;
begin
    result := tcdatautils.GetTaxRateForCode(sTaxCode);
end;

procedure TPOSScreenForm.SetPeripherals;
var
  qryTill: TERPQuery;
begin
  FreeReceiptPrinterList;
    try
      sPrnType := uppercase(Trim(sPrnType));
      sPrnname := uppercase(Trim(sPrnname));

      // if multi tills enabled then each till can have its own printer definitions
      if bMultiTills then begin
        qryTill := TERPQuery.Create(nil);
        qryTill.Options.FlatBuffers := True;
        qryTill.Connection := CommonDbLib.GetSharedMyDacConnection;
        try
          with qryTill do begin
            SQL.Clear;
            SQL.Add('SELECT UseDefaultPrinter, ReceiptPrinterOn, ReceiptPrinterPort, ' +
              'ReceiptPrinterType, USBPrinterName, UseCashDrawerOnly, IsPrintSpooler, ' +
              'RemoteTillID, UsePrintSpooler, ' +
              'POSPrintReceiptOnlyOnCompleteSale, '+
              'POSPrintDescriptionMultipleLines ' +
              'FROM tblPOSTills WHERE TillID = :xTillID');
            Params.ParamByName('xTillID').asInteger := iTillID;
            //logtext(SQLtext);
            Open;
            if not IsEmpty then begin
              if FieldByName('UseDefaultPrinter').AsString <> 'T' then begin
                sPrnType := FieldByName('ReceiptPrinterType').AsString;
                sPrnname := FieldByName('USBPrinterName').AsString;
                sPrnDev := FieldByName('ReceiptPrinterPort').AsString;
                bIsSpooler := (FieldByName('IsPrintSpooler').AsString = 'T');
                bUseSpooler := (FieldByName('UsePrintSpooler').AsString = 'T');
                bPOSPrintReceiptOnlyOnCompleteSale := FieldByName('POSPrintReceiptOnlyOnCompleteSale').AsBoolean;
                bPOSPrintDescriptionMultipleLines := FieldByName('POSPrintDescriptionMultipleLines').AsBoolean;

                // assign remote till for printing to
                if bIsSpooler then begin
                  iRemoteTillID := iTillID;   // spooler spools to itself
                end else begin
                  iRemoteTillID := FieldByName('RemoteTillID').AsInteger;
                end;
              end;
            end
            else begin // if use defoultprinter - teake from preferences
              bPOSPrintReceiptOnlyOnCompleteSale := AppEnv.CompanyPrefs.POSPrintReceiptOnlyOnCompleteSale;
              bPOSPrintDescriptionMultipleLines := AppEnv.CompanyPrefs.POSPrintDescriptionMultipleLines;
            end;
          end;

        finally
          FreeandNil(qryTill);
        end;
      end;

      // Create receipt printer
      //logtext('Receipt Printer (' + sPrnType+','+ sPrnname +')');
      if bIsSpooler or bUseSpooler then begin
        // remote printer - create remote printer type
        try
          oRcptPrn := TRemotePrn.Create(iTillID, iRemoteTillID, CommonDbLib.GetSharedMyDacConnection);
        Except
            on E:Exception do begin
              //logtext('19:' + E.Message);
              CommonLib.MessageDlgXP_Vista('Print Failed - unable to connect to the remote printer.', mtWarning, [mbOK], 0);
              Exit;
            end;
        end;
        TRemotePrn(oRcptPrn).SetFlushTrigger('TAX INVOICE', 3); // buffer will be flushed if more than 3 receipts
        // local cash drawer - may or may not use
        oCashDrawer := ReceiptPrinterList.CreatePrinter(sPrnType, sPrnname);
        oCashDrawer.SetDevice(sPrnDev);
        oCashDrawer.Initialize;
      end else begin
        // local printer and cash drawer
        oRcptPrn := ReceiptPrinterList.CreatePrinter(sPrnType, sPrnname);
        oRcptPrn.SetDevice(sPrnDev);
        oRcptPrn.Initialize;
        oCashDrawer := oRcptPrn;
      end;
    Except
      on E:Exception do begin
        if devmode then
          //logtext('Error Initialising the Receipt Printer (' + sPrnType+','+ sPrnname +'): ' +NL+NL+E.message);
      end;
    end;
end;
function TPOSScreenForm.IsAccessAllowed(const sFnName: string; const iEmployeeID: integer = 0): boolean;
begin
  if AppEnv.AccessLevels.GetEmployeeAccessLevel(sFnName, iEmployeeID) <> ACCESS_ALLOWED then begin
//    raise ENoAccess.Create('You don''t have Access to this Function');
    Result := false;
  end else Result := true;
end;

procedure TPOSScreenForm.HandleNoAccessException(const e: Exception);
begin
  {User doesn't have access to this Function}
  CommonLib.MessageDlgXP_Vista(e.Message, mtInformation, [mbOK], 0);
end;


function TPOSScreenForm.FilterPartsByName(const sName: string): boolean;
begin
    Product.LoadSelect('PartName = ' + quotedStr(sName));
  if Product.count > 0 then begin
    Result := true;
  end else begin
    CommonLib.MessageDlgXP_Vista('Could not locate Part: ' + sName + ' in Parts Table ',
      mtWarning, [mbOK], 0);
    Result := false;
  end;
end;


procedure TPOSScreenForm.FillLinesBySaleId(aSaleId: integer);
var
  qry : TERPQuery;
//  line : PLineItemRec;
  SubProductRec: TSubProductRec;
begin
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Clear;
    qry.SQL.Add('select * from tblSalesLines where SaleId = ' + IntToStr(iSaleId));
    qry.Open;
    while not qry.eof do
    begin
      if SameText(qry.FieldByName('ProductName').AsString, 'Rounding') then
      begin
        qry.Next;
        Continue;
      end;

      with SubProductRec do begin
        ProductID := qry.FieldByName('ProductID').AsInteger;
        Valid     := true;
        if char_length(qry.FieldByName('UnitOfMeasureSaleLines').AsString) > 0 then begin
          Units := qry.FieldByName('UnitOfMeasureSaleLines').AsString;
          UnitsMultiplier := qry.FieldByName('UnitOfMeasureMultiplier').AsFloat;
          SubProductDesc := qry.FieldByName('Product_Description').AsString;
          PriceEx := qry.FieldByName('LinePrice').AsFloat * UnitsMultiplier;
        end;
      end;

      NewLineItem;
      LineItem.ProductID := qry.FieldByName('ProductId').AsInteger;
      LineItem.ProductName := qry.FieldByName('ProductName').AsString;
      LineItem.ProductPrintName := qry.FieldByName('ProductPrintName').AsString;
      LineItem.ProductDescription := qry.FieldByName('Product_Description').AsString;
      LineItem.Qty       := qry.FieldByName('UnitOfMeasureQtySold').AsFloat;
      LineItem.PartType            := qry.FieldByName('PARTTYPE').AsString;
      LineItem.Amount              := qry.FieldByName('TotalLineAmountInc').AsFloat;
      LineItem.Multiplier          := qry.FieldByName('UnitOfMeasureMultiplier').AsFloat;
      LineItem.LinePrice           := qry.FieldByName('LinePrice').AsFloat * LineItem.Multiplier;
      LineItem.LinePriceInc        := qry.FieldByName('LinePriceInc').AsFloat * LineItem.Multiplier;
      LineItem.Area                := qry.FieldByName('Area').AsString;
      LineItem.LaybyId             := 0;
      LineItem.LaybyBal            := 0;
      LineItem.LaybyAmount         := 0;
      LineItem.TaxRate             := qry.FieldByName('LineTaxRate').AsFloat;
      LineItem.TaxCode             := qry.FieldByName('LineTaxCode').AsString;
      LineItem.IncomeAccnt         := qry.FieldByName('IncomeAccnt').AsString;
      LineItem.AssetAccnt          := qry.FieldByName('AssetAccnt').AsString;
      LineItem.CogsAccnt           := qry.FieldByName('CogsAccnt').AsString;
      LineItem.ProductGroup        := qry.FieldByName('ProductGroup').AsString;;
      LineItem.LineCost            := qry.FieldByName('LineCost').AsFloat;
      LineItem.LineCostInc         := qry.FieldByName('LineCostInc').AsFloat;
      LineItem.ApplyDisc           := false;
      LineItem.IsProduct           := false; // i think that this will prevent unwanted processing
      LineItem.IsDiscount          := false;
      LineItem.DiscRatio           := 0;
      LineItem.IsChild             := false;
      LineItem.PriceChanged        := false; //true;
      LineItem.IsVoucher           := false;
      LineItem.IsRedeeming         := false;
      LineItem.VoucherNo           := '';
      LineItem.IssuedBy            := '';
      LineItem.IsToBeDeleted       := false;
      LineItem.SubProduct          := SubProductRec; // sub product attributes
      LineItem.FixedPrice          := true;
      LineItem.UnitID              := qry.FieldByName('UnitOfMeasureID').asInteger;
      LineItem.IsFrozen            := true;
//      LineItem.BarTabId            := qry.fieldbyname('SaleID').asInteger;
//      LineItem.BarTabLineId        := qry.fieldbyname('SaleLineID').asInteger;
      LineItem.Amount := RoundCurrency(LineItem.LinePriceInc * LineItem.Qty);
      LineItem.IsAccountPayment    := false;
      lstLineItems.Add(LineItem);
      qry.Next;
    end;
  finally
    RebuildGrid;
    qry.Free;
  end;
end;

function TPOSScreenForm.FilterPartsByID(const iPartsID: integer): boolean;
begin
  Product.Load(iPartsID);

  if Product.count > 0 then begin
    Result := true;
  end else begin
    CommonLib.MessageDlgXP_Vista('Could not locate Part: ' + IntToStr(iPartsId) + ' in Parts Table ',
      mtWarning, [mbOK], 0);
    Result := false;
  end;
end;


procedure TPOSScreenForm.WMSysCommand;
  { get here on maximize or minimize }
begin
  // prevent changing from maximized
//  if Msg.CmdType <> SC_CLOSE then begin // only allow close
//    Msg.CmdType := SC_MAXIMIZE;
//  end;
  DefaultHandler(Msg);

end;

function TPOSScreenForm.GetTillName(const iTillID: integer): string;
begin
    result := TPosTill.IDToggle(itillID);
    if result = '' then
        CommonLib.MessageDlgXP_Vista('Till ID "' + IntToStr(iTillID) + '" not found'#13 +'Will default to "Unknown"',
            mtWarning, [mbOK], 0);
end;

function TPOSScreenForm.GetTotalDiscountAmount: double;
var x: integer;
begin
  result:= 0;
  if Assigned(lstLineItems) then begin
    for x := 0 to lstLineItems.Count -1 do begin
      if pLineItemRec(lstLineItems[x])^.IsDiscount then
        result:= result + Abs(pLineItemRec(lstLineItems[x])^.Amount);
    end;
  end;
end;

function TPOSScreenForm.GetPrimaryPad(const iTillID: integer): integer;
begin
   result := tcDatautils.GetPrimaryPad(itillID);
   if result = 0 then begin
        CommonLib.MessageDlgXP_Vista('Till ID "' + IntToStr(iTillID) + '" not found'#13 +'in tblPOSTills. Will default.',
                    mtWarning, [mbOK], 0);
        Result := DEFAULT_PAD;
   end;
end;

procedure TPOSScreenForm.ResetCustInfo;
begin
  sClient := CLIENT_CASH;
  iClientID := 0;
  rCustDisc := 0.0;
  rSpecDisc := 0.0;
  sClientPHAddress := '';
  sClientBTAddress := '';
  lblCustomer.Caption := CLIENT_CASH;
  lblTotCustDisc.Caption := '';
  lblCustDisc.Caption := '';
  lblSpecDisc.Caption := '';
end;

procedure TPOSScreenForm.RestoreUnselected;
begin
  CleanUp;
  ClearAll;
  LoadSavedContext;
end;

procedure TPOSScreenForm.RefreshMatrixPrice;
var
    pItem: pLineItemRec;
    MatrixDesc, MatrixRef:String;
    MatrixPrice:Double;
begin
  pItem := lstLineItems.Last;
  if pItem^.MatrixRef = '' then begin
    ReadSalesDefaultPriceMethod(pItem^.ProductID,MatrixDesc, MatrixRef,MatrixPrice);
    SetMatrixDetails(pItem , MatrixDesc,MatrixRef ,MatrixPrice);

  end;
end;
Procedure TPOSScreenForm.SetMatrixDetails( pItem: pLineItemRec; sMatrixDesc:String;  sMatrixRef:String;  dMatrixPrice:double);
begin
    if pItem^.TaxRate <> 0 then dMatrixPrice := dMatrixPrice * (1.0 + pItem^.TaxRate);
    pItem^.MatrixDesc := sMatrixDesc;
    pItem^.MatrixRef  := sMatrixRef;
    pItem^.MatrixPrice:= dMatrixPrice;
    if pItem^.MatrixPrice <> 0 then  begin
      pItem^.LinePrice :=dMatrixPrice*pItem^.multiplier;
      pItem^.Amount :=pItem^.LinePrice*pItem^.Qty;
      RebuildGrid;
    end;
end;

procedure TPOSScreenForm.PostAndDisplayAnyProductDisc;
var
  sDescription: string;
  pItem: pLineItemRec;
begin
  pItem := lstLineItems.Last;
  if pItem^.DiscRatio > 0 then begin
    CaluclateDiscount(pItem);
    RebuildGrid;
  end else if (pItem^.PriceChanged=False) and (oDiscount.DiscountType<> 0) then begin
      sDescription :=DiscountDescription;
      if sDescription <> '' then
        if pItem^.DiscRatio <> 0 then
        sDescription := sDescription +' @ ' +FloatToStrF(pItem^.DiscRatio*100,ffNumber , 15, 2) +'%'
      else if rCustDisc <> 0 then
        sDescription := sDescription +' @ ' +FloatToStrF(rCustDisc,ffNumber , 15, 2) +'%';
      pItem^.DiscountDetails := '(' +sDescription +')';
      RebuildGrid;
  end;
end;
function TPOSScreenForm.DiscountDescription: String;
begin
    case oDiscount.DiscountType of
      EXTRA_SELL: Result      := 'Ext Sell Disc';
      SPEC_DISC: Result       := 'Spec Disc';
      SPEC_PRICE_DISC: Result := 'Spec Price Disc';
      PROD_GROUP_DISC: Result := 'Group Disc';
      PERMANENT: Result       := 'Perm Disc';
      else Result := 'Discount';
    end;
end;
procedure TPOSScreenForm.CaluclateDiscount(pItem: pLineItemRec);
var
  sDescription: string;
  rDollarDisc: currency;
begin
  if pItem^.DiscRatio > 0 then begin
    sDescription := DiscountDescription;
    if sDescription <> '' then
      if pItem^.DiscRatio <> 0 then
        sDescription := sDescription +' @ ' +FloatToStrF(pItem^.DiscRatio*100 ,ffNumber , 15, 2 ) +'%';
    rDollarDisc := RoundTo1C(pItem^.Amount * pItem^.DiscRatio);
    pItem^.DiscountDetails := '(' +sDescription +':' +  FloatToStrF(rDollarDisc,ffNumber , 15, 2)+')';
  end else pItem^.DiscountDetails :='';
end;

procedure TPOSScreenForm.CalcAndPostCustDisc;
{ this Posts the discount in dollars for this customer
  It should probably only be called when the sale is completed and all
  line items have been entered.}
var
  pItem: pLineItemRec;
  i: integer;
begin
  if (rTotCustDisc <> 0.0) then begin
    // Post the discount
    FilterPartsByName(PART_PCENT_DISC);
    if not PostSaleItem('Customer Discount', - rTotCustDisc,
      1, 0, 0.0, 0.0, false, true, false) then Exit;
    DisplayLineItem(lstLineItems.Last);

    // Now that discount is to be posted, remove disc flag from all entries
    rTotCustDisc := 0.0;
    for i := 0 to lstLineItems.Count - 1 do begin
      pItem := lstLineItems.Items[i];
      pItem^.ApplyDisc := false;
    end;
    ReCalcRunTot;
    DisplayRunTot(rRunTot);
  end;
end;

procedure TPOSScreenForm.CalculatorFn;
var
  pItem: pLineItemRec;
  lQuant : Double;
  lStr : string;
begin
  if lstLineItems.Count = 0 then
    Exit;

  if idOk() then begin
      if pLineItemRec(lstLineItems.Last)^.IsAccountPayment then begin
        CommonLib.MessageDlgXP_Vista('You cannot Change the Quantity of an Account Payment', mtWarning, [mbOK], 0);
      end else begin
        // Convert to float
        try

          lQuant := rQuantOfProd;
          lStr := '';
          if not frmCalculator.Calculate(lQuant, lStr) then
            exit;
          pItem := CurrentRow;
          if not Assigned(pItem) then exit;
          if (lQuant >0) and not (ISoktoShip(rQuantOfProd ,pItem)) then
            exit;  //

          if not Assigned(pItem) then
            exit;

          if Sysutils.SameText(pItem^.ProductName , REDEEM_POINTS) then begin
            CommonLib.MessageDlgXP_Vista('You cannot Change the Quantity of Redeem Points', mtWarning, [mbOK], 0);
            Exit;
          End;

          if (pItem^.Qty < 0) then begin
              bRefundMode := true;  // set global if in refund mode
          end;

          rQuantOfProd := lQuant;
          pItem^.Qty := rQuantOfProd;


          PostSaleItem(pItem ,PItem^.ProductDescription ,PItem^.LinePriceinc, rQuantOfProd , 0, 0.0, 0.0, False, False , True , False, False, PItem^.UnitID);
          updateRelatedProductsQty(PItem^.ID, PItem^.Qty*PItem^.Multiplier);
          RebuildGrid;
        except
          on EConvertError do begin
            CommonLib.MessageDlgXP_Vista('Not a valid Quatity', mtWarning, [mbOK], 0);
            rQuantOfProd := 1.0;
          end;
        end;
      end;
  end;
  rQuantOfProd := 1.0;
end;

procedure TPOSScreenForm.CalcVideoDisplayRatio;
begin

end;

procedure TPOSScreenForm.DullDisplay;
var
  iRows: integer;
begin
  if isformshown then CheckForCashDrop;
  grdTrans.FixedColor := CL_FUNKY_BLUE;
  pnlCustomer.FromColor  := CL_FUNKY_BLUE;
  pnlCustomer.ToColorMirror  := CL_FUNKY_BLUE;
  lblRunTot.Color := CL_FUNKY_BLUE;
  if CompletedBitMap <> nil then begin
    grdTrans.BackGround.Bitmap.Assign(CompletedBitMap);
    if grdTrans.RowCount < MAX_ROWS then begin
      iRows := grdTrans.RowCount;
      grdTrans.RowCount := MAX_ROWS;
      grdTrans.ClearRows(iRows, MAX_ROWS - iRows);
    end;
  end else begin
    grdTrans.Color := CL_FUNKY_BLUE;
  end;
end;

procedure TPOSScreenForm.NormalDisplay;
begin
  if CompletedBitMap <> nil then begin
    grdTrans.BackGround.Bitmap.Assign(NullBitMap); // must be a better way
  end;
  grdTrans.Color := clWhite;
  grdTrans.FixedColor := clWhite;
  pnlCustomer.FromColor  := CL_FUNKY_BLUE;
  pnlCustomer.ToColorMirror  := CL_FUNKY_BLUE;
  lblRunTot.Color := clWhite;
end;

procedure TPOSScreenForm.HighlightDiscCustomer;
begin
  pnlCustomer.FromColor  := clYellow;
  pnlCustomer.ToColorMirror  := clYellow;
end;


procedure TPOSScreenForm.HookListForm(aForm : TBaseListingGui);
begin
//  OldSalesListDbl
  aForm.CloseOnRecSelect := true;
  aForm.OnGridDataSelect := ListFormDataSelect;
end;

procedure TPOSScreenForm.mnuExitPOSClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := FindExistingComponent('TCustomizePOSForm');
  If Assigned(tmpComponent) then
    TForm(tmpComponent).Close;
  Application.ProcessMessages;
//  Self.WindowState := wsNormal;
//  Self.Update;
  Self.Close;
end;


procedure TPOSScreenForm.mnuCustomPOSClick(Sender: TObject);
begin
  inherited;
  CustomizePOS;
  PerformPaints;
end;

procedure TPOSScreenForm.CustomizePOS;
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TCustomizePOSForm');
  If not Assigned(tmpComponent) then Exit;
  with TForm(tmpComponent) do begin
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TPOSScreenForm.ProductListClick(Sender: TObject);

begin
  inherited;

end;

//procedure TPOSScreenForm.RepairClick(Sender: TObject);
//Var
//  tmpComponent: TComponent;
//begin
//  inherited;
//  tmpComponent := GetComponentByClassName('TRepairsGUI');
//  If not Assigned(tmpComponent) then Exit;
//  with TForm(tmpComponent) do begin
//    ShowModal;
//  end;
//end;
//
//procedure TPOSScreenForm.RepairListClick(Sender: TObject);
//Var
//  tmpComponent: TComponent;
//begin
//  inherited;
//  AppContext['Repair'].VarByname['Caption'] := AppEnv.CompanyPrefs.RepairTitle;
//  AppContext['Repair'].VarByname['CreateJobFromRepair'] := 'F';
//  if AppEnv.CompanyPrefs.RepairEquipListLimit = 'C' then AppContext['Job'].VarByname['Caption'] := AppEnv.CompanyPrefs.JobTitle;
//  if not FormStillOpen('TRepairsListGUI') then begin
//    tmpComponent := GetComponentByClassName('TRepairsListGUI');
//    If not Assigned(tmpComponent) then Exit;
//    with TForm(tmpComponent) do begin
//        FormStyle := fsmdiChild;
//        BringToFront;
//      end;
//  end else begin
//    with TForm(FindExistingComponent('TRepairsListGUI')) do begin
//      Show;
//      BringToFront;
//    end;
//  end;
//end;

procedure TPOSScreenForm.AppointmentClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TAppointmentGUI');
  If not Assigned(tmpComponent) then Exit;
  with TForm(tmpComponent) do begin
    ShowModal;
  end;
end;

//procedure TPOSScreenForm.Repairs1Click(Sender: TObject);
//begin
//  inherited;
//  Self.RepairListClick(Sender);
//end;

//procedure TPOSScreenForm.SetRepairID(const iRepairID: integer);
//var
//  qryRepairs: TERPQuery;
//  qryRepairParts: TERPQuery;
//  bOK: boolean;
//begin
//  If Assigned(POSObj) then POSObj.RepairID := iRepairID;
//  if bTransComplete then begin
//    bOK := false;
//    ClearAll;
//    bTransComplete := false;
//    self.iRepairID := iRepairID;
//    qryRepairs     := TERPQuery.Create(nil);
//    qryRepairs.Options.FlatBuffers := True;
//    qryRepairs.Connection := CommonDbLib.GetSharedMyDacConnection;
//    try
//      with qryRepairs do begin
//        // Repairs table
//        SQL.Clear;
//        SQL.Add('SELECT CusID FROM tblRepairs WHERE RepairID = :xRepairID');
//        Params.ParamByName('xRepairID').AsInteger := iRepairID;
//        Open;
//        if not IsEmpty then begin
//          LoadCustomer(FieldByName('CusID').AsInteger);
//          bOK := true;
//        end else begin
//          CommonLib.MessageDlgXP_Vista('Repair ID "' + IntToStr(iRepairID) + '" not found'#13 +
//            'in tblRepairs.', mtWarning, [mbOK], 0);
//        end;
//      end;
//    finally
//      FreeandNil(qryRepairs);
//    end;
//
//    // Post the Repair parts
//    if bOK then begin
//      qryRepairParts := TERPQuery.Create(nil);
//      qryRepairParts.Options.FlatBuffers := True;
//      qryRepairParts.Connection := CommonDbLib.GetSharedMyDacConnection;
//      try
//        with qryRepairParts do begin
//          // Repair Parts table
//          SQL.Clear;
//          SQL.Add('SELECT PartsID, Qty, Description, PriceEx, ' +
//            'TaxRate, Discount, Markup ' +
//            'FROM tblRepairParts ' +
//            'WHERE RepairID = :xRepairID');
//          Params.ParamByName('xRepairID').AsInteger := iRepairID;
//          Open;
//          if not IsEmpty then begin  // any qryRepair Parts records?
//            First;
//            while not Eof do begin  // for each Repair part record
//
//              // post the part
//              if FilterPartsByID(FieldByName('PartsID').AsInteger) then begin
//                if not PostSaleItem(qryRepairParts.FieldByName('Description').AsString,
//                  qryRepairParts.FieldByName('PriceEx').AsFloat,
//                  qryRepairParts.FieldByName('Qty').AsFloat,
//                  0, 0.0, 0.0, false, false, false, 0) then Exit;
//                DisplayLineItem(lstLineItems.Last);
//              end;
//
//              // post any discounts or surcharges
//              if FieldByName('Discount').AsFloat >= 0.01 then begin
//                if FilterPartsByName(ReplaceStr(PART_DOL_DISC,'$',AppEnv.RegionalOptions.CurrencySymbol)) then begin
//                  if not PostSaleItem('Discount', - qryRepairParts.FieldByName('Discount').AsFloat,
//                    1, 0, 0.0, 0.0, false, true, false, 0) then Exit;
//                  DisplayLineItem(lstLineItems.Last);
//                end;
//              end;
//              if FieldByName('Markup').AsFloat > 0.01 then begin
//                if FilterPartsByName(ReplaceStr(PART_DOL_SURCH,'$',AppEnv.RegionalOptions.CurrencySymbol)) then begin
//                  if not PostSaleItem('Surcharge',
//                    qryRepairParts.FieldByName('Markup').AsFloat,
//                    1, 0, 0.0, 0.0, false, true, false, 0) then Exit;
//                  DisplayLineItem(lstLineItems.Last);
//                end;
//              end;
//
//              Next; // next Repair part record
//            end;    // for each Repair part
//          end else begin
//            CommonLib.MessageDlgXP_Vista('Repair ID "' + IntToStr(iRepairID) + '" not found'#13 +
//              'in tblRepairsParts.',
//              mtWarning, [mbOK], 0);
//          end;
//        end;
//      finally
//        FreeandNil(qryRepairParts);
//      end; // try
//    end;   // if bOK
//  end;
//  DisplayInViewer('Repair Conversion');
//end;

procedure TPOSScreenForm.SetQuoteID(const iQuoteID: integer);
  // this creates a POS sale from the quote specidfied.  It is designed
  // .. for use by the quote form when a POS conversion is required.
var
  qryQuotes: TERPQuery;
  qryQuoteLines: TERPQuery;
  bOK: boolean;
  rTotalQuoteAmount: currency;
  rDiff: currency;
begin
  if (POSObj <> nil) then POSObj.QuoteID := iQuoteID;
  rTotalQuoteAmount := 0.0;
  if bTransComplete then begin
    bOK := false;
    ClearAll;
    bTransComplete := false;
    self.iQuoteID  := iQuoteID;
    qryQuotes      := TERPQuery.Create(nil);
    qryQuotes.Options.FlatBuffers := True;
    qryQuotes.Connection := CommonDbLib.GetSharedMyDacConnection;
    try
      with qryQuotes do begin
        // Quotes are in the Sales table
        SQL.Clear;
        SQL.Add('SELECT ClientID, TotalQuoteAmount ' +
          'FROM tblSales WHERE SaleID = :xSaleID');
        Params.ParamByName('xSaleID').AsInteger := iQuoteID;
        Open;
        if not IsEmpty then begin
          LoadCustomer(FieldByName('ClientID').AsInteger);
          rTotalQuoteAmount := FieldByName('TotalQuoteAmount').AsFloat;
          bOK := true;
        end else begin
          CommonLib.MessageDlgXP_Vista('Quote Sales ID "' + IntToStr(iQuoteID) + '" not found'#13 +
            'in tblSales.', mtWarning, [mbOK], 0);
        end;
      end;
    finally
      FreeandNil(qryQuotes);
    end;

    // Post the Quote liness
    if bOK then begin
      qryQuoteLines := TERPQuery.Create(nil);
      qryQuoteLines.Options.FlatBuffers := True;
      qryQuoteLines.Connection := CommonDbLib.GetSharedMyDacConnection;
      try
        with qryQuoteLines do begin
          // Quote lines in SalesLines table
          SQL.Clear;
          SQL.Add('SELECT ProductID, QtySold, Product_Description, ' +
            'LinePrice, UnitOfMeasureID,' +
            'LineTaxRate, Discounts, Markup  '+
            'FROM tblSalesLines ' +
            'WHERE SaleID = :xSaleID');
          Params.ParamByName('xSaleID').AsInteger := iQuoteID;
          Open;
          if not IsEmpty then begin  // any qryQuoteLine records?
            First;
            while not Eof do begin  // for each Quote line

              // post the part
              if FilterPartsByID(FieldByName('ProductID').AsInteger) then begin
                if not PostSaleItem(
                  qryQuoteLines.FieldByName('Product_Description').AsString,
                  qryQuoteLines.FieldByName('LinePrice').AsFloat,
                  qryQuoteLines.FieldByName('QtySold').AsFloat,
                  0,
                  0.0,
                  0.0,
                  false,
                  false,
                  false,
                  false,
                  false,
                  qryQuoteLines.FieldByName('UnitOfMeasureID').AsInteger) then Exit;
                DisplayLineItem(lstLineItems.Last);
              end;

              // post any discounts or surcharges
              if FieldByName('Discounts').AsFloat > 0.001 then begin
                if FilterPartsByName(ReplaceStr(PART_DOL_DISC,'$',AppEnv.RegionalOptions.CurrencySymbol)) then begin
                  if not PostSaleItem('Discounts', - qryQuoteLines.FieldByName('Discounts').AsFloat,
                    1, 0, 0.0, 0.0, false, true, false, false, false) then Exit;
                  DisplayLineItem(lstLineItems.Last);
                end;
              end;
              if FieldByName('Markup').AsFloat > 0.001 then begin
                if FilterPartsByName(ReplaceStr(PART_DOL_SURCH,'$',AppEnv.RegionalOptions.CurrencySymbol)) then begin
                  if not PostSaleItem('Surcharge',
                    qryQuoteLines.FieldByName('Markup').AsFloat,
                    1, 0, 0.0, 0.0, false, true, false) then Exit;
                  DisplayLineItem(lstLineItems.Last);
                end;
              end;

              Next; // Point to next Quote Line record
            end;    // for each Quote line
            DisplayInViewer('Quote Conversion');
          end else begin
            CommonLib.MessageDlgXP_Vista('Quote/Sale ID "' + IntToStr(iQuoteID) + '" not found'#13 +
              'in tblSalesLines.',
              mtWarning, [mbOK], 0);
          end;
        end;
      finally
        FreeandNil(qryQuoteLines);
      end; // try
      rDiff := rTotalQuoteAmount - rRunTot;
      if rDiff <= -0.01 then begin
        if FilterPartsByName(ReplaceStr(PART_DOL_DISC,'$',AppEnv.RegionalOptions.CurrencySymbol)) then begin
          if not PostSaleItem('Quote Discount',
            rDiff, 1, 0, 0.0, 0.0, false, true, false) then exit;
          DisplayLineItem(lstLineItems.Last);
        end;
      end else if rDiff >= 0.01 then begin
        if FilterPartsByName(ReplaceStr(PART_DOL_SURCH,'$',AppEnv.RegionalOptions.CurrencySymbol)) then begin
          if not PostSaleItem('Quote Conversion',
            rDiff, 1, 0, 0.0, 0.0, false, true, false) then Exit;
          DisplayLineItem(lstLineItems.Last);
        end;
      end
    end;  // if bOK
  end;
  DisplayInViewer('Quote Conversion');
end;

procedure TPOSScreenForm.SetHireID(const iHireID: integer);
var
  Qryhire: TERPQuery;
  ItemRec: pLineItemRec;
begin

  if (POSObj <> nil) then POSObj.HireGlobalref := THire.IDToggle(iHireID);
  if bTransComplete then begin
    ClearAll;
    bTransComplete := false;
    self.iHireID  := iHireID;
    Qryhire := dbsharedobj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
    try
      with Qryhire do begin
        SQL.Clear;
        SQL.Add('SELECT ClientID , TotalAmountInc FROM tblHire WHERE HireID = :xHireID');
        Params.ParamByName('xHireID').AsInteger := iHireID;
        Open;
        if not IsEmpty then begin
          LoadCustomer(FieldByName('ClientID').AsInteger);
        end else begin
          CommonLib.MessageDlgXP_Vista('Hire # "' + IntToStr(iHireID) + '" not found', mtWarning, [mbOK], 0);
          Exit;
        end;
      end;
        with Qryhire do begin
          SQL.Clear;
          SQL.Add('SELECT * FROM tblhirelines WHERE HireID = ' + inttoStr(iHireID));
          Open;
          if recordcount >0 then begin
            First;
            while not Eof do begin  // for each Quote line

              if FilterPartsByID(FieldByName('ProductID').AsInteger) then begin
                if not PostSaleItem('Equipment Hire :' + FieldByName('EquipmentName').AsString,
                  FieldByName('LineAmountInc').AsFloat,
                  FieldByName('HireQty').AsFloat,
                  0, 0.0, 0.0, false, false, false) then Exit;
                ItemRec := lstLineItems.Last;
                ItemRec^.HireLineId := fieldByname('HireLineId').AsInteger;
                DisplayLineItem(lstLineItems.Last);
              end;

              Next;
            end;
          end;

          if Active then close;
          SQL.Clear;
          SQL.Add('Select * from tblhirepartssale where HireID = ' + inttoStr(iHireID));
          Open;
          if recordcount >0 then begin
            First;
            while not Eof do begin  // for each Quote line
              if FilterPartsByID(FieldByName('ProductID').AsInteger) then begin
                if not PostSaleItem('Equipment Hire Product :' + FieldByName('Description').AsString,
                  FieldByName('PriceEx').AsFloat,
                  FieldByName('Qty').AsFloat,
                  0, 0.0, 0.0, false, false, false) then Exit;
                ItemRec := lstLineItems.Last;
                ItemRec^.HirePartsSaleID := fieldByname('HirePartsSaleID').AsInteger;
                DisplayLineItem(lstLineItems.Last);
              end;

              Next;
            end;
          end;

          DisplayInViewer('Hire Conversion');
        end;
    finally
      DbsharedObj.ReleaseObj(QryHire);
    end;
  end;
  DisplayInViewer('Quote Conversion');
end;

procedure TPOSScreenForm.SetAppointID(const iAppointID: integer);
var
  qryAppoints: TERPQuery;
  rLabourCost: double;
  rCallout: double;
begin
  if (POSObj <> nil) then POSObj.appointId := iAppointId;
  rCallout := 0.0;
  rLabourCost := 0.0;

  if bTransComplete then begin
    ClearAll;
    bTransComplete  := false;
    self.iAppointID := iAppointID;
    qryAppoints     := TERPQuery.Create(nil);
    qryAppoints.Options.FlatBuffers := True;
    qryAppoints.Connection := CommonDbLib.GetSharedMyDacConnection;
    try
      with qryAppoints do begin
        // Appoints table
        SQL.Clear;
        SQL.Add('SELECT CusID, CalloutValue, TotalInc FROM tblAppointments ' +
          'WHERE AppointID = :xAppointID');
        Params.ParamByName('xAppointID').AsInteger := iAppointID;
        Open;
        if not IsEmpty then begin
          LoadCustomer(FieldByName('CusID').AsInteger);
          rCallout := FieldByName('CalloutValue').AsFloat;
          rLabourCost := FieldByName('TotalInc').AsFloat - rCallout;
        end else begin
          CommonLib.MessageDlgXP_Vista('Appoint ID "' + IntToStr(iAppointID) + '" not found'#13 +
            'in tblAppointments.', mtWarning, [mbOK], 0);
        end;
      end;
    finally
      FreeandNil(qryAppoints);
    end;

    // Post the Labour if there are any hrs to charge. it is possible to have 0
    // hrs to charge when teh cutomer has free hrs (its inc tax)
    if AppointmentTotalHours <> 0 then
        if FilterPartsByName(PART_LABOUR) then begin
            bPriceChange := true;
            rPriceChange := rLabourCost;
            bApplyDiscToPriceChange := true;
            //if AppEnv.CompanyPrefs.ShowServiceHrsInInvoiceQty then
                if PostSaleItem(PART_LABOUR, (DivZer(rLabourCost, AppointmentTotalHours)),
                    AppointmentTotalHours, 0, 0.0, 0.0, false, true, true) then begin
            {else
                PostSaleItem('Labour', (DivZer(rLabourCost, 1)),
                    1, 0, 0.0, 0.0, false, true, true, 0);}

                DisplayLineItem(lstLineItems.Last);
                PostAndDisplayAnyProductDisc;
            end;
    end;
    // post the freee hours only if there are free hrs
    //if AppEnv.CompanyPrefs.ShowServiceHrsInInvoiceQty  then
        if AppointmentFreeHours<> 0 then
            if FilterPartsByName(PART_LABOUR) then begin
                bPriceChange := true;
                rPriceChange := rLabourCost;
                bApplyDiscToPriceChange := true;
                if PostSaleItem(PART_LABOUR+'(Customer''s free hours)', (DivZer(0, AppointmentFreeHours)),
                    AppointmentFreeHours, 0, 0.0, 0.0, false, true, true) then begin
                    DisplayLineItem(lstLineItems.Last);
                    PostAndDisplayAnyProductDisc;
                end;
            end;

    // Post the Callout (its tax int too)
    if FilterPartsByName(PART_LABOUR) then begin
      bPriceChange := true;
      rPriceChange := rCallout;
      bApplyDiscToPriceChange := true;
      if PostSaleItem('CalloutValue',
        rCallout, 1, 0, 0.0, 0.0, false, true, true) then begin
        DisplayLineItem(lstLineItems.Last);
        PostAndDisplayAnyProductDisc;
      end;
    end;
  end;
  DisplayInViewer('Appointment Conversion');
end;



procedure TPOSScreenForm.DisplayInViewer(const sText1: string; const sText2: string = '');
begin
  ClearInputMemo;
  edtPOSMemo.Lines.Add(sText1);
  if not Empty(sText2) then begin
    edtPOSMemo.Lines.Add(sText2);
  end;
  TopOfViewer;
end;

function TPOSScreenForm.GetUpdatedLaybyBal(const   iLaybyID: integer; const rMasterBal: currency): currency;
  // Used to obtain the current layby balance including any payments for this sale
  // Takes into account that they may have
  // .. already made a repayment on this layby on this sale.
var
  pItem: pLineItemRec;
  i: integer;
begin
  Result := rMasterBal;
  for i := lstLineItems.Count - 1 downto 0 do begin
    pItem := lstLineItems[i];
    if pItem^.LaybyID = iLaybyID then begin
      Result := pItem^.LaybyBal;
      Break;
    end;
  end;
end;

function TPOSScreenForm.GetLaybyBal(const iLaybyId: integer): currency;
  // retrieves the current layby balance prior to transactions from the individual layby payments
  // T avoid issues we do this by adding the payments
var
  qryPayments: TERPQuery;
  qryAmount: TERPQuery;
begin
  Result := 0;
  qryPayments := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  qryAmount := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);

  try
    // first get original sale amount
    with qryAmount do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT TotalAmountInc ' +
        'FROM tblsales ' +
        'WHERE SaleID = :xSaleID');
      Params.ParamByName('xSaleID').AsInteger := iLaybyID;
      Open;
      if not IsEmpty then begin
        Result := FieldByName('TotalAmountInc').AsFloat;
      end;
    end;

    // Now get payments
    with qryPayments do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT LaybyID, SUM(TotalLineAmountInc) as TotalPayments ' +
        'FROM tblsaleslines ' +
        'WHERE LaybyID = :xLaybyID ' +
        'GROUP BY LaybyID');
      Params.ParamByName('xLaybyID').AsString := GetSaleGlobalRef(iLaybyId);
      Open;
      if not IsEmpty then begin
        Result := Result - FieldByName('TotalPayments').AsFloat;
      end;
    end;

  finally
    DbSharedObj.ReleaseObj(qryPayments);
    DbSharedObj.ReleaseObj(qryAmount);
  end;
end;

function TPOSScreenForm.GetQuantity: integer;
begin
  if (lstLineItems.Count <> 0) and (CurrentItem <> nil) then begin
    if currentItem^.IsToBeDeleted then begin
      Result := 0;
    end else begin
      Result := Trunc(currentItem^.Qty);
    end;
  end else begin
    Result := 0;
  end;
end;

function TPOSScreenForm.GetDummySaleID: integer;
var
  iMax: integer;
  qry: TERPQuery;
begin
{ We want to produce a unique SaleID that is not already being used and
  has a negligible risk of being used in the immediate future ( ie the time
  that it takes to do a transaction) }

  // we set the dummy saleID only once for each transaction
  // ..(iDummy Sale ID gets set to zero at end of each transaction)
  if iDummySaleID = 0 then begin
    iMax := MAX_INTEGER - 10; // just in case we run into trouble

    // get the maximum SaleID used (we can't be less than this
    qry := TERPQuery.Create(nil);
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    try
      with qry do begin
        // Sales table
        SQL.Clear;
        SQL.Add('SELECT MAX(SaleID) as MaxSaleID FROM tblSales');
        Open;
        if not IsEmpty then begin
          iMax := FieldByName('MaxSaleID').AsInteger;
        end;
      end;
    finally
      FreeAndNil(qry);
    end;

    // we are trying to get a range of numbers greater than the max ID used
    // .. that is unlikey to used in the immedite future (as described above)
    if iMax + 1000 < MAX_INTEGER then begin
      iMax := iMax + 1000;
    end else begin
      iMax := iMax + (MAX_INTEGER - iMax div 10);  //we are getting desperate now
    end;

    // Now, set our dummy ID
    iDummySaleID := RandomRange(iMax, MAX_INTEGER);
  end;
  Result := iDummySaleID;
end;

function TPOSScreenForm.GetProductID: integer;
begin
  if (lstLineItems.Count <> 0) and (CurrentItem <> nil) then begin
    Result := currentItem^.ProductID;
  end else begin
    Result := 0;
  end;
end;
function TPOSScreenForm.getClient :Tclient;
begin
    if iClientID = 0 then iClientID :=GetCashCustID;
    if not Assigned(fClient) then begin
        fClient := TClient.Create(Self);
        fClient.IsReadonly:= true;
    end;
    if fClient.ID <> iClientID then fClient.Load(iClientID);
    result := fClient;
end;
function TPOSScreenForm.GetClientID: integer;
begin
  Result := iClientID;
end;

procedure TPOSScreenForm.DoPayment(const sDescription: string; const sPayType: string);
var
  bOk: boolean;
  rTendered: currency;
begin
  if bIsSplitTab and not bSplitInProgress then begin
    CommonLib.MessageDlgXP_Vista('You have already commenced to Split this Tab.' + #13 + #10 + 'Please continue using "Split Tab" ', mtWarning, [mbOK], 0);
    Exit;
  end;

  rTendered := 0.0;
  bOk := true;

  if bSplitInProgress then begin
    rTendered := rAmountThisSplit;
  end else begin
    // get this payment amount
    if (EnteringNum = true) and (char_length(edtPOSMemo.Lines[0]) > 0) then begin
      if IsValidAmount() then begin
        rTendered := GetAmount;
      end else begin
        CommonLib.MessageDlgXP_Vista('Invalid Amount Entered', mtWarning, [mbOK], 0);
        bOk := false;
      end;
    end else begin
      rTendered := 0.0
    end;
  end;

  // Do Payment
  if bOk then DoPayment(rTendered, sDescription, sPayType);
end;


procedure TPOSScreenForm.DoPayment(const rTendered: currency; const sDescription: string; const sPayType: string);
var
  bIsFinalPayment: boolean;
  qry: TERPQuery;
  CardPaymentProcessed: boolean;
  PosCashSale: TPosCashSale;
begin
TRY
  try
    bIsFinalPayment := false;
    if IsLineItems() then begin
      if FinaliseAndCheckSale() then begin
        if sPayType = PAY_COMPLETE then begin
          bIsFinalPayment := true;

          // Record the payment
        end else begin
          case PostPayment(rTendered, sDescription, sPayType) of
            //POS_ERROR: bOK := False;
            FINAL_PAYMENT: bIsFinalPayment := true;
          end;
        end;
        if bIsSplitTab and bIsFinalPayment then begin
          bSplitInProgress := false;
          rSplitTabToPayAmount := rSplitTabToPayAmount - rAmountThisSplit;
          bIsFinalPayment := not (rSplitTabToPayAmount > 0);
          lblSplit.Caption := CurrencyToStrF(rSplitTabToPayAmount, ffCurrency);
          if sPayType <> PAY_TAB then begin
            if bPrintReceipt then begin
              CreateReceiptLists;
              PrintReceipt;
            end;
          end;
        end;

        // if all payments complete then post to DB
          if bIsFinalPayment then begin
            AddAnyVoucherReversals;
            if bIsSplitTab then begin
              PerformEndOfSplitTab;
              PostToDB;
              sSplitParentID := POSObj.Globalref;
              CreateSplitTabSales;
              DeleteBarTab(iTabClientID);  // remove all sales in the POS Sales tables for this client
            end else begin
              PostToDB;
            end;

            if not bIsTraining then begin
               if SavePOS then begin
                 { is this a card gateway payment .. }
                 if IsCardPayment(sPayType) then begin
                   if AppEnv.UtilsClient.PayGateway.Installed then begin
                     if AppEnv.UtilsClient.PayGateway.EnabledGatewayList <> '' then begin

                       CardPaymentProcessed:= false;
                       qry := TERPQuery.Create(nil);
                       try
                         qry.Connection := CommonDbLib.GetSharedMyDacConnection;
                         qry.SQL.Add('select tblsalespayments.PaymentID as PaymentID');
                         qry.SQL.Add('from tblsalespayments');
                         qry.SQL.Add('inner join tblpaymentmethods on tblpaymentmethods.name = tblsalespayments.PayMethod and tblpaymentmethods.IsCreditCard = "T"');
                         qry.SQL.Add('where tblsalespayments.SaleID = ' + IntToStr(iSaleID));
                         qry.Open;
                         while not qry.Eof do begin

                           if DoCardPayment(TSalesPayments,qry.FieldByName('PaymentID').AsInteger,AccessLevel,nil) then begin
                             { payment has been processed }
                             CardPaymentProcessed := true;

                           end
                           else begin
                             { ToDo: need to delete the pos transaction if user wants to }
                             if CommonLib.MessageDlgXP_Vista('Do you wish to Delete the Sale?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
                               try
                                 PosCashSale := TPosCashSale.CreateWithNewConn(nil);
                                 try
                                   PosCashSale.Connection.BeginTransaction;
                                   try
                                     PosCashSale.Load(iSaleID);
                                     while PosCashSale.Lines.Count > 0 do
                                       if not PosCashSale.Lines.Delete then break;
                                     PosCashSale.Deleted := true;
                                     PosCashSale.Save;
                                     PosCashSale.Connection.CommitTransaction;
                                   finally;
                                     if PosCashSale.Connection.InTransaction then
                                       PosCashSale.Connection.RollbackTransaction;
                                   end;

                                 finally
                                   PosCashSale.Free;
                                 end;
                               except
                                 on e: exception do begin
                                   CommonLib.MessageDlgXP_Vista('Error Deleting Sale: ' + e.Message,mtInformation,[mbOk],0);
                                 end;

                               end;
                             end;


                           end;

                           qry.Next;
                         end;
                       finally
                         qry.Free;
                       end;
                       if CardPaymentProcessed then begin
                         if not MakeBankDepositsForCardPayments(iSaleID) then begin

                         end;
                       end;
                     end
                     else begin
                       { no gateways enabled .. }
                     end;
                   end;
                 end;

                 if PickingSlipOnComplete then PrintPickingSlip(iSaleID);
                 CleanUp;
               end;
            end else
            CleanUp;
          end;
      end;
    end;
  except
      on E:Exception do begin
         MessageDlgXP_Vista('Failed to Save.' + chr(13) +E.message  +chr(13)+chr(13) +'Current Transaction will Be Cancelled.', mtWarning , [mbOK] , 0);
         PrintReceipt(True, True);
         Application.ProcessMessages;
         CancelOnError;
         if not canConnect then
              Self.close
         else BeginTransaction;
      end;
  end;
finally
    DisplayMemoFirstLineonPole;
end;
end;


procedure TPOSScreenForm.doPriceMAtrix;
var
  sMatrixDesc:String;
  sMatrixRef:String;
  dMatrixPrice:double;
  pItem: pLineItemRec;
begin
    pItem := CurrentRow;
    if pItem= nil then exit;
    if not ParthasPriceMatrix( PItem^.ProductId) then exit;
    sMatrixDesc := PItem^.MatrixDesc;
    sMatrixRef  := PItem^.MatrixRef;
    dMatrixPrice:= PItem^.MatrixPrice;
    TfmpartsPriceMatrixInput.PriceMAtrix(Self, sMatrixRef , sMatrixDesc , dMatrixPrice, PItem^.ProductId, Myconnection);
    SetMatrixDetails(PItem ,sMatrixDesc,sMatrixRef ,dMatrixPrice);
end;

function TPOSScreenForm.IsValidAmount(const bShowMessage: boolean = true): boolean;
  { returns false if amount is not a valid real number OR is less than zero }
var
  rAmount: double;
  iCode: integer;
begin
  Result := true;
  Val(edtPOSMemo.Lines[0], rAmount, iCode);
  if (iCode <> 0) or (rAmount < 0.0) then Result := false;
  if not Result and bShowMessage then CommonLib.MessageDlgXP_Vista('Not a Valid Amount', mtWarning, [mbOK], 0);
end;

function TPOSScreenForm.GetAmount: currency;
  { should not be used without calling IsValidAmount first }
var
  rAmount: double;
  iCode: integer;
begin
  Val(edtPOSMemo.Lines[0], rAmount, iCode);
  if iCode <> 0 then begin
    CommonLib.MessageDlgXP_Vista('Not a Valid Amount', mtWarning, [mbOK], 0);
  end;
  Result := RoundTo1C(rAmount);
end;


function TPOSScreenForm.PostPayment(const Tendered: currency; const sDescription: string; const sPayType: string): integer;
var
  rAmount: currency;
  rRounded: double;
  bOk: boolean;
  bIsExact: boolean;
  bIsCash: boolean;
  rPaidSoFar: currency;
  bIsFinalPayment: boolean;
  rBalance: currency;
  rTotalToPay: currency;
  rTendered: currency;
begin
  rTendered := Tendered;
  bOk := true;
  bIsFinalPayment := false;
  rPaidSoFar := RoundTo1C(GetPayments());
  bIsCash := (sPayType = PAY_CASH);
  bIsExact := false;
  self.sPayType := sPayType;
  rTendered := RoundTo1C(rTendered);

  if bIsSplitTab then begin
    rTotalToPay := rAmountThisSplit;
  end else begin
    rTotalToPay := rRunTot;
  end;

  if rTendered <> 0.0 then begin
    // If cash, then amount entered must be in 5 cent units
    if bIsCash then begin
      if not IsValidCashAmount(rTendered) then begin
        bOK := false;
      end;
    end;
    rBalance := rTotalToPay - rPaidSoFar
  end else begin
    // if nothing entered then assume that this payment completes the balance
    rBalance  := rTotalToPay - rPaidSoFar;
    rTendered := rBalance;
    bIsExact  := true;
  end;

  // if cash then do rounding to 5 cents (note: cash is only allowed if last in split)
  if bOk then begin
    if bIsCash then begin
      rRounded := POSRoundTo5C(rBalance);
      // check that cash tendered is not less than that required
      if not bIsExact and (rRounded > rTendered) then begin
        CommonLib.MessageDlgXP_Vista('Cash Tendered is less than required'#13 +
          'Cash can only be the final payment of a Split Tender'#13 +
          'Try Again',
          mtWarning, [mbOK], 0);
        bOk := false;
      end else begin
        if Abs(rRounded - rBalance) >= 0.00000999 then begin
          FilterPartsByName(PART_ROUNDING);
          if PostSaleItem(PART_ROUNDING, rRounded - rBalance,
            1, 0, 0.0, 0.0, false, true, false) then begin
            DisplayLineItem(lstLineItems.Last);
            rTotalToPay := rTotalToPay + (rRounded - rBalance);
          end;
        end;
        ReCalcRunTot;    // probably don't need this
        rPaidSoFar := GetPayments;
        rBalance := rTotalToPay - rPaidSoFar;
        if bIsExact then begin
          rTendered := rBalance;
        end else if rTendered < rBalance then begin
          CommonLib.MessageDlgXP_Vista('Amount Tendered is less than Balance', mtWarning, [mbOK], 0);
          bOk := false;
        end;
      end;
    end;
  end;

  // now do the payment
  if bOk then begin
    if bIsCash then begin
      rAmount := rBalance;
    end else begin
      rAmount := rTendered;
    end;

    // add payment to list
    AddPaymentToList(sPayType, sRef, rAmount, rTendered, iPayID, 0);

    // check if this is the final payment. Cash always completes a sale
    // .. and any other payment will complete if the run total is covered
    if bIsCash or (Abs((rAmount + rPaidSoFar) - rTotalToPay) < 0.00999) then begin
      bIsFinalPayment := true;
    end;

    // Display payment in viewer
    rChangeGiven := 0.0;
    if bIsCash then begin
      rCash := rAmount;
      rChangeGiven := rPaidSoFar + rTendered - rTotalToPay;
      DisplayInViewer('Cash Tendered:    ' +
        CurrencyToStrF(rTendered, ffCurrency),
        'Change:           ' + CurrencyToStrF(rChangeGiven, ffCurrency));
    end else begin
      DisplayInViewer(sDescription + ':' + CurrToStrRJ(rAmount, 13),
        'Balance:      ' +
        CurrToStrRJ(rTotalToPay - RoundTo1C(GetPayments()), 13));
    end;
  end;

//  sRef := '';
{ TODO :
May need to skip this if an error  occured
ie put in IF's below }
  EnteringNum(false);

  if not bOk then begin
    // should not get here unless Cash payment
    // If EFT was used then we are in deep trouble cuz the EFT payment to bank would
    // .. already be posted at this stage
    DisplayInViewer('Error - Try Again           '+AppEnv.RegionalOptions.CurrencySymbol+AppEnv.RegionalOptions.CurrencySymbol+AppEnv.RegionalOptions.CurrencySymbol+AppEnv.RegionalOptions.CurrencySymbol,
      'Balance:           ' +
      CurrToStrRJ(rTotalToPay - RoundTo1C(GetPayments()), 13));
    Result := POS_ERROR;
  end else if bIsFinalPayment then begin
    Result := FINAL_PAYMENT;
  end else begin
    Result := POS_SUCCESS;
  end;
end;

procedure TPOSScreenForm.AddPaymentToList(const sPayType, sRef: string; const rAmount, rTendered: currency;
  const iID, iLaybyID: integer);
  // Creates a payment in the payment list
var
  pPayRec: pPaymentRec;
begin
  New(pPayRec);
  with pPayRec^ do begin
    if sPayType = PAY_TAB then begin
      IsBarTab := true;
      ClientID := iClientID;
    end else begin
      IsBarTab := false;
      ClientID := 0;
    end;
    PaymentType := sPayType;
    Amount      := rAmount;
    Tendered    := rTendered;
    Ref         := sRef;
    LaybyID     := iLaybyID;
    Id          := iID;  // used only for vouchers at this stage
    if bIsSplitTab then begin
      SplitTabID := iSplitTabGroupID;
    end else begin
      SplitTabID := 0;
    end;
  end;
  lstPayments.Add(pPayRec);
end;

function TPOSScreenForm.GetPayments: currency;
var
  pPayRec: pPaymentRec;
  i: integer;
begin
  Result := 0.0;
  for i := 0 to lstPayments.Count - 1 do begin
    pPayRec := lstPayments[i];
    if pPayRec^.SplitTabID = iSplitTabGroupID then begin
      // NOTE: if we are not in a Split Tab Payments then iSplitTabGroupID will be
      // ..zero and should match all payments
      Result := Result + pPayRec^.Amount;
    end;
  end;
end;


procedure TPOSScreenForm.PostPaymentsToDB;
var
  pPay: pPaymentRec;
  i: integer;
begin
  // NOTE: Add Any field changes here to SummariseSales if appropriate
  for i := 0 to lstPayments.Count - 1 do begin
    pPay := lstPayments[i];
    POSObj.POSpayments.New;
    POSObj.POSpayments.PayMethod:= pPay^.PaymentType;
    POSObj.POSpayments.Amount := pPay^.Amount;
    POSObj.POSpayments.AmountTendered := pPay^.Tendered;
    POSObj.POSpayments.Ref :=pPay^.Ref;
    POSObj.POSpayments.PostDB;
  End;
end;

procedure TPOSScreenForm.SaveContext;
var
  pItem: pLineItemRec;
  i: integer;
begin
  with SavedContext do begin
    fbChqNoEntered := bChqNoEntered;
    fbPrevTransWasLayby := bPrevTransWasLayby;
//    fiRepairID   := iRepairID;
    fiQuoteID    := iQuoteID;
    fiHireID    := iHireID;
    fiAppointID  := iAppointID;
    fedtPOSMemoText := edtPOSMemo.Text;
    frQuantOfProd := rQuantOfProd;
    flblMemoTextCaption := lblMemoText.Caption;
    fsRef        := sRef;
    fiClientID   := iClientID;
    fbMustEnterIdNow := bMustEnterIdNow;
    flblSalesPersonCaption := lblSalesPerson.Caption;
    fiEmployeeID := iEmployeeID;
  end;
  //SavedContext.flstLineItems := TList.Create;
  for i := 0 to lstLineItems.Count - 1 do begin
    pItem := lstLineItems[i];
    NewLineItem;
    LineItem^ := pItem^;
    SavedContext.flstLineItems.Add(LineItem);
  end;
  bTransOnHold := true;
  lblOnHold.Visible := true;
end;


procedure TPOSScreenForm.LoadSavedContext;
begin
  { TODO : Update the date }
  with SavedContext do begin
    lstLineItems.Assign(flstLineItems);
    if lstLineItems.Count = 0 then
      exit;

    // we do not dispose of line items because they have been assigned
    // .. to lstLineItems - just free the TList;
    flstLineItems.Clear;
    bChqNoEntered := fbChqNoEntered;
    bPrevTransWasLayby := fbPrevTransWasLayby;
    iQuoteID    := fiQuoteID;
    iHireID    := fiHireID;
    iAppointID  := fiAppointID;
    edtPOSMemo.Text := fedtPOSMemoText;
    rQuantOfProd := frQuantOfProd;
    lblMemoText.Caption := flblMemoTextCaption;
    sRef        := fsRef;
    iClientID   := fiClientID;  // will need to LoadCustInfo
    bMustEnterIdNow := fbMustEnterIdNow;
    lblSalesPerson.Caption := flblSalesPersonCaption;
    iEmployeeID := fiEmployeeID;
  end;

  if iClientID <> 0 then begin
    LoadCustomer(iClientID);
  end;
  RebuildGrid;
  ClearInputMemo;
  bTransOnHold := false;
  bTransComplete := false;
  bPrintReceiptCount := 0; // reset counter
  lblOnHold.Visible := false;
end;

procedure TPOSScreenForm.InterruptFn;
begin
  if bIsPayTab then begin
    CommonLib.MessageDlgXP_Vista('Cannot Use Interrupt On A Tab ', mtInformation, [mbOK], 0);
    Exit;
  end;
  if bTransOnHold then begin

    if IsLineItems() then begin
      CommonLib.MessageDlgXP_Vista('You cannot restore until the current Transaction is complete', mtWarning, [mbOK], 0);
    end else if CommonLib.MessageDlgXP_Vista('Do you wish to restore the interrupted sale',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      Cleanup;
      ClearAll;
      LoadSavedContext;
      EnteringNum(false);
      DisplayInViewer('Transaction Restored');
    end;
  end else begin
    if not IsLineItems() then begin
      CommonLib.MessageDlgXP_Vista('No Sales to Interrupt', mtWarning, [mbOK], 0);
    end else if bRefundMode then begin
      CommonLib.MessageDlgXP_Vista('Cannot Interrupt if in Refund mode', mtWarning, [mbOK], 0);
    end else if bPriceChange then begin
      CommonLib.MessageDlgXP_Vista('Cannot Interrupt if in Price Change mode', mtWarning, [mbOK], 0);
    end else begin
      SaveContext;
      CleanUp;
      ClearAll;
      DisplayInViewer('Transaction On Hold');
    end;
  end;
end;


procedure TPOSScreenForm.OnVoucherSelect(Sender: TwwDBGrid);
var
  i:Integer;
begin
  if Sender.SelectedList.Count>0 then begin
    for i := 0 to Sender.SelectedList.Count - 1 do begin
          Sender.datasource.dataset.GotoBookmark(Sender.SelectedList.Items[i]);
          if Sender.datasource.dataset.fieldByname('VoucherID').asinteger <> 0 then
            edtVoucherID.Text := Sender.DataSource.DataSet.FieldByName('VoucherID').AsString;
          Application.ProcessMessages;
    end;
  end else begin
    edtVoucherID.Text := Sender.DataSource.DataSet.FieldByName('VoucherID').AsString;
  end;
end;
function TPOSScreenForm.EnteredNumAsFloat: Double;
begin
  result:= 0;
  if isnumber(edtPOSMemo.Lines[0]) then result := StrToFloat(edtPOSMemo.Lines[0]);
end;
//Function TPOSScreenForm.EnteredNumAsinteger:Integer;
//begin
//  result:= 0;
//  if isinteger(edtPOSMemo.Lines[0]) then result := strtoint(edtPOSMemo.Lines[0])
//  else if isnumber(edtPOSMemo.Lines[0]) then result := trunc( StrToFloat(edtPOSMemo.Lines[0]));
//end;
Function TPOSScreenForm.VoucherNoRange(var VNOFrom, VNOto: Int64):Boolean;
begin
    With TFmPOSInput.Create(Self) do try
      VNOfrom := 0;
      VNOTo:= 0;
      Caption1:= 'From';
      Caption2:= 'To';
      TitleLabel.Caption := 'Voucher Number Range Entry';
      EditMask1:= '#[#][#][#][#][#][#][#][#][#][#][#][#][#][#][#][#][#]';
      EditMask2:= '#[#][#][#][#][#][#][#][#][#][#][#][#][#][#][#][#][#]';
      value1 := NextVoucherno(nil);
      value2 := value1+99;
      if devmode then value2 := value1+5;
      IF showModal = mrok then begin
        VNOfrom := Value1;
        VNOTo:= Value2;
      end;
      result := (Vnofrom<>0) and (VNoTo<>0);
      if Vnofrom>VNoTo then begin
        VNoTo   :=Vnofrom+VNoTo;
        Vnofrom :=VNoTo -Vnofrom;
        VNoTo   :=VNoTo - Vnofrom;
      end;
    finally
      Free;
    end;
end;
procedure TPOSScreenForm.edtVoucherIDChange(Sender: TObject);
var
  qry: TERPQuery;
  sStore, svouchervalue: string;
  pPayItem: pPaymentRec;

begin
  inherited;
  if char_length(edtVoucherID.Text) <> 0 then begin
    if edtVoucherID.Text <> '0' then begin
      qry := TERPQuery.Create(nil);
      qry.Options.FlatBuffers := True;
      qry.Connection := CommonDbLib.GetSharedMyDacConnection;
      try
        if not IsVoucherAlreadySelected(FastFuncs.StrToInt(edtVoucherID.Text)) then begin
          // Get voucher details for this voucher
          with qry do begin
            // Vouchers table
            Close;
            SQL.Clear;
            SQL.Add('SELECT VoucherNo, Value, IsRedeemed FROM tblvouchers ' +
              'WHERE VoucherID = :xVoucherID');
            Params.ParamByName('xVoucherID').AsInteger := FastFuncs.StrToInt(edtVoucherID.Text);
            Open;
            if not IsEmpty then begin
              if not FieldByName('IsRedeemed').AsBoolean then begin
                EnteringNum(True);
                DisplayInViewer(FieldByName('Value').AsString);
                sRef := FieldByName('VoucherNo').AsString;
                iPayID := FastFuncs.StrToInt(edtVoucherID.Text);
                DoPayment('Voucher', PAY_VOUCHER);
              end else begin
                CommonLib.MessageDlgXP_Vista('Voucher ' +  Quotedstr(edtVoucherID.Text) +' has already been redeemed.', mtWarning, [mbOK], 0);
              end;
            end else begin
              CommonLib.MessageDlgXP_Vista('Could not retrieve Voucher details of ' +  Quotedstr(edtVoucherID.Text) +' , cannot redeem', mtWarning, [mbOK], 0);
            end;
          end;
        end;
      finally
        FreeAndNil(qry);
      end;
    end else begin
      if CommonLib.MessageDlgXP_Vista('You have not selected a Voucher to Redeem, Do you wish to ' +
        #13 + #10 + 'Redeem a Voucher anyway?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
        // get the Issuing store
        MemoInput('Enter Issuing Store', sStore);
        // get the voucher number
        MemoInput('Enter Voucher Number', sRef);
        // get the Dollar Amount
        if MemoInput('Enter Voucher Value', svouchervalue) then begin
              EnteringNum(True);
              DisplayInViewer(FloatToStr(StrValue(svouchervalue))); // must rename edtChequeno !!!
              iPayID := -1;
              DoPayment('Voucher-NO ISSUE', PAY_VOUCHER);
              pPayItem := lstPayments.Last;
              pPayItem^.IssuedBy := sStore;
        end ;
      end;
    end;
  end;
end;

function  TPOSScreenForm.LockVoucher:boolean ;
var
  ErrMsg:String;
begin
  result := true;
  if not userlock.enabled then userlock.enabled := True;
  if not (userlock.Lock('tblvouchers' , 0, 'POS')) then begin
      {alter the lock message for the locked record
      the locked record can be the current record, any of the BO record, or the parent record}
      ErrMsg := Replacestr(ReplaceStr(ReplaceStr(userlock.LockMessage, 'Unable to update data.' , 'Unable to make/redeem voucher.' ) , 'this record' , 'Vouchers') , 'Record' , 'Vouchers');
      CommonLib.MessageDlgXP_Vista(ErrMsg , mtWarning, [mbOK], 0);
      REsult:= False;
  end;
end;
procedure TPOSScreenForm.VoucherFn(FnID:Integer);
begin
  if not Lockvoucher then exit;

  if idOk() then begin
    if EnteringNum then begin
      if (fnId= FN_VOUCHER_GROUP) then begin
          MakevoucherforRange;
      end  else begin
        VoucherIssueFn;
      end;
    end else begin
      VoucherRedeemFn;
    end;
  end;
end;
procedure TPOSScreenForm.VoucherIssueFn;
var
  rAmount: currency;
  bOk: boolean;
begin
  if IsVoucherAllowed  then begin
    bOk     := true;
    rAmount := 0.0;
    if EnteringNum then begin
      // Convert to float
      try
        rAmount := StrToFloat(edtPOSMemo.Lines[0]);
      except
        on EConvertError do begin
          CommonLib.MessageDlgXP_Vista('Not a valid cash amount', mtWarning, [mbOK], 0);
          bOK := false;
        end;
      end;

      if bOK then begin
        // get the voucher number
          if GetVouchernumber then begin
            // POst voucher
            FilterPartsByName(PART_VOUCHER);
            if not PostSaleItem('Voucher No: ' + sVoucherNo, rAmount, 1, 0, 0.0, 0.0, true, true, false) then Exit;
            DisplayLineItem(lstLineItems.Last);
            bIsVoucher := true;
            EnteringNum(false);
          end else edtPOSMemo.lines.clear;
        end;
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('You cannot mix a Voucher with other Products.', mtWarning, [mbOK], 0);
  end;
end;

function TPOSScreenForm.MakeBankDepositsForCardPayments(
  const aSaleId: integer): boolean;
var
  BankDeposit: TBankDeposit;
  CashSale: TCashSale;
  qry: TERPQuery;
  BankAccount: string;
begin
  result := true;
  try
    BankAccount := '';
    BankDeposit := TBankDeposit.CreateWithNewConn(nil);
    CashSale := TCashSale.CreateWithSharedConn(nil);
    qry := TERPQuery.Create(nil);
    try
      BankDeposit.SilentMode := true;
      BankDeposit.Connection.BeginTransaction;
      try
        qry.Connection := CashSale.Connection.Connection;
        qry.SQL.Add('select * from tblcardpayment');
        qry.SQL.Add('inner join tblsalespayments on tblsalespayments.PaymentID = tblcardpayment.ERPTransID and tblsalespayments.SaleID = ' + IntToStr(aSaleID));
        qry.SQL.Add('where ERPTransType = "TSalesPayments"');
        qry.SQL.Add('and PaymentStatus = 1');
        qry.Open;
        if qry.IsEmpty then exit;
        CashSale.Load(aSaleID);
        while not qry.Eof do begin

          if not SameText(BankAccount, qry.FieldByName('ERPBankAccount').AsString)  then  begin
            BankDeposit.IsDepositEntry := true;
            BankAccount := qry.FieldByName('ERPBankAccount').AsString;
            BankDeposit.New;
            BankDeposit.DepositDate          := Trunc(Now);
            BankDeposit.PostDB;
            BankDeposit.EmployeeId           := CashSale.EmployeeID;
            BankDeposit.classId              := CashSale.SaleClassId;
            BankDeposit.AccountId            := TAccount.IDToggle(BankAccount);
            BankDeposit.Notes                := 'Cash Sale Card Payment';
            BankDeposit.Deposit              := 0; // -(TotalAmountInc);
            BankDeposit.Deleted              := False;
            BankDeposit.PostDB;
          end;

          if not CashSale.SalesPayments.LocateId(qry.FieldByName('ERPTransID').ASInteger) then
            raise Exception.Create('Could not find Card Payment matching Sales Payment record');

          BankDeposit.Lines.New;
          BankDeposit.Lines.PaymentID     := aSaleID;
          BankDeposit.Lines.TrnsType      := 'POS Cash Sale';
          BankDeposit.Lines.CusID         := CashSale.CustomerID;
          //BankDeposit.Lines.PayMethodID   := 0;
          BankDeposit.Lines.PaymentMethod := CashSale.SalesPayments.PayMethod;
          BankDeposit.Lines.PaymentDate   := BankDeposit.DepositDate;
          BankDeposit.Lines.CompanyName   := CashSale.CustomerName;
          BankDeposit.Lines.ReferenceNo   := 'Card Payment';
          BankDeposit.Lines.ClassID       := CashSale.SaleClassId;
          BankDeposit.Lines.AccountID     := BankDeposit.AccountId;
          BankDeposit.Lines.AccountName   := BankAccount;
          BankDeposit.Lines.LineName      := '';
          BankDeposit.Lines.TransID       := IntToStr(aSaleID);
          BankDeposit.Lines.FromDeposited := true;
          BankDeposit.Lines.Amount        := CashSale.SalesPayments.Amount;
          BankDeposit.Lines.Notes         := qry.FieldByName('Gateway').AsString + ' ' + qry.FieldByName('CurrencyCode').AsString + ' card payment';
          BankDeposit.Lines.Customer      := False;
          BankDeposit.Lines.Supplier      := false;
          BankDeposit.Lines.Employee      := False;
          BankDeposit.Lines.Contact       := False;
          BankDeposit.Lines.Deposited     := True;
          BankDeposit.Lines.StatementNo   := 0;
          BankDeposit.Lines.PostDB;

          BankDeposit.LinesSales.New;
          BankDeposit.LinesSales.bankdepositlinesID := BankDeposit.Lines.ID;
          BankDeposit.LinesSales.TransID := aSaleID;
          BankDeposit.LinesSales.PaymentMethod := CashSale.SalesPayments.PayMethod;
          BankDeposit.LinesSales.PaymentID := CashSale.SalesPayments.ID;
          BankDeposit.LinesSales.Amount := CashSale.SalesPayments.Amount;
          BankDeposit.LinesSales.PostDB;

          BankDeposit.Deposit := BankDeposit.Deposit + BankDeposit.Lines.Amount;
          BankDeposit.BankDepositTotal := BankDeposit.Deposit;
          BankDeposit.PostDB;

          qry.Next;
        end;
        BankDeposit.Dirty := true;
        if not BankDeposit.Save then begin
          result := false;
          CommonLib.MessageDlgXP_Vista('Could not create a Benk Deposit for the Card Payment: ' + BankDeposit.ResultStatus.Messages,mtInformation,[mbOk],0);
          exit;
        end;

        BankDeposit.Connection.CommitTransaction;
      finally
        if BankDeposit.Connection.InTransaction then
          BankDeposit.Connection.RollbackTransaction;
      end;
    finally
      CashSale.Free;
      BankDeposit.Free;
      qry.Free;
    end;
  except
    on e: exception do begin
      result := false;
      CommonLib.MessageDlgXP_Vista('Could not create a Benk Deposit for the Card Payment: ' + e.Message, mtInformation,[mbOk],0);
    end;
  end;
end;

Procedure TPOSScreenForm.MakeVoucherforRange;
var
  VNoFrom , VNoTo :Int64;
  ctr:Integer;
  ErrMsg:String;
  Option : word;
  Amount:Double;
  st:TStringlist;
  il: TIntegerlist;
  ItemRec: pLineItemRec;
begin
  if IsVoucherAllowed then begin
    if VoucherNoRange(VNOFrom, VNOto) then begin
      st:=TStringlist.Create;
      il:= TIntegerlist.create;
      try
        for ctr:= VNOFrom to  VNOto do begin
           if Validvoucherno(inttostr(ctr) , ErrMsg) then il.add(ctr)
           else st.Add(trim(ErrMsg));
              // POst voucher
        end;

        option := mrno;
        if st.count=0 then option := mryes
        else if il.count>0 then Option := MessageDlgXP_Vista('The following Voucher number(s) are found invalid.'+Nl+Nl+st.text+NL+'Do you wish to create vouchers for the Valid numbers?', mtConfirmation, [mbYes, mbNo], 0 ,nil , '' , '' , False, nil , '' , '' , 450 )
        else MessageDlgXP_Vista('The Voucher number(s) are all found invalid'+Nl+st.text+NL+'Please provide another Range', mtWarning, [mbok], 0 ,nil , '' , '' , False, nil , '' , '' , 450 );

        Amount:=EnteredNumAsFloat;
        if option = mryes then begin
          for ctr:= 0 to il.count-1 do begin
              FilterPartsByName(PART_VOUCHER);
              sVoucherNo:= inttostr(il[ctr]);
              if not PostSaleItem('Voucher No: ' + inttostr(il[ctr]), Amount, 1, 0, 0.0, 0.0, true, true, false) then Exit;
              ItemRec := lstLineItems.Last;
              ItemRec^.PriceChanged:= true;
              DisplayLineItem(lstLineItems.Last);
          end;
          bIsVoucher := true;
        end;
        EnteringNum(false);
        edtPOSMemo.lines.clear;
      finally
        FreeandNil(st);
      end;
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('You cannot mix a Voucher with other Products.', mtWarning, [mbOK], 0);
  end;
end;
Function TPOSScreenForm.VoucherRedeemFn:boolean;
begin
    OpenERPListFormultiselectModal('TVoucherListGUI' , nil , OnVoucherSelect);
    Result:= True;
end;

function TPOSScreenForm.IsVoucherAlreadySelected(const iVoucherID: integer): boolean;
var
  pPayment: pPaymentRec;
  i: integer;
begin
  Result := false;
  if lstPayments.Count <> 0 then begin
    for i := 0 to lstPayments.Count - 1 do begin
      pPayment := lstPayments[i];
      if pPayment^.Id = iVoucherID then begin
        CommonLib.MessageDlgXP_Vista('You have already selected this voucher - try again', mtWarning, [mbOK], 0);
        Result := true;
        Break;
      end;
    end;
  end;
end;

function TPOSScreenForm.IsProductAllowed: boolean;
  { product is not allowed if there is a layby on this sale }
begin
  //  result := (not bIsVoucher) and (not bIsLaybyPayment);
  Result := not bIsLaybyPayment;
end;

function TPOSScreenForm.IsVoucherAllowed: boolean;
  { returns true if no non-voucher items exist for this sale  - (no longer used)}
begin
  Result := true;
end;

function TPOSScreenForm.IsLaybyPayAllowed: boolean;
  { returns true if no lines (other than  layby payments) exits for this sale }
begin
  if bIsLaybyPayment or not IsLineItems() then begin
    Result := true;
  end else begin
    Result := false;
  end;
end;

procedure TPOSScreenForm.AddAnyVoucherReversals;
var
  pPayment: pPaymentRec;
  pVoucherReversal: pPaymentRec;
  i: integer;
begin
  for i := 0 to lstPayments.Count - 1 do begin
    pPayment := lstPayments[i];
    if pPayment^.PaymentType = PAY_VOUCHER then begin
      // create the reverse voucher Part
      FilterPartsByName(PART_VOUCHER_PAY);
      if not PostSaleItem('Voucher Payment: ' + pPayment^.Ref, - pPayment.Amount, 1, 0, 0.0, 0.0, false, true, false) then Exit;
      DisplayLineItem(lstLineItems.Last);

      // create the reverse voucher payment
      New(pVoucherReversal);
      lstPayments.Add(pVoucherReversal);
      pVoucherReversal^.PaymentType := PAY_VOUCHER_REVERSAL;
      pVoucherReversal^.Amount := -pPayment^.Amount;
      pVoucherReversal^.Ref := pPayment^.Ref;
      pVoucherReversal^.ID := pPayment^.ID;
      pVoucherReversal^.VoucherID := pPayment^.VoucherID;
      pVoucherReversal^.IssuedBy := pPayment^.IssuedBy;
      pVoucherReversal^.LaybyId := 0;
    end;
  end;
end;

function TPOSScreenForm.IsAnyLaybyPayments: boolean;
var
  pItem: pLineItemRec;
  i: integer;
begin
  Result := false;
  for i := 0 to lstLineItems.Count - 1 do begin
    pItem := lstLineItems[i];
    if pItem^.LaybyId <> 0 then begin
      Result := true;
      Break;
    end;
  end;
end;

function TPOSScreenForm.AssignBarcode(const iPartNumber: integer): boolean;
var
  IsReadOnlySave: boolean;
begin
  Result := false;
  Product.Load(iPartNumber);
  // if we have found part number then we can check if ok to assign barcode
  if Product.count > 0 then begin
    if Empty(Product.BARCODE) then begin
      if Product.Lock then try
        IsReadOnlySave:= Product.IsReadOnly;
        Product.IsReadOnly:= false;
        try
          Product.BARCODE:= sBarcode;
          Product.Postdb;
        finally
          Product.IsReadOnly:= IsReadOnlySave;
        end;
        Result := true;
      finally
        Product.UnLock;
      end;
    end else begin
      CommonLib.MessageDlgXP_Vista('Barcode Not Assigned - This Product already has a Barcode.', mtWarning, [mbOK], 0);
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('No such Product with ID: ' +IntToStr(iPartNumber),mtWarning, [mbOK], 0);
  end;
end;

function TPOSScreenForm.AssignSwipeCard(const sCardNum: string; const iCustID: integer): boolean;
  // Assigns the swipe card number to the client specified
var
  qry: TERPQuery;
begin
  Result := false;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  qry.ParamCheck := true;
  qry.Options.StrictUpdate := false;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT ClientID, CardNumber ' +
      'FROM tblClients ' +
      'WHERE Active = "T" AND ClientID = :xClientID');
    qry.Params.ParamByName('xClientID').AsInteger := iCustID;
    qry.Open;

    // if we have found part number then we can check if ok to assign barcode
    if not qry.IsEmpty then begin
      if not Empty(qry.FieldByName('CardNumber').AsString) then begin
        if CommonLib.MessageDlgXP_Vista('This Client Already has a Card assigned. ' + #13 + #10 +
          'Do you wish to replace with this Card?',
          mtConfirmation, [mbYes, mbNo], 0) <> mrYes then begin
          Exit;
        end;
      end;
      qry.Edit;
      qry.FieldByName('CardNumber').AsString := sCardNum;
      qry.Post;
      Result := true;
    end else begin
      CommonLib.MessageDlgXP_Vista('No such Client with ID: ' + IntToStr(iCustID), mtWarning, [mbOK], 0);
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TPOSScreenForm.AssignAccountNumber(const sAccountNum: string; const iCustID: integer): boolean;
  // Assigns the Account No to the client specified
var
  qry: TERPQuery;
begin
  Result := false;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  qry.ParamCheck := true;
  qry.Options.StrictUpdate := false;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT ClientID, ClientNo ' +
      'FROM tblClients ' +
      'WHERE ClientID = :xClientID');
    qry.Params.ParamByName('xClientID').AsInteger := iCustID;
    qry.Open;

    // if we have found part number then we can check if ok to assign barcode
    if not qry.IsEmpty then begin
      if not Empty(qry.FieldByName('ClientNo').AsString) then begin
        if CommonLib.MessageDlgXP_Vista('This Client Already has an Account No assigned. ' + #13 + #10 +
          'Do you wish to replace with this Account No?',
          mtConfirmation, [mbYes, mbNo], 0) <> mrYes then begin
          Exit;
        end;
      end;
      qry.Edit;
      qry.FieldByName('ClientNo').AsString := sAccountNum;
      qry.Post;
      Result := true;
    end else begin
      CommonLib.MessageDlgXP_Vista('No such Client with ID: ' + IntToStr(iCustID), mtWarning, [mbOK], 0);
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TPOSScreenForm.IsPrinterToggledOn: boolean;
var
  qry: TERPQuery;
begin
  Result := false;
  if AppEnv.CompanyPrefs.ReceiptPrinterON then begin
    qry := TERPQuery.Create(nil);
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    try
      with qry do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT ReceiptPrinterToggled FROM tblPOSTills ' +
          'WHERE TillID = :xTillID');
        Params.ParamByName('xTillID').AsInteger := iTillID;
        Open;
        if not IsEmpty then begin
          Result := FieldByName('ReceiptPrinterToggled').AsBoolean;
        end;
      end;
    finally
      FreeAndNil(qry);
    end;
  end else begin
    Result := false;
  end;
end;

procedure TPOSScreenForm.SetPrnStatus(const bStatus: boolean);
var
  qry: TERPCommand;
begin
  qry := TERPCommand.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qry.SQL.Add('UPDATE tblPOSTills SET ReceiptPrinterToggled = :xReceiptPrinterToggled ' +
      'WHERE TillID = :xTillID');
    qry.Params.ParamByName('xTillID').AsInteger := iTillID;
    if bStatus then begin
      qry.Params.ParamByName('xReceiptPrinterToggled').AsString := 'T';
    end else begin
      qry.Params.ParamByName('xReceiptPrinterToggled').AsString := 'F';
    end;
    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TPOSScreenForm.IndicatePrnStatus;
begin
  if bIsUsingReceiptPrinter then begin
    if bIsPrinterToggledOn then begin
      lblPrn.Caption := 'ON';
    end else begin
      lblPrn.Caption := 'OFF';
    end;
  end else begin
    lblPrn.Caption := 'N/A';
  end;
end;


function TPOSScreenForm.LoadRefund(const sGblRef: string): boolean;
begin
  Result := false;
    with TempMyQuery do try
      Close;
      SQL.Clear;
      saleIdtoRefund:=GetSaleIDForGlobalRef(sGblRef);
      try
          SQL.add('SELECT SL.SaleLineID, SL.ProductID , SL.Product_Description, SL.LinePrice,SL.QtySold,SL.UnitOfMeasureID , SL.UnitofMeasureMultiplier ,'+
                  ' SL.shipped - ifnull((Select 0 - Sum(Shipped) refunded from tblsaleslines inner join tblsales using (SaleID) where RefundedSalesLineID= SL.saleLineID and converted ="F"),0) as  qtytorefund  '+
                  ' FROM tblSalesLines  SL   WHERE  SL.SaleID = '+ inttostr(saleIdtoRefund));
          Open;
          First;
          if not IsEmpty then begin
            bLoadedRefund := true;
            while not Eof do begin
              // post the part
              if DivZer(FieldByName('qtytorefund').AsFloat , Fieldbyname('UnitofMeasureMultiplier').asFloat) >0 then begin
                Result := true;
                if FilterPartsByID(FieldByName('ProductID').AsInteger) then begin
                  if not PostSaleItem(FieldByName('Product_Description').AsString,
                    FieldByName('LinePrice').AsFloat*Fieldbyname('UnitofMeasureMultiplier').asFloat,
                    DivZer(FieldByName('qtytorefund').AsFloat , Fieldbyname('UnitofMeasureMultiplier').asFloat),
                    0, 0.0, 0.0, false, false, false, false, false,
                    FieldByName('UnitOfMeasureID').AsInteger, FieldByName('SAleLineID').AsInteger) then Exit;
                end;
              end;
              Next;
            end;
            if Result =False then begin
               REsult:= True;
               if CommonLib.MessageDlgXP_Vista('This Sale is completely Refunded. Do you want to see the product(s) and qty of this sale?', mtconfirmation , [mbyes, mbno],0)= mrYes then
                OpenERPListFormModal('TSoldnRefundQtyofSalesGUI' , SelectSalesLinesToRefund , inintSoldnRefundQtyofSales);
            end;
            RebuildGrid;
            bLoadedRefund := false;
          end;
      finally
        saleIdtoRefund:=0;
      end;
  finally
    if active then close;
    free;
  end;
end;
procedure TPOSScreenForm.SelectAllLines(Select: boolean = true);
var
  x: integer;
begin
  for x := 0 to lstLineItems.Count -1 do begin
    pLineItemRec(lstLineItems[x])^.Selected := Select;
  end;
  grdTrans.Invalidate;
end;

procedure TPOSScreenForm.SelectSalesLinesToRefund(Sender: twwDBGrid);
var
  i:Integer;
begin
  if sender.SelectedList.Count > 0 then begin
      for i := 0 to sender.SelectedList.Count - 1 do begin
                sender.Datasource.DataSet.GoToBookmark(Sender.SelectedList.Items[i]);
                if FilterPartsByID(sender.Datasource.DataSet.FieldByName('ProductID').AsInteger) then begin
                  PostSaleItem(sender.Datasource.DataSet.FieldByName('Product_Description').AsString,
                    sender.Datasource.DataSet.FieldByName('LinePrice').AsFloat,
                    sender.Datasource.DataSet.FieldByName('shipped').AsFloat,
                    0, 0.0, 0.0, false, false, false, false, false,
                    sender.Datasource.DataSet.FieldByName('UnitOfMeasureID').AsInteger, sender.Datasource.DataSet.FieldByName('SAleLineID').AsInteger);
                end;
      end;
    end;
end;
procedure TPOSScreenForm.SelectUOMFn;
var
  pItem: pLineItemRec;
  unitID:Integer;
begin
  if oPOSBtnMatrix.Selected.Func.Description = '' then exit;
  pItem := CurrentRow;
  if not Assigned(pItem) then exit;
  if PItem^.ProductID =0 then exit;
  unitID:= tcDatautils.GetUnitOfMeasureID(oPOSBtnMatrix.Selected.Func.Description  , PItem^.ProductID );
  if unitID <> 0 then begin
    edtUnitID.text := ''; { to make sure onChange event fires }
    edtUnitID.Text := inttostr(unitID);
  end else begin
    CommonLib.MessageDlgXP_Vista('Unit of measure ' +quotedstr(oPOSBtnMatrix.Selected.Func.Description ) +' doesn''t exists for ' + AppEnv.DefaultClass.PartColumn + ' ' +quotedstr(PItem^.ProductName), mtWarning, [mbOK], 0);
  end;
end;

procedure TPOSScreenForm.inintSoldnRefundQtyofSales(Sender: TObject);
begin
   if not(Sender is TSoldnRefundQtyofSalesGUI) then exit;
   TSoldnRefundQtyofSalesGUI(Sender).SaleId :=saleIdtoRefund;
   TSoldnRefundQtyofSalesGUI(Sender).caption := 'Sold n Refund Qty of Sale # ' + inttostr(saleIdtoRefund);
   TSoldnRefundQtyofSalesGUI(Sender).lblNote.Caption := 'Choose Product(s) to be refunded and ''Select'' option to add the selected Product(s) and its ''Shipped Quantity'' to refund.';
   TSoldnRefundQtyofSalesGUI(Sender).HighlightControl(TSoldnRefundQtyofSalesGUI(Sender).cmdPrint);
end;

procedure TPOSScreenForm.PrintPickingSlip(const SaleID: integer);
var
  sSQL: string;
  TemplateName:STring;
  Json: TJsonObject;
begin
    TemplateName := tcdatautils.GetDefaultReport( 30);
    if TemplateName = '' then TemplateName := 'Picking Slip';

    sSQL:= PrintPickingSlipsLib.SQL4PickingSlipreport(TemplateName,Json, IntToStr(SaleID));
    fbReportSQLSupplied := true;
    PrintTemplateReport(TemplateName, sSQL, not AppEnv.Employee.ShowPreview, 1 , Json);

end;
procedure TPOSScreenForm.SubProductFn;
var
  fiGroupID :Integer;
POSBtnMatrixSelected: TPosBtn;
begin
  POSBtnMatrixSelected := oPOSBtnMatrix.Selected;
    fiGroupID := POSBtnMatrixSelected.Func.PartNumber;
    if fiGroupID <> 0 then
      TfmProdAttribmatrix.DoproductAttribute(Self, fiGroupID,Createtransrec);
end;
procedure TPOSScreenForm.PickingSlipFn;
begin
  if AppEnv.CompanyPrefs.POSSummarise then Begin
    PickingSlipOnComplete := false;
    CommonLib.MessageDlgXP_Vista('Cannot Print Picking Slip In Summarise Mode.', mtInformation, [mbOK], 0);
    Exit;
  end;

  if PickingSlipOnComplete then begin
    PickingSlipOnComplete := false;
    CommonLib.MessageDlgXP_Vista('Picking Slip Print Disabled.', mtInformation, [mbOK], 0);
  end else begin
    PickingSlipOnComplete := true;
    CommonLib.MessageDlgXP_Vista('Picking Slip Will Print on Completion of this Sale.', mtInformation, [mbOK], 0);
  end;
end;
procedure TPOSScreenForm.PlayerNotify(Sender: TObject);
begin
  if (pnlMediaHost.visible) and (Player.Mode = mpStopped) then
  begin
    Player.Rewind;
    Player.play;
  end;
   //must set to true to enable next-time notification
   Player.Notify := True;
end;

procedure TPOSScreenForm.PlayFile;
var
  lRatio : double;
begin
  tmrMedia.Enabled := false;
  try

    if VideoFiles.Count = 1 then
    begin
      if Player.FileName <> '' then
      begin
        Player.Rewind;
        Player.Play;
        exit;
      end;
    end;

  if Player.FileName <> '' then
    Player.Close;
  Player.FileName := VideoFiles.Next;
  Player.Shareable := true;
  Player.Open;
  if csUseRatio then
  begin
    lRatio := Player.DisplayRect.Bottom / Player.DisplayRect.Right;
  //  Self.Height := round(Self.Width * lRatio);
  // DisplayRect is to be changed after the call to Open, since Open sets it to the video frame sizes
  //Player.DisplayRect := Panel1.ClientRect;
    pnlDisplay.Left := 0;
    pnlDisplay.Width := pnlMediaHost.Width;
    pnlDisplay.Height := system.Round(pnlMediaHost.Width * lRatio);
    pnlDisplay.Top := (pnlMediaHost.Height - pnlDisplay.Height) div 2;
  end
  else
    pnlDisplay.Align := alClient;

  Player.DisplayRect := pnlDisplay.ClientRect;
  Player.Play;
  finally
  tmrMedia.Enabled := true;
  end;
end;

procedure TPOSScreenForm.lblTillHeadMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  inherited;
  if ssCtrl in Shift then begin
    bDebugTrafficPro := true;
  end;
end;

procedure TPOSScreenForm.FixedAmountFn;
var
  s: string;
  sNew: string;
begin
  s := oPOSBtnMatrix.Selected.Line1.Caption;
  sNew := FloattoStr(StrValue(s));
  DisplayInViewer(sNew);
  EnteringNum(True);
end;

procedure TPOSScreenForm.pnlNumericKeyPadClick(Sender: TObject);
begin
  inherited;
  //  CommonLib.MessageDlgXP_Vista('Got here');
end;

procedure TPOSScreenForm.btnNumPadClick(Sender: TObject);
var
  btn: TDNMSpeedButton;
begin
  inherited;
  if Sender is TDNMSpeedButton then begin
  try
    btn := TDNMSpeedButton(Sender);
    if btn = btnNumBS then begin
      POSKeyDown(word(VK_BACK), [ssMiddle]); // used ssMiddle cuz there is no ssNone ???
    end else if btn = btnNumDot then begin
      POSKeyDown(word(VK_DECIMAL), [ssMiddle]);
    end else if btn = btnNum1 then begin
      POSKeyDown(word('1'), [ssMiddle]);
    end else if btn = btnNum2 then begin
      POSKeyDown(word('2'), [ssMiddle]);
    end else if btn = btnNum3 then begin
      POSKeyDown(word('3'), [ssMiddle]);
    end else if btn = btnNum4 then begin
      POSKeyDown(word('4'), [ssMiddle]);
    end else if btn = btnNum5 then begin
      POSKeyDown(word('5'), [ssMiddle]);
    end else if btn = btnNum6 then begin
      POSKeyDown(word('6'), [ssMiddle]);
    end else if btn = btnNum7 then begin
      POSKeyDown(word('7'), [ssMiddle]);
    end else if btn = btnNum8 then begin
      POSKeyDown(word('8'), [ssMiddle]);
    end else if btn = btnNum9 then begin
      POSKeyDown(word('9'), [ssMiddle]);
    end else if btn = btnNum0 then begin
      POSKeyDown(word('0'), [ssMiddle]);
    end;
    finally
        SetControlFocus(grdTrans);
    end;
  end;
end;


procedure TPOSScreenForm.POSKeyDown(const wKey: word; const Shift: TShiftState);
  // Should get here for any keyboard key hit
var
  bAllow: boolean;
  bKeyUsed: boolean;
  Key: word;

  function IsFunctionKey: boolean;
  begin
    Result := ((Key >= VK_F1) and (Key <= VK_F12)) or (Key = VK_ESCAPE);
  end;

begin


  Key := wKey;
  if bSwipeCardInProgress and (not IsFunctionKey()) then begin
    Exit; // keyboard events are captured by KeyPressed under this mode
  end;

  // Ignore if termianl is locked
  bAllow := true;
  if bIsLocked then begin
    if iLockedHotKey <> Chr(Key) then // Is this an attempt to unlock?
      bAllow := false;
  end;

  if bAllow then begin
    // we need to check if new transaction for some key strokes, others
    // .. are checked in Perform function
    case Key of
      ENTER_KEY,
      word('0')..word('9'),
      VK_BACK,
      VK_NUMPAD0..VK_NUMPAD9,
      VK_DECIMAL,
      DOT_KEY,
      VK_ESCAPE:
        begin
          if (bTransComplete = true) then begin
            bTransComplete := false;
            ClearAll;
          end;
        end;
    end;


    case Key of
      word('A')..word('Z'):
        begin
          If bUseAlphaNumericBarcodes AND (bTransComplete = true) then begin
            ClearAll;
            bTransComplete := false;
          end;
        end;
    end;
    bKeyUsed := false;
    if ssCtrl in Shift then begin
      bKeyUsed := true;
      case Key of
        VK_F1: CommonLib.MessageDlgXP_Vista('Please use CTRL-F2 to Access "Customise POS"', mtInformation, [mbOK], 0);
        VK_F2: CustomizePOS;  // control-F2 takes us to customize POS form
        else bKeyUsed := false;
      end;
    end else begin
      try
        bKeyUsed := true;
        case Key of
          ENTER_KEY: BarcodeFn;
          word('0')..word('9'),
          VK_BACK: AddDigitToViewer(char(Key));
          VK_NUMPAD0..VK_NUMPAD9: AddDigitToViewer(Chr(Key - VK_NUMPAD0 + ASCII_0));
          VK_DECIMAL,
          DOT_KEY: AddDigitToViewer('.');
          VK_ESCAPE: Close;   // Exit form
          VK_PLUS,
          VK_ADD: PerformFunction(FN_SALESMAN);
          VK_F2: PerformFunction(FN_PROD_LIST);
          VK_F3: PerformFunction(FN_CUST_LIST);
          VK_F4: PerformFunction(FN_PRINT_RCPT);
          VK_F5: PerformFunction(FN_QUANT);
          VK_F6: PerformFunction(FN_NO_SALE);
          VK_F7: PerformFunction(FN_REFUND);
          VK_F8: PerformFunction(FN_CANCEL);
          VK_F9: PerformFunction(FN_CHEQUE);
          VK_F10: PerformFunction(FN_CREDIT_CARD);
          VK_F11: PerformFunction(FN_EFTPOS);
          VK_F12: PerformFunction(FN_CASH);
          word('A')..word('Z'): Begin
                                  If bUseAlphaNumericBarcodes then Begin
                                    AddDigitToViewer(char(Key));
                                    bTransComplete := false;
                                  end else
                                    DoHotKey(Chr(Key));
                                end;
          else bKeyUsed := false;
        end;
      except
        on e: ENoAccess do HandleNoAccessException(e);
      end;
    end;
    if bKeyUsed then begin
      Key := 0;
    end;
  end;
end;


procedure TPOSScreenForm.btnKeyPadClick(Sender: TObject);
begin
  inherited;
  if pnlNumericKeyPad.Visible = false then begin
    pnlNumericKeyPad.Visible := true;
    btnKeyPad.Caption        := 'Memo';
  end else begin
    pnlNumericKeyPad.Visible := false;
    btnKeyPad.Caption        := 'Key Pad';
  end;
end;

function TPOSScreenForm.IsAnyPaymentsByVoucher: boolean;
var
  pPayment: pPaymentRec;
  i: integer;
begin
  Result := false;
  for i := 0 to lstPayments.Count - 1 do begin
    pPayment := lstPayments[i];
    if pPayment^.PaymentType = PAY_VOUCHER then begin
      Result := true;
      Break;
    end;
  end;
end;

function TPOSScreenForm.IsAnyAccountPayments: boolean;
var
  pItem: pLineItemRec;
  i: integer;
begin
  Result := false;
  for i := 0 to lstLineItems.Count - 1 do begin
    pItem := lstLineItems[i];
    if pItem^.IsAccountPayment then begin
      Result := true;
      Break;
    end;
  end;
end;

function TPOSScreenForm.IsAnyPaymentsByCheque: boolean;
var
  pPayment: pPaymentRec;
  i: integer;
begin
  Result := false;
  for i := 0 to lstPayments.Count - 1 do begin
    pPayment := lstPayments[i];
    if pPayment^.PaymentType = PAY_CHEQUE then begin
      Result := true;
      Break;
    end;
  end;
end;

function TPOSScreenForm.IsAnyCashOut: boolean;
var
  pPayment: pPaymentRec;
  i: integer;
begin
  Result := false;
  for i := 0 to lstPayments.Count - 1 do begin
    pPayment := lstPayments[i];
    if (pPayment^.PaymentType = PAY_CASH) and (pPayment^.Amount < 0) then begin
      Result := true;
      Break;
    end;
  end;
end;

procedure TPOSScreenForm.SummariseSales;
  // Creates summarised sales from the POS (summarised) sales tables, and add them
  // to the sales tables.  Typically used eith EOP processing.
var
  TempClassID: integer;
  qryClasses: TERPQuery;
  qryLines: TERPQuery;
  qryPosLines: TERPQuery;
  qrySales: TERPQuery;
  qryPosPayments: TERPQuery;
  iSaleID_: integer;
  dTotalAmount, dTotalAmountInc: double;
  savedConnection: TCustomMyConnection;
  MaxSaleDateTime : TDateTime;
  //fQueries          :TStringList;
  CashSale          : TPOSCashSale;
  Doc: TXMLDocument;

  procedure GetPosLines;
  begin
    // retreive summarised Lines from POS table
    with qryPosLines do begin
      SQL.Clear;
      SQL.Add('SELECT tblsaleslines_pos.*, SUM(QtySold), SUM(UnitOfMeasureQtySold), SUM(Shipped), ');
      SQL.Add('SUM(UnitOfMeasureShipped), SUM(TotalLineAmount), Sum(TotalLineAmountInc) , Max(tblsales_pos.SaleDateTime) MaxSaleDateTime ');
      SQL.Add('FROM tblsaleslines_pos ');
      SQL.Add('INNER JOIN tblsales_pos using (SaleID) ');
      SQL.Add('WHERE tblsales_pos.TillID = ' + IntToStr(iTillID) + ' AND ');
      SQL.Add('IsCashSale = "T" AND tblsales_pos.ClassID = ' + IntToStr(TempClassID) + ' ');
      SQL.Add('GROUP BY ProductID,UnitOfMeasureID,UnitofMeasureMultiplier,linePriceInc, LineCost,Area,MatrixREf,Matrixprice,MatrixDesc ');
      Open;
      dTotalAmount    := 0;
      dTotalAmountInc := 0;
      First;
      MaxSaleDateTime := qryPosLines.FieldByName('MaxSaleDateTime').AsDateTime;
      while not qryPOSLines.Eof do begin
        dTotalAmount := dTotalAmount + qryPosLines.FieldByName('SUM(TotalLineAmount)').AsFloat;
        dTotalAmountInc := dTotalAmountInc + qryPosLines.FieldByName('SUM(TotalLineAmountInc)').AsFloat;
        Next;
      end;
    end;
  end;

  function CreateSaleRecord: integer;
  begin
    // creates a blank sale record
    qrySales.SQL.Clear;
    qrySales.SQL.Add('SELECT * FROM tblsales WHERE SaleID = 0');
    qrySales.Open;
    qrySales.Insert;
    qrySales.FieldByName('Memo').AsString := 'Summarised POS Transactions';
    qrySales.FieldByName('IsPOs').asBoolean := False;
    qrySales.FieldByName('IsCashSale').asBoolean := True;
    qrySales.Post;
    Result := qrySales.FieldByName('SaleID').AsInteger;
  end;

  procedure PrepareSalesLines;
  begin
    with qryLines do begin
      SQL.Clear;
      SQL.Add('SELECT * FROM tblsaleslines WHERE SaleLineID = 0');
      Open;
    end;
  end;
  procedure CreateSaleLinesRecord;
    // creates a sale lines record for the summarised transactions
  begin
    qryLines.Insert;
    with qryLines do begin
      FieldByName('SaleId').AsInteger     := iSaleID_;
      FieldByName('Product_Description').AsString := qryPosLines.FieldByName('Product_Description').AsString;
      FieldByName('ProductName').AsString := qryPosLines.FieldByName('ProductName').AsString;
      FieldByName('ProductPrintName').AsString := qryPosLines.FieldByName('ProductPrintName').AsString;
      FieldByName('LinePrice').AsFloat    := qryPosLines.FieldByName('LinePrice').AsFloat;
      FieldByName('LinePriceInc').AsFloat := qryPosLines.FieldByName('LinePriceInc').AsFloat;
      FieldByName('LineTaxRate').AsFloat  := qryPosLines.FieldByName('LineTaxRate').AsFloat;
      FieldByName('QtySold').AsFloat      := qryPosLines.FieldByName('SUM(QtySold)').AsFloat;
      FieldByName('Shipped').AsFloat      := qryPosLines.FieldByName('SUM(Shipped)').AsFloat;

      FieldByName('UnitofMeasureQtySold').AsFloat    := qryPosLines.FieldByName('SUM(UnitofMeasureQtySold)').AsFloat;
      FieldByName('UnitofMeasureShipped').AsFloat    := qryPosLines.FieldByName('SUM(UnitofMeasureShipped)').AsFloat;
      FieldByName('UnitofMeasureMultiplier').AsFloat := qryPosLines.FieldByName('UnitofMeasureMultiplier').AsFloat;

      FieldByName('Invoiced').AsString          := 'T';
      FieldByName('TotalLineAmount').AsFloat    := qryPosLines.FieldByName('SUM(TotalLineAmount)').AsFloat;
      FieldByName('TotalLineAmountInc').AsFloat := qryPosLines.FieldByName('SUM(TotalLineAmountInc)').AsFloat;

      FieldByName('LineTax').AsFloat := FieldByName('TotalLineAmountInc').AsFloat - FieldByName('TotalLineAmount').AsFloat;

      FieldByName('LaybyID').AsString     := '';

      FieldByName('ProductID').AsInteger   := qryPOSLines.FieldByName('ProductID').AsInteger;
      FieldByName('PartType').AsString     := qryPOSLines.FieldByName('PartType').AsString;
      FieldByName('ProductGroup').AsString := qryPOSLines.FieldByName('ProductGroup').AsString;
      FieldByName('LineCost').AsFloat      := qryPOSLines.FieldByName('LineCost').AsFloat;
      FieldByName('LineCostInc').AsFloat   := qryPOSLines.FieldByName('LineCostInc').AsFloat;
      FieldByName('IncomeAccnt').AsString  := qryPOSLines.FieldByName('IncomeAccnt').AsString;
      FieldByName('AssetAccnt').AsString   := qryPOSLines.FieldByName('AssetAccnt').AsString;
      FieldByName('CogsAccnt').AsString    := qryPOSLines.FieldByName('CogsAccnt').AsString;
      FieldByName('LineTaxCode').AsString  := qryPOSLines.FieldByName('LineTaxCode').AsString;
      FieldByName('UnitofMeasureSaleLines').AsString := qryPOSLines.FieldByName('UnitofMeasureSaleLines').AsString;
      FieldByName('UnitOfMeasureId').AsInteger := qryPOSLines.FieldByName('UnitOfMeasureId').AsInteger;
      FieldByName('Area').AsString        := qryPOSLines.FieldByName('Area').AsString;
      FieldByName('MatrixDesc').AsString        := qryPOSLines.FieldByName('MatrixDesc').AsString;
      FieldByName('MatrixRef').AsString        := qryPOSLines.FieldByName('MatrixRef').AsString;
      FieldByName('MatrixPrice').asFloat        := qryPOSLines.FieldByName('MatrixPrice').asFloat;
    end;
    qryLines.Post;
    //updateAllocation(qryLines.fieldbyname('ProductID').asInteger ,qryLines.Fieldbyname('SaleID').asInteger , qryLines.fieldbyname('SaleLineID').asInteger);
    qryLines.Edit;
    qryLines.FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + qryLines.FieldByName('SaleLineID').AsString;
    qryLines.FieldByName('SeqNo').AsInteger := qryLines.RecordCount;
    qryLines.FieldByName('SortId').AsInteger := qryLines.RecordCount * 10;

    qryLines.Post;
  end;

  procedure UpdateTblSales;
  begin
    qrySales.Edit;

    qrySales.FieldByName('SaleDate').AsDateTime := Date;
    qrySales.FieldByName('ShipDate').AsDateTime := Date;
    qrySales.FieldByName('TotalAmount').AsFloat := dTotalAmount;
    qrySales.FieldByName('TotalAmountInc').AsFloat := dTotalAmountInc;
    qrySales.FieldByName('TotalTax').AsFloat := RoundTo1C(dTotalAmountInc - dTotalAmount);
    qrySales.FieldByName('EmployeeName').AsString := lblSalesPerson.Caption;
    qrySales.FieldByName('EmployeeID').AsInteger := iEmployeeID;
    qrySales.FieldByName('TimeOfSale').AsString := lblTime.Caption;
    qrySales.FieldByName('Saledatetime').AsDateTime := MaxSaleDateTime;// Date + StrToTime(lblTime.Caption);
    qrySales.FieldByName('CustomerName').AsString := CLIENT_CASH;
    qrySales.FieldByName('ClientID').AsInteger := iCashCustID;
    qrySales.FieldByName('InvoiceTo').AsString := sClientBTAddress;
    qrySales.FieldByName('ShipTo').AsString := sClientPHAddress;
    qrySales.FieldByName('POS').AsString := 'T';           // used for End-Of-Period tagging
    qrySales.FieldByName('IsPOS').AsString := 'T';         // Indicates that this is a POS sale
    qrySales.FieldByName('IsCashSale').AsString := 'T';
    qrySales.FieldByName('IsQuote').AsString := 'F';
    qrySales.FieldByName('IsSalesOrder').AsString := 'F';
    qrySales.FieldByName('IsLayby').AsString := 'F';
    qrySales.FieldByName('IsLaybyPayment').AsString := 'F';
    qrySales.FieldByName('IsLaybyTOS').AsString := 'F';
    qrySales.FieldByName('IsVoucher').AsString := 'F';
    qrySales.FieldByName('IsRefund').AsString := 'F';
    qrySales.FieldByName('IsInvoice').AsString := 'F';
    qrySales.FieldByName('Class').AsString := GetClassName(TempClassID);
    qrySales.FieldByName('ClassID').AsInteger := TempClassID;
    qrySales.FieldByName('TillID').AsInteger := iTillID;
    qrySales.FieldByName('Account').AsString := UNDEPOSITED_FUNDS;
    qrySales.FieldByName('AccountID').AsInteger := AccountID(UNDEPOSITED_FUNDS);
    qrySales.FieldByName('Terms').AsString := '';
    qrySales.FieldByName('DueDate').AsDateTime := Date;

    qrySales.FieldByName('PayMethod').AsString := 'Split';
    qrySales.FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + IntToStr(iSaleID_);
    qrySales.FieldByName('InvoiceDocNumber').AsInteger := iSaleID_;

    qrySales.Post;
  end;

  procedure GetPosPayments;
  begin
    // retreive and summarise Payments from POS table
    with qryPosPayments do begin
      SQL.Clear;
      SQL.Add('SELECT P.PaymentID, P.SaleID, P.PayMethod, P.Ref, SUM(P.Amount) as TotalPayments  ');
      SQL.Add('FROM tblsalespayments_pos AS P  ');
      SQL.Add('INNER JOIN tblsales_pos AS S USING (SaleID)  ');
      SQL.Add('WHERE S.IsInvoice <> "T" AND  S.TillID = ' + IntToStr(iTillID) + ' AND S.ClassID = ' +
        IntToStr(TempClassID) + ' ');
      SQL.Add('GROUP BY S.ClassID,P.PayMethod; ');
      Open;
    end;
  end;

  procedure CreatePaymentRecords;
    // creates a payment records for the summarised transactions (one for each payment type)
  var
    qry: TERPQuery;
  begin
    qry := TERPQuery.Create(self);
    qry.Connection := MyConnection;
    try
      with qry do begin
        Sql.Clear;
        Sql.Add('INSERT tblsalespayments ');
        Sql.Add('(SaleID,  PayMethod,  Amount,  Ref) VALUES ');
        Sql.Add('(:xSaleID,  :xPayMethod, :xAmount,  :xRef);');

        qryPosPayments.First;
        while not qryPosPayments.Eof do begin
          with qry do begin
            ParamByName('xPayMethod').AsString := qryPosPayments.FieldByName('PayMethod').AsString;
            ParamByName('xAmount').AsFloat := qryPosPayments.FieldByName('TotalPayments').AsFloat;
            ParamByName('xRef').AsString := 'POS Summarised';
            ParamByName('xSaleId').asInteger := iSaleID_;
          end;
          Execute;
          qryPosPayments.Next;
        end;
        Sql.Clear;
        SQL.Add('update tblsalespayments');
        SQL.Add('SET GlobalRef = CONCAT_WS("",' + QuotedStr(AppEnv.Branch.SiteCode) +
        ',PaymentId) Where char_length(GlobalRef)=0 OR IsNull(GlobalRef);');
        Execute;
      end;
    finally
      FreeAndNil(qry);
    end;
  end;

  procedure RemoveDetailedRecords;
    // remove all records that have been summarised from the 3 POS detailed tables
  var
    qry: TERPQuery;
  begin
    qry := TERPQuery.Create(self);
    qry.Connection := MyConnection;
    try
      qry.Sql.Clear;
      qry.Sql.Add('DELETE tblsalespayments_pos.* FROM tblsales_pos ');
      qry.Sql.Add('INNER JOIN tblsalespayments_pos ON tblsales_pos.SaleID = tblsalespayments_pos.SaleID ');
      qry.Sql.Add('WHERE tblsales_pos.TillId = ' + IntToStr(iTillID) +
        ' AND tblsales_pos.IsCashSale = "T"  AND tblsales_pos.ClassID = ' + IntToStr(TempClassID) + '; ');

      qry.Sql.Add('DELETE tblPQA.* FROM tblsales_pos ');
      qry.Sql.Add('INNER JOIN tblsaleslines_pos ON tblsales_pos.SaleID = tblsaleslines_pos.SaleID ');
      qry.Sql.Add('INNER JOIN tblPQA ON tblPQA.TransId = tblsales_pos.SaleID  and  tblPQA.translineId = tblsaleslines_pos.SaleLineID and tblPQA.Transtype = "TPOSSaleLine"');
      qry.Sql.Add('WHERE tblsales_pos.TillId = ' + IntToStr(iTillID) +
        ' AND tblsales_pos.IsCashSale = "T"  AND tblsales_pos.ClassID = ' + IntToStr(TempClassID) + '; ');

      qry.Sql.Add('DELETE tblsaleslines_pos.* FROM tblsales_pos ');
      qry.Sql.Add('INNER JOIN tblsaleslines_pos ON tblsales_pos.SaleID = tblsaleslines_pos.SaleID ');
      qry.Sql.Add('WHERE tblsales_pos.TillId = ' + IntToStr(iTillID) +
        ' AND tblsales_pos.IsCashSale = "T"  AND tblsales_pos.ClassID = ' + IntToStr(TempClassID) + '; ');

      qry.Sql.Add('DELETE FROM tblsales_pos ');
      qry.Sql.Add('WHERE tblsales_pos.TillId = ' + IntToStr(iTillID) +
        ' AND tblsales_pos.IsCashSale = "T"  AND tblsales_pos.ClassID = ' + IntToStr(TempClassID) + '; ');

      qry.Sql.Add('DELETE FROM tblsales_pos ');
      qry.Sql.Add('WHERE tblsales_pos.TillId = ' + IntToStr(iTillID) +
        ' AND tblsales_pos.Deleted = "T";');

      qry.Sql.Add('DELETE tblsales_pos.* FROM tblsales_pos ');
      qry.Sql.Add('left JOIN tblsaleslines_pos ON tblsales_pos.SaleID = tblsaleslines_pos.SaleID ');
      qry.Sql.Add('WHERE IfNull(tblsaleslines_pos.SaleLineId,0) = 0 ;');
      qry.Execute;
    finally
      FreeAndNil(qry);
    end;
  end;
begin   // SummariseSales

  qryPosLines     := TERPQuery.Create(nil);
  qryPosPayments  := TERPQuery.Create(nil);
  qryClasses      := TERPQuery.Create(nil);
  qryLines        := TERPQuery.Create(nil);
  qrySales        := TERPQuery.Create(nil);

  qryPosLines.Options.FlatBuffers     := True;
  qryPosPayments.Options.FlatBuffers  := True;
  qryClasses.Options.FlatBuffers      := True;

  qryPosLines.Connection    := CommonDbLib.GetSharedMyDacConnection;
  qryPosPayments.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryClasses.Connection     := CommonDbLib.GetSharedMyDacConnection;
  qryLines.Connection       := MyConnection;
  qrySales.Connection       := MyConnection;

  // fTblSalesLinesDetails is used in UpdateAccounts() which is called
  // .. when we have completed sumarising.  fTblSalesLinesDetail's Connection
  // .. may or may not be in transaction.  We will set it to transaction later
  // .. so we must Save the current state and set it back in the 'finally' block

  savedConnection := fTblSalesLinesDetails.Connection;
  try
    try
      MyConnection.Open;
      BeginTransaction;
      qryClasses.SQL.Clear;
      qryClasses.SQL.Add('SELECT tblClass.ClassID, tblClass.ClassName FROM tblClass INNER JOIN tblsales_pos Using(ClassID) Group By tblClass.ClassID;');
      qryClasses.Open;
      qryClasses.First;
      while not qryClasses.Eof do begin
        self.ShowLocalProgressbar(7,'Processing ' + qryClasses.FieldByName('ClassName').AsString);
        Application.ProcessMessages;
        TempClassID := qryClasses.FieldByName('ClassID').AsInteger;
        // retrieve and summarise POS SalesLines
        GetPosLines;
        self.StepLocalProgressbar();
        if qryPosLines.RecordCount = 0 then begin
          // CommonLib.MessageDlgXP_Vista('No POS transactions found to Summarise', mtWarning, [mbOK], 0);
          qryClasses.Next;
          Continue;
        end;

        self.StepLocalProgressbar();
        // Creates Sales Record to get SaleID (we'll update it later)
        iSaleID_ := CreateSaleRecord;
        if iSaleID_ = 0 then begin
          CommonLib.MessageDlgXP_Vista('Could not Create Summarised POS Sales Table', mtWarning, [mbOK], 0);
          Exit;
        end;

        // Set Up SalesLines, get ready for inserting summarised records
        self.StepLocalProgressbar();
        PrepareSalesLines;

        // Now Load Summarised POS lines into SalesLines
        qryPosLines.First;

        self.StepLocalProgressbar();
        if qryPosLines.RecordCount > 100 then begin
          self.HideLocalProgressbar;
          self.ShowLocalProgressbar(qryPosLines.RecordCount,'Creating sale lines');
        end;
        while not qryPosLines.Eof do begin
          CreateSaleLinesRecord;
          qryPosLines.Next;
          Application.ProcessMessages;
          self.StepLocalProgressbar();
        end;
        self.HideLocalProgressbar;
        self.ShowLocalProgressbar(3,'Processing ' + qryClasses.FieldByName('ClassName').AsString);

        // Update the blank Sale Header record  we created earlier
        self.StepLocalProgressbar();
        UpdateTblSales;

        // Now Get Summarised Payments
        self.StepLocalProgressbar();
        GetPosPayments;

        // Create summarised Payment Records
        self.StepLocalProgressbar();
        CreatePaymentRecords;

        // update account balances & inventory etc   (no need to update SN tracking)
        fTblSalesLinesDetails.Connection := MyConnection; // make sure that we are in transaction
        //UpdateAccounts(iSaleID_, false);
        self.HideLocalProgressbar;
        CashSale := TPOSCashSale.Create(Self);
        try
            CashSale.BusObjEvent := DoBusinessObjectEvent;
            CashSale.connection := TMydacdataconnection.create(CashSAle);
            TMyDacDataconnection(CashSale.connection).MydacConnection := MyConnection;
            CashSale.Load(0);
            Doc:=CashSale.XMLdoc;
            CashSale.Load(iSaleID_);
            CashSale.CleanXMLDoc.ChildNodes.Clear;
            CashSale.CleanXMLDoc.XML.Text:= Doc.XML.Text;
            CashSale.CleanXMLDoc.Active:= true;
            //CashSale.isPOs := False;
            CashSale.PostDB;
            CashSale.Save;
            CashSale.IsPos := True;
            CashSale.PostDB;
        finally
          CashSale.ResultStatus.Clear;
            Freeandnil(CashSale);
        end;


        // remove all this Till's POS transactions that make up the summary (from all tables)
        RemoveDetailedRecords;
        qryClasses.Next;
      end;
      UpdateAppt;
      CommitTransaction;
      PlaySavesound;
      qryPosLines.Close;
      qryPosPayments.Close;
      qryLines.Close;
      qrySales.Close;
      qryClasses.Close;

      if MyConnection.intransaction then RollbackTransaction;
      if savedConnection <>  fTblSalesLinesDetails.Connection then fTblSalesLinesDetails.Connection.Close;
      //savedConnection.Close;
    finally
      fTblSalesLinesDetails.Connection := savedConnection;
      FreeandNil(qryPosLines);
      FreeandNil(qryPosPayments);
      FreeandNil(qryLines);
      FreeandNil(qrySales);
      FreeandNil(qryClasses);
      self.HideLocalProgressbar;
    end;
  except
    if MyConnection.intransaction then RollbackTransaction;
    raise;
  end;
end;

procedure TPOSScreenForm.MemoLineFn;
var
  sText: string;
begin
  if idOk() then begin
    MemoInput('Enter Memo:', sText);
    if not Empty(sText) then begin
      CreateMemoPartLine(sText);
      DisplayLineItem(lstLineItems.Last);
      EnteringNum(false);
    end;
  end;
end;

procedure TPOSScreenForm.OpenCashDrawer;
begin
  if bOkToOpenCashDrawer then begin
    if bIsSpooler or bOkToOpenRemoteCashDrawer then begin
      OpenRemoteDrawer;
    end else begin
      oCashDrawer.OpenCashDrawer;
    end;
  end;
end;

procedure TPOSScreenForm.SwipeCardFn;
begin
  bSwipeCardInProgress := true;
  sCardNumber := '';
  ClearInputMemo;
end;

procedure TPOSScreenForm.AddCharToCardNumber(const cChar: char);
begin
  sCardNumber := sCardNumber + cChar;
end;

procedure TPOSScreenForm.EndSwipeCard;
var
  mrResult: integer;
begin
  bSwipeCardInProgress := false;
  if not Empty(sCardNumber) then begin
    iClientID := GetClientIDFromCard(sCardNumber);
    if iClientID <> 0 then begin
      LoadCustomer(iClientID);
    end else begin
      mrResult := CommonLib.MessageDlgXP_Vista('No Match found for this Card' + edtPOSMemo.Lines[0] +
        #10#13'Do you wish to Assign this Card to a Customer?', mtWarning, [mbYes, mbNo], 0);
      if mrResult = mrYes then begin
        iCustOriginator := FN_SWIPECARD;
        ShowCustList;   // processing will recommence in edtClientIDChange
      end;
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('Invalid Card Number', mtWarning, [mbOK], 0); // or some other appropriate message
  end;
  EnteringNum(false);
end;

procedure TPOSScreenForm.FormKeyPress(Sender: TObject; var Key: char);
begin
  inherited;
  if bSwipeCardInProgress then begin
    if Key = CR then begin
      EndSwipeCard;
    end else if IsPrintable(char(Key)) then begin
      AddCharToCardNumber(char(Key));
    end;
    Key := #0;
  end else begin
    case Key of
      '%', ';':
        begin
          SwipeCardFn;
          AddCharToCardNumber(Key);
        end;
    end;
    Key := #0;
  end;
end;

function TPOSScreenForm.SetTill: integer;
begin
  if bMultiTills then begin
    Result := GetAssignedTillID(getPCName());
    if Result = 0 then begin
      with TPOSGetTillPopUp.Create(Self) do try
          ShowModal;
          Result := fiTillID;
          if Result <= 0 then begin
            Result := DEFAULT_TILL;
          end;
        finally
          Free;
        end;
    end;
  end else begin
    Result := DEFAULT_TILL;
  end;
  lblTillName.Caption := GetTillName(Result);
end;
function TPOSScreenForm.AutoRoundRelatedQty(aLineItemRec: pLineItemRec; ParentQty:Double):Double;
begin
  result := tcdatautils.AutoRoundRelatedQty(ParentQty  , aLineItemRec^.RelatedParentProductID , aLineItemRec^.ProductID);
end;
procedure TPOSScreenForm.updateRelatedProductsQty(RelatedParentID:Integer; RelatedParentQty:Double);
var
  I:Integer;
  aLineItemRec: pLineItemRec;
begin
  if lstLineItems.Count = 0 then Exit;

  for i := 0 to lstLineItems.Count - 1 do begin
    if (pLineItemRec(lstLineItems[i])^.Ischild) and (pLineItemRec(lstLineItems[i])^.RelatedParentID =  RelatedParentID) then begin
      aLineItemRec := pLineItemRec(lstLineItems[i]);
      rQuantOfProd:= AutoRoundRelatedQty(aLineItemRec , RelatedParentQty);
      pLineItemRec(lstLineItems[i])^.Qty := rQuantOfProd;
      PostSaleItem(aLineItemRec ,pLineItemRec(lstLineItems[i])^.ProductDescription ,pLineItemRec(lstLineItems[i])^.LinePriceinc, rQuantOfProd , 0, 0.0, 0.0, False, False , True , False, False, pLineItemRec(lstLineItems[i])^.UnitID);
      updateRelatedProductsQty(pLineItemRec(lstLineItems[i])^.ID, pLineItemRec(lstLineItems[i])^.Qty*pLineItemRec(lstLineItems[i])^.Multiplier);
    end;
  end;
end;
procedure TPOSScreenForm.LoadRelatedParts(const iParentID: integer; const dQty: double; const ParentID:Integer; ParentProductHidden:boolean ;issubrelated:Boolean =False);
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qry.Sql.Clear;
    qry.Sql.Add('SELECT RelatedID, ParentID, ProductID, Qty,ParentQty,  IsHidden,CanDelete , IsToRoundtoNextNumberinSales , IsToRoundtoPreviousNumberinSales FROM tblrelatedparts ');
    qry.Sql.Add('WHERE ParentID = :xParentID;');
    qry.Params.ParamByName('xParentID').AsInteger := iParentID;
    qry.Open;
    // this is the parent of related parts so add the related parts
    if qry.RecordCount > 0 then begin
      qry.First;
      while not qry.Eof do begin
        try
          dRelatedQtyMultiplier := qry.FieldByName('Qty').AsFloat / qry.FieldByName('ParentQty').AsFloat
        Except
          on E:Exception do begin
            dRelatedQtyMultiplier := qry.FieldByName('Qty').AsFloat;
          end;
        end;

        rQuantOfProd := dQty;
        FindAndAddPart(qry.FieldByName('ProductID').AsInteger , not(qry.FieldByName('IsHidden').AsBoolean) and not(ParentProductHidden));
        With pLineItemRec(lstLineItems.Last)^ do begin

          RelatedQtyMultiplier  := dRelatedQtyMultiplier;
          RelatedParentQty      := dQty;
          RelatedParentID       := ParentID;
          RelatedParentProductID:= iParentID;
          Qty                   := AutoRoundRelatedQty(pLineItemRec(lstLineItems.Last) , RelatedParentQty);
          IsChild               := true;
          IsrelatedHidden       := qry.FieldByName('IsHidden').AsBoolean or ParentProductHidden;
          CanDeleteRelated      := qry.FieldByName('CanDelete').AsBoolean;

          LoadRelatedParts(qry.FieldByName('ProductID').AsInteger, dQty * dRelatedQtyMultiplier , ID , qry.FieldByName('IsHidden').AsBoolean or ParentProductHidden , true);
        end;
        qry.Next;
      end;

      if not issubrelated then begin
        RebuildGrid;
      end;
    end; // if qry.recordcount...
  finally
    FreeAndNil(qry);
    dRelatedQtyMultiplier := 1;
  end;
end;

procedure TPOSScreenForm.DoEftTransaction(const sCommand: string; const rCashOut: currency);
begin
  if not FinaliseAndCheckSale() then begin
    Exit;
  end;

  edtReceipt.Clear;

  // Set EFT InProgress flag to indicate that a transaction is starting
  SetEftInProgress(true);
  try
    // Telling PCEFTPOS that I want to print
    EFT.ReceiptAutoPrint := false;
    EFT.CutReceipt := false;

    // Setting the transaction type
    eft.TxnType := sCommand;

    // setting the transaction reference
    sEftTxnRef := GetNextEftID;
    eft.TxnRef := sEftTxnRef;

    // Setting the Transaction amount
    eft.AmtPurchase := Abs(rRunTot);   // absolute to allow for refund
    if rCashOut <> 0 then begin
      eft.AmtCash := rCashOut;
    end else
      eft.AmtCash := 0.00;

    // Call do transaction
    EFT.DoTransaction;
  finally

  end;
end;

procedure TPOSScreenForm.eftTransactionEvent(Sender: TObject);
begin
  inherited;
  // Clear InProgress flag to indicate that the transaction has completed
  SetEftInProgress(false);

  if eft.TxnRef <> sEftTxnRef then begin
    // If we get here then we are in trouble since the Reference should always match
    DisplayInViewer('EFT Error: Transaction Ref Does Not Match',
      'Please Check Validity');
    Exit;
  end;

  if eft.Success then begin
    bIsEft := true;
    if eft.AmtCash > 0 then begin
      AddPaymentToList(PAY_CASH, eft.TxnRef, - eft.AmtCash, - eft.AmtCash, 0, 0);
      if not IsLineItems then begin
        FilterPartsByName(PART_MEMO);
        if PostSaleItem('EFT Cash Out', 0, 0, 0, 0.0, 0.0, false, false, false, false) then begin
            DisplayLineItem(lstLineItems.Last);
            grdTrans.Cells[COL_QTY, 1] := '';
            grdTrans.Cells[COL_AMOUNT, 1] := '';
            bIsEftCashOutOnly := true;
        end;
      end;
    end;
    if fbCreditCardPayment then DoPayment('Credit Card', PAY_CREDITCARD)
    else DoPayment('EFTPOS', PAY_EFT);
  end else begin
    DisplayInViewer(' EFT Error: ' + eft.ResponseCode, eft.ResponseText);
  end;
  EnteringNum(false);
end;

procedure TPOSScreenForm.eftPrintReceiptEvent(Sender: TObject; const ReceiptType: WideString);
begin
  inherited;
  case ReceiptType[1] of
    'R':
      begin // Receipt is ready to print.
        InsertEftRcptText(EFT.Receipt);
        PrintEftReceipt;
      end;
    // ReceiptType is an identifier of the receipt to follow //
    'C': InsertEftRcptText(#13#10#13#10 + 'Customer Receipt' + #13#10);
    'L': InsertEftRcptText(#13#10#13#10 + 'Logon Receipt' + #13#10);
    'M': InsertEftRcptText(#13#10#13#10 + 'Merchant Receipt' + #13#10);
    'S': InsertEftRcptText(#13#10#13#10 + 'Settlement Receipt' + #13#10);
    'A': InsertEftRcptText(#13#10#13#10 + 'Audit Receipt' + #13#10);
  end;
end;

procedure TPOSScreenForm.InsertEftRcptText(const Text: string);
begin
  edtReceipt.Text := edtReceipt.Text + Text;
end;

procedure TPOSScreenForm.PrintEftReceipt;
var
  i: integer;
begin
  oRcptPrn.OpenPort;
  for i := 0 to edtReceipt.Lines.Count - 1 do begin
    oRcptPrn.Print('     ' + edtReceipt.Lines[i]);
  end;
  oRcptPrn.FeedPaperForCut;
  oRcptPrn.ClosePort;
end;

procedure TPOSScreenForm.RePrintEftFn;
begin
  if AppEnv.CompanyPrefs.IntegratedEFTPOS then begin
    eft.ReceiptAutoPrint := false;
    eft.CutReceipt       := false;
    //eft.DoReprintReceipt;
    eft.DoGetLastReceipt;  // use iether of these calls, I think they do the same thing
  end else begin
    CommonLib.MessageDlgXP_Vista('You do not have the Integrated EFTPOS Option Enabled', mtWarning, [mbOK], 0);
  end;
end;


procedure TPOSScreenForm.LineFeedFn;
begin
  oRcptPrn.OpenPort;
  oRcptPrn.NewLine(1);
  oRcptPrn.ClosePort;
end;

procedure TPOSScreenForm.ListFormDataSelect(Sender: TwwDbGrid);
begin
  iSaleId := Sender.DataSource.DataSet.Fields.FieldByName('SaleID').AsInteger;
end;

procedure TPOSScreenForm.eftReprintReceiptEvent(Sender: TObject);
begin
  inherited;
  edtReceipt.Clear;
  InsertEftRcptText(EFT.Receipt);
  PrintEftReceipt;
end;

function TPOSScreenForm.IsValidCashAmount(const rAmount: currency): boolean;
begin
  if (AppEnv.RegionalOptions.RegionType <> rUK) AND ((Trunc(rAmount * 100) mod 5) <> 0.0) then begin
    CommonLib.MessageDlgXP_Vista('Cash entered must be in 5 cent units', mtWarning, [mbOK], 0);
    Result := false;
  end else begin
    Result := true;
  end;
end;

function TPOSScreenForm.FinaliseAndCheckSale: boolean;
  // perform any checks and housekeeping prior to Payment of this sale
begin
  Result := false;
  if IsTotalDiscOK() then begin
    // perform global customer discount on all lines if not already done
    if not bIsCalcDiscDone then begin
      CalcAndPostCustDisc;
      bIsCalcDiscDone := true;
    end;
    Result := true;
  end;
end;

procedure TPOSScreenForm.EFTControlFn;
begin
  if AppEnv.CompanyPrefs.IntegratedEFTPOS then begin
    if IsAccessAllowed('FnEftSettlement') then begin
      edtReceipt.Clear;
      eft.ReceiptAutoPrint := false;
      eft.CutReceipt := false;
      eft.DoControlPanel;
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('You do not have the Integrated EFTPOS Option enabled', mtWarning, [mbOK], 0);
  end;
end;

procedure TPOSScreenForm.EFTSettlementFn;
begin
  if AppEnv.CompanyPrefs.IntegratedEFTPOS then begin
    if IsAccessAllowed('FnEftSettlement') then begin
      edtReceipt.Clear;
      eft.ReceiptAutoPrint := false;
      eft.CutReceipt := false;
      eft.DoDisplaySettlement;
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('You do not have the Integrated EFTPOS Option enabled', mtWarning, [mbOK], 0);
  end;
end;

function TPOSScreenForm.GetNextEftID: string;
var
  qry: TERPQuery;
  iEftID: integer;
begin
  iEftID := -999;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT TillID, EFTNextID FROM tblPosTills ' +
        'WHERE TillID = :xTillID');
      Params.ParamByName('xTillID').AsInteger := iTillID;
      Open;
      if not IsEmpty then begin
        iEftID := FieldByName('EFTNextID').AsInteger;
      end else begin
      end;
      Close;
      if iEftID >= 0 then begin
        SQL.Clear;
        SQL.Add('UPDATE tblPosTills SET EFTNextID = :xEFTNextID ' +
          'WHERE TillID = :xTillID');
        Params.ParamByName('xEFTNextID').AsInteger := iEftID + 1;
        Params.ParamByName('xTillID').AsInteger := iTillID;
        Execute;
      end;
    end;
  finally
    Result := 'EFT-' + AppEnv.Branch.SiteCode + '-' + IntToStr(iTillId) + '-' + IntToStr(iEftID);
    FreeAndNil(qry);
  end;
end;

function TPOSScreenForm.IsEftInProgress: boolean;
var
  qry: TERPQuery;
  //iEftID: integer;
begin
  Result := false;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT TillID, EftInProgress FROM tblPosTills ' +
        'WHERE TillID = :xTillID');
      Params.ParamByName('xTillID').AsInteger := iTillID;
      Open;
      if not IsEmpty then begin
        Result := (FieldByName('EFTInProgress').AsString = 'T');
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TPOSScreenForm.SetEftInProgress(const bState: boolean);
var
  qry: TERPCommand;
begin
  qry := TERPCommand.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    with qry do begin
      SQL.Clear;
      SQL.Add('UPDATE tblPosTills SET EftInProgress = :xEftInProgress ' +
        'WHERE TillID = :xTillID;');
      if bState then begin
        Params.ParamByName('xEftInProgress').AsString := 'T';
      end else begin
        Params.ParamByName('xEftInProgress').AsString := 'F';
      end;
      Params.ParamByName('xTillID').AsInteger := iTillID;
      Execute;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TPOSScreenForm.CompleteEftInProgress;
{ Note the order of calls here.  If we call ReprintEftFn (which calls reprintreceipt fn
  or GetLastReceipt func) after the DoGetLastTransaction call then we get a error
  from PC_EFTPOS - Recursive Call }
begin
  ReprintEftFn;
  CommonLib.MessageDlgXP_Vista('An EFT tranaction was "In Progress" when POS was Last Shut Down.' + #13 + #10 +
    'Please wait while the Outcome of this transaction is ' + #13 + #10 + 'retieved and Displayed.', mtWarning, [mbOK], 0);
  eft.DoGetLastTransaction;
end;

procedure TPOSScreenForm.eftGetLastTransactionEvent(Sender: TObject);
begin
  inherited;
  SetEftInProgress(false);
  if eft.LastTxnSuccess then begin
    DisplayInViewer(' EFT (' + eft.TxnRef + '):  OK ', eft.ResponseText);
  end else begin
    DisplayInViewer(' EFT (' + eft.TxnRef + '): ' + eft.ResponseCode, eft.ResponseText);
  end;
end;


procedure TPOSScreenForm.eftGetLastReceiptEvent(Sender: TObject);
begin
  inherited;
  edtReceipt.Clear;
  InsertEftRcptText(EFT.Receipt);
  PrintEftReceipt;
end;

procedure TPOSScreenForm.LoadProductRec(const iPartID, iUnitID: integer; const rQty: double);
var
  rPriceEx: double;
  sPartDesc: string;
begin
  ProductRec.Valid := true;
  ProductRec.ProductID := iPartID;
  ProductRec.Units := GetUnitName(iUnitID);
  ProductRec.UnitsID := iUnitID;
  ProductRec.UnitsMultiplier := GetUnitMultiplier(ProductRec.UnitsID);

  if oPrice.ProductPrice(iPartID, tcDatautils.GetTillClassID(iTillID), rQty * ProductRec.UnitsMultiplier,
    rPriceEx, false) then begin
    ProductRec.PriceEx        := rPriceEx * ProductRec.UnitsMultiplier;
    ProductRec.SubProductDesc := sPartDesc;
  end else begin
    ProductRec.Valid := false;
  end;
end;

function TPOSScreenForm.IsUsingReceiptPrinter: boolean;
var
  qryTill: TERPQuery;
begin
  Result := true;
  if AppEnv.CompanyPrefs.MultiTills then begin
    qryTill := TERPQuery.Create(nil);
    qryTill.Options.FlatBuffers := True;
    qryTill.Connection := CommonDbLib.GetSharedMyDacConnection;
    try
      with qryTill do begin
        SQL.Clear;
        SQL.Add('SELECT UseDefaultPrinter, ReceiptPrinterOn, ReceiptPrinterPort, ' +
          'ReceiptPrinterType, UseCashDrawerOnly ' +
          'FROM tblPOSTills WHERE TillID = :xTillID');
        Params.ParamByName('xTillID').AsInteger := iTillID;
        Open;
        if not IsEmpty then begin
          if FieldByName('UseDefaultPrinter').AsString <> 'T' then begin
            if (FieldByName('ReceiptPrinterOn').AsString = 'T') and
              (FieldByName('UseCashDrawerOnly').AsString <> 'T') then begin
              Result := true;
            end else begin
              Result := false;
            end;
          end else begin
            Result := (AppEnv.CompanyPrefs.ReceiptPrinterOn and not AppEnv.CompanyPrefs.POSUseCashDrawerOnly);
          end;
        end;
      end;
    finally
      FreeandNil(qryTill);
    end;
  end else begin
    Result := (AppEnv.CompanyPrefs.ReceiptPrinterOn and not AppEnv.CompanyPrefs.POSUseCashDrawerOnly);
  end;
end;

function TPOSScreenForm.OkToOpenRemoteCashDrawer: boolean;
var
  qryTill: TERPQuery;
begin
  Result := false;
  if AppEnv.CompanyPrefs.MultiTills then begin
    qryTill := TERPQuery.Create(nil);
    qryTill.Options.FlatBuffers := True;
    qryTill.Connection := CommonDbLib.GetSharedMyDacConnection;
    try
      with qryTill do begin
        SQL.Clear;
        SQL.Add('SELECT UsePrintSpooler,EnableKickRemoteDrawer ' +
          'FROM tblPOSTills WHERE TillID = :xTillID');
        Params.ParamByName('xTillID').AsInteger := iTillID;
        Open;
        if not IsEmpty then begin
          if (FieldByName('EnableKickRemoteDrawer').AsString = 'T') and (FieldByName('UsePrintSpooler').AsString = 'T') then
          begin
            Result := true;
          end else begin
            Result := false;
          end;
        end;
      end;
    finally
      FreeandNil(qryTill);
    end;
  end;
end;


procedure TPOSScreenForm.CustAccountFn;
var
  iCustID: integer;
  mrResult: integer;
begin
  if idOk() then begin
    if EnteringNum = true then begin
      sAccountNo := edtPOSMemo.Lines[0];
      iCustID := GetClientIDFromAccount(sAccountNo);
      if not LoadCustomer(iCustID) then begin
        mrResult := CommonLib.MessageDlgXP_Vista('No match found for Account No: ' + sAccountNo +
          #10#13'Do you wish to assign this Account to a Customer?', mtWarning, [mbYes, mbNo], 0);
        if mrResult = mrYes then begin
          iCustOriginator := FN_CUST_ACNT;
          ShowCustList;  // processing will recommence in edtClientIDChange
        end;
      end;
    end;
  end;
end;

procedure TPOSScreenForm.OpenRemoteDrawer;
var
  qry: TERPCommand;
begin
  qry := TERPCommand.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qry.SQL.Add('UPDATE tblPOSTills SET KickRemoteDrawer = "T" ' +
      'WHERE TillID = :xTillID');
    qry.Params.ParamByName('xTillID').AsInteger := iTillID;
    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TPOSScreenForm.BarTabFn;
begin
  // commented out cuz we need to do this for spliting a bar tab
  //  if bIsPayTab then begin
  //    CommonLib.MessageDlgXP_Vista('You cannot place a Bar Tab on a Bar Tab !!!!', mtWarning, [mbOK], 0);
  //    EXIT;
  //  end;

  if AppEnv.CompanyPrefs.POSSummarise then begin
    if idOk() then begin
      if IsLineItems then begin
        if IsTotalDiscOK() then begin
          if (char_length(sClient) = 0) or (sClient = CLIENT_CASH) then begin
            iCustOriginator := FN_BAR_TAB; // used in edtClientIDChange to identify
            ShowCustList; // get the client name

            { The processing of this transaction is completed in the edtClientIDChange as
              this OnChange event marks the return from the customer list.
              edtClientIDChange will recognize that it needs to initiate
              'FinishAddToTab'  from the value of iCustOriginator}
          end else begin
            if (iTabsClientID <> iClientID) then begin
              // We know client name so continue with process
              FinishAddToTab;
            end else begin
              CommonLib.MessageDlgXP_Vista('This Bar Tab has Already Belongs to this Customer !', mtWarning, [mbOK], 0);
              iCustOriginator := FN_BAR_TAB; // used in edtClientIDChange to identify
              ShowCustList; // get the client name
            end;
          end;
        end;
      end;
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('You Must have Summarised POS preference ON to use the ' + #13 + #10 + 'Bar Tab function', mtWarning, [mbOK], 0);
  end;
end;

procedure TPOSScreenForm.TransferTabFn;
begin
  if AppEnv.CompanyPrefs.POSSummarise then begin
    if idOk() then begin
      if IsLineItems then begin
        if IsTotalDiscOK() then begin
          if (char_length(sClient) = 0) or (sClient = CLIENT_CASH) then begin
            iCustOriginator := FN_TRANSFER_TAB; // used in edtClientIDChange to identify
            ShowCustList; // get the client name
          end else begin
            if (iTabsClientID <> iClientID) then begin
              // We know client name so continue with process
              bIsTransferTab := true;
              FinishAddToTab;
            end else begin
              CommonLib.MessageDlgXP_Vista('This Bar Tab has Already Belongs to this Customer !', mtWarning, [mbOK], 0);
              iCustOriginator := FN_TRANSFER_TAB; // used in edtClientIDChange to identify
              ShowCustList; // get the client name
            end;
          end;
        end;
      end;
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('You Must have Summarised POS preference ON to use the ' + #13 + #10 + 'Bar Tab function', mtWarning, [mbOK], 0);
  end;
end;

procedure TPOSScreenForm.FinishAddToTab;
begin
  if (char_length(sClient) = 0) or (sClient = CLIENT_CASH) then begin
    CommonLib.MessageDlgXP_Vista('You must provide a Customer Name for Tab',
      mtWarning, [mbOK], 0);
    bIsBarTab      := false;
    bIsTransferTab := false;
  end else begin
    CalcAndPostCustDisc;
    if IsCreditOk(iClientID) then begin
      bIsBarTab := true;
      sPayType := PAY_NONE;
      if bIsSplitTab then begin
        DoPayment('Bar Tab', PAY_TAB);
      end else begin
        if bIsPayTab and bIsBarTab then begin
          if bIsTransferTab and not bIsSplitTab then begin
            //Client on bar Tab Invoice
            ChangeClientOnBarTabInvoice(iTabsClientID, iClientID);
            CleanUp;
            DisplayInViewer('TRANSFERED TAB  ' + CurrToStrRJ(rRunTot, 13));
            Exit;
          end else begin
            CommonLib.MessageDlgXP_Vista('Cannot Pay A Bar Tab With A Bar Tab !', mtWarning, [mbOK], 0);
            CleanUp;
            Exit;
          end;
        end;
        PostToDB;
        SavePOS;
        CleanUp;
        DisplayInViewer('TAB  ' + CurrToStrRJ(rRunTot, 13));
      end;
    end;
    bIsBarTab      := false;
    bIsTransferTab := false;
  end;
end;

function TPOSScreenForm.IsCreditOk(const iClientID: integer): boolean;
var
  rBalance, rBarTabBal: currency;
  rPrevBal: currency;
  rCreditLimit: currency;
begin
  Result := false;

  GetCredit(iClientID, rCreditLimit, rPrevBal);
  rBarTabBal := GetBarTabBalance(iClientID);
  rBalance := rRunTot + rPrevBal + rBarTabBal;

  if rBalance <= rCreditLimit then begin
    Result := true;
  end else begin
    with TPOSCreditPopUp.Create(Self) do try
        lblCredit.Caption := CurrencyToStrF(rCreditLimit, ffCurrency);
        lblPrevBal.Caption := CurrencyToStrF(rPrevBal, ffCurrency);
        lblNewBal.Caption := CurrencyToStrF(rBalance, ffCurrency);
        lblDiff.Caption := CurrencyToStrF(rBalance - rCreditLimit, ffCurrency);
        if ShowModal = mrOk then begin
          if IsAccessAllowed('FnCreditOverride', fiEmployeeID) then begin
            Result := true;
          end;
        end;
      finally
        Free;
      end;
  end;
end;

procedure TPOSScreenForm.SplitTabFn;
var
  bOk: boolean;
  rAmount: double;
begin
  if (not bIsSplitTab) and ((not EnteringNum) or (char_length(edtPOSMemo.Lines[0]) = 0)) then begin
    CommonLib.MessageDlgXP_Vista('Please Enter the Dollar Value of this Split', mtWarning, [mbOK], 0);
    Exit;
  end;

  if bSplitInProgress then begin
    CommonLib.MessageDlgXP_Vista('Please complete the current Split', mtWarning, [mbOK], 0);
    Exit;
  end;

  if (EnteringNum {char_length(edtPOSMemo.Lines[0]) > 0}) then begin
    if IsValidAmount() then begin
      rAmount := GetAmount;
    end else begin
      CommonLib.MessageDlgXP_Vista('Invalid Amount Entered', mtWarning, [mbOK], 0);
      Exit;
    end;
  end else begin
    if CommonLib.MessageDlgXP_Vista('Assign Remaining Amount to this Split?', mtConfirmation, [mbOK, mbCancel], 0) = mrOk then begin
      rAmount := rSplitTabToPayAmount;
    end else begin
      Exit;
    end;
  end;

  // check amount specified
  bOk := true;
  if bIsSplitTab then begin
    if rAmount > rSplitTabToPayAmount then begin
      bOk := false;
    end
  end else begin
    if rAmount > rRunTot then begin
      bOk := false;
    end
  end;
  if not bOk then begin
    CommonLib.MessageDlgXP_Vista('The Split amount specified is too Large', mtWarning, [mbOK], 0);
    Exit;
  end;

  rAmountThisSplit := rAmount;
  bSplitInProgress := true;
  DisplayInViewer('Split:    ' + CurrencyToStrF(RoundTo1C(rAmountThisSplit), ffCurrency));

  if not bIsSplitTab then begin
    bIsSplitTab           := true;
    rSplitTabToPayAmount  := rRunTot;
    lblSubLabel.Visible   := false;
    lblSplit.Visible      := true;
    lblSplitLabel.Visible := true;
    lblSplit.Caption      := CurrencyToStrF(rSplitTabToPayAmount, ffCurrency);
  end;

  LoadCustomer(iCashCustomerID);
  Inc(iSplitTabGroupID);
end;

procedure TPOSScreenForm.SmartOrderBeforeShow(Sender: TObject);
begin

end;

procedure TPOSScreenForm.SmartOrderFn;
var
  idx : integer;
  pLine : pLineItemRec;
  doIt : boolean;
begin
//  OpenERPFormModal('TSmartOrderGUI', 0, SmartOrderBeforeShow, true, SmartOrderAfterShow);
  if lstLineItems.Count = 0 then
    exit;

  if (char_length(sClient) = 0) or (sClient = CLIENT_CASH) then
  begin
    CommonLib.MessageDlgXP_Vista('You must provide a customer name for Smart Order',
      mtWarning, [mbOK], 0);
    Exit;
  end;

  doIt := false;

  for idx :=  0 to lstLineItems.Count - 1 do
  begin
    pLine := lstLineItems[idx];
    doIt := pLine.Selected;
    if doIt then
      break;
  end;

  if not doIt then
  begin
    MessageDlgXP_Vista('No Products Selected For Smart Ordering.', mtWarning, [mbOk], 0);
    exit;
  end;

  // Cannot use Modal - need AfterShow event
  OpenERPForm('TSmartOrderGUI', 0, SmartOrderAfterShow, SmartOrderBeforeShow);//, true, SmartOrderAfterShow);
  // make sure the form is dead and gone
  while FormStillOpen('TSmartOrderGUI') do begin
    Sleep(10);
    Application.ProcessMessages;
  end;
// STill want to get money - do not clear the sales
//  ClearAll;
//  CleanUp;
end;

procedure TPOSScreenForm.SmartOrderAfterShow(Sender: TObject);
var
  lForm : TSmartOrderGui;
  idx : integer;
  line : PLineItemRec;
  soLine : TSmartOrderLine;
  soObj : TSmartOrder;
  oldState : TDataSetState;

begin
  if lstLineItems.Count = 0 then
    exit;  // nothing to add

  if not (Sender is TSmartOrderGui) then
    exit;

  lForm := Sender as TSmartOrderGui;
  lForm.FormStyle := fsStayOnTop; //fsNormal;
  lForm.txtSmartOrderDesc.Text  := 'Smart Order From POS';
  oldState := lForm.tblMaster.State;
  if not(oldState in [dsInsert, dsEdit]) then
    lForm.tblMaster.Edit;
  lform.tblMaster.FieldByName('SmartOrderDesc').AsString :=  'Smart Order From POS';
  lForm.tblMaster.Post;
  //if oldState <> dsBrowse then



  soObj := lForm.SmartOrder;
  for idx := 0 to lstLineItems.Count - 1 do begin
    line := pLineItemRec(lstLineItems[idx]);

//    if qryWork.Locate('ProductId', Line.ProductID, [loCaseInsensitive]) then
    if Line.Selected then
    begin
//      if qryWork.FieldByName('AvailableQty').AsFloat <= Line.Qty then
//      begin
        soObj.Lines.New;
        soLine := soObj.Lines;
        soLine.ProductID := line.ProductID;     // costs etc are loaded by the line
        soLine.UnitOfMeasureID := line.UnitID;  // multiplier and stuff is loaded by the line
        soLine.UnitOfMeasure := tcdatautils.GetUOMName(line.UnitId);
        soLine.UnitofMeasureMultiplier := Line.Multiplier;
        soLine.ToPurchaseUOMQty := Line.Qty;
        soLine.CusJobId := StrToInt(edtClientID.Text);
        soLine.CusJobName := sClient;
//      end;
    end;
  end;
//  if assigned(qryWork) then
//    FreeAndNil(fQueryWork);
end;

procedure TPOSScreenForm.SplitAccountFn;
begin
  if IsLineItems() then begin
    CommonLib.MessageDlgXP_Vista('Please Complete the In-Progress Sale', mtWarning, [mbOK], 0);
    Exit;
  end;

  if AppEnv.CompanyPrefs.POSSummarise then begin
    if idOk() then begin
      if (char_length(sClient) = 0) or (sClient = CLIENT_CASH) then begin
        iCustOriginator := FN_SPLIT_ACCOUNT; // used in edtClientIDChange to identify
        ShowCustList; // get the client name
        { The processing of this transaction is completed in the edtClientIDChange as
          this OnChange event marks the return from the customer list.
          edtClientIDChange will recognize that it needs to initiate
          'FinishSplitAccount'  from the value of iCustOriginator }
      end else begin
        // We know client name so continue with process
        FinishSplitAccount;
      end;
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('You Must have Summarised POS Preferrence ON to use the ' + #13 + #10 + 'Split Account function',
      mtWarning, [mbOK], 0);
  end;
end;




procedure TPOSScreenForm.PayTabFn;
begin
  if IsLineItems() then begin
    CommonLib.MessageDlgXP_Vista('Please Complete the In-Progress Sale', mtWarning, [mbOK], 0);
    Exit;
  end;

  if AppEnv.CompanyPrefs.POSSummarise then begin
    if idOk() then begin
      if (char_length(sClient) = 0) or (sClient = CLIENT_CASH) then begin
        iCustOriginator := FN_PAY_TAB; // used in edtClientIDChange to identify
        ShowCustList; // get the client name
        { The processing of this transaction is completed in the edtClientIDChange as
          this OnChange event marks the return from the customer list.
          edtClientIDChange will recognize that it needs to initiate
          'FinishPayTab'  from the value of iCustOriginator }
      end else begin
        // We know client name so continue with process
        iTabsClientID := iClientID;// Ian Trying To Track Orginal Bar Tab Owner
        FinishPayTab;
      end;
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('You Must have Summarised POS Preferrence ON to use the ' + #13 + #10 + 'Bar Tab function', mtWarning, [mbOK], 0);
  end;
end;

procedure TPOSScreenForm.FinishPayTab;
begin
  if (char_length(sClient) = 0) or (sClient = CLIENT_CASH) then begin
    CommonLib.MessageDlgXP_Vista('You must provide a Customer Name for Tab',
      mtWarning, [mbOK], 0);
    bIsPayTab := false;
  end else begin
    CalcAndPostCustDisc;
    iTabClientID := iClientID;
    if LoadBarTab(iClientID) then begin
      bIsPayTab := true;
    end;
  end;
end;

function TPOSScreenForm.LoadBarTab(const iClientID: integer): boolean;
var
  qry: TERPQuery;
  iPrevSaleID: integer;

  procedure LoadBarTabDate;
  var
    qry: TERPQuery;
  begin
    dtTabCreateDate := Date;
    sTabCreateTime := TimeToStr(Now());
    qry := TERPQuery.Create(nil);
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    try
      qry.SQL.Clear;
      qry.SQL.Add(' SELECT SaleDate, TimeOfSale FROM tblsales_pos' +
        ' WHERE ClientID = :xClientID AND IsInvoice = "T"' +
        ' ORDER BY SaleID;');
      qry.Params.ParamByName('xClientID').AsInteger := iClientID;
      qry.Open;
      if qry.RecordCount > 0 then begin
        qry.First;
        dtTabCreateDate := qry.FieldByName('SaleDate').AsDateTime;
        sTabCreateTime := qry.FieldByName('TimeOfSale').AsString;
      end;
    finally
      FreeAndNil(qry);
    end;
  end;
    Procedure ReserveBarTabIDs;
    begin
        if Qry.Active then Qry.close;
        Qry.SQl.clear;
        Qry.Sql.add('SELECT tblsales_pos.SaleID, tblsaleslines_pos.SaleLineID, tblsaleslines_pos.ProductID ' +
                    ' FROM tblsales_pos ' +
                    ' INNER JOIN tblsaleslines_pos ON tblsaleslines_pos.SaleID = tblsales_pos.SaleID ' +
                    ' WHERE ClientID = ' + IntToStr(iClientID) + ' AND IsInvoice = "T"');
        Qry.Open;
        if Qry.Recordcount = 0 then Exit;
        qry.first;
        While Qry.Eof = False do begin
            New(ProcessedBarTabItem);
            ProcessedBarTabItem^.BarTabID       := Qry.Fieldbyname('SaleID').asInteger;
            ProcessedBarTabItem^.BarTabLineId   := Qry.Fieldbyname('SaleLineID').asInteger;
            ProcessedBarTabItem^.ProductID      := Qry.Fieldbyname('ProductID').asInteger;
            LstProcessedBarTabs.Add(ProcessedBarTabItem);
            Qry.Next;
        end;
    end;
begin
  Result := false;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    with qry do begin
      Close;
      SQL.Clear;
      LoadBarTabDate;
      if AppEnv.CompanyPrefs.POSSummariseBarTabInv then begin
        SQL.Add('SELECT 0 as SaleId, 0 as SaleLineID, ProductID, ProductName, ProductPrintName, Product_Description, PARTTYPE, ' +
          ' SUM(UnitOfMeasureQtySold) as UnitOfMeasureQtySold, SUM(QtySold) as QtySold, ' +
          ' SUM(TotalLineAmount) as TotalLineAmount, ' +
          ' SUM(TotalLineAmountInc) as TotalLineAmountInc, ' +
          ' LinePrice, LinePriceInc, UnitOfMeasureMultiplier, UnitOfMeasureID, LineTaxRate, INCOMEACCNT, ' +
          ' ASSETACCNT, COGSACCNT, ProductGroup, LineCost, LineCostInc, ' +
          ' LineTaxCode, ' +
          ' UnitOfMeasureSaleLines, TillID, Area ' +
          ' FROM tblsales_pos ' +
          'INNER JOIN tblsaleslines_pos USING (SaleID) ' +
          'WHERE ClientID = :xClientID AND IsInvoice = "T"');
        SQL.Add('GROUP BY Product_Description, TillID, Area');
      end else begin
        SQL.Add('SELECT tblsaleslines_pos.SaleLineId, tblsales_pos.SaleID, ProductID, ProductName, ProductPrintName, Product_Description, PARTTYPE, ' +
          ' UnitOfMeasureQtySold, QtySold, ' +
          ' TotalLineAmount, TotalLineAmountInc, ' +
          ' LinePrice, LinePriceInc, UnitOfMeasureMultiplier, UnitOfMeasureID , LineTaxRate, INCOMEACCNT, ' +
          ' ASSETACCNT, COGSACCNT, ProductGroup, LineCost, LineCostInc, ' +
          ' LineTaxCode, ' +
          ' UnitOfMeasureSaleLines, TillID, Area, SaleDate, TimeOfSale ' +
          ' FROM tblsales_pos ' +
          'INNER JOIN tblsaleslines_pos USING (SaleID) ' +
          'WHERE ClientID = :xClientID AND IsInvoice = "T"');
        SQL.Add('ORDER BY tblsales_pos.SaleID');
      end;
      Params.ParamByName('xClientID').AsInteger := iClientID;
      Open;
      First;
      if qry.RecordCount > 0 then begin
        iPrevSaleID := 0;
        while not qry.Eof do begin
          if AppEnv.CompanyPrefs.POSSummariseBarTabInv then begin
            CreateTabLineItem(qry);
          end else begin
            if iPrevSaleID <> qry.FieldByName('SaleID').AsInteger then begin
              // change of saleId, so give it a heading using a memo part
              iPrevSaleID := qry.FieldByName('SaleID').AsInteger;
              CreateMemoPartLine(FormatDateTime(MysqlTimeFormat12hr, qry.FieldByName('TimeOfSale').AsDateTime) + ' - ' +
                GetTillName(qry.FieldByName('TillID').AsInteger));
            end;
            CreateTabLineItem(qry);
          end;
          qry.Next;
        end;
        Result := true;
        RebuildGrid;
        if Qry.Active then Qry.close;

        REserveBarTabIDs;
      end else begin
        CommonLib.MessageDlgXP_Vista('No TAB Current for this Customer', mtConfirmation, [mbOK], 0);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TPOSScreenForm.CreateTabLineItem(const qryLines: TDataset);
var
  SubProductRec: TSubProductRec;
begin
  with SubProductRec do begin
    ProductID := qryLines.FieldByName('ProductID').AsInteger;
    Valid     := true;
    if char_length(qryLines.FieldByName('UnitOfMeasureSaleLines').AsString) > 0 then begin
      Units := qryLines.FieldByName('UnitOfMeasureSaleLines').AsString;
      UnitsMultiplier := qryLines.FieldByName('UnitOfMeasureMultiplier').AsFloat;
      SubProductDesc := qryLines.FieldByName('Product_Description').AsString;
      PriceEx := qryLines.FieldByName('LinePrice').AsFloat * UnitsMultiplier;
    end;
  end;

  NewLineItem;
  with LineItem^ do begin
    ProductID           := qryLines.FieldByName('ProductID').AsInteger;
    Qty                 := qryLines.FieldByName('UnitOfMeasureQtySold').AsFloat;
    ProductDescription  := qryLines.FieldByName('Product_Description').AsString;
    ProductName         := qryLines.FieldByName('ProductName').AsString;
    ProductPrintName    := qryLines.FieldByName('ProductPrintName').AsString;
    PartType            := qryLines.FieldByName('PARTTYPE').AsString;
    Amount              := qryLines.FieldByName('TotalLineAmountInc').AsFloat;
    Multiplier          := qryLines.FieldByName('UnitOfMeasureMultiplier').AsFloat;
    LinePrice           := qryLines.FieldByName('LinePrice').AsFloat * Multiplier;
    LinePriceInc        := qryLines.FieldByName('LinePriceInc').AsFloat * Multiplier;
    Area                := qryLines.FieldByName('Area').AsString;
    LaybyId             := 0;
    LaybyBal            := 0;
    LaybyAmount         := 0;
    TaxRate             := qryLines.FieldByName('LineTaxRate').AsFloat;
    //GlobalRef := '';
    IncomeAccnt         := qryLines.FieldByName('IncomeAccnt').AsString;
    AssetAccnt          := qryLines.FieldByName('AssetAccnt').AsString;
    CogsAccnt           := qryLines.FieldByName('CogsAccnt').AsString;
    ProductGroup        := qryLines.FieldByName('ProductGroup').AsString;;
    LineCost            := qryLines.FieldByName('LineCost').AsFloat;
    LineCostInc         := qryLines.FieldByName('LineCostInc').AsFloat;
    ApplyDisc           := false;
    IsProduct           := false; // i think that this will prevent unwanted processing
    IsDiscount          := false;
    DiscRatio           := 1;
    IsChild             := false;
    PriceChanged        := true;
    IsVoucher           := false;
    IsRedeeming         := false;
    VoucherNo           := '';
    IssuedBy            := '';
    IsToBeDeleted       := false;
    SubProduct          := SubProductRec; // sub product attributes
    FixedPrice          := true;
    UnitID              := qryLines.FieldByName('UnitOfMeasureID').asInteger;
    IsFrozen            := true;
    BarTabId            := QryLines.fieldbyname('SaleID').asInteger;
    BarTabLineId        := QryLines.fieldbyname('SaleLineID').asInteger;
    IsAccountPayment    := false;
    lstLineItems.Add(LineItem);
  end
end;



procedure TPOSScreenForm.DeleteBarTab(const iClientID: integer);
  // remove all records that have been summarised for this Client
var
  qryTabs: TERPQuery;
  qryDel: TERPCommand;
begin
  if not Assigned(oBarTabIDList) then
    oBarTabIDList:= TStringList.Create;

  oBarTabIDList.Clear;

  qryTabs := TERPQuery.Create(nil);
  qryTabs.Options.FlatBuffers := True;
  qryDel := TERPCommand.Create(nil);
  try
    qryDel.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTabs.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTabs.SQL.Text:=
      'Select SaleID From tblsales_pos ' +
      'Where IsInvoice = "T" ' +
      'AND ClientId = '+IntToStr(iClientID) +';';

    qryTabs.Open;
    qryTabs.First;
    while not qryTabs.Eof do begin
      oBarTabIDList.Add(qryTabs.FieldByName('SaleID').AsString);
      qryTabs.Next;
    end;

    if Assigned(oBarTabIDList) and (oBarTabIDList.Count > 0) then begin
      qryDel.SQL.add( 'DELETE FROM tblsales_pos WHERE SaleID IN (' + oBarTabIDList.CommaText + ');');
      qryDel.SQL.add( 'DELETE FROM tblsaleslines_pos WHERE SaleID IN (' + oBarTabIDList.CommaText + ');');
      qryDel.SQL.add('DELETE FROM tblsalespayments_pos WHERE SaleID IN (' + oBarTabIDList.CommaText + ');');
      qryDel.Execute;
    end;

  finally
    FreeAndNil(oBarTabIDList);
    FreeandNil(qryTabs);
    FreeandNil(qryDel);
  end;
end;

procedure TPOSScreenForm.CloseAllTabsFn;
  // Create invoices (by client) for all Bar Tab entries that have been summarised.
begin
  if IsLineItems() then begin
    CommonLib.MessageDlgXP_Vista('Please Complete the In-Progress Sale', mtWarning, [mbOK], 0);
    Exit;
  end;

  if not AppEnv.CompanyPrefs.POSSummarise then begin
    CommonLib.MessageDlgXP_Vista('You Must have Summarised POS Preferrence ON to use the ' + #13 + #10 + 'Bar Tab function', mtWarning, [mbOK], 0);
    Exit;
  end;

  if idOk() then begin
    if CommonLib.MessageDlgXP_Vista('Invoices will be Created and the Bar Tab Accounts Closed'#10#13 +
      'for ALL Bar Tab Clients.'#10#13 +
      'Do you wish to proceed?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      GenerateAllBarTabInvoices;
    end;
  end;
end;


procedure TPOSScreenForm.GenerateAllBarTabInvoices;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  qry.ParamCheck := false;
  qry.Options.StrictUpdate := false;
  try
    with qry do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ClientID ' +
        ' FROM tblsales_pos ' +
        'WHERE IsInvoice = "T" ' +
        'GROUP BY ClientID');
      Open;
      First;
      while not qry.Eof do begin
        Application.ProcessMessages;
        CreateBarTabInvoice(qry.FieldByName('ClientID').AsInteger);
        Application.ProcessMessages;
        DeleteBarTab(qry.FieldByName('ClientID').AsInteger);
        Application.ProcessMessages;
        Next;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

constructor TPOSScreenForm.Create(AOwner: TComponent);
begin
  inherited;
  Self.WindowState := wsMaximized;
end;

procedure TPOSScreenForm.CreateBarTabInvoice(const iClientID: integer);
begin
  ClearAll;
  bIsCloseTab := true;
  LoadCustomer(iClientID);
  LoadBarTab(iClientID);
  IsPOSInvoice := true;
  bIsPayTab := true; // just in case it's not already set.
  sPayType := PAY_NONE;
  PostToDB;  // create the sale
  SavePOS;
  Application.ProcessMessages;
  CompleteBarTabInvoice; // Complete the invoice
  Application.ProcessMessages;
  CleanUp;
end;

procedure TPOSScreenForm.CreateMemoPartLine(const sText: string; const dAmount: currency = 0.0);
begin
  FilterPartsByName(PART_MEMO);
  if not PostSaleItem(sText, dAmount, 1, 0, 0.0, 0.0, false, true, false, false) then Exit;
end;

function TPOSScreenForm.IsAnyBarTabs: boolean;
var
  qry: TERPQuery;
begin
  Result := false;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  qry.ParamCheck := false;
  qry.Options.StrictUpdate := false;
  try
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT SaleID FROM tblsales_pos WHERE IsInvoice = "T"');
      Open;
      if not IsEmpty then begin
        Result := true;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;


procedure TPOSScreenForm.CustSalesFn;
begin
  iSaleId := 0;
  openERPListForm('TSalesListReportGUI', nil, SalesListAfterShow);

  while FormStillOpen('TSalesListReportGUI') do begin
    Sleep(10);
    Application.ProcessMessages;
  end;

  if iSaleId = 0 then
    exit;
  FillLinesBySaleId(iSaleId);
end;

procedure TPOSScreenForm.FinishCustSales;
var
  iProductID: integer;
  tmpComponent: TComponent;
begin
  // check if user has selected a specific product
  if (grdTrans.Col = 0) then begin
    // this is the best I can do for determining if no cell has been selected - could cause issues
    // none selcted, so get the last product entered in the grid
    iProductID := GetLastProduct;
  end else begin
    // use the product from the string grid row that the user has selected
    iProductID := pLineItemRec(lstLineItems[grdTrans.Row - 1])^.ProductID;
  end;

  if IsAnySalesOnProduct(iClientID, iProductID) then begin
      if not FormStillOpen('TCustomerSalesOnProductListGUI') then begin
        tmpComponent := GetComponentByClassName('TCustomerSalesOnProductListGUI');
        If not Assigned(tmpComponent) then Exit;
        with TCustomerSalesOnProductListGUI(tmpComponent) do begin
          lblCustomer.Caption := self.lblCustomer.Caption;
          fiClientID := iClientID;
          fiProductID := iProductID;
          FormStyle := fsMDIChild;
        end
      end
      else begin
        TForm(FindExistingComponent('TCustomerSalesOnProductListGUI')).Show;
      end;
  end else begin
    CommonLib.MessageDlgXP_Vista('No Sales Recorded on this Product for this Customer', mtInformation, [mbOK], 0);
  end;
end;

function TPOSScreenForm.GetLastProduct: integer;
  // Returns the last product.
var
  i: integer;
begin
  Result := 0;
  if lstLineItems.Count = 0 then begin
    Exit;
  end;

  for i := lstLineItems.Count - 1 downto 0 do begin
    if pLineItemRec(lstLineItems[i])^.IsProduct then begin
      Result := pLineItemRec(lstLineItems[i])^.ProductID;
      Break;
    end;
  end;
end;

procedure TPOSScreenForm.PayAccountFn;
var
  dValue: currency;
begin
  if bIsTraining then begin
    CommonLib.MessageDlgXP_Vista('Paying Accounts can not be done in training mode', mtInformation,  [mbOk], 0);
    exit;
  end;

  if idOk() then begin
    if EnteringNum then begin
      if not GetFloatValue(dValue) then begin
        Exit;
      end;
    end;

    if not IsValidCustomer(iClientID) then begin
      iCustOriginator := FN_PAY_ACCOUNT; // used in edtClientIDChange to identify
      ShowCustList; // get the client
       { The processing of this transaction is completed in the edtClientIDChange as
         this OnChange event marks the return from the customer list.
         edtClientIDChange will recognize that it needs to initiate
         'FinishPayAccount'  from the value of iCustOriginator }
    end else begin
      // We know client so continue with process
      FinishPayAccount;
      iTabsClientID := iClientID;// Ian Trying To Track Original Bar Tab Owner
    end;
  end;
end;

procedure TPOSScreenForm.FinishPayAccount;
var
  frm: TfmCustPayments;
  ParentRelatedClientID: Integer;
begin
  // Create the Customer Payment form and set some initail values in that form
  frm := TfmCustPayments(GetComponentByClassName('TfmCustPayments'));
  If not Assigned(frm) then Exit;
  frm.POSInitiated := true;
  ParentRelatedClientID := GetParentRelatedClientID(iClientID);

  if ParentRelatedClientID <> 0 then
    frm.POSClientID := ParentRelatedClientID
  else
    frm.POSClientID := iClientID;

  if EnteringNum then begin
    frm.POSAmount := StrValue(edtPOSMemo.Lines[0]);
  end;

  frm.ShowModal;

  if frm.POSPaymentMade then begin
    // create a sale line part of payment part
    FilterPartsByName(PART_MEMO);
    CreateMemoPartLine('Account Payment(ID: ' + IntToStr(frm.POSPaymentID) + '): ' +
      FloatToStrF(frm.POSAmount, ffCurrency, 15, CurrencyRoundPlaces),
      frm.POSAmount);
    pLineItemRec(lstLineItems.Last)^.IsAccountPayment := true;
    pLineItemRec(lstLineItems.Last)^.AcntPayMethodID  := frm.POSPayMethodID;
    pLineItemRec(lstLineItems.Last)^.AcntPaymentID    := frm.POSPaymentID;
    pLineItemRec(lstLineItems.Last)^.IsFrozen         := true;
    DisplayLineItem(lstLineItems.Last);
  end;
end;

function TPOSScreenForm.GetFloatValue(var Value: currency): boolean;
begin
  Result := true;
  try
    Value := StrToFloat(edtPOSMemo.Lines[0]);
  except
    on EConvertError do begin
      CommonLib.MessageDlgXP_Vista('Not a valid Amount', mtWarning, [mbOK], 0);
      Result := false;
    end;
  end;
end;

function TPOSScreenForm.IsValidCustomer(const iClientID: integer): boolean;
begin
  Result := not ((iClientID = 0) or (iClientID = iCashCustID));
end;

procedure TPOSScreenForm.AdjustPayments;
  // Adjusts payments by any Account Payment amounts.
var
  i: integer;
  pItem: pLineItemRec;
  pPayment: pPaymentRec;
  rTotAcntPayments: double;
  rTotPayments: double;
begin
  if lstPayments.Count > 1 then begin
    // too hard with many payments if we want to allow for Account Payments
    // .. so combine together as SPLIT
    rTotPayments := 0;
    for i := 0 to lstPayments.Count - 1 do begin
      rTotPayments := rTotPayments + pPaymentRec(lstPayments[i]).Amount;
    end;
    for i := 0 to lstPayments.Count - 1 do begin
      Dispose(lstPayments[i]);
    end;
    lstPayments.Clear;

    // create a new, single payment
    New(pPayment);
    lstPayments.Add(pPayment);
    pPayment^.PaymentType := PAY_SPLIT;
    pPayment^.Amount      := rTotPayments;
  end else begin
    if (lstPayments.Count <> 0) then begin
      pPayment := lstPayments[0];
    end else Exit;
  end;

  rTotAcntPayments := 0;
  for i := 0 to lstLineItems.Count - 1 do begin
    pItem := lstLineItems[i];
    if pItem^.IsAccountPayment then begin
      pPayment^.Amount := pPayment^.Amount - pItem^.Amount;
      rTotAcntPayments := rTotAcntPayments + pItem^.Amount;

      // make sure this memo part does not create any $'s
      pItem^.Amount := 0;
      pItem^.Qty := 0;
      pItem^.LinePrice := 0;
      pItem^.Multiplier := 0;
      pItem.LinePriceInc := 0;
      pItem^.TaxRate := 0;
      pItem^.LineCost := 0;
    end;
  end;

  if rTotAcntPayments <> 0 then begin
    CreateEOPPayment(rTotAcntPayments, pPayment^.PaymentType);
  end;
end;

procedure TPOSScreenForm.AfterformShow;
begin
  inherited;
  fbNoSavesound:=true;
  fbNoCanelsound:= True;
end;

procedure TPOSScreenForm.AfterpayFn;
begin
  if idOk() then begin
    DoPayment('Afterpay', PAY_AFTERPAY);
  end;
end;

procedure TPOSScreenForm.CreateEOPPayment(const rAmount: double; const sPayMethod: string);
var
  qry: TERPCommand;
begin
  qry := TERPCommand.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  qry.ParamCheck := true;
  try
    with qry do begin
      Sql.Clear;
      Sql.Add('INSERT tblposeoppayments ' +
        '(Date, ' +
        'PayMethod, ' +
        'TillID, ' +
        'Amount) ' +
        'VALUES ' +
        '(:xDate, ' +
        ':xPayMethod, ' +
        ':xTillID, ' +
        ':xAmount);');
      with qry.Params do begin
        ParamByName('xDate').AsDateTime := Date;
        ParamByName('xPayMethod').AsString := sPayMethod;
        ParamByName('xTillID').AsInteger := iTillID;
        ParamByName('xAmount').AsFloat := rAmount;
      end;
      Execute;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TPOSScreenForm.CreateReceiptLists;
  // These lists are used when printing receipts. They should be created and saved
  // .. early in the posting processing to avoid any changes to info in the parent lists.
  // eg Payment list gets changed during 'Account payment' Processing
var
  pPay: pPaymentRec;
  pRcptPay: pRcptPayRec;
  i: integer;
begin
  ClearReceiptLists;
  if bIsSplitTab then begin
    rRcptRunTot      := rAmountThisSplit;
    rRcptRunTotNoTax := rRunTotNoTax * DivZer(rAmountThisSplit, rRunTot); // aportion the tax according to the split
  end else begin
    rRcptRunTot      := rRunTot;
    rRcptRunTotNoTax := rRunTotNoTax;
  end;
  for i := 0 to lstPayments.Count - 1 do begin
    pPay := lstPayments[i];
    if (not bIsSplitTab) or (pPay^.SplitTabID = iSplitTabGroupID) then begin
      New(pRcptPay);
      lstRcptPayments.Add(pRcptPay);
      pRcptPay^.PaymentType := pPay^.PaymentType;
      pRcptPay^.Amount := pPay^.Amount;
      pRcptPay^.Tendered := pPay^.Tendered;
      pRcptPay^.Ref := pPay^.Ref;
    end;
  end;
end;

procedure TPOSScreenForm.ClearReceiptLists;
begin
  // Clear payments list
  try
    while lstRcptPayments.Count > 0 do begin
      try
        Dispose(lstRcptPayments.Items[0]);
      except
      end;
      lstRcptPayments.Delete(0);
    end;
  except
  end;
end;

function TPOSScreenForm.IsAnySalesOnProduct(const iClientID, iProductID: integer): boolean;
var
  qry: TERPQuery;
begin
  Result := false;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  qry.ParamCheck := true;
  qry.Options.StrictUpdate := false;
  try
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT Count(*) as Count ' +
        'FROM tblsales AS S ' +
        'INNER JOIN tblsaleslines AS L USING (SaleID) ' +
        'WHERE ClientID = :xClientID AND ProductID = :xProductID ' +
        'ORDER BY S.SaleDate DESC '
        );
      qry.Params.ParamByName('xClientID').AsInteger := iClientID;
      qry.Params.ParamByName('xProductID').AsInteger := iProductID;
      Open;
      if qry.FieldByName('Count').AsInteger > 0 then begin
        Result := true;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

Procedure TPOSScreenForm.setIsPOSInvoice(Const Value:Boolean);
begin
  bISInvoice := Value;
  TRy
    if (POSObj <> nil) then
      if POSObj.count > 0 then
        POSObj.IsPOSInvoice := Value;
  Except
    //kill the exception
  end;
end;

procedure TPOSScreenForm.setIsPosQuote(const Value: boolean);
begin
  bIsQuote := Value;
  TRy
    if (POSObj <> nil) then
      if POSObj.count > 0 then
        POSObj.IsPOSQuote := Value;
  Except
    //kill the exception
  end;
end;

procedure TPOSScreenForm.setIsPOSSalesOrder(const Value: boolean);
begin
  bIsSalesOrder := Value;
  TRy
    if (POSObj <> nil) then
      if POSObj.count > 0 then
        POSObj.IsPOSSalesOrder := Value;
  Except
    //kill the exception
  end;
end;

procedure TPOSScreenForm.SetFuncBookingID(const iFuncBookingID: integer);
  // this creates a POS sale from the quote specified.  It is designed
  // .. for use by the quote form when a POS conversion is requested.
var
  ayQryDetails: array[0..1] of TERPQuery;
  i: integer;
  qryBooks: TERPQuery;
  qryRooms: TERPQuery;
  qryMeals: TERPQuery;
  qryDrinks: TERPQuery;
  rBookExtras: currency;
  rQty: double;
  bOK: boolean;
begin
  rBookExtras := 0;
  if bTransComplete then begin
    bOK := false;
    ClearAll;
    bTransComplete      := false;
    self.iFuncBookingID := iFuncBookingID;

    qryBooks := TERPQuery.Create(nil);
    qryBooks.Options.FlatBuffers := True;
    qryBooks.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryBooks.ParamCheck := false;
    qryBooks.Options.StrictUpdate := false;

    qryRooms := TERPQuery.Create(nil);
    qryRooms.Options.FlatBuffers := True;
    qryRooms.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryRooms.ParamCheck := false;
    qryRooms.Options.StrictUpdate := false;

    qryMeals := TERPQuery.Create(nil);
    qryMeals.Options.FlatBuffers := True;
    qryMeals.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryMeals.ParamCheck := true;
    qryMeals.Options.StrictUpdate := false;

    qryDrinks := TERPQuery.Create(nil);
    qryDrinks.Options.FlatBuffers := True;
    qryDrinks.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryDrinks.ParamCheck := true;
    qryDrinks.Options.StrictUpdate := false;

    try
      with qryBooks do begin
        SQL.Clear;
        SQL.Add('SELECT FuncBookingID, ClientID, BillToClientID, UseBillTo, Extras, TotalInc ' +
          'FROM tblFuncBookings WHERE FuncBookingID = ' + IntToStr(iFuncBookingID) + ';');
        Open;
        if not IsEmpty then begin
          if FieldByName('UseBillTo').AsString = 'T' then begin
            LoadCustomer(FieldByName('BillToClientID').AsInteger);
          end else begin
            LoadCustomer(FieldByName('ClientID').AsInteger);
          end;
          //rTotalInc := FieldByName('TotalInc').AsFloat;
          rBookExtras := FieldByName('Extras').AsFloat;
          bOK := true;
        end else begin
          CommonLib.MessageDlgXP_Vista('Function Booking ID "' + IntToStr(iFuncBookingID) + '" not found'#13 +
            'in tblFuncBookings.', mtWarning, [mbOK], 0);
        end;
      end;

      // Post the booking  lines
      if bOK then begin
        qryRooms.SQL.Clear;
        qryRooms.SQL.Add('SELECT RoomAllocationID, FuncBookingID, ' +
          'A.RoomID, Name, Start, End, ' +
          'StartDummy, EndDummy, ' +
          'Extras, LinePriceInc ' +
          'FROM tblfuncroomallocation as A ' +
          'LEFT JOIN tblFuncRooms USING (RoomID) ' +
          'WHERE  FuncBookingID = ' + IntToStr(iFuncBookingID) + ';');
        qryRooms.Open;

        qryMeals.SQL.Clear;
        qryMeals.SQL.Add('SELECT RoomAllocationID, FuncMealID, ProductID, ' +
          'Meal, MealSortOrder, ' +
          'Course, CourseSortOrder, Qty, Date, Time, ' +
          'ProductName, Description, Price, ' +
          'FuncBookingID, RoomAllocationID ' +
          'FROM tblfuncbookingmeals ' +
          'WHERE RoomAllocationID = :xRoomAllocationID ' +
          'ORDER BY MealSortOrder, CourseSortOrder; ');

        qryDrinks.SQL.Clear;
        qryDrinks.SQL.Add('SELECT RoomAllocationID, FuncDrinkID, ProductID, ' +
          'Meal, MealSortOrder, ' +
          'Course, CourseSortOrder, Qty, Date, Time, ' +
          'ProductName, Description, Price, ' +
          'FuncBookingID, RoomAllocationID ' +
          'FROM tblfuncbookingdrinks ' +
          'WHERE RoomAllocationID = :xRoomAllocationID ' +
          'ORDER BY MealSortOrder, CourseSortOrder; ');

        qryRooms.First;
        while not qryRooms.Eof do begin
          // post the room booking
          if FilterPartsByID(DNMLib.GetPartID(PART_ROOM)) then begin
            bPriceChange := true;
            rPriceChange := qryRooms.FieldByName('LinePriceInc').AsFloat - qryRooms.FieldByName('Extras').AsFloat;
            bApplyDiscToPriceChange := true;
            if PostSaleItem(qryRooms.FieldByName('Name').AsString +
              ' (' + qryRooms.FieldByName('Start').AsString +
              ' - ' + TimeToStr(qryRooms.FieldByName('End').AsDateTime) + ')',
              0, 1, 0, 0.0, 0.0, false, true, true) then
                DisplayLineItem(lstLineItems.Last);
          end;

          // post room Extras
          if qryRooms.FieldByName('Extras').AsFloat <> 0 then begin
            if FilterPartsByID(DNMLib.GetPartID(PART_EXTRAS)) then begin
              bPriceChange := true;
              rPriceChange := qryRooms.FieldByName('Extras').AsFloat;
              bApplyDiscToPriceChange := true;
              if PostSaleItem('Room Extras', 0,
                1, 0, 0.0, 0.0, false, true, true) then
                DisplayLineItem(lstLineItems.Last);
            end;
          end;

          // post Meals & Beverages
          ayQryDetails[0] := qryMeals;
          ayQryDetails[1] := qryDrinks;
          for i := 0 to 1 do begin
            ayQryDetails[i].Close;
            ayQryDetails[i].Params.ParamByName('xRoomAllocationID').AsInteger :=
              qryRooms.FieldByName('RoomAllocationID').AsInteger;
            ayQryDetails[i].Open;

            ayQryDetails[i].First;
            while not ayQryDetails[i].Eof do begin
              // post the detail
              if FilterPartsByID(ayQryDetails[i].FieldByName('ProductID').AsInteger) then begin
                rQty := ayQryDetails[i].FieldByName('Qty').AsFloat;
                bPriceChange := true;
                rPriceChange := DivZer(ayQryDetails[i].FieldByName('Price').AsFloat, rQty);
                bApplyDiscToPriceChange := true;
                if PostSaleItem(ayQryDetails[i].FieldByName('Description').AsString,
                  0, rQty, 0, 0.0, 0.0, false, true, true) then
                    DisplayLineItem(lstLineItems.Last);
              end;
              ayQryDetails[i].Next;
            end;
          end; // for i := 0 to 1
          qryRooms.Next;
        end;

        // now post Booking Extras  (as opposed to room extras)
        if rBookExtras <> 0 then begin
          if FilterPartsByID(DNMLib.GetPartID(PART_EXTRAS)) then begin
            bPriceChange := true;
            rPriceChange := rBookExtras;
            bApplyDiscToPriceChange := true;
            if PostSaleItem('Booking Extras', 0,
              1, 0, 0.0, 0.0, false, true, true) then
                DisplayLineItem(lstLineItems.Last);
          end;
        end;
      end;
    finally
      FreeandNil(qryBooks);
      FreeandNil(qryRooms);
      FreeandNil(qryMeals);
      FreeandNil(qryDrinks);
    end; // try

    DisplayInViewer('Room Booking Conversion');
  end;
end;


procedure TPOSScreenForm.PerformEndOfSplitTab;
var
  i: integer;
begin
  // This sale is to be nullified but we still want to update the inventory quantities, so
  // .. we create the reverseal part for the origianl value and assign it to this sale.
  FilterPartsByName(PART_REVERSAL);
  if not PostSaleItem('Split Payment Reversal', - rRunTot,
    1, 0, 0.0, 0.0, false, true, false) then Exit;
  DisplayLineItem(lstLineItems.Last);
  ReCalcRunTot;

  // create a copy of all the payments for use when creating the sales for each split
  for i := 0 to lstPayments.Count - 1 do begin
    lstSplitTabPayments.Add(lstPayments[i]);
  end;

  // this sale will have no payments - they will be reassigned to new sales
  lstPayments.Clear;  // do not dispose
  bIsEndOfSplitTab := true;
end;

procedure TPOSScreenForm.CreateSplitTabSales;
var
  i, j: integer;
  pPayment: pPaymentRec;
  rTotal: currency;
begin
  // Create a sale for each of the splits
  for i := 1 to iSplitTabGroupID do begin
    // get value of this split
    rTotal    := 0;
    bIsBarTab := false;
    lstPayments.Clear;  // do not dispose
    for j := 0 to lstSplitTabPayments.Count - 1 do begin
      pPayment := lstSplitTabPayments[j];
      if pPayment^.SplitTabID = i then begin
        rTotal := rTotal + pPayment.Amount;
        lstPayments.Add(lstSplitTabPayments[j]);
      end;
    end;

    //  Create sale for this split
    rRunTot      := 0.0;
    rRunTotNoTax := 0.0;
    CleanUp;
    bIsSplitTab := true;

    // if this split is to go to another customers bartab
    pPayment := lstPayments.Last;  //
    if pPayment^.IsBarTab then begin
      bIsBarTab := true;
    end;
    LoadCustomer(pPayment^.ClientID);

    // Clear line items list
    for j := 0 to lstLineItems.Count - 1 do Dispose(lstLineItems.Items[j]);
    lstLineItems.Clear;
    FilterPartsByName(PART_PAYMENT);
    if PostSaleItem('Split Tab Payment for Sale ID: ' + sSplitParentID,
      rTotal, 1, 0, 0.0, 0.0, false, true, false) then
       PostToDB;
  end;
  lstPayments.Clear;  // do not dispose
end;

procedure TPOSScreenForm.TabListFn;
Var
  tmpComponent: TComponent;
begin
  if IsLineItems() then begin
    CommonLib.MessageDlgXP_Vista('Please Complete the In-Progress Sale', mtWarning, [mbOK], 0);
    Exit;
  end;

  if AppEnv.CompanyPrefs.POSSummarise then begin
    if idOk() then begin
      edtClientID.Text := '';
      iCustOriginator := FN_TAB_LIST;
      if not FormStillOpen('TBarTabListGUI') then begin
        tmpComponent := GetComponentByClassName('TBarTabListGUI');
        If not Assigned(tmpComponent) then Exit;
        with TBaseListingGUI(tmpComponent) do begin
          FormStyle:= fsMDIChild;
          OnGridDataSelect :=OnBarTabSelect;
        end;
      end else begin
        TForm(FindExistingComponent('TBarTabListGUI')).show;
      end;
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('You Must have Summarised POS Preferrence ON to use the ' + #13 + #10 + 'Bar Tab function', mtWarning, [mbOK], 0);
  end;
end;

procedure TPOSScreenForm.OnBarTabSelect(Sender: TwwDBGrid);
var
  qry: TERPQuery;
begin
  {Get the list of sale Ids for this customers bar tab}
  if not Assigned(oBarTabIDList) then
    oBarTabIDList:= TStringList.Create;
  oBarTabIDList.Clear;
  qry:= TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    qry.Connection:= commonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text:=
      'Select SaleID From tblsales_pos ' +
      'Where tblsales_pos.SaleDate Between :DateFrom AND :DateTo '+
      'AND IsInvoice = "T" ' +
      'AND ClientId = :ClientID ' +
      'Group By tblsales_pos.SaleID';
    qry.ParamByName('DateFrom').AsDate:= TBaseListingGUI(Sender.Owner).dtFrom.Date;
    qry.ParamByName('DateTo').AsDate:= TBaseListingGUI(Sender.Owner).dtTo.Date;
    qry.ParamByName('ClientID').AsInteger:=
      Sender.DataSource.Dataset.FieldByName('ClientID').AsInteger;
    qry.Open;
    while not qry.Eof do begin
      oBarTabIDList.Add(qry.FieldByName('SaleID').AsString);
      qry.Next;
    end;

  finally
    FreeAndNil(qry);
  end;
  edtClientID.Text := Sender.DataSource.Dataset.FieldByName('ClientID').AsString;
end;

procedure TPOSScreenForm.FinishTabList;
begin
  FinishPayTab;
end;

procedure TPOSScreenForm.TableSelectorFn;
Var
  tmpComponent: TComponent;
begin
  iCustOriginator := 0;
  if not FormStillOpen('TfrmPOSTableSelectorGUI') then begin
    tmpComponent := GetComponentByClassName('TfrmPOSTableSelectorGUI');
    If not Assigned(tmpComponent) then Exit;
    with TfrmPOSTableSelectorGUI(tmpComponent) do begin
      KeyID := tcDataUtils.getFuncRoomID('DefaultRoom');     //oPOSBtnMatrix.Selected.Func.RoomID;
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TPOSScreenForm.ChangeClientOnBarTabInvoice(const OldiClient, iClient: integer);
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('UPDATE tblsales_pos SET ');
    qryTemp.Sql.Add('CustomerName= ' + QuotedStr(sClient) + ', ');
    qryTemp.Sql.Add('ClientID= ' + IntToStr(iClient) + ', ');
    qryTemp.Sql.Add('InvoiceTo= ' + QuotedStr(sClientBTAddress) + ', ');
    qryTemp.Sql.Add('ShipTo= ' + QuotedStr(sClientPHAddress) + ' ');
    qryTemp.Sql.Add('WHERE ClientID = ' + IntToStr(OldiClient) + ' AND IsInvoice = "T";');
    try
      qryTemp.Execute;
    except
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TPOSScreenForm.grdTransDblClickCell(Sender: TObject; ARow, ACol: integer);
  {Show Qtys}
var
  pItem: pLineItemRec;
//  tmpComponent: TComponent;
begin

  if not bTransComplete then begin
    // allow user to reverse any Serial number tracking
    if (ARow < 1) OR (lstLineItems.Count=0) OR (lstLineItems.Count < ARow) then Exit;

  pItem := ItemForGridIndex(ARow);//   lstLineItems[ARow - 1];
  if pItem = nil then exit;
  if aCol = 3 then begin
    if iclientId= 0 then
      TfmproductPrices.showProduct(pItem^.productId, iCashCustID, '', pItem^.unitID , pItem^.Qty*pItem^.multiplier  , pItem^.TaxRate , pItem^.MAtrixRef , 0,0)
    else
      TfmproductPrices.showProduct(pItem^.productId, iclientId, '', pItem^.unitID , pItem^.Qty*pItem^.multiplier, pItem^.TaxRate, pItem^.MAtrixRef, 0,0);

  end else begin

    TempProductID := pItem^.ProductID;
    TempClassID   := tcDatautils.GetTillClassID(iTillID);

    if not AppEnv.Employee.NoQtyDrillDownOnSales then begin
      OpenERPFormModal('TfrmProductQtyBinETA' , 0 , initProductQtyBinETA);
    end;
  end;
  end;
end;

procedure TPOSScreenForm.grdTransDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  pLine : pLineItemRec;
begin
  inherited;
//
  if ACol = 0 then
    exit;
  pLine := ItemForGridIndex(ARow);
  if not Assigned(pLine) then
    exit;
  if not pLine.Selected then
    exit;
  grdTrans.Canvas.Brush.Color := clAqua;
  grdTrans.Canvas.FillRect(Rect);
  grdTrans.Canvas.TextOut(Rect.Left+2, Rect.Top+2, grdTrans.Cells[ACol, ARow]);

end;

procedure TPOSScreenForm.grdTransMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  lCol, lRow : integer;
  pLine : pLineItemRec;
begin
  inherited;
  grdTrans.MouseToCell(X,Y, LCol, lRow);
  pLine := ItemForGridIndex(lRow);
  if not assigned(pLine) then
    exit;
  if (Shift * [ssCtrl]) <> [] then
    pLine.Selected := not pLine.Selected
  else
    pLine.Selected := false;
  grdTrans.Invalidate;

end;

procedure TPOSScreenForm.initProductQtyBinETA(Sender: TObject);
begin
  with TfrmProductQtyBinETA(Sender) do begin
    KeyID := TempProductID;
    ClassID := TempClassID;
  end;
end;
procedure TPOSScreenForm.btnNumDblClick(Sender: TObject);
var
  btn: TDNMSpeedButton;
begin
  inherited;
  if Sender is TDNMSpeedButton then begin
    btn := TDNMSpeedButton(Sender);
    if btn = btnNumBS then begin
      POSKeyDown(word(VK_BACK), [ssMiddle]); // used ssMiddle cuz there is no ssNone ???
    end else if btn = btnNumDot then begin
      POSKeyDown(word(VK_DECIMAL), [ssMiddle]);
    end else if btn = btnNum1 then begin
      POSKeyDown(word('1'), [ssMiddle]);
    end else if btn = btnNum2 then begin
      POSKeyDown(word('2'), [ssMiddle]);
    end else if btn = btnNum3 then begin
      POSKeyDown(word('3'), [ssMiddle]);
    end else if btn = btnNum4 then begin
      POSKeyDown(word('4'), [ssMiddle]);
    end else if btn = btnNum5 then begin
      POSKeyDown(word('5'), [ssMiddle]);
    end else if btn = btnNum6 then begin
      POSKeyDown(word('6'), [ssMiddle]);
    end else if btn = btnNum7 then begin
      POSKeyDown(word('7'), [ssMiddle]);
    end else if btn = btnNum8 then begin
      POSKeyDown(word('8'), [ssMiddle]);
    end else if btn = btnNum9 then begin
      POSKeyDown(word('9'), [ssMiddle]);
    end else if btn = btnNum0 then begin
      POSKeyDown(word('0'), [ssMiddle]);
    end;
  end;
end;

procedure TPOSScreenForm.PrepayAccountFn;
var
  dValue: currency;
begin
  if idOk() then begin
    if EnteringNum then begin
      if not GetFloatValue(dValue) then begin
        Exit;
      end;
    end;
    if not IsValidCustomer(iClientID) then begin
      iCustOriginator := FN_PREPAY_ACCOUNT; // used in edtClientIDChange to identify
      ShowCustList; // get the client
      { The processing of this transaction is completed in the edtClientIDChange as
        this OnChange event marks the return from the customer list.
        edtClientIDChange will recognize that it needs to initiate
        'FinishPayAccount'  from the value of iCustOriginator }
    end else begin
      // We know client so continue with process
      FinishPrepayAccount;
      iTabsClientID := iClientID;// Ian Trying To Track Orginal Bar Tab Owner
    end;
  end;
end;

procedure TPOSScreenForm.FinishPrepayAccount;
var
  frm: TfmCustPrepayments;
  ParentRelatedClientID: Integer;
begin
  // create the Customer Payment form and set some initail values in that form
  frm := TfmCustPrepayments(GetComponentByClassName('TfmCustPrepayments'));
  If not Assigned(frm) then Exit;
  frm.POSInitiated := true;
  ParentRelatedClientID := GetParentRelatedClientID(iClientID);

  if ParentRelatedClientID <> 0 then
    frm.POSClientID := ParentRelatedClientID
  else
    frm.POSClientID := iClientID;

  if EnteringNum then begin
    frm.POSAmount := StrValue(edtPOSMemo.Lines[0]);
  end;

  frm.ShowModal;

  if frm.POSPrepaymentMade then begin
    // create a sale line part of payment part
    FilterPartsByName(PART_MEMO);
    CreateMemoPartLine('Account Prepayment(ID: ' + IntToStr(frm.POSPrepaymentID) + '): ' +
      FloatToStrF(frm.POSAmount, ffCurrency, 15, CurrencyRoundPlaces),
      frm.POSAmount);
    pLineItemRec(lstLineItems.Last)^.IsAccountPayment := true;
    pLineItemRec(lstLineItems.Last)^.AcntPayMethodID  := frm.POSPayMethodID;
    pLineItemRec(lstLineItems.Last)^.AcntPaymentID    := frm.POSPrepaymentID;
    pLineItemRec(lstLineItems.Last)^.IsFrozen         := true;
    DisplayLineItem(lstLineItems.Last);
  end;
end;

procedure TPOSScreenForm.FinishQuote;
begin
  if (char_length(sClient) = 0) or (sClient = CLIENT_CASH) then begin
    CommonLib.MessageDlgXP_Vista('You must provide a customer name for Quote', mtWarning, [mbOK], 0);
    IsPOSQuote := false;
    Exit;
  end;

  try
    CalcAndPostCustDisc;

    IsPosQuote := true;
    sPayType := PAY_NONE;
    if not PostToDB then
      exit;
    if SavePOS then begin
      CleanUp;
      DisplayInViewer('Quote  ' + CurrToStrRJ(rRunTot, 13));
    end else
      IsPOSQuote := False;
  finally
    bOnhold:=False;
  end;
end;

procedure TPOSScreenForm.SetPOSScreenActive;
begin
  fbNoActivate := true;
  try
    if (pnlPOSBtns.Visible and pnlPOSBtns.Enabled) then begin
      SetControlFocus(self);
      SetControlFocus(self.pnlPOSBtns);
    end;
  finally
    fbNoActivate := false;
  end;
end;

procedure TPOSScreenForm.SetPosVideoDelay(const Value: integer);
begin
  if (Value <= 0) or (Value > 120) then
    fPosVideoDelay := 120
  else
    fPosVideoDelay := Value;
end;

function TPOSScreenForm.IsAnyAccoutPayments: boolean;
var
  pItem: pLineItemRec;
  i: integer;
begin
  Result := false;
  for i := 0 to lstLineItems.Count - 1 do begin
    pItem := lstLineItems[i];
    if pItem^.IsAccountPayment then begin
      Result := true;
      Break;
    end;
  end;
end;
Procedure TPOSScreenForm.UpdateAppt;
var
  qry: TERPCommand;
begin
if iAppointID<> 0 then begin
  qry := TERPCommand.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    {update the appointment as converted when the POS is saved}
    qry.SQL.clear;
    Qry.SQL.add('update tblAppointments Set converted = ''T'' where appointid  = :xappointid ');
    qry.Params.ParamByName('xappointid').asInteger := iAppointID;
    qry.Execute;

    {deduct the free hrs from the client }
    if AppointmentFreeHours> 0 then begin
        qry.SQL.clear;
        qry.SQL.Add('UPDATE tblClients SET Hours = Hours - :xhours ' +
                'WHERE ClientID = :xClientID;');
        qry.Params.ParamByName('xClientID').asInteger := iClientID;
        qry.Params.ParamByName('xhours').AsFloat  := AppointmentFreeHours;
        qry.Execute;
    end;

  finally
    FreeAndNil(qry);
  end;


    end;
end;

procedure TPOSScreenForm.DeleteTempTable;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('DROP TABLE IF EXISTS ' + GetUserTempName + ' ');
    qryTemp.Execute;
    fsUserTempName := '';
  finally
    if Assigned(qryTemp) then FreeAndNil(qryTemp);
  end;
end;

function TPOSScreenForm.GetUserTempName: string;
begin
  if fsUserTempName = '' then
    fsUserTempName :=  commondbLib.GetUserTemporaryTableName('tmp_POS');// 'tmp_Pos_' + GetMachineIdentification(true, true, true, true);
  Result := fsUserTempName;
end;

procedure TPOSScreenForm.CreateTempTable;
var
  qryTemp: TERPCommand;
begin
  qryTemp := DbSharedObj.Getcommand(commondblib.GetSharedMyDacConnection);
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('DROP TABLE IF EXISTS ' + GetUserTempName + '; ');
    qryTemp.Sql.Add('CREATE TABLE IF NOT EXISTS ' + GetUserTempName + ' ( ');
    qryTemp.Sql.Add('`ID` int(11) NOT NULL auto_increment,');
    qryTemp.SQL.Add('`SaleDate` datetime default NULL,');
    qryTemp.Sql.Add('`TimeOfSale` varchar(32) default NULL,');
    qryTemp.Sql.Add('`SaleID` int(11) default "0",');
    qryTemp.Sql.Add('`SaleID_1` int(11) default "0",');
    qryTemp.Sql.Add('`TillID` int(11) default "0",');
    qryTemp.Sql.Add('`IsLayby` varchar(8) default NULL,');
    qryTemp.Sql.Add('`POS` varchar(8) default NULL,');
    qryTemp.SQL.Add('`SaleDateTime` datetime default NULL,'); //extra field to sort on
    qryTemp.Sql.Add('PRIMARY KEY  (`ID`),');
    qryTemp.Sql.Add('KEY `ID` (`ID`)');
    qryTemp.Sql.Add(') ENGINE=InnoDB;');
    qryTemp.Execute;

  finally
    DbSharedObj.ReleaseObj(qryTemp);
  end;
end;

Function TPOSScreenForm.SavePeriodDetails:Integer;
var
  qry,qrySales :TERPQuery;
  qryTemp: TERPCommand;
  InsertSQL:String;
begin
  result := 0;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  qrySales := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  qryTemp := DbSharedObj.Getcommand(commondblib.GetSharedMyDacConnection);

  try
    qry.SQL.text := 'SELECT * FROM tblposeop';
    qry.Open;

    //create temp table with extra TimeOfSale field that is DateTime so we can fix sort bug
    CreateTempTable;

    //load temp table
    InsertSQL := 'INSERT HIGH_PRIORITY INTO ' + GetUserTempName +
     '(SaleDate,TimeOfSale,SaleID,SaleID_1,TillID , SaleDateTime)';

    with qryTemp do begin
      Sql.Clear;
      Sql.Add(InsertSQL);

      Sql.Add(' SELECT  SaleDate, TimeOfSale,SL.SaleID,S.SaleID,TillID , SaleDateTime ');
      Sql.Add('FROM tblSalesLines SL INNER JOIN tblSales S ON SL.SaleID = S.SaleID');
      Sql.Add('WHERE IsLayby = "F" and POS = "T" AND TillID = ');
      Sql.Add(IntToStr(iTillID)+';');
      Sql.Add(InsertSQL);

      Sql.Add(' SELECT  SaleDate, TimeOfSale,SL.SaleID,S.SaleID,TillID , SaleDateTime ');
      Sql.Add('FROM tblSalesLines_POS SL INNER JOIN tblSales_POS S ON SL.SaleID = S.SaleID');
      Sql.Add('WHERE IsLayby = "F" and POS = "T" AND TillID = ');
      Sql.Add(IntToStr(iTillID)+';');


      Execute;

    end;

    qrySales.SQL.Clear;
    qrySales.SQL.Add('SELECT  SaleDate, TimeOfSale,SaleID,TillID, SaleDateTime');
    qrySales.SQL.Add('FROM ');
    qrySales.SQL.Add(GetUserTempName);
    qrySales.SQL.Add(' ORDER By SaleDateTime , SaleDate, STR_TO_DATE(timeofsale,"%h:%i:%s %p")');

    qrySales.Open;

    if qrySales.RecordCount > 0 then begin
      qrySales.First;     //we need to get the first sale to establish the Start of Period

      qry.Insert;
      qry.FieldByName('StartDate').AsDateTime := qrySales.FieldByName('SaleDateTime').AsDateTime;

      qrySales.Last;

      qry.FieldByName('EndDate').AsDateTime :=  qrySales.FieldByName('SaleDateTime').AsDateTime;

      qry.FieldByName('TillID').AsInteger := iTillID;
      qry.FieldByName('msUpdateSiteCode').AsString :=  AppEnv.Branch.SiteCode;
      qry.Post;
      qry.Edit;
      qry.FieldByName('GlobalRef').AsString :=  AppEnv.Branch.SiteCode + qry.FieldByName('PeriodID').AsString;
      qry.Post;
      TCashDrop.OnEOP(Self,qry.fieldbyname('PeriodID').AsInteger ,  iTillID);
      Result :=qry.fieldbyname('PeriodID').AsInteger ;

      DeleteTempTable;
    end;
  finally
    DbSharedObj.ReleaseObj(qryTemp);
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qrySales);
  end;
end;


procedure TPOSScreenForm.MatchPrevQtyFn;
Var pItem: pLineItemRec;
begin
  //find out qty of previous line
  if lstLineItems.Count < 2 then exit;
  pItem := lstLineItems[lstLineItems.Count-2];
  edtPOSMemo.Text := FloatToStr(pItem.Qty);
  EnteringNum(True);
  // set the qty
  QuantityFn;
end;

function TPOSScreenForm.MaxDiscountPercentageExceeded(DiscountAmount: double = 0): boolean;
var
  x: integer;
  amtTotal, amtDiscount: double;
begin
  result:= false;
  amtTotal:= 0;
  amtDiscount:= 0;
  if Assigned(lstLineItems) then begin
    for x:= 0 to lstLineItems.Count -1 do begin
      if pLineItemRec(lstLineItems[x])^.IsDiscount then
        amtDiscount:= amtDiscount + Abs(pLineItemRec(lstLineItems[x])^.Amount)
      else
        amtTotal:= amtTotal + pLineItemRec(lstLineItems[x])^.Amount;
    end;
    amtDiscount:= amtDiscount + DiscountAmount;
    if AppEnv.CompanyPrefs.MaxDiscountPercentage <= AppEnv.Employee.EmployeemaxDiscountPercentage then begin
      if (amtTotal > 0) and (amtDiscount > 0) and (AppEnv.CompanyPrefs.MaxDiscountPercentage > 0) and
         ((amtDiscount / amtTotal) > AppEnv.CompanyPrefs.MaxDiscountPercentage) then
        result:= true;
    end
    else begin
      if (amtTotal > 0) and (amtDiscount > 0) and (AppEnv.Employee.EmployeemaxDiscountPercentage > 0) and
         ((amtDiscount / amtTotal) > AppEnv.Employee.EmployeemaxDiscountPercentage) then
        result:= true;
    end;
  end;
end;

Function TPOSScreenForm.ItemForGridIndex(const Gridindex :Integer ): pLineItemRec;
var
  x:Integer;
begin
  Result:= nil;
    for x:= 0 to lstLineItems.Count -1 do begin
      if pLineItemRec(lstLineItems[x])^.Gridindex=Gridindex then begin
        REsult :=lstLineItems[x];
        Exit;
      end;
    end;
end;

procedure TPOSScreenForm.grdTransClickCell(Sender: TObject; ARow,  ACol: Integer);
  { deletes the line}
var
  pItem: pLineItemRec;
begin
  If (ACol <> 0) then begin
    ShowDetails;
    Exit;
  end;

  if (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAllowDeleteinPOS' , AppEnv.Employee.employeeID) <>1) then begin
    CommonLib.MessageDlgXP_Vista('You don''t have access to Delete Entries in POS Transaction.' , mtWarning, [mbok] , 0);
    exit;
  end;
  if not bTransComplete then begin
    // allow user to reverse any Serial number tracking
    If (lstLineItems.Count=0) OR (lstLineItems.Count < ARow) or (ARow = 0) then Exit;
    pItem := ItemForGridIndex(ARow );//   lstLineItems[ARow - 1];
    if pitem = nil then exit;
    if pItem^.IsChild then begin
      if not pItem^.CanDeleteRelated then begin
        CommonLib.MessageDlgXP_Vista('You don''t have an option to delete this related Product', mtWarning, [mbOK], 0);
        exit;
      end;
    end
    else begin
      { not a child }
      if not pItem^.CanDeleteInPOS then begin
        CommonLib.MessageDlgXP_Vista('You don''t have an option to delete this Product', mtWarning, [mbOK], 0);
        exit;
      end;
    end;
    if pItem^.IsAccountPayment then begin
      CommonLib.MessageDlgXP_Vista('You Cannot Delete this Customer Acount Payment!', mtWarning, [mbOK], 0);
      Exit;
    end;
    RemoveLine(ARow);
    GlobalEvents.Notify(self, GEVENT_POS_AfterSaleListLineDelete, lstLineItems);
    GlobalEvents.Notify(self, GEVENT_POS_CheckForListRedisplay, lstLineItems);
    ReCalcRunTot;
    DisplayRunTot(rRunTot);
    RebuildGrid;
  end;

  if Assigned(CustomerDisplay) then begin
    RefreshCustomerDisplay;
    SetPOSScreenActive;
  end;
end;

procedure TPOSScreenForm.POSCommandHandler(const Sender: TObject;
  const Event: string; const Data: Pointer);
begin
  if Sysutils.SameText(Event, GEVENT_POS_DoRebuildGrid) then begin
    RebuildGrid;
  end;
end;

procedure TPOSScreenForm.Createtransrec(const Matrixform :Tcomponent);
begin
  edtPartID.text :='';
  if not(Assigned(Matrixform)) then exit;
  if not(Matrixform is TfmProdAttribmatrix) then Exit;
  With TfmProdAttribmatrix(MatrixForm) do begin
    if qryToBeCreated.recordcount = 0 then exit;
    qryToBeCreated.first;
    ProgressBar.Max := qryToBeCreated.RecordCount;
    ProgressBar.Min := 1;
    ProgressBar.visible := True;
    try
      while qryToBeCreated.Eof = false do begin
        if qryToBeCreated.fieldByname('ProductID').asInteger <> 0 then begin
          rQuantOfProd :=qryToBeCreated.fieldByname('Qty').asFloat;
          iProdOriginator := FN_ATTRIBUTEPROD;
          edtPartID.text := ''; { to make sure onChange event fires }
          edtPartID.text :=qryToBeCreated.fieldByname('ProductID').asString;
        end;
        qryToBeCreated.next;
        ProgressBar.StepIt;
      end;
    finally
        ProgressBar.visible := false;
    end;
  end;
  rQuantOfProd := 1;
end;


procedure TPOSScreenForm.ProductList1Click(Sender: TObject);
var
  tmpComponent:TComponent;
begin
  inherited;
  if not FormStillOpen('TProductListGUI') then begin
    tmpComponent := GetComponentByClassName('TProductListGUI');
    If not Assigned(tmpComponent) then Exit;
    with TForm(tmpComponent) do begin
      FormStyle := fsmdiChild;
      BringToFront;
    end;
  end else begin
    with TForm(FindExistingComponent('TProductListGUI')) do begin
      Show;
      BringToFront;
    end;
  end;
end;


procedure TPOSScreenForm.setiTillID(const Value: Integer);
begin
  xiTillID := Value;
  GetCompanyInfo;
end;

function TPOSScreenForm.PosObj: TPOS;
begin
  if Assigned(POSGroupObj) then
    result:= POSGroupObj.POSObj
  else
    result:= nil;
end;

procedure TPOSScreenForm.AcceptExtraDetails;
var
  form :Tcomponent;
begin
  form:= GetComponentByClassName('TfmPOSExtraDetails' , True , self , False);
  if form = nil then exit;
  with TfmPOSExtraDetails(form) do try
    PosObj := self.PosObj;
    ExtraDetailItem := fExtraDetailItem;
    Showmodal;
    sPOSPCode  :=PosObj.POSPostCode;
    sCustPONumber := POSObj.CustPONumber;
    sMedtype   :=PosObj.Medtype;
    iMedTypeID :=PosObj.MedtypeId;
  finally
    Free;
  end;

end;


Function  TPOSScreenForm.MemoInput(const memoCaption: String; var sResult: String; Required: boolean = false):Boolean;
begin
    Result := False;
    with TPOSChequePopUp.Create(Self) do try
        TitleLabel.Caption    := memoCaption;
//        edtInput1.Font.Size := 12;
        OKBtn.Default         := false;
        if Required then
          CancelBtn.Enabled:= false;
        if ShowModal = mrOk then begin
          sResult := edtInput1.Text;
          result := true;
        end;
    finally
        Free;
    end;
end;

function TPOSScreenForm.RedeemPoints: Boolean;
begin
  result := True;
  if rRunTot = 0 then begin
      exit;
  end;
    if not IsValidCustomer(iClientID) then begin
      iCustOriginator := FN_REDEEMPOINTS; // used in edtClientIDChange to identify
      ShowCustList; // get the client
    end else begin
      showRedeemPoints;
    end;
end;

procedure TPOSScreenForm.showRedeemPoints;
begin
  if iClientID= 0 then exit;

  if sClient = CLIENT_CASH then
  else  begin
    TRewardPointsDetailsGUI.GetPoints(iclientID, OnrewardPointSelect, date,nil);
  end;
end;


procedure TPOSScreenForm.OnrewardPointSelect(Sender: TObject);
var
  Qrymain:TDataset;
  i:Integer;
  grdmain :TwwDbgrid;
  totalamountinc:Double;
  pRedeemPointsRec: pRedeemPoints;
  MaxPointsToRedeem:Double;
  PointsRedeemed:double;
  PointsToredeem:Double;


  Procedure SelectsaleLinePoints;
  var
    i: integer;
  begin
    for i := 0 to lstRedeemPoints.Count - 1 do begin
      pRedeemPointsRec := lstRedeemPoints[i];
      if pRedeemPointsRec^.SalesLinesPointsId =Qrymain.fieldbyname('SalesLinesPointsId').asInteger  then begin
        exit;
      end;
    end;
     New(pRedeemPointsRec);
     pRedeemPointsRec^.ValueforRewardPoints  := Qrymain.fieldbyname('ValueforRewardPoint').asFloat;
     pRedeemPointsRec^.SalesLinesPointsId    := Qrymain.fieldbyname('SalesLinesPointsId').asInteger ;
     pRedeemPointsRec^.PointsfromSaleId      :=Qrymain.fieldbyname('SaleID').asInteger;
     pRedeemPointsRec^.PointsFromSalelineId  :=Qrymain.fieldbyname('SaleLineID').asInteger;
     pRedeemPointsRec^.ProductId             :=Qrymain.fieldbyname('ProductId').asInteger;
     pRedeemPointsRec^.ProductName           :=Qrymain.fieldbyname('ProductName').asString;
     pRedeemPointsRec^.UsedPoints            :=0;
     lstRedeemPoints.Add(pRedeemPointsRec);
  end;
begin

  if not(Sender is twwDBgrid) then exit;
  grdMain :=TwwDBGrid(Sender);
  Qrymain := grdmain.Datasource.dataset;
  if not assigned(Qrymain) then exit;

  MaxPointsToRedeem:= 0;
  for i := 0 to grdMain.SelectedList.Count - 1 do begin
      qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
      MaxPointsToRedeem:= MaxPointsToRedeem + qryMain.fieldbyname('AvailablePoints').asFloat;
  end;
  if MaxPointsToRedeem  =0 then exit;

  if trunc(MaxPointsToRedeem / appenv.CompanyPrefs.MultiplesofPointstoRedeem) = 0 then begin
    MessageDlgXP_Vista('Preference is Set to Redeem Multiples of '+inttostr(appenv.CompanyPrefs.MultiplesofPointstoRedeem) +' Points.'+chr(13) +chr(13) +
                        'Total Selected points (' + FloatToStr(MaxPointsToRedeem)+') is not Enough to Redeem.', mtwarning, [mbok] , 0);
    exit;
  end;
  MaxPointsToRedeem := trunc(MaxPointsToRedeem / appenv.CompanyPrefs.MultiplesofPointstoRedeem) * appenv.CompanyPrefs.MultiplesofPointstoRedeem;

  totalamountinc := rRunTot;
  PointsRedeemed:= 0;
  try
    for i := 0 to grdMain.SelectedList.Count - 1 do begin

        qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
        PointsToredeem :=qryMain.fieldbyname('AvailablePoints').asFloat;
        if PointsToredeem >  MaxPointsToRedeem -PointsRedeemed then PointsToredeem := MaxPointsToRedeem -PointsRedeemed;

        if (PointsToredeem * qryMain.fieldbyname('ValueforRewardPoint').asFloat <0) or
          (TotalAmountinc>0) then begin
          SelectSaleLinePoints;
          if TotalamountInc >= PointsToredeem * qryMain.fieldbyname('ValueforRewardPoint').asFloat then begin
            pRedeemPointsRec^.ValueforRewardPoint  := qryMain.fieldbyname('ValueforRewardPoint').asFloat;
            pRedeemPointsRec^.Redeemamount := PointsToredeem * qryMain.fieldbyname('ValueforRewardPoint').asFloat ;
            pRedeemPointsRec^.UsedPoints :=PointsToredeem ;
          end else begin
            pRedeemPointsRec^.ValueforRewardPoint  := qryMain.fieldbyname('ValueforRewardPoint').asFloat;
            pRedeemPointsRec^.Redeemamount := TotalamountInc;
            pRedeemPointsRec^.UsedPoints :=Round(TotalamountInc/pRedeemPointsRec^.ValueforRewardPoint ,CurrencyRoundPlaces) ;
          end;
          PointsRedeemed := PointsRedeemed +pRedeemPointsRec^.UsedPoints;
          totalAmountInc := totalAmountInc - pRedeemPointsRec^.UsedPoints*pRedeemPointsRec^.ValueforRewardPoints;
          if totalAmountInc=0 then break;
        end;
    end;
  finally
    rRunTot:= totalamountinc;
    SearchnRefreshRedeemPoints;
    DisplayRunTot(rRunTot);
    if rRunTot <> 0 then begin
      MessageDlgXP_Vista('Redeemed points are not Enough for This Sale.'+chr(13) +chr(13) +lblCustomer.caption +' Will have to Pay ' + FloatToStrF(rRunTot, ffCurrency, 15, CurrencyRoundPlaces)+' More!' , mtInformation, [mbok],0);
    end;
  end;
end;

procedure TPOSScreenForm.totalPointsCallback(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not (Sender is TSalesRedeemPoints) then exit;

  totalRedeemedPoints := totalRedeemedPoints + TSalesRedeemPoints(Sender).UsedPoints;
  totalRedeemedAmount := totalRedeemedAmount + TSalesRedeemPoints(Sender).RedeemAmount;
  RedeemedPointsDesc := RedeemedPointsDesc+chr(13) +
      '    ' +FloatToStr(TSalesRedeemPoints(Sender).UsedPoints) + ' Points Redeemed From Sale#' +IntToStr(TSalesRedeemPoints(Sender).PointsfromSaleId)+
      '  For Product:' + TSalesRedeemPoints(Sender).ProductName;

end;

procedure TPOSScreenForm.SearchnRefreshRedeemPoints;
var
  i:Integer;
  fLineItem: pLineItemRec;
  ARow:Integer;
  qryLines :TERPQuery;
  pRedeemPointsRec: pRedeemPoints;
begin
  fLineItem:= nil;
  totalRedeemedPoints :=0;
  totalRedeemedAmount :=0;
  RedeemedPointsDesc := 'Points Details';
  for i := 0 to lstRedeemPoints.Count - 1 do begin
      pRedeemPointsRec := lstRedeemPoints[i];
      totalRedeemedPoints := totalRedeemedPoints + pRedeemPointsRec^.UsedPoints;
      totalRedeemedAmount := totalRedeemedAmount +pRedeemPointsRec^.RedeemAmount;
      RedeemedPointsDesc := RedeemedPointsDesc + chr(13) +
      '    ' +FloatToStr(pRedeemPointsRec^.UsedPoints) + ' Points Redeemed From Sale#' +IntToStr(pRedeemPointsRec^.PointsfromsAleId)+
      '  For Product:' + pRedeemPointsRec^.ProductName;
  end;

  ARow:=-1;
  for i := 0 to self.lstLineItems.Count - 1 do begin
    fLineItem := lstLineItems[i];
    if Sysutils.SameText( fLineItem^.ProductName , REDEEM_POINTS) then begin
      ARow := fLineItem^.Gridindex;
      break;
    end;
  end;
  if totalRedeemedAmount <> 0 then begin
    if (ARow = -1)  then begin
      qryLines := TProduct.Productquery(REDEEM_POINTS);
      Try
        NewLineItem;
        fLineItem:= LineItem;
        with fLineItem^ do begin
          ProductID           := qryLines.FieldByName('PartsId').AsInteger;
          Qty                 := 1;
          ProductName         := qryLines.FieldByName('PartName').AsString;
          PartType            := qryLines.FieldByName('PARTTYPE').AsString;
          Multiplier          := 1;
          IncomeAccnt         := qryLines.FieldByName('IncomeAccnt').AsString;
          AssetAccnt          := qryLines.FieldByName('AssetAccnt').AsString;
          CogsAccnt           := qryLines.FieldByName('CogsAccnt').AsString;
          ProductGroup        := qryLines.FieldByName('ProductGroup').AsString;;
          TaxCode             := qryLines.FieldByName('TAXCODE').AsString;
          TaxRate             := qryLines.FieldByName('TaxRate').AsFloat;
          IsAccountPayment    := False;
          IsDiscount          := False;
          LineCost            := 0;
          LineCostInc         := 0;
          lstLineItems.Add(fLineItem);
        end;
      finally
          if qryLines.active then qryLines.close;
          freeandNil(qryLines);
      end;
    end;
    fLineItem^.ProductDescription  := RedeemedPointsDesc;
    fLineItem^.Amount              := 0-totalRedeemedAmount;
    fLineItem^.LinePrice           := totalRedeemedAmount;
    fLineItem^.LinePriceInc        := totalRedeemedAmount;
    fLineItem^.Ischild             := False;
    fLineItem^.IsrelatedHidden     := False;
    RebuildGrid;
  end else begin
    if ARow <> -1 then begin
      grdTransClickCell(grdTrans ,ARow, 0);
    end;
  end;
end;

procedure TPOSScreenForm.PercentDiscItemFnFixed;
begin
  if idOk() and IsAccessAllowed('FnPcentDiscItm') then
    ApplyPercentDiscountOnItem(ValuefromLine1(oPOSBtnMatrix.Selected));
end;

procedure TPOSScreenForm.PercentDiscTotalFnFixed;
begin
 if idOk() and IsAccessAllowed('FnPcentDiscTot') then
    ApplyPercentDiscountonTotal(ValuefromLine1(oPOSBtnMatrix.Selected));
end;

procedure TPOSScreenForm.PercentSurchargeItemFnFixed;
begin
  if idOk() and IsAccessAllowed('FnPcentSurchItm') then
     ApplySurchargeOnItem(ValuefromLine1(oPOSBtnMatrix.Selected));
end;

procedure TPOSScreenForm.PercentSurchargeTotalFnFixed;
begin
  if idOk() and IsAccessAllowed('FnPcentSurchTot') then
    ApplySurchargeonTotal(ValuefromLine1(oPOSBtnMatrix.Selected));
end;

procedure TPOSScreenForm.ApplyPercentDiscountOnItem(rDiscount: Double);
var
  pItem: pLineItemRec;
  rAmount:Double;
  s:String;
  ddisc:Double;
  CurRow: PLineItemRec;
begin
      if lstLineItems.Count = 0 then begin
        CommonLib.MessageDlgXP_Vista('Nothing to apply discount to', mtWarning, [mbOK], 0);
        edtPOSMemo.lines.clear;
        exit;
      end;
      CurRow := CurrentRow;
      if not Assigned(CurRow) then
        exit;
      pItem := CurrentRow;
      if not Assigned(pItem) then exit;
      rAmount := pItem^.Amount;
      if rAmount <= 0 then begin
        CommonLib.MessageDlgXP_Vista('Sale Item Amount is 0, not Possible to Apply Discount ', mtWarning, [mbOK], 0);
        edtPOSMemo.lines.clear;
        Exit;
      end;
      ddisc:=rDiscount;
      rDiscount := RoundTo1C(rAmount * rDiscount) / 100;
      if MaxDiscountPercentageExceeded(rDiscount)  {rDiscount > AppEnv.CompanyPrefs.MaxDiscountPercentage * 100} then begin
        CommonLib.MessageDlgXP_Vista(sDiscTooBig, mtWarning, [mbOK], 0);
      end else begin
        s := FloatToStrF(ddisc,ffGeneral, 15, 2) + '% Discount on '+pItem^.ProductDescription;
        LineEntry(s , rDiscount  , PART_PCENT_DISC, true);
      end;
end;

procedure TPOSScreenForm.ApplyPercentDiscountonTotal(rDiscount: Double);
var
  s:STring;
begin
      if rRunTot = 0 then begin
        CommonLib.MessageDlgXP_Vista('Total Sale Amount is 0. Please Add Products Before Adding Discount.' , mtWarning, [mbOK], 0);
        edtPOSMemo.lines.clear;
        exit;
      end;
      if (AppEnv.CompanyPrefs.MaxDiscountPercentage <= AppEnv.Employee.EmployeemaxDiscountPercentage) and (rDiscount > AppEnv.CompanyPrefs.MaxDiscountPercentage * 100) then
        CommonLib.MessageDlgXP_Vista(sDiscTooBig, mtWarning, [mbOK], 0)
      else if (AppEnv.CompanyPrefs.MaxDiscountPercentage > AppEnv.Employee.EmployeemaxDiscountPercentage) and (rDiscount > AppEnv.Employee.EmployeemaxDiscountPercentage * 100) then
        CommonLib.MessageDlgXP_Vista(sDiscTooBig, mtWarning, [mbOK], 0)
      else begin
        // Calculate discount of total
        s := FloatToStrF(rDiscount,ffGeneral, 15, 2) + '% Discount on Total Sale';
        rDiscount := RoundTo1C(rRunTot * rDiscount / 100);
        if MaxDiscountPercentageExceeded(rDiscount) then  begin
          CommonLib.MessageDlgXP_Vista(sDiscTooBig, mtWarning, [mbOK], 0);
          exit;
        end;
        LineEntry(s , rDiscount  , PART_PCENT_DISC, true);
      end;
end;

procedure TPOSScreenForm.ApplySurchargeOnItem(rSurcharge: Double);
var
    rAmount :Double;
    pItem: pLineItemRec;
    s:String;
begin
    if lstLineItems.Count = 0 then begin
        CommonLib.MessageDlgXP_Vista('Nothing to apply discount to', mtWarning, [mbOK], 0);
    end else begin
// Calculate surcharge of last item posted
      pItem := CurrentRow;
      if not Assigned(pItem) then exit;
      rAmount := pItem^.Amount;
      s := FloatToStrF(rSurcharge,ffGeneral, 15, 2) + '% Surcharge on '+pItem^.ProductName;
      rSurcharge := RoundTo1C(rAmount * rSurcharge) / 100;

      // Now post surcharge

      LineEntry(s, rSurcharge  , PART_PCENT_SURCH, False);
  end;
end;

procedure TPOSScreenForm.ApplySurchargeonTotal(rSurcharge: Double);
var
  s:String;
begin
// Calculate surcharge of total
      s := FloatToStrF(rSurcharge,ffGeneral, 15, 2) + '% Surcharge on Total Sale';
      rSurcharge := RoundTo1C(rRunTot * rSurcharge / 100);
      LineEntry(s, rSurcharge  , PART_PCENT_SURCH, False);
end;

procedure TPOSScreenForm.AppMessage(var Msg: TMsg; var Handled: Boolean);
begin

 // Check for keyboard messages
  if ((Msg.message >= WM_KEYFIRST) and (Msg.message <= WM_KEYLAST)) OR
  // Check for non-client mouse messages
     ((Msg.message >= WM_NCLBUTTONDOWN) and (Msg.message <= WM_NCMBUTTONDBLCLK)) or
  // Check for mouse messages
     ((Msg.message >= WM_LBUTTONDOWN) and (Msg.message <= WM_MOUSELAST)) or
  // Check for activation messages
    (Msg.message in [WM_ACTIVATE, WM_SETFOCUS, WM_ACTIVATEAPP]) then
    begin
       // Update last activity
       StartTime := Time; //GetTickCount;
       // Stop player if running
       if pnlMediaHost.Visible then
         StopPlayer;
    end;

  // We do not directly handle the message
  Handled:=False;

end;

procedure TPOSScreenForm.EnteringNum(const Value: Boolean);
begin
  if OPOSScanning then exit;

  if fbEnteringNum <> Value then
    fbEnteringNum:= Value;
end;

function TPOSScreenForm.EnteringNum: Boolean;
begin
    result := fbEnteringNum;
end;


function TPOSScreenForm.ProductPrice: Double;
begin
  result := Product.SellQty1Price;
end;

function TPOSScreenForm.ValueFromLine1(PosBtn:TPosBtn): double;
var
  s: string;
  sNew: string;
  dValue:Double;
begin
  s := PosBtn.Line1.Caption;
  dValue :=StrValue(s);
  sNew := FloattoStr(dValue);
  DisplayInViewer(sNew);
  result := dValue;
end;

procedure TPOSScreenForm.DollarDiscFnFixed;
begin
  if (idOk()) and (IsAccessAllowed('FnDolDisc')) then
     Applydiscount(ValuefromLine1(oPOSBtnMatrix.Selected));
end;

procedure TPOSScreenForm.DollarSurchargeFnFixed;
begin
  if (idOk()) and (IsAccessAllowed('FnDolSurch')) then
    ApplySurcharge(ValuefromLine1(oPOSBtnMatrix.Selected));
end;

procedure TPOSScreenForm.AppIdle(Sender: TObject; var Done: Boolean);
begin
  try
    StopTime := time;
    if not pnlMediaHost.Visible then
    begin
      if (SecondsBetween(StopTime, StartTime) < PosVideoDelay) then
        exit;  // not a time yet
      if (VideoFiles.Count = 0) or         // no files to show
         (not (bTransComplete)) then //or               // txn not completed
//         (lstLineItems.Count > 0) then   // sale already started
        exit;   // no files to show
      pnlMediaHost.Align := alClient;
      // somehow first time size is not set, so let's do it manually
      if pnlMediaHost.ClientRect.Right <> pnlMediaHost.Parent.ClientRect.Right then
      begin
        pnlMediaHost.Left := pnlMediaHost.Parent.ClientRect.Left;
        pnlMediaHost.Top := pnlMediaHost.Parent.ClientRect.Top;
        pnlMediaHost.Width := pnlMediaHost.Parent.ClientRect.Right - pnlMediaHost.Parent.ClientRect.Left;
        pnlMediaHost.Height := pnlMediaHost.Parent.ClientRect.Bottom  - pnlMediaHost.Parent.ClientRect.Top;
      end;
      Player.Visible := false;
      Player.Notify := true;
      PlayFile;
      pnlMediaHost.Visible := true;
    end;
  finally
    // independent on whether main screen is playing or not
    if (SecondsBetween(StopTime, StartTime) >= PosVideoDelay) and
       (assigned(CustomerDisplay)) and
       (CustomerDisplay.PositionInitialised) and
       not (CustomerDisplay.pnlMediaHost.Visible) and
       (CustomerDisplay.VideoCount > 0) and
//        (lstLineItems.Count = 0) then
       (bTransComplete) then
       begin
          CustomerDisplay.PlayVideo;
       end;
    Done := true;
  end;

end;

procedure TPOSScreenForm.Applydiscount(rDiscount: Double);
begin
      if (rDiscount + GetTotalDiscountAmount) > rRunTot * AppEnv.CompanyPrefs.MaxDiscountPercentage then begin
        CommonLib.MessageDlgXP_Vista(sDiscTooBig, mtWarning, [mbOK], 0);
      end else begin
        LineEntry('Discount ' , rDiscount  , ReplaceStr(PART_DOL_DISC,'$',AppEnv.RegionalOptions.CurrencySymbol), true);
      end;
end;

procedure TPOSScreenForm.ApplySurcharge(rsurcharge: Double);
begin
        LineEntry('Surcharge ' , rSurcharge  , ReplaceStr(PART_DOL_SURCH,'$',AppEnv.RegionalOptions.CurrencySymbol), False);
end;

Function TPOSScreenForm.LineEntry(Caption:String; Amount:double; ProductName:String; Isdiscount:Boolean = False):Boolean;
begin
    REsult := False;
    DisplayInViewer(Caption ,   CurrToStrRJ(Amount, 13));
    FilterPartsByName(ProductName);
    if Isdiscount then Amount := 0-amount;
    if not PostSaleItem(Caption , Amount,1, 0, 0.0, 0.0, false, true, false , Isdiscount) then Exit;
    DisplayLineItem(lstLineItems.Last);
    EnteringNum(false);
    Result := True;
end;

function TPOSScreenForm.CurrentRow: PLineItemRec;
var
  itemIndex:Integer;
begin
  if grdTrans.Row-1 <lstLineItems.count then
      itemIndex :=grdTrans.Row
    else itemindex :=grdTrans.rowcount-1;
  result := ItemForGridIndex(itemindex);//lstLineItems.Items[itemindex];
end;

procedure TPOSScreenForm.RefreshforCustomer;
var
  ctr:Integer;
  ItemRec:PLineItemRec;
begin
  bPriceChange := False;
  rPriceChange:= 0;
  for ctr := 0 to lstLineItems.Count-1 do begin
    itemrec:=lstLineItems.Items[ctr];
    if not ItemRec^.IsDiscount then  begin
      PostSaleItem( Itemrec, itemrec^.ProductDescription ,0 , itemrec^.Qty , 0 ,0 , 0 , true, False ,true);
      CaluclateDiscount(Itemrec);
    end;
  end;
  RebuildGrid;
end;

function TPOSScreenForm.GetVouchernumber: Boolean;
var
  errmsg:String;
begin
  While True do begin
    Result := MemoInput('Voucher Number Entry', sVoucherNo);
    if result then result :=sVoucherNo <> '';
    if not result then
      errmsg:= 'Voucher Number Should Not be Blank.'+chr(13)+chr(13)
    else begin
      result:= Validvoucherno(sVoucherNo,errmsg);
    end;
    if result then exit
    else if CommonLib.MessageDlgXP_Vista(errmsg+'Do You Wish to Enter Another Voucher Number?', mtconfirmation, [mbyes,mbNo],0 ) = mrNo then Exit;
  end;
end;

function TPOSScreenForm.Validvoucherno(const sVoucherNo:String; var errmsg:String):Boolean;
var
  ctr:Integer;
  ItemRec:PLineItemRec;
begin
      errmsg:= '';
      with commonDblib.TempMyQuery do try
        SQL.add('SELECT * FROM tblvouchers where voucherno = '+quotedStr(sVoucherNo));
        Open;
        result := recordcount = 0 ;
        if not result then begin
          errmsg:='Voucher:' + sVoucherNo +' is already issued to ' +GetClientName(FieldByname('clientID').asInteger)+' on ' +FormatDateTime(FormatSettings.ShortDateformat , Fieldbyname('DateIssued').asDateTime )+chr(13)+chr(13);
        end else begin
          for ctr := 0 to lstLineItems.Count-1 do begin
            ItemRec:=lstLineItems.Items[ctr];
            if ItemRec^.VoucherNo= sVoucherNo then begin
              errmsg:='Voucher:' + sVoucherNo +' is already issued.'+chr(13)+chr(13);
              Result := false;
            end;
          end;
        end;
      finally
          if active then close;
          Free;
      end;
end;

procedure TPOSScreenForm.UOMFn;
var
  pItem: pLineItemRec;
  tmpComponent :TComponent;
begin
  if lstLineItems.Count = 0 then begin
    Exit;
  end;
  pItem := CurrentRow;
  if not Assigned(pItem) then exit;
  if pItem^.ProductID = 0 then exit;

  if not FormStillOpen('TUnitOfMeasureforProductGUI') then begin
      tmpComponent := GetComponentByClassName('TUnitOfMeasureforProductGUI');
      If not Assigned(tmpComponent) then Exit;
      with TUnitOfMeasureforProductGUI(tmpComponent) do begin
        ProductID := pItem^.ProductID;
        FormStyle := fsMDIChild;
        OnGridDataSelect := OnUOMSelect;
      end;
  end;
end;

procedure TPOSScreenForm.TaxCodeFn;
var
  pItem: pLineItemRec;
  tmpComponent :TComponent;
begin
  if lstLineItems.Count = 0 then begin
    Exit;
  end;
  pItem := CurrentRow;
  if not Assigned(pItem) then exit;
  if pItem^.ProductID = 0 then exit;

  if not FormStillOpen('TTaxCodeListGUI') then begin
      tmpComponent := GetComponentByClassName('TTaxCodeListGUI');
      If not Assigned(tmpComponent) then Exit;
      with TUnitOfMeasureforProductGUI(tmpComponent) do begin
        ProductID := pItem^.ProductID;
        FormStyle := fsMDIChild;
        OnGridDataSelect := OnTaxCodeSelect;
      end;
  end;
end;


procedure TPOSScreenForm.edtUnitIDChange(Sender: TObject);
var
  UnitID:Integer;
  pItem: pLineItemRec;
begin
  if (edtUnitID.text = '') or (not (ISInteger(edtUnitID.text))) then exit;
  UnitID := StrToInt(edtUnitID.text);
  if UnitID = 0 then exit;
  pItem := CurrentRow;
  if not Assigned(pItem) then exit;
  pItem^.UnitID := UnitID;
  pItem^.Multiplier := getUnitMultiplier(unitID);
  PItem^.LinePrice:= 0;
  PostSaleItem(pItem ,PItem^.ProductDescription ,PItem^.LinePriceinc, PItem^.qty,
              pItem^.LaybyID, pItem^.LaybyBal,pItem^.LaybyAmount,False,False,  true, False, False, PItem^.UnitID);
  CaluclateDiscount(PItem);
  RebuildGrid;

end;

procedure TPOSScreenForm.OnUOMSelect(Sender: TwwDBGrid);
begin
  edtUnitID.text := ''; { to make sure onChange event fires }
  edtUnitID.Text := Sender.DataSource.DataSet.FieldByName('UnitID').AsString;
end;

procedure TPOSScreenForm.OnTaxCodeSelect(Sender: TwwDBGrid);
var
//  Rate: double;
//  CodeName, Description: string;
  pItem: pLineItemRec;
begin
//  Rate := Sender.DataSource.DataSet.FieldByName('Rate').AsFloat;
  SelectedTaxCodeId := Sender.DataSource.DataSet.FieldByName('TaxCodeId').AsInteger;
//  CodeName := Sender.DataSource.DataSet.FieldByName('Name').AsString;
//  description := Sender.DataSource.DataSet.FieldByName('Description').AsString;
  pItem := CurrentRow;
  if not Assigned(pItem) then exit;
  PItem^.LinePrice:= 0;
  PostSaleItem(pItem ,PItem^.ProductDescription ,PItem^.LinePriceinc, PItem^.qty,
              pItem^.LaybyID, pItem^.LaybyBal,pItem^.LaybyAmount,False,False,  true, False, False, 0,0);
  CaluclateDiscount(PItem);
  RebuildGrid;
end;

procedure TPOSScreenForm.ShowDetails;
var
   pItem: pLineItemRec;
begin
  if lstLineItems.Count=0 then
    exit;
  pItem := CurrentRow;
  if not Assigned(pItem) then exit;
  lblLineDetails.Caption :=pItem^.ProductDescription   + chr(13) +
                      UnitDescription(PItem^.UnitID)+chr(13) +
                      PItem^.MatrixDesc;
  lblLineDetails.Refresh;
end;

function TPOSScreenForm.UnitDescription(const UnitID: Integer): String;
var
  UOMMultipleir:Double;
begin
    result := GetUnitName(UnitID);
    UOMMultipleir:= getUnitMultiplier(unitID);
    if UOMMultipleir <> 1 then result := result + ' ( ' +
                                          FloatToStrF(UOMMultipleir , ffNumber , 15, 0) + ' ' +
                                          getBaseUnitname(UnitId)+')';
end;

procedure TPOSScreenForm.unlockallTills;
begin
  with TUSerLock.Create(Self) do try
    Unlock('POS-Till-EOP');
  finally
    Free;
  end;
end;

procedure TPOSScreenForm.PrintSaleinA4(const posSaleId:Integer);
var
  s:String;
  templName:String;
begin
  if appenv.Companyprefs.POSPrintAfterSave then
    if CommonLib.MessageDlgXP_Vista('Do You Wish To Print The Transaction To A4 Printer?', mtconfirmation, [mbYes,mbNo], 0) = mrYes then begin
      s:= '{CompanyInfo}'+
        ' SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, '+
        ' Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, '+
        ' CO.ABN FROM tblCompanyInformation AS CO  '+
        ' ~|||~{Details} SELECT S.*, SL.* '+
        ' FROM `tblsales` AS `S` '+
        ' Inner Join `tblsaleslines` AS `SL` ON `S`.`SaleID` = `SL`.`SaleID` '+
        ' left join tblrelatedparts RP on RP.ProductID = SL.productId and RP.ParentID = SL.RelatedParentProductID ' +
        ' where Sl.ProductName <> ' +quotedStr(PART_ROUNDING) +' and   S.saleid ='+IntToStr(posSaleId) + '  and (ifnull(RP.RelatedID,0)=0 or RP.IsHidden ="F")'+
        '~|||~SELECT C.CommentsID,C.Comments  FROM tblComments C  inner join tbltranscomments TC on C.CommentsID = TC.CommentID  Where TC.Transtype ="POS" and TC.TransId ='+IntToStr(posSaleId) ;
      if AppEnv.CompanyPrefs.POSSummarise then begin
        s:= replacestr(s, '`tblsales`' , 'tblsales_POS ');
        s:= replacestr(s, '`tblsaleslines`' , 'tblsaleslines_POS ');
      end;
      fbReportSQLSupplied := true;
      try
       templName := TillA4templateID(iTillID);
       if templName = '' then templName:='POSSale';
       PrintTemplateReport(templName,s , not(devmode) , 1);
      finally
        fbReportSQLSupplied := False;
      end;
    end;
end;
function TPOSScreenForm.TillA4templateID(const fiTillID: Integer): String;
begin
  with tempMyquery do try
    SQL.add('Select T.TemplName from tblpostills  PT inner join tbltemplates T on PT.DefaultA4TemplateID = T.TemplID where Pt.TillID = ' + inttostr(fitillid));
    open;
    result:= fieldbyname('TemplName').AsString;
  finally
    closenFree;
  end;

end;
function  TPOSScreenForm.TillPOStemplateID(const fiTillID:Integer):String;
begin
  with tempMyquery do try
    SQL.add('Select T.TemplName from tblpostills  PT inner join tbltemplates T on PT.DefaultTemplateID = T.TemplID where Pt.TillID = ' + inttostr(fitillid));
    open;
    result:= fieldbyname('TemplName').AsString;
  finally
    closenFree;
  end;
end;
procedure TPOSScreenForm.tmrMediaTimer(Sender: TObject);
begin
  inherited;
  if not pnlMediaHost.Visible  then
    exit;
  if Player.Length <= Player.Position  then
    PlayFile;
end;

procedure TPOSScreenForm.OpenCustomerDisplay;
begin
  TCustomerDisplayObj.Instance;
  CustomerDisplaySettings.PopulateMe(iTillID);
  if CustomerDisplaySettings.EnableCustomerDisplay then begin
    CustomerDisplay := TPOSCustomerDisplayGUI.Create(Self);
    CustomerDisplay.Show;
    if CustomerDisplay.PositionInitialised then begin
      {$IFDEF DevMode}
        CustomerDisplay.windowstate := wsNormal;
        exit;
      {$ENDIF}
      CustomerDisplay.WindowState := wsMaximized;
    end;
  end;
end;



procedure TPOSScreenForm.OpenPole;
begin

  TPoleDisplayObj.Instance;
  PoleDisplayObjSetting.Populateme(iTillID);
end;
Procedure TPOSScreenForm.DisplayOnPole(Value:String);
begin
    PoleDisplayObjSetting.DisplayOnPole(Value);
end;
Procedure TPOSScreenForm.DisplayWelcomeOnPole;
begin
  PoleDisplayObjSetting.DisplayWelcomeOnPole;
end;
Procedure TPOSScreenForm.DisplayProductOnPole(ProductName :String; Amount:Double);
begin
  PoleDisplayObjSetting.DisplayPairOnPole(ProductName, Amount);
end;

procedure TPOSScreenForm.DisplayMemoFirstLineOnPole;
var
  s2, s3:String;
begin
try
    s2:= edtPOSMemo.Lines[0];
    While Pos(s2 , '  ')<>0 do s2:= replacestr(s2, '  ' , ': ');
    s3:= edtPOSMemo.Lines[1];
    While Pos(s3 , '  ')<>0 do s3:= replacestr(s3, '  ' , ': ');
    PoleDisplayObjSetting.doComplete(rRunTot,s2,s3);
except
    //kill the exception
end;
end;

procedure TPOSScreenForm.DisplayItemoonPole(const pItemRec: pLineItemRec);
begin
  DisplayProductOnPole(pItemRec^.ProductDescription   , pItemRec^.Amount);
end;
Function TPOSScreenForm.IteraterecordProgressbarMsg(Sender:TDatasetBusObj):String;
begin
  Result := WAITMSG;
  if sender is TBusObj then
    result:= TBusObj(Sender).IteraterecordProgressbarMsg;
end;
procedure TPOSScreenForm.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited ;
  if (EventType=BusobjEvent_Event) then begin
    if (Value =BusobjEvent_IteratereRecords) then begin
      if not SameText(Sender.ClassName,'TPQA') then
        ShowLocalProgressbar(Sender.Count, IteraterecordProgressbarMsg(Sender));
    end else if Value =BusobjEvent_IteratereRecordLoop then begin
      if not SameText(Sender.ClassName,'TPQA') then
        StepLocalProgressbar;
    end else if Value =BusobjEvent_IteratereRecordDone then begin
      if not SameText(Sender.ClassName,'TPQA') then
        HideLocalProgressbar;
    end ;
  end;
end;

procedure TPOSScreenForm.DoDevmodeTesting;
begin
    oRcptPrn.OpenPort;
    oRcptPrn.Justify(CJ);
    oRcptPrn.Print('========================================');
    oRcptPrn.Print(uppercase(''));
    oRcptPrn.Print('............................');
    oRcptPrn.Print(uppercase(''));
    oRcptPrn.Print('========================================');
    oRcptPrn.newline(1);
    oRcptPrn.newline(1);

    oRcptPrn.ClosePort;
end;


function TPOSScreenForm.CurrencyToStrF(Value: Currency;  Format: TFloatFormat): string;
begin
   REsult := CurrToStrF(Value , format , CurrencyRoundPlaces);
end;

procedure TPOSScreenForm.OpenOPOS;
begin
  TOPOSSettingObj.Instance;
  OPOSSetting.Populateme(iTillID);
  if OPOSSetting.usescanner then EnableOPOSScanner;
  if Assigned(OPOSSetting) and  OPOSSetting.UseScale   then EnableOPOSScale;
end;
procedure TPOSScreenForm.EnableOPOSScale;
begin
  OPOSScale := OPOSSetting.EnableOPOSScale(Self , OPOSScannerEvent , OPOSOnErrorEvent);
end;

procedure TPOSScreenForm.EnableOPOSScanner;
begin
  if OPOSSetting.EnableOPOSScanner(Self , OPOSScannerEvent , OPOSOnErrorEvent) = nil then begin
    OPOSSetting.Free;
    OPOSSetting:= nil;
  end;
end;
procedure TPOSScreenForm.CloseOPOS;
begin
  if assigned(OPOSSetting) then
    OPOSSetting.closeOPOSScanner;
end;
procedure TPOSScreenForm.OPOSOnErrorEvent(ASender: TObject; ResultCode,
  ResultCodeExtended, ErrorLocus: Integer; var pErrorResponse: Integer);
begin

end;

procedure TPOSScreenForm.OPOSScannerEvent(ASender: TObject; Status: Integer);
var
  xEnteringNum :Boolean;
begin
  if ASender is TOPOSScanner then begin
    xEnteringNum :=fbEnteringNum;
    EnteringNum(TRue);
    try
      OPOSScanning := TRue;
      try
      if idOk() then begin
        sBarcode:=TOPOSScanner(Asender).ScanDatalabel;
        SendKeys('{ENTER}',True);
        TOPOSScanner(Asender).DataEventEnabled := True;
      end;
      finally
        OPOSScanning:= False;
      end;
    finally
      EnteringNum(xEnteringNum);
    end;
  end else if ASender is TOPOSScale then begin

  end;
end;
procedure TPOSScreenForm.hideColumn(colindex: Integer; ShowColumn: Boolean);
begin
  if ShowColumn then
    grdtrans.UnHideColumn(colindex)
  else
    grdtrans.HideColumn(colindex);
  GuiPrefs.Node['Gridcolumn.col'+inttostr(colindex)].asString := BooleantoStr(ShowColumn);
end;

procedure TPOSScreenForm.SetGridcolumns;
begin
   hideColumn(col_qty   , ((GuiPrefs.Node.Exists('Gridcolumn.col'+inttostr(col_qty    ))=False)       OR (GuiPrefs.Node['Gridcolumn.col'+inttostr(col_qty)].asString        ='T')));
   hideColumn(col_name  , ((GuiPrefs.Node.Exists('Gridcolumn.col'+inttostr(col_name   ))=False)       OR (GuiPrefs.Node['Gridcolumn.col'+inttostr(col_name)].asString        ='T')));
   hideColumn(col_desc  , ((GuiPrefs.Node.Exists('Gridcolumn.col'+inttostr(col_desc   ))=False)       OR (GuiPrefs.Node['Gridcolumn.col'+inttostr(col_desc)].asString        ='T')));
   hideColumn(col_price , ((GuiPrefs.Node.Exists('Gridcolumn.col'+inttostr(col_price  ))=False)       OR (GuiPrefs.Node['Gridcolumn.col'+inttostr(col_price)].asString       ='T')));
//   hideColumn(col_uomprice , ((GuiPrefs.Node.Exists('Gridcolumn.col'+inttostr(col_uomprice  ))=False) OR (GuiPrefs.Node['Gridcolumn.col'+inttostr(col_uomprice)].asString       ='T')));
   hideColumn(col_amount, ((GuiPrefs.Node.Exists('Gridcolumn.col'+inttostr(col_amount ))=False)       OR (GuiPrefs.Node['Gridcolumn.col'+inttostr(col_amount)].asString      ='T')));
   hideColumn(col_profitpercent, ((GuiPrefs.Node.Exists('Gridcolumn.col'+inttostr(col_profitpercent ))=False)       OR (GuiPrefs.Node['Gridcolumn.col'+inttostr(col_profitpercent)].asString      ='T')));
   hideColumn(col_profitdollar, ((GuiPrefs.Node.Exists('Gridcolumn.col'+inttostr(col_profitdollar ))=False)       OR (GuiPrefs.Node['Gridcolumn.col'+inttostr(col_profitdollar)].asString      ='T')));
end;

procedure TPOSScreenForm.mnuCustomiseListClick(Sender: TObject);
begin
  inherited;
  With TfmPOSCustomizeGrid.create(Self) do try
    QtyVisible         := not(grdTrans.IsHiddenColumn(col_qty));
    ProductNameVisible := not(grdTrans.IsHiddenColumn(col_name));
    ProductdescVisible := not(grdTrans.IsHiddenColumn(col_desc));
    UnitPriceVisible   := not(grdTrans.IsHiddenColumn(col_price));
    AmountVisible      := not(grdTrans.IsHiddenColumn(col_amount));
    ProfitDollarVisible :=   not(grdTrans.IsHiddenColumn(COL_PROFITDOLLAR));
    ProfitPercentVisible :=   not(grdTrans.IsHiddenColumn(COL_PROFITPERCENT));
    showmodal;
    if modalresult = mrok then begin
      hideColumn(col_qty    , Qtyvisible);
      hideColumn(col_name   , Productnamevisible);
      hideColumn(col_desc   , productdescvisible);
      hideColumn(col_price  , unitpricevisible);
      hideColumn(col_amount , amountvisible);
      hideColumn(COL_PROFITPERCENT, ProfitPercentVisible);
      hideColumn(COL_PROFITDOLLAR, ProfitDollarVisible);
    end;
  finally
    Free;
  end;
end;
Procedure TPOSScreenForm.ClearInputMemo;
begin
  edtPOSMemo.clear;
end;
Procedure TPOSScreenForm.LogKey(Key: word);
begin
(*    if not devmode then exit;
    if screen.activecontrol = edtPOSMemo then begin
      lblLog.caption := lblLog.caption  + char(key);
      lblLog.refresh;
    end;*)
end;
function  TPOSScreenForm.UnLockVoucher:boolean ;
var
  ErrMsg:String;
begin
  result := true;
  if not userlock.enabled then userlock.enabled := True;
  userlock.unLock('tblvouchers' , 0, 'POS');
  Result := True;
end;

initialization
  RegisterClassOnce(TPOSScreenForm);
finalization

end.

