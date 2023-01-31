inherited DoorCompDetGUI: TDoorCompDetGUI
  Left = 1311
  Top = 247
  HelpContext = 99000
  Caption = 'Door Component Detail List'
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 99001
  end
  inherited FooterPanel: TPanel
    HelpContext = 99002
    inherited Label3: TLabel
      HelpContext = 99003
    end
    inherited lblTotal: TLabel
      HelpContext = 99004
    end
    inherited lblNote: TLabel
      HelpContext = 99005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 99006
    end
    inherited lblTime: TLabel
      HelpContext = 99007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 99008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 99009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 99010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 99011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 99012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 99013
      inherited LblChooseTemplate: TLabel
        HelpContext = 99014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 99015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 99016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 99017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 99018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 99019
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
    HelpContext = 99020
    inherited lblFrom: TLabel
      HelpContext = 99021
    end
    inherited lblTo: TLabel
      HelpContext = 99022
    end
    inherited pnlHeader: TPanel
      HelpContext = 99023
      inherited TitleShader: TShader
        HelpContext = 99024
        inherited TitleLabel: TLabel
          HelpContext = 99025
          Caption = 'Door Component Detail List'
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 99026
      inherited grpFilters: TRadioGroup
        HelpContext = 99027
      end
      inherited pnlButtons: TPanel
        HelpContext = 99028
        inherited lblcustomReport: TLabel
          HelpContext = 99029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 99030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 99031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 99032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 99033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 99034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 99035
      inherited Label1: TLabel
        HelpContext = 99036
      end
      inherited Label2: TLabel
        HelpContext = 99037
      end
      inherited cboFilter: TComboBox
        HelpContext = 99038
      end
      inherited edtSearch: TEdit
        HelpContext = 99039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 99040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 99041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 99042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 99043
    inherited grdMain: TwwDBGrid
      HelpContext = 99044
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'12'#9'Global Ref'#9'F'
        'CompRef'#9'15'#9'Comp Ref'
        'Cost'#9'15'#9'Cost'
        'SizeNo'#9'15'#9'Size No'
        'Height'#9'11'#9'Height'
        'Width'#9'11'#9'Width'
        'Thickness'#9'11'#9'Thickness'
        'Tolerance'#9'11'#9'Tolerance'
        'CompDetUnit'#9'20'#9'Unit'
        'Active'#9'10'#9'Active')
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'Select * from vwDoorCompDetList')
    object qryMainGlobalRef: TStringField
      Tag = 4
      DisplayLabel = 'Global Ref'
      DisplayWidth = 12
      FieldName = 'GlobalRef'
      Origin = 'vwDoorCompDetList.GlobalRef'
      Size = 255
    end
    object qryMainCompRef: TStringField
      Tag = 4
      DisplayLabel = 'Comp Ref'
      DisplayWidth = 15
      FieldName = 'CompRef'
      Origin = 'vwDoorCompDetList.CompRef'
      Size = 255
    end
    object qryMainCost: TStringField
      Tag = 4
      DisplayWidth = 15
      FieldName = 'Cost'
      Origin = 'vwDoorCompDetList.Cost'
      Size = 255
    end
    object qryMainSizeNo: TStringField
      Tag = 4
      DisplayLabel = 'Size No'
      DisplayWidth = 15
      FieldName = 'SizeNo'
      Origin = 'vwDoorCompDetList.SizeNo'
      Size = 255
    end
    object qryMainHeight: TStringField
      Tag = 4
      DisplayWidth = 11
      FieldName = 'Height'
      Origin = 'vwDoorCompDetList.Height'
      Size = 255
    end
    object qryMainWidth: TStringField
      Tag = 4
      DisplayWidth = 11
      FieldName = 'Width'
      Origin = 'vwDoorCompDetList.Width'
      Size = 255
    end
    object qryMainThickness: TStringField
      Tag = 4
      DisplayWidth = 11
      FieldName = 'Thickness'
      Origin = 'vwDoorCompDetList.Thickness'
      Size = 255
    end
    object qryMainTolerance: TStringField
      Tag = 4
      DisplayWidth = 11
      FieldName = 'Tolerance'
      Origin = 'vwDoorCompDetList.Tolerance'
      Size = 255
    end
    object qryMainCompDetUnit: TStringField
      Tag = 4
      DisplayLabel = 'Unit'
      DisplayWidth = 20
      FieldName = 'CompDetUnit'
      Origin = 'vwDoorCompDetList.CompDetUnit'
      Size = 255
    end
    object qryMainActive: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'Active'
      Origin = 'vwDoorCompDetList.Active'
      Size = 255
    end
  end
end
