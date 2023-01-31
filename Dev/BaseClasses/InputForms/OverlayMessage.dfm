object OverlayMessageGUI: TOverlayMessageGUI
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'OverlayMessageGUI'
  ClientHeight = 234
  ClientWidth = 920
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    920
    234)
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1692002
  object lblMsg: TLabel
    AlignWithMargins = True
    Left = 6
    Top = 6
    Width = 903
    Height = 179
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 0
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSize = False
    Caption = 'This is a Custom Message'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -43
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
    WordWrap = True
    HelpContext = 1692003
  end
  object btnClose: TDNMSpeedButton
    Left = 416
    Top = 199
    Width = 87
    Height = 27
    Anchors = [akBottom]
    Cancel = True
    Caption = '&Close'
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
    TabOrder = 0
    TabStop = False
    OnClick = btnCloseClick
    HelpContext = 1692004
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 792
    Top = 40
  end
end
