inherited fmRosterDatePicker: TfmRosterDatePicker
  Left = 805
  Top = 359
  HelpContext = 1369002
  Caption = 'fmRosterDatePicker'
  ExplicitLeft = 805
  ExplicitTop = 359
  PixelsPerInch = 96
  TextHeight = 13
  object pnlDate: TDNMPanel [3]
    Left = 0
    Top = 0
    Width = 255
    Height = 50
    HelpContext = 1369003
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      255
      50)
    object dtpMonth: TwwDBDateTimePicker
      Left = 32
      Top = 13
      Width = 189
      Height = 23
      HelpContext = 1369004
      Anchors = [akLeft]
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      Epoch = 1950
      ShowButton = True
      TabOrder = 0
      DisplayFormat = 'mmmm yyyy'
      OnChange = dtpMonthChange
    end
    object btnPrev: TDNMSpeedButton
      Left = 5
      Top = 13
      Width = 25
      Height = 23
      HelpContext = 1369005
      Anchors = [akLeft]
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF3333333333333744333333333333F773333333333337
        44473333333333F777F3333333333744444333333333F7733733333333374444
        4433333333F77333733333333744444447333333F7733337F333333744444444
        433333F77333333733333744444444443333377FFFFFFF7FFFFF999999999999
        9999733777777777777333CCCCCCCCCC33333773FF333373F3333333CCCCCCCC
        C333333773FF3337F333333333CCCCCCC33333333773FF373F3333333333CCCC
        CC333333333773FF73F33333333333CCCCC3333333333773F7F3333333333333
        CCC333333333333777FF33333333333333CC3333333333333773}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      WordWrap = True
      OnClick = btnPrevClick
    end
    object btnNext: TDNMSpeedButton
      Left = 223
      Top = 13
      Width = 25
      Height = 23
      HelpContext = 1369006
      Anchors = [akLeft]
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000120B0000120B00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333447333333333333374447333333333333444447333333333334444447333
        3333337444444473333333344444444473333333444444444473999999999999
        99993333CCCCCCCCCC33333CCCCCCCCC3333333CCCCCCC33333333CCCCCC3333
        33333CCCCC33333333333CCC333333333333CC33333333333333}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      Layout = blGlyphRight
      NumGlyphs = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      WordWrap = True
      OnClick = btnNextClick
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 49
    Top = 91
  end
  inherited tmrdelay: TTimer
    Left = 120
    Top = 91
  end
  inherited popSpelling: TPopupMenu
    Left = 160
    Top = 91
  end
  inherited tmrdelayMsg: TTimer
    Left = 80
    Top = 91
  end
end
