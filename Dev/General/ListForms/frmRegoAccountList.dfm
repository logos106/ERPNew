inherited frmRegoAccountListGUI: TfrmRegoAccountListGUI
  Left = 82
  Top = 114
  HelpContext = 342000
  Caption = 'ERP Registration Accounts'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 342001
  end
  inherited FooterPanel: TDnMPanel
    HelpContext = 342002
    Color = 15527129
    inherited Label3: TLabel
      HelpContext = 342003
    end
    inherited lblTotal: TLabel
      HelpContext = 342004
    end
    inherited lblNote: TLabel
      HelpContext = 342005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 342006
    end
    inherited lblTime: TLabel
      HelpContext = 342007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 342008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 342009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 342010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 342011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 342012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 342013
      inherited LblChooseTemplate: TLabel
        HelpContext = 342014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 342015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 342016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 342017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 342018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 342019
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
    HelpContext = 342020
    Color = 15527129
    inherited lblFrom: TLabel
      HelpContext = 342021
      Visible = False
    end
    inherited lblTo: TLabel
      HelpContext = 342022
      Visible = False
    end
    inherited pnlHeader: TPanel
      HelpContext = 342023
      Caption = 'ERP Registration Accounts'
      inherited TitleShader: TShader
        HelpContext = 342024
        inherited TitleLabel: TLabel
          HelpContext = 342025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 342026
      inherited grpFilters: TwwRadioGroup
        HelpContext = 342027
        ItemIndex = 0
        Items.Strings = (
          'Issued'
          'Not Issued')
      end
      inherited pnlButtons: TPanel
        HelpContext = 342028
        inherited lblcustomReport: TLabel
          HelpContext = 342029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 342030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 342031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 342032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 342033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 342034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 342035
      inherited lblFilter: TLabel
        Left = 5
        HelpContext = 342036
      end
      inherited lblSearchoptions: TLabel
        Left = 293
        HelpContext = 342037
      end
      inherited cboFilter: TComboBox
        Left = 95
        HelpContext = 342038
      end
      inherited edtSearch: TEdit
        Left = 367
        HelpContext = 342039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 342040
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 342041
      Visible = False
    end
    inherited cboDateRange: TComboBox
      HelpContext = 342042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 342043
    inherited grdMain: TwwDBGrid
      HelpContext = 342044
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'Company'#9'20'#9'Company'#9#9
        'ServerPrice'#9'20'#9'Server Price'#9#9
        'ClientPrice'#9'20'#9'Client Price'#9#9
        'NoClients'#9'12'#9'No Clients'#9#9
        'YearlyMaintenancePercent'#9'12'#9'Percent'#9#9
        'AnnualFee'#9'12'#9'AnnualFee'#9'F'#9
        'ContractStart'#9'14'#9'Contract Start'#9#9
        'Expires'#9'14'#9'Expires'#9#9
        'TermsSigned'#9'12'#9'Terms Signed'#9#9
        'Active'#9'1'#9'Active'#9#9)
      TitleColor = 15527129
      FooterColor = clWhite
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT '
      'C.Company, L.*'
      'FROM tblclients AS C'
      'LEFT JOIN tbllicence AS L Using(ClientID)'
      'WHERE C.Active="T" AND C.Customer="T" AND IsJob="F"')
    AfterOpen = qryMainAfterOpen
    OnCalcFields = qryMainCalcFields
    Options.StrictUpdate = False
    object qryMainCompany: TWideStringField
      DisplayWidth = 20
      FieldName = 'Company'
      Origin = 'tblclients.Company'
      Size = 80
    end
    object qryMainServerPrice: TFloatField
      DisplayLabel = 'Server Price'
      DisplayWidth = 20
      FieldName = 'ServerPrice'
      Origin = 'L.ServerPrice'
      currency = True
    end
    object qryMainClientPrice: TFloatField
      DisplayLabel = 'Client Price'
      DisplayWidth = 20
      FieldName = 'ClientPrice'
      Origin = 'L.ClientPrice'
      currency = True
    end
    object qryMainNoClients: TIntegerField
      DisplayLabel = 'No Clients'
      DisplayWidth = 12
      FieldName = 'NoClients'
      Origin = 'L.NoClients'
    end
    object qryMainYearlyMaintenancePercent: TIntegerField
      DisplayLabel = 'Percent'
      DisplayWidth = 12
      FieldName = 'YearlyMaintenancePercent'
      Origin = 'L.YearlyMaintenancePercent'
    end
    object qryMainAnnualFee: TCurrencyField
      DisplayWidth = 12
      FieldKind = fkCalculated
      FieldName = 'AnnualFee'
      Calculated = True
    end
    object qryMainContractStart: TDateField
      DisplayLabel = 'Contract Start'
      DisplayWidth = 14
      FieldName = 'ContractStart'
      Origin = 'L.ContractStart'
    end
    object qryMainExpires: TDateField
      DisplayWidth = 14
      FieldName = 'Expires'
      Origin = 'L.Expires'
    end
    object qryMainTermsSigned: TDateField
      DisplayLabel = 'Terms Signed'
      DisplayWidth = 12
      FieldName = 'TermsSigned'
      Origin = 'L.TermsSigned'
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'L.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainTodoIssued: TDateTimeField
      DisplayLabel = 'Todo Issued'
      DisplayWidth = 18
      FieldName = 'TodoIssued'
      Origin = 'L.TodoIssued'
      Visible = False
    end
    object qryMainmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'L.msTimeStamp'
      Visible = False
    end
    object qryMainAutoInvoice: TWideStringField
      DisplayWidth = 1
      FieldName = 'AutoInvoice'
      Origin = 'L.AutoInvoice'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryMainGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Origin = 'L.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryMainID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'L.ID'
      Visible = False
    end
    object qryMainClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Origin = 'L.ClientID'
      Visible = False
    end
  end
end
