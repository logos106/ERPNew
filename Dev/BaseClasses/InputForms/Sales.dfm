inherited BaseSaleGUI: TBaseSaleGUI
  Left = 196
  Top = 359
  Caption = 'Sales'
  ClientHeight = 562
  ClientWidth = 952
  OnResize = FormResize
  ExplicitLeft = 196
  ExplicitTop = 359
  ExplicitWidth = 968
  ExplicitHeight = 601
  DesignSize = (
    952
    562)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 562
    Width = 952
    ExplicitTop = 562
    ExplicitWidth = 952
  end
  inherited imgGridWatermark: TImage
    Left = 248
    ExplicitLeft = 248
  end
  inherited pnlDetail: TDNMPanel
    Width = 952
    Height = 201
    ParentColor = True
    ExplicitWidth = 952
    ExplicitHeight = 201
    inherited grdTransactions: TwwDBGrid
      Width = 952
      Height = 185
      ControlType.Strings = (
        'ProductName;CustomEdit;cboProductR;F'
        'LineTaxCode;CustomEdit;cboTaxCode;F'
        'UnitofMeasureSaleLines;CustomEdit;cboUnitOfMeasure;F'
        'Supplier;CustomEdit;cboSupplier;F'
        'SearchFilter;CustomEdit;txtSearchFilter;T'
        'CostCentreName;CustomEdit;cboCostCentre;F'
        'SpecDescription;CustomEdit;cboPartSpecs;F'
        'ProviderNum;CustomEdit;cboPrescriber;T'
        'MemoLine;CustomEdit;edtMemoLine;F'
        'Area;CustomEdit;cboLinesAreaCode;F'
        'RequiresAssembly;CheckBox;T;F')
      Selected.Strings = (
        'SeqNo'#9'6'#9'No'
        'ProductName'#9'17'#9'Product'
        'UnitofMeasureSaleLines'#9'10'#9'Units'
        'UnitofMeasureQtySold'#9'6'#9'Ordered'
        'UnitofMeasureShipped'#9'6'#9'Shipped'
        'PQA'#9'1'#9'Allocation'
        'UnitofMeasureBackorder'#9'6'#9'BO'
        'Attrib1Sale'#9'6'#9'Metres ?'
        'ReferenceNo'#9'20'#9'Reference No'
        'Attrib2Sale'#9'6'#9'Weight'
        'Attrib1SaleRate'#9'10'#9'Metres ? Rate'
        'SpecDescription'#9'17'#9'Specifications'
        'SpecValue'#9'10'#9'Spec Qty'
        'Product_Description'#9'20'#9'Description'
        'PartBarcode'#9'20'#9'Barcode'
        'Product_Description_Memo'#9'10'#9'Product Description Memo'
        'CostCentreName'#9'20'#9'Cost Centre'
        'LineCostInc'#9'10'#9'Cost (Inc)'
        'LinePriceInc'#9'10'#9'Price (Inc)'
        'Discounts'#9'10'#9'Discount ($)'
        'ForeignCurrencyLinePrice'#9'10'#9'Foreign Amount'
        'CalcProfit'#9'10'#9'Profit (Inc)'
        'CalcProfitPercent'#9'7'#9'% Profit (Inc)'
        'CalcGrossProfitPercentInc'#9'10'#9'Gross % (based on Avg Cost)'
        'LatestCostPriceInc'#9'10'#9'Latest Cost (Inc)'
        'LineTaxCode'#9'15'#9'Code'
        'LineTax'#9'10'#9'Tax (Dbl Click)'
        'TotalLineAmountInc'#9'14'#9'Amount (Inc)'
        'Supplier'#9'20'#9'Supplier'
        'SupplierContact'#9'20'#9'Supplier Contact'
        'SalesLinesCustField1'#9'20'#9'SalesLinesCustField1'
        'SalesLinesCustField2'#9'20'#9'SalesLinesCustField2'
        'SalesLinesCustField3'#9'20'#9'SalesLinesCustField3'
        'SalesLinesCustField4'#9'20'#9'SalesLinesCustField4'
        'SalesLinesCustField5'#9'20'#9'SalesLinesCustField5'
        'SalesLinesCustField6'#9'20'#9'SalesLinesCustField6'
        'SalesLinesCustField7'#9'20'#9'SalesLinesCustField7'
        'SalesLinesCustField8'#9'20'#9'SalesLinesCustField8'
        'SalesLinesCustField9'#9'20'#9'SalesLinesCustField9'
        'SalesLinesCustField10'#9'20'#9'SalesLinesCustField10'
        'MemoLine'#9'10'#9'MemoLine'
        'ShipDate'#9'18'#9'Ship Date'
        'BaseLineno'#9'10'#9'BaseLineno'
        'ShipContainerName'#9'20'#9'ShipContainerName'
        'ShipContainerETA'#9'10'#9'ShipContainerETA'
        'Timecostused'#9'1'#9'Timecostused'
        'ProfitbasedLatestCost'#9'10'#9'GP (based on Latest Cost)'
        'ProfitbasedLatestCostPercent'#9'10'#9'GP% (based on Latest Cost)'
        'ProfitbasedLatestCostInc'#9'10'#9'GP(Ex) (based on Latest Cost)'
        
          'ProfitbasedLatestCostPercentInc'#9'10'#9'GP(Inc)% (based on Latest Cos' +
          't)'
        
          'GrossProfitbasedLatestCostPercentInc'#9'10'#9'GP% (based on Latest Cos' +
          't)'
        'UOM_Height'#9'10'#9'UOM_Height'
        'UOM_Width'#9'10'#9'UOM_Width'
        'UOM_Length'#9'10'#9'UOM_Length'
        'UOM_Weight'#9'10'#9'UOM_Weight'
        'TotalUOM_WeightSold'#9'10'#9'TotalUOM_WeightSold'
        'TotalUOM_WeightShipped'#9'10'#9'TotalUOM_WeightShipped'
        'TotalUOM_WeightBO'#9'10'#9'TotalUOM_WeightBO'
        'TotalUOM_LengthSold'#9'10'#9'TotalUOM_LengthSold'
        'TotalUOM_LengthShipped'#9'10'#9'TotalUOM_LengthShipped'
        'TotalUOM_LengthBO'#9'10'#9'TotalUOM_LengthBO'
        'UOM_Volume'#9'10'#9'UOM_Volume'
        'UOM_ShippedVolume'#9'10'#9'Volume of Shipped'
        'UOM_Soldvolume'#9'10'#9'Volume of Sold'
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
        'MatrixDesc'#9'10'#9'Matrix Details'
        'MatrixPrice'#9'10'#9'Matrix Price'
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
        'Attrib1SaleEst'#9'10'#9'Est Metres ?'
        'Attrib2SaleEst'#9'10'#9'Est Weight'
        'ISContainer'#9'1'#9'ISContainer'
        'IsPallet'#9'1'#9'IsPallet'
        'Area'#9'20'#9'Area'
        'AreaQty'#9'10'#9'Area To Cover'
        'CustomerEquipmentID'#9'10'#9'CustomerEquipmentID'
        'Equipment'#9'10'#9'Equipment'
        'LinesOrder'#9'10'#9'Order by'
        'RequiresAssembly'#9'1'#9'Requires Assembly?'
        'ProductBarcode'#9'255'#9'ProductBarcode'
        'UOMLineCost'#9'10'#9'UOM Cost (Ex)'
        'UOMLineCostInc'#9'10'#9'UOM Cost (Inc)'
        'UOMLinePrice'#9'10'#9'UOM Price (Ex)'
        'UOMLinePriceInc'#9'10'#9'UOM Price (Inc)'
        'OriginalQtyOrdered'#9'10'#9'Orig Qty'
        'DetailsCust1Total'#9'10'#9'DetailsCust1Total'
        'StandardCost'#9'10'#9'Standard Cost'
        'OrgProductPrice'#9'10'#9'Org Product Price (Ex)'
        'OrgProductPriceInc'#9'10'#9'Org Product Price (Inc)'
        'PurchaseCost'#9'10'#9'SMO To Cost'
        'ISVoucher'#9'1'#9'ISVoucher'
        'ProductPrintName'#9'20'#9'ProductPrintName'
        'PackWeightField1'#9'10'#9'PackWeightField1'
        'PackWeightfield2'#9'10'#9'PackWeightfield2'
        'PackCount'#9'10'#9'PackCount'
        'BOMComments'#9'20'#9'BOM Partial Build Comments'
        'RelatedProductProdLine'#9'10'#9'RelatedProductProdLine'
        'RelatedProductPatternName'#9'255'#9'RelatedProductPatternName'
        
          'RelatedProductFormulaDescription'#9'255'#9'RelatedProductFormulaDescri' +
          'ption'
        'ETDDate'#9'18'#9'ETD Date'
        'UOMQtyInStock'#9'10'#9'Qty In Stock'
        'UOMQtyAvailable'#9'10'#9'Qty Available'
        'DiscountedPriceInc'#9'10'#9'Disc Price (Inc)'
        'TotalDiscountedPriceInc'#9'10'#9'Total Disc Price (Inc)'
        'ProfitOnLanded'#9'10'#9'Landed Profit (Ex)'
        'ProfitOnLandedInc'#9'10'#9'Landed Profit (Inc)'
        'ProfitOnLandedPercent'#9'10'#9'Landed Profit % (Ex)'
        'ProfitOnLandedPercentInc'#9'10'#9'Landed Profit % (Inc)'
        'SalesTaxBasedon'#9'2'#9'SalesTaxBasedon')
      MemoAttributes = [mSizeable, mGridShow]
      OnMultiSelectRecord = grdTransactionsMultiSelectRecord
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
      PopupMenu = mnuDiscountTotal
      OnColExit = grdTransactionsColExit
      OnKeyDown = grdTransactionsKeyDown
      OnDrawFooterCell = grdTransactionsDrawFooterCell
      OnFieldChanged = grdTransactionsFieldChanged
      FooterColor = clWhite
      FooterCellColor = clWhite
      ExplicitWidth = 952
      ExplicitHeight = 185
      inherited btnDelete: TwwIButton
        Left = -1
        ExplicitLeft = -1
      end
    end
    inherited cboTaxCode: TERPDbLookupCombo [1]
      Left = 92
      Top = 26
      TabOrder = 1
      UseTFields = False
      OnDropDown = cboTaxCodeDropDown
      OnCloseUp = cboTaxCodeCloseUp
      ExplicitLeft = 92
      ExplicitTop = 26
    end
    object cboUnitOfMeasure: TwwDBLookupCombo [2]
      Left = 163
      Top = 36
      Width = 85
      Height = 26
      AutoSize = False
      DropDownAlignment = taLeftJustify
      DataField = 'UnitofMeasureSaleLines'
      DataSource = DSDetails
      LookupTable = qryUnitOfMeasure
      LookupField = 'UnitName'
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnDropDown = cboUnitOfMeasureDropDown
      OnCloseUp = cboUnitOfMeasureCloseUp
    end
    object cboSupplier: TERPDbLookupCombo [3]
      Left = 378
      Top = 29
      Width = 121
      Height = 26
      AutoSize = False
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'20'#9'Supplier'#9'T')
      DataField = 'Supplier'
      DataSource = DSDetails
      LookupTable = qrySupplier
      LookupField = 'Company'
      TabOrder = 10
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnDropDown = cboSupplierDropDown
      LookupFormClassName = 'TSupplierExpressListGUI'
      EditFormClassName = 'TfmSupplier'
      LookupFormKeyStringFieldName = 'SupplierName'
      LookupComboType = ctSupplier
      AllowFullListSearchMode = False
      DisableNotInList = False
      AllowMultipleSelectFromList = False
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      LookupIDField = 'ClientID'
      LookupFieldAlt = 'PrintName'
    end
    object cboCostCentre: TwwDBLookupCombo [4]
      Left = 251
      Top = 29
      Width = 121
      Height = 26
      AutoSize = False
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'CostCentreName'#9'40'#9'CostCentreName'#9'F')
      DataField = 'CostCentreName'
      DataSource = DSDetails
      LookupTable = qryCostCentre
      LookupField = 'CostCentreID'
      Style = csDropDownList
      DropDownWidth = 40
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnDropDown = cboCostCentreDropDown
      OnCloseUp = cboCostCentreCloseUp
    end
    object cboPartSpecs: TwwDBLookupCombo [5]
      Left = 455
      Top = 113
      Width = 85
      Height = 26
      AutoSize = False
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'SpecDescription'#9'30'#9'SpecDescription'#9'F')
      DataField = 'SpecDescription'
      DataSource = DSDetails
      LookupTable = qryPartsSpecs
      LookupField = 'SpecDescription'
      Style = csDropDownList
      TabOrder = 4
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnDropDown = cboPartSpecsDropDown
      OnEnter = cboPartSpecsEnter
    end
    object cboProductR: TERPDbLookupCombo [6]
      Left = 21
      Top = 30
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
        'PartsDescription'#9'35'#9'Description'#9'F'
        'Active'#9'1'#9'Active'#9'F'
        'SupplierProductCode'#9'20'#9'Supplier Product Code'#9'F')
      DataField = 'ProductName'
      DataSource = DSDetails
      LookupTable = cboProductQry
      LookupField = 'Partname'
      Options = [loTitles]
      TabOrder = 5
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboProductRCloseUp
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
    object ProgressBar: TProgressBar [7]
      Left = 0
      Top = 185
      Width = 952
      Height = 16
      Align = alBottom
      TabOrder = 6
      Visible = False
    end
    object edtMemoLine: TwwDBEdit [8]
      Left = 544
      Top = 56
      Width = 121
      Height = 26
      DataField = 'MemoLine'
      DataSource = DSDetails
      TabOrder = 7
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnDblClick = edtMemoLineDblClick
    end
    inherited cboLinesAreaCode: TwwDBLookupCombo [9]
      DataField = 'Area'
      TabOrder = 8
    end
    object cboPrintProductR: TERPDbLookupCombo
      Left = 29
      Top = 38
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
        'PartsDescription'#9'35'#9'Description'#9'F'
        'Active'#9'1'#9'Active'#9'F'
        'SupplierProductCode'#9'20'#9'Supplier Product Code'#9'F')
      DataField = 'ProductName'
      DataSource = DSDetails
      LookupTable = cboProductQry
      LookupField = 'Partname'
      Options = [loTitles]
      TabOrder = 9
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
  end
  inherited pnlFooter: TDNMPanel
    Top = 432
    Width = 952
    ParentColor = True
    PopupMenu = mnuDiscountTotal
    ExplicitTop = 432
    ExplicitWidth = 952
    DesignSize = (
      952
      131)
    inherited lblComments: TLabel
      Left = 8
      Top = 0
      ExplicitLeft = 8
      ExplicitTop = 0
    end
    inherited Label142: TLabel
      Left = 768
      ExplicitLeft = 768
      ExplicitTop = 50
    end
    inherited Label54: TLabel
      Left = 769
      ExplicitLeft = 769
      ExplicitTop = 74
    end
    object Label93: TLabel [3]
      Left = 0
      Top = 74
      Width = 72
      Height = 31
      Alignment = taCenter
      AutoSize = False
      Caption = '    Picking Instructions:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    inherited Label56: TLabel
      Left = 768
      Top = 99
      Width = 51
      Caption = 'Total '
      ExplicitLeft = 768
      ExplicitTop = 99
      ExplicitWidth = 51
    end
    object Label122: TLabel [5]
      Left = 630
      Top = 66
      Width = 51
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Markup'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label5: TLabel [6]
      Left = 622
      Top = 38
      Width = 59
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Discount'
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
      Left = 628
      Top = 95
      Width = 53
      Alignment = taRightJustify
      Caption = 'Foreign'
      ExplicitLeft = 628
      ExplicitTop = 95
      ExplicitWidth = 53
    end
    object Label101: TLabel [8]
      Left = 319
      Top = 96
      Width = 28
      Height = 30
      Caption = 'Con. Note'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblContributionAmount: TLabel [9]
      Left = 613
      Top = 10
      Width = 68
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Contribution'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label12: TLabel [10]
      Left = 768
      Top = 26
      Width = 61
      Height = 18
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = 'Balance'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblApprovedAmount: TLabel [11]
      Left = 772
      Top = 3
      Width = 57
      Height = 30
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = 'Approved Amount'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    inherited pnlComments: TDNMPanel
      Left = 76
      Width = 238
      Anchors = [akLeft, akBottom]
      TabOrder = 13
      ExplicitLeft = 76
      ExplicitWidth = 238
      inherited LblCommentsHint: TLabel
        Width = 236
        ExplicitWidth = 236
      end
      inherited txtComments: TDBMemo
        Width = 236
        DataField = 'Comments'
        ExplicitWidth = 236
      end
    end
    inherited txtSubTotal: TDBEdit
      Left = 835
      Top = 47
      DataField = 'TotalAmount'
      TabOrder = 7
      ExplicitLeft = 835
      ExplicitTop = 47
    end
    inherited txtTotalTax: TDBEdit
      Left = 835
      Top = 71
      DataField = 'TotalTax'
      TabOrder = 3
      ExplicitLeft = 835
      ExplicitTop = 71
    end
    object txtTotalDiscount: TDBEdit [15]
      Left = 683
      Top = 34
      Width = 88
      Height = 24
      TabStop = False
      Color = clScrollBar
      DataField = 'TotalDiscount'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
    object txtPickMemo: TDBMemo [16]
      Left = 85
      Top = 45
      Width = 238
      Height = 59
      Hint = '"Type In A Comment For The Warehouse"'
      DataField = 'PickMemo'
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
    end
    object txtTotalMarkup: TDBEdit [17]
      Left = 683
      Top = 64
      Width = 88
      Height = 24
      TabStop = False
      Color = clScrollBar
      DataField = 'TotalMarkup'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
    end
    inherited txtTotalAmount: TDBEdit
      Left = 821
      Top = 95
      DataField = 'TotalAmountInc'
      TabOrder = 4
      OnChange = txtTotalAmountChange
      ExplicitLeft = 821
      ExplicitTop = 95
    end
    inherited edtBaseForeignTotal: TDBEdit
      Left = 683
      Top = 94
      Width = 88
      Color = clScrollBar
      TabOrder = 2
      ExplicitLeft = 683
      ExplicitTop = 94
      ExplicitWidth = 88
    end
    inherited lblDisableCalc: TDNMSpeedButton
      Left = 136
      Top = -10
      TabOrder = 21
      ExplicitLeft = 136
      ExplicitTop = -10
    end
    object btnAttachments: TDNMSpeedButton [21]
      Left = 8
      Top = 24
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
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = btnAttachmentsClick
    end
    inherited DNMPanel5: TDNMPanel
      Top = 0
      Width = 148
      Height = 96
      TabOrder = 9
      ExplicitTop = 0
      ExplicitWidth = 148
      ExplicitHeight = 96
      inherited lblEnteredbyHead: TLabel
        Left = 4
        Top = 4
        ExplicitLeft = 4
        ExplicitTop = 4
      end
      inherited lblEnteredBy: TDBText
        Top = 1
        ExplicitTop = 1
      end
      inherited lblPrintHead: TLabel
        Left = 7
        Top = 41
        ExplicitLeft = 7
        ExplicitTop = 41
      end
      inherited lblPrintedBy: TLabel
        Top = 39
        ExplicitTop = 39
      end
      inherited lblPrintedOnCaption: TLabel
        Left = 5
        Top = 59
        ExplicitLeft = 5
        ExplicitTop = 59
      end
      inherited lblPrintedOn: TLabel
        Top = 58
        ExplicitTop = 58
      end
      inherited lblPrintedAtCaption: TLabel
        Left = 9
        Top = 78
        ExplicitLeft = 9
        ExplicitTop = 78
      end
      inherited lblPrintedAt: TLabel
        Top = 77
        ExplicitTop = 77
      end
      object lblEnteredAtHead: TLabel
        Left = 6
        Top = 22
        Width = 65
        Height = 15
        Caption = 'Entered At :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblEnteredAt: TDBText
        Left = 77
        Top = 20
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
    inherited lblEmail: TDNMPanel
      Left = 351
      Top = 6
      TabOrder = 14
      ExplicitLeft = 351
      ExplicitTop = 6
    end
    inherited pnlProcessMessage: TDNMPanel
      Width = 952
      ExplicitWidth = 952
      inherited lblProcessMessage: TLabel
        Width = 948
        ExplicitWidth = 948
      end
    end
    object dnmpanle6: TDNMPanel
      Left = 467
      Top = 0
      Width = 143
      Height = 124
      BevelKind = bkFlat
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      object lblMargin: TLabel
        Left = 66
        Top = 105
        Width = 50
        Height = 15
        Caption = 'lblMargin'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        Visible = False
      end
      object lblMarginLabel: TLabel
        Left = 4
        Top = 102
        Width = 42
        Height = 15
        Caption = 'Margin:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Visible = False
      end
      object lblCostLabel: TLabel
        Left = 4
        Top = 85
        Width = 29
        Height = 15
        Caption = 'Cost:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Visible = False
      end
      object lblCost: TLabel
        Left = 66
        Top = 87
        Width = 39
        Height = 15
        Caption = 'lblCost'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        Visible = False
      end
      object lblEarlyPaymentDiscount2: TLabel
        Left = 4
        Top = 51
        Width = 59
        Height = 15
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = 'Discount'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
        Transparent = True
      end
      object lblEarlyPaymentDiscountAmount: TLabel
        Left = 66
        Top = 53
        Width = 43
        Height = 15
        AutoSize = False
        Caption = 'lblEarlyPaymentDiscountAmount'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object lblEarlyPaymentDiscount: TLabel
        Left = 2
        Top = 34
        Width = 91
        Height = 15
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = 'Early Payment'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
        Transparent = True
      end
      object lblShipTitle: TLabel
        Left = 4
        Top = 17
        Width = 46
        Height = 15
        Caption = 'Shipped'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblShipped: TLabel
        Left = 66
        Top = 18
        Width = 41
        Height = 15
        AutoSize = False
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
        Left = 66
        Top = 1
        Width = 41
        Height = 15
        AutoSize = False
        Caption = 'lblOrdered'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object lblOrdTitle: TLabel
        Left = 4
        Top = 1
        Width = 47
        Height = 15
        Caption = 'Ordered'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblEstimatedFinalAmt: TLabel
        Left = 65
        Top = 70
        Width = 77
        Height = 15
        AutoSize = False
        Caption = 'lblEstimatedFinalAmt'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object lblEstimatedFinalAmtCaption: TLabel
        Left = 4
        Top = 68
        Width = 56
        Height = 15
        Caption = 'Estimate :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblWeightcaption: TLabel
        Left = 32
        Top = 97
        Width = 40
        Height = 15
        Caption = 'Weight'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblWeight: TLabel
        Left = 102
        Top = 97
        Width = 51
        Height = 15
        Caption = 'lblWeight'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
    end
    object txtConNote: TDBEdit
      Left = 351
      Top = 101
      Width = 110
      Height = 23
      DataField = 'ConNote'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      OnEnter = OverrideAccessLevel
      OnExit = RestoreOverridenAccessLevel
    end
    object edtContributionAmount: TwwDBEdit
      Left = 683
      Top = 4
      Width = 88
      Height = 24
      Hint = 
        'Double Click To Add the Customer as a Related Customer to the co' +
        'ntributor. If already a Related Customer to the Contributor, Ope' +
        'n the Contributor Record'
      TabStop = False
      DataField = 'ContributionAmount'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnDblClick = edtContributionAmountDblClick
    end
    object Label11: TDNMSpeedButton
      Left = 768
      Top = 3
      Width = 61
      Height = 38
      Caption = 'Paid'
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
      TabOrder = 18
      WordWrap = True
      AutoDisableParentOnclick = True
    end
    object edtPayment: TDBEdit
      Left = 835
      Top = 0
      Width = 105
      Height = 24
      TabStop = False
      Anchors = [akRight, akBottom]
      DataField = 'Payment'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      ReadOnly = True
      TabOrder = 15
    end
    object edtBalance: TDBEdit
      Left = 835
      Top = 23
      Width = 105
      Height = 24
      TabStop = False
      Anchors = [akRight, akBottom]
      DataField = 'Balance'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      ReadOnly = True
      TabOrder = 16
    end
    object edtApprovedAmount: TDBEdit
      Left = 835
      Top = 4
      Width = 105
      Height = 24
      TabStop = False
      Anchors = [akRight, akBottom]
      DataField = 'ApprovedAmount'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      ReadOnly = True
      TabOrder = 17
    end
    object btnSignature: TDNMSpeedButton
      Left = 8
      Top = 49
      Width = 65
      Height = 22
      Action = actSignature
      Caption = 'Signature'
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
      TabOrder = 19
      AutoDisableParentOnclick = True
    end
    object btnAddFreight: TDNMSpeedButton
      Left = 777
      Top = 32
      Width = 49
      Height = 36
      Caption = 'Add Freight'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      TabOrder = 20
      Visible = False
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnAddFreightClick
    end
  end
  inherited pnlHeader: TDNMPanel
    Width = 952
    ExplicitWidth = 952
    DesignSize = (
      952
      237)
    object bvelCustomerDetails: TBevel [0]
      Left = 4
      Top = 119
      Width = 238
      Height = 88
    end
    object Bvlshipto: TBevel [1]
      Left = 619
      Top = 99
      Width = 234
      Height = 122
    end
    inherited Label38: TLabel [2]
      Left = 16
      Caption = 'Customer Name'
      ExplicitLeft = 16
    end
    inherited lblClientDetails: TLabel [3]
      Top = 122
      Width = 26
      ExplicitTop = 122
      ExplicitWidth = 26
    end
    inherited SaleDate_Label: TLabel [4]
      Left = 618
      ExplicitLeft = 618
    end
    inherited Label160: TLabel [5]
      Left = 759
      ExplicitLeft = 759
    end
    object ClassLabel: TLabel [6]
      Left = 283
      Top = 38
      Width = 107
      Height = 18
      AutoSize = False
      Caption = 'Class'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label43: TLabel [7]
      Left = 11
      Top = 194
      Width = 83
      Height = 18
      Alignment = taCenter
      AutoSize = False
      Caption = 'P.O. Number'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label47: TLabel [8]
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
    object Label79: TLabel [9]
      Left = 490
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
    object Label45: TLabel [10]
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
    object lblAccount: TLabel [11]
      Left = 16
      Top = 1
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
    inherited Label48: TLabel [12]
      Left = 126
      ExplicitLeft = 126
    end
    inherited lbMemTrans: TLabel [13]
      Left = 709
      ExplicitLeft = 709
    end
    inherited lblBaseForeignCurrencyCode: TLabel [14]
      Left = 473
      Top = 93
      ExplicitLeft = 473
      ExplicitTop = 93
    end
    object Label10: TLabel [15]
      Left = 170
      Top = 89
      Width = 47
      Height = 16
      AutoSize = False
      Caption = 'Equip'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
      WordWrap = True
    end
    inherited lblBaseExchangeRate: TLabel [16]
      Left = 474
      Top = 150
      Width = 85
      Height = 15
      AutoSize = True
      Visible = True
      ExplicitLeft = 474
      ExplicitTop = 150
      ExplicitWidth = 85
      ExplicitHeight = 15
    end
    inherited lblRedeemPoints: TLabel [17]
    end
    inherited imgSearch: TImage [18]
    end
    inherited lblStatus: TLabel [19]
      Top = 200
      ExplicitTop = 200
    end
    object Label8: TLabel [20]
      Left = 618
      Top = 81
      Width = 92
      Height = 15
      AutoSize = False
      Caption = 'Sales Category'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblArea: TLabel [21]
      Left = 716
      Top = 39
      Width = 75
      Height = 15
      Caption = 'Area Number'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object edt_SaleNum_Seq: TDBText [22]
      Left = 829
      Top = 85
      Width = 117
      Height = 16
      DataField = 'SaleNum_Seq'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    inherited cboCurrentTransStatus: TwwDBLookupCombo [23]
      Left = 248
      Top = 212
      Selected.Strings = (
        'Name'#9'75'#9'Name'#9'F')
      TabOrder = 31
      ExplicitLeft = 248
      ExplicitTop = 212
    end
    object txtShipTo: TDBMemo [24]
      Left = 632
      Top = 118
      Width = 227
      Height = 84
      DataField = 'ShipTo'
      DataSource = DSMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 15
      OnDblClick = txtShipToDblClick
      OnEnter = txtShipToEnter
      OnExit = txtShipToExit
    end
    object editField: TEdit [25]
      Left = 492
      Top = 60
      Width = 57
      Height = 26
      TabOrder = 23
      Text = 'editField'
      Visible = False
      OnChange = editFieldChange
    end
    inherited txtClientDetails: TDBMemo [26]
      Top = 137
      Height = 52
      DataField = 'InvoiceTo'
      TabOrder = 2
      ExplicitTop = 137
      ExplicitHeight = 52
    end
    inherited cboCreationDate: TwwDBDateTimePicker [27]
      Left = 617
      Top = 54
      DataField = 'SaleDate'
      Date = 0.000000000000000000
      TabOrder = 5
      ExplicitLeft = 617
      ExplicitTop = 54
    end
    object cboClass: TwwDBLookupCombo [28]
      Left = 283
      Top = 52
      Width = 131
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      DataField = 'Class'
      DataSource = DSMaster
      LookupTable = cboClassQry
      LookupField = 'ClassName'
      ParentFont = False
      TabOrder = 4
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboClassCloseUp
    end
    object txtPONumber: TDBEdit [29]
      Left = 15
      Top = 209
      Width = 98
      Height = 23
      DataField = 'PONumber'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object cboTerms: TwwDBLookupCombo [30]
      Left = 491
      Top = 209
      Width = 111
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
      TabOrder = 8
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboTermsCloseUp
    end
    object cboDueDate: TwwDBDateTimePicker [31]
      Left = 604
      Top = 209
      Width = 111
      Height = 23
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
      TabOrder = 9
      UnboundDataType = wwDTEdtDate
    end
    object cmdDeliveryDocket: TDNMSpeedButton [32]
      Left = 821
      Top = 164
      Width = 43
      Height = 27
      Anchors = [akTop, akRight]
      Caption = '&Del'
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
      TabOrder = 25
      TabStop = False
      AutoDisableParentOnclick = True
    end
    object cmdPrintPick: TDNMSpeedButton [33]
      Left = 777
      Top = 164
      Width = 43
      Height = 27
      Anchors = [akTop, akRight]
      Caption = 'Pic&k'
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
      TabOrder = 21
      TabStop = False
      AutoDisableParentOnclick = True
    end
    object cboAccount: TwwDBLookupCombo [34]
      Left = 12
      Top = 15
      Width = 227
      Height = 23
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'50'#9'AccountName'#9'F')
      DataField = 'Account'
      DataSource = DSMaster
      LookupTable = cboAccountQry
      LookupField = 'AccountName'
      ParentFont = False
      TabOrder = 22
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboAccountCloseUp
    end
    inherited txtCustomID: TDBEdit [35]
      Left = 759
      Top = 54
      DataField = 'InvoiceDocNumber'
      TabOrder = 6
      ExplicitLeft = 759
      ExplicitTop = 54
    end
    inherited cboEmployee: TwwDBLookupCombo [36]
      Left = 126
      Top = 209
      Selected.Strings = (
        'EmployeeName'#9'30'#9'Employee Name'#9'F')
      DataField = 'EmployeeName'
      TabOrder = 13
      OnExit = cboEmployeeExit
      ExplicitLeft = 126
      ExplicitTop = 209
    end
    inherited btnNext: TDNMSpeedButton [37]
      Left = 865
      Top = 1
      Caption = '&New'
      Font.Height = -12
      TabOrder = 34
      ExplicitLeft = 865
      ExplicitTop = 1
    end
    inherited btnCompleted: TDNMSpeedButton [38]
      Left = 865
      Top = 76
      Caption = '&Save'
      Font.Charset = DEFAULT_CHARSET
      Font.Height = -12
      ModalResult = 0
      TabOrder = 18
      ExplicitLeft = 865
      ExplicitTop = 76
    end
    inherited btnClose: TDNMSpeedButton [39]
      Left = 865
      Top = 109
      Font.Charset = DEFAULT_CHARSET
      Font.Height = -12
      ModalResult = 0
      TabOrder = 19
      ExplicitLeft = 865
      ExplicitTop = 109
    end
    inherited btnPreview: TDNMSpeedButton [40]
      Left = 865
      Top = 142
      Font.Height = -12
      TabOrder = 20
      ExplicitLeft = 865
      ExplicitTop = 142
    end
    inherited btnPrint: TDNMSpeedButton [41]
      Left = 865
      Top = 175
      Font.Height = -12
      TabOrder = 26
      ExplicitLeft = 865
      ExplicitTop = 175
    end
    inherited pnlChooseRpt: TDNMPanel [42]
      Left = 304
      Top = 104
      TabOrder = 24
      ExplicitLeft = 304
      ExplicitTop = 104
      inherited chkChooseRpt: TCheckBox
        Left = 8
        Top = 3
        ExplicitLeft = 8
        ExplicitTop = 3
      end
    end
    object cboVia: TwwDBLookupCombo [43]
      Left = 364
      Top = 214
      Width = 121
      Height = 23
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
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnChange = cboViaChange
      OnCloseUp = cboViaCloseUp
    end
    object pnlHold: TDNMPanel [44]
      Left = 304
      Top = 77
      Width = 132
      Height = 23
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      object lblHoldSale: TLabel
        Left = 28
        Top = 4
        Width = 53
        Height = 15
        Caption = 'Hold Sale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object chkHoldSale: TwwCheckBox
        Left = 6
        Top = 4
        Width = 16
        Height = 17
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
        DataField = 'HoldSale'
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
    inherited btnContacts: TDNMSpeedButton [45]
      Top = 52
      TabOrder = 10
      ExplicitTop = 52
    end
    inherited cboBaseForeignCurrencyCode: TwwDBLookupCombo [46]
      Left = 472
      DataField = 'ForeignExchangeCode'
      TabOrder = 11
      OnChange = cboBaseForeignCurrencyCodeChange
      OnExit = cboBaseForeignCurrencyCodeExit
      ExplicitLeft = 472
    end
    inherited edtBaseExchangeRate: TwwDBEdit [47]
      Left = 472
      DataField = 'ForeignExchangeRate'
      TabOrder = 12
      Visible = True
      ExplicitLeft = 472
    end
    inherited pnlTitle: TDNMPanel [48]
      Width = 305
      Locked = True
      TabOrder = 7
      ExplicitWidth = 305
      inherited TitleShader: TShader
        Width = 303
        ExplicitWidth = 303
        inherited TitleLabel: TLabel
          Width = 303
          ExplicitWidth = 303
        end
      end
    end
    inherited cboClientR: TERPDbLookupCombo [49]
      Left = 12
      Top = 56
      Selected.Strings = (
        'Company'#9'35'#9'Company'#9'F')
      AutoSelect = True
      LookupFormClassName = 'TCustomerExpressListGUI'
      EditFormClassName = 'TfrmCustomer'
      LookupFormKeyStringFieldName = 'Company'
      LookupComboType = ctCustomer
      OnBeforeOpenList = cboClientRBeforeOpenList
      LookupIDField = 'ClientID'
      LookupFieldAlt = 'PrintName'
      ExplicitLeft = 12
      ExplicitTop = 56
    end
    object btnPrepayment: TDNMSpeedButton [50]
      Left = 324
      Top = 130
      Width = 87
      Height = 27
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
      TabOrder = 35
      AutoDisableParentOnclick = True
      OnClick = btnPrepaymentClick
    end
    object btnRepairEquipment: TDNMSpeedButton [51]
      Left = 221
      Top = 86
      Width = 25
      Height = 23
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C000000000000000000000000000000000001FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000FF00FFFF00
        FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
        0000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00
        FFFF00FFFF00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FF00
        0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000FF00
        FFFF00FFFF00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FF00000000
        0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000000000
        00FF00FFFF00FFFF00FF000000000000FF00FFFF00FFFF00FF000000000000FF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000000000
        00FF00FFFF00FFFF00FF000000000000FF00FFFF00FFFF00FF000000000000FF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000
        00000000FF00FFFF00FF000000000000FF00FFFF00FF000000000000FF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        000000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000
        00000000FF00FFFF00FF000000000000FF00FFFF00FF000000000000FF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000
        101010525252101010000000000000000000FF00FFFF00FFFF00FFFF00FFFF00
        FF000000000000FF00FF000000000000FF00FF000000000000FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000101010
        101010525252101010101010000000101010000000000000FF00FFFF00FFFF00
        FF000000000000000000000000000000000000000000000000FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000101010
        101010424242525252101010000000212121101010101010000000000000FF00
        FFFF00FF000000212121525252525252525252000000FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF000000000000FF00FFFF00FFFF00FF000000101010
        101010737373FF63001010100000005252524242422121211010101010100000
        0000000000000000000021212121212152525252525200000000000000000000
        0000000000000000000000000000000000FF00FFFF00FFFF00FF000000101010
        1010105252524242425252520000008C8C8C7373735252524242422121211010
        10101010000000000000000000000000212121000000000000FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF000000000000FF00FFFF00FFFF00FF000000101010
        525252101010101010101010000000BDBDBDBDBDBD8C8C8C7373735252524242
        42212121101010101010000000000000000000000000000000FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000
        101010101010000000000000FFFFFFDEDEDEDEDEDEBDBDBDBDBDBD8C8C8C7373
        73525252424242212121101010101010000000000000FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000
        000000000000BDBDBDDEDEDEDEDEDEEFEFEFFFFFFFEFEFEFDEDEDEBDBDBDBDBD
        BD8C8C8C737373525252424242212121101010101010000000000000FF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF000000000000BDBDBD8C8C8C5252528C8C8CEFEFEFFFFFFFDEDEDEDEDE
        DEBDBDBDBDBDBD8C8C8C73737352525242424221212110101010101000000000
        0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF000000000000BDBDBD000000DEDEDEDEDEDEEFEFEFFFFF
        FFDEDEDEDEDEDEBDBDBDBDBDBD8C8C8C73737352525242424221212110101010
        1010000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF000000BDBDBD000000BDBDBDBDBDBDDEDEDEDEDE
        DEEFEFEFFFFFFFDEDEDEDEDEDEBDBDBDBDBDBD8C8C8C73737352525242424221
        2121101010101010000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF000000BDBDBD000000000000000000BDBDBDBDBD
        BDDEDEDEDEDEDEEFEFEFFFFFFFDEDEDEDEDEDEBDBDBDBDBDBD8C8C8C73737352
        5252424242212121101010101010000000000000FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF000000DEDEDE000000FF00FFFF00FF0000000000
        00BDBDBDBDBDBDDEDEDEDEDEDEEFEFEFFFFFFFDEDEDEDEDEDEBDBDBDBDBDBD8C
        8C8C737373525252424242212121101010000000FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF000000525252000000FF00FFFF00FFFF00FFFF00
        FF000000000000BDBDBDBDBDBDDEDEDEDEDEDEEFEFEFFFFFFFDEDEDEDEDEDEBD
        BDBDBDBDBD8C8C8C737373525252424242212121000000FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF000000000000000000FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FF000000000000BDBDBDBDBDBDDEDEDEDEDEDEEFEFEFFFFFFFDE
        DEDEDEDEDEBDBDBDBDBDBD8C8C8C737373525252000000FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF000000000000BDBDBDBDBDBDDEDEDEDEDEDEEF
        EFEFFFFFFFDEDEDEDEDEDEBDBDBDBDBDBD8C8C8C000000FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000BDBDBDBDBDBDDE
        DEDEDEDEDEEFEFEFFFFFFFDEDEDEDEDEDEBDBDBD000000FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000BD
        BDBDBDBDBDDEDEDEDEDEDEEFEFEFFFFFFFDEDEDE000000FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
        0000000000BDBDBDBDBDBDDEDEDEDEDEDE000000FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF000000000000000000000000FF00FFFF00FFFF00FF}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Layout = blGlyphRight
      NumGlyphs = 1
      ParentFont = False
      TabOrder = 27
      AutoDisableParentOnclick = True
      OnClick = btnRepairEquipmentClick
    end
    object btnCreateJob: TDNMSpeedButton [52]
      Left = 269
      Top = 158
      Width = 87
      Height = 27
      Action = actCreateJob
      Caption = 'Create a Job'
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
    object pnlParentclient: TDNMPanel [53]
      Left = 9
      Top = 83
      Width = 155
      Height = 30
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 29
      Transparent = False
      object lblParentclient: TLabel
        Left = 5
        Top = 7
        Width = 84
        Height = 15
        Alignment = taRightJustify
        Caption = 'Related Parent'
        Transparent = True
        OnClick = lblParentclientClick
      end
      object edtParentclient: TwwDBEdit
        Left = 92
        Top = 3
        Width = 142
        Height = 23
        DataField = 'Mastercompany'
        DataSource = DSMaster
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = True
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
    end
    object cmdFax: TDNMSpeedButton [54]
      Left = 736
      Top = 208
      Width = 43
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
      TabOrder = 30
      Visible = False
      AutoDisableParentOnclick = True
    end
    inherited btnPayments: TDNMSpeedButton [55]
      Left = 616
      Top = 2
      TabOrder = 14
      ExplicitLeft = 616
      ExplicitTop = 2
    end
    object cboSalesCategory: TwwDBLookupCombo [56]
      Left = 709
      Top = 79
      Width = 111
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ControlInfoInDataset = False
      DropDownAlignment = taLeftJustify
      DataField = 'SalesCategory'
      DataSource = DSMaster
      LookupTable = QrySalesCAtegory
      LookupField = 'Name'
      AutoSelect = False
      DropDownWidth = 50
      MaxLength = 255
      ParentFont = False
      TabOrder = 32
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      ShowMatchText = True
      OnDblClick = cboSalesCategoryDblClick
      OnNotInList = cboSalesCategoryNotInList
    end
    inherited cmdEmail: TDNMSpeedButton [57]
      Left = 777
      Top = 197
      TabOrder = 33
      Visible = True
      ExplicitLeft = 777
      ExplicitTop = 197
    end
    inherited btnPDF: TDNMSpeedButton [58]
      Left = 821
      Top = 197
      ExplicitLeft = 821
      ExplicitTop = 197
    end
    inherited btnEdit: TDNMSpeedButton [59]
      Hint = 'Add a new line to a locked Sale'
      TabOrder = 36
    end
    object btnShipment: TDNMSpeedButton
      Left = 620
      Top = 102
      Width = 54
      Height = 16
      Hint = 'Sale Shipments'
      Caption = 'Ship To'
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
      TabOrder = 37
      AutoDisableParentOnclick = True
      OnClick = btnShipmentClick
    end
    object cboAreaCode: TwwDBLookupCombo
      Left = 716
      Top = 52
      Width = 102
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
      DataSource = DSMaster
      LookupTable = QryAreaCodes
      LookupField = 'AreaCode'
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 38
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object btnPrevious: TDNMSpeedButton
      Left = 865
      Top = 40
      Width = 41
      Height = 27
      Action = actPrev
      Anchors = [akTop, akRight]
      Caption = 'Prev'
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
      TabOrder = 39
      TabStop = False
      AutoDisableParentOnclick = True
    end
    object btnNextSale: TDNMSpeedButton
      Left = 912
      Top = 43
      Width = 41
      Height = 27
      Action = actNext
      Anchors = [akTop, akRight]
      Caption = 'Next'
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
      TabOrder = 40
      TabStop = False
      AutoDisableParentOnclick = True
    end
    object btnShiptocontact: TDNMSpeedButton
      Left = 675
      Top = 102
      Width = 25
      Height = 16
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
        055557777777777775F508888888888880557F5FFFFFFFFFF75F080000000000
        88057577777777775F755080FFFFFF05088057F7FFFFFF7575F70000000000F0
        F08077777777775757F70FFFFFFFFF0F008075F5FF5FF57577F750F00F00FFF0
        F08057F775775557F7F750FFFFFFFFF0F08057FF5555555757F7000FFFFFFFFF
        0000777FF5FFFFF577770900F00000F000907F775777775777F7090FFFFFFFFF
        00907F7F555555557757000FFFFFFFFF0F00777F5FFF5FF57F77550F000F00FF
        0F05557F777577557F7F550FFFFFFFFF0005557F555FFFFF7775550FFF000000
        05555575FF777777755555500055555555555557775555555555}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 41
      AutoDisableParentOnclick = True
      OnClick = btnShiptocontactClick
    end
    object pnlShipToMessage: TPanel
      Left = 630
      Top = 163
      Width = 185
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 42
      DesignSize = (
        185
        23)
      object lblShipToMessage: TLabel
        Left = 8
        Top = 5
        Width = 177
        Height = 16
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight, akBottom]
        AutoSize = False
        Caption = 'Double click for ship addresses'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
    object btninvoices: TDNMSpeedButton
      Left = 630
      Top = 23
      Width = 87
      Height = 27
      Anchors = [akTop, akRight]
      Caption = 'Invoices'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        55555555FFFFFFFF5555555000000005555555577777777FF555550999999900
        55555575555555775F55509999999901055557F55555557F75F5001111111101
        105577FFFFFFFF7FF75F00000000000011057777777777775F755070FFFFFF0F
        01105777F555557F75F75500FFFFFF0FF0105577F555FF7F57575550FF700008
        8F0055575FF7777555775555000888888F005555777FFFFFFF77555550000000
        0F055555577777777F7F555550FFFFFF0F05555557F5FFF57F7F555550F000FF
        0005555557F777557775555550FFFFFF0555555557F555FF7F55555550FF7000
        05555555575FF777755555555500055555555555557775555555}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 43
      TabStop = False
      Visible = False
      AutoDisableParentOnclick = True
      OnClick = btninvoicesClick
    end
    object btnConSmart: TDNMSpeedButton
      Left = 357
      Top = 163
      Width = 111
      Height = 25
      Action = actconsmart
      Caption = 'Copy To smart'
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
      TabOrder = 44
      AutoDisableParentOnclick = True
    end
    object btnShowDetails: TDNMSpeedButton
      Left = 859
      Top = 208
      Width = 87
      Height = 27
      Caption = 'Summary'
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
      TabOrder = 45
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnShowDetailsClick
    end
    object btnRefNo: TDNMSpeedButton
      Left = 902
      Top = 204
      Width = 41
      Height = 27
      Anchors = [akTop, akRight]
      Caption = 'Ref No'
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
      TabOrder = 46
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnRefNoClick
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 712
    Top = 295
  end
  inherited tmrdelay: TTimer
    Left = 786
    Top = 295
  end
  inherited popSpelling: TPopupMenu
    Left = 194
    Top = 295
  end
  inherited tmrdelayMsg: TTimer
    Left = 675
    Top = 295
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 379
    Top = 295
  end
  inherited DSDetails: TDataSource
    Left = 38
    Top = 362
  end
  inherited DSMaster: TDataSource
    Left = 7
    Top = 362
  end
  inherited lsTDNMSpeedButtonActions: TActionList
    Left = 305
    Top = 295
    object actPick: TAction [4]
      Caption = 'Print Pic&k'
      OnUpdate = actPickUpdate
    end
    object actDelDocket: TAction [5]
      Caption = 'Delivery Do&cket'
      OnExecute = actDelDocketExecute
      OnUpdate = actDelDocketUpdate
    end
    object actCreateJob: TDNMAction
      Caption = 'Create a Job'
      OnExecute = actCreateJobExecute
      OnUpdate = actCreateJobUpdate
      buttoncolor = clWhite
    end
    object actcheckdiscount: TDNMAction
      Caption = 'Check Discount'
      OnExecute = actcheckdiscountExecute
      OnUpdate = actcheckdiscountUpdate
      buttoncolor = clWhite
    end
    object actManifestList: TDNMAction
      Caption = 'Manifest List'
      OnExecute = actManifestListExecute
      OnUpdate = actManifestListUpdate
      buttoncolor = clWhite
    end
    object actNext: TAction
      Caption = 'Next'
      OnExecute = actNextExecute
    end
    object actPrev: TAction
      Caption = 'Prev'
      OnExecute = actPrevExecute
    end
    object actSignature: TAction
      Caption = 'Signature'
      OnExecute = actSignatureExecute
      OnUpdate = actSignatureUpdate
    end
    object actconsmart: TDNMAction
      Caption = 'Copy To smart'
      OnExecute = actconsmartExecute
      OnUpdate = actconsmartUpdate
      buttoncolor = clWhite
    end
  end
  inherited popDscntMrkup: TAdvPopupMenu
    Left = 157
    Top = 295
  end
  inherited popMemTrans: TAdvPopupMenu
    Left = 638
    Top = 295
    inherited mnuStockTransferEntrylist: TMenuItem
      Visible = True
    end
    object CheckDiscounts1: TMenuItem
      Action = actcheckdiscount
    end
    object mnuconvertedToList: TMenuItem
      Caption = 'Converted To'
    end
    object SmartPurchaseOrders1: TMenuItem
      Caption = 'Smart / Purchase Orders'
      OnClick = SmartPurchaseOrders1Click
    end
    object Repairs1: TMenuItem
      Caption = 'Repairs'
      OnClick = Repairs1Click
    end
    object ProductSelectionOptions1: TMenuItem
      Caption = 'Product Selection Options'
      OnClick = ProductSelectionOptions1Click
    end
    object ManifestList1: TMenuItem
      Action = actManifestList
    end
  end
  inherited tblMaster: TERPQuery
    BeforeOpen = tblMasterBeforeOpen
    BeforeClose = tblMasterBeforeClose
    OnCalcFields = tblMasterCalcFields
    Left = 7
    Top = 330
    object tblMasterSaleID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'SaleID'
      Origin = 'tblsales.SaleID'
      ReadOnly = True
    end
    object tblMasterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblsales.GlobalRef'
      Size = 255
    end
    object tblMasterInvoiceDocNumber: TWideStringField
      FieldName = 'InvoiceDocNumber'
      Origin = 'tblsales.InvoiceDocNumber'
      OnSetText = tblMasterInvoiceDocNumberSetText
      Size = 30
    end
    object tblMasterArea: TWideStringField
      DisplayWidth = 50
      FieldName = 'Area'
      Origin = 'tblsales.Area'
      Size = 50
    end
    object tblMasterOriginalNo: TWideStringField
      FieldName = 'OriginalNo'
      Origin = 'tblsales.OriginalNo'
      Size = 50
    end
    object tblMasterAccount: TWideStringField
      FieldName = 'Account'
      Origin = 'tblsales.Account'
      Size = 255
    end
    object tblMasterCustomerName: TWideStringField
      FieldName = 'CustomerName'
      Origin = 'tblsales.CustomerName'
      Size = 255
    end
    object tblMasterInvoiceTo: TWideStringField
      FieldName = 'InvoiceTo'
      Origin = 'tblsales.InvoiceTo'
      Size = 255
    end
    object tblMasterDefaultReferenceNoinAllLines: TWideStringField
      FieldName = 'DefaultReferenceNoinAllLines'
      Origin = 'tblsales.DefaultReferenceNoinAllLines'
      Size = 1
    end
    object tblMasterIsdone: TWideStringField
      FieldName = 'Isdone'
      Origin = 'tblsales.Isdone'
      Size = 1
    end
    object tblMasterReferenceNo: TWideStringField
      FieldName = 'ReferenceNo'
      Origin = 'tblsales.ReferenceNo'
      Size = 255
    end
    object tblMasterSaleNum_Seq: TStringField
      FieldKind = fkCalculated
      FieldName = 'SaleNum_Seq'
      Size = 50
      Calculated = True
    end
    object tblMasterShipTo: TWideStringField
      FieldName = 'ShipTo'
      Origin = 'tblsales.ShipTo'
      Size = 255
    end
    object tblMasterSaleDate: TDateField
      FieldName = 'SaleDate'
      Origin = 'tblsales.SaleDate'
    end
    object tblMasterOriginalSaleId: TIntegerField
      FieldKind = fkLookup
      FieldName = 'OriginalSaleId'
      LookupDataSet = qrySaleLookup
      LookupKeyFields = 'GlobalRef'
      LookupResultField = 'SaleID'
      KeyFields = 'OriginalNo'
      Lookup = True
    end
    object tblMasterTotalTax: TFloatField
      FieldName = 'TotalTax'
      Origin = 'tblsales.TotalTax'
      DisplayFormat = '$#0.00###'
      EditFormat = '$#0.00###'
      currency = True
    end
    object tblMasterTotalAmount: TFloatField
      FieldName = 'TotalAmount'
      Origin = 'tblsales.TotalAmount'
      currency = True
    end
    object tblMasterTotalAmountInc: TFloatField
      FieldName = 'TotalAmountInc'
      Origin = 'tblsales.TotalAmountInc'
      currency = True
    end
    object tblMasterTotalMarkup: TFloatField
      FieldName = 'TotalMarkup'
      Origin = 'tblsales.TotalMarkup'
      currency = True
    end
    object tblMasterTotalDiscount: TFloatField
      FieldName = 'TotalDiscount'
      Origin = 'tblsales.TotalDiscount'
      currency = True
    end
    object tblMasterEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Origin = 'tblsales.EmployeeName'
      Size = 255
    end
    object tblMasterClass: TWideStringField
      FieldName = 'Class'
      Origin = 'tblsales.Class'
      Size = 255
    end
    object tblMasterOrderNumber: TWideStringField
      FieldName = 'OrderNumber'
      Origin = 'tblsales.OrderNumber'
      Size = 30
    end
    object tblMasterPONumber: TWideStringField
      FieldName = 'PONumber'
      Origin = 'tblsales.PONumber'
      Size = 30
    end
    object tblMasterShipDate: TDateField
      FieldName = 'ShipDate'
      Origin = 'tblsales.ShipDate'
    end
    object tblMasterDueDate: TDateField
      FieldName = 'DueDate'
      Origin = 'tblsales.DueDate'
    end
    object tblMasterConNote: TWideStringField
      FieldName = 'ConNote'
      Origin = 'tblsales.ConNote'
      Size = 25
    end
    object tblMasterInvoicePrintDesc: TWideStringField
      FieldName = 'InvoicePrintDesc'
      Origin = 'tblsales.InvoicePrintDesc'
      Size = 255
    end
    object tblMasterPrintHold: TWideStringField
      FieldName = 'PrintHold'
      Origin = 'tblsales.PrintHold'
      FixedChar = True
      Size = 1
    end
    object tblMasterShipping: TWideStringField
      FieldName = 'Shipping'
      Origin = 'tblsales.Shipping'
      Size = 255
    end
    object tblMasterTerms: TWideStringField
      FieldName = 'Terms'
      Origin = 'tblsales.Terms'
      Size = 255
    end
    object tblMasterPayMethod: TWideStringField
      FieldName = 'PayMethod'
      Origin = 'tblsales.PayMethod'
      Size = 50
    end
    object tblMasterPayDueDate: TWideStringField
      FieldName = 'PayDueDate'
      Origin = 'tblsales.PayDueDate'
      Size = 11
    end
    object tblMasterPaid: TWideStringField
      FieldName = 'Paid'
      Origin = 'tblsales.Paid'
      FixedChar = True
      Size = 1
    end
    object tblMasterBalance: TFloatField
      FieldName = 'Balance'
      Origin = 'tblsales.Balance'
      currency = True
    end
    object tblMasterPayment: TFloatField
      FieldName = 'Payment'
      Origin = 'tblsales.Payment'
    end
    object tblMasterApplyFlag: TWideStringField
      FieldName = 'ApplyFlag'
      Origin = 'tblsales.ApplyFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterAmountDue: TFloatField
      FieldName = 'AmountDue'
      Origin = 'tblsales.AmountDue'
      currency = True
    end
    object tblMasterTimeOfSale: TWideStringField
      FieldName = 'TimeOfSale'
      Origin = 'tblsales.TimeOfSale'
      Size = 11
    end
    object tblMasterPOS: TWideStringField
      FieldName = 'POS'
      Origin = 'tblsales.POS'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsCashSale: TWideStringField
      FieldName = 'IsCashSale'
      Origin = 'tblsales.IsCashSale'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsInvoice: TWideStringField
      FieldName = 'IsInvoice'
      Origin = 'tblsales.IsInvoice'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsQuote: TWideStringField
      FieldName = 'IsQuote'
      Origin = 'tblsales.IsQuote'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsSalesOrder: TWideStringField
      FieldName = 'IsSalesOrder'
      Origin = 'tblsales.IsSalesOrder'
      FixedChar = True
      Size = 1
    end
    object tblMasterDeleted: TWideStringField
      FieldName = 'Deleted'
      Origin = 'tblsales.Deleted'
      FixedChar = True
      Size = 1
    end
    object tblMasterCancelled: TWideStringField
      FieldName = 'Cancelled'
      Origin = 'tblsales.Cancelled'
      FixedChar = True
      Size = 1
    end
    object tblMasterEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblsales.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsRefund: TWideStringField
      FieldName = 'IsRefund'
      Origin = 'tblsales.IsRefund'
      FixedChar = True
      Size = 1
    end
    object tblMasterTotalQuoteAmount: TFloatField
      FieldName = 'TotalQuoteAmount'
      Origin = 'tblsales.TotalQuoteAmount'
      currency = True
    end
    object tblMasterBOID: TWideStringField
      FieldName = 'BOID'
      Origin = 'tblsales.BOID'
      Size = 255
    end
    object tblMasterClassID: TIntegerField
      FieldName = 'ClassID'
      Origin = 'tblsales.ClassID'
    end
    object tblMasterChequeNo: TWideStringField
      FieldName = 'ChequeNo'
      Origin = 'tblsales.ChequeNo'
      Size = 45
    end
    object tblMasterClientID: TIntegerField
      FieldName = 'ClientID'
      Origin = 'tblsales.ClientID'
    end
    object tblMasterAccountID: TIntegerField
      FieldName = 'AccountID'
      Origin = 'tblsales.AccountID'
    end
    object tblMasterEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblsales.EmployeeID'
    end
    object tblMasterIsLayby: TWideStringField
      FieldName = 'IsLayby'
      Origin = 'tblsales.IsLayby'
      FixedChar = True
      Size = 1
    end
    object tblMasterLaybyID: TWideStringField
      FieldName = 'LaybyID'
      Origin = 'tblsales.LaybyID'
      Size = 14
    end
    object tblMasterIsPOS: TWideStringField
      FieldName = 'IsPOS'
      Origin = 'tblsales.IsPOS'
      FixedChar = True
      Size = 1
    end
    object tblMasterDeposited: TWideStringField
      FieldName = 'Deposited'
      Origin = 'tblsales.Deposited'
      FixedChar = True
      Size = 1
    end
    object tblMasterHoldSale: TWideStringField
      FieldName = 'HoldSale'
      Origin = 'tblsales.HoldSale'
      FixedChar = True
      Size = 1
    end
    object tblMasterMemo: TWideMemoField
      FieldName = 'Memo'
      Origin = 'tblsales.Memo'
      BlobType = ftWideMemo
    end
    object tblMasterComments: TWideMemoField
      FieldName = 'Comments'
      Origin = 'tblsales.Comments'
      BlobType = ftWideMemo
    end
    object tblMasterEnteredBy: TWideStringField
      FieldName = 'EnteredBy'
      Origin = 'tblsales.EnteredBy'
      Size = 255
    end
    object tblMasterEnteredAt: TWideStringField
      FieldName = 'EnteredAt'
      Origin = 'tblsales.EnteredAt'
      Size = 255
    end
    object tblMasterSOBalance: TFloatField
      FieldName = 'SOBalance'
      Origin = 'tblsales.SOBalance'
    end
    object tblMasterFreezeQuoteAmount: TWideStringField
      FieldName = 'FreezeQuoteAmount'
      Origin = 'tblsales.FreezeQuoteAmount'
      FixedChar = True
      Size = 1
    end
    object tblMasterConverted: TWideStringField
      FieldName = 'Converted'
      Origin = 'tblsales.Converted'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsVoucher: TWideStringField
      FieldName = 'IsVoucher'
      Origin = 'tblsales.IsVoucher'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsLaybyTOS: TWideStringField
      FieldName = 'IsLaybyTOS'
      Origin = 'tblsales.IsLaybyTOS'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsLaybyPayment: TWideStringField
      FieldName = 'IsLaybyPayment'
      Origin = 'tblsales.IsLaybyPayment'
      FixedChar = True
      Size = 1
    end
    object tblMasterTillID: TSmallintField
      FieldName = 'TillID'
      Origin = 'tblsales.TillID'
    end
    object tblMasterCommissionPaid: TWideStringField
      FieldName = 'CommissionPaid'
      Origin = 'tblsales.CommissionPaid'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsManifest: TWideStringField
      FieldName = 'IsManifest'
      Origin = 'tblsales.IsManifest'
      FixedChar = True
      Size = 1
    end
    object tblMasterUsedOnManifest: TWideStringField
      FieldName = 'UsedOnManifest'
      Origin = 'tblsales.UsedOnManifest'
      FixedChar = True
      Size = 1
    end
    object tblMasterAddToManifest: TWideStringField
      FieldName = 'AddToManifest'
      Origin = 'tblsales.AddToManifest'
      FixedChar = True
      Size = 1
    end
    object tblMasterQuoteGlobalRef: TWideStringField
      FieldName = 'QuoteGlobalRef'
      Origin = 'tblsales.QuoteGlobalRef'
      Size = 255
    end
    object tblMasterSalesOrderGlobalRef: TWideStringField
      FieldName = 'SalesOrderGlobalRef'
      Origin = 'tblsales.SalesOrderGlobalRef'
      Size = 255
    end
    object tblMasterIsBarcodePicking: TWideStringField
      FieldName = 'IsBarcodePicking'
      Origin = 'tblsales.IsBarcodePicking'
      FixedChar = True
      Size = 1
    end
    object tblMasterBarcodePickingDone: TWideStringField
      FieldName = 'BarcodePickingDone'
      Origin = 'tblsales.BarcodePickingDone'
      FixedChar = True
      Size = 1
    end
    object tblMasterARNotes: TWideMemoField
      FieldName = 'ARNotes'
      Origin = 'tblsales.ARNotes'
      BlobType = ftWideMemo
    end
    object tblMasterOriginalCreationDate: TDateField
      FieldName = 'OriginalCreationDate'
      Origin = 'tblsales.OriginalCreationDate'
    end
    object tblMasterQuoteStatus: TWideStringField
      FieldName = 'QuoteStatus'
      Origin = 'tblsales.QuoteStatus'
      Size = 255
    end
    object tblMasterTotalWETTax: TFloatField
      FieldName = 'TotalWETTax'
      Origin = 'tblsales.TotalWETTax'
    end
    object tblMasterTotalWEGTax: TFloatField
      FieldName = 'TotalWEGTax'
      Origin = 'tblsales.TotalWEGTax'
    end
    object tblMasterLastUpdated: TDateTimeField
      FieldName = 'LastUpdated'
      Origin = 'tblsales.LastUpdated'
    end
    object tblMasterRepairGlobalRef: TWideStringField
      FieldName = 'RepairGlobalRef'
      Origin = 'tblsales.RepairGlobalRef'
      Size = 255
    end
    object tblMasterForeignExchangeCode: TWideStringField
      FieldName = 'ForeignExchangeCode'
      Origin = 'tblsales.ForeignExchangeCode'
      OnSetText = FeldSetTextDontAllowNulls
      FixedChar = True
      Size = 3
    end
    object tblMasterForeignExchangeRate: TFloatField
      FieldName = 'ForeignExchangeRate'
      Origin = 'tblsales.ForeignExchangeRate'
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblMasterForeignTotalAmount: TFloatField
      FieldName = 'ForeignTotalAmount'
      Origin = 'tblsales.ForeignTotalAmount'
      DisplayFormat = '###,###,###,##0.00;(###,###,###,##0.00)'
    end
    object tblMasterForeignPaidAmount: TFloatField
      FieldName = 'ForeignPaidAmount'
      Origin = 'tblsales.ForeignPaidAmount'
    end
    object tblMasterForeignBalanceAmount: TFloatField
      FieldName = 'ForeignBalanceAmount'
      Origin = 'tblsales.ForeignBalanceAmount'
    end
    object tblMasterBaseNo: TWideStringField
      FieldName = 'BaseNo'
      Origin = 'tblsales.BaseNo'
      Size = 255
    end
    object tblMasterSaleDateTime: TDateTimeField
      FieldName = 'SaleDateTime'
      Origin = 'tblsales.SaleDateTime'
    end
    object tblMasterContactID: TLargeintField
      FieldName = 'ContactID'
      Origin = 'tblsales.contactID'
    end
    object tblMasterContactName: TWideStringField
      FieldName = 'ContactName'
      Origin = 'tblsales.ContactName'
      Size = 100
    end
    object tblMasterRepairID: TLargeintField
      FieldName = 'RepairID'
      Origin = 'tblsales.RepairID'
    end
    object tblMasterNoOfBoxes: TLargeintField
      FieldName = 'NoOfBoxes'
      Origin = 'tblsales.NoOfBoxes'
    end
    object tblMasterContributionAmount: TFloatField
      FieldName = 'ContributionAmount'
      Origin = 'tblsales.ContributionAmount'
      currency = True
    end
    object tblMAsterMastercompany: TStringField
      FieldKind = fkLookup
      FieldName = 'Mastercompany'
      LookupDataSet = QryRelatedMaster
      LookupKeyFields = 'ChildclientId'
      LookupResultField = 'Mastercompany'
      KeyFields = 'ClientId'
      Lookup = True
    end
    object tblMasterApprovedAmount: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ApprovedAmount'
      currency = True
      Calculated = True
    end
    object tblMasterShipToID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ShipToID'
      Origin = 'tblsales.ShipToID'
      Visible = False
    end
    object tblMasterSalesCategory: TWideStringField
      FieldName = 'SalesCategory'
      Origin = 'tblsales.SalesCategory'
      Size = 255
    end
    object tblMasterEnteredAtShort: TStringField
      FieldKind = fkCalculated
      FieldName = 'EnteredAtShort'
      Size = 255
      Calculated = True
    end
    object tblMasterPickupFromID: TIntegerField
      FieldName = 'PickupFromID'
      Origin = 'tblsales.PickupFromID'
    end
    object tblMasterPickupFrom: TWideStringField
      FieldName = 'PickupFrom'
      Origin = 'tblsales.PickupFrom'
      Size = 255
    end
    object tblMasterPickMemo: TWideMemoField
      FieldName = 'PickMemo'
      Origin = 'tblsales.PickMemo'
      BlobType = ftWideMemo
    end
    object tblMasterShipTocontactID: TLargeintField
      FieldName = 'ShipTocontactID'
      Origin = 'tblsales.ShipTocontactID'
    end
    object tblMasterClientSignature: TBlobField
      FieldName = 'ClientSignature'
      Origin = 'tblsales.ClientSignature'
    end
    object tblMasterSignatureTime: TDateTimeField
      FieldName = 'SignatureTime'
      Origin = 'tblsales.SignatureTime'
    end
    object tblMasterClientPrintName: TWideStringField
      FieldName = 'ClientPrintName'
      Origin = 'tblsales.ClientPrintName'
      Size = 255
    end
    object tblMastermsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblsales.msTimeStamp'
    end
  end
  inherited tblDetails: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblsaleslines'
      'WHERE SaleID = :ID')
    BeforeOpen = tblDetailsBeforeOpen
    BeforeInsert = tblDetailsBeforeInsert
    AfterScroll = tblDetailsAfterScroll
    Left = 38
    Top = 330
    object tblDetailsSeqNo: TIntegerField
      DisplayLabel = 'No'
      DisplayWidth = 6
      FieldName = 'SeqNo'
      Origin = 'tblsaleslines.SeqNo'
    end
    object tblDetailsProductName: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 17
      FieldName = 'ProductName'
      Origin = 'tblsaleslines.ProductName'
      Size = 60
    end
    object tblDetailsUnitofMeasureSaleLines: TWideStringField
      DisplayLabel = 'Units'
      DisplayWidth = 10
      FieldName = 'UnitofMeasureSaleLines'
      Origin = 'tblsaleslines.UnitofMeasureSaleLines'
      Size = 255
    end
    object tblDetailsUnitofMeasureQtySold: TFloatField
      DisplayLabel = 'Ordered'
      DisplayWidth = 6
      FieldName = 'UnitofMeasureQtySold'
      Origin = 'tblsaleslines.UnitofMeasureQtySold'
      OnChange = tblDetailsUnitofMeasureQtySoldChange
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblDetailsUnitofMeasureShipped: TFloatField
      DisplayLabel = 'Shipped'
      DisplayWidth = 6
      FieldName = 'UnitofMeasureShipped'
      Origin = 'tblsaleslines.UnitofMeasureShipped'
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblDetailsPQA: TWideStringField
      DisplayLabel = 'Allocation'
      DisplayWidth = 1
      FieldKind = fkCalculated
      FieldName = 'PQA'
      Size = 100
      Calculated = True
    end
    object tblDetailsUnitofMeasureBackorder: TFloatField
      DisplayLabel = 'BO'
      DisplayWidth = 6
      FieldName = 'UnitofMeasureBackorder'
      Origin = 'tblsaleslines.UnitofMeasureBackorder'
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblDetailsAttrib1Sale: TFloatField
      DisplayLabel = 'Metres ?'
      DisplayWidth = 6
      FieldName = 'Attrib1Sale'
      Origin = 'tblsaleslines.Attrib1Sale'
    end
    object tblDetailsReferenceNo: TWideStringField
      DisplayLabel = 'Reference No'
      DisplayWidth = 20
      FieldName = 'ReferenceNo'
      Size = 255
    end
    object tblDetailsAttrib2Sale: TFloatField
      DisplayLabel = 'Weight'
      DisplayWidth = 6
      FieldName = 'Attrib2Sale'
      Origin = 'tblsaleslines.Attrib2Sale'
    end
    object tblDetailsAttrib1SaleRate: TFloatField
      DisplayLabel = 'Metres ? Rate'
      DisplayWidth = 10
      FieldName = 'Attrib1SaleRate'
      Origin = 'tblsaleslines.Attrib1SaleRate'
      currency = True
    end
    object tblDetailsSpecDescription: TWideStringField
      DisplayLabel = 'Specifications'
      DisplayWidth = 17
      FieldName = 'SpecDescription'
      Origin = 'tblsaleslines.SpecDescription'
      Size = 255
    end
    object tblDetailsSpecValue: TFloatField
      DisplayLabel = 'Spec Qty'
      DisplayWidth = 10
      FieldName = 'SpecValue'
      Origin = 'tblsaleslines.SpecValue'
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblDetailsProduct_Description: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 20
      FieldName = 'Product_Description'
      Origin = 'tblsaleslines.Product_Description'
      Size = 255
    end
    object tblDetailsPartBarcode: TWideStringField
      DisplayLabel = 'Barcode'
      DisplayWidth = 20
      FieldName = 'PartBarcode'
      Origin = 'tblsaleslines.PartBarcode'
      Size = 255
    end
    object tblDetailsProduct_Description_Memo: TWideMemoField
      DisplayLabel = 'Product Description Memo'
      DisplayWidth = 10
      FieldName = 'Product_Description_Memo'
      Origin = 'tblsaleslines.Product_Description_Memo'
      BlobType = ftWideMemo
    end
    object tblDetailsCostCentreName: TWideStringField
      DisplayLabel = 'Cost Centre'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'CostCentreName'
      LookupDataSet = qryCostCentre
      LookupKeyFields = 'CostCentreID'
      LookupResultField = 'CostCentreName'
      KeyFields = 'CostCentreId'
      Size = 255
      Lookup = True
    end
    object tblDetailsLineCostInc: TFloatField
      DisplayLabel = 'Cost (Inc)'
      DisplayWidth = 10
      FieldName = 'LineCostInc'
      Origin = 'tblsaleslines.LineCostInc'
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object tblDetailsLinePriceInc: TFloatField
      DisplayLabel = 'Price (Inc)'
      DisplayWidth = 10
      FieldName = 'LinePriceInc'
      Origin = 'tblsaleslines.LinePriceInc'
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '$0.00###'
      EditFormat = '$0.00###'
    end
    object tblDetailsDiscounts: TFloatField
      DisplayLabel = 'Discount ($)'
      DisplayWidth = 10
      FieldName = 'Discounts'
      Origin = 'tblsaleslines.Discounts'
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '$#0.00#'
      EditFormat = '$#0.00#'
      currency = True
    end
    object tblDetailsForeignCurrencyLinePrice: TFloatField
      DisplayLabel = 'Foreign Amount'
      DisplayWidth = 10
      FieldName = 'ForeignCurrencyLinePrice'
      Origin = 'tblsaleslines.ForeignCurrencyLinePrice'
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '0.00###'
      EditFormat = '0.00###'
    end
    object tblDetailsCalcProfit: TCurrencyField
      DisplayLabel = 'Profit (Inc)'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'CalcProfit'
      Calculated = True
    end
    object tblDetailsCalcProfitPercent: TFloatField
      DisplayLabel = '% Profit (Inc)'
      DisplayWidth = 7
      FieldKind = fkCalculated
      FieldName = 'CalcProfitPercent'
      DisplayFormat = '0.0%'
      Calculated = True
    end
    object tblDetailsCalcGrossProfitPercentInc: TFloatField
      DisplayLabel = 'Gross % (based on Avg Cost)'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'CalcGrossProfitPercentInc'
      DisplayFormat = '0.0#%'
      Calculated = True
    end
    object tblDetailsLatestCostPriceInc: TFloatField
      DisplayLabel = 'Latest Cost (Inc)'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'LatestCostPriceInc'
      currency = True
      Calculated = True
    end
    object tblDetailsLineTaxCode: TWideStringField
      DisplayLabel = 'Code'
      DisplayWidth = 15
      FieldName = 'LineTaxCode'
      Origin = 'tblsaleslines.LineTaxCode'
      Size = 15
    end
    object tblDetailsLineTax: TFloatField
      DisplayLabel = 'Tax (Dbl Click)'
      DisplayWidth = 10
      FieldName = 'LineTax'
      Origin = 'tblsaleslines.LineTax'
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '$#0.00###'
      EditFormat = '$#0.00###'
      currency = True
    end
    object tblDetailsTotalLineAmountInc: TFloatField
      DisplayLabel = 'Amount (Inc)'
      DisplayWidth = 14
      FieldName = 'TotalLineAmountInc'
      Origin = 'tblsaleslines.TotalLineAmountInc'
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object tblDetailsSupplier: TWideStringField
      DisplayWidth = 20
      FieldName = 'Supplier'
      Origin = 'tblsaleslines.Supplier'
      Size = 255
    end
    object tblDetailsSupplierContact: TWideStringField
      DisplayLabel = 'Supplier Contact'
      DisplayWidth = 20
      FieldName = 'SupplierContact'
      Origin = 'tblsaleslines.SupplierContact'
      Size = 255
    end
    object tblDetailsSalesLinesCustField1: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'SalesLinesCustField1'
      Origin = 'tblsaleslines.SalesLinesCustField1'
      Size = 255
    end
    object tblDetailsSalesLinesCustField2: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'SalesLinesCustField2'
      Origin = 'tblsaleslines.SalesLinesCustField2'
      Size = 255
    end
    object tblDetailsSalesLinesCustField3: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'SalesLinesCustField3'
      Origin = 'tblsaleslines.SalesLinesCustField3'
      Size = 255
    end
    object tblDetailsSalesLinesCustField4: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'SalesLinesCustField4'
      Origin = 'tblsaleslines.SalesLinesCustField4'
      Size = 255
    end
    object tblDetailsSalesLinesCustField5: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'SalesLinesCustField5'
      Origin = 'tblsaleslines.SalesLinesCustField5'
      Size = 255
    end
    object tblDetailsSalesLinesCustField6: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'SalesLinesCustField6'
      Origin = 'tblsaleslines.SalesLinesCustField6'
      Size = 255
    end
    object tblDetailsSalesLinesCustField7: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'SalesLinesCustField7'
      Origin = 'tblsaleslines.SalesLinesCustField7'
      Size = 255
    end
    object tblDetailsSalesLinesCustField8: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'SalesLinesCustField8'
      Origin = 'tblsaleslines.SalesLinesCustField8'
      Size = 255
    end
    object tblDetailsSalesLinesCustField9: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'SalesLinesCustField9'
      Origin = 'tblsaleslines.SalesLinesCustField9'
      Size = 255
    end
    object tblDetailsSalesLinesCustField10: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'SalesLinesCustField10'
      Origin = 'tblsaleslines.SalesLinesCustField10'
      Size = 255
    end
    object tblDetailsMemoLine: TWideMemoField
      DisplayWidth = 10
      FieldName = 'MemoLine'
      Origin = 'tblsaleslines.MemoLine'
      BlobType = ftWideMemo
    end
    object tblDetailsShipDate: TDateTimeField
      DisplayLabel = 'Ship Date'
      DisplayWidth = 18
      FieldName = 'ShipDate'
      Origin = 'tblsaleslines.ShipDate'
    end
    object tblDetailsBaseLineno: TIntegerField
      DisplayWidth = 10
      FieldName = 'BaseLineno'
      Origin = 'tblsaleslines.BaseLineno'
    end
    object tblDetailsShipContainerName: TWideStringField
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'ShipContainerName'
      LookupDataSet = qryShipContainerSaleLookup
      LookupKeyFields = 'SaleLineID'
      LookupResultField = 'ContainerName'
      KeyFields = 'SaleLineID'
      ReadOnly = True
      Size = 255
      Lookup = True
    end
    object tblDetailsShipContainerETA: TDateField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'ShipContainerETA'
      LookupDataSet = qryShipContainerSaleLookup
      LookupKeyFields = 'SaleLineID'
      LookupResultField = 'ETA'
      KeyFields = 'SaleLineID'
      ReadOnly = True
      Lookup = True
    end
    object tblDetailsTimecostused: TWideStringField
      DisplayWidth = 1
      FieldName = 'Timecostused'
      Origin = 'tblsaleslines.Timecostused'
      FixedChar = True
      Size = 1
    end
    object tblDetailsProfitbasedLatestCost: TFloatField
      DisplayLabel = 'GP (based on Latest Cost)'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'ProfitbasedLatestCost'
      Calculated = True
    end
    object tblDetailsProfitbasedLatestCostPercent: TFloatField
      DisplayLabel = 'GP% (based on Latest Cost)'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'ProfitbasedLatestCostPercent'
      Calculated = True
    end
    object tblDetailsProfitbasedLatestCostInc: TFloatField
      DisplayLabel = 'GP(Ex) (based on Latest Cost)'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'ProfitbasedLatestCostInc'
      Calculated = True
    end
    object tblDetailsProfitbasedLatestCostPercentInc: TFloatField
      DisplayLabel = 'GP(Inc)% (based on Latest Cost)'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'ProfitbasedLatestCostPercentInc'
      Calculated = True
    end
    object tblDetailsGrossProfitbasedLatestCostPercentInc: TFloatField
      DisplayLabel = 'GP% (based on Latest Cost)'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'GrossProfitbasedLatestCostPercentInc'
      Calculated = True
    end
    object tblDetailsUOM_Height: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'UOM_Height'
      Calculated = True
    end
    object tblDetailsUOM_Width: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'UOM_Width'
      Calculated = True
    end
    object tblDetailsUOM_Length: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'UOM_Length'
      Calculated = True
    end
    object tblDetailsUOM_Weight: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'UOM_Weight'
      Calculated = True
    end
    object tblDetailsTotalUOM_WeightSold: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TotalUOM_WeightSold'
      Calculated = True
    end
    object tblDetailsTotalUOM_WeightShipped: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TotalUOM_WeightShipped'
      Calculated = True
    end
    object tblDetailsTotalUOM_WeightBO: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TotalUOM_WeightBO'
      Calculated = True
    end
    object tblDetailsTotalUOM_LengthSold: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TotalUOM_LengthSold'
      Calculated = True
    end
    object tblDetailsTotalUOM_LengthShipped: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TotalUOM_LengthShipped'
      Calculated = True
    end
    object tblDetailsTotalUOM_LengthBO: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TotalUOM_LengthBO'
      Calculated = True
    end
    object tblDetailsUOM_Volume: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'UOM_Volume'
      Calculated = True
    end
    object tblDetailsUOM_ShippedVolume: TFloatField
      DisplayLabel = 'Volume of Shipped'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'UOM_ShippedVolume'
      Calculated = True
    end
    object tblDetailsUOM_Soldvolume: TFloatField
      DisplayLabel = 'Volume of Sold'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'UOM_Soldvolume'
      Calculated = True
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
    object tblDetailsMatrixDesc: TWideMemoField
      DisplayLabel = 'Matrix Details'
      DisplayWidth = 10
      FieldName = 'MatrixDesc'
      Origin = 'tblsaleslines.MatrixDesc'
      BlobType = ftWideMemo
    end
    object tblDetailsMatrixPrice: TFloatField
      DisplayLabel = 'Matrix Price'
      DisplayWidth = 10
      FieldName = 'MatrixPrice'
      Origin = 'tblsaleslines.MatrixPrice'
      currency = True
    end
    object tblDetailsFormulaQtySoldValue1: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue1'
      Origin = 'tblsaleslines.FormulaQtySoldValue1'
    end
    object tblDetailsFormulaQtySoldValue2: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue2'
      Origin = 'tblsaleslines.FormulaQtySoldValue2'
    end
    object tblDetailsFormulaQtySoldValue3: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue3'
      Origin = 'tblsaleslines.FormulaQtySoldValue3'
    end
    object tblDetailsFormulaQtySoldValue4: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue4'
      Origin = 'tblsaleslines.FormulaQtySoldValue4'
    end
    object tblDetailsFormulaQtySoldValue5: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue5'
      Origin = 'tblsaleslines.FormulaQtySoldValue5'
    end
    object tblDetailsFormulaQtyShippedValue1: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue1'
      Origin = 'tblsaleslines.FormulaQtyShippedValue1'
    end
    object tblDetailsFormulaQtyShippedValue2: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue2'
      Origin = 'tblsaleslines.FormulaQtyShippedValue2'
    end
    object tblDetailsFormulaQtyShippedValue3: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue3'
      Origin = 'tblsaleslines.FormulaQtyShippedValue3'
    end
    object tblDetailsFormulaQtyShippedValue4: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue4'
      Origin = 'tblsaleslines.FormulaQtyShippedValue4'
    end
    object tblDetailsFormulaQtyShippedValue5: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue5'
      Origin = 'tblsaleslines.FormulaQtyShippedValue5'
    end
    object tblDetailsFormulaQtySoldValue: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue'
      Origin = 'tblsaleslines.FormulaQtySoldValue'
    end
    object tblDetailsFormulaQtyShippedValue: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue'
      Origin = 'tblsaleslines.FormulaQtyShippedValue'
    end
    object tblDetailsAttrib1SaleEst: TFloatField
      DisplayLabel = 'Est Metres ?'
      DisplayWidth = 10
      FieldName = 'Attrib1SaleEst'
      Origin = 'tblsaleslines.Attrib1SaleEst'
    end
    object tblDetailsAttrib2SaleEst: TFloatField
      DisplayLabel = 'Est Weight'
      DisplayWidth = 10
      FieldName = 'Attrib2SaleEst'
      Origin = 'tblsaleslines.Attrib2SaleEst'
    end
    object tblDetailsISContainer: TWideStringField
      DisplayWidth = 1
      FieldName = 'ISContainer'
      Origin = 'tblsaleslines.ISContainer'
      FixedChar = True
      Size = 1
    end
    object tblDetailsIsPallet: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsPallet'
      Origin = 'tblsaleslines.IsPallet'
      FixedChar = True
      Size = 1
    end
    object tblDetailsArea: TWideStringField
      DisplayWidth = 20
      FieldName = 'Area'
      Origin = 'tblsaleslines.Area'
      Size = 50
    end
    object tblDetailsAreaQty: TFloatField
      DisplayLabel = 'Area To Cover'
      DisplayWidth = 10
      FieldName = 'AreaQty'
      Origin = 'tblsaleslines.AreaQty'
    end
    object tblDetailsCustomerEquipmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'CustomerEquipmentID'
      Origin = 'tblsaleslines.CustomerEquipmentID'
    end
    object tblDetailsEquipment: TWideStringField
      DisplayWidth = 10
      FieldName = 'Equipment'
      Origin = 'tblsaleslines.Equipment'
      Size = 100
    end
    object tblDetailsLinesOrder: TIntegerField
      DisplayLabel = 'Order by'
      DisplayWidth = 10
      FieldName = 'LinesOrder'
      Origin = 'tblsaleslines.LinesOrder'
    end
    object tblDetailsRequiresAssembly: TWideStringField
      DisplayLabel = 'Requires Assembly?'
      DisplayWidth = 1
      FieldName = 'RequiresAssembly'
      Origin = 'tblsaleslines.RequiresAssembly'
      FixedChar = True
      Size = 1
    end
    object tblDetailsProductBarcode: TWideStringField
      DisplayWidth = 255
      FieldName = 'ProductBarcode'
      Origin = 'tblsaleslines.ProductBarcode'
      Size = 255
    end
    object tblDetailsUOMLineCost: TFloatField
      DisplayLabel = 'UOM Cost (Ex)'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'UOMLineCost'
      ReadOnly = True
      DisplayFormat = '$0.00###'
      Calculated = True
    end
    object tblDetailsUOMLineCostInc: TFloatField
      DisplayLabel = 'UOM Cost (Inc)'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'UOMLineCostInc'
      ReadOnly = True
      DisplayFormat = '$0.00###'
      Calculated = True
    end
    object tblDetailsUOMLinePrice: TFloatField
      DisplayLabel = 'UOM Price (Ex)'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'UOMLinePrice'
      ReadOnly = True
      DisplayFormat = '$0.00###'
      Calculated = True
    end
    object tblDetailsUOMLinePriceInc: TFloatField
      DisplayLabel = 'UOM Price (Inc)'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'UOMLinePriceInc'
      ReadOnly = True
      DisplayFormat = '$0.00###'
      Calculated = True
    end
    object tblDetailsOriginalQtyOrdered: TFloatField
      DisplayLabel = 'Orig Qty'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'OriginalQtyOrdered'
      Calculated = True
    end
    object tblDetailsDetailsCust1Total: TFloatField
      DisplayWidth = 10
      FieldName = 'DetailsCust1Total'
      Origin = 'tblsaleslines.DetailsCust1Total'
    end
    object tblDetailsStandardCost: TFloatField
      DisplayLabel = 'Standard Cost'
      DisplayWidth = 10
      FieldName = 'StandardCost'
      Origin = 'tblsaleslines.StandardCost'
    end
    object tblDetailsOrgProductPrice: TFloatField
      DisplayLabel = 'Org Product Price (Ex)'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'OrgProductPrice'
      currency = True
      Calculated = True
    end
    object tblDetailsOrgProductPriceInc: TFloatField
      DisplayLabel = 'Org Product Price (Inc)'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'OrgProductPriceInc'
      currency = True
      Calculated = True
    end
    object tblDetailsPurchaseCost: TFloatField
      DisplayLabel = 'SMO To Cost'
      DisplayWidth = 10
      FieldName = 'PurchaseCost'
      Origin = 'tblsaleslines.PurchaseCost'
      currency = True
    end
    object tblDetailsISVoucher: TWideStringField
      DisplayWidth = 1
      FieldName = 'ISVoucher'
      FixedChar = True
      Size = 1
    end
    object tblDetailsProductPrintName: TWideStringField
      DisplayWidth = 20
      FieldName = 'ProductPrintName'
      Size = 255
    end
    object tblDetailsPackWeightField1: TFloatField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'PackWeightField1'
      LookupDataSet = QrySalesLinePackWeightLinesSum
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'AttribValue1'
      KeyFields = 'SaleLineID'
      Lookup = True
    end
    object tblDetailsPackWeightfield2: TFloatField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'PackWeightfield2'
      LookupDataSet = QrySalesLinePackWeightLinesSum
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'AttribValue2'
      KeyFields = 'SaleLineID'
      Lookup = True
    end
    object tblDetailsPackCount: TFloatField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'PackCount'
      LookupDataSet = QrySalesLinePackWeightLinesSum
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'Packcount'
      KeyFields = 'SaleLineID'
      Lookup = True
    end
    object tblDetailsBOMComments: TWideStringField
      DisplayLabel = 'BOM Partial Build Comments'
      DisplayWidth = 20
      FieldName = 'BOMComments'
      ReadOnly = True
      Size = 255
    end
    object tblDetailsRelatedProductProdLine: TIntegerField
      DisplayWidth = 10
      FieldName = 'RelatedProductProdLine'
    end
    object tblDetailsRelatedProductPatternName: TWideStringField
      DisplayWidth = 255
      FieldName = 'RelatedProductPatternName'
      Size = 255
    end
    object tblDetailsRelatedProductFormulaDescription: TWideStringField
      DisplayWidth = 255
      FieldName = 'RelatedProductFormulaDescription'
      Size = 255
    end
    object tblDetailsETDDate: TDateTimeField
      DisplayLabel = 'ETD Date'
      DisplayWidth = 18
      FieldName = 'ETDDate'
    end
    object tblDetailsUOMQtyInStock: TFloatField
      DisplayLabel = 'Qty In Stock'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'UOMQtyInStock'
      Calculated = True
    end
    object tblDetailsUOMQtyAvailable: TFloatField
      DisplayLabel = 'Qty Available'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'UOMQtyAvailable'
      Calculated = True
    end
    object tblDetailsSortId: TIntegerField
      DisplayWidth = 10
      FieldName = 'SortId'
      Origin = 'tblsaleslines.SortId'
      Visible = False
    end
    object tblDetailsLineCost: TFloatField
      DisplayLabel = 'Cost (Ex)'
      DisplayWidth = 10
      FieldName = 'LineCost'
      Origin = 'tblsaleslines.LineCost'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '$0.00###'
      EditFormat = '$0.00###'
    end
    object tblDetailsLinePrice: TFloatField
      DisplayLabel = 'Price (Ex)'
      DisplayWidth = 10
      FieldName = 'LinePrice'
      Origin = 'tblsaleslines.LinePrice'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '$0.00###'
      EditFormat = '$0.00###'
    end
    object tblDetailsDiscountedPriceInc: TFloatField
      DisplayLabel = 'Disc Price (Inc)'
      DisplayWidth = 10
      FieldName = 'DiscountedPriceInc'
      Origin = 'tblsaleslines.DiscountedPriceInc'
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '$0.00###'
      EditFormat = '$0.00###'
    end
    object tblDetailsDiscountedPrice: TFloatField
      DisplayLabel = 'Disc Price (Ex)'
      DisplayWidth = 10
      FieldName = 'DiscountedPrice'
      Origin = 'tblsaleslines.DiscountedPrice'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '$0.00###'
      EditFormat = '$0.00###'
    end
    object tblDetailsTotalDiscountedPriceInc: TFloatField
      DisplayLabel = 'Total Disc Price (Inc)'
      DisplayWidth = 10
      FieldName = 'TotalDiscountedPriceInc'
      Origin = 'tblsaleslines.TotalDiscountedPriceInc'
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '$0.00###'
      EditFormat = '$0.00###'
    end
    object tblDetailsTotalDiscountedPrice: TFloatField
      DisplayLabel = 'Total Disc Price (Ex)'
      DisplayWidth = 10
      FieldName = 'TotalDiscountedPrice'
      Origin = 'tblsaleslines.TotalDiscountedPrice'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '$0.00###'
      EditFormat = '$0.00###'
    end
    object tblDetailsLatestCostPrice: TFloatField
      DisplayLabel = 'Latest Cost (Inc)'
      FieldKind = fkCalculated
      FieldName = 'LatestCostPrice'
      Visible = False
      currency = True
      Calculated = True
    end
    object tblDetailsTotalLineAmount: TFloatField
      DisplayLabel = 'Amount (Ex)'
      DisplayWidth = 10
      FieldName = 'TotalLineAmount'
      Origin = 'tblsaleslines.TotalLineAmount'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object tblDetailsQtySold: TFloatField
      DisplayLabel = 'Ordered'
      DisplayWidth = 10
      FieldName = 'QtySold'
      Origin = 'tblsaleslines.QtySold'
      Visible = False
    end
    object tblDetailsShipped: TFloatField
      DisplayWidth = 10
      FieldName = 'Shipped'
      Origin = 'tblsaleslines.Shipped'
      Visible = False
      OnChange = tblDetailsShippedChange
    end
    object tblDetailsBackOrder: TFloatField
      DisplayLabel = 'BO'
      DisplayWidth = 10
      FieldName = 'BackOrder'
      Origin = 'tblsaleslines.BackOrder'
      Visible = False
    end
    object tblDetailsOrgLinePrice: TFloatField
      FieldName = 'OrgLinePrice'
      Origin = 'tblsaleslines.OrgLinePrice'
      Visible = False
      DisplayFormat = '$#0.00#'
      EditFormat = '$#0.00#'
    end
    object tblDetailsSaleID: TIntegerField
      DefaultExpression = '0'
      DisplayWidth = 10
      FieldName = 'SaleID'
      Origin = 'tblsaleslines.SaleID'
      Visible = False
    end
    object tblDetailsSaleLineID: TAutoIncField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'SaleLineID'
      Origin = 'tblsaleslines.SaleLineID'
      ReadOnly = True
      Visible = False
    end
    object tblDetailsGlobalRef: TWideStringField
      DisplayLabel = 'Global Ref'
      DisplayWidth = 20
      FieldName = 'GlobalRef'
      Origin = 'tblsaleslines.GlobalRef'
      Visible = False
      Size = 255
    end
    object tblDetailsProductGroup: TWideStringField
      DisplayLabel = 'Product Group'
      DisplayWidth = 20
      FieldName = 'ProductGroup'
      Origin = 'tblsaleslines.ProductGroup'
      Visible = False
      Size = 255
    end
    object tblDetailsLineWholesalePrice: TFloatField
      DisplayLabel = 'Line Wholesale Price'
      DisplayWidth = 10
      FieldName = 'LineWholesalePrice'
      Origin = 'tblsaleslines.LineWholesalePrice'
      Visible = False
      currency = True
    end
    object tblDetailsLineTaxRate: TFloatField
      DisplayLabel = 'Line Tax Rate'
      DisplayWidth = 10
      FieldName = 'LineTaxRate'
      Origin = 'tblsaleslines.LineTaxRate'
      Visible = False
    end
    object tblDetailsInvoiced: TWideStringField
      DisplayWidth = 1
      FieldName = 'Invoiced'
      Origin = 'tblsaleslines.Invoiced'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsMarkup: TFloatField
      DisplayWidth = 10
      FieldName = 'Markup'
      Origin = 'tblsaleslines.Markup'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '$#0.00#'
      EditFormat = '$#0.00#'
      currency = True
    end
    object tbldetailsMargin: TFloatField
      DisplayWidth = 10
      FieldName = 'Margin'
      Origin = 'tblsaleslines.Margin'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '$#0.00#'
      EditFormat = '$#0.00#'
      currency = True
    end
    object tblDetailsMarkupPercent: TFloatField
      DisplayLabel = 'Markup %'
      FieldName = 'MarkupPercent'
      Origin = 'tblsaleslines.MarkupPercent'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '#0.0%'
    end
    object tbldetailsMarginPercent: TFloatField
      DisplayLabel = 'Margin %'
      FieldName = 'MarginPercent'
      Origin = 'tblsaleslines.MarginPercent'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '#0.0%'
    end
    object tblDetailsDiscountPercent: TFloatField
      DisplayLabel = 'Discount Percent'
      FieldName = 'DiscountPercent'
      Origin = 'tblsaleslines.DiscountPercent'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '#0.0%'
    end
    object tblDetailsEditedFlag: TWideStringField
      DisplayLabel = 'Edited Flag'
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Origin = 'tblsaleslines.EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsDeleted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Origin = 'tblsaleslines.Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsProductID: TIntegerField
      DisplayLabel = 'Product ID'
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'tblsaleslines.ProductID'
      Visible = False
    end
    object tblDetailsPartType: TWideStringField
      DisplayLabel = 'Part Type'
      DisplayWidth = 13
      FieldName = 'PartType'
      Origin = 'tblsaleslines.PARTTYPE'
      Visible = False
      Size = 13
    end
    object tblDetailsRefundQty: TFloatField
      DisplayLabel = 'Refund Qty'
      DisplayWidth = 10
      FieldName = 'RefundQty'
      Origin = 'tblsaleslines.RefundQty'
      Visible = False
    end
    object tblDetailsLaybyID: TWideStringField
      DisplayLabel = 'Layby ID'
      DisplayWidth = 14
      FieldName = 'LaybyID'
      Origin = 'tblsaleslines.LaybyID'
      Visible = False
      Size = 14
    end
    object tblDetailsIncomeAccnt: TWideStringField
      DisplayLabel = 'Income Accnt'
      DisplayWidth = 50
      FieldName = 'IncomeAccnt'
      Origin = 'tblsaleslines.INCOMEACCNT'
      Visible = False
      Size = 50
    end
    object tblDetailsAssetAccnt: TWideStringField
      DisplayLabel = 'Asset Accnt'
      DisplayWidth = 50
      FieldName = 'AssetAccnt'
      Origin = 'tblsaleslines.ASSETACCNT'
      Visible = False
      Size = 50
    end
    object tblDetailsCogsAccnt: TWideStringField
      DisplayLabel = 'Cogs Accnt'
      DisplayWidth = 50
      FieldName = 'CogsAccnt'
      Origin = 'tblsaleslines.COGSACCNT'
      Visible = False
      Size = 50
    end
    object tblDetailsCalcPriceInc: TCurrencyField
      DisplayLabel = 'Calc Price (Inc)'
      FieldKind = fkCalculated
      FieldName = 'CalcPriceInc'
      Visible = False
      Calculated = True
    end
    object tblDetailsCalcTotalInc: TCurrencyField
      DisplayLabel = 'Calc Total (Inc)'
      FieldKind = fkCalculated
      FieldName = 'CalcTotalInc'
      Visible = False
      Calculated = True
    end
    object tblDetailsCalcTotalEx: TCurrencyField
      DisplayLabel = 'Calc Total (Ex)'
      FieldKind = fkCalculated
      FieldName = 'CalcTotalEx'
      Visible = False
      Calculated = True
    end
    object tblDetailsCalcTax: TCurrencyField
      DisplayLabel = 'Calc Tax'
      FieldKind = fkCalculated
      FieldName = 'CalcTax'
      Visible = False
      Calculated = True
    end
    object tblDetailsCalcBackOrder: TFloatField
      DisplayLabel = 'Calc Back Order'
      FieldKind = fkCalculated
      FieldName = 'CalcBackOrder'
      Visible = False
      DisplayFormat = '$#0.00#'
      EditFormat = '$#0.00#'
      Calculated = True
    end
    object tblDetailsCalcLinePriceEx: TCurrencyField
      DisplayLabel = 'Calc Line Price (Ex)'
      FieldKind = fkCalculated
      FieldName = 'CalcLinePriceEx'
      Visible = False
      DisplayFormat = '$0.00##'
      Calculated = True
    end
    object tblDetailsCalcTotalIncB4Discount: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'CalcTotalIncB4Discount'
      Visible = False
      DisplayFormat = '$#0.00#'
      EditFormat = '$#0.00#'
      Calculated = True
    end
    object tblDetailsLastLineID: TIntegerField
      FieldName = 'LastLineID'
      Origin = 'tblsaleslines.LastLineID'
      Visible = False
    end
    object tblDetailsUnitofMeasureMultiplier: TFloatField
      FieldName = 'UnitofMeasureMultiplier'
      Origin = 'tblsaleslines.UnitofMeasureMultiplier'
      Visible = False
    end
    object tblDetailsForeignExchangeSellRate: TFloatField
      DisplayLabel = 'Foreign Exchange Sell Rate'
      FieldName = 'ForeignExchangeSellRate'
      Origin = 'tblsaleslines.ForeignExchangeSellRate'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblDetailsForeignTotalLineAmount: TFloatField
      FieldName = 'ForeignTotalLineAmount'
      Origin = 'tblsaleslines.ForeignTotalLineAmount'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblDetailsCalcProfitEx: TCurrencyField
      DisplayLabel = 'Profit (Ex)'
      FieldKind = fkCalculated
      FieldName = 'CalcProfitEx'
      Visible = False
      Calculated = True
    end
    object tblDetailsCalcProfitPercentEx: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'CalcProfitPercentEx'
      Visible = False
      DisplayFormat = '0.0%'
      Calculated = True
    end
    object tblDetailsSearchFilter: TWideStringField
      FieldName = 'SearchFilter'
      Origin = 'tblsaleslines.SearchFilter'
      Visible = False
      Size = 64
    end
    object tblDetailsSearchFilterCopy: TWideStringField
      FieldName = 'SearchFilterCopy'
      Origin = 'tblsaleslines.SearchFilterCopy'
      Visible = False
      Size = 64
    end
    object tblDetailsIsRelatedProduct: TWideStringField
      FieldName = 'IsRelatedProduct'
      Origin = 'tblsaleslines.IsRelatedProduct'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsRelatedParentProductID: TIntegerField
      FieldName = 'RelatedParentProductID'
      Origin = 'tblsaleslines.RelatedParentProductID'
      Visible = False
    end
    object tblDetailsCostCentreId: TIntegerField
      FieldName = 'CostCentreId'
      Origin = 'tblsaleslines.CostCentreId'
      Visible = False
    end
    object tblDetailsUseHedging: TWideStringField
      FieldName = 'UseHedging'
      Origin = 'tblsaleslines.UseHedging'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsPartSpecID: TIntegerField
      FieldName = 'PartSpecID'
      Origin = 'tblsaleslines.PartSpecID'
      Visible = False
    end
    object tblDetailsCreationDate: TDateTimeField
      FieldName = 'CreationDate'
      Origin = 'tblsaleslines.CreationDate'
      Visible = False
    end
    object tblDetailsSoldSerials: TWideMemoField
      FieldName = 'SoldSerials'
      Origin = 'tblsaleslines.SoldSerials'
      Visible = False
      BlobType = ftWideMemo
    end
    object tblDetailsLineNotes: TWideMemoField
      FieldName = 'LineNotes'
      Origin = 'tblsaleslines.LineNotes'
      Visible = False
      BlobType = ftWideMemo
    end
    object tblDetailsCustomData: TWideMemoField
      FieldName = 'CustomData'
      Origin = 'tblsaleslines.CustomData'
      Visible = False
      BlobType = ftWideMemo
    end
    object tblDetailsUnitOfMeasureID: TIntegerField
      FieldName = 'UnitOfMeasureID'
      Origin = 'tblsaleslines.UnitOfMeasureID'
      Visible = False
    end
    object tblDetailsRelatedParentLineRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'RelatedParentLineRef'
      Origin = 'tblsaleslines.RelatedParentLineRef'
      Visible = False
      Size = 255
    end
    object tblDetailsRelatedProductQty: TFloatField
      FieldName = 'RelatedProductQty'
      Origin = 'tblsaleslines.RelatedProductQty'
      Visible = False
    end
    object tblDetailsIsFormulaRElatedProduct: TWideStringField
      FieldName = 'IsFormulaRElatedProduct'
      Origin = 'tblsaleslines.IsFormulaRElatedProduct'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsFormulaID: TIntegerField
      DisplayWidth = 10
      FieldName = 'FormulaID'
      Origin = 'tblsaleslines.FormulaID'
      Visible = False
    end
    object tblDetailsMatrixRef: TWideMemoField
      DisplayWidth = 10
      FieldName = 'MatrixRef'
      Origin = 'tblsaleslines.MatrixRef'
      Visible = False
      BlobType = ftWideMemo
    end
    object tblDetailsmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblsaleslines.msTimeStamp'
      Visible = False
    end
    object tblDetailsmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblsaleslines.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
    object tblDetailsProfitOnLanded: TFloatField
      DisplayLabel = 'Landed Profit (Ex)'
      FieldKind = fkCalculated
      FieldName = 'ProfitOnLanded'
      currency = True
      Calculated = True
    end
    object tblDetailsProfitOnLandedInc: TFloatField
      DisplayLabel = 'Landed Profit (Inc)'
      FieldKind = fkCalculated
      FieldName = 'ProfitOnLandedInc'
      currency = True
      Calculated = True
    end
    object tblDetailsProfitOnLandedPercent: TFloatField
      DisplayLabel = 'Landed Profit % (Ex)'
      FieldKind = fkCalculated
      FieldName = 'ProfitOnLandedPercent'
      DisplayFormat = '#0.0%'
      Calculated = True
    end
    object tblDetailsProfitOnLandedPercentInc: TFloatField
      DisplayLabel = 'Landed Profit % (Inc)'
      FieldKind = fkCalculated
      FieldName = 'ProfitOnLandedPercentInc'
      DisplayFormat = '#0.0%'
      Calculated = True
    end
    object tblDetailsSalesTaxBasedon: TWideStringField
      FieldName = 'SalesTaxBasedon'
      FixedChar = True
      Size = 2
    end
  end
  inherited cboClientLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      '####################################################'
      '### Keep In Format for Query Manipulation Object ###'
      '### Add Fields To Base (Sales) #####################'
      '####################################################'
      'SELECT'
      'CT.DefaultPostAccount AS DefaultPostAccount,'
      'CT.DefaultPostAccountID AS DefaultPostAccountID,'
      'C1.ClientID as ClientID,'
      'C1.Company as Company,'
      'C1.Street as Street,'
      'C1.Street2 as Street2,'
      'C1.Street3 as Street3,'
      'C1.Suburb as Suburb,'
      'C1.State as State,'
      'C1.Country as Country,'
      'C1.Postcode as Postcode,'
      'C1.BillStreet as BillStreet,'
      'C1.BillStreet2 as BillStreet2,'
      'C1.BillStreet3 as BillStreet3,'
      'C1.BillSuburb as BillSuburb,'
      'C1.BillState as BillState,'
      'C1.BillPostcode as BillPostcode,'
      'C1.BillCountry as BillCountry,'
      'C1.TERMS as TERMS,'
      'C1.TermsID as TermsID,'
      'C1.ShippingMethod as ShippingMethod,'
      'C1.ShippingID as ShippingID,'
      'C1.RepID as RepID,'
      'C1.TaxID as TaxID,'
      'C1.Phone as Phone,'
      'C1.FaxNumber as Fax,'
      'C1.Mobile as Mobile,'
      'C1.Email as Email,'
      'C1.AltPhone as AltPhone,'
      'IF(C1.IsJob = '#39'T'#39',C2.StopCredit,C1.StopCredit) AS StopCredits,'
      'C1.ForcePOOnInvoice as ForcePOOnInvoice,'
      'C1.UseInvBase as UseInvBase,'
      'C1.InvBaseNumber as InvBaseNumber, '
      'C1.WarrantyFinishDate, C1.IsJob'
      'FROM tblclients as C1'
      
        'LEFT JOIN tblClientType AS CT on C1.ClientTypeID = CT.ClientType' +
        'ID '
      'LEFT JOIN tblClients as C2 on C1.ParentClientID = C2.ClientID'
      'WHERE C1.Customer='#39'T'#39' AND char_length(C1.Company)>0'
      'AND C1.ClientID= :xClientID')
    OnCalcFields = cboClientLookupCalcFields
    Left = 353
    Top = 330
    ParamData = <
      item
        DataType = ftString
        Name = 'xClientID'
        Value = ''
      end>
    object cboClientLookupCompany: TWideStringField
      DisplayWidth = 70
      FieldName = 'Company'
      Origin = 'tblclients.Company'
      Size = 80
    end
    object cboClientLookupStopCreditImage: TIntegerField
      DisplayLabel = 'Stop Credit'
      DisplayWidth = 1
      FieldKind = fkCalculated
      FieldName = 'StopCreditImage'
      Calculated = True
    end
    object cboClientLookupClientID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientID'
      Origin = 'tblclients.ClientID'
      ReadOnly = True
      Visible = False
    end
    object cboClientLookupTERMS: TWideStringField
      FieldName = 'TERMS'
      Origin = 'tblclients.TERMS'
      Visible = False
      Size = 30
    end
    object cboClientLookupTermsID: TIntegerField
      FieldName = 'TermsID'
      Origin = 'tblclients.TermsID'
      Visible = False
    end
    object cboClientLookupShippingMethod: TWideStringField
      FieldName = 'ShippingMethod'
      Origin = 'tblclients.ShippingMethod'
      Visible = False
      Size = 30
    end
    object cboClientLookupShippingID: TIntegerField
      FieldName = 'ShippingID'
      Origin = 'tblclients.ShippingID'
      Visible = False
    end
    object cboClientLookupRepID: TIntegerField
      FieldName = 'RepID'
      Origin = 'tblclients.RepID'
      Visible = False
    end
    object cboClientLookupTaxID: TIntegerField
      FieldName = 'TaxID'
      Origin = 'tblclients.TaxID'
      Visible = False
    end
    object cboClientLookupForcePOOnInvoice: TWideStringField
      FieldName = 'ForcePOOnInvoice'
      Origin = 'tblclients.ForcePOOnInvoice'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboClientLookupStreet: TWideStringField
      FieldName = 'Street'
      Origin = 'tblclients.Street'
      FixedChar = True
      Size = 255
    end
    object cboClientLookupStreet2: TWideStringField
      FieldName = 'Street2'
      Origin = 'tblclients.Street2'
      FixedChar = True
      Size = 255
    end
    object cboClientLookupSuburb: TWideStringField
      FieldName = 'Suburb'
      Origin = 'tblclients.Suburb'
      FixedChar = True
      Size = 255
    end
    object cboClientLookupState: TWideStringField
      FieldName = 'State'
      Origin = 'tblclients.State'
      FixedChar = True
      Size = 255
    end
    object cboClientLookupCountry: TWideStringField
      FieldName = 'Country'
      Origin = 'tblclients.Country'
      FixedChar = True
      Size = 255
    end
    object cboClientLookupPostcode: TWideStringField
      FieldName = 'Postcode'
      Origin = 'tblclients.Postcode'
      FixedChar = True
      Size = 255
    end
    object cboClientLookupBillStreet: TWideStringField
      FieldName = 'BillStreet'
      Origin = 'tblclients.BillStreet'
      FixedChar = True
      Size = 255
    end
    object cboClientLookupBillStreet2: TWideStringField
      FieldName = 'BillStreet2'
      Origin = 'tblclients.BillStreet2'
      FixedChar = True
      Size = 255
    end
    object cboClientLookupBillSuburb: TWideStringField
      FieldName = 'BillSuburb'
      Origin = 'tblclients.BillSuburb'
      FixedChar = True
      Size = 255
    end
    object cboClientLookupBillState: TWideStringField
      FieldName = 'BillState'
      Origin = 'tblclients.BillState'
      FixedChar = True
      Size = 255
    end
    object cboClientLookupBillPostcode: TWideStringField
      FieldName = 'BillPostcode'
      Origin = 'tblclients.BillPostcode'
      FixedChar = True
      Size = 255
    end
    object cboClientLookupBillCountry: TWideStringField
      FieldName = 'BillCountry'
      Origin = 'tblclients.BillCountry'
      FixedChar = True
      Size = 255
    end
    object cboClientLookupUseInvBase: TWideStringField
      FieldName = 'UseInvBase'
      Origin = 'tblclients.UseInvBase'
      FixedChar = True
      Size = 1
    end
    object cboClientLookupInvBaseNumber: TIntegerField
      FieldName = 'InvBaseNumber'
      Origin = 'tblclients.InvBaseNumber'
    end
    object cboClientLookupPhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'tblclients.Phone'
    end
    object cboClientLookupFax: TWideStringField
      FieldName = 'Fax'
      Origin = 'tblclients.Fax'
    end
    object cboClientLookupAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Origin = 'tblclients.AltPhone'
    end
    object cboClientLookupDefaultPostAccount: TWideStringField
      FieldName = 'DefaultPostAccount'
      Origin = 'CT.DefaultPostAccount'
      Size = 255
    end
    object cboClientLookupDefaultPostAccountID: TIntegerField
      FieldName = 'DefaultPostAccountID'
      Origin = 'CT.DefaultPostAccountID'
    end
    object cboClientLookupWarrantyFinishDate: TDateTimeField
      FieldName = 'WarrantyFinishDate'
      Origin = 'tblclients.WarrantyFinishDate'
    end
    object cboClientLookupIsJob: TWideStringField
      FieldName = 'IsJob'
      Origin = 'tblclients.IsJob'
      FixedChar = True
      Size = 1
    end
    object cboClientLookupStreet3: TWideStringField
      FieldName = 'Street3'
      Origin = 'tblclients.Street3'
      Size = 255
    end
    object cboClientLookupBillStreet3: TWideStringField
      FieldName = 'BillStreet3'
      Origin = 'tblclients.BillStreet3'
      Size = 255
    end
    object cboClientLookupStopCredits: TWideStringField
      FieldName = 'StopCredits'
      Size = 1
    end
    object cboClientLookupMobile: TWideStringField
      FieldName = 'Mobile'
    end
    object cboClientLookupEmail: TWideStringField
      FieldName = 'Email'
      Size = 80
    end
  end
  inherited cboEmployeeLookup: TERPQuery
    Left = 132
    Top = 330
  end
  inherited cboClassQry: TERPQuery
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName,ClassPercent'
      'FROM tblClass '
      
        'WHERE (((tblClass.ClassName) Is Not Null) And ((tblClass.Active)' +
        '<>'#39'F'#39')) '
      'ORDER BY tblClass.ClassName; ')
    Left = 321
    Top = 330
  end
  inherited qryBaseForeignCurrency: TERPQuery
    Left = 479
    Top = 330
  end
  inherited qryClientLookup: TERPQuery
    SQL.Strings = (
      'SELECT'
      'CT.DefaultPostAccount AS DefaultPostAccount,'
      'CT.DefaultPostAccountID AS DefaultPostAccountID,'
      'C1.ClientID as ClientID,'
      'C1.Company as Company,'
      'C1.Street as Street,'
      'C1.Street2 as Street2,'
      'C1.Street3 as Street3,'
      'C1.Suburb as Suburb,'
      'C1.State as State,'
      'C1.Country as Country,'
      'C1.Postcode as Postcode,'
      'C1.BillStreet as BillStreet,'
      'C1.BillStreet2 as BillStreet2,'
      'C1.BillStreet3 as BillStreet3,'
      'C1.BillSuburb as BillSuburb,'
      'C1.BillState as BillState,'
      'C1.BillPostcode as BillPostcode,'
      'C1.BillCountry as BillCountry,'
      'C1.TERMS as TERMS,'
      'C1.TermsID as TermsID,'
      'C1.ShippingMethod as ShippingMethod,'
      'C1.ShippingID as ShippingID,'
      'C1.RepID as RepID,'
      'C1.TaxID as TaxID,'
      'C1.Phone as Phone,'
      'C1.FaxNumber as Fax,'
      'C1.AltPhone as AltPhone,'
      'IF(C1.IsJob = '#39'T'#39',C2.StopCredit,C1.StopCredit) AS StopCredits,'
      'C1.ForcePOOnInvoice as ForcePOOnInvoice,'
      'C1.UseInvBase as UseInvBase,'
      'C1.InvBaseNumber as InvBaseNumber, '
      'C1.WarrantyFinishDate, C1.IsJob'
      'FROM tblclients as C1'
      
        'LEFT JOIN tblClientType AS CT on C1.ClientTypeID = CT.ClientType' +
        'ID '
      'LEFT JOIN tblClients as C2 on C1.ParentClientID = C2.ClientID'
      'WHERE C1.Customer='#39'T'#39' AND char_length(C1.Company)>0'
      'AND C1.Active = '#39'T'#39' '
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (C1.Company LIKE Concat(:SearchValue,"' +
        '%")))'
      
        'or ((:SearchMode = 2) and (C1.Company LIKE Concat("%",:SearchVal' +
        'ue,"%"))))'
      'and IfNull(:SearchValue,"") <> ""')
    Left = 920
    Top = 330
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
    inherited qryClientLookupCompany: TWideStringField
      DisplayWidth = 35
    end
    inherited qryClientLookupClientId: TIntegerField
      Visible = False
    end
    object qryClientLookupDefaultPostAccount: TWideStringField
      FieldName = 'DefaultPostAccount'
      Visible = False
      Size = 255
    end
    object qryClientLookupDefaultPostAccountID: TIntegerField
      FieldName = 'DefaultPostAccountID'
      Visible = False
    end
    object qryClientLookupStreet: TWideStringField
      FieldName = 'Street'
      Visible = False
      Size = 255
    end
    object qryClientLookupStreet2: TWideStringField
      FieldName = 'Street2'
      Visible = False
      Size = 255
    end
    object qryClientLookupStreet3: TWideStringField
      FieldName = 'Street3'
      Visible = False
      Size = 255
    end
    object qryClientLookupSuburb: TWideStringField
      FieldName = 'Suburb'
      Visible = False
      Size = 255
    end
    object qryClientLookupState: TWideStringField
      FieldName = 'State'
      Visible = False
      Size = 255
    end
    object qryClientLookupCountry: TWideStringField
      FieldName = 'Country'
      Visible = False
      Size = 255
    end
    object qryClientLookupPostcode: TWideStringField
      FieldName = 'Postcode'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillStreet: TWideStringField
      FieldName = 'BillStreet'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillStreet2: TWideStringField
      FieldName = 'BillStreet2'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillStreet3: TWideStringField
      FieldName = 'BillStreet3'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillSuburb: TWideStringField
      FieldName = 'BillSuburb'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillState: TWideStringField
      FieldName = 'BillState'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillPostcode: TWideStringField
      FieldName = 'BillPostcode'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillCountry: TWideStringField
      FieldName = 'BillCountry'
      Visible = False
      Size = 255
    end
    object qryClientLookupTERMS: TWideStringField
      FieldName = 'TERMS'
      Visible = False
      Size = 30
    end
    object qryClientLookupTermsID: TIntegerField
      FieldName = 'TermsID'
      Visible = False
    end
    object qryClientLookupShippingMethod: TWideStringField
      FieldName = 'ShippingMethod'
      Visible = False
      Size = 30
    end
    object qryClientLookupShippingID: TIntegerField
      FieldName = 'ShippingID'
      Visible = False
    end
    object qryClientLookupRepID: TIntegerField
      FieldName = 'RepID'
      Visible = False
    end
    object qryClientLookupTaxID: TIntegerField
      FieldName = 'TaxID'
      Visible = False
    end
    object qryClientLookupPhone: TWideStringField
      FieldName = 'Phone'
      Visible = False
    end
    object qryClientLookupFax: TWideStringField
      FieldName = 'Fax'
      Visible = False
    end
    object qryClientLookupAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Visible = False
    end
    object qryClientLookupStopCredits: TWideStringField
      FieldName = 'StopCredits'
      Visible = False
      Size = 1
    end
    object qryClientLookupForcePOOnInvoice: TWideStringField
      FieldName = 'ForcePOOnInvoice'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryClientLookupUseInvBase: TWideStringField
      FieldName = 'UseInvBase'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryClientLookupInvBaseNumber: TIntegerField
      FieldName = 'InvBaseNumber'
      Visible = False
    end
    object qryClientLookupWarrantyFinishDate: TDateTimeField
      FieldName = 'WarrantyFinishDate'
      Visible = False
    end
    object qryClientLookupIsJob: TWideStringField
      FieldName = 'IsJob'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  inherited imgPopup: TImageList
    Left = 342
    Top = 295
    Bitmap = {
      494C01010400FC014C0610001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 601
    Top = 295
  end
  object qryUnitOfMeasure: TERPQuery [27]
    Connection = MyConnection
    SQL.Strings = (
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
    Left = 258
    Top = 330
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
    object qryUnitOfMeasureBaseUnitName: TWideStringField
      FieldName = 'BaseUnitName'
      Size = 15
    end
  end
  object mnuDiscountTotal: TAdvPopupMenu [28]
    OnPopup = mnuDiscountTotalPopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 46
    Top = 295
    object DiscountDollarTotal: TMenuItem
      Caption = 'Discount $ From Grand Total (Inc)'
      OnClick = DiscountDollarTotalClick
    end
    object DiscountPercentTotal: TMenuItem
      Caption = 'Discount % From Grand Total (Inc)'
      OnClick = DiscountPercentTotalClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object mnuProductNotes: TMenuItem
      Caption = 'Product Notes'
      OnClick = mnuProductNotesClick
    end
    object ProductStockQty1: TMenuItem
      Caption = 'Product Stock Qty'
      OnClick = ProductStockQty1Click
    end
    object ETAInfo: TMenuItem
      Caption = 'Product Status'
      OnClick = ETAInfoClick
    end
    object mnuAlternateProduct: TMenuItem
      Caption = 'Alternate Product'
      OnClick = mnuAlternateProductClick
    end
    object ProductSelectionOptions2: TMenuItem
      Caption = 'Product Selection Options'
      OnClick = ProductSelectionOptions2Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object CustomFields1: TMenuItem
      Caption = 'Line Custom Fields'
      OnClick = CustomFields1Click
    end
    object mnuSaleCustomFields: TMenuItem
      Caption = 'Sale Custom Fields'
      OnClick = mnuSaleCustomFieldsClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
  end
  object cboAccountQry: TERPQuery [29]
    SQL.Strings = (
      
        'SELECT AccountID, AccountName, AccountType, Description, Account' +
        'Number, Taxcode, BankNumber, Extra, Active, EditedFlag, Class, A' +
        'llClasses, OpeningBalance, Debits, Credits, ClosingBalance, Acco' +
        'untGroup  '
      'FROM tblchartofaccounts'
      'WHERE AccountType = '#39'AR'#39' and Active='#39'T'#39' and IsHeader = '#39'F'#39)
    Options.LongStrings = False
    Left = 290
    Top = 330
  end
  object qrySupplier: TERPQuery [30]
    SQL.Strings = (
      'SELECT ClientID, Company '
      'FROM tblclients'
      'WHERE Active = '#39'T'#39
      'And Supplier = '#39'T'#39' '
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (Company LIKE Concat(:SearchValue,"%")' +
        '))'
      
        'or ((:SearchMode = 2) and (Company LIKE Concat("%",:SearchValue,' +
        '"%"))))'
      'and IfNull(:SearchValue,"") <> ""'
      'ORDER BY Company')
    Options.LongStrings = False
    Left = 510
    Top = 330
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
  object DMTextTargetSales: TDMTextTarget [31]
    AcceptorControl = txtComments
    AcceptTextFormats = [dtfFiles, dtfCustom]
    OnDrop = DMTextTargetSalesDrop
    Left = 268
    Top = 295
  end
  object qryPartsSpecs: TERPQuery [32]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblpartsspecifications'
      'WHERE IsMultiplier='#39'T'#39' AND PartsID=:xPartsID;')
    Left = 573
    Top = 330
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPartsID'
      end>
  end
  object cboTermsQry: TERPQuery [33]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT tblTerms.TermsID, tblTerms.Terms, tblTerms.TermsAmount, t' +
        'blTerms.EOM, tblTerms.EOMPlus, tblTerms.Active '
      'FROM tblTerms '
      'WHERE (tblTerms.Active='#39'T'#39' OR tblTerms.Terms=:xTerms)'
      'ORDER BY tblTerms.Terms; ')
    BeforeOpen = cboTermsQryBeforeOpen
    CommandTimeout = 30
    Left = 416
    Top = 330
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xTerms'
      end>
    object cboTermsQryTermsID: TIntegerField
      FieldName = 'TermsID'
    end
    object cboTermsQryTerms: TWideStringField
      FieldName = 'Terms'
      Size = 50
    end
    object cboTermsQryTermsAmount: TIntegerField
      FieldName = 'TermsAmount'
    end
    object cboTermsQryEOM: TWideStringField
      FieldName = 'EOM'
      FixedChar = True
      Size = 1
    end
    object cboTermsQryEOMPlus: TWideStringField
      FieldName = 'EOMPlus'
      FixedChar = True
      Size = 1
    end
    object cboTermsQryActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
  end
  object dlgMemoLine: TwwMemoDialog [34]
    DataSource = DSDetails
    DataField = 'MemoLine'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Caption = 'Memo Line Editor'
    DlgLeft = 0
    DlgTop = 0
    DlgWidth = 561
    DlgHeight = 396
    Left = 231
    Top = 295
  end
  object tblFESalesLines: TERPQuery [35]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblFESalesLines'
      'WHERE SaleLineID = :ID')
    Left = 69
    Top = 330
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblFESalesLinesField1: TFloatField
      DisplayWidth = 10
      FieldName = 'Field1'
    end
    object tblFESalesLinesField2: TFloatField
      DisplayWidth = 10
      FieldName = 'Field2'
    end
    object tblFESalesLinesField3: TFloatField
      DisplayWidth = 10
      FieldName = 'Field3'
    end
    object tblFESalesLinesfield4: TFloatField
      DisplayWidth = 10
      FieldName = 'field4'
    end
    object tblFESalesLinesField5: TFloatField
      DisplayWidth = 10
      FieldName = 'Field5'
    end
    object tblFESalesLinesShippedField1: TFloatField
      DisplayWidth = 10
      FieldName = 'ShippedField1'
    end
    object tblFESalesLinesShippedField2: TFloatField
      DisplayWidth = 10
      FieldName = 'ShippedField2'
    end
    object tblFESalesLinesShippedField3: TFloatField
      DisplayWidth = 10
      FieldName = 'ShippedField3'
    end
    object tblFESalesLinesShippedField4: TFloatField
      DisplayWidth = 10
      FieldName = 'ShippedField4'
    end
    object tblFESalesLinesShippedField5: TFloatField
      DisplayWidth = 10
      FieldName = 'ShippedField5'
    end
    object tblFESalesLinesSaleID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleID'
    end
    object tblFESalesLinesSaleLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleLineID'
    end
    object tblFESalesLinesFESalesLineID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'FESalesLineID'
      ReadOnly = True
      Visible = False
    end
    object tblFESalesLinesGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object tblFESalesLinesProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Visible = False
    end
    object tblFESalesLinesDeleted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblFESalesLinesProductName: TWideStringField
      DisplayWidth = 60
      FieldName = 'ProductName'
      Size = 60
    end
    object tblFESalesLinesmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object tblFESalesLinesmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object tblFESalesLinesFormulaId: TIntegerField
      FieldName = 'FormulaId'
    end
  end
  object tblFESaleslinesRelatedPrs: TERPQuery [36]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblFESaleslinesRelatedPrs'
      'WHERE FESalesLineID = :ID')
    Left = 101
    Top = 330
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblFESaleslinesRelatedPrsProductName: TWideStringField
      DisplayWidth = 23
      FieldName = 'ProductName'
      Size = 60
    end
    object tblFESaleslinesRelatedPrsFormula: TWideStringField
      DisplayWidth = 23
      FieldName = 'Formula'
      Size = 255
    end
    object tblFESaleslinesRelatedPrsRelatedQty: TFloatField
      DisplayWidth = 10
      FieldName = 'RelatedQty'
    end
    object tblFESaleslinesRelatedPrsRelatedShippedQty: TFloatField
      DisplayWidth = 10
      FieldName = 'RelatedShippedQty'
    end
    object tblFESaleslinesRelatedPrsFESaleslinesRelatedPrID: TAutoIncField
      FieldName = 'FESaleslinesRelatedPrID'
      ReadOnly = True
      Visible = False
    end
    object tblFESaleslinesRelatedPrsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object tblFESaleslinesRelatedPrsFESalesLineID: TIntegerField
      FieldName = 'FESalesLineID'
      Visible = False
    end
    object tblFESaleslinesRelatedPrsProductID: TIntegerField
      FieldName = 'ProductID'
      Visible = False
    end
    object tblFESaleslinesRelatedPrsFormulaID: TIntegerField
      FieldName = 'FormulaID'
      Visible = False
    end
    object tblFESaleslinesRelatedPrsDeleted: TWideStringField
      FieldName = 'Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object dsFESalesLines: TDataSource [37]
    DataSet = tblFESalesLines
    Left = 69
    Top = 362
  end
  object dsFESaleslinesRelatedPrs: TDataSource [38]
    DataSet = tblFESaleslinesRelatedPrs
    Left = 101
    Top = 362
  end
  object qryShipContainerSaleLookup: TERPQuery [39]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT ContainerName,SD.PurchaseLineID,tblpurchaselines.SaleLine' +
        'ID,SC.ETA,SC.Active'
      'FROM tblshippingcontainer SC'
      
        'INNER JOIN tblshipcontainerdetails SD ON SC.ShippingContainerID ' +
        '= SD.ShippingContainerID'
      
        'INNER JOIN tblpurchaselines ON SD.PurchaseLineID = tblpurchaseli' +
        'nes.PurchaseLineID'
      'WHERE SC.Active = "T"')
    Left = 542
    Top = 330
  end
  object tblEquipmentxRefs: TERPQuery [40]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblEquipmentxRef'
      'Where RepairID= :ID;')
    Left = 857
    Top = 330
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID'
        Value = 0
      end>
    object tblEquipmentxRefsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object tblEquipmentxRefsid: TIntegerField
      FieldName = 'id'
    end
    object tblEquipmentxRefsCustomerEquipmentID: TIntegerField
      FieldName = 'CustomerEquipmentID'
    end
    object tblEquipmentxRefsRepairID: TIntegerField
      FieldName = 'RepairID'
    end
    object tblEquipmentxRefsNotes: TWideStringField
      FieldName = 'Notes'
      Size = 100
    end
    object tblEquipmentxRefsOnSite: TWideStringField
      FieldName = 'OnSite'
      FixedChar = True
      Size = 1
    end
    object tblEquipmentxRefsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblEquipmentxRefsDescription: TWideStringField
      FieldName = 'Description'
      Size = 255
    end
    object tblEquipmentxRefsCreationDate: TDateField
      FieldName = 'CreationDate'
    end
    object tblEquipmentxRefsUpdateDate: TDateField
      FieldName = 'UpdateDate'
    end
    object tblEquipmentxRefsCode: TWideStringField
      FieldName = 'Code'
      Size = 255
    end
    object tblEquipmentxRefsCustomField1: TWideStringField
      FieldName = 'CustomField1'
      Size = 255
    end
    object tblEquipmentxRefsCustomField2: TWideStringField
      FieldName = 'CustomField2'
      Size = 255
    end
    object tblEquipmentxRefsCustomField3: TWideStringField
      FieldName = 'CustomField3'
      Size = 255
    end
    object tblEquipmentxRefsCustomField4: TWideStringField
      FieldName = 'CustomField4'
      Size = 255
    end
    object tblEquipmentxRefsCustomField5: TWideStringField
      FieldName = 'CustomField5'
      Size = 255
    end
    object tblEquipmentxRefsCustomField6: TWideStringField
      FieldName = 'CustomField6'
      Size = 255
    end
    object tblEquipmentxRefsCustomField7: TWideStringField
      FieldName = 'CustomField7'
      Size = 255
    end
    object tblEquipmentxRefsCustomField8: TWideStringField
      FieldName = 'CustomField8'
      Size = 255
    end
    object tblEquipmentxRefsCustomField9: TWideStringField
      FieldName = 'CustomField9'
      Size = 255
    end
    object tblEquipmentxRefsCustomField10: TWideStringField
      FieldName = 'CustomField10'
      Size = 255
    end
    object tblEquipmentxRefsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object tblEquipmentxRefsWarantyPeriodTaken: TLargeintField
      FieldName = 'WarantyPeriodTaken'
    end
    object tblEquipmentxRefsWarantyPeriodLeft: TLargeintField
      FieldName = 'WarantyPeriodLeft'
    end
    object tblEquipmentxRefsSaleId: TLargeintField
      FieldName = 'SaleId'
    end
    object tblEquipmentxRefsUOM: TWideStringField
      FieldName = 'UOM'
      Size = 50
    end
    object tblEquipmentxRefsUOMID: TLargeintField
      FieldName = 'UOMID'
    end
    object tblEquipmentxRefsUOMMultiplier: TFloatField
      FieldName = 'UOMMultiplier'
    end
    object tblEquipmentxRefsUOMQty: TFloatField
      FieldName = 'UOMQty'
    end
    object tblEquipmentxRefsQuantity: TFloatField
      FieldName = 'Quantity'
    end
    object tblEquipmentxRefsAppointmentID: TLargeintField
      FieldName = 'AppointmentID'
    end
    object tblEquipmentxRefsInvoiceID: TLargeintField
      FieldName = 'InvoiceID'
    end
    object tblEquipmentxRefsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object tblEquipmentxRefsNextServiceDate: TDateTimeField
      FieldName = 'NextServiceDate'
    end
  end
  object cboProductQry: TERPQuery [41]
    Connection = MyConnection
    SQL.Strings = (
      
        '#DUMMY QUERY - Sales.Formcreate dynamically changes the query fo' +
        'r seach options '
      ''
      'SELECT '
      'SUBSTRING_INDEX(P.ProductGroup,'#39'^'#39',1) AS Manuf    , '
      
        'substring(substring_index(P.ProductGroup,'#39'^'#39',2),char_length(subs' +
        'tring_index(P.ProductGroup,'#39'^'#39',1))+2) AS Type  ,'
      
        'substring(substring_index(P.ProductGroup,'#39'^'#39',3),char_length(subs' +
        'tring_index(P.ProductGroup,'#39'^'#39',2))+2) AS Dept,'
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
      'SupplierProductCode,'
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
        'tPrice  , '
      'p.TAXCODE, p.AutoBatch,'
      'p.Attrib1Sale,'
      'p.Attrib2Sale, '
      ' p.Attrib1SaleRate, '
      'P.LatestCostDate as LatestCostDate,'
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
      'FROM tblParts P'
      'WHERE P.Active = "T"'
      ' AND ('
      '  ((1 = 0) or (IsNull(1))) '
      
        'or ((1 = 1) and ((Partname  LIKE Concat('#39'As'#39',"%")) or (PARTSDESC' +
        'RIPTION LIKE Concat('#39'As'#39',"%")) or (SUBSTRING_INDEX(P.ProductGrou' +
        'p,'#39'^'#39',1) LIKE Concat('#39'As'#39',"%")) or (substring(substring_index(P.' +
        'ProductGroup,'#39'^'#39',2),char_length(substring_index(P.ProductGroup,'#39 +
        '^'#39',1))+2) LIKE Concat('#39'As'#39',"%")) or (substring(substring_index(P' +
        '.ProductGroup,'#39'^'#39',3),char_length(substring_index(P.ProductGroup,' +
        #39'^'#39',2))+2) LIKE Concat('#39'As'#39',"%")) )) '
      
        'or ((1 = 2) and ((Partname  LIKE Concat("%",'#39'As'#39',"%")) or (PARTS' +
        'DESCRIPTION LIKE Concat("%",'#39'As'#39',"%")) or (SUBSTRING_INDEX(P.Pro' +
        'ductGroup,'#39'^'#39',1) LIKE Concat("%",'#39'As'#39',"%")) or (substring(substr' +
        'ing_index(P.ProductGroup,'#39'^'#39',2),char_length(substring_index(P.Pr' +
        'oductGroup,'#39'^'#39',1))+2) LIKE Concat("%",'#39'As'#39',"%")) or (substring(s' +
        'ubstring_index(P.ProductGroup,'#39'^'#39',3),char_length(substring_index' +
        '(P.ProductGroup,'#39'^'#39',2))+2) LIKE Concat("%",'#39'As'#39',"%")) )) '
      ')')
    FilterOptions = [foCaseInsensitive]
    AfterOpen = cboProductQryAfterOpen
    Options.LongStrings = False
    Left = 668
    Top = 330
    object cboProductQryPARTNAME: TWideStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 15
      FieldName = 'PARTNAME'
      Origin = 'tblParts.PARTNAME'
      Size = 60
    end
    object cboProductQryPartsDescription: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 30
      FieldName = 'PartsDescription'
      Origin = 'tblParts.PARTSDESCRIPTION'
    end
    object cboProductQryManuf: TWideStringField
      DisplayWidth = 255
      FieldName = 'Manuf'
      Origin = '.Manuf'
      Visible = False
      Size = 255
    end
    object cboProductQryType: TWideStringField
      DisplayWidth = 255
      FieldName = 'Type'
      Origin = '.Type'
      Visible = False
      Size = 255
    end
    object cboProductQryDept: TWideStringField
      DisplayWidth = 255
      FieldName = 'Dept'
      Origin = '.Dept'
      Visible = False
      Size = 255
    end
    object cboProductQryPARTSID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PARTSID'
      Origin = 'tblParts.PARTSID'
      Visible = False
    end
    object cboProductQryPARTTYPE: TWideStringField
      DisplayWidth = 13
      FieldName = 'PARTTYPE'
      Origin = 'tblParts.PARTTYPE'
      Visible = False
      Size = 13
    end
    object cboProductQryLatestCostPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'LatestCostPrice'
      Origin = '.LatestCostPrice'
      Visible = False
    end
    object cboProductQrySNTracking: TWideStringField
      DisplayWidth = 1
      FieldName = 'SNTracking'
      Origin = 'tblParts.SNTracking'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblParts.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryPreferedSupp: TWideStringField
      DisplayWidth = 55
      FieldName = 'PreferedSupp'
      Origin = 'tblParts.PREFEREDSUPP'
      Visible = False
      Size = 55
    end
    object cboProductQryPRODUCTGROUP: TWideStringField
      DisplayWidth = 255
      FieldName = 'PRODUCTGROUP'
      Origin = 'tblParts.PRODUCTGROUP'
      Visible = False
      Size = 255
    end
    object cboProductQryINCOMEACCNT: TWideStringField
      DisplayWidth = 50
      FieldName = 'INCOMEACCNT'
      Origin = 'tblParts.INCOMEACCNT'
      Visible = False
      Size = 50
    end
    object cboProductQryASSETACCNT: TWideStringField
      DisplayWidth = 50
      FieldName = 'ASSETACCNT'
      Origin = 'tblParts.ASSETACCNT'
      Visible = False
      Size = 50
    end
    object cboProductQryCOGSACCNT: TWideStringField
      DisplayWidth = 50
      FieldName = 'COGSACCNT'
      Origin = 'tblParts.COGSACCNT'
      Visible = False
      Size = 50
    end
    object cboProductQryBARCODE: TWideStringField
      DisplayWidth = 35
      FieldName = 'BARCODE'
      Origin = 'tblParts.BARCODE'
      Visible = False
      Size = 35
    end
    object cboProductQryPRODUCTCODE: TWideStringField
      DisplayWidth = 255
      FieldName = 'PRODUCTCODE'
      Origin = 'tblParts.PRODUCTCODE'
      Visible = False
      Size = 255
    end
    object cboProductQryTAXCODE: TWideStringField
      DisplayWidth = 15
      FieldName = 'TAXCODE'
      Origin = 'tblParts.TAXCODE'
      Visible = False
      Size = 15
    end
    object cboProductQryBatch: TWideStringField
      DisplayWidth = 1
      FieldName = 'Batch'
      Origin = 'tblParts.Batch'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryAutoBatch: TWideStringField
      DisplayWidth = 1
      FieldName = 'AutoBatch'
      Origin = 'tblParts.AutoBatch'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryMultipleBins: TWideStringField
      DisplayWidth = 1
      FieldName = 'MultipleBins'
      Origin = 'tblParts.MultipleBins'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQrySpecialDiscount: TWideStringField
      DisplayWidth = 1
      FieldName = 'SpecialDiscount'
      Origin = 'tblParts.SpecialDiscount'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryBuyQTY1: TIntegerField
      DisplayWidth = 10
      FieldName = 'BuyQTY1'
      Origin = 'tblParts.BuyQTY1'
      Visible = False
    end
    object cboProductQryBuyQTY2: TIntegerField
      DisplayWidth = 10
      FieldName = 'BuyQTY2'
      Origin = 'tblParts.BuyQTY2'
      Visible = False
    end
    object cboProductQryBuyQTY3: TIntegerField
      DisplayWidth = 10
      FieldName = 'BuyQTY3'
      Origin = 'tblParts.BuyQTY3'
      Visible = False
    end
    object cboProductQryCOST1: TFloatField
      DisplayWidth = 10
      FieldName = 'COST1'
      Origin = 'tblParts.COST1'
      Visible = False
    end
    object cboProductQryCOST2: TFloatField
      DisplayWidth = 10
      FieldName = 'COST2'
      Origin = 'tblParts.COST2'
      Visible = False
    end
    object cboProductQryCOST3: TFloatField
      DisplayWidth = 10
      FieldName = 'COST3'
      Origin = 'tblParts.COST3'
      Visible = False
    end
    object cboProductQrySellQTY1: TIntegerField
      DisplayWidth = 10
      FieldName = 'SellQTY1'
      Origin = 'tblParts.SellQTY1'
      Visible = False
    end
    object cboProductQrySellQTY2: TIntegerField
      DisplayWidth = 10
      FieldName = 'SellQTY2'
      Origin = 'tblParts.SellQTY2'
      Visible = False
    end
    object cboProductQrySellQTY3: TIntegerField
      DisplayWidth = 10
      FieldName = 'SellQTY3'
      Origin = 'tblParts.SellQTY3'
      Visible = False
    end
    object cboProductQryPRICE1: TFloatField
      DisplayWidth = 10
      FieldName = 'PRICE1'
      Origin = 'tblParts.PRICE1'
      Visible = False
    end
    object cboProductQryPRICE2: TFloatField
      DisplayWidth = 10
      FieldName = 'PRICE2'
      Origin = 'tblParts.PRICE2'
      Visible = False
    end
    object cboProductQryPRICE3: TFloatField
      DisplayWidth = 10
      FieldName = 'PRICE3'
      Origin = 'tblParts.PRICE3'
      Visible = False
    end
    object cboProductQryWHOLESALEPRICE: TFloatField
      DisplayWidth = 10
      FieldName = 'WHOLESALEPRICE'
      Origin = 'tblParts.WHOLESALEPRICE'
      Visible = False
    end
    object cboProductQryEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Origin = 'tblParts.EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryAvgCost: TFloatField
      DisplayWidth = 10
      FieldName = 'AvgCost'
      Origin = 'tblParts.AvgCost'
      Visible = False
    end
    object cboProductQryAttrib1Sale: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib1Sale'
      Origin = 'tblParts.Attrib1Sale'
      Visible = False
    end
    object cboProductQryAttrib2Sale: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib2Sale'
      Origin = 'tblParts.Attrib2Sale'
      Visible = False
    end
    object cboProductQryAttrib1SaleRate: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib1SaleRate'
      Origin = 'tblParts.Attrib1SaleRate'
      Visible = False
    end
    object cboProductQryDiscontinued: TWideStringField
      DisplayWidth = 1
      FieldName = 'Discontinued'
      Origin = 'tblParts.Discontinued'
      Visible = False
      FixedChar = True
      Size = 1
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
    object cboProductQrySupplierProductCode: TWideStringField
      DisplayLabel = 'Supplier Product Code'
      DisplayWidth = 20
      FieldName = 'SupplierProductCode'
      Size = 50
    end
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 527
    Top = 295
  end
  inherited MyConnection: TERPConnection
    Database = 'magento_test_db'
    Server = 'localhost'
    Top = 295
  end
  object Qrysalesshippingdetails: TERPQuery [44]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblsalesshippingdetails'
      'WHERE SalesID = :ID')
    Left = 739
    Top = 330
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object QrysalesshippingdetailsSalesShippingDetailsID: TLargeintField
      FieldName = 'SalesShippingDetailsID'
    end
    object QrysalesshippingdetailsGlobalref: TWideStringField
      FieldName = 'Globalref'
      Size = 255
    end
    object QrysalesshippingdetailsSalesId: TLargeintField
      FieldName = 'SalesId'
    end
    object QrysalesshippingdetailsFlightNo: TWideStringField
      FieldName = 'FlightNo'
      Size = 100
    end
    object QrysalesshippingdetailsETD: TDateTimeField
      FieldName = 'ETD'
    end
    object QrysalesshippingdetailsETA: TDateTimeField
      FieldName = 'ETA'
    end
    object QrysalesshippingdetailsExFactoryDate: TDateTimeField
      FieldName = 'ExFactoryDate'
    end
    object QrysalesshippingdetailsDescription: TWideStringField
      FieldName = 'Description'
      Size = 100
    end
    object QrysalesshippingdetailsWeightUOMID: TLargeintField
      FieldName = 'WeightUOMID'
    end
    object QrysalesshippingdetailsWeightUOM: TWideStringField
      FieldName = 'WeightUOM'
      Size = 100
    end
    object QrysalesshippingdetailsWeightUOMMultiplier: TFloatField
      FieldName = 'WeightUOMMultiplier'
    end
    object QrysalesshippingdetailsNetWeight: TFloatField
      FieldName = 'NetWeight'
    end
    object QrysalesshippingdetailsGrossWeight: TFloatField
      FieldName = 'GrossWeight'
    end
    object QrysalesshippingdetailsSizeUOM: TWideStringField
      FieldName = 'SizeUOM'
      Size = 100
    end
    object QrysalesshippingdetailsSizeUOMID: TLargeintField
      FieldName = 'SizeUOMID'
    end
    object QrysalesshippingdetailsSizeUOMMultiplier: TFloatField
      FieldName = 'SizeUOMMultiplier'
    end
    object QrysalesshippingdetailsTotalCubicsize: TFloatField
      FieldName = 'TotalCubicsize'
    end
    object QrysalesshippingdetailsAdditionalOrderCost: TFloatField
      FieldName = 'AdditionalOrderCost'
      currency = True
    end
    object QrysalesshippingdetailsmsTimestamp: TDateTimeField
      FieldName = 'msTimestamp'
    end
    object QrysalesshippingdetailsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
  end
  object qryUOMLookup: TMyQuery [45]
    SQL.Strings = (
      'select * from tblunitsofmeasure')
    Left = 825
    Top = 330
  end
  object QryRelatedMaster: TERPQuery [46]
    Connection = MyConnection
    SQL.Strings = (
      'Select ChildclientId, Mastercompany  from tblrelatedclients')
    Left = 699
    Top = 330
    object QryRelatedMasterChildclientId: TIntegerField
      FieldName = 'ChildclientId'
      Origin = 'tblrelatedclients.ChildClientID'
    end
    object QryRelatedMasterMastercompany: TWideStringField
      FieldName = 'Mastercompany'
      Origin = 'tblrelatedclients.MasterCompany'
      Size = 80
    end
  end
  inherited DataState: TDataState
    Left = 453
    Top = 295
  end
  object QrySalesCAtegory: TERPQuery [48]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT id,Typecode,name FROM tblsimpletypes '
      'WHERE Typecode = '#39'SalesCategory'#39
      'ORDER BY Name')
    Left = 888
    Top = 330
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 83
    Top = 295
  end
  inherited imgsort: TImageList
    Left = 564
    Top = 295
  end
  inherited QryTransStatus: TERPQuery
    Left = 794
    Top = 330
  end
  inherited QryAreaCodeLk: TERPQuery
    Left = 762
    Top = 330
  end
  inherited cbTaxCodeQry: TERPQuery [53]
    Left = 447
    Top = 330
  end
  inherited qryMemTrans: TERPQuery [54]
    Left = 195
    Top = 330
  end
  inherited SaveDialog1: TSaveDialog [55]
    Left = 490
    Top = 295
  end
  inherited QryCustomField: TERPQuery [56]
    Left = 227
    Top = 330
  end
  inherited ProgressDialogOBJ: TProgressDialog [57]
    Left = 416
    Top = 295
  end
  inherited TmrCommentshint: TTimer [58]
    Left = 749
    Top = 295
  end
  inherited mnuBusobjProperties: TAdvPopupMenu [59]
    Left = 120
    Top = 295
  end
  object cboViaQry: TERPQuery [60]
    SQL.Strings = (
      'SELECT ShippingMethodID, ShippingMethod, 0 AS SortID'
      
        'FROM tblShippingMethods where Active= "T" and ShippingMethod = "' +
        'Quote" '
      'union all'
      'SELECT ShippingMethodID, ShippingMethod, 1 AS SortID'
      'FROM tblShippingMethods '
      'WHERE Active= "T" and ShippingMethod <> "Quote" '
      'ORDER BY SortID, ShippingMethod;')
    Left = 384
    Top = 330
    object cboViaQryShippingMethod: TWideStringField
      DisplayWidth = 25
      FieldName = 'ShippingMethod'
      FixedChar = True
      Size = 15
    end
    object cboViaQryShippingMethodID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'ShippingMethodID'
      ReadOnly = True
      Visible = False
    end
  end
  object QryAreaCodes: TERPQuery [61]
    Connection = MyConnection
    SQL.Strings = (
      
        'Select AreaCode, AreaName from tblAreaCodes where active ="T" or' +
        'der by Areacode')
    Left = 605
    Top = 330
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
  object qrySalesQuantities: TERPQuery [62]
    Connection = MyConnection
    SQL.Strings = (
      'select SL.ProductId, SL.SeqNo, SL.QtySold '
      
        'from tblsaleslines SL inner join tblsales S on SL.saleId = s.Sal' +
        'eID'
      'Where  S.Originalno = :xSaleID and ifnull(SL.BaseLineno,0)=0')
    Left = 164
    Top = 330
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xSaleID'
      end>
    object qrySalesQuantitiesProductId: TIntegerField
      FieldName = 'ProductId'
    end
    object qrySalesQuantitiesSeqNo: TIntegerField
      FieldName = 'SeqNo'
    end
    object qrySalesQuantitiesQtySold: TFloatField
      FieldName = 'QtySold'
    end
  end
  object tmrShipToMessage: TTimer [63]
    Interval = 6000
    OnTimer = tmrShipToMessageTimer
    Left = 823
    Top = 295
  end
  object QrySalesLinePackWeightLinesSum: TERPQuery [64]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT SL.saleId, SLPW.SaleLineId, sum(SLPW.AttribValue1*Packcou' +
        'nt) as AttribValue1 , Sum(SLPW.AttribValue2*Packcount) as Attrib' +
        'Value2 , sum(Packcount) as Packcount'
      'FROM tblsaleslinepackweightlines SLPW '
      'inner join tblsaleslines SL on SLPW.salelineId = SL.saleLineID '
      'group by SaleLineId')
    Left = 142
    Top = 362
    object QrySalesLinePackWeightLinesSumsaleId: TIntegerField
      FieldName = 'saleId'
    end
    object QrySalesLinePackWeightLinesSumSaleLineId: TIntegerField
      FieldName = 'SaleLineId'
    end
    object QrySalesLinePackWeightLinesSumAttribValue1: TFloatField
      FieldName = 'AttribValue1'
    end
    object QrySalesLinePackWeightLinesSumAttribValue2: TFloatField
      FieldName = 'AttribValue2'
    end
    object QrySalesLinePackWeightLinesSumPackcount: TFloatField
      FieldName = 'Packcount'
    end
  end
  object dsSalesLinePackWeightLinesSum: TDataSource [65]
    DataSet = QrySalesLinePackWeightLinesSum
    Left = 142
    Top = 394
  end
  object qrySalesSeqno: TERPQuery [66]
    Connection = MyConnection
    SQL.Strings = (
      
        'select Count( * )  as SeqNo from tblsales where OriginalNo = :Or' +
        'iginalNo'
      'and SaleID <= :SaleId')
    Left = 920
    Top = 299
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'OriginalNo'
      end
      item
        DataType = ftUnknown
        Name = 'SaleId'
      end>
    object qrySalesSeqnoSeqNo: TLargeintField
      FieldName = 'SeqNo'
    end
  end
  object qrySaleLookup: TERPQuery [67]
    Connection = MyConnection
    SQL.Strings = (
      
        'select SaleID, GlobalRef from tblsales where GlobalRef  = :Origi' +
        'nalNo')
    Left = 909
    Top = 331
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'OriginalNo'
      end>
  end
  object qryCostCentre: TERPQuery [68]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT CostCentreID, CostCentreName '
      'FROM tblCostCentre'
      'WHERE Active = '#39'T'#39
      'Order By CostCentreName;')
    Options.LongStrings = False
    Left = 636
    Top = 330
  end
  inherited tmrOnshow: TTimer [69]
    Left = 888
    Top = 296
  end
  object PopupMenu1: TPopupMenu
    Left = 376
  end
  object qryexternalxref: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblexternalxref where ERPID =:ERPID')
    Left = 184
    Top = 365
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ERPID'
      end>
    object qryexternalxrefID: TIntegerField
      FieldName = 'ID'
    end
    object qryexternalxrefExternalType: TWideStringField
      FieldName = 'ExternalType'
      Size = 255
    end
    object qryexternalxrefExternalID: TWideStringField
      FieldName = 'ExternalID'
      Size = 255
    end
    object qryexternalxrefExternalAltID: TWideStringField
      FieldName = 'ExternalAltID'
      Size = 255
    end
  end
  object dsexternalxref: TDataSource
    DataSet = qryexternalxref
    Left = 182
    Top = 394
  end
end
