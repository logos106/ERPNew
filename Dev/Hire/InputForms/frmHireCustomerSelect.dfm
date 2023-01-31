inherited fmHireCustomerSelect: TfmHireCustomerSelect
  HelpContext = 1406002
  BorderStyle = bsDialog
  Caption = 'Hire Customer'
  ClientHeight = 204
  ClientWidth = 452
  Position = poScreenCenter
  ExplicitWidth = 468
  ExplicitHeight = 243
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 204
    Width = 452
    HelpContext = 1406003
    ExplicitTop = 219
    ExplicitWidth = 442
  end
  object Label38: TLabel [3]
    Left = 73
    Top = 92
    Width = 56
    Height = 15
    HelpContext = 1406004
    Caption = 'Customer'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object btnSave: TDNMSpeedButton [5]
    Left = 125
    Top = 170
    Width = 87
    Height = 27
    HelpContext = 1406008
    Anchors = [akBottom]
    Caption = 'Save'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
    OnClick = btnSaveClick
  end
  object btnCancel: TDNMSpeedButton [6]
    Left = 240
    Top = 170
    Width = 87
    Height = 27
    HelpContext = 1406009
    Anchors = [akBottom]
    Caption = 'Cancel'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
  end
  object cboClientR: TERPDbLookupCombo [7]
    Left = 148
    Top = 89
    Width = 232
    Height = 23
    HelpContext = 1406010
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'Company'#9'45'#9'Company'#9'F')
    DataField = 'ClientName'
    DataSource = dtClient
    LookupTable = qryClientLookup
    LookupField = 'Company'
    ParentFont = False
    TabOrder = 3
    AutoDropDown = True
    ShowButton = True
    UseTFields = False
    PreciseEditRegion = False
    AllowClearKey = False
    LookupFormClassName = 'TCustomerExpressListGUI'
    EditFormClassName = 'TfrmCustomer'
    LookupFormKeyStringFieldName = 'Company'
    LookupComboType = ctCustomer
    AllowFullListSearchMode = False
    DisableNotInList = False
    AllowMultipleSelectFromList = False
    OpenListinF6WhenNotinList = False
    DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
    LookupIDField = 'ClientID'
  end
  object pnlTitle: TDNMPanel [8]
    Left = 59
    Top = 7
    Width = 334
    Height = 41
    HelpContext = 1406005
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 330
      Height = 37
      HelpContext = 1406006
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      FromColor = clBtnFace
      ToColor = clWhite
      FromColorMirror = clWhite
      ToColorMirror = clBtnFace
      Steps = 10
      Direction = False
      Version = '1.4.0.0'
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 330
        Height = 37
        HelpContext = 1406007
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Hire Customer'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 326
      end
    end
  end
  object qryClientLookup: TERPQuery
    SQL.Strings = (
      'SELECT'
      'CT.DefaultPostAccount AS DefaultPostAccount,'
      'CT.DefaultPostAccountID AS DefaultPostAccountID,'
      'C1.ClientID as ClientID,'
      'C1.Company as Company,'
      'C1.Street as Street,'
      'C1.Street2 as Street2,'
      'C1.Street3 as Street3,'
      'C1.Suburb as Suburb,'
      'C1.State as State,'
      'C1.Country as Country,'
      'C1.Postcode as Postcode,'
      'C1.BillStreet as BillStreet,'
      'C1.BillStreet2 as BillStreet2,'
      'C1.BillStreet3 as BillStreet3,'
      'C1.BillSuburb as BillSuburb,'
      'C1.BillState as BillState,'
      'C1.BillPostcode as BillPostcode,'
      'C1.BillCountry as BillCountry,'
      'C1.TERMS as TERMS,'
      'C1.TermsID as TermsID,'
      'C1.ShippingMethod as ShippingMethod,'
      'C1.ShippingID as ShippingID,'
      'C1.RepID as RepID,'
      'C1.TaxID as TaxID,'
      'C1.Phone as Phone,'
      'C1.FaxNumber as Fax,'
      'C1.AltPhone as AltPhone,'
      'IF(C1.IsJob = '#39'T'#39',C2.StopCredit,C1.StopCredit) AS StopCredits,'
      'C1.ForcePOOnInvoice as ForcePOOnInvoice,'
      'C1.UseInvBase as UseInvBase,'
      'C1.InvBaseNumber as InvBaseNumber, '
      'C1.WarrantyFinishDate, C1.IsJob'
      'FROM tblclients as C1'
      
        'LEFT JOIN tblClientType AS CT on C1.ClientTypeID = CT.ClientType' +
        'ID '
      'LEFT JOIN tblClients as C2 on C1.ParentClientID = C2.ClientID'
      'WHERE C1.Customer='#39'T'#39' AND char_length(C1.Company)>0'
      'AND C1.Active = '#39'T'#39' '
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (C1.Company LIKE Concat(:SearchValue,"' +
        '%")))'
      
        'or ((:SearchMode = 2) and (C1.Company LIKE Concat("%",:SearchVal' +
        'ue,"%"))))'
      'and IfNull(:SearchValue,"") <> ""')
    Left = 312
    Top = 93
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
    object qryClientLookupCompany: TWideStringField
      DisplayWidth = 35
      FieldName = 'Company'
      Size = 80
    end
    object qryClientLookupClientId: TIntegerField
      FieldName = 'ClientId'
      Visible = False
    end
    object qryClientLookupDefaultPostAccount: TWideStringField
      FieldName = 'DefaultPostAccount'
      Visible = False
      Size = 255
    end
    object qryClientLookupDefaultPostAccountID: TIntegerField
      FieldName = 'DefaultPostAccountID'
      Visible = False
    end
    object qryClientLookupStreet: TWideStringField
      FieldName = 'Street'
      Visible = False
      Size = 255
    end
    object qryClientLookupStreet2: TWideStringField
      FieldName = 'Street2'
      Visible = False
      Size = 255
    end
    object qryClientLookupStreet3: TWideStringField
      FieldName = 'Street3'
      Visible = False
      Size = 255
    end
    object qryClientLookupSuburb: TWideStringField
      FieldName = 'Suburb'
      Visible = False
      Size = 255
    end
    object qryClientLookupState: TWideStringField
      FieldName = 'State'
      Visible = False
      Size = 255
    end
    object qryClientLookupCountry: TWideStringField
      FieldName = 'Country'
      Visible = False
      Size = 255
    end
    object qryClientLookupPostcode: TWideStringField
      FieldName = 'Postcode'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillStreet: TWideStringField
      FieldName = 'BillStreet'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillStreet2: TWideStringField
      FieldName = 'BillStreet2'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillStreet3: TWideStringField
      FieldName = 'BillStreet3'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillSuburb: TWideStringField
      FieldName = 'BillSuburb'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillState: TWideStringField
      FieldName = 'BillState'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillPostcode: TWideStringField
      FieldName = 'BillPostcode'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillCountry: TWideStringField
      FieldName = 'BillCountry'
      Visible = False
      Size = 255
    end
    object qryClientLookupTERMS: TWideStringField
      FieldName = 'TERMS'
      Visible = False
      Size = 30
    end
    object qryClientLookupTermsID: TIntegerField
      FieldName = 'TermsID'
      Visible = False
    end
    object qryClientLookupShippingMethod: TWideStringField
      FieldName = 'ShippingMethod'
      Visible = False
      Size = 30
    end
    object qryClientLookupShippingID: TIntegerField
      FieldName = 'ShippingID'
      Visible = False
    end
    object qryClientLookupRepID: TIntegerField
      FieldName = 'RepID'
      Visible = False
    end
    object qryClientLookupTaxID: TIntegerField
      FieldName = 'TaxID'
      Visible = False
    end
    object qryClientLookupPhone: TWideStringField
      FieldName = 'Phone'
      Visible = False
    end
    object qryClientLookupFax: TWideStringField
      FieldName = 'Fax'
      Visible = False
    end
    object qryClientLookupAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Visible = False
    end
    object qryClientLookupStopCredits: TWideStringField
      FieldName = 'StopCredits'
      Visible = False
      Size = 1
    end
    object qryClientLookupForcePOOnInvoice: TWideStringField
      FieldName = 'ForcePOOnInvoice'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryClientLookupUseInvBase: TWideStringField
      FieldName = 'UseInvBase'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryClientLookupInvBaseNumber: TIntegerField
      FieldName = 'InvBaseNumber'
      Visible = False
    end
    object qryClientLookupWarrantyFinishDate: TDateTimeField
      FieldName = 'WarrantyFinishDate'
      Visible = False
    end
    object qryClientLookupIsJob: TWideStringField
      FieldName = 'IsJob'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object mtClient: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '6.51.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 400
    Top = 48
  end
  object dtClient: TDataSource
    DataSet = mtClient
    Left = 408
    Top = 112
  end
end
