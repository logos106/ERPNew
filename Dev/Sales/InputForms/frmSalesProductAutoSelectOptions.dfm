inherited fmSalesProductAutoSelectOptions: TfmSalesProductAutoSelectOptions
  Left = 472
  Top = 330
  HelpContext = 1012001
  Caption = 'Product Selection Options'
  ClientHeight = 343
  ClientWidth = 472
  Position = poScreenCenter
  ExplicitLeft = 472
  ExplicitTop = 330
  ExplicitWidth = 488
  ExplicitHeight = 382
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 307
    Width = 472
    HelpContext = 1012002
    ExplicitTop = 213
    ExplicitWidth = 479
  end
  object DNMPanel3: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 472
    Height = 58
    HelpContext = 1012006
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    Transparent = False
    object pnlTitle: TDNMPanel
      Left = 30
      Top = 8
      Width = 414
      Height = 38
      HelpContext = 1012007
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      Transparent = False
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 412
        Height = 36
        HelpContext = 1012008
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
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
          Width = 412
          Height = 36
          HelpContext = 1012009
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Product Selection Options'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 459
        end
      end
    end
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 0
    Top = 58
    Width = 472
    Height = 249
    HelpContext = 1012010
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Transparent = False
    ExplicitHeight = 252
    object Bevel4: TDNMPanel
      Left = 1
      Top = 1
      Width = 470
      Height = 62
      HelpContext = 1012014
      Align = alTop
      Anchors = []
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      DesignSize = (
        470
        62)
      object Label1: TLabel
        Left = 129
        Top = 1
        Width = 340
        Height = 60
        HelpContext = 1012015
        Align = alRight
        AutoSize = False
        Caption = 
          'Don'#39't use the Customer'#39's history to select Products.  Add Produc' +
          'ts direct on the Transaction.'
        Layout = tlCenter
        WordWrap = True
        ExplicitTop = -3
      end
      object btnIgnore: TDNMSpeedButton
        Left = 16
        Top = 18
        Width = 87
        Height = 27
        HelpContext = 1012019
        Anchors = []
        Caption = 'Ignore'
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
        TabOrder = 0
        TabStop = False
        OnClick = btnIgnoreClick
      end
    end
    object Bevel1: TDNMPanel
      Left = 1
      Top = 187
      Width = 470
      Height = 62
      HelpContext = 1012011
      Align = alTop
      Anchors = []
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = 10
      ExplicitTop = 170
      DesignSize = (
        470
        62)
      object Label4: TLabel
        Left = 129
        Top = 1
        Width = 340
        Height = 60
        HelpContext = 1012018
        Align = alRight
        AutoSize = False
        Caption = 'Open the full Product List to select Products'
        Layout = tlCenter
        ExplicitLeft = 128
        ExplicitTop = 22
        ExplicitHeight = 40
      end
      object DNMSpeedButton1: TDNMSpeedButton
        Left = 16
        Top = 18
        Width = 87
        Height = 27
        HelpContext = 1012022
        Anchors = []
        Caption = 'Product List'
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
        TabOrder = 0
        TabStop = False
        OnClick = DNMSpeedButton1Click
      end
    end
    object Bevel2: TDNMPanel
      Left = 1
      Top = 125
      Width = 470
      Height = 62
      HelpContext = 1012012
      Align = alTop
      Anchors = []
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      ExplicitLeft = 0
      ExplicitTop = 130
      DesignSize = (
        470
        62)
      object Label3: TLabel
        Left = 129
        Top = 1
        Width = 340
        Height = 60
        HelpContext = 1012017
        Align = alRight
        AutoSize = False
        Caption = 'See a list of Products the Customer has ordered'
        Layout = tlCenter
        ExplicitLeft = 127
        ExplicitTop = 27
        ExplicitHeight = 40
      end
      object btnOrderHistory: TDNMSpeedButton
        Left = 16
        Top = 18
        Width = 87
        Height = 27
        HelpContext = 1012021
        Anchors = []
        Caption = 'Order History'
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
        TabOrder = 0
        TabStop = False
        OnClick = btnOrderHistoryClick
      end
    end
    object Bevel3: TDNMPanel
      Left = 1
      Top = 63
      Width = 470
      Height = 62
      HelpContext = 1012013
      Align = alTop
      Anchors = []
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      DesignSize = (
        470
        62)
      object Label2: TLabel
        Left = 129
        Top = 1
        Width = 340
        Height = 60
        HelpContext = 1012016
        Align = alRight
        AutoSize = False
        Caption = 'Load the last order placed by the Customer'
        Layout = tlCenter
        ExplicitLeft = 128
        ExplicitTop = 22
        ExplicitHeight = 40
      end
      object btnLastOrder: TDNMSpeedButton
        Left = 16
        Top = 18
        Width = 87
        Height = 27
        HelpContext = 1012020
        Anchors = []
        Caption = 'Last Order'
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
        TabOrder = 0
        TabStop = False
        OnClick = btnLastOrderClick
      end
    end
  end
  object DNMPanel2: TDNMPanel [6]
    Left = 0
    Top = 307
    Width = 472
    Height = 36
    HelpContext = 1012003
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    Transparent = False
    ExplicitTop = 310
    DesignSize = (
      472
      36)
    object chkhide: TCheckBox
      Left = 317
      Top = 6
      Width = 147
      Height = 23
      HelpContext = 1012004
      Alignment = taLeftJustify
      Anchors = [akRight]
      Caption = 'Don'#39't Show Next Time'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = chkhideClick
    end
    object btnClose: TDNMSpeedButton
      Left = 189
      Top = 4
      Width = 87
      Height = 27
      HelpContext = 1012005
      Anchors = [akTop, akRight]
      Cancel = True
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      TabStop = False
      OnClick = btnCloseClick
    end
  end
end
