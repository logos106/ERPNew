inherited RollaBlindTechDataListGUI: TRollaBlindTechDataListGUI
  Left = 146
  Top = 140
  Caption = 'Technical Data List'
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
      TitleColor = clSilver
    end
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      'SELECT  *'
      'FROM tblrollainstallationmeasurements')
    object qryMainMeasurementID: TIntegerField
      FieldName = 'MeasurementID'
      Visible = False
    end
    object qryMainGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryMainInstallID: TFloatField
      FieldName = 'InstallID'
      Visible = False
    end
    object qryMainCategory: TStringField
      FieldName = 'Category'
      Size = 50
    end
    object qryMainMeasurement: TIntegerField
      FieldName = 'Measurement'
    end
    object qryMainGuideType: TStringField
      DisplayLabel = 'Guide Type'
      FieldName = 'GuideType'
      Size = 50
    end
    object qryMainType: TStringField
      FieldName = 'Type'
      Size = 50
    end
    object qryMainmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Visible = False
    end
  end
end
