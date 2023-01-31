inherited BaseInputGUI1: TBaseInputGUI1
  Caption = 'BaseInputGUI1'
  ClientHeight = 384
  ClientWidth = 509
  OldCreateOrder = True
  DesignSize = (
    509
    384)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel [1]
    Left = 70
    Top = 48
    Width = 417
    Height = 38
    HelpContext = 446002
    Shape = bsFrame
  end
  object Label2: TLabel [2]
    Left = 139
    Top = 56
    Width = 61
    Height = 19
    HelpContext = 446003
    Caption = 'Product'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object pnlTitle: TDNMPanel [3]
    Left = 94
    Top = 6
    Width = 373
    Height = 38
    HelpContext = 446014
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
      Width = 369
      Height = 34
      HelpContext = 446015
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      FromColor = clBtnFace
      ToColor = clWhite
      FromColorMirror = clWhite
      ToColorMirror = clBtnFace
      Steps = 10
      Direction = False
      Version = '1.2.1.1'
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 369
        Height = 34
        HelpContext = 446016
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Qty'#39's and Bin Location'#39's'
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
  object edPartName: TEdit [4]
    Left = 206
    Top = 53
    Width = 211
    Height = 27
    HelpContext = 446006
    TabStop = False
    AutoSelect = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    Text = 'Product'
  end
  object grdPartQtyLines: TwwDBGrid [5]
    Left = 0
    Top = 112
    Width = 509
    Height = 272
    HelpContext = 446007
    Selected.Strings = (
      'ClassName'#9'24'#9'Class'#9'T'#9
      'calcAvail'#9'9'#9'Available'#9'T'#9
      'InvoiceBOQty'#9'9'#9'Allocated~BO'#9'T'#9
      'SalesOrdersQty'#9'9'#9'Allocated~SO'#9'T'#9
      'InStockQty'#9'9'#9'In~Stock'#9'T'#9
      'OnOrderQty'#9'9'#9'On~Order'#9'T'#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alBottom
    DataSource = DSQtys
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    TitleAlignment = taCenter
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 2
    TitleButtons = False
    PaintOptions.AlternatingRowRegions = []
    PaintOptions.BackgroundOptions = [coBlendFixedRow]
  end
  object DNMPanel2: TDNMPanel [6]
    Left = 0
    Top = 89
    Width = 509
    Height = 23
    HelpContext = 446004
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Label3: TLabel
      Left = 3
      Top = 9
      Width = 58
      Height = 15
      HelpContext = 446005
      Caption = 'Quantities'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
  end
  object qryQtys: TMyQuery
    SQL.Strings = (
      
        'Select ProductID, tblparts.PartName as ProductName, tblpartqtyli' +
        'nes.ProductGroup, ClassID, ClassName ,'
      'InStockQty, SalesOrdersQty ,'
      
        'InvoiceBOQty , OnOrderQty , ReOrderPoint, tblpartqtylines.Prefer' +
        'redLevel,'
      
        'ReOrderAmount,LastAdj,ID,tblpartqtylines.EditedFlag,ClassPriceVa' +
        'riance'
      'FROM tblpartqtylines'
      'INNER JOIN tblparts ON PARTSID = ProductID'
      'WHERE ProductID= :PARTSID')
    AutoCalcFields = False
    Left = 34
    Top = 150
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PARTSID'
      end>
    object qryQtysClassName: TStringField
      DisplayLabel = 'Class'
      DisplayWidth = 24
      FieldName = 'ClassName'
      Size = 255
    end
    object qryQtyscalcAvail: TFloatField
      DisplayLabel = 'Available'
      DisplayWidth = 9
      FieldKind = fkCalculated
      FieldName = 'calcAvail'
      Calculated = True
    end
    object qryQtysInvoiceBOQty: TFloatField
      DisplayLabel = 'Allocated~BO'
      DisplayWidth = 9
      FieldName = 'InvoiceBOQty'
      ReadOnly = True
    end
    object qryQtysSalesOrdersQty: TFloatField
      DisplayLabel = 'Allocated~SO'
      DisplayWidth = 9
      FieldName = 'SalesOrdersQty'
      ReadOnly = True
    end
    object qryQtysInStockQty: TFloatField
      DisplayLabel = 'In~Stock'
      DisplayWidth = 9
      FieldName = 'InStockQty'
      ReadOnly = True
    end
    object qryQtysOnOrderQty: TFloatField
      DisplayLabel = 'On~Order'
      DisplayWidth = 9
      FieldName = 'OnOrderQty'
      ReadOnly = True
    end
    object qryQtysProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Visible = False
    end
    object qryQtysProductName: TStringField
      DisplayWidth = 40
      FieldName = 'ProductName'
      Visible = False
      Size = 255
    end
    object qryQtysProductGroup: TStringField
      DisplayWidth = 40
      FieldName = 'ProductGroup'
      Visible = False
      Size = 255
    end
    object qryQtysClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
      Visible = False
    end
    object qryQtysID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'ID'
      ReadOnly = True
      Visible = False
    end
  end
  object DSQtys: TDataSource
    DataSet = qryQtys
    Left = 42
    Top = 176
  end
end
