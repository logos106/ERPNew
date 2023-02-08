inherited QuoteGUI: TQuoteGUI
  Left = 412
  Top = 111
  HelpContext = 460000
  Caption = 'Quote'
  ClientHeight = 564
  ClientWidth = 996
  ExplicitLeft = 412
  ExplicitTop = 111
  ExplicitWidth = 1012
  ExplicitHeight = 603
  DesignSize = (
    996
    564)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 414
    Width = 996
    HelpContext = 460122
    ExplicitTop = 414
    ExplicitWidth = 996
  end
  inherited shapehint: TShape
    Left = 12
    ExplicitLeft = 12
  end
  inherited imgGridWatermark: TImage
    HelpContext = 460001
  end
  inherited shapehintextra1: TShape
    Left = 56
    ExplicitLeft = 56
  end
  inherited pnlDetail: TDNMPanel
    Top = 265
    Width = 996
    Height = 149
    HelpContext = 460119
    Align = alClient
    ExplicitTop = 265
    ExplicitWidth = 996
    ExplicitHeight = 149
    inherited grdTransactions: TwwDBGrid
      Width = 996
      Height = 133
      HelpContext = 460121
      Selected.Strings = (
        'SeqNo'#9'6'#9'No'#9#9
        'PartBarcode'#9'20'#9'Barcode'#9#9
        'ProductName'#9'17'#9'Product'#9#9
        'UnitofMeasureSaleLines'#9'10'#9'Units'#9#9
        'Attrib1Sale'#9'6'#9'Metres ?'#9#9
        'Attrib2Sale'#9'6'#9'Weight'#9#9
        'Attrib1SaleRate'#9'10'#9'Metres ? Rate'#9#9
        'SpecDescription'#9'17'#9'Specifications'#9#9
        'SpecValue'#9'10'#9'Spec Qty'#9#9
        'Product_Description'#9'20'#9'Description'#9#9
        'Product_Description_Memo'#9'10'#9'Product Description Memo'#9#9
        'CostCentreName'#9'20'#9'Cost Centre'#9#9
        'LineCostInc'#9'10'#9'Cost (Inc)'#9#9
        'LinePriceInc'#9'10'#9'Price (Inc)'#9#9
        'ForeignCurrencyLinePrice'#9'10'#9'Foreign Amount'#9#9
        'CalcProfit'#9'10'#9'Profit (Inc)'#9#9
        'CalcProfitPercent'#9'7'#9'% Profit (Inc)'#9#9
        'CalcGrossProfitPercentInc'#9'10'#9'Gross % (based on Avg Cost)'#9#9
        'LatestCostPriceInc'#9'10'#9'Latest Cost (Inc)'#9#9
        'LineTaxCode'#9'15'#9'Code'#9#9
        'LineTax'#9'10'#9'Tax (Dbl Click)'#9#9
        'Discounts'#9'10'#9'Discount ($)'#9#9
        'TotalLineAmountInc'#9'14'#9'Amount (Inc)'#9#9
        'Supplier'#9'20'#9'Supplier'#9#9
        'SupplierContact'#9'20'#9'Supplier Contact'#9#9
        'SalesLinesCustField1'#9'20'#9'SalesLinesCustField1'#9#9
        'SalesLinesCustField2'#9'20'#9'SalesLinesCustField2'#9#9
        'SalesLinesCustField3'#9'20'#9'SalesLinesCustField3'#9#9
        'SalesLinesCustField4'#9'20'#9'SalesLinesCustField4'#9#9
        'SalesLinesCustField5'#9'20'#9'SalesLinesCustField5'#9#9
        'SalesLinesCustField6'#9'20'#9'SalesLinesCustField6'#9#9
        'SalesLinesCustField7'#9'20'#9'SalesLinesCustField7'#9#9
        'SalesLinesCustField8'#9'20'#9'SalesLinesCustField8'#9#9
        'SalesLinesCustField9'#9'20'#9'SalesLinesCustField9'#9#9
        'SalesLinesCustField10'#9'20'#9'SalesLinesCustField10'#9#9
        'MemoLine'#9'10'#9'MemoLine'#9#9
        'ShipDate'#9'18'#9'Ship Date'#9#9
        'BaseLineno'#9'10'#9'BaseLineno'#9#9
        'ShipContainerName'#9'20'#9'ShipContainerName'#9#9
        'ShipContainerETA'#9'10'#9'ShipContainerETA'#9#9
        'Timecostused'#9'1'#9'Timecostused'#9#9
        'ProfitbasedLatestCost'#9'10'#9'GP (based on Latest Cost)'#9#9
        'ProfitbasedLatestCostPercent'#9'10'#9'GP% (based on Latest Cost)'#9#9
        'ProfitbasedLatestCostInc'#9'10'#9'GP(Ex) (based on Latest Cost)'#9#9
        
          'ProfitbasedLatestCostPercentInc'#9'10'#9'GP(Inc)% (based on Latest Cos' +
          't)'#9#9
        
          'GrossProfitbasedLatestCostPercentInc'#9'10'#9'GP% (based on Latest Cos' +
          't)'#9#9
        'UnitofMeasureQtySold'#9'6'#9'Ordered'#9#9
        'UOM_Height'#9'10'#9'UOM_Height'#9#9
        'UOM_Width'#9'10'#9'UOM_Width'#9#9
        'UOM_Length'#9'10'#9'UOM_Length'#9#9
        'UOM_Weight'#9'10'#9'UOM_Weight'#9#9
        'UOM_Volume'#9'10'#9'UOM_Volume'#9#9
        'Product_custFld1'#9'20'#9'Product_custFld1'#9#9
        'Product_custFld2'#9'20'#9'Product_custFld2'#9#9
        'Product_custFld3'#9'20'#9'Product_custFld3'#9#9
        'Product_custFld4'#9'20'#9'Product_custFld4'#9#9
        'Product_custFld5'#9'20'#9'Product_custFld5'#9#9
        'Product_custFld6'#9'20'#9'Product_custFld6'#9#9
        'Product_custFld7'#9'20'#9'Product_custFld7'#9#9
        'Product_custFld8'#9'20'#9'Product_custFld8'#9#9
        'Product_custFld9'#9'20'#9'Product_custFld9'#9#9
        'Product_custFld10'#9'20'#9'Product_custFld10'#9#9
        'Product_custFld11'#9'20'#9'Product_custFld11'#9#9
        'Product_custFld12'#9'20'#9'Product_custFld12'#9#9
        'Product_custFld13'#9'20'#9'Product_custFld13'#9#9
        'Product_custFld14'#9'20'#9'Product_custFld14'#9#9
        'Product_custFld15'#9'20'#9'Product_custFld15'#9#9
        'Product_custDate1'#9'18'#9'Product_custDate1'#9#9
        'Product_custDate2'#9'18'#9'Product_custDate2'#9#9
        'Product_custDate3'#9'18'#9'Product_custDate3'#9#9
        'WarrantyPeriod'#9'100'#9'WarrantyPeriod'#9#9
        'WarrantyEndsOn'#9'10'#9'WarrantyEndsOn'#9#9
        'MatrixDesc'#9'10'#9'Matrix Details'#9#9
        'MatrixPrice'#9'10'#9'Matrix Price'#9#9
        'TotalUOM_WeightSold'#9'10'#9'TotalUOM_WeightSold'#9#9
        'TotalUOM_WeightShipped'#9'10'#9'TotalUOM_WeightShipped'#9#9
        'TotalUOM_WeightBO'#9'10'#9'TotalUOM_WeightBO'#9#9
        'TotalUOM_LengthSold'#9'10'#9'TotalUOM_LengthSold'#9#9
        'TotalUOM_LengthShipped'#9'10'#9'TotalUOM_LengthShipped'#9#9
        'TotalUOM_LengthBO'#9'10'#9'TotalUOM_LengthBO'#9#9
        'Area'#9'20'#9'Area'#9#9
        'FormulaQtySoldValue1'#9'10'#9'FormulaQtySoldValue1'#9#9
        'FormulaQtySoldValue2'#9'10'#9'FormulaQtySoldValue2'#9#9
        'FormulaQtySoldValue3'#9'10'#9'FormulaQtySoldValue3'#9#9
        'FormulaQtySoldValue4'#9'10'#9'FormulaQtySoldValue4'#9#9
        'FormulaQtySoldValue5'#9'10'#9'FormulaQtySoldValue5'#9#9
        'FormulaQtyShippedValue1'#9'10'#9'FormulaQtyShippedValue1'#9#9
        'FormulaQtyShippedValue2'#9'10'#9'FormulaQtyShippedValue2'#9#9
        'FormulaQtyShippedValue3'#9'10'#9'FormulaQtyShippedValue3'#9#9
        'FormulaQtyShippedValue4'#9'10'#9'FormulaQtyShippedValue4'#9#9
        'FormulaQtyShippedValue5'#9'10'#9'FormulaQtyShippedValue5'#9#9
        'FormulaQtySoldValue'#9'10'#9'FormulaQtySoldValue'#9#9
        'FormulaQtyShippedValue'#9'10'#9'FormulaQtyShippedValue'#9#9
        'Attrib1SaleEst'#9'10'#9'Est Metres ?'#9#9
        'Attrib2SaleEst'#9'10'#9'Est Weight'#9#9
        'ISContainer'#9'1'#9'ISContainer'#9#9
        'IsPallet'#9'1'#9'IsPallet'#9#9
        'AreaQty'#9'10'#9'Area To Cover'#9#9
        'CustomerEquipmentID'#9'10'#9'CustomerEquipmentID'#9#9
        'Equipment'#9'10'#9'Equipment'#9#9
        'LinesOrder'#9'10'#9'Order by'#9#9
        'RequiresAssembly'#9'1'#9'Requires Assembly?'#9#9
        'ExcludeFromSmartOrder'#9'1'#9'ExcludeFromSmartOrder'#9'F'#9)
      ExplicitWidth = 996
      ExplicitHeight = 133
    end
    inherited cboTaxCode: TERPDbLookupCombo
      Left = 28
      TabOrder = 2
      ExplicitLeft = 28
    end
    inherited cboUnitOfMeasure: TwwDBLookupCombo
      TabOrder = 10
    end
    inherited cboSupplier: TERPDbLookupCombo
      Top = 21
      TabOrder = 3
      ExplicitTop = 21
    end
    inherited cboCostCentre: TwwDBLookupCombo
      Left = 523
      Top = 21
      TabOrder = 4
      ExplicitLeft = 523
      ExplicitTop = 21
    end
    inherited cboPartSpecs: TwwDBLookupCombo
      Left = 655
      Top = 17
      TabOrder = 5
      ExplicitLeft = 655
      ExplicitTop = 17
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
      TabOrder = 9
    end
    inherited ProgressBar: TProgressBar
      Top = 133
      Width = 996
      HelpContext = 460151
      TabOrder = 1
      ExplicitTop = 133
      ExplicitWidth = 996
    end
    inherited edtMemoLine: TwwDBEdit
      TabOrder = 6
    end
    inherited cboLinesAreaCode: TwwDBLookupCombo
      TabOrder = 7
    end
    inherited cboPrintProductR: TERPDbLookupCombo
      TabOrder = 8
    end
  end
  inherited pnlFooter: TDNMPanel
    Top = 414
    Width = 996
    Height = 150
    HelpContext = 460002
    Align = alBottom
    ExplicitTop = 414
    ExplicitWidth = 996
    ExplicitHeight = 150
    DesignSize = (
      996
      150)
    object Bevel3: TBevel [0]
      Left = 3
      Top = 116
      Width = 245
      Height = 34
      HelpContext = 460123
      Style = bsRaised
    end
    inherited lblComments: TLabel
      Top = 5
      ExplicitTop = 5
    end
    inherited Label142: TLabel
      Left = 812
      Top = 61
      HelpContext = 460005
      ExplicitLeft = 812
      ExplicitTop = 61
    end
    inherited Label54: TLabel
      Left = 813
      Top = 93
      HelpContext = 460006
      ExplicitLeft = 813
      ExplicitTop = 93
    end
    inherited Label93: TLabel
      Width = 22
      Height = 18
      HelpContext = 460018
      Enabled = False
      Visible = False
      ExplicitWidth = 22
      ExplicitHeight = 18
    end
    inherited Label56: TLabel
      Left = 817
      Top = 126
      Width = 41
      Height = 17
      HelpContext = 460007
      ExplicitLeft = 773
      ExplicitTop = 126
      ExplicitWidth = 41
      ExplicitHeight = 17
    end
    inherited Label122: TLabel
      Left = 640
      Top = 98
      Width = 43
      Height = 15
      HelpContext = 460020
      AutoSize = True
      ExplicitLeft = 640
      ExplicitTop = 98
      ExplicitWidth = 43
      ExplicitHeight = 15
    end
    inherited Label5: TLabel
      Left = 633
      Top = 69
      Width = 50
      Height = 15
      HelpContext = 460021
      AutoSize = True
      ExplicitLeft = 633
      ExplicitTop = 69
      ExplicitWidth = 50
      ExplicitHeight = 15
    end
    inherited lblBaseForeignTotal: TLabel
      Left = 641
      Top = 127
      Width = 42
      Height = 15
      HelpContext = 460011
      AutoSize = True
      Visible = True
      ExplicitLeft = 641
      ExplicitTop = 127
      ExplicitWidth = 42
      ExplicitHeight = 15
    end
    object lblAmountToAppearOnPrintout: TLabel [9]
      Left = 17
      Top = 119
      Width = 104
      Height = 30
      HelpContext = 460048
      Alignment = taRightJustify
      Caption = 'Amount to Appear on Printout'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label4: TLabel [10]
      Left = 0
      Top = 77
      Width = 68
      Height = 30
      HelpContext = 460124
      Alignment = taRightJustify
      Caption = 'Picking Instructions'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    inherited Label101: TLabel
      Top = 119
      ExplicitTop = 119
    end
    inherited lblContributionAmount: TLabel
      Left = 614
      Top = 32
      Width = 69
      Height = 30
      HelpContext = 460125
      AutoSize = True
      Caption = 'Contribution Amount'
      ExplicitLeft = 614
      ExplicitTop = 32
      ExplicitWidth = 69
      ExplicitHeight = 30
    end
    inherited Label12: TLabel
      Left = 528
      Top = 94
      Visible = False
      ExplicitLeft = 484
      ExplicitTop = 94
    end
    inherited lblApprovedAmount: TLabel
      Left = 626
      ExplicitLeft = 626
    end
    inherited pnlComments: TDNMPanel
      Left = 85
      Top = 5
      Width = 536
      HelpContext = 460165
      TabOrder = 16
      ExplicitLeft = 85
      ExplicitTop = 5
      ExplicitWidth = 536
      inherited LblCommentsHint: TLabel
        Width = 534
        HelpContext = 460166
        ExplicitLeft = 0
        ExplicitTop = 35
        ExplicitWidth = 534
      end
      inherited txtComments: TDBMemo
        Width = 534
        HelpContext = 460013
        ExplicitWidth = 534
      end
    end
    inherited txtSubTotal: TDBEdit
      Left = 879
      Top = 58
      HelpContext = 460014
      TabOrder = 10
      ExplicitLeft = 879
      ExplicitTop = 58
    end
    inherited txtTotalTax: TDBEdit
      Left = 879
      Top = 89
      HelpContext = 460015
      TabOrder = 11
      ExplicitLeft = 879
      ExplicitTop = 89
    end
    inherited txtTotalDiscount: TDBEdit
      Left = 685
      Top = 64
      HelpContext = 460034
      TabOrder = 7
      ExplicitLeft = 685
      ExplicitTop = 64
    end
    inherited txtPickMemo: TDBMemo
      Top = 65
      Width = 536
      Height = 54
      HelpContext = 460036
      ScrollBars = ssVertical
      TabOrder = 0
      ExplicitTop = 65
      ExplicitWidth = 536
      ExplicitHeight = 54
    end
    inherited txtTotalMarkup: TDBEdit
      Left = 685
      Top = 93
      Width = 82
      HelpContext = 460038
      TabOrder = 22
      ExplicitLeft = 685
      ExplicitTop = 93
      ExplicitWidth = 82
    end
    inherited txtTotalAmount: TDBEdit
      Left = 865
      Top = 121
      HelpContext = 460016
      TabOrder = 12
      ExplicitLeft = 865
      ExplicitTop = 121
    end
    inherited edtBaseForeignTotal: TDBEdit
      Left = 685
      Top = 122
      Width = 82
      HelpContext = 460017
      DataField = 'ForeignTotalAmount'
      TabOrder = 9
      Visible = True
      ExplicitLeft = 685
      ExplicitTop = 122
      ExplicitWidth = 82
    end
    inherited lblDisableCalc: TDNMSpeedButton
      Left = 848
      Top = 5
      TabOrder = 14
      ExplicitLeft = 848
      ExplicitTop = 5
    end
    inherited btnAttachments: TDNMSpeedButton
      Left = 5
      Top = 25
      HelpContext = 460043
      TabOrder = 13
      ExplicitLeft = 5
      ExplicitTop = 25
    end
    object txtTotalQuoteAmount: TDBEdit [25]
      Left = 127
      Top = 124
      Width = 114
      Height = 21
      HelpContext = 460049
      TabStop = False
      AutoSize = False
      DataField = 'TotalQuoteAmount'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnEnter = txtTotalQuoteAmountEnter
      OnExit = txtTotalQuoteAmountExit
    end
    inherited DNMPanel5: TDNMPanel
      Height = 113
      HelpContext = 460126
      TabOrder = 17
      Visible = False
      ExplicitHeight = 113
      inherited lblEnteredbyHead: TLabel
        Top = 1
        ExplicitTop = 1
      end
      inherited lblEnteredBy: TDBText
        Width = 69
        Height = 15
        HelpContext = 460127
        ExplicitWidth = 69
        ExplicitHeight = 15
      end
      inherited lblPrintHead: TLabel
        Top = 46
        ExplicitTop = 46
      end
      inherited lblPrintedBy: TLabel
        Top = 46
        Width = 67
        HelpContext = 460128
        AutoSize = False
        ExplicitTop = 46
        ExplicitWidth = 67
      end
      inherited lblPrintedOnCaption: TLabel
        Top = 69
        ExplicitTop = 69
      end
      inherited lblPrintedOn: TLabel
        Left = 77
        Top = 69
        Width = 65
        Height = 15
        HelpContext = 460129
        ExplicitLeft = 77
        ExplicitTop = 69
        ExplicitWidth = 65
        ExplicitHeight = 15
      end
      inherited lblPrintedAtCaption: TLabel
        Top = 92
        ExplicitTop = 92
      end
      inherited lblPrintedAt: TLabel
        Top = 92
        Width = 64
        Height = 15
        HelpContext = 460130
        ExplicitTop = 92
        ExplicitWidth = 64
        ExplicitHeight = 15
      end
      inherited lblEnteredAtHead: TLabel
        Top = 23
        ExplicitTop = 23
      end
      inherited lblEnteredAt: TDBText
        Top = 23
        Width = 66
        Height = 15
        HelpContext = 460131
        DataField = 'EnteredAtShort'
        ExplicitTop = 23
        ExplicitWidth = 66
        ExplicitHeight = 15
      end
    end
    inherited lblEmail: TDNMPanel
      Left = 780
      Top = 5
      HelpContext = 460170
      TabOrder = 21
      ExplicitLeft = 780
      ExplicitTop = 5
      inherited lblEmailMsg: TLabel
        Left = 25
        Top = 0
        ExplicitLeft = 25
        ExplicitTop = 0
      end
    end
    inherited dnmpanle6: TDNMPanel [28]
      Height = 148
      HelpContext = 460132
      TabOrder = 15
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
        ExplicitTop = 55
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
      inherited lblOrdered: TLabel
        Visible = False
      end
      inherited lblOrdTitle: TLabel
        Visible = False
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
    inherited txtConNote: TDBEdit [29]
      Top = 123
      TabOrder = 2
      ExplicitTop = 123
    end
    inherited edtContributionAmount: TwwDBEdit [30]
      Left = 685
      Top = 35
      ParentColor = True
      TabOrder = 6
      ExplicitLeft = 685
      ExplicitTop = 35
    end
    inherited Label11: TDNMSpeedButton [31]
      Left = 484
      Top = 71
      Visible = False
      ExplicitLeft = 484
      ExplicitTop = 71
    end
    inherited edtPayment: TDBEdit [32]
      Left = 757
      Top = 63
      Width = 61
      HelpContext = 460133
      TabOrder = 3
      Visible = False
      ExplicitLeft = 757
      ExplicitTop = 63
      ExplicitWidth = 61
    end
    inherited edtBalance: TDBEdit [33]
      Left = 755
      Top = 86
      Width = 61
      HelpContext = 460134
      TabOrder = 4
      Visible = False
      ExplicitLeft = 755
      ExplicitTop = 86
      ExplicitWidth = 61
    end
    inherited edtApprovedAmount: TDBEdit [34]
      Left = 685
      Top = 6
      Width = 88
      HelpContext = 460135
      TabOrder = 5
      ExplicitLeft = 685
      ExplicitTop = 6
      ExplicitWidth = 88
    end
    inherited btnSignature: TDNMSpeedButton [35]
      Left = 5
      Top = 51
      ExplicitLeft = 5
      ExplicitTop = 51
    end
    inherited btnAddFreight: TDNMSpeedButton [36]
      Left = 770
      Top = 114
      Width = 47
      Height = 34
      HelpContext = 460167
      ExplicitLeft = 770
      ExplicitTop = 114
      ExplicitWidth = 47
      ExplicitHeight = 34
    end
    inherited pnlProcessMessage: TDNMPanel [37]
      Width = 996
      HelpContext = 460168
      ExplicitWidth = 996
      inherited lblProcessMessage: TLabel
        Width = 992
        HelpContext = 460120
        ExplicitLeft = 248
        ExplicitWidth = 746
      end
    end
  end
  inherited pnlHeader: TDNMPanel
    Top = 0
    Width = 996
    Height = 265
    HelpContext = 460051
    Align = alTop
    ParentColor = True
    ExplicitTop = 0
    ExplicitWidth = 996
    ExplicitHeight = 265
    DesignSize = (
      996
      265)
    object Bevel1: TBevel [0]
      Left = 253
      Top = 60
      Width = 144
      Height = 47
      HelpContext = 460105
    end
    object bvlForeign: TBevel [1]
      Left = 399
      Top = 60
      Width = 207
      Height = 47
      HelpContext = 460136
    end
    inherited bvelCustomerDetails: TBevel
      Top = 115
      Height = 109
      HelpContext = 460137
      ExplicitTop = 115
      ExplicitHeight = 109
    end
    inherited Bvlshipto: TBevel
      Top = 115
      Width = 274
      Height = 109
      HelpContext = 460138
      ExplicitTop = 115
      ExplicitWidth = 274
      ExplicitHeight = 109
    end
    inherited Label38: TLabel
      Left = 9
      Top = 41
      Width = 144
      HelpContext = 460052
      ExplicitLeft = 9
      ExplicitTop = 41
      ExplicitWidth = 144
    end
    inherited lblClientDetails: TLabel
      Left = 14
      Top = 117
      Width = 74
      HelpContext = 460053
      Caption = 'Quote To'
      ExplicitLeft = 14
      ExplicitTop = 117
      ExplicitWidth = 74
    end
    inherited SaleDate_Label: TLabel
      Left = 620
      Top = 41
      HelpContext = 460054
      ExplicitLeft = 620
      ExplicitTop = 41
    end
    inherited Label160: TLabel
      Left = 822
      Top = 41
      Width = 69
      HelpContext = 460055
      Caption = 'Quote No'
      ExplicitLeft = 822
      ExplicitTop = 41
      ExplicitWidth = 69
    end
    inherited ClassLabel: TLabel
      Left = 259
      Top = 64
      Width = 135
      Height = 15
      HelpContext = 460082
      ExplicitLeft = 259
      ExplicitTop = 64
      ExplicitWidth = 135
      ExplicitHeight = 15
    end
    inherited Label43: TLabel
      Left = 56
      Top = 162
      Width = 18
      HelpContext = 460083
      Enabled = False
      Visible = False
      ExplicitLeft = 56
      ExplicitTop = 162
      ExplicitWidth = 18
    end
    inherited Label47: TLabel
      Left = 56
      Top = 162
      Width = 18
      HelpContext = 460084
      Enabled = False
      Visible = False
      ExplicitLeft = 56
      ExplicitTop = 162
      ExplicitWidth = 18
    end
    inherited Label79: TLabel
      Left = 80
      Top = 162
      Width = 18
      HelpContext = 460085
      Enabled = False
      Visible = False
      ExplicitLeft = 80
      ExplicitTop = 162
      ExplicitWidth = 18
    end
    inherited Label45: TLabel
      Left = 40
      Top = 162
      Width = 18
      HelpContext = 460086
      Enabled = False
      Visible = False
      ExplicitLeft = 40
      ExplicitTop = 162
      ExplicitWidth = 18
    end
    inherited lblAccount: TLabel
      Left = 8
      HelpContext = 460087
      Visible = False
      ExplicitLeft = 8
    end
    inherited Label48: TLabel
      Left = 805
      Top = 195
      Width = 9
      HelpContext = 460056
      Enabled = False
      Visible = False
      ExplicitLeft = 805
      ExplicitTop = 195
      ExplicitWidth = 9
    end
    object Label2: TLabel [15]
      Left = 468
      Top = 224
      Width = 22
      Height = 15
      HelpContext = 460106
      Caption = 'Rep'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel [16]
      Left = 581
      Top = 224
      Width = 83
      Height = 15
      HelpContext = 460107
      Caption = 'Follow Up Date'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    inherited lbMemTrans: TLabel
      Left = 753
      HelpContext = 460057
      ExplicitLeft = 753
    end
    inherited lblBaseForeignCurrencyCode: TLabel
      Left = 405
      Top = 64
      Width = 135
      Height = 15
      HelpContext = 460058
      Visible = True
      ExplicitLeft = 405
      ExplicitTop = 64
      ExplicitWidth = 135
      ExplicitHeight = 15
    end
    inherited Label10: TLabel
      Left = 218
      Top = 38
      Width = 35
      HelpContext = 460139
      Visible = True
      ExplicitLeft = 218
      ExplicitTop = 38
      ExplicitWidth = 35
    end
    inherited lblBaseExchangeRate: TLabel
      Left = 508
      Top = 64
      HelpContext = 460059
      ExplicitLeft = 508
      ExplicitTop = 64
    end
    object Label9: TLabel [21]
      Left = 9
      Top = 224
      Width = 59
      Height = 15
      HelpContext = 460109
      Caption = 'Reference'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Bevel6: TBevel [22]
      Left = 253
      Top = 107
      Width = 353
      Height = 116
      HelpContext = 460162
    end
    inherited lblStatus: TLabel
      Left = 355
      Top = 224
      Width = 37
      HelpContext = 460140
      AutoSize = True
      ExplicitLeft = 355
      ExplicitTop = 224
      ExplicitWidth = 37
    end
    inherited Label8: TLabel
      Top = 90
      ExplicitTop = 90
    end
    object lblconvertedtoRepairs: TLabel [27]
      Left = 451
      Top = 42
      Width = 160
      Height = 16
      HelpContext = 460141
      Caption = 'Repair Has Been Created'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
      WordWrap = True
    end
    object lblConverted: TLabel [28]
      Left = 287
      Top = 42
      Width = 65
      Height = 16
      HelpContext = 460142
      Caption = 'Converted'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
      WordWrap = True
    end
    object bvlVariation: TBevel [29]
      Left = 377
      Top = 112
      Width = 105
      Height = 21
      HelpContext = 460143
      ParentShowHint = False
      ShowHint = True
    end
    inherited lblArea: TLabel
      Left = 737
      Top = 41
      ExplicitLeft = 737
      ExplicitTop = 41
    end
    object Label3: TLabel [32]
      Left = 231
      Top = 224
      Width = 18
      Height = 15
      HelpContext = 460163
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
    inherited cboAccount: TwwDBLookupCombo [33]
      Left = 7
      Width = 170
      HelpContext = 460097
      TabOrder = 0
      Visible = False
      OnChange = cboAccountChange
      ExplicitLeft = 7
      ExplicitWidth = 170
    end
    inherited btnPrint: TDNMSpeedButton [34]
      Left = 899
      Top = 197
      HelpContext = 460070
      Action = nil
      Caption = 'Prin&t'
      TabOrder = 18
      OnClick = btnPrintClick
      ExplicitLeft = 899
      ExplicitTop = 197
    end
    inherited cboEmployee: TwwDBLookupCombo [35]
      Left = 468
      Top = 239
      Width = 111
      HelpContext = 460065
      OnNotInList = cboEmployeeNotInList
      ExplicitLeft = 468
      ExplicitTop = 239
      ExplicitWidth = 111
    end
    object btnConInvoice: TDNMSpeedButton [36]
      Left = 490
      Top = 166
      Width = 111
      Height = 25
      HelpContext = 460110
      Action = actConInvoice
      Caption = 'Copy To &Invoice'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      TabOrder = 25
      AutoDisableParentOnclick = True
    end
    object btnConCashSale: TDNMSpeedButton [37]
      Left = 259
      Top = 194
      Width = 111
      Height = 25
      HelpContext = 460111
      Action = actConCashSale
      Caption = 'Copy To Cash Sale'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
    end
    object btnConPOS: TDNMSpeedButton [38]
      Left = 490
      Top = 138
      Width = 111
      Height = 25
      HelpContext = 460113
      Action = actConPOS
      Caption = 'Copy To POS'
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
      TabOrder = 22
      AutoDisableParentOnclick = True
    end
    inherited btnContacts: TDNMSpeedButton [39]
      Left = 191
      Top = 56
      HelpContext = 460074
      TabOrder = 30
      ExplicitLeft = 191
      ExplicitTop = 56
    end
    object btnConSalesOrder: TDNMSpeedButton [40]
      Left = 491
      Top = 194
      Width = 111
      Height = 25
      HelpContext = 460114
      Action = actConSalesOrd
      Caption = 'Copy To Or&der'
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
      TabOrder = 28
      AutoDisableParentOnclick = True
    end
    object btnConQuote: TDNMSpeedButton [41]
      Left = 259
      Top = 166
      Width = 111
      Height = 25
      HelpContext = 460115
      Action = actConQuote
      Caption = 'Copy Quote'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      TabOrder = 23
      AutoDisableParentOnclick = True
    end
    inherited txtClientDetails: TDBMemo [42]
      Left = 14
      Top = 134
      Height = 84
      HelpContext = 460062
      ExplicitLeft = 14
      ExplicitTop = 134
      ExplicitHeight = 84
    end
    inherited editField: TEdit [43]
      Left = 676
      Top = 26
      Width = 22
      HelpContext = 460090
      TabOrder = 53
      ExplicitLeft = 676
      ExplicitTop = 26
      ExplicitWidth = 22
    end
    inherited btnPrepayment: TDNMSpeedButton [44]
      Left = 374
      Top = 166
      Width = 111
      Height = 25
      HelpContext = 460103
      TabOrder = 24
      ExplicitLeft = 374
      ExplicitTop = 166
      ExplicitWidth = 111
      ExplicitHeight = 25
    end
    object btnRepair: TDNMSpeedButton [45]
      Left = 374
      Top = 138
      Width = 111
      Height = 25
      HelpContext = 460117
      Caption = 'Copy To &Repair'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      TabOrder = 21
      AutoDisableParentOnclick = True
      OnClick = actRepairExecute
    end
    object edtReference: TwwDBEdit [46]
      Left = 9
      Top = 239
      Width = 216
      Height = 23
      HelpContext = 460118
      DataField = 'Reference'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    inherited cboBaseForeignCurrencyCode: TwwDBLookupCombo [47]
      Left = 405
      Top = 79
      Width = 95
      HelpContext = 460076
      TabOrder = 4
      Visible = True
      ExplicitLeft = 405
      ExplicitTop = 79
      ExplicitWidth = 95
    end
    inherited edtBaseExchangeRate: TwwDBEdit [48]
      Left = 507
      Top = 79
      Width = 95
      HelpContext = 460077
      TabOrder = 5
      ExplicitLeft = 507
      ExplicitTop = 79
      ExplicitWidth = 95
    end
    inherited pnlTitle: TDNMPanel [49]
      Left = 325
      Width = 206
      Height = 38
      HelpContext = 460079
      Caption = 'Quote'
      TabOrder = 50
      ExplicitLeft = 325
      ExplicitWidth = 206
      ExplicitHeight = 38
      inherited TitleShader: TShader
        Width = 204
        Height = 36
        HelpContext = 460080
        ExplicitWidth = 204
        ExplicitHeight = 36
        inherited TitleLabel: TLabel
          Width = 204
          Height = 36
          HelpContext = 460081
          Caption = 'Quote'
          ExplicitWidth = 204
          ExplicitHeight = 36
        end
      end
    end
    inherited btnRepairEquipment: TDNMSpeedButton [50]
      Top = 56
      TabOrder = 29
      ExplicitTop = 56
    end
    inherited btnPreview: TDNMSpeedButton [51]
      Left = 899
      Top = 159
      HelpContext = 460069
      Action = nil
      TabOrder = 42
      OnClick = btnPreviewClick
      ExplicitLeft = 899
      ExplicitTop = 159
    end
    inherited cboDueDate: TwwDBDateTimePicker [52]
      Left = 581
      Top = 239
      HelpContext = 460094
      TabOrder = 14
      ExplicitLeft = 581
      ExplicitTop = 239
    end
    inherited cmdDeliveryDocket: TDNMSpeedButton [53]
      Left = 788
      Top = 195
      Width = 13
      Height = 12
      HelpContext = 460095
      Enabled = False
      TabOrder = 36
      Visible = False
      ExplicitLeft = 788
      ExplicitTop = 195
      ExplicitWidth = 13
      ExplicitHeight = 12
    end
    inherited txtCustomID: TDBEdit [54]
      Left = 822
      Top = 56
      Width = 69
      HelpContext = 460064
      TabOrder = 8
      ExplicitLeft = 822
      ExplicitTop = 56
      ExplicitWidth = 69
    end
    inherited cboClientR: TERPDbLookupCombo [55]
      Width = 179
      HelpContext = 460144
      Selected.Strings = (
        'Company'#9'45'#9'Company'#9'F')
      TabOrder = 1
      OnExit = cboClientRExit
      ExplicitWidth = 179
    end
    inherited btnCompleted: TDNMSpeedButton [56]
      Left = 899
      Top = 83
      HelpContext = 460067
      TabOrder = 15
      ExplicitLeft = 899
      ExplicitTop = 83
    end
    inherited cmdPrintPick: TDNMSpeedButton [57]
      Left = 807
      Top = 195
      Width = 12
      Height = 12
      HelpContext = 460096
      Enabled = False
      TabOrder = 44
      Visible = False
      ExplicitLeft = 807
      ExplicitTop = 195
      ExplicitWidth = 12
      ExplicitHeight = 12
    end
    inherited btnPayments: TDNMSpeedButton [58]
      Left = 636
      Top = 8
      HelpContext = 460122
      TabOrder = 31
      ExplicitLeft = 636
      ExplicitTop = 8
    end
    inherited btnCreateJob: TDNMSpeedButton [59]
      Left = 374
      Top = 194
      Width = 111
      Height = 25
      HelpContext = 460145
      TabOrder = 27
      ExplicitLeft = 374
      ExplicitTop = 194
      ExplicitWidth = 111
      ExplicitHeight = 25
    end
    inherited pnlParentclient: TDNMPanel [60]
      HelpContext = 460171
      TabOrder = 33
    end
    object btnVariation: TDNMSpeedButton [61]
      Left = 374
      Top = 110
      Width = 111
      Height = 25
      HelpContext = 460146
      Action = actVariation
      Caption = 'Variation'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      TabOrder = 20
      AutoDisableParentOnclick = True
    end
    inherited cmdFax: TDNMSpeedButton [62]
      Left = 670
      Top = 162
      TabOrder = 52
      ExplicitLeft = 670
      ExplicitTop = 162
    end
    inherited cboSalesCategory: TwwDBLookupCombo [63]
      Left = 712
      Top = 86
      Width = 180
      HelpContext = 460147
      TabOrder = 9
      ExplicitLeft = 712
      ExplicitTop = 86
      ExplicitWidth = 180
    end
    inherited cmdEmail: TDNMSpeedButton [64]
      Left = 768
      Top = 162
      Width = 53
      HelpContext = 460148
      TabOrder = 41
      Visible = False
      ExplicitLeft = 768
      ExplicitTop = 162
      ExplicitWidth = 53
    end
    inherited btnPDF: TDNMSpeedButton [65]
      Left = 835
      Top = 162
      Width = 42
      HelpContext = 460149
      Visible = False
      ExplicitLeft = 835
      ExplicitTop = 162
      ExplicitWidth = 42
    end
    inherited btnEdit: TDNMSpeedButton [66]
      Left = 719
      Top = 162
      TabOrder = 34
      ExplicitLeft = 719
      ExplicitTop = 162
    end
    inherited cboVia: TwwDBLookupCombo [67]
      Left = 665
      Top = 195
      Width = 18
      Height = 18
      HelpContext = 460099
      Enabled = False
      TabOrder = 37
      Visible = False
      ExplicitLeft = 665
      ExplicitTop = 195
      ExplicitWidth = 18
      ExplicitHeight = 18
    end
    inherited btnClose: TDNMSpeedButton [68]
      Left = 899
      Top = 121
      HelpContext = 460068
      ExplicitLeft = 899
      ExplicitTop = 121
    end
    inherited cboTerms: TwwDBLookupCombo [69]
      Left = 626
      Top = 195
      Width = 18
      HelpContext = 460093
      Enabled = False
      TabOrder = 48
      Visible = False
      ExplicitLeft = 626
      ExplicitTop = 195
      ExplicitWidth = 18
    end
    inherited pnlHold: TDNMPanel [70]
      Left = 1162
      Top = 10
      HelpContext = 460100
      TabOrder = 43
      Visible = False
      ExplicitLeft = 1162
      ExplicitTop = 10
      inherited lblHoldSale: TLabel
        Left = 26
        HelpContext = 460101
        Visible = False
        ExplicitLeft = 26
      end
      inherited chkHoldSale: TwwCheckBox
        Left = 5
        Top = 3
        HelpContext = 460102
        ExplicitLeft = 5
        ExplicitTop = 3
      end
    end
    inherited pnlChooseRpt: TDNMPanel [71]
      Left = 695
      Top = 236
      Width = 131
      Height = 26
      HelpContext = 460071
      TabOrder = 47
      ExplicitLeft = 695
      ExplicitTop = 236
      ExplicitWidth = 131
      ExplicitHeight = 26
      inherited chkChooseRpt: TCheckBox
        AlignWithMargins = True
        Left = 4
        Top = 1
        Width = 123
        Height = 24
        HelpContext = 460073
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alClient
        ExplicitLeft = 4
        ExplicitTop = 1
        ExplicitWidth = 123
        ExplicitHeight = 24
      end
    end
    inherited txtPONumber: TDBEdit [72]
      Left = 689
      Top = 195
      Width = 18
      HelpContext = 460092
      Enabled = False
      TabOrder = 32
      Visible = False
      ExplicitLeft = 689
      ExplicitTop = 195
      ExplicitWidth = 18
    end
    inherited btnShipment: TDNMSpeedButton [73]
      Left = 622
      Top = 117
      TabOrder = 35
      ExplicitLeft = 622
      ExplicitTop = 117
    end
    inherited cboCreationDate: TwwDBDateTimePicker [74]
      Left = 620
      Top = 56
      Height = 23
      HelpContext = 460063
      TabOrder = 6
      ExplicitLeft = 620
      ExplicitTop = 56
      ExplicitHeight = 23
    end
    inherited cboClass: TwwDBLookupCombo [75]
      Left = 259
      Top = 79
      Width = 134
      HelpContext = 460091
      TabOrder = 3
      ExplicitLeft = 259
      ExplicitTop = 79
      ExplicitWidth = 134
    end
    inherited txtShipTo: TDBMemo [76]
      Top = 134
      Width = 267
      HelpContext = 460098
      TabOrder = 10
      ExplicitTop = 134
      ExplicitWidth = 267
    end
    inherited cboAreaCode: TwwDBLookupCombo [77]
      Left = 737
      Top = 56
      Width = 81
      HelpContext = 460150
      TabOrder = 7
      ExplicitLeft = 737
      ExplicitTop = 56
      ExplicitWidth = 81
    end
    inherited btnNext: TDNMSpeedButton [78]
      Left = 899
      Top = 7
      HelpContext = 460066
      TabOrder = 16
      ExplicitLeft = 899
      ExplicitTop = 7
    end
    inherited btnPrevious: TDNMSpeedButton [79]
      Left = 899
      Top = 45
      TabOrder = 56
      ExplicitLeft = 899
      ExplicitTop = 45
    end
    inherited cboCurrentTransStatus: TwwDBLookupCombo [80]
      Left = 355
      Top = 239
      TabOrder = 12
      ExplicitLeft = 355
      ExplicitTop = 239
    end
    inherited btnNextSale: TDNMSpeedButton
      Left = 945
      Top = 45
      TabOrder = 46
      ExplicitLeft = 945
      ExplicitTop = 45
    end
    inherited btnShiptocontact: TDNMSpeedButton
      Left = 679
      Top = 117
      TabOrder = 38
      ExplicitLeft = 679
      ExplicitTop = 117
    end
    inherited pnlShipToMessage: TPanel
      HelpContext = 460172
      TabOrder = 39
    end
    inherited btninvoices: TDNMSpeedButton
      Left = 544
      Top = 7
      TabOrder = 40
      ExplicitLeft = 544
      ExplicitTop = 7
    end
    inherited btnConSmart: TDNMSpeedButton
      Left = 259
      Top = 138
      TabOrder = 51
      ExplicitLeft = 259
      ExplicitTop = 138
    end
    object wwDBLookupCombo1: TwwDBLookupCombo [86]
      Left = 231
      Top = 239
      Width = 122
      Height = 23
      HelpContext = 460164
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'ShippingMethod'#9'25'#9'ShippingMethod'#9'F')
      DataField = 'Shipping'
      DataSource = DSMaster
      LookupTable = cboViaQry
      LookupField = 'ShippingMethod'
      ParentFont = False
      TabOrder = 49
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    inherited btnShowDetails: TDNMSpeedButton
      Left = 899
      Top = 235
      TabOrder = 54
      ExplicitLeft = 899
      ExplicitTop = 235
    end
    inherited btnRefNo: TDNMSpeedButton
      TabOrder = 45
      Visible = False
    end
    object DNMPanel1: TDNMPanel
      Left = 832
      Top = 236
      Width = 61
      Height = 26
      HelpContext = 460169
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 55
      object chkDone: TDBCheckBox
        AlignWithMargins = True
        Left = 4
        Top = 1
        Width = 53
        Height = 24
        HelpContext = 460050
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alClient
        Caption = 'Done'
        DataField = 'Isdone'
        DataSource = DSMaster
        TabOrder = 0
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        OnEnter = OverrideAccessLevel
        OnExit = RestoreOverridenAccessLevel
        ExplicitLeft = 0
        ExplicitTop = 2
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 707
    Top = 301
  end
  inherited popSpelling: TPopupMenu
    Left = 243
    Top = 301
  end
  inherited tmrdelayMsg: TTimer
    Left = 668
    Top = 301
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 629
    Top = 301
  end
  inherited DSMaster: TDataSource
    Top = 361
  end
  inherited lsTDNMSpeedButtonActions: TActionList
    Left = 320
    Top = 301
    object actConInvoice: TAction [15]
      Caption = 'Copy To &Invoice'
      HelpContext = 460152
      OnExecute = actConInvoiceExecute
      OnUpdate = actConInvoiceUpdate
    end
    object actConCashSale: TAction [16]
      Caption = 'Copy To &Cash Sale'
      HelpContext = 460153
      OnExecute = actConCashSaleExecute
      OnUpdate = actConCashSaleUpdate
    end
    object actConPOS: TAction [17]
      Caption = 'Copy To P&OS'
      HelpContext = 460155
      OnExecute = actConPOSExecute
      OnUpdate = actConPOSUpdate
    end
    object actConSalesOrd: TAction [18]
      Caption = 'Copy To Or&der'
      HelpContext = 460156
      OnExecute = actConSalesOrdExecute
      OnUpdate = actConSalesOrdUpdate
    end
    object actConQuote: TAction [19]
      Caption = 'actConQuote'
      HelpContext = 460157
      OnExecute = actConQuoteExecute
      OnUpdate = actConQuoteUpdate
    end
    object actRepair: TAction [20]
      Caption = 'Copy To &Repair'
      HelpContext = 460158
      OnExecute = actRepairExecute
      OnUpdate = actRepairUpdate
    end
    object actVariation: TDNMAction [21]
      Caption = 'Variation'
      HelpContext = 460159
      OnExecute = actVariationExecute
      OnUpdate = actVariationUpdate
      buttoncolor = clWhite
    end
  end
  inherited popDscntMrkup: TAdvPopupMenu
    Left = 165
    Top = 301
  end
  inherited popMemTrans: TAdvPopupMenu
    Left = 49
    Top = 301
    inherited mnuStockTransferEntrylist: TMenuItem
      Visible = False
    end
    inherited mnuconvertedToList: TMenuItem
      Caption = 'Quote Converted to Sales List'
      HelpContext = 460160
      OnClick = mnuconvertedToListClick
    end
  end
  inherited tblMaster: TERPQuery
    Left = 9
    Top = 329
    object tblMasterReference: TWideStringField [91]
      FieldName = 'Reference'
      Origin = 'tblsales.Reference'
      Size = 255
    end
    object tblMasterAutoSmartOrderRef: TWideStringField
      FieldName = 'AutoSmartOrderRef'
      Origin = 'tblsales.AutoSmartOrderRef'
      Size = 255
    end
    object tblMasterPOCreated: TWideStringField
      FieldName = 'POCreated'
      Origin = 'tblsales.POCreated'
      FixedChar = True
      Size = 1
    end
  end
  inherited tblDetails: TERPQuery
    Left = 36
    Top = 329
    inherited tblDetailsPartBarcode: TWideStringField [1]
    end
    inherited tblDetailsProductName: TWideStringField [2]
    end
    inherited tblDetailsUnitofMeasureSaleLines: TWideStringField [3]
    end
    inherited tblDetailsAttrib1Sale: TFloatField [4]
    end
    inherited tblDetailsAttrib2Sale: TFloatField [5]
    end
    inherited tblDetailsAttrib1SaleRate: TFloatField [6]
    end
    inherited tblDetailsSpecDescription: TWideStringField [7]
    end
    inherited tblDetailsSpecValue: TFloatField [8]
    end
    inherited tblDetailsProduct_Description: TWideStringField [9]
    end
    inherited tblDetailsProduct_Description_Memo: TWideMemoField [10]
    end
    inherited tblDetailsCostCentreName: TWideStringField [11]
    end
    inherited tblDetailsLineCostInc: TFloatField [12]
    end
    inherited tblDetailsLinePriceInc: TFloatField [13]
    end
    inherited tblDetailsForeignCurrencyLinePrice: TFloatField [14]
    end
    inherited tblDetailsCalcProfit: TCurrencyField [15]
    end
    inherited tblDetailsCalcProfitPercent: TFloatField [16]
    end
    inherited tblDetailsCalcGrossProfitPercentInc: TFloatField [17]
    end
    inherited tblDetailsLatestCostPriceInc: TFloatField [18]
    end
    inherited tblDetailsLineTaxCode: TWideStringField [19]
    end
    inherited tblDetailsLineTax: TFloatField [20]
      DisplayFormat = ''
    end
    inherited tblDetailsDiscounts: TFloatField [21]
    end
    inherited tblDetailsTotalLineAmountInc: TFloatField [22]
    end
    inherited tblDetailsSupplier: TWideStringField [23]
    end
    inherited tblDetailsSupplierContact: TWideStringField [24]
    end
    inherited tblDetailsSalesLinesCustField1: TWideStringCustField [25]
    end
    inherited tblDetailsSalesLinesCustField2: TWideStringCustField [26]
    end
    inherited tblDetailsSalesLinesCustField3: TWideStringCustField [27]
    end
    inherited tblDetailsSalesLinesCustField4: TWideStringCustField [28]
    end
    inherited tblDetailsSalesLinesCustField5: TWideStringCustField [29]
    end
    inherited tblDetailsSalesLinesCustField6: TWideStringCustField [30]
    end
    inherited tblDetailsSalesLinesCustField7: TWideStringCustField [31]
    end
    inherited tblDetailsSalesLinesCustField8: TWideStringCustField [32]
    end
    inherited tblDetailsSalesLinesCustField9: TWideStringCustField [33]
    end
    inherited tblDetailsSalesLinesCustField10: TWideStringCustField [34]
    end
    inherited tblDetailsMemoLine: TWideMemoField [35]
    end
    inherited tblDetailsShipDate: TDateTimeField [36]
    end
    inherited tblDetailsBaseLineno: TIntegerField [37]
    end
    inherited tblDetailsShipContainerName: TWideStringField [38]
    end
    inherited tblDetailsShipContainerETA: TDateField [39]
    end
    inherited tblDetailsTimecostused: TWideStringField [40]
    end
    inherited tblDetailsProfitbasedLatestCost: TFloatField [41]
    end
    inherited tblDetailsProfitbasedLatestCostPercent: TFloatField [42]
      DisplayFormat = '0.0%'
    end
    inherited tblDetailsProfitbasedLatestCostInc: TFloatField [43]
    end
    inherited tblDetailsProfitbasedLatestCostPercentInc: TFloatField [44]
      DisplayFormat = '0.0%'
    end
    inherited tblDetailsGrossProfitbasedLatestCostPercentInc: TFloatField [45]
      DisplayFormat = '0.0%'
    end
    inherited tblDetailsUnitofMeasureQtySold: TFloatField [46]
    end
    inherited tblDetailsUOM_Height: TFloatField [47]
    end
    inherited tblDetailsUOM_Width: TFloatField [48]
    end
    inherited tblDetailsUOM_Length: TFloatField [49]
    end
    inherited tblDetailsUOM_Weight: TFloatField [50]
    end
    inherited tblDetailsUOM_Volume: TFloatField [51]
    end
    inherited tblDetailsProduct_custFld1: TWideStringField [52]
    end
    inherited tblDetailsProduct_custFld2: TWideStringField [53]
    end
    inherited tblDetailsProduct_custFld3: TWideStringField [54]
    end
    inherited tblDetailsProduct_custFld4: TWideStringField [55]
    end
    inherited tblDetailsProduct_custFld5: TWideStringField [56]
    end
    inherited tblDetailsProduct_custFld6: TWideStringField [57]
    end
    inherited tblDetailsProduct_custFld7: TWideStringField [58]
    end
    inherited tblDetailsProduct_custFld8: TWideStringField [59]
    end
    inherited tblDetailsProduct_custFld9: TWideStringField [60]
    end
    inherited tblDetailsProduct_custFld10: TWideStringField [61]
    end
    inherited tblDetailsProduct_custFld11: TWideStringField [62]
    end
    inherited tblDetailsProduct_custFld12: TWideStringField [63]
    end
    inherited tblDetailsProduct_custFld13: TWideStringField [64]
    end
    inherited tblDetailsProduct_custFld14: TWideStringField [65]
    end
    inherited tblDetailsProduct_custFld15: TWideStringField [66]
    end
    inherited tblDetailsProduct_custDate1: TDateTimeField [67]
    end
    inherited tblDetailsProduct_custDate2: TDateTimeField [68]
    end
    inherited tblDetailsProduct_custDate3: TDateTimeField [69]
    end
    object tblDetailsWarrantyPeriod: TWideStringField [70]
      DisplayWidth = 100
      FieldName = 'WarrantyPeriod'
      Origin = 'tblsaleslines.WarrantyPeriod'
      Size = 100
    end
    object tblDetailsWarrantyEndsOn: TDateField [71]
      DisplayWidth = 10
      FieldName = 'WarrantyEndsOn'
      Origin = 'tblsaleslines.WarrantyEndsOn'
    end
    inherited tblDetailsMatrixDesc: TWideMemoField [72]
    end
    inherited tblDetailsMatrixPrice: TFloatField [73]
    end
    inherited tblDetailsTotalUOM_WeightSold: TFloatField [74]
    end
    inherited tblDetailsTotalUOM_WeightShipped: TFloatField [75]
    end
    inherited tblDetailsTotalUOM_WeightBO: TFloatField [76]
    end
    inherited tblDetailsTotalUOM_LengthSold: TFloatField [77]
    end
    inherited tblDetailsTotalUOM_LengthShipped: TFloatField [78]
    end
    inherited tblDetailsTotalUOM_LengthBO: TFloatField [79]
    end
    inherited tblDetailsArea: TWideStringField [80]
    end
    inherited tblDetailsFormulaQtySoldValue1: TFloatField [81]
    end
    inherited tblDetailsFormulaQtySoldValue2: TFloatField [82]
    end
    inherited tblDetailsFormulaQtySoldValue3: TFloatField [83]
    end
    inherited tblDetailsFormulaQtySoldValue4: TFloatField [84]
    end
    inherited tblDetailsFormulaQtySoldValue5: TFloatField [85]
    end
    inherited tblDetailsFormulaQtyShippedValue1: TFloatField [86]
    end
    inherited tblDetailsFormulaQtyShippedValue2: TFloatField [87]
    end
    inherited tblDetailsFormulaQtyShippedValue3: TFloatField [88]
    end
    inherited tblDetailsFormulaQtyShippedValue4: TFloatField [89]
    end
    inherited tblDetailsFormulaQtyShippedValue5: TFloatField [90]
    end
    inherited tblDetailsFormulaQtySoldValue: TFloatField [91]
    end
    inherited tblDetailsFormulaQtyShippedValue: TFloatField [92]
    end
    inherited tblDetailsAttrib1SaleEst: TFloatField [93]
    end
    inherited tblDetailsAttrib2SaleEst: TFloatField [94]
    end
    inherited tblDetailsISContainer: TWideStringField [95]
    end
    inherited tblDetailsIsPallet: TWideStringField [96]
    end
    inherited tblDetailsAreaQty: TFloatField [97]
    end
    inherited tblDetailsCustomerEquipmentID: TIntegerField [98]
    end
    inherited tblDetailsEquipment: TWideStringField [99]
    end
    inherited tblDetailsLinesOrder: TIntegerField [100]
    end
    inherited tblDetailsRequiresAssembly: TWideStringField [101]
    end
    object tblDetailsExcludeFromSmartOrder: TWideStringField [102]
      DisplayWidth = 1
      FieldName = 'ExcludeFromSmartOrder'
      FixedChar = True
      Size = 1
    end
    inherited tblDetailsUnitofMeasureShipped: TFloatField [103]
      Visible = False
    end
    inherited tblDetailsUnitofMeasureBackorder: TFloatField [104]
      Visible = False
    end
    inherited tblDetailsSortId: TIntegerField [105]
    end
    inherited tblDetailsLineCost: TFloatField [106]
    end
    inherited tblDetailsLinePrice: TFloatField [107]
    end
    inherited tblDetailsLatestCostPrice: TFloatField [108]
    end
    inherited tblDetailsTotalLineAmount: TFloatField [109]
    end
    inherited tblDetailsQtySold: TFloatField [110]
    end
    inherited tblDetailsShipped: TFloatField [111]
    end
    inherited tblDetailsBackOrder: TFloatField [112]
    end
    inherited tblDetailsOrgLinePrice: TFloatField [113]
      currency = True
    end
    inherited tblDetailsSaleID: TIntegerField [114]
    end
    inherited tblDetailsSaleLineID: TAutoIncField [115]
    end
    inherited tblDetailsGlobalRef: TWideStringField [116]
    end
    inherited tblDetailsProductGroup: TWideStringField [117]
    end
    inherited tblDetailsLineWholesalePrice: TFloatField [118]
    end
    inherited tblDetailsLineTaxRate: TFloatField [119]
    end
    inherited tblDetailsInvoiced: TWideStringField [120]
    end
    inherited tblDetailsMarkup: TFloatField [121]
    end
    inherited tblDetailsMarkupPercent: TFloatField [122]
    end
    inherited tblDetailsDiscountPercent: TFloatField [123]
    end
    inherited tblDetailsEditedFlag: TWideStringField [124]
    end
    inherited tblDetailsDeleted: TWideStringField [125]
    end
    inherited tblDetailsProductID: TIntegerField [126]
    end
    inherited tblDetailsPartType: TWideStringField [127]
    end
    inherited tblDetailsRefundQty: TFloatField [128]
    end
    inherited tblDetailsLaybyID: TWideStringField [129]
    end
    inherited tblDetailsIncomeAccnt: TWideStringField [130]
    end
    inherited tblDetailsAssetAccnt: TWideStringField [131]
    end
    inherited tblDetailsCogsAccnt: TWideStringField [132]
    end
    inherited tblDetailsCalcPriceInc: TCurrencyField [133]
    end
    inherited tblDetailsCalcTotalInc: TCurrencyField [134]
    end
    inherited tblDetailsCalcTotalEx: TCurrencyField [135]
    end
    inherited tblDetailsCalcTax: TCurrencyField [136]
    end
    inherited tblDetailsCalcBackOrder: TFloatField [137]
    end
    inherited tblDetailsCalcLinePriceEx: TCurrencyField [138]
    end
    inherited tblDetailsCalcTotalIncB4Discount: TCurrencyField [139]
    end
    inherited tblDetailsLastLineID: TIntegerField [140]
    end
    inherited tblDetailsUnitofMeasureMultiplier: TFloatField [141]
    end
    inherited tblDetailsForeignExchangeSellRate: TFloatField [142]
    end
    inherited tblDetailsForeignTotalLineAmount: TFloatField [143]
    end
    inherited tblDetailsCalcProfitEx: TCurrencyField [144]
    end
    inherited tblDetailsCalcProfitPercentEx: TCurrencyField [145]
    end
    object tblDetailsLastUpdated: TDateTimeField [146]
      DisplayWidth = 18
      FieldName = 'LastUpdated'
      Origin = 'tblsaleslines.LastUpdated'
      Visible = False
    end
    object tblDetailsIsQuote: TWideStringField [147]
      DisplayWidth = 1
      FieldName = 'IsQuote'
      Origin = 'tblsaleslines.IsQuote'
      Visible = False
      FixedChar = True
      Size = 1
    end
    inherited tblDetailsSearchFilter: TWideStringField [148]
    end
    inherited tblDetailsSearchFilterCopy: TWideStringField [149]
    end
    inherited tblDetailsIsRelatedProduct: TWideStringField [150]
    end
    inherited tblDetailsRelatedParentProductID: TIntegerField [151]
    end
    inherited tblDetailsCostCentreId: TIntegerField [152]
    end
    inherited tblDetailsUseHedging: TWideStringField [153]
    end
    inherited tblDetailsPartSpecID: TIntegerField [154]
    end
    inherited tblDetailsCreationDate: TDateTimeField [155]
    end
    inherited tblDetailsSoldSerials: TWideMemoField [156]
    end
    inherited tblDetailsLineNotes: TWideMemoField [157]
    end
    inherited tblDetailsCustomData: TWideMemoField [158]
    end
    inherited tblDetailsUnitOfMeasureID: TIntegerField [159]
    end
    inherited tblDetailsRelatedParentLineRef: TWideStringField [160]
    end
    inherited tblDetailsPQA: TWideStringField [161]
      Visible = False
    end
    inherited tblDetailsMatrixRef: TWideMemoField [162]
    end
    inherited tblDetailsmsTimeStamp: TDateTimeField [163]
    end
    inherited tblDetailsmsUpdateSiteCode: TWideStringField [164]
    end
    inherited tblDetailsRelatedProductQty: TFloatField [165]
    end
    inherited tblDetailsIsFormulaRElatedProduct: TWideStringField [166]
    end
    inherited tblDetailsFormulaID: TIntegerField [167]
    end
    inherited tblDetailsProductBarcode: TWideStringField [168]
      Visible = False
    end
    inherited tblDetailsUOMLineCost: TFloatField [169]
      Visible = False
    end
    inherited tblDetailsUOMLineCostInc: TFloatField [170]
      Visible = False
    end
    inherited tblDetailsUOMLinePrice: TFloatField [171]
      Visible = False
    end
    inherited tblDetailsUOMLinePriceInc: TFloatField [172]
      Visible = False
    end
    inherited tblDetailsOriginalQtyOrdered: TFloatField [173]
      Visible = False
    end
    inherited tblDetailsDetailsCust1Total: TFloatField [174]
      Visible = False
    end
    inherited tblDetailsStandardCost: TFloatField [175]
      Visible = False
    end
    inherited tblDetailsOrgProductPrice: TFloatField [176]
      Visible = False
    end
    inherited tblDetailsPurchaseCost: TFloatField [177]
      Visible = False
    end
    inherited tbldetailsMargin: TFloatField [178]
    end
    inherited tbldetailsMarginPercent: TFloatField [179]
    end
    inherited tblDetailsOrgProductPriceInc: TFloatField [180]
    end
    inherited tblDetailsISVoucher: TWideStringField [181]
    end
    inherited tblDetailsProductPrintName: TWideStringField [182]
    end
    inherited tblDetailsPackWeightField1: TFloatField [183]
    end
    inherited tblDetailsPackWeightfield2: TFloatField [184]
    end
    inherited tblDetailsPackCount: TFloatField [185]
    end
    inherited tblDetailsBOMComments: TWideStringField [186]
    end
    inherited tblDetailsRelatedProductProdLine: TIntegerField [187]
    end
    inherited tblDetailsRelatedProductPatternName: TWideStringField [188]
    end
    inherited tblDetailsRelatedProductFormulaDescription: TWideStringField [189]
    end
    inherited tblDetailsETDDate: TDateTimeField [190]
    end
    inherited tblDetailsUOMQtyInStock: TFloatField [191]
    end
    inherited tblDetailsUOMQtyAvailable: TFloatField [192]
    end
    inherited tblDetailsReferenceNo: TWideStringField [193]
    end
    inherited tblDetailsUOM_ShippedVolume: TFloatField [194]
    end
    inherited tblDetailsUOM_Soldvolume: TFloatField [195]
    end
    inherited tblDetailsDiscountedPriceInc: TFloatField [196]
    end
    inherited tblDetailsDiscountedPrice: TFloatField [197]
    end
    inherited tblDetailsTotalDiscountedPriceInc: TFloatField [198]
    end
    inherited tblDetailsTotalDiscountedPrice: TFloatField [199]
    end
    object tblDetailsTreeFinalized: TWideStringField
      FieldName = 'TreeFinalized'
      Origin = 'tblsaleslines.TreeFinalized'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  inherited cboClientLookup: TERPQuery
    Left = 201
    Top = 329
  end
  inherited cboEmployeeLookup: TERPQuery
    Left = 585
    Top = 329
  end
  inherited cboClassQry: TERPQuery
    SQL.Strings = (
      
        'SELECT tblClass.ClassID, tblClass.ClassName, ClassPercent, AutoC' +
        'reateSmartOrders'
      'FROM tblClass '
      
        'WHERE (((tblClass.ClassName) Is Not Null) And ((tblClass.Active)' +
        '<>'#39'F'#39')) '
      'ORDER BY tblClass.ClassName')
    Left = 640
    Top = 329
  end
  inherited qryBaseForeignCurrency: TERPQuery
    Left = 475
    Top = 329
  end
  inherited qryClientLookup: TERPQuery
    Left = 778
    Top = 329
  end
  inherited imgPopup: TImageList
    Left = 397
    Top = 301
    Bitmap = {
      494C010104001801080210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 784
    Top = 301
  end
  inherited qryUnitOfMeasure: TERPQuery
    Left = 338
    Top = 329
  end
  inherited mnuDiscountTotal: TAdvPopupMenu
    Left = 88
    Top = 301
  end
  inherited cboAccountQry: TERPQuery
    Left = 723
    Top = 329
  end
  object qryStatusChecker: TERPQuery [30]
    SQL.Strings = (
      'SELECT DISTINCT Status FROM tblquotestatus ORDER BY Status')
    Left = 833
    Top = 329
  end
  inherited qrySupplier: TERPQuery
    Left = 448
    Top = 329
  end
  inherited DMTextTargetSales: TDMTextTarget
    Left = 359
    Top = 301
  end
  inherited qryPartsSpecs: TERPQuery
    Left = 530
    Top = 329
  end
  inherited cboTermsQry: TERPQuery
    Left = 366
    Top = 329
  end
  inherited dlgMemoLine: TwwMemoDialog
    Left = 281
    Top = 301
  end
  inherited tblFESalesLines: TERPQuery
    Left = 63
    Top = 329
  end
  inherited tblFESaleslinesRelatedPrs: TERPQuery
    Left = 91
    Top = 329
  end
  inherited qryShipContainerSaleLookup: TERPQuery
    Left = 283
    Top = 329
  end
  inherited tblEquipmentxRefs: TERPQuery
    Left = 146
    Top = 329
  end
  object qryContacts: TERPQuery [42]
    SQL.Strings = (
      'SELECT * FROM tblcontacts WHERE Company = :xCompany')
    Left = 311
    Top = 329
    ParamData = <
      item
        DataType = ftString
        Name = 'xCompany'
        Value = ''
      end>
  end
  inherited cboProductQry: TERPQuery
    Left = 613
    Top = 329
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 475
    Top = 301
  end
  inherited MyConnection: TERPConnection
    Left = 11
    Top = 301
  end
  inherited Qrysalesshippingdetails: TERPQuery
    Left = 695
    Top = 329
  end
  inherited qryUOMLookup: TMyQuery
    Left = 860
    Top = 329
  end
  inherited QryRelatedMaster: TERPQuery
    Left = 668
    Top = 329
  end
  inherited DataState: TDataState
    Left = 552
    Top = 301
  end
  inherited QrySalesCAtegory: TERPQuery
    Top = 329
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 204
    Top = 301
  end
  inherited imgsort: TImageList
    Left = 591
    Top = 301
    Bitmap = {
      494C010102002801180210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 805
    Top = 329
  end
  inherited QryAreaCodeLk: TERPQuery
    Left = 750
    Top = 329
  end
  inherited cbTaxCodeQry: TERPQuery
    Left = 393
    Top = 329
  end
  inherited qryMemTrans: TERPQuery
    Left = 228
    Top = 329
  end
  inherited SaveDialog1: TSaveDialog
    Left = 513
    Top = 301
  end
  inherited QryCustomField: TERPQuery
    Left = 173
    Top = 329
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 436
    Top = 301
  end
  inherited TmrCommentshint: TTimer
    Left = 745
    Top = 301
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 127
    Top = 301
  end
  inherited cboViaQry: TERPQuery
    Left = 503
    Top = 329
  end
  inherited QryAreaCodes: TERPQuery
    Left = 558
    Top = 329
  end
  inherited qrySalesQuantities: TERPQuery
    Left = 118
    Top = 329
  end
  inherited tmrShipToMessage: TTimer
    Top = 301
  end
  object ERPQuery1: TERPQuery [69]
    SQL.Strings = (
      'SELECT ShippingMethodID, ShippingMethod'
      'FROM tblShippingMethods '
      'WHERE tblShippingMethods.Active='#39'T'#39' '
      'ORDER BY tblShippingMethods.ShippingMethod; '
      '')
    Left = 421
    Top = 329
    object WideStringField1: TWideStringField
      DisplayWidth = 25
      FieldName = 'ShippingMethod'
      FixedChar = True
      Size = 15
    end
    object AutoIncField1: TAutoIncField
      DisplayWidth = 10
      FieldName = 'ShippingMethodID'
      ReadOnly = True
      Visible = False
    end
  end
  inherited qryCostCentre: TERPQuery
    Left = 256
    Top = 329
  end
end
