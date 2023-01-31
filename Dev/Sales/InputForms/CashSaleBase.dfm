inherited CashSaleBaseGUI: TCashSaleBaseGUI
  Left = 282
  Top = 121
  HelpContext = 58000
  Caption = 'Cash Sale'
  ClientHeight = 564
  ExplicitLeft = 282
  ExplicitTop = 121
  ExplicitHeight = 603
  DesignSize = (
    827
    564)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 443
    ExplicitTop = 443
  end
  inherited imgGridWatermark: TImage
    HelpContext = 58001
  end
  inherited pnlDetail: TDNMPanel
    Top = 233
    Height = 210
    HelpContext = 58079
    Align = alClient
    ExplicitTop = 233
    ExplicitHeight = 210
    inherited grdTransactions: TwwDBGrid
      Height = 210
      HelpContext = 58081
      ControlType.Strings = (
        'ProductName;CustomEdit;cboProductR;F'
        'LineTaxCode;CustomEdit;cboTaxCode;F'
        'UnitofMeasureSaleLines;CustomEdit;cboUnitOfMeasure;F'
        'SearchFilter;CustomEdit;txtSearchFilter;T'
        'HireQty;CustomEdit;edtHireQty;F')
      Selected.Strings = (
        'PartBarcode'#9'10'#9'Barcode'
        'ProductName'#9'20'#9'Name'
        'UnitofMeasureSaleLines'#9'10'#9'UOM'
        'UnitofMeasureShipped'#9'10'#9'Shipped'
        'PQA'#9'1'#9'Allocation'
        'Product_Description'#9'20'#9'Description'
        'CalcGrossProfitPercentInc'#9'10'#9'CalcGrossProfitPercentInc'
        'LatestCostPriceInc'#9'10'#9'LatestCostPriceInc'
        'LinePriceInc'#9'10'#9'Amount (Inc)'
        'LineTaxCode'#9'5'#9'Code'
        'LineTax'#9'10'#9'Tax'
        'Discounts'#9'8'#9'Discounts'
        'TotalLineAmountInc'#9'10'#9'TotalLineAmountInc'
        'MatrixDesc'#9'10'#9'Matrix Details'
        'MatrixPrice'#9'10'#9'Matrix Price')
      MemoAttributes = [mSizeable, mWordWrap, mGridShow]
      ExplicitHeight = 210
    end
    inherited cboTaxCode: TERPDbLookupCombo
      Left = 284
      Top = 33
      ExplicitLeft = 284
      ExplicitTop = 33
    end
    inherited cboUnitOfMeasure: TwwDBLookupCombo
      Left = 193
      Top = 31
      ExplicitLeft = 193
      ExplicitTop = 31
    end
    inherited txtSearchFilter: TwwDBEdit
      Left = 352
      Top = 33
      ExplicitLeft = 352
      ExplicitTop = 33
    end
    inherited cboProductR: TERPDbLookupCombo
      Top = 31
      OnKeyDown = nil
      ExplicitTop = 31
    end
  end
  inherited pnlFooter: TDNMPanel
    Top = 443
    Height = 121
    HelpContext = 58002
    Align = alBottom
    ExplicitTop = 443
    ExplicitHeight = 121
    DesignSize = (
      827
      121)
    inherited lblComments: TLabel
      Left = 11
      Top = 14
      HelpContext = 58004
      ExplicitLeft = 11
      ExplicitTop = 7
    end
    inherited Label142: TLabel
      Top = 39
      HelpContext = 58005
      ExplicitTop = 39
    end
    inherited Label54: TLabel
      Top = 68
      HelpContext = 58006
      ExplicitTop = 68
    end
    inherited Label56: TLabel
      Top = 98
      HelpContext = 58007
      ExplicitTop = 98
    end
    inherited lblBaseForeignTotal: TLabel
      HelpContext = 58011
      ExplicitTop = 74
    end
    inherited Label122: TLabel
      Left = 467
      Top = 68
      HelpContext = 58018
      ExplicitLeft = 467
      ExplicitTop = 68
    end
    inherited Label3: TLabel
      Left = 467
      Top = 39
      HelpContext = 58019
      ExplicitLeft = 467
      ExplicitTop = 39
    end
    object Label93: TLabel [7]
      Left = 7
      Top = 73
      Width = 74
      Height = 31
      HelpContext = 58024
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
    object Label101: TLabel [8]
      Left = 321
      Top = 100
      Width = 57
      Height = 15
      HelpContext = 58025
      Caption = 'Con. &Note:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    inherited pnlComments: TDNMPanel
      HelpContext = 58082
      TabOrder = 13
      inherited txtComments: TDBMemo
        HelpContext = 58013
        OnExit = txtCommentsExit
      end
    end
    inherited txtSubTotal: TDBEdit
      Top = 36
      HelpContext = 58014
      TabOrder = 6
      ExplicitTop = 36
    end
    inherited txtTotalTax: TDBEdit
      Top = 65
      HelpContext = 58015
      TabOrder = 5
      ExplicitTop = 65
    end
    inherited txtTotalAmount: TDBEdit
      Top = 94
      HelpContext = 58016
      TabOrder = 10
      ExplicitTop = 94
    end
    inherited edtBaseForeignTotal: TDBEdit
      HelpContext = 58017
      TabOrder = 4
    end
    inherited lblDisableCalc: TDNMSpeedButton
      Left = 715
      Top = 3
      TabOrder = 11
      ExplicitLeft = 715
      ExplicitTop = 3
    end
    inherited DNMPanel5: TDNMPanel
      Height = 94
      HelpContext = 58083
      ExplicitHeight = 94
      inherited lblEnteredAt: TDBText
        DataField = 'EnteredAtShort'
      end
    end
    inherited lblEmail: TDNMPanel
      Left = 583
      Top = 3
      HelpContext = 58084
      ExplicitLeft = 583
      ExplicitTop = 3
    end
    inherited pnlProcessMessage: TDNMPanel
      HelpContext = 58085
      inherited lblProcessMessage: TLabel
        HelpContext = 58080
        ExplicitWidth = 747
      end
    end
    inherited txtTotalDiscount: TDBEdit
      Left = 559
      Top = 36
      HelpContext = 58022
      TabOrder = 2
      ExplicitLeft = 559
      ExplicitTop = 36
    end
    inherited txtTotalMarkup: TDBEdit
      Left = 559
      Top = 65
      HelpContext = 58023
      TabOrder = 3
      ExplicitLeft = 559
      ExplicitTop = 65
    end
    object txtPickMemo: TDBMemo
      Left = 77
      Top = 69
      Width = 238
      Height = 36
      Hint = '"Type In A Comment For The Warehouse"'
      HelpContext = 58026
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
      TabOrder = 0
    end
    object txtConNote: TDBEdit
      Left = 386
      Top = 96
      Width = 113
      Height = 23
      HelpContext = 58027
      DataField = 'ConNote'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnEnter = txtConNoteEnter
      OnExit = txtConNoteExit
    end
    object btnAddDate: TDNMSpeedButton
      Left = 11
      Top = 30
      Width = 64
      Height = 15
      HelpContext = 58086
      Caption = 'Add Date'
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      AutoDisableParentOnclick = True
      OnClick = btnAddDateClick
    end
  end
  inherited pnlHeader: TDNMPanel
    Height = 233
    HelpContext = 58028
    ParentColor = True
    ExplicitHeight = 233
    DesignSize = (
      827
      233)
    object Bevel3: TBevel [0]
      Left = 256
      Top = 52
      Width = 462
      Height = 51
      HelpContext = 58064
      Shape = bsFrame
    end
    inherited Bevel2: TBevel
      Left = 247
      Top = 152
      Width = 201
      HelpContext = 58087
      ExplicitLeft = 247
      ExplicitTop = 152
      ExplicitWidth = 201
    end
    inherited Bevel1: TBevel
      Left = 485
      Top = 106
      Height = 109
      HelpContext = 58059
      ExplicitLeft = 485
      ExplicitTop = 106
      ExplicitHeight = 109
    end
    inherited lblStatus: TLabel
      Top = 213
      Width = 37
      HelpContext = 58088
      AutoSize = True
      ExplicitTop = 213
      ExplicitWidth = 37
    end
    inherited Label38: TLabel
      Left = 7
      Top = 52
      HelpContext = 58029
      ExplicitLeft = 7
      ExplicitTop = 52
    end
    inherited lblClientDetails: TLabel
      Left = 7
      Top = 96
      HelpContext = 58030
      Caption = 'Sold To'
      ExplicitLeft = 7
      ExplicitTop = 96
    end
    inherited SaleDate_Label: TLabel
      Left = 261
      Top = 55
      HelpContext = 58031
      ExplicitLeft = 261
      ExplicitTop = 55
    end
    inherited Label160: TLabel
      Left = 633
      Top = 55
      HelpContext = 58032
      Caption = 'Invoice No'
      ExplicitLeft = 633
      ExplicitTop = 55
    end
    inherited ClassLabel: TLabel
      Left = 252
      Top = 158
      ExplicitLeft = 252
      ExplicitTop = 158
    end
    inherited Label43: TLabel
      Left = 493
      HelpContext = 58061
      ExplicitLeft = 493
    end
    inherited lblAccount: TLabel
      Left = 9
      Top = 6
      HelpContext = 58062
      ExplicitLeft = 9
      ExplicitTop = 6
    end
    inherited lblPaymentMethod: TLabel
      Left = 493
      HelpContext = 58063
      ExplicitLeft = 493
    end
    inherited Label48: TLabel
      Left = 385
      Width = 79
      HelpContext = 58033
      Caption = 'Employee'
      ExplicitLeft = 385
      ExplicitWidth = 79
    end
    inherited lblInvoice: TLabel
      Left = 634
      HelpContext = 58065
      ExplicitLeft = 634
    end
    inherited lbMemTrans: TLabel
      Left = 580
      Top = 7
      HelpContext = 58034
      ExplicitLeft = 580
      ExplicitTop = 7
    end
    inherited Label79: TLabel
      Left = 87
      Top = 137
      Width = 31
      HelpContext = 58066
      ExplicitLeft = 87
      ExplicitTop = 137
      ExplicitWidth = 31
    end
    inherited Label45: TLabel
      Left = 24
      Top = 137
      Width = 47
      HelpContext = 58067
      ExplicitLeft = 24
      ExplicitTop = 137
      ExplicitWidth = 47
    end
    inherited lblBaseForeignCurrencyCode: TLabel
      Left = 154
      Top = 134
      HelpContext = 58035
      ExplicitLeft = 154
      ExplicitTop = 134
    end
    inherited lblBaseExchangeRate: TLabel
      Left = 95
      Top = 134
      HelpContext = 58036
      ExplicitLeft = 95
      ExplicitTop = 134
    end
    inherited lblRedeemPoints: TLabel
      Left = 153
      Top = 96
      Height = 16
      HelpContext = 58089
      Alignment = taRightJustify
      ExplicitLeft = 153
      ExplicitTop = 96
      ExplicitHeight = 16
    end
    object Label444: TLabel [20]
      Left = 509
      Top = 55
      Width = 87
      Height = 18
      HelpContext = 58035
      AutoSize = False
      Caption = 'Till'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    inherited Label4: TLabel
      Left = 471
      Top = 213
      Visible = False
      ExplicitLeft = 471
      ExplicitTop = 213
    end
    inherited imgSearch: TImage
      Left = 201
      Top = 2
      ExplicitLeft = 201
      ExplicitTop = 2
    end
    object cmdPrintPick: TDNMSpeedButton [23]
      Left = 731
      Top = 196
      Width = 87
      Height = 27
      HelpContext = 58077
      Action = actPick
      Anchors = [akTop, akRight]
      Caption = 'Print Pic&k'
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
      TabOrder = 18
      TabStop = False
      AutoDisableParentOnclick = True
    end
    object btnDelDocket: TDNMSpeedButton [24]
      Left = 20
      Top = 125
      Width = 87
      Height = 27
      HelpContext = 58078
      Action = actDelDocket
      Caption = '&Del Docket'
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
      TabOrder = 33
      TabStop = False
      AutoDisableParentOnclick = True
    end
    inherited cboCurrentTransStatus: TwwDBLookupCombo
      Left = 291
      Top = 209
      Width = 157
      HelpContext = 58090
      TabOrder = 31
      ExplicitLeft = 291
      ExplicitTop = 209
      ExplicitWidth = 157
    end
    inherited txtClientDetails: TDBMemo
      Left = 7
      Height = 103
      HelpContext = 58039
      TabOrder = 2
      ExplicitLeft = 7
      ExplicitHeight = 103
    end
    inherited cboCreationDate: TwwDBDateTimePicker
      Left = 261
      Top = 71
      HelpContext = 58040
      TabOrder = 3
      UnboundDataType = wwDTEdtDate
      ExplicitLeft = 261
      ExplicitTop = 71
    end
    inherited cboClass: TwwDBLookupCombo
      Left = 252
      Top = 177
      TabOrder = 7
      ExplicitLeft = 252
      ExplicitTop = 177
    end
    inherited txtPONumber: TDBEdit
      Left = 495
      Top = 180
      HelpContext = 58069
      ExplicitLeft = 495
      ExplicitTop = 180
    end
    inherited cboAccount: TwwDBLookupCombo
      Left = 9
      Top = 23
      HelpContext = 58070
      TabOrder = 0
      ExplicitLeft = 9
      ExplicitTop = 23
    end
    inherited txtCustomID: TDBEdit
      Left = 633
      Top = 71
      HelpContext = 58041
      TabOrder = 6
      ExplicitLeft = 633
      ExplicitTop = 71
    end
    inherited cboEmployee: TwwDBLookupCombo
      Left = 385
      Top = 71
      Width = 116
      HelpContext = 58042
      DropDownWidth = 40
      ExplicitLeft = 385
      ExplicitTop = 71
      ExplicitWidth = 116
    end
    inherited btnNext: TDNMSpeedButton
      Left = 731
      Top = 10
      HelpContext = 58043
      Caption = '&New'
      Font.Height = -12
      ExplicitLeft = 731
      ExplicitTop = 10
    end
    inherited btnCompleted: TDNMSpeedButton
      Left = 731
      Top = 43
      HelpContext = 58044
      Caption = '&Save'
      Font.Height = -12
      TabOrder = 14
      ExplicitLeft = 731
      ExplicitTop = 43
    end
    inherited btnClose: TDNMSpeedButton
      Left = 731
      Top = 81
      HelpContext = 58045
      Font.Height = -12
      TabOrder = 29
      ExplicitLeft = 731
      ExplicitTop = 81
    end
    inherited btnPreview: TDNMSpeedButton
      Left = 731
      Top = 119
      HelpContext = 58046
      Font.Height = -12
      TabOrder = 16
      ExplicitLeft = 731
      ExplicitTop = 119
    end
    inherited btnPrint: TDNMSpeedButton
      Left = 731
      Top = 157
      HelpContext = 58047
      Caption = 'Prin&t'
      Font.Height = -12
      TabOrder = 17
      ExplicitLeft = 731
      ExplicitTop = 157
    end
    inherited pnlChooseRpt: TDNMPanel
      Top = 121
      HelpContext = 58091
      TabOrder = 26
      ExplicitTop = 121
    end
    inherited btnContacts: TDNMSpeedButton
      Top = 68
      HelpContext = 58051
      ExplicitTop = 68
    end
    inherited cboBaseForeignCurrencyCode: TwwDBLookupCombo
      Left = 124
      Top = 129
      HelpContext = 58053
      TabOrder = 27
      ExplicitLeft = 124
      ExplicitTop = 129
    end
    inherited edtBaseExchangeRate: TwwDBEdit
      Left = 124
      Top = 158
      HelpContext = 58054
      TabOrder = 30
      ExplicitLeft = 124
      ExplicitTop = 158
    end
    inherited pnlTitle: TDNMPanel
      Left = 263
      Width = 300
      HelpContext = 58056
      Caption = 'Cash Sale'
      TabOrder = 23
      ExplicitLeft = 263
      ExplicitWidth = 300
      inherited TitleShader: TShader
        Width = 298
        HelpContext = 58057
        ExplicitWidth = 298
        inherited TitleLabel: TLabel
          Width = 298
          HelpContext = 58058
          Caption = 'Cash Sale'
          ExplicitWidth = 171
        end
      end
    end
    inherited cboClientR: TERPDbLookupCombo
      Left = 7
      Top = 68
      Width = 202
      HelpContext = 58092
      Selected.Strings = (
        'Company'#9'45'#9'Company'#9'F')
      TabOrder = 1
      ExplicitLeft = 7
      ExplicitTop = 68
      ExplicitWidth = 202
    end
    inherited btnPayments: TDNMSpeedButton
      Left = 569
      Top = 22
      HelpContext = 58082
      TabOrder = 20
      ExplicitLeft = 569
      ExplicitTop = 22
    end
    inherited cmdEmail: TDNMSpeedButton
      TabOrder = 15
    end
    inherited btnPDF: TDNMSpeedButton
      TabOrder = 32
    end
    inherited btnEdit: TDNMSpeedButton
      TabOrder = 28
    end
    inherited cboPaymentMethod: TwwDBLookupCombo
      Left = 491
      HelpContext = 58071
      ExplicitLeft = 491
    end
    inherited btnSplit: TDNMSpeedButton
      Left = 616
      Top = 133
      HelpContext = 58072
      Caption = 'Split &Pay'
      ExplicitLeft = 616
      ExplicitTop = 133
    end
    inherited chkInvoice: TCheckBox
      Left = 616
      Top = 114
      HelpContext = 58073
      TabOrder = 8
      ExplicitLeft = 616
      ExplicitTop = 114
    end
    inherited cboTerms: TwwDBLookupCombo
      Left = 76
      Top = 175
      Width = 61
      HelpContext = 58074
      TabOrder = 21
      ExplicitLeft = 76
      ExplicitTop = 175
      ExplicitWidth = 61
    end
    inherited cboDueDate: TwwDBDateTimePicker
      Left = 20
      Top = 161
      Width = 61
      HelpContext = 58075
      TabOrder = 22
      ExplicitLeft = 20
      ExplicitTop = 161
      ExplicitWidth = 61
    end
    inherited btnCashDrawer: TDNMSpeedButton
      Left = 617
      HelpContext = 58076
      ExplicitLeft = 617
    end
    inherited btnDeposit: TDNMSpeedButton
      Left = 569
      Top = 22
      TabOrder = 25
      OnClick = btnDepositClick
      ExplicitLeft = 569
      ExplicitTop = 22
    end
    inherited wwDBDateTimePicker1: TwwDBDateTimePicker
      Left = 536
      Top = 209
      TabOrder = 24
      Visible = False
      ExplicitLeft = 536
      ExplicitTop = 209
    end
    object cboTillName: TwwDBLookupCombo
      Left = 509
      Top = 71
      Width = 116
      Height = 23
      HelpContext = 58053
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'TillName'#9'30'#9'Till'#9'F'
        'ComputerName'#9'20'#9'Computer'#9'F')
      DataField = 'TillName'
      DataSource = DSMaster
      LookupTable = qryTills
      LookupField = 'TillName'
      ParentFont = False
      TabOrder = 5
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboBaseForeignCurrencyCodeCloseUp
    end
  end
  inherited qryPayMethod: TERPQuery
    Left = 271
    Top = 363
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 167
    Top = 5
  end
  inherited DSDetails: TDataSource
    Top = 395
  end
  inherited DSMaster: TDataSource
    Left = 7
    Top = 395
  end
  inherited lsTDNMSpeedButtonActions: TActionList
    object actPick: TAction [5]
      Caption = 'Print Pic&k'
      HelpContext = 58093
      OnExecute = actPickExecute
      OnUpdate = actPickUpdate
    end
    object actDelDocket: TAction [6]
      Caption = 'Del Do&cket'
      Enabled = False
      HelpContext = 58094
      Visible = False
      OnExecute = actDelDocketExecute
    end
  end
  inherited popDscntMrkup: TAdvPopupMenu
    Left = 580
    Top = 363
  end
  inherited popMemTrans: TAdvPopupMenu
    Left = 669
    Top = 363
  end
  inherited tblMaster: TERPQuery
    Left = 7
    Top = 363
    inherited tblMasterComments: TWideMemoField
      OnSetText = tblMasterCommentsSetText
    end
    object tblMasterSaleDateTime: TDateTimeField [88]
      FieldName = 'SaleDateTime'
    end
    object tblMasterTillName: TStringField [89]
      FieldKind = fkLookup
      FieldName = 'TillName'
      LookupDataSet = qryTills
      LookupKeyFields = 'TillId'
      LookupResultField = 'TillName'
      KeyFields = 'TillID'
      Size = 255
      Lookup = True
    end
  end
  inherited tblDetails: TERPQuery
    Top = 363
    inherited tblDetailsCalcGrossProfitPercentInc: TFloatField
      DisplayFormat = '0.0%'
    end
    inherited tblDetailsLineTaxCode: TWideStringField [9]
      DisplayWidth = 5
    end
    inherited tblDetailsLineTax: TFloatField [10]
      DisplayLabel = 'Tax'
    end
    inherited tblDetailsDiscounts: TFloatField [11]
    end
    inherited tblDetailsTotalLineAmountInc: TFloatField [12]
    end
    inherited tblDetailsMatrixDesc: TWideMemoField [13]
      DisplayLabel = 'Matrix Details'
    end
    inherited tblDetailsMatrixPrice: TFloatField [14]
      DisplayLabel = 'Matrix Price'
    end
    object tblDetailsIsQuote: TWideStringField [15]
      DisplayWidth = 1
      FieldName = 'IsQuote'
      Visible = False
      FixedChar = True
      Size = 1
    end
    inherited tblDetailsDiscountedPriceInc: TFloatField [16]
      Visible = False
    end
    inherited tblDetailsDiscountedPrice: TFloatField [17]
    end
    inherited tblDetailsTotalDiscountedPriceInc: TFloatField [18]
      Visible = False
    end
    inherited tblDetailsTotalDiscountedPrice: TFloatField [19]
    end
    inherited tblDetailsFormulaQtySoldValue1: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtySoldValue2: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtySoldValue3: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtySoldValue4: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtySoldValue5: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue1: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue2: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue3: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue4: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue5: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtySoldValue: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue: TFloatField
      Visible = False
    end
    inherited tblDetailsISVoucher: TWideStringField
      Visible = False
    end
    inherited tblDetailsVoucherNo: TWideStringField
      Visible = False
    end
    inherited tblDetailsISContainer: TWideStringField
      Visible = False
    end
    inherited tblDetailsIsPallet: TWideStringField
      Visible = False
    end
    inherited tblDetailsArea: TWideStringField
      Visible = False
    end
    inherited tblDetailsAreaQty: TFloatField
      Visible = False
    end
    inherited tblDetailsLinePrice: TFloatField
      OnSetText = FeldSetTextDontAllowNulls
    end
    inherited tblDetailsProductPrintName: TWideStringField
      Visible = False
    end
    inherited tblDetailsUOMQtyInStock: TFloatField
      DisplayLabel = 'Qty In Stock'
      Visible = False
    end
    inherited tblDetailsUOMQtyAvailable: TFloatField
      DisplayLabel = 'Qty Available'
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField1: TWideStringField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField2: TWideStringField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField3: TWideStringField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField4: TWideStringField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField5: TWideStringField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField6: TWideStringField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField7: TWideStringField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField8: TWideStringField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField9: TWideStringField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField10: TWideStringField
      Visible = False
    end
  end
  inherited cboClientLookup: TERPQuery
    SQL.Strings = (
      'SELECT ClientID, Company, '
      'Street, Street2, Street3, Suburb, State, Country, Postcode,'
      
        'BillStreet, BillStreet2, BillStreet3, BillSuburb, BillState, Bil' +
        'lPostcode,BillCountry,'
      
        'TERMS, ShippingMethod, ShippingID,RepID, TaxID, WarrantyFinishDa' +
        'te, IsJob'
      'FROM tblclients'
      'WHERE Customer = '#39'T'#39' '
      'AND tblclients.ClientID= :xClientID'
      'Order By Company')
    Left = 624
    Top = 363
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientID'
      end>
  end
  inherited cboEmployeeLookup: TERPQuery
    Left = 139
    Top = 363
  end
  inherited cboClassQry: TERPQuery
    Left = 183
    Top = 363
  end
  inherited qryBaseForeignCurrency: TERPQuery
    Left = 492
    Top = 363
  end
  inherited qryClientLookup: TERPQuery
    Left = 424
    Top = 136
    inherited qryClientLookupCompany: TWideStringField
      DisplayWidth = 45
    end
  end
  inherited imgPopup: TImageList
    Bitmap = {
      494C01010200BC00F00010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited DataState: TDataState
    Left = 167
    Top = 29
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C01010200C000F40010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited qryPayments: TERPQuery
    Left = 95
    Top = 363
  end
  inherited qryUnitOfMeasure: TERPQuery
    Left = 536
    Top = 363
  end
  inherited cboTermsQry: TERPQuery
    Left = 448
    Top = 363
  end
  inherited cboAccountQry: TERPQuery
    SQL.Strings = (
      'SELECT AccountID, AccountName,tblacctypedesc.AccDesc AS Type '
      'FROM tblchartofaccounts'
      
        'LEFT JOIN tblacctypedesc ON tblacctypedesc.AccType = tblchartofa' +
        'ccounts.AccountType'
      'WHERE (AccountType = '#39'OCASSET'#39' ) and Active='#39'T'#39
      'AND IsHeader = '#39'F'#39
      'ORDER BY AccountType,AccountName;')
    Left = 227
    Top = 363
  end
  inherited DSPayments: TDataSource
    Left = 95
    Top = 395
  end
  inherited qryMemTrans: TERPQuery
    Left = 404
    Top = 363
  end
  object qryTills: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT TillID, TillName, ComputerName'
      'FROM tblPOSTills WHERE Active = '#39'T'#39)
    Left = 408
    Top = 104
  end
end
