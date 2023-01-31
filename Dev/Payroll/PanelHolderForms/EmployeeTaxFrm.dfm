inherited EmpTaxGUI: TEmpTaxGUI
  Left = 118
  Top = 104
  HelpContext = 127000
  Caption = 'Employee Tax'
  ClientHeight = 800
  ClientWidth = 810
  OldCreateOrder = True
  ExplicitLeft = 118
  ExplicitTop = 104
  ExplicitWidth = 826
  ExplicitHeight = 839
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 800
    Width = 810
    ExplicitTop = 453
    ExplicitWidth = 880
  end
  object pnlMain: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 793
    Height = 809
    HelpContext = 127015
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Category = 'AustPayroll'
    DesignSize = (
      793
      809)
    object ScrollMain: TScrollBox
      Left = 1
      Top = 1
      Width = 787
      Height = 801
      VertScrollBar.Tracking = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
      object pnlTax: TDNMPanel
        Left = 10
        Top = 52
        Width = 762
        Height = 133
        HelpContext = 127017
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object lblTaxName: TLabel
          Left = 24
          Top = 5
          Width = 56
          Height = 15
          HelpContext = 127018
          Caption = 'Tax Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblTaxScale: TLabel
          Left = 198
          Top = 5
          Width = 55
          Height = 15
          HelpContext = 127018
          Caption = 'Tax Scale'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblAllowanceQty: TLabel
          Left = 360
          Top = 5
          Width = 81
          Height = 15
          HelpContext = 127018
          Caption = 'Allowance Qty'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblExpenseAccount: TLabel
          Left = 452
          Top = 5
          Width = 99
          Height = 15
          HelpContext = 127018
          Caption = 'Expense Account'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblLiabilityAccount: TLabel
          Left = 598
          Top = 5
          Width = 93
          Height = 15
          HelpContext = 127018
          Caption = 'LIability Account'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object TaxScaleList: TDNMPanel
          Left = 10
          Top = 26
          Width = 735
          Height = 99
          BevelOuter = bvNone
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
        end
      end
      object pnlExtraTax: TDNMPanel
        Left = 9
        Top = 189
        Width = 762
        Height = 106
        HelpContext = 127034
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object Label1: TLabel
          Left = 12
          Top = 11
          Width = 53
          Height = 15
          HelpContext = 127035
          Caption = 'Extra Tax'
          FocusControl = ExtraTax
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic, fsUnderline]
          ParentFont = False
          Transparent = True
        end
        object Label20: TLabel
          Left = 393
          Top = 61
          Width = 31
          Height = 15
          HelpContext = 127036
          Caption = 'Value'
          FocusControl = ExtraTax
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object ExtraTaxOptions: TwwRadioGroup
          Left = 25
          Top = 37
          Width = 346
          Height = 53
          HelpContext = 127037
          DisableThemes = False
          TransparentActiveItem = True
          Indents.TextX = 5
          Transparent = True
          Caption = 'Options'
          Columns = 3
          DataField = 'ExtraTaxOptions'
          DataSource = DSEmployees
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Items.Strings = (
            'Dollar'
            'Percentage'
            'Fixed')
          ParentFont = False
          TabOrder = 0
          Values.Strings = (
            '$'
            '%'
            'Fixed')
        end
        object ExtraTax: TDBEdit
          Left = 446
          Top = 58
          Width = 117
          Height = 23
          HelpContext = 127038
          DataField = 'ExtraTax'
          DataSource = DSEmployees
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
      object pnlExtra: TDNMPanel
        Left = 10
        Top = 598
        Width = 761
        Height = 105
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object Label3: TLabel
          Left = 36
          Top = 15
          Width = 66
          Height = 15
          HelpContext = 127020
          Caption = 'Workcover:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label4: TLabel
          Left = 36
          Top = 44
          Width = 62
          Height = 15
          HelpContext = 127021
          Caption = 'HELP Debt:'
          Transparent = True
        end
        object Label5: TLabel
          Left = 36
          Top = 72
          Width = 100
          Height = 15
          HelpContext = 127022
          Caption = 'SFSS Repayment:'
          Transparent = True
        end
        object Workcover: TwwDBLookupCombo
          Left = 168
          Top = 12
          Width = 329
          Height = 23
          HelpContext = 127026
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Company'#9'80'#9'Company'#9'F')
          DataField = 'WorkersCompInsurer'
          DataSource = DSEmployees
          LookupTable = qrySuppliers
          LookupField = 'ClientID'
          DropDownWidth = 250
          ParentFont = False
          TabOrder = 0
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object chkHECS: TwwCheckBox
          Left = 142
          Top = 44
          Width = 14
          Height = 17
          HelpContext = 127027
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
          Color = clBtnFace
          DataField = 'HECSIndicator'
          DataSource = DSEmployees
          ParentColor = False
          TabOrder = 1
          OnClick = chkHECSClick
        end
        object cboHECSTaxScales: TwwDBLookupCombo
          Left = 168
          Top = 41
          Width = 329
          Height = 23
          HelpContext = 127030
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'ScaleDescription'#9'40'#9'Scale Description'#9'F')
          DataField = 'HECSTaxScale'
          DataSource = DSEmployees
          LookupTable = qryHECSTaxScales
          LookupField = 'ScaleID'
          Style = csDropDownList
          ParentFont = False
          TabOrder = 2
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object chkSFSS: TwwCheckBox
          Left = 142
          Top = 72
          Width = 14
          Height = 17
          HelpContext = 127028
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
          Color = clBtnFace
          DataField = 'StudentLoanIndicator'
          DataSource = DSEmployees
          ParentColor = False
          TabOrder = 3
          OnClick = chkSFSSClick
        end
        object cboStudentLoanTaxScales: TwwDBLookupCombo
          Left = 168
          Top = 69
          Width = 329
          Height = 23
          HelpContext = 127031
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'ScaleDescription'#9'40'#9'Scale Description'#9'F')
          DataField = 'StudentLoanTaxScale'
          DataSource = DSEmployees
          LookupTable = qryStudentLoanTaxScales
          LookupField = 'ScaleID'
          Style = csDropDownList
          ParentFont = False
          TabOrder = 4
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
      end
      object pnlAccounts: TDNMPanel
        Left = 9
        Top = 299
        Width = 762
        Height = 295
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        object Label2: TLabel
          Left = 33
          Top = 27
          Width = 142
          Height = 15
          HelpContext = 414105
          Caption = 'Payroll Clearing Account '
          Transparent = True
        end
        object Label6: TLabel
          Left = 407
          Top = 17
          Width = 279
          Height = 30
          Caption = 'Note: this must be a clearing account not an actual bank account'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label7: TLabel
          Left = 33
          Top = 56
          Width = 77
          Height = 15
          HelpContext = 414110
          Caption = 'Gross Wages'
          Transparent = True
        end
        object Label8: TLabel
          Left = 33
          Top = 85
          Width = 62
          Height = 15
          HelpContext = 414112
          Caption = 'Net Wages'
          Transparent = True
        end
        object Label9: TLabel
          Left = 33
          Top = 114
          Width = 78
          Height = 15
          HelpContext = 414114
          Caption = 'Commissions'
          Transparent = True
        end
        object Label10: TLabel
          Left = 33
          Top = 143
          Width = 51
          Height = 15
          HelpContext = 414114
          Caption = 'Sundries'
          Transparent = True
        end
        object Label11: TLabel
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
        object Label12: TLabel
          Left = 33
          Top = 235
          Width = 34
          Height = 15
          HelpContext = 414111
          Caption = 'Leave'
          Transparent = True
        end
        object Label15: TLabel
          Left = 33
          Top = 266
          Width = 90
          Height = 15
          HelpContext = 414112
          Caption = 'Superannuation'
          Transparent = True
        end
        object Label13: TLabel
          Left = 417
          Top = 86
          Width = 98
          Height = 15
          HelpContext = 414112
          Caption = 'Nonwage Income'
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
        object wwDBLookupCombo18: TwwDBLookupCombo
          Left = 197
          Top = 262
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
          TabOrder = 8
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object wwDBLookupCombo19: TwwDBLookupCombo
          Left = 425
          Top = 263
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
          TabOrder = 9
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object edtNonwageIncome: TDBEdit
          Left = 569
          Top = 82
          Width = 117
          Height = 23
          HelpContext = 127038
          DataField = 'NonWageIncome'
          DataSource = dsEmpPaySettings
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
      end
      object pnlTFN: TDNMPanel
        Left = 10
        Top = 6
        Width = 762
        Height = 43
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        object lblTFN: TLabel
          Left = 24
          Top = 11
          Width = 125
          Height = 15
          HelpContext = 127018
          Caption = 'Tax File Number (TFN):'
          FocusControl = edTFN
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblABN: TLabel
          Left = 454
          Top = 11
          Width = 24
          Height = 15
          HelpContext = 127023
          Alignment = taRightJustify
          Caption = 'ABN'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object edTFN: TDBEdit
          Left = 198
          Top = 8
          Width = 170
          Height = 23
          HelpContext = 127024
          DataField = 'TFN'
          DataSource = DSEmployees
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object ABN: TDBEdit
          Left = 490
          Top = 8
          Width = 145
          Height = 23
          HelpContext = 127029
          DataField = 'ABN'
          DataSource = DSEmployees
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 585
    Top = 19
  end
  inherited tmrdelay: TTimer
    Left = 184
    Top = 65528
  end
  inherited popSpelling: TPopupMenu
    Left = 16
    Top = 0
  end
  inherited tmrdelayMsg: TTimer
    Left = 120
  end
  object DSEmployees: TDataSource
    Left = 256
    Top = 2
  end
  object qryTaxScales: TERPQuery
    SQL.Strings = (
      'Select ScaleID,Threshold,A,B'
      'FROM tblTax'
      'WHERE ScaleID=:TaxScaleID')
    Left = 128
    Top = 131
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TaxScaleID'
      end>
  end
  object qrySuppliers: TERPQuery
    SQL.Strings = (
      'SELECT ClientID, Company'
      'FROM tblClients'
      'WHERE Supplier='#39'T'#39
      'UNION ALL'
      'SELECT 0 AS ClientID, "(Default)" as Company'
      'ORDER BY Company;')
    Left = 562
    Top = 106
  end
  object dsEmpPaySettings: TDataSource
    Left = 28
    Top = 128
  end
  object qryTaxScale: TERPQuery
    Connection = frmEmployee.MyConnection
    SQL.Strings = (
      'Select ScaleID, ScaleDescription'
      'FROM tblTaxScales '
      
        'Where (((scaledescription not LIKE "%HELP%") and (scaledescripti' +
        'on not LIKE "%SFSS%")) or (scaledescription LIKE "%Use this code' +
        '%")) AND Active = '#39'T'#39' and REgionID = :RegionID;')
    BeforeOpen = qryTaxScaleBeforeOpen
    Left = 204
    Top = 124
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RegionID'
      end>
  end
  object qryHECSTaxScales: TERPQuery
    SQL.Strings = (
      'SELECT ScaleID, ScaleDescription'
      'FROM tblTaxScales '
      'WHERE ScaleDescription LIKE "%HELP%" AND Active = '#39'T'#39
      'UNION ALL'
      'SELECT 0 AS ScaleID, "(Default)" AS ScaleDescription'
      'ORDER BY ScaleDescription;')
    Left = 294
    Top = 116
  end
  object qryStudentLoanTaxScales: TERPQuery
    SQL.Strings = (
      'SELECT ScaleID, ScaleDescription'
      'FROM tblTaxScales '
      'WHERE ScaleDescription LIKE "%SFSS%" AND Active = '#39'T'#39
      'UNION ALL'
      'SELECT 0 AS ScaleID, "(Default)" AS ScaleDescription'
      'ORDER BY ScaleDescription;')
    Left = 664
    Top = 124
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
      '"(Default)" as AccountName,'
      '"" as AccType'
      'ORDER BY AccountName, AccType')
    Left = 488
    Top = 113
  end
  object dsPersonalPreferences: TDataSource
    Left = 408
    Top = 120
  end
end
