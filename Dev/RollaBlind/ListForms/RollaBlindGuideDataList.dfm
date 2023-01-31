inherited RollaBlindGuideDataListGUI: TRollaBlindGuideDataListGUI
  Caption = 'Guide Data List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = clSilver
  end
  inherited HeaderPanel: TPanel
    Color = clSilver
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
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
        'ProfileType'#9'50'#9'ProfileType'#9#9
        'Perforated'#9'1'#9'Perforated'#9#9
        'ShutterClipped'#9'1'#9'Clipped'#9#9
        'GuideType'#9'50'#9'GuideType'#9#9
        'Length'#9'10'#9'Length'#9#9
        'ItemNumber'#9'50'#9'Item Number'#9'F'
        'Standard'#9'1'#9'Standard'#9#9)
      TitleColor = clSilver
    end
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      'SELECT * '
      'FROM tblrollaguidedata'
      '')
    object qryMainProfileType: TStringField
      DisplayWidth = 50
      FieldName = 'ProfileType'
      Size = 50
    end
    object qryMainPerforated: TStringField
      DisplayWidth = 1
      FieldName = 'Perforated'
      FixedChar = True
      Size = 1
    end
    object qryMainShutterClipped: TStringField
      DisplayLabel = 'Clipped'
      DisplayWidth = 1
      FieldName = 'ShutterClipped'
      FixedChar = True
      Size = 1
    end
    object qryMainGuideType: TStringField
      DisplayWidth = 50
      FieldName = 'GuideType'
      Size = 50
    end
    object qryMainLength: TFloatField
      DisplayWidth = 10
      FieldName = 'Length'
    end
    object qryMainItemNumber: TStringField
      DisplayLabel = 'Item Number'
      DisplayWidth = 50
      FieldName = 'ItemNumber'
      Size = 50
    end
    object qryMainStandard: TStringField
      DisplayWidth = 1
      FieldName = 'Standard'
      FixedChar = True
      Size = 1
    end
    object qryMainGuideDataID: TIntegerField
      FieldName = 'GuideDataID'
      Visible = False
    end
    object qryMainGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryMainmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Visible = False
    end
  end
  inherited qryPersonalPrefs: TMyQuery
    ParamData = <
      item
        DataType = ftString
        Name = 'EmployeeID'
        Value = ''
      end>
  end
end
