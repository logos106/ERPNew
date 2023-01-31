inherited fmSalesorderInvoice: TfmSalesorderInvoice
  Left = 595
  Top = 309
  HelpContext = 1155002
  Caption = 'Sales Order - Partial Invoicing'
  ClientHeight = 454
  ClientWidth = 878
  Position = poMainFormCenter
  ExplicitLeft = 595
  ExplicitTop = 309
  ExplicitWidth = 894
  ExplicitHeight = 493
  DesignSize = (
    878
    454)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 305
    Width = 878
    HelpContext = 1155003
    ExplicitTop = 223
    ExplicitWidth = 455
  end
  inherited shapehint: TShape
    Left = 110
    Top = 10
    ExplicitLeft = 49
    ExplicitTop = 10
  end
  inherited imgGridWatermark: TImage
    Left = 305
    Top = 10
    ExplicitLeft = 305
    ExplicitTop = 10
  end
  inherited shapehintextra1: TShape
    Left = 233
    Top = 10
    ExplicitLeft = 113
    ExplicitTop = 10
  end
  object pnlDetails: TDNMPanel [5]
    Left = 0
    Top = 95
    Width = 878
    Height = 210
    HelpContext = 1155010
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object lblmsg: TLabel
      Left = 1
      Top = 194
      Width = 876
      Height = 15
      HelpContext = 1155011
      Align = alBottom
      Alignment = taCenter
      Caption = 'messages'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Visible = False
      ExplicitWidth = 60
    end
    object grdTransactions: TwwDBGrid
      Left = 1
      Top = 1
      Width = 876
      Height = 193
      HelpContext = 1155012
      Selected.Strings = (
        'UOMQty'#9'10'#9'Quantity~To Invoice'#9#9
        'PQA'#9'1'#9'Allocation'#9#9
        'QtytoInvoice'#9'10'#9'Quantity To~be Invoiced'#9#9
        'ProductName'#9'15'#9'Product'#9#9
        'Product_Description'#9'20'#9'Description'#9#9
        'UOM'#9'10'#9'UOM'#9#9
        'UOMQtySold'#9'10'#9'Ordered'#9#9
        'UOMQtyShipped'#9'10'#9'Shipped'#9#9
        'UOMBOQty'#9'10'#9'Back Order'#9#9
        'InvoicedQty'#9'10'#9'Qty Invoiced'#9#9)
      MemoAttributes = [mSizeable, mWordWrap, mGridShow]
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsSaleSOrderInvoiceLines
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgRowResize]
      ParentFont = False
      PopupMenu = MnuGrd
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = True
      OnCalcCellColors = grdTransactionsCalcCellColors
      OnCalcTitleAttributes = grdTransactionsCalcTitleAttributes
      OnDblClick = grdTransactionsDblClick
      OnMouseUp = grdTransactionsMouseUp
      FooterColor = clWhite
      FooterCellColor = clWhite
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
    end
  end
  object pnlBottom: TDNMPanel [6]
    Left = 0
    Top = 305
    Width = 878
    Height = 99
    HelpContext = 1155013
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      878
      99)
    object Label1: TLabel
      Left = 10
      Top = 8
      Width = 67
      Height = 18
      HelpContext = 1155014
      AutoSize = False
      Caption = 'Comments'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label2: TLabel
      Left = 220
      Top = 10
      Width = 64
      Height = 15
      HelpContext = 1155015
      Alignment = taRightJustify
      Caption = 'Invoiced By'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object SaleDate_Label: TLabel
      Left = 693
      Top = 10
      Width = 66
      Height = 15
      HelpContext = 1155016
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Invoiced On'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object txtComments: TDBMemo
      AlignWithMargins = True
      Left = 4
      Top = 36
      Width = 870
      Height = 59
      HelpContext = 1155019
      Align = alBottom
      DataField = 'Notes'
      DataSource = dsSaleSOrderInvoice
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ScrollBars = ssVertical
      ShowHint = True
      TabOrder = 2
    end
    object cboEmployee: TwwDBLookupCombo
      Left = 290
      Top = 6
      Width = 166
      Height = 23
      HelpContext = 1155020
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'EmployeeName'#9'46'#9'Employee Name'#9'F')
      DataField = 'InvoicedBy'
      DataSource = dsSaleSOrderInvoice
      LookupTable = qryEmployees
      LookupField = 'EmployeeID'
      ParentFont = False
      TabOrder = 0
      Visible = False
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboCreationDate: TwwDBDateTimePicker
      Left = 765
      Top = 6
      Width = 102
      Height = 23
      HelpContext = 1155021
      Anchors = [akTop, akRight]
      AutoFillDateAndTime = True
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'InvoicedOn'
      DataSource = dsSaleSOrderInvoice
      Epoch = 1950
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 1
      Visible = False
    end
  end
  object DNMPanel1: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 878
    Height = 95
    HelpContext = 1155004
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      878
      95)
    object Label3: TLabel
      Left = 24
      Top = 72
      Width = 71
      Height = 15
      HelpContext = 1155005
      Caption = 'Sales Order '
      Color = clBtnFace
      ParentColor = False
      Transparent = True
    end
    object pnlTitle: TDNMPanel
      Left = 179
      Top = 4
      Width = 522
      Height = 52
      HelpContext = 1155006
      Anchors = []
      
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
        Width = 520
        Height = 50
        HelpContext = 1155007
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
          Width = 520
          Height = 50
          HelpContext = 1155008
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Partial Invoicing'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = 2
          ExplicitWidth = 407
        end
      end
    end
    object wwDBEdit1: TwwDBEdit
      Left = 110
      Top = 67
      Width = 121
      Height = 23
      HelpContext = 1155009
      DataField = 'saleID'
      DataSource = dsSalesOrderLines
      ReadOnly = True
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  object pnlButtons: TDNMPanel [8]
    Left = 0
    Top = 404
    Width = 878
    Height = 50
    HelpContext = 1155025
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  inherited tmrProcessMessage: TTimer
    Left = 222
    Top = 173
  end
  inherited tmrdelay: TTimer
    Left = 456
    Top = 173
  end
  inherited popSpelling: TPopupMenu
    Left = 768
    Top = 173
  end
  inherited tmrdelayMsg: TTimer
    Left = 808
    Top = 173
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 300
    Top = 173
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 495
    Top = 173
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Left = 24
    Top = 143
  end
  inherited DataState: TDataState
    Left = 378
    Top = 173
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 534
    Top = 173
    inherited CustomiseGrid: TMenuItem
      Visible = False
    end
  end
  inherited imgsort: TImageList
    Left = 417
    Top = 173
    Bitmap = {
      494C010102001C013C0110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited QryCustomField: TERPQuery
    Left = 183
    Top = 173
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 573
    Top = 173
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 612
    Top = 173
  end
  inherited qryMemTrans: TERPQuery
    Left = 144
    Top = 173
  end
  object QrySalesOrderLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select'
      'SL.saleID, '
      
        'SL.SaleLineID , SL.ProductID, SL.ProductName ,SL.Product_Descrip' +
        'tion,  SL.UnitofMeasureQtySold , SL.UnitofMeasureShipped , SL.Un' +
        'itofMeasureBackorder , concat(SL.UnitofMeasureSaleLines , '#39'('#39' , ' +
        'SL.UnitofMeasureMultiplier , '#39')'#39') as UOM , '
      'sum(SOIL.UOMQty) as Invoiced'
      'from tblsales S'
      'inner join tblsaleslines SL on s.saleId = SL.saleID '
      
        'left join tblsalesorderinvoicelines SOIL on SL.SaleLineID = SOIL' +
        '.SalesOrderLineID'
      'where S.saleId = :SaleID'
      'group by SL.SaleLineID')
    OnCalcFields = QrySalesOrderLinesCalcFields
    Left = 27
    Top = 173
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SaleID'
      end>
    object QrySalesOrderLinesProductName: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 35
      FieldName = 'ProductName'
      Origin = 'SL.ProductName'
      Size = 60
    end
    object QrySalesOrderLinesProduct_Description: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 35
      FieldName = 'Product_Description'
      Origin = 'SL.Product_Description'
      Size = 60
    end
    object QrySalesOrderLinesUOM: TWideStringField
      DisplayWidth = 25
      FieldName = 'UOM'
      Origin = 'UOM'
      Size = 279
    end
    object QrySalesOrderLinesUnitofMeasureQtySold: TFloatField
      DisplayLabel = 'Ordered'
      DisplayWidth = 10
      FieldName = 'UnitofMeasureQtySold'
      Origin = 'SL.UnitofMeasureQtySold'
    end
    object QrySalesOrderLinesUnitofMeasureShipped: TFloatField
      DisplayLabel = 'Shipped'
      DisplayWidth = 10
      FieldName = 'UnitofMeasureShipped'
      Origin = 'SL.UnitofMeasureShipped'
    end
    object QrySalesOrderLinesUnitofMeasureBackorder: TFloatField
      DisplayLabel = 'BO'
      DisplayWidth = 10
      FieldName = 'UnitofMeasureBackorder'
      Origin = 'SL.UnitofMeasureBackorder'
    end
    object QrySalesOrderLinesInvoiced: TFloatField
      DisplayLabel = 'To be Invoiced'
      DisplayWidth = 10
      FieldName = 'Invoiced'
      Origin = 'Invoiced'
    end
    object QrySalesOrderLinessaleID: TIntegerField
      FieldName = 'saleID'
      Origin = 'SL.SaleID'
      Visible = False
    end
    object QrySalesOrderLinesSaleLineID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'SaleLineID'
      Origin = 'SL.SaleLineID'
      Visible = False
    end
    object QrySalesOrderLinesProductID: TIntegerField
      FieldName = 'ProductID'
      Origin = 'SL.ProductID'
      Visible = False
    end
    object QrySalesOrderLinesQtytoInvoice: TFloatField
      FieldKind = fkCalculated
      FieldName = 'QtytoInvoice'
      Calculated = True
    end
  end
  object dsSalesOrderLines: TDataSource
    DataSet = QrySalesOrderLines
    Left = 27
    Top = 209
  end
  object QrySaleSOrderInvoice: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblsalesorderinvoices'
      'Where (SOInvoiceID = :ID);')
    Left = 66
    Top = 173
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object QrySaleSOrderInvoiceSOInvoiceID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'SOInvoiceID'
      Origin = 'tblsalesorderinvoices.SOInvoiceID'
    end
    object QrySaleSOrderInvoiceGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblsalesorderinvoices.GlobalRef'
      Size = 255
    end
    object QrySaleSOrderInvoiceSalesOrderID: TIntegerField
      FieldName = 'SalesOrderID'
      Origin = 'tblsalesorderinvoices.SalesOrderID'
    end
    object QrySaleSOrderInvoiceInvoicedBy: TIntegerField
      FieldName = 'InvoicedBy'
      Origin = 'tblsalesorderinvoices.InvoicedBy'
    end
    object QrySaleSOrderInvoiceInvoicedOn: TDateTimeField
      FieldName = 'InvoicedOn'
      Origin = 'tblsalesorderinvoices.InvoicedOn'
    end
    object QrySaleSOrderInvoicemstimeStamp: TDateTimeField
      FieldName = 'mstimeStamp'
      Origin = 'tblsalesorderinvoices.mstimeStamp'
    end
    object QrySaleSOrderInvoicemsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblsalesorderinvoices.msUpdateSiteCode'
      Size = 3
    end
    object QrySaleSOrderInvoiceNotes: TWideStringField
      FieldName = 'Notes'
      Origin = 'tblsalesorderinvoices.Notes'
      Size = 50
    end
  end
  object dsSaleSOrderInvoice: TDataSource
    DataSet = QrySaleSOrderInvoice
    Left = 67
    Top = 209
  end
  object QrySaleSOrderInvoiceLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblsalesorderinvoicelines'
      'WHERE SOInvoiceID = :ID')
    BeforePost = QrySaleSOrderInvoiceLinesBeforePost
    OnCalcFields = QrySaleSOrderInvoiceLinesCalcFields
    Left = 105
    Top = 173
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object QrySaleSOrderInvoiceLinesUOMQty: TFloatField
      DisplayLabel = 'Quantity~To Invoice'
      DisplayWidth = 10
      FieldName = 'UOMQty'
      Origin = 'tblsalesorderinvoicelines.UOMQty'
      OnChange = QrySaleSOrderInvoiceLinesUOMQtyChange
    end
    object QrySaleSOrderInvoiceLinesPQA: TStringField
      DisplayLabel = 'Allocation'
      DisplayWidth = 1
      FieldKind = fkCalculated
      FieldName = 'PQA'
      Size = 1
      Calculated = True
    end
    object QrySaleSOrderInvoiceLinesQtytoInvoice: TFloatField
      DisplayLabel = 'Quantity To~be Invoiced'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'QtytoInvoice'
      LookupDataSet = QrySalesOrderLines
      LookupKeyFields = 'SaleLineID'
      LookupResultField = 'QtytoInvoice'
      KeyFields = 'SalesOrderLineID'
      Lookup = True
    end
    object QrySaleSOrderInvoiceLinesProductName: TStringField
      DisplayLabel = 'Product'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'ProductName'
      LookupDataSet = QrySalesOrderLines
      LookupKeyFields = 'SaleLineID'
      LookupResultField = 'ProductName'
      KeyFields = 'SalesOrderLineID'
      Size = 255
      Lookup = True
    end
    object QrySaleSOrderInvoiceLinesProduct_Description: TStringField
      DisplayLabel = 'Description'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'Product_Description'
      LookupDataSet = QrySalesOrderLines
      LookupKeyFields = 'SaleLineID'
      LookupResultField = 'Product_Description'
      KeyFields = 'SalesOrderLineID'
      Size = 255
      Lookup = True
    end
    object QrySaleSOrderInvoiceLinesUOM: TStringField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'UOM'
      LookupDataSet = QrySalesOrderLines
      LookupKeyFields = 'SaleLineID'
      LookupResultField = 'UOM'
      KeyFields = 'SalesOrderLineID'
      Size = 100
      Lookup = True
    end
    object QrySaleSOrderInvoiceLinesUOMQtySold: TFloatField
      DisplayLabel = 'Ordered'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'UOMQtySold'
      LookupDataSet = QrySalesOrderLines
      LookupKeyFields = 'SaleLineID'
      LookupResultField = 'UnitofMeasureQtySold'
      KeyFields = 'SalesOrderLineID'
      Lookup = True
    end
    object QrySaleSOrderInvoiceLinesUOMQtyShipped: TFloatField
      DisplayLabel = 'Shipped'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'UOMQtyShipped'
      LookupDataSet = QrySalesOrderLines
      LookupKeyFields = 'SaleLineID'
      LookupResultField = 'UnitofMeasureShipped'
      KeyFields = 'SalesOrderLineID'
      Lookup = True
    end
    object QrySaleSOrderInvoiceLinesUOMBOQty: TFloatField
      DisplayLabel = 'Back Order'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'UOMBOQty'
      LookupDataSet = QrySalesOrderLines
      LookupKeyFields = 'SaleLineID'
      LookupResultField = 'UnitofMeasureBackorder'
      KeyFields = 'SalesOrderLineID'
      Lookup = True
    end
    object QrySaleSOrderInvoiceLinesInvoicedQty: TFloatField
      DisplayLabel = 'Qty Invoiced'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'InvoicedQty'
      LookupDataSet = QrySalesOrderLines
      LookupKeyFields = 'SaleLineID'
      LookupResultField = 'Invoiced'
      KeyFields = 'SalesOrderLineID'
      Lookup = True
    end
    object QrySaleSOrderInvoiceLinesSOInvoiceLineID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'SOInvoiceLineID'
      Origin = 'tblsalesorderinvoicelines.SOInvoiceLineID'
      Visible = False
    end
    object QrySaleSOrderInvoiceLinesGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblsalesorderinvoicelines.GlobalRef'
      Visible = False
      Size = 255
    end
    object QrySaleSOrderInvoiceLinesSOInvoiceID: TIntegerField
      FieldName = 'SOInvoiceID'
      Origin = 'tblsalesorderinvoicelines.SOInvoiceID'
      Visible = False
    end
    object QrySaleSOrderInvoiceLinesSalesOrderLineID: TIntegerField
      FieldName = 'SalesOrderLineID'
      Origin = 'tblsalesorderinvoicelines.SalesOrderLineID'
      Visible = False
    end
    object QrySaleSOrderInvoiceLinesProductId: TIntegerField
      FieldName = 'ProductId'
      Origin = 'tblsalesorderinvoicelines.ProductId'
      Visible = False
    end
    object QrySaleSOrderInvoiceLinesUOMID: TIntegerField
      FieldName = 'UOMID'
      Origin = 'tblsalesorderinvoicelines.UOMID'
      Visible = False
    end
    object QrySaleSOrderInvoiceLinesUOMMultiplier: TFloatField
      FieldName = 'UOMMultiplier'
      Origin = 'tblsalesorderinvoicelines.UOMMultiplier'
      Visible = False
    end
    object QrySaleSOrderInvoiceLinesQty: TFloatField
      FieldName = 'Qty'
      Origin = 'tblsalesorderinvoicelines.Qty'
      Visible = False
    end
    object QrySaleSOrderInvoiceLinesmstimeStamp: TDateTimeField
      FieldName = 'mstimeStamp'
      Origin = 'tblsalesorderinvoicelines.mstimeStamp'
      Visible = False
    end
    object QrySaleSOrderInvoiceLinesmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblsalesorderinvoicelines.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
  end
  object dsSaleSOrderInvoiceLines: TDataSource
    DataSet = QrySaleSOrderInvoiceLines
    Left = 108
    Top = 209
  end
  object qryEmployees: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT E.EmployeeID, Concat(E.FirstName,'#39' '#39',E.LastName) AS Emplo' +
        'yeeName'
      'FROM tblEmployees AS E'
      'WHERE E.Active = '#39'T'#39
      'ORDER BY EmployeeName;')
    Left = 651
    Top = 173
  end
  object tmrMsg: TTimer
    Enabled = False
    OnTimer = tmrMsgTimer
    Left = 690
    Top = 173
  end
  object MnuGrd: TAdvPopupMenu
    AutoHotkeys = maManual
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 729
    Top = 173
    object mnuAllocation: TMenuItem
      Caption = 'Select correct Bin, Batch / Serial Number for partial completion'
      HelpContext = 1155024
      OnClick = mnuAllocationClick
    end
  end
  object ImageList1: TImageList
    Left = 261
    Top = 173
    Bitmap = {
      494C010102002400440010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000080000000
      0000000000000000FF0000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000800000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000080008080
      800000000000000080008080800000000000000000008080800000000000FFFF
      FF000000000080808000FFFFFF00000000000000000000000000008000008000
      0000000000000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      8000000080000000800000008000000000000000000080808000000000000000
      0000808080000000000000000000FFFFFF000000000000800000008000000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      8000000080000000800080808000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF0000000000800000000080000000FF00000080
      0000800000000000000000000000000000008080800000000000808080000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000000080000000800000000000000000000000000000000000808080000000
      0000000000000000000080808000000000000080000000800000000000000080
      000080000000000000000000000000000000808080000000000000000000FFFF
      FF00808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      800000008000808080000000000000000000000000000000000000000000FFFF
      FF000000000000000000000000000000000000FF000000FF00000000000000FF
      0000008000000000000000000000000000008080800080808000000000008080
      800000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000080008080800000000000000000000000000000000000000000008080
      8000000000008080800000000000000000000000000000000000000000000000
      0000008000008000000000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8000000080008080800000000000000000000000000000000000000000008080
      8000000000008080800000000000000000000000000000000000000000000000
      0000008000000080000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      8000000080000000800000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      000000FF00000080000080000000000000000000000000000000000000000000
      0000808080000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      80000000FF000000800080808000000000000000000000000000808080000000
      0000FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000080000000800000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000FF0000008000000000000000000000000000FFFFFF008080
      800000000000FFFFFF0000000000FFFFFF000000000000000000000000000000
      0000000000000000000000800000800000000000000000000000000000000000
      00000000000000000000FFFFFF00808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000000000000000000000000808080000000
      00000000000080808000FFFFFF00808080000000000000000000000000000000
      0000000000000000000000FF0000008000000000000000000000000000000000
      0000000000000000000080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000DFDFFFFF00000000
      9BDFDFCF0000000089A9CFEF00000000C1B68FF700000000C1DD075700000000
      E3DD276700000000E3EF272B00000000E3EBF3FB00000000E3EBF3F500000000
      C3FBF1F500000000C1D5F9FA00000000D9CAFCFC00000000FDD8FCFC00000000
      FFFDFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object c: TActionList
    Left = 339
    Top = 173
    object actclose: TDNMAction
      Caption = 'Close'
      HelpContext = 1155026
      ImageIndex = 766
      OnExecute = cmdCancelClick
      buttoncolor = clWhite
    end
    object actautoAlocate: TDNMAction
      Caption = 'Auto Allocate'
      HelpContext = 1155027
      ImageIndex = 19
      OnExecute = btnAutoAllocateClick
      buttoncolor = clWhite
    end
    object actSave: TDNMAction
      Caption = 'Make Invoice'
      HelpContext = 1155028
      ImageIndex = 765
      OnExecute = cmdCloseClick
      buttoncolor = clWhite
    end
    object actShipAll: TDNMAction
      Caption = 'Invoice All'
      HelpContext = 1155029
      ImageIndex = 170
      OnExecute = btnshipAllClick
      buttoncolor = clWhite
    end
  end
end
