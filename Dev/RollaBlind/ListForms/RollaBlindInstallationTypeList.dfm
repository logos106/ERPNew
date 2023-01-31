inherited RollaBlindInstallationTypeListGUI: TRollaBlindInstallationTypeListGUI
  Left = 120
  Top = 136
  Caption = 'Installation Type List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = clSilver
  end
  inherited HeaderPanel: TPanel
    Color = clSilver
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      TitleColor = clSilver
      OnDblClick = nil
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT *'
      'FROM tblrollainstallationtypes')
    object qryMainInstallationType: TStringField
      FieldName = 'InstallationType'
      Size = 50
    end
  end
end
