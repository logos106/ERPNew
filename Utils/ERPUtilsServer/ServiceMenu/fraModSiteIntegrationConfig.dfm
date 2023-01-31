inherited frModSiteIntegrationConfig: TfrModSiteIntegrationConfig
  Height = 112
  ExplicitHeight = 112
  object Bevel1: TBevel
    Left = 3
    Top = 1
    Width = 669
    Height = 108
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
    ExplicitHeight = 360
  end
  object Label9: TLabel
    Left = 14
    Top = 14
    Width = 86
    Height = 15
    HelpContext = 504027
    Caption = 'Site Integration'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    Transparent = True
  end
  object Label6: TLabel
    Left = 14
    Top = 77
    Width = 31
    Height = 15
    Caption = 'Active'
  end
  object rgLoggingLevel: TwwRadioGroup
    Left = 192
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
    Top = 22
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
  object chkActive: TCheckBox
    Left = 78
    Top = 77
    Width = 19
    Height = 17
    TabOrder = 2
    OnClick = chkActiveClick
  end
end
