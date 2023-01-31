inherited dtmManufacturingAddin: TdtmManufacturingAddin
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Left = 362
  Top = 224
  Height = 121
  Width = 176
  object MainMenu: TAdvMainMenu
    Version = '2.5.3.4'
    Left = 89
    Top = 16
    object Manufacturing1: TMenuItem
      Caption = 'Manufacturing'
      GroupIndex = 75
      ImageIndex = 79
      OnClick = AnyActionExecute
      object BarcodeManufacturing1: TMenuItem
        Action = actBarCodeManufacturing
        GroupIndex = 110
      end
      object ResourceJobAllocation1: TMenuItem
        Action = actCapacityPlanning
        GroupIndex = 110
      end
      object JobTimeSheets1: TMenuItem
        Action = actProductionJobStatusDetails
        GroupIndex = 110
      end
      object ManufactureProductList1: TMenuItem
        Action = actManufactureProductList
        GroupIndex = 110
      end
      object ManufactureSubProductList1: TMenuItem
        Action = actManufactureSubProductListGUI
        GroupIndex = 110
      end
      object OrdersFromStock1: TMenuItem
        Action = actOrdersFromStock
        GroupIndex = 110
      end
      object Preferances1: TMenuItem
        Action = actProcPreferences
        GroupIndex = 110
      end
      object ProcessSteps1: TMenuItem
        Action = actProcessSteps
        GroupIndex = 110
      end
      object ProcessJobList1: TMenuItem
        Action = actProcessJobListing
        GroupIndex = 110
      end
      object ProductionPartsList1: TMenuItem
        Action = actProductionPartsList
        GroupIndex = 110
      end
      object ProductExpressList1: TMenuItem
        Action = dtmMainGUI.actInventProductsProductsExpressList
        GroupIndex = 110
      end
      object Resource2: TMenuItem
        Action = actResource
        GroupIndex = 110
      end
      object ResourceList1: TMenuItem
        Action = actResourceList
        GroupIndex = 110
      end
      object ResourceUnavailability1: TMenuItem
        Action = actResourceUnAvailability
        GroupIndex = 110
      end
      object BuildProfitability1: TMenuItem
        Action = actWastagereport
        GroupIndex = 110
      end
      object StowAwayList1: TMenuItem
        Action = actStowAwayList
        GroupIndex = 110
      end
      object WorkOrderTimesheets1: TMenuItem
        Action = actWorkOrderTimesheets
        GroupIndex = 110
      end
      object ProgressBuilds1: TMenuItem
        Action = actBOMProgressbuilds
        GroupIndex = 110
      end
      object BOMSalesSubProducts1: TMenuItem
        Action = actBOMSubAssemblyCheck
        GroupIndex = 110
      end
      object SubBOMs1: TMenuItem
        Action = actSubBom
        GroupIndex = 110
      end
    end
  end
  object ActionList: TActionList
    Left = 24
    Top = 16
    object actResource: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Resource'
      ImageIndex = 174
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmProcResourceEdit'
      DefaultPage = 'Manufacturing'
      Description = 'Manufacturing Resource'
      buttoncolor = clWhite
    end
    object actResourcesimple: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Resource'
      ImageIndex = 174
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmProcResourceSimpleEdit'
      DefaultPage = 'Manufacturing'
      Description = 'Manufacturing Resource Simple'
      buttoncolor = clWhite
    end
    object actResourceList: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Resource List'
      ImageIndex = 332
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmProcResourceList'
      DefaultPage = 'Manufacturing'
      Description = 'Manufacturing Resource List'
      buttoncolor = clWhite
    end
    object actWorkOrdertimeSheet: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Work Order TimeSheet'
      ImageIndex = 662
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmWorkOrdertimeSheet'
      DefaultPage = 'Manufacturing'
      Description = 'Manufacturing Resource'
      buttoncolor = clWhite
    end
    object actResourceUnAvailability: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Resource Unavailability'
      ImageIndex = 338
      OnExecute = AnyActionExecute
      ClassExecute = 'TResourceUnavailabilityGUI'
      buttoncolor = clWhite
    end
    object actProcessSteps: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Process Steps'
      ImageIndex = 117
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmProcessStep'
      buttoncolor = clWhite
    end
    object actCapacityPlanning: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Capacity Planning'
      ImageIndex = 52
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmProcCapacityPlanning'
      buttoncolor = clWhite
    end
    object actProcessJobListing: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Production Job Status'
      ImageIndex = 139
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductionJobStatusGUI'
      buttoncolor = clWhite
    end
    object actManufacturingReports: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Manufacturing Reports'
      ImageIndex = 141
      OnExecute = actManufacturingReportsExecute
      ClassExecute = 'TfrmReportSelectorGUI'
      buttoncolor = clWhite
    end
    object actProcPreferences: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Preferences'
      ImageIndex = 159
      OnExecute = actProcPreferencesExecute
      buttoncolor = clWhite
    end
    object actProductionPartsList: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Production Parts Status'
      ImageIndex = 96
      Visible = False
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductionPartStatusGUI'
      buttoncolor = clWhite
    end
    object actOrdersFromStock: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Orders From Stock'
      ImageIndex = 132
      OnExecute = AnyActionExecute
      ClassExecute = 'TOrdersFromStockGUI'
      buttoncolor = clWhite
    end
    object actProductionOrders: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Production Orders'
      ImageIndex = 217
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductionOrdersGUI'
      buttoncolor = clWhite
    end
    object actProcJobListing: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Production Job List'
      ImageIndex = 104
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmProcJobListing'
      buttoncolor = clWhite
    end
    object actProcProductionPartsList: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Production Parts List'
      ImageIndex = 142
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmProcProductionPartsList'
      buttoncolor = clWhite
    end
    object actBOMProductList: TDNMAction
      Category = 'Manufacturing'
      Caption = 'BOM Product List'
      ImageIndex = 175
      OnExecute = AnyActionExecute
      ClassExecute = 'TManufactureProductListGUI'
      buttoncolor = clWhite
    end
    object actManufactureProductList: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Manufacture Product List'
      ImageIndex = 175
      OnExecute = AnyActionExecute
      ClassExecute = 'TManufactureProductListGUI'
      buttoncolor = clWhite
    end
    object actBarCodeManufacturing: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Barcode Manufacturing'
      ImageIndex = 335
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmBarCodeManufacturing'
      buttoncolor = clWhite
    end
    object actProductionJobStatusDetails: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Job Time Sheets'
      ImageIndex = 28
      OnExecute = AnyActionExecute
      ClassExecute = 'TJobtimeSheetsGUI'
      buttoncolor = clWhite
    end
    object actProductionWorkordertimesheets: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Job Time Sheets'
      ImageIndex = 28
      OnExecute = AnyActionExecute
      ClassExecute = 'TWorkOrdertimeSheetsGUI'
      buttoncolor = clWhite
    end
    object actManufactureSubProductListGUI: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Manufacture Sub Product List'
      ImageIndex = 183
      OnExecute = AnyActionExecute
      ClassExecute = 'TManufactureSubProductListGUI'
      buttoncolor = clWhite
    end
    object actWastagereport: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Build Profitability'
      ImageIndex = 242
      OnExecute = AnyActionExecute
      ClassExecute = 'TBOMWastageReportGUI'
      buttoncolor = clWhite
    end
    object actOrderStatus: TDNMAction
      Category = 'Manufacturing'
      Caption = 'BOM Product Status'
      ImageIndex = 241
      OnExecute = AnyActionExecute
      ClassExecute = 'TBOMOrderStatusGUI'
      buttoncolor = clWhite
    end
    object actprocessstepList: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Process Step List'
      ImageIndex = 235
      OnExecute = AnyActionExecute
      ClassExecute = 'TprocessstepListGUI'
      buttoncolor = clWhite
    end
    object actBOMSalesList: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Manufacturing Sales List'
      ImageIndex = 225
      OnExecute = AnyActionExecute
      ClassExecute = 'TBOMSalesListGUI'
      buttoncolor = clWhite
    end
    object actProductionjobstatusdetailsList: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Production Job Details'
      ImageIndex = 220
      ClassExecute = 'TProductionjobstatusdetailsList'
      buttoncolor = clWhite
    end
    object actCapacityPlanningonGanttchart: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Capacity Planning (Gantt Chart)'
      ImageIndex = 240
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmCapacityPlanningonGanttchart'
      buttoncolor = clWhite
    end
    object actRosterWithManProcess: TDNMAction
      Category = 'Manufacturing'
      Caption = 'BOM Roster'
      ImageIndex = 343
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmRosterWithManProcess'
      buttoncolor = clWhite
    end
    object actStowAwayList: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Stow Away List'
      ImageIndex = 351
      OnExecute = AnyActionExecute
      ClassExecute = 'TStowAwayListGUI'
      buttoncolor = clWhite
    end
    object actRosterBreakList: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Roster History'
      ImageIndex = 16
      OnExecute = AnyActionExecute
      ClassExecute = 'TRosterBreakListGUI'
      buttoncolor = clWhite
    end
    object actEmployeeJobStatus: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Employee Job Status'
      ImageIndex = 229
      OnExecute = AnyActionExecute
      ClassExecute = 'TEmployeeJobStatusGUI'
      buttoncolor = clWhite
    end
    object actUnallocatedBatchSalesList: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Unallocated Batch Sales List'
      ImageIndex = 352
      OnExecute = AnyActionExecute
      ClassExecute = 'TUnallocatedBatchSalesListGUI'
      buttoncolor = clWhite
    end
    object actBOMJobs: TDNMAction
      Category = 'Manufacturing'
      Caption = 'BOM Jobs'
      ImageIndex = 349
      OnExecute = AnyActionExecute
      ClassExecute = 'TBOMJobsGUI'
      buttoncolor = clWhite
    end
    object actImportSolidWorksBOM: TDNMAction
      Category = 'Manufacturing'
      Caption = 'SolidWorks'
      ImageIndex = 761
      OnExecute = actImportSolidWorksBOMExecute
      buttoncolor = clWhite
    end
    object actEmpBOMRosternScheduleConfig: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Roster n Schedule'
      ImageIndex = 17
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmEmpBOMRosternScheduleConfig'
      buttoncolor = clWhite
    end
    object actEmpResProcRosternSchedule: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Production Scheduling'
      ImageIndex = 17
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmBOMPlanner'
      buttoncolor = clWhite
    end
    object actBOMSchedulewhenReadytoSchedule: TDNMAction
      Category = 'Manufacturing'
      Caption = 'BOM Jobs'
      ImageIndex = 80
      OnExecute = AnyActionExecute
      ClassExecute = 'TBOMSchedulewhenReadytoScheduleGUI'
      buttoncolor = clWhite
    end
    object actBOMWorkOrdersEmployees: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Workorders - Employee'
      ImageIndex = 212
      OnExecute = AnyActionExecute
      ClassExecute = 'TBOMWorkOrdersEmployeesGUI'
      buttoncolor = clWhite
    end
    object actBOMWorkOrdersUnscheduled: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Workorders - (Un-sheduled)'
      ImageIndex = 212
      OnExecute = AnyActionExecute
      ClassExecute = 'TWorkOrdersUnScheduledGUI'
      buttoncolor = clWhite
    end
    object actBOMWorkOrdersExtraDetails: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Workorders - Extra Details'
      ImageIndex = 281
      OnExecute = AnyActionExecute
      ClassExecute = 'TBOMWorkOrdersExtraDetailsGUI'
      buttoncolor = clWhite
    end
    object actBOMWorkOrdersProcess: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Workorders - Process'
      ImageIndex = 305
      OnExecute = AnyActionExecute
      ClassExecute = 'TBOMWorkOrdersProcessGUI'
      buttoncolor = clWhite
    end
    object actBOMWorkOrdersProduct: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Workorders - Product'
      ImageIndex = 309
      OnExecute = AnyActionExecute
      ClassExecute = 'TBOMWorkOrdersProductGUI'
      buttoncolor = clWhite
    end
    object actBOMWorkOrdersSalesOrder: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Workorders - Sales Order'
      ImageIndex = 355
      OnExecute = AnyActionExecute
      ClassExecute = 'TBOMWorkOrdersSalesOrderGUI'
      buttoncolor = clWhite
    end
    object actBOMWorkOrdersSummary: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Work Orders - Summary'
      ImageIndex = 474
      OnExecute = AnyActionExecute
      ClassExecute = 'TBOMWorkOrdersSummaryGUI'
      buttoncolor = clWhite
    end
    object actWorkOrdersByRes: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Work Orders (Resource)'
      ImageIndex = 489
      OnExecute = AnyActionExecute
      ClassExecute = 'TWorkOrdersByResGUI'
      buttoncolor = clWhite
    end
    object actWorkOrdersByDate: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Work Orders (Dte)'
      ImageIndex = 489
      OnExecute = AnyActionExecute
      ClassExecute = 'TWorkOrdersByDateGUI'
      buttoncolor = clWhite
    end
    object actWorkOrders: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Work Orders'
      ImageIndex = 489
      OnExecute = AnyActionExecute
      ClassExecute = 'TEmpWorkOrdersGUI'
      buttoncolor = clWhite
    end
    object actWorkOrdersBySale: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Work Orders (Sale)'
      ImageIndex = 489
      OnExecute = AnyActionExecute
      ClassExecute = 'TWorkOrdersBySaleGUI'
      buttoncolor = clWhite
    end
    object actWorkOrdersByEmp: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Work Orders (Employee)'
      ImageIndex = 489
      OnExecute = AnyActionExecute
      ClassExecute = 'TWorkOrdersByEmpGUI'
      buttoncolor = clWhite
    end
    object actEmpResProcRoster: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Employee Allocation'
      ImageIndex = 44
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmEmpResProcRoster'
      buttoncolor = clWhite
    end
    object actSimpleWorkOrder: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Simple Work Order'
      ImageIndex = 498
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmSalesLineBOMTree'
      buttoncolor = clWhite
    end
    object actBOMProgressbuilds: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Progress Builds'
      ImageIndex = 667
      OnExecute = AnyActionExecute
      ClassExecute = 'TBOMProgressbuildListGUI'
      buttoncolor = clWhite
    end
    object actProcProgress: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Progress Build'
      ImageIndex = 580
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmProcProgress'
      buttoncolor = clWhite
    end
    object actBOMSetup: TDNMAction
      Category = 'Manufacturing'
      Caption = 'BOM Setup'
      ImageIndex = 575
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmBOMSetup'
      buttoncolor = clWhite
    end
    object actWorkOrderTimesheets: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Work Order Timesheets'
      ImageIndex = 337
      OnExecute = AnyActionExecute
      ClassExecute = 'TWorkOrdertimeSheetsGUI'
      buttoncolor = clWhite
    end
    object actBOMSalesOrders: TDNMAction
      Category = 'Manufacturing'
      Caption = 'BOM Sales Orders'
      ImageIndex = 690
      OnExecute = AnyActionExecute
      ClassExecute = 'TBOMSalesOrdersGUI'
      buttoncolor = clWhite
    end
    object actBOMProductsList: TDNMAction
      Category = 'Manufacturing'
      Caption = 'BOM Products'
      ImageIndex = 682
      OnExecute = AnyActionExecute
      ClassExecute = 'TBOMProductsListGUI'
      buttoncolor = clWhite
    end
    object actProductionTonnesDetails: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Production Tonnes - With Raw Materials'
      ImageIndex = 691
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductionTonnesDetailsGUI'
      buttoncolor = clWhite
    end
    object actProductionTonnes: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Production Tonnes - Main Product'
      ImageIndex = 692
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductionTonnesGUI'
      buttoncolor = clWhite
    end
    object actBOMSalesSubProductsList: TDNMAction
      Category = 'Manufacturing'
      Caption = 'BOM Sales Sub Products'
      ImageIndex = 665
      OnExecute = AnyActionExecute
      ClassExecute = 'TBOMSalesSubProductsListGUI'
      buttoncolor = clWhite
    end
    object actBOMSalesSubProductsDetailList: TDNMAction
      Category = 'Manufacturing'
      Caption = 'BOM Sales Sub Products(Details)'
      ImageIndex = 665
      OnExecute = AnyActionExecute
      ClassExecute = 'TBOMSalesSubProductsDetailListGUI'
      buttoncolor = clWhite
    end
    object actBOMSalesDEtails: TDNMAction
      Category = 'Manufacturing'
      Caption = 'BOM Sales - Details'
      ImageIndex = 666
      OnExecute = actBOMSalesDEtailsExecute
      ClassExecute = 'TBOMSalesList_ProductGUI'
      buttoncolor = clWhite
    end
    object actProductionOrderReport: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Production Order Report'
      ImageIndex = 676
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductionOrderListGUI'
      buttoncolor = clWhite
    end
    object actProductionOrderReportNew: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Production Order Report(New)'
      ImageIndex = 676
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductionOrderMaterialListGUI'
      buttoncolor = clWhite
    end
    object actBOMSubAssemblyCheck: TDNMAction
      Category = 'Manufacturing'
      Caption = 'BOM Sub-Assembly Check'
      ImageIndex = 695
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmSubAssemUpdateAndCheck'
      buttoncolor = clWhite
    end
    object actSubBom: TDNMAction
      Category = 'Manufacturing'
      Caption = 'Sub BOMs'
      ImageIndex = 715
      OnExecute = AnyActionExecute
      ClassExecute = 'TSubBomGUI'
      buttoncolor = clWhite
    end
    object actBOMDailyProcessSales: TDNMAction
      Category = 'Manufacturing'
      Caption = 'BOM Daily Process Sales'
      ImageIndex = 751
      OnExecute = AnyActionExecute
      ClassExecute = 'TBOMDailyProcessSalesGUI'
      buttoncolor = clWhite
    end
  end
end
