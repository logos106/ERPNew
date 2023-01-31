inherited POSChequePopUp: TPOSChequePopUp
  Left = 207
  Top = 210
  HelpContext = 420000
  BorderStyle = bsDialog
  Caption = 'Enter Number'
  ClientHeight = 334
  ClientWidth = 797
  Color = 15527129
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnPaint = FormPaint
  ExplicitWidth = 803
  ExplicitHeight = 362
  DesignSize = (
    797
    334)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 334
    Width = 797
    ExplicitTop = 334
    ExplicitWidth = 797
    HelpContext = 420022
  end
  object Bevel1: TBevel [1]
    Left = 16
    Top = 96
    Width = 777
    Height = 121
    HelpContext = 420001
    Shape = bsFrame
  end
  object Bevel2: TBevel [2]
    Left = 88
    Top = 8
    Width = 641
    Height = 73
    HelpContext = 420002
    Shape = bsFrame
  end
  object CancelBtn: TDNMSpeedButton [5]
    Left = 449
    Top = 294
    Width = 87
    Height = 27
    HelpContext = 420005
    Caption = 'Cancel'
    Color = clWhite
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
    ModalResult = 2
    NumGlyphs = 2
    ParentColor = False
    ParentFont = False
    TabOrder = 1
  end
  object pnlNumericKeyPad: TDNMPanel [6]
    Left = 26
    Top = 223
    Width = 741
    Height = 56
    HelpContext = 420006
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Shape2: TShape
      Left = 63
      Top = 2
      Width = 60
      Height = 52
      HelpContext = 420023
    end
    object Shape3: TShape
      Left = 125
      Top = 2
      Width = 60
      Height = 52
      HelpContext = 420024
    end
    object Shape4: TShape
      Left = 186
      Top = 2
      Width = 60
      Height = 52
      HelpContext = 420025
    end
    object Shape5: TShape
      Left = 248
      Top = 2
      Width = 60
      Height = 52
      HelpContext = 420026
    end
    object Shape6: TShape
      Left = 309
      Top = 2
      Width = 60
      Height = 52
      HelpContext = 420027
    end
    object Shape7: TShape
      Left = 371
      Top = 2
      Width = 60
      Height = 52
      HelpContext = 420028
    end
    object Shape8: TShape
      Left = 432
      Top = 2
      Width = 60
      Height = 52
      HelpContext = 420029
    end
    object Shape9: TShape
      Left = 494
      Top = 2
      Width = 60
      Height = 52
      HelpContext = 420030
    end
    object Shape10: TShape
      Left = 555
      Top = 2
      Width = 60
      Height = 52
      HelpContext = 420031
    end
    object Shape11: TShape
      Left = 617
      Top = 2
      Width = 60
      Height = 52
      HelpContext = 420032
    end
    object Shape12: TShape
      Left = 679
      Top = 2
      Width = 60
      Height = 52
      HelpContext = 420033
    end
    object Shape1: TShape
      Left = 1
      Top = 2
      Width = 60
      Height = 52
      HelpContext = 420034
    end
    object btnNum1: TLabel
      Left = 2
      Top = 3
      Width = 58
      Height = 50
      HelpContext = 420007
      Alignment = taCenter
      AutoSize = False
      Caption = '1'
      Color = 14810111
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
      OnClick = btnNum1click
    end
    object btnNum2: TLabel
      Left = 64
      Top = 3
      Width = 58
      Height = 50
      HelpContext = 420008
      Alignment = taCenter
      AutoSize = False
      Caption = '2'
      Color = 14810111
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
      OnClick = btnNum1click
    end
    object btnNum3: TLabel
      Left = 126
      Top = 3
      Width = 58
      Height = 50
      HelpContext = 420009
      Alignment = taCenter
      AutoSize = False
      Caption = '3'
      Color = 14810111
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
      OnClick = btnNum1click
    end
    object btnNum4: TLabel
      Left = 187
      Top = 3
      Width = 58
      Height = 50
      HelpContext = 420010
      Alignment = taCenter
      AutoSize = False
      Caption = '4'
      Color = 14810111
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
      OnClick = btnNum1click
    end
    object btnNum5: TLabel
      Left = 249
      Top = 3
      Width = 58
      Height = 50
      HelpContext = 420011
      Alignment = taCenter
      AutoSize = False
      Caption = '5'
      Color = 14810111
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
      OnClick = btnNum1click
    end
    object btnNumDot: TLabel
      Left = 618
      Top = 3
      Width = 58
      Height = 50
      HelpContext = 420012
      Alignment = taCenter
      AutoSize = False
      Caption = '.'
      Color = 14810111
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
      OnClick = btnNum1click
    end
    object btnNum6: TLabel
      Left = 310
      Top = 3
      Width = 58
      Height = 50
      HelpContext = 420013
      Alignment = taCenter
      AutoSize = False
      Caption = '6'
      Color = 14810111
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
      OnClick = btnNum1click
    end
    object btnNum7: TLabel
      Left = 372
      Top = 3
      Width = 58
      Height = 50
      HelpContext = 420014
      Alignment = taCenter
      AutoSize = False
      Caption = '7'
      Color = 14810111
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
      OnClick = btnNum1click
    end
    object btnNum8: TLabel
      Left = 433
      Top = 3
      Width = 58
      Height = 50
      HelpContext = 420015
      Alignment = taCenter
      AutoSize = False
      Caption = '8'
      Color = 14810111
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
      OnClick = btnNum1click
    end
    object btnNum9: TLabel
      Left = 495
      Top = 3
      Width = 58
      Height = 50
      HelpContext = 420016
      Alignment = taCenter
      AutoSize = False
      Caption = '9'
      Color = 14810111
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
      OnClick = btnNum1click
    end
    object btnNum0: TLabel
      Left = 556
      Top = 3
      Width = 58
      Height = 50
      HelpContext = 420017
      Alignment = taCenter
      AutoSize = False
      Caption = '0'
      Color = 14810111
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
      OnClick = btnNum1click
    end
    object btnNumBS: TLabel
      Left = 680
      Top = 3
      Width = 58
      Height = 50
      HelpContext = 420018
      Alignment = taCenter
      AutoSize = False
      Caption = 'BS'
      Color = 14810111
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
      OnClick = btnNum1click
    end
  end
  object pnlTitle: TDNMPanel [7]
    Left = 103
    Top = 21
    Width = 611
    Height = 45
    HelpContext = 420019
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 607
      Height = 41
      HelpContext = 420020
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
        Width = 607
        Height = 41
        HelpContext = 420021
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Title'
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
  object OKBtn: TDNMSpeedButton [8]
    Left = 261
    Top = 294
    Width = 87
    Height = 27
    HelpContext = 420004
    Caption = 'OK'
    Color = clWhite
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    ModalResult = 1
    NumGlyphs = 2
    ParentColor = False
    ParentFont = False
    TabOrder = 0
  end
  object edtInput1: TwwDBEdit [9]
    Left = 24
    Top = 112
    Width = 761
    Height = 89
    HelpContext = 420003
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -64
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
    OnChange = edtInput1Change
    OnEnter = edtInput1Enter
  end
end
