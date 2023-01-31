inherited fmAttributemain: TfmAttributemain
  Left = 187
  Top = 249
  Caption = 'Product Attribute Groups'
  ClientHeight = 562
  ClientWidth = 1000
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel [1]
    Left = 0
    Top = 0
    Width = 134
    Height = 562
    HelpContext = 388016
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object sbButtons: TScrollBox
      Left = 0
      Top = 0
      Width = 134
      Height = 159
      HelpContext = 388017
      HorzScrollBar.Visible = False
      Align = alTop
      BorderStyle = bsNone
      Color = clBtnFace
      ParentColor = False
      TabOrder = 0
      object pnlButtons: TDNMPanel
        Left = 0
        Top = 0
        Width = 134
        Height = 159
        HelpContext = 388018
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Transparent = False
      end
    end
    object sbGroup: TScrollBox
      Left = 0
      Top = 189
      Width = 134
      Height = 373
      HelpContext = 388019
      HorzScrollBar.Visible = False
      Align = alClient
      BorderStyle = bsNone
      Color = clBtnFace
      ParentColor = False
      TabOrder = 1
      object pnlGroups: TDNMPanel
        Left = 0
        Top = 0
        Width = 134
        Height = 373
        HelpContext = 388018
        Align = alTop
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Transparent = False
      end
    end
    object pnlBtnsTitle: TPanel
      Left = 0
      Top = 159
      Width = 134
      Height = 30
      HelpContext = 388021
      Align = alTop
      BevelOuter = bvNone
      Caption = '`'
      TabOrder = 2
      object lblList: TGradientLabel
        Left = 2
        Top = 7
        Width = 131
        Height = 18
        HelpContext = 388022
        Alignment = taCenter
        AutoSize = False
        Caption = 'Group List'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ColorTo = clWhite
        EllipsType = etNone
        GradientType = gtFullHorizontal
        Indent = 0
        LineWidth = 2
        Orientation = goHorizontal
        TransparentText = False
        VAlignment = vaCenter
      end
      object Bevel2: TBevel
        Left = 13
        Top = 3
        Width = 110
        Height = 7
        HelpContext = 388023
        Shape = bsTopLine
      end
    end
  end
  object pnlTitle: TDNMPanel [2]
    Left = 271
    Top = 2
    Width = 608
    Height = 37
    HelpContext = 388007
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 604
      Height = 33
      HelpContext = 388008
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      FromColor = clBtnFace
      ToColor = clWhite
      FromColorMirror = clWhite
      ToColorMirror = clBtnFace
      Steps = 10
      Direction = False
      Version = '1.2.1.1'
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 604
        Height = 33
        HelpContext = 388009
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Product Attribute Groups'
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
  object Shader1: TShader [3]
    Left = 142
    Top = 48
    Width = 850
    Height = 30
    HelpContext = 388005
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    Caption = 'Shader1'
    TabOrder = 2
    FromColor = clBtnFace
    ToColor = clWhite
    FromColorMirror = clWhite
    ToColorMirror = clBtnFace
    Steps = 10
    Direction = False
    Version = '1.2.1.1'
    object pnlActiveForm: TLabel
      Left = 0
      Top = 0
      Width = 850
      Height = 30
      HelpContext = 388006
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
  end
  object btnSave: TDNMSpeedButton [4]
    Left = 275
    Top = 532
    Width = 87
    Height = 27
    HelpContext = 388003
    Anchors = [akBottom]
    Caption = 'Save'
    Color = clBtnFace
    Default = True
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    ParentColor = False
    ParentFont = False
    TabOrder = 3
  end
  object btnNew: TDNMSpeedButton [5]
    Left = 524
    Top = 532
    Width = 87
    Height = 27
    HelpContext = 388015
    Anchors = [akBottom]
    Caption = 'New'
    Default = True
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
      333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
      0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
      07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
      07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
      0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
      33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
      B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
      3BB33773333773333773B333333B3333333B7333333733333337}
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 4
  end
  object btnCancel: TDNMSpeedButton [6]
    Left = 773
    Top = 532
    Width = 87
    Height = 27
    HelpContext = 388004
    Anchors = [akBottom]
    Cancel = True
    Caption = '&Cancel'
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
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 5
  end
  object pnlMain: TDNMPanel [7]
    Left = 142
    Top = 80
    Width = 849
    Height = 448
    HelpContext = 388010
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 6
    Transparent = False
  end
end
