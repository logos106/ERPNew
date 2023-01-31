inherited fmChartOfAccountsTree: TfmChartOfAccountsTree
  Left = 765
  Top = 184
  HelpContext = 148000
  Caption = 'Chart of Accounts Tree'
  ExplicitLeft = 765
  ExplicitTop = 184
  PixelsPerInch = 96
  TextHeight = 15
  inherited imgGridWatermark: TImage
    HelpContext = 148001
  end
  inherited Tree: TVirtualStringTree
    HelpContext = 148009
    Font.Height = -12
    Header.Background = 14153215
    Header.Height = 23
    OnCompareNodes = TreeCompareNodes
    OnFreeNode = TreeFreeNode
  end
  inherited pnlBottom: TDNMPanel
    HelpContext = 148002
    Color = 14153215
    inherited btnCustomize: TDNMSpeedButton
      Left = 138
      HelpContext = 148003
      OnClick = btnCustomizeClick
      ExplicitLeft = 138
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 265
      HelpContext = 148004
      ExplicitLeft = 265
    end
    inherited cmdNew: TDNMSpeedButton
      Left = 392
      HelpContext = 148005
      OnClick = cmdNewClick
      ExplicitLeft = 392
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 519
      HelpContext = 148006
      ExplicitLeft = 519
    end
    inherited cmdClose: TDNMSpeedButton
      Left = 646
      HelpContext = 148007
      ExplicitLeft = 646
    end
    inherited btnExpandAll: TDNMSpeedButton
      HelpContext = 148008
      Anchors = [akLeft, akTop, akBottom]
    end
    object btnEdit: TDNMSpeedButton
      Left = 903
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 148028
      Anchors = [akRight, akBottom]
      Caption = 'Edit'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnEditClick
    end
  end
  inherited pnlTop: TDNMPanel
    HelpContext = 148010
    Color = 14153215
    inherited lblFrom: TLabel
      HelpContext = 148011
    end
    inherited lblTo: TLabel
      HelpContext = 148012
    end
    inherited cboDateRange: TComboBox
      HelpContext = 148013
      OnCloseUp = nil
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 148014
      OnCloseUp = nil
      OnChange = nil
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 148015
      OnCloseUp = nil
      OnChange = nil
    end
    inherited pnlSearch: TPanel
      HelpContext = 148016
      inherited Label1: TLabel
        HelpContext = 148017
      end
      inherited Label2: TLabel
        HelpContext = 148018
      end
      object Label3: TLabel [2]
        Left = 921
        Top = 8
        Width = 59
        Height = 15
        HelpContext = 148022
        Anchors = [akTop, akRight]
        Caption = 'Tree Mode'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        OnClick = chkTreeModeClick
      end
      inherited cboFilter: TComboBox
        HelpContext = 148019
      end
      inherited edtSearch: TEdit
        HelpContext = 148020
      end
      inherited btnGo: TDNMSpeedButton
        HelpContext = 148021
      end
      inherited btnRequery: TDNMSpeedButton
        TabOrder = 5
      end
      object chkTreeMode: TCheckBox
        Left = 904
        Top = 8
        Width = 17
        Height = 17
        HelpContext = 148023
        Anchors = [akTop, akRight]
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = chkTreeModeClick
      end
    end
    inherited pnlTitle: TDNMPanel
      HelpContext = 148025
      Font.Height = -35
      TabOrder = 5
      inherited TitleShader: TShader
        HelpContext = 148026
        inherited TitleLabel: TLabel
          HelpContext = 148027
          Caption = 'Chart of Accounts Tree'
        end
      end
    end
    object grpFilters: TwwRadioGroup
      Left = 8
      Top = 2
      Width = 217
      Height = 52
      HelpContext = 148024
      DisableThemes = False
      ItemIndex = 0
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Items.Strings = (
        'Active Account'
        'Inactive Account'
        'All Account')
      ParentFont = False
      TabOrder = 4
      OnClick = grpFiltersClick
    end
  end
  inherited popSpelling: TPopupMenu
    Left = 367
    Top = 248
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 335
    Top = 248
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 398
    Top = 248
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Left = 493
    Top = 248
  end
  inherited DataState: TDataState
    Left = 619
    Top = 248
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 430
    Top = 248
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102007400980010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  inherited QryCustomField: TERPQuery
    Left = 304
    Top = 248
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 524
    Top = 248
  end
  inherited qryMemTrans: TERPQuery
    Left = 272
    Top = 248
  end
  inherited PrintDialog: TPrintDialog
    Left = 556
    Top = 248
  end
  inherited PrinterSetupDialog: TPrinterSetupDialog
    Left = 461
    Top = 248
  end
  inherited dlgSave: TSaveDialog
    Left = 587
    Top = 248
  end
  object qryAcc: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      '# Returns account types and base level accounts'
      
        'SELECT AT.TypeId, AT.AccDesc as "AccountType", A.AccountId,AT.Ac' +
        'cType,'
      
        'A.AccountNumber, A.AccountName, A.Balance, A.Active, A.Level1, A' +
        '.Level2 ,A.Level3, Level4,'
      
        'A.TaxCode, A.BSB, A.BankAccountNumber, A.Description, A.BankAcco' +
        'untName, A.BankNumber,'
      'tblTaxcodes.Description as TaxCodeDescription,'
      'convert(AT.SortOrder , signed) as SortOrder'
      'FROM tblChartOfAccounts A'
      'INNER JOIN tblAccTypeDesc AT ON A.AccountType = AT.AccType'
      
        'LEFT JOIN tblTaxcodes  ON tblTaxcodes.Name = A.Taxcode   AND tbl' +
        'Taxcodes.RegionID= :xRegionID '
      'WHERE A.AccountName <> ""'
      'AND ((A.Level2 = "") OR (A.Level2 IS NULL))'
      
        'AND ((:ActiveStr = "Active Account" AND A.Active = "T") OR (:Act' +
        'iveStr = "Inactive Account" AND A.Active = "F") OR (:ActiveStr =' +
        ' "All Account"))')
    BeforeOpen = qryAccBeforeOpen
    IndexFieldNames = 'AccountType,AccountName'
    Left = 241
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end
      item
        DataType = ftString
        Name = 'ActiveStr'
        Value = ''
      end
      item
        DataType = ftString
        Name = 'ActiveStr'
        Value = ''
      end
      item
        DataType = ftString
        Name = 'ActiveStr'
        Value = ''
      end>
    object qryAccAccountType: TWideStringField
      FieldName = 'AccountType'
      Origin = 'AT.AccountType'
      Size = 255
    end
    object qryAccAccType: TWideStringField
      FieldName = 'AccType'
      Origin = 'AT.AccType'
      Size = 255
    end
    object qryAccAccountNumber: TWideStringField
      FieldName = 'AccountNumber'
      Origin = 'A.AccountNumber'
      Size = 50
    end
    object qryAccAccountName: TWideStringField
      FieldName = 'AccountName'
      Origin = 'A.AccountName'
      Size = 50
    end
    object qryAccBalance: TFloatField
      FieldName = 'Balance'
      Origin = 'A.Balance'
    end
    object qryAccActive: TWideStringField
      FieldName = 'Active'
      Origin = 'A.Active'
      FixedChar = True
      Size = 1
    end
    object qryAccLevel1: TWideStringField
      FieldName = 'Level1'
      Origin = 'A.Level1'
      Size = 255
    end
    object qryAccLevel2: TWideStringField
      FieldName = 'Level2'
      Origin = 'A.Level2'
      Size = 255
    end
    object qryAccLevel3: TWideStringField
      FieldName = 'Level3'
      Origin = 'A.Level3'
      Size = 255
    end
    object qryAccLevel4: TWideStringField
      FieldName = 'Level4'
      Origin = 'A.Level4'
      Size = 255
    end
    object qryAccTaxCode: TWideStringField
      FieldName = 'TaxCode'
      Origin = 'A.TaxCode'
      Size = 15
    end
    object qryAccBSB: TWideStringField
      FieldName = 'BSB'
      Origin = 'A.BSB'
      Size = 30
    end
    object qryAccBankAccountNumber: TWideStringField
      FieldName = 'BankAccountNumber'
      Origin = 'A.BankAccountNumber'
      Size = 255
    end
    object qryAccDescription: TWideStringField
      FieldName = 'Description'
      Origin = 'A.Description'
      Size = 150
    end
    object qryAccBankAccountName: TWideStringField
      FieldName = 'BankAccountName'
      Origin = 'A.BankAccountName'
      Size = 255
    end
    object qryAccBankNumber: TWideStringField
      FieldName = 'BankNumber'
      Origin = 'A.BankNumber'
      Size = 50
    end
    object qryAccTaxCodeDescription: TWideStringField
      FieldName = 'TaxCodeDescription'
      Origin = 'tblTaxcodes.Description'
      Size = 255
    end
    object qryAccTotalBalance: TFloatField
      FieldKind = fkLookup
      FieldName = 'TotalBalance'
      LookupDataSet = qryTotalBalances
      LookupKeyFields = 'AccountID'
      LookupResultField = 'TotalBalance'
      KeyFields = 'AccountId'
      Lookup = True
    end
    object qryAccTypeId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'TypeId'
      Origin = 'AT.TypeId'
    end
    object qryAccAccountId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'AccountId'
      Origin = 'A.AccountId'
    end
    object qryAccSortOrder: TLargeintField
      FieldName = 'SortOrder'
    end
  end
  object qrySubAcc: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT A.AccountId,'
      
        'A.AccountNumber, A.AccountName, A.Balance, A.Active, A.Level1, A' +
        '.Level2, A.Level3, Level4,'
      
        'A.TaxCode, A.BSB, A.BankAccountNumber, A.Description, A.BankAcco' +
        'untName, A.BankNumber,'
      'tblTaxcodes.Description as TaxCodeDescription  , A.Accounttype'
      'FROM tblChartOfAccounts A'
      
        'LEFT JOIN tblTaxcodes  ON tblTaxcodes.Name = A.Taxcode  AND tblT' +
        'axcodes.RegionID= :xRegionID '
      'WHERE (A.AccountName <> "")'
      'AND'
      '(((A.AccountName = A.Level2) AND (Level1 = :Parent))'
      'OR'
      '((A.AccountName = A.Level3) AND (Level2 = :Parent))'
      'OR'
      '((A.AccountName = A.Level4) AND (Level3 = :Parent)))'
      
        'AND ((:ActiveStr = "Active Account" AND A.Active = "T") OR (:Act' +
        'iveStr = "Inactive Account" AND A.Active = "F") OR (:ActiveStr =' +
        ' "All Account"))')
    BeforeOpen = qrySubAccBeforeOpen
    IndexFieldNames = 'AccountName'
    Left = 209
    Top = 248
    ParamData = <
      item
        DataType = ftString
        Name = 'xRegionID'
        Value = ''
      end
      item
        DataType = ftString
        Name = 'Parent'
        Value = ''
      end
      item
        DataType = ftString
        Name = 'Parent'
        Value = ''
      end
      item
        DataType = ftString
        Name = 'Parent'
        Value = ''
      end
      item
        DataType = ftUnknown
        Name = 'ActiveStr'
      end
      item
        DataType = ftUnknown
        Name = 'ActiveStr'
      end
      item
        DataType = ftUnknown
        Name = 'ActiveStr'
      end>
    object qrySubAccAccountId: TIntegerField
      FieldName = 'AccountId'
    end
    object qrySubAccAccountNumber: TWideStringField
      FieldName = 'AccountNumber'
      Size = 50
    end
    object qrySubAccAccountName: TWideStringField
      FieldName = 'AccountName'
      Size = 50
    end
    object qrySubAccBalance: TFloatField
      FieldName = 'Balance'
    end
    object qrySubAccActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qrySubAccLevel1: TWideStringField
      FieldName = 'Level1'
      Size = 255
    end
    object qrySubAccLevel2: TWideStringField
      FieldName = 'Level2'
      Size = 255
    end
    object qrySubAccLevel3: TWideStringField
      FieldName = 'Level3'
      Size = 255
    end
    object qrySubAccLevel4: TWideStringField
      FieldName = 'Level4'
      Size = 255
    end
    object qrySubAccTaxCode: TWideStringField
      FieldName = 'TaxCode'
      Size = 15
    end
    object qrySubAccBSB: TWideStringField
      FieldName = 'BSB'
      Size = 30
    end
    object qrySubAccBankAccountNumber: TWideStringField
      FieldName = 'BankAccountNumber'
      Size = 255
    end
    object qrySubAccDescription: TWideStringField
      FieldName = 'Description'
      Size = 150
    end
    object qrySubAccBankAccountName: TWideStringField
      FieldName = 'BankAccountName'
      Size = 255
    end
    object qrySubAccBankNumber: TWideStringField
      FieldName = 'BankNumber'
      Size = 50
    end
    object qrySubAccTaxCodeDescription: TWideStringField
      FieldName = 'TaxCodeDescription'
      Size = 255
    end
    object qrySubAccAccounttype: TWideStringField
      FieldName = 'Accounttype'
      Size = 50
    end
    object qrySubAccTotalBalance: TFloatField
      FieldKind = fkLookup
      FieldName = 'TotalBalance'
      LookupDataSet = qryTotalBalances
      LookupKeyFields = 'AccountID'
      LookupResultField = 'TotalBalance'
      KeyFields = 'AccountId'
      Lookup = True
    end
  end
  object qryTotalBalances: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT Max(If(Level1=AccountName,AccountID,0)) as AccountID,'
      'Sum(Balance) as TotalBalance '
      'FROM tblchartofaccounts ACC'
      'WHERE char_length(Level1)>0 '
      'Group By Level1'
      'Union All'
      'SELECT Max(If(Level2=AccountName,AccountID,0)) as AccountID,'
      'Sum(Balance) as TotalBalance '
      'FROM tblchartofaccounts ACC'
      'WHERE char_length(Level2)>0 '
      'Group By Level2'
      'Union All'
      'SELECT Max(If(Level3=AccountName,AccountID,0)) as AccountID,'
      'Sum(Balance) as TotalBalance '
      'FROM tblchartofaccounts ACC'
      'WHERE char_length(Level3)>0 '
      'Group By Level3'
      'Union All'
      'SELECT Max(If(Level4=AccountName,AccountID,0)) as AccountID,'
      'Sum(Balance) as TotalBalance '
      'FROM tblchartofaccounts ACC '
      'WHERE char_length(Level4)>0'
      'Group By Level4;')
    Left = 178
    Top = 248
  end
end
