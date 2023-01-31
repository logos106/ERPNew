inherited InvoiceGUI: TInvoiceGUI
  Left = 331
  Top = 93
  HelpContext = 372000
  Caption = 'Invoice'
  ClientHeight = 563
  ClientWidth = 996
  ExplicitLeft = 331
  ExplicitTop = 93
  ExplicitWidth = 1012
  ExplicitHeight = 602
  DesignSize = (
    996
    563)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 413
    Width = 996
    HelpContext = 372119
    ExplicitTop = 414
    ExplicitWidth = 996
  end
  inherited shapehint: TShape
    Left = 12
    ExplicitLeft = 12
  end
  inherited imgGridWatermark: TImage
    Left = 207
    HelpContext = 372001
    ExplicitLeft = 207
  end
  inherited pnlDetail: TDNMPanel
    Top = 265
    Width = 996
    Height = 148
    HelpContext = 372116
    Align = alClient
    ExplicitTop = 265
    ExplicitWidth = 996
    ExplicitHeight = 148
    inherited grdTransactions: TwwDBGrid
      Width = 996
      Height = 132
      HelpContext = 372118
      ControlType.Strings = (
        'ProductName;CustomEdit;cboProductR;F'
        'LineTaxCode;CustomEdit;cboTaxCode;F'
        'UnitofMeasureSaleLines;CustomEdit;cboUnitOfMeasure;F'
        'ForeignExchangeSellCode;CustomEdit;cboForeignCurrencyCode;F'
        'Supplier;CustomEdit;cboSupplier;F'
        'SearchFilter;CustomEdit;txtSearchFilter;T'
        'CostCentreName;CustomEdit;cboCostCentre;F'
        'HireQty;CustomEdit;edtHireQty;T'
        'SpecDescription;CustomEdit;cboPartSpecs;F'
        'SmartOrderCreated;CheckBox;T;F'
        'AutoSmartOrder;CheckBox;T;F'
        'ProviderNum;CustomEdit;cboPrescriber;T'
        'ShipContainerETA;CustomEdit;dtShipContainerETA;T'
        'MemoLine;CustomEdit;edtMemoLine;F'
        'Area;CustomEdit;cboLinesAreaCode;F'
        'RequiresAssembly;CheckBox;T;F'
        'Assembled;CheckBox;T;F')
      Selected.Strings = (
        'SeqNo'#9'6'#9'No'#9'F'#9
        'ProductName'#9'17'#9'Product'#9#9
        'UnitofMeasureSaleLines'#9'10'#9'Units'#9'F'#9
        'UnitofMeasureQtySold'#9'6'#9'Ordered'#9'F'#9
        'UnitofMeasureShipped'#9'6'#9'Shipped'#9'F'#9
        'PQA'#9'1'#9'Allocation'#9'F'#9
        'UnitofMeasureBackorder'#9'6'#9'BO'#9'T'#9
        'Attrib1Sale'#9'6'#9'Metres ?'#9'F'#9
        'Attrib2Sale'#9'6'#9'Weight'#9'F'#9
        'Attrib1SaleRate'#9'10'#9'Metres ? Rate'#9'F'#9
        'SpecDescription'#9'17'#9'Specifications'#9'F'#9
        'SpecValue'#9'10'#9'Spec Qty'#9'F'#9
        'Product_Description'#9'20'#9'Description'#9'F'#9
        'PartBarcode'#9'20'#9'Barcode'#9'F'#9
        'Product_Description_Memo'#9'10'#9'Product Description Memo'#9'F'#9
        'CostCentreName'#9'20'#9'Cost Centre'#9'F'#9
        'LineCostInc'#9'10'#9'Cost (Inc)'#9'F'#9
        'LinePriceInc'#9'10'#9'Price (Inc)'#9'F'#9
        'Discounts'#9'10'#9'Discount ($)'#9'F'#9
        'ForeignCurrencyLinePrice'#9'10'#9'Foreign Amount'#9'F'#9
        'CalcProfit'#9'10'#9'Profit (Inc)'#9'F'#9
        'CalcProfitPercent'#9'7'#9'% Profit (Inc)'#9'F'#9
        'CalcGrossProfitPercentInc'#9'10'#9'Gross % (based on Avg Cost)'#9'T'#9
        'LatestCostPriceInc'#9'10'#9'Latest Cost (Inc)'#9'T'#9
        'LineTaxCode'#9'15'#9'Code'#9'F'#9
        'LineTax'#9'10'#9'Tax (Dbl Click)'#9'F'#9
        'TotalLineAmountInc'#9'14'#9'Amount (Inc)'#9'T'#9
        'Supplier'#9'20'#9'Supplier'#9'F'#9
        'SupplierContact'#9'20'#9'Supplier Contact'#9'F'#9
        'SalesLinesCustField1'#9'20'#9'SalesLinesCustField1'#9'F'#9
        'SalesLinesCustField2'#9'20'#9'SalesLinesCustField2'#9'F'#9
        'SalesLinesCustField3'#9'20'#9'SalesLinesCustField3'#9'F'#9
        'DocketNumber'#9'20'#9'Docket Number'#9'F'#9
        'WarrantyEndsOn'#9'10'#9'Warranty Ends On'#9'F'#9
        'WarrantyPeriod'#9'20'#9'Warranty Period'#9'F'#9
        'SalesLinesCustField4'#9'20'#9'SalesLinesCustField4'#9'F'#9
        'SalesLinesCustField5'#9'20'#9'SalesLinesCustField5'#9'F'#9
        'SalesLinesCustField6'#9'20'#9'SalesLinesCustField6'#9'F'#9
        'SalesLinesCustField7'#9'20'#9'SalesLinesCustField7'#9'F'#9
        'SalesLinesCustField8'#9'20'#9'SalesLinesCustField8'#9'F'#9
        'SalesLinesCustField9'#9'20'#9'SalesLinesCustField9'#9'F'#9
        'SalesLinesCustField10'#9'20'#9'SalesLinesCustField10'#9'F'#9
        'MemoLine'#9'10'#9'MemoLine'#9'F'#9
        'AutoSmartOrder'#9'1'#9'Auto Create Order?'#9'T'#9
        'SmartOrderCreated'#9'1'#9'Ordered?'#9'T'#9
        'ShipDate'#9'18'#9'Ship Date'#9'F'#9
        'BaseLineno'#9'10'#9'BaseLineno'#9'F'#9
        'ShipContainerName'#9'20'#9'Ship Container Name'#9'F'#9
        'ShipContainerETA'#9'10'#9'ShipContainerETA'#9'F'#9
        'Timecostused'#9'1'#9'Timecostused'#9'F'#9
        'ProfitbasedLatestCost'#9'10'#9'GP (based on Latest Cost)'#9'F'#9
        'ProfitbasedLatestCostPercent'#9'10'#9'GP% (based on Latest Cost)'#9'F'#9
        'ProfitbasedLatestCostInc'#9'10'#9'GP(Ex) (based on Latest Cost)'#9'F'#9
        
          'ProfitbasedLatestCostPercentInc'#9'10'#9'GP(Inc)% (based on Latest Cos' +
          't)'#9'F'#9
        
          'GrossProfitbasedLatestCostPercentInc'#9'10'#9'GP% (based on Latest Cos' +
          't)'#9'F'#9
        'UOM_Height'#9'10'#9'UOM_Height'#9'F'#9
        'UOM_Width'#9'10'#9'UOM_Width'#9'F'#9
        'UOM_Length'#9'10'#9'UOM_Length'#9'F'#9
        'UOM_Weight'#9'10'#9'UOM_Weight'#9'F'#9
        'TotalUOM_WeightSold'#9'10'#9'TotalUOM_WeightSold'#9'F'#9
        'TotalUOM_WeightShipped'#9'10'#9'TotalUOM_WeightShipped'#9'F'#9
        'TotalUOM_WeightBO'#9'10'#9'TotalUOM_WeightBO'#9'F'#9
        'TotalUOM_LengthSold'#9'10'#9'TotalUOM_LengthSold'#9'F'#9
        'TotalUOM_LengthShipped'#9'10'#9'TotalUOM_LengthShipped'#9'F'#9
        'TotalUOM_LengthBO'#9'10'#9'TotalUOM_LengthBO'#9'F'#9
        'UOM_Volume'#9'10'#9'UOM_Volume'#9'F'#9
        'Product_custFld1'#9'20'#9'Product_custFld1'#9'F'#9
        'Product_custFld2'#9'20'#9'Product_custFld2'#9'F'#9
        'Product_custFld3'#9'20'#9'Product_custFld3'#9'F'#9
        'Product_custFld4'#9'20'#9'Product_custFld4'#9'F'#9
        'Product_custFld5'#9'20'#9'Product_custFld5'#9'F'#9
        'Product_custFld6'#9'20'#9'Product_custFld6'#9'F'#9
        'Product_custFld7'#9'20'#9'Product_custFld7'#9'F'#9
        'Product_custFld8'#9'20'#9'Product_custFld8'#9'F'#9
        'Product_custFld9'#9'20'#9'Product_custFld9'#9'F'#9
        'Product_custFld10'#9'20'#9'Product_custFld10'#9'F'#9
        'Product_custFld11'#9'20'#9'Product_custFld11'#9'F'#9
        'Product_custFld12'#9'20'#9'Product_custFld12'#9'F'#9
        'Product_custFld13'#9'20'#9'Product_custFld13'#9'F'#9
        'ProgresspaymentRef'#9'10'#9'Progress Payment Ref'#9'F'#9
        'Product_custFld14'#9'20'#9'Product_custFld14'#9'F'#9
        'Product_custFld15'#9'20'#9'Product_custFld15'#9'F'#9
        'Product_custDate1'#9'18'#9'Product_custDate1'#9'F'#9
        'Product_custDate2'#9'18'#9'Product_custDate2'#9'F'#9
        'Product_custDate3'#9'18'#9'Product_custDate3'#9'F'#9
        'MatrixDesc'#9'10'#9'Matrix Details'#9'T'#9
        'MatrixPrice'#9'10'#9'Matrix Price'#9'T'#9
        'FormulaQtySoldValue1'#9'10'#9'FormulaQtySoldValue1'#9'F'#9
        'FormulaQtySoldValue2'#9'10'#9'FormulaQtySoldValue2'#9'F'#9
        'FormulaQtySoldValue3'#9'10'#9'FormulaQtySoldValue3'#9'F'#9
        'FormulaQtySoldValue4'#9'10'#9'FormulaQtySoldValue4'#9'F'#9
        'FormulaQtySoldValue5'#9'10'#9'FormulaQtySoldValue5'#9'F'#9
        'FormulaQtyShippedValue1'#9'10'#9'FormulaQtyShippedValue1'#9'F'#9
        'FormulaQtyShippedValue2'#9'10'#9'FormulaQtyShippedValue2'#9'F'#9
        'FormulaQtyShippedValue3'#9'10'#9'FormulaQtyShippedValue3'#9'F'#9
        'FormulaQtyShippedValue4'#9'10'#9'FormulaQtyShippedValue4'#9'F'#9
        'FormulaQtyShippedValue5'#9'10'#9'FormulaQtyShippedValue5'#9'F'#9
        'FormulaQtySoldValue'#9'10'#9'FormulaQtySoldValue'#9'F'#9
        'FormulaQtyShippedValue'#9'10'#9'FormulaQtyShippedValue'#9'F'#9
        'Attrib1SaleEst'#9'10'#9'Est Metres ?'#9'F'#9
        'BOMGroupedLine'#9'1'#9'BOMGroupedLine'#9'F'#9
        'BOMProductionLine'#9'1'#9'BOMProductionLine'#9'F'#9
        'Attrib2SaleEst'#9'10'#9'Est Weight'#9'F'#9
        'ISContainer'#9'1'#9'ISContainer'#9'F'#9
        'IsPallet'#9'1'#9'IsPallet'#9'F'#9
        'Area'#9'20'#9'Area'#9'F'#9
        'AreaQty'#9'10'#9'Area To Cover'#9'F'#9
        'Assembled'#9'1'#9'Assembled'#9'F'#9
        'CustomerEquipmentID'#9'10'#9'CustomerEquipmentID'#9'F'#9
        'Equipment'#9'10'#9'Equipment'#9'T'#9
        'LinesOrder'#9'10'#9'Order by'#9'F'#9
        'RequiresAssembly'#9'1'#9'Requires Assembly?'#9'F'#9
        'ProductBarcode'#9'255'#9'ProductBarcode'#9'F'#9
        'UOMLineCost'#9'10'#9'UOM Cost (Ex)'#9'F'#9
        'UOMLineCostInc'#9'10'#9'UOM Cost (Inc)'#9'F'#9
        'UOMLinePrice'#9'10'#9'UOM Price (Ex)'#9'F'#9
        'UOMLinePriceInc'#9'10'#9'UOM Price (Inc)'#9'F'#9
        'OriginalQtyOrdered'#9'10'#9'Orig Qty'#9'F'#9
        'DetailsCust1Total'#9'10'#9'DetailsCust1Total'#9'F'#9
        'StandardCost'#9'10'#9'Standard Cost'#9'F'#9
        'OrgProductPrice'#9'10'#9'Org Product Price (Ex)'#9'F'#9
        'OrgProductPriceInc'#9'10'#9'Org Product Price (Inc)'#9'F'#9
        'ExcludeFromSmartOrder'#9'1'#9'ExcludeFromSmartOrder'#9'F'#9
        'PurchaseCost'#9'10'#9'SMO To Cost'#9'F'#9
        'ISVoucher'#9'1'#9'ISVoucher'#9'F'#9
        'ProductPrintName'#9'20'#9'ProductPrintName'#9'F'#9
        'PackWeightField1'#9'10'#9'PackWeightField1'#9'F'#9
        'PackWeightfield2'#9'10'#9'PackWeightfield2'#9'F'#9
        'PackCount'#9'10'#9'PackCount'#9'F'#9
        'BOMComments'#9'20'#9'BOM Partial Build Comments'#9'F'#9
        'RelatedProductProdLine'#9'10'#9'RelatedProductProdLine'#9'F'#9
        'RelatedProductPatternName'#9'255'#9'RelatedProductPatternName'#9'F'#9
        
          'RelatedProductFormulaDescription'#9'255'#9'RelatedProductFormulaDescri' +
          'ption'#9'F'#9
        'ETDDate'#9'18'#9'ETD Date'#9'F'#9
        'UOMQtyInStock'#9'10'#9'Qty In Stock'#9'F'#9
        'UOMQtyAvailable'#9'10'#9'Qty Available'#9'F'#9
        'SortId'#9'10'#9'Sort ID'#9'F'#9
        'VoucherNo'#9'255'#9'VoucherNo'#9'F'#9
        'SOInvoiceLineRef'#9'255'#9'SOInvoiceLineRef'#9'F'#9)
      ExplicitWidth = 996
      ExplicitHeight = 132
    end
    inherited cboTaxCode: TERPDbLookupCombo
      TabOrder = 2
    end
    inherited cboUnitOfMeasure: TwwDBLookupCombo
      TabOrder = 3
    end
    inherited cboSupplier: TERPDbLookupCombo
      TabOrder = 4
    end
    inherited cboCostCentre: TwwDBLookupCombo
      TabOrder = 5
    end
    inherited cboPartSpecs: TwwDBLookupCombo
      TabOrder = 6
    end
    inherited cboProductR: TERPDbLookupCombo
      Selected.Strings = (
        'PARTNAME'#9'15'#9'Product Name'#9'F'
        'Manuf'#9'15'#9'Manuf'#9'F'
        'Type'#9'15'#9'Type'#9'F'
        'Dept'#9'15'#9'Dept'#9'F'
        'PartsDescription'#9'35'#9'Description'#9'F'
        'Active'#9'1'#9'Active'#9'F'
        'PreferedSupp'#9'20'#9'Preferred Supplier'#9'F'
        'SupplierProductCode'#9'20'#9'Supplier Product Code'#9'F')
      TabOrder = 7
      OnChange = cboProductRChange
    end
    inherited ProgressBar: TProgressBar
      Top = 132
      Width = 996
      HelpContext = 372150
      TabOrder = 1
      ExplicitTop = 132
      ExplicitWidth = 996
    end
    inherited edtMemoLine: TwwDBEdit
      TabOrder = 10
    end
    object dtShipContainerETA: TwwDBDateTimePicker [9]
      Left = 560
      Top = 24
      Width = 121
      Height = 26
      HelpContext = 372151
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'ShipContainerETA'
      DataSource = DSDetails
      Epoch = 1950
      ShowButton = True
      TabOrder = 11
      OnClick = grdTransactionsDblClick
    end
  end
  inherited pnlFooter: TDNMPanel
    Top = 413
    Width = 996
    Height = 150
    HelpContext = 372002
    Align = alBottom
    Alignment = taRightJustify
    ExplicitTop = 413
    ExplicitWidth = 996
    ExplicitHeight = 150
    DesignSize = (
      996
      150)
    inherited lblComments: TLabel
      Top = 3
      HelpContext = 372004
      ExplicitTop = 3
    end
    inherited Label142: TLabel
      Left = 821
      Top = 6
      Height = 19
      HelpContext = 372005
      ExplicitLeft = 777
      ExplicitTop = 6
      ExplicitHeight = 19
    end
    inherited Label54: TLabel
      Left = 822
      Top = 35
      Height = 19
      HelpContext = 372006
      ExplicitLeft = 778
      ExplicitTop = 35
      ExplicitHeight = 19
    end
    inherited Label93: TLabel
      Top = 79
      Width = 68
      Height = 30
      HelpContext = 372018
      Alignment = taRightJustify
      AutoSize = True
      Caption = 'Picking Instructions'
      ExplicitTop = 79
      ExplicitWidth = 68
      ExplicitHeight = 30
    end
    inherited Label56: TLabel
      Left = 815
      Top = 66
      Height = 19
      HelpContext = 372007
      ExplicitLeft = 771
      ExplicitTop = 66
      ExplicitHeight = 19
    end
    inherited Label122: TLabel
      Left = 638
      Top = 99
      Width = 43
      Height = 15
      HelpContext = 372020
      AutoSize = True
      WordWrap = False
      ExplicitLeft = 638
      ExplicitTop = 99
      ExplicitWidth = 43
      ExplicitHeight = 15
    end
    inherited Label5: TLabel
      Left = 631
      Top = 69
      Width = 50
      Height = 15
      HelpContext = 372021
      AutoSize = True
      WordWrap = False
      ExplicitLeft = 631
      ExplicitTop = 69
      ExplicitWidth = 50
      ExplicitHeight = 15
    end
    inherited lblBaseForeignTotal: TLabel
      Top = 127
      HelpContext = 372011
      Visible = True
      ExplicitTop = 127
    end
    inherited Label101: TLabel
      Top = 129
      Width = 54
      Height = 15
      HelpContext = 372120
      WordWrap = False
      ExplicitTop = 129
      ExplicitWidth = 54
      ExplicitHeight = 15
    end
    inherited lblContributionAmount: TLabel
      Left = 612
      Top = 39
      Width = 69
      Height = 15
      HelpContext = 372121
      AutoSize = True
      ExplicitLeft = 612
      ExplicitTop = 39
      ExplicitWidth = 69
      ExplicitHeight = 15
    end
    inherited Label12: TLabel
      Left = 821
      Top = 127
      ExplicitLeft = 777
      ExplicitTop = 127
    end
    inherited lblApprovedAmount: TLabel
      Left = 624
      Top = 1
      ExplicitLeft = 624
      ExplicitTop = 1
    end
    inherited pnlComments: TDNMPanel
      Left = 75
      Top = 3
      Width = 535
      Height = 59
      HelpContext = 372166
      TabOrder = 18
      ExplicitLeft = 75
      ExplicitTop = 3
      ExplicitWidth = 535
      ExplicitHeight = 59
      inherited LblCommentsHint: TLabel
        Top = 40
        Width = 533
        HelpContext = 372167
        ExplicitLeft = 1
        ExplicitTop = 40
        ExplicitWidth = 237
      end
      inherited txtComments: TDBMemo
        Width = 533
        Height = 39
        HelpContext = 372013
        ExplicitWidth = 533
        ExplicitHeight = 39
      end
    end
    inherited txtSubTotal: TDBEdit
      Left = 888
      Top = 3
      HelpContext = 372014
      TabOrder = 23
      ExplicitLeft = 888
      ExplicitTop = 3
    end
    inherited txtTotalTax: TDBEdit
      Left = 888
      Top = 33
      HelpContext = 372015
      TabOrder = 7
      ExplicitLeft = 888
      ExplicitTop = 33
    end
    inherited txtTotalDiscount: TDBEdit
      Left = 685
      Top = 64
      HelpContext = 372034
      TabOrder = 4
      ExplicitLeft = 685
      ExplicitTop = 64
    end
    inherited txtTotalMarkup: TDBEdit [16]
      Left = 685
      Top = 94
      HelpContext = 372038
      TabOrder = 5
      ExplicitLeft = 685
      ExplicitTop = 94
    end
    inherited txtTotalAmount: TDBEdit [17]
      Left = 874
      Top = 62
      HelpContext = 372016
      TabOrder = 9
      ExplicitLeft = 874
      ExplicitTop = 62
    end
    inherited edtBaseForeignTotal: TDBEdit [18]
      Left = 685
      Top = 124
      HelpContext = 372017
      DataField = 'ForeignTotalAmount'
      TabOrder = 6
      Visible = True
      ExplicitLeft = 685
      ExplicitTop = 124
    end
    inherited lblDisableCalc: TDNMSpeedButton [19]
      Left = 749
      Top = 6
      TabOrder = 16
      ExplicitLeft = 749
      ExplicitTop = 6
    end
    inherited btnAttachments: TDNMSpeedButton [20]
      Left = 5
      HelpContext = 372043
      TabOrder = 12
      ExplicitLeft = 5
    end
    inherited DNMPanel5: TDNMPanel [21]
      Height = 124
      HelpContext = 372122
      TabOrder = 15
      Visible = False
      ExplicitHeight = 124
      inherited lblEnteredBy: TDBText
        Top = 4
        Height = 15
        HelpContext = 372123
        ExplicitTop = 4
        ExplicitHeight = 15
      end
      inherited lblPrintHead: TLabel
        Top = 53
        ExplicitTop = 53
      end
      inherited lblPrintedBy: TLabel
        Top = 53
        ExplicitTop = 53
      end
      inherited lblPrintedOnCaption: TLabel
        Top = 77
        ExplicitTop = 77
      end
      inherited lblPrintedOn: TLabel
        Left = 77
        Top = 77
        Height = 15
        HelpContext = 372124
        ExplicitLeft = 77
        ExplicitTop = 77
        ExplicitHeight = 15
      end
      inherited lblPrintedAtCaption: TLabel
        Top = 102
        ExplicitTop = 102
      end
      inherited lblPrintedAt: TLabel
        Top = 102
        Height = 15
        HelpContext = 372125
        ExplicitTop = 102
        ExplicitHeight = 15
      end
      inherited lblEnteredAtHead: TLabel
        Top = 28
        ExplicitTop = 28
      end
      inherited lblEnteredAt: TDBText
        Top = 28
        Height = 15
        HelpContext = 372126
        DataField = 'EnteredAtShort'
        ExplicitTop = 28
        ExplicitHeight = 15
      end
    end
    inherited lblEmail: TDNMPanel [22]
      Left = 558
      Top = 9
      HelpContext = 372168
      TabOrder = 22
      ExplicitLeft = 558
      ExplicitTop = 9
    end
    object DNMPanel2: TDNMPanel [23]
      Left = 1
      Top = 125
      Width = 113
      Height = 23
      HelpContext = 372049
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 13
      object Label13: TLabel
        Left = 26
        Top = 5
        Width = 92
        Height = 15
        HelpContext = 372129
        AutoSize = False
        Caption = 'Barcode Pick'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object wwCheckBox1: TwwCheckBox
        Left = 7
        Top = 4
        Width = 13
        Height = 15
        HelpContext = 372051
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        DataField = 'IsBarcodePicking'
        DataSource = DSMaster
        TabOrder = 0
      end
    end
    object DNMPanel1: TDNMPanel [24]
      Left = 136
      Top = 125
      Width = 85
      Height = 23
      HelpContext = 372046
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 14
      Visible = False
      object Label7: TLabel
        Left = 22
        Top = 4
        Width = 49
        Height = 15
        HelpContext = 372047
        Caption = 'Manifest'
        Transparent = True
        Visible = False
      end
      object chkManifest: TwwCheckBox
        Left = 7
        Top = 4
        Width = 13
        Height = 15
        HelpContext = 372048
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'chkManifest'
        DataField = 'IsManifest'
        DataSource = DSMaster
        TabOrder = 0
        Visible = False
      end
    end
    inherited dnmpanle6: TDNMPanel [25]
      Height = 148
      HelpContext = 372127
      TabOrder = 19
      Visible = False
      ExplicitHeight = 148
      inherited lblMargin: TLabel
        Top = 109
        ExplicitTop = 109
      end
      inherited lblMarginLabel: TLabel
        Top = 109
        ExplicitTop = 109
      end
      inherited lblCostLabel: TLabel
        Top = 91
        ExplicitTop = 91
      end
      inherited lblCost: TLabel
        Top = 91
        ExplicitTop = 91
      end
      inherited lblEarlyPaymentDiscount2: TLabel
        Top = 55
        ExplicitTop = 55
      end
      inherited lblEarlyPaymentDiscountAmount: TLabel
        Top = 55
        Width = 73
        HelpContext = 372128
        ExplicitTop = 55
        ExplicitWidth = 73
      end
      inherited lblEarlyPaymentDiscount: TLabel
        Left = 4
        Top = 37
        ExplicitLeft = 4
        ExplicitTop = 37
      end
      inherited lblShipTitle: TLabel
        Top = 19
        ExplicitTop = 19
      end
      inherited lblShipped: TLabel
        Top = 19
        ExplicitTop = 19
      end
      inherited lblEstimatedFinalAmt: TLabel
        Left = 66
        Top = 73
        ExplicitLeft = 66
        ExplicitTop = 73
      end
      inherited lblEstimatedFinalAmtCaption: TLabel
        Top = 73
        ExplicitTop = 73
      end
      inherited lblWeightcaption: TLabel
        Left = 4
        Top = 128
        ExplicitLeft = 4
        ExplicitTop = 128
      end
      inherited lblWeight: TLabel
        Left = 66
        Top = 128
        ExplicitLeft = 66
        ExplicitTop = 128
      end
    end
    inherited txtConNote: TDBEdit [26]
      Left = 379
      Top = 125
      Width = 82
      HelpContext = 372130
      TabOrder = 1
      ExplicitLeft = 379
      ExplicitTop = 125
      ExplicitWidth = 82
    end
    inherited edtContributionAmount: TwwDBEdit [27]
      Left = 685
      Top = 34
      ParentColor = True
      TabOrder = 3
      ExplicitLeft = 685
      ExplicitTop = 34
    end
    inherited Label11: TDNMSpeedButton [28]
      Left = 821
      Top = 92
      Height = 24
      HelpContext = 372131
      TabOrder = 17
      OnClick = doShowPayments
      ExplicitLeft = 821
      ExplicitTop = 92
      ExplicitHeight = 24
    end
    inherited edtPayment: TDBEdit [29]
      Left = 888
      Top = 92
      DataField = 'TotalInvoicePayment'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      ExplicitLeft = 888
      ExplicitTop = 92
    end
    inherited edtBalance: TDBEdit [30]
      Left = 888
      Top = 123
      DataField = 'InvoiceBalance'
      TabOrder = 11
      ExplicitLeft = 888
      ExplicitTop = 123
    end
    inherited edtApprovedAmount: TDBEdit [31]
      Left = 685
      Width = 88
      HelpContext = 372132
      TabOrder = 2
      ExplicitLeft = 685
      ExplicitWidth = 88
    end
    inherited btnSignature: TDNMSpeedButton [32]
      Left = 5
      TabOrder = 21
      ExplicitLeft = 5
    end
    inherited btnAddFreight: TDNMSpeedButton [33]
      Left = 778
      Top = 36
      Width = 45
      HelpContext = 372169
      ExplicitLeft = 778
      ExplicitTop = 36
      ExplicitWidth = 45
    end
    inherited pnlProcessMessage: TDNMPanel [34]
      Width = 996
      HelpContext = 372170
      ExplicitWidth = 996
      inherited lblProcessMessage: TLabel
        Width = 992
        HelpContext = 372117
        ExplicitLeft = 288
        ExplicitWidth = 706
      end
    end
    inherited txtPickMemo: TDBMemo [35]
      Left = 75
      Top = 64
      HelpContext = 372036
      TabOrder = 0
      ExplicitLeft = 75
      ExplicitTop = 64
    end
  end
  inherited pnlHeader: TDNMPanel
    Top = 0
    Width = 996
    Height = 265
    HelpContext = 372052
    Align = alTop
    ParentColor = True
    ExplicitTop = 0
    ExplicitWidth = 996
    ExplicitHeight = 265
    DesignSize = (
      996
      265)
    inherited Bvlshipto: TBevel [0]
      Left = 635
      Top = 115
      Width = 261
      Height = 108
      HelpContext = 372133
      ExplicitLeft = 635
      ExplicitTop = 115
      ExplicitWidth = 261
      ExplicitHeight = 108
    end
    object Bevel3: TBevel [1]
      Left = 422
      Top = 61
      Width = 208
      Height = 47
      HelpContext = 372106
    end
    object Bevel2: TBevel [2]
      Left = 269
      Top = 61
      Width = 150
      Height = 47
      HelpContext = 372156
    end
    object Bevel1: TBevel [3]
      Left = 269
      Top = 151
      Width = 361
      Height = 72
      HelpContext = 372157
    end
    inherited bvelCustomerDetails: TBevel [4]
      Top = 115
      Width = 261
      Height = 108
      HelpContext = 372134
      ExplicitTop = 115
      ExplicitWidth = 261
      ExplicitHeight = 108
    end
    inherited Label38: TLabel
      Left = 9
      Top = 41
      HelpContext = 372053
      ExplicitLeft = 9
      ExplicitTop = 41
    end
    inherited lblClientDetails: TLabel
      Top = 118
      ExplicitTop = 118
    end
    inherited SaleDate_Label: TLabel
      Left = 635
      Top = 42
      Width = 26
      Height = 15
      HelpContext = 372055
      AutoSize = True
      ExplicitLeft = 635
      ExplicitTop = 42
      ExplicitWidth = 26
      ExplicitHeight = 15
    end
    inherited Label160: TLabel
      Left = 746
      Top = 42
      Width = 58
      Height = 15
      HelpContext = 372056
      AutoSize = True
      Caption = 'Invoice No'
      ExplicitLeft = 746
      ExplicitTop = 42
      ExplicitWidth = 58
      ExplicitHeight = 15
    end
    inherited ClassLabel: TLabel
      Left = 277
      Top = 66
      Width = 32
      Height = 15
      HelpContext = 372083
      AutoSize = True
      ExplicitLeft = 277
      ExplicitTop = 66
      ExplicitWidth = 32
      ExplicitHeight = 15
    end
    inherited Label43: TLabel
      Left = 10
      Top = 225
      Width = 69
      Height = 15
      HelpContext = 372084
      Alignment = taLeftJustify
      AutoSize = True
      ExplicitLeft = 10
      ExplicitTop = 225
      ExplicitWidth = 69
      ExplicitHeight = 15
    end
    inherited Label47: TLabel
      Left = 309
      Top = 225
      Width = 18
      Height = 15
      HelpContext = 372085
      Alignment = taLeftJustify
      AutoSize = True
      ExplicitLeft = 309
      ExplicitTop = 225
      ExplicitWidth = 18
      ExplicitHeight = 15
    end
    inherited Label79: TLabel
      Left = 541
      Top = 225
      Width = 36
      Height = 15
      HelpContext = 372086
      AutoSize = True
      ExplicitLeft = 541
      ExplicitTop = 225
      ExplicitWidth = 36
      ExplicitHeight = 15
    end
    inherited Label45: TLabel
      Left = 660
      Top = 225
      Width = 51
      Height = 15
      HelpContext = 372087
      AutoSize = True
      ExplicitLeft = 660
      ExplicitTop = 225
      ExplicitWidth = 51
      ExplicitHeight = 15
    end
    inherited lblAccount: TLabel
      Left = 9
      HelpContext = 372088
      ExplicitLeft = 9
    end
    object Label3: TLabel [15]
      Left = 219
      Top = 225
      Width = 54
      Height = 15
      HelpContext = 372107
      Caption = 'Ship Date'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    inherited Label48: TLabel
      Left = 112
      Top = 225
      Width = 22
      Height = 15
      HelpContext = 372057
      AutoSize = True
      ExplicitLeft = 112
      ExplicitTop = 225
      ExplicitWidth = 22
      ExplicitHeight = 15
    end
    inherited lbMemTrans: TLabel
      Left = 753
      HelpContext = 372058
      ExplicitLeft = 753
    end
    inherited lblBaseForeignCurrencyCode: TLabel
      Left = 426
      Top = 64
      HelpContext = 372059
      Visible = True
      ExplicitLeft = 426
      ExplicitTop = 64
    end
    inherited Label10: TLabel
      Left = 229
      Top = 42
      Width = 34
      HelpContext = 372135
      Alignment = taRightJustify
      Visible = True
      ExplicitLeft = 229
      ExplicitTop = 42
      ExplicitWidth = 34
    end
    inherited lblBaseExchangeRate: TLabel
      Left = 535
      Top = 66
      HelpContext = 372060
      ExplicitLeft = 535
      ExplicitTop = 66
    end
    object lblPickUpFrom: TLabel [21]
      Left = 815
      Top = 119
      Width = 57
      Height = 15
      HelpContext = 372108
      Alignment = taRightJustify
      Caption = 'Pick From'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    inherited lblRedeemPoints: TLabel
      Left = 176
      Top = 89
      Width = 86
      HelpContext = 372136
      Alignment = taRightJustify
      ExplicitLeft = 176
      ExplicitTop = 89
      ExplicitWidth = 86
    end
    object lblInvoicePaid: TLabel [23]
      Left = 753
      Top = 19
      Width = 93
      Height = 19
      HelpContext = 372044
      Caption = 'Invoice Paid'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object Label2: TLabel [25]
      Left = 743
      Top = 119
      Width = 42
      Height = 15
      HelpContext = 372158
      Alignment = taRightJustify
      Caption = 'Foreign'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel [26]
      Left = 750
      Top = 225
      Width = 68
      Height = 15
      HelpContext = 372137
      Caption = 'No of Boxes'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblProgressPayment: TLabel [27]
      Left = 248
      Top = 42
      Width = 175
      Height = 19
      Cursor = crHandPoint
      HelpContext = 372159
      Alignment = taCenter
      AutoSize = False
      Caption = 'Sales Order'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
      OnClick = lblProgressPaymentDblClick
    end
    object lblInvoice: TLabel [28]
      Left = 433
      Top = 42
      Width = 175
      Height = 19
      Cursor = crHandPoint
      HelpContext = 372160
      Alignment = taCenter
      AutoSize = False
      Caption = 'Invoice'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
      OnClick = lblInvoiceClick
    end
    inherited lblStatus: TLabel
      Left = 424
      Top = 225
      Width = 37
      HelpContext = 372138
      AutoSize = True
      ExplicitLeft = 424
      ExplicitTop = 225
      ExplicitWidth = 37
    end
    inherited Label8: TLabel
      Left = 636
      Top = 90
      Width = 51
      HelpContext = 372171
      Alignment = taRightJustify
      Caption = 'Category'
      WordWrap = False
      ExplicitLeft = 636
      ExplicitTop = 90
      ExplicitWidth = 51
    end
    object Label14: TLabel [31]
      Left = 659
      Top = 160
      Width = 56
      Height = 15
      HelpContext = 372139
      Caption = 'Ship Time'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    inherited lblArea: TLabel
      Left = 820
      Top = 225
      ExplicitLeft = 820
      ExplicitTop = 225
    end
    inherited edt_SaleNum_Seq: TDBText
      Left = 830
      Top = 60
      ExplicitLeft = 830
      ExplicitTop = 60
    end
    inherited txtClientDetails: TDBMemo [34]
      Left = 11
      Top = 138
      Width = 252
      Height = 81
      HelpContext = 372063
      TabOrder = 4
      ExplicitLeft = 11
      ExplicitTop = 138
      ExplicitWidth = 252
      ExplicitHeight = 81
    end
    inherited cboCreationDate: TwwDBDateTimePicker [35]
      Left = 636
      Top = 57
      Width = 103
      Height = 23
      HelpContext = 372064
      TabOrder = 11
      ExplicitLeft = 636
      ExplicitTop = 57
      ExplicitWidth = 103
      ExplicitHeight = 23
    end
    inherited cboClass: TwwDBLookupCombo [36]
      Left = 277
      Top = 80
      Width = 134
      HelpContext = 372092
      Selected.Strings = (
        'ClassName'#9'25'#9'ClassName'#9'F')
      TabOrder = 5
      ExplicitLeft = 277
      ExplicitTop = 80
      ExplicitWidth = 134
    end
    inherited txtPONumber: TDBEdit [37]
      Left = 9
      Top = 240
      Width = 100
      HelpContext = 372093
      TabOrder = 41
      ExplicitLeft = 9
      ExplicitTop = 240
      ExplicitWidth = 100
    end
    inherited cmdPrintPick: TDNMSpeedButton [38]
      Left = 784
      Top = 163
      HelpContext = 372097
      TabOrder = 42
      Visible = False
      ExplicitLeft = 784
      ExplicitTop = 163
    end
    inherited cboAccount: TwwDBLookupCombo [39]
      Left = 9
      Top = 14
      Width = 235
      HelpContext = 372098
      TabOrder = 0
      ExplicitLeft = 9
      ExplicitTop = 14
      ExplicitWidth = 235
    end
    inherited txtShipTo: TDBMemo [40]
      Left = 643
      Top = 138
      Width = 250
      Height = 81
      HelpContext = 372099
      TabOrder = 17
      ExplicitLeft = 643
      ExplicitTop = 138
      ExplicitWidth = 250
      ExplicitHeight = 81
    end
    inherited txtCustomID: TDBEdit [41]
      Left = 746
      Top = 57
      Hint = 'Double Click For The Transaction Sequence List'
      HelpContext = 372065
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 13
      ExplicitLeft = 746
      ExplicitTop = 57
    end
    inherited cboEmployee: TwwDBLookupCombo [42]
      Left = 111
      Top = 240
      Width = 105
      HelpContext = 372066
      Selected.Strings = (
        'EmployeeName'#9'25'#9'EmployeeName'#9'F')
      TabOrder = 19
      OnNotInList = cboEmployeeNotInList
      ExplicitLeft = 111
      ExplicitTop = 240
      ExplicitWidth = 105
    end
    inherited btnNext: TDNMSpeedButton [43]
      Left = 901
      Top = 10
      HelpContext = 372067
      TabOrder = 30
      ExplicitLeft = 901
      ExplicitTop = 10
    end
    inherited btnCompleted: TDNMSpeedButton [44]
      Left = 901
      Top = 74
      HelpContext = 372068
      TabOrder = 31
      ExplicitLeft = 901
      ExplicitTop = 74
    end
    inherited btnClose: TDNMSpeedButton [45]
      Left = 901
      Top = 106
      HelpContext = 372069
      TabOrder = 32
      ExplicitLeft = 901
      ExplicitTop = 106
    end
    inherited btnPreview: TDNMSpeedButton [46]
      Left = 901
      Top = 138
      HelpContext = 372070
      Action = nil
      TabOrder = 33
      OnClick = btnPreviewClick
      ExplicitLeft = 901
      ExplicitTop = 138
    end
    inherited btnPrint: TDNMSpeedButton [47]
      Left = 901
      Top = 170
      HelpContext = 372071
      Action = nil
      Caption = 'Print'
      TabOrder = 34
      OnClick = btnPrintClick
      ExplicitLeft = 901
      ExplicitTop = 170
    end
    inherited pnlChooseRpt: TDNMPanel [48]
      Left = 269
      Top = 118
      Width = 128
      Height = 21
      HelpContext = 372072
      TabOrder = 8
      ExplicitLeft = 269
      ExplicitTop = 118
      ExplicitWidth = 128
      ExplicitHeight = 21
      inherited chkChooseRpt: TCheckBox
        Left = 5
        HelpContext = 372074
        TabStop = False
        ExplicitLeft = 5
      end
    end
    object pnlWholesale: TDNMPanel [49]
      Left = 664
      Top = 10
      Width = 132
      Height = 23
      HelpContext = 372109
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 49
      Visible = False
      object lblWholesale: TLabel
        Left = 26
        Top = 4
        Width = 96
        Height = 15
        HelpContext = 372110
        Caption = ' Wholesale Price'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object chkWholesalePrice: TCheckBox
        Left = 8
        Top = 3
        Width = 14
        Height = 17
        HelpContext = 372111
        TabStop = False
        Caption = 'chkWholesalePrice'
        TabOrder = 0
      end
    end
    inherited cboVia: TwwDBLookupCombo [50]
      Left = 308
      Top = 240
      Width = 113
      HelpContext = 372100
      TabOrder = 20
      ExplicitLeft = 308
      ExplicitTop = 240
      ExplicitWidth = 113
    end
    inherited pnlHold: TDNMPanel [51]
      Left = 411
      Top = 118
      Width = 98
      Height = 21
      HelpContext = 372101
      TabOrder = 9
      ExplicitLeft = 411
      ExplicitTop = 118
      ExplicitWidth = 98
      ExplicitHeight = 21
      inherited lblHoldSale: TLabel
        Top = 3
        HelpContext = 372102
        ExplicitTop = 3
      end
      inherited chkHoldSale: TwwCheckBox
        Top = 3
        Width = 15
        HelpContext = 372103
        ExplicitTop = 3
        ExplicitWidth = 15
      end
    end
    inherited btnContacts: TDNMSpeedButton [52]
      Left = 206
      Top = 56
      HelpContext = 372075
      TabOrder = 2
      ExplicitLeft = 206
      ExplicitTop = 56
    end
    object cboShipDate: TwwDBDateTimePicker [53]
      Left = 218
      Top = 240
      Width = 88
      Height = 23
      HelpContext = 372112
      AutoFillDateAndTime = True
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'ShipDate'
      DataSource = DSMaster
      Epoch = 1950
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 55
    end
    inherited cboBaseForeignCurrencyCode: TwwDBLookupCombo [54]
      Left = 426
      Top = 80
      Width = 103
      HelpContext = 372077
      TabOrder = 6
      Visible = True
      ExplicitLeft = 426
      ExplicitTop = 80
      ExplicitWidth = 103
    end
    inherited edtBaseExchangeRate: TwwDBEdit [55]
      Left = 535
      Top = 80
      Width = 87
      HelpContext = 372078
      TabOrder = 7
      ExplicitLeft = 535
      ExplicitTop = 80
      ExplicitWidth = 87
    end
    inherited pnlTitle: TDNMPanel [56]
      Left = 387
      Top = 4
      Width = 222
      Height = 39
      HelpContext = 372080
      Caption = 'Invoice'
      TabOrder = 51
      ExplicitLeft = 387
      ExplicitTop = 4
      ExplicitWidth = 222
      ExplicitHeight = 39
      inherited TitleShader: TShader
        Width = 220
        Height = 37
        HelpContext = 372081
        ExplicitWidth = 220
        ExplicitHeight = 37
        inherited TitleLabel: TLabel
          Width = 220
          Height = 37
          HelpContext = 372082
          Caption = 'Invoice'
          ExplicitWidth = 171
          ExplicitHeight = 37
        end
      end
    end
    inherited cboClientR: TERPDbLookupCombo [57]
      Left = 9
      Width = 193
      HelpContext = 372140
      Selected.Strings = (
        'Company'#9'45'#9'Company'#9'F')
      TabOrder = 1
      ExplicitLeft = 9
      ExplicitWidth = 193
    end
    inherited btnPrepayment: TDNMSpeedButton [58]
      Left = 403
      Top = 193
      Width = 98
      Height = 25
      HelpContext = 372104
      TabOrder = 28
      ExplicitLeft = 403
      ExplicitTop = 193
      ExplicitWidth = 98
      ExplicitHeight = 25
    end
    inherited btnRepairEquipment: TDNMSpeedButton [59]
      Left = 238
      Top = 56
      TabOrder = 3
      ExplicitLeft = 238
      ExplicitTop = 56
    end
    inherited btnCreateJob: TDNMSpeedButton [60]
      Left = 281
      Top = 157
      Width = 98
      Height = 25
      HelpContext = 372141
      TabOrder = 25
      ExplicitLeft = 281
      ExplicitTop = 157
      ExplicitWidth = 98
      ExplicitHeight = 25
    end
    inherited pnlParentclient: TDNMPanel [61]
      HelpContext = 372172
      TabOrder = 43
    end
    object btnPickUpFrom: TDNMSpeedButton [62]
      Left = 873
      Top = 117
      Width = 18
      Height = 19
      HelpContext = 372113
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
      TabOrder = 16
      Visible = False
      AutoDisableParentOnclick = True
      OnClick = btnPickUpFromClick
    end
    object cmdTimecost: TDNMSpeedButton [63]
      Left = 947
      Top = 202
      Width = 41
      Height = 27
      Hint = 
        '"Add To This Invoice Any Costs Or Expenses Associated With The S' +
        'elected Customer"'
      HelpContext = 372115
      Anchors = [akTop, akRight]
      Caption = 'Costs'
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
      TabOrder = 27
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = cmdTimecostClick
    end
    object btnPayment: TDNMSpeedButton [64]
      Left = 403
      Top = 157
      Width = 98
      Height = 25
      HelpContext = 372161
      Caption = 'Payments'
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
      TabOrder = 26
      AutoDisableParentOnclick = True
      OnClick = btnPaymentClick
    end
    object btnSalesShippingDetailForm: TDNMSpeedButton [65]
      Left = 791
      Top = 117
      Width = 18
      Height = 19
      HelpContext = 372162
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
      TabOrder = 15
      AutoDisableParentOnclick = True
      OnClick = btnSalesShippingDetailFormClick
    end
    object wwDBEdit1: TwwDBEdit [66]
      Left = 750
      Top = 240
      Width = 68
      Height = 23
      HelpContext = 372142
      DataField = 'NoOfBoxes'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 24
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object DNMPanel3: TDNMPanel [67]
      Left = 521
      Top = 118
      Width = 98
      Height = 21
      HelpContext = 372163
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      object Label9: TLabel
        Left = 23
        Top = 3
        Width = 59
        Height = 15
        HelpContext = 372102
        Caption = 'Confirmed'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox2: TwwCheckBox
        Left = 4
        Top = 4
        Width = 14
        Height = 13
        HelpContext = 372164
        TabStop = False
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        DataField = 'SaleConfirmed'
        DataSource = DSMaster
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = chkHoldSaleClick
      end
    end
    object DNMSpeedButton3: TDNMSpeedButton [68]
      Left = 526
      Top = 193
      Width = 98
      Height = 25
      HelpContext = 372143
      Action = actCopyInvoice
      Caption = 'Copy Invoice'
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
      TabOrder = 29
      AutoDisableParentOnclick = True
    end
    inherited btnPayments: TDNMSpeedButton [69]
      Left = 653
      Top = 9
      HelpContext = 372119
      TabOrder = 48
      ExplicitLeft = 653
      ExplicitTop = 9
    end
    inherited cboSalesCategory: TwwDBLookupCombo [70]
      Left = 693
      Top = 86
      Width = 202
      HelpContext = 372145
      TabOrder = 14
      ExplicitLeft = 693
      ExplicitTop = 86
      ExplicitWidth = 202
    end
    inherited btnEdit: TDNMSpeedButton [71]
      Left = 901
      Top = 202
      Width = 41
      HelpContext = 372146
      TabOrder = 35
      Visible = True
      ExplicitLeft = 901
      ExplicitTop = 202
      ExplicitWidth = 41
    end
    inherited cmdEmail: TDNMSpeedButton [72]
      Left = 742
      Top = 140
      HelpContext = 372037
      TabOrder = 45
      Visible = False
      ExplicitLeft = 742
      ExplicitTop = 140
    end
    inherited btnPDF: TDNMSpeedButton [73]
      Left = 823
      Top = 176
      TabOrder = 18
      Visible = False
      ExplicitLeft = 823
      ExplicitTop = 176
    end
    inherited cmdDeliveryDocket: TDNMSpeedButton [74]
      Left = 823
      Top = 143
      HelpContext = 372096
      TabOrder = 56
      Visible = False
      ExplicitLeft = 823
      ExplicitTop = 143
    end
    inherited cmdFax: TDNMSpeedButton [75]
      Left = 774
      Top = 155
      HelpContext = 372039
      TabOrder = 46
      OnClick = cmdFaxClick
      ExplicitLeft = 774
      ExplicitTop = 155
    end
    inherited btnShipment: TDNMSpeedButton [76]
      Left = 642
      Top = 120
      ParentColor = False
      TabOrder = 36
      ExplicitLeft = 642
      ExplicitTop = 120
    end
    inherited cboDueDate: TwwDBDateTimePicker [77]
      Left = 659
      Top = 240
      Width = 88
      HelpContext = 372095
      TabOrder = 23
      ExplicitLeft = 659
      ExplicitTop = 240
      ExplicitWidth = 88
    end
    inherited cboTerms: TwwDBLookupCombo [78]
      Left = 541
      Top = 240
      Width = 116
      HelpContext = 372094
      TabOrder = 22
      ExplicitLeft = 541
      ExplicitTop = 240
      ExplicitWidth = 116
    end
    inherited cboAreaCode: TwwDBLookupCombo [79]
      Left = 820
      Top = 240
      Width = 75
      HelpContext = 372148
      TabOrder = 12
      ExplicitLeft = 820
      ExplicitTop = 240
      ExplicitWidth = 75
    end
    inherited editField: TEdit [80]
      Left = 696
      Top = 144
      HelpContext = 372091
      TabOrder = 50
      ExplicitLeft = 696
      ExplicitTop = 144
    end
    inherited btnPrevious: TDNMSpeedButton [81]
      Left = 901
      Top = 42
      TabOrder = 37
      ExplicitLeft = 901
      ExplicitTop = 42
    end
    inherited cboCurrentTransStatus: TwwDBLookupCombo [82]
      Left = 423
      Top = 240
      TabOrder = 21
      ExplicitLeft = 423
      ExplicitTop = 240
    end
    inherited btnNextSale: TDNMSpeedButton
      Left = 947
      Top = 42
      TabOrder = 38
      ExplicitLeft = 947
      ExplicitTop = 42
    end
    inherited btnShiptocontact: TDNMSpeedButton
      Left = 699
      Top = 120
      TabOrder = 39
      ExplicitLeft = 699
      ExplicitTop = 120
    end
    inherited pnlShipToMessage: TPanel
      HelpContext = 372173
      TabOrder = 40
    end
    inherited btninvoices: TDNMSpeedButton
      Left = 808
      Top = 8
      TabOrder = 52
      ExplicitLeft = 808
      ExplicitTop = 8
    end
    object btnsplitPay: TDNMSpeedButton [87]
      Left = 526
      Top = 157
      Width = 98
      Height = 25
      HelpContext = 372165
      Caption = 'Split Payment'
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
      TabOrder = 47
      AutoDisableParentOnclick = True
      OnClick = btnsplitPayClick
    end
    inherited btnConSmart: TDNMSpeedButton
      Left = 281
      Top = 193
      Width = 98
      HelpContext = 372174
      TabOrder = 53
      ExplicitLeft = 281
      ExplicitTop = 193
      ExplicitWidth = 98
    end
    inherited btnShowDetails: TDNMSpeedButton
      Left = 901
      Top = 235
      Anchors = [akTop, akRight]
      TabOrder = 54
      ExplicitLeft = 901
      ExplicitTop = 235
    end
    inherited btnRefNo: TDNMSpeedButton
      TabOrder = 44
      Visible = False
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 703
    Top = 303
  end
  inherited tmrdelay: TTimer
    Left = 779
    Top = 303
  end
  inherited tmrdelayMsg: TTimer
    Left = 665
    Top = 303
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 284
    Top = 303
  end
  inherited DSDetails: TDataSource
    Left = 47
    Top = 361
  end
  inherited DSMaster: TDataSource
    Left = 19
    Top = 361
  end
  inherited lsTDNMSpeedButtonActions: TActionList
    Left = 627
    Top = 303
    inherited actPick: TAction
      OnExecute = actPickExecute
    end
    object actBatchInvoices: TAction [14]
      Caption = 'Batch Create Invoices'
      HelpContext = 372152
      OnExecute = actBatchInvoicesExecute
      OnUpdate = actBatchInvoicesUpdate
    end
    object actCopyToSmart: TAction [15]
      Caption = 'Copy to Smart'
      HelpContext = 372153
    end
    object actCopyInvoice: TDNMAction [16]
      Caption = 'Copy Invoice'
      HelpContext = 372154
      OnExecute = actCopyInvoiceExecute
      OnUpdate = actCopyInvoiceUpdate
      buttoncolor = clWhite
    end
  end
  inherited popDscntMrkup: TAdvPopupMenu
    Left = 132
    Top = 303
  end
  inherited popMemTrans: TAdvPopupMenu
    Left = 170
    Top = 303
    inherited mnuconvertedToList: TMenuItem
      Visible = False
    end
    object N2: TMenuItem
      Caption = '-'
      HelpContext = 372155
    end
    object BatchCreateInvoices1: TMenuItem
      Action = actBatchInvoices
    end
  end
  inherited tblMaster: TERPQuery
    Left = 19
    Top = 332
    inherited tblMasterPayment: TFloatField
      currency = True
    end
    object tblMasterAutoSmartOrderRef: TWideStringField [106]
      FieldName = 'AutoSmartOrderRef'
      Origin = 'tblsales.AutoSmartOrderRef'
      Size = 255
    end
    object tblMasterPOCreated: TWideStringField [107]
      FieldName = 'POCreated'
      Origin = 'tblsales.POCreated'
      FixedChar = True
      Size = 1
    end
    object tblMasterSaleConfirmed: TWideStringField [108]
      FieldName = 'SaleConfirmed'
      Origin = 'tblsales.SaleConfirmed'
      FixedChar = True
      Size = 1
    end
    object tblMasterSOProgressPaymentGlobalRef: TWideStringField [109]
      FieldName = 'SOProgressPaymentGlobalRef'
      Origin = 'tblsales.SOProgressPaymentGlobalRef'
      Size = 255
    end
    object tblMasterSOProgressPaymentOriginalRef: TWideStringField [110]
      FieldName = 'SOProgressPaymentOriginalRef'
      Origin = 'tblsales.SOProgressPaymentOriginalRef'
      Size = 255
    end
    object tblMasterTotalInvoicePayment: TFloatField [111]
      FieldKind = fkCalculated
      FieldName = 'TotalInvoicePayment'
      currency = True
      Calculated = True
    end
    object tblMasterInvoiceBalance: TFloatField [112]
      FieldKind = fkCalculated
      FieldName = 'InvoiceBalance'
      currency = True
      Calculated = True
    end
    object tblMasterProgressPaymentInvRef: TWideStringField [113]
      FieldName = 'ProgressPaymentInvRef'
      Origin = 'tblsales.ProgressPaymentInvRef'
      Size = 255
    end
    object tblMasterProgressPaymentSeqno: TIntegerField [114]
      FieldName = 'ProgressPaymentSeqno'
      Origin = 'tblsales.ProgressPaymentSeqno'
    end
    object tblMasterSOInvoiced: TWideStringField [115]
      FieldName = 'SOInvoiced'
      Origin = 'tblsales.SOInvoiced'
      FixedChar = True
      Size = 1
    end
    object tblMasterSOInvoiceRef: TWideStringField [116]
      FieldName = 'SOInvoiceRef'
      Origin = 'tblsales.SOInvoiceRef'
      Size = 255
    end
    object tblMasterIsInternalOrder: TWideStringField
      FieldName = 'IsInternalOrder'
      Origin = 'tblsales.IsInternalOrder'
      FixedChar = True
      Size = 1
    end
  end
  inherited tblDetails: TERPQuery
    AfterInsert = tblDetailsAfterInsert
    Left = 47
    Top = 332
    inherited tblDetailsAttrib1Sale: TFloatField
      OnSetText = FeldSetTextDontAllowNulls
    end
    inherited tblDetailsAttrib2Sale: TFloatField
      OnSetText = FeldSetTextDontAllowNulls
    end
    inherited tblDetailsAttrib1SaleRate: TFloatField
      OnSetText = FeldSetTextDontAllowNulls
    end
    inherited tblDetailsCalcGrossProfitPercentInc: TFloatField
      DisplayFormat = '0.0%'
    end
    object tblDetailsDocketNumber: TWideStringField [32]
      DisplayLabel = 'Docket Number'
      DisplayWidth = 20
      FieldName = 'DocketNumber'
      Origin = 'tblsaleslines.DocketNumber'
      Size = 255
    end
    object tblDetailsWarrantyEndsOn: TDateField [33]
      DisplayLabel = 'Warranty Ends On'
      DisplayWidth = 10
      FieldName = 'WarrantyEndsOn'
      Origin = 'tblsaleslines.WarrantyEndsOn'
    end
    object tblDetailsWarrantyPeriod: TWideStringField [34]
      DisplayLabel = 'Warranty Period'
      DisplayWidth = 20
      FieldName = 'WarrantyPeriod'
      Origin = 'tblsaleslines.WarrantyPeriod'
      Size = 100
    end
    object tblDetailsAutoSmartOrder: TWideStringField [43]
      DisplayLabel = 'Auto Create Order?'
      DisplayWidth = 1
      FieldName = 'AutoSmartOrder'
      Origin = 'tblsaleslines.AutoSmartOrder'
      FixedChar = True
      Size = 1
    end
    object tblDetailsSmartOrderCreated: TWideStringField [44]
      DisplayLabel = 'Ordered?'
      DisplayWidth = 1
      FieldName = 'SmartOrderCreated'
      Origin = 'tblsaleslines.SmartOrderCreated'
      FixedChar = True
      Size = 1
    end
    inherited tblDetailsShipContainerName: TWideStringField
      DisplayLabel = 'Ship Container Name'
    end
    object tblDetailsProgresspaymentRef: TWideStringField [79]
      DisplayLabel = 'Progress Payment Ref'
      DisplayWidth = 10
      FieldName = 'ProgresspaymentRef'
      Origin = 'tblsaleslines.ProgresspaymentRef'
      Size = 255
    end
    object tblDetailsBOMGroupedLine: TWideStringField [100]
      DisplayWidth = 1
      FieldName = 'BOMGroupedLine'
      Origin = 'tblsaleslines.BOMGroupedLine'
      FixedChar = True
      Size = 1
    end
    object tblDetailsBOMProductionLine: TWideStringField [101]
      DisplayWidth = 1
      FieldName = 'BOMProductionLine'
      Origin = 'tblsaleslines.BOMProductionLine'
      FixedChar = True
      Size = 1
    end
    object tblDetailsAssembled: TWideStringField [107]
      DisplayWidth = 1
      FieldName = 'Assembled'
      Origin = 'tblsaleslines.Assembled'
      FixedChar = True
      Size = 1
    end
    object tbldetailsPPGInvoiced: TWideStringField [115]
      FieldName = 'PPGInvoiced'
      Origin = 'tblsaleslines.PPGInvoiced'
      FixedChar = True
      Size = 1
    end
    object tbldetailsPPGRef: TWideStringField [116]
      FieldName = 'PPGRef'
      Origin = 'tblsaleslines.PPGRef'
      Size = 255
    end
    object tblDetailsExcludeFromSmartOrder: TWideStringField [124]
      DisplayWidth = 1
      FieldName = 'ExcludeFromSmartOrder'
      FixedChar = True
      Size = 1
    end
    object tblDetailsLastUpdated: TDateTimeField [126]
      DisplayWidth = 18
      FieldName = 'LastUpdated'
      Origin = 'tblsaleslines.LastUpdated'
      Visible = False
    end
    object tblDetailsHireID: TIntegerField [127]
      DisplayWidth = 10
      FieldName = 'HireID'
      Origin = 'tblsaleslines.HireID'
      Visible = False
    end
    object tblDetailsHireSerials: TWideMemoField [128]
      DisplayWidth = 10
      FieldName = 'HireSerials'
      Origin = 'tblsaleslines.HireSerials'
      Visible = False
      BlobType = ftWideMemo
    end
    object tblDetailsIsQuote: TWideStringField [129]
      DisplayWidth = 1
      FieldName = 'IsQuote'
      Origin = 'tblsaleslines.IsQuote'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsHireToBeReturned: TDateField [130]
      DisplayWidth = 10
      FieldName = 'HireToBeReturned'
      Origin = 'tblsaleslines.HireToBeReturned'
      Visible = False
    end
    inherited tblDetailsSortId: TIntegerField
      DisplayLabel = 'Sort ID'
      Visible = True
    end
    object tblDetailsVoucherNo: TWideStringField
      DisplayWidth = 255
      FieldName = 'VoucherNo'
      Size = 255
    end
    object tblDetailsSOInvoiceLineRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'SOInvoiceLineRef'
      Size = 255
    end
  end
  inherited cboClientLookup: TERPQuery
    Left = 163
    Top = 332
    inherited cboClientLookupCompany: TWideStringField
      DisplayWidth = 30
    end
    inherited cboClientLookupBillStreet3: TWideStringField [2]
      Visible = False
    end
    inherited cboClientLookupClientID: TAutoIncField [3]
    end
    inherited cboClientLookupTERMS: TWideStringField [4]
    end
    inherited cboClientLookupTermsID: TIntegerField [5]
    end
    inherited cboClientLookupShippingMethod: TWideStringField [6]
    end
    inherited cboClientLookupShippingID: TIntegerField [7]
    end
    inherited cboClientLookupRepID: TIntegerField [8]
    end
    inherited cboClientLookupTaxID: TIntegerField [9]
    end
    inherited cboClientLookupForcePOOnInvoice: TWideStringField [10]
    end
    inherited cboClientLookupStreet: TWideStringField [11]
      Visible = False
    end
    inherited cboClientLookupStreet2: TWideStringField [12]
      Visible = False
    end
    inherited cboClientLookupSuburb: TWideStringField [13]
      Visible = False
    end
    inherited cboClientLookupState: TWideStringField [14]
      Visible = False
    end
    inherited cboClientLookupCountry: TWideStringField [15]
      Visible = False
    end
    inherited cboClientLookupPostcode: TWideStringField [16]
      Visible = False
    end
    inherited cboClientLookupBillStreet: TWideStringField [17]
      Visible = False
    end
    inherited cboClientLookupBillStreet2: TWideStringField [18]
      Visible = False
    end
    inherited cboClientLookupBillSuburb: TWideStringField [19]
      Visible = False
    end
    inherited cboClientLookupBillState: TWideStringField [20]
      Visible = False
    end
    inherited cboClientLookupBillPostcode: TWideStringField [21]
      Visible = False
    end
    inherited cboClientLookupBillCountry: TWideStringField [22]
      Visible = False
    end
    inherited cboClientLookupUseInvBase: TWideStringField [23]
      Visible = False
    end
    inherited cboClientLookupInvBaseNumber: TIntegerField [24]
      Visible = False
    end
    inherited cboClientLookupPhone: TWideStringField [25]
      Visible = False
    end
    inherited cboClientLookupFax: TWideStringField [26]
      Visible = False
    end
    inherited cboClientLookupAltPhone: TWideStringField [27]
      Visible = False
    end
    inherited cboClientLookupDefaultPostAccount: TWideStringField [28]
      Visible = False
    end
    inherited cboClientLookupDefaultPostAccountID: TIntegerField [29]
      Visible = False
    end
    inherited cboClientLookupWarrantyFinishDate: TDateTimeField [30]
      Visible = False
    end
    inherited cboClientLookupIsJob: TWideStringField [31]
      Visible = False
    end
    inherited cboClientLookupStreet3: TWideStringField [32]
      Visible = False
    end
    inherited cboClientLookupStopCredits: TWideStringField
      Visible = False
    end
  end
  inherited cboEmployeeLookup: TERPQuery
    Connection = MyConnection
    AutoCalcFields = False
    Left = 250
    Top = 332
  end
  inherited cboClassQry: TERPQuery
    Left = 192
    Top = 332
  end
  inherited qryBaseForeignCurrency: TERPQuery
    Left = 569
    Top = 332
  end
  inherited qryClientLookup: TERPQuery
    Left = 859
    Top = 332
  end
  inherited imgPopup: TImageList
    Left = 513
    Top = 303
    Bitmap = {
      494C01010400D402300510001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
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
      0000000000008080800080808000000000000000000080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000080000000000080808000000000000000FF0000008000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000008000000080000080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF0000008000808080000000FF000000800000000000808080000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000000080000000800000808080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000008000000080000000800080808000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000008000000000800000008000008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080008080800080808000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000008000000000FF0000008000000080000080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000008000000080000000800080808000808080000000
      00000000000000000000000000000000000000000000000000000000000000FF
      000000800000800000000000000000FF00000080000000800000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000FF0000008000808080000000FF0000008000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000800000008000008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000800000008000808080000000FF0000008000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000008000000080
      0000808080000000000000000000000000000000000000000000000000000000
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
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000E00FFDFFFFFFFFFFE00FF8FFFFFFFFFF
      E00FF8FFFFFFFFFFF00FF87FFFFFFFFFF00FF81FF98FF9FFF80FF80FE10FF0FF
      F007F00FF01FE07FF007E00FF83FE03FF007E00FFC3FE01FF00FE00FF81FE20F
      F01FF01FF00FFF07F81FF00FF00FFF87FE1FF00FFFFFFFFFFF1FF007FFFFFFFF
      FF1FF007FFFFFFFFFFBFF007FFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  inherited ProgDialog: TProgressDialog
    Left = 589
    Top = 303
  end
  inherited qryUnitOfMeasure: TERPQuery
    Left = 453
    Top = 332
  end
  inherited mnuDiscountTotal: TAdvPopupMenu
    Left = 94
    Top = 303
    object mnuPrintAddressLabel: TMenuItem [5]
      Caption = 'Print Address Label'
      HelpContext = 372175
      OnClick = mnuPrintAddressLabelClick
    end
  end
  inherited cboAccountQry: TERPQuery
    Left = 424
    Top = 332
  end
  inherited qrySupplier: TERPQuery
    Left = 308
    Top = 332
  end
  inherited DMTextTargetSales: TDMTextTarget
    Left = 208
    Top = 303
  end
  inherited qryPartsSpecs: TERPQuery
    Left = 714
    Top = 332
  end
  inherited cboTermsQry: TERPQuery
    Left = 337
    Top = 332
  end
  inherited dlgMemoLine: TwwMemoDialog
    Left = 246
    Top = 303
  end
  object tmrMonitor: TTimer [35]
    Enabled = False
    Interval = 200
    OnTimer = tmrMonitorTimer
    Left = 856
    Top = 303
  end
  inherited tblFESalesLines: TERPQuery
    Left = 76
    Top = 332
  end
  inherited tblFESaleslinesRelatedPrs: TERPQuery
    Left = 105
    Top = 332
  end
  inherited dsFESalesLines: TDataSource
    Left = 76
    Top = 361
  end
  inherited dsFESaleslinesRelatedPrs: TDataSource
    Left = 105
    Top = 361
  end
  object qryContacts: TERPQuery [40]
    SQL.Strings = (
      'SELECT * FROM tblcontacts WHERE Company = :xCompany')
    Left = 830
    Top = 332
    ParamData = <
      item
        DataType = ftString
        Name = 'xCompany'
        Value = ''
      end>
  end
  inherited qryShipContainerSaleLookup: TERPQuery
    Left = 627
    Top = 332
  end
  inherited tblEquipmentxRefs: TERPQuery
    Left = 366
    Top = 332
  end
  inherited cboProductQry: TERPQuery
    Left = 540
    Top = 332
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 360
    Top = 303
  end
  inherited MyConnection: TERPConnection
    Database = ''
    Left = 18
    Top = 303
  end
  inherited Qrysalesshippingdetails: TERPQuery
    Left = 656
    Top = 332
  end
  inherited qryUOMLookup: TMyQuery
    Left = 801
    Top = 332
  end
  inherited QryRelatedMaster: TERPQuery
    Left = 598
    Top = 332
  end
  inherited DataState: TDataState
    Left = 398
    Top = 303
  end
  inherited QrySalesCAtegory: TERPQuery
    Top = 332
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 56
    Top = 303
  end
  inherited imgsort: TImageList
    Left = 551
    Top = 303
    Bitmap = {
      494C01010200E802440510001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited QryTransStatus: TERPQuery
    Left = 743
    Top = 332
  end
  inherited QryAreaCodeLk: TERPQuery
    Left = 685
    Top = 332
  end
  inherited cbTaxCodeQry: TERPQuery
    Left = 395
    Top = 332
  end
  inherited qryMemTrans: TERPQuery
    Left = 511
    Top = 332
  end
  inherited SaveDialog1: TSaveDialog
    Left = 322
    Top = 303
  end
  inherited QryCustomField: TERPQuery
    Left = 221
    Top = 332
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 437
    Top = 303
  end
  inherited TmrCommentshint: TTimer
    Left = 741
    Top = 303
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 475
    Top = 303
  end
  inherited cboViaQry: TERPQuery
    Left = 279
    Top = 332
  end
  inherited QryAreaCodes: TERPQuery
    Left = 482
    Top = 332
  end
  inherited qrySalesQuantities: TERPQuery
    Left = 134
    Top = 332
  end
  inherited tmrShipToMessage: TTimer
    Left = 817
    Top = 303
  end
  object dssalesdeliverydetails: TDataSource [69]
    DataSet = qrysalesdeliverydetails
    Left = 915
    Top = 362
  end
  object qrysalesdeliverydetails: TERPQuery [70]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblsalesdeliverydetails'
      'WHERE SaleID = :ID')
    Left = 918
    Top = 332
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object qrysalesdeliverydetailsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qrysalesdeliverydetailsID: TIntegerField
      FieldName = 'ID'
    end
    object qrysalesdeliverydetailsSaleID: TIntegerField
      FieldName = 'SaleID'
    end
    object qrysalesdeliverydetailsPlannedDelfromDt: TDateField
      FieldName = 'PlannedDelfromDt'
    end
    object qrysalesdeliverydetailsPlannedDelfromTime: TWideStringField
      FieldName = 'PlannedDelfromTime'
      Size = 50
    end
    object qrysalesdeliverydetailsPlannedDelToDt: TDateField
      FieldName = 'PlannedDelToDt'
    end
    object qrysalesdeliverydetailsPlannedDeltotime: TWideStringField
      FieldName = 'PlannedDeltotime'
      Size = 50
    end
    object qrysalesdeliverydetailsPlannedDelFrom: TDateTimeField
      FieldName = 'PlannedDelFrom'
    end
    object qrysalesdeliverydetailsPlannedDelto: TDateTimeField
      FieldName = 'PlannedDelto'
    end
    object qrysalesdeliverydetailsPromisedDelDt: TDateField
      FieldName = 'PromisedDelDt'
    end
    object qrysalesdeliverydetailsPromisedDeltime: TWideStringField
      FieldName = 'PromisedDeltime'
      Size = 50
    end
    object qrysalesdeliverydetailsPromisedDel: TDateTimeField
      FieldName = 'PromisedDel'
    end
    object qrysalesdeliverydetailsCauseofDelayID: TIntegerField
      FieldName = 'CauseofDelayID'
    end
    object qrysalesdeliverydetailsCauseofDelay: TWideStringField
      FieldName = 'CauseofDelay'
      Size = 255
    end
    object qrysalesdeliverydetailsActualDelDt: TDateField
      FieldName = 'ActualDelDt'
    end
    object qrysalesdeliverydetailsActualDeltime: TWideStringField
      FieldName = 'ActualDeltime'
      Size = 50
    end
    object qrysalesdeliverydetailsActualDel: TDateTimeField
      FieldName = 'ActualDel'
    end
    object qrysalesdeliverydetailsFeedBack: TWideMemoField
      FieldName = 'FeedBack'
      BlobType = ftWideMemo
    end
    object qrysalesdeliverydetailsmstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
    end
    object qrysalesdeliverydetailsSalesglobalref: TWideStringField
      FieldName = 'Salesglobalref'
      Size = 255
    end
  end
  inherited qryCostCentre: TERPQuery
    Left = 772
    Top = 332
  end
end
