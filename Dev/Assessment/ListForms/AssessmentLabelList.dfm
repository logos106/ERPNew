inherited AssessmentLabelsList: TAssessmentLabelsList
  Left = 188
  Top = 133
  HelpContext = 20000
  Caption = 'Assessment Labels List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 20001
  end
  inherited FooterPanel: TPanel
    HelpContext = 20002
    Color = 15527129
    inherited Label3: TLabel
      HelpContext = 20003
    end
    inherited lblTotal: TLabel
      HelpContext = 20004
    end
    inherited lblNote: TLabel
      HelpContext = 20005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 20006
    end
    inherited lblTime: TLabel
      HelpContext = 20007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 20008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 20009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 20010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 20011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 20012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 20013
      inherited LblChooseTemplate: TLabel
        HelpContext = 20014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 20015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 20016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 20017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 20018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 20019
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
    HelpContext = 20020
    Color = 15527129
    inherited lblFrom: TLabel
      HelpContext = 20021
      Visible = False
    end
    inherited lblTo: TLabel
      HelpContext = 20022
      Visible = False
    end
    inherited pnlHeader: TPanel
      HelpContext = 20023
      Caption = 'Assessment Labels List'
      inherited TitleShader: TShader
        HelpContext = 20024
        inherited TitleLabel: TLabel
          HelpContext = 20025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 20026
      inherited grpFilters: TRadioGroup
        HelpContext = 20027
        ItemIndex = 0
        Items.Strings = (
          'Active'
          'Inactive'
          'All')
      end
      inherited pnlButtons: TPanel
        HelpContext = 20028
        inherited lblcustomReport: TLabel
          HelpContext = 20029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 20030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 20031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 20032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 20033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 20034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 20035
      inherited Label1: TLabel
        HelpContext = 20036
      end
      inherited Label2: TLabel
        HelpContext = 20037
      end
      inherited cboFilter: TComboBox
        HelpContext = 20038
      end
      inherited edtSearch: TEdit
        HelpContext = 20039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 20040
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 20041
      Visible = False
    end
    inherited cboDateRange: TComboBox
      HelpContext = 20042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 20043
    inherited grdMain: TwwDBGrid
      HelpContext = 20044
      Selected.Strings = (
        'Label'#9'40'#9'Label'#9#9
        'Category'#9'35'#9'Category'#9#9
        'OtherOption'#9'5'#9'OtherOption'#9'F'
        'Active'#9'5'#9'Active'#9#9)
      TitleColor = 15527129
      FooterColor = 15527129
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT * FROM tblassessmentlabels')
    object qryMainLabel: TWideStringField
      DisplayWidth = 40
      FieldName = 'Label'
      Origin = 'tblassessmentlabels.Label'
      Size = 40
    end
    object qryMainCategory: TWideStringField
      DisplayWidth = 35
      FieldName = 'Category'
      Origin = 'tblassessmentlabels.Category'
      Size = 255
    end
    object qryMainOtherOption: TWideStringField
      DisplayWidth = 5
      FieldName = 'OtherOption'
      Origin = 'tblassessmentlabels.OtherOption'
      FixedChar = True
      Size = 1
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 5
      FieldName = 'Active'
      Origin = 'tblassessmentlabels.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainLabelId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'LabelId'
      Origin = 'tblassessmentlabels.LabelId'
      Visible = False
    end
  end
  inherited MyConnection1: TERPConnection
    Left = 58
  end
end
