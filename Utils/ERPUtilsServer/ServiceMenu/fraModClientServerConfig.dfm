inherited frModClientServerConfig: TfrModClientServerConfig
  Height = 149
  ExplicitHeight = 149
  object Bevel1: TBevel
    Left = 3
    Top = 1
    Width = 669
    Height = 145
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
    ExplicitHeight = 166
  end
  object lblModuleName: TLabel
    Left = 14
    Top = 14
    Width = 121
    Height = 15
    HelpContext = 504027
    Caption = 'Client Licence Server'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 20
    Top = 85
    Width = 107
    Height = 15
    Caption = 'Client Server Name'
  end
  object Label6: TLabel
    Left = 20
    Top = 116
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
  object edtClientServerName: TEdit
    Left = 133
    Top = 82
    Width = 121
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnExit = edtClientServerNameExit
  end
  object chkActive: TCheckBox
    Left = 133
    Top = 114
    Width = 17
    Height = 17
    TabOrder = 3
    OnClick = chkActiveClick
  end
end
