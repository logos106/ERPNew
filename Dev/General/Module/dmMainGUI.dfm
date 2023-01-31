inherited dtmMainGUI: TdtmMainGUI
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 381
  Width = 699
  object ActionList: TActionList
    Left = 20
    Top = 17
    object actStockTransferEntryBin: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Bin Transfer'
      ImageIndex = 361
      OnExecute = AnyActionExecute
      OnHint = actStockTransferEntryBinHint
      ClassExecute = 'TfmStockTransferEntryBin'
      Description = 'Stk Trans List'
      buttoncolor = 11579647
    end
    object actwalmartshippingmethods: TDNMAction
      Category = 'Integration'
      Caption = 'Walmart Shipping Methods'
      ImageIndex = 733
      OnExecute = actInt_WalMartExecute
      ClassExecute = 'Tfmwalmartshippingmethods'
      buttoncolor = clWhite
    end
    object actStockTransferEntryListBin: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Bin Transfer List'
      ImageIndex = 428
      OnExecute = AnyActionExecute
      ClassExecute = 'TStockTransferEntryListBinGUI'
      Description = 'Stk Trans List'
      buttoncolor = 11579647
    end
    object actInt_WalMart: TDNMAction
      Category = 'Integration'
      Caption = 'Walmart'
      ImageIndex = 755
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_Woocommerce: TDNMAction
      Category = 'Integration'
      Caption = 'WooCommerce'
      ImageIndex = 768
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_QuickBooks: TDNMAction
      Category = 'Integration'
      Caption = 'QuickBooks'
      ImageIndex = 780
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actEmployeeLeaveRequest: TDNMAction
      Category = 'Employee'
      Caption = 'Employee Leave Request'
      ImageIndex = 109
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmEmployeeLeaveRequests'
      buttoncolor = clWhite
    end
    object actStockTransferEntrySN: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Serial Number Transfer '
      ImageIndex = 319
      OnExecute = AnyActionExecute
      OnHint = actStockTransferEntryBinHint
      ClassExecute = 'TfmStockTransferEntrySN'
      Description = 'Stk Trans List'
      buttoncolor = 11579647
    end
    object actStockTransferEntryListSN: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Serial Number Transfer List'
      ImageIndex = 312
      OnExecute = AnyActionExecute
      ClassExecute = 'TStockTransferEntryListSNGUI'
      Description = 'Stk Trans List'
      buttoncolor = 11579647
    end
    object actERPPDFDocs: TDNMAction
      Category = 'General'
      Caption = 'How To - All'
      ImageIndex = 746
      OnExecute = AnyActionExecute
      ClassExecute = 'TERPPDFDocsGUI'
      buttoncolor = clWhite
    end
    object actReportsPOS: TDNMAction
      Category = 'Reports'
      Caption = 'POS Reports'
      ImageIndex = 141
      OnExecute = actReportsPOSExecute
      ClassExecute = 'TfrmReportSelectorGUI'
      buttoncolor = clWhite
    end
    object actStockTransferEntryBatch: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Batch Transfer'
      ImageIndex = 401
      OnExecute = AnyActionExecute
      OnHint = actStockTransferEntryBinHint
      ClassExecute = 'TfmStockTransferEntryBatch'
      Description = 'Stk Trans List'
      buttoncolor = 11579647
    end
    object actProductFormulaType: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Formula Type'
      ImageIndex = 688
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmProductFormulaTypes'
      buttoncolor = clWhite
    end
    object actStockTransferEntryListBAtch: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Batch Transfer List'
      ImageIndex = 418
      OnExecute = AnyActionExecute
      ClassExecute = 'TStockTransferEntryListBAtchGUI'
      Description = 'Stk Trans List'
      buttoncolor = 11579647
    end
    object actInventStockStockAdjustmentbatch: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Batch Adjustment '
      ImageIndex = 594
      OnExecute = AnyActionExecute
      OnHint = actStockTransferEntryBinHint
      ClassExecute = 'tfmStockAdjustEntryBatch'
      Description = 'Stock Adjustment - Batch'
      buttoncolor = 14024618
    end
    object actInventStockStockAdjustmentList: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Stock Adjustment List'
      ImageIndex = 280
      OnExecute = AnyActionExecute
      ClassExecute = 'TStockAdjustEntryListGUI'
      Description = 'Stk Adj List'
      buttoncolor = 14024618
    end
    object actInventStockStockAdjustment: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Stock Adjustment'
      ImageIndex = 296
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmStockAdjustEntryTree'
      Description = 'Stock Adj'
      buttoncolor = 14024618
    end
    object actStockAdjustEntryflat: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Stock Adjustment '
      ImageIndex = 246
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmStockAdjustEntryflat'
      Description = 'Stock Adj'
      buttoncolor = 14024618
    end
    object actInventStockStockAdjustmentsnLsit: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Serial Number Adjustment List'
      ImageIndex = 571
      OnExecute = AnyActionExecute
      ClassExecute = 'TStockAdjustEntryListSNGUI'
      Description = 'Stock Adjustment - SN List'
      buttoncolor = 14024618
    end
    object actInventStockStockTake: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Stock Take (Stock)'
      ImageIndex = 224
      OnExecute = actInventStockStockTakeExecute
      buttoncolor = 11796479
    end
    object actStockTakeList: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Stock Take (Stock) List'
      ImageIndex = 264
      OnExecute = AnyActionExecute
      ClassExecute = 'TStockTakeListGUI'
      Description = 'Stk Adj List'
      buttoncolor = 11796479
    end
    object actStockTransferEntryTree: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Stock Transfer'
      ImageIndex = 568
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmStockTransferEntryTree'
      buttoncolor = 11579647
    end
    object actInventStockStockAdjustmentbinList: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Bin Adjustment List'
      ImageIndex = 633
      OnExecute = AnyActionExecute
      ClassExecute = 'TStockAdjustEntryListBinGUI'
      Description = 'Stock Adjustment - Bin List'
      buttoncolor = 14024618
    end
    object actCashFlowStatement: TDNMAction
      Category = 'Accounts'
      Caption = 'Cash Flow Statement'
      ImageIndex = 346
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmCashFlowStatement'
      buttoncolor = clWhite
    end
    object actReportsUtilities: TDNMAction
      Category = 'Reports'
      Caption = 'Utilities Reports'
      ImageIndex = 141
      OnExecute = actReportsUtilitiesExecute
      ClassExecute = 'TfrmReportSelectorGUI'
      buttoncolor = clWhite
    end
    object actWalmartitems: TDNMAction
      Category = 'Integration'
      Caption = 'Walmart Products'
      ImageIndex = 752
      OnExecute = actInt_WalMartExecute
      ClassExecute = 'TWalmartItemsGUI'
      buttoncolor = clWhite
    end
    object actWoocommitems: TDNMAction
      Category = 'Integration'
      Caption = 'WooCommerce Products'
      ImageIndex = 752
      OnExecute = actInt_WoocommExecute
      ClassExecute = 'TWooCommerceItemsGUI'
      buttoncolor = clWhite
    end
    object actWalmartSalesOrders: TDNMAction
      Category = 'Integration'
      Caption = 'Walmart Sales Orders'
      ImageIndex = 718
      OnExecute = actInt_WalMartExecute
      ClassExecute = 'TWalmartSalesOrdersGUI'
      buttoncolor = clWhite
    end
    object actWooCommerceInvoices: TDNMAction
      Category = 'Integration'
      Caption = 'WooCommerce Orders'
      ImageIndex = 718
      OnExecute = actInt_WoocommExecute
      ClassExecute = 'TWooCommerceInvoicesGUI'
      buttoncolor = clWhite
    end
    object actUtilsEmailedReport: TDNMAction
      Category = 'Utilities'
      Caption = 'Emailed Reports'
      Enabled = False
      ImageIndex = 292
      Visible = False
      OnExecute = AnyActionExecute
      ClassExecute = 'TEmailedReportsList'
      buttoncolor = clWhite
    end
    object actInt_WalMartOrders: TDNMAction
      Category = 'Integration'
      Caption = 'Walmart Orders'
      ImageIndex = 717
      OnExecute = actInt_WalMartExecute
      ClassExecute = 'TWalmartOrderLinesGUI'
      buttoncolor = clWhite
    end
    object actInt_WoocommCustomers: TDNMAction
      Category = 'Integration'
      Caption = 'WooCommerce Customers'
      ImageIndex = 717
      OnExecute = actInt_WoocommExecute
      ClassExecute = 'TWooCommerceCustomersGUI'
      buttoncolor = clWhite
    end
    object actInt_WalmartFeeds: TDNMAction
      Category = 'Integration'
      Caption = 'Walmart Inventory Feeds'
      ImageIndex = 717
      OnExecute = actInt_WalMartExecute
      ClassExecute = 'TWalmartFeedsGUI'
      buttoncolor = clWhite
    end
    object SOBOList: TDNMAction
      Category = 'Sales'
      Caption = 'BO Sales Orders'
      ImageIndex = 74
      OnExecute = AnyActionExecute
      ClassExecute = 'TBackOrderSOGUI'
      Description = 'BO Sales Ord'
      buttoncolor = clWhite
    end
    object actSOList: TDNMAction
      Category = 'Sales'
      Caption = 'Sales Order List'
      ImageIndex = 85
      OnExecute = AnyActionExecute
      ClassExecute = 'TSalesorderListExpressGUI'
      Description = 'Sales Order Express List'
      buttoncolor = clWhite
    end
    object actInventStockStockTransfer: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Stock Transfer (Flat)'
      ImageIndex = 546
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmStockTransferEntry'
      buttoncolor = 11579647
    end
    object SOBOListExpress: TDNMAction
      Category = 'Sales'
      Caption = 'Sales Order BO Express'
      ImageIndex = 84
      OnExecute = AnyActionExecute
      ClassExecute = 'TBackOrderSOExpressGUI'
      Description = 'Sales Order BO Express List'
      buttoncolor = clWhite
    end
    object actScheduledReports: TDNMAction
      Category = 'General'
      Caption = 'Scheduled Reports'
      ImageIndex = 429
      OnExecute = AnyActionExecute
      ClassExecute = 'TScheduledReportsGUI'
      buttoncolor = clWhite
    end
    object actProfitandLossPeriodCompare: TDNMAction
      Category = 'Accounts'
      Caption = 'Profit And Loss (Compare)'
      ImageIndex = 140
      OnExecute = AnyActionExecute
      ClassExecute = 'TProfitandLossPeriodCompareGUI'
      Description = 'P & L (Period)'
      buttoncolor = clWhite
    end
    object INVBOList: TDNMAction
      Category = 'Sales'
      Caption = 'BO Invoices'
      ImageIndex = 73
      OnExecute = AnyActionExecute
      ClassExecute = 'TBackOrdersListGUI'
      buttoncolor = clWhite
    end
    object actERPHelpDoc: TDNMAction
      Category = 'General'
      Caption = 'ERP Help Doc'
      ImageIndex = 548
      OnExecute = AnyActionExecute
      ClassExecute = 'TFmERPHelpDoc'
      buttoncolor = clWhite
    end
    object INVBOListExpress: TDNMAction
      Category = 'Sales'
      Caption = 'Invoice Backorder Express'
      ImageIndex = 47
      OnExecute = AnyActionExecute
      ClassExecute = 'TbackorderInvoiceExpressGUI'
      buttoncolor = clWhite
    end
    object actFileNewCompany: TDNMAction
      Category = 'File'
      Caption = 'New Company'
      ImageIndex = 125
      OnExecute = actFileNewCompanyExecute
      buttoncolor = clWhite
    end
    object actReportsEmployee: TDNMAction
      Category = 'Reports'
      Caption = 'Employee Reports'
      ImageIndex = 141
      OnExecute = actReportsEmployeeExecute
      ClassExecute = 'TfrmReportSelectorGUI'
      Description = 'Employee Rep'
      buttoncolor = clWhite
    end
    object actOverdueInvoices: TDNMAction
      Category = 'Payments'
      Caption = 'Overdue Invoices'
      ImageIndex = 307
      OnExecute = AnyActionExecute
      ClassExecute = 'TOverdueInvoicesGUI'
      Description = 'Supp Pmnt Lst'
      buttoncolor = clWhite
    end
    object actFileOpenCompany: TDNMAction
      Category = 'File'
      Caption = 'Open Company'
      ImageIndex = 143
      OnExecute = actFileOpenCompanyExecute
      buttoncolor = clWhite
    end
    object actMainswitchHeightIncrease: TDNMAction
      Category = 'Mainswitch'
      Caption = 'Main Form - Increase Height'
      ImageIndex = 694
      OnExecute = actMainswitchHeightIncreaseExecute
      buttoncolor = clWhite
    end
    object actFileImportData: TDNMAction
      Category = 'File'
      Caption = 'Data'
      ImageIndex = 234
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmImportDataMappingList'
      buttoncolor = clWhite
    end
    object actInventProductsProductCommission: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Commission'
      ImageIndex = 357
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmProductCommission'
      Description = 'Product Com'
      buttoncolor = clWhite
    end
    object actFileImportTemplates: TDNMAction
      Category = 'File'
      Caption = 'Import Templates'
      ImageIndex = 83
      OnExecute = AnyActionExecute
      ClassExecute = 'TImportTemplatesGUI'
      Description = 'Imp Templates'
      buttoncolor = clWhite
    end
    object actFileImportTNTClientRates: TDNMAction
      Category = 'File'
      Caption = 'Client Rates'
      ImageIndex = 214
      OnExecute = AnyActionExecute
      ClassExecute = 'TImportTNTRatesGUI'
      buttoncolor = clWhite
    end
    object actFileImportTNTPostcodeToRating: TDNMAction
      Category = 'File'
      Caption = 'Postcode to Rating Area & Zone'
      ImageIndex = 27
      OnExecute = AnyActionExecute
      ClassExecute = 'TImportPcodeToRatingAreaZoneGUI'
      Description = 'Pstcd Rtg & Zn'
      buttoncolor = clWhite
    end
    object actAccountsTerms: TDNMAction
      Category = 'Accounts'
      Caption = 'Terms'
      ImageIndex = 114
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmTerms'
      buttoncolor = clWhite
    end
    object actFileExportData: TDNMAction
      Category = 'File'
      Caption = 'Export Data'
      ImageIndex = 156
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmExportImportData'
      buttoncolor = clWhite
    end
    object actFileExportTemplates: TDNMAction
      Category = 'File'
      Caption = 'Export Templates'
      ImageIndex = 153
      OnExecute = AnyActionExecute
      ClassExecute = 'TExportTemplatesGUI'
      Description = 'Exp Templates'
      buttoncolor = clWhite
    end
    object actCustomerProfitability: TDNMAction
      Category = 'Sales'
      Caption = 'Customer Profitability'
      ImageIndex = 192
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomerProfitability'
      Description = 'Customer Profitability'
      buttoncolor = clWhite
    end
    object actApptMainCalendar: TDNMAction
      Category = 'Appointments'
      Caption = 'Main Calendar'
      ImageIndex = 21
      OnExecute = AnyActionExecute
      ClassExecute = 'TCalendarGUI'
      buttoncolor = clWhite
    end
    object actSerialNumberList: TDNMAction
      Category = 'Inventory'
      Caption = 'Serial Numbers Available'
      ImageIndex = 377
      OnExecute = AnyActionExecute
      ClassExecute = 'TSerialNumberListBatchGUI'
      buttoncolor = clWhite
    end
    object actSerialjobnumbers: TDNMAction
      Category = 'Inventory'
      Caption = 'Serial Numbers Available'
      ImageIndex = 377
      OnExecute = AnyActionExecute
      ClassExecute = 'TSerialJobNumbersGUI'
      buttoncolor = clWhite
    end
    object actApptsPrintAppointments: TDNMAction
      Category = 'Appointments'
      Caption = 'Print Appointments'
      ImageIndex = 177
      OnExecute = AnyActionExecute
      ClassExecute = 'TAppointmentsPrnGUI'
      Description = 'Print Appts'
      buttoncolor = clWhite
    end
    object actApptsNewAppointment: TDNMAction
      Category = 'Appointments'
      Caption = 'Appointment'
      ImageIndex = 8
      OnExecute = AnyActionExecute
      ClassExecute = 'TAppointmentGUI'
      buttoncolor = clWhite
    end
    object actIncomeandExpenditurereport: TDNMAction
      Category = 'Accounts'
      Caption = 'Income and Expenditure Report'
      ImageIndex = 71
      OnExecute = AnyActionExecute
      ClassExecute = 'TIncomeandExpenditureGUI'
      Description = 'P & L (Period)'
      buttoncolor = clWhite
    end
    object actApptsAppointmentsList: TDNMAction
      Category = 'Appointments'
      Caption = 'Appointments List'
      ImageIndex = 9
      OnExecute = AnyActionExecute
      ClassExecute = 'TAppointmentListGUI'
      Description = 'Appts List'
      buttoncolor = clWhite
    end
    object actApptsNewSource: TDNMAction
      Category = 'Appointments'
      Caption = 'Source'
      ImageIndex = 26
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmSource'
      buttoncolor = clWhite
    end
    object actApptsSourceList: TDNMAction
      Category = 'Appointments'
      Caption = 'Source List'
      ImageIndex = 95
      OnExecute = AnyActionExecute
      ClassExecute = 'TSourceListGUI'
      buttoncolor = clWhite
    end
    object actApptsNewJob: TDNMAction
      Category = 'Appointments'
      Caption = 'Job'
      ImageIndex = 196
      OnExecute = actApptsNewJobExecute
      buttoncolor = clWhite
    end
    object actApptsJobList: TDNMAction
      Category = 'Appointments'
      Caption = 'Job List'
      ImageIndex = 200
      OnExecute = AnyActionExecute
      ClassExecute = 'TJobListGUI'
      buttoncolor = clWhite
    end
    object actApptsPhoneSupport: TDNMAction
      Category = 'Appointments'
      Caption = 'Support Pricing'
      ImageIndex = 59
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmPhSupportPrintout'
      Description = 'Support Pricing'
      buttoncolor = clWhite
    end
    object actInventProductPictureProductsList: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Picture List'
      ImageIndex = 69
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductPictureListGUI'
      buttoncolor = clWhite
    end
    object actReportsGeneral: TDNMAction
      Category = 'Reports'
      Caption = 'General Reports'
      ImageIndex = 141
      OnExecute = actReportsGeneralExecute
      ClassExecute = 'TfrmReportSelectorGUI'
      buttoncolor = clWhite
    end
    object actApptsFeedbackReport: TDNMAction
      Category = 'Appointments'
      Caption = 'Feedback Report'
      ImageIndex = 41
      OnExecute = AnyActionExecute
      ClassExecute = 'TFeedbackListGUI'
      DefaultPage = 'Feedback Rep'
      buttoncolor = clWhite
    end
    object actApptsAppointmentsReport: TDNMAction
      Category = 'Appointments'
      Caption = 'Appointment Report'
      ImageIndex = 237
      OnExecute = AnyActionExecute
      ClassExecute = 'TAppointmentListReportGUI'
      Description = 'Appts Report'
      buttoncolor = clWhite
    end
    object actApptsPhoneSupportLogList: TDNMAction
      Category = 'Appointments'
      Caption = 'Support Log List'
      ImageIndex = 135
      OnExecute = AnyActionExecute
      ClassExecute = 'TPhSupportLogListGUI'
      Description = 'Support Log List'
      buttoncolor = clWhite
    end
    object actBarcodeAction: TDNMAction
      Category = 'Inventory'
      Caption = 'Barcode Action'
      ImageIndex = 285
      OnExecute = actBarcodeActionExecute
      ClassExecute = 'TBarcodeAction'
      DefaultPage = 'Inventory'
      buttoncolor = clWhite
    end
    object actApptsCustomersOnSupportList: TDNMAction
      Category = 'Appointments'
      Caption = 'Customers On Support List'
      ImageIndex = 191
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomersOnSupportListGUI'
      Description = 'Cust Supp List'
      buttoncolor = clWhite
    end
    object actSalesCustomersNewCustomer: TDNMAction
      Category = 'Sales'
      Caption = 'Customer'
      ImageIndex = 189
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmCustomer'
      buttoncolor = clWhite
    end
    object actSalesCustomersCustomerList: TDNMAction
      Category = 'Sales'
      Caption = 'Customer List'
      ImageIndex = 29
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomerListGUI'
      Description = 'Cust/List'
      buttoncolor = clWhite
    end
    object actProfitandLossByPeriod: TDNMAction
      Category = 'Inventory'
      Caption = 'Profit and Loss  By Period'
      ImageIndex = 402
      OnExecute = AnyActionExecute
      ClassExecute = 'TProfitLossPeriodGUI'
      buttoncolor = clWhite
    end
    object actSalesCustomersCustomerAccountNoSetup: TDNMAction
      Category = 'Sales'
      Caption = 'Customer Account No Setup'
      ImageIndex = 303
      OnExecute = actSalesCustomersCustomerAccountNoSetupExecute
      ClassExecute = 'FnCustomerAccountNoSetup'
      Description = 'Cust Acc Setup'
      buttoncolor = clWhite
    end
    object actSalesCustomersClientType: TDNMAction
      Category = 'Sales'
      Caption = 'Customer Type'
      ImageIndex = 22
      OnExecute = AnyActionExecute
      ClassExecute = 'TClientTypeGUI'
      buttoncolor = clWhite
    end
    object actSalesCustomersClientTypeList: TDNMAction
      Category = 'Sales'
      Caption = 'Customer Type List'
      ImageIndex = 23
      OnExecute = AnyActionExecute
      ClassExecute = 'TClientTypeListGUI'
      Description = 'Customer Type Lst'
      buttoncolor = clWhite
    end
    object actSalesCustomersCustomerSummary: TDNMAction
      Category = 'Sales'
      Caption = 'Customer Summary'
      ImageIndex = 376
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomerSummaryListingGUI'
      Description = 'Customer Summ'
      buttoncolor = clWhite
    end
    object actEmployeeLeaveRequests: TDNMAction
      Category = 'Employee'
      Caption = 'Employee Leave Requests'
      ImageIndex = 88
      OnExecute = AnyActionExecute
      ClassExecute = 'TEmployeeLeaveRequestsGUI'
      buttoncolor = clWhite
    end
    object actSalesCustomersCustomerDetailsList: TDNMAction
      Category = 'Sales'
      Caption = 'Customer Details List'
      ImageIndex = 186
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomerDetailsListGUI'
      Description = 'Cust Det List'
      buttoncolor = clWhite
    end
    object actSalesCRMOtherContacts: TDNMAction
      Category = 'CRM'
      Caption = 'Prospect'
      ImageIndex = 53
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmOtherContact'
      buttoncolor = clWhite
    end
    object actSalesCRMOtherContactsList: TDNMAction
      Category = 'CRM'
      Caption = 'Prospect List'
      ImageIndex = 54
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmOthersList'
      Description = 'Contact List'
      buttoncolor = clWhite
    end
    object actSalesCRMPhoneContact: TDNMAction
      Category = 'CRM'
      Caption = 'Phone Contact'
      ImageIndex = 340
      OnExecute = actSalesCRMPhoneContactExecute
      buttoncolor = clWhite
    end
    object actSalesCRMPhoneContactList: TDNMAction
      Category = 'CRM'
      Caption = 'Phone Contact List'
      ImageIndex = 339
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmFollowUpList'
      Description = 'Phone Con List'
      buttoncolor = clWhite
    end
    object actSalesCRMCanvasser: TDNMAction
      Category = 'CRM'
      Caption = 'Canvasser'
      ImageIndex = 372
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmCanvasser'
      buttoncolor = clWhite
    end
    object actSalesCRMCanvasserList: TDNMAction
      Category = 'CRM'
      Caption = 'Canvasser List'
      ImageIndex = 375
      OnExecute = AnyActionExecute
      ClassExecute = 'TCanvasserListGUI'
      buttoncolor = clWhite
    end
    object actSalesCRMLoyaltyProgram: TDNMAction
      Category = 'CRM'
      Caption = 'Loyalty Program'
      ImageIndex = 164
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmRewardPoint'
      buttoncolor = clWhite
    end
    object actSalesCRMMailMerge: TDNMAction
      Category = 'CRM'
      Caption = 'Mail Merge'
      ImageIndex = 51
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmMailMerge'
      buttoncolor = clWhite
    end
    object actSalesJobsJobAnalysisBalanceReport: TDNMAction
      Category = 'Sales'
      Caption = 'Job Analysis / Balance Report'
      ImageIndex = 193
      OnExecute = AnyActionExecute
      ClassExecute = 'TJobAnalysisReportGUI'
      Description = 'Job An/Bal Rep'
      buttoncolor = clWhite
    end
    object actSalesJobsJobProfitability: TDNMAction
      Category = 'Sales'
      Caption = 'Job Profitability'
      ImageIndex = 501
      OnExecute = AnyActionExecute
      ClassExecute = 'TJobProfitabilityforCustomerGUI'
      Description = 'Job Profit'
      buttoncolor = clWhite
    end
    object actSalesQuotesQuote: TDNMAction
      Category = 'Sales'
      Caption = 'Quote'
      ImageIndex = 392
      OnExecute = AnyActionExecute
      ClassExecute = 'TQuoteGUI'
      buttoncolor = clWhite
    end
    object actSalesQuotesQuoteList: TDNMAction
      Category = 'Sales'
      Caption = 'Quote List'
      ImageIndex = 78
      OnExecute = AnyActionExecute
      ClassExecute = 'TQuoteListGUI'
      buttoncolor = clWhite
    end
    object actSalesQuotesQuoteExpressList: TDNMAction
      Category = 'Sales'
      Caption = 'Quote Express List'
      ImageIndex = 394
      OnExecute = AnyActionExecute
      ClassExecute = 'TQuoteListExpressGUI'
      buttoncolor = clWhite
    end
    object actSalesSalesOrdersSalesOrder: TDNMAction
      Category = 'Sales'
      Caption = 'Sales Order'
      ImageIndex = 226
      OnExecute = AnyActionExecute
      ClassExecute = 'TSalesOrderGUI'
      buttoncolor = clWhite
    end
    object actSalesPOSPOSScreen: TDNMAction
      Category = 'Sales'
      Caption = 'POS'
      ImageIndex = 263
      OnExecute = AnyActionExecute
      ClassExecute = 'TPOSScreenForm'
      Description = 'POS'
      buttoncolor = clWhite
    end
    object actSalesPOSQuickPOS: TDNMAction
      Category = 'Sales'
      Caption = 'Quick POS'
      ImageIndex = 265
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmQuickPOS'
      Description = 'Quick POS'
      buttoncolor = clWhite
    end
    object actSalesSalesOrdersSalesOrderList: TDNMAction
      Category = 'Sales'
      Caption = 'Sales Order List'
      ImageIndex = 406
      OnExecute = AnyActionExecute
      ClassExecute = 'TSalesOrderListGUI'
      Description = 'Sales Ord List'
      buttoncolor = clWhite
    end
    object actSalesSalesOrdersSalesOrderExpressList: TDNMAction
      Category = 'Sales'
      Caption = 'Sales Order Express List'
      ImageIndex = 85
      OnExecute = AnyActionExecute
      ClassExecute = 'TSalesorderListExpressGUI'
      Description = 'Sales Order Express List'
      buttoncolor = clWhite
    end
    object actProductformulaTypeList: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Formula Type List'
      ImageIndex = 684
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductformulaTypeListGUI'
      buttoncolor = clWhite
    end
    object actSalesSalesOrdersSalesOrderReport: TDNMAction
      Category = 'Sales'
      Caption = 'Sales Order Report'
      ImageIndex = 233
      OnExecute = AnyActionExecute
      ClassExecute = 'TSalesOrderReportGUI'
      Description = 'Sales Ord Rep'
      buttoncolor = clWhite
    end
    object actSalesSalesCashSale: TDNMAction
      Category = 'Sales'
      Caption = 'Cash Sale'
      ImageIndex = 130
      OnExecute = AnyActionExecute
      ClassExecute = 'TCashSaleGUI'
      buttoncolor = clWhite
    end
    object actPOSCashPayments: TDNMAction
      Category = 'Sales'
      Caption = 'POS Cash Payments'
      ImageIndex = 680
      OnExecute = AnyActionExecute
      ClassExecute = 'TPOSCashPaymentsGUI'
      buttoncolor = clWhite
    end
    object actCustomFieldValuesProducts: TDNMAction
      Category = 'Inventory'
      Caption = 'Customisable List - Products'
      ImageIndex = 699
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomFieldValuesProductsGUI'
      buttoncolor = clWhite
    end
    object actCustomFieldValuesAlls: TDNMAction
      Category = 'General'
      Caption = 'Customisable List - All'
      ImageIndex = 699
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomFieldValuesAllGUI'
      buttoncolor = clWhite
    end
    object actCustomFieldValuesContacts: TDNMAction
      Category = 'General'
      Caption = 'Customisable List - Contacts'
      ImageIndex = 699
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomFieldValuesContactGUI'
      buttoncolor = clWhite
    end
    object actCustomFieldValuesCustomers: TDNMAction
      Category = 'Sales'
      Caption = 'Customisable List - Customers'
      ImageIndex = 699
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomFieldValuesCustomerGUI'
      buttoncolor = clWhite
    end
    object actCustomFieldValuesEquipments: TDNMAction
      Category = 'General'
      Caption = 'Customisable List - Equipment'
      ImageIndex = 699
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomFieldValuesEquipmentGUI'
      buttoncolor = clWhite
    end
    object actCustomFieldValuesLeadss: TDNMAction
      Category = 'Marketing'
      Caption = 'Customisable List - Leads'
      ImageIndex = 699
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomFieldValuesLeadsGUI'
      buttoncolor = clWhite
    end
    object actCustomFieldValuesListProducts: TDNMAction
      Category = 'Inventory'
      Caption = 'Customisable Fields - Products'
      ImageIndex = 698
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomFieldValuesListProductGUI'
      buttoncolor = clWhite
    end
    object actCustomFieldValuesListContacts: TDNMAction
      Category = 'General'
      Caption = 'Customisable Fields - Contacts'
      ImageIndex = 698
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomFieldValuesListContactGUI'
      buttoncolor = clWhite
    end
    object actCustomFieldValuesListCustomers: TDNMAction
      Category = 'Sales'
      Caption = 'Customisable Fields - Customers'
      ImageIndex = 698
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomFieldValuesListCustomerGUI'
      buttoncolor = clWhite
    end
    object actCustomFieldValuesListEquipments: TDNMAction
      Category = 'General'
      Caption = 'Customisable Fields - Equipment'
      ImageIndex = 698
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomFieldValuesListEquipmentGUI'
      buttoncolor = clWhite
    end
    object actCustomFieldValuesListLeadss: TDNMAction
      Category = 'Marketing'
      Caption = 'Customisable Fields - Leads'
      ImageIndex = 698
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomFieldValuesListLeadsGUI'
      buttoncolor = clWhite
    end
    object actCustomFieldValuesListSuppliers: TDNMAction
      Category = 'Purchases'
      Caption = 'Customisable Fields - Supplier'
      ImageIndex = 698
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomFieldValuesListSupplierGUI'
      buttoncolor = clWhite
    end
    object actCustomFieldValuesSuppliers: TDNMAction
      Category = 'Purchases'
      Caption = 'Customisable List - Supplier'
      ImageIndex = 699
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomFieldValuesSupplierGUI'
      buttoncolor = clWhite
    end
    object actSalesSalesRefunds: TDNMAction
      Category = 'Sales'
      Caption = 'Refunds'
      ImageIndex = 77
      OnExecute = AnyActionExecute
      ClassExecute = 'TRefundGUI'
      buttoncolor = clWhite
    end
    object actSalesSalesInvoice: TDNMAction
      Category = 'Sales'
      Caption = 'Invoice'
      ImageIndex = 150
      OnExecute = AnyActionExecute
      ClassExecute = 'TInvoiceGUI'
      buttoncolor = clWhite
    end
    object actSalesSalesInvoiceList: TDNMAction
      Category = 'Sales'
      Caption = 'Invoice List'
      ImageIndex = 178
      OnExecute = AnyActionExecute
      ClassExecute = 'TInvoiceListGUI'
      buttoncolor = clWhite
    end
    object actSalesSalesInvoiceExpressList: TDNMAction
      Category = 'Sales'
      Caption = 'Invoice Express List'
      ImageIndex = 151
      OnExecute = AnyActionExecute
      ClassExecute = 'TInvoicelistExpressGUI'
      buttoncolor = clWhite
    end
    object actSalesSalesInvoiceInternalOrderExpressList: TDNMAction
      Category = 'Sales'
      Caption = 'Invoice (Internal Order) Express List'
      ImageIndex = 151
      OnExecute = AnyActionExecute
      ClassExecute = 'TInvoiceInternalOrderlistExressGUI'
      buttoncolor = clWhite
    end
    object actCustomerReturnList: TDNMAction
      Category = 'Sales'
      Caption = 'Customer Return List'
      ImageIndex = 152
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomerReturnListGUI'
      buttoncolor = clWhite
    end
    object actCustomerReturns: TDNMAction
      Category = 'Sales'
      Caption = 'Customer Return'
      ImageIndex = 398
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmCustomerReturn'
      buttoncolor = clWhite
    end
    object actSalesSalesBackOrders: TDNMAction
      Category = 'Sales'
      Caption = 'BackOrders'
      ImageIndex = 250
      OnExecute = AnyActionExecute
      ClassExecute = 'TBackOrdersPopupGUI'
      buttoncolor = clWhite
    end
    object actSalesSalesSalesList: TDNMAction
      Category = 'Sales'
      Caption = 'Sales List'
      ImageIndex = 113
      OnExecute = AnyActionExecute
      ClassExecute = 'TSalesListReportGUI'
      buttoncolor = clWhite
    end
    object actSalesPOSCustomisePOS: TDNMAction
      Category = 'Sales'
      Caption = 'Customise POS'
      ImageIndex = 432
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomizePOSForm'
      buttoncolor = clWhite
    end
    object actSalesPOSBarTabList: TDNMAction
      Category = 'Sales'
      Caption = 'Bar Tab List'
      ImageIndex = 106
      OnExecute = AnyActionExecute
      ClassExecute = 'TBarTabListGUI'
      buttoncolor = clWhite
    end
    object actSalesPOSVouchersList: TDNMAction
      Category = 'Sales'
      Caption = 'Vouchers List'
      ImageIndex = 255
      OnExecute = AnyActionExecute
      ClassExecute = 'TVoucherListGUI'
      buttoncolor = clWhite
    end
    object actSalesPOSTillSummaryReport: TDNMAction
      Category = 'Sales'
      Caption = 'Till Summary Report'
      ImageIndex = 160
      OnExecute = AnyActionExecute
      ClassExecute = 'TTillSummaryReportGUI'
      Description = 'Till Summ Rep'
      buttoncolor = clWhite
    end
    object actSalesPOSTrafficList: TDNMAction
      Category = 'Sales'
      Caption = 'Traffic List'
      ImageIndex = 245
      OnExecute = AnyActionExecute
      ClassExecute = 'TTrafficListGUI'
      buttoncolor = clWhite
    end
    object actSalesPOSTrafficSummaryReport: TDNMAction
      Category = 'Sales'
      Caption = 'Traffic Summary Report'
      ImageIndex = 188
      OnExecute = AnyActionExecute
      ClassExecute = 'TTrafficMonitoringSummaryGUI'
      Description = 'Traf Summ Rep'
      buttoncolor = clWhite
    end
    object actSalesPOSOrderProcessList: TDNMAction
      Category = 'Sales'
      Caption = 'Order Process List'
      ImageIndex = 232
      OnExecute = AnyActionExecute
      ClassExecute = 'TPOSProcessFrm'
      Description = 'Ord Pro Lst'
      buttoncolor = clWhite
    end
    object actSalesManifestManifestAllocationList: TDNMAction
      Category = 'Sales'
      Caption = 'Manifest Allocation List'
      ImageIndex = 427
      OnExecute = AnyActionExecute
      ClassExecute = 'TManifestAllocationListGUI'
      Description = 'Man Alloc List'
      buttoncolor = clWhite
    end
    object actSalesManifestManifest: TDNMAction
      Category = 'Sales'
      Caption = 'Manifest'
      ImageIndex = 184
      OnExecute = AnyActionExecute
      ClassExecute = 'TManifestGUI'
      buttoncolor = clWhite
    end
    object actSalesManifestManifestList: TDNMAction
      Category = 'Sales'
      Caption = 'Manifest List'
      ImageIndex = 185
      OnExecute = AnyActionExecute
      ClassExecute = 'TManifestListGUI'
      buttoncolor = clWhite
    end
    object actSalesManifestManifestListDetail: TDNMAction
      Category = 'Sales'
      Caption = 'Manifest Detail List'
      ImageIndex = 109
      OnExecute = AnyActionExecute
      ClassExecute = 'TManifestDetailListGUI'
      buttoncolor = clWhite
    end
    object actSalesManifestManifestVehicle: TDNMAction
      Category = 'Sales'
      Caption = 'Manifest Vehicle'
      ImageIndex = 216
      OnExecute = AnyActionExecute
      ClassExecute = 'TManifestVehicleGUI'
      Description = 'Man Vehicle'
      buttoncolor = clWhite
    end
    object actSalesManifestManifestVehicleList: TDNMAction
      Category = 'Sales'
      Caption = 'Manifest Vehicle List'
      ImageIndex = 218
      OnExecute = AnyActionExecute
      ClassExecute = 'TManifestVehiclesListGUI'
      Description = 'Man Vehcl List'
      buttoncolor = clWhite
    end
    object actSalesManifestManifestRoute: TDNMAction
      Category = 'Sales'
      Caption = 'Manifest Route'
      ImageIndex = 187
      OnExecute = AnyActionExecute
      ClassExecute = 'TManifestRouteGUI'
      buttoncolor = clWhite
    end
    object actSalesManifestManifestRouteList: TDNMAction
      Category = 'Sales'
      Caption = 'Manifest Route List'
      ImageIndex = 219
      OnExecute = AnyActionExecute
      ClassExecute = 'TManifestRouteListGUI'
      Description = 'Man Route List'
      buttoncolor = clWhite
    end
    object actSalesPrintInvoices: TDNMAction
      Category = 'Sales'
      Caption = 'Print Invoices'
      ImageIndex = 190
      OnExecute = AnyActionExecute
      ClassExecute = 'TInvoicesPrnGUI'
      buttoncolor = clWhite
    end
    object actSalesPrintSalesOrders: TDNMAction
      Category = 'Sales'
      Caption = 'Print Sales Orders'
      ImageIndex = 503
      OnExecute = AnyActionExecute
      ClassExecute = 'TSalesOrderPrnGUI'
      buttoncolor = clWhite
    end
    object actPurchasesSuppliersSupplier: TDNMAction
      Category = 'Purchases'
      Caption = 'Supplier'
      ImageIndex = 100
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmSupplier'
      buttoncolor = clWhite
    end
    object actPurchasesSuppliersSupplierList: TDNMAction
      Category = 'Purchases'
      Caption = 'Supplier List'
      ImageIndex = 91
      OnExecute = AnyActionExecute
      ClassExecute = 'TSupplierListGUI'
      buttoncolor = clWhite
    end
    object actPurchasesSuppliersSupplierExpressList: TDNMAction
      Category = 'Purchases'
      Caption = 'Supplier Express List'
      ImageIndex = 101
      OnExecute = AnyActionExecute
      ClassExecute = 'TSupplierExpressListGUI'
      buttoncolor = clWhite
    end
    object actPurchasesSmartOrdersSmartOrder: TDNMAction
      Category = 'Purchases'
      Caption = 'Smart Order'
      ImageIndex = 92
      OnExecute = AnyActionExecute
      ClassExecute = 'TSmartOrderGUI'
      buttoncolor = clWhite
    end
    object actPurchasesSmartOrdersSmartOrderList: TDNMAction
      Category = 'Purchases'
      Caption = 'Smart Order List'
      ImageIndex = 93
      OnExecute = AnyActionExecute
      ClassExecute = 'TSmartOrderListGUI'
      Description = 'Smart Ord List'
      buttoncolor = clWhite
    end
    object actPurchasesPurchaseOrdersPurchaseOrder: TDNMAction
      Category = 'Purchases'
      Caption = 'Purchase Order'
      ImageIndex = 290
      OnExecute = AnyActionExecute
      ClassExecute = 'TPurchaseGUI'
      buttoncolor = clWhite
    end
    object actPurchasesPurchaseOrdersPurchaseOrderList: TDNMAction
      Category = 'Purchases'
      Caption = 'Purchase Order List'
      ImageIndex = 481
      OnExecute = AnyActionExecute
      ClassExecute = 'TPurchaseOrderListGUI'
      Description = 'Purch Ord List'
      buttoncolor = clWhite
    end
    object actPurchasesPurchaseOrdersPurchaseOrderListDetail: TDNMAction
      Category = 'Purchases'
      Caption = 'Purchase Order List Detail'
      ImageIndex = 661
      OnExecute = AnyActionExecute
      ClassExecute = 'TPurchaseOrderDetailListGUI'
      Description = 'Purch Ord List Detail'
      buttoncolor = clWhite
    end
    object actPurchasesPurchaseOrdersPurchaseOrderExpressList: TDNMAction
      Category = 'Purchases'
      Caption = 'Purchase Order Express List'
      ImageIndex = 60
      OnExecute = AnyActionExecute
      ClassExecute = 'TPurchaseOrderListExpressGUI'
      Description = 'Purch Ord List'
      buttoncolor = clWhite
    end
    object actPurchasesPurchaseOrdersBackOrders: TDNMAction
      Category = 'Purchases'
      Caption = 'BackOrders'
      ImageIndex = 279
      OnExecute = AnyActionExecute
      ClassExecute = 'TBackOrdersPopupGUI'
      buttoncolor = clWhite
    end
    object actPurchasesBillsBill: TDNMAction
      Category = 'Purchases'
      Caption = 'Bill'
      ImageIndex = 19
      OnExecute = AnyActionExecute
      ClassExecute = 'TBillGUI'
      buttoncolor = clWhite
    end
    object actPurchasesBillsBillRefund: TDNMAction
      Category = 'Purchases'
      Caption = 'Credit'
      ImageIndex = 284
      OnExecute = AnyActionExecute
      ClassExecute = 'TCreditGui'
      buttoncolor = clWhite
    end
    object actPurchasesBillsBillList: TDNMAction
      Category = 'Purchases'
      Caption = 'Bill List'
      ImageIndex = 370
      OnExecute = AnyActionExecute
      ClassExecute = 'TBillListGUI'
      buttoncolor = clWhite
    end
    object actPurchasesBillsBillDetailsList: TDNMAction
      Category = 'Purchases'
      Caption = 'Bill Details List'
      ImageIndex = 371
      OnExecute = AnyActionExecute
      ClassExecute = 'TBillDetailsListGUI'
      buttoncolor = clWhite
    end
    object actPurchasesReturnAuthorityReturnAuthority: TDNMAction
      Category = 'Purchases'
      Caption = 'Return Authority'
      ImageIndex = 396
      OnExecute = AnyActionExecute
      ClassExecute = 'TReturnAGUI'
      Description = 'Return Auth'
      buttoncolor = clWhite
    end
    object actPurchasesReturnAuthorityReturnAuthorityList: TDNMAction
      Category = 'Purchases'
      Caption = 'Return Authority List'
      ImageIndex = 397
      OnExecute = AnyActionExecute
      ClassExecute = 'TReturnAuthListGUI'
      Description = 'Ret Auth List'
      buttoncolor = clWhite
    end
    object actbinLocation: TDNMAction
      Category = 'Inventory'
      Caption = 'Bin Location'
      ImageIndex = 247
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmbinLocations'
      buttoncolor = clWhite
    end
    object actBinLocationList: TDNMAction
      Category = 'Inventory'
      Caption = 'Bin Location List'
      ImageIndex = 243
      OnExecute = AnyActionExecute
      ClassExecute = 'TBinLocationListGUI'
      buttoncolor = clWhite
    end
    object actInventProductsProduct: TDNMAction
      Category = 'Inventory'
      Caption = 'Product'
      ImageIndex = 66
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmParts'
      buttoncolor = clWhite
    end
    object actInventProductsProductsExpressBatchbinSNList: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Batch/Bin/SN List'
      ImageIndex = 273
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductBatchbinSNListGUI'
      Description = 'Product Batch/Bin/SN List'
      buttoncolor = clWhite
    end
    object actInventProductsProductCommissionList: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Commission List'
      ImageIndex = 252
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductCommissionListGUI'
      Description = 'Prod Com Lst'
      buttoncolor = clWhite
    end
    object actInventProductsProductRewardPoints: TDNMAction
      Category = 'CRM'
      Caption = 'Loyalty Program'
      ImageIndex = 559
      ClassExecute = 'TfmRewardPoint'
      Description = 'Prod Rew Pts'
      buttoncolor = clWhite
    end
    object actInventProductsProductRewardPointsList: TDNMAction
      Category = 'Inventory'
      Caption = 'Loyalty Program List'
      ImageIndex = 374
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductRewardPointsGUI'
      Description = 'Prd Rwd Pt Lst'
      buttoncolor = clWhite
    end
    object actInventProductsBatchProductCreator: TDNMAction
      Category = 'Inventory'
      Caption = 'Batch Product Creator'
      ImageIndex = 253
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmBatchParts'
      Description = 'Batch Prd Crtr'
      buttoncolor = clWhite
    end
    object actInventProductsBatchProductCodeAbbreviator: TDNMAction
      Category = 'Inventory'
      Caption = 'Batch Product Code Abbreviator'
      ImageIndex = 228
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductCodeAbbrevGUI'
      Description = 'Batch Prod Abb'
      buttoncolor = clWhite
    end
    object actInventStockStockTransferList: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Stock Transfer List'
      ImageIndex = 565
      OnExecute = AnyActionExecute
      ClassExecute = 'TStockTransferEntryListGUI'
      Description = 'Stk Trans List'
      buttoncolor = 11579647
    end
    object actInventStockStockAdjustmentbin: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Bin Adjustment'
      ImageIndex = 589
      OnExecute = AnyActionExecute
      OnHint = actStockTransferEntryBinHint
      ClassExecute = 'TfmStockAdjustEntryBins'
      Description = 'Stock Adjustment - Bin'
      buttoncolor = 14024618
    end
    object actInventStockStockAdjustmentsn: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Serial Number Adjustment'
      ImageIndex = 573
      OnExecute = AnyActionExecute
      OnHint = actStockTransferEntryBinHint
      ClassExecute = 'tfmStockAdjustEntrySN'
      Description = 'Stock Adjustment - SN'
      buttoncolor = 14024618
    end
    object actInventStockStockAdjustmentbatchList: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Batch Adjustment List'
      ImageIndex = 630
      OnExecute = AnyActionExecute
      ClassExecute = 'TStockAdjustEntryListBatchGUI'
      Description = 'Stock Adjustment - Batch List'
      buttoncolor = 14024618
    end
    object actInventPriceUpdate: TDNMAction
      Category = 'Inventory'
      Caption = 'Data Update'
      ImageIndex = 547
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmDataUpdator'
      buttoncolor = clWhite
    end
    object actoldInventPriceUpdate: TDNMAction
      Category = 'Inventory'
      Caption = 'Data Update(Old)'
      ImageIndex = 548
      Visible = False
      OnExecute = AnyActionExecute
      ClassExecute = 'TPriceUpdateGUI'
      buttoncolor = clWhite
    end
    object actInventAutoReOrder: TDNMAction
      Category = 'Inventory'
      Caption = 'Auto Re-Order'
      ImageIndex = 356
      OnExecute = AnyActionExecute
      ClassExecute = 'TAutoReorderGUI'
      buttoncolor = clWhite
    end
    object actInventCustomerTypePriceList: TDNMAction
      Category = 'Inventory'
      Caption = 'Customer Type Price List'
      ImageIndex = 221
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmPriceListGUI'
      Description = 'Cust Prc Lst'
      buttoncolor = clWhite
    end
    object actInventCustomerPriceList: TDNMAction
      Category = 'Inventory'
      Caption = 'Customer Price List'
      ImageIndex = 668
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomerPriceListGUI'
      Description = 'Cust Price List'
      buttoncolor = clWhite
    end
    object actInventPrintPickSlips: TDNMAction
      Category = 'Inventory'
      Caption = 'Print Pick Slips'
      ImageIndex = 65
      OnExecute = AnyActionExecute
      ClassExecute = 'TPickSlipGUI'
      Description = 'Print Pk Slips'
      buttoncolor = clWhite
    end
    object actInventBarcodePickingAssembly: TDNMAction
      Category = 'Inventory'
      Caption = 'Barcode Picking'
      ImageIndex = 134
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmBarcodePicking'
      buttoncolor = clWhite
    end
    object actInventBarcodePickingAssemblyList: TDNMAction
      Category = 'Inventory'
      Caption = 'Barcode Picking List'
      ImageIndex = 133
      OnExecute = AnyActionExecute
      ClassExecute = 'TBarcodePickListGUI'
      Description = 'Brcde Pck Lst'
      buttoncolor = clWhite
    end
    object actInventPickedSalesList: TDNMAction
      Category = 'Inventory'
      Caption = 'Pick/Pack Sales List'
      ImageIndex = 478
      OnExecute = AnyActionExecute
      ClassExecute = 'TPickedSalesListGUI'
      buttoncolor = clWhite
    end
    object actInventPickSlipManifest: TDNMAction
      Category = 'Inventory'
      Caption = 'Pick List (Done)'
      ImageIndex = 480
      OnExecute = AnyActionExecute
      ClassExecute = 'TPickSlipManifestGUI'
      buttoncolor = clWhite
    end
    object actInventProductSales: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Sales Projection'
      ImageIndex = 270
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductSalesListFormSoldGUI'
      buttoncolor = clWhite
    end
    object actInventProductSalesnotSold: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Sales Projection(Not Sold)'
      ImageIndex = 562
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductSalesListFormNotSoldGUI'
      buttoncolor = clWhite
    end
    object actInventUnitsOfMeasure: TDNMAction
      Category = 'Inventory'
      Caption = 'Units Of Measure'
      ImageIndex = 211
      OnExecute = AnyActionExecute
      ClassExecute = 'TUnitsOfMeasureGUI'
      Description = 'Units Of Msr'
      buttoncolor = clWhite
    end
    object actInventUnitsOfMeasureList: TDNMAction
      Category = 'Inventory'
      Caption = 'Units Of Measure List'
      ImageIndex = 182
      OnExecute = AnyActionExecute
      ClassExecute = 'TUnitsOfMeasureListGUI'
      Description = 'Units Msr Lst'
      buttoncolor = clWhite
    end
    object actPaymentsCustomerPayment: TDNMAction
      Category = 'Payments'
      Caption = 'Customer Payment'
      ImageIndex = 30
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmCustPayments'
      Description = 'Cust Payment'
      buttoncolor = clWhite
    end
    object actPaymentsCustomerPaymentList: TDNMAction
      Category = 'Payments'
      Caption = 'Customer Payment List'
      ImageIndex = 31
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustPaymentListGUI'
      Description = 'Cust Pmnt List'
      buttoncolor = clWhite
    end
    object actPaymentsCustomerPrepayment: TDNMAction
      Category = 'Payments'
      Caption = 'Customer Prepayment'
      ImageIndex = 172
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmCustPrepayments'
      Description = 'Cust Prepay'
      buttoncolor = clWhite
    end
    object actPaymentsCustomerPrepaymentList: TDNMAction
      Category = 'Payments'
      Caption = 'Customer Prepayment List'
      ImageIndex = 173
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustPrepaymentListGUI'
      Description = 'Cst Prepay Lst'
      buttoncolor = clWhite
    end
    object actPaymentsBulkPaySuppliers: TDNMAction
      Category = 'Payments'
      Caption = 'Bulk Pay Suppliers'
      ImageIndex = 534
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmBulkPaySuppliers'
      Description = 'Bulk Pay Supps'
      buttoncolor = clWhite
    end
    object actPaymentsReceivedBulkPayments: TDNMAction
      Category = 'Payments'
      Caption = 'Received Bulk Payments'
      ImageIndex = 231
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmBulkReceiveCustomersGUI'
      Description = 'Rec Blk Pmnts'
      buttoncolor = clWhite
    end
    object actPaymentsCustomerPaymentExpressList: TDNMAction
      Category = 'Payments'
      Caption = 'Customer Payment Express'
      ImageIndex = 736
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomerPaymentExpressListGUI'
      Description = 'Customer Payment Express'
      buttoncolor = clWhite
    end
    object actPaymentsSupplierPayment: TDNMAction
      Category = 'Payments'
      Caption = 'Supplier Payment'
      ImageIndex = 102
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmSuppPayments'
      Description = 'Supp Paymnt'
      buttoncolor = clWhite
    end
    object actPaymentsSupplierPaymentList: TDNMAction
      Category = 'Payments'
      Caption = 'Supplier Payment List'
      ImageIndex = 103
      OnExecute = AnyActionExecute
      ClassExecute = 'TSuppPaymentListGUI'
      Description = 'Supp Pmnt Lst'
      buttoncolor = clWhite
    end
    object actPaymentsSupplierPrepayment: TDNMAction
      Category = 'Payments'
      Caption = 'Supplier Prepayment'
      ImageIndex = 167
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmSuppPrepayments'
      Description = 'Supp Prepay'
      buttoncolor = clWhite
    end
    object actPaymentsSuppPrepaymentList: TDNMAction
      Category = 'Payments'
      Caption = 'Supplier Prepayment List'
      ImageIndex = 181
      OnExecute = AnyActionExecute
      ClassExecute = 'TSuppPrepaymentListGUI'
      Description = 'Supp Prepy Lst'
      buttoncolor = clWhite
    end
    object actPaymentsDepositEntry: TDNMAction
      Category = 'Banking'
      Caption = 'Deposit Entry'
      ImageIndex = 24
      OnExecute = AnyActionExecute
      ClassExecute = 'TDepositEntryGUI'
      buttoncolor = clWhite
    end
    object actPaymentsToBeDeposited: TDNMAction
      Category = 'Payments'
      Caption = 'To Be Deposited'
      ImageIndex = 76
      OnExecute = AnyActionExecute
      ClassExecute = 'TDepositGUI'
      buttoncolor = clWhite
    end
    object actPaymentsDepositedList: TDNMAction
      Category = 'Payments'
      Caption = 'Deposited List'
      ImageIndex = 276
      OnExecute = AnyActionExecute
      ClassExecute = 'TDepositedListGUI'
      buttoncolor = clWhite
    end
    object actPaymentsCheque: TDNMAction
      Category = 'Banking'
      Caption = 'Cheque'
      ImageIndex = 25
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmCheque'
      buttoncolor = clWhite
    end
    object actPaymentsChequeList: TDNMAction
      Category = 'Banking'
      Caption = 'Cheque List'
      ImageIndex = 170
      OnExecute = AnyActionExecute
      ClassExecute = 'TChequeListGUI'
      buttoncolor = clWhite
    end
    object actPaymentsChequeDetailsList: TDNMAction
      Category = 'Payments'
      Caption = 'Cheque Details List'
      ImageIndex = 488
      OnExecute = AnyActionExecute
      ClassExecute = 'TChequeDetailsListGUI'
      buttoncolor = clWhite
    end
    object actPaymentsReconcile: TDNMAction
      Category = 'Banking'
      Caption = 'Reconcile'
      ImageIndex = 75
      OnExecute = actPaymentsReconcileExecute
      ClassExecute = 'TReconciliationGUI'
      buttoncolor = clWhite
    end
    object actPaymentsReconciliationList: TDNMAction
      Category = 'Banking'
      Caption = 'Reconciliation List'
      ImageIndex = 494
      OnExecute = AnyActionExecute
      ClassExecute = 'TReconListGUI'
      Description = 'Recon List'
      buttoncolor = clWhite
    end
    object actPaymentsStatements: TDNMAction
      Category = 'Payments'
      Caption = 'Statements List'
      ImageIndex = 261
      OnExecute = AnyActionExecute
      ClassExecute = 'TStatementListGUI'
      buttoncolor = clWhite
    end
    object actPaymentsPrintStatements: TDNMAction
      Category = 'Payments'
      Caption = 'Print Statements'
      ImageIndex = 147
      OnExecute = AnyActionExecute
      ClassExecute = 'TPrintStatement'
      buttoncolor = clWhite
    end
    object actPaymentsAccountsPayableReport: TDNMAction
      Category = 'Payments'
      Caption = 'Accounts Payable Report'
      ImageIndex = 3
      OnExecute = AnyActionExecute
      ClassExecute = 'TAccountsPayListGUI'
      Description = 'Accts Pay Rep'
      buttoncolor = clWhite
    end
    object actPaymentsAccountsReceivableReport: TDNMAction
      Category = 'Payments'
      Caption = 'Accounts Receivable Report'
      ImageIndex = 4
      OnExecute = AnyActionExecute
      ClassExecute = 'TAccountsReceiveListGUI'
      Description = 'Acc/Receive'
      buttoncolor = clWhite
    end
    object actPaymentsBankAccountReport: TDNMAction
      Category = 'Banking'
      Caption = 'Bank Account Report'
      ImageIndex = 278
      OnExecute = AnyActionExecute
      ClassExecute = 'TBankAccountListGUI'
      Description = 'Bank Acct Rep'
      buttoncolor = clWhite
    end
    object actPaymentsTransactionJournal: TDNMAction
      Category = 'Payments'
      Caption = 'Transaction Journal'
      ImageIndex = 329
      OnExecute = AnyActionExecute
      ClassExecute = 'TTransactionListGUI'
      Description = 'Trans Journal'
      buttoncolor = clWhite
    end
    object actPaymentsTransactionJournalExpress: TDNMAction
      Category = 'Payments'
      Caption = 'Transaction Journal (Express)'
      ImageIndex = 329
      OnExecute = AnyActionExecute
      ClassExecute = 'TTransactionExpressListGUI'
      Description = 'Trans Journal (Express)'
      buttoncolor = clWhite
    end
    object actEmployeePayrollPayStaff: TDNMAction
      Category = 'Payroll'
      Caption = 'Pay Staff'
      ImageIndex = 58
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmPaySummary'
      buttoncolor = clWhite
    end
    object actEmployeePayrollPayHistory: TDNMAction
      Category = 'Payroll'
      Caption = 'Pay History'
      ImageIndex = 55
      OnExecute = AnyActionExecute
      ClassExecute = 'TPayListingGUI'
      buttoncolor = clWhite
    end
    object actEmployeePayslist: TDNMAction
      Category = 'Employee'
      Caption = 'Rate and Leave Accruals'
      ImageIndex = 56
      OnExecute = AnyActionExecute
      ClassExecute = 'TRateandLeaveAccrualsGUI'
      buttoncolor = clWhite
    end
    object actEmployeePayrollNewAllowance: TDNMAction
      Category = 'Payroll'
      Caption = 'Allowance'
      ImageIndex = 354
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmAllowances'
      buttoncolor = clWhite
    end
    object actEmployeePayrollAllowances: TDNMAction
      Category = 'Payroll'
      Caption = 'Allowances List'
      ImageIndex = 6
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmAllowanceList'
      buttoncolor = clWhite
    end
    object actEmployeePayrollNewAward: TDNMAction
      Category = 'Payroll'
      Caption = 'Award'
      ImageIndex = 11
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmAwards'
      buttoncolor = clWhite
    end
    object actEmployeePayrollAwards: TDNMAction
      Category = 'Payroll'
      Caption = 'Awards List'
      ImageIndex = 360
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmAwardsList'
      buttoncolor = clWhite
    end
    object actEmployeePayrollNewBankCode: TDNMAction
      Category = 'Employee'
      Caption = 'Bank Code'
      ImageIndex = 362
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmBankCodes'
      buttoncolor = clWhite
    end
    object actEmployeePayrollBankCodes: TDNMAction
      Category = 'Payroll'
      Caption = 'Bank Code List'
      ImageIndex = 13
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmBankCodeList'
      buttoncolor = clWhite
    end
    object actEmployeePayrollNewDeduction: TDNMAction
      Category = 'Payroll'
      Caption = 'Deduction'
      ImageIndex = 33
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmDeductions'
      buttoncolor = clWhite
    end
    object actEmployeePayrollDeductions: TDNMAction
      Category = 'Payroll'
      Caption = 'Deductions List'
      ImageIndex = 34
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmDeductionList'
      Description = 'Deduct List'
      buttoncolor = clWhite
    end
    object actEmployeePayrollNewPayRate: TDNMAction
      Category = 'Employee'
      Caption = 'Pay Rate'
      ImageIndex = 163
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmPayRates'
      buttoncolor = clWhite
    end
    object actEmployeePayrollPayRates: TDNMAction
      Category = 'Payroll'
      Caption = 'Pay Rate List'
      ImageIndex = 535
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmPayRateList'
      buttoncolor = clWhite
    end
    object actEmployeePayrollNewTaxScale: TDNMAction
      Category = 'Employee'
      Caption = 'Tax Scale'
      ImageIndex = 46
      OnExecute = AnyActionExecute
      ClassExecute = 'TTaxScale'
      buttoncolor = clWhite
    end
    object actEmployeePayrollTaxScales: TDNMAction
      Category = 'Payroll'
      Caption = 'Tax Scales List'
      ImageIndex = 306
      OnExecute = AnyActionExecute
      ClassExecute = 'TTaxScaleList'
      Description = 'Tax Scales Lst'
      buttoncolor = clWhite
    end
    object actEmployeePayrollImportTaxScales: TDNMAction
      Category = 'Employee'
      Caption = 'Import Tax Scales'
      ImageIndex = 251
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmImportTaxScalesGUI'
      Description = 'Imp Tax Scales'
      buttoncolor = clWhite
    end
    object actEmployeePayrollLeaveAccruedList: TDNMAction
      Category = 'Employee'
      Caption = 'Leave Accrued List'
      ImageIndex = 108
      OnExecute = AnyActionExecute
      ClassExecute = 'TLeaveAccruedListGUI'
      Description = 'Leave Acc List'
      buttoncolor = clWhite
    end
    object actEmployeePayrollLeaveTakenList: TDNMAction
      Category = 'Employee'
      Caption = 'Leave Taken List'
      ImageIndex = 161
      OnExecute = AnyActionExecute
      ClassExecute = 'TLeaveListGUI'
      Description = 'Leave Take Lst'
      buttoncolor = clWhite
    end
    object actEmployeePayrollPayrollJobsList: TDNMAction
      Category = 'Employee'
      Caption = 'Payroll Job List'
      ImageIndex = 207
      OnExecute = AnyActionExecute
      ClassExecute = 'TPayJobListGUI'
      Description = 'Payroll Jb Lst'
      buttoncolor = clWhite
    end
    object actEmployeePayrollEmployeeServices: TDNMAction
      Category = 'Payroll'
      Caption = 'Services - Employee'
      ImageIndex = 265
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmPayrollServicesGUI'
      Description = 'Employee Srvcs'
      buttoncolor = clWhite
    end
    object actEmployeePayrollPAYGSummary: TDNMAction
      Category = 'Payroll'
      Caption = 'PAYG Payment Summary'
      ImageIndex = 368
      OnExecute = AnyActionExecute
      ClassExecute = 'TPAYGPaymentSummaryListGUI'
      Description = 'PAYG Pmnt Sum'
      buttoncolor = clWhite
    end
    object actEmployeeRep: TDNMAction
      Category = 'Employee'
      Caption = 'Rep'
      ImageIndex = 404
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmRep'
      buttoncolor = clWhite
    end
    object actEmployeeRepList: TDNMAction
      Category = 'Employee'
      Caption = 'Rep List'
      ImageIndex = 81
      OnExecute = AnyActionExecute
      ClassExecute = 'TRepListGUI'
      buttoncolor = clWhite
    end
    object actEmployeeToDo: TDNMAction
      Category = 'Employee'
      Caption = 'To Do'
      ImageIndex = 111
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmToDo'
      buttoncolor = clWhite
    end
    object actEmployeeEmployee: TDNMAction
      Category = 'Employee'
      Caption = 'Employee'
      ImageIndex = 38
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmEmployee'
      buttoncolor = clWhite
    end
    object actEmployeeEmployeeAnalysis: TDNMAction
      Category = 'Employee'
      Caption = 'Employee Analysis'
      ImageIndex = 405
      OnExecute = AnyActionExecute
      ClassExecute = 'TEmployeeAnalysisListGUI'
      Description = 'Emp Analysis'
      buttoncolor = clWhite
    end
    object actEmployeeEmployeeList: TDNMAction
      Category = 'Employee'
      Caption = 'Employee List'
      ImageIndex = 39
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmEmployeeList'
      buttoncolor = clWhite
    end
    object actEmployeeTerminateEmployee: TDNMAction
      Category = 'Employee'
      Caption = 'Terminate Employee'
      Enabled = False
      ImageIndex = 107
      Visible = False
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmEmployeeTerminateGUI'
      Description = 'Terminate Emp'
      buttoncolor = clWhite
    end
    object actEmployeeGlobalList: TDNMAction
      Category = 'Employee'
      Caption = 'Global List'
      ImageIndex = 42
      OnExecute = actEmployeeGlobalListExecute
      ClassExecute = 'TGlobalListSearchFrm'
      buttoncolor = clWhite
    end
    object actEmployeeRepServices: TDNMAction
      Category = 'Employee'
      Caption = 'Services - Rep'
      ImageIndex = 82
      OnExecute = AnyActionExecute
      ClassExecute = 'TRepServicesListGUI'
      buttoncolor = clWhite
    end
    object actEmployeeRoster: TDNMAction
      Category = 'Employee'
      Caption = 'Roster'
      ImageIndex = 482
      OnExecute = AnyActionExecute
      ClassExecute = 'TRosterCalGUI'
      buttoncolor = clWhite
    end
    object actEmployeeRosterList: TDNMAction
      Category = 'Employee'
      Caption = 'Roster List'
      ImageIndex = 239
      OnExecute = AnyActionExecute
      ClassExecute = 'TRosterListGUI'
      buttoncolor = clWhite
    end
    object actEmployeeClockOn: TDNMAction
      Category = 'Employee'
      Caption = 'Clock On'
      ImageIndex = 155
      OnExecute = AnyActionExecute
      ClassExecute = 'TClockOnGUI'
      buttoncolor = clWhite
    end
    object actEmployeeResetPersonalTabs: TDNMAction
      Category = 'Employee'
      Caption = 'Reset Personal Tabs'
      ImageIndex = 208
      OnExecute = actEmployeeResetPersonalTabsExecute
      Description = 'Reset Tabs'
      buttoncolor = clWhite
    end
    object actFixedAssetsFixedAsset: TDNMAction
      Category = 'FixedAssets'
      Caption = 'Fixed Asset'
      ImageIndex = 124
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmFixedAsset'
      buttoncolor = clWhite
    end
    object actFixedAssetsFixedAssetsList: TDNMAction
      Category = 'FixedAssets'
      Caption = 'Fixed Assets List'
      ImageIndex = 48
      OnExecute = AnyActionExecute
      ClassExecute = 'TFixedAssetsListGUI'
      Description = 'Fixed Asst Lst'
      buttoncolor = clWhite
    end
    object actFixedAssetsFixedAssetType: TDNMAction
      Category = 'FixedAssets'
      Caption = 'Fixed Asset Type'
      ImageIndex = 126
      OnExecute = AnyActionExecute
      ClassExecute = 'TFixedAssetTypeGUI'
      Description = 'Fixed Asst Typ'
      buttoncolor = clWhite
    end
    object actFixedAssetsFixedAssetTypesList: TDNMAction
      Category = 'FixedAssets'
      Caption = 'Fixed Asset Types List'
      ImageIndex = 127
      OnExecute = AnyActionExecute
      ClassExecute = 'TFixedAssetTypeListGUI'
      Description = 'Fxd Asst Typ Ls'
      buttoncolor = clWhite
    end
    object actFixedAssetsCheckWarrantiesInsurancePolicy: TDNMAction
      Category = 'FixedAssets'
      Caption = 'Warranties / Insurance Policy Report'
      ImageIndex = 128
      OnExecute = AnyActionExecute
      ClassExecute = 'TCheckWarranty_InsurancePolicyGUI'
      Description = 'Chk Warr/Ins'
      buttoncolor = clWhite
    end
    object actFixedAssetsServiceLog: TDNMAction
      Category = 'FixedAssets'
      Caption = 'Service Log'
      ImageIndex = 123
      OnExecute = AnyActionExecute
      ClassExecute = 'TServiceLogGUI'
      buttoncolor = clWhite
    end
    object actFixedAssetsServiceLogList: TDNMAction
      Category = 'FixedAssets'
      Caption = 'Service Log List'
      ImageIndex = 120
      OnExecute = AnyActionExecute
      ClassExecute = 'TServiceLogListGUI'
      DefaultPage = 'Service Log Lst'
      buttoncolor = clWhite
    end
    object actAccountsAccount: TDNMAction
      Category = 'Accounts'
      Caption = 'Account'
      ImageIndex = 1
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmChartOfAccounts'
      buttoncolor = clWhite
    end
    object actAccountsAccountsList: TDNMAction
      Category = 'Accounts'
      Caption = 'Accounts List'
      ImageIndex = 2
      OnExecute = actAccountsAccountsListExecute
      buttoncolor = clWhite
    end
    object actAccountsAccountTypeList: TDNMAction
      Category = 'Accounts'
      Caption = 'Account Type List'
      ImageIndex = 12
      OnExecute = AnyActionExecute
      ClassExecute = 'TAccountTypesListGUI'
      Description = 'Acc Type List'
      buttoncolor = clWhite
    end
    object actAccountsDepartment: TDNMAction
      Category = 'Accounts'
      Caption = 'Department'
      ImageIndex = 277
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmClass'
      buttoncolor = clWhite
    end
    object actAccountsDepartmentsList: TDNMAction
      Category = 'Accounts'
      Caption = 'Departments List'
      ImageIndex = 67
      OnExecute = AnyActionExecute
      ClassExecute = 'TClassListGUI'
      Description = 'Depts List'
      buttoncolor = clWhite
    end
    object actAccountsTaxCode: TDNMAction
      Category = 'Accounts'
      Caption = 'Tax Code'
      ImageIndex = 166
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmTaxcode'
      buttoncolor = clWhite
    end
    object actAccountsTaxCodeList: TDNMAction
      Category = 'Accounts'
      Caption = 'Tax Code List'
      ImageIndex = 572
      OnExecute = AnyActionExecute
      ClassExecute = 'TTaxCodeListGUI'
      buttoncolor = clWhite
    end
    object actTaxCodeDetailList: TDNMAction
      Category = 'Accounts'
      Caption = 'Tax Code List (Details)'
      ImageIndex = 572
      OnExecute = AnyActionExecute
      ClassExecute = 'TTaxCodeDetailListGUI'
      buttoncolor = clWhite
    end
    object actAccountsTermsList: TDNMAction
      Category = 'Accounts'
      Caption = 'Terms List'
      ImageIndex = 105
      OnExecute = AnyActionExecute
      ClassExecute = 'TTermsListGUI'
      buttoncolor = clWhite
    end
    object actAccountsShipping: TDNMAction
      Category = 'Accounts'
      Caption = 'Shipping'
      ImageIndex = 157
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmShipping'
      buttoncolor = clWhite
    end
    object actAccountsShippingList: TDNMAction
      Category = 'Accounts'
      Caption = 'Shipping List'
      ImageIndex = 179
      OnExecute = AnyActionExecute
      ClassExecute = 'TShippingListGUI'
      buttoncolor = clWhite
    end
    object actAccountsForeignExchangeRate: TDNMAction
      Category = 'Accounts'
      Caption = 'Foreign Exchange Rate'
      ImageIndex = 145
      OnExecute = AnyActionExecute
      ClassExecute = 'TForeignExchangeRateGUI'
      Description = 'Fgn Exch Rate'
      buttoncolor = clWhite
    end
    object actAccountsForeignExchangeRatesList: TDNMAction
      Category = 'Accounts'
      Caption = 'Foreign Exchange Rates List'
      ImageIndex = 36
      OnExecute = AnyActionExecute
      ClassExecute = 'TForeignExchangeRatesListGUI'
      Description = 'Fgn Ex Rts Lst'
      buttoncolor = clWhite
    end
    object actAccountsForeignExchangeHistoryList: TDNMAction
      Category = 'Accounts'
      Caption = 'Foreign Exchange History List'
      ImageIndex = 215
      OnExecute = AnyActionExecute
      ClassExecute = 'TForeignExchangeHistoryListGUI'
      Description = 'Fgn Ex Hst Lst'
      buttoncolor = clWhite
    end
    object actAccountsMemorisedTransactionList: TDNMAction
      Category = 'Accounts'
      Caption = 'Memorised Transaction List'
      ImageIndex = 176
      OnExecute = AnyActionExecute
      ClassExecute = 'TMemTransListGUI'
      Description = 'Mem Trans List'
      buttoncolor = clWhite
    end
    object actAccountsJournalEntry: TDNMAction
      Category = 'Accounts'
      Caption = 'Journal Entry'
      ImageIndex = 49
      OnExecute = AnyActionExecute
      ClassExecute = 'TJournalEntryGUI'
      buttoncolor = clWhite
    end
    object actAccountsJournalEntryList: TDNMAction
      Category = 'Accounts'
      Caption = 'Journal Entry List'
      ImageIndex = 89
      OnExecute = AnyActionExecute
      ClassExecute = 'TJournalListGUI'
      Description = 'Journ Ent Lst'
      buttoncolor = clWhite
    end
    object actAccountsJournalEntries: TDNMAction
      Category = 'Accounts'
      Caption = 'Journal Entries'
      ImageIndex = 89
      OnExecute = AnyActionExecute
      ClassExecute = 'TJournalEnrtiesGUI'
      Description = 'Journ Entries'
      buttoncolor = clWhite
    end
    object actAccountsTrialBalance: TDNMAction
      Category = 'Accounts'
      Caption = 'Trial Balance'
      ImageIndex = 467
      OnExecute = AnyActionExecute
      ClassExecute = 'TTrialBalanceGUI'
      buttoncolor = clWhite
    end
    object actAccountsBalanceSheet: TDNMAction
      Category = 'Accounts'
      Caption = 'Balance Sheet'
      ImageIndex = 363
      OnExecute = AnyActionExecute
      ClassExecute = 'TBalanceSheetGUI'
      buttoncolor = clWhite
    end
    object actAccountsProfitAndLoss: TDNMAction
      Category = 'Accounts'
      Caption = 'Profit And Loss'
      ImageIndex = 390
      OnExecute = AnyActionExecute
      ClassExecute = 'TProfitandLossGUI'
      buttoncolor = clWhite
    end
    object actAccountsjobProfitAndLoss: TDNMAction
      Category = 'Accounts'
      Caption = 'Job Profit And Loss'
      ImageIndex = 391
      OnExecute = AnyActionExecute
      ClassExecute = 'TJobProfitansLossGUI'
      buttoncolor = clWhite
    end
    object actAccountsProfitAndLossByPeriod: TDNMAction
      Category = 'Accounts'
      Caption = 'Profit And Loss (By Period)'
      ImageIndex = 70
      OnExecute = AnyActionExecute
      ClassExecute = 'TProfitandLossByPeriodGUI'
      Description = 'P & L (Period)'
      buttoncolor = clWhite
    end
    object actAccountsElectronicFundsTransfer: TDNMAction
      Category = 'Accounts'
      Caption = 'Electronic Funds Transfer'
      ImageIndex = 63
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmABAExportGUI'
      Description = 'EFT'
      buttoncolor = clWhite
    end
    object actAccountsRefreshBatchTransaction: TDNMAction
      Category = 'Accounts'
      Caption = 'Refresh Batch Transaction'
      ImageIndex = 248
      OnExecute = actAccountsRefreshBatchTransactionExecute
      Description = 'Ref Btch Trans'
      buttoncolor = clWhite
    end
    object actReportsAccounts: TDNMAction
      Category = 'Reports'
      Caption = 'Accounts Reports'
      ImageIndex = 141
      OnExecute = actReportsAccountsExecute
      ClassExecute = 'TfrmReportSelectorGUI'
      Description = 'Accounts Rep'
      buttoncolor = clWhite
    end
    object actReportsAppointments: TDNMAction
      Category = 'Reports'
      Caption = 'Appointment Reports'
      ImageIndex = 141
      OnExecute = actReportsAppointmentsExecute
      ClassExecute = 'TfrmReportSelectorGUI'
      Description = 'Appts Report'
      buttoncolor = clWhite
    end
    object actReportsBanking: TDNMAction
      Category = 'Reports'
      Caption = 'Banking Reports'
      ImageIndex = 141
      OnExecute = actReportsBankingExecute
      ClassExecute = 'TfrmReportSelectorGUI'
      Description = 'Banking Report'
      buttoncolor = clWhite
    end
    object actEmployeeEmployeeSummary: TDNMAction
      Category = 'Employee'
      Caption = 'Employee Summary'
      ImageIndex = 301
      OnExecute = AnyActionExecute
      ClassExecute = 'TEmployeeReportGUI'
      Description = 'Employee Sum'
      buttoncolor = clWhite
    end
    object actReportsFixedAssets: TDNMAction
      Category = 'Reports'
      Caption = 'Fixed Assets Reports'
      ImageIndex = 141
      OnExecute = actReportsFixedAssetsExecute
      ClassExecute = 'TfrmReportSelectorGUI'
      buttoncolor = clWhite
    end
    object actReportsHospitality: TDNMAction
      Category = 'Reports'
      Caption = 'Hospitality Reports'
      ImageIndex = 141
      Visible = False
      ClassExecute = 'TfrmReportSelectorGUI'
      buttoncolor = clWhite
    end
    object actReportsInventory: TDNMAction
      Category = 'Reports'
      Caption = 'Inventory Reports'
      ImageIndex = 141
      OnExecute = actReportsInventoryExecute
      ClassExecute = 'TfrmReportSelectorGUI'
      Description = 'Inventory Rep'
      buttoncolor = clWhite
    end
    object actReportsPayments: TDNMAction
      Category = 'Reports'
      Caption = 'Payments Report'
      ImageIndex = 141
      OnExecute = actReportsPaymentsExecute
      ClassExecute = 'TfrmReportSelectorGUI'
      Description = 'Payments Rep'
      buttoncolor = clWhite
    end
    object actReportsPayroll: TDNMAction
      Category = 'Reports'
      Caption = 'Payroll Reports'
      ImageIndex = 141
      OnExecute = actReportsPayrollExecute
      ClassExecute = 'TfrmReportSelectorGUI'
      buttoncolor = clWhite
    end
    object actReportsPurchases: TDNMAction
      Category = 'Reports'
      Caption = 'Purchases Report'
      ImageIndex = 141
      OnExecute = actReportsPurchasesExecute
      ClassExecute = 'TfrmReportSelectorGUI'
      Description = 'Purchases Rep'
      buttoncolor = clWhite
    end
    object actReportsSales: TDNMAction
      Category = 'Reports'
      Caption = 'All Sales Reports'
      ImageIndex = 141
      OnExecute = actReportsSalesExecute
      ClassExecute = 'TfrmReportSelectorGUI'
      buttoncolor = clWhite
    end
    object actReportsTemplates: TDNMAction
      Category = 'Reports'
      Caption = 'Templates'
      ImageIndex = 324
      OnExecute = AnyActionExecute
      ClassExecute = 'TReportTemplateGUI'
      buttoncolor = clWhite
    end
    object actReportsCustomReports: TDNMAction
      Category = 'Reports'
      Caption = 'Custom Reports'
      ImageIndex = 32
      OnExecute = actReportsCustomReportsExecute
      ClassExecute = 'TEmployeeReportsGUI'
      buttoncolor = clWhite
    end
    object actWindowTiled: TDNMAction
      Category = 'Window'
      Caption = 'Tiled'
      ImageIndex = 413
      OnExecute = actWindowTiledExecute
      buttoncolor = clWhite
    end
    object actWindowCascade: TDNMAction
      Category = 'Window'
      Caption = 'Cascade'
      ImageIndex = 412
      OnExecute = actWindowCascadeExecute
      buttoncolor = clWhite
    end
    object actWindowArrangeIcons: TDNMAction
      Category = 'Window'
      Caption = 'Arrange Icons'
      ImageIndex = 411
      OnExecute = actWindowArrangeIconsExecute
      buttoncolor = clWhite
    end
    object actWindowCustomiseToolbar: TDNMAction
      Category = 'Window'
      Caption = 'Customise Toolbar'
      ImageIndex = 171
      OnExecute = actWindowCustomiseToolbarExecute
      buttoncolor = clWhite
    end
    object actUtilsLocations: TDNMAction
      Category = 'Utilities'
      Caption = 'Location List'
      ImageIndex = 50
      OnExecute = AnyActionExecute
      ClassExecute = 'TLocationListGUI'
      buttoncolor = clWhite
    end
    object actUtilsDbUtilsBackup: TDNMAction
      Category = 'Utilities'
      Caption = 'Backup'
      ImageIndex = 14
      OnExecute = actUtilsDBUtilsBackupExecute
      buttoncolor = clWhite
    end
    object actUtilsDbUtilsRestore: TDNMAction
      Category = 'Utilities'
      Caption = 'Restore'
      ImageIndex = 61
      OnExecute = actUtilsDBUtilsRestoreExecute
      buttoncolor = clWhite
    end
    object actUtilsDbUtilsCopy: TDNMAction
      Category = 'Utilities'
      Caption = 'Copy'
      ImageIndex = 256
      OnExecute = actUtilsDBUtilsCopyExecute
      buttoncolor = clWhite
    end
    object actUtilsDbUtilsCopyRO: TDNMAction
      Category = 'Utilities'
      Caption = 'Read-Only Copy'
      ImageIndex = 555
      OnExecute = actUtilsDbUtilsCopyROExecute
      buttoncolor = clWhite
    end
    object actUtilsDbUtilsRemove: TDNMAction
      Category = 'Utilities'
      Caption = 'Remove'
      ImageIndex = 257
      OnExecute = actUtilsDBUtilsRemoveExecute
      buttoncolor = clWhite
    end
    object actUtilsDbUtilsOptimise: TDNMAction
      Category = 'Utilities'
      Caption = 'Optimise'
      ImageIndex = 491
      OnExecute = AnyActionExecute
      ClassExecute = 'TOptimizeTablesGUI'
      buttoncolor = clWhite
    end
    object actUtilsSetupDocsPath: TDNMAction
      Category = 'Utilities'
      Caption = 'Setup Doc'#39's Path'
      ImageIndex = 426
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmDocsPath'
      Description = 'Set Doc'#39's Path'
      buttoncolor = clWhite
    end
    object actUtilsPublicHolidays: TDNMAction
      Category = 'Appointments'
      Caption = 'Public Holidays'
      ImageIndex = 18
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmPublicHolidaysGUI'
      Description = 'Public Hols'
      buttoncolor = clWhite
    end
    object actUtilsPreferences: TDNMAction
      Category = 'Utilities'
      Caption = 'Preferences'
      ImageIndex = 62
      OnExecute = actUtilsPreferencesExecute
      ClassExecute = 'TfrmPreferences'
      buttoncolor = clWhite
    end
    object actUtilsCompanyInformation: TDNMAction
      Category = 'Utilities'
      Caption = 'Company Information'
      ImageIndex = 149
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmCompanyInformation'
      Description = 'Company Info'
      buttoncolor = clWhite
    end
    object actUtilsCurrentUsers: TDNMAction
      Category = 'Utilities'
      Caption = 'Current Users'
      ImageIndex = 433
      OnExecute = actUtilsCurrentUsersExecute
      buttoncolor = clWhite
    end
    object actUtilsFaxJobsFaxSpoolList: TDNMAction
      Category = 'Utilities'
      Caption = 'Fax Spool List'
      ImageIndex = 144
      OnExecute = AnyActionExecute
      ClassExecute = 'TFaxSpoolListingGUI'
      buttoncolor = clWhite
    end
    object actUtilsFaxJobsPurgeOldFaxJobs: TDNMAction
      Category = 'Utilities'
      Caption = 'Purge Old Fax Jobs'
      ImageIndex = 138
      OnExecute = actUtilsFaxJobsPurgeOldFaxJobsExecute
      Description = 'Prg Old Fx Jbs'
      buttoncolor = clWhite
    end
    object actUtilsAuditTrailAuditTrailList: TDNMAction
      Category = 'Utilities'
      Caption = 'Audit Trail List'
      ImageIndex = 148
      OnExecute = AnyActionExecute
      ClassExecute = 'TAuditTrailListGUI'
      Description = 'Audit Trl List'
      buttoncolor = clWhite
    end
    object actUtilsAuditTrailPurgeAuditTrail: TDNMAction
      Category = 'Utilities'
      Caption = 'Purge Audit Trail'
      ImageIndex = 236
      OnExecute = actUtilsAuditTrailPurgeAuditTrailExecute
      Description = 'Prg Audit Trl'
      buttoncolor = clWhite
    end
    object actUtilsAuditTrailExportAuditTrail: TDNMAction
      Category = 'Utilities'
      Caption = 'Export Audit Trail'
      ImageIndex = 486
      OnExecute = actUtilsAuditTrailExportAuditTrailExecute
      Description = 'Exp Audit Trl'
      buttoncolor = clWhite
    end
    object actAboutUpdateNotes: TDNMAction
      Category = 'About'
      Caption = 'Update Notes'
      ImageIndex = 336
      OnExecute = actAboutUpdateNotesExecute
      buttoncolor = clWhite
    end
    object actAboutAbout: TDNMAction
      Category = 'About'
      Caption = 'About...'
      ImageIndex = 581
      OnExecute = AnyActionExecute
      ClassExecute = 'TAboutBox'
      buttoncolor = clWhite
    end
    object actFileExit: TDNMAction
      Category = 'File'
      Caption = 'Exit'
      OnExecute = actFileExitExecute
      buttoncolor = clWhite
    end
    object actReportsQuoteStatus: TDNMAction
      Category = 'Reports'
      Caption = 'Quote Status Report'
      ImageIndex = 316
      OnExecute = actReportsQuoteStatusExecute
      Description = 'Quote Stat Rep'
      buttoncolor = clWhite
    end
    object actReportsSalesOrderStatus: TDNMAction
      Category = 'Reports'
      Caption = 'Sales Order Status'
      ImageIndex = 321
      OnExecute = AnyActionExecute
      ClassExecute = 'TSalesOrderStatusReportGUI'
      Description = 'Sales Ord Stat'
      buttoncolor = clWhite
    end
    object actReportsUnPaidBills: TDNMAction
      Category = 'Reports'
      Caption = 'Unpaid Bills Report'
      ImageIndex = 295
      OnExecute = AnyActionExecute
      ClassExecute = 'TUnpaidBillGUI'
      Description = 'Unpd Bills Rep'
      buttoncolor = clWhite
    end
    object actReportsStockStatus: TDNMAction
      Category = 'Reports'
      Caption = 'Stock Status Report'
      ImageIndex = 327
      OnExecute = AnyActionExecute
      ClassExecute = 'TStockStatusReportGUI'
      Description = 'Stk Status Rep'
      buttoncolor = clWhite
    end
    object actReportsProductSalesSummary: TDNMAction
      Category = 'Reports'
      Caption = 'Product Sales Summary'
      ImageIndex = 496
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductSummaryGUI'
      Description = 'Prod Sale Summ'
      buttoncolor = clWhite
    end
    object actReportsAttributesProductSalesSummary: TDNMAction
      Category = 'Reports'
      Caption = 'Attribute Product Sales Summary'
      ImageIndex = 496
      OnExecute = AnyActionExecute
      ClassExecute = 'TAttributeProductSalesSummaryGUI'
      Description = 'Attrib Prod Sale Summ'
      buttoncolor = clWhite
    end
    object actReportsTransactionJournal: TDNMAction
      Category = 'Reports'
      Caption = 'Transaction Journal Report'
      ImageIndex = 550
      OnExecute = AnyActionExecute
      ClassExecute = 'TTransactionListGUI'
      Description = 'Trans Jnl Rep'
      buttoncolor = clWhite
    end
    object actReportsGeneralLedger: TDNMAction
      Category = 'Reports'
      Caption = 'General Ledger Report'
      ImageIndex = 227
      OnExecute = AnyActionExecute
      ClassExecute = 'TGeneralLedgerReportGUI'
      Description = 'Gen Ledger Rep'
      buttoncolor = clWhite
    end
    object actReportsJobProfitability: TDNMAction
      Category = 'Reports'
      Caption = 'Job Profitability Report'
      ImageIndex = 302
      OnExecute = AnyActionExecute
      ClassExecute = 'TJobProfitabilityforCustomerGUI'
      Description = 'Job Prof Rep'
      buttoncolor = clWhite
    end
    object actReportsSupplier: TDNMAction
      Category = 'Reports'
      Caption = 'Supplier Report'
      ImageIndex = 300
      OnExecute = AnyActionExecute
      ClassExecute = 'TSupplierReportGUI'
      buttoncolor = clWhite
    end
    object actReportsBAS: TDNMAction
      Category = 'Reports'
      Caption = 'BAS Report'
      ImageIndex = 68
      OnExecute = AnyActionExecute
      ClassExecute = 'TBASReportGUI'
      buttoncolor = clWhite
    end
    object actReportsBASList: TDNMAction
      Category = 'Reports'
      Caption = 'BAS Report List'
      ImageIndex = 168
      OnExecute = AnyActionExecute
      ClassExecute = 'TBasReturnListGUI'
      Description = 'BAS Report Lst'
      buttoncolor = clWhite
    end
    object actReportsAccountsSummary: TDNMAction
      Category = 'Reports'
      Caption = 'Summary Sheet'
      ImageIndex = 266
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmSummarySheetGUI'
      buttoncolor = clWhite
    end
    object actUtilsExportToReportDB: TDNMAction
      Category = 'Utilities'
      Caption = 'Export To Report DB'
      ImageIndex = 260
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmExportTablesSelector'
      Description = 'Exp To Rep DB'
      buttoncolor = clWhite
    end
    object actCustomImports: TDNMAction
      Category = 'Utilities'
      Caption = 'Custom Imports'
      ImageIndex = 99
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmCustomImport'
      buttoncolor = clWhite
    end
    object actEmployeeTransferDetails: TDNMAction
      Category = 'Employee'
      Caption = 'Transfer Employee Data'
      ImageIndex = 10
      OnExecute = AnyActionExecute
      ClassExecute = 'TEmployeeTransferDetails'
      Description = 'Trans Emp Data'
      buttoncolor = clWhite
    end
    object actPaymentsPrintRecipientCreatedStatement: TDNMAction
      Category = 'Payments'
      Caption = 'Print Recipient Created Statement'
      ImageIndex = 558
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmPurchaseStatementPrint'
      Description = 'Prt Rc Crtd St'
      buttoncolor = clWhite
    end
    object actEmployeeToDoList: TDNMAction
      Category = 'Employee'
      Caption = 'To Do List'
      ImageIndex = 112
      OnExecute = AnyActionExecute
      ClassExecute = 'TToDoListGUI'
      buttoncolor = clWhite
    end
    object actEmployeeAccessLevels: TDNMAction
      Category = 'Employee'
      Caption = 'Access Levels'
      ImageIndex = 762
      OnExecute = actEmployeeAccessLevelsExecute
      ClassExecute = 'TfrmAccessLevel'
      buttoncolor = clWhite
    end
    object actEmployeePersonalPreferences: TDNMAction
      Category = 'Employee'
      Caption = 'Personal Preferences'
      ImageIndex = 146
      OnExecute = actEmployeePersonalPreferencesExecute
      ClassExecute = 'TfrmPreferences'
      Description = 'Personal Prefs'
      buttoncolor = clWhite
    end
    object actSTPPreferences: TDNMAction
      Category = 'Utilities'
      Caption = 'STP Preferences'
      ImageIndex = 146
      OnExecute = actSTPPreferencesExecute
      ClassExecute = 'TfrmPreferences'
      Description = 'STP Prefs'
      buttoncolor = clWhite
    end
    object actCompanyTypes: TDNMAction
      Category = 'Sales'
      Caption = 'Company Types'
      ImageIndex = 517
      OnExecute = actSalesCRMCompanyTypesExecute
      ClassExecute = 'TfmSimpleTypes'
      buttoncolor = clWhite
    end
    object actFollowupTypes: TDNMAction
      Category = 'Sales'
      Caption = 'Follow-Up Types'
      ImageIndex = 495
      OnExecute = actSalesCRMFollowUpTypesExecute
      ClassExecute = 'TfmSimpleTypes'
      Description = 'Follow-Up Typ'
      buttoncolor = clWhite
    end
    object actFollowupResultTypes: TDNMAction
      Category = 'Sales'
      Caption = 'Follow-Up Result Types'
      ImageIndex = 137
      OnExecute = actSalesCRMFollowUpResultTypesExecute
      ClassExecute = 'TfmSimpleTypes'
      Description = 'Fllw-Up Res Typ'
      buttoncolor = clWhite
    end
    object actReminders: TDNMAction
      Category = 'Employee'
      Caption = 'Reminders '
      ImageIndex = 115
      OnExecute = actRemindersExecute
      ClassExecute = 'TReminderListGUI'
      buttoncolor = clWhite
    end
    object actBinUsageReport: TDNMAction
      Category = 'Inventory'
      Caption = 'Bin Usage Report'
      ImageIndex = 40
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmBinUsageReport'
      Description = 'Bin Use Rep'
      buttoncolor = clWhite
    end
    object actReportsSalesSummary: TDNMAction
      Category = 'Reports'
      Caption = 'Sales Summary'
      ImageIndex = 308
      OnExecute = AnyActionExecute
      ClassExecute = 'TSalesSummaryReportGUI'
      buttoncolor = clWhite
    end
    object actPaymentsChequePrn: TDNMAction
      Category = 'Payments'
      Caption = 'Print Cheques'
      ImageIndex = 294
      OnExecute = AnyActionExecute
      ClassExecute = 'TPrintchequesGUI'
      buttoncolor = clWhite
    end
    object actPaymentsEFT: TDNMAction
      Category = 'Payments'
      Caption = 'EFT '
      ImageIndex = 275
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmAbaExportGUI'
      buttoncolor = clWhite
    end
    object actAboutShowManual: TDNMAction
      Category = 'About'
      Caption = 'Show Manual'
      ImageIndex = 582
      Visible = False
      buttoncolor = clWhite
    end
    object actPaymentsAccountsReceivableNotes: TDNMAction
      Category = 'Payments'
      Caption = 'Accounts Receivable Notes Report'
      ImageIndex = 364
      OnExecute = AnyActionExecute
      ClassExecute = 'TAccountsReceivableNotes'
      Description = 'Accts Rec Nts'
      buttoncolor = clWhite
    end
    object actApptsCancellationReasons: TDNMAction
      Category = 'Appointments'
      Caption = 'Cancellation Reason List'
      ImageIndex = 195
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmAppointmentCancellationReasons'
      Description = 'Cncl Rsn Lst'
      buttoncolor = clWhite
    end
    object POBOList: TDNMAction
      Category = 'Purchases'
      Caption = 'BO Purchase Orders'
      ImageIndex = 313
      OnExecute = AnyActionExecute
      ClassExecute = 'TBackOrderPurchaseListGUI'
      Description = 'BO Purch Ords'
      buttoncolor = clWhite
    end
    object POBOExpressList: TDNMAction
      Category = 'Purchases'
      Caption = 'Purchase BO Express'
      ImageIndex = 566
      OnExecute = AnyActionExecute
      ClassExecute = 'TBackorderPurchaseOrderExpressGUI'
      Description = 'BO Purch Express'
      buttoncolor = clWhite
    end
    object actSalesPrintPickSlips: TDNMAction
      Category = 'Sales'
      Caption = 'Print Picking Slips'
      ImageIndex = 500
      OnExecute = actSalesPrintPickSlipsExecute
      Description = 'Print Pick Slp'
      buttoncolor = clWhite
    end
    object actCustomExport: TDNMAction
      Category = 'File'
      Caption = 'Custom Export'
      ImageIndex = 315
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmCustomExport'
      buttoncolor = clWhite
    end
    object actReportsCRM: TDNMAction
      Category = 'Reports'
      Caption = 'CRM Reports'
      ImageIndex = 141
      OnExecute = actReportsCRMExecute
      ClassExecute = 'TfrmReportSelectorGUI'
      buttoncolor = clWhite
    end
    object actReportsJobs: TDNMAction
      Category = 'Reports'
      Caption = 'Jobs Reports'
      ImageIndex = 141
      OnExecute = actReportsJobsExecute
      ClassExecute = 'TfrmReportSelectorGUI'
      buttoncolor = clWhite
    end
    object actEquipmentList: TDNMAction
      Category = 'General'
      Caption = 'Equipment List'
      ImageIndex = 342
      OnExecute = AnyActionExecute
      ClassExecute = 'TEquipmentListGUI'
      buttoncolor = clWhite
    end
    object actEquipment: TDNMAction
      Category = 'General'
      Caption = 'Equipment'
      ImageIndex = 254
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmEquip'
      buttoncolor = clWhite
    end
    object actProductFormulaEntry: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Formula Entry'
      ImageIndex = 258
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmProductFormulaEntry'
      DefaultPage = 'Inventory'
      buttoncolor = clWhite
    end
    object actProductFormulaCreator: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Formula Creator'
      ImageIndex = 552
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmProductFormula'
      DefaultPage = 'Inventory'
      buttoncolor = clWhite
    end
    object actProductFormulaList: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Formula List'
      ImageIndex = 317
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmProductformulaList'
      DefaultPage = 'Inventory'
      buttoncolor = clWhite
    end
    object actEmployeePayrollATO: TDNMAction
      Category = 'Payroll'
      Caption = 'ATO Submissions'
      ImageIndex = 119
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmATOSubmissionsGUI'
      Description = 'ATO Submissions'
      buttoncolor = clWhite
    end
    object actPurchasesExpenseClaimList: TDNMAction
      Category = 'Purchases'
      Caption = 'Expense Claim List'
      ImageIndex = 595
      OnExecute = AnyActionExecute
      ClassExecute = 'TExpenseClaimListGUI'
      Description = 'Expense Claim List'
      buttoncolor = clWhite
    end
    object actPaymentsApprovalReminderList: TDNMAction
      Category = 'Payments'
      Caption = 'Approval Reminder List'
      ImageIndex = 563
      OnExecute = AnyActionExecute
      ClassExecute = 'TApprovalReminderListGUI'
      Description = 'Approval Reminder List'
      buttoncolor = clWhite
    end
    object actWorkOrderStatusList: TDNMAction
      Category = 'Inventory'
      Caption = 'Work Order Status'
      ImageIndex = 385
      Visible = False
      OnExecute = AnyActionExecute
      ClassExecute = 'TWorkOrderStatusListGUI'
      buttoncolor = clWhite
    end
    object actDeliveryDocketList: TDNMAction
      Category = 'Sales'
      Caption = 'Delivery Docket Audit'
      ImageIndex = 417
      OnExecute = AnyActionExecute
      ClassExecute = 'TDeliveryDocketListGUI'
      buttoncolor = clWhite
    end
    object actEmployeeTerminationList: TDNMAction
      Category = 'Employee'
      Caption = 'Terminations List'
      Enabled = False
      ImageIndex = 20
      Visible = False
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmEmployeeTerminationList'
      Description = 'Terminations List'
      buttoncolor = clWhite
    end
    object actAccountsIntrastatDeclaration: TDNMAction
      Category = 'Accounts'
      Caption = 'Intrastat Declaration'
      ImageIndex = 549
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmIntrastatDeclaration'
      buttoncolor = clWhite
    end
    object actAccountsIntrastatList: TDNMAction
      Category = 'Accounts'
      Caption = 'Intrastat List'
      ImageIndex = 551
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmIntrastatList'
      buttoncolor = clWhite
    end
    object actSource: TDNMAction
      Category = 'CRM'
      Caption = 'Source'
      ImageIndex = 131
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmSource'
      buttoncolor = clWhite
    end
    object actCashFlowForecast: TDNMAction
      Category = 'Accounts'
      Caption = 'Cash Flow Forecast'
      ImageIndex = 345
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmCashFlowForecast'
      buttoncolor = clWhite
    end
    object actGeneralLedger: TDNMAction
      Category = 'Accounts'
      Caption = 'General Ledger'
      OnExecute = AnyActionExecute
      ClassExecute = 'TGeneralLedgerReportGUI'
      buttoncolor = clWhite
    end
    object actUnpaidBillGUI: TDNMAction
      Category = 'Accounts'
      Caption = 'Unpaid Bills'
      ImageIndex = 400
      OnExecute = AnyActionExecute
      ClassExecute = 'TUnpaidBillGUI'
      buttoncolor = clWhite
    end
    object actCustomerBalanceDetail: TDNMAction
      Category = 'Sales'
      Caption = 'Customer Balance Detail'
      ImageIndex = 596
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomerBalanceDetailGUI'
      buttoncolor = clWhite
    end
    object actCustomerNotesReport: TDNMAction
      Category = 'Sales'
      Caption = 'Customer Notes Report'
      ImageIndex = 597
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomerNotesReportGUI'
      buttoncolor = clWhite
    end
    object actEmployeeReportByPeriod: TDNMAction
      Category = 'Employee'
      Caption = 'Employee Summary (By Period)'
      ImageIndex = 598
      OnExecute = AnyActionExecute
      ClassExecute = 'TEmployeeReportByPeriodGUI'
      buttoncolor = clWhite
    end
    object actForeignSalesList: TDNMAction
      Category = 'Sales'
      Caption = 'Foreign Sales Report'
      ImageIndex = 599
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmForeignSalesList'
      buttoncolor = clWhite
    end
    object actActionAuthorisationsList: TDNMAction
      Category = 'Employee'
      Caption = 'Action Authorisations Report'
      ImageIndex = 600
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmActionAuthorisationsList'
      buttoncolor = clWhite
    end
    object actCombinedAnalysisList: TDNMAction
      Category = 'Employee'
      Caption = 'Combined Analysis'
      ImageIndex = 601
      OnExecute = AnyActionExecute
      ClassExecute = 'TCombinedAnalysisListGUI'
      buttoncolor = clWhite
    end
    object actCommissionReport: TDNMAction
      Category = 'Employee'
      Caption = 'Invoice Commission Report'
      ImageIndex = 602
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmCommissionReportGUI'
      buttoncolor = clWhite
    end
    object actEmployeesFixedAssetsList: TDNMAction
      Category = 'Employee'
      Caption = 'Employee Fixed Assests'
      ImageIndex = 603
      OnExecute = AnyActionExecute
      ClassExecute = 'TEmployeesFixedAssetsList'
      buttoncolor = clWhite
    end
    object actSalesCommissionList: TDNMAction
      Category = 'Accounts'
      Caption = 'Commission Report'
      ImageIndex = 604
      OnExecute = AnyActionExecute
      ClassExecute = 'TSalescommissionListGUI'
      buttoncolor = clWhite
    end
    object actAssetRegisterList: TDNMAction
      Category = 'FixedAssets'
      Caption = 'Asset Register Report'
      ImageIndex = 35
      OnExecute = AnyActionExecute
      ClassExecute = 'TAssetRegisterListGUI'
      buttoncolor = clWhite
    end
    object actFixedAssetsDetails: TDNMAction
      Category = 'FixedAssets'
      Caption = 'Fixed Assets Details Report'
      ImageIndex = 605
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmFixedAssetsDetails'
      buttoncolor = clWhite
    end
    object actProductSalesSummaryByColumn: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Sales Summary (By Column)'
      ImageIndex = 606
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductSalesSummaryByColumnGUI'
      buttoncolor = clWhite
    end
    object actStockStatusRoling: TDNMAction
      Category = 'Inventory'
      Caption = 'Stock Movement Status'
      ImageIndex = 607
      OnExecute = AnyActionExecute
      ClassExecute = 'TStockStatusRoling'
      buttoncolor = clWhite
    end
    object actStockQtysLocationsReport: TDNMAction
      Category = 'Inventory'
      Caption = 'Stock Quantities and Location Report'
      ImageIndex = 608
      OnExecute = AnyActionExecute
      ClassExecute = 'TStockQtysLocationsReportGUI'
      buttoncolor = clWhite
    end
    object actBinQtyReport: TDNMAction
      Category = 'Inventory'
      Caption = 'Bin Quantities Report'
      ImageIndex = 608
      OnExecute = AnyActionExecute
      ClassExecute = 'TStockBinQtysReportGUI'
      buttoncolor = clWhite
    end
    object actSupplierProductReport: TDNMAction
      Category = 'Inventory'
      Caption = 'Supplier Product Report'
      ImageIndex = 609
      OnExecute = AnyActionExecute
      ClassExecute = 'TSupplierProductReportGUI'
      buttoncolor = clWhite
    end
    object actUnAllocatedBinsReport: TDNMAction
      Category = 'Inventory'
      Caption = 'UnAllocated Bins Report'
      ImageIndex = 610
      OnExecute = AnyActionExecute
      ClassExecute = 'TUnAllocatedBinsReportGUI'
      buttoncolor = clWhite
    end
    object actUnbalancedBinQty: TDNMAction
      Category = 'Inventory'
      Caption = 'Unbalanced Bin Quantities'
      ImageIndex = 611
      OnExecute = AnyActionExecute
      ClassExecute = 'TUnbalancedBinQtyGUI'
      buttoncolor = clWhite
    end
    object actCustomerJobFollowupList: TDNMAction
      Category = 'Inventory'
      Caption = 'Customer / Job Follow ups'
      ImageIndex = 612
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmCustomerJobFollowupList'
      buttoncolor = clWhite
    end
    object actProfitLossSummary: TDNMAction
      Category = 'Inventory'
      Caption = 'Profit and Loss Summary'
      ImageIndex = 613
      OnExecute = AnyActionExecute
      ClassExecute = 'TProfitLossSummaryGUI'
      buttoncolor = clWhite
    end
    object actProdAttribTemplateFields: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Attributes in Sales Template'
      ImageIndex = 544
      OnExecute = AnyActionExecute
      ClassExecute = 'TProdAttribTemplateFieldsGUI'
      buttoncolor = clWhite
    end
    object actProdAttribTemplateFieldsdetails: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Attributes in Sales Template(Details)'
      ImageIndex = 545
      OnExecute = AnyActionExecute
      ClassExecute = 'TProdAttribTemplateFieldsDetailsGUI'
      buttoncolor = clWhite
    end
    object actProductAttributes: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Attributes'
      ImageIndex = 542
      OnExecute = AnyActionExecute
      ClassExecute = 'TProdAttribGroupsGUI'
      buttoncolor = clWhite
    end
    object actAccountsPayableNotes: TDNMAction
      Category = 'Payments'
      Caption = 'Accounts Payable Notes Report'
      ImageIndex = 614
      OnExecute = AnyActionExecute
      ClassExecute = 'TAccountsPayableNotes'
      buttoncolor = clWhite
    end
    object actExpenseClaimList: TDNMAction
      Category = 'Payments'
      Caption = 'Expense Claims'
      ImageIndex = 615
      OnExecute = AnyActionExecute
      ClassExecute = 'TExpenseClaimListGUI'
      buttoncolor = clWhite
    end
    object actForeignPurchaseList: TDNMAction
      Category = 'Purchases'
      Caption = 'Foreign Purchase Report'
      ImageIndex = 616
      OnExecute = AnyActionExecute
      ClassExecute = 'TForeignPurchaseOrderListExpressGUI'
      buttoncolor = clWhite
    end
    object actSupplierStatement: TDNMAction
      Category = 'Purchases'
      Caption = 'Supplier Statement '
      ImageIndex = 617
      OnExecute = AnyActionExecute
      ClassExecute = 'TSupplierStatementGUI'
      buttoncolor = clWhite
    end
    object actUnInvoicedPurchasesList: TDNMAction
      Category = 'Purchases'
      Caption = 'Un-Invoiced Customer Purchase Orders'
      ImageIndex = 618
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmUnInvoicedPurchasesList'
      buttoncolor = clWhite
    end
    object actUnInvoicedPurchItemList: TDNMAction
      Category = 'Purchases'
      Caption = 'Un-Invoiced Customer Purchase Items'
      ImageIndex = 619
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmUnInvoicedPurchItemList'
      buttoncolor = clWhite
    end
    object actQuoteDetailsReport: TDNMAction
      Category = 'Sales'
      Caption = 'Quote Details Report'
      ImageIndex = 620
      OnExecute = AnyActionExecute
      ClassExecute = 'TQuoteDetailsReport'
      buttoncolor = clWhite
    end
    object actSalesReport: TDNMAction
      Category = 'Sales'
      Caption = 'Sales Report'
      ImageIndex = 621
      OnExecute = AnyActionExecute
      ClassExecute = 'TSalesReportGUI'
      buttoncolor = clWhite
    end
    object actSalesRewardPointsList: TDNMAction
      Category = 'Sales'
      Caption = 'Sales Reward Points'
      ImageIndex = 622
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmSalesRewardPointsList'
      buttoncolor = clWhite
    end
    object actSoldProductsReport: TDNMAction
      Category = 'Sales'
      Caption = 'Stock Turnover Report'
      ImageIndex = 623
      OnExecute = AnyActionExecute
      ClassExecute = 'TSoldProductsReport'
      buttoncolor = clWhite
    end
    object actTransactionList: TDNMAction
      Category = 'General'
      Caption = 'Transaction List'
      ImageIndex = 358
      Visible = False
      OnExecute = AnyActionExecute
      ClassExecute = 'TAllTransactionGUI'
      buttoncolor = clWhite
    end
    object actMarketingRatios: TDNMAction
      Category = 'CRM'
      Caption = 'Marketing Ratios Report'
      ImageIndex = 505
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmMarketingRatios'
      buttoncolor = clWhite
    end
    object actSalesRatios: TDNMAction
      Category = 'Sales'
      Caption = 'Sales Ratios Report'
      ImageIndex = 201
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmSalesRatioReport'
      buttoncolor = clWhite
    end
    object actLeadStatusType1: TDNMAction
      Category = 'Marketing'
      Caption = 'Lead/Quote Status Type'
      ImageIndex = 533
      OnExecute = actLeadStatusTypeExecute
      buttoncolor = clWhite
    end
    object actSalesPipeline: TDNMAction
      Category = 'Sales'
      Caption = 'Sales Pipeline'
      ImageIndex = 518
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmSalesPipelineReport'
      buttoncolor = clWhite
    end
    object actSerialNumbersOld: TDNMAction
      Category = 'Inventory'
      Caption = 'Serial Numbers'
      ImageIndex = 377
      Visible = False
      OnExecute = AnyActionExecute
      ClassExecute = 'TSerialNumbersGUI'
      buttoncolor = clWhite
    end
    object actShippingContainerStatus: TDNMAction
      Category = 'Purchases'
      Caption = 'Shipping Container Status'
      ImageIndex = 94
      OnExecute = actShippingContainerStatusExecute
      buttoncolor = clWhite
    end
    object actShippingContainer: TDNMAction
      Category = 'Purchases'
      Caption = 'Shipping Container'
      ImageIndex = 525
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmShipContainer'
      buttoncolor = clWhite
    end
    object actShipContainerList: TDNMAction
      Category = 'Purchases'
      Caption = 'Shipping Container List'
      ImageIndex = 527
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmShippingContainerList'
      buttoncolor = clWhite
    end
    object actBatches: TDNMAction
      Category = 'Inventory'
      Caption = 'Batches'
      ImageIndex = 37
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductBatchesGUI'
      buttoncolor = clWhite
    end
    object actMailMergeHistory: TDNMAction
      Category = 'CRM'
      Caption = 'Mail Merge History'
      ImageIndex = 365
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmMailMergeHistoryList'
      buttoncolor = clWhite
    end
    object actTimesheetEntry: TDNMAction
      Category = 'Employee'
      Caption = 'Timesheet'
      ImageIndex = 7
      OnExecute = AnyActionExecute
      ClassExecute = 'TFrmTimesheet'
      buttoncolor = clWhite
    end
    object actEmployeeTimesheetList: TDNMAction
      Category = 'Employee'
      Caption = 'Timesheet List'
      ImageIndex = 366
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmPayTimesheet'
      buttoncolor = clWhite
    end
    object actReportsWorkShop: TDNMAction
      Category = 'Reports'
      Caption = 'Workshop Reports'
      ImageIndex = 141
      OnExecute = actReportsWorkShopExecute
      buttoncolor = clWhite
    end
    object actClientEquipmentlist: TDNMAction
      Category = 'General'
      Caption = 'Customer Equipment List'
      ImageIndex = 238
      OnExecute = AnyActionExecute
      ClassExecute = 'TClientEquipmentlist'
      buttoncolor = clWhite
    end
    object actVidoes: TDNMAction
      Category = 'General'
      Caption = 'Videos'
      ImageIndex = 382
      OnExecute = actVidoesExecute
      buttoncolor = clWhite
    end
    object actincomeExpenseConfig: TDNMAction
      Category = 'Accounts'
      Caption = 'Income && Expenditure Config'
      ImageIndex = 395
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmSelectAccountsforReports'
      buttoncolor = clWhite
    end
    object actmainDashboard: TDNMAction
      Category = 'General'
      Caption = 'Dashboard'
      ImageIndex = 271
      OnExecute = AnyActionExecute
      ClassExecute = 'TMainDashboardGUI'
      buttoncolor = clWhite
    end
    object actsalesDashboard: TDNMAction
      Category = 'General'
      Caption = 'Sales Dashboard'
      ImageIndex = 561
      OnExecute = AnyActionExecute
      ClassExecute = 'TSalesDashboardGUI'
      buttoncolor = clWhite
    end
    object actSerialJobnumber: TDNMAction
      Category = 'Inventory'
      Caption = 'Serial / Job Number'
      ImageIndex = 485
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmSerialjobNumbers'
      buttoncolor = clWhite
    end
    object actAutoAdjustbin: TDNMAction
      Category = 'Inventory'
      Caption = 'Auto Adjust Bin'
      ImageIndex = 519
      OnExecute = actAutoAdjustbinExecute
      buttoncolor = clWhite
    end
    object actSalesListwithCommision: TDNMAction
      Category = 'Accounts'
      Caption = 'Sales - Commission'
      ImageIndex = 457
      OnExecute = AnyActionExecute
      ClassExecute = 'TSalesListwithCommisionGUI'
      buttoncolor = clWhite
    end
    object actCashSaleDepositGUI: TDNMAction
      Category = 'Sales'
      Caption = 'Cash Sale Deposits'
      ImageIndex = 461
      OnExecute = AnyActionExecute
      ClassExecute = 'TCashSaleDepositGUI'
      buttoncolor = clWhite
    end
    object actAdjustUOM: TDNMAction
      Category = 'Inventory'
      Caption = 'Adjust UOM (Stock)'
      ImageIndex = 213
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmAdjustUOM'
      buttoncolor = clWhite
    end
    object actRewardPoints: TDNMAction
      Category = 'CRM'
      Caption = 'Reward Points'
      ImageIndex = 121
      OnExecute = AnyActionExecute
      ClassExecute = 'TRewardPointsGUI'
      buttoncolor = clWhite
    end
    object actRewardPointsDueToExpireGUI: TDNMAction
      Category = 'CRM'
      Caption = 'Reward Points Due to Expire'
      ImageIndex = 122
      OnExecute = AnyActionExecute
      ClassExecute = 'TRewardPointsDueToExpireGUI'
      buttoncolor = clWhite
    end
    object actAppointmentStatusList: TDNMAction
      Category = 'Appointments'
      Caption = 'Appointment Status List'
      ImageIndex = 386
      OnExecute = actAppointmentStatusListExecute
      buttoncolor = clWhite
    end
    object actRepAbilityList: TDNMAction
      Category = 'Employee'
      Caption = 'Rep Ability List'
      ImageIndex = 590
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmRepAbilityList'
      buttoncolor = clWhite
    end
    object actRepAbility: TDNMAction
      Category = 'Employee'
      Caption = 'Rep Ability'
      ImageIndex = 472
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmRepAbilityEdit'
      buttoncolor = clWhite
    end
    object actTransactionwith0Qty: TDNMAction
      Category = 'General'
      Caption = 'Transactions with 0 Quantity'
      ImageIndex = 381
      OnExecute = AnyActionExecute
      ClassExecute = 'TTransactionswith0QtyGUI'
      buttoncolor = clWhite
    end
    object actCustomerExpressList: TDNMAction
      Category = 'Sales'
      Caption = 'Customer Express List'
      ImageIndex = 379
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomerExpressListGUI'
      buttoncolor = clWhite
    end
    object actShippingAgent: TDNMAction
      Category = 'Sales'
      Caption = 'Shipping Agent'
      ImageIndex = 469
      ClassExecute = 'TfmShippingAgent'
      buttoncolor = clWhite
    end
    object actShippingAgentlist: TDNMAction
      Category = 'Sales'
      Caption = 'Shipping Agent List'
      ImageIndex = 222
      ClassExecute = 'TShippingAgentGUI'
      buttoncolor = clWhite
    end
    object actMessages: TDNMAction
      Category = 'General'
      Caption = 'Messages'
      ImageIndex = 373
      OnExecute = actMessagesExecute
      buttoncolor = clWhite
    end
    object actCustomise: TDNMAction
      Category = 'General'
      Caption = 'Customise'
      OnExecute = actCustomiseExecute
      buttoncolor = clWhite
    end
    object actProfitandLossSummary: TDNMAction
      Category = 'Inventory'
      Caption = 'Profit and Loss Summary'
      ImageIndex = 624
      OnExecute = AnyActionExecute
      ClassExecute = 'TProfitLossSummaryGUI'
      buttoncolor = clWhite
    end
    object actProductListwithUOM: TDNMAction
      Category = 'Inventory'
      Caption = 'Product List With Unit of Measure'
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductListwithUOMGUI'
      buttoncolor = clWhite
    end
    object actRegionList: TDNMAction
      Category = 'General'
      Caption = 'Region List'
      ImageIndex = 526
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmRegionalOptionList'
      buttoncolor = clWhite
    end
    object actRegion: TDNMAction
      Category = 'General'
      Caption = 'Region'
      ImageIndex = 528
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmRegionalOptionEdit'
      buttoncolor = clWhite
    end
    object actProductBarcodes: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Barcodes'
      ImageIndex = 403
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductBarcodesGUI'
      buttoncolor = clWhite
    end
    object actClientList: TDNMAction
      Category = 'General'
      Caption = 'Client List'
      ImageIndex = 110
      OnExecute = AnyActionExecute
      ClassExecute = 'TClientListGUI'
      buttoncolor = clWhite
    end
    object actContactList: TDNMAction
      Category = 'General'
      Caption = 'Contact List'
      ImageIndex = 506
      OnExecute = AnyActionExecute
      ClassExecute = 'TContactListGUI'
      buttoncolor = clWhite
    end
    object actMarketingContactcontactList: TDNMAction
      Category = 'CRM'
      Caption = 'Marketing Contact Contact List'
      ImageIndex = 508
      OnExecute = AnyActionExecute
      ClassExecute = 'TMarketingContactcontactListGUI'
      buttoncolor = clWhite
    end
    object actProductClassList: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Class List'
      ImageIndex = 509
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductClassListGUI'
      buttoncolor = clWhite
    end
    object actOtherfollowups: TDNMAction
      Category = 'General'
      Caption = 'Other Followups'
      ImageIndex = 463
      OnExecute = AnyActionExecute
      ClassExecute = 'TOtherfollowupsGUI'
      buttoncolor = clWhite
    end
    object actProductgroupdiscount: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Group Discount List'
      ImageIndex = 203
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductgroupdiscountListGUI'
      buttoncolor = clWhite
    end
    object actProductSpecificationList: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Specification List'
      ImageIndex = 205
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductSpecificationListGUI'
      buttoncolor = clWhite
    end
    object actProductExtrabuyPrices: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Extra Buy Prices'
      ImageIndex = 206
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductExtrabuyPricesGUI'
      buttoncolor = clWhite
    end
    object actProductExtraSellPrices: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Extra Sell Prices'
      ImageIndex = 514
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductExtraSellPriceGUI'
      buttoncolor = clWhite
    end
    object actProductforeignBuyPrice: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Foreign Buy Prices'
      ImageIndex = 515
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductforeignBuyPriceGUI'
      buttoncolor = clWhite
    end
    object actproductForeignSellPrice: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Foreign Sell Price'
      ImageIndex = 209
      OnExecute = AnyActionExecute
      ClassExecute = 'TproductForeignSellPriceGUI'
      buttoncolor = clWhite
    end
    object actRelatedProducts: TDNMAction
      Category = 'Inventory'
      Caption = 'Related Products'
      ImageIndex = 210
      OnExecute = AnyActionExecute
      ClassExecute = 'TRelatedProductsGUI'
      buttoncolor = clWhite
    end
    object actrelatedcustomers: TDNMAction
      Category = 'Sales'
      Caption = 'Related Customers'
      ImageIndex = 516
      OnExecute = AnyActionExecute
      ClassExecute = 'TrelatedcustomersGUI'
      buttoncolor = clWhite
    end
    object actShippingMethods: TDNMAction
      Category = 'Purchases'
      Caption = 'Shipping Methods'
      ImageIndex = 520
      OnExecute = AnyActionExecute
      ClassExecute = 'TShippingMethodsGUI'
      buttoncolor = clWhite
    end
    object actSpecialProducts: TDNMAction
      Category = 'Inventory'
      Caption = 'Special Products'
      ImageIndex = 521
      OnExecute = AnyActionExecute
      ClassExecute = 'TSpecialProductsGUI'
      buttoncolor = clWhite
    end
    object actLanguages: TDNMAction
      Category = 'General'
      Caption = 'Language List'
      ImageIndex = 510
      OnExecute = AnyActionExecute
      ClassExecute = 'TLanguagesGUI'
      buttoncolor = clWhite
    end
    object actkills: TDNMAction
      Category = 'Employee'
      Caption = 'Employee Skill'
      ImageIndex = 512
      OnExecute = AnyActionExecute
      ClassExecute = 'Tfmskills'
      buttoncolor = clWhite
    end
    object actSkillList: TDNMAction
      Category = 'Employee'
      Caption = 'Skill List'
      ImageIndex = 204
      OnExecute = AnyActionExecute
      ClassExecute = 'TSkillsGUI'
      buttoncolor = clWhite
    end
    object actEmployeeSkillList: TDNMAction
      Category = 'Employee'
      Caption = 'Employee Skill List'
      ImageIndex = 513
      OnExecute = AnyActionExecute
      ClassExecute = 'TEmployeeSkillListGUI'
      buttoncolor = clWhite
    end
    object actProductGroupList: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Category List'
      ImageIndex = 634
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmProductGroupList'
      buttoncolor = clWhite
    end
    object actPickingSlipList: TDNMAction
      Category = 'Sales'
      Caption = 'Picking Slip Audit'
      ImageIndex = 631
      OnExecute = AnyActionExecute
      ClassExecute = 'TPickingSlipListGUI'
      buttoncolor = clWhite
    end
    object actSalesQuotesPadQuote: TDNMAction
      Category = 'Sales'
      Caption = 'Insurance Pad'
      ImageIndex = 393
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmPadQuote'
      buttoncolor = clWhite
    end
    object actWebAPITest: TDNMAction
      Category = 'Utilities'
      Caption = 'Web API Test'
      ImageIndex = 739
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmWebAPITest'
      buttoncolor = clWhite
    end
    object actSubTaxcodes: TDNMAction
      Category = 'Accounts'
      Caption = 'Sub Tax Code List'
      ImageIndex = 458
      OnExecute = AnyActionExecute
      ClassExecute = 'TSubTaxcodesGUI'
      buttoncolor = clWhite
    end
    object actSubTaxcode: TDNMAction
      Category = 'Accounts'
      Caption = 'Sub Tax Code'
      ImageIndex = 459
      OnExecute = AnyActionExecute
      ClassExecute = 'TSubTaxcodesGUI'
      buttoncolor = clWhite
    end
    object actNotesAuditTrial: TDNMAction
      Category = 'Utilities'
      Caption = 'Notes Audit Trail List'
      ImageIndex = 484
      OnExecute = AnyActionExecute
      ClassExecute = 'TNotesAuditTrailListGUI'
      buttoncolor = clWhite
    end
    object actImportDataMapping: TDNMAction
      Category = 'File'
      Caption = 'Import Data Mapping'
      ImageIndex = 567
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmImportDataMapping'
      buttoncolor = clWhite
    end
    object actImportDataMappingList: TDNMAction
      Category = 'File'
      Caption = 'Import Data Mapping List'
      ImageIndex = 408
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmImportDataMappingList'
      buttoncolor = clWhite
    end
    object actDeldocketList: TDNMAction
      Category = 'Inventory'
      Caption = 'Print Delivery'
      ImageIndex = 470
      OnExecute = AnyActionExecute
      ClassExecute = 'TDeldocketListGUI'
      buttoncolor = clWhite
    end
    object actSalesListOutstanding: TDNMAction
      Category = 'Inventory'
      Caption = 'Sales List Outstanding'
      ImageIndex = 223
      OnExecute = AnyActionExecute
      ClassExecute = 'TSalesListOutstandingGUI'
      buttoncolor = clWhite
    end
    object actPrintPurchaseOrders: TDNMAction
      Category = 'Purchases'
      Caption = 'Print Purchase Order'
      ImageIndex = 479
      OnExecute = AnyActionExecute
      ClassExecute = 'TPurchaseOrderPrnGUI'
      buttoncolor = clWhite
    end
    object actPurchaseOrderAudit: TDNMAction
      Category = 'Purchases'
      Caption = 'Purchase Order Audit'
      ImageIndex = 536
      OnExecute = AnyActionExecute
      ClassExecute = 'TPurchaseOrderAuditGUI'
      buttoncolor = clWhite
    end
    object actSalesJobQuoteList: TDNMAction
      Category = 'Sales'
      Caption = 'Job Quote List'
      ImageIndex = 502
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmQuoteJobList'
      buttoncolor = clWhite
    end
    object actTask: TDNMAction
      Category = 'Utilities'
      Caption = 'Task'
      ImageIndex = 464
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmTasks'
      buttoncolor = clWhite
    end
    object actTaskList: TDNMAction
      Category = 'Utilities'
      Caption = 'Task List'
      ImageIndex = 531
      OnExecute = AnyActionExecute
      ClassExecute = 'TTasksGUI'
      buttoncolor = clWhite
    end
    object actClientPhoneList: TDNMAction
      Category = 'Sales'
      Caption = 'Phone Numbers'
      ImageIndex = 465
      OnExecute = AnyActionExecute
      ClassExecute = 'TClientPhoneListGUI'
      buttoncolor = clWhite
    end
    object actPhoneSupportLogListExpress: TDNMAction
      Category = 'Appointments'
      Caption = 'Phone Support Log (Express)'
      ImageIndex = 532
      OnExecute = AnyActionExecute
      ClassExecute = 'TPhoneSupportLogListExpressGUI'
      buttoncolor = clWhite
    end
    object actCustlistWithDetails: TDNMAction
      Category = 'Sales'
      Caption = 'Customer History List'
      ImageIndex = 380
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustlistWithDetailsGUI'
      buttoncolor = clWhite
    end
    object actPhoneSupportTypeList: TDNMAction
      Category = 'Appointments'
      Caption = 'Support Type List'
      ImageIndex = 522
      OnExecute = actPhoneSupportTypeListExecute
      buttoncolor = clWhite
    end
    object actPhoneSupportVersionList: TDNMAction
      Category = 'Appointments'
      Caption = 'Support Version List'
      ImageIndex = 523
      OnExecute = actPhoneSupportVersionListExecute
      buttoncolor = clWhite
    end
    object actUnAllocatedQty: TDNMAction
      Category = 'Inventory'
      Caption = 'Un-Allocated Qty'
      ImageIndex = 199
      OnExecute = AnyActionExecute
      ClassExecute = 'TUnAllocatedQtyGUI'
      buttoncolor = clWhite
    end
    object actProductPurchaseMovementList: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Purchase Movement List'
      ImageIndex = 483
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductPurchaseMovementListGUI'
      buttoncolor = clWhite
    end
    object actNumberSequenceList: TDNMAction
      Category = 'General'
      Caption = 'Number Sequence List'
      ImageIndex = 367
      OnExecute = AnyActionExecute
      ClassExecute = 'TNumberSequenceListGUI'
      buttoncolor = clWhite
    end
    object actLinkTo: TDNMAction
      Category = 'Utilities'
      Caption = 'Link To'
      ImageIndex = 492
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmLinkToTestForms'
      buttoncolor = clWhite
    end
    object actGoogleAnalysisReport_Language: TDNMAction
      Category = 'Google'
      Caption = 'Google Report Language'
      ImageIndex = 477
      OnExecute = AnyActionExecute
      ClassExecute = 'TGoogleAnalysisReport_LanguageGUI'
      buttoncolor = clWhite
    end
    object actGoogleAnalysisReport_Location: TDNMAction
      Category = 'Google'
      Caption = 'Google Report Location'
      ImageIndex = 490
      OnExecute = AnyActionExecute
      ClassExecute = 'TGoogleAnalysisReport_LocationGUI'
      buttoncolor = clWhite
    end
    object actGoogleAnalysisReport_Keyword: TDNMAction
      Category = 'Google'
      Caption = 'Google Report Keyword'
      ImageIndex = 462
      OnExecute = AnyActionExecute
      ClassExecute = 'TGoogleAnalysisReport_KeywordGUI'
      buttoncolor = clWhite
    end
    object actGoogleAnalysisReport_Campaign: TDNMAction
      Category = 'Google'
      Caption = 'Google Report Campaign'
      ImageIndex = 504
      OnExecute = AnyActionExecute
      ClassExecute = 'TGoogleAnalysisReport_CampaignGUI'
      buttoncolor = clWhite
    end
    object actGoogleAnalysisReport_Browser: TDNMAction
      Category = 'Google'
      Caption = 'Google Report Browser'
      ImageIndex = 460
      OnExecute = AnyActionExecute
      ClassExecute = 'TGoogleAnalysisReport_BrowserGUI'
      buttoncolor = clWhite
    end
    object actGoogleAnalysisReport_DayofWeek: TDNMAction
      Category = 'Google'
      Caption = 'Google Report Day of the Week'
      ImageIndex = 449
      OnExecute = AnyActionExecute
      ClassExecute = 'TGoogleAnalysisReport_DayofWeekGUI'
      buttoncolor = clWhite
    end
    object actGoogleAnalyticReport_Language: TDNMAction
      Category = 'Google'
      Caption = 'Google Combined Language'
      ImageIndex = 650
      OnExecute = AnyActionExecute
      ClassExecute = 'TGoogleAnalytic_LanguageGUI'
      buttoncolor = clWhite
    end
    object actGoogleAnalyticReport_Location: TDNMAction
      Category = 'Google'
      Caption = 'Google Combined Location'
      ImageIndex = 651
      OnExecute = AnyActionExecute
      ClassExecute = 'TGoogleAnalytic_LocationGUI'
      buttoncolor = clWhite
    end
    object actGoogleAnalyticReport_Keyword: TDNMAction
      Category = 'Google'
      Caption = 'Google Combined Keyword'
      ImageIndex = 649
      OnExecute = AnyActionExecute
      ClassExecute = 'TGoogleAnalytic_KeywordGUI'
      buttoncolor = clWhite
    end
    object actGoogleAnalyticReport_Campaign: TDNMAction
      Category = 'Google'
      Caption = 'Google Combined Campaign'
      ImageIndex = 652
      OnExecute = AnyActionExecute
      ClassExecute = 'TGoogleAnalytic_CampaignGUI'
      buttoncolor = clWhite
    end
    object actGoogleAnalyticReport_Browser: TDNMAction
      Category = 'Google'
      Caption = 'Google Combined Browser'
      ImageIndex = 648
      OnExecute = AnyActionExecute
      ClassExecute = 'TGoogleAnalytic_BrowserGUI'
      buttoncolor = clWhite
    end
    object actGoogleAnalyticReport_DayofWeek: TDNMAction
      Category = 'Google'
      Caption = 'Google Combined Day of the Week'
      ImageIndex = 645
      OnExecute = AnyActionExecute
      ClassExecute = 'TGoogleAnalytic_DayofWeekGUI'
      buttoncolor = clWhite
    end
    object actreportsGoogle: TDNMAction
      Category = 'Google'
      Caption = 'Google Reports'
      ImageIndex = 141
      OnExecute = actreportsGoogleExecute
      buttoncolor = clWhite
    end
    object actAnalyicreports: TDNMAction
      Category = 'General'
      Caption = 'Google Analytic Reports'
      ImageIndex = 443
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmAnalyicreports'
      buttoncolor = clWhite
    end
    object actAnalyticsSummaryList: TDNMAction
      Category = 'Google'
      Caption = 'Google Analytics Summary List'
      ImageIndex = 489
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmAnalyticsSummaryList'
      buttoncolor = clWhite
    end
    object actAnalyticsDetailList: TDNMAction
      Category = 'Google'
      Caption = 'Google Analytics Detail List'
      ImageIndex = 675
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmAnalyticsDetailList'
      buttoncolor = clWhite
    end
    object actGoogleAnalysisReport_Summary: TDNMAction
      Category = 'Google'
      Caption = 'Google Report Summary'
      ImageIndex = 499
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmGoogleAnalytic_Summary'
      buttoncolor = clWhite
    end
    object actGoogleAnalytic_Summary: TDNMAction
      Category = 'Google'
      Caption = 'Google Combined Summary'
      ImageIndex = 674
      OnExecute = AnyActionExecute
      ClassExecute = 'TGoogleAnalytic_SummaryGUI'
      buttoncolor = clWhite
    end
    object actFaq: TDNMAction
      Category = 'General'
      Caption = 'F A Q'
      ImageIndex = 466
      OnExecute = AnyActionExecute
      ClassExecute = 'TFaqGUI'
      buttoncolor = clWhite
    end
    object actGoogleanalysisCost: TDNMAction
      Category = 'Google'
      Caption = 'Google Cost'
      ImageIndex = 453
      OnExecute = AnyActionExecute
      ClassExecute = 'TGoogleanalysisCostGUI'
      buttoncolor = clWhite
    end
    object actProductSalesReport: TDNMAction
      Category = 'Sales'
      Caption = 'Product Sales Report'
      ImageIndex = 421
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductSalesReportGUI'
      buttoncolor = clWhite
    end
    object actVoucher: TDNMAction
      Category = 'Sales'
      Caption = 'Voucher(Cash Sale)'
      ImageIndex = 543
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmVoucherSale'
      buttoncolor = clWhite
    end
    object actsalesAnalysisGraph: TDNMAction
      Category = 'Sales'
      Caption = 'Sales Analysis Chart'
      ImageIndex = 639
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmsalesAnalysisGraph'
      buttoncolor = clWhite
    end
    object actEmailList: TDNMAction
      Category = 'Utilities'
      Caption = 'Email List'
      ImageIndex = 399
      OnExecute = AnyActionExecute
      ClassExecute = 'TEmailListGUI'
      buttoncolor = clWhite
    end
    object actEmailPurge: TDNMAction
      Category = 'Utilities'
      Caption = 'Email Purge'
      ImageIndex = 541
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmEmailPurge'
      buttoncolor = clWhite
    end
    object actSalesAnalysisManual: TDNMAction
      Category = 'Employee'
      Caption = 'Sales Analysis (Manual)'
      ImageIndex = 585
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmSalesAnalysisManual'
      buttoncolor = clWhite
    end
    object actSalesAnalysisManualList: TDNMAction
      Category = 'Employee'
      Caption = 'Sales Analysis (Manual) List'
      ImageIndex = 588
      OnExecute = AnyActionExecute
      ClassExecute = 'TSalesAnalysisManualGUI'
      buttoncolor = clWhite
    end
    object actvoucherInvoice: TDNMAction
      Category = 'Sales'
      Caption = 'Voucher(Invoice)'
      ImageIndex = 154
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmvoucherInvoice'
      buttoncolor = clWhite
    end
    object actProfitnLosschart: TDNMAction
      Category = 'Accounts'
      Caption = 'Revenue Chart'
      ImageIndex = 497
      OnExecute = ProfitnLosschart_REv_Exp
      ClassExecute = 'TProfitnLosschartGUI'
      buttoncolor = clWhite
    end
    object actProfitnLosschartCompareGross: TDNMAction
      Tag = -1
      Category = 'Accounts'
      Caption = 'Gross Profit Comparison'
      ImageIndex = 86
      Visible = False
      OnExecute = actProfitnLosschartCompareGrossClick
      ClassExecute = 'TProfitnLosschartCompareGUI'
      buttoncolor = clWhite
    end
    object actProfitnLosschartCompareGrossMonth: TDNMAction
      Category = 'Accounts'
      Caption = 'Monthly Gross Profit Comparison'
      ImageIndex = 407
      OnExecute = actProfitnLosschartCompareGrossClick
      ClassExecute = 'TProfitnLosschartCompareGUI'
      buttoncolor = clWhite
    end
    object actProfitnLosschartCompareGrossQuarter: TDNMAction
      Tag = 1
      Category = 'Accounts'
      Caption = 'Quarterly Gross Profit Comparison'
      ImageIndex = 409
      OnExecute = actProfitnLosschartCompareGrossClick
      ClassExecute = 'TProfitnLosschartCompareGUI'
      buttoncolor = clWhite
    end
    object actProfitnLosschartCompareGrossYear: TDNMAction
      Tag = 2
      Category = 'Accounts'
      Caption = 'Yearly Gross Profit Comparison'
      ImageIndex = 410
      OnExecute = actProfitnLosschartCompareGrossClick
      ClassExecute = 'TProfitnLosschartCompareGUI'
      buttoncolor = clWhite
    end
    object actProfitnLosschartCompareRevenue: TDNMAction
      Tag = -1
      Category = 'Accounts'
      Caption = 'Revenue Comparison'
      ImageIndex = 430
      Visible = False
      OnExecute = actProfitnLosschartCompareRevenueClick
      ClassExecute = 'TProfitnLosschartCompareGUI'
      buttoncolor = clWhite
    end
    object actProfitnLosschartCompareRevenueMonth: TDNMAction
      Category = 'Accounts'
      Caption = 'Monthly Revenue Comparison'
      ImageIndex = 431
      OnExecute = actProfitnLosschartCompareRevenueClick
      ClassExecute = 'TProfitnLosschartCompareGUI'
      buttoncolor = clWhite
    end
    object actProfitnLosschartCompareRevenuequarter: TDNMAction
      Tag = 1
      Category = 'Accounts'
      Caption = 'Quarterly Revenue Comparison'
      ImageIndex = 455
      OnExecute = actProfitnLosschartCompareRevenueClick
      ClassExecute = 'TProfitnLosschartCompareGUI'
      buttoncolor = clWhite
    end
    object actProfitnLosschartCompareRevenueYear: TDNMAction
      Tag = 2
      Category = 'Accounts'
      Caption = 'Yearly Revenue Comparison'
      ImageIndex = 456
      OnExecute = actProfitnLosschartCompareRevenueClick
      ClassExecute = 'TProfitnLosschartCompareGUI'
      buttoncolor = clWhite
    end
    object actProfitnLosschartCompareNI: TDNMAction
      Tag = -1
      Category = 'Accounts'
      Caption = 'Net Income Comparison'
      ImageIndex = 414
      Visible = False
      OnExecute = actProfitnLosschartCompareNIclick
      ClassExecute = 'TProfitnLosschartCompareGUI'
      buttoncolor = clWhite
    end
    object actProfitnLosschartCompareNIMonth: TDNMAction
      Category = 'Accounts'
      Caption = 'Monthly Net Income Comparison'
      ImageIndex = 415
      OnExecute = actProfitnLosschartCompareNIclick
      ClassExecute = 'TProfitnLosschartCompareGUI'
      buttoncolor = clWhite
    end
    object actProfitnLosschartCompareNIQuarter: TDNMAction
      Tag = 1
      Category = 'Accounts'
      Caption = 'Quarterly Net Income Comparison'
      ImageIndex = 424
      OnExecute = actProfitnLosschartCompareNIclick
      ClassExecute = 'TProfitnLosschartCompareGUI'
      buttoncolor = clWhite
    end
    object actProfitnLosschartCompareNIYear: TDNMAction
      Tag = 2
      Category = 'Accounts'
      Caption = 'Yearly Net Income Comparison'
      ImageIndex = 425
      OnExecute = actProfitnLosschartCompareNIclick
      ClassExecute = 'TProfitnLosschartCompareGUI'
      buttoncolor = clWhite
    end
    object actProfitnLosschartgrossProfit: TDNMAction
      Category = 'Accounts'
      Caption = 'Gross Profit Chart'
      ImageIndex = 383
      OnExecute = ProfitnLosschart_GrossProfit
      ClassExecute = 'TProfitnLosschartGUI'
      buttoncolor = clWhite
    end
    object actSmartorderListDetails: TDNMAction
      Category = 'Purchases'
      Caption = 'Supplier Order Totals'
      ImageIndex = 560
      OnExecute = AnyActionExecute
      ClassExecute = 'TSmartorderListDetailsGUI'
      buttoncolor = clWhite
    end
    object actTaxSummaryDetailReport: TDNMAction
      Category = 'Accounts'
      Caption = 'Tax Summary Report (Main Tax)'
      ImageIndex = 576
      OnExecute = AnyActionExecute
      ClassExecute = 'TSubtaxSummaryreport_MainTaxCodeGUI'
      buttoncolor = clWhite
    end
    object actrosterReport: TDNMAction
      Category = 'Employee'
      Caption = 'Roster Report (Summary)'
      ImageIndex = 537
      OnExecute = AnyActionExecute
      ClassExecute = 'TrosterReportGUI'
      buttoncolor = clWhite
    end
    object actRosterReportDetails: TDNMAction
      Category = 'Employee'
      Caption = 'Roster Report (Details)'
      ImageIndex = 538
      OnExecute = AnyActionExecute
      ClassExecute = 'TRosterReportDetailsGUI'
      buttoncolor = clWhite
    end
    object actSiteIntegrationReport: TDNMAction
      Category = 'Utilities'
      Caption = 'Site Integration Report'
      ImageIndex = 586
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmSiteIntegrationReport'
      buttoncolor = clWhite
    end
    object actApprovalLevelList: TDNMAction
      Category = 'Payments'
      Caption = 'Approval Level List'
      ImageIndex = 422
      OnExecute = AnyActionExecute
      ClassExecute = 'TApprovalLevelListGUI'
      buttoncolor = clWhite
    end
    object actApprovalList: TDNMAction
      Category = 'Payments'
      Caption = 'Transaction Approval List'
      ImageIndex = 344
      OnExecute = AnyActionExecute
      ClassExecute = 'TApprovalListGUI'
      buttoncolor = clWhite
    end
    object actHourlySalesReport: TDNMAction
      Category = 'Sales'
      Caption = 'Hourly Sales Report'
      ImageIndex = 637
      OnExecute = AnyActionExecute
      ClassExecute = 'THourlySalesReportGUI'
      buttoncolor = clWhite
    end
    object actEmailReferenceList: TDNMAction
      Category = 'General'
      Caption = 'Email Reference List'
      OnExecute = AnyActionExecute
      ClassExecute = 'TEmailCorrespondenceReferenceListGUI'
      buttoncolor = clWhite
    end
    object actLetterReferenceList: TDNMAction
      Category = 'General'
      Caption = 'Letter Reference List'
      OnExecute = AnyActionExecute
      ClassExecute = 'TLetterCorrespondenceReferenceListGUI'
      buttoncolor = clWhite
    end
    object actAccountrunningBalance: TDNMAction
      Category = 'Accounts'
      Caption = 'Account Running Balance'
      ImageIndex = 423
      OnExecute = AnyActionExecute
      ClassExecute = 'TAccountrunningBalanceGUI'
      buttoncolor = clWhite
    end
    object actCashProfitandLoss: TDNMAction
      Category = 'Accounts'
      Caption = 'Cash Profit and Loss Report'
      ImageIndex = 384
      OnExecute = AnyActionExecute
      ClassExecute = 'TCashProfitandLossGUI'
      buttoncolor = clWhite
    end
    object actPnLEmployeereport: TDNMAction
      Category = 'Accounts'
      Caption = 'Profit And Loss (Area/Employee)'
      ImageIndex = 638
      OnExecute = AnyActionExecute
      ClassExecute = 'TPnLAreaEmployeeReportGUI'
      buttoncolor = clWhite
    end
    object actAreaCode: TDNMAction
      Category = 'General'
      Caption = 'Area Code'
      ImageIndex = 539
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmAreaCode'
      buttoncolor = clWhite
    end
    object actAreacodes: TDNMAction
      Category = 'General'
      Caption = 'Area Code List'
      ImageIndex = 556
      OnExecute = AnyActionExecute
      ClassExecute = 'TAreacodesGUI'
      buttoncolor = clWhite
    end
    object actProductstoExcludeDefaultTaxCode: TDNMAction
      Category = 'Sales'
      Caption = 'Products to Exclude Default Tax Code'
      ImageIndex = 577
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductstoExcludeDefaultTaxCodeGUI'
      buttoncolor = clWhite
    end
    object actEBayOrders: TDNMAction
      Category = 'EBay'
      Caption = 'Ebay Orders'
      ImageIndex = 569
      OnExecute = AnyActionExecute
      ClassExecute = 'TEBayOrdersGUI'
      buttoncolor = clWhite
    end
    object actEBaySalesOrders: TDNMAction
      Category = 'EBay'
      Caption = 'EBay Sales Orders'
      ImageIndex = 570
      OnExecute = AnyActionExecute
      ClassExecute = 'TEBaySalesOrdersGUI'
      buttoncolor = clWhite
    end
    object actAuseParcelconf: TDNMAction
      Category = 'Utilities'
      Caption = 'Aus Post eParcel Conf'
      ImageIndex = 387
      OnExecute = AnyActionExecute
      OnUpdate = actAuseParcelconfUpdate
      ClassExecute = 'TfmAuseParcelconf'
      buttoncolor = clWhite
    end
    object actSalesTaxReport: TDNMAction
      Category = 'Sales'
      Caption = 'Sales Tax Report'
      ImageIndex = 435
      OnExecute = AnyActionExecute
      ClassExecute = 'TSalesTaxReportGUI'
      buttoncolor = clWhite
    end
    object actCleanDatabase: TDNMAction
      Category = 'Utilities'
      Caption = 'Clean Database'
      ImageIndex = 592
      OnExecute = AnyActionExecute
      ClassExecute = 'TDeletetenpTablesGUI'
      buttoncolor = clWhite
    end
    object actWeeklysalesreport: TDNMAction
      Category = 'Sales'
      Caption = 'Weekly Sales Report'
      ImageIndex = 640
      OnExecute = AnyActionExecute
      ClassExecute = 'TWeeklySalesreportGUI'
      buttoncolor = clWhite
    end
    object actFxTrading: TDNMAction
      Category = 'Accounts'
      Caption = 'Fx Trading'
      ImageIndex = 473
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmFxTrading'
      buttoncolor = clWhite
    end
    object actFxTradingList: TDNMAction
      Category = 'Accounts'
      Caption = 'FX Trading List'
      ImageIndex = 475
      OnExecute = AnyActionExecute
      ClassExecute = 'TFxTradingListGUI'
      buttoncolor = clWhite
    end
    object actummarySheets: TDNMAction
      Category = 'Reports'
      Caption = 'Combined Categories'
      ImageIndex = 593
      OnExecute = AnyActionExecute
      ClassExecute = 'TSummarysheetCategoryGUI'
      buttoncolor = clWhite
    end
    object actSummarySheets: TDNMAction
      Category = 'Reports'
      Caption = 'Combined Companies'
      ImageIndex = 591
      OnExecute = AnyActionExecute
      ClassExecute = 'TSummarySheetsGUI'
      buttoncolor = clWhite
    end
    object actcolorPrefs: TDNMAction
      Category = 'Employee'
      Caption = 'Colour Preferences'
      ImageIndex = 583
      OnExecute = actcolorPrefsExecute
      buttoncolor = clWhite
    end
    object actSMSList: TDNMAction
      Category = 'Utilities'
      Caption = 'SMS List'
      ImageIndex = 262
      OnExecute = AnyActionExecute
      ClassExecute = 'TSMSListGUI'
      buttoncolor = clWhite
    end
    object actEmailedReports: TDNMAction
      Category = 'General'
      Caption = 'Emailed Reports Status'
      ImageIndex = 635
      OnExecute = AnyActionExecute
      ClassExecute = 'TEmailedReportsGUI'
      buttoncolor = clWhite
    end
    object actProductReportByPeriod: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Summary (By Period)'
      ImageIndex = 320
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductReportByPeriodGUI'
      buttoncolor = clWhite
    end
    object actCAR: TDNMAction
      Category = 'CRM'
      Caption = 'Corrective Action Reporting'
      ImageIndex = 471
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmCAR'
      buttoncolor = clWhite
    end
    object actCarList: TDNMAction
      Category = 'CRM'
      Caption = 'Corrective Action List'
      ImageIndex = 468
      OnExecute = AnyActionExecute
      ClassExecute = 'TCarListGUI'
      buttoncolor = clWhite
    end
    object actPayHoursList: TDNMAction
      Category = 'Employee'
      Caption = 'Pay Hours List'
      ImageIndex = 389
      OnExecute = AnyActionExecute
      ClassExecute = 'TPayHoursListGUI'
      buttoncolor = clWhite
    end
    object actStockValue: TDNMAction
      Category = 'Inventory'
      Caption = 'Stock Values'
      ImageIndex = 625
      OnExecute = AnyActionExecute
      ClassExecute = 'TStockValue'
      buttoncolor = clWhite
    end
    object actProductBuyPriceList: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Buy Price List'
      ImageIndex = 378
      Visible = False
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductBuyPriceListGUI'
      buttoncolor = clWhite
    end
    object actProductQtyAdjOptions: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Qty Adj Options'
      ImageIndex = 507
      OnExecute = AnyActionExecute
      ClassExecute = 'TFmProductQtyAdjOptions'
      buttoncolor = clWhite
    end
    object actRefundSalesList: TDNMAction
      Category = 'Sales'
      Caption = 'Refund Sales Report'
      ImageIndex = 436
      OnExecute = AnyActionExecute
      ClassExecute = 'TRefundSalesListGUI'
      buttoncolor = clWhite
    end
    object actSupplierSkillList: TDNMAction
      Category = 'Employee'
      Caption = 'Skill Provider List'
      ImageIndex = 511
      OnExecute = AnyActionExecute
      ClassExecute = 'TSupplierSkillListGUI'
      buttoncolor = clWhite
    end
    object actEmployeeTaxList: TDNMAction
      Category = 'Payroll'
      Caption = 'Employee Tax List'
      ImageIndex = 369
      OnExecute = AnyActionExecute
      ClassExecute = 'TEmployeeTaxListGUI'
      buttoncolor = clWhite
    end
    object actPaymentMethodList: TDNMAction
      Category = 'Payments'
      Caption = 'Payment Method List'
      ImageIndex = 359
      OnExecute = AnyActionExecute
      ClassExecute = 'TPaymentMethodListGUI'
      buttoncolor = clWhite
    end
    object actPaymentMethod: TDNMAction
      Category = 'Payments'
      Caption = 'Payment Method'
      ImageIndex = 564
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmPaymentMethod'
      buttoncolor = clWhite
    end
    object actClientMainContacts: TDNMAction
      Category = 'General'
      Caption = 'Client Main Contacts'
      ImageIndex = 636
      OnExecute = AnyActionExecute
      ClassExecute = 'TClientMainContactsGUI'
      buttoncolor = clWhite
    end
    object actShippingList: TDNMAction
      Category = 'Inventory'
      Caption = 'Shipment List'
      ImageIndex = 286
      OnExecute = AnyActionExecute
      ClassExecute = 'TShipmentListFormGUI'
      buttoncolor = clWhite
    end
    object actSalesAddressLabelPrn: TDNMAction
      Category = 'Sales'
      Caption = 'Print Address Label List'
      ImageIndex = 677
      OnExecute = AnyActionExecute
      ClassExecute = 'TSalesAddressLabelPrnGUI'
      buttoncolor = clWhite
    end
    object actsingleSalesAddressLabelPrn: TDNMAction
      Category = 'Sales'
      Caption = 'Print Address Label'
      ImageIndex = 678
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmSalesAddressLabelPrn'
      buttoncolor = clWhite
    end
    object actPOsInvoicedBeforeOrder: TDNMAction
      Category = 'Purchases'
      Caption = 'POs Invoiced Before Ordered'
      ImageIndex = 579
      OnExecute = AnyActionExecute
      ClassExecute = 'TPOsInvoicedBeforeOrderGUI'
      buttoncolor = clWhite
    end
    object actExpenseClaimRequest: TDNMAction
      Category = 'Purchases'
      Caption = 'Expense Claim Request'
      ImageIndex = 557
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmExpenseClaim'
      buttoncolor = clWhite
    end
    object actSmartOrderRFQs: TDNMAction
      Category = 'Purchases'
      Caption = 'Request for Quote'
      ImageIndex = 641
      OnExecute = AnyActionExecute
      ClassExecute = 'TSmartOrderRFQsGUI'
      buttoncolor = clWhite
    end
    object actImportStockAdjustment: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Stock Adjustment Import'
      ImageIndex = 419
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmImportStockAdjustment'
      buttoncolor = 16763647
    end
    object actExportStockAdjustment: TDNMAction
      Category = 'InventoryAdjust'
      Caption = 'Stock Adjustment Export'
      ImageIndex = 420
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmExportStockAdjustment'
      buttoncolor = 16763647
    end
    object actInventoryAssetVsStockStauts: TDNMAction
      Category = 'Accounts'
      Caption = 'Inventory Asset'
      Enabled = False
      ImageIndex = 416
      OnExecute = AnyActionExecute
      ClassExecute = 'TInventoryAssetVsStockStautsGUI'
      buttoncolor = clWhite
    end
    object actInventoryAsset: TDNMAction
      Category = 'Accounts'
      Caption = 'Inventory Asset Vs Balance sheet'
      ImageIndex = 629
      OnExecute = AnyActionExecute
      ClassExecute = 'TInventoryAssetVsStockStautsGUI'
      buttoncolor = clWhite
    end
    object actAreaPOLinesDetailsList: TDNMAction
      Category = 'Inventory'
      Caption = 'Area Product List'
      ImageIndex = 293
      OnExecute = AnyActionExecute
      ClassExecute = 'TAreaPOLinesDetailsListGUI'
      buttoncolor = clWhite
    end
    object actUOMList: TDNMAction
      Category = 'Inventory'
      Caption = 'UOM List (Merge / Delete)'
      ImageIndex = 578
      OnExecute = AnyActionExecute
      ClassExecute = 'TUOMListGUI'
      buttoncolor = clWhite
    end
    object actInt_ATO: TDNMAction
      Category = 'Integration'
      Caption = 'Australian Tax Office'
      ImageIndex = 437
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_AustPostParcel: TDNMAction
      Category = 'Integration'
      Caption = 'Aust Post Parcel'
      ImageIndex = 438
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_CanadaPost: TDNMAction
      Category = 'Integration'
      Caption = 'Canada Post'
      ImageIndex = 647
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_CustomerPortal: TDNMAction
      Category = 'Integration'
      Caption = 'Customer Portal'
      ImageIndex = 447
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_Cytrack: TDNMAction
      Category = 'Integration'
      Caption = 'Cytrack'
      ImageIndex = 643
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_Ebay: TDNMAction
      Category = 'Integration'
      Caption = 'Ebay'
      ImageIndex = 434
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_Eftpos: TDNMAction
      Category = 'Integration'
      Caption = 'Eftpos'
      ImageIndex = 440
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_FedEx: TDNMAction
      Category = 'Integration'
      Caption = 'FedEx'
      ImageIndex = 454
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object avtInt_Fuel: TDNMAction
      Category = 'Integration'
      Caption = 'Fuel'
      ImageIndex = 442
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_GoogleAnalytics: TDNMAction
      Category = 'Integration'
      Caption = 'Google Analytics'
      ImageIndex = 448
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_PNET: TDNMAction
      Category = 'Integration'
      Caption = 'PNET'
      ImageIndex = 439
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_OPOS: TDNMAction
      Category = 'Integration'
      Caption = 'OPOS'
      ImageIndex = 441
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_ShoppingCart: TDNMAction
      Category = 'Integration'
      Caption = 'Shopping Cart'
      ImageIndex = 446
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_SMS: TDNMAction
      Category = 'Integration'
      Caption = 'SMS'
      ImageIndex = 451
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_Telstra: TDNMAction
      Category = 'Integration'
      Caption = 'Telstra'
      ImageIndex = 760
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_TNT: TDNMAction
      Category = 'Integration'
      Caption = 'TNT'
      ImageIndex = 642
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_UPS: TDNMAction
      Category = 'Integration'
      Caption = 'UPS'
      ImageIndex = 450
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_USPS: TDNMAction
      Category = 'Integration'
      Caption = 'USPS'
      ImageIndex = 452
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_Web: TDNMAction
      Category = 'Integration'
      Caption = 'Web'
      ImageIndex = 445
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_XML: TDNMAction
      Category = 'Integration'
      Caption = 'XML'
      ImageIndex = 644
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_Target: TDNMAction
      Category = 'Integration'
      Caption = 'Target'
      ImageIndex = 756
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_Sony: TDNMAction
      Category = 'Integration'
      Caption = 'Sony'
      ImageIndex = 757
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_Seagate: TDNMAction
      Category = 'Integration'
      Caption = 'Seagate'
      ImageIndex = 758
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_Erico: TDNMAction
      Category = 'Integration'
      Caption = 'Erico'
      ImageIndex = 759
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actCustomAccountsReport: TDNMAction
      Category = 'Accounts'
      Caption = 'Accounts Report'
      ImageIndex = 529
      Visible = False
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomAccountsReportGUI'
      buttoncolor = clWhite
    end
    object actCustomAccountsReportTree: TDNMAction
      Category = 'Accounts'
      Caption = 'Accounts Report (Tree)'
      ImageIndex = 530
      Visible = False
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomAccountsReportTreeGUI'
      buttoncolor = clWhite
    end
    object actClockedOnList: TDNMAction
      Category = 'Employee'
      Caption = 'Clock On List'
      ImageIndex = 540
      OnExecute = AnyActionExecute
      ClassExecute = 'TClockedOnListGUI'
      buttoncolor = clWhite
    end
    object actRosterBreakList: TDNMAction
      Category = 'Employee'
      Caption = 'Roster history'
      ImageIndex = 553
      OnExecute = AnyActionExecute
      ClassExecute = 'TRosterBreakListGUI'
      buttoncolor = clWhite
    end
    object actProductPriceList: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Price List'
      ImageIndex = 587
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductPriceListGUI'
      buttoncolor = clWhite
    end
    object actERPTip: TDNMAction
      Category = 'Utilities'
      Caption = 'ERP Tip'
      OnExecute = actERPTipExecute
      buttoncolor = clWhite
    end
    object actsalesdispatch: TDNMAction
      Category = 'Sales'
      Caption = 'Sales Dispatch'
      ImageIndex = 628
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmSalesDispatch'
      buttoncolor = clWhite
    end
    object actSalesDispatches: TDNMAction
      Category = 'Sales'
      Caption = 'Sales Dispatches'
      ImageIndex = 632
      OnExecute = AnyActionExecute
      ClassExecute = 'TSalesDispatchesGUI'
      buttoncolor = clWhite
    end
    object actSalesDispatchBatches: TDNMAction
      Category = 'Sales'
      Caption = 'Sales Dispatch Batches'
      ImageIndex = 584
      OnExecute = AnyActionExecute
      ClassExecute = 'TSalesDispatchBatchesGUI'
      buttoncolor = clWhite
    end
    object actProjectInstallations: TDNMAction
      Category = 'Appointments'
      Caption = 'Managers Roster'
      ImageIndex = 388
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmProjectInstallationRoster'
      buttoncolor = clWhite
    end
    object actSetupPayroll: TDNMAction
      Category = 'Payroll'
      Caption = 'Payroll Setup'
      ImageIndex = 737
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmSetupPayroll'
      buttoncolor = clWhite
    end
    object actSaleCostAndProfit: TDNMAction
      Category = 'Sales'
      Caption = 'Sale Cost and Profit'
      ImageIndex = 87
      OnExecute = AnyActionExecute
      ClassExecute = 'TSaleCostListGUI'
      buttoncolor = clWhite
    end
    object actInt_ePadLink: TDNMAction
      Category = 'Integration'
      Caption = 'ePad Link'
      ImageIndex = 763
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_Scanner: TDNMAction
      Category = 'Integration'
      Caption = 'Scanner'
      ImageIndex = 764
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actERPChanges: TDNMAction
      Category = 'Utilities'
      Caption = 'ERP Changes'
      ImageIndex = 5
      OnExecute = AnyActionExecute
      ClassExecute = 'TERPChangesGUI'
      buttoncolor = clWhite
    end
    object actSalesOrderProgressPayments: TDNMAction
      Category = 'Sales'
      Caption = 'Sales Order Progress Payments'
      ImageIndex = 79
      OnExecute = AnyActionExecute
      ClassExecute = 'TSalesOrderProgressPaymentsGUI'
      buttoncolor = clWhite
    end
    object actSetupEmployee: TDNMAction
      Category = 'Employee'
      Caption = 'Setup Employee'
      ImageIndex = 509
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmEmployeeSetup'
      buttoncolor = clWhite
    end
    object actProductQtyinCrossStockCompanies: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Qty in Cross Stock Companies'
      ImageIndex = 626
      OnExecute = AnyActionExecute
      OnUpdate = actProductQtyinCrossStockCompaniesUpdate
      ClassExecute = 'TProductQtyinCrossStockCompaniesGUI'
      buttoncolor = clWhite
    end
    object actInventoryAssetCheckList: TDNMAction
      Category = 'Inventory'
      Caption = 'Inventory Asset Check List'
      ImageIndex = 670
      OnExecute = AnyActionExecute
      ClassExecute = 'TInventoryAssetCheckListByProductGUI'
      buttoncolor = clWhite
    end
    object actUnInvoicedPOList: TDNMAction
      Category = 'Purchases'
      Caption = 'Un Invoiced PO List'
      ImageIndex = 679
      OnExecute = AnyActionExecute
      ClassExecute = 'TUnInvoicedPOListGUI'
      buttoncolor = clWhite
    end
    object actSpecialForm: TDNMAction
      Category = 'Utilities'
      Caption = 'Special Form'
      ImageIndex = 72
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmSpecial'
      buttoncolor = clWhite
    end
    object actFileImportAPI: TDNMAction
      Category = 'File'
      Caption = 'Import API'
      ImageIndex = 228
      OnExecute = actFileImportAPIExecute
      buttoncolor = clWhite
    end
    object actNonERPSalesList: TDNMAction
      Category = 'Sales'
      Caption = 'Non ERP Sales'
      ImageIndex = 680
      OnExecute = AnyActionExecute
      ClassExecute = 'TNonERPSalesListGUI'
      buttoncolor = clWhite
    end
    object actNonERPPOList: TDNMAction
      Category = 'Purchases'
      Caption = 'Non ERP Purchases'
      ImageIndex = 680
      OnExecute = AnyActionExecute
      ClassExecute = 'TNonERPPOListGUI'
      buttoncolor = clWhite
    end
    object actPhoneSupportLogList: TDNMAction
      Category = 'Appointments'
      Caption = 'Phone Support Log Details'
      ImageIndex = 654
      OnExecute = AnyActionExecute
      ClassExecute = 'TPhoneSupportLogListGUI'
      buttoncolor = clWhite
    end
    object actHRForm: TDNMAction
      Category = 'General'
      Caption = 'HR Form'
      ImageIndex = 681
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmHRForm'
      buttoncolor = clWhite
    end
    object actHRForms: TDNMAction
      Category = 'General'
      Caption = 'HR List'
      ImageIndex = 721
      OnExecute = AnyActionExecute
      ClassExecute = 'THRFormsGUI'
      buttoncolor = clWhite
    end
    object actDutynHandlingProductList: TDNMAction
      Category = 'Inventory'
      Caption = 'Duty n Handling Product List'
      ImageIndex = 657
      OnExecute = AnyActionExecute
      ClassExecute = 'TDutynHandlingProductListGUI'
      buttoncolor = clWhite
    end
    object actStateFreightChargeList: TDNMAction
      Category = 'General'
      Caption = 'State Freight Charges'
      ImageIndex = 554
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmStateFreightList'
      buttoncolor = clWhite
    end
    object actSimpleTypes: TDNMAction
      Category = 'General'
      Caption = 'Type Codes'
      ImageIndex = 664
      OnExecute = AnyActionExecute
      ClassExecute = 'TSimpleTypesGUI'
      buttoncolor = clWhite
    end
    object actProductcustomFieldList: TDNMAction
      Category = 'Inventory'
      Caption = 'Product List(Custom Fields)'
      ImageIndex = 732
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductcustomFieldListGUI'
      buttoncolor = clWhite
    end
    object actIncomingCustomerOrders: TDNMAction
      Category = 'Purchases'
      Caption = 'Incoming Customer Orders'
      ImageIndex = 487
      OnExecute = AnyActionExecute
      ClassExecute = 'TIncomingCustomerOrdersGUI'
      buttoncolor = clWhite
    end
    object actPurchaseList: TDNMAction
      Category = 'Purchases'
      Caption = 'Incoming Orders'
      ImageIndex = 683
      OnExecute = AnyActionExecute
      ClassExecute = 'TIncomingOrdersList'
      buttoncolor = clWhite
    end
    object actEmployeePayrollSuperByFund: TDNMAction
      Category = 'Payroll'
      Caption = 'Super By Fund'
      ImageIndex = 656
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmSuperFundListGUI'
      buttoncolor = clWhite
    end
    object actInventProductsProductsExpressList: TDNMAction
      Category = 'Inventory'
      Caption = 'Products Express List'
      ImageIndex = 272
      OnExecute = OpenProductList
      ClassExecute = 'TProductListExpressGUI'
      Description = 'Prdcts Exp Lst'
      buttoncolor = clWhite
    end
    object actProductsWithBlanknameList: TDNMAction
      Category = 'Inventory'
      Caption = 'Invalid Products With Blank Product Name'
      ImageIndex = 272
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductsWithBlanknameListGUI'
      Description = 'Prdcts Exp Lst'
      buttoncolor = clWhite
    end
    object actChooseProductList: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Options List'
      ImageIndex = 250
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmChooseProductList'
      buttoncolor = clWhite
    end
    object actProductQtylist: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Qty List'
      ImageIndex = 693
      OnExecute = OpenProductList
      ClassExecute = 'TProductQtylistGUI'
      buttoncolor = clWhite
    end
    object actInventProductsProductsList: TDNMAction
      Category = 'Inventory'
      Caption = 'Products List'
      ImageIndex = 80
      OnExecute = OpenProductList
      ClassExecute = 'TProductListGUI'
      buttoncolor = clWhite
    end
    object actInventProductsProductsList1: TDNMAction
      Category = 'Inventory'
      Caption = 'Products List'
      ImageIndex = 80
      Visible = False
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductListGUI'
      buttoncolor = clWhite
    end
    object actProductQtylist1: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Qty List'
      ImageIndex = 693
      Visible = False
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductQtylistGUI'
      buttoncolor = clWhite
    end
    object actInventProductsProductsExpressList1: TDNMAction
      Category = 'Inventory'
      Caption = 'Products Express List'
      ImageIndex = 272
      Visible = False
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductListExpressGUI'
      Description = 'Prdcts Exp Lst'
      buttoncolor = clWhite
    end
    object actStockanalysisReport: TDNMAction
      Category = 'Sales'
      Caption = 'Stock Analysis Report'
      ImageIndex = 671
      OnExecute = actStockanalysisReportExecute
      ClassExecute = 'TStockAnalysisDetailsReportGUI'
      buttoncolor = clWhite
    end
    object actProjectedManufacturingQty: TDNMAction
      Category = 'Inventory'
      Caption = 'Projected Manufacturing Qty'
      ImageIndex = 700
      OnExecute = AnyActionExecute
      ClassExecute = 'TProjectedManufacturingQtyGUI'
      buttoncolor = clWhite
    end
    object actProductSerialNumberQtyList: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Serial Number Qty List'
      ImageIndex = 711
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductSerialNumberQtyListGUI'
      buttoncolor = clWhite
    end
    object actContractorPaymentSummary: TDNMAction
      Category = 'Accounts'
      Caption = 'Contractor Payment Summary'
      ImageIndex = 476
      OnExecute = AnyActionExecute
      ClassExecute = 'TContractorPaymentSummaryGUI'
      buttoncolor = clWhite
    end
    object actProductStockAndSalesList: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Stock And Sales List'
      ImageIndex = 672
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductStockAndSalesListGUI'
      buttoncolor = clWhite
    end
    object actGoodsReceipt: TDNMAction
      Category = 'Inventory'
      Caption = 'Goods Receipt'
      ImageIndex = 687
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmGoodsReceipt'
      buttoncolor = clWhite
    end
    object actGoodsReceiptList: TDNMAction
      Category = 'Inventory'
      Caption = 'Goods Receipt List'
      ImageIndex = 689
      OnExecute = AnyActionExecute
      ClassExecute = 'TGoodsReceiptListGUI'
      buttoncolor = clWhite
    end
    object actMainswitchHeightdecrease: TDNMAction
      Category = 'Mainswitch'
      Caption = 'Main Form - Decrease Height'
      ImageIndex = 696
      OnExecute = actMainswitchHeightdecreaseExecute
      buttoncolor = clWhite
    end
    object actMainswitchHeightDefault: TDNMAction
      Category = 'Mainswitch'
      Caption = 'Main Form - Default Height'
      ImageIndex = 386
      OnExecute = actMainswitchHeightDefaultExecute
      buttoncolor = clWhite
    end
    object actSerialNumbers: TDNMAction
      Category = 'Inventory'
      Caption = 'Serial Numbers (All)'
      ImageIndex = 716
      OnExecute = AnyActionExecute
      ClassExecute = 'TSerialNumberListCurrentGUI'
      buttoncolor = clWhite
    end
    object actBankTransactionList: TDNMAction
      Category = 'Banking'
      Caption = 'Bank Transaction List'
      ImageIndex = 659
      OnExecute = AnyActionExecute
      ClassExecute = 'TBankStatementLineListGUI'
      buttoncolor = clWhite
    end
    object actBankTransactionImport: TDNMAction
      Category = 'Banking'
      Caption = 'Bank Transaction Import'
      ImageIndex = 697
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmBankStatmentImport'
      buttoncolor = clWhite
    end
    object actSerialNoTabletAllocation: TDNMAction
      Category = 'Utilities'
      Caption = 'Serial No Tablet Allocation'
      ImageIndex = 714
      OnExecute = AnyActionExecute
      ClassExecute = 'TSerialNoTabletAllocationGUI'
      buttoncolor = clWhite
    end
    object actPriceMatrixHelp: TDNMAction
      Category = 'Inventory'
      Caption = 'How To - Price Matrix'
      ImageIndex = 746
      OnExecute = actPriceMatrixHelpExecute
      buttoncolor = clWhite
    end
    object actAlternateProductList: TDNMAction
      Category = 'Inventory'
      Caption = 'Alternate Product List'
      ImageIndex = 702
      OnExecute = AnyActionExecute
      ClassExecute = 'TAlternateProductsGUI'
      buttoncolor = clWhite
    end
    object actBackorderPurchaseOrderChangeList: TDNMAction
      Category = 'Purchases'
      Caption = 'BO PO Change List'
      ImageIndex = 701
      OnExecute = AnyActionExecute
      ClassExecute = 'TBackorderPurchaseOrderChangeListGUI'
      buttoncolor = clWhite
    end
    object actAlternateProducts: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Buy Price List'
      ImageIndex = 712
      OnExecute = AnyActionExecute
      ClassExecute = 'TAlternateProductsEBPGUI'
      buttoncolor = clWhite
    end
    object actUserPasswordDetails: TDNMAction
      Category = 'Utilities'
      Caption = 'User Password Details'
      ImageIndex = 704
      OnExecute = AnyActionExecute
      ClassExecute = 'TUserPasswordDetailsGUI'
      buttoncolor = clWhite
    end
    object actPrejerence: TDNMAction
      Category = 'Utilities'
      Caption = 'Prejerence List'
      ImageIndex = 727
      OnExecute = AnyActionExecute
      ClassExecute = 'TPrejerenceToExportGUI'
      buttoncolor = clWhite
    end
    object actEmpPayRunList: TDNMAction
      Category = 'Payroll'
      Caption = 'Pay Run List (Single Touch Payroll)'
      ImageIndex = 703
      OnExecute = AnyActionExecute
      ClassExecute = 'TPayRunListGUI'
      buttoncolor = clWhite
    end
    object actAmazonEdiOrderList: TDNMAction
      Category = 'Integration'
      Caption = 'Amazon Order List'
      ImageIndex = 705
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmEdiOrderAmazonList'
      buttoncolor = clWhite
    end
    object actInt_Amazon: TDNMAction
      Category = 'Integration'
      Caption = 'Amazon'
      ImageIndex = 781
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actAmazonSalesOrderExpressList: TDNMAction
      Category = 'Integration'
      Caption = 'Amazon Sales Order List'
      ImageIndex = 708
      OnExecute = AnyActionExecute
      ClassExecute = 'TAmazonSalesOrderExpressGUI'
      buttoncolor = clWhite
    end
    object actAmazonInvoiceExpressList: TDNMAction
      Category = 'Integration'
      Caption = 'Amazon Invoice List'
      ImageIndex = 709
      OnExecute = AnyActionExecute
      ClassExecute = 'TAmazonInvoiceListExpressGUI'
      buttoncolor = clWhite
    end
    object actVATObligationList: TDNMAction
      Category = 'Payroll'
      Caption = 'VAT Obligation List'
      ImageIndex = 710
      OnExecute = AnyActionExecute
      ClassExecute = 'TVATObligationsGUI'
      buttoncolor = clWhite
    end
    object DNMAction1: TDNMAction
      Category = 'Utilities'
      Caption = 'Template Reports List'
      ImageIndex = 324
      OnExecute = AnyActionExecute
      ClassExecute = 'TReportTemplateListGUI'
      buttoncolor = clWhite
    end
    object actUSPayrollforms: TDNMAction
      Category = 'Payroll'
      Caption = 'US Payroll Forms'
      ImageIndex = 324
      OnExecute = AnyActionExecute
      ClassExecute = 'TUSPayrollformsGUI'
      buttoncolor = clWhite
    end
    object acttrialbalanceadjsutemnt: TDNMAction
      Category = 'Accounts'
      Caption = 'Trial Balance Adjustment'
      ImageIndex = 361
      Visible = False
      OnExecute = AnyActionExecute
      ClassExecute = 'Tfmtrialbalanceadjsutemnt'
      buttoncolor = clWhite
    end
    object actint_SPS: TDNMAction
      Category = 'Integration'
      Caption = 'SPS'
      ImageIndex = 769
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actint_Magento: TDNMAction
      Category = 'Integration'
      Caption = 'Magento'
      ImageIndex = 770
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actint_AvaTax: TDNMAction
      Category = 'Integration'
      Caption = 'Avalara Tax'
      ImageIndex = 812
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_GoogleCalendar: TDNMAction
      Category = 'Integration'
      Caption = 'Google Calendar'
      ImageIndex = 813
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_HMRC: TDNMAction
      Category = 'Integration'
      Caption = 'HMRC'
      ImageIndex = 772
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_Stripe: TDNMAction
      Category = 'Integration'
      Caption = 'Stripe'
      ImageIndex = 774
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_PaymentExpress: TDNMAction
      Category = 'Integration'
      Caption = 'Payment Express'
      ImageIndex = 775
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_Payeezy: TDNMAction
      Category = 'Integration'
      Caption = 'Payeezy'
      ImageIndex = 776
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_Endica: TDNMAction
      Category = 'Integration'
      Caption = 'Endica'
      ImageIndex = 777
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_VAT: TDNMAction
      Category = 'Integration'
      Caption = 'VAT'
      ImageIndex = 778
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_ERPAPI: TDNMAction
      Category = 'Integration'
      Caption = 'ERP API'
      ImageIndex = 779
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actInt_Stamps: TDNMAction
      Category = 'Integration'
      Caption = 'Stamps'
      ImageIndex = 779
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actProductSumQtyList: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Qty API List'
      ImageIndex = 719
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductSumQtyListGUI'
      buttoncolor = clWhite
    end
    object actQuickbooksSynchList: TDNMAction
      Category = 'Integration'
      Caption = 'Quickbooks Synch List'
      ImageIndex = 717
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmQuickbooksSynchList'
      buttoncolor = clWhite
    end
    object actMagentoOrders: TDNMAction
      Category = 'Integration'
      Caption = 'Magento Orders'
      ImageIndex = 717
      OnExecute = AnyActionExecute
      ClassExecute = 'TMagentoOrdersGUI'
      buttoncolor = clWhite
    end
    object actEDISynchList: TDNMAction
      Category = 'Integration'
      Caption = 'EDI Synch List'
      ImageIndex = 717
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmEDISynchList'
      buttoncolor = clWhite
    end
    object actInt_EDISynch: TDNMAction
      Category = 'Integration'
      Caption = 'EDI Synch'
      ImageIndex = 52
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actMagentoProducts: TDNMAction
      Category = 'Integration'
      Caption = 'Magento Products'
      ImageIndex = 787
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductsForMagentoGUI'
      buttoncolor = clWhite
    end
    object actMagentoCustomers: TDNMAction
      Category = 'Integration'
      Caption = 'Magento Customers'
      ImageIndex = 789
      OnExecute = AnyActionExecute
      ClassExecute = 'TMagentoCustomersGUI'
      buttoncolor = clWhite
    end
    object actERPUpdateFix: TDNMAction
      Category = 'Utilities'
      Caption = 'ERP Update Fix'
      ImageIndex = 725
      OnExecute = AnyActionExecute
      ClassExecute = 'TERPUpdateFixGUI'
      buttoncolor = clWhite
    end
    object actProductOptions: TDNMAction
      Category = 'Inventory'
      Caption = 'Product Options'
      ImageIndex = 151
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmProductOptionsMain'
      buttoncolor = clWhite
    end
    object actEDIConnectionsList: TDNMAction
      Category = 'Integration'
      Caption = 'EDI Connections List'
      ImageIndex = 118
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmEDIConnectionsList'
      buttoncolor = clWhite
    end
    object actint_CoreEDIService: TDNMAction
      Category = 'Integration'
      Caption = 'Setup CoreEDI Service'
      ImageIndex = 52
      OnExecute = actIntegrationExecute
      buttoncolor = clWhite
    end
    object actint_CoreEDIService_Help: TDNMAction
      Category = 'Integration'
      Caption = 'How to Setup CoreEDI Service'
      ImageIndex = 746
      OnExecute = actint_CoreEDIService_HelpExecute
      buttoncolor = clWhite
    end
    object actColesSalesOrderExpressList: TDNMAction
      Category = 'Coles'
      Caption = 'Coles Purchase Order Express List'
      ImageIndex = 85
      OnExecute = AnyActionExecute
      ClassExecute = 'TColesSaleslistExpressGUI'
      buttoncolor = clWhite
    end
    object actColesORDRSPExpressList: TDNMAction
      Category = 'Coles'
      Caption = 'Coles Purchase Order Response Express List'
      ImageIndex = 85
      OnExecute = AnyActionExecute
      ClassExecute = 'TColesORDRSPExpressListGUI'
      buttoncolor = clWhite
    end
    object actColesInvoiceExpressList: TDNMAction
      Category = 'Coles'
      Caption = 'Coles Invoice Express List'
      ImageIndex = 85
      OnExecute = AnyActionExecute
      ClassExecute = 'TColesInvoicelistExpressGUI'
      buttoncolor = clWhite
    end
    object actColesDESADVExpressList: TDNMAction
      Category = 'Coles'
      Caption = 'Coles Despatch Advice Order Express List'
      ImageIndex = 85
      OnExecute = AnyActionExecute
      ClassExecute = 'TColesDESADVExpressListGUI'
      buttoncolor = clWhite
    end
    object actColesREMADVExpressList: TDNMAction
      Category = 'Coles'
      Caption = 'Coles Remittance Advice Express List'
      ImageIndex = 85
      OnExecute = AnyActionExecute
      ClassExecute = 'TColesCustPaymentListGUI'
      buttoncolor = clWhite
    end
    object actPayrollDataRecoverFix: TDNMAction
      Category = 'Payroll'
      Caption = 'Payroll Data Recover Fix'
      ImageIndex = 85
      OnExecute = AnyActionExecute
      ClassExecute = 'TPayrollDataRecoverFixGUI'
      buttoncolor = clWhite
    end
  end
  object dlgCurrentUsers: TSelectionDialog
    Caption = 'ERP Users'
    Message = ' Current ERP Users '
    MessageFont.Charset = ANSI_CHARSET
    MessageFont.Color = clNavy
    MessageFont.Height = -12
    MessageFont.Name = 'Arial'
    MessageFont.Style = [fsBold]
    Buttons = [sbOK]
    MultiSelect = False
    Width = 370
    Height = 250
    Color = clMoneyGreen
    Left = 31
    Top = 71
  end
  object MainMenu: TAdvMainMenu
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 72
    Top = 15
    object File2: TMenuItem
      Caption = '&File'
      Hint = 'File related commands'
      object NewCompany2: TMenuItem
        Action = actFileNewCompany
      end
      object OpenCompany2: TMenuItem
        Action = actFileOpenCompany
      end
      object N126: TMenuItem
        Caption = '-'
      end
      object Export2: TMenuItem
        Caption = 'Export'
        GroupIndex = 190
        object ExportData2: TMenuItem
          Action = actFileExportData
        end
        object ExportTemplates2: TMenuItem
          Action = actFileExportTemplates
        end
        object CustomExport1: TMenuItem
          Action = actCustomExport
        end
        object ExportToReportDB1: TMenuItem
          Action = actUtilsExportToReportDB
          GroupIndex = 190
        end
      end
      object Import1: TMenuItem
        Caption = 'Import'
        GroupIndex = 190
        object CustomImports2: TMenuItem
          Action = actCustomImports
        end
        object Data1: TMenuItem
          Action = actFileImportData
        end
        object ImportAPI1: TMenuItem
          Action = actFileImportAPI
        end
        object ImportTemplates1: TMenuItem
          Action = actFileImportTemplates
        end
        object NT1: TMenuItem
          Caption = 'TNT'
          object ClientRates1: TMenuItem
            Action = actFileImportTNTClientRates
          end
          object PostcodetoRatingAreaZone1: TMenuItem
            Action = actFileImportTNTPostcodeToRating
          end
        end
      end
      object N37: TMenuItem
        Caption = '-'
        GroupIndex = 190
      end
      object HowTo1: TMenuItem
        Caption = 'How To'
        GroupIndex = 190
        object InstallingTestServer1: TMenuItem
        end
        object UploadingaBackupToERP1: TMenuItem
        end
        object mnuSettingupOffsiteBackup: TMenuItem
        end
      end
      object N1: TMenuItem
        Caption = '-'
        GroupIndex = 190
      end
      object Exit2: TMenuItem
        Caption = 'E&xit'
        Default = True
        GroupIndex = 190
        Hint = 'Exit|Exit application'
        OnClick = actFileExitExecute
      end
      object ActiveForms2: TMenuItem
        Caption = 'Active Forms'
        GroupIndex = 190
        OnClick = ActiveForms2Click
      end
    end
    object Accounts2: TMenuItem
      Caption = 'Accou&nts'
      GroupIndex = 10
      object Accounts1: TMenuItem
        Caption = 'Accounts'
        GroupIndex = 10
        object Account2: TMenuItem
          Action = actAccountsAccount
          GroupIndex = 100
        end
        object AccountsList2: TMenuItem
          Action = actAccountsAccountsList
          GroupIndex = 100
        end
        object AccountRunningBalance1: TMenuItem
          Action = actAccountrunningBalance
          GroupIndex = 100
        end
        object N225: TMenuItem
          Caption = '-'
          GroupIndex = 100
        end
        object AccountTypeList2: TMenuItem
          Action = actAccountsAccountTypeList
          GroupIndex = 100
        end
        object FxTrading1: TMenuItem
          Action = actFxTradingList
          GroupIndex = 100
        end
        object N34: TMenuItem
          Caption = '-'
          GroupIndex = 100
        end
        object PnLCompareGross1: TMenuItem
          Caption = 'Profit and Loss Charts'
          GroupIndex = 100
          ImageIndex = 498
          object ProfitandLosscharts1: TMenuItem
            Action = actProfitnLosschartCompareGross
            GroupIndex = 100
          end
          object PnLCompareRevenue1: TMenuItem
            Action = actProfitnLosschartCompareRevenue
            GroupIndex = 100
          end
          object GrossProfitChart1: TMenuItem
            Action = actProfitnLosschartCompareNI
            GroupIndex = 100
          end
        end
      end
      object mnuTaxreport: TMenuItem
        Caption = 'Bas / VAT / GST'
        GroupIndex = 10
        object BASReport1: TMenuItem
          Action = actReportsBAS
        end
        object BASReportList1: TMenuItem
          Action = actReportsBASList
        end
      end
      object JournalEntry1: TMenuItem
        Caption = 'Journal Entries'
        GroupIndex = 20
        object JournalEntry2: TMenuItem
          Action = actAccountsJournalEntry
          GroupIndex = 100
        end
        object JournalEntryList2: TMenuItem
          Action = actAccountsJournalEntryList
          GroupIndex = 100
        end
        object JournalEntries1: TMenuItem
          Action = actAccountsJournalEntries
          GroupIndex = 100
        end
      end
      object ForeignExchangeRates2: TMenuItem
        Caption = 'Foreign Exchange Rates'
        GroupIndex = 100
        object ForeignPurchaseReport2: TMenuItem
          Action = actAccountsForeignExchangeRate
        end
        object ForeignExchangeRatesList1: TMenuItem
          Action = actAccountsForeignExchangeRatesList
        end
        object ForeignExchangeHistoryList1: TMenuItem
          Action = actAccountsForeignExchangeHistoryList
        end
      end
      object About2: TMenuItem
        Caption = 'Tax Code'
        GroupIndex = 100
        ImageIndex = 583
        OnClick = AnyActionExecute
        object axCodeList1: TMenuItem
          Action = actAccountsTaxCode
          GroupIndex = 100
        end
        object axCodeList3: TMenuItem
          Action = actAccountsTaxCodeList
          GroupIndex = 100
        end
        object N27: TMenuItem
          Caption = '-'
          GroupIndex = 100
        end
        object SubTaxCode2: TMenuItem
          Action = actSubTaxcode
          GroupIndex = 100
        end
        object SubTaxCodeList1: TMenuItem
          Action = actSubTaxcodes
          GroupIndex = 100
        end
      end
      object N7: TMenuItem
        Caption = '-'
        GroupIndex = 100
      end
      object FixedAssets3: TMenuItem
        Caption = 'Fixed Assets'
        GroupIndex = 100
        object FixedAsset1: TMenuItem
          Caption = 'Fixed Asset'
          object FixedAsset2: TMenuItem
            Action = actFixedAssetsFixedAsset
            GroupIndex = 90
          end
          object FixedAssetsList2: TMenuItem
            Action = actFixedAssetsFixedAssetsList
            GroupIndex = 90
          end
        end
        object FixedAssetType2: TMenuItem
          Caption = 'Fixed Asset Type'
          GroupIndex = 90
          ImageIndex = 474
          object FixedAssetType1: TMenuItem
            Action = actFixedAssetsFixedAssetType
            GroupIndex = 90
          end
          object FixedAssetTypesList2: TMenuItem
            Action = actFixedAssetsFixedAssetTypesList
            GroupIndex = 90
          end
        end
        object ServiceLogs1: TMenuItem
          Caption = 'Service Logs'
          GroupIndex = 90
          object ServiceLog2: TMenuItem
            Action = actFixedAssetsServiceLog
            GroupIndex = 90
          end
          object ServiceLogList2: TMenuItem
            Action = actFixedAssetsServiceLogList
            GroupIndex = 90
          end
        end
        object N210: TMenuItem
          Caption = '-'
          GroupIndex = 90
        end
        object AssetRegisterReport1: TMenuItem
          Action = actAssetRegisterList
          GroupIndex = 90
        end
        object WarrantyInsurancePolicyReport2: TMenuItem
          Action = actFixedAssetsDetails
          GroupIndex = 90
        end
        object CheckWarrantiesInsurancePolicy2: TMenuItem
          Action = actFixedAssetsCheckWarrantiesInsurancePolicy
          GroupIndex = 90
        end
      end
      object N217: TMenuItem
        Caption = '-'
        GroupIndex = 100
      end
      object BalanceSheet2: TMenuItem
        Action = actAccountsBalanceSheet
        GroupIndex = 100
      end
      object CashProfitandLossReport1: TMenuItem
        Action = actCashProfitandLoss
        GroupIndex = 100
      end
      object JobProfitAndLoss1: TMenuItem
        Action = actAccountsjobProfitAndLoss
        GroupIndex = 100
      end
      object ProfitAndLoss2: TMenuItem
        Action = actAccountsProfitAndLoss
        GroupIndex = 100
      end
      object ProfitAndLossByPeriod2: TMenuItem
        Action = actAccountsProfitAndLossByPeriod
        GroupIndex = 100
      end
      object PnLEmployee1: TMenuItem
        Action = actPnLEmployeereport
        GroupIndex = 100
      end
      object ransactionJournal1: TMenuItem
        Action = actPaymentsTransactionJournal
        GroupIndex = 100
      end
      object TrialBalance2: TMenuItem
        Action = actAccountsTrialBalance
        GroupIndex = 100
      end
      object N16: TMenuItem
        Caption = '-'
        GroupIndex = 100
      end
      object AccountsPayableReport3: TMenuItem
        Action = actPaymentsAccountsPayableReport
        GroupIndex = 100
      end
      object AccountsReceivableReport3: TMenuItem
        Action = actPaymentsAccountsReceivableReport
        GroupIndex = 100
      end
      object AuditTrailList1: TMenuItem
        Action = actUtilsAuditTrailAuditTrailList
        GroupIndex = 100
      end
      object BankAccountReport3: TMenuItem
        Action = actPaymentsBankAccountReport
        GroupIndex = 100
      end
      object CashFlowForecast1: TMenuItem
        Action = actCashFlowForecast
        GroupIndex = 100
      end
      object CashFlowStatement1: TMenuItem
        Action = actCashFlowStatement
        GroupIndex = 100
      end
      object MemorisedTransactionList1: TMenuItem
        Action = actAccountsMemorisedTransactionList
        GroupIndex = 100
      end
      object GeneralLedger1: TMenuItem
        Action = actGeneralLedger
        GroupIndex = 100
      end
      object SummarySheet1: TMenuItem
        Action = actReportsAccountsSummary
        GroupIndex = 100
      end
      object SummarySheets1: TMenuItem
        Action = actSummarySheets
        GroupIndex = 100
      end
      object SummarySheetsCategory1: TMenuItem
        Action = actummarySheets
        GroupIndex = 100
      end
      object InventoryAssetVsBalancesheet1: TMenuItem
        Action = actInventoryAssetVsStockStauts
        GroupIndex = 100
      end
      object UnpaidBills1: TMenuItem
        Action = actUnpaidBillGUI
        GroupIndex = 100
      end
      object N214: TMenuItem
        Caption = '-'
        GroupIndex = 100
      end
      object RefreshBatchTransaction2: TMenuItem
        Action = actAccountsRefreshBatchTransaction
        GroupIndex = 100
      end
    end
    object Appointments3: TMenuItem
      Caption = '&Appointments'
      GroupIndex = 20
      Hint = 'Edit commands'
      object MainCalendar2: TMenuItem
        Action = actApptMainCalendar
        GroupIndex = 10
      end
      object N133: TMenuItem
        Caption = '-'
        GroupIndex = 10
      end
      object Source1: TMenuItem
        Caption = 'Source'
        GroupIndex = 10
        object NewSource2: TMenuItem
          Action = actApptsNewSource
          GroupIndex = 10
        end
        object SourceList2: TMenuItem
          Action = actApptsSourceList
          GroupIndex = 10
        end
      end
      object Support1: TMenuItem
        Caption = 'Support'
        GroupIndex = 10
        object CustomersOnSupportList2: TMenuItem
          Action = actApptsCustomersOnSupportList
          GroupIndex = 10
        end
        object PhoneSupportLogList2: TMenuItem
          Action = actApptsPhoneSupportLogList
          GroupIndex = 10
        end
        object PhoneSupport2: TMenuItem
          Action = actApptsPhoneSupport
          GroupIndex = 10
        end
        object SupportTypeList1: TMenuItem
          Action = actPhoneSupportTypeList
          GroupIndex = 10
        end
        object SupportVersionList1: TMenuItem
          Action = actPhoneSupportVersionList
          GroupIndex = 10
        end
      end
      object N22: TMenuItem
        Caption = '-'
        GroupIndex = 10
      end
      object NewAppointment2: TMenuItem
        Action = actApptsNewAppointment
        GroupIndex = 10
      end
      object AppointmentsList2: TMenuItem
        Action = actApptsAppointmentsList
        GroupIndex = 10
      end
      object ProjectManagersAppointments1: TMenuItem
        Action = actProjectInstallations
        GroupIndex = 10
      end
      object N42: TMenuItem
        Caption = '-'
        GroupIndex = 10
      end
      object PrintAppointments2: TMenuItem
        Action = actApptsPrintAppointments
        GroupIndex = 10
      end
      object N41: TMenuItem
        Caption = '-'
        GroupIndex = 10
      end
      object AppointmentsReport2: TMenuItem
        Action = actApptsAppointmentsReport
        GroupIndex = 10
      end
      object CancellationReasonList1: TMenuItem
        Action = actApptsCancellationReasons
        GroupIndex = 10
      end
      object FeedbackReport2: TMenuItem
        Action = actApptsFeedbackReport
        GroupIndex = 10
      end
      object AppointmentStatusList1: TMenuItem
        Action = actAppointmentStatusList
        GroupIndex = 10
      end
    end
    object Banking1: TMenuItem
      Caption = 'Banking'
      GroupIndex = 30
      object Cheques1: TMenuItem
        Caption = 'Cheques'
        GroupIndex = 100
        object Cheque2: TMenuItem
          Action = actPaymentsCheque
          GroupIndex = 100
        end
        object ChequeList2: TMenuItem
          Action = actPaymentsChequeList
          GroupIndex = 100
        end
        object N30: TMenuItem
          Caption = '-'
          GroupIndex = 100
        end
        object ChequeDetailsList2: TMenuItem
          Action = actPaymentsChequeDetailsList
          GroupIndex = 100
        end
        object PrintCheques1: TMenuItem
          Action = actPaymentsChequePrn
          GroupIndex = 100
        end
      end
      object Deposits1: TMenuItem
        Caption = 'Deposits'
        GroupIndex = 100
        object DepositEntry2: TMenuItem
          Action = actPaymentsDepositEntry
          GroupIndex = 100
        end
        object oBeDeposited2: TMenuItem
          Action = actPaymentsToBeDeposited
          GroupIndex = 100
        end
        object N177: TMenuItem
          Caption = '-'
          GroupIndex = 100
        end
        object DepositedList2: TMenuItem
          Action = actPaymentsDepositedList
          GroupIndex = 100
        end
      end
      object ElectronicFundsTransfer2: TMenuItem
        Action = actAccountsElectronicFundsTransfer
        GroupIndex = 100
      end
      object Reconciliation1: TMenuItem
        Caption = 'Reconciliation'
        GroupIndex = 100
        object Reconcile2: TMenuItem
          Action = actPaymentsReconcile
          GroupIndex = 100
        end
        object ReconciliationList2: TMenuItem
          Action = actPaymentsReconciliationList
          GroupIndex = 100
        end
        object BankTransactionImport1: TMenuItem
          Action = actBankTransactionImport
          GroupIndex = 100
        end
        object BankTransactionList1: TMenuItem
          Action = actBankTransactionList
          GroupIndex = 100
        end
      end
      object N174: TMenuItem
        Caption = '-'
        GroupIndex = 100
      end
      object AccountsPayableReport2: TMenuItem
        Action = actPaymentsAccountsPayableReport
        GroupIndex = 100
      end
      object AccountsReceivableReport2: TMenuItem
        Action = actPaymentsAccountsReceivableReport
        GroupIndex = 100
      end
      object BankAccountReport2: TMenuItem
        Action = actPaymentsBankAccountReport
        GroupIndex = 100
      end
      object TransactionJournal2: TMenuItem
        Action = actPaymentsTransactionJournal
        GroupIndex = 100
      end
      object BankCodeList1: TMenuItem
        Action = actEmployeePayrollBankCodes
        GroupIndex = 100
      end
      object HowTO3: TMenuItem
        Caption = 'How To'
        GroupIndex = 100
        object ChequeForms1: TMenuItem
        end
      end
    end
    object Employee3: TMenuItem
      Caption = 'E&mployee'
      GroupIndex = 40
      object Employee1: TMenuItem
        Caption = 'Employee'
        GroupIndex = 60
        object NewEmployee2: TMenuItem
          Action = actEmployeeEmployee
          GroupIndex = 60
        end
        object EmployeeList2: TMenuItem
          Action = actEmployeeEmployeeList
          GroupIndex = 60
        end
        object N43: TMenuItem
          Caption = '-'
          GroupIndex = 100
        end
        object ActionAuthorisations1: TMenuItem
          Action = actActionAuthorisationsList
          GroupIndex = 100
        end
        object CombinedAnalysis1: TMenuItem
          Action = actCombinedAnalysisList
          GroupIndex = 100
        end
        object EmployeeAnalysis2: TMenuItem
          Action = actEmployeeEmployeeAnalysis
          GroupIndex = 100
        end
        object EmployeeFixedAssests1: TMenuItem
          Action = actEmployeesFixedAssetsList
          GroupIndex = 100
        end
        object EmployeesummarybyPeriod1: TMenuItem
          Action = actEmployeeReportByPeriod
          GroupIndex = 100
        end
        object InvoiceandProductcommissionReport1: TMenuItem
          Action = actSalesCommissionList
          GroupIndex = 100
        end
        object PAYGPaymentSummary1: TMenuItem
          Action = actEmployeePayrollEmployeeServices
          GroupIndex = 100
        end
        object RepServices1: TMenuItem
          Action = actEmployeeRepServices
          GroupIndex = 100
        end
      end
      object Reps1: TMenuItem
        Caption = 'Reps'
        GroupIndex = 60
        object NewRep2: TMenuItem
          Action = actEmployeeRep
          GroupIndex = 60
        end
        object RepList2: TMenuItem
          Action = actEmployeeRepList
          GroupIndex = 60
        end
        object RepServices2: TMenuItem
          Action = actEmployeeRepServices
          GroupIndex = 60
        end
        object RepAbility1: TMenuItem
          Action = actRepAbility
          GroupIndex = 60
        end
        object RepAbilityList1: TMenuItem
          Action = actRepAbilityList
          GroupIndex = 60
        end
      end
      object Roster1: TMenuItem
        Caption = 'Roster'
        GroupIndex = 60
        object Roster2: TMenuItem
          Action = actEmployeeRoster
          GroupIndex = 60
        end
        object RosterList2: TMenuItem
          Action = actEmployeeRosterList
          GroupIndex = 60
        end
        object N186: TMenuItem
          Caption = '-'
          GroupIndex = 60
        end
        object RosterReportDetails1: TMenuItem
          Action = actRosterReportDetails
          GroupIndex = 60
        end
        object RosterReportSummary1: TMenuItem
          Action = actrosterReport
          GroupIndex = 60
        end
        object N31: TMenuItem
          Caption = '-'
          GroupIndex = 60
        end
        object ClockOn2: TMenuItem
          Action = actEmployeeClockOn
          GroupIndex = 60
        end
      end
      object Payroll2: TMenuItem
        Caption = 'Payroll'
        GroupIndex = 60
        object PayStaff2: TMenuItem
          Action = actEmployeePayrollPayStaff
          GroupIndex = 60
        end
        object PayHistory2: TMenuItem
          Action = actEmployeePayrollPayHistory
          GroupIndex = 60
        end
        object N199: TMenuItem
          Caption = '-'
          GroupIndex = 60
        end
        object Allowance1: TMenuItem
          Caption = 'Allowance'
          GroupIndex = 60
          object NewAllowance2: TMenuItem
            Action = actEmployeePayrollNewAllowance
            GroupIndex = 60
          end
          object Allowances2: TMenuItem
            Action = actEmployeePayrollAllowances
            GroupIndex = 60
          end
        end
        object N198: TMenuItem
          Caption = '-'
          GroupIndex = 60
        end
        object Award1: TMenuItem
          Caption = 'Award'
          GroupIndex = 60
          object NewAward2: TMenuItem
            Action = actEmployeePayrollNewAward
            GroupIndex = 60
          end
          object Awards2: TMenuItem
            Action = actEmployeePayrollAwards
            GroupIndex = 60
          end
        end
        object N197: TMenuItem
          Caption = '-'
          GroupIndex = 60
        end
        object BankCodes1: TMenuItem
          Caption = 'Bank Codes'
          GroupIndex = 60
          object NewBankCode2: TMenuItem
            Action = actEmployeePayrollNewBankCode
            GroupIndex = 60
          end
          object BankCodes2: TMenuItem
            Action = actEmployeePayrollBankCodes
            GroupIndex = 60
          end
        end
        object N45: TMenuItem
          Caption = '-'
          GroupIndex = 60
        end
        object Deduction1: TMenuItem
          Caption = 'Deduction'
          GroupIndex = 60
          object NewDeduction2: TMenuItem
            Action = actEmployeePayrollNewDeduction
            GroupIndex = 60
          end
          object DeductionsList2: TMenuItem
            Action = actEmployeePayrollDeductions
            GroupIndex = 60
          end
        end
        object N196: TMenuItem
          Caption = '-'
          GroupIndex = 60
        end
        object Leave1: TMenuItem
          Caption = 'Leave'
          GroupIndex = 60
          object LeaveAccruedList2: TMenuItem
            Action = actEmployeePayrollLeaveAccruedList
            GroupIndex = 60
          end
          object LeaveTakenList2: TMenuItem
            Action = actEmployeePayrollLeaveTakenList
            GroupIndex = 60
          end
        end
        object N195: TMenuItem
          Caption = '-'
          GroupIndex = 60
        end
        object PayRate1: TMenuItem
          Caption = 'Pay Rates'
          GroupIndex = 60
          object NewPayRate2: TMenuItem
            Action = actEmployeePayrollNewPayRate
            GroupIndex = 60
          end
          object PayRates2: TMenuItem
            Action = actEmployeePayrollPayRates
            GroupIndex = 60
          end
        end
        object N194: TMenuItem
          Caption = '-'
          GroupIndex = 60
        end
        object axScales1: TMenuItem
          Caption = 'Tax Scales'
          GroupIndex = 60
          object NewTaxScale2: TMenuItem
            Action = actEmployeePayrollNewTaxScale
            GroupIndex = 60
          end
          object axScalesList2: TMenuItem
            Action = actEmployeePayrollTaxScales
            GroupIndex = 60
          end
          object N44: TMenuItem
            Caption = '-'
            GroupIndex = 60
          end
          object ImportTaxScales2: TMenuItem
            Action = actEmployeePayrollImportTaxScales
            GroupIndex = 60
          end
        end
        object N193: TMenuItem
          Caption = '-'
          GroupIndex = 60
        end
        object erminations1: TMenuItem
          Caption = 'Terminations'
          GroupIndex = 60
          Visible = False
          object TerminateEmployeemnu: TMenuItem
            Action = actEmployeeTerminateEmployee
            GroupIndex = 60
          end
          object TerminationsList: TMenuItem
            Action = actEmployeeTerminationList
            GroupIndex = 60
          end
        end
        object N192: TMenuItem
          Caption = '-'
          GroupIndex = 60
          Visible = False
        end
        object imeSheetEntry2: TMenuItem
          Action = actEmployeeTimesheetList
          GroupIndex = 60
        end
        object N190: TMenuItem
          Caption = '-'
          GroupIndex = 60
        end
        object ATOSubmissions: TMenuItem
          Action = actEmployeePayrollATO
          GroupIndex = 60
        end
        object PayRunList: TMenuItem
          Action = actEmpPayRunList
          GroupIndex = 60
        end
        object PAYGPaymentSummary2: TMenuItem
          Action = actEmployeePayrollPAYGSummary
          GroupIndex = 60
        end
        object EmployeeServices2: TMenuItem
          Action = actEmployeePayrollEmployeeServices
          GroupIndex = 60
        end
        object PayrollJobsList2: TMenuItem
          Action = actEmployeePayrollPayrollJobsList
          GroupIndex = 60
        end
        object imesheetList1: TMenuItem
          Action = actEmployeeTimesheetList
          GroupIndex = 60
        end
      end
      object imesheet1: TMenuItem
        Caption = 'Timesheet'
        GroupIndex = 60
        object q1: TMenuItem
          Action = actTimesheetEntry
        end
        object imesheetList2: TMenuItem
          Action = actEmployeeTimesheetList
        end
      end
      object oDo1: TMenuItem
        Caption = 'To Do'
        GroupIndex = 60
        object NewToDo2: TMenuItem
          Action = actEmployeeToDo
          GroupIndex = 60
        end
        object oDoList2: TMenuItem
          Action = actEmployeeToDoList
          GroupIndex = 60
        end
      end
      object Skills1: TMenuItem
        Caption = 'Skills'
        GroupIndex = 60
        object SkillList1: TMenuItem
          Action = actSkillList
        end
        object SkillProviderList1: TMenuItem
          Action = actSupplierSkillList
        end
        object EmployeeSkillList1: TMenuItem
          Action = actEmployeeSkillList
        end
      end
      object ExpenseClaim2: TMenuItem
        Caption = 'Expense Claim'
        GroupIndex = 60
        object ExpenseClaimList2: TMenuItem
          Action = actPurchasesExpenseClaimList
        end
        object ExpenseClaimRequest2: TMenuItem
          Action = actExpenseClaimRequest
        end
      end
      object N185: TMenuItem
        Caption = '-'
        GroupIndex = 60
      end
      object CustomReports3: TMenuItem
        Action = actReportsCustomReports
        GroupIndex = 60
      end
      object N183: TMenuItem
        Caption = '-'
        GroupIndex = 60
      end
      object AccessLevels2: TMenuItem
        Action = actEmployeeAccessLevels
        GroupIndex = 60
      end
      object ColourPreferences1: TMenuItem
        Action = actcolorPrefs
        GroupIndex = 60
      end
      object PersonalPreferences2: TMenuItem
        Action = actEmployeePersonalPreferences
        GroupIndex = 60
      end
      object N187: TMenuItem
        Caption = '-'
        GroupIndex = 60
      end
      object ResetPersonalTabs1: TMenuItem
        Action = actEmployeeResetPersonalTabs
        GroupIndex = 60
      end
      object ransferEmployeeData1: TMenuItem
        Action = actEmployeeTransferDetails
        GroupIndex = 60
      end
      object GlobalList1: TMenuItem
        Action = actEmployeeGlobalList
        GroupIndex = 60
      end
      object Messages1: TMenuItem
        Action = actMessages
        GroupIndex = 60
      end
      object Reminders1: TMenuItem
        Action = actReminders
        GroupIndex = 60
      end
      object actVideos1: TMenuItem
        Action = actVidoes
        GroupIndex = 60
      end
      object N36: TMenuItem
        Caption = '-'
        GroupIndex = 60
      end
      object ProjectManagersAppointments2: TMenuItem
        Action = actProjectInstallations
        GroupIndex = 60
      end
      object HRForm2: TMenuItem
        Caption = 'HR Form'
        GroupIndex = 190
        object HRForm3: TMenuItem
          Action = actHRForm
        end
        object HRList1: TMenuItem
          Action = actHRForms
        end
      end
    end
    object General1: TMenuItem
      Caption = 'General'
      GroupIndex = 60
      object Department1: TMenuItem
        Caption = 'Departments'
        GroupIndex = 190
        object Department2: TMenuItem
          Action = actAccountsDepartment
          GroupIndex = 100
        end
        object DepartmentsList2: TMenuItem
          Action = actAccountsDepartmentsList
          GroupIndex = 100
        end
        object AreaCodeList1: TMenuItem
          Action = actAreacodes
          GroupIndex = 190
        end
      end
      object ForeignExchangeRates1: TMenuItem
        Caption = 'Foreign Exchange Rates'
        GroupIndex = 190
        object ForeignExchangeRate2: TMenuItem
          Action = actAccountsForeignExchangeRate
          GroupIndex = 100
        end
        object ForeignExchangeRatesList2: TMenuItem
          Action = actAccountsForeignExchangeRatesList
          GroupIndex = 100
        end
        object ForeignExchangeHistoryList2: TMenuItem
          Action = actAccountsForeignExchangeHistoryList
          GroupIndex = 100
        end
      end
      object Shipping1: TMenuItem
        Caption = 'Shipping'
        GroupIndex = 190
        object Shipping2: TMenuItem
          Action = actAccountsShipping
          GroupIndex = 100
        end
        object ShippingList2: TMenuItem
          Action = actAccountsShippingList
          GroupIndex = 100
        end
      end
      object axCodes1: TMenuItem
        Caption = 'Tax Codes'
        GroupIndex = 190
        object axCode2: TMenuItem
          Action = actAccountsTaxCode
          GroupIndex = 100
        end
        object axCodeList2: TMenuItem
          Action = actAccountsTaxCodeList
          GroupIndex = 100
        end
        object N28: TMenuItem
          Caption = '-'
          GroupIndex = 100
        end
        object SubTaxCode1: TMenuItem
          Action = actSubTaxcode
          GroupIndex = 100
        end
        object SubTaxCodeList2: TMenuItem
          Action = actSubTaxcodes
          GroupIndex = 100
        end
      end
      object erms1: TMenuItem
        Caption = 'Terms'
        GroupIndex = 190
        object erms2: TMenuItem
          Action = actAccountsTerms
          GroupIndex = 100
        end
        object ermsList2: TMenuItem
          Action = actAccountsTermsList
          GroupIndex = 100
        end
      end
      object Correspondence1: TMenuItem
        Caption = 'Correspondence'
        GroupIndex = 190
        object EmailReferenceList1: TMenuItem
          Action = actEmailReferenceList
        end
        object LetterReferenceList1: TMenuItem
          Action = actLetterReferenceList
        end
      end
      object N2: TMenuItem
        Caption = '-'
        GroupIndex = 190
      end
      object PublicHolidays2: TMenuItem
        Action = actUtilsPublicHolidays
        GroupIndex = 190
      end
      object N219: TMenuItem
        Caption = '-'
        GroupIndex = 190
      end
      object GlobalList2: TMenuItem
        Action = actEmployeeGlobalList
        GroupIndex = 190
      end
      object Locations2: TMenuItem
        Action = actUtilsLocations
        GroupIndex = 190
      end
      object ClientMainContacts1: TMenuItem
        Action = actClientMainContacts
        GroupIndex = 190
      end
      object MemorisedTransactionList2: TMenuItem
        Action = actAccountsMemorisedTransactionList
        GroupIndex = 190
      end
      object Locations1: TMenuItem
        Action = actRegionList
        GroupIndex = 190
      end
      object Languages1: TMenuItem
        Action = actLanguages
        GroupIndex = 190
      end
      object StateFreightCharges1: TMenuItem
        Action = actStateFreightChargeList
        GroupIndex = 190
      end
      object N9: TMenuItem
        Caption = '-'
        GroupIndex = 190
      end
      object DatabaseUtils1: TMenuItem
        Caption = 'Database Utils'
        GroupIndex = 190
        object Backup1: TMenuItem
          Action = actUtilsDbUtilsBackup
        end
        object Restore1: TMenuItem
          Action = actUtilsDbUtilsRestore
        end
        object Copy1: TMenuItem
          Action = actUtilsDbUtilsCopy
        end
        object REadOnlyCopy1: TMenuItem
          Action = actUtilsDbUtilsCopyRO
        end
        object Remove1: TMenuItem
          Action = actUtilsDbUtilsRemove
        end
        object N23: TMenuItem
          Caption = '-'
        end
        object Optimise1: TMenuItem
          Action = actUtilsDbUtilsOptimise
        end
      end
      object emplates1: TMenuItem
        Action = actReportsTemplates
        GroupIndex = 190
      end
      object N24: TMenuItem
        Caption = '-'
        GroupIndex = 190
      end
      object Customise1: TMenuItem
        Action = actCustomise
        GroupIndex = 190
      end
      object CustomiseToolbar1: TMenuItem
        Action = actWindowCustomiseToolbar
        GroupIndex = 190
      end
      object Reminders2: TMenuItem
        Action = actReminders
        GroupIndex = 190
      end
      object Messages2: TMenuItem
        Action = actMessages
        GroupIndex = 190
      end
      object Videos2: TMenuItem
        Action = actVidoes
        GroupIndex = 190
      end
      object ERPPDFDocs1: TMenuItem
        Action = actERPPDFDocs
        GroupIndex = 190
      end
      object HRForm1: TMenuItem
        Caption = 'HR Form'
        GroupIndex = 190
        object New1: TMenuItem
          Action = actHRForm
        end
        object HRForms1: TMenuItem
          Action = actHRForms
        end
      end
      object mnutypeCodes: TMenuItem
        Caption = 'Type Codes'
        GroupIndex = 190
        ImageIndex = 664
        OnClick = AnyActionExecute
        object ypeCodes2: TMenuItem
          Action = actSimpleTypes
        end
      end
      object N39: TMenuItem
        Caption = '-'
        GroupIndex = 190
      end
      object CustomisableListAll1: TMenuItem
        Caption = 'Custom Field Values'
        GroupIndex = 190
        ImageIndex = 693
        OnClick = AnyActionExecute
        object CustomisableList1: TMenuItem
          Caption = 'Customisable List'
          object CustomisableListAll2: TMenuItem
            Action = actCustomFieldValuesAlls
            Caption = 'All'
          end
          object CustomisableListContacts1: TMenuItem
            Action = actCustomFieldValuesContacts
            Caption = 'Contacts'
          end
          object CustomisableListCustomers1: TMenuItem
            Action = actCustomFieldValuesCustomers
            Caption = 'Customers'
          end
          object CustomisableListEquipment1: TMenuItem
            Action = actCustomFieldValuesEquipments
            Caption = 'Equipment'
          end
          object CustomisableListLeads1: TMenuItem
            Action = actCustomFieldValuesLeadss
            Caption = 'Leads'
          end
          object CustomisableListProducts2: TMenuItem
            Action = actCustomFieldValuesProducts
            Caption = 'Products'
          end
          object CustomisableListRepairs1: TMenuItem
            Caption = 'Repairs'
            ImageIndex = 699
            OnClick = AnyActionExecute
          end
          object CustomisableListSupplier1: TMenuItem
            Action = actCustomFieldValuesSuppliers
            Caption = 'Supplier'
          end
        end
        object CustomisableFields1: TMenuItem
          Caption = 'Customisable Fields'
          object CustomisableFieldsContacts1: TMenuItem
            Action = actCustomFieldValuesListContacts
            Caption = 'Contacts'
            GroupIndex = 40
          end
          object CustomisableFieldsCustomers1: TMenuItem
            Action = actCustomFieldValuesListCustomers
            Caption = 'Customers'
            GroupIndex = 40
          end
          object CustomisableFieldsEquipment1: TMenuItem
            Action = actCustomFieldValuesListEquipments
            Caption = 'Equipment'
            GroupIndex = 40
          end
          object CustomisableFieldsLeads1: TMenuItem
            Action = actCustomFieldValuesListLeadss
            Caption = 'Leads'
            GroupIndex = 40
          end
          object CustomisableFieldsProducts1: TMenuItem
            Action = actCustomFieldValuesListProducts
            Caption = 'Products'
            GroupIndex = 40
          end
          object mnuCustomFieldValuesListRepairs: TMenuItem
            Caption = 'Repairs'
            GroupIndex = 40
          end
          object CustomisableFieldsSupplier1: TMenuItem
            Action = actCustomFieldValuesListSuppliers
            Caption = 'Supplier'
            GroupIndex = 40
          end
        end
      end
    end
    object Inventory2: TMenuItem
      Caption = '&Inventory'
      GroupIndex = 70
      object BarcodePicking1: TMenuItem
        Caption = 'Barcode Picking'
        GroupIndex = 40
        object BarcodePickingAssembly2: TMenuItem
          Action = actInventBarcodePickingAssembly
          GroupIndex = 40
        end
        object BarcodePickingAssemblyList2: TMenuItem
          Action = actInventBarcodePickingAssemblyList
          GroupIndex = 40
        end
      end
      object Bins1: TMenuItem
        Caption = 'Bins'
        GroupIndex = 40
        object BinLocation1: TMenuItem
          Action = actbinLocation
          GroupIndex = 40
        end
        object BinLocationList1: TMenuItem
          Action = actBinLocationList
          GroupIndex = 40
        end
        object N5: TMenuItem
          Caption = '-'
          GroupIndex = 40
        end
        object BinUsageReport1: TMenuItem
          Action = actBinUsageReport
          GroupIndex = 40
        end
        object N19: TMenuItem
          Caption = '-'
          GroupIndex = 40
        end
        object StockMovementStatus2: TMenuItem
          Action = actStockStatusRoling
          GroupIndex = 40
        end
        object StockQuantitiesLocationReport2: TMenuItem
          Action = actStockQtysLocationsReport
          GroupIndex = 40
        end
        object UnAllocatedBinsReport1: TMenuItem
          Action = actUnAllocatedBinsReport
          GroupIndex = 40
        end
        object UnbalancedBinQuantities1: TMenuItem
          Action = actUnbalancedBinQty
          GroupIndex = 40
        end
      end
      object Products2: TMenuItem
        Caption = 'Products'
        GroupIndex = 40
        object NewProduct2: TMenuItem
          Action = actInventProductsProduct
          GroupIndex = 40
        end
        object ProductOptions: TMenuItem
          Action = actProductOptions
          GroupIndex = 40
        end
        object ProductAttributes1: TMenuItem
          Action = actProductAttributes
          GroupIndex = 40
        end
        object ProductAttributesinSalesTemplate1: TMenuItem
          Action = actProdAttribTemplateFields
          GroupIndex = 40
        end
        object ProductAttributesinSalesTemplatedetails1: TMenuItem
          Action = actProdAttribTemplateFieldsdetails
          GroupIndex = 40
        end
        object ProductListCustomFields1: TMenuItem
          Action = actProductcustomFieldList
          GroupIndex = 40
        end
        object ProductsExpressList2: TMenuItem
          Action = actInventProductsProductsExpressList
          GroupIndex = 40
        end
        object ProductsList2: TMenuItem
          Action = actInventProductsProductsList
          GroupIndex = 40
        end
        object ProductPictureList1: TMenuItem
          Action = actInventProductPictureProductsList
          GroupIndex = 40
        end
        object ProductExtraBuyPrices1: TMenuItem
          Action = actProductExtrabuyPrices
          GroupIndex = 40
        end
        object AlternateProductList1: TMenuItem
          Action = actAlternateProductList
          GroupIndex = 40
        end
        object mnuSerialNumbers: TMenuItem
          Action = actSerialNumbersOld
          GroupIndex = 40
        end
        object SerialNumberBatch1: TMenuItem
          Action = actSerialNumberList
          GroupIndex = 40
        end
        object mnuSerialjobNumber: TMenuItem
          Action = actSerialJobnumber
          GroupIndex = 40
        end
        object ProductGroupList1: TMenuItem
          Action = actProductGroupList
          GroupIndex = 40
        end
        object CustomisableListProducts1: TMenuItem
          Action = actCustomFieldValuesProducts
          GroupIndex = 40
        end
        object N172: TMenuItem
          Caption = '-'
          GroupIndex = 40
        end
        object ProductCommission2: TMenuItem
          Action = actInventProductsProductCommission
          GroupIndex = 40
        end
        object ProductCommissionList2: TMenuItem
          Action = actInventProductsProductCommissionList
          GroupIndex = 40
        end
        object N171: TMenuItem
          Caption = '-'
          GroupIndex = 40
        end
        object ProductRewardPoints2: TMenuItem
          Action = actInventProductsProductRewardPoints
          GroupIndex = 40
        end
        object ProductRewardPointsList2: TMenuItem
          Action = actInventProductsProductRewardPointsList
          GroupIndex = 40
        end
        object N170: TMenuItem
          Caption = '-'
          GroupIndex = 40
        end
        object BatchProductCreator2: TMenuItem
          Action = actInventProductsBatchProductCreator
          GroupIndex = 40
        end
        object BatchProductCodeAbbreviator2: TMenuItem
          Action = actInventProductsBatchProductCodeAbbreviator
          GroupIndex = 40
        end
        object N169: TMenuItem
          Caption = '-'
          GroupIndex = 40
        end
        object ProductFormulaEntry1: TMenuItem
          Action = actProductFormulaEntry
          GroupIndex = 40
        end
        object ProductFormulaCreator1: TMenuItem
          Action = actProductFormulaCreator
          GroupIndex = 40
        end
        object ProductFormulaList1: TMenuItem
          Action = actProductFormulaList
          GroupIndex = 40
        end
        object ProductFormulaType1: TMenuItem
          Action = actProductFormulaType
          GroupIndex = 40
        end
        object ProductFormulaTypeList1: TMenuItem
          Action = actProductformulaTypeList
          GroupIndex = 40
        end
        object N4: TMenuItem
          Caption = '-'
          GroupIndex = 40
        end
        object Equipment1: TMenuItem
          Action = actEquipment
          GroupIndex = 40
        end
        object EquipmentList1: TMenuItem
          Action = actEquipmentList
          GroupIndex = 40
        end
        object ProductsExpressList3: TMenuItem
          Action = actProductsWithBlanknameList
          GroupIndex = 40
        end
      end
      object Stock2: TMenuItem
        Caption = 'Stock'
        GroupIndex = 40
        object StockTransfer2: TMenuItem
          Action = actInventStockStockTransfer
          GroupIndex = 40
        end
        object StockTransferList2: TMenuItem
          Action = actInventStockStockTransferList
          GroupIndex = 40
        end
        object N167: TMenuItem
          Caption = '-'
          GroupIndex = 40
        end
        object StockAdjustment2: TMenuItem
          Action = actInventStockStockAdjustment
          GroupIndex = 40
        end
        object StockAdjustmentList2: TMenuItem
          Action = actInventStockStockAdjustmentList
          GroupIndex = 40
        end
        object About1: TMenuItem
          Action = actAutoAdjustbin
          GroupIndex = 40
        end
        object N166: TMenuItem
          Caption = '-'
          GroupIndex = 40
        end
        object StockTake2: TMenuItem
          Action = actInventStockStockTake
          GroupIndex = 40
        end
      end
      object UnitsOfMeasure1: TMenuItem
        Caption = 'Units Of Measure'
        GroupIndex = 40
        object UnitsOfMeasure2: TMenuItem
          Action = actInventUnitsOfMeasure
          GroupIndex = 40
        end
        object UnitsOfMeasureList2: TMenuItem
          Action = actInventUnitsOfMeasureList
          GroupIndex = 40
        end
        object N10: TMenuItem
          Caption = '-'
          GroupIndex = 40
        end
        object AdjustUOM1: TMenuItem
          Action = actAdjustUOM
          GroupIndex = 40
        end
        object UOMList1: TMenuItem
          Action = actUOMList
          GroupIndex = 40
        end
      end
      object N3: TMenuItem
        Caption = '-'
        GroupIndex = 40
      end
      object PriceUpdate2: TMenuItem
        Action = actInventPriceUpdate
        GroupIndex = 40
      end
      object AutoReOrder2: TMenuItem
        Action = actInventAutoReOrder
        GroupIndex = 40
      end
      object N164: TMenuItem
        Caption = '-'
        GroupIndex = 40
      end
      object PrintPickSlips2: TMenuItem
        Action = actInventPrintPickSlips
        GroupIndex = 40
      end
      object N163: TMenuItem
        Caption = '-'
        GroupIndex = 40
      end
      object CustomerTypePriceList2: TMenuItem
        Action = actInventCustomerTypePriceList
        GroupIndex = 40
      end
      object ProductBuyPriceList1: TMenuItem
        Action = actAlternateProducts
        GroupIndex = 40
      end
      object ProductSales2: TMenuItem
        Action = actInventProductSales
        GroupIndex = 40
      end
      object ProductSalesSummary1: TMenuItem
        Action = actReportsProductSalesSummary
        GroupIndex = 40
      end
      object ProductSalesSummaryByColumn1: TMenuItem
        Action = actProductSalesSummaryByColumn
        GroupIndex = 40
      end
      object StockMovementStatus1: TMenuItem
        Action = actStockStatusRoling
        GroupIndex = 40
      end
      object StockQuantitiesLocationReport1: TMenuItem
        Action = actStockQtysLocationsReport
        GroupIndex = 40
      end
      object StockStatusReport1: TMenuItem
        Action = actReportsStockStatus
        GroupIndex = 40
      end
      object SupplierProductReport1: TMenuItem
        Action = actSupplierProductReport
        GroupIndex = 40
      end
      object UnAllocatedQty1: TMenuItem
        Action = actUnAllocatedQty
        GroupIndex = 40
      end
      object PickPackSalesList1: TMenuItem
        Action = actInventPickedSalesList
        GroupIndex = 40
      end
      object StockAnalysisReport1: TMenuItem
        Action = actStockanalysisReport
        GroupIndex = 40
      end
      object ProjectedManufacturingQty1: TMenuItem
        Action = actProjectedManufacturingQty
        GroupIndex = 40
      end
      object N159: TMenuItem
        Caption = '-'
        GroupIndex = 40
      end
      object RefreshSnapshotProducts6: TMenuItem
        Caption = 'Refresh Snapshot (Products)'
        GroupIndex = 40
        ImageIndex = 574
      end
      object ProductSerialNumberQtyList1: TMenuItem
        Action = actProductSerialNumberQtyList
        GroupIndex = 40
      end
      object mnuSerialNoTabletAllocation: TMenuItem
        Action = actSerialNoTabletAllocation
        GroupIndex = 40
      end
    end
    object Payments1: TMenuItem
      Caption = 'Pa&yments'
      GroupIndex = 80
      object CustomerPayment2: TMenuItem
        Caption = 'Customer Payments'
        GroupIndex = 100
        object CustomerPayment1: TMenuItem
          Action = actPaymentsCustomerPayment
          GroupIndex = 50
        end
        object CustomerPaymentList1: TMenuItem
          Action = actPaymentsCustomerPaymentList
          GroupIndex = 50
        end
        object N14: TMenuItem
          Caption = '-'
          GroupIndex = 100
        end
        object ReceivedBulkPayments1: TMenuItem
          Action = actPaymentsReceivedBulkPayments
          GroupIndex = 100
        end
      end
      object CustomerPrepayment2: TMenuItem
        Caption = 'Customer Prepayments'
        GroupIndex = 100
        object CustomerPrepayment1: TMenuItem
          Action = actPaymentsCustomerPrepayment
          GroupIndex = 50
        end
        object CustomerPrepaymentList1: TMenuItem
          Action = actPaymentsCustomerPrepaymentList
          GroupIndex = 50
        end
      end
      object SupplierPayments1: TMenuItem
        Caption = 'Supplier Payments'
        GroupIndex = 100
        object SupplierPayment1: TMenuItem
          Action = actPaymentsSupplierPayment
          GroupIndex = 50
        end
        object SupplierPaymentList1: TMenuItem
          Action = actPaymentsSupplierPaymentList
          GroupIndex = 50
        end
        object N17: TMenuItem
          Caption = '-'
          GroupIndex = 100
        end
        object BulkPaySuppliers1: TMenuItem
          Action = actPaymentsBulkPaySuppliers
          GroupIndex = 100
        end
      end
      object SupplierPrepayments1: TMenuItem
        Caption = 'Supplier Prepayments'
        GroupIndex = 100
        object SupplierPrepayment1: TMenuItem
          Action = actPaymentsSupplierPrepayment
          GroupIndex = 50
        end
        object SuppPrepaymentList1: TMenuItem
          Action = actPaymentsSuppPrepaymentList
          GroupIndex = 50
        end
      end
      object Statements1: TMenuItem
        Caption = 'Statements'
        GroupIndex = 100
        object Statements2: TMenuItem
          Action = actPaymentsStatements
          GroupIndex = 100
        end
        object PrintStatements2: TMenuItem
          Action = actPaymentsPrintStatements
          GroupIndex = 100
        end
        object PrintRecipientCreatedStatement2: TMenuItem
          Action = actPaymentsPrintRecipientCreatedStatement
          GroupIndex = 100
        end
      end
      object PaymentMethodList1: TMenuItem
        Action = actPaymentMethodList
        GroupIndex = 100
      end
      object N6: TMenuItem
        Caption = '-'
        GroupIndex = 100
      end
      object AccountsPayableReport1: TMenuItem
        Action = actPaymentsAccountsPayableReport
        GroupIndex = 100
      end
      object AccountsPayableNotesReport1: TMenuItem
        Action = actAccountsPayableNotes
        GroupIndex = 100
      end
      object AccountsReceivableReport1: TMenuItem
        Action = actPaymentsAccountsReceivableReport
        GroupIndex = 100
      end
      object AccountsReceivableNotes1: TMenuItem
        Action = actPaymentsAccountsReceivableNotes
        GroupIndex = 100
      end
      object ApprovalReminderList2: TMenuItem
        Action = actPaymentsApprovalReminderList
        GroupIndex = 100
      end
      object ExpenseClaims1: TMenuItem
        Action = actExpenseClaimList
        GroupIndex = 100
      end
      object N33: TMenuItem
        Caption = '-'
        GroupIndex = 100
      end
      object ApprovalList1: TMenuItem
        Action = actApprovalList
        GroupIndex = 100
      end
      object ApprovalReminderList1: TMenuItem
        Action = actPaymentsApprovalReminderList
        GroupIndex = 100
      end
      object OverdueInvoices1: TMenuItem
        Action = actOverdueInvoices
        GroupIndex = 100
      end
    end
    object Purchases2: TMenuItem
      Caption = '&Purchases'
      GroupIndex = 90
      object Bills2: TMenuItem
        Caption = 'Bills / Credits'
        GroupIndex = 30
        object Bill2: TMenuItem
          Action = actPurchasesBillsBill
        end
        object BillRefund2: TMenuItem
          Action = actPurchasesBillsBillRefund
        end
        object N13: TMenuItem
          Caption = '-'
        end
        object BillList2: TMenuItem
          Action = actPurchasesBillsBillList
        end
        object BillDetailsList2: TMenuItem
          Action = actPurchasesBillsBillDetailsList
        end
      end
      object PurchaseOrders2: TMenuItem
        Caption = 'Purchase Orders'
        GroupIndex = 30
        object PurchaseOrder2: TMenuItem
          Action = actPurchasesPurchaseOrdersPurchaseOrder
        end
        object PurchaseOrderList2: TMenuItem
          Action = actPurchasesPurchaseOrdersPurchaseOrderList
        end
        object PurchaseOrderListDetail1: TMenuItem
          Action = actPurchasesPurchaseOrdersPurchaseOrderListDetail
        end
        object N157: TMenuItem
          Caption = '-'
        end
        object BackOrders4: TMenuItem
          Action = actPurchasesPurchaseOrdersBackOrders
        end
        object POsInvoicedBeforeOrdered1: TMenuItem
          Action = actPOsInvoicedBeforeOrder
        end
        object NonERPPurchases1: TMenuItem
          Action = actNonERPPOList
          GroupIndex = 20
        end
      end
      object ReturnAuthority3: TMenuItem
        Caption = 'Return Authority'
        GroupIndex = 30
        object ReturnAuthority4: TMenuItem
          Action = actPurchasesReturnAuthorityReturnAuthority
        end
        object ReturnAuthorityList2: TMenuItem
          Action = actPurchasesReturnAuthorityReturnAuthorityList
        end
      end
      object SmartOrders2: TMenuItem
        Caption = 'Smart Orders'
        GroupIndex = 30
        object SmartOrder2: TMenuItem
          Action = actPurchasesSmartOrdersSmartOrder
        end
        object SmartOrderList2: TMenuItem
          Action = actPurchasesSmartOrdersSmartOrderList
        end
        object SmartOrderDetailList1: TMenuItem
          Action = actSmartorderListDetails
        end
        object SmartOrderRFQs1: TMenuItem
          Action = actSmartOrderRFQs
        end
      end
      object Suppliers2: TMenuItem
        Caption = 'Suppliers'
        GroupIndex = 30
        object Supplier2: TMenuItem
          Action = actPurchasesSuppliersSupplier
          GroupIndex = 30
        end
        object SupplierList2: TMenuItem
          Action = actPurchasesSuppliersSupplierList
          GroupIndex = 30
        end
        object N158: TMenuItem
          Caption = '-'
          GroupIndex = 30
        end
        object SupplierReport2: TMenuItem
          Action = actReportsSupplier
          GroupIndex = 30
        end
      end
      object ExpenseClaim1: TMenuItem
        Caption = 'Expense Claim'
        GroupIndex = 30
        object ExpenseClaimList1: TMenuItem
          Action = actPurchasesExpenseClaimList
          GroupIndex = 30
        end
        object ExpenseClaimRequest1: TMenuItem
          Action = actExpenseClaimRequest
          GroupIndex = 30
        end
      end
      object N29: TMenuItem
        Caption = '-'
        GroupIndex = 30
      end
      object AccountsPayableNotesReport2: TMenuItem
        Action = actAccountsPayableNotes
        GroupIndex = 30
      end
      object ForeignPurchaseReport1: TMenuItem
        Action = actForeignPurchaseList
        GroupIndex = 30
      end
      object ProductSalesProjection2: TMenuItem
        Action = actInventProductSales
        GroupIndex = 30
      end
      object ProductSalesSummary2: TMenuItem
        Action = actReportsProductSalesSummary
        GroupIndex = 30
      end
      object ProfitAndLoss3: TMenuItem
        Action = actAccountsProfitAndLoss
        GroupIndex = 30
      end
      object ProfitandLossSummary2: TMenuItem
        Action = actProfitLossSummary
        GroupIndex = 30
      end
      object SupplierProductReport2: TMenuItem
        Action = actSupplierProductReport
        GroupIndex = 30
      end
      object SupplierStatement1: TMenuItem
        Action = actSupplierStatement
        GroupIndex = 30
      end
      object UnInvoicedCustomerPurchaseItems1: TMenuItem
        Action = actUnInvoicedPurchItemList
        GroupIndex = 30
      end
      object UnInvoicedCustomerPurchaseOrders1: TMenuItem
        Action = actUnInvoicedPurchasesList
        GroupIndex = 30
      end
      object UnpaidBillsReport1: TMenuItem
        Action = actReportsUnPaidBills
        GroupIndex = 30
      end
      object N26: TMenuItem
        Caption = '-'
        GroupIndex = 30
      end
      object RefreshSnapshotProducts5: TMenuItem
        Caption = 'Refresh Snapshot (Products)'
        GroupIndex = 30
        ImageIndex = 575
      end
      object HowTo4: TMenuItem
        Caption = 'How To'
        GroupIndex = 30
        object UsingSmartOrdersandPurchaseOrders1: TMenuItem
        end
      end
      object CustomisableListSupplier2: TMenuItem
        Action = actCustomFieldValuesSuppliers
        GroupIndex = 30
      end
    end
    object mnuReports: TMenuItem
      Caption = '&Reports'
      GroupIndex = 100
      object AccountsReport2: TMenuItem
        Action = actReportsAccounts
        GroupIndex = 120
      end
      object Appointments4: TMenuItem
        Action = actReportsAppointments
        GroupIndex = 120
      end
      object Banking2: TMenuItem
        Action = actReportsBanking
        GroupIndex = 120
      end
      object CRMReports1: TMenuItem
        Action = actReportsCRM
        GroupIndex = 120
      end
      object Employee4: TMenuItem
        Action = actReportsEmployee
        GroupIndex = 120
      end
      object FixedAssets4: TMenuItem
        Action = actReportsFixedAssets
        GroupIndex = 120
      end
      object GeneralReports1: TMenuItem
        Action = actReportsGeneral
        GroupIndex = 120
      end
      object InventoryReport2: TMenuItem
        Action = actReportsInventory
        GroupIndex = 120
      end
      object Jobs1: TMenuItem
        Action = actReportsJobs
        GroupIndex = 120
      end
      object POSReports1: TMenuItem
        Action = actReportsPOS
        GroupIndex = 120
      end
      object PaymentsReport2: TMenuItem
        Action = actReportsPayments
        GroupIndex = 120
      end
      object PayrollReports2: TMenuItem
        Action = actReportsPayroll
        GroupIndex = 120
      end
      object PurchasesReport2: TMenuItem
        Action = actReportsPurchases
        GroupIndex = 120
      end
      object SalesReport4: TMenuItem
        Action = actReportsSales
        GroupIndex = 120
      end
      object UtilitiesReports1: TMenuItem
        Action = actReportsUtilities
        GroupIndex = 120
      end
      object N229: TMenuItem
        Caption = '-'
        GroupIndex = 120
      end
      object CustomReports4: TMenuItem
        Action = actReportsCustomReports
        GroupIndex = 120
      end
      object emplates4: TMenuItem
        Action = actReportsTemplates
        GroupIndex = 120
      end
      object Videos3: TMenuItem
        Action = actVidoes
        GroupIndex = 120
      end
    end
    object Sales3: TMenuItem
      Caption = 'Sa&les'
      GroupIndex = 110
      Hint = 'Window related commands'
      object Customers2: TMenuItem
        Caption = 'Customers'
        GroupIndex = 20
        object NewCustomer2: TMenuItem
          Action = actSalesCustomersNewCustomer
          GroupIndex = 20
        end
        object CustomerList2: TMenuItem
          Action = actSalesCustomersCustomerList
          GroupIndex = 20
        end
        object CustomerAccountNoSetup2: TMenuItem
          Action = actSalesCustomersCustomerAccountNoSetup
          GroupIndex = 20
        end
        object N155: TMenuItem
          Caption = '-'
          GroupIndex = 20
        end
        object ClientType2: TMenuItem
          Action = actSalesCustomersClientType
          GroupIndex = 20
        end
        object ClientTypeList2: TMenuItem
          Action = actSalesCustomersClientTypeList
          GroupIndex = 20
        end
        object N154: TMenuItem
          Caption = '-'
          GroupIndex = 20
        end
        object CustomerBalanceDetail1: TMenuItem
          Action = actCustomerBalanceDetail
          GroupIndex = 20
        end
        object CustomerDetailsList2: TMenuItem
          Action = actSalesCustomersCustomerDetailsList
          GroupIndex = 20
        end
        object CustomerNotesReport1: TMenuItem
          Action = actCustomerNotesReport
          GroupIndex = 20
        end
        object CustomerSummary2: TMenuItem
          Action = actSalesCustomersCustomerSummary
          GroupIndex = 20
        end
        object CustomerTypePriceList1: TMenuItem
          Action = actInventCustomerTypePriceList
          GroupIndex = 20
        end
        object EmployeeSummary1: TMenuItem
          Caption = 'Employee Summary'
          GroupIndex = 100
          ImageIndex = 487
        end
        object EmployeeSummary2: TMenuItem
          Action = actEmployeeReportByPeriod
          GroupIndex = 100
        end
        object ForeignSalesReport1: TMenuItem
          Action = actForeignSalesList
          GroupIndex = 100
        end
        object SalesList1: TMenuItem
          Action = actSalesSalesSalesList
          GroupIndex = 100
        end
      end
      object CRM2: TMenuItem
        Caption = 'CRM'
        GroupIndex = 20
        object OtherContacts2: TMenuItem
          Action = actSalesCRMOtherContacts
        end
        object OtherContactsList2: TMenuItem
          Action = actSalesCRMOtherContactsList
        end
        object N18: TMenuItem
          Caption = '-'
        end
        object PhoneContact2: TMenuItem
          Action = actSalesCRMPhoneContact
        end
        object PhoneContactList2: TMenuItem
          Action = actSalesCRMPhoneContactList
        end
        object N152: TMenuItem
          Caption = '-'
        end
        object Canvasser2: TMenuItem
          Action = actSalesCRMCanvasser
        end
        object CanvasserList2: TMenuItem
          Action = actSalesCRMCanvasserList
        end
        object N151: TMenuItem
          Caption = '-'
        end
        object LoyaltyProgram2: TMenuItem
          Action = actSalesCRMLoyaltyProgram
        end
        object N150: TMenuItem
          Caption = '-'
        end
        object MailMerge2: TMenuItem
          Action = actSalesCRMMailMerge
        end
        object N149: TMenuItem
          Caption = '-'
        end
        object N148: TMenuItem
          Action = actCompanyTypes
        end
        object N147: TMenuItem
          Action = actFollowupTypes
        end
        object N146: TMenuItem
          Action = actFollowupResultTypes
        end
        object SalesAnalysisChart3: TMenuItem
          Action = actsalesAnalysisGraph
          GroupIndex = 20
        end
      end
      object Jobs2: TMenuItem
        Caption = 'Jobs'
        GroupIndex = 20
        object NewJob2: TMenuItem
          Action = actApptsNewJob
          GroupIndex = 10
        end
        object JobList2: TMenuItem
          Action = actApptsJobList
          GroupIndex = 10
        end
        object N20: TMenuItem
          Caption = '-'
          GroupIndex = 20
        end
        object JobAnalysisBalanceReport2: TMenuItem
          Action = actSalesJobsJobAnalysisBalanceReport
          GroupIndex = 20
        end
        object JobProfitability2: TMenuItem
          Action = actSalesJobsJobProfitability
          GroupIndex = 20
        end
        object N21: TMenuItem
          Caption = '-'
          GroupIndex = 20
        end
        object CombinedAnalysis2: TMenuItem
          Action = actCombinedAnalysisList
          GroupIndex = 20
        end
        object CustomerJobFollowups1: TMenuItem
          Action = actCustomerJobFollowupList
          GroupIndex = 20
        end
        object CustomerDiscountPriceList3: TMenuItem
          Caption = 'Customer Discount Price List'
          GroupIndex = 20
          ImageIndex = 627
          OnClick = AnyActionExecute
        end
        object EmployeeAnalysis1: TMenuItem
          Action = actEmployeeEmployeeAnalysis
          GroupIndex = 20
        end
        object JobList1: TMenuItem
          Action = actApptsJobList
          GroupIndex = 20
        end
        object ProfitandLossSummary1: TMenuItem
          Action = actProfitLossSummary
          GroupIndex = 20
        end
        object ProfitAndLoss1: TMenuItem
          Action = actAccountsProfitAndLoss
          GroupIndex = 20
        end
      end
      object POS2: TMenuItem
        Caption = 'POS'
        GroupIndex = 20
        object POSScreen2: TMenuItem
          Action = actSalesPOSPOSScreen
        end
        object QuickPOS2: TMenuItem
          Action = actSalesPOSQuickPOS
        end
        object VoucherSale1: TMenuItem
          Action = actVoucher
        end
        object CustomisePOS2: TMenuItem
          Action = actSalesPOSCustomisePOS
        end
        object N140: TMenuItem
          Caption = '-'
        end
        object BarTabList2: TMenuItem
          Action = actSalesPOSBarTabList
        end
        object VouchersList2: TMenuItem
          Action = actSalesPOSVouchersList
        end
        object TillSummaryReport2: TMenuItem
          Action = actSalesPOSTillSummaryReport
        end
        object TrafficList2: TMenuItem
          Action = actSalesPOSTrafficList
        end
        object TrafficSummaryReport2: TMenuItem
          Action = actSalesPOSTrafficSummaryReport
        end
        object OrderProcessList2: TMenuItem
          Action = actSalesPOSOrderProcessList
        end
        object NonERPSlaes2: TMenuItem
          Action = actPOSCashPayments
        end
      end
      object Quotes2: TMenuItem
        Caption = 'Quotes'
        GroupIndex = 20
        object Quote2: TMenuItem
          Action = actSalesQuotesQuote
        end
        object QuoteList2: TMenuItem
          Action = actSalesQuotesQuoteList
        end
        object N8: TMenuItem
          Caption = '-'
        end
        object QuoteList1: TMenuItem
          Action = actQuoteDetailsReport
        end
      end
      object Manifest3: TMenuItem
        Caption = 'Manifest'
        GroupIndex = 20
        object ManifestAllocationList2: TMenuItem
          Action = actSalesManifestManifestAllocationList
        end
        object N139: TMenuItem
          Caption = '-'
        end
        object Manifest4: TMenuItem
          Action = actSalesManifestManifest
        end
        object ManifestList2: TMenuItem
          Action = actSalesManifestManifestList
        end
        object N138: TMenuItem
          Caption = '-'
        end
        object ManifestVehicle2: TMenuItem
          Action = actSalesManifestManifestVehicle
        end
        object ManifestVehicleList2: TMenuItem
          Action = actSalesManifestManifestVehicleList
        end
        object N137: TMenuItem
          Caption = '-'
        end
        object ManifestRoute2: TMenuItem
          Action = actSalesManifestManifestRoute
        end
        object ManifestRouteList2: TMenuItem
          Action = actSalesManifestManifestRouteList
        end
      end
      object Sales4: TMenuItem
        Caption = 'Sales'
        GroupIndex = 20
        object CashSale2: TMenuItem
          Action = actSalesSalesCashSale
        end
        object Refunds2: TMenuItem
          Action = actSalesSalesRefunds
        end
        object CustomerReturn1: TMenuItem
          Action = actCustomerReturns
        end
        object Invoice2: TMenuItem
          Action = actSalesSalesInvoice
        end
        object VoucherSale2: TMenuItem
          Action = actVoucher
        end
        object VoucherInvoice1: TMenuItem
          Action = actvoucherInvoice
        end
        object InvoiceList2: TMenuItem
          Action = actSalesSalesInvoiceList
        end
        object InvoiceInternalOrderExpressList1: TMenuItem
          Action = actSalesSalesInvoiceInternalOrderExpressList
        end
        object CustomerReturnList1: TMenuItem
          Action = actCustomerReturnList
        end
        object PrintAddressLabel1: TMenuItem
          Action = actsingleSalesAddressLabelPrn
        end
        object N142: TMenuItem
          Caption = '-'
        end
        object BackOrders3: TMenuItem
          Action = actSalesSalesBackOrders
        end
        object N141: TMenuItem
          Caption = '-'
        end
        object InvoiceandProductCommissionReport2: TMenuItem
          Action = actSalesCommissionList
        end
        object InvoiceCommissionReport2: TMenuItem
          Action = actCommissionReport
        end
        object ProductSalesProjection1: TMenuItem
          Action = actInventProductSales
        end
        object ProductSalesSummary3: TMenuItem
          Action = actReportsProductSalesSummary
        end
        object ProductSalesSummaryByColumn2: TMenuItem
          Action = actProductSalesSummaryByColumn
        end
        object ProfitAndLoss4: TMenuItem
          Action = actAccountsProfitAndLoss
        end
        object ProfitandLossSummary3: TMenuItem
          Action = actProfitLossSummary
        end
        object RefundSalesReport1: TMenuItem
          Action = actRefundSalesList
        end
        object SalesAnalysisChart2: TMenuItem
          Action = actsalesAnalysisGraph
          GroupIndex = 20
        end
        object SalesList2: TMenuItem
          Action = actSalesSalesSalesList
          GroupIndex = 20
        end
        object SalesReport1: TMenuItem
          Action = actSalesReport
          GroupIndex = 20
        end
        object SalesRewardPoints1: TMenuItem
          Action = actSalesRewardPointsList
          GroupIndex = 20
        end
        object SalesSummary1: TMenuItem
          Action = actReportsSalesSummary
          GroupIndex = 20
        end
        object StockTurnoverReport1: TMenuItem
          Action = actSoldProductsReport
          GroupIndex = 20
        end
        object HourlySalesReport1: TMenuItem
          Action = actHourlySalesReport
          GroupIndex = 20
        end
        object ProductstoExcludeDefaultTaxCode1: TMenuItem
          Action = actProductstoExcludeDefaultTaxCode
          GroupIndex = 20
        end
        object PrintAddressLabels1: TMenuItem
          Action = actSalesAddressLabelPrn
          GroupIndex = 20
        end
        object NonERPSales1: TMenuItem
          Action = actNonERPSalesList
          GroupIndex = 20
        end
      end
      object SalesOrders2: TMenuItem
        Caption = 'Sales Orders'
        GroupIndex = 20
        object SalesOrder2: TMenuItem
          Action = actSalesSalesOrdersSalesOrder
        end
        object SalesOrderList2: TMenuItem
          Action = actSalesSalesOrdersSalesOrderList
        end
        object N15: TMenuItem
          Caption = '-'
        end
        object SalesList3: TMenuItem
          Action = actSalesSalesSalesList
        end
        object SalesOrderReport2: TMenuItem
          Action = actSalesSalesOrdersSalesOrderReport
        end
        object SalesOrderReport1: TMenuItem
          Action = actReportsSalesOrderStatus
          GroupIndex = 20
        end
      end
      object Ebay1: TMenuItem
        Caption = 'Ebay'
        GroupIndex = 20
        object EbayOrders1: TMenuItem
          Action = actEBayOrders
          GroupIndex = 20
        end
        object EBaySalesOrders1: TMenuItem
          Action = actEBaySalesOrders
          GroupIndex = 20
        end
      end
      object Walmart1: TMenuItem
        Caption = 'Walmart'
        GroupIndex = 20
        object Walmart3: TMenuItem
          Action = actInt_WalMartOrders
        end
        object Walmart13: TMenuItem
          Action = actInt_Woocommerce
        end
        object WalmartProducts1: TMenuItem
          Action = actWalmartitems
        end
        object Walmart2: TMenuItem
          Action = actWalmartSalesOrders
        end
        object WalmartShippingMethods1: TMenuItem
          Action = actwalmartshippingmethods
        end
        object Walmart4: TMenuItem
          Action = actInt_WalMart
        end
      end
      object WooCommerce1: TMenuItem
        Caption = 'WooCommerce'
        GroupIndex = 20
        object WooCommerceOrders1: TMenuItem
          Action = actInt_WoocommCustomers
        end
        object WooCommerce2: TMenuItem
          Action = actInt_Woocommerce
        end
      end
      object N25: TMenuItem
        Caption = '-'
        GroupIndex = 20
      end
      object BackOrders1: TMenuItem
        Action = actSalesSalesBackOrders
        GroupIndex = 20
      end
      object DeliveryDocketList2: TMenuItem
        Action = actDeliveryDocketList
        GroupIndex = 20
      end
      object MarketingRatiosReport1: TMenuItem
        Action = actMarketingRatios
        GroupIndex = 20
      end
      object ProductsExpressList1: TMenuItem
        Action = actInventProductsProductsExpressList
        GroupIndex = 20
      end
      object ProductsList1: TMenuItem
        Action = actInventProductsProductsList
        GroupIndex = 20
      end
      object SalesanalysisChart1: TMenuItem
        Action = actsalesAnalysisGraph
        GroupIndex = 20
      end
      object SalesPipeline1: TMenuItem
        Action = actSalesPipeline
        GroupIndex = 20
      end
      object SalesRatiosReport1: TMenuItem
        Action = actSalesRatios
        GroupIndex = 20
      end
      object Weeklysalesreport1: TMenuItem
        Action = actWeeklysalesreport
        GroupIndex = 20
      end
      object StockAnalysisReport2: TMenuItem
        Action = actStockanalysisReport
        GroupIndex = 20
      end
      object N136: TMenuItem
        Caption = '-'
        GroupIndex = 20
      end
      object PrintInvoices2: TMenuItem
        Action = actSalesPrintInvoices
        GroupIndex = 20
      end
      object SalesAnalysis1: TMenuItem
        Caption = 'Sales Analysis'
        GroupIndex = 20
        object SalesAnalysisManual1: TMenuItem
          Action = actSalesAnalysisManual
        end
        object objectactSalesAnalysisManualListTDNMAction1: TMenuItem
          Action = actSalesAnalysisManualList
        end
        object SalesAnalysisChart4: TMenuItem
          Action = actsalesAnalysisGraph
        end
      end
      object N32: TMenuItem
        Caption = '-'
        GroupIndex = 20
      end
      object InsurancePad1: TMenuItem
        Action = actSalesQuotesPadQuote
        GroupIndex = 20
      end
      object CustomisableListCustomers2: TMenuItem
        Action = actCustomFieldValuesCustomers
        GroupIndex = 20
      end
      object CustomisableListEquipment2: TMenuItem
        Action = actCustomFieldValuesEquipments
        GroupIndex = 20
      end
    end
    object Utilities2: TMenuItem
      Caption = '&Utilities'
      GroupIndex = 120
      OnClick = Utilities2Click
      object CurrentUsers2: TMenuItem
        Action = actUtilsCurrentUsers
        GroupIndex = 190
      end
      object N235: TMenuItem
        Caption = '-'
        GroupIndex = 190
      end
      object Preferences2: TMenuItem
        Action = actUtilsPreferences
        GroupIndex = 190
      end
      object PrejerenceList1: TMenuItem
        Action = actPrejerence
        Caption = 'Preference List'
        GroupIndex = 190
      end
      object N35: TMenuItem
        Caption = '-'
        GroupIndex = 190
      end
      object DatabaseUtils2: TMenuItem
        Caption = 'Database Utils'
        GroupIndex = 190
        object Backup2: TMenuItem
          Action = actUtilsDbUtilsBackup
        end
        object Restore2: TMenuItem
          Action = actUtilsDbUtilsRestore
        end
        object Copy2: TMenuItem
          Action = actUtilsDbUtilsCopy
          Caption = 'Clone'
        end
        object ReadOnlyCopy2: TMenuItem
          Action = actUtilsDbUtilsCopyRO
        end
        object Remove2: TMenuItem
          Action = actUtilsDbUtilsRemove
        end
        object NonERPClone1: TMenuItem
          Caption = 'NonERP Clone'
          OnClick = NonERPClone1Click
        end
        object N242: TMenuItem
          Caption = '-'
        end
        object Optimise2: TMenuItem
          Action = actUtilsDbUtilsOptimise
        end
        object CleanDatabase1: TMenuItem
          Action = actCleanDatabase
        end
        object N12: TMenuItem
          Caption = '-'
        end
        object SpecialForm1: TMenuItem
          Action = actSpecialForm
        end
        object N38: TMenuItem
          Caption = '-'
        end
        object HowTo2: TMenuItem
          Caption = 'How To'
          object InstallingTestServer2: TMenuItem
            Caption = 'Installing Test Server'
          end
          object UploadingaBackupToERP2: TMenuItem
            Caption = 'Uploading a Backup To ERP'
          end
        end
        object ProductQtyFix1: TMenuItem
        end
      end
      object N234: TMenuItem
        Caption = '-'
        GroupIndex = 190
      end
      object CompanyInformation2: TMenuItem
        Action = actUtilsCompanyInformation
        GroupIndex = 190
      end
      object EmailedReport1: TMenuItem
        Action = actUtilsEmailedReport
        GroupIndex = 190
      end
      object Export1: TMenuItem
        Caption = 'Export'
        GroupIndex = 190
        object ExportData1: TMenuItem
          Action = actFileExportData
        end
        object ExportTemplates1: TMenuItem
          Action = actFileExportTemplates
        end
        object CustomExport2: TMenuItem
          Action = actCustomExport
        end
        object ExportToReportDB2: TMenuItem
          Action = actUtilsExportToReportDB
          GroupIndex = 190
        end
      end
      object mnuUtilsExportToReportDB: TMenuItem
        Action = actUtilsExportToReportDB
        GroupIndex = 190
      end
      object EmailList1: TMenuItem
        Action = actEmailList
        GroupIndex = 190
      end
      object SMSList1: TMenuItem
        Action = actSMSList
        GroupIndex = 190
      end
      object EmailPurge1: TMenuItem
        Action = actEmailPurge
        GroupIndex = 190
      end
      object FaxJobs2: TMenuItem
        Caption = 'Fax Jobs'
        GroupIndex = 190
        object FaxSpoolList2: TMenuItem
          Action = actUtilsFaxJobsFaxSpoolList
        end
        object PurgeOldFaxJobs2: TMenuItem
          Action = actUtilsFaxJobsPurgeOldFaxJobs
        end
      end
      object Import2: TMenuItem
        Caption = 'Import'
        GroupIndex = 190
        object Data2: TMenuItem
          Action = actFileImportData
          Caption = 'Import Data'
        end
        object emplates3: TMenuItem
          Action = actFileImportTemplates
        end
        object CustomImports1: TMenuItem
          Action = actCustomImports
        end
        object NT2: TMenuItem
          Caption = 'TNT'
          object ClientRates2: TMenuItem
            Action = actFileImportTNTClientRates
          end
          object PostcodetoRatingAreaZone2: TMenuItem
            Action = actFileImportTNTPostcodeToRating
          end
        end
      end
      object SetupDocsPath2: TMenuItem
        Action = actUtilsSetupDocsPath
        Caption = 'Setup  Doc'#39's Path'
        GroupIndex = 190
      end
      object N233: TMenuItem
        Caption = '-'
        GroupIndex = 190
      end
      object AuditTrail2: TMenuItem
        Caption = 'Audit Trail'
        GroupIndex = 190
        object AuditTrailList2: TMenuItem
          Action = actUtilsAuditTrailAuditTrailList
        end
        object NotesAuditTrialList1: TMenuItem
          Action = actNotesAuditTrial
        end
        object PurgeAuditTrail2: TMenuItem
          Action = actUtilsAuditTrailPurgeAuditTrail
        end
        object ExportAuditTrail2: TMenuItem
          Action = actUtilsAuditTrailExportAuditTrail
        end
      end
      object N231: TMenuItem
        Caption = '-'
        GroupIndex = 190
      end
      object mnuLanguage: TMenuItem
        Caption = 'Language'
        GroupIndex = 190
        OnClick = mnuLanguageClick
      end
      object LinkTo1: TMenuItem
        Action = actLinkTo
        GroupIndex = 190
      end
      object WebAPITest1: TMenuItem
        Action = actWebAPITest
        GroupIndex = 190
      end
      object BOSalesOrders1: TMenuItem
        Action = SOBOList
        GroupIndex = 190
      end
      object ERPTip1: TMenuItem
        Action = actERPTip
        GroupIndex = 190
      end
      object UserPasswordDetails1: TMenuItem
        Action = actUserPasswordDetails
        GroupIndex = 190
      end
    end
    object miWindow: TMenuItem
      Caption = '&Window'
      GroupIndex = 180
      OnClick = miWindowClick
      object iled2: TMenuItem
        Action = actWindowTiled
      end
      object Cascade2: TMenuItem
        Action = actWindowCascade
      end
      object ArrangeIcons2: TMenuItem
        Action = actWindowArrangeIcons
      end
      object Dashboard1: TMenuItem
        Action = actmainDashboard
      end
      object CustomiseToolbar3: TMenuItem
        Action = actWindowCustomiseToolbar
      end
      object Maximise1: TMenuItem
        Caption = 'Maximise'
        ImageIndex = 493
        OnClick = Maximise1Click
      end
      object Customise2: TMenuItem
        Action = actCustomise
        GroupIndex = 190
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      GroupIndex = 190
      object Contents2: TMenuItem
        Caption = '&Contents'
        OnClick = Contents2Click
      end
      object TrainingGuideMnu: TMenuItem
        Caption = 'Training Guide'
        Visible = False
        OnClick = TrainingGuideMnuClick
      end
      object TrainingVideos1: TMenuItem
        Caption = 'Training Videos'
        Visible = False
        OnClick = TrainingVideos1Click
      end
      object N11: TMenuItem
        Caption = '-'
        Visible = False
      end
      object UpdateNotes2: TMenuItem
        Caption = 'Update Notes'
        GroupIndex = 200
        OnClick = actAboutUpdateNotesExecute
      end
      object LicenceAgreement1: TMenuItem
        Caption = 'Licence Agreement'
        GroupIndex = 200
        OnClick = LicenceAgreement1Click
      end
      object actSoftwareAdditionsAgreement: TMenuItem
        Caption = 'Software Additions Agreement'
        GroupIndex = 200
        OnClick = actSoftwareAdditionsAgreementClick
      end
      object mnuSMSRates: TMenuItem
        Caption = 'SMS Rates'
        GroupIndex = 200
        OnClick = mnuSMSRatesClick
      end
      object N243: TMenuItem
        Caption = '-'
        GroupIndex = 200
      end
      object Videos1: TMenuItem
        Action = actVidoes
        GroupIndex = 200
      end
      object About4: TMenuItem
        Action = actAboutAbout
        GroupIndex = 200
      end
    end
  end
end
