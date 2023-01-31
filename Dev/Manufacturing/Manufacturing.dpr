library Manufacturing;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  ShareMem,
  SysUtils,
  Classes,
  Forms,
  windows,
  BaseGUIDatamodule in '..\BaseClasses\Module\BaseGUIDatamodule.pas' {dtmGUI: TDataModule},
  ActionsObj in '..\General\Objects\CommonObjects\ActionsObj.pas',
  CommonLib in '..\General\Objects\CommonObjects\CommonLib.pas',
  CommonDbLib in '..\General\Objects\CommonObjects\CommonDbLib.pas',
  DecimalRounding in '..\General\Objects\CommonObjects\DecimalRounding.pas',
  DNMAccessManager in '..\General\Objects\DNMAccessManager.pas',
  AccessLevelObj in '..\General\Objects\AccessLevelObj.pas',
  EmployeeObj in '..\Employee\Objects\EmployeeObj.pas',
  tcTypes in '..\General\Objects\CommonObjects\tcTypes.pas',
  AppDatabase in '..\General\Objects\AppDatabase.pas',
  tcConst in '..\General\Objects\CommonObjects\tcConst.pas',
  tcClasses in '..\General\Objects\CommonObjects\tcClasses.pas',
  CompanyPrefObj in '..\Utilities\Objects\CompanyPrefObj.pas',
  DNMLib in '..\General\Objects\CommonObjects\DNMLib.pas',
  ReceiptPrinterObj in '..\POS\Objects\ReceiptPrinterObj.pas',
  GuiPrefsObj in '..\General\Objects\GuiPrefsObj.pas',
  DataTreeObj in '..\General\Objects\CommonObjects\DataTreeObj.pas',
  FastStrings in '..\General\Objects\CommonObjects\FastStrings.pas',
  FastStringFuncs in '..\General\Objects\CommonObjects\FastStringFuncs.pas',
  ParserObj in '..\General\Objects\CommonObjects\ParserObj.pas',
  DbPrimaryKeysObj in '..\General\Objects\CommonObjects\DbPrimaryKeysObj.pas',
  AnsiStringReplaceUnit in '..\General\Objects\CommonObjects\AnsiStringReplaceUnit.pas',
  AppEnvironment in '..\General\Objects\CommonObjects\AppEnvironment.pas',
  BranchObj in '..\General\Objects\BranchObj.pas',
  RegionalOptionsObj in '..\General\Objects\RegionalOptionsObj.pas',
  DefaultClassObj in '..\General\Objects\DefaultClassObj.pas',
  PayPreferencesObj in '..\Payroll\Objects\Pay\PayPreferencesObj.pas',
  busobjcompinfo in '..\Utilities\Objects\busobjcompinfo.pas',
  BusObjBase in '..\BaseClasses\Objects\BusObjBase.pas',
  UserLockObj in '..\General\Objects\CommonObjects\UserLockObj.pas',
  BusObjGeneral in '..\BusinessObjects\BusObjGeneral.pas',
  LogLib in '..\General\Objects\CommonObjects\LogLib.pas',
  BusObjAudit in '..\BusinessObjects\BusObjAudit.pas',
  ObjectFieldListObj in '..\General\Objects\CommonObjects\ObjectFieldListObj.pas',
  frmDelayMessageDlg in '..\General\InputForms\frmDelayMessageDlg.pas' {fmDelayMessageDlg},
  BusObjConst in '..\BusinessObjects\BusObjConst.pas',
  BusObjDataUtils in '..\BusinessObjects\BusObjDataUtils.pas',
  BusObjProductQty in '..\Inventory\Objects\BusObjProductQty.pas',
  BusObjStock in '..\Inventory\Objects\BusObjStock.pas',
  BusObjTaxCodes in '..\Accounts\Objects\BusObjTaxCodes.pas',
  tcDataUtils in '..\General\Objects\CommonObjects\tcDataUtils.pas',
  BusobjProductProperties in '..\Inventory\Objects\BusobjProductProperties.pas',
  BusObjUtils in '..\BusinessObjects\BusObjUtils.pas',
  BusObjClass in '..\Accounts\Objects\BusObjClass.pas',
  BusObjRap in '..\Raptor\Objects\BusObjRap.pas',
  BusObjSales in '..\Sales\Objects\BusObjSales.pas',
  BusObjTrans in '..\BaseClasses\Objects\BusObjTrans.pas',
  BusObjClient in '..\Clients\Common\Objects\BusObjClient.pas',
  BusObjCommon in '..\BusinessObjects\BusObjCommon.pas',
  ForeignExchangeObj in '..\Accounts\Objects\ForeignExchangeObj.pas',
  BusObjGLAccount in '..\Accounts\Objects\BusObjGLAccount.pas',
  BusObjProductQtyAllocation in '..\Inventory\Objects\BusObjProductQtyAllocation.pas',
  BusObjPrintDoc in '..\BusinessObjects\BusObjPrintDoc.pas',
  BusobjSaleBase in '..\BaseClasses\Objects\BusObjSaleBase.pas',
  ClientDiscountObj in '..\Clients\Customers\Objects\ClientDiscountObj.pas',
  ProductPriceObj in '..\Inventory\Objects\ProductPriceObj.pas',
  GlobalEventsObj in '..\General\Objects\CommonObjects\GlobalEventsObj.pas',
  BusobjCash in '..\Sales\Objects\BusobjCash.pas',
  BusObjBuildGroups in '..\BuildGroups\Objects\BusObjBuildGroups.pas',
  BusObjSmartOrder in '..\Purchases\Objects\BusObjSmartOrder.pas',
  GroupReorder in '..\Inventory\Objects\GroupReorder.pas',
  BusObjOrders in '..\BaseClasses\Objects\BusObjOrders.pas',
  BusObjStockAdjustment in '..\Inventory\Objects\BusObjStockAdjustment.pas',
  BusobjStockTransfer in '..\Inventory\Objects\BusobjStockTransfer.pas',
  AuditTrailObj in '..\General\Objects\AuditTrailObj.pas',
  MergeObj in '..\General\Objects\MergeObj.pas',
  TransactionsTable in '..\Accounts\Objects\TransactionsTable.pas',
  TableFunctionsObj in '..\Utilities\Objects\TableFunctionsObj.pas',
  DNMExceptions in '..\General\Objects\DNMExceptions.pas',
  StockCostSystemsObj in '..\Inventory\Objects\StockCostSystemsObj.pas',
  OptimiseInsertsObj in '..\General\Objects\OptimiseInsertsObj.pas',
  QueryManipulationObj in '..\General\Objects\QueryManipulationObj.pas',
  SysInfo in '..\General\Objects\CommonObjects\SysInfo.pas',
  AppContextObj in '..\General\Objects\CommonObjects\AppContextObj.pas',
  BaseFormForm in '..\BaseClasses\InputForms\BaseFormForm.pas' {BaseForm},
  MessageConst in '..\General\Objects\CommonObjects\MessageConst.pas',
  BaseInputForm in '..\BaseClasses\InputForms\BaseInputForm.pas' {BaseInputGUI},
  PrintTemplateObj in '..\TemplateReports\Objects\PrintTemplateObj.pas',
  ReportTemplates in '..\TemplateReports\Objects\ReportTemplates.pas',
  PersonalTabStops in '..\General\Objects\PersonalTabStops.pas',
  AccountingObj in '..\Accounts\Objects\AccountingObj.pas',
  templatesFrm in '..\TemplateReports\Objects\templatesFrm.pas' {templates},
  FormFactory in '..\General\Objects\FormFactory.pas',
  BaseListingForm in '..\BaseClasses\ListForms\BaseListingForm.pas' {BaseListingGUI},
  BusobjCustomFilter in '..\Utilities\Objects\BusobjCustomFilter.pas',
  frmSaveCustomFilter in '..\Utilities\InputForms\frmSaveCustomFilter.pas' {fmSaveCustomFilter},
  GlobalRefToIDToggleObj in '..\Utilities\Objects\GlobalRefToIDToggleObj.pas',
  ListSpeedHintGUI in '..\General\ListForms\ListSpeedHintGUI.pas' {frmQrySpeedHintGUI},
  BaseHintForm in '..\BaseClasses\InputForms\BaseHintForm.pas' {BaseHintGUI},
  datManufacturingAddin in 'Module\datManufacturingAddin.pas' {dtmManufacturingAddin: TDataModule},
  frmProcResourceList in 'ListForms\frmProcResourceList.pas' {fmProcResourceList},
  AddinPackageInfoObj in '..\General\Objects\CommonObjects\AddinPackageInfoObj.pas',
  ManufacturingCommon in 'ManufacturingCommon.pas',
  BusObjManufacturing in 'Objects\BusObjManufacturing.pas',
  BusObjNDSBase in '..\BaseClasses\Objects\BusObjNDSBase.pas',
  frmProcTreeEdit in 'InputForms\frmProcTreeEdit.pas' {fmProcTreeEdit},
  TreeFrame in 'InputForms\TreeFrame.pas' {frameTree: TFrame},
  ProductListExpressForm in '..\Inventory\ListForms\ProductListExpressForm.pas' {ProductListExpressGUI},
  ManufacturingDataUtils in 'Objects\ManufacturingDataUtils.pas',
  BusObjProcResource in 'Objects\BusObjProcResource.Pas',
  BusObjProcessStep in 'Objects\BusObjProcessStep.pas',
  frmProcResourceEdit in 'InputForms\frmProcResourceEdit.pas' {fmProcResourceEdit},
  BusObjProcessPart in 'Objects\BusObjProcessPart.pas',
  BusObjProcessPartNDS in 'Objects\BusObjProcessPartNDS.pas',
  frmProcessStepsEdit in 'InputForms\frmProcessStepsEdit.pas' {fmProcessStepsEdit},
  busobjPOS in '..\POS\Objects\busobjPOS.pas',
  busobjPOSOrders in '..\POS\Objects\busobjPOSOrders.pas',
  BusObjPOSale in '..\POS\Objects\busobjPOSale.pas',
  ClassExtenderObj in '..\BaseClasses\Objects\ClassExtenderObj.pas',
  GlobalClassFinder in '..\General\Objects\CommonObjects\GlobalClassFinder.pas',
  ManufactingPartsFormExtender in 'Objects\ManufactingPartsFormExtender.pas',
  BaseInputFormExtender in '..\BaseClasses\Objects\BaseInputFormExtender.pas',
  ManufacturingProductExtender in 'Objects\ManufacturingProductExtender.pas',
  BusObjLeads in '..\BusinessObjects\BusObjLeads.pas',
  BusObjMarketing in '..\BusinessObjects\BusObjMarketing.pas',
  ManufacturingSalesFormExtender in 'Objects\ManufacturingSalesFormExtender.pas',
  ManufacturingSalesExtender in 'Objects\ManufacturingSalesExtender.pas',
  BusObjAppointments in '..\BusinessObjects\BusObjAppointments.pas',
  BusObjRepServices in '..\BusinessObjects\BusObjRepServices.pas';

{$R *.res}

var
  ExitSave: Pointer;

procedure InitializeDllPackage(const ModuleInfo: TAddinPackageInfo;
                               const MainAppEnv: TAppEnvironment;
                               const MainApp: TApplication;
                               const MainScreen: TScreen);
begin
  { Assign main exe application variable to dll application variable }
  Application:= MainApp;
  { register class finder function for this dll }
  ClassFinder.AddFindModuleClassFunc(FindModuleClassFunc);

  //  AppEnv:= MainAppEnv;
  AppEnv.AppDb.Server:= MainAppEnv.AppDb.Server;
  AppEnv.AppDb.Database:= MainAppEnv.AppDb.Database;
  //AppEnv.AppDb.EmployeeID:= MainAppEnv.AppDb.EmployeeId;
  AppEnv.AppDb.UserName:= MainAppEnv.AppDb.UserName;
  AppEnv.AppDb.UserPass:= MainAppEnv.AppDb.UserPass;

  ModuleInfo.DataModGUI:= TdtmManufacturingAddin.Create(Application);
  Screen := MainScreen;
  IsLibrary:= true;
end;

procedure DllExit;
begin
  ExitProc := ExitSave;  // always restore old vector first

end;

exports
  InitializeDllPackage;

begin
  ExitSave := ExitProc;
  ExitProc := @DllExit;
end.

