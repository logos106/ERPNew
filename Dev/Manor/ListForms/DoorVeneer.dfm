inherited DoorVeneerGUI: TDoorVeneerGUI
  Left = 140
  Top = 148
  HelpContext = 112000
  Caption = 'Door Veneer List'
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 112001
  end
  inherited FooterPanel: TPanel
    HelpContext = 112002
    inherited Label3: TLabel
      HelpContext = 112003
    end
    inherited lblTotal: TLabel
      HelpContext = 112004
    end
    inherited lblNote: TLabel
      HelpContext = 112005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 112006
    end
    inherited lblTime: TLabel
      HelpContext = 112007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 112008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 112009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 112010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 112011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 112012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 112013
      inherited LblChooseTemplate: TLabel
        HelpContext = 112014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 112015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 112016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 112017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 112018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 112019
    end
  end
  inherited HeaderPanel: TPanel
    HelpContext = 112020
    inherited lblFrom: TLabel
      HelpContext = 112021
    end
    inherited lblTo: TLabel
      HelpContext = 112022
    end
    inherited pnlHeader: TPanel
      HelpContext = 112023
      inherited TitleShader: TShader
        HelpContext = 112024
        inherited TitleLabel: TLabel
          HelpContext = 112025
          Caption = 'Door Veneer List'
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 112026
      inherited grpFilters: TRadioGroup
        HelpContext = 112027
      end
      inherited pnlButtons: TPanel
        HelpContext = 112028
        inherited lblcustomReport: TLabel
          HelpContext = 112029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 112030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 112031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 112032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 112033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 112034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 112035
      inherited Label1: TLabel
        HelpContext = 112036
      end
      inherited Label2: TLabel
        HelpContext = 112037
      end
      inherited cboFilter: TComboBox
        HelpContext = 112038
      end
      inherited edtSearch: TEdit
        HelpContext = 112039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 112040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 112041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 112042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 112043
    inherited grdMain: TwwDBGrid
      HelpContext = 112044
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'22'#9'GlobalRef'
        'CostPerSq'#9'26'#9'CostPerSq'#9'F'
        'VeneerName'#9'77'#9'VeneerName'
        'Active'#9'10'#9'Active')
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'select * from vwDoorVeneerList')
    object qryMainGlobalRef: TStringField
      Tag = 4
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMainCostPerSq: TStringField
      Tag = 4
      FieldName = 'CostPerSq'
      Size = 255
    end
    object qryMainVeneerName: TStringField
      Tag = 4
      FieldName = 'VeneerName'
      Size = 255
    end
    object qryMainActive: TStringField
      Tag = 4
      FieldName = 'Active'
      Size = 255
    end
  end
  inherited MyConnection1: TERPConnection
    Left = 55
  end
end
