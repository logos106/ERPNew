inherited NonRelatedCustomerGUI: TNonRelatedCustomerGUI
  Caption = 'Non Related Customers'
  ExplicitLeft = 250
  ExplicitTop = 143
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 817001
  inherited FooterPanel: TDnMPanel
    HelpContext = 817003
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
        end>
    end
  end
  inherited HeaderPanel: TPanel
    HelpContext = 817004
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited pnlHeader: TPanel
      HelpContext = 817005
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          Caption = 'Non Related Customers'
          HelpContext = 817002
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
    HelpContext = 817006
    inherited grdMain: TwwDBGrid
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'10'#9'Global Ref'#9'F'
        'CompanyName'#9'20'#9'Name'#9'F'
        'CustomerType'#9'10'#9'Customer~Type'#9'F'
        'AR Balance'#9'10'#9'AR Balance'#9#9
        'AP Balance'#9'10'#9'AP Balance'#9#9
        'Balance'#9'10'#9'Balance'#9#9
        'Firstname'#9'15'#9'First~Name'#9'F'
        'LastName'#9'15'#9'Last~Name'#9'F'
        'ContactName'#9'15'#9'Contact~Name'#9'F'
        'Contactdetails'#9'20'#9'Contact~Details'#9'F'
        'Email'#9'20'#9'Email'#9'F'
        'Street'#9'10'#9'Street'#9'F'
        'Street2'#9'10'#9'Street2'#9'F'
        'Street3'#9'10'#9'Street3'#9'F'
        'Suburb'#9'10'#9'Suburb'#9'F'
        'State'#9'10'#9'State'#9'F'
        'Postcode'#9'10'#9'Post Code'#9'F'
        'Country'#9'10'#9'Country'#9'F'
        'Phone'#9'15'#9'Phone'#9'F'
        'FaxNumber'#9'15'#9'Fax Number'#9'F'
        'Mobile'#9'15'#9'Mobile'#9'F'
        'AltContact'#9'10'#9'Contact'#9'F'#9'Alt'
        'AltPhone'#9'15'#9'Phone'#9'F'#9'Alt'
        'BillStreet'#9'10'#9'Street'#9'F'#9'Bill'
        'BillStreet2'#9'10'#9'Street2'#9'F'#9'Bill'
        'BillStreet3'#9'10'#9'Street3'#9'F'#9'Bill'
        'BillSuburb'#9'10'#9'Suburb'#9'F'#9'Bill'
        'BillState'#9'10'#9'State'#9'F'#9'Bill'
        'BillPostcode'#9'10'#9'Postcode'#9'F'#9'Bill'
        'BillCountry'#9'10'#9'Country'#9'F'#9'Bill'
        'AccountNo'#9'10'#9'AccountNo'#9'F'
        'CUSTFLD1'#9'10'#9'1'#9'F'#9'Custom Field'
        'CUSTFLD2'#9'10'#9'2'#9'F'#9'Custom Field'
        'CUSTFLD3'#9'10'#9'3'#9'F'#9'Custom Field'
        'CUSTFLD4'#9'10'#9'4'#9'F'#9'Custom Field'
        'CUSTFLD5'#9'10'#9'5'#9'F'#9'Custom Field'
        'CUSTFLD6'#9'10'#9'6'#9'F'#9'Custom Field'
        'CUSTFLD7'#9'10'#9'7'#9'F'#9'Custom Field'
        'CUSTFLD8'#9'10'#9'8'#9'F'#9'Custom Field'
        'CUSTFLD9'#9'10'#9'9'#9'F'#9'Custom Field'
        'CUSTFLD10'#9'10'#9'10'#9'F'#9'Custom Field'
        'CUSTFLD11'#9'10'#9'11'#9'F'#9'Custom Field'
        'CUSTFLD12'#9'10'#9'12'#9'F'#9'Custom Field'
        'CUSTFLD13'#9'10'#9'13'#9'F'#9'Custom Field'
        'CUSTFLD14'#9'10'#9'14'#9'F'#9'Custom Field'
        'CUSTFLD15'#9'10'#9'15'#9'F'#9'Custom Field'
        'CUSTDATE1'#9'10'#9'16'#9'F'#9'Custom Field'
        'CUSTDATE2'#9'10'#9'17'#9'F'#9'Custom Field'
        'CUSTDATE3'#9'10'#9'18'#9'F'#9'Custom Field'
        'CardNumber'#9'10'#9'Card~Number'#9'F'
        'Active'#9'1'#9'Active'#9#9
        'CreditLimit'#9'10'#9'Credit~Limit'#9'F'
        'GracePeriod'#9'10'#9'Grace~Period'#9'F'
        'PickingPriority'#9'10'#9'Picking~Priority'#9'F'
        'DefaultClass'#9'10'#9'Default~Class'#9'F'
        'Area'#9'10'#9'Area'#9#9
        'DischargeDate'#9'10'#9'Discharge~Date'#9'F'
        'CreationDate'#9'10'#9'Creation~Date'#9'F'
        'CreditCardType'#9'10'#9'Type'#9'F'#9'Credit Card '
        'CreditCardNumber'#9'10'#9'Number'#9'F'#9'Credit Card '
        'CreditCardExpiryDate'#9'10'#9'Expiry Date'#9'F'#9'Credit Card '
        'CreditCardNotes'#9'10'#9'Notes'#9'F'#9'Credit Card '
        'ABN'#9'10'#9'ABN'#9'F'
        'SOBalance'#9'10'#9'SO Balance'#9'F')
      TitleLines = 2
      UseTFields = False
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT C.GlobalRef as GlobalRef,'
      'SUBSTRING_INDEX(C.Company,"^",1) as CompanyName,'
      'CT.TypeName AS CustomerType,'
      'C.ARBalance AS "AR Balance",'
      'C.APBalance AS "AP Balance",'
      'C.Balance AS Balance,'
      'C.FirstName as Firstname, '
      'C.LastName as LastName,'
      'Concat_WS(" ",C.FirstName, C.LastName) AS ContactName,'
      'Concat_WS(" ",C.FirstName, C.LastName) AS Contactdetails,'
      'C.Email AS Email,'
      'C.Street AS Street,'
      'C.Street2 AS Street2,'
      'C.Street3 AS Street3,'
      'C.Suburb AS Suburb,'
      'C.State AS State,'
      'C.Postcode AS Postcode,'
      'C.Country AS Country,'
      'C.Phone AS Phone,'
      'C.FaxNumber AS FaxNumber,'
      'C.Mobile AS Mobile,'
      'C.AltContact AS AltContact,'
      'C.AltPhone AS AltPhone,'
      'C.BillStreet AS BillStreet,'
      'C.BillStreet2 AS BillStreet2,'
      'C.BillStreet3 AS BillStreet3,'
      'C.BillSuburb AS BillSuburb,'
      'C.BillState AS BillState,'
      'C.BillPostcode AS BillPostcode,'
      'C.BillCountry AS BillCountry,'
      'C.ClientNo as AccountNo,'
      'C.CUSTFLD1 AS CUSTFLD1,'
      'C.CUSTFLD2 AS CUSTFLD2,'
      'C.CUSTFLD3 AS CUSTFLD3,'
      'C.CUSTFLD4 AS CUSTFLD4,'
      'C.CUSTFLD5 AS CUSTFLD5,'
      'C.CUSTFLD6 AS CUSTFLD6,'
      'C.CUSTFLD7 AS CUSTFLD7,'
      'C.CUSTFLD8 AS CUSTFLD8,'
      'C.CUSTFLD9 AS CUSTFLD9,'
      'C.CUSTFLD10 AS CUSTFLD10,'
      'C.CUSTFLD11 AS CUSTFLD11,'
      'C.CUSTFLD12 AS CUSTFLD12,'
      'C.CUSTFLD13 AS CUSTFLD13,'
      'C.CUSTFLD14 AS CUSTFLD14,'
      'C.CUSTFLD15 AS CUSTFLD15,'
      'C.CUSTDATE1 AS CUSTDATE1,'
      'C.CUSTDATE2 AS CUSTDATE2,'
      'C.CUSTDATE3 AS CUSTDATE3,'
      'C.CardNumber as CardNumber,'
      'C.Active AS Active,'
      'C.ClientID AS ClientID,'
      'C.ParentClientID AS ParentClientID,'
      'C.ParentRelatedClientID AS ParentRelatedClientID,'
      'C.CreditLimit AS CreditLimit,'
      'C.TermsID AS TermsID,'
      'C.GracePeriod AS GracePeriod,'
      'C.PickingPriority AS PickingPriority,'
      'C.DefaultClass AS DefaultClass,'
      'C.Area AS Area,'
      'C.DischargeDate AS DischargeDate,'
      'C.CreationDate AS CreationDate,'
      'C.CreditCardType AS CreditCardType,'
      'C.CreditCardNumber AS CreditCardNumber,'
      'C.CreditCardExpiryDate AS CreditCardExpiryDate,'
      'C.CreditCardNotes AS CreditCardNotes,'
      'C.ABN AS ABN,'
      'C.SOBalance AS SOBalance'
      'FROM tblClients C'
      'LEFT JOIN tblclienttype CT Using(ClientTypeID)'
      'Left join tblrelatedclients  RC on RC.ChildClientID = C.clientID'
      'Where ifnull(RC.RelatedClientID ,0) =0'
      'and C.Customer="T" AND char_length(C.Company)>0'
      'and C.IsJob = '#39'F'#39
      'and (C.clientID <> :xclientID or :xclientID =0)')
    ParamData = <
      item
        DataType = ftInteger
        Name = 'XclientID'
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'xclientID'
        Value = 0
      end>
    object qryMainGlobalRef: TWideStringField
      DisplayLabel = 'Global Ref'
      DisplayWidth = 10
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMainCompanyName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldName = 'CompanyName'
      Size = 160
    end
    object qryMainCustomerType: TWideStringField
      DisplayLabel = 'Customer~Type'
      DisplayWidth = 10
      FieldName = 'CustomerType'
      Size = 50
    end
    object qryMainARBalance: TFloatField
      DisplayWidth = 10
      FieldName = 'AR Balance'
    end
    object qryMainAPBalance: TFloatField
      DisplayWidth = 10
      FieldName = 'AP Balance'
    end
    object qryMainBalance: TFloatField
      DisplayWidth = 10
      FieldName = 'Balance'
    end
    object qryMainFirstname: TWideStringField
      DisplayLabel = 'First~Name'
      DisplayWidth = 15
      FieldName = 'Firstname'
      Size = 40
    end
    object qryMainLastName: TWideStringField
      DisplayLabel = 'Last~Name'
      DisplayWidth = 15
      FieldName = 'LastName'
      Size = 40
    end
    object qryMainContactName: TWideStringField
      DisplayLabel = 'Contact~Name'
      DisplayWidth = 15
      FieldName = 'ContactName'
      Size = 81
    end
    object qryMainContactdetails: TWideStringField
      DisplayLabel = 'Contact~Details'
      DisplayWidth = 20
      FieldName = 'Contactdetails'
      Size = 81
    end
    object qryMainEmail: TWideStringField
      DisplayWidth = 20
      FieldName = 'Email'
      Size = 80
    end
    object qryMainStreet: TWideStringField
      DisplayWidth = 10
      FieldName = 'Street'
      Size = 255
    end
    object qryMainStreet2: TWideStringField
      DisplayWidth = 10
      FieldName = 'Street2'
      Size = 255
    end
    object qryMainStreet3: TWideStringField
      DisplayWidth = 10
      FieldName = 'Street3'
      Size = 255
    end
    object qryMainSuburb: TWideStringField
      DisplayWidth = 10
      FieldName = 'Suburb'
      Size = 255
    end
    object qryMainState: TWideStringField
      DisplayWidth = 10
      FieldName = 'State'
      Size = 255
    end
    object qryMainPostcode: TWideStringField
      DisplayLabel = 'Post Code'
      DisplayWidth = 10
      FieldName = 'Postcode'
      Size = 255
    end
    object qryMainCountry: TWideStringField
      DisplayWidth = 10
      FieldName = 'Country'
      Size = 255
    end
    object qryMainPhone: TWideStringField
      DisplayWidth = 15
      FieldName = 'Phone'
    end
    object qryMainFaxNumber: TWideStringField
      DisplayLabel = 'Fax Number'
      DisplayWidth = 15
      FieldName = 'FaxNumber'
    end
    object qryMainMobile: TWideStringField
      DisplayWidth = 15
      FieldName = 'Mobile'
    end
    object qryMainAltContact: TWideStringField
      DisplayLabel = 'Contact'
      DisplayWidth = 10
      FieldName = 'AltContact'
      Size = 50
    end
    object qryMainAltPhone: TWideStringField
      DisplayLabel = 'Phone'
      DisplayWidth = 15
      FieldName = 'AltPhone'
    end
    object qryMainBillStreet: TWideStringField
      DisplayWidth = 10
      FieldName = 'BillStreet'
      Size = 255
    end
    object qryMainBillStreet2: TWideStringField
      DisplayWidth = 10
      FieldName = 'BillStreet2'
      Size = 255
    end
    object qryMainBillStreet3: TWideStringField
      DisplayWidth = 10
      FieldName = 'BillStreet3'
      Size = 255
    end
    object qryMainBillSuburb: TWideStringField
      DisplayWidth = 10
      FieldName = 'BillSuburb'
      Size = 255
    end
    object qryMainBillState: TWideStringField
      DisplayWidth = 10
      FieldName = 'BillState'
      Size = 255
    end
    object qryMainBillPostcode: TWideStringField
      DisplayWidth = 10
      FieldName = 'BillPostcode'
      Size = 255
    end
    object qryMainBillCountry: TWideStringField
      DisplayWidth = 10
      FieldName = 'BillCountry'
      Size = 255
    end
    object qryMainAccountNo: TWideStringField
      DisplayWidth = 10
      FieldName = 'AccountNo'
      Size = 50
    end
    object qryMainCUSTFLD1: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD1'
      Size = 255
    end
    object qryMainCUSTFLD2: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD2'
      Size = 255
    end
    object qryMainCUSTFLD3: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD3'
      Size = 255
    end
    object qryMainCUSTFLD4: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD4'
      Size = 255
    end
    object qryMainCUSTFLD5: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD5'
      Size = 255
    end
    object qryMainCUSTFLD6: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD6'
      Size = 255
    end
    object qryMainCUSTFLD7: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD7'
      Size = 255
    end
    object qryMainCUSTFLD8: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD8'
      Size = 255
    end
    object qryMainCUSTFLD9: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD9'
      Size = 255
    end
    object qryMainCUSTFLD10: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD10'
      Size = 255
    end
    object qryMainCUSTFLD11: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD11'
      Size = 255
    end
    object qryMainCUSTFLD12: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD12'
      Size = 255
    end
    object qryMainCUSTFLD13: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD13'
      Size = 255
    end
    object qryMainCUSTFLD14: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD14'
      Size = 255
    end
    object qryMainCUSTFLD15: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD15'
      Size = 255
    end
    object qryMainCUSTDATE1: TDateField
      DisplayWidth = 10
      FieldName = 'CUSTDATE1'
    end
    object qryMainCUSTDATE2: TDateField
      DisplayWidth = 10
      FieldName = 'CUSTDATE2'
    end
    object qryMainCUSTDATE3: TDateField
      DisplayWidth = 10
      FieldName = 'CUSTDATE3'
    end
    object qryMainCardNumber: TWideStringField
      DisplayWidth = 10
      FieldName = 'CardNumber'
      Size = 255
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryMainClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
    end
    object qryMainParentClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ParentClientID'
    end
    object qryMainParentRelatedClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ParentRelatedClientID'
    end
    object qryMainCreditLimit: TFloatField
      DisplayWidth = 10
      FieldName = 'CreditLimit'
    end
    object qryMainTermsID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TermsID'
    end
    object qryMainGracePeriod: TWordField
      DisplayWidth = 10
      FieldName = 'GracePeriod'
    end
    object qryMainPickingPriority: TIntegerField
      DisplayWidth = 10
      FieldName = 'PickingPriority'
    end
    object qryMainDefaultClass: TWideStringField
      DisplayWidth = 10
      FieldName = 'DefaultClass'
      Size = 255
    end
    object qryMainArea: TWideStringField
      DisplayWidth = 10
      FieldName = 'Area'
    end
    object qryMainDischargeDate: TDateField
      DisplayWidth = 10
      FieldName = 'DischargeDate'
    end
    object qryMainCreationDate: TDateField
      DisplayWidth = 10
      FieldName = 'CreationDate'
    end
    object qryMainCreditCardType: TWideStringField
      DisplayWidth = 10
      FieldName = 'CreditCardType'
      Size = 255
    end
    object qryMainCreditCardNumber: TWideStringField
      DisplayWidth = 10
      FieldName = 'CreditCardNumber'
      Size = 255
    end
    object qryMainCreditCardExpiryDate: TWideStringField
      DisplayWidth = 10
      FieldName = 'CreditCardExpiryDate'
      Size = 255
    end
    object qryMainCreditCardNotes: TWideStringField
      DisplayWidth = 10
      FieldName = 'CreditCardNotes'
      Size = 255
    end
    object qryMainABN: TWideStringField
      DisplayWidth = 10
      FieldName = 'ABN'
      Size = 15
    end
    object qryMainSOBalance: TFloatField
      DisplayWidth = 10
      FieldName = 'SOBalance'
    end
  end
end
