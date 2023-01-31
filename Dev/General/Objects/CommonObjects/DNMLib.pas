{ ****************************************************************************
  DnMLib - Miscellaneous library routines for use by DnM applications
  **************************************************************************** }
{ Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  19/05/05  1.00.01 BJ  Formating Display label of the Grid (function SeparateWords)
  is modified to change the case of 'ID' which should be in
  capital letters (incase if it is not. eg Id ot id) etc.
  07/07/05  1.00.02 DMS Moved procedure SetGlobalIsolationLevel to CommonDBLib.
  15/07/05  1.00.03 DMS New function - is to change the caption of the form. The caption
  of the form contains the access information and the lable
  of the form separated with a -. This function replaces the
  [label before the -] with the new value.
  25/07/05  1.00.04 DSP Added stock adjustment into the GetCellQtyValue function
  19/10/05  1.00.05 BJ  New Function AddDatetimelogin to add current user name and
  system date and time to the text passed to it.
  25/11/05  1.00.06 DSP Moved two statements with 'exit' into a try - finally
  block in the ProcessEditedFlag procedure.
  13/12/05  1.00.07 DSP Added the function DuplicatePart and the procedures
  CopyProductTableRecords, CopyTableRecord, CopyAssemblyData and
  CopyChildGroup. These are used to produce a clone of
  a product.
  11/06/06  1.00.08 IJB Modified RealignTabControl to only change tab size if
  new tab size is different (+/- one pixel).
  20/01/06  1.00.09 DSP Add function GetJobName.
  20/09/05  1.00.10 ISB Move User Temporary Table functions to CommonDbLib
  27/01/06  1.00.11 DSP Changed GetJobName to lookup tblrepairs instead of
  tblrepairjobs.
  09/02/06  1.00.12 DSP Added procedure SaveFieldPrefs.
  09/03/06  1.00.13 DSP Added functionality for stock transfer to
  GetCellQtyValue.
  12/04/06  1.00.14 DSP Removed functionality for AdvMatrix.
  26/04/06  1.00.15 BJ  Function : GetProductInfo
  Buy and sell defualt UOM fields are removed from the parts table ,
  the default is always the DEFAULT_UOM So the Qry's SQL is not selecting
  the fields and the object has the properties intialised to the default value
  14/07/06  1.00.16 DSP Added adjustments for PriceInc1, PriceInc2 and PriceInc3
  to UpdateNewPrices.

}

unit DNMLib;

interface

uses SysUtils, Forms, Classes, Types, StrUtils, DB, Messages, Windows, Dialogs, ExtCtrls, Math, kbmMemTable, WwDBGrid, Graphics, Controls, Wwdbcomb, DateUtils, Variants, ComCtrls, AdvOfficeStatusBar,
  MyAccess, ERPdbComponents, MyClasses, ProgressDialog,
  // ReceiptPrinterObj,
  //
  BusObjStock, DNMSpeedButton, wwcheckbox, wwradiogroup, InventoryTypes ,DBCtrls;

/// ////////////////////////////////////////////////////////////////////////////////////////////////////////
// Used in the Ordering Matrix Form ( frmOrderingMatrixGUI )
/// ////////////////////////////////////////////////////////////////////////////////////////////////////////
type
  TMatrixQtyMode = (mqmInStock, mqmAllocatedSO, mqmAllocatedBO, mqmOnOrder, mqmAvailable, mqmSOBO, mqmSold, mqmReceivedStock, mqmDataSold, mqmDataPO, mqmToSell, mqmStockAdjustment, mqmStockTransfer);

type
  TLogchangingDetailsonNoteFields = (
    lcdOnLoganyway              = 0,
    lcdOnServicePadFeedback     = 1,
    lcdOnRepairsFeedback        = 2,
    lcdOnRepairsNotes           = 3,
    lcdOnSupportPricingNotes    = 4,
    lcdOnSupplierfollowupNotes  = 5,
    lcdOnchequecomments         = 6,
    lcdOnchequeInternalcomments = 7,
    lcdOnCustPayComments        = 8,
    lcdOnDepositEntryNotes      = 9,
    lcdOnDepositNotes           = 10,
    lcdOnSuppPayNotes           = 11,
    lcdOnRepairNotes            = 12,
    lcdOnRepairFeedbackNotes    = 13,
    lcdOnCashsAleComments       = 14,
    lcdOnCustomerfollowupNotes  = 15,
    lcdOnTimeSheetInvoiceNotes  = 16,
    lcdOnDoNotLog               = 17);


type
  PMatrixQtyResults = ^TMatrixQtyResults;

  TMatrixQtyResults = record
    dQty: double;
    dUOMQty: double;
  end;
  /// ////////////////////////////////////////////////////////////////////////////////////////////////////////

type
  TBASBasisMode = (Accrual_Basis, Cash_Basis);

type
  TArrayOfChar = array [0 .. 255] of char;

type
  PASDescription = ^TASDescription;

  TASDescription = record
    Result: string;
  end;

type
  PSerialNode = ^TSerialNode;

  TSerialNode = record
    SerialID: integer;
    SerialNumber: string;
  end;

type
  TSuppInvoiceNoDupInfo = record
    IsDup: boolean;
    PurchaseOrderID: integer;
    PurchaseOrderNumber: string;
    IsPO: boolean;
    IsBill: boolean;
    IsCredit: boolean;
  end;

type
  PProductInfo = ^TProductInfo;

  TProductInfo = record
    PartID: integer;
    ProductName: string;
    ProductCode: string;
    ProductGroup: string;
    PartType: string;
    PartBuyDescription: string;
    PartSellDescription: string;
    BuyUnitOfMeasure: string;
    SellUnitOfMeasure: string;
    BuyUnitOfMeasureID: integer;
    SellUnitOfMeasureID: integer;
    BuyUnitOfMeasureMultiplier: double;
    SellUnitOfMeasureMultiplier: double;
    BarCode: string;
    IncomeAccount: string;
    AssetAccount: string;
    COGSAccount: string;
    SellTaxCode: string;
    PurchaseTaxCode: string;
    PreferedSupplier: string;
    SNTracking: boolean;
    PreferedSupplierID: integer;
    SellQty1, SellQty2, SellQty3: double;
    Price1, Price2, Price3: double;
    BuyQty1, BuyQty2, BuyQty3: double;
    BuyPrice1, BuyPrice2, BuyPrice3: double;
    LatestCostPrice: double;
    LatestCostDate: TDateTime;
  end;

type
  TClonedRecords = array of integer;

type
  TSnapShotType = (stSuburbs, stProductListCombos);
  TSnapShotInfo = array [ low(TSnapShotType) .. high(TSnapShotType)] of string;

type
  TTranType = (ttLocation, ttManifestVehicle, ttManifestRoute, ttManifest, ttSupplierPayment, ttCustomerPayment, ttUnitsOfMeasure,
    ttParts, ttEquipment, ttToDo, ttRepServices, TfrmRep, ttPassword, ttEmployee, ttSupplier, ttOtherContact, ttJob, ttCustomer, ttCustomFields, ttTerms, ttTaxcode, ttShipping,
    ttForeignExchangeRate, ttClass, ttChartOfAccounts, ttCashSale, ttRefund, ttPOS, ttBill, ttCredit, ttCheque, ttPurchaseOrder, ttRA, ttSmartOrder, ttInvoice, ttQuote, ttSalesOrder, ttAppointment,
    ttJournalEntry, ttPhSupportLog, ttRepairs, ttNone);

  TTranTypeInfo = array [ low(TTranType) .. high(TTranType)] of string;

const
  SnapShotFromTableName: TSnapShotInfo = ('tbllocations', 'tblparts');
  SnapShotFromTablePrimaryKey: TSnapShotInfo = ('LocationID', 'PARTSID');
  SnapShotDesc: TSnapShotInfo = ('Locations', 'Product Combo''s');
  SnapShotGetBatchSize: TSnapShotInfo = ('5000', '5000');
  SnapShotOrderBy: TSnapShotInfo = ('City_sub', 'PARTNAME');

  PNLMAXClassCount: integer = 40;
  /// ///////////////////////////////////////////////////////////////////////////////////////////////
  JOBNUMBER_MAINGRIDFIELD = 'CustomerJob'; // This is the fieldname that BaseTrans uses
  // For Customer Job - This constants main purpose
  // is to disable sorting on the specified field.

  SMART_JOBNUMBER_MAINGRIDFIELD = 'CusJobName'; // This is the fieldname that SmartOrder uses
  // For Customer Job - This constants main purpose
  // is to disable sorting on the specified field.

  JOBNUMBER_FIELDNAME = 'JobNumber'; // This is the fieldname that is used
  // for toggling Customer Job and JobNumber within
  // TwwDBGrids.  This fieldname is also used within
  // relative queries in regards to customer jobs.

  TS_JOBNUMBER_FIELDNAME = 'Job'; // AS line above - but for Job Costing Timesheets.
  JOBNUMBER_DISPLAYTEXT = 'Job Number'; // This is the default text that shows in the
  // grid column.
  /// ///////////////////////////////////////////////////////////////////////////////////////////////

  // Calendar ID's
  CAL_FUNCS = 1; // Function Calendar
  CAL_APPOINT = 2; // Appointment Calendar
  CAL_ROSTER = 3; // Roster Calendar
  CAL_UNITS = 4; // Unit Bookings Calendar

  { String handling }
function AddDateTime(const LogchangingDetailson : TLogchangingDetailsonNoteFields; const s: string; AddEmpName:Boolean =False): string; overload;
Procedure AddDateTime(const LogchangingDetailson : TLogchangingDetailsonNoteFields; memo :TDBMemo; AddEmpName:Boolean =False);   overload;
function AddDateTimeemp(const LogchangingDetailson : TLogchangingDetailsonNoteFields;const s: string; AddEmpName:Boolean =False): string;
(*function AddUserAndDateTime(const LogchangingDetailson : TLogchangingDetailsonNoteFields;const s: string): string;
function AddDateTimeLogin(const LogchangingDetailson : TLogchangingDetailsonNoteFields;const s: string): string;*)
function UserPreferenceOn(const LogchangingDetailson : TLogchangingDetailsonNoteFields):Boolean;
function TArrayOfCharToStr(const A: TArrayOfChar): string;

function CountWords(const Data: string; const strDelim: string = ' '; const CountWhenNotBlank: boolean = true): integer;

function EnCrypt(const Text: string; const KEY: string): string;

function GetLargestResult(const sValue1, sValue2: string): string;
procedure SplitString(const aValue: string; const aDelimiter: string; var Result: TStringList);
function IsInteger(const s: string): boolean;
function IsNumeric(const s: string): boolean;
function IsPrintable(const c: char): boolean;
function RemoveInvalidAlphaNumericCharacters(const sValue: string): string;
function ReplaceStr(const sString, sOldStr, sNewStr: string): string;
function SeparateWords(const s: string): string;
function StripDateTime(const s: string): string;
function StripSpaces(const sString: string): string;
function StrToTArrayOfChar(const s: string): TArrayOfChar;
function StrValue(const sValue: string): double;
function ValidAlphaNumericCharacters(const sValue: string): boolean;
function ValidDatabasename(const sValue: string): boolean;
{ Number handling }
function DivZer(const x, y: extended): extended;

{ Misc Methods }

function CheckABN(const ABN: string): boolean;
function ConvertCurrentDateToMySQLDate(const dtConversionDate: TDateTime): string; overload;
function ConvertCurrentDateToMySQLDate: string; overload;
function ConvertCurrentDateToMySQLDateTime(const dtConversionDate: TDateTime): string; overload;
function ConvertCurrentDateToMySQLDateTime: string; overload;
function GetControl(const sName: string; const pnl: TPanel): TControl;
function GetGridColumnIndex(const ThisGrid: TwwDBGrid; const FieldName: string): integer;
function GetPCName: string;
function GetPCNetworkName: string;
function GetPreferedSupplierFromPart(const PartID: integer): string; overload;
function GetPreferedSupplierFromPart(const ProductName: string): string; overload;
function GetSupplierID(const SupplierName: string): integer;
function GetTableRoomName(const RoomID: integer): string;
function GetVehicleID(const VehicleName: string): integer;
function MoneyWords(const dValue: double): string;
// function MysqlDateStrToDate(const MsqlDate: string): TDateTime;

function RoundCurrency(const Value: double): currency;
function RoundQty(const Value: double): double;
function RoundTo5C(const rMoney: currency(*; const iUpDownValue: double = 2.5*)): currency; Overload;

function WinExecAndWait(const FileName: string; const Visibility: integer): longword;
procedure ClearTList(const lst: TList; const iSize: integer);
procedure EnableGrid(const grd: TwwDBGrid; const bState: boolean);
procedure EnablePanel(const pnl: TPanel; const bState: boolean; const bRecursive: boolean = true);
procedure MFree(var p: Pointer; const lSize: longint);
procedure RealignTabControl(const TabCtl: TPageControl; const TabLines: integer);
procedure RemoveXDesignSql;
procedure WinExec(const FileName: string; const Visibility: integer);
function ChangeFormCaption(const NewValue, OldValue: string): string;
function DuplicatePart(const PartsID: integer; const Connection: TCustomMyConnection): integer;
procedure CopyProductTableRecords(const PartsID, NewPartsID: integer; const SQLText: string;const qrySource, qryDestination: TERPQuery; ExcludeList: TStrings;const OrderBy: string = ''; NewProduct: TProduct = nil);
procedure CopyTableRecord(const qrySource, qryDestination: TERPQuery; ExcludeList: TStrings);
// procedure SaveFieldPrefs(const GuiPrefs: TFormGuiPrefs);
procedure SetClassLabels(const Form: TForm);

function StartMySQLLockMonitor: boolean;
function StopMySQLLockMonitor: boolean;

{ Edited Flags }
function IsModified(const OldValues: TDataSet; const NewValues: TCustomMyDataset): boolean;
procedure LoadEditedFlagMemTable(const DiskQry: TDataSet; const MemQry: TkbmMemTable);
procedure ProcessEditedFlag(const DataDescription: string; const FromForm: TForm; const OldValues, NewValues, Master: TDataSet; const DoPost: boolean = false);
Procedure SetfocusToERP;

{ Misc Enumerators }
type
  TFormMode = (fmReadOnly, fmEdit, fmInsert, fmBackOrder);

  { Misc Messages }

function CMessageDlg(const Msg: string; const DlgType: TMsgDlgType; const btn1, btn2, btn3: string): string;

{ System thingys :) }
//function GetMachineIdentification(const User, System, Network, Drives: boolean): string;
function IsDir(const DirPath: string): boolean;
// function SysDir: string;
// function TempDir: string;
// function WinDir: string;

{ File Handling }
function CreateNewWaveFile(const NewFileName: string): boolean;
function IsValidFileName(const FileName: string): boolean;
procedure DeleteFiles(const Path, Mask: string);
procedure DeleteMultipleFiles(const Path, filenames:String);
procedure DeleteRecursiveFiles(const dir: string);
procedure FindInCurrentDir(const Mask: string; const sl: TStringList);

{ ADO/DB related }
function CloneRecord(const dsSrc: TCustomMyDataset; const autoKeyField: string): integer; overload;
function CloneRecords(const dsSrc: TCustomMyDataset; const autoKeyField: string): TClonedRecords; overload;
function GetMysqlTablePrimaryKey(const TableName: string): string;
function IsThisTransactionInUse(const ADOQuery: TERPQuery; const KeyID: integer; const Connection: TCustomMyConnection): boolean;
function QueryMaxRecords(const DataSet: TERPQuery): integer;
// function SetMyDacConnection(const MyConnection: TERPConnection; const ADOConnectionString: string = ''): boolean;
procedure CheckRunLinesForExistingFields;
procedure DeleteAllRecords(const dst: TDataSet);
procedure DeleteRecord(const dst: TDataSet);
procedure UnlockTables;

{ Transaction Info }
function ClassNameToTranType(const ClassName: string): TTranType;
function TypeToDescription(const TranType: TTranType): string;
function TypeToDetailPKName(const TranType: TTranType): string;
function TypeToDetailTableName(const TranType: TTranType): string;
function TypeToMasterPKName(const TranType: TTranType): string;

function ValidateClosingDate(const TransDate: TDateTime; const IsAR, IsAP: boolean): boolean;
procedure SetConnectionIsolationLevel(const oConnection: TCustomMyConnection); overload;
procedure SetConnectionIsolationLevel(const oConnection: TERPConnection); overload;
function GetStockCostSystem(const No: integer): TStockCostSystem;

{ Back End Related }
function GetMenuColour: integer;
//function GetClientsDefaultReport(const ClientID: integer): string;
function CheckRelatedProduct(const iRelatedID, iProductID: integer): boolean;
function CheckAlternateProduct(const iAlternateID, iProductID: integer): boolean;
function AlternateProductUnique(const iAlternateID, iProductID: integer; ID: integer; Connection: TCustomMyConnection = nil): boolean;
function CopyRecord(const Src, Dest: TCustomMyDataset): boolean;
function GetAbilityID(const sAbility: string): integer;
function GetAccountGroup(const iAccountID: integer): string;
function GetAccountID(const AccountName: string): integer;
function GetAccountType(const AccountID: integer): string;
function GetAllowanceID(const sAllowanceName: string): integer;
function GetAmountEx(const AmountInc: double; const TaxRate: double): double;
function GetAmountInc(const AmountEx: double; const TaxRate: double): double;
function GetTaxAmount(const AmountEx: double; const TaxRate: double): double;
function GetAssetCode(const PartID: integer): string;
function GetBarTabBalance(const iClientID: integer): currency;



// function GetClassName(const iClassID: integer): string;
function GetClassVariancePercentage(const ClassID, ProductID: integer): double;
function GetClientDefaultClass(const iClientID: integer): string;

function GetClientIDFromAccount(const sAccountNo: string): integer;
function GetClientIDFromCard(const sCardNumber: string): integer;
function GetClientIDFromPrepayment(const iPrePaymentID: integer): integer;
function GetClientIDFromSale(const iSaleID: integer): integer;

function GetClientsTermsID(const iClientID: integer): integer;
function GetCompanyName: string;
function GetEmployeeClass(const iEmployeeID: integer): integer;
function GetEmployeeID(const EmployeeName: string): integer;
function GetEmployeeName(const iEmployeeID: integer): string;
function GetEquipmentID(const sEquipmentName: string): integer;
//function GetFileVersion(const FileName: string): string;
function GetForeignExchangeSellCode(const iClientID: integer): string;
function GetFormDescription(const FormName: string): string;
function GetInvDocNo(const SaleID: integer): string;
function GetJobParentID(const iClientID: integer): integer;
function GetLastRecordPostID(const TableName: string): integer; overload;
function GetLastRecordPostID(const TableName: string; Connection: TCustomMyConnection): integer; overload;
function GetLaybyBal(const iSaleID: integer; const dTotalAmountInc: currency): currency;
function GetMyNextSequenceNumber(const iRunID: integer): integer;
function GetMysqlServerVersion: string;
function GetNextInvoiceBaseNo(const ClientID: integer): integer;
function GetPartAdvMatrixCostEx(const PartID, ClassID, ClientID: integer; const UnitofMeasure: string): double;
function GetPartAttrib1Purchase(const PartID: integer): double;
function GetPartAttrib1Sale(const PartID: integer): double;
function GetPartBarcode(const PartID: integer): string;
function GetPartID(const sPartName: string): integer;
function GetPartName(const PartID: integer): string;
function GetPartPrice1(const PartID: integer): double;
function GetPartPrice2(const PartID: integer): double;
function GetPartPrice3(const PartID: integer): double;
function GetPartPurchaseTaxcodeRate(const PartID: integer): double;
function GetPartType(const PartID: integer): string;
function GetPayMethod(const iPayMethodID: integer): string;
function GetPayMethodName(const iPayMethodID: integer): string;
function GetPhysicalAddress(const iClientID: integer): string;
function GetPrepaymentAccountID(const TransType: string): integer;
function GetSupplierPrepaymentAccountID: integer;
function GetCustomerPrepaymentAccountID: integer;
function GetProductInfo(const iProductID: integer): TProductInfo;
function GetProductReminderPopup(const ProductID: integer; var MessageStr: string): boolean;
function GetProductPurchaseReminderPopup(const ProductID: integer; var MessageStr: string): boolean;
function GetRunName(const iRunID: integer): string;
function GetServersUserVersion(Connection: TERPConnection): string;
function GetServiceID(const sService: string): integer;
function GetShippingAddress(const iClientID: integer): string;
function GetStatementNo(const ReconciliationID: integer): string;
function GetTaxRate(const iProductID: integer): double; overload;
function GetTaxRate(const sTaxCode: string): double; overload;
function GetTerms(const TermsID: integer): string;
function GetTermsID(const Terms: string): integer;
// function GetUnitID(const sUnitName: string): integer;
function GetUnitMultiplier(const UnitOfMeasureID: integer): double;
function GetUnitName(const iUnitID: integer): string;
function getBaseUnitname(const iUnitID: integer): string;
// function GetUnitTimeID(const sPeriod: string): integer;
// function GetJobName(const RepairID: integer): string;
function HasBarTabsConvertStarted: boolean;
function HasPayrollAccess: boolean;
function HasHireAccess: boolean;
function GoogleModuleInstalled:Boolean;
function IsBatchInProgress: boolean;
function TempClosingTablesEmpty: boolean;
function IsThisBranchUsed(const BranchSiteCode: string): boolean;
function IsCreditOK(const iClientID: integer; const bVerbose: boolean = true): boolean;
function IsCustomerOnRun(const iClientID, iExcludeRunID: integer): boolean; overload;
function IsCustomerOnRun(const iClientID: integer; const sClientName: string): boolean; overload;
function IsDupMultisiteEmail(const BackEndID: integer; const EmailAddress: string): boolean;
function IsMultisitePC(const EmployeeID: integer): boolean;
procedure SetMultisitePC(const EmployeeID: integer);
function IsGroupProduct(const PartsID: integer): boolean;
function IsPosEOPDoneAndNoSummariseSalesExist: boolean; { Check To See If End Of Period was Done ! }
function IsProductDiscontinued(const iProductID: integer): boolean;
function IsAlternateProduct(const iProductID: integer): boolean;
function AlternateProductFor(const iProductID: integer): string;
function IsRelatedChild(const ClientID: integer): boolean;
function IsStopCredit(const iClientID: integer): boolean;

function IsTermsOK(const iClientID: integer; const bVerbose: boolean = true): boolean;
function IsTransTableEmpty: boolean;
function ProductExist(const ProductName: string): boolean;
function ServerIsActive: boolean;

procedure GetCredit(const iClientID: integer; var rLimit: currency; var rBalance: currency);
procedure GetPartCosts(const PartID: integer; var Cost1, Cost2, Cost3: double);
procedure IncrementNextBaseInvoiceNo(const ClientID: integer);
procedure PopulateCustomCombos(const pnl: TPanel);
procedure ResetAllEmployeeNames;
procedure ResetBalances;
procedure SetBarTabsConvertStarted;
procedure SetBatchInProgress(const SetFlag: boolean);


procedure SetNoAccess(const EmployeeID: integer);
procedure SetRelatedChildID(const tblClient: TDataSet); overload;
procedure SetRelatedChildID; overload;
procedure UnSetBarTabsConvertStarted;
procedure UpdateLatestCost(const PartsID: integer; const LatestCost: double; const LatestCostDate: TDateTime);
procedure updateDefaultCalss(const Defaultclass, sitecode, cleanDefaultclass: string; fconnection: TERPConnection);
procedure UpdateSecsInAllLogs;
procedure CleanUpLevelFields(const AccountID: integer = 0);
procedure SetAccountLevelField(const AccountID: integer = 0);
procedure UpdateLevels(const AccountID: integer; const Level1, Level2, Level3, Level4: string);
function FirstNoAbort(const DataSet: TDataSet): boolean;
function GetParentRelatedClientID(const ClientID: integer): integer;

{ Receipt Printer }
function GetAssignedTillID(const sPCName: string): integer;
function IsPrintSpooler(const iTillID: integer): boolean;
// function CreatePrinter(const sPrnType: string;PrinterName:String): TReceiptPrinter;
function GetPrinterType(const iTillID: integer): string;
function GetPrintername(const iTillID: integer): string;
function GetPrinterDev(const iTillID: integer): string;

{ Foreign Exchange Rates handling }
function Local_To_ForeignCurrency(const Amount: double; const Rate: double): double; overload;
function Local_To_ForeignCurrency(const Amount: double; const Rate: double; const Decimals: integer): double; overload;
function ForeignCurrency_To_AUD(const ForeignAmount: double; const Rate: double): double;
function DoesProductUseHedgingFormula(const PartsID: integer): boolean;

{ Payroll - also see TaxUtils }
function DefaultAwardExists: boolean;

function GetLastFiscalYearEnd: TDateTime; overload;
function GetLastFiscalYearEnd(const CurrentDate: TDateTime): TDateTime; overload;
function GetFiscalYearEnd(const CurrentDate: TDateTime): TDateTime;

function GetCurrentFiscalYearStart: TDateTime; overload;
function GetCurrentFiscalYearStart(const CurrentDate: TDateTime): TDateTime; overload;
function GetPriorFiscalYearStart: TDateTime;
function InPayrollTestMode: boolean;

{ Date Time - see also Delphi's Date/Time functions }
function StartOfTheFY(const dtDate: TDateTime): TDateTime;
function StartOfTheQuarter(const dtDate: TDateTime): TDateTime;
function DaysInQuarter(const dtDate: TDateTime): integer;
function DaysBetweenSigned(const dtNow, dtThen: TDateTime): integer;
function WeeksBetweenSigned(const dtNow, dtThen: TDateTime): integer;
function MonthsBetweenSigned(const dtNow, dtThen: TDateTime): integer;
function YearsBetweenSigned(const dtNow, dtThen: TDateTime): integer;
function MinsToStr(const iMins: integer): string;

function GetMonthName(const MonthNo: integer): string;
function GetMonthNo(const MonthName: string): integer;
function QuarterOf(const aValue: TDateTime): integer;
function IncQuarter(const dtDate: TDateTime; const iNumberOfQuarters: integer = 1): TDateTime;
function EndOfTheQuarter(const aValue: TDateTime): TDateTime;
function IsUSBPrinter(const Printername: string): boolean;
procedure PopulatePrintertypes(const Combo: TwwDBComboBox);
procedure ChangeCurrencyNameinRAdioGroup(Sender: TwwRadioGroup); overload;
procedure ChangeCurrencyNameinRAdioGroup(Sender: TRadioGroup); overload;
{ Multisite }



implementation

uses DBCGrids, StdCtrls,  ShellAPI, MMSystem, DecimalRounding,
  AuditTrailObj, MergeObj, QueryManipulationObj, OnGuard, CommonDBLib,
  tcDataUtils, AppEnvironment, tcConst, CommonLib,
  DataTreeBaseObj, CompanyPrefObj, EmployeeObj, ogutil, UtilsServerUtils,
  BusObjDeletedItem, MySQLConst, MySQLUtils, DateTimeUtils, ProgressInfoDlgObj,
  BusObjBase, SystemLib, PreferenceLib, PreferancesLib , DnMAction, UtilsLib,
  LogLib, utCloudconst;

const
  MAXSTRINGLEN = 255;

  StockCostSystemNo: TStockCostSystemInfo = (0, 1, 2);

  TranTypeClassName: TTranTypeInfo = ('TfrmLocation', 'TManifestVehicleGUI', 'TManifestRouteGUI', 'TManifestGUI', 'TfmSuppPayments', 'TfmCustPayments', 'TUnitsOfMeasureGUI',
    'TfrmParts', 'TfmEquip', 'TfrmToDo', 'TfrmRepServices', 'TfrmRep', 'TfrmPassword', 'TfrmEmployee', 'TfmSupplier', 'TfrmOtherContact', 'TJobGUI', 'TfrmCustomer',
    'TfrmCustomFields', 'TfmTerms', 'TfrmTaxcode', 'TfrmShipping', 'TForeignExchangeRateGUI', 'TfrmClass', 'TfrmChartOfAccounts', 'TCashSaleGUI', 'TRefundGUI', 'TPOSScreenForm', 'TBillGUI',
    'TCreditGUI', 'TfmCheque', 'TPurchaseGUI', 'TReturnAGUI', 'TSmartOrderGUI', 'TInvoiceGUI', 'TQuoteGUI', 'TSalesOrderGUI', 'TAppointmentGUI',
    'TJournalEntryGUI', 'TPhSupportLogGUI','TRepairsGUI', '');

  TranTypeDesc: TTranTypeInfo = ('Location', 'Manifest Vehicle', 'Manifest Route', 'Manifest', 'Supplier Payment', 'Customer Payment', 'Units Of Measure',
    'Product', 'Equipment', 'To Do', 'Rep Services', 'Rep', 'Passwords', 'Employee', 'Supplier', 'Other Contact', 'Job', 'Customer', 'Custom Fields', 'Terms', 'Tax Codes',
    'Shipping Methods', 'Foreign Exchange Rate', 'Class', 'Account', 'Cash Sale', 'Refund', 'POS', 'Bill', 'Credit', 'Cheque', 'Purchase Order', 'Return Authority', 'Smart Order', 'Invoice', 'Quote',
    'Sales Order', 'Appointment',
    'Journal Entry', 'Phone Support Log','Repairs', '');

  TranTypeMasterTable: TTranTypeInfo = ('tblLocations', 'tblmanifestvehicles', 'tblmanifestroutes', 'tblmanifest', 'tblwithdrawal', 'tbldeposits', 'tblunitsofmeasure',
    'tblparts', 'tblEquipment', 'tblToDo', 'tblServices', 'tblemployees', 'tblPassword', 'tblemployees', 'tblClients', 'tblClients', 'tblClients', 'tblClients',
    'tblcustomfields', 'tblTerms', 'tblTaxCodes', 'tblShippingMethods', 'tblcurrencyconversion', 'tblclass', 'tblChartofAccounts', 'tblSales', 'tblSales', 'tblSales', 'tblPurchaseOrders',
    'tblPurchaseOrders', 'tblPurchaseOrders', 'tblPurchaseOrders', 'tblPurchaseOrders', 'tblSmartOrder', 'tblSales', 'tblSales', 'tblSales', 'tblAppointments',
    'tblgeneraljournal', 'tblphonesupportlog', 'tblrepairs','');

  TranTypeDetailTable: TTranTypeInfo = ('', '', '', '', '', '', '',
     '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'tblSalesLines', 'tblSalesLines', 'tblSalesLines', 'tblPurchaseLines', 'tblPurchaseLines',
    'tblPurchaseLines', 'tblPurchaseLines', 'tblPurchaseLines', 'tblSmartOrderLines', 'tblSalesLines', 'tblSalesLines', 'tblSalesLines', 'tblequipmentxref',
    'tblgeneraljournaldetails', '', 'tblrepairparts','');

  TranTypeMasterPrimaryKeyID: TTranTypeInfo = ('LocationID', 'VehicleID', 'ManifestRouteID', 'ManifestID', 'PaymentID', 'PaymentID', 'UnitID',
    'PartsID', 'EquipmentID', 'ToDoID', 'ServiceID', 'EmployeeID', 'Pswd_ID', 'EmployeeID', 'ClientID', 'ClientID', 'ClientID', 'ClientID', 'ID', 'TermsID', 'TaxCodeID',
    'ShippingMethodID', 'CurrencyID', 'ClassID', 'AccountID', 'SaleID', 'SaleID', 'SaleID', 'PurchaseOrderID', 'PurchaseOrderID', 'PurchaseOrderID', 'PurchaseOrderID', 'PurchaseOrderID',
    'SmartOrderID', 'SaleID', 'SaleID', 'SaleID', 'AppointmentID',
    'GJID', 'SupportLogID','RepairID', '');

  TranTypeDetailPrimaryKeyID: TTranTypeInfo = ('', '', '', '', '', '', '',
    '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'SaleLineID', 'SaleLineID', 'SaleLineID', 'PurchaseLineID', 'PurchaseLineID', 'PurchaseLineID',
    'PurchaseLineID', 'PurchaseLineID', 'SmartOrderLinesID', 'SaleLineID', 'SaleLineID', 'SaleLineID', 'ID',
    'GJDID', '','RepairPartsID', '');


  // --------- Additional Form Modal Result Definitions ------------------------

  // mrOkClean = 100001; // User clicked OK, form data is clean
  mrOkDirty = 100002; // User clicked OK, form data is dirty

  mrCancelClean = 100010; // User clicked Cancel, form data is clean
  mrCancelDirty = 100011; // User clicked Cancel, form data is dirty

  TAG_DO_NOT_CHANGE = 1; // Set a TLabel's tag to this value if you do not wish
  // .. SetClassLabels to do its dirty deed on your label




  // Feed a string (s) and it returns date/time at the end of the string.
  // ** Is there a better way using TCaption?
function UserPreferenceOn(const LogchangingDetailson : TLogchangingDetailsonNoteFields):Boolean;
begin
         if LogchangingDetailson = lcdOnDoNotLog               then result := False
    else if LogchangingDetailson = lcdOnServicePadFeedback     then result := Appenv.CompanyPrefs.LogchangingDetailsonServicePadFeedback
    else if LogchangingDetailson = lcdOnRepairsFeedback        then result := Appenv.CompanyPrefs.LogchangingDetailsonRepairsFeedback
    else if LogchangingDetailson = lcdOnRepairsNotes           then result := Appenv.CompanyPrefs.LogchangingDetailsonRepairsNotes
    else if LogchangingDetailson = lcdOnSupportPricingNotes    then result := Appenv.CompanyPrefs.LogchangingDetailsonSupportPricingNotes
    else if LogchangingDetailson = lcdOnSupplierfollowupNotes  then result := Appenv.CompanyPrefs.LogchangingDetailsonSupplierfollowupNotes
    else if LogchangingDetailson = lcdOnchequecomments         then result := Appenv.CompanyPrefs.LogchangingDetailsonchequecomments
    else if LogchangingDetailson = lcdOnchequeInternalcomments then result := Appenv.CompanyPrefs.LogchangingDetailsonchequeInternalcomments
    else if LogchangingDetailson = lcdOnCustPayComments        then result := Appenv.CompanyPrefs.LogchangingDetailsonCustPayComments
    else if LogchangingDetailson = lcdOnDepositEntryNotes      then result := Appenv.CompanyPrefs.LogchangingDetailsonDepositEntryNotes
    else if LogchangingDetailson = lcdOnDepositNotes           then result := Appenv.CompanyPrefs.LogchangingDetailsonDepositNotes
    else if LogchangingDetailson = lcdOnSuppPayNotes           then result := Appenv.CompanyPrefs.LogchangingDetailsonSuppPayNotes
    else if LogchangingDetailson = lcdOnTimeSheetInvoiceNotes  then result := Appenv.CompanyPrefs.LogchangingDetailsonTimesheetInvoiceNotes
    else if LogchangingDetailson = lcdOnRepairNotes            then result := Appenv.CompanyPrefs.LogchangingDetailsonRepairNotes
    else if LogchangingDetailson = lcdOnRepairFeedbackNotes    then result := Appenv.CompanyPrefs.LogchangingDetailsonRepairFeedbackNotes
    else if LogchangingDetailson = lcdOnCashsAleComments       then result := Appenv.CompanyPrefs.LogchangingDetailsonCashsAleComments
    else if LogchangingDetailson = lcdOnCustomerfollowupNotes  then result := Appenv.CompanyPrefs.LogchangingDetailsonCustomerfollowupNotes
    else if LogchangingDetailson = lcdOnLoganyway              then result := True
    else Result := True;
end;
Procedure AddDateTime(const LogchangingDetailson : TLogchangingDetailsonNoteFields; memo :TDBMemo; AddEmpName:Boolean =False);
begin
  //memo.Lines.Strings[memo.Lines.Count - 1]:= AddDateTime(LogchangingDetailson , memo.Lines.Strings[memo.Lines.Count - 1] , AddEmpName);
  try EditDB(memo.DataSource.DataSet); except end;
  memo.Text := TRim(memo.text);
  memo.Lines.Add(AddDateTimeemp(LogchangingDetailson , memo.Lines.Strings[memo.Lines.Count - 1] , AddEmpName));
  try
    memo.Datasource.DataSet.FieldByName(memo.DataField).AsString := memo.Text;
    PostDB(memo.DataSource.DataSet);
  except end;
end;

function AddDateTime(const LogchangingDetailson : TLogchangingDetailsonNoteFields;const s: string; AddEmpName:Boolean =False): string;
begin
  result :=  s + AddDateTimeemp(LogchangingDetailson , s , AddEmpName);
end;
function AddDateTimeemp(const LogchangingDetailson : TLogchangingDetailsonNoteFields;const s: string; AddEmpName:Boolean =False): string;
begin
  result := '';
  if not(UserPreferenceOn(LogchangingDetailson)) then exit;
  if empty (s) then exit;
  //result := result +' : ' ;
  if AddEmpName then result := result +  result+ AppEnv.Employee.EmployeeName + ' - ';
  Result := result  + ' : ' + FormatDatetime('dd/mm/yyyy - hh:nn:ss AM/PM', now);

end;
(*function AddDateTimeLogin(const LogchangingDetailson : TLogchangingDetailsonNoteFields; const s: string): string;
begin
  result := s;
  if not(UserPreferenceOn(LogchangingDetailson)) then exit;
  if not Empty(s) then Result := s + ' : ' + AppEnv.Employee.FirstName + Chr(32) + AppEnv.Employee.LastName + ' - ' + FormatDatetime(ShortDateFormat + ' - hh:nn:ss AM/PM', now);

end;

function AddUserAndDateTime(const LogchangingDetailson : TLogchangingDetailsonNoteFields;const s: string): string;
begin
  result := s;
  if not(UserPreferenceOn(LogchangingDetailson)) then exit;
  if not Empty(s) then Result := s + ' : ' + AppEnv.Employee.EmployeeName + ' - ' + FormatDatetime(ShortDateFormat +' - hh:nn:ss AM/PM', now);
end;*)

// Feed a string (s) with the date and time gained from the function AddDateTime, then
// this function returns a string stripped of the date and time.
function StripDateTime(const s: string): string;
var
  t: string;
  iSpace, iCur, iColon, iDash, iSlash: integer;
begin
  t:='';
  try
  iColon := 0;
  iDash := 0;
  iSlash := 0;
  iSpace := 0;
  t := s;
  if ((not Empty(s)) and (char_length(s) >= 23)) and ((s[char_length(s)] = 'M') and CharInSet(s[char_length(s) - 1], ['A', 'P'])) then begin
    iCur := char_length(s);
    repeat
      case s[iCur] of
        ':': Inc(iColon);
        '-': Inc(iDash);
        '/': Inc(iSlash);
        ' ': Inc(iSpace);
      end;
      Dec(iCur);
    until (iCur = (char_length(s) - 25) or 0) or (iColon = 3);
    if iDash = 1 then
      if iSlash = 2 then
        if iColon >= 2 then
          if iSpace = 4 then
            if char_length(s) - iCur >= 23 then
              // It's most likely (make more accurate) date/time format, so remove it:
                Delete(t, iCur, (char_length(s) - iCur + 1));
  end;
  finally
    Result := trim(t);
  end;

end;

function HasBarTabsConvertStarted: boolean;
begin
  Result := AppEnv.CompanyPrefs.BarTabsConvertStarted;
end;

procedure SetBarTabsConvertStarted;
begin
  AppEnv.CompanyPrefs.BarTabsConvertStarted := true;
  PreferancesLib.DoPrefAuditTrail;
end;
procedure UnSetBarTabsConvertStarted;
begin
  AppEnv.CompanyPrefs.BarTabsConvertStarted := false;
  PreferancesLib.DoPrefAuditTrail;
end;

procedure updateDefaultCalss(const Defaultclass, sitecode, cleanDefaultclass: string; fconnection: TERPConnection);
var
  msg: string;
begin

  with TERPQuery.create(nil) do
    try
      Connection := fconnection;
      if sitecode <> '' then begin
        SQL.add('update tblmsbackendid ' + ' Set Sitecode = ' + quotedStr(sitecode) + ' where BEDefault =' + quotedStr('T') + ' and Sitecode <> ' + quotedStr(sitecode));
        Execute;
        SQL.clear;
      end;

      SQL.add('Select * from tblpartsclasspreferences where classname = ' + quotedStr(cleanDefaultclass));
      Open;
      if recordcount > 0 then begin
        first;
        while not eof do begin
          if not TDeletedItem.AddDeleted('tblpartsclasspreferences','',FieldByName('GlobalRef').AsString,FieldByName('ID').AsInteger, fConnection,msg,false) then begin
          end;
          Delete;
        end;
      end;
      close;
      SQL.clear;
      SQL.add('Select * from tblpartsclasspreferences where classname = ' + quotedStr(Defaultclass));
      Open;
      if recordcount = 0 then begin
        append;
        fieldbyname('className').asString := Defaultclass;
        fieldbyname('classID').asInteger := tcDataUtils.GetDeptID(Defaultclass);
        Post;
      end;
      Close;
      SQL.Clear;
      SQL.Add('update tblpartsclasspreferences set');
      SQL.Add('GlobalRef = CONCAT_WS("",' + QuotedStr(AppEnv.Branch.SiteCode) + ',Id)');
      SQL.Add(', msUpdateSiteCode = ' + QuotedStr(AppEnv.Branch.SiteCode));
      SQL.Add('Where IfNull(GlobalRef, "") = ""');
      Execute;
    finally
      if active then close;
      Free;
    end;
end;

procedure UpdateLatestCost(const PartsID: integer; const LatestCost: double; const LatestCostDate: TDateTime);
var
  qry: TERPCommand;
begin
  qry := TERPCommand.create(nil);
  qry.Connection := GetSharedMyDacConnection;
  try
    with qry do begin
      SQL.clear;
      SQL.add('UPDATE tblParts SET LatestCost = :xLatestCost ,LatestCostDate = :xLatestCostDate WHERE PARTSID= :xID;');
      Params.ParamByName('xLatestCost').AsFloat := LatestCost;
      Params.ParamByName('xLatestCostDate').AsDateTime := LatestCostDate;
      Params.ParamByName('xID').asInteger := PartsID;
      try Execute;
      except
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;


function IsNumeric(const s: string): boolean;
var
  num: extended;
begin
  Result := TryStrToFloat(s, num);
end;

function IsPrintable(const c: char): boolean;
begin
  if (c >= #32) and (c <= #127) then begin
    Result := true;
  end else begin
    Result := false;
  end;
end;

function IsInteger(const s: string): boolean;
var
  I, Code: integer;
begin
  Val(s, I, Code);
  if (I = 0) then;
  Result := (Code = 0);
end;

function DivZer(const x, y: extended): extended;
begin
  { return 0 if either value is 0 otherwise perform division }
  if (x = 0) or (y = 0) then Result := 0
  else Result := x / y;
end;

function EnCrypt(const Text: string; const KEY: string): string;
var
  I, j: integer;
begin
  Result := '';
  j := 1;
  for I := 1 to char_length(Text) do begin
    Result := Result + Chr(Ord(Text[I]) + Ord(KEY[j]) and 255);
    Inc(j);
    if j > char_length(KEY) then j := 1;
  end;
end;

function ReplaceStr(const sString, sOldStr, sNewStr: string): string;
begin
  Result := StringReplace(sString, sOldStr, sNewStr, [rfReplaceAll, rfIgnoreCase]);
end;

function StripSpaces(const sString: string): string;
begin
  Result := StringReplace(sString, ' ', '', [rfReplaceAll, rfIgnoreCase]);
end;

// function MysqlDateStrToDate(const MsqlDate: string): TDateTime;
// var
// Year1, Month1, Day1: word;
// Date1: TDateTime;
// begin
// Result := 0;
// Year1 := FastFuncs.StrToInt(ExtractStrPortion(MsqlDate, '-', 1));
// Month1 := FastFuncs.StrToInt(ExtractStrPortion(MsqlDate, '-', 2));
// Day1 := FastFuncs.StrToInt(ExtractStrPortion(MsqlDate, '-', 3));
// if TryEncodeDate(Year1, Month1, Day1, Date1) then begin
// Result := EncodeDate(Year1, Month1, Day1);
// end;
// end;

function GetPCName: string;
var
  Buffer: array [0 .. MAX_COMPUTERNAME_LENGTH] of char;
  nSize: cardinal;
begin
  nSize := SizeOf(Buffer);
  GetComputerName(Buffer, nSize);
  Result := Buffer;
end;

function GetPCNetworkName: string;
var
  dwI: DWord;
begin
  dwI := MAX_PATH;
  Setlength(Result, dwI + 1);
  if WNetGetUser(nil, PChar(Result), dwI) = NO_ERROR then Setlength(Result, SysUtils.StrLen(PChar(Result)))
  else Setlength(Result, 0);
end;

{ ----------------------------------------------------------------------------
  Function:    StrValue
  Description: Strip all non-numeric characters from a string and returns the
  value of the result string using StrToFloat. This function
  overcomes the problem of converting a formatted number in a
  string back into a value. For example, StrToFloat will raise an
  exception with the string '7.50%' because of the '%' character.
  This function will remove the '%' and then convert the string.
  Returns 0 if the string doesn't contain any numeric characters.
  Parameters:  <sValue> string to process
  Result:      <double> numeric value of processed string
  ---------------------------------------------------------------------------- }

function StrValue(const sValue: string): double;
var
  sTemp: string;
  bIsNeg: boolean;
  I: integer;
begin
  bIsNeg := (Pos('-', sValue) > 0) or (Pos('(', sValue) > 0);
  sTemp := '';
  for I := 1 to char_length(sValue) do
    if CharInSet(sValue[I], ['0' .. '9', FormatSettings.DecimalSeparator]) then sTemp := sTemp + sValue[I];
  if sTemp = '' then sTemp := '0';
  if bIsNeg then sTemp := '-' + sTemp;
  try Result := StrToFloat(sTemp);
  except Result := 0.00;
  end;
end;
function ValidDatabasename(const sValue: string): boolean;
begin
  REsult := False;
  if  sametext(sValue , ErpLanguageDBName) or
      sametext(sValue , ErpservicesDBName) or
      sametext(sValue , VS1ClientdbDBName) or
      sametext(sValue , erpdocumentationDBNAme) or
      sametext(sValue , InformationSchemaDBNAme) or
      sametext(sValue , erpnewdbDBNAme) or
      sametext(sValue , mysqlDBNAme) or
      sametext(sValue , ServerUpdatesDBNAme) then begin
      CommonLib.MessageDlgXP_Vista(svalue + ' is an ERP/MySQL Reserved Database. It is Not Possible to Create an ERP Database with This Name ', mtInformation, [mbOK], 0);
      Exit;
  end;
  Result := True;
end;
function ValidAlphaNumericCharacters(const sValue: string): boolean;
var
  iIndex: integer;
begin
  Result := true;
  for iIndex := 1 to char_length(sValue) do begin
    if not CharInSet(sValue[iIndex], ['a' .. 'z', 'A' .. 'Z', '0' .. '9', '_']) then begin
      Result := false;
      Break;
    end;
  end;
end;

function RemoveInvalidAlphaNumericCharacters(const sValue: string): string;
var
  iIndex: integer;
  sNewValue: string;
begin
  sNewValue := sValue;
  for iIndex := 1 to char_length(sValue) do begin
    if not CharInSet(sValue[iIndex], ['a' .. 'z', 'A' .. 'Z', '0' .. '9', '_']) then begin
      sNewValue := StringReplace(sNewValue, sValue[iIndex], '_', [rfReplaceAll, rfIgnoreCase]);
    end;
  end;
  Result := sNewValue;
end;

{ Use to insert a space between capitals or in the position of an underscore (_) }

function SeparateWords(const s: string): string;
var
  I: integer;
begin
  Result := s;
  I := 2;
  while I <= char_length(Result) do begin
    if CharInSet(Result[I - 1], ['a' .. 'z']) and CharInSet(Result[I], ['A' .. 'Z']) then Insert(' ', Result, I)
    else if Result[I] = '_' then Result[I] := ' ';

    { Cater For Multiple Capital then Lower eg. PONumer , ARNotes = PO Number , AR Notes }
    if CharInSet(Result[I - 1], ['A' .. 'Z']) and CharInSet(Result[I], ['A' .. 'Z']) and CharInSet(Result[I + 1], ['a' .. 'z']) then Insert(' ', Result, I)
    else if Result[I] = '_' then Result[I] := ' ';

    // 'ID' in the field name should be capitalised not 'Id'
    if I > 2 then begin
      if (Result[I - 2] = ' ') and (uppercase(Result[I]) = 'D') and (uppercase(Result[I - 1]) = 'I') and (I = char_length(Result)) then begin
        Result[I] := 'D';
        Result[I - 1] := 'I';
      end
      else if (Result[I - 2] = ' ') and (uppercase(Result[I]) = 'D') and (uppercase(Result[I - 1]) = 'I') and (Result[I + 1] = ' ') then begin
        Result[I] := 'D';
        Result[I - 1] := 'I';
      end;
    end;
    Inc(I);
  end;
end;

function CheckABN(const ABN: string): boolean;
var
  arrX: array [1 .. 11] of integer;
  arrY: array [1 .. 11] of integer;
  Remainder: extended;
begin
  arrY[1] := 10;
  arrY[2] := 1;
  arrY[3] := 3;
  arrY[4] := 5;
  arrY[5] := 7;
  arrY[6] := 9;
  arrY[7] := 11;
  arrY[8] := 13;
  arrY[9] := 15;
  arrY[10] := 17;
  arrY[11] := 19;
  arrX[1] := StrToInt(MidStr(ABN, 1, 1));
  arrX[2] := StrToInt(MidStr(ABN, 2, 1));
  arrX[3] := StrToInt(MidStr(ABN, 3, 1));
  arrX[4] := StrToInt(MidStr(ABN, 4, 1));
  arrX[5] := StrToInt(MidStr(ABN, 5, 1));
  arrX[6] := StrToInt(MidStr(ABN, 6, 1));
  arrX[7] := StrToInt(MidStr(ABN, 7, 1));
  arrX[8] := StrToInt(MidStr(ABN, 8, 1));
  arrX[9] := StrToInt(MidStr(ABN, 9, 1));
  arrX[10] := StrToInt(MidStr(ABN, 10, 1));
  arrX[11] := StrToInt(MidStr(ABN, 11, 1));
  Remainder := ((arrY[1] * arrX[1]) + (arrY[2] * arrX[2]) + (arrY[3] * arrX[3]) + (arrY[4] * arrX[4]) + (arrY[5] * arrX[5]) + (arrY[6] * arrX[6]) + (arrY[7] * arrX[7]) + (arrY[8] * arrX[8]) +
    (arrY[9] * arrX[9]) + (arrY[10] * arrX[10]) + (arrY[11] * arrX[11])) mod 89;
  if Remainder = 0 then Result := true
  else Result := false;
end;

procedure ClearTList(const lst: TList; const iSize: integer);
var
  I: integer;
  p: Pointer;
begin
  { don't try if lst = nil otherwise GPF }
  if lst <> nil then begin
    for I := 0 to lst.Count - 1 do begin
      p := lst.Items[I];
      if iSize > 0 then MFree(p, iSize)
      else Dispose(p);
    end;
    lst.clear;
  end;
end;

procedure MFree(var p: Pointer; const lSize: longint);
begin
  if lSize < 65528 then FreeMem(p, word(lSize))
  else GlobalFreePtr(p);
  p := nil;
end;

// function WinDir: string;
// var
// acDir: array[0..MAXSTRINGLEN] of char;
// begin
// GetWindowsDirectory(acDir, SizeOf(acDir));
// Result := StrPas(acDir);
// end;

// function SysDir: string;
// var
// acDir: array[0..MAXSTRINGLEN] of char;
// begin
// GetSystemDirectory(acDir, SizeOf(acDir));
// Result := StrPas(acDir);
// end;

// function TempDir: string;
// var
// acDir: array[0..MAX_PATH] of char;
// begin
// GetTempPath(SizeOf(acDir), acDir);
// Result := StrPas(acDir);
// end;


function IsDir(const DirPath: string): boolean;
begin
  Result := DirectoryExists(DirPath);
end;

function WinExecAndWait(const FileName: string; const Visibility: integer): longword;
var
  zAppName: array [0 .. 512] of char;
  zCurDir: array [0 .. 255] of char;
  WorkDir: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  dwResult: DWord;
begin
  StrPCopy(zAppName, FileName);
  GetDir(0, WorkDir);
  StrPCopy(zCurDir, WorkDir);
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := Visibility;
  if not CreateProcess(nil, zAppName, nil, nil, false, CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInfo) then Result := WAIT_FAILED
  else begin
    while true do begin
      // Application.ProcessMessages;
      dwResult := WaitforSingleObject(ProcessInfo.hProcess, 1000); // wait for 1 second
      if dwResult = WAIT_OBJECT_0 then begin
        GetExitCodeProcess(ProcessInfo.hProcess, Result);
        CloseHandle(ProcessInfo.hProcess);
        CloseHandle(ProcessInfo.hThread);
        Break;
      end;
    end;
  end;
end;

function ChangeFormCaption(const NewValue, OldValue: string): string;
var
  IntPos: integer;
begin
  IntPos := Pos('-', OldValue);
  if IntPos > 0 then Result := NewValue + ' ' + Copy(OldValue, IntPos, char_length(OldValue))
  else Result := NewValue;
end;

procedure CopyProductTableRecords(const PartsID, NewPartsID: integer; const SQLText: string;
  const qrySource, qryDestination: TERPQuery; ExcludeList: TStrings;
  const OrderBy: string = ''; NewProduct: TProduct = nil);
var
  CurrID: integer;
  BaseID: integer;
begin

  if (PartsID > 0) and (NewPartsID > 0) and Assigned(qrySource) and Assigned(qryDestination) and Assigned(ExcludeList) then begin
    qrySource.SQL.Text := SQLText + IntToStr(PartsID);
    qrySource.Open;

    if not qrySource.IsEmpty then begin
      qryDestination.SQL.Text := SQLText + IntToStr(NewPartsID);
      if OrderBy <> '' then
        qryDestination.SQL.Add(OrderBy);
      qryDestination.Open;
      qrySource.First;

      while not qrySource.Eof do begin
        try
              qryDestination.append;
              CopyTableRecord(qrySource, qryDestination, ExcludeList);

                   if qryDestination.FindField('PartsID') <> nil then qryDestination.fieldbyname('PartsID').asInteger := NewPartsID
              else if qryDestination.FindField('PartID') <> nil then qryDestination.fieldbyname('PartID').asInteger := NewPartsID
              else if qryDestination.FindField('GroupProductID') <> nil then qryDestination.fieldbyname('GroupProductID').asInteger := NewPartsID
              else if qryDestination.FindField('ParentID') <> nil then qryDestination.fieldbyname('ParentID').asInteger := NewPartsID
              else if qryDestination.FindField('ProductID') <> nil then qryDestination.fieldbyname('ProductID').asInteger := NewPartsID;


              if qryDestination.FindField('BaseUnitName') <> nil then begin
                if qrySource.FieldByName('BaseUnitName').AsString = '' then
                  qryDestination.fieldbyname('BaseUnitID').AsInteger := 0
                else begin
                  { need to find base UOM }
                 qryDestination.Post;
                 currID := qryDestination.FieldByName('UnitID').AsInteger;
                 if qryDestination.Locate('UnitName',qrySource.FieldByName('BaseUnitName').AsString,[]) then begin
                   BaseID := qryDestination.FieldByName('UnitID').AsInteger;
                   if qryDestination.Locate('UnitId',CurrID,[]) then begin
                     qryDestination.Edit;
                     qryDestination.fieldbyname('BaseUnitID').AsInteger := BaseID;
                   end;
                 end;
                end;
              end;
              if Assigned(NewProduct) then begin
                if (qryDestination.FindField('Productname') <> nil) then begin
                    qryDestination.FieldByName('Productname').asString := NewProduct.Productname;
                end;
                if (qryDestination.FindField('Partname') <> nil) then begin
                    qryDestination.FieldByName('Partname').asString := NewProduct.Productname;
                end;
                if (qryDestination.FindField('Partsname') <> nil) then begin
                    qryDestination.FieldByName('Partsname').asString := NewProduct.Productname;
                end;
              end;
              if (qryDestination.FindField('UOM') <> nil) and (qryDestination.FindField('UOMID') <> nil) then begin
                if Assigned(NewProduct) then begin
                  if NewProduct.ProductUOMLocate(qrySource.FieldByName('UOM').AsString) then
                    qryDestination.FieldByName('UOMID').AsInteger := NewProduct.UOMList.ID;
                end;
              end;
              if qryDestination.FindField('UnitProductKeyName')<> nil then begin
                editdb(qryDestination);
                qryDestination.Fieldbyname('UnitProductKeyName').asString := trim(qryDestination.Fieldbyname('UnitName').asString)+':' + TProduct.IdToggle(NewPartsID, qryDestination.Connection);
              end;


              if qryDestination.State in [dsEdit, dsInsert] then
                qryDestination.Post;
        Except
          on E:Exception do begin
            // ignore the error
          end;
        end;
        qrySource.Next;
      end;

      qryDestination.close;
    end;

    qrySource.close;
  end;
end;

function DuplicatePart(const PartsID: integer; const Connection: TCustomMyConnection): integer;
var
  index: integer;
  NewPartsID: integer;
  qrySource: TERPQuery;
  qryDestination: TERPQuery;
  ExcludeList: TStringList;
  NewProduct: TProduct;
begin
  Result := 0;

  if (PartsID > 0) and Assigned(Connection) then begin
    qrySource := TERPQuery.create(nil);
    qryDestination := TERPQuery.create(nil);
    ExcludeList := TStringList.create;

    try
      qrySource.Connection := Connection;
      qrySource.SQL.Text := 'SELECT * FROM tblparts WHERE PartsID = ' + IntToStr(PartsID);
      qrySource.Open;

      if not qrySource.IsEmpty then begin
        qryDestination.Connection := Connection;
        qryDestination.SQL.Text := 'SELECT * FROM tblparts WHERE PartsID = 0';// + IntToStr(PartsID);
        qryDestination.Open;
        qryDestination.append;

        for index := 0 to qrySource.FieldCount - 1 do begin
          if (not SysUtils.SameText(qrySource.Fields[index].FieldName, 'GlobalRef')) and (not SysUtils.SameText(qrySource.Fields[index].FieldName, 'PartsID')) and
            (not SysUtils.SameText(qrySource.Fields[index].FieldName, 'ProductCode')) and (not SysUtils.SameText(qrySource.Fields[index].FieldName, 'Barcode')) and
            (not SysUtils.SameText(qrySource.Fields[index].FieldName, 'PartCalcformulaUOM')) and (not SysUtils.SameText(qrySource.Fields[index].FieldName, 'PartCalcformulaUOMID')) and (not SysUtils.SameText(qrySource.Fields[index].FieldName, 'PartCalcformulaUOMMult')) and
            (not SysUtils.SameText(qrySource.Fields[index].FieldName, 'PartName')) then begin
            qryDestination.Fields[index].Value := qrySource.Fields[index].Value;
          end;
        end;
        qryDestination.fieldbyname('DateCreated').AsDateTime := now;
        qrySource.close;
        qryDestination.Post;
        NewPartsID := qryDestination.fieldbyname('PartsID').asInteger;
        Result := NewPartsID;
        if qryDestination.fieldbyname('PartCalcformula').asString <> '' then begin
           EditDB(qryDestination);
           qryDestination.FieldByname('PartCalcformulaUOM').asSTring := AppEnv.DefaultClass.DefaultUOM;
           qryDestination.FieldByname('PartCalcformulaUOMID').asInteger := GetUnitOfMeasureID(0, AppEnv.DefaultClass.DefaultUOM , 1);
           qryDestination.FieldByname('PartCalcformulaUOMMult').asFloat:= 1;
           PostDB(qryDestination);
        end;
        qryDestination.close;

        (*ExcludeList.clear;
        ExcludeList.add('GlobalRef');
        ExcludeList.add('PartID');
        ExcludeList.add('BaseUnitID');
        ExcludeList.add('UnitID');
        CopyProductTableRecords(PartsID, NewPartsID, 'SELECT * FROM tblunitsofmeasure WHERE PartID = ', qrySource, qryDestination, ExcludeList, 'order by BaseUnitName');*)

        NewProduct:= TProduct.Create(nil);
        try
          NewProduct.Connection := TMyDacDataConnection.Create(NewProduct);
          NewProduct.Connection.Connection := Connection;
          NewProduct.Load(NewPartsID);

          (*
          // UOM is created in Parts form after save
          NewProduct.Connection.beginnestedtransaction;
          try
            ExcludeList.clear;
            ExcludeList.add('GlobalRef');
            ExcludeList.add('PartID');
            ExcludeList.add('BaseUnitID');
            ExcludeList.add('UnitID');
            CopyProductTableRecords(PartsID, NewPartsID, 'SELECT * FROM tblunitsofmeasure WHERE PartID = ', qrySource, qryDestination, ExcludeList, 'order by BaseUnitName');
          Except
            on E:EXception do begin
              NewProduct.Connection.Rollbacknestedtransaction;
            end;
          end;*)
          (*
          // Product class is created in Parts form after save
          NewProduct.Connection.beginnestedtransaction;
          try
              ExcludeList.clear;
              ExcludeList.add('GlobalRef');
              ExcludeList.add('ProductID');
              ExcludeList.add('ID');
              ExcludeList.add('Productname');
              CopyProductTableRecords(PartsID, NewPartsID, 'SELECT * FROM tblproductclasses WHERE ProductID = ', qrySource, qryDestination, ExcludeList,'',NewProduct);
          Except
            on E:EXception do begin
              NewProduct.Connection.Rollbacknestedtransaction;
            end;
          end;*)

          NewProduct.Connection.beginnestedtransaction;
          try
              ExcludeList.clear;
              ExcludeList.add('GlobalRef');
              ExcludeList.add('PartsID');
              ExcludeList.add('UOMID');
              ExcludeList.add('ExtraPartPriceID');
              CopyProductTableRecords(PartsID, NewPartsID, 'SELECT * FROM tblextraprice WHERE PartsID = ', qrySource, qryDestination, ExcludeList,'',NewProduct);
          Except
            on E:EXception do begin
              NewProduct.Connection.Rollbacknestedtransaction;
            end;
          end;


          NewProduct.Connection.beginnestedtransaction;
          try
              ExcludeList.clear;
              ExcludeList.add('GlobalRef');
              ExcludeList.add('PartsID');
              ExcludeList.add('UOMID');
              ExcludeList.add('PriceID');
              CopyProductTableRecords(PartsID, NewPartsID, 'SELECT * FROM tblextrapricesell WHERE PartsID = ', qrySource, qryDestination, ExcludeList,'',NewProduct);
          Except
            on E:EXception do begin
              NewProduct.Connection.Rollbacknestedtransaction;
            end;
          end;

          NewProduct.Connection.beginnestedtransaction;
          try
              ExcludeList.clear;
              ExcludeList.add('GlobalRef');
              ExcludeList.add('PartsID');
              ExcludeList.add('UOMID');
              ExcludeList.add('ForeignPriceID');
              CopyProductTableRecords(PartsID, NewPartsID, 'SELECT * FROM tblforeignprice WHERE PartsID = ', qrySource, qryDestination, ExcludeList,'',NewProduct);
          Except
            on E:EXception do begin
              NewProduct.Connection.Rollbacknestedtransaction;
            end;
          end;

          NewProduct.Connection.beginnestedtransaction;
          try
              ExcludeList.clear;
              ExcludeList.add('GlobalRef');
              ExcludeList.add('RelatedID');
              ExcludeList.add('ParentID');
              CopyProductTableRecords(PartsID, NewPartsID, 'SELECT * FROM tblrelatedparts WHERE ParentID = ', qrySource, qryDestination, ExcludeList,'',NewProduct);
          Except
            on E:EXception do begin
              NewProduct.Connection.Rollbacknestedtransaction;
            end;
          end;
        finally
          NewProduct.Free;
        end;
      end;
    finally
      FreeAndNil(qrySource);
      FreeAndNil(qryDestination);
      FreeAndNil(ExcludeList);
    end;
  end;
end;

procedure CopyTableRecord(const qrySource, qryDestination: TERPQuery; ExcludeList: TStrings);
var
  ListIndex: integer;
  FieldIndex: integer;
  ExcludeField: boolean;
begin
  if Assigned(qrySource) and Assigned(qryDestination) and Assigned(ExcludeList) then begin
    for FieldIndex := 0 to qrySource.FieldCount - 1 do begin
      ExcludeField := false;
      ListIndex := 0;

      while (ListIndex < ExcludeList.Count) and (ExcludeField = false) do begin
        if SysUtils.SameText(ExcludeList[ListIndex], qrySource.Fields[FieldIndex].FieldName) then ExcludeField := true
        else Inc(ListIndex);
      end;

      if not ExcludeField then qryDestination.Fields[FieldIndex].Value := qrySource.Fields[FieldIndex].Value;
    end;
  end;
end;

// procedure SaveFieldPrefs(const GuiPrefs: TFormGuiPrefs);
// var
// Index: Integer;
// DataSet: TDataSet;
// FieldIndex: Integer;
// FieldName: string;
// begin
// exit;
// if Assigned(GuiPrefs) then
// begin
// for Index := 0 to GuiPrefs.Elements.Count - 1 do
// begin
// if GuiPrefs.Elements[Index] is TwwDbGridGuiElement then
// begin
// if Assigned(GuiPrefs.Elements[Index].Target) and
// Assigned(TwwDBGrid(GuiPrefs.Elements[Index].Target).DataSource) then
// begin
// GuiPrefs.Elements[Index].Node.ItemByName['GridFields'].CData :=
// TwwDBGrid(GuiPrefs.Elements[Index].Target).Selected.Text;
//
/// /          DataSet := TwwDBGrid(GuiPrefs.Elements[Index].Target).DataSource.DataSet;
/// /
/// /          if Assigned(DataSet) then
/// /          begin
/// /            FieldIndex := 0;
/// /            while FieldIndex < DataSet.FieldCount do
/// /            begin
/// /              FieldName := DataSet.Fields[FieldIndex].FieldName;
/// /
/// /              if (not DataSet.Fields[FieldIndex].Visible) and
/// /                 TwwDbGridGuiElement(GuiPrefs.Elements[Index]).Columns[FieldName + '.Hidden'].AsBoolean then
/// /              begin
/// /                GuiPrefs.HideField(FieldName, DataSet);
/// /              end;
/// /              Inc(FieldIndex);
/// /            end;
/// /          end;
// end;
//
// TwwDbGridGuiElement(GuiPrefs.Elements[Index]).GetColumnSettings;
// end;
// end;
//
// GuiPrefs.SavePrefs;
// end;
// end;

procedure SetClassLabels(const Form: TForm);
var
  I, iIndex: integer;
  s: string;
begin
  for I := 0 to Form.ComponentCount - 1 do begin
    if (Form.Components[I] is TLabel) then begin
      if TLabel(Form.Components[I]).Tag <> TAG_DO_NOT_CHANGE then begin
        if Pos(uppercase('class'), uppercase(TLabel(Form.Components[I]).Caption)) > 0 then begin
          TLabel(Form.Components[I]).AutoSize := true;
          TLabel(Form.Components[I]).Caption := StringReplace(TLabel(Form.Components[I]).Caption, 'Class', AppEnv.Defaultclass.ClassHeading, [rfReplaceAll, rfIgnoreCase]);
        end;
      end;
    end else if (Form.Components[I] is TwwDBGrid) then begin
      with (Form.Components[I] as TwwDBGrid) do begin
        if (TwwDBGrid(Form.Components[I]).datasource <> nil) and (TwwDBGrid(Form.Components[I]).datasource.DataSet.FieldCount > 0) then
          // dynamic Grids will not have the fields in form show. eg: budget
          if TwwDBGrid(Form.Components[I]).Tag <> TAG_DO_NOT_CHANGE then begin
            for iIndex := 0 to TwwDBGrid(Form.Components[I]).GetColCount - 1 do begin
              with TwwDBGrid(Form.Components[I]).Columns[iIndex] do begin { change the display label for "Class" }
                if Pos(uppercase('Class'), uppercase(DisplayLabel)) > 0 then begin
                  s := StringReplace(DisplayLabel, 'Class', AppEnv.Defaultclass.ClassHeading, [rfReplaceAll, rfIgnoreCase]);
                  DisplayLabel := s;
                end;
              end;
            end;
          end;
      end;
    end else if (Form.Components[I] is TwwCheckBox) then begin
      with (Form.Components[I] as TwwCheckBox) do begin
        if TwwCheckBox(Form.Components[I]).Tag <> TAG_DO_NOT_CHANGE then begin
          s := StringReplace(Caption, 'Class', AppEnv.Defaultclass.ClassHeading, [rfReplaceAll, rfIgnoreCase]);
          Caption := s;
        end;
      end;
    end else if (Form.Components[I] is TDnMAction) then begin
      with (Form.Components[I] as TDnMAction) do begin
        if TDnMAction(Form.Components[I]).Tag <> TAG_DO_NOT_CHANGE then begin
          s := StringReplace(Caption, 'Class', AppEnv.Defaultclass.ClassHeading, [rfReplaceAll, rfIgnoreCase]);
          Caption := s;
        end;
      end;
    end;
  end;
end;

procedure WinExec(const FileName: string; const Visibility: integer);
var
  zAppName: array [0 .. 512] of char;
  zCurDir: array [0 .. 255] of char;
  WorkDir: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  StrPCopy(zAppName, FileName);
  GetDir(0, WorkDir);
  StrPCopy(zCurDir, WorkDir);
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := Visibility;
  CreateProcess(nil, zAppName, nil, nil, false, CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInfo);
end;

procedure DeleteRecursiveFiles(const dir: string);
var
  TempDIR: string;
var
  t: TSHFileOpStruct;
  p_from: PChar;
begin
  TempDIR := dir;
  p_from := StrAlloc(500);
  if TempDIR[char_length(TempDIR)] <> '\' then TempDIR := TempDIR + '\';
  TempDIR := TempDIR + '*.*';
  StrPCopy(p_from, TempDIR);
  t.Wnd := 0;
  t.wFunc := FO_DELETE;
  t.pfrom := p_from;
  t.pto := nil;
  t.fFlags := FOF_ALLOWUNDO or FOF_FILESONLY or FOF_SILENT or FOF_NOCONFIRMATION;
  SHFileOperation(t);
  StrDispose(p_from);
end;

{ Example Usage
  Path = c:\Temp\  Mask=*.tmp }
procedure DeleteMultipleFiles(const Path, filenames:String);
var
  st:TStringlist;
  ctr:Integer;
begin
  if filenames = '' then exit;
  st:= TStringlist.Create;
  Try
    st.CommaText := Filenames;
    if st.Count =0 then exit;
    for ctr := 0 to st.Count-1 do Deletefiles(path , st[ctr]);
  Finally
    Freeandnil(st);
  End;

end;
procedure DeleteFiles(const Path, Mask: string);
var
  lpFileOp: TSHFileOpStruct;
begin
  FillChar(lpFileOp, SizeOf(lpFileOp), #0);
  lpFileOp.wFunc := FO_DELETE;
  // The + #0 is required
  lpFileOp.pfrom := PChar(Path + Mask + #0);
  lpFileOp.pto := PChar(Path);
  lpFileOp.fFlags := FOF_NOCONFIRMATION or FOF_FILESONLY or FOF_SILENT;
  // Perform Operation
  if (SHFileOperation(lpFileOp) <> 0) then Exit;
end;

//function GetFileVersion(const FileName: string): string;
//var
//  VersionInfoSize, VersionInfoValueSize, Zero: DWord;
//  VersionInfo, VersionInfoValue: Pointer;
//begin
//  Result := '';
//  VersionInfoSize := GetFileVersionInfoSize(PChar(FileName), Zero);
//  if VersionInfoSize = 0 then Exit;
//  GetMem(VersionInfo, VersionInfoSize);
//  try
//    if GetFileVersionInfo(PChar(FileName), 0, VersionInfoSize, VersionInfo) and VerQueryValue(VersionInfo, '\', VersionInfoValue, VersionInfoValueSize) and (0 <> longint(VersionInfoValueSize)) then
//    begin
//      with TVSFixedFileInfo(VersionInfoValue^) do begin
//        Result := IntToStr(HiWord(dwFileVersionMS));
//        Result := Result + '.' + IntToStr(LoWord(dwFileVersionMS));
//        Result := Result + '.' + IntToStr(HiWord(dwFileVersionLS));
//        Result := Result + '.' + IntToStr(LoWord(dwFileVersionLS));
//      end;
//    end;
//  finally FreeMem(VersionInfo);
//  end;
//end;

function GetMysqlServerVersion: string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      close;
      SQL.clear;
      SQL.add('SELECT VERSION() as Version;');
      Open;
      if not IsEmpty then begin
        Result := fieldbyname('Version').asString;
      end
    end;
  finally FreeAndNil(qry);
  end;
end;

function GetServersUserVersion(Connection: TERPConnection): string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := Connection;
  qry.ParamCheck := false;
  try
    with qry do begin
      close;
      SQL.clear;
      SQL.add('SELECT ID,UserVersion FROM tblupdatedetails WHERE ID=1;');
      Open;
      if not IsEmpty then begin
        Result := fieldbyname('UserVersion').asString;
      end
    end;
  finally FreeAndNil(qry);
  end;
end;



function RoundQty(const Value: double): double;
begin
  try Result := DecimalRoundDbl(Value, 5, drHalfUp);
  except Result := 0.00000;
  end;
end;

function RoundCurrency(const Value: double): currency;
begin
  try Result := DecimalRoundDbl(Value, CurrencyRoundPlaces, drHalfUp);
  except Result := 0.00;
  end;
end;

function RoundTo5C(const rMoney: currency(*; const iUpDownValue: double*)): currency;
// Rounds money to the closest 5 cents according to iUpDownValue
var
  iUnitCents: integer;
  bIsNeg: boolean;
  rAmount,firem: currency;
  //iLot: integer;
  RoundLotsof: integer;
  RoundPlaces: integer;
  Multiplier: integer;
  iUpDownValue: double;

  x: integer;
begin


  RoundPlaces:= CurrencyRoundPlaces;
  bIsNeg := false;
  rAmount := round(rMoney, RoundPlaces);
  if rAmount < 0.0 then begin
    bIsNeg := true;
    rAmount := -rAmount;
  end;
  Multiplier:= 1;
  for x := 1 to RoundPlaces do
    Multiplier:= Multiplier * 10;  { ie: 100 for 2 places, 1000 for 3 places }
  iUpDownValue:= AppEnv.CompanyPrefs.RoundUp; if iUpDownValue =0 then iUpDownValue := 2.5;
  RoundLotsof := System.round(AppEnv.CompanyPrefs.RoundLotsof) ;// System.round(AppEnv.CompanyPrefs.RoundLotsof * Multiplier);
{----}if AppEnv.CompanyPrefs.RoundLotsnRoundup then begin
      result:=  Trunc(rAmount*Multiplier)/Multiplier ;
      firem := Trunc(round(Frac(result)*Multiplier,0));
      result:= Trunc(result);
      iUnitCents := Trunc(firem /RoundLotsof) * RoundLotsof;
      firem :=firem  - iUnitCents;
      if firem >= iUpDownValue then iUnitCents := iUnitCents +RoundLotsof;
      result:= result + (iUnitCents /  Multiplier);
  end else begin
    result := rAmount;
(*{----}end else if AppEnv.CompanyPrefs.Roundup5Cents then begin
    iUnitCents := System.Round(Frac((rAmount * Multiplier) / 10) * 10);
    if iUnitCents <= 5 then begin
      if iUnitCents < iUpDownValue then iUnitCents := 0
      else iUnitCents := 5;
    end else begin
      if iUnitCents < iUpDownValue + 5 then iUnitCents := 5
      else iUnitCents := 10;
    end;
    Result := (Int(rAmount * (Multiplier/10)) / (Multiplier/10)) + (iUnitCents / Multiplier); // extract the number of cents
{----}end else begin
    iUnitCents := System.round(Frac(rAmount) * Multiplier);
    iLot := 0;
    while iUnitCents > RoundLotsof do begin
      iLot := iLot + RoundLotsof;
      iUnitCents := iUnitCents - RoundLotsof;
    end;

    if iUnitCents > 0 then iUnitCents := RoundLotsof;
    iUnitCents := iUnitCents + iLot;
    Result := (Int(rAmount) * Multiplier + iUnitCents) / Multiplier;*)
{----}end;
      if bIsNeg then Result := -Result;
end;

{ ds must NOT have lockType ltBatchOptimistic!
  function returns id of newly created record
  ( -- if autoKeyField was set }

{ ML - Note - The clone doesn't keep the fields in the order of the original,
  therefore we can no longer map fields for [i] to [i] }

{ ML - Clone an entire dataset. The method returns an array of Integers (The new AutoKey IDs) that you
  can evaluate to update necessary records . This method is ideal for copying
  multiple records from a Detail table. The cloned records will be the same as the originals with the
  exception of the AutoNumber field }
{ ML - Note - The clone doesn't keep the fields in the order of the original,
  therefore we can no longer map fields for [i] to [i] }

function CloneRecord(const dsSrc: TCustomMyDataset; const autoKeyField: string): integer;
var
  dsDst: TCustomMyDataset;
  index: integer;
begin
  Result := 0;
  dsDst := TCustomMyDataset.create(nil);

  try
    if Assigned(dsSrc) and Assigned(dsDst) then begin
      dsDst.Connection := dsSrc.Connection;
      dsDst.ParamCheck := dsSrc.ParamCheck;
      dsDst.SQL.Text := dsSrc.SQL.Text;
      dsDst.Open;
      dsDst.append;

      for index := 0 to dsSrc.FieldCount - 1 do begin
        if (dsSrc.Fields[index].FieldKind = fkData) and (not SysUtils.SameText(dsSrc.Fields[index].FieldName, autoKeyField)) and
        (not SysUtils.SameText(dsSrc.Fields[index].FieldName, 'msTimeStamp')) and
        (not SysUtils.SameText(dsSrc.Fields[index].FieldName, 'globalref')) and
        (not SysUtils.SameText(dsSrc.Fields[index].FieldName, autoKeyField)) then begin
          if dsDst.fieldbyname(dsSrc.Fields[index].FieldName).Value <> dsSrc.Fields[index].Value then dsDst.fieldbyname(dsSrc.Fields[index].FieldName).Value := dsSrc.Fields[index].Value;
        end;
      end;

      dsDst.Post;

      if Trim(autoKeyField) <> '' then Result := dsDst.fieldbyname(autoKeyField).asInteger;
    end;
  finally FreeAndNil(dsDst);
  end;
end;

function CloneRecords(const dsSrc: TCustomMyDataset; const autoKeyField: string): TClonedRecords;
var
  index, Count, recordcount: integer;
  dsDst: TCustomMyDataset;
  DoUpdateCloneFieldFromId: boolean;
begin
  Result := nil;
  dsDst := TCustomMyDataset.create(nil);

  try
    if Assigned(dsSrc) and Assigned(dsDst) then begin
      dsDst.Connection := dsSrc.Connection;
      dsDst.ParamCheck := dsSrc.ParamCheck;
      dsDst.SQL.Text := dsSrc.SQL.Text;
      dsDst.Open;
      dsDst.First;

      Setlength(Result, dsSrc.recordcount);
      recordcount := dsSrc.recordcount;
      dsSrc.First;
      DoUpdateCloneFieldFromId := ((dsDst.FindField('ClonedFromId') <> nil) and (dsDst.FindField(autoKeyField) <> nil));

      for Count := 0 to recordcount - 1 do begin
        dsDst.append;

        for index := 0 to dsSrc.FieldCount - 1 do begin
          if (dsSrc.Fields[index].FieldKind = fkData) and (not SysUtils.SameText(dsSrc.Fields[index].FieldName, autoKeyField)) then begin
            // dsDst.Fields[Index].Value := dsSrc.Fields[Index].Value;
            if dsDst.fieldbyname(dsSrc.Fields[index].FieldName).Value <> dsSrc.Fields[index].Value then dsDst.fieldbyname(dsSrc.Fields[index].FieldName).Value := dsSrc.Fields[index].Value;

          end;
        end;

        if DoUpdateCloneFieldFromId then dsDst.fieldbyname('ClonedFromId').asInteger := dsSrc.fieldbyname(autoKeyField).asInteger;

        dsDst.Post;

        if Trim(autoKeyField) <> '' then Result[Count] := dsDst.fieldbyname(autoKeyField).asInteger
        else Result[Count] := 0;

        dsSrc.Next;
      end;
    end;
  finally FreeAndNil(dsDst);
  end;
end;

function TypeToDescription(const TranType: TTranType): string;
begin
  Result := TranTypeDesc[TranType];
end;

function ClassNameToTranType(const ClassName: string): TTranType;
var
  I: TTranType;
begin
  Result := ttNone;
  for I := low(TTranType) to high(TTranType) do begin
    if ClassName = TranTypeClassName[I] then begin
      Result := I;
      Break;
    end;
  end;
end;

function GetStockCostSystem(const No: integer): TStockCostSystem;
var
  I: TStockCostSystem;
begin
  Result := scsAvg;
  for I := low(TStockCostSystem) to high(TStockCostSystem) do begin
    if No = StockCostSystemNo[I] then begin
      Result := I;
      Break;
    end;
  end;
end;


function TypeToDetailTableName(const TranType: TTranType): string;
begin
  Result := TranTypeDetailTable[TranType];
end;

function TypeToMasterPKName(const TranType: TTranType): string;
begin
  Result := TranTypeMasterPrimaryKeyID[TranType];
end;

function TypeToDetailPKName(const TranType: TTranType): string;
begin
  Result := TranTypeDetailPrimaryKeyID[TranType];
end;

{ MoneyWords - Converts money to words for (say) cheque printing
  This function was stolen from a turkish freedom fighter (who pened it
  whilst crossing the amwah desert on his faithfull camel shitawah).
  It has been prettied up to include punctuation and to remove the
  Turkish options etc. }

function MoneyWords(const dValue: double): string;
var
  ayNumWords: array [1 .. 3, 1 .. 9] of string[12];
  ayHundGrps: array [1 .. 5] of string[3];
  DecimalStr, sCents: string[20];
  Ps: longint;
  R_Ok: boolean;
  Hundred, Ten, One: integer;
  ExitNumStr: string;
  Neg: boolean;
  Value: double;

  function NumString(const Number: real; const Width, Decimals: byte): string;
  var
    St: shortstring;
  begin
    Str(Number: Width: Decimals, St);
    Result := string(St);
  end;

  function DelSpaces(const St: string; const Ch: char): string;
  var
    K: integer;
  begin
    Result := '';
    for K := 1 to char_length(St) do begin
      if (St[K] <> Ch) and (St[K] <> #0) then begin
        Result := Result + St[K];
      end;
    end;
  end;

  function RightSpaces(const St: string; const Width: integer; const Ch: char): string;
  var
    K: integer;
    tmpSt: string;
  begin
    tmpSt := St;
    for K := 1 to Width - char_length(tmpSt) do begin
      tmpSt := Ch + tmpSt;
    end;
    Result := tmpSt;
  end;

begin // MoneyWords

  if dValue < 0 then begin
    Value := dValue * -1;
    Neg := true;
  end else begin
    Value := dValue;
    Neg := false;
  end;

  ayNumWords[1, 1] := 'One';
  ayNumWords[2, 1] := 'Ten';
  ayNumWords[3, 1] := 'Eleven';
  ayNumWords[1, 2] := 'Two';
  ayNumWords[2, 2] := 'Twenty';
  ayNumWords[3, 2] := 'Twelve';
  ayNumWords[1, 3] := 'Three';
  ayNumWords[2, 3] := 'Thirty';
  ayNumWords[3, 3] := 'Thirteen';
  ayNumWords[1, 4] := 'Four';
  ayNumWords[2, 4] := 'Forty';
  ayNumWords[3, 4] := 'Fourteen';
  ayNumWords[1, 5] := 'Five';
  ayNumWords[2, 5] := 'Fifty';
  ayNumWords[3, 5] := 'Fifteen';
  ayNumWords[1, 6] := 'Six';
  ayNumWords[2, 6] := 'Sixty';
  ayNumWords[3, 6] := 'Sixteen';
  ayNumWords[1, 7] := 'Seven';
  ayNumWords[2, 7] := 'Seventy';
  ayNumWords[3, 7] := 'Seventeen';
  ayNumWords[1, 8] := 'Eight';
  ayNumWords[2, 8] := 'Eighty';
  ayNumWords[3, 8] := 'Eighteen';
  ayNumWords[1, 9] := 'Nine';
  ayNumWords[2, 9] := 'Ninety';
  ayNumWords[3, 9] := 'Nineteen';

  // Load string version of number to convert
{$WARNINGS off}
  DecimalStr := DelSpaces(NumString(Value, 15, 2), #32);
{$WARNINGS on}
  // Remove cents
  Ps := Pos('.', string(DecimalStr));
  if Ps > 0 then begin
    sCents := Copy(DecimalStr, Ps + 1, 5);
    DecimalStr := Copy(DecimalStr, 1, Ps - 1);
    if sCents = '00' then begin
      sCents := '';
    end;
  end else begin
    sCents := '';
  end;

{$WARNINGS off}
  DecimalStr := RightSpaces(string(DecimalStr), 12, '0');
{$WARNINGS on}
  ExitNumStr := '';

  // group into hundreds
  ayHundGrps[1] := Copy(DecimalStr, 1, 3);
  ayHundGrps[2] := Copy(DecimalStr, 4, 3);
  ayHundGrps[3] := Copy(DecimalStr, 7, 3);
  ayHundGrps[4] := Copy(DecimalStr, 10, 3);

  Ps := 1;
  R_Ok := true;

  while R_Ok do begin
    case Ps of
      1: ayHundGrps[5] := ayHundGrps[1];
      2: ayHundGrps[5] := ayHundGrps[2];
      3: ayHundGrps[5] := ayHundGrps[3];
      4: ayHundGrps[5] := ayHundGrps[4];
    end;

    if ayHundGrps[5] <> '000' then begin
      // extract each digit of the hundred group
      Hundred := StrToInt(Copy(string(ayHundGrps[5]), 1, 1));
      Ten := StrToInt(Copy(string(ayHundGrps[5]), 2, 1));
      One := StrToInt(Copy(string(ayHundGrps[5]), 3, 1));
      if Hundred > 0 then begin
        ExitNumStr := ExitNumStr + string(ayNumWords[1, Hundred]) + ' Hundred '; // ayNumWords[3,Hundred];
        if (Ten > 0) or (One > 0) then ExitNumStr := ExitNumStr + 'and ';
      end;

      if (Ten = 1) and (One > 0) then begin
        ExitNumStr := ExitNumStr + string(ayNumWords[3, One]) + ' ';
      end else begin
        if Ten > 0 then ExitNumStr := ExitNumStr + string(ayNumWords[2, Ten]) + ' ';
        if One > 0 then ExitNumStr := ExitNumStr + string(ayNumWords[1, One]) + ' ';
      end;
      case Ps of
        1: ExitNumStr := ExitNumStr + 'Billion, ';
        2: ExitNumStr := ExitNumStr + 'Million, ';
        3: ExitNumStr := ExitNumStr + 'Thousand, ';
      end;
    end;
    Ps := Ps + 1;
    if Ps > 4 then R_Ok := false;
  end;
  if char_length(ExitNumStr) > 0 then begin
    ExitNumStr := ExitNumStr + AppEnv.RegionalOptions.WholeCurrencyName;
  end;
  if length(sCents) > 0 then begin
    if char_length(ExitNumStr) > 0 then begin
      ExitNumStr := ExitNumStr + ' and ';
    end;
    if AppEnv.RegionalOptions.MoneyWordsShowsDecimalCurrencyName then
      ExitNumStr := ExitNumStr + string(sCents) + ' ' +AppEnv.RegionalOptions.DecimalCurrencyName
    else
      ExitNumStr := ExitNumStr + string(sCents) + '/' + floatTostr(Math.IntPower(10,AppEnv.RegionalOptions.DecimalPlaces));
  end;
  Result := ExitNumStr;

  if Neg then begin
    Result := 'Negitive(-) ' + Result;
  end;

  if char_length(Result) = 0 then Result := ' ';
end;

{ CMessageDlg allows custom button text (up to 3 buttons) }

function CMessageDlg(const Msg: string; const DlgType: TMsgDlgType; const btn1, btn2, btn3: string): string;
var
  frmMsg: TForm;
  I: integer;
begin
  if btn3 <> '' then frmMsg := CreateMessageDialog(Msg, DlgType, [mbYes, mbOK, mbCancel])
  else if btn2 <> '' then frmMsg := CreateMessageDialog(Msg, DlgType, [mbYes, mbOK])
  else frmMsg := CreateMessageDialog(Msg, DlgType, [mbYes]);
  try
    with frmMsg do begin
      for I := 0 to ComponentCount - 1 do
        if Components[I] is TButton then begin
          if Pos('Yes', TDNMSpeedButton(Components[I]).Caption) > 0 then TButton(Components[I]).Caption := btn1
          else if Pos('OK', TDNMSpeedButton(Components[I]).Caption) > 0 then TButton(Components[I]).Caption := btn2
          else if Pos('Cancel', TDNMSpeedButton(Components[I]).Caption) > 0 then TButton(Components[I]).Caption := btn3;
        end;
      ShowModal;
      if ModalResult = mrYes then Result := btn1
      else if ModalResult = mrOk then Result := btn2
      else Result := btn3;
    end;
  finally FreeAndNil(frmMsg);
  end;
end; // CMessageDlg

procedure EnablePanel(const pnl: TPanel; const bState: boolean; const bRecursive: boolean = true);
// EnablePanel - Enables/Disables the components on a panel according to theb value
// .. of bState.  If bRecursive is set to true then the operation will be applied to
// .. any panels contained in the panel.
var
  I: integer;
begin
  pnl.Enabled := bState;
  for I := 0 to pnl.ControlCount - 1 do begin
    if (pnl.Controls[I] is TControl) then begin
      TControl(pnl.Controls[I]).Enabled := bState;
      if bRecursive and (pnl.Controls[I] is TPanel) then begin
        EnablePanel(TPanel(pnl.Controls[I]), bState);
      end;
    end;
  end;
end;

function GetControl(const sName: string; const pnl: TPanel): TControl;
{ returns the  Control which exists on the Panel 'pnl' and of name 'sName' }
var
  I: integer;
begin
  Result := nil;
  for I := 0 to pnl.ControlCount - 1 do begin
    if sName = pnl.Controls[I].Name then begin
      Result := pnl.Controls[I];
      Break;
    end;
  end;
end;


// Enable's/Disables TwwDBGrid (chages colour too)

procedure EnableGrid(const grd: TwwDBGrid; const bState: boolean);
begin
  if bState then begin
    grd.Enabled := true;
    grd.Font.Color := clWindowText;
    grd.TitleFont.Color := clWindowText;
  end else begin
    grd.Enabled := false;
    grd.Font.Color := clSilver;
    grd.TitleFont.Color := clSilver;
  end;
end;

procedure LoadEditedFlagMemTable(const DiskQry: TDataSet; const MemQry: TkbmMemTable);
var
  I: integer;
begin;

  // EDITED FLAG - Copies ALL fields and data to memory table
  try
    MemQry.close;
    MemQry.EmptyTable;
    try
      MemQry.LoadFromDataSet(DiskQry, [mtcpoStructure, mtcpoProperties]);
    Except
      on E:Exception do begin
        logtext('MemQry.LoadFromDataSet error :' + e.message);
      end;
    end;

    for I := 0 to MemQry.FieldCount - 1 do begin;
      MemQry.Fields[I].ReadOnly := false;
    end;

    MemQry.Open;
  Except
    on E:Exception do begin
        logtext('LoadEditedFlagMemTable Error :' + e.message);
    end;
  end;
end;

procedure ProcessEditedFlag(const DataDescription: string; const FromForm: TForm; const OldValues, NewValues, Master: TDataSet; const DoPost: boolean = false);
var
  LookForIndex, NumOfField, GridLine: integer;
  DiffText: TStringList;
  TempLine: string;
  IDField: string;
  TransGlobalref: string;
  ExceptionFlag: boolean;
  OldField: TField;
  NewField: TField;
  fld: TField;
  bmOldField: TBookMark;
  bmNewField: TBookMark;
  Connection: TERPConnection;
begin;
  // ------ Locate index field for table/query
  for LookForIndex := 0 to NewValues.Fields.Count - 1 do begin;
    // if NewValues.Fields[LookForIndex].DataType = ftAutoInc then begin
    if NewValues.Fields[LookForIndex].AutoGenerateValue = arAutoInc then begin
      IDField := NewValues.Fields[LookForIndex].FieldName;
      Break;
    end;
  end;
  // ------
  if not NewValues.active then NewValues.Open;
  bmNewField := NewValues.GetBookmark;
  NewValues.DisableControls;
  if not OldValues.active then OldValues.Open;
  bmOldField := OldValues.GetBookmark;
  OldValues.DisableControls;
  DiffText := TStringList.create;
  Connection := nil;

  try
    if not AppEnv.CompanyPrefs.UseAuditTrail then Exit;

    OldValues.First;
    NewValues.First;

    for GridLine := 0 to NewValues.recordcount - 1 do begin;
      if OldValues.Locate(IDField, NewValues.fieldbyname(IDField).asString, [loCaseInsensitive]) then begin
        for NumOfField := 0 to NewValues.FieldCount - 1 do begin
          NewField := NewValues.Fields[NumOfField];
          try
            if (NewField.FieldKind = fkData) and (OldValues.fieldbyname(NewField.FieldName).AsVariant <> NewField.AsVariant) then begin
              OldField := OldValues.fieldbyname(NewField.FieldName);
              ExceptionFlag := false;
              if (TypeToDescription(ClassNameToTranType(FromForm.ClassName)) = 'Company Preferences') and ((OldField.FieldName = 'StartOfDay') or (OldField.FieldName = 'EndOfDay')) and
                (FormatDatetime('hh:mm AM/PM', OldField.AsDateTime) = FormatDatetime('hh:mm AM/PM', NewField.AsDateTime)) then begin
                ExceptionFlag := true;
              end;
              if not ExceptionFlag then begin
                // Add Difference To Audit Trail Strings
                TempLine := '';
                if (DataDescription <> 'Main') then begin
                  TempLine := 'Record No = ' + IntToStr(GridLine + 1) + '   ,';
                end;

                if (TypeToDescription(ClassNameToTranType(FromForm.ClassName)) = 'Company Preferences') and ((OldField.FieldName = 'StartOfDay') or (OldField.FieldName = 'EndOfDay')) then begin
                  TempLine := TempLine + OldField.FieldName + AuditTrialOldValue + FormatDatetime('hh:mm AM/PM', OldField.AsDateTime) + '   ' + AuditTrialNewValue +
                    FormatDatetime('hh:mm AM/PM', NewField.AsDateTime) + ';';
                end else begin;
                  TempLine := TempLine + OldField.FieldName + AuditTrialOldValue + VartoWideStr(OldField.AsVariant) + '   ' + AuditTrialNewValue +
                    VartoWideStr(NewField.AsVariant) + ';';
                end;

                DiffText.add(TempLine);
              end;
            end;
          except
            on E: exception do begin
              raise exception.create('ProcessEditedFlag Exception: ' + E.ClassName + ' Field: ' + NewField.FieldName + ' Dataset: ' + NewValues.Name + ' Message: ' + E.Message);
            end;
          end;
        end;
      end else begin
        // Added Lines To Audit Trail Strings
        TempLine := '';
        if (DataDescription <> 'Main') then begin
          TempLine := 'Record No = ' + IntToStr(GridLine + 1) + '   ,';
        end;

        for NumOfField := 0 to NewValues.FieldCount - 1 do begin
          NewField := NewValues.Fields[NumOfField];
          try
            if (NewField.FieldKind = fkData) then begin
              ExceptionFlag := false;
              if (TypeToDescription(ClassNameToTranType(FromForm.ClassName)) = 'Company Preferences') and ((NEwField.FieldName = 'StartOfDay') or (NEwField.FieldName = 'EndOfDay')) and
                (FormatDatetime('hh:mm AM/PM', NEWField.AsDateTime) = FormatDatetime('hh:mm AM/PM', NewField.AsDateTime)) then begin
                ExceptionFlag := true;
              end;
              if not ExceptionFlag then begin
                TempLine := '';
                if (DataDescription <> 'Main') then TempLine := 'Record No = ' + IntToStr(GridLine + 1) + '   ,';

                if (TypeToDescription(ClassNameToTranType(FromForm.ClassName)) = 'Company Preferences') and ((NEwField.FieldName = 'StartOfDay') or (NEwField.FieldName = 'EndOfDay')) then begin
                  TempLine := TempLine + NEwField.FieldName + AuditTrialOldValue+AuditTrialNewValue +
                    FormatDatetime('hh:mm AM/PM', NewField.AsDateTime) + ';';
                end else begin;
                  TempLine := TempLine + NewField.FieldName + AuditTrialOldValue+AuditTrialNewValue +
                    VartoWideStr(NewField.AsVariant) + ';';
                end;

                DiffText.add(TempLine);
              end;
            end;
          except
            on E: exception do begin
              raise exception.create('ProcessEditedFlag Exception: ' + E.ClassName + ' Field: ' + NewField.FieldName + ' Dataset: ' + NewValues.Name + ' Message: ' + E.Message);
            end;
          end;
        end;
        DiffText.add(TempLine);
      end;
      NewValues.Next;
    end;

    // Delete Lines To Audit Trail Strings
    OldValues.First;
    NewValues.First;
    for GridLine := 0 to OldValues.recordcount - 1 do begin;
      if not NewValues.Locate(IDField, OldValues.fieldbyname(IDField).asString, [loCaseInsensitive]) then begin
        TempLine := '';
        if (DataDescription <> 'Main') then begin
          TempLine := 'Old Record No = ' + IntToStr(GridLine + 1) + '   ,';
        end;
        TempLine := TempLine + 'Entire Line Deleted;';
        DiffText.add(TempLine);
      end;
      OldValues.Next;
    end;
    if not Empty(DiffText.Text) then begin
      AuditTrail := TAuditTrailObj.create;
      try
        if (ClassNameToTranType(FromForm.ClassName) <> ttNone) then begin
          try
            fld := NewValues.FindField('Globalref');
            if Assigned(fld) then TransGlobalref := fld.asString
            else TransGlobalref := '';
          except Exit;
          end;
          if NewValues is TCustomMyDataset then Connection := TERPConnection(TCustomMyDataset(NewValues).Connection);
          AuditTrail.AddEntry(DataDescription, TransGlobalref, DiffText, FromForm, Connection, OldValues.recordcount=0);
        end;
      finally FreeAndNil(AuditTrail);
      end;
    end;

    if (Master <> nil) and (Master.recordcount<>0) then Master.Edit;
  finally
    if (NewValues <> nil) and (NewValues.recordcount <> 0) then begin
      NewValues.Edit;
      NewValues.EnableControls;
      NewValues.GotoBookmark(bmNewField);
      NewValues.FreeBookmark(bmNewField);
    end;
    if (OldValues <> nil) and (OldValues.recordcount <> 0) then begin
      OldValues.EnableControls;
      OldValues.GotoBookmark(bmOldField);
      OldValues.FreeBookmark(bmOldField);
    end;
    FreeAndNil(DiffText);
  end;
end;

function IsModified(const OldValues: TDataSet; const NewValues: TCustomMyDataset): boolean;
var
  LookForIndex, NumOfField: integer;
  IDField: string;
begin;
  if (not NewValues.active) or (not OldValues.active) then begin
    Result := false;
    Exit;
  end;

  if not NewValues.Connection.InTransaction then begin
    // If dataset is NOT in transaction the we must address the problem differenctly
    // .. because the First and Next statements bellow will POST and this is probably
    // .. not a desired result.
    Result := NewValues.Modified; // this is probably enough
    Exit;
  end;

  // check if record has been added or removed
  if OldValues.recordcount <> NewValues.recordcount then begin
    Result := true;
    Exit;
  end;

  Result := false;

  // Locate index field for table/query
  for LookForIndex := 0 to NewValues.Fields.Count - 1 do begin;
    // if NewValues.Fields[LookForIndex].DataType = ftAutoInc then begin
    if NewValues.Fields[LookForIndex].AutoGenerateValue = arAutoInc then begin
      IDField := NewValues.Fields[LookForIndex].FieldName;
      Break;
    end;
  end;

  NewValues.Open;
  NewValues.DisableControls;
  OldValues.Open;
  OldValues.DisableControls;

  try

    if OldValues.recordcount = 0 then Exit; // New Record Trap;
    if NewValues.recordcount = 0 then Exit; // New Record Trap;

    OldValues.First;
    if FirstNoAbort(NewValues) then begin
      while not NewValues.Eof do begin;
        OldValues.First;

        // try to matchup the record in the oldvalues and newvalues
        while (not OldValues.Eof) and (OldValues.fieldbyname(IDField).asString <> NewValues.fieldbyname(IDField).asString) do begin;
          OldValues.Next;
        end;

        // for NumOfField := 0 to OldValues.FieldCount-1 do begin
        // if NewValues.FieldByName(OldValues.Fields[NumOfField].FieldName).AsVariant <>
        // OldValues.Fields[NumOfField].AsVariant then begin
        // result := true;
        // EXIT;
        // end;
        for NumOfField := 0 to NewValues.FieldCount - 1 do begin
          if (NewValues.Fields[NumOfField].FieldKind = fkData) and (OldValues.fieldbyname(NewValues.Fields[NumOfField].FieldName).AsVariant <> NewValues.Fields[NumOfField].AsVariant) then begin
            Result := true;
            Exit;
          end;
        end;

        NewValues.Next;
        OldValues.Next;
      end;
    end;
  finally
    NewValues.EnableControls;
    OldValues.EnableControls;
  end;
end;

function GetTaxRate(const iProductID: integer): double;
var
  qryTemp: TERPQuery;
begin
  Result := 0;
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT PARTSID, TaxCode FROM tblparts WHERE PARTSID = ' + IntToStr(iProductID) + ';');
    qryTemp.Open;
    if not qryTemp.IsEmpty then begin
      Result := GetTaxRate(qryTemp.fieldbyname('TaxCode').asString);
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetTaxRate(const sTaxCode: string): double;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      SQL.clear;
      SQL.add('SELECT Rate FROM tblTaxCodes WHERE Name = ' + quotedStr(sTaxCode) + ' AND RegionID=' + IntToStr(AppEnv.RegionalOptions.ID) + ';');
      Open;
      if not IsEmpty then begin
        Result := fieldbyname('Rate').AsFloat;
      end else begin
        Result := 0.0;
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

procedure GetCredit(const iClientID: integer; var rLimit: currency; var rBalance: currency);
var
  qry: TERPQuery;
begin
  rBalance := 0.0;
  rLimit := 0.0;
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      SQL.clear;
      SQL.add('SELECT CreditLimit, Balance, SOBalance ');
      SQL.add('FROM tblClients where ClientID =' + IntToStr(iClientID) + ';');
      Open;
      if not IsEmpty then begin
        rLimit := fieldbyname('CreditLimit').AsCurrency;
        rBalance := fieldbyname('Balance').AsCurrency;
        if AppEnv.CompanyPrefs.CreditCheckSO then begin
          rBalance := rBalance + fieldbyname('SOBalance').AsCurrency;
        end;
      end else begin
        CommonLib.MessageDlgXP_Vista('Cannot find Client''s Credit Limit', mtWarning, [mbOK], 0);
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

function IsCreditOK(const iClientID: integer; const bVerbose: boolean = true): boolean;
var
  rLimit: currency;
  rBalance: currency;
begin
  GetCredit(iClientID, rLimit, rBalance);
  if rLimit <= rBalance then begin
    if bVerbose then begin
      CommonLib.MessageDlgXP_Vista('Customer has Exceeded Credit Limit'#13 + 'Limit: ' + CurrToStrF(rLimit, ffCurrency, 2) + '   Amount: ' + CurrToStrF(rBalance, ffCurrency, 2), mtWarning, [mbOK], 0);
    end;
    Result := false;
  end else begin
    Result := true;
  end;
end;

function IsStopCredit(const iClientID: integer): boolean;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.add('SELECT C.ClientID AS ClientID,IF(C.IsJob = "T",C2.StopCredit,C.StopCredit)  AS StopCredit ');
    qryTemp.SQL.add('FROM tblClients C LEFT JOIN tblClients as C2 on C.ParentClientID = C2.ClientID ');
    qryTemp.SQL.add('WHERE char_length(C.Company)>0 AND C.ClientID=' + IntToStr(iClientID) + ';');
    try
      qryTemp.Open;
      if not qryTemp.IsEmpty then begin
        if (qryTemp.fieldbyname('StopCredit').asString = 'T') then begin
          Result := true;
        end else begin
          Result := false;
        end;
      end else begin
        Result := false;
      end;
    except Result := false;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function IsTermsOK(const iClientID: integer; const bVerbose: boolean = true): boolean;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      SQL.clear;

      SQL.add('SELECT SaleID, DueDate, GracePeriod, Paid, ' + 'tblSales.Balance, TotalAmountInc ' + 'FROM tblSales INNER JOIN tblClients ' + 'ON tblSales.ClientID = tblClients.ClientID ' +
        'WHERE tblSales.ClientID = ' + IntToStr(iClientID) + ' AND IsInvoice = "T" AND ' + 'Paid <> "T" AND TotalAmountInc > 0.00 AND tblSales.Balance > 0.0 AND ' +
        'CURDATE() > Date_add(DueDate  , INTERVAL  GracePeriod DAY) ORDER BY DueDate ');
      Open;
      if not IsEmpty then begin
        // There are overdues
        First;
        if bVerbose then begin
          CommonLib.MessageDlgXP_Vista('Customer has exceeded Terms on previous Sale#' + IntToStr(fieldbyname('SaleID').asInteger) + #13#10 + 'Date Due: ' + fieldbyname('DueDate').asString, mtWarning,
            [mbOK], 0);
        end;
        Result := false;
      end else begin
        Result := true;
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

function Local_To_ForeignCurrency(const Amount: double; const Rate: double): double;
begin
  Result := RoundCurrency(Amount * Rate);
end;

function Local_To_ForeignCurrency(const Amount: double; const Rate: double; const Decimals: integer): double; overload;
begin
  Result := DecimalRoundDbl(Amount * Rate, Decimals, drHalfUp);
end;

function ForeignCurrency_To_AUD(const ForeignAmount: double; const Rate: double): double;
begin
  Result := RoundCurrency(ForeignAmount * DivZer(1, Rate));
end;

procedure UnlockTables;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.create(nil);
  qryTemp.Connection := GetSharedMyDacConnection;
  try
    qryTemp.SQL.add('UNLOCK TABLES;');
    qryTemp.Execute;
  finally FreeAndNil(qryTemp);
  end;
end;

function ServerIsActive: boolean;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.add('SELECT * FROM tblability;');
    try
      qryTemp.Open;
      Result := true;
    except
      // Silent Server Has Gone Away error !!
        Result := false;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function IsTransTableEmpty: boolean;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.add('SELECT Count(TransID) as Count FROM `tbltransactions`;');
    qryTemp.active := true;
    if (qryTemp.fieldbyname('Count').asInteger > 0) and (not IsBatchInProgress) then begin
      Result := false;
    end else begin
      Result := true;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

procedure ResetBalances;
var
  MergeObj: TMergeObj;
begin
  // Balances
  if not IsTransTableEmpty then begin
    MergeObj := TMergeObj.Create;
//    MergeObj.Connection := CommonDbLib.GetSharedMyDacConnection;
    Processingcursor(True);
    try
      MergeObj.ClientBalanceVerify;
      MergeObj.AccountBalanceVerify;
    finally
      FreeAndNil(MergeObj);
      Processingcursor(False);
    end;
  end;
end;

function IsThisTransactionInUse(const ADOQuery: TERPQuery; const KeyID: integer; const Connection: TCustomMyConnection): boolean;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Connection := Connection;
  try
    Result := false;
    if KeyID = 0 then Exit;
    qryTemp.SQL.Text := ReplaceStr(ADOQuery.SQL.Text, ';', '') + ' For Update';
    qryTemp.ParamByName('ID').asInteger := KeyID;
    try qryTemp.Open;
    except
      on E: EMyError do Result := true;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function DefaultAwardExists: boolean;
var
  qry: TERPQuery;
begin
  Result := false;
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      close;
      SQL.clear;
      SQL.add('SELECT AwardName FROM tblAwards ' + 'WHERE AwardName = "Default"');
      Open;
      if not IsEmpty then begin
        Result := true;
      end
    end;
  finally FreeAndNil(qry);
  end;
end;

procedure DeleteRecord(const dst: TDataSet);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try dst.Delete;
    except
      { Do nothing - raise a silent exception }
    end;
  end;
end;

function MinsToStr(const iMins: integer): string;
var
  iHrs, iRemainingMins: integer;
begin
  iHrs := iMins div 60;
  iRemainingMins := iMins mod 60;
  Result := IntToStr(iRemainingMins) + ' mins';
  if iHrs > 0 then begin
    Result := IntToStr(iHrs) + ' hrs ' + Result;
  end;
end;

function GetAccountID(const AccountName: string): integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      SQL.clear;
      SQL.add('SELECT AccountID FROM tblchartofaccounts Where AccountName  = ' + quotedStr(AccountName) + ';');
      Open;
      if not recordcount <> 0 then begin
        Result := qry.fieldbyname('AccountID').asInteger;
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

function GetMysqlTablePrimaryKey(const TableName: string): string;
var
  HasGlobalRef: boolean;
begin
  Result := MySQLUtils.MySQLTablePrimaryKey(TableName, CommonDBLib.GetSharedMyDacConnection,HasGlobalRef);
end;

function GetAccountType(const AccountID: integer): string;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    qry.SQL.add('SELECT AccountID,AccountType FROM tblchartofaccounts Where AccountID = ' + IntToStr(AccountID) + ';');
    qry.active := true;
    if not qry.IsEmpty then begin
      Result := qry.fieldbyname('AccountType').asString;
    end else begin
      Result := '';
    end;
  finally FreeAndNil(qry);
  end;
end;

function GetTerms(const TermsID: integer): string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      SQL.clear;
      SQL.add('SELECT TermsID,Terms FROM tblterms WHERE TermsID = ' + IntToStr(TermsID) + ';');
      Open;
      if not IsEmpty then begin
        Result := fieldbyname('Terms').asString;
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

function GetEmployeeID(const EmployeeName: string): integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      SQL.clear;
      SQL.add('SELECT EmployeeID,EmployeeName FROM tblemployees WHERE EmployeeName = ' + quotedStr(EmployeeName) + ';');
      Open;
      if not IsEmpty then begin
        Result := fieldbyname('EmployeeID').asInteger;
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

function GetFormDescription(const FormName: string): string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      SQL.clear;
      SQL.add('SELECT FormID,Description FROM tblforms WHERE FormName = ' + quotedStr(FormName) + ';');
      Open;
      if not IsEmpty then begin
        Result := fieldbyname('Description').asString;
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

function GetTermsID(const Terms: string): integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      SQL.clear;
      SQL.add('SELECT TermsID,Terms FROM tblterms WHERE Terms = ' + quotedStr(Terms) + ';');
      Open;
      if not IsEmpty then begin
        Result := fieldbyname('TermsID').asInteger;
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

function GetClientsTermsID(const iClientID: integer): integer;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      SQL.clear;
      SQL.add('SELECT ClientID,TermsID FROM tblClients WHERE ClientID = ' + IntToStr(iClientID) + ';');
      Open;
      if not IsEmpty then begin
        Result := fieldbyname('TermsID').asInteger;
        if (Result = 0) then Result := GetTermsID('Prepayment');
      end else begin
        Result := GetTermsID('Prepayment');
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

function GetClientIDFromCard(const sCardNumber: string): integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      SQL.clear;
      SQL.add('SELECT ClientID  FROM tblClients WHERE Active = "T" AND CardNumber = ' + quotedStr(sCardNumber) + ' ');
      SQL.add('UNION ALL');
      SQL.add('SELECT tblContacts.ClientID  FROM tblContacts INNER JOIN tblClients on tblContacts.ClientID = tblClients.ClientID ' +
        'WHERE tblClients.Active= "T" AND tblContacts.CardNumber = ' + quotedStr(sCardNumber) + ';');
      Open;
      if not IsEmpty then begin
        Result := fieldbyname('ClientID').asInteger;
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

function GetClientIDFromPrepayment(const iPrePaymentID: integer): integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  try
    qry.Connection := GetSharedMyDacConnection;
    qry.ParamCheck := false;
    with qry do begin
      SQL.clear;
      SQL.add('SELECT PrePaymentID,ClientID FROM tblprepayments WHERE PrePaymentID = ' + IntToStr(iPrePaymentID) + ';');
      Open;
      if not IsEmpty then begin
        Result := fieldbyname('ClientID').asInteger;
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

function GetClientIDFromSale(const iSaleID: integer): integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  try
    qry.Connection := GetSharedMyDacConnection;
    qry.ParamCheck := false;
    with qry do begin
      SQL.clear;
      SQL.add('SELECT SaleID,ClientID FROM tblsales WHERE SaleID = ' + IntToStr(iSaleID) + ';');
      Open;
      if not IsEmpty then begin
        Result := fieldbyname('ClientID').asInteger;
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

function GetClientIDFromAccount(const sAccountNo: string): integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      SQL.clear;
      SQL.add('SELECT ClientID  FROM tblClients WHERE Not IsNull(Company) AND (char_length(Company)>0) AND Active = "T" AND ClientNo = ' + quotedStr(sAccountNo) + ' ');
      SQL.add('UNION ALL');
      SQL.add('SELECT ClientID  FROM tblContacts WHERE Not IsNull(Company) AND (char_length(Company)>0) AND Active = "T" AND AccountNo = ' + quotedStr(sAccountNo) + ';');
      Open;
      if not IsEmpty then begin
        Result := fieldbyname('ClientID').asInteger;
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

function GetJobParentID(const iClientID: integer): integer;
{ Returns a parent ID for the client specified.  Note that if this client has no
  parent then the original clientid is returned }
var
  qry: TERPQuery;
begin
  Result := iClientID;
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      SQL.clear;
      SQL.add('SELECT ParentClientID FROM tblClients WHERE ClientID = ' + IntToStr(iClientID) + ';');
      Open;
      if not IsEmpty then begin
        Result := fieldbyname('ParentClientID').asInteger;
      end;
      if Result = 0 then begin
        Result := iClientID;
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

function GetAccountGroup(const iAccountID: integer): string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      // Account table
      SQL.clear;
      SQL.add('SELECT AccountID,AccountGroup FROM tblChartOfAccounts WHERE AccountID = ' + IntToStr(iAccountID) + ';');
      Open;
      if not IsEmpty then begin
        Result := fieldbyname('AccountGroup').asString;
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

function GetEmployeeName(const iEmployeeID: integer): string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      SQL.clear;
      SQL.add('SELECT EmployeeID,FirstName,LastName FROM tblEmployees WHERE EmployeeID = ' + IntToStr(iEmployeeID) + ';');
      Open;
      if not IsEmpty then begin
        Result := fieldbyname('FirstName').asString + ' ' + fieldbyname('LastName').asString;
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

function GetEmployeeClass(const iEmployeeID: integer): integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      SQL.clear;
      SQL.add('SELECT EmployeeID, DefaultClassID FROM tblEmployees WHERE EmployeeID = ' + IntToStr(iEmployeeID) + ';');
      Open;
      if fieldbyname('DefaultClassID').asInteger > 0 then Result := fieldbyname('DefaultClassID').asInteger;
    end;
  finally FreeAndNil(qry);
  end;
end;
function GoogleModuleInstalled:boolean;
begin
  result := ModuleInstalled(appenv.AppDb.Server , 'GoogleAnalytics');
end;
function HasHireAccess: boolean;
begin
  Result := (AppEnv.CompanyPrefs.UseHire )
end;

function HasPayrollAccess: boolean;
begin
  Result := (AppEnv.CompanyPrefs.UsePayroll and AppEnv.Employee.PayrollAccess)
end;

function GetLaybyBal(const iSaleID: integer; const dTotalAmountInc: currency): currency;
// retrieves the current layby balance for this sale from the individual layby payments
var
  qryPayments: TERPQuery;
begin
  Result := dTotalAmountInc;
  qryPayments := TERPQuery.create(nil);
  qryPayments.Options.FlatBuffers := true;
  qryPayments.Connection := GetSharedMyDacConnection;
  qryPayments.ParamCheck := false;
  try
    with qryPayments do begin
      close;
      SQL.clear;
      SQL.add('SELECT LaybyID, SUM(TotalLineAmountInc) as TotalPayments ' + 'FROM tblsaleslines ' + 'WHERE LaybyID = ' + quotedStr(GetSaleGlobalRef(iSaleID)) +
        ' AND Product_Description<>"Layby Completion Reversal" ' +
        { If Product Description is changed Can Give False Reading }
        'GROUP BY LaybyID');
      Open;
      if not IsEmpty then begin
        Result := Result - fieldbyname('TotalPayments').AsCurrency;
      end;
    end;
  finally FreeAndNil(qryPayments);
  end;
end;


function GetUnitMultiplier(const UnitOfMeasureID: integer): double;
var
  qryUnitsTemp: TERPQuery;
begin
  qryUnitsTemp := TERPQuery.create(nil);
  qryUnitsTemp.Options.FlatBuffers := true;
  qryUnitsTemp.Connection := GetSharedMyDacConnection;
  qryUnitsTemp.ParamCheck := false;
  try
    qryUnitsTemp.SQL.add('SELECT UnitID,Multiplier FROM tblunitsofmeasure WHERE UnitID =' + IntToStr(UnitOfMeasureID) + ';');
    qryUnitsTemp.active := true;
    if not qryUnitsTemp.IsEmpty then begin
      Result := qryUnitsTemp.fieldbyname('Multiplier').AsFloat;
    end else begin
      Result := 1;
    end;
  finally FreeAndNil(qryUnitsTemp);
  end;
end;

function getBaseUnitname(const iUnitID: integer): string;
begin
  with CommonDBLib.TempMyQuery do
    try
      SQL.add('SELECT BaseUnitName FROM tblunitsofmeasure WHERE UnitID=' + IntToStr(iUnitID));
      Open;
      Result := fieldbyname('BaseUnitName').asString;
    finally
      if active then close;
      Free;
    end;
end;

function GetUnitName(const iUnitID: integer): string;
var
  qryUnitsTemp: TERPQuery;
begin
  qryUnitsTemp := TERPQuery.create(nil);
  qryUnitsTemp.Options.FlatBuffers := true;
  qryUnitsTemp.Connection := GetSharedMyDacConnection;
  qryUnitsTemp.ParamCheck := false;
  try
    qryUnitsTemp.SQL.add('SELECT UnitID, UnitName FROM tblunitsofmeasure WHERE UnitID=' + IntToStr(iUnitID) + ';');
    qryUnitsTemp.active := true;
    if not qryUnitsTemp.IsEmpty then begin
      Result := qryUnitsTemp.fieldbyname('UnitName').asString;
    end else begin
      Result := '';
    end;
  finally FreeAndNil(qryUnitsTemp);
  end;
end;

function GetStatementNo(const ReconciliationID: integer): string;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.add('SELECT ReconciliationID,StatementNo FROM `tblreconciliation` WHERE `ReconciliationID` = ' + IntToStr(ReconciliationID) + ';');
    qryTemp.active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('StatementNo').asString;
    end else begin
      Result := '';
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetProductPurchaseReminderPopup(const ProductID: integer; var MessageStr: string): boolean;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT PARTSID,ProductPurchasePopUpNotes ,ShowPurchaseProductPopUp FROM tblparts WHERE PARTSID = ' + IntToStr(ProductID) + ';');
    qryTemp.active := true;
    if not qryTemp.IsEmpty then begin
      if (qryTemp.fieldbyname('ShowPurchaseProductPopUp').asString = 'T') then begin
        Result := true;
        MessageStr := qryTemp.fieldbyname('ProductPurchasePopUpNotes').asString;
      end else begin
        Result := false;
        MessageStr := '';
      end;
    end else begin
      Result := false;
      MessageStr := '';
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetProductReminderPopup(const ProductID: integer; var MessageStr: string): boolean;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT PARTSID,ShowProductPopUp ,ProductPopUpNotes FROM tblparts WHERE PARTSID = ' + IntToStr(ProductID) + ';');
    qryTemp.active := true;
    if not qryTemp.IsEmpty then begin
      if (qryTemp.fieldbyname('ShowProductPopUp').asString = 'T') then begin
        Result := true;
        MessageStr := qryTemp.fieldbyname('ProductPopUpNotes').asString;
      end else begin
        Result := false;
        MessageStr := '';
      end;
    end else begin
      Result := false;
      MessageStr := '';
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

procedure ResetAllEmployeeNames;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.create(nil);
  qryTemp.Connection := GetSharedMyDacConnection;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('UPDATE tblemployees SET EmployeeName = CONCAT_WS(" ", FirstName, LastName);');
    try qryTemp.Execute;
    except
      on E: EMyError do; // Silent Lock Error trap
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

procedure DeleteAllRecords(const dst: TDataSet);
begin
  dst.First;
  while not dst.Eof do begin
    dst.Delete;
    // dst.First;
  end;
end;

procedure PopulateCustomCombos(const pnl: TPanel);
{ Populate the drop down lists of the 'custom' fields in the panel TPanel. }
var
  qryDropDown: TERPQuery;
  qryIsCombo: TERPQuery;
  cbo: TwwDBComboBox;
  sComboName: string;
  I: integer;
begin
  qryDropDown := TERPQuery.create(nil);
  qryDropDown.Options.FlatBuffers := true;
  qryIsCombo := TERPQuery.create(nil);
  qryIsCombo.Options.FlatBuffers := true;
  try
    qryDropDown.Connection := GetSharedMyDacConnection;
    qryDropDown.ParamCheck := false;
    qryIsCombo.Connection := GetSharedMyDacConnection;
    qryIsCombo.ParamCheck := false;

    qryDropDown.SQL.add('SELECT FieldNumber, Text FROM tblcustomfielddropdowns');
    qryDropDown.Open;

    qryIsCombo.SQL.add('SELECT ' + 'CFIsCombo1, CFIsCombo2, CFIsCombo3, CFIsCombo4, CFIsCombo5, ' + 'CFIsCombo6, CFIsCombo7, CFIsCombo8, CFIsCombo9, CFIsCombo10, ' +
      'CFIsCombo11, CFIsCombo12, CFIsCombo13, CFIsCombo14, CFIsCombo15 ' + 'FROM tblcustomfields');
    qryIsCombo.Open;

    // For each of the 15 custom fields, Clear the drop down list and enable/disable drop down
    for I := 1 to 15 do begin
      cbo := TwwDBComboBox(GetControl('CUSTFLD' + IntToStr(I), pnl));
      if Assigned(cbo) then begin
        cbo.Items.clear;
        if qryIsCombo.fieldbyname('CFIsCombo' + IntToStr(I)).asString = 'T' then begin
          cbo.ButtonWidth := 0; // enable by setting default button width
          cbo.AutoDropDown := true;
        end else begin
          cbo.ButtonWidth := -1; // disable
        end;
      end;
    end;

    // populate the drop down lists of each custom field
    while not qryDropDown.Eof do begin
      sComboName := 'CUSTFLD' + qryDropDown.fieldbyname('FieldNumber').asString;
      cbo := TwwDBComboBox(GetControl('CUSTFLD' + qryDropDown.fieldbyname('FieldNumber').asString, pnl));
      if Assigned(cbo) then begin
        cbo.Items.add(qryDropDown.fieldbyname('Text').asString);
      end;
      qryDropDown.Next;
    end;
  finally
    FreeAndNil(qryDropDown);
    FreeAndNil(qryIsCombo);
  end;
end;

function StartOfTheFY(const dtDate: TDateTime): TDateTime;
begin
  if MonthOfTheYear(dtDate) <= 6 then begin
    Result := IncMonth(StartOfTheYear(IncYear(dtDate, -1)), 6);
  end else begin
    Result := IncMonth(StartOfTheYear(dtDate), 6);
  end;
end;

function StartOfTheQuarter(const dtDate: TDateTime): TDateTime;
(*var
  iMonth: integer;
  iQuater: integer;
  iStartMonth: integer;
begin
  iMonth := MonthOfTheYear(dtDate);
  iQuater := (iMonth - 1) div 3 + 1;
  iStartMonth := (iQuater - 1) * 3 + 1;
  Result := StartOfTheMonth(RecodeMonth(dtDate, iStartMonth));*)
begin
  REsult := utilslib.StartOfTheQuarter(dtDate);
end;

function DaysInQuarter(const dtDate: TDateTime): integer;
var
  dtStart, dtStartNext: TDateTime;
begin
  dtStart := StartOfTheQuarter(dtDate);
  dtStartNext := IncMonth(dtStart, 3);
  Result := DaysBetween(dtStartNext, dtStart);
end;

function IncQuarter(const dtDate: TDateTime; const iNumberOfQuarters: integer = 1): TDateTime;
begin
  Result := IncMonth(dtDate, iNumberOfQuarters * 3);
end;

function DaysBetweenSigned(const dtNow, dtThen: TDateTime): integer;
begin
  if dtNow > dtThen then begin
    Result := DaysBetween(dtNow, dtThen);
  end else begin
    Result := -DaysBetween(dtNow, dtThen);
  end;
end;

function WeeksBetweenSigned(const dtNow, dtThen: TDateTime): integer;
begin
  if dtNow > dtThen then begin
    Result := WeeksBetween(dtNow, dtThen);
  end else begin
    Result := -WeeksBetween(dtNow, dtThen);
  end;
end;

function MonthsBetweenSigned(const dtNow, dtThen: TDateTime): integer;
begin
  if dtNow > dtThen then begin
    Result := MonthsBetween(dtNow, dtThen);
  end else begin
    Result := -MonthsBetween(dtNow, dtThen);
  end;
end;

function YearsBetweenSigned(const dtNow, dtThen: TDateTime): integer;
begin
  if dtNow > dtThen then begin
    Result := YearsBetween(dtNow, dtThen);
  end else begin
    Result := -YearsBetween(dtNow, dtThen);
  end;
end;

function GetAmountInc(const AmountEx: double; const TaxRate: double): double;
begin
  if TaxRate =0 then REsult := AmountEx else
  Result := AmountEx * DivZer((1 + TaxRate), 1);
end;

function GetTaxAmount(const AmountEx: double; const TaxRate: double): double;
begin
  if  TaxRate = 0 then result := 0 else
  Result := AmountEx * DivZer((TaxRate), 1);
end;

function GetAmountEx(const AmountInc: double; const TaxRate: double): double;
begin
  if TaxRate =0 then REsult := AmountInc else
  Result := AmountInc * DivZer(1, (1 + TaxRate));
end;

function CreateNewWaveFile(const NewFileName: string): boolean;
var
  DeviceID: word;
  MciOpen: TMCI_Open_Parms;
  MciRecord: TMCI_Record_Parms;
  MciPlay: TMCI_Play_Parms;
  MciSave: TMCI_SaveParms;
  Flags: word;
  TempFileName: array [0 .. 255] of char;
begin
  StrPCopy(TempFileName, NewFileName);
  MciOpen.lpstrDeviceType := 'waveaudio';
  MciOpen.lpstrElementName := '';
  Flags := Mci_Open_Element or Mci_Open_Type;
  MciSendCommand(0, MCI_OPEN, Flags, longint(@MciOpen));
  DeviceID := MciOpen.wDeviceId;
  MciRecord.dwTo := 1;
  Flags := Mci_To or Mci_Wait;
  MciSendCommand(DeviceID, Mci_Record, Flags, longint(@MciRecord));
  MciPlay.dwFrom := 0;
  Flags := Mci_From or Mci_Wait;
  MciSendCommand(DeviceID, Mci_Play, Flags, longint(@MciPlay));
  MciSave.lpfileName := TempFileName;
  Flags := MCI_Save_File or Mci_Wait;
  MciSendCommand(DeviceID, MCI_Save, Flags, longint(@MciSave));
  Result := MciSendCommand(DeviceID, Mci_Close, 0, longint(nil)) = 0;
end;

function IsValidFileName(const FileName: string): boolean;
var
  I: integer;
begin
  Result := false;
  if Trim(FileName) = '' then Exit;
  if CharInSet(FileName[1], [' ', '.']) then Exit;
  if CharInSet(FileName[char_length(FileName)], [' ', '.']) then Exit;
  for I := 1 to char_length(FileName) do begin
    // Check for invalid characters
    if CharInSet(FileName[I], [Chr(0) .. Chr(31), '\', '/', ':', '*', '?', '"', '<', '>', '|']) then Exit;
  end;
  Result := true;
end;

procedure FindInCurrentDir(const Mask: string; const sl: TStringList);
var
  sr: TSearchRec;
begin
  sl.clear;
  if FindFirst(Mask, faAnyFile, sr) = 0 then
    repeat sl.add(sr.Name)
    until FindNext(sr) <> 0;
  SysUtils.FindClose(sr);
end;

function IsBatchInProgress: boolean;
begin
  Result := AppEnv.CompanyPrefs.BatchUpdateInProgress;
end;

function TempClosingTablesEmpty: boolean;
const
  aysTables: array [0 .. 1] of string = ('tbltransactionsummary', 'tbltransactionsummarydetails');
var
  I, iTable: integer;
  qry: TERPQuery;
  TempTableName: string;
  TableList: TStringList;
  IsTempTable: boolean;
begin
  Result := true;
  TableList := TStringList.create;
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  try
    qry.Connection := GetSharedMyDacConnection;
    qry.ParamCheck := false;
    qry.Connection.GetTableNames(TableList);
    for I := 0 to TableList.Count - 1 do begin
      TempTableName := uppercase(TableList.Strings[I]);
      IsTempTable := false;
      for iTable := 0 to high(aysTables) do begin
        if SysUtils.SameText(uppercase(aysTables[iTable]), uppercase(TempTableName)) then begin
          IsTempTable := true;
          Break;
        end;
      end;

      if (Pos('TMP_', uppercase(TempTableName)) <> 0) and (not SameText(TempTableName,'TMP_TAXCODELOCATIONS')) then begin
        IsTempTable := true;
      end;

      if not IsTempTable then Continue;

      qry.SQL.clear;
      qry.SQL.add('SELECT Count(*) as CountRec FROM ' + TempTableName + ';');
      try
        qry.active := true;
        if qry.Fields[0].asInteger > 0 then begin
          Result := false;
          Exit;
        end;
      except
        // kill the exception
      end;
    end;
  finally
    FreeAndNil(qry);
    FreeAndNil(TableList);
  end;
end;

function IsThisBranchUsed(const BranchSiteCode: string): boolean;
var
  qry: TERPQuery;
begin
  Result := false;
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      SQL.clear;
      SQL.add('SELECT AssetID FROM `tblfixedassets`  WHERE `BranchID` = ' + quotedStr(BranchSiteCode));
      active := true;
      if not IsEmpty then begin
        Result := (qry.recordcount <> 0);
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

procedure SetBatchInProgress(const SetFlag: boolean);
begin
  AppEnv.CompanyPrefs.BatchUpdateInProgress := SetFlag;
end;

procedure SetNoAccess(const EmployeeID: integer);
var
  qry: TERPCommand;
begin
  qry := TERPCommand.create(nil);
  qry.Connection := GetSharedMyDacConnection;
  try
    with qry do begin
      SQL.clear;
      SQL.add('UPDATE tblemployeeformsaccess SET Access= 6 ,EditedFlag= "T" WHERE EmployeeID=' + IntToStr(EmployeeID) + ';');
      Execute;

      SQL.clear;
      SQL.add('FLUSH QUERY CACHE;');
      Execute;

      SQL.clear;
      SQL.add('UPDATE tblpassword SET Logon_Password=Null ,EditedFlag= "T" WHERE EmployeeId=' + IntToStr(EmployeeID) + ';');
      Execute;
    end;
  finally FreeAndNil(qry);
  end;
end;

function GetForeignExchangeSellCode(const iClientID: integer): string;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.add('SELECT ClientID,ForeignExchangeSellCode FROM tblclients WHERE ClientID = ' + IntToStr(iClientID) + ';');
    qryTemp.active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('ForeignExchangeSellCode').asString;
    end else begin
      Result := '';
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetClientDefaultClass(const iClientID: integer): string;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.add('SELECT ClientID,DefaultClass FROM tblclients WHERE ClientID = ' + IntToStr(iClientID) + ';');
    qryTemp.active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('DefaultClass').asString;
    end else begin
      Result := '';
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetClassVariancePercentage(const ClassID, ProductID: integer): double;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.add('SELECT ID,ClassPriceVariance FROM tblproductclasses  WHERE ClassID = ' + IntToStr(ClassID) + ' AND ProductID = ' + IntToStr(ProductID) + ';');
    qryTemp.active := true;
    if not qryTemp.IsEmpty then begin
      Result := (qryTemp.fieldbyname('ClassPriceVariance').AsFloat / 100);
    end else begin
      Result := 0;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetPartAttrib1Sale(const PartID: integer): double;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT PARTSID,Attrib1Sale FROM tblparts WHERE PARTSID = ' + IntToStr(PartID) + ';');
    qryTemp.active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('Attrib1Sale').AsFloat;
    end else begin
      Result := 0.00;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetPartAttrib1Purchase(const PartID: integer): double;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT PARTSID,Attrib1Purchase FROM tblparts WHERE PARTSID = ' + IntToStr(PartID) + ';');
    qryTemp.active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('Attrib1Purchase').AsFloat;
    end else begin
      Result := 0.00;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetPartType(const PartID: integer): string;
var
  qryTemp: TERPQuery;
begin
  Result := '';
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT PARTSID,PARTTYPE FROM tblparts WHERE PARTSID = ' + IntToStr(PartID) + ';');
    qryTemp.Open;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('PARTTYPE').asString;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function IsRelatedChild(const ClientID: integer): boolean;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.add('SELECT RelatedClientID FROM tblrelatedclients WHERE ChildClientID=' + IntToStr(ClientID) + ';');
    qryTemp.active := true;
    if not qryTemp.IsEmpty then begin
      Result := true;
    end else begin
      Result := false;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetInvDocNo(const SaleID: integer): string;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.add('SELECT SaleID,InvoiceDocNumber FROM tblsales WHERE SaleID=' + IntToStr(SaleID) + ';');
    qryTemp.active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('InvoiceDocNumber').asString;
    end else begin
      Result := '';
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

procedure SetRelatedChildID(const tblClient: TDataSet); overload;
var
  qryTemp: TERPQuery;
  qryUpdate: TERPCommand;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryUpdate := TERPCommand.create(nil);
  qryTemp.Connection := GetSharedMyDacConnection;
  qryUpdate.Connection := GetSharedMyDacConnection;
  try
    { TODO : this updation is not required as the parentID is always updated from the parent record which cannot be
      changed from the child record. }
    if not tblClient.active then Exit;
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT RelatedClientID,MasterClientID FROM tblrelatedclients WHERE ChildClientID=' + IntToStr(tblClient.fieldbyname('ClientID').asInteger) + ';');
    qryTemp.Open;
    try
      tblClient.Edit;
      if qryTemp.recordcount > 0 then begin
        tblClient.fieldbyname('ParentRelatedClientID').asInteger := qryTemp.fieldbyname('MasterClientID').asInteger;
      end else begin
        tblClient.fieldbyname('ParentRelatedClientID').asInteger := 0;
      end;
      tblClient.Post;
    except
    end;

    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT RelatedClientID,ChildClientID FROM tblrelatedclients WHERE MasterClientID=' + IntToStr(tblClient.fieldbyname('ClientID').asInteger) + ';');
    qryTemp.Open;
    qryTemp.First;
    while not qryTemp.Eof do begin
      try
        qryUpdate.SQL.clear;
        qryUpdate.SQL.add('UPDATE tblclients ');
        qryUpdate.SQL.add('SET ParentRelatedClientID=' + IntToStr(tblClient.fieldbyname('ClientID').asInteger) + ' ');
        qryUpdate.SQL.add('WHERE ClientID=' + IntToStr(qryTemp.fieldbyname('ChildClientID').asInteger) + ';');
        qryUpdate.WaitExecuting(2);
        qryUpdate.Execute;
      except
      end;
      qryTemp.Next;
    end;

  finally
    FreeAndNil(qryTemp);
    FreeAndNil(qryUpdate);
  end;
end;

procedure SetRelatedChildID;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.create(nil);
  qryTemp.Connection := GetSharedMyDacConnection;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('UPDATE tblclients SET ParentRelatedClientID=0;');
    qryTemp.Execute;
    qryTemp.SQL.clear;
    qryTemp.SQL.add('UPDATE tblclients INNER JOIN tblrelatedclients ON ChildClientID=ClientID SET ParentRelatedClientID=MasterClientID;');
    qryTemp.Execute;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetPartID(const sPartName: string): integer;
var
  qryTemp: TERPQuery;
begin
  Result := 0;
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT PARTSID FROM tblparts WHERE PARTNAME = ' + quotedStr(sPartName));
    qryTemp.Open;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('PARTSID').asInteger;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetServiceID(const sService: string): integer;
var
  qryTemp: TERPQuery;
begin
  Result := 0;
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT ServiceID FROM tblservices WHERE ServiceDesc = ' + quotedStr(sService));
    qryTemp.Open;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('ServiceID').asInteger;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetAbilityID(const sAbility: string): integer;
var
  qryTemp: TERPQuery;
begin
  Result := 0;
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT AbilityID FROM tblability WHERE AbilityDesc = ' + quotedStr(sAbility));
    qryTemp.Open;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('AbilityID').asInteger;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

procedure GetPartCosts(const PartID: integer; var Cost1, Cost2, Cost3: double);
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT PARTSID,COST1,COST2,COST3 FROM tblparts WHERE PARTSID = ' + IntToStr(PartID) + ';');
    qryTemp.Open;
    if not qryTemp.IsEmpty then begin
      Cost1 := qryTemp.fieldbyname('COST1').AsFloat;
      Cost2 := qryTemp.fieldbyname('COST2').AsFloat;
      Cost3 := qryTemp.fieldbyname('COST3').AsFloat;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetPartName(const PartID: integer): string;
var
  qryTemp: TERPQuery;
begin
  Result := '';
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT PARTSID,PARTNAME FROM tblparts WHERE PARTSID = ' + IntToStr(PartID) + ';');
    qryTemp.Open;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('PARTNAME').asString;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetAssetCode(const PartID: integer): string;
var
  qryTemp: TERPQuery;
begin
  Result := '';
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('Select AssetID,AssetCode From tblfixedassets');
    qryTemp.SQL.add('Inner Join tblParts Using(PARTSID) Where tblParts.Active = "T" And tblParts.PARTSID=' + IntToStr(PartID) + ';');
    qryTemp.Open;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('AssetCode').asString;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function AlternateProductFor(const iProductID: integer): string;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('select ProductName   from tblpartsalternate where AlternateProductID = ' + IntToStr(iProductID) + ';');
    qryTemp.Open;
    Result := qryTemp.GroupConcat('ProductName', '', false, Chr(13) + char(vk_tab));
  finally FreeAndNil(qryTemp);
  end;
end;

function IsAlternateProduct(const iProductID: integer): boolean;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('select ID  from tblpartsalternate where AlternateProductID = ' + IntToStr(iProductID) + ';');
    qryTemp.Open;
    Result := qryTemp.recordcount > 0;
  finally FreeAndNil(qryTemp);
  end;
end;

function IsProductDiscontinued(const iProductID: integer): boolean;
var
  qryTemp: TERPQuery;
begin
  Result := false;
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT PARTSID,Discontinued FROM tblparts WHERE PARTSID = ' + IntToStr(iProductID) + ';');
    qryTemp.Open;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('Discontinued').AsBoolean;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetPartPrice1(const PartID: integer): double;
var
  qryTemp: TERPQuery;
begin
  Result := 0.00;
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT PARTSID,PRICE1 FROM tblparts WHERE PARTSID = ' + IntToStr(PartID) + ';');
    qryTemp.Open;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('PRICE1').AsFloat;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetPartPrice2(const PartID: integer): double;
var
  qryTemp: TERPQuery;
begin
  Result := 0.00;
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT PARTSID,PRICE2 FROM tblparts WHERE PARTSID = ' + IntToStr(PartID) + ';');
    qryTemp.Open;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('PRICE2').AsFloat;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetPartPrice3(const PartID: integer): double;
var
  qryTemp: TERPQuery;
begin
  Result := 0.00;
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT PARTSID,PRICE3 FROM tblparts WHERE PARTSID = ' + IntToStr(PartID) + ';');
    qryTemp.Open;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('PRICE3').AsFloat;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetPartAdvMatrixCostEx(const PartID, ClassID, ClientID: integer; const UnitofMeasure: string): double;
// var
// qryTemp: TERPQuery;
begin
  Result := 0.00;
  // qryTemp := TERPQuery.Create(nil);
  // qryTemp.Connection := GetSharedMyDacConnection;
  // qryTemp.ParamCheck := false;
  // try
  // qryTemp.Sql.Clear;
  // qryTemp.Sql.Add('SELECT AdvMatrixID,AdvMatrixCost FROM tbladvmatrix ');
  // qryTemp.Sql.Add('WHERE PARTSID=' + IntToStr(PartID) + ' AND ClassID=' + IntToStr(ClassID) + ' ');
  // qryTemp.Sql.Add('AND ClientID=' + IntToStr(ClientID) + ' AND UnitofMeasure=' + QuotedStr(UnitofMeasure) + ';');
  // qryTemp.Open;
  // if not qryTemp.IsEmpty then begin
  // Result := qryTemp.FieldByName('AdvMatrixCost').AsFloat;
  // end;
  // finally
  // FreeAndNil(qryTemp);
  // end;
end;

function GetPartBarcode(const PartID: integer): string;
var
  qryTemp: TERPQuery;
begin
  Result := '';
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT PARTSID,BARCODE FROM tblparts WHERE PARTSID = ' + IntToStr(PartID) + ';');
    qryTemp.Open;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('BARCODE').asString;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetPartPurchaseTaxcodeRate(const PartID: integer): double;
var
  TempTaxcode: string;
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT PARTSID,PURCHTAXCODE FROM tblparts WHERE PARTSID = ' + IntToStr(PartID) + ';');
    qryTemp.active := true;
    if not qryTemp.IsEmpty then begin
      TempTaxcode := qryTemp.fieldbyname('PURCHTAXCODE').asString;
    end else begin
      TempTaxcode := '';
    end;
    Result := GetTaxRate(TempTaxcode);
  finally FreeAndNil(qryTemp);
  end;
end;

function GetCompanyName: string;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('Select SetupID,CompanyName From tblCompanyInformation;');
    qryTemp.active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('CompanyName').asString;
    end else begin
      Result := '';
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetMenuColour: integer;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('Select SetupID,MenuColor From tblCompanyInformation;');
    try
      if not qryTemp.Connection.connected then begin { DB Lost - Remove DB }
        Result := clNone;
        Exit;
      end;
      qryTemp.Open
    except
      Result := clNone;
      Exit;
    end;

    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('MenuColor').asInteger;
      if Result = 0 then Result := clNone;
    end else begin
      Result := clNone;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetAssignedTillID(const sPCName: string): integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      close;
      SQL.clear;
      SQL.add('SELECT TillID, ComputerName FROM tblPosTills WHERE ComputerName = ' + quotedStr(sPCName) + ';');
      Open;
      if not IsEmpty then begin
        Result := fieldbyname('TillID').asInteger;
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

function IsPrintSpooler(const iTillID: integer): boolean;
var
  qry: TERPQuery;
begin
  Result := false;
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      close;
      SQL.clear;
      SQL.add('SELECT TillID, IsPrintSpooler FROM tblPosTills WHERE TillID = ' + IntToStr(iTillID) + ' AND ReceiptPrinterOn = "T"');
      Open;
      if not IsEmpty then begin
        Result := (qry.fieldbyname('IsPrintSpooler').asString = 'T');
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

// function CreatePrinter(const sPrnType: string;PrinterName:String): TReceiptPrinter;
// begin
// if Sysutils.SameText('EPSON', sPrnType) then begin
// Result := TEpsonPrn.Create;
// end else if Sysutils.SameText('STAR', sPrnType) then begin
// Result := TStarPrn.Create
// end else if Sysutils.SameText('CITIZEN', sPrnType) then begin // iDP 3550
// Result := TCitizenPrn.Create
// end else if Sysutils.SameText('CTZ460', sPrnType) then begin
// Result := TCTZ460Prn.Create
// end else if Sysutils.SameText('CTZ3540', sPrnType) then begin
// Result := TCTZ3540Prn.Create
// end else if Sysutils.SameText('HERO', sPrnType) then begin
// Result := THeroPrn.Create
// end else if Sysutils.SameText('COMPANION', sPrnType) then begin // Eltron Companion
// Result := TCompanionPrn.Create
// end else if  Sysutils.SameText('EPSON-TM-U220', sPrnType) then begin // Eltron Companion
// Result := TEPSON_TM_U220Printer.Create(PrinterName)
// end else if Sysutils.SameText('Log file' ,sPrntype) then begin
// Result := TLogPrinter.Create;
// end else begin
// Result := TEpsonPrn.Create;
// end;
// end;
function GetPrintername(const iTillID: integer): string;
var
  qry: TERPQuery;
begin
  Result := AppEnv.CompanyPrefs.USBPrinterName;
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      close;
      SQL.clear;
      SQL.add('SELECT TillID, USBPrintername FROM tblPosTills WHERE TillID = ' + IntToStr(iTillID) + ';');
      Open;
      if not IsEmpty then begin
        Result := qry.fieldbyname('USBPrintername').asString;
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

function GetPrinterType(const iTillID: integer): string;
var
  qry: TERPQuery;
begin
  Result := 'EPSON';
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      close;
      SQL.clear;
      SQL.add('SELECT TillID, ReceiptPrinterType FROM tblPosTills WHERE TillID = ' + IntToStr(iTillID) + ';');
      Open;
      if not IsEmpty then begin
        Result := qry.fieldbyname('ReceiptPrinterType').asString;
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

function GetPrinterDev(const iTillID: integer): string;
var
  qry: TERPQuery;
begin
  Result := 'EPSON';
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      close;
      SQL.clear;
      SQL.add('SELECT TillID, ReceiptPrinterPort FROM tblPosTills WHERE TillID = ' + IntToStr(iTillID) + ';');
      Open;
      if not IsEmpty then begin
        Result := qry.fieldbyname('ReceiptPrinterPort').asString;
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

function GetBarTabBalance(const iClientID: integer): currency;
var
  qry: TERPQuery;
  // iPrevSaleID: integer;
begin
  Result := 0;
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    with qry do begin
      close;
      SQL.clear;
      SQL.add('SELECT SUM(TotalAmountInc) as TotalAmountInc FROM tblsales_pos ' + 'WHERE ClientID = ' + IntToStr(iClientID) + ' AND IsInvoice = "T" GROUP BY ClientID');
      Open;
      First;
      if qry.recordcount > 0 then begin
        Result := qry.fieldbyname('TotalAmountInc').AsCurrency;
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

function AlternateProductUnique(const iAlternateID, iProductID: integer; ID: integer; Connection: TCustomMyConnection = nil): boolean;
var
  qry: TMyQuery;
begin
  qry := TempMyQuery;
  try
    if Connection <> nil then qry.Connection := Connection;
    qry.SQL.add('select ID from tblpartsalternate where ProductID = ' + IntToStr(iProductID) + ' and AlternateProductID = ' + IntToStr(iAlternateID) + ' and ID <> ' + IntToStr(ID));
    qry.Open;
    Result := qry.IsEmpty;
  finally qry.Free;
  end;

end;

function CheckAlternateProduct(const iAlternateID, iProductID: integer): boolean;
var
  qry: TERPQuery;
begin
  Result := true;
  if iAlternateID = iProductID then begin
    Result := false;
    Exit;
  end;

  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    qry.SQL.clear;
    qry.SQL.add('SELECT ID, ProductID, AlternateProductID FROM tblpartsalternate WHERE AlternateProductID = ' + IntToStr(iProductID) + ';');
    qry.Open;
    if qry.recordcount > 0 then begin
      qry.First;
      while not qry.Eof do begin
        if not CheckAlternateProduct(iAlternateID, qry.fieldbyname('ProductID').asInteger) then begin
          Result := false;
          Exit;
        end;
        qry.Next;
      end;
    end; // if qry.recordcount...
    if Result then begin

    end;
  finally FreeAndNil(qry);
  end;
end;

function CheckRelatedProduct(const iRelatedID, iProductID: integer): boolean;
var
  qry: TERPQuery;
begin
  Result := true;
  if iRelatedID = iProductID then begin
    Result := false;
    Exit;
  end;

  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    qry.SQL.clear;
    qry.SQL.add('SELECT RelatedID, ParentID, ProductID FROM tblrelatedparts WHERE ProductID = ' + IntToStr(iProductID) + ';');
    qry.Open;
    if qry.recordcount > 0 then begin
      qry.First;
      while not qry.Eof do begin
        if not CheckRelatedProduct(iRelatedID, qry.fieldbyname('ParentID').asInteger) then begin
          Result := false;
          Exit;
        end;
        qry.Next;
      end;
    end; // if qry.recordcount...
  finally FreeAndNil(qry);
  end;
end;

function GetPayMethod(const iPayMethodID: integer): string;
// untried!!!!
var
  qryTemp: TERPQuery;
begin
  Result := '';
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT PayMethodID, Name FROM tblpaymentmethods WHERE PayMethodID = ' + IntToStr(iPayMethodID) + ';');
    qryTemp.Open;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('Name').asString;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetNextInvoiceBaseNo(const ClientID: integer): integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  with qry.SQL do begin
    try
      clear;
      add('SELECT InvBaseNumber FROM tblClients WHERE ClientID = ' + quotedStr(IntToStr(ClientID)));
      qry.Open;
      if qry.recordcount > 0 then begin
        Result := qry.fieldbyname('InvBaseNumber').asInteger;
      end;
    finally FreeAndNil(qry);
    end;
  end;
end;

procedure IncrementNextBaseInvoiceNo(const ClientID: integer);
var
  qry: TERPQuery;
  iX: integer;
begin
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  iX := GetNextInvoiceBaseNo(ClientID);
  Inc(iX);
  with qry.SQL do begin
    try
      clear;
      add('UPDATE tblClients SET InvBaseNumber=' + IntToStr(iX) + ' WHERE ClientID = ' + IntToStr(ClientID));
      qry.Execute;
    finally FreeAndNil(qry);
    end;
  end;
end;

function ProductExist(const ProductName: string): boolean;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT PARTSID FROM tblparts WHERE PARTNAME = ' + quotedStr(ProductName) + ';');
    qryTemp.active := true;
    if not qryTemp.IsEmpty then begin
      Result := true;
    end else begin
      Result := false;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function DoesProductUseHedgingFormula(const PartsID: integer): boolean;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT PARTSID,UseHedgingFormula FROM tblparts WHERE PARTSID = ' + IntToStr(PartsID) + ';');
    qryTemp.active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('UseHedgingFormula').AsBoolean;
    end else begin
      Result := false;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function IsGroupProduct(const PartsID: integer): boolean;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT PARTSID,PARTTYPE FROM tblparts WHERE PARTSID = ' + IntToStr(PartsID) + ' AND PARTTYPE = "GRP";');
    qryTemp.active := true;
    if not qryTemp.IsEmpty then begin
      Result := true;
    end else begin
      Result := false;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

/// /////////////////////////////////////////////////////////////////////////
// Daniel: 24 Feb 2004
// ///////////////////
// This function allows the programmer to search a TwwDBGrid control
// and request the column position index of a pertaining field.
//
// The result is the column index value otherwise -1 to
// indicate failure / not found.
/// /////////////////////////////////////////////////////////////////////////

function GetGridColumnIndex(const ThisGrid: TwwDBGrid; const FieldName: string): integer;
var
  iX: integer;
  Buffer: array [0 .. 255] of char;
  Buffer2: array [0 .. 255] of char;
begin
  // Clear local string buffers.
  ZeroMemory(@Buffer, SizeOf(Buffer));
  ZeroMemory(@Buffer2, SizeOf(Buffer2));

  // Copy Fieldname to buffer and lower its case.
  StrPCopy(Buffer, FieldName);
  StrLower(Buffer);

  // This indicates not found.
  Result := -1;

  // Attempt to locate field and return its array index value.
  for iX := 0 to ThisGrid.GetColCount - 1 do begin
    StrPCopy(Buffer2, ThisGrid.Columns[iX].FieldName);
    StrLower(Buffer2);
    // Is this the column we are after?
    if string(Buffer2) = string(Buffer) then begin
      // Found, result = iX to indicate column index.
      Result := iX;
      // Terminate for loop
      Break;
    end;
  end;
end;

/// /////////////////////////////////////////////////////////////////////////
// Daniel: 27 Feb 2004
// ///////////////////
// This function allows the programmer to get a vehicleID
// from the given vehiclename.
//
// The result is the Assigned Vehicle ID value otherwise 0 to
// indicate failure / not found.
/// /////////////////////////////////////////////////////////////////////////

function GetVehicleID(const VehicleName: string): integer;
var
  qryVehicles: TERPQuery;
begin
  Result := 0;
  qryVehicles := TERPQuery.create(nil);
  qryVehicles.Options.FlatBuffers := true;
  qryVehicles.Connection := GetSharedMyDacConnection;
  qryVehicles.ParamCheck := false;
  try
    with qryVehicles do begin
      SQL.clear;
      SQL.add('SELECT VehicleID FROM tblManifestVehicles WHERE (VehicleName = ' + quotedStr(VehicleName) + ')');
      Open;

      if recordcount < 1 then Exit;
      Result := fieldbyname('VehicleID').asInteger;
    end;
  finally FreeAndNil(qryVehicles);
  end;
end;

/// /////////////////////////////////////////////////////////////////////////
// Daniel: 1 March 2004
// ///////////////////
// This function allows the programmer to get a SupplierID
// from the given Supplier Name.
//
// The result is the Assigned Supplier ID value otherwise 0 to
// indicate failure / not found.
/// /////////////////////////////////////////////////////////////////////////

function GetSupplierID(const SupplierName: string): integer;
var
  qrySuppliers: TERPQuery;
begin
  Result := 0;
  qrySuppliers := TERPQuery.create(nil);
  qrySuppliers.Options.FlatBuffers := true;
  qrySuppliers.Connection := GetSharedMyDacConnection;
  qrySuppliers.ParamCheck := false;
  try
    with qrySuppliers do begin
      SQL.clear;
      SQL.add('SELECT ClientID FROM tblclients WHERE (Company = ' + quotedStr(SupplierName) + ')');
      Open;

      if recordcount < 1 then Exit;
      Result := fieldbyname('ClientID').asInteger;
    end;
  finally FreeAndNil(qrySuppliers);
  end;
end;

// //////////////////////////////////////////////////////////////////////////
// Daniel : 4/3/2004
//
// This will copy all fields from the source table to the destination table.
// Any field that can't be found or written will be skipped.
// //////////////////////////////////////////////////////////////////////////

function CopyRecord(const Src, Dest: TCustomMyDataset): boolean;
var
  iY: integer;
begin
  try
    Result := true;
    if Src.recordcount < 1 then Exit;

    // Insert new record and put into edit mode.
    Dest.Insert;
    // Copy Record
    for iY := 0 to Src.FieldCount - 1 do begin
      try
        if (Src.Fields[iY].FieldKind = fkData) then begin
          Dest.fieldbyname(Src.Fields[iY].FieldName).AsVariant := Src.fieldbyname(Src.Fields[iY].FieldName).AsVariant;
        end;
      except
      end;
    end;
    // Post copied record.
    Dest.Post;
  except
    // State that the function failed.
      Result := false;
  end;
end;

/// /////////////////////////////////////////////////////////////////////////
// Daniel: 11 March 2004
// ///////////////////
// This function allows the programmer to get a Function Room Name
// from the given Room ID.
//
// The result is the Assigned Room Name value otherwise NULL to
// indicate failure / not found.
/// /////////////////////////////////////////////////////////////////////////

function GetTableRoomName(const RoomID: integer): string;
var
  qryRooms: TERPQuery;
begin
  Result := '';
  qryRooms := TERPQuery.create(nil);
  qryRooms.Options.FlatBuffers := true;
  qryRooms.Connection := GetSharedMyDacConnection;
  qryRooms.ParamCheck := false;
  try
    with qryRooms do begin
      SQL.clear;
      SQL.add('SELECT RoomID, Name FROM tblfuncrooms WHERE (RoomID = ' + quotedStr(IntToStr(RoomID)) + ')');
      Open;

      if recordcount < 1 then Exit;
      Result := fieldbyname('Name').asString;
    end;
  finally
    // Free Object
    if Assigned(qryRooms) then FreeAndNil(qryRooms);
  end;
end;

/// /////////////////////////////////////////////////////////////////////////
// Daniel: 22 March 2004
// ///////////////////
// This function checks a Part/Product for its Preferred supplier via
// using a product name.
//
// The result is the supplier name or an empty string to indicate failure or
// one is not assigned.
/// /////////////////////////////////////////////////////////////////////////

function GetPreferedSupplierFromPart(const ProductName: string): string;
var
  qryParts: TERPQuery;
begin
  Result := '';
  qryParts := TERPQuery.create(nil);
  qryParts.Options.FlatBuffers := true;
  qryParts.Connection := GetSharedMyDacConnection;
  qryParts.ParamCheck := false;
  try
    with qryParts do begin
      SQL.clear;
      SQL.add('SELECT PARTSID, PREFEREDSUPP FROM tblparts WHERE (PartName = ' + quotedStr(ProductName) + ')');
      Open;

      if recordcount > 0 then begin
        Result := fieldbyname('PREFEREDSUPP').asString;
      end;
    end;
  finally
    // Free Object
    if Assigned(qryParts) then FreeAndNil(qryParts);
  end;
end;

/// /////////////////////////////////////////////////////////////////////////
// Daniel: 22 March 2004
// ///////////////////
// This function checks a Part/Product for its Preferred supplier via using
// a product ID.
//
// The result is the supplier name or an empty string to indicate failure or
// one is not assigned.
/// /////////////////////////////////////////////////////////////////////////

function GetPreferedSupplierFromPart(const PartID: integer): string;
var
  qryParts: TERPQuery;
begin
  Result := '';
  qryParts := TERPQuery.create(nil);
  qryParts.Options.FlatBuffers := true;
  qryParts.Connection := GetSharedMyDacConnection;
  qryParts.ParamCheck := false;
  try
    with qryParts do begin
      SQL.clear;
      SQL.add('SELECT PARTSID, PREFEREDSUPP FROM tblparts WHERE (PartsID = ' + IntToStr(PartID) + ')');
      Open;

      if recordcount > 0 then begin
        Result := fieldbyname('PREFEREDSUPP').asString;
      end;
    end;
  finally
    // Free Object
    if Assigned(qryParts) then FreeAndNil(qryParts);
  end;
end;

function GetMonthName(const MonthNo: integer): string;
begin
  result := DateTimeUtils.MonthNumberToName(MonthNo);
end;

function GetMonthNo(const MonthName: string): integer;
begin
  result := DateTimeUtils.MonthNameToNumber(MonthName);
end;

function QueryMaxRecords(const DataSet: TERPQuery): integer;
var
  MaxRecQueryManipulationObj: TQueryManipulationObj;
  qry: TERPQuery;
begin
  qry := TERPQuery.create(nil);
  MaxRecQueryManipulationObj := TQueryManipulationObj.create(DataSet.SQL.Text);
  qry.Connection := GetSharedMyDacConnection;
  try
    MaxRecQueryManipulationObj.ProcessSQLMaxRecords;
    with qry do begin
      SQL.clear;
      SQL.add(MaxRecQueryManipulationObj.ModifiedSQLMaxRecords);
      qry.Params := DataSet.Params;
      //Prepared := true;
      try Open;
      except
      end;
      if not IsEmpty then begin
        Result := qry.fieldbyname('MaxRecords').asInteger;
      end else begin
        Result := 0;
      end;
    end;
  finally
    FreeAndNil(qry);
    FreeAndNil(MaxRecQueryManipulationObj);
  end;
end;

procedure RealignTabControl(const TabCtl: TPageControl; const TabLines: integer);
var
  I, iCnt: integer;
  // siRnd: single;
  NewTabWidth: integer;
  rowCount: integer;
  Width: integer;
begin
  try
  // Adjust Tab Width To Suit
  iCnt := 0;
  // if Tablines = 1 then siRnd := 0.0
  // else siRnd := 0.5;
  for I := 0 to TabCtl.PageCount - 1 do begin
    if TabCtl.Pages[I].TabVisible then begin
      Inc(iCnt);
    end;
  end;

  if (TabLines > 1) and (not TabCtl.MultiLine) then begin
    TabCtl.MultiLine := true;
  end;

  TabCtl.RaggedRight := true;

  rowCount := System.round(iCnt / TabLines);
  if rowCount < 1 then rowCount := 1;
  Width := TabCtl.Width - 6;
  NewTabWidth := System.round(Width / rowCount);
  if (NewTabWidth * rowCount) > Width then begin
    while (NewTabWidth * rowCount) > Width do Dec(NewTabWidth);

  end
  else if (NewTabWidth * rowCount) < Width then begin
    while (NewTabWidth * rowCount) < Width do Inc(NewTabWidth);
    Dec(NewTabWidth);
  end;
  TabCtl.TabWidth := NewTabWidth;

  // NewTabWidth:= Abs((TabCtl.Width - 4) div System.Round((iCnt + siRnd) / TabLines));
  // if not ((TabCtl.TabWidth >= NewTabWidth -1) and (TabCtl.TabWidth <= NewTabWidth +1)) then
  // TabCtl.TabWidth := NewTabWidth;
  Except
    on E:EXception do begin
      MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
    end;
  end;
end;

function GetCurrentFiscalYearStart: TDateTime;
//var
//  tmpYear, tmpMonth, tmpDay: word;
begin
  result := DateTimeUtils.FiscalYearStart(now,AppEnv.CompanyPrefs.FiscalYearStarts);
//  DecodeDate(now(), tmpYear, tmpMonth, tmpDay);
//  if (tmpMonth < GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts)) then tmpYear := tmpYear - 1;
//  Result := EncodeDate(tmpYear, GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts), 1);
end;

function GetPriorFiscalYearStart: TDateTime;
//var
//  tmpYear, tmpMonth, tmpDay: word;
begin
  result := DateTimeUtils.PriorFiscalYearStart(now,AppEnv.CompanyPrefs.FiscalYearStarts);
//  DecodeDate(now(), tmpYear, tmpMonth, tmpDay);
//  if (tmpMonth < GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts)) then tmpYear := tmpYear - 1;
//  tmpYear := tmpYear - 1;
//  Result := EncodeDate(tmpYear, GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts), 1);
end;

function GetCurrentFiscalYearStart(const CurrentDate: TDateTime): TDateTime;
//var
//  tmpYear, tmpMonth, tmpDay: word;
begin
  result := DateTimeUtils.FiscalYearStart(CurrentDate,AppEnv.CompanyPrefs.FiscalYearStarts);
//  Result := 0;
//  if AppEnv.CompanyPrefs.FiscalYearStarts <> '' then begin
//    DecodeDate(CurrentDate, tmpYear, tmpMonth, tmpDay);
//    if (tmpMonth < GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts)) then tmpYear := tmpYear - 1;
//    Result := EncodeDate(tmpYear, GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts), 1);
//  end;
end;

function GetLastFiscalYearEnd: TDateTime; overload;
begin
  Result := IncDay(GetCurrentFiscalYearStart, -1);
end;

function GetLastFiscalYearEnd(const CurrentDate: TDateTime): TDateTime; overload;
begin
  Result := IncDay(GetCurrentFiscalYearStart(CurrentDate), -1);
end;

function GetFiscalYearEnd(const CurrentDate: TDateTime): TDateTime;
var
  mnth: integer;
begin
  result := IncDay(IncYear(GetCurrentFiscalYearStart(CurrentDate)),-5);
  mnth := MonthOfTheYear(result);
  repeat
    result := IncDay(result, 1);
  until mnth <> MonthOfTheYear(result);
end;


function GetLastRecordPostID(const TableName: string): integer;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    qry.SQL.clear;
    qry.SQL.add('SELECT LAST_INSERT_ID() FROM ' + TableName);
    qry.Open;
    Result := qry.Fields[0].asInteger;
  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function GetLastRecordPostID(const TableName: string; Connection: TCustomMyConnection): integer;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := Connection;
  qry.ParamCheck := false;
  try
    qry.SQL.clear;
    qry.SQL.add('SELECT LAST_INSERT_ID() FROM ' + TableName);
    qry.Open;
    Result := qry.Fields[0].asInteger;
  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

// function SetMyDacConnection(const MyConnection: TERPConnection; const ADOConnectionString: string): boolean;
// var
// UseOld: boolean;
// ConnectionString, OldServer, OldDatabase, OldUsername, OldPassword: string;
//
// function ExtractValue(const key, from: string): string;
// var
// p: integer;
// begin
// Result := '';
// p := FastFuncs.PosEx(uppercase(key) + '=', uppercase(from));
// if p > 0 then begin
// p := p + char_length(key) + 1;
// while (p <= char_length(from)) and (from[p] <> ';') do begin
// Result := Result + from[p];
// Inc(p);
// end;
// end;
// end;
// begin
// Result := true;
// if Empty(ADOConnectionString) then begin
/// /    ConnectionString := GetSharedADOConnection.ConnectionString;
// end else begin
// ConnectionString := ADOConnectionString;
// end;
//
// OldServer := MyConnection.Server;
// OldDatabase := MyConnection.Database;
// OldUsername := MyConnection.Username;
// OldPassword := MysqlPassword;
// UseOld := false;
// try
// Processingcursor(True);
// MyConnection.Server   := ExtractValue('Server', ConnectionString);
// MyConnection.Database := ExtractValue('DataBase', ConnectionString);
// MyConnection.Username := ExtractValue('UID', ConnectionString);
// MyConnection.Password := MysqlPassword;
//
// //ExtractValue('Password', ConnectionString);
//
// try
// MyConnection.Open;
// except
// on E: EMyError do UseOld := true;
// end;
// //Revert Back to Old Connection
// if UseOld then begin
// MyConnection.Server := OldServer;
// MyConnection.Database := OldDatabase;
// MyConnection.Username := OldUsername;
// MyConnection.Password := OldPassword;
// try
// MyConnection.Open;
// except
// on E: EMyError do Begin
// Result := false;
// end;
// end;
// end;
// Processingcursor(False);
// except
// Result := false;
// end;
// end;

function GetPrepaymentAccountID(const TransType: string): integer;
begin
  Result := 0;
  if (TransType = 'TfmSuppPrepayments') or (TransType = 'TfmSuppPayments') or (TransType = 'S') then begin
    Result := GetAccountID(GLACCOUNT_SUPPPREPAYMENT);
  end
  else if (TransType = 'TfmCustPrepayments') or (TransType = 'TfmCustPayments') or (TransType = 'C') then begin
    Result := GetAccountID(GLACCOUNT_CUSTPREPAYMENT);
  end;
end;

function GetSupplierPrepaymentAccountID: integer;
begin
  result := GetPrepaymentAccountID('S');
end;

function GetCustomerPrepaymentAccountID: integer;
begin
  result := GetPrepaymentAccountID('C');
end;

function IsPosEOPDoneAndNoSummariseSalesExist: boolean;
var
  qryTemp: TERPQuery;
begin
  Result := true;
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    with qryTemp do begin
      close;
      SQL.clear;
//      SQL.add('SELECT SaleID FROM tblsales_pos where Deleted <> "T" LIMIT 0,10 ');
      SQL.add('SELECT tblsales_pos.SaleID FROM tblsales_pos');
      SQL.add('left join tblSalesLines_Pos on tblSales_Pos.SaleId = tblSalesLines_Pos.SaleId');
      SQL.add('where tblsales_pos.Deleted <> "T"');
      SQL.add('and not IsNull(tblSalesLines_Pos.SaleId)');
      SQL.add('LIMIT 0,10');
      Open;
      if not IsEmpty then begin
        Result := false;
        Exit;
      end;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function GetAllowanceID(const sAllowanceName: string): integer;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    qry.SQL.clear;
    qry.SQL.add('SELECT AllowanceID FROM tblAllowances WHERE Description = ' + quotedStr(sAllowanceName));
    qry.Open;
    if qry.recordcount > 0 then begin
      Result := qry.fieldbyname('AllowanceID').asInteger;
    end else begin
      Result := 0;
    end;
  finally
    // Free our used objects.
      FreeAndNil(qry);
  end;
end;

function GetEquipmentID(const sEquipmentName: string): integer;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := false;
  try
    qry.SQL.clear;
    qry.SQL.add('SELECT EquipmentID FROM tblequipment WHERE EquipmentName = ' + quotedStr(sEquipmentName));
    qry.Open;
    if qry.recordcount > 0 then begin
      Result := qry.fieldbyname('EquipmentID').asInteger;
    end else begin
      Result := 0;
    end;
  finally
    // Free our used objects.
      FreeAndNil(qry);
  end;
end;

function GetPhysicalAddress(const iClientID: integer): string;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  try
    qry.Connection := GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.clear;
    qry.SQL.add('SELECT ClientID, Street, Street2, Suburb, State, PostCode, Country FROM tblclients');
    qry.SQL.add('WHERE ClientID = :xClientID');
    qry.Params.ParamByName('xClientID').asInteger := iClientID;
    qry.Open;
    if qry.recordcount > 0 then begin
      Result := qry.fieldbyname('Street').asString + #13 + #10 + qry.fieldbyname('Street2').asString + #13 + #10 + qry.fieldbyname('Suburb').asString + ' ' + qry.fieldbyname('State').asString + ' ' +
        qry.fieldbyname('PostCode').asString + #13 + #10 + qry.fieldbyname('Country').asString;
    end else begin
      Result := '';
    end;

    qry.close;
  finally
    // Free our used object.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function GetShippingAddress(const iClientID: integer): string;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  try
    qry.Connection := GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.clear;
    qry.SQL.add('SELECT ClientID, BillStreet, BillStreet2, BillSuburb, BillState, BillPostCode, BillCountry FROM tblclients');
    qry.SQL.add('WHERE ClientID = :xClientID');
    qry.Params.ParamByName('xClientID').asInteger := iClientID;
    qry.Open;
    if qry.recordcount > 0 then begin
      Result := qry.fieldbyname('BillStreet').asString + #13 + #10 + qry.fieldbyname('BillStreet2').asString + #13 + #10 + qry.fieldbyname('BillSuburb').asString + ' ' + qry.fieldbyname('BillState')
        .asString + ' ' + qry.fieldbyname('BillPostCode').asString + #13 + #10 + qry.fieldbyname('BillCountry').asString;
    end else begin
      Result := '';
    end;

    qry.close;
  finally
    // Free our used object.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function GetPayMethodName(const iPayMethodID: integer): string;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  try
    qry.Connection := GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.clear;
    qry.SQL.add('SELECT PayMethodID, Name FROM tblpaymentmethods WHERE PayMethodID = :xID');
    qry.Params.ParamByName('xID').asInteger := iPayMethodID;
    qry.Open;

    if qry.recordcount > 0 then begin
      Result := qry.fieldbyname('Name').asString;
    end else begin
      Result := '';
    end;
  finally
    // Free our used objects.
    qry.close;
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function GetRunName(const iRunID: integer): string;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  try
    qry.Connection := GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.clear;
    qry.SQL.add('SELECT RunID, RunName FROM tblruns WHERE RunID = :xID');
    qry.Params.ParamByName('xID').asInteger := iRunID;
    qry.Open;

    if qry.recordcount > 0 then begin
      Result := qry.fieldbyname('RunName').asString;
    end else begin
      Result := '';
    end;
  finally
    // Free our used objects.
    qry.close;
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function GetProductInfo(const iProductID: integer): TProductInfo;
var
  qry: TERPQuery;
  oPartInfo: TProductInfo;
begin
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  try
    qry.Connection := GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.clear;
    { Binny : Buy and sell defualt UOM fields are removed from the parts table , the default is always the DEFAULT_UOM
      So the Qry's SQL is not selecting the fields and the object has the properties intialised to the
      default value }
    qry.SQL.add('SELECT tblparts.PartsID, tblparts.PartsDescription, tblparts.PartName,  ');
    qry.SQL.add('tblparts.PartType, tblparts.ProductGroup, tblparts.IncomeAccnt,  ');
    qry.SQL.add('tblparts.AssetAccnt, tblparts.COGSAccnt, tblparts.Barcode, tblparts.ProductCode, ');
    qry.SQL.add('tblparts.TaxCode, tblparts.PreferedSupp, tblparts.SellQty1,  ');
    qry.SQL.add('tblparts.SellQty2, tblparts.SellQty3, tblparts.Price1, tblparts.Price2, tblparts.Price3, ');
    qry.SQL.add('tblparts.PURCHASEDESC, tblparts.BuyQty1, tblparts.BuyQty2,  tblparts.BuyQty3,  ');
    qry.SQL.add('tblparts.Cost1, tblparts.Cost2, tblparts.Cost3, tblparts.PURCHTAXCODE,');
    // qry.SQL.Add('tblparts.UnitOfMeasure, tblparts.UnitOfMeasureID, Buy.Multiplier as BuyMultiplier , ');
    // qry.SQL.Add('tblparts.UnitOfMeasureSales,  tblparts.UnitOfMeasureIDSales, Sales.Multiplier as SalesMultiplier , ');
    qry.SQL.add('tblparts.LatestCost, tblparts.LatestCostDate,  tblparts.SNTracking');
    qry.SQL.add('FROM tblparts ');
    // qry.SQL.Add('Left join  tblunitsofMeasure Sales  on Sales.UnitId  = tblparts.UnitOfMeasureIDSales ');
    // qry.SQL.Add('Left join  tblunitsofMeasure Buy  on Buy.UnitId  = tblparts.UnitOfMeasureID ');
    qry.SQL.add('WHERE tblparts.PartsID = :xPartID');
    qry.Params.ParamByName('xPartID').asInteger := iProductID;
    qry.Open;
    if qry.recordcount > 0 then begin
      with oPartInfo do begin
        PartID := iProductID;
        ProductName := qry.fieldbyname('PartName').asString;
        PartType := qry.fieldbyname('PartType').asString;
        ProductGroup := qry.fieldbyname('ProductGroup').asString;
        ProductCode := qry.fieldbyname('ProductCode').asString;
        BarCode := qry.fieldbyname('Barcode').asString;
        PartSellDescription := qry.fieldbyname('PARTSDESCRIPTION').asString;
        PartBuyDescription := qry.fieldbyname('PURCHASEDESC').asString;
        SellTaxCode := qry.fieldbyname('TaxCode').asString;
        PreferedSupplier := qry.fieldbyname('PreferedSupp').asString;
        PreferedSupplierID := GetClientID(qry.fieldbyname('PreferedSupp').asString);
        SNTracking := qry.fieldbyname('SNTracking').AsBoolean;
        Price1 := qry.fieldbyname('Price1').AsFloat;
        Price2 := qry.fieldbyname('Price2').AsFloat;
        Price3 := qry.fieldbyname('Price3').AsFloat;
        SellQty1 := qry.fieldbyname('SellQty1').AsFloat;
        SellQty2 := qry.fieldbyname('SellQty2').AsFloat;
        SellQty3 := qry.fieldbyname('SellQty3').AsFloat;
        IncomeAccount := qry.fieldbyname('IncomeAccnt').asString;
        COGSAccount := qry.fieldbyname('COGSAccnt').asString;
        AssetAccount := qry.fieldbyname('AssetAccnt').asString;
        BuyPrice1 := qry.fieldbyname('Cost1').AsFloat;
        BuyPrice2 := qry.fieldbyname('Cost2').AsFloat;
        BuyPrice3 := qry.fieldbyname('Cost3').AsFloat;
        BuyQty1 := qry.fieldbyname('BuyQty1').AsFloat;
        BuyQty2 := qry.fieldbyname('BuyQty2').AsFloat;
        BuyQty3 := qry.fieldbyname('BuyQty3').AsFloat;
        PurchaseTaxCode := qry.fieldbyname('PURCHTAXCODE').asString;

        BuyUnitOfMeasure := AppEnv.DefaultClass.DefaultUOM;
        SellUnitOfMeasure := AppEnv.DefaultClass.DefaultUOM;
        BuyUnitOfMeasureID := GetUnitOfMeasureID(AppEnv.DefaultClass.DefaultUOM);
        SellUnitOfMeasureID := GetUnitOfMeasureID(AppEnv.DefaultClass.DefaultUOM);
        BuyUnitOfMeasureMultiplier := 1;
        SellUnitOfMeasureMultiplier := 1;

        LatestCostPrice := qry.fieldbyname('LatestCost').AsFloat;
        LatestCostDate := qry.fieldbyname('LatestCostDate').AsDateTime;
      end;
      Result := oPartInfo;
    end else begin
      ZeroMemory(@oPartInfo, SizeOf(oPartInfo));
      Result := oPartInfo;
    end;

    qry.close;
  finally
    // Free our used object.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

/// /////////////////////////////////////////////////////////////////
// This function checks the template run list to see if the given
// client id has already been assigned to any run.
/// /////////////////////////////////////////////////////////////////

function IsCustomerOnRun(const iClientID: integer; const sClientName: string): boolean;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  try
    qry.Connection := GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.clear;
    qry.SQL.add('SELECT RunID FROM tblrunslines WHERE ClientID = :xCID AND ClientName = :xClientName');
    qry.Params.ParamByName('xCID').asInteger := iClientID;
    qry.Params.ParamByName('xClientName').asString := sClientName;
    qry.Open;

    if qry.recordcount > 0 then begin
      Result := true;
    end else begin
      Result := false;
    end;
  finally
    // Free our used objects.
    qry.close;
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

/// /////////////////////////////////////////////////////////////////
// This function checks the template run list to see if the given
// client id has already been assigned to any other run except for
// the run id that has been given.
/// /////////////////////////////////////////////////////////////////

function IsCustomerOnRun(const iClientID, iExcludeRunID: integer): boolean;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  try
    qry.Connection := GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.clear;
    qry.SQL.add('SELECT RunID FROM tblrunslines WHERE ClientID = :xCID AND RunID <> :xRunID');
    qry.Params.ParamByName('xCID').asInteger := iClientID;
    qry.Params.ParamByName('xRunID').asInteger := iExcludeRunID;
    qry.Open;

    if qry.recordcount > 0 then begin
      Result := true;
    end else begin
      Result := false;
    end;
  finally
    // Free our used objects.
    qry.close;
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function GetMyNextSequenceNumber(const iRunID: integer): integer;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  try
    qry.Connection := GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.clear;
    qry.SQL.add('SELECT Max(Sequence) AS Sequence FROM tblrunslines WHERE RunID = :xRID');
    qry.Params.ParamByName('xRID').asInteger := iRunID;
    qry.Open;

    if qry.recordcount > 0 then begin
      if not qry.fieldbyname('Sequence').IsNull then begin
        Result := qry.fieldbyname('Sequence').asInteger + 1;
      end else begin
        Result := 1;
      end;
    end else begin
      Result := 1;
    end;
  finally
    // Free our used objects.
    qry.close;
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function ConvertCurrentDateToMySQLDate: string;
var
  wYear, wMonth, wDay: word;
begin
  DecodeDate(Date(), wYear, wMonth, wDay);
  Result := IntToStr(wYear) + '-' + IntToStr(wMonth) + '-' + IntToStr(wDay);
end;

function ConvertCurrentDateToMySQLDate(const dtConversionDate: TDateTime): string;
var
  wYear, wMonth, wDay: word;
begin
  try
    DecodeDate(dtConversionDate, wYear, wMonth, wDay);
    Result := IntToStr(wYear) + '-' + IntToStr(wMonth) + '-' + IntToStr(wDay);
  except Result := '';
  end;
end;

function ConvertCurrentDateToMySQLDateTime: string;
var
  wYear, wMonth, wDay: word;
  wHour, wMin, wSec, wMSec: word;
begin
  DecodeDate(Date(), wYear, wMonth, wDay);
  DecodeTime(Time(), wHour, wMin, wSec, wMSec);
  Result := IntToStr(wYear) + '-' + IntToStr(wMonth) + '-' + IntToStr(wDay) + ' ' + Format('%2.2d', [wHour]) + ':' + Format('%2.2d', [wMin]) + ':' + Format('%2.2d', [wSec]);
end;

function ConvertCurrentDateToMySQLDateTime(const dtConversionDate: TDateTime): string;
var
  wYear, wMonth, wDay: word;
  wHour, wMin, wSec, wMSec: word;
begin
  try
    DecodeDate(dtConversionDate, wYear, wMonth, wDay);
    DecodeTime(dtConversionDate, wHour, wMin, wSec, wMSec);
    Result := IntToStr(wYear) + '-' + IntToStr(wMonth) + '-' + IntToStr(wDay) + ' ' + Format('%2.2d', [wHour]) + ':' + Format('%2.2d', [wMin]) + ':' + Format('%2.2d', [wSec]);
  except Result := '';
  end;
end;

function ValidateClosingDate(const TransDate: TDateTime; const IsAR, IsAP: boolean): boolean;
var
  bValidDate: boolean;
begin
  bValidDate := true;
  if (TransDate <= AppEnv.CompanyPrefs.ClosingDate) then begin
    bValidDate := false;
  end
  else if IsAR then begin
    if (TransDate <= AppEnv.CompanyPrefs.ClosingDateAR) then begin
      bValidDate := false;
    end;
  end
  else if not IsAP then begin
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

procedure CheckRunLinesForExistingFields;
begin
  { Redundant }
end;

(*function GetClientsDefaultReport(const ClientID: integer): string;
var
  qryTemp: TERPQuery;
  TemplID: string;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT DefaultInvoiceTemplateID FROM tblclients WHERE DefaultInvoiceTemplateID<>0 AND ClientID = ' + IntToStr(ClientID) + ';');
    qryTemp.active := true;

    if not qryTemp.IsEmpty then begin
      TemplID := qryTemp.fieldbyname('DefaultInvoiceTemplateID').asString;
    end else begin
      TemplID := '0';
    end;

    qryTemp.SQL.clear;
    qryTemp.SQL.add('SELECT TemplID,TemplName FROM `tbltemplates`  WHERE `TemplID` = ' + TemplID + ';');
    qryTemp.active := true;

    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('TemplName').asString;
    end else begin
      Result := '';
    end;
  finally
    if Assigned(qryTemp) then FreeAndNil(qryTemp);
  end;
end;*)

function GetLargestResult(const sValue1, sValue2: string): string;
var
  Buffer: array [0 .. 255] of char;
  Buffer2: array [0 .. 255] of char;
  iX: integer;
  b1, b2: byte;
begin
  if StrLen(PChar(sValue1)) > StrLen(PChar(sValue2)) then begin
    Result := sValue1;
    Exit;
  end
  else if StrLen(PChar(sValue2)) > StrLen(PChar(sValue1)) then begin
    Result := sValue2;
    Exit;
  end;

  // Otherwise the string lengths must be identical.
  // perform a byte by byte comparison.
  StrPCopy(Buffer, sValue1);
  StrPCopy(Buffer2, sValue2);
  for iX := 0 to StrLen(PChar(sValue1)) - 1 do begin
    b1 := byte(Buffer[iX]);
    b2 := byte(Buffer2[iX]);
    if (b1 > b2) then begin
      Result := sValue1;
      Exit;
    end
    else if (b2 > b1) then begin
      Result := sValue2;
      Exit;
    end;
  end;

  // if we get to here they must be absolutely identical.
  Result := sValue1;
end;

function IsMultisitePC(const EmployeeID: integer): boolean;
var
  qry: TERPQuery;
begin
  Result := false;
  if EmployeeID = 0 then Exit;
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  try
    qry.Connection := GetSharedMyDacConnection;
    qry.SQL.clear;
    qry.SQL.add('SELECT BackEndID,LastPC,LastUserID FROM `tblmsbackendid`  WHERE `BEDefault` = "T";');
    qry.Open;
    if qry.recordcount > 0 then begin
      qry.First;
      if SysUtils.SameText(Trim(qry.fieldbyname('LastPC').asString), Trim(GetPCName())) and (qry.fieldbyname('LastUserID').asInteger = EmployeeID) then Result := true
      else Result := false;
    end;
  finally FreeAndNil(qry);
  end;
end;

procedure SetMultisitePC(const EmployeeID: integer);
var
  qry: TERPCommand;
begin
  qry := TERPCommand.create(nil);
  try
    qry.Connection := GetSharedMyDacConnection;
    qry.SQL.clear;
    qry.SQL.add('UPDATE tblmsbackendid SET LastUserID=' + IntToStr(EmployeeID) + ', LastPC=' + quotedStr(Trim(GetPCName())) + ' WHERE `BEDefault` = "T";');
    qry.Execute;
  finally FreeAndNil(qry);
  end;
end;

function IsDupMultisiteEmail(const BackEndID: integer; const EmailAddress: string): boolean;
var
  qry: TERPQuery;
begin
  Result := false;
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  try
    qry.Connection := GetSharedMyDacConnection;
    qry.SQL.clear;
    qry.SQL.add('SELECT BackEndID, EmailAddressData FROM tblmsbackendid ');
    qry.SQL.add('WHERE EmailAddressData<>"" AND Not IsNull(EmailAddressData) AND BackEndID <> ' + IntToStr(BackEndID) + ';');
    qry.Open;
    if qry.recordcount > 0 then begin
      qry.First;
      while not qry.Eof do begin
        if SysUtils.SameText(Trim(qry.fieldbyname('EmailAddressData').asString), Trim(EmailAddress)) then begin
          Result := true;
          Exit;
        end;
        qry.Next;
      end;
    end;
  finally FreeAndNil(qry);
  end;
end;

procedure SetConnectionIsolationLevel(const oConnection: TCustomMyConnection);
var
  qry: TERPQuery;
begin
  qry := TERPQuery.create(nil);
  try
    try
      qry.Connection := oConnection;
      qry.SQL.clear;
      qry.SQL.Text := 'SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;';
      qry.Execute;
    except
    end;
  finally FreeAndNil(qry);
  end;
end;

procedure SetConnectionIsolationLevel(const oConnection: TERPConnection); overload;
var
  qry: TERPCommand;
begin
  qry := TERPCommand.create(nil);
  try
    try
      qry.Connection := oConnection;
      qry.SQL.clear;
      qry.SQL.Text := 'SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;';
      qry.Execute;
    except
    end;
  finally FreeAndNil(qry);
  end;
end;

/// /////////////////////////////////////////////////////////////////////////////
// Daniel: 13/1/2005
/// /////////////////////////////////////////////////////////////////////////////
// This function will start the MySQL Monitoring with
// the ability to also record locking issues.  This routine
// is used strictly for debugging purposes and should not
// be left in your routines once you have completed
// your debugging.
//
// Once you have finished your debugging your functions you
// should end your function with a call to
// StopyMySQLLockMonitor() function to have the server
// stop recording.  If you donot, MySQL will keep recording
// and sooner or later you will have a log that is so huge
// and could possibly make your server fall over.
//
// To review your monitoring logs you will need to find the
// file *.err in your c:\mysql\data directory.
/// /////////////////////////////////////////////////////////////////////////////

function StartMySQLLockMonitor: boolean;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  try
    try
      qry.Connection := GetSharedMyDacConnection;
      qry.SQL.clear;
      qry.SQL.add('CREATE TABLE innodb_lock_monitor(a INT) ENGINE=InnoDB;');
      qry.Execute;
      Result := true;
    except Result := false;
    end;
  finally
    // Free our allocated objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

/// /////////////////////////////////////////////////////////////////////////////
// Be sure to call this function at the end of your query statements that
// you are wanting to debug.
//
// Example:

// if (StartMySQLLockMonitor) then
// begin
// ... Your Query functions here ....
// Call StopMySQLLockMonitor()
// end;
/// /////////////////////////////////////////////////////////////////////////////

function StopMySQLLockMonitor: boolean;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.create(nil);
  qry.Options.FlatBuffers := true;
  try
    try
      qry.Connection := GetSharedMyDacConnection;
      qry.SQL.clear;
      qry.SQL.add('DROP TABLE innodb_lock_monitor;');
      qry.Execute;
      Result := true;
    except Result := false;
    end;
  finally
    // Free our allocated objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;
/// /////////////////////////////////////////////////////////////////////////////

function QuarterOf(const aValue: TDateTime): integer;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.add('SELECT QUARTER("' + FormatDatetime(MysqlDateFormat, aValue) + '") as QUARTER;');
    qryTemp.active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.fieldbyname('QUARTER').asInteger;
    end else begin
      Result := 0;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function EndOfTheQuarter(const aValue: TDateTime): TDateTime;
var
  Quarter: integer;
begin
  Quarter := QuarterOf(aValue);
  Result := aValue; { Remove Hint }
  case Quarter of
    1: begin
        Result := EndOfTheMonth(IncMonth(aValue, 3 - MonthOf(aValue)));
      end;
    2: begin
        Result := EndOfTheMonth(IncMonth(aValue, 6 - MonthOf(aValue)));
      end;
    3: begin
        Result := EndOfTheMonth(IncMonth(aValue, 9 - MonthOf(aValue)));
      end;
    4: begin
        Result := EndOfTheMonth(IncMonth(aValue, 12 - MonthOf(aValue)));
      end;
  end;
end;

procedure UpdateSecsInAllLogs;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.create(nil);
  qryTemp.Connection := GetSharedMyDacConnection;
  try
    qryTemp.SQL.clear;
    qryTemp.SQL.add
      ('UPDATE tblphonesupportlog SET CallSecs= SUBSTRING_INDEX(CallTime, ":", 1)*3600 + SUBSTRING_INDEX(SUBSTRING_INDEX(CallTime, ":", 2),":",-1)*60 + SUBSTRING_INDEX(CallTime, ":", -1);');
    qryTemp.Execute;
  finally FreeAndNil(qryTemp);
  end;
end;

function TArrayOfCharToStr(const A: TArrayOfChar): string;
var
  n: integer;
begin
  Result := '';
  for n := 0 to 255 do Result := Result + A[n];
end;

function StrToTArrayOfChar(const s: string): TArrayOfChar;
var
  n: integer;
begin
  for n := 0 to 255 do Result[n] := #0;

  if char_length(s) = 0 then Exit;

  for n := 0 to 255 do Result[n] := s[n + 1];
end;

//function GetMachineIdentification(const User, System, Network, Drives: boolean): string;
//var
//  InfoSet: TEsMachineInfoSet;
//  MachineID: longint;
//begin
//  InfoSet := [];
//  if User then InfoSet := InfoSet + [midUser];
//  if System then InfoSet := InfoSet + [midSystem];
//  if Network then InfoSet := InfoSet + [midNetwork];
//  if Drives then InfoSet := InfoSet + [midDrives];
//
//  MachineID := CreateMachineID(InfoSet);
//  Result := BufferToHex(MachineID, SizeOf(MachineID));
//end;

{ Counts the number of words in 'strData'.
  'strDelim' separates the words. By default it is single space.
  If CountWhenNotBlank  is true, it counts the last part of 'strdata' as 1  if the
  string is not termintated with 'strDelim' }
procedure SplitString(const aValue: string; const aDelimiter: string; var Result: TStringList);
var
  ctr: integer;
  x: integer;
begin
  ctr := CharCounter(aDelimiter, aValue);
  Result.clear;
  for x := 1 to ctr do begin
    Result.add(ExtractStrPortion(aValue, aDelimiter, x));
  end;

end;

function CountWords(const Data: string; const strDelim: string = ' '; const CountWhenNotBlank: boolean = true): integer;
var
  IntPos: integer;
  StrData: string;
begin
  Result := 0;
  StrData := Trim(Data);
  while StrData <> '' do begin
    IntPos := Pos(strDelim, StrData);
    if IntPos <> 0 then begin
      Result := Result + 1;
      StrData := Copy(StrData, IntPos + 1, char_length(StrData) - IntPos);
    end else begin
      if CountWhenNotBlank then
        if StrData <> '' then Result := Result + 1;
      StrData := '';
    end;
  end;
end;

procedure RemoveXDesignSql;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := CommonDBLib.GetSharedMyDacConnection;
  try
    qryTemp.SQL.add('UPDATE tbltemplates SET DesignTimeSQLString = NULL WHERE LOWER(Trim(DesignTimeSQLString)) = "x";');
    try qryTemp.Execute;
    except
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

procedure CleanUpLevelFields(const AccountID: integer = 0);
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := CommonDBLib.GetSharedMyDacConnection;
  try
    qryTemp.SQL.add('UPDATE tblchartofaccounts SET Level1 = AccountName, Level2=NULL , Level3=NULL , Level4 =NULL ');
    if AccountID <> 0 then begin
      qryTemp.SQL.add('WHERE tblchartofaccounts.AccountID=' + IntToStr(AccountID) + ';');
    end;
    qryTemp.Execute;
  finally FreeAndNil(qryTemp);
  end;
end;

procedure SetAccountLevelField(const AccountID: integer = 0);
var
  qryLevelsTemp: TERPQuery;
begin
  CleanUpLevelFields(AccountID);
  qryLevelsTemp := TERPQuery.create(nil);
  qryLevelsTemp.Options.FlatBuffers := true;
  qryLevelsTemp.Connection := CommonDBLib.GetSharedMyDacConnection;
  try
    qryLevelsTemp.SQL.add('SELECT AccountID, ');
    qryLevelsTemp.SQL.add(SplitField('', 'Concat_WS("^",AccountGroup,AccountName)', 1) + ' as Level1,');
    qryLevelsTemp.SQL.add(SplitField('', 'Concat_WS("^",AccountGroup,AccountName)', 2) + ' as Level2,');
    qryLevelsTemp.SQL.add(SplitField('', 'Concat_WS("^",AccountGroup,AccountName)', 3) + ' as Level3,');
    qryLevelsTemp.SQL.add(SplitField('', 'Concat_WS("^",AccountGroup,AccountName)', 4) + ' as Level4');
    qryLevelsTemp.SQL.add('FROM tblChartofAccounts Where char_length(AccountGroup) > 0 ');
    if AccountID <> 0 then begin
      qryLevelsTemp.SQL.add('AND tblChartofAccounts.AccountID=' + IntToStr(AccountID) + ';');
    end;
    qryLevelsTemp.active := true;

    if not qryLevelsTemp.IsEmpty then begin
      qryLevelsTemp.First;
      while not qryLevelsTemp.Eof do begin
        UpdateLevels(qryLevelsTemp.fieldbyname('AccountID').asInteger, qryLevelsTemp.fieldbyname('Level1').asString, qryLevelsTemp.fieldbyname('Level2').asString,
          qryLevelsTemp.fieldbyname('Level3').asString, qryLevelsTemp.fieldbyname('Level4').asString);
        qryLevelsTemp.Next;
      end;
    end;
  finally FreeAndNil(qryLevelsTemp);
  end;
end;

procedure UpdateLevels(const AccountID: integer; const Level1, Level2, Level3, Level4: string);
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.create(nil);
  qryTemp.Options.FlatBuffers := true;
  qryTemp.Connection := CommonDBLib.GetSharedMyDacConnection;
  try
    qryTemp.SQL.add('UPDATE tblchartofaccounts SET Level1 =' + quotedStr(Level1) + ' , Level2 =' + quotedStr(Level2) + ' , Level3 =' + quotedStr(Level3) + ' , Level4 =' + quotedStr(Level4) + ' ');
    qryTemp.SQL.add('WHERE AccountID =' + IntToStr(AccountID) + ';');
    try qryTemp.Execute;
    except
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

function InPayrollTestMode: boolean;
begin
  Result := FileExists(ExeDir + 'PayrollTesting.ini');
end;

function FirstNoAbort(const DataSet: TDataSet): boolean;
begin
  Result := false;
  try
    DataSet.First;
    Result := true;
  except
    on EAbort do;
  end;
end;

function GetParentRelatedClientID(const ClientID: integer): integer;
var
  TmpQry: TERPQuery;
begin
  Result := 0;
  TmpQry := TERPQuery.create(nil);

  try
    TmpQry.Connection := CommonDBLib.GetSharedMyDacConnection;
    TmpQry.SQL.Text := 'SELECT ParentRelatedClientID FROM tblclients WHERE ClientID = ' + IntToStr(ClientID);
    TmpQry.Open;

    if not TmpQry.IsEmpty then Result := TmpQry.fieldbyname('ParentRelatedClientID').asInteger;

    TmpQry.close;
  finally FreeAndNil(TmpQry);
  end;
end;

function IsUSBPrinter(const Printername: string): boolean;
begin
  Result := SameText(Printername, PRINTER_EPSONTMU220) or
            sametext(Printername, PRINTER_EPSONT82II) Or
            SameText(Printername, PRINTER_STARTSP100);
end;

function PrinterTypes: TStrings;
begin
  Result := TStringList.create;
  Result.add('Epson' + #9 + 'EPSON');
  Result.add('Star' + #9 + 'STAR');
  Result.add('Citizen' + #9 + 'CITIZEN');
  Result.add('Citizen iDP460' + #9 + 'CTZ460');
  Result.add('Citizen iDP3540' + #9 + 'CTZ3540');
  Result.add('Hero TH200' + #9 + 'HERO');
  Result.add('Eltron Companion' + #9 + 'COMPANION');
  Result.add(PRINTER_EPSONTMU220 + #9 + 'EPSON-TM-U220');
  Result.add(PRINTER_EPSONT82II + #9 + 'EPSON-TM-T82II');
  Result.add(PRINTER_STARTSP100 + #9 + 'STAR-TSP-100');
end;

procedure PopulatePrintertypes(const Combo: TwwDBComboBox);
begin
  Combo.Items.clear;
  Combo.Items.add('Epson' + #9 + 'EPSON');
  Combo.Items.add('Star' + #9 + 'STAR');
  Combo.Items.add('Citizen' + #9 + 'CITIZEN');
  Combo.Items.add('Citizen iDP460' + #9 + 'CTZ460');
  Combo.Items.add('Citizen iDP3540' + #9 + 'CTZ3540');
  Combo.Items.add('Hero TH200' + #9 + 'HERO');
  Combo.Items.add('Eltron Companion' + #9 + 'COMPANION');
  Combo.Items.add(PRINTER_EPSONTMU220 + #9 + 'EPSON-TM-U220');
  Combo.Items.add(PRINTER_EPSONT82II + #9 + 'EPSON-TM-T82II');
  Combo.Items.add(PRINTER_STARTSP100 + #9 + 'STAR-TSP-100');
end;

procedure ChangeCurrencyNameinRAdioGroup(Sender: TwwRadioGroup);
var
  currencyName: string;
  x: integer;
begin
  { change currency name for region }
  currencyName := AppEnv.RegionalOptions.WholeCurrencyName;
  x := Sender.Items.IndexOf('Dollars');
  if x >= 0 then Sender.Items[x] := currencyName;
end;

procedure ChangeCurrencyNameinRAdioGroup(Sender: TRadioGroup);
var
  currencyName: string;
  x: integer;
begin
  { change currency name for region }
  currencyName := AppEnv.RegionalOptions.WholeCurrencyName;
  x := Sender.Items.IndexOf('Dollars');
  if x >= 0 then Sender.Items[x] := currencyName;
end;
Procedure SetfocusToERP;
begin
  Application.Restore;
  Application.BringToFront;
end;

end.
