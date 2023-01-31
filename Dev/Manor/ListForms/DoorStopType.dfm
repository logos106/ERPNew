inherited DoorStopTypeGUI: TDoorStopTypeGUI
  HelpContext = 110000
  Caption = 'Door Stop Type List'
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 110001
  end
  inherited FooterPanel: TPanel
    HelpContext = 110002
    inherited Label3: TLabel
      HelpContext = 110003
    end
    inherited lblTotal: TLabel
      HelpContext = 110004
    end
    inherited lblNote: TLabel
      HelpContext = 110005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 110006
    end
    inherited lblTime: TLabel
      HelpContext = 110007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 110008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 110009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 110010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 110011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 110012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 110013
      inherited LblChooseTemplate: TLabel
        HelpContext = 110014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 110015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 110016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 110017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 110018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 110019
      Panels = <
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          Text = 'Current Filter'
          TimeFormat = 'hh:mm:ss'
          Width = 80
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          TimeFormat = 'hh:mm:ss'
          Width = 700
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psOwnerDraw
          TimeFormat = 'hh:mm:ss'
          Width = 50
          OfficeHint.Picture.Data = {}
        end>
    end
  end
  inherited HeaderPanel: TPanel
    HelpContext = 110020
    inherited lblFrom: TLabel
      HelpContext = 110021
    end
    inherited lblTo: TLabel
      HelpContext = 110022
    end
    inherited pnlHeader: TPanel
      HelpContext = 110023
      inherited TitleShader: TShader
        HelpContext = 110024
        inherited TitleLabel: TLabel
          HelpContext = 110025
          Caption = 'Door Stop Type List'
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 110026
      inherited grpFilters: TRadioGroup
        HelpContext = 110027
      end
      inherited pnlButtons: TPanel
        HelpContext = 110028
        inherited lblcustomReport: TLabel
          HelpContext = 110029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 110030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 110031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 110032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 110033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 110034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 110035
      inherited Label1: TLabel
        HelpContext = 110036
      end
      inherited Label2: TLabel
        HelpContext = 110037
      end
      inherited cboFilter: TComboBox
        HelpContext = 110038
      end
      inherited edtSearch: TEdit
        HelpContext = 110039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 110040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 110041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 110042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 110043
    inherited grdMain: TwwDBGrid
      HelpContext = 110044
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'22'#9'GlobalRef'
        'StopType'#9'20'#9'StopType'
        'Active'#9'10'#9'Active')
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'select * from vwDoorStoptypeList')
    object qryMainGlobalRef: TStringField
      Tag = 4
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMainStopType: TStringField
      Tag = 4
      FieldName = 'StopType'
      Size = 255
    end
    object qryMainActive: TStringField
      Tag = 4
      FieldName = 'Active'
      Size = 255
    end
  end
end
