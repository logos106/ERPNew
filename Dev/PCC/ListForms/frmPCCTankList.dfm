inherited PCCTankList: TPCCTankList
  Left = 201
  Top = 183
  Caption = 'Tank List'
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
      Caption = 'Tank List'
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
        'TankNo'#9'15'#9'TankNo'
        'TankDescription'#9'255'#9'TankDescription'
        'GradeName'#9'50'#9'GradeName'
        'PartName'#9'60'#9'PartName')
      TitleColor = 13092579
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT '
      'tblPCCTanks.TankID as TankID, '
      'tblPCCTanks.TankNo as TankNo, '
      'tblPCCTanks.TankDescription as TankDescription, '
      'tblPCCGrades.GradeName as GradeName, '
      'tblParts.PartName as PartName,'
      'tblPCCTanks.Active as Active'
      'FROM tblPCCTanks'
      'LEFT JOIN tblPCCGrades USING(GradeID)'
      'LEFT JOIN tblParts ON tblPCCTanks.ProductID = PartsID')
    Left = 86
    object qryMainTankID: TIntegerField
      FieldName = 'TankID'
      Visible = False
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
    object qryMainPartName: TStringField
      FieldName = 'PartName'
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
    Top = 31
  end
end
