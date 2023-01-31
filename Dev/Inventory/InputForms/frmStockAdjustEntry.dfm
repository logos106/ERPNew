inherited fmStockAdjustEntry: TfmStockAdjustEntry
  Left = 432
  Top = 178
  HelpContext = 616000
  Caption = 'Stock Adjustement'
  ClientHeight = 561
  ClientWidth = 953
  OldCreateOrder = True
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 959
  ExplicitHeight = 590
  DesignSize = (
    953
    561)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 451
    Width = 953
    HelpContext = 616006
    ExplicitTop = 448
    ExplicitWidth = 953
  end
  inherited imgGridWatermark: TImage
    Picture.Data = {00}
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 137
    Width = 953
    Height = 314
    HelpContext = 616026
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    object lblProgressbar: TLabel
      Left = 0
      Top = 278
      Width = 953
      Height = 15
      HelpContext = 616027
      Align = alBottom
      Alignment = taCenter
      Caption = 'To Account'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Visible = False
      ExplicitWidth = 58
    end
    object grdTransactions: TwwDBGrid
      Left = 17
      Top = 0
      Width = 919
      Height = 278
      HelpContext = 616029
      ControlType.Strings = (
        'ProductName;CustomEdit;cboProduct;F'
        'ClassName;CustomEdit;cboClass;F'
        'BinLocation;CustomEdit;cboBinLocation;F'
        'BinNumber;CustomEdit;cboBinNumber;F'
        'UOM;CustomEdit;cboUOM;F'
        'BatchNo;CustomEdit;cboBatchnumber;F'
        'JobName;CustomEdit;cboJob;F')
      Selected.Strings = (
        'ProductName'#9'10'#9'Product~Name'#9#9
        'Description'#9'10'#9'Description'#9#9
        'ClassName'#9'10'#9'Department'#9#9
        'UOM'#9'10'#9'UOM'#9#9
        'AvailableUOMQty'#9'10'#9'Available'#9#9
        'FinalUOMQty'#9'10'#9'Final'#9#9
        'FormulaQtyValue'#9'10'#9'FormulaQtyValue'#9#9
        'FormulaQtyValue1'#9'10'#9'FormulaQtyValue1'#9#9
        'FormulaQtyValue2'#9'10'#9'FormulaQtyValue2'#9#9
        'FormulaQtyValue3'#9'10'#9'FormulaQtyValue3'#9#9
        'FormulaQtyValue4'#9'10'#9'FormulaQtyValue4'#9#9
        'FormulaQtyValue5'#9'10'#9'FormulaQtyValue5'#9#9
        'AdjustUOMQty'#9'10'#9'Adjust'#9#9
        'BatchNo'#9'10'#9'Batch~No'#9#9
        'Expirydate'#9'10'#9'Expiry~Date'#9#9
        'BinLocation'#9'10'#9'Bin~Location'#9#9
        'BinNumber'#9'10'#9'Bin~Number'#9#9
        'SerialNumber'#9'10'#9'Serial~Number'#9#9
        'AllocationAvailableUOMQty'#9'10'#9'Available'#9#9
        'AllocationFinalUOMQty'#9'10'#9'Final'#9#9
        'AllocationAdjustUOMQty'#9'10'#9'Adjust'#9#9
        'Cost'#9'10'#9'Cost'#9#9
        'PartBarcode'#9'10'#9'Product Barcode'#9#9
        'ProductPrintName'#9'255'#9'ProductPrintName'#9#9
        'Notes'#9'20'#9'Notes'#9#9
        'ClassID'#9'10'#9'ClassID'#9'F'#9
        'JobName'#9'20'#9'JobName'#9'F'#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsStockAdjustEntryLines
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgAllowInsert]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgRowResize]
      ParentFont = False
      PopupMenu = popCustomiseGrid
      TabOrder = 4
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = True
      OnCalcCellColors = grdTransactionsCalcCellColors
      OnCalcTitleAttributes = grdTransactionsCalcTitleAttributes
      OnDblClick = grdTransactionsDblClick
      OnEnter = grdTransactionsEnter
      OnExit = grdTransactionsExit
      FooterColor = clWhite
      FooterCellColor = clWhite
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
      object btnDelete: TwwIButton
        Left = 0
        Top = 0
        Width = 22
        Height = 22
        HelpContext = 616030
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
        Layout = blGlyphBottom
      end
    end
    object ProgressBar: TProgressBar
      Left = 0
      Top = 293
      Width = 953
      Height = 21
      HelpContext = 616028
      Align = alBottom
      Smooth = True
      Step = 1
      TabOrder = 0
      Visible = False
    end
    object cboProduct: TERPDbLookupCombo
      Left = 23
      Top = 41
      Width = 109
      Height = 23
      HelpContext = 616003
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PARTNAME'#9'15'#9'Product Name'#9'F'
        'Manuf'#9'15'#9'Manuf'#9'F'
        'Type'#9'15'#9'Type'#9'F'
        'Dept'#9'15'#9'Dept'#9'F'
        'PartsDescription'#9'35'#9'Description'#9'F'
        'Active'#9'1'#9'Active'#9'F'
        'PreferedSupp'#9'20'#9'Preferred Supplier'#9'F'
        'SupplierProductCode'#9'20'#9'Supplier Product Code'#9'F')
      DataField = 'ProductName'
      DataSource = dsStockAdjustEntryLines
      LookupTable = cboProductQry
      LookupField = 'Partname'
      Options = [loTitles]
      AutoSelect = False
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      LookupFormClassName = 'TProductListExpressGUI'
      EditFormClassName = 'TfrmParts'
      LookupFormKeyStringFieldName = 'ProductName'
      LookupComboType = ctProduct
      AllowFullListSearchMode = False
      DisableNotInList = False
      AllowMultipleSelectFromList = True
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      LookupIDField = 'PartsID'
      LookupFieldAlt = 'ProductPrintName'
    end
    object cboClass: TwwDBLookupCombo
      Left = 23
      Top = 70
      Width = 109
      Height = 23
      HelpContext = 616004
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'ClassName'#9'60'#9'ClassName'#9#9)
      DataField = 'ClassName'
      DataSource = dsStockAdjustEntryLines
      LookupTable = cboClassQry
      LookupField = 'ClassName'
      Options = [loColLines, loTitles, loFixedDropDownHeight, loSearchOnBackspace]
      Style = csDropDownList
      DropDownWidth = 150
      ParentFont = False
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      OrderByDisplay = False
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboUOM: TwwDBLookupCombo
      Left = 23
      Top = 178
      Width = 109
      Height = 23
      HelpContext = 616005
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Unitname'#9'15'#9'Unitname'#9'F'
        'multiplier'#9'10'#9'multiplier'#9'F')
      DataField = 'UOM'
      DataSource = dsStockAdjustEntryLines
      LookupTable = QryUOM
      LookupField = 'Unitname'
      AutoSelect = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object DNMPanel3: TDNMPanel
      Left = 0
      Top = 0
      Width = 17
      Height = 278
      HelpContext = 616031
      Align = alLeft
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 5
    end
    object DNMPanel4: TDNMPanel
      Left = 936
      Top = 0
      Width = 17
      Height = 278
      HelpContext = 616032
      Align = alRight
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 6
    end
    object cboPrintProduct: TERPDbLookupCombo
      Left = 23
      Top = 128
      Width = 109
      Height = 23
      HelpContext = 616043
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PARTNAME'#9'15'#9'Product Name'#9'F'
        'Manuf'#9'15'#9'Manuf'#9'F'
        'Type'#9'15'#9'Type'#9'F'
        'Dept'#9'15'#9'Dept'#9'F'
        'PartsDescription'#9'35'#9'Description'#9'F'
        'Active'#9'1'#9'Active'#9'F'
        'PreferedSupp'#9'20'#9'Preferred Supplier'#9'F'
        'SupplierProductCode'#9'20'#9'Supplier Product Code'#9'F')
      DataField = 'ProductPrintName'
      DataSource = dsStockAdjustEntryLines
      LookupTable = cboProductQry
      LookupField = 'Partname'
      Options = [loTitles]
      AutoSelect = False
      ParentFont = False
      TabOrder = 7
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      LookupFormClassName = 'TProductListExpressGUI'
      EditFormClassName = 'TfrmParts'
      LookupFormKeyStringFieldName = 'ProductName'
      LookupComboType = ctProduct
      AllowFullListSearchMode = False
      DisableNotInList = False
      AllowMultipleSelectFromList = True
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      DataIDField = 'ProductId'
      LookupIDField = 'PartsID'
      LookupFieldAlt = 'ProductPrintName'
    end
    object cboJob: TwwDBLookupCombo
      Left = 361
      Top = 70
      Width = 109
      Height = 23
      HelpContext = 616004
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'30'#9'Company'#9'F'
        'PrintName'#9'30'#9'Print Name'#9'F'
        'JobNumber'#9'10'#9'Job Number'#9'F')
      DataField = 'JobName'
      DataSource = dsStockAdjustEntryLines
      LookupTable = qryJob
      LookupField = 'Company'
      Options = [loColLines, loTitles, loFixedDropDownHeight, loSearchOnBackspace]
      Style = csDropDownList
      DropDownWidth = 150
      ParentFont = False
      TabOrder = 8
      AutoDropDown = True
      ShowButton = True
      OrderByDisplay = False
      PreciseEditRegion = False
      AllowClearKey = False
    end
  end
  object DNMPanel5: TDNMPanel [6]
    Left = 0
    Top = 451
    Width = 953
    Height = 110
    HelpContext = 616033
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
    DesignSize = (
      953
      110)
    object lbMemo: TLabel
      Left = 14
      Top = 7
      Width = 54
      Height = 18
      HelpContext = 616034
      Anchors = [akLeft, akBottom]
      Caption = 'Reason'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblDeleted: TLabel
      Left = 902
      Top = 76
      Width = 44
      Height = 16
      HelpContext = 616035
      Alignment = taCenter
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = 'Deleted'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object btnCompleted: TDNMSpeedButton
      Left = 154
      Top = 82
      Width = 87
      Height = 27
      HelpContext = 616036
      Anchors = [akBottom]
      Caption = '&Hold'
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
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = btnCompletedClick
      OnEnter = btnCompletedEnter
    end
    object btnImport: TDNMSpeedButton
      Left = 290
      Top = 82
      Width = 87
      Height = 27
      HelpContext = 616037
      Anchors = [akBottom]
      Caption = '&Import'
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
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = btnImportClick
    end
    object btnExport: TDNMSpeedButton
      Left = 426
      Top = 82
      Width = 87
      Height = 27
      HelpContext = 616038
      Anchors = [akBottom]
      Caption = 'E&xport'
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
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = btnExportClick
    end
    object btnPrint: TDNMSpeedButton
      Left = 563
      Top = 82
      Width = 87
      Height = 27
      HelpContext = 616039
      Anchors = [akBottom]
      Caption = 'Prin&t'
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
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      AutoDisableParentOnclick = True
      OnClick = btnPrintClick
    end
    object btnClose: TDNMSpeedButton
      Left = 700
      Top = 82
      Width = 87
      Height = 27
      HelpContext = 616040
      Anchors = [akBottom]
      Caption = '&Cancel'
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
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = btnCloseClick
    end
    object edtReason: TDBMemo
      Left = 14
      Top = 29
      Width = 931
      Height = 43
      HelpContext = 616041
      Anchors = [akLeft, akRight, akBottom]
      DataField = 'Notes'
      DataSource = dsStockAdjustEntry
      ScrollBars = ssVertical
      TabOrder = 5
      OnEnter = OverrideAccessLevel
      OnExit = Setaccesslevel
    end
    object chkDeleted: TwwCheckBox
      Left = 917
      Top = 94
      Width = 13
      Height = 16
      HelpContext = 616042
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
      Anchors = [akRight, akBottom]
      DataField = 'Deleted'
      DataSource = dsStockAdjustEntry
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = chkDeletedClick
      OnEnter = chkDeletedEnter
      OnExit = Setaccesslevel
    end
    object chkApproved: TwwCheckBox
      Left = 17
      Top = 84
      Width = 81
      Height = 17
      HelpContext = 616044
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
      Anchors = [akLeft, akBottom]
      Caption = 'Approved'
      DataField = 'Approved'
      DataSource = dsStockAdjustEntry
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      OnClick = chkApprovedClick
    end
  end
  object DNMPanel1: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 953
    Height = 137
    HelpContext = 616007
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
    DesignSize = (
      953
      137)
    object Bevel1: TBevel
      Left = 16
      Top = 69
      Width = 619
      Height = 59
      HelpContext = 616008
      Shape = bsFrame
    end
    object Label160: TLabel
      Left = 832
      Top = 28
      Width = 25
      Height = 18
      HelpContext = 616009
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'No.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label1: TLabel
      Left = 22
      Top = 82
      Width = 78
      Height = 18
      HelpContext = 616010
      Caption = 'To Account'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label48: TLabel
      Left = 205
      Top = 82
      Width = 76
      Height = 18
      HelpContext = 616011
      AutoSize = False
      Caption = 'Employee'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblStockDate: TLabel
      Left = 443
      Top = 82
      Width = 33
      Height = 18
      HelpContext = 616012
      Caption = 'Date'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel2: TBevel
      Left = 641
      Top = 69
      Width = 210
      Height = 59
      HelpContext = 616013
      Shape = bsFrame
    end
    object lblEnforceUOM: TLabel
      Left = 632
      Top = 79
      Width = 194
      Height = 16
      Hint = 
        'When Ticked this is only showing the Quantity of the selected Un' +
        'it of Measure. Its not displaying the Quantity any other Unit of' +
        ' Measure  for this product'
      HelpContext = 616014
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Show only as Unit of Measure'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblAdjustmentOnInstock: TLabel
      Left = 632
      Top = 103
      Width = 194
      Height = 16
      HelpContext = 616015
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Adjustment on In-Stock Quantity'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblprocessed: TLabel
      Left = 734
      Top = 19
      Width = 82
      Height = 19
      HelpContext = 616016
      Caption = 'Processed'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object pnlTitle: TDNMPanel
      Left = 223
      Top = 3
      Width = 498
      Height = 40
      HelpContext = 616017
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
        Width = 494
        Height = 36
        HelpContext = 616018
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
          Width = 494
          Height = 36
          HelpContext = 616019
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Stock Adjustment'
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
    object txtCustomID: TDBEdit
      Left = 861
      Top = 23
      Width = 78
      Height = 23
      HelpContext = 616020
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object cboAccount: TwwDBLookupCombo
      Left = 21
      Top = 99
      Width = 178
      Height = 23
      HelpContext = 616021
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'25'#9'Account Name'#9'F'
        'AccountType'#9'20'#9'Account Type'#9'F')
      DataField = 'AccountID'
      DataSource = dsStockAdjustEntry
      LookupTable = cboAccountQry
      LookupField = 'AccountID'
      Options = [loTitles]
      ParentFont = False
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboEmployee: TwwDBLookupCombo
      Left = 205
      Top = 99
      Width = 208
      Height = 23
      HelpContext = 616022
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      DataField = 'Employee'
      DataSource = dsStockAdjustEntry
      LookupTable = cboEmployeeLookup
      LookupField = 'EmployeeName'
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object btnToggleMode: TDNMSpeedButton
      Left = 853
      Top = 99
      Width = 81
      Height = 23
      HelpContext = 616001
      Caption = 'Tree Mode'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 4
      AutoDisableParentOnclick = True
    end
    object cboDBStockDate: TwwDBDateTimePicker
      Left = 442
      Top = 99
      Width = 184
      Height = 23
      HelpContext = 616023
      AutoFillDateAndTime = True
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      CalendarAttributes.PopupYearOptions.NumberColumns = 4
      DataField = 'AdjustmentDate'
      DataSource = dsStockAdjustEntry
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 5
      OnEnter = chkEnforceUOMEnter
      OnExit = Setaccesslevel
    end
    object chkEnforceUOM: TwwCheckBox
      Left = 831
      Top = 78
      Width = 13
      Height = 16
      HelpContext = 616024
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
      DataField = 'EnforceUOM'
      DataSource = dsStockAdjustEntry
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = chkEnforceUOMClick
      OnEnter = chkEnforceUOMEnter
      OnExit = Setaccesslevel
    end
    object chkAdjustmentOnInstock: TwwCheckBox
      Left = 831
      Top = 102
      Width = 13
      Height = 16
      HelpContext = 616025
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
      DataField = 'AdjustmentOnInstock'
      DataSource = dsStockAdjustEntry
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnExit = Setaccesslevel
    end
  end
  inherited popSpelling: TPopupMenu
    Top = 8
  end
  inherited tmrdelayMsg: TTimer
    Top = 0
  end
  inherited dlgReportSelect: TSelectionDialog
    Top = 8
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 18
    Top = 15
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Top = 8
    inherited CustomiseGrid: TMenuItem
      Visible = False
    end
    object DefaultOrder1: TMenuItem
      Caption = 'Default Order'
      HelpContext = 616045
      OnClick = DefaultOrder1Click
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C01010200A000480110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 226
    Top = 65528
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Top = 8
  end
  inherited qryMemTrans: TERPQuery
    Top = 24
  end
  object qryStockAdjustEntry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblstockadjustEntry'
      'Where StockAdjustEntryID= :ID')
    Left = 202
    Top = 276
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object qryStockAdjustEntryGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryStockAdjustEntryStockAdjustEntryID: TIntegerField
      FieldName = 'StockAdjustEntryID'
    end
    object qryStockAdjustEntryCreationDate: TDateField
      FieldName = 'CreationDate'
    end
    object qryStockAdjustEntryAccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object qryStockAdjustEntryAccountname: TWideStringField
      FieldName = 'Accountname'
      Size = 100
    end
    object qryStockAdjustEntryNotes: TWideMemoField
      FieldName = 'Notes'
      BlobType = ftWideMemo
    end
    object qryStockAdjustEntryIsStocktake: TWideStringField
      FieldName = 'IsStocktake'
      FixedChar = True
      Size = 1
    end
    object qryStockAdjustEntryEmployee: TWideStringField
      FieldName = 'Employee'
      Size = 255
    end
    object qryStockAdjustEntryDeleted: TWideStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
    object qryStockAdjustEntrymsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryStockAdjustEntryAdjustmentdate: TDateTimeField
      FieldName = 'Adjustmentdate'
    end
    object qryStockAdjustEntryEnforceUOM: TWideStringField
      FieldName = 'EnforceUOM'
      FixedChar = True
      Size = 1
    end
    object qryStockAdjustEntryAdjustmentOnInstock: TWideStringField
      FieldName = 'AdjustmentOnInstock'
      OnChange = qryStockAdjustEntryAdjustmentOnInstockChange
      FixedChar = True
      Size = 1
    end
    object qryStockAdjustEntryImportgroupOriginalno: TWideStringField
      FieldName = 'ImportgroupOriginalno'
      Size = 255
    end
    object qryStockAdjustEntryApproved: TWideStringField
      FieldName = 'Approved'
      FixedChar = True
      Size = 1
    end
  end
  object dsStockAdjustEntry: TDataSource
    DataSet = qryStockAdjustEntry
    Left = 98
    Top = 369
  end
  object qryStockAdjustEntryLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM  tblstockadjustentryLines'
      'WHERE StockAdjustEntryID=:ID')
    Left = 591
    Top = 164
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object qryStockAdjustEntryLinesProductName: TWideStringField
      DisplayLabel = 'Product~Name'
      DisplayWidth = 10
      FieldName = 'ProductName'
      Origin = 'tblstockadjustentrylines.ProductName'
      Size = 255
    end
    object qryStockAdjustEntryLinesDescription: TWideStringField
      DisplayWidth = 10
      FieldName = 'Description'
      Origin = 'tblstockadjustentrylines.Description'
      Size = 255
    end
    object qryStockAdjustEntryLinesClassName: TWideStringField
      DisplayLabel = 'Department'
      DisplayWidth = 10
      FieldName = 'ClassName'
      Origin = 'tblstockadjustentrylines.ClassName'
      Size = 255
    end
    object qryStockAdjustEntryLinesUOM: TWideStringField
      DisplayWidth = 10
      FieldName = 'UOM'
      Origin = 'tblstockadjustentrylines.UOM'
      Size = 50
    end
    object qryStockAdjustEntryLinesAvailableUOMQty: TFloatField
      DisplayLabel = 'Available'
      DisplayWidth = 10
      FieldName = 'AvailableUOMQty'
      Origin = 'tblstockadjustentrylines.AvailableUOMQty'
      DisplayFormat = '########0.0####'
    end
    object qryStockAdjustEntryLinesFinalUOMQty: TFloatField
      DisplayLabel = 'Final'
      DisplayWidth = 10
      FieldName = 'FinalUOMQty'
      Origin = 'tblstockadjustentrylines.FinalUOMQty'
      DisplayFormat = '########0.0####'
    end
    object qryStockAdjustEntryLinesFormulaQtyValue: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue'
      Origin = 'tblstockadjustentrylines.FormulaQtyValue'
    end
    object qryStockAdjustEntryLinesFormulaQtyValue1: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue1'
      Origin = 'tblstockadjustentrylines.FormulaQtyValue1'
    end
    object qryStockAdjustEntryLinesFormulaQtyValue2: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue2'
      Origin = 'tblstockadjustentrylines.FormulaQtyValue2'
    end
    object qryStockAdjustEntryLinesFormulaQtyValue3: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue3'
      Origin = 'tblstockadjustentrylines.FormulaQtyValue3'
    end
    object qryStockAdjustEntryLinesFormulaQtyValue4: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue4'
      Origin = 'tblstockadjustentrylines.FormulaQtyValue4'
    end
    object qryStockAdjustEntryLinesFormulaQtyValue5: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue5'
      Origin = 'tblstockadjustentrylines.FormulaQtyValue5'
    end
    object qryStockAdjustEntryLinesAdjustUOMQty: TFloatField
      DisplayLabel = 'Adjust'
      DisplayWidth = 10
      FieldName = 'AdjustUOMQty'
      Origin = 'tblstockadjustentrylines.AdjustUOMQty'
      OnChange = qryStockAdjustEntryLinesAdjustUOMQtyChange
      DisplayFormat = '########0.0####'
    end
    object qryStockAdjustEntryLinesBatchNo: TWideStringField
      DisplayLabel = 'Batch~No'
      DisplayWidth = 10
      FieldName = 'BatchNo'
      Origin = 'tblstockadjustentrylines.BatchNo'
      Size = 50
    end
    object qryStockAdjustEntryLinesExpirydate: TDateTimeField
      DisplayLabel = 'Expiry~Date'
      DisplayWidth = 10
      FieldName = 'Expirydate'
      Origin = 'tblstockadjustentrylines.Expirydate'
    end
    object qryStockAdjustEntryLinesBinLocation: TWideStringField
      DisplayLabel = 'Bin~Location'
      DisplayWidth = 10
      FieldName = 'BinLocation'
      Origin = 'tblstockadjustentrylines.BinLocation'
      Size = 255
    end
    object qryStockAdjustEntryLinesBinNumber: TWideStringField
      DisplayLabel = 'Bin~Number'
      DisplayWidth = 10
      FieldName = 'BinNumber'
      Origin = 'tblstockadjustentrylines.BinNumber'
      Size = 255
    end
    object qryStockAdjustEntryLinesSerialNumber: TWideStringField
      DisplayLabel = 'Serial~Number'
      DisplayWidth = 10
      FieldName = 'SerialNumber'
      Origin = 'tblstockadjustentrylines.SerialNumber'
      Size = 50
    end
    object qryStockAdjustEntryLinesAllocationAvailableUOMQty: TFloatField
      DisplayLabel = 'Available'
      DisplayWidth = 10
      FieldName = 'AllocationAvailableUOMQty'
      Origin = 'tblstockadjustentrylines.AllocationAvailableUOMQty'
      DisplayFormat = '########0.0####'
    end
    object qryStockAdjustEntryLinesAllocationFinalUOMQty: TFloatField
      DisplayLabel = 'Final'
      DisplayWidth = 10
      FieldName = 'AllocationFinalUOMQty'
      Origin = 'tblstockadjustentrylines.AllocationFinalUOMQty'
      DisplayFormat = '########0.0####'
    end
    object qryStockAdjustEntryLinesAllocationAdjustUOMQty: TFloatField
      DisplayLabel = 'Adjust'
      DisplayWidth = 10
      FieldName = 'AllocationAdjustUOMQty'
      Origin = 'tblstockadjustentrylines.AllocationAdjustUOMQty'
      DisplayFormat = '########0.0####'
    end
    object qryStockAdjustEntryLinesCost: TFloatField
      DisplayWidth = 10
      FieldName = 'Cost'
      Origin = 'tblstockadjustentrylines.Cost'
    end
    object qryStockAdjustEntryLinesPartBarcode: TWideStringField
      DisplayLabel = 'Product Barcode'
      DisplayWidth = 10
      FieldName = 'PartBarcode'
      Origin = 'tblstockadjustentrylines.PartBarcode'
      Size = 255
    end
    object qryStockAdjustEntryLinesProductPrintName: TWideStringField
      DisplayWidth = 255
      FieldName = 'ProductPrintName'
      Origin = 'tblstockadjustentrylines.ProductPrintName'
      Size = 255
    end
    object qryStockAdjustEntryLinesNotes: TWideStringField
      DisplayWidth = 20
      FieldName = 'Notes'
      Origin = 'tblstockadjustentrylines.Notes'
      Size = 255
    end
    object qryStockAdjustEntryLinesClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
    end
    object qryStockAdjustEntryLinesJobName: TWideStringField
      DisplayWidth = 20
      FieldName = 'JobName'
      Origin = 'tblstockadjustentrylines.JobName'
      Size = 50
    end
    object qryStockAdjustEntryLinesGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblstockadjustentrylines.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryStockAdjustEntryLinesStockAdjustEntryLinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'StockAdjustEntryLinesID'
      Origin = 'tblstockadjustentrylines.StockAdjustEntryLinesID'
      Visible = False
    end
    object qryStockAdjustEntryLinesStockAdjustEntryID: TIntegerField
      DisplayWidth = 10
      FieldName = 'StockAdjustEntryID'
      Origin = 'tblstockadjustentrylines.StockAdjustEntryID'
      Visible = False
    end
    object qryStockAdjustEntryLinesProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'tblstockadjustentrylines.ProductID'
      Visible = False
    end
    object qryStockAdjustEntryLinesAvailableQty: TFloatField
      DisplayWidth = 10
      FieldName = 'AvailableQty'
      Origin = 'tblstockadjustentrylines.AvailableQty'
      Visible = False
      DisplayFormat = '########0.0####'
    end
    object qryStockAdjustEntryLinesFinalQty: TFloatField
      DisplayWidth = 10
      FieldName = 'FinalQty'
      Origin = 'tblstockadjustentrylines.FinalQty'
      Visible = False
      DisplayFormat = '########0.0####'
    end
    object qryStockAdjustEntryLinesAdjustQty: TFloatField
      DisplayWidth = 10
      FieldName = 'AdjustQty'
      Origin = 'tblstockadjustentrylines.AdjustQty'
      Visible = False
      DisplayFormat = '########0.0####'
    end
    object qryStockAdjustEntryLinesAllocationAvailableQty: TFloatField
      DisplayWidth = 10
      FieldName = 'AllocationAvailableQty'
      Origin = 'tblstockadjustentrylines.AllocationAvailableQty'
      Visible = False
      DisplayFormat = '########0.0####'
    end
    object qryStockAdjustEntryLinesAllocationFinalqty: TFloatField
      DisplayWidth = 10
      FieldName = 'AllocationFinalqty'
      Origin = 'tblstockadjustentrylines.AllocationFinalqty'
      Visible = False
      DisplayFormat = '########0.0####'
    end
    object qryStockAdjustEntryLinesAllocationAdjustQty: TFloatField
      DisplayWidth = 10
      FieldName = 'AllocationAdjustQty'
      Origin = 'tblstockadjustentrylines.AllocationAdjustQty'
      Visible = False
      DisplayFormat = '########0.0####'
    end
    object qryStockAdjustEntryLinesUOMMultiplier: TFloatField
      DisplayWidth = 10
      FieldName = 'UOMMultiplier'
      Origin = 'tblstockadjustentrylines.UOMMultiplier'
      Visible = False
    end
    object qryStockAdjustEntryLinesDeleted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Origin = 'tblstockadjustentrylines.Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryStockAdjustEntryLinesUOMID: TIntegerField
      DisplayWidth = 10
      FieldName = 'UOMID'
      Origin = 'tblstockadjustentrylines.UOMID'
      Visible = False
    end
    object qryStockAdjustEntryLinesmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblstockadjustentrylines.msTimeStamp'
      Visible = False
    end
    object qryStockAdjustEntryLinesInStockUOMQty: TFloatField
      FieldName = 'InStockUOMQty'
      Origin = 'tblstockadjustentrylines.InStockUOMQty'
      Visible = False
      DisplayFormat = '########0.0####'
    end
    object qryStockAdjustEntryLinesJobID: TIntegerField
      DisplayWidth = 10
      FieldName = 'JobID'
      Origin = 'tblstockadjustentrylines.JobID'
      Visible = False
    end
  end
  object dsStockAdjustEntryLines: TDataSource
    DataSet = qryStockAdjustEntryLines
    Left = 598
    Top = 273
  end
  object cboProductQry: TERPQuery
    SQL.Strings = (
      'SELECT'
      'if((LOCATE('#39'^'#39',PRODUCTGROUP,InStr(PRODUCTGROUP,'#39'^'#39')+1)) >0,'
      'MID(PRODUCTGROUP,LOCATE('#39'^'#39',PRODUCTGROUP,'
      'InStr(PRODUCTGROUP,'#39'^'#39')+1)+1,char_length(PRODUCTGROUP)-'
      
        'LOCATE('#39'^'#39',PRODUCTGROUP,InStr(PRODUCTGROUP,'#39'^'#39')+1)),  Null)  AS ' +
        #39'Manuf'#39' ,'
      'MID(PRODUCTGROUP, InStr(PRODUCTGROUP,'#39'^'#39')+1 ,'
      'If(LOCATE('#39'^'#39',PRODUCTGROUP,'
      'InStr(PRODUCTGROUP,'#39'^'#39')+1) - InStr(PRODUCTGROUP,'#39'^'#39') >0,'
      'LOCATE('#39'^'#39',PRODUCTGROUP,'
      'InStr(PRODUCTGROUP,'#39'^'#39')+1)-1 - InStr(PRODUCTGROUP,'#39'^'#39'),'
      'IF(InStr(PRODUCTGROUP,'#39'^'#39')<>0,'
      
        'char_length(PRODUCTGROUP) - InStr(PRODUCTGROUP,'#39'^'#39'),0))) AS '#39'Typ' +
        'e'#39' ,'
      'If(InStr(PRODUCTGROUP,'#39'^'#39') -1 >0,'
      'Left(PRODUCTGROUP,InStr(PRODUCTGROUP,'#39'^'#39')-1),'
      'PRODUCTGROUP) AS '#39'Dept'#39' ,'
      'PARTSID,PARTTYPE, PRODUCTGROUP,PARTNAME,'
      'PARTSDESCRIPTION,ASSETACCNT, AvgCost,Cost1, Active,SNTracking'
      'FROM tblparts WHERE Active = '#39'T'#39' '
      'AND (PARTTYPE='#39'INV'#39' OR PARTTYPE='#39'GRP'#39' OR PARTTYPE='#39'MANUF'#39')'
      
        '#AND ((ifnull(Multiplebins,"F") = "T" or ifnull(BATCH,"F") = "T"' +
        ' or ifnull(SNTRacking,"F") ="T"))'
      'ORDER BY PARTNAME')
    Options.LongStrings = False
    Left = 294
    Top = 239
  end
  object cboClassQry: TERPQuery
    SQL.Strings = (
      'SELECT ClassID, ClassName'
      'FROM tblClass  '
      'WHERE ClassName Is Not Null And Active='#39'T'#39
      'ORDER BY ClassName; ')
    Options.LongStrings = False
    Left = 190
    Top = 210
  end
  object QryUOM: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      '/*SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND (ifnull(U.PartID,0) = :KeyId or U.Part' +
        'ID = 0) '
      'Group By U.UnitName '
      'Order By U.UnitName , UnitID desc'
      '*/'
      'SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = :KeyId'
      'union all '
      'SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = 0 and Unitname no' +
        't  in (Select unitname from  tblunitsofmeasure where  ifnull(Par' +
        'tID,0) = :KeyId )'
      'Order By UnitID desc ,UnitName;')
    Options.LongStrings = False
    Left = 156
    Top = 270
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
    object QryUOMUnitname: TWideStringField
      DisplayWidth = 15
      FieldName = 'Unitname'
      Size = 15
    end
    object QryUOMmultiplier: TFloatField
      DisplayWidth = 10
      FieldName = 'multiplier'
    end
    object QryUOMUnitId: TIntegerField
      FieldName = 'UnitId'
      Visible = False
    end
  end
  object cboAccountQry: TERPQuery
    SQL.Strings = (
      
        'SELECT AccountID, AccountName, AccDesc,AccountType, Description,' +
        ' AccountNumber, Taxcode, BankNumber, Extra, Active, Class, AllCl' +
        'asses, OpeningBalance, Debits, Credits, ClosingBalance, AccountG' +
        'roup  '
      'FROM tblchartofaccounts'
      'Left Join tblacctypedesc on  AccType = AccountType'
      'WHERE Active = '#39'T'#39' AND AccType<>'#39'NONPOSTING'#39' AND Isheader = '#39'F'#39
      'Order By AccDesc,AccountName;')
    Options.LongStrings = False
    Left = 174
    Top = 26
  end
  object cboEmployeeLookup: TERPQuery
    SQL.Strings = (
      
        'SELECT tblEmployees.EmployeeID, Concat(firstname,'#39' '#39',Lastname) A' +
        'S EmployeeName '
      'FROM tblEmployees '
      'WHERE (((tblEmployees.Active)<>'#39'F'#39')) '
      'ORDER BY Concat(firstname,'#39' '#39',Lastname);')
    Options.LongStrings = False
    Left = 253
    Top = 158
  end
  object qryJob: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClientID AS JobId, Company, PrintName, JobNumber, JobName'
      #9'FROM tblClients'
      #9'WHERE IsJob = "T"'
      #9'ORDER BY Company')
    AfterInsert = qryJobAfterInsert
    Left = 464
    Top = 280
    object qryJobCompany: TWideStringField
      DisplayWidth = 30
      FieldName = 'Company'
      Size = 160
    end
    object qryJobPrintName: TWideStringField
      DisplayLabel = 'Print Name'
      DisplayWidth = 30
      FieldName = 'PrintName'
      Size = 255
    end
    object qryJobJobNumber: TIntegerField
      DisplayLabel = 'Job Number'
      DisplayWidth = 10
      FieldName = 'JobNumber'
    end
    object qryJobJobId: TIntegerField
      DisplayWidth = 10
      FieldName = 'JobId'
      Visible = False
    end
    object qryJobJobName: TWideStringField
      DisplayWidth = 255
      FieldName = 'JobName'
      Visible = False
      Size = 255
    end
  end
end
