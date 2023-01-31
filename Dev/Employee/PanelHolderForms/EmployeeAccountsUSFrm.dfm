inherited EmpAccountsUS: TEmpAccountsUS
  HelpContext = 1211002
  Caption = 'EmpAccountsUS'
  ClientHeight = 668
  ClientWidth = 944
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 960
  ExplicitHeight = 706
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 668
    Width = 944
    HelpContext = 1211003
    ExplicitTop = 612
    ExplicitWidth = 944
  end
  object pnlMain: TDNMPanel [3]
    Left = 8
    Top = 56
    Width = 833
    Height = 593
    HelpContext = 1211004
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object ScrollBox1: TScrollBox
      Left = 1
      Top = 1
      Width = 831
      Height = 591
      HelpContext = 1211005
      VertScrollBar.Tracking = True
      Align = alClient
      BevelInner = bvNone
      TabOrder = 0
      ExplicitHeight = 490
      object DNMPanel5: TDNMPanel
        Left = 5
        Top = 5
        Width = 769
        Height = 95
        HelpContext = 1211006
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          769
          95)
        object Bevel5: TBevel
          Left = 6
          Top = 8
          Width = 756
          Height = 79
          HelpContext = 1211007
          Anchors = [akLeft, akTop, akRight, akBottom]
          Shape = bsFrame
          ExplicitWidth = 806
        end
        object Label65: TLabel
          Left = 14
          Top = 14
          Width = 97
          Height = 15
          HelpContext = 1211008
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
          HelpContext = 1211009
          Caption = 'Payroll Clearing Account '
          Transparent = True
        end
        object Label34: TLabel
          Left = 176
          Top = 59
          Width = 352
          Height = 15
          HelpContext = 1211010
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
          Left = 20
          Top = 56
          Width = 144
          Height = 23
          HelpContext = 1211011
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
      object pnlExpenseAccounts: TDNMPanel
        Left = 5
        Top = 102
        Width = 769
        Height = 241
        HelpContext = 1211012
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        DesignSize = (
          769
          241)
        object Bevel6: TBevel
          Left = 6
          Top = 8
          Width = 755
          Height = 225
          HelpContext = 1211013
          Anchors = [akLeft, akTop, akRight, akBottom]
          Shape = bsFrame
          ExplicitHeight = 183
        end
        object Label37: TLabel
          Left = 14
          Top = 14
          Width = 106
          Height = 15
          HelpContext = 1211014
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
          Top = 38
          Width = 77
          Height = 14
          HelpContext = 1211015
          Caption = 'Gross Wages'
          Transparent = True
        end
        object Label41: TLabel
          Left = 575
          Top = 38
          Width = 62
          Height = 15
          HelpContext = 1211016
          Caption = 'Leave Paid'
          Transparent = True
        end
        object Label46: TLabel
          Left = 389
          Top = 86
          Width = 113
          Height = 15
          HelpContext = 1211017
          Caption = 'Social Security Paid'
          Transparent = True
        end
        object Label47: TLabel
          Left = 203
          Top = 134
          Width = 115
          Height = 15
          HelpContext = 1211018
          Caption = 'Deductions (Default)'
          Transparent = True
        end
        object Label48: TLabel
          Left = 17
          Top = 183
          Width = 51
          Height = 15
          HelpContext = 1211019
          Caption = 'Sundries'
          Transparent = True
        end
        object Label62: TLabel
          Left = 17
          Top = 134
          Width = 117
          Height = 15
          HelpContext = 1211020
          Caption = 'Allowances (Default)'
          Transparent = True
        end
        object Label123: TLabel
          Left = 17
          Top = 86
          Width = 142
          Height = 15
          HelpContext = 1211021
          Caption = 'Fed Withholding Expense'
          Transparent = True
        end
        object Label122: TLabel
          Left = 203
          Top = 38
          Width = 62
          Height = 15
          HelpContext = 1211022
          Caption = 'Net Wages'
          Transparent = True
        end
        object Label133: TLabel
          Left = 389
          Top = 38
          Width = 78
          Height = 15
          HelpContext = 1211023
          Caption = 'Commissions'
          Transparent = True
        end
        object Label23: TLabel
          Left = 203
          Top = 86
          Width = 152
          Height = 15
          HelpContext = 1211024
          Caption = 'State Withholding Expense'
          Transparent = True
        end
        object Label68: TLabel
          Left = 576
          Top = 86
          Width = 81
          Height = 15
          HelpContext = 1211025
          Caption = 'Medicare Paid'
          Transparent = True
        end
        object Label1: TLabel
          Left = 388
          Top = 133
          Width = 169
          Height = 15
          HelpContext = 1211054
          Caption = 'Social Security Paid Company'
          Transparent = True
        end
        object Label2: TLabel
          Left = 576
          Top = 134
          Width = 137
          Height = 15
          HelpContext = 1211055
          Caption = 'Medicare Paid Company'
          Transparent = True
        end
        object cboGrossWages: TwwDBLookupCombo
          Left = 17
          Top = 56
          Width = 170
          Height = 23
          HelpContext = 1211026
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
          Left = 575
          Top = 56
          Width = 170
          Height = 23
          HelpContext = 1211027
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
        object cboSocialSecurityPaidAccount: TwwDBLookupCombo
          Left = 389
          Top = 104
          Width = 170
          Height = 23
          HelpContext = 1211028
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
          Left = 203
          Top = 152
          Width = 170
          Height = 23
          HelpContext = 1211029
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
          Left = 17
          Top = 201
          Width = 170
          Height = 23
          HelpContext = 1211030
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
          Left = 17
          Top = 152
          Width = 170
          Height = 23
          HelpContext = 1211031
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
          Left = 203
          Top = 56
          Width = 170
          Height = 23
          HelpContext = 1211032
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
        object cboFedWithholdingExpence: TwwDBLookupCombo
          Left = 17
          Top = 104
          Width = 170
          Height = 23
          HelpContext = 1211033
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
          Left = 389
          Top = 56
          Width = 170
          Height = 23
          HelpContext = 1211034
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
        object cboStateWithholdingExpenses: TwwDBLookupCombo
          Left = 203
          Top = 104
          Width = 170
          Height = 23
          HelpContext = 1211035
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
          DataSource = dsPersonalPreferences
          LookupTable = qryAccount
          LookupField = 'AccountID'
          ParentFont = False
          TabOrder = 9
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object cboMedicarePaid: TwwDBLookupCombo
          Left = 576
          Top = 104
          Width = 170
          Height = 23
          HelpContext = 1211036
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
        object cboSocialSecurityPaidCompanyAccount: TwwDBLookupCombo
          Left = 389
          Top = 152
          Width = 170
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
          HelpContext = 1211056
        end
        object cboMedicarePaidCompany: TwwDBLookupCombo
          Left = 576
          Top = 152
          Width = 170
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
          HelpContext = 1211057
        end
      end
      object pnlLiabilityAccounts: TDNMPanel
        Left = 5
        Top = 347
        Width = 769
        Height = 195
        HelpContext = 1211037
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        DesignSize = (
          769
          195)
        object Bevel7: TBevel
          Left = 6
          Top = 8
          Width = 755
          Height = 179
          HelpContext = 1211038
          Anchors = [akLeft, akTop, akRight, akBottom]
          Shape = bsFrame
          ExplicitHeight = 130
        end
        object Label49: TLabel
          Left = 14
          Top = 14
          Width = 100
          Height = 15
          HelpContext = 1211039
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
          Left = 203
          Top = 86
          Width = 110
          Height = 15
          HelpContext = 1211040
          Caption = 'Deductions Liability'
          Transparent = True
        end
        object Label51: TLabel
          Left = 18
          Top = 134
          Width = 80
          Height = 15
          HelpContext = 1211041
          Caption = 'Leave Liability'
          Transparent = True
        end
        object Label52: TLabel
          Left = 203
          Top = 38
          Width = 171
          Height = 15
          HelpContext = 1211042
          Caption = 'State Withholding Tax Payable'
          Transparent = True
        end
        object Label53: TLabel
          Left = 17
          Top = 38
          Width = 161
          Height = 15
          HelpContext = 1211043
          Caption = 'Fed Withholding Tax Payable'
          Transparent = True
        end
        object Label111: TLabel
          Left = 17
          Top = 86
          Width = 112
          Height = 15
          HelpContext = 1211044
          Caption = 'Allowances Liability'
          Transparent = True
        end
        object Label21: TLabel
          Left = 389
          Top = 38
          Width = 133
          Height = 15
          HelpContext = 1211045
          Caption = 'Social Security Payable'
          Transparent = True
        end
        object Label22: TLabel
          Left = 576
          Top = 38
          Width = 101
          Height = 15
          HelpContext = 1211046
          Caption = 'Medicare Payable'
          Transparent = True
        end
        object Label3: TLabel
          Left = 390
          Top = 86
          Width = 164
          Height = 15
          HelpContext = 1211058
          Caption = 'Social Sec Payable Company'
          Transparent = True
        end
        object Label4: TLabel
          Left = 577
          Top = 86
          Width = 157
          Height = 15
          HelpContext = 1211059
          Caption = 'Medicare Payable Company'
          Transparent = True
        end
        object cboDeductionsLiability: TwwDBLookupCombo
          Left = 203
          Top = 104
          Width = 170
          Height = 23
          HelpContext = 1211047
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
        object cboLeaveLiability: TwwDBLookupCombo
          Left = 18
          Top = 152
          Width = 170
          Height = 23
          HelpContext = 1211048
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
        object cboStateWithholdingTaxPayable: TwwDBLookupCombo
          Left = 203
          Top = 56
          Width = 170
          Height = 23
          HelpContext = 1211049
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
        object cboFedWithholdingTaxPayable: TwwDBLookupCombo
          Left = 17
          Top = 56
          Width = 170
          Height = 23
          HelpContext = 1211050
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
          TabOrder = 4
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object cboAllowancesLiability: TwwDBLookupCombo
          Left = 17
          Top = 104
          Width = 170
          Height = 23
          HelpContext = 1211051
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
          TabOrder = 2
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object cboSocialSecurityPayable: TwwDBLookupCombo
          Left = 389
          Top = 56
          Width = 170
          Height = 23
          HelpContext = 1211052
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
        object cboMedicarePayable: TwwDBLookupCombo
          Left = 576
          Top = 56
          Width = 170
          Height = 23
          HelpContext = 1211053
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
        object cboSocialSecurityPayableCompany: TwwDBLookupCombo
          Left = 390
          Top = 104
          Width = 170
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
          HelpContext = 1211060
        end
        object cboMedicarePayableCompany: TwwDBLookupCombo
          Left = 577
          Top = 104
          Width = 170
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
          HelpContext = 1211061
        end
      end
    end
  end
  inherited popSpelling: TPopupMenu
    Left = 104
    Top = 0
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
