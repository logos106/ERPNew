object frShipment: TfrShipment
  Left = 0
  Top = 0
  Width = 832
  Height = 104
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  OnClick = FrameClick
  OnDblClick = FrameDblClick
  OnResize = FrameResize
  DesignSize = (
    832
    104)
  object bevHeighlight: TBevel
    Left = 3
    Top = 2
    Width = 826
    Height = 99
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
    ExplicitWidth = 756
  end
  object Bevel1: TBevel
    Left = 0
    Top = 92
    Width = 832
    Height = 12
    Align = alBottom
    Shape = bsBottomLine
    ExplicitTop = 93
    ExplicitWidth = 762
  end
  object lblShipAddress: TLabel
    Left = 56
    Top = 8
    Width = 561
    Height = 19
    AutoSize = False
    Caption = 'lblShipAddress'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = lblShipAddressClick
    OnDblClick = lblShipAddressDblClick
  end
  object btnDeleteShipping: TDNMSpeedButton
    Left = 13
    Top = 6
    Width = 28
    Height = 27
    DisableTransparent = False
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    NumGlyphs = 2
    Style = bsModern
    TabOrder = 0
    AutoDisableParentOnclick = True
    OnClick = btnDeleteShippingClick
  end
  object grdSaleLine: TwwDBGrid
    Left = 56
    Top = 34
    Width = 601
    Height = 64
    Selected.Strings = (
      'ProductName'#9'15'#9'Product'#9'T'#9
      'Description'#9'15'#9'Description'#9'T'#9
      'Provider'#9'10'#9'Provider'#9'F'
      'payortype'#9'10'#9'Payor Type'#9'F'
      'UOM'#9'6'#9'UOM'#9'T'#9
      'UOMSoldQty'#9'10'#9'Sold Qty'#9'T'#9
      'ShippedUOMQty'#9'10'#9'Shipped Qty'#9'T'#9
      'AllocatedUOMQty'#9'10'#9'Allocated'#9#9
      'UnallocatedUOMQty'#9'10'#9'Unallocated'#9'T'#9
      'RecipientAddressValid'#9'1'#9'RecipientAddressValid'#9'F'#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akBottom]
    DataSource = dsSaleLine
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    OnCalcCellColors = grdSaleLineCalcCellColors
    OnDblClick = grdSaleLineDblClick
  end
  object btnAddressEdit: TDNMSpeedButton
    Left = 623
    Top = 5
    Width = 33
    Height = 23
    Caption = 'Edit'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    ParentFont = False
    Style = bsModern
    TabOrder = 3
    AutoDisableParentOnclick = True
    OnClick = btnAddressEditClick
  end
  object btnEditShipment: TDNMSpeedButton
    Left = 663
    Top = 34
    Width = 42
    Height = 27
    Action = actEditActionList
    Caption = 'Edit'
    Color = clBtnFace
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    ParentColor = False
    ParentFont = False
    ShadowColor = clGray
    TabOrder = 2
    AutoDisableParentOnclick = True
  end
  object chkProcessed: TCheckBox
    Left = 738
    Top = 9
    Width = 83
    Height = 17
    Alignment = taLeftJustify
    Anchors = [akTop, akRight]
    Caption = 'Processed'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object edtTrackNo: TEdit
    Left = 663
    Top = 65
    Width = 158
    Height = 23
    ReadOnly = True
    TabOrder = 5
    Text = 'edtTrackNo'
  end
  object chkCanceled: TCheckBox
    Left = 738
    Top = 32
    Width = 83
    Height = 17
    Alignment = taLeftJustify
    Anchors = [akTop, akRight]
    Caption = 'Canceled'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object qrySaleLine: TERPQuery
    Connection = ERPConnection1
    SQL.Strings = (
      'select tblsaleslines.SaleLineId, '
      'tblsaleslines.ProductName, '
      'tblsaleslines.Product_Description as Description, '
      'tblsaleslines.UnitOfMeasureQtySold as UOMSoldQty, '
      'tblsaleslines.UnitOfMeasureShipped as ShippedUOMQty, '
      'tblsaleslines.UnitOfMeasureSaleLines as UOM,'
      'IfNull(SSL2.UOMQty,0) as AllocatedUOMQty,'
      'shp2.RecipientAddressValid, '
      
        'if(shp2.provider=0 , '#39'FedEx'#39' , if(shp2.provider=1, '#39'UPS'#39' , if(sh' +
        'p2.provider=2, '#39'USPS'#39',if(shp2.provider=3, '#39'Canada Post'#39' , '#39#39'))))' +
        ' AS Provider,'
      
        'if(shp2.payortype=0 , '#39'Sender'#39', if(shp2.payortype=1 , '#39'Recipient' +
        #39','#39#39')) AS payortype,'
      
        'tblsaleslines.UnitOfMeasureShipped - IFNULL((select sum(IfNull(S' +
        'SL1.UOMQty,0)) FROM tblShipmentSaleLine SSL1 INNER JOIN tblShipm' +
        'ent shp ON shp.ShipmentId = SSL1.ShipmentId AND shp.Canceled = "' +
        'F" WHERE SSL1.SaleLineId = SSL2.SaleLineId),0) as UnallocatedUOM' +
        'Qty'
      'from tblsaleslines'
      
        'left join tblShipmentSaleLine SSL2 on SSL2.SaleLineId = tblsales' +
        'lines.SaleLineID and SSL2.ShipmentId = :ShipmentId'
      
        'LEFT  JOIN tblShipment shp2 ON shp2.ShipmentId = SSL2.ShipmentId' +
        ' AND shp2.Canceled = "F" '
      'where SaleId = :SaleId'
      'group by tblsaleslines.SaleLineID'
      'order by tblsaleslines.SortId')
    Left = 528
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ShipmentId'
      end
      item
        DataType = ftUnknown
        Name = 'SaleId'
      end>
    object qrySaleLineProductName: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 15
      FieldName = 'ProductName'
      Origin = 'tblsaleslines.ProductName'
      Size = 60
    end
    object qrySaleLineDescription: TWideStringField
      DisplayWidth = 15
      FieldName = 'Description'
      Origin = 'tblsaleslines.Product_Description'
      Size = 255
    end
    object qrySaleLineProvider: TWideStringField
      DisplayWidth = 10
      FieldName = 'Provider'
      Size = 11
    end
    object qrySaleLinepayortype: TWideStringField
      DisplayLabel = 'Payor Type'
      DisplayWidth = 10
      FieldName = 'payortype'
      Size = 9
    end
    object qrySaleLineUOM: TWideStringField
      DisplayWidth = 6
      FieldName = 'UOM'
      Origin = 'tblsaleslines.UnitofMeasureSaleLines'
      Size = 255
    end
    object qrySaleLineUOMSoldQty: TFloatField
      DisplayLabel = 'Sold Qty'
      DisplayWidth = 10
      FieldName = 'UOMSoldQty'
      Origin = 'tblsaleslines.UnitofMeasureQtySold'
    end
    object qrySaleLineShippedUOMQty: TFloatField
      DisplayLabel = 'Shipped Qty'
      DisplayWidth = 10
      FieldName = 'ShippedUOMQty'
      Origin = 'tblsaleslines.UnitofMeasureShipped'
    end
    object qrySaleLineAllocatedUOMQty: TFloatField
      DisplayLabel = 'Allocated'
      DisplayWidth = 10
      FieldName = 'AllocatedUOMQty'
      Origin = 'AllocatedUOMQty'
      OnSetText = qrySaleLineAllocatedUOMQtySetText
    end
    object qrySaleLineUnallocatedUOMQty: TFloatField
      DisplayLabel = 'Unallocated'
      DisplayWidth = 10
      FieldName = 'UnallocatedUOMQty'
      Origin = 'UnallocatedUOMQty'
    end
    object qrySaleLineRecipientAddressValid: TWideStringField
      DisplayWidth = 1
      FieldName = 'RecipientAddressValid'
      FixedChar = True
      Size = 1
    end
    object qrySaleLineSaleLineId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'SaleLineId'
      Origin = 'tblsaleslines.SaleLineID'
      Visible = False
    end
  end
  object ERPConnection1: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Server = 'localhost'
    Connected = True
    LoginPrompt = False
    Left = 456
  end
  object dsSaleLine: TDataSource
    DataSet = qrySaleLine
    Left = 576
    Top = 8
  end
  object ActionList1: TActionList
    Left = 512
    Top = 56
    object actEditActionList: TDNMAction
      Caption = 'Edit'
      OnExecute = btnEditShipmentClick
      OnUpdate = actEditActionListUpdate
      buttoncolor = clWhite
    end
  end
end
