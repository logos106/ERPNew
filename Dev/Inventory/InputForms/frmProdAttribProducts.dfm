inherited fmProdAttribProducts: TfmProdAttribProducts
  Left = 1612
  Top = 241
  HelpContext = 62000
  Caption = 'Product Attribute Products'
  ClientHeight = 403
  ClientWidth = 830
  ExplicitLeft = 1612
  ExplicitTop = 241
  ExplicitWidth = 838
  ExplicitHeight = 430
  PixelsPerInch = 96
  TextHeight = 13
  object SubForm: TDNMPanel
    Left = 0
    Top = 0
    Width = 830
    Height = 403
    HelpContext = 62001
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = 16769217
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Transparent = False
    ExplicitHeight = 396
    object Label1: TLabel
      Left = 0
      Top = 384
      Width = 826
      Height = 15
      Align = alBottom
      Alignment = taCenter
      Caption = 'Double click on the grid to restore a Deleted record.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInactiveCaption
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 280
      HelpContext = 62002
    end
    object grdAttribProducts: TwwDBGrid
      Left = 16
      Top = 16
      Width = 796
      Height = 367
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = DSGrid
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnCalcCellColors = grdAttribProductsCalcCellColors
      OnDblClick = grdAttribProductsDblClick
      OnExit = grdAttribProductsExit
      FooterColor = clWhite
      HelpContext = 62003
      object grdAttribProductsIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 20
        Height = 22
        AllowAllUp = True
        Glyph.Data = {
          26040000424D2604000000000000360000002800000012000000120000000100
          180000000000F0030000120B0000120B00000000000000000000FFFFFFFFFFFF
          636393525293FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF555591616191FFFFFFFFFFFF0000FDFDFD6060820000D20000DA3F3F
          7DF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F741417D0000CC00
          00CE5B5B80FBFBFB00009292A40000A40000C80000F60000BA30307BE7E7E7FF
          FFFFFFFFFFFFFFFFFFFFFFE7E7E734347C0000B20000FC0000D40000A28D8DA1
          000062628D0000BE0000D80000F80000F80000BA1F1F79DBDBDBFFFFFFFFFFFF
          D9D9D91C1C790000B00000FF1717FF0000F40000CA5C5C8900007979A90000CC
          0000D20000D60000F80000F40000B0131375DFDFDFDEDEDE1212750000B00000
          FA0F0FFF0000EA0000E40000E47373AB0000EAEAEC3F3FB30000CC0000D20000
          D80000F20000EE0000A812126B11116B0000A80000F60303FF0000E80000E200
          00DE3F3FBDEAEAEC0000FFFFFFFFFFFF4949B30000CC0000CE0000CC0000E400
          00DC00008A00008A0000DE0000EE0000E00000DE0000DC5252B6FFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFF6464AF0000D00000E00000E20000F60000D60000D6
          0000F40000DC0000D40000D26A6AB4FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFF8888BB0101F60303FF0000F80000FC0000FC0000FC0505FF0303
          E89696BEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFABAB
          AB0202910000E40000FC0000F80000F80000FC0000E2050592C7C7C7FFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF94949C00005800007C0000D607
          07FF0000FC0000FC0707FF0000CC00007600004EAEAEB2FFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFF8E8E960000540000840000E00F0FFF0303FF1111FF0F0FFF
          0303FF0F0FFF0000D600007C00004CB1B1B3FFFFFFFFFFFF0000FFFFFF93939B
          00004E00007C0000EA1F1FFF1111FF1F1FFF0505EC0000F21F1FFF0F0FFF1F1F
          FF0000DC000078000044B3B3B7FFFFFF0000E0E0E100004400007E0000EC2D2D
          FF1919FF2F2FFF0101FCD8D8DDC5C5CF0B0BFF2D2DFF1919FF2929FF0000E000
          007A151547FBFBFB0000C7C7C80000820000F63535FF2525FF3D3DFF0202FFCA
          CAD3FFFFFFFFFFFFACACC11515FF3939FF2525FF3535FF0000EA00006EEAEAEA
          0000E0E0E20000EA5757FF2F2FFF4949FF0707FFCACAD3FFFFFFFFFFFFFFFFFF
          FFFFFFA6A6BF1B1BFF4343FF3333FF5151FF1414D9F7F7F70000FFFFFFB6B6CD
          1B1BFF6565FF1212FFC9C9D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFACAC
          C22929FF6565FF1616FAD3D3DCFFFFFF0000FFFFFFFFFFFFAFAFC43333E6CCCC
          D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9898BE3737E4E0
          E0E3FFFFFFFFFFFF0000}
        OnClick = grdAttribProductsIButtonClick
        HelpContext = 62004
      end
    end
  end
  object qryAttribProducts: TERPQuery
    SQL.Strings = (
      'SELECT * '
      'FROM tblproductattributeproducts')
    Left = 48
    object qryAttribProductsPAP_ID: TIntegerField
      FieldName = 'PAP_ID'
    end
    object qryAttribProductsPAG_ID: TIntegerField
      FieldName = 'PAG_ID'
    end
    object qryAttribProductsGroupName: TWideStringField
      FieldName = 'GroupName'
      Size = 255
    end
    object qryAttribProductsProductID: TIntegerField
      FieldName = 'ProductID'
    end
    object qryAttribProductsProductName: TWideStringField
      FieldName = 'ProductName'
      Size = 255
    end
    object qryAttribProductsAttribName: TWideStringField
      FieldName = 'AttribName'
      Size = 255
    end
    object qryAttribProductsattribValue: TWideStringField
      FieldName = 'attribValue'
      Size = 255
    end
    object qryAttribProductsActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
  end
  object DSAttribProducts: TDataSource
    DataSet = qryAttribProducts
    Left = 49
    Top = 28
  end
  object DSGrid: TDataSource
    DataSet = grdMemTable
    Left = 223
    Top = 33
  end
  object grdMemTable: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'AutoID'
        DataType = ftAutoInc
      end>
    IndexDefs = <>
    SortOptions = []
    Standalone = True
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
    Left = 222
    Top = 3
  end
end
