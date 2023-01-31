inherited frmEmailInfoDlg: TfrmEmailInfoDlg
  Left = 409
  Top = 177
  HelpContext = 593000
  BorderStyle = bsSingle
  Caption = 'Email Information Request'
  ClientHeight = 326
  ClientWidth = 275
  Color = clSkyBlue
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = [fsBold]
  Position = poScreenCenter
  OnPaint = FormPaint
  ExplicitLeft = 409
  ExplicitTop = 177
  ExplicitWidth = 283
  ExplicitHeight = 353
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 326
    Width = 275
    HelpContext = 593014
  end
  object Label1: TLabel [1]
    Left = 35
    Top = 81
    Width = 82
    Height = 15
    HelpContext = 593001
    Caption = 'Email Address'
    Transparent = True
  end
  object Label2: TLabel [2]
    Left = 35
    Top = 144
    Width = 62
    Height = 15
    HelpContext = 593002
    Caption = 'SMTP Host'
    Transparent = True
  end
  object Label3: TLabel [3]
    Left = 35
    Top = 204
    Width = 24
    Height = 15
    HelpContext = 593003
    Caption = 'Port'
    Transparent = True
  end
  object Label4: TLabel [4]
    Left = 18
    Top = 59
    Width = 228
    Height = 15
    HelpContext = 593004
    Caption = 'Please supply your email contact details'
  end
  object Bevel1: TBevel [5]
    Left = 16
    Top = 76
    Width = 241
    Height = 184
    HelpContext = 593005
    Shape = bsFrame
  end
  object edtEmailAddress: TEdit [6]
    Left = 34
    Top = 102
    Width = 209
    Height = 23
    HelpContext = 593006
    TabOrder = 0
  end
  object edtSMTPHost: TEdit [7]
    Left = 34
    Top = 165
    Width = 209
    Height = 23
    HelpContext = 593007
    TabOrder = 1
  end
  object edtPort: TEdit [8]
    Left = 34
    Top = 223
    Width = 73
    Height = 23
    HelpContext = 593008
    TabOrder = 2
    OnExit = edtPortExit
  end
  object bbtnOk: TDNMSpeedButton [9]
    Left = 36
    Top = 280
    Width = 87
    Height = 27
    HelpContext = 593009
    Caption = 'OK'
    Default = True
    DisableTransparent = False
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
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    TabOrder = 3
    OnClick = bbtnOkClick
  end
  object bbtnCancel: TDNMSpeedButton [10]
    Left = 156
    Top = 280
    Width = 87
    Height = 27
    HelpContext = 593010
    Cancel = True
    Caption = 'Cancel'
    DisableTransparent = False
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
    HotTrackFont.Style = [fsBold]
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    TabOrder = 4
  end
  object pnlTitle: TDNMPanel [11]
    Left = 5
    Top = 8
    Width = 267
    Height = 36
    HelpContext = 593011
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
      Width = 263
      Height = 32
      HelpContext = 593012
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
        Width = 263
        Height = 32
        HelpContext = 593013
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Email Information Request'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
    end
  end
end
