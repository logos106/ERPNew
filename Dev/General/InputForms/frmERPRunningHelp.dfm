inherited fmERPRunningHelp: TfmERPRunningHelp
  Left = 753
  Top = 157
  BorderStyle = bsNone
  Caption = 'fmERPRunningHelp'
  ClientHeight = 159
  OnResize = FormResize
  ExplicitLeft = 753
  ExplicitTop = 157
  ExplicitHeight = 198
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 159
    ExplicitTop = 141
  end
  object DNMPanel1: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 284
    Height = 159
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object sbMain: TAdvScrollBox
      Left = 1
      Top = 1
      Width = 282
      Height = 119
      Align = alClient
      DoubleBuffered = True
      Ctl3D = False
      ParentCtl3D = False
      ParentDoubleBuffered = False
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 0
      DesignSize = (
        280
        117)
      object lblMsg: TLabel
        Left = 3
        Top = 0
        Width = 37
        Height = 15
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = 'lblMsg'
        Color = clBtnFace
        ParentColor = False
        Transparent = False
        WordWrap = True
      end
    end
    object pnlfooter: TDNMPanel
      Left = 1
      Top = 120
      Width = 282
      Height = 38
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        282
        38)
      object btnClose: TDNMSpeedButton
        Left = 191
        Top = 5
        Width = 87
        Height = 27
        HelpContext = 372069
        Anchors = [akTop, akRight, akBottom]
        Cancel = True
        Caption = 'Close'
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
        AutoDisableParentOnclick = True
      end
    end
  end
  inherited tmrdelayMsg: TTimer
    Left = 64
  end
end
