inherited EmpAccounts: TEmpAccounts
  Caption = 'EmpAccounts'
  ClientHeight = 615
  ClientWidth = 922
  ExplicitWidth = 938
  ExplicitHeight = 653
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 615
    Width = 922
    ExplicitTop = 491
    ExplicitWidth = 748
  end
  object pnlMain: TDNMPanel [3]
    Left = 24
    Top = 2
    Width = 834
    Height = 434
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object DNMPanel5: TDNMPanel
      Left = 1
      Top = 6
      Width = 803
      Height = 95
      HelpContext = 414102
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        803
        95)
      object Bevel5: TBevel
        Left = 6
        Top = 8
        Width = 790
        Height = 79
        HelpContext = 414103
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitWidth = 806
      end
      object Label65: TLabel
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
        Left = 17
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
        Left = 17
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
        DataSource = dsPersonalPreferences
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
    object DNMPanel6: TDNMPanel
      Left = 1
      Top = 106
      Width = 803
      Height = 154
      HelpContext = 414107
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        803
        154)
      object Bevel6: TBevel
        Left = 6
        Top = 8
        Width = 790
        Height = 136
        HelpContext = 414108
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
      end
      object Label37: TLabel
        Left = 14
        Top = 14
        Width = 106
        Height = 15
        HelpContext = 414109
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
        Left = 17
        Top = 40
        Width = 77
        Height = 15
        HelpContext = 414110
        Caption = 'Gross Wages'
        Transparent = True
      end
      object Label41: TLabel
        Left = 327
        Top = 35
        Width = 62
        Height = 15
        HelpContext = 414111
        Caption = 'Leave Paid'
        Transparent = True
      end
      object Label46: TLabel
        Left = 17
        Top = 88
        Width = 62
        Height = 15
        HelpContext = 414112
        Caption = 'Super Paid'
        Transparent = True
      end
      object Label47: TLabel
        Left = 173
        Top = 40
        Width = 115
        Height = 15
        HelpContext = 414113
        Caption = 'Deductions (Default)'
        Transparent = True
      end
      object Label48: TLabel
        Left = 329
        Top = 88
        Width = 51
        Height = 15
        HelpContext = 414114
        Caption = 'Sundries'
        Transparent = True
      end
      object Label62: TLabel
        Left = 641
        Top = 40
        Width = 117
        Height = 15
        HelpContext = 414113
        Caption = 'Allowances (Default)'
        Transparent = True
      end
      object Label123: TLabel
        Left = 173
        Top = 88
        Width = 81
        Height = 15
        HelpContext = 414113
        Caption = 'PAYG Expense'
        Transparent = True
      end
      object Label122: TLabel
        Left = 485
        Top = 39
        Width = 62
        Height = 15
        HelpContext = 414112
        Caption = 'Net Wages'
        Transparent = True
      end
      object Label133: TLabel
        Left = 485
        Top = 88
        Width = 78
        Height = 15
        HelpContext = 414114
        Caption = 'Commissions'
        Transparent = True
      end
      object Label68: TLabel
        Left = 641
        Top = 88
        Width = 124
        Height = 15
        HelpContext = 414126
        Caption = 'Lump Sum D Expense'
        Transparent = True
      end
      object cboGrossWages: TwwDBLookupCombo
        Left = 17
        Top = 56
        Width = 148
        Height = 23
        HelpContext = 414115
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
        DataSource = dsPersonalPreferences
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
      object cboLeavePaidAccount: TwwDBLookupCombo
        Left = 329
        Top = 56
        Width = 148
        Height = 23
        HelpContext = 414116
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
        DataSource = dsPersonalPreferences
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
      object cboSuperPaidAccount: TwwDBLookupCombo
        Left = 17
        Top = 104
        Width = 148
        Height = 23
        HelpContext = 414117
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
        DataSource = dsPersonalPreferences
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
      object cboDeductionAccount: TwwDBLookupCombo
        Left = 173
        Top = 56
        Width = 148
        Height = 23
        HelpContext = 414118
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
        DataSource = dsPersonalPreferences
        LookupTable = qryAccount
        LookupField = 'AccountID'
        Options = [loColLines]
        ParentFont = False
        TabOrder = 1
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object cboSundriesAccount: TwwDBLookupCombo
        Left = 329
        Top = 104
        Width = 148
        Height = 23
        HelpContext = 414119
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
        DataSource = dsPersonalPreferences
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
        Left = 641
        Top = 56
        Width = 148
        Height = 23
        HelpContext = 414118
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
        DataSource = dsPersonalPreferences
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
      object cboNetWages: TwwDBLookupCombo
        Left = 485
        Top = 56
        Width = 148
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
        DataSource = dsPersonalPreferences
        LookupTable = qryAccount
        LookupField = 'AccountID'
        ParentFont = False
        TabOrder = 3
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object cboPAYGExpence: TwwDBLookupCombo
        Left = 173
        Top = 104
        Width = 148
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
        DataSource = dsPersonalPreferences
        LookupTable = qryAccount
        LookupField = 'AccountID'
        ParentFont = False
        TabOrder = 6
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object cboCommissionAccount: TwwDBLookupCombo
        Left = 485
        Top = 104
        Width = 148
        Height = 23
        HelpContext = 414119
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
        DataSource = dsPersonalPreferences
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
      object cboLumpSumDPaidAccountID: TwwDBLookupCombo
        Left = 641
        Top = 104
        Width = 148
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
        DataField = 'LumpSumDPaidAccountID'
        DataSource = dsPersonalPreferences
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
    end
    object DNMPanel7: TDNMPanel
      Left = 1
      Top = 265
      Width = 803
      Height = 154
      HelpContext = 414120
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      DesignSize = (
        803
        154)
      object Bevel7: TBevel
        Left = 6
        Top = 8
        Width = 790
        Height = 138
        HelpContext = 414121
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitWidth = 808
      end
      object Label49: TLabel
        Left = 14
        Top = 14
        Width = 100
        Height = 15
        HelpContext = 414122
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
        Left = 17
        Top = 40
        Width = 110
        Height = 15
        HelpContext = 414123
        Caption = 'Deductions Liability'
        Transparent = True
      end
      object Label51: TLabel
        Left = 17
        Top = 96
        Width = 80
        Height = 15
        HelpContext = 414124
        Caption = 'Leave Liability'
        Transparent = True
      end
      object Label52: TLabel
        Left = 248
        Top = 40
        Width = 82
        Height = 15
        HelpContext = 414125
        Caption = 'Super Payable'
        Transparent = True
      end
      object Label53: TLabel
        Left = 248
        Top = 96
        Width = 100
        Height = 15
        HelpContext = 414126
        Caption = 'PAYG Tax Payable'
        Transparent = True
      end
      object Label111: TLabel
        Left = 472
        Top = 40
        Width = 112
        Height = 15
        HelpContext = 414123
        Caption = 'Allowances Liability'
        Transparent = True
      end
      object wwDBLookupCombo7: TwwDBLookupCombo
        Left = 17
        Top = 56
        Width = 193
        Height = 23
        HelpContext = 414127
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
        DataSource = dsPersonalPreferences
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
      object wwDBLookupCombo8: TwwDBLookupCombo
        Left = 17
        Top = 112
        Width = 193
        Height = 23
        HelpContext = 414128
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
        DataSource = dsPersonalPreferences
        LookupTable = qryAccount
        LookupField = 'AccountID'
        Options = [loColLines]
        ParentFont = False
        TabOrder = 1
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo9: TwwDBLookupCombo
        Left = 248
        Top = 56
        Width = 193
        Height = 23
        HelpContext = 414129
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
        DataSource = dsPersonalPreferences
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
      object wwDBLookupCombo10: TwwDBLookupCombo
        Left = 248
        Top = 112
        Width = 193
        Height = 23
        HelpContext = 414130
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
        DataSource = dsPersonalPreferences
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
      object wwDBLookupCombo14: TwwDBLookupCombo
        Left = 472
        Top = 56
        Width = 193
        Height = 23
        HelpContext = 414127
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
        DataSource = dsPersonalPreferences
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
    end
  end
  object pnlAccounts: TDNMPanel [4]
    Left = 24
    Top = 8
    Width = 783
    Height = 370
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      783
      370)
    object Bevel1: TBevel
      Left = 7
      Top = 8
      Width = 768
      Height = 355
      HelpContext = 414103
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
      ExplicitWidth = 805
      ExplicitHeight = 285
    end
    object Label1: TLabel
      Left = 33
      Top = 27
      Width = 142
      Height = 15
      HelpContext = 414105
      Caption = 'Payroll Clearing Account '
      Transparent = True
    end
    object Label2: TLabel
      Left = 407
      Top = 27
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
    object Label3: TLabel
      Left = 33
      Top = 56
      Width = 77
      Height = 15
      HelpContext = 414110
      Caption = 'Gross Wages'
      Transparent = True
    end
    object Label4: TLabel
      Left = 33
      Top = 85
      Width = 62
      Height = 15
      HelpContext = 414112
      Caption = 'Net Wages'
      Transparent = True
    end
    object Label5: TLabel
      Left = 33
      Top = 114
      Width = 78
      Height = 15
      HelpContext = 414114
      Caption = 'Commissions'
      Transparent = True
    end
    object Label6: TLabel
      Left = 33
      Top = 143
      Width = 51
      Height = 15
      HelpContext = 414114
      Caption = 'Sundries'
      Transparent = True
    end
    object Label7: TLabel
      Left = 33
      Top = 172
      Width = 124
      Height = 15
      HelpContext = 414126
      Caption = 'Lump Sum D Expense'
      Transparent = True
    end
    object Label69: TLabel
      Left = 197
      Top = 204
      Width = 49
      Height = 15
      HelpContext = 127048
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
    object Label70: TLabel
      Left = 425
      Top = 204
      Width = 43
      Height = 15
      HelpContext = 127049
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
    object Label8: TLabel
      Left = 33
      Top = 235
      Width = 34
      Height = 15
      HelpContext = 414111
      Caption = 'Leave'
      Transparent = True
    end
    object Label9: TLabel
      Left = 33
      Top = 264
      Width = 115
      Height = 15
      HelpContext = 414113
      Caption = 'Deductions (Default)'
      Transparent = True
    end
    object Label10: TLabel
      Left = 33
      Top = 294
      Width = 117
      Height = 15
      HelpContext = 414113
      Caption = 'Allowances (Default)'
      Transparent = True
    end
    object Label11: TLabel
      Left = 33
      Top = 323
      Width = 90
      Height = 15
      HelpContext = 414112
      Caption = 'Superannuation'
      Transparent = True
    end
    object wwDBLookupCombo1: TwwDBLookupCombo
      Left = 197
      Top = 24
      Width = 193
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
      DataSource = dsPersonalPreferences
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
      Left = 197
      Top = 53
      Width = 193
      Height = 23
      HelpContext = 414115
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
      DataSource = dsPersonalPreferences
      LookupTable = qryAccount
      LookupField = 'AccountID'
      Options = [loColLines]
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object wwDBLookupCombo3: TwwDBLookupCombo
      Left = 197
      Top = 82
      Width = 193
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
      DataSource = dsPersonalPreferences
      LookupTable = qryAccount
      LookupField = 'AccountID'
      ParentFont = False
      TabOrder = 2
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object wwDBLookupCombo4: TwwDBLookupCombo
      Left = 197
      Top = 111
      Width = 193
      Height = 23
      HelpContext = 414119
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
      DataSource = dsPersonalPreferences
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
      Left = 197
      Top = 140
      Width = 193
      Height = 23
      HelpContext = 414119
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
      DataSource = dsPersonalPreferences
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
      Left = 197
      Top = 169
      Width = 193
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
      DataField = 'LumpSumDPaidAccountID'
      DataSource = dsPersonalPreferences
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
    object wwDBLookupCombo11: TwwDBLookupCombo
      Left = 197
      Top = 232
      Width = 193
      Height = 23
      HelpContext = 414116
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
      DataSource = dsPersonalPreferences
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
    object wwDBLookupCombo12: TwwDBLookupCombo
      Left = 425
      Top = 233
      Width = 193
      Height = 23
      HelpContext = 414128
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
      DataSource = dsPersonalPreferences
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
    object wwDBLookupCombo13: TwwDBLookupCombo
      Left = 197
      Top = 261
      Width = 193
      Height = 23
      HelpContext = 414118
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
      DataSource = dsPersonalPreferences
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
    object wwDBLookupCombo15: TwwDBLookupCombo
      Left = 425
      Top = 262
      Width = 193
      Height = 23
      HelpContext = 414127
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
      DataSource = dsPersonalPreferences
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
    object wwDBLookupCombo16: TwwDBLookupCombo
      Left = 197
      Top = 290
      Width = 193
      Height = 23
      HelpContext = 414118
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
      DataSource = dsPersonalPreferences
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
    object wwDBLookupCombo17: TwwDBLookupCombo
      Left = 425
      Top = 291
      Width = 193
      Height = 23
      HelpContext = 414127
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
      DataSource = dsPersonalPreferences
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
    object wwDBLookupCombo18: TwwDBLookupCombo
      Left = 197
      Top = 319
      Width = 193
      Height = 23
      HelpContext = 414117
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
      DataSource = dsPersonalPreferences
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
    object wwDBLookupCombo19: TwwDBLookupCombo
      Left = 425
      Top = 320
      Width = 193
      Height = 23
      HelpContext = 414129
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
      DataSource = dsPersonalPreferences
      LookupTable = qryAccount
      LookupField = 'AccountID'
      Options = [loColLines]
      ParentFont = False
      TabOrder = 13
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
  end
  inherited popSpelling: TPopupMenu
    Left = 112
    Top = 8
  end
  object qryAccount: TERPQuery
    SQL.Strings = (
      'SELECT tblChartofAccounts.AccountId as AccountID,'
      
        'tblChartofAccounts.AccountName as AccountName, tblacctypedesc.Ac' +
        'cDesc as AccType'
      'FROM tblChartofAccounts'
      'LEFT JOIN tblacctypedesc on  AccType = AccountType'
      'WHERE IsHeader = '#39'F'#39' AND Active = '#39'T'#39
      'union all'
      'select 0 as AccountId,'
      '"[Default]" as AccountName,'
      '"" as AccType'
      'ORDER BY AccType, AccountName')
    Left = 200
    Top = 9
  end
  object dsPersonalPreferences: TDataSource
    Left = 312
    Top = 24
  end
end
