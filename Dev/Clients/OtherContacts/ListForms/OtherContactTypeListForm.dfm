inherited OtherContactTypeListGUI: TOtherContactTypeListGUI
  Left = 95
  Top = 209
  HelpContext = 405000
  Caption = 'Other Contact Type List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 405001
  end
  inherited FooterPanel: TDnMPanel
    HelpContext = 405002
    Color = 14153215
    inherited Label3: TLabel
      HelpContext = 405003
    end
    inherited lblTotal: TLabel
      HelpContext = 405004
    end
    inherited lblNote: TLabel
      HelpContext = 405005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 405006
    end
    inherited lblTime: TLabel
      HelpContext = 405007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 405008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 405009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 405010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 405011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 405012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 405013
      inherited LblChooseTemplate: TLabel
        HelpContext = 405014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 405015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 405016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 405017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 405018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 405019
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
    HelpContext = 405020
    Color = 14153215
    inherited lblFrom: TLabel
      HelpContext = 405021
      Visible = False
    end
    inherited lblTo: TLabel
      HelpContext = 405022
      Visible = False
    end
    inherited pnlHeader: TPanel
      HelpContext = 405023
      inherited TitleShader: TShader
        HelpContext = 405024
        inherited TitleLabel: TLabel
          HelpContext = 405025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 405026
      inherited grpFilters: TwwRadioGroup
        HelpContext = 405027
      end
      inherited pnlButtons: TPanel
        HelpContext = 405028
        inherited lblcustomReport: TLabel
          HelpContext = 405029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 405030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 405031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 405032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 405033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 405034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 405035
      inherited lblFilter: TLabel
        HelpContext = 405036
      end
      inherited lblSearchoptions: TLabel
        HelpContext = 405037
      end
      inherited cboFilter: TComboBox
        HelpContext = 405038
      end
      inherited edtSearch: TEdit
        HelpContext = 405039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 405040
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 405041
      Visible = False
    end
    inherited cboDateRange: TComboBox
      HelpContext = 405042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 405043
    inherited grdMain: TwwDBGrid
      HelpContext = 405044
      TitleColor = 14153215
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT OtherTypeID, OtherType, EditedFlag FROM tblOtherType')
  end
end
