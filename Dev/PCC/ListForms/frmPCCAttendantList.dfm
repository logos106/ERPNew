inherited PCCAttendantList: TPCCAttendantList
  Left = 194
  Top = 85
  Caption = 'Attendant List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 13092579
  end
  inherited HeaderPanel: TPanel
    Color = 13092579
    inherited pnlHeader: TPanel
      Caption = 'Attendant List'
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
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'EmployeeName'#9'81'#9'EmployeeName'
        'Active'#9'1'#9'Active')
      TitleColor = 13092579
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT '
      'PCCAttendantID as PCCAttendantID,'
      'AttendantID as AttendantID,'
      'CONCAT_WS(SPACE(1),FirstName,LastName) as EmployeeName,'
      'tblPCCAttendants.Active'
      'FROM tblPCCAttendants'
      'LEFT JOIN tblEmployees Using(EmployeeID)')
    object qryMainPCCAttendantID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PCCAttendantID'
      Origin = 'tblPCCAttendants.PCCAttendantID'
      Visible = False
    end
    object qryMainAttendantID: TWordField
      FieldName = 'AttendantID'
      Origin = 'tblPCCAttendants.AttendantID'
      Visible = False
    end
    object qryMainEmployeeName: TStringField
      FieldName = 'EmployeeName'
      Origin = 'tblPCCAttendants.EmployeeName'
      Size = 81
    end
    object qryMainActive: TStringField
      FieldName = 'Active'
      Origin = 'tblPCCAttendants.Active'
      FixedChar = True
      Size = 1
    end
  end
end
