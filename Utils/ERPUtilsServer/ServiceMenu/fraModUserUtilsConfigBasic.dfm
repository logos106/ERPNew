inherited frModUserUtilsConfigBasic: TfrModUserUtilsConfigBasic
  Height = 130
  ExplicitHeight = 130
  DesignSize = (
    675
    130)
  object Bevel1: TBevel
    Left = 3
    Top = 3
    Width = 669
    Height = 124
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
    ExplicitHeight = 378
  end
  object Label9: TLabel
    Left = 14
    Top = 14
    Width = 72
    Height = 15
    HelpContext = 504027
    Caption = 'User Utilities'
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
    AutoDisableParentOnclick = True
    OnClick = btnShowLogClick
  end
  object btnLogFile: TDNMSpeedButton
    Left = 570
    Top = 54
    Width = 87
    Height = 27
    Anchors = [akTop, akRight]
    Caption = 'Log File'
    DisableTransparent = False
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Style = bsModern
    TabOrder = 2
    Visible = False
    AutoDisableParentOnclick = True
  end
  object DNMSpeedButton1: TDNMSpeedButton
    Left = 24
    Top = 80
    Width = 121
    Height = 25
    Caption = 'Offsite Backup'
    Color = clWhite
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    HotTrackColor = clBtnShadow
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    ParentColor = False
    ParentFont = False
    SlowDecease = True
    Style = bsModern
    TabOrder = 3
    AutoDisableParentOnclick = True
    OnClick = DNMSpeedButton1Click
  end
end
