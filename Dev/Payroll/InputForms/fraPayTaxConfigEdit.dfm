object frPayTaxConfigEdit: TfrPayTaxConfigEdit
  Left = 0
  Top = 0
  Width = 490
  Height = 91
  TabOrder = 0
  object pnlMain: TDNMPanel
    Left = 0
    Top = 0
    Width = 490
    Height = 91
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnDblClick = pnlMainDblClick
    DesignSize = (
      490
      91)
    object lblTaxName: TLabel
      Left = 8
      Top = 23
      Width = 90
      Height = 15
      AutoSize = False
      Caption = 'Tax Name'
      Transparent = True
      OnDblClick = lblTaxNameDblClick
    end
    object lblType: TLabel
      Left = 144
      Top = 52
      Width = 26
      Height = 15
      Caption = 'Type'
      Transparent = True
      OnDblClick = lblTaxNameDblClick
    end
    object lblAllowance: TLabel
      Left = 263
      Top = 52
      Width = 59
      Height = 15
      Caption = 'Allowance'
      Transparent = True
      OnDblClick = lblTaxNameDblClick
    end
    object lblRound: TLabel
      Left = 376
      Top = 52
      Width = 36
      Height = 15
      Caption = 'Round'
      Transparent = True
      OnDblClick = lblTaxNameDblClick
    end
    object Bevel1: TBevel
      Left = 8
      Top = 86
      Width = 465
      Height = 5
      Anchors = [akLeft, akBottom]
      Shape = bsBottomLine
      ExplicitTop = 55
    end
    object lblInstruct: TLabel
      Left = 439
      Top = 47
      Width = 43
      Height = 28
      Caption = '(Dbl click to edit)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      OnDblClick = lblInstructDblClick
    end
    object lblGroup: TLabel
      Left = 4
      Top = 52
      Width = 34
      Height = 15
      Caption = 'Group'
      Transparent = True
      OnDblClick = lblTaxNameDblClick
    end
    object lblExpense: TLabel
      Left = 152
      Top = -1
      Width = 90
      Height = 15
      AutoSize = False
      Caption = 'Expense'
      Transparent = True
      OnDblClick = lblTaxNameDblClick
    end
    object lblLiability: TLabel
      Left = 305
      Top = -1
      Width = 90
      Height = 15
      AutoSize = False
      Caption = 'Liability'
      Transparent = True
      OnDblClick = lblTaxNameDblClick
    end
    object cboExpense: TwwDBLookupCombo
      Left = 130
      Top = 20
      Width = 160
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'20'#9'AccountName'#9'F'#9
        'Type'#9'20'#9'Type'#9'F'#9)
      LookupTable = qryExp
      LookupField = 'AccountID'
      Style = csDropDownList
      ParentFont = False
      TabOrder = 0
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnChange = cboExpenseChange
      OnDblClick = cboExpenseDblClick
    end
    object cboLiability: TwwDBLookupCombo
      Left = 305
      Top = 20
      Width = 160
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'20'#9'AccountName'#9'F'
        'Type'#9'20'#9'Type'#9'F')
      LookupTable = qryLiab
      LookupField = 'AccountID'
      Style = csDropDownList
      ParentFont = False
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnChange = cboLiabilityChange
      OnDblClick = cboLiabilityDblClick
    end
    object cboType: TwwDBComboBox
      Left = 176
      Top = 49
      Width = 81
      Height = 23
      ShowButton = True
      Style = csDropDownList
      MapList = False
      AllowClearKey = False
      DropDownCount = 8
      DropDownWidth = 100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        'Employee'
        'Company')
      ItemIndex = 0
      ParentFont = False
      ReadOnly = True
      Sorted = False
      TabOrder = 2
      UnboundDataType = wwDefault
      OnChange = cboTypeChange
      OnDblClick = cboTypeDblClick
    end
    object edtAllowanceAmount: TDBAdvEdit
      Left = 331
      Top = 49
      Width = 38
      Height = 23
      EditType = etMoney
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
      TabOrder = 3
      Text = '0'
      Visible = True
      OnChange = edtAllowanceAmountChange
      OnDblClick = edtAllowanceAmountDblClick
      Version = '2.8.6.9'
    end
    object chkRound: TwwCheckBox
      Left = 419
      Top = 52
      Width = 15
      Height = 15
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      TabOrder = 4
      OnClick = chkRoundClick
      ReadOnly = True
    end
    object cboGroup: TwwDBComboBox
      Left = 43
      Top = 49
      Width = 95
      Height = 23
      ShowButton = True
      Style = csDropDownList
      MapList = True
      AllowClearKey = False
      DropDownCount = 8
      DropDownWidth = 100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        'Federal'#9'Federal'
        'State'#9'State'
        'Medicare'#9'Medicare'
        'Social Security'#9'SocialSecurity'
        'Other'#9'Other')
      ItemIndex = 0
      ParentFont = False
      ReadOnly = True
      Sorted = False
      TabOrder = 5
      UnboundDataType = wwDefault
      OnChange = cboTypeChange
      OnDblClick = cboTypeDblClick
    end
  end
  object qryExp: TERPQuery
    SQL.Strings = (
      'select T.AccountId, T.AccountName, AccDesc as Type'
      'from tblchartofaccounts  T'
      'LEFT JOIN tblacctypedesc on  AccType = AccountType'
      'where AccountType = '#39'EXP'#39' and Active = "T"'
      'order by AccountName;')
    Options.LongStrings = False
    Left = 44
    Top = 2
    object qryExpAccountName: TWideStringField
      DisplayWidth = 20
      FieldName = 'AccountName'
      Origin = 'tblChartofAccounts.AccountName'
      Size = 50
    end
    object qryExpType: TWideStringField
      DisplayWidth = 20
      FieldName = 'Type'
      Origin = 'tblacctypedesc.Type'
      Size = 255
    end
    object qryExpAccountID: TIntegerField
      DisplayWidth = 10
      FieldName = 'AccountID'
      Origin = 'tblChartofAccounts.AccountID'
      Visible = False
    end
  end
  object qryLiab: TERPQuery
    SQL.Strings = (
      'select T.AccountId, T.AccountName, AccDesc as Type'
      'from tblchartofaccounts  T'
      'LEFT JOIN tblacctypedesc on  AccType = AccountType'
      'where AccountType = "OCLIAB" and Active = "T"'
      'order by AccountName;')
    Options.LongStrings = False
    Left = 92
    Top = 2
    object WideStringField1: TWideStringField
      DisplayWidth = 20
      FieldName = 'AccountName'
      Origin = 'tblChartofAccounts.AccountName'
      Size = 50
    end
    object WideStringField2: TWideStringField
      DisplayWidth = 20
      FieldName = 'Type'
      Origin = 'tblacctypedesc.Type'
      Size = 255
    end
    object IntegerField1: TIntegerField
      DisplayWidth = 10
      FieldName = 'AccountID'
      Origin = 'tblChartofAccounts.AccountID'
      Visible = False
    end
  end
end
