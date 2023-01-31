inherited DoorStilesGUI: TDoorStilesGUI
  Left = 136
  Top = 269
  HelpContext = 109000
  Caption = 'Door Stile List'
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 109001
  end
  inherited FooterPanel: TPanel
    HelpContext = 109002
    inherited Label3: TLabel
      HelpContext = 109003
    end
    inherited lblTotal: TLabel
      HelpContext = 109004
    end
    inherited lblNote: TLabel
      HelpContext = 109005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 109006
    end
    inherited lblTime: TLabel
      HelpContext = 109007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 109008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 109009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 109010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 109011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 109012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 109013
      inherited LblChooseTemplate: TLabel
        HelpContext = 109014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 109015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 109016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 109017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 109018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 109019
    end
  end
  inherited HeaderPanel: TPanel
    HelpContext = 109020
    inherited lblFrom: TLabel
      HelpContext = 109021
    end
    inherited lblTo: TLabel
      HelpContext = 109022
    end
    inherited pnlHeader: TPanel
      HelpContext = 109023
      inherited TitleShader: TShader
        HelpContext = 109024
        inherited TitleLabel: TLabel
          HelpContext = 109025
          Caption = 'Door Stile List'
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 109026
      inherited grpFilters: TRadioGroup
        HelpContext = 109027
      end
      inherited pnlButtons: TPanel
        HelpContext = 109028
        inherited lblcustomReport: TLabel
          HelpContext = 109029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 109030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 109031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 109032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 109033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 109034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 109035
      inherited Label1: TLabel
        HelpContext = 109036
      end
      inherited Label2: TLabel
        HelpContext = 109037
      end
      inherited cboFilter: TComboBox
        HelpContext = 109038
      end
      inherited edtSearch: TEdit
        HelpContext = 109039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 109040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 109041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 109042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 109043
    inherited grdMain: TwwDBGrid
      HelpContext = 109044
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'26'#9'GlobalRef'
        'Code'#9'22'#9'Code'
        'CostPerMetre'#9'22'#9'CostPerMetre'
        'Stiles'#9'55'#9'Stiles'#9'F'
        'Active'#9'10'#9'Active')
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'select * from vwDoorStilesList')
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
    object qryMainCostPerMetre: TStringField
      Tag = 4
      FieldName = 'CostPerMetre'
      Size = 255
    end
    object qryMainStiles: TStringField
      Tag = 4
      FieldName = 'Stiles'
      Size = 255
    end
    object qryMainActive: TStringField
      Tag = 4
      FieldName = 'Active'
      Size = 255
    end
  end
end
