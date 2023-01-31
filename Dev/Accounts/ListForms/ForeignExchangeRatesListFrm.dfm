inherited ForeignExchangeRatesListGUI: TForeignExchangeRatesListGUI
  Left = 85
  Top = 169
  HelpContext = 221000
  Caption = 'Foreign Exchange Rates'
  Color = 14153215
  OldCreateOrder = True
  ExplicitLeft = 85
  ExplicitTop = 169
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 221001
  end
  inherited FooterPanel: TDnMPanel
    HelpContext = 221002
    Color = 14153215
    inherited Label3: TLabel
      HelpContext = 221003
    end
    inherited lblTotal: TLabel
      HelpContext = 221004
    end
    inherited lblNote: TLabel
      HelpContext = 221005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 221006
    end
    inherited lblTime: TLabel
      HelpContext = 221007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 221008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 221009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 221010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 221011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 221012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 221013
      inherited LblChooseTemplate: TLabel
        HelpContext = 221014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 221015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 221016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 221017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 221018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 221019
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
    HelpContext = 221020
    Color = 14153215
    inherited lblFrom: TLabel
      HelpContext = 221021
      Visible = False
    end
    inherited lblTo: TLabel
      HelpContext = 221022
      Visible = False
    end
    inherited pnlHeader: TPanel
      HelpContext = 221023
      Caption = 'Foreign Exchange Rates'
      inherited TitleShader: TShader
        HelpContext = 221024
        inherited TitleLabel: TLabel
          HelpContext = 221025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 221026
      inherited grpFilters: TwwRadioGroup
        HelpContext = 221027
        ItemIndex = 0
        Items.Strings = (
          'Active Rates'
          'Inactive Rates'
          'All Rates')
      end
      inherited pnlButtons: TPanel
        HelpContext = 221028
        inherited lblcustomReport: TLabel
          HelpContext = 221029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 221030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 221031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 221032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 221033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 221034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 221035
      inherited lblFilter: TLabel
        HelpContext = 221036
      end
      inherited lblSearchoptions: TLabel
        HelpContext = 221037
      end
      inherited cboFilter: TComboBox
        HelpContext = 221038
      end
      inherited edtSearch: TEdit
        HelpContext = 221039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 221040
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 221041
      Visible = False
    end
    inherited cboDateRange: TComboBox
      HelpContext = 221042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 221043
    inherited grdMain: TwwDBGrid
      HelpContext = 221044
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'15'#9'GlobalRef'#9'F'#9
        'Country'#9'40'#9'Country'#9#9
        'Currency'#9'30'#9'Currency'#9#9
        'Code'#9'10'#9'Code'#9#9
        'BuyRate'#9'11'#9'BuyRate'#9#9
        'SellRate'#9'10'#9'SellRate'#9#9
        'RateLastModified'#9'10'#9'RateLastModified'#9#9
        'Active'#9'1'#9'Active'#9#9
        'CurrencySymbol'#9'1'#9'Currency Symbol'#9'F')
      TitleColor = 14153215
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblcurrencyconversion;')
    object qryMainGlobalRef: TWideStringField
      DisplayWidth = 15
      FieldName = 'GlobalRef'
      Origin = 'tblcurrencyconversion.GlobalRef'
      Size = 255
    end
    object qryMainCountry: TWideStringField
      DisplayWidth = 40
      FieldName = 'Country'
      Origin = 'tblcurrencyconversion.Country'
      Size = 255
    end
    object qryMainCurrency: TWideStringField
      DisplayWidth = 30
      FieldName = 'Currency'
      Origin = 'tblcurrencyconversion.Currency'
      Size = 255
    end
    object qryMainCode: TWideStringField
      DisplayWidth = 10
      FieldName = 'Code'
      Origin = 'tblcurrencyconversion.Code'
      FixedChar = True
      Size = 3
    end
    object qryMainBuyRate: TFloatField
      DisplayWidth = 11
      FieldName = 'BuyRate'
      Origin = 'tblcurrencyconversion.BuyRate'
      Precision = 10
    end
    object qryMainSellRate: TFloatField
      DisplayWidth = 10
      FieldName = 'SellRate'
      Origin = 'tblcurrencyconversion.SellRate'
    end
    object qryMainRateLastModified: TDateField
      DisplayWidth = 10
      FieldName = 'RateLastModified'
      Origin = 'tblcurrencyconversion.RateLastModified'
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblcurrencyconversion.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainCurrencySymbol: TWideStringField
      DisplayLabel = 'Currency Symbol'
      DisplayWidth = 1
      FieldName = 'CurrencySymbol'
      Size = 3
    end
    object qryMainCurrencyID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'CurrencyID'
      Origin = 'tblcurrencyconversion.CurrencyID'
      Visible = False
    end
    object qryMainEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblcurrencyconversion.EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  inherited qryPersonalPrefs: TERPQuery
    Left = 80
  end
end
