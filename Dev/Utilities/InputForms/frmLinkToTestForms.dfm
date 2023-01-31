inherited fmLinkToTestForms: TfmLinkToTestForms
  Caption = 'Link To'
  ClientHeight = 195
  ClientWidth = 244
  Position = poMainFormCenter
  ExplicitWidth = 252
  ExplicitHeight = 222
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 934001
  inherited lblSkingroupMsg: TLabel
    Top = 195
    Width = 244
    ExplicitTop = 195
    ExplicitWidth = 218
    HelpContext = 934002
  end
  object btnCancel: TDNMSpeedButton [3]
    Left = 78
    Top = 160
    Width = 87
    Height = 27
    HelpContext = 934003
    Anchors = [akBottom]
    Caption = 'Close'
    Color = clBtnFace
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
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    OnClick = btnCancelClick
  end
  object DNMSpeedButton1: TDNMSpeedButton [4]
    Left = 25
    Top = 31
    Width = 194
    Height = 27
    HelpContext = 934004
    Anchors = [akTop]
    Caption = 'Link to a Web Site'
    Color = clBtnFace
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
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    OnClick = DNMSpeedButton1Click
  end
  object btnCHeckSiteIntergration: TDNMSpeedButton [5]
    Left = 25
    Top = 71
    Width = 194
    Height = 27
    HelpContext = 934005
    Anchors = [akTop]
    Caption = 'Link to a another TrueERP Site'
    Color = clBtnFace
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
    ParentColor = False
    ParentFont = False
    TabOrder = 2
    OnClick = btnCHeckSiteIntergrationClick
  end
end
