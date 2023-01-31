inherited DoorfinishGUI: TDoorfinishGUI
  Left = 1304
  Top = 213
  HelpContext = 102000
  Caption = 'Door Finish List'
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 102001
  end
  inherited FooterPanel: TPanel
    HelpContext = 102002
    inherited Label3: TLabel
      HelpContext = 102003
    end
    inherited lblTotal: TLabel
      HelpContext = 102004
    end
    inherited lblNote: TLabel
      HelpContext = 102005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 102006
    end
    inherited lblTime: TLabel
      HelpContext = 102007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 102008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 102009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 102010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 102011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 102012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 102013
      inherited LblChooseTemplate: TLabel
        HelpContext = 102014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 102015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 102016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 102017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 102018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 102019
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
    HelpContext = 102020
    inherited lblFrom: TLabel
      HelpContext = 102021
    end
    inherited lblTo: TLabel
      HelpContext = 102022
    end
    inherited pnlHeader: TPanel
      HelpContext = 102023
      inherited TitleShader: TShader
        HelpContext = 102024
        inherited TitleLabel: TLabel
          HelpContext = 102025
          Caption = 'Door Finish List'
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 102026
      inherited grpFilters: TRadioGroup
        HelpContext = 102027
      end
      inherited pnlButtons: TPanel
        HelpContext = 102028
        inherited lblcustomReport: TLabel
          HelpContext = 102029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 102030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 102031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 102032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 102033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 102034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 102035
      inherited Label1: TLabel
        HelpContext = 102036
      end
      inherited Label2: TLabel
        HelpContext = 102037
      end
      inherited cboFilter: TComboBox
        HelpContext = 102038
      end
      inherited edtSearch: TEdit
        HelpContext = 102039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 102040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 102041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 102042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 102043
    inherited grdMain: TwwDBGrid
      HelpContext = 102044
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'22'#9'GlobalRef'#9#9
        'FinishName'#9'70'#9'Name'#9'F'
        'Cost'#9'33'#9'Cost'#9'F'#9
        'Active'#9'10'#9'Active'#9#9)
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'Select * from vwDoorfinishList')
    object qryMainGlobalRef: TStringField
      Tag = 4
      DisplayWidth = 22
      FieldName = 'GlobalRef'
      Origin = 'vwDoorfinishList.GlobalRef'
      Size = 255
    end
    object qryMainFinishName: TStringField
      Tag = 4
      DisplayLabel = 'Name'
      DisplayWidth = 70
      FieldName = 'FinishName'
      Origin = 'vwDoorfinishList.FinishName'
      Size = 255
    end
    object qryMainCost: TStringField
      Tag = 4
      DisplayWidth = 33
      FieldName = 'Cost'
      Origin = 'vwDoorfinishList.Cost'
      Size = 255
    end
    object qryMainActive: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'Active'
      Origin = 'vwDoorfinishList.Active'
      Size = 255
    end
  end
end
