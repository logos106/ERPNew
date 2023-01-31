inherited PurchasesPrefsGUI: TPurchasesPrefsGUI
  Left = 260
  Top = 89
  HelpContext = 458000
  VertScrollBar.Tracking = True
  ActiveControl = cboDutiesAccount
  Caption = 'Purchases Preferences'
  ClientHeight = 922
  ClientWidth = 905
  OldCreateOrder = True
  ExplicitLeft = 496
  ExplicitTop = 28
  ExplicitLeft = 260
  ExplicitTop = 89
  ExplicitWidth = 921
  ExplicitHeight = 961
  PixelsPerInch = 96
  TextHeight = 13
  object lblWidth: TLabel [0]
    Left = 15
    Top = 8
    Width = 863
    Height = 22
    HelpContext = 458001
    Caption = 
      'All panels should have a width of 545.  Panel TabOrder is used f' +
      'or panel placement sequence.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited lblSkingroupMsg: TLabel
    Top = 922
    Width = 905
    HelpContext = 458069
    ExplicitTop = 647
    ExplicitWidth = 905
  end
  object DNMPanel4: TDNMPanel [5]
    Left = 20
    Top = 162
    Width = 559
    Height = 230
    HelpContext = 458100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object Bevel4: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 545
      Height = 216
      HelpContext = 458101
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Shape = bsFrame
      ExplicitLeft = 8
      ExplicitHeight = 185
    end
    object Label17: TLabel
      Left = 14
      Top = 14
      Width = 118
      Height = 15
      HelpContext = 458102
      Caption = 'Smart Order Options'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label19: TLabel
      Left = 27
      Top = 41
      Width = 249
      Height = 15
      HelpContext = 458017
      Alignment = taRightJustify
      Caption = 'Maximum Value Allowable on a Smart Order'
      Transparent = True
    end
    object Label5: TLabel
      Left = 27
      Top = 73
      Width = 257
      Height = 15
      HelpContext = 458071
      Alignment = taRightJustify
      Caption = 'Allow Conversion of a Converted Smart Order'
      Transparent = True
    end
    object Label39: TLabel
      Left = 28
      Top = 189
      Width = 380
      Height = 15
      HelpContext = 458103
      Caption = 
        'Measure for volume in Smart Order:                             (' +
        'ie. mm, inches)'
      Transparent = True
    end
    object wwDBEdit1: TwwDBEdit
      Left = 295
      Top = 38
      Width = 159
      Height = 23
      HelpContext = 458031
      DataField = 'MaxSmartAmount'
      DataSource = dsPrefs
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwCheckBox4: TwwCheckBox
      Left = 295
      Top = 73
      Width = 16
      Height = 17
      HelpContext = 458075
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
      Caption = 'wwCheckBox1'
      DataField = 'ConvertConvertedSmartOrder'
      DataSource = dsPrefs
      TabOrder = 1
    end
    object optTotalvolumeUOMInsmartOrder: TwwRadioGroup
      Left = 19
      Top = 100
      Width = 520
      Height = 77
      HelpContext = 458104
      DisableThemes = False
      Caption = 'Divide Total Volume in Smart Order  by '
      Columns = 5
      DataField = 'TotalvolumeUOMInsmartOrder'
      DataSource = dsPrefs
      Items.Strings = (
        'None'
        '10'
        '100'
        '1,000'
        '10,000'
        '100,000'
        '1,000,000'
        '10,000,000'
        '100,000,000'
        '1,000,000,000')
      TabOrder = 2
      Values.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9')
    end
    object wwDBEdit9: TwwDBEdit
      Left = 235
      Top = 187
      Width = 65
      Height = 23
      HelpContext = 458105
      DataField = 'UOMforTotalvolumeInsmartOrder'
      DataSource = dsPrefs
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  object DNMPanel5: TDNMPanel [6]
    Left = 8
    Top = 398
    Width = 545
    Height = 104
    HelpContext = 458113
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Bevel5: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 531
      Height = 90
      HelpContext = 458114
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Shape = bsFrame
      ExplicitLeft = 0
      ExplicitTop = 10
    end
    object Label28: TLabel
      Left = 14
      Top = 14
      Width = 166
      Height = 15
      HelpContext = 458115
      Caption = 'Import Cost Default Accounts'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label30: TLabel
      Left = 43
      Top = 35
      Width = 75
      Height = 15
      HelpContext = 458116
      Caption = 'Duty Account'
      Transparent = True
    end
    object Label29: TLabel
      Left = 296
      Top = 35
      Width = 99
      Height = 15
      HelpContext = 458117
      Caption = 'Handling Account'
      Transparent = True
    end
    object cboDutiesAccount: TwwDBLookupCombo
      Left = 43
      Top = 57
      Width = 169
      Height = 23
      HelpContext = 458118
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'30'#9'Account Name'#9'T'
        'Type'#9'20'#9'Type'#9'T')
      DataField = 'DutiesAccount'
      DataSource = dsPrefs
      LookupTable = qryAccExp
      LookupField = 'AccountID'
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnNotInList = cboDutiesAccountNotInList
    end
    object cboBrokerHandlingAccount: TwwDBLookupCombo
      Left = 296
      Top = 57
      Width = 169
      Height = 23
      HelpContext = 458119
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'30'#9'Account Name'#9'T'
        'Type'#9'20'#9'Type'#9'T')
      DataField = 'BrokerHandlingAccount'
      DataSource = dsPrefs
      LookupTable = qryAccExp
      LookupField = 'AccountID'
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnNotInList = cboDutiesAccountNotInList
    end
  end
  object DNMPanel2: TDNMPanel [8]
    Left = 16
    Top = 39
    Width = 545
    Height = 234
    HelpContext = 458094
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Bevel2: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 531
      Height = 220
      HelpContext = 458095
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Shape = bsFrame
      ExplicitLeft = 6
      ExplicitTop = 11
      ExplicitHeight = 160
    end
    object Label65: TLabel
      Left = 14
      Top = 14
      Width = 163
      Height = 15
      HelpContext = 458096
      Caption = 'Uninvoiced Purchase Orders'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label66: TLabel
      Left = 48
      Top = 40
      Width = 172
      Height = 15
      HelpContext = 458036
      Caption = 'Include Un-Invoiced PO'#39's to GL'
      Transparent = True
    end
    object Label67: TLabel
      Left = 24
      Top = 72
      Width = 90
      Height = 15
      HelpContext = 458037
      Caption = 'Default Account'
      Transparent = True
    end
    object Label34: TLabel
      Left = 45
      Top = 164
      Width = 124
      Height = 15
      HelpContext = 458110
      Caption = 'Enable Period Posting'
      Transparent = True
    end
    object Label35: TLabel
      Left = 14
      Top = 133
      Width = 148
      Height = 15
      HelpContext = 458111
      Caption = 'Invoiced Purchase Orders'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object lblPOHasPeriodPosting: TLabel
      Left = 46
      Top = 181
      Width = 360
      Height = 30
      HelpContext = 458134
      Caption = 
        '(Eg : When Selected, Purchase Order Received in One Month and It' +
        #39's '#39'Invoice'#39' Received in Next Month , will be 2 Different Postin' +
        'g )'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object chkIncludeUnInvoicedPOtoGL: TwwCheckBox
      Left = 24
      Top = 40
      Width = 16
      Height = 17
      HelpContext = 458038
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'IncludeUnInvoicedPOtoGL'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 0
    end
    object wwDBLookupCombo2: TwwDBLookupCombo
      Left = 24
      Top = 88
      Width = 169
      Height = 23
      HelpContext = 458039
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'30'#9'Account Name'#9'T'
        'Type'#9'20'#9'Type'#9'T')
      DataField = 'UnInvoicedPOAccount'
      DataSource = dsPrefs
      LookupTable = qryAccUnInvPO
      LookupField = 'AccountID'
      ParentFont = False
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object chkPOHasPeriodPosting: TwwCheckBox
      Left = 24
      Top = 164
      Width = 16
      Height = 17
      HelpContext = 458112
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'POHasPeriodPosting'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 2
    end
  end
  object DNMPanel14: TDNMPanel [9]
    Left = 58
    Top = 531
    Width = 545
    Height = 321
    HelpContext = 458040
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Bevel14: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 531
      Height = 307
      HelpContext = 458097
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Shape = bsFrame
      ExplicitLeft = 8
      ExplicitTop = 8
      ExplicitWidth = 529
      ExplicitHeight = 231
    end
    object Label71: TLabel
      Left = 48
      Top = 41
      Width = 64
      Height = 15
      HelpContext = 458042
      Caption = 'Show Units'
      Transparent = True
    end
    object Label72: TLabel
      Left = 48
      Top = 70
      Width = 115
      Height = 15
      HelpContext = 458043
      Caption = 'Show Customer Job'
      Transparent = True
    end
    object Label73: TLabel
      Left = 48
      Top = 100
      Width = 67
      Height = 15
      HelpContext = 458044
      Caption = 'Show Class'
      Transparent = True
    end
    object Label75: TLabel
      Left = 48
      Top = 189
      Width = 127
      Height = 15
      HelpContext = 458045
      Caption = 'Show Part Description'
      Transparent = True
    end
    object Label76: TLabel
      Left = 14
      Top = 14
      Width = 136
      Height = 15
      HelpContext = 458046
      Caption = 'Purchase Lines Options'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label77: TLabel
      Left = 48
      Top = 129
      Width = 87
      Height = 15
      HelpContext = 458047
      Caption = 'Show Tax Code'
      Transparent = True
    end
    object Label78: TLabel
      Left = 46
      Top = 159
      Width = 102
      Height = 15
      HelpContext = 458048
      Caption = 'Show Tax Amount'
      Transparent = True
    end
    object Label81: TLabel
      Left = 268
      Top = 41
      Width = 137
      Height = 15
      HelpContext = 458051
      Caption = 'Show Account Numbers'
      Transparent = True
    end
    object lblDisableAltSaveCost: TLabel
      Left = 268
      Top = 70
      Width = 188
      Height = 15
      Hint = 
        'Changing Purchase Cost will Update Product'#39's Cost when Product'#39's' +
        ' '#39'Auto Price Update'#39' is Selected'
      HelpContext = 458052
      Caption = 'Disable "Alter Save Cost" prompt'
      Transparent = True
    end
    object Label83: TLabel
      Left = 268
      Top = 100
      Width = 169
      Height = 15
      HelpContext = 458053
      Caption = 'Show Docket Number Column'
      Transparent = True
    end
    object Label85: TLabel
      Left = 268
      Top = 129
      Width = 154
      Height = 15
      HelpContext = 458055
      Caption = 'Use Product Specifications'
      Transparent = True
    end
    object Label16: TLabel
      Left = 48
      Top = 289
      Width = 221
      Height = 15
      HelpContext = 458098
      Caption = 'Filter Taxcode for the selected Supplier'
      Transparent = True
    end
    object Label24: TLabel
      Left = 268
      Top = 159
      Width = 163
      Height = 15
      HelpContext = 458106
      Caption = 'Auto Append Batch Numbers'
      Transparent = True
    end
    object Label38: TLabel
      Left = 268
      Top = 186
      Width = 257
      Height = 15
      Caption = 'Disable Purchase Line Zero Quantity Warning'
      Transparent = True
    end
    object wwCheckBox42: TwwCheckBox
      Left = 24
      Top = 40
      Width = 16
      Height = 17
      HelpContext = 458056
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
      Caption = 'wwCheckBox1'
      DataField = 'ShowPurchUnits'
      DataSource = dsPrefs
      TabOrder = 0
    end
    object wwCheckBox43: TwwCheckBox
      Left = 24
      Top = 69
      Width = 16
      Height = 17
      HelpContext = 458057
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
      Caption = 'wwCheckBox1'
      DataField = 'ShowPurchCustJob'
      DataSource = dsPrefs
      TabOrder = 1
    end
    object wwCheckBox44: TwwCheckBox
      Left = 24
      Top = 99
      Width = 16
      Height = 17
      HelpContext = 458058
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'ShowPurchClass'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 2
    end
    object wwCheckBox46: TwwCheckBox
      Left = 24
      Top = 189
      Width = 16
      Height = 17
      HelpContext = 458059
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'ShowPurchDescription'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 5
    end
    object wwCheckBox47: TwwCheckBox
      Left = 24
      Top = 129
      Width = 16
      Height = 17
      HelpContext = 458060
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'ShowPurchTaxCode'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 3
    end
    object wwCheckBox48: TwwCheckBox
      Left = 24
      Top = 159
      Width = 16
      Height = 17
      HelpContext = 458061
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'ShowPurchTaxAmount'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 4
    end
    object wwCheckBox51: TwwCheckBox
      Left = 244
      Top = 40
      Width = 16
      Height = 17
      HelpContext = 458064
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
      Caption = 'wwCheckBox1'
      DataField = 'ShowAccountNumbers'
      DataSource = dsPrefs
      TabOrder = 6
    end
    object chkDisableAltSaveCost: TwwCheckBox
      Left = 244
      Top = 69
      Width = 16
      Height = 17
      Hint = 
        'Changing Purchase Cost will Update Product'#39's Cost when Product'#39's' +
        ' '#39'Auto Price Update'#39' is Selected'
      HelpContext = 458065
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
      Caption = 'wwCheckBox1'
      DataField = 'DisableAltSaveCost'
      DataSource = dsPrefs
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = chkDisableAltSaveCostClick
    end
    object wwCheckBox53: TwwCheckBox
      Left = 244
      Top = 99
      Width = 16
      Height = 17
      HelpContext = 458066
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
      Caption = 'wwCheckBox1'
      DataField = 'ShowDocketNumberColumnOnPO'
      DataSource = dsPrefs
      TabOrder = 8
    end
    object wwCheckBox55: TwwCheckBox
      Left = 244
      Top = 129
      Width = 16
      Height = 17
      HelpContext = 458068
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
      Caption = 'wwCheckBox1'
      DataField = 'UseProductSpecsCalcsPO'
      DataSource = dsPrefs
      TabOrder = 9
    end
    object wwRadioGroup2: TwwRadioGroup
      Left = 24
      Top = 216
      Width = 500
      Height = 64
      HelpContext = 458086
      DisableThemes = False
      TransparentActiveItem = True
      Indents.TextX = 5
      Transparent = True
      NoSpacing = True
      Caption = #39'Area'#39' gets value by default from'
      Columns = 3
      DataField = 'PODefaultValueForAreaFrom'
      DataSource = dsPrefs
      Items.Strings = (
        'Supplier'#39's Area'
        'Product'#39's Area'
        'None')
      TabOrder = 10
      Values.Strings = (
        'S'
        'P'
        'N')
    end
    object wwCheckBox21: TwwCheckBox
      Left = 24
      Top = 289
      Width = 16
      Height = 17
      HelpContext = 458099
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
      Caption = 'Filter Taxcode for the selected Supplier'
      Checked = True
      DataField = 'filterTaxcodeforClient'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 11
    end
    object chkAutoAppendBatchNumber: TwwCheckBox
      Left = 244
      Top = 159
      Width = 16
      Height = 17
      HelpContext = 458107
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
      Caption = 'wwCheckBox1'
      DataField = 'AutoAppendBatchNumber'
      DataSource = dsPrefs
      TabOrder = 12
    end
    object chkDisablePurchaseLineZeroQuantityWarning: TwwCheckBox
      Left = 244
      Top = 186
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      DataField = 'DisablePurchaseLineZeroQuantityWarning'
      DataSource = dsPrefs
      TabOrder = 13
    end
  end
  object DNMPanel1: TDNMPanel [10]
  object DNMPanel14: TDNMPanel [7]
    Left = 58
    Top = 531
    Width = 545
    Height = 321
    HelpContext = 458040
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Bevel14: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 531
      Height = 307
      HelpContext = 458097
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Shape = bsFrame
      ExplicitLeft = 8
      ExplicitTop = 8
      ExplicitWidth = 529
      ExplicitHeight = 231
    end
    object Label71: TLabel
      Left = 48
      Top = 41
      Width = 64
      Height = 15
      HelpContext = 458042
      Caption = 'Show Units'
      Transparent = True
    end
    object Label72: TLabel
      Left = 48
      Top = 70
      Width = 115
      Height = 15
      HelpContext = 458043
      Caption = 'Show Customer Job'
      Transparent = True
    end
    object Label73: TLabel
      Left = 48
      Top = 100
      Width = 67
      Height = 15
      HelpContext = 458044
      Caption = 'Show Class'
      Transparent = True
    end
    object Label75: TLabel
      Left = 48
      Top = 189
      Width = 127
      Height = 15
      HelpContext = 458045
      Caption = 'Show Part Description'
      Transparent = True
    end
    object Label76: TLabel
      Left = 14
      Top = 14
      Width = 136
      Height = 15
      HelpContext = 458046
      Caption = 'Purchase Lines Options'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label77: TLabel
      Left = 48
      Top = 129
      Width = 87
      Height = 15
      HelpContext = 458047
      Caption = 'Show Tax Code'
      Transparent = True
    end
    object Label78: TLabel
      Left = 46
      Top = 159
      Width = 102
      Height = 15
      HelpContext = 458048
      Caption = 'Show Tax Amount'
      Transparent = True
    end
    object Label81: TLabel
      Left = 268
      Top = 41
      Width = 137
      Height = 15
      HelpContext = 458051
      Caption = 'Show Account Numbers'
      Transparent = True
    end
    object lblDisableAltSaveCost: TLabel
      Left = 268
      Top = 70
      Width = 188
      Height = 15
      Hint = 
        'Changing Purchase Cost will Update Product'#39's Cost when Product'#39's' +
        ' '#39'Auto Price Update'#39' is Selected'
      HelpContext = 458052
      Caption = 'Disable "Alter Save Cost" prompt'
      Transparent = True
    end
    object Label83: TLabel
      Left = 268
      Top = 100
      Width = 169
      Height = 15
      HelpContext = 458053
      Caption = 'Show Docket Number Column'
      Transparent = True
    end
    object Label85: TLabel
      Left = 268
      Top = 129
      Width = 154
      Height = 15
      HelpContext = 458055
      Caption = 'Use Product Specifications'
      Transparent = True
    end
    object Label16: TLabel
      Left = 48
      Top = 289
      Width = 221
      Height = 15
      HelpContext = 458098
      Caption = 'Filter Taxcode for the selected Supplier'
      Transparent = True
    end
    object Label24: TLabel
      Left = 268
      Top = 159
      Width = 163
      Height = 15
      HelpContext = 458106
      Caption = 'Auto Append Batch Numbers'
      Transparent = True
    end
    object Label38: TLabel
      Left = 268
      Top = 186
      Width = 257
      Height = 15
      Caption = 'Disable Purchase Line Zero Quantity Warning'
      Transparent = True
    end
    object wwCheckBox42: TwwCheckBox
      Left = 24
      Top = 40
      Width = 16
      Height = 17
      HelpContext = 458056
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
      Caption = 'wwCheckBox1'
      DataField = 'ShowPurchUnits'
      DataSource = dsPrefs
      TabOrder = 0
    end
    object wwCheckBox43: TwwCheckBox
      Left = 24
      Top = 69
      Width = 16
      Height = 17
      HelpContext = 458057
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
      Caption = 'wwCheckBox1'
      DataField = 'ShowPurchCustJob'
      DataSource = dsPrefs
      TabOrder = 1
    end
    object wwCheckBox44: TwwCheckBox
      Left = 24
      Top = 99
      Width = 16
      Height = 17
      HelpContext = 458058
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'ShowPurchClass'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 2
    end
    object wwCheckBox46: TwwCheckBox
      Left = 24
      Top = 189
      Width = 16
      Height = 17
      HelpContext = 458059
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'ShowPurchDescription'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 5
    end
    object wwCheckBox47: TwwCheckBox
      Left = 24
      Top = 129
      Width = 16
      Height = 17
      HelpContext = 458060
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'ShowPurchTaxCode'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 3
    end
    object wwCheckBox48: TwwCheckBox
      Left = 24
      Top = 159
      Width = 16
      Height = 17
      HelpContext = 458061
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'ShowPurchTaxAmount'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 4
    end
    object wwCheckBox51: TwwCheckBox
      Left = 244
      Top = 40
      Width = 16
      Height = 17
      HelpContext = 458064
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
      Caption = 'wwCheckBox1'
      DataField = 'ShowAccountNumbers'
      DataSource = dsPrefs
      TabOrder = 6
    end
    object chkDisableAltSaveCost: TwwCheckBox
      Left = 244
      Top = 69
      Width = 16
      Height = 17
      Hint = 
        'Changing Purchase Cost will Update Product'#39's Cost when Product'#39's' +
        ' '#39'Auto Price Update'#39' is Selected'
      HelpContext = 458065
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
      Caption = 'wwCheckBox1'
      DataField = 'DisableAltSaveCost'
      DataSource = dsPrefs
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = chkDisableAltSaveCostClick
    end
    object wwCheckBox53: TwwCheckBox
      Left = 244
      Top = 99
      Width = 16
      Height = 17
      HelpContext = 458066
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
      Caption = 'wwCheckBox1'
      DataField = 'ShowDocketNumberColumnOnPO'
      DataSource = dsPrefs
      TabOrder = 8
    end
    object wwCheckBox55: TwwCheckBox
      Left = 244
      Top = 129
      Width = 16
      Height = 17
      HelpContext = 458068
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
      Caption = 'wwCheckBox1'
      DataField = 'UseProductSpecsCalcsPO'
      DataSource = dsPrefs
      TabOrder = 9
    end
    object wwRadioGroup2: TwwRadioGroup
      Left = 24
      Top = 216
      Width = 500
      Height = 64
      HelpContext = 458086
      DisableThemes = False
      TransparentActiveItem = True
      Indents.TextX = 5
      Transparent = True
      NoSpacing = True
      Caption = #39'Area'#39' gets value by default from'
      Columns = 3
      DataField = 'PODefaultValueForAreaFrom'
      DataSource = dsPrefs
      Items.Strings = (
        'Supplier'#39's Area'
        'Product'#39's Area'
        'None')
      TabOrder = 10
      Values.Strings = (
        'S'
        'P'
        'N')
    end
    object wwCheckBox21: TwwCheckBox
      Left = 24
      Top = 289
      Width = 16
      Height = 17
      HelpContext = 458099
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
      Caption = 'Filter Taxcode for the selected Supplier'
      Checked = True
      DataField = 'filterTaxcodeforClient'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 11
    end
    object chkAutoAppendBatchNumber: TwwCheckBox
      Left = 244
      Top = 159
      Width = 16
      Height = 17
      HelpContext = 458107
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
      Caption = 'wwCheckBox1'
      DataField = 'AutoAppendBatchNumber'
      DataSource = dsPrefs
      TabOrder = 12
    end
    object chkDisablePurchaseLineZeroQuantityWarning: TwwCheckBox
      Left = 244
      Top = 186
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      DataField = 'DisablePurchaseLineZeroQuantityWarning'
      DataSource = dsPrefs
      TabOrder = 13
    end
  end
  object DNMPanel1: TDNMPanel [8]
  object DNMPanel2: TDNMPanel [8]
    Left = 16
    Top = 39
    Width = 545
    Height = 234
    HelpContext = 458094
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Bevel2: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 531
      Height = 220
      HelpContext = 458095
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Shape = bsFrame
      ExplicitLeft = 6
      ExplicitTop = 11
      ExplicitHeight = 160
    end
    object Label65: TLabel
      Left = 14
      Top = 14
      Width = 163
      Height = 15
      HelpContext = 458096
      Caption = 'Uninvoiced Purchase Orders'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label66: TLabel
      Left = 48
      Top = 40
      Width = 172
      Height = 15
      HelpContext = 458036
      Caption = 'Include Un-Invoiced PO'#39's to GL'
      Transparent = True
    end
    object Label67: TLabel
      Left = 24
      Top = 72
      Width = 90
      Height = 15
      HelpContext = 458037
      Caption = 'Default Account'
      Transparent = True
    end
    object Label34: TLabel
      Left = 45
      Top = 164
      Width = 124
      Height = 15
      HelpContext = 458110
      Caption = 'Enable Period Posting'
      Transparent = True
    end
    object Label35: TLabel
      Left = 14
      Top = 133
      Width = 148
      Height = 15
      HelpContext = 458111
      Caption = 'Invoiced Purchase Orders'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object lblPOHasPeriodPosting: TLabel
      Left = 46
      Top = 181
      Width = 360
      Height = 30
      HelpContext = 458134
      Caption = 
        '(Eg : When Selected, Purchase Order Received in One Month and It' +
        #39's '#39'Invoice'#39' Received in Next Month , will be 2 Different Postin' +
        'g )'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object chkIncludeUnInvoicedPOtoGL: TwwCheckBox
      Left = 24
      Top = 40
      Width = 16
      Height = 17
      HelpContext = 458038
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'IncludeUnInvoicedPOtoGL'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 0
    end
    object wwDBLookupCombo2: TwwDBLookupCombo
      Left = 24
      Top = 88
      Width = 169
      Height = 23
      HelpContext = 458039
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'30'#9'Account Name'#9'T'
        'Type'#9'20'#9'Type'#9'T')
      DataField = 'UnInvoicedPOAccount'
      DataSource = dsPrefs
      LookupTable = qryAccUnInvPO
      LookupField = 'AccountID'
      ParentFont = False
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object chkPOHasPeriodPosting: TwwCheckBox
      Left = 24
      Top = 164
      Width = 16
      Height = 17
      HelpContext = 458112
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'POHasPeriodPosting'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 2
    end
  end
  object DNMPanel1: TDNMPanel [9]
    Left = 310
    Top = 36
    Width = 545
    Height = 789
    HelpContext = 458002
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Bevel1: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 531
      Height = 775
      HelpContext = 458041
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Shape = bsFrame
      ExplicitLeft = 3
      ExplicitTop = 3
      ExplicitHeight = 839
    end
    object Label1: TLabel
      Left = 14
      Top = 14
      Width = 44
      Height = 15
      HelpContext = 458004
      Caption = 'General'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 47
      Top = 40
      Width = 201
      Height = 15
      HelpContext = 458005
      Caption = 'Print Barcodes on Receipt of Goods'
      Transparent = True
    end
    object Label3: TLabel
      Left = 47
      Top = 66
      Width = 191
      Height = 15
      HelpContext = 458006
      Caption = 'Print Barcodes on Order of Goods'
      Transparent = True
    end
    object Label4: TLabel
      Left = 47
      Top = 93
      Width = 211
      Height = 15
      HelpContext = 458007
      Caption = 'Print Store Away on Receipt of Goods'
      Transparent = True
    end
    object Label6: TLabel
      Left = 47
      Top = 146
      Width = 221
      Height = 15
      HelpContext = 458009
      Caption = 'Disable Make Preferred Supplier on PO'
      Transparent = True
    end
    object Label7: TLabel
      Left = 47
      Top = 200
      Width = 134
      Height = 15
      HelpContext = 458010
      Caption = 'Enforce ETA Date on PO'
      Transparent = True
    end
    object Label8: TLabel
      Left = 47
      Top = 226
      Width = 221
      Height = 15
      HelpContext = 458011
      Caption = 'Include Landed Costs in Average Costs'
      Transparent = True
    end
    object Label9: TLabel
      Left = 47
      Top = 280
      Width = 287
      Height = 15
      HelpContext = 458012
      Caption = 'Sum (Received Products only) on Foreign Currency'
      Transparent = True
    end
    object Label10: TLabel
      Left = 47
      Top = 173
      Width = 239
      Height = 15
      HelpContext = 458013
      Caption = 'Store Foreign Currency Value and Supplier'
      Transparent = True
    end
    object Label11: TLabel
      Left = 47
      Top = 253
      Width = 227
      Height = 15
      HelpContext = 458014
      Caption = 'Remember Last Transaction by Supplier'
      Transparent = True
    end
    object Label13: TLabel
      Left = 304
      Top = 40
      Width = 195
      Height = 15
      HelpContext = 458015
      Caption = 'Default Accounts Payable Account'
      Transparent = True
    end
    object Label14: TLabel
      Left = 304
      Top = 85
      Width = 188
      Height = 15
      HelpContext = 458016
      Caption = 'Default Supplier Payment Method'
      Transparent = True
    end
    object Label15: TLabel
      Left = 304
      Top = 134
      Width = 171
      Height = 15
      HelpContext = 458018
      Caption = 'Begin Transactions at Number'
      Transparent = True
    end
    object Label12: TLabel
      Left = 47
      Top = 120
      Width = 198
      Height = 15
      HelpContext = 458087
      Caption = 'Update Sale When Goods Received'
      Transparent = True
    end
    object Label20: TLabel
      Left = 47
      Top = 306
      Width = 225
      Height = 15
      HelpContext = 458070
      Caption = 'Exclude Back-Ordered Items From Print'
      Transparent = True
    end
    object Label18: TLabel
      Left = 47
      Top = 333
      Width = 253
      Height = 15
      HelpContext = 458050
      Caption = 'Enforce Con Note Number in Purchase Order'
      Transparent = True
    end
    object Label21: TLabel
      Left = 47
      Top = 386
      Width = 122
      Height = 15
      HelpContext = 458088
      Caption = 'Use Foreign Currency'
      Transparent = True
    end
    object Label22: TLabel
      Left = 47
      Top = 413
      Width = 212
      Height = 15
      HelpContext = 458089
      Caption = 'Can Remove Supplier Invoice Number'
      Transparent = True
    end
    object Label23: TLabel
      Left = 304
      Top = 181
      Width = 126
      Height = 15
      HelpContext = 458090
      Caption = 'Default RA Line Status'
      Transparent = True
    end
    object Label48: TLabel
      Left = 47
      Top = 440
      Width = 211
      Height = 15
      HelpContext = 458072
      Caption = 'Warn When Creation date is in Future'
      Transparent = True
    end
    object Label25: TLabel
      Left = 47
      Top = 466
      Width = 424
      Height = 15
      HelpContext = 458073
      Caption = 
        'Use the Address of Current Logged User'#39's Default Department  for' +
        ' '#39'Ship To'#39
      Transparent = True
    end
    object Label27: TLabel
      Left = 47
      Top = 360
      Width = 254
      Height = 15
      HelpContext = 458108
      Caption = 'Enforce Con Note Number in Return Authority'
      Transparent = True
    end
    object Label31: TLabel
      Left = 47
      Top = 547
      Width = 430
      Height = 15
      HelpContext = 458120
      Caption = 
        'Print Labels on Receipt of Goods for Products Allocated to Custo' +
        'mer Orders'
      Transparent = True
    end
    object Label32: TLabel
      Left = 47
      Top = 493
      Width = 483
      Height = 15
      HelpContext = 458121
      Caption = 
        'Email Customer On Receipt of All Products Allocated to Customer ' +
        'Orders (Messages)'
      Transparent = True
    end
    object Label33: TLabel
      Left = 47
      Top = 520
      Width = 465
      Height = 15
      HelpContext = 458122
      Caption = 
        'Email Employee On Receipt of Products Allocated to Customer Orde' +
        'rs (Messages)'
      Transparent = True
    end
    object Bevel19: TBevel
      Left = 23
      Top = 633
      Width = 473
      Height = 42
      HelpContext = 458123
      Shape = bsFrame
    end
    object lblFuturePurchaseOrders: TLabel
      Left = 63
      Top = 647
      Width = 162
      Height = 15
      HelpContext = 458124
      Caption = 'Use Future Purchase Orders'
      Transparent = True
    end
    object lblFuturePurchaseOrders1: TLabel
      Left = 273
      Top = 647
      Width = 84
      Height = 15
      HelpContext = 458125
      Caption = 'Due Date Over '
      Transparent = True
    end
    object Label36: TLabel
      Left = 45
      Top = 568
      Width = 142
      Height = 15
      HelpContext = 458131
      Caption = '(Product Received Label)'
      Transparent = True
    end
    object Label37: TLabel
      Left = 23
      Top = 598
      Width = 179
      Height = 15
      HelpContext = 458132
      AutoSize = False
      Caption = 'Sales Backorder Check Type'
    end
    object Label172: TLabel
      Left = 48
      Top = 752
      Width = 285
      Height = 15
      HelpContext = 484375
      Caption = 'Purchase Area gets value by Default from Supplier'
      Transparent = True
    end
    object Label40: TLabel
      Left = 304
      Top = 229
      Width = 163
      Height = 15
      HelpContext = 458016
      Caption = 'Default Store Away Template'
      Transparent = True
    end
    object wwCheckBox1: TwwCheckBox
      Left = 23
      Top = 39
      Width = 16
      Height = 17
      HelpContext = 458019
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
      Caption = 'wwCheckBox1'
      DataField = 'PrintBarcodesOnReceival'
      DataSource = dsPrefs
      TabOrder = 0
    end
    object wwCheckBox2: TwwCheckBox
      Left = 23
      Top = 65
      Width = 16
      Height = 17
      HelpContext = 458020
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
      Caption = 'wwCheckBox1'
      DataField = 'PrintBarcodesOnOrder'
      DataSource = dsPrefs
      TabOrder = 1
    end
    object wwCheckBox3: TwwCheckBox
      Left = 23
      Top = 92
      Width = 16
      Height = 17
      HelpContext = 458021
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'PrintStoreAwayOnReceival'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 2
    end
    object wwCheckBox5: TwwCheckBox
      Left = 23
      Top = 145
      Width = 16
      Height = 17
      HelpContext = 458023
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
      Caption = 'wwCheckBox1'
      DataField = 'NoPreferredSuppQuestion'
      DataSource = dsPrefs
      TabOrder = 3
    end
    object wwCheckBox6: TwwCheckBox
      Left = 23
      Top = 199
      Width = 16
      Height = 17
      HelpContext = 458024
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
      Caption = 'wwCheckBox1'
      DataField = 'POenforceETA'
      DataSource = dsPrefs
      TabOrder = 5
    end
    object wwCheckBox7: TwwCheckBox
      Left = 23
      Top = 225
      Width = 16
      Height = 17
      HelpContext = 458025
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
      Caption = 'wwCheckBox1'
      DataField = 'IncludeLandedCostsinAvgCost'
      DataSource = dsPrefs
      TabOrder = 6
    end
    object wwCheckBox8: TwwCheckBox
      Left = 23
      Top = 279
      Width = 16
      Height = 17
      HelpContext = 458026
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
      Caption = 'wwCheckBox1'
      DataField = 'SumReceivedOnlyForeignCurrencyonPO'
      DataSource = dsPrefs
      TabOrder = 7
    end
    object wwCheckBox9: TwwCheckBox
      Left = 23
      Top = 172
      Width = 16
      Height = 17
      HelpContext = 458027
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'StoreForeignCurrencyValue'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 4
    end
    object wwCheckBox10: TwwCheckBox
      Left = 23
      Top = 252
      Width = 16
      Height = 17
      HelpContext = 458028
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'RememberLastTransactionBySupplier'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 8
    end
    object cboUnInvoicedSOAccount: TwwDBLookupCombo
      Left = 304
      Top = 56
      Width = 201
      Height = 23
      HelpContext = 458029
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'30'#9'Account Name'#9'T'
        'Type'#9'20'#9'Type'#9'T'#9)
      DataField = 'DefaultPurchasesAccount'
      DataSource = dsPrefs
      LookupTable = qryAccount
      LookupField = 'AccountID'
      ParentFont = False
      TabOrder = 9
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object wwDBLookupCombo1: TwwDBLookupCombo
      Left = 304
      Top = 101
      Width = 201
      Height = 23
      HelpContext = 458030
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Name'#9'30'#9'Name'#9'T')
      DataField = 'DefaultPayMethodID'
      DataSource = dsPrefs
      LookupTable = qryPayMethod
      LookupField = 'PayMethodID'
      ParentFont = False
      TabOrder = 10
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object wwCheckBox11: TwwCheckBox
      Left = 23
      Top = 119
      Width = 16
      Height = 17
      HelpContext = 458091
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
      Caption = 'wwCheckBox1'
      DataField = 'UpdateSaleShippedFromPOReceived'
      DataSource = dsPrefs
      TabOrder = 12
    end
    object wwCheckBox15: TwwCheckBox
      Left = 23
      Top = 305
      Width = 16
      Height = 17
      HelpContext = 458074
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
      Caption = 'wwCheckBox1'
      DataField = 'ExcludeBOFromPrintinPO'
      DataSource = dsPrefs
      TabOrder = 13
    end
    object edtPurchasesStartNum: TAdvEdit
      Left = 304
      Top = 149
      Width = 177
      Height = 23
      HelpContext = 458032
      EditType = etNumeric
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'MS Sans Serif'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      Enabled = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      Text = '0'
      Visible = True
      Version = '2.8.6.9'
    end
    object wwCheckBox14: TwwCheckBox
      Left = 23
      Top = 332
      Width = 16
      Height = 17
      HelpContext = 458063
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
      Caption = 'wwCheckBox1'
      DataField = 'EnforceConNoteOnPO'
      DataSource = dsPrefs
      TabOrder = 14
    end
    object wwCheckBox16: TwwCheckBox
      Left = 23
      Top = 385
      Width = 16
      Height = 17
      HelpContext = 458092
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
      Caption = 'wwCheckBox1'
      DataField = 'UseForeignCurrencyonPO'
      DataSource = dsPrefs
      TabOrder = 15
    end
    object wwCheckBox17: TwwCheckBox
      Left = 23
      Top = 412
      Width = 16
      Height = 17
      HelpContext = 458093
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
      Caption = 'wwCheckBox1'
      DataField = 'CanRemoveSupplierInvoiceNoInPO'
      DataSource = dsPrefs
      TabOrder = 16
    end
    object cboStatus: TwwDBComboBox
      Left = 304
      Top = 197
      Width = 177
      Height = 23
      HelpContext = 458076
      ShowButton = True
      Style = csDropDownList
      MapList = False
      AllowClearKey = False
      AutoDropDown = True
      AutoFillDate = False
      DataField = 'RALineDefaultStatus'
      DataSource = dsPrefs
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        'Awaiting RA No.'
        'In Transit'
        'Returned'
        'Send To Supplier'
        'Testing'
        'With Supplier')
      ParentFont = False
      Sorted = False
      TabOrder = 17
      UnboundDataType = wwDefault
    end
    object wwRadioGroup1: TwwRadioGroup
      Left = 23
      Top = 681
      Width = 506
      Height = 54
      HelpContext = 458077
      DisableThemes = False
      Caption = 'Calculate ETA From '
      Columns = 2
      DataField = 'PurchaseETACalculatedFrom'
      DataSource = dsPrefs
      Items.Strings = (
        'Supplier'#39's Normal Shipping Time'
        'Product'#39's Normal Delivery Time')
      TabOrder = 18
      Values.Strings = (
        'S'
        'P')
    end
    object wwCheckBox19: TwwCheckBox
      Left = 23
      Top = 439
      Width = 16
      Height = 17
      HelpContext = 458078
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
      Caption = 'wwCheckBox1'
      DataField = 'WarnWhenPurchaseCreationDateisfuture'
      DataSource = dsPrefs
      TabOrder = 19
    end
    object wwCheckBox20: TwwCheckBox
      Left = 23
      Top = 465
      Width = 16
      Height = 17
      HelpContext = 458079
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
      Caption = 'wwCheckBox1'
      DataField = 'UseEmployeeDeptAddressinPOShipto'
      DataSource = dsPrefs
      TabOrder = 20
    end
    object wwCheckBox22: TwwCheckBox
      Left = 23
      Top = 359
      Width = 16
      Height = 17
      HelpContext = 458109
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
      Caption = 'wwCheckBox1'
      DataField = 'EnforceConNoteOnRA'
      DataSource = dsPrefs
      TabOrder = 21
    end
    object wwCheckBox23: TwwCheckBox
      Left = 23
      Top = 546
      Width = 16
      Height = 17
      HelpContext = 458126
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
      Caption = 'wwCheckBox1'
      DataField = 'PrintLabelsOnReceipt'
      DataSource = dsPrefs
      TabOrder = 22
    end
    object wwCheckBox24: TwwCheckBox
      Left = 23
      Top = 492
      Width = 16
      Height = 17
      HelpContext = 458127
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
      Caption = 'wwCheckBox1'
      DataField = 'EmailCustomerOnReceipt'
      DataSource = dsPrefs
      TabOrder = 23
    end
    object wwCheckBox25: TwwCheckBox
      Left = 23
      Top = 519
      Width = 16
      Height = 17
      HelpContext = 458128
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
      Caption = 'wwCheckBox1'
      DataField = 'EmailEmployeeOnReceipt'
      DataSource = dsPrefs
      TabOrder = 24
    end
    object chkUseFuturePurchaseOrders: TwwCheckBox
      Left = 39
      Top = 646
      Width = 16
      Height = 17
      HelpContext = 458129
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
      Caption = 'wwCheckBox1'
      DataField = 'UseFuturePO'
      DataSource = dsPrefs
      TabOrder = 25
      OnClick = chkUseFuturePurchaseOrdersClick
    end
    object edtFuturePurchaseOrdersDays: TwwDBEdit
      Left = 361
      Top = 643
      Width = 33
      Height = 23
      HelpContext = 458130
      DataField = 'FuturePODays'
      DataSource = dsPrefs
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 26
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object cboSalesBackorderCheckType: TwwDBComboBox
      Left = 208
      Top = 594
      Width = 121
      Height = 23
      HelpContext = 458133
      ShowButton = True
      Style = csDropDownList
      MapList = False
      AllowClearKey = False
      DataField = 'SalesBackorderCheckType'
      DataSource = dsPrefs
      DropDownCount = 8
      ItemHeight = 0
      Items.Strings = (
        'Invoice'
        'Sales Order')
      ItemIndex = 0
      Sorted = False
      TabOrder = 27
      UnboundDataType = wwDefault
    end
    object wwCheckBox38: TwwCheckBox
      Left = 20
      Top = 750
      Width = 16
      Height = 17
      HelpContext = 484377
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
      DataField = 'SalesDefaultAreaFromCustomer'
      DataSource = dsPrefs
      TabOrder = 28
    end
    object cboPOStoreAwayTemplate: TwwDBLookupCombo
      Left = 304
      Top = 245
      Width = 201
      Height = 23
      HelpContext = 458030
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Templname'#9'50'#9'Templname'#9'F')
      DataField = 'POStoreAwayTemplate'
      DataSource = dsPrefs
      LookupTable = QryPOStoreawaytempl
      LookupField = 'Templname'
      ParentFont = False
      TabOrder = 29
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnEnter = cboPOStoreAwayTemplateEnter
    end
  end
  object DNMPanel2: TDNMPanel [9]
    Left = 16
    Top = 39
    Width = 545
    Height = 234
    HelpContext = 458094
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Bevel2: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 531
      Height = 220
      HelpContext = 458095
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Shape = bsFrame
      ExplicitLeft = 6
      ExplicitTop = 11
      ExplicitHeight = 160
    end
    object Label65: TLabel
      Left = 14
      Top = 14
      Width = 163
      Height = 15
      HelpContext = 458096
      Caption = 'Uninvoiced Purchase Orders'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label66: TLabel
      Left = 48
      Top = 40
      Width = 172
      Height = 15
      HelpContext = 458036
      Caption = 'Include Un-Invoiced PO'#39's to GL'
      Transparent = True
    end
    object Label67: TLabel
      Left = 24
      Top = 72
      Width = 90
      Height = 15
      HelpContext = 458037
      Caption = 'Default Account'
      Transparent = True
    end
    object Label34: TLabel
      Left = 45
      Top = 164
      Width = 124
      Height = 15
      HelpContext = 458110
      Caption = 'Enable Period Posting'
      Transparent = True
    end
    object Label35: TLabel
      Left = 14
      Top = 133
      Width = 148
      Height = 15
      HelpContext = 458111
      Caption = 'Invoiced Purchase Orders'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object lblPOHasPeriodPosting: TLabel
      Left = 46
      Top = 181
      Width = 360
      Height = 30
      HelpContext = 458134
      Caption = 
        '(Eg : When Selected, Purchase Order Received in One Month and It' +
        #39's '#39'Invoice'#39' Received in Next Month , will be 2 Different Postin' +
        'g )'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object chkIncludeUnInvoicedPOtoGL: TwwCheckBox
      Left = 24
      Top = 40
      Width = 16
      Height = 17
      HelpContext = 458038
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'IncludeUnInvoicedPOtoGL'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 0
    end
    object wwDBLookupCombo2: TwwDBLookupCombo
      Left = 24
      Top = 88
      Width = 169
      Height = 23
      HelpContext = 458039
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'30'#9'Account Name'#9'T'
        'Type'#9'20'#9'Type'#9'T')
      DataField = 'UnInvoicedPOAccount'
      DataSource = dsPrefs
      LookupTable = qryAccUnInvPO
      LookupField = 'AccountID'
      ParentFont = False
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object chkPOHasPeriodPosting: TwwCheckBox
      Left = 24
      Top = 164
      Width = 16
      Height = 17
      HelpContext = 458112
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'POHasPeriodPosting'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 2
    end
  end
  object DNMPanel3: TDNMPanel [10]
    Left = 8
    Top = 2
    Width = 545
    Height = 195
    HelpContext = 458033
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object Bevel3: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 531
      Height = 181
      HelpContext = 458034
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Shape = bsFrame
      ExplicitLeft = 15
      ExplicitTop = 16
    end
    object Label26: TLabel
      Left = 14
      Top = 14
      Width = 105
      Height = 15
      HelpContext = 458035
      Caption = #39'ETA Date'#39' Choices'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object lblETA1: TLabel
      Left = 63
      Top = 42
      Width = 273
      Height = 15
      Hint = 
        #39'ETA Date'#39'  of all Lines of the Purchase Order gets updated when' +
        ' the '#39'ETA Date '#39' changes in header'
      HelpContext = 458080
      Caption = 'Line'#39's '#39'ETA Date'#39' Match With Header'#39's '#39'ETA Date'#39
      ParentShowHint = False
      ShowHint = True
      Transparent = True
    end
    object lbleta3: TLabel
      Left = 63
      Top = 104
      Width = 339
      Height = 15
      Hint = 
        'Lines '#39'ETA Date'#39' gets updated when the '#39'ETA Date '#39' changes in th' +
        'e Shipping Container'
      HelpContext = 458081
      Caption = 'Line'#39's '#39'ETA Date'#39' Match With Shipping Container'#39's '#39'ETA Date'#39
      ParentShowHint = False
      ShowHint = True
      Transparent = True
    end
    object lbleta2: TLabel
      Left = 63
      Top = 73
      Width = 273
      Height = 15
      Hint = 
        'Header '#39'ETA Date'#39' gets updated when the '#39'ETA Date '#39' changes in t' +
        'he Lines .  Header'#39's ETA Date the Smallest ETA Date from its lin' +
        'es'
      HelpContext = 458082
      Caption = 'Header'#39's '#39'ETA Date'#39' Match With Line'#39's '#39'ETA Date'#39
      ParentShowHint = False
      ShowHint = True
      Transparent = True
    end
    object lbleta4: TLabel
      Left = 63
      Top = 135
      Width = 299
      Height = 15
      HelpContext = 484375
      Caption = 'Match Header'#39's '#39'Invoice Date'#39' To Header'#39's  '#39'ETA Date'#39
      Transparent = True
    end
    object lbleta4_1: TLabel
      Left = 66
      Top = 157
      Width = 468
      Height = 15
      HelpContext = 458131
      Caption = 
        '('#39'Invoice Date'#39' will Match the '#39'ETA Date'#39' by default when the '#39'I' +
        'nvoice No'#39' is provided)'
      Transparent = True
    end
    object wwCheckBox12: TwwCheckBox
      Left = 39
      Top = 41
      Width = 16
      Height = 17
      HelpContext = 458083
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
      Caption = 'wwCheckBox1'
      DataField = 'POMatchLineETAToHeaderETA'
      DataSource = dsPrefs
      TabOrder = 0
    end
    object wwCheckBox13: TwwCheckBox
      Left = 39
      Top = 103
      Width = 16
      Height = 17
      HelpContext = 458084
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
      Caption = 'wwCheckBox1'
      DataField = 'POMatchLineETAToShippingContainerETA'
      DataSource = dsPrefs
      TabOrder = 1
    end
    object wwCheckBox18: TwwCheckBox
      Left = 39
      Top = 72
      Width = 16
      Height = 17
      HelpContext = 458085
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
      Caption = 'wwCheckBox1'
      DataField = 'POMatchHeaderETAToLineETA'
      DataSource = dsPrefs
      TabOrder = 2
    end
    object wwCheckBox26: TwwCheckBox
      Left = 39
      Top = 134
      Width = 16
      Height = 17
      HelpContext = 484377
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
      DataField = 'MatchInvoiceDateToETADate'
      DataSource = dsPrefs
      TabOrder = 3
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 473
    Top = 67
  end
  inherited tmrdelay: TTimer
    Left = 504
    Top = 40
  end
  inherited popSpelling: TPopupMenu
    Left = 440
    Top = 16
  end
  inherited tmrdelayMsg: TTimer
    Left = 376
    Top = 24
  end
  object DNMPanel14: TDNMPanel [10]
    Left = 58
    Top = 531
    Width = 545
    Height = 321
    HelpContext = 458040
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Bevel14: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 531
      Height = 307
      HelpContext = 458097
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Shape = bsFrame
      ExplicitLeft = 8
      ExplicitTop = 8
      ExplicitWidth = 529
      ExplicitHeight = 231
    end
    object Label71: TLabel
      Left = 48
      Top = 41
      Width = 64
      Height = 15
      HelpContext = 458042
      Caption = 'Show Units'
      Transparent = True
    end
    object Label72: TLabel
      Left = 48
      Top = 70
      Width = 115
      Height = 15
      HelpContext = 458043
      Caption = 'Show Customer Job'
      Transparent = True
    end
    object Label73: TLabel
      Left = 48
      Top = 100
      Width = 67
      Height = 15
      HelpContext = 458044
      Caption = 'Show Class'
      Transparent = True
    end
    object Label75: TLabel
      Left = 48
      Top = 189
      Width = 127
      Height = 15
      HelpContext = 458045
      Caption = 'Show Part Description'
      Transparent = True
    end
    object Label76: TLabel
      Left = 14
      Top = 14
      Width = 136
      Height = 15
      HelpContext = 458046
      Caption = 'Purchase Lines Options'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label77: TLabel
      Left = 48
      Top = 129
      Width = 87
      Height = 15
      HelpContext = 458047
      Caption = 'Show Tax Code'
      Transparent = True
    end
    object Label78: TLabel
      Left = 46
      Top = 159
      Width = 102
      Height = 15
      HelpContext = 458048
      Caption = 'Show Tax Amount'
      Transparent = True
    end
    object Label81: TLabel
      Left = 268
      Top = 41
      Width = 137
      Height = 15
      HelpContext = 458051
      Caption = 'Show Account Numbers'
      Transparent = True
    end
    object lblDisableAltSaveCost: TLabel
      Left = 268
      Top = 70
      Width = 188
      Height = 15
      Hint = 
        'Changing Purchase Cost will Update Product'#39's Cost when Product'#39's' +
        ' '#39'Auto Price Update'#39' is Selected'
      HelpContext = 458052
      Caption = 'Disable "Alter Save Cost" prompt'
      Transparent = True
    end
    object Label83: TLabel
      Left = 268
      Top = 100
      Width = 169
      Height = 15
      HelpContext = 458053
      Caption = 'Show Docket Number Column'
      Transparent = True
    end
    object Label85: TLabel
      Left = 268
      Top = 129
      Width = 154
      Height = 15
      HelpContext = 458055
      Caption = 'Use Product Specifications'
      Transparent = True
    end
    object Label16: TLabel
      Left = 48
      Top = 289
      Width = 221
      Height = 15
      HelpContext = 458098
      Caption = 'Filter Taxcode for the selected Supplier'
      Transparent = True
    end
    object Label24: TLabel
      Left = 268
      Top = 159
      Width = 163
      Height = 15
      HelpContext = 458106
      Caption = 'Auto Append Batch Numbers'
      Transparent = True
    end
    object Label38: TLabel
      Left = 268
      Top = 186
      Width = 257
      Height = 15
      Caption = 'Disable Purchase Line Zero Quantity Warning'
      Transparent = True
    end
    object wwCheckBox42: TwwCheckBox
      Left = 24
      Top = 40
      Width = 16
      Height = 17
      HelpContext = 458056
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
      Caption = 'wwCheckBox1'
      DataField = 'ShowPurchUnits'
      DataSource = dsPrefs
      TabOrder = 0
    end
    object wwCheckBox43: TwwCheckBox
      Left = 24
      Top = 69
      Width = 16
      Height = 17
      HelpContext = 458057
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
      Caption = 'wwCheckBox1'
      DataField = 'ShowPurchCustJob'
      DataSource = dsPrefs
      TabOrder = 1
    end
    object wwCheckBox44: TwwCheckBox
      Left = 24
      Top = 99
      Width = 16
      Height = 17
      HelpContext = 458058
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'ShowPurchClass'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 2
    end
    object wwCheckBox46: TwwCheckBox
      Left = 24
      Top = 189
      Width = 16
      Height = 17
      HelpContext = 458059
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'ShowPurchDescription'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 5
    end
    object wwCheckBox47: TwwCheckBox
      Left = 24
      Top = 129
      Width = 16
      Height = 17
      HelpContext = 458060
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'ShowPurchTaxCode'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 3
    end
    object wwCheckBox48: TwwCheckBox
      Left = 24
      Top = 159
      Width = 16
      Height = 17
      HelpContext = 458061
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'ShowPurchTaxAmount'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 4
    end
    object wwCheckBox51: TwwCheckBox
      Left = 244
      Top = 40
      Width = 16
      Height = 17
      HelpContext = 458064
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
      Caption = 'wwCheckBox1'
      DataField = 'ShowAccountNumbers'
      DataSource = dsPrefs
      TabOrder = 6
    end
    object chkDisableAltSaveCost: TwwCheckBox
      Left = 244
      Top = 69
      Width = 16
      Height = 17
      Hint = 
        'Changing Purchase Cost will Update Product'#39's Cost when Product'#39's' +
        ' '#39'Auto Price Update'#39' is Selected'
      HelpContext = 458065
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
      Caption = 'wwCheckBox1'
      DataField = 'DisableAltSaveCost'
      DataSource = dsPrefs
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = chkDisableAltSaveCostClick
    end
    object wwCheckBox53: TwwCheckBox
      Left = 244
      Top = 99
      Width = 16
      Height = 17
      HelpContext = 458066
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
      Caption = 'wwCheckBox1'
      DataField = 'ShowDocketNumberColumnOnPO'
      DataSource = dsPrefs
      TabOrder = 8
    end
    object wwCheckBox55: TwwCheckBox
      Left = 244
      Top = 129
      Width = 16
      Height = 17
      HelpContext = 458068
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
      Caption = 'wwCheckBox1'
      DataField = 'UseProductSpecsCalcsPO'
      DataSource = dsPrefs
      TabOrder = 9
    end
    object wwRadioGroup2: TwwRadioGroup
      Left = 24
      Top = 216
      Width = 500
      Height = 64
      HelpContext = 458086
      DisableThemes = False
      TransparentActiveItem = True
      Indents.TextX = 5
      Transparent = True
      NoSpacing = True
      Caption = #39'Area'#39' gets value by default from'
      Columns = 3
      DataField = 'PODefaultValueForAreaFrom'
      DataSource = dsPrefs
      Items.Strings = (
        'Supplier'#39's Area'
        'Product'#39's Area'
        'None')
      TabOrder = 10
      Values.Strings = (
        'S'
        'P'
        'N')
    end
    object wwCheckBox21: TwwCheckBox
      Left = 24
      Top = 289
      Width = 16
      Height = 17
      HelpContext = 458099
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
      Caption = 'Filter Taxcode for the selected Supplier'
      Checked = True
      DataField = 'filterTaxcodeforClient'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 11
    end
    object chkAutoAppendBatchNumber: TwwCheckBox
      Left = 244
      Top = 159
      Width = 16
      Height = 17
      HelpContext = 458107
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
      Caption = 'wwCheckBox1'
      DataField = 'AutoAppendBatchNumber'
      DataSource = dsPrefs
      TabOrder = 12
    end
    object chkDisablePurchaseLineZeroQuantityWarning: TwwCheckBox
      Left = 244
      Top = 186
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      DataField = 'DisablePurchaseLineZeroQuantityWarning'
      DataSource = dsPrefs
      TabOrder = 13
    end
  end
  object MyConnection: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Connected = True
    LoginPrompt = False
    Left = 592
    Top = 56
  end
  object dsPrefs: TDataSourcePrefs
    OnDataChange = dsPrefsDataChange
    Connection = MyConnection
    FieldDefs = <>
    FieldNames.Strings = (
      'AutoAppendBatchNumber'
      'BrokerHandlingAccount'
      'CanRemoveSupplierInvoiceNoInPO'
      'ConvertConvertedSmartOrder'
      'DefaultPayMethodID'
      'DefaultPurchasesAccount'
      'DisableAltSaveCost'
      'DisablePurchaseLineZeroQuantityWarning'
      'DutiesAccount'
      'EmailCustomerOnReceipt'
      'EmailEmployeeOnReceipt'
      'EnforceConNoteOnPO'
      'EnforceConNoteOnRA'
      'ExcludeBOFromPrintinPO'
      'filterTaxcodeforClient'
      'FuturePODays'
      'IncludeLandedCostsinAvgCost'
      'IncludeUnInvoicedPOtoGL'
      'MatchInvoiceDateToETADate'
      'MaxSmartAmount'
      'NoPreferredSuppQuestion'
      'PODefaultValueForAreaFrom'
      'POenforceETA'
      'POHasPeriodPosting'
      'POMatchHeaderETAToLineETA'
      'POMatchLineETAToHeaderETA'
      'POMatchLineETAToShippingContainerETA'
      'POStoreAwayTemplate'
      'PrintBarcodesOnOrder'
      'PrintBarcodesOnReceival'
      'PrintLabelsOnReceipt'
      'PrintStoreAwayOnReceival'
      'PurchaseDefaultAreaFromSupplier'
      'PurchaseETACalculatedFrom'
      'RALineDefaultStatus'
      'RememberLastTransactionBySupplier'
      'SalesBackorderCheckType'
      'SalesDefaultAreaFromCustomer'
      'ShowAccountNumbers'
      'ShowDocketNumberColumnOnPO'
      'ShowPurchClass'
      'ShowPurchCustJob'
      'ShowPurchDescription'
      'ShowPurchTaxAmount'
      'ShowPurchTaxCode'
      'ShowPurchUnits'
      'StoreForeignCurrencyValue'
      'SumReceivedOnlyForeignCurrencyonPO'
      'TotalvolumeUOMInsmartOrder'
      'UnInvoicedPOAccount'
      'UOMforTotalvolumeInsmartOrder'
      'UpdateSaleShippedFromPOReceived'
      'UseEmployeeDeptAddressinPOShipto'
      'UseForeignCurrencyonPO'
      'UseFuturePO'
      'UseProductSpecsCalcsPO'
      'WarnWhenPurchaseCreationDateisfuture')
    Left = 624
    Top = 56
  end
  object qryAccount: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblChartofAccounts.*, AccDesc as Type'
      'FROM tblChartofAccounts'
      'LEFT JOIN tblacctypedesc on  AccType = AccountType'
      'WHERE IsHeader = '#39'F'#39' AND Active = '#39'T'#39
      'AND AccountType = "AP"'
      'ORDER BY AccDesc, AccountName;')
    Left = 656
    Top = 56
  end
  object qryPayMethod: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT PayMethodID, Name, IsCreditCard FROM tblpaymentmethods wh' +
        'ere Active ="T"'
      'union'
      'select 0 as PayMethodId, "" as Name, "F" as IsCreditCard'
      'Order By Name')
    Left = 688
    Top = 56
  end
  object qryAccUnInvPO: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblChartofAccounts.*, AccDesc AS Type'
      'FROM tblChartofAccounts'
      'LEFT JOIN tblacctypedesc on AccType = AccountType'
      'WHERE IsHeader = '#39'F'#39' AND Active = '#39'T'#39
      'AND AccountType='#39'OCLIAB'#39
      'ORDER BY AccDesc, AccountName;')
    Left = 720
    Top = 56
  end
  object qryAccExp: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'tblChartofAccounts.AccountID,'
      'tblChartofAccounts.AccountName,'
      'tblChartofAccounts.AccountGroup,'
      'tblChartofAccounts.AccountNumber,'
      'tblacctypedesc.AccDesc AS Type,'
      'tblChartofAccounts.Description,'
      'tblChartofAccounts.Taxcode,'
      'tblChartofAccounts.Active,'
      
        'Concat(If( char_length(Level4)>0,Space(15), If( char_length(Leve' +
        'l3)>0,Space(10),If( char_length(Level2)>0,Space(5),Space(0)))),A' +
        'ccountName) as AccountTree,'
      
        'SUBSTRING(If((char_length(tblChartofAccounts.AccountGroup)>0),Co' +
        'ncat(REPLACE(tblChartofAccounts.AccountGroup,"^"," - ")," - ",tb' +
        'lChartofAccounts.AccountName),tblChartofAccounts.AccountName),1,' +
        '255) as FullAccountName'
      'FROM tblChartofAccounts'
      
        'LEFT JOIN tblacctypedesc ON tblacctypedesc.AccType = tblChartofA' +
        'ccounts.AccountType'
      
        'WHERE IsHeader = '#39'F'#39' AND Active = '#39'T'#39' AND (AccountType='#39'EXEXP'#39' o' +
        'r AccountType='#39'EXP'#39')'
      'ORDER BY Type, AccountNumber;')
    Left = 752
    Top = 56
  end
  object QryPOStoreawaytempl: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select Templname  from tbltemplates where typeid in (Select type' +
        'id from tbltemplatetype where typename = '#39'Purchase Order'#39') Order' +
        ' by Templname')
    Left = 784
    Top = 56
    object QryPOStoreawaytemplTemplname: TWideStringField
      DisplayWidth = 50
      FieldName = 'Templname'
      Size = 100
    end
  end
end
