inherited fmChooseProductList: TfmChooseProductList
  Left = 501
  Top = 338
  Caption = 'Choose Product List'
  ClientHeight = 306
  ClientWidth = 382
  Position = poMainFormCenter
  ExplicitLeft = 501
  ExplicitTop = 338
  ExplicitWidth = 398
  ExplicitHeight = 345
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1632002
  inherited lblSkingroupMsg: TLabel
    Top = 235
    Width = 382
    ExplicitTop = 235
    ExplicitWidth = 382
    HelpContext = 1632003
  end
  object DNMPanel1: TDNMPanel [4]
    Left = 0
    Top = 235
    Width = 382
    Height = 71
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      382
      71)
    HelpContext = 1632004
    object cmdCancel: TDNMSpeedButton
      Left = 148
      Top = 30
      Width = 87
      Height = 27
      HelpContext = 1632005
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
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = cmdCancelClick
    end
    object chkShowProductListtypeSelection: TCheckBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 374
      Height = 21
      Align = alTop
      Caption = '  Show Choose List Options'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = chkShowProductListtypeSelectionClick
      HelpContext = 1632006
    end
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 382
    Height = 59
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    HelpContext = 1632007
    object pnlTitle: TDNMPanel
      Left = 46
      Top = 9
      Width = 308
      Height = 41
      HelpContext = 1632008
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 304
        Height = 37
        HelpContext = 1632009
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
          Width = 304
          Height = 37
          HelpContext = 1632010
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Choose Product List'
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
  object pnl1: TDNMPanel [6]
    Left = 0
    Top = 59
    Width = 127
    Height = 176
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    HelpContext = 1632011
    object lbl1: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 112
      Width = 119
      Height = 60
      HelpContext = 1632012
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = 'Fast, But No Quantities.  Updated Real Time'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
      ExplicitTop = 124
      ExplicitWidth = 125
    end
  end
  object pnl3: TDNMPanel [7]
    Left = 254
    Top = 59
    Width = 127
    Height = 176
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    HelpContext = 1632013
    object lbl3: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 112
      Width = 119
      Height = 60
      HelpContext = 1632014
      Align = alBottom
      Alignment = taCenter
      Caption = 
        'Slow, With Lots of Details.  Updated Once a Day Or With Batch Up' +
        'date'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
      ExplicitWidth = 113
    end
  end
  object pnl2: TDNMPanel [8]
    Left = 127
    Top = 59
    Width = 127
    Height = 176
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    HelpContext = 1632015
    object lbl2: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 112
      Width = 119
      Height = 60
      HelpContext = 1632016
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = 'Slower, With Quantities.  Updated Real Time'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
      ExplicitTop = 124
      ExplicitWidth = 125
    end
  end
  object tmrCheckShowProductListtypeSelectionPref: TTimer
    Enabled = False
    Interval = 500
    Left = 104
    Top = 104
  end
end
