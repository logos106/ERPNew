inherited PrefSettingsListGUI: TPrefSettingsListGUI
  Left = 106
  Top = 182
  HelpContext = 437000
  Caption = 'List Preferences'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 437001
  end
  inherited FooterPanel: TPanel
    HelpContext = 437002
    Color = 15527129
    inherited Label3: TLabel
      HelpContext = 437003
    end
    inherited lblTotal: TLabel
      HelpContext = 437004
    end
    inherited Label121: TLabel
      HelpContext = 437005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 437006
    end
    inherited lblTime: TLabel
      HelpContext = 437007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 437008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 437009
      Enabled = False
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 437010
      Enabled = False
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 437011
      Enabled = False
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 437012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 437013
      inherited LblChooseTemplate: TLabel
        HelpContext = 437014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 437015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 437016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 437017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 437018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 437019
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
    HelpContext = 437020
    Color = 15527129
    inherited lblFrom: TLabel
      HelpContext = 437021
      Enabled = False
    end
    inherited lblTo: TLabel
      HelpContext = 437022
      Enabled = False
    end
    inherited pnlHeader: TPanel
      HelpContext = 437023
      inherited TitleShader: TShader
        HelpContext = 437024
        inherited TitleLabel: TLabel
          HelpContext = 437025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 437026
      inherited grpFilters: TRadioGroup
        HelpContext = 437027
      end
      inherited pnlButtons: TPanel
        HelpContext = 437028
        inherited lblcustomReport: TLabel
          HelpContext = 437029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 437030
          Enabled = False
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 437031
          Enabled = False
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 437032
          Enabled = False
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 437033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 437034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 437035
      inherited Label1: TLabel
        HelpContext = 437036
        Enabled = False
      end
      inherited Label2: TLabel
        HelpContext = 437037
        Enabled = False
      end
      inherited cboFilter: TComboBox
        HelpContext = 437038
        Enabled = False
      end
      inherited edtSearch: TEdit
        HelpContext = 437039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 437040
      Enabled = False
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 437041
      Enabled = False
    end
    inherited cboDateRange: TComboBox
      HelpContext = 437042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 437043
    inherited grdMain: TwwDBGrid
      HelpContext = 437044
      TitleColor = 15527129
    end
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      'SELECT LocationID, City_Sub, State, Postcode '
      'FROM tblLocations'
      'Where RegionID= :xRegionID'
      'LIMIT 100;'
      '')
    BeforeOpen = qryMainBeforeOpen
    Top = 0
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end>
  end
end
