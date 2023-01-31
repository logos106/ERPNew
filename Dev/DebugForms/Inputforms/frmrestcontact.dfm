inherited fmrestcontact: Tfmrestcontact
  Caption = 'fmrestcontact'
  PixelsPerInch = 96
  TextHeight = 15
  object Button1: TButton [3]
    Left = 368
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo [4]
    Left = 536
    Top = 0
    Width = 416
    Height = 532
    Align = alRight
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object Memo2: TMemo [5]
    Left = 0
    Top = 0
    Width = 416
    Height = 532
    Align = alLeft
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
    ExplicitLeft = 536
  end
  inherited MyConnection: TERPConnection
    Left = 280
    Top = 95
  end
  object qryContacts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblContacts'
      'WHERE ContactID=:KeyID;')
    Left = 277
    Top = 157
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
    object qryContactsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryContactsContactID: TIntegerField
      FieldName = 'ContactID'
    end
    object qryContactsCusID: TIntegerField
      FieldName = 'CusID'
    end
    object qryContactsSupID: TIntegerField
      FieldName = 'SupID'
    end
    object qryContactsEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryContactsCompany: TWideStringField
      FieldName = 'Company'
      Size = 50
    end
    object qryContactsContactTitle: TWideStringField
      FieldName = 'ContactTitle'
      Size = 32
    end
    object qryContactsContactFirstName: TWideStringField
      FieldName = 'ContactFirstName'
      Size = 30
    end
    object qryContactsContactSurName: TWideStringField
      FieldName = 'ContactSurName'
      Size = 30
    end
    object qryContactsContactAddress: TWideStringField
      FieldName = 'ContactAddress'
      Size = 255
    end
    object qryContactsContactAddress2: TWideStringField
      FieldName = 'ContactAddress2'
      Size = 255
    end
    object qryContactsContactAddress3: TWideStringField
      FieldName = 'ContactAddress3'
      Size = 255
    end
    object qryContactsContactCity: TWideStringField
      FieldName = 'ContactCity'
      Size = 255
    end
    object qryContactsContactState: TWideStringField
      FieldName = 'ContactState'
      Size = 255
    end
    object qryContactsContactPcode: TWideStringField
      FieldName = 'ContactPcode'
      Size = 255
    end
    object qryContactsContactCountry: TWideStringField
      FieldName = 'ContactCountry'
      Size = 255
    end
    object qryContactsContactPH: TWideStringField
      FieldName = 'ContactPH'
      Size = 255
    end
    object qryContactsContactAltPH: TWideStringField
      FieldName = 'ContactAltPH'
      Size = 255
    end
    object qryContactsContactMOB: TWideStringField
      FieldName = 'ContactMOB'
      Size = 255
    end
    object qryContactsContactFax: TWideStringField
      FieldName = 'ContactFax'
      Size = 255
    end
    object qryContactsContactEmail: TWideStringField
      FieldName = 'ContactEmail'
      Size = 255
    end
    object qryContactsNotes: TWideStringField
      FieldName = 'Notes'
      Size = 255
    end
    object qryContactsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryContactsActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryContactsCardNumber: TWideStringField
      FieldName = 'CardNumber'
      Size = 255
    end
    object qryContactsAccountNo: TWideStringField
      FieldName = 'AccountNo'
      Size = 255
    end
    object qryContactsJobTitle: TWideStringField
      FieldName = 'JobTitle'
      Size = 255
    end
    object qryContactsContactIsCustomer: TWideStringField
      FieldName = 'ContactIsCustomer'
      FixedChar = True
      Size = 1
    end
    object qryContactsContactIsJob: TWideStringField
      FieldName = 'ContactIsJob'
      FixedChar = True
      Size = 1
    end
    object qryContactsContactIsSupplier: TWideStringField
      FieldName = 'ContactIsSupplier'
      FixedChar = True
      Size = 1
    end
    object qryContactsContactIsOtherContact: TWideStringField
      FieldName = 'ContactIsOtherContact'
      FixedChar = True
      Size = 1
    end
    object qryContactsUseOnRun: TWideStringField
      FieldName = 'UseOnRun'
      FixedChar = True
      Size = 1
    end
    object qryContactsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryContactsLogMeInComputerIPAddress: TWideStringField
      FieldName = 'LogMeInComputerIPAddress'
    end
    object qryContactsLogMeInEmailPassword: TWideStringField
      FieldName = 'LogMeInEmailPassword'
      Size = 100
    end
    object qryContactsLogMeInUserName: TWideStringField
      FieldName = 'LogMeInUserName'
      Size = 100
    end
    object qryContactsLogMeInPassword: TWideStringField
      FieldName = 'LogMeInPassword'
      Size = 100
    end
    object qryContactsLogMeInERPUserName: TWideStringField
      FieldName = 'LogMeInERPUserName'
      Size = 100
    end
    object qryContactsLogMeInERPPassword: TWideStringField
      FieldName = 'LogMeInERPPassword'
      Size = 100
    end
    object qryContactsLogMeIncomputerPassword: TWideStringField
      FieldName = 'LogMeIncomputerPassword'
      Size = 100
    end
    object qryContactsIsPrimarycontact: TWideStringField
      FieldName = 'IsPrimarycontact'
      FixedChar = True
      Size = 1
    end
    object qryContactsTeamviewerID: TWideStringField
      FieldName = 'TeamviewerID'
      Size = 9
    end
  end
  object frmContactSrc: TDataSource
    DataSet = qryContacts
    Left = 310
    Top = 158
  end
  object qryContactscopy: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblContacts'
      'WHERE ContactID=:KeyID;')
    Left = 421
    Top = 157
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
    object WideStringField1: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object IntegerField1: TIntegerField
      FieldName = 'ContactID'
    end
    object IntegerField2: TIntegerField
      FieldName = 'CusID'
    end
    object IntegerField3: TIntegerField
      FieldName = 'SupID'
    end
    object IntegerField4: TIntegerField
      FieldName = 'EmployeeID'
    end
    object WideStringField2: TWideStringField
      FieldName = 'Company'
      Size = 50
    end
    object WideStringField3: TWideStringField
      FieldName = 'ContactTitle'
      Size = 32
    end
    object WideStringField4: TWideStringField
      FieldName = 'ContactFirstName'
      Size = 30
    end
    object WideStringField5: TWideStringField
      FieldName = 'ContactSurName'
      Size = 30
    end
    object WideStringField6: TWideStringField
      FieldName = 'ContactAddress'
      Size = 255
    end
    object WideStringField7: TWideStringField
      FieldName = 'ContactAddress2'
      Size = 255
    end
    object WideStringField8: TWideStringField
      FieldName = 'ContactAddress3'
      Size = 255
    end
    object WideStringField9: TWideStringField
      FieldName = 'ContactCity'
      Size = 255
    end
    object WideStringField10: TWideStringField
      FieldName = 'ContactState'
      Size = 255
    end
    object WideStringField11: TWideStringField
      FieldName = 'ContactPcode'
      Size = 255
    end
    object WideStringField12: TWideStringField
      FieldName = 'ContactCountry'
      Size = 255
    end
    object WideStringField13: TWideStringField
      FieldName = 'ContactPH'
      Size = 255
    end
    object WideStringField14: TWideStringField
      FieldName = 'ContactAltPH'
      Size = 255
    end
    object WideStringField15: TWideStringField
      FieldName = 'ContactMOB'
      Size = 255
    end
    object WideStringField16: TWideStringField
      FieldName = 'ContactFax'
      Size = 255
    end
    object WideStringField17: TWideStringField
      FieldName = 'ContactEmail'
      Size = 255
    end
    object WideStringField18: TWideStringField
      FieldName = 'Notes'
      Size = 255
    end
    object WideStringField19: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object WideStringField20: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object WideStringField21: TWideStringField
      FieldName = 'CardNumber'
      Size = 255
    end
    object WideStringField22: TWideStringField
      FieldName = 'AccountNo'
      Size = 255
    end
    object WideStringField23: TWideStringField
      FieldName = 'JobTitle'
      Size = 255
    end
    object WideStringField24: TWideStringField
      FieldName = 'ContactIsCustomer'
      FixedChar = True
      Size = 1
    end
    object WideStringField25: TWideStringField
      FieldName = 'ContactIsJob'
      FixedChar = True
      Size = 1
    end
    object WideStringField26: TWideStringField
      FieldName = 'ContactIsSupplier'
      FixedChar = True
      Size = 1
    end
    object WideStringField27: TWideStringField
      FieldName = 'ContactIsOtherContact'
      FixedChar = True
      Size = 1
    end
    object WideStringField28: TWideStringField
      FieldName = 'UseOnRun'
      FixedChar = True
      Size = 1
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object WideStringField29: TWideStringField
      FieldName = 'LogMeInComputerIPAddress'
    end
    object WideStringField30: TWideStringField
      FieldName = 'LogMeInEmailPassword'
      Size = 100
    end
    object WideStringField31: TWideStringField
      FieldName = 'LogMeInUserName'
      Size = 100
    end
    object WideStringField32: TWideStringField
      FieldName = 'LogMeInPassword'
      Size = 100
    end
    object WideStringField33: TWideStringField
      FieldName = 'LogMeInERPUserName'
      Size = 100
    end
    object WideStringField34: TWideStringField
      FieldName = 'LogMeInERPPassword'
      Size = 100
    end
    object WideStringField35: TWideStringField
      FieldName = 'LogMeIncomputerPassword'
      Size = 100
    end
    object WideStringField36: TWideStringField
      FieldName = 'IsPrimarycontact'
      FixedChar = True
      Size = 1
    end
    object WideStringField37: TWideStringField
      FieldName = 'TeamviewerID'
      Size = 9
    end
  end
  object frmContactSrccopy: TDataSource
    DataSet = qryContactscopy
    Left = 454
    Top = 158
  end
  object qryContactsdup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblContacts'
      'WHERE ContactID=:KeyID;')
    Left = 277
    Top = 189
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
    object WideStringField38: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object IntegerField5: TIntegerField
      FieldName = 'ContactID'
    end
    object IntegerField6: TIntegerField
      FieldName = 'CusID'
    end
    object IntegerField7: TIntegerField
      FieldName = 'SupID'
    end
    object IntegerField8: TIntegerField
      FieldName = 'EmployeeID'
    end
    object WideStringField39: TWideStringField
      FieldName = 'Company'
      Size = 50
    end
    object WideStringField40: TWideStringField
      FieldName = 'ContactTitle'
      Size = 32
    end
    object WideStringField41: TWideStringField
      FieldName = 'ContactFirstName'
      Size = 30
    end
    object WideStringField42: TWideStringField
      FieldName = 'ContactSurName'
      Size = 30
    end
    object WideStringField43: TWideStringField
      FieldName = 'ContactAddress'
      Size = 255
    end
    object WideStringField44: TWideStringField
      FieldName = 'ContactAddress2'
      Size = 255
    end
    object WideStringField45: TWideStringField
      FieldName = 'ContactAddress3'
      Size = 255
    end
    object WideStringField46: TWideStringField
      FieldName = 'ContactCity'
      Size = 255
    end
    object WideStringField47: TWideStringField
      FieldName = 'ContactState'
      Size = 255
    end
    object WideStringField48: TWideStringField
      FieldName = 'ContactPcode'
      Size = 255
    end
    object WideStringField49: TWideStringField
      FieldName = 'ContactCountry'
      Size = 255
    end
    object WideStringField50: TWideStringField
      FieldName = 'ContactPH'
      Size = 255
    end
    object WideStringField51: TWideStringField
      FieldName = 'ContactAltPH'
      Size = 255
    end
    object WideStringField52: TWideStringField
      FieldName = 'ContactMOB'
      Size = 255
    end
    object WideStringField53: TWideStringField
      FieldName = 'ContactFax'
      Size = 255
    end
    object WideStringField54: TWideStringField
      FieldName = 'ContactEmail'
      Size = 255
    end
    object WideStringField55: TWideStringField
      FieldName = 'Notes'
      Size = 255
    end
    object WideStringField56: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object WideStringField57: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object WideStringField58: TWideStringField
      FieldName = 'CardNumber'
      Size = 255
    end
    object WideStringField59: TWideStringField
      FieldName = 'AccountNo'
      Size = 255
    end
    object WideStringField60: TWideStringField
      FieldName = 'JobTitle'
      Size = 255
    end
    object WideStringField61: TWideStringField
      FieldName = 'ContactIsCustomer'
      FixedChar = True
      Size = 1
    end
    object WideStringField62: TWideStringField
      FieldName = 'ContactIsJob'
      FixedChar = True
      Size = 1
    end
    object WideStringField63: TWideStringField
      FieldName = 'ContactIsSupplier'
      FixedChar = True
      Size = 1
    end
    object WideStringField64: TWideStringField
      FieldName = 'ContactIsOtherContact'
      FixedChar = True
      Size = 1
    end
    object WideStringField65: TWideStringField
      FieldName = 'UseOnRun'
      FixedChar = True
      Size = 1
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object WideStringField66: TWideStringField
      FieldName = 'LogMeInComputerIPAddress'
    end
    object WideStringField67: TWideStringField
      FieldName = 'LogMeInEmailPassword'
      Size = 100
    end
    object WideStringField68: TWideStringField
      FieldName = 'LogMeInUserName'
      Size = 100
    end
    object WideStringField69: TWideStringField
      FieldName = 'LogMeInPassword'
      Size = 100
    end
    object WideStringField70: TWideStringField
      FieldName = 'LogMeInERPUserName'
      Size = 100
    end
    object WideStringField71: TWideStringField
      FieldName = 'LogMeInERPPassword'
      Size = 100
    end
    object WideStringField72: TWideStringField
      FieldName = 'LogMeIncomputerPassword'
      Size = 100
    end
    object WideStringField73: TWideStringField
      FieldName = 'IsPrimarycontact'
      FixedChar = True
      Size = 1
    end
    object WideStringField74: TWideStringField
      FieldName = 'TeamviewerID'
      Size = 9
    end
  end
  object frmContactSrcdup: TDataSource
    DataSet = qryContactsdup
    Left = 310
    Top = 190
  end
  object qryContactscopydup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblContacts'
      'WHERE ContactID=:KeyID;')
    Left = 421
    Top = 189
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
    object WideStringField75: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object IntegerField9: TIntegerField
      FieldName = 'ContactID'
    end
    object IntegerField10: TIntegerField
      FieldName = 'CusID'
    end
    object IntegerField11: TIntegerField
      FieldName = 'SupID'
    end
    object IntegerField12: TIntegerField
      FieldName = 'EmployeeID'
    end
    object WideStringField76: TWideStringField
      FieldName = 'Company'
      Size = 50
    end
    object WideStringField77: TWideStringField
      FieldName = 'ContactTitle'
      Size = 32
    end
    object WideStringField78: TWideStringField
      FieldName = 'ContactFirstName'
      Size = 30
    end
    object WideStringField79: TWideStringField
      FieldName = 'ContactSurName'
      Size = 30
    end
    object WideStringField80: TWideStringField
      FieldName = 'ContactAddress'
      Size = 255
    end
    object WideStringField81: TWideStringField
      FieldName = 'ContactAddress2'
      Size = 255
    end
    object WideStringField82: TWideStringField
      FieldName = 'ContactAddress3'
      Size = 255
    end
    object WideStringField83: TWideStringField
      FieldName = 'ContactCity'
      Size = 255
    end
    object WideStringField84: TWideStringField
      FieldName = 'ContactState'
      Size = 255
    end
    object WideStringField85: TWideStringField
      FieldName = 'ContactPcode'
      Size = 255
    end
    object WideStringField86: TWideStringField
      FieldName = 'ContactCountry'
      Size = 255
    end
    object WideStringField87: TWideStringField
      FieldName = 'ContactPH'
      Size = 255
    end
    object WideStringField88: TWideStringField
      FieldName = 'ContactAltPH'
      Size = 255
    end
    object WideStringField89: TWideStringField
      FieldName = 'ContactMOB'
      Size = 255
    end
    object WideStringField90: TWideStringField
      FieldName = 'ContactFax'
      Size = 255
    end
    object WideStringField91: TWideStringField
      FieldName = 'ContactEmail'
      Size = 255
    end
    object WideStringField92: TWideStringField
      FieldName = 'Notes'
      Size = 255
    end
    object WideStringField93: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object WideStringField94: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object WideStringField95: TWideStringField
      FieldName = 'CardNumber'
      Size = 255
    end
    object WideStringField96: TWideStringField
      FieldName = 'AccountNo'
      Size = 255
    end
    object WideStringField97: TWideStringField
      FieldName = 'JobTitle'
      Size = 255
    end
    object WideStringField98: TWideStringField
      FieldName = 'ContactIsCustomer'
      FixedChar = True
      Size = 1
    end
    object WideStringField99: TWideStringField
      FieldName = 'ContactIsJob'
      FixedChar = True
      Size = 1
    end
    object WideStringField100: TWideStringField
      FieldName = 'ContactIsSupplier'
      FixedChar = True
      Size = 1
    end
    object WideStringField101: TWideStringField
      FieldName = 'ContactIsOtherContact'
      FixedChar = True
      Size = 1
    end
    object WideStringField102: TWideStringField
      FieldName = 'UseOnRun'
      FixedChar = True
      Size = 1
    end
    object DateTimeField3: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object WideStringField103: TWideStringField
      FieldName = 'LogMeInComputerIPAddress'
    end
    object WideStringField104: TWideStringField
      FieldName = 'LogMeInEmailPassword'
      Size = 100
    end
    object WideStringField105: TWideStringField
      FieldName = 'LogMeInUserName'
      Size = 100
    end
    object WideStringField106: TWideStringField
      FieldName = 'LogMeInPassword'
      Size = 100
    end
    object WideStringField107: TWideStringField
      FieldName = 'LogMeInERPUserName'
      Size = 100
    end
    object WideStringField108: TWideStringField
      FieldName = 'LogMeInERPPassword'
      Size = 100
    end
    object WideStringField109: TWideStringField
      FieldName = 'LogMeIncomputerPassword'
      Size = 100
    end
    object WideStringField110: TWideStringField
      FieldName = 'IsPrimarycontact'
      FixedChar = True
      Size = 1
    end
    object WideStringField111: TWideStringField
      FieldName = 'TeamviewerID'
      Size = 9
    end
  end
  object frmContactSrccopydup: TDataSource
    DataSet = qryContactscopydup
    Left = 454
    Top = 190
  end
  object qryCustomers: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'ClientID, Company, ABN, Title, FirstName, MiddleName, LastName,'
      
        'Position, Street, Street2, Street3, Suburb, State, Country, Post' +
        'code, BillStreet,'
      
        'BillStreet2, BillStreet3, BillSuburb, BillState, BillCountry, Bi' +
        'llPostcode, POBox, POSuburb,'
      'POState, POCountry, POPostcode, Phone, FaxNumber, Mobile, Email,'
      
        'AltContact, AltPhone, Contact1, PhoneSupportTill, Contact2, Cont' +
        'act1Phone,'
      
        'Contact2Phone, Notes, ClientNo, ClientTypeID, InvBaseNumber, Use' +
        'InvBase,'
      
        'MedTypeID, TYPE, TAXID, CreditLimit, Balance, TERMS, TermsID, Gr' +
        'acePeriod,'
      
        'ShippingMethod, ShippingID, Discount, SpecialDiscount, JobName,S' +
        'endXMLInvoices,'
      'IsJob, CUSTFLD1, CUSTFLD2, CUSTFLD3, CUSTFLD4, CUSTFLD5,'
      'CUSTFLD6, CUSTFLD7, CUSTFLD8, CUSTFLD9, CUSTFLD10,'
      'CUSTFLD11, CUSTFLD12, CUSTFLD13, CUSTFLD14, CUSTFLD15,'
      'CUSTDATE1, CUSTDATE2, CUSTDATE3,'
      'PayMethodID, Feedback, Customer, Supplier, OtherContact,'
      
        'OtherContactType, RepID, RepName, Global, Done, Active, StopCred' +
        'it,'
      'EditedFlag, DontContact, ParentClientID, URL,EmailXML,'
      
        'Required, ForcePOOnBooking, ForcePOOnInvoice,ForcePOOnCustomer,P' +
        'ickingPriority,'
      
        'DefaultInvoiceTemplateID, DefaultDeliveryTemplateID, CardNumber,' +
        'GroupDiscountOverridesAll,'
      
        'DefaultClass, CreationDate, DischargeDate, Area, JobTitle, Paren' +
        'tRelatedClientID,'
      
        'DeliveryNotes, DefaultContactMethod,CreditCardNumber,CreditCardE' +
        'xpiryDate,'
      
        'CreditCardNotes, CreditCardType, CreditCardCardHolderName, LastU' +
        'pdated,'
      'BankAccountName, BankAccountBSB, BankAccountNo, BankCode,'
      
        'ForeignExchangeSellCode, Hours, InvoiceComment, InvoiceCommentPo' +
        'pUp,'
      
        'IncludeOnIntrastat, ForcePOOnRepair, Globalref, SpecialProductPr' +
        'iceOverridesAll,'
      
        'PortOfLanding ,PortOfDischarge ,FinalDestination ,IncoPlace,Ship' +
        'pingAgentID  , DefaultStatementTemplateId,CallPriority, Teamview' +
        'erID , Skypename'
      'FROM tblclients'
      'WHERE Customer='#39'T'#39' AND ClientID = :CusID;')
    Left = 224
    Top = 153
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CusID'
      end>
    object qryCustomersPhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'tblclients.Phone'
      EditMask = '## #### ####;0;_'
    end
    object qryCustomersFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
      Origin = 'tblclients.FaxNumber'
      EditMask = '## #### ####;0;_'
    end
    object qryCustomersMobile: TWideStringField
      FieldName = 'Mobile'
      Origin = 'tblclients.Mobile'
      EditMask = '#### ### ###;0;_'
    end
    object qryCustomersAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Origin = 'tblclients.AltPhone'
      EditMask = '## #### ####;0;_'
    end
    object qryCustomersContact1Phone: TWideStringField
      FieldName = 'Contact1Phone'
      Origin = 'tblclients.Contact1Phone'
      EditMask = '## #### ####;0;_'
    end
    object qryCustomersContact2Phone: TWideStringField
      FieldName = 'Contact2Phone'
      Origin = 'tblclients.Contact2Phone'
      EditMask = '## #### ####;0;_'
    end
    object qryCustomersClientID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientID'
      Origin = 'tblclients.ClientID'
      ReadOnly = True
    end
    object qryCustomersCompany: TWideStringField
      FieldName = 'Company'
      Origin = 'tblclients.Company'
      Size = 80
    end
    object qryCustomersABN: TWideStringField
      FieldName = 'ABN'
      Origin = 'tblclients.ABN'
      EditMask = '## ### ### ###;0;_'
      Size = 15
    end
    object qryCustomersFirstName: TWideStringField
      FieldName = 'FirstName'
      Origin = 'tblclients.FirstName'
      Size = 40
    end
    object qryCustomersMiddleName: TWideStringField
      FieldName = 'MiddleName'
      Origin = 'tblclients.MiddleName'
      Size = 40
    end
    object qryCustomersLastName: TWideStringField
      FieldName = 'LastName'
      Origin = 'tblclients.LastName'
      Size = 40
    end
    object qryCustomersPosition: TWideStringField
      FieldName = 'Position'
      Origin = 'tblclients.Position'
      Size = 30
    end
    object qryCustomersEmail: TWideStringField
      FieldName = 'Email'
      Origin = 'tblclients.Email'
      Size = 80
    end
    object qryCustomersAltContact: TWideStringField
      FieldName = 'AltContact'
      Origin = 'tblclients.AltContact'
      Size = 50
    end
    object qryCustomersContact1: TWideStringField
      FieldName = 'Contact1'
      Origin = 'tblclients.Contact1'
      Size = 50
    end
    object qryCustomersPhoneSupportTill: TDateField
      FieldName = 'PhoneSupportTill'
      Origin = 'tblclients.PhoneSupportTill'
    end
    object qryCustomersContact2: TWideStringField
      FieldName = 'Contact2'
      Origin = 'tblclients.Contact2'
      Size = 50
    end
    object qryCustomersNotes: TWideMemoField
      FieldName = 'Notes'
      Origin = 'tblclients.Notes'
      BlobType = ftWideMemo
    end
    object qryCustomersMedTypeID: TIntegerField
      FieldName = 'MedTypeID'
      Origin = 'tblclients.MedTypeID'
    end
    object qryCustomersTYPE: TWideStringField
      FieldName = 'TYPE'
      Origin = 'tblclients.TYPE'
      Size = 50
    end
    object qryCustomersCreditLimit: TFloatField
      FieldName = 'CreditLimit'
      Origin = 'tblclients.CreditLimit'
    end
    object qryCustomersBalance: TFloatField
      FieldName = 'Balance'
      Origin = 'tblclients.Balance'
      currency = True
    end
    object qryCustomersTERMS: TWideStringField
      FieldName = 'TERMS'
      Origin = 'tblclients.TERMS'
      Size = 30
    end
    object qryCustomersTermsID: TIntegerField
      FieldName = 'TermsID'
      Origin = 'tblclients.TermsID'
    end
    object qryCustomersShippingMethod: TWideStringField
      FieldName = 'ShippingMethod'
      Origin = 'tblclients.ShippingMethod'
      Size = 30
    end
    object qryCustomersShippingID: TIntegerField
      FieldName = 'ShippingID'
      Origin = 'tblclients.ShippingID'
    end
    object qryCustomersDiscount: TFloatField
      FieldName = 'Discount'
      Origin = 'tblclients.Discount'
      DisplayFormat = '#.#%'
    end
    object qryCustomersSpecialDiscount: TFloatField
      FieldName = 'SpecialDiscount'
      Origin = 'tblclients.SpecialDiscount'
    end
    object qryCustomersJobName: TWideStringField
      FieldName = 'JobName'
      Origin = 'tblclients.JobName'
      Size = 39
    end
    object qryCustomersIsJob: TWideStringField
      FieldName = 'IsJob'
      Origin = 'tblclients.IsJob'
      FixedChar = True
      Size = 1
    end
    object qryCustomersPayMethodID: TIntegerField
      FieldName = 'PayMethodID'
      Origin = 'tblclients.PayMethodID'
    end
    object qryCustomersFeedback: TWideStringField
      FieldName = 'Feedback'
      Origin = 'tblclients.Feedback'
      FixedChar = True
      Size = 1
    end
    object qryCustomersCustomer: TWideStringField
      FieldName = 'Customer'
      Origin = 'tblclients.Customer'
      FixedChar = True
      Size = 1
    end
    object qryCustomersSupplier: TWideStringField
      FieldName = 'Supplier'
      Origin = 'tblclients.Supplier'
      FixedChar = True
      Size = 1
    end
    object qryCustomersOtherContact: TWideStringField
      FieldName = 'OtherContact'
      Origin = 'tblclients.OtherContact'
      FixedChar = True
      Size = 1
    end
    object qryCustomersOtherContactType: TIntegerField
      FieldName = 'OtherContactType'
      Origin = 'tblclients.OtherContactType'
    end
    object qryCustomersRepID: TIntegerField
      FieldName = 'RepID'
      Origin = 'tblclients.RepID'
    end
    object qryCustomersGlobal: TWideStringField
      FieldName = 'Global'
      Origin = 'tblclients.Global'
      FixedChar = True
      Size = 1
    end
    object qryCustomersDone: TWideStringField
      FieldName = 'Done'
      Origin = 'tblclients.Done'
      FixedChar = True
      Size = 1
    end
    object qryCustomersActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblclients.Active'
      FixedChar = True
      Size = 1
    end
    object qryCustomersEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblclients.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryCustomersDontContact: TWideStringField
      FieldName = 'DontContact'
      Origin = 'tblclients.DontContact'
      FixedChar = True
      Size = 1
    end
    object qryCustomersParentClientID: TIntegerField
      FieldName = 'ParentClientID'
      Origin = 'tblclients.ParentClientID'
    end
    object qryCustomersGracePeriod: TSmallintField
      FieldName = 'GracePeriod'
      Origin = 'tblclients.GracePeriod'
    end
    object qryCustomersClientNo: TWideStringField
      FieldName = 'ClientNo'
      Origin = 'tblclients.ClientNo'
      Size = 50
    end
    object qryCustomersTAXID: TIntegerField
      FieldName = 'TAXID'
      Origin = 'tblclients.TAXID'
    end
    object qryCustomersTitle: TWideStringField
      FieldName = 'Title'
      Origin = 'tblclients.Title'
      Size = 25
    end
    object qryCustomersClientTypeID: TIntegerField
      FieldName = 'ClientTypeID'
      Origin = 'tblclients.ClientTypeID'
    end
    object qryCustomersURL: TWideStringField
      FieldName = 'URL'
      Origin = 'tblclients.URL'
      Size = 255
    end
    object qryCustomersStopCredit: TWideStringField
      FieldName = 'StopCredit'
      Origin = 'tblclients.StopCredit'
      FixedChar = True
      Size = 1
    end
    object qryCustomersRequired: TWideStringField
      FieldName = 'Required'
      Origin = 'tblclients.Required'
      FixedChar = True
      Size = 1
    end
    object qryCustomersForcePOOnBooking: TWideStringField
      FieldName = 'ForcePOOnBooking'
      Origin = 'tblclients.ForcePOOnBooking'
      FixedChar = True
      Size = 1
    end
    object qryCustomersForcePOOnInvoice: TWideStringField
      FieldName = 'ForcePOOnInvoice'
      Origin = 'tblclients.ForcePOOnInvoice'
      FixedChar = True
      Size = 1
    end
    object qryCustomersPickingPriority: TIntegerField
      FieldName = 'PickingPriority'
      Origin = 'tblclients.PickingPriority'
    end
    object qryCustomersDefaultInvoiceTemplateID: TIntegerField
      FieldName = 'DefaultInvoiceTemplateID'
      Origin = 'tblclients.DefaultInvoiceTemplateID'
    end
    object qryCustomersRepName: TWideStringField
      FieldName = 'RepName'
      Origin = 'tblclients.RepName'
      Size = 255
    end
    object qryCustomersCardNumber: TWideStringField
      FieldName = 'CardNumber'
      Origin = 'tblclients.CardNumber'
      Size = 255
    end
    object qryCustomersGroupDiscountOverridesAll: TWideStringField
      FieldName = 'GroupDiscountOverridesAll'
      Origin = 'tblclients.GroupDiscountOverridesAll'
      FixedChar = True
      Size = 1
    end
    object qryCustomersDefaultClass: TWideStringField
      FieldName = 'DefaultClass'
      Origin = 'tblclients.DefaultClass'
      Size = 255
    end
    object qryCustomersState: TWideStringField
      DisplayWidth = 40
      FieldName = 'State'
      Origin = 'tblclients.State'
      FixedChar = True
      Size = 255
    end
    object qryCustomersStreet: TWideStringField
      FieldName = 'Street'
      Origin = 'tblclients.Street'
      Size = 255
    end
    object qryCustomersStreet2: TWideStringField
      FieldName = 'Street2'
      Origin = 'tblclients.Street2'
      Size = 255
    end
    object qryCustomersSuburb: TWideStringField
      FieldName = 'Suburb'
      Origin = 'tblclients.Suburb'
      Size = 255
    end
    object qryCustomersCountry: TWideStringField
      FieldName = 'Country'
      Origin = 'tblclients.Country'
      Size = 255
    end
    object qryCustomersPostcode: TWideStringField
      FieldName = 'Postcode'
      Origin = 'tblclients.Postcode'
      Size = 255
    end
    object qryCustomersBillStreet: TWideStringField
      FieldName = 'BillStreet'
      Origin = 'tblclients.BillStreet'
      Size = 255
    end
    object qryCustomersBillStreet2: TWideStringField
      FieldName = 'BillStreet2'
      Origin = 'tblclients.BillStreet2'
      Size = 255
    end
    object qryCustomersBillSuburb: TWideStringField
      FieldName = 'BillSuburb'
      Origin = 'tblclients.BillSuburb'
      Size = 255
    end
    object qryCustomersBillState: TWideStringField
      FieldName = 'BillState'
      Origin = 'tblclients.BillState'
      Size = 255
    end
    object qryCustomersBillCountry: TWideStringField
      FieldName = 'BillCountry'
      Origin = 'tblclients.BillCountry'
      Size = 255
    end
    object qryCustomersBillPostcode: TWideStringField
      FieldName = 'BillPostcode'
      Origin = 'tblclients.BillPostcode'
      Size = 255
    end
    object qryCustomersPOBox: TWideStringField
      FieldName = 'POBox'
      Origin = 'tblclients.POBox'
      Size = 255
    end
    object qryCustomersPOSuburb: TWideStringField
      FieldName = 'POSuburb'
      Origin = 'tblclients.POSuburb'
      Size = 255
    end
    object qryCustomersPOState: TWideStringField
      FieldName = 'POState'
      Origin = 'tblclients.POState'
      Size = 255
    end
    object qryCustomersPOCountry: TWideStringField
      FieldName = 'POCountry'
      Origin = 'tblclients.POCountry'
      Size = 255
    end
    object qryCustomersPOPostcode: TWideStringField
      FieldName = 'POPostcode'
      Origin = 'tblclients.POPostcode'
      Size = 255
    end
    object qryCustomersCUSTFLD1: TWideStringField
      FieldName = 'CUSTFLD1'
      Origin = 'tblclients.CUSTFLD1'
      Size = 255
    end
    object qryCustomersCUSTFLD2: TWideStringField
      FieldName = 'CUSTFLD2'
      Origin = 'tblclients.CUSTFLD2'
      Size = 255
    end
    object qryCustomersCUSTFLD3: TWideStringField
      FieldName = 'CUSTFLD3'
      Origin = 'tblclients.CUSTFLD3'
      Size = 255
    end
    object qryCustomersCUSTFLD4: TWideStringField
      FieldName = 'CUSTFLD4'
      Origin = 'tblclients.CUSTFLD4'
      Size = 255
    end
    object qryCustomersCUSTFLD5: TWideStringField
      FieldName = 'CUSTFLD5'
      Origin = 'tblclients.CUSTFLD5'
      Size = 255
    end
    object qryCustomersCUSTFLD6: TWideStringField
      FieldName = 'CUSTFLD6'
      Origin = 'tblclients.CUSTFLD6'
      Size = 255
    end
    object qryCustomersCUSTFLD7: TWideStringField
      FieldName = 'CUSTFLD7'
      Origin = 'tblclients.CUSTFLD7'
      Size = 255
    end
    object qryCustomersCUSTFLD8: TWideStringField
      FieldName = 'CUSTFLD8'
      Origin = 'tblclients.CUSTFLD8'
      Size = 255
    end
    object qryCustomersCUSTFLD9: TWideStringField
      FieldName = 'CUSTFLD9'
      Origin = 'tblclients.CUSTFLD9'
      Size = 255
    end
    object qryCustomersCUSTFLD10: TWideStringField
      FieldName = 'CUSTFLD10'
      Origin = 'tblclients.CUSTFLD10'
      Size = 255
    end
    object qryCustomersCUSTFLD11: TWideStringField
      FieldName = 'CUSTFLD11'
      Origin = 'tblclients.CUSTFLD11'
      Size = 255
    end
    object qryCustomersCUSTFLD12: TWideStringField
      FieldName = 'CUSTFLD12'
      Origin = 'tblclients.CUSTFLD12'
      Size = 255
    end
    object qryCustomersCUSTFLD13: TWideStringField
      FieldName = 'CUSTFLD13'
      Origin = 'tblclients.CUSTFLD13'
      Size = 255
    end
    object qryCustomersCUSTFLD14: TWideStringField
      FieldName = 'CUSTFLD14'
      Origin = 'tblclients.CUSTFLD14'
      Size = 255
    end
    object qryCustomersCUSTFLD15: TWideStringField
      FieldName = 'CUSTFLD15'
      Origin = 'tblclients.CUSTFLD15'
      Size = 255
    end
    object qryCustomersCreationDate: TDateField
      FieldName = 'CreationDate'
      Origin = 'tblclients.CreationDate'
    end
    object qryCustomersDischargeDate: TDateField
      FieldName = 'DischargeDate'
      Origin = 'tblclients.DischargeDate'
    end
    object qryCustomersArea: TSmallintField
      FieldName = 'Area'
      Origin = 'tblclients.Area'
    end
    object qryCustomersJobTitle: TWideStringField
      FieldName = 'JobTitle'
      Origin = 'tblclients.JobTitle'
      Size = 255
    end
    object qryCustomersInvBaseNumber: TIntegerField
      FieldName = 'InvBaseNumber'
      Origin = 'tblclients.InvBaseNumber'
    end
    object qryCustomersUseInvBase: TWideStringField
      FieldName = 'UseInvBase'
      Origin = 'tblclients.UseInvBase'
      FixedChar = True
      Size = 1
    end
    object qryCustomersParentRelatedClientID: TIntegerField
      FieldName = 'ParentRelatedClientID'
      Origin = 'tblclients.ParentRelatedClientID'
    end
    object qryCustomersDeliveryNotes: TWideMemoField
      FieldName = 'DeliveryNotes'
      Origin = 'tblclients.DeliveryNotes'
      BlobType = ftWideMemo
    end
    object qryCustomersDefaultContactMethod: TWideStringField
      FieldName = 'DefaultContactMethod'
      Origin = 'tblclients.DefaultContactMethod'
      Size = 255
    end
    object qryCustomersCreditCardNumber: TWideStringField
      FieldName = 'CreditCardNumber'
      Origin = 'tblclients.CreditCardNumber'
      Size = 255
    end
    object qryCustomersCreditCardExpiryDate: TWideStringField
      FieldName = 'CreditCardExpiryDate'
      Origin = 'tblclients.CreditCardExpiryDate'
      EditMask = '90/00;1; '
      Size = 255
    end
    object qryCustomersCreditCardNotes: TWideStringField
      FieldName = 'CreditCardNotes'
      Origin = 'tblclients.CreditCardNotes'
      Size = 255
    end
    object qryCustomersCreditCardType: TWideStringField
      FieldName = 'CreditCardType'
      Origin = 'tblclients.CreditCardType'
      Size = 255
    end
    object qryCustomersLastUpdated: TDateTimeField
      FieldName = 'LastUpdated'
      Origin = 'tblclients.LastUpdated'
    end
    object qryCustomersBankAccountName: TWideStringField
      FieldName = 'BankAccountName'
      Origin = 'tblclients.BankAccountName'
      Size = 255
    end
    object qryCustomersBankAccountBSB: TWideStringField
      FieldName = 'BankAccountBSB'
      Origin = 'tblclients.BankAccountBSB'
      EditMask = '000-000;1;_'
      Size = 7
    end
    object qryCustomersBankAccountNo: TWideStringField
      FieldName = 'BankAccountNo'
      Origin = 'tblclients.BankAccountNo'
      EditMask = '999999999;0; '
      Size = 10
    end
    object qryCustomersBankCode: TWideStringField
      FieldName = 'BankCode'
      Origin = 'tblclients.BankCode'
      FixedChar = True
      Size = 3
    end
    object qryCustomersForeignExchangeSellCode: TWideStringField
      FieldName = 'ForeignExchangeSellCode'
      Origin = 'tblclients.ForeignExchangeSellCode'
      FixedChar = True
      Size = 3
    end
    object qryCustomersCreditCardCardHolderName: TWideStringField
      FieldName = 'CreditCardCardHolderName'
      Origin = 'tblclients.CreditCardCardHolderName'
      Size = 40
    end
    object qryCustomersForcePOOnCustomer: TWideStringField
      FieldName = 'ForcePOOnCustomer'
      Origin = 'tblclients.ForcePOOnCustomer'
      FixedChar = True
      Size = 1
    end
    object qryCustomersDefaultDeliveryTemplateID: TIntegerField
      FieldName = 'DefaultDeliveryTemplateID'
      Origin = 'tblclients.DefaultDeliveryTemplateID'
    end
    object qryCustomersHours: TFloatField
      FieldName = 'Hours'
      Origin = 'tblclients.hours'
    end
    object qryCustomersEmailXML: TWideStringField
      FieldName = 'EmailXML'
      Origin = 'tblclients.EmailXML'
      Size = 80
    end
    object qryCustomersInvoiceComment: TWideMemoField
      FieldName = 'InvoiceComment'
      Origin = 'tblclients.InvoiceComment'
      BlobType = ftWideMemo
    end
    object qryCustomersInvoiceCommentPopUp: TWideStringField
      FieldName = 'InvoiceCommentPopUp'
      Origin = 'tblclients.InvoiceCommentPopup'
      FixedChar = True
      Size = 1
    end
    object qryCustomersSendXMLInvoices: TWideStringField
      FieldName = 'SendXMLInvoices'
      Origin = 'tblclients.SendXMLInvoices'
      FixedChar = True
      Size = 1
    end
    object qryCustomersStreet3: TWideStringField
      FieldName = 'Street3'
      Origin = 'tblclients.Street3'
      Size = 255
    end
    object qryCustomersBillStreet3: TWideStringField
      FieldName = 'BillStreet3'
      Origin = 'tblclients.BillStreet3'
      Size = 255
    end
    object qryCustomersIncludeOnIntrastat: TWideStringField
      FieldName = 'IncludeOnIntrastat'
      Origin = 'tblclients.IncludeOnIntrastat'
      FixedChar = True
      Size = 1
    end
    object qryCustomersCUSTDATE1: TDateField
      FieldName = 'CUSTDATE1'
      Origin = 'tblclients.CUSTDATE1'
    end
    object qryCustomersCUSTDATE2: TDateField
      FieldName = 'CUSTDATE2'
      Origin = 'tblclients.CUSTDATE2'
    end
    object qryCustomersCUSTDATE3: TDateField
      FieldName = 'CUSTDATE3'
      Origin = 'tblclients.CUSTDATE3'
    end
    object qryCustomersForcePOOnRepair: TWideStringField
      FieldName = 'ForcePOOnRepair'
      Origin = 'tblclients.ForcePOOnRepair'
      FixedChar = True
      Size = 1
    end
    object qryCustomersGlobalref: TWideStringField
      FieldName = 'Globalref'
      Origin = 'tblclients.GlobalRef'
      Size = 255
    end
    object qryCustomersSpecialProductPriceOverridesAll: TWideStringField
      FieldName = 'SpecialProductPriceOverridesAll'
      Origin = 'tblclients.SpecialProductPriceOverridesAll'
      FixedChar = True
      Size = 1
    end
    object qryCustomersPortOfLanding: TWideStringField
      FieldName = 'PortOfLanding'
      Origin = 'tblclients.PortOfLanding'
      Size = 100
    end
    object qryCustomersPortOfDischarge: TWideStringField
      FieldName = 'PortOfDischarge'
      Origin = 'tblclients.PortOfDischarge'
      Size = 100
    end
    object qryCustomersFinalDestination: TWideStringField
      FieldName = 'FinalDestination'
      Origin = 'tblclients.FinalDestination'
      Size = 100
    end
    object qryCustomersIncoPlace: TWideStringField
      FieldName = 'IncoPlace'
      Origin = 'tblclients.IncoPlace'
      Size = 100
    end
    object qryCustomersShippingAgentID: TIntegerField
      FieldName = 'ShippingAgentID'
      Origin = 'tblclients.ShippingAgentID'
    end
    object qryCustomersDefaultStatementTemplateId: TIntegerField
      FieldName = 'DefaultStatementTemplateId'
      Origin = 'tblclients.DefaultStatementTemplateId'
    end
    object qryCustomersCallPriority: TIntegerField
      FieldName = 'CallPriority'
    end
    object qryCustomersTeamviewerID: TWideStringField
      FieldName = 'TeamviewerID'
      Size = 9
    end
    object qryCustomersSkypename: TWideStringField
      FieldName = 'Skypename'
      Size = 100
    end
  end
  object frmCustomerSrc: TDataSource
    DataSet = qryCustomers
    Left = 213
    Top = 185
  end
  object qryCustomersCopy: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'ClientID, Company, ABN, Title, FirstName, MiddleName, LastName,'
      
        'Position, Street, Street2, Street3, Suburb, State, Country, Post' +
        'code, BillStreet,'
      
        'BillStreet2, BillStreet3, BillSuburb, BillState, BillCountry, Bi' +
        'llPostcode, POBox, POSuburb,'
      'POState, POCountry, POPostcode, Phone, FaxNumber, Mobile, Email,'
      
        'AltContact, AltPhone, Contact1, PhoneSupportTill, Contact2, Cont' +
        'act1Phone,'
      
        'Contact2Phone, Notes, ClientNo, ClientTypeID, InvBaseNumber, Use' +
        'InvBase,'
      
        'MedTypeID, TYPE, TAXID, CreditLimit, Balance, TERMS, TermsID, Gr' +
        'acePeriod,'
      
        'ShippingMethod, ShippingID, Discount, SpecialDiscount, JobName,S' +
        'endXMLInvoices,'
      'IsJob, CUSTFLD1, CUSTFLD2, CUSTFLD3, CUSTFLD4, CUSTFLD5,'
      'CUSTFLD6, CUSTFLD7, CUSTFLD8, CUSTFLD9, CUSTFLD10,'
      'CUSTFLD11, CUSTFLD12, CUSTFLD13, CUSTFLD14, CUSTFLD15,'
      'CUSTDATE1, CUSTDATE2, CUSTDATE3,'
      'PayMethodID, Feedback, Customer, Supplier, OtherContact,'
      
        'OtherContactType, RepID, RepName, Global, Done, Active, StopCred' +
        'it,'
      'EditedFlag, DontContact, ParentClientID, URL,EmailXML,'
      
        'Required, ForcePOOnBooking, ForcePOOnInvoice,ForcePOOnCustomer,P' +
        'ickingPriority,'
      
        'DefaultInvoiceTemplateID, DefaultDeliveryTemplateID, CardNumber,' +
        'GroupDiscountOverridesAll,'
      
        'DefaultClass, CreationDate, DischargeDate, Area, JobTitle, Paren' +
        'tRelatedClientID,'
      
        'DeliveryNotes, DefaultContactMethod,CreditCardNumber,CreditCardE' +
        'xpiryDate,'
      
        'CreditCardNotes, CreditCardType, CreditCardCardHolderName, LastU' +
        'pdated,'
      'BankAccountName, BankAccountBSB, BankAccountNo, BankCode,'
      
        'ForeignExchangeSellCode, Hours, InvoiceComment, InvoiceCommentPo' +
        'pUp,'
      
        'IncludeOnIntrastat, ForcePOOnRepair, Globalref, SpecialProductPr' +
        'iceOverridesAll,'
      
        'PortOfLanding ,PortOfDischarge ,FinalDestination ,IncoPlace,Ship' +
        'pingAgentID  , DefaultStatementTemplateId,CallPriority, Teamview' +
        'erID , Skypename'
      'FROM tblclients'
      'WHERE Customer='#39'T'#39' AND ClientID = :CusID;')
    Left = 512
    Top = 153
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CusID'
      end>
    object WideStringField112: TWideStringField
      FieldName = 'Phone'
      Origin = 'tblclients.Phone'
      EditMask = '## #### ####;0;_'
    end
    object WideStringField113: TWideStringField
      FieldName = 'FaxNumber'
      Origin = 'tblclients.FaxNumber'
      EditMask = '## #### ####;0;_'
    end
    object WideStringField114: TWideStringField
      FieldName = 'Mobile'
      Origin = 'tblclients.Mobile'
      EditMask = '#### ### ###;0;_'
    end
    object WideStringField115: TWideStringField
      FieldName = 'AltPhone'
      Origin = 'tblclients.AltPhone'
      EditMask = '## #### ####;0;_'
    end
    object WideStringField116: TWideStringField
      FieldName = 'Contact1Phone'
      Origin = 'tblclients.Contact1Phone'
      EditMask = '## #### ####;0;_'
    end
    object WideStringField117: TWideStringField
      FieldName = 'Contact2Phone'
      Origin = 'tblclients.Contact2Phone'
      EditMask = '## #### ####;0;_'
    end
    object AutoIncField1: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientID'
      Origin = 'tblclients.ClientID'
      ReadOnly = True
    end
    object WideStringField118: TWideStringField
      FieldName = 'Company'
      Origin = 'tblclients.Company'
      Size = 80
    end
    object WideStringField119: TWideStringField
      FieldName = 'ABN'
      Origin = 'tblclients.ABN'
      EditMask = '## ### ### ###;0;_'
      Size = 15
    end
    object WideStringField120: TWideStringField
      FieldName = 'FirstName'
      Origin = 'tblclients.FirstName'
      Size = 40
    end
    object WideStringField121: TWideStringField
      FieldName = 'MiddleName'
      Origin = 'tblclients.MiddleName'
      Size = 40
    end
    object WideStringField122: TWideStringField
      FieldName = 'LastName'
      Origin = 'tblclients.LastName'
      Size = 40
    end
    object WideStringField123: TWideStringField
      FieldName = 'Position'
      Origin = 'tblclients.Position'
      Size = 30
    end
    object WideStringField124: TWideStringField
      FieldName = 'Email'
      Origin = 'tblclients.Email'
      Size = 80
    end
    object WideStringField125: TWideStringField
      FieldName = 'AltContact'
      Origin = 'tblclients.AltContact'
      Size = 50
    end
    object WideStringField126: TWideStringField
      FieldName = 'Contact1'
      Origin = 'tblclients.Contact1'
      Size = 50
    end
    object DateField1: TDateField
      FieldName = 'PhoneSupportTill'
      Origin = 'tblclients.PhoneSupportTill'
    end
    object WideStringField127: TWideStringField
      FieldName = 'Contact2'
      Origin = 'tblclients.Contact2'
      Size = 50
    end
    object WideMemoField1: TWideMemoField
      FieldName = 'Notes'
      Origin = 'tblclients.Notes'
      BlobType = ftWideMemo
    end
    object IntegerField13: TIntegerField
      FieldName = 'MedTypeID'
      Origin = 'tblclients.MedTypeID'
    end
    object WideStringField128: TWideStringField
      FieldName = 'TYPE'
      Origin = 'tblclients.TYPE'
      Size = 50
    end
    object FloatField1: TFloatField
      FieldName = 'CreditLimit'
      Origin = 'tblclients.CreditLimit'
    end
    object FloatField2: TFloatField
      FieldName = 'Balance'
      Origin = 'tblclients.Balance'
      currency = True
    end
    object WideStringField129: TWideStringField
      FieldName = 'TERMS'
      Origin = 'tblclients.TERMS'
      Size = 30
    end
    object IntegerField14: TIntegerField
      FieldName = 'TermsID'
      Origin = 'tblclients.TermsID'
    end
    object WideStringField130: TWideStringField
      FieldName = 'ShippingMethod'
      Origin = 'tblclients.ShippingMethod'
      Size = 30
    end
    object IntegerField15: TIntegerField
      FieldName = 'ShippingID'
      Origin = 'tblclients.ShippingID'
    end
    object FloatField3: TFloatField
      FieldName = 'Discount'
      Origin = 'tblclients.Discount'
      DisplayFormat = '#.#%'
    end
    object FloatField4: TFloatField
      FieldName = 'SpecialDiscount'
      Origin = 'tblclients.SpecialDiscount'
    end
    object WideStringField131: TWideStringField
      FieldName = 'JobName'
      Origin = 'tblclients.JobName'
      Size = 39
    end
    object WideStringField132: TWideStringField
      FieldName = 'IsJob'
      Origin = 'tblclients.IsJob'
      FixedChar = True
      Size = 1
    end
    object IntegerField16: TIntegerField
      FieldName = 'PayMethodID'
      Origin = 'tblclients.PayMethodID'
    end
    object WideStringField133: TWideStringField
      FieldName = 'Feedback'
      Origin = 'tblclients.Feedback'
      FixedChar = True
      Size = 1
    end
    object WideStringField134: TWideStringField
      FieldName = 'Customer'
      Origin = 'tblclients.Customer'
      FixedChar = True
      Size = 1
    end
    object WideStringField135: TWideStringField
      FieldName = 'Supplier'
      Origin = 'tblclients.Supplier'
      FixedChar = True
      Size = 1
    end
    object WideStringField136: TWideStringField
      FieldName = 'OtherContact'
      Origin = 'tblclients.OtherContact'
      FixedChar = True
      Size = 1
    end
    object IntegerField17: TIntegerField
      FieldName = 'OtherContactType'
      Origin = 'tblclients.OtherContactType'
    end
    object IntegerField18: TIntegerField
      FieldName = 'RepID'
      Origin = 'tblclients.RepID'
    end
    object WideStringField137: TWideStringField
      FieldName = 'Global'
      Origin = 'tblclients.Global'
      FixedChar = True
      Size = 1
    end
    object WideStringField138: TWideStringField
      FieldName = 'Done'
      Origin = 'tblclients.Done'
      FixedChar = True
      Size = 1
    end
    object WideStringField139: TWideStringField
      FieldName = 'Active'
      Origin = 'tblclients.Active'
      FixedChar = True
      Size = 1
    end
    object WideStringField140: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblclients.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object WideStringField141: TWideStringField
      FieldName = 'DontContact'
      Origin = 'tblclients.DontContact'
      FixedChar = True
      Size = 1
    end
    object IntegerField19: TIntegerField
      FieldName = 'ParentClientID'
      Origin = 'tblclients.ParentClientID'
    end
    object SmallintField1: TSmallintField
      FieldName = 'GracePeriod'
      Origin = 'tblclients.GracePeriod'
    end
    object WideStringField142: TWideStringField
      FieldName = 'ClientNo'
      Origin = 'tblclients.ClientNo'
      Size = 50
    end
    object IntegerField20: TIntegerField
      FieldName = 'TAXID'
      Origin = 'tblclients.TAXID'
    end
    object WideStringField144: TWideStringField
      FieldName = 'Title'
      Origin = 'tblclients.Title'
      Size = 25
    end
    object IntegerField21: TIntegerField
      FieldName = 'ClientTypeID'
      Origin = 'tblclients.ClientTypeID'
    end
    object WideStringField145: TWideStringField
      FieldName = 'URL'
      Origin = 'tblclients.URL'
      Size = 255
    end
    object WideStringField146: TWideStringField
      FieldName = 'StopCredit'
      Origin = 'tblclients.StopCredit'
      FixedChar = True
      Size = 1
    end
    object WideStringField147: TWideStringField
      FieldName = 'Required'
      Origin = 'tblclients.Required'
      FixedChar = True
      Size = 1
    end
    object WideStringField148: TWideStringField
      FieldName = 'ForcePOOnBooking'
      Origin = 'tblclients.ForcePOOnBooking'
      FixedChar = True
      Size = 1
    end
    object WideStringField149: TWideStringField
      FieldName = 'ForcePOOnInvoice'
      Origin = 'tblclients.ForcePOOnInvoice'
      FixedChar = True
      Size = 1
    end
    object IntegerField22: TIntegerField
      FieldName = 'PickingPriority'
      Origin = 'tblclients.PickingPriority'
    end
    object IntegerField23: TIntegerField
      FieldName = 'DefaultInvoiceTemplateID'
      Origin = 'tblclients.DefaultInvoiceTemplateID'
    end
    object WideStringField150: TWideStringField
      FieldName = 'RepName'
      Origin = 'tblclients.RepName'
      Size = 255
    end
    object WideStringField151: TWideStringField
      FieldName = 'CardNumber'
      Origin = 'tblclients.CardNumber'
      Size = 255
    end
    object WideStringField152: TWideStringField
      FieldName = 'GroupDiscountOverridesAll'
      Origin = 'tblclients.GroupDiscountOverridesAll'
      FixedChar = True
      Size = 1
    end
    object WideStringField153: TWideStringField
      FieldName = 'DefaultClass'
      Origin = 'tblclients.DefaultClass'
      Size = 255
    end
    object WideStringField154: TWideStringField
      DisplayWidth = 40
      FieldName = 'State'
      Origin = 'tblclients.State'
      FixedChar = True
      Size = 255
    end
    object WideStringField155: TWideStringField
      FieldName = 'Street'
      Origin = 'tblclients.Street'
      Size = 255
    end
    object WideStringField156: TWideStringField
      FieldName = 'Street2'
      Origin = 'tblclients.Street2'
      Size = 255
    end
    object WideStringField157: TWideStringField
      FieldName = 'Suburb'
      Origin = 'tblclients.Suburb'
      Size = 255
    end
    object WideStringField158: TWideStringField
      FieldName = 'Country'
      Origin = 'tblclients.Country'
      Size = 255
    end
    object WideStringField159: TWideStringField
      FieldName = 'Postcode'
      Origin = 'tblclients.Postcode'
      Size = 255
    end
    object WideStringField160: TWideStringField
      FieldName = 'BillStreet'
      Origin = 'tblclients.BillStreet'
      Size = 255
    end
    object WideStringField161: TWideStringField
      FieldName = 'BillStreet2'
      Origin = 'tblclients.BillStreet2'
      Size = 255
    end
    object WideStringField162: TWideStringField
      FieldName = 'BillSuburb'
      Origin = 'tblclients.BillSuburb'
      Size = 255
    end
    object WideStringField163: TWideStringField
      FieldName = 'BillState'
      Origin = 'tblclients.BillState'
      Size = 255
    end
    object WideStringField164: TWideStringField
      FieldName = 'BillCountry'
      Origin = 'tblclients.BillCountry'
      Size = 255
    end
    object WideStringField165: TWideStringField
      FieldName = 'BillPostcode'
      Origin = 'tblclients.BillPostcode'
      Size = 255
    end
    object WideStringField166: TWideStringField
      FieldName = 'POBox'
      Origin = 'tblclients.POBox'
      Size = 255
    end
    object WideStringField167: TWideStringField
      FieldName = 'POSuburb'
      Origin = 'tblclients.POSuburb'
      Size = 255
    end
    object WideStringField168: TWideStringField
      FieldName = 'POState'
      Origin = 'tblclients.POState'
      Size = 255
    end
    object WideStringField169: TWideStringField
      FieldName = 'POCountry'
      Origin = 'tblclients.POCountry'
      Size = 255
    end
    object WideStringField170: TWideStringField
      FieldName = 'POPostcode'
      Origin = 'tblclients.POPostcode'
      Size = 255
    end
    object WideStringField171: TWideStringField
      FieldName = 'CUSTFLD1'
      Origin = 'tblclients.CUSTFLD1'
      Size = 255
    end
    object WideStringField172: TWideStringField
      FieldName = 'CUSTFLD2'
      Origin = 'tblclients.CUSTFLD2'
      Size = 255
    end
    object WideStringField173: TWideStringField
      FieldName = 'CUSTFLD3'
      Origin = 'tblclients.CUSTFLD3'
      Size = 255
    end
    object WideStringField174: TWideStringField
      FieldName = 'CUSTFLD4'
      Origin = 'tblclients.CUSTFLD4'
      Size = 255
    end
    object WideStringField175: TWideStringField
      FieldName = 'CUSTFLD5'
      Origin = 'tblclients.CUSTFLD5'
      Size = 255
    end
    object WideStringField176: TWideStringField
      FieldName = 'CUSTFLD6'
      Origin = 'tblclients.CUSTFLD6'
      Size = 255
    end
    object WideStringField177: TWideStringField
      FieldName = 'CUSTFLD7'
      Origin = 'tblclients.CUSTFLD7'
      Size = 255
    end
    object WideStringField178: TWideStringField
      FieldName = 'CUSTFLD8'
      Origin = 'tblclients.CUSTFLD8'
      Size = 255
    end
    object WideStringField179: TWideStringField
      FieldName = 'CUSTFLD9'
      Origin = 'tblclients.CUSTFLD9'
      Size = 255
    end
    object WideStringField180: TWideStringField
      FieldName = 'CUSTFLD10'
      Origin = 'tblclients.CUSTFLD10'
      Size = 255
    end
    object WideStringField181: TWideStringField
      FieldName = 'CUSTFLD11'
      Origin = 'tblclients.CUSTFLD11'
      Size = 255
    end
    object WideStringField182: TWideStringField
      FieldName = 'CUSTFLD12'
      Origin = 'tblclients.CUSTFLD12'
      Size = 255
    end
    object WideStringField183: TWideStringField
      FieldName = 'CUSTFLD13'
      Origin = 'tblclients.CUSTFLD13'
      Size = 255
    end
    object WideStringField184: TWideStringField
      FieldName = 'CUSTFLD14'
      Origin = 'tblclients.CUSTFLD14'
      Size = 255
    end
    object WideStringField185: TWideStringField
      FieldName = 'CUSTFLD15'
      Origin = 'tblclients.CUSTFLD15'
      Size = 255
    end
    object DateField2: TDateField
      FieldName = 'CreationDate'
      Origin = 'tblclients.CreationDate'
    end
    object DateField3: TDateField
      FieldName = 'DischargeDate'
      Origin = 'tblclients.DischargeDate'
    end
    object SmallintField2: TSmallintField
      FieldName = 'Area'
      Origin = 'tblclients.Area'
    end
    object WideStringField186: TWideStringField
      FieldName = 'JobTitle'
      Origin = 'tblclients.JobTitle'
      Size = 255
    end
    object IntegerField24: TIntegerField
      FieldName = 'InvBaseNumber'
      Origin = 'tblclients.InvBaseNumber'
    end
    object WideStringField187: TWideStringField
      FieldName = 'UseInvBase'
      Origin = 'tblclients.UseInvBase'
      FixedChar = True
      Size = 1
    end
    object IntegerField25: TIntegerField
      FieldName = 'ParentRelatedClientID'
      Origin = 'tblclients.ParentRelatedClientID'
    end
    object WideMemoField2: TWideMemoField
      FieldName = 'DeliveryNotes'
      Origin = 'tblclients.DeliveryNotes'
      BlobType = ftWideMemo
    end
    object WideStringField188: TWideStringField
      FieldName = 'DefaultContactMethod'
      Origin = 'tblclients.DefaultContactMethod'
      Size = 255
    end
    object WideStringField189: TWideStringField
      FieldName = 'CreditCardNumber'
      Origin = 'tblclients.CreditCardNumber'
      Size = 255
    end
    object WideStringField190: TWideStringField
      FieldName = 'CreditCardExpiryDate'
      Origin = 'tblclients.CreditCardExpiryDate'
      EditMask = '90/00;1; '
      Size = 255
    end
    object WideStringField191: TWideStringField
      FieldName = 'CreditCardNotes'
      Origin = 'tblclients.CreditCardNotes'
      Size = 255
    end
    object WideStringField192: TWideStringField
      FieldName = 'CreditCardType'
      Origin = 'tblclients.CreditCardType'
      Size = 255
    end
    object DateTimeField4: TDateTimeField
      FieldName = 'LastUpdated'
      Origin = 'tblclients.LastUpdated'
    end
    object WideStringField193: TWideStringField
      FieldName = 'BankAccountName'
      Origin = 'tblclients.BankAccountName'
      Size = 255
    end
    object WideStringField194: TWideStringField
      FieldName = 'BankAccountBSB'
      Origin = 'tblclients.BankAccountBSB'
      EditMask = '000-000;1;_'
      Size = 7
    end
    object WideStringField195: TWideStringField
      FieldName = 'BankAccountNo'
      Origin = 'tblclients.BankAccountNo'
      EditMask = '999999999;0; '
      Size = 10
    end
    object WideStringField196: TWideStringField
      FieldName = 'BankCode'
      Origin = 'tblclients.BankCode'
      FixedChar = True
      Size = 3
    end
    object WideStringField197: TWideStringField
      FieldName = 'ForeignExchangeSellCode'
      Origin = 'tblclients.ForeignExchangeSellCode'
      FixedChar = True
      Size = 3
    end
    object WideStringField198: TWideStringField
      FieldName = 'CreditCardCardHolderName'
      Origin = 'tblclients.CreditCardCardHolderName'
      Size = 40
    end
    object WideStringField199: TWideStringField
      FieldName = 'ForcePOOnCustomer'
      Origin = 'tblclients.ForcePOOnCustomer'
      FixedChar = True
      Size = 1
    end
    object IntegerField26: TIntegerField
      FieldName = 'DefaultDeliveryTemplateID'
      Origin = 'tblclients.DefaultDeliveryTemplateID'
    end
    object FloatField5: TFloatField
      FieldName = 'Hours'
      Origin = 'tblclients.hours'
    end
    object WideStringField200: TWideStringField
      FieldName = 'EmailXML'
      Origin = 'tblclients.EmailXML'
      Size = 80
    end
    object WideMemoField3: TWideMemoField
      FieldName = 'InvoiceComment'
      Origin = 'tblclients.InvoiceComment'
      BlobType = ftWideMemo
    end
    object WideStringField201: TWideStringField
      FieldName = 'InvoiceCommentPopUp'
      Origin = 'tblclients.InvoiceCommentPopup'
      FixedChar = True
      Size = 1
    end
    object WideStringField202: TWideStringField
      FieldName = 'SendXMLInvoices'
      Origin = 'tblclients.SendXMLInvoices'
      FixedChar = True
      Size = 1
    end
    object WideStringField203: TWideStringField
      FieldName = 'Street3'
      Origin = 'tblclients.Street3'
      Size = 255
    end
    object WideStringField204: TWideStringField
      FieldName = 'BillStreet3'
      Origin = 'tblclients.BillStreet3'
      Size = 255
    end
    object WideStringField205: TWideStringField
      FieldName = 'IncludeOnIntrastat'
      Origin = 'tblclients.IncludeOnIntrastat'
      FixedChar = True
      Size = 1
    end
    object DateField4: TDateField
      FieldName = 'CUSTDATE1'
      Origin = 'tblclients.CUSTDATE1'
    end
    object DateField5: TDateField
      FieldName = 'CUSTDATE2'
      Origin = 'tblclients.CUSTDATE2'
    end
    object DateField6: TDateField
      FieldName = 'CUSTDATE3'
      Origin = 'tblclients.CUSTDATE3'
    end
    object WideStringField206: TWideStringField
      FieldName = 'ForcePOOnRepair'
      Origin = 'tblclients.ForcePOOnRepair'
      FixedChar = True
      Size = 1
    end
    object WideStringField207: TWideStringField
      FieldName = 'Globalref'
      Origin = 'tblclients.GlobalRef'
      Size = 255
    end
    object WideStringField208: TWideStringField
      FieldName = 'SpecialProductPriceOverridesAll'
      Origin = 'tblclients.SpecialProductPriceOverridesAll'
      FixedChar = True
      Size = 1
    end
    object WideStringField209: TWideStringField
      FieldName = 'PortOfLanding'
      Origin = 'tblclients.PortOfLanding'
      Size = 100
    end
    object WideStringField210: TWideStringField
      FieldName = 'PortOfDischarge'
      Origin = 'tblclients.PortOfDischarge'
      Size = 100
    end
    object WideStringField211: TWideStringField
      FieldName = 'FinalDestination'
      Origin = 'tblclients.FinalDestination'
      Size = 100
    end
    object WideStringField212: TWideStringField
      FieldName = 'IncoPlace'
      Origin = 'tblclients.IncoPlace'
      Size = 100
    end
    object IntegerField27: TIntegerField
      FieldName = 'ShippingAgentID'
      Origin = 'tblclients.ShippingAgentID'
    end
    object IntegerField29: TIntegerField
      FieldName = 'DefaultStatementTemplateId'
      Origin = 'tblclients.DefaultStatementTemplateId'
    end
    object IntegerField30: TIntegerField
      FieldName = 'CallPriority'
    end
    object WideStringField217: TWideStringField
      FieldName = 'TeamviewerID'
      Size = 9
    end
    object WideStringField218: TWideStringField
      FieldName = 'Skypename'
      Size = 100
    end
  end
  object frmCustomerSrcCopy: TDataSource
    DataSet = qryCustomersCopy
    Left = 501
    Top = 185
  end
  object ERPQuery1: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblContacts'
      'WHERE ContactID=:KeyID;')
    Left = 461
    Top = 13
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
  end
  object DataSource1: TDataSource
    DataSet = ERPQuery1
    Left = 494
    Top = 14
  end
  object ERPQuery2: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      
        'GlobalRef, ContactID, CusID, SupID, EmployeeID, Company, Contact' +
        'Title,'
      'ContactFirstName, ContactSurName, ContactAddress,'
      
        'ContactCity, ContactState, ContactPcode, ContactPH, ContactAltPH' +
        ','
      
        'ContactMOB, ContactFax, ContactEmail, Notes, EditedFlag, Contact' +
        'Address2,'
      
        'Active, CardNumber, AccountNo, JobTitle, ContactIsCustomer, UseO' +
        'nRun,'
      'Company AS ContactName, isPrimarycontact,'
      
        'contactIsOthercontact,contactISCustomer,contactIsJob,contactIsSu' +
        'pplier,ContactCountry'
      'FROM tblContacts'
      'WHERE ifnull(CusID,0) = :CusID and ifnull(CusID,0) <> 0')
    Left = 785
    Top = 1
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CusID'
      end>
    object WideStringField143: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object AutoIncField2: TAutoIncField
      FieldName = 'ContactID'
      ReadOnly = True
    end
    object IntegerField28: TIntegerField
      FieldName = 'CusID'
    end
    object IntegerField31: TIntegerField
      FieldName = 'SupID'
    end
    object IntegerField32: TIntegerField
      FieldName = 'EmployeeID'
    end
    object WideStringField213: TWideStringField
      FieldName = 'Company'
      Size = 50
    end
    object WideStringField214: TWideStringField
      FieldName = 'ContactTitle'
      Size = 10
    end
    object WideStringField215: TWideStringField
      FieldName = 'ContactFirstName'
      Size = 30
    end
    object WideStringField216: TWideStringField
      FieldName = 'ContactSurName'
      Size = 30
    end
    object WideStringField219: TWideStringField
      FieldName = 'ContactAddress'
      Size = 100
    end
    object WideStringField220: TWideStringField
      FieldName = 'ContactCity'
      Size = 30
    end
    object WideStringField221: TWideStringField
      FieldName = 'ContactState'
      Size = 5
    end
    object WideStringField222: TWideStringField
      FieldName = 'ContactPcode'
      Size = 255
    end
    object WideStringField223: TWideStringField
      FieldName = 'ContactPH'
    end
    object WideStringField224: TWideStringField
      FieldName = 'ContactAltPH'
    end
    object WideStringField225: TWideStringField
      FieldName = 'ContactMOB'
    end
    object WideStringField226: TWideStringField
      FieldName = 'ContactFax'
    end
    object WideStringField227: TWideStringField
      FieldName = 'ContactEmail'
      Size = 80
    end
    object WideStringField228: TWideStringField
      FieldName = 'Notes'
      Size = 255
    end
    object WideStringField229: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object WideStringField230: TWideStringField
      FieldName = 'ContactAddress2'
      Size = 40
    end
    object WideStringField231: TWideStringField
      FieldName = 'CardNumber'
      Size = 255
    end
    object WideStringField232: TWideStringField
      FieldName = 'AccountNo'
      EditMask = '999999999999999999999999999999;0; '
      Size = 255
    end
    object WideStringField233: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryContactsContactName: TWideStringField
      FieldName = 'ContactName'
      ReadOnly = True
      Size = 61
    end
    object WideStringField234: TWideStringField
      FieldName = 'JobTitle'
      Size = 255
    end
    object WideStringField235: TWideStringField
      FieldName = 'ContactIsCustomer'
      FixedChar = True
      Size = 1
    end
    object WideStringField236: TWideStringField
      FieldName = 'isPrimarycontact'
      FixedChar = True
      Size = 1
    end
    object WideStringField237: TWideStringField
      FieldName = 'UseOnRun'
      FixedChar = True
      Size = 1
    end
    object WideStringField238: TWideStringField
      FieldName = 'contactIsOthercontact'
      FixedChar = True
      Size = 1
    end
    object qryContactscontactISCustomer_1: TWideStringField
      FieldName = 'contactISCustomer_1'
      FixedChar = True
      Size = 1
    end
    object WideStringField239: TWideStringField
      FieldName = 'contactIsJob'
      FixedChar = True
      Size = 1
    end
    object WideStringField240: TWideStringField
      FieldName = 'contactIsSupplier'
      FixedChar = True
      Size = 1
    end
    object WideStringField241: TWideStringField
      FieldName = 'ContactCountry'
      Size = 255
    end
  end
  object DSContacts: TDataSource
    DataSet = ERPQuery2
    Left = 776
    Top = 33
  end
end
