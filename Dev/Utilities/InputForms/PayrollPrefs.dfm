inherited PayrollPrefsGUI: TPayrollPrefsGUI
  Left = 450
  Top = 75
  HelpContext = 414000
  Caption = 'Payroll Preferences'
  ClientHeight = 498
  ClientWidth = 683
  ExplicitLeft = 450
  ExplicitTop = 75
  ExplicitWidth = 699
  ExplicitHeight = 537
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 498
    Width = 683
    HelpContext = 414155
    ExplicitTop = 913
    ExplicitWidth = 1144
  end
  object lblWidth: TLabel [1]
    Left = 23
    Top = 8
    Width = 863
    Height = 22
    HelpContext = 414001
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
    Width = 683
    Height = 498
    HelpContext = 414245
    VertScrollBar.Position = 2459
    ExplicitWidth = 1076
    ExplicitHeight = 861
    object pnlAccounts: TDNMPanel
      Left = 0
      Top = -2031
      Width = 839
      Height = 785
      HelpContext = 414205
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Bevel6: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 825
        Height = 771
        HelpContext = 414206
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 5
        ExplicitWidth = 1051
      end
      object Label5: TLabel
        Left = 14
        Top = 14
        Width = 54
        Height = 15
        HelpContext = 414207
        Caption = 'Accounts'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label7: TLabel
        Left = 167
        Top = 16
        Width = 49
        Height = 15
        HelpContext = 414208
        Caption = 'Expense'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label10: TLabel
        Left = 339
        Top = 14
        Width = 43
        Height = 15
        HelpContext = 414209
        Caption = 'Liability'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object lblGrossWages: TLabel
        Left = 24
        Top = 141
        Width = 77
        Height = 15
        HelpContext = 414210
        Caption = 'Gross Wages'
        Transparent = True
      end
      object Label11: TLabel
        Left = 24
        Top = 170
        Width = 62
        Height = 15
        HelpContext = 414211
        Caption = 'Net Wages'
        Transparent = True
      end
      object Label12: TLabel
        Left = 24
        Top = 199
        Width = 78
        Height = 15
        HelpContext = 414212
        Caption = 'Commissions'
        Transparent = True
      end
      object Label14: TLabel
        Left = 24
        Top = 257
        Width = 124
        Height = 15
        HelpContext = 414213
        Caption = 'Lump Sum D Expense'
        Transparent = True
      end
      object Label15: TLabel
        Left = 24
        Top = 286
        Width = 34
        Height = 15
        HelpContext = 414214
        Caption = 'Leave'
        Transparent = True
      end
      object Label16: TLabel
        Left = 23
        Top = 41
        Width = 115
        Height = 15
        HelpContext = 414215
        Caption = 'Deductions (Default)'
        Transparent = True
      end
      object Label17: TLabel
        Left = 23
        Top = 70
        Width = 117
        Height = 15
        HelpContext = 414216
        Caption = 'Allowances (Default)'
        Transparent = True
      end
      object Label21: TLabel
        Left = 24
        Top = 228
        Width = 51
        Height = 15
        HelpContext = 414217
        Caption = 'Sundries'
        Transparent = True
      end
      object lblSuperannuation: TLabel
        Left = 24
        Top = 315
        Width = 90
        Height = 15
        HelpContext = 414218
        Caption = 'Superannuation'
        Transparent = True
      end
      object Label23: TLabel
        Left = 14
        Top = 363
        Width = 77
        Height = 15
        HelpContext = 414219
        Caption = 'Tax Accounts'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Bevel7: TBevel
        Left = 24
        Top = 127
        Width = 493
        Height = 5
        HelpContext = 414220
        Shape = bsBottomLine
      end
      object Label32: TLabel
        Left = 166
        Top = 94
        Width = 314
        Height = 30
        HelpContext = 414221
        Caption = 
          'These Accounts are used as Defaults when creating new Employee D' +
          'eductions of Allowances'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Bevel13: TBevel
        Left = 24
        Top = 342
        Width = 493
        Height = 5
        HelpContext = 414222
        Shape = bsBottomLine
      end
      object Bevel15: TBevel
        Left = 24
        Top = 389
        Width = 493
        Height = 5
        HelpContext = 414223
        Shape = bsBottomLine
      end
      object wwDBLookupCombo1: TwwDBLookupCombo
        Left = 167
        Top = 138
        Width = 160
        Height = 23
        HelpContext = 414224
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'WagesPaidAccountID'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        Options = [loColLines]
        ParentFont = False
        TabOrder = 0
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo2: TwwDBLookupCombo
        Left = 167
        Top = 167
        Width = 160
        Height = 23
        HelpContext = 414225
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'NetWagesAccountID'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        ParentFont = False
        TabOrder = 1
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo3: TwwDBLookupCombo
        Left = 167
        Top = 196
        Width = 160
        Height = 23
        HelpContext = 414226
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'CommissionPaidAccountID'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        Options = [loColLines]
        ParentFont = False
        TabOrder = 2
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo4: TwwDBLookupCombo
        Left = 167
        Top = 254
        Width = 160
        Height = 23
        HelpContext = 414227
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'LumpSumDPaidAccountID'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        Options = [loColLines]
        ParentFont = False
        TabOrder = 3
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo5: TwwDBLookupCombo
        Left = 167
        Top = 283
        Width = 160
        Height = 23
        HelpContext = 414228
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'LeaveProvisionAccountID'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        Options = [loColLines]
        ParentFont = False
        TabOrder = 4
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo6: TwwDBLookupCombo
        Left = 339
        Top = 283
        Width = 160
        Height = 23
        HelpContext = 414229
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'LeaveLiabilityAccountID'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        Options = [loColLines]
        ParentFont = False
        TabOrder = 5
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo7: TwwDBLookupCombo
        Left = 166
        Top = 38
        Width = 160
        Height = 23
        HelpContext = 414230
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'DeductionsPaidAccountID'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        Options = [loColLines]
        ParentFont = False
        TabOrder = 6
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo8: TwwDBLookupCombo
        Left = 166
        Top = 67
        Width = 160
        Height = 23
        HelpContext = 414231
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'AllowancePaidAccountID'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        Options = [loColLines]
        ParentFont = False
        TabOrder = 7
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo9: TwwDBLookupCombo
        Left = 338
        Top = 67
        Width = 160
        Height = 23
        HelpContext = 414232
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'AllowanceLiabilityAccountID'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        Options = [loColLines]
        ParentFont = False
        TabOrder = 8
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo10: TwwDBLookupCombo
        Left = 167
        Top = 225
        Width = 160
        Height = 23
        HelpContext = 414233
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'SundriesPaidAccountID'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        Options = [loColLines]
        ParentFont = False
        TabOrder = 9
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object cboSuperannuationExpense: TwwDBLookupCombo
        Left = 167
        Top = 312
        Width = 160
        Height = 23
        HelpContext = 414234
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'SuperPaidAccountID'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        Options = [loColLines]
        ParentFont = False
        TabOrder = 10
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object cboSuperannuationLiability: TwwDBLookupCombo
        Left = 339
        Top = 312
        Width = 160
        Height = 23
        HelpContext = 414235
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'SuperPayableAccountID'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        Options = [loColLines]
        ParentFont = False
        TabOrder = 11
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo11: TwwDBLookupCombo
        Left = 338
        Top = 38
        Width = 161
        Height = 23
        HelpContext = 414236
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'DeductionLiabilityAccountID'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        Options = [loColLines]
        ParentFont = False
        TabOrder = 12
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object btnNewPayTax: TDNMSpeedButton
        Left = 16
        Top = 743
        Width = 98
        Height = 25
        Hint = 'Create a new payroll tax'
        HelpContext = 414237
        Caption = 'New Tax'
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
        TabOrder = 13
        AutoDisableParentOnclick = True
        OnClick = btnNewPayTaxClick
      end
      object pnlTaxAccountActive: TDNMPanel
        Left = 273
        Top = 358
        Width = 225
        Height = 25
        HelpContext = 414238
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 14
        object rbActive: TRadioButton
          Left = 8
          Top = 5
          Width = 65
          Height = 17
          HelpContext = 414239
          Caption = 'Active'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = rbActiveClick
        end
        object rbInactive: TRadioButton
          Left = 79
          Top = 4
          Width = 65
          Height = 17
          HelpContext = 414240
          Caption = 'Inactive'
          TabOrder = 1
          OnClick = rbInactiveClick
        end
        object rdBoth: TRadioButton
          Left = 158
          Top = 5
          Width = 54
          Height = 17
          HelpContext = 414241
          Caption = 'Both'
          TabOrder = 2
          OnClick = rdBothClick
        end
      end
      object TaxList: TScrollBox
        Left = 17
        Top = 400
        Width = 518
        Height = 327
        HelpContext = 414242
        VertScrollBar.Smooth = True
        VertScrollBar.Tracking = True
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 15
      end
    end
    object pnlJobs: TDNMPanel
      Left = 0
      Top = 287
      Width = 839
      Height = 209
      HelpContext = 414023
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
        Width = 825
        Height = 195
        HelpContext = 414024
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 217
      end
      object Label9: TLabel
        Left = 14
        Top = 14
        Width = 97
        Height = 15
        HelpContext = 414025
        Caption = 'Jobs / Timesheet'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox9: TwwCheckBox
        Left = 24
        Top = 45
        Width = 444
        Height = 17
        HelpContext = 414033
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
        Caption = 'Use Employee Service as Employee Cost in Job Tracking'
        DataField = 'UseEmpServiceAsEmpCost'
        DataSource = dsPrefs
        TabOrder = 0
      end
      object wwCheckBox10: TwwCheckBox
        Left = 24
        Top = 77
        Width = 444
        Height = 17
        HelpContext = 414034
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
        Caption = 'Timesheets are allocated as done when applied to an invoice'
        DataField = 'TSDoneOnInvoice'
        DataSource = dsPrefs
        TabOrder = 1
      end
      object wwCheckBox11: TwwCheckBox
        Left = 24
        Top = 109
        Width = 444
        Height = 17
        HelpContext = 414035
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
        Caption = 'Summarise Timesheet Entries when applying cost to Invoices'
        DataField = 'SummariseTSForInvoiceCost'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object wwCheckBox13: TwwCheckBox
        Left = 24
        Top = 141
        Width = 444
        Height = 17
        HelpContext = 414036
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
        Caption = 'Use Timesheet Rate Inc As Invoice Cost'
        DataField = 'UseTimesheetRateIncAsInvoiceCost'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object chkDefaultSuperOnTimesheet: TwwCheckBox
        Left = 24
        Top = 172
        Width = 444
        Height = 17
        HelpContext = 414203
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
        Caption = 'Include Super on Timesheets by default'
        DataField = 'DefaultSuperOnTimesheet'
        DataSource = dsPrefs
        TabOrder = 4
      end
    end
    object pnlSuper: TDNMPanel
      Left = 0
      Top = -272
      Width = 839
      Height = 406
      HelpContext = 414131
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Bevel8: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 825
        Height = 392
        HelpContext = 414132
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 9
        ExplicitTop = 5
        ExplicitWidth = 1043
      end
      object Label33: TLabel
        Left = 14
        Top = 14
        Width = 34
        Height = 15
        HelpContext = 414133
        Caption = 'Super'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label46: TLabel
        Left = 24
        Top = 136
        Width = 215
        Height = 15
        HelpContext = 414139
        Caption = 'Pay Super if Monthly Gross More Than'
        Transparent = True
      end
      object Label47: TLabel
        Left = 24
        Top = 253
        Width = 162
        Height = 15
        HelpContext = 414140
        Caption = 'Default Superannuation Rate'
        Transparent = True
      end
      object Label48: TLabel
        Left = 23
        Top = 368
        Width = 149
        Height = 15
        HelpContext = 414143
        Caption = 'Employer SGC Percentage'
        Transparent = True
      end
      object lblIgnore8: TLabel
        Left = 262
        Top = 252
        Width = 9
        Height = 15
        HelpContext = 414144
        Caption = '%'
        Transparent = True
      end
      object wwCheckBox18: TwwCheckBox
        Left = 24
        Top = 104
        Width = 333
        Height = 17
        HelpContext = 414145
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
        Caption = 'Monthly Super Threshold On Casual Employees'
        Checked = True
        DataField = 'MonthSuperTCasual'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 0
      end
      object wwCheckBox22: TwwCheckBox
        Left = 24
        Top = 40
        Width = 333
        Height = 17
        HelpContext = 414146
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
        Caption = 'Monthly Super Threshold On Permanent Employees'
        Checked = True
        DataField = 'MonthSuperTPermanent'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 1
      end
      object wwCheckBox23: TwwCheckBox
        Left = 24
        Top = 72
        Width = 333
        Height = 17
        HelpContext = 414147
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
        Caption = 'Monthly Super Threshold On Part Time Employees'
        Checked = True
        DataField = 'MonthSuperTPartTime'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 2
      end
      object wwCheckBox24: TwwCheckBox
        Left = 24
        Top = 168
        Width = 444
        Height = 17
        HelpContext = 414148
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
        Caption = 'Pay Super to those over the age of 70 years'
        DataField = 'PaySuperToOver70'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object wwCheckBox26: TDBCheckBox
        Left = 24
        Top = 206
        Width = 444
        Height = 29
        HelpContext = 414149
        Caption = 
          'Pay Super to Partime or Casuals under the age of 18 and who work' +
          ' less than 30 hours per week.'
        DataField = 'PayUnder18'
        DataSource = dsPrefs
        TabOrder = 4
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        WordWrap = True
      end
      object wwDBEdit1: TwwDBEdit
        Left = 248
        Top = 133
        Width = 81
        Height = 23
        HelpContext = 414150
        DataField = 'SuperOverGross'
        DataSource = dsPrefs
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
      object wwDBEdit18: TwwDBEdit
        Left = 200
        Top = 248
        Width = 57
        Height = 23
        HelpContext = 414151
        DataField = 'DefaultSuperRate'
        DataSource = dsPrefs
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
      object wwCheckBox19: TwwCheckBox
        Left = 24
        Top = 288
        Width = 444
        Height = 17
        HelpContext = 414152
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
        Caption = 'Calculate SGC on Salary Sacrifice Amounts'
        DataField = 'CalcSGCOnSS'
        DataSource = dsPrefs
        TabOrder = 7
      end
      object wwCheckBox20: TwwCheckBox
        Left = 24
        Top = 323
        Width = 444
        Height = 17
        HelpContext = 414153
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
        Caption = 'Exclude Super from Work Cover Calculations'
        DataField = 'ExcludeSuperFromWC'
        DataSource = dsPrefs
        TabOrder = 8
      end
      object wwDBEdit19: TwwDBEdit
        Left = 191
        Top = 363
        Width = 57
        Height = 23
        HelpContext = 414154
        DataField = 'EmployerSGCPercent'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
    end
    object pnlClearingAccount: TDNMPanel
      Left = 0
      Top = -377
      Width = 839
      Height = 105
      HelpContext = 414102
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Bevel5: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 825
        Height = 91
        HelpContext = 414103
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
      object Label49: TLabel
        Left = 14
        Top = 14
        Width = 97
        Height = 15
        HelpContext = 414104
        Caption = 'Clearing Account'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label35: TLabel
        Left = 24
        Top = 40
        Width = 142
        Height = 15
        HelpContext = 414105
        Caption = 'Payroll Clearing Account '
        Transparent = True
      end
      object Label34: TLabel
        Left = 176
        Top = 59
        Width = 352
        Height = 15
        HelpContext = 414156
        Caption = 'Note: this must be a clearing account not an actual bank account'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object cboWages: TwwDBLookupCombo
        Left = 24
        Top = 56
        Width = 144
        Height = 23
        HelpContext = 414106
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'WageAccountID'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        Options = [loColLines]
        ParentFont = False
        TabOrder = 0
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
    end
    object pnlExtra: TDNMPanel
      Left = 0
      Top = -855
      Width = 839
      Height = 478
      HelpContext = 414204
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object Label50: TLabel
        Left = 14
        Top = 14
        Width = 30
        Height = 15
        HelpContext = 414051
        Caption = 'Extra'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Bevel14: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 825
        Height = 464
        HelpContext = 414050
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 678
      end
      object Label28: TLabel
        Left = 24
        Top = 42
        Width = 111
        Height = 15
        HelpContext = 414058
        Caption = 'Medicare Levy Rate'
        Transparent = True
      end
      object lblIgnore1: TLabel
        Left = 302
        Top = 38
        Width = 9
        Height = 15
        HelpContext = 414062
        Caption = '%'
        Transparent = True
      end
      object Label29: TLabel
        Left = 24
        Top = 71
        Width = 174
        Height = 15
        HelpContext = 414059
        Caption = 'Medicare Levy Surcharge Rate'
        Transparent = True
      end
      object lblIgnore2: TLabel
        Left = 302
        Top = 67
        Width = 9
        Height = 15
        HelpContext = 414063
        Caption = '%'
        Transparent = True
      end
      object Label30: TLabel
        Left = 24
        Top = 100
        Width = 171
        Height = 15
        HelpContext = 414060
        Caption = 'Base Tax Rate for Lump Sums'
        Transparent = True
      end
      object lblIgnore3: TLabel
        Left = 302
        Top = 96
        Width = 9
        Height = 15
        HelpContext = 414064
        Caption = '%'
        Transparent = True
      end
      object Label31: TLabel
        Left = 24
        Top = 129
        Width = 202
        Height = 15
        HelpContext = 414061
        Caption = 'Lump Sum Flat Tax Rate for Over 55'
        Transparent = True
      end
      object lblIgnore4: TLabel
        Left = 302
        Top = 125
        Width = 9
        Height = 15
        HelpContext = 414065
        Caption = '%'
        Transparent = True
      end
      object Label36: TLabel
        Left = 24
        Top = 158
        Width = 181
        Height = 15
        HelpContext = 414066
        Caption = 'Lump Sum E / Backpay Tax Rate'
        Transparent = True
      end
      object lblIgnore5: TLabel
        Left = 302
        Top = 154
        Width = 9
        Height = 15
        HelpContext = 414067
        Caption = '%'
        Transparent = True
      end
      object Label38: TLabel
        Left = 24
        Top = 187
        Width = 137
        Height = 15
        HelpContext = 414068
        Caption = 'Fringe Benefits Tax Rate'
        Transparent = True
      end
      object lblIgnore6: TLabel
        Left = 302
        Top = 183
        Width = 9
        Height = 15
        HelpContext = 414069
        Caption = '%'
        Transparent = True
      end
      object Label40: TLabel
        Left = 24
        Top = 216
        Width = 91
        Height = 15
        HelpContext = 414070
        Caption = 'No TFN Tax Rate'
        Transparent = True
      end
      object lblIgnore7: TLabel
        Left = 302
        Top = 212
        Width = 9
        Height = 15
        HelpContext = 414071
        Caption = '%'
        Transparent = True
      end
      object Label42: TLabel
        Left = 24
        Top = 245
        Width = 191
        Height = 15
        HelpContext = 414072
        Caption = 'Threshold Limit for RBL Purposes'
        Transparent = True
      end
      object Label43: TLabel
        Left = 24
        Top = 274
        Width = 210
        Height = 15
        HelpContext = 414073
        Caption = 'Lump Sum D (Basic Tax Free Portion)'
        Transparent = True
      end
      object Label44: TLabel
        Left = 24
        Top = 303
        Width = 132
        Height = 15
        HelpContext = 414074
        Caption = '(Yearly tax free portion)'
        Transparent = True
      end
      object Label45: TLabel
        Left = 24
        Top = 332
        Width = 196
        Height = 15
        HelpContext = 414075
        Caption = 'ETP Low Rate Threshold (per year)'
        Transparent = True
      end
      object Label51: TLabel
        Left = 24
        Top = 358
        Width = 162
        Height = 15
        HelpContext = 414171
        Caption = 'Default Superannuation Rate'
        Transparent = True
      end
      object Label52: TLabel
        Left = 344
        Top = 358
        Width = 9
        Height = 15
        HelpContext = 414173
        Caption = '%'
        Transparent = True
      end
      object Label53: TLabel
        Left = 24
        Top = 387
        Width = 215
        Height = 15
        HelpContext = 414172
        Caption = 'Pay Super if Monthly Gross More Than'
        Transparent = True
      end
      object Label54: TLabel
        Left = 24
        Top = 416
        Width = 164
        Height = 15
        HelpContext = 414174
        Caption = 'Workers Compensation Rate'
      end
      object wwDBEdit7: TwwDBEdit
        Left = 248
        Top = 34
        Width = 49
        Height = 23
        HelpContext = 414086
        DataField = 'MedicareLevyRate'
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
      object wwDBEdit8: TwwDBEdit
        Left = 248
        Top = 63
        Width = 49
        Height = 23
        HelpContext = 414087
        DataField = 'MedicareLevySurchargeRate'
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
      object wwDBEdit9: TwwDBEdit
        Left = 248
        Top = 92
        Width = 49
        Height = 23
        HelpContext = 414088
        DataField = 'LumpSumTaxRate'
        DataSource = dsPrefs
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
      object wwDBEdit10: TwwDBEdit
        Left = 248
        Top = 121
        Width = 49
        Height = 23
        HelpContext = 414089
        DataField = 'LumpSumTaxRateOver55'
        DataSource = dsPrefs
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
      object wwDBEdit11: TwwDBEdit
        Left = 248
        Top = 150
        Width = 49
        Height = 23
        HelpContext = 414090
        DataField = 'LumpSumTaxRate'
        DataSource = dsPrefs
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
      object wwDBEdit12: TwwDBEdit
        Left = 248
        Top = 179
        Width = 49
        Height = 23
        HelpContext = 414091
        DataField = 'FBTTaxRate'
        DataSource = dsPrefs
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
      object wwDBEdit13: TwwDBEdit
        Left = 248
        Top = 208
        Width = 49
        Height = 23
        HelpContext = 414092
        DataField = 'NoTFNTaxRate'
        DataSource = dsPrefs
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
      object wwDBEdit14: TwwDBEdit
        Left = 248
        Top = 237
        Width = 92
        Height = 23
        HelpContext = 414093
        DataField = 'RBLThreshold'
        DataSource = dsPrefs
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
      object wwDBEdit15: TwwDBEdit
        Left = 248
        Top = 266
        Width = 92
        Height = 23
        HelpContext = 414094
        DataField = 'LumpDBaseTaxFree'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit16: TwwDBEdit
        Left = 248
        Top = 295
        Width = 92
        Height = 23
        HelpContext = 414095
        DataField = 'LumpDYearlyTaxFree'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit17: TwwDBEdit
        Left = 248
        Top = 324
        Width = 92
        Height = 23
        HelpContext = 414096
        DataField = 'YearlyIncomeThreshold'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit20: TwwDBEdit
        Left = 248
        Top = 353
        Width = 92
        Height = 23
        HelpContext = 414176
        DataField = 'DefaultSuperRate'
        DataSource = dsPrefs
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
      object wwDBEdit21: TwwDBEdit
        Left = 248
        Top = 384
        Width = 92
        Height = 23
        HelpContext = 414177
        DataField = 'SuperOverGross'
        DataSource = dsPrefs
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
      object wwDBEdit22: TwwDBEdit
        Left = 248
        Top = 413
        Width = 92
        Height = 23
        HelpContext = 414178
        DataField = 'WorkersCompRate'
        DataSource = dsPrefs
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
      object chkPaySuperOnLumpSumD: TwwCheckBox
        Left = 26
        Top = 444
        Width = 333
        Height = 17
        HelpContext = 414189
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
        Caption = 'Pay Super On Lump Sum D Payments'
        DataField = 'PaySuperOnLumpSumD'
        DataSource = dsPrefs
        TabOrder = 14
      end
    end
    object pnlGeneral: TDNMPanel
      Left = 0
      Top = -1096
      Width = 839
      Height = 241
      HelpContext = 414049
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      object Bevel4: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 825
        Height = 227
        HelpContext = 414243
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 678
      end
      object Label18: TLabel
        Left = 14
        Top = 14
        Width = 44
        Height = 15
        HelpContext = 414244
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
        Top = 40
        Width = 200
        Height = 15
        HelpContext = 414052
        Caption = 'Standard Hours Worked Per Period'
        Transparent = True
      end
      object Label20: TLabel
        Left = 24
        Top = 72
        Width = 170
        Height = 15
        HelpContext = 414053
        Caption = 'Annual Leave Weeks Per Year'
        Transparent = True
      end
      object lblSickLeaveDays: TLabel
        Left = 24
        Top = 104
        Width = 172
        Height = 15
        HelpContext = 414054
        Caption = 'Sick Leave Days Per Year Cap '
        Transparent = True
      end
      object Label25: TLabel
        Left = 24
        Top = 136
        Width = 213
        Height = 15
        HelpContext = 414055
        Caption = 'Long Service Leave Periods Per Term'
        Transparent = True
      end
      object Label26: TLabel
        Left = 24
        Top = 168
        Width = 186
        Height = 15
        HelpContext = 414056
        Caption = 'Long Service Leave Term (years)'
        Transparent = True
      end
      object Label27: TLabel
        Left = 24
        Top = 200
        Width = 165
        Height = 15
        HelpContext = 414057
        Caption = 'Leave Loading Tax Threshold'
        Transparent = True
      end
      object edtHoursPerWeek: TwwDBEdit
        Left = 248
        Top = 32
        Width = 49
        Height = 23
        HelpContext = 414080
        DataField = 'HoursPerWeek'
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
      object wwDBEdit2: TwwDBEdit
        Left = 248
        Top = 64
        Width = 49
        Height = 23
        HelpContext = 414081
        DataField = 'ALeaveWeeks'
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
      object wwDBEdit3: TwwDBEdit
        Left = 248
        Top = 96
        Width = 49
        Height = 23
        HelpContext = 414082
        DataField = 'SickLeaveDays'
        DataSource = dsPrefs
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
        Left = 248
        Top = 128
        Width = 49
        Height = 23
        HelpContext = 414083
        DataField = 'LSLWeeks'
        DataSource = dsPrefs
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
        Left = 248
        Top = 160
        Width = 49
        Height = 23
        HelpContext = 414084
        DataField = 'LSLCommenceYears'
        DataSource = dsPrefs
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
        Left = 248
        Top = 192
        Width = 49
        Height = 23
        HelpContext = 414085
        DataField = 'LeaveLoadTaxThreshold'
        DataSource = dsPrefs
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
      object wwCheckBox16: TwwCheckBox
        Left = 328
        Top = 40
        Width = 199
        Height = 17
        HelpContext = 414097
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
        Caption = 'Pay by Department'
        DataField = 'PayByDepartment'
        DataSource = dsPrefs
        TabOrder = 6
      end
      object wwCheckBox17: TwwCheckBox
        Left = 328
        Top = 72
        Width = 199
        Height = 17
        HelpContext = 414098
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
        Caption = 'Add to E.F.T. by Default'
        DataField = 'AddToEFT'
        DataSource = dsPrefs
        TabOrder = 7
      end
      object btnImportTaxScales: TDNMSpeedButton
        Left = 328
        Top = 138
        Width = 138
        Height = 27
        HelpContext = 414100
        Caption = 'Import Tax Scales'
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
        OnClick = btnImportTaxScalesClick
      end
      object wwCheckBox21: TwwCheckBox
        Left = 328
        Top = 103
        Width = 199
        Height = 17
        HelpContext = 414101
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
        Caption = 'Include pays with $0 pay rate'
        Checked = True
        DataField = 'IncZeroPayRates'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 9
      end
      object Panel1: TPanel
        Left = 271
        Top = 148
        Width = 257
        Height = 137
        HelpContext = 414179
        BevelInner = bvRaised
        BorderStyle = bsSingle
        Color = clBlue
        TabOrder = 10
        Visible = False
        object Label55: TLabel
          Left = 2
          Top = 122
          Width = 249
          Height = 15
          HelpContext = 414180
          Align = alTop
          ExplicitWidth = 3
        end
        object Label56: TLabel
          Left = 2
          Top = 62
          Width = 249
          Height = 15
          HelpContext = 414181
          Align = alTop
          Caption = 
            '      in the Same directory with the same name and .enc extensio' +
            'n'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 367
        end
        object Label57: TLabel
          Left = 2
          Top = 47
          Width = 249
          Height = 15
          HelpContext = 414182
          Align = alTop
          Caption = '3.    Select the file. This will encrypt the file and save '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 295
        end
        object Label58: TLabel
          Left = 2
          Top = 32
          Width = 249
          Height = 15
          HelpContext = 414183
          Align = alTop
          Caption = '2.    Shit+ctrl+ double click on label 4'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 205
        end
        object Label59: TLabel
          Left = 2
          Top = 17
          Width = 249
          Height = 15
          HelpContext = 414184
          Align = alTop
          Caption = '1.    Shift+Ctrl+single click on Label4'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 204
        end
        object Label60: TLabel
          Left = 2
          Top = 2
          Width = 249
          Height = 15
          HelpContext = 414185
          Align = alTop
          Caption = 'To encrypt the Tax Scale File'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          ExplicitWidth = 160
        end
        object Label61: TLabel
          Left = 2
          Top = 107
          Width = 249
          Height = 15
          HelpContext = 414186
          Align = alTop
          Caption = '1. Select the encrypted file'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 150
        end
        object Label62: TLabel
          Left = 2
          Top = 92
          Width = 249
          Height = 15
          HelpContext = 414187
          Align = alTop
          Caption = 'To Import the file'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          ExplicitWidth = 94
        end
        object Label63: TLabel
          Left = 2
          Top = 77
          Width = 249
          Height = 15
          HelpContext = 414188
          Align = alTop
          ExplicitWidth = 3
        end
      end
    end
    object pnlLoadHoures: TDNMPanel
      Left = 0
      Top = -1246
      Width = 839
      Height = 150
      HelpContext = 414040
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      object Bevel3: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 825
        Height = 136
        HelpContext = 414041
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 96
      end
      object Label13: TLabel
        Left = 14
        Top = 14
        Width = 138
        Height = 15
        HelpContext = 414042
        Caption = 'Load Hours From Roster'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox12: TwwCheckBox
        Left = 24
        Top = 40
        Width = 333
        Height = 17
        HelpContext = 414046
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
        Caption = 'Use Clocked Hours'
        Checked = True
        DataField = 'UseClockedHrs'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 0
      end
      object wwCheckBox14: TwwCheckBox
        Left = 24
        Top = 75
        Width = 333
        Height = 17
        HelpContext = 414047
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
        Caption = 'Ignore Early Start'
        Checked = True
        DataField = 'IgnoreEarlyStart'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 1
      end
      object wwCheckBox15: TwwCheckBox
        Left = 24
        Top = 110
        Width = 333
        Height = 17
        HelpContext = 414048
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
        Caption = 'Ignore Late Finish'
        Checked = True
        DataField = 'IgnoreLateFinish'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 2
      end
    end
    object pnlLeaveAccrual: TDNMPanel
      Left = 0
      Top = -2459
      Width = 839
      Height = 428
      HelpContext = 414002
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      DesignSize = (
        839
        428)
      object Bevel1: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 825
        Height = 414
        HelpContext = 414003
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 12
        ExplicitWidth = 529
        ExplicitHeight = 410
      end
      object Bevel12: TBevel
        Left = 25
        Top = 327
        Width = 798
        Height = 83
        HelpContext = 414157
        Anchors = [akLeft, akTop, akRight]
        Shape = bsFrame
        ExplicitWidth = 1016
      end
      object Bevel9: TBevel
        Left = 25
        Top = 39
        Width = 798
        Height = 126
        HelpContext = 414158
        Anchors = [akLeft, akTop, akRight]
        Shape = bsFrame
        ExplicitWidth = 1016
      end
      object Bevel11: TBevel
        Left = 25
        Top = 200
        Width = 798
        Height = 89
        HelpContext = 414159
        Anchors = [akLeft, akTop, akRight]
        Shape = bsFrame
        ExplicitWidth = 1016
      end
      object Label1: TLabel
        Left = 14
        Top = 19
        Width = 81
        Height = 15
        HelpContext = 414004
        Caption = 'Leave Accrual'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label2: TLabel
        Left = 288
        Top = 68
        Width = 160
        Height = 15
        HelpContext = 414005
        Caption = 'Accrue During Annual Leave'
        Transparent = True
      end
      object lblLeaveAccrueDuringSick: TLabel
        Left = 288
        Top = 100
        Width = 146
        Height = 15
        HelpContext = 414006
        Caption = 'Accrue During Sick Leave'
        Transparent = True
      end
      object Label4: TLabel
        Left = 288
        Top = 132
        Width = 160
        Height = 15
        HelpContext = 414007
        Caption = 'Accrue During Unpaid Leave'
        Transparent = True
      end
      object Label6: TLabel
        Left = 47
        Top = 40
        Width = 113
        Height = 15
        HelpContext = 414010
        Caption = 'Special Leave / RDO'
        Transparent = True
      end
      object Label8: TLabel
        Left = 175
        Top = 40
        Width = 86
        Height = 15
        HelpContext = 414011
        Caption = 'All Other Leave'
        Transparent = True
      end
      object Label64: TLabel
        Left = 16
        Top = 181
        Width = 82
        Height = 15
        HelpContext = 414161
        Caption = 'Balance Sheet'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label65: TLabel
        Left = 17
        Top = 309
        Width = 42
        Height = 15
        HelpContext = 414162
        Caption = 'PaySlip'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Bevel10: TBevel
        Left = 45
        Top = 61
        Width = 444
        Height = 1
        HelpContext = 414014
        Shape = bsTopLine
      end
      object Label22: TLabel
        Left = 288
        Top = 40
        Width = 65
        Height = 15
        HelpContext = 414166
        Caption = 'Description'
        Transparent = True
      end
      object wwCheckBox1: TwwCheckBox
        Left = 95
        Top = 68
        Width = 16
        Height = 17
        HelpContext = 414015
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
        Caption = 'Special Leave / RDO : Accrue During Annual Leave'
        Checked = True
        DataField = 'RDOAccrueDuringAL'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 0
      end
      object chkRDOAccrueDuringSick: TwwCheckBox
        Left = 95
        Top = 100
        Width = 16
        Height = 17
        HelpContext = 414016
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
        Caption = 'Special Leave / RDO : Accrue During Sick Leave'
        Checked = True
        DataField = 'RDOAccrueDuringSick'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 1
      end
      object wwCheckBox3: TwwCheckBox
        Left = 95
        Top = 132
        Width = 16
        Height = 17
        HelpContext = 414017
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
        Caption = 'Special Leave / RDO : Accrue During Unpaid Leave'
        Checked = True
        DataField = 'RDOAccrueDuringUL'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 2
      end
      object wwCheckBox6: TwwCheckBox
        Left = 207
        Top = 132
        Width = 16
        Height = 17
        HelpContext = 414018
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
        Caption = 'All Leave : Accrue During Unpaid Leave'
        Checked = True
        DataField = 'LeaveAccrueDuringUL'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 3
      end
      object wwCheckBox4: TwwCheckBox
        Left = 207
        Top = 68
        Width = 16
        Height = 17
        HelpContext = 414019
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
        Caption = 'All Leave : Accrue During Annual Leave'
        Checked = True
        DataField = 'LeaveAccrueDuringAL'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 4
      end
      object chkLeaveAccrueDuringSick: TwwCheckBox
        Left = 207
        Top = 100
        Width = 16
        Height = 17
        HelpContext = 414020
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
        Caption = 'All Leave: Accrue During Sick Leave'
        Checked = True
        DataField = 'LeaveAccrueDuringSick'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 5
      end
      object wwCheckBox7: TwwCheckBox
        Left = 71
        Top = 212
        Width = 333
        Height = 17
        HelpContext = 414021
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
        Caption = ' Post Accrued Annual Leave Liability'
        Checked = True
        DataField = 'ShowAccruedAnnualLeaveLiability'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 6
      end
      object chkShowAccruedSickLeaveLiability: TwwCheckBox
        Left = 71
        Top = 237
        Width = 333
        Height = 17
        HelpContext = 414022
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
        Caption = ' Post Accrued Sick Leave Liability'
        DataField = 'ShowAccruedSickLeaveLiability'
        DataSource = dsPrefs
        TabOrder = 7
      end
      object wwCheckBox25: TwwCheckBox
        Left = 71
        Top = 262
        Width = 333
        Height = 17
        HelpContext = 414167
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
        Caption = ' Post Accrued Long Service Leave Liability'
        DataField = 'ShowAccruedLongServiceLeaveLiability'
        DataSource = dsPrefs
        TabOrder = 8
      end
      object wwCheckBox27: TwwCheckBox
        Left = 71
        Top = 387
        Width = 333
        Height = 17
        HelpContext = 414168
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
        Caption = 'Show Accrued Long Service Leave'
        DataField = 'ShowAccruedLongServiceLeavePaySlip'
        DataSource = dsPrefs
        TabOrder = 9
      end
      object chkShowAccruedSickLeavePaySlip: TwwCheckBox
        Left = 71
        Top = 361
        Width = 333
        Height = 17
        HelpContext = 414169
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
        Caption = 'Show Accrued Sick Leave'
        DataField = 'ShowAccruedSickLeavePaySlip'
        DataSource = dsPrefs
        TabOrder = 10
      end
      object wwCheckBox29: TwwCheckBox
        Left = 71
        Top = 336
        Width = 333
        Height = 17
        HelpContext = 414170
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
        Caption = 'Show Accrued Annual Leave'
        Checked = True
        DataField = 'ShowAccruedAnnualLeavePaySlip'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 11
      end
    end
    object pnlSingleTouchPayroll: TDNMPanel
      Left = 0
      Top = 134
      Width = 839
      Height = 153
      HelpContext = 414246
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      object Bevel16: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 825
        Height = 139
        HelpContext = 414247
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
      object Label3: TLabel
        Left = 14
        Top = 14
        Width = 114
        Height = 15
        HelpContext = 414248
        Caption = 'Single Touch Payroll'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label24: TLabel
        Left = 24
        Top = 47
        Width = 46
        Height = 15
        HelpContext = 414249
        Caption = 'Client ID'
      end
      object Label37: TLabel
        Left = 248
        Top = 45
        Width = 256
        Height = 15
        HelpContext = 414250
        Caption = '( Contact ERP Support to obtain your Client ID )'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label39: TLabel
        Left = 24
        Top = 81
        Width = 57
        Height = 15
        HelpContext = 414251
        Caption = 'System ID'
      end
      object wwDBEdit23: TwwDBEdit
        Left = 99
        Top = 42
        Width = 140
        Height = 23
        HelpContext = 414252
        DataField = 'OzEdiClientID'
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
      object edtBusinessManagementSystemID: TwwDBEdit
        Left = 99
        Top = 76
        Width = 293
        Height = 23
        HelpContext = 414253
        DataField = 'SoftwareInformationBusinessManagementSystemId'
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
      object btnGEnerateSystemID: TDNMSpeedButton
        Left = 398
        Top = 74
        Width = 100
        Height = 23
        HelpContext = 414254
        Caption = 'Generate'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        TabOrder = 2
        AutoDisableParentOnclick = True
        OnClick = btnGEnerateSystemIDClick
      end
      object chkOzEDITestMode: TwwCheckBox
        Left = 24
        Top = 113
        Width = 97
        Height = 17
        HelpContext = 414255
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Test Mode'
        DataField = 'OzEDITestMode'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object chkSTPDatesinUTCFormat: TwwCheckBox
        Left = 142
        Top = 113
        Width = 155
        Height = 17
        HelpContext = 414255
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Dates in UTC Format'
        DataField = 'STPDatesinUTCFormat'
        DataSource = dsPrefs
        TabOrder = 4
        Visible = False
      end
    end
    object pnlTaxable: TDNMPanel
      Left = 0
      Top = -1246
      Width = 839
      Height = 240
      HelpContext = 414040
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      object Label41: TLabel
        Left = 14
        Top = 14
        Width = 89
        Height = 15
        HelpContext = 414042
        Caption = 'Taxable Income'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Bevel17: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 825
        Height = 226
        HelpContext = 414041
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 9
      end
      object Bevel18: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 825
        Height = 226
        HelpContext = 414050
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 38
      end
      object Label66: TLabel
        Left = 453
        Top = 22
        Width = 9
        Height = 15
        HelpContext = 414062
        Caption = '%'
        Transparent = True
      end
      object grdTaxable: TwwDBGrid
        Left = 35
        Top = 47
        Width = 463
        Height = 171
        HelpContext = 523014
        Selected.Strings = (
          'PayPeriod'#9'24'#9'PayPeriod'
          'A'#9'10'#9'A'
          'B'#9'10'#9'B'
          'C'#9'10'#9'C')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = dsTaxable
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgProportionalColResize]
        TabOrder = 0
        TitleAlignment = taCenter
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = True
        PaintOptions.BackgroundOptions = [coBlendFixedRow]
        object wwDBGrid1IButton: TwwIButton
          Left = 0
          Top = -2
          Width = 23
          Height = 25
          HelpContext = 523018
          AllowAllUp = True
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            333333333333333333333333000033337733333333333333333F333333333333
            0000333911733333973333333377F333333F3333000033391117333911733333
            37F37F333F77F33300003339111173911117333337F337F3F7337F3300003333
            911117111117333337F3337F733337F3000033333911111111733333337F3337
            3333F7330000333333911111173333333337F333333F73330000333333311111
            7333333333337F3333373333000033333339111173333333333337F333733333
            00003333339111117333333333333733337F3333000033333911171117333333
            33337333337F333300003333911173911173333333373337F337F33300003333
            9117333911173333337F33737F337F33000033333913333391113333337FF733
            37F337F300003333333333333919333333377333337FFF730000333333333333
            3333333333333333333777330000333333333333333333333333333333333333
            0000}
          NumGlyphs = 2
          Transparent = False
          Visible = False
          OnClick = wwDBGrid1IButtonClick
        end
      end
      object edtTaxDPercent: TwwDBEdit
        Left = 399
        Top = 18
        Width = 49
        Height = 23
        HelpContext = 414086
        DataField = 'TaxableDeduction'
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
  end
  inherited tmrProcessMessage: TTimer
    Left = 665
    Top = 104
  end
  inherited tmrdelay: TTimer
    Left = 736
    Top = 104
  end
  inherited popSpelling: TPopupMenu
    Left = 808
    Top = 104
  end
  inherited tmrdelayMsg: TTimer
    Left = 699
    Top = 104
  end
  object MyConnection: TERPConnection
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    LoginPrompt = False
    Left = 772
    Top = 104
  end
  object dsPrefs: TDataSourcePrefs
    FieldDefs = <>
    FieldNames.Strings = (
      'AddToEFT'
      'ALeaveWeeks'
      'AllowanceLiabilityAccountID'
      'AllowancePaidAccountID'
      'CalcSGCOnSS'
      'CommissionPaidAccountID'
      'DeductionLiabilityAccountID'
      'DeductionsPaidAccountID'
      'DefaultSuperOnTimesheet'
      'DefaultSuperRate'
      'EmployerSGCPercent'
      'ExcludeSuperFromWC'
      'FBTTaxRate'
      'HoursPerWeek'
      'IgnoreEarlyStart'
      'IgnoreLateFinish'
      'IncZeroPayRates'
      'LeaveAccrueDuringAL'
      'LeaveAccrueDuringSick'
      'LeaveAccrueDuringUL'
      'LeaveLiabilityAccountID'
      'LeaveLoadTaxThreshold'
      'LeaveProvisionAccountID'
      'LiabilityAccountID'
      'LSLCommenceYears'
      'LSLWeeks'
      'LumpDBaseTaxFree'
      'LumpDYearlyTaxFree'
      'LumpSumDPaidAccountID'
      'LumpSumTaxRate'
      'LumpSumTaxRateOver55'
      'MedicareLevyRate'
      'MedicareLevySurchargeRate'
      'MonthSuperTCasual'
      'MonthSuperTPartTime'
      'MonthSuperTPermanent'
      'NetWagesAccountID'
      'NoTFNTaxRate'
      'OzEdiClientID'
      'OzEDITestMode'
      'PayByDepartment'
      'PAYGTaxPayableAccountID'
      'PaySuperOnLumpSumD'
      'PaySuperToOver70'
      'PayUnder18'
      'RBLThreshold'
      'RDOAccrueDuringAL'
      'RDOAccrueDuringSick'
      'RDOAccrueDuringUL'
      'ShowAccruedAnnualLeaveLiability'
      'ShowAccruedAnnualLeavePaySlip'
      'ShowAccruedLongServiceLeaveLiability'
      'ShowAccruedLongServiceLeavePaySlip'
      'ShowAccruedSickLeaveLiability'
      'ShowAccruedSickLeavePaySlip'
      'SickLeaveDays'
      'SoftwareInformationBusinessManagementSystemId'
      'STPDatesinUTCFormat'
      'SummariseTSForInvoiceCost'
      'SundriesPaidAccountID'
      'SuperOverGross'
      'SuperPaidAccountID'
      'SuperPayableAccountID'
      'TaxableDeduction'
      'TSDoneOnInvoice'
      'UseClockedHrs'
      'UseEmpServiceAsEmpCost'
      'UseTimesheetRateIncAsInvoiceCost'
      'WageAccountID'
      'WagesPaidAccountID'
      'WorkersCompRate'
      'YearlyIncomeThreshold')
    Left = 748
    Top = 168
  end
  object dsPersonalPreferences: TDataSource
    DataSet = qryPersonalPreferences
    Left = 880
    Top = 104
  end
  object qryPersonalPreferences: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblpersonalpreferences'
      'WHERE EmployeeID = :EmployeeID;')
    Left = 916
    Top = 104
    ParamData = <
      item
        DataType = ftString
        Name = 'EmployeeID'
        Value = ''
      end>
  end
  object qryAccount: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblChartofAccounts.*, AccDesc as Type'
      'FROM tblChartofAccounts'
      'LEFT JOIN tblacctypedesc on  AccType = AccountType'
      'WHERE IsHeader = '#39'F'#39' AND Active = '#39'T'#39
      'ORDER BY AccDesc, AccountName;')
    Left = 988
    Top = 104
  end
  object qryPayTaxConfig: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblPayTaxConfig where RegionId = :RegionId')
    BeforeOpen = qryPayTaxConfigBeforeOpen
    AfterOpen = qryPayTaxConfigAfterOpen
    Left = 1024
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RegionId'
      end>
    object qryPayTaxConfigTaxName: TWideStringField
      DisplayLabel = 'Tax Name'
      DisplayWidth = 13
      FieldName = 'TaxName'
      Size = 255
    end
    object qryPayTaxConfigTaxType: TWideStringField
      DisplayLabel = 'Tax Type'
      DisplayWidth = 8
      FieldName = 'TaxType'
      FixedChar = True
      Size = 8
    end
    object qryPayTaxConfigExpenseAccount: TStringField
      DisplayLabel = 'Expense Acnt'
      DisplayWidth = 14
      FieldKind = fkLookup
      FieldName = 'ExpenseAccount'
      LookupDataSet = qryAccount
      LookupKeyFields = 'AccountID'
      LookupResultField = 'AccountName'
      KeyFields = 'ExpenseAccountId'
      Size = 255
      Lookup = True
    end
    object qryPayTaxConfigLiabilityAccount: TStringField
      DisplayLabel = 'Liability Acnt'
      DisplayWidth = 14
      FieldKind = fkLookup
      FieldName = 'LiabilityAccount'
      LookupDataSet = qryAccount
      LookupKeyFields = 'AccountID'
      LookupResultField = 'AccountName'
      KeyFields = 'LiabilityAccountId'
      Size = 255
      Lookup = True
    end
    object qryPayTaxConfigAllowanceAmount: TFloatField
      DisplayLabel = 'Allowance Amt'
      DisplayWidth = 10
      FieldName = 'AllowanceAmount'
      currency = True
    end
    object qryPayTaxConfigPrimaryTax: TWideStringField
      DisplayLabel = 'Primary'
      DisplayWidth = 1
      FieldName = 'PrimaryTax'
      FixedChar = True
      Size = 1
    end
    object qryPayTaxConfigRoundTax: TWideStringField
      DisplayLabel = 'Round'
      DisplayWidth = 1
      FieldName = 'RoundTax'
      FixedChar = True
      Size = 1
    end
    object qryPayTaxConfigActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryPayTaxConfigExpenseAccountId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ExpenseAccountId'
      Visible = False
    end
    object qryPayTaxConfigLiabilityAccountId: TIntegerField
      DisplayWidth = 10
      FieldName = 'LiabilityAccountId'
      Visible = False
    end
    object qryPayTaxConfigmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Visible = False
    end
    object qryPayTaxConfigmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Visible = False
      Size = 3
    end
    object qryPayTaxConfigGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryPayTaxConfigID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ID'
      Visible = False
    end
    object qryPayTaxConfigRegionId: TIntegerField
      DisplayWidth = 10
      FieldName = 'RegionId'
      Visible = False
    end
  end
  object dsPayTaxConfig: TDataSource
    DataSet = qryPayTaxConfig
    Left = 952
    Top = 104
  end
  object dsTaxable: TDataSource
    DataSet = qryTaxable
    Left = 639
    Top = 546
  end
  object qryTaxable: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PayPeriod, A, B, C FROM tblTaxable')
    Left = 552
    Top = 544
    object qryTaxablePayPeriod: TWideStringField
      DisplayWidth = 24
      FieldName = 'PayPeriod'
      Origin = 'tbltaxable.PayPeriod'
      FixedChar = True
      Size = 12
    end
    object qryTaxableA: TFloatField
      DisplayWidth = 10
      FieldName = 'A'
      Origin = 'tbltaxable.A'
    end
    object qryTaxableB: TFloatField
      DisplayWidth = 10
      FieldName = 'B'
      Origin = 'tbltaxable.B'
    end
    object qryTaxableC: TFloatField
      DisplayWidth = 10
      FieldName = 'C'
      Origin = 'tbltaxable.C'
    end
  end
end
