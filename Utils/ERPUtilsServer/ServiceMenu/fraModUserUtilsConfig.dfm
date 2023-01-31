inherited frModUserUtilsConfig: TfrModUserUtilsConfig
  Height = 440
  ExplicitHeight = 440
  DesignSize = (
    675
    440)
  object Bevel1: TBevel
    Left = 3
    Top = 3
    Width = 669
    Height = 434
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
    ExplicitHeight = 512
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
  object Label3: TLabel
    Left = 21
    Top = 91
    Width = 54
    Height = 15
    Caption = 'Database'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label1: TLabel
    Left = 158
    Top = 228
    Width = 267
    Height = 15
    Caption = 'This will make a copy of the selected database.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
  end
  object Label2: TLabel
    Left = 158
    Top = 251
    Width = 467
    Height = 51
    AutoSize = False
    Caption = 
      'This will make a copy of the selected database  with no closing ' +
      'dates "Locked Down Periods". All forms except the '#39'Preferences'#39' ' +
      'will be in '#39'Read-only'#39' Access. User '#39'Admin'#39' will have full acces' +
      's to the '#39'Access Levels'#39
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    WordWrap = True
  end
  object Label4: TLabel
    Left = 158
    Top = 316
    Width = 262
    Height = 15
    Caption = 'The database Selected above will be removed.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
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
    TabOrder = 0
    AutoDisableParentOnclick = True
    OnClick = btnShowLogClick
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
    TabOrder = 1
    OnClick = rgLoggingLevelClick
  end
  object cbDataBase: TComboBox
    Left = 89
    Top = 87
    Width = 344
    Height = 23
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object btnBackup: TDNMSpeedButton
    Left = 21
    Top = 136
    Width = 121
    Height = 25
    Caption = 'Backup'
    Color = clWhite
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
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
    OnClick = btnBackupClick
  end
  object btnRestore: TDNMSpeedButton
    Left = 21
    Top = 179
    Width = 121
    Height = 25
    Caption = 'Restore'
    Color = clWhite
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
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
    TabOrder = 4
    AutoDisableParentOnclick = True
    OnClick = btnRestoreClick
  end
  object btnClone: TDNMSpeedButton
    Left = 21
    Top = 223
    Width = 121
    Height = 25
    Caption = 'Clone'
    Color = clWhite
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
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
    TabOrder = 5
    AutoDisableParentOnclick = True
    OnClick = btnCloneClick
  end
  object btnReadonlyClose: TDNMSpeedButton
    Left = 21
    Top = 266
    Width = 121
    Height = 25
    Caption = 'Read-only Clone'
    Color = clWhite
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
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
    TabOrder = 6
    AutoDisableParentOnclick = True
    OnClick = btnReadonlyCloseClick
  end
  object btnRemove: TDNMSpeedButton
    Left = 21
    Top = 310
    Width = 121
    Height = 25
    Caption = 'Remove'
    Color = clWhite
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
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
    TabOrder = 7
    AutoDisableParentOnclick = True
    OnClick = btnRemoveClick
  end
  object btnCheckLicence: TDNMSpeedButton
    Left = 21
    Top = 353
    Width = 121
    Height = 25
    Caption = 'Check Licence'
    Color = clWhite
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
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
    TabOrder = 8
    AutoDisableParentOnclick = True
    OnClick = btnCheckLicenceClick
  end
  object btnCheckUpdate: TDNMSpeedButton
    Left = 21
    Top = 397
    Width = 121
    Height = 25
    Caption = 'Check Update'
    Color = clWhite
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
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
    TabOrder = 9
    AutoDisableParentOnclick = True
    OnClick = btnCheckUpdateClick
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
    TabOrder = 10
    AutoDisableParentOnclick = True
    OnClick = btnLogFileClick
  end
  object DNMSpeedButton1: TDNMSpeedButton
    Left = 536
    Top = 128
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
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
    TabOrder = 11
    AutoDisableParentOnclick = True
    OnClick = DNMSpeedButton1Click
  end
end
