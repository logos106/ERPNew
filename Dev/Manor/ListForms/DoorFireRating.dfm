inherited DoorFireRatingGUI: TDoorFireRatingGUI
  Left = 211
  Top = 153
  HelpContext = 103000
  Caption = 'Door Firerating List'
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 103001
  end
  inherited FooterPanel: TPanel
    HelpContext = 103002
    inherited Label3: TLabel
      HelpContext = 103003
    end
    inherited lblTotal: TLabel
      HelpContext = 103004
    end
    inherited lblNote: TLabel
      HelpContext = 103005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 103006
    end
    inherited lblTime: TLabel
      HelpContext = 103007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 103008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 103009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 103010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 103011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 103012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 103013
      inherited LblChooseTemplate: TLabel
        HelpContext = 103014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 103015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 103016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 103017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 103018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 103019
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
    HelpContext = 103020
    inherited lblFrom: TLabel
      HelpContext = 103021
    end
    inherited lblTo: TLabel
      HelpContext = 103022
    end
    inherited pnlHeader: TPanel
      HelpContext = 103023
      inherited TitleShader: TShader
        HelpContext = 103024
        inherited TitleLabel: TLabel
          HelpContext = 103025
          Caption = 'Door Firerating List'
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 103026
      inherited grpFilters: TRadioGroup
        HelpContext = 103027
      end
      inherited pnlButtons: TPanel
        HelpContext = 103028
        inherited lblcustomReport: TLabel
          HelpContext = 103029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 103030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 103031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 103032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 103033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 103034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 103035
      inherited Label1: TLabel
        HelpContext = 103036
      end
      inherited Label2: TLabel
        HelpContext = 103037
      end
      inherited cboFilter: TComboBox
        HelpContext = 103038
      end
      inherited edtSearch: TEdit
        HelpContext = 103039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 103040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 103041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 103042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 103043
    inherited grdMain: TwwDBGrid
      HelpContext = 103044
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'22'#9'GlobalRef'
        'FireRating'#9'10'#9'FireRating'
        'HardwoodFrame'#9'10'#9'HardwoodFrame'
        'QuoteText'#9'79'#9'QuoteText'#9'F'
        'Active'#9'10'#9'Active')
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'select * from vwDoorFireRatinglist')
    object qryMainGlobalRef: TStringField
      Tag = 4
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMainFireRating: TStringField
      Tag = 4
      FieldName = 'FireRating'
      Size = 255
    end
    object qryMainHardwoodFrame: TStringField
      Tag = 4
      FieldName = 'HardwoodFrame'
      Size = 255
    end
    object qryMainQuoteText: TStringField
      Tag = 4
      FieldName = 'QuoteText'
      Size = 255
    end
    object qryMainActive: TStringField
      Tag = 4
      FieldName = 'Active'
      Size = 255
    end
  end
end
