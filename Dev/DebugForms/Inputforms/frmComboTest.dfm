inherited fmComboTest: TfmComboTest
  Caption = 'fmComboTest'
  ExplicitTop = 8
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel [3]
    Left = 23
    Top = 75
    Width = 56
    Height = 15
    Caption = 'Customer'
  end
  object Label2: TLabel [4]
    Left = 200
    Top = 75
    Width = 54
    Height = 15
    Caption = 'Sale Date'
  end
  object Label3: TLabel [5]
    Left = 336
    Top = 75
    Width = 70
    Height = 15
    Caption = 'Doc Number'
  end
  object grdMain: TwwDBGrid [6]
    Left = 23
    Top = 160
    Width = 921
    Height = 353
    ControlType.Strings = (
      'ProductName;CustomEdit;cboProduct;F')
    Selected.Strings = (
      'ProductName'#9'20'#9'ProductName'
      'Product_Description'#9'30'#9'Product_Description'
      'LinePriceInc'#9'10'#9'LinePriceInc'
      'QtySold'#9'10'#9'QtySold'
      'TotalLineAmountInc'#9'10'#9'TotalLineAmountInc')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsDetail
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = [dgAllowInsert]
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgRowResize]
    ParentFont = False
    TabOrder = 3
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
  end
  object cboClient: TERPDbLookupCombo [7]
    Left = 23
    Top = 96
    Width = 162
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    DataField = 'CustomerName'
    DataSource = dsMaster
    LookupTable = qryClientLookup
    LookupField = 'Company'
    DropDownWidth = 450
    ParentFont = False
    TabOrder = 0
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnChange = cboClientChange
    OnCloseUp = cboClientCloseUp
    LookupFormClassName = 'TCustomerListGUI'
    EditFormClassName = 'TfrmCustomer'
    LookupFormKeyStringFieldName = 'CompanyName'
    LookupComboType = ctCustomer
    AllowFullListSearchMode = False
  end
  object cboProduct: TERPDbLookupCombo [8]
    Left = 288
    Top = 280
    Width = 121
    Height = 23
    DropDownAlignment = taLeftJustify
    DataField = 'ProductName'
    DataSource = dsDetail
    LookupTable = qryPartsLookup
    LookupField = 'PARTNAME'
    TabOrder = 4
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnNotInList = cboProductNotInList
    LookupFormClassName = 'TProductListExpressGUI'
    EditFormClassName = 'TfrmParts'
    LookupFormKeyStringFieldName = 'ProductName'
    LookupComboType = ctProduct
    AllowFullListSearchMode = False
  end
  object edtSaleDate: TwwDBEdit [9]
    Left = 200
    Top = 96
    Width = 121
    Height = 23
    DataField = 'SaleDate'
    DataSource = dsMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object edtInvoiceDocNumber: TwwDBEdit [10]
    Left = 336
    Top = 96
    Width = 121
    Height = 23
    DataField = 'InvoiceDocNumber'
    DataSource = dsMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object memLog: TMemo [11]
    Left = 488
    Top = 8
    Width = 456
    Height = 146
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 5
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited QryCustomField: TERPQuery
    Left = 74
    Top = 128
  end
  object qryMaster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tmp_sales where SaleID = :SaleID')
    Left = 576
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SaleID'
      end>
    object qryMasterSaleID: TIntegerField
      FieldName = 'SaleID'
    end
    object qryMasterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMasterInvoiceDocNumber: TWideStringField
      FieldName = 'InvoiceDocNumber'
      Size = 30
    end
    object qryMasterOriginalNo: TWideStringField
      FieldName = 'OriginalNo'
      Size = 255
    end
    object qryMasterBaseNo: TWideStringField
      FieldName = 'BaseNo'
      Size = 255
    end
    object qryMasterAccount: TWideStringField
      FieldName = 'Account'
      Size = 255
    end
    object qryMasterAccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object qryMasterBOID: TWideStringField
      FieldName = 'BOID'
      Size = 255
    end
    object qryMasterCustomerName: TWideStringField
      FieldName = 'CustomerName'
      OnChange = qryMasterCustomerNameChange
      OnSetText = qryMasterCustomerNameSetText
      OnValidate = qryMasterCustomerNameValidate
      Size = 255
    end
    object qryMasterClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object qryMasterInvoiceTo: TWideStringField
      FieldName = 'InvoiceTo'
      Size = 255
    end
    object qryMasterShipTo: TWideStringField
      FieldName = 'ShipTo'
      Size = 255
    end
    object qryMasterPickupFrom: TWideStringField
      FieldName = 'PickupFrom'
      Size = 255
    end
    object qryMasterSaleDate: TDateField
      FieldName = 'SaleDate'
    end
    object qryMasterTotalTax: TFloatField
      FieldName = 'TotalTax'
    end
    object qryMasterTotalWETTax: TFloatField
      FieldName = 'TotalWETTax'
    end
    object qryMasterTotalWEGTax: TFloatField
      FieldName = 'TotalWEGTax'
    end
    object qryMasterTotalAmount: TFloatField
      FieldName = 'TotalAmount'
    end
    object qryMasterTotalAmountInc: TFloatField
      FieldName = 'TotalAmountInc'
    end
    object qryMasterTotalMarkup: TFloatField
      FieldName = 'TotalMarkup'
    end
    object qryMasterTotalDiscount: TFloatField
      FieldName = 'TotalDiscount'
    end
    object qryMasterEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 255
    end
    object qryMasterEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryMasterClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object qryMasterClass: TWideStringField
      FieldName = 'Class'
      Size = 255
    end
    object qryMasterOrderNumber: TWideStringField
      FieldName = 'OrderNumber'
      Size = 30
    end
    object qryMasterPONumber: TWideStringField
      FieldName = 'PONumber'
      Size = 30
    end
    object qryMasterChequeNo: TWideStringField
      FieldName = 'ChequeNo'
      Size = 45
    end
    object qryMasterShipDate: TDateField
      FieldName = 'ShipDate'
    end
    object qryMasterFutureSO: TWideStringField
      FieldName = 'FutureSO'
      FixedChar = True
      Size = 1
    end
    object qryMasterDueDate: TDateField
      FieldName = 'DueDate'
    end
    object qryMasterConNote: TWideStringField
      FieldName = 'ConNote'
      Size = 25
    end
    object qryMasterMemo: TWideMemoField
      FieldName = 'Memo'
      BlobType = ftWideMemo
    end
    object qryMasterComments: TWideMemoField
      FieldName = 'Comments'
      BlobType = ftWideMemo
    end
    object qryMasterInvoicePrintDesc: TWideStringField
      FieldName = 'InvoicePrintDesc'
      Size = 255
    end
    object qryMasterPickMemo: TWideStringField
      FieldName = 'PickMemo'
      Size = 255
    end
    object qryMasterPrintHold: TWideStringField
      FieldName = 'PrintHold'
      FixedChar = True
      Size = 1
    end
    object qryMasterShipping: TWideStringField
      FieldName = 'Shipping'
      Size = 255
    end
    object qryMasterTerms: TWideStringField
      FieldName = 'Terms'
      Size = 255
    end
    object qryMasterPayMethod: TWideStringField
      FieldName = 'PayMethod'
      Size = 50
    end
    object qryMasterPayDueDate: TWideStringField
      FieldName = 'PayDueDate'
      Size = 11
    end
    object qryMasterPaid: TWideStringField
      FieldName = 'Paid'
      FixedChar = True
      Size = 1
    end
    object qryMasterBalance: TFloatField
      FieldName = 'Balance'
    end
    object qryMasterSOBalance: TFloatField
      FieldName = 'SOBalance'
    end
    object qryMasterPayment: TFloatField
      FieldName = 'Payment'
    end
    object qryMasterApplyFlag: TWideStringField
      FieldName = 'ApplyFlag'
      FixedChar = True
      Size = 1
    end
    object qryMasterAmountDue: TFloatField
      FieldName = 'AmountDue'
    end
    object qryMasterTimeOfSale: TWideStringField
      FieldName = 'TimeOfSale'
      Size = 11
    end
    object qryMasterIsPOS: TWideStringField
      FieldName = 'IsPOS'
      FixedChar = True
      Size = 1
    end
    object qryMasterPOS: TWideStringField
      FieldName = 'POS'
      FixedChar = True
      Size = 1
    end
    object qryMasterIsRefund: TWideStringField
      FieldName = 'IsRefund'
      FixedChar = True
      Size = 1
    end
    object qryMasterIsCashSale: TWideStringField
      FieldName = 'IsCashSale'
      FixedChar = True
      Size = 1
    end
    object qryMasterIsInvoice: TWideStringField
      FieldName = 'IsInvoice'
      FixedChar = True
      Size = 1
    end
    object qryMasterIsQuote: TWideStringField
      FieldName = 'IsQuote'
      FixedChar = True
      Size = 1
    end
    object qryMasterIsSalesOrder: TWideStringField
      FieldName = 'IsSalesOrder'
      FixedChar = True
      Size = 1
    end
    object qryMasterIsVoucher: TWideStringField
      FieldName = 'IsVoucher'
      FixedChar = True
      Size = 1
    end
    object qryMasterIsLayby: TWideStringField
      FieldName = 'IsLayby'
      FixedChar = True
      Size = 1
    end
    object qryMasterIsLaybyTOS: TWideStringField
      FieldName = 'IsLaybyTOS'
      FixedChar = True
      Size = 1
    end
    object qryMasterIsLaybyPayment: TWideStringField
      FieldName = 'IsLaybyPayment'
      FixedChar = True
      Size = 1
    end
    object qryMasterDeleted: TWideStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
    object qryMasterCancelled: TWideStringField
      FieldName = 'Cancelled'
      FixedChar = True
      Size = 1
    end
    object qryMasterEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryMasterTotalQuoteAmount: TFloatField
      FieldName = 'TotalQuoteAmount'
    end
    object qryMasterLaybyID: TWideStringField
      FieldName = 'LaybyID'
      Size = 14
    end
    object qryMasterDeposited: TWideStringField
      FieldName = 'Deposited'
      FixedChar = True
      Size = 1
    end
    object qryMasterTillID: TSmallintField
      FieldName = 'TillID'
    end
    object qryMasterTillName: TWideStringField
      FieldName = 'TillName'
      Size = 255
    end
    object qryMasterHoldSale: TWideStringField
      FieldName = 'HoldSale'
      FixedChar = True
      Size = 1
    end
    object qryMasterSaleConfirmed: TWideStringField
      FieldName = 'SaleConfirmed'
      FixedChar = True
      Size = 1
    end
    object qryMasterFreezeQuoteAmount: TWideStringField
      FieldName = 'FreezeQuoteAmount'
      FixedChar = True
      Size = 1
    end
    object qryMasterConverted: TWideStringField
      FieldName = 'Converted'
      FixedChar = True
      Size = 1
    end
    object qryMasterEnteredBy: TWideStringField
      FieldName = 'EnteredBy'
      Size = 255
    end
    object qryMasterEnteredAt: TWideStringField
      FieldName = 'EnteredAt'
      Size = 255
    end
    object qryMasterCommissionPaid: TWideStringField
      FieldName = 'CommissionPaid'
      FixedChar = True
      Size = 1
    end
    object qryMasterIsManifest: TWideStringField
      FieldName = 'IsManifest'
      FixedChar = True
      Size = 1
    end
    object qryMasterUsedOnManifest: TWideStringField
      FieldName = 'UsedOnManifest'
      FixedChar = True
      Size = 1
    end
    object qryMasterAddToManifest: TWideStringField
      FieldName = 'AddToManifest'
      FixedChar = True
      Size = 1
    end
    object qryMasterSalesOrderGlobalRef: TWideStringField
      FieldName = 'SalesOrderGlobalRef'
      Size = 255
    end
    object qryMasterQuoteGlobalRef: TWideStringField
      FieldName = 'QuoteGlobalRef'
      Size = 255
    end
    object qryMasterRepairGlobalRef: TWideStringField
      FieldName = 'RepairGlobalRef'
      Size = 255
    end
    object qryMasterSOProgressPaymentGlobalRef: TWideStringField
      FieldName = 'SOProgressPaymentGlobalRef'
      Size = 255
    end
    object qryMasterSOProgressPaymentOriginalRef: TWideStringField
      FieldName = 'SOProgressPaymentOriginalRef'
      Size = 255
    end
    object qryMasterIsBarcodePicking: TWideStringField
      FieldName = 'IsBarcodePicking'
      FixedChar = True
      Size = 1
    end
    object qryMasterBarcodePickingDone: TWideStringField
      FieldName = 'BarcodePickingDone'
      FixedChar = True
      Size = 1
    end
    object qryMasterARNotes: TWideMemoField
      FieldName = 'ARNotes'
      BlobType = ftWideMemo
    end
    object qryMasterOriginalCreationDate: TDateField
      FieldName = 'OriginalCreationDate'
    end
    object qryMasterQuoteStatus: TWideStringField
      FieldName = 'QuoteStatus'
      Size = 255
    end
    object qryMasterDespatchID: TIntegerField
      FieldName = 'DespatchID'
    end
    object qryMasterRunID: TIntegerField
      FieldName = 'RunID'
    end
    object qryMasterRunName: TWideStringField
      FieldName = 'RunName'
      Size = 255
    end
    object qryMasterReference: TWideStringField
      FieldName = 'Reference'
      Size = 255
    end
    object qryMastermsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryMasterPOCreated: TWideStringField
      FieldName = 'POCreated'
      FixedChar = True
      Size = 1
    end
    object qryMasterLastUpdated: TDateTimeField
      FieldName = 'LastUpdated'
    end
    object qryMasterForeignExchangeCode: TWideStringField
      FieldName = 'ForeignExchangeCode'
      FixedChar = True
      Size = 3
    end
    object qryMasterForeignExchangeRate: TFloatField
      FieldName = 'ForeignExchangeRate'
    end
    object qryMasterForeignTotalAmount: TFloatField
      FieldName = 'ForeignTotalAmount'
    end
    object qryMasterForeignPaidAmount: TFloatField
      FieldName = 'ForeignPaidAmount'
    end
    object qryMasterForeignBalanceAmount: TFloatField
      FieldName = 'ForeignBalanceAmount'
    end
    object qryMasterIsGeneratedFromHire: TWideStringField
      FieldName = 'IsGeneratedFromHire'
      FixedChar = True
      Size = 1
    end
    object qryMasterBlindBalancePeriodID: TIntegerField
      FieldName = 'BlindBalancePeriodID'
    end
    object qryMasterSaleDateTime: TDateTimeField
      FieldName = 'SaleDateTime'
    end
    object qryMasterAutoSmartOrderRef: TWideStringField
      FieldName = 'AutoSmartOrderRef'
      Size = 255
    end
    object qryMasterIsInternalOrder: TWideStringField
      FieldName = 'IsInternalOrder'
      FixedChar = True
      Size = 1
    end
    object qryMasterShippingCost: TFloatField
      FieldName = 'ShippingCost'
    end
    object qryMastercontactID: TLargeintField
      FieldName = 'contactID'
    end
    object qryMasterContactName: TWideStringField
      FieldName = 'ContactName'
      Size = 100
    end
    object qryMasterPOSPostCode: TWideStringField
      FieldName = 'POSPostCode'
      Size = 4
    end
    object qryMasterRepairID: TLargeintField
      FieldName = 'RepairID'
    end
    object qryMasterMedtypeID: TIntegerField
      FieldName = 'MedtypeID'
    end
    object qryMasterMedtype: TWideStringField
      FieldName = 'Medtype'
      Size = 100
    end
    object qryMasterNoOfBoxes: TLargeintField
      FieldName = 'NoOfBoxes'
    end
  end
  object dsMaster: TDataSource
    DataSet = qryMaster
    Left = 568
    Top = 16
  end
  object qryDetail: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tmp_saleslines where SaleID = :SaleID')
    Left = 640
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SaleID'
      end>
    object qryDetailProductName: TWideStringField
      DisplayWidth = 20
      FieldName = 'ProductName'
      OnChange = qryMasterCustomerNameChange
      Size = 60
    end
    object qryDetailProduct_Description: TWideStringField
      DisplayWidth = 30
      FieldName = 'Product_Description'
      Size = 255
    end
    object qryDetailLinePriceInc: TFloatField
      DisplayWidth = 10
      FieldName = 'LinePriceInc'
    end
    object qryDetailQtySold: TFloatField
      DisplayWidth = 10
      FieldName = 'QtySold'
    end
    object qryDetailTotalLineAmountInc: TFloatField
      DisplayWidth = 10
      FieldName = 'TotalLineAmountInc'
    end
    object qryDetailSaleLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleLineID'
      Visible = False
    end
    object qryDetailSaleID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleID'
      Visible = False
    end
    object qryDetailProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Visible = False
    end
  end
  object dsDetail: TDataSource
    DataSet = qryDetail
    Left = 640
    Top = 24
  end
  object qryClientLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      '(select Company from tmp_clients'
      'where (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (Company LIKE Concat(:SearchValue,"%")' +
        '))'
      
        'or ((:SearchMode = 2) and (Company LIKE Concat("%",:SearchValue,' +
        '"%"))))'
      'and IfNull(:SearchValue,"") <> ""'
      'order by company)')
    Left = 400
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
  end
  object qryPartsLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      '(select partname from tmp_parts'
      'where (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (PartName LIKE Concat(:SearchValue,"%"' +
        ')))'
      
        'or ((:SearchMode = 2) and (PartName LIKE Concat("%",:SearchValue' +
        ',"%"))))'
      'and IfNull(:SearchValue,"") <> ""'
      'order by partname)')
    Left = 464
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
  end
end
