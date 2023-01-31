inherited AppointmentsPrefsGUI: TAppointmentsPrefsGUI
  Left = 19
  Top = 142
  HelpContext = 14000
  Caption = 'Appointment Preferences'
  ClientHeight = 861
  ClientWidth = 1084
  ExplicitLeft = 19
  ExplicitTop = 142
  ExplicitWidth = 1100
  ExplicitHeight = 900
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 861
    Width = 1084
    HelpContext = 14074
    ExplicitTop = 691
    ExplicitWidth = 901
  end
  object lblWidth: TLabel [3]
    Left = 16
    Top = 8
    Width = 863
    Height = 22
    HelpContext = 14001
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
    Width = 1084
    Height = 861
    HelpContext = 14080
    VertScrollBar.Position = 234
    ExplicitWidth = 1084
    ExplicitHeight = 861
    object DNMPanel1: TDNMPanel
      Left = 0
      Top = -234
      Width = 1065
      Height = 181
      HelpContext = 14002
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Bevel2: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 167
        HelpContext = 14003
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 165
      end
      object Label1: TLabel
        Left = 14
        Top = 14
        Width = 156
        Height = 15
        HelpContext = 14004
        Caption = 'Telephone Support Defaults'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label2: TLabel
        Left = 24
        Top = 48
        Width = 47
        Height = 15
        HelpContext = 14005
        Caption = 'Period 1'
        Transparent = True
      end
      object Label3: TLabel
        Left = 176
        Top = 48
        Width = 44
        Height = 15
        HelpContext = 14006
        Caption = 'Amount'
        Transparent = True
      end
      object Label4: TLabel
        Left = 24
        Top = 80
        Width = 47
        Height = 15
        HelpContext = 14007
        Caption = 'Period 2'
        Transparent = True
      end
      object Label5: TLabel
        Left = 176
        Top = 80
        Width = 44
        Height = 15
        HelpContext = 14008
        Caption = 'Amount'
        Transparent = True
      end
      object Label6: TLabel
        Left = 24
        Top = 112
        Width = 47
        Height = 15
        HelpContext = 14009
        Caption = 'Period 3'
        Transparent = True
      end
      object Label7: TLabel
        Left = 176
        Top = 112
        Width = 44
        Height = 15
        HelpContext = 14010
        Caption = 'Amount'
        Transparent = True
      end
      object Label8: TLabel
        Left = 24
        Top = 144
        Width = 47
        Height = 15
        HelpContext = 14011
        Caption = 'Period 4'
        Transparent = True
      end
      object Label9: TLabel
        Left = 176
        Top = 144
        Width = 44
        Height = 15
        HelpContext = 14012
        Caption = 'Amount'
        Transparent = True
      end
      object wwDBEdit1: TwwDBEdit
        Left = 80
        Top = 40
        Width = 73
        Height = 23
        HelpContext = 14013
        DataField = 'PhoneSupportPeriodNo1'
        DataSource = dsPhoneSupport
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
      object wwDBEdit2: TwwDBEdit
        Left = 232
        Top = 40
        Width = 73
        Height = 23
        HelpContext = 14014
        DataField = 'PhoneSupportAmountNo1'
        DataSource = dsPhoneSupport
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
      object wwDBEdit3: TwwDBEdit
        Left = 80
        Top = 72
        Width = 73
        Height = 23
        HelpContext = 14015
        DataField = 'PhoneSupportPeriodNo2'
        DataSource = dsPhoneSupport
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit4: TwwDBEdit
        Left = 232
        Top = 72
        Width = 73
        Height = 23
        HelpContext = 14016
        DataField = 'PhoneSupportAmountNo2'
        DataSource = dsPhoneSupport
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit5: TwwDBEdit
        Left = 80
        Top = 104
        Width = 73
        Height = 23
        HelpContext = 14017
        DataField = 'PhoneSupportPeriodNo3'
        DataSource = dsPhoneSupport
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit6: TwwDBEdit
        Left = 232
        Top = 104
        Width = 73
        Height = 23
        HelpContext = 14018
        DataField = 'PhoneSupportAmountNo3'
        DataSource = dsPhoneSupport
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit7: TwwDBEdit
        Left = 80
        Top = 136
        Width = 73
        Height = 23
        HelpContext = 14019
        DataField = 'PhoneSupportPeriodNo4'
        DataSource = dsPhoneSupport
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit8: TwwDBEdit
        Left = 232
        Top = 136
        Width = 73
        Height = 23
        HelpContext = 14020
        DataField = 'PhoneSupportAmountNo4'
        DataSource = dsPhoneSupport
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
    end
    object DNMPanel2: TDNMPanel
      Left = 0
      Top = -53
      Width = 1065
      Height = 197
      HelpContext = 14021
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Bevel1: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 183
        HelpContext = 14022
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 181
      end
      object Label10: TLabel
        Left = 14
        Top = 14
        Width = 44
        Height = 15
        HelpContext = 14023
        Caption = 'General'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label11: TLabel
        Left = 16
        Top = 160
        Width = 192
        Height = 15
        HelpContext = 14058
        Caption = 'Appointment Duration (In Minutes)'
        Transparent = True
      end
      object wwCheckBox2: TwwCheckBox
        Left = 16
        Top = 46
        Width = 333
        Height = 17
        HelpContext = 14027
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
        Caption = 'Cancelled Appointments not printed'
        DataField = 'CancelledAppointmentsNotPrinted'
        DataSource = dsPrefs
        TabOrder = 0
      end
      object wwDBEdit9: TwwDBEdit
        Left = 224
        Top = 156
        Width = 73
        Height = 23
        HelpContext = 14061
        DataField = 'AppointmentDuration'
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
      object wwCheckBox1: TwwCheckBox
        Left = 16
        Top = 84
        Width = 333
        Height = 17
        HelpContext = 14062
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
        Caption = 'Load The Scheduled Times to the Actual Times'
        DataField = 'AutoLoadActualDatetimeFromscheduled'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object wwCheckBox3: TwwCheckBox
        Left = 16
        Top = 122
        Width = 333
        Height = 17
        HelpContext = 14063
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
        Caption = 'Auto Update Actual Date and Time from Schedule  '
        DataField = 'AutoUpdateActual'
        DataSource = dsPrefs
        TabOrder = 3
      end
    end
    object DNMPanel3: TDNMPanel
      Left = 0
      Top = 817
      Width = 1065
      Height = 106
      HelpContext = 14028
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      ExplicitTop = 777
      object Bevel3: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 92
        HelpContext = 14029
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = -40
        ExplicitTop = 75
        ExplicitWidth = 531
      end
      object Label12: TLabel
        Left = 14
        Top = 14
        Width = 102
        Height = 15
        HelpContext = 14031
        Caption = 'Print Appointment'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox4: TwwCheckBox
        Left = 24
        Top = 49
        Width = 266
        Height = 17
        HelpContext = 14039
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
        Caption = 'Print Best Practices'
        Checked = True
        DataField = 'PrintBestPractices'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 0
      end
    end
    object DNMPanel4: TDNMPanel
      Left = 0
      Top = 738
      Width = 1065
      Height = 79
      HelpContext = 14041
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      ExplicitTop = 698
      object Bevel4: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 65
        HelpContext = 14042
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 0
        ExplicitTop = 27
        ExplicitWidth = 531
      end
      object Label13: TLabel
        Left = 14
        Top = 14
        Width = 115
        Height = 15
        HelpContext = 14043
        Caption = 'Invoice Appointment'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox6: TwwCheckBox
        Left = 24
        Top = 40
        Width = 369
        Height = 17
        HelpContext = 14045
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
        Caption = 'Show  Invoice Form when Appointment  is Invoiced'
        Checked = True
        DataField = 'ShowInvoiceFormwhenApptInvoiced'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 0
      end
    end
    object DNMPanel5: TDNMPanel
      Left = 0
      Top = 144
      Width = 1065
      Height = 234
      HelpContext = 14046
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object Bevel5: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 220
        HelpContext = 14047
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 9
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 176
      end
      object Label14: TLabel
        Left = 14
        Top = 14
        Width = 143
        Height = 15
        HelpContext = 14048
        Caption = 'Support Log Preferences'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object lblCallsIn: TLabel
        Left = 80
        Top = 80
        Width = 44
        Height = 15
        HelpContext = 14049
        Caption = 'Calls in '
        Transparent = True
      end
      object lblDaysTrigger: TLabel
        Left = 184
        Top = 80
        Width = 117
        Height = 15
        HelpContext = 14050
        Caption = 'Days Triggers Popup'
        Transparent = True
      end
      object lblPopupMessage: TLabel
        Left = 320
        Top = 21
        Width = 91
        Height = 15
        HelpContext = 14052
        Caption = 'Popup Message'
        Transparent = True
      end
      object Label15: TLabel
        Left = 23
        Top = 195
        Width = 190
        Height = 15
        HelpContext = 14065
        Caption = 'Default Module for Phone Support'
        Transparent = True
      end
      object sdtSupportNumOfCalls: TwwDBSpinEdit
        Left = 24
        Top = 72
        Width = 49
        Height = 23
        HelpContext = 14053
        Increment = 1.000000000000000000
        Value = 4.000000000000000000
        DataField = 'SupportNoOfCalls'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        UnboundDataType = wwDefault
      end
      object sdtSupportPeriodInDays: TwwDBSpinEdit
        Left = 128
        Top = 72
        Width = 49
        Height = 23
        HelpContext = 14054
        Increment = 1.000000000000000000
        Value = 30.000000000000000000
        DataField = 'SupportPeriodInDays'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        UnboundDataType = wwDefault
      end
      object chkSupportPopup: TwwCheckBox
        Left = 24
        Top = 40
        Width = 184
        Height = 17
        HelpContext = 14055
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
        Caption = 'Enable Support Popup'
        Checked = True
        DataField = 'SupportPopupEnabled'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 2
        OnClick = chkSupportPopupClick
      end
      object memoPopupMessage: TDBMemo
        Left = 320
        Top = 37
        Width = 201
        Height = 89
        HelpContext = 14056
        DataField = 'SupportPopupMessage'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object wwCheckBox5: TwwCheckBox
        Left = 24
        Top = 106
        Width = 184
        Height = 17
        HelpContext = 14067
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
        Caption = 'Support All Customers'
        Checked = True
        DataField = 'SupportAllcustomers'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 4
        OnClick = chkSupportPopupClick
      end
      object wwDBLookupCombo1: TwwDBLookupCombo
        Left = 220
        Top = 189
        Width = 301
        Height = 23
        HelpContext = 14057
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'modulename'#9'20'#9'Name'#9'F')
        DataField = 'DefualtModuleNameforPhSupport'
        DataSource = dsPrefs
        LookupTable = qrymodules
        LookupField = 'ModuleName'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 5
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwCheckBox7: TwwCheckBox
        Left = 24
        Top = 135
        Width = 184
        Height = 17
        HelpContext = 14068
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
        Caption = 'Auto Assign to User'
        Checked = True
        DataField = 'SupportAutoAssign'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 6
        OnClick = chkSupportPopupClick
      end
      object chkUseSupportEmail: TwwCheckBox
        Left = 24
        Top = 164
        Width = 184
        Height = 17
        HelpContext = 14076
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
        Caption = 'Use Support Email Account'
        Checked = True
        DataField = 'UseSupportEmail'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 7
        OnClick = chkUseSupportEmailClick
      end
      object btnEmailConfig: TDNMSpeedButton
        Left = 220
        Top = 156
        Width = 87
        Height = 27
        HelpContext = 14077
        Caption = 'Email Config'
        Default = True
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentFont = False
        Style = bsModern
        TabOrder = 8
        AutoDisableParentOnclick = True
        OnClick = btnEmailConfigClick
      end
      object bntEmailTasks: TDNMSpeedButton
        Left = 327
        Top = 156
        Width = 87
        Height = 27
        HelpContext = 14078
        Caption = 'Email Tasks'
        Default = True
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentFont = False
        Style = bsModern
        TabOrder = 9
        AutoDisableParentOnclick = True
        OnClick = bntEmailTasksClick
      end
      object btnEmailGoLive: TDNMSpeedButton
        Left = 434
        Top = 156
        Width = 87
        Height = 27
        HelpContext = 14079
        Caption = 'Email GoLive'
        Default = True
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentFont = False
        Style = bsModern
        TabOrder = 10
        Visible = False
        AutoDisableParentOnclick = True
        OnClick = btnEmailGoLiveClick
      end
    end
    object pnlDefaultApptSettings: TDNMPanel
      Left = 0
      Top = 378
      Width = 1065
      Height = 360
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      DesignSize = (
        1065
        360)
      object Bevel6: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 346
        HelpContext = 121114
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 14
        ExplicitTop = 5
        ExplicitHeight = 251
      end
      object Label16: TLabel
        Left = 127
        Top = 54
        Width = 72
        Height = 15
        HelpContext = 11070
        Caption = 'Show Hours '
        Transparent = True
      end
      object Label17: TLabel
        Left = 33
        Top = 211
        Width = 166
        Height = 15
        HelpContext = 11070
        Caption = 'Default Appointment Duration'
        Transparent = True
      end
      object Label19: TLabel
        Left = 113
        Top = 322
        Width = 86
        Height = 15
        HelpContext = 11070
        Anchors = [akLeft, akBottom]
        Caption = 'Default Service'
        Transparent = True
      end
      object Label20: TLabel
        Left = 14
        Top = 14
        Width = 122
        Height = 15
        HelpContext = 121100
        Caption = 'Appointment Defaults'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label18: TLabel
        Left = 123
        Top = 287
        Width = 76
        Height = 15
        HelpContext = 11070
        Anchors = [akLeft, akBottom]
        Caption = 'Show Time In'
        Transparent = True
      end
      object Start_Time_Label: TLabel
        Left = 211
        Top = 29
        Width = 34
        Height = 16
        HelpContext = 11054
        AutoSize = False
        Caption = 'From'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object End_Time_Label: TLabel
        Left = 343
        Top = 29
        Width = 26
        Height = 17
        HelpContext = 11055
        AutoSize = False
        Caption = 'To'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label21: TLabel
        Left = 66
        Top = 131
        Width = 133
        Height = 15
        HelpContext = 11070
        Caption = 'Weekdays for Available'
        Transparent = True
      end
      object Bevel7: TBevel
        AlignWithMargins = True
        Left = 211
        Top = 82
        Width = 289
        Height = 117
        HelpContext = 121114
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Shape = bsFrame
      end
      object lblRoundApptDurationTo: TLabel
        Left = 67
        Top = 247
        Width = 132
        Height = 15
        HelpContext = 11070
        Caption = 'Round Appt Duration To'
        Transparent = True
      end
      object txtStartTime: TErpDbTimeCombo
        Left = 211
        Top = 51
        Width = 100
        Height = 23
        HelpContext = 11180
        DataField = 'ApptStartTime'
        DataSource = dsPrefs
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Items.Strings = (
          '12:00 AM'
          '12:30 AM'
          '01:00 AM'
          '01:30 AM'
          '02:00 AM'
          '02:30 AM'
          '03:00 AM'
          '03:30 AM'
          '04:00 AM'
          '04:30 AM'
          '05:00 AM'
          '05:30 AM'
          '06:00 AM'
          '06:30 AM'
          '07:00 AM'
          '07:30 AM'
          '08:00 AM'
          '08:30 AM'
          '09:00 AM'
          '09:30 AM'
          '10:00 AM'
          '10:30 AM'
          '11:00 AM'
          '11:30 AM'
          '12:00 PM'
          '12:30 PM'
          '01:00 PM'
          '01:30 PM'
          '02:00 PM'
          '02:30 PM'
          '03:00 PM'
          '03:30 PM'
          '04:00 PM'
          '04:30 PM'
          '05:00 PM'
          '05:30 PM'
          '06:00 PM'
          '06:30 PM'
          '07:00 PM'
          '07:30 PM'
          '08:00 PM'
          '08:30 PM'
          '09:00 PM'
          '09:30 PM'
          '10:00 PM'
          '10:30 PM'
          '11:00 PM'
          '11:30 PM')
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Interval = 30
      end
      object txtEndTime: TErpDbTimeCombo
        Left = 343
        Top = 50
        Width = 100
        Height = 23
        HelpContext = 11181
        DataField = 'ApptEndtime'
        DataSource = dsPrefs
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Items.Strings = (
          '12:00 AM'
          '12:30 AM'
          '01:00 AM'
          '01:30 AM'
          '02:00 AM'
          '02:30 AM'
          '03:00 AM'
          '03:30 AM'
          '04:00 AM'
          '04:30 AM'
          '05:00 AM'
          '05:30 AM'
          '06:00 AM'
          '06:30 AM'
          '07:00 AM'
          '07:30 AM'
          '08:00 AM'
          '08:30 AM'
          '09:00 AM'
          '09:30 AM'
          '10:00 AM'
          '10:30 AM'
          '11:00 AM'
          '11:30 AM'
          '12:00 PM'
          '12:30 PM'
          '01:00 PM'
          '01:30 PM'
          '02:00 PM'
          '02:30 PM'
          '03:00 PM'
          '03:30 PM'
          '04:00 PM'
          '04:30 PM'
          '05:00 PM'
          '05:30 PM'
          '06:00 PM'
          '06:30 PM'
          '07:00 PM'
          '07:30 PM'
          '08:00 PM'
          '08:30 PM'
          '09:00 PM'
          '09:30 PM'
          '10:00 PM'
          '10:30 PM'
          '11:00 PM'
          '11:30 PM')
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Interval = 30
      end
      object cboDefaultApptDuration: TwwDBComboBox
        Left = 211
        Top = 207
        Width = 136
        Height = 23
        ShowButton = True
        Style = csDropDown
        MapList = True
        AllowClearKey = False
        DataField = 'DefaultApptDuration'
        DataSource = dsPrefs
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          '.5 Hour'#9'30')
        ParentFont = False
        Sorted = False
        TabOrder = 2
        UnboundDataType = wwDefault
      end
      object cboShowApptDurationin: TwwDBComboBox
        Left = 211
        Top = 281
        Width = 136
        Height = 23
        Anchors = [akLeft, akBottom]
        ShowButton = True
        Style = csDropDown
        MapList = True
        AllowClearKey = False
        DataField = 'ShowApptDurationin'
        DataSource = dsPrefs
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          '.5 Hour'#9'30')
        ParentFont = False
        Sorted = False
        TabOrder = 3
        UnboundDataType = wwDefault
        ExplicitTop = 241
      end
      object wwDBLookupCombo2: TwwDBLookupCombo
        Left = 211
        Top = 318
        Width = 232
        Height = 23
        Anchors = [akLeft, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'partname'#9'30'#9'Name'#9'F')
        DataField = 'DefaultServiceProductID'
        DataSource = dsPrefs
        LookupTable = QryProduct
        LookupField = 'PartsId'
        ParentFont = False
        TabOrder = 4
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object chkSunday: TwwCheckBox
        Left = 220
        Top = 97
        Width = 87
        Height = 17
        HelpContext = 121198
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
        Caption = 'Sunday'
        DataField = 'ShowSundayinApptCalendar'
        DataSource = dsPrefs
        TabOrder = 5
      end
      object chkWednesday: TwwCheckBox
        Left = 313
        Top = 97
        Width = 87
        Height = 17
        HelpContext = 121198
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
        Caption = 'Wednesday'
        DataField = 'ShowWednesdayinApptCalendar'
        DataSource = dsPrefs
        TabOrder = 6
      end
      object chkSaturday: TwwCheckBox
        Left = 423
        Top = 97
        Width = 75
        Height = 17
        HelpContext = 121198
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
        Caption = 'Saturday'
        DataField = 'ShowSaturdayinApptCalendar'
        DataSource = dsPrefs
        TabOrder = 7
      end
      object chkMonday: TwwCheckBox
        Left = 220
        Top = 130
        Width = 87
        Height = 17
        HelpContext = 121198
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
        Caption = 'Monday'
        DataField = 'ShowMondayinApptCalendar'
        DataSource = dsPrefs
        TabOrder = 8
      end
      object chkThursday: TwwCheckBox
        Left = 313
        Top = 130
        Width = 87
        Height = 17
        HelpContext = 121198
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
        Caption = 'Thursday'
        DataField = 'ShowThursdayinApptCalendar'
        DataSource = dsPrefs
        TabOrder = 9
      end
      object chkTuesday: TwwCheckBox
        Left = 220
        Top = 164
        Width = 87
        Height = 17
        HelpContext = 121198
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
        Caption = 'Tuesday'
        DataField = 'ShowTuesdayinApptCalendar'
        DataSource = dsPrefs
        TabOrder = 10
      end
      object chkFriday: TwwCheckBox
        Left = 313
        Top = 164
        Width = 87
        Height = 17
        HelpContext = 121198
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
        Caption = 'Friday'
        DataField = 'ShowFridayinApptCalendar'
        DataSource = dsPrefs
        TabOrder = 11
      end
      object cboRoundApptDurationTo: TwwDBComboBox
        Left = 211
        Top = 244
        Width = 136
        Height = 23
        ShowButton = True
        Style = csDropDown
        MapList = True
        AllowClearKey = False
        DataField = 'RoundApptDurationTo'
        DataSource = dsPrefs
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          '30 Min'#9'30'
          '1 Hr'#9'60')
        ParentFont = False
        Sorted = False
        TabOrder = 12
        UnboundDataType = wwDefault
      end
    end
  end
  object MyConnection: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Connected = True
    LoginPrompt = False
    Left = 600
    Top = 48
  end
  object dsPrefs: TDataSourcePrefs
    Connection = MyConnection
    FieldDefs = <>
    FieldNames.Strings = (
      'AppointmentDuration'
      'ApptEndtime'
      'ApptStartTime'
      'AutoLoadActualDatetimeFromscheduled'
      'AutoUpdateActual'
      'CancelledAppointmentsNotPrinted'
      'DefaultApptDuration'
      'DefaultServiceProductID'
      'DefualtModuleNameforPhSupport'
      'ExcludeInactiveContactFromMessages'
      'PrintBestPractices'
      'RoundApptDurationTo'
      'ShowApptDurationin'
      'ShowFridayinApptCalendar'
      'ShowInvoiceFormwhenApptInvoiced'
      'ShowMondayinApptCalendar'
      'ShowSaturdayinApptCalendar'
      'ShowSundayinApptCalendar'
      'ShowThursdayinApptCalendar'
      'ShowTuesdayinApptCalendar'
      'ShowWednesdayinApptCalendar'
      'SupportAllcustomers'
      'SupportAutoAssign'
      'SupportNoOfCalls'
      'SupportPeriodInDays'
      'SupportPopupEnabled'
      'SupportPopupMessage'
      'UseSupportEmail')
    Left = 640
    Top = 48
  end
  object qryPhoneSupport: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblphonesupport')
    AfterPost = qryPhoneSupportAfterPost
    Left = 720
    Top = 48
    object qryPhoneSupportPhoneSupportPeriodNo1: TWideStringField
      FieldName = 'PhoneSupportPeriodNo1'
      Origin = 'tblphonesupport.PhoneSupportPeriodNo1'
      Size = 50
    end
    object qryPhoneSupportPhoneSupportAmountNo1: TFloatField
      FieldName = 'PhoneSupportAmountNo1'
      Origin = 'tblphonesupport.PhoneSupportAmountNo1'
      currency = True
    end
    object qryPhoneSupportPhoneSupportPeriodNo2: TWideStringField
      FieldName = 'PhoneSupportPeriodNo2'
      Origin = 'tblphonesupport.PhoneSupportPeriodNo2'
      Size = 50
    end
    object qryPhoneSupportPhoneSupportAmountNo2: TFloatField
      FieldName = 'PhoneSupportAmountNo2'
      Origin = 'tblphonesupport.PhoneSupportAmountNo2'
      currency = True
    end
    object qryPhoneSupportPhoneSupportPeriodNo3: TWideStringField
      FieldName = 'PhoneSupportPeriodNo3'
      Origin = 'tblphonesupport.PhoneSupportPeriodNo3'
      Size = 50
    end
    object qryPhoneSupportPhoneSupportAmountNo3: TFloatField
      FieldName = 'PhoneSupportAmountNo3'
      Origin = 'tblphonesupport.PhoneSupportAmountNo3'
      currency = True
    end
    object qryPhoneSupportPhoneSupportPeriodNo4: TWideStringField
      FieldName = 'PhoneSupportPeriodNo4'
      Origin = 'tblphonesupport.PhoneSupportPeriodNo4'
      Size = 50
    end
    object qryPhoneSupportPhoneSupportAmountNo4: TFloatField
      FieldName = 'PhoneSupportAmountNo4'
      Origin = 'tblphonesupport.PhoneSupportAmountNo4'
      currency = True
    end
  end
  object dsPhoneSupport: TDataSource
    DataSet = qryPhoneSupport
    Left = 680
    Top = 48
  end
  object qrymodules: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select ID,modulename from tblSupportModules '
      'where active = '#39'T'#39
      'order by moduleName')
    Left = 776
    Top = 48
  end
  object QryProduct: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PartsId, partname'
      'FROM tblparts'
      'WHERE active ="T" and parttype ='#39'NONINV'#39
      'order by partname')
    Left = 704
    Top = 568
  end
end
