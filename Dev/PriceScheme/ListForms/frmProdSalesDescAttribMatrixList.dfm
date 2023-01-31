inherited fmProdSalesDescAttribMatrixList: TfmProdSalesDescAttribMatrixList
  Top = 133
  HelpContext = 198000
  Caption = 'Sales Report Matrix Allocation'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 198001
  end
  inherited FooterPanel: TPanel
    HelpContext = 198002
    inherited Label3: TLabel
      HelpContext = 198003
    end
    inherited lblTotal: TLabel
      HelpContext = 198004
    end
    inherited Label121: TLabel
      HelpContext = 198005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 198006
    end
    inherited lblTime: TLabel
      HelpContext = 198007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 198008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 198009
      Enabled = False
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 198010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 198011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 198012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 198013
      inherited LblChooseTemplate: TLabel
        HelpContext = 198014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 198015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 198016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 198017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 198018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 198019
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
    HelpContext = 198020
    inherited lblFrom: TLabel
      HelpContext = 198021
    end
    inherited lblTo: TLabel
      HelpContext = 198022
    end
    inherited pnlHeader: TPanel
      HelpContext = 198023
      inherited TitleShader: TShader
        HelpContext = 198024
        inherited TitleLabel: TLabel
          HelpContext = 198025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 198026
      inherited grpFilters: TRadioGroup
        HelpContext = 198027
        ItemIndex = 0
        Items.Strings = (
          'Hide Duplicate Titles'
          'Show All')
      end
      inherited pnlButtons: TPanel
        HelpContext = 198028
        inherited lblcustomReport: TLabel
          HelpContext = 198029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 198030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 198031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 198032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 198033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 198034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 198035
      inherited Label1: TLabel
        HelpContext = 198036
      end
      inherited Label2: TLabel
        HelpContext = 198037
      end
      inherited cboFilter: TComboBox
        HelpContext = 198038
      end
      inherited edtSearch: TEdit
        HelpContext = 198039
      end
      object btnSelect: TDNMSpeedButton
        Left = 751
        Top = 4
        Width = 114
        Height = 27
        Hint = '"Close The List"'
        HelpContext = 198040
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
      HelpContext = 198041
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 198042
    end
    inherited cboDateRange: TComboBox
      HelpContext = 198043
    end
  end
  inherited Panel1: TPanel
    HelpContext = 198044
    inherited grdMain: TwwDBGrid
      HelpContext = 198045
    end
  end
  object qryClass: TMyQuery
    SQL.Strings = (
      'SELECT * FROM tblClass WHERE Active = "T"')
    Left = 384
    Top = 8
  end
end
