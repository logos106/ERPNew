inherited DoorSundryGUI: TDoorSundryGUI
  HelpContext = 111000
  Caption = 'Door Sundry List'
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 111001
  end
  inherited FooterPanel: TPanel
    HelpContext = 111002
    inherited Label3: TLabel
      HelpContext = 111003
    end
    inherited lblTotal: TLabel
      HelpContext = 111004
    end
    inherited lblNote: TLabel
      HelpContext = 111005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 111006
    end
    inherited lblTime: TLabel
      HelpContext = 111007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 111008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 111009
      Enabled = False
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 111010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 111011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 111012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 111013
      inherited LblChooseTemplate: TLabel
        HelpContext = 111014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 111015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 111016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 111017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 111018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 111019
    end
  end
  inherited HeaderPanel: TPanel
    HelpContext = 111020
    inherited lblFrom: TLabel
      HelpContext = 111021
    end
    inherited lblTo: TLabel
      HelpContext = 111022
    end
    inherited pnlHeader: TPanel
      HelpContext = 111023
      inherited TitleShader: TShader
        HelpContext = 111024
        inherited TitleLabel: TLabel
          HelpContext = 111025
          Caption = 'Door Sundry List'
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 111026
      inherited grpFilters: TRadioGroup
        HelpContext = 111027
      end
      inherited pnlButtons: TPanel
        HelpContext = 111028
        inherited lblcustomReport: TLabel
          HelpContext = 111029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 111030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 111031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 111032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 111033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 111034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 111035
      inherited Label1: TLabel
        HelpContext = 111036
      end
      inherited Label2: TLabel
        HelpContext = 111037
      end
      inherited cboFilter: TComboBox
        HelpContext = 111038
      end
      inherited edtSearch: TEdit
        HelpContext = 111039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 111040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 111041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 111042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 111043
    inherited grdMain: TwwDBGrid
      HelpContext = 111044
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'22'#9'GlobalRef'
        'Code'#9'22'#9'Code'
        'Cost'#9'22'#9'Cost'
        'Description'#9'59'#9'Description'#9'F'
        'Active'#9'10'#9'Active')
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'select * from vwDoorSundryList')
    object qryMainGlobalRef: TStringField
      Tag = 4
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMainCode: TStringField
      Tag = 4
      FieldName = 'Code'
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
    object qryMainActive: TStringField
      Tag = 4
      FieldName = 'Active'
      Size = 255
    end
  end
end
