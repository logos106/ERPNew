inherited fmPartsExcelPrice: TfmPartsExcelPrice
  Left = 463
  Top = 188
  Caption = 'fmPartsExcelPrice'
  ClientHeight = 719
  ClientWidth = 937
  ExplicitLeft = 463
  ExplicitTop = 188
  ExplicitWidth = 953
  ExplicitHeight = 758
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1648002
  inherited lblSkingroupMsg: TLabel
    Top = 719
    Width = 937
    ExplicitTop = 717
    ExplicitWidth = 691
    HelpContext = 1648003
  end
  inherited pnlMain: TDNMPanel
    Width = 937
    Height = 719
    ExplicitTop = -6
    ExplicitWidth = 807
    ExplicitHeight = 719
    HelpContext = 1648004
    object Shape3: TDNMPanel
      Left = 1
      Top = 54
      Width = 935
      Height = 69
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        935
        69)
      HelpContext = 1648005
      object Label2: TLabel
        Left = 71
        Top = 27
        Width = 26
        Height = 15
        HelpContext = 1648006
        Anchors = [akLeft]
        Caption = 'Cost'
        Transparent = True
        ExplicitTop = 28
      end
      object lblCost: TLabel
        AlignWithMargins = True
        Left = 277
        Top = 3
        Width = 650
        Height = 62
        HelpContext = 1648007
        Margins.Left = 277
        Align = alLeft
        AutoSize = False
        Caption = 
          'Update Product Card Cost if blank.  Preference to Edit Sales Cos' +
          't is Enabled, So Based on the Flag Below, Cost will be used in S' +
          'ales'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        ExplicitTop = 1
        ExplicitHeight = 65
      end
      object Shape2: TShape
        Left = 0
        Top = 68
        Width = 935
        Height = 1
        Align = alBottom
        Pen.Color = clGray
        ExplicitLeft = 744
        ExplicitTop = 40
        ExplicitWidth = 65
        HelpContext = 1648008
      end
      object edtCostCell: TwwDBEdit
        Left = 133
        Top = 23
        Width = 90
        Height = 23
        Anchors = [akLeft]
        DataField = 'CostCell'
        DataSource = dspartsForExcelPrice
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        ExplicitTop = 24
        HelpContext = 1648009
      end
      object btncost: TDNMSpeedButton
        Left = 235
        Top = 23
        Width = 28
        Height = 23
        HelpContext = 1648010
        Anchors = [akLeft]
        Caption = '. . .'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentFont = False
        TabOrder = 1
        AutoDisableParentOnclick = True
        OnClick = btncostClick
        ExplicitTop = 24
      end
      object chkUseCostInSales: TwwCheckBox
        Left = 133
        Top = 47
        Width = 133
        Height = 17
        HelpContext = 1648011
        TabStop = False
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Anchors = [akLeft]
        Caption = 'Use Cost in Sales'
        DataField = 'UseCostInSales'
        DataSource = dspartsForExcelPrice
        TabOrder = 2
        Visible = False
        OnExit = chkUseCostInSalesExit
        ExplicitTop = 49
      end
      object btnclearCost: TDNMSpeedButton
        Left = 103
        Top = 23
        Width = 28
        Height = 23
        HelpContext = 1648012
        Anchors = [akLeft]
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
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
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        NumGlyphs = 1
        ParentFont = False
        TabOrder = 3
        AutoDisableParentOnclick = True
        OnClick = btnclearCostClick
        ExplicitTop = 24
      end
    end
    object Shape4: TDNMPanel
      Left = 1
      Top = 123
      Width = 935
      Height = 69
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      DesignSize = (
        935
        69)
      HelpContext = 1648013
      object lblPrice: TLabel
        AlignWithMargins = True
        Left = 277
        Top = 3
        Width = 650
        Height = 62
        HelpContext = 1648014
        Margins.Left = 277
        Align = alLeft
        AutoSize = False
        Caption = 
          'Update Product Card Price if blank.  Use this Price for Sales Pr' +
          'ice Calculation'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        ExplicitLeft = 402
        ExplicitTop = 4
        ExplicitHeight = 57
      end
      object Label3: TLabel
        Left = 67
        Top = 16
        Width = 30
        Height = 15
        HelpContext = 1648015
        Anchors = [akLeft]
        Caption = 'Price'
        Transparent = True
        ExplicitTop = 17
      end
      object Shape6: TShape
        Left = 0
        Top = 68
        Width = 935
        Height = 1
        Align = alBottom
        Pen.Color = clGray
        ExplicitLeft = 744
        ExplicitTop = 40
        ExplicitWidth = 65
        HelpContext = 1648016
      end
      object edtPriceCell: TwwDBEdit
        Left = 133
        Top = 12
        Width = 90
        Height = 23
        Anchors = [akLeft]
        DataField = 'PriceCell'
        DataSource = dspartsForExcelPrice
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        ExplicitTop = 13
        HelpContext = 1648017
      end
      object btnPrice: TDNMSpeedButton
        Left = 235
        Top = 12
        Width = 28
        Height = 23
        HelpContext = 1648018
        Anchors = [akLeft]
        Caption = '. . .'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentFont = False
        TabOrder = 1
        AutoDisableParentOnclick = True
        OnClick = btnPriceClick
        ExplicitTop = 13
      end
      object chkExcelSellPriceOverridesOtherPrices: TwwCheckBox
        Left = 133
        Top = 48
        Width = 228
        Height = 17
        HelpContext = 1648019
        TabStop = False
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Excel Price Overrides Other Prices'
        DataField = 'ExcelSellPriceOverridesOtherPrices'
        DataSource = dspartsForExcelPrice
        TabOrder = 2
        OnExit = chkExcelSellPriceOverridesOtherPricesExit
      end
      object DNMSpeedButton1: TDNMSpeedButton
        Left = 103
        Top = 12
        Width = 28
        Height = 23
        HelpContext = 1648020
        Anchors = [akLeft]
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
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
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        NumGlyphs = 1
        ParentFont = False
        TabOrder = 3
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton1Click
        ExplicitTop = 13
      end
    end
    object Shape5: TDNMPanel
      Left = 1
      Top = 192
      Width = 935
      Height = 69
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      DesignSize = (
        935
        69)
      HelpContext = 1648021
      object Label4: TLabel
        Left = 50
        Top = 27
        Width = 47
        Height = 15
        HelpContext = 1648022
        Anchors = [akLeft]
        Caption = 'Quantity'
        Transparent = True
        ExplicitTop = 28
      end
      object lblQty: TLabel
        AlignWithMargins = True
        Left = 277
        Top = 3
        Width = 650
        Height = 62
        HelpContext = 1648023
        Margins.Left = 277
        Align = alLeft
        AutoSize = False
        Caption = 'Default Sales Qty'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        ExplicitLeft = 405
        ExplicitTop = 1
        ExplicitHeight = 63
      end
      object Shape7: TShape
        Left = 0
        Top = 68
        Width = 935
        Height = 1
        Align = alBottom
        Pen.Color = clGray
        ExplicitLeft = 744
        ExplicitTop = 40
        ExplicitWidth = 65
        HelpContext = 1648024
      end
      object edtQtyCell: TwwDBEdit
        Left = 133
        Top = 23
        Width = 90
        Height = 23
        Anchors = [akLeft]
        DataField = 'QtyCell'
        DataSource = dspartsForExcelPrice
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        ExplicitTop = 24
        HelpContext = 1648025
      end
      object btnQty: TDNMSpeedButton
        Left = 235
        Top = 23
        Width = 28
        Height = 23
        HelpContext = 1648026
        Anchors = [akLeft]
        Caption = '. . .'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentFont = False
        TabOrder = 1
        AutoDisableParentOnclick = True
        OnClick = btnQtyClick
        ExplicitTop = 24
      end
      object DNMSpeedButton2: TDNMSpeedButton
        Left = 103
        Top = 23
        Width = 28
        Height = 23
        HelpContext = 1648027
        Anchors = [akLeft]
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
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
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        NumGlyphs = 1
        ParentFont = False
        TabOrder = 2
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton2Click
        ExplicitTop = 24
      end
    end
    object pnlMsg: TDNMPanel
      AlignWithMargins = True
      Left = 223
      Top = 317
      Width = 491
      Height = 91
      Margins.Left = 222
      Margins.Right = 222
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = 205
      ExplicitTop = 414
      ExplicitWidth = 397
      HelpContext = 1648028
      object lblMsg: TLabel
        Left = 58
        Top = 39
        Width = 55
        Height = 15
        HelpContext = 1648029
        Alignment = taCenter
        AutoSize = False
        Caption = 'lblmsg'
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
    end
    object DNMPanel1: TDNMPanel
      Left = 1
      Top = 1
      Width = 935
      Height = 53
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      HelpContext = 1648030
      object Label1: TLabel
        Left = 42
        Top = 19
        Width = 55
        Height = 15
        HelpContext = 1648031
        Caption = 'File Name'
        Transparent = True
      end
      object Shape1: TShape
        Left = 0
        Top = 52
        Width = 935
        Height = 1
        Align = alBottom
        Pen.Color = clGray
        ExplicitLeft = 744
        ExplicitTop = 40
        ExplicitWidth = 65
        HelpContext = 1648032
      end
      object wwDBEdit1: TwwDBEdit
        Left = 133
        Top = 15
        Width = 524
        Height = 23
        DataField = 'ExcelFilename'
        DataSource = dspartsForExcelPrice
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnExit = wwDBEdit1Exit
        HelpContext = 1648033
      end
      object btnchooseExcelFileForPrice: TDNMSpeedButton
        Left = 663
        Top = 15
        Width = 28
        Height = 23
        HelpContext = 1648034
        Caption = '. . .'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentFont = False
        TabOrder = 1
        AutoDisableParentOnclick = True
        OnClick = btnchooseExcelFileForPriceClick
      end
      object wwCheckBox1: TwwCheckBox
        Left = 767
        Top = 18
        Width = 62
        Height = 17
        HelpContext = 1648035
        TabStop = False
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Active'
        DataField = 'Active'
        DataSource = dspartsForExcelPrice
        TabOrder = 2
        OnExit = wwCheckBox1Exit
      end
    end
    object pnlActive: TDNMPanel
      Left = 1
      Top = 261
      Width = 935
      Height = 53
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      Visible = False
      ExplicitLeft = 10
      ExplicitTop = 215
      HelpContext = 1648036
      object Shape8: TShape
        Left = 0
        Top = 52
        Width = 935
        Height = 1
        Align = alBottom
        Pen.Color = clGray
        ExplicitLeft = 744
        ExplicitTop = 40
        ExplicitWidth = 65
        HelpContext = 1648037
      end
      object DBCheckBox1: TwwCheckBox
        AlignWithMargins = True
        Left = 385
        Top = 16
        Width = 236
        Height = 17
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'A'
        ValueUnchecked = 'C'
        DisplayValueChecked = 'A'
        DisplayValueUnchecked = 'C'
        NullAndBlankState = cbUnchecked
        Caption = 'Open Excel file On Product Selection'
        DataField = 'ExcelPopupOption'
        DataSource = dspartsForExcelPrice
        TabOrder = 0
        Visible = False
        OnExit = DBCheckBox1Exit
        HelpContext = 1648038
      end
    end
    object DNMPanel2: TDNMPanel
      Left = 1
      Top = 640
      Width = 935
      Height = 78
      Margins.Top = 11
      Margins.Bottom = 11
      Align = alBottom
      BevelEdges = []
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      ExplicitTop = 261
      HelpContext = 1648039
      object lblNote: TLabel
        Left = 0
        Top = 0
        Width = 935
        Height = 78
        HelpContext = 1648040
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 
          'Adding/Removing Rows/Columns  in the Excel Sheet WILL NOT Make R' +
          'elative changes to the Selections Above. '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        ExplicitTop = -5
        ExplicitWidth = 929
      end
    end
  end
  inherited popSpelling: TPopupMenu
    Left = 176
    Top = 65528
  end
  inherited tmrdelayMsg: TTimer
    Left = 96
    Top = 0
  end
  object dspartsForExcelPrice: TDataSource
    DataSet = qrypartsForExcelPrice
    Left = 548
    Top = 199
  end
  object qrypartsForExcelPrice: TERPQuery
    SQL.Strings = (
      'SELECT * from tblpartsForExcelPrice where ProductId = :ProductId')
    AfterInsert = qrypartsForExcelPriceAfterInsert
    OnCalcFields = qrypartsForExcelPriceCalcFields
    Left = 549
    Top = 227
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProductId'
      end>
    object qrypartsForExcelPriceID: TIntegerField
      FieldName = 'ID'
    end
    object qrypartsForExcelPriceProductId: TIntegerField
      FieldName = 'ProductId'
    end
    object qrypartsForExcelPriceExcelPopupOption: TWideStringField
      FieldName = 'ExcelPopupOption'
      FixedChar = True
      Size = 1
    end
    object qrypartsForExcelPriceExcelFilename: TWideStringField
      FieldName = 'ExcelFilename'
      Size = 255
    end
    object qrypartsForExcelPricePriceRow: TIntegerField
      FieldName = 'PriceRow'
    end
    object qrypartsForExcelPricePriceCol: TIntegerField
      FieldName = 'PriceCol'
    end
    object qrypartsForExcelPriceCostRow: TIntegerField
      FieldName = 'CostRow'
    end
    object qrypartsForExcelPriceCostCol: TIntegerField
      FieldName = 'CostCol'
    end
    object qrypartsForExcelPriceQtycol: TIntegerField
      FieldName = 'Qtycol'
    end
    object qrypartsForExcelPriceQtyRow: TIntegerField
      FieldName = 'QtyRow'
    end
    object qrypartsForExcelPriceActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qrypartsForExcelPriceExcelSellPriceOverridesOtherPrices: TWideStringField
      FieldName = 'ExcelSellPriceOverridesOtherPrices'
      FixedChar = True
      Size = 1
    end
    object qrypartsForExcelPriceUseCostInSales: TWideStringField
      FieldName = 'UseCostInSales'
      FixedChar = True
      Size = 1
    end
    object qrypartsForExcelPricemsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object qrypartsForExcelPricemstimeStamp: TDateTimeField
      FieldName = 'mstimeStamp'
    end
    object qrypartsForExcelPricePriceCell: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'PriceCell'
      Size = 100
      Calculated = True
    end
    object qrypartsForExcelPriceCostCell: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'CostCell'
      Size = 100
      Calculated = True
    end
    object qrypartsForExcelPriceQtyCell: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'QtyCell'
      Size = 100
      Calculated = True
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.XLSX'
    Filter = 'Excel file|*.XLSX'
    Left = 880
    Top = 376
  end
  object tmrExcelEscape: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrExcelEscapeTimer
    Left = 512
    Top = 200
  end
end
