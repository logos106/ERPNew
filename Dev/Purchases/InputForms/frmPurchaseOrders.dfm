inherited PurchaseGUI: TPurchaseGUI
  Left = 443
  Top = 359
  HelpContext = 455000
  ActiveControl = cboVia
  Caption = 'Purchase Order'
  ClientHeight = 548
  ClientWidth = 951
  ExplicitLeft = 443
  ExplicitTop = 359
  ExplicitWidth = 967
  ExplicitHeight = 587
  DesignSize = (
    951
    548)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 417
    Width = 951
    HelpContext = 455115
    ExplicitTop = 440
    ExplicitWidth = 951
  end
  inherited imgGridWatermark: TImage
    HelpContext = 455001
  end
  inherited pnlDetail: TDNMPanel
    Top = 240
    Width = 951
    Height = 177
    HelpContext = 455100
    Align = alClient
    ExplicitTop = 240
    ExplicitWidth = 951
    ExplicitHeight = 177
    inherited grdTransactions: TwwDBGrid
      Width = 951
      Height = 177
      HelpContext = 455102
      ControlType.Strings = (
        'ProductName;CustomEdit;cboProductR;F'
        'CustomerJob;CustomEdit;cboCustJob;F'
        'Class;CustomEdit;cboClass;F'
        'LineTaxCode;CustomEdit;cboTaxCode;F'
        'ForeignExchangeCode;CustomEdit;cboForeignCurrencyCode;F'
        'UnitofMeasurePOLines;CustomEdit;cboUnitOfMeasure;F'
        'SearchFilter;CustomEdit;txtSearchFilter;T'
        'CostCentreName;CustomEdit;cboCostCentre;F'
        'CostCentreId;CustomEdit;cboCostCentre;F'
        'SpecDescription;CustomEdit;cboPartSpecs;F'
        'ShipContainerETA;CustomEdit;edShipContainerETA;F'
        'EquipmentName;CustomEdit;cboEquipmentName;F'
        'LineNotes;CustomEdit;edtLineNotes;F'
        'MemoLine;CustomEdit;edtMemoLine;F'
        'RepairDocNo;CustomEdit;cboRepairDocNo;F'
        'EmployeeName;CustomEdit;cboLineEmployee;F'
        'AreaCode;CustomEdit;cboLinesAreaCode;F'
        'ShipContainerNAmeX;CustomEdit;cboShippingContainer;F'
        'ShipContainerNameX;CustomEdit;cboShippingContainer;F')
      Selected.Strings = (
        'ProductName'#9'17'#9'Product'#9#9
        'Product_custFld1'#9'20'#9'Product_custFld1'#9#9
        'Product_custFld2'#9'20'#9'Product_custFld2'#9#9
        'Product_custFld3'#9'20'#9'Product_custFld3'#9#9
        'Product_custFld4'#9'20'#9'Product_custFld4'#9#9
        'Product_custFld5'#9'20'#9'Product_custFld5'#9#9
        'Product_custFld6'#9'20'#9'Product_custFld6'#9#9
        'OriginalQtyOrdered'#9'7'#9'Orig Qty'#9#9
        'Product_custFld7'#9'20'#9'Product_custFld7'#9#9
        'Product_custFld8'#9'20'#9'Product_custFld8'#9#9
        'Product_custFld9'#9'20'#9'Product_custFld9'#9#9
        'SpecDescription'#9'7'#9'Specifications'#9#9
        'SpecValue'#9'7'#9'Spec Qty'#9#9
        'ReceivedDate'#9'18'#9'Received Date'#9#9
        'Product_Description'#9'35'#9'Description'#9#9
        'CostCentreName'#9'10'#9'Cost Centre Name'#9#9
        'LineCost'#9'10'#9'Cost (Ex)'#9#9
        'LineTaxCode'#9'15'#9'Code'#9#9
        'LineTax'#9'10'#9'Tax (Dbl Click)'#9#9
        'TotalLineAmountInc'#9'10'#9'Amount (Inc)'#9#9
        'ForeignTotalLineAmount'#9'10'#9'Foreign Total'#9#9
        'ETADate'#9'10'#9'ETA Date'#9#9
        'CustomField1'#9'10'#9'CustomField1'#9#9
        'CustomField2'#9'10'#9'CustomField2'#9#9
        'CustomField3'#9'10'#9'CustomField3'#9#9
        'CustomField4'#9'10'#9'CustomField4'#9#9
        'CustomField5'#9'10'#9'CustomField5'#9#9
        'CustomField6'#9'10'#9'CustomField6'#9#9
        'CustomField7'#9'10'#9'CustomField7'#9#9
        'CustomField8'#9'10'#9'CustomField8'#9#9
        'CustomField9'#9'10'#9'CustomField9'#9#9
        'CustomField10'#9'10'#9'CustomField10'#9#9
        'LineNotes'#9'10'#9'Line Notes'#9#9
        'ForeignExchangeCode'#9'3'#9'Foreign Exchange Code'#9#9
        'LandedCostsPerItem'#9'10'#9'Landed Cost/Item'#9#9
        'LandedCostsTotal'#9'10'#9'Landed Costs Total'#9#9
        'MemoLine'#9'10'#9'Memo Line'#9#9
        'ShipContainerName'#9'15'#9'Ship Container'#9#9
        'ShipContainerETA'#9'10'#9'Ship Container ETA'#9#9
        'EquipmentName'#9'30'#9'Equipment Name'#9#9
        'LandedCostsPercentage'#9'10'#9'Landed Costs %'#9#9
        'SupplierProductCode'#9'20'#9'Supp Product Code'#9#9
        'SupplierProductName'#9'20'#9'Supp Product Name'#9#9
        'ProcTreeId'#9'10'#9'ProcTreeId'#9'F'#9
        'TotalLineLandedCost'#9'10'#9'Landed Cost'#9#9
        'PrintedValue'#9'10'#9'Printed Value'#9#9
        'DiscountPercent'#9'10'#9'Discount %'#9#9
        'OriginalCost'#9'10'#9'OriginalCost'#9'F'#9
        'cOriginalCost'#9'10'#9'Original Cost'#9#9
        'LineCostInc'#9'10'#9'Cost (Inc)'#9#9
        'PartBarcode'#9'10'#9'Product Barcode'#9#9
        'UOM_Height'#9'10'#9'Height'#9#9
        'UOM_Width'#9'10'#9'Width'#9#9
        'UOM_Length'#9'10'#9'Length'#9#9
        'UOM_Weight'#9'10'#9'Weight'#9#9
        'TotalUOM_WeightSold'#9'10'#9'Total Sold Weight'#9#9
        'TotalUOM_WeightShipped'#9'10'#9'Total Shipped Weight'#9#9
        'TotalUOM_WeightBO'#9'10'#9'Total BO Weight'#9#9
        'UOM_Volume'#9'10'#9'Volume'#9#9
        'RepairDocNo'#9'12'#9'Repair #'#9#9
        'SmartOrderID'#9'10'#9'SmartOrderID'#9'F'#9
        'SmartOrderLineID'#9'10'#9'SmartOrderLineID'#9'F'#9
        'Product_custFld10'#9'20'#9'Product_custFld10'#9#9
        'Product_custFld11'#9'20'#9'Product_custFld11'#9#9
        'Product_custFld12'#9'20'#9'Product_custFld12'#9#9
        'Product_custFld13'#9'20'#9'Product_custFld13'#9#9
        'Product_custFld14'#9'20'#9'Product_custFld14'#9#9
        'Product_custFld15'#9'20'#9'Product_custFld15'#9#9
        'Product_custDate1'#9'18'#9'Product_custDate1'#9#9
        'Product_custDate2'#9'18'#9'Product_custDate2'#9#9
        'Product_custDate3'#9'18'#9'Product_custDate3'#9#9
        'Class'#9'9'#9'Department'#9#9
        'UnitofMeasurePOLines'#9'9'#9'Units'#9#9
        'UnitofMeasureQtySold'#9'7'#9'Ordered'#9#9
        'UnitofMeasureShipped'#9'7'#9'Received'#9#9
        'PQA'#9'1'#9'Allocation'#9#9
        'UnitofMeasureBackorder'#9'7'#9'BO'#9#9
        'Attrib1Purchase'#9'7'#9'Metres'#9#9
        'Attrib2Purchase'#9'7'#9'Weight'#9#9
        'ForeignCurrencyLineCost'#9'10'#9'Foreign Cost'#9#9
        'Attrib1PurchaseRate'#9'7'#9'Metres'#9#9
        'FormulaQtySoldValue'#9'10'#9'FormulaQtySoldValue'#9#9
        'FormulaQtyShippedValue2'#9'10'#9'FormulaQtyShippedValue2'#9#9
        'FormulaQtySoldValue3'#9'10'#9'FormulaQtySoldValue3'#9#9
        'FormulaQtyShippedValue'#9'10'#9'FormulaQtyShippedValue'#9#9
        'FormulaQtySoldValue4'#9'10'#9'FormulaQtySoldValue4'#9#9
        'Attrib1PurchaseEst'#9'10'#9'Attrib1PurchaseEst'#9#9
        'FormulaQtyShippedValue3'#9'10'#9'FormulaQtyShippedValue3'#9#9
        'FormulaQtySoldValue1'#9'10'#9'FormulaQtySoldValue1'#9#9
        'AreaCode'#9'10'#9'Area'#9#9
        'Attrib2PurchaseEst'#9'10'#9'Metres'#9#9
        'FormulaQtyShippedValue1'#9'10'#9'FormulaQtyShippedValue1'#9#9
        'FormulaQtySoldValue2'#9'10'#9'FormulaQtySoldValue2'#9#9
        'LinesOrder'#9'10'#9'Order by'#9#9
        'TotalUOM_LengthSold'#9'10'#9'Total Sold Length'#9#9
        'EmployeeName'#9'20'#9'Employee'#9#9
        'TotalUOM_LengthShipped'#9'10'#9'Total Shipped Length'#9#9
        'TotalUOM_LengthBO'#9'10'#9'Total BO Length'#9#9
        'StandardCost'#9'10'#9'Standard Cost'#9#9
        'FormulaQtySoldValue5'#9'10'#9'FormulaQtySoldValue5'#9#9
        'FormulaQtyShippedValue5'#9'10'#9'FormulaQtyShippedValue5'#9#9
        'FormulaQtyShippedValue4'#9'10'#9'FormulaQtyShippedValue4'#9#9
        'SellPrice'#9'10'#9'Sell Price'#9'F'#9
        'BoxesReceived'#9'10'#9'Boxes Received'#9'F'#9
        'BoxesOrdered'#9'10'#9'BoxesOrdered'#9'F'#9
        'ProductPrintName'#9'20'#9'ProductPrintName'#9'F'#9
        'ForeignUOMLineCost'#9'10'#9'Foreign UOM Cost'#9#9
        'LineDescription'#9'20'#9'Change Desc After Approval'#9'T'#9
        'GeneralNotes'#9'20'#9'Product General Notes'#9'F'#9
        'DocketNumber'#9'10'#9'Docket Number'#9#9
        'SaleLineID'#9'10'#9'SaleLineID'#9'F'#9
        'SupplierBarCode'#9'50'#9'SupplierBarCode'#9'F'#9)
      MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
      OnDrawFooterCell = grdTransactionsDrawFooterCell
      ExplicitWidth = 951
      ExplicitHeight = 177
    end
    inherited cboClass: TwwDBLookupCombo
      Left = 168
      Top = 29
      Width = 52
      HelpContext = 455166
      ExplicitLeft = 168
      ExplicitTop = 29
      ExplicitWidth = 52
    end
    inherited cboTaxCode: TERPDbLookupCombo
      Left = 113
      Top = 29
      Width = 52
      HelpContext = 455167
      TabOrder = 15
      ExplicitLeft = 113
      ExplicitTop = 29
      ExplicitWidth = 52
    end
    inherited cboForeignCurrencyCode: TwwDBLookupCombo
      Left = 885
      Top = 29
      Width = 52
      HelpContext = 455168
      Selected.Strings = (
        'Code'#9'5'#9'Code'#9'F'
        'Country'#9'25'#9'Country'#9'F'#9
        'Currency'#9'15'#9'Currency'#9'F')
      ExplicitLeft = 885
      ExplicitTop = 29
      ExplicitWidth = 52
    end
    inherited cboUnitOfMeasure: TwwDBLookupCombo
      Left = 333
      Top = 29
      Width = 52
      HelpContext = 455169
      ExplicitLeft = 333
      ExplicitTop = 29
      ExplicitWidth = 52
    end
    inherited txtSearchFilter: TwwDBEdit
      Left = 388
      Top = 31
      Width = 52
      HelpContext = 455170
      ExplicitLeft = 388
      ExplicitTop = 31
      ExplicitWidth = 52
    end
    inherited cboPartSpecs: TwwDBLookupCombo
      Left = 554
      Top = 29
      Width = 52
      HelpContext = 455171
      Selected.Strings = (
        'SpecDescription'#9'30'#9'SpecDescription'#9'F')
      LookupTable = qryPartsSpecs
      Style = csDropDownList
      OnCloseUp = nil
      OnEnter = cboPartSpecsEnter
      OnNotInList = cboPartSpecsNotInList
      ExplicitLeft = 554
      ExplicitTop = 29
      ExplicitWidth = 52
    end
    inherited cboProductR: TERPDbLookupCombo
      Left = 3
      Top = 29
      Width = 52
      HelpContext = 455172
      ExplicitLeft = 3
      ExplicitTop = 29
      ExplicitWidth = 52
    end
    inherited cboEquipmentName: TwwDBLookupCombo
      Left = 444
      Top = 29
      Width = 52
      HelpContext = 455173
      Selected.Strings = (
        'EquipmentName'#9'20'#9'Name'#9'F'
        'RepairID'#9'1'#9'Repair#'#9'F'
        'Serialno'#9'10'#9'Serial#'#9'F'
        'Quantity'#9'1'#9'Quantity'#9'F'
        'Manufacture'#9'10'#9'Manufacture'#9'F'
        'model'#9'10'#9'Model'#9'F'
        'Registration'#9'10'#9'Registration'#9'F'
        'WarantyFinishDate'#9'10'#9'Warranty Finish'#9'F'
        'WarantyPeriod'#9'1'#9'Warranty Period'#9'F')
      ExplicitLeft = 444
      ExplicitTop = 29
      ExplicitWidth = 52
    end
    inherited edtMemoLine: TwwDBEdit
      Left = 777
      Top = 29
      Width = 52
      HelpContext = 455174
      TabOrder = 17
      OnDblClick = edtMemoLineDblClick
      ExplicitLeft = 777
      ExplicitTop = 29
      ExplicitWidth = 52
    end
    inherited cboRepairDocNo: TwwDBLookupCombo
      Left = 829
      Top = 29
      Width = 52
      HelpContext = 455175
      ExplicitLeft = 829
      ExplicitTop = 29
      ExplicitWidth = 52
    end
    inherited cboLinesAreaCode: TwwDBLookupCombo
      Left = 664
      Top = 31
      Width = 52
      HelpContext = 455176
      TabOrder = 16
      ExplicitLeft = 664
      ExplicitTop = 31
      ExplicitWidth = 52
    end
    inherited cboPrintProductR: TERPDbLookupCombo
      Left = 223
      Top = 29
      Width = 52
      HelpContext = 455177
      TabOrder = 18
      ExplicitLeft = 223
      ExplicitTop = 29
      ExplicitWidth = 52
    end
    inherited cboCustJob: TERPDbLookupCombo
      Left = 58
      Top = 30
      Width = 52
      HelpContext = 455178
      TabOrder = 13
      ExplicitLeft = 58
      ExplicitTop = 30
      ExplicitWidth = 52
    end
    inherited cboCustPrintJob: TERPDbLookupCombo
      Left = 499
      Top = 30
      Width = 52
      HelpContext = 455179
      ExplicitLeft = 499
      ExplicitTop = 30
      ExplicitWidth = 52
    end
    object cboCostCentre: TwwDBLookupCombo
      Left = 278
      Top = 29
      Width = 52
      Height = 26
      HelpContext = 455135
      AutoSize = False
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'CostCentreName'#9'15'#9'Cost Centre'#9'F'
        'CostCentreDescription'#9'40'#9'Description'#9'F')
      DataField = 'CostCentreName'
      DataSource = DSDetails
      LookupTable = qryCostCentre
      LookupField = 'CostCentreID'
      Options = [loTitles]
      DropDownWidth = 700
      TabOrder = 8
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboCostCentreCloseUp
      OnNotInList = cboCostCentreNotInList
    end
    object edShipContainerETA: TwwDBEdit
      Left = 719
      Top = 29
      Width = 52
      Height = 26
      HelpContext = 455136
      AutoFillDate = False
      AutoSelect = False
      ReadOnly = True
      TabOrder = 12
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnDblClick = edShipContainerETADblClick
    end
    object edtLineNotes: TwwDBEdit
      Left = 609
      Top = 29
      Width = 52
      Height = 26
      HelpContext = 455137
      DataField = 'LineNotes'
      DataSource = DSDetails
      TabOrder = 11
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnDblClick = edtLineNotesDblClick
    end
  end
  inherited pnlFooter: TDNMPanel
    Top = 417
    Width = 951
    Height = 131
    HelpContext = 455002
    Align = alBottom
    ExplicitTop = 417
    ExplicitWidth = 951
    ExplicitHeight = 131
    DesignSize = (
      951
      131)
    inherited lblComments: TLabel
      Left = 8
      Top = -17
      HelpContext = 455004
      ExplicitLeft = 8
      ExplicitTop = -17
    end
    inherited Label142: TLabel
      Left = 767
      Top = 39
      HelpContext = 455005
      ExplicitLeft = 767
      ExplicitTop = 39
    end
    inherited Label54: TLabel
      Left = 775
      Top = 70
      Width = 53
      HelpContext = 455006
      ExplicitLeft = 775
      ExplicitTop = 70
      ExplicitWidth = 53
    end
    inherited Label56: TLabel
      Left = 775
      Top = 99
      Width = 41
      HelpContext = 455007
      Caption = 'Total '
      ExplicitLeft = 775
      ExplicitTop = 99
      ExplicitWidth = 41
    end
    object Label6: TLabel [4]
      Left = 9
      Top = 47
      Width = 67
      Height = 38
      HelpContext = 455022
      Alignment = taRightJustify
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Warehouse Notes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    inherited lblBaseForeignTotal: TLabel
      Left = 637
      Top = 61
      Width = 45
      Height = 30
      HelpContext = 455011
      Alignment = taRightJustify
      AutoSize = True
      Visible = True
      ExplicitLeft = 637
      ExplicitTop = 61
      ExplicitWidth = 45
      ExplicitHeight = 30
    end
    object lblEstimatedFinalAmt: TLabel [6]
      Left = 635
      Top = 5
      Width = 47
      Height = 15
      HelpContext = 455026
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Est Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object EstimatedFinalAmt: TLabel [7]
      Left = 686
      Top = 4
      Width = 83
      Height = 16
      HelpContext = 455027
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = '0.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel [8]
      Left = 629
      Top = 93
      Width = 53
      Height = 30
      HelpContext = 455143
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      BiDiMode = bdLeftToRight
      Caption = 'Discount Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Bevel5: TBevel [9]
      Left = 322
      Top = 0
      Width = 2
      Height = 131
      HelpContext = 455116
      Anchors = [akLeft, akTop, akBottom]
      Shape = bsLeftLine
      ExplicitHeight = 124
    end
    object lblEstimatedForeignAmt: TLabel [10]
      Left = 648
      Top = 26
      Width = 34
      Height = 15
      HelpContext = 455144
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Est Fx'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object EstimatedForeignAmt: TLabel [11]
      Left = 686
      Top = 25
      Width = 83
      Height = 16
      HelpContext = 455145
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = '0.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblEmployeeExpenseClaim: TLabel [12]
      Left = 24
      Top = 97
      Width = 52
      Height = 30
      HelpContext = 455089
      Alignment = taRightJustify
      Caption = 'Expense Claim'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    inherited lblEmail: TDNMPanel [13]
      Left = 714
      Top = 2
      HelpContext = 455190
      TabOrder = 8
      ExplicitLeft = 714
      ExplicitTop = 2
      inherited lblEmailMsg: TLabel
        Left = -24
        Top = 2
        ExplicitLeft = -24
        ExplicitTop = 2
      end
    end
    inherited pnlComments: TDNMPanel [14]
      Left = 80
      Height = 49
      HelpContext = 455157
      TabOrder = 6
      ExplicitLeft = 80
      ExplicitHeight = 49
      inherited LblCommentsHint: TLabel
        Top = 43
        Height = 5
        HelpContext = 455158
        Anchors = [akLeft, akTop, akRight, akBottom]
        ExplicitLeft = 2
        ExplicitTop = 48
        ExplicitWidth = 238
        ExplicitHeight = 15
      end
      inherited txtComments: TDBMemo
        Height = 42
        Hint = '"Type In Comments for this Order"'
        HelpContext = 455013
        ExplicitHeight = 42
      end
    end
    inherited txtSubTotal: TDBEdit [15]
      Left = 834
      Top = 35
      HelpContext = 455014
      TabOrder = 12
      ExplicitLeft = 834
      ExplicitTop = 35
    end
    inherited txtTotalTax: TDBEdit [16]
      Left = 834
      Top = 66
      HelpContext = 455015
      TabOrder = 9
      ExplicitLeft = 834
      ExplicitTop = 66
    end
    inherited txtTotalAmount: TDBEdit [17]
      Left = 820
      HelpContext = 455016
      TabOrder = 4
      ExplicitLeft = 820
    end
    inherited edtBaseForeignTotal: TDBEdit [18]
      Left = 684
      Top = 66
      Width = 85
      HelpContext = 455017
      DataField = 'ForeignTotalAmount'
      TabOrder = 1
      Visible = True
      ExplicitLeft = 684
      ExplicitTop = 66
      ExplicitWidth = 85
    end
    inherited lblDisableCalc: TDNMSpeedButton [19]
      Left = 846
      Top = 1
      TabOrder = 11
      ExplicitLeft = 846
      ExplicitTop = 1
    end
    inherited DNMPanel5: TDNMPanel [20]
      Left = 325
      Height = 124
      HelpContext = 455117
      TabOrder = 3
      ExplicitLeft = 325
      ExplicitHeight = 124
      inherited lblEnteredbyHead: TLabel
        Left = 4
        Top = 4
        ExplicitLeft = 4
        ExplicitTop = 4
      end
      inherited lblEnteredBy: TDBText
        Left = 76
        Top = 4
        Width = 69
        Height = 15
        HelpContext = 455118
        ExplicitLeft = 76
        ExplicitTop = 4
        ExplicitWidth = 69
        ExplicitHeight = 15
      end
      inherited lblPrintHead: TLabel
        Left = 4
        Top = 53
        ExplicitLeft = 4
        ExplicitTop = 53
      end
      inherited lblPrintedBy: TLabel
        Left = 76
        Top = 54
        Width = 66
        HelpContext = 455119
        AutoSize = False
        ExplicitLeft = 76
        ExplicitTop = 54
        ExplicitWidth = 66
      end
      inherited lblPrintedOnCaption: TLabel
        Left = 4
        Top = 77
        ExplicitLeft = 4
        ExplicitTop = 77
      end
      inherited lblPrintedOn: TLabel
        Left = 76
        Top = 77
        Width = 65
        Height = 18
        HelpContext = 455120
        ExplicitLeft = 76
        ExplicitTop = 77
        ExplicitWidth = 65
        ExplicitHeight = 18
      end
      inherited lblPrintedAtCaption: TLabel
        Left = 4
        Top = 102
        ExplicitLeft = 4
        ExplicitTop = 102
      end
      inherited lblPrintedAt: TLabel
        Left = 76
        Top = 102
        Width = 48
        Height = 15
        HelpContext = 455121
        ExplicitLeft = 76
        ExplicitTop = 102
        ExplicitWidth = 48
        ExplicitHeight = 15
      end
      inherited lblEnteredAtHead: TLabel
        Left = 4
        Top = 28
        Width = 62
        HelpContext = 455122
        Caption = 'Entered At:'
        ExplicitLeft = 4
        ExplicitTop = 28
        ExplicitWidth = 62
      end
      inherited lblEnteredAt: TDBText
        Left = 76
        Top = 28
        Width = 66
        Height = 15
        HelpContext = 455123
        DataField = 'EnteredAtShort'
        ExplicitLeft = 76
        ExplicitTop = 28
        ExplicitWidth = 66
        ExplicitHeight = 15
      end
    end
    inherited btnAttachments: TDNMSpeedButton [21]
      Left = 9
      HelpContext = 455020
      TabOrder = 5
      ExplicitLeft = 9
    end
    object txtSalesComments: TDBMemo [22]
      Left = 80
      Top = 51
      Width = 240
      Height = 49
      Hint = '"Type In A Comment For The Warehouse"'
      HelpContext = 455035
      DataField = 'SalesComments'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object edtTotalDiscount: TDBEdit [23]
      Left = 684
      Top = 97
      Width = 85
      Height = 24
      HelpContext = 455146
      TabStop = False
      Anchors = [akRight, akBottom]
      DataField = 'TotalDiscount'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 7
    end
    object DNMPanel3: TDNMPanel [24]
      Left = 469
      Top = 0
      Width = 162
      Height = 124
      HelpContext = 455124
      BevelKind = bkFlat
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      DesignSize = (
        158
        120)
      object Label8: TLabel
        Left = 9
        Top = 89
        Width = 49
        Height = 30
        HelpContext = 455025
        Alignment = taRightJustify
        Anchors = [akLeft, akBottom]
        Caption = 'Cust PO Number'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label12: TLabel
        Left = 47
        Top = 42
        Width = 17
        Height = 15
        HelpContext = 455032
        Caption = 'BO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblShipTitle: TLabel
        Left = 12
        Top = 23
        Width = 52
        Height = 15
        HelpContext = 455028
        Caption = 'Received'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblOrdTitle: TLabel
        Left = 17
        Top = 4
        Width = 47
        Height = 15
        HelpContext = 455030
        Caption = 'Ordered'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblBO: TLabel
        Left = 124
        Top = 42
        Width = 30
        Height = 15
        HelpContext = 455033
        Alignment = taRightJustify
        Caption = 'lblBO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object lblShipped: TLabel
        Left = 95
        Top = 23
        Width = 59
        Height = 15
        HelpContext = 455029
        Alignment = taRightJustify
        Caption = 'lblShipped'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object lblOrdered: TLabel
        Left = 96
        Top = 4
        Width = 58
        Height = 15
        HelpContext = 455031
        Alignment = taRightJustify
        Caption = 'lblOrdered'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Bevel2: TBevel
        Left = -3
        Top = 59
        Width = 161
        Height = 1
        HelpContext = 455125
        Shape = bsTopLine
      end
      object Label7: TLabel
        Left = 4
        Top = 68
        Width = 54
        Height = 15
        HelpContext = 455023
        Alignment = taRightJustify
        Caption = 'Con. Note'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object CustPONumber: TDBEdit
        Left = 64
        Top = 93
        Width = 90
        Height = 23
        HelpContext = 455036
        DataField = 'CustPONumber'
        DataSource = DSMaster
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = txtInvNumberChange
      end
      object txtConsignmentNotes: TDBMemo
        Left = 62
        Top = 64
        Width = 90
        Height = 23
        Hint = '"You can type a note for the consignment here."'
        HelpContext = 455034
        DataField = 'ConNote'
        DataSource = DSMaster
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnDblClick = txtCommentsDblClick
      end
    end
    inherited pnlProcessMessage: TDNMPanel [25]
      Width = 951
      HelpContext = 455180
      ExplicitWidth = 951
      inherited lblProcessMessage: TLabel
        Width = 947
        HelpContext = 455101
        ExplicitLeft = 200
        ExplicitWidth = 749
      end
    end
    object cboExpenseClaimEmployee: TwwDBLookupCombo
      Left = 80
      Top = 102
      Width = 179
      Height = 23
      HelpContext = 455099
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'EmployeeName'#9'10'#9'EmployeeName'#9'F')
      DataField = 'ExpenseClaimEmployee'
      DataSource = DSMaster
      LookupTable = cboEmployeeLookup
      LookupField = 'EmployeeID'
      ParentFont = False
      TabOrder = 13
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboExpenseClaimEmployeeCloseUp
      OnExit = cboExpenseClaimEmployeeExit
    end
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 265
      Top = 100
      Width = 55
      Height = 27
      HelpContext = 455164
      Action = actConvertToAsset
      Anchors = [akTop, akRight]
      Caption = 'Asset'
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
      TabOrder = 14
      AutoDisableParentOnclick = True
    end
  end
  inherited pnlHeader: TDNMPanel
    Width = 951
    Height = 240
    HelpContext = 455038
    ParentColor = True
    ExplicitWidth = 951
    ExplicitHeight = 240
    DesignSize = (
      951
      240)
    object Bevel1: TBevel [0]
      Left = 270
      Top = 147
      Width = 312
      Height = 49
      HelpContext = 455081
      Shape = bsFrame
    end
    inherited Label38: TLabel
      Left = 8
      Top = 44
      HelpContext = 455039
      ExplicitLeft = 8
      ExplicitTop = 44
    end
    inherited lblClientDetails: TLabel
      Left = 8
      Top = 88
      HelpContext = 455040
      ExplicitLeft = 8
      ExplicitTop = 88
    end
    inherited SaleDate_Label: TLabel
      Left = 589
      Top = 13
      Width = 79
      HelpContext = 455041
      Caption = 'Order Date'
      ExplicitLeft = 589
      ExplicitTop = 13
      ExplicitWidth = 79
    end
    inherited Label160: TLabel
      Left = 713
      Top = 13
      Width = 76
      HelpContext = 455042
      Caption = 'PO Number'
      ExplicitLeft = 713
      ExplicitTop = 13
      ExplicitWidth = 76
    end
    inherited Label43: TLabel
      Left = 113
      Top = 201
      Width = 100
      Height = 15
      HelpContext = 455069
      Alignment = taLeftJustify
      AutoSize = True
      Caption = 'Supplier Invoice #'
      WordWrap = False
      ExplicitLeft = 113
      ExplicitTop = 201
      ExplicitWidth = 100
      ExplicitHeight = 15
    end
    inherited Label47: TLabel
      Left = 748
      Top = 199
      Width = 81
      HelpContext = 455070
      Alignment = taLeftJustify
      ExplicitLeft = 748
      ExplicitTop = 199
      ExplicitWidth = 81
    end
    inherited Label79: TLabel
      Left = 430
      Top = 199
      Width = 79
      HelpContext = 455071
      ExplicitLeft = 430
      ExplicitTop = 199
      ExplicitWidth = 79
    end
    inherited Label45: TLabel
      Left = 292
      Top = 11
      Width = 26
      HelpContext = 455072
      Visible = False
      ExplicitLeft = 292
      ExplicitTop = 11
      ExplicitWidth = 26
    end
    inherited lblAccount: TLabel
      Left = 8
      HelpContext = 455073
      ExplicitLeft = 8
    end
    inherited Label48: TLabel
      Left = 325
      Top = 199
      Width = 79
      HelpContext = 455043
      Caption = 'Employee'
      ExplicitLeft = 325
      ExplicitTop = 199
      ExplicitWidth = 79
    end
    object Label35: TLabel [11]
      Left = 588
      Top = 84
      Width = 41
      Height = 15
      HelpContext = 455082
      Caption = 'Ship To'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label3: TLabel [12]
      Left = 8
      Top = 199
      Width = 79
      Height = 18
      HelpContext = 455083
      AutoSize = False
      Caption = 'ETA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    inherited lbMemTrans: TLabel
      Left = 714
      Top = 0
      HelpContext = 455044
      ExplicitLeft = 714
      ExplicitTop = 0
    end
    object Label5: TLabel [14]
      Left = 219
      Top = 201
      Width = 69
      Height = 15
      HelpContext = 455084
      Caption = 'Invoice Date'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    inherited lblBaseForeignCurrencyCode: TLabel
      Left = 271
      Top = 66
      HelpContext = 455045
      Visible = True
      ExplicitLeft = 271
      ExplicitTop = 66
    end
    object Label9: TLabel [16]
      Left = 279
      Top = 151
      Width = 92
      Height = 15
      HelpContext = 455085
      Caption = 'Search Barcode'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label10: TLabel [17]
      Left = 402
      Top = 150
      Width = 22
      Height = 15
      HelpContext = 455086
      Caption = '(F9)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object edt_PONum_Seq: TDBText [18]
      Left = 791
      Top = 30
      Width = 58
      Height = 16
      HelpContext = 455087
      DataField = 'PONum_Seq'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    inherited lblBaseExchangeRate: TLabel
      Left = 271
      Top = 106
      Width = 90
      HelpContext = 455046
      Visible = True
      ExplicitLeft = 271
      ExplicitTop = 106
      ExplicitWidth = 90
    end
    object lblProductReceiptsOnly: TLabel [21]
      Left = 271
      Top = 47
      Width = 311
      Height = 19
      HelpContext = 455088
      Alignment = taCenter
      AutoSize = False
      Caption = 'Product Receipt Only'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    inherited lblArea: TLabel
      Left = 642
      Top = 201
      Alignment = taLeftJustify
      ExplicitLeft = 642
      ExplicitTop = 201
    end
    inherited lblStatus: TLabel
      Left = 589
      Top = 181
      Width = 37
      HelpContext = 455152
      AutoSize = True
      ExplicitLeft = 589
      ExplicitTop = 181
      ExplicitWidth = 37
    end
    object Label13: TLabel [25]
      Left = 430
      Top = 151
      Width = 81
      Height = 15
      HelpContext = 455149
      Caption = 'Receive Batch'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label14: TLabel [26]
      Left = 553
      Top = 150
      Width = 22
      Height = 15
      HelpContext = 455150
      Caption = '(F8)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label15: TLabel [27]
      Left = 536
      Top = 201
      Width = 51
      Height = 15
      HelpContext = 455153
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
    object Label4: TLabel [28]
      Left = 8
      Top = 181
      Width = 60
      Height = 15
      HelpContext = 455097
      Caption = 'Equipment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblPickUpFrom: TLabel [29]
      Left = 769
      Top = 60
      Width = 57
      Height = 15
      HelpContext = 455181
      Alignment = taRightJustify
      Caption = 'Pick From'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    inherited cboCurrentTransStatus: TwwDBLookupCombo
      Left = 637
      Top = 177
      Width = 214
      HelpContext = 455182
      TabOrder = 38
      ExplicitLeft = 637
      ExplicitTop = 177
      ExplicitWidth = 214
    end
    inherited txtClientDetails: TDBMemo
      Left = 8
      Top = 103
      Width = 258
      Height = 68
      HelpContext = 455049
      ExplicitLeft = 8
      ExplicitTop = 103
      ExplicitWidth = 258
      ExplicitHeight = 68
    end
    inherited cboCreationDate: TwwDBDateTimePicker
      Left = 589
      Top = 28
      Height = 23
      HelpContext = 455050
      TabOrder = 14
      ExplicitLeft = 589
      ExplicitTop = 28
      ExplicitHeight = 23
    end
    inherited txtCustomID: TDBEdit
      Left = 710
      Top = 28
      Width = 75
      Hint = 'Double Click For The Transaction Sequence List'
      HelpContext = 455051
      ParentShowHint = False
      ShowHint = True
      TabOrder = 15
      ExplicitLeft = 710
      ExplicitTop = 28
      ExplicitWidth = 75
    end
    inherited cboEmployee: TwwDBLookupCombo
      Left = 325
      Top = 214
      Width = 102
      HelpContext = 455052
      TabOrder = 20
      ExplicitLeft = 325
      ExplicitTop = 214
      ExplicitWidth = 102
    end
    inherited txtInvNumber: TDBEdit
      Left = 113
      Top = 214
      Width = 102
      HelpContext = 455074
      TabOrder = 18
      OnChange = txtInvNumberChange
      OnEnter = OverrideAccessLevel
      OnExit = txtInvNumberExit
      ExplicitLeft = 113
      ExplicitTop = 214
      ExplicitWidth = 102
    end
    inherited cboVia: TwwDBLookupCombo
      Left = 749
      Top = 214
      Width = 102
      HelpContext = 455075
      TabOrder = 24
      ExplicitLeft = 749
      ExplicitTop = 214
      ExplicitWidth = 102
    end
    inherited cboTerms: TwwDBLookupCombo
      Left = 430
      Top = 214
      Width = 102
      HelpContext = 455076
      TabOrder = 21
      ExplicitLeft = 430
      ExplicitTop = 214
      ExplicitWidth = 102
    end
    inherited cboDueDate: TwwDBDateTimePicker
      Left = 293
      Top = 12
      Width = 17
      HelpContext = 455077
      TabOrder = 37
      Visible = False
      ExplicitLeft = 293
      ExplicitTop = 12
      ExplicitWidth = 17
    end
    inherited cboAccount: TwwDBLookupCombo
      Left = 8
      Top = 19
      Width = 214
      HelpContext = 455078
      TabOrder = 0
      ExplicitLeft = 8
      ExplicitTop = 19
      ExplicitWidth = 214
    end
    inherited btnNext: TDNMSpeedButton
      Left = 854
      Top = 3
      Width = 89
      HelpContext = 455053
      Font.Height = -12
      TabOrder = 25
      ExplicitLeft = 854
      ExplicitTop = 3
      ExplicitWidth = 89
    end
    inherited btnCompleted: TDNMSpeedButton
      Left = 854
      Top = 32
      Width = 89
      Height = 27
      HelpContext = 455183
      Caption = 'Save'
      Font.Height = -12
      TabOrder = 26
      ExplicitLeft = 854
      ExplicitTop = 32
      ExplicitWidth = 89
      ExplicitHeight = 27
    end
    inherited btnClose: TDNMSpeedButton
      Left = 854
      Top = 61
      Width = 89
      HelpContext = 455055
      Font.Height = -12
      TabOrder = 27
      ExplicitLeft = 854
      ExplicitTop = 61
      ExplicitWidth = 89
    end
    object txtShipTo: TDBMemo [43]
      Left = 593
      Top = 103
      Width = 258
      Height = 68
      HelpContext = 455091
      DataField = 'ShipTo'
      DataSource = DSMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      OnDblClick = txtShipToDblClick
      OnEnter = txtShipToEnter
      OnExit = txtShipToExit
    end
    object cboETADate: TwwDBDateTimePicker [44]
      Left = 8
      Top = 214
      Width = 102
      Height = 23
      HelpContext = 455092
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'ETADate'
      DataSource = DSMaster
      Epoch = 1950
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 17
      OnCloseUp = cboETADateCloseUp
    end
    object cboInvoiceDate: TwwDBDateTimePicker [45]
      Left = 219
      Top = 214
      Width = 102
      Height = 23
      HelpContext = 455093
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'InvoiceDate'
      DataSource = DSMaster
      Epoch = 1950
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 19
      OnChange = cboInvoiceDateChange
      OnEnter = OverrideAccessLevel
      OnExit = cboInvoiceDateExit
    end
    object edtBarcode: TEdit [46]
      Left = 277
      Top = 166
      Width = 147
      Height = 23
      HelpContext = 455094
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      Text = 'edtBarcode'
      OnEnter = edtBarcodeEnter
      OnKeyPress = edtBarcodeKeyPress
    end
    object cmdIncudeLandeCost: TDNMSpeedButton [47]
      Left = 854
      Top = 90
      Width = 89
      Height = 27
      HelpContext = 455095
      Action = actImportCosts
      Anchors = [akTop, akRight]
      Caption = 'Import Costs'
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
      TabOrder = 28
      TabStop = False
      AutoDisableParentOnclick = True
    end
    inherited btnPreview: TDNMSpeedButton
      Left = 854
      Top = 119
      Width = 89
      HelpContext = 455056
      Enabled = False
      Font.Height = -12
      TabOrder = 29
      Visible = False
      ExplicitLeft = 854
      ExplicitTop = 119
      ExplicitWidth = 89
    end
    inherited btnPrint: TDNMSpeedButton
      Left = 854
      Top = 148
      Width = 89
      HelpContext = 455057
      Action = nil
      Font.Height = -12
      TabOrder = 30
      OnClick = btnPrintClick
      ExplicitLeft = 854
      ExplicitTop = 148
      ExplicitWidth = 89
    end
    inherited pnlChooseRpt: TDNMPanel
      Left = 366
      Width = 125
      Height = 21
      HelpContext = 455058
      TabOrder = 7
      ExplicitLeft = 366
      ExplicitWidth = 125
      ExplicitHeight = 21
      inherited chkChooseRpt: TCheckBox
        AlignWithMargins = True
        Left = 4
        Width = 117
        Height = 13
        HelpContext = 455060
        Align = alClient
        ExplicitLeft = 4
        ExplicitWidth = 117
        ExplicitHeight = 13
      end
    end
    inherited btnContacts: TDNMSpeedButton
      Left = 236
      Top = 59
      HelpContext = 455061
      TabOrder = 2
      ExplicitLeft = 236
      ExplicitTop = 59
    end
    inherited cboBaseForeignCurrencyCode: TwwDBLookupCombo
      Left = 271
      Top = 80
      HelpContext = 455063
      DataField = 'ForeignExchangeCode'
      TabOrder = 5
      Visible = True
      AutoDropDown = True
      ExplicitLeft = 271
      ExplicitTop = 80
    end
    inherited edtBaseExchangeRate: TwwDBEdit
      Left = 271
      Top = 120
      HelpContext = 455064
      DataField = 'ForeignExchangeRate'
      TabOrder = 6
      Visible = True
      OnExit = edtBaseExchangeRateExit
      ExplicitLeft = 271
      ExplicitTop = 120
    end
    inherited pnlTitle: TDNMPanel
      Left = 277
      Top = 3
      Width = 307
      Height = 43
      HelpContext = 455066
      Caption = 'Purchase Order'
      TabOrder = 39
      ExplicitLeft = 277
      ExplicitTop = 3
      ExplicitWidth = 307
      ExplicitHeight = 43
      inherited TitleShader: TShader
        Width = 305
        Height = 41
        HelpContext = 455067
        ExplicitWidth = 305
        ExplicitHeight = 41
        inherited TitleLabel: TLabel
          Width = 305
          Height = 41
          HelpContext = 455068
          Caption = 'Purchase Order'
          ExplicitWidth = 304
          ExplicitHeight = 41
        end
      end
    end
    inherited cboClientR: TERPDbLookupCombo
      Left = 8
      Width = 228
      HelpContext = 455127
      Selected.Strings = (
        'Company'#9'45'#9'Company'#9'F')
      TabOrder = 1
      ExplicitLeft = 8
      ExplicitWidth = 228
    end
    inherited cmdFax: TDNMSpeedButton
      Left = 716
      Top = 135
      Width = 43
      HelpContext = 455080
      TabOrder = 36
      Visible = False
      OnClick = cmdFaxClick
      ExplicitLeft = 716
      ExplicitTop = 135
      ExplicitWidth = 43
    end
    inherited cboAreaCode: TwwDBLookupCombo
      Left = 642
      Top = 214
      Width = 102
      HelpContext = 455128
      DataSource = DSMaster
      TabOrder = 23
      ExplicitLeft = 642
      ExplicitTop = 214
      ExplicitWidth = 102
    end
    inherited btnPayments: TDNMSpeedButton
      Left = 588
      Top = 54
      Width = 79
      HelpContext = 455114
      TabOrder = 13
      ExplicitLeft = 588
      ExplicitTop = 54
      ExplicitWidth = 79
    end
    inherited cmdEmail: TDNMSpeedButton
      Left = 667
      Top = 135
      HelpContext = 455079
      TabOrder = 34
      Visible = False
      ExplicitLeft = 667
      ExplicitTop = 135
    end
    inherited btnPDF: TDNMSpeedButton
      Left = 618
      Top = 135
      Width = 43
      HelpContext = 455129
      TabOrder = 35
      Visible = False
      ExplicitLeft = 618
      ExplicitTop = 135
      ExplicitWidth = 43
    end
    inherited btnEdit: TDNMSpeedButton
      Left = 854
      Top = 207
      Width = 43
      Hint = 'Add a new line to a locked Purchase Order'
      HelpContext = 455130
      TabOrder = 32
      Visible = True
      ExplicitLeft = 854
      ExplicitTop = 207
      ExplicitWidth = 43
    end
    object DNMPanel1: TDNMPanel
      Left = 366
      Top = 93
      Width = 125
      Height = 21
      HelpContext = 455096
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      object GroupProducts: TCheckBox
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 117
        Height = 13
        HelpContext = 455098
        Align = alClient
        Caption = 'Group Products'
        TabOrder = 0
      end
    end
    object btndiscount: TDNMSpeedButton
      Left = 900
      Top = 207
      Width = 43
      Height = 27
      HelpContext = 455079
      Anchors = [akTop, akRight]
      Caption = '% Discount'
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
      TabOrder = 33
      AutoDisableParentOnclick = True
      OnClick = btndiscountClick
    end
    object btnfix: TButton
      Left = 228
      Top = 11
      Width = 44
      Height = 25
      HelpContext = 455133
      Caption = 'Round Fix'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
      WordWrap = True
      OnClick = btnfixClick
    end
    object btnCopy: TDNMSpeedButton
      Left = 854
      Top = 177
      Width = 89
      Height = 27
      Hint = 
        'Copy and make another Purchase Order backorder with all the prod' +
        'ucts and Ordered Qty'
      HelpContext = 455134
      Anchors = [akTop, akRight]
      Caption = 'Copy'
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
      TabOrder = 31
      AutoDisableParentOnclick = True
      OnClick = btnCopyClick
    end
    object edtBatch: TEdit
      Left = 430
      Top = 166
      Width = 147
      Height = 23
      HelpContext = 455151
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      Text = 'edtBatch'
      OnKeyPress = edtBatchKeyPress
    end
    object btnPrepayment: TDNMSpeedButton
      Left = 854
      Top = 119
      Width = 89
      Height = 27
      HelpContext = 455154
      Action = actPrepayment
      Anchors = [akTop, akRight]
      Caption = 'Prepayment'
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
      TabOrder = 9
      TabStop = False
      AutoDisableParentOnclick = True
    end
    object dtDueDate: TwwDBDateTimePicker
      Left = 536
      Top = 214
      Width = 102
      Height = 23
      HelpContext = 455155
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      CalendarAttributes.PopupYearOptions.NumberColumns = 4
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
      TabOrder = 22
      UnboundDataType = wwDTEdtDate
      OnEnter = dtDueDateEnter
      OnExit = dtDueDateExit
    end
    object cboEquipment: TERPDbLookupCombo
      Left = 75
      Top = 177
      Width = 191
      Height = 23
      HelpContext = 455148
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'EquipmentName'#9'20'#9'Equipment'#9'F'
        'EquipmentDescription'#9'20'#9'Description'#9'F'
        'Manufacture'#9'25'#9'Manufacture'#9'F'
        'Model'#9'25'#9'Model'#9'F')
      DataField = 'EquipmentName'
      DataSource = DSMaster
      LookupTable = cboEquipmentLookup
      LookupField = 'EquipmentName'
      Options = [loTitles]
      AutoSelect = False
      ParentFont = False
      TabOrder = 4
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      LookupFormClassName = 'TEquipmentListGUI'
      EditFormClassName = 'TfmEquip'
      LookupFormKeyStringFieldName = 'Equipmentname'
      LookupComboType = ctEquipment
      AllowFullListSearchMode = False
      DisableNotInList = False
      AllowMultipleSelectFromList = False
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      LookupIDField = 'EquipmentID'
    end
    object pnlFutureOrder: TDNMPanel
      Left = 366
      Top = 118
      Width = 125
      Height = 25
      HelpContext = 455160
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 40
      TabStop = True
      Transparent = False
      object chkFuturePO: TDBCheckBox
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 117
        Height = 17
        HelpContext = 455162
        TabStop = False
        Align = alClient
        Caption = 'Future Order'
        DataField = 'FuturePO'
        DataSource = DSMaster
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        OnClick = chkFuturePOClick
      end
    end
    object btnPickUpFrom: TDNMSpeedButton
      Left = 833
      Top = 58
      Width = 18
      Height = 19
      HelpContext = 455184
      DisableTransparent = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555500000000
        0555555F7777777775F55500FFFFFFFFF0555577F5FFFFFFF7F550F0FEEEEEEE
        F05557F7F777777757F550F0FFFFFFFFF05557F7F5FFFFFFF7F550F0FEEEEEEE
        F05557F7F777777757F550F0FF777FFFF05557F7F5FFFFFFF7F550F0FEEEEEEE
        F05557F7F777777757F550F0FF7F777FF05557F7F5FFFFFFF7F550F0FEEEEEEE
        F05557F7F777777757F550F0FF77F7FFF05557F7F5FFFFFFF7F550F0FEEEEEEE
        F05557F7F777777757F550F0FFFFFFFFF05557F7FF5F5F5F57F550F00F0F0F0F
        005557F77F7F7F7F77555055070707070555575F7F7F7F7F7F55550507070707
        0555557575757575755555505050505055555557575757575555}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      TabOrder = 41
      AutoDisableParentOnclick = True
      OnClick = btnPickUpFromClick
    end
    object DNMPanel6: TDNMPanel
      Left = 633
      Top = 83
      Width = 218
      Height = 20
      HelpContext = 455160
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 42
      TabStop = True
      Transparent = False
      object chkShipToClass: TDBCheckBox
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 75
        Height = 20
        Hint = 'Choose to Select a Department for Shipment'
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alRight
        Caption = 'Class'
        DataField = 'ShipToClass'
        DataSource = DSMaster
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        OnClick = chkShipToClassClick
      end
      object chkShipToCustomer: TDBCheckBox
        AlignWithMargins = True
        Left = 77
        Top = 0
        Width = 79
        Height = 20
        Hint = 'Choose to Have the Customer/Job Address for Shipment'
        Margins.Left = 1
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alRight
        Caption = 'Customer'
        DataField = 'ShipToCustomer'
        DataSource = DSMaster
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        OnClick = chkShipToCustomerClick
      end
      object chkShipToDefaultAddress: TDBCheckBox
        AlignWithMargins = True
        Left = 158
        Top = 0
        Width = 59
        Height = 20
        Margins.Left = 1
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alRight
        Caption = 'Default '
        DataField = 'ShipToDefaultAddress'
        DataSource = DSMaster
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        OnClick = chkShipToDefaultAddressClick
      end
    end
    object pnlApproved: TDNMPanel
      Left = 496
      Top = 118
      Width = 81
      Height = 25
      HelpContext = 455096
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 43
      object chkApproved: TwwCheckBox
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 73
        Height = 17
        HelpContext = 455132
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = '&Approved'
        DataField = 'Approved'
        DataSource = DSMaster
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = chkApprovedClick
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 295
    Top = 368
  end
  inherited tmrdelay: TTimer
    Left = 330
    Top = 368
  end
  inherited cboViaQry: TERPQuery
    Connection = MyConnection
    Left = 275
    Top = 336
  end
  inherited popSpelling: TPopupMenu
    Left = 508
    Top = 368
  end
  inherited tmrdelayMsg: TTimer
    Left = 188
    Top = 368
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 224
    Top = 368
  end
  inherited DSDetails: TDataSource
    Left = 11
    Top = 368
  end
  inherited DSMaster: TDataSource
    Left = 46
    Top = 368
  end
  inherited lsTDNMSpeedButtonActions: TActionList
    Left = 402
    Top = 368
    object actImportCosts: TAction
      Caption = 'Import Costs'
      HelpContext = 455138
      OnExecute = actImportCostsExecute
    end
    object actPrepayment: TAction
      Caption = 'Prepayment'
      HelpContext = 455159
      OnExecute = actPrepaymentExecute
    end
    object actConvertToAsset: TAction
      Caption = 'Asset'
      HelpContext = 455164
      OnExecute = actConvertToAssetExecute
    end
  end
  inherited popDscntMrkup: TAdvPopupMenu
    Left = 686
    Top = 368
  end
  inherited popMemTrans: TAdvPopupMenu
    Left = 841
    Top = 304
    object mnuSalesOrder: TMenuItem
      Caption = 'Sales Order'
      HelpContext = 455139
      OnClick = mnuSalesOrderClick
    end
    object mnuInvoice: TMenuItem
      Caption = 'Invoice'
      HelpContext = 455140
      OnClick = mnuInvoiceClick
    end
    object mnuCreateReturnAuthority: TMenuItem
      Caption = 'Create Return Authority'
      HelpContext = 455185
      OnClick = mnuCreateReturnAuthorityClick
    end
    object mnuAllocateSerialNumberstoHire: TMenuItem
      Caption = 'Allocate Serial Numbers to Hire'
      HelpContext = 455165
      OnClick = mnuAllocateSerialNumberstoHireClick
    end
  end
  inherited tblMaster: TERPQuery
    BeforeOpen = tblMasterBeforeOpen
    Left = 39
    Top = 336
    inherited tblMasterPurchaseOrderID: TAutoIncField
      AutoGenerateValue = arAutoInc
      Origin = 'tblpurchaseorders.PurchaseOrderID'
    end
    inherited tblMasterGlobalRef: TWideStringField
      Origin = 'tblpurchaseorders.GlobalRef'
    end
    inherited tblMasterPurchaseOrderNumber: TWideStringField
      Alignment = taRightJustify
      Origin = 'tblpurchaseorders.PurchaseOrderNumber'
      OnSetText = tblMasterPurchaseOrderNumberSetText
    end
    inherited tblMasterOriginalNo: TWideStringField
      Origin = 'tblpurchaseorders.OriginalNo'
    end
    inherited tblMasterAccount: TWideStringField
      Origin = 'tblpurchaseorders.Account'
    end
    inherited tblMasterSupplierName: TWideStringField
      Origin = 'tblpurchaseorders.SupplierName'
    end
    inherited tblMasterOrderTo: TWideStringField
      Origin = 'tblpurchaseorders.OrderTo'
    end
    inherited tblMasterShipTo: TWideStringField
      Origin = 'tblpurchaseorders.ShipTo'
    end
    inherited tblMasterTotalTax: TFloatField
      Origin = 'tblpurchaseorders.OrderDate'
    end
    inherited tblMasterTotalAmount: TFloatField
      Origin = 'tblpurchaseorders.TotalTax'
    end
    inherited tblMasterTotalAmountInc: TFloatField
      Origin = 'tblpurchaseorders.TotalAmount'
    end
    inherited tblMasterEmployeeName: TWideStringField
      Origin = 'tblpurchaseorders.TotalAmountInc'
    end
    inherited tblMasterInvoiceNumber: TWideStringField
      Origin = 'tblpurchaseorders.EmployeeID'
      OnChange = tblMasterInvoiceNumberChange
      OnGetText = tblMasterInvoiceNumberGetText
    end
    inherited tblMasterETADate: TDateField
      Origin = 'tblpurchaseorders.RefNo'
    end
    inherited tblMasterDueDate: TDateField
      Origin = 'tblpurchaseorders.ETADate'
    end
    inherited tblMasterComments: TWideStringField
      Origin = 'tblpurchaseorders.DueDate'
    end
    inherited tblMasterSalesComments: TWideStringField
      Origin = 'tblpurchaseorders.Comments'
    end
    inherited tblMasterShipping: TWideStringField
      Origin = 'tblpurchaseorders.SalesComments'
    end
    inherited tblMasterTerms: TWideStringField
      Origin = 'tblpurchaseorders.Shipping'
    end
    inherited tblMasterPrintFlag: TWideStringField
      Origin = 'tblpurchaseorders.Terms'
    end
    inherited tblMasterPaid: TWideStringField
      Origin = 'tblpurchaseorders.PrintedBy'
    end
    inherited tblMasterBalance: TFloatField
      Origin = 'tblpurchaseorders.Paid'
    end
    inherited tblMasterPayment: TFloatField
      Origin = 'tblpurchaseorders.Balance'
    end
    inherited tblMasterApplyFlag: TWideStringField
      Origin = 'tblpurchaseorders.Payment'
    end
    inherited tblMasterAmountDue: TFloatField
      Origin = 'tblpurchaseorders.ApplyFlag'
    end
    inherited tblMasterPayMethod: TIntegerField
      Origin = 'tblpurchaseorders.AmountDue'
    end
    inherited tblMasterIsPO: TWideStringField
      Origin = 'tblpurchaseorders.PayMethod'
    end
    inherited tblMasterIsRA: TWideStringField
      Origin = 'tblpurchaseorders.IsPO'
    end
    inherited tblMasterIsBill: TWideStringField
      Origin = 'tblpurchaseorders.IsRA'
    end
    inherited tblMasterIsCredit: TWideStringField
      Origin = 'tblpurchaseorders.IsBill'
    end
    inherited tblMasterDeleted: TWideStringField
      Origin = 'tblpurchaseorders.IsPOCredit'
    end
    inherited tblMasterCancelled: TWideStringField
      Origin = 'tblpurchaseorders.Deleted'
    end
    inherited tblMasterEditedFlag: TWideStringField
      Origin = 'tblpurchaseorders.Cancelled'
    end
    inherited tblMasterBOID: TWideStringField
      Origin = 'tblpurchaseorders.BOID'
    end
    inherited tblMasterAccountID: TIntegerField
      Origin = 'tblpurchaseorders.AccountID'
    end
    inherited tblMasterClientID: TIntegerField
      Origin = 'tblpurchaseorders.ClientID'
    end
    inherited tblMasterEmployeeID: TIntegerField
      Origin = 'tblpurchaseorders.EmployeeName'
    end
    inherited tblMasterRefNo: TWideStringField
      Origin = 'tblpurchaseorders.InvoiceNumber'
    end
    inherited tblMasterIsPOCredit: TWideStringField
      Origin = 'tblpurchaseorders.IsCheque'
    end
    inherited tblMasterEnteredBy: TWideStringField
      Origin = 'tblpurchaseorders.InvoiceDate'
    end
    inherited tblMasterPrintedBy: TWideStringField
      Origin = 'tblpurchaseorders.PrintFlag'
    end
    inherited tblMasterEnteredAt: TWideStringField
      Origin = 'tblpurchaseorders.EnteredBy'
    end
    inherited tblMasterIsCheque: TWideStringField
      Origin = 'tblpurchaseorders.IsCredit'
    end
    inherited tblMasterInvoiceDate: TDateField
      Origin = 'tblpurchaseorders.EditedFlag'
    end
    inherited tblMasterConNote: TWideStringField
      Origin = 'tblpurchaseorders.EnteredAt'
    end
    inherited tblMasterCustPONumber: TWideStringField
      Origin = 'tblpurchaseorders.ConNote'
    end
    inherited tblMasterLastUpdated: TDateTimeField
      Origin = 'tblpurchaseorders.CustPONumber'
    end
    inherited tblMasterBaseNo: TWideStringField
      Origin = 'tblpurchaseorders.BaseNo'
    end
    inherited tblMasterOrderDate: TDateTimeField
      Origin = 'tblpurchaseorders.ShipToId'
    end
    inherited tblMasterContactID: TLargeintField
      Origin = 'tblpurchaseorders.ExpenseClaimEmployee'
    end
    inherited tblMasterContactName: TWideStringField
      Origin = 'tblpurchaseorders.contactID'
    end
    inherited tblMasterArea: TWideStringField
      Origin = 'tblpurchaseorders.msUpdateSiteCode'
    end
    inherited tblMasterOrderStatus: TWideStringField
      Origin = 'tblpurchaseorders.Area'
      Size = 50
    end
    object tblMasterSeqNo: TIntegerField
      FieldName = 'SeqNo'
      Origin = 'tblpurchaseorders.SeqNo'
    end
    object tblMasterPONum_Seq: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'PONum_Seq'
      Size = 100
      Calculated = True
    end
    object tblMasterForeignExchangeCode: TWideStringField
      FieldName = 'ForeignExchangeCode'
      Origin = 'tblpurchaseorders.LastUpdated'
      OnSetText = FeldSetTextDontAllowNulls
      FixedChar = True
      Size = 3
    end
    object tblMasterForeignExchangeRate: TFloatField
      FieldName = 'ForeignExchangeRate'
      Origin = 'tblpurchaseorders.ForeignExchangeCode'
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblMasterForeignTotalAmount: TFloatField
      FieldName = 'ForeignTotalAmount'
      Origin = 'tblpurchaseorders.ForeignExchangeRate'
      DisplayFormat = '#,###,##0.00'
    end
    object tblMasterForeignPaidAmount: TFloatField
      FieldName = 'ForeignPaidAmount'
      Origin = 'tblpurchaseorders.ForeignTotalAmount'
    end
    object tblMasterForeignBalanceAmount: TFloatField
      FieldName = 'ForeignBalanceAmount'
      Origin = 'tblpurchaseorders.ForeignPaidAmount'
    end
    object tblMastermsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblpurchaseorders.ForeignBalanceAmount'
    end
    object tblMasterApproved: TWideStringField
      FieldName = 'Approved'
      Origin = 'tblpurchaseorders.msTimeStamp'
      FixedChar = True
      Size = 1
    end
    object tblMasterOrgPONumber: TWideStringField
      FieldKind = fkLookup
      FieldName = 'OrgPONumber'
      LookupDataSet = qryPONumber
      LookupKeyFields = 'GlobalREf'
      LookupResultField = 'PurchaseOrderNumber'
      KeyFields = 'OriginalNo'
      Size = 100
      Lookup = True
    end
    object tblMasterExpenseClaimEmployee: TIntegerField
      FieldName = 'ExpenseClaimEmployee'
      Origin = 'tblpurchaseorders.APNotes'
    end
    object tblMasterSalesglobalref: TWideStringField
      FieldName = 'Salesglobalref'
      Origin = 'tblpurchaseorders.ContactName'
      Size = 255
    end
    object tblMasterShipToCustomer: TWideStringField
      FieldName = 'ShipToCustomer'
      Origin = 'tblpurchaseorders.SalesGlobalref'
      Size = 1
    end
    object tblMasterTotalDiscount: TFloatField
      FieldName = 'TotalDiscount'
      Origin = 'tblpurchaseorders.RARef'
    end
    object tblMasterEquipmentId: TIntegerField
      FieldName = 'EquipmentId'
      Origin = 'tblpurchaseorders.OrderStatus'
    end
    object tblMasterEquipmentName: TWideStringField
      FieldName = 'EquipmentName'
      Origin = 'tblpurchaseorders.EquipmentId'
      Size = 100
    end
    object tblMasterShipToId: TIntegerField
      FieldName = 'ShipToId'
    end
    object tblMasterPickUpfromID: TIntegerField
      FieldName = 'PickUpfromID'
    end
    object tblMasterShiptoClassID: TIntegerField
      FieldName = 'ShiptoClassID'
    end
    object tblMastermsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object tblMasterFuturePO: TWideStringField
      FieldName = 'FuturePO'
      FixedChar = True
      Size = 1
    end
    object tblMasterLinkPOref: TWideStringField
      FieldName = 'LinkPOref'
      Size = 255
    end
    object tblMasterPickupFromDesc: TWideStringField
      FieldName = 'PickupFromDesc'
      Size = 255
    end
    object tblMasterShipToDefaultAddress: TWideStringField
      FieldName = 'ShipToDefaultAddress'
      Size = 1
    end
    object tblMasterShipToClass: TWideStringField
      FieldName = 'ShipToClass'
      Size = 1
    end
    object tblMasterApproverID: TIntegerField
      FieldName = 'ApproverID'
    end
    object tblMasterSOApprovedBy: TIntegerField
      FieldName = 'SOApprovedBy'
    end
    object tblMasterCreatedFromSO: TIntegerField
      FieldName = 'CreatedFromSO'
    end
    object tblMasterIsRefundCheque: TWideStringField
      FieldName = 'IsRefundCheque'
      FixedChar = True
      Size = 1
    end
    object tblMasterRefundGlobalref: TWideStringField
      FieldName = 'RefundGlobalref'
      Size = 255
    end
    object tblMasterAPNotes: TWideMemoField
      FieldName = 'APNotes'
      BlobType = ftWideMemo
    end
    object tblMasterRARef: TWideStringField
      FieldName = 'RARef'
      Size = 255
    end
    object tblMasterSaleLineRef: TWideStringField
      FieldName = 'SaleLineRef'
      Size = 255
    end
    object tblMasterSignature: TBlobField
      FieldName = 'Signature'
    end
    object tblMasterSignatureTime: TDateTimeField
      FieldName = 'SignatureTime'
    end
    object tblMasterContractorPayment: TWideStringField
      FieldName = 'ContractorPayment'
      FixedChar = True
      Size = 1
    end
  end
  inherited tblDetails: TERPQuery
    SQL.Strings = (
      
        'SELECT tblpurchaselines.*, tblpurchaselines.RepairId as OldRepai' +
        'rId from tblPurchaseLines'
      'Where PurchaseOrderID = :ID')
    AutoCalcFields = False
    AfterClose = tblDetailsAfterClose
    AfterInsert = tblDetailsAfterInsert
    AfterScroll = tblDetailsAfterScroll
    Left = 10
    Top = 336
    inherited tblDetailsProductName: TWideStringField
      DisplayLabel = 'Product'
      Origin = 'tblpurchaselines.ProductName'
    end
    object tblDetailsOriginalQtyOrdered: TFloatField [7]
      DisplayLabel = 'Orig Qty'
      DisplayWidth = 7
      FieldKind = fkCalculated
      FieldName = 'OriginalQtyOrdered'
      Calculated = True
    end
    inherited tblDetailsSpecDescription: TWideStringField [11]
      DisplayWidth = 7
      Origin = 'tblpurchaselines.SpecDescription'
    end
    inherited tblDetailsSpecValue: TFloatField [12]
      DisplayWidth = 7
      Origin = 'tblpurchaselines.SpecValue'
    end
    inherited tblDetailsReceivedDate: TDateTimeField [13]
      DisplayLabel = 'Received Date'
      Origin = 'tblpurchaselines.ReceivedDate'
    end
    inherited tblDetailsProduct_Description: TWideStringField [14]
      DisplayWidth = 35
      Origin = 'tblpurchaselines.Product_Description'
      Visible = True
    end
    object tblDetailsCostCentreName: TWideStringField [15]
      DisplayLabel = 'Cost Centre Name'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'CostCentreName'
      LookupDataSet = qryCostCentre
      LookupKeyFields = 'CostCentreID'
      LookupResultField = 'CostCentreName'
      KeyFields = 'CostCentreId'
      Lookup = True
    end
    inherited tblDetailsLineCost: TFloatField [16]
      Origin = 'tblpurchaselines.LineCost'
      DisplayFormat = '$,##0.00###;($,##0.00###)'
      EditFormat = '#0.00###'
    end
    inherited tblDetailsLineTaxCode: TWideStringField [17]
      Origin = 'tblpurchaselines.LineTaxCode'
    end
    inherited tblDetailsLineTax: TFloatField [18]
      Origin = 'tblpurchaselines.LineTax'
      DisplayFormat = '$,##0.00###;($,##0.00###)'
    end
    inherited tblDetailsTotalLineAmountInc: TFloatField [19]
      Origin = 'tblpurchaselines.TotalLineAmountInc'
      DisplayFormat = '$,##0.00;($,##0.00)'
      EditFormat = '#0.00'
    end
    object tblDetailsForeignTotalLineAmount: TFloatField [20]
      DisplayLabel = 'Foreign Total'
      DisplayWidth = 10
      FieldName = 'ForeignTotalLineAmount'
      Origin = 'tblpurchaselines.ForeignTotalLineAmount'
      OnSetText = tblDetailsForeignTotalLineAmountSetText
      DisplayFormat = ',##0.00;(,##0.00)'
    end
    inherited tblDetailsETADate: TDateField [21]
      Origin = 'tblpurchaselines.ETADate'
    end
    inherited tblDetailsCustomField1: TWideStringCustField [22]
      DisplayWidth = 10
      Origin = 'tblpurchaselines.CustomField1'
    end
    inherited tblDetailsCustomField2: TWideStringCustField [23]
      DisplayWidth = 10
      Origin = 'tblpurchaselines.CustomField2'
    end
    inherited tblDetailsCustomField3: TWideStringCustField [24]
      DisplayWidth = 10
      Origin = 'tblpurchaselines.CustomField3'
    end
    inherited tblDetailsCustomField4: TWideStringCustField [25]
      DisplayWidth = 10
      Origin = 'tblpurchaselines.CustomField4'
    end
    inherited tblDetailsCustomField5: TWideStringCustField [26]
      DisplayWidth = 10
      Origin = 'tblpurchaselines.CustomField5'
    end
    inherited tblDetailsCustomField6: TWideStringCustField [27]
      DisplayWidth = 10
      Origin = 'tblpurchaselines.CustomField6'
    end
    inherited tblDetailsCustomField7: TWideStringCustField [28]
      DisplayWidth = 10
      Origin = 'tblpurchaselines.CustomField7'
    end
    inherited tblDetailsCustomField8: TWideStringCustField [29]
      DisplayWidth = 10
      Origin = 'tblpurchaselines.CustomField8'
    end
    inherited tblDetailsCustomField9: TWideStringCustField [30]
      DisplayWidth = 10
      Origin = 'tblpurchaselines.CustomField9'
    end
    inherited tblDetailsCustomField10: TWideStringCustField [31]
      DisplayWidth = 10
      Origin = 'tblpurchaselines.CustomField10'
    end
    object tblDetailsLineNotes: TWideMemoField [32]
      DisplayLabel = 'Line Notes'
      DisplayWidth = 10
      FieldName = 'LineNotes'
      Origin = 'tblpurchaselines.LineNotes'
      BlobType = ftWideMemo
    end
    inherited tblDetailsForeignExchangeCode: TWideStringField [33]
      DisplayLabel = 'Foreign Exchange Code'
      Origin = 'tblpurchaselines.ForeignExchangeCode'
      Visible = True
      OnChange = tblDetailsForeignExchangeCodeChange
    end
    inherited tblDetailsLandedCostsPerItem: TFloatField [34]
      Origin = 'tblpurchaselines.LandedCostsPerItem'
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    inherited tblDetailsLandedCostsTotal: TFloatField [35]
      DisplayLabel = 'Landed Costs Total'
      Origin = 'tblpurchaselines.LandedCostsTotal'
      Visible = True
      DisplayFormat = '$,##0.00;($,##0.00)'
    end
    inherited tblDetailsMemoLine: TWideMemoField [36]
      Origin = 'tblpurchaselines.MemoLine'
    end
    object tblDetailsShipContainerName: TWideStringField [37]
      DisplayLabel = 'Ship Container'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'ShipContainerName'
      LookupDataSet = qryShipContainerLookup
      LookupKeyFields = 'PurchaseLineID'
      LookupResultField = 'ContainerName'
      KeyFields = 'PurchaseLineID'
      Size = 255
      Lookup = True
    end
    object tblDetailsShipContainerETA: TDateField [38]
      DisplayLabel = 'Ship Container ETA'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'ShipContainerETA'
      LookupDataSet = qryShipContainerLookup
      LookupKeyFields = 'PurchaseLineID'
      LookupResultField = 'ETA'
      KeyFields = 'PurchaseLineID'
      ReadOnly = True
      Lookup = True
    end
    inherited tblDetailsEquipmentName: TWideStringField [39]
      DisplayWidth = 30
      Origin = 'tblpurchaselines.EquipmentName'
    end
    inherited tblDetailsLandedCostsPercentage: TFloatField [40]
      DisplayLabel = 'Landed Costs %'
      Origin = 'tblpurchaselines.LandedCostsPercentage'
      OnSetText = FeldSetTextDontAllowNulls
    end
    inherited tblDetailsSupplierProductCode: TWideStringField [41]
      Origin = 'tblpurchaselines.SupplierProductCode'
    end
    inherited tblDetailsSupplierProductName: TWideStringField [42]
      Origin = 'tblpurchaselines.SupplierProductName'
    end
    object tblDetailsProcTreeId: TIntegerField [43]
      DisplayWidth = 10
      FieldName = 'ProcTreeId'
      Origin = 'tblpurchaselines.ProcTreeId'
    end
    inherited tblDetailsTotalLineLandedCost: TFloatField [44]
    end
    object tblDetailsPrintedValue: TFloatField [45]
      DisplayLabel = 'Printed Value'
      DisplayWidth = 10
      FieldName = 'PrintedValue'
      Origin = 'tblpurchaselines.PrintedValue'
    end
    object tblDetailsDiscountPercent: TFloatField [46]
      DisplayLabel = 'Discount %'
      DisplayWidth = 10
      FieldName = 'DiscountPercent'
      Origin = 'tblpurchaselines.DiscountPercent'
    end
    object tblDetailsOriginalCost: TFloatField [47]
      DisplayWidth = 10
      FieldName = 'OriginalCost'
      Origin = 'tblpurchaselines.OriginalCost'
    end
    object tblDetailscOriginalCost: TFloatField [48]
      DisplayLabel = 'Original Cost'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'cOriginalCost'
      Calculated = True
    end
    inherited tblDetailsLineCostInc: TFloatField [49]
      Origin = 'tblpurchaselines.LineCostInc'
      Visible = True
      DisplayFormat = '$,##0.00###;($,##0.00###)'
      EditFormat = '#0.00###'
    end
    inherited tblDetailsPartBarcode: TWideStringField [50]
      DisplayLabel = 'Product Barcode'
      DisplayWidth = 10
      Origin = 'tblpurchaselines.PartBarcode'
    end
    inherited tblDetailsUOM_Height: TFloatField [51]
    end
    inherited tblDetailsUOM_Width: TFloatField [52]
    end
    inherited tblDetailsUOM_Length: TFloatField [53]
    end
    inherited tblDetailsUOM_Weight: TFloatField [54]
    end
    inherited tblDetailsTotalUOM_WeightSold: TFloatField [55]
    end
    inherited tblDetailsTotalUOM_WeightShipped: TFloatField [56]
    end
    inherited tblDetailsTotalUOM_WeightBO: TFloatField [57]
    end
    inherited tblDetailsUOM_Volume: TFloatField [58]
    end
    inherited tblDetailsRepairDocNo: TStringField [59]
    end
    object tblDetailsSmartOrderID: TIntegerField [60]
      DisplayWidth = 10
      FieldName = 'SmartOrderID'
      Origin = 'tblpurchaselines.SmartOrderID'
    end
    object tblDetailsSmartOrderLineID: TIntegerField [61]
      DisplayWidth = 10
      FieldName = 'SmartOrderLineID'
      Origin = 'tblpurchaselines.SmartOrderLineID'
    end
    inherited tblDetailsProduct_custFld10: TWideStringField [62]
    end
    inherited tblDetailsProduct_custFld11: TWideStringField [63]
    end
    inherited tblDetailsProduct_custFld12: TWideStringField [64]
    end
    inherited tblDetailsProduct_custFld13: TWideStringField [65]
    end
    inherited tblDetailsProduct_custFld14: TWideStringField [66]
    end
    inherited tblDetailsProduct_custFld15: TWideStringField [67]
    end
    inherited tblDetailsProduct_custDate1: TDateTimeField [68]
    end
    inherited tblDetailsProduct_custDate2: TDateTimeField [69]
    end
    inherited tblDetailsProduct_custDate3: TDateTimeField [70]
    end
    inherited tblDetailsClass: TWideStringField [71]
      DisplayLabel = 'Department'
      DisplayWidth = 9
      Origin = 'tblpurchaselines.Class'
    end
    inherited tblDetailsUnitofMeasurePOLines: TWideStringField [72]
      DisplayWidth = 9
      Origin = 'tblpurchaselines.UnitofMeasurePOLines'
    end
    inherited tblDetailsUnitofMeasureQtySold: TFloatField [73]
      DisplayWidth = 7
      Origin = 'tblpurchaselines.UnitofMeasureQtySold'
    end
    inherited tblDetailsUnitofMeasureShipped: TFloatField [74]
      DisplayWidth = 7
      Origin = 'tblpurchaselines.UnitofMeasureShipped'
    end
    inherited tblDetailsPQA: TWideStringField [75]
    end
    inherited tblDetailsUnitofMeasureBackorder: TFloatField [76]
      DisplayWidth = 7
      Origin = 'tblpurchaselines.UnitofMeasureBackorder'
      DisplayFormat = ''
    end
    inherited tblDetailsAttrib1Purchase: TFloatField [77]
      DisplayWidth = 7
      Origin = 'tblpurchaselines.Attrib1Purchase'
    end
    inherited tblDetailsAttrib2Purchase: TFloatField [78]
      DisplayWidth = 7
      Origin = 'tblpurchaselines.Attrib2Purchase'
    end
    inherited tblDetailsForeignCurrencyLineCost: TFloatField [79]
      Origin = 'tblpurchaselines.ForeignCurrencyLineCost'
      OnChange = tblDetailsForeignCurrencyLineCostChange
      DisplayFormat = ',##0.00###;(,##0.00###)'
      EditFormat = '#0.00###'
    end
    inherited tblDetailsAttrib1PurchaseRate: TFloatField [80]
      DisplayWidth = 7
      Origin = 'tblpurchaselines.Attrib1PurchaseRate'
    end
    inherited tblDetailsFormulaQtySoldValue: TFloatField [81]
      Origin = 'tblpurchaselines.FormulaQtySoldValue'
    end
    inherited tblDetailsFormulaQtyShippedValue2: TFloatField [82]
      Origin = 'tblpurchaselines.FormulaQtyShippedValue2'
    end
    inherited tblDetailsFormulaQtySoldValue3: TFloatField [83]
      Origin = 'tblpurchaselines.FormulaQtySoldValue3'
    end
    inherited tblDetailsFormulaQtyShippedValue: TFloatField [84]
      Origin = 'tblpurchaselines.FormulaQtyShippedValue'
    end
    inherited tblDetailsFormulaQtySoldValue4: TFloatField [85]
      Origin = 'tblpurchaselines.FormulaQtySoldValue4'
    end
    inherited tblDetailsAttrib1PurchaseEst: TFloatField [86]
      Origin = 'tblpurchaselines.Attrib1PurchaseEst'
    end
    inherited tblDetailsFormulaQtyShippedValue3: TFloatField [87]
      Origin = 'tblpurchaselines.FormulaQtyShippedValue3'
    end
    inherited tblDetailsFormulaQtySoldValue1: TFloatField [88]
      Origin = 'tblpurchaselines.FormulaQtySoldValue1'
    end
    inherited tblDetailsAreaCode: TWideStringField [89]
      Origin = 'tblpurchaselines.AreaCode'
    end
    inherited tblDetailsAttrib2PurchaseEst: TFloatField [90]
      Origin = 'tblpurchaselines.Attrib2PurchaseEst'
    end
    inherited tblDetailsFormulaQtyShippedValue1: TFloatField [91]
      Origin = 'tblpurchaselines.FormulaQtyShippedValue1'
    end
    inherited tblDetailsFormulaQtySoldValue2: TFloatField [92]
      Origin = 'tblpurchaselines.FormulaQtySoldValue2'
    end
    inherited tblDetailsLinesOrder: TIntegerField [93]
      Origin = 'tblpurchaselines.LinesOrder'
    end
    inherited tblDetailsTotalUOM_LengthSold: TFloatField [94]
    end
    inherited tblDetailsEmployeeName: TWideStringField [95]
      DisplayLabel = 'Employee'
      DisplayWidth = 20
      Origin = 'tblpurchaselines.EmployeeName'
    end
    inherited tblDetailsTotalUOM_LengthShipped: TFloatField [96]
    end
    inherited tblDetailsTotalUOM_LengthBO: TFloatField [97]
    end
    object tblDetailsStandardCost: TFloatField [98]
      DisplayLabel = 'Standard Cost'
      DisplayWidth = 10
      FieldName = 'StandardCost'
      Origin = 'tblpurchaselines.StandardCost'
      currency = True
    end
    inherited tblDetailsFormulaQtySoldValue5: TFloatField [99]
      Origin = 'tblpurchaselines.FormulaQtySoldValue5'
    end
    inherited tblDetailsFormulaQtyShippedValue5: TFloatField [100]
      Origin = 'tblpurchaselines.FormulaQtyShippedValue5'
    end
    inherited tblDetailsFormulaQtyShippedValue4: TFloatField [101]
      Origin = 'tblpurchaselines.FormulaQtyShippedValue4'
    end
    object tblDetailsSellPrice: TFloatField [102]
      DisplayLabel = 'Sell Price'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'SellPrice'
      LookupDataSet = QryProductsellPrice
      LookupKeyFields = 'PARTSID'
      LookupResultField = 'price1'
      KeyFields = 'productid'
      DisplayFormat = '$#######0.00'
      Lookup = True
    end
    object tblDetailsBoxesReceived: TIntegerField [103]
      DisplayLabel = 'Boxes Received'
      DisplayWidth = 10
      FieldName = 'BoxesReceived'
    end
    object tblDetailsBoxesOrdered: TIntegerField [104]
      DisplayWidth = 10
      FieldName = 'BoxesOrdered'
    end
    inherited tblDetailsProductPrintName: TWideStringField [105]
    end
    inherited tblDetailsForeignUOMLineCost: TFloatField [106]
    end
    object tblDetailsLineDescription: TWideStringField [107]
      DisplayLabel = 'Change Desc After Approval'
      DisplayWidth = 20
      FieldName = 'LineDescription'
    end
    object tblDetailsGeneralNotes: TWideMemoField [108]
      DisplayLabel = 'Product General Notes'
      DisplayWidth = 20
      FieldName = 'GeneralNotes'
      BlobType = ftWideMemo
    end
    object tblDetailsDocketNumber: TWideStringField [109]
      DisplayLabel = 'Docket Number'
      DisplayWidth = 10
      FieldName = 'DocketNumber'
      Origin = 'tblpurchaselines.DocketNumber'
      Size = 255
    end
    object tblDetailsSaleLineID: TIntegerField [110]
      DisplayWidth = 10
      FieldName = 'SaleLineID'
      Origin = 'tblpurchaselines.SaleLineID'
    end
    inherited tblDetailsCogsAccnt: TWideStringField [111]
      Origin = 'tblpurchaselines.COGSACCNT'
    end
    inherited tblDetailsSortID: TIntegerField [112]
      Origin = 'tblpurchaselines.SortID'
      Visible = False
    end
    inherited tblDetailsUnitofMeasureMultiplier: TFloatField [113]
      Origin = 'tblpurchaselines.UnitofMeasureMultiplier'
    end
    inherited tblDetailsClassID: TIntegerField [114]
      Origin = 'tblpurchaselines.ClassID'
    end
    inherited tblDetailsRAInvoiceNo: TWideStringField [115]
      Origin = 'tblpurchaselines.RAInvoiceNo'
    end
    inherited tblDetailsDeleted: TWideStringField [116]
      Origin = 'tblpurchaselines.Deleted'
    end
    inherited tblDetailsForeignExchangeRate: TFloatField [117]
      Origin = 'tblpurchaselines.ForeignExchangeRate'
    end
    inherited tblDetailsTimecostMarkupDol: TFloatField [118]
      Origin = 'tblpurchaselines.TimecostMarkupDol'
    end
    inherited tblDetailsSaleID_Timecost: TIntegerField [119]
      Origin = 'tblpurchaselines.SaleID_Timecost'
    end
    inherited tblDetailsUseTimecost: TWideStringField [120]
      Origin = 'tblpurchaselines.UseTimecost'
    end
    inherited tblDetailsRAQty: TFloatField [121]
      Origin = 'tblpurchaselines.RAQty'
    end
    inherited tblDetailsShipped: TFloatField [122]
      Origin = 'tblpurchaselines.Shipped'
    end
    inherited tblDetailsAccountNumber: TWideStringField [123]
      Origin = 'tblpurchaselines.AccountNumber'
      Visible = False
    end
    inherited tblDetailsBackOrder: TFloatField [124]
      Origin = 'tblpurchaselines.BackOrder'
    end
    inherited tblDetailsSearchFilter: TWideStringField [125]
      Origin = 'tblpurchaselines.SearchFilter'
    end
    inherited tblDetailsSearchFilterCopy: TWideStringField [126]
      Origin = 'tblpurchaselines.SearchFilterCopy'
    end
    object tblDetailsCostCentreId: TIntegerField [127]
      DisplayWidth = 10
      FieldName = 'CostCentreId'
      Origin = 'tblpurchaselines.CostCentreId'
      Visible = False
      OnSetText = tblDetailsCostCentreIdSetText
    end
    object tblDetailsSEQNo: TIntegerField [128]
      DisplayWidth = 10
      FieldName = 'SEQNo'
      Origin = 'tblpurchaselines.SEQNo'
      Visible = False
    end
    object tblDetailsNewForeignExchangeRate: TFloatField [129]
      DisplayWidth = 10
      FieldName = 'NewForeignExchangeRate'
      Origin = 'tblpurchaselines.NewForeignExchangeRate'
      Visible = False
    end
    inherited tblDetailsProductID: TIntegerField [130]
      Origin = 'tblpurchaselines.ProductID'
    end
    inherited tblDetailsPartType: TWideStringField [131]
      Origin = 'tblpurchaselines.PARTTYPE'
    end
    inherited tblDetailsEditedFlag: TWideStringField [132]
      Origin = 'tblpurchaselines.EditedFlag'
    end
    inherited tblDetailsAccountGroup: TWideStringField [133]
      Origin = 'tblpurchaselines.AccountGroup'
    end
    inherited tblDetailsCalcTotalInc: TCurrencyField [134]
      DisplayFormat = ''
    end
    inherited tblDetailsProductGroup: TWideStringField [135]
      Origin = 'tblpurchaselines.ProductGroup'
    end
    inherited tblDetailsCalcTotalEx: TCurrencyField [136]
      DisplayFormat = ''
    end
    inherited tblDetailsLineTaxRate: TFloatField [137]
      Origin = 'tblpurchaselines.LineTaxRate'
    end
    inherited tblDetailsCalcTax: TCurrencyField [138]
      DisplayFormat = ''
    end
    inherited tblDetailsPurchaseLineID: TAutoIncField [139]
      AutoGenerateValue = arAutoInc
      Origin = 'tblpurchaselines.PurchaseLineID'
    end
    inherited tblDetailsCalcBackOrder: TFloatField [140]
    end
    inherited tblDetailsInvoiced: TWideStringField [141]
      Origin = 'tblpurchaselines.Invoiced'
    end
    inherited tblDetailsCOGSTotalLineAmount: TFloatField [142]
      Origin = 'tblpurchaselines.COGSTotalLineAmount'
      DisplayFormat = '$,##0.00;($,##0.00)'
    end
    inherited tblDetailsCustomerJob: TWideStringField [143]
      Origin = 'tblpurchaselines.CustomerJob'
    end
    inherited tblDetailsAvgCost: TFloatField [144]
      Origin = 'tblpurchaselines.AvgCost'
      DisplayFormat = '$,##0.00###;($,##0.00###)'
    end
    inherited tblDetailsRepairId: TIntegerField [145]
      DisplayLabel = 'Repair #'
      Origin = 'tblpurchaselines.RepairId'
    end
    inherited tblDetailsUnitOfMeasureID: TIntegerField [146]
      Origin = 'tblpurchaselines.UnitOfMeasureID'
      Visible = False
    end
    inherited tblDetailsCustomerJobID: TIntegerField [147]
      Origin = 'tblpurchaselines.CustomerJobID'
    end
    inherited tblDetailsTimecostMarkupPer: TFloatField [148]
      Origin = 'tblpurchaselines.TimecostMarkupPer'
    end
    inherited tblDetailsCOGSTotalLineAmountInc: TFloatField [149]
      Origin = 'tblpurchaselines.COGSTotalLineAmountInc'
      DisplayFormat = '$,##0.00;($,##0.00)'
    end
    inherited tblDetailsRelatedPOID: TIntegerField [150]
      Origin = 'tblpurchaselines.RelatedPOID'
    end
    inherited tblDetailsAssetAccnt: TWideStringField [151]
      Origin = 'tblpurchaselines.ASSETACCNT'
    end
    object tblDetailsBaseLineno: TIntegerField [152]
      DisplayWidth = 10
      FieldName = 'BaseLineno'
      Origin = 'tblpurchaselines.BaseLineno'
      Visible = False
    end
    object tblDetailsmsTimeStamp: TDateTimeField [153]
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblpurchaselines.msTimeStamp'
      Visible = False
    end
    object tblDetailsINCOMEACCNTID: TIntegerField [154]
      DisplayWidth = 10
      FieldName = 'INCOMEACCNTID'
      Origin = 'tblpurchaselines.INCOMEACCNTID'
      Visible = False
    end
    object tblDetailsASSETACCNTID: TIntegerField [155]
      DisplayWidth = 10
      FieldName = 'ASSETACCNTID'
      Origin = 'tblpurchaselines.ASSETACCNTID'
      Visible = False
    end
    object tblDetailsCOGSACCNTID: TIntegerField [156]
      DisplayWidth = 10
      FieldName = 'COGSACCNTID'
      Origin = 'tblpurchaselines.COGSACCNTID'
      Visible = False
    end
    inherited tblDetailsAccountName: TWideStringField [157]
      Origin = 'tblpurchaselines.AccountName'
    end
    inherited tblDetailsTotalLineAmount: TFloatField [158]
      Origin = 'tblpurchaselines.TotalLineAmount'
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '$###,###,###,##0.00'
      EditFormat = '#0.00'
    end
    object tblDetailsDiscountAmount: TFloatField [159]
      DisplayWidth = 10
      FieldName = 'DiscountAmount'
      Origin = 'tblpurchaselines.DiscountAmount'
      Visible = False
    end
    inherited tblDetailsPartSpecID: TIntegerField [160]
      Origin = 'tblpurchaselines.PartSpecID'
    end
    inherited tblDetailsserialno: TWideMemoField [161]
      Origin = 'tblpurchaselines.serialno'
    end
    inherited tblDetailsCustomerEquipmentID: TIntegerField [162]
      Origin = 'tblpurchaselines.CustomerEquipmentID'
    end
    inherited tblDetailsMatrixDesc: TWideMemoField [163]
      DisplayLabel = 'Matrix Desc'
      Origin = 'tblpurchaselines.MatrixDesc'
    end
    inherited tblDetailsMatrixRef: TWideMemoField [164]
      DisplayLabel = 'Matrix Ref'
      Origin = 'tblpurchaselines.MatrixRef'
    end
    inherited tblDetailsMatrixPrice: TFloatField [165]
      DisplayLabel = 'Matrix Price'
      Origin = 'tblpurchaselines.MatrixPrice'
    end
    inherited tblDetailsEmployeeID: TIntegerField [166]
      Origin = 'tblpurchaselines.EmployeeID'
      Visible = False
    end
    inherited tblDetailsGlobalRef: TWideStringField [167]
      Origin = 'tblpurchaselines.GlobalRef'
    end
    inherited tblDetailsPurchaseOrderID: TIntegerField [168]
      Origin = 'tblpurchaselines.PurchaseOrderID'
    end
    inherited tblDetailsQtySold: TFloatField [169]
      Origin = 'tblpurchaselines.QtySold'
    end
    inherited tblDetailsBatch: TWideStringField [170]
      Origin = 'tblpurchaselines.Batch'
    end
    inherited tblDetailsRAstatus: TWideStringField [171]
      Origin = 'tblpurchaselines.RAstatus'
    end
    inherited tblDetailsIncomeAccnt: TWideStringField [172]
      Origin = 'tblpurchaselines.INCOMEACCNT'
    end
    inherited tblDetailsRelatedPOIDUsed: TWideStringField [173]
      Origin = 'tblpurchaselines.RelatedPOIDUsed'
    end
    inherited tblDetailsLastLineID: TIntegerField [174]
      Origin = 'tblpurchaselines.LastLineID'
    end
    inherited tblDetailsCalcCostInc: TCurrencyField [175]
      DisplayFormat = ''
    end
    inherited tblDetailsTimecostPrice: TFloatField [176]
      Origin = 'tblpurchaselines.TimecostPrice'
    end
    object tblDetailsPackWeightField1: TFloatField [177]
      FieldKind = fkLookup
      FieldName = 'PackWeightField1'
      LookupDataSet = QryPurchaseLinePackWeightLinesSum
      LookupKeyFields = 'PurchaseLineId'
      LookupResultField = 'AttribValue1'
      KeyFields = 'PurchaseLineId'
      Visible = False
      Lookup = True
    end
    object tblDetailsPackWeightfield2: TFloatField [178]
      FieldKind = fkLookup
      FieldName = 'PackWeightfield2'
      LookupDataSet = QryPurchaseLinePackWeightLinesSum
      LookupKeyFields = 'PurchaseLineId'
      LookupResultField = 'AttribValue2'
      KeyFields = 'PurchaseLineId'
      Visible = False
      Lookup = True
    end
    object tblDetailsPackCount: TFloatField [179]
      FieldKind = fkLookup
      FieldName = 'PackCount'
      LookupDataSet = QryPurchaseLinePackWeightLinesSum
      LookupKeyFields = 'PurchaseLineId'
      LookupResultField = 'Packcount'
      KeyFields = 'PurchaseLineId'
      Visible = False
      Lookup = True
    end
  end
  inherited cboClientLookup: TERPQuery
    SQL.Strings = (
      'SELECT ClientID, Company, '
      'Street, Street2, Street3, Suburb, State, Country, Postcode,'
      
        'BillStreet, BillStreet2, BillStreet3, BillSuburb, BillState, Bil' +
        'lPostcode,BillCountry,'
      'TERMS, TermsID, ShippingMethod, ShippingID, ShipTime, RepID,'
      'ForeignExchangeSellCode'
      'FROM tblclients'
      'WHERE Supplier = '#39'T'#39
      'AND tblclients.ClientID= :xClientID')
    Left = 157
    Top = 336
  end
  inherited cboEmployeeLookup: TERPQuery
    Left = 216
    Top = 336
  end
  inherited cboClassQry: TERPQuery
    SQL.Strings = (
      'SELECT '
      
        'ClassID, ClassName, UseAddress, Street, Street2, Suburb, State, ' +
        'Postcode'
      'FROM tblClass '
      'WHERE (((ClassName) Is Not Null) And (Active<>'#39'F'#39')) '
      'ORDER BY tblClass.ClassName; ')
    Left = 246
    Top = 336
  end
  inherited qryBaseForeignCurrency: TERPQuery
    Left = 689
    Top = 336
  end
  inherited qryClientLookup: TERPQuery
    Left = 482
    Top = 336
  end
  inherited cboTermsQry: TERPQuery
    Connection = MyConnection
    Left = 364
    Top = 336
  end
  inherited qryForeignCurrency: TERPQuery
    Connection = MyConnection
    Left = 453
    Top = 336
  end
  inherited qryUnitOfMeasure: TERPQuery
    Left = 867
    Top = 336
  end
  inherited cboAccountQry: TERPQuery
    Left = 305
    Top = 336
  end
  inherited cboProductQry: TERPQuery
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
      'P.GeneralNotes,'
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
    Left = 571
    Top = 336
    object cboProductQryGeneralNotes: TWideMemoField
      FieldName = 'GeneralNotes'
      BlobType = ftWideMemo
    end
  end
  inherited qryCustomerJob: TERPQuery
    SQL.Strings = (
      'SELECT ClientID, Company, JobNumber, DefaultClass,'
      'Street, Street2, Suburb, State, Country, Postcode,'
      'BillStreet, BillStreet2, BillSuburb, BillState, BillPostcode,'
      'TERMS, ShippingMethod, ShippingID, ShipTime'
      'FROM tblclients'
      'WHERE Active = '#39'T'#39' And Customer = '#39'T'#39' '
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and ((Company LIKE Concat(:SearchValue,"%"' +
        ')) or (JobNumber LIKE Concat(:SearchValue,"%")) ))'
      
        'or ((:SearchMode = 2) and ((Company LIKE Concat("%",:SearchValue' +
        ',"%")) or (JobNumber LIKE Concat("%",:SearchValue,"%")) )))'
      'and IfNull(:SearchValue,"") <> ""')
    Left = 541
    Top = 336
  end
  inherited DMTextTargetOrder: TDMTextTarget
    Left = 366
    Top = 368
  end
  inherited qryRepairEquip: TERPQuery
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
      '`CE`.`UOMQty` as Quantity,'
      'CE.UOM,'
      '`CE`.`ClientID`'
      'FROM'
      '`tblEquipmentxRef` AS `RE`'
      'inner join tblrepairs as R on R.RepairID = RE.repairID'
      
        'Inner Join `tblcustomerequip` AS `CE` ON `RE`.`CustomerEquipment' +
        'ID` = `CE`.`id`'
      
        'Inner Join `tblequipment` AS `E` ON `CE`.`EquipmentID` = `E`.`Eq' +
        'uipmentID`'
      
        'Where (RE.RepairID = :RepairID or :RepairID = 0) and (CE.ClientI' +
        'D = :ClientID or :ClientID = 0)'
      'and ifnull(R.done,"F" ) = "F"')
    Left = 423
    Top = 336
    inherited qryRepairEquipRepairID: TIntegerField
      DisplayWidth = 1
    end
    inherited qryRepairEquipSerialno: TWideStringField
      DisplayWidth = 10
    end
    inherited qryRepairEquipQuantity: TFloatField [4]
    end
    inherited qryRepairEquipManufacture: TWideStringField [5]
      DisplayWidth = 10
    end
    inherited qryRepairEquipmodel: TWideStringField [6]
      DisplayWidth = 10
    end
    inherited qryRepairEquipRegistration: TWideStringField [7]
      DisplayWidth = 10
    end
    inherited qryRepairEquipWarantyFinishDate: TDateTimeField [8]
      DisplayWidth = 10
    end
    inherited qryRepairEquipWarantyPeriod: TFloatField [9]
    end
    inherited qryRepairEquipUOM: TWideStringField [10]
      DisplayWidth = 1
      Visible = False
    end
  end
  inherited imgPopup: TImageList
    Left = 153
    Top = 368
    Bitmap = {
      494C010102006C02980510001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryProduct: TERPQuery [35]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      
        'PartsID, Cost1, Price1, Price2, Price3, OnCostIncrease, OnCostDe' +
        'crease'
      'FROM tblparts'
      'WHERE Partsid =:xPartsID;')
    Left = 630
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPartsID'
      end>
  end
  object dsTotals: TDataSource [36]
    Left = 117
    Top = 368
  end
  object qryPartsSpecs: TERPQuery [37]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PartSpecID,SpecDescription '
      'FROM tblpartsspecifications'
      'WHERE IsMultiplier='#39'T'#39' AND PartsID=:xPartsID;')
    Left = 601
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPartsID'
      end>
  end
  object qryPOQuantities: TERPQuery [38]
    Connection = MyConnection
    SQL.Strings = (
      'select POL.ProductId, POL.SeqNo, POL.QtySold '
      'from tblpurchaselines POL inner join tblPurchaseOrders PO on '
      'POL.PurchaseOrderId =  PO.PurchaseOrderId'
      
        'Where  PO.OriginalNo= :xpurchaseOrderId and ifnull(POL.BaseLinen' +
        'o,0)=0')
    Left = 98
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xpurchaseOrderId'
      end>
    object qryPOQuantitiesProductId: TIntegerField
      FieldName = 'ProductId'
    end
    object qryPOQuantitiesSeqNo: TIntegerField
      FieldName = 'SeqNo'
    end
    object qryPOQuantitiesQtySold: TFloatField
      FieldName = 'QtySold'
    end
  end
  object qryPONumber: TERPQuery [39]
    Connection = MyConnection
    SQL.Strings = (
      'select GlobalREf, PurchaseOrderId, PurchaseOrderNumber, BaseNo'
      'from tblPurchaseOrders where GlobalREf = :Originalno;')
    Left = 69
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Originalno'
      end>
    object qryPONumberPurchaseOrderId: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'PurchaseOrderId'
      Origin = 'tblpurchaseorders.PurchaseOrderID'
      ReadOnly = True
    end
    object qryPONumberPurchaseOrderNumber: TWideStringField
      FieldName = 'PurchaseOrderNumber'
      Origin = 'tblpurchaseorders.PurchaseOrderNumber'
      Size = 30
    end
    object qryPONumberGlobalREf: TWideStringField
      FieldName = 'GlobalREf'
      Origin = 'tblpurchaseorders.GlobalRef'
      Size = 255
    end
    object qryPONumberBaseNo: TWideStringField
      FieldName = 'BaseNo'
      Origin = 'tblpurchaseorders.BaseNo'
      Size = 255
    end
  end
  object DataSource1: TDataSource [40]
    DataSet = qryPONumber
    Left = 82
    Top = 368
  end
  object qryShipContainerLookup: TERPQuery [41]
    Connection = MyConnection
    SQL.Strings = (
      '#SELECT ContainerName,PurchaseLineID'
      '#FROM tblshippingcontainer SC'
      
        '#INNER JOIN tblshipcontainerdetails SD ON SC.ShippingContainerID' +
        ' = SD.ShippingContainerID'
      '#GROUP BY ContainerName'
      ''
      
        'SELECT distinct ContainerName,SD.PurchaseLineID,tblpurchaselines' +
        '.SaleLineID,SC.ETA,SC.Active'
      'FROM tblshippingcontainer SC'
      
        'INNER JOIN tblshipcontainerdetails SD ON SC.ShippingContainerID ' +
        '= SD.ShippingContainerID'
      
        'INNER JOIN tblpurchaselines ON SD.PurchaseLineID = tblpurchaseli' +
        'nes.PurchaseLineID'
      'WHERE SC.Active = "T"')
    Left = 660
    Top = 336
  end
  inherited ProgDialog: TProgressDialog
    Left = 757
    Top = 368
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 259
    Top = 368
  end
  inherited MyConnection: TERPConnection
    Database = 'aus_sample_company'
    Connected = True
    Top = 303
  end
  inherited DataState: TDataState
    Left = 473
    Top = 368
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 544
    Top = 368
  end
  inherited popOptions: TAdvPopupMenu
    Left = 721
    Top = 368
    object ProductStatus1: TMenuItem
      Caption = 'Product Status'
      HelpContext = 455141
      OnClick = QuantityAndBinLocations1Click
    end
    object PrintStoreAwaySlip1: TMenuItem
      Caption = 'Print Store Away Slip'
      HelpContext = 455142
      OnClick = PrintStoreAwaySlip1Click
    end
    object N3: TMenuItem
      Caption = '-'
      HelpContext = 455186
    end
    object mnuCopyDocketNumbers: TMenuItem
      Caption = 'Copy Docket Numbers'
      HelpContext = 455187
      OnClick = mnuCopyDocketNumbersClick
    end
    object mnuPasteDocketNumbers: TMenuItem
      Caption = 'Paste Docket Numbers'
      HelpContext = 455188
      OnClick = mnuPasteDocketNumbersClick
    end
    object N4: TMenuItem
      Caption = '-'
      HelpContext = 455189
    end
  end
  inherited qryRepairLookup: TERPQuery
    Left = 719
    Top = 336
    inherited qryRepairLookupRepairDocNo: TWideStringField
      Origin = 'tblrepairs.RepairDocNo'
    end
    inherited qryRepairLookupCustomerName: TWideStringField
      Origin = 'tblrepairs.CustomerName'
    end
    inherited qryRepairLookupRepairID: TIntegerField
      AutoGenerateValue = arAutoInc
      Origin = 'tblrepairs.RepairID'
    end
    inherited qryRepairLookupcusid: TIntegerField
      Origin = 'tblrepairs.CusID'
    end
  end
  inherited qryEmployeeLookup: TERPQuery
    Left = 335
    Top = 336
  end
  inherited QryAreaCodes: TERPQuery
    Left = 748
    Top = 336
  end
  inherited QryTransStatus: TERPQuery
    Left = 807
    Top = 336
  end
  inherited QryAreaCodeLk: TERPQuery
    Left = 778
    Top = 336
  end
  inherited cbTaxCodeQry: TERPQuery
    Left = 512
    Top = 336
  end
  inherited qryMemTrans: TERPQuery
    Connection = MyConnection
    Left = 837
    Top = 336
  end
  inherited SaveDialog1: TSaveDialog
    Left = 827
    Top = 366
  end
  inherited imgsort: TImageList
    Left = 579
    Top = 368
    Bitmap = {
      494C010100005C00880310001000FFFFFFFFFF00FFFFFFFFFFFFFFFF424D3600
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
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000}
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 650
    Top = 368
  end
  inherited QryCustomField: TERPQuery
    Left = 187
    Top = 336
  end
  inherited TmrCommentshint: TTimer
    Left = 437
    Top = 368
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 615
    Top = 368
  end
  inherited tmrOnshow: TTimer
    Left = 528
    Top = 24
  end
  inherited dsFEPOLines: TDataSource
    Left = 797
    Top = 306
  end
  inherited dsFEPOlinesRelatedPrs: TDataSource
    Left = 901
    Top = 378
  end
  inherited tblFEPOlinesRelatedPrs: TERPQuery
    Left = 901
    Top = 322
  end
  object qryPurchaseLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select PurchaseOrderID, GlobalRef from tblpurchaseorders where G' +
        'lobalRef  = :OriginalNo')
    Left = 909
    Top = 331
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'OriginalNo'
      end>
  end
  object cboEquipmentLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'EquipmentName,'
      'EquipmentID,'
      'EquipmentDescription, '
      'ProductID, '
      'Model, '
      'Manufacture'
      'FROM tblequipment'
      ''
      'where  (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and ((EquipmentName LIKE Concat(:SearchVal' +
        'ue,"%"))     Or  (EquipmentDescription LIKE Concat(:SearchValue,' +
        '"%"))      ))'
      
        'or ((:SearchMode = 2) and ((EquipmentName LIKE Concat("%",:Searc' +
        'hValue,"%")) Or  (EquipmentDescription LIKE Concat("%",:SearchVa' +
        'lue,"%"))  )))'
      'and IfNull(:SearchValue,"") <> ""'
      'ORDER BY EquipmentName;')
    Options.LongStrings = False
    Left = 128
    Top = 336
    ParamData = <
      item
        DataType = ftInteger
        Name = 'SearchMode'
      end
      item
        DataType = ftInteger
        Name = 'SearchMode'
      end
      item
        DataType = ftInteger
        Name = 'SearchMode'
      end
      item
        DataType = ftWideString
        Name = 'SearchValue'
      end
      item
        DataType = ftWideString
        Name = 'SearchValue'
      end
      item
        DataType = ftInteger
        Name = 'SearchMode'
      end
      item
        DataType = ftWideString
        Name = 'SearchValue'
      end
      item
        DataType = ftWideString
        Name = 'SearchValue'
      end
      item
        DataType = ftWideString
        Name = 'SearchValue'
      end>
    object cboEquipmentLookupEquipmentName: TWideStringField
      DisplayLabel = 'Equipment Name'
      DisplayWidth = 20
      FieldName = 'EquipmentName'
      Origin = 'tblequipment.EquipmentName'
      Size = 50
    end
    object cboEquipmentLookupEquipmentDescription: TWideStringField
      DisplayWidth = 30
      FieldName = 'EquipmentDescription'
      Origin = 'tblequipment.EquipmentDescription'
      Size = 100
    end
    object cboEquipmentLookupEquipmentID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'EquipmentID'
      Origin = 'tblequipment.EquipmentID'
      Visible = False
    end
    object cboEquipmentLookupProductID: TLargeintField
      FieldName = 'ProductID'
      Origin = 'tblequipment.ProductId'
    end
    object cboEquipmentLookupModel: TWideStringField
      FieldName = 'Model'
      Origin = 'tblequipment.Model'
      Size = 100
    end
    object cboEquipmentLookupManufacture: TWideStringField
      FieldName = 'Manufacture'
      Origin = 'tblequipment.Manufacture'
      Size = 100
    end
  end
  object dsPurchaseLinePackWeightLinesSum: TDataSource
    DataSet = QryPurchaseLinePackWeightLinesSum
    Left = 70
    Top = 306
  end
  object QryPurchaseLinePackWeightLinesSum: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT POL.PurchaseOrderId, POLPW.PurchaseLineId, sum(POLPW.Attr' +
        'ibValue1*Packcount) as AttribValue1 , Sum(POLPW.AttribValue2*Pac' +
        'kcount) as AttribValue2 , sum(Packcount) as Packcount'
      'FROM tblPurchaselinepackweightlines POLPW '
      
        'inner join tblPurchaselines POL on POLPW.PurchaselineId = POL.Pu' +
        'rchaseLineID '
      'Order by PurchaseLineId')
    Left = 70
    Top = 274
    object QryPurchaseLinePackWeightLinesSumPurchaseOrderId: TIntegerField
      FieldName = 'PurchaseOrderId'
    end
    object QryPurchaseLinePackWeightLinesSumPurchaseLineId: TIntegerField
      FieldName = 'PurchaseLineId'
    end
    object QryPurchaseLinePackWeightLinesSumAttribValue1: TFloatField
      FieldName = 'AttribValue1'
    end
    object QryPurchaseLinePackWeightLinesSumAttribValue2: TFloatField
      FieldName = 'AttribValue2'
    end
    object QryPurchaseLinePackWeightLinesSumPackcount: TFloatField
      FieldName = 'Packcount'
    end
  end
  object QryProductsellPrice: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'P.partsId,'
      'P.PRICE1 as PRICE1'
      'FROM `tblParts` P')
    AfterOpen = cboProductQryAfterOpen
    Options.LongStrings = False
    Left = 579
    Top = 304
    object QryProductsellPricepartsId: TIntegerField
      FieldName = 'partsId'
    end
    object QryProductsellPricePRICE1: TFloatField
      FieldName = 'PRICE1'
    end
  end
  object qryCostCentre: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT CostCentreID, CostCentreName, CostCentreDescription '
      'FROM tblCostCentre'
      'WHERE Active = '#39'T'#39
      'Order By CostCentreName;')
    Options.LongStrings = False
    Left = 394
    Top = 336
  end
  object qryPOSeqno: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select Count( * )  as SeqNo from tblpurchaseorders where Origina' +
        'lNo = :OriginalNo'
      'and PurchaseOrderID <= :PurchaseOrderID')
    Left = 920
    Top = 299
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'OriginalNo'
      end
      item
        DataType = ftUnknown
        Name = 'PurchaseOrderID'
      end>
    object qryPOSeqnoSeqNo: TLargeintField
      FieldName = 'SeqNo'
    end
  end
end
