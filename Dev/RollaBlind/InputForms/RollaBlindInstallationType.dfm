inherited RollaBlindInstallationTypeGUI: TRollaBlindInstallationTypeGUI
  Left = 174
  Top = 148
  Caption = 'Installation Types'
  ClientHeight = 589
  ClientWidth = 904
  PixelsPerInch = 96
  TextHeight = 15
  inherited DNMPanel1: TDNMPanel
    Width = 904
    Height = 589
    inherited Bevel1: TBevel
      Width = 872
      Height = 461
    end
    inherited pnlTitle: TDNMPanel
      Width = 568
    end
    inherited btnSave: TDNMSpeedButton
      Left = 302
      Top = 548
    end
    inherited btnCancel: TDNMSpeedButton
      Left = 513
      Top = 548
    end
    inherited btnNew: TDNMSpeedButton
      Left = 407
      Top = 548
    end
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      'SELECT * FROM tblrollainstallationtypes')
  end
end
