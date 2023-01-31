inherited DoorLippingGUI: TDoorLippingGUI
  HelpContext = 108000
  Caption = 'Door Lipping List'
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 108001
  end
  inherited FooterPanel: TPanel
    HelpContext = 108002
    inherited Label3: TLabel
      HelpContext = 108003
    end
    inherited lblTotal: TLabel
      HelpContext = 108004
    end
    inherited lblNote: TLabel
      HelpContext = 108005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 108006
    end
    inherited lblTime: TLabel
      HelpContext = 108007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 108008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 108009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 108010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 108011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 108012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 108013
      inherited LblChooseTemplate: TLabel
        HelpContext = 108014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 108015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 108016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 108017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 108018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 108019
    end
  end
  inherited HeaderPanel: TPanel
    HelpContext = 108020
    inherited lblFrom: TLabel
      HelpContext = 108021
    end
    inherited lblTo: TLabel
      HelpContext = 108022
    end
    inherited pnlHeader: TPanel
      HelpContext = 108023
      inherited TitleShader: TShader
        HelpContext = 108024
        inherited TitleLabel: TLabel
          HelpContext = 108025
          Caption = 'Door Lipping List'
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 108026
      inherited grpFilters: TRadioGroup
        HelpContext = 108027
      end
      inherited pnlButtons: TPanel
        HelpContext = 108028
        inherited lblcustomReport: TLabel
          HelpContext = 108029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 108030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 108031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 108032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 108033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 108034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 108035
      inherited Label1: TLabel
        HelpContext = 108036
      end
      inherited Label2: TLabel
        HelpContext = 108037
      end
      inherited cboFilter: TComboBox
        HelpContext = 108038
      end
      inherited edtSearch: TEdit
        HelpContext = 108039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 108040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 108041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 108042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 108043
    inherited grdMain: TwwDBGrid
      HelpContext = 108044
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'26'#9'GlobalRef'#9'F'
        'LipCost'#9'22'#9'LipCost'
        'LipSize'#9'33'#9'LipSize'
        'LipType'#9'44'#9'LipType'
        'Active'#9'10'#9'Active')
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'select * from vwDoorLippingsList')
    object qryMainGlobalRef: TStringField
      Tag = 4
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMainLipCost: TStringField
      Tag = 4
      FieldName = 'LipCost'
      Size = 255
    end
    object qryMainLipSize: TStringField
      Tag = 4
      FieldName = 'LipSize'
      Size = 255
    end
    object qryMainLipType: TStringField
      Tag = 4
      FieldName = 'LipType'
      Size = 255
    end
    object qryMainActive: TStringField
      Tag = 4
      FieldName = 'Active'
      Size = 255
    end
  end
end
