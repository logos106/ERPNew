inherited frModGoogleConfig: TfrModGoogleConfig
  Height = 82
  ExplicitHeight = 82
  object Bevel1: TBevel
    Left = 3
    Top = 3
    Width = 669
    Height = 77
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
    ExplicitHeight = 328
  end
  object Label9: TLabel
    Left = 14
    Top = 14
    Width = 91
    Height = 15
    HelpContext = 504027
    Caption = 'Google Analitics'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    Transparent = True
  end
  object rgLoggingLevel: TwwRadioGroup
    Left = 203
    Top = 14
    Width = 345
    Height = 50
    DisableThemes = False
    Caption = 'Logging Level'
    Columns = 4
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Items.Strings = (
      'Error'
      'Warning'
      'Info'
      'Detail')
    ParentFont = False
    TabOrder = 0
    OnClick = rgLoggingLevelClick
  end
  object btnShowLog: TDNMSpeedButton
    Left = 570
    Top = 14
    Width = 87
    Height = 27
    Anchors = [akTop, akRight]
    Caption = 'Log'
    DisableTransparent = False
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Style = bsModern
    TabOrder = 1
    OnClick = btnShowLogClick
  end
  object chkActive: TwwCheckBox
    Left = 33
    Top = 38
    Width = 97
    Height = 17
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Caption = 'Active'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = chkActiveClick
  end
end
