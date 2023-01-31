inherited ScopingInputForm: TScopingInputForm
  Left = 126
  Top = 200
  PixelsPerInch = 96
  TextHeight = 15
  inherited pnlTop: TDNMPanel
    inherited DNMPanel1: TDNMPanel
      inherited lblDate: TLabel
        Left = 244
      end
      inherited Label2: TLabel
        Left = 398
      end
      inherited Label4: TLabel
        Left = 10
      end
      inherited DateTimePicker: TDateTimePicker
        Left = 244
        TabOrder = 1
      end
      inherited EmployeeLookup: TwwDBLookupCombo
        Left = 398
        TabOrder = 2
      end
      inherited cboDefinition: TwwDBLookupCombo
        Left = 10
        TabOrder = 0
      end
    end
  end
  inherited pnlBottom: TDNMPanel
    inherited btnSave: TDNMSpeedButton
      TabOrder = 2
    end
    inherited btnNew: TDNMSpeedButton
      TabOrder = 1
    end
    inherited btnCancel: TDNMSpeedButton
    end
    inherited btnPrint: TDNMSpeedButton
      TabOrder = 4
    end
  end
end
