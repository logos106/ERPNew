inherited MarketingContactRawListGUI: TMarketingContactRawListGUI
  Left = 95
  Top = 147
  HelpContext = 589000
  Caption = 'Marketing Contact Raw List'
  OldCreateOrder = True
  ExplicitLeft = 95
  ExplicitTop = 147
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 589001
  end
  inherited FooterPanel: TDnMPanel
    HelpContext = 589002
    inherited Label3: TLabel
      HelpContext = 589003
    end
    inherited lblTotal: TLabel
      HelpContext = 589004
    end
    inherited lblNote: TLabel
      HelpContext = 589005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 589006
    end
    inherited lblTime: TLabel
      HelpContext = 589007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 589008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 589009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 589010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 589011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 589012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 589013
      inherited LblChooseTemplate: TLabel
        HelpContext = 589014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 589015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 589016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 589017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 589018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 589019
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
    HelpContext = 589020
    inherited lblFrom: TLabel
      HelpContext = 589021
      Visible = False
    end
    inherited lblTo: TLabel
      HelpContext = 589022
      Visible = False
    end
    inherited pnlHeader: TPanel
      HelpContext = 589023
      inherited TitleShader: TShader
        HelpContext = 589024
        inherited TitleLabel: TLabel
          HelpContext = 589025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 589026
      inherited grpFilters: TwwRadioGroup
        HelpContext = 589027
      end
      inherited pnlButtons: TPanel
        HelpContext = 589028
        inherited lblcustomReport: TLabel
          HelpContext = 589029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 589030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 589031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 589032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 589033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 589034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 589035
      inherited lblFilter: TLabel
        HelpContext = 589036
      end
      inherited lblSearchoptions: TLabel
        HelpContext = 589037
      end
      inherited cboFilter: TComboBox
        HelpContext = 589038
      end
      inherited edtSearch: TEdit
        HelpContext = 589039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 589040
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 589041
      Visible = False
    end
    inherited cboDateRange: TComboBox
      HelpContext = 589042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 589043
    inherited grdMain: TwwDBGrid
      HelpContext = 589044
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'COMPANY'#9'20'#9'COMPANY'
        'Title'#9'10'#9'Title'
        'FirstName'#9'20'#9'First~Name'#9'F'
        'MiddleName'#9'20'#9'Middle~Name'#9'F'
        'LastName'#9'20'#9'Last~Name'#9'F'
        'Street'#9'20'#9'Street'#9'F'#9'Address'
        'Street2'#9'20'#9'Street2'#9'F'#9'Address'
        'Street3'#9'20'#9'Street3'#9'F'#9'Address'
        'SUBURB'#9'20'#9'SUBURB'#9'F'#9'Address'
        'STATE'#9'20'#9'STATE'#9'F'#9'Address'
        'Country'#9'20'#9'Country'#9'F'#9'Address'
        'POSTCODE'#9'20'#9'POSTCODE'#9'F'#9'Address'
        'FaxNumber'#9'20'#9'Fax Number'#9'F'#9'Contact'
        'Phone'#9'20'#9'Phone'#9'F'#9'Contact'
        'AltPhone'#9'20'#9'Alt Phone'#9'F'#9'Contact'
        'Mobile'#9'20'#9'Mobile'#9'F'#9'Contact'
        'EmployeeSize'#9'20'#9'Employee Size'
        'Notes'#9'20'#9'Notes'
        'JobTitle'#9'10'#9'Job Title'
        'DateOfBirth'#9'10'#9'Date Of Birth'#9'F'
        'Duration'#9'10'#9'Duration'
        'Source'#9'20'#9'Source'
        'Active'#9'1'#9'Active')
      MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
      TitleLines = 2
      UseTFields = False
      ExplicitLeft = 0
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT'
      '`tblmarketingcontacts`.ID, '
      '`tblmarketingcontacts`.`COMPANY`,'
      '`tblmarketingcontacts`.`Title`,'
      '`tblmarketingcontacts`.`FirstName`,'
      '`tblmarketingcontacts`.`MiddleName`,'
      '`tblmarketingcontacts`.`LastName`,'
      '`tblmarketingcontacts`.`Street`,'
      '`tblmarketingcontacts`.`Street2`,'
      '`tblmarketingcontacts`.`Street3`,'
      '`tblmarketingcontacts`.`FaxNumber`,'
      '`tblmarketingcontacts`.`Phone`,'
      '`tblmarketingcontacts`.`AltPhone`,'
      '`tblmarketingcontacts`.`Mobile`,'
      '`tblmarketingcontacts`.`SUBURB`,'
      '`tblmarketingcontacts`.`STATE`,'
      '`tblmarketingcontacts`.`POSTCODE`,'
      '`tblmarketingcontacts`.`Country`,'
      '`tblmarketingcontacts`.`EmployeeSize`,'
      '`tblmarketingcontacts`.`Notes`,'
      '`tblmarketingcontacts`.`JobTitle`,'
      '`tblmarketingcontacts`.`DateOfBirth`,'
      '`tblmarketingcontacts`.`Duration`,'
      '`tblmarketingcontacts`.`Source`,'
      '`tblmarketingcontacts`.`Active`'
      'FROM'
      '`tblmarketingcontacts` '
      
        'Left Join `tblmarketingleads`  ON `tblmarketingleads`.`Marketing' +
        'ContactID` = `tblmarketingcontacts`.`ID` and IsLEad = "T"'
      'Where '
      'ifnull(`tblmarketingleads`.`LeadID`,0) =0')
    object qryMainID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblmarketingcontacts.ID'
    end
    object qryMainCOMPANY: TWideStringField
      FieldName = 'COMPANY'
      Origin = 'tblmarketingcontacts.COMPANY'
      Size = 255
    end
    object qryMainTitle: TWideStringField
      FieldName = 'Title'
      Origin = 'tblmarketingcontacts.Title'
      Size = 16
    end
    object qryMainFirstName: TWideStringField
      FieldName = 'FirstName'
      Origin = 'tblmarketingcontacts.FirstName'
      Size = 255
    end
    object qryMainMiddleName: TWideStringField
      FieldName = 'MiddleName'
      Origin = 'tblmarketingcontacts.MiddleName'
      Size = 255
    end
    object qryMainLastName: TWideStringField
      FieldName = 'LastName'
      Origin = 'tblmarketingcontacts.LastName'
      Size = 255
    end
    object qryMainStreet: TWideStringField
      FieldName = 'Street'
      Origin = 'tblmarketingcontacts.Street'
      Size = 255
    end
    object qryMainStreet2: TWideStringField
      FieldName = 'Street2'
      Origin = 'tblmarketingcontacts.Street2'
      Size = 255
    end
    object qryMainStreet3: TWideStringField
      FieldName = 'Street3'
      Origin = 'tblmarketingcontacts.Street3'
      Size = 255
    end
    object qryMainFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
      Origin = 'tblmarketingcontacts.FaxNumber'
      Size = 255
    end
    object qryMainPhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'tblmarketingcontacts.Phone'
      Size = 255
    end
    object qryMainAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Origin = 'tblmarketingcontacts.AltPhone'
      Size = 255
    end
    object qryMainMobile: TWideStringField
      FieldName = 'Mobile'
      Origin = 'tblmarketingcontacts.Mobile'
      Size = 255
    end
    object qryMainSUBURB: TWideStringField
      FieldName = 'SUBURB'
      Origin = 'tblmarketingcontacts.SUBURB'
      Size = 255
    end
    object qryMainSTATE: TWideStringField
      FieldName = 'STATE'
      Origin = 'tblmarketingcontacts.STATE'
      Size = 255
    end
    object qryMainPOSTCODE: TWideStringField
      FieldName = 'POSTCODE'
      Origin = 'tblmarketingcontacts.POSTCODE'
      Size = 255
    end
    object qryMainCountry: TWideStringField
      FieldName = 'Country'
      Origin = 'tblmarketingcontacts.Country'
      Size = 255
    end
    object qryMainEmployeeSize: TWideStringField
      FieldName = 'EmployeeSize'
      Origin = 'tblmarketingcontacts.EmployeeSize'
      Size = 255
    end
    object qryMainNotes: TWideMemoField
      FieldName = 'Notes'
      Origin = 'tblmarketingcontacts.Notes'
      BlobType = ftWideMemo
    end
    object qryMainJobTitle: TWideStringField
      FieldName = 'JobTitle'
      Origin = 'tblmarketingcontacts.JobTitle'
      Size = 255
    end
    object qryMainDateOfBirth: TDateField
      FieldName = 'DateOfBirth'
      Origin = 'tblmarketingcontacts.DateOfBirth'
    end
    object qryMainDuration: TDateTimeField
      FieldName = 'Duration'
      Origin = 'tblmarketingcontacts.Duration'
    end
    object qryMainSource: TWideStringField
      FieldName = 'Source'
      Origin = 'tblmarketingcontacts.Source'
      Size = 255
    end
    object qryMainActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblmarketingcontacts.Active'
      FixedChar = True
      Size = 1
    end
  end
end
