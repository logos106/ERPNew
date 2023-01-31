inherited ReportPercentage: TReportPercentage
  Top = 316
  HelpContext = 471000
  Caption = 'Configure'
  ClientHeight = 252
  ClientWidth = 323
  OldCreateOrder = True
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel [0]
    Left = 37
    Top = 72
    Width = 249
    Height = 113
    HelpContext = 471002
    Shape = bsFrame
  end
  object Label1: TLabel [2]
    Left = 48
    Top = 144
    Width = 88
    Height = 15
    HelpContext = 471003
    Caption = 'Preferred Level'
    Transparent = True
  end
  object Label2: TLabel [3]
    Left = 48
    Top = 96
    Width = 78
    Height = 15
    HelpContext = 471004
    Caption = 'Reorder Point'
    Transparent = True
  end
  object Label3: TLabel [4]
    Left = 256
    Top = 96
    Width = 9
    Height = 15
    HelpContext = 471005
    Caption = '%'
    Transparent = True
  end
  object Label4: TLabel [5]
    Left = 256
    Top = 144
    Width = 9
    Height = 15
    HelpContext = 471006
    Caption = '%'
    Transparent = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 471001
  end
  object edtRP: TEdit [8]
    Left = 144
    Top = 92
    Width = 105
    Height = 23
    HelpContext = 471009
    TabOrder = 2
    OnKeyPress = edtRPKeyPress
  end
  object edtPL: TEdit [9]
    Left = 144
    Top = 140
    Width = 105
    Height = 23
    HelpContext = 471010
    TabOrder = 3
    OnKeyPress = edtRPKeyPress
  end
  object pnlTitle: TDNMPanel [10]
    Left = 60
    Top = 9
    Width = 205
    Height = 45
    HelpContext = 471011
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
      Width = 201
      Height = 41
      HelpContext = 471012
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
        Width = 201
        Height = 41
        HelpContext = 471013
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Configure'
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
  object btnCancel: TDNMSpeedButton [11]
    Left = 195
    Top = 209
    Width = 85
    Height = 27
    HelpContext = 471008
    Anchors = [akBottom]
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    TabOrder = 1
  end
  object btnOK: TDNMSpeedButton [12]
    Left = 51
    Top = 209
    Width = 87
    Height = 27
    HelpContext = 471007
    Anchors = [akBottom]
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ModalResult = 1
    NumGlyphs = 2
    TabOrder = 0
  end
end
