inherited SalesOrderGUI: TSalesOrderGUI
  Left = 133
  Top = 213
  HelpContext = 480000
  ActiveControl = cboShipDate
  Caption = 'Sales Order'
  ClientHeight = 569
  ClientWidth = 996
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 1002
  ExplicitHeight = 598
  DesignSize = (
    996
    569)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 419
    Width = 996
    HelpContext = 480128
    ExplicitTop = 414
    ExplicitWidth = 996
  end
  inherited shapehint: TShape
    Left = 12
    ExplicitLeft = 12
  end
  inherited imgGridWatermark: TImage
    HelpContext = 480001
  end
  inherited shapehintextra1: TShape
    Left = 56
    ExplicitLeft = 56
  end
  inherited pnlDetail: TDNMPanel
    Top = 265
    Width = 996
    Height = 154
    HelpContext = 480125
    Align = alClient
    ExplicitTop = 265
    ExplicitWidth = 996
    ExplicitHeight = 154
    inherited grdTransactions: TwwDBGrid
      Width = 996
      Height = 137
      HelpContext = 480127
      ControlType.Strings = (
        'ProductName;CustomEdit;cboProductR;F'
        'LineTaxCode;CustomEdit;cboTaxCode;F'
        'UnitofMeasureSaleLines;CustomEdit;cboUnitOfMeasure;F'
        'ForeignExchangeSellCode;CustomEdit;cboForeignCurrencyCode;T'
        'Supplier;CustomEdit;cboSupplier;F'
        'SearchFilter;CustomEdit;txtSearchFilter;T'
        'CostCentreName;CustomEdit;cboCostCentre;F'
        'SpecDescription;CustomEdit;cboPartSpecs;F'
        'SmartOrderCreated;CheckBox;T;F'
        'AutoSmartOrder;CheckBox;T;F'
        'ProviderNum;CustomEdit;cboPrescriber;T'
        'ShipContainerETA;CustomEdit;dtShipETA;T'
        'MemoLine;CustomEdit;edtMemoLine;F'
        'Area;CustomEdit;cboLinesAreaCode;F'
        'RequiresAssembly;CheckBox;T;F'
        'Assembled;CheckBox;T;F')
      Selected.Strings = (
        'SeqNo'#9'6'#9'No'#9#9
        'ProductName'#9'17'#9'Product'#9#9
        'UnitofMeasureSaleLines'#9'10'#9'Units'#9#9
        'UnitofMeasureQtySold'#9'6'#9'Ordered'#9#9
        'UnitofMeasureShipped'#9'6'#9'Shipped'#9#9
        'PQA'#9'1'#9'Allocation'#9#9
        'UnitofMeasureBackorder'#9'6'#9'BO'#9#9
        'Product_Description'#9'20'#9'Description'#9#9
        'LineCostInc'#9'10'#9'Cost (Inc)'#9#9
        'LineTaxCode'#9'15'#9'Code'#9#9
        'LineTax'#9'10'#9'Tax (Dbl Click)'#9#9
        'LinePriceInc'#9'10'#9'Price (Inc)'#9#9
        'TotalLineAmountInc'#9'14'#9'Amount (Inc)'#9#9
        'CalcProfit'#9'10'#9'Profit (Inc)'#9#9
        'CalcProfitPercent'#9'7'#9'% Profit (Inc)'#9#9
        'CalcGrossProfitPercentInc'#9'10'#9'GP %'#9#9
        'LatestCostPriceInc'#9'10'#9'Latest Cost (Inc)'#9#9
        'ShipDate'#9'18'#9'Ship Date'#9#9
        'SmartOrderCreated'#9'1'#9'Ordered?'#9#9)
      IniAttributes.Delimiter = ''
      PaintOptions.BackgroundOptions = [coBlendFixedRow, coBlendAlternatingRow]
      ExplicitWidth = 996
      ExplicitHeight = 137
    end
    inherited cboTaxCode: TERPDbLookupCombo
      Left = 108
      Top = 4
      TabOrder = 2
      ExplicitLeft = 108
      ExplicitTop = 4
    end
    inherited cboUnitOfMeasure: TwwDBLookupCombo
      Left = 796
      Top = 2
      TabOrder = 3
      ExplicitLeft = 796
      ExplicitTop = 2
    end
    inherited cboSupplier: TERPDbLookupCombo
      Left = 395
      Top = 2
      TabOrder = 4
      ExplicitLeft = 395
      ExplicitTop = 2
    end
    inherited cboCostCentre: TwwDBLookupCombo
      Left = 267
      Top = 2
      TabOrder = 5
      ExplicitLeft = 267
      ExplicitTop = 2
    end
    inherited cboPartSpecs: TwwDBLookupCombo
      Left = 695
      Top = 2
      TabOrder = 6
      ExplicitLeft = 695
      ExplicitTop = 2
    end
    inherited cboProductR: TERPDbLookupCombo
      Left = 40
      Top = 2
      Selected.Strings = (
        'PARTNAME'#9'15'#9'Product Name'#9'F'
        'Manuf'#9'15'#9'Manuf'#9'F'
        'Type'#9'15'#9'Type'#9'F'
        'Dept'#9'15'#9'Dept'#9'F'
        'PartsDescription'#9'35'#9'Description'#9'F'
        'Active'#9'1'#9'Active'#9'F'
        'PreferedSupp'#9'20'#9'Preferred Supplier'#9'F'
        'SupplierProductCode'#9'20'#9'Supplier Product Code'#9'F')
      TabOrder = 11
      ExplicitLeft = 40
      ExplicitTop = 2
    end
    object dtShipETA: TwwDBDateTimePicker [7]
      Left = 568
      Top = 2
      Width = 121
      Height = 26
      HelpContext = 480165
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'ShipContainerETA'
      DataSource = DSDetails
      Epoch = 1950
      ShowButton = True
      TabOrder = 10
      OnDblClick = grdTransactionsDblClick
    end
    inherited ProgressBar: TProgressBar
      Top = 137
      Width = 996
      Height = 17
      HelpContext = 480166
      TabOrder = 1
      ExplicitTop = 137
      ExplicitWidth = 996
      ExplicitHeight = 17
    end
  end
  inherited pnlFooter: TDNMPanel
    Top = 419
    Width = 996
    Height = 150
    HelpContext = 480002
    Align = alBottom
    ExplicitTop = 419
    ExplicitWidth = 996
    ExplicitHeight = 150
    DesignSize = (
      996
      150)
    inherited lblComments: TLabel
      Top = 5
      HelpContext = 480004
      ExplicitTop = 5
    end
    inherited Label142: TLabel
      Left = 823
      Top = 8
      HelpContext = 480005
      ExplicitLeft = 779
      ExplicitTop = 8
    end
    inherited Label54: TLabel
      Left = 824
      Top = 37
      HelpContext = 480006
      ExplicitLeft = 780
      ExplicitTop = 37
    end
    inherited Label93: TLabel
      Top = 77
      HelpContext = 480018
      ExplicitTop = 77
    end
    inherited Label56: TLabel
      Left = 817
      Top = 67
      HelpContext = 480007
      ExplicitLeft = 773
      ExplicitTop = 67
    end
    inherited Label122: TLabel
      Left = 639
      Top = 99
      Width = 43
      Height = 15
      HelpContext = 480020
      AutoSize = True
      ExplicitLeft = 639
      ExplicitTop = 99
      ExplicitWidth = 43
      ExplicitHeight = 15
    end
    inherited Label5: TLabel
      Left = 632
      Top = 69
      Width = 50
      Height = 15
      HelpContext = 480021
      AutoSize = True
      ExplicitLeft = 632
      ExplicitTop = 69
      ExplicitWidth = 50
      ExplicitHeight = 15
    end
    inherited lblBaseForeignTotal: TLabel
      Left = 640
      Top = 129
      Width = 42
      Height = 15
      HelpContext = 480011
      AutoSize = True
      Visible = True
      ExplicitLeft = 640
      ExplicitTop = 129
      ExplicitWidth = 42
      ExplicitHeight = 15
    end
    inherited Label101: TLabel
      Left = 324
      Top = 129
      Width = 54
      Height = 15
      HelpContext = 480129
      WordWrap = False
      ExplicitLeft = 324
      ExplicitTop = 129
      ExplicitWidth = 54
      ExplicitHeight = 15
    end
    inherited lblContributionAmount: TLabel
      Top = 39
      Width = 69
      Height = 15
      HelpContext = 480130
      AutoSize = True
      ExplicitTop = 39
      ExplicitWidth = 69
      ExplicitHeight = 15
    end
    inherited Label12: TLabel
      Left = 838
      Top = 129
      Width = 46
      Height = 15
      HelpContext = 480131
      AutoSize = True
      ExplicitLeft = 838
      ExplicitTop = 129
      ExplicitWidth = 46
      ExplicitHeight = 15
    end
    inherited lblApprovedAmount: TLabel
      Left = 625
      Top = 1
      ExplicitLeft = 625
      ExplicitTop = 1
    end
    inherited pnlComments: TDNMPanel
      Left = 74
      Top = 5
      Width = 536
      HelpContext = 480188
      TabOrder = 22
      ExplicitLeft = 74
      ExplicitTop = 5
      ExplicitWidth = 536
      inherited LblCommentsHint: TLabel
        Width = 534
        HelpContext = 480189
        ExplicitWidth = 534
      end
      inherited txtComments: TDBMemo
        Width = 534
        HelpContext = 480013
        ExplicitWidth = 534
      end
    end
    inherited txtSubTotal: TDBEdit
      Left = 890
      Top = 5
      HelpContext = 480014
      TabOrder = 15
      ExplicitLeft = 890
      ExplicitTop = 5
    end
    inherited txtTotalTax: TDBEdit
      Left = 890
      Top = 34
      HelpContext = 480015
      TabOrder = 11
      ExplicitLeft = 890
      ExplicitTop = 34
    end
    inherited txtTotalDiscount: TDBEdit
      Left = 684
      Top = 64
      HelpContext = 480034
      TabOrder = 7
      ExplicitLeft = 684
      ExplicitTop = 64
    end
    inherited txtPickMemo: TDBMemo
      Left = 74
      Top = 64
      Width = 536
      Height = 58
      HelpContext = 480036
      TabOrder = 0
      ExplicitLeft = 74
      ExplicitTop = 64
      ExplicitWidth = 536
      ExplicitHeight = 58
    end
    inherited txtTotalMarkup: TDBEdit
      Left = 684
      Top = 94
      HelpContext = 480038
      TabOrder = 24
      ExplicitLeft = 684
      ExplicitTop = 94
    end
    inherited txtTotalAmount: TDBEdit
      Left = 876
      Top = 62
      HelpContext = 480016
      TabOrder = 12
      ExplicitLeft = 876
      ExplicitTop = 62
    end
    inherited edtBaseForeignTotal: TDBEdit
      Left = 684
      Top = 124
      HelpContext = 480017
      DataField = 'ForeignTotalAmount'
      TabOrder = 9
      Visible = True
      ExplicitLeft = 684
      ExplicitTop = 124
    end
    inherited lblDisableCalc: TDNMSpeedButton
      Left = 652
      Top = 7
      TabOrder = 20
      ExplicitLeft = 652
      ExplicitTop = 7
    end
    inherited btnAttachments: TDNMSpeedButton
      Left = 5
      Top = 29
      HelpContext = 480043
      TabOrder = 16
      ExplicitLeft = 5
      ExplicitTop = 29
    end
    inherited DNMPanel5: TDNMPanel
      Height = 124
      HelpContext = 480132
      TabOrder = 10
      Visible = False
      ExplicitHeight = 124
      inherited lblEnteredBy: TDBText
        Top = 4
        Height = 15
        HelpContext = 480133
        ExplicitTop = 4
        ExplicitHeight = 15
      end
      inherited lblPrintHead: TLabel
        Top = 52
        ExplicitTop = 52
      end
      inherited lblPrintedBy: TLabel
        Top = 52
        ExplicitTop = 52
      end
      inherited lblPrintedOnCaption: TLabel
        Top = 76
        ExplicitTop = 76
      end
      inherited lblPrintedOn: TLabel
        Left = 77
        Top = 76
        Height = 15
        HelpContext = 480134
        ExplicitLeft = 77
        ExplicitTop = 76
        ExplicitHeight = 15
      end
      inherited lblPrintedAtCaption: TLabel
        Top = 100
        ExplicitTop = 100
      end
      inherited lblPrintedAt: TLabel
        Top = 100
        Height = 15
        HelpContext = 480135
        ExplicitTop = 100
        ExplicitHeight = 15
      end
      inherited lblEnteredAtHead: TLabel
        Top = 28
        ExplicitTop = 28
      end
      inherited lblEnteredAt: TDBText
        Top = 28
        Height = 15
        HelpContext = 480136
        DataField = 'EnteredAtShort'
        ExplicitTop = 28
        ExplicitHeight = 15
      end
    end
    inherited lblEmail: TDNMPanel
      Left = 551
      Top = 7
      HelpContext = 480190
      TabOrder = 21
      ExplicitLeft = 551
      ExplicitTop = 7
      inherited lblEmailMsg: TLabel
        Left = 26
        Top = 5
        ExplicitLeft = 26
        ExplicitTop = 5
      end
    end
    inherited dnmpanle6: TDNMPanel [24]
      Left = 464
      Height = 149
      HelpContext = 480137
      TabOrder = 18
      Visible = False
      ExplicitLeft = 464
      ExplicitHeight = 149
      inherited lblMargin: TLabel
        Top = 110
        ExplicitTop = 110
      end
      inherited lblMarginLabel: TLabel
        Top = 110
        ExplicitTop = 110
      end
      inherited lblCostLabel: TLabel
        Top = 92
        ExplicitTop = 92
      end
      inherited lblCost: TLabel
        Top = 92
        ExplicitTop = 92
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
      inherited lblEstimatedFinalAmt: TLabel
        Left = 66
        Top = 74
        ExplicitLeft = 66
        ExplicitTop = 74
      end
      inherited lblEstimatedFinalAmtCaption: TLabel
        Top = 74
        ExplicitTop = 74
      end
      inherited lblWeightcaption: TLabel
        Left = 4
        Top = 129
        Width = 43
        HelpContext = 480138
        Caption = 'Weight:'
        ExplicitLeft = 4
        ExplicitTop = 129
        ExplicitWidth = 43
      end
      inherited lblWeight: TLabel
        Left = 66
        Top = 129
        ExplicitLeft = 66
        ExplicitTop = 129
      end
    end
    inherited txtConNote: TDBEdit [25]
      Left = 384
      Top = 125
      Width = 80
      HelpContext = 480139
      TabOrder = 4
      ExplicitLeft = 384
      ExplicitTop = 125
      ExplicitWidth = 80
    end
    inherited edtContributionAmount: TwwDBEdit [26]
      Left = 684
      Top = 34
      ParentColor = True
      TabOrder = 6
      ExplicitLeft = 684
      ExplicitTop = 34
    end
    object DNMPanel2: TDNMPanel [27]
      Left = 96
      Top = 124
      Width = 97
      Height = 25
      HelpContext = 480048
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 2
      Transparent = False
      object Label4: TLabel
        Left = 19
        Top = 5
        Width = 92
        Height = 15
        HelpContext = 480141
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
        Left = 2
        Top = 5
        Width = 14
        Height = 15
        HelpContext = 480050
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
    object DNMPanel1: TDNMPanel [28]
      Left = 195
      Top = 124
      Width = 74
      Height = 25
      HelpContext = 480051
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 3
      Visible = False
      Transparent = False
      object Label7: TLabel
        Left = 22
        Top = 5
        Width = 49
        Height = 15
        HelpContext = 480052
        Caption = 'Manifest'
        Transparent = True
        Visible = False
      end
      object chkManifest: TwwCheckBox
        Left = 3
        Top = 5
        Width = 13
        Height = 15
        HelpContext = 480053
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
    object pnlFutureOrder: TDNMPanel [29]
      Left = 0
      Top = 124
      Width = 94
      Height = 25
      HelpContext = 480054
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 1
      TabStop = True
      Transparent = False
      object Label2: TLabel
        Left = 19
        Top = 5
        Width = 72
        Height = 15
        HelpContext = 480055
        Caption = 'Future Order'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object chkFutureSO: TwwCheckBox
        Left = 3
        Top = 5
        Width = 13
        Height = 15
        HelpContext = 480056
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
        DataField = 'FutureSO'
        DataSource = DSMaster
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
    end
    inherited Label11: TDNMSpeedButton [30]
      Left = 823
      Top = 91
      Height = 30
      HelpContext = 480140
      Caption = 'Invoiced Amount'
      TabOrder = 17
      OnClick = doShowPrepayments
      ExplicitLeft = 823
      ExplicitTop = 91
      ExplicitHeight = 30
    end
    inherited edtPayment: TDBEdit [31]
      Left = 890
      Top = 94
      DataField = 'TotalProgressPayments'
      Enabled = False
      TabOrder = 13
      ExplicitLeft = 890
      ExplicitTop = 94
    end
    inherited edtBalance: TDBEdit [32]
      Left = 890
      Top = 124
      DataField = 'BalanceAmount'
      Enabled = False
      TabOrder = 14
      ExplicitLeft = 890
      ExplicitTop = 124
    end
    inherited edtApprovedAmount: TDBEdit [33]
      Left = 684
      Width = 88
      HelpContext = 480142
      TabOrder = 5
      ExplicitLeft = 684
      ExplicitWidth = 88
    end
    inherited btnSignature: TDNMSpeedButton [34]
      Left = 5
      Top = 53
      ExplicitLeft = 5
      ExplicitTop = 53
    end
    inherited btnAddFreight: TDNMSpeedButton [35]
      Left = 779
      Top = 5
      TabOrder = 23
      ExplicitLeft = 779
      ExplicitTop = 5
    end
    inherited pnlProcessMessage: TDNMPanel [36]
      Width = 996
      HelpContext = 480191
      ExplicitWidth = 996
      inherited lblProcessMessage: TLabel
        Width = 992
        HelpContext = 480126
        ExplicitLeft = 160
        ExplicitWidth = 834
      end
    end
  end
  inherited pnlHeader: TDNMPanel
    Top = 0
    Width = 996
    Height = 265
    HelpContext = 480057
    Align = alTop
    ParentColor = True
    ExplicitTop = 0
    ExplicitWidth = 996
    ExplicitHeight = 265
    DesignSize = (
      996
      265)
    inherited Bvlshipto: TBevel [0]
      Left = 640
      Top = 110
      Width = 256
      Height = 112
      HelpContext = 480143
      ExplicitLeft = 640
      ExplicitTop = 110
      ExplicitWidth = 256
      ExplicitHeight = 112
    end
    object Bevel5: TBevel [1]
      Left = 267
      Top = 60
      Width = 144
      Height = 46
      HelpContext = 480144
    end
    object bvlForeign: TBevel [2]
      Left = 414
      Top = 60
      Width = 220
      Height = 46
      HelpContext = 480111
    end
    object Label3: TLabel [3]
      Left = 220
      Top = 224
      Width = 54
      Height = 15
      HelpContext = 480112
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
    inherited SaleDate_Label: TLabel [4]
      Left = 639
      Top = 39
      HelpContext = 480060
      ExplicitLeft = 639
      ExplicitTop = 39
    end
    inherited Label160: TLabel [5]
      Left = 746
      Top = 41
      Width = 35
      Height = 15
      HelpContext = 480061
      AutoSize = True
      Caption = 'SO No'
      WordWrap = False
      ExplicitLeft = 746
      ExplicitTop = 41
      ExplicitWidth = 35
      ExplicitHeight = 15
    end
    inherited Label48: TLabel [6]
      Left = 111
      Top = 224
      Width = 22
      Height = 15
      HelpContext = 480062
      AutoSize = True
      ExplicitLeft = 111
      ExplicitTop = 224
      ExplicitWidth = 22
      ExplicitHeight = 15
    end
    inherited ClassLabel: TLabel [7]
      Left = 271
      Top = 63
      Width = 137
      Height = 15
      HelpContext = 480088
      ExplicitLeft = 271
      ExplicitTop = 63
      ExplicitWidth = 137
      ExplicitHeight = 15
    end
    inherited Label43: TLabel [8]
      Left = 8
      Top = 224
      Width = 69
      Height = 15
      HelpContext = 480089
      Alignment = taLeftJustify
      AutoSize = True
      ExplicitLeft = 8
      ExplicitTop = 224
      ExplicitWidth = 69
      ExplicitHeight = 15
    end
    inherited Label47: TLabel [9]
      Left = 319
      Top = 224
      Width = 18
      Height = 15
      HelpContext = 480090
      Alignment = taLeftJustify
      AutoSize = True
      ExplicitLeft = 319
      ExplicitTop = 224
      ExplicitWidth = 18
      ExplicitHeight = 15
    end
    inherited Label79: TLabel [10]
      Left = 537
      Top = 224
      Width = 36
      Height = 15
      HelpContext = 480091
      AutoSize = True
      ExplicitLeft = 537
      ExplicitTop = 224
      ExplicitWidth = 36
      ExplicitHeight = 15
    end
    inherited Label45: TLabel [11]
      Left = 661
      Top = 224
      Width = 51
      Height = 15
      HelpContext = 480092
      AutoSize = True
      ExplicitLeft = 661
      ExplicitTop = 224
      ExplicitWidth = 51
      ExplicitHeight = 15
    end
    inherited Label38: TLabel [12]
      Left = 12
      Top = 39
      Width = 159
      HelpContext = 480058
      ExplicitLeft = 12
      ExplicitTop = 39
      ExplicitWidth = 159
    end
    inherited bvelCustomerDetails: TBevel [13]
      Top = 113
      Width = 260
      Height = 107
      HelpContext = 480145
      ExplicitTop = 113
      ExplicitWidth = 260
      ExplicitHeight = 107
    end
    inherited lbMemTrans: TLabel [14]
      Left = 774
      Top = -1
      HelpContext = 480063
      ExplicitLeft = 774
      ExplicitTop = -1
    end
    inherited lblAccount: TLabel [15]
      Left = 12
      HelpContext = 480093
      ExplicitLeft = 12
    end
    inherited lblClientDetails: TLabel [16]
      Top = 115
      Width = 90
      HelpContext = 480146
      Caption = 'Order To'
      ExplicitTop = 115
      ExplicitWidth = 90
    end
    object lblPickUpFrom: TLabel [17]
      Left = 822
      Top = 113
      Width = 57
      Height = 15
      HelpContext = 480113
      Caption = 'Pick From'
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
    object Bevel6: TBevel [18]
      Left = 267
      Top = 135
      Width = 367
      Height = 86
      HelpContext = 480147
    end
    inherited lblBaseForeignCurrencyCode: TLabel
      Left = 426
      Top = 63
      Width = 95
      Height = 15
      HelpContext = 480064
      Visible = True
      ExplicitLeft = 426
      ExplicitTop = 63
      ExplicitWidth = 95
      ExplicitHeight = 15
    end
    inherited Label10: TLabel
      Left = 228
      Top = 39
      Width = 33
      HelpContext = 480148
      Visible = True
      ExplicitLeft = 228
      ExplicitTop = 39
      ExplicitWidth = 33
    end
    inherited lblBaseExchangeRate: TLabel
      Left = 534
      Top = 63
      HelpContext = 480065
      ExplicitLeft = 534
      ExplicitTop = 63
    end
    object lblConverted: TLabel [22]
      Left = 295
      Top = 40
      Width = 80
      Height = 19
      HelpContext = 480044
      Caption = 'Converted'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    inherited lblRedeemPoints: TLabel
      Left = 203
      Top = 39
      Width = 83
      Height = 15
      HelpContext = 480149
      AutoSize = True
      ExplicitLeft = 203
      ExplicitTop = 39
      ExplicitWidth = 83
      ExplicitHeight = 15
    end
    object Label13: TLabel [25]
      Left = 751
      Top = 224
      Width = 68
      Height = 15
      HelpContext = 480065
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
    object lblconvertedtoRepairs: TLabel [26]
      Left = 418
      Top = 42
      Width = 160
      Height = 16
      HelpContext = 480182
      Caption = 'Repair Has Been Created'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object Label94: TLabel [27]
      Left = 747
      Top = 113
      Width = 49
      Height = 15
      HelpContext = 480150
      Alignment = taRightJustify
      Caption = 'Shipping'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    inherited lblStatus: TLabel
      Left = 428
      Top = 224
      Width = 37
      HelpContext = 480151
      AutoSize = True
      ExplicitLeft = 428
      ExplicitTop = 224
      ExplicitWidth = 37
    end
    inherited Label8: TLabel
      Left = 639
      Top = 85
      Width = 56
      HelpContext = 480187
      Caption = 'Category'
      ExplicitLeft = 639
      ExplicitTop = 85
      ExplicitWidth = 56
    end
    object Label14: TLabel [30]
      Left = 667
      Top = 163
      Width = 56
      Height = 15
      HelpContext = 480183
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
      Left = 825
      Top = 225
      ExplicitLeft = 825
      ExplicitTop = 225
    end
    inherited edt_SaleNum_Seq: TDBText
      Top = 59
      ExplicitTop = 59
    end
    object btnComplnInvoice: TDNMSpeedButton [33]
      Left = 519
      Top = 193
      Width = 98
      Height = 25
      HelpContext = 480152
      Action = actcomplnInvoice
      Caption = 'Copy to &Invoice'
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
      TabOrder = 46
      AutoDisableParentOnclick = True
    end
    object btninv: TDNMSpeedButton [34]
      Left = 519
      Top = 193
      Width = 98
      Height = 25
      HelpContext = 480124
      Action = actInvoice
      Caption = 'Copy to &Invoice'
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
      TabOrder = 52
      AutoDisableParentOnclick = True
    end
    inherited cboCurrentTransStatus: TwwDBLookupCombo
      Left = 428
      Top = 240
      Width = 107
      HelpContext = 480192
      TabOrder = 55
      ExplicitLeft = 428
      ExplicitTop = 240
      ExplicitWidth = 107
    end
    object btnCompleteNoInvoice: TDNMSpeedButton [36]
      Left = 415
      Top = 168
      Width = 98
      Height = 25
      HelpContext = 480119
      Action = actConComplete
      Caption = 'Co&mplt no Invc'
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
      AutoDisableParentOnclick = True
    end
    object btnTakeFromStock: TDNMSpeedButton [37]
      Left = 399
      Top = 193
      Width = 98
      Height = 25
      HelpContext = 480153
      Action = actTakeFromStock
      Caption = 'Take From Stock'
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
      TabOrder = 47
      AutoDisableParentOnclick = True
    end
    inherited btnPreview: TDNMSpeedButton [38]
      Left = 902
      Top = 140
      HelpContext = 480075
      Action = nil
      TabOrder = 26
      OnClick = btnPreviewClick
      ExplicitLeft = 902
      ExplicitTop = 140
    end
    inherited btnPrint: TDNMSpeedButton [39]
      Left = 902
      Top = 172
      HelpContext = 480076
      Action = nil
      TabOrder = 27
      OnClick = btnPrintClick
      ExplicitLeft = 902
      ExplicitTop = 172
    end
    inherited pnlTitle: TDNMPanel [40]
      Left = 267
      Width = 367
      Height = 38
      HelpContext = 480085
      Caption = 'Sales Order'
      TabOrder = 53
      ExplicitLeft = 267
      ExplicitWidth = 367
      ExplicitHeight = 38
      inherited TitleShader: TShader
        Width = 365
        Height = 36
        HelpContext = 480086
        ExplicitWidth = 365
        ExplicitHeight = 36
        inherited TitleLabel: TLabel
          Width = 365
          Height = 36
          HelpContext = 480087
          Caption = 'Sales Order'
          ExplicitWidth = 308
          ExplicitHeight = 36
        end
      end
    end
    inherited pnlChooseRpt: TDNMPanel [41]
      Left = 267
      Top = 109
      Width = 144
      HelpContext = 480077
      ParentColor = True
      TabOrder = 3
      TabStop = True
      Transparent = False
      ExplicitLeft = 267
      ExplicitTop = 109
      ExplicitWidth = 144
      inherited chkChooseRpt: TCheckBox
        Left = 6
        Width = 118
        HelpContext = 480079
        ExplicitLeft = 6
        ExplicitWidth = 118
      end
    end
    object cboShipDate: TwwDBDateTimePicker [42]
      Left = 220
      Top = 240
      Width = 97
      Height = 23
      HelpContext = 480116
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
      TabOrder = 48
      OnEnter = cboShipDateEnter
      OnExit = cboShipDateExit
    end
    inherited editField: TEdit [43]
      Left = 687
      Top = 147
      HelpContext = 480096
      TabOrder = 56
      ExplicitLeft = 687
      ExplicitTop = 147
    end
    inherited cboBaseForeignCurrencyCode: TwwDBLookupCombo [44]
      Left = 425
      Top = 79
      Width = 95
      HelpContext = 480082
      TabOrder = 7
      Visible = True
      ExplicitLeft = 425
      ExplicitTop = 79
      ExplicitWidth = 95
    end
    inherited txtPONumber: TDBEdit [45]
      Left = 8
      Top = 240
      Width = 100
      HelpContext = 480098
      TabOrder = 16
      ExplicitLeft = 8
      ExplicitTop = 240
      ExplicitWidth = 100
    end
    inherited edtBaseExchangeRate: TwwDBEdit [46]
      Left = 534
      Top = 79
      Width = 95
      HelpContext = 480083
      TabOrder = 8
      ExplicitLeft = 534
      ExplicitTop = 79
      ExplicitWidth = 95
    end
    inherited btnPrepayment: TDNMSpeedButton [47]
      Left = 399
      Top = 137
      Width = 98
      Height = 25
      HelpContext = 480109
      TabOrder = 34
      ExplicitLeft = 399
      ExplicitTop = 137
      ExplicitWidth = 98
      ExplicitHeight = 25
    end
    inherited pnlHold: TDNMPanel [48]
      Left = 530
      Top = 109
      Width = 104
      HelpContext = 480106
      ParentColor = True
      TabOrder = 4
      TabStop = True
      Transparent = False
      ExplicitLeft = 530
      ExplicitTop = 109
      ExplicitWidth = 104
      inherited lblHoldSale: TLabel
        Left = 34
        HelpContext = 480107
        ExplicitLeft = 34
      end
      inherited chkHoldSale: TwwCheckBox
        Left = 12
        Top = 3
        HelpContext = 480108
        Caption = 'Hold Sale'
        ExplicitLeft = 12
        ExplicitTop = 3
      end
    end
    inherited cboDueDate: TwwDBDateTimePicker [49]
      Left = 661
      Top = 240
      Width = 88
      HelpContext = 480100
      TabOrder = 21
      OnEnter = cboDueDateEnter
      ExplicitLeft = 661
      ExplicitTop = 240
      ExplicitWidth = 88
    end
    object btnCopyToRepair: TDNMSpeedButton [50]
      Left = 280
      Top = 193
      Width = 98
      Height = 25
      HelpContext = 480117
      Caption = 'Copy to &Repair'
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
      TabOrder = 51
      AutoDisableParentOnclick = True
      OnClick = btnCopyToRepairClick
    end
    object btnPickUpFrom: TDNMSpeedButton [51]
      Left = 878
      Top = 109
      Width = 18
      Height = 23
      HelpContext = 480118
      DisableTransparent = False
      Enabled = False
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
      TabOrder = 14
      Visible = False
      AutoDisableParentOnclick = True
      OnClick = btnPickUpFromClick
    end
    object btnCash: TDNMSpeedButton [52]
      Left = 519
      Top = 137
      Width = 98
      Height = 25
      HelpContext = 480123
      Action = actConCash
      Caption = 'Copy to &Cash'
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
      TabOrder = 33
      AutoDisableParentOnclick = True
    end
    object DNMPanel4: TDNMPanel [53]
      Left = 414
      Top = 109
      Width = 113
      Height = 23
      HelpContext = 480184
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 5
      TabStop = True
      Transparent = False
      object chkIsInternalOrder: TwwCheckBox
        Left = 4
        Top = 3
        Width = 103
        Height = 17
        HelpContext = 480122
        DisableThemes = False
        AlwaysTransparent = False
        Frame.Transparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Internal Order'
        DataField = 'IsInternalOrder'
        DataSource = DSMaster
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = chkIsInternalOrderClick
      end
    end
    inherited cboCreationDate: TwwDBDateTimePicker [54]
      Left = 639
      Top = 56
      Width = 103
      Height = 23
      HelpContext = 480069
      TabOrder = 9
      OnExit = nil
      ExplicitLeft = 639
      ExplicitTop = 56
      ExplicitWidth = 103
      ExplicitHeight = 23
    end
    inherited cboTerms: TwwDBLookupCombo [55]
      Left = 537
      Top = 240
      Width = 122
      HelpContext = 480099
      TabOrder = 20
      ExplicitLeft = 537
      ExplicitTop = 240
      ExplicitWidth = 122
    end
    inherited txtClientDetails: TDBMemo [56]
      Left = 12
      Top = 132
      Width = 251
      Height = 85
      HelpContext = 480068
      ExplicitLeft = 12
      ExplicitTop = 132
      ExplicitWidth = 251
      ExplicitHeight = 85
    end
    inherited cboClientR: TERPDbLookupCombo [57]
      Width = 183
      HelpContext = 480154
      Selected.Strings = (
        'Company'#9'45'#9'Company'#9'F')
      TabOrder = 1
      ExplicitWidth = 183
    end
    inherited cboClass: TwwDBLookupCombo [58]
      Left = 271
      Top = 79
      HelpContext = 480097
      TabOrder = 6
      ExplicitLeft = 271
      ExplicitTop = 79
    end
    inherited btnRepairEquipment: TDNMSpeedButton [59]
      Left = 232
      Top = 56
      TabOrder = 43
      ExplicitLeft = 232
      ExplicitTop = 56
    end
    inherited cboAccount: TwwDBLookupCombo [60]
      Width = 255
      HelpContext = 480103
      TabOrder = 0
      ExplicitWidth = 255
    end
    inherited txtShipTo: TDBMemo [61]
      Left = 647
      Top = 131
      Width = 246
      Height = 86
      HelpContext = 480104
      ExplicitLeft = 647
      ExplicitTop = 131
      ExplicitWidth = 246
      ExplicitHeight = 86
    end
    inherited txtCustomID: TDBEdit [62]
      Left = 746
      Top = 56
      Hint = 'Double Click For The Transaction Sequence List'
      HelpContext = 480070
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 11
      ExplicitLeft = 746
      ExplicitTop = 56
    end
    object btnShipmentDetails: TDNMSpeedButton [63]
      Left = 798
      Top = 111
      Width = 18
      Height = 19
      HelpContext = 480155
      Caption = 'Foriegn'
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
      TabOrder = 13
      AutoDisableParentOnclick = True
      OnClick = btnShipmentDetailsClick
    end
    object wwDBEdit1: TwwDBEdit [64]
      Left = 751
      Top = 240
      Width = 71
      Height = 23
      HelpContext = 480185
      DataField = 'NoOfBoxes'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 22
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object btnProgressPayment: TDNMSpeedButton [65]
      Left = 812
      Top = 14
      Width = 87
      Height = 27
      HelpContext = 480156
      Action = actProgressPayment
      Anchors = [akTop, akRight]
      Caption = 'Progress'
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
      TabOrder = 57
      TabStop = False
      AutoDisableParentOnclick = True
    end
    object DNMSpeedButton2: TDNMSpeedButton [66]
      Left = 519
      Top = 165
      Width = 98
      Height = 25
      HelpContext = 480157
      Action = actCopyOrder
      Caption = 'Copy Order'
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
      TabOrder = 49
      AutoDisableParentOnclick = True
    end
    inherited btnNext: TDNMSpeedButton [67]
      Left = 902
      Top = 14
      HelpContext = 480072
      TabOrder = 23
      ExplicitLeft = 902
      ExplicitTop = 14
    end
    inherited btnCreateJob: TDNMSpeedButton [68]
      Left = 280
      Top = 138
      Width = 98
      Height = 25
      HelpContext = 480158
      TabOrder = 32
      ExplicitLeft = 280
      ExplicitTop = 138
      ExplicitWidth = 98
      ExplicitHeight = 25
    end
    inherited cboEmployee: TwwDBLookupCombo [69]
      Left = 111
      Top = 240
      Width = 107
      HelpContext = 480071
      TabOrder = 17
      OnNotInList = cboEmployeeNotInList
      ExplicitLeft = 111
      ExplicitTop = 240
      ExplicitWidth = 107
    end
    inherited btnContacts: TDNMSpeedButton [70]
      Left = 201
      Top = 56
      HelpContext = 480080
      TabOrder = 41
      ExplicitLeft = 201
      ExplicitTop = 56
    end
    inherited btnCompleted: TDNMSpeedButton [71]
      Left = 902
      Top = 77
      HelpContext = 480073
      TabOrder = 24
      ExplicitLeft = 902
      ExplicitTop = 77
    end
    inherited pnlParentclient: TDNMPanel [72]
      HelpContext = 480193
      TabOrder = 42
    end
    inherited cmdFax: TDNMSpeedButton [73]
      Left = 831
      Top = 147
      HelpContext = 480039
      TabOrder = 31
      OnClick = cmdFaxClick
      ExplicitLeft = 831
      ExplicitTop = 147
    end
    inherited cboSalesCategory: TwwDBLookupCombo [74]
      Left = 697
      Top = 81
      Width = 196
      HelpContext = 480160
      TabOrder = 12
      ExplicitLeft = 697
      ExplicitTop = 81
      ExplicitWidth = 196
    end
    inherited cmdEmail: TDNMSpeedButton [75]
      Left = 831
      Top = 179
      TabOrder = 30
      Visible = False
      ExplicitLeft = 831
      ExplicitTop = 179
    end
    object wwDBDateTimePicker1: TwwDBDateTimePicker [76]
      Left = 667
      Top = 179
      Width = 158
      Height = 23
      HelpContext = 480186
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
      TabOrder = 44
      UnboundDataType = wwDTEdtDate
      Visible = False
      OnEnter = cboDueDateEnter
      OnExit = cboDueDateExit
    end
    inherited cboVia: TwwDBLookupCombo [77]
      Left = 319
      Top = 240
      Width = 107
      HelpContext = 480105
      TabOrder = 19
      ExplicitLeft = 319
      ExplicitTop = 240
      ExplicitWidth = 107
    end
    inherited cmdDeliveryDocket: TDNMSpeedButton [78]
      Left = 765
      Top = 191
      HelpContext = 480101
      TabOrder = 29
      Visible = False
      ExplicitLeft = 765
      ExplicitTop = 191
    end
    inherited cmdPrintPick: TDNMSpeedButton [79]
      Left = 765
      Top = 135
      HelpContext = 480102
      TabOrder = 28
      Visible = False
      ExplicitLeft = 765
      ExplicitTop = 135
    end
    object btnFinalizeOrder: TDNMSpeedButton [80]
      Left = 399
      Top = 165
      Width = 98
      Height = 25
      HelpContext = 480162
      Action = actfinalizeBuild
      Caption = 'Finalise Build'
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
      TabOrder = 50
      AutoDisableParentOnclick = True
    end
    inherited btnShipment: TDNMSpeedButton [81]
      Left = 647
      Top = 112
      TabOrder = 36
      ExplicitLeft = 647
      ExplicitTop = 112
    end
    inherited btnPayments: TDNMSpeedButton [82]
      Left = 723
      Top = 14
      HelpContext = 480128
      TabOrder = 54
      ExplicitLeft = 723
      ExplicitTop = 14
    end
    inherited btnClose: TDNMSpeedButton [83]
      Left = 902
      HelpContext = 480074
      TabOrder = 25
      ExplicitLeft = 902
    end
    inherited cboAreaCode: TwwDBLookupCombo [84]
      Left = 825
      Top = 240
      Width = 73
      HelpContext = 480164
      TabOrder = 10
      ExplicitLeft = 825
      ExplicitTop = 240
      ExplicitWidth = 73
    end
    inherited btnEdit: TDNMSpeedButton [85]
      Left = 948
      Top = 204
      Width = 41
      HelpContext = 480163
      TabOrder = 35
      Visible = True
      ExplicitLeft = 948
      ExplicitTop = 204
      ExplicitWidth = 41
    end
    inherited btnPrevious: TDNMSpeedButton [86]
      Left = 902
      Top = 45
      TabOrder = 37
      ExplicitLeft = 902
      ExplicitTop = 45
    end
    inherited btnPDF: TDNMSpeedButton [87]
      Left = 750
      Top = 168
      TabOrder = 18
      Visible = False
      OnClick = nil
      ExplicitLeft = 750
      ExplicitTop = 168
    end
    inherited btnNextSale: TDNMSpeedButton
      Left = 948
      Top = 45
      TabOrder = 38
      ExplicitLeft = 948
      ExplicitTop = 45
    end
    inherited btnShiptocontact: TDNMSpeedButton
      Left = 707
      Top = 112
      TabOrder = 39
      ExplicitLeft = 707
      ExplicitTop = 112
    end
    inherited pnlShipToMessage: TPanel
      HelpContext = 480194
      TabOrder = 40
    end
    inherited btninvoices: TDNMSpeedButton
      Left = 635
      Top = 14
      TabOrder = 58
      ExplicitLeft = 635
      ExplicitTop = 14
    end
    inherited btnConSmart: TDNMSpeedButton
      Left = 280
      Top = 165
      Width = 98
      HelpContext = 480195
      TabOrder = 59
      ExplicitLeft = 280
      ExplicitTop = 165
      ExplicitWidth = 98
    end
    inherited btnShowDetails: TDNMSpeedButton
      Left = 902
      Top = 236
      Anchors = [akTop, akRight]
      TabOrder = 60
      ExplicitLeft = 902
      ExplicitTop = 236
    end
    inherited btnRefNo: TDNMSpeedButton
      TabOrder = 61
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 701
  end
  inherited tmrdelay: TTimer
    Left = 782
  end
  inherited popSpelling: TPopupMenu
    Left = 172
  end
  inherited tmrdelayMsg: TTimer
    Left = 660
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 253
  end
  inherited DSDetails: TDataSource
    Left = 62
    Top = 365
  end
  inherited DSMaster: TDataSource
    Left = 35
    Top = 365
  end
  inherited lsTDNMSpeedButtonActions: TActionList
    inherited actPick: TAction
      OnExecute = actPickExecute
    end
    object actInvoice: TAction [10]
      Caption = 'Copy to &Invoice'
      HelpContext = 480167
      OnExecute = actInvoiceExecute
      OnUpdate = actInvoiceUpdate
    end
    object actConCash: TAction [11]
      Caption = 'Copy to &Cash'
      Enabled = False
      HelpContext = 480168
      OnExecute = actConCashExecute
      OnUpdate = actConCashUpdate
    end
    object actConRepair: TAction [12]
      Caption = 'Copy to &Repair'
      HelpContext = 480170
    end
    object actfinalizeBuild: TAction [13]
      Caption = 'Finalise Build'
      HelpContext = 480171
      OnExecute = actfinalizeBuildExecute
    end
    object actConComplete: TAction [14]
      Caption = 'Co&mplt no Invc'
      HelpContext = 480172
      OnExecute = actConCompleteExecute
      OnUpdate = actConCompleteUpdate
    end
    object actProgressPayment: TAction [15]
      Caption = 'Payments'
      HelpContext = 480173
      OnExecute = actProgressPaymentExecute
    end
    object actCopyOrder: TDNMAction [16]
      Caption = 'Copy Order'
      HelpContext = 480174
      OnExecute = actCopyOrderExecute
      OnUpdate = actCopyOrderUpdate
      buttoncolor = clWhite
    end
    object actTakeFromStock: TDNMAction [22]
      Caption = 'Take From Stock'
      HelpContext = 480175
      OnExecute = actTakeFromStockExecute
      OnUpdate = actTakeFromStockUpdate
      buttoncolor = clWhite
    end
    object actPartialInvoice: TDNMAction [23]
      Caption = 'Make a Partial Invoice'
      HelpContext = 480176
      OnExecute = actPartialInvoiceExecute
      buttoncolor = clWhite
    end
    object actcomplnInvoice: TDNMAction [24]
      Caption = 'Compl n Invoice'
      HelpContext = 480177
      OnExecute = actcomplnInvoiceExecute
      OnUpdate = actcomplnInvoiceUpdate
      buttoncolor = clWhite
    end
  end
  inherited popDscntMrkup: TAdvPopupMenu
    Left = 131
  end
  inherited popMemTrans: TAdvPopupMenu
    Left = 91
    inherited mnuTransactionSequence: TMenuItem [2]
    end
    object N5: TMenuItem [3]
      Caption = '-'
      HelpContext = 480178
    end
    inherited mnuAuditTrial: TMenuItem [4]
    end
    inherited mnuconvertedToList: TMenuItem
      Caption = 'Sales Order Converted to Sales List'
      HelpContext = 480179
      OnClick = mnuconvertedToListClick
    end
    object mnuPartialShipmentLine: TMenuItem
      Caption = '-'
      HelpContext = 480180
    end
    object mnuPartialInvoice: TMenuItem
      Action = actPartialInvoice
    end
    object mnuPartialShipments: TMenuItem
      Caption = 'Partial Invoices Created'
      HelpContext = 480181
      OnClick = mnuPartialShipmentsClick
    end
  end
  inherited tblMaster: TERPQuery
    Left = 35
    Top = 331
    object tblMasterPOCreated: TWideStringField [94]
      FieldName = 'POCreated'
      Origin = 'tblsales.POCreated'
      FixedChar = True
      Size = 1
    end
    object tblMasterFutureSO: TWideStringField [95]
      FieldName = 'FutureSO'
      Origin = 'tblsales.FutureSO'
      FixedChar = True
      Size = 1
    end
    object tblMasterAutoSmartOrderRef: TWideStringField [96]
      FieldName = 'AutoSmartOrderRef'
      Origin = 'tblsales.AutoSmartOrderRef'
      Size = 255
    end
    object tblMasterIsInternalOrder: TWideStringField [98]
      FieldName = 'IsInternalOrder'
      Origin = 'tblsales.IsInternalOrder'
      FixedChar = True
      Size = 1
    end
    object tblMasterSOProgressPaymentGlobalRef: TWideStringField [100]
      FieldName = 'SOProgressPaymentGlobalRef'
      Origin = 'tblsales.SOProgressPaymentGlobalRef'
      Size = 255
    end
    object tblMasterSOProgressPaymentOriginalRef: TWideStringField [102]
      FieldName = 'SOProgressPaymentOriginalRef'
      Origin = 'tblsales.SOProgressPaymentOriginalRef'
      Size = 255
    end
    object tblMasterTotalProgressPayments: TFloatField [104]
      FieldKind = fkCalculated
      FieldName = 'TotalProgressPayments'
      currency = True
      Calculated = True
    end
    object tblMasterBalanceAmount: TFloatField [106]
      FieldKind = fkCalculated
      FieldName = 'BalanceAmount'
      currency = True
      Calculated = True
    end
  end
  object qryPartsTemplate: TERPQuery [19]
    Connection = MyConnection
    SQL.Strings = (
      'select MasterProductID from tblManufTemplate')
    Left = 253
    Top = 331
  end
  inherited tblDetails: TERPQuery
    AfterPost = tblDetailsAfterPost
    Left = 62
    Top = 331
    inherited tblDetailsProduct_Description: TWideStringField [7]
    end
    inherited tblDetailsLineCostInc: TFloatField [8]
    end
    inherited tblDetailsLineTaxCode: TWideStringField [9]
    end
    inherited tblDetailsLineTax: TFloatField [10]
    end
    inherited tblDetailsLinePriceInc: TFloatField [11]
    end
    inherited tblDetailsTotalLineAmountInc: TFloatField [12]
    end
    inherited tblDetailsCalcProfit: TCurrencyField [13]
    end
    inherited tblDetailsCalcProfitPercent: TFloatField [14]
    end
    inherited tblDetailsCalcGrossProfitPercentInc: TFloatField [15]
      DisplayLabel = 'GP %'
      DisplayFormat = '0.0%'
    end
    inherited tblDetailsLatestCostPriceInc: TFloatField [16]
    end
    inherited tblDetailsShipDate: TDateTimeField [17]
    end
    object tblDetailsSmartOrderCreated: TWideStringField [18]
      DisplayLabel = 'Ordered?'
      DisplayWidth = 1
      FieldName = 'SmartOrderCreated'
      Origin = 'tblsaleslines.SmartOrderCreated'
      FixedChar = True
      Size = 1
    end
    inherited tblDetailsPartBarcode: TWideStringField [19]
      Visible = False
    end
    object tblDetailsWarrantyEndsOn: TDateField [20]
      DisplayLabel = 'Warranty Ends On'
      DisplayWidth = 10
      FieldName = 'WarrantyEndsOn'
      Origin = 'tblsaleslines.WarrantyEndsOn'
      Visible = False
    end
    inherited tblDetailsReferenceNo: TWideStringField [21]
    end
    inherited tblDetailsAttrib1Sale: TFloatField [22]
      Visible = False
    end
    inherited tblDetailsAttrib2Sale: TFloatField [23]
      Visible = False
    end
    inherited tblDetailsAttrib1SaleRate: TFloatField [24]
      Visible = False
    end
    inherited tblDetailsSpecDescription: TWideStringField [25]
      Visible = False
    end
    inherited tblDetailsSpecValue: TFloatField [26]
      Visible = False
    end
    object tblDetailsWarrantyPeriod: TWideStringField [27]
      DisplayLabel = 'Warranty Period'
      DisplayWidth = 20
      FieldName = 'WarrantyPeriod'
      Origin = 'tblsaleslines.WarrantyPeriod'
      Visible = False
      Size = 100
    end
    inherited tblDetailsProduct_Description_Memo: TWideMemoField [28]
      Visible = False
    end
    inherited tblDetailsCostCentreName: TWideStringField [29]
      Visible = False
    end
    object tblDetailsDocketNumber: TWideStringField [30]
      DisplayLabel = 'Docket Number'
      DisplayWidth = 20
      FieldName = 'DocketNumber'
      Origin = 'tblsaleslines.DocketNumber'
      Visible = False
      Size = 255
    end
    inherited tblDetailsDiscounts: TFloatField [31]
      Visible = False
    end
    inherited tblDetailsForeignCurrencyLinePrice: TFloatField [32]
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField10: TWideStringCustField [33]
      Visible = False
    end
    inherited tblDetailsSupplier: TWideStringField [34]
      Visible = False
    end
    inherited tblDetailsSupplierContact: TWideStringField [35]
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField1: TWideStringCustField [36]
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField2: TWideStringCustField [37]
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField3: TWideStringCustField [38]
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField4: TWideStringCustField [39]
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField5: TWideStringCustField [40]
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField6: TWideStringCustField [41]
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField7: TWideStringCustField [42]
      Visible = False
    end
    inherited tblDetailsBaseLineno: TIntegerField [43]
      Visible = False
    end
    object tblDetailsAutoSmartOrder: TWideStringField [44]
      DisplayLabel = 'Auto Create Order?'
      DisplayWidth = 1
      FieldName = 'AutoSmartOrder'
      Origin = 'tblsaleslines.AutoSmartOrder'
      Visible = False
      FixedChar = True
      Size = 1
    end
    inherited tblDetailsSalesLinesCustField9: TWideStringCustField [45]
      Visible = False
    end
    inherited tblDetailsMemoLine: TWideMemoField [46]
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField8: TWideStringCustField [47]
      Visible = False
    end
    inherited tblDetailsTimecostused: TWideStringField [48]
      Visible = False
    end
    inherited tblDetailsShipContainerName: TWideStringField [49]
      Visible = False
    end
    inherited tblDetailsProfitbasedLatestCost: TFloatField [50]
      Visible = False
    end
    inherited tblDetailsProfitbasedLatestCostPercent: TFloatField [51]
      Visible = False
    end
    inherited tblDetailsProfitbasedLatestCostInc: TFloatField [52]
      Visible = False
    end
    inherited tblDetailsProfitbasedLatestCostPercentInc: TFloatField [53]
      Visible = False
    end
    inherited tblDetailsGrossProfitbasedLatestCostPercentInc: TFloatField [54]
      Visible = False
    end
    inherited tblDetailsShipContainerETA: TDateField [55]
      Visible = False
    end
    inherited tblDetailsUOM_Height: TFloatField
      Visible = False
    end
    inherited tblDetailsUOM_Width: TFloatField
      Visible = False
    end
    inherited tblDetailsUOM_Length: TFloatField
      Visible = False
    end
    inherited tblDetailsUOM_Weight: TFloatField
      Visible = False
    end
    inherited tblDetailsTotalUOM_WeightSold: TFloatField
      Visible = False
    end
    inherited tblDetailsTotalUOM_WeightShipped: TFloatField
      Visible = False
    end
    inherited tblDetailsTotalUOM_WeightBO: TFloatField
      Visible = False
    end
    inherited tblDetailsTotalUOM_LengthSold: TFloatField
      Visible = False
    end
    inherited tblDetailsTotalUOM_LengthShipped: TFloatField
      Visible = False
    end
    inherited tblDetailsTotalUOM_LengthBO: TFloatField
      Visible = False
    end
    object tblDetailsProgresspaymentRef: TWideStringField [66]
      DisplayWidth = 10
      FieldName = 'ProgresspaymentRef'
      Origin = 'tblsaleslines.ProgresspaymentRef'
      Visible = False
      Size = 255
    end
    inherited tblDetailsUOM_Volume: TFloatField
      Visible = False
    end
    inherited tblDetailsProduct_custFld1: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld2: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld3: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld4: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld5: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld6: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld7: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld8: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld9: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld10: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld11: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld12: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld13: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld14: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld15: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custDate1: TDateTimeField
      Visible = False
    end
    inherited tblDetailsProduct_custDate2: TDateTimeField
      Visible = False
    end
    object tblDetailsBOMGroupedLine: TWideStringField [87]
      DisplayWidth = 1
      FieldName = 'BOMGroupedLine'
      Origin = 'tblsaleslines.BOMGroupedLine'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsBOMProductionLine: TWideStringField [88]
      DisplayWidth = 1
      FieldName = 'BOMProductionLine'
      Origin = 'tblsaleslines.BOMProductionLine'
      Visible = False
      FixedChar = True
      Size = 1
    end
    inherited tblDetailsProduct_custDate3: TDateTimeField
      Visible = False
    end
    inherited tblDetailsMatrixDesc: TWideMemoField
      Visible = False
    end
    inherited tblDetailsMatrixPrice: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtySoldValue1: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtySoldValue2: TFloatField
      Visible = False
    end
    object tblDetailsAssembled: TWideStringField [94]
      DisplayWidth = 1
      FieldName = 'Assembled'
      Origin = 'tblsaleslines.Assembled'
      Visible = False
      FixedChar = True
      Size = 1
    end
    inherited tblDetailsFormulaQtySoldValue3: TFloatField
      Visible = False
    end
    inherited tblDetailsProductBarcode: TWideStringField [96]
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue1: TFloatField [97]
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue2: TFloatField [98]
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue3: TFloatField [99]
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue4: TFloatField [100]
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue5: TFloatField [101]
      Visible = False
    end
    inherited tblDetailsFormulaQtySoldValue: TFloatField [102]
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue: TFloatField [103]
      Visible = False
    end
    inherited tblDetailsAttrib1SaleEst: TFloatField [104]
      Visible = False
    end
    inherited tblDetailsAttrib2SaleEst: TFloatField [105]
      Visible = False
    end
    inherited tblDetailsISContainer: TWideStringField [106]
      Visible = False
    end
    inherited tblDetailsIsPallet: TWideStringField [107]
      Visible = False
    end
    inherited tblDetailsArea: TWideStringField [108]
      Visible = False
    end
    inherited tblDetailsAreaQty: TFloatField [109]
      Visible = False
    end
    inherited tblDetailsCustomerEquipmentID: TIntegerField [110]
      Visible = False
    end
    inherited tblDetailsUOMLineCost: TFloatField [111]
      Visible = False
    end
    inherited tblDetailsUOMLineCostInc: TFloatField [112]
      Visible = False
    end
    inherited tblDetailsUOMLinePrice: TFloatField [113]
      Visible = False
    end
    inherited tblDetailsUOMLinePriceInc: TFloatField [114]
      Visible = False
    end
    inherited tblDetailsEquipment: TWideStringField [115]
      Visible = False
    end
    inherited tblDetailsLinesOrder: TIntegerField [116]
      Visible = False
    end
    inherited tblDetailsRequiresAssembly: TWideStringField [117]
      Visible = False
    end
    inherited tblDetailsFormulaQtySoldValue4: TFloatField [118]
      Visible = False
    end
    inherited tblDetailsFormulaQtySoldValue5: TFloatField [119]
      Visible = False
    end
    inherited tblDetailsOriginalQtyOrdered: TFloatField
      Visible = False
    end
    inherited tblDetailsDetailsCust1Total: TFloatField
      Visible = False
    end
    object tblDetailsForeignExchangeSellCode: TWideStringField [122]
      DisplayLabel = 'Foreign Currency'
      DisplayWidth = 3
      FieldName = 'ForeignExchangeSellCode'
      Origin = 'tblsaleslines.ForeignExchangeSellCode'
      Visible = False
      FixedChar = True
      Size = 3
    end
    inherited tblDetailsStandardCost: TFloatField
      Visible = False
    end
    inherited tblDetailsLineCost: TFloatField [124]
    end
    inherited tblDetailsShipped: TFloatField [125]
    end
    inherited tblDetailsLatestCostPrice: TFloatField [126]
    end
    inherited tblDetailsBackOrder: TFloatField [127]
    end
    inherited tblDetailsOrgLinePrice: TFloatField [128]
    end
    inherited tblDetailsSaleID: TIntegerField [129]
    end
    inherited tblDetailsSaleLineID: TAutoIncField [130]
    end
    inherited tblDetailsTotalLineAmount: TFloatField [131]
    end
    inherited tblDetailsQtySold: TFloatField [132]
    end
    inherited tblDetailsGlobalRef: TWideStringField [133]
    end
    inherited tblDetailsProductGroup: TWideStringField [134]
    end
    inherited tblDetailsLineWholesalePrice: TFloatField [135]
    end
    inherited tblDetailsLineTaxRate: TFloatField [136]
    end
    inherited tblDetailsInvoiced: TWideStringField [137]
    end
    inherited tblDetailsMarkup: TFloatField [138]
    end
    inherited tblDetailsMarkupPercent: TFloatField [139]
    end
    inherited tblDetailsDiscountPercent: TFloatField [140]
    end
    inherited tblDetailsEditedFlag: TWideStringField [141]
    end
    inherited tblDetailsDeleted: TWideStringField [142]
    end
    inherited tblDetailsProductID: TIntegerField [143]
    end
    inherited tblDetailsPartType: TWideStringField [144]
    end
    inherited tblDetailsRefundQty: TFloatField [145]
    end
    inherited tblDetailsLaybyID: TWideStringField [146]
    end
    inherited tblDetailsIncomeAccnt: TWideStringField [147]
    end
    inherited tblDetailsAssetAccnt: TWideStringField [148]
    end
    inherited tblDetailsCogsAccnt: TWideStringField [149]
    end
    inherited tblDetailsCalcPriceInc: TCurrencyField [150]
    end
    inherited tblDetailsCalcTotalInc: TCurrencyField [151]
    end
    inherited tblDetailsCalcTotalEx: TCurrencyField [152]
    end
    inherited tblDetailsCalcTax: TCurrencyField [153]
    end
    inherited tblDetailsCalcBackOrder: TFloatField [154]
    end
    inherited tblDetailsCalcLinePriceEx: TCurrencyField [155]
    end
    inherited tblDetailsCalcTotalIncB4Discount: TCurrencyField [156]
    end
    inherited tblDetailsLastLineID: TIntegerField [157]
    end
    inherited tblDetailsUnitofMeasureMultiplier: TFloatField [158]
    end
    inherited tblDetailsForeignExchangeSellRate: TFloatField [159]
    end
    inherited tblDetailsForeignTotalLineAmount: TFloatField [160]
    end
    inherited tblDetailsCalcProfitEx: TCurrencyField [161]
    end
    inherited tblDetailsCalcProfitPercentEx: TCurrencyField [162]
    end
    inherited tblDetailsSearchFilter: TWideStringField [163]
    end
    inherited tblDetailsSearchFilterCopy: TWideStringField [164]
    end
    inherited tblDetailsIsRelatedProduct: TWideStringField [165]
    end
    inherited tblDetailsRelatedParentProductID: TIntegerField [166]
    end
    inherited tblDetailsCostCentreId: TIntegerField [167]
    end
    inherited tblDetailsUseHedging: TWideStringField [168]
    end
    inherited tblDetailsPartSpecID: TIntegerField [169]
    end
    inherited tblDetailsCreationDate: TDateTimeField [170]
    end
    inherited tblDetailsSoldSerials: TWideMemoField [171]
    end
    inherited tblDetailsLineNotes: TWideMemoField [172]
    end
    inherited tblDetailsCustomData: TWideMemoField [173]
    end
    inherited tblDetailsUnitOfMeasureID: TIntegerField [174]
    end
    inherited tblDetailsRelatedParentLineRef: TWideStringField [175]
    end
    inherited tblDetailsRelatedProductQty: TFloatField [176]
    end
    inherited tblDetailsIsFormulaRElatedProduct: TWideStringField [177]
    end
    inherited tblDetailsFormulaID: TIntegerField [178]
    end
    inherited tblDetailsMatrixRef: TWideMemoField [179]
    end
    inherited tblDetailsmsTimeStamp: TDateTimeField [180]
    end
    inherited tblDetailsmsUpdateSiteCode: TWideStringField [181]
    end
    inherited tblDetailsLinePrice: TFloatField [182]
    end
    inherited tblDetailsSortId: TIntegerField [183]
    end
    inherited tbldetailsMargin: TFloatField [184]
    end
    inherited tbldetailsMarginPercent: TFloatField [185]
    end
    inherited tblDetailsPurchaseCost: TFloatField [186]
      Visible = False
    end
    inherited tblDetailsISVoucher: TWideStringField [187]
    end
    inherited tblDetailsProductPrintName: TWideStringField [188]
    end
    inherited tblDetailsPackWeightField1: TFloatField [189]
    end
    inherited tblDetailsPackWeightfield2: TFloatField [190]
    end
    inherited tblDetailsPackCount: TFloatField [191]
    end
    inherited tblDetailsBOMComments: TWideStringField [192]
    end
    inherited tblDetailsRelatedProductProdLine: TIntegerField [193]
    end
    inherited tblDetailsRelatedProductPatternName: TWideStringField [194]
    end
    inherited tblDetailsRelatedProductFormulaDescription: TWideStringField [195]
    end
    inherited tblDetailsETDDate: TDateTimeField [196]
    end
    inherited tblDetailsUOMQtyInStock: TFloatField [197]
    end
    inherited tblDetailsUOMQtyAvailable: TFloatField [198]
    end
    inherited tblDetailsOrgProductPrice: TFloatField [199]
      Visible = False
    end
    inherited tblDetailsOrgProductPriceInc: TFloatField [200]
    end
    inherited tblDetailsDiscountedPriceInc: TFloatField [201]
    end
    object tblDetailsLastUpdated: TDateTimeField [202]
      DisplayWidth = 18
      FieldName = 'LastUpdated'
      Origin = 'tblsaleslines.LastUpdated'
      Visible = False
    end
    object tblDetailsIsQuote: TWideStringField [203]
      DisplayWidth = 1
      FieldName = 'IsQuote'
      Origin = 'tblsaleslines.IsQuote'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsTreeFinalized: TWideStringField [204]
      FieldName = 'TreeFinalized'
      Origin = 'tblsaleslines.TreeFinalized'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsExcludeFromSmartOrder: TWideStringField [205]
      FieldName = 'ExcludeFromSmartOrder'
      FixedChar = True
      Size = 1
    end
    inherited tblDetailsDiscountedPrice: TFloatField [206]
    end
    inherited tblDetailsTotalDiscountedPriceInc: TFloatField [207]
    end
    inherited tblDetailsTotalDiscountedPrice: TFloatField [208]
    end
  end
  inherited cboClientLookup: TERPQuery
    Left = 308
    Top = 331
  end
  inherited cboEmployeeLookup: TERPQuery
    Left = 335
    Top = 331
  end
  inherited cboClassQry: TERPQuery
    Left = 281
    Top = 331
  end
  inherited qryBaseForeignCurrency: TERPQuery
    Left = 226
    Top = 331
  end
  inherited qryClientLookup: TERPQuery
    AfterOpen = qryClientLookupAfterOpen
    Left = 964
    Top = 331
  end
  inherited imgPopup: TImageList
    Left = 457
    Bitmap = {
      494C010104000C02A00410001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 619
  end
  inherited qryUnitOfMeasure: TERPQuery
    Left = 608
    Top = 331
  end
  inherited mnuDiscountTotal: TAdvPopupMenu
    Left = 335
  end
  inherited cboAccountQry: TERPQuery
    Left = 390
    Top = 331
  end
  inherited qrySupplier: TERPQuery
    Left = 445
    Top = 331
  end
  inherited DMTextTargetSales: TDMTextTarget
    Left = 294
  end
  inherited qryPartsSpecs: TERPQuery
    Left = 745
    Top = 331
  end
  inherited cboTermsQry: TERPQuery
    Left = 417
    Top = 331
  end
  inherited dlgMemoLine: TwwMemoDialog
    Left = 213
  end
  inherited tblFESalesLines: TERPQuery
    Left = 89
    Top = 331
  end
  inherited tblFESaleslinesRelatedPrs: TERPQuery
    Left = 117
    Top = 331
  end
  inherited dsFESalesLines: TDataSource
    Left = 89
    Top = 365
  end
  inherited dsFESaleslinesRelatedPrs: TDataSource
    Left = 117
    Top = 365
  end
  object qryWorkOrderPriority: TERPQuery [40]
    SQL.Strings = (
      'SELECT Concat('#39'None'#39', Space(251)) AS Text, 0 AS Color'
      'UNION'
      'SELECT Text, Color'
      'FROM tbllistlinecolor '
      'WHERE (GroupType = '#39'WorkOrderStatus'#39') AND (Active = '#39'T'#39')')
    Left = 800
    Top = 331
    object qryWorkOrderPriorityText: TWideStringField
      DisplayWidth = 20
      FieldName = 'Text'
      FixedChar = True
      Size = 255
    end
    object qryWorkOrderPriorityColor: TLargeintField
      FieldName = 'Color'
      Visible = False
    end
  end
  object qryGetPriority: TERPQuery [41]
    SQL.Strings = (
      'SELECT llc.Text'
      'FROM tblprocess p'
      'INNER JOIN tblprocesslines pl USING(ProcessID)'
      'INNER JOIN tbllistlinecolor llc ON pl.LineColor = llc.Color'
      
        'WHERE (p.SaleID = :SaleID) AND (llc.GroupType = '#39'WorkOrderStatus' +
        #39') AND (llc.Active = '#39'T'#39')')
    Left = 854
    Top = 331
    ParamData = <
      item
        DataType = ftString
        Name = 'SaleID'
        Value = ''
      end>
  end
  inherited qryShipContainerSaleLookup: TERPQuery
    Left = 663
    Top = 331
  end
  inherited tblEquipmentxRefs: TERPQuery
    Left = 171
    Top = 331
  end
  inherited cboProductQry: TERPQuery
    SQL.Strings = (
      
        '#DUMMY QUERY - Sales.Formcreate dynamically changes the query fo' +
        'r seach options '
      ''
      'SELECT '
      'SUBSTRING_INDEX(P.ProductGroup,'#39'^'#39',1) AS Dept  , '
      
        'substring(substring_index(P.ProductGroup,'#39'^'#39',2),char_length(subs' +
        'tring_index(P.ProductGroup,'#39'^'#39',1))+2) AS Type  ,'
      
        'substring(substring_index(P.ProductGroup,'#39'^'#39',3),char_length(subs' +
        'tring_index(P.ProductGroup,'#39'^'#39',2))+2) AS Manuf  ,'
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
      ''
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
    Left = 581
    Top = 331
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 375
  end
  inherited Qrysalesshippingdetails: TERPQuery
    Left = 690
    Top = 331
  end
  inherited qryUOMLookup: TMyQuery
    Left = 827
    Top = 331
  end
  inherited QryRelatedMaster: TERPQuery
    Left = 636
    Top = 331
  end
  inherited DataState: TDataState
    Left = 497
  end
  inherited QrySalesCAtegory: TERPQuery
    Left = 882
    Top = 331
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 50
  end
  inherited imgsort: TImageList
    Left = 579
    Bitmap = {
      494C010102001C02B00410001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 772
    Top = 331
  end
  inherited QryAreaCodeLk: TERPQuery
    Left = 718
    Top = 331
  end
  inherited cbTaxCodeQry: TERPQuery
    Left = 472
    Top = 331
  end
  inherited qryMemTrans: TERPQuery
    Connection = MyConnection
    Left = 526
    Top = 331
  end
  inherited SaveDialog1: TSaveDialog
    Left = 530
  end
  inherited QryCustomField: TERPQuery
    Left = 199
    Top = 331
  end
  inherited TmrCommentshint: TTimer
    Left = 741
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Top = 160
  end
  inherited cboViaQry: TERPQuery
    Left = 363
    Top = 331
  end
  inherited QryAreaCodes: TERPQuery
    Left = 499
    Top = 331
  end
  inherited qrySalesQuantities: TERPQuery
    Left = 144
    Top = 331
  end
  object qrysalesdeliverydetails: TERPQuery [70]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblsalesdeliverydetails'
      'WHERE SaleID = :ID')
    AfterOpen = qrysalesdeliverydetailsAfterOpen
    Left = 8
    Top = 331
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
  object dssalesdeliverydetails: TDataSource [71]
    DataSet = qrysalesdeliverydetails
    Left = 8
    Top = 365
  end
  inherited qryCostCentre: TERPQuery
    Left = 554
    Top = 331
  end
end
