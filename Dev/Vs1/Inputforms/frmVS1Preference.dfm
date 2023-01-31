object fmVS1Preference: TfmVS1Preference
  Left = 343
  Top = 142
  Caption = 'fmVS1Preference'
  ClientHeight = 141
  ClientWidth = 585
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = [fsBold]
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object pnlVS1config: TDNMPanel
    Left = 2
    Top = 0
    Width = 580
    Height = 139
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object lblTitle: TLabel
      Left = 14
      Top = 14
      Width = 58
      Height = 15
      HelpContext = 1686005
      Caption = 'VS1 Cloud'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Bevel1: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 566
      Height = 125
      HelpContext = 1686004
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Shape = bsFrame
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 573
      ExplicitHeight = 129
    end
    object lblBaseForeignCurrencyCode: TLabel
      Left = 42
      Top = 94
      Width = 115
      Height = 15
      HelpContext = 372059
      Caption = 'Use Single Currency'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object chkUseRegioncurrency: TwwCheckBox
      Left = 42
      Top = 57
      Width = 183
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Use Region'#39's currency'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = chkUseRegioncurrencyClick
    end
    object cboBaseForeignCurrencyCode: TwwDBLookupCombo
      Left = 210
      Top = 91
      Width = 103
      Height = 23
      HelpContext = 372077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Code'#9'10'#9'Code'#9'F'
        'Currency'#9'20'#9'Currency'#9'F')
      DataField = 'ForeignExchangeCode'
      LookupTable = qryForeignCurrency
      LookupField = 'Code'
      ParentFont = False
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnChange = cboBaseForeignCurrencyCodeChange
    end
  end
  object qryForeignCurrency: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT CurrencyID, Country, Currency, Code, BuyRate , Active  '
      'FROM tblcurrencyconversion'
      'Where BuyRate <>0 and active ="T";')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Active = True
    Left = 306
    Top = 62
  end
  object MyConnection: TERPConnection
    Database = 'aus_sample_company'
    Port = 3309
    Options.UseUnicode = True
    Options.KeepDesignConnected = False
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Server = 'localhost'
    Connected = True
    LoginPrompt = False
    Left = 174
    Top = 5
  end
end
