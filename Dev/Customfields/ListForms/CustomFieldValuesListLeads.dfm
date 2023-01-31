inherited CustomFieldValuesListLeadsGUI: TCustomFieldValuesListLeadsGUI
  Caption = 'Customisable List - Leads'
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1613002
  inherited HeaderPanel: TPanel
    HelpContext = 1613006
    inherited pnlHeader: TPanel
      Left = 263
      Width = 469
      ExplicitLeft = 263
      ExplicitWidth = 469
      HelpContext = 1613003
      inherited TitleShader: TShader
        Width = 467
        ExplicitWidth = 467
        HelpContext = 1613004
        inherited TitleLabel: TLabel
          Width = 467
          Caption = 'Customisable List - Leads'
          ExplicitWidth = 467
          HelpContext = 1613005
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 1613007
      inherited grpFilters: TwwRadioGroup
        ExplicitLeft = 453
        ExplicitWidth = 307
      end
    end
  end
  inherited Panel1: TPanel
    HelpContext = 1613008
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'ID'#9'10'#9'ID'#9'F'#9
        'GlobalRef'#9'255'#9'GlobalRef'#9'F'#9
        'LeadID'#9'10'#9'LeadID'#9'F'#9
        'ClientID'#9'10'#9'ClientID'#9'F'#9
        'Company'#9'20'#9'Company'#9#9
        'RepID'#9'10'#9'RepID'#9'F'#9
        'EnteredByEmployeeID'#9'10'#9'EnteredByEmployeeID'#9'F'#9
        'Street'#9'10'#9'Street'#9'F'#9
        'Street2'#9'255'#9'Street2'#9'F'#9
        'Street3'#9'255'#9'Street3'#9'F'#9
        'SUBURB'#9'255'#9'SUBURB'#9'F'#9
        'STATE'#9'255'#9'STATE'#9'F'#9
        'Country'#9'255'#9'Country'#9'F'#9
        'POSTCODE'#9'255'#9'POSTCODE'#9'F'#9
        'FaxNumber'#9'255'#9'FaxNumber'#9'F'#9
        'Phone'#9'255'#9'Phone'#9#9
        'AltPhone'#9'255'#9'AltPhone'#9#9
        'Mobile'#9'255'#9'Mobile'#9#9
        'Source'#9'255'#9'Source'#9'F'#9
        'CreatedOn'#9'18'#9'CreatedOn'#9'F'#9
        'ContactName'#9'511'#9'ContactName'#9#9
        'LeadStatus'#9'255'#9'LeadStatus'#9'F'#9)
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT'
      'MC.ID,'
      'ML.GlobalRef as GlobalRef,'
      'ML.LeadID as LeadID,'
      'ML.ClientID as ClientID,'
      'MC.COMPANY as Company,'
      'ML.RepID as RepID,'
      'ML.EnteredByEmployeeID as EnteredByEmployeeID,'
      'MC.Street as Street,'
      'MC.Street2 as Street2,'
      'MC.Street3 as Street3,'
      'MC.SUBURB as SUBURB,'
      'MC.STATE as STATE,'
      'MC.Country as Country,'
      'MC.POSTCODE as POSTCODE,'
      'MC.FaxNumber as FaxNumber, '
      'MC.Phone as Phone,'
      'MC.AltPhone as AltPhone,'
      'MC.Mobile as Mobile,'
      'MC.Source as Source,'
      'ML.CreatedOn as CreatedOn,'
      'CONCAT(MC.FirstName," ",MC.LastName) as ContactName,'
      ''
      'ML.LeadStatus as LeadStatus'
      'FROM tblMarketingLeads ML '
      
        'inner join tblmarketingcontacts  MC on (MC.ID = ML.MarketingCont' +
        'actID)'
      ''
      'Where ML.IsLead <> "F"'
      
        'and IfNull(ML.CreatedOn,"1899/12/31") between :DateFrom and :Dat' +
        'eto'
      'AND  MC.Active = "T"')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DateFrom'
      end
      item
        DataType = ftUnknown
        Name = 'Dateto'
      end>
    object qryMainID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ID'
    end
    object qryMainGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMainLeadID: TIntegerField
      DisplayWidth = 10
      FieldName = 'LeadID'
    end
    object qryMainClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
    end
    object qryMainCompany: TWideStringField
      DisplayWidth = 20
      FieldName = 'Company'
      Size = 255
    end
    object qryMainRepID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RepID'
    end
    object qryMainEnteredByEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EnteredByEmployeeID'
    end
    object qryMainStreet: TWideStringField
      DisplayWidth = 10
      FieldName = 'Street'
      Size = 255
    end
    object qryMainStreet2: TWideStringField
      DisplayWidth = 255
      FieldName = 'Street2'
      Size = 255
    end
    object qryMainStreet3: TWideStringField
      DisplayWidth = 255
      FieldName = 'Street3'
      Size = 255
    end
    object qryMainSUBURB: TWideStringField
      DisplayWidth = 255
      FieldName = 'SUBURB'
      Size = 255
    end
    object qryMainSTATE: TWideStringField
      DisplayWidth = 255
      FieldName = 'STATE'
      Size = 255
    end
    object qryMainCountry: TWideStringField
      DisplayWidth = 255
      FieldName = 'Country'
      Size = 255
    end
    object qryMainPOSTCODE: TWideStringField
      DisplayWidth = 255
      FieldName = 'POSTCODE'
      Size = 255
    end
    object qryMainFaxNumber: TWideStringField
      DisplayWidth = 255
      FieldName = 'FaxNumber'
      Size = 255
    end
    object qryMainPhone: TWideStringField
      DisplayWidth = 255
      FieldName = 'Phone'
      Size = 255
    end
    object qryMainAltPhone: TWideStringField
      DisplayWidth = 255
      FieldName = 'AltPhone'
      Size = 255
    end
    object qryMainMobile: TWideStringField
      DisplayWidth = 255
      FieldName = 'Mobile'
      Size = 255
    end
    object qryMainSource: TWideStringField
      DisplayWidth = 255
      FieldName = 'Source'
      Size = 255
    end
    object qryMainCreatedOn: TDateTimeField
      DisplayWidth = 18
      FieldName = 'CreatedOn'
    end
    object qryMainContactName: TWideStringField
      DisplayWidth = 511
      FieldName = 'ContactName'
      Size = 511
    end
    object qryMainLeadStatus: TWideStringField
      DisplayWidth = 255
      FieldName = 'LeadStatus'
      Size = 255
    end
  end
end
