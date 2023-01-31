unit datManufacturingAddin;
{  ActionImageIndexes: (366,361,355,356,365,315,362,82,363,296,281)}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ImgList, Menus, AdvMenus,
  DNMAction, BaseGUIDatamodule, ActionsObj, frmReportSelectorFrm;

type
  TdtmManufacturingAddinClass = class of TdtmManufacturingAddin;

  TdtmManufacturingAddin = class(TdtmGUI)
    MainMenu: TAdvMainMenu;
    Manufacturing1: TMenuItem;
    ActionList: TActionList;
    actResourceList: TDNMAction;
    ResourceList1: TMenuItem;
    actCapacityPlanning: TDNMAction;
    ResourceJobAllocation1: TMenuItem;
    ResourceUnavailability1: TMenuItem;
    actProcessSteps: TDNMAction;
    ProcessSteps1: TMenuItem;
    actProcessJobListing: TDNMAction;
    ProcessJobList1: TMenuItem;
    actManufacturingReports: TDNMAction;
    actProcPreferences: TDNMAction;
    Preferances1: TMenuItem;
    actProductionPartsList: TDNMAction;
    ProductionPartsList1: TMenuItem;
    actResource: TDNMAction;
    actResourcesimple: TDNMAction;
    actOrdersFromStock: TDNMAction;
    actProductionOrders: TDNMAction;
    OrdersFromStock1: TMenuItem;
    actProcJobListing: TDNMAction;
    actProcProductionPartsList: TDNMAction;
    actManufactureProductList: TDNMAction;
    ManufactureProductList1: TMenuItem;
    actBarCodeManufacturing: TDNMAction;
    BarcodeManufacturing1: TMenuItem;
    actProductionJobStatusDetails: TDNMAction;
    actProductionWorkordertimesheets: TDNMAction;
    Resource2: TMenuItem;
    JobTimeSheets1: TMenuItem;
    ProductExpressList1: TMenuItem;
    actManufactureSubProductListGUI: TDNMAction;
    ManufactureSubProductList1: TMenuItem;
    actWastagereport: TDNMAction;
    actOrderStatus: TDNMAction;
    actprocessstepList: TDNMAction;
    actBOMSalesList: TDNMAction;
    actProductionjobstatusdetailsList: TDNMAction;
    actCapacityPlanningonGanttchart: TDNMAction;
    actRosterWithManProcess: TDNMAction;
    BuildProfitability1: TMenuItem;
    actStowAwayList: TDNMAction;
    StowAwayList1: TMenuItem;
    actRosterBreakList: TDNMAction;
    actEmployeeJobStatus: TDNMAction;
    actUnallocatedBatchSalesList: TDNMAction;
    actBOMJobs: TDNMAction;
    actWorkOrdertimeSheet: TDNMAction;
    actImportSolidWorksBOM: TDNMAction;
    actEmpResProcRoster: TDNMAction;
    actEmpResProcRosternSchedule: TDNMAction;
    actBOMSchedulewhenReadytoSchedule: TDNMAction;
    actBOMWorkOrdersEmployees: TDNMAction;
    actBOMWorkOrdersUnscheduled: TDNMAction;
    actBOMWorkOrdersExtraDetails: TDNMAction;
    actBOMWorkOrdersProcess: TDNMAction;
    actBOMWorkOrdersProduct: TDNMAction;
    actBOMWorkOrdersSalesOrder: TDNMAction;
    actBOMWorkOrdersSummary: TDNMAction;
    actWorkOrdersByEmp: TDNMAction;
    actWorkOrdersByRes: TDNMAction;
    actWorkOrdersByDate: TDNMAction;
    actWorkOrders: TDNMAction;
    actWorkOrdersBySale: TDNMAction;
    actSimpleWorkOrder: TDNMAction;
    actWorkOrderTimesheets: TDNMAction;
    actEmpBOMRosternScheduleConfig: TDNMAction;
    actBOMProductList: TDNMAction;
    actBOMSetup: TDNMAction;
    actProcProgress: TDNMAction;
    WorkOrderTimesheets1: TMenuItem;
    actBOMProgressbuilds: TDNMAction;
    ProgressBuilds1: TMenuItem;
    actBOMSalesOrders: TDNMAction;
    actBOMProductsList: TDNMAction;
    actProductionTonnesDetails: TDNMAction;
    actProductionTonnes: TDNMAction;
    actBOMSalesDEtails: TDNMAction;
    BOMSalesSubProducts1: TMenuItem;
    actBOMSalesSubProductsList: TDNMAction;
    actBOMSalesSubProductsDetailList: TDNMAction;
    actProductionOrderReport: TDNMAction;
    actProductionOrderReportNew: TDNMAction;
    actBOMSubAssemblyCheck: TDNMAction;
    actSubBom: TDNMAction;
    SubBOMs1: TMenuItem;
    actBOMDailyProcessSales: TDNMAction;

    procedure actManufacturingReportsExecute(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure actProcPreferencesExecute(Sender: TObject);
    procedure actImportSolidWorksBOMExecute(Sender: TObject);
    procedure actBOMSalesDEtailsExecute(Sender: TObject);
  private
  Protected
    procedure DoAddReports(Const ReportSelector: TfrmReportSelectorGUI); Override;
  public
    Procedure AssignImageList;override;
    constructor Create(AOwner: TComponent); override;
  published
    function GetItem(const ActionName: string): TActionHelperItem;
  end;

var
  dtmManufacturingAddin: TdtmManufacturingAddin;

implementation

uses
  FastFuncs, CommonLib, GlobalEventsObj,
  Preferences, AddinPackageInfoObj, tcConst, dmMainGUI, PreferenceLib,
  MainSwitchFrm2, SolidWorksLib, BusObjProcPrefs, AppEnvironment;

{$R *.dfm}
{$M+}        {don't delete!}

{ TdtmManufacturingAddin }

procedure TdtmManufacturingAddin.DataModuleDestroy(Sender: TObject);
begin
  GlobalEvents.DeregisterHandlers(self);
  inherited;
end;

procedure TdtmManufacturingAddin.AssignImageList;
begin
  inherited;
  //ActionList.Images := ImageList;
end;

constructor TdtmManufacturingAddin.Create(AOwner: TComponent);
begin
  
  inherited;

end;

function TdtmManufacturingAddin.GetItem(
  const ActionName: string): TActionHelperItem;
var
  I: integer;
begin
  Result := nil;
  if ActionHelper.Count > 0 then for I := 0 to ActionHelper.ActionCount - 1 do
      if Sysutils.SameText(ActionHelper.Items[I].ActionName, ActionName) then begin
        Result := ActionHelper.Items[I];
        Break;
      end;
end;

procedure TdtmManufacturingAddin.actBOMSalesDEtailsExecute(Sender: TObject);
var
  fsClassname:String;
begin
  inherited;
  fsClassname :=AppEnv.Employee.BOMSalesList;
  if fsClassname = '' then fsClassname:= TDnMAction(Sender).ClassExecute;
  ShowGUI(Sender,fsClassname, true);
end;

procedure TdtmManufacturingAddin.actImportSolidWorksBOMExecute(Sender: TObject);
var
  OpenDialog: TOpenDialog;
  ProductId: integer;
begin
  inherited;
  OpenDialog := TOpenDialog.Create(nil);
  try
    OpenDialog.Filter := 'SolidWorks BOM (*.xml)|*.xml|All Files (*.*)|*.*';
    if OpenDialog.Execute then begin
      TSolidWorksImport.ImportSolidWorksBOM(OpenDialog.FileName, ProductId);
    end;
  finally
    OpenDialog.Free;
  end;
end;

procedure TdtmManufacturingAddin.actManufacturingReportsExecute(
  Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_MANUFACTURING));
end;

procedure TdtmManufacturingAddin.DoAddReports(Const ReportSelector: TfrmReportSelectorGUI);
begin
  if Assigned(ReportSelector) then begin
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'BOM Product List', 'TBOMProductsListGUI', 0);
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'BOM Product Status', 'TBOMOrderStatusGUI', 0);

    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'BOM Sales Sub Products (Details)', 'TBOMSalesSubProductsDetailListGUI', 0);
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'BOM Sales Sub Products (Summary)', 'TBOMSalesSubProductsListGUI', 0);

    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'BOM Sales List', 'TBOMSalesListGUI', 0);
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'BOM Sales Orders', 'TBOMSalesOrdersGUI', 0);
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Employee Job Status', 'TEmployeeJobStatusGUI', 0);
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Job Time Sheets', 'TJobtimeSheetsGUI', 0);
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Manufacture Product List', 'TManufactureProductListGUI', 0);
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Manufacture Sales List', 'TBOMSalesListGUI', 0);
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Manufacture Sub Product List', 'TManufactureSubProductListGUI', 0);
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Orders From Stock', 'TOrdersFromStockGUI', 0);
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Process Step in BOM / Orders', 'TProcessStepsInBOMListGUI', 0);
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Production Job Details', 'TProductionjobstatusdetailsList', 0);
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Production Job Status', 'TProductionJobStatusGUI', 0);
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Production Order List', 'TProductionOrdersGUI', 0);
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Production Order Report', 'TProductionOrderMaterialListGUI', 0);
    //ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Production Order Report', 'TProductionOrderListGUI', 0);
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Production Parts Status', 'TProductionPartStatusGUI', 0);
    if ProcPrefs.UseFld7AsSteelWeight then begin
      ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Production Tonnes Report - Main Product', 'TProductionTonnesGUI', 0);
      ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Production Tonnes Report - With Raw Materials', 'TProductionTonnesDetailsGUI', 0);
    end;
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Resource List', 'TfmProcResourceList', 0);
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Resource Unavailability', 'TResourceUnavailabilityGUI', 0);
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Sub BOMs', 'TSubBomGUI', 0);

    //ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Orders From Stock', 'TOrdersFromStockGUI', 0);
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Unallocated Batch Sales', 'TUnallocatedBatchSalesListGUI', 0);
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Work Order (Groups)', 'TWorkOrdersByEmpGUI', 0);
    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Work Order (Timesheet)', 'TWorkOrderTimesGUI', 0);


//    ReportSelector.Add(REPORT_GROUP_MANUFACTURING, 'Stow Away Slip List', 'TfmProcStowAwaySlipList', 0);
  end;
end;

procedure TdtmManufacturingAddin.actProcPreferencesExecute(  Sender: TObject);
begin
  inherited;
  OpenPrefform('Manufacturing' ,  '', 0 , False );
end;

initialization
  if Assigned(AddinInfo) then AddinInfo.GuiDataModuleClass:= TdtmManufacturingAddin;
end.
