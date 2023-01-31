inherited fmProcPickingSlipList: TfmProcPickingSlipList
  Left = 68
  Top = 137
  HelpContext = 187000
  Caption = 'Production Picking Slip List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 187001
  end
  inherited FooterPanel: TPanel
    HelpContext = 187002
    inherited Label3: TLabel
      HelpContext = 187003
    end
    inherited lblTotal: TLabel
      HelpContext = 187004
    end
    inherited Label121: TLabel
      HelpContext = 187005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 187006
    end
    inherited lblTime: TLabel
      HelpContext = 187007
    end
    inherited cmdClose: TDNMSpeedButton
      TabOrder = 4
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 187009
      Enabled = False
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 187010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 187011
    end
    inherited btnCustomize: TDNMSpeedButton
      TabOrder = 7
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 187013
      inherited LblChooseTemplate: TLabel
        HelpContext = 187014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 187015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 187016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 187017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 187018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 187019
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
    HelpContext = 187020
    inherited lblFrom: TLabel
      HelpContext = 187021
    end
    inherited lblTo: TLabel
      HelpContext = 187022
    end
    inherited pnlHeader: TPanel
      HelpContext = 187023
      inherited TitleShader: TShader
        HelpContext = 187024
        inherited TitleLabel: TLabel
          HelpContext = 187025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 187026
      inherited grpFilters: TRadioGroup
        HelpContext = 187027
        ItemIndex = 2
        Items.Strings = (
          'Picked'
          'Not Picked'
          'All')
      end
      inherited pnlButtons: TPanel
        HelpContext = 187028
        inherited lblcustomReport: TLabel
          HelpContext = 187029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 187030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 187031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 187032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 187033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 187034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 187035
      inherited Label1: TLabel
        HelpContext = 187036
      end
      inherited Label2: TLabel
        HelpContext = 187037
      end
      inherited cboFilter: TComboBox
        HelpContext = 187038
      end
      inherited edtSearch: TEdit
        HelpContext = 187039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 187040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 187041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 187042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 187043
    inherited grdMain: TwwDBGrid
      HelpContext = 187044
    end
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      'SELECT * FROM tblProcPickSlip')
  end
end
