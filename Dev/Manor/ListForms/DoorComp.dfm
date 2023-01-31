inherited doorCompGUI: TdoorCompGUI
  Left = 1426
  Top = 48
  HelpContext = 100000
  Caption = 'Door Component List'
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 100001
  end
  inherited FooterPanel: TPanel
    HelpContext = 100002
    inherited Label3: TLabel
      HelpContext = 100003
    end
    inherited lblTotal: TLabel
      HelpContext = 100004
    end
    inherited lblNote: TLabel
      HelpContext = 100005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 100006
    end
    inherited lblTime: TLabel
      HelpContext = 100007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 100008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 100009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 100010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 100011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 100012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 100013
      inherited LblChooseTemplate: TLabel
        HelpContext = 100014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 100015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 100016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 100017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 100018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 100019
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
    HelpContext = 100020
    inherited lblFrom: TLabel
      HelpContext = 100021
    end
    inherited lblTo: TLabel
      HelpContext = 100022
    end
    inherited pnlHeader: TPanel
      HelpContext = 100023
      inherited TitleShader: TShader
        HelpContext = 100024
        inherited TitleLabel: TLabel
          HelpContext = 100025
          Caption = 'Door Component List'
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 100026
      inherited grpFilters: TRadioGroup
        HelpContext = 100027
      end
      inherited pnlButtons: TPanel
        HelpContext = 100028
        inherited lblcustomReport: TLabel
          HelpContext = 100029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 100030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 100031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 100032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 100033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 100034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 100035
      inherited Label1: TLabel
        HelpContext = 100036
      end
      inherited Label2: TLabel
        HelpContext = 100037
      end
      inherited cboFilter: TComboBox
        HelpContext = 100038
      end
      inherited edtSearch: TEdit
        HelpContext = 100039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 100040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 100041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 100042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 100043
    inherited grdMain: TwwDBGrid
      HelpContext = 100044
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'22'#9'GlobalRef'#9#9
        'CompRef'#9'22'#9'CompRef'#9#9
        'DoorType'#9'22'#9'DoorType'#9#9
        'Finish'#9'12'#9'Finish'#9'F'#9
        'HghtMats'#9'11'#9'HghtMats'#9#9
        'Position'#9'11'#9'Position'#9#9
        'Quantity'#9'11'#9'Quantity'#9#9
        'WidMats'#9'11'#9'WidMats'#9#9
        'Active'#9'10'#9'Active'#9#9)
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'Select *     from vwDoorcompList')
    object qryMainGlobalRef: TStringField
      Tag = 4
      DisplayWidth = 22
      FieldName = 'GlobalRef'
      Origin = 'vwDoorcompList.GlobalRef'
      Size = 255
    end
    object qryMainCompRef: TStringField
      Tag = 4
      DisplayWidth = 22
      FieldName = 'CompRef'
      Origin = 'vwDoorcompList.CompRef'
      Size = 255
    end
    object qryMainDoorType: TStringField
      Tag = 4
      DisplayWidth = 22
      FieldName = 'DoorType'
      Origin = 'vwDoorcompList.DoorType'
      Size = 255
    end
    object qryMainFinish: TStringField
      Tag = 4
      DisplayWidth = 12
      FieldName = 'Finish'
      Origin = 'vwDoorcompList.Finish'
      Size = 255
    end
    object qryMainHghtMats: TStringField
      Tag = 4
      DisplayWidth = 11
      FieldName = 'HghtMats'
      Origin = 'vwDoorcompList.HghtMats'
      Size = 255
    end
    object qryMainPosition: TStringField
      Tag = 4
      DisplayWidth = 11
      FieldName = 'Position'
      Origin = 'vwDoorcompList.Position'
      Size = 255
    end
    object qryMainQuantity: TStringField
      Tag = 4
      DisplayWidth = 11
      FieldName = 'Quantity'
      Origin = 'vwDoorcompList.Quantity'
      Size = 255
    end
    object qryMainWidMats: TStringField
      Tag = 4
      DisplayWidth = 11
      FieldName = 'WidMats'
      Origin = 'vwDoorcompList.WidMats'
      Size = 255
    end
    object qryMainActive: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'Active'
      Origin = 'vwDoorcompList.Active'
      Size = 255
    end
  end
end
