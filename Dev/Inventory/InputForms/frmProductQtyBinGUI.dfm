inherited ProductQtyBinGUI: TProductQtyBinGUI
  Left = 580
  Top = 163
  HelpContext = 446000
  Caption = 'Product Qty'#39's and Bin Location'#39's'
  ClientHeight = 229
  ClientWidth = 652
  OldCreateOrder = True
  OnResize = FormResize
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 658
  ExplicitHeight = 258
  DesignSize = (
    652
    229)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 229
    Width = 652
    HelpContext = 446013
    ExplicitTop = 229
    ExplicitWidth = 562
  end
  inherited shapehint: TShape
    Left = 12
    ExplicitLeft = 12
  end
  inherited imgGridWatermark: TImage
    Left = 420
    Top = 1
    HelpContext = 446001
    Anchors = []
    ExplicitLeft = 420
    ExplicitTop = 1
  end
  inherited shapehintextra1: TShape
    Left = 64
    ExplicitLeft = 64
  end
  object pnl2: TDNMPanel [5]
    Left = 0
    Top = 125
    Width = 652
    Height = 25
    HelpContext = 446010
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      652
      25)
    object lblDept: TLabel
      Left = 3
      Top = 7
      Width = 166
      Height = 15
      HelpContext = 446011
      Anchors = [akLeft]
      Caption = 'Bin Locations in Department :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object lbqryQtysClassName: TDBText
      Left = 180
      Top = 5
      Width = 161
      Height = 19
      HelpContext = 446012
      Anchors = [akLeft]
      AutoSize = True
      Color = clWhite
      DataField = 'calcClassName'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
  end
  object grdbins: TwwDBGrid [6]
    Left = 0
    Top = 150
    Width = 652
    Height = 79
    HelpContext = 446014
    Selected.Strings = (
      'binlocation'#9'24'#9'Bin Location'#9'F'
      'Binnumber'#9'22'#9'Bin Number'#9'F'
      'UOM'#9'12'#9'UOM'#9'F'
      'AvailableQty'#9'13'#9'Available'#9'F'
      'SoQty'#9'13'#9'Allocated SO'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = DSBin
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgProportionalColResize, dgFixedProportionalResize]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleAlignment = taCenter
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
    PaintOptions.AlternatingRowRegions = []
    PaintOptions.BackgroundOptions = [coBlendFixedRow]
  end
  object pnl1: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 652
    Height = 24
    HelpContext = 446004
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      652
      24)
    object Label3: TLabel
      Left = 3
      Top = 7
      Width = 132
      Height = 15
      HelpContext = 446005
      Anchors = [akLeft]
      Caption = 'Quantities of Product  : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object lblproduct: TLabel
      Left = 136
      Top = 5
      Width = 78
      Height = 19
      HelpContext = 446015
      Anchors = [akLeft]
      Caption = 'lblproduct'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 434
      Top = 6
      Width = 181
      Height = 15
      HelpContext = 446017
      Anchors = [akTop, akRight]
      Caption = 'Double click for more information'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      ExplicitLeft = 344
    end
  end
  object grdPartQtyLines: TwwDBGrid [8]
    Left = 0
    Top = 24
    Width = 652
    Height = 101
    HelpContext = 446007
    Selected.Strings = (
      'ClassName'#9'11'#9'Class'#9'F'
      'AvailableQty'#9'6'#9'Available'#9'F'
      'BOQty'#9'7'#9'Allocated~BO'#9'F'
      'SOQty'#9'7'#9'Allocated~SO'#9'F'
      'SOBOQty'#9'6'#9'Allocated~SO BO'#9'F'
      'InStockQty'#9'6'#9'In~Stock'#9'F'
      'OnOrderQty'#9'7'#9'On~Order'#9'F'
      'PartName'#9'16'#9'Product'#9'F'
      'ProductPrintName'#9'15'#9'Print Name'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alTop
    DataSource = DSQtys
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgProportionalColResize, dgFixedProportionalResize]
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
    TitleAlignment = taCenter
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 2
    TitleButtons = False
    UseTFields = False
    OnDblClick = grdPartQtyLinesDblClick
    PaintOptions.AlternatingRowRegions = []
    PaintOptions.BackgroundOptions = [coBlendFixedRow]
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102003C00580010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object DSBin: TDataSource
    DataSet = qryBin
    Left = 53
    Top = 328
  end
  object DSQtys: TDataSource
    DataSet = qryQtys
    Left = 42
    Top = 176
  end
  object qryQtys: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select PC.ClassID, PC.ClassName ,P.PartsID, P.PartName,P.Product' +
        'PrintNameHeading,'
      
        'Sum(if(PQA.Active ="F" , 0, if(PQA.alloctype="IN" and  PQA.ISBo=' +
        '"F", ifnull(PQA.QTY,0), if(PQA.alloctype="OUT" and (PQA.TransTyp' +
        'e<>"TSalesOrderLine" or PQA.ISBO="F") ,0-ifnull(PQA.QTY,0),0))))' +
        ' as   AvailableQty,'
      
        'Sum(if(PQA.Active ="F" , 0, if(PQA.TransType="TSalesOrderLine" o' +
        'r PQA.IsBO ="T",0,if(PQA.alloctype="IN"  , ifnull(PQA.QTY,0), 0-' +
        'ifnull(PQA.QTY,0))))) as   InStockQty,'
      
        'Sum(if(PQA.Active ="F" , 0, if(PQA.TransType="TSalesOrderLine" a' +
        'nd PQA.IsBO ="F",ifnull(PQA.QTY,0), 0))) as   SOQty,'
      
        'Sum(if(PQA.Active ="F" , 0, if(PQA.TransType="TInvoiceLine" and ' +
        'PQA.IsBO ="T",ifnull(PQA.QTY,0),0))) as   BOQty,'
      
        'Sum(if(PQA.Active ="F" , 0, if(PQA.TransType="TPurchaseOrderLine' +
        '" and PQA.IsBO ="T",ifnull(PQA.QTY,0),0))) as   OnOrderQty'
      'FROM tblParts as P'
      'inner join tblPQA as PQA on PQA.ProductId = P.PartsID '
      'inner join tblclass as C on PQA.departmentID = C.ClassID '
      
        'inner join tblProductClasses as PC on PC.ProductID = PQA.Product' +
        'ID and PC.ClassID = PQA.departmentID'
      ''
      'group by PC.ClassID, PC.ClassName')
    AutoCalcFields = False
    AfterOpen = qryQtysAfterOpen
    AfterScroll = qryQtysAfterScroll
    Left = 34
    Top = 150
    object qryQtysClassName: TWideStringField
      DisplayWidth = 20
      FieldName = 'ClassName'
      Origin = 'PC.ClassName'
      Size = 255
    end
    object qryQtysAvailableQty: TFloatField
      DisplayLabel = 'Available'
      DisplayWidth = 10
      FieldName = 'AvailableQty'
      Origin = '.AvailableQty'
    end
    object qryQtysBOQty: TFloatField
      DisplayLabel = 'Allocated~BO'
      DisplayWidth = 10
      FieldName = 'BOQty'
      Origin = '.BOQty'
    end
    object qryQtysSOQty: TFloatField
      DisplayLabel = 'Allocated~SO'
      DisplayWidth = 10
      FieldName = 'SOQty'
      Origin = '.SOQty'
    end
    object qryQtysSOBOQty: TFloatField
      DisplayLabel = 'Allocated~SO BO'
      DisplayWidth = 10
      FieldName = 'SOBOQty'
      Origin = '.SOBOQty'
    end
    object qryQtysInStockQty: TFloatField
      DisplayLabel = 'In~Stock'
      DisplayWidth = 10
      FieldName = 'InStockQty'
      Origin = '.InStockQty'
    end
    object qryQtysOnOrderQty: TFloatField
      DisplayLabel = 'On~Order'
      DisplayWidth = 10
      FieldName = 'OnOrderQty'
      Origin = '.OnOrderQty'
    end
    object qryQtysPartName: TWideStringField
      DisplayWidth = 20
      FieldName = 'PartName'
      Origin = 'tblParts.PartName'
      Size = 60
    end
    object qryQtysProductPrintName: TWideStringField
      DisplayWidth = 20
      FieldName = 'ProductPrintName'
      Origin = 'tblParts.ProductPrintName'
      Size = 60
    end
    object qryQtysClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
      Origin = 'PC.ClassID'
      Visible = False
    end
    object qryQtysPartsID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PartsID'
      Origin = 'tblParts.PartsID'
      Visible = False
    end
  end
  object qryBin: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select PBIn.binlocation, PBin.Binnumber, PQA.UOM,'
      'PQA.ProductID,PQA.DepartmentID ,'
      
        'Sum(if(PQA.Active ="F" , 0, if(PQA.alloctype="IN" and  PQA.ISBo=' +
        '"F", ifnull(PQABins.UOMQty,0), if(PQA.alloctype="OUT" and (PQA.T' +
        'ransType<>"TSalesOrderLine" or PQA.ISBO="F") ,0-ifnull(PQAbins.U' +
        'OMQty,0),0)))) as   AvailableQty,'
      
        'Sum(if(PQA.Active ="F" , 0, if(PQA.TransType="TSalesOrderLine" a' +
        'nd PQA.IsBO ="F",ifnull(PQAbins.UOMQty,0), 0))) as   SoQty'
      'FROM tblParts as P'
      'inner join tblPQA as PQA on PQA.ProductId = P.PartsID '
      'inner join tblclass as C on PQA.departmentID = C.ClassID '
      
        'Left join tblProductClasses as PC on PC.ProductID = PQA.ProductI' +
        'D and PC.ClassID = PQA.departmentID'
      
        'left join tblPqaDetails PQABatch  on PQABatch.PQAId '#9'= PQA.PQAID' +
        ' and PQABatch.PQAType = "Batch"  and PQABatch.Active= "T"'
      'left join tblPqaDetails PQABins  on PQABins.PQAId '#9'= PQA.PQAID '
      'and PQABins.PQAType = "Bin" and PQABins.Active = "T" and  '
      
        '( (PQABatch.globalref = IFNULL(PQABins.ParentRef,"") and P.Batch' +
        '="T" '
      
        'and P.multiplebins = "T") or (ifnull(PQABins.Parentref ,"") = ""' +
        ' AND P.Batch="F" and P.multiplebins = "T"))'
      'Left join tblProductBin PBin     on PBin.binId '#9'= PQABins.Value'
      'group by pbin.binlocation, pbin.Binnumber, PQA.UOM'
      ''
      
        '/*SELECT  PQA.ProductID ,PQA.DepartmentID ,PBin.Binlocation , PB' +
        'in.Binnumber ,PQA.UOM,'
      'Sum(if(PQA.alloctype='#39'IN'#39' , PQAbins.Qty, 0-PQA.Qty))  as Qty,'
      
        'Sum(if(PQA.alloctype='#39'IN'#39' , PQAbins.UOMQty, 0-PQA.UOMQty))  as U' +
        'OMQty,'
      
        'Sum(if(PQA.transtype='#39'TsalesOrderLine'#39' , PQAbins.UOMQty, 0))  as' +
        ' SOQty'
      'FROM tblParts as P'
      
        'inner join tblPQA as PQA on PQA.ProductId = P.PartsID and ISBO='#39 +
        'F'#39
      
        'and ( Date(PQA.TransDate) <= :ASonDate or  PQA.AllocType = '#39'OUT'#39 +
        ') '
      
        'left join tblPqaDetails PQABins     on PQABins.PQAId '#9'= PQA.PQAI' +
        'D and PQABins.PQAType = '#39'Bin'#39' and PQABins.Active = '#39'T'#39' and P.mul' +
        'tiplebins = '#39'T'#39
      
        'Left join tblProductBin as PBin      on PBin.binId '#9#9'= PQABins.V' +
        'alue'
      
        'group by PQA.ProductID ,PQA.DepartmentID ,PBin.Binlocation , PBi' +
        'n.Binnumber ,PQA.UOM'
      '*/')
    Left = 50
    Top = 296
    object qryBinbinlocation: TWideStringField
      DisplayLabel = 'Bin Location'
      DisplayWidth = 20
      FieldName = 'binlocation'
      Origin = 'PBin.binlocation'
      Size = 30
    end
    object qryBinBinnumber: TWideStringField
      DisplayLabel = 'Bin Number'
      DisplayWidth = 19
      FieldName = 'Binnumber'
      Origin = 'PBin.Binnumber'
      Size = 30
    end
    object qryBinUOM: TWideStringField
      DisplayWidth = 10
      FieldName = 'UOM'
      Origin = 'PQA.UOM'
      Size = 50
    end
    object qryBinAvailableQty: TFloatField
      DisplayLabel = 'Available Qty'
      DisplayWidth = 10
      FieldName = 'AvailableQty'
      Origin = '.AvailableQty'
    end
    object qryBinSoQty: TFloatField
      DisplayLabel = 'Salesorder Qty'
      DisplayWidth = 10
      FieldName = 'SoQty'
      Origin = '.SoQty'
    end
    object qryBinProductID: TIntegerField
      FieldName = 'ProductID'
      Origin = 'PQA.ProductID'
      Visible = False
    end
    object qryBinDepartmentID: TIntegerField
      FieldName = 'DepartmentID'
      Origin = 'PQA.DepartmentID'
      Visible = False
    end
  end
end
