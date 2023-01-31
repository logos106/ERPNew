inherited FmChartofAccountsReportTree: TFmChartofAccountsReportTree
  Left = 436
  Top = 187
  HelpContext = 1248002
  Caption = 'Choose Accounts '
  PixelsPerInch = 96
  TextHeight = 15
  inherited Tree: TVirtualStringTree
    Top = 108
    Height = 146
    HelpContext = 1248008
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoHideButtons, toAutoDeleteMovedNodes, toDisableAutoscrollOnFocus]
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toWheelPanning]
    TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toUseBlendedSelection]
    TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toRightClickSelect]
    OnAfterCellPaint = TreeAfterCellPaint
    OnCollapsed = TreeCollapsed
    OnCreateEditor = TreeCreateEditor
    OnDragAllowed = TreeDragAllowed
    OnDragOver = TreeDragOver
    OnDragDrop = TreeDragDrop
    OnInitNode = TreeInitNode
    OnNewText = TreeNewText
    ExplicitTop = 108
    ExplicitHeight = 146
  end
  inherited pnlBottom: TDNMPanel
    HelpContext = 1248016
    inherited btnCustomize: TDNMSpeedButton
      Left = 98
      Top = 15
      ExplicitLeft = 98
      ExplicitTop = 15
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 195
      Top = 15
      ExplicitLeft = 195
      ExplicitTop = 15
    end
    inherited cmdNew: TDNMSpeedButton
      Left = 292
      Top = 15
      Width = 87
      HelpContext = 1248009
      ExplicitLeft = 292
      ExplicitTop = 15
      ExplicitWidth = 87
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 389
      Top = 15
      ExplicitLeft = 389
      ExplicitTop = 15
    end
    inherited cmdClose: TDNMSpeedButton
      Left = 778
      Top = 15
      Width = 87
      HelpContext = 1248010
      ExplicitLeft = 778
      ExplicitTop = 15
      ExplicitWidth = 87
    end
    inherited btnEdit: TDNMSpeedButton
      TabOrder = 9
    end
    object btnSave: TDNMSpeedButton
      Left = 680
      Top = 15
      Width = 87
      Height = 26
      HelpContext = 1248011
      Anchors = [akBottom]
      Caption = 'Save'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnSaveClick
    end
    object btnSelectAll: TDNMSpeedButton
      Left = 486
      Top = 15
      Width = 87
      Height = 26
      HelpContext = 1248012
      Anchors = [akBottom]
      Caption = 'Select All'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnSelectAllClick
    end
    object btnUnSelectall: TDNMSpeedButton
      Left = 583
      Top = 15
      Width = 87
      Height = 26
      HelpContext = 1248013
      Anchors = [akBottom]
      Caption = 'Un Select All'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnUnSelectallClick
    end
  end
  inherited pnlTop: TDNMPanel
    Height = 108
    HelpContext = 1248003
    ExplicitHeight = 108
    DesignSize = (
      996
      108)
    object lblReportname: TLabel [2]
      Left = 0
      Top = 58
      Width = 996
      Height = 17
      HelpContext = 1248004
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = 'Choose Accounts for Report : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
      WordWrap = True
      ExplicitTop = 66
    end
    inherited pnlSearch: TPanel
      Top = 75
      HelpContext = 1248017
      ExplicitTop = 75
      inherited chkTreeMode: TCheckBox
        Left = 910
        Top = 10
        Visible = False
        ExplicitLeft = 910
        ExplicitTop = 10
      end
    end
    inherited pnlTitle: TDNMPanel
      Left = 231
      Width = 534
      HelpContext = 1248005
      Anchors = [akLeft, akTop, akRight]
      ExplicitLeft = 231
      ExplicitWidth = 534
      inherited TitleShader: TShader
        Width = 530
        HelpContext = 1248006
        ExplicitWidth = 530
        inherited TitleLabel: TLabel
          Width = 530
          HelpContext = 1248007
          Caption = 'Choose Accounts '
          ExplicitWidth = 530
        end
      end
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C0101020010011C0110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited qryAcc: TERPQuery
    SQL.Strings = (
      
        'SELECT ifnull(AAT.category , "AT") as Category, AAT.AccountId AA' +
        'TAccountID,'
      
        'AT.TypeId as accountId, AT.AccDesc as "AccountType", AT.typeid ,' +
        ' AT.AccType,'
      
        'null AccountNumber, AT.AccDesc  accountname, 0.0 Balance, "T" ac' +
        'tive , null Level1, null Level2 ,null Level3, null Level4,'
      
        'null TaxCode, null BSB, null BankAccountNumber, null Description' +
        ', null BankAccountName, null BankNumber,'
      'null as TaxCodeDescription,'
      'ifnull(AAt.SortOrder,AT.SortOrder) as SortOrder , '
      
        'if(ifnull(AAT.AccountId,0)=0,"No" , if(AAT.Showinthereport="T" ,' +
        ' "Yes" , "No")) as Showinthereport,'
      'AAT.reportCaption'
      'FROM  tblAccTypeDesc AT  '
      'left join  tblChartofAccountsReportTree AAT  '
      
        'on  (AT.typeId = AAT.AccountID and AAT.reportId = :ReportID and ' +
        'AAT.category ='#39'AT'#39' and  (AAt.Level2ID = 0)) or ifnull(AAT.accoun' +
        'tid,0)=0'
      'order by SORTOrder, Category')
    IndexFieldNames = ''
    Left = 105
    Top = 296
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ReportID'
        Value = 1924
      end>
    inherited qryAccAccountName: TWideStringField [0]
      DisplayWidth = 19
      Origin = 'AT.accountname'
      Size = 4
    end
    inherited qryAccSortOrder: TLargeintField [1]
      DisplayWidth = 9
      Origin = 'SortOrder'
    end
    object qryAccreportCaption: TWideStringField [2]
      DisplayWidth = 50
      FieldName = 'reportCaption'
      Origin = 'AAT.reportCaption'
      Visible = False
      Size = 100
    end
    inherited qryAccAccountType: TWideStringField [3]
      Visible = False
    end
    inherited qryAccAccType: TWideStringField [4]
      Visible = False
    end
    inherited qryAccAccountNumber: TWideStringField [5]
      Origin = 'AccountNumber'
      Visible = False
    end
    inherited qryAccBalance: TFloatField [6]
      Origin = 'Balance'
      Visible = False
    end
    inherited qryAccActive: TWideStringField [7]
      Origin = 'active'
      Visible = False
    end
    inherited qryAccLevel1: TWideStringField [8]
      Origin = 'Level1'
      Visible = False
      Size = 4
    end
    inherited qryAccLevel2: TWideStringField [9]
      Origin = 'Level2'
      Visible = False
    end
    inherited qryAccLevel3: TWideStringField [10]
      Origin = 'Level3'
      Visible = False
    end
    inherited qryAccLevel4: TWideStringField [11]
      Origin = 'Level4'
      Visible = False
    end
    inherited qryAccTaxCode: TWideStringField [12]
      Origin = 'TaxCode'
      Visible = False
    end
    inherited qryAccBSB: TWideStringField [13]
      Origin = 'BSB'
      Visible = False
    end
    inherited qryAccBankAccountNumber: TWideStringField [14]
      Origin = 'BankAccountNumber'
      Visible = False
    end
    inherited qryAccDescription: TWideStringField [15]
      Origin = 'Description'
      Visible = False
    end
    inherited qryAccBankAccountName: TWideStringField [16]
      Origin = 'BankAccountName'
      Visible = False
    end
    inherited qryAccBankNumber: TWideStringField [17]
      Origin = 'BankNumber'
      Visible = False
    end
    inherited qryAccTaxCodeDescription: TWideStringField [18]
      Origin = 'TaxCodeDescription'
      Visible = False
    end
    inherited qryAccTotalBalance: TFloatField [19]
      Visible = False
    end
    inherited qryAccTypeId: TIntegerField [20]
      Origin = 'AT.typeid'
      Visible = False
    end
    inherited qryAccAccountId: TIntegerField [21]
      Origin = 'AT.accountId'
      Visible = False
    end
    object qryAccAATAccountID: TIntegerField
      FieldName = 'AATAccountID'
      Origin = 'AAT.AATAccountID'
      Visible = False
    end
    object qryAccShowinthereport: TWideStringField
      FieldName = 'Showinthereport'
      Origin = 'Showinthereport'
      Visible = False
      Size = 1
    end
    object qryAcccategory: TWideStringField
      FieldName = 'category'
      Origin = 'Category'
      Visible = False
      Size = 3
    end
  end
  inherited qrySubAcc: TERPQuery
    SQL.Strings = (
      'SELECT '
      #39'COA'#39' as category , '
      'AAT.AccountId AATAccountID, '
      'A.AccountId,'
      'A.AccountNumber, '
      'A.AccountName, '
      'A.Balance, '
      'A.Active, '
      'A.Level1, '
      'A.Level2, '
      'A.Level3, '
      'A.Level4,'
      'A.TaxCode, '
      'A.BSB, '
      'A.BankAccountNumber, '
      'A.Description, '
      'A.BankAccountName, '
      'A.BankNumber,'
      
        'tblTaxcodes.Description as TaxCodeDescription  , A.Accounttype ,' +
        ' '
      
        'if(ifnull(AAT.AccountId,0)=0,"No" , if(AAT.Showinthereport="T" ,' +
        ' "Yes" , "No")) as Showinthereport,'
      'AAT.reportCaption'
      'FROM tblChartOfAccounts A'
      
        'Left join tblChartofAccountsReportTree AAT on A.accountId = AAT.' +
        'AccountID and AAT.reportId = :ReportID '
      
        'LEFT JOIN tblTaxcodes  ON tblTaxcodes.Name = A.Taxcode  AND  Reg' +
        'ionID= :xRegionID'
      'WHERE (A.AccountName <> "")'
      'AND'
      '(((A.AccountName = A.Level2) AND (Level1 = :Parent))'
      'OR'
      '((A.AccountName = A.Level3) AND (Level2 = :Parent))'
      'OR'
      '((A.AccountName = A.Level4) AND (Level3 = :Parent)))'
      
        'AND ((:ActiveStr = "Active Account" AND A.Active = "T") OR (:Act' +
        'iveStr = "Inactive Account" AND A.Active = "F") OR (:ActiveStr =' +
        ' "All Account"))'
      ''
      '/*'
      'SELECT '
      #39'COA'#39' as category , '
      'AAT.AccountId AATAccountID, '
      'A.AccountId,'
      'A.AccountNumber, '
      'A.AccountName, '
      'A.Balance, '
      'A.Active, '
      'A.Level1, '
      'A.Level2, '
      'A.Level3, '
      'A.Level4,'
      'A.TaxCode, '
      'A.BSB, '
      'A.BankAccountNumber, '
      'A.Description, '
      'A.BankAccountName, '
      'A.BankNumber,'
      
        'tblTaxcodes.Description as TaxCodeDescription  , A.Accounttype ,' +
        ' '
      
        'if(ifnull(AAT.AccountId,0)=0,"No" , if(AAT.Showinthereport="T" ,' +
        ' "Yes" , "No")) as Showinthereport,'
      'AAT.reportCaption'
      'FROM tblChartOfAccounts A'
      
        'Left join tblChartofAccountsReportTree AAT on A.accountId = AAT.' +
        'AccountID and AAT.reportId = :ReportID'
      
        'LEFT JOIN tblTaxcodes  ON tblTaxcodes.Name = A.Taxcode  AND  Reg' +
        'ionID=:XregionId'
      'WHERE (A.AccountName <> "")'
      'and parentId = :ParentID and PArentCategory =:ParentCategory'
      
        'AND ((:ActiveStr = "Active Account" AND A.Active = "T") OR (:Act' +
        'iveStr = "Inactive Account" AND A.Active = "F") OR (:ActiveStr =' +
        ' "All Account"))'
      '*/')
    Left = 177
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ReportID'
      end
      item
        DataType = ftString
        Name = 'xRegionID'
        Value = ''
      end
      item
        DataType = ftUnknown
        Name = 'Parent'
      end
      item
        DataType = ftUnknown
        Name = 'Parent'
      end
      item
        DataType = ftUnknown
        Name = 'Parent'
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
    object qrySubAccAATAccountID: TIntegerField
      FieldName = 'AATAccountID'
    end
    object qrySubAccShowinthereport: TWideStringField
      FieldName = 'Showinthereport'
      Size = 1
    end
    object qrySubAccreportCaption: TWideStringField
      FieldName = 'reportCaption'
      Size = 100
    end
    object qrySubAcccategory: TWideStringField
      FieldName = 'category'
      Size = 3
    end
  end
  object mnuTree: TAdvPopupMenu
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 657
    Top = 250
    object miAddBranch: TMenuItem
      Caption = 'Add Branch'
      HelpContext = 1248014
      OnClick = miAddBranchClick
    end
    object miDelete: TMenuItem
      Caption = 'Delete'
      HelpContext = 1248015
      OnClick = miDeleteClick
    end
  end
  object Qryaccounts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select accountId , accountname from tblchartofaccounts order by ' +
        'accountID')
    Left = 145
    Top = 248
    object QryaccountsaccountId: TIntegerField
      FieldName = 'accountId'
    end
    object Qryaccountsaccountname: TWideStringField
      FieldName = 'accountname'
      Size = 50
    end
  end
  object qryRootAcc: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT  '
      'AAT.AccountId AATAccountID, '
      'A.AccountId,'
      'A.AccountNumber, '
      'A.AccountName, '
      'A.Balance, '
      'A.Active, '
      'A.Level1, '
      'A.Level2, '
      'A.Level3, '
      'A.Level4,'
      'A.TaxCode, '
      'A.BSB, '
      'A.BankAccountNumber, '
      'A.Description, '
      'A.BankAccountName, '
      'A.BankNumber,'
      
        'tblTaxcodes.Description as TaxCodeDescription  , A.Accounttype ,' +
        ' '
      
        'if(ifnull(AAT.AccountId,0)=0,"No" , if(AAT.Showinthereport="T" ,' +
        ' "Yes" , "No")) as Showinthereport,'
      'AAT.reportCaption,'
      #39'COA'#39' as category '
      'FROM tblChartOfAccounts A'
      'inner join tblacctypedesc At on A.AccountType = At.AccType'
      
        'Left join tblChartofAccountsReportTree AAT on A.accountId = AAT.' +
        'AccountID and AAT.reportId = :ReportID and AAT.category ='#39'COA'#39
      
        'LEFT JOIN tblTaxcodes  ON tblTaxcodes.Name = A.Taxcode  AND  Reg' +
        'ionID= :xRegionID'
      'WHERE ((A.AccountName = A.Level1) and (AT.AccDesc = :Parent) ) '
      
        'AND ((:ActiveStr = "Active Account" AND A.Active = "T") OR (:Act' +
        'iveStr = "Inactive Account" AND A.Active = "F") OR (:ActiveStr =' +
        ' "All Account"))')
    BeforeOpen = qrySubAccBeforeOpen
    IndexFieldNames = 'AccountName'
    Left = 145
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ReportID'
      end
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
    object qryRootAccAATAccountID: TIntegerField
      FieldName = 'AATAccountID'
    end
    object qryRootAccAccountId: TIntegerField
      FieldName = 'AccountId'
    end
    object qryRootAccAccountNumber: TWideStringField
      FieldName = 'AccountNumber'
      Size = 50
    end
    object qryRootAccAccountName: TWideStringField
      FieldName = 'AccountName'
      Size = 50
    end
    object qryRootAccBalance: TFloatField
      FieldName = 'Balance'
    end
    object qryRootAccActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryRootAccLevel1: TWideStringField
      FieldName = 'Level1'
      Size = 255
    end
    object qryRootAccLevel2: TWideStringField
      FieldName = 'Level2'
      Size = 255
    end
    object qryRootAccLevel3: TWideStringField
      FieldName = 'Level3'
      Size = 255
    end
    object qryRootAccLevel4: TWideStringField
      FieldName = 'Level4'
      Size = 255
    end
    object qryRootAccTaxCode: TWideStringField
      FieldName = 'TaxCode'
      Size = 15
    end
    object qryRootAccBSB: TWideStringField
      FieldName = 'BSB'
      Size = 30
    end
    object qryRootAccBankAccountNumber: TWideStringField
      FieldName = 'BankAccountNumber'
      Size = 255
    end
    object qryRootAccDescription: TWideStringField
      FieldName = 'Description'
      Size = 150
    end
    object qryRootAccBankAccountName: TWideStringField
      FieldName = 'BankAccountName'
      Size = 255
    end
    object qryRootAccBankNumber: TWideStringField
      FieldName = 'BankNumber'
      Size = 50
    end
    object qryRootAccTaxCodeDescription: TWideStringField
      FieldName = 'TaxCodeDescription'
      Size = 255
    end
    object qryRootAccAccounttype: TWideStringField
      FieldName = 'Accounttype'
      Size = 50
    end
    object qryRootAccShowinthereport: TWideStringField
      FieldName = 'Showinthereport'
      Size = 3
    end
    object qryRootAccreportCaption: TWideStringField
      FieldName = 'reportCaption'
      Size = 100
    end
    object qryRootAcccategory: TWideStringField
      FieldName = 'category'
      Size = 3
    end
  end
end
