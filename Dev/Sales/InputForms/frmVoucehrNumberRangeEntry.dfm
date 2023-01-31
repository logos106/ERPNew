inherited fmVoucehrNumberRangeEntry: TfmVoucehrNumberRangeEntry
  Left = 725
  Top = 191
  Caption = 'fmVoucehrNumberRangeEntry'
  ClientHeight = 264
  ClientWidth = 460
  Position = poScreenCenter
  ExplicitLeft = 725
  ExplicitTop = 191
  ExplicitWidth = 468
  ExplicitHeight = 291
  DesignSize = (
    460
    264)
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 975001
  inherited lblSkingroupMsg: TLabel
    Top = 249
    Width = 460
    ExplicitTop = 264
    ExplicitWidth = 460
    HelpContext = 975002
  end
  object lblto: TLabel [1]
    Left = 245
    Top = 132
    Width = 111
    Height = 15
    HelpContext = 975003
    Caption = 'Voucher Number To'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblAmount: TLabel [2]
    Left = 82
    Top = 92
    Width = 97
    Height = 15
    HelpContext = 975004
    Caption = 'Voucher Amount '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblfrom: TLabel [3]
    Left = 82
    Top = 132
    Width = 127
    Height = 15
    HelpContext = 975005
    Caption = 'Voucher Number From'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblHint: TLabel [4]
    Left = 0
    Top = 249
    Width = 460
    Height = 15
    HelpContext = 975006
    Align = alBottom
    Caption = 'hint'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
    ExplicitLeft = 3
  end
  object Bevel1: TBevel [5]
    Left = 34
    Top = 71
    Width = 393
    Height = 118
    HelpContext = 975007
  end
  object btnOk: TDNMSpeedButton [6]
    Left = 82
    Top = 207
    Width = 106
    Height = 30
    HelpContext = 975008
    Caption = 'OK'
    Color = clWhite
    Default = True
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
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
    HotTrackColor = clBtnShadow
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    NumGlyphs = 2
    ParentColor = False
    ParentFont = False
    Style = bsModern
    TabOrder = 3
    OnClick = btnOkClick
  end
  object btnCancel: TDNMSpeedButton [7]
    Left = 266
    Top = 207
    Width = 106
    Height = 30
    HelpContext = 975009
    Cancel = True
    Caption = 'Cancel'
    Color = clWhite
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
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
    HotTrackColor = clBtnShadow
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ModalResult = 2
    NumGlyphs = 2
    ParentColor = False
    ParentFont = False
    Style = bsModern
    TabOrder = 4
  end
  object edtVoucherNoto: TwwDBEdit [8]
    Left = 245
    Top = 148
    Width = 127
    Height = 23
    HelpContext = 975010
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Picture.PictureMask = '#[#][#][#][#][#][#][#][#][#][#][#][#][#][#][#][#][#]'
    TabOrder = 2
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
    OnExit = edtVoucherNotoExit
  end
  object pnlTitle: TDNMPanel [9]
    Left = 34
    Top = 13
    Width = 393
    Height = 45
    HelpContext = 975011
    Anchors = [akLeft, akTop, akRight]
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
      Width = 389
      Height = 41
      HelpContext = 975012
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
      ExplicitWidth = 390
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 389
        Height = 41
        HelpContext = 975013
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Voucher Number Range Entry'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 456
      end
    end
  end
  object edtVoucheramount: TwwDBEdit [10]
    Left = 188
    Top = 88
    Width = 184
    Height = 23
    HelpContext = 975014
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Picture.PictureMask = '#[#][#][#][#][#][#][#]'
    TabOrder = 0
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object edtVouchernumebrFrom: TwwDBEdit [11]
    Left = 82
    Top = 148
    Width = 127
    Height = 23
    HelpContext = 975015
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Picture.PictureMask = '#[#][#][#][#][#][#][#][#][#][#][#][#][#][#][#][#][#]'
    TabOrder = 1
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
    OnExit = edtVouchernumebrFromExit
  end
  inherited tmrdelay: TTimer
    Left = 70
  end
end
