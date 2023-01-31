inherited EmailedReportsList: TEmailedReportsList
  Left = 106
  Top = 122
  HelpContext = 114000
  Caption = 'Emailed Reports List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 114001
  end
  inherited FooterPanel: TDnMPanel
    HelpContext = 114002
    Color = 14153215
    inherited Label3: TLabel
      HelpContext = 114003
    end
    inherited lblTotal: TLabel
      HelpContext = 114004
    end
    inherited lblNote: TLabel
      HelpContext = 114005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 114006
    end
    inherited lblTime: TLabel
      HelpContext = 114007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 114008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 114009
      Enabled = False
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 114010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 114011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 114012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 114013
      inherited LblChooseTemplate: TLabel
        HelpContext = 114014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 114015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 114016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 114017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 114018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 114019
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
    HelpContext = 114020
    Color = 14153215
    inherited lblFrom: TLabel
      HelpContext = 114021
    end
    inherited lblTo: TLabel
      HelpContext = 114022
    end
    inherited pnlHeader: TPanel
      HelpContext = 114023
      inherited TitleShader: TShader
        HelpContext = 114024
        inherited TitleLabel: TLabel
          HelpContext = 114025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 114026
      inherited grpFilters: TwwRadioGroup
        HelpContext = 114027
      end
      inherited pnlButtons: TPanel
        HelpContext = 114028
        inherited lblcustomReport: TLabel
          HelpContext = 114029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 114030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 114031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 114032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 114033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 114034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 114035
      inherited lblFilter: TLabel
        HelpContext = 114036
      end
      inherited lblSearchoptions: TLabel
        HelpContext = 114037
      end
      inherited cboFilter: TComboBox
        HelpContext = 114038
      end
      inherited edtSearch: TEdit
        HelpContext = 114039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 114040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 114041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 114042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 114043
    inherited grdMain: TwwDBGrid
      HelpContext = 114044
      TitleColor = 14153215
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      
        'Select GlobalRef, ReportListID, TransactionID as "Transaction", ' +
        'UserID as "User", Date, ReportType as "Report Type", Transaction' +
        'Description as "Transaction Description" from tblEmailedReports'
      'Order by ReportListID DESC;')
    Top = 65535
  end
end
