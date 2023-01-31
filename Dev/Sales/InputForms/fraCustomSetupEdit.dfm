object CustomSetupEdit: TCustomSetupEdit
  Left = 0
  Top = 0
  Width = 452
  Height = 75
  TabOrder = 0
  object pnlMain: TDNMPanel
    Left = 0
    Top = 0
    Width = 452
    Height = 75
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      452
      75)
    object lblColumn: TLabel
      Left = 24
      Top = 7
      Width = 90
      Height = 15
      AutoSize = False
      Caption = 'Column'
      Transparent = True
      OnDblClick = lblColumnDblClick
    end
    object Bevel1: TBevel
      Left = 0
      Top = 65
      Width = 465
      Height = 5
      Anchors = [akLeft, akBottom]
      Shape = bsBottomLine
      ExplicitTop = 81
    end
    object lblLiability: TLabel
      Left = 233
      Top = 7
      Width = 90
      Height = 15
      AutoSize = False
      Caption = 'Accounts'
      Transparent = True
      OnDblClick = lblColumnDblClick
    end
    object lblDelete: TLabel
      Left = 334
      Top = 52
      Width = 91
      Height = 14
      Caption = '(Dbl click to delete)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      OnDblClick = lblDeleteDblClick
    end
    object edtHeader: TEdit
      Left = 24
      Top = 28
      Width = 145
      Height = 23
      TabOrder = 0
    end
    object cboAccounts: TERPDbLookupCombo
      Left = 233
      Top = 28
      Width = 192
      Height = 23
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'25'#9'AccountName'#9'F'#9
        'Type'#9'20'#9'Type'#9'T'#9
        'Description'#9'30'#9'Description'#9'F'#9)
      DataField = 'accountname'
      DataSource = dsMain
      LookupTable = qryAccounts
      LookupField = 'AccountName'
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnChange = cboAccountsChange
      LookupFormClassName = 'TChartOfAccountsListLookupGUI'
      EditFormClassName = 'TfrmChartOfAccounts'
      LookupFormKeyStringFieldName = 'AccountName'
      LookupComboType = ctAccount
      AllowFullListSearchMode = False
      onDoGridDataSelect = cboAccountsDoGridDataSelect
      DisableNotInList = False
      AllowMultipleSelectFromList = True
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      LookupIDField = 'AccountID'
    end
  end
  object qryAccounts: TERPQuery
    SQL.Strings = (
      'SELECT'
      
        'Concat(If( char_length(Level4)>0,Space(15), If( char_length(Leve' +
        'l3)>0,Space(10),If( char_length(Level2)>0,Space(5),Space(0)))),A' +
        'ccountName) as AccountTree,'
      
        'SUBSTRING(If((char_length(tblChartofAccounts.AccountGroup)>0),Co' +
        'ncat(REPLACE(tblChartofAccounts.AccountGroup,"^"," - ")," - ",tb' +
        'lChartofAccounts.AccountName),tblChartofAccounts.AccountName),1,' +
        '255) as FullAccountName,'
      'tblChartofAccounts.AccountName,'
      'tblChartofAccounts.AccountID,'
      'tblChartofAccounts.AccountNumber,'
      'tblChartofAccounts.AccountGroup,'
      'tblacctypedesc.AccDesc AS Type,'
      'tblChartofAccounts.Description,'
      'tblChartofAccounts.Taxcode,'
      'tblChartofAccounts.Active'
      'FROM tblChartofAccounts'
      
        'LEFT JOIN tblacctypedesc ON tblacctypedesc.AccType = tblChartofA' +
        'ccounts.AccountType'
      'WHERE tblChartofAccounts.Active = '#39'T'#39' and IsHeader = '#39'F'#39
      
        'and (tblChartofAccounts.AccountName <> "Retained Earnings") and ' +
        '(Left(ifnull(AccountGroup,""),17) <> "Retained Earnings") '
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (((AccountName LIKE Concat(:SearchValu' +
        'e,"%")) or (tblacctypedesc.AccDesc LIKE Concat(:SearchValue,"%")' +
        ') or (tblacctypedesc.AccDesc LIKE Concat(:SearchValue,"%")))) )'
      
        'or ((:SearchMode = 2) and (((AccountName LIKE Concat("%",:Search' +
        'Value,"%")) or (tblacctypedesc.AccDesc LIKE Concat("%",:SearchVa' +
        'lue,"%")) or (tblacctypedesc.AccDesc LIKE Concat("%",:SearchValu' +
        'e,"%"))))))'
      'and IfNull(:SearchValue,"") <> ""'
      '# placeholder for FilterAccountsForExpenseClaim'
      'ORDER BY AccountName')
    Left = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
    object qryAccountsAccountName: TWideStringField
      DisplayWidth = 25
      FieldName = 'AccountName'
      Origin = 'tblchartofaccounts.AccountName'
      Size = 50
    end
    object qryAccountsType: TWideStringField
      DisplayWidth = 20
      FieldName = 'Type'
      Origin = 'tblacctypedesc.AccDesc'
      Size = 255
    end
    object qryAccountsDescription: TWideStringField
      DisplayWidth = 30
      FieldName = 'Description'
      Origin = 'tblchartofaccounts.Description'
      Size = 150
    end
    object qryAccountsAccountTree: TWideStringField
      DisplayWidth = 10
      FieldName = 'AccountTree'
      Origin = 'AccountTree'
      Visible = False
      Size = 65
    end
    object qryAccountsFullAccountName: TWideStringField
      DisplayWidth = 255
      FieldName = 'FullAccountName'
      Origin = 'FullAccountName'
      Visible = False
      Size = 255
    end
    object qryAccountsAccountID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'AccountID'
      Origin = 'tblchartofaccounts.AccountID'
      Visible = False
    end
    object qryAccountsAccountNumber: TWideStringField
      DisplayWidth = 50
      FieldName = 'AccountNumber'
      Origin = 'tblchartofaccounts.AccountNumber'
      Visible = False
      Size = 50
    end
    object qryAccountsAccountGroup: TWideStringField
      DisplayWidth = 255
      FieldName = 'AccountGroup'
      Origin = 'tblchartofaccounts.AccountGroup'
      Visible = False
      Size = 255
    end
    object qryAccountsTaxcode: TWideStringField
      DisplayWidth = 15
      FieldName = 'Taxcode'
      Origin = 'tblchartofaccounts.Taxcode'
      Visible = False
      Size = 15
    end
    object qryAccountsActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblchartofaccounts.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object dsMain: TDataSource
    DataSet = qryMain
    Left = 3
    Top = 44
  end
  object qryMain: TERPQuery
    SQL.Strings = (
      
        'SELECT accountid, accountname, accountnumber FROM tblchartofacco' +
        'unts')
    Left = 113
    Top = 65532
    object qryMainaccountid: TIntegerField
      FieldName = 'accountid'
    end
    object qryMainaccountname: TWideStringField
      FieldName = 'accountname'
      Size = 50
    end
  end
end
