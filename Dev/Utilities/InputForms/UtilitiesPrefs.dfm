inherited UtilitiesPrefsGUI: TUtilitiesPrefsGUI
  Left = 210
  Top = 39
  HelpContext = 544000
  VertScrollBar.Tracking = True
  Caption = 'Utilities Preferences'
  ClientHeight = 845
  ClientWidth = 873
  OldCreateOrder = True
  ExplicitTop = -363
  ExplicitWidth = 889
  ExplicitHeight = 884
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 845
    Width = 873
    HelpContext = 544091
    ExplicitTop = 810
    ExplicitWidth = 874
  end
  object lblWidth: TLabel [1]
    Left = 16
    Top = 8
    Width = 863
    Height = 22
    HelpContext = 544001
    Caption = 
      'All panels should have a width of 545.  Panel TabOrder is used f' +
      'or panel placement sequence.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited sbpanels: TAdvScrollBox
    Width = 873
    Height = 845
    HelpContext = 544174
    VertScrollBar.Position = 549
    ExplicitWidth = 873
    ExplicitHeight = 845
    object DNMPanel2: TDNMPanel
      Left = 0
      Top = -248
      Width = 854
      Height = 307
      HelpContext = 544025
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Bevel7: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 840
        Height = 293
        HelpContext = 544026
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 4
        ExplicitTop = 8
        ExplicitWidth = 521
        ExplicitHeight = 292
      end
      object Label5: TLabel
        Left = 14
        Top = 14
        Width = 207
        Height = 15
        HelpContext = 544027
        Caption = 'Marketing Lead : Email Configuration'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label6: TLabel
        Left = 25
        Top = 51
        Width = 43
        Height = 15
        HelpContext = 544056
        Caption = 'Subject'
        Transparent = True
      end
      object Label7: TLabel
        Left = 26
        Top = 83
        Width = 24
        Height = 15
        HelpContext = 544140
        Caption = 'Text'
        Transparent = True
      end
      object wwDBEdit1: TwwDBEdit
        Left = 74
        Top = 43
        Width = 441
        Height = 23
        HelpContext = 544022
        DataField = 'DefaultEmailSubject'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object DBMemo1: TDBMemo
        Left = 74
        Top = 85
        Width = 441
        Height = 200
        HelpContext = 544101
        DataField = 'DefaultEmailText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    object pnlEnabledModules: TDNMPanel
      Left = 0
      Top = 2082
      Width = 854
      Height = 237
      HelpContext = 544002
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        854
        237)
      object Bevel1: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 840
        Height = 223
        HelpContext = 544003
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitWidth = 530
      end
      object Label1: TLabel
        Left = 14
        Top = 14
        Width = 96
        Height = 15
        HelpContext = 544004
        Caption = 'Enabled Modules'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object ModulesCheckList: TCheckListBox
        AlignWithMargins = True
        Left = 35
        Top = 35
        Width = 769
        Height = 184
        HelpContext = 544005
        Margins.Left = 11
        OnClickCheck = ModulesCheckListClickCheck
        Anchors = [akLeft, akTop, akRight, akBottom]
        AutoComplete = False
        BevelEdges = []
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Columns = 2
        Flat = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ItemHeight = 30
        Items.Strings = (
          'Budget'
          'CRM / Marketing'
          'Delivery'
          'EDI & Integration'
          'Fixed Assets'
          'Google Analytics'
          'Hire'
          'Manufacturing'
          'Payroll'
          'Price Schemes'
          'WorkFlow'
          'Workshop')
        ParentColor = True
        ParentFont = False
        Sorted = True
        Style = lbOwnerDrawFixed
        TabOrder = 0
      end
    end
    object DNMPanel3: TDNMPanel
      Left = 0
      Top = 1161
      Width = 854
      Height = 921
      HelpContext = 544157
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      DesignSize = (
        854
        921)
      object Bevel9: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 840
        Height = 907
        HelpContext = 544158
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 5
        ExplicitWidth = 841
      end
      object Label2: TLabel
        Left = 14
        Top = 14
        Width = 44
        Height = 15
        HelpContext = 544159
        Caption = 'General'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Bevel12: TBevel
        Left = 154
        Top = 337
        Width = 595
        Height = 37
        HelpContext = 544145
        Anchors = [akLeft, akTop, akRight]
        Shape = bsFrame
        ExplicitWidth = 286
      end
      object Label11: TLabel
        Left = 48
        Top = 667
        Width = 238
        Height = 15
        HelpContext = 544170
        Caption = 'Choose the Tables to Export Automatically'
        Transparent = True
      end
      object wwCheckBox4: TwwCheckBox
        Left = 23
        Top = 520
        Width = 333
        Height = 17
        HelpContext = 544077
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Backup on last person exit'
        DataField = 'AutoBackup'
        DataSource = dsPrefs
        TabOrder = 0
      end
      object chkUseAuditTrail: TwwCheckBox
        Left = 23
        Top = 40
        Width = 333
        Height = 16
        HelpContext = 544085
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Use Audit Trail'
        Checked = True
        DataField = 'UseAuditTrail'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 1
      end
      object wwCheckBox5: TwwCheckBox
        Left = 23
        Top = 74
        Width = 333
        Height = 16
        HelpContext = 544086
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Use Clocking On'
        Checked = True
        DataField = 'UseClockOn'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 2
      end
      object chkUseWord: TwwCheckBox
        Left = 23
        Top = 108
        Width = 333
        Height = 16
        HelpContext = 544087
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Use MS Word'
        DataField = 'UseWord'
        DataSource = dsPersonalPreferences
        TabOrder = 3
      end
      object wwCheckBox6: TwwCheckBox
        Left = 23
        Top = 143
        Width = 333
        Height = 16
        HelpContext = 544088
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Phone Number Formatting'
        Checked = True
        DataField = 'PhoneNumberFormatting'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 4
      end
      object cbPostcodeFormatting: TwwCheckBox
        Left = 23
        Top = 211
        Width = 333
        Height = 16
        HelpContext = 544089
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Postcode Formatting'
        Checked = True
        DataField = 'PostcodeFormatting'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 5
      end
      object chkBankAccountFormatting: TwwCheckBox
        Left = 23
        Top = 246
        Width = 333
        Height = 16
        HelpContext = 544090
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Bank Account Formatting'
        Checked = True
        DataField = 'BankAccFormatting'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 7
      end
      object chkshowDashboard: TwwCheckBox
        Left = 23
        Top = 349
        Width = 130
        Height = 16
        HelpContext = 544146
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Show Dashboard'
        Checked = True
        DataField = 'ShowDashboard'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 6
      end
      object wwCheckBox8: TwwCheckBox
        Left = 23
        Top = 177
        Width = 333
        Height = 16
        HelpContext = 544147
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Tax Number Formatting'
        Checked = True
        DataField = 'CustomerABNFormating'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 8
      end
      object wwCheckBox9: TwwCheckBox
        Left = 23
        Top = 280
        Width = 333
        Height = 17
        HelpContext = 544148
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Ignore Training'
        DataField = 'IgnoreTraining'
        DataSource = dsPrefs
        TabOrder = 9
      end
      object wwCheckBox10: TwwCheckBox
        Left = 23
        Top = 314
        Width = 333
        Height = 17
        HelpContext = 544057
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Preview Email'
        DataField = 'DefaultMailClientPreview'
        DataSource = dsPrefs
        TabOrder = 10
      end
      object wwRadioGroup1: TwwRadioGroup
        Left = 160
        Top = 331
        Width = 275
        Height = 34
        HelpContext = 544104
        DisableThemes = False
        Columns = 2
        DataField = 'DashboardToshow'
        DataSource = dsPrefs
        Items.Strings = (
          'Main Dashboard'
          'Sale Dashboard')
        TabOrder = 11
        Values.Strings = (
          'M'
          'S')
      end
      object chkSchedulereportsEnabled: TwwCheckBox
        Left = 23
        Top = 383
        Width = 333
        Height = 17
        HelpContext = 544105
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Enable Scheduled Reports '
        DataField = 'EnableScheduledreports'
        DataSource = dsPrefs
        TabOrder = 12
      end
      object chkAusEParcel: TwwCheckBox
        Left = 23
        Top = 417
        Width = 333
        Height = 17
        HelpContext = 544106
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Enable Australian E-Parcel'
        DataField = 'EnableAusEparcel'
        DataSource = dsPrefs
        TabOrder = 13
      end
      object btnSpelling: TDNMSpeedButton
        Left = 333
        Top = 597
        Width = 121
        Height = 27
        HelpContext = 544107
        Anchors = [akTop, akRight]
        Caption = 'Spelling Prefs'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Style = bsModern
        TabOrder = 14
        AutoDisableParentOnclick = True
        OnClick = btnSpellingClick
      end
      object chkBackupAfterUpdateCheck: TwwCheckBox
        Left = 23
        Top = 555
        Width = 200
        Height = 17
        HelpContext = 544156
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Backup after update check'
        DataField = 'BackupAfterRestart'
        DataSource = dsPrefs
        TabOrder = 15
      end
      object DNMSpeedButton1: TDNMSpeedButton
        Left = 225
        Top = 548
        Width = 121
        Height = 27
        HelpContext = 544164
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
        TabOrder = 16
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton1Click
      end
      object btnHowto: TDNMSpeedButton
        Left = 352
        Top = 548
        Width = 78
        Height = 27
        HelpContext = 544166
        Caption = 'How To'
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
        TabOrder = 17
        AutoDisableParentOnclick = True
        OnClick = btnHowtoClick
      end
      object wwCheckBox1: TwwCheckBox
        Left = 23
        Top = 634
        Width = 333
        Height = 17
        HelpContext = 544172
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Export to Report DB After Update Check'
        DataField = 'ExporttoReportDBAfterRestart'
        DataSource = dsPrefs
        TabOrder = 18
      end
      object wwDBGrid1: TwwDBGrid
        Left = 45
        Top = 688
        Width = 341
        Height = 216
        HelpContext = 544173
        ControlType.Strings = (
          'IncludeinMidnightupdate;CheckBox;T;F')
        Selected.Strings = (
          'TableName'#9'30'#9'Name'
          'IncludeinMidnightupdate'#9'12'#9'Export After~Update Check ?'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        DataSource = dsexporttables
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 19
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 2
        TitleButtons = False
        FooterCellColor = clWhite
      end
      object chkGenerateEmployeeno: TwwCheckBox
        Left = 23
        Top = 452
        Width = 333
        Height = 17
        HelpContext = 544175
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Generate Employee No For New Employees'
        DataField = 'GenerateEmployeeno'
        DataSource = dsPrefs
        TabOrder = 20
      end
      object chkShowToDoNotifications: TwwCheckBox
        Left = 23
        Top = 486
        Width = 333
        Height = 17
        HelpContext = 544176
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Show To Do Notifications'
        DataField = 'ShowToDoNotifications'
        DataSource = dsPrefs
        TabOrder = 21
      end
    end
    object DNMPanel6: TDNMPanel
      Left = 0
      Top = 825
      Width = 854
      Height = 336
      HelpContext = 544152
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      DesignSize = (
        854
        336)
      object Bevel8: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 840
        Height = 322
        HelpContext = 544153
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 15
        ExplicitWidth = 525
        ExplicitHeight = 528
      end
      object Label12: TLabel
        Left = 14
        Top = 24
        Width = 318
        Height = 15
        HelpContext = 544154
        Caption = 'Log Changing Details (User / Date n Time ) on Note Fields'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object chkLogchangingDetailsonServicePadFeedback: TwwCheckBox
        Left = 275
        Top = 131
        Width = 222
        Height = 17
        HelpContext = 544119
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Service Pad Feedback'
        DataField = 'LogchangingDetailsonServicePadFeedback'
        DataSource = dsPrefs
        TabOrder = 0
      end
      object chkLogchangingDetailsonchequecomments: TwwCheckBox
        Left = 34
        Top = 93
        Width = 222
        Height = 17
        HelpContext = 544120
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Cheque Comments'
        DataField = 'LogchangingDetailsonchequecomments'
        DataSource = dsPrefs
        TabOrder = 1
      end
      object chkLogchangingDetailsonCashsAleComments: TwwCheckBox
        Left = 34
        Top = 55
        Width = 222
        Height = 17
        HelpContext = 544121
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Cash Sale Comments'
        DataField = 'LogchangingDetailsonCashsAleComments'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object chkLogchangingDetailsonSupportPricingNotes: TwwCheckBox
        Left = 275
        Top = 93
        Width = 222
        Height = 17
        HelpContext = 544122
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Support Pricing Notes'
        DataField = 'LogchangingDetailsonSupportPricingNotes'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object chkLogchangingDetailsonSupplierfollowupNotes: TwwCheckBox
        Left = 275
        Top = 169
        Width = 222
        Height = 17
        HelpContext = 544123
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Supplier Followup Notes'
        DataField = 'LogchangingDetailsonSupplierfollowupNotes'
        DataSource = dsPrefs
        TabOrder = 4
      end
      object chkLogchangingDetailsonchequeInternalcomments: TwwCheckBox
        Left = 34
        Top = 131
        Width = 222
        Height = 17
        HelpContext = 544124
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Cheque Internal Comments'
        DataField = 'LogchangingDetailsonchequeInternalcomments'
        DataSource = dsPrefs
        TabOrder = 5
      end
      object chkLogchangingDetailsonCustPayComments: TwwCheckBox
        Left = 34
        Top = 208
        Width = 222
        Height = 17
        HelpContext = 544125
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Customer Payment Comments'
        DataField = 'LogchangingDetailsonCustPayComments'
        DataSource = dsPrefs
        TabOrder = 6
      end
      object chkLogchangingDetailsonDepositEntryNotes: TwwCheckBox
        Left = 34
        Top = 246
        Width = 222
        Height = 17
        HelpContext = 544126
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Deposit Entry Notes'
        DataField = 'LogchangingDetailsonDepositEntryNotes'
        DataSource = dsPrefs
        TabOrder = 7
      end
      object chkLogchangingDetailsonDepositNotes: TwwCheckBox
        Left = 275
        Top = 54
        Width = 222
        Height = 17
        HelpContext = 544127
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Deposit Notes'
        DataField = 'LogchangingDetailsonDepositNotes'
        DataSource = dsPrefs
        TabOrder = 8
      end
      object chkLogchangingDetailsonSuppPayNotes: TwwCheckBox
        Left = 275
        Top = 208
        Width = 222
        Height = 17
        HelpContext = 544128
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Supplier Payment Notes'
        DataField = 'LogchangingDetailsonSuppPayNotes'
        DataSource = dsPrefs
        TabOrder = 9
      end
      object chkLogchangingDetailsonCustomerfollowupNotes: TwwCheckBox
        Left = 34
        Top = 169
        Width = 222
        Height = 17
        HelpContext = 544129
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Customer Followup Notes'
        DataField = 'LogchangingDetailsonCustomerfollowupNotes'
        DataSource = dsPrefs
        TabOrder = 10
      end
      object btnDisableLogchangingDetails: TDNMSpeedButton
        Left = 34
        Top = 288
        Width = 87
        Height = 27
        HelpContext = 544130
        Anchors = [akLeft, akBottom]
        Caption = 'Disable All'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Style = bsModern
        TabOrder = 11
        AutoDisableParentOnclick = True
        OnClick = EnabledisableLogchangeDetails
      end
      object btnEnableLogchangingDetails: TDNMSpeedButton
        Left = 147
        Top = 288
        Width = 87
        Height = 27
        HelpContext = 544131
        Anchors = [akLeft, akBottom]
        Caption = 'Enable All'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Style = bsModern
        TabOrder = 12
        AutoDisableParentOnclick = True
        OnClick = EnabledisableLogchangeDetails
      end
    end
    object DNMPanel1: TDNMPanel
      Left = 0
      Top = 209
      Width = 854
      Height = 191
      HelpContext = 544092
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object Bevel11: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 840
        Height = 177
        HelpContext = 544093
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 9
        ExplicitTop = 9
        ExplicitWidth = 841
      end
      object Label19: TLabel
        Left = 14
        Top = 14
        Width = 66
        Height = 15
        HelpContext = 544094
        Caption = 'Data Export'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label24: TLabel
        Left = 45
        Top = 94
        Width = 131
        Height = 15
        HelpContext = 544143
        Caption = 'Default Export File Type'
        Transparent = True
      end
      object wwCheckBox3: TwwCheckBox
        Left = 43
        Top = 51
        Width = 333
        Height = 17
        HelpContext = 544177
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Do Not Prompt for Filename (Use System Generated File Name)'
        DataField = 'UseERPFilenameforDataExport'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object wwDBComboBox2: TwwDBComboBox
        Left = 200
        Top = 90
        Width = 218
        Height = 23
        HelpContext = 544178
        ShowButton = True
        Style = csDropDown
        MapList = True
        AllowClearKey = False
        DataField = 'DataExportDefaultExtension'
        DataSource = dsPrefs
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          'Tabbed Delimited Text (TXT)'#9'TXT'
          'Comma Delimited Text (CSV)'#9'CSV'
          'Excel SYLK (SLK)'#9'SLK'
          'HTML (HTML)'#9'HTML')
        ItemIndex = 0
        ParentFont = False
        Sorted = False
        TabOrder = 0
        UnboundDataType = wwDefault
      end
      object wwCheckBox2: TwwCheckBox
        Left = 43
        Top = 137
        Width = 333
        Height = 17
        HelpContext = 544179
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Open File When Data Exported'
        DataField = 'OpenfileWhenDataExported'
        DataSource = dsPrefs
        TabOrder = 1
      end
    end
    object pnlDayWeekInfo: TDNMPanel
      Left = 0
      Top = 59
      Width = 854
      Height = 150
      HelpContext = 544180
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      object Bevel2: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 840
        Height = 136
        HelpContext = 544181
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitWidth = 529
        ExplicitHeight = 134
      end
      object Label9: TLabel
        Left = 14
        Top = 14
        Width = 63
        Height = 15
        HelpContext = 544182
        Caption = 'Day / Week'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label21: TLabel
        Left = 24
        Top = 40
        Width = 153
        Height = 15
        HelpContext = 544095
        Caption = 'Start Day of Working Week'
        Transparent = True
      end
      object Label22: TLabel
        Left = 248
        Top = 40
        Width = 99
        Height = 15
        HelpContext = 544096
        Caption = 'Start Of Day Time'
        Transparent = True
      end
      object Label23: TLabel
        Left = 392
        Top = 40
        Width = 92
        Height = 15
        HelpContext = 544097
        Caption = 'End Of Day Time'
        Transparent = True
      end
      object Label8: TLabel
        Left = 26
        Top = 108
        Width = 117
        Height = 15
        HelpContext = 544020
        Caption = 'No of Weekend Days'
        Transparent = True
      end
      object lblHours: TLabel
        Left = 248
        Top = 108
        Width = 90
        Height = 15
        HelpContext = 544165
        Caption = 'Hours In a Day : '
        Transparent = True
      end
      object wwDBComboBox1: TwwDBComboBox
        Left = 24
        Top = 56
        Width = 201
        Height = 23
        HelpContext = 544098
        ShowButton = True
        Style = csDropDown
        MapList = False
        AllowClearKey = False
        AutoDropDown = True
        DataField = 'StartWorkWeek'
        DataSource = dsPrefs
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          'Monday'
          'Tuesday'
          'Wednesday'
          'Thursday'
          'Friday'
          'Saturday'
          'Sunday')
        ItemIndex = 2
        ParentFont = False
        Sorted = False
        TabOrder = 0
        UnboundDataType = wwDefault
      end
      object wwDBDateTimePicker1: TwwDBDateTimePicker
        Left = 248
        Top = 56
        Width = 121
        Height = 23
        HelpContext = 544099
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'StartOfDay'
        DataSource = dsPrefs
        Epoch = 1950
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 1
        DisplayFormat = 'hh:mm am/pm'
        OnChange = wwDBDateTimePicker1Change
      end
      object wwDBDateTimePicker2: TwwDBDateTimePicker
        Left = 392
        Top = 56
        Width = 121
        Height = 23
        HelpContext = 544100
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'EndOfDay'
        DataSource = dsPrefs
        Epoch = 1950
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 2
        DisplayFormat = 'hh:mm am/pm'
        OnChange = wwDBDateTimePicker1Change
      end
      object wwDBSpinEdit2: TwwDBSpinEdit
        Left = 149
        Top = 104
        Width = 65
        Height = 23
        HelpContext = 544024
        Increment = 1.000000000000000000
        MaxValue = 7.000000000000000000
        Value = 5.000000000000000000
        DataField = 'NoofWeekendDays'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        UnboundDataType = wwDefault
      end
    end
    object pnlAuditTrail: TDNMPanel
      Left = 0
      Top = 2424
      Width = 854
      Height = 105
      HelpContext = 544132
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      object Bevel10: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 840
        Height = 91
        HelpContext = 544133
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 12
        ExplicitWidth = 531
        ExplicitHeight = 86
      end
      object Label20: TLabel
        Left = 14
        Top = 14
        Width = 56
        Height = 15
        HelpContext = 544134
        Caption = 'Audit Trail'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label25: TLabel
        Left = 22
        Top = 63
        Width = 184
        Height = 15
        HelpContext = 544136
        Caption = 'Purge entries that are older than'
        Transparent = True
      end
      object Label28: TLabel
        Left = 283
        Top = 63
        Width = 46
        Height = 15
        HelpContext = 544137
        Caption = 'months.'
        Transparent = True
      end
      object chkAutoPurgeAuditTrail: TwwCheckBox
        Left = 21
        Top = 36
        Width = 220
        Height = 17
        HelpContext = 544138
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Auto Purge Audit Trail'
        DataField = 'AutoPurgeAuditTrail'
        DataSource = dsPrefs
        TabOrder = 0
      end
      object edtAuditPurgeMonths: TwwDBEdit
        Left = 219
        Top = 59
        Width = 50
        Height = 23
        HelpContext = 544139
        DataField = 'AutoPurgeAuditTrailMonths'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
    end
    object DNMPanel4: TDNMPanel
      Left = 0
      Top = 2319
      Width = 854
      Height = 105
      HelpContext = 544010
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      object Bevel5: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 840
        Height = 91
        HelpContext = 544011
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 89
      end
      object Label26: TLabel
        Left = 14
        Top = 14
        Width = 46
        Height = 15
        HelpContext = 544012
        Caption = 'Printers'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label27: TLabel
        Left = 24
        Top = 40
        Width = 87
        Height = 15
        HelpContext = 544013
        Caption = 'Primary Printer'
        Transparent = True
      end
      object txtDBPrimaryPrinter: TwwDBComboBox
        Left = 24
        Top = 56
        Width = 201
        Height = 23
        HelpContext = 544014
        ShowButton = True
        Style = csDropDown
        MapList = False
        AllowClearKey = False
        AutoDropDown = True
        DataField = 'PrimaryPrinter'
        DataSource = dsPrefs
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        ParentFont = False
        Sorted = False
        TabOrder = 0
        UnboundDataType = wwDefault
      end
    end
    object pnlNewDatabaseDefaultData: TDNMPanel
      Left = 0
      Top = 400
      Width = 854
      Height = 425
      HelpContext = 544058
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      object Bevel3: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 840
        Height = 411
        HelpContext = 544059
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 9
        ExplicitHeight = 356
      end
      object Bevel4: TBevel
        Left = 23
        Top = 68
        Width = 354
        Height = 325
        HelpContext = 544060
      end
      object Label10: TLabel
        Left = 14
        Top = 14
        Width = 154
        Height = 15
        HelpContext = 544061
        Caption = 'New Database Default Data'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label13: TLabel
        Left = 48
        Top = 41
        Width = 169
        Height = 15
        HelpContext = 544064
        Caption = 'Copy Data when creating New'
        Transparent = True
      end
      object chkCopyDataOnNew: TwwCheckBox
        Left = 26
        Top = 40
        Width = 16
        Height = 17
        HelpContext = 544079
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Copy Data when creating New'
        Checked = True
        DataField = 'CopyDataToNewDB'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 0
        OnClick = chkCopyDataOnNewClick
      end
      object chkCopyAccess: TwwCheckBox
        Left = 41
        Top = 160
        Width = 333
        Height = 17
        HelpContext = 544080
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Copy Employee Preferences'
        Checked = True
        DataField = 'CopyEmployeeSettings'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 3
        OnClick = OnCopyOptionclick
        OnExit = chkCopyEmployeeExit
      end
      object chkCopyCompany: TwwCheckBox
        Left = 39
        Top = 119
        Width = 333
        Height = 17
        HelpContext = 544081
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Copy Company Preferences'
        Checked = True
        DataField = 'CopyCompanySettings'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 2
        OnClick = OnCopyOptionclick
        OnExit = chkCopyEmployeeExit
      end
      object chkCopyEmployee: TwwCheckBox
        Left = 40
        Top = 79
        Width = 333
        Height = 17
        HelpContext = 544082
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Copy Employee Access.'
        Checked = True
        DataField = 'CopyEmployeeAccess'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 1
        OnClick = OnCopyOptionclick
        OnExit = chkCopyEmployeeExit
      end
      object chkCopyProduct: TwwCheckBox
        Left = 40
        Top = 205
        Width = 333
        Height = 17
        HelpContext = 544083
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Copy Products'
        Checked = True
        DataField = 'CopyProducts'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 4
        OnClick = OnCopyOptionclick
        OnExit = chkCopyEmployeeExit
      end
      object chkCopyCOA: TwwCheckBox
        Left = 41
        Top = 241
        Width = 333
        Height = 17
        HelpContext = 544084
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Copy Chart Of Accounts'
        DataField = 'CopyCOA'
        DataSource = dsPrefs
        TabOrder = 5
        OnClick = OnCopyOptionclick
        OnExit = chkCopyEmployeeExit
      end
      object chkCopyClients: TwwCheckBox
        Left = 40
        Top = 281
        Width = 333
        Height = 17
        HelpContext = 544162
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Copy Clients (Customers,Suppliers and Prospects)'
        DataField = 'CopyClients'
        DataSource = dsPrefs
        TabOrder = 6
        OnClick = OnCopyOptionclick
        OnExit = chkCopyEmployeeExit
      end
      object chkCopyMarketingContacts: TwwCheckBox
        Left = 40
        Top = 322
        Width = 333
        Height = 17
        HelpContext = 544163
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Copy Marketing Contacts'
        DataField = 'CopyMarketingContacts'
        DataSource = dsPrefs
        TabOrder = 7
        OnClick = OnCopyOptionclick
        OnExit = chkCopyEmployeeExit
      end
      object chkCopyOutstandingTxn: TwwCheckBox
        Left = 40
        Top = 362
        Width = 333
        Height = 17
        HelpContext = 544163
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Copy Outstanding Transactions'
        DataField = 'CopyOutstandingTxn'
        DataSource = dsPrefs
        TabOrder = 8
        OnClick = OnCopyOptionclick
        OnExit = chkCopyEmployeeExit
      end
    end
    object pnlPassword: TDNMPanel
      Left = 0
      Top = -549
      Width = 854
      Height = 301
      HelpContext = 544183
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      object Bevel13: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 840
        Height = 287
        HelpContext = 544184
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = -72
        ExplicitTop = -5
        ExplicitWidth = 531
        ExplicitHeight = 303
      end
      object Shape1: TShape
        Left = 32
        Top = 35
        Width = 498
        Height = 96
        HelpContext = 544185
        Brush.Style = bsClear
        Pen.Color = clGray
      end
      object lblUserPassword: TLabel
        Left = 14
        Top = 14
        Width = 88
        Height = 15
        HelpContext = 544186
        Caption = 'User Password'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object lblLoginExpireDays: TLabel
        Left = 39
        Top = 52
        Width = 162
        Height = 15
        HelpContext = 544167
        Alignment = taRightJustify
        Caption = 'Login Password Expire Days'
        Transparent = True
      end
      object lblLoginExpireDays2: TLabel
        Left = 261
        Top = 52
        Width = 100
        Height = 15
        HelpContext = 544168
        Caption = '(0 = Never expire)'
        Transparent = True
      end
      object lblPassExpireDate: TLabel
        Left = 41
        Top = 95
        Width = 160
        Height = 15
        HelpContext = 544187
        Alignment = taRightJustify
        Caption = 'Login Password Expire Date'
        Transparent = True
      end
      object Label32: TLabel
        Left = 160
        Top = 74
        Width = 17
        Height = 15
        HelpContext = 544188
        Caption = 'OR'
      end
      object Label33: TLabel
        Left = 19
        Top = 150
        Width = 180
        Height = 15
        HelpContext = 544189
        AutoSize = False
        Caption = 'Minimum Password Characters'
        Transparent = True
      end
      object Label34: TLabel
        Left = 266
        Top = 150
        Width = 180
        Height = 15
        HelpContext = 544190
        AutoSize = False
        Caption = '(0 = No Minimum)'
        Transparent = True
      end
      object lblLoginExpireDayshint: TLabel
        Left = 374
        Top = 50
        Width = 152
        Height = 60
        HelpContext = 544191
        AutoSize = False
        Caption = 
          '"Password Never Expires" on Employee Card overrides these Prefer' +
          'ences'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object edtLoginExpireDays: TDBAdvEdit
        Left = 216
        Top = 46
        Width = 39
        Height = 23
        HelpContext = 544171
        EditType = etNumeric
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        TabOrder = 0
        Text = '0'
        Visible = True
        OnChange = edtLoginExpireDaysChange
        Version = '2.8.6.9'
        DataField = 'LoginExpireDays'
        DataSource = dsPrefs
      end
      object edtPassExpireDate: TwwDBDateTimePicker
        Left = 217
        Top = 91
        Width = 121
        Height = 23
        HelpContext = 544192
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'Tahoma'
        CalendarAttributes.Font.Style = []
        DataField = 'LoginExpireDate'
        DataSource = dsPrefs
        Epoch = 1950
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 1
        OnChange = edtPassExpireDateChange
      end
      object edtMinPasswordChars: TAdvEdit
        Left = 217
        Top = 146
        Width = 44
        Height = 23
        HelpContext = 544193
        EditType = etNumeric
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        TabOrder = 2
        Text = '0'
        Visible = True
        OnChange = edtMinPasswordCharsChange
        Version = '2.8.6.9'
      end
      object chkIncludeUppercaseChar: TwwCheckBox
        Left = 31
        Top = 178
        Width = 200
        Height = 17
        HelpContext = 544194
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        Caption = 'Include Uppercase Character'
        TabOrder = 3
        OnClick = chkIncludeUppercaseCharClick
      end
      object chkIncludeLowercaseChar: TwwCheckBox
        Left = 29
        Top = 205
        Width = 202
        Height = 17
        HelpContext = 544195
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        Caption = 'Include Lowercase Character'
        TabOrder = 4
        OnClick = chkIncludeLowercaseCharClick
      end
      object chkIncludeNumber: TwwCheckBox
        Left = 107
        Top = 233
        Width = 124
        Height = 17
        HelpContext = 544196
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        Caption = 'Include Number'
        TabOrder = 5
        OnClick = chkIncludeNumberClick
      end
      object chkIncludeSpecialChar: TwwCheckBox
        Left = 50
        Top = 261
        Width = 181
        Height = 17
        HelpContext = 544197
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        Caption = 'Include Special Character'
        TabOrder = 6
        OnClick = chkIncludeSpecialCharClick
      end
    end
  end
  inherited popSpelling: TPopupMenu
    Left = 264
  end
  inherited tmrdelayMsg: TTimer
    Left = 0
  end
  object MyConnection: TERPConnection
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    LoginPrompt = False
    Left = 816
    Top = 47
  end
  object dsPrefs: TDataSourcePrefs
    Connection = MyConnection
    FieldDefs = <>
    FieldNames.Strings = (
      'AutoBackup'
      'AutoPurgeAuditTrail'
      'AutoPurgeAuditTrailMonths'
      'BackupAfterRestart'
      'BankAccFormatting'
      'CopyClients'
      'CopyCOA'
      'CopyCompanySettings'
      'CopyDataToNewDB'
      'CopyEmployeeAccess'
      'CopyEmployeeSettings'
      'CopyMarketingContacts'
      'CopyOutstandingTxn'
      'CopyProducts'
      'CustomerABNFormating'
      'DashboardToshow'
      'DataExportDefaultExtension'
      'DefaultEmailSubject'
      'DefaultEmailText'
      'DefaultMailClientPreview'
      'EnableAusEparcel'
      'EnableScheduledreports'
      'EndOfDay'
      'ExporttoReportDBAfterRestart'
      'GenerateEmployeeno'
      'IgnoreTraining'
      'LogchangingDetailsonCashsAleComments'
      'LogchangingDetailsonchequecomments'
      'LogchangingDetailsonchequeInternalcomments'
      'LogchangingDetailsonCustomerfollowupNotes'
      'LogchangingDetailsonCustPayComments'
      'LogchangingDetailsonDepositEntryNotes'
      'LogchangingDetailsonDepositNotes'
      'LogchangingDetailsonServicePadFeedback'
      'LogchangingDetailsonSupplierfollowupNotes'
      'LogchangingDetailsonSupportPricingNotes'
      'LogchangingDetailsonSuppPayNotes'
      'LoginExpireDate'
      'LoginExpireDays'
      'NoofWeekendDays'
      'OpenfileWhenDataExported'
      'PCCPathToVisualConsole'
      'PCCVCAutoStart'
      'PhoneNumberFormatting'
      'POSPrintDescriptionMultipleLines'
      'POSPrintReceiptOnlyOnCompleteSale'
      'PostcodeFormatting'
      'PrimaryPrinter'
      'ShowDashboard'
      'ShowEdiIntegration'
      'ShowToDoNotifications'
      'StartOfDay'
      'StartWorkWeek'
      'UseAuditTrail'
      'UseBudget'
      'UseClockOn'
      'UseCRM'
      'UseDelivery'
      'UseERPFilenameforDataExport'
      'UseFixedAssets'
      'UseGoogleAnalytics'
      'UseHire'
      'UseManufacturing'
      'UsePayroll'
      'UsePriceSchemes'
      'UseWorkFlow'
      'UseWorkShop')
    Left = 560
    Top = 40
  end
  object dsPersonalPreferences: TDataSource
    DataSet = qryPersonalPreferences
    Left = 664
    Top = 56
  end
  object qryPersonalPreferences: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblpersonalpreferences'
      'WHERE EmployeeID = :EmployeeID;')
    Left = 696
    Top = 56
    ParamData = <
      item
        DataType = ftString
        Name = 'EmployeeID'
        Value = ''
      end>
  end
  object qryexporttables: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblexporttables order by TableName')
    AfterPost = qryexporttablesAfterPost
    Left = 696
    Top = 96
  end
  object dsexporttables: TDataSource
    DataSet = qryexporttables
    Left = 664
    Top = 96
  end
end
