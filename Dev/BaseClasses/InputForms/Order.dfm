inherited BaseOrderGUI: TBaseOrderGUI
  Left = 535
  Top = 171
  Caption = 'Order'
  ClientWidth = 839
  OnKeyPress = FormKeyPress
  ExplicitLeft = 535
  ExplicitTop = 171
  ExplicitWidth = 855
  DesignSize = (
    839
    588)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Width = 839
    ExplicitWidth = 839
  end
  inherited pnlDetail: TDNMPanel
    Width = 839
    Align = alTop
    ParentColor = True
    ExplicitWidth = 839
    inherited grdTransactions: TwwDBGrid
      Width = 839
      ControlType.Strings = (
        'ProductName;CustomEdit;cboProductR;F'
        'CustomerJob;CustomEdit;cboCustJob;F'
        'Class;CustomEdit;cboClass;F'
        'LineTaxCode;CustomEdit;cboTaxCode;F'
        'ForeignExchangeCode;CustomEdit;cboForeignCurrencyCode;F'
        'UnitofMeasurePOLines;CustomEdit;cboUnitOfMeasure;F'
        'EquipmentName;CustomEdit;cboEquipmentname;F'
        'MemoLine;CustomEdit;edtMemoLine;F'
        'RepairDocNo;CustomEdit;cboRepairDocNo;F'
        'AreaCode;CustomEdit;cboLinesAreaCode;F')
      Selected.Strings = (
        'ProductName'#9'17'#9'Name'
        'Product_custFld1'#9'20'#9'Product_custFld1'
        'Product_custFld2'#9'20'#9'Product_custFld2'
        'Product_custFld3'#9'20'#9'Product_custFld3'
        'Product_custFld4'#9'20'#9'Product_custFld4'
        'Product_custFld5'#9'20'#9'Product_custFld5'
        'Product_custFld6'#9'20'#9'Product_custFld6'
        'Product_custFld7'#9'20'#9'Product_custFld7'
        'Product_custFld8'#9'20'#9'Product_custFld8'
        'Product_custFld9'#9'20'#9'Product_custFld9'
        'Product_custFld10'#9'20'#9'Product_custFld10'
        'Product_custFld11'#9'20'#9'Product_custFld11'
        'Product_custFld12'#9'20'#9'Product_custFld12'
        'Product_custFld13'#9'20'#9'Product_custFld13'
        'Product_custFld14'#9'20'#9'Product_custFld14'
        'Product_custFld15'#9'20'#9'Product_custFld15'
        'Product_custDate1'#9'18'#9'Product_custDate1'
        'Product_custDate2'#9'18'#9'Product_custDate2'
        'Product_custDate3'#9'18'#9'Product_custDate3'
        'Class'#9'20'#9'Class'
        'UnitofMeasurePOLines'#9'20'#9'Units'
        'UnitofMeasureQtySold'#9'10'#9'Ordered'
        'UnitofMeasureShipped'#9'10'#9'Received'
        'PQA'#9'1'#9'Allocation'
        'UnitofMeasureBackorder'#9'10'#9'BO'
        'Attrib1Purchase'#9'16'#9'Metres'
        'Attrib2Purchase'#9'16'#9'Weight'
        'Attrib1PurchaseRate'#9'16'#9'Metres'
        'LineCost'#9'10'#9'Cost (Ex)'
        'ForeignCurrencyLineCost'#9'10'#9'Foreign Cost'
        'LineTaxCode'#9'15'#9'Code'
        'LineTax'#9'10'#9'Tax (Dbl Click)'
        'TotalLineAmountInc'#9'10'#9'Amount (Inc)'
        'ETADate'#9'10'#9'ETA Date'
        'CustomField1'#9'20'#9'CustomField1'
        'CustomField2'#9'20'#9'CustomField2'
        'CustomField3'#9'20'#9'CustomField3'
        'CustomField4'#9'20'#9'CustomField4'
        'CustomField5'#9'20'#9'CustomField5'
        'CustomField6'#9'20'#9'CustomField6'
        'CustomField7'#9'20'#9'CustomField7'
        'CustomField8'#9'20'#9'CustomField8'
        'CustomField9'#9'20'#9'CustomField9'
        'CustomField10'#9'20'#9'CustomField10'
        'AccountNumber'#9'50'#9'Account Number'
        'SpecDescription'#9'20'#9'Specifications'
        'SpecValue'#9'10'#9'Spec Qty'
        'UnitOfMeasureID'#9'10'#9'UnitOfMeasureID'
        'SortID'#9'10'#9'SortID'
        'LinesOrder'#9'10'#9'Order by'
        'MemoLine'#9'10'#9'Memo Line'
        'ReceivedDate'#9'18'#9'Receive On'
        'EquipmentName'#9'100'#9'Equipment Name'
        'LandedCostsPercentage'#9'10'#9'Landed Cost %'
        'LandedCostsPerItem'#9'10'#9'Landed Cost/Item'
        'TotalLineLandedCost'#9'10'#9'Landed Cost'
        'SupplierProductCode'#9'20'#9'Supp Product Code'
        'SupplierProductName'#9'20'#9'Supp Product Name'
        'PartBarcode'#9'20'#9'Barcode'
        'UOM_Height'#9'10'#9'Height'
        'UOM_Width'#9'10'#9'Width'
        'UOM_Length'#9'10'#9'Length'
        'UOM_Weight'#9'10'#9'Weight'
        'TotalUOM_WeightSold'#9'10'#9'Total Sold Weight'
        'TotalUOM_WeightShipped'#9'10'#9'Total Shipped Weight'
        'TotalUOM_WeightBO'#9'10'#9'Total BO Weight'
        'TotalUOM_LengthSold'#9'10'#9'Total Sold Length'
        'TotalUOM_LengthShipped'#9'10'#9'Total Shipped Length'
        'TotalUOM_LengthBO'#9'10'#9'Total BO Length'
        'UOM_Volume'#9'10'#9'Volume'
        'RepairDocNo'#9'12'#9'Repair #'
        'FormulaQtySoldValue1'#9'10'#9'FormulaQtySoldValue1'
        'FormulaQtySoldValue2'#9'10'#9'FormulaQtySoldValue2'
        'FormulaQtySoldValue3'#9'10'#9'FormulaQtySoldValue3'
        'FormulaQtySoldValue4'#9'10'#9'FormulaQtySoldValue4'
        'FormulaQtySoldValue5'#9'10'#9'FormulaQtySoldValue5'
        'FormulaQtyShippedValue1'#9'10'#9'FormulaQtyShippedValue1'
        'FormulaQtyShippedValue2'#9'10'#9'FormulaQtyShippedValue2'
        'FormulaQtyShippedValue3'#9'10'#9'FormulaQtyShippedValue3'
        'FormulaQtyShippedValue4'#9'10'#9'FormulaQtyShippedValue4'
        'FormulaQtyShippedValue5'#9'10'#9'FormulaQtyShippedValue5'
        'FormulaQtySoldValue'#9'10'#9'FormulaQtySoldValue'
        'FormulaQtyShippedValue'#9'10'#9'FormulaQtyShippedValue'
        'Attrib1PurchaseEst'#9'10'#9'Attrib1PurchaseEst'
        'Attrib2PurchaseEst'#9'10'#9'Metres'
        'EmployeeID'#9'10'#9'EmployeeID'
        'EmployeeName'#9'100'#9'EmployeeName'
        'AreaCode'#9'10'#9'Area'
        'ForeignUOMLineCost'#9'10'#9'Foreign UOM Cost'
        'ProductPrintName'#9'20'#9'ProductPrintName')
      MemoAttributes = [mSizeable, mGridShow]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgShowFooter, dgRowResize]
      PopupMenu = popOptions
      OnKeyDown = grdTransactionsKeyDown
      OnFieldChanged = grdTransactionsFieldChanged
      FooterColor = clWhite
      FooterCellColor = clWhite
      ExplicitWidth = 839
    end
    object cboClass: TwwDBLookupCombo [1]
      Left = 180
      Top = 18
      Width = 65
      Height = 26
      AutoSize = False
      DropDownAlignment = taLeftJustify
      DataField = 'Class'
      DataSource = DSDetails
      LookupTable = cboClassQry
      LookupField = 'ClassName'
      Options = [loColLines, loTitles, loSearchOnBackspace]
      DropDownWidth = 150
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      OrderByDisplay = False
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnDropDown = cboClassDropDown
      OnCloseUp = cboClassCloseUp
    end
    inherited cboTaxCode: TERPDbLookupCombo [2]
      Left = 62
      Top = 18
      Width = 65
      Height = 26
      TabOrder = 12
      UseTFields = False
      OnDropDown = cboTaxCodeDropDown
      ExplicitLeft = 62
      ExplicitTop = 18
      ExplicitWidth = 65
      ExplicitHeight = 26
    end
    object cboForeignCurrencyCode: TwwDBLookupCombo [3]
      Left = 298
      Top = 18
      Width = 65
      Height = 26
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Code'#9'3'#9'Code'#9#9
        'Country'#9'25'#9'Country'#9'F'#9
        'Currency'#9'15'#9'Currency'#9'F')
      DataField = 'ForeignExchangeCode'
      DataSource = DSDetails
      LookupTable = qryForeignCurrency
      LookupField = 'Code'
      Style = csDropDownList
      ParentFont = False
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnDropDown = cboForeignCurrencyCodeDropDown
    end
    object cboUnitOfMeasure: TwwDBLookupCombo [4]
      Left = 534
      Top = 18
      Width = 65
      Height = 26
      AutoSize = False
      DropDownAlignment = taLeftJustify
      DataField = 'UnitofMeasurePOLines'
      DataSource = DSDetails
      LookupTable = qryUnitOfMeasure
      LookupField = 'UnitName'
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnDropDown = cboUnitOfMeasureDropDown
      OnCloseUp = cboUnitOfMeasureCloseUp
    end
    object txtSearchFilter: TwwDBEdit [5]
      Left = 357
      Top = 20
      Width = 65
      Height = 23
      DataField = 'SearchFilter'
      DataSource = DSDetails
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      UnboundDataType = wwDefault
      Visible = False
      WantReturns = False
      WordWrap = False
    end
    object cboPartSpecs: TwwDBLookupCombo [6]
      Left = 593
      Top = 18
      Width = 65
      Height = 26
      AutoSize = False
      DropDownAlignment = taLeftJustify
      DataField = 'SpecDescription'
      DataSource = DSDetails
      LookupField = 'SpecDescription'
      TabOrder = 5
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnDropDown = cboPartSpecsDropDown
      OnCloseUp = cboUnitOfMeasureCloseUp
    end
    object cboProductR: TERPDbLookupCombo [7]
      Left = 4
      Top = 18
      Width = 65
      Height = 26
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PARTNAME'#9'15'#9'Product Name'#9'F'
        'Manuf'#9'15'#9'Manuf'#9'F'
        'Type'#9'15'#9'Type'#9'F'
        'Dept'#9'15'#9'Dept'#9'F'
        'PurchaseDesc'#9'35'#9'Description'#9'F'
        'Active'#9'1'#9'Active'#9'F'
        'SupplierProductCode'#9'20'#9'Supplier Product Code'#9'F')
      DataField = 'ProductName'
      DataSource = DSDetails
      LookupTable = cboProductQry
      LookupField = 'Partname'
      Options = [loTitles]
      TabOrder = 6
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnNotInList = cboProductRNotInList
      LookupFormClassName = 'TProductListExpressGUI'
      EditFormClassName = 'TfrmParts'
      LookupFormKeyStringFieldName = 'ProductName'
      LookupComboType = ctProduct
      AllowFullListSearchMode = False
      OnAfterchange = cboProductRAfterchange
      DisableNotInList = False
      AllowMultipleSelectFromList = True
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      DataIDField = 'ProductId'
      LookupIDField = 'PartsID'
      LookupFieldAlt = 'ProductPrintName'
    end
    object cboEquipmentName: TwwDBLookupCombo [8]
      Left = 416
      Top = 18
      Width = 65
      Height = 26
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'EquipmentName'#9'20'#9'Name'#9'F'
        'RepairNo'#9'15'#9'Repair #'#9'F'
        'Serialno'#9'1'#9'Serial#'#9'F'
        'UOM'#9'50'#9'UOM'#9'F'
        'Quantity'#9'1'#9'Quantity'#9'F'
        'Manufacture'#9'1'#9'Manufacture'#9'F'
        'model'#9'1'#9'Model'#9'F'
        'Registration'#9'1'#9'Registration'#9'F'
        'WarantyFinishDate'#9'1'#9'Warranty Finish'#9'F'
        'WarantyPeriod'#9'1'#9'Warranty Period'#9'F')
      LookupTable = qryRepairEquip
      LookupField = 'CustomerEquipmentID'
      Options = [loTitles]
      TabOrder = 7
      Visible = False
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = True
      OnDblClick = cboEquipmentNameDblClick
      OnBeforeDropDown = cboEquipmentNameBeforeDropDown
      OnDropDown = cboEquipmentNameDropDown
      OnCloseUp = cboEquipmentNameCloseUp
      OnNotInList = cboEquipmentNameNotInList
    end
    object edtMemoLine: TwwDBEdit [9]
      Left = 711
      Top = 18
      Width = 65
      Height = 26
      DataField = 'MemoLine'
      TabOrder = 8
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object cboRepairDocNo: TwwDBLookupCombo [10]
      Left = 770
      Top = 18
      Width = 65
      Height = 26
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'RepairDocNo'#9'20'#9'Repair #'#9'F'
        'CustomerName'#9'30'#9'Customer Name'#9'F')
      DataField = 'RepairDocNo'
      DataSource = DSDetails
      LookupTable = qryRepairLookup
      LookupField = 'RepairID'
      Options = [loTitles]
      TabOrder = 9
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnCloseUp = cboRepairDocNoCloseUp
    end
    object cboLineEmployee: TwwDBLookupCombo [11]
      Left = 64
      Top = 209
      Width = 109
      Height = 18
      AutoSize = False
      DropDownAlignment = taLeftJustify
      DataField = 'EmployeeName'
      DataSource = DSDetails
      LookupTable = qryEmployeeLookup
      LookupField = 'EmployeeName'
      TabOrder = 10
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    inherited cboLinesAreaCode: TwwDBLookupCombo [12]
      Left = 652
      Top = 20
      Width = 65
      TabOrder = 11
      ExplicitLeft = 652
      ExplicitTop = 20
      ExplicitWidth = 65
    end
    object cboPrintProductR: TERPDbLookupCombo
      Left = 239
      Top = 18
      Width = 65
      Height = 26
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PARTNAME'#9'15'#9'Product Name'#9'F'
        'Manuf'#9'15'#9'Manuf'#9'F'
        'Type'#9'15'#9'Type'#9'F'
        'Dept'#9'15'#9'Dept'#9'F'
        'PurchaseDesc'#9'35'#9'Description'#9'F'
        'Active'#9'1'#9'Active'#9'F'
        'SupplierProductCode'#9'20'#9'Supplier Product Code'#9'F')
      DataField = 'ProductName'
      DataSource = DSDetails
      LookupTable = cboProductQry
      LookupField = 'Partname'
      Options = [loTitles]
      TabOrder = 13
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnNotInList = cboProductRNotInList
      LookupFormClassName = 'TProductListExpressGUI'
      EditFormClassName = 'TfrmParts'
      LookupFormKeyStringFieldName = 'ProductName'
      LookupComboType = ctProduct
      AllowFullListSearchMode = False
      DisableNotInList = False
      AllowMultipleSelectFromList = True
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      DataIDField = 'ProductId'
      LookupIDField = 'PartsID'
      LookupFieldAlt = 'ProductPrintName'
    end
    object cboCustJob: TERPDbLookupCombo
      Left = 122
      Top = 50
      Width = 121
      Height = 26
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'30'#9'Company'#9'F'
        'JobNumber'#9'10'#9'Job Number'#9'F')
      DataField = 'CustomerJob'
      DataSource = DSDetails
      LookupTable = qryCustomerJob
      LookupField = 'Company'
      TabOrder = 15
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnDropDown = cboCustomerJobDropDown
      OnExit = cboCustomerJobExit
      OnNotInList = cboCustomerJobNotInList
      LookupFormClassName = 'TCustomerExpressListGUI'
      EditFormClassName = 'TfrmCustomer'
      LookupFormKeyStringFieldName = 'Company'
      LookupComboType = ctCustomer
      AllowFullListSearchMode = False
      DisableNotInList = False
      AllowMultipleSelectFromList = False
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      DataIDField = 'CustomerJobID'
      LookupIDField = 'ClientID'
      LookupFieldAlt = 'PrintName'
    end
    object cboCustPrintJob: TERPDbLookupCombo
      Left = 249
      Top = 50
      Width = 121
      Height = 26
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'45'#9'Company'#9'F'#9
        'JobNumber'#9'8'#9'JobNumber'#9'F'#9)
      DataField = 'CustomerJob'
      DataSource = DSDetails
      LookupTable = qryCustomerJob
      LookupField = 'Company'
      TabOrder = 14
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnDropDown = cboCustomerJobDropDown
      OnExit = cboCustomerJobExit
      OnNotInList = cboCustomerJobNotInList
      LookupFormClassName = 'TCustomerExpressListGUI'
      EditFormClassName = 'TfrmCustomer'
      LookupFormKeyStringFieldName = 'Company'
      LookupComboType = ctCustomer
      AllowFullListSearchMode = False
      DisableNotInList = False
      AllowMultipleSelectFromList = False
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      DataIDField = 'CustomerJobID'
      LookupIDField = 'ClientID'
      LookupFieldAlt = 'PrintName'
    end
  end
  inherited pnlFooter: TDNMPanel
    Top = 464
    Width = 839
    Height = 124
    Align = alClient
    ParentColor = True
    ExplicitTop = 464
    ExplicitWidth = 839
    ExplicitHeight = 124
    DesignSize = (
      839
      124)
    inherited lblComments: TLabel
      Left = 9
      ExplicitLeft = 9
    end
    inherited Label142: TLabel
      Left = 655
      ExplicitLeft = 655
    end
    inherited Label54: TLabel
      Left = 656
      ExplicitLeft = 656
    end
    inherited Label56: TLabel
      Caption = 'Total Amount'
    end
    inherited pnlComments: TDNMPanel
      inherited txtComments: TDBMemo
        DataField = 'Comments'
      end
    end
    inherited txtSubTotal: TDBEdit
      Left = 721
      DataField = 'TotalAmount'
      ExplicitLeft = 721
    end
    inherited txtTotalTax: TDBEdit
      Left = 721
      DataField = 'TotalTax'
      ExplicitLeft = 721
    end
    inherited txtTotalAmount: TDBEdit
      Left = 707
      DataField = 'TotalAmountInc'
      TabOrder = 9
      ExplicitLeft = 707
    end
    inherited lblDisableCalc: TDNMSpeedButton
      TabOrder = 8
    end
    inherited DNMPanel5: TDNMPanel
      Left = 348
      Top = 0
      ExplicitLeft = 348
      ExplicitTop = 0
      inherited lblPrintHead: TLabel
        Top = 44
        ExplicitTop = 44
      end
      inherited lblPrintedBy: TLabel
        Top = 44
        ExplicitTop = 44
      end
      inherited lblPrintedOnCaption: TLabel
        Left = 10
        Top = 63
        ExplicitLeft = 10
        ExplicitTop = 63
      end
      inherited lblPrintedOn: TLabel
        Left = 77
        Top = 63
        ExplicitLeft = 77
        ExplicitTop = 63
      end
      inherited lblPrintedAtCaption: TLabel
        Top = 83
        ExplicitTop = 83
      end
      inherited lblPrintedAt: TLabel
        Top = 83
        ExplicitTop = 83
      end
      object lblEnteredAtHead: TLabel
        Left = 10
        Top = 25
        Width = 59
        Height = 15
        Caption = 'Entered At'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblEnteredAt: TDBText
        Left = 80
        Top = 27
        Width = 85
        Height = 17
        DataField = 'EnteredAt'
        DataSource = DSMaster
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
    end
    inherited pnlProcessMessage: TDNMPanel
      Width = 839
      TabOrder = 2
      ExplicitWidth = 839
      inherited lblProcessMessage: TLabel
        Width = 835
        ExplicitWidth = 835
      end
    end
    object btnAttachments: TDNMSpeedButton
      Left = 4
      Top = 22
      Width = 65
      Height = 22
      Caption = 'Attach'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500000000000
        000557777777777777750BBBBBBBBBBBBBB07F5555FFFFFFF5570BBBB0000000
        BBB07F5557777777FF570BBB077BBB770BB07F557755555775570BBBBBBBBBBB
        BBB07F5555FFFFFFF5570BBBB0000000BBB07F5557777777F5570BBBB0FFFFF0
        BBB07F5557FFFFF7F5570BBBB0000000BBB07F555777777755570BBBBBBBBBBB
        BBB07FFFFFFFFFFFFFF700000000000000007777777777777777500FFFFFFFFF
        F005577FF555FFFFF7755500FFF00000005555775FF7777777F5550F777FFFFF
        F055557F777FFF5557F5550000000FFF00555577777775FF77F5550777777000
        7055557FFFFFF777F7F555000000000000555577777777777755}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = btnAttachmentsClick
    end
  end
  inherited pnlHeader: TDNMPanel
    Top = 0
    Width = 839
    Align = alTop
    Color = clActiveBorder
    ExplicitTop = 0
    ExplicitWidth = 839
    DesignSize = (
      839
      237)
    inherited Label38: TLabel [0]
      Left = 14
      Top = 39
      Caption = 'Supplier Name'
      ExplicitLeft = 14
      ExplicitTop = 39
    end
    inherited lblClientDetails: TLabel [1]
    end
    inherited SaleDate_Label: TLabel [2]
      Left = 503
      ExplicitLeft = 503
    end
    inherited Label160: TLabel [3]
      Left = 644
      ExplicitLeft = 644
    end
    object Label43: TLabel [4]
      Left = 6
      Top = 194
      Width = 83
      Height = 18
      Alignment = taCenter
      AutoSize = False
      Caption = '# Number'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label47: TLabel [5]
      Left = 362
      Top = 194
      Width = 31
      Height = 18
      Alignment = taCenter
      AutoSize = False
      Caption = 'Via'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label79: TLabel [6]
      Left = 484
      Top = 194
      Width = 45
      Height = 18
      AutoSize = False
      Caption = 'Terms'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label45: TLabel [7]
      Left = 604
      Top = 194
      Width = 61
      Height = 18
      AutoSize = False
      Caption = 'Due Date'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblAccount: TLabel [8]
      Left = 17
      Top = 2
      Width = 48
      Height = 14
      AutoSize = False
      Caption = 'Account'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    inherited Label48: TLabel [9]
      Left = 128
      ExplicitLeft = 128
    end
    inherited lbMemTrans: TLabel [10]
      Left = 596
      ExplicitLeft = 596
    end
    inherited lblBaseForeignCurrencyCode: TLabel [11]
      Left = 520
      ExplicitLeft = 520
    end
    inherited lblBaseExchangeRate: TLabel [12]
    end
    inherited lblRedeemPoints: TLabel [13]
    end
    object lblArea: TLabel [14]
      Left = 352
      Top = 123
      Width = 75
      Height = 15
      Alignment = taRightJustify
      Caption = 'Area Number'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    inherited imgSearch: TImage [15]
    end
    inherited lblStatus: TLabel [16]
      Left = 247
      Top = 188
      ExplicitLeft = 247
      ExplicitTop = 188
    end
    inherited cboCurrentTransStatus: TwwDBLookupCombo [17]
      Left = 249
      Top = 208
      Selected.Strings = (
        'Name'#9'75'#9'Name'#9'F')
      DataField = 'OrderStatus'
      LookupField = 'name'
      TabOrder = 26
      ExplicitLeft = 249
      ExplicitTop = 208
    end
    inherited txtClientDetails: TDBMemo [18]
      Left = 14
      DataField = 'OrderTo'
      TabOrder = 3
      ExplicitLeft = 14
    end
    inherited cboCreationDate: TwwDBDateTimePicker [19]
      Left = 503
      Top = 54
      DataField = 'OrderDate'
      Date = 0.000000000000000000
      TabOrder = 10
      ExplicitLeft = 503
      ExplicitTop = 54
    end
    inherited txtCustomID: TDBEdit [20]
      Left = 646
      Top = 54
      DataField = 'PurchaseOrderNumber'
      TabOrder = 2
      ExplicitLeft = 646
      ExplicitTop = 54
    end
    inherited cboEmployee: TwwDBLookupCombo [21]
      Left = 127
      Top = 209
      DataField = 'EmployeeName'
      TabOrder = 5
      ExplicitLeft = 127
      ExplicitTop = 209
    end
    object txtInvNumber: TDBEdit [22]
      Left = 14
      Top = 209
      Width = 97
      Height = 23
      DataField = 'InvoiceNumber'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object cboVia: TwwDBLookupCombo [23]
      Left = 363
      Top = 210
      Width = 116
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      DataField = 'Shipping'
      DataSource = DSMaster
      LookupTable = cboViaQry
      LookupField = 'ShippingMethod'
      ParentFont = False
      TabOrder = 6
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnEnter = cboViaEnter
    end
    object cboTerms: TwwDBLookupCombo [24]
      Left = 482
      Top = 210
      Width = 116
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      DataField = 'Terms'
      DataSource = DSMaster
      LookupTable = cboTermsQry
      LookupField = 'Terms'
      ParentFont = False
      TabOrder = 7
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboTermsCloseUp
    end
    object cboDueDate: TwwDBDateTimePicker [25]
      Left = 604
      Top = 210
      Width = 116
      Height = 23
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'DueDate'
      DataSource = DSMaster
      Epoch = 1950
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 8
      UnboundDataType = wwDTEdtDate
    end
    object cboAccount: TwwDBLookupCombo [26]
      Left = 14
      Top = 16
      Width = 227
      Height = 23
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      DataField = 'Account'
      DataSource = DSMaster
      LookupTable = cboAccountQry
      LookupField = 'AccountName'
      ParentFont = False
      TabOrder = 25
      Visible = False
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboAccountCloseUp
    end
    inherited btnNext: TDNMSpeedButton [27]
      Left = 748
      Caption = '&New'
      TabOrder = 9
      ExplicitLeft = 748
    end
    inherited btnCompleted: TDNMSpeedButton [28]
      Left = 748
      Top = 40
      Height = 25
      Caption = '&Save'
      TabOrder = 24
      ExplicitLeft = 748
      ExplicitTop = 40
      ExplicitHeight = 25
    end
    inherited btnClose: TDNMSpeedButton [29]
      Left = 748
      TabOrder = 13
      ExplicitLeft = 748
    end
    inherited btnPreview: TDNMSpeedButton [30]
      Left = 749
      TabOrder = 15
      ExplicitLeft = 749
    end
    inherited btnPrint: TDNMSpeedButton [31]
      Left = 748
      Caption = 'Prin&t'
      TabOrder = 23
      ExplicitLeft = 748
    end
    inherited pnlChooseRpt: TDNMPanel [32]
      Top = 69
      TabOrder = 20
      ExplicitTop = 69
    end
    inherited btnContacts: TDNMSpeedButton [33]
      Left = 248
      TabOrder = 1
      ExplicitLeft = 248
    end
    inherited cboBaseForeignCurrencyCode: TwwDBLookupCombo [34]
      TabOrder = 11
    end
    inherited edtBaseExchangeRate: TwwDBEdit [35]
      TabOrder = 12
    end
    inherited pnlTitle: TDNMPanel [36]
      Width = 192
      Locked = True
      TabOrder = 19
      ExplicitWidth = 192
      inherited TitleShader: TShader
        Width = 190
        ExplicitWidth = 190
        inherited TitleLabel: TLabel
          Width = 190
          ExplicitWidth = 190
        end
      end
    end
    inherited cboClientR: TERPDbLookupCombo [37]
      DataField = 'SupplierName'
      AutoSelect = True
      UseTFields = False
      OnEnter = cboClientREnter
      LookupFormClassName = 'TSupplierExpressListGUI'
      EditFormClassName = 'TfmSupplier'
      LookupFormKeyStringFieldName = 'SupplierName'
      LookupComboType = ctSupplier
      LookupIDField = 'ClientID'
      LookupFieldAlt = 'PrintName'
    end
    object cmdFax: TDNMSpeedButton [38]
      Left = 793
      Top = 201
      Width = 44
      Height = 27
      Anchors = [akTop, akRight]
      Caption = '&Fax'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 16
      AutoDisableParentOnclick = True
    end
    object cboAreaCode: TwwDBLookupCombo [39]
      Left = 348
      Top = 144
      Width = 88
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AreaCode'#9'10'#9'Code'#9'F'
        'AreaName'#9'20'#9'Name'#9'F')
      DataField = 'Area'
      LookupTable = QryAreaCodes
      LookupField = 'AreaCode'
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 21
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    inherited btnPayments: TDNMSpeedButton [40]
      Left = 491
      TabOrder = 14
      ExplicitLeft = 491
    end
    inherited cmdEmail: TDNMSpeedButton [41]
      Left = 748
      Top = 201
      TabOrder = 22
      Visible = True
      ExplicitLeft = 748
      ExplicitTop = 201
    end
    inherited btnPDF: TDNMSpeedButton [42]
      Left = 748
      Top = 168
      Width = 87
      ExplicitLeft = 748
      ExplicitTop = 168
      ExplicitWidth = 87
    end
    inherited btnEdit: TDNMSpeedButton [43]
      Left = 698
      Top = 171
      ExplicitLeft = 698
      ExplicitTop = 171
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 45
    Top = 335
  end
  inherited tmrdelay: TTimer
    Left = 151
    Top = 335
  end
  object cboViaQry: TERPQuery [10]
    SQL.Strings = (
      'SELECT ShippingMethodID, ShippingMethod'
      'FROM tblShippingMethods where Active = "T"')
    Left = 207
    Top = 376
    object cboViaQryShippingMethodID: TAutoIncField
      FieldName = 'ShippingMethodID'
      ReadOnly = True
    end
    object cboViaQryShippingMethod: TWideStringField
      FieldName = 'ShippingMethod'
      FixedChar = True
      Size = 15
    end
  end
  inherited popSpelling: TPopupMenu
    Left = 186
    Top = 335
  end
  inherited tmrdelayMsg: TTimer
    Left = 80
    Top = 335
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 222
    Top = 335
  end
  inherited DSDetails: TDataSource
    Left = 38
    Top = 407
  end
  inherited DSMaster: TDataSource
    Left = 9
    Top = 407
  end
  inherited lsTDNMSpeedButtonActions: TActionList
    Left = 363
    Top = 335
  end
  inherited popDscntMrkup: TAdvPopupMenu
    Left = 610
    Top = 335
  end
  inherited popMemTrans: TAdvPopupMenu
    Left = 469
    Top = 335
  end
  inherited tblMaster: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblpurchaseorders'
      'Where PurchaseOrderID = :ID;')
    OnCalcFields = tblMasterCalcFields
    Left = 9
    Top = 376
    object tblMasterPurchaseOrderID: TAutoIncField
      FieldName = 'PurchaseOrderID'
      ReadOnly = True
    end
    object tblMasterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object tblMasterPurchaseOrderNumber: TWideStringField
      FieldName = 'PurchaseOrderNumber'
      Size = 30
    end
    object tblMasterOriginalNo: TWideStringField
      FieldName = 'OriginalNo'
      Size = 50
    end
    object tblMasterAccount: TWideStringField
      FieldName = 'Account'
      Size = 255
    end
    object tblMasterSupplierName: TWideStringField
      FieldName = 'SupplierName'
      Size = 255
    end
    object tblMasterOrderTo: TWideStringField
      FieldName = 'OrderTo'
      Size = 255
    end
    object tblMasterClientPrintName: TWideStringField
      FieldName = 'ClientPrintName'
      Size = 255
    end
    object tblMasterShipTo: TWideStringField
      FieldName = 'ShipTo'
      Size = 255
    end
    object tblMasterTotalTax: TFloatField
      FieldName = 'TotalTax'
      DisplayFormat = '$#0.00###'
      EditFormat = '$#0.00###'
      currency = True
    end
    object tblMasterTotalAmount: TFloatField
      FieldName = 'TotalAmount'
      currency = True
    end
    object tblMasterTotalAmountInc: TFloatField
      FieldName = 'TotalAmountInc'
      currency = True
    end
    object tblMasterEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 255
    end
    object tblMasterInvoiceNumber: TWideStringField
      FieldName = 'InvoiceNumber'
      Size = 30
    end
    object tblMasterETADate: TDateField
      FieldName = 'ETADate'
    end
    object tblMasterDueDate: TDateField
      FieldName = 'DueDate'
    end
    object tblMasterComments: TWideStringField
      FieldName = 'Comments'
      Size = 255
    end
    object tblMasterSalesComments: TWideStringField
      FieldName = 'SalesComments'
      Size = 255
    end
    object tblMasterShipping: TWideStringField
      FieldName = 'Shipping'
      Size = 255
    end
    object tblMasterTerms: TWideStringField
      FieldName = 'Terms'
      Size = 255
    end
    object tblMasterPrintFlag: TWideStringField
      FieldName = 'PrintFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterPaid: TWideStringField
      FieldName = 'Paid'
      FixedChar = True
      Size = 1
    end
    object tblMasterBalance: TFloatField
      FieldName = 'Balance'
    end
    object tblMasterPayment: TFloatField
      FieldName = 'Payment'
    end
    object tblMasterApplyFlag: TWideStringField
      FieldName = 'ApplyFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterAmountDue: TFloatField
      FieldName = 'AmountDue'
    end
    object tblMasterPayMethod: TIntegerField
      FieldName = 'PayMethod'
    end
    object tblMasterIsPO: TWideStringField
      FieldName = 'IsPO'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsRA: TWideStringField
      FieldName = 'IsRA'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsBill: TWideStringField
      FieldName = 'IsBill'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsCredit: TWideStringField
      FieldName = 'IsCredit'
      FixedChar = True
      Size = 1
    end
    object tblMasterDeleted: TWideStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
    object tblMasterCancelled: TWideStringField
      FieldName = 'Cancelled'
      FixedChar = True
      Size = 1
    end
    object tblMasterEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterBOID: TWideStringField
      FieldName = 'BOID'
      Size = 255
    end
    object tblMasterAccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object tblMasterClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object tblMasterEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object tblMasterRefNo: TWideStringField
      FieldName = 'RefNo'
      Size = 50
    end
    object tblMasterIsPOCredit: TWideStringField
      FieldName = 'IsPOCredit'
      FixedChar = True
      Size = 1
    end
    object tblMasterEnteredBy: TWideStringField
      FieldName = 'EnteredBy'
      Size = 255
    end
    object tblMasterPrintedBy: TWideStringField
      FieldName = 'PrintedBy'
      Size = 255
    end
    object tblMasterEnteredAt: TWideStringField
      FieldName = 'EnteredAt'
      Size = 255
    end
    object tblMasterIsCheque: TWideStringField
      FieldName = 'IsCheque'
      FixedChar = True
      Size = 1
    end
    object tblMasterInvoiceDate: TDateField
      FieldName = 'InvoiceDate'
      OnChange = tblMasterInvoiceDateChange
    end
    object tblMasterConNote: TWideStringField
      FieldName = 'ConNote'
      Size = 25
    end
    object tblMasterCustPONumber: TWideStringField
      FieldName = 'CustPONumber'
      Size = 30
    end
    object tblMasterLastUpdated: TDateTimeField
      FieldName = 'LastUpdated'
    end
    object tblMasterBaseNo: TWideStringField
      FieldName = 'BaseNo'
      Size = 255
    end
    object tblMasterOrderDate: TDateTimeField
      FieldName = 'OrderDate'
    end
    object tblMasterContactID: TLargeintField
      FieldName = 'ContactID'
    end
    object tblMasterContactName: TWideStringField
      FieldName = 'ContactName'
      Size = 100
    end
    object tblMasterArea: TWideStringField
      FieldName = 'Area'
      Size = 50
    end
    object tblMasterEnteredAtShort: TStringField
      FieldKind = fkCalculated
      FieldName = 'EnteredAtShort'
      Size = 255
      Calculated = True
    end
    object tblMasterOrderStatus: TWideStringField
      FieldName = 'OrderStatus'
      Size = 100
    end
  end
  inherited tblDetails: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblpurchaselines'
      'Where PurchaseOrderID = :ID;')
    Left = 75
    Top = 376
    object tblDetailsProductName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 17
      FieldName = 'ProductName'
      OnChange = tblDetailsProductNameChange
      Size = 50
    end
    object tblDetailsProduct_custFld1: TWideStringField
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'Product_custFld1'
      Calculated = True
    end
    object tblDetailsProduct_custFld2: TWideStringField
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'Product_custFld2'
      Calculated = True
    end
    object tblDetailsProduct_custFld3: TWideStringField
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'Product_custFld3'
      Calculated = True
    end
    object tblDetailsProduct_custFld4: TWideStringField
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'Product_custFld4'
      Calculated = True
    end
    object tblDetailsProduct_custFld5: TWideStringField
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'Product_custFld5'
      Calculated = True
    end
    object tblDetailsProduct_custFld6: TWideStringField
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'Product_custFld6'
      Calculated = True
    end
    object tblDetailsProduct_custFld7: TWideStringField
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'Product_custFld7'
      Calculated = True
    end
    object tblDetailsProduct_custFld8: TWideStringField
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'Product_custFld8'
      Calculated = True
    end
    object tblDetailsProduct_custFld9: TWideStringField
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'Product_custFld9'
      Calculated = True
    end
    object tblDetailsProduct_custFld10: TWideStringField
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'Product_custFld10'
      Calculated = True
    end
    object tblDetailsProduct_custFld11: TWideStringField
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'Product_custFld11'
      Calculated = True
    end
    object tblDetailsProduct_custFld12: TWideStringField
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'Product_custFld12'
      Calculated = True
    end
    object tblDetailsProduct_custFld13: TWideStringField
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'Product_custFld13'
      Calculated = True
    end
    object tblDetailsProduct_custFld14: TWideStringField
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'Product_custFld14'
      Calculated = True
    end
    object tblDetailsProduct_custFld15: TWideStringField
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'Product_custFld15'
      Calculated = True
    end
    object tblDetailsProduct_custDate1: TDateTimeField
      DisplayWidth = 18
      FieldKind = fkCalculated
      FieldName = 'Product_custDate1'
      Calculated = True
    end
    object tblDetailsProduct_custDate2: TDateTimeField
      DisplayWidth = 18
      FieldKind = fkCalculated
      FieldName = 'Product_custDate2'
      Calculated = True
    end
    object tblDetailsProduct_custDate3: TDateTimeField
      DisplayWidth = 18
      FieldKind = fkCalculated
      FieldName = 'Product_custDate3'
      Calculated = True
    end
    object tblDetailsClass: TWideStringField
      DisplayWidth = 20
      FieldName = 'Class'
      Size = 255
    end
    object tblDetailsUnitofMeasurePOLines: TWideStringField
      DisplayLabel = 'Units'
      DisplayWidth = 20
      FieldName = 'UnitofMeasurePOLines'
      OnChange = tblDetailsUnitofMeasurePOLinesChange
      Size = 255
    end
    object tblDetailsUnitofMeasureQtySold: TFloatField
      DisplayLabel = 'Ordered'
      DisplayWidth = 10
      FieldName = 'UnitofMeasureQtySold'
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblDetailsUnitofMeasureShipped: TFloatField
      DisplayLabel = 'Received'
      DisplayWidth = 10
      FieldName = 'UnitofMeasureShipped'
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblDetailsPQA: TWideStringField
      DisplayLabel = 'Allocation'
      DisplayWidth = 1
      FieldKind = fkCalculated
      FieldName = 'PQA'
      Size = 1
      Calculated = True
    end
    object tblDetailsUnitofMeasureBackorder: TFloatField
      DisplayLabel = 'BO'
      DisplayWidth = 10
      FieldName = 'UnitofMeasureBackorder'
      LookupDataSet = cboAccountQry
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '#,###,###,##0.#####'
    end
    object tblDetailsAttrib1Purchase: TFloatField
      DisplayLabel = 'Metres'
      DisplayWidth = 16
      FieldName = 'Attrib1Purchase'
      DisplayFormat = '####0.00'
    end
    object tblDetailsAttrib2Purchase: TFloatField
      DisplayLabel = 'Weight'
      DisplayWidth = 16
      FieldName = 'Attrib2Purchase'
    end
    object tblDetailsAttrib1PurchaseRate: TFloatField
      DisplayLabel = 'Metres'
      DisplayWidth = 16
      FieldName = 'Attrib1PurchaseRate'
      currency = True
    end
    object tblDetailsLineCost: TFloatField
      DisplayLabel = 'Cost (Ex)'
      DisplayWidth = 10
      FieldName = 'LineCost'
      OnChange = tblDetailsLineCostChange
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '$0.00##'
      currency = True
    end
    object tblDetailsForeignCurrencyLineCost: TFloatField
      DisplayLabel = 'Foreign Cost'
      DisplayWidth = 10
      FieldName = 'ForeignCurrencyLineCost'
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblDetailsLineTaxCode: TWideStringField
      DisplayLabel = 'Code'
      DisplayWidth = 15
      FieldName = 'LineTaxCode'
      OnChange = tblDetailsLineTaxCodeChange
      Size = 15
    end
    object tblDetailsLineTax: TFloatField
      DisplayLabel = 'Tax (Dbl Click)'
      DisplayWidth = 10
      FieldName = 'LineTax'
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '$#0.00###'
      EditFormat = '$#0.00###'
      currency = True
    end
    object tblDetailsTotalLineAmountInc: TFloatField
      DisplayLabel = 'Amount (Inc)'
      DisplayWidth = 10
      FieldName = 'TotalLineAmountInc'
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object tblDetailsETADate: TDateField
      DisplayLabel = 'ETA Date'
      DisplayWidth = 10
      FieldName = 'ETADate'
    end
    object tblDetailsCustomField1: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField1'
      Size = 255
    end
    object tblDetailsCustomField2: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField2'
      Size = 255
    end
    object tblDetailsCustomField3: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField3'
      Size = 255
    end
    object tblDetailsCustomField4: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField4'
      Size = 255
    end
    object tblDetailsCustomField5: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField5'
      Size = 255
    end
    object tblDetailsCustomField6: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField6'
      Size = 255
    end
    object tblDetailsCustomField7: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField7'
      Size = 255
    end
    object tblDetailsCustomField8: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField8'
      Size = 255
    end
    object tblDetailsCustomField9: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField9'
      Size = 255
    end
    object tblDetailsCustomField10: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField10'
      Size = 255
    end
    object tblDetailsAccountNumber: TWideStringField
      DisplayLabel = 'Account Number'
      DisplayWidth = 50
      FieldName = 'AccountNumber'
      Size = 50
    end
    object tblDetailsSpecDescription: TWideStringField
      DisplayLabel = 'Specifications'
      DisplayWidth = 20
      FieldName = 'SpecDescription'
      Size = 255
    end
    object tblDetailsSpecValue: TFloatField
      DisplayLabel = 'Spec Qty'
      DisplayWidth = 10
      FieldName = 'SpecValue'
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblDetailsUnitOfMeasureID: TIntegerField
      DisplayWidth = 10
      FieldName = 'UnitOfMeasureID'
    end
    object tblDetailsSortID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SortID'
    end
    object tblDetailsLinesOrder: TIntegerField
      DisplayLabel = 'Order by'
      DisplayWidth = 10
      FieldName = 'LinesOrder'
    end
    object tblDetailsMemoLine: TWideMemoField
      DisplayLabel = 'Memo Line'
      DisplayWidth = 10
      FieldName = 'MemoLine'
      BlobType = ftWideMemo
    end
    object tblDetailsReceivedDate: TDateTimeField
      DisplayLabel = 'Receive On'
      DisplayWidth = 18
      FieldName = 'ReceivedDate'
    end
    object tblDetailsEquipmentName: TWideStringField
      DisplayLabel = 'Equipment Name'
      DisplayWidth = 100
      FieldName = 'EquipmentName'
      Size = 100
    end
    object tblDetailsLandedCostsPercentage: TFloatField
      DisplayLabel = 'Landed Cost %'
      DisplayWidth = 10
      FieldName = 'LandedCostsPercentage'
      OnChange = tblDetailsLandedCostsPercentageChange
      DisplayFormat = '#0.0%'
    end
    object tblDetailsLandedCostsPerItem: TFloatField
      DisplayLabel = 'Landed Cost/Item'
      DisplayWidth = 10
      FieldName = 'LandedCostsPerItem'
      OnChange = tblDetailsLandedCostsPerItemChange
    end
    object tblDetailsTotalLineLandedCost: TFloatField
      DisplayLabel = 'Landed Cost'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TotalLineLandedCost'
      currency = True
      Calculated = True
    end
    object tblDetailsSupplierProductCode: TWideStringField
      DisplayLabel = 'Supp Product Code'
      DisplayWidth = 20
      FieldName = 'SupplierProductCode'
      Size = 50
    end
    object tblDetailsSupplierProductName: TWideStringField
      DisplayLabel = 'Supp Product Name'
      DisplayWidth = 20
      FieldName = 'SupplierProductName'
      Size = 50
    end
    object tblDetailsPartBarcode: TWideStringField
      DisplayLabel = 'Barcode'
      DisplayWidth = 20
      FieldName = 'PartBarcode'
      Size = 255
    end
    object tblDetailsUOM_Height: TFloatField
      DisplayLabel = 'Height'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'UOM_Height'
      Calculated = True
    end
    object tblDetailsUOM_Width: TFloatField
      DisplayLabel = 'Width'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'UOM_Width'
      Calculated = True
    end
    object tblDetailsUOM_Length: TFloatField
      DisplayLabel = 'Length'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'UOM_Length'
      Calculated = True
    end
    object tblDetailsUOM_Weight: TFloatField
      DisplayLabel = 'Weight'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'UOM_Weight'
      Calculated = True
    end
    object tblDetailsTotalUOM_WeightSold: TFloatField
      DisplayLabel = 'Total Sold Weight'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TotalUOM_WeightSold'
      Calculated = True
    end
    object tblDetailsTotalUOM_WeightShipped: TFloatField
      DisplayLabel = 'Total Shipped Weight'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TotalUOM_WeightShipped'
      Calculated = True
    end
    object tblDetailsTotalUOM_WeightBO: TFloatField
      DisplayLabel = 'Total BO Weight'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TotalUOM_WeightBO'
      Calculated = True
    end
    object tblDetailsTotalUOM_LengthSold: TFloatField
      DisplayLabel = 'Total Sold Length'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TotalUOM_LengthSold'
      Calculated = True
    end
    object tblDetailsTotalUOM_LengthShipped: TFloatField
      DisplayLabel = 'Total Shipped Length'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TotalUOM_LengthShipped'
      Calculated = True
    end
    object tblDetailsTotalUOM_LengthBO: TFloatField
      DisplayLabel = 'Total BO Length'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TotalUOM_LengthBO'
      Calculated = True
    end
    object tblDetailsUOM_Volume: TFloatField
      DisplayLabel = 'Volume'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'UOM_Volume'
      Calculated = True
    end
    object tblDetailsRepairDocNo: TStringField
      DisplayLabel = 'Repair #'
      DisplayWidth = 12
      FieldKind = fkLookup
      FieldName = 'RepairDocNo'
      LookupDataSet = qryRepairLookup
      LookupKeyFields = 'RepairID'
      LookupResultField = 'RepairDocNo'
      KeyFields = 'RepairId'
      Size = 255
      Lookup = True
    end
    object tblDetailsFormulaQtySoldValue1: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue1'
    end
    object tblDetailsFormulaQtySoldValue2: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue2'
    end
    object tblDetailsFormulaQtySoldValue3: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue3'
    end
    object tblDetailsFormulaQtySoldValue4: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue4'
    end
    object tblDetailsFormulaQtySoldValue5: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue5'
    end
    object tblDetailsFormulaQtyShippedValue1: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue1'
    end
    object tblDetailsFormulaQtyShippedValue2: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue2'
    end
    object tblDetailsFormulaQtyShippedValue3: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue3'
    end
    object tblDetailsFormulaQtyShippedValue4: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue4'
    end
    object tblDetailsFormulaQtyShippedValue5: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue5'
    end
    object tblDetailsFormulaQtySoldValue: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue'
    end
    object tblDetailsFormulaQtyShippedValue: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue'
    end
    object tblDetailsAttrib1PurchaseEst: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib1PurchaseEst'
      DisplayFormat = '####0.00'
    end
    object tblDetailsAttrib2PurchaseEst: TFloatField
      DisplayLabel = 'Metres'
      DisplayWidth = 10
      FieldName = 'Attrib2PurchaseEst'
    end
    object tblDetailsEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
    end
    object tblDetailsEmployeeName: TWideStringField
      DisplayWidth = 100
      FieldName = 'EmployeeName'
      Size = 100
    end
    object tblDetailsAreaCode: TWideStringField
      DisplayLabel = 'Area'
      DisplayWidth = 10
      FieldName = 'AreaCode'
      Size = 50
    end
    object tblDetailsForeignUOMLineCost: TFloatField
      DisplayLabel = 'Foreign UOM Cost'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'ForeignUOMLineCost'
      Calculated = True
    end
    object tblDetailsProductPrintName: TWideStringField
      DisplayWidth = 20
      FieldName = 'ProductPrintName'
      Size = 255
    end
    object tblDetailsRepairId: TIntegerField
      DisplayLabel = 'RepairID'
      DisplayWidth = 10
      FieldName = 'RepairId'
      Visible = False
    end
    object tblDetailsProduct_Description: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 20
      FieldName = 'Product_Description'
      Visible = False
      Size = 255
    end
    object tblDetailsLineCostInc: TFloatField
      DisplayLabel = 'Cost (Inc)'
      DisplayWidth = 10
      FieldName = 'LineCostInc'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object tblDetailsForeignExchangeCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'ForeignExchangeCode'
      Visible = False
      FixedChar = True
      Size = 3
    end
    object tblDetailsCustomerJob: TWideStringField
      DisplayLabel = 'Customer / Job'
      DisplayWidth = 20
      FieldName = 'CustomerJob'
      Visible = False
      Size = 255
    end
    object tblDetailsQtySold: TFloatField
      DisplayLabel = 'Ordered'
      DisplayWidth = 10
      FieldName = 'QtySold'
      Visible = False
      OnChange = tblDetailsQtySoldChange
    end
    object tblDetailsShipped: TFloatField
      DisplayLabel = 'Received'
      DisplayWidth = 10
      FieldName = 'Shipped'
      Visible = False
      OnChange = tblDetailsShippedChange
    end
    object tblDetailsBackOrder: TFloatField
      DisplayLabel = 'BO'
      DisplayWidth = 10
      FieldName = 'BackOrder'
      Visible = False
    end
    object tblDetailsPurchaseLineID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'PurchaseLineID'
      ReadOnly = True
      Visible = False
    end
    object tblDetailsGlobalRef: TWideStringField
      DisplayWidth = 20
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object tblDetailsPurchaseOrderID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PurchaseOrderID'
      Visible = False
    end
    object tblDetailsProductGroup: TWideStringField
      DisplayWidth = 20
      FieldName = 'ProductGroup'
      Visible = False
      Size = 255
    end
    object tblDetailsLineTaxRate: TFloatField
      DisplayWidth = 10
      FieldName = 'LineTaxRate'
      Visible = False
    end
    object tblDetailsInvoiced: TWideStringField
      DisplayWidth = 1
      FieldName = 'Invoiced'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsRAQty: TFloatField
      DisplayWidth = 10
      FieldName = 'RAQty'
      Visible = False
    end
    object tblDetailsRAstatus: TWideStringField
      DisplayWidth = 15
      FieldName = 'RAstatus'
      Visible = False
      Size = 15
    end
    object tblDetailsBatch: TWideStringField
      DisplayWidth = 9
      FieldName = 'Batch'
      Visible = False
      Size = 9
    end
    object tblDetailsUseTimecost: TWideStringField
      DisplayWidth = 1
      FieldName = 'UseTimecost'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsSaleID_Timecost: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleID_Timecost'
      Visible = False
    end
    object tblDetailsTimecostMarkupPer: TFloatField
      DisplayWidth = 10
      FieldName = 'TimecostMarkupPer'
      Visible = False
      currency = True
    end
    object tblDetailsTimecostPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'TimecostPrice'
      Visible = False
      currency = True
    end
    object tblDetailsTimecostMarkupDol: TFloatField
      DisplayWidth = 10
      FieldName = 'TimecostMarkupDol'
      Visible = False
      currency = True
    end
    object tblDetailsForeignExchangeRate: TFloatField
      DisplayWidth = 10
      FieldName = 'ForeignExchangeRate'
      Visible = False
    end
    object tblDetailsTotalLineAmount: TFloatField
      DisplayLabel = 'Amount (Inc)'
      DisplayWidth = 10
      FieldName = 'TotalLineAmount'
      Visible = False
      DisplayFormat = '$0.00##'
      currency = True
    end
    object tblDetailsEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsDeleted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsRAInvoiceNo: TWideStringField
      DisplayWidth = 11
      FieldName = 'RAInvoiceNo'
      Visible = False
      Size = 11
    end
    object tblDetailsAccountName: TWideStringField
      DisplayWidth = 50
      FieldName = 'AccountName'
      Visible = False
      Size = 50
    end
    object tblDetailsAccountGroup: TWideStringField
      DisplayWidth = 20
      FieldName = 'AccountGroup'
      Visible = False
      Size = 255
    end
    object tblDetailsProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Visible = False
    end
    object tblDetailsClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
      Visible = False
    end
    object tblDetailsPartType: TWideStringField
      DisplayWidth = 13
      FieldName = 'PartType'
      Visible = False
      Size = 13
    end
    object tblDetailsIncomeAccnt: TWideStringField
      DisplayWidth = 50
      FieldName = 'IncomeAccnt'
      Visible = False
      Size = 50
    end
    object tblDetailsAssetAccnt: TWideStringField
      DisplayWidth = 50
      FieldName = 'AssetAccnt'
      Visible = False
      Size = 50
    end
    object tblDetailsCogsAccnt: TWideStringField
      DisplayWidth = 50
      FieldName = 'CogsAccnt'
      Visible = False
      Size = 50
    end
    object tblDetailsCalcCostInc: TCurrencyField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'CalcCostInc'
      Visible = False
      DisplayFormat = '$#0.00#'
      EditFormat = '$#0.00#'
      Calculated = True
    end
    object tblDetailsCalcTotalInc: TCurrencyField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'CalcTotalInc'
      Visible = False
      DisplayFormat = '$#0.00#'
      EditFormat = '$#0.00#'
      Calculated = True
    end
    object tblDetailsCalcTotalEx: TCurrencyField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'CalcTotalEx'
      Visible = False
      DisplayFormat = '$#0.00#'
      EditFormat = '$#0.00#'
      Calculated = True
    end
    object tblDetailsCalcTax: TCurrencyField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'CalcTax'
      Visible = False
      DisplayFormat = '$#0.00#'
      EditFormat = '$#0.00#'
      Calculated = True
    end
    object tblDetailsCalcBackOrder: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'CalcBackOrder'
      Visible = False
      Calculated = True
    end
    object tblDetailsCOGSTotalLineAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'COGSTotalLineAmount'
      Visible = False
      DisplayFormat = '$#0.00#'
      EditFormat = '$#0.00#'
    end
    object tblDetailsAvgCost: TFloatField
      DisplayWidth = 10
      FieldName = 'AvgCost'
      Visible = False
    end
    object tblDetailsCustomerJobID: TIntegerField
      DisplayWidth = 10
      FieldName = 'CustomerJobID'
      Visible = False
    end
    object tblDetailsCOGSTotalLineAmountInc: TFloatField
      DisplayWidth = 10
      FieldName = 'COGSTotalLineAmountInc'
      Visible = False
      DisplayFormat = '$#0.00#'
      EditFormat = '$#0.00#'
    end
    object tblDetailsLastLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'LastLineID'
      Visible = False
    end
    object tblDetailsRelatedPOID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RelatedPOID'
      Visible = False
    end
    object tblDetailsRelatedPOIDUsed: TWideStringField
      DisplayWidth = 1
      FieldName = 'RelatedPOIDUsed'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsUnitofMeasureMultiplier: TFloatField
      DisplayWidth = 10
      FieldName = 'UnitofMeasureMultiplier'
      Visible = False
    end
    object tblDetailsSearchFilter: TWideStringField
      DisplayWidth = 20
      FieldName = 'SearchFilter'
      Visible = False
      Size = 64
    end
    object tblDetailsSearchFilterCopy: TWideStringField
      DisplayWidth = 20
      FieldName = 'SearchFilterCopy'
      Visible = False
      Size = 64
    end
    object tblDetailsLandedCostsTotal: TFloatField
      DisplayWidth = 10
      FieldName = 'LandedCostsTotal'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblDetailsPartSpecID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PartSpecID'
      Visible = False
    end
    object tblDetailsserialno: TWideMemoField
      DisplayWidth = 10
      FieldName = 'serialno'
      Visible = False
      BlobType = ftWideMemo
    end
    object tblDetailsCustomerEquipmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'CustomerEquipmentID'
      Visible = False
    end
    object tblDetailsMatrixDesc: TWideMemoField
      FieldName = 'MatrixDesc'
      Visible = False
      BlobType = ftWideMemo
    end
    object tblDetailsMatrixRef: TWideMemoField
      FieldName = 'MatrixRef'
      Visible = False
      BlobType = ftWideMemo
    end
    object tblDetailsMatrixPrice: TFloatField
      FieldName = 'MatrixPrice'
      Visible = False
    end
    object tblDetailsSupplierBarCode: TWideStringField
      FieldName = 'SupplierBarCode'
      Size = 50
    end
  end
  inherited cboClientLookup: TERPQuery
    SQL.Strings = (
      'SELECT ClientID, Company, '
      'Street, Street2, Street3, Suburb, State, Country, Postcode,'
      
        'BillStreet, BillStreet2, BillStreet3, BillSuburb, BillState, Bil' +
        'lPostcode,BillCountry,'
      'TERMS, TermsID, ShippingMethod, ShippingID, ShipTime, RepID'
      'FROM tblclients'
      'WHERE Supplier = '#39'T'#39
      'AND tblclients.ClientID= :xClientID')
    Left = 108
    Top = 376
  end
  inherited cboEmployeeLookup: TERPQuery
    Left = 141
    Top = 376
  end
  inherited cboClassQry: TERPQuery
    Left = 174
    Top = 376
  end
  inherited qryBaseForeignCurrency: TERPQuery
    Left = 603
    Top = 376
  end
  inherited qryClientLookup: TERPQuery
    SQL.Strings = (
      'Select Company, ClientId FROM tblclients C1'
      'WHERE C1.Active = "T"'
      'AND C1.Supplier = "T"'
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (Company LIKE Concat(:SearchValue,"%")' +
        '))'
      
        'or ((:SearchMode = 2) and (Company LIKE Concat("%",:SearchValue,' +
        '"%"))))'
      'and IfNull(:SearchValue,"") <> ""')
    Left = 372
    Top = 376
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
  object cboTermsQry: TERPQuery [26]
    SQL.Strings = (
      
        'SELECT tblTerms.TermsID, tblTerms.Terms, tblTerms.TermsAmount, t' +
        'blTerms.EOM, tblTerms.EOMPlus, tblTerms.Active '
      'FROM tblTerms '
      'WHERE (((tblTerms.Active)<>'#39'F'#39')) '
      'ORDER BY tblTerms.Terms; ')
    Left = 339
    Top = 376
  end
  object qryForeignCurrency: TERPQuery [27]
    SQL.Strings = (
      'SELECT CurrencyID, Country, Currency, Code, BuyRate, Active  '
      'FROM tblcurrencyconversion'
      'Where BuyRate<>0;')
    Left = 471
    Top = 376
  end
  object qryUnitOfMeasure: TERPQuery [28]
    Connection = MyConnection
    SQL.Strings = (
      '/*SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND (ifnull(U.PartID,0) = :xPartID or U.Pa' +
        'rtID = 0) '
      'Group By U.UnitName Desc'
      'Order By UnitID desc ,U.UnitName'
      '*/'
      'SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = :xPartID'
      'union all '
      'SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = 0 and Unitname no' +
        't  in (Select unitname from  tblunitsofmeasure where  ifnull(Par' +
        'tID,0) = :xPartID  )'
      'Order By UnitID desc ,UnitName;')
    BeforeOpen = qryUnitOfMeasureBeforeOpen
    Left = 504
    Top = 376
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPartID'
      end
      item
        DataType = ftUnknown
        Name = 'xPartID'
      end>
    object qryUnitOfMeasureUnitID: TIntegerField
      FieldName = 'UnitID'
    end
    object qryUnitOfMeasureUnitName: TWideStringField
      FieldName = 'UnitName'
      Size = 15
    end
    object qryUnitOfMeasureUnitDescription: TWideStringField
      FieldName = 'UnitDescription'
      Size = 35
    end
    object qryUnitOfMeasureMultiplier: TFloatField
      FieldName = 'Multiplier'
    end
  end
  object cboAccountQry: TERPQuery [29]
    SQL.Strings = (
      
        'SELECT AccountID, AccountName, AccountType, Description, Account' +
        'Number, Taxcode, BankNumber, Extra, Active, EditedFlag, Class, A' +
        'llClasses, OpeningBalance, Debits, Credits, ClosingBalance, Acco' +
        'untGroup  '
      'FROM tblchartofaccounts'
      'WHERE AccountType = '#39'AP'#39' and Active='#39'T'#39';')
    Options.LongStrings = False
    Left = 240
    Top = 376
  end
  object cboProductQry: TERPQuery [30]
    Connection = MyConnection
    SQL.Strings = (
      
        '#DUMMY QUERY - Order.Formcreate dynamically changes the query fo' +
        'r seach options '
      'SELECT '
      'Left(SUBSTRING_INDEX(P.ProductGroup,'#39'^'#39',1),255) AS Manuf  , '
      
        'Left(substring(substring_index(P.ProductGroup,'#39'^'#39',2),char_length' +
        '(substring_index(P.ProductGroup,'#39'^'#39',1))+2),255) AS Type  ,'
      
        'Left(substring(substring_index(P.ProductGroup,'#39'^'#39',3),char_length' +
        '(substring_index(P.ProductGroup,'#39'^'#39',2))+2),255) AS Dept  ,'
      'P.PARTSID as PARTSID,'
      'P.PARTTYPE as PARTTYPE,'
      'P.PRODUCTGROUP as PRODUCTGROUP,'
      'P.PARTNAME as PARTNAME,'
      'P.PARTSDESCRIPTION as PARTSDESCRIPTION,'
      'P.INCOMEACCNT as INCOMEACCNT,'
      'P.PurchaseDesc as PurchaseDesc,'
      'P.ASSETACCNT as ASSETACCNT,'
      'P.COGSACCNT as COGSACCNT,'
      'P.BARCODE as BARCODE,'
      'P.PRODUCTCODE as PRODUCTCODE,'
      'P.PURCHTAXCODE as PURCHTAXCODE,'
      'P.PREFEREDSUPP as PREFEREDSUPP,'
      'P.Batch as Batch,'
      'P.SpecialDiscount as SpecialDiscount,'
      'P.SNTracking as SNTracking,'
      'P.BuyQTY1 as BuyQTY1,'
      'P.BuyQTY2 as BuyQTY2,'
      'P.BuyQTY3 as BuyQTY3,'
      'P.COST1 as COST1,'
      'P.COST2 as COST2,'
      'P.COST3 as COST3,'
      'P.SellQTY1 as SellQTY1,'
      'P.SellQTY2 as SellQTY2,'
      'P.SellQTY3 as SellQTY3,'
      'P.PRICE1 as PRICE1,'
      'P.PRICE2 as PRICE2,'
      'P.PRICE3 as PRICE3,'
      'P.WHOLESALEPRICE as WHOLESALEPRICE,'
      'P.Active as Active,'
      'P.EditedFlag as EditedFlag,'
      'P.MultipleBins as MultipleBins,'
      'P.AvgCost as AvgCost,'
      'P.Discontinued as Discontinued,'
      'P.Attrib1Purchase as Attrib1Purchase,'
      'P.Attrib2Purchase as Attrib2Purchase,'
      'P.Attrib1PurchaseRate as Attrib1PurchaseRate,'
      
        'if (ifnull(LatestCost ,0) = 0 , cost1, LatestCost ) as LatestCos' +
        'tPrice ,'
      'P.taxcode as TaxCode,'
      'p.LatestCost as LatestCost,'
      'p.AutoBatch as AutoBatch, '
      'p.Attrib1Sale as Attrib1Sale,'
      'p.Attrib2Sale as Attrib2Sale,'
      'p.Attrib1SaleRate as Attrib1SaleRate,'
      'P.LatestCostDate as LatestCostDate,'
      'SupplierProductCode,'
      '`P`.`CUSTFLD1`,'
      '`P`.`CUSTFLD2`,'
      '`P`.`CUSTFLD3`,'
      '`P`.`CUSTFLD4`,'
      '`P`.`CUSTFLD5`,'
      '`P`.`CUSTFLD6`,'
      '`P`.`CUSTFLD7`,'
      '`P`.`CUSTFLD8`,'
      '`P`.`CUSTFLD9`,'
      '`P`.`CUSTFLD10`,'
      '`P`.`CUSTFLD11`,'
      '`P`.`CUSTFLD12`,'
      '`P`.`CUSTFLD13`,'
      '`P`.`CUSTFLD14`,'
      '`P`.`CUSTFLD15`,'
      '`P`.`CUSTDATE1`,'
      '`P`.`CUSTDATE2`,'
      '`P`.`CUSTDATE3`'
      'FROM `tblParts` P'
      'WHERE P.Active = "T"'
      ' AND ('
      '  ((:SearchMode = 0) or (IsNull(:SearchMode))) '
      
        'or ((:SearchMode = 1) and ((Partname  LIKE Concat(:SearchValue,"' +
        '%"))  or (PREFEREDSUPP  LIKE Concat(:SearchValue,"%"))   or (Pur' +
        'chaseDesc LIKE Concat(:SearchValue,"%"))   or (Left(SUBSTRING_IN' +
        'DEX(P.ProductGroup,'#39'^'#39',1),255) LIKE Concat(:SearchValue,"%"))   ' +
        'or (Left(substring(substring_index(P.ProductGroup,'#39'^'#39',2),char_le' +
        'ngth(substring_index(P.ProductGroup,'#39'^'#39',1))+2),255) LIKE Concat(' +
        ':SearchValue,"%"))   or (Left(substring(substring_index(P.Produc' +
        'tGroup,'#39'^'#39',3),char_length(substring_index(P.ProductGroup,'#39'^'#39',2))' +
        '+2),255) LIKE Concat(:SearchValue,"%"))  )) '
      
        'or ((:SearchMode = 2) and (Trim(:SearchValue) <> "") and ((Partn' +
        'ame  LIKE Concat("%",:SearchValue,"%"))   or (PREFEREDSUPP  LIKE' +
        ' Concat("%",:SearchValue,"%"))   or (PurchaseDesc LIKE Concat("%' +
        '",:SearchValue,"%"))  or (Left(SUBSTRING_INDEX(P.ProductGroup,'#39'^' +
        #39',1),255) LIKE Concat("%",:SearchValue,"%"))  or (Left(substring' +
        '(substring_index(P.ProductGroup,'#39'^'#39',2),char_length(substring_ind' +
        'ex(P.ProductGroup,'#39'^'#39',1))+2),255) LIKE Concat("%",:SearchValue,"' +
        '%"))  or (Left(substring(substring_index(P.ProductGroup,'#39'^'#39',3),c' +
        'har_length(substring_index(P.ProductGroup,'#39'^'#39',2))+2),255) LIKE C' +
        'oncat("%",:SearchValue,"%"))  )) '
      ')'
      'and IfNull(:SearchValue,"") <> ""')
    AfterOpen = cboProductQryAfterOpen
    Options.LongStrings = False
    Left = 570
    Top = 376
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
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
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
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
    object cboProductQryManuf: TWideStringField
      FieldName = 'Manuf'
      Size = 255
    end
    object cboProductQryType: TWideStringField
      FieldName = 'Type'
      Size = 255
    end
    object cboProductQryDept: TWideStringField
      FieldName = 'Dept'
      Size = 255
    end
    object cboProductQryPARTSID: TIntegerField
      FieldName = 'PARTSID'
    end
    object cboProductQryPARTTYPE: TWideStringField
      FieldName = 'PARTTYPE'
      Size = 13
    end
    object cboProductQryPRODUCTGROUP: TWideStringField
      FieldName = 'PRODUCTGROUP'
      Size = 255
    end
    object cboProductQryPARTNAME: TWideStringField
      FieldName = 'PARTNAME'
      Size = 60
    end
    object cboProductQryPARTSDESCRIPTION: TWideStringField
      FieldName = 'PARTSDESCRIPTION'
      Size = 255
    end
    object cboProductQryINCOMEACCNT: TWideStringField
      FieldName = 'INCOMEACCNT'
      Size = 50
    end
    object cboProductQryPurchaseDesc: TWideStringField
      FieldName = 'PurchaseDesc'
      Size = 255
    end
    object cboProductQryASSETACCNT: TWideStringField
      FieldName = 'ASSETACCNT'
      Size = 50
    end
    object cboProductQryCOGSACCNT: TWideStringField
      FieldName = 'COGSACCNT'
      Size = 50
    end
    object cboProductQryBARCODE: TWideStringField
      FieldName = 'BARCODE'
      Size = 35
    end
    object cboProductQryPRODUCTCODE: TWideStringField
      FieldName = 'PRODUCTCODE'
      Size = 255
    end
    object cboProductQryPURCHTAXCODE: TWideStringField
      FieldName = 'PURCHTAXCODE'
      Size = 11
    end
    object cboProductQryPREFEREDSUPP: TWideStringField
      FieldName = 'PREFEREDSUPP'
      Size = 55
    end
    object cboProductQryBatch: TWideStringField
      FieldName = 'Batch'
      FixedChar = True
      Size = 1
    end
    object cboProductQrySpecialDiscount: TWideStringField
      FieldName = 'SpecialDiscount'
      FixedChar = True
      Size = 1
    end
    object cboProductQrySNTracking: TWideStringField
      FieldName = 'SNTracking'
      FixedChar = True
      Size = 1
    end
    object cboProductQryBuyQTY1: TIntegerField
      FieldName = 'BuyQTY1'
    end
    object cboProductQryBuyQTY2: TIntegerField
      FieldName = 'BuyQTY2'
    end
    object cboProductQryBuyQTY3: TIntegerField
      FieldName = 'BuyQTY3'
    end
    object cboProductQryCOST1: TFloatField
      FieldName = 'COST1'
    end
    object cboProductQryCOST2: TFloatField
      FieldName = 'COST2'
    end
    object cboProductQryCOST3: TFloatField
      FieldName = 'COST3'
    end
    object cboProductQrySellQTY1: TIntegerField
      FieldName = 'SellQTY1'
    end
    object cboProductQrySellQTY2: TIntegerField
      FieldName = 'SellQTY2'
    end
    object cboProductQrySellQTY3: TIntegerField
      FieldName = 'SellQTY3'
    end
    object cboProductQryPRICE1: TFloatField
      FieldName = 'PRICE1'
    end
    object cboProductQryPRICE2: TFloatField
      FieldName = 'PRICE2'
    end
    object cboProductQryPRICE3: TFloatField
      FieldName = 'PRICE3'
    end
    object cboProductQryWHOLESALEPRICE: TFloatField
      FieldName = 'WHOLESALEPRICE'
    end
    object cboProductQryActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object cboProductQryEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object cboProductQryMultipleBins: TWideStringField
      FieldName = 'MultipleBins'
      FixedChar = True
      Size = 1
    end
    object cboProductQryAvgCost: TFloatField
      FieldName = 'AvgCost'
    end
    object cboProductQryDiscontinued: TWideStringField
      FieldName = 'Discontinued'
      FixedChar = True
      Size = 1
    end
    object cboProductQryAttrib1Purchase: TFloatField
      FieldName = 'Attrib1Purchase'
    end
    object cboProductQryAttrib2Purchase: TFloatField
      FieldName = 'Attrib2Purchase'
    end
    object cboProductQryAttrib1PurchaseRate: TFloatField
      FieldName = 'Attrib1PurchaseRate'
    end
    object cboProductQryLatestCostPrice: TFloatField
      FieldName = 'LatestCostPrice'
    end
    object cboProductQryTaxCode: TWideStringField
      FieldName = 'TaxCode'
      Size = 15
    end
    object cboProductQryLatestCost: TFloatField
      FieldName = 'LatestCost'
    end
    object cboProductQryAutoBatch: TWideStringField
      FieldName = 'AutoBatch'
      FixedChar = True
      Size = 1
    end
    object cboProductQryAttrib1Sale: TFloatField
      FieldName = 'Attrib1Sale'
    end
    object cboProductQryAttrib2Sale: TFloatField
      FieldName = 'Attrib2Sale'
    end
    object cboProductQryAttrib1SaleRate: TFloatField
      FieldName = 'Attrib1SaleRate'
    end
    object cboProductQryLatestCostDate: TDateField
      FieldName = 'LatestCostDate'
    end
    object cboProductQrySupplierProductCode: TWideStringField
      FieldName = 'SupplierProductCode'
      Size = 50
    end
    object cboProductQryCUSTFLD1: TWideStringField
      FieldName = 'CUSTFLD1'
      Size = 255
    end
    object cboProductQryCUSTFLD2: TWideStringField
      FieldName = 'CUSTFLD2'
      Size = 255
    end
    object cboProductQryCUSTFLD3: TWideStringField
      FieldName = 'CUSTFLD3'
      Size = 255
    end
    object cboProductQryCUSTFLD4: TWideStringField
      FieldName = 'CUSTFLD4'
      Size = 255
    end
    object cboProductQryCUSTFLD5: TWideStringField
      FieldName = 'CUSTFLD5'
      Size = 255
    end
    object cboProductQryCUSTFLD6: TWideStringField
      FieldName = 'CUSTFLD6'
      Size = 255
    end
    object cboProductQryCUSTFLD7: TWideStringField
      FieldName = 'CUSTFLD7'
      Size = 255
    end
    object cboProductQryCUSTFLD8: TWideStringField
      FieldName = 'CUSTFLD8'
      Size = 255
    end
    object cboProductQryCUSTFLD9: TWideStringField
      FieldName = 'CUSTFLD9'
      Size = 255
    end
    object cboProductQryCUSTFLD10: TWideStringField
      FieldName = 'CUSTFLD10'
      Size = 255
    end
    object cboProductQryCUSTFLD11: TWideStringField
      FieldName = 'CUSTFLD11'
      Size = 255
    end
    object cboProductQryCUSTFLD12: TWideStringField
      FieldName = 'CUSTFLD12'
      Size = 255
    end
    object cboProductQryCUSTFLD13: TWideStringField
      FieldName = 'CUSTFLD13'
      Size = 255
    end
    object cboProductQryCUSTFLD14: TWideStringField
      FieldName = 'CUSTFLD14'
      Size = 255
    end
    object cboProductQryCUSTFLD15: TWideStringField
      FieldName = 'CUSTFLD15'
      Size = 255
    end
    object cboProductQryCUSTDATE1: TDateTimeField
      FieldName = 'CUSTDATE1'
    end
    object cboProductQryCUSTDATE2: TDateTimeField
      FieldName = 'CUSTDATE2'
    end
    object cboProductQryCUSTDATE3: TDateTimeField
      FieldName = 'CUSTDATE3'
    end
  end
  object qryCustomerJob: TERPQuery [31]
    SQL.Strings = (
      'SELECT ClientID, Company, JobNumber, DefaultClass,'
      'Street, Street2, Suburb, State, Country, Postcode,'
      'BillStreet, BillStreet2, BillSuburb, BillState, BillPostcode,'
      'TERMS, ShippingMethod, ShippingID, ShipTime'
      'FROM tblclients'
      'WHERE Active = '#39'T'#39
      'And Customer = '#39'T'#39' '
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and ((Company LIKE Concat(:SearchValue,"%"' +
        ')) or (JobNumber LIKE Concat(:SearchValue,"%")) ))'
      
        'or ((:SearchMode = 2) and ((Company LIKE Concat("%",:SearchValue' +
        ',"%")) or (JobNumber LIKE Concat("%",:SearchValue,"%")) )))'
      'and IfNull(:SearchValue,"") <> ""')
    AfterOpen = qryCustomerJobAfterOpen
    Options.LongStrings = False
    Left = 438
    Top = 376
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
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
  end
  object DMTextTargetOrder: TDMTextTarget [32]
    AcceptorControl = txtComments
    AcceptTextFormats = [dtfFiles, dtfCustom]
    OnDrop = DMTextTargetOrderDrop
    Left = 116
    Top = 335
  end
  object qryRepairEquip: TERPQuery [33]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '`RE`.`CustomerEquipmentID`,'
      '`E`.`EquipmentName`,'
      '`RE`.`RepairID`,'
      'R.RepairDocNo as RepairNo,'
      '`CE`.`Serialno`,'
      '`CE`.`Manufacture`,'
      '`CE`.`model`,'
      '`CE`.`Registration`,'
      '`CE`.`WarantyPeriod`,'
      '`CE`.`WarantyFinishDate`,'
      '`CE`.`Quantity`,'
      '`CE`.`ClientID`'
      'FROM'
      '`tblEquipmentxRef` AS `RE`'
      
        'Inner Join `tblcustomerequip` AS `CE` ON `RE`.`CustomerEquipment' +
        'ID` = `CE`.`id`'
      
        'Inner Join `tblequipment` AS `E` ON `CE`.`EquipmentID` = `E`.`Eq' +
        'uipmentID`'
      'Left Join tblRepairs as R on RE.RepairID = R.RepairID'
      
        'Where (RE.RepairID = :RepairID or :RepairID = 0) and (CE.ClientI' +
        'D = :ClientID or :ClientID = 0)')
    Left = 306
    Top = 376
    ParamData = <
      item
        DataType = ftInteger
        Name = 'RepairID'
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'RepairID'
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'ClientID'
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'ClientID'
        Value = 0
      end>
    object qryRepairEquipEquipmentName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldName = 'EquipmentName'
      Size = 50
    end
    object qryRepairEquipRepairID: TIntegerField
      DisplayLabel = 'Repair#'
      DisplayWidth = 10
      FieldName = 'RepairID'
    end
    object qryRepairEquipRepairNo: TWideStringField
      FieldName = 'RepairNo'
      Size = 50
    end
    object qryRepairEquipSerialno: TWideStringField
      DisplayLabel = 'Serial#'
      DisplayWidth = 1
      FieldName = 'Serialno'
      Size = 100
    end
    object qryRepairEquipUOM: TWideStringField
      DisplayWidth = 50
      FieldName = 'UOM'
      Size = 50
    end
    object qryRepairEquipQuantity: TFloatField
      DisplayWidth = 1
      FieldName = 'Quantity'
    end
    object qryRepairEquipManufacture: TWideStringField
      DisplayWidth = 1
      FieldName = 'Manufacture'
      Size = 100
    end
    object qryRepairEquipmodel: TWideStringField
      DisplayLabel = 'Model'
      DisplayWidth = 1
      FieldName = 'model'
      Size = 100
    end
    object qryRepairEquipRegistration: TWideStringField
      DisplayWidth = 1
      FieldName = 'Registration'
      Size = 100
    end
    object qryRepairEquipWarantyFinishDate: TDateTimeField
      DisplayLabel = 'Warranty Finish'
      DisplayWidth = 1
      FieldName = 'WarantyFinishDate'
    end
    object qryRepairEquipWarantyPeriod: TFloatField
      DisplayLabel = 'Warranty Period'
      DisplayWidth = 1
      FieldName = 'WarantyPeriod'
    end
    object qryRepairEquipCustomerEquipmentID: TIntegerField
      FieldName = 'CustomerEquipmentID'
      Visible = False
    end
    object qryRepairEquipClientID: TIntegerField
      FieldName = 'ClientID'
      Visible = False
    end
  end
  inherited imgPopup: TImageList
    Left = 257
    Top = 335
    Bitmap = {
      494C010102007800740110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  inherited ProgDialog: TProgressDialog
    Left = 646
    Top = 335
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 328
    Top = 335
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Top = 335
  end
  inherited DataState: TDataState
    Left = 256
    Top = 0
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 575
    Top = 335
  end
  object popOptions: TAdvPopupMenu [40]
    AutoHotkeys = maManual
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 504
    Top = 335
    object N1: TMenuItem
      Caption = '-'
    end
    object CustomFields1: TMenuItem
      Caption = 'Custom Fields'
      OnClick = customFields1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
  end
  object qryRepairLookup: TERPQuery [41]
    Connection = MyConnection
    SQL.Strings = (
      
        'select RepairID, RepairDocNo, CustomerName, cusid from tblRepair' +
        's')
    Left = 736
    Top = 376
    object qryRepairLookupRepairDocNo: TWideStringField
      DisplayLabel = 'Repair #'
      DisplayWidth = 20
      FieldName = 'RepairDocNo'
      Size = 50
    end
    object qryRepairLookupCustomerName: TWideStringField
      DisplayLabel = 'Customer Name'
      DisplayWidth = 30
      FieldName = 'CustomerName'
      Size = 255
    end
    object qryRepairLookupRepairID: TIntegerField
      FieldName = 'RepairID'
      Visible = False
    end
    object qryRepairLookupcusid: TIntegerField
      FieldName = 'cusid'
    end
  end
  object qryEmployeeLookup: TERPQuery [42]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT EmployeeName '
      'FROM tblemployees'
      'WHERE Active = '#39'T'#39' '
      'ORDER BY EmployeeName;')
    Options.LongStrings = False
    Left = 273
    Top = 376
    object qryEmployeeLookupEmployeeName: TWideStringField
      DisplayWidth = 30
      FieldName = 'EmployeeName'
      Origin = 'tblemployees.EmployeeName'
      Size = 255
    end
  end
  object QryAreaCodes: TERPQuery [43]
    Connection = MyConnection
    SQL.Strings = (
      
        'Select AreaCode, AreaName from tblAreaCodes where active ="T" or' +
        'der by Areacode')
    Left = 636
    Top = 376
    object QryAreaCodesAreaCode: TWideStringField
      DisplayLabel = 'Code'
      DisplayWidth = 10
      FieldName = 'AreaCode'
      Size = 50
    end
    object QryAreaCodesAreaName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldName = 'AreaName'
      Size = 100
    end
  end
  inherited QryTransStatus: TERPQuery [44]
    Left = 702
    Top = 376
  end
  inherited QryAreaCodeLk: TERPQuery [45]
    Left = 669
    Top = 376
  end
  inherited cbTaxCodeQry: TERPQuery [46]
    Left = 405
    Top = 376
  end
  inherited qryMemTrans: TERPQuery [47]
    Left = 537
    Top = 376
  end
  inherited SaveDialog1: TSaveDialog [48]
    Left = 434
    Top = 335
  end
  inherited imgsort: TImageList [49]
    Left = 292
    Top = 335
    Bitmap = {
      494C010102007C00780110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 398
    Top = 335
  end
  inherited QryCustomField: TERPQuery [51]
    Left = 42
    Top = 376
  end
  inherited TmrCommentshint: TTimer [52]
  end
  inherited mnuBusobjProperties: TAdvPopupMenu [53]
    Left = 540
    Top = 335
  end
  inherited tmrOnshow: TTimer [54]
  end
  object tblFEPOLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblFEPOLines'
      'WHERE POLineID = :ID')
    Left = 773
    Top = 378
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblFEPOLinesField1: TFloatField
      DisplayWidth = 10
      FieldName = 'Field1'
      Origin = 'tblfepolines.Field1'
    end
    object tblFEPOLinesField2: TFloatField
      DisplayWidth = 10
      FieldName = 'Field2'
      Origin = 'tblfepolines.Field2'
    end
    object tblFEPOLinesField3: TFloatField
      DisplayWidth = 10
      FieldName = 'Field3'
      Origin = 'tblfepolines.Field3'
    end
    object tblFEPOLinesfield4: TFloatField
      DisplayWidth = 10
      FieldName = 'field4'
      Origin = 'tblfepolines.field4'
    end
    object tblFEPOLinesField5: TFloatField
      DisplayWidth = 10
      FieldName = 'Field5'
      Origin = 'tblfepolines.Field5'
    end
    object tblFEPOLinesShippedField1: TFloatField
      DisplayWidth = 10
      FieldName = 'ShippedField1'
      Origin = 'tblfepolines.ShippedField1'
    end
    object tblFEPOLinesShippedField2: TFloatField
      DisplayWidth = 10
      FieldName = 'ShippedField2'
      Origin = 'tblfepolines.ShippedField2'
    end
    object tblFEPOLinesShippedField3: TFloatField
      DisplayWidth = 10
      FieldName = 'ShippedField3'
      Origin = 'tblfepolines.ShippedField3'
    end
    object tblFEPOLinesShippedfield4: TFloatField
      DisplayWidth = 10
      FieldName = 'Shippedfield4'
      Origin = 'tblfepolines.Shippedfield4'
    end
    object tblFEPOLinesShippedField5: TFloatField
      DisplayWidth = 10
      FieldName = 'ShippedField5'
      Origin = 'tblfepolines.ShippedField5'
    end
    object tblFEPOLinesPOID: TIntegerField
      DisplayWidth = 10
      FieldName = 'POID'
      Origin = 'tblfepolines.POID'
    end
    object tblFEPOLinesPOLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'POLineID'
      Origin = 'tblfepolines.POLineID'
    end
    object tblFEPOLinesFEPOLineID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'FEPOLineID'
      Origin = 'tblfepolines.FEPOLineID'
      ReadOnly = True
      Visible = False
    end
    object tblFEPOLinesGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Origin = 'tblfepolines.GlobalRef'
      Visible = False
      Size = 255
    end
    object tblFEPOLinesProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'tblfepolines.ProductID'
      Visible = False
    end
    object tblFEPOLinesDeleted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Origin = 'tblfepolines.Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblFEPOLinesProductName: TWideStringField
      DisplayWidth = 60
      FieldName = 'ProductName'
      Origin = 'tblfepolines.ProductName'
      Size = 60
    end
    object tblFEPOLinesmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblfepolines.msTimeStamp'
    end
    object tblFEPOLinesmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblfepolines.msUpdateSiteCode'
      Size = 3
    end
    object tblFEPOLinesFormulaId: TIntegerField
      FieldName = 'FormulaId'
      Origin = 'tblfepolines.FormulaId'
    end
  end
  object dsFEPOLines: TDataSource
    DataSet = tblFEPOLines
    Left = 773
    Top = 410
  end
  object dsFEPOlinesRelatedPrs: TDataSource
    DataSet = tblFEPOlinesRelatedPrs
    Left = 805
    Top = 410
  end
  object tblFEPOlinesRelatedPrs: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblFEPOlinesRelatedPrs'
      'WHERE FEPOLineID = :ID')
    Left = 805
    Top = 378
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblFEPOlinesRelatedPrsProductName: TWideStringField
      DisplayWidth = 23
      FieldName = 'ProductName'
      Origin = 'tblfepolinesrelatedprs.ProductName'
      Size = 60
    end
    object tblFEPOlinesRelatedPrsFormula: TWideStringField
      DisplayWidth = 23
      FieldName = 'Formula'
      Origin = 'tblfepolinesrelatedprs.Formula'
      Size = 255
    end
    object tblFEPOlinesRelatedPrsRelatedQty: TFloatField
      DisplayWidth = 10
      FieldName = 'RelatedQty'
      Origin = 'tblfepolinesrelatedprs.RelatedQty'
    end
    object tblFEPOlinesRelatedPrsRelatedShippedQty: TFloatField
      DisplayWidth = 10
      FieldName = 'RelatedShippedQty'
      Origin = 'tblfepolinesrelatedprs.RelatedShippedQty'
    end
    object tblFEPOlinesRelatedPrsFEPOlinesRelatedPrID: TAutoIncField
      FieldName = 'FEPOlinesRelatedPrID'
      Origin = 'tblfepolinesrelatedprs.FEPOlinesRelatedPrID'
      ReadOnly = True
      Visible = False
    end
    object tblFEPOlinesRelatedPrsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblfepolinesrelatedprs.GlobalRef'
      Visible = False
      Size = 255
    end
    object tblFEPOlinesRelatedPrsFEPOLineID: TIntegerField
      FieldName = 'FEPOLineID'
      Origin = 'tblfepolinesrelatedprs.FEPOLineID'
      Visible = False
    end
    object tblFEPOlinesRelatedPrsProductID: TIntegerField
      FieldName = 'ProductID'
      Origin = 'tblfepolinesrelatedprs.ProductID'
      Visible = False
    end
    object tblFEPOlinesRelatedPrsFormulaID: TIntegerField
      FieldName = 'FormulaID'
      Origin = 'tblfepolinesrelatedprs.FormulaID'
      Visible = False
    end
    object tblFEPOlinesRelatedPrsDeleted: TWideStringField
      FieldName = 'Deleted'
      Origin = 'tblfepolinesrelatedprs.Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
end
