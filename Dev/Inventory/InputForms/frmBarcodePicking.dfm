inherited fmBarcodePicking: TfmBarcodePicking
  Left = 387
  Top = 150
  HelpContext = 1180002
  Caption = 'Barcode Picking'
  ClientHeight = 564
  ClientWidth = 998
  ExplicitLeft = 387
  ExplicitTop = 150
  ExplicitWidth = 1014
  ExplicitHeight = 603
  DesignSize = (
    998
    564)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 507
    Width = 998
    HelpContext = 1180003
    ExplicitTop = 507
    ExplicitWidth = 998
  end
  inherited shapehint: TShape
    Left = 12
    ExplicitLeft = 12
  end
  inherited imgGridWatermark: TImage
    Left = 215
    Top = 139
    ExplicitLeft = 215
    ExplicitTop = 139
  end
  inherited shapehintextra1: TShape
    Left = 57
    ExplicitLeft = 57
  end
  object pnlDetail: TDNMPanel [5]
    Left = 0
    Top = 176
    Width = 998
    Height = 331
    HelpContext = 1180030
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 1
    Transparent = False
    object Splitter1: TSplitter
      Left = 0
      Top = 177
      Width = 998
      Height = 2
      Cursor = crVSplit
      HelpContext = 1180031
      Align = alBottom
      Color = clBlack
      ParentColor = False
      ResizeStyle = rsLine
      ExplicitTop = 176
    end
    object pnlSummary: TDNMPanel
      Left = 0
      Top = 179
      Width = 998
      Height = 152
      HelpContext = 1180033
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      OnResize = pnlSummaryResize
      Transparent = False
      object grdSalesSummary: TwwDBGrid
        AlignWithMargins = True
        Left = 6
        Top = 28
        Width = 986
        Height = 54
        HelpContext = 1180034
        Margins.Left = 6
        Margins.Right = 6
        ControlType.Strings = (
          'Done;CheckBox;T;F')
        Selected.Strings = (
          'productname'#9'24'#9'Product Name'#9#9
          'ProductDescription'#9'50'#9'Description'#9#9
          'QtyRequired'#9'12'#9'Qty Required'#9#9
          'QtyBackorder'#9'12'#9'Back Order'#9#9
          'QtyPacked'#9'12'#9'Qty Packed'#9#9
          'UOM'#9'12'#9'UOM'#9#9)
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alClient
        DataSource = dsSalesSummary
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        ReadOnly = True
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
        OnCalcCellColors = grdSalesSummaryCalcCellColors
        OnDblClick = grdSalesSummaryDblClick
      end
      object pnlSummaryHeader: TDNMPanel
        Left = 0
        Top = 0
        Width = 998
        Height = 25
        HelpContext = 1180035
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 1
        Transparent = False
        DesignSize = (
          998
          25)
        object Label5: TLabel
          Left = 22
          Top = 7
          Width = 104
          Height = 15
          HelpContext = 1180036
          Caption = 'Packing Summary'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object lblPacknoCaption: TLabel
          Left = 779
          Top = 5
          Width = 96
          Height = 15
          HelpContext = 1180037
          Anchors = [akTop, akRight]
          Caption = 'Current Pack No:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          Visible = False
        end
        object lblPackno: TLabel
          Left = 891
          Top = 3
          Width = 78
          Height = 19
          HelpContext = 1180038
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'lblPackNo'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          Visible = False
        end
        object lblPackSummaryClickInstructions: TLabel
          Left = 152
          Top = 6
          Width = 614
          Height = 15
          HelpContext = 1180039
          Alignment = taCenter
          AutoSize = False
          Caption = 'Double Click on '#39'Back Order Qty'#39' to Pick Total'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
      end
      object grdToBeDispatched: TwwDBGrid
        AlignWithMargins = True
        Left = 6
        Top = 88
        Width = 986
        Height = 61
        HelpContext = 1180050
        Margins.Left = 6
        Margins.Right = 6
        ControlType.Strings = (
          'Done;CheckBox;T;F')
        Selected.Strings = (
          'PackNumber'#9'10'#9'Pack Number'
          'PackBarcode'#9'30'#9'Pack Barcode'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alBottom
        DataSource = dsToBeDispatched
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        ReadOnly = True
        TabOrder = 2
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
        OnCalcCellColors = grdSalesSummaryCalcCellColors
        OnDblClick = grdToBeDispatchedDblClick
      end
    end
    object pnlPacked: TDNMPanel
      Left = 0
      Top = 0
      Width = 998
      Height = 177
      HelpContext = 1180051
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnResize = pnlPackedResize
      object grdpickingassemblyentrylines: TwwDBGrid
        AlignWithMargins = True
        Left = 6
        Top = 3
        Width = 986
        Height = 87
        HelpContext = 1180032
        Margins.Left = 6
        Margins.Right = 6
        ControlType.Strings = (
          'Dispatched;CheckBox;T;F')
        Selected.Strings = (
          'ProductName'#9'34'#9'Product Name'#9#9
          'Description'#9'54'#9'Description'#9#9
          'SaleID'#9'10'#9'Sale #'#9#9
          'Qty'#9'10'#9'Qty'#9#9
          'UOM'#9'13'#9'UOM'#9#9
          'PackNumber'#9'8'#9'Pack No'#9#9
          'Dispatched'#9'1'#9'Dispatched'#9'T')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alClient
        DataSource = dspickingassemblyentrylines
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        ReadOnly = True
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
        OnCalcCellColors = grdpickingassemblyentrylinesCalcCellColors
        OnEnter = grdpickingassemblyentrylinesEnter
        GroupFieldName = 'Productname'
        object grdpickingassemblyentrylinesIButton: TwwIButton
          Left = 0
          Top = 0
          Width = 20
          Height = 22
          HelpContext = 1180058
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
          OnClick = grdpickingassemblyentrylinesIButtonClick
        end
      end
      object grdDispatched: TwwDBGrid
        AlignWithMargins = True
        Left = 6
        Top = 96
        Width = 986
        Height = 78
        HelpContext = 1180052
        Margins.Left = 6
        Margins.Right = 6
        ControlType.Strings = (
          'Done;CheckBox;T;F')
        Selected.Strings = (
          'PackNumber'#9'10'#9'Pack Number'
          'PackBarcode'#9'30'#9'Pack Barcode'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alBottom
        DataSource = dsDispatched
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        ReadOnly = True
        TabOrder = 1
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
        OnCalcCellColors = grdSalesSummaryCalcCellColors
        OnDblClick = grdSalesSummaryDblClick
      end
    end
  end
  object pnlButtons: TDNMPanel [6]
    Left = 0
    Top = 507
    Width = 998
    Height = 57
    HelpContext = 1180040
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 2
    Transparent = False
    DesignSize = (
      998
      57)
    object Label7: TLabel
      Left = 186
      Top = 0
      Width = 626
      Height = 15
      HelpContext = 1180041
      Alignment = taCenter
      Anchors = [akTop, akRight, akBottom]
      AutoSize = False
      Caption = '{ Press (Ctrl + Enter) to Start Printing a New Picking Slip }'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
    end
    object btnStartNewPicking: TDNMSpeedButton
      Left = 273
      Top = 20
      Width = 97
      Height = 29
      HelpContext = 1180042
      Anchors = []
      Caption = 'Start Next'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
        333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
        0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
        07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
        0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
        B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
        3BB33773333773333773B333333B3333333B7333333733333337}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnStartNewPickingClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 896
      Top = 20
      Width = 97
      Height = 29
      HelpContext = 1180043
      Anchors = []
      Cancel = True
      Caption = '&Close'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnCancelClick
    end
    object btnConNote: TDNMSpeedButton
      Left = 646
      Top = 20
      Width = 97
      Height = 29
      HelpContext = 1180044
      Anchors = []
      Cancel = True
      Caption = 'Con Note'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 2
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnConNoteClick
    end
    object btnControlBarCodes: TDNMSpeedButton
      Left = 128
      Top = 20
      Width = 117
      Height = 29
      HelpContext = 1180045
      Anchors = []
      Cancel = True
      Caption = 'Print Control Codes'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 3
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnControlBarCodesClick
    end
    object btnCompleted: TDNMSpeedButton
      Left = 4
      Top = 20
      Width = 97
      Height = 29
      HelpContext = 1180046
      Anchors = []
      Caption = '&Save'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 4
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnCompletedClick
    end
    object btnDelete: TDNMSpeedButton
      Left = 397
      Top = 20
      Width = 97
      Height = 29
      HelpContext = 1180047
      Anchors = []
      Caption = '&Delete'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnDeleteClick
    end
    object cmdPrint: TDNMSpeedButton
      Left = 771
      Top = 20
      Width = 97
      Height = 29
      HelpContext = 1180048
      Anchors = []
      Caption = 'Prin&t'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = cmdPrintClick
    end
    object btnPickingStatusreport: TDNMSpeedButton
      Left = 522
      Top = 20
      Width = 97
      Height = 29
      HelpContext = 1180049
      Anchors = []
      Caption = 'Picking Status'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnPickingStatusreportClick
    end
    object chkAutoPopUpBarcodePickingOptions: TwwCheckBox
      Left = 819
      Top = 1
      Width = 173
      Height = 17
      HelpContext = 1180059
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Anchors = [akRight, akBottom]
      Caption = 'Auto Pop-Up Print Options'
      TabOrder = 8
      OnClick = chkAutoPopUpBarcodePickingOptionsClick
    end
  end
  object pnlMaster: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 998
    Height = 176
    HelpContext = 1180004
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    Transparent = False
    DesignSize = (
      998
      176)
    object lblEmployee: TLabel
      Left = 20
      Top = 83
      Width = 55
      Height = 15
      HelpContext = 1180005
      Caption = 'Employee'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lblEmployeeName: TLabel
      Left = 92
      Top = 82
      Width = 300
      Height = 18
      HelpContext = 1180006
      AutoSize = False
      Caption = 'lblEmployeeName'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 20
      Top = 106
      Width = 31
      Height = 15
      HelpContext = 1180007
      Caption = 'Sale :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lblSale: TLabel
      Left = 92
      Top = 106
      Width = 300
      Height = 18
      HelpContext = 1180008
      AutoSize = False
      Caption = 'lblSale'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 20
      Top = 60
      Width = 43
      Height = 15
      HelpContext = 1180009
      Caption = 'Status :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lbPickStart: TLabel
      Left = 419
      Top = 117
      Width = 62
      Height = 15
      HelpContext = 1180010
      Alignment = taRightJustify
      Caption = 'Pick Start :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      OnDblClick = DevmodeBtnclick
    end
    object lblPickStart: TLabel
      Left = 492
      Top = 116
      Width = 122
      Height = 19
      HelpContext = 1180011
      AutoSize = False
      Caption = 'lblPickStart'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lbPickfinish: TLabel
      Left = 634
      Top = 117
      Width = 39
      Height = 15
      HelpContext = 1180012
      Caption = 'Finish :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      OnDblClick = DevmodeBtnclick
    end
    object lblPickFinish: TLabel
      Left = 684
      Top = 116
      Width = 110
      Height = 19
      HelpContext = 1180013
      AutoSize = False
      Caption = 'lblPickFinish'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lbPackstart: TLabel
      Left = 415
      Top = 135
      Width = 66
      Height = 15
      HelpContext = 1180014
      Alignment = taRightJustify
      Caption = 'Pack Start :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      OnDblClick = DevmodeBtnclick
    end
    object lblPackStart: TLabel
      Left = 492
      Top = 134
      Width = 122
      Height = 19
      HelpContext = 1180015
      AutoSize = False
      Caption = 'lblPackStart'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lbPackfinish: TLabel
      Left = 634
      Top = 135
      Width = 39
      Height = 15
      HelpContext = 1180016
      Caption = 'Finish :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      OnDblClick = DevmodeBtnclick
    end
    object lblPackFinish: TLabel
      Left = 684
      Top = 134
      Width = 110
      Height = 19
      HelpContext = 1180017
      AutoSize = False
      Caption = 'lblPackFinish'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lblSale2: TLabel
      Left = 92
      Top = 130
      Width = 300
      Height = 18
      HelpContext = 1180018
      AutoSize = False
      Caption = 'lblSale2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object imgProduct: TImage
      Left = 816
      Top = 8
      Width = 169
      Height = 137
      HelpContext = 1180019
      Anchors = [akTop, akRight]
      Proportional = True
      Stretch = True
    end
    object Label2: TLabel
      Left = 416
      Top = 59
      Width = 350
      Height = 15
      HelpContext = 1180020
      Caption = 
        'To select existing  picking  enter "S-<order number>"  (eg S-123' +
        ')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 20
      Top = 156
      Width = 93
      Height = 15
      HelpContext = 1180021
      Caption = 'Scan Summary :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lblLastProduct: TLabel
      Left = 800
      Top = 154
      Width = 185
      Height = 18
      HelpContext = 1180022
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'lblLastProduct'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lblCountSummary: TLabel
      Left = 120
      Top = 154
      Width = 268
      Height = 18
      HelpContext = 1180023
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'lblCountSummary'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lblStatus: TLabel
      Left = 92
      Top = 58
      Width = 300
      Height = 18
      HelpContext = 1180024
      AutoSize = False
      Caption = 'lblStatus'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lbDispatchStart: TLabel
      Left = 394
      Top = 152
      Width = 87
      Height = 15
      HelpContext = 1180053
      Alignment = taRightJustify
      Caption = 'Dispatch Start :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      OnDblClick = DevmodeBtnclick
    end
    object lblDispatchStart: TLabel
      Left = 492
      Top = 151
      Width = 122
      Height = 19
      HelpContext = 1180054
      AutoSize = False
      Caption = 'lblDispatchStart'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lbDispatchFinish: TLabel
      Left = 634
      Top = 152
      Width = 39
      Height = 15
      HelpContext = 1180055
      Caption = 'Finish :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      OnDblClick = DevmodeBtnclick
    end
    object lblDispatchFinish: TLabel
      Left = 684
      Top = 151
      Width = 110
      Height = 19
      HelpContext = 1180056
      AutoSize = False
      Caption = 'lblDispatchFinish'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object edtBarcodeInput: TEdit
      Left = 416
      Top = 79
      Width = 273
      Height = 32
      HelpContext = 1180025
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      OnExit = edtBarcodeInputExit
      OnKeyDown = edtBarcodeInputKeyDown
      OnKeyPress = edtBarcodeInputKeyPress
    end
    object edtQty: TAdvEdit
      Left = 695
      Top = 80
      Width = 97
      Height = 32
      Hint = 
        'This is the Qty picking on the selected Line. Please change to P' +
        'ick a different Quantity. If the Quantity given is more than the' +
        ' '#39'shipped Quantity'#39' of the slaes it, Qty will be picked from the' +
        ' other sales of the group'
      HelpContext = 1180026
      EditType = etFloat
      Precision = 2
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'MS Sans Serif'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = 11075496
      Enabled = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = '0.00'
      Visible = True
      OnEnter = edtQtyEnter
      OnExit = edtQtyExit
      OnKeyDown = edtQtyKeyDown
      OnKeyPress = edtQtyKeyPress
      Version = '2.8.6.9'
    end
    object pnlTitle: TDNMPanel
      Left = 310
      Top = 6
      Width = 378
      Height = 45
      HelpContext = 1180027
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 374
        Height = 41
        HelpContext = 1180028
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
          Width = 374
          Height = 41
          HelpContext = 1180029
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Barcode Picking'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 483
        end
      end
    end
    object rgScanSummary: TRadioGroup
      Left = 22
      Top = 14
      Width = 263
      Height = 38
      HelpContext = 1180057
      Caption = 'Scan'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Summary'
        'Detail')
      TabOrder = 3
      OnClick = rgScanSummaryClick
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 196
    Top = 16
  end
  inherited tmrdelay: TTimer
    Left = 180
    Top = 112
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 211
    Top = 0
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 257
    Top = 136
  end
  inherited MyConnection: TERPConnection
    Server = 'Localhost'
    Left = 343
    Top = 136
  end
  inherited DataState: TDataState
    Left = 254
    Top = 0
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 300
    Top = 136
  end
  inherited imgsort: TImageList
    Left = 121
    Top = 112
    Bitmap = {
      494C010102000801440110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 277
    Top = 72
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 370
    Top = 72
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 320
    Top = 72
  end
  object dspickingassemblyentry: TDataSource
    DataSet = Qrypickingassemblyentry
    Left = 368
    Top = 200
  end
  object Qrypickingassemblyentry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblpickingassemblyentry')
    Left = 400
    Top = 256
    object QrypickingassemblyentryGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblpickingassemblyentry.GlobalRef'
      Size = 255
    end
    object QrypickingassemblyentryPickingAssemblyEntryID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PickingAssemblyEntryID'
      Origin = 'tblpickingassemblyentry.PickingAssemblyEntryID'
    end
    object QrypickingassemblyentrySaleID: TIntegerField
      FieldName = 'SaleID'
      Origin = 'tblpickingassemblyentry.SaleID'
    end
    object QrypickingassemblyentryBarcode: TWideStringField
      FieldName = 'Barcode'
      Origin = 'tblpickingassemblyentry.Barcode'
      Size = 255
    end
    object QrypickingassemblyentryPickingEmployeeID: TIntegerField
      FieldName = 'PickingEmployeeID'
      Origin = 'tblpickingassemblyentry.PickingEmployeeID'
    end
    object QrypickingassemblyentryStartPicking: TWideStringField
      FieldName = 'StartPicking'
      Origin = 'tblpickingassemblyentry.StartPicking'
      FixedChar = True
      Size = 1
    end
    object QrypickingassemblyentryStartPickingTime: TDateTimeField
      FieldName = 'StartPickingTime'
      Origin = 'tblpickingassemblyentry.StartPickingTime'
    end
    object QrypickingassemblyentryFinishedPicking: TWideStringField
      FieldName = 'FinishedPicking'
      Origin = 'tblpickingassemblyentry.FinishedPicking'
      FixedChar = True
      Size = 1
    end
    object QrypickingassemblyentryFinishedPickingTime: TDateTimeField
      FieldName = 'FinishedPickingTime'
      Origin = 'tblpickingassemblyentry.FinishedPickingTime'
    end
    object QrypickingassemblyentryPackingEmployeeID: TIntegerField
      FieldName = 'PackingEmployeeID'
      Origin = 'tblpickingassemblyentry.PackingEmployeeID'
    end
    object QrypickingassemblyentryStartPacking: TWideStringField
      FieldName = 'StartPacking'
      Origin = 'tblpickingassemblyentry.StartPacking'
      FixedChar = True
      Size = 1
    end
    object QrypickingassemblyentryStartPackingTime: TDateTimeField
      FieldName = 'StartPackingTime'
      Origin = 'tblpickingassemblyentry.StartPackingTime'
    end
    object QrypickingassemblyentryFinishedPacking: TWideStringField
      FieldName = 'FinishedPacking'
      Origin = 'tblpickingassemblyentry.FinishedPacking'
      FixedChar = True
      Size = 1
    end
    object QrypickingassemblyentryFinishedPackingTime: TDateTimeField
      FieldName = 'FinishedPackingTime'
      Origin = 'tblpickingassemblyentry.FinishedPackingTime'
    end
    object QrypickingassemblyentryEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblpickingassemblyentry.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object QrypickingassemblyentrymsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblpickingassemblyentry.msTimeStamp'
    end
    object QrypickingassemblyentrymsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblpickingassemblyentry.msUpdateSiteCode'
      Size = 3
    end
    object QrypickingassemblyentryCreatedOn: TDateTimeField
      FieldName = 'CreatedOn'
    end
    object QrypickingassemblyentryDispatchingEmployeeID: TIntegerField
      FieldName = 'DispatchingEmployeeID'
    end
    object QrypickingassemblyentryStartDispatch: TWideStringField
      FieldName = 'StartDispatch'
      FixedChar = True
      Size = 1
    end
    object QrypickingassemblyentryStartDispatchTime: TDateTimeField
      FieldName = 'StartDispatchTime'
    end
    object QrypickingassemblyentryFinishedDispatch: TWideStringField
      FieldName = 'FinishedDispatch'
      FixedChar = True
      Size = 1
    end
    object QrypickingassemblyentryFinishedDispatchTime: TDateTimeField
      FieldName = 'FinishedDispatchTime'
    end
  end
  object dspickingassemblyentrylines: TDataSource
    DataSet = Qrypickingassemblyentrylines
    Left = 424
    Top = 200
  end
  object Qrypickingassemblyentrylines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblpickingassemblyentrylines')
    AfterOpen = QrypickingassemblyentrylinesAfterOpen
    AfterInsert = QrypickingassemblyentrylinesAfterInsert
    AfterPost = QrypickingassemblyentrylinesAfterPost
    Left = 560
    Top = 256
    object QrypickingassemblyentrylinesProductName: TWideStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 34
      FieldName = 'ProductName'
      Origin = 'tblpickingassemblyentrylines.ProductName'
      Size = 255
    end
    object QrypickingassemblyentrylinesDescription: TWideStringField
      DisplayWidth = 54
      FieldName = 'Description'
      Origin = 'tblpickingassemblyentrylines.Description'
      Size = 255
    end
    object QrypickingassemblyentrylinesSaleID: TIntegerField
      DisplayLabel = 'Sale #'
      DisplayWidth = 10
      FieldName = 'SaleID'
      Origin = 'tblpickingassemblyentrylines.SaleID'
    end
    object QrypickingassemblyentrylinesQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
      Origin = 'tblpickingassemblyentrylines.Qty'
    end
    object QrypickingassemblyentrylinesUOM: TWideStringField
      DisplayWidth = 13
      FieldName = 'UOM'
      Origin = 'tblpickingassemblyentrylines.UOM'
      Size = 255
    end
    object QrypickingassemblyentrylinesPackNumber: TIntegerField
      DisplayLabel = 'Pack No'
      DisplayWidth = 8
      FieldName = 'PackNumber'
      Origin = 'tblpickingassemblyentrylines.PackNumber'
    end
    object QrypickingassemblyentrylinesDispatched: TWideStringField
      DisplayWidth = 1
      FieldName = 'Dispatched'
      FixedChar = True
      Size = 1
    end
    object QrypickingassemblyentrylinesGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblpickingassemblyentrylines.GlobalRef'
      Visible = False
      Size = 255
    end
    object QrypickingassemblyentrylinesPickingAssemblyentrylinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PickingAssemblyentrylinesID'
      Origin = 'tblpickingassemblyentrylines.PickingAssemblyentrylinesID'
      Visible = False
    end
    object QrypickingassemblyentrylinesPickingAssemblyEntryID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PickingAssemblyEntryID'
      Origin = 'tblpickingassemblyentrylines.PickingAssemblyEntryID'
      Visible = False
    end
    object QrypickingassemblyentrylinesProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'tblpickingassemblyentrylines.ProductID'
      Visible = False
    end
    object QrypickingassemblyentrylinesQtyMultiplier: TFloatField
      DisplayWidth = 10
      FieldName = 'QtyMultiplier'
      Origin = 'tblpickingassemblyentrylines.QtyMultiplier'
      Visible = False
    end
    object QrypickingassemblyentrylinesUOMID: TIntegerField
      DisplayWidth = 10
      FieldName = 'UOMID'
      Origin = 'tblpickingassemblyentrylines.UOMID'
      Visible = False
    end
    object QrypickingassemblyentrylinesEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Origin = 'tblpickingassemblyentrylines.EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QrypickingassemblyentrylinesmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblpickingassemblyentrylines.msTimeStamp'
      Visible = False
    end
    object QrypickingassemblyentrylinesmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblpickingassemblyentrylines.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
  end
  object dsSalesSummary: TDataSource
    DataSet = QrySalesSummary
    Left = 560
    Top = 208
  end
  object QrySalesSummary: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select '
      'SL.productId , '
      'SL.productname , '
      'Product_Description as ProductDescription , '
      'sum(Shipped) as QtyRequired, '
      'sum(if(ifnull(shipped,0)=0 , BackOrder,0))  as QtyBackorder, '
      
        '(Select Sum(Qty) from tblpickingassemblylines PAL where PA.Picki' +
        'ngAssemblyID = PAL.PickingAssemblyID and PAL.ProductID = SL.prod' +
        'uctID)  as QtyPacked, '
      'UnitofMeasureSaleLines as UOM, '
      'UnitOfMeasureID as UOMId, '
      'UnitofMeasureMultiplier UOMMultiplier, '
      'PA.FinishedPacking as Done '
      'From tblsales S '
      'inner join tblsalesLines SL on S.saleId = SL.saleID '
      'Left join tblpickingassembly PA on PA.SaleID = S.saleID '
      'WHERE    s.saleID = 8180 '
      'GROUP BY Sl.productID')
    Left = 616
    Top = 248
    object QrySalesSummaryproductname: TWideStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 24
      FieldName = 'productname'
      Origin = 'SL.productname'
      Size = 60
    end
    object QrySalesSummaryProductDescription: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 50
      FieldName = 'ProductDescription'
      Origin = 'SL.ProductDescription'
      Size = 255
    end
    object QrySalesSummaryQtyRequired: TFloatField
      DisplayLabel = 'Qty Required'
      DisplayWidth = 12
      FieldKind = fkCalculated
      FieldName = 'QtyRequired'
      Origin = 'QtyRequired'
      Calculated = True
    end
    object QrySalesSummaryQtyBackorder: TFloatField
      DisplayLabel = 'Back Order'
      DisplayWidth = 12
      FieldName = 'QtyBackorder'
      Origin = 'QtyBackorder'
    end
    object QrySalesSummaryQtyPacked: TFloatField
      DisplayLabel = 'Qty Packed'
      DisplayWidth = 12
      FieldName = 'QtyPacked'
      Origin = 'QtyPacked'
    end
    object QrySalesSummaryUOM: TWideStringField
      DisplayWidth = 12
      FieldName = 'UOM'
      Origin = 'SL.UOM'
      Size = 255
    end
    object QrySalesSummarytotalshipped: TFloatField
      DisplayLabel = 'Total Shipped'
      DisplayWidth = 12
      FieldName = 'totalshipped'
      Origin = 'QtyTotalshipped'
      Visible = False
    end
    object QrySalesSummaryproductId: TIntegerField
      FieldName = 'productId'
      Origin = 'SL.productId'
      Visible = False
    end
    object QrySalesSummaryUOMId: TIntegerField
      FieldName = 'UOMId'
      Origin = 'SL.UOMId'
      Visible = False
    end
    object QrySalesSummaryUOMMultiplier: TFloatField
      FieldName = 'UOMMultiplier'
      Origin = 'SL.UOMMultiplier'
      Visible = False
    end
  end
  object qryToBeDispatched: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select Distinct PackNumber, Concat("D-",SaleID,"-",PackNumber) a' +
        's PackBarcode from tblpickingassemblyentrylines where Dispatched' +
        ' = "F" and PickingAssemblyEntryID = :ID')
    Left = 552
    Top = 424
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
  end
  object dsToBeDispatched: TDataSource
    DataSet = qryToBeDispatched
    Left = 544
    Top = 384
  end
  object dsDispatched: TDataSource
    DataSet = qryDispatched
    Left = 736
    Top = 224
  end
  object qryDispatched: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select Distinct PackNumber, Concat("D-",SaleID,"-",PackNumber) a' +
        's PackBarcode from tblpickingassemblyentrylines where Dispatched' +
        ' = "T" and PickingAssemblyEntryID = :ID')
    Left = 744
    Top = 264
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
  end
end
