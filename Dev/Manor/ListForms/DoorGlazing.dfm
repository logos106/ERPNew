inherited DoorGlazingGUI: TDoorGlazingGUI
  Left = 1318
  Top = 185
  HelpContext = 104000
  Caption = 'Door Glazing List'
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 104001
  end
  inherited FooterPanel: TPanel
    HelpContext = 104002
    inherited Label3: TLabel
      HelpContext = 104003
    end
    inherited lblTotal: TLabel
      HelpContext = 104004
    end
    inherited lblNote: TLabel
      HelpContext = 104005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 104006
    end
    inherited lblTime: TLabel
      HelpContext = 104007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 104008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 104009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 104010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 104011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 104012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 104013
      inherited LblChooseTemplate: TLabel
        HelpContext = 104014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 104015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 104016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 104017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 104018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 104019
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
    HelpContext = 104020
    inherited lblFrom: TLabel
      HelpContext = 104021
    end
    inherited lblTo: TLabel
      HelpContext = 104022
    end
    inherited pnlHeader: TPanel
      HelpContext = 104023
      inherited TitleShader: TShader
        HelpContext = 104024
        inherited TitleLabel: TLabel
          HelpContext = 104025
          Caption = 'Door Glazing List'
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 104026
      inherited grpFilters: TRadioGroup
        HelpContext = 104027
      end
      inherited pnlButtons: TPanel
        HelpContext = 104028
        inherited lblcustomReport: TLabel
          HelpContext = 104029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 104030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 104031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 104032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 104033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 104034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 104035
      inherited Label1: TLabel
        HelpContext = 104036
      end
      inherited Label2: TLabel
        HelpContext = 104037
      end
      inherited cboFilter: TComboBox
        HelpContext = 104038
      end
      inherited edtSearch: TEdit
        HelpContext = 104039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 104040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 104041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 104042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 104043
    inherited grdMain: TwwDBGrid
      HelpContext = 104044
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'22'#9'GlobalRef'#9'F'
        'ChannelMats'#9'11'#9'Channel~Mats'#9'F'
        'GlazingCost'#9'11'#9'Glazing~Cost'#9'F'
        'GlazingMats'#9'16'#9'Glazing~Mats'#9'F'
        'GlazingProformaText'#9'11'#9'Glazing~Proforma Text'#9'F'
        'GlazingShape'#9'11'#9'Glazing~Shape'#9'F'
        'GlazingType'#9'16'#9'Glazing~Type'#9'F'
        'GlazingUnit'#9'11'#9'Glazing~Unit'#9'F'
        'Manufacturer'#9'11'#9'Manufacturer'#9'F'
        'Active'#9'10'#9'Active'#9'F')
      TitleLines = 2
      UseTFields = False
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'Select * from vwDoorGlazingList')
    object qryMainGlobalRef: TStringField
      Tag = 4
      FieldName = 'GlobalRef'
      Origin = 'vwDoorGlazingList.GlobalRef'
      Size = 255
    end
    object qryMainChannelMats: TStringField
      Tag = 4
      FieldName = 'ChannelMats'
      Origin = 'vwDoorGlazingList.ChannelMats'
      Size = 255
    end
    object qryMainGlazingCost: TStringField
      Tag = 4
      FieldName = 'GlazingCost'
      Origin = 'vwDoorGlazingList.GlazingCost'
      Size = 255
    end
    object qryMainGlazingMats: TStringField
      Tag = 4
      FieldName = 'GlazingMats'
      Origin = 'vwDoorGlazingList.GlazingMats'
      Size = 255
    end
    object qryMainGlazingProformaText: TStringField
      Tag = 4
      FieldName = 'GlazingProformaText'
      Origin = 'vwDoorGlazingList.GlazingProformaText'
      Size = 255
    end
    object qryMainGlazingShape: TStringField
      Tag = 4
      FieldName = 'GlazingShape'
      Origin = 'vwDoorGlazingList.GlazingShape'
      Size = 255
    end
    object qryMainGlazingType: TStringField
      Tag = 4
      FieldName = 'GlazingType'
      Origin = 'vwDoorGlazingList.GlazingType'
      Size = 255
    end
    object qryMainGlazingUnit: TStringField
      Tag = 4
      FieldName = 'GlazingUnit'
      Origin = 'vwDoorGlazingList.GlazingUnit'
      Size = 255
    end
    object qryMainManufacturer: TStringField
      Tag = 4
      FieldName = 'Manufacturer'
      Origin = 'vwDoorGlazingList.Manufacturer'
      Size = 255
    end
    object qryMainActive: TStringField
      Tag = 4
      FieldName = 'Active'
      Origin = 'vwDoorGlazingList.Active'
      Size = 255
    end
  end
end
