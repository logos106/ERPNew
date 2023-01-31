inherited PayrollPrefsUSGUI: TPayrollPrefsUSGUI
  Left = 674
  Top = 46
  VertScrollBar.Tracking = True
  Caption = 'Payroll Preferences'
  ClientHeight = 913
  ClientWidth = 1144
  OldCreateOrder = True
  ExplicitWidth = 1160
  ExplicitHeight = 951
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 913
    Width = 1144
    ExplicitTop = 913
    ExplicitWidth = 1144
  end
  object lblWidth: TLabel [1]
    Left = 23
    Top = 8
    Width = 863
    Height = 22
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
  object DNMPanel5: TDNMPanel [4]
    Left = 16
    Top = 1344
    Width = 545
    Height = 105
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      545
      105)
    object Bevel5: TBevel
      Left = 8
      Top = 8
      Width = 529
      Height = 89
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object Label65: TLabel
      Left = 14
      Top = 14
      Width = 97
      Height = 15
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
      Caption = 'Payroll Clearing Account '
      Transparent = True
    end
    object Label34: TLabel
      Left = 176
      Top = 59
      Width = 352
      Height = 15
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
  object pnlExpenseAccounts: TDNMPanel [5]
    Left = 575
    Top = 45
    Width = 545
    Height = 309
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object Bevel6: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 531
      Height = 295
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Shape = bsFrame
      ExplicitLeft = 8
      ExplicitTop = 9
      ExplicitWidth = 529
      ExplicitHeight = 347
    end
    object Bevel14: TBevel
      Left = 190
      Top = 188
      Width = 339
      Height = 73
      Shape = bsFrame
    end
    object Label37: TLabel
      Left = 14
      Top = 14
      Width = 106
      Height = 15
      Caption = 'Expense Accounts'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label39: TLabel
      Left = 24
      Top = 38
      Width = 77
      Height = 15
      Caption = 'Gross Wages'
      Transparent = True
    end
    object Label41: TLabel
      Left = 368
      Top = 88
      Width = 62
      Height = 15
      Caption = 'Leave Paid'
      Transparent = True
    end
    object Label46: TLabel
      Left = 196
      Top = 138
      Width = 113
      Height = 15
      Caption = 'Social Security Paid'
      Transparent = True
    end
    object Label47: TLabel
      Left = 24
      Top = 188
      Width = 115
      Height = 15
      Caption = 'Deductions (Default)'
      Transparent = True
    end
    object Label48: TLabel
      Left = 22
      Top = 239
      Width = 51
      Height = 15
      Caption = 'Sundries'
      Transparent = True
    end
    object Label62: TLabel
      Left = 24
      Top = 138
      Width = 117
      Height = 15
      Caption = 'Allowances (Default)'
      Transparent = True
    end
    object Label123: TLabel
      Left = 24
      Top = 88
      Width = 142
      Height = 15
      Caption = 'Fed Withholding Expense'
      Transparent = True
    end
    object Label122: TLabel
      Left = 196
      Top = 38
      Width = 62
      Height = 15
      Caption = 'Net Wages'
      Transparent = True
    end
    object Label133: TLabel
      Left = 368
      Top = 38
      Width = 78
      Height = 15
      Caption = 'Commissions'
      Transparent = True
    end
    object Label23: TLabel
      Left = 196
      Top = 88
      Width = 152
      Height = 15
      Caption = 'State Withholding Expense'
      Transparent = True
    end
    object Label68: TLabel
      Left = 368
      Top = 138
      Width = 81
      Height = 15
      Caption = 'Medicare Paid'
      Transparent = True
    end
    object Label77: TLabel
      Left = 196
      Top = 210
      Width = 131
      Height = 15
      Caption = 'Co Social Security Paid'
      Transparent = True
    end
    object Label78: TLabel
      Left = 364
      Top = 210
      Width = 99
      Height = 15
      Caption = 'Co Medicare Paid'
      Transparent = True
    end
    object Label80: TLabel
      Left = 201
      Top = 191
      Width = 53
      Height = 15
      Caption = 'Company'
      Transparent = True
    end
    object cboGrossWages: TwwDBLookupCombo
      Left = 24
      Top = 56
      Width = 160
      Height = 23
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
      AllowClearKey = True
    end
    object cboLeavePaidAccount: TwwDBLookupCombo
      Left = 368
      Top = 106
      Width = 160
      Height = 23
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
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object cboSocialSecurityPaidAccount: TwwDBLookupCombo
      Left = 196
      Top = 156
      Width = 160
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'30'#9'Account Name'#9'T'
        'Type'#9'20'#9'Type'#9'T')
      DataField = 'SocialSecurityPaidAccountId'
      DataSource = dsPrefs
      LookupTable = qryAccount
      LookupField = 'AccountID'
      Options = [loColLines]
      ParentFont = False
      TabOrder = 5
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object cboDeductionAccount: TwwDBLookupCombo
      Left = 24
      Top = 206
      Width = 160
      Height = 23
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
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object cboSundriesAccount: TwwDBLookupCombo
      Left = 22
      Top = 257
      Width = 160
      Height = 23
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
      TabOrder = 7
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboAllowanceAccount: TwwDBLookupCombo
      Left = 24
      Top = 156
      Width = 160
      Height = 23
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
      TabOrder = 4
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object cboNetWages: TwwDBLookupCombo
      Left = 196
      Top = 56
      Width = 160
      Height = 23
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
      TabOrder = 3
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object cboFedWithholdingExpence: TwwDBLookupCombo
      Left = 24
      Top = 106
      Width = 160
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'30'#9'Account Name'#9'T'
        'Type'#9'20'#9'Type'#9'T')
      DataField = 'PAYGExpenseAccountID'
      DataSource = dsPrefs
      LookupTable = qryAccount
      LookupField = 'AccountID'
      ParentFont = False
      TabOrder = 6
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object cboCommissionAccount: TwwDBLookupCombo
      Left = 368
      Top = 56
      Width = 160
      Height = 23
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
      TabOrder = 8
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object cboStateWithholdingExpenses: TwwDBLookupCombo
      Left = 196
      Top = 106
      Width = 160
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'30'#9'Account Name'#9'T'
        'Type'#9'20'#9'Type'#9'T')
      DataField = 'StateWithholdingTaxPaidAccountId'
      DataSource = dsPrefs
      LookupTable = qryAccount
      LookupField = 'AccountID'
      ParentFont = False
      TabOrder = 9
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object cboMedicarePaid: TwwDBLookupCombo
      Left = 368
      Top = 156
      Width = 160
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'30'#9'Account Name'#9'T'
        'Type'#9'20'#9'Type'#9'T')
      DataField = 'MedicarePaidAccountId'
      DataSource = dsPrefs
      LookupTable = qryAccount
      LookupField = 'AccountID'
      Options = [loColLines]
      ParentFont = False
      TabOrder = 10
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object cboSocialSecurityPaidCompanyAccount: TwwDBLookupCombo
      Left = 196
      Top = 228
      Width = 156
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'30'#9'Account Name'#9'T'
        'Type'#9'20'#9'Type'#9'T')
      DataField = 'SocialSecurityPaidCompanyAccountId'
      DataSource = dsPrefs
      LookupTable = qryAccount
      LookupField = 'AccountID'
      Options = [loColLines]
      ParentFont = False
      TabOrder = 11
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object cboMedicarePaidCompany: TwwDBLookupCombo
      Left = 364
      Top = 228
      Width = 156
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'30'#9'Account Name'#9'T'
        'Type'#9'20'#9'Type'#9'T')
      DataField = 'MedicarePaidCompanyAccountId'
      DataSource = dsPrefs
      LookupTable = qryAccount
      LookupField = 'AccountID'
      Options = [loColLines]
      ParentFont = False
      TabOrder = 12
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
  end
  object pnlLeaveAccrual: TDNMPanel [6]
    Left = 24
    Top = 74
    Width = 545
    Height = 378
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Bevel1: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 531
      Height = 364
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Shape = bsFrame
      ExplicitLeft = 8
      ExplicitTop = 8
      ExplicitWidth = 529
      ExplicitHeight = 362
    end
    object Label1: TLabel
      Left = 14
      Top = 14
      Width = 81
      Height = 15
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
      Left = 208
      Top = 64
      Width = 160
      Height = 15
      Caption = 'Accrue During Annual Leave'
      Transparent = True
    end
    object Label3: TLabel
      Left = 208
      Top = 96
      Width = 146
      Height = 15
      Caption = 'Accrue During Sick Leave'
      Transparent = True
    end
    object Label4: TLabel
      Left = 208
      Top = 128
      Width = 160
      Height = 15
      Caption = 'Accrue During Unpaid Leave'
      Transparent = True
    end
    object Label7: TLabel
      Left = 95
      Top = 189
      Width = 208
      Height = 15
      Caption = 'Show Accrued Annual Leave Liability'
      Transparent = True
    end
    object Label5: TLabel
      Left = 95
      Top = 215
      Width = 194
      Height = 15
      Caption = 'Show Accrued Sick Leave Liability'
      Transparent = True
    end
    object Label6: TLabel
      Left = 24
      Top = 40
      Width = 113
      Height = 15
      HelpContext = 414010
      Caption = 'Special Leave / RDO'
      Transparent = True
    end
    object Label8: TLabel
      Left = 152
      Top = 40
      Width = 86
      Height = 15
      Caption = 'All Other Leave'
      Transparent = True
    end
    object Bevel9: TBevel
      Left = 24
      Top = 87
      Width = 393
      Height = 9
      Shape = bsTopLine
    end
    object Bevel10: TBevel
      Left = 24
      Top = 119
      Width = 393
      Height = 9
      Shape = bsTopLine
    end
    object Bevel11: TBevel
      Left = 24
      Top = 151
      Width = 393
      Height = 9
      Shape = bsTopLine
    end
    object Label113: TLabel
      Left = 95
      Top = 241
      Width = 243
      Height = 15
      Caption = 'Show Accrued Long Service Leave Liability'
      Transparent = True
    end
    object Bevel20: TBevel
      Left = 24
      Top = 155
      Width = 393
      Height = 5
      Shape = bsTopLine
    end
    object Label114: TLabel
      Left = 14
      Top = 165
      Width = 82
      Height = 15
      Caption = 'Balance Sheet'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Bevel21: TBevel
      Left = 21
      Top = 269
      Width = 393
      Height = 9
      Shape = bsTopLine
    end
    object Bevel22: TBevel
      Left = 21
      Top = 273
      Width = 393
      Height = 5
      Shape = bsTopLine
    end
    object Label115: TLabel
      Left = 14
      Top = 276
      Width = 42
      Height = 15
      Caption = 'PaySlip'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label116: TLabel
      Left = 95
      Top = 347
      Width = 197
      Height = 15
      Caption = 'Show Accrued Long Service Leave'
      Transparent = True
    end
    object Label117: TLabel
      Left = 95
      Top = 321
      Width = 148
      Height = 15
      Caption = 'Show Accrued Sick Leave'
      Transparent = True
    end
    object Label118: TLabel
      Left = 95
      Top = 295
      Width = 162
      Height = 15
      Caption = 'Show Accrued Annual Leave'
      Transparent = True
    end
    object wwCheckBox1: TwwCheckBox
      Left = 72
      Top = 64
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'RDOAccrueDuringAL'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 0
    end
    object wwCheckBox2: TwwCheckBox
      Left = 72
      Top = 96
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'RDOAccrueDuringSick'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 1
    end
    object wwCheckBox3: TwwCheckBox
      Left = 72
      Top = 128
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'RDOAccrueDuringUL'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 2
    end
    object wwCheckBox6: TwwCheckBox
      Left = 184
      Top = 128
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'LeaveAccrueDuringUL'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 3
    end
    object wwCheckBox4: TwwCheckBox
      Left = 184
      Top = 64
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'LeaveAccrueDuringAL'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 4
    end
    object wwCheckBox5: TwwCheckBox
      Left = 184
      Top = 96
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'LeaveAccrueDuringSick'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 5
    end
    object wwCheckBox7: TwwCheckBox
      Left = 71
      Top = 189
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'ShowAccruedAnnualLeaveLiability'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 6
    end
    object wwCheckBox8: TwwCheckBox
      Left = 71
      Top = 214
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      DataField = 'ShowAccruedSickLeaveLiability'
      DataSource = dsPrefs
      TabOrder = 7
    end
    object wwCheckBox27: TwwCheckBox
      Left = 71
      Top = 240
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      DataField = 'ShowAccruedLongServiceLeaveLiability'
      DataSource = dsPrefs
      TabOrder = 8
    end
    object wwCheckBox28: TwwCheckBox
      Left = 71
      Top = 346
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      DataField = 'ShowAccruedLongServiceLeavePaySlip'
      DataSource = dsPrefs
      TabOrder = 9
    end
    object wwCheckBox29: TwwCheckBox
      Left = 71
      Top = 320
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      DataField = 'ShowAccruedSickLeavePaySlip'
      DataSource = dsPrefs
      TabOrder = 10
    end
    object wwCheckBox30: TwwCheckBox
      Left = 71
      Top = 295
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'ShowAccruedAnnualLeavePaySlip'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 11
    end
  end
  object pnlGeneral: TDNMPanel [7]
    Left = 493
    Top = 15
    Width = 545
    Height = 352
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Bevel4: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 531
      Height = 338
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
      Left = 38
      Top = 36
      Width = 200
      Height = 15
      Alignment = taRightJustify
      Caption = 'Standard Hours Worked Per Period'
      Transparent = True
    end
    object Label20: TLabel
      Left = 68
      Top = 67
      Width = 170
      Height = 15
      Alignment = taRightJustify
      Caption = 'Annual Leave Weeks Per Year'
      Transparent = True
    end
    object Label24: TLabel
      Left = 66
      Top = 99
      Width = 172
      Height = 15
      Alignment = taRightJustify
      Caption = 'Sick Leave Days Per Year Cap '
      Transparent = True
    end
    object Label25: TLabel
      Left = 25
      Top = 131
      Width = 213
      Height = 15
      Alignment = taRightJustify
      Caption = 'Long Service Leave Periods Per Term'
      Transparent = True
    end
    object Label26: TLabel
      Left = 52
      Top = 163
      Width = 186
      Height = 15
      Alignment = taRightJustify
      Caption = 'Long Service Leave Term (years)'
      Transparent = True
    end
    object Label27: TLabel
      Left = 73
      Top = 195
      Width = 165
      Height = 15
      Alignment = taRightJustify
      Caption = 'Leave Loading Tax Threshold'
      Transparent = True
    end
    object Label32: TLabel
      Left = 352
      Top = 36
      Width = 107
      Height = 15
      Caption = 'Pay by Department'
      Transparent = True
    end
    object Label33: TLabel
      Left = 352
      Top = 67
      Width = 125
      Height = 15
      Caption = 'Add to E.F.T. by Default'
      Transparent = True
    end
    object Label67: TLabel
      Left = 352
      Top = 99
      Width = 164
      Height = 15
      Caption = 'Include pays with $0 pay rate'
      Transparent = True
    end
    object Label69: TLabel
      Left = 76
      Top = 227
      Width = 162
      Height = 15
      Alignment = taRightJustify
      Caption = 'Fedaral Pay Allowance Value'
      Transparent = True
    end
    object Label81: TLabel
      Left = 151
      Top = 314
      Width = 87
      Height = 15
      Alignment = taRightJustify
      Caption = 'State Tax Label'
      Transparent = True
    end
    object Label82: TLabel
      Left = 88
      Top = 256
      Width = 150
      Height = 15
      Alignment = taRightJustify
      Caption = 'State Pay Allowance Value'
      Transparent = True
    end
    object Label83: TLabel
      Left = 139
      Top = 285
      Width = 99
      Height = 15
      Alignment = taRightJustify
      Caption = 'Federal Tax Label'
      Transparent = True
    end
    object edtHoursPerWeek: TwwDBEdit
      Left = 247
      Top = 32
      Width = 49
      Height = 23
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
      Left = 247
      Top = 63
      Width = 49
      Height = 23
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
      Left = 247
      Top = 95
      Width = 49
      Height = 23
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
      Left = 247
      Top = 127
      Width = 49
      Height = 23
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
      Left = 247
      Top = 159
      Width = 49
      Height = 23
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
      Left = 247
      Top = 191
      Width = 49
      Height = 23
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
      Top = 35
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      DataField = 'PayByDepartment'
      DataSource = dsPrefs
      TabOrder = 6
    end
    object wwCheckBox17: TwwCheckBox
      Left = 328
      Top = 66
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      DataField = 'AddToEFT'
      DataSource = dsPrefs
      TabOrder = 7
    end
    object btnImportTaxScales: TDNMSpeedButton
      Left = 327
      Top = 126
      Width = 138
      Height = 25
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
      OnClick = btnImportTaxScalesClick
    end
    object wwCheckBox21: TwwCheckBox
      Left = 328
      Top = 98
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'IncZeroPayRates'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 9
    end
    object Panel1: TPanel
      Left = 436
      Top = 42
      Width = 257
      Height = 137
      BevelInner = bvRaised
      BorderStyle = bsSingle
      Color = clBlue
      TabOrder = 10
      Visible = False
      object Label124: TLabel
        Left = 2
        Top = 122
        Width = 249
        Height = 15
        Align = alTop
        ExplicitWidth = 3
      end
      object Label125: TLabel
        Left = 2
        Top = 62
        Width = 249
        Height = 15
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
      object Label126: TLabel
        Left = 2
        Top = 47
        Width = 249
        Height = 15
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
      object Label127: TLabel
        Left = 2
        Top = 32
        Width = 249
        Height = 15
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
      object Label128: TLabel
        Left = 2
        Top = 17
        Width = 249
        Height = 15
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
      object Label129: TLabel
        Left = 2
        Top = 2
        Width = 249
        Height = 15
        Align = alTop
        Caption = 'To encrypt the Tax Scale File'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        ExplicitTop = 3
      end
      object Label130: TLabel
        Left = 2
        Top = 107
        Width = 249
        Height = 15
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
      object Label131: TLabel
        Left = 2
        Top = 92
        Width = 249
        Height = 15
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
      object Label132: TLabel
        Left = 2
        Top = 77
        Width = 249
        Height = 15
        Align = alTop
        ExplicitWidth = 3
      end
    end
    object edtPayAllowanceAmount: TDBAdvEdit
      Left = 247
      Top = 223
      Width = 49
      Height = 23
      EditType = etMoney
      Precision = 2
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
      TabOrder = 11
      Text = '0.00'
      Visible = True
      Version = '2.8.6.9'
      DataField = 'USPayAllowanceAmount'
      DataSource = dsPrefs
    end
    object edtUSStateTaxLabel: TDBAdvEdit
      Left = 247
      Top = 310
      Width = 218
      Height = 23
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
      TabOrder = 12
      Text = 'edtUSStateTaxLabel'
      Visible = True
      Version = '2.8.6.9'
      DataField = 'USStateTaxLabel'
      DataSource = dsPrefs
    end
    object edtUSPayAllowanceStateAmount: TDBAdvEdit
      Left = 247
      Top = 252
      Width = 49
      Height = 23
      EditType = etMoney
      Precision = 2
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
      TabOrder = 13
      Text = '0.00'
      Visible = True
      Version = '2.8.6.9'
      DataField = 'USPayAllowanceStateAmount'
      DataSource = dsPrefs
    end
    object DBAdvEdit1: TDBAdvEdit
      Left = 247
      Top = 281
      Width = 218
      Height = 23
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
      TabOrder = 14
      Text = 'edtUSStateTaxLabel'
      Visible = True
      Version = '2.8.6.9'
      DataField = 'USFedTaxLabel'
      DataSource = dsPrefs
    end
  end
  object pnlTaxRounding: TDNMPanel [8]
    Left = 609
    Top = 356
    Width = 545
    Height = 153
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object Bevel12: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 531
      Height = 139
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Shape = bsFrame
      ExplicitLeft = 8
      ExplicitTop = 8
      ExplicitWidth = 478
      ExplicitHeight = 141
    end
    object Label70: TLabel
      Left = 14
      Top = 14
      Width = 76
      Height = 15
      Caption = 'Tax Rounding'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label71: TLabel
      Left = 55
      Top = 42
      Width = 190
      Height = 15
      Caption = 'Round Federal Tax to whole dollar'
      Transparent = True
    end
    object Label72: TLabel
      Left = 55
      Top = 67
      Width = 178
      Height = 15
      Caption = 'Round State Tax to whole dollar'
      Transparent = True
    end
    object Label73: TLabel
      Left = 54
      Top = 92
      Width = 233
      Height = 15
      Caption = 'Round Social Security Tax to whole dollar'
      Transparent = True
    end
    object Label74: TLabel
      Left = 54
      Top = 117
      Width = 201
      Height = 15
      Caption = 'Round Medicare Tax to whole dollar'
      Transparent = True
    end
    object chkUSRoundFedTax: TwwCheckBox
      Left = 33
      Top = 41
      Width = 16
      Height = 17
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
      DataField = 'USRoundFedTax'
      DataSource = dsPrefs
      TabOrder = 0
    end
    object chkUSRoundStateTax: TwwCheckBox
      Left = 33
      Top = 66
      Width = 16
      Height = 17
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
      DataField = 'USRoundStateTax'
      DataSource = dsPrefs
      TabOrder = 1
    end
    object chkUSRoundSocialSecurityTax: TwwCheckBox
      Left = 32
      Top = 91
      Width = 16
      Height = 17
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
      DataField = 'USRoundSocialSecurityTax'
      DataSource = dsPrefs
      TabOrder = 2
    end
    object chkUSRoundMedicareTax: TwwCheckBox
      Left = 32
      Top = 116
      Width = 16
      Height = 17
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
      DataField = 'USRoundMedicareTax'
      DataSource = dsPrefs
      TabOrder = 3
    end
  end
  object pnlLiabilityAccounts: TDNMPanel [9]
    Left = 571
    Top = 519
    Width = 545
    Height = 283
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object Bevel7: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 531
      Height = 269
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Shape = bsFrame
      ExplicitLeft = 8
      ExplicitTop = 8
      ExplicitWidth = 529
      ExplicitHeight = 184
    end
    object Bevel13: TBevel
      Left = 21
      Top = 192
      Width = 352
      Height = 73
      Shape = bsFrame
    end
    object Label49: TLabel
      Left = 14
      Top = 14
      Width = 100
      Height = 15
      Caption = 'Liability Accounts'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label50: TLabel
      Left = 24
      Top = 144
      Width = 110
      Height = 15
      Caption = 'Deductions Liability'
      Transparent = True
    end
    object Label51: TLabel
      Left = 368
      Top = 40
      Width = 80
      Height = 15
      Caption = 'Leave Liability'
      Transparent = True
    end
    object Label52: TLabel
      Left = 190
      Top = 41
      Width = 148
      Height = 15
      Caption = 'State Withholding Payable'
      Transparent = True
    end
    object Label53: TLabel
      Left = 24
      Top = 40
      Width = 138
      Height = 15
      Caption = 'Fed Withholding Payable'
      Transparent = True
    end
    object Label111: TLabel
      Left = 24
      Top = 92
      Width = 112
      Height = 15
      Caption = 'Allowances Liability'
      Transparent = True
    end
    object Label21: TLabel
      Left = 196
      Top = 92
      Width = 133
      Height = 15
      Caption = 'Social Security Payable'
      Transparent = True
    end
    object Label22: TLabel
      Left = 368
      Top = 92
      Width = 101
      Height = 15
      Caption = 'Medicare Payable'
      Transparent = True
    end
    object Label75: TLabel
      Left = 32
      Top = 216
      Width = 151
      Height = 15
      Caption = 'Co Social Security Payable'
      Transparent = True
    end
    object Label76: TLabel
      Left = 204
      Top = 216
      Width = 119
      Height = 15
      Caption = 'Co Medicare Payable'
      Transparent = True
    end
    object Label79: TLabel
      Left = 32
      Top = 195
      Width = 53
      Height = 15
      Caption = 'Company'
      Transparent = True
    end
    object cboDeductionsLiability: TwwDBLookupCombo
      Left = 24
      Top = 160
      Width = 160
      Height = 23
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
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object cboLeaveLiability: TwwDBLookupCombo
      Left = 368
      Top = 56
      Width = 160
      Height = 23
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
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object cboStateWithholdingTaxPayable: TwwDBLookupCombo
      Left = 196
      Top = 56
      Width = 160
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'30'#9'Account Name'#9'T'
        'Type'#9'20'#9'Type'#9'T')
      DataField = 'StateWithholdingTaxPayableAccountId'
      DataSource = dsPrefs
      LookupTable = qryAccount
      LookupField = 'AccountID'
      Options = [loColLines]
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object cboFedWithholdingTaxPayable: TwwDBLookupCombo
      Left = 24
      Top = 56
      Width = 160
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'30'#9'Account Name'#9'T'
        'Type'#9'20'#9'Type'#9'T')
      DataField = 'PAYGTaxPayableAccountID'
      DataSource = dsPrefs
      LookupTable = qryAccount
      LookupField = 'AccountID'
      Options = [loColLines]
      ParentFont = False
      TabOrder = 4
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object cboAllowancesLiability: TwwDBLookupCombo
      Left = 24
      Top = 108
      Width = 160
      Height = 23
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
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object cboSocialSecurityPayable: TwwDBLookupCombo
      Left = 196
      Top = 108
      Width = 160
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'30'#9'Account Name'#9'T'
        'Type'#9'20'#9'Type'#9'T')
      DataField = 'SocialSecurityPayableAccountId'
      DataSource = dsPrefs
      LookupTable = qryAccount
      LookupField = 'AccountID'
      Options = [loColLines]
      ParentFont = False
      TabOrder = 5
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object cboMedicarePayable: TwwDBLookupCombo
      Left = 368
      Top = 108
      Width = 160
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'30'#9'Account Name'#9'T'
        'Type'#9'20'#9'Type'#9'T')
      DataField = 'MedicarePayableAccountId'
      DataSource = dsPrefs
      LookupTable = qryAccount
      LookupField = 'AccountID'
      Options = [loColLines]
      ParentFont = False
      TabOrder = 6
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object cboSocialSecurityCompanyPayable: TwwDBLookupCombo
      Left = 32
      Top = 232
      Width = 160
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'30'#9'Account Name'#9'T'
        'Type'#9'20'#9'Type'#9'T')
      DataField = 'SocialSecurityPayableCompanyAccountId'
      DataSource = dsPrefs
      LookupTable = qryAccount
      LookupField = 'AccountID'
      Options = [loColLines]
      ParentFont = False
      TabOrder = 7
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object cboMedicarePayableCompany: TwwDBLookupCombo
      Left = 204
      Top = 232
      Width = 160
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'30'#9'Account Name'#9'T'
        'Type'#9'20'#9'Type'#9'T')
      DataField = 'MedicarePayableCompanyAccountId'
      DataSource = dsPrefs
      LookupTable = qryAccount
      LookupField = 'AccountID'
      Options = [loColLines]
      ParentFont = False
      TabOrder = 8
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
  end
  object DNMPanel1: TDNMPanel [10]
    Left = 24
    Top = 226
    Width = 545
    Height = 518
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    Visible = False
    object Label28: TLabel
      Left = 35
      Top = 35
      Width = 111
      Height = 15
      Caption = 'Medicare Levy Rate'
      Transparent = True
    end
    object lblIgnore1: TLabel
      Left = 313
      Top = 24
      Width = 9
      Height = 15
      Caption = '%'
      Transparent = True
    end
    object Label29: TLabel
      Left = 35
      Top = 67
      Width = 174
      Height = 15
      Caption = 'Medicare Levy Surcharge Rate'
      Transparent = True
    end
    object lblIgnore2: TLabel
      Left = 313
      Top = 56
      Width = 9
      Height = 15
      Caption = '%'
      Transparent = True
    end
    object Label30: TLabel
      Left = 35
      Top = 98
      Width = 171
      Height = 15
      Caption = 'Base Tax Rate for Lump Sums'
      Transparent = True
    end
    object lblIgnore3: TLabel
      Left = 313
      Top = 88
      Width = 9
      Height = 15
      Caption = '%'
      Transparent = True
    end
    object Label31: TLabel
      Left = 35
      Top = 130
      Width = 202
      Height = 15
      Caption = 'Lump Sum Flat Tax Rate for Over 55'
      Transparent = True
    end
    object lblIgnore4: TLabel
      Left = 313
      Top = 120
      Width = 9
      Height = 15
      Caption = '%'
      Transparent = True
    end
    object Label36: TLabel
      Left = 35
      Top = 162
      Width = 181
      Height = 15
      Caption = 'Lump Sum E / Backpay Tax Rate'
      Transparent = True
    end
    object lblIgnore5: TLabel
      Left = 313
      Top = 151
      Width = 9
      Height = 15
      Caption = '%'
      Transparent = True
    end
    object Label38: TLabel
      Left = 35
      Top = 194
      Width = 137
      Height = 15
      Caption = 'Fringe Benefits Tax Rate'
      Transparent = True
    end
    object lblIgnore6: TLabel
      Left = 313
      Top = 183
      Width = 9
      Height = 15
      Caption = '%'
      Transparent = True
    end
    object Label40: TLabel
      Left = 35
      Top = 226
      Width = 91
      Height = 15
      Caption = 'No TFN Tax Rate'
      Transparent = True
    end
    object lblIgnore7: TLabel
      Left = 313
      Top = 215
      Width = 9
      Height = 15
      Caption = '%'
      Transparent = True
    end
    object Label42: TLabel
      Left = 35
      Top = 247
      Width = 191
      Height = 15
      Caption = 'Threshold Limit for RBL Purposes'
      Transparent = True
    end
    object Label43: TLabel
      Left = 35
      Top = 268
      Width = 210
      Height = 15
      Caption = 'Lump Sum D (Basic Tax Free Portion)'
      Transparent = True
    end
    object Label45: TLabel
      Left = 35
      Top = 311
      Width = 196
      Height = 15
      Caption = 'ETP Low Rate Threshold (per year)'
      Transparent = True
    end
    object Label112: TLabel
      Left = 41
      Top = 400
      Width = 162
      Height = 15
      Caption = 'Default Superannuation Rate'
      Transparent = True
    end
    object Label120: TLabel
      Left = 355
      Top = 343
      Width = 9
      Height = 15
      Caption = '%'
      Transparent = True
    end
    object Label119: TLabel
      Left = 41
      Top = 343
      Width = 215
      Height = 15
      Caption = 'Pay Super if Monthly Gross More Than'
      Transparent = True
    end
    object Label44: TLabel
      Left = 49
      Top = 432
      Width = 132
      Height = 15
      Caption = '(Yearly tax free portion)'
      Transparent = True
    end
    object Label121: TLabel
      Left = 49
      Top = 470
      Width = 164
      Height = 15
      Caption = 'Workers Compensation Rate'
    end
    object Bevel15: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 531
      Height = 504
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Shape = bsFrame
      ExplicitLeft = 5
      ExplicitTop = 9
    end
    object wwDBEdit7: TwwDBEdit
      Left = 259
      Top = 14
      Width = 49
      Height = 23
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
      Left = 259
      Top = 45
      Width = 49
      Height = 23
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
      Left = 259
      Top = 77
      Width = 49
      Height = 23
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
      Left = 259
      Top = 109
      Width = 49
      Height = 23
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
      Left = 259
      Top = 141
      Width = 49
      Height = 23
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
      Left = 259
      Top = 173
      Width = 49
      Height = 23
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
      Left = 259
      Top = 205
      Width = 49
      Height = 23
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
      Left = 259
      Top = 236
      Width = 92
      Height = 23
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
      Left = 267
      Top = 276
      Width = 92
      Height = 23
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
    object wwDBEdit17: TwwDBEdit
      Left = 259
      Top = 307
      Width = 92
      Height = 23
      DataField = 'YearlyIncomeThreshold'
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
    object wwDBEdit20: TwwDBEdit
      Left = 257
      Top = 352
      Width = 92
      Height = 23
      DataField = 'DefaultSuperRate'
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
    object wwDBEdit46: TwwDBEdit
      Left = 259
      Top = 392
      Width = 92
      Height = 23
      DataField = 'SuperOverGross'
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
    object wwDBEdit16: TwwDBEdit
      Left = 273
      Top = 429
      Width = 92
      Height = 23
      DataField = 'LumpDYearlyTaxFree'
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
    object wwDBEdit47: TwwDBEdit
      Left = 273
      Top = 463
      Width = 92
      Height = 23
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
  end
  object pnlLoadFromRoster: TDNMPanel [11]
    Left = 24
    Top = 268
    Width = 545
    Height = 112
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Bevel3: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 531
      Height = 98
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
      Caption = 'Load Hours From Roster'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label15: TLabel
      Left = 48
      Top = 40
      Width = 108
      Height = 15
      Caption = 'Use Clocked Hours'
      Transparent = True
    end
    object Label16: TLabel
      Left = 48
      Top = 72
      Width = 98
      Height = 15
      Caption = 'Ignore Early Start'
      Transparent = True
    end
    object Label17: TLabel
      Left = 256
      Top = 40
      Width = 100
      Height = 15
      Caption = 'Ignore Late Finish'
      Transparent = True
    end
    object wwCheckBox12: TwwCheckBox
      Left = 24
      Top = 40
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'UseClockedHrs'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 0
    end
    object wwCheckBox14: TwwCheckBox
      Left = 24
      Top = 72
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'IgnoreEarlyStart'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 1
    end
    object wwCheckBox15: TwwCheckBox
      Left = 232
      Top = 40
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'IgnoreLateFinish'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 2
    end
  end
  object pnlJobs: TDNMPanel [12]
    Left = 24
    Top = 307
    Width = 545
    Height = 184
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    object Bevel2: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 531
      Height = 170
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
      Caption = 'Jobs / Timesheet'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label10: TLabel
      Left = 48
      Top = 48
      Width = 319
      Height = 15
      Caption = 'Use Employee Service as Employee Cost in Job Tracking'
      Transparent = True
    end
    object Label11: TLabel
      Left = 48
      Top = 80
      Width = 344
      Height = 15
      Caption = 'Timesheets are allocated as done when applied to an invoice'
      Transparent = True
    end
    object Label12: TLabel
      Left = 48
      Top = 112
      Width = 348
      Height = 15
      Caption = 'Summarise Timesheet Entries when applying cost to Invoices'
      Transparent = True
    end
    object Label14: TLabel
      Left = 48
      Top = 144
      Width = 224
      Height = 15
      Caption = 'Use Timesheet Rate Inc As Invoice Cost'
      Transparent = True
    end
    object wwCheckBox9: TwwCheckBox
      Left = 24
      Top = 48
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      DataField = 'UseEmpServiceAsEmpCost'
      DataSource = dsPrefs
      TabOrder = 0
    end
    object wwCheckBox10: TwwCheckBox
      Left = 24
      Top = 80
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      DataField = 'TSDoneOnInvoice'
      DataSource = dsPrefs
      TabOrder = 1
    end
    object wwCheckBox11: TwwCheckBox
      Left = 24
      Top = 112
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      DataField = 'SummariseTSForInvoiceCost'
      DataSource = dsPrefs
      TabOrder = 2
    end
    object wwCheckBox13: TwwCheckBox
      Left = 24
      Top = 144
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      DataSource = dsPrefs
      TabOrder = 3
    end
  end
  object pnlSuper: TDNMPanel [13]
    Left = 24
    Top = 346
    Width = 545
    Height = 392
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    Visible = False
    object Bevel8: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 531
      Height = 378
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Shape = bsFrame
      ExplicitLeft = 8
      ExplicitTop = 8
      ExplicitWidth = 529
      ExplicitHeight = 377
    end
    object Label54: TLabel
      Left = 14
      Top = 14
      Width = 34
      Height = 15
      Caption = 'Super'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label55: TLabel
      Left = 48
      Top = 40
      Width = 291
      Height = 15
      Caption = 'Monthly Super Threshold On Permanent Employees'
      Transparent = True
    end
    object Label56: TLabel
      Left = 48
      Top = 72
      Width = 283
      Height = 15
      Caption = 'Monthly Super Threshold On Part Time Employees'
      Transparent = True
    end
    object Label57: TLabel
      Left = 48
      Top = 104
      Width = 267
      Height = 15
      Caption = 'Monthly Super Threshold On Casual Employees'
      Transparent = True
    end
    object Label58: TLabel
      Left = 48
      Top = 168
      Width = 246
      Height = 15
      Caption = 'Pay Super to those over the age of 70 years'
      Transparent = True
    end
    object Label59: TLabel
      Left = 48
      Top = 200
      Width = 299
      Height = 30
      Caption = 
        'Pay Super to Partime or Casuals under the age of 18 and who work' +
        ' less than 30 hours per week.'
      Transparent = True
      WordWrap = True
    end
    object Label60: TLabel
      Left = 24
      Top = 136
      Width = 215
      Height = 15
      Caption = 'Pay Super if Monthly Gross More Than'
      Transparent = True
    end
    object Label61: TLabel
      Left = 24
      Top = 248
      Width = 162
      Height = 15
      Caption = 'Default Superannuation Rate'
      Transparent = True
    end
    object Label63: TLabel
      Left = 48
      Top = 290
      Width = 244
      Height = 15
      Caption = 'Calculate SGC on Salary Sacrifice Amounts'
      Transparent = True
    end
    object Label64: TLabel
      Left = 48
      Top = 322
      Width = 255
      Height = 15
      Caption = 'Exclude Super from Work Cover Calculations'
      Transparent = True
    end
    object Label66: TLabel
      Left = 24
      Top = 354
      Width = 149
      Height = 15
      Caption = 'Employer SGC Percentage'
      Transparent = True
    end
    object lblIgnore8: TLabel
      Left = 262
      Top = 242
      Width = 9
      Height = 15
      Caption = '%'
      Transparent = True
    end
    object wwCheckBox22: TwwCheckBox
      Left = 24
      Top = 104
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'MonthSuperTCasual'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 0
    end
    object wwCheckBox23: TwwCheckBox
      Left = 24
      Top = 40
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'MonthSuperTPermanent'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 1
    end
    object wwCheckBox24: TwwCheckBox
      Left = 24
      Top = 72
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'MonthSuperTPartTime'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 2
    end
    object wwCheckBox25: TwwCheckBox
      Left = 24
      Top = 168
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      DataField = 'PaySuperToOver70'
      DataSource = dsPrefs
      TabOrder = 3
    end
    object wwCheckBox26: TwwCheckBox
      Left = 24
      Top = 200
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      DataField = 'PayUnder18'
      DataSource = dsPrefs
      TabOrder = 4
    end
    object wwDBEdit18: TwwDBEdit
      Left = 248
      Top = 132
      Width = 81
      Height = 23
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
    object wwDBEdit19: TwwDBEdit
      Left = 200
      Top = 238
      Width = 57
      Height = 23
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
      Top = 290
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      DataField = 'CalcSGCOnSS'
      DataSource = dsPrefs
      TabOrder = 7
    end
    object wwCheckBox20: TwwCheckBox
      Left = 24
      Top = 322
      Width = 16
      Height = 17
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
      Caption = 'wwCheckBox1'
      DataField = 'ExcludeSuperFromWC'
      DataSource = dsPrefs
      TabOrder = 8
    end
    object wwDBEdit21: TwwDBEdit
      Left = 192
      Top = 344
      Width = 57
      Height = 23
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
  object MyConnection: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    LoginPrompt = False
    Left = 904
    Top = 1
  end
  object dsPrefs: TDataSourcePrefs
    Connection = MyConnection
    FieldDefs = <>
    FieldNames.Strings = (
      'AddToEFT'
      'ALeaveWeeks'
      'AllowanceLiabilityAccountID'
      'AllowancePaidAccountID'
      'ARAccountID'
      'CalcSGCOnSS'
      'CommissionPaidAccountID'
      'DeductionLiabilityAccountID'
      'DeductionsPaidAccountID'
      'DefaultPaperID'
      'DefaultSuperRate'
      'EditedFlag'
      'EFTIncBalance'
      'EFTIncCredit'
      'EFTIncDebit'
      'EFTIncNet'
      'EmployerSGCPercent'
      'ExcludeSuperFromWC'
      'ExpensesAccountID'
      'FBTTaxRate'
      'GSTTaxRateWC'
      'HoursPerWeek'
      'IgnoreEarlyStart'
      'IgnoreLateFinish'
      'IncZeroPayRates'
      'LabourIncomeAccountID'
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
      'LumpSumETaxRate'
      'LumpSumTaxRate'
      'LumpSumTaxRateOver55'
      'MedicareLevyRate'
      'MedicareLevySurchargeRate'
      'MedicarePaidAccountId'
      'MedicarePaidCompanyAccountId'
      'MedicarePayableAccountId'
      'MedicarePayableCompanyAccountId'
      'MiningMinSuperHrs'
      'MonthSuperTCasual'
      'MonthSuperTPartTime'
      'MonthSuperTPermanent'
      'NetWagesAccountID'
      'NICsEmployeePaidAccountID'
      'NICsEmployeePayableAccountID'
      'NICsEmployerPaidAccountID'
      'NICsEmployerPayableAccountID'
      'NoABNAccountID'
      'NoABNExpenseAccountID'
      'NoTFNTaxRate'
      'PayByDepartment'
      'PAYGExpenseAccountID'
      'PAYGTaxPaidAccountID'
      'PAYGTaxPayableAccountID'
      'PayrollTaxPaidAccountID'
      'PayrollTaxPayableAccountID'
      'PaySlipType'
      'PaySummaryType'
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
      'SocialSecurityPaidAccountId'
      'SocialSecurityPaidCompanyAccountId'
      'SocialSecurityPayableAccountId'
      'SocialSecurityPayableCompanyAccountId'
      'StateWithholdingTaxPaidAccountId'
      'StateWithholdingTaxPayableAccountId'
      'SummariseTSForInvoiceCost'
      'SundriesPaidAccountID'
      'SuperOverGross'
      'SuperPaidAccountID'
      'SuperPayableAccountID'
      'TaxOnSuperWC'
      'TaxPaidIn'
      'TSDoneOnInvoice'
      'UKNICClass3Rate'
      'UKNICEarningsThreshold1'
      'UKNICEarningsThreshold1MTH'
      'UKNICEarningsThreshold1WK'
      'UKNICEarningsThreshold2'
      'UKNICEarningsThreshold2MTH'
      'UKNICEarningsThreshold2WK'
      'UKNICEmployeeClass1Rate2'
      'UKNICEmployeesClass1Rate1'
      'UKNICEmployeesContractedOutRebate'
      'UKNICEmployersClass1Rate1'
      'UKNICEmployersClass1Rate2'
      'UKNICEmployersContractedOutRebateM'
      'UKNICEmployersContractedOutRebateS'
      'UKNICLowerEarningsLimit'
      'UKNICLowerEarningsLimitMTH'
      'UKNICLowerEarningsLimitWK'
      'UKNICMarriedWomanClass1Rate1'
      'UKNICMarriedWomanClass1Rate2'
      'UKNICUpperEarningsLimit'
      'UKNICUpperEarningsLimitMTH'
      'UKNICUpperEarningsLimitWK'
      'UKStartFiscalYear'
      'UKTaxAllowance65-74'
      'UKTaxAllowance65-74Limit'
      'UKTaxAllowance75'
      'UKTaxAllowance75Limit'
      'UKTaxBasicAllowance'
      'UKTaxBasicAllowanceLimit'
      'UKTaxBasicRateDividend'
      'UKTaxBasicRateOther'
      'UKTaxBasicRateSavings'
      'UKTaxBasicRateUpperThreshold'
      'UKTaxEmergencyTaxCode'
      'UKTaxHigherRateDividend'
      'UKTaxHigherRateOther'
      'UKTaxHigherRateSavings'
      'UKTaxMaxRate'
      'UKTaxStartingRateDividend'
      'UKTaxStartingRateOther'
      'UKTaxStartingRateSavings'
      'UKTaxStartRateUpperThreshold'
      'UseClockedHrs'
      'UseEmpServiceAsEmpCost'
      'UseTimesheetRateIncAsInvoiceCost'
      'USFedTaxLabel'
      'USPayAllowanceAmount'
      'USPayAllowanceStateAmount'
      'USRoundFedTax'
      'USRoundMedicareTax'
      'USRoundSocialSecurityTax'
      'USRoundStateTax'
      'USStateTaxLabel'
      'WageAccountID'
      'WagesPaidAccountID'
      'WagesPayableAccountID'
      'WorkCoverPaidAccountID'
      'WorkCoverPayableAccountID'
      'WorkersCompPaidAccountID'
      'WorkersCompPayableAccountID'
      'WorkersCompRate'
      'YearlyIncomeThreshold')
    Left = 936
    Top = 1
  end
  object dsPersonalPreferences: TDataSource
    DataSet = qryPersonalPreferences
    Left = 968
    Top = 1
  end
  object qryPersonalPreferences: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblpersonalpreferences'
      'WHERE EmployeeID = :EmployeeID;')
    Left = 1000
    Top = 1
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
      
        'select 1 as Rank, 0 as AccountID,"N/A" as AccountName,null as Ac' +
        'countNumber ,0.00 as Balance, null as `Type` from dual'
      'union all'
      
        'SELECT 2 as Rank, a.AccountID, a.AccountName, a.AccountNumber, a' +
        '.Balance, AccDesc as Type'
      'FROM tblChartofAccounts a'
      'LEFT JOIN tblacctypedesc on  AccType = AccountType'
      'WHERE IsHeader = '#39'F'#39' AND Active = '#39'T'#39
      'ORDER BY Rank, `Type`, AccountName'
      ''
      '/*'
      'SELECT tblChartofAccounts.*, AccDesc as Type'
      'FROM tblChartofAccounts'
      'LEFT JOIN tblacctypedesc on  AccType = AccountType'
      'WHERE IsHeader = '#39'F'#39' AND Active = '#39'T'#39
      'ORDER BY AccDesc, AccountName;'
      '*/')
    Left = 1032
    Top = 1
  end
end
