inherited frmFixedAssetsDetails: TfrmFixedAssetsDetails
  Left = 114
  Top = 111
  HelpContext = 285000
  Caption = 'Fixed Assets Details'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 285001
  end
  inherited FooterPanel: TDnMPanel
    Color = 14671805
    HelpContext = 285050
    inherited cmdNew: TDNMSpeedButton
      Enabled = False
    end
    inherited barStatus: TAdvOfficeStatusBar
      Panels = <
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          Text = 'Current Filter'
          TimeFormat = 'hh:mm:ss'
          Width = 80
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          TimeFormat = 'hh:mm:ss'
          Width = 700
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psOwnerDraw
          TimeFormat = 'hh:mm:ss'
          Width = 50
          OfficeHint.Picture.Data = {}
        end>
    end
  end
  inherited HeaderPanel: TPanel
    HelpContext = 285020
    Color = 14671805
    inherited lblFrom: TLabel
      Left = 29
      Top = 44
      HelpContext = 285021
      Visible = False
    end
    inherited lblTo: TLabel
      Left = 152
      Top = 44
      HelpContext = 285022
      Visible = False
    end
    inherited pnlHeader: TPanel
      Left = 264
      Width = 441
      HelpContext = 285023
      Caption = 'Fixed Assets Details'
      Color = 14671805
      ParentColor = False
      inherited TitleShader: TShader
        Width = 439
        HelpContext = 285024
        inherited TitleLabel: TLabel
          Width = 439
          HelpContext = 285025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 285026
      inherited grpFilters: TwwRadioGroup
        HelpContext = 285027
        ItemIndex = 0
        Items.Strings = (
          'Summary'
          'Details')
      end
      inherited pnlButtons: TPanel
        HelpContext = 285028
        inherited lblcustomReport: TLabel
          HelpContext = 285029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 285030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 285031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 285032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 285033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 285034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 285035
      inherited lblFilter: TLabel
        HelpContext = 285036
      end
      inherited lblSearchoptions: TLabel
        HelpContext = 285037
      end
      inherited cboFilter: TComboBox
        HelpContext = 285038
      end
      inherited edtSearch: TEdit
        HelpContext = 285039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      Left = 65
      Top = 40
      HelpContext = 285040
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      Left = 169
      Top = 40
      HelpContext = 285041
      Visible = False
    end
    inherited cboDateRange: TComboBox
      HelpContext = 285042
      TabOrder = 7
    end
    inherited chkIgnoreDates: TCheckBox
      TabOrder = 8
    end
    object rgDetails: TwwRadioGroup
      Left = 0
      Top = 0
      Width = 257
      Height = 54
      HelpContext = 285043
      ItemIndex = 0
      Frame.FocusStyle = efsFrameRaised
      Frame.NonFocusStyle = efsFrameRaised
      ButtonFrame.AutoSizeHeightAdjust = 2
      ButtonFrame.FocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
      ButtonFrame.NonFocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
      ButtonFrame.FocusStyle = efsFrameRaised
      Caption = 'Depreciation Details'
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Items.Strings = (
        'Depreciation #1'
        'Depreciation #2')
      ParentFont = False
      TabOrder = 5
      OnClick = rgDetailsClick
    end
    object DNMPanel1: TDNMPanel
      Left = 708
      Top = 4
      Width = 285
      Height = 50
      HelpContext = 285044
      Color = 14671805
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      object Label4: TLabel
        Left = 5
        Top = 19
        Width = 72
        Height = 16
        HelpContext = 285045
        AutoSize = False
        Caption = 'Asset Type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
      object Label5: TLabel
        Left = 237
        Top = 19
        Width = 20
        Height = 16
        HelpContext = 285046
        AutoSize = False
        Caption = 'All '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
      object cboAssetType: TwwDBLookupCombo
        Left = 80
        Top = 15
        Width = 145
        Height = 23
        HelpContext = 285047
        DropDownAlignment = taLeftJustify
        LookupTable = qryAssetType
        LookupField = 'AssetTypeCode'
        Style = csDropDownList
        DropDownWidth = 40
        TabOrder = 0
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboAssetTypeCloseUp
      end
      object chkAll: TCheckBox
        Left = 256
        Top = 18
        Width = 14
        Height = 17
        HelpContext = 285048
        TabOrder = 1
        OnClick = chkAllClick
      end
    end
  end
  inherited Panel1: TPanel
    HelpContext = 285049
    inherited grdMain: TwwDBGrid
      HelpContext = 285050
      Selected.Strings = (
        'Asset Name'#9'20'#9'Asset Name'
        'Asset Code'#9'15'#9'Asset Code'
        'Purchase Date'#9'10'#9'Purchase Date'
        'Asset Type'#9'15'#9'Asset Type'
        'Date'#9'10'#9'Date'
        'Location'#9'20'#9'Location'
        'Total Depreciation'#9'10'#9'Total Depreciation'
        'Purchase Cost'#9'10'#9'Purchase Cost'
        'Replacement Cost'#9'10'#9'Replacement Cost'
        'Life (Years)'#9'10'#9'Life (Years)'
        'Salvage'#9'10'#9'Salvage'
        'Disposed'#9'1'#9'Disposed'
        'Disposal Date'#9'10'#9'Disposal Date'
        'Disposal BookValue'#9'10'#9'Disposal BookValue'
        'Department'#9'20'#9'Department'
        'Depreciation Option'#9'15'#9'Depreciation Option'
        'Part Name'#9'20'#9'Part Name'
        'Business Use'#9'10'#9'Business Use')
      TitleColor = 14671805
    end
  end
  inherited dsMain: TDataSource
    Left = 806
    Top = 392
  end
  inherited dlgSave: TSaveDialog
    Left = 881
    Top = 392
  end
  inherited imgPopup: TImageList
    Left = 944
    Top = 424
  end
  inherited dlgPrint: TPdtPrintDAT
    Left = 769
    Top = 392
  end
  inherited actlstFilters: TActionList
    Left = 912
    Top = 392
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 769
    Top = 423
  end
  inherited wwLocateDialog1: TwwLocateDialog
    Left = 943
    Top = 394
  end
  inherited CloseModalTimer: TTimer
    Left = 875
    Top = 426
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      '# DUMMY SQL - See RefreshQuery()'
      ''
      'SELECT'
      
        '  FA.AssetID, 1 AS Details, SPACE(200) AS "Asset Name", SPACE(20' +
        '0) AS "Asset Code", FA.PurchDate AS "Purchase Date",'
      '  SPACE(200) AS "Asset Type", SPACE(200) AS "Location",'
      '  FADD.TotalDepreciation AS "Total Depreciation",'
      '  FADD.Date AS "Date",'
      
        'FA.PurchCost AS "Purchase Cost", FA.ReplacementCost AS "Replacem' +
        'ent Cost",'
      'FA.Life AS "Life (Years)",'
      
        'FA.Salvage AS "Salvage", FA.Disposal AS "Disposed", FA.DisposalD' +
        'ate AS "Disposal Date",'
      'FA.DisposalBookValue AS "Disposal BookValue",'
      'SPACE(200) AS "Depreciation Option",'
      'SPACE(200) AS "Department", SPACE(200) AS "Part Name",'
      'FA.BusinessUsePercent AS "Business Use"'
      'FROM tblfixedassets AS FA'
      
        'INNER JOIN tblfixedassetsdepreciationdetails AS FADD Using(Asset' +
        'ID)'
      'WHERE (FA.Active = "T")'
      '#GROUP BY FA.AssetID'
      ''
      'UNION ALL'
      ''
      'SELECT'
      
        'FA.AssetID, 0 AS Details, AssetName AS "Asset Name", AssetCode A' +
        'S "Asset Code", FA.PurchDate AS "Purchase Date",'
      'AssetType AS "Asset Type", LocationDescription AS "Location",'
      
        'SUM(FADD.Depreciation) AS "Total Depreciation", FA.PurchDate AS ' +
        '"Date",'
      
        'FA.PurchCost AS "Purchase Cost", FA.ReplacementCost AS "Replacem' +
        'ent Cost",'
      
        'Life AS "Life (Years)", FA.Salvage AS "Salvage", FA.Disposal AS ' +
        '"Disposed", FA.DisposalDate AS "Disposal Date",'
      'FA.DisposalBookValue AS "Disposal BookValue",'
      'CASE FA.DepreciationOption'
      '  WHEN 1 THEN "No Depreciation"'
      '  WHEN 2 THEN "Straight Line"'
      '  WHEN 3 THEN "Declining Balance"'
      '  ELSE "No Depreciation"'
      'END AS "Depreciation Option",'
      'C.ClassName AS "Department", FA.PartName AS "Part Name",'
      'FA.BusinessUsePercent AS "Business Use"'
      'FROM tblfixedassets AS FA'
      
        'INNER JOIN tblfixedassetsdepreciationdetails AS FADD Using(Asset' +
        'ID)'
      'INNER JOIN tblclass AS C on FA.ClassID = C.ClassID'
      'WHERE (FA.Active = "T")'
      'GROUP BY FA.AssetID')
    Left = 839
    Top = 393
    object qryMainAssetName: TWideStringField
      DisplayWidth = 20
      FieldName = 'Asset Name'
      Origin = '.`Asset Name`'
      FixedChar = True
      Size = 200
    end
    object qryMainAssetCode: TWideStringField
      DisplayWidth = 15
      FieldName = 'Asset Code'
      Origin = '.`Asset Code`'
      FixedChar = True
      Size = 200
    end
    object qryMainPurchaseDate: TDateField
      DisplayWidth = 10
      FieldName = 'Purchase Date'
      Origin = 'tblfixedassets.`Purchase Date`'
    end
    object qryMainAssetType: TWideStringField
      DisplayWidth = 15
      FieldName = 'Asset Type'
      Origin = '.`Asset Type`'
      FixedChar = True
      Size = 200
    end
    object qryMainDate: TDateField
      FieldName = 'Date'
      Origin = 'FADD.Date'
    end
    object qryMainLocation: TWideStringField
      DisplayWidth = 20
      FieldName = 'Location'
      Origin = '.Location'
      FixedChar = True
      Size = 200
    end
    object qryMainTotalDepreciation: TFloatField
      DisplayWidth = 10
      FieldName = 'Total Depreciation'
      Origin = 'FADD.`Total Depreciation`'
      currency = True
    end
    object qryMainPurchaseCost: TFloatField
      DisplayWidth = 10
      FieldName = 'Purchase Cost'
      Origin = 'tblfixedassets.`Purchase Cost`'
      currency = True
    end
    object qryMainReplacementCost: TFloatField
      DisplayWidth = 10
      FieldName = 'Replacement Cost'
      Origin = 'tblfixedassets.`Replacement Cost`'
      currency = True
    end
    object qryMainLifeYears: TFloatField
      DisplayWidth = 10
      FieldName = 'Life (Years)'
      Origin = 'tblfixedassets.`Life (Years)`'
    end
    object qryMainSalvage: TFloatField
      DisplayWidth = 10
      FieldName = 'Salvage'
      Origin = 'tblfixedassets.Salvage'
      currency = True
    end
    object qryMainDisposed: TWideStringField
      DisplayWidth = 1
      FieldName = 'Disposed'
      Origin = 'tblfixedassets.Disposed'
      FixedChar = True
      Size = 1
    end
    object qryMainDisposalDate: TDateTimeField
      DisplayWidth = 10
      FieldName = 'Disposal Date'
      Origin = 'tblfixedassets.`Disposal Date`'
    end
    object qryMainDisposalBookValue: TFloatField
      DisplayWidth = 10
      FieldName = 'Disposal BookValue'
      Origin = 'tblfixedassets.`Disposal BookValue`'
      currency = True
    end
    object qryMainDepartment: TWideStringField
      DisplayWidth = 20
      FieldName = 'Department'
      Origin = '.Department'
      FixedChar = True
      Size = 200
    end
    object qryMainDepreciationOption: TWideStringField
      DisplayWidth = 15
      FieldName = 'Depreciation Option'
      Origin = '.`Depreciation Option`'
      FixedChar = True
      Size = 200
    end
    object qryMainPartName: TWideStringField
      DisplayWidth = 20
      FieldName = 'Part Name'
      Origin = '.`Part Name`'
      FixedChar = True
      Size = 200
    end
    object qryMainAssetID: TIntegerField
      DisplayWidth = 10
      FieldName = 'AssetID'
      Origin = 'tblfixedassets.AssetID'
      Visible = False
    end
    object qryMainBusinessUse: TFloatField
      DisplayWidth = 10
      FieldName = 'Business Use'
      Origin = 'tblfixedassets.`Business Use`'
      DisplayFormat = '#0.00%'
    end
    object qryMainDetails: TLargeintField
      DisplayWidth = 15
      FieldName = 'Details'
      Origin = '.Details'
      Visible = False
    end
  end
  inherited qryPersonalPrefs: TERPQuery
    Left = 839
    Top = 425
  end
  inherited mnuFilter: TAdvPopupMenu
    Left = 912
    Top = 424
  end
  object qryAssetType: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT'
      'AssetTypeID, AssetTypeCode'
      'FROM tblfixedassettypes'
      'ORDER BY AssetTypeCode;')
    Left = 944
    Top = 360
  end
end
