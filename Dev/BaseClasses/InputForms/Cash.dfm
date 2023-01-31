inherited BaseCashGUI: TBaseCashGUI
  Left = 344
  Top = 311
  Caption = 'Cash'
  ClientWidth = 827
  OnKeyPress = FormKeyPress
  ExplicitLeft = 344
  ExplicitTop = 311
  ExplicitWidth = 843
  DesignSize = (
    827
    588)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Width = 827
    ExplicitWidth = 827
  end
  inherited pnlDetail: TDNMPanel
    Top = 219
    Width = 827
    Height = 260
    Align = alTop
    ParentColor = True
    ExplicitTop = 219
    ExplicitWidth = 827
    ExplicitHeight = 260
    inherited grdTransactions: TwwDBGrid
      Width = 827
      Height = 260
      ControlType.Strings = (
        'ProductName;CustomEdit;cboProductR;F'
        'LineTaxCode;CustomEdit;cboTaxCode;F'
        'UnitofMeasureSaleLines;CustomEdit;cboUnitOfMeasure;F'
        'SearchFilter;CustomEdit;txtSearchFilter;T'
        'Area;CustomEdit;cboLinesAreaCode;F')
      Selected.Strings = (
        'PartBarcode'#9'10'#9'Barcode'#9'F'#9
        'ProductName'#9'20'#9'Name'#9'F'#9
        'UnitofMeasureSaleLines'#9'10'#9'UOM'#9'F'#9
        'UnitofMeasureShipped'#9'10'#9'Shipped'#9'F'#9
        'PQA'#9'1'#9'Allocation'#9'F'#9
        'Product_Description'#9'20'#9'Description'#9'F'#9
        'CalcGrossProfitPercentInc'#9'10'#9'CalcGrossProfitPercentInc'#9#9
        'LatestCostPriceInc'#9'10'#9'Latest Cost (Inc)'#9#9
        'LinePriceInc'#9'10'#9'Amount (Inc)'#9#9
        'DiscountedPriceInc'#9'10'#9'Discounted Amount (Inc)'#9#9
        'LineTaxCode'#9'15'#9'Code'#9#9
        'LineTax'#9'10'#9'Tax (Dbl Click)'#9'F'
        'Discounts'#9'8'#9'Discounts'#9#9
        'TotalLineAmountInc'#9'10'#9'TotalLineAmountInc'#9#9
        'MatrixDesc'#9'10'#9'MatrixDesc'#9'T'#9
        'MatrixPrice'#9'10'#9'MatrixPrice'#9'T'#9
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
        'ISVoucher'#9'1'#9'ISVoucher'#9'F'#9
        'VoucherNo'#9'255'#9'VoucherNo'#9'F'#9
        'ISContainer'#9'1'#9'ISContainer'#9'F'#9
        'IsPallet'#9'1'#9'IsPallet'#9'F'#9
        'Area'#9'20'#9'Area'#9'F'#9
        'AreaQty'#9'10'#9'Area to Cover'#9'F'#9)
      OnKeyDown = grdTransactionsKeyDown
      ExplicitWidth = 827
      ExplicitHeight = 260
    end
    inherited cboTaxCode: TERPDbLookupCombo [1]
      TabOrder = 1
      OnDropDown = cboTaxCodeDropDown
    end
    object cboUnitOfMeasure: TwwDBLookupCombo [2]
      Left = 297
      Top = 97
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
      PreciseEditRegion = False
      AllowClearKey = False
      OnDropDown = cboUnitOfMeasureDropDown
      OnCloseUp = cboUnitOfMeasureCloseUp
    end
    object txtSearchFilter: TwwDBEdit [3]
      Left = 24
      Top = 81
      Width = 121
      Height = 23
      DataField = 'SearchFilter'
      DataSource = DSDetails
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      UnboundDataType = wwDefault
      Visible = False
      WantReturns = False
      WordWrap = False
    end
    object cboProductR: TERPDbLookupCombo [4]
      Left = 24
      Top = 30
      Width = 153
      Height = 26
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PARTNAME'#9'15'#9'Part Name'#9'T'
        'Manuf'#9'15'#9'Manuf'#9'T'
        'Type'#9'15'#9'Type'#9'T'
        'Dept'#9'15'#9'Dept'#9'T'
        'PARTSDESCRIPTION'#9'35'#9'Description'#9'T'
        'Active'#9'1'#9'Active'#9'T'
        'SupplierProductCode'#9'20'#9'Supplier Product Code'#9'F')
      DataField = 'ProductName'
      DataSource = DSDetails
      LookupTable = cboProductQry
      LookupField = 'Partname'
      Options = [loTitles]
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnChange = cboProductRChange
      OnKeyDown = cboProductRKeyDown
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
    inherited cboLinesAreaCode: TwwDBLookupCombo [5]
      DataField = 'Area'
      TabOrder = 4
    end
    object cboPrintProductR: TERPDbLookupCombo
      Left = 32
      Top = 38
      Width = 153
      Height = 26
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PARTNAME'#9'15'#9'Part Name'#9'T'
        'Manuf'#9'15'#9'Manuf'#9'T'
        'Type'#9'15'#9'Type'#9'T'
        'Dept'#9'15'#9'Dept'#9'T'
        'PARTSDESCRIPTION'#9'35'#9'Description'#9'T'
        'Active'#9'1'#9'Active'#9'T'
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
      OnChange = cboProductRChange
      OnKeyDown = cboProductRKeyDown
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
  end
  inherited pnlFooter: TDNMPanel
    Top = 479
    Width = 827
    Height = 109
    Align = alClient
    ParentColor = True
    ExplicitTop = 479
    ExplicitWidth = 827
    ExplicitHeight = 109
    DesignSize = (
      827
      109)
    inherited lblComments: TLabel
      Left = 118
      Top = 54
      ExplicitLeft = 118
      ExplicitTop = 54
    end
    inherited Label142: TLabel
      Left = 643
      Top = 10
      ExplicitLeft = 643
      ExplicitTop = 10
    end
    inherited Label54: TLabel
      Left = 644
      Top = 34
      ExplicitLeft = 644
      ExplicitTop = 34
    end
    inherited Label56: TLabel
      Left = 589
      Top = 63
      ExplicitLeft = 589
      ExplicitTop = 63
    end
    object Label122: TLabel [5]
      Left = 451
      Top = 36
      Width = 89
      Height = 18
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = 'Markup Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label3: TLabel [6]
      Left = 451
      Top = 7
      Width = 89
      Height = 18
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = 'Discount Total'
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
      TabOrder = 10
      inherited txtComments: TDBMemo
        Anchors = [akLeft, akRight, akBottom]
        DataField = 'Comments'
      end
    end
    inherited txtSubTotal: TDBEdit
      Left = 709
      Top = 6
      DataField = 'TotalAmount'
      ExplicitLeft = 709
      ExplicitTop = 6
    end
    inherited txtTotalTax: TDBEdit
      Left = 709
      Top = 31
      DataField = 'TotalTax'
      ExplicitLeft = 709
      ExplicitTop = 31
    end
    inherited txtTotalAmount: TDBEdit
      Left = 695
      Top = 57
      DataField = 'TotalAmountInc'
      ExplicitLeft = 695
      ExplicitTop = 57
    end
    inherited DNMPanel5: TDNMPanel
      Left = 333
      Top = 0
      TabOrder = 7
      ExplicitLeft = 333
      ExplicitTop = 0
      inherited lblEnteredbyHead: TLabel
        Top = 0
        ExplicitTop = 0
      end
      inherited lblEnteredBy: TDBText
        Left = 78
        Top = 0
        Width = 69
        Height = 15
        AutoSize = True
        ExplicitLeft = 78
        ExplicitTop = 0
        ExplicitWidth = 69
        ExplicitHeight = 15
      end
      inherited lblPrintHead: TLabel
        Top = 19
        ExplicitTop = 19
      end
      inherited lblPrintedBy: TLabel
        Left = 78
        Top = 19
        ExplicitLeft = 78
        ExplicitTop = 19
      end
      inherited lblPrintedOnCaption: TLabel
        Left = 10
        Top = 38
        ExplicitLeft = 10
        ExplicitTop = 38
      end
      inherited lblPrintedOn: TLabel
        Left = 78
        Top = 38
        ExplicitLeft = 78
        ExplicitTop = 38
      end
      inherited lblPrintedAtCaption: TLabel
        Top = 57
        ExplicitTop = 57
      end
      inherited lblPrintedAt: TLabel
        Left = 78
        Top = 57
        ExplicitLeft = 78
        ExplicitTop = 57
      end
      object lblEnteredAtHead: TLabel
        Left = 10
        Top = 76
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
        Left = 78
        Top = 76
        Width = 66
        Height = 15
        AutoSize = True
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
      TabOrder = 9
    end
    inherited pnlProcessMessage: TDNMPanel
      Width = 827
      ExplicitWidth = 827
      inherited lblProcessMessage: TLabel
        Width = 823
        ExplicitWidth = 823
      end
    end
    object txtTotalDiscount: TDBEdit
      Left = 543
      Top = 6
      Width = 88
      Height = 24
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
      TabOrder = 6
    end
    object txtTotalMarkup: TDBEdit
      Left = 543
      Top = 33
      Width = 88
      Height = 24
      TabStop = False
      Anchors = [akRight, akBottom]
      DataField = 'TotalMarkup'
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
  end
  inherited pnlHeader: TDNMPanel
    Top = 0
    Width = 827
    Height = 219
    Align = alTop
    Color = clActiveBorder
    ExplicitLeft = -123
    ExplicitTop = -4
    ExplicitWidth = 827
    ExplicitHeight = 219
    DesignSize = (
      827
      219)
    object Bevel2: TBevel [0]
      Left = 248
      Top = 113
      Width = 161
      Height = 55
      Shape = bsFrame
    end
    object Bevel1: TBevel [1]
      Left = 464
      Top = 112
      Width = 233
      Height = 97
      Shape = bsFrame
    end
    inherited lblStatus: TLabel
      Top = 173
      ExplicitTop = 173
    end
    inherited Label38: TLabel
      Left = 14
      Top = 44
      Caption = 'Customer Name'
      ExplicitLeft = 14
      ExplicitTop = 44
    end
    inherited lblClientDetails: TLabel
      Top = 93
      ExplicitTop = 93
    end
    inherited SaleDate_Label: TLabel
      Left = 440
      Top = 47
      ExplicitLeft = 440
      ExplicitTop = 47
    end
    inherited Label160: TLabel
      Left = 598
      Top = 48
      ExplicitLeft = 598
      ExplicitTop = 48
    end
    object ClassLabel: TLabel [7]
      Left = 273
      Top = 119
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
    object Label43: TLabel [8]
      Left = 472
      Top = 161
      Width = 105
      Height = 18
      AutoSize = False
      Caption = 'Reference No'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblAccount: TLabel [9]
      Left = 17
      Top = -1
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
    object lblPaymentMethod: TLabel [10]
      Left = 472
      Top = 119
      Width = 105
      Height = 18
      AutoSize = False
      Caption = 'Payment Method'
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
      Left = 248
      Top = 55
      ExplicitLeft = 248
      ExplicitTop = 55
    end
    object lblInvoice: TLabel [12]
      Left = 613
      Top = 116
      Width = 40
      Height = 15
      Caption = 'Invoice'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    inherited lbMemTrans: TLabel
      Left = 584
      ExplicitLeft = 584
    end
    object Label79: TLabel [14]
      Left = 487
      Top = 176
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
      Visible = False
      WordWrap = True
    end
    object Label45: TLabel [15]
      Left = 366
      Top = 174
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
      Visible = False
      WordWrap = True
    end
    inherited lblRedeemPoints: TLabel
      Top = 41
      ExplicitTop = 41
    end
    object Label4: TLabel [19]
      Left = 626
      Top = 11
      Width = 56
      Height = 15
      Caption = 'Ship Time'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    inherited cboCurrentTransStatus: TwwDBLookupCombo [21]
      Left = 248
      Top = 190
      TabOrder = 30
      ExplicitLeft = 248
      ExplicitTop = 190
    end
    inherited txtClientDetails: TDBMemo [22]
      Top = 112
      Height = 100
      DataField = 'InvoiceTo'
      ExplicitTop = 112
      ExplicitHeight = 100
    end
    inherited cboCreationDate: TwwDBDateTimePicker [23]
      Left = 439
      Top = 68
      DataField = 'SaleDate'
      Date = 0.000000000000000000
      ExplicitLeft = 439
      ExplicitTop = 68
    end
    object cboClass: TwwDBLookupCombo [24]
      Left = 273
      Top = 138
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
      TabOrder = 8
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object txtPONumber: TDBEdit [25]
      Left = 472
      Top = 176
      Width = 116
      Height = 23
      DataField = 'ChequeNo'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
    end
    object cboAccount: TwwDBLookupCombo [26]
      Left = 15
      Top = 12
      Width = 217
      Height = 23
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'30'#9'AccountName'#9'F'
        'Type'#9'20'#9'Type'#9'F')
      DataField = 'Account'
      DataSource = DSMaster
      LookupTable = cboAccountQry
      LookupField = 'AccountName'
      ParentFont = False
      TabOrder = 28
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    inherited txtCustomID: TDBEdit [27]
      Left = 596
      Top = 68
      DataField = 'InvoiceDocNumber'
      ExplicitLeft = 596
      ExplicitTop = 68
    end
    inherited cboEmployee: TwwDBLookupCombo [28]
      Left = 282
      Top = 53
      Width = 127
      DataField = 'EmployeeName'
      OnNotInList = cboEmployeeNotInList
      ExplicitLeft = 282
      ExplicitTop = 53
      ExplicitWidth = 127
    end
    inherited btnNext: TDNMSpeedButton [29]
      TabOrder = 13
    end
    inherited btnCompleted: TDNMSpeedButton [30]
      Top = 47
      TabOrder = 20
      ExplicitTop = 47
    end
    inherited btnClose: TDNMSpeedButton [31]
      Top = 90
      TabOrder = 23
      ExplicitTop = 90
    end
    inherited btnPreview: TDNMSpeedButton [32]
      Top = 133
      TabOrder = 5
      ExplicitTop = 133
    end
    inherited btnPrint: TDNMSpeedButton [33]
      Top = 176
      TabOrder = 6
      ExplicitTop = 176
    end
    inherited pnlChooseRpt: TDNMPanel [34]
      Left = 248
      Top = 82
      Width = 161
      TabOrder = 22
      ExplicitLeft = 248
      ExplicitTop = 82
      ExplicitWidth = 161
    end
    inherited btnContacts: TDNMSpeedButton [35]
      TabOrder = 19
    end
    inherited cboBaseForeignCurrencyCode: TwwDBLookupCombo [36]
      TabOrder = 21
    end
    inherited edtBaseExchangeRate: TwwDBEdit [37]
      TabOrder = 25
    end
    inherited pnlTitle: TDNMPanel [38]
      Width = 180
      Locked = True
      TabOrder = 7
      ExplicitWidth = 180
      inherited TitleShader: TShader
        Width = 178
        ExplicitWidth = 178
        inherited TitleLabel: TLabel
          Width = 178
          ExplicitWidth = 178
        end
      end
    end
    inherited cboClientR: TERPDbLookupCombo [39]
      Selected.Strings = (
        'Company'#9'35'#9'Company'#9'F')
      AutoSelect = True
      UseTFields = False
      LookupFormClassName = 'TCustomerExpressListGUI'
      EditFormClassName = 'TfrmCustomer'
      LookupFormKeyStringFieldName = 'Company'
      LookupComboType = ctCustomer
      LookupIDField = 'ClientID'
      LookupFieldAlt = 'PrintName'
    end
    inherited btnPayments: TDNMSpeedButton [40]
      Left = 484
      Top = 18
      ExplicitLeft = 484
      ExplicitTop = 18
    end
    inherited cmdEmail: TDNMSpeedButton [41]
      Top = 209
      ExplicitTop = 209
    end
    inherited btnPDF: TDNMSpeedButton [42]
      TabOrder = 27
    end
    inherited btnEdit: TDNMSpeedButton [43]
      TabOrder = 29
    end
    object cboPaymentMethod: TwwDBLookupCombo
      Left = 470
      Top = 135
      Width = 116
      Height = 23
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taRightJustify
      DataField = 'PayMethod'
      DataSource = DSMaster
      LookupTable = qryPayMethod
      LookupField = 'Name'
      DropDownWidth = 150
      ParentFont = False
      TabOrder = 9
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnChange = cboPaymentMethodChange
    end
    object btnSplit: TDNMSpeedButton
      Left = 595
      Top = 135
      Width = 87
      Height = 27
      Action = actSplitPay
      Caption = 'Split Pay'
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
      TabOrder = 10
      AutoDisableParentOnclick = True
    end
    object chkInvoice: TCheckBox
      Left = 595
      Top = 115
      Width = 14
      Height = 17
      Caption = 'chkInvoice'
      Enabled = False
      TabOrder = 14
      Visible = False
    end
    object cboTerms: TwwDBLookupCombo
      Left = 484
      Top = 190
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
      TabOrder = 17
      Visible = False
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboDueDate: TwwDBDateTimePicker
      Left = 367
      Top = 192
      Width = 111
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
      TabOrder = 18
      UnboundDataType = wwDTEdtDate
      Visible = False
    end
    object btnCashDrawer: TDNMSpeedButton
      Left = 596
      Top = 176
      Width = 87
      Height = 27
      Caption = 'Cash &Drawer'
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
      TabOrder = 12
      Visible = False
      AutoDisableParentOnclick = True
      OnClick = btnCashDrawerClick
    end
    object btnDeposit: TDNMSpeedButton
      Left = 487
      Top = 18
      Width = 87
      Height = 27
      Caption = 'Deposit'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      TabOrder = 24
      TabStop = False
      Visible = False
      AutoDisableParentOnclick = True
    end
    object wwDBDateTimePicker1: TwwDBDateTimePicker
      Left = 626
      Top = 23
      Width = 158
      Height = 23
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      CalendarAttributes.PopupYearOptions.NumberColumns = 4
      DataField = 'SaleDateTime'
      DataSource = DSMaster
      Epoch = 1950
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 26
      UnboundDataType = wwDTEdtDate
    end
  end
  object qryPayMethod: TERPQuery [8]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT PayMethodID, Name, IsCreditCard FROM tblpaymentmethods wh' +
        'ere Active ="T" order by name')
    AutoCalcFields = False
    Left = 222
    Top = 384
    object qryPayMethodPayMethodID: TIntegerField
      FieldName = 'PayMethodID'
    end
    object qryPayMethodName: TWideStringField
      FieldName = 'Name'
      Size = 255
    end
    object qryPayMethodIsCreditCard: TWideStringField
      FieldName = 'IsCreditCard'
      FixedChar = True
      Size = 1
    end
  end
  inherited DSDetails: TDataSource
    Left = 51
    Top = 410
  end
  inherited DSMaster: TDataSource
    Left = 10
    Top = 411
  end
  inherited lsTDNMSpeedButtonActions: TActionList
    object actSplitPay: TAction [4]
      Caption = 'Split Pay'
      Enabled = False
      OnExecute = actSplitPayExecute
      OnUpdate = actSplitPayUpdate
    end
    object actcheckdiscount: TDNMAction
      Caption = 'Check Discount'
      OnExecute = actcheckdiscountExecute
      OnUpdate = actcheckdiscountUpdate
      buttoncolor = clWhite
    end
  end
  inherited popDscntMrkup: TAdvPopupMenu
    Left = 483
    Top = 305
  end
  inherited popMemTrans: TAdvPopupMenu
    Top = 8
    inherited mnuStockTransferEntrylist: TMenuItem
      Visible = True
    end
    object checkDiscount1: TMenuItem
      Action = actcheckdiscount
    end
  end
  inherited tblMaster: TERPQuery
    OnCalcFields = tblMasterCalcFields
    Left = 8
    Top = 378
    object tblMasterSaleID: TAutoIncField
      FieldName = 'SaleID'
      ReadOnly = True
    end
    object tblMasterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object tblMasterInvoiceDocNumber: TWideStringField
      FieldName = 'InvoiceDocNumber'
      OnSetText = FeldSetTextDontAllowNulls
      Size = 30
    end
    object tblMasterOriginalNo: TWideStringField
      FieldName = 'OriginalNo'
      Size = 255
    end
    object tblMasterClientPrintName: TWideStringField
      FieldName = 'ClientPrintName'
      Size = 255
    end
    object tblMasterAccount: TWideStringField
      FieldName = 'Account'
      Size = 255
    end
    object tblMasterAccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object tblMasterBOID: TWideStringField
      FieldName = 'BOID'
      Size = 255
    end
    object tblMasterCustomerName: TWideStringField
      FieldName = 'CustomerName'
      Size = 255
    end
    object tblMasterClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object tblMasterInvoiceTo: TWideStringField
      FieldName = 'InvoiceTo'
      Size = 255
    end
    object tblMasterShipTo: TWideStringField
      FieldName = 'ShipTo'
      Size = 255
    end
    object tblMasterSaleDate: TDateField
      FieldName = 'SaleDate'
    end
    object tblMasterTotalTax: TFloatField
      FieldName = 'TotalTax'
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
    object tblMasterTotalMarkup: TFloatField
      FieldName = 'TotalMarkup'
      currency = True
    end
    object tblMasterTotalDiscount: TFloatField
      FieldName = 'TotalDiscount'
      currency = True
    end
    object tblMasterEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 255
    end
    object tblMasterClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object tblMasterEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object tblMasterClass: TWideStringField
      FieldName = 'Class'
      Size = 255
    end
    object tblMasterOrderNumber: TWideStringField
      FieldName = 'OrderNumber'
      Size = 30
    end
    object tblMasterPONumber: TWideStringField
      FieldName = 'PONumber'
      Size = 30
    end
    object tblMasterChequeNo: TWideStringField
      FieldName = 'ChequeNo'
      Size = 45
    end
    object tblMasterShipDate: TDateField
      FieldName = 'ShipDate'
    end
    object tblMasterDueDate: TDateField
      FieldName = 'DueDate'
    end
    object tblMasterConNote: TWideStringField
      FieldName = 'ConNote'
      Size = 25
    end
    object tblMasterInvoicePrintDesc: TWideStringField
      FieldName = 'InvoicePrintDesc'
      Size = 255
    end
    object tblMasterPickMemo: TWideMemoField
      FieldName = 'PickMemo'
      BlobType = ftWideMemo
      Size = 255
    end
    object tblMasterPrintHold: TWideStringField
      FieldName = 'PrintHold'
      FixedChar = True
      Size = 1
    end
    object tblMasterShipping: TWideStringField
      FieldName = 'Shipping'
      Size = 255
    end
    object tblMasterTerms: TWideStringField
      FieldName = 'Terms'
      Size = 255
    end
    object tblMasterPayMethod: TWideStringField
      FieldName = 'PayMethod'
      Size = 50
    end
    object tblMasterPayDueDate: TWideStringField
      FieldName = 'PayDueDate'
      Size = 11
    end
    object tblMasterPaid: TWideStringField
      FieldName = 'Paid'
      FixedChar = True
      Size = 1
    end
    object tblMasterBalance: TFloatField
      FieldName = 'Balance'
      currency = True
    end
    object tblMasterPayment: TFloatField
      FieldName = 'Payment'
      currency = True
    end
    object tblMasterApplyFlag: TWideStringField
      FieldName = 'ApplyFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterAmountDue: TFloatField
      FieldName = 'AmountDue'
    end
    object tblMasterTimeOfSale: TWideStringField
      FieldName = 'TimeOfSale'
      Size = 11
    end
    object tblMasterPOS: TWideStringField
      FieldName = 'POS'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsRefund: TWideStringField
      FieldName = 'IsRefund'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsCashSale: TWideStringField
      FieldName = 'IsCashSale'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsInvoice: TWideStringField
      FieldName = 'IsInvoice'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsQuote: TWideStringField
      FieldName = 'IsQuote'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsSalesOrder: TWideStringField
      FieldName = 'IsSalesOrder'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsLayby: TWideStringField
      FieldName = 'IsLayby'
      FixedChar = True
      Size = 1
    end
    object tblMasterDeleted: TWideStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
    object tblMasterEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterTotalQuoteAmount: TFloatField
      FieldName = 'TotalQuoteAmount'
      currency = True
    end
    object tblMasterLaybyID: TWideStringField
      FieldName = 'LaybyID'
      Size = 14
    end
    object tblMasterMemo: TWideMemoField
      FieldName = 'Memo'
      BlobType = ftWideMemo
    end
    object tblMasterComments: TWideMemoField
      FieldName = 'Comments'
      BlobType = ftWideMemo
    end
    object tblMasterEnteredBy: TWideStringField
      FieldName = 'EnteredBy'
      Size = 255
    end
    object tblMasterEnteredAt: TWideStringField
      FieldName = 'EnteredAt'
      Size = 255
    end
    object tblMasterSOBalance: TFloatField
      FieldName = 'SOBalance'
    end
    object tblMasterIsPOS: TWideStringField
      FieldName = 'IsPOS'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsVoucher: TWideStringField
      FieldName = 'IsVoucher'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsLaybyTOS: TWideStringField
      FieldName = 'IsLaybyTOS'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsLaybyPayment: TWideStringField
      FieldName = 'IsLaybyPayment'
      FixedChar = True
      Size = 1
    end
    object tblMasterDeposited: TWideStringField
      FieldName = 'Deposited'
      FixedChar = True
      Size = 1
    end
    object tblMasterTillID: TSmallintField
      FieldName = 'TillID'
    end
    object tblMasterHoldSale: TWideStringField
      FieldName = 'HoldSale'
      FixedChar = True
      Size = 1
    end
    object tblMasterFreezeQuoteAmount: TWideStringField
      FieldName = 'FreezeQuoteAmount'
      FixedChar = True
      Size = 1
    end
    object tblMasterConverted: TWideStringField
      FieldName = 'Converted'
      FixedChar = True
      Size = 1
    end
    object tblMasterCommissionPaid: TWideStringField
      FieldName = 'CommissionPaid'
      FixedChar = True
      Size = 1
    end
    object tblMasterPickupFrom: TWideStringField
      FieldName = 'PickupFrom'
      Size = 255
    end
    object tblMasterIsManifest: TWideStringField
      FieldName = 'IsManifest'
      FixedChar = True
      Size = 1
    end
    object tblMasterUsedOnManifest: TWideStringField
      FieldName = 'UsedOnManifest'
      FixedChar = True
      Size = 1
    end
    object tblMasterAddToManifest: TWideStringField
      FieldName = 'AddToManifest'
      FixedChar = True
      Size = 1
    end
    object tblMasterQuoteGlobalRef: TWideStringField
      FieldName = 'QuoteGlobalRef'
      Size = 255
    end
    object tblMasterSalesOrderGlobalRef: TWideStringField
      FieldName = 'SalesOrderGlobalRef'
      Size = 255
    end
    object tblMasterIsBarcodePicking: TWideStringField
      FieldName = 'IsBarcodePicking'
      FixedChar = True
      Size = 1
    end
    object tblMasterBarcodePickingDone: TWideStringField
      FieldName = 'BarcodePickingDone'
      FixedChar = True
      Size = 1
    end
    object tblMasterARNotes: TWideMemoField
      FieldName = 'ARNotes'
      BlobType = ftWideMemo
    end
    object tblMasterOriginalCreationDate: TDateField
      FieldName = 'OriginalCreationDate'
    end
    object tblMasterQuoteStatus: TWideStringField
      FieldName = 'QuoteStatus'
      Size = 255
    end
    object tblMasterTotalWETTax: TFloatField
      FieldName = 'TotalWETTax'
    end
    object tblMasterTotalWEGTax: TFloatField
      FieldName = 'TotalWEGTax'
    end
    object tblMasterLastUpdated: TDateTimeField
      FieldName = 'LastUpdated'
    end
    object tblMasterForeignExchangeCode: TWideStringField
      FieldName = 'ForeignExchangeCode'
      OnSetText = FeldSetTextDontAllowNulls
      FixedChar = True
      Size = 3
    end
    object tblMasterForeignExchangeRate: TFloatField
      FieldName = 'ForeignExchangeRate'
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblMasterForeignTotalAmount: TFloatField
      FieldName = 'ForeignTotalAmount'
    end
    object tblMasterForeignPaidAmount: TFloatField
      FieldName = 'ForeignPaidAmount'
    end
    object tblMasterForeignBalanceAmount: TFloatField
      FieldName = 'ForeignBalanceAmount'
    end
    object tblMasterBaseNo: TWideStringField
      FieldName = 'BaseNo'
      Size = 255
    end
    object tblMasterContactID: TLargeintField
      FieldName = 'ContactID'
    end
    object tblMasterContactName: TWideStringField
      FieldName = 'ContactName'
      Size = 100
    end
    object tblMasterEnteredAtShort: TStringField
      FieldKind = fkCalculated
      FieldName = 'EnteredAtShort'
      Size = 255
      Calculated = True
    end
    object tblMasterSaleCustField1: TWideStringField
      FieldName = 'SaleCustField1'
      Size = 255
    end
    object tblMasterSaleCustField2: TWideStringField
      FieldName = 'SaleCustField2'
      Size = 255
    end
    object tblMasterSaleCustField3: TWideStringField
      FieldName = 'SaleCustField3'
      Size = 255
    end
    object tblMasterSaleCustField4: TWideStringField
      FieldName = 'SaleCustField4'
      Size = 255
    end
    object tblMasterSaleCustField5: TWideStringField
      FieldName = 'SaleCustField5'
      Size = 255
    end
    object tblMasterSaleCustField6: TWideStringField
      FieldName = 'SaleCustField6'
      Size = 255
    end
    object tblMasterSaleCustField7: TWideStringField
      FieldName = 'SaleCustField7'
      Size = 255
    end
    object tblMasterSaleCustField8: TWideStringField
      FieldName = 'SaleCustField8'
      Size = 255
    end
    object tblMasterSaleCustField9: TWideStringField
      FieldName = 'SaleCustField9'
      Size = 255
    end
    object tblMasterSaleCustField10: TWideStringField
      FieldName = 'SaleCustField10'
      Size = 255
    end
  end
  inherited tblDetails: TERPQuery
    Connection = MyConnection
    Left = 51
    Top = 380
    object tblDetailsPartBarcode: TWideStringField
      DisplayLabel = 'Barcode'
      DisplayWidth = 10
      FieldName = 'PartBarcode'
      Size = 255
    end
    object tblDetailsProductName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldName = 'ProductName'
      Size = 60
    end
    object tblDetailsUnitofMeasureSaleLines: TWideStringField
      DisplayLabel = 'UOM'
      DisplayWidth = 10
      FieldName = 'UnitofMeasureSaleLines'
      Size = 255
    end
    object tblDetailsUnitofMeasureShipped: TFloatField
      DisplayLabel = 'Shipped'
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
    object tblDetailsProduct_Description: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 20
      FieldName = 'Product_Description'
      Size = 255
    end
    object tblDetailsCalcGrossProfitPercentInc: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'CalcGrossProfitPercentInc'
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
    object tblDetailsLinePriceInc: TFloatField
      DisplayLabel = 'Amount (Inc)'
      DisplayWidth = 10
      FieldName = 'LinePriceInc'
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
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
    object tblDetailsLineTaxCode: TWideStringField
      DisplayLabel = 'Code'
      DisplayWidth = 15
      FieldName = 'LineTaxCode'
      Size = 15
    end
    object tblDetailsLineTax: TFloatField
      DisplayLabel = 'Tax (Dbl Click)'
      DisplayWidth = 10
      FieldName = 'LineTax'
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object tblDetailsDiscounts: TFloatField
      DisplayWidth = 8
      FieldName = 'Discounts'
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object tblDetailsTotalLineAmountInc: TFloatField
      DisplayWidth = 10
      FieldName = 'TotalLineAmountInc'
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object tblDetailsMatrixDesc: TWideMemoField
      DisplayWidth = 10
      FieldName = 'MatrixDesc'
      BlobType = ftWideMemo
    end
    object tblDetailsMatrixPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'MatrixPrice'
      currency = True
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
    object tblDetailsISVoucher: TWideStringField
      DisplayWidth = 1
      FieldName = 'ISVoucher'
      FixedChar = True
      Size = 1
    end
    object tblDetailsVoucherNo: TWideStringField
      DisplayWidth = 255
      FieldName = 'VoucherNo'
      Size = 255
    end
    object tblDetailsISContainer: TWideStringField
      DisplayWidth = 1
      FieldName = 'ISContainer'
      FixedChar = True
      Size = 1
    end
    object tblDetailsIsPallet: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsPallet'
      FixedChar = True
      Size = 1
    end
    object tblDetailsArea: TWideStringField
      DisplayWidth = 20
      FieldName = 'Area'
      Size = 255
    end
    object tblDetailsAreaQty: TFloatField
      DisplayLabel = 'Area to Cover'
      DisplayWidth = 10
      FieldName = 'AreaQty'
    end
    object tblDetailsSaleLineID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'SaleLineID'
      ReadOnly = True
      Visible = False
    end
    object tblDetailsGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object tblDetailsSaleID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleID'
      Visible = False
    end
    object tblDetailsProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Visible = False
    end
    object tblDetailsProductGroup: TWideStringField
      DisplayWidth = 40
      FieldName = 'ProductGroup'
      Visible = False
      Size = 255
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
    object tblDetailsLinePrice: TFloatField
      DisplayLabel = 'Price (Ex)'
      DisplayWidth = 10
      FieldName = 'LinePrice'
      Visible = False
      DisplayFormat = '$0.00##'
      currency = True
    end
    object tblDetailsLineWholesalePrice: TFloatField
      DisplayWidth = 10
      FieldName = 'LineWholesalePrice'
      Visible = False
      currency = True
    end
    object tblDetailsLineTaxRate: TFloatField
      DisplayWidth = 10
      FieldName = 'LineTaxRate'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblDetailsLineCost: TFloatField
      DisplayWidth = 10
      FieldName = 'LineCost'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '$0.00##'
      currency = True
    end
    object tblDetailsLineCostInc: TFloatField
      DisplayWidth = 10
      FieldName = 'LineCostInc'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object tblDetailsQtySold: TFloatField
      DisplayWidth = 10
      FieldName = 'QtySold'
      Visible = False
    end
    object tblDetailsShipped: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'Shipped'
      Visible = False
    end
    object tblDetailsBackOrder: TFloatField
      DisplayWidth = 10
      FieldName = 'BackOrder'
      Visible = False
    end
    object tblDetailsInvoiced: TWideStringField
      DisplayWidth = 1
      FieldName = 'Invoiced'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsMarkup: TFloatField
      DisplayWidth = 8
      FieldName = 'Markup'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object tblDetailsMarkupPercent: TFloatField
      DisplayWidth = 8
      FieldName = 'MarkupPercent'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '#0.0%'
    end
    object tbldetailsMargin: TFloatField
      DisplayWidth = 8
      FieldName = 'Margin'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object tbldetailsMarginPercent: TFloatField
      DisplayWidth = 8
      FieldName = 'MarginPercent'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '#0.0%'
    end
    object tblDetailsDiscountPercent: TFloatField
      DisplayWidth = 8
      FieldName = 'DiscountPercent'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '#0.0%'
    end
    object tblDetailsTotalLineAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'TotalLineAmount'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
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
    object tblDetailsRefundQty: TFloatField
      DisplayWidth = 10
      FieldName = 'RefundQty'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblDetailsLaybyID: TWideStringField
      DisplayWidth = 14
      FieldName = 'LaybyID'
      Visible = False
      Size = 14
    end
    object tblDetailsCalcPriceInc: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'CalcPriceInc'
      Visible = False
      Calculated = True
    end
    object tblDetailsCalcTotalInc: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'CalcTotalInc'
      Visible = False
      Calculated = True
    end
    object tblDetailsCalcTotalEx: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'CalcTotalEx'
      Visible = False
      Calculated = True
    end
    object tblDetailsCalcTax: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'CalcTax'
      Visible = False
      Calculated = True
    end
    object tblDetailsCalcBackOrder: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'CalcBackOrder'
      Visible = False
      Calculated = True
    end
    object tblDetailsCalcLinePriceEx: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'CalcLinePriceEx'
      Visible = False
      Calculated = True
    end
    object tblDetailsOrgLinePrice: TFloatField
      FieldName = 'OrgLinePrice'
      Visible = False
    end
    object tblDetailsCalcTotalIncB4Discount: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'CalcTotalIncB4Discount'
      Visible = False
      Calculated = True
    end
    object tblDetailsAttrib1Sale: TFloatField
      FieldName = 'Attrib1Sale'
      Visible = False
    end
    object tblDetailsAttrib2Sale: TFloatField
      FieldName = 'Attrib2Sale'
      Visible = False
    end
    object tblDetailsAttrib1SaleRate: TFloatField
      FieldName = 'Attrib1SaleRate'
      Visible = False
    end
    object tblDetailsLastLineID: TIntegerField
      FieldName = 'LastLineID'
      Visible = False
    end
    object tblDetailsUnitofMeasureQtySold: TFloatField
      FieldName = 'UnitofMeasureQtySold'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblDetailsUnitofMeasureBackorder: TFloatField
      FieldName = 'UnitofMeasureBackorder'
      Visible = False
      DisplayFormat = '#,###,###,##0.#####'
    end
    object tblDetailsUnitofMeasureMultiplier: TFloatField
      FieldName = 'UnitofMeasureMultiplier'
      Visible = False
    end
    object tblDetailsSupplierContact: TWideStringField
      FieldName = 'SupplierContact'
      Visible = False
      Size = 255
    end
    object tblDetailsForeignCurrencyLinePrice: TFloatField
      FieldName = 'ForeignCurrencyLinePrice'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblDetailsForeignExchangeSellRate: TFloatField
      FieldName = 'ForeignExchangeSellRate'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblDetailsForeignExchangeSellCode: TWideStringField
      FieldName = 'ForeignExchangeSellCode'
      Visible = False
      FixedChar = True
      Size = 3
    end
    object tblDetailsSearchFilter: TWideStringField
      FieldName = 'SearchFilter'
      Visible = False
      Size = 64
    end
    object tblDetailsSearchFilterCopy: TWideStringField
      FieldName = 'SearchFilterCopy'
      Visible = False
      Size = 64
    end
    object tblDetailsIsRelatedProduct: TWideStringField
      FieldName = 'IsRelatedProduct'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsRelatedParentProductID: TIntegerField
      FieldName = 'RelatedParentProductID'
      Visible = False
    end
    object tblDetailsLatestCostPrice: TFloatField
      DisplayLabel = 'Latest Cost (Ex)'
      FieldKind = fkCalculated
      FieldName = 'LatestCostPrice'
      Visible = False
      currency = True
      Calculated = True
    end
    object tblDetailsSoldSerials: TWideMemoField
      FieldName = 'SoldSerials'
      Visible = False
      BlobType = ftWideMemo
    end
    object tblDetailsUnitOfMeasureID: TIntegerField
      FieldName = 'UnitOfMeasureID'
      Visible = False
    end
    object tblDetailsSortId: TIntegerField
      FieldName = 'SortId'
      Visible = False
    end
    object tblDetailsLinesOrder: TIntegerField
      DisplayLabel = 'Order by'
      FieldName = 'LinesOrder'
      Visible = False
    end
    object tblDetailsSeqNo: TIntegerField
      FieldName = 'SeqNo'
      Visible = False
    end
    object tblDetailsRelatedParentLineRef: TWideStringField
      FieldName = 'RelatedParentLineRef'
      Visible = False
      Size = 255
    end
    object tblDetailsCustomData: TWideMemoField
      FieldName = 'CustomData'
      Visible = False
      BlobType = ftWideMemo
    end
    object tblDetailsLastUpdated: TDateTimeField
      FieldName = 'LastUpdated'
      Visible = False
    end
    object tblDetailsForeignTotalLineAmount: TFloatField
      FieldName = 'ForeignTotalLineAmount'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblDetailsRelatedProductQty: TFloatField
      FieldName = 'RelatedProductQty'
      Visible = False
    end
    object tblDetailsIsFormulaRElatedProduct: TWideStringField
      FieldName = 'IsFormulaRElatedProduct'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsFormulaID: TIntegerField
      FieldName = 'FormulaID'
      Visible = False
    end
    object tblDetailsMatrixRef: TWideMemoField
      DisplayWidth = 10
      FieldName = 'MatrixRef'
      Visible = False
      BlobType = ftWideMemo
    end
    object tblDetailsProductPrintName: TWideStringField
      DisplayWidth = 20
      FieldName = 'ProductPrintName'
      Size = 255
    end
    object tblDetailsUOMQtyInStock: TFloatField
      FieldKind = fkCalculated
      FieldName = 'UOMQtyInStock'
      Calculated = True
    end
    object tblDetailsUOMQtyAvailable: TFloatField
      FieldKind = fkCalculated
      FieldName = 'UOMQtyAvailable'
      Calculated = True
    end
    object tblDetailsSalesTaxBasedon: TWideStringField
      FieldName = 'SalesTaxBasedon'
      Visible = False
      FixedChar = True
      Size = 2
    end
    object tblDetailsSalesLinesCustField1: TWideStringField
      FieldName = 'SalesLinesCustField1'
      Size = 255
    end
    object tblDetailsSalesLinesCustField2: TWideStringField
      FieldName = 'SalesLinesCustField2'
      Size = 255
    end
    object tblDetailsSalesLinesCustField3: TWideStringField
      FieldName = 'SalesLinesCustField3'
      Size = 255
    end
    object tblDetailsSalesLinesCustField4: TWideStringField
      FieldName = 'SalesLinesCustField4'
      Size = 255
    end
    object tblDetailsSalesLinesCustField5: TWideStringField
      FieldName = 'SalesLinesCustField5'
      Size = 255
    end
    object tblDetailsSalesLinesCustField6: TWideStringField
      FieldName = 'SalesLinesCustField6'
      Size = 255
    end
    object tblDetailsSalesLinesCustField7: TWideStringField
      FieldName = 'SalesLinesCustField7'
      Size = 255
    end
    object tblDetailsSalesLinesCustField8: TWideStringField
      FieldName = 'SalesLinesCustField8'
      Size = 255
    end
    object tblDetailsSalesLinesCustField9: TWideStringField
      FieldName = 'SalesLinesCustField9'
      Size = 255
    end
    object tblDetailsSalesLinesCustField10: TWideStringField
      FieldName = 'SalesLinesCustField10'
      Size = 255
    end
  end
  inherited cboClientLookup: TERPQuery
    SQL.Strings = (
      'SELECT ClientID, Company, '
      'Street, Street2, Street3, Suburb, State, Country, Postcode,'
      
        'BillStreet, BillStreet2, BillStreet3, BillSuburb, BillState, Bil' +
        'lPostcode,BillCountry,'
      'TERMS, ShippingMethod, ShippingID,RepID, TaxID'
      'FROM tblclients'
      'WHERE Active = '#39'T'#39
      'And Customer = '#39'T'#39' '
      'Order By Company')
    AutoCalcFields = False
    Left = 79
    Top = 381
    ParamData = <>
  end
  inherited cboEmployeeLookup: TERPQuery
    AutoCalcFields = False
    Left = 115
    Top = 382
  end
  inherited cboClassQry: TERPQuery
    Left = 153
    Top = 383
  end
  inherited qryClientLookup: TERPQuery
    SQL.Strings = (
      'Select Company, ClientId FROM tblclients C1'
      'WHERE C1.Active = "T"'
      'And C1.Customer = '#39'T'#39
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (C1.Company LIKE Concat(:SearchValue,"' +
        '%")))'
      
        'or ((:SearchMode = 2) and (C1.Company LIKE Concat("%",:SearchVal' +
        'ue,"%"))))'
      'and IfNull(:SearchValue,"") <> ""')
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
  end
  inherited imgPopup: TImageList
    Bitmap = {
      494C01010200A8009C0110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102009C00900110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryPayments: TERPQuery [33]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * From tblsalespayments'
      'WHERE SaleID = :xSaleID;'
      '')
    Left = 443
    Top = 384
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xSaleID'
      end>
    object qryPaymentsPaymentID: TAutoIncField
      FieldName = 'PaymentID'
      ReadOnly = True
    end
    object qryPaymentsPayMethod: TWideStringField
      DisplayLabel = 'Pay Method'
      DisplayWidth = 15
      FieldName = 'PayMethod'
      Size = 50
    end
    object qryPaymentsRef: TWideStringField
      DisplayLabel = 'Ref No'
      DisplayWidth = 15
      FieldName = 'Ref'
      Size = 45
    end
    object qryPaymentsAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
      currency = True
    end
    object qryPaymentsSaleID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleID'
      Visible = False
    end
    object qryPaymentsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryPaymentsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryPaymentsDeleted: TWideStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
  end
  object qryUnitOfMeasure: TERPQuery [34]
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
    Left = 476
    Top = 387
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
  object cboTermsQry: TERPQuery [35]
    SQL.Strings = (
      
        'SELECT tblTerms.TermsID, tblTerms.Terms, tblTerms.TermsAmount, t' +
        'blTerms.EOM, tblTerms.EOMPlus, tblTerms.Active '
      'FROM tblTerms '
      'WHERE (((tblTerms.Active)<>'#39'F'#39')) '
      'ORDER BY tblTerms.Terms; ')
    Left = 408
    Top = 385
    object cboTermsQryTermsAmount: TSmallintField
      FieldName = 'TermsAmount'
    end
    object cboTermsQryTerms: TWideStringField
      FieldName = 'Terms'
      Size = 50
    end
    object cboTermsQryTermsID: TAutoIncField
      FieldName = 'TermsID'
      ReadOnly = True
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
  object cboProductQry: TERPQuery [36]
    Connection = MyConnection
    SQL.Strings = (
      
        '################################################################' +
        '######'
      
        '#DUMMY QUERY - CASH.Formcreate dynamically changes the query for' +
        ' seach options '
      
        '################################################################' +
        '######'
      ''
      'SELECT'
      'if((LOCATE('#39'^'#39',p.PRODUCTGROUP,InStr(p.PRODUCTGROUP,'#39'^'#39')+1)) >0,'
      'MID(p.PRODUCTGROUP,LOCATE('#39'^'#39',p.PRODUCTGROUP,'
      'InStr(p.PRODUCTGROUP,'#39'^'#39')+1)+1,char_length(p.PRODUCTGROUP)-'
      
        'LOCATE('#39'^'#39',p.PRODUCTGROUP,InStr(p.PRODUCTGROUP,'#39'^'#39')+1)),  Null) ' +
        ' AS '#39'Manuf'#39'  ,'
      'MID(p.PRODUCTGROUP, InStr(p.PRODUCTGROUP,'#39'^'#39')+1 ,'
      'If(LOCATE('#39'^'#39',p.PRODUCTGROUP,'
      'InStr(p.PRODUCTGROUP,'#39'^'#39')+1) - InStr(p.PRODUCTGROUP,'#39'^'#39') >0,'
      'LOCATE('#39'^'#39',p.PRODUCTGROUP,'
      'InStr(p.PRODUCTGROUP,'#39'^'#39')+1)-1 - InStr(p.PRODUCTGROUP,'#39'^'#39'),'
      'IF(InStr(p.PRODUCTGROUP,'#39'^'#39')<>0,'
      
        'char_length(p.PRODUCTGROUP) - InStr(p.PRODUCTGROUP,'#39'^'#39'),0))) AS ' +
        #39'Type'#39' ,'
      'If(InStr(p.PRODUCTGROUP,'#39'^'#39') -1 >0,'
      'Left(p.PRODUCTGROUP,InStr(p.PRODUCTGROUP,'#39'^'#39')-1),'
      'p.PRODUCTGROUP)   AS '#39'Dept'#39','
      'SupplierProductCode,'
      'p.PARTSID,p.PARTTYPE, p.PRODUCTGROUP, p.PARTNAME,'
      'p.PARTSDESCRIPTION, p.INCOMEACCNT,'
      'p.ASSETACCNT, p.COGSACCNT, p.BARCODE, p.PRODUCTCODE,'
      'p.TAXCODE, p.Batch, p.AutoBatch, p.MultipleBins,'
      'p.SpecialDiscount, p.SNTracking,  p.BuyQTY1, p.BuyQTY2,'
      
        'p.BuyQTY3, p.COST1, p.COST2, p.COST3, p.SellQTY1, p.SellQTY2, p.' +
        'SellQTY3,'
      
        'p.PRICE1, p.PRICE2, p.PRICE3, p.WHOLESALEPRICE, p.Active, p.Edit' +
        'edFlag,AvgCost,'
      'p.Discontinued, p.LatestCost'
      'FROM tblparts p'
      'WHERE p.Active = '#39'T'#39
      'ORDER BY p.PARTNAME')
    AfterOpen = cboProductQryAfterOpen
    Options.LongStrings = False
    Left = 286
    Top = 385
    object cboProductQryPARTNAME: TWideStringField
      DisplayLabel = 'Part Name'
      DisplayWidth = 15
      FieldName = 'PARTNAME'
      Origin = 'tblparts.PARTNAME'
      Size = 60
    end
    object cboProductQryManuf: TWideStringField
      DisplayWidth = 15
      FieldName = 'Manuf'
      Origin = '.Manuf'
      Size = 255
    end
    object cboProductQryType: TWideStringField
      DisplayWidth = 15
      FieldName = 'Type'
      Origin = '.Type'
      Size = 255
    end
    object cboProductQryDept: TWideStringField
      DisplayWidth = 15
      FieldName = 'Dept'
      Origin = '.Dept'
      Size = 255
    end
    object cboProductQryActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblparts.Active'
      FixedChar = True
      Size = 1
    end
    object cboProductQryPARTSID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PARTSID'
      Origin = 'tblparts.PARTSID'
      Visible = False
    end
    object cboProductQryPARTTYPE: TWideStringField
      DisplayWidth = 13
      FieldName = 'PARTTYPE'
      Origin = 'tblparts.PARTTYPE'
      Visible = False
      Size = 13
    end
    object cboProductQryPRODUCTGROUP: TWideStringField
      DisplayWidth = 255
      FieldName = 'PRODUCTGROUP'
      Origin = 'tblparts.PRODUCTGROUP'
      Visible = False
      Size = 255
    end
    object cboProductQryINCOMEACCNT: TWideStringField
      DisplayWidth = 50
      FieldName = 'INCOMEACCNT'
      Origin = 'tblparts.INCOMEACCNT'
      Visible = False
      Size = 50
    end
    object cboProductQryASSETACCNT: TWideStringField
      DisplayWidth = 50
      FieldName = 'ASSETACCNT'
      Origin = 'tblparts.ASSETACCNT'
      Visible = False
      Size = 50
    end
    object cboProductQryCOGSACCNT: TWideStringField
      DisplayWidth = 50
      FieldName = 'COGSACCNT'
      Origin = 'tblparts.COGSACCNT'
      Visible = False
      Size = 50
    end
    object cboProductQryBARCODE: TWideStringField
      DisplayWidth = 35
      FieldName = 'BARCODE'
      Origin = 'tblparts.BARCODE'
      Visible = False
      Size = 35
    end
    object cboProductQryPRODUCTCODE: TWideStringField
      DisplayWidth = 11
      FieldName = 'PRODUCTCODE'
      Origin = 'tblparts.PRODUCTCODE'
      Visible = False
      Size = 11
    end
    object cboProductQryTAXCODE: TWideStringField
      DisplayWidth = 15
      FieldName = 'TAXCODE'
      Origin = 'tblparts.TAXCODE'
      Visible = False
      Size = 15
    end
    object cboProductQryBatch: TWideStringField
      DisplayWidth = 1
      FieldName = 'Batch'
      Origin = 'tblparts.Batch'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryAutoBatch: TWideStringField
      DisplayWidth = 1
      FieldName = 'AutoBatch'
      Origin = 'tblparts.AutoBatch'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryMultipleBins: TWideStringField
      DisplayWidth = 1
      FieldName = 'MultipleBins'
      Origin = 'tblparts.MultipleBins'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQrySpecialDiscount: TWideStringField
      DisplayWidth = 1
      FieldName = 'SpecialDiscount'
      Origin = 'tblparts.SpecialDiscount'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQrySNTracking: TWideStringField
      DisplayWidth = 1
      FieldName = 'SNTracking'
      Origin = 'tblparts.SNTracking'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryBuyQTY1: TIntegerField
      DisplayWidth = 10
      FieldName = 'BuyQTY1'
      Origin = 'tblparts.BuyQTY1'
      Visible = False
    end
    object cboProductQryBuyQTY2: TIntegerField
      DisplayWidth = 10
      FieldName = 'BuyQTY2'
      Origin = 'tblparts.BuyQTY2'
      Visible = False
    end
    object cboProductQryBuyQTY3: TIntegerField
      DisplayWidth = 10
      FieldName = 'BuyQTY3'
      Origin = 'tblparts.BuyQTY3'
      Visible = False
    end
    object cboProductQryCOST1: TFloatField
      DisplayWidth = 10
      FieldName = 'COST1'
      Origin = 'tblparts.COST1'
      Visible = False
    end
    object cboProductQryCOST2: TFloatField
      DisplayWidth = 10
      FieldName = 'COST2'
      Origin = 'tblparts.COST2'
      Visible = False
    end
    object cboProductQryCOST3: TFloatField
      DisplayWidth = 10
      FieldName = 'COST3'
      Origin = 'tblparts.COST3'
      Visible = False
    end
    object cboProductQrySellQTY1: TIntegerField
      DisplayWidth = 10
      FieldName = 'SellQTY1'
      Origin = 'tblparts.SellQTY1'
      Visible = False
    end
    object cboProductQrySellQTY2: TIntegerField
      DisplayWidth = 10
      FieldName = 'SellQTY2'
      Origin = 'tblparts.SellQTY2'
      Visible = False
    end
    object cboProductQrySellQTY3: TIntegerField
      DisplayWidth = 10
      FieldName = 'SellQTY3'
      Origin = 'tblparts.SellQTY3'
      Visible = False
    end
    object cboProductQryPRICE1: TFloatField
      DisplayWidth = 10
      FieldName = 'PRICE1'
      Origin = 'tblparts.PRICE1'
      Visible = False
    end
    object cboProductQryPRICE2: TFloatField
      DisplayWidth = 10
      FieldName = 'PRICE2'
      Origin = 'tblparts.PRICE2'
      Visible = False
    end
    object cboProductQryPRICE3: TFloatField
      DisplayWidth = 10
      FieldName = 'PRICE3'
      Origin = 'tblparts.PRICE3'
      Visible = False
    end
    object cboProductQryWHOLESALEPRICE: TFloatField
      DisplayWidth = 10
      FieldName = 'WHOLESALEPRICE'
      Origin = 'tblparts.WHOLESALEPRICE'
      Visible = False
    end
    object cboProductQryEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Origin = 'tblparts.EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryAvgCost: TFloatField
      DisplayWidth = 10
      FieldName = 'AvgCost'
      Origin = 'tblparts.AvgCost'
      Visible = False
    end
    object cboProductQryDiscontinued: TWideStringField
      DisplayWidth = 1
      FieldName = 'Discontinued'
      Origin = 'tblparts.Discontinued'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryLatestCost: TFloatField
      DisplayWidth = 10
      FieldName = 'LatestCost'
      Visible = False
    end
    object cboProductQrySupplierProductCode: TWideStringField
      FieldName = 'SupplierProductCode'
      Size = 50
    end
    object cboProductQryPARTSDESCRIPTION: TWideStringField
      FieldName = 'PARTSDESCRIPTION'
    end
  end
  object cboAccountQry: TERPQuery [37]
    SQL.Strings = (
      'SELECT AccountID, AccountName,tblacctypedesc.AccDesc AS Type '
      'FROM tblchartofaccounts'
      
        'LEFT JOIN tblacctypedesc ON tblacctypedesc.AccType = tblchartofa' +
        'ccounts.AccountType'
      
        'WHERE (AccountType = '#39'AR'#39' or AccountType = '#39'OCASSET'#39' OR AccountT' +
        'ype = '#39'BANK'#39') and Active='#39'T'#39
      'And IsHeader = '#39'F'#39
      'ORDER BY AccountType,AccountName;')
    Options.LongStrings = False
    Left = 190
    Top = 383
  end
  object DSPayments: TDataSource [38]
    DataSet = qryPayments
    Left = 444
    Top = 416
  end
  inherited cbTaxCodeQry: TERPQuery [41]
  end
  inherited qryMemTrans: TERPQuery [42]
    Left = 376
    Top = 384
  end
  inherited SaveDialog1: TSaveDialog [43]
  end
  inherited QryCustomField: TERPQuery [44]
  end
  inherited ProgressDialogOBJ: TProgressDialog [45]
  end
  inherited mnuBusobjProperties: TAdvPopupMenu [46]
  end
end
