inherited MarketingContactcontactListGUI: TMarketingContactcontactListGUI
  Caption = 'Marketing Contact Contacts'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TDnMPanel
    inherited barStatus: TAdvOfficeStatusBar
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
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited pnlHeader: TPanel
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          Caption = 'Marketing Contact Contacts'
        end
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      Visible = False
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'MarketingContact'#9'10'#9'Marketing~Contact'
        'Company'#9'20'#9'Name'
        'ContactTitle'#9'10'#9'Title'
        'ContactFirstName'#9'10'#9'First Name'
        'ContactSurName'#9'10'#9'Sur Name'
        'ContactAddress'#9'10'#9'Address1'
        'ContactAddress2'#9'10'#9'Address2'
        'ContactAddress3'#9'10'#9'Address3'
        'ContactCity'#9'10'#9'City'
        'ContactState'#9'10'#9'State'
        'ContactPcode'#9'10'#9'Post Code'
        'ContactCountry'#9'10'#9'Country'
        'ContactPH'#9'10'#9'Phone'
        'ContactAltPH'#9'10'#9'Alt Phone'
        'ContactMOB'#9'10'#9'Mobile'
        'ContactFax'#9'10'#9'Fax'
        'ContactEmail'#9'10'#9'Email'
        'Notes'#9'10'#9'Notes'
        'Active'#9'1'#9'Active'
        'CardNumber'#9'10'#9'Card Number'
        'AccountNo'#9'10'#9'Account No'
        'JobTitle'#9'10'#9'Job Title'
        'IsPrimarycontact'#9'10'#9'Is Primary~Contact')
      TitleLines = 2
      inherited btnGrid: TwwIButton
        Height = 34
        ExplicitHeight = 34
      end
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT'
      '`tblmarketingcontactcontacts`.`GlobalRef` as `GlobalRef`,'
      '`tblmarketingcontactcontacts`.`ContactID` as `ContactID`,'
      
        '`tblmarketingcontactcontacts`.`MarketingContactID` as `Marketing' +
        'ContactID`,'
      '`tblmarketingcontactcontacts`.`Company` as `Company`,'
      '`tblmarketingcontactcontacts`.`ContactTitle` as `ContactTitle`,'
      
        '`tblmarketingcontactcontacts`.`ContactFirstName` as `ContactFirs' +
        'tName`,'
      
        '`tblmarketingcontactcontacts`.`ContactSurName` as `ContactSurNam' +
        'e`,'
      
        '`tblmarketingcontactcontacts`.`ContactAddress` as `ContactAddres' +
        's`,'
      
        '`tblmarketingcontactcontacts`.`ContactAddress2` as `ContactAddre' +
        'ss2`,'
      
        '`tblmarketingcontactcontacts`.`ContactAddress3` as `ContactAddre' +
        'ss3`,'
      '`tblmarketingcontactcontacts`.`ContactCity` as `ContactCity`,'
      '`tblmarketingcontactcontacts`.`ContactState` as `ContactState`,'
      '`tblmarketingcontactcontacts`.`ContactPcode` as `ContactPcode`,'
      
        '`tblmarketingcontactcontacts`.`ContactCountry` as `ContactCountr' +
        'y`,'
      '`tblmarketingcontactcontacts`.`ContactPH` as `ContactPH`,'
      '`tblmarketingcontactcontacts`.`ContactAltPH` as `ContactAltPH`,'
      '`tblmarketingcontactcontacts`.`ContactMOB` as `ContactMOB`,'
      '`tblmarketingcontactcontacts`.`ContactFax` as `ContactFax`,'
      '`tblmarketingcontactcontacts`.`ContactEmail` as `ContactEmail`,'
      '`tblmarketingcontactcontacts`.`Notes` as `Notes`,'
      '`tblmarketingcontactcontacts`.`Active` as `Active`,'
      '`tblmarketingcontactcontacts`.`CardNumber` as `CardNumber`,'
      '`tblmarketingcontactcontacts`.`AccountNo` as `AccountNo`,'
      '`tblmarketingcontactcontacts`.`JobTitle` as `JobTitle`,'
      
        '`tblmarketingcontactcontacts`.`IsPrimarycontact` as `IsPrimaryco' +
        'ntact`,'
      '`tblmarketingcontacts`.`COMPANY` as MarketingContact'
      'FROM `tblmarketingcontactcontacts`'
      
        'inner join tblMarketingcontacts on tblMarketingcontacts.Id = `tb' +
        'lmarketingcontactcontacts`.`MarketingContactID`')
    object qryMainMarketingContact: TWideStringField
      DisplayLabel = 'Marketing~Contact'
      DisplayWidth = 10
      FieldName = 'MarketingContact'
      Origin = 'tblMarketingcontacts.COMPANY'
      Size = 255
    end
    object qryMainCompany: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldName = 'Company'
      Origin = 'tblmarketingcontactcontacts.Company'
      Size = 50
    end
    object qryMainContactTitle: TWideStringField
      DisplayLabel = 'Title'
      DisplayWidth = 10
      FieldName = 'ContactTitle'
      Origin = 'tblmarketingcontactcontacts.ContactTitle'
      Size = 32
    end
    object qryMainContactFirstName: TWideStringField
      DisplayLabel = 'First Name'
      DisplayWidth = 10
      FieldName = 'ContactFirstName'
      Origin = 'tblmarketingcontactcontacts.ContactFirstName'
      Size = 30
    end
    object qryMainContactSurName: TWideStringField
      DisplayLabel = 'Sur Name'
      DisplayWidth = 10
      FieldName = 'ContactSurName'
      Origin = 'tblmarketingcontactcontacts.ContactSurName'
      Size = 30
    end
    object qryMainContactAddress: TWideStringField
      DisplayLabel = 'Address1'
      DisplayWidth = 10
      FieldName = 'ContactAddress'
      Origin = 'tblmarketingcontactcontacts.ContactAddress'
      Size = 255
    end
    object qryMainContactAddress2: TWideStringField
      DisplayLabel = 'Address2'
      DisplayWidth = 10
      FieldName = 'ContactAddress2'
      Origin = 'tblmarketingcontactcontacts.ContactAddress2'
      Size = 255
    end
    object qryMainContactAddress3: TWideStringField
      DisplayLabel = 'Address3'
      DisplayWidth = 10
      FieldName = 'ContactAddress3'
      Origin = 'tblmarketingcontactcontacts.ContactAddress3'
      Size = 255
    end
    object qryMainContactCity: TWideStringField
      DisplayLabel = 'City'
      DisplayWidth = 10
      FieldName = 'ContactCity'
      Origin = 'tblmarketingcontactcontacts.ContactCity'
      Size = 255
    end
    object qryMainContactState: TWideStringField
      DisplayLabel = 'State'
      DisplayWidth = 10
      FieldName = 'ContactState'
      Origin = 'tblmarketingcontactcontacts.ContactState'
      Size = 255
    end
    object qryMainContactPcode: TWideStringField
      DisplayLabel = 'Post Code'
      DisplayWidth = 10
      FieldName = 'ContactPcode'
      Origin = 'tblmarketingcontactcontacts.ContactPcode'
      Size = 255
    end
    object qryMainContactCountry: TWideStringField
      DisplayLabel = 'Country'
      DisplayWidth = 10
      FieldName = 'ContactCountry'
      Origin = 'tblmarketingcontactcontacts.ContactCountry'
      Size = 255
    end
    object qryMainContactPH: TWideStringField
      DisplayLabel = 'Phone'
      DisplayWidth = 10
      FieldName = 'ContactPH'
      Origin = 'tblmarketingcontactcontacts.ContactPH'
      Size = 255
    end
    object qryMainContactAltPH: TWideStringField
      DisplayLabel = 'Alt Phone'
      DisplayWidth = 10
      FieldName = 'ContactAltPH'
      Origin = 'tblmarketingcontactcontacts.ContactAltPH'
      Size = 255
    end
    object qryMainContactMOB: TWideStringField
      DisplayLabel = 'Mobile'
      DisplayWidth = 10
      FieldName = 'ContactMOB'
      Origin = 'tblmarketingcontactcontacts.ContactMOB'
      Size = 255
    end
    object qryMainContactFax: TWideStringField
      DisplayLabel = 'Fax'
      DisplayWidth = 10
      FieldName = 'ContactFax'
      Origin = 'tblmarketingcontactcontacts.ContactFax'
      Size = 255
    end
    object qryMainContactEmail: TWideStringField
      DisplayLabel = 'Email'
      DisplayWidth = 10
      FieldName = 'ContactEmail'
      Origin = 'tblmarketingcontactcontacts.ContactEmail'
      Size = 255
    end
    object qryMainNotes: TWideStringField
      DisplayWidth = 10
      FieldName = 'Notes'
      Origin = 'tblmarketingcontactcontacts.Notes'
      Size = 255
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblmarketingcontactcontacts.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainCardNumber: TWideStringField
      DisplayLabel = 'Card Number'
      DisplayWidth = 10
      FieldName = 'CardNumber'
      Origin = 'tblmarketingcontactcontacts.CardNumber'
      Size = 255
    end
    object qryMainAccountNo: TWideStringField
      DisplayLabel = 'Account No'
      DisplayWidth = 10
      FieldName = 'AccountNo'
      Origin = 'tblmarketingcontactcontacts.AccountNo'
      Size = 255
    end
    object qryMainJobTitle: TWideStringField
      DisplayLabel = 'Job Title'
      DisplayWidth = 10
      FieldName = 'JobTitle'
      Origin = 'tblmarketingcontactcontacts.JobTitle'
      Size = 255
    end
    object qryMainIsPrimarycontact: TWideStringField
      DisplayLabel = 'Is Primary~Contact'
      DisplayWidth = 10
      FieldName = 'IsPrimarycontact'
      Origin = 'tblmarketingcontactcontacts.IsPrimarycontact'
      FixedChar = True
      Size = 1
    end
    object qryMainGlobalRef: TWideStringField
      DisplayWidth = 10
      FieldName = 'GlobalRef'
      Origin = 'tblmarketingcontactcontacts.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryMainContactID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'ID'
      DisplayWidth = 10
      FieldName = 'ContactID'
      Origin = 'tblmarketingcontactcontacts.ContactID'
      Visible = False
    end
    object qryMainMarketingContactID: TIntegerField
      DisplayWidth = 10
      FieldName = 'MarketingContactID'
      Origin = 'tblmarketingcontactcontacts.MarketingContactID'
      Visible = False
    end
  end
end
