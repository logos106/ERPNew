inherited BarcodeGUI: TBarcodeGUI
  Left = 1261
  Top = 183
  HelpContext = 591000
  Caption = 'Barcode'
  ClientHeight = 220
  ClientWidth = 538
  Font.Charset = ANSI_CHARSET
  Font.Height = -12
  Font.Name = 'Arial'
  KeyPreview = True
  Position = poScreenCenter
  ExplicitLeft = 1261
  ExplicitTop = 183
  ExplicitWidth = 554
  ExplicitHeight = 259
  DesignSize = (
    538
    220)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 220
    Width = 538
    ExplicitTop = 220
    ExplicitWidth = 538
    HelpContext = 591008
  end
  object bvlBarcode: TBevel [3]
    Left = 34
    Top = 136
    Width = 469
    Height = 33
    HelpContext = 591001
    Anchors = [akTop]
  end
  object grdBarcodeSteps: TValueListEditor [4]
    Left = 35
    Top = 137
    Width = 467
    Height = 30
    HelpContext = 591002
    TabStop = False
    Anchors = [akTop]
    BorderStyle = bsNone
    Color = clBtnFace
    DefaultColWidth = 234
    DefaultDrawing = False
    DefaultRowHeight = 30
    DisplayOptions = [doAutoColResize, doKeyColFixed]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    GridLineWidth = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goAlwaysShowEditor, goThumbTracking]
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 2
    OnDrawCell = grdBarcodeStepsDrawCell
    ColWidths = (
      234
      231)
  end
  object btnClose: TDNMSpeedButton [5]
    Left = 225
    Top = 181
    Width = 87
    Height = 27
    HelpContext = 591003
    Anchors = [akTop]
    Caption = '&Close'
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
    HotTrackColor = clBtnShadow
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    NumGlyphs = 2
    ParentColor = False
    ParentFont = False
    SlowDecease = True
    Style = bsModern
    TabOrder = 1
    OnClick = btnCloseClick
  end
  object edtBarcode: TEdit [6]
    Left = 26
    Top = 72
    Width = 486
    Height = 50
    HelpContext = 591004
    Anchors = [akTop]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -37
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnKeyPress = edtBarcodeKeyPress
  end
  object pnlTitle: TDNMPanel [7]
    Left = 149
    Top = 6
    Width = 238
    Height = 45
    HelpContext = 591005
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 234
      Height = 41
      HelpContext = 591006
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
        Width = 234
        Height = 41
        HelpContext = 591007
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Barcode'
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
end
