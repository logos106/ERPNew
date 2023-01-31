inherited ClientTypeListGUI: TClientTypeListGUI
  Left = 110
  Top = 174
  HelpContext = 69000
  Caption = 'Customer Type List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 69001
  end
  inherited FooterPanel: TDnMPanel
    HelpContext = 69002
    Color = 15527129
    inherited Label3: TLabel
      HelpContext = 69003
    end
    inherited lblTotal: TLabel
      HelpContext = 69004
    end
    inherited lblNote: TLabel
      HelpContext = 69005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 69006
    end
    inherited lblTime: TLabel
      HelpContext = 69007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 69008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 69009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 69010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 69011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 69012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 69013
      inherited LblChooseTemplate: TLabel
        HelpContext = 69014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 69015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 69016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 69017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 69018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 69019
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
    HelpContext = 69020
    Color = 15527129
    inherited lblFrom: TLabel
      HelpContext = 69021
    end
    inherited lblTo: TLabel
      HelpContext = 69022
    end
    inherited pnlHeader: TPanel
      HelpContext = 69023
      inherited TitleShader: TShader
        HelpContext = 69024
        inherited TitleLabel: TLabel
          HelpContext = 69025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 69026
      inherited grpFilters: TwwRadioGroup
        HelpContext = 69027
        ItemIndex = 0
        Items.Strings = (
          'Active Customer Types Only'
          'Inacative Customer Types'
          'All Customer Types')
      end
      inherited pnlButtons: TPanel
        HelpContext = 69028
        inherited lblcustomReport: TLabel
          HelpContext = 69029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 69030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 69031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 69032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 69033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 69034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 69035
      inherited lblFilter: TLabel
        HelpContext = 69036
      end
      inherited lblSearchoptions: TLabel
        HelpContext = 69037
      end
      inherited cboFilter: TComboBox
        HelpContext = 69038
      end
      inherited edtSearch: TEdit
        HelpContext = 69039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 69040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 69041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 69042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 69043
    inherited grdMain: TwwDBGrid
      HelpContext = 69044
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'TypeName'#9'20'#9'Type Name'#9'F'
        'TypeDescription'#9'20'#9'Type Description'#9'F'
        'Terms'#9'20'#9'Terms'#9'F'
        'CreditLimit'#9'10'#9'Credit Limit'#9'F'
        'GracePeriod'#9'10'#9'Grace Period'#9'F'
        'Active'#9'1'#9'Active'#9#9)
      TitleColor = 15527129
      FooterColor = 15527129
      FooterCellColor = 15527129
      ExplicitLeft = 1
      ExplicitTop = 16
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT'
      '`tblclienttype`.`ClientTypeID`,'
      '`tblclienttype`.`TypeName`,'
      '`tblclienttype`.`TypeDescription`,'
      '`tblterms`.`Terms`,'
      '`tblclienttype`.`CreditLimit`,'
      '`tblclienttype`.`GracePeriod`,'
      '`tblclienttype`.`TermsID`,'
      '`tblclienttype`.`Active`'
      'FROM tblClientType '
      'LEFT JOIN tblTerms ON tblClientType.TermsID = tblTerms.TermsID')
    object qryMainTypeName: TWideStringField
      DisplayLabel = 'Type Name'
      DisplayWidth = 20
      FieldName = 'TypeName'
      Size = 50
    end
    object qryMainTypeDescription: TWideStringField
      DisplayLabel = 'Type Description'
      DisplayWidth = 20
      FieldName = 'TypeDescription'
      Size = 255
    end
    object qryMainTerms: TWideStringField
      DisplayWidth = 20
      FieldName = 'Terms'
      Size = 50
    end
    object qryMainCreditLimit: TFloatField
      DisplayLabel = 'Credit Limit'
      DisplayWidth = 10
      FieldName = 'CreditLimit'
      currency = True
    end
    object qryMainGracePeriod: TWordField
      DisplayLabel = 'Grace Period'
      DisplayWidth = 10
      FieldName = 'GracePeriod'
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryMainClientTypeID: TIntegerField
      FieldName = 'ClientTypeID'
    end
    object qryMainTermsID: TIntegerField
      FieldName = 'TermsID'
    end
  end
  inherited MyConnection1: TERPConnection

  end
end
