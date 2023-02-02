unit utVS1Const;

interface

uses StSConst;

Const
    //VS1_Admin_DB = 'VS1_License';//'VS1_Cloud';
    VS1_Admin_DB_Production = 'vs1_Production_license';
    VS1_Admin_DB_Sandbox    = 'vs1_sandbox_license';
    VS1_Admin_DB_TEMP = 'VS1_License'; // delete this once license database is changed

    ERP_VS1CLOUD_DEFAULT_USERFirstName = 'VS1_Temp_User';
    ERP_VS1CLOUD_DEFAULT_USERLastName  = '.';

    ERP_VS1CLOUD_ADMIN_USERFirstName = 'Admin';
    ERP_VS1CLOUD_ADMIN_USERLastName  = '.';

    ERP_VS1CLOUD_DEFAULT_USER          = 'VS1_Temp_User';
    ERP_VS1CLOUD_DEFAULT_TOKEN         = 'Dpjhge8rnvl1j&9';

    VS1_HTTP_Success_Code           = 200;  VS1_HTTP_Success_STRCode           = '200';
    VS1_HTTP_Progress_Code          = 300;  VS1_HTTP_Progress_STRCode          = '300';
    VS1_HTTP_Failed_Code            = 401;  VS1_HTTP_Failed_STRCode            = '401';
    VS1_HTTP_DupicateErr_Code       = 403;  VS1_HTTP_DupicateErr_STRCode       = '403';

    VS1_TAG_ID                      = 'Id';
    VS1_TAG_ClientUserID            = 'ClientUSerID';
    VS1_TAG_ServerName              = 'ServerName';
    VS1_TAG_RegionName              = 'RegionName';
    VS1_TAG_DatabaseName            = 'DatabaseName';
    VS1_TAG_Databases               = 'Databases';
    VS1_TAG_BackupList              = 'BackupList'; // Wang
    VS1_TAG_PNLLayout               = 'PNLLayout';  // Wang
    VS1_TAG_PNLGroupList            = 'PNLGroupList';  // Wang
    VS1_TAG_DatabaseNameToChange    = 'DatabasenameToChange';
    VS1_TAG_NewPassword             = 'NewPassword';
    VS1_TAG_APIPort                 = 'APIPort';
    VS1_TAG_HTTPS                   = 'IsHttps';
    VS1_TAG_SampleDatabaseName      = 'Sampledatabasename';
    VS1_TAG_CustomerName            = 'CustomerName';
    VS1_TAG_VS1UserName             = 'VS1UserName';
    VS1_TAG_VS1Password             = 'VS1Password';
    VS1_TAG_VS1Database             = 'VS1Database';
    VS1_TAG_VS1AdminUserName        = 'VS1AdminUserName';
    VS1_TAG_ClientLicense           = 'ClientLicense';
    VS1_TAG_LicenseLevel            = 'LicenseLevel';
    VS1_TAG_LicenseLevelDesc        = 'LicenseLevelDesc';
    VS1_TAG_ExtraModules            = 'ExtraModules';
    VS1_TAG_ExtraModule             = 'ExtraModule';
    VS1_TAG_ClientName              = 'ClientName';
    VS1_TAG_CloudUserName           = 'CloudUserName';
(*    VS1_TAG_ERPDBServerName         = 'ERPDBServerName';
    VS1_TAG_ERPDBDatabaseName       = 'ERPDBDatabaseName';
    VS1_TAG_ERPDBPortnumber         = 'ERPDBPortnumber';
    VS1_TAG_ERPDBIsPortHttps        = 'ERPDBIsPortHttps';*)
    VS1_TAG_PhoneNumber             = 'Phone';
    VS1_TAG_CloudPassword           = 'CloudPassword';
    VS1_TAG_CloudSampleDBUserName   = 'CloudSampleDBUserName';
    VS1_TAG_CloudSampleDBPassword   = 'CloudSampleDBPassword';
    VS1_TAG_FirstName               = 'FirstName';
    VS1_TAG_Middlename              = 'Middlename';
    VS1_TAG_LastName                = 'LastName';
    VS1_TAG_EmployeeName            = 'EmployeeName';
    VS1_TAG_CreditCardType          = 'CreditCardType';
    VS1_TAG_CreditCardCardHolderName= 'CreditCardCardHolderName';
    VS1_TAG_CreditCardNumber        = 'CreditCardNumber';
    VS1_TAG_CreditCardNotes         = 'CreditCardNotes';
    VS1_TAG_CreditCardCVC           = 'CreditCardCVC';
    VS1_TAG_CreditCardExpirymonth   = 'CreditCardExpirymonth';
    VS1_TAG_CreditCardExpiryYear    = 'CreditCardExpiryYear';
    VS1_TAG_Modules                 = 'Modules';
    VS1_TAG_ModuleActive            = 'ModuleActive';
    VS1_TAG_ModuleName              = 'ModuleName';
    VS1_TAG_ModuleID                = 'ModuleID';
    VS1_TAG_ModuleQuantity          = 'Quantity';
    VS1_TAG_CreateNewDB             = 'CreateNewDB'              ;
    VS1_TAG_LicenseRenewDurationType= 'LicenseRenewDurationType';
    VS1_TAG_LicenseExtensionDesc    = 'LicenseExtensionDesc';
    VS1_TAG_AdjustmentExtension     = 'AdjustmentExtension';
    VS1_TAG_LicenseRenewDuration    = 'LicenseRenewDuration';
    VS1_TAG_MakingExtraDB           = 'MakingExtraDB'            ;
    VS1_TAG_IsSampleDB              = 'IsSampleDB'               ;
    VS1_TAG_Price                   = 'Price';
    VS1_TAG_DiscountedPrice         = 'DiscountedPrice';
    VS1_TAG_DiscountedAmt           = 'DiscountedAmt';
    VS1_TAG_Renew_Price             = 'RenewPrice';
    VS1_TAG_Renew_DiscountedPrice   = 'RenewDiscountedPrice';
    VS1_TAG_Renew_DiscountedAmt     = 'RenewDiscountedAmt';
    VS1_TAG_DiscountDesc            = 'DiscountDesc';
    VS1_TAG_Renew_DiscountDesc      = 'RenewDiscountDesc';
    VS1_TAG_LinePrice               = 'LinePrice';
    VS1_TAG_LineDiscountedPrice     = 'LineDiscountedPrice';
    VS1_TAG_ERPLoginDetails         = 'ERPLoginDetails';
    VS1_TAG_LogonName               = 'LogonName';
    VS1_TAG_LogonPassword           = 'LogonPassword';
    VS1_TAG_VS1User                 = 'IsVS1User';
    VS1_TAG_TotalPrice              = 'TotaleginPrice';
    VS1_TAG_PayMethod               = 'PayMethod';
    VS1_TAG_Paymentamount           = 'Paymentamount';
    VS1_TAG_LicenseFrom             = 'LicenseFrom';
    VS1_TAG_LicenseUntil            = 'LicenseUntil';
    VS1_TAG_Logon_name              = 'Logon_name';
    VS1_TAG_EmployeeId              = 'EmployeeId';
    VS1_TAG_TabGroup                = 'TabGroup';
    VS1_TAG_FormID                  = 'FormID';
    VS1_TAG_FormName                = 'FormName';
    VS1_TAG_Description             = 'Description';
    VS1_TAG_IsForm                  = 'IsForm';
    VS1_TAG_AccessLevels            = 'AccessLevels';
    VS1_TAG_SkinsGroup              = 'SkinsGroup';
    //VS1_TAG_AccessLevel             = 'AccessLevel';
    VS1_TAG_AccessLevelName         = 'AccessLevelName';
    VS1_TAG_CurrencySymbol          = 'CurrencySymbol';
    VS1_TAG_WholeCurrencyName       = 'WholeCurrencyName';
    VS1_TAG_DecimalCurrencyName     = 'DecimalCurrencyName';
    VS1_TAG_DecimalPlaces           = 'DecimalPlaces';
    VS1_TAG_ShortDateformat         = 'ShortDateformat';
    VS1_TAG_DateSeparator           = 'DateSeparator';
    VS1_TAG_EmployeeDetails         = 'EmployeeDetails';
    VS1_TAG_DateStarted             = 'DateStarted';
    VS1_TAG_LicenseExtensionTo      = 'LicenseExtensionTo';
    VS1_TAG_DOB                     = 'DOB';
    VS1_TAG_Sex                     = 'Sex';
    VS1_TAG_Country                 = 'Country';
    VS1_TAG_EMail                   = 'Email';
    VS1_TAG_CompanyEMail            = 'CompanyEmail';
    VS1_TAG_EmailsFromEmployeeAddress= 'EmailsFromEmployeeAddress';
    VS1_TAG_VS1EmployeeId           = 'VS1EmployeeId';
    VS1_TAG_IsVS1Database           = 'IsVS1Database';
    VS1_TAG_Access                  = 'Access';
    VS1_TAG_VS1EmployeeAccessList   = 'VS1EmployeeAccessList';
    VS1_TAG_PriceDescription        = 'PriceDescription';
    VS1_TAG_TransTableLastUpdated   = 'TransactionTableLastUpdated';
    VS1_TAG_ClientDetails           = 'ClientDetails';
    VS1_TAG_CompanyPreferenceList   = 'CompanyPreferenceList';
    VS1_TAG_DashboardOption         = 'DashboardOption';
    VS1_TAG_LoginDefault            = 'LoginDefault';

    VS1_TAG_type                    = 'type';
    VS1_TAG_Fields                  = 'fields';
    VS1_TAG_DashboardError          = 'DashboardError';
    VS1_TAG_Dashboard_AP_report     = 'AP_Report';
    VS1_TAG_Dashboard_PnL_report    = 'PnL_Report';
    VS1_TAG_Dashboard_PnL_report2   = 'PnL_Period_Report';
    VS1_TAG_Dashboard_SalesList     = 'SalesList';
    VS1_TAG_Dashboard_SalesPerEmp   = 'SalesPerEmp';
    VS1_TAG_Dashboard_Summary       = 'Summary';
    VS1_TAG_Dashboard_Employee      = 'Employee';
    VS1_TAG_Dashboard_EmpPicture    = 'EmpPicture';
    VS1_TAG_Dashboard_EmpAccess     = 'EmpAccess';
    VS1_TAG_Dashboard_LastSumDate   = 'LastSumMaryUpdateOn';
    VS1_TAG_Dashboard_Summary2      = 'Summary2';
    VS1_TAG_AppointID               = 'AppointID';
    VS1_TAG_AppointIDs              = 'AppointIDs';
    VS1_TAG_InvoiceID               = 'InvoiceID';
    VS1_TAG_InvoiceIDs              = 'InvoiceIDs';
    VS1_TAG_Msg                     = 'Message';
    VS1_TAG_Msgs                    = 'Messages';
    VS1_TAG_TimesheetID             = 'TimesheetID';
    VS1_TAG_TimesheetIDs            = 'TimesheetIDs';
    VS1_TAG_ResPonse                = 'ResPonse';

    //VS1_TAG_Error                   = 'Error';


    VS1_Module_CloudAccounts        = 'CloudAccounts';
    VS1_Module_CloudContacts        = 'CloudContacts';
    VS1_Module_CloudDashboard       = 'CloudDashboard';
    VS1_Module_CloudExpenseClaims   = 'CloudExpenseClaims';
    VS1_Module_CloudFixedAssets     = 'CloudFixedAssets';
    VS1_Module_CloudPayments        = 'CloudPayments';
    VS1_Module_CloudPurchases       = 'CloudPurchases';
    VS1_Module_CloudInventory       = 'CloudInventory';
    VS1_Module_CloudManufacturing   = 'CloudManufacturing';
    VS1_Module_CloudMain            = 'CloudMain';
    VS1_Module_CloudReports         = 'CloudReports';
    VS1_Module_CloudSales           = 'CloudSales';
    VS1_Module_CloudSettings        = 'CloudSettings';
    VS1_Module_CloudShipping        = 'CloudShipping';
    VS1_Module_CloudStockTake       = 'CloudStockTake';
    VS1_Module_CloudStockTransfer   = 'CloudStockTransfer';
    VS1_Module_CloudWalkThroughSheet= 'CloudWalkThroughSheet';
    VS1_TAG_EnableStS               = 'EnableStS';

    VS1_TAG_Class_User              = 'TUser';

    VS1_DB_Status_Used              = 'Used';
    VS1_DB_Status_Available         = 'Available';

    VS1_Class_Employee              = 'TEmployee';
    VS1_Class_User                  = 'TUser';
    VS1_Class_EmployeeFormAccess    = 'TEmployeeFormAccess';
    VS1_Class_EmployeeFormAccessDt  = 'TEmployeeFormAccessDetail';
    VS1_Class_RegionalOptions       = 'TRegionalOptions';
    VS1_Class_TERPForm              = 'TERPForm';

    VS1_TAG_Invoice                 = 'Invoice';
    VS1_TAG_CustPayments            = 'CustomerPayment';
    VS1_TAG_CustPrePayments         = 'CustomerPre-Payment';
    VS1_TAG_ERPVersion              = 'ERPVersion';


    VS1_Cloud_Task          = 'VS1_Cloud_Task';

    TASK_VS1_NewRego          = 'VS1_NewRego';
    TASK_Vs1_Logon            = 'Vs1_Logon';
    TASK_VS1_SequenceList     = 'VS1_SequenceList';
    TASK_VS1_NextTransID      = 'VS1_NextTransID';
    TASK_VS1_Customize        = 'VS1_Customize';
    TASK_VS1_GetCustomize     = 'VS1_GetCustomize';
    TASK_VS1_ClosingDates     = 'VS1_ClosingDates';
    TASK_VS1_GetClosingDates  = 'VS1_GetClosingDates';
    TASK_VS1_NewUser          = 'VS1_NewUser';
    TASK_VS1_SetAccountant    = 'VS1_SetAccountant';
    TASK_VS1_ChangeDatabase   = 'VS1_ChangeDatabase';
    TASK_VS1_DbConnectTest    = 'VS1_DbConnectTest';
    TASK_VS1_AddModules       = 'VS1_AddModules';
    TASK_VS1_Renew            = 'VS1_Renew';
    TASK_VS1_SysInfo          = 'VS1_SysInfo';
    TASK_VS1_Dashboard        = 'VS1_Dashboard';
    TASK_VS1_Test             = 'Vs1_Test';
    TASK_VS1_EmployeeAccess   = 'VS1_EmployeeAccess';
    TASK_VS1_InitNewDatabase  = 'VS1_InitNewDatabase';
    TASK_VS1_BatchUpdate      = 'VS1_BatchUpdate';
    TASK_VS1_InvoiceAppt      = 'VS1_InvoiceAppt';
    TASK_VS1_InvoiceTimesheet = 'VS1_InvoiceTimesheet';
    TASK_VS1_ChangePassword   = 'VS1_ChangePassword';
    TASK_VS1_UpdateCompPref   = 'VS1_UpdateCompPref';
    TASK_VS1_RepeatAppointment= 'VS1_RepeatAppointment';
    TASK_VS1_RepeatTrans      = 'VS1_RepeatTrans';
    TASK_VS1_DeleteRepeated   = 'VS1_DeleteRepeated';   // Wang
    TASK_VS1_DeleteAllAppts   = 'VS1_DeleteAllAppts';
    TASK_VS1_DatabaseBackup   = 'VS1_DatabaseBackup';   // Wang
    TASK_VS1_BackupList       = 'VS1_BackupList';       // Wang
    TASK_VS1_DatabaseRestore  = 'VS1_DatabaseRestore';  // Wang
    TASK_VS1_PNLGetLayout     = 'VS1_PNLGetLayout';     // Wang
    TASK_VS1_PNLMoveAccount   = 'VS1_PNLMoveAccount';   // Wang
    TASK_VS1_PNLAddGroup      = 'VS1_PNLAddGroup';      // Wang
    TASK_VS1_PNLDeleteGroup   = 'VS1_PNLDeleteGroup';   // Wang
    TASK_VS1_PNLRenameGroup   = 'VS1_PNLRenameGroup';   // Wang
    TASK_VS1_PNLGetGroups     = 'VS1_PNLGetGroups';     // Wang
    TASK_VS1_GetDatabases     = 'VS1_GetDatabases';     // Wang

    {repeat tags}
    VS1_TAG_Repeat_Period       = 'Repeat_Period';
    VS1_TAG_Repeat_BaseDate     = 'Repeat_BaseDate';
    VS1_TAG_Repeat_FinalDate    = 'Repeat_FinalDate';
    VS1_TAG_Repeat_Saturday     = 'Repeat_Saturday';
    VS1_TAG_Repeat_Sunday       = 'Repeat_sunday';
    VS1_TAG_Repeat_Monday       = 'Repeat_Monday';
    VS1_TAG_Repeat_Tuesday      = 'Repeat_Tuesday';
    VS1_TAG_Repeat_Wednesday    = 'Repeat_Wednesday';
    VS1_TAG_Repeat_Thursday     = 'Repeat_Thursday';
    VS1_TAG_Repeat_Friday       = 'Repeat_Friday';
    VS1_TAG_Repeat_Holiday      = 'Repeat_holiday';
    VS1_TAG_Repeat_Weekday      = 'Repeat_Weekday';
    VS1_TAG_Repeat_MonthoffSet  = 'Repeat_MonthoffSet';
    VS1_TAG_Repeat_Frequency    = 'Repeat_Frequency';
    VS1_TAG_Repeat_Dates        = 'Repeat_Dates';
    VS1_TAG_Repeat_TransID      = 'TransID';
    VS1_TAG_Repeat_TransType    = 'TransType';
    VS1_TAG_Dates               = 'Dates';


    VS1_Admin_Email   = 'admin@vs1cloud.com';
    VS1_DEFAULT_CLASS = 'Head Office';

    VS1_STRVALUE_TO_IGNORE = '~';

    VS1_Module_Accounts_Payable_Reports     = 'Accounts Payable Reports';
    VS1_Module_Accounts_Receivable_Report   = 'Accounts Receivable Report';
    VS1_Module_Add_Extra_User               = 'Add Extra User';
    VS1_Module_Appointment_Scheduling       = 'Appointment Scheduling';
    VS1_Module_Back_Ordering                = 'Back Ordering';
    VS1_Module_Balance_Sheets               = 'Balance Sheets';
    VS1_Module_Batch_Serial_No_Tracking     = 'Batch / Serial No. Tracking';
    VS1_Module_Bills                        = 'Bills';
    VS1_Module_Bin_Tracking                 = 'Bin Tracking';
    VS1_Module_Departments                  = 'Departments';
    VS1_Module_Expense_Claims               = 'Expense Claims';
    VS1_Module_FX_Currency                  = 'FX Currency';
    VS1_Module_Inventory_Tracking           = 'Inventory Tracking';
    VS1_Module_Invoices                     = 'Invoices';
    VS1_Module_Jobs_construction            = 'Jobs/construction';
    VS1_Module_Journals                     = 'Journals';
    VS1_Module_Link_To_TrueERP              = 'Link To TrueERP';
    VS1_Module_Manufacturing                = 'Manufacturing';
    VS1_Module_Matrix                       = 'Matrix';
    VS1_Module_Payemnts                     = 'Payemnts';
    VS1_Module_Payroll_Integration          = 'Payroll Integration';
    VS1_Module_Payroll_Unlimited_Employees  = 'Payroll Unlimited Employees';
    VS1_Module_PO_Non_Inventory             = 'PO Non-Inventory';
    VS1_Module_POS                          = 'POS';
    VS1_Module_Profit_Loss_Reports          = 'Profit & Loss Reports';
    VS1_Module_Quotes                       = 'Quotes';
    VS1_Module_Reports_Dashboard            = 'Reports Dashboard';
    VS1_Module_Seed_To_Sale                 = 'Seed To Sale';
    VS1_Module_Shipping                     = 'Shipping';
    VS1_Module_Statements                   = 'Statements';
    VS1_Module_Stock_Adjustments            = 'Stock Adjustments';
    VS1_Module_Time_Sheets                  = 'Time Sheets';
    VS1_Module_Use_Foreign_Currency         = 'Use Foreign Currency';
    VS1_Module_Website_Integration          = 'Website Integration';
    VS1_Module_WMS                          = 'WMS';
    VS1_Module_Paychex_Payroll              = 'Paychex Payroll Integration';
    VS1_Module_ADP_Payroll                  = 'ADP Payroll Integration';
    VS1_Module_Fixed_Assets                 = 'Fixed Assets';

    //VS1_MODULE_Add_Extra_User                 = 'Add Extra User';
    //VS1_MODULE_Expense_Claims_Receipt_Claiming= 'Expense Claims / Receipt Claiming';
    //VS1_MODULE_Manufacturing                  = 'Manufacturing';
    //VS1_MODULE_Matrix                         = 'Matrix';
    //VS1_MODULE_Payroll_Integration            = 'Payroll Integration';
    //VS1_MODULE_POS                            = 'POS';
    //VS1_MODULE_Seed_To_Sale                   = STS_CAPTION;
    //VS1_MODULE_Shipping                       = 'Shipping';
    //VS1_MODULE_Use_Foreign_Currency           = 'Use Foreign Currency';
    //VS1_MODULE_WMS                            = 'WMS';

    Function VS1_Admin_DBs:String;
implementation

uses Sysutils;

  Function VS1_Admin_DBs:String;
  begin
    result := Quotedstr(VS1_Admin_DB_Sandbox)+','+Quotedstr(VS1_Admin_DB_Production )+','+Quotedstr(VS1_Admin_DB_TEMP);
  end;
end.



