inherited PCCGradeList: TPCCGradeList
  Left = 110
  Top = 146
  Caption = 'Grade List'
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
      Caption = 'Grade List'
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
        'GradeNo'#9'10'#9'GradeNo'
        'GradeName'#9'50'#9'GradeName'
        'GradeDesc'#9'255'#9'GradeDesc'
        'Active'#9'1'#9'Active')
      TitleColor = 13092579
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT '
      'GradeID as GradeID,'
      'GradeNo as GradeNo,'
      'GradeName as GradeName,'
      'GradeDesc as GradeDesc,'
      'Active as Active'
      'FROM tblPCCGrades')
    object qryMainGradeID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'GradeID'
      Origin = 'tblPCCGrades.GradeID'
      Visible = False
    end
    object qryMainGradeNo: TIntegerField
      FieldName = 'GradeNo'
      Origin = 'tblPCCGrades.GradeNo'
    end
    object qryMainGradeName: TStringField
      FieldName = 'GradeName'
      Origin = 'tblPCCGrades.GradeName'
      Size = 50
    end
    object qryMainGradeDesc: TStringField
      FieldName = 'GradeDesc'
      Origin = 'tblPCCGrades.GradeDesc'
      Size = 255
    end
    object qryMainActive: TStringField
      FieldName = 'Active'
      Origin = 'tblPCCGrades.Active'
      FixedChar = True
      Size = 1
    end
  end
end
