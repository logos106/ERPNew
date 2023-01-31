inherited FixedAssetsPrefsGUI: TFixedAssetsPrefsGUI
  Left = 100
  Top = 100
  HelpContext = 136000
  Caption = 'Fixed Assets Preferences'
  ClientHeight = 861
  ClientWidth = 1084
  ExplicitLeft = 100
  ExplicitTop = 100
  ExplicitWidth = 1100
  ExplicitHeight = 900
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 861
    Width = 1084
    HelpContext = 136027
    ExplicitTop = 651
    ExplicitWidth = 907
  end
  object lblWidth: TLabel [1]
    Left = 16
    Top = 8
    Width = 863
    Height = 22
    HelpContext = 136001
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
    Width = 1084
    Height = 861
    ExplicitWidth = 907
    ExplicitHeight = 651
    HelpContext = 136030
    object DNMPanel1: TDNMPanel
      Left = 0
      Top = 0
      Width = 1082
      Height = 274
      HelpContext = 136002
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = -16
      ExplicitTop = -28
      ExplicitWidth = 905
      object Bevel1: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1068
        Height = 260
        HelpContext = 136003
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 257
      end
      object Label1: TLabel
        Left = 14
        Top = 14
        Width = 133
        Height = 15
        HelpContext = 136004
        Caption = 'Default Asset Accounts'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label5: TLabel
        Left = 24
        Top = 40
        Width = 123
        Height = 15
        HelpContext = 136005
        Caption = 'Fixed Assets Account'
        Transparent = True
      end
      object Label2: TLabel
        Left = 24
        Top = 96
        Width = 155
        Height = 15
        HelpContext = 136006
        Caption = 'Fixed Assets Bank Account'
        Transparent = True
      end
      object Label3: TLabel
        Left = 24
        Top = 152
        Width = 227
        Height = 15
        HelpContext = 136007
        Caption = 'Fixed Asset Depreciation Asset Account'
        Transparent = True
      end
      object Label4: TLabel
        Left = 24
        Top = 208
        Width = 243
        Height = 15
        HelpContext = 136008
        Caption = 'Fixed Asset Depreciation Expense Account'
        Transparent = True
      end
      object wwDBLookupCombo1: TwwDBLookupCombo
        Left = 24
        Top = 56
        Width = 249
        Height = 23
        HelpContext = 136009
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'40'#9'AccountName'#9'T'
          'AccountType'#9'40'#9'AccountType'#9'T')
        DataField = 'FixedAssetCostAssetAccount'
        DataSource = dsPrefs
        LookupTable = qryAccountFixed
        LookupField = 'AccountName'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 0
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo2: TwwDBLookupCombo
        Left = 24
        Top = 112
        Width = 249
        Height = 23
        HelpContext = 136010
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'40'#9'AccountName'#9'T'
          'AccountType'#9'40'#9'AccountType'#9'T')
        DataField = 'FixedAssetClearingAccount'
        DataSource = dsPrefs
        LookupTable = qryAccountFixed
        LookupField = 'AccountName'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 1
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo3: TwwDBLookupCombo
        Left = 24
        Top = 168
        Width = 249
        Height = 23
        HelpContext = 136011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'40'#9'AccountName'#9'T'
          'AccountType'#9'40'#9'AccountType'#9'T')
        DataField = 'FixedAssetDepreciationAssetAccount'
        DataSource = dsPrefs
        LookupTable = qryAccountFixed
        LookupField = 'AccountName'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 2
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo4: TwwDBLookupCombo
        Left = 24
        Top = 224
        Width = 249
        Height = 23
        HelpContext = 136012
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'40'#9'AccountName'#9'T'
          'AccountType'#9'40'#9'AccountType'#9'T')
        DataField = 'FixedAssetDepreciationExpAccount'
        DataSource = dsPrefs
        LookupTable = qryAccountFixed
        LookupField = 'AccountName'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 3
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwRadioGroup1: TwwRadioGroup
        Left = 312
        Top = 40
        Width = 185
        Height = 97
        HelpContext = 136013
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 3
        Transparent = True
        Caption = 'Depreciation For Transactions'
        DataField = 'DepreciationForTransactions'
        DataSource = dsPrefs
        Items.Strings = (
          'Depreciation # 1'
          'Depreciation # 2')
        TabOrder = 4
        Values.Strings = (
          '1'
          '2')
      end
    end
    object DNMPanel2: TDNMPanel
      Left = 0
      Top = 274
      Width = 1082
      Height = 580
      HelpContext = 136014
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      ExplicitLeft = 8
      ExplicitTop = 69
      ExplicitWidth = 545
      object Bevel2: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1068
        Height = 566
        HelpContext = 136015
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 10
        ExplicitTop = 14
        ExplicitWidth = 529
        ExplicitHeight = 564
      end
      object Label6: TLabel
        Left = 14
        Top = 14
        Width = 119
        Height = 15
        HelpContext = 136016
        Caption = 'Depreciation Options'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Bevel3: TBevel
        Left = 24
        Top = 40
        Width = 499
        Height = 249
        HelpContext = 136017
      end
      object Label7: TLabel
        Left = 32
        Top = 48
        Width = 89
        Height = 15
        HelpContext = 136018
        Caption = 'Depreciation #1'
        Transparent = True
      end
      object Bevel4: TBevel
        Left = 24
        Top = 304
        Width = 499
        Height = 249
        HelpContext = 136019
      end
      object Label8: TLabel
        Left = 32
        Top = 312
        Width = 89
        Height = 15
        HelpContext = 136020
        Caption = 'Depreciation #2'
        Transparent = True
      end
      object wwRadioGroup2: TwwRadioGroup
        Left = 40
        Top = 72
        Width = 273
        Height = 97
        HelpContext = 136021
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 3
        Transparent = True
        Caption = 'Depreciation Calculation Conventions'
        Columns = 2
        DataField = 'DepreciationCalculationConventions'
        DataSource = dsPrefs
        Items.Strings = (
          'Full Year'
          'Half Year'
          'Full Month')
        TabOrder = 0
        Values.Strings = (
          'Full Year'
          'Half Year'
          'Full Month')
      end
      object wwRadioGroup3: TwwRadioGroup
        Left = 40
        Top = 176
        Width = 129
        Height = 97
        HelpContext = 136022
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 3
        Transparent = True
        Caption = 'Period of Purchase'
        DataField = 'MonthofPurchase'
        DataSource = dsPrefs
        Items.Strings = (
          'Include'
          'Exclude')
        TabOrder = 1
        Values.Strings = (
          'Include'
          'Exclude')
      end
      object wwRadioGroup4: TwwRadioGroup
        Left = 184
        Top = 176
        Width = 129
        Height = 97
        HelpContext = 136023
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 3
        Transparent = True
        Caption = 'Period of Disposal'
        DataField = 'MonthofPurchase2'
        DataSource = dsPrefs
        Items.Strings = (
          'Include'
          'Exclude')
        TabOrder = 2
        Values.Strings = (
          'Include'
          'Exclude')
      end
      object wwRadioGroup5: TwwRadioGroup
        Left = 40
        Top = 336
        Width = 273
        Height = 97
        HelpContext = 136024
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 3
        Transparent = True
        Caption = 'Depreciation Calculation Conventions'
        Columns = 2
        DataField = 'DepreciationCalculationConventions2'
        DataSource = dsPrefs
        Items.Strings = (
          'Full Year'
          'Half Year'
          'Full Month')
        TabOrder = 3
        Values.Strings = (
          'Full Year'
          'Half Year'
          'Full Month')
      end
      object wwRadioGroup6: TwwRadioGroup
        Left = 40
        Top = 440
        Width = 129
        Height = 97
        HelpContext = 136025
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 3
        Transparent = True
        Caption = 'Period of Purchase'
        DataField = 'MonthofDisposal'
        DataSource = dsPrefs
        Items.Strings = (
          'Include'
          'Exclude')
        TabOrder = 4
        Values.Strings = (
          'Include'
          'Exclude')
      end
      object wwRadioGroup7: TwwRadioGroup
        Left = 184
        Top = 440
        Width = 129
        Height = 97
        HelpContext = 136026
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 3
        Transparent = True
        Caption = 'Period of Disposal'
        DataField = 'MonthofDisposal2'
        DataSource = dsPrefs
        Items.Strings = (
          'Include'
          'Exclude')
        TabOrder = 5
        Values.Strings = (
          'Include'
          'Exclude')
      end
      object wwRadioGroup8: TwwRadioGroup
        Left = 319
        Top = 72
        Width = 186
        Height = 97
        HelpContext = 136028
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 3
        Transparent = True
        Caption = 'Depreciation Calculation Start'
        DataField = 'DepreciationCalcStart1'
        DataSource = dsPrefs
        Items.Strings = (
          'Financial Year'
          'Calendar Year')
        TabOrder = 6
        Values.Strings = (
          'Financial Year'
          'Calendar Year')
      end
      object wwRadioGroup9: TwwRadioGroup
        Left = 319
        Top = 336
        Width = 186
        Height = 97
        HelpContext = 136029
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 3
        Transparent = True
        Caption = 'Depreciation Calculation Start'
        DataField = 'DepreciationCalcStart2'
        DataSource = dsPrefs
        Items.Strings = (
          'Financial Year'
          'Calendar Year')
        TabOrder = 7
        Values.Strings = (
          'Financial Year'
          'Calendar Year')
      end
    end
  end
  object MyConnection: TERPConnection
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    LoginPrompt = False
    Left = 600
    Top = 50
  end
  object dsPrefs: TDataSourcePrefs
    Connection = MyConnection
    FieldDefs = <>
    FieldNames.Strings = (
      'DepreciationCalcStart1'
      'DepreciationCalcStart2'
      'DepreciationCalculationConventions'
      'DepreciationCalculationConventions2'
      'DepreciationForTransactions'
      'FixedAssetClearingAccount'
      'FixedAssetCostAssetAccount'
      'FixedAssetDepreciationAssetAccount'
      'FixedAssetDepreciationExpAccount'
      'MonthofDisposal'
      'MonthofDisposal2'
      'MonthofPurchase'
      'MonthofPurchase2')
    Left = 640
    Top = 50
  end
  object qryAccountFixed: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT AccountID, AccountName,AccDesc as AccountType, Descriptio' +
        'n, AccountNumber, Taxcode, BankNumber, Extra, '
      
        'Active, tblchartofaccounts.EditedFlag, Class, AllClasses, Openin' +
        'gBalance, Debits, Credits, ClosingBalance, AccountGroup  '
      'FROM tblchartofaccounts'
      'Inner Join tblacctypedesc On AccountType=AccType'
      'WHERE (AccountType <> '#39'AR'#39') And (AccountType <> '#39'AP'#39')'
      'And (AccountType <> '#39'INC'#39') And (AccountType <> '#39'EXINC'#39')'
      'And (AccountType <> '#39'NONPOSTING'#39') And (AccountType <> '#39'COGS'#39')'
      'And IsHeader ="F" AND Active='#39'T'#39
      'Order By AccountType,AccountName;')
    Left = 680
    Top = 48
  end
end
