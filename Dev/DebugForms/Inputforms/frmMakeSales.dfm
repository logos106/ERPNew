inherited fmMakeSales: TfmMakeSales
  Left = 589
  Top = 177
  HelpContext = 1035002
  Caption = 'fmMakeSales'
  ExplicitLeft = 589
  ExplicitTop = 177
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel [4]
    Left = 9
    Top = 41
    Width = 215
    Height = 18
    HelpContext = 1035003
    AutoSize = False
    Caption = 'Customer Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label2: TLabel [5]
    Left = 368
    Top = 41
    Width = 215
    Height = 18
    HelpContext = 1035004
    AutoSize = False
    Caption = 'Product'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object wwDBGrid1: TwwDBGrid [6]
    Left = 9
    Top = 72
    Width = 320
    Height = 333
    HelpContext = 1035005
    Selected.Strings = (
      'Company'#9'35'#9'Company')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsClientLookup
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
  end
  object grdproducts: TwwDBGrid [7]
    Left = 368
    Top = 72
    Width = 409
    Height = 333
    HelpContext = 1035006
    Selected.Strings = (
      'PARTNAME'#9'15'#9'Product Name'
      'PartsDescription'#9'30'#9'Description')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsProductQry
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
    TabOrder = 1
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
  end
  object btnMakeSales: TButton [8]
    Left = 824
    Top = 184
    Width = 75
    Height = 25
    HelpContext = 1035007
    Caption = 'Make Sales'
    TabOrder = 2
    OnClick = btnMakeSalesClick
  end
  inherited MyConnection: TERPConnection

    Server = 'localhost'
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102007400740010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  object qryClientLookup: TERPQuery
    Connection = MyConnection
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
      'AND C1.Active = '#39'T'#39)
    Left = 88
    Top = 101
    object qryClientLookupCompany: TWideStringField
      DisplayWidth = 35
      FieldName = 'Company'
      Origin = 'C1.Company'
      Size = 80
    end
    object qryClientLookupClientId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientId'
      Origin = 'C1.ClientID'
      Visible = False
    end
    object qryClientLookupDefaultPostAccount: TWideStringField
      FieldName = 'DefaultPostAccount'
      Origin = 'CT.DefaultPostAccount'
      Visible = False
      Size = 255
    end
    object qryClientLookupDefaultPostAccountID: TIntegerField
      FieldName = 'DefaultPostAccountID'
      Origin = 'CT.DefaultPostAccountID'
      Visible = False
    end
    object qryClientLookupStreet: TWideStringField
      FieldName = 'Street'
      Origin = 'C1.Street'
      Visible = False
      Size = 255
    end
    object qryClientLookupStreet2: TWideStringField
      FieldName = 'Street2'
      Origin = 'C1.Street2'
      Visible = False
      Size = 255
    end
    object qryClientLookupStreet3: TWideStringField
      FieldName = 'Street3'
      Origin = 'C1.Street3'
      Visible = False
      Size = 255
    end
    object qryClientLookupSuburb: TWideStringField
      FieldName = 'Suburb'
      Origin = 'C1.Suburb'
      Visible = False
      Size = 255
    end
    object qryClientLookupState: TWideStringField
      FieldName = 'State'
      Origin = 'C1.State'
      Visible = False
      Size = 255
    end
    object qryClientLookupCountry: TWideStringField
      FieldName = 'Country'
      Origin = 'C1.Country'
      Visible = False
      Size = 255
    end
    object qryClientLookupPostcode: TWideStringField
      FieldName = 'Postcode'
      Origin = 'C1.Postcode'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillStreet: TWideStringField
      FieldName = 'BillStreet'
      Origin = 'C1.BillStreet'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillStreet2: TWideStringField
      FieldName = 'BillStreet2'
      Origin = 'C1.BillStreet2'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillStreet3: TWideStringField
      FieldName = 'BillStreet3'
      Origin = 'C1.BillStreet3'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillSuburb: TWideStringField
      FieldName = 'BillSuburb'
      Origin = 'C1.BillSuburb'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillState: TWideStringField
      FieldName = 'BillState'
      Origin = 'C1.BillState'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillPostcode: TWideStringField
      FieldName = 'BillPostcode'
      Origin = 'C1.BillPostcode'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillCountry: TWideStringField
      FieldName = 'BillCountry'
      Origin = 'C1.BillCountry'
      Visible = False
      Size = 255
    end
    object qryClientLookupTERMS: TWideStringField
      FieldName = 'TERMS'
      Origin = 'C1.TERMS'
      Visible = False
      Size = 30
    end
    object qryClientLookupTermsID: TIntegerField
      FieldName = 'TermsID'
      Origin = 'C1.TermsID'
      Visible = False
    end
    object qryClientLookupShippingMethod: TWideStringField
      FieldName = 'ShippingMethod'
      Origin = 'C1.ShippingMethod'
      Visible = False
      Size = 30
    end
    object qryClientLookupShippingID: TIntegerField
      FieldName = 'ShippingID'
      Origin = 'C1.ShippingID'
      Visible = False
    end
    object qryClientLookupRepID: TIntegerField
      FieldName = 'RepID'
      Origin = 'C1.RepID'
      Visible = False
    end
    object qryClientLookupTaxID: TIntegerField
      FieldName = 'TaxID'
      Origin = 'C1.TaxID'
      Visible = False
    end
    object qryClientLookupPhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'C1.Phone'
      Visible = False
    end
    object qryClientLookupFax: TWideStringField
      FieldName = 'Fax'
      Origin = 'C1.Fax'
      Visible = False
    end
    object qryClientLookupAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Origin = 'C1.AltPhone'
      Visible = False
    end
    object qryClientLookupStopCredits: TWideStringField
      FieldName = 'StopCredits'
      Origin = 'StopCredits'
      Visible = False
      Size = 1
    end
    object qryClientLookupForcePOOnInvoice: TWideStringField
      FieldName = 'ForcePOOnInvoice'
      Origin = 'C1.ForcePOOnInvoice'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryClientLookupUseInvBase: TWideStringField
      FieldName = 'UseInvBase'
      Origin = 'C1.UseInvBase'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryClientLookupInvBaseNumber: TIntegerField
      FieldName = 'InvBaseNumber'
      Origin = 'C1.InvBaseNumber'
      Visible = False
    end
    object qryClientLookupWarrantyFinishDate: TDateTimeField
      FieldName = 'WarrantyFinishDate'
      Origin = 'C1.WarrantyFinishDate'
      Visible = False
    end
    object qryClientLookupIsJob: TWideStringField
      FieldName = 'IsJob'
      Origin = 'C1.IsJob'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object cboProductQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        '#DUMMY QUERY - Sales.Formcreate dynamically changes the query fo' +
        'r seach options '
      ''
      'SELECT '
      'SUBSTRING_INDEX(P.ProductGroup,'#39'^'#39',1) AS Manuf    , '
      
        'substring(substring_index(P.ProductGroup,'#39'^'#39',2),char_length(subs' +
        'tring_index(P.ProductGroup,'#39'^'#39',1))+2) AS Type  ,'
      
        'substring(substring_index(P.ProductGroup,'#39'^'#39',3),char_length(subs' +
        'tring_index(P.ProductGroup,'#39'^'#39',2))+2) AS Dept,'
      'P.PARTSID as PARTSID,'
      'P.PARTTYPE as PARTTYPE,'
      'P.PRODUCTGROUP as PRODUCTGROUP,'
      'P.PARTNAME as PARTNAME,'
      'P.PARTSDESCRIPTION as PARTSDESCRIPTION,'
      'P.INCOMEACCNT as INCOMEACCNT,'
      'P.PurchaseDesc as PurchaseDesc,'
      'P.ASSETACCNT as ASSETACCNT,'
      'P.COGSACCNT as COGSACCNT,'
      'P.BARCODE as BARCODE,'
      'P.PRODUCTCODE as PRODUCTCODE,'
      'P.PURCHTAXCODE as PURCHTAXCODE,'
      'P.PREFEREDSUPP as PREFEREDSUPP,'
      'P.Batch as Batch,'
      'P.SpecialDiscount as SpecialDiscount,'
      'P.SNTracking as SNTracking,'
      'P.BuyQTY1 as BuyQTY1,'
      'P.BuyQTY2 as BuyQTY2,'
      'P.BuyQTY3 as BuyQTY3,'
      'P.COST1 as COST1,'
      'P.COST2 as COST2,'
      'P.COST3 as COST3,'
      'P.SellQTY1 as SellQTY1,'
      'P.SellQTY2 as SellQTY2,'
      'P.SellQTY3 as SellQTY3,'
      'P.PRICE1 as PRICE1,'
      'P.PRICE2 as PRICE2,'
      'P.PRICE3 as PRICE3,'
      'P.WHOLESALEPRICE as WHOLESALEPRICE,'
      'P.Active as Active,'
      'P.EditedFlag as EditedFlag,'
      'P.MultipleBins as MultipleBins,'
      'P.AvgCost as AvgCost,'
      'P.Discontinued as Discontinued,'
      'P.Attrib1Purchase as Attrib1Purchase,'
      'P.Attrib2Purchase as Attrib2Purchase,'
      'P.Attrib1PurchaseRate as Attrib1PurchaseRate,'
      
        'if (ifnull(LatestCost ,0) = 0 , cost1, LatestCost ) as LatestCos' +
        'tPrice  , '
      'p.TAXCODE, p.AutoBatch,'
      'p.Attrib1Sale,'
      'p.Attrib2Sale, '
      ' p.Attrib1SaleRate, '
      'P.LatestCostDate as LatestCostDate,'
      '`P`.`CUSTFLD1`,'
      '`P`.`CUSTFLD2`,'
      '`P`.`CUSTFLD3`,'
      '`P`.`CUSTFLD4`,'
      '`P`.`CUSTFLD5`,'
      '`P`.`CUSTFLD6`,'
      '`P`.`CUSTFLD7`,'
      '`P`.`CUSTFLD8`,'
      '`P`.`CUSTFLD9`,'
      '`P`.`CUSTFLD10`,'
      '`P`.`CUSTFLD11`,'
      '`P`.`CUSTFLD12`,'
      '`P`.`CUSTFLD13`,'
      '`P`.`CUSTFLD14`,'
      '`P`.`CUSTFLD15`,'
      '`P`.`CUSTDATE1`,'
      '`P`.`CUSTDATE2`,'
      '`P`.`CUSTDATE3`'
      'FROM tblParts P'
      'WHERE P.Active = "T"'
      'and P.parttype = '#39'INV'#39
      'order by partname')
    FilterOptions = [foCaseInsensitive]
    Options.LongStrings = False
    Left = 95
    Top = 138
    object cboProductQryPARTNAME: TWideStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 15
      FieldName = 'PARTNAME'
      Origin = 'P.PARTNAME'
      Size = 60
    end
    object cboProductQryPartsDescription: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 30
      FieldName = 'PartsDescription'
      Origin = 'P.PARTSDESCRIPTION'
      Size = 255
    end
    object cboProductQryPARTSID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PARTSID'
      Origin = 'P.PARTSID'
      Visible = False
    end
    object cboProductQryPARTTYPE: TWideStringField
      DisplayWidth = 13
      FieldName = 'PARTTYPE'
      Origin = 'P.PARTTYPE'
      Visible = False
      Size = 13
    end
    object cboProductQryLatestCostPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'LatestCostPrice'
      Origin = 'LatestCostPrice'
      Visible = False
    end
    object cboProductQrySNTracking: TWideStringField
      DisplayWidth = 1
      FieldName = 'SNTracking'
      Origin = 'P.SNTracking'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'P.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryPreferedSupp: TWideStringField
      DisplayWidth = 55
      FieldName = 'PreferedSupp'
      Origin = 'P.PREFEREDSUPP'
      Visible = False
      Size = 55
    end
    object cboProductQryPRODUCTGROUP: TWideStringField
      DisplayWidth = 255
      FieldName = 'PRODUCTGROUP'
      Origin = 'P.PRODUCTGROUP'
      Visible = False
      Size = 255
    end
    object cboProductQryINCOMEACCNT: TWideStringField
      DisplayWidth = 50
      FieldName = 'INCOMEACCNT'
      Origin = 'P.INCOMEACCNT'
      Visible = False
      Size = 50
    end
    object cboProductQryASSETACCNT: TWideStringField
      DisplayWidth = 50
      FieldName = 'ASSETACCNT'
      Origin = 'P.ASSETACCNT'
      Visible = False
      Size = 50
    end
    object cboProductQryCOGSACCNT: TWideStringField
      DisplayWidth = 50
      FieldName = 'COGSACCNT'
      Origin = 'P.COGSACCNT'
      Visible = False
      Size = 50
    end
    object cboProductQryBARCODE: TWideStringField
      DisplayWidth = 35
      FieldName = 'BARCODE'
      Origin = 'P.BARCODE'
      Visible = False
      Size = 35
    end
    object cboProductQryPRODUCTCODE: TWideStringField
      DisplayWidth = 255
      FieldName = 'PRODUCTCODE'
      Origin = 'P.PRODUCTCODE'
      Visible = False
      Size = 255
    end
    object cboProductQryTAXCODE: TWideStringField
      DisplayWidth = 15
      FieldName = 'TAXCODE'
      Origin = 'P.TAXCODE'
      Visible = False
      Size = 15
    end
    object cboProductQryBatch: TWideStringField
      DisplayWidth = 1
      FieldName = 'Batch'
      Origin = 'P.Batch'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryAutoBatch: TWideStringField
      DisplayWidth = 1
      FieldName = 'AutoBatch'
      Origin = 'P.AutoBatch'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryMultipleBins: TWideStringField
      DisplayWidth = 1
      FieldName = 'MultipleBins'
      Origin = 'P.MultipleBins'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQrySpecialDiscount: TWideStringField
      DisplayWidth = 1
      FieldName = 'SpecialDiscount'
      Origin = 'P.SpecialDiscount'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryBuyQTY1: TIntegerField
      DisplayWidth = 10
      FieldName = 'BuyQTY1'
      Origin = 'P.BuyQTY1'
      Visible = False
    end
    object cboProductQryBuyQTY2: TIntegerField
      DisplayWidth = 10
      FieldName = 'BuyQTY2'
      Origin = 'P.BuyQTY2'
      Visible = False
    end
    object cboProductQryBuyQTY3: TIntegerField
      DisplayWidth = 10
      FieldName = 'BuyQTY3'
      Origin = 'P.BuyQTY3'
      Visible = False
    end
    object cboProductQryCOST1: TFloatField
      DisplayWidth = 10
      FieldName = 'COST1'
      Origin = 'P.COST1'
      Visible = False
    end
    object cboProductQryCOST2: TFloatField
      DisplayWidth = 10
      FieldName = 'COST2'
      Origin = 'P.COST2'
      Visible = False
    end
    object cboProductQryCOST3: TFloatField
      DisplayWidth = 10
      FieldName = 'COST3'
      Origin = 'P.COST3'
      Visible = False
    end
    object cboProductQrySellQTY1: TIntegerField
      DisplayWidth = 10
      FieldName = 'SellQTY1'
      Origin = 'P.SellQTY1'
      Visible = False
    end
    object cboProductQrySellQTY2: TIntegerField
      DisplayWidth = 10
      FieldName = 'SellQTY2'
      Origin = 'P.SellQTY2'
      Visible = False
    end
    object cboProductQrySellQTY3: TIntegerField
      DisplayWidth = 10
      FieldName = 'SellQTY3'
      Origin = 'P.SellQTY3'
      Visible = False
    end
    object cboProductQryPRICE1: TFloatField
      DisplayWidth = 10
      FieldName = 'PRICE1'
      Origin = 'P.PRICE1'
      Visible = False
    end
    object cboProductQryPRICE2: TFloatField
      DisplayWidth = 10
      FieldName = 'PRICE2'
      Origin = 'P.PRICE2'
      Visible = False
    end
    object cboProductQryPRICE3: TFloatField
      DisplayWidth = 10
      FieldName = 'PRICE3'
      Origin = 'P.PRICE3'
      Visible = False
    end
    object cboProductQryWHOLESALEPRICE: TFloatField
      DisplayWidth = 10
      FieldName = 'WHOLESALEPRICE'
      Origin = 'P.WHOLESALEPRICE'
      Visible = False
    end
    object cboProductQryEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Origin = 'P.EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryAvgCost: TFloatField
      DisplayWidth = 10
      FieldName = 'AvgCost'
      Origin = 'P.AvgCost'
      Visible = False
    end
    object cboProductQryAttrib1Sale: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib1Sale'
      Origin = 'P.Attrib1Sale'
      Visible = False
    end
    object cboProductQryAttrib2Sale: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib2Sale'
      Origin = 'P.Attrib2Sale'
      Visible = False
    end
    object cboProductQryAttrib1SaleRate: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib1SaleRate'
      Origin = 'P.Attrib1SaleRate'
      Visible = False
    end
    object cboProductQryDiscontinued: TWideStringField
      DisplayWidth = 1
      FieldName = 'Discontinued'
      Origin = 'P.Discontinued'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryCUSTFLD1: TWideStringField
      DisplayWidth = 255
      FieldName = 'CUSTFLD1'
      Origin = 'P.CUSTFLD1'
      Visible = False
      Size = 255
    end
    object cboProductQryCUSTFLD2: TWideStringField
      DisplayWidth = 255
      FieldName = 'CUSTFLD2'
      Origin = 'P.CUSTFLD2'
      Visible = False
      Size = 255
    end
    object cboProductQryCUSTFLD3: TWideStringField
      DisplayWidth = 255
      FieldName = 'CUSTFLD3'
      Origin = 'P.CUSTFLD3'
      Visible = False
      Size = 255
    end
    object cboProductQryCUSTFLD4: TWideStringField
      DisplayWidth = 255
      FieldName = 'CUSTFLD4'
      Origin = 'P.CUSTFLD4'
      Visible = False
      Size = 255
    end
    object cboProductQryCUSTFLD5: TWideStringField
      DisplayWidth = 255
      FieldName = 'CUSTFLD5'
      Origin = 'P.CUSTFLD5'
      Visible = False
      Size = 255
    end
    object cboProductQryCUSTFLD6: TWideStringField
      DisplayWidth = 255
      FieldName = 'CUSTFLD6'
      Origin = 'P.CUSTFLD6'
      Visible = False
      Size = 255
    end
    object cboProductQryCUSTFLD7: TWideStringField
      DisplayWidth = 255
      FieldName = 'CUSTFLD7'
      Origin = 'P.CUSTFLD7'
      Visible = False
      Size = 255
    end
    object cboProductQryCUSTFLD8: TWideStringField
      DisplayWidth = 255
      FieldName = 'CUSTFLD8'
      Origin = 'P.CUSTFLD8'
      Visible = False
      Size = 255
    end
    object cboProductQryCUSTFLD9: TWideStringField
      DisplayWidth = 255
      FieldName = 'CUSTFLD9'
      Origin = 'P.CUSTFLD9'
      Visible = False
      Size = 255
    end
    object cboProductQryCUSTFLD10: TWideStringField
      DisplayWidth = 255
      FieldName = 'CUSTFLD10'
      Origin = 'P.CUSTFLD10'
      Visible = False
      Size = 255
    end
    object cboProductQryCUSTFLD11: TWideStringField
      DisplayWidth = 255
      FieldName = 'CUSTFLD11'
      Origin = 'P.CUSTFLD11'
      Visible = False
      Size = 255
    end
    object cboProductQryCUSTFLD12: TWideStringField
      DisplayWidth = 255
      FieldName = 'CUSTFLD12'
      Origin = 'P.CUSTFLD12'
      Visible = False
      Size = 255
    end
    object cboProductQryCUSTFLD13: TWideStringField
      DisplayWidth = 255
      FieldName = 'CUSTFLD13'
      Origin = 'P.CUSTFLD13'
      Visible = False
      Size = 255
    end
    object cboProductQryCUSTFLD14: TWideStringField
      DisplayWidth = 255
      FieldName = 'CUSTFLD14'
      Origin = 'P.CUSTFLD14'
      Visible = False
      Size = 255
    end
    object cboProductQryCUSTFLD15: TWideStringField
      DisplayWidth = 255
      FieldName = 'CUSTFLD15'
      Origin = 'P.CUSTFLD15'
      Visible = False
      Size = 255
    end
    object cboProductQryCUSTDATE1: TDateTimeField
      DisplayWidth = 18
      FieldName = 'CUSTDATE1'
      Origin = 'P.CUSTDATE1'
      Visible = False
    end
    object cboProductQryCUSTDATE2: TDateTimeField
      DisplayWidth = 18
      FieldName = 'CUSTDATE2'
      Origin = 'P.CUSTDATE2'
      Visible = False
    end
    object cboProductQryCUSTDATE3: TDateTimeField
      DisplayWidth = 18
      FieldName = 'CUSTDATE3'
      Origin = 'P.CUSTDATE3'
      Visible = False
    end
    object cboProductQryType: TWideMemoField
      DisplayWidth = 10
      FieldName = 'Type'
      Origin = 'Type'
      Visible = False
      BlobType = ftWideMemo
    end
    object cboProductQryManuf: TWideStringField
      DisplayWidth = 255
      FieldName = 'Manuf'
      Origin = 'Manuf'
      Visible = False
      Size = 255
    end
    object cboProductQryDept: TWideMemoField
      DisplayWidth = 10
      FieldName = 'Dept'
      Origin = 'Dept'
      Visible = False
      BlobType = ftWideMemo
    end
  end
  object dsProductQry: TDataSource
    DataSet = cboProductQry
    Left = 136
    Top = 144
  end
  object dsClientLookup: TDataSource
    DataSet = qryClientLookup
    Left = 136
    Top = 96
  end
  object ERPQuery1: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblsales')
    FilterOptions = [foCaseInsensitive]
    Options.LongStrings = False
    Left = 623
    Top = 434
    object ERPQuery1SaleID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'SaleID'
      Origin = 'tblsales.SaleID'
    end
    object ERPQuery1GlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblsales.GlobalRef'
      Size = 255
    end
    object ERPQuery1InvoiceDocNumber: TWideStringField
      FieldName = 'InvoiceDocNumber'
      Origin = 'tblsales.InvoiceDocNumber'
      Size = 30
    end
    object ERPQuery1OriginalNo: TWideStringField
      FieldName = 'OriginalNo'
      Origin = 'tblsales.OriginalNo'
      Size = 255
    end
    object ERPQuery1BaseNo: TWideStringField
      FieldName = 'BaseNo'
      Origin = 'tblsales.BaseNo'
      Size = 255
    end
    object ERPQuery1Account: TWideStringField
      FieldName = 'Account'
      Origin = 'tblsales.Account'
      Size = 255
    end
    object ERPQuery1AccountID: TIntegerField
      FieldName = 'AccountID'
      Origin = 'tblsales.AccountID'
    end
    object ERPQuery1BOID: TWideStringField
      FieldName = 'BOID'
      Origin = 'tblsales.BOID'
      Size = 255
    end
    object ERPQuery1CustomerName: TWideStringField
      FieldName = 'CustomerName'
      Origin = 'tblsales.CustomerName'
      Size = 255
    end
    object ERPQuery1ClientID: TIntegerField
      FieldName = 'ClientID'
      Origin = 'tblsales.ClientID'
    end
    object ERPQuery1InvoiceTo: TWideStringField
      FieldName = 'InvoiceTo'
      Origin = 'tblsales.InvoiceTo'
      Size = 255
    end
    object ERPQuery1ShipTo: TWideStringField
      FieldName = 'ShipTo'
      Origin = 'tblsales.ShipTo'
      Size = 255
    end
    object ERPQuery1PickupFrom: TWideStringField
      FieldName = 'PickupFrom'
      Origin = 'tblsales.PickupFrom'
      Size = 255
    end
    object ERPQuery1SaleDate: TDateField
      FieldName = 'SaleDate'
      Origin = 'tblsales.SaleDate'
    end
    object ERPQuery1TotalTax: TFloatField
      FieldName = 'TotalTax'
      Origin = 'tblsales.TotalTax'
    end
    object ERPQuery1TotalWETTax: TFloatField
      FieldName = 'TotalWETTax'
      Origin = 'tblsales.TotalWETTax'
    end
    object ERPQuery1TotalWEGTax: TFloatField
      FieldName = 'TotalWEGTax'
      Origin = 'tblsales.TotalWEGTax'
    end
    object ERPQuery1TotalAmount: TFloatField
      FieldName = 'TotalAmount'
      Origin = 'tblsales.TotalAmount'
    end
    object ERPQuery1TotalAmountInc: TFloatField
      FieldName = 'TotalAmountInc'
      Origin = 'tblsales.TotalAmountInc'
    end
    object ERPQuery1TotalMarkup: TFloatField
      FieldName = 'TotalMarkup'
      Origin = 'tblsales.TotalMarkup'
    end
    object ERPQuery1TotalDiscount: TFloatField
      FieldName = 'TotalDiscount'
      Origin = 'tblsales.TotalDiscount'
    end
    object ERPQuery1EmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Origin = 'tblsales.EmployeeName'
      Size = 255
    end
    object ERPQuery1EmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblsales.EmployeeID'
    end
    object ERPQuery1ClassID: TIntegerField
      FieldName = 'ClassID'
      Origin = 'tblsales.ClassID'
    end
    object ERPQuery1Class: TWideStringField
      FieldName = 'Class'
      Origin = 'tblsales.Class'
      Size = 255
    end
    object ERPQuery1OrderNumber: TWideStringField
      FieldName = 'OrderNumber'
      Origin = 'tblsales.OrderNumber'
      Size = 30
    end
    object ERPQuery1PONumber: TWideStringField
      FieldName = 'PONumber'
      Origin = 'tblsales.PONumber'
      Size = 30
    end
    object ERPQuery1ChequeNo: TWideStringField
      FieldName = 'ChequeNo'
      Origin = 'tblsales.ChequeNo'
      Size = 45
    end
    object ERPQuery1ShipDate: TDateField
      FieldName = 'ShipDate'
      Origin = 'tblsales.ShipDate'
    end
    object ERPQuery1FutureSO: TWideStringField
      FieldName = 'FutureSO'
      Origin = 'tblsales.FutureSO'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1DueDate: TDateField
      FieldName = 'DueDate'
      Origin = 'tblsales.DueDate'
    end
    object ERPQuery1ConNote: TWideStringField
      FieldName = 'ConNote'
      Origin = 'tblsales.ConNote'
      Size = 25
    end
    object ERPQuery1Memo: TWideMemoField
      FieldName = 'Memo'
      Origin = 'tblsales.Memo'
      BlobType = ftWideMemo
    end
    object ERPQuery1Comments: TWideMemoField
      FieldName = 'Comments'
      Origin = 'tblsales.Comments'
      BlobType = ftWideMemo
    end
    object ERPQuery1InvoicePrintDesc: TWideStringField
      FieldName = 'InvoicePrintDesc'
      Origin = 'tblsales.InvoicePrintDesc'
      Size = 255
    end
    object ERPQuery1PickMemo: TWideMemoField
      FieldName = 'PickMemo'
      Origin = 'tblsales.PickMemo'
      BlobType = ftWideMemo
      Size = 255
    end
    object ERPQuery1PrintHold: TWideStringField
      FieldName = 'PrintHold'
      Origin = 'tblsales.PrintHold'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1Shipping: TWideStringField
      FieldName = 'Shipping'
      Origin = 'tblsales.Shipping'
      Size = 255
    end
    object ERPQuery1Terms: TWideStringField
      FieldName = 'Terms'
      Origin = 'tblsales.Terms'
      Size = 255
    end
    object ERPQuery1PayMethod: TWideStringField
      FieldName = 'PayMethod'
      Origin = 'tblsales.PayMethod'
      Size = 50
    end
    object ERPQuery1PayDueDate: TWideStringField
      FieldName = 'PayDueDate'
      Origin = 'tblsales.PayDueDate'
      Size = 11
    end
    object ERPQuery1Paid: TWideStringField
      FieldName = 'Paid'
      Origin = 'tblsales.Paid'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1Balance: TFloatField
      FieldName = 'Balance'
      Origin = 'tblsales.Balance'
    end
    object ERPQuery1SOBalance: TFloatField
      FieldName = 'SOBalance'
      Origin = 'tblsales.SOBalance'
    end
    object ERPQuery1Payment: TFloatField
      FieldName = 'Payment'
      Origin = 'tblsales.Payment'
    end
    object ERPQuery1ApplyFlag: TWideStringField
      FieldName = 'ApplyFlag'
      Origin = 'tblsales.ApplyFlag'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1AmountDue: TFloatField
      FieldName = 'AmountDue'
      Origin = 'tblsales.AmountDue'
    end
    object ERPQuery1TimeOfSale: TWideStringField
      FieldName = 'TimeOfSale'
      Origin = 'tblsales.TimeOfSale'
      Size = 15
    end
    object ERPQuery1IsPOS: TWideStringField
      FieldName = 'IsPOS'
      Origin = 'tblsales.IsPOS'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1POS: TWideStringField
      FieldName = 'POS'
      Origin = 'tblsales.POS'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1IsRefund: TWideStringField
      FieldName = 'IsRefund'
      Origin = 'tblsales.IsRefund'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1IsCashSale: TWideStringField
      FieldName = 'IsCashSale'
      Origin = 'tblsales.IsCashSale'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1IsInvoice: TWideStringField
      FieldName = 'IsInvoice'
      Origin = 'tblsales.IsInvoice'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1IsQuote: TWideStringField
      FieldName = 'IsQuote'
      Origin = 'tblsales.IsQuote'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1IsSalesOrder: TWideStringField
      FieldName = 'IsSalesOrder'
      Origin = 'tblsales.IsSalesOrder'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1IsVoucher: TWideStringField
      FieldName = 'IsVoucher'
      Origin = 'tblsales.IsVoucher'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1IsLayby: TWideStringField
      FieldName = 'IsLayby'
      Origin = 'tblsales.IsLayby'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1IsLaybyTOS: TWideStringField
      FieldName = 'IsLaybyTOS'
      Origin = 'tblsales.IsLaybyTOS'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1IsLaybyPayment: TWideStringField
      FieldName = 'IsLaybyPayment'
      Origin = 'tblsales.IsLaybyPayment'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1Deleted: TWideStringField
      FieldName = 'Deleted'
      Origin = 'tblsales.Deleted'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1Cancelled: TWideStringField
      FieldName = 'Cancelled'
      Origin = 'tblsales.Cancelled'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1EditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblsales.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1TotalQuoteAmount: TFloatField
      FieldName = 'TotalQuoteAmount'
      Origin = 'tblsales.TotalQuoteAmount'
    end
    object ERPQuery1LaybyID: TWideStringField
      FieldName = 'LaybyID'
      Origin = 'tblsales.LaybyID'
      Size = 14
    end
    object ERPQuery1Deposited: TWideStringField
      FieldName = 'Deposited'
      Origin = 'tblsales.Deposited'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1TillID: TSmallintField
      FieldName = 'TillID'
      Origin = 'tblsales.TillID'
    end
    object ERPQuery1HoldSale: TWideStringField
      FieldName = 'HoldSale'
      Origin = 'tblsales.HoldSale'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1SaleConfirmed: TWideStringField
      FieldName = 'SaleConfirmed'
      Origin = 'tblsales.SaleConfirmed'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1FreezeQuoteAmount: TWideStringField
      FieldName = 'FreezeQuoteAmount'
      Origin = 'tblsales.FreezeQuoteAmount'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1Converted: TWideStringField
      FieldName = 'Converted'
      Origin = 'tblsales.Converted'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1EnteredBy: TWideStringField
      FieldName = 'EnteredBy'
      Origin = 'tblsales.EnteredBy'
      Size = 255
    end
    object ERPQuery1EnteredAt: TWideStringField
      FieldName = 'EnteredAt'
      Origin = 'tblsales.EnteredAt'
      Size = 255
    end
    object ERPQuery1CommissionPaid: TWideStringField
      FieldName = 'CommissionPaid'
      Origin = 'tblsales.CommissionPaid'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1IsManifest: TWideStringField
      FieldName = 'IsManifest'
      Origin = 'tblsales.IsManifest'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1UsedOnManifest: TWideStringField
      FieldName = 'UsedOnManifest'
      Origin = 'tblsales.UsedOnManifest'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1AddToManifest: TWideStringField
      FieldName = 'AddToManifest'
      Origin = 'tblsales.AddToManifest'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1SalesOrderGlobalRef: TWideStringField
      FieldName = 'SalesOrderGlobalRef'
      Origin = 'tblsales.SalesOrderGlobalRef'
      Size = 255
    end
    object ERPQuery1QuoteGlobalRef: TWideStringField
      FieldName = 'QuoteGlobalRef'
      Origin = 'tblsales.QuoteGlobalRef'
      Size = 255
    end
    object ERPQuery1RepairGlobalRef: TWideStringField
      FieldName = 'RepairGlobalRef'
      Origin = 'tblsales.RepairGlobalRef'
      Size = 255
    end
    object ERPQuery1SOProgressPaymentGlobalRef: TWideStringField
      FieldName = 'SOProgressPaymentGlobalRef'
      Origin = 'tblsales.SOProgressPaymentGlobalRef'
      Size = 255
    end
    object ERPQuery1SOProgressPaymentOriginalRef: TWideStringField
      FieldName = 'SOProgressPaymentOriginalRef'
      Origin = 'tblsales.SOProgressPaymentOriginalRef'
      Size = 255
    end
    object ERPQuery1IsBarcodePicking: TWideStringField
      FieldName = 'IsBarcodePicking'
      Origin = 'tblsales.IsBarcodePicking'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1BarcodePickingDone: TWideStringField
      FieldName = 'BarcodePickingDone'
      Origin = 'tblsales.BarcodePickingDone'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1ARNotes: TWideMemoField
      FieldName = 'ARNotes'
      Origin = 'tblsales.ARNotes'
      BlobType = ftWideMemo
    end
    object ERPQuery1OriginalCreationDate: TDateField
      FieldName = 'OriginalCreationDate'
      Origin = 'tblsales.OriginalCreationDate'
    end
    object ERPQuery1QuoteStatus: TWideStringField
      FieldName = 'QuoteStatus'
      Origin = 'tblsales.QuoteStatus'
      Size = 255
    end
    object ERPQuery1DespatchID: TIntegerField
      FieldName = 'DespatchID'
      Origin = 'tblsales.DespatchID'
    end
    object ERPQuery1RunID: TIntegerField
      FieldName = 'RunID'
      Origin = 'tblsales.RunID'
    end
    object ERPQuery1RunName: TWideStringField
      FieldName = 'RunName'
      Origin = 'tblsales.RunName'
      Size = 255
    end
    object ERPQuery1Reference: TWideStringField
      FieldName = 'Reference'
      Origin = 'tblsales.Reference'
      Size = 255
    end
    object ERPQuery1msTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblsales.msTimeStamp'
    end
    object ERPQuery1POCreated: TWideStringField
      FieldName = 'POCreated'
      Origin = 'tblsales.POCreated'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1LastUpdated: TDateTimeField
      FieldName = 'LastUpdated'
      Origin = 'tblsales.LastUpdated'
    end
    object ERPQuery1ForeignExchangeCode: TWideStringField
      FieldName = 'ForeignExchangeCode'
      Origin = 'tblsales.ForeignExchangeCode'
      FixedChar = True
      Size = 3
    end
    object ERPQuery1ForeignExchangeRate: TFloatField
      FieldName = 'ForeignExchangeRate'
      Origin = 'tblsales.ForeignExchangeRate'
    end
    object ERPQuery1ForeignTotalAmount: TFloatField
      FieldName = 'ForeignTotalAmount'
      Origin = 'tblsales.ForeignTotalAmount'
    end
    object ERPQuery1ForeignPaidAmount: TFloatField
      FieldName = 'ForeignPaidAmount'
      Origin = 'tblsales.ForeignPaidAmount'
    end
    object ERPQuery1ForeignBalanceAmount: TFloatField
      FieldName = 'ForeignBalanceAmount'
      Origin = 'tblsales.ForeignBalanceAmount'
    end
    object ERPQuery1IsGeneratedFromHire: TWideStringField
      FieldName = 'IsGeneratedFromHire'
      Origin = 'tblsales.IsGeneratedFromHire'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1BlindBalancePeriodID: TIntegerField
      FieldName = 'BlindBalancePeriodID'
      Origin = 'tblsales.BlindBalancePeriodID'
    end
    object ERPQuery1SaleDateTime: TDateTimeField
      FieldName = 'SaleDateTime'
      Origin = 'tblsales.SaleDateTime'
    end
    object ERPQuery1AutoSmartOrderRef: TWideStringField
      FieldName = 'AutoSmartOrderRef'
      Origin = 'tblsales.AutoSmartOrderRef'
      Size = 255
    end
    object ERPQuery1IsInternalOrder: TWideStringField
      FieldName = 'IsInternalOrder'
      Origin = 'tblsales.IsInternalOrder'
      FixedChar = True
      Size = 1
    end
    object ERPQuery1ShippingCost: TFloatField
      FieldName = 'ShippingCost'
      Origin = 'tblsales.ShippingCost'
    end
    object ERPQuery1contactID: TLargeintField
      FieldName = 'contactID'
      Origin = 'tblsales.contactID'
    end
    object ERPQuery1ContactName: TWideStringField
      FieldName = 'ContactName'
      Origin = 'tblsales.ContactName'
      Size = 100
    end
    object ERPQuery1POSPostCode: TWideStringField
      FieldName = 'POSPostCode'
      Origin = 'tblsales.POSPostCode'
      Size = 4
    end
    object ERPQuery1RepairID: TLargeintField
      FieldName = 'RepairID'
      Origin = 'tblsales.RepairID'
    end
    object ERPQuery1MedtypeID: TIntegerField
      FieldName = 'MedtypeID'
      Origin = 'tblsales.MedtypeID'
    end
    object ERPQuery1Medtype: TWideStringField
      FieldName = 'Medtype'
      Origin = 'tblsales.Medtype'
      Size = 100
    end
    object ERPQuery1NoOfBoxes: TLargeintField
      FieldName = 'NoOfBoxes'
      Origin = 'tblsales.NoOfBoxes'
    end
    object ERPQuery1ContributionAmount: TFloatField
      FieldName = 'ContributionAmount'
      Origin = 'tblsales.ContributionAmount'
    end
    object ERPQuery1ShipToID: TIntegerField
      FieldName = 'ShipToID'
      Origin = 'tblsales.ShipToID'
    end
    object ERPQuery1SalesCategory: TWideStringField
      FieldName = 'SalesCategory'
      Origin = 'tblsales.SalesCategory'
      Size = 255
    end
    object ERPQuery1msUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblsales.msUpdateSiteCode'
      Size = 3
    end
  end
  object DataSource1: TDataSource
    DataSet = ERPQuery1
    Left = 664
    Top = 440
  end
end
