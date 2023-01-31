inherited frmProjectList: TfrmProjectList
  Left = 103
  Top = 159
  HelpContext = 337000
  Caption = 'Project List'
  ClientHeight = 570
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    Top = 477
    HelpContext = 337001
  end
  inherited FooterPanel: TPanel
    Top = 490
    HelpContext = 337002
    Color = 15588572
    inherited Label3: TLabel
      HelpContext = 337003
    end
    inherited lblTotal: TLabel
      HelpContext = 337004
    end
    inherited Label121: TLabel
      HelpContext = 337005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 337006
    end
    inherited lblTime: TLabel
      HelpContext = 337007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 337008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 337009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 337010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 337011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 337012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 337013
      inherited LblChooseTemplate: TLabel
        HelpContext = 337014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 337015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 337016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 337017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 337018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 337019
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
    HelpContext = 337020
    Color = 15588572
    inherited lblFrom: TLabel
      HelpContext = 337021
    end
    inherited lblTo: TLabel
      HelpContext = 337022
    end
    inherited pnlHeader: TPanel
      HelpContext = 337023
      inherited TitleShader: TShader
        HelpContext = 337024
        inherited TitleLabel: TLabel
          HelpContext = 337025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 337026
      inherited grpFilters: TRadioGroup
        HelpContext = 337027
      end
      inherited pnlButtons: TPanel
        HelpContext = 337028
        inherited lblcustomReport: TLabel
          HelpContext = 337029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 337030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 337031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 337032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 337033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 337034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 337035
      inherited Label1: TLabel
        HelpContext = 337036
      end
      inherited Label2: TLabel
        HelpContext = 337037
      end
      inherited cboFilter: TComboBox
        HelpContext = 337038
      end
      inherited edtSearch: TEdit
        HelpContext = 337039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 337040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 337041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 337042
    end
  end
  inherited Panel1: TPanel
    Height = 348
    HelpContext = 337043
    Color = 15588572
    inherited grdMain: TwwDBGrid
      Height = 348
      HelpContext = 337044
      Selected.Strings = (
        'GlobalRef'#9'15'#9'GlobalRef'
        'ProjectID'#9'15'#9'ProjectID'
        'CreationDate'#9'18'#9'CreationDate'
        'ProjectName'#9'50'#9'ProjectName'
        'ProjectStartDate'#9'18'#9'ProjectStartDate'
        'Notes'#9'50'#9'Notes'#9'F'
        'Progress'#9'15'#9'Progress')
      TitleColor = 15588572
    end
  end
  inherited dsMain: TDataSource
    Left = 52
    Top = 35
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      
        'select tblProjects.GlobalRef, ProjectID, CreationDate, ProjectNa' +
        'me, ProjectStartDate,Notes,Progress'
      'from tblProjects'
      'Order by CreationDate Desc;')
    Left = 272
    Top = 176
  end
  inherited qryPersonalPrefs: TMyQuery
    Connection = MyConnection1
    Left = 53
    Top = 3
  end
  inherited MyConnection1: TMyConnection
    Left = 65
    Top = 40
  end
end
