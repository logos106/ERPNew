inherited EmployeePrefsGUI: TEmployeePrefsGUI
  Left = 608
  Top = 65
  HelpContext = 121000
  Caption = 'Employee Preferences'
  ClientHeight = 857
  ClientWidth = 1086
  ExplicitLeft = 608
  ExplicitTop = 65
  ExplicitWidth = 1102
  ExplicitHeight = 896
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 857
    Width = 1086
    HelpContext = 121112
    ExplicitTop = 594
    ExplicitWidth = 956
  end
  object lblWidth: TLabel [1]
    Left = 15
    Top = 8
    Width = 863
    Height = 22
    HelpContext = 121001
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
    Width = 1086
    Height = 857
    HelpContext = 121176
    VertScrollBar.Position = 2278
    ExplicitWidth = 1086
    ExplicitHeight = 857
    object DNMPanel2: TDNMPanel
      Left = 0
      Top = -2278
      Width = 1067
      Height = 255
      HelpContext = 121031
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Bevel2: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1053
        Height = 241
        HelpContext = 121032
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 11
        ExplicitWidth = 531
      end
      object Label2: TLabel
        Left = 14
        Top = 13
        Width = 200
        Height = 15
        HelpContext = 121033
        Caption = 'Default Employee'#39's List Date Range'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label3: TLabel
        Left = 286
        Top = 30
        Width = 60
        Height = 15
        HelpContext = 121034
        Caption = '# Day Past'
        Transparent = True
      end
      object Label4: TLabel
        Left = 415
        Top = 30
        Width = 88
        Height = 15
        HelpContext = 121035
        Caption = '# Days Forward'
        Transparent = True
      end
      object Label5: TLabel
        Left = 16
        Top = 181
        Width = 241
        Height = 15
        HelpContext = 121177
        Caption = 'Report Table Usage Message in List Forms'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label6: TLabel
        Left = 102
        Top = 60
        Width = 157
        Height = 15
        HelpContext = 121178
        Caption = 'Normal Date Range Reports'
        Transparent = True
      end
      object Label7: TLabel
        Left = 112
        Top = 100
        Width = 147
        Height = 15
        HelpContext = 121179
        Caption = 'Short Date Range Reports'
        Transparent = True
      end
      object Label8: TLabel
        Left = 111
        Top = 141
        Width = 144
        Height = 15
        HelpContext = 121180
        Caption = 'Long Date Range Reports'
        Transparent = True
      end
      object wwDBEdit1: TwwDBEdit
        Left = 286
        Top = 56
        Width = 73
        Height = 23
        HelpContext = 121036
        DataField = 'ListDaysPast'
        DataSource = dsPersonalPreferences
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
        Left = 415
        Top = 56
        Width = 97
        Height = 23
        HelpContext = 121037
        DataField = 'ListDaysFuture'
        DataSource = dsPersonalPreferences
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
      object wwCheckBox9: TwwCheckBox
        Left = 33
        Top = 210
        Width = 464
        Height = 17
        HelpContext = 121028
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
        Caption = 
          'Show a Message in List Forms if the form is Based on Report Tabl' +
          'es'
        DataField = 'ShowReportTablesMsg'
        DataSource = dsPersonalPreferences
        TabOrder = 6
      end
      object wwDBEdit5: TwwDBEdit
        Left = 286
        Top = 96
        Width = 73
        Height = 23
        HelpContext = 121181
        DataField = 'ShortListDaysPast'
        DataSource = dsPersonalPreferences
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
      object wwDBEdit6: TwwDBEdit
        Left = 415
        Top = 96
        Width = 97
        Height = 23
        HelpContext = 121182
        DataField = 'ShortListDaysFuture'
        DataSource = dsPersonalPreferences
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
      object wwDBEdit7: TwwDBEdit
        Left = 286
        Top = 137
        Width = 73
        Height = 23
        HelpContext = 121183
        DataField = 'LongListDaysPast'
        DataSource = dsPersonalPreferences
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
      object wwDBEdit8: TwwDBEdit
        Left = 414
        Top = 137
        Width = 97
        Height = 23
        HelpContext = 121184
        DataField = 'LongListDaysFuture'
        DataSource = dsPersonalPreferences
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
    end
    object DNMPanel3: TDNMPanel
      Left = 0
      Top = 837
      Width = 1067
      Height = 83
      HelpContext = 121038
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      ExplicitTop = 772
      object Bevel3: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1053
        Height = 69
        HelpContext = 121039
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 0
        ExplicitTop = 32
        ExplicitWidth = 529
        ExplicitHeight = 67
      end
      object Label9: TLabel
        Left = 14
        Top = 14
        Width = 91
        Height = 15
        HelpContext = 121040
        Caption = 'Active Windows'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwRadioGroup2: TwwRadioGroup
        Left = 24
        Top = 29
        Width = 345
        Height = 33
        HelpContext = 121041
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 5
        ShowBorder = False
        ShowGroupCaption = False
        ShowFocusRect = False
        Transparent = True
        NoSpacing = True
        Caption = 'Active Windows'
        Columns = 3
        DataField = 'ActiveWindow'
        DataSource = dsPersonalPreferences
        Items.Strings = (
          'Off'
          'Auto-popup'
          'Click on Status')
        TabOrder = 0
        Values.Strings = (
          '0'
          '1'
          '2')
      end
    end
    object DNMPanel4: TDNMPanel
      Left = 0
      Top = -771
      Width = 1067
      Height = 572
      HelpContext = 121042
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Bevel4: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1053
        Height = 558
        HelpContext = 121044
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 5
      end
      object Bevel5: TBevel
        Left = 7
        Top = 40
        Width = 531
        Height = 25
        HelpContext = 121043
        Shape = bsFrame
      end
      object Label10: TLabel
        Left = 14
        Top = 14
        Width = 231
        Height = 15
        HelpContext = 121045
        Caption = 'Days in Advance for Reminder to Appear '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label13: TLabel
        Left = 16
        Top = 45
        Width = 38
        Height = 15
        HelpContext = 121046
        Caption = 'Enable'
        Transparent = True
      end
      object Label14: TLabel
        Left = 304
        Top = 45
        Width = 38
        Height = 15
        HelpContext = 121057
        Caption = 'Enable'
        Transparent = True
      end
      object Label15: TLabel
        Left = 24
        Top = 517
        Width = 234
        Height = 15
        HelpContext = 121063
        Caption = 'Don'#39't show reminders after days overdue'
        Transparent = True
      end
      object cbAppointments: TwwCheckBox
        Left = 24
        Top = 86
        Width = 222
        Height = 17
        HelpContext = 121065
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
        Caption = 'Appointments'
        TabOrder = 0
        OnClick = CheckBoxClick
      end
      object cbCustomer: TwwCheckBox
        Left = 24
        Top = 121
        Width = 222
        Height = 17
        HelpContext = 121066
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
        Caption = 'Customer Loyalty Program'
        TabOrder = 1
        OnClick = CheckBoxClick
      end
      object chkFAInsurance: TwwCheckBox
        Left = 24
        Top = 157
        Width = 222
        Height = 17
        HelpContext = 121067
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
        Caption = 'Fixed Asset Insurances'
        TabOrder = 2
        OnClick = CheckBoxClick
      end
      object chkFAWarranty: TwwCheckBox
        Left = 24
        Top = 193
        Width = 222
        Height = 17
        HelpContext = 121068
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
        Caption = 'Fixed Asset Warranties'
        TabOrder = 3
        OnClick = CheckBoxClick
      end
      object cbMemTrans: TwwCheckBox
        Left = 24
        Top = 265
        Width = 222
        Height = 17
        HelpContext = 121069
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
        Caption = 'Memorised Transaction'
        TabOrder = 5
        OnClick = CheckBoxClick
      end
      object cbContact: TwwCheckBox
        Left = 24
        Top = 301
        Width = 222
        Height = 17
        HelpContext = 121070
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
        Caption = 'Other Contact Loyalty Program'
        TabOrder = 6
        OnClick = CheckBoxClick
      end
      object cbQuotes: TwwCheckBox
        Left = 311
        Top = 121
        Width = 170
        Height = 17
        HelpContext = 121071
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
        Caption = 'Quotes'
        TabOrder = 8
        OnClick = CheckBoxClick
      end
      object cbOtherContacts: TwwCheckBox
        Left = 311
        Top = 86
        Width = 170
        Height = 17
        HelpContext = 121072
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
        Caption = 'Other Prospects'
        TabOrder = 7
        OnClick = CheckBoxClick
      end
      object chkMrktContacts: TwwCheckBox
        Left = 24
        Top = 229
        Width = 222
        Height = 17
        HelpContext = 121075
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
        Caption = 'Marketing Contacts'
        TabOrder = 4
        OnClick = CheckBoxClick
      end
      object edAppointmentsAppearDays: TwwDBEdit
        Left = 233
        Top = 83
        Width = 33
        Height = 23
        HelpContext = 121076
        DataField = 'APPAppearDays'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object cbReceivedBO: TwwCheckBox
        Left = 311
        Top = 157
        Width = 170
        Height = 17
        HelpContext = 121077
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
        Caption = 'Received Back Orders'
        TabOrder = 9
        OnClick = CheckBoxClick
      end
      object cbToDo: TwwCheckBox
        Left = 311
        Top = 229
        Width = 170
        Height = 17
        HelpContext = 121078
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
        Caption = 'To Do'#39's'
        TabOrder = 38
        OnClick = CheckBoxClick
      end
      object cbPendingSOAppearDays: TwwCheckBox
        Left = 24
        Top = 373
        Width = 170
        Height = 17
        HelpContext = 121185
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
        Caption = 'Pending SO'
        TabOrder = 40
        OnClick = CheckBoxClick
      end
      object edCustomerLoyalty: TwwDBEdit
        Left = 233
        Top = 118
        Width = 33
        Height = 23
        HelpContext = 121081
        DataField = 'CustomerLoyaltyAppearDays'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object edInsurance: TwwDBEdit
        Left = 233
        Top = 154
        Width = 33
        Height = 23
        HelpContext = 121082
        DataField = 'FixedAssetInsuranceExpiresAppearDays'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object edWarranty: TwwDBEdit
        Left = 233
        Top = 190
        Width = 33
        Height = 23
        HelpContext = 121083
        DataField = 'FixedAssetWarrantyExpiresAppearDays'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object edMarketingContacts: TwwDBEdit
        Left = 233
        Top = 226
        Width = 33
        Height = 23
        HelpContext = 121084
        DataField = 'MarketingContactsAppearDays'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object edMemTransAppearDays: TwwDBEdit
        Left = 233
        Top = 261
        Width = 33
        Height = 23
        HelpContext = 121085
        DataField = 'MemTransAppearDays'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 16
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object edOCLoyaltyProgram: TwwDBEdit
        Left = 233
        Top = 297
        Width = 33
        Height = 23
        HelpContext = 121086
        DataField = 'ContactLoyaltyAppearDays'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object edOtherContactAppearDays: TwwDBEdit
        Left = 481
        Top = 83
        Width = 33
        Height = 23
        HelpContext = 121087
        DataField = 'OthContactAppearDays'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 19
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object edQuotesAppearDays: TwwDBEdit
        Left = 481
        Top = 118
        Width = 33
        Height = 23
        HelpContext = 121090
        DataField = 'QuoteAppearDays'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 20
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object edtBOAppearDays: TwwDBEdit
        Left = 481
        Top = 154
        Width = 33
        Height = 23
        HelpContext = 121091
        DataField = 'ReceivedBOAppearDays'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 21
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object edToDoAppearDays: TwwDBEdit
        Left = 481
        Top = 226
        Width = 33
        Height = 23
        HelpContext = 121092
        DataField = 'ToDoAppearDays'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 39
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object edPendingSOAppearDays: TwwDBEdit
        Left = 233
        Top = 370
        Width = 33
        Height = 23
        HelpContext = 121186
        DataField = 'PendingSOAppearDays'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 41
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit3: TwwDBEdit
        Left = 261
        Top = 513
        Width = 33
        Height = 23
        HelpContext = 121095
        DataField = 'ReminderHideDays'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 18
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object cbLeads: TwwCheckBox
        Left = 311
        Top = 265
        Width = 170
        Height = 17
        HelpContext = 121096
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
        Caption = 'Leads'
        TabOrder = 10
        OnClick = CheckBoxClick
      end
      object edLeadsAppearDays: TwwDBEdit
        Left = 481
        Top = 262
        Width = 33
        Height = 23
        HelpContext = 121097
        DataField = 'LeadsAppearDays'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 22
        UnboundDataType = wwDefault
        Visible = False
        WantReturns = False
        WordWrap = False
      end
      object cGoodToReceiveReminderDays: TwwCheckBox
        Left = 311
        Top = 193
        Width = 170
        Height = 17
        HelpContext = 121146
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
        Caption = 'Back Orders To Receive'
        TabOrder = 25
        OnClick = CheckBoxClick
      end
      object edGoodToReceiveReminderDays: TwwDBEdit
        Left = 481
        Top = 190
        Width = 33
        Height = 23
        HelpContext = 121147
        DataField = 'GoodToReceiveReminderDays'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 26
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object cbServiceLogAprearDays: TwwCheckBox
        Left = 311
        Top = 301
        Width = 170
        Height = 17
        HelpContext = 121148
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
        Caption = 'Service Log'
        TabOrder = 23
        OnClick = CheckBoxClick
      end
      object edServiceLogAprearDays: TwwDBEdit
        Left = 481
        Top = 298
        Width = 33
        Height = 23
        HelpContext = 121149
        DataField = 'ServiceLogAprearDays'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 24
        UnboundDataType = wwDefault
        Visible = False
        WantReturns = False
        WordWrap = False
      end
      object cbEmployeeRenewal: TwwCheckBox
        Left = 24
        Top = 337
        Width = 222
        Height = 17
        HelpContext = 121150
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
        Caption = 'Employee Skill Renewal'
        TabOrder = 27
        OnClick = CheckBoxClick
      end
      object edEmployeeskill: TwwDBEdit
        Left = 233
        Top = 333
        Width = 33
        Height = 23
        HelpContext = 121151
        DataField = 'EmployeeskillRenewalAppearDays'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 28
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object cbExpenseClaimAppearDays: TwwCheckBox
        Left = 311
        Top = 337
        Width = 170
        Height = 17
        HelpContext = 121121
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
        Caption = 'Expense Claim'
        TabOrder = 29
        OnClick = CheckBoxClick
      end
      object edExpenseClaimAppearDays: TwwDBEdit
        Left = 481
        Top = 334
        Width = 33
        Height = 23
        HelpContext = 121122
        DataField = 'ExpenseClaimAppearDays'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 30
        UnboundDataType = wwDefault
        Visible = False
        WantReturns = False
        WordWrap = False
      end
      object btnDisableAll: TDNMSpeedButton
        Left = 311
        Top = 512
        Width = 91
        Height = 25
        HelpContext = 121154
        Caption = 'Disable  Alll'
        Color = clWhite
        DisableTransparent = False
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentColor = False
        Style = bsModern
        TabOrder = 31
        Visible = False
        AutoDisableParentOnclick = True
        OnClick = btnDisableAllClick
      end
      object btnEnableAll: TDNMSpeedButton
        Left = 415
        Top = 512
        Width = 91
        Height = 25
        HelpContext = 121155
        Caption = 'Enable All'
        Color = clWhite
        DisableTransparent = False
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentColor = False
        Style = bsModern
        TabOrder = 32
        Visible = False
        AutoDisableParentOnclick = True
        OnClick = btnEnableAllClick
      end
      object wwCheckBox3: TwwCheckBox
        Left = 24
        Top = 445
        Width = 261
        Height = 16
        HelpContext = 121165
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
        Caption = 'Show Overdue Sales to Add Surcharge To'
        Color = 14276567
        DataField = 'ShowOverduesalesReminders'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 33
      end
      object wwCheckBox4: TwwCheckBox
        Left = 24
        Top = 481
        Width = 261
        Height = 16
        HelpContext = 121167
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
        Caption = 'Show Finished Progress Build Reminder'
        Color = 14276567
        DataField = 'ShowFinishedProgressBuildReminder'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 34
      end
      object chkShowReorder: TwwCheckBox
        Left = 311
        Top = 481
        Width = 170
        Height = 17
        HelpContext = 121187
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
        Caption = 'Reorder'
        DataField = 'ShowReorder'
        DataSource = dsPersonalPreferences
        TabOrder = 35
        OnClick = CheckBoxClick
      end
      object chkSupportLogLinesAppearDays: TwwCheckBox
        Left = 24
        Top = 409
        Width = 170
        Height = 17
        HelpContext = 121188
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
        Caption = 'Support Log Comments'
        TabOrder = 36
        OnClick = CheckBoxClick
      end
      object edtSupportLogLinesAppearDays: TwwDBEdit
        Left = 233
        Top = 406
        Width = 33
        Height = 23
        HelpContext = 121189
        DataField = 'SupportLogLinesAppearDays'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 37
        UnboundDataType = wwDefault
        Visible = False
        WantReturns = False
        WordWrap = False
      end
      object cbEquipmentServiceAppearDays: TwwCheckBox
        Left = 311
        Top = 373
        Width = 170
        Height = 17
        HelpContext = 121190
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
        Caption = 'Equipment Service'
        TabOrder = 44
        OnClick = CheckBoxClick
      end
      object edEquipmentServiceAppearDays: TwwDBEdit
        Left = 481
        Top = 370
        Width = 33
        Height = 23
        HelpContext = 121191
        DataField = 'EquipmentServiceAppearDays'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 45
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object cbERPLicenseRenewalAppearDays: TwwCheckBox
        Left = 311
        Top = 409
        Width = 170
        Height = 17
        HelpContext = 121192
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
        Caption = 'Expiring ERP Licenses'
        TabOrder = 42
        OnClick = CheckBoxClick
      end
      object edERPLicenseRenewalAppearDays: TwwDBEdit
        Left = 481
        Top = 406
        Width = 33
        Height = 23
        HelpContext = 121193
        DataField = 'ERPLicenseRenewalAppearDays'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 43
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
    end
    object DNMPanel5: TDNMPanel
      Left = 0
      Top = 350
      Width = 1067
      Height = 127
      HelpContext = 121098
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      Visible = False
      object Bevel6: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1053
        Height = 113
        HelpContext = 121099
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 14
        ExplicitTop = 8
        ExplicitWidth = 537
        ExplicitHeight = 105
      end
      object Label16: TLabel
        Left = 14
        Top = 14
        Width = 101
        Height = 15
        HelpContext = 121100
        Caption = 'Popup Reminders'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox10: TwwCheckBox
        Left = 24
        Top = 41
        Width = 333
        Height = 17
        HelpContext = 121104
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
        Caption = 'To Do'#39's'
        DataField = 'PopRemindersToDo'
        DataSource = dsPersonalPreferences
        TabOrder = 0
      end
      object wwCheckBox11: TwwCheckBox
        Left = 24
        Top = 66
        Width = 333
        Height = 17
        HelpContext = 121105
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
        Caption = 'Marketing Follow-ups'
        DataField = 'PopRemindersMFollowup'
        DataSource = dsPersonalPreferences
        TabOrder = 1
      end
      object wwCheckBox12: TwwCheckBox
        Left = 24
        Top = 92
        Width = 333
        Height = 16
        HelpContext = 121153
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
        Caption = 'Messages'
        Color = 14276567
        DataField = 'PopRemindersMessages'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 2
      end
    end
    object DNMPanel6: TDNMPanel
      Left = 0
      Top = 271
      Width = 1067
      Height = 79
      HelpContext = 121107
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      object Label17: TLabel
        Left = 14
        Top = 14
        Width = 133
        Height = 15
        HelpContext = 121109
        Caption = 'Roster / Calendar Clock'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Bevel7: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1053
        Height = 65
        HelpContext = 121114
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 101
      end
      object wwCheckBox13: TwwCheckBox
        Left = 24
        Top = 40
        Width = 209
        Height = 17
        HelpContext = 121111
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
        Caption = 'Display 24 hrs'
        DataField = 'Calender24hr'
        DataSource = dsPersonalPreferences
        TabOrder = 0
      end
    end
    object pnlCyTrackIntegration: TDNMPanel
      Left = 0
      Top = 148
      Width = 1067
      Height = 123
      HelpContext = 121113
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      object Bevel8: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1053
        Height = 109
        HelpContext = 121114
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 101
      end
      object Label11: TLabel
        Left = 14
        Top = 14
        Width = 110
        Height = 15
        HelpContext = 121115
        Caption = 'CyTrack Integration'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object lblCyTRackPort: TLabel
        Left = 26
        Top = 75
        Width = 72
        Height = 15
        HelpContext = 121117
        Caption = 'Port Number'
      end
      object chkCyTrackIntegrationEnabled: TwwCheckBox
        Left = 26
        Top = 41
        Width = 333
        Height = 17
        HelpContext = 121118
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
        Caption = 'CyTrack Integration Enabled'
        DataField = 'CyTrackIntegrationEnabled'
        DataSource = dsPersonalPreferences
        TabOrder = 0
        OnClick = chkCyTrackIntegrationEnabledClick
      end
      object edtCyTrackPort: TDBAdvEdit
        Left = 115
        Top = 72
        Width = 82
        Height = 23
        HelpContext = 121119
        EditType = etNumeric
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = '0'
        Visible = True
        OnChange = edtCyTrackPortChange
        Version = '2.8.6.9'
        DataField = 'CyTrackPortNumber'
        DataSource = dsPersonalPreferences
      end
    end
    object DNMPanel7: TDNMPanel
      Left = 0
      Top = -199
      Width = 1067
      Height = 347
      HelpContext = 121194
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      object Bevel10: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1053
        Height = 333
        HelpContext = 121195
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 6
        ExplicitWidth = 531
        ExplicitHeight = 263
      end
      object Label18: TLabel
        Left = 14
        Top = 14
        Width = 116
        Height = 15
        HelpContext = 121196
        Caption = 'Product List Options'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwRadioGroup1: TwwRadioGroup
        Left = 55
        Top = 81
        Width = 378
        Height = 142
        HelpContext = 121197
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 5
        Transparent = True
        NoSpacing = True
        Caption = 'Default Product List for '#39' Product Options List'#39
        DataField = 'ProductListType'
        DataSource = dsPersonalPreferences
        Items.Strings = (
          'Product Express List (Fast)'
          'Product Qty List (Medium) '
          'Product List (Slow)')
        TabOrder = 0
        Values.Strings = (
          'E'
          'Q'
          'D')
      end
      object wwCheckBox5: TwwCheckBox
        Left = 33
        Top = 48
        Width = 333
        Height = 17
        HelpContext = 121137
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
        Caption = 'Show Choose List Options for '#39' Product Options List'#39
        DataField = 'ShowProductListtypeSelection'
        DataSource = dsPersonalPreferences
        TabOrder = 1
      end
      object wwCheckBox6: TwwCheckBox
        Left = 33
        Top = 240
        Width = 333
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
        Caption = 'Show Choose List Options for '#39'Product Express List'#39
        DataField = 'ShowProductListtypeSelectionforExpress'
        DataSource = dsPersonalPreferences
        TabOrder = 2
      end
      object wwCheckBox7: TwwCheckBox
        Left = 33
        Top = 272
        Width = 333
        Height = 17
        HelpContext = 121199
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
        Caption = 'Show Choose List Options for '#39'Product Quantity List'#39
        DataField = 'ShowProductListtypeSelectionforQtyList'
        DataSource = dsPersonalPreferences
        TabOrder = 3
      end
      object wwCheckBox8: TwwCheckBox
        Left = 33
        Top = 304
        Width = 333
        Height = 17
        HelpContext = 121200
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
        Caption = 'Show Choose List Options for '#39'Product Detail List'#39
        DataField = 'ShowProductListtypeSelectionforDetails'
        DataSource = dsPersonalPreferences
        TabOrder = 4
      end
    end
    object DnmPanel1: TDNMPanel
      Left = 0
      Top = -2023
      Width = 1067
      Height = 887
      HelpContext = 121002
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        1067
        887)
      object Bevel1: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1053
        Height = 735
        HelpContext = 121156
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Align = alTop
        Shape = bsFrame
      end
      object Bevel9: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 748
        Width = 1053
        Height = 132
        HelpContext = 121003
        Margins.Left = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Shape = bsFrame
        ExplicitTop = 647
        ExplicitWidth = 531
      end
      object Bevel11: TBevel
        Left = 342
        Top = 758
        Width = 176
        Height = 107
        HelpContext = 121170
        Anchors = [akLeft, akBottom]
        ExplicitTop = 724
      end
      object Label1: TLabel
        Left = 14
        Top = 14
        Width = 44
        Height = 15
        HelpContext = 121004
        Caption = 'General'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label19: TLabel
        Left = 24
        Top = 232
        Width = 280
        Height = 15
        HelpContext = 121017
        Caption = 'User Default Lists Search Selection Colour ............'
        Transparent = True
      end
      object Label12: TLabel
        Left = 23
        Top = 761
        Width = 226
        Height = 15
        HelpContext = 121132
        Anchors = [akLeft, akBottom]
        Caption = 'Maximum Allowed Discount Percentage'
        Transparent = True
        ExplicitTop = 659
      end
      object Label20: TLabel
        Left = 96
        Top = 802
        Width = 152
        Height = 15
        HelpContext = 121159
        Anchors = [akLeft, akBottom]
        Caption = 'Minimum Required Markup'
        Transparent = True
        ExplicitTop = 700
      end
      object lblexplain: TLabel
        Left = 347
        Top = 766
        Width = 168
        Height = 91
        HelpContext = 121160
        Anchors = [akLeft, akBottom]
        AutoSize = False
        Caption = 
          '"Max Percentage Discount" , "MinimumMarginPercentage" and     "M' +
          'in Required Markup"                         can be Set For the W' +
          'hole Database on the Company Level in the "Sales" page.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        ExplicitTop = 732
      end
      object Label21: TLabel
        Left = 85
        Top = 844
        Width = 163
        Height = 15
        HelpContext = 121171
        Anchors = [akLeft, akBottom]
        Caption = 'Minimum Margin Percentage'
        Transparent = True
        ExplicitTop = 742
      end
      object Label22: TLabel
        Left = 312
        Top = 761
        Width = 9
        Height = 15
        HelpContext = 121172
        Anchors = [akLeft, akBottom]
        Caption = '%'
        Transparent = True
        ExplicitTop = 659
      end
      object Label23: TLabel
        Left = 312
        Top = 802
        Width = 9
        Height = 15
        HelpContext = 121173
        Anchors = [akLeft, akBottom]
        Caption = '%'
        Transparent = True
        ExplicitTop = 700
      end
      object Label24: TLabel
        Left = 312
        Top = 844
        Width = 9
        Height = 15
        HelpContext = 121174
        Anchors = [akLeft, akBottom]
        Caption = '%'
        Transparent = True
        ExplicitTop = 742
      end
      object chkLoadPOSAtLogon: TwwCheckBox
        Left = 24
        Top = 40
        Width = 222
        Height = 17
        HelpContext = 121018
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
        Caption = 'Load POS at Logon'
        DataField = 'POSAutoLoad'
        DataSource = dsPersonalPreferences
        TabOrder = 0
      end
      object chkPayrollAccess: TwwCheckBox
        Left = 274
        Top = 40
        Width = 222
        Height = 17
        HelpContext = 121019
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
        Caption = 'Payroll Access'
        DataField = 'PayrollAccess'
        DataSource = dsPersonalPreferences
        TabOrder = 5
      end
      object chkShowPreview: TwwCheckBox
        Left = 24
        Top = 104
        Width = 222
        Height = 17
        HelpContext = 121021
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
        Caption = 'Show Preview'
        DataField = 'ShowPreview'
        DataSource = dsPersonalPreferences
        TabOrder = 1
      end
      object chkUseClientAccNoOnPayments: TwwCheckBox
        Left = 274
        Top = 136
        Width = 222
        Height = 17
        HelpContext = 121023
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
        Caption = 'Use Client Acc No. on Payments'
        DataField = 'UseClientAccountNoOnPayments'
        DataSource = dsPersonalPreferences
        TabOrder = 3
        Visible = False
      end
      object chkOverrideClassAutoSmartOrders: TwwCheckBox
        Left = 274
        Top = 104
        Width = 222
        Height = 17
        HelpContext = 121024
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
        Caption = 'Override Class Auto Smart Orders'
        DataField = 'OverrideAutoSmartOrders'
        DataSource = dsPersonalPreferences
        TabOrder = 7
        Visible = False
      end
      object chkEnableClassWarning: TwwCheckBox
        Left = 24
        Top = 136
        Width = 222
        Height = 17
        HelpContext = 121026
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
        Caption = 'Enable Class Warning'
        DataField = 'ProductClassWarning'
        DataSource = dsPersonalPreferences
        TabOrder = 2
      end
      object chkEmailPromptForAttachments: TwwCheckBox
        Left = 24
        Top = 200
        Width = 222
        Height = 17
        HelpContext = 121201
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
        Caption = 'Email - Prompt for Attachments'
        DataField = 'ProductClassWarning'
        DataSource = dsPersonalPreferences
        TabOrder = 4
      end
      object btnListSearchColour: TDNMSpeedButton
        Left = 311
        Top = 227
        Width = 130
        Height = 25
        HelpContext = 121030
        Caption = 'Set Colour Default'
        Color = clWhite
        DisableTransparent = False
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentColor = False
        Style = bsModern
        TabOrder = 8
        AutoDisableParentOnclick = True
        OnClick = btnListSearchColourClick
      end
      object chkShowVideoMenu: TwwCheckBox
        Left = 274
        Top = 72
        Width = 222
        Height = 16
        HelpContext = 121133
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
        Caption = 'Show Video Menu at Startup'
        DataField = 'ShowVideoMenuAtStartup'
        DataSource = dsPersonalPreferences
        TabOrder = 6
      end
      object chkManufacturePartSourceStockconfirm: TwwCheckBox
        Left = 24
        Top = 265
        Width = 500
        Height = 17
        HelpContext = 121134
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
        Caption = 
          'Open Product Source Option from Sale. (ie. Stock Or Manufacture.' +
          ')'
        DataField = 'ManufacturePartSourceStockconfirm'
        DataSource = dsPersonalPreferences
        TabOrder = 9
        OnClick = chkManufacturePartSourceStockconfirmClick
      end
      object chkOpenTreeFromSalesOrder: TwwCheckBox
        Left = 24
        Top = 329
        Width = 500
        Height = 17
        HelpContext = 121135
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
        Caption = 'Open Process Tree From Sales Order when Product Selected'
        DataField = 'OpenTreeFromSalesOrder'
        DataSource = dsPersonalPreferences
        TabOrder = 10
        OnClick = chkOpenTreeFromSalesOrderClick
      end
      object chkCapacityplannerSelectionOptionBeforeLoad: TwwCheckBox
        Left = 24
        Top = 361
        Width = 500
        Height = 17
        HelpContext = 121136
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
        Caption = 'Capacity Planner : Show Selection Options '
        DataField = 'CapacityplannerSelectionOptionBeforeLoad'
        DataSource = dsPersonalPreferences
        TabOrder = 11
        OnClick = chkCapacityplannerSelectionOptionBeforeLoadClick
      end
      object chkShowDeliveryDetailsformonDeldocketprint: TwwCheckBox
        Left = 24
        Top = 297
        Width = 500
        Height = 17
        HelpContext = 121202
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
        Caption = 'Open Delivery Details When printing Delivery Docket'
        DataField = 'ShowDeliveryDetailsformonDeldocketprint'
        DataSource = dsPersonalPreferences
        TabOrder = 12
      end
      object chkPrintAddressLabelfromDelPrint: TwwCheckBox
        Left = 24
        Top = 393
        Width = 500
        Height = 17
        HelpContext = 121138
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
        Caption = 
          'Print '#39'Address Labels'#39' When Delivery Docket printed from the '#39'De' +
          'livery Docket Audit'#39
        DataField = 'PrintAddressLabelfromDelPrint'
        DataSource = dsPersonalPreferences
        TabOrder = 13
      end
      object chkShowSalesProductAutoSelectOptions: TwwCheckBox
        Left = 24
        Top = 425
        Width = 500
        Height = 17
        HelpContext = 121139
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
        Caption = 'Sales : Show Product Auto Select Options'
        DataField = 'ShowSalesProductAutoSelectOptions'
        DataSource = dsPersonalPreferences
        TabOrder = 14
      end
      object chkShowManufacutresummarywhenchangedfromSales: TwwCheckBox
        Left = 24
        Top = 457
        Width = 500
        Height = 17
        HelpContext = 121140
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
        Caption = 'Show  '#39'Manufacture Summary'#39' When Tree Created/changed from Sales'
        DataField = 'ShowManufacutresummarywhenchangedfromSales'
        DataSource = dsPersonalPreferences
        TabOrder = 16
      end
      object chkHideMSgonEmployeeCalendar: TwwCheckBox
        Left = 24
        Top = 490
        Width = 500
        Height = 17
        HelpContext = 121141
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
        Caption = 'Don'#39't Show Message when '#39'Service Pad'#39' Opens'
        DataField = 'HideMSgonEmployeeCalendar'
        DataSource = dsPersonalPreferences
        TabOrder = 15
      end
      object edtMaxDiscount: TwwDBEdit
        Left = 255
        Top = 757
        Width = 55
        Height = 23
        HelpContext = 121142
        Anchors = [akLeft, akBottom]
        DataField = 'MaxDiscountPercentage'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwCheckBox1: TwwCheckBox
        Left = 24
        Top = 168
        Width = 222
        Height = 16
        HelpContext = 121106
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
        Caption = 'Show ERP Tips'
        Color = 14276567
        DataField = 'ShowERPTips'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 19
      end
      object chkRunManufacturingUpdateBatch: TwwCheckBox
        Left = 24
        Top = 522
        Width = 500
        Height = 16
        HelpContext = 121161
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
        Caption = 'Run Manufacturing Update Batch?'
        Color = 14276567
        DataField = 'RunManufacturingUpdateBatch'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 18
      end
      object wwCheckBox2: TwwCheckBox
        Left = 24
        Top = 554
        Width = 500
        Height = 16
        HelpContext = 121162
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
        Caption = 'Default Order in Transaction Forms?'
        Color = 14276567
        DataField = 'DefaultOrderinTransForms'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 20
      end
      object wwDBEdit4: TwwDBEdit
        Left = 254
        Top = 841
        Width = 55
        Height = 23
        HelpContext = 121163
        Anchors = [akLeft, akBottom]
        DataField = 'MinimumMarginPercentage'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 23
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object edtMinimumMarginPercentage: TwwDBEdit
        Left = 255
        Top = 798
        Width = 55
        Height = 23
        HelpContext = 121175
        Anchors = [akLeft, akBottom]
        DataField = 'MinMarkupPercentage'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 21
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object chkShowRelatedProductSelectioninSale: TwwCheckBox
        Left = 24
        Top = 586
        Width = 500
        Height = 16
        HelpContext = 121169
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
        Caption = 'Show Related Product Selection in Sale'
        Color = 14276567
        DataField = 'ShowRelatedProductSelectioninSale'
        DataSource = dsPersonalPreferences
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 22
      end
      object chkGenerateEmployeeno: TwwCheckBox
        Left = 24
        Top = 618
        Width = 500
        Height = 20
        HelpContext = 121203
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
        TabOrder = 24
      end
      object chkShowPrintDialog: TwwCheckBox
        Left = 24
        Top = 72
        Width = 222
        Height = 17
        HelpContext = 121022
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
        Caption = 'Show Print Dialog'
        DataField = 'ShowPrintDialog'
        DataSource = dsPersonalPreferences
        TabOrder = 25
      end
      object chkShowGrossWeightnQtyCalcMsg: TwwCheckBox
        Left = 24
        Top = 650
        Width = 464
        Height = 17
        HelpContext = 121204
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
        Caption = 'Show Gross Weight and Quantity Calculation Confirmation Message'
        DataField = 'ShowGrossWeightnQtyCalcMsg'
        DataSource = dsPersonalPreferences
        TabOrder = 27
      end
      object chkUseGradBackground: TwwCheckBox
        Left = 24
        Top = 682
        Width = 464
        Height = 17
        HelpContext = 121205
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
        Caption = 'Use Gradient Background on Forms'
        DataField = 'UseGradBackground'
        DataSource = dsPersonalPreferences
        TabOrder = 28
      end
      object chkCalcnshowAvailaibityinCapacityPlanner: TwwCheckBox
        Left = 24
        Top = 715
        Width = 464
        Height = 17
        HelpContext = 121206
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
        Caption = 'Calculate and show Availaibity in Capacity Planner'
        DataField = 'CalcnshowAvailaibityinCapacityPlanner'
        DataSource = dsPersonalPreferences
        TabOrder = 26
      end
    end
    object DNMPanel8: TDNMPanel
      Left = 0
      Top = -1136
      Width = 1067
      Height = 365
      HelpContext = 121207
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      DesignSize = (
        1067
        365)
      object Bevel12: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 4
        Width = 1053
        Height = 357
        HelpContext = 121208
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitHeight = 328
      end
      object Label25: TLabel
        AlignWithMargins = True
        Left = 14
        Top = 19
        Width = 132
        Height = 15
        HelpContext = 121209
        Margins.Left = 13
        Margins.Top = 16
        Margins.Right = 13
        Margins.Bottom = 5
        Caption = 'List and Button Colours'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object pnlAlternatingRowColor: TPanel
        AlignWithMargins = True
        Left = 23
        Top = 119
        Width = 1030
        Height = 41
        HelpContext = 121210
        Margins.Left = 22
        Margins.Top = 1
        Margins.Right = 13
        Margins.Bottom = 2
        Align = alBottom
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object chkAlternatingRowColor: TwwCheckBox
          Left = 8
          Top = 10
          Width = 222
          Height = 20
          HelpContext = 121211
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
          Caption = 'User Alternate Row Colour in Lists '
          DataField = 'UseAlternatingRowColor'
          DataSource = dsPersonalPreferences
          TabOrder = 0
        end
        object AlternatingRowColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 282
          Top = 9
          Width = 26
          Height = 23
          HelpContext = 121212
          Margins.Left = 233
          AntiAlias = aaAntiAlias
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Version = '1.3.1.1'
          TabOrder = 1
          AllowFloating = False
          CloseOnSelect = True
          CaptionAppearance.BorderColor = clNone
          CaptionAppearance.Color = 13198890
          CaptionAppearance.ColorTo = clNone
          CaptionAppearance.Direction = gdHorizontal
          CaptionAppearance.TextColor = clWhite
          CaptionAppearance.TextColorHot = clBlack
          CaptionAppearance.TextColorDown = clBlack
          CaptionAppearance.ButtonAppearance.ColorChecked = 16111818
          CaptionAppearance.ButtonAppearance.ColorCheckedTo = 16367008
          CaptionAppearance.ButtonAppearance.ColorDisabled = 15921906
          CaptionAppearance.ButtonAppearance.ColorDisabledTo = 15921906
          CaptionAppearance.ButtonAppearance.ColorDown = 16111818
          CaptionAppearance.ButtonAppearance.ColorDownTo = 16367008
          CaptionAppearance.ButtonAppearance.ColorHot = 16117985
          CaptionAppearance.ButtonAppearance.ColorHotTo = 16372402
          CaptionAppearance.ButtonAppearance.ColorMirrorHot = 16107693
          CaptionAppearance.ButtonAppearance.ColorMirrorHotTo = 16775412
          CaptionAppearance.ButtonAppearance.ColorMirrorDown = 16102556
          CaptionAppearance.ButtonAppearance.ColorMirrorDownTo = 16768988
          CaptionAppearance.ButtonAppearance.ColorMirrorChecked = 16102556
          CaptionAppearance.ButtonAppearance.ColorMirrorCheckedTo = 16768988
          CaptionAppearance.ButtonAppearance.ColorMirrorDisabled = 11974326
          CaptionAppearance.ButtonAppearance.ColorMirrorDisabledTo = 15921906
          DragGripAppearance.BorderColor = clGray
          DragGripAppearance.Color = clWhite
          DragGripAppearance.ColorTo = clWhite
          DragGripAppearance.ColorMirror = clSilver
          DragGripAppearance.ColorMirrorTo = clWhite
          DragGripAppearance.Gradient = ggVertical
          DragGripAppearance.GradientMirror = ggVertical
          DragGripAppearance.BorderColorHot = clBlue
          DragGripAppearance.ColorHot = 16117985
          DragGripAppearance.ColorHotTo = 16372402
          DragGripAppearance.ColorMirrorHot = 16107693
          DragGripAppearance.ColorMirrorHotTo = 16775412
          DragGripAppearance.GradientHot = ggRadial
          DragGripAppearance.GradientMirrorHot = ggRadial
          DragGripPosition = gpTop
          Appearance.ColorChecked = 16111818
          Appearance.ColorCheckedTo = 16367008
          Appearance.ColorDisabled = 15921906
          Appearance.ColorDisabledTo = 15921906
          Appearance.ColorDown = 16111818
          Appearance.ColorDownTo = 16367008
          Appearance.ColorHot = 16117985
          Appearance.ColorHotTo = 16372402
          Appearance.ColorMirrorHot = 16107693
          Appearance.ColorMirrorHotTo = 16775412
          Appearance.ColorMirrorDown = 16102556
          Appearance.ColorMirrorDownTo = 16768988
          Appearance.ColorMirrorChecked = 16102556
          Appearance.ColorMirrorCheckedTo = 16768988
          Appearance.ColorMirrorDisabled = 11974326
          Appearance.ColorMirrorDisabledTo = 15921906
          SelectedColor = clNone
          ShowRGBHint = True
          ColorDropDown = 16251129
          ColorDropDownFloating = 16374724
          SelectionAppearance.ColorChecked = 16111818
          SelectionAppearance.ColorCheckedTo = 16367008
          SelectionAppearance.ColorDisabled = 15921906
          SelectionAppearance.ColorDisabledTo = 15921906
          SelectionAppearance.ColorDown = 16111818
          SelectionAppearance.ColorDownTo = 16367008
          SelectionAppearance.ColorHot = 16117985
          SelectionAppearance.ColorHotTo = 16372402
          SelectionAppearance.ColorMirrorHot = 16107693
          SelectionAppearance.ColorMirrorHotTo = 16775412
          SelectionAppearance.ColorMirrorDown = 16102556
          SelectionAppearance.ColorMirrorDownTo = 16768988
          SelectionAppearance.ColorMirrorChecked = 16102556
          SelectionAppearance.ColorMirrorCheckedTo = 16768988
          SelectionAppearance.ColorMirrorDisabled = 11974326
          SelectionAppearance.ColorMirrorDisabledTo = 15921906
          SelectionAppearance.TextColor = clBlack
          SelectionAppearance.TextColorHot = clWhite
          SelectionAppearance.TextColorDown = clWhite
          SelectionAppearance.TextColorChecked = clBlack
          SelectionAppearance.TextColorDisabled = clGray
          SelectionAppearance.Rounded = False
          Tools = <
            item
              BackGroundColor = clBlack
              Caption = 'Automatic'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'Automatic'
              Enable = True
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Colors'
              Enable = True
              ItemType = itFullWidthButton
            end>
          OnSelectColor = AlternatingRowColorSelectorSelectColor
        end
        object AlternatingRowGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 321
          Top = 9
          Width = 160
          Height = 23
          HelpContext = 121213
          Margins.Left = 10
          BorderColor = clBlack
          BorderColorDisabled = clBlack
          Buttons.BorderColor = clBlack
          Buttons.BorderColorHot = 10079963
          Buttons.BorderColorDown = 4548219
          Buttons.Color = 15653832
          Buttons.ColorTo = 16178633
          Buttons.ColorHot = 15465983
          Buttons.ColorHotTo = 11332863
          Buttons.ColorDown = 7778289
          Buttons.ColorDownTo = 4296947
          Buttons.ColorMirror = 15586496
          Buttons.ColorMirrorTo = 16245200
          Buttons.ColorMirrorHot = 5888767
          Buttons.ColorMirrorHotTo = 10807807
          Buttons.ColorMirrorDown = 946929
          Buttons.ColorMirrorDownTo = 5021693
          Buttons.GradientMirror = ggVertical
          ColorTo = clWhite
          ColorDisabled = clWhite
          ColorDisabledTo = clWhite
          Direction = gdHorizontal
          Color = clWhite
          Max = 240
          Slider.BorderColor = 12752500
          Slider.BorderColorDisabled = clBlack
          Slider.Color = clWhite
          Slider.ColorTo = clBlack
          Slider.ColorDisabled = clBlack
          Slider.ColorDisabledTo = clBlack
          Slider.ColorCompleted = clNone
          Slider.ColorCompletedTo = clNone
          Slider.ColorCompletedDisabled = clNone
          Slider.ColorCompletedDisabledTo = clNone
          Slider.Direction = gdHorizontal
          TabOrder = 2
          Thumb.BorderColor = 10317632
          Thumb.BorderColorHot = 10079963
          Thumb.BorderColorDown = 4548219
          Thumb.BorderColorDisabled = clBlack
          Thumb.Color = 15653832
          Thumb.ColorTo = 16178633
          Thumb.ColorDown = 7778289
          Thumb.ColorDownTo = 4296947
          Thumb.ColorHot = 15465983
          Thumb.ColorHotTo = 11332863
          Thumb.ColorDisabled = clBlack
          Thumb.ColorDisabledTo = clBlack
          Thumb.ColorMirror = 15586496
          Thumb.ColorMirrorTo = 16245200
          Thumb.ColorMirrorHot = 5888767
          Thumb.ColorMirrorHotTo = 10807807
          Thumb.ColorMirrorDown = 946929
          Thumb.ColorMirrorDownTo = 5021693
          Thumb.ColorMirrorDisabled = clBlack
          Thumb.ColorMirrorDisabledTo = clBlack
          Thumb.Gradient = ggVertical
          Thumb.GradientMirror = ggRadial
          Thumb.Shape = tsPointer
          TickMark.Color = clWhite
          TickMark.ColorDisabled = clWhite
          TickMark.Font.Charset = DEFAULT_CHARSET
          TickMark.Font.Color = clWindowText
          TickMark.Font.Height = -11
          TickMark.Font.Name = 'Tahoma'
          TickMark.Font.Style = []
          TickMark.Line3D = True
          TickMark.ShowImageAtSteps = 15
          TickMark.Spacing = 10
          TickMark.Size = 10
          TrackHint = True
          TrackLabel.Font.Charset = DEFAULT_CHARSET
          TrackLabel.Font.Color = clWindowText
          TrackLabel.Font.Height = -11
          TrackLabel.Font.Name = 'Tahoma'
          TrackLabel.Font.Style = []
          TrackLabel.Format = 'Pos: %d'
          Transparent = False
          Version = '1.6.2.0'
          OnChange = AlternatingRowGradIntensityChange
        end
      end
      object pnlERPSingleColor: TPanel
        AlignWithMargins = True
        Left = 23
        Top = 76
        Width = 1030
        Height = 41
        HelpContext = 121214
        Margins.Left = 22
        Margins.Top = 1
        Margins.Right = 13
        Margins.Bottom = 1
        Align = alBottom
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object chkERPSingleColor: TwwCheckBox
          Left = 8
          Top = 10
          Width = 254
          Height = 20
          HelpContext = 121215
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
          Caption = 'Use Single Base Colour for All ERP Forms'
          DataField = 'UseERPSingleColor'
          DataSource = dsPersonalPreferences
          TabOrder = 0
        end
        object ERPSingleColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 282
          Top = 9
          Width = 26
          Height = 23
          HelpContext = 121216
          Margins.Left = 233
          AntiAlias = aaAntiAlias
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Version = '1.3.1.1'
          TabOrder = 1
          AllowFloating = False
          CloseOnSelect = True
          CaptionAppearance.BorderColor = clNone
          CaptionAppearance.Color = 13198890
          CaptionAppearance.ColorTo = clNone
          CaptionAppearance.Direction = gdHorizontal
          CaptionAppearance.TextColor = clWhite
          CaptionAppearance.TextColorHot = clBlack
          CaptionAppearance.TextColorDown = clBlack
          CaptionAppearance.ButtonAppearance.ColorChecked = 16111818
          CaptionAppearance.ButtonAppearance.ColorCheckedTo = 16367008
          CaptionAppearance.ButtonAppearance.ColorDisabled = 15921906
          CaptionAppearance.ButtonAppearance.ColorDisabledTo = 15921906
          CaptionAppearance.ButtonAppearance.ColorDown = 16111818
          CaptionAppearance.ButtonAppearance.ColorDownTo = 16367008
          CaptionAppearance.ButtonAppearance.ColorHot = 16117985
          CaptionAppearance.ButtonAppearance.ColorHotTo = 16372402
          CaptionAppearance.ButtonAppearance.ColorMirrorHot = 16107693
          CaptionAppearance.ButtonAppearance.ColorMirrorHotTo = 16775412
          CaptionAppearance.ButtonAppearance.ColorMirrorDown = 16102556
          CaptionAppearance.ButtonAppearance.ColorMirrorDownTo = 16768988
          CaptionAppearance.ButtonAppearance.ColorMirrorChecked = 16102556
          CaptionAppearance.ButtonAppearance.ColorMirrorCheckedTo = 16768988
          CaptionAppearance.ButtonAppearance.ColorMirrorDisabled = 11974326
          CaptionAppearance.ButtonAppearance.ColorMirrorDisabledTo = 15921906
          DragGripAppearance.BorderColor = clGray
          DragGripAppearance.Color = clWhite
          DragGripAppearance.ColorTo = clWhite
          DragGripAppearance.ColorMirror = clSilver
          DragGripAppearance.ColorMirrorTo = clWhite
          DragGripAppearance.Gradient = ggVertical
          DragGripAppearance.GradientMirror = ggVertical
          DragGripAppearance.BorderColorHot = clBlue
          DragGripAppearance.ColorHot = 16117985
          DragGripAppearance.ColorHotTo = 16372402
          DragGripAppearance.ColorMirrorHot = 16107693
          DragGripAppearance.ColorMirrorHotTo = 16775412
          DragGripAppearance.GradientHot = ggRadial
          DragGripAppearance.GradientMirrorHot = ggRadial
          DragGripPosition = gpTop
          Appearance.ColorChecked = 16111818
          Appearance.ColorCheckedTo = 16367008
          Appearance.ColorDisabled = 15921906
          Appearance.ColorDisabledTo = 15921906
          Appearance.ColorDown = 16111818
          Appearance.ColorDownTo = 16367008
          Appearance.ColorHot = 16117985
          Appearance.ColorHotTo = 16372402
          Appearance.ColorMirrorHot = 16107693
          Appearance.ColorMirrorHotTo = 16775412
          Appearance.ColorMirrorDown = 16102556
          Appearance.ColorMirrorDownTo = 16768988
          Appearance.ColorMirrorChecked = 16102556
          Appearance.ColorMirrorCheckedTo = 16768988
          Appearance.ColorMirrorDisabled = 11974326
          Appearance.ColorMirrorDisabledTo = 15921906
          SelectedColor = clNone
          ShowRGBHint = True
          ColorDropDown = 16251129
          ColorDropDownFloating = 16374724
          SelectionAppearance.ColorChecked = 16111818
          SelectionAppearance.ColorCheckedTo = 16367008
          SelectionAppearance.ColorDisabled = 15921906
          SelectionAppearance.ColorDisabledTo = 15921906
          SelectionAppearance.ColorDown = 16111818
          SelectionAppearance.ColorDownTo = 16367008
          SelectionAppearance.ColorHot = 16117985
          SelectionAppearance.ColorHotTo = 16372402
          SelectionAppearance.ColorMirrorHot = 16107693
          SelectionAppearance.ColorMirrorHotTo = 16775412
          SelectionAppearance.ColorMirrorDown = 16102556
          SelectionAppearance.ColorMirrorDownTo = 16768988
          SelectionAppearance.ColorMirrorChecked = 16102556
          SelectionAppearance.ColorMirrorCheckedTo = 16768988
          SelectionAppearance.ColorMirrorDisabled = 11974326
          SelectionAppearance.ColorMirrorDisabledTo = 15921906
          SelectionAppearance.TextColor = clBlack
          SelectionAppearance.TextColorHot = clWhite
          SelectionAppearance.TextColorDown = clWhite
          SelectionAppearance.TextColorChecked = clBlack
          SelectionAppearance.TextColorDisabled = clGray
          SelectionAppearance.Rounded = False
          Tools = <
            item
              BackGroundColor = clBlack
              Caption = 'Automatic'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'Automatic'
              Enable = True
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Colors'
              Enable = True
              ItemType = itFullWidthButton
            end>
          OnSelectColor = ERPSingleColorSelectorSelectColor
        end
        object ERPSingleGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 321
          Top = 9
          Width = 160
          Height = 23
          HelpContext = 121217
          Margins.Left = 10
          BorderColor = clBlack
          BorderColorDisabled = clBlack
          Buttons.BorderColor = clBlack
          Buttons.BorderColorHot = 10079963
          Buttons.BorderColorDown = 4548219
          Buttons.Color = 15653832
          Buttons.ColorTo = 16178633
          Buttons.ColorHot = 15465983
          Buttons.ColorHotTo = 11332863
          Buttons.ColorDown = 7778289
          Buttons.ColorDownTo = 4296947
          Buttons.ColorMirror = 15586496
          Buttons.ColorMirrorTo = 16245200
          Buttons.ColorMirrorHot = 5888767
          Buttons.ColorMirrorHotTo = 10807807
          Buttons.ColorMirrorDown = 946929
          Buttons.ColorMirrorDownTo = 5021693
          Buttons.GradientMirror = ggVertical
          ColorTo = clWhite
          ColorDisabled = clWhite
          ColorDisabledTo = clWhite
          Direction = gdHorizontal
          Color = clWhite
          Max = 240
          Slider.BorderColor = 12752500
          Slider.BorderColorDisabled = clBlack
          Slider.Color = clWhite
          Slider.ColorTo = clBlack
          Slider.ColorDisabled = clBlack
          Slider.ColorDisabledTo = clBlack
          Slider.ColorCompleted = clNone
          Slider.ColorCompletedTo = clNone
          Slider.ColorCompletedDisabled = clNone
          Slider.ColorCompletedDisabledTo = clNone
          Slider.Direction = gdHorizontal
          TabOrder = 2
          Thumb.BorderColor = 10317632
          Thumb.BorderColorHot = 10079963
          Thumb.BorderColorDown = 4548219
          Thumb.BorderColorDisabled = clBlack
          Thumb.Color = 15653832
          Thumb.ColorTo = 16178633
          Thumb.ColorDown = 7778289
          Thumb.ColorDownTo = 4296947
          Thumb.ColorHot = 15465983
          Thumb.ColorHotTo = 11332863
          Thumb.ColorDisabled = clBlack
          Thumb.ColorDisabledTo = clBlack
          Thumb.ColorMirror = 15586496
          Thumb.ColorMirrorTo = 16245200
          Thumb.ColorMirrorHot = 5888767
          Thumb.ColorMirrorHotTo = 10807807
          Thumb.ColorMirrorDown = 946929
          Thumb.ColorMirrorDownTo = 5021693
          Thumb.ColorMirrorDisabled = clBlack
          Thumb.ColorMirrorDisabledTo = clBlack
          Thumb.Gradient = ggVertical
          Thumb.GradientMirror = ggRadial
          Thumb.Shape = tsPointer
          TickMark.Color = clWhite
          TickMark.ColorDisabled = clWhite
          TickMark.Font.Charset = DEFAULT_CHARSET
          TickMark.Font.Color = clWindowText
          TickMark.Font.Height = -11
          TickMark.Font.Name = 'Tahoma'
          TickMark.Font.Style = []
          TickMark.Line3D = True
          TickMark.ShowImageAtSteps = 15
          TickMark.Spacing = 10
          TickMark.Size = 10
          TrackHint = True
          TrackLabel.Font.Charset = DEFAULT_CHARSET
          TrackLabel.Font.Color = clWindowText
          TrackLabel.Font.Height = -11
          TrackLabel.Font.Name = 'Tahoma'
          TrackLabel.Font.Style = []
          TrackLabel.Format = 'Pos: %d'
          Transparent = False
          Version = '1.6.2.0'
          OnChange = ERPSingleGradIntensityChange
        end
      end
      object pnlERPButtonColor: TPanel
        AlignWithMargins = True
        Left = 23
        Top = 164
        Width = 1030
        Height = 190
        HelpContext = 121218
        Margins.Left = 22
        Margins.Top = 2
        Margins.Right = 13
        Margins.Bottom = 10
        Align = alBottom
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 2
        DesignSize = (
          1030
          190)
        object chkERPButtonColor: TwwCheckBox
          Left = 8
          Top = 10
          Width = 248
          Height = 20
          HelpContext = 121219
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
          Caption = 'Change Colour of ERP Buttons'
          DataField = 'UseERPButtonColor'
          DataSource = dsPersonalPreferences
          TabOrder = 0
        end
        object DNMPanel9: TDNMPanel
          AlignWithMargins = True
          Left = 0
          Top = 34
          Width = 1030
          Height = 41
          HelpContext = 121220
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alBottom
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object Label26: TLabel
            Left = 122
            Top = 13
            Width = 149
            Height = 15
            HelpContext = 121221
            Alignment = taRightJustify
            Caption = 'Button Background Colour'
            Transparent = True
          end
          object ERPButtonColorSelector: TAdvOfficeColorSelector
            AlignWithMargins = True
            Left = 282
            Top = 9
            Width = 26
            Height = 23
            HelpContext = 121222
            Margins.Left = 233
            AntiAlias = aaAntiAlias
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            Version = '1.3.1.1'
            TabOrder = 0
            AllowFloating = False
            CloseOnSelect = True
            CaptionAppearance.BorderColor = clNone
            CaptionAppearance.Color = 13198890
            CaptionAppearance.ColorTo = clNone
            CaptionAppearance.Direction = gdHorizontal
            CaptionAppearance.TextColor = clWhite
            CaptionAppearance.TextColorHot = clBlack
            CaptionAppearance.TextColorDown = clBlack
            CaptionAppearance.ButtonAppearance.ColorChecked = 16111818
            CaptionAppearance.ButtonAppearance.ColorCheckedTo = 16367008
            CaptionAppearance.ButtonAppearance.ColorDisabled = 15921906
            CaptionAppearance.ButtonAppearance.ColorDisabledTo = 15921906
            CaptionAppearance.ButtonAppearance.ColorDown = 16111818
            CaptionAppearance.ButtonAppearance.ColorDownTo = 16367008
            CaptionAppearance.ButtonAppearance.ColorHot = 16117985
            CaptionAppearance.ButtonAppearance.ColorHotTo = 16372402
            CaptionAppearance.ButtonAppearance.ColorMirrorHot = 16107693
            CaptionAppearance.ButtonAppearance.ColorMirrorHotTo = 16775412
            CaptionAppearance.ButtonAppearance.ColorMirrorDown = 16102556
            CaptionAppearance.ButtonAppearance.ColorMirrorDownTo = 16768988
            CaptionAppearance.ButtonAppearance.ColorMirrorChecked = 16102556
            CaptionAppearance.ButtonAppearance.ColorMirrorCheckedTo = 16768988
            CaptionAppearance.ButtonAppearance.ColorMirrorDisabled = 11974326
            CaptionAppearance.ButtonAppearance.ColorMirrorDisabledTo = 15921906
            DragGripAppearance.BorderColor = clGray
            DragGripAppearance.Color = clWhite
            DragGripAppearance.ColorTo = clWhite
            DragGripAppearance.ColorMirror = clSilver
            DragGripAppearance.ColorMirrorTo = clWhite
            DragGripAppearance.Gradient = ggVertical
            DragGripAppearance.GradientMirror = ggVertical
            DragGripAppearance.BorderColorHot = clBlue
            DragGripAppearance.ColorHot = 16117985
            DragGripAppearance.ColorHotTo = 16372402
            DragGripAppearance.ColorMirrorHot = 16107693
            DragGripAppearance.ColorMirrorHotTo = 16775412
            DragGripAppearance.GradientHot = ggRadial
            DragGripAppearance.GradientMirrorHot = ggRadial
            DragGripPosition = gpTop
            Appearance.ColorChecked = 16111818
            Appearance.ColorCheckedTo = 16367008
            Appearance.ColorDisabled = 15921906
            Appearance.ColorDisabledTo = 15921906
            Appearance.ColorDown = 16111818
            Appearance.ColorDownTo = 16367008
            Appearance.ColorHot = 16117985
            Appearance.ColorHotTo = 16372402
            Appearance.ColorMirrorHot = 16107693
            Appearance.ColorMirrorHotTo = 16775412
            Appearance.ColorMirrorDown = 16102556
            Appearance.ColorMirrorDownTo = 16768988
            Appearance.ColorMirrorChecked = 16102556
            Appearance.ColorMirrorCheckedTo = 16768988
            Appearance.ColorMirrorDisabled = 11974326
            Appearance.ColorMirrorDisabledTo = 15921906
            SelectedColor = clNone
            ShowRGBHint = True
            ColorDropDown = 16251129
            ColorDropDownFloating = 16374724
            SelectionAppearance.ColorChecked = 16111818
            SelectionAppearance.ColorCheckedTo = 16367008
            SelectionAppearance.ColorDisabled = 15921906
            SelectionAppearance.ColorDisabledTo = 15921906
            SelectionAppearance.ColorDown = 16111818
            SelectionAppearance.ColorDownTo = 16367008
            SelectionAppearance.ColorHot = 16117985
            SelectionAppearance.ColorHotTo = 16372402
            SelectionAppearance.ColorMirrorHot = 16107693
            SelectionAppearance.ColorMirrorHotTo = 16775412
            SelectionAppearance.ColorMirrorDown = 16102556
            SelectionAppearance.ColorMirrorDownTo = 16768988
            SelectionAppearance.ColorMirrorChecked = 16102556
            SelectionAppearance.ColorMirrorCheckedTo = 16768988
            SelectionAppearance.ColorMirrorDisabled = 11974326
            SelectionAppearance.ColorMirrorDisabledTo = 15921906
            SelectionAppearance.TextColor = clBlack
            SelectionAppearance.TextColorHot = clWhite
            SelectionAppearance.TextColorDown = clWhite
            SelectionAppearance.TextColorChecked = clBlack
            SelectionAppearance.TextColorDisabled = clGray
            SelectionAppearance.Rounded = False
            Tools = <
              item
                BackGroundColor = clBlack
                Caption = 'Automatic'
                CaptionAlignment = taCenter
                ImageIndex = -1
                Hint = 'Automatic'
                Enable = True
                ItemType = itFullWidthButton
              end
              item
                BackGroundColor = clBlack
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 13209
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 13107
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 13056
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 6697728
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clNavy
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 3486515
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 3355443
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clMaroon
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 26367
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clOlive
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clGreen
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clTeal
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clBlue
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 10053222
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clGray
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clRed
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 39423
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 52377
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 6723891
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 13421619
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 16737843
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clPurple
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 10066329
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clFuchsia
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 52479
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clYellow
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clLime
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clAqua
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 16763904
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 6697881
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clSilver
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 13408767
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 10079487
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 10092543
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 13434828
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 16777164
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 16764057
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 16751052
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clWhite
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                Caption = 'More Colors...'
                CaptionAlignment = taCenter
                ImageIndex = -1
                Hint = 'More Colors'
                Enable = True
                ItemType = itFullWidthButton
              end>
            OnSelectColor = ERPButtonColorSelectorSelectColor
          end
          object ERPButtonGradIntensity: TAdvTrackBar
            AlignWithMargins = True
            Left = 321
            Top = 9
            Width = 160
            Height = 23
            HelpContext = 121223
            Margins.Left = 10
            BorderColor = clBlack
            BorderColorDisabled = clBlack
            Buttons.BorderColor = clBlack
            Buttons.BorderColorHot = 10079963
            Buttons.BorderColorDown = 4548219
            Buttons.Color = 15653832
            Buttons.ColorTo = 16178633
            Buttons.ColorHot = 15465983
            Buttons.ColorHotTo = 11332863
            Buttons.ColorDown = 7778289
            Buttons.ColorDownTo = 4296947
            Buttons.ColorMirror = 15586496
            Buttons.ColorMirrorTo = 16245200
            Buttons.ColorMirrorHot = 5888767
            Buttons.ColorMirrorHotTo = 10807807
            Buttons.ColorMirrorDown = 946929
            Buttons.ColorMirrorDownTo = 5021693
            Buttons.GradientMirror = ggVertical
            ColorTo = clWhite
            ColorDisabled = clWhite
            ColorDisabledTo = clWhite
            Direction = gdHorizontal
            Color = clWhite
            Max = 240
            Slider.BorderColor = 12752500
            Slider.BorderColorDisabled = clBlack
            Slider.Color = clWhite
            Slider.ColorTo = clBlack
            Slider.ColorDisabled = clBlack
            Slider.ColorDisabledTo = clBlack
            Slider.ColorCompleted = clNone
            Slider.ColorCompletedTo = clNone
            Slider.ColorCompletedDisabled = clNone
            Slider.ColorCompletedDisabledTo = clNone
            Slider.Direction = gdHorizontal
            TabOrder = 1
            Thumb.BorderColor = 10317632
            Thumb.BorderColorHot = 10079963
            Thumb.BorderColorDown = 4548219
            Thumb.BorderColorDisabled = clBlack
            Thumb.Color = 15653832
            Thumb.ColorTo = 16178633
            Thumb.ColorDown = 7778289
            Thumb.ColorDownTo = 4296947
            Thumb.ColorHot = 15465983
            Thumb.ColorHotTo = 11332863
            Thumb.ColorDisabled = clBlack
            Thumb.ColorDisabledTo = clBlack
            Thumb.ColorMirror = 15586496
            Thumb.ColorMirrorTo = 16245200
            Thumb.ColorMirrorHot = 5888767
            Thumb.ColorMirrorHotTo = 10807807
            Thumb.ColorMirrorDown = 946929
            Thumb.ColorMirrorDownTo = 5021693
            Thumb.ColorMirrorDisabled = clBlack
            Thumb.ColorMirrorDisabledTo = clBlack
            Thumb.Gradient = ggVertical
            Thumb.GradientMirror = ggRadial
            Thumb.Shape = tsPointer
            TickMark.Color = clWhite
            TickMark.ColorDisabled = clWhite
            TickMark.Font.Charset = DEFAULT_CHARSET
            TickMark.Font.Color = clWindowText
            TickMark.Font.Height = -11
            TickMark.Font.Name = 'Tahoma'
            TickMark.Font.Style = []
            TickMark.Line3D = True
            TickMark.ShowImageAtSteps = 15
            TickMark.Spacing = 10
            TickMark.Size = 10
            TrackHint = True
            TrackLabel.Font.Charset = DEFAULT_CHARSET
            TrackLabel.Font.Color = clWindowText
            TrackLabel.Font.Height = -11
            TrackLabel.Font.Name = 'Tahoma'
            TrackLabel.Font.Style = []
            TrackLabel.Format = 'Pos: %d'
            Transparent = False
            Version = '1.6.2.0'
            OnChange = ERPButtonGradIntensityChange
          end
        end
        object pnlERPButtonFontColor: TPanel
          AlignWithMargins = True
          Left = 0
          Top = 75
          Width = 1030
          Height = 41
          HelpContext = 121224
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alBottom
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 2
          DesignSize = (
            1030
            41)
          object Label27: TLabel
            Left = 167
            Top = 13
            Width = 104
            Height = 15
            HelpContext = 121225
            Alignment = taRightJustify
            Anchors = [akLeft, akBottom]
            Caption = 'Button Font Colour'
            Transparent = True
          end
          object ERPButtonFontColorSelector: TAdvOfficeColorSelector
            AlignWithMargins = True
            Left = 282
            Top = 9
            Width = 26
            Height = 23
            HelpContext = 121226
            Margins.Left = 233
            AntiAlias = aaAntiAlias
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            Version = '1.3.1.1'
            TabOrder = 0
            AllowFloating = False
            CloseOnSelect = True
            CaptionAppearance.BorderColor = clNone
            CaptionAppearance.Color = 13198890
            CaptionAppearance.ColorTo = clNone
            CaptionAppearance.Direction = gdHorizontal
            CaptionAppearance.TextColor = clWhite
            CaptionAppearance.TextColorHot = clBlack
            CaptionAppearance.TextColorDown = clBlack
            CaptionAppearance.ButtonAppearance.ColorChecked = 16111818
            CaptionAppearance.ButtonAppearance.ColorCheckedTo = 16367008
            CaptionAppearance.ButtonAppearance.ColorDisabled = 15921906
            CaptionAppearance.ButtonAppearance.ColorDisabledTo = 15921906
            CaptionAppearance.ButtonAppearance.ColorDown = 16111818
            CaptionAppearance.ButtonAppearance.ColorDownTo = 16367008
            CaptionAppearance.ButtonAppearance.ColorHot = 16117985
            CaptionAppearance.ButtonAppearance.ColorHotTo = 16372402
            CaptionAppearance.ButtonAppearance.ColorMirrorHot = 16107693
            CaptionAppearance.ButtonAppearance.ColorMirrorHotTo = 16775412
            CaptionAppearance.ButtonAppearance.ColorMirrorDown = 16102556
            CaptionAppearance.ButtonAppearance.ColorMirrorDownTo = 16768988
            CaptionAppearance.ButtonAppearance.ColorMirrorChecked = 16102556
            CaptionAppearance.ButtonAppearance.ColorMirrorCheckedTo = 16768988
            CaptionAppearance.ButtonAppearance.ColorMirrorDisabled = 11974326
            CaptionAppearance.ButtonAppearance.ColorMirrorDisabledTo = 15921906
            DragGripAppearance.BorderColor = clGray
            DragGripAppearance.Color = clWhite
            DragGripAppearance.ColorTo = clWhite
            DragGripAppearance.ColorMirror = clSilver
            DragGripAppearance.ColorMirrorTo = clWhite
            DragGripAppearance.Gradient = ggVertical
            DragGripAppearance.GradientMirror = ggVertical
            DragGripAppearance.BorderColorHot = clBlue
            DragGripAppearance.ColorHot = 16117985
            DragGripAppearance.ColorHotTo = 16372402
            DragGripAppearance.ColorMirrorHot = 16107693
            DragGripAppearance.ColorMirrorHotTo = 16775412
            DragGripAppearance.GradientHot = ggRadial
            DragGripAppearance.GradientMirrorHot = ggRadial
            DragGripPosition = gpTop
            Appearance.ColorChecked = 16111818
            Appearance.ColorCheckedTo = 16367008
            Appearance.ColorDisabled = 15921906
            Appearance.ColorDisabledTo = 15921906
            Appearance.ColorDown = 16111818
            Appearance.ColorDownTo = 16367008
            Appearance.ColorHot = 16117985
            Appearance.ColorHotTo = 16372402
            Appearance.ColorMirrorHot = 16107693
            Appearance.ColorMirrorHotTo = 16775412
            Appearance.ColorMirrorDown = 16102556
            Appearance.ColorMirrorDownTo = 16768988
            Appearance.ColorMirrorChecked = 16102556
            Appearance.ColorMirrorCheckedTo = 16768988
            Appearance.ColorMirrorDisabled = 11974326
            Appearance.ColorMirrorDisabledTo = 15921906
            SelectedColor = clNone
            ShowRGBHint = True
            ColorDropDown = 16251129
            ColorDropDownFloating = 16374724
            SelectionAppearance.ColorChecked = 16111818
            SelectionAppearance.ColorCheckedTo = 16367008
            SelectionAppearance.ColorDisabled = 15921906
            SelectionAppearance.ColorDisabledTo = 15921906
            SelectionAppearance.ColorDown = 16111818
            SelectionAppearance.ColorDownTo = 16367008
            SelectionAppearance.ColorHot = 16117985
            SelectionAppearance.ColorHotTo = 16372402
            SelectionAppearance.ColorMirrorHot = 16107693
            SelectionAppearance.ColorMirrorHotTo = 16775412
            SelectionAppearance.ColorMirrorDown = 16102556
            SelectionAppearance.ColorMirrorDownTo = 16768988
            SelectionAppearance.ColorMirrorChecked = 16102556
            SelectionAppearance.ColorMirrorCheckedTo = 16768988
            SelectionAppearance.ColorMirrorDisabled = 11974326
            SelectionAppearance.ColorMirrorDisabledTo = 15921906
            SelectionAppearance.TextColor = clBlack
            SelectionAppearance.TextColorHot = clWhite
            SelectionAppearance.TextColorDown = clWhite
            SelectionAppearance.TextColorChecked = clBlack
            SelectionAppearance.TextColorDisabled = clGray
            SelectionAppearance.Rounded = False
            Tools = <
              item
                BackGroundColor = clBlack
                Caption = 'Automatic'
                CaptionAlignment = taCenter
                ImageIndex = -1
                Hint = 'Automatic'
                Enable = True
                ItemType = itFullWidthButton
              end
              item
                BackGroundColor = clBlack
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 13209
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 13107
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 13056
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 6697728
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clNavy
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 3486515
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 3355443
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clMaroon
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 26367
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clOlive
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clGreen
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clTeal
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clBlue
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 10053222
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clGray
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clRed
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 39423
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 52377
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 6723891
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 13421619
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 16737843
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clPurple
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 10066329
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clFuchsia
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 52479
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clYellow
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clLime
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clAqua
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 16763904
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 6697881
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clSilver
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 13408767
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 10079487
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 10092543
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 13434828
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 16777164
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 16764057
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 16751052
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clWhite
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                Caption = 'More Colors...'
                CaptionAlignment = taCenter
                ImageIndex = -1
                Hint = 'More Colors'
                Enable = True
                ItemType = itFullWidthButton
              end>
            OnSelectColor = ERPButtonFontColorSelectorSelectColor
          end
          object ERPButtonFontGradIntensity: TAdvTrackBar
            AlignWithMargins = True
            Left = 321
            Top = 9
            Width = 160
            Height = 23
            HelpContext = 121227
            Margins.Left = 10
            BorderColor = clBlack
            BorderColorDisabled = clBlack
            Buttons.BorderColor = clBlack
            Buttons.BorderColorHot = 10079963
            Buttons.BorderColorDown = 4548219
            Buttons.Color = 15653832
            Buttons.ColorTo = 16178633
            Buttons.ColorHot = 15465983
            Buttons.ColorHotTo = 11332863
            Buttons.ColorDown = 7778289
            Buttons.ColorDownTo = 4296947
            Buttons.ColorMirror = 15586496
            Buttons.ColorMirrorTo = 16245200
            Buttons.ColorMirrorHot = 5888767
            Buttons.ColorMirrorHotTo = 10807807
            Buttons.ColorMirrorDown = 946929
            Buttons.ColorMirrorDownTo = 5021693
            Buttons.GradientMirror = ggVertical
            ColorTo = clWhite
            ColorDisabled = clWhite
            ColorDisabledTo = clWhite
            Direction = gdHorizontal
            Color = clWhite
            Max = 240
            Slider.BorderColor = 12752500
            Slider.BorderColorDisabled = clBlack
            Slider.Color = clWhite
            Slider.ColorTo = clBlack
            Slider.ColorDisabled = clBlack
            Slider.ColorDisabledTo = clBlack
            Slider.ColorCompleted = clNone
            Slider.ColorCompletedTo = clNone
            Slider.ColorCompletedDisabled = clNone
            Slider.ColorCompletedDisabledTo = clNone
            Slider.Direction = gdHorizontal
            TabOrder = 1
            Thumb.BorderColor = 10317632
            Thumb.BorderColorHot = 10079963
            Thumb.BorderColorDown = 4548219
            Thumb.BorderColorDisabled = clBlack
            Thumb.Color = 15653832
            Thumb.ColorTo = 16178633
            Thumb.ColorDown = 7778289
            Thumb.ColorDownTo = 4296947
            Thumb.ColorHot = 15465983
            Thumb.ColorHotTo = 11332863
            Thumb.ColorDisabled = clBlack
            Thumb.ColorDisabledTo = clBlack
            Thumb.ColorMirror = 15586496
            Thumb.ColorMirrorTo = 16245200
            Thumb.ColorMirrorHot = 5888767
            Thumb.ColorMirrorHotTo = 10807807
            Thumb.ColorMirrorDown = 946929
            Thumb.ColorMirrorDownTo = 5021693
            Thumb.ColorMirrorDisabled = clBlack
            Thumb.ColorMirrorDisabledTo = clBlack
            Thumb.Gradient = ggVertical
            Thumb.GradientMirror = ggRadial
            Thumb.Shape = tsPointer
            TickMark.Color = clWhite
            TickMark.ColorDisabled = clWhite
            TickMark.Font.Charset = DEFAULT_CHARSET
            TickMark.Font.Color = clWindowText
            TickMark.Font.Height = -11
            TickMark.Font.Name = 'Tahoma'
            TickMark.Font.Style = []
            TickMark.Line3D = True
            TickMark.ShowImageAtSteps = 15
            TickMark.Spacing = 10
            TickMark.Size = 10
            TrackHint = True
            TrackLabel.Font.Charset = DEFAULT_CHARSET
            TrackLabel.Font.Color = clWindowText
            TrackLabel.Font.Height = -11
            TrackLabel.Font.Name = 'Tahoma'
            TrackLabel.Font.Style = []
            TrackLabel.Format = 'Pos: %d'
            Transparent = False
            Version = '1.6.2.0'
            OnChange = ERPButtonFontGradIntensityChange
          end
        end
        object pnlERPButtonHTColor: TPanel
          AlignWithMargins = True
          Left = 0
          Top = 116
          Width = 1030
          Height = 41
          HelpContext = 121228
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 33
          Align = alBottom
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 3
          DesignSize = (
            1030
            41)
          object Label28: TLabel
            Left = 142
            Top = 13
            Width = 129
            Height = 15
            HelpContext = 121229
            Alignment = taRightJustify
            Anchors = [akLeft, akBottom]
            Caption = 'Button Hottrack Colour'
            Transparent = True
          end
          object ERPButtonHTColorSelector: TAdvOfficeColorSelector
            AlignWithMargins = True
            Left = 282
            Top = 9
            Width = 26
            Height = 23
            HelpContext = 121230
            Margins.Left = 233
            AntiAlias = aaAntiAlias
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            NotesFont.Charset = DEFAULT_CHARSET
            NotesFont.Color = clWindowText
            NotesFont.Height = -11
            NotesFont.Name = 'Tahoma'
            NotesFont.Style = []
            ParentFont = False
            Version = '1.3.1.1'
            TabOrder = 0
            AllowFloating = False
            CloseOnSelect = True
            CaptionAppearance.BorderColor = clNone
            CaptionAppearance.Color = 13198890
            CaptionAppearance.ColorTo = clNone
            CaptionAppearance.Direction = gdHorizontal
            CaptionAppearance.TextColor = clWhite
            CaptionAppearance.TextColorHot = clBlack
            CaptionAppearance.TextColorDown = clBlack
            CaptionAppearance.ButtonAppearance.ColorChecked = 16111818
            CaptionAppearance.ButtonAppearance.ColorCheckedTo = 16367008
            CaptionAppearance.ButtonAppearance.ColorDisabled = 15921906
            CaptionAppearance.ButtonAppearance.ColorDisabledTo = 15921906
            CaptionAppearance.ButtonAppearance.ColorDown = 16111818
            CaptionAppearance.ButtonAppearance.ColorDownTo = 16367008
            CaptionAppearance.ButtonAppearance.ColorHot = 16117985
            CaptionAppearance.ButtonAppearance.ColorHotTo = 16372402
            CaptionAppearance.ButtonAppearance.ColorMirrorHot = 16107693
            CaptionAppearance.ButtonAppearance.ColorMirrorHotTo = 16775412
            CaptionAppearance.ButtonAppearance.ColorMirrorDown = 16102556
            CaptionAppearance.ButtonAppearance.ColorMirrorDownTo = 16768988
            CaptionAppearance.ButtonAppearance.ColorMirrorChecked = 16102556
            CaptionAppearance.ButtonAppearance.ColorMirrorCheckedTo = 16768988
            CaptionAppearance.ButtonAppearance.ColorMirrorDisabled = 11974326
            CaptionAppearance.ButtonAppearance.ColorMirrorDisabledTo = 15921906
            DragGripAppearance.BorderColor = clGray
            DragGripAppearance.Color = clWhite
            DragGripAppearance.ColorTo = clWhite
            DragGripAppearance.ColorMirror = clSilver
            DragGripAppearance.ColorMirrorTo = clWhite
            DragGripAppearance.Gradient = ggVertical
            DragGripAppearance.GradientMirror = ggVertical
            DragGripAppearance.BorderColorHot = clBlue
            DragGripAppearance.ColorHot = 16117985
            DragGripAppearance.ColorHotTo = 16372402
            DragGripAppearance.ColorMirrorHot = 16107693
            DragGripAppearance.ColorMirrorHotTo = 16775412
            DragGripAppearance.GradientHot = ggRadial
            DragGripAppearance.GradientMirrorHot = ggRadial
            DragGripPosition = gpTop
            Appearance.ColorChecked = 16111818
            Appearance.ColorCheckedTo = 16367008
            Appearance.ColorDisabled = 15921906
            Appearance.ColorDisabledTo = 15921906
            Appearance.ColorDown = 16111818
            Appearance.ColorDownTo = 16367008
            Appearance.ColorHot = 16117985
            Appearance.ColorHotTo = 16372402
            Appearance.ColorMirrorHot = 16107693
            Appearance.ColorMirrorHotTo = 16775412
            Appearance.ColorMirrorDown = 16102556
            Appearance.ColorMirrorDownTo = 16768988
            Appearance.ColorMirrorChecked = 16102556
            Appearance.ColorMirrorCheckedTo = 16768988
            Appearance.ColorMirrorDisabled = 11974326
            Appearance.ColorMirrorDisabledTo = 15921906
            SelectedColor = clNone
            ShowRGBHint = True
            ColorDropDown = 16251129
            ColorDropDownFloating = 16374724
            SelectionAppearance.ColorChecked = 16111818
            SelectionAppearance.ColorCheckedTo = 16367008
            SelectionAppearance.ColorDisabled = 15921906
            SelectionAppearance.ColorDisabledTo = 15921906
            SelectionAppearance.ColorDown = 16111818
            SelectionAppearance.ColorDownTo = 16367008
            SelectionAppearance.ColorHot = 16117985
            SelectionAppearance.ColorHotTo = 16372402
            SelectionAppearance.ColorMirrorHot = 16107693
            SelectionAppearance.ColorMirrorHotTo = 16775412
            SelectionAppearance.ColorMirrorDown = 16102556
            SelectionAppearance.ColorMirrorDownTo = 16768988
            SelectionAppearance.ColorMirrorChecked = 16102556
            SelectionAppearance.ColorMirrorCheckedTo = 16768988
            SelectionAppearance.ColorMirrorDisabled = 11974326
            SelectionAppearance.ColorMirrorDisabledTo = 15921906
            SelectionAppearance.TextColor = clBlack
            SelectionAppearance.TextColorHot = clWhite
            SelectionAppearance.TextColorDown = clWhite
            SelectionAppearance.TextColorChecked = clBlack
            SelectionAppearance.TextColorDisabled = clGray
            SelectionAppearance.Rounded = False
            Tools = <
              item
                BackGroundColor = clBlack
                Caption = 'Automatic'
                CaptionAlignment = taCenter
                ImageIndex = -1
                Hint = 'Automatic'
                Enable = True
                ItemType = itFullWidthButton
              end
              item
                BackGroundColor = clBlack
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 13209
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 13107
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 13056
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 6697728
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clNavy
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 3486515
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 3355443
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clMaroon
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 26367
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clOlive
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clGreen
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clTeal
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clBlue
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 10053222
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clGray
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clRed
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 39423
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 52377
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 6723891
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 13421619
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 16737843
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clPurple
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 10066329
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clFuchsia
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 52479
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clYellow
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clLime
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clAqua
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 16763904
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 6697881
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clSilver
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 13408767
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 10079487
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 10092543
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 13434828
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 16777164
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 16764057
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = 16751052
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                BackGroundColor = clWhite
                CaptionAlignment = taCenter
                ImageIndex = -1
                Enable = True
              end
              item
                Caption = 'More Colors...'
                CaptionAlignment = taCenter
                ImageIndex = -1
                Hint = 'More Colors'
                Enable = True
                ItemType = itFullWidthButton
              end>
            OnSelectColor = ERPButtonHTColorSelectorSelectColor
          end
          object ERPButtonHTGradIntensity: TAdvTrackBar
            AlignWithMargins = True
            Left = 321
            Top = 9
            Width = 160
            Height = 23
            HelpContext = 121231
            Margins.Left = 10
            BorderColor = clBlack
            BorderColorDisabled = clBlack
            Buttons.BorderColor = clBlack
            Buttons.BorderColorHot = 10079963
            Buttons.BorderColorDown = 4548219
            Buttons.Color = 15653832
            Buttons.ColorTo = 16178633
            Buttons.ColorHot = 15465983
            Buttons.ColorHotTo = 11332863
            Buttons.ColorDown = 7778289
            Buttons.ColorDownTo = 4296947
            Buttons.ColorMirror = 15586496
            Buttons.ColorMirrorTo = 16245200
            Buttons.ColorMirrorHot = 5888767
            Buttons.ColorMirrorHotTo = 10807807
            Buttons.ColorMirrorDown = 946929
            Buttons.ColorMirrorDownTo = 5021693
            Buttons.GradientMirror = ggVertical
            ColorTo = clWhite
            ColorDisabled = clWhite
            ColorDisabledTo = clWhite
            Direction = gdHorizontal
            Color = clWhite
            Max = 240
            Slider.BorderColor = 12752500
            Slider.BorderColorDisabled = clBlack
            Slider.Color = clWhite
            Slider.ColorTo = clBlack
            Slider.ColorDisabled = clBlack
            Slider.ColorDisabledTo = clBlack
            Slider.ColorCompleted = clNone
            Slider.ColorCompletedTo = clNone
            Slider.ColorCompletedDisabled = clNone
            Slider.ColorCompletedDisabledTo = clNone
            Slider.Direction = gdHorizontal
            TabOrder = 1
            Thumb.BorderColor = 10317632
            Thumb.BorderColorHot = 10079963
            Thumb.BorderColorDown = 4548219
            Thumb.BorderColorDisabled = clBlack
            Thumb.Color = 15653832
            Thumb.ColorTo = 16178633
            Thumb.ColorDown = 7778289
            Thumb.ColorDownTo = 4296947
            Thumb.ColorHot = 15465983
            Thumb.ColorHotTo = 11332863
            Thumb.ColorDisabled = clBlack
            Thumb.ColorDisabledTo = clBlack
            Thumb.ColorMirror = 15586496
            Thumb.ColorMirrorTo = 16245200
            Thumb.ColorMirrorHot = 5888767
            Thumb.ColorMirrorHotTo = 10807807
            Thumb.ColorMirrorDown = 946929
            Thumb.ColorMirrorDownTo = 5021693
            Thumb.ColorMirrorDisabled = clBlack
            Thumb.ColorMirrorDisabledTo = clBlack
            Thumb.Gradient = ggVertical
            Thumb.GradientMirror = ggRadial
            Thumb.Shape = tsPointer
            TickMark.Color = clWhite
            TickMark.ColorDisabled = clWhite
            TickMark.Font.Charset = DEFAULT_CHARSET
            TickMark.Font.Color = clWindowText
            TickMark.Font.Height = -11
            TickMark.Font.Name = 'Tahoma'
            TickMark.Font.Style = []
            TickMark.Line3D = True
            TickMark.ShowImageAtSteps = 15
            TickMark.Spacing = 10
            TickMark.Size = 10
            TrackHint = True
            TrackLabel.Font.Charset = DEFAULT_CHARSET
            TrackLabel.Font.Color = clWindowText
            TrackLabel.Font.Height = -11
            TrackLabel.Font.Name = 'Tahoma'
            TrackLabel.Font.Style = []
            TrackLabel.Format = 'Pos: %d'
            Transparent = False
            Version = '1.6.2.0'
            OnChange = ERPButtonHTGradIntensityChange
          end
        end
        object btnColorPrefs: TDNMSpeedButton
          Left = 8
          Top = 157
          Width = 185
          Height = 27
          HelpContext = 121232
          Anchors = [akLeft, akBottom]
          Cancel = True
          Caption = 'Colour Preferences'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
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
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btnColorPrefsClick
        end
      end
      object btnDefault: TDNMSpeedButton
        Left = 344
        Top = 46
        Width = 160
        Height = 27
        HelpContext = 121233
        Cancel = True
        Caption = 'Set To Blue'
        Color = clWhite
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
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
        TabStop = False
        AutoDisableParentOnclick = True
        OnClick = btnDefaultClick
      end
      object btnGreenRestore: TDNMSpeedButton
        Left = 178
        Top = 46
        Width = 160
        Height = 27
        HelpContext = 121234
        Cancel = True
        Caption = 'Set to Green'
        Color = clWhite
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
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
        TabStop = False
        AutoDisableParentOnclick = True
        OnClick = btnGreenRestoreClick
      end
    end
    object pnlDefaultApptSettings: TDNMPanel
      Left = 0
      Top = 477
      Width = 1067
      Height = 360
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      DesignSize = (
        1067
        360)
      object Bevel13: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1053
        Height = 346
        HelpContext = 121114
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 5
        ExplicitHeight = 306
      end
      object Label29: TLabel
        Left = 127
        Top = 54
        Width = 72
        Height = 15
        HelpContext = 11070
        Caption = 'Show Hours '
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
        Left = 400
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
      object Label30: TLabel
        Left = 39
        Top = 211
        Width = 166
        Height = 15
        HelpContext = 11070
        Caption = 'Default Appointment Duration'
        Transparent = True
      end
      object Label31: TLabel
        Left = 123
        Top = 281
        Width = 76
        Height = 15
        HelpContext = 11070
        Anchors = [akLeft, akBottom]
        Caption = 'Show Time In'
        Transparent = True
        ExplicitTop = 241
      end
      object Label32: TLabel
        Left = 113
        Top = 315
        Width = 86
        Height = 15
        HelpContext = 11070
        Anchors = [akLeft, akBottom]
        Caption = 'Default Service'
        Transparent = True
        ExplicitTop = 275
      end
      object Label33: TLabel
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
      object Label34: TLabel
        Left = 66
        Top = 131
        Width = 133
        Height = 15
        HelpContext = 11070
        Caption = 'Weekdays for Available'
        Transparent = True
      end
      object Bevel14: TBevel
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
        Top = 50
        Width = 100
        Height = 23
        HelpContext = 11180
        DataField = 'ApptStartTime'
        DataSource = dsPersonalPreferences
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
        Left = 400
        Top = 50
        Width = 100
        Height = 23
        HelpContext = 11181
        DataField = 'ApptEndtime'
        DataSource = dsPersonalPreferences
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
        Top = 208
        Width = 136
        Height = 23
        ShowButton = True
        Style = csDropDown
        MapList = True
        AllowClearKey = False
        DataField = 'DefaultApptDuration'
        DataSource = dsPersonalPreferences
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
        Top = 277
        Width = 136
        Height = 23
        Anchors = [akLeft, akBottom]
        ShowButton = True
        Style = csDropDown
        MapList = True
        AllowClearKey = False
        DataField = 'ShowApptDurationin'
        DataSource = dsPersonalPreferences
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
      end
      object wwDBLookupCombo1: TwwDBLookupCombo
        Left = 211
        Top = 311
        Width = 289
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
        DataSource = dsPersonalPreferences
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
        DataSource = dsPersonalPreferences
        TabOrder = 5
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
        DataSource = dsPersonalPreferences
        TabOrder = 6
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
        DataSource = dsPersonalPreferences
        TabOrder = 7
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
        DataSource = dsPersonalPreferences
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
        DataSource = dsPersonalPreferences
        TabOrder = 9
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
        DataSource = dsPersonalPreferences
        TabOrder = 10
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
        DataSource = dsPersonalPreferences
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
        DataSource = dsPersonalPreferences
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
  inherited popSpelling: TPopupMenu
    Left = 152
    Top = 24
  end
  inherited tmrdelayMsg: TTimer
    Left = 192
    Top = 24
  end
  object MyConnection: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Server = 'localhost'
    LoginPrompt = False
    Left = 592
    Top = 24
  end
  object dsPrefs: TDataSourcePrefs
    Connection = MyConnection
    FieldDefs = <>
    FieldNames.Strings = (
      'GenerateEmployeeno')
    Left = 496
    Top = 32
  end
  object qryPersonalPreferences: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblpersonalpreferences'
      'WHERE EmployeeID = :EmployeeID;')
    BeforePost = qryPersonalPreferencesBeforePost
    Left = 688
    Top = 24
    ParamData = <
      item
        DataType = ftString
        Name = 'EmployeeID'
        Value = ''
      end>
  end
  object dsPersonalPreferences: TDataSource
    DataSet = qryPersonalPreferences
    Left = 542
    Top = 24
  end
  object ColorDialog: TColorDialog
    Left = 720
    Top = 24
  end
  object QryProduct: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PartsId, partname'
      'FROM tblparts'
      'WHERE active ="T" and parttype ='#39'NONINV'#39
      'order by partname')
    BeforePost = qryPersonalPreferencesBeforePost
    Left = 704
    Top = 568
  end
end
