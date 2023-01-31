unit AppEnvironmentVirtual;

interface

uses
  AppEnvVirtualObj, MyAccess,
  ProgressInfoObj, ProgressInfoDlgObj;

Type
{$M+}
  TAppEnvVirtualGUI = class(TAppEnvVirtual)
  private
    fCommonDbLib: TObject;
    fCompanyPrefs: TObject;//TCompanyPrefs;
    fBranch: TObject;//TBranch;
    fDNMLib: TObject;//TDNMLib;
    fTcConst: TObject;//TTcConst;
    fProgressInfo: TProgressInfo;
    fRegionalOptions: TObject;//TRegionalOptions;
    fCommonLib: TObject;//TCommonLib;
    fSharedDbConnection: TMyConnection;
    fEmployee: TObject;//TEmployee;
    fPayPrefs: TObject;//TPayPrefs;
    fDefaultClass: TObject;
    fCompanyInfo: TObject;
    function GetCommonDbLib: TObject;
    function GetCompanyPrefs: TObject;
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
    constructor Create;
    destructor Destroy; override;
    procedure PopulateCompanyPrefs; override;
    function GetEmployeeAccessLevel(const FormName: string; const EmployeeID: integer = 0): integer; override;
    procedure DeleteServerFiles(const aFileNameMask: string); override;
    Function showWarning(const Value:String):Boolean;override;
    Procedure LogText(const Value:String);Override;
    Procedure LogTextLoge(const Value:String);Override;
    function Round(const Value: double; places: word): double;Override;
  published
    property CommonDbLib: TObject read GetCommonDbLib;
    property CompanyPrefs: TObject read GetCompanyPrefs;
    property Branch: TObject read GetBranch;
    property DNMLib: TObject read GetDNMLib;
    property TcConst: TObject read GetTcConst;
    property RegionalOptions: TObject read GetRegionalOptions;
    property Employee: TObject read GetEmployee;
    property CommonLib: TObject read GetCommonLib;
    property ProgressInfo: TProgressInfo read GetProgressInfo write SetProgressInfo;
    property PayPrefs: TObject read GetPayPrefs;
    property SharedDbConnection: TMyConnection read fSharedDbConnection write SetSharedDbConnection;
    property DefaultClass: TObject read GetDefaultClass;
    property CompanyInfo: TObject read GetCompanyInfo;
  end;
{$M-}

  function AppEnvVirt :TAppEnvVirtual;

implementation

uses
  sysutils, types,
  ERPDbComponents, CommonDbLib, AppEnvironment, DNMLib, tcConst, CommonLib,DecimalRounding,
  LogLib;

Type


{$M+}
  //TAppEnvVirtualGUI = class;

  TCommonDbLib = class
  private
    function GetGetSharedMyDAcConnection: TERPConnection;
    function GetGetMySQLTempDir: string;
    function GetGetTemporaryTableNameSuffix: string;
    function GetTempMyQuery: TERPQuery;
    function GetTempMyScript: TERPScript;
  published
    property GetSharedMyDAcConnection: TERPConnection read GetGetSharedMyDAcConnection;
    property GetMySQLTempDir: string read GetGetMySQLTempDir;
    property GetTemporaryTableNameSuffix: string read GetGetTemporaryTableNameSuffix;
    property TempMyQuery: TERPQuery read GetTempMyQuery;
    property TempMyScript: TERPScript read GetTempMyScript;
  end;

  TCompanyPrefs = class
  private
    function GetFiscalYearStarts: string;
    function GetBatchUpdateInProgress: boolean;
    function GetUseApprovalLevels: boolean;
    procedure SetBatchUpdateInProgress(const Value: boolean);
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
    function GetClosingDateAR: TDateTime;
    function GetClosingDateAP: TDateTime;
    function GetSummarisedTransDateChanged: TDateTime;
    (*function GetInventoryAssetBOMNonInvCogsAccount:String;*)
(*    function getNonInvProductcostinBOM1 :Integer;
    function getNonInvProductcostinBOM2 :Integer;
    function getNonInvProductcostinBOM3 :Integer;*)
    procedure SetSummarisedTransDate(const Value: TDateTime);
    procedure SetClosingDate(const Value: TDateTime);
    procedure SetClosingDateAR(const Value: TDateTime);
    procedure SetClosingDateAP(const Value: TDateTime);
    function GetStockCostSystem: integer;
    function GetTransactionTableLastUpdated: TDateTime;
    procedure SetTransactionTableLastUpdated(const Value: TDateTime);
    function GetRewardPointssoldAccount: integer;
    function GetExpenseAccountforRewardPoints: integer;
    function GetRoundUpPoints: integer;
    function GetRewardPointsExpiredAccount: integer;
    function GetVerifyBalanceOnBatch: boolean;
    function GetReportTablesLastUpdatedOn: TDateTime;
    function GetSerialNumberListUpdatedOn: TDateTime;
    procedure SetReportTablesLastUpdatedOn(const Value: TDateTime);
    procedure SetSerialNumberListUpdatedOn(const Value: TDateTime);
    function getEnableScheduledreports: Boolean;
    function getIncludeLandedCostsinAvgCost: Boolean;
    //function getEnableCogsAdjustmentPosting: Boolean;
    function getAccountPosingPopulated: Boolean;
    Procedure setAccountPosingPopulated (const Value :Boolean);
    //function getProductAvgcostCalculatedForDepartment: Boolean;
    function getCompanyEmail:String;
    function getTradingname: String;
    function getZerotaxWhenLoss: Boolean;
    function getIncomeTaxPercentage: Double;
    function getNoOfMonthstoChangeClosingdate: Integer;
    function getProductListPriceMultiplier: double;
    function getProductListPriceMultiplierOn: String;
    function getDBName: String;
    function GetStandardCostCOGSAdjustmentAccountID: integer;
    function GetUseInventoryStandardCosting: boolean;
    function GetStandardCostPurchaseAdjustmentAccountID: integer;
    function GetTrialBalanceAdjustAccount: integer;
    function GetDefPartsCOGSAccount: integer;
    function GetPOSBliandBalanceVarianceAccount: string;
    function GetPOSPostBlindBalanceVariance: boolean;
    function GetDefaultBOMWastageAccount: string;
    function GetBoMNonProductsubnodePostingAccount: string;
    function GetPOHasPeriodPosting: boolean;
    function GetCountSOBOInAvailable: boolean;
    function GetDosyncSerialnumberlist: boolean;
    function GetDoUpdateProductQtySum: boolean;
    function GetUpdatebatchRunVS1_sum                            : Boolean;
    function GetUpdatebatchRunVS1_PnLReport                      : Boolean;
    function GetUpdatebatchRunVS1_PnLReport_Sum                  : Boolean;
    function GetUpdatebatchRunVS1_APReport                       : Boolean;
    function GetUpdatebatchRunVS1_SalesList                      : Boolean;
    function GetUpdatebatchRunVS1_PQASumList                     : Boolean;
    function GetUpdatebatchRunVS1_Sum2                           : Boolean;

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
    (*Property InventoryAssetBOMNonInvCogsAccount :String read getInventoryAssetBOMNonInvCogsAccount;*)
    (*Property NonInvProductcostinBOM1 :Integer read getNonInvProductcostinBOM1;
    Property NonInvProductcostinBOM2 :Integer read getNonInvProductcostinBOM2;
    Property NonInvProductcostinBOM3 :Integer read getNonInvProductcostinBOM3;*)
    property SummarisedTransDate: TDateTime read GetSummarisedTransDate write SetSummarisedTransDate;
    property ClosingDate: TDateTime read GetClosingDate write SetClosingDate;
    property ClosingDateAR: TDateTime read GetClosingDateAR write SetClosingDateAR;
    property ClosingDateAP: TDateTime read GetClosingDateAP write SetClosingDateAP;
    property StockCostSystem: integer read GetStockCostSystem;
    property TransactionTableLastUpdated: TDateTime read GetTransactionTableLastUpdated write SetTransactionTableLastUpdated;
    property RewardPointssoldAccount: integer read GetRewardPointssoldAccount;
    property ExpenseAccountforRewardPoints: integer read GetExpenseAccountforRewardPoints;
    property RoundUpPoints: integer read GetRoundUpPoints;
    property RewardPointsExpiredAccount: integer read GetRewardPointsExpiredAccount;
    property VerifyBalanceOnBatch: boolean read GetVerifyBalanceOnBatch;
    property ReportTablesLastUpdatedOn: TDateTime read GetReportTablesLastUpdatedOn write SetReportTablesLastUpdatedOn;
    property SerialNumberListUpdatedOn: TDateTime read GetSerialNumberListUpdatedOn write SetSerialNumberListUpdatedOn;
    Property EnableScheduledreports : Boolean read getEnableScheduledreports;
    Property IncludeLandedCostsinAvgCost : Boolean read getIncludeLandedCostsinAvgCost;
    //Property EnableCogsAdjustmentPosting : Boolean read getEnableCogsAdjustmentPosting;
    Property AccountPosingPopulated : Boolean read getAccountPosingPopulated write setAccountPosingPopulated;
    //Property ProductAvgcostCalculatedForDepartment : Boolean read getProductAvgcostCalculatedForDepartment;
    Property companyEmail:String read getcompanyEmail;
    Property Tradingname :String read getTradingname;
    Property ZerotaxWhenLoss :Boolean read getZerotaxWhenLoss;
    Property IncomeTaxPercentage :Double read getIncomeTaxPercentage;
    Property ProductListPriceMultiplierOn :String read getProductListPriceMultiplierOn;
    Property ProductListPriceMultiplier :double read getProductListPriceMultiplier;
    Property NoOfMonthstoChangeClosingdate :Integer read getNoOfMonthstoChangeClosingdate;
    property StandardCostCOGSAdjustmentAccountID: integer read GetStandardCostCOGSAdjustmentAccountID;
    property StandardCostPurchaseAdjustmentAccountID: integer read GetStandardCostPurchaseAdjustmentAccountID;
    property TrialBalanceAdjustAccount: integer read GetTrialBalanceAdjustAccount;
    property DefPartsCOGSAccount: integer read GetDefPartsCOGSAccount;
    property UseInventoryStandardCosting: boolean read GetUseInventoryStandardCosting;
    Property DBName :String read getDBName;
    property POSPostBlindBalanceVariance: boolean read GetPOSPostBlindBalanceVariance;
    property POSBliandBalanceVarianceAccount: string read GetPOSBliandBalanceVarianceAccount;
    property DefaultBOMWastageAccount: string read GetDefaultBOMWastageAccount;
    property BoMNonProductsubnodePostingAccount: string read GetBoMNonProductsubnodePostingAccount;
    property POHasPeriodPosting: boolean read GetPOHasPeriodPosting;
    property CountSOBOInAvailable: boolean read GetCountSOBOInAvailable;
    property DosyncSerialnumberlist: boolean read GetDosyncSerialnumberlist;
    property DoUpdateProductQtySum: boolean read GetDoUpdateProductQtySum;

    Property UpdatebatchRunVS1_sum: Boolean Read getUpdatebatchRunVS1_sum ;
    Property UpdatebatchRunVS1_PnLReport: Boolean Read getUpdatebatchRunVS1_PnLReport ;
    Property UpdatebatchRunVS1_PnLReport_Sum: Boolean Read getUpdatebatchRunVS1_PnLReport_Sum ;
    Property UpdatebatchRunVS1_APReport: Boolean Read getUpdatebatchRunVS1_APReport ;
    Property UpdatebatchRunVS1_SalesList: Boolean Read getUpdatebatchRunVS1_SalesList ;
    Property UpdatebatchRunVS1_PQASumList: Boolean Read getUpdatebatchRunVS1_PQASumList ;
    Property UpdatebatchRunVS1_Sum2: Boolean Read getUpdatebatchRunVS1_Sum2 ;
  end;

  TBranch = class
  private
    function GetSiteCode: string;
  published
    property SiteCode: string read GetSiteCode;
  end;

  TDNMLib = class
  private
    function GetGetCustomerPrepaymentAccountID: integer;
    function GetGetSupplierPrepaymentAccountID: integer;
    function GetIsTransTableEmpty: boolean;
  published
  published
    property GetSupplierPrepaymentAccountID: integer read GetGetSupplierPrepaymentAccountID;
    property GetCustomerPrepaymentAccountID: integer read GetGetCustomerPrepaymentAccountID;
    property IsTransTableEmpty: boolean read GetIsTransTableEmpty;
  end;

  TTcConst = class
  private
    function GetGeneralRoundPlaces: integer;
//    function GetDEFAULT_UOM: string;
    function GetWAITMSG: string;
    function GetCUSTOMER_PREPAYMENT: string;
    function GetUNDEPOSITED_FUNDS: string;
    function GetGLACCOUNT_TAX_COLLECTED: string;
    function GetGLACCOUNT_TAX_WEG: string;
    function GetGLACCOUNT_TAX_WET: string;
    function GetGLACCOUNT_TAX_PAID: string;
    function GetTABLE_PROFITANDLOSSREPORT: string;
  published
  published
    property GeneralRoundPlaces: integer read GetGeneralRoundPlaces;
//    property DEFAULT_UOM: string read GetDEFAULT_UOM;
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
    function GetForeignExDefault: string;
    function GetRegion: string;
    function GetSLName: string;
  published
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
  published
  published
    property LogonName: string read GetLogonName;
    Property EmployeeId :Integer read getEmployeeId;
  end;

  TCommonLib = class
  private
    function GetDevMode: boolean;
  published
  published
    property DevMode: boolean read GetDevMode;
    Function ShowWarning(const Value:String):Boolean;
    function Round(const Value: double; places: word): double;
  end;

  TPayPrefs = class
  private
    function GetShowAccruedAnnualLeaveLiability: boolean;
    function GetShowAccruedSickLeaveLiability: boolean;
    function GetShowAccruedLongServiceLeaveLiability: boolean;
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
    function GetIndustryId: Integer;
  public
    DbConnection: TMyConnection;
  published
    property IndustryId: integer read GetIndustryId;
  end;

{$M-}

var
  fAppEnvVirt: TAppEnvVirtual;


function AppEnvVirt :TAppEnvVirtual;
begin
  if not Assigned(fAppEnvVirt) then
    fAppEnvVirt := TAppEnvVirtualGUI.Create;

  result := fAppEnvVirt;
end;

{ TAppEnvVirtualGUI }

constructor TAppEnvVirtualGUI.Create;
begin

end;

procedure TAppEnvVirtualGUI.DeleteServerFiles(const aFileNameMask: string);
var
  msg:String;
begin
  inherited;
  if not AppEnv.UtilsClient.connected then
    if not AppEnv.UtilsClient.ConnectUser(msg,AppEnv.AppDb.server,AppEnv.AppDb.Database,AppEnv.AppDb.UserName,'','',true) then
      Exit;
  AppEnv.UtilsClient.DeleteServerFiles(aFileNameMask);
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
  fPayPrefs.Free;
  fDefaultClass.Free;
  fCompanyInfo.Free;
  inherited;
end;

function TAppEnvVirtualGUI.GetBranch: TObject;
begin
  result := nil;
  if not Assigned(AppEnv.Branch) then exit;

  if not Assigned(fBranch) then
    fBranch:= TBranch.Create;
  result := fBranch;
end;

function TAppEnvVirtualGUI.GetCommonDbLib: TObject;
begin
  if not Assigned(fCommonDbLib) then
    fCommonDbLib := TCommonDbLib.Create;
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
  Result := fCompanyInfo;
end;

function TAppEnvVirtualGUI.GetCompanyPrefs: TObject;
begin
  if not Assigned(fCompanyPrefs) then
    fCompanyPrefs := TCompanyPrefs.Create;
  result := fCompanyPrefs;
end;


function TAppEnvVirtualGUI.GetDefaultClass: TObject;
begin
  if not Assigned(fDefaultClass) then begin
    fDefaultClass := TDefaultClass.Create;
    TDefaultClass(fDefaultClass).DbConnection := self.SharedDbConnection;
  end;
  result := fDefaultClass;
end;

function TAppEnvVirtualGUI.GetDNMLib: TObject;
begin
  if not Assigned(fDNMLib) then
    fDNMLib := TDNMLib.Create;
  result:= fDNMLib;
end;

function TAppEnvVirtualGUI.GetEmployee: TObject;
begin
  if not Assigned(fEmployee) then
    fEmployee := TEmployee.Create;
  result := fEmployee;
end;

function TAppEnvVirtualGUI.GetEmployeeAccessLevel(const FormName: string;
  const EmployeeID: integer): integer;
begin
  result := AppEnv.AccessLevels.GetEmployeeAccessLevel(FormName, EmployeeID);
end;

function TAppEnvVirtualGUI.GetPayPrefs: TObject;
begin
  if not Assigned(fPayPrefs) then
    fPayPrefs:= TPayPrefs.Create;
  result := fPayPrefs;
end;
procedure TAppEnvVirtualGUI.SetSharedDbConnection(const Value: TMyConnection);
begin
  fSharedDbConnection := Value;
end;

Function TAppEnvVirtualGUI.showWarning(const Value:String):Boolean;
begin
  inherited;
  result := TCommonLib(Commonlib).showWarning(Value);
end;

function TAppEnvVirtualGUI.GetProgressInfo: TProgressInfo;
begin
  if not Assigned(fProgressInfo) then
    fProgressInfo := TProgressInfoDlg.Create;
  result := fProgressInfo;
end;

function TAppEnvVirtualGUI.GetRegionalOptions: TObject;
begin
  if not Assigned(fRegionalOptions) then
    fRegionalOptions := TRegionalOptions.Create;
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
  loglib.LogText(Value, '', true);
end;

procedure TAppEnvVirtualGUI.LogTextLoge(const Value: String);
begin
  inherited;
  loglib.LogTextLoge(Value);
end;

procedure TAppEnvVirtualGUI.PopulateCompanyPrefs;
begin
  inherited;
  AppEnv.CompanyPrefs.PopulateMe;
end;

function TAppEnvVirtualGUI.Round(const Value: double; places: word): double;
begin
  result := TCommonLib(Commonlib).Round(Value, places);
end;

procedure TAppEnvVirtualGUI.SetProgressInfo(const Value: TProgressInfo);
begin
  fProgressInfo := Value;
end;

{ TCommonDbLib }

function TCommonDbLib.GetGetMySQLTempDir: string;
begin
  result:= CommonDbLib.GetMySQLTempDir;
end;

function TCommonDbLib.GetGetSharedMyDAcConnection: TERPConnection;
begin
  result := CommonDbLib.GetSharedMyDacConnection;
end;

function TCommonDbLib.GetGetTemporaryTableNameSuffix: string;
begin
  result:= CommonDbLib.GetTemporaryTableNameSuffix;
end;

function TCommonDbLib.GetTempMyQuery: TERPQuery;
begin
  result := CommonDbLib.TempMyQuery();
end;
function TCommonDbLib.GetTempMyScript: TERPScript;
begin
  result := CommonDbLib.TempMyScript();
end;

{ TCompanyPrefs }

function TCompanyPrefs.GetBatchUpdateInProgress: boolean;
begin
  result := AppEnv.CompanyPrefs.BatchUpdateInProgress;
end;
function TCompanyPrefs.GetUseApprovalLevels: boolean;
begin
  result := AppEnv.CompanyPrefs.UseApprovalLevels;
end;

function TCompanyPrefs.GetDepreciationForTransactions: integer;
begin
  result := AppEnv.CompanyPrefs.DepreciationForTransactions;
end;


function TCompanyPrefs.getEnableScheduledreports: Boolean;
begin
  REsult:= AppEnv.CompanyPrefs.EnableScheduledreports;
end;
function TCompanyPrefs.getIncludeLandedCostsinAvgCost: Boolean;
begin
  REsult:= AppEnv.CompanyPrefs.IncludeLandedCostsinAvgCost;
end;
(*function TCompanyPrefs.getEnableCogsAdjustmentPosting: Boolean;
begin
  REsult:= AppEnv.CompanyPrefs.EnableCogsAdjustmentPosting;
end;*)
function TCompanyPrefs.getAccountPosingPopulated: Boolean;
begin
  REsult:= AppEnv.CompanyPrefs.AccountPosingPopulated;
end;
Procedure TCompanyPrefs.setAccountPosingPopulated(const Value:Boolean);
begin
  AppEnv.CompanyPrefs.AccountPosingPopulated := Value;
end;
(*function TCompanyPrefs.getProductAvgcostCalculatedForDepartment: Boolean;
begin
  REsult:= AppEnv.CompanyPrefs.ProductAvgcostCalculatedForDepartment;
end;*)
function TCompanyPrefs.getCompanyEmail: String;
begin
  result := AppEnv.CompanyInfo.Email;
end;

function TCompanyPrefs.getDBName: String;
begin
  Result := AppEnv.AppDb.Database;
end;

function TCompanyPrefs.GetExpenseAccountforRewardPoints: integer;
begin
  result := AppEnv.CompanyPrefs.ExpenseAccountforRewardPoints;
end;

function TCompanyPrefs.GetFiscalYearStarts: string;
begin
  result := Appenv.CompanyPrefs.FiscalYearStarts;
end;

function TCompanyPrefs.GetIncludeUnInvoicedPOtoGL: boolean;
begin
  result := AppEnv.CompanyPrefs.IncludeUnInvoicedPOtoGL;
end;

function TCompanyPrefs.GetIncludeUnInvoicedSOtoGL: boolean;
begin
  result := AppEnv.CompanyPrefs.IncludeUnInvoicedSOtoGL;
end;

function TCompanyPrefs.getIncomeTaxPercentage: Double;
begin
    result := AppEnv.CompanyPrefs.IncomeTaxPercentage;
end;

function TCompanyPrefs.getNoOfMonthstoChangeClosingdate: Integer;
begin
    result := AppEnv.CompanyPrefs.NoOfMonthstoChangeClosingdate;
end;

function TCompanyPrefs.GetPOSBliandBalanceVarianceAccount: string;
begin
  result := AppEnv.CompanyPrefs.POSBliandBalanceVarianceAccount;
end;
function TCompanyPrefs.GetDefaultBOMWastageAccount: string;
begin
  result := AppEnv.CompanyPrefs.DefaultBOMWastageAccount;
end;
function TCompanyPrefs.GetBoMNonProductsubnodePostingAccount: string;
begin
  result := AppEnv.CompanyPrefs.BoMNonProductsubnodePostingAccount;
end;
function TCompanyPrefs.GetPOSPostBlindBalanceVariance: boolean;
begin
  result := AppEnv.CompanyPrefs.POSPostBlindBalanceVariance;
end;
function TCompanyPrefs.GetDosyncSerialnumberlist: boolean;
begin
  result := AppEnv.CompanyPrefs.DosyncSerialnumberlist;
end;
function TCompanyPrefs.GetDoUpdateProductQtySum: boolean;
begin
  result := AppEnv.CompanyPrefs.DoUpdateProductQtySum;
end;
function TCompanyPrefs.getUpdatebatchRunVS1_sum                     : Boolean; begin Result := AppEnv.CompanyPrefs.UpdatebatchRunVS1_sum; end;
function TCompanyPrefs.getUpdatebatchRunVS1_PnLReport               : Boolean; begin Result := AppEnv.CompanyPrefs.UpdatebatchRunVS1_PnLReport; end;
function TCompanyPrefs.getUpdatebatchRunVS1_PnLReport_Sum           : Boolean; begin Result := AppEnv.CompanyPrefs.UpdatebatchRunVS1_PnLReport_Sum; end;
function TCompanyPrefs.getUpdatebatchRunVS1_APReport                : Boolean; begin Result := AppEnv.CompanyPrefs.UpdatebatchRunVS1_APReport; end;
function TCompanyPrefs.getUpdatebatchRunVS1_SalesList               : Boolean; begin Result := AppEnv.CompanyPrefs.UpdatebatchRunVS1_SalesList; end;
function TCompanyPrefs.getUpdatebatchRunVS1_PQASumList              : Boolean; begin Result := AppEnv.CompanyPrefs.UpdatebatchRunVS1_PQASumList; end;
function TCompanyPrefs.getUpdatebatchRunVS1_Sum2                    : Boolean; begin Result := AppEnv.CompanyPrefs.UpdatebatchRunVS1_Sum2; end;

function TCompanyPrefs.getProductListPriceMultiplier: double;
begin
    result := AppEnv.CompanyPrefs.ProductListPriceMultiplier;
end;

function TCompanyPrefs.getProductListPriceMultiplierOn: String;
begin
    result := AppEnv.CompanyPrefs.ProductListPriceMultiplierOn;
end;

function TCompanyPrefs.GetReportTablesLastUpdatedOn: TDateTime;
begin
  result := AppEnv.CompanyPrefs.ReportTablesLastUpdatedOn;
end;
function TCompanyPrefs.GetSerialNumberListUpdatedOn: TDateTime;
begin
  result := AppEnv.CompanyPrefs.SerialNumberListUpdatedOn;
end;

function TCompanyPrefs.GetRewardPointsExpiredAccount: integer;
begin
  result:= AppEnv.CompanyPrefs.RewardPointsExpiredAccount;
end;

function TCompanyPrefs.GetRewardPointssoldAccount: integer;
begin
  result:= AppEnv.CompanyPrefs.RewardPointssoldAccount;
end;

function TCompanyPrefs.GetRoundUpPoints: integer;
begin
  result := AppEnv.CompanyPrefs.RoundUpPoints;
end;

function TCompanyPrefs.GetShowActiveClassOnReports: boolean;
begin
  result := AppEnv.CompanyPrefs.ShowActiveClassOnReports;
end;

function TCompanyPrefs.GetStandardCostCOGSAdjustmentAccountID: integer;
begin
  result := AppEnv.CompanyPrefs.StandardCostCOGSAdjustmentAccountID;
end;

function TCompanyPrefs.GetStandardCostPurchaseAdjustmentAccountID: integer;
begin
  result := AppEnv.CompanyPrefs.StandardCostPurchaseAdjustmentAccountID;
end;
function TCompanyPrefs.GetTrialBalanceAdjustAccount: integer;
begin
  result := AppEnv.CompanyPrefs.TrialBalanceAdjustAccount;
end;
function TCompanyPrefs.GetDefPartsCOGSAccount: integer;
begin
  result := AppEnv.CompanyPrefs.DefPartsCOGSAccount;
end;

function TCompanyPrefs.GetStockCostSystem: integer;
begin
  result:= Ord(AppEnv.CompanyPrefs.StockCostSystem);
end;

function TCompanyPrefs.GetSummarisedTransDate: TDateTime;
begin
  result := AppEnv.CompanyPrefs.SummarisedTransDate;
end;
function TCompanyPrefs.GetClosingDate: TDateTime;
begin
  result := AppEnv.CompanyPrefs.ClosingDate;
end;
function TCompanyPrefs.GetClosingDateAR: TDateTime;
begin
  result := AppEnv.CompanyPrefs.ClosingDateAR;
end;
function TCompanyPrefs.GetClosingDateAP: TDateTime;
begin
  result := AppEnv.CompanyPrefs.ClosingDateAP;
end;
(*function TCompanyPrefs.GetInventoryAssetBOMNonInvCogsAccount:String;
begin
  result := AppEnv.CompanyPrefs.InventoryAssetBOMNonInvCogsAccount;
end;*)
(*function TCompanyPrefs.GetNonInvProductcostinBOM1:Integer;
begin
  result := AppEnv.CompanyPrefs.NonInvProductcostinBOM1;
end;
function TCompanyPrefs.GetNonInvProductcostinBOM2:Integer;
begin
  result := AppEnv.CompanyPrefs.NonInvProductcostinBOM2;
end;
function TCompanyPrefs.GetNonInvProductcostinBOM3:Integer;
begin
  result := AppEnv.CompanyPrefs.NonInvProductcostinBOM3;
end;*)
function TCompanyPrefs.GetSummarisedTransDateChanged: TDateTime;
begin
  result := AppEnv.CompanyPrefs.SummarisedTransDateChanged;
end;

function TCompanyPrefs.getTradingname: String;
begin
    result := AppEnv.CompanyInfo.Tradingname;
end;

function TCompanyPrefs.GetTransactionTableLastUpdated: TDateTime;
begin
  result:= AppEnv.CompanyPrefs.TransactionTableLastUpdated
end;

function TCompanyPrefs.GetUnInvoicedPOAccount: integer;
begin
  result:= AppEnv.CompanyPrefs.UnInvoicedPOAccount;
end;

function TCompanyPrefs.GetUnInvoicedSOAccount: integer;
begin
  result := AppEnv.CompanyPrefs.UnInvoicedSOAccount;
end;

function TCompanyPrefs.GetUnInvoicedSOType: integer;
begin
  result := AppEnv.CompanyPrefs.UnInvoicedSOType;
end;

function TCompanyPrefs.GetUseBatchTransactions: boolean;
begin
  result := AppEnv.CompanyPrefs.UseBatchTransactions;
end;

function TCompanyPrefs.GetUseInventoryStandardCosting: boolean;
begin
  result := AppEnv.CompanyPrefs.UseInventoryStandardCosting;
end;
function TCompanyPrefs.GetPOHasPeriodPosting: boolean;
begin
  result := AppEnv.CompanyPrefs.POHasPeriodPosting;
end;
function TCompanyPrefs.GetCountSOBOInAvailable: boolean;
begin
  result := AppEnv.CompanyPrefs.CountSOBOInAvailable;
end;
function TCompanyPrefs.GetVerifyBalanceOnBatch: boolean;
begin
  result:= AppEnv.CompanyPrefs.VerifyBalanceOnBatch;
end;

function TCompanyPrefs.getZerotaxWhenLoss: Boolean;
begin
    result := AppEnv.CompanyPrefs.ZerotaxWhenLoss;
end;

procedure TCompanyPrefs.SetBatchUpdateInProgress(const Value: boolean);
begin
  AppEnv.CompanyPrefs.BatchUpdateInProgress := Value;
end;

procedure TCompanyPrefs.SetReportTablesLastUpdatedOn(const Value: TDateTime);
begin
  AppEnv.CompanyPrefs.ReportTablesLastUpdatedOn := Value;
end;
procedure TCompanyPrefs.SetSerialNumberListUpdatedOn(const Value: TDateTime);
begin
  AppEnv.CompanyPrefs.SerialNumberListUpdatedOn := Value;
end;

procedure TCompanyPrefs.SetSummarisedTransDate(const Value: TDateTime);
begin
  AppEnv.CompanyPrefs.SummarisedTransDate:= Value;
end;
procedure TCompanyPrefs.SetClosingDate(const Value: TDateTime);
begin
  AppEnv.CompanyPrefs.ClosingDate:= Value;
end;
procedure TCompanyPrefs.SetClosingDateAR(const Value: TDateTime);
begin
  AppEnv.CompanyPrefs.ClosingDateAR:= Value;
end;
procedure TCompanyPrefs.SetClosingDateAP(const Value: TDateTime);
begin
  AppEnv.CompanyPrefs.ClosingDateAP:= Value;
end;

procedure TCompanyPrefs.SetTransactionTableLastUpdated(const Value: TDateTime);
begin
  AppEnv.CompanyPrefs.TransactionTableLastUpdated := Value;
end;

{ TBranch }

function TBranch.GetSiteCode: string;
begin
  result := AppEnv.Branch.SiteCode;
end;

{ TDNMLib }

function TDNMLib.GetGetCustomerPrepaymentAccountID: integer;
begin
  result := DNMLib.GetCustomerPrepaymentAccountID;
end;

function TDNMLib.GetGetSupplierPrepaymentAccountID: integer;
begin
  result := DNMLib.GetSupplierPrepaymentAccountID;
end;

function TDNMLib.GetIsTransTableEmpty: boolean;
begin
  result := DNMLib.IsTransTableEmpty;
end;

{ TTcConst }

function TTcConst.GetCUSTOMER_PREPAYMENT: string;
begin
  result := TcConst.CUSTOMER_PREPAYMENT;
end;
function TTcConst.GetUNDEPOSITED_FUNDS: string;
begin
  result := TcConst.UNDEPOSITED_FUNDS;
end;

//function TTcConst.GetDEFAULT_UOM: string;
//begin
//  result := TcConst.DEFAULT_UOM;
//end;

function TTcConst.GetGeneralRoundPlaces: integer;
begin
  result := TcConst.GeneralRoundPlaces;
end;

function TTcConst.GetGLACCOUNT_TAX_COLLECTED: string;
begin
  result := tcConst.GLACCOUNT_TAX_COLLECTED;
end;

function TTcConst.GetGLACCOUNT_TAX_PAID: string;
begin
  result := tcConst.GLACCOUNT_TAX_PAID;
end;

function TTcConst.GetGLACCOUNT_TAX_WEG: string;
begin
  result := tcConst.GLACCOUNT_TAX_WEG;
end;

function TTcConst.GetGLACCOUNT_TAX_WET: string;
begin
  result := tcConst.GLACCOUNT_TAX_WET;
end;

function TTcConst.GetTABLE_PROFITANDLOSSREPORT: string;
begin
  result := tcConst.TABLE_PROFITANDLOSSREPORT;
end;

function TTcConst.GetWAITMSG: string;
begin
  result := tcConst.WAITMSG;
end;

{ TRegionalOptions }

function TRegionalOptions.GetCurrencyRoundPlaces: integer;
begin
  result := AppEnv.RegionalOptions.CurrencyRoundPlaces;
end;


function TRegionalOptions.getCurrencySymbol: String;
begin
  result := AppEnv.RegionalOptions.CurrencySymbol;
end;

function TRegionalOptions.GetForeignExDefault: string;
begin
  result:= AppEnv.RegionalOptions.ForeignExDefault;
end;
function TRegionalOptions.GetRegion: string;
begin
  result:= AppEnv.RegionalOptions.Region;
end;
function TRegionalOptions.GetSLName: string;
begin
  result:= AppEnv.RegionalOptions.SLName;
end;

function TRegionalOptions.GetID: integer;
begin
  result := AppEnv.RegionalOptions.ID;
end;

{ TEmployee }

function TEmployee.getEmployeeId: Integer;
begin
  result := Appenv.Employee.Employeeid;
end;

function TEmployee.GetLogonName: string;
begin
  result := Appenv.Employee.LogonName;
end;

{ TCommonLib }

function TCommonLib.GetDevMode: boolean;
begin
  result := CommonLib.DevMode;
end;

function TCommonLib.ShowWarning(const Value: String):Boolean;
begin
    CommonLib.ShowWarning(Value);
    Result:= TRue;
end;
function TCommonLib.Round(const Value: double; places: word): double;
begin
  result := Value;
  if Value = 0 then exit;
  result := DecimalRoundDbl(Value, Places, drHalfUp);
end;

{ TPayPrefs }

function TPayPrefs.GetShowAccruedAnnualLeaveLiability: boolean;
begin
  result := AppEnv.PayPrefs.ShowAccruedAnnualLeaveLiability;
end;

function TPayPrefs.GetShowAccruedLongServiceLeaveLiability: boolean;
begin
  result := AppEnv.PayPrefs.ShowAccruedLongServiceLeaveLiability;
end;

function TPayPrefs.GetShowAccruedSickLeaveLiability: boolean;
begin
  result := AppEnv.PayPrefs.ShowAccruedSickLeaveLiability;
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

{ TCompanyInfo }

function TCompanyInfo.GetIndustryId: integer;
begin
  Result := AppEnv.CompanyInfo.IndustryId;
end;

initialization

finalization
  FreeAndNil(fAppEnvVirt);

end.

