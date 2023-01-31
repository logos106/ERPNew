inherited TransRecListGUI: TTransRecListGUI
  Left = 78
  Top = 186
  HelpContext = 535000
  Caption = 'Reconciled List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 535001
  end
  inherited FooterPanel: TDnMPanel
    HelpContext = 535002
    Color = 15527129
    inherited Label3: TLabel
      HelpContext = 535003
    end
    inherited lblTotal: TLabel
      HelpContext = 535004
    end
    inherited lblNote: TLabel
      HelpContext = 535005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 535006
    end
    inherited lblTime: TLabel
      HelpContext = 535007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 535008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 535009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 535010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 535011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 535012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 535013
      inherited LblChooseTemplate: TLabel
        HelpContext = 535014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 535015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 535016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 535017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 535018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 535019
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
    HelpContext = 535020
    Color = 15527129
    inherited lblFrom: TLabel
      HelpContext = 535021
    end
    inherited lblTo: TLabel
      HelpContext = 535022
    end
    inherited pnlHeader: TPanel
      HelpContext = 535023
      Caption = 'Reconciled List'
      inherited TitleShader: TShader
        HelpContext = 535024
        inherited TitleLabel: TLabel
          HelpContext = 535025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 535026
      inherited grpFilters: TwwRadioGroup
        HelpContext = 535027
      end
      inherited pnlButtons: TPanel
        HelpContext = 535028
        inherited lblcustomReport: TLabel
          HelpContext = 535029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 535030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 535031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 535032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 535033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 535034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 535035
      inherited lblFilter: TLabel
        HelpContext = 535036
      end
      inherited lblSearchoptions: TLabel
        HelpContext = 535037
      end
      inherited cboFilter: TComboBox
        HelpContext = 535038
      end
      inherited edtSearch: TEdit
        HelpContext = 535039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 535040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 535041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 535042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 535043
    inherited grdMain: TwwDBGrid
      HelpContext = 535044
      TitleColor = 15527129
    end
  end
end
