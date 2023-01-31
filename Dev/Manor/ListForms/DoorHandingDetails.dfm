inherited DoorHandingDetailsGUI: TDoorHandingDetailsGUI
  Left = 223
  Top = 140
  HelpContext = 105000
  Caption = 'Door Handing Detail List'
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 105001
  end
  inherited FooterPanel: TPanel
    HelpContext = 105002
    inherited Label3: TLabel
      HelpContext = 105003
    end
    inherited lblTotal: TLabel
      HelpContext = 105004
    end
    inherited lblNote: TLabel
      HelpContext = 105005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 105006
    end
    inherited lblTime: TLabel
      HelpContext = 105007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 105008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 105009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 105010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 105011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 105012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 105013
      inherited LblChooseTemplate: TLabel
        HelpContext = 105014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 105015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 105016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 105017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 105018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 105019
    end
  end
  inherited HeaderPanel: TPanel
    HelpContext = 105020
    inherited lblFrom: TLabel
      HelpContext = 105021
    end
    inherited lblTo: TLabel
      HelpContext = 105022
    end
    inherited pnlHeader: TPanel
      HelpContext = 105023
      inherited TitleShader: TShader
        HelpContext = 105024
        inherited TitleLabel: TLabel
          HelpContext = 105025
          Caption = 'Door Handing Detail List'
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 105026
      inherited grpFilters: TRadioGroup
        HelpContext = 105027
      end
      inherited pnlButtons: TPanel
        HelpContext = 105028
        inherited lblcustomReport: TLabel
          HelpContext = 105029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 105030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 105031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 105032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 105033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 105034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 105035
      inherited Label1: TLabel
        HelpContext = 105036
      end
      inherited Label2: TLabel
        HelpContext = 105037
      end
      inherited cboFilter: TComboBox
        HelpContext = 105038
      end
      inherited edtSearch: TEdit
        HelpContext = 105039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 105040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 105041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 105042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 105043
    inherited grdMain: TwwDBGrid
      HelpContext = 105044
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'22'#9'GlobalRef'#9'F'
        'Description'#9'55'#9'Description'#9'F'
        'HandingAbbrev'#9'48'#9'Handing Abbrevation'#9'F'
        'Active'#9'10'#9'Active'#9'F')
      TitleLines = 2
      UseTFields = False
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'Select * from vwDoorHandingDetailsList')
    object qryMainGlobalRef: TStringField
      Tag = 4
      FieldName = 'GlobalRef'
      Origin = 'vwDoorHandingDetailsList.GlobalRef'
      Size = 255
    end
    object qryMainActive: TStringField
      Tag = 4
      FieldName = 'Active'
      Origin = 'vwDoorHandingDetailsList.Active'
      Size = 255
    end
    object qryMainDescription: TStringField
      Tag = 4
      FieldName = 'Description'
      Origin = 'vwDoorHandingDetailsList.Description'
      Size = 255
    end
    object qryMainHandingAbbrev: TStringField
      Tag = 4
      FieldName = 'HandingAbbrev'
      Origin = 'vwDoorHandingDetailsList.HandingAbbrev'
      Size = 255
    end
  end
end
