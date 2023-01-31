inherited SpeedPrefsGUI: TSpeedPrefsGUI
  Left = 207
  Top = 54
  HelpContext = 504000
  VertScrollBar.Tracking = True
  Caption = 'Speed Preferences'
  ClientHeight = 708
  ClientWidth = 912
  OldCreateOrder = True
  ExplicitLeft = 207
  ExplicitTop = 54
  ExplicitWidth = 928
  ExplicitHeight = 747
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 708
    Width = 912
    HelpContext = 504050
    ExplicitTop = 706
    ExplicitWidth = 912
  end
  object lblWidth: TLabel [1]
    Left = 15
    Top = 8
    Width = 863
    Height = 22
    HelpContext = 504001
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
  inherited sbpanels: TAdvScrollBox
    Width = 912
    Height = 708
    HelpContext = 504058
    ExplicitWidth = 912
    ExplicitHeight = 708
    object DNMPanel3: TDNMPanel
      Left = 0
      Top = 0
      Width = 893
      Height = 197
      HelpContext = 504036
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Bevel3: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 879
        Height = 183
        HelpContext = 504037
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 97
      end
      object Label7: TLabel
        Left = 14
        Top = 14
        Width = 25
        Height = 15
        HelpContext = 504038
        Caption = 'POS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object chkPOSSummarise: TwwCheckBox
        Left = 24
        Top = 44
        Width = 222
        Height = 17
        HelpContext = 504042
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
        Caption = 'Summarise Sales'
        DataField = 'POSSummarise'
        DataSource = dsPrefs
        TabOrder = 0
        OnClick = chkPOSSummariseClick
      end
      object wwCheckBox2: TwwCheckBox
        Left = 24
        Top = 80
        Width = 222
        Height = 17
        HelpContext = 504043
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
        Caption = 'Use Express Product List'
        DataField = 'UseExpressProductList'
        DataSource = dsPrefs
        TabOrder = 1
      end
      object wwCheckBox3: TwwCheckBox
        Left = 24
        Top = 116
        Width = 222
        Height = 17
        HelpContext = 504044
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
        Caption = 'Summarise Bar Tab Invoice'
        DataField = 'POSSummariseBarTabInv'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object wwCheckBox4: TwwCheckBox
        Left = 24
        Top = 153
        Width = 222
        Height = 17
        HelpContext = 504057
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
        Caption = 'Disable Audit Trial In QuickPOS'
        DataField = 'DisableAuditTrialinQuickPOS'
        DataSource = dsPrefs
        TabOrder = 3
      end
    end
    object DNMPanel1: TDNMPanel
      Left = 0
      Top = 362
      Width = 893
      Height = 185
      HelpContext = 504051
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Bevel1: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 879
        Height = 171
        HelpContext = 504052
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 73
      end
      object Label1: TLabel
        Left = 14
        Top = 14
        Width = 84
        Height = 15
        HelpContext = 504053
        Caption = 'Combo Search'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwRadioGroup1: TwwRadioGroup
        Left = 14
        Top = 47
        Width = 468
        Height = 58
        HelpContext = 504054
        DisableThemes = False
        Caption = 'Product Combo Search List Form'
        Columns = 2
        DataField = 'ProductcomboLookupListform'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Items.Strings = (
          'Express List'
          'Detail List')
        ParentFont = False
        TabOrder = 0
        Values.Strings = (
          'E'
          'D')
      end
      object wwRadioGroup2: TwwRadioGroup
        Left = 14
        Top = 111
        Width = 468
        Height = 58
        HelpContext = 504055
        DisableThemes = False
        Caption = 'Customer Combo Search List Form'
        Columns = 2
        DataField = 'CustomercomboLookupExpressList'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Items.Strings = (
          'Express List'
          'Detail List')
        ParentFont = False
        TabOrder = 1
        Values.Strings = (
          'E'
          'D')
      end
    end
    object DNMPanel4: TDNMPanel
      Left = 0
      Top = 547
      Width = 893
      Height = 240
      HelpContext = 504045
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Bevel4: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 879
        Height = 226
        HelpContext = 504046
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 9
        ExplicitHeight = 186
      end
      object Label8: TLabel
        Left = 14
        Top = 14
        Width = 269
        Height = 15
        HelpContext = 504047
        Caption = 'Disable Calculations After This Number of Lines'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object lblIgnore: TLabel
        Left = 206
        Top = 54
        Width = 225
        Height = 15
        HelpContext = 504048
        AutoSize = False
        Caption = 'Set to Zero to always Enable Calculations'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Visible = False
        WordWrap = True
      end
      object Label2: TLabel
        Left = 87
        Top = 54
        Width = 32
        Height = 15
        HelpContext = 504059
        Alignment = taRightJustify
        Caption = 'Sales'
      end
      object Label5: TLabel
        Left = 64
        Top = 90
        Width = 55
        Height = 15
        HelpContext = 504060
        Alignment = taRightJustify
        Caption = 'Purchase'
      end
      object Label6: TLabel
        Left = 206
        Top = 90
        Width = 225
        Height = 15
        HelpContext = 504061
        AutoSize = False
        Caption = 'Set to Zero to always Enable Calculations'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Visible = False
        WordWrap = True
      end
      object lblhintExpenseLinesToDisableCalcs: TLabel
        Left = 206
        Top = 127
        Width = 225
        Height = 15
        HelpContext = 504048
        AutoSize = False
        Caption = 'Set to Zero to always Enable Calculations'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Visible = False
        WordWrap = True
      end
      object lblExpenseLinesToDisableCalcs: TLabel
        Left = 70
        Top = 127
        Width = 49
        Height = 15
        HelpContext = 504059
        Alignment = taRightJustify
        Caption = 'Expense'
      end
      object lblhintCustPayLinesToDisableCalcs: TLabel
        Left = 206
        Top = 163
        Width = 225
        Height = 15
        HelpContext = 504048
        AutoSize = False
        Caption = 'Set to Zero to always Enable Calculations'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Visible = False
        WordWrap = True
      end
      object lblCustPayLinesToDisableCalcs: TLabel
        Left = 40
        Top = 163
        Width = 79
        Height = 15
        HelpContext = 504059
        Alignment = taRightJustify
        Caption = 'Cust Payment'
      end
      object lblhintSuppPayLinesToDisableCalcs: TLabel
        Left = 206
        Top = 200
        Width = 225
        Height = 15
        HelpContext = 504048
        AutoSize = False
        Caption = 'Set to Zero to always Enable Calculations'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Visible = False
        WordWrap = True
      end
      object lblSuppPayLinesToDisableCalcs: TLabel
        Left = 19
        Top = 200
        Width = 100
        Height = 15
        HelpContext = 504059
        Alignment = taRightJustify
        Caption = 'Supplier Payment'
      end
      object edtSaleLinesToDisableCalcs: TwwDBEdit
        Left = 126
        Top = 50
        Width = 73
        Height = 23
        HelpContext = 504062
        DataField = 'SaleLinesToDisableCalcs'
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
      object edtOrderLinesToDisableCalcs: TwwDBEdit
        Left = 126
        Top = 86
        Width = 73
        Height = 23
        HelpContext = 504063
        DataField = 'OrderLinesToDisableCalcs'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
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
      object edtExpenseLinesToDisableCalcs: TwwDBEdit
        Left = 126
        Top = 123
        Width = 73
        Height = 23
        HelpContext = 504062
        DataField = 'ExpenseLinesToDisableCalcs'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
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
      object edtCustPayLinesToDisableCalcs: TwwDBEdit
        Left = 126
        Top = 159
        Width = 73
        Height = 23
        HelpContext = 504062
        DataField = 'CustPayLinesToDisableCalcs'
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
      object edtSuppPayLinesToDisableCalcs: TwwDBEdit
        Left = 126
        Top = 196
        Width = 73
        Height = 23
        HelpContext = 504062
        DataField = 'SuppPayLinesToDisableCalcs'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
    end
    object DNMPanel5: TDNMPanel
      Left = 0
      Top = 279
      Width = 893
      Height = 83
      HelpContext = 504025
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Bevel5: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 879
        Height = 69
        HelpContext = 504026
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 64
      end
      object Label9: TLabel
        Left = 14
        Top = 14
        Width = 42
        Height = 15
        HelpContext = 504027
        Caption = 'Utilities'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox5: TwwCheckBox
        Left = 24
        Top = 40
        Width = 222
        Height = 17
        HelpContext = 504035
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
        Caption = 'Disable List Updates on Save'
        DataField = 'DisableNotifyLists'
        DataSource = dsPrefs
        TabOrder = 0
      end
    end
    object DNMPanel2: TDNMPanel
      Left = 0
      Top = 197
      Width = 893
      Height = 82
      HelpContext = 504008
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      Visible = False
      object Bevel2: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 879
        Height = 68
        HelpContext = 504009
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 65
      end
      object Label3: TLabel
        Left = 14
        Top = 14
        Width = 54
        Height = 15
        HelpContext = 504010
        Caption = 'Accounts'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox1: TwwCheckBox
        Left = 24
        Top = 40
        Width = 329
        Height = 17
        HelpContext = 504012
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
        Caption = 'Use Batch Transaction For Reports'
        DataField = 'UseBatchTransactions'
        DataSource = dsPrefs
        TabOrder = 0
      end
    end
  end
  object MyConnection: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    LoginPrompt = False
    Left = 592
    Top = 52
  end
  object dsPrefs: TDataSourcePrefs
    Connection = MyConnection
    FieldDefs = <>
    FieldNames.Strings = (
      'CustomercomboLookupExpressList'
      'CustPayLinesToDisableCalcs'
      'DisableAuditTrialinQuickPOS'
      'DisableNotifyLists'
      'ExpenseLinesToDisableCalcs'
      'OrderLinesToDisableCalcs'
      'POSSummarise'
      'POSSummariseBarTabInv'
      'ProductcomboLookupListform'
      'SaleLinesToDisableCalcs'
      'SuppPayLinesToDisableCalcs'
      'UseBatchTransactions'
      'UseExpressProductList')
    Left = 624
    Top = 52
  end
  object dsPersonalPreferences: TDataSource
    DataSet = qryPersonalPreferences
    Left = 661
    Top = 53
  end
  object qryPersonalPreferences: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblpersonalpreferences'
      'WHERE EmployeeID = :EmployeeID;')
    Left = 698
    Top = 56
    ParamData = <
      item
        DataType = ftString
        Name = 'EmployeeID'
        Value = ''
      end>
  end
end
