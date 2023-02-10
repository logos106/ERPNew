unit EmployeeObj;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 26/03/05  1.00.01 IJB  Added finialization section to free global instance.
                        Added UserOnly param to PopulateMe method.
 09/11/05  1.00.01 BJ   Added PendingSOAppearDays.
 08/12/05  1.00.02 AL   Made fbUseSearchProductsComboSales writable
 16/01/05  1.00.03 AL   Added three properties
                        UseSearchLikeProductComboSales
                        UseSearchLikeProductComboPO
                        UseDearchLikeProductComboInv
 19/01/06  1.00.04 RM   Added property UseEmpEmailAsFromAddress
 28/03/06  1.00.05 BJ   Added property Showhints
 10/07/06  1.00.06 BJ   CloseOnPrint is aways True and all forms should be closed after print.
}

interface

uses
  ERPdbComponents, Classes, SysUtils, Graphics, JsonObject;

type
  TEmployeeObj = class(TObject)
  private
    fsLogonPassword: string;
    fsLogonName: string;
    fsTitle: string;
    fsFirstName: string;
    fsMiddleName: string;
    fsLastName: string;
    fsEmployeeName: string;
    fsStreet: string;
    fsStreet2: string;
    fsState: string;
    fsSuburb: string;
    fsPostCode: string;
    fsDefaultClassName: string;
    fsEmail: string;
    fsTFN : string;
    fdUseEmpEmailAsFromAddress: boolean;
    fiDefaultClassID: integer;
    fiOptionNo: integer;
    fiPasswordID: integer;
    fiEmployeeNo: integer;
    {More fields to be added on a needs basis}

    fbOverrideAutoSmartOrders: boolean;
    fiAPPAppearDays: integer;
    fiToDoAppearDays: integer;
    fiPendingSOAppearDays: integer;
    fiFixedAssetWarrantyAppearDays: integer;
    fiFixedAssetInsuranceAppearDays: integer;
    fiOthContactAppearDays: integer;
    fiQuoteAppearDays: integer;
    fiMemTransAppearDays: integer;
    fbProductClassWarning: boolean;
    fiListDaysPast: integer;
    fiListDaysFuture: integer;
    fbUseWord: boolean;
    fiCustomerLoyaltyAppearDays: integer;
    fiContactLoyaltyAppearDays: integer;
    fiEmployeeskillRenewalAppearDays: integer;
    fbPOSAutoLoad: boolean;
    fbShowPrintDialog: boolean;
    fbShowPreview: boolean;
    fsListSelectionColour: TColor;
    fbPayrollAccess: boolean;
    fbAutoApplyDeposit: boolean;
    fbNoQtyDrillDownOnSales: boolean;
    fbCloseOnPrint: boolean;
    fbUseClientAccountNoOnPayments: boolean;
    fsCommissionOn: String;
    fdCommissionFlatRate: double;
    fbCommissionInvoiceExPrice: boolean;
    fbCommissionUseProd: boolean;
    fbCommissionUseEmp: boolean;

    fiMarketingContactsAppearDays: integer;
    fiLeadsAppearDays: integer;
    fiServiceLogAprearDays :Integer;
    fiGoodToReceiveReminderDays: integer;
    fiReceivedBOAppearDays:Integer;

    fsUserFirstName: string;
    fsUserLastName: string;
    fsUserFullName: string;

    fbActiveWindows :integer;
    fbCalender24hr:boolean;
//    fbUseSoundScheme:boolean;
    fbPopRemindersToDo: boolean;
    fbShowERPTips: boolean;
    fbRunManufacturingUpdateBatch: boolean;
    fbDefaultOrderinTransForms: boolean;
    fsImageScheme :String;
    fbPopRemindersMFollowup: boolean;
    fbPopRemindersMessages: boolean;
    fbShowDeliveryDetailsformonDeldocketprint: boolean;
    fbShowManufacutresummarywhenchangedfromSales: boolean;
    fbHideMSgonEmployeeCalendar:Boolean;
    fbShowImageOnMainBackGround:Boolean;
//    fbShowPrintOptionsinTransforms:Boolean;
    fbOpenTreeFromSalesOrder: boolean;
    fbCapacityplannerSelectionOptionBeforeLoad: boolean;
    fbManufacturePartSourceStockconfirm: boolean;
    fbPrintAddressLabelfromDelPrint:Boolean;
    fbShowSalesProductAutoSelectOptions:boolean;
    fsProductListType: String;
    fbShowProductListtypeSelection: boolean;
    fbShowProductListtypeSelectionforExpress: boolean;
    fbShowProductListtypeSelectionforQtyList: boolean;
    fbShowProductListtypeSelectionforDetails: boolean;
    fsBOMSalesList: String;
    fsStockanalysisReport: String;
    fbShowReportTablesMsg: boolean;
    fbUseAlternatingRowColor: boolean;
    fbUseERPSingleColor: boolean;
    fbUseERPButtonColor: boolean;

    fiEquipmentServiceAppearDays:integer;
    fiERPLicenseRenewalAppearDays:integer;
    fbBPRPreview: Boolean;
    fShowVideoMenuAtStartup: boolean;
    fbCommissionOnPaid: Boolean;
    fdOverheadbaserate: Double;
    fbTrackEmails: boolean;
    fCyTrackPortNumber: integer;
    fCyTrackIntegrationEnabled: boolean;
    fEmployeemaxDiscountPercentage: double;
    fEmployeeMinMarkupPercentage: double;
    fEmployeeMinimumMarginPercentage: double;
    fExpenseClaimAppearDays: integer;
    fCalendarTimeZones: TJsonObject;
    fbShowOverduesalesReminders: boolean;
    fbShowFinishedProgressBuildReminder: boolean;
    fbShowRelatedProductSelectioninSale: boolean;
    fSupportLogLinesAppearDays: integer;
    fiCustomerPriceLsitOption: integer;

    fiColourAlternatingRow: integer;
    fiGradIntensityAlternatingRow: integer;
    FAlternatingRowColor  : TColor;

    fiColourERPSingle: integer;
    fiGradIntensityERPSingle: integer;
    FERPSingleColor  : TColor;

    fiColourERPButton: integer;
    fiGradIntensityERPButton: integer;
    FERPButtonColor  : TColor;

    fiColourERPButtonFont: integer;
    fiGradIntensityERPButtonFont: integer;
    FERPButtonFontColor  : TColor;
    fiColourERPButtonHT: integer;
    fiGradIntensityERPButtonHT: integer;
    FERPButtonHTColor  : TColor;
    fbShowGrossWeightnQtyCalcMsg: boolean;
    fbUseGradBackground: boolean;
    fbCalcnshowAvailaibityinCapacityPlanner: boolean;

    procedure SetListDaysPast(Value: integer);
    procedure SetListDaysFuture(Value: integer);
    Procedure ReporttoERPforduplicatePrefRecord(xEmployeeName:String; reccount:Integer);
    procedure setShowDeliveryDetailsformonDeldocketprint(const Value: boolean);
    procedure setShowManufacutresummarywhenchangedfromSales(const Value: boolean);
    Procedure SetHideMSgonEmployeeCalendar (Const Value:boolean);
    Procedure SetShowVideoMenuAtStartup (Const Value:boolean);
    Procedure SetShowERPTips (Const Value:boolean);
    Procedure SetRunManufacturingUpdateBatch (Const Value:boolean);
    Procedure SetDefaultOrderinTransForms (Const Value:boolean);
    Procedure SetImageScheme(const Value:String);
    Procedure SetShowImageOnMainBackGround (Const Value:boolean);
//    Procedure SetShowPrintOptionsinTransforms (Const Value:boolean);
    Function UpdatePersonalpreferences(const FieldName: String;Value: boolean):Boolean;Overload;
    //Function UpdatePersonalpreferences(const FieldName: String;Value: TDateTime):Boolean;Overload;
    Function UpdatePersonalpreferences(const FieldName: String;Value: String):Boolean;Overload;
    function UpdatePersonalpreferences(const FieldName: String; Value: integer): boolean; overload;
    procedure setOpenTreeFromSalesOrder(const Value: boolean);
    procedure setCapacityplannerSelectionOptionBeforeLoad(const Value: boolean);
    procedure setManufacturePartSourceStockconfirm(const Value: boolean);
    Procedure SetPrintAddressLabelfromDelPrint(Const Value: Boolean);
    Procedure setShowSalesProductAutoSelectOptions(const Value :Boolean);
    function ValidateReminderdays(const value: Integer): Integer;
    procedure SetCyTrackIntegrationEnabled(const Value: boolean);
    procedure SetCyTrackPortNumber(const Value: integer);
    procedure SetEmployeemaxDiscountPercentage(const Value: double);
    procedure SetEmployeeMinMarkupPercentage(const Value: double);
    procedure SetEmployeeMinimumMarginPercentage(const Value: double);
    Procedure SetShowOverduesalesReminders (Const Value:boolean);
    Procedure SetShowFinishedProgressBuildReminder (Const Value:boolean);
    Procedure SetShowRelatedProductSelectioninSale (Const Value:boolean);
    function getMaximumDiscountPercentage: double;
    function getMinimumMarkupPercentage: double;
    function getMinimumMarginPercentage: double;
    procedure SetShowProductListtypeSelection(const Value: boolean);
    procedure SetShowProductListtypeSelectionforExpress(const Value: boolean);
    procedure SetShowProductListtypeSelectionforQtyList(const Value: boolean);
    procedure SetShowProductListtypeSelectionforDetails(const Value: boolean);
    procedure SetProductListType(const Value: String);
    procedure SetBOMSalesList(const Value: String);
    procedure SetStockanalysisReport(const Value: String);
    procedure SetShowReportTablesMsg(const Value: boolean);
    procedure setCustomerPriceLsitOption(const Value: integer);
    procedure SetUseAlternatingRowColor(const Value: boolean);
    procedure setColourAlternatingRow(const Value: integer);
    procedure setGradIntensityAlternatingRow(const Value: integer);

    procedure SetUseERPSingleColor(const Value: boolean);
    procedure setColourERPSingle(const Value: integer);
    procedure setGradIntensityERPSingle(const Value: integer);

    procedure SetUseERPButtonColor(const Value: boolean);
    procedure setColourERPButton(const Value: integer);
    procedure setGradIntensityERPButton(const Value: integer);

    procedure setColourERPButtonFont(const Value: integer);
    procedure setGradIntensityERPButtonFont(const Value: integer);
    procedure setColourERPButtonHT(const Value: integer);
    procedure setGradIntensityERPButtonHT(const Value: integer);

    function GetShowImageOnMainBackGround: boolean;
    function getColourERPButtonFont: integer;
    property EmployeeMinMarkupPercentage: double read fEmployeeMinMarkupPercentage write SetEmployeeMinMarkupPercentage;
    property EmployeeMinimumMarginPercentage: double read fEmployeeMinimumMarginPercentage write SetEmployeeMinimumMarginPercentage;
    procedure SetShowGrossWeightnQtyCalcMsg(const Value: boolean);
    procedure SetUseGradBackground(const Value: boolean);
    procedure SetCalcnshowAvailaibityinCapacityPlanner(const Value: boolean);
  Protected
    fiEmployeeID: integer;
    qryPersonalPreferences: TERPQuery;
  public
//    class procedure Instance;
    constructor Create;
    destructor Destroy; override;
    //
    procedure PopulateMe(const iEmployeeID: integer; const UserOnly: boolean = true); overload;Virtual;
    procedure PopulateMe(const EmployeeName: string; const UserOnly: boolean = true); overload;
    function CanAutoCreateSmartOrders: boolean;
    function CanAutoCreateRepairs(const ficlassId : Integer = 0): boolean;

    // Public properties.
    property LogonPassword: string read fsLogonPassword;
    property LogonName: string read fsLogonName;
    property Title: string read fsTitle;
    property FirstName: string read fsFirstName;
    property MiddleName: string read fsMiddleName;
    property LastName: string read fsLastName;
    property EmployeeName: string read fsEmployeeName;
    property Street: string read fsStreet;
    property Street2: string read fsStreet2;
    property Suburb: string read fsSuburb;
    property State: string read fsState;
    property PostCode: string read fsPostCode;
    property OptionNo: integer read fiOptionNo;
    property PasswordID: integer read fiPasswordID;
    property EmployeeID: integer read fiEmployeeID;
    property EmployeeNo: integer read fiEmployeeNo;
    property Email: string read fsEmail;
    property TFN : string read fsTFN;
    property UseEmpEmailAsFromAddress:boolean read fdUseEmpEmailAsFromAddress;
    {More fields to be added on a needs basis}

    property APPAppearDays: integer read fiAPPAppearDays;
    property ToDoAppearDays: integer read fiToDoAppearDays;
    property PendingSOAppearDays: integer read fiPendingSOAppearDays;
    property OthContactAppearDays: integer read fiOthContactAppearDays;
    property QuoteAppearDays: integer read fiQuoteAppearDays;
    property FixedAssetWarrantyAppearDays: integer read fiFixedAssetWarrantyAppearDays;
    property FixedAssetInsuranceAppearDays: integer read fiFixedAssetInsuranceAppearDays;
    property MemTransAppearDays: integer read fiMemTransAppearDays;
    property ProductClassWarning: boolean read fbProductClassWarning;
    property ListDaysPast: integer read fiListDaysPast write SetListDaysPast;
    property ListDaysFuture: integer read fiListDaysFuture write SetListDaysFuture;
    property UseWord: boolean read fbUseWord;
    property CustomerLoyaltyAppearDays: integer read fiCustomerLoyaltyAppearDays;
    property ContactLoyaltyAppearDays: integer read fiContactLoyaltyAppearDays;
    property EmployeeskillRenewalAppearDays: integer read fiEmployeeskillRenewalAppearDays;
    property POSAutoLoad: boolean read fbPOSAutoLoad;
    property ShowPrintDialog: boolean read fbShowPrintDialog write fbShowPrintDialog;
    property ShowPreview: boolean read fbShowPreview;
    Property PreviewAllreport  :Boolean read fbBPRPreview write fbBPRPreview;
    property ListSelectionColour: TColor read fsListSelectionColour;
    property PayrollAccess: boolean read fbPayrollAccess;
    property AutoApplyDeposit: boolean read fbAutoApplyDeposit;
    property NoQtyDrillDownOnSales: boolean read fbNoQtyDrillDownOnSales;
    property CloseOnPrint: boolean read fbCloseOnPrint;
    property UseClientAccountNoOnPayments: boolean read fbUseClientAccountNoOnPayments;
    property DefaultClassName: string read fsDefaultClassName write fsDefaultClassName;
    property DefaultClassID: integer read fiDefaultClassID write fiDefaultClassID;
    property OverrideAutoSmartOrders: boolean read fbOverrideAutoSmartOrders write fbOverrideAutoSmartOrders;
    property MarketingContactsAppearDays: integer read fiMarketingContactsAppearDays;
    property LeadsAppearDays: integer read fiLeadsAppearDays;
    Property ServiceLogAprearDays :Integer read fiServiceLogAprearDays;
    property GoodToReceiveReminderDays: integer read fiGoodToReceiveReminderDays;
    Property ReceivedBOAppearDays :Integer read fiReceivedBOAppearDays;
    property EquipmentServiceAppearDays: integer read fiEquipmentServiceAppearDays;
    property ERPLicenseRenewalAppearDays: integer read fiERPLicenseRenewalAppearDays;

    property CommissionOn: String read fsCommissionOn;
    Property CommissionOnPaid :Boolean REad fbCommissionOnPaid;
    property CommissionFlatRate: double read fdCommissionFlatRate;
    Property Overheadbaserate :Double Read fdOverheadbaserate;
    property CommissionInvoiceExPrice: boolean read fbCommissionInvoiceExPrice;
    property CommissionUseEmp: boolean read fbCommissionUseEmp;
    property CommissionUseProd: boolean read fbCommissionUseProd;

    property UserFirstName: string read fsUserFirstName write fsUserFirstName;
    property UserLastName: string read fsUserLastName write fsUserLastName;
    property UserFullName: string read fsUserFullName write fsUserFullName;
    property ActiveWindow: integer read fbActiveWindows;

    property Calender24hr :Boolean read fbCalender24hr;
    property PopRemindersToDo :Boolean read fbPopRemindersToDo Write fbPopRemindersToDo;
    property ShowERPTips :Boolean read fbShowERPTips Write SetShowERPTips;
    property RunManufacturingUpdateBatch :Boolean read fbRunManufacturingUpdateBatch Write SetRunManufacturingUpdateBatch;
    property DefaultOrderinTransForms :Boolean read fbDefaultOrderinTransForms Write SetDefaultOrderinTransForms;
    Property ImageScheme :String read fsImageScheme write setImageScheme;
    property PopRemindersMFollowup :Boolean read fbPopRemindersMFollowup Write fbPopRemindersMFollowup;
    property PopRemindersMessages :Boolean read fbPopRemindersMessages Write fbPopRemindersMessages;
    property ShowDeliveryDetailsformonDeldocketprint: boolean read fbShowDeliveryDetailsformonDeldocketprint Write setShowDeliveryDetailsformonDeldocketprint;
    property ShowManufacutresummarywhenchangedfromSales: boolean read fbShowManufacutresummarywhenchangedfromSales Write setShowManufacutresummarywhenchangedfromSales;
    Property HideMSgonEmployeeCalendar :boolean read fbHideMSgonEmployeeCalendar Write setHideMSgonEmployeeCalendar;
    Property ShowImageOnMainBackGround :boolean read GetShowImageOnMainBackGround Write SetShowImageOnMainBackGround;
//    Property ShowPrintOptionsinTransforms :boolean read fbShowPrintOptionsinTransforms Write SetShowPrintOptionsinTransforms;
    property OpenTreeFromSalesOrder: boolean  read fbOpenTreeFromSalesOrder Write setOpenTreeFromSalesOrder;
    property CapacityplannerSelectionOptionBeforeLoad: boolean  read fbCapacityplannerSelectionOptionBeforeLoad write setCapacityplannerSelectionOptionBeforeLoad;
    property ManufacturePartSourceStockconfirm: boolean read fbManufacturePartSourceStockconfirm write setManufacturePartSourceStockconfirm;
    Property PrintAddressLabelfromDelPrint : Boolean read fbPrintAddressLabelfromDelPrint write setPrintAddressLabelfromDelPrint;
    Property ShowSalesProductAutoSelectOptions :Boolean read fbShowSalesProductAutoSelectOptions write setShowSalesProductAutoSelectOptions;


    property ShowVideoMenuAtStartup: boolean read fShowVideoMenuAtStartup write setShowVideoMenuAtStartup;
    property TrackEmails: boolean read fbTrackEmails;
    property CyTrackIntegrationEnabled: boolean read fCyTrackIntegrationEnabled write SetCyTrackIntegrationEnabled;
    property CyTrackPortNumber: integer read fCyTrackPortNumber write SetCyTrackPortNumber;
    property ExpenseClaimAppearDays: integer read fExpenseClaimAppearDays;
    property CalendarTimeZones: TJsonObject read fCalendarTimeZones;
    property ShowOverduesalesReminders :Boolean read fbShowOverduesalesReminders Write SetShowOverduesalesReminders;
    property ShowFinishedProgressBuildReminder :Boolean read fbShowFinishedProgressBuildReminder Write SetShowFinishedProgressBuildReminder;
    property ShowRelatedProductSelectioninSale :Boolean read fbShowRelatedProductSelectioninSale Write SetShowRelatedProductSelectioninSale;
    procedure SaveCalendarTimeZones;
    property EmployeemaxDiscountPercentage: double read fEmployeemaxDiscountPercentage write SetEmployeemaxDiscountPercentage;
    Property MaximumDiscountPercentage :double read getMaximumDiscountPercentage;
    property MinimumMarkupPercentage: double read getMinimumMarkupPercentage;
    property MinimumMarginPercentage: double read getMinimumMarginPercentage;
    property ShowProductListtypeSelection: boolean read fbShowProductListtypeSelection Write SetShowProductListtypeSelection;
    property ShowProductListtypeSelectionforExpress: boolean read fbShowProductListtypeSelectionforExpress Write SetShowProductListtypeSelectionforExpress;
    property ShowProductListtypeSelectionforQtyList: boolean read fbShowProductListtypeSelectionforQtyList Write SetShowProductListtypeSelectionforQtyList;
    property ShowProductListtypeSelectionforDetails: boolean read fbShowProductListtypeSelectionforDetails Write SetShowProductListtypeSelectionforDetails;
    property ProductListType: String read fsProductListType write SetProductListType;
    property BOMSalesList: String read fsBOMSalesList write SetBOMSalesList;
    property StockanalysisReport: String read fsStockanalysisReport write SetStockanalysisReport;
    property ShowReportTablesMsg: boolean read fbShowReportTablesMsg Write SetShowReportTablesMsg;
    property SupportLogLinesAppearDays: integer read fSupportLogLinesAppearDays;
    property CustomerPriceLsitOption: integer read fiCustomerPriceLsitOption write setCustomerPriceLsitOption;
    property UseAlternatingRowColor: boolean read fbUseAlternatingRowColor Write SetUseAlternatingRowColor;
    property ColourAlternatingRow: integer read fiColourAlternatingRow write setColourAlternatingRow;
    property GradIntensityAlternatingRow: integer read fiGradIntensityAlternatingRow write setGradIntensityAlternatingRow;
    Property AlternatingRowColor: TColor Read FAlternatingRowColor;
    property UseERPSingleColor: boolean read fbUseERPSingleColor Write SetUseERPSingleColor;
    property ColourERPSingle: integer read fiColourERPSingle write setColourERPSingle;
    property GradIntensityERPSingle: integer read fiGradIntensityERPSingle write setGradIntensityERPSingle;
    Property ERPSingleColor: TColor Read FERPSingleColor;
    property UseERPButtonColor: boolean read fbUseERPButtonColor Write SetUseERPButtonColor;
    property ColourERPButton: integer read fiColourERPButton write setColourERPButton;
    property GradIntensityERPButton: integer read fiGradIntensityERPButton write setGradIntensityERPButton;
    Property ERPButtonColor: TColor Read FERPButtonColor;

    property ColourERPButtonFont: integer read getColourERPButtonFont write setColourERPButtonFont;
    property GradIntensityERPButtonFont: integer read fiGradIntensityERPButtonFont write setGradIntensityERPButtonFont;
    Property ERPButtonFontColor: TColor Read FERPButtonFontColor;

    property ColourERPButtonHT: integer read fiColourERPButtonHT write setColourERPButtonHT;
    property GradIntensityERPButtonHT: integer read fiGradIntensityERPButtonHT write setGradIntensityERPButtonHT;
    Property ERPButtonHTColor: TColor Read FERPButtonHTColor;
    property ShowGrossWeightnQtyCalcMsg: boolean read fbShowGrossWeightnQtyCalcMsg Write SetShowGrossWeightnQtyCalcMsg;
    property UseGradBackground: boolean read fbUseGradBackground Write SetUseGradBackground;
    property CalcnshowAvailaibityinCapacityPlanner: boolean read fbCalcnshowAvailaibityinCapacityPlanner Write SetCalcnshowAvailaibityinCapacityPlanner;
  end;

implementation

uses
  MyAccess,DB, Dialogs, CommonDbLib, CommonLib,
  DNMLib, AppEnvironment, ProgressDialog, AppDatabase, SimpleEncrypt,
  PreferenceLib, MySQLConst, SystemLib, ERPErrorEmailUtils, FileVersion,
  PreferancesLib , GraphUtil, tcConst;

procedure TEmployeeObj.PopulateMe(const EmployeeName: string; const UserOnly: boolean);
var
  qry: TERPQuery;
  EmpId: integer;
begin
  qry:= CommonDbLib.TempMyQuery;
  try
    qry.SQL.Text:= 'SELECT EmployeeID FROM tblEmployees WHERE EmployeeName = '+
      QuotedStr(EmployeeName);
    qry.Open;
    EmpId:= qry.FieldByName('EmployeeId').AsInteger;
  finally
    FreeAndNil(qry);
  end;
  PopulateMe(EmpId,UserOnly);
end;

function TEmployeeObj.ValidateReminderdays(const value:Integer):Integer;
begin
  result:= Value;
  if result <-500 then result := -500 else if result >500 then result := 500;
end;

procedure TEmployeeObj.PopulateMe(const iEmployeeID: integer; const UserOnly: boolean = true);
var
    qryEmployee: TERPQuery;
  {Normally separate the data layer, however due to RAD, not option}
  procedure FindEmployeeDetails;
  begin
    with qryEmployee do begin
      Sql.Add('SELECT ' +
        'p.Pswd_ID, p.Logon_Name, p.Logon_Password, p.OptionNo, e.EmployeeID, e.CommissionInvoiceExPrice, ' +
        'e.Title, e.Firstname, e.Middlename, e.Lastname, e.Street, e.Street2, e.Suburb,e.State,e.DefaultClassName, ' +
        'e.DefaultClassID, e.CommissionOnPaid, e.Postcode, e.Email/*, e.CommissionFlatRate, e.CommissionOn, e.Overheadbaserate, ' +
        'e.CommissionUseEmp, e.CommissionUseProd*/,e.EmailsFromEmployeeAddress, e.EmployeeNo, e.TrackEmails, e.TFN ' +
        'FROM tblEmployees AS e ' +
        'LEFT JOIN tblPassword p ON e.EmployeeID=p.EmployeeId ' +
        'WHERE e.EmployeeID = :xEmployeeID AND e.Active="T"');
      if UserOnly then Sql.Add('AND p.Logon_Name IS NOT NULL');
      Params.ParamByName('xEmployeeID').AsInteger := iEmployeeID;
      try
        Open;
      except 
      end;
    end;
  end;

  procedure FindPreferencesDetails;
  begin
    with qryPersonalPreferences do begin
      Sql.Add('SELECT * ' +
        'FROM tblPersonalPreferences ' +
        'WHERE EmployeeID = :xEmployeeID ORDER BY PPID DESC');
      Params.ParamByName('xEmployeeID').AsInteger := iEmployeeID;
      Open;
      if recordcount > 1 then begin
        ProgressDialog.DoShowProgressbar(recordcount , 'Deleting Duplicate Personal Preference Record(s)' ,'Wait While Sending Email to ERP' );
        try
          ReporttoERPforduplicatePrefRecord(fsTitle +' ' +fsFirstName +' ' +  fsMiddleName +' ' + fsLastName, recordcount);
          ProgressDialog.DoStepProgressbar('Deleting...');
          While recordcount >1 do begin
              First;
              Delete;
              ProgressDialog.DoStepProgressbar('Deleting...');
          end;
        finally
            ProgressDialog.DoHideProgressbar;
        end;
      end;
    end;
  end;
begin //--- Begin PopulateMe
  try
    qryEmployee := TERPQuery.Create(nil);
    qryEmployee.Connection := CommonDbLib.GetSharedMyDacConnection;

    FindEmployeeDetails;

    with qryEmployee do try
        fsLogonPassword := Decrypt(FieldByName('Logon_Password').AsString, 'z');
        fsLogonName := FieldByName('Logon_Name').AsString;
        fsTitle := FieldByName('Title').AsString;
        fsFirstName := FieldByName('FirstName').AsString;
        fsMiddleName := FieldByName('MiddleName').AsString;
        fsLastName := FieldByName('LastName').AsString;
        fsEmployeeName := fsFirstName + ' '+ fsLastName;
        fsStreet := FieldByName('Street').AsString;
        fsStreet2 := FieldByName('Street2').AsString;
        fsSuburb := FieldByName('Suburb').AsString;
        fsState := FieldByName('State').AsString;
        fsPostCode := FieldByName('PostCode').AsString;
        fiOptionNo := FieldByName('OptionNo').AsInteger;
        fiPasswordID := FieldByName('Pswd_ID').AsInteger;
        fiEmployeeID := FieldByName('EmployeeID').AsInteger;
        fiEmployeeNo := FieldByName('EmployeeNo').AsInteger;
        fiDefaultClassID := FieldByName('DefaultClassID').AsInteger;
        fsDefaultClassName := GetClassName(FieldByName('DefaultClassID').AsInteger);
        fsEmail := FieldByName('Email').AsString;
        fsTFN := FieldByName('TFN').AsString;
        fdUseEmpEmailAsFromAddress := FieldByName('EmailsFromEmployeeAddress').AsBoolean;
        (*fdCommissionFlatRate := FieldByName('CommissionFlatRate').AsFloat;
        fdOverheadbaserate := fieldByname('Overheadbaserate').asFloat;
        fsCommissionOn := FieldByName('CommissionOn').AsString;
        fbCommissionOnPaid := FieldByname('CommissionOnPaid').asBoolean;
        fbCommissionInvoiceExPrice := FieldByName('CommissionInvoiceExPrice').AsBoolean;
        fbCommissionUseProd := FieldByName('CommissionUseProd').AsBoolean;
        fbCommissionUseEmp := FieldByName('CommissionUseEmp').AsBoolean;*)
        fbTrackEmails:= FieldByName('TrackEmails').AsBoolean;


      finally
        // Free our used objects.
        FreeandNil(qryEmployee);
      end;
  except
    on e: Exception do begin
      if devmode then else
        raise Exception.Create(e.message);
    end;
  end;
  try
    fbCloseOnPrint := True; // the preferance is being removed, and the form is always closed after print
    qryPersonalPreferences := TERPQuery.Create(nil);
    qryPersonalPreferences.Connection := CommonDbLib.GetSharedMyDacConnection;
    FindPreferencesDetails;
    with qryPersonalPreferences do try
        if RecordCount = 1 then begin
          fbActiveWindows := FieldByName('ActiveWindow').asinteger;
          //fsPOLayout := FieldByName('POLayout').AsString;
          fbUseWord := FieldByName('UseWord').AsBoolean;
          fiListDaysPast := FieldByName('ListDaysPast').AsInteger;
          fbPOSAutoLoad := FieldByName('POSAutoLoad').AsBoolean;
          fbShowPreview := FieldByName('ShowPreview').AsBoolean;
          fbBPRPreview  := FieldByName('PreviewAllreport').AsBoolean;
          fiListDaysFuture := FieldByName('ListDaysFuture').AsInteger;
          fbShowPrintDialog := FieldByName('ShowPrintDialog').AsBoolean;
          fiPendingSOAppearDays := FieldByName('PendingSOAppearDays').AsInteger;
          fiCustomerLoyaltyAppearDays         := ValidateReminderdays(FieldByName('CustomerLoyaltyAppearDays').AsInteger);
          fiContactLoyaltyAppearDays          := ValidateReminderdays(FieldByName('ContactLoyaltyAppearDays').AsInteger);
          fiEmployeeskillRenewalAppearDays    := ValidateReminderdays(FieldByName('EmployeeskillRenewalAppearDays').AsInteger);
          fiLeadsAppearDays                   := ValidateReminderdays(FieldByName('LeadsAppearDays').AsInteger);
          fiServiceLogAprearDays              := ValidateReminderdays(FieldByname('ServiceLogAprearDays').asInteger);
          fiGoodToReceiveReminderDays         := ValidateReminderdays(FieldByName('GoodToReceiveReminderDays').AsInteger);
          fiReceivedBOAppearDays              := ValidateReminderdays(Fieldbyname('ReceivedBOAppearDays').AsInteger);
          fiToDoAppearDays                    := ValidateReminderdays(FieldByName('ToDoAppearDays').AsInteger);
          fiQuoteAppearDays                   := ValidateReminderdays(FieldByName('QuoteAppearDays').AsInteger);
          fiOthContactAppearDays              := ValidateReminderdays(FieldByName('OthContactAppearDays').AsInteger);
          fiAPPAppearDays                     := ValidateReminderdays(FieldByName('APPAppearDays').AsInteger);
          fiMemTransAppearDays                := FieldByName('MemTransAppearDays').AsInteger;
          fiFixedAssetWarrantyAppearDays      := ValidateReminderdays(FieldByName('FixedAssetWarrantyExpiresAppearDays').AsInteger);
          fiFixedAssetInsuranceAppearDays     := ValidateReminderdays(FieldByName('FixedAssetInsuranceExpiresAppearDays').AsInteger);
          fiMarketingContactsAppearDays       := ValidateReminderdays(FieldByName('MarketingContactsAppearDays').AsInteger);
          fExpenseClaimAppearDays             := ValidateReminderdays(FieldByName('ExpenseClaimAppearDays').AsInteger);
          fSupportLogLinesAppearDays          := ValidateReminderDays(FieldByName('SupportLogLinesAppearDays').AsInteger);
          fiCustomerPriceLsitOption           := ValidateReminderDays(FieldByName('CustomerPriceLsitOption').AsInteger);
          fiEquipmentServiceAppearDays        := FieldByName('EquipmentServiceAppearDays').AsInteger;
          fiERPLicenseRenewalAppearDays       := FieldByName('ERPLicenseRenewalAppearDays').AsInteger;

          fiColourAlternatingRow              := FieldByName('ColourAlternatingRow').AsInteger;
          fiGradIntensityAlternatingRow       := FieldByName('GradIntensityAlternatingRow').AsInteger;
          FAlternatingRowColor                := GraphUtil.ColorAdjustLuma(FieldByName('ColourAlternatingRow').AsInteger, FieldByName('GradIntensityAlternatingRow').AsInteger Div 2, False);

          fiColourERPSingle                   := FieldByName('ColourERPSingle').AsInteger;
          fiGradIntensityERPSingle            := FieldByName('GradIntensityERPSingle').AsInteger;
          FERPSingleColor                     := GraphUtil.ColorAdjustLuma(FieldByName('ColourERPSingle').AsInteger, FieldByName('GradIntensityERPSingle').AsInteger Div 2, False);

          fiColourERPButton                   := FieldByName('ColourERPButton').AsInteger;
          fiGradIntensityERPButton            := FieldByName('GradIntensityERPButton').AsInteger;
          FERPButtonColor                     := GraphUtil.ColorAdjustLuma(FieldByName('ColourERPButton').AsInteger, FieldByName('GradIntensityERPButton').AsInteger Div 2, False);

          fiColourERPButtonFont                   := FieldByName('ColourERPButtonFont').AsInteger;
          fiGradIntensityERPButtonFont            := FieldByName('GradIntensityERPButtonFont').AsInteger;
          FERPButtonFontColor                     := GraphUtil.ColorAdjustLuma(FieldByName('ColourERPButtonFont').AsInteger, FieldByName('GradIntensityERPButtonFont').AsInteger Div 2, False);

          fiColourERPButtonHT                   := FieldByName('ColourERPButtonHT').AsInteger;
          fiGradIntensityERPButtonHT            := FieldByName('GradIntensityERPButtonHT').AsInteger;
          FERPButtonHTColor                     := GraphUtil.ColorAdjustLuma(FieldByName('ColourERPButtonHT').AsInteger, FieldByName('GradIntensityERPButtonHT').AsInteger Div 2, False);

          if not Empty(FieldByName('ListSelectionColour').AsString) then
            fsListSelectionColour := StrToInt(FieldByName('ListSelectionColour').AsString);
          fbPayrollAccess := FieldByName('PayrollAccess').AsBoolean;
          fbAutoApplyDeposit := FieldByName('AutoApplyDeposits').AsBoolean;
          fbNoQtyDrillDownOnSales := FieldByName('NoQtyDrillDownOnSales').AsBoolean;
          fbProductClassWarning := FieldByName('ProductClassWarning').AsBoolean;
          fbUseClientAccountNoOnPayments := FieldByName('UseClientAccountNoOnPayments').AsBoolean;
          fbOverrideAutoSmartOrders := FieldByName('OverrideAutoSmartOrders').AsBoolean;
          fbCalender24hr := FieldByName('Calender24hr').AsBoolean;
          fbShowDeliveryDetailsformonDeldocketprint:= FieldByName('ShowDeliveryDetailsformonDeldocketprint').AsBoolean;
          fbShowManufacutresummarywhenchangedfromSales:= FieldByName('ShowManufacutresummarywhenchangedfromSales').AsBoolean;
          fbHideMSgonEmployeeCalendar := fieldByname('HideMSgonEmployeeCalendar').asBoolean;
          fbShowImageOnMainBackGround := fieldByname('ShowImageOnMainBackGround').asBoolean;
//          fbShowPrintOptionsinTransforms := fieldByname('ShowPrintOptionsinTransforms').asBoolean;
          fbOpenTreeFromSalesOrder:= FieldByName('OpenTreeFromSalesOrder').AsBoolean;
          fbCapacityplannerSelectionOptionBeforeLoad:= FieldByName('CapacityplannerSelectionOptionBeforeLoad').AsBoolean;
          fbManufacturePartSourceStockconfirm:= FieldByName('ManufacturePartSourceStockconfirm').AsBoolean;
          fbPrintAddressLabelfromDelPrint := fieldbyname('PrintAddressLabelfromDelPrint').asBoolean;
          fbShowSalesProductAutoSelectOptions:= Fieldbyname('ShowSalesProductAutoSelectOptions').asBoolean;
          fbShowERPTips := FieldByName('ShowERPTips').AsBoolean;
          fbRunManufacturingUpdateBatch := FieldByName('RunManufacturingUpdateBatch').AsBoolean;
          fbDefaultOrderinTransForms := FieldByName('DefaultOrderinTransForms').AsBoolean;
          fsImageScheme := FieldByname('ImageScheme').AsString;
          if fsImageScheme = '' then fsImageScheme := 'Default';
//          fbPopRemindersToDo := FieldByName('PopRemindersToDo').AsBoolean;
//          fbPopRemindersMFollowup := FieldByName('PopRemindersMFollowup').AsBoolean;
//          fbPopRemindersMessages := FieldByName('PopRemindersMessages').AsBoolean;
          fbPopRemindersToDo := false;
          fbPopRemindersMFollowup := false;
          fbPopRemindersMessages := false;
          fShowVideoMenuAtStartup:= FieldByName('ShowVideoMenuAtStartup').AsBoolean;
          fCyTrackPortNumber := FieldByName('CyTrackPortNumber').AsInteger;
          fCyTrackIntegrationEnabled := FieldByName('CyTrackIntegrationEnabled').AsBoolean;
          fEmployeemaxDiscountPercentage := FieldByName('MaxDiscountPercentage').AsFloat;if fEmployeemaxDiscountPercentage <>0 then fEmployeemaxDiscountPercentage := fEmployeemaxDiscountPercentage /100;
          fEmployeeMinMarkupPercentage := FieldByName('MinMarkupPercentage').AsFloat; if fEmployeeMinMarkupPercentage <> 0 then fEmployeeMinMarkupPercentage := fEmployeeMinMarkupPercentage /100;
          fEmployeeMinimumMarginPercentage := FieldByName('MinimumMarginPercentage').AsFloat; if fEmployeeMinimumMarginPercentage <> 0 then fEmployeeMinimumMarginPercentage := fEmployeeMinimumMarginPercentage /100;
          fCalendarTimeZones.AsString := FieldByName('CalendarTimeZones').AsString;
          fbShowOverduesalesReminders := FieldByName('ShowOverduesalesReminders').AsBoolean;
          fbShowFinishedProgressBuildReminder := FieldByName('ShowFinishedProgressBuildReminder').AsBoolean;
          fbShowRelatedProductSelectioninSale := FieldByName('ShowRelatedProductSelectioninSale').AsBoolean;
          fsProductListType := FieldByName('ProductListType').asString;
          fsBOMSalesList := FieldByName('BOMSalesList').asString;
          fsStockanalysisReport := FieldByName('StockanalysisReport').asString;
          fbShowProductListtypeSelection := FieldByName('ShowProductListtypeSelection').AsBoolean;
          fbShowProductListtypeSelectionforExpress := FieldByName('ShowProductListtypeSelectionforExpress').AsBoolean;
          fbShowProductListtypeSelectionforQtyList := FieldByName('ShowProductListtypeSelectionforQtyList').AsBoolean;
          fbShowProductListtypeSelectionforDetails := FieldByName('ShowProductListtypeSelectionforDetails').AsBoolean;
          fbShowReportTablesMsg := FieldByName('ShowReportTablesMsg').AsBoolean;
          fbUseAlternatingRowColor := FieldByName('UseAlternatingRowColor').AsBoolean;
          fbUseERPSingleColor := FieldByName('UseERPSingleColor').AsBoolean;
          fbUseERPButtonColor := FieldByName('UseERPButtonColor').AsBoolean;

          if fiColourAlternatingRow = 0 then fiColourAlternatingRow := Default_ColourAlternatingRow;
          if fiColourERPSingle      = 0 then fiColourERPSingle      := Default_ColourERPSingle;
          if fiColourERPButton      = 0 then fiColourERPButton      := Default_ColourERPButton;
          if fiColourERPButtonFont  = 0 then fiColourERPButtonFont  := Default_ColourERPButtonFont;
          if fiColourERPButtonHT    = 0 then fiColourERPButtonHT    := Default_ColourERPButtonHT;

          fbShowGrossWeightnQtyCalcMsg := FieldByName('ShowGrossWeightnQtyCalcMsg').AsBoolean;
          fbUseGradBackground := FieldByName('UseGradBackground').AsBoolean;
          fbCalcnshowAvailaibityinCapacityPlanner := FieldByName('CalcnshowAvailaibityinCapacityPlanner').AsBoolean;

        end;
        Close;
      finally
        FreeandNil(qryPersonalPreferences);
      end;
  except
    on e: Exception do begin
      if devmode then
        MessageDlgXP_Vista(E.message, mtError, [mbOK], 0)
      else
        raise Exception.Create(e.message);
    end;
  end;
end;

procedure TEmployeeObj.SetListDaysFuture(Value: integer);
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('UPDATE tblpersonalpreferences SET ListDaysFuture= ' + IntToStr(Value) +
      ' Where EmployeeID=' + IntToStr(fiEmployeeID) + ';');
    qryTemp.Execute;
    fiListDaysFuture := Value;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TEmployeeObj.SetListDaysPast(Value: integer);
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('UPDATE tblpersonalpreferences SET ListDaysPast= ' + IntToStr(Value) +
      ' Where EmployeeID=' + IntToStr(fiEmployeeID) + ';');
    qryTemp.Execute;
    fiListDaysPast := Value;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TEmployeeObj.SaveCalendarTimeZones;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('UPDATE tblpersonalpreferences SET CalendarTimeZones = ' + QuotedStr(fCalendarTimeZones.AsString) +
      ' Where EmployeeID=' + IntToStr(fiEmployeeID) + ';');
    qryTemp.Execute;
    PreferancesLib.DoPrefAuditTrail;
  finally
    FreeAndNil(qryTemp);
  end;
end;


//fCalendarTimeZones


Function TEmployeeObj.UpdatePersonalpreferences(const FieldName: String;Value: String):Boolean;
var
  qryTemp: TERPCommand;
  LockMessage:String;
begin
  REsult:= False;
  if LockPreferenceTable(LockMessage) then try
      qryTemp := TERPCommand.Create(nil);
      qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
      try
        qryTemp.Sql.Add('UPDATE tblpersonalpreferences SET ' + FieldName +' = ' + Quotedstr(Value)+' Where EmployeeID=' + IntToStr(fiEmployeeID) + ';');
        qryTemp.Execute;
        Result:= True;
      finally
        FreeAndNil(qryTemp);
      end;
  finally
    UnLockPreferenceTable;
  end;
end;
//Function TEmployeeObj.UpdatePersonalpreferences(const FieldName:String;Value:TDateTime ):Boolean;begin  result:= UpdatePersonalpreferences(FieldName ,FormatDateTime(MYSQLDateFormat , Value));end;
//procedure TEmployeeObj.SetShowPrintOptionsinTransforms(const Value: boolean);begin    if UpdatePersonalpreferences('ShowPrintOptionsinTransforms' , Value) then      fbShowPrintOptionsinTransforms:= Value;end;
Function TEmployeeObj.UpdatePersonalpreferences(const FieldName:String;Value:boolean):Boolean;begin  Result := UpdatePersonalpreferences(FieldName ,BooleanToStr(Value));end;
function TEmployeeObj.UpdatePersonalpreferences(const FieldName:String;Value:integer):Boolean;begin  Result := UpdatePersonalpreferences(FieldName, IntToStr(Value)    );end;

procedure TEmployeeObj.setCapacityplannerSelectionOptionBeforeLoad  (const Value: boolean);begin  if UpdatePersonalpreferences('CapacityplannerSelectionOptionBeforeLoad'   , Value)              then  fbCapacityplannerSelectionOptionBeforeLoad  := Value;end;
procedure TEmployeeObj.setCustomerPriceLsitOption                   (const Value: integer);begin  if UpdatePersonalpreferences('CustomerPriceLsitOption'                    , Value)              then  fiCustomerPriceLsitOption                   := Value;end;
procedure TEmployeeObj.setOpenTreeFromSalesOrder                    (const Value: boolean);begin  if UpdatePersonalpreferences('OpenTreeFromSalesOrder'                     , Value)              then  fbOpenTreeFromSalesOrder                    := Value;end;
procedure TEmployeeObj.setShowDeliveryDetailsformonDeldocketprint   (const Value: boolean);begin  if UpdatePersonalpreferences('ShowDeliveryDetailsformonDeldocketprint'    , Value)              then  fbShowDeliveryDetailsformonDeldocketprint   := Value;end;
procedure TEmployeeObj.setShowManufacutresummarywhenchangedfromSales(const Value: boolean);begin  if UpdatePersonalpreferences('ShowManufacutresummarywhenchangedfromSales' , Value)              then  fbShowManufacutresummarywhenchangedfromSales:= Value;end;
procedure TEmployeeObj.setHideMSgonEmployeeCalendar                 (const Value: boolean);begin  if UpdatePersonalpreferences('HideMSgonEmployeeCalendar'                  , Value)              then  fbHideMSgonEmployeeCalendar                 := Value;end;
procedure TEmployeeObj.setShowVideoMenuAtStartup                    (const Value: boolean);begin  if UpdatePersonalpreferences('ShowVideoMenuAtStartup'                     , Value)              then  fShowVideoMenuAtStartup                     := Value;end;
procedure TEmployeeObj.setShowERPTips                               (const Value: boolean);begin  if UpdatePersonalpreferences('ShowERPTips'                                , Value)              then  fbShowERPTips                               := Value;end;
procedure TEmployeeObj.setRunManufacturingUpdateBatch               (const Value: boolean);begin  if UpdatePersonalpreferences('RunManufacturingUpdateBatch'                , Value)              then  fbRunManufacturingUpdateBatch               := Value;end;
procedure TEmployeeObj.setDefaultOrderinTransForms                  (const Value: boolean);begin  if UpdatePersonalpreferences('DefaultOrderinTransForms'                   , Value)              then  fbDefaultOrderinTransForms                  := Value;end;
Procedure TEmployeeObj.setImageScheme                               (const Value: String );begin  if UpdatePersonalpreferences('ImageScheme'                                , Value)              then  fsImageScheme                               := Value;end;
procedure TEmployeeObj.SetShowImageOnMainBackGround                 (const Value: boolean);begin  if UpdatePersonalpreferences('ShowImageOnMainBackGround'                  , Value)              then  fbShowImageOnMainBackGround                 := Value;end;
procedure TEmployeeObj.setManufacturePartSourceStockconfirm         (const Value: boolean);begin  if UpdatePersonalpreferences('ManufacturePartSourceStockconfirm'          , Value)              then  fbManufacturePartSourceStockconfirm         := Value;end;
procedure TEmployeeObj.SetEmployeemaxDiscountPercentage             (const Value: double );begin  if UpdatePersonalpreferences('MaxDiscountPercentage'                      , FloatToStr(Value))  then  fEmployeemaxDiscountPercentage              := Value;end;
procedure TEmployeeObj.SetEmployeeMinMarkupPercentage               (const Value: double );begin  if UpdatePersonalpreferences('MinMarkupPercentage'                        , FloatToStr(Value))  then  fEmployeeMinMarkupPercentage                := Value;end;
procedure TEmployeeObj.SetEmployeeMinimumMarginPercentage           (const Value: double );begin  if UpdatePersonalpreferences('MinimumMarginPercentage'                    , FloatToStr(Value))  then  fEmployeeMinimumMarginPercentage            := Value;end;
procedure TEmployeeObj.setPrintAddressLabelfromDelPrint             (const Value: boolean);begin  if UpdatePersonalpreferences('PrintAddressLabelfromDelPrint'              , Value)              then  fbPrintAddressLabelfromDelPrint             := Value;end;
Procedure TEmployeeObj.SetShowSalesProductAutoSelectOptions         (const Value :boolean);begin  if UpdatePersonalpreferences('ShowSalesProductAutoSelectOptions'          , value)              then  fbShowSalesProductAutoSelectOptions         := Value;end;
procedure TEmployeeObj.setShowOverduesalesReminders                 (const Value: boolean);begin  if UpdatePersonalpreferences('ShowOverduesalesReminders'                  , Value)              then  fbShowOverduesalesReminders                 := Value;end;
procedure TEmployeeObj.SetShowProductListtypeSelection              (const Value: boolean);begin  if UpdatePersonalpreferences('ShowProductListtypeSelection'               , Value)              then  fbShowProductListtypeSelection              := Value;end;
procedure TEmployeeObj.SetShowProductListtypeSelectionforExpress    (const Value: boolean);begin  if UpdatePersonalpreferences('ShowProductListtypeSelectionforExpress'     , Value)              then  fbShowProductListtypeSelectionforExpress    := Value;end;
procedure TEmployeeObj.SetShowProductListtypeSelectionforQtyList    (const Value: boolean);begin  if UpdatePersonalpreferences('ShowProductListtypeSelectionforQtyList'     , Value)              then  fbShowProductListtypeSelectionforQtyList    := Value;end;
procedure TEmployeeObj.SetShowProductListtypeSelectionforDetails    (const Value: boolean);begin  if UpdatePersonalpreferences('ShowProductListtypeSelectionforDetails'     , Value)              then  fbShowProductListtypeSelectionforDetails    := Value;end;
procedure TEmployeeObj.setShowFinishedProgressBuildReminder         (const Value: boolean);begin  if UpdatePersonalpreferences('ShowFinishedProgressBuildReminder'          , Value)              then  fbShowFinishedProgressBuildReminder         := Value;end;
procedure TEmployeeObj.setShowRelatedProductSelectioninSale         (const Value: boolean);begin  if UpdatePersonalpreferences('ShowRelatedProductSelectioninSale'          , Value)              then  fbShowRelatedProductSelectioninSale         := Value;end;
procedure TEmployeeObj.SetProductListType                           (const Value: String );begin  if UpdatePersonalpreferences('ProductListType'                            , Value)              then  fsProductListType                           := Value;end;
procedure TEmployeeObj.SetBOMSalesList                              (const Value: String );begin  if UpdatePersonalpreferences('BOMSalesList'                               , Value)              then  fsBOMSalesList                              := Value;end;
procedure TEmployeeObj.SetStockanalysisReport                       (const Value: String );begin  if UpdatePersonalpreferences('StockanalysisReport'                        , Value)              then  fsStockanalysisReport                       := Value;end;
procedure TEmployeeObj.SetShowReportTablesMsg                       (const Value: boolean);begin  if UpdatePersonalpreferences('ShowReportTablesMsg'                        , Value)              then  fbShowReportTablesMsg                       := Value;end;
procedure TEmployeeObj.SetUseAlternatingRowColor                    (const Value: boolean);begin  if UpdatePersonalpreferences('UseAlternatingRowColor'                     , Value)              then  fbUseAlternatingRowColor                    := Value;end;
procedure TEmployeeObj.setColourAlternatingRow                      (const Value: integer);begin  if UpdatePersonalpreferences('ColourAlternatingRow'                       , Value)              then  fiColourAlternatingRow                      := Value;end;
procedure TEmployeeObj.setGradIntensityAlternatingRow               (const Value: integer);begin  if UpdatePersonalpreferences('GradIntensityAlternatingRow'                , Value)              then  fiGradIntensityAlternatingRow               := Value;end;
procedure TEmployeeObj.SetUseERPSingleColor                         (const Value: boolean);begin  if UpdatePersonalpreferences('UseERPSingleColor'                          , Value)              then  fbUseERPSingleColor                         := Value;end;
procedure TEmployeeObj.setColourERPSingle                           (const Value: integer);begin  if UpdatePersonalpreferences('ColourERPSingle'                            , Value)              then  fiColourERPSingle                           := Value;end;
procedure TEmployeeObj.setGradIntensityERPSingle                    (const Value: integer);begin  if UpdatePersonalpreferences('GradIntensityERPSingle'                     , Value)              then  fiGradIntensityERPSingle                    := Value;end;
procedure TEmployeeObj.SetUseERPButtonColor                         (const Value: boolean);begin  if UpdatePersonalpreferences('UseERPButtonColor'                          , Value)              then  fbUseERPButtonColor                         := Value;end;
procedure TEmployeeObj.setColourERPButton                           (const Value: integer);begin  if UpdatePersonalpreferences('ColourERPButton'                            , Value)              then  fiColourERPButton                           := Value;end;
procedure TEmployeeObj.setGradIntensityERPButton                    (const Value: integer);begin  if UpdatePersonalpreferences('GradIntensityERPButton'                     , Value)              then  fiGradIntensityERPButton                    := Value;end;
procedure TEmployeeObj.setColourERPButtonFont                       (const Value: integer);begin  if UpdatePersonalpreferences('ColourERPButtonFont'                        , Value)              then  fiColourERPButtonFont                       := Value;end;
procedure TEmployeeObj.setGradIntensityERPButtonFont                (const Value: integer);begin  if UpdatePersonalpreferences('GradIntensityERPButtonFont'                 , Value)              then  fiGradIntensityERPButtonFont                := Value;end;
procedure TEmployeeObj.setColourERPButtonHT                         (const Value: integer);begin  if UpdatePersonalpreferences('ColourERPButtonHT'                          , Value)              then  fiColourERPButtonHT                         := Value;end;
procedure TEmployeeObj.setGradIntensityERPButtonHT                  (const Value: integer);begin  if UpdatePersonalpreferences('GradIntensityERPButtonHT'                   , Value)              then  fiGradIntensityERPButtonHT                  := Value;end;
procedure TEmployeeObj.SetShowGrossWeightnQtyCalcMsg                (const Value: boolean);begin  if UpdatePersonalpreferences('ShowGrossWeightnQtyCalcMsg'                 , Value)              then  fbShowGrossWeightnQtyCalcMsg                := Value;end;
procedure TEmployeeObj.SetUseGradBackground                         (const Value: boolean);begin  if UpdatePersonalpreferences('UseGradBackground'                          , Value)              then  fbUseGradBackground                         := Value;end;
procedure TEmployeeObj.SetCalcnshowAvailaibityinCapacityPlanner     (const Value: boolean);begin  if UpdatePersonalpreferences('CalcnshowAvailaibityinCapacityPlanner'      , Value)              then  fbCalcnshowAvailaibityinCapacityPlanner     := Value;end;

procedure TEmployeeObj.SetCyTrackIntegrationEnabled(const Value: boolean);
begin
  if UpdatePersonalpreferences('CyTrackIntegrationEnabled', value) then
    fCyTrackIntegrationEnabled := Value;
end;

procedure TEmployeeObj.SetCyTrackPortNumber(const Value: integer);
begin
  if UpdatePersonalpreferences('CyTrackPortNumber', value) then
    fCyTrackPortNumber := Value;
end;


destructor TEmployeeObj.Destroy;
begin
  fCalendarTimeZones.Free;
  inherited;
end;

function TEmployeeObj.getColourERPButtonFont: integer;
begin
  result := fiColourERPButtonFont;
end;

function TEmployeeObj.getMaximumDiscountPercentage: double;
begin
  REsult := EmployeemaxDiscountPercentage;
  if (*(REsult > Appenv.CompanyPrefs.MaxDiscountPercentage) or*) (Result =0) then
    REsult := Appenv.CompanyPrefs.MaxDiscountPercentage;
end;

function TEmployeeObj.getMinimumMarkupPercentage: double;
begin
  REsult := EmployeeMinMarkupPercentage;
  if (*(REsult < Appenv.CompanyPrefs.MinMarkupPercentage) or*) (Result =0) then
    REsult := Appenv.CompanyPrefs.MinMarkupPercentage;
end;
function TEmployeeObj.GetShowImageOnMainBackGround: boolean;
begin
   //result := fbShowImageOnMainBackGround;
  { always show }
  result := true;
end;

function TEmployeeObj.getMinimumMarginPercentage: double;
begin
  REsult := EmployeeMinimumMarginPercentage;
  if (*(REsult < Appenv.CompanyPrefs.MinimumMarginPercentage) or*) (Result =0) then
    REsult := Appenv.CompanyPrefs.MinimumMarginPercentage;
end;

function TEmployeeObj.CanAutoCreateRepairs(const fiClassId : Integer = 0): boolean;
var
  qry: TERPQuery;
  iClassId : Integer;
begin
  qry := TERPQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT ClassID, AutoCreateRepairs FROM tblClass WHERE ClassID = :xClassID');

    if fiClassId = 0 then
      iClassId := fiDefaultClassID
    else
      iClassId := fiClassId;

    qry.Params.ParamByName('xClassID').AsInteger := iClassId;
    qry.Open;

    if qry.RecordCount > 0 then begin
      if qry.FieldByName('AutoCreateRepairs').AsString = 'T' then begin
        Result := true;
      end else begin
        Result := false;
      end;
    end else begin
      Result := false;
    end;
    qry.Close;
  finally
    // Free our used object.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function TEmployeeObj.CanAutoCreateSmartOrders: boolean;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT ClassID, AutoCreateSmartOrders FROM tblClass WHERE ClassID = :xClassID');
    qry.Params.ParamByName('xClassID').AsInteger := fiDefaultClassID;
    qry.Open;

    if qry.RecordCount > 0 then begin
      if qry.FieldByName('AutoCreateSmartOrders').AsString = 'T' then begin
        Result := true;
      end else begin
        Result := false;
      end;
    end else begin
      Result := false;
    end;
    qry.Close;
  finally
    // Free our used object.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

constructor TEmployeeObj.Create;
begin
  fCalendarTimeZones := TJsonObject.Create;
end;


procedure TEmployeeObj.ReporttoERPforduplicatePrefRecord(xEmployeeName:String; reccount:Integer);
begin
  SendEmailtoErp( 'Duplicate records found for Personal Perference',
                '    Company     :' + appenv.CompanyInfo.Companyname          +chr(13) +
                '    Server      :' +GetSharedMyDacConnection.Server  +chr(13) +
                '    Datase      :' +GetSharedMyDacConnection.Database+chr(13) +
                '    Version     :' + FileVersion.GetFileVersion() +chr(13) +
                '    Employee    :' +xEmployeeName + ' has ' + IntToStr(reccount) +' Personal Preference records. Deleting ' + IntToStr(reccount-1) +'.'  ,
                'sendemail');
end;

end.


