inherited frmFuncRoomListGUI: TfrmFuncRoomListGUI
  Left = 121
  Top = 188
  Caption = 'Function Room List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 14609623
  end
  inherited HeaderPanel: TPanel
    Color = 14609623
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited pnlHeader: TPanel
    end
    inherited dtFrom: TwwDBDateTimePicker
      Top = 31
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      Visible = False
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'GlobalRef'#9'15'#9'GlobalRef'#9'F'
        'RoomID'#9'10'#9'RoomID'#9#9
        'RoomName'#9'50'#9'RoomName'#9'F'
        'Capacity'#9'10'#9'Capacity'#9#9
        'ResetTime'#9'18'#9'ResetTime'#9#9
        'PerDay'#9'10'#9'PerDay'#9#9
        'PerHalfDay'#9'10'#9'PerHalfDay'#9#9
        'PerHour'#9'10'#9'PerHour'#9#9
        'ParentRoom'#9'50'#9'ParentRoom'#9'F'
        'Active'#9'1'#9'Active'#9#9)
      TitleColor = 14609623
      FooterColor = 12054011
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT R1.GlobalRef, R1.RoomID,'
      'R1.Name as RoomName,'
      'R1.Capacity,'
      'R1.ResetTime,'
      'R1.PerDay,'
      'R1.PerHalfDay,'
      'R1.PerHour,'
      'R2.Name as ParentRoom,'
      'R1.Active '
      'FROM'
      'tblfuncrooms as R1'
      'LEFT JOIN tblfuncrooms as R2 ON R2.RoomID = R1.ParentRoomID')
    Left = 88
    Top = 0
    object qryMainGlobalRef: TStringField
      DisplayWidth = 15
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMainRoomID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'RoomID'
      Origin = 'tblfuncrooms.RoomID'
    end
    object qryMainRoomName: TStringField
      DisplayWidth = 50
      FieldName = 'RoomName'
      Origin = 'tblfuncrooms.RoomName'
      Size = 255
    end
    object qryMainCapacity: TIntegerField
      DisplayWidth = 10
      FieldName = 'Capacity'
      Origin = 'tblfuncrooms.Capacity'
    end
    object qryMainResetTime: TDateTimeField
      DisplayWidth = 18
      FieldName = 'ResetTime'
      Origin = 'tblfuncrooms.ResetTime'
      DisplayFormat = 'hh:nn'
    end
    object qryMainPerDay: TFloatField
      DisplayWidth = 10
      FieldName = 'PerDay'
      Origin = 'tblfuncrooms.PerDay'
      currency = True
    end
    object qryMainPerHalfDay: TFloatField
      DisplayWidth = 10
      FieldName = 'PerHalfDay'
      Origin = 'tblfuncrooms.PerHalfDay'
      currency = True
    end
    object qryMainPerHour: TFloatField
      DisplayWidth = 10
      FieldName = 'PerHour'
      Origin = 'tblfuncrooms.PerHour'
      currency = True
    end
    object qryMainParentRoom: TStringField
      DisplayWidth = 50
      FieldName = 'ParentRoom'
      Origin = 'R2.ParentRoom'
      Size = 255
    end
    object qryMainActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblfuncrooms.Active'
      FixedChar = True
      Size = 1
    end
  end
  inherited qryPersonalPrefs: TMyQuery
    Left = 89
  end
end
