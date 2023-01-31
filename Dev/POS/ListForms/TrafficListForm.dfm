inherited TrafficListGUI: TTrafficListGUI
  Left = 218
  Top = 148
  HelpContext = 530000
  Caption = 'Traffic List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 530001
  end
  inherited FooterPanel: TDnMPanel
    HelpContext = 530002
    Color = 15527129
    inherited Label3: TLabel
      HelpContext = 530003
    end
    inherited lblTotal: TLabel
      HelpContext = 530004
    end
    inherited lblNote: TLabel
      HelpContext = 530005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 530006
    end
    inherited lblTime: TLabel
      HelpContext = 530007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 530008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 530009
      Enabled = False
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 530010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 530011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 530012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 530013
      inherited LblChooseTemplate: TLabel
        HelpContext = 530014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 530015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 530016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 530017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 530018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 530019
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
    HelpContext = 530020
    Color = 15527129
    inherited lblFrom: TLabel
      HelpContext = 530021
    end
    inherited lblTo: TLabel
      HelpContext = 530022
    end
    inherited pnlHeader: TPanel
      HelpContext = 530023
      inherited TitleShader: TShader
        HelpContext = 530024
        inherited TitleLabel: TLabel
          HelpContext = 530025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 530026
      inherited grpFilters: TwwRadioGroup
        HelpContext = 530027
      end
      inherited pnlButtons: TPanel
        HelpContext = 530028
        inherited lblcustomReport: TLabel
          HelpContext = 530029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 530030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 530031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 530032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 530033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 530034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 530035
      inherited lblFilter: TLabel
        HelpContext = 530036
      end
      inherited lblSearchoptions: TLabel
        HelpContext = 530037
      end
      inherited cboFilter: TComboBox
        HelpContext = 530038
      end
      inherited edtSearch: TEdit
        HelpContext = 530039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 530040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 530041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 530042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 530043
    inherited grdMain: TwwDBGrid
      HelpContext = 530044
      Selected.Strings = (
        'Branch'#9'40'#9'Branch'
        'BranchDescription'#9'40'#9'BranchDescription'#9'F'
        'Recorder'#9'10'#9'Recorder'
        'Date'#9'10'#9'Date'
        'Hour'#9'10'#9'Hour'
        'Count'#9'10'#9'Count')
      TitleColor = 15527129
      FooterColor = 15527129
      FooterCellColor = 15527129
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      
        'SELECT Branch,SiteDesc as BranchDescription,Recorder,Date, Hour,' +
        ' Count '
      'FROM tblTraffic'
      'LEFT JOIN tblmsbackendid on SiteCode=Branch'
      'WHERE Date BETWEEN  :txtfrom AND  :txtTo')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'txtfrom'
      end
      item
        DataType = ftUnknown
        Name = 'txtTo'
      end>
  end
end
