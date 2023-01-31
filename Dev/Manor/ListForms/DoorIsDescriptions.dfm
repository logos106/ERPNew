inherited DoorIsDescriptionsGUI: TDoorIsDescriptionsGUI
  HelpContext = 106000
  Caption = 'Door Description List'
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 106001
  end
  inherited FooterPanel: TPanel
    HelpContext = 106002
    inherited Label3: TLabel
      HelpContext = 106003
    end
    inherited lblTotal: TLabel
      HelpContext = 106004
    end
    inherited lblNote: TLabel
      HelpContext = 106005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 106006
    end
    inherited lblTime: TLabel
      HelpContext = 106007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 106008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 106009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 106010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 106011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 106012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 106013
      inherited LblChooseTemplate: TLabel
        HelpContext = 106014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 106015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 106016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 106017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 106018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 106019
    end
  end
  inherited HeaderPanel: TPanel
    HelpContext = 106020
    inherited lblFrom: TLabel
      HelpContext = 106021
    end
    inherited lblTo: TLabel
      HelpContext = 106022
    end
    inherited pnlHeader: TPanel
      HelpContext = 106023
      inherited TitleShader: TShader
        HelpContext = 106024
        inherited TitleLabel: TLabel
          HelpContext = 106025
          Caption = 'Door Description List'
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 106026
      inherited grpFilters: TRadioGroup
        HelpContext = 106027
      end
      inherited pnlButtons: TPanel
        HelpContext = 106028
        inherited lblcustomReport: TLabel
          HelpContext = 106029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 106030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 106031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 106032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 106033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 106034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 106035
      inherited Label1: TLabel
        HelpContext = 106036
      end
      inherited Label2: TLabel
        HelpContext = 106037
      end
      inherited cboFilter: TComboBox
        HelpContext = 106038
      end
      inherited edtSearch: TEdit
        HelpContext = 106039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 106040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 106041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 106042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 106043
    inherited grdMain: TwwDBGrid
      HelpContext = 106044
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'22'#9'GlobalRef'
        'Code'#9'22'#9'Code'
        'Description'#9'82'#9'Description'#9'F'
        'Active'#9'10'#9'Active')
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'select * from vwDoorIsdescriptionsList')
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
