inherited fmProcStowAwaySlipList: TfmProcStowAwaySlipList
  Left = 90
  Top = 177
  HelpContext = 194000
  Caption = 'Production Stow Away Slip List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 194001
  end
  inherited FooterPanel: TPanel
    HelpContext = 194002
    inherited Label3: TLabel
      HelpContext = 194003
    end
    inherited lblTotal: TLabel
      HelpContext = 194004
    end
    inherited Label121: TLabel
      HelpContext = 194005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 194006
    end
    inherited lblTime: TLabel
      HelpContext = 194007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 194008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 194009
      Enabled = False
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 194010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 194011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 194012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 194013
      inherited LblChooseTemplate: TLabel
        HelpContext = 194014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 194015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 194016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 194017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 194018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 194019
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
    HelpContext = 194020
    inherited lblFrom: TLabel
      HelpContext = 194021
    end
    inherited lblTo: TLabel
      HelpContext = 194022
    end
    inherited pnlHeader: TPanel
      HelpContext = 194023
      inherited TitleShader: TShader
        HelpContext = 194024
        inherited TitleLabel: TLabel
          HelpContext = 194025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 194026
      inherited grpFilters: TRadioGroup
        HelpContext = 194027
        ItemIndex = 2
        Items.Strings = (
          'Stowed'
          'Not Stowed'
          'All')
      end
      inherited pnlButtons: TPanel
        HelpContext = 194028
        inherited lblcustomReport: TLabel
          HelpContext = 194029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 194030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 194031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 194032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 194033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 194034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 194035
      inherited Label1: TLabel
        HelpContext = 194036
      end
      inherited Label2: TLabel
        HelpContext = 194037
      end
      inherited cboFilter: TComboBox
        HelpContext = 194038
      end
      inherited edtSearch: TEdit
        HelpContext = 194039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 194040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 194041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 194042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 194043
    inherited grdMain: TwwDBGrid
      HelpContext = 194044
    end
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      'SELECT * FROM tblProcPickSlip')
  end
end
