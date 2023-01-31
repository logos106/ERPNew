inherited QuickBooksListGUI: TQuickBooksListGUI
  Left = 2286
  Top = 129
  Caption = 'Quickbooks ID List'
  ClientHeight = 562
  ClientWidth = 996
  FormStyle = fsMDIChild
  Position = poMainFormCenter
  Visible = True
  OnResize = FormResize
  ExplicitLeft = 2286
  ExplicitTop = 129
  ExplicitWidth = 1012
  ExplicitHeight = 601
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 474
    Width = 996
    ExplicitTop = 499
    ExplicitWidth = 996
  end
  object lblMsg: TLabel [4]
    Left = 0
    Top = 474
    Width = 996
    Height = 24
    Align = alBottom
    Alignment = taCenter
    Caption = 'Double Click to Link'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 201
  end
  object pnlFooter: TDNMPanel [5]
    Left = 0
    Top = 498
    Width = 996
    Height = 64
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      996
      64)
    object cmdClose: TDNMSpeedButton
      Left = 584
      Top = 20
      Width = 107
      Height = 25
      Hint = '"Close The List"'
      Anchors = [akBottom]
      Caption = '&Close'
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
      ModalResult = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = cmdCloseClick
    end
    object btnRequery: TDNMSpeedButton
      Left = 306
      Top = 20
      Width = 107
      Height = 25
      Caption = 'Refresh'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337FF3333333333330003333333333333777F333333333333080333
        3333333F33777FF33F3333B33B000B33B3333373F777773F7333333BBB0B0BBB
        33333337737F7F77F333333BBB0F0BBB33333337337373F73F3333BBB0F7F0BB
        B333337F3737F73F7F3333BB0FB7BF0BB3333F737F37F37F73FFBBBB0BF7FB0B
        BBB3773F7F37337F377333BB0FBFBF0BB333337F73F333737F3333BBB0FBF0BB
        B3333373F73FF7337333333BBB000BBB33333337FF777337F333333BBBBBBBBB
        3333333773FF3F773F3333B33BBBBB33B33333733773773373333333333B3333
        333333333337F33333333333333B333333333333333733333333}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = btnRequeryClick
    end
    object btnunlink: TDNMSpeedButton
      Left = 445
      Top = 20
      Width = 107
      Height = 25
      HelpContext = 372069
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Un-Link'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 2
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnunlinkClick
    end
    object btntest: TDNMSpeedButton
      Left = 173
      Top = 21
      Width = 100
      Height = 23
      Caption = 'Test'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      TabOrder = 3
      AutoDisableParentOnclick = True
      OnClick = btntestClick
    end
  end
  object pnlHeader: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 996
    Height = 64
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      996
      64)
    object Panel1: TPanel
      Left = 263
      Top = 5
      Width = 469
      Height = 49
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 467
        Height = 47
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
          Width = 467
          Height = 47
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Quickbooks ID List'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = 2
          ExplicitTop = 1
        end
      end
    end
  end
  object PgLists: TPageControl [7]
    Left = 0
    Top = 64
    Width = 996
    Height = 410
    ActivePage = tabPaymethods
    Align = alClient
    TabOrder = 2
    OnChange = PgListsChange
    OnResize = PgListsResize
    object TabAccounts: TTabSheet
      Caption = 'Accounts'
      object pnlAccounts: TDNMPanel
        Left = 0
        Top = 0
        Width = 988
        Height = 382
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
    end
    object tabPaymethods: TTabSheet
      Caption = 'Paymethods'
      ImageIndex = 4
      object pnlPaymethods: TDNMPanel
        Left = 0
        Top = 0
        Width = 988
        Height = 382
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
    end
    object tabTaxCodes: TTabSheet
      Caption = 'Tax Codes'
      ImageIndex = 1
      object pnlTaxcodes: TDNMPanel
        Left = 0
        Top = 0
        Width = 988
        Height = 382
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
    end
    object TabTaxrates: TTabSheet
      Caption = 'Tax Rates'
      ImageIndex = 3
      object pnlTaxRates: TDNMPanel
        Left = 0
        Top = 0
        Width = 988
        Height = 382
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
    end
    object TabTerms: TTabSheet
      Caption = 'Terms'
      ImageIndex = 2
      object pnlTerms: TDNMPanel
        Left = 0
        Top = 0
        Width = 988
        Height = 382
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 329
    Top = 248
  end
  inherited tmrdelay: TTimer
    Left = 430
    Top = 248
  end
  inherited popSpelling: TPopupMenu
    Left = 464
    Top = 248
  end
  inherited tmrdelayMsg: TTimer
    Left = 396
    Top = 248
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 362
    Top = 248
  end
end
