inherited PCCHoseList: TPCCHoseList
  Left = 272
  Top = 194
  Caption = 'Hose List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 13092579
  end
  inherited HeaderPanel: TPanel
    Color = 13092579
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited pnlHeader: TPanel
      Caption = 'Hose List'
    end
    inherited Panel2: TPanel
      inherited grpFilters: TRadioGroup
        ItemIndex = 0
        Items.Strings = (
          'Active'
          'Inactive'
          'All')
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      Visible = False
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'HoseNo'#9'5'#9'HoseNo'
        'DispenserNo'#9'5'#9'DispenserNo'
        'TankNo'#9'5'#9'TankNo'
        'TankDescription'#9'30'#9'TankDescription'
        'GradeName'#9'30'#9'GradeName'
        'ProductName'#9'40'#9'ProductName')
      TitleColor = 13092579
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT '
      'PH.HoseID as HoseID,'
      'PH.HoseNo as HoseNo,'
      'PH.DispenserNo as DispenserNo,'
      'PT.TankNo as TankNo,'
      'PT.TankDescription as TankDescription,'
      'PG.GradeName as GradeName,'
      'P.PartName as ProductName,'
      'PH.Active'
      'FROM tblPCCHoses PH'
      'LEFT JOIN tblPCCTanks PT USING(TankID)'
      'LEFT JOIN tblPCCGrades PG USING(GradeID)'
      'LEFT JOIN tblParts P ON PT.ProductID = P.PartsId'
      'ORDER BY DispenserNo, HoseNo')
    object qryMainHoseID: TIntegerField
      FieldName = 'HoseID'
      Visible = False
    end
    object qryMainHoseNo: TIntegerField
      FieldName = 'HoseNo'
    end
    object qryMainDispenserNo: TIntegerField
      FieldName = 'DispenserNo'
    end
    object qryMainTankNo: TIntegerField
      FieldName = 'TankNo'
    end
    object qryMainTankDescription: TStringField
      FieldName = 'TankDescription'
      Size = 255
    end
    object qryMainGradeName: TStringField
      FieldName = 'GradeName'
      Size = 50
    end
    object qryMainProductName: TStringField
      FieldName = 'ProductName'
      Size = 60
    end
    object qryMainActive: TStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
  end
  inherited MyConnection1: TMyConnection
    Left = 56
  end
end
