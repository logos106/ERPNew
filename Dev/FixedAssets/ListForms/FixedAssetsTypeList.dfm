inherited FixedAssetTypeListGUI: TFixedAssetTypeListGUI
  Left = 73
  Top = 163
  HelpContext = 138000
  Caption = 'Fixed Asset Type List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 138001
  end
  inherited FooterPanel: TDnMPanel
    HelpContext = 138002
    Color = 14671805
    inherited Label3: TLabel
      HelpContext = 138003
    end
    inherited lblTotal: TLabel
      HelpContext = 138004
    end
    inherited lblNote: TLabel
      HelpContext = 138005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 138006
    end
    inherited lblTime: TLabel
      HelpContext = 138007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 138008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 138009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 138010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 138011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 138012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 138013
      inherited LblChooseTemplate: TLabel
        HelpContext = 138014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 138015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 138016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 138017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 138018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 138019
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
    HelpContext = 138020
    Color = 14671805
    inherited lblFrom: TLabel
      HelpContext = 138021
      Visible = False
    end
    inherited lblTo: TLabel
      HelpContext = 138022
      Visible = False
    end
    inherited pnlHeader: TPanel
      HelpContext = 138023
      inherited TitleShader: TShader
        HelpContext = 138024
        inherited TitleLabel: TLabel
          HelpContext = 138025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 138026
      inherited grpFilters: TwwRadioGroup
        HelpContext = 138027
      end
      inherited pnlButtons: TPanel
        HelpContext = 138028
        inherited lblcustomReport: TLabel
          HelpContext = 138029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 138030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 138031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 138032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 138033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 138034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 138035
      inherited lblFilter: TLabel
        HelpContext = 138036
      end
      inherited lblSearchoptions: TLabel
        HelpContext = 138037
      end
      inherited cboFilter: TComboBox
        HelpContext = 138038
      end
      inherited edtSearch: TEdit
        HelpContext = 138039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 138040
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 138041
      Visible = False
    end
    inherited cboDateRange: TComboBox
      HelpContext = 138042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 138043
    inherited grdMain: TwwDBGrid
      HelpContext = 138044
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'15'#9'GlobalRef'#9'F'
        'AssetTypeID'#9'10'#9'AssetTypeID'#9#9
        'AssetTypeCode'#9'50'#9'AssetTypeCode'#9#9
        'AssetTypeName'#9'50'#9'AssetTypeName'#9'F'
        'Notes'#9'50'#9'Notes'#9'F'
        'Active'#9'1'#9'Active'#9#9)
      TitleColor = 14671805
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      
        'SELECT GlobalRef, AssetTypeID, AssetTypeCode, AssetTypeName, SUB' +
        'STRING(Notes,1,255)as Notes, Active  '
      'FROM tblfixedassettypes')
    object qryMainGlobalRef: TWideStringField
      DisplayWidth = 15
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMainAssetTypeID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'AssetTypeID'
      ReadOnly = True
    end
    object qryMainAssetTypeCode: TWideStringField
      DisplayWidth = 50
      FieldName = 'AssetTypeCode'
      Size = 50
    end
    object qryMainAssetTypeName: TWideStringField
      DisplayWidth = 50
      FieldName = 'AssetTypeName'
      Size = 255
    end
    object qryMainNotes: TWideStringField
      DisplayWidth = 50
      FieldName = 'Notes'
      ReadOnly = True
      Size = 255
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
  end
end
