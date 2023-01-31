inherited PoolTestDefaultsListGUI: TPoolTestDefaultsListGUI
  Left = 42
  Top = 445
  Caption = 'Pool Test Defaults'
  ClientHeight = 476
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    Top = 463
  end
  inherited FooterPanel: TPanel
    Top = 383
    Color = 15527129
    inherited cmdClose: TDNMSpeedButton
      Left = 635
    end
    inherited cmdNew: TDNMSpeedButton
      Enabled = False
      Visible = False
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 516
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 397
    end
    inherited btnCustomize: TDNMSpeedButton
      Left = 279
    end
  end
  inherited HeaderPanel: TPanel
    Color = 15527129
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited pnlHeader: TPanel
      Caption = 'Pool Test Defaults'
    end
    inherited Panel2: TPanel
      Color = 15527129
      ParentColor = False
      inherited grpFilters: TRadioGroup
        Columns = 4
        Items.Strings = (
          'Construction'
          'Sanitizer'
          'Common'
          'All')
      end
    end
    inherited Panel3: TPanel
    end
    inherited dtFrom: TwwDBDateTimePicker
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Height = 254
    inherited grdMain: TwwDBGrid
      Height = 254
      Selected.Strings = (
        'Type'#9'12'#9'Type'#9'F'#9
        'Category'#9'30'#9'Category'#9'F'#9
        'Substance'#9'30'#9'Substance'#9'F'#9
        'TargetValue'#9'10'#9'Target Value'#9'F'#9
        'Minimum'#9'10'#9'Minimum Range Value'#9'F'#9
        'Maximum'#9'10'#9'Maximum Range Value'#9'F'#9
        'DecreasePartNo'#9'10'#9'Decrease Part No.'#9'F'#9
        'DecreaseDose'#9'10'#9'Decrease Dose'#9'F'#9
        'DecreaseRslt'#9'10'#9'Decrease Result'#9'F'#9
        'IncreasePartNo'#9'10'#9'Increase Part No.'#9'F'#9
        'IncreaseDose'#9'10'#9'Increase Dose'#9'F'#9
        'IncreaseRslt'#9'10'#9'Increase Result'#9'F'#9)
      TitleColor = 15527129
      FooterCellColor = 15527129
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT DT.DefaultTestId, '
      
        'if (TC.Construction="T" , "Construction", if (  TC.Sanitizer="T"' +
        ' ,  "Sanitizer", "")) as Type, '
      
        'if (TC.Construction="T" , 0, if (  TC.Sanitizer="T" ,  1, 2)) as' +
        ' ValuetypeID, '
      
        'TC.Name Category, DT.Name Substance, DT.TargetValue, DT.Minimum,' +
        ' '
      'DT.Maximum, DT.DecreasePartNo, DT.DecreaseDose, '
      'DT.DecreaseRslt, DT.IncreasePartNo, DT.IncreaseDose, '
      'DT.IncreaseRslt , DT.IncreasePartID, DT.DecreasePartID'
      
        'FROM tblpooldefaulttest DT INNER JOIN tblpooltestcategories TC O' +
        'N '
      'DT.TestCategoriesID = TC.TestCategoriesID'
      'ORDER BY type, TC.Name, DT.Name;')
    object qryMainType: TStringField
      DisplayWidth = 12
      FieldName = 'Type'
      Origin = '.Type'
      Size = 12
    end
    object qryMainCategory: TStringField
      DisplayWidth = 30
      FieldName = 'Category'
      Origin = 'TC.Category'
      Size = 30
    end
    object qryMainSubstance: TStringField
      DisplayWidth = 30
      FieldName = 'Substance'
      Origin = 'tblpooldefaulttest.Substance'
      Size = 30
    end
    object qryMainTargetValue: TFloatField
      DisplayLabel = 'Target Value'
      DisplayWidth = 10
      FieldName = 'TargetValue'
      Origin = 'tblpooldefaulttest.TargetValue'
    end
    object qryMainMinimum: TFloatField
      DisplayLabel = 'Minimum Range Value'
      DisplayWidth = 10
      FieldName = 'Minimum'
      Origin = 'tblpooldefaulttest.Minimum'
    end
    object qryMainMaximum: TFloatField
      DisplayLabel = 'Maximum Range Value'
      DisplayWidth = 10
      FieldName = 'Maximum'
      Origin = 'tblpooldefaulttest.Maximum'
    end
    object qryMainDecreasePartNo: TStringField
      DisplayLabel = 'Decrease Part No.'
      DisplayWidth = 10
      FieldName = 'DecreasePartNo'
      Origin = 'tblpooldefaulttest.DecreasePartNo'
      Size = 10
    end
    object qryMainDecreaseDose: TFloatField
      DisplayLabel = 'Decrease Dose'
      DisplayWidth = 10
      FieldName = 'DecreaseDose'
      Origin = 'tblpooldefaulttest.DecreaseDose'
    end
    object qryMainDecreaseRslt: TFloatField
      DisplayLabel = 'Decrease Result'
      DisplayWidth = 10
      FieldName = 'DecreaseRslt'
      Origin = 'tblpooldefaulttest.DecreaseRslt'
    end
    object qryMainIncreasePartNo: TStringField
      DisplayLabel = 'Increase Part No.'
      DisplayWidth = 10
      FieldName = 'IncreasePartNo'
      Origin = 'tblpooldefaulttest.IncreasePartNo'
      Size = 10
    end
    object qryMainIncreaseDose: TFloatField
      DisplayLabel = 'Increase Dose'
      DisplayWidth = 10
      FieldName = 'IncreaseDose'
      Origin = 'tblpooldefaulttest.IncreaseDose'
    end
    object qryMainIncreaseRslt: TFloatField
      DisplayLabel = 'Increase Result'
      DisplayWidth = 10
      FieldName = 'IncreaseRslt'
      Origin = 'tblpooldefaulttest.IncreaseRslt'
    end
    object qryMainDefaultTestId: TIntegerField
      FieldName = 'DefaultTestId'
      Origin = 'tblpooldefaulttest.DefaultTestId'
      Visible = False
    end
    object qryMainValuetypeID: TIntegerField
      FieldName = 'ValuetypeID'
      Origin = '.ValuetypeID'
      Visible = False
    end
    object qryMainIncreasePartID: TIntegerField
      FieldName = 'IncreasePartID'
      Origin = 'tblpooldefaulttest.IncreasePartID'
      Visible = False
    end
    object qryMainDecreasePartID: TIntegerField
      FieldName = 'DecreasePartID'
      Origin = 'tblpooldefaulttest.DecreasePartID'
      Visible = False
    end
  end
  inherited qryPersonalPrefs: TMyQuery
    Connection = MyConnection1
  end
end
