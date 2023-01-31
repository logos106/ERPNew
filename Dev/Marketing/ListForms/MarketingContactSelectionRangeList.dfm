inherited MarketingContactSelectionRangeListGUI: TMarketingContactSelectionRangeListGUI
  Left = 56
  Top = 121
  HelpContext = 74000
  Caption = 'Contact Selection Ranges'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 74001
  end
  inherited FooterPanel: TDnMPanel
    HelpContext = 74002
    Color = 15527129
    inherited Label3: TLabel
      HelpContext = 74003
    end
    inherited lblTotal: TLabel
      HelpContext = 74004
    end
    inherited lblNote: TLabel
      HelpContext = 74005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 74006
    end
    inherited lblTime: TLabel
      HelpContext = 74007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 74008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 74009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 74010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 74011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 74012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 74013
      inherited LblChooseTemplate: TLabel
        HelpContext = 74014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 74015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 74016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 74017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 74018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 74019
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
    HelpContext = 74020
    Color = 15527129
    inherited lblFrom: TLabel
      HelpContext = 74021
      Visible = False
    end
    inherited lblTo: TLabel
      HelpContext = 74022
      Visible = False
    end
    inherited pnlHeader: TPanel
      HelpContext = 74023
      Caption = 'Contact Selection Ranges'
      inherited TitleShader: TShader
        HelpContext = 74024
        inherited TitleLabel: TLabel
          HelpContext = 74025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 74026
      inherited grpFilters: TwwRadioGroup
        HelpContext = 74027
        ItemIndex = 0
        Items.Strings = (
          'Active'
          'Not Active'
          'Both')
      end
      inherited pnlButtons: TPanel
        HelpContext = 74028
        inherited lblcustomReport: TLabel
          HelpContext = 74029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 74030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 74031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 74032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 74033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 74034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 74035
      inherited lblFilter: TLabel
        HelpContext = 74036
      end
      inherited lblSearchoptions: TLabel
        HelpContext = 74037
      end
      inherited cboFilter: TComboBox
        HelpContext = 74038
      end
      inherited edtSearch: TEdit
        HelpContext = 74039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 74040
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 74041
      Visible = False
    end
    inherited cboDateRange: TComboBox
      HelpContext = 74042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 74043
    inherited grdMain: TwwDBGrid
      HelpContext = 74044
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'RangeDescription'#9'30'#9'Description'#9#9
        'XMLData'#9'100'#9'XML Data'#9'F'#9
        'Active'#9'1'#9'Active'#9#9)
      TitleColor = 15527129
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT * FROM tblMarketingrangeselection'
      'WHERE (Active = "T" AND :Active = "Active")'
      'OR (Active <> "T" AND :Active = "Not Active")'
      'OR (:Active = "Both")')
    ParamData = <
      item
        DataType = ftString
        Name = 'Active'
        Value = ''
      end
      item
        DataType = ftString
        Name = 'Active'
      end
      item
        DataType = ftString
        Name = 'Active'
      end>
    object qryMainRangeDescription: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 30
      FieldName = 'RangeDescription'
      Origin = 'tblMarketingrangeselection.RangeDescription'
      Size = 255
    end
    object qryMainXMLData: TWideMemoField
      DisplayLabel = 'XML Data'
      DisplayWidth = 100
      FieldName = 'XMLData'
      Origin = 'tblMarketingrangeselection.XMLData'
      BlobType = ftWideMemo
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblMarketingrangeselection.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainRangeSelectionId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'RangeSelectionId'
      Origin = 'tblMarketingrangeselection.RangeSelectionId'
      Visible = False
    end
    object qryMainGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Origin = 'tblMarketingrangeselection.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryMainmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblMarketingrangeselection.msTimeStamp'
      Visible = False
    end
  end
end
