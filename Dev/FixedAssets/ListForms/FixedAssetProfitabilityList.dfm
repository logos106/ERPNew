inherited frmFixedAssetProfitabilityList: TfrmFixedAssetProfitabilityList
  Left = 287
  Top = 145
  Caption = 'Fixed Asset Profitability'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 14671805
    inherited cmdClose: TDNMSpeedButton
      Left = 619
    end
    inherited cmdNew: TDNMSpeedButton
      Left = 7
      Top = -16
      Visible = False
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 504
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 390
    end
    inherited btnCustomize: TDNMSpeedButton
      Left = 276
    end
  end
  inherited HeaderPanel: TPanel
    Color = 14671805
    inherited pnlHeader: TPanel
      Caption = 'Fixed Asset Profitability'
      Color = 14671805
      ParentColor = False
    end
    inherited dtFrom: TwwDBDateTimePicker
      OnCloseUp = dtFromCloseUp
    end
    inherited dtTo: TwwDBDateTimePicker
      OnCloseUp = dtToCloseUp
    end
    inherited cboDateRange: TComboBox
      Visible = True
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'AssetID'#9'5'#9'Asset ID'#9#9
        'AssetName'#9'20'#9'Asset name'#9#9
        'Income'#9'15'#9'Income'#9#9
        'Expense'#9'15'#9'Expense'#9#9
        'Diff'#9'10'#9'Diff $'#9'F'#9
        'Diff%'#9'10'#9'Diff %'#9#9
        'Profit'#9'10'#9'Profit %'#9#9)
      TitleColor = 14671805
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgShowFooter, dgRowResize]
      FooterColor = 14671805
    end
  end
  inherited qryMain: TMyQuery
    object qryMainAssetID: TIntegerField
      DisplayLabel = 'Asset ID'
      DisplayWidth = 5
      FieldName = 'AssetID'
      Origin = 'tmp_fajobprofitability.AssetID'
    end
    object qryMainAssetName: TStringField
      DisplayLabel = 'Asset name'
      DisplayWidth = 20
      FieldName = 'AssetName'
      Origin = 'tmp_fajobprofitability.AssetName'
      Size = 255
    end
    object qryMainIncome: TFloatField
      DisplayWidth = 15
      FieldName = 'Income'
      Origin = 'tmp_fajobprofitability.Income'
      currency = True
    end
    object qryMainExpense: TFloatField
      DisplayWidth = 15
      FieldName = 'Expense'
      Origin = 'tmp_fajobprofitability.Expense'
      currency = True
    end
    object qryMainDiff: TFloatField
      DisplayLabel = 'Diff $'
      DisplayWidth = 10
      FieldName = 'Diff'
      Origin = 'tmp_fajobprofitability.Diff$'
      currency = True
    end
    object qryMainDiff2: TFloatField
      DisplayLabel = 'Diff %'
      DisplayWidth = 10
      FieldName = 'Diff%'
      Origin = 'tmp_fajobprofitability.`Diff%`'
      DisplayFormat = '#0.00%'
    end
    object qryMainProfit: TFloatField
      DisplayLabel = 'Profit %'
      DisplayWidth = 10
      FieldName = 'Profit'
      Origin = 'tmp_fajobprofitability.Profit'
      DisplayFormat = '#0.00%'
    end
    object qryMainID: TSmallintField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tmp_fajobprofitability.ID'
      Visible = False
    end
  end
  object qryTemp: TMyQuery
    Connection = MyConnection1
    Left = 944
    Top = 440
  end
end
