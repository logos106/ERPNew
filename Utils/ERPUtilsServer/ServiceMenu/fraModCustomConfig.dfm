inherited frModCustomConfig: TfrModCustomConfig
  Width = 545
  Height = 446
  ParentShowHint = False
  ShowHint = True
  ExplicitWidth = 545
  ExplicitHeight = 446
  object Bevel1: TBevel
    Left = 3
    Top = 3
    Width = 539
    Height = 440
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
    ExplicitWidth = 669
    ExplicitHeight = 512
  end
  object lblModuleName: TLabel
    Left = 14
    Top = 14
    Width = 77
    Height = 15
    HelpContext = 504027
    Caption = 'Module Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object rgLoggingLevel: TwwRadioGroup
    Left = 136
    Top = 14
    Width = 301
    Height = 44
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
    Left = 446
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
    AutoDisableParentOnclick = True
    OnClick = btnShowLogClick
  end
end
