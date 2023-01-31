inherited frModWebAPIConfig: TfrModWebAPIConfig
  Height = 273
  ExplicitHeight = 273
  DesignSize = (
    675
    273)
  object Bevel1: TBevel
    Left = 3
    Top = 3
    Width = 669
    Height = 269
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
  end
  object Label9: TLabel
    Left = 14
    Top = 14
    Width = 94
    Height = 15
    HelpContext = 504027
    Caption = 'Web API Service'
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
    Width = 92
    Height = 15
    Caption = 'Web User Name'
  end
  object Label3: TLabel
    Left = 20
    Top = 114
    Width = 94
    Height = 15
    Caption = 'Max Connections'
  end
  object Label7: TLabel
    Left = 197
    Top = 114
    Width = 222
    Height = 15
    Caption = '( A value of 0 means no connection limit )'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 20
    Top = 143
    Width = 60
    Height = 15
    Caption = 'Server Port'
  end
  object Label5: TLabel
    Left = 20
    Top = 172
    Width = 86
    Height = 15
    Caption = 'Server SSL Port'
  end
  object lblRestartMessage: TLabel
    Left = 168
    Top = 202
    Width = 473
    Height = 44
    AutoSize = False
    Caption = 'lblRestartMessage'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
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
    TabOrder = 0
    AutoDisableParentOnclick = True
    OnClick = btnShowLogClick
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
    TabOrder = 1
    OnClick = rgLoggingLevelClick
  end
  object edtWebUserName: TEdit
    Left = 124
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
    OnExit = edtWebUserNameExit
  end
  object btnTest: TDNMSpeedButton
    Left = 570
    Top = 98
    Width = 87
    Height = 27
    Anchors = [akTop, akRight]
    Caption = 'Test'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    ParentFont = False
    SlowDecease = True
    Style = bsModern
    TabOrder = 3
    AutoDisableParentOnclick = True
    OnClick = btnTestClick
  end
  object edtMaxConnections: TDBAdvEdit
    Left = 124
    Top = 111
    Width = 61
    Height = 23
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Text = '0'
    Visible = True
    OnExit = edtMaxConnectionsExit
    Version = '2.8.6.9'
  end
  object edtServerPort: TDBAdvEdit
    Left = 124
    Top = 140
    Width = 61
    Height = 23
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Text = '0'
    Visible = True
    OnExit = edtServerPortExit
    Version = '2.8.6.9'
  end
  object edtServerSSLPort: TDBAdvEdit
    Left = 124
    Top = 169
    Width = 61
    Height = 23
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    Text = '0'
    Visible = True
    OnExit = edtServerSSLPortExit
    Version = '2.8.6.9'
  end
  object chkUseSSL: TCheckBox
    Left = 20
    Top = 202
    Width = 118
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Use SSL'
    TabOrder = 7
    OnClick = chkUseSSLClick
  end
  object chkActive: TCheckBox
    Left = 20
    Top = 231
    Width = 118
    Height = 17
    Alignment = taLeftJustify
    Caption = 'API Server Active'
    TabOrder = 8
    OnClick = chkActiveClick
  end
  object btnRESTClient: TDNMSpeedButton
    Left = 570
    Top = 131
    Width = 87
    Height = 27
    Anchors = [akTop, akRight]
    Caption = 'Test App'
    DisableTransparent = False
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Style = bsModern
    TabOrder = 9
    AutoDisableParentOnclick = True
    OnClick = btnRESTClientClick
  end
  object btnLogFile: TDNMSpeedButton
    Left = 570
    Top = 60
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
    TabOrder = 10
    AutoDisableParentOnclick = True
    OnClick = btnLogFileClick
  end
end
