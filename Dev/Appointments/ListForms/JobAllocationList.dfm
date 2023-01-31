inherited JobAllocationListGUI: TJobAllocationListGUI
  Left = 95
  Top = 164
  Caption = 'Repair Allocation List'
  ClientHeight = 557
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    Top = 464
  end
  inherited FooterPanel: TPanel
    Top = 477
    Color = 14609623
  end
  inherited HeaderPanel: TPanel
    Color = 14609623
    inherited Panel2: TPanel
      inherited grpFilters: TRadioGroup
        ItemIndex = 0
        Items.Strings = (
          'Active Repair'
          'Inactive Repairs'
          'All Repairs')
      end
    end
  end
  inherited Panel1: TPanel
    Height = 335
    inherited grdMain: TwwDBGrid
      Height = 335
      Selected.Strings = (
        'GlobalRef'#9'10'#9'Global Ref'#9'T'#9
        'Company'#9'122'#9'Company'#9'F'#9
        'EmployeeName'#9'20'#9'Employee Name'#9'T'#9
        'CreationDate'#9'10'#9'Creation Date'#9'T'#9
        'StartDateTime'#9'20'#9'Start Date Time'#9'F'#9
        'FinishDateTime'#9'20'#9'Finish Date Time'#9'F'#9
        'HoursTakenForRepair'#9'10'#9'Hours Taken For Repair'#9'F'#9
        'Notes'#9'100'#9'Notes'#9'T'#9)
      TitleColor = 14609623
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT r.GlobalRef, '
      
        'CONCAT_WS(" ", If(InStr(c.Company,'#39'^'#39') -1 >0,Left(c.Company,InSt' +
        'r(c.Company,'#39'^'#39')-1),c.Company), If(Length(c.JobName)>0, Concat("' +
        '(",c.JobName,")"),'#39#39')) as Company,'
      
        'e.EmployeeName, SUBSTRING(r.Notes, 1, 100) AS Notes, r.CreationD' +
        'ate, r.StartDateTime, r.FinishDateTime, r.HoursTakenForRepair, r' +
        '.Done, r.RepairID '
      'FROM tblrepairs r'
      'LEFT JOIN tblclients c ON r.CusID=c.ClientID'
      'INNER JOIN tblemployees e ON r.AllocatedEmployeeID=e.EmployeeID'
      
        'WHERE ((r.CreationDate BETWEEN :dtFrom AND :dtTo) OR (IsNull(r.C' +
        'reationDate)) OR (r.CreationDate='#39'1899-12-30'#39'))')
    FetchRows = 1
    ParamData = <
      item
        DataType = ftString
        Name = 'dtFrom'
        Value = ''
      end
      item
        DataType = ftUnknown
        Name = 'dtTo'
      end>
    object qryMainGlobalRef: TStringField
      DisplayLabel = 'Global Ref'
      DisplayWidth = 10
      FieldName = 'GlobalRef'
      Origin = 'tblrepairjobs.GlobalRef'
      Size = 255
    end
    object qryMainCompany: TStringField
      DisplayWidth = 122
      FieldName = 'Company'
      Size = 122
    end
    object qryMainEmployeeName: TStringField
      DisplayLabel = 'Employee Name'
      DisplayWidth = 20
      FieldName = 'EmployeeName'
      Origin = '.EmployeeName'
      Size = 81
    end
    object qryMainCreationDate: TDateField
      DisplayLabel = 'Creation Date'
      DisplayWidth = 10
      FieldName = 'CreationDate'
      Origin = 'r.CreationDate'
    end
    object qryMainStartDateTime: TDateTimeField
      DisplayLabel = 'Start Date Time'
      DisplayWidth = 20
      FieldName = 'StartDateTime'
    end
    object qryMainFinishDateTime: TDateTimeField
      DisplayLabel = 'Finish Date Time'
      DisplayWidth = 20
      FieldName = 'FinishDateTime'
    end
    object qryMainHoursTakenForRepair: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Hours Taken For Repair'
      DisplayWidth = 10
      FieldName = 'HoursTakenForRepair'
      Size = 10
    end
    object qryMainNotes: TStringField
      DisplayWidth = 100
      FieldName = 'Notes'
      Size = 100
    end
    object qryMainRepairID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RepairID'
      Visible = False
    end
  end
end
