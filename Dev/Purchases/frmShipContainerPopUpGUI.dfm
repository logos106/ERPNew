inherited frmShipContainerPopUp: TfrmShipContainerPopUp
  Left = 204
  Top = 330
  HelpContext = 633000
  Caption = 'Add to Shipping Container'
  ClientHeight = 352
  ClientWidth = 912
  OldCreateOrder = True
  ExplicitLeft = 204
  ExplicitTop = 330
  ExplicitWidth = 920
  ExplicitHeight = 379
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 303
    Width = 912
    HelpContext = 633014
    ExplicitTop = 303
    ExplicitWidth = 912
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 912
    Height = 50
    HelpContext = 633004
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      912
      50)
    object pnlTitle: TDNMPanel
      Left = 251
      Top = 6
      Width = 429
      Height = 38
      HelpContext = 633015
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Sales Order'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 427
        Height = 36
        HelpContext = 633016
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
          Width = 427
          Height = 36
          HelpContext = 633017
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'PO Line Assignment'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
      end
    end
  end
  object DNMPanel1: TDNMPanel [6]
    Left = 0
    Top = 303
    Width = 912
    Height = 49
    HelpContext = 633001
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      912
      49)
    object Label3: TLabel
      Left = 2
      Top = 6
      Width = 76
      Height = 15
      Alignment = taCenter
      Anchors = [akLeft, akBottom]
      Caption = 'Total Records'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      HelpContext = 633018
    end
    object lblTotal: TLabel
      Left = 1
      Top = 23
      Width = 77
      Height = 22
      Alignment = taCenter
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      HelpContext = 633019
    end
    object btnCancel: TDNMSpeedButton
      Left = 546
      Top = 14
      Width = 87
      Height = 27
      HelpContext = 633002
      Action = actCancel
      Anchors = [akBottom]
      Caption = '&Close'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object btnAdd: TDNMSpeedButton
      Left = 263
      Top = 13
      Width = 90
      Height = 27
      HelpContext = 633003
      Anchors = [akBottom]
      Caption = '&Add Selection'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 1
      OnClick = btnAddClick
    end
  end
  object grdPO: TwwDBGrid [7]
    Left = 0
    Top = 87
    Width = 912
    Height = 216
    HelpContext = 633005
    Selected.Strings = (
      'ProductName'#9'16'#9'Product Name'#9'F'
      'UnitOfMeasurePOLines'#9'9'#9'Unit'#9'F'
      'Product_Description'#9'17'#9'Description'#9'F'
      'Qtysold'#9'9'#9'Quantity'#9'F'
      'OrderDate'#9'12'#9'Order Date'#9'F'
      'Class'#9'15'#9'Department'#9'F'
      'TotalLineAmountInc'#9'15'#9'Amount Inc'#9'F'
      'PurchaseOrderID'#9'10'#9'From PO #'#9'F'
      'CustomerName'#9'16'#9'Customer Name'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = DSPOs
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgProportionalColResize, dgFixedProportionalResize]
    ParentFont = False
    TabOrder = 2
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = True
    UseTFields = False
  end
  object DNMPanel3: TDNMPanel [8]
    Left = 0
    Top = 50
    Width = 912
    Height = 37
    HelpContext = 633006
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Label1: TLabel
      Left = 295
      Top = 14
      Width = 47
      Height = 15
      HelpContext = 633007
      Caption = 'Supplier'
      Transparent = True
    end
    object cboSuppliers: TwwDBLookupCombo
      Left = 353
      Top = 6
      Width = 185
      Height = 23
      HelpContext = 633008
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      LookupTable = qrySuppliers
      LookupField = 'Company'
      Style = csDropDownList
      ParentFont = False
      TabOrder = 0
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboSuppliersCloseUp
    end
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 32
    Top = 16
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 48
    Top = 47
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    HelpContext = 633011
    Left = 32
    Top = 40
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102004000400010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object ActionList: TActionList
    Left = 48
    Top = 24
    object actCancel: TAction
      Caption = 'Cancel'
      HelpContext = 633013
      OnExecute = actCancelExecute
    end
  end
  object qrySuppliers: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT tblClients.ClientID,Company,Supplier,Active,ShowInShipCon' +
        'tainers,PL.BackOrder '
      'FROM tblclients'
      
        'INNER JOIN tblpurchaseOrders PO ON tblClients.ClientID=PO.Client' +
        'ID'
      
        'INNER JOIN tblpurchaselines PL ON PO.PurchaseOrderID=PL.Purchase' +
        'OrderID'
      'WHERE (Supplier = "T") and (Active = "T")'
      'AND (ShowInShipContainers = "T") AND (PL.BackOrder > 0)'
      'GROUP BY Company')
    Left = 168
    Top = 48
    object qrySuppliersCompany: TWideStringField
      DisplayWidth = 30
      FieldName = 'Company'
      Size = 80
    end
    object qrySuppliersClientID: TIntegerField
      FieldName = 'ClientID'
      Visible = False
    end
    object qrySuppliersSupplier: TWideStringField
      FieldName = 'Supplier'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qrySuppliersActive: TWideStringField
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object DSPOs: TDataSource
    DataSet = qryPOs
    Left = 768
    Top = 32
  end
  object qryPOs: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT PL.PurchaseOrderID,PL.UnitOfMeasurePOLines,Date(PO.OrderD' +
        'ate) as OrderDate, PO.SupplierName,PL.UnitOfMeasureShipped,PL.Pr' +
        'oductName,PL.Class,'
      
        'PL.QtySold * PL.LineCostInc as TotalLineAmountInc ,PL.Product_De' +
        'scription,'
      'PL.PurchaseLineID,PL.SaleLineID,  PL.QtySold as Qtysold, '
      'S.CustomerName'
      'FROM tblpurchaselines PL'
      
        'INNER JOIN tblpurchaseorders PO ON PL.PurchaseOrderID = PO.Purch' +
        'aseOrderID'
      'Left join (tblsaleslines'
      
        'INNER JOIN tblsales S ON tblsaleslines.SaleID = S.SaleID) on tbl' +
        'saleslines.SaleLineID  = PL.SaleLineID'
      'WHERE SupplierName = :xSupplierName'
      
        'AND PO.IsBill <> '#39'T'#39' and PO.iscredit <> '#39'T'#39' and  PO.ISCheque <> ' +
        #39'T'#39
      'AND PL.UnitOfMeasureShipped = 0'
      'AND IFNULL(PO.BOID,'#39#39')='#39#39
      
        'AND PL.PurchaseLineID not in (SELECT  ifnull(tblshipcontainerdet' +
        'ails.PurchaseLineID,0) FROM tblshipcontainerdetails )'
      'GROUP BY PL.PurchaseLineID'
      ''
      ''
      ''
      ''
      ''
      
        '/*SELECT PL.PurchaseOrderID,UnitOfMeasurePOLines,Date(PO.OrderDa' +
        'te) as OrderDate, PO.SupplierName,PL.UnitOfMeasureShipped,PL.Pro' +
        'ductName,PL.Class,'
      '#PL.TotalLineAmountInc'
      
        'PL.QtySold * PL.LineCostInc as TotalLineAmountInc ,PL.Product_De' +
        'scription,'
      'PL.PurchaseLineID,PL.SaleLineID,  PL.QtySold as Qtysold'
      'FROM tblpurchaselines PL'
      
        'INNER JOIN tblpurchaseorders PO ON PL.PurchaseOrderID = PO.Purch' +
        'aseOrderID'
      'WHERE SupplierName = :xSupplierName'
      
        'AND PO.IsBill <> '#39'T'#39' and PO.iscredit <> '#39'T'#39' and  PO.ISCheque <> ' +
        #39'T'#39
      'AND UnitOfMeasureShipped = 0'
      'AND IFNULL(PO.BOID,'#39#39')='#39#39
      
        'AND PL.PurchaseLineID not in (SELECT  ifnull(tblshipcontainerdet' +
        'ails.PurchaseLineID,0) FROM tblshipcontainerdetails )'
      'GROUP BY PL.PurchaseLineID'
      '*/')
    AfterOpen = qryPOsAfterOpen
    Left = 664
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xSupplierName'
      end>
    object qryPOsPurchaseOrderID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PurchaseOrderID'
    end
    object qryPOsUnitOfMeasurePOLines: TWideStringField
      DisplayWidth = 15
      FieldName = 'UnitOfMeasurePOLines'
      Size = 255
    end
    object qryPOsUnitOfMeasureShipped: TFloatField
      DisplayWidth = 10
      FieldName = 'UnitOfMeasureShipped'
    end
    object qryPOsProductName: TWideStringField
      DisplayWidth = 20
      FieldName = 'ProductName'
      Size = 60
    end
    object qryPOsClass: TWideStringField
      DisplayWidth = 15
      FieldName = 'Class'
      Size = 255
    end
    object qryPOsTotalLineAmountInc: TFloatField
      DisplayWidth = 12
      FieldName = 'TotalLineAmountInc'
      currency = True
    end
    object qryPOsSupplierName: TWideStringField
      DisplayWidth = 255
      FieldName = 'SupplierName'
      Visible = False
      Size = 255
    end
    object qryPOsPurchaseLineID: TIntegerField
      FieldName = 'PurchaseLineID'
    end
    object qryPOsProduct_Description: TWideStringField
      FieldName = 'Product_Description'
      Size = 255
    end
    object qryPOsSaleLineID: TIntegerField
      FieldName = 'SaleLineID'
    end
    object qryPOsCustomerName: TWideStringField
      FieldName = 'CustomerName'
      Size = 255
    end
    object qryPOsOrderDate: TDateField
      FieldName = 'OrderDate'
    end
    object qryPOsQtysold: TFloatField
      FieldName = 'Qtysold'
    end
  end
  object qryCustomerLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select SaleLineID,tblsaleslines.SaleId,S.CustomerName'
      'FROM tblsaleslines'
      'INNER JOIN tblsales S ON tblsaleslines.SaleID = S.SaleID')
    Left = 712
    Top = 16
  end
end
