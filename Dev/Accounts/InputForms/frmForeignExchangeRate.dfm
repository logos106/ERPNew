inherited ForeignExchangeRateGUI: TForeignExchangeRateGUI
  Left = 868
  Top = 111
  HelpContext = 220000
  Caption = 'Foreign Exchange Rate'
  ClientHeight = 356
  ClientWidth = 456
  OldCreateOrder = True
  ExplicitLeft = 868
  ExplicitTop = 111
  ExplicitWidth = 472
  ExplicitHeight = 395
  DesignSize = (
    456
    356)
  PixelsPerInch = 96
  TextHeight = 15
  object Label11: TLabel [0]
    Left = 412
    Top = 319
    Width = 40
    Height = 18
    HelpContext = 220002
    Alignment = taCenter
    Anchors = [akRight, akBottom]
    AutoSize = False
    Caption = 'Active'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 356
    Width = 456
    HelpContext = 220042
    ExplicitTop = 356
    ExplicitWidth = 456
  end
  inherited imgGridWatermark: TImage
    HelpContext = 220001
  end
  object PageControl1: TPageControl [6]
    Left = 13
    Top = 65
    Width = 431
    Height = 247
    HelpContext = 220007
    ActivePage = tabGeneral
    TabHeight = 25
    TabOrder = 4
    TabWidth = 213
    object tabGeneral: TTabSheet
      HelpContext = 220008
      Caption = 'General'
      ImageIndex = 1
      object DNMPanel1: TDNMPanel
        Left = 0
        Top = 0
        Width = 423
        Height = 212
        HelpContext = 220009
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Bevel2: TBevel
          Left = 147
          Top = 132
          Width = 123
          Height = 77
          HelpContext = 220010
        end
        object Bevel3: TBevel
          Left = 277
          Top = 132
          Width = 123
          Height = 77
          HelpContext = 220011
        end
        object Description_Label: TLabel
          Left = 18
          Top = 67
          Width = 103
          Height = 18
          HelpContext = 220012
          AutoSize = False
          Caption = 'Currency'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label2: TLabel
          Left = 18
          Top = 134
          Width = 54
          Height = 18
          HelpContext = 220013
          AutoSize = False
          Caption = 'Code'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label3: TLabel
          Left = 158
          Top = 134
          Width = 80
          Height = 18
          HelpContext = 220014
          AutoSize = False
          Caption = 'Buy Rate'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label4: TLabel
          Left = 18
          Top = 8
          Width = 103
          Height = 18
          HelpContext = 220015
          AutoSize = False
          Caption = 'Country'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label1: TLabel
          Left = 288
          Top = 134
          Width = 80
          Height = 18
          HelpContext = 220016
          AutoSize = False
          Caption = 'Sell Rate'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label13: TLabel
          Left = 80
          Top = 119
          Width = 52
          Height = 30
          HelpContext = 220017
          Caption = 'Currency Symbol'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object lblBuyratedesc: TLabel
          Left = 147
          Top = 175
          Width = 123
          Height = 32
          HelpContext = 220014
          Alignment = taCenter
          AutoSize = False
          Caption = '1 X AUD = 0.0286 ZAR  AUD 100 = 28 ZAR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          Visible = False
        end
        object lblSellratedesc: TLabel
          Left = 277
          Top = 175
          Width = 123
          Height = 32
          HelpContext = 220014
          Alignment = taCenter
          AutoSize = False
          Caption = 'Sell Rate Desc'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          Visible = False
        end
        object edtDescription: TDBEdit
          Left = 18
          Top = 82
          Width = 386
          Height = 23
          HelpContext = 220018
          DataField = 'Currency'
          DataSource = DSCurrencyConversions
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object Code: TDBEdit
          Left = 18
          Top = 149
          Width = 54
          Height = 23
          HelpContext = 220019
          DataField = 'Code'
          DataSource = DSCurrencyConversions
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object txtBuyRate: TDBEdit
          Left = 157
          Top = 149
          Width = 102
          Height = 23
          HelpContext = 220020
          DataField = 'BuyRate'
          DataSource = DSCurrencyConversions
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnExit = txtBuyRateExit
        end
        object cbocountry: TwwDBLookupCombo
          Left = 18
          Top = 23
          Width = 386
          Height = 23
          HelpContext = 220021
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'CurrencyDesc'#9'30'#9'CurrencyDesc'#9'F')
          DataField = 'Country'
          DataSource = DSCurrencyConversions
          LookupTable = qryCountry
          LookupField = 'CurrencyDesc'
          ParentFont = False
          TabOrder = 0
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = cbocountryCloseUp
        end
        object txtSellRate: TDBEdit
          Left = 287
          Top = 149
          Width = 102
          Height = 23
          HelpContext = 220022
          DataField = 'SellRate'
          DataSource = DSCurrencyConversions
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnExit = txtSellRateExit
        end
        object txtCurrencySymbol: TDBEdit
          Left = 80
          Top = 150
          Width = 54
          Height = 23
          HelpContext = 220023
          DataField = 'CurrencySymbol'
          DataSource = DSCurrencyConversions
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnExit = txtCurrencySymbolExit
        end
      end
    end
    object tabHedgingFormula: TTabSheet
      HelpContext = 220024
      Caption = 'Hedging Formula'
      ImageIndex = 1
      object DNMPanel3: TDNMPanel
        Left = 0
        Top = 0
        Width = 423
        Height = 212
        HelpContext = 220025
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Bevel4: TBevel
          Left = 95
          Top = 17
          Width = 230
          Height = 35
          HelpContext = 220026
          Shape = bsFrame
        end
        object Bevel1: TBevel
          Left = 72
          Top = 10
          Width = 281
          Height = 177
          HelpContext = 220027
        end
        object Label5: TLabel
          Left = 121
          Top = 62
          Width = 90
          Height = 15
          HelpContext = 220028
          Caption = 'A = Fixed Rate - '
          Transparent = True
        end
        object Label6: TLabel
          Left = 121
          Top = 86
          Width = 84
          Height = 15
          HelpContext = 220029
          Caption = 'B = Fixed Price'
          Transparent = True
        end
        object Label7: TLabel
          Left = 121
          Top = 111
          Width = 102
          Height = 15
          HelpContext = 220030
          Caption = 'C = % Fixed Rate - '
          Transparent = True
        end
        object Label8: TLabel
          Left = 121
          Top = 135
          Width = 86
          Height = 15
          HelpContext = 220031
          Caption = 'D = Actual Rate'
          Transparent = True
        end
        object Label12: TLabel
          Left = 121
          Top = 160
          Width = 107
          Height = 15
          HelpContext = 220032
          Caption = 'E = % Actual Rate - '
          Transparent = True
        end
        object Label9: TLabel
          Left = 103
          Top = 189
          Width = 212
          Height = 16
          HelpContext = 220033
          Caption = 'Formula = (A x B x C) / D + (B x E)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          ParentFont = False
          Transparent = True
        end
        object Label10: TLabel
          Left = 106
          Top = 26
          Width = 143
          Height = 15
          HelpContext = 220034
          Caption = 'Trigger Price +/- Variation'
          Transparent = True
        end
        object DBEdit1: TDBEdit
          Left = 241
          Top = 60
          Width = 54
          Height = 23
          HelpContext = 220035
          DataField = 'FixedRate'
          DataSource = DSCurrencyConversions
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object DBEdit2: TDBEdit
          Left = 241
          Top = 108
          Width = 54
          Height = 23
          HelpContext = 220036
          DataField = 'UpperVariation'
          DataSource = DSCurrencyConversions
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object DBEdit3: TDBEdit
          Left = 241
          Top = 158
          Width = 54
          Height = 23
          HelpContext = 220037
          DataField = 'LowerVariation'
          DataSource = DSCurrencyConversions
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object DBEdit4: TDBEdit
          Left = 259
          Top = 23
          Width = 54
          Height = 23
          HelpContext = 220038
          DataField = 'TriggerPriceVariation'
          DataSource = DSCurrencyConversions
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
      end
    end
  end
  object pnlTitle: TDNMPanel [7]
    Left = 47
    Top = 6
    Width = 363
    Height = 45
    HelpContext = 220039
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 359
      Height = 41
      HelpContext = 220040
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      FromColor = clBtnFace
      ToColor = clWhite
      FromColorMirror = clWhite
      ToColorMirror = clBtnFace
      Steps = 10
      Direction = False
      Version = '1.4.0.0'
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 359
        Height = 41
        HelpContext = 220041
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Foreign Exchange Rates'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
    end
  end
  object chkActive: TwwCheckBox [8]
    Left = 424
    Top = 334
    Width = 13
    Height = 16
    HelpContext = 220005
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
    Anchors = [akRight, akBottom]
    DataField = 'Active'
    DataSource = DSCurrencyConversions
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object cmdCancel: TDNMSpeedButton [9]
    Left = 301
    Top = 322
    Width = 87
    Height = 27
    HelpContext = 220043
    Action = actCancel
    Anchors = [akBottom]
    Caption = '&Cancel'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
    AutoDisableParentOnclick = True
  end
  object cmdNew: TDNMSpeedButton [10]
    Left = 180
    Top = 322
    Width = 87
    Height = 27
    HelpContext = 220044
    Action = actNew
    Anchors = [akBottom]
    Caption = '&New'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    AutoDisableParentOnclick = True
  end
  object cmdOk: TDNMSpeedButton [11]
    Left = 59
    Top = 322
    Width = 87
    Height = 27
    HelpContext = 220045
    Action = actSave
    Anchors = [akBottom]
    Caption = '&Save'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 0
    AutoDisableParentOnclick = True
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102006C00840010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryCurrencyConversions: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *  FROM tblcurrencyconversion '
      'Where CurrencyID=:ID;')
    AfterOpen = qryCurrencyConversionsAfterOpen
    Left = 413
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Size = 255
      end>
    object qryCurrencyConversionsCurrencyID: TAutoIncField
      FieldName = 'CurrencyID'
      ReadOnly = True
    end
    object qryCurrencyConversionsCountry: TWideStringField
      FieldName = 'Country'
      Size = 255
    end
    object qryCurrencyConversionsCurrency: TWideStringField
      FieldName = 'Currency'
      Size = 255
    end
    object qryCurrencyConversionsCode: TWideStringField
      FieldName = 'Code'
      FixedChar = True
      Size = 3
    end
    object qryCurrencyConversionsBuyRate: TFloatField
      FieldName = 'BuyRate'
      OnChange = qryCurrencyConversionsBuyRateChange
      DisplayFormat = '0.0000##'
      EditFormat = '0.0000##'
    end
    object qryCurrencyConversionsSellRate: TFloatField
      FieldName = 'SellRate'
      OnChange = qryCurrencyConversionsBuyRateChange
      DisplayFormat = '0.0000##'
      EditFormat = '0.0000##'
    end
    object qryCurrencyConversionsActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryCurrencyConversionsRateLastModified: TDateField
      FieldName = 'RateLastModified'
    end
    object qryCurrencyConversionsFixedRate: TFloatField
      FieldName = 'FixedRate'
      DisplayFormat = '0.0000##'
      EditFormat = '0.0000##'
    end
    object qryCurrencyConversionsUpperVariation: TFloatField
      FieldName = 'UpperVariation'
      DisplayFormat = '####0.##%'
      EditFormat = '####0.##'
    end
    object qryCurrencyConversionsLowerVariation: TFloatField
      FieldName = 'LowerVariation'
      DisplayFormat = '####0.##%'
      EditFormat = '####0.##'
    end
    object qryCurrencyConversionsTriggerPriceVariation: TFloatField
      FieldName = 'TriggerPriceVariation'
      DisplayFormat = '####0.##%'
      EditFormat = '####0.##'
    end
    object qryCurrencyConversionsCurrencySymbol: TWideStringField
      FieldName = 'CurrencySymbol'
      Size = 3
    end
    object qryCurrencyConversionsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryCurrencyConversionsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryCurrencyConversionsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryCurrencyConversionsCountryID: TLargeintField
      FieldName = 'CountryID'
    end
  end
  object DSCurrencyConversions: TDataSource
    DataSet = qryCurrencyConversions
    Left = 413
    Top = 30
  end
  object ActionList: TActionList
    Left = 168
    Top = 40
    object actSave: TAction
      Caption = '&Save'
      HelpContext = 220046
      OnExecute = actSaveExecute
    end
    object actNew: TAction
      Caption = '&New'
      HelpContext = 220047
      OnExecute = actNewExecute
    end
    object actCancel: TAction
      Caption = '&Cancel'
      HelpContext = 220048
      OnExecute = actCancelExecute
    end
  end
  object qryCountry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblcountries')
    Left = 271
    Top = 149
    object qryCountryCurrencyDesc: TWideStringField
      DisplayWidth = 30
      FieldName = 'CurrencyDesc'
      Size = 255
    end
    object qryCountryCountry: TWideStringField
      DisplayWidth = 30
      FieldName = 'Country'
      Origin = 'tblcountries.Country'
      Visible = False
      Size = 255
    end
    object qryCountryCountryId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'CountryId'
      Origin = 'tblcountries.CountryId'
      Visible = False
    end
  end
end
