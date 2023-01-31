inherited RollaBlindProfileTypesListGUI: TRollaBlindProfileTypesListGUI
  Caption = 'Profile Types List'
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
      Left = 215
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
      'SELECT * '
      'FROM tblrollaprofiletypes')
    object qryMainProfileTypeID: TIntegerField
      FieldName = 'ProfileTypeID'
      Visible = False
    end
    object qryMainGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryMainProfileType: TStringField
      FieldName = 'ProfileType'
      Size = 50
    end
    object qryMainDescription: TStringField
      FieldName = 'Description'
      Size = 255
    end
    object qryMainmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Visible = False
    end
  end
end
