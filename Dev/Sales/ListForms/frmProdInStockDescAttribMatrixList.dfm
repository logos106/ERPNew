inherited fmProdInStockDescAttribMatrixList: TfmProdInStockDescAttribMatrixList
  Left = 257
  Top = 125
  HelpContext = 197000
  Caption = 'In Stock Levels'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 197001
  end
  inherited FooterPanel: TPanel
    HelpContext = 197002
    inherited Label3: TLabel
      HelpContext = 197003
    end
    inherited lblTotal: TLabel
      HelpContext = 197004
    end
    inherited Label121: TLabel
      HelpContext = 197005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 197006
    end
    inherited lblTime: TLabel
      HelpContext = 197007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 197008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 197009
      Caption = 'Stock Transfer'
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 197010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 197011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 197012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 197013
      inherited LblChooseTemplate: TLabel
        HelpContext = 197014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 197015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 197016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 197017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 197018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 197019
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
    HelpContext = 197020
    inherited lblFrom: TLabel
      HelpContext = 197021
      Visible = False
    end
    inherited lblTo: TLabel
      Left = 852
      Top = 11
      Width = 58
      HelpContext = 197022
      Alignment = taRightJustify
      Caption = 'As at Date'
    end
    inherited pnlHeader: TPanel
      HelpContext = 197023
      inherited TitleShader: TShader
        HelpContext = 197024
        inherited TitleLabel: TLabel
          HelpContext = 197025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 197026
      inherited grpFilters: TRadioGroup
        HelpContext = 197027
        ItemIndex = 0
        Items.Strings = (
          'Hide Duplicate Titles'
          'Show All')
      end
      inherited pnlButtons: TPanel
        HelpContext = 197028
        inherited lblcustomReport: TLabel
          HelpContext = 197029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 197030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 197031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 197032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 197033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 197034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 197035
      inherited Label1: TLabel
        HelpContext = 197036
      end
      inherited Label2: TLabel
        HelpContext = 197037
      end
      inherited cboFilter: TComboBox
        HelpContext = 197038
      end
      inherited edtSearch: TEdit
        HelpContext = 197039
      end
      object btnSelect: TDNMSpeedButton
        Left = 751
        Top = 4
        Width = 114
        Height = 27
        Hint = '"Close The List"'
        HelpContext = 197040
        Anchors = [akBottom]
        Caption = 'Select Attributes'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ModalResult = 1
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        TabStop = False
        OnClick = btnSelectClick
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 197041
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      Top = 8
      HelpContext = 197042
    end
    inherited cboDateRange: TComboBox
      Left = 769
      Width = 56
      HelpContext = 197043
    end
  end
  inherited Panel1: TPanel
    HelpContext = 197044
    inherited grdMain: TwwDBGrid
      HelpContext = 197045
      MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgMultiSelect, dgRowResize]
    end
  end
  object qryClass: TMyQuery
    SQL.Strings = (
      'SELECT * FROM tblClass WHERE Active = "T"')
    Left = 384
    Top = 8
  end
end
