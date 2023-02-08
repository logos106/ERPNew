unit AppEnvironmentVirtual;
 { NON-GUI library stuff }

interface

uses
  AppEnvVirtualObj, ProgressInfoObj, MyAccess, DB, ERPDbComponents, Contnrs;

Type

{$M+}
  TAppEnvVirtualGUI = class;

  TCommonDbLib = class
  private
    function GetGetSharedMyDAcConnection: TMyConnection;
    function GetGetMySQLTempDir: string;
    function GetGetTemporaryTableNameSuffix: string;
    function GetTempMyQuery: TMyQuery;
    function GetTempMyScript: TERPScript;
  public
    DbConnection: TMyConnection;
  published
    property GetSharedMyDAcConnection: TMyConnection read GetGetSharedMyDAcConnection;
    property GetMySQLTempDir: string read GetGetMySQLTempDir;
    property GetTemporaryTableNameSuffix: string read GetGetTemporaryTableNameSuffix;
    property TempMyQuery: TMyQuery read GetTempMyQuery;
    property TempMyScript: TERPScript read GetTempMyScript;
  end;

  TCompanyPrefs = class
  private
    function GetFiscalYearStarts: string;
    function GetBatchUpdateInProgress: boolean;
    function GetUseApprovalLevels: boolean;
    procedure SetBatchUpdateInProgress(const Value: boolean);
    function GetDbPrefRec(aName: string): TMyQuery;
    function GetIncludeUnInvoicedPOtoGL: boolean;
    function GetUnInvoicedPOAccount: integer;
    function GetIncludeUnInvoicedSOtoGL: boolean;
    function GetUnInvoicedSOType: integer;
    function GetUnInvoicedSOAccount: integer;
    function GetDepreciationForTransactions: integer;
    function GetShowActiveClassOnReports: boolean;
    function GetUseBatchTransactions: boolean;
    function GetSummarisedTransDate: TDateTime;
    function GetClosingDate: TDateTime;
    function GetClosingDateAP: TDateTime;
    function GetClosingDateAR: TDateTime;
    function GetSummarisedTransDateChanged: TDateTime;
    function getInventoryAssetBOMNonInvCogsAccount :String;
(*    function getNonInvProductcostinBOM1:Integer;
    function getNonInvProductcostinBOM2:Integer;
    function getNonInvProductcostinBOM3:Integer;*)
    procedure SetSummarisedTransDate(const Value: TDateTime);
    procedure SetClosingDate(const Value: TDateTime);
    procedure SetClosingDateAP(const Value: TDateTime);
    procedure SetClosingDateAR(const Value: TDateTime);
    function GetStockCostSystem: integer;
    function GetTransactionTableLastUpdated: TDateTime;
    procedure SetTransactionTableLastUpdated(const Value: TDateTime);
    function GetRewardPointssoldAccount: integer;
    function GetExpenseAccountforRewardPoints: integer;
    function GetRoundUpPoints: integer;
    function GetRewardPointsExpiredAccount: integer;
    function GetVerifyBalanceOnBatch: boolean;
    function GetReportTablesLastUpdatedOn: TDateTime;
    procedure SetReportTablesLastUpdatedOn(const Value: TDateTime);
    function getEnableScheduledreports: Boolean;
    function getIncludeLandedCostsinAvgCost: Boolean;
    function getEnableCogsAdjustmentPosting: Boolean;
    function getAccountPosingPopulated: Boolean;
    Procedure SetAccountPosingPopulated(const Value:Boolean);
    //function getProductAvgcostCalculatedForDepartment: Boolean;
    function getCompanyEmail: String;
    function getTradingname: String;
    function getZerotaxWhenLoss: Boolean;
    function getIncomeTaxPercentage: Double;
    function getNoOfMonthstoChangeClosingdate: Integer;
    function getProductListPriceMultiplier: double;
    function getProductListPriceMultiplierOn: String;
    function getDBName: String;
    function GetStandardCostPurchaseAdjustmentAccountID: integer;
    function GetDefPartsCOGSAccount: integer;
    function GetUseInventoryStandardCosting: boolean;
    function GetStandardCostCOGSAdjustmentAccountID: integer;
    function GetPOSBliandBalanceVarianceAccount: string;
    function GetPOSPostBlindBalanceVariance: boolean;
    function GetDosyncSerialnumberlist: boolean;
    function getStartWorkWeek: String;
//    function getCurrentWeekEndDate(dateVal : Tdatetime): Tdatetime;
    function getStartWorkWeekDay: Integer;
    function getNoofWeekendDays: Integer;
    function getEndWeekDay: Integer;
    function GetDoUpdateProductQtySum: boolean;
    function GetTrialBalanceAdjustAccount: integer;
    function GetDefaultBOMWastageAccount: string;
    function GetPickupShipingMethod: string;
    function GetBoMNonProductsubnodePostingAccount: string;
    function GetPOHasPeriodPosting: boolean;
    function GetCountSOBOInAvailable: boolean;
    function GetUpdatebatchRunVS1_sum                            : Boolean;
    function GetUpdatebatchRunVS1_PnLReport                      : Boolean;
    function GetUpdatebatchRunVS1_PnLReport_Sum                  : Boolean;
    function GetUpdatebatchRunVS1_APReport                       : Boolean;
    function GetUpdatebatchRunVS1_SalesList                      : Boolean;
    function GetUpdatebatchRunVS1_PQASumList                     : Boolean;
    function GetUpdatebatchRunVS1_Sum2                           : Boolean;
    function GetNonERPClone_User: string;
    function GetNonERPClone_Password: string;

  public
    DbConnection: TMyConnection;
  published
    property FiscalYearStarts: string read GetFiscalYearStarts;
    property BatchUpdateInProgress: boolean read GetBatchUpdateInProgress write SetBatchUpdateInProgress;
    property UseApprovalLevels: boolean read GetUseApprovalLevels ;
    property IncludeUnInvoicedPOtoGL: boolean read GetIncludeUnInvoicedPOtoGL;
    property UnInvoicedPOAccount: integer read GetUnInvoicedPOAccount;
    property IncludeUnInvoicedSOtoGL: boolean read GetIncludeUnInvoicedSOtoGL;
    property UnInvoicedSOType: integer read GetUnInvoicedSOType;
    property UnInvoicedSOAccount: integer read GetUnInvoicedSOAccount;
    property DepreciationForTransactions: integer read GetDepreciationForTransactions;
    property ShowActiveClassOnReports: boolean read GetShowActiveClassOnReports;
    property UseBatchTransactions: boolean read GetUseBatchTransactions;
    property SummarisedTransDateChanged: TDateTime read GetSummarisedTransDateChanged;
    Property InventoryAssetBOMNonInvCogsAccount :String read getInventoryAssetBOMNonInvCogsAccount;
(*    Property NonInvProductcostinBOM1 :Integer read getNonInvProductcostinBOM1;
    Property NonInvProductcostinBOM2 :Integer read getNonInvProductcostinBOM2;
    Property NonInvProductcostinBOM3 :Integer read getNonInvProductcostinBOM3;*)
    property SummarisedTransDate: TDateTime read GetSummarisedTransDate write SetSummarisedTransDate;
    property ClosingDate: TDateTime read GetClosingDate write SetClosingDate;
    property ClosingDateAP: TDateTime read GetClosingDateAP write SetClosingDateAP;
    property ClosingDateAR: TDateTime read GetClosingDateAR write SetClosingDateAR;
    property StockCostSystem: integer read GetStockCostSystem;
    property TransactionTableLastUpdated: TDateTime read GetTransactionTableLastUpdated write SetTransactionTableLastUpdated;
    property RewardPointssoldAccount: integer read GetRewardPointssoldAccount;
    property ExpenseAccountforRewardPoints: integer read GetExpenseAccountforRewardPoints;
    property RoundUpPoints: integer read GetRoundUpPoints;
    property RewardPointsExpiredAccount: integer read GetRewardPointsExpiredAccount;
    property VerifyBalanceOnBatch: boolean read GetVerifyBalanceOnBatch;
    property ReportTablesLastUpdatedOn: TDateTime read GetReportTablesLastUpdatedOn write SetReportTablesLastUpdatedOn;
    Property EnableScheduledreports : Boolean read getEnableScheduledreports;
    Property IncludeLandedCostsinAvgCost : Boolean read getIncludeLandedCostsinAvgCost;
    Property EnableCogsAdjustmentPosting : Boolean read getEnableCogsAdjustmentPosting;
    Property AccountPosingPopulated : Boolean read getAccountPosingPopulated write SetAccountPosingPopulated;
    //Property ProductAvgcostCalculatedForDepartment : Boolean read getProductAvgcostCalculatedForDepartment;
    Property CompanyEmail : String read getCompanyEmail;
    Property Tradingname :String read getTradingname;
    Property ZerotaxWhenLoss :Boolean read getZerotaxWhenLoss;
    Property IncomeTaxPercentage :Double read getIncomeTaxPercentage;
    Property ProductListPriceMultiplierOn :String read getProductListPriceMultiplierOn;
    Property ProductListPriceMultiplier :double read getProductListPriceMultiplier;
    Property NoOfMonthstoChangeClosingdate :Integer read getNoOfMonthstoChangeClosingdate;
    property StandardCostPurchaseAdjustmentAccountID: integer read GetStandardCostPurchaseAdjustmentAccountID;
    property DefPartsCOGSAccount: integer read GetDefPartsCOGSAccount;
    property StandardCostCOGSAdjustmentAccountID: integer read GetStandardCostCOGSAdjustmentAccountID;
    property UseInventoryStandardCosting: boolean read GetUseInventoryStandardCosting;
    Property DBName :String read getDBName;
    property POSPostBlindBalanceVariance: boolean read GetPOSPostBlindBalanceVariance;
    property DosyncSerialnumberlist: boolean read GetDosyncSerialnumberlist;
    property POSBliandBalanceVarianceAccount: string read GetPOSBliandBalanceVarianceAccount;
    Property StartWorkWeek :String read getStartWorkWeek;
    Property StartWorkWeekDay :Integer read getStartWorkWeekDay;
    Property NoofWeekendDays :Integer read getNoofWeekendDays;
    Property EndWeekDay :Integer read getEndWeekDay;
    property DoUpdateProductQtySum: boolean read GetDoUpdateProductQtySum;
    property TrialBalanceAdjustAccount: integer read GetTrialBalanceAdjustAccount;
    property DefaultBOMWastageAccount: string read GetDefaultBOMWastageAccount;
    property PickupShipingMethod: string read GetPickupShipingMethod;
    property BoMNonProductsubnodePostingAccount: string read GetBoMNonProductsubnodePostingAccount;
    property POHasPeriodPosting: boolean read GetPOHasPeriodPosting;
    property CountSOBOInAvailable: boolean read GetCountSOBOInAvailable;
    Property UpdatebatchRunVS1_sum: Boolean Read getUpdatebatchRunVS1_sum ;
    Property UpdatebatchRunVS1_PnLReport: Boolean Read getUpdatebatchRunVS1_PnLReport ;
    Property UpdatebatchRunVS1_PnLReport_Sum: Boolean Read getUpdatebatchRunVS1_PnLReport_Sum ;
    Property UpdatebatchRunVS1_APReport: Boolean Read getUpdatebatchRunVS1_APReport ;
    Property UpdatebatchRunVS1_SalesList: Boolean Read getUpdatebatchRunVS1_SalesList ;
    Property UpdatebatchRunVS1_PQASumList: Boolean Read getUpdatebatchRunVS1_PQASumList ;
    Property UpdatebatchRunVS1_Sum2: Boolean Read getUpdatebatchRunVS1_Sum2 ;
    property NonERPClone_User: string read GetNonERPClone_User;
    property NonERPClone_Password: string read GetNonERPClone_Password;
  end;

  TBranch = class
  private
    function GetSiteCode: string;
  public
    DbConnection: TMyConnection;
  published
    property SiteCode: string read GetSiteCode;
  end;

  TDNMLib = class
  private
    function GetGetCustomerPrepaymentAccountID: integer;
    function GetGetSupplierPrepaymentAccountID: integer;
    function GetIsTransTableEmpty: boolean;
    function GetAccountID(AccountName: string): integer;
  public
    DbConnection: TMyConnection;
    AppEnv: TAppEnvVirtualGUI;
  published
    property GetSupplierPrepaymentAccountID: integer read GetGetSupplierPrepaymentAccountID;
    property GetCustomerPrepaymentAccountID: integer read GetGetCustomerPrepaymentAccountID;
    property IsTransTableEmpty: boolean read GetIsTransTableEmpty;
  end;

  TTcConst = class
  private
    function GetGeneralRoundPlaces: integer;
    function GetDEFAULT_UOM: string;
    function GetWAITMSG: string;
    function GetCUSTOMER_PREPAYMENT: string;
    function GetUNDEPOSITED_FUNDS: string;
    function GetGLACCOUNT_TAX_COLLECTED: string;
    function GetGLACCOUNT_TAX_WEG: string;
    function GetGLACCOUNT_TAX_WET: string;
    function GetGLACCOUNT_TAX_PAID: string;
    function GetTABLE_PROFITANDLOSSREPORT: string;
  published
    property GeneralRoundPlaces: integer read GetGeneralRoundPlaces;
    property DEFAULT_UOM: string read GetDEFAULT_UOM;
    property WAITMSG: string read GetWAITMSG;
    property CUSTOMER_PREPAYMENT: string read GetCUSTOMER_PREPAYMENT;
    property UNDEPOSITED_FUNDS: string read GetUNDEPOSITED_FUNDS;
    property GLACCOUNT_TAX_COLLECTED: string read GetGLACCOUNT_TAX_COLLECTED;
    property GLACCOUNT_TAX_WEG: string read GetGLACCOUNT_TAX_WEG;
    property GLACCOUNT_TAX_WET: string read GetGLACCOUNT_TAX_WET;
    property GLACCOUNT_TAX_PAID: string read GetGLACCOUNT_TAX_PAID;
    property TABLE_PROFITANDLOSSREPORT: string read GetTABLE_PROFITANDLOSSREPORT;
  end;

  TRegionalOptions = class
  private
    function GetCurrencyRoundPlaces: integer;
    function getCurrencySymbol :String;
    function GetID: integer;
    function GetRegionRec: TDataset;
    function GetForeignExDefault: string;
    function GetRegion: string;
    function GetSLName: string;
  public
    DbConnection: TMyConnection;
  published
    property CurrencyRoundPlaces: integer read GetCurrencyRoundPlaces;
    Property CurrencySymbol :String read getCurrencySymbol;
    property ID: integer read GetID;
    property ForeignExDefault: string read GetForeignExDefault;
    property Region: string read GetRegion;
    property SLName: string read GetSLName;
  end;

  TEmployee = class
  private
    function GetLogonName: string;
    function getEmployeeId: Integer;
  Public
    DbConnection: TMyConnection;
  published
    property LogonName: string read GetLogonName;
    Property EmployeeId :Integer read getEmployeeId;
  end;

  TCommonLib = class
  private
    function GetDevMode: boolean;
  published
    property DevMode: boolean read GetDevMode;
    function Round(const Value: double; places: word): double;
  end;

  TPayPrefs = class
  private
    function GetShowAccruedAnnualLeaveLiability: boolean;
    function GetDbPrefRec(aName: string): TMyQuery;
    function GetShowAccruedSickLeaveLiability: boolean;
    function GetShowAccruedLongServiceLeaveLiability: boolean;
  public
    DbConnection: TMyConnection;
  published
    property ShowAccruedAnnualLeaveLiability: boolean read GetShowAccruedAnnualLeaveLiability;
    property ShowAccruedSickLeaveLiability: boolean read GetShowAccruedSickLeaveLiability;
    property ShowAccruedLongServiceLeaveLiability: boolean read GetShowAccruedLongServiceLeaveLiability;
  end;

  TDefaultClass = class
  private
    fDefaultUOM: string;
    function GetDefaultUOM: string;
  public
    DbConnection: TMyConnection;
    constructor Create;
  published
    property DefaultUOM: string read GetDefaultUOM;
  end;

  TCompanyInfo = class
  private
    function GetIndustryId: integer;
  public
    DbConnection: TMyConnection;
  published
    property IndustryId: integer read GetIndustryId;
  end;

  TAppEnvVirtualGUI = class(TAppEnvVirtual)
  private
    fCommonDbLib: TObject;
    fCompanyPrefs: TCompanyPrefs;
    fBranch: TBranch;
    fDNMLib: TDNMLib;
    fTcConst: TTcConst;
    fProgressInfo: TProgressInfo;
    fRegionalOptions: TRegionalOptions;
    fEmployee: TEmployee;
    fCommonLib: TCommonLib;
    fSharedDbConnection: TMyConnection;
    fPayPrefs: TPayPrefs;
    fDefaultClass: TDefaultClass;
    fCompanyInfo: TCompanyInfo;
    fServer: string;
    fApiMode: boolean;
    function GetCommonDbLib: TObject;
    function GetCompanyPrefs: TCompanyPrefs;
    function GetBranch: TObject;
    function GetDNMLib: TObject;
    function GetProgressInfo: TProgressInfo;
    procedure SetProgressInfo(const Value: TProgressInfo);
    function GetTcConst: TObject;
    function GetRegionalOptions: TObject;
    function GetEmployee: TObject;
    function GetCommonLib: TObject;
    function GetPayPrefs: TObject;
    procedure SetSharedDbConnection(const Value: TMyConnection);
    function GetDefaultClass: TObject;
    function GetCompanyInfo: TObject;
  protected
  public
    constructor Create(aAPIMode: boolean);
    destructor Destroy; override;
    procedure PopulateCompanyPrefs; override;
    function GetEmployeeAccessLevel(const FormName: string; const EmployeeID: integer = 0): integer; override;
    procedure DeleteServerFiles(const aFileNameMask: string); override;
    Function showWarning(const Value:String):Boolean;Override;
    Procedure LogText(const Value:String);Override;
    Procedure LogTextLoge(const Value:String);Override;
    function Round(const Value: double; places: word): double;override;
  published
    property CommonDbLib: TObject read GetCommonDbLib;
    property CompanyPrefs: TCompanyPrefs read GetCompanyPrefs;
    property Branch: TObject read GetBranch;
    property DNMLib: TObject read GetDNMLib;
    property TcConst: TObject read GetTcConst;
    property RegionalOptions: TObject read GetRegionalOptions;
    property Employee: TObject read GetEmployee;
    property ProgressInfo: TProgressInfo read GetProgressInfo write SetProgressInfo;
    property CommonLib: TObject read GetCommonLib;
    property SharedDbConnection: TMyConnection read fSharedDbConnection write SetSharedDbConnection;
    property PayPrefs: TObject read GetPayPrefs;
    property DefaultClass: TObject read GetDefaultClass;
    property CompanyInfo: TObject read GetCompanyInfo;
    property Server: string read fServer write fServer;
    property ApiMode: boolean read fApiMode write fApiMode;
  end;
{$M-}

  TAppEnvironmentList = class(TObjectList)
  private
    fMySQLServer: string;
    fAPIMode: boolean;
  public
    constructor Create; overload;
    constructor Create(AOwnesObjects: boolean); overload;
    procedure RemoveAppEnvInstance(const aThreadId: cardinal = 0);
    function AppEnvForThread(const ThreadId: cardinal; AutoCreate: boolean = false): TAppEnvVirtualGUI;
    property MySQLServer: string read fMySQLServer write fMySQLServer;
    property APIMode: boolean read fAPIMode write fAPIMode;
  end;


var
  fAppEnvVirt :TAppEnvVirtual;

  function AppEnvVirt :TAppEnvVirtual;

var
  AppEnvList :TAppEnvironmentList;

implementation

uses
  sysutils, types, MachineSignature, ModuleConst, Windows, SyncObjs,
  DecimalRounding , DateUtils
   {CommonDbLib, AppEnvironment, DNMLib, tcConst,}
  {, ProgressInfoDlgObj}, DateTimeUtils;


const
  { tcConst }
  _CUSTOMER_PREPAYMENT = 'Customer Prepayment';
  _UNDEPOSITED_FUNDS = 'Undeposited Funds';
  _SUPPLIER_PREPAYMENT = 'Supplier Prepayment';
  _DEFAULT_UOM = 'Units';
  _WAITMSG = 'Please Wait...';
  _GeneralRoundPlaces =5;
  _GLACCOUNT_TAX_COLLECTED = 'Tax Collected';
  _GLACCOUNT_TAX_PAID = 'Tax Paid';
  _GLACCOUNT_TAX_WEG       = 'WEG';
  _GLACCOUNT_TAX_WET       = 'WET';
  _GLACCOUNT_CUSTPREPAYMENT= 'Customer Prepayments';
  _GLACCOUNT_SUPPPREPAYMENT= 'Supplier Prepayments';

  _TABLE_PROFITANDLOSSREPORT = 'tmp_profitandlossreport';


var
  AppEnvListLock :TCriticalSection;


function AppEnvVirt :TAppEnvVirtual;
begin
  Result := AppEnvList.AppEnvForThread(GetCurrentThreadID,true);
//  if not Assigned(fAppEnvVirt) then
//    fAppEnvVirt := TAppEnvVirtualGUI.Create;
//
//  result := fAppEnvVirt;
end;

{ TAppEnvVirtualGUI }

constructor TAppEnvVirtualGUI.Create(aAPIMode: boolean);
begin
  fApiMode := aApiMode;
  inherited Create;
end;

procedure TAppEnvVirtualGUI.DeleteServerFiles(const aFileNameMask: string);
var
  SearchRec: TSearchRec;
  Found: integer;
  sFile: string;
  sPath: string;
Begin
  { path may me in MySQL (linex) format so change to windows }
  sPath:= ExtractFilePath(StringReplace(aFileNameMask,'/','\',[rfReplaceAll]));
  Found := FindFirst(aFileNameMask, faAnyFile, SearchRec);
  try
    while (Found = 0) do begin
      if not (SearchRec.Attr and faDirectory > 0) then begin
        sFile := SearchRec.Name;
        SysUtils.DeleteFile(sPath + sFile);
      end;
      Found := SysUtils.FindNext(SearchRec);
    end;
  finally
    SysUtils.FindClose(SearchRec);
  end;
end;

destructor TAppEnvVirtualGUI.Destroy;
begin
  fCommonDbLib.Free;
  fCompanyPrefs.Free;
  fBranch.Free;
  fDNMLib.Free;
  fTcConst.Free;
  fRegionalOptions.Free;
  fEmployee.Free;
  fCommonLib.Free;
  fProgressInfo.Free;
  fDefaultClass.Free;
  fCompanyInfo.Free;
  inherited;
end;

function TAppEnvVirtualGUI.GetBranch: TObject;
begin
  if not Assigned(fBranch) then begin
    fBranch:= TBranch.Create;
    TBranch(fBranch).DbConnection := self.SharedDbConnection;
  end;
  result := fBranch;
end;

function TAppEnvVirtualGUI.GetCommonDbLib: TObject;
begin
  if not Assigned(fCommonDbLib) then begin
    fCommonDbLib := TCommonDbLib.Create;
    TCommonDbLib(fCommonDbLib).DbConnection := self.SharedDbConnection;
  end;
  result := fCommonDbLib;
end;

function TAppEnvVirtualGUI.GetCommonLib: TObject;
begin
  if not Assigned(fCommonLib) then
    fCommonLib := TCommonLib.Create;
  result := fCommonLib;
end;

function TAppEnvVirtualGUI.GetCompanyInfo: TObject;
begin
  if not Assigned(fCompanyInfo) then
    fCompanyInfo := TCompanyInfo.Create;
  result := fCompanyInfo;
end;

function TAppEnvVirtualGUI.GetCompanyPrefs: TCompanyPrefs;
begin
  if not Assigned(fCompanyPrefs) then begin
    fCompanyPrefs := TCompanyPrefs.Create;
    TCompanyPrefs(fCompanyPrefs).DbConnection := self.SharedDbConnection;
  end;
  result := fCompanyPrefs;
end;

function TAppEnvVirtualGUI.GetDefaultClass: TObject;
begin
  if not Assigned(fDefaultClass) then begin
    fDefaultClass := TDefaultClass.Create;
    fDefaultClass.DbConnection := self.SharedDbConnection;
  end;
  result := fDefaultClass;
end;

function TAppEnvVirtualGUI.GetDNMLib: TObject;
begin
  if not Assigned(fDNMLib) then begin
    fDNMLib := TDNMLib.Create;
    TDNMLib(fDNMLib).DbConnection := self.SharedDbConnection;
    TDNMLib(fDNMLib).AppEnv := self;
  end;
  result:= fDNMLib;
end;

function TAppEnvVirtualGUI.GetEmployee: TObject;
begin
  if not Assigned(fEmployee) then begin
    fEmployee := TEmployee.Create;
    TEmployee(fEmployee).DbConnection := self.SharedDbConnection;
  end;
  result := fEmployee;
end;

function TAppEnvVirtualGUI.GetEmployeeAccessLevel(const FormName: string;
  const EmployeeID: integer): integer;
begin
  result := 1;
end;

function TAppEnvVirtualGUI.GetPayPrefs: TObject;
begin
  if not Assigned(fPayPrefs) then begin
    fPayPrefs := TPayPrefs.Create;
    TPayPrefs(fPayPrefs).DbConnection := self.SharedDbConnection;
  end;
  result := fPayPrefs;
end;

function TAppEnvVirtualGUI.GetProgressInfo: TProgressInfo;
begin
  if not Assigned(fProgressInfo) then
    fProgressInfo := TProgressInfo.Create;
  result := fProgressInfo;
end;

function TAppEnvVirtualGUI.GetRegionalOptions: TObject;
begin
  if not Assigned(fRegionalOptions) then begin
    fRegionalOptions := TRegionalOptions.Create;
    TRegionalOptions(fRegionalOptions).DbConnection := self.SharedDbConnection;
  end;
  result := fRegionalOptions;
end;

function TAppEnvVirtualGUI.GetTcConst: TObject;
begin
  if not Assigned(fTcConst) then
    fTcConst := TTcConst.Create;
  result := fTcConst;
end;

procedure TAppEnvVirtualGUI.LogText(const Value: String);
begin
  exit;
end;

procedure TAppEnvVirtualGUI.LogTextLoge(const Value: String);
begin
  inherited;
  Exit;
end;

procedure TAppEnvVirtualGUI.PopulateCompanyPrefs;
begin
  inherited;

end;

function TAppEnvVirtualGUI.Round(const Value: double; places: word): double;
begin
  result := TCommonLib(Commonlib).Round(Value, Places);
end;

procedure TAppEnvVirtualGUI.SetProgressInfo(const Value: TProgressInfo);
begin
  fProgressInfo := Value;
end;

procedure TAppEnvVirtualGUI.SetSharedDbConnection(const Value: TMyConnection);
begin
  fSharedDbConnection := Value;
end;

Function TAppEnvVirtualGUI.showWarning(const Value:String):Boolean;
begin
  inherited;
  Result := False;
end;

{ TCommonDbLib }

function TCommonDbLib.GetGetMySQLTempDir: string;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection := DbConnection;
    qry.SQL.Text:= 'select @@tmpdir';
    qry.Open;
    result:= qry.Fields[0].AsString+'\';
  finally
    qry.Free;
  end;
end;

function TCommonDbLib.GetGetSharedMyDAcConnection: TMyConnection;
begin
  result := DbConnection;
end;

function TCommonDbLib.GetGetTemporaryTableNameSuffix: string;
begin
  result:= ModuleConst.ERP_ADMIN_USER + '_' + MachineSignature.GetMachineIdentification(true, true, true, true);
end;

function TCommonDbLib.GetTempMyQuery: TMyQuery;
begin
  result := TMyQuery.Create(nil);
  result.Connection := DbConnection;
end;

function TCommonDbLib.GetTempMyScript: TERPScript;
begin
  result := TERPScript.Create(nil);
  result.Connection := DbConnection;
end;

{ TCompanyPrefs }

function TCompanyPrefs.GetBatchUpdateInProgress: boolean;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection := DbConnection;
    qry.SQL.Add('select * from tblDbPreferences where Name = "BatchUpdateInProgress"');
    qry.Open;
    result := SameText(qry.FieldByName('FieldValue').AsString,'T');
  finally
    qry.Free;
  end;
end;
function TCompanyPrefs.GetUseApprovalLevels: boolean;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection := DbConnection;
    qry.SQL.Add('select * from tblDbPreferences where Name = "UseApprovalLevels"');
    qry.Open;
    result := SameText(qry.FieldByName('FieldValue').AsString,'T');
  finally
    qry.Free;
  end;
end;
function TCompanyPrefs.GetDepreciationForTransactions: integer;
begin
  with GetDbPrefRec('DepreciationForTransactions') do try
    result := StrToIntDef(FieldByName('FieldValue').AsString,0);
  finally
    Free;
  end;
end;

function TCompanyPrefs.GetDbPrefRec(aName: string): TMyQuery;
begin
  Result := TMyQuery.Create(nil);
  Result.Connection := DbConnection;
  Result.SQL.Add('SELECT * FROM tblDbPreferences WHERE Name = ' + QuotedStr(aName));
  Result.Open;
end;
function TCompanyPrefs.getEnableScheduledreports: Boolean;
begin
  with GetDbPrefRec('EnableScheduledreports') do begin
    result := SameText(FieldByName('FieldValue').AsString, 'T');
    Free;
  end;
end;

function TCompanyPrefs.getIncludeLandedCostsinAvgCost: Boolean;
begin
  with GetDbPrefRec('IncludeLandedCostsinAvgCost') do begin
    result := SameText(FieldByName('FieldValue').AsString, 'T');
    Free;
  end;
end;
function TCompanyPrefs.getEnableCogsAdjustmentPosting: Boolean;
begin
  with GetDbPrefRec('EnableCogsAdjustmentPosting') do begin
    result := SameText(FieldByName('FieldValue').AsString, 'T');
    Free;
  end;
end;
function TCompanyPrefs.getAccountPosingPopulated: Boolean;
begin
  with GetDbPrefRec('AccountPosingPopulated') do begin
    result := SameText(FieldByName('FieldValue').AsString, 'T');
    Free;
  end;
end;
(*function TCompanyPrefs.getProductAvgcostCalculatedForDepartment: Boolean;
begin
  with GetDbPrefRec('ProductAvgcostCalculatedForDepartment') do begin
    result := SameText(FieldByName('FieldValue').AsString, 'T');
    Free;
  end;
end;*)
function TCompanyPrefs.getCompanyEmail: String;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection := DbConnection;
    qry.SQL.Add('select email from tblcompanyinformation');
    qry.Open;
    result := qry.FieldByName('email').AsString;
  finally
    qry.Free;
  end;

end;

function TCompanyPrefs.getDBName: String;
begin
  REsult := DbConnection.database;
end;

function TCompanyPrefs.GetExpenseAccountforRewardPoints: integer;
begin
  with GetDbPrefRec('ExpenseAccountforRewardPoints') do begin
    result := StrToIntDef(FieldByName('FieldValue').AsString,0);
    Free;
  end;
end;

function TCompanyPrefs.GetFiscalYearStarts: string;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection := DbConnection;
    qry.SQL.Add('select * from tblDbPreferences where Name = "FiscalYearStarts"');
    qry.Open;
    result := qry.FieldByName('FieldValue').AsString;
  finally
    qry.Free;
  end;
end;

function TCompanyPrefs.GetIncludeUnInvoicedPOtoGL: boolean;
begin
  with GetDbPrefRec('IncludeUnInvoicedPOtoGL') do begin
    result := SameText(FieldByName('FieldValue').AsString, 'T');
    Free;
  end;
end;

function TCompanyPrefs.GetIncludeUnInvoicedSOtoGL: boolean;
begin
  with GetDbPrefRec('IncludeUnInvoicedSOtoGL') do begin
    result := SameText(FieldByName('FieldValue').AsString, 'T');
    Free;
  end;
end;

function TCompanyPrefs.getIncomeTaxPercentage: Double;
begin
  with GetDbPrefRec('IncomeTaxPercentage') do begin
    result := FieldByName('FieldValue').asFloat;
    Free;
  end;
end;

function TCompanyPrefs.getNoOfMonthstoChangeClosingdate: Integer;
begin
  with GetDbPrefRec('NoOfMonthstoChangeClosingdate') do begin
    result := FieldByName('FieldValue').asInteger;
    Free;
  end;

end;

function TCompanyPrefs.GetPOSBliandBalanceVarianceAccount: string;
begin
  with GetDbPrefRec('POSBliandBalanceVarianceAccount') do begin
    result := FieldByName('FieldValue').AsString;
    Free;
  end;
end;
function TCompanyPrefs.GetDefaultBOMWastageAccount: string;
begin
  with GetDbPrefRec('DefaultBOMWastageAccount') do begin
    result := FieldByName('FieldValue').AsString;
    Free;
  end;
end;
function TCompanyPrefs.GetPickupShipingMethod: string;
begin
  with GetDbPrefRec('PickupShipingMethod') do begin
    result := FieldByName('FieldValue').AsString;
    Free;
  end;
end;
function TCompanyPrefs.GetNonERPClone_User: string;
begin
  with GetDbPrefRec('NonERPClone_User') do begin
    result := FieldByName('FieldValue').AsString;
    Free;
  end;
end;
function TCompanyPrefs.GetNonERPClone_Password: string;
begin
  with GetDbPrefRec('NonERPClone_Password') do begin
    result := FieldByName('FieldValue').AsString;
    Free;
  end;
end;
function TCompanyPrefs.GetBoMNonProductsubnodePostingAccount: string;
begin
  with GetDbPrefRec('BoMNonProductsubnodePostingAccount') do begin
    result := FieldByName('FieldValue').AsString;
    Free;
  end;
end;
function TCompanyPrefs.GetPOSPostBlindBalanceVariance: boolean;
begin
  with GetDbPrefRec('POSPostBlindBalanceVariance') do begin
    result := SameText(FieldByName('FieldValue').AsString, 'T');
    Free;
  end;
end;
function TCompanyPrefs.GetDosyncSerialnumberlist: boolean;
begin
  with GetDbPrefRec('DosyncSerialnumberlist') do begin
    result := SameText(FieldByName('FieldValue').AsString, 'T');
    Free;
  end;
end;
function TCompanyPrefs.GetDoUpdateProductQtySum: boolean;
begin
  with GetDbPrefRec('DoUpdateProductQtySum') do begin
    result := SameText(FieldByName('FieldValue').AsString, 'T');
    Free;
  end;
end;
function TCompanyPrefs.GetPOHasPeriodPosting: boolean;
begin
  with GetDbPrefRec('POHasPeriodPosting') do begin
    result := SameText(FieldByName('FieldValue').AsString, 'T');
    Free;
  end;
end;

function TCompanyPrefs.GetCountSOBOInAvailable: boolean;
begin
  with GetDbPrefRec('CountSOBOInAvailable') do begin
    result := SameText(FieldByName('FieldValue').AsString, 'T');
    Free;
  end;
end;

function TCompanyPrefs.getUpdatebatchRunVS1_sum                     : Boolean; begin with GetDbPrefRec('UpdatebatchRunVS1_sum')           do begin result := SameText(FieldByName('FieldValue').AsString, 'T'); Free; end;end;
function TCompanyPrefs.getUpdatebatchRunVS1_PnLReport               : Boolean; begin with GetDbPrefRec('UpdatebatchRunVS1_PnLReport')     do begin result := SameText(FieldByName('FieldValue').AsString, 'T'); Free; end;end;
function TCompanyPrefs.getUpdatebatchRunVS1_PnLReport_Sum           : Boolean; begin with GetDbPrefRec('UpdatebatchRunVS1_PnLReport_Sum') do begin result := SameText(FieldByName('FieldValue').AsString, 'T'); Free; end;end;
function TCompanyPrefs.getUpdatebatchRunVS1_APReport                : Boolean; begin with GetDbPrefRec('UpdatebatchRunVS1_APReport')      do begin result := SameText(FieldByName('FieldValue').AsString, 'T'); Free; end;end;
function TCompanyPrefs.getUpdatebatchRunVS1_SalesList               : Boolean; begin with GetDbPrefRec('UpdatebatchRunVS1_SalesList')     do begin result := SameText(FieldByName('FieldValue').AsString, 'T'); Free; end;end;
function TCompanyPrefs.getUpdatebatchRunVS1_PQASumList              : Boolean; begin with GetDbPrefRec('UpdatebatchRunVS1_PQASumList')    do begin result := SameText(FieldByName('FieldValue').AsString, 'T'); Free; end;end;
function TCompanyPrefs.getUpdatebatchRunVS1_Sum2                    : Boolean; begin with GetDbPrefRec('UpdatebatchRunVS1_Sum2')          do begin result := SameText(FieldByName('FieldValue').AsString, 'T'); Free; end;end;

function TCompanyPrefs.GetTrialBalanceAdjustAccount: integer;
begin
  with GetDbPrefRec('TrialBalanceAdjustAccount') do begin
    result := FieldByName('FieldValue').asInteger;
    Free;
  end;
end;

function TCompanyPrefs.getProductListPriceMultiplier: double;
begin
  with GetDbPrefRec('ProductListPriceMultiplier') do begin
    result := FieldByName('FieldValue').asFloat;
    Free;
  end;

end;

function TCompanyPrefs.getProductListPriceMultiplierOn: String;
begin
  with GetDbPrefRec('ProductListPriceMultiplierOn') do begin
    result := FieldByName('FieldValue').asString;
    Free;
  end;

end;

function TCompanyPrefs.GetReportTablesLastUpdatedOn: TDateTime;
begin
  with GetDbPrefRec('ReportTablesLastUpdatedOn') do begin
    result := StrToFloatDef(FieldByName('FieldValue').AsString,0);
    Free;
  end;
end;

function TCompanyPrefs.GetRewardPointsExpiredAccount: integer;
begin
  with GetDbPrefRec('RewardPointsExpiredAccount') do begin
    result := StrToIntDef(FieldByName('FieldValue').AsString,0);
    Free;
  end;
end;

function TCompanyPrefs.GetRewardPointssoldAccount: integer;
begin
  with GetDbPrefRec('RewardPointssoldAccount') do begin
    result := StrToIntDef(FieldByName('FieldValue').AsString,0);
    Free;
  end;
end;

function TCompanyPrefs.GetRoundUpPoints: integer;
begin
  with GetDbPrefRec('RoundUpPoints') do begin
    result := StrToIntDef(FieldByName('FieldValue').AsString,0);
    Free;
  end;
end;

function TCompanyPrefs.GetShowActiveClassOnReports: boolean;
begin
  with GetDbPrefRec('ShowActiveClassOnReports') do begin
    result := SameText(FieldByName('FieldValue').AsString, 'T');
    Free;
  end;
end;

function TCompanyPrefs.GetStandardCostCOGSAdjustmentAccountID: integer;
begin
  with GetDbPrefRec('StandardCostCOGSAdjustmentAccountID') do begin
    result := FieldByName('FieldValue').asInteger;
    Free;
  end;
end;

function TCompanyPrefs.GetStandardCostPurchaseAdjustmentAccountID: integer;
begin
  with GetDbPrefRec('StandardCostPurchaseAdjustmentAccountID') do begin
    result := FieldByName('FieldValue').asInteger;
    Free;
  end;
end;
function TCompanyPrefs.GetDefPartsCOGSAccount: integer;
begin
  with GetDbPrefRec('DefPartsCOGSAccount') do begin
    result := FieldByName('FieldValue').asInteger;
    Free;
  end;
end;

function TCompanyPrefs.GetStockCostSystem: integer;
begin
  with GetDbPrefRec('StockCostSystem') do begin
    result := StrToIntDef(FieldByName('FieldValue').AsString,0);
    Free;
  end;
end;

function TCompanyPrefs.GetSummarisedTransDate: TDateTime;
begin
  with GetDbPrefRec('SummarisedTransDate') do begin
    result := StrToFloatDef(FieldByName('FieldValue').AsString,0);
    Free;
  end;
end;
function TCompanyPrefs.GetClosingDate: TDateTime;
begin
  with GetDbPrefRec('ClosingDate') do begin
    result := StrToFloatDef(FieldByName('FieldValue').AsString,0);
    Free;
  end;
end;
function TCompanyPrefs.GetClosingDateAP: TDateTime;
begin
  with GetDbPrefRec('ClosingDateAP') do begin
    result := StrToFloatDef(FieldByName('FieldValue').AsString,0);
    Free;
  end;
end;
function TCompanyPrefs.GetClosingDateAR: TDateTime;
begin
  with GetDbPrefRec('ClosingDateAR') do begin
    result := StrToFloatDef(FieldByName('FieldValue').AsString,0);
    Free;
  end;
end;

function TCompanyPrefs.GetInventoryAssetBOMNonInvCogsAccount:String;
begin
  with GetDbPrefRec('InventoryAssetBOMNonInvCogsAccount') do begin
    result := FieldByName('FieldValue').asString;
    Free;
  end;
end;

(*function TCompanyPrefs.GetNonInvProductcostinBOM1 :Integer;
begin
  with GetDbPrefRec('NonInvProductcostinBOM1') do begin
    result := StrTointDef(FieldByName('FieldValue').AsString,0);
    Free;
  end;
end;
function TCompanyPrefs.GetNonInvProductcostinBOM2 :Integer;
begin
  with GetDbPrefRec('NonInvProductcostinBOM2') do begin
    result := StrTointDef(FieldByName('FieldValue').AsString,0);
    Free;
  end;
end;
function TCompanyPrefs.GetNonInvProductcostinBOM3 :Integer;
begin
  with GetDbPrefRec('NonInvProductcostinBOM3') do begin
    result := StrTointDef(FieldByName('FieldValue').AsString,0);
    Free;
  end;
end;*)
function TCompanyPrefs.GetSummarisedTransDateChanged: TDateTime;
begin
  with GetDbPrefRec('SummarisedTransDateChanged') do begin
    result := StrToFloatDef(FieldByName('FieldValue').AsString,0);
    Free;
  end;
end;

function TCompanyPrefs.getTradingname: String;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection := DbConnection;
    qry.SQL.Add('select Tradingname from tblcompanyinformation');
    qry.Open;
    result := qry.FieldByName('Tradingname').AsString;
  finally
    qry.Free;
  end;
end;

function TCompanyPrefs.GetTransactionTableLastUpdated: TDateTime;
begin
  with GetDbPrefRec('TransactionTableLastUpdated') do begin
    result := StrToFloatDef(FieldByName('FieldValue').AsString,0);
    Free;
  end;
end;

function TCompanyPrefs.GetUnInvoicedPOAccount: integer;
begin
  with GetDbPrefRec('UnInvoicedPOAccount') do begin
    result := StrToIntDef(FieldByName('FieldValue').AsString,0);
    Free;
  end;
end;

function TCompanyPrefs.GetUnInvoicedSOAccount: integer;
begin
  with GetDbPrefRec('UnInvoicedSOAccount') do begin
    result := StrToIntDef(FieldByName('FieldValue').AsString,0);
    Free;
  end;
end;

function TCompanyPrefs.GetUnInvoicedSOType: integer;
begin
  with GetDbPrefRec('UnInvoicedSOType') do begin
    result := StrToIntDef(FieldByName('FieldValue').AsString,0);
    Free;
  end;
end;

function TCompanyPrefs.GetUseBatchTransactions: boolean;
begin
  with GetDbPrefRec('UseBatchTransactions') do begin
    result := SameText(FieldByName('FieldValue').AsString, 'T');
    Free;
  end;
end;

function TCompanyPrefs.GetUseInventoryStandardCosting: boolean;
begin
  with GetDbPrefRec('UseInventoryStandardCosting') do begin
    result := SameText(FieldByName('FieldValue').AsString, 'T');
    Free;
  end;
end;

function TCompanyPrefs.GetVerifyBalanceOnBatch: boolean;
begin
  with GetDbPrefRec('VerifyBalanceOnBatch') do begin
    result := SameText(FieldByName('FieldValue').AsString, 'T');
    Free;
  end;
end;

function TCompanyPrefs.getZerotaxWhenLoss: Boolean;
begin
  with GetDbPrefRec('ZerotaxWhenLoss') do begin
    result := SameText(FieldByName('FieldValue').AsString, 'T');
    Free;
  end;
end;

procedure TCompanyPrefs.SetBatchUpdateInProgress(const Value: boolean);
var
  cmd: TMyCommand;
begin
  cmd:= TMyCommand.Create(nil);
  try
    cmd.Connection := DbConnection;
    if Value then
      cmd.SQL.Add('update tblDbPreferences set FieldValue = "T" where Name = "BatchUpdateInProgress"')
    else
      cmd.SQL.Add('update tblDbPreferences set FieldValue = "F" where Name = "BatchUpdateInProgress"');
    cmd.Execute;
  finally
    cmd.Free;
  end;
end;

procedure TCompanyPrefs.SetReportTablesLastUpdatedOn(const Value: TDateTime);
begin
  with GetDbPrefRec('ReportTablesLastUpdatedOn') do begin
    Edit;
    FieldByName('FieldValue').AsString := FloatToStr(Value);
    Post;
    Free;
  end;
end;

procedure TCompanyPrefs.SetSummarisedTransDate(const Value: TDateTime);
begin
  with GetDbPrefRec('SummarisedTransDate') do begin
    Edit;
    FieldByName('FieldValue').AsString := FloatToStr(Value);
    Post;
    Free;
  end;
end;
procedure TCompanyPrefs.SetAccountPosingPopulated(const Value:Boolean);
begin
  with GetDbPrefRec('AccountPosingPopulated') do begin
    Edit;
    FieldByName('FieldValue').asBoolean := Value;
    Post;
    Free;
  end;
end;

procedure TCompanyPrefs.SetClosingDate(const Value: TDateTime);
begin
  with GetDbPrefRec('ClosingDate') do begin
    Edit;
    FieldByName('FieldValue').AsString := FloatToStr(Value);
    Post;
    Free;
  end;
end;
procedure TCompanyPrefs.SetClosingDateAP(const Value: TDateTime);
begin
  with GetDbPrefRec('ClosingDateAP') do begin
    Edit;
    FieldByName('FieldValue').AsString := FloatToStr(Value);
    Post;
    Free;
  end;
end;
procedure TCompanyPrefs.SetClosingDateAR(const Value: TDateTime);
begin
  with GetDbPrefRec('ClosingDateAR') do begin
    Edit;
    FieldByName('FieldValue').AsString := FloatToStr(Value);
    Post;
    Free;
  end;
end;

procedure TCompanyPrefs.SetTransactionTableLastUpdated(const Value: TDateTime);
begin
  with GetDbPrefRec('TransactionTableLastUpdated') do begin
    Edit;
    FieldByName('FieldValue').AsString:= FloatToStr(Value);
    Post;
    Free;
  end;
end;

{ TBranch }

function TBranch.GetSiteCode: string;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection := DbConnection;
    qry.SQL.Add('select * from tblmsbackendid');
    qry.Open;
    result := qry.FieldByName('SiteCode').AsString;
  finally
    qry.Free;
  end;
end;

{ TDNMLib }

function TDNMLib.GetAccountID(AccountName: string): integer;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection := DbConnection;
    qry.SQL.add('SELECT AccountID FROM tblchartofaccounts Where AccountName  = ' + quotedStr(AccountName) + ';');
    qry.Open;
    result := qry.FieldByName('AccountID').AsInteger;
  finally
    qry.Free;
  end;
end;

function TDNMLib.GetGetCustomerPrepaymentAccountID: integer;
begin
  result := GetAccountID(_GLACCOUNT_CUSTPREPAYMENT);
end;

function TDNMLib.GetGetSupplierPrepaymentAccountID: integer;
begin
  result := GetAccountID(_GLACCOUNT_SUPPPREPAYMENT);
end;

function TDNMLib.GetIsTransTableEmpty: boolean;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.create(nil);
  qryTemp.Connection := dbConnection;
  try
    qryTemp.SQL.add('SELECT Count(TransID) as Count FROM `tbltransactions`;');
    qryTemp.Open;
    if (qryTemp.fieldbyname('Count').asInteger > 0) and (not AppEnv.CompanyPrefs.BatchUpdateInProgress) then begin
      Result := false;
    end else begin
      Result := true;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

{ TTcConst }

function TTcConst.GetCUSTOMER_PREPAYMENT: string;
begin
  result := _CUSTOMER_PREPAYMENT;
end;
function TTcConst.GetUNDEPOSITED_FUNDS: string;
begin
  result := _UNDEPOSITED_FUNDS;
end;

function TTcConst.GetDEFAULT_UOM: string;
begin
  result := _DEFAULT_UOM;
end;

function TTcConst.GetGeneralRoundPlaces: integer;
begin
  result := _GeneralRoundPlaces;
end;

function TTcConst.GetGLACCOUNT_TAX_COLLECTED: string;
begin
  result := _GLACCOUNT_TAX_COLLECTED;
end;

function TTcConst.GetGLACCOUNT_TAX_PAID: string;
begin
  result := _GLACCOUNT_TAX_PAID;
end;

function TTcConst.GetGLACCOUNT_TAX_WEG: string;
begin
  result := _GLACCOUNT_TAX_WEG;
end;

function TTcConst.GetGLACCOUNT_TAX_WET: string;
begin
  result := _GLACCOUNT_TAX_WET;
end;

function TTcConst.GetTABLE_PROFITANDLOSSREPORT: string;
begin
  result := _TABLE_PROFITANDLOSSREPORT;
end;

function TTcConst.GetWAITMSG: string;
begin
  result := _WAITMSG;
end;

{ TRegionalOptions }

function TRegionalOptions.GetCurrencyRoundPlaces: integer;
begin
  with GetRegionRec do begin
    result := FieldByName('DecimalPlaces').AsInteger;
    Free;
  end;
end;
function TRegionalOptions.GetCurrencySymbol:String;
begin
  with GetRegionRec do begin
    result := FieldByName('CurrencySymbol').AsString;
    Free;
  end;
end;

function TRegionalOptions.GetForeignExDefault: string;
begin
  with GetRegionRec do begin
    result := FieldByName('ForeignExDefault').AsString;
    Free;
  end;
end;
function TRegionalOptions.GetRegion: string;
begin
  with GetRegionRec do begin
    result := FieldByName('Region').AsString;
    Free;
  end;
end;
function TRegionalOptions.GetSLName: string;
begin
  with GetRegionRec do begin
    result := FieldByName('SLName').AsString;
    Free;
  end;
end;

function TRegionalOptions.GetID: integer;
begin
  with GetRegionRec do begin
    result := FieldByName('RegionID').AsInteger;
    Free;
  end;
end;

function TRegionalOptions.GetRegionRec: TDataset;
begin
  result := TMyQuery.Create(nil);
  TMyQuery(result).Connection := DbConnection;
  TMyQuery(result).SQL.Add('select R.* from tblRegionalOptions R, tblDbPreferences P where');
  TMyQuery(result).SQL.Add('R.Region = P.FieldValue and P.Name = "CompanyRegion"');
  result.Open;
end;

{ TEmployee }


function TEmployee.getEmployeeId: Integer;
var
  qry: TMyQuery;
begin
    Result := 0;
    qry := TMyQuery.Create(nil);
    try
      qry.Connection := DBConnection;
      qry.SQL.Text := 'SELECT E.EmployeeID FROM tblpassword P INNER JOIN tblemployees E ON E.EmployeeID = P.EmployeeId WHERE P.Logon_Name = ' +quotedstr(LogonName);
      qry.Open;
      result := qry.Fieldbyname('Employeeid').asInteger;
    finally
      qry.Free;
    end;
end;

function TEmployee.GetLogonName: string;
begin
  result := ModuleConst.ERP_ADMIN_USER;
end;

{ TCommonLib }

function TCommonLib.GetDevMode: boolean;
begin
  result := false;
end;


function TCommonLib.Round(const Value: double; places: word): double;
begin
  result := Value;
  if Value = 0 then exit;
  result := DecimalRoundDbl(Value, Places, drHalfUp);
end;

{ TPayPrefs }

function TPayPrefs.GetDbPrefRec(aName: string): TMyQuery;
begin
  result := TMyQuery.Create(nil);
  result.Connection := DbConnection;
  result.SQL.Add('select * from tblDbPreferences where Name = ' + QuotedStr(aName));
  result.Open;
end;

function TPayPrefs.GetShowAccruedAnnualLeaveLiability: boolean;
begin
  with GetDbPrefRec('ShowAccruedAnnualLeaveLiability') do begin
    result := SameText(FieldByName('FieldValue').AsString, 'T');
    Free;
  end;
end;

function TPayPrefs.GetShowAccruedLongServiceLeaveLiability: boolean;
begin
  with GetDbPrefRec('ShowAccruedLongServiceLeaveLiability') do begin
    result := SameText(FieldByName('FieldValue').AsString, 'T');
    Free;
  end;
end;

function TPayPrefs.GetShowAccruedSickLeaveLiability: boolean;
begin
  with GetDbPrefRec('ShowAccruedSickLeaveLiability') do begin
    result := SameText(FieldByName('FieldValue').AsString, 'T');
    Free;
  end;
end;

{ TAppEnvironmentList }

function TAppEnvironmentList.AppEnvForThread(const ThreadId: cardinal;
  AutoCreate: boolean): TAppEnvVirtualGUI;
Var
  tmpAppEnv :TAppEnvVirtualGUI;
  I:Integer;
begin
  result:= nil;
  if not Assigned(AppEnvListLock) then
    exit;
  AppEnvListLock.Acquire;
  Try
    If Self.Count > 0 then
      for I := 0 to Self.Count-1 do begin
        tmpAppEnv := TAppEnvVirtualGUI(Self.Items[I]);
        If (tmpAppEnv.ThreadId = ThreadId) Then Begin
          Result := tmpAppEnv;
          break;
        end;
    end;
    if (not Assigned(result)) and AutoCreate then begin
      tmpAppEnv := TAppEnvVirtualGUI.Create(ApiMode);
      tmpAppEnv.Server := MySQLServer;
      tmpAppEnv.ThreadId := ThreadId;
      Result := tmpAppEnv;
      Self.Add(tmpAppEnv);
    end;
  Finally;
    AppEnvListLock.Release;
  End;
end;

constructor TAppEnvironmentList.Create;
begin
  inherited Create;
  fMySQLServer := '127.0.0.1';
  fAPIMode := false;

end;

constructor TAppEnvironmentList.Create(AOwnesObjects: boolean);
begin
  inherited Create(AOwnesObjects);
  fMySQLServer := '127.0.0.1';
  fAPIMode := false;

end;

procedure TAppEnvironmentList.RemoveAppEnvInstance(const aThreadId: cardinal);
Var
  tmpAppEnv :TAppEnvVirtualGUI;
  I:Integer;
  Id: Cardinal;
begin
  AppEnvListLock.Acquire;
  Try
    if aThreadId = 0 then Id:= GetCurrentThreadID
    else Id:= aThreadId;
    If Self.Count>0 then
      for I := 0 to Self.Count-1 do begin
        tmpAppEnv := TAppEnvVirtualGUI(Self.Items[I]);
        If (tmpAppEnv.ThreadId = ID) Then Begin
          Self.Remove(tmpAppEnv);
          Break;
        end;
      end;
  Finally;
    AppEnvListLock.Release;
  End;
end;



{ TDefaultClass }

constructor TDefaultClass.Create;
begin
  fDefaultUOM := '';
end;

function TDefaultClass.GetDefaultUOM: string;
var
  qry: TMyQuery;
begin
  if fDefaultUOM = '' then begin
    qry := TMyQuery.Create(nil);
    try
      qry.Connection := DBConnection;
      qry.SQL.Text := 'select DefaultUOM from tblcolumnheadings';
      qry.Open;
      fDefaultUOM := qry.FieldByName('DefaultUOM').AsString;
    finally
      qry.Free;
    end;
  end;
  result := fDefaultUOM;
end;

function TCompanyPrefs.getStartWorkWeek: String;
begin
  result := '';
  with GetDbPrefRec('StartWorkWeek') do begin
    result := FieldByName('FieldValue').AsString;
    Free;
  end;
  If result = '' Then result := 'Monday';
end;

function TCompanyPrefs.getNoofWeekendDays: Integer;
begin
  with GetDbPrefRec('NoofWeekendDays') do begin
    result := FieldByName('NoofWeekendDays').asInteger;
    Free;
  end;
end;

function TCompanyPrefs.getStartWorkWeekDay: Integer;
begin
  result := WeekDay(StartWorkWeek);
end;

function TCompanyPrefs.getEndWeekDay: Integer;
begin
  result := Skipdays(StartWorkWeekDay, 0 - NoofWeekendDays);
end;

//function TCompanyPrefs.getCurrentWeekEndDate(dateVal : Tdatetime): Tdatetime;
//var
//    ctr :Integer;
//begin
//    Result := DateVal;
//    ctr := DayOfTheWeek(Result);
//    While ctr <> EndWeekDay do begin
//        Result := incDay(Result);
//        ctr := DayOfTheWeek(REsult);
//    end;
//end;

{ TCompanyInfo }

function TCompanyInfo.GetIndustryId: integer;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := DBConnection;
    qry.SQL.Text := 'select IndustryId from tblcompanyinformation';
    qry.Open;
    result := qry.FieldByName('IndustryId').AsInteger;
  finally
    qry.Free;
  end;
end;

initialization
  AppEnvList := TAppEnvironmentList.Create;
  AppEnvListLock := TCriticalSection.Create;

finalization
  AppEnvList.RemoveAppEnvInstance;
  FreeAndNil(AppEnvList);
  FreeAndNil(AppEnvListLock);


//initialization

//finalization
//  FreeAndNil(fAppEnvVirt);

end.
