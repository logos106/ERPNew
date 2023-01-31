inherited DoorJoineryGUI: TDoorJoineryGUI
  HelpContext = 107000
  Caption = 'Door Joinery List'
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 107001
  end
  inherited FooterPanel: TPanel
    HelpContext = 107002
    inherited Label3: TLabel
      HelpContext = 107003
    end
    inherited lblTotal: TLabel
      HelpContext = 107004
    end
    inherited lblNote: TLabel
      HelpContext = 107005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 107006
    end
    inherited lblTime: TLabel
      HelpContext = 107007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 107008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 107009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 107010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 107011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 107012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 107013
      inherited LblChooseTemplate: TLabel
        HelpContext = 107014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 107015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 107016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 107017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 107018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 107019
    end
  end
  inherited HeaderPanel: TPanel
    HelpContext = 107020
    inherited lblFrom: TLabel
      HelpContext = 107021
    end
    inherited lblTo: TLabel
      HelpContext = 107022
    end
    inherited pnlHeader: TPanel
      HelpContext = 107023
      inherited TitleShader: TShader
        HelpContext = 107024
        inherited TitleLabel: TLabel
          HelpContext = 107025
          Caption = 'Door Joinery List'
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 107026
      inherited grpFilters: TRadioGroup
        HelpContext = 107027
      end
      inherited pnlButtons: TPanel
        HelpContext = 107028
        inherited lblcustomReport: TLabel
          HelpContext = 107029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 107030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 107031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 107032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 107033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 107034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 107035
      inherited Label1: TLabel
        HelpContext = 107036
      end
      inherited Label2: TLabel
        HelpContext = 107037
      end
      inherited cboFilter: TComboBox
        HelpContext = 107038
      end
      inherited edtSearch: TEdit
        HelpContext = 107039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 107040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 107041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 107042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 107043
    inherited grdMain: TwwDBGrid
      HelpContext = 107044
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'22'#9'GlobalRef'
        'Cost'#9'22'#9'Cost'
        'Description'#9'48'#9'Description'#9'F'
        'UnitOfCharge'#9'33'#9'UnitOfCharge'
        'Active'#9'10'#9'Active')
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'select * from vwDoorJoineryList')
    object qryMainGlobalRef: TStringField
      Tag = 4
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMainCost: TStringField
      Tag = 4
      FieldName = 'Cost'
      Size = 255
    end
    object qryMainDescription: TStringField
      Tag = 4
      FieldName = 'Description'
      Size = 255
    end
    object qryMainUnitOfCharge: TStringField
      Tag = 4
      FieldName = 'UnitOfCharge'
      Size = 255
    end
    object qryMainActive: TStringField
      Tag = 4
      FieldName = 'Active'
      Size = 255
    end
  end
end
