inherited RollaBlindDropDataListGUI: TRollaBlindDropDataListGUI
  Caption = 'Drop Data List'
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
    inherited pnlHeader: TPanel
      Left = 223
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
        'ProfileType'#9'50'#9'Profile Type'#9#9
        'Category'#9'50'#9'Housing Type'#9#9
        'MinDrop'#9'10'#9'Min Drop'#9#9
        'MaxDrop'#9'10'#9'Max Drop'#9#9
        'HiddenProfiles'#9'10'#9'Hidden Profiles'#9#9
        'ProfileWidth'#9'10'#9'Profile Width'#9#9
        'HousingHeight'#9'10'#9'Housing Height'#9#9
        'Perforated'#9'1'#9'Perforated'#9#9)
      TitleColor = clSilver
    end
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      'SELECT *'
      'FROM tblrollaprofdata')
    object qryMainProfDataID: TIntegerField
      FieldName = 'ProfDataID'
      Visible = False
    end
    object qryMainGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryMainProfileType: TStringField
      DisplayLabel = 'Profile Type'
      DisplayWidth = 50
      FieldName = 'ProfileType'
      Size = 50
    end
    object qryMainCategory: TStringField
      DisplayLabel = 'Housing Type'
      DisplayWidth = 50
      FieldName = 'Category'
      Size = 50
    end
    object qryMainMinDrop: TFloatField
      DisplayLabel = 'Min Drop'
      DisplayWidth = 10
      FieldName = 'MinDrop'
    end
    object qryMainMaxDrop: TFloatField
      DisplayLabel = 'Max Drop'
      DisplayWidth = 10
      FieldName = 'MaxDrop'
    end
    object qryMainHiddenProfiles: TFloatField
      DisplayLabel = 'Hidden Profiles'
      DisplayWidth = 10
      FieldName = 'HiddenProfiles'
    end
    object qryMainProfileWidth: TFloatField
      DisplayLabel = 'Profile Width'
      DisplayWidth = 10
      FieldName = 'ProfileWidth'
    end
    object qryMainHousingHeight: TFloatField
      DisplayLabel = 'Housing Height'
      DisplayWidth = 10
      FieldName = 'HousingHeight'
    end
    object qryMainPerforated: TStringField
      DisplayWidth = 1
      FieldName = 'Perforated'
      FixedChar = True
      Size = 1
    end
    object qryMainmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Visible = False
    end
  end
end
