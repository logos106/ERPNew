inherited fmHire: TfmHire
  Left = 266
  Top = 363
  HelpContext = 1330002
  Caption = 'Hire'
  ClientHeight = 565
  ClientWidth = 996
  ExplicitLeft = 266
  ExplicitTop = 363
  ExplicitWidth = 1012
  ExplicitHeight = 604
  DesignSize = (
    996
    565)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 565
    Width = 996
    HelpContext = 1330003
    ExplicitTop = 223
    ExplicitWidth = 455
  end
  inherited shapehint: TShape
    Left = 126
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
    Left = 266
    Top = 10
    ExplicitLeft = 113
    ExplicitTop = 10
  end
  object DNMPanel4: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 996
    Height = 565
    HelpContext = 1330004
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 355
      Width = 994
      Height = 5
      Cursor = crVSplit
      HelpContext = 1330088
      Align = alBottom
      Beveled = True
      ExplicitTop = 329
    end
    object DNMPanel6: TDNMPanel
      Left = 1
      Top = 510
      Width = 994
      Height = 54
      HelpContext = 1330005
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      DesignSize = (
        994
        54)
      object Bevel4: TBevel
        Left = 516
        Top = 1
        Width = 477
        Height = 52
        HelpContext = 1330006
        Align = alRight
        ExplicitLeft = 520
      end
      object Label3: TLabel
        AlignWithMargins = True
        Left = 597
        Top = 6
        Width = 68
        Height = 16
        HelpContext = 1330007
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        Alignment = taRightJustify
        Anchors = [akRight, akBottom]
        Caption = 'Sales Total'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Label7: TLabel
        AlignWithMargins = True
        Left = 758
        Top = 6
        Width = 60
        Height = 16
        HelpContext = 1330008
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        Alignment = taRightJustify
        Anchors = [akRight, akBottom]
        Caption = 'Hire Total'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Label8: TLabel
        AlignWithMargins = True
        Left = 949
        Top = 3
        Width = 41
        Height = 18
        HelpContext = 1330009
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        Alignment = taRightJustify
        Anchors = [akRight, akBottom]
        Caption = 'Total '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Bevel2: TBevel
        Left = 1
        Top = 1
        Width = 356
        Height = 52
        HelpContext = 1330010
        Align = alLeft
      end
      object Label4: TLabel
        Left = 5
        Top = 6
        Width = 33
        Height = 15
        HelpContext = 1330011
        Caption = 'Notes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label48: TLabel
        Left = 412
        Top = 6
        Width = 55
        Height = 15
        HelpContext = 1330012
        Alignment = taRightJustify
        Caption = 'Employee'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object DBEdit4: TDBEdit
        Left = 520
        Top = 24
        Width = 147
        Height = 24
        HelpContext = 1330013
        Margins.Top = 10
        Margins.Bottom = 10
        TabStop = False
        Anchors = [akRight, akBottom]
        DataField = 'SalesTotal'
        DataSource = dsHire
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
      object DBEdit3: TDBEdit
        Left = 673
        Top = 24
        Width = 147
        Height = 24
        HelpContext = 1330014
        Margins.Top = 10
        Margins.Bottom = 10
        TabStop = False
        Anchors = [akRight, akBottom]
        DataField = 'Hiretotal'
        DataSource = dsHire
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
      object DBEdit5: TDBEdit
        Left = 826
        Top = 22
        Width = 164
        Height = 27
        HelpContext = 1330015
        Margins.Top = 10
        Margins.Bottom = 10
        TabStop = False
        Anchors = [akRight, akBottom]
        DataField = 'Totalamount'
        DataSource = dsHire
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
      end
      object txtNotes: TAddictSpellDBMemo
        Left = 105
        Top = 6
        Width = 301
        Height = 42
        HelpContext = 1330016
        DataField = 'Notes'
        DataSource = dsHire
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object cboEmployee: TwwDBLookupCombo
        Left = 412
        Top = 24
        Width = 98
        Height = 23
        HelpContext = 1330017
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'EmployeeName'#9'25'#9'EmployeeName'#9'F')
        DataField = 'employeeName'
        DataSource = dsHire
        LookupTable = cboEmployeeLookup
        LookupField = 'EmployeeName'
        DropDownWidth = 300
        ParentFont = False
        TabOrder = 1
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = True
      end
      object btnAttachments: TDNMSpeedButton
        Left = 3
        Top = 27
        Width = 96
        Height = 22
        HelpContext = 1330095
        Alignment = taLeftJustify
        Caption = 'Attachments'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500000000000
          000557777777777777750BBBBBBBBBBBBBB07F5555FFFFFFF5570BBBB0000000
          BBB07F5557777777FF570BBB077BBB770BB07F557755555775570BBBBBBBBBBB
          BBB07F5555FFFFFFF5570BBBB0000000BBB07F5557777777F5570BBBB0FFFFF0
          BBB07F5557FFFFF7F5570BBBB0000000BBB07F555777777755570BBBBBBBBBBB
          BBB07FFFFFFFFFFFFFF700000000000000007777777777777777500FFFFFFFFF
          F005577FF555FFFFF7755500FFF00000005555775FF7777777F5550F777FFFFF
          F055557F777FFF5557F5550000000FFF00555577777775FF77F5550777777000
          7055557FFFFFF777F7F555000000000000555577777777777755}
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 5
        OnClick = btnAttachmentsClick
      end
    end
    object pnlHireEquipments: TDNMPanel
      Left = 1
      Top = 193
      Width = 994
      Height = 162
      HelpContext = 1330018
      Align = alClient
      Constraints.MinHeight = 20
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label6: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 101
        Height = 15
        HelpContext = 1330019
        Margins.Right = 888
        Align = alTop
        Caption = 'Hiring Items'
        ExplicitWidth = 68
      end
      object grdHireEquipments: TwwDBGrid
        Left = 1
        Top = 22
        Width = 992
        Height = 139
        HelpContext = 1330020
        ControlType.Strings = (
          'EmployeeName;CustomEdit;cboLinesEmployee;F'
          'EquipmentName;CustomEdit;cboEquipment;F'
          'Status;CustomEdit;cboStatus;F'
          'Converted;CheckBox;T;F'
          'LineTaxCode;CustomEdit;cboTax;F'
          'DurationName;CustomEdit;cboDurationName;F'
          'HireFrom;CustomEdit;dtHireFrom;F'
          'HireTo;CustomEdit;dtHireTo;F'
          'ActualHireFrom;CustomEdit;dtActualHireFrom;F'
          'ActualHireTo;CustomEdit;dtActualHireTo;F'
          'AssetProductName;CustomEdit;cboProduct;F'
          'AssetName;CustomEdit;cboAsset;F')
        Selected.Strings = (
          'AssetName'#9'20'#9'Item'#9'F'
          'HireQty'#9'6'#9'HireQty'#9'F'
          'AssetCode'#9'10'#9'Code'#9'F'
          'HireFrom'#9'10'#9'From'#9'F'#9'Quoted Period'
          'HireTo'#9'10'#9'To'#9'F'#9'Quoted Period'
          'Status'#9'10'#9'Status'#9#9
          'DurationName'#9'10'#9'Name'#9'F'#9'Duration'
          'DurationQty'#9'6'#9'Qty'#9'T'#9'Duration'
          'DurationRate'#9'10'#9'Rate'#9'F'#9'Duration'
          'ActualHireFrom'#9'10'#9'From'#9'F'#9'Actual Period'
          'ActualHireTo'#9'10'#9'To'#9'F'#9'Actual Period'
          'PriceEx'#9'10'#9'Price (Ex)'#9#9
          'LineTaxCode'#9'10'#9'Tax Code'#9#9
          'LineAmount'#9'12'#9'Amount (Ex)'#9#9
          'EmployeeName'#9'11'#9'Employee'#9#9
          'Converted'#9'1'#9'Converted'#9'T'
          'SalesDescription'#9'50'#9'SalesDescription'#9'F')
        MemoAttributes = [mSizeable, mWordWrap, mGridShow]
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        Align = alClient
        DataSource = dsHireLines
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = [dgAllowInsert]
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgRowResize]
        ParentFont = False
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 2
        TitleButtons = True
        UseTFields = False
        OnTitleButtonClick = grdHireEquipmentsTitleButtonClick
        OnColEnter = grdHireEquipmentsColEnter
        OnDblClick = grdHireEquipmentsDblClick
        OnEnter = grdHireEquipmentsEnter
        OnExit = grdHireEquipmentsExit
        OnMouseUp = grdHireEquipmentsMouseUp
        FooterColor = clWhite
        FooterCellColor = clWhite
        PaintOptions.BackgroundOptions = [coBlendFixedRow]
        object btnDelete: TwwIButton
          Left = -1
          Top = 0
          Width = 22
          Height = 33
          HelpContext = 1330021
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
          OnClick = btnDeleteClick
        end
      end
      object cboAsset: TERPDbLookupCombo
        Left = 245
        Top = 61
        Width = 80
        Height = 23
        HelpContext = 1330023
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AssetName'#9'30'#9'Asset Name'#9'F'
          'AssetCode'#9'20'#9'Asset Code'#9'F')
        DataField = 'AssetName'
        DataSource = dsHireLines
        LookupTable = cboAssetLookup
        LookupField = 'AssetName'
        Options = [loTitles]
        AutoSelect = False
        ParentFont = False
        TabOrder = 1
        AutoDropDown = True
        ShowButton = True
        UseTFields = False
        PreciseEditRegion = False
        AllowClearKey = False
        OnDblClick = cboAssetDblClick
        OnCloseUp = cboAssetCloseUp
        LookupFormClassName = 'TFixedAssetsListGUI'
        LookupFormKeyStringFieldName = 'AssetName'
        LookupComboType = ctNone
        AllowFullListSearchMode = False
        OnBeforeOpenList = cboAssetBeforeOpenList
        onDoGridDataSelect = cboAssetDoGridDataSelect
        DisableNotInList = False
        AllowMultipleSelectFromList = True
        OpenListinF6WhenNotinList = False
        DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      end
      object cboLinesEmployee: TwwDBLookupCombo
        Left = 437
        Top = 69
        Width = 80
        Height = 23
        HelpContext = 1330024
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'EmployeeName'#9'25'#9'EmployeeName'#9'F')
        DataField = 'EmployeeName'
        DataSource = dsHireLines
        LookupTable = cboLinesEmployeeLookup
        LookupField = 'EmployeeName'
        DropDownWidth = 300
        ParentFont = False
        TabOrder = 2
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = True
      end
      object cboStatus: TwwDBComboBox
        Left = 544
        Top = 69
        Width = 80
        Height = 23
        HelpContext = 1330025
        ShowButton = True
        Style = csDropDown
        MapList = True
        AllowClearKey = False
        DataField = 'Status'
        DataSource = dsHireLines
        DropDownCount = 8
        ItemHeight = 0
        Items.Strings = (
          'Ordered'#9'O'
          'Picked'#9'P'
          'Returned'#9'R'
          'Awaiting Pick Up'#9'A'
          'Off Hire'#9'N')
        Sorted = False
        TabOrder = 3
        UnboundDataType = wwDefault
      end
      object cboDurationName: TwwDBLookupCombo
        Left = 652
        Top = 77
        Width = 80
        Height = 23
        HelpContext = 1330026
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'DurationName'#9'15'#9'DurationName'#9'F'
          'Duration'#9'15'#9'Duration'#9'F'
          'Rate'#9'10'#9'Rate'#9'F')
        DataField = 'DurationName'
        DataSource = dsHireLines
        LookupTable = QryDurationRates
        LookupField = 'DurationName'
        DropDownWidth = 300
        ParentFont = False
        TabOrder = 4
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = True
        OnCloseUp = cboDurationNameCloseUp
      end
      object cboTax: TwwDBLookupCombo
        Left = 369
        Top = 91
        Width = 80
        Height = 23
        HelpContext = 1330027
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Name'#9'5'#9'Name'#9'F'
          'Rate'#9'5'#9'Rate'#9'F')
        DataField = 'LineTaxCode'
        DataSource = dsHireLines
        LookupTable = QryTax
        LookupField = 'Name'
        TabOrder = 5
        AutoDropDown = False
        ShowButton = True
        UseTFields = False
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object dtHireFrom: TwwDBDateTimePicker
        Left = 512
        Top = 112
        Width = 107
        Height = 23
        HelpContext = 1330028
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'Tahoma'
        CalendarAttributes.Font.Style = []
        DataField = 'HireFrom'
        DataSource = dsHireLines
        Epoch = 1950
        ShowButton = True
        TabOrder = 6
        OnDblClick = dtHireTimeDblClick
      end
      object dtActualHireFrom: TwwDBDateTimePicker
        Left = 625
        Top = 106
        Width = 107
        Height = 23
        HelpContext = 1330029
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'Tahoma'
        CalendarAttributes.Font.Style = []
        DataField = 'ActualHireFrom'
        DataSource = dsHireLines
        Epoch = 1950
        ShowButton = True
        TabOrder = 7
        OnDblClick = dtHireTimeDblClick
      end
      object dtActualHireTo: TwwDBDateTimePicker
        Left = 738
        Top = 106
        Width = 107
        Height = 23
        HelpContext = 1330030
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'Tahoma'
        CalendarAttributes.Font.Style = []
        DataField = 'ActualHireTo'
        DataSource = dsHireLines
        Epoch = 1950
        ShowButton = True
        TabOrder = 8
        OnDblClick = dtHireTimeDblClick
      end
      object dtHireTo: TwwDBDateTimePicker
        Left = 852
        Top = 112
        Width = 107
        Height = 23
        HelpContext = 1330031
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'Tahoma'
        CalendarAttributes.Font.Style = []
        DataField = 'HireTo'
        DataSource = dsHireLines
        Epoch = 1950
        ShowButton = True
        TabOrder = 9
        OnDblClick = dtHireTimeDblClick
      end
    end
    object pnlProducts: TDNMPanel
      Left = 1
      Top = 360
      Width = 994
      Height = 150
      HelpContext = 1330032
      Align = alBottom
      Caption = 'pnlProducts'
      Constraints.MinHeight = 20
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object lblMsg: TLabel
        Left = 1
        Top = 1
        Width = 992
        Height = 17
        HelpContext = 1330034
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExplicitLeft = 79
        ExplicitTop = 0
        ExplicitWidth = 908
      end
      object Label5: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 73
        Height = 15
        HelpContext = 1330033
        Margins.Right = 888
        Caption = 'Selling Items'
      end
      object grdProducts: TwwDBGrid
        Left = 1
        Top = 18
        Width = 992
        Height = 131
        HelpContext = 1330035
        ControlType.Strings = (
          'ProductName;CustomEdit;cboProductsProduct;F'
          'UnitofMeasure;CustomEdit;cboProductsUOM;F'
          'TaxCode;CustomEdit;cboProductsTax;F'
          'Converted;CheckBox;T;F')
        Selected.Strings = (
          'ProductName'#9'15'#9'Product'#9#9
          'Description'#9'15'#9'Description'#9#9
          'UnitofMeasure'#9'10'#9'UOM'#9#9
          'UOMQty'#9'10'#9'Qty'#9#9
          'PriceEx'#9'10'#9'Price (Ex)'#9#9
          'TaxCode'#9'10'#9'Tax Code'#9#9
          'LineTotalEx'#9'10'#9'Total (Ex)'#9'F'#9
          'Discount'#9'10'#9'Discount'#9#9
          'Converted'#9'1'#9'Converted ?'#9'T'#9
          'LineTotalInc'#9'10'#9'Total (Inc)'#9'F'#9
          'ProductPrintName'#9'255'#9'ProductPrintName'#9'F'#9)
        MemoAttributes = [mSizeable, mWordWrap, mGridShow]
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        Align = alClient
        DataSource = dsHirePartsSales
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = [dgAllowInsert]
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgRowResize]
        ParentFont = False
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = True
        OnTitleButtonClick = grdProductsTitleButtonClick
        FooterColor = clWhite
        FooterCellColor = clWhite
        PaintOptions.BackgroundOptions = [coBlendFixedRow]
        object wwIButton1: TwwIButton
          Left = -1
          Top = 0
          Width = 22
          Height = 22
          HelpContext = 1330036
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
          OnClick = wwIButton1Click
        end
      end
      object cboProductsUOM: TwwDBLookupCombo
        Left = 77
        Top = 59
        Width = 85
        Height = 26
        HelpContext = 1330037
        AutoSize = False
        DropDownAlignment = taLeftJustify
        DataField = 'UnitofMeasure'
        LookupTable = qryProductsUOM
        LookupField = 'UnitName'
        TabOrder = 1
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object cboProductsProduct: TERPDbLookupCombo
        Left = 270
        Top = 62
        Width = 85
        Height = 23
        HelpContext = 1330038
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'PARTNAME'#9'15'#9'Name'#9'F'
          'Manuf'#9'10'#9'Manuf'#9'F'
          'Type'#9'15'#9'Type'#9'F'
          'Dept'#9'10'#9'Dept'#9'F'
          'PARTSDESCRIPTION'#9'50'#9'PARTSDESCRIPTION'#9'F'
          'SupplierProductCode'#9'20'#9'Supplier Product Code'#9'F')
        DataField = 'ProductName'
        DataSource = dsHirePartsSales
        LookupTable = qryProductsParts
        LookupField = 'Partname'
        Options = [loTitles]
        TabOrder = 2
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
        AllowMultipleSelectFromList = False
        OpenListinF6WhenNotinList = False
        DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
        DataIDField = 'ProductID'
        LookupIDField = 'PartsID'
        LookupFieldAlt = 'ProductPrintName'
      end
      object cboProductsTax: TwwDBLookupCombo
        Left = 168
        Top = 62
        Width = 85
        Height = 23
        HelpContext = 1330039
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Name'#9'5'#9'Name'#9'F'
          'Rate'#9'5'#9'Rate'#9'F')
        DataField = 'TaxCode'
        LookupTable = QryProductsTax
        LookupField = 'Name'
        TabOrder = 3
        AutoDropDown = False
        ShowButton = True
        UseTFields = False
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object cboPrintProductR: TERPDbLookupCombo
        Left = 280
        Top = 70
        Width = 85
        Height = 23
        HelpContext = 1330096
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'PARTNAME'#9'15'#9'Name'#9'F'
          'Manuf'#9'10'#9'Manuf'#9'F'
          'Type'#9'15'#9'Type'#9'F'
          'Dept'#9'10'#9'Dept'#9'F'
          'PARTSDESCRIPTION'#9'50'#9'PARTSDESCRIPTION'#9'F'
          'SupplierProductCode'#9'20'#9'Supplier Product Code'#9'F')
        DataField = 'ProductName'
        DataSource = dsHirePartsSales
        LookupTable = qryProductsParts
        LookupField = 'Partname'
        Options = [loTitles]
        TabOrder = 4
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
        AllowMultipleSelectFromList = False
        OpenListinF6WhenNotinList = False
        DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
        DataIDField = 'ProductID'
        LookupIDField = 'PartsID'
        LookupFieldAlt = 'ProductPrintName'
      end
    end
    object pnlTop: TDNMPanel
      Left = 1
      Top = 1
      Width = 994
      Height = 192
      HelpContext = 1330040
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
        994
        192)
      object Bevel1: TBevel
        Left = 369
        Top = 57
        Width = 126
        Height = 129
        HelpContext = 1330041
      end
      object Label160: TLabel
        Left = 762
        Top = 12
        Width = 33
        Height = 15
        HelpContext = 1330042
        Anchors = [akTop, akRight]
        Caption = 'Hire #'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label38: TLabel
        Left = 12
        Top = 47
        Width = 56
        Height = 15
        HelpContext = 1330043
        Caption = 'Customer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label2: TLabel
        Left = 632
        Top = 68
        Width = 58
        Height = 16
        HelpContext = 1330044
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'Company'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object bvelCustomerDetails: TBevel
        Left = 5
        Top = 91
        Width = 265
        Height = 98
        HelpContext = 1330045
      end
      object Label79: TLabel
        Left = 373
        Top = 59
        Width = 36
        Height = 15
        HelpContext = 1330046
        Caption = 'Terms'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object ClassLabel: TLabel
        Left = 373
        Top = 100
        Width = 32
        Height = 15
        HelpContext = 1330047
        Caption = 'Class'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Bevel7: TBevel
        Left = 631
        Top = 91
        Width = 257
        Height = 98
        HelpContext = 1330048
        Anchors = [akTop, akRight]
      end
      object Label1: TLabel
        Left = 635
        Top = 97
        Width = 33
        Height = 15
        HelpContext = 1330049
        Anchors = [akTop, akRight]
        Caption = 'Bill To'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Bevel3: TBevel
        Left = 501
        Top = 57
        Width = 126
        Height = 129
        HelpContext = 1330050
      end
      object SaleDate_Label: TLabel
        Left = 626
        Top = 12
        Width = 26
        Height = 15
        HelpContext = 1330051
        Anchors = [akTop, akRight]
        Caption = 'Date'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label9: TLabel
        Left = 12
        Top = 2
        Width = 149
        Height = 15
        HelpContext = 1330089
        Caption = 'Estimated Date/Time From'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label11: TLabel
        Left = 373
        Top = 141
        Width = 94
        Height = 15
        HelpContext = 1330091
        Caption = 'Cust PO Number'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object btnconvertToSale: TDNMSpeedButton
        Left = 508
        Top = 71
        Width = 111
        Height = 27
        HelpContext = 1330052
        Action = actConvertToSale
        Caption = 'Convert'
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
        TabOrder = 11
      end
      object pnlTitle: TDNMPanel
        Left = 402
        Top = 12
        Width = 189
        Height = 39
        HelpContext = 1330053
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Locked = True
        ParentFont = False
        TabOrder = 13
        object TitleShader: TShader
          Left = 1
          Top = 1
          Width = 187
          Height = 37
          HelpContext = 1330054
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
            Width = 187
            Height = 37
            HelpContext = 1330055
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'Hire'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -29
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
            ExplicitLeft = -1
            ExplicitTop = 6
            ExplicitWidth = 948
          end
        end
      end
      object txtCustomID: TDBEdit
        Left = 800
        Top = 8
        Width = 88
        Height = 23
        Hint = 'Double Click For The Transaction Sequence List'
        HelpContext = 1330056
        Anchors = [akTop, akRight]
        DataField = 'HireID'
        DataSource = dsHire
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 0
      end
      object chkUseBillCust: TDBCheckBox
        Left = 652
        Top = 43
        Width = 236
        Height = 15
        HelpContext = 1330057
        Alignment = taLeftJustify
        Anchors = [akTop, akRight]
        Caption = 'Use different Customer for Invoicing ?'
        DataField = 'UseBillCust'
        DataSource = dsHire
        TabOrder = 5
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        OnExit = chkUseBillCustExit
      end
      object cboClientR: TERPDbLookupCombo
        Left = 12
        Top = 65
        Width = 232
        Height = 23
        HelpContext = 1330058
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Company'#9'45'#9'Company'#9'F')
        DataField = 'CustomerName'
        DataSource = dsHire
        LookupTable = qryClientLookup
        LookupField = 'Company'
        ParentFont = False
        TabOrder = 1
        AutoDropDown = True
        ShowButton = True
        UseTFields = False
        PreciseEditRegion = False
        AllowClearKey = False
        LookupFormClassName = 'TCustomerExpressListGUI'
        EditFormClassName = 'TfrmCustomer'
        LookupFormKeyStringFieldName = 'Company'
        LookupComboType = ctCustomer
        AllowFullListSearchMode = False
        DisableNotInList = False
        AllowMultipleSelectFromList = False
        OpenListinF6WhenNotinList = False
        DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
        DataIDField = 'CustomerID'
        LookupIDField = 'ClientID'
        LookupFieldAlt = 'PrintName'
      end
      object btnContacts: TDNMSpeedButton
        Left = 245
        Top = 65
        Width = 25
        Height = 23
        HelpContext = 1330059
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500000000000
          055557777777777775F508888888888880557F5FFFFFFFFFF75F080000000000
          88057577777777775F755080FFFFFF05088057F7FFFFFF7575F70000000000F0
          F08077777777775757F70FFFFFFFFF0F008075F5FF5FF57577F750F00F00FFF0
          F08057F775775557F7F750FFFFFFFFF0F08057FF5555555757F7000FFFFFFFFF
          0000777FF5FFFFF577770900F00000F000907F775777775777F7090FFFFFFFFF
          00907F7F555555557757000FFFFFFFFF0F00777F5FFF5FF57F77550F000F00FF
          0F05557F777577557F7F550FFFFFFFFF0005557F555FFFFF7775550FFF000000
          05555575FF777777755555500055555555555557775555555555}
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 2
        OnClick = btnContactsClick
      end
      object cboBillClientName: TERPDbLookupCombo
        Left = 698
        Top = 65
        Width = 190
        Height = 23
        HelpContext = 1330060
        Anchors = [akTop, akRight]
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Company'#9'30'#9'Company'#9'F')
        DataField = 'BillCustomerName'
        DataSource = dsHire
        LookupTable = qryClientInvoicetoLookup
        LookupField = 'Company'
        Options = [loSearchOnBackspace]
        Style = csDropDownList
        DropDownWidth = 150
        Enabled = False
        ParentFont = False
        TabOrder = 6
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        LookupFormClassName = 'TCustomerExpressListGUI'
        EditFormClassName = 'TfrmCustomer'
        LookupFormKeyStringFieldName = 'Company'
        LookupComboType = ctCustomer
        AllowFullListSearchMode = False
        DisableNotInList = False
        AllowMultipleSelectFromList = False
        OpenListinF6WhenNotinList = False
        DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
        DataIDField = 'BillCustomerID'
        LookupIDField = 'ClientID'
        LookupFieldAlt = 'PrintName'
      end
      object btnShipment: TDNMSpeedButton
        Left = 12
        Top = 96
        Width = 54
        Height = 16
        Hint = 'Sale Shipments'
        HelpContext = 1330061
        Caption = 'Ship To'
        Color = clBtnFace
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
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = btnShipmentClick
      end
      object txtClientDetails: TDBMemo
        Left = 11
        Top = 115
        Width = 252
        Height = 70
        HelpContext = 1330062
        DataField = 'ShiptoAddress'
        DataSource = dsHire
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object OptStatus: TDBRadioGroup
        AlignWithMargins = True
        Left = 273
        Top = 59
        Width = 94
        Height = 106
        HelpContext = 1330063
        Caption = 'Status'
        DataField = 'Status'
        DataSource = dsHire
        Items.Strings = (
          'Quoted'
          'On Hire'
          'Off Hire'
          'Returned')
        ParentBackground = True
        TabOrder = 8
        Values.Strings = (
          'Q'
          'O'
          'N'
          'R'
          '')
        OnClick = OptStatusClick
      end
      object cboTerms: TwwDBLookupCombo
        Left = 373
        Top = 75
        Width = 117
        Height = 23
        HelpContext = 1330064
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        DataField = 'Terms'
        DataSource = dsHire
        LookupTable = cboTermsQry
        LookupField = 'Terms'
        ParentFont = False
        TabOrder = 9
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object cboClass: TwwDBLookupCombo
        Left = 373
        Top = 116
        Width = 117
        Height = 23
        HelpContext = 1330065
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ClassName'#9'25'#9'ClassName'#9'F')
        DataField = 'Classname'
        DataSource = dsHire
        LookupTable = cboClassQry
        LookupField = 'ClassName'
        ParentFont = False
        TabOrder = 10
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object txtShipTo: TDBMemo
        Left = 635
        Top = 115
        Width = 249
        Height = 70
        HelpContext = 1330066
        Anchors = [akTop, akRight]
        DataField = 'BillToAddress'
        DataSource = dsHire
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object DNMPanel1: TDNMPanel
        Left = 892
        Top = 0
        Width = 102
        Height = 192
        HelpContext = 1330067
        Align = alRight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 12
        object btnSave: TDNMSpeedButton
          AlignWithMargins = True
          Left = 4
          Top = 37
          Width = 94
          Height = 27
          Hint = 'Save the Repair'
          HelpContext = 1330068
          Margins.Bottom = 2
          Align = alTop
          Caption = '&Save'
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
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          NumGlyphs = 2
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = btnSaveClick
        end
        object btnNew: TDNMSpeedButton
          AlignWithMargins = True
          Left = 4
          Top = 5
          Width = 94
          Height = 27
          Hint = '"Save This Repair And Open A New Repair"'
          HelpContext = 1330069
          Margins.Top = 4
          Margins.Bottom = 2
          Align = alTop
          Caption = '&New'
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
          TabOrder = 0
          OnClick = btnNewClick
        end
        object btnRepeat: TDNMSpeedButton
          AlignWithMargins = True
          Left = 4
          Top = 99
          Width = 94
          Height = 27
          HelpContext = 1330070
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alTop
          Caption = '&Repeat'
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
          TabOrder = 3
          OnClick = btnRepeatClick
        end
        object btnCopy: TDNMSpeedButton
          AlignWithMargins = True
          Left = 4
          Top = 161
          Width = 94
          Height = 27
          Hint = 'Preview the Repair'
          HelpContext = 1330071
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alTop
          Caption = 'C&opy'
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
          OnClick = btnCopyClick
        end
        object btnPrint: TDNMSpeedButton
          AlignWithMargins = True
          Left = 4
          Top = 130
          Width = 94
          Height = 27
          Hint = 'Print the Repair'
          HelpContext = 1330072
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alTop
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
          TabOrder = 4
          OnClick = DoPrintOptions
        end
        object btnCancel: TDNMSpeedButton
          AlignWithMargins = True
          Left = 4
          Top = 68
          Width = 94
          Height = 27
          Hint = 'Cancel the Changes'
          HelpContext = 1330073
          Margins.Top = 2
          Margins.Bottom = 2
          Align = alTop
          Caption = 'Cancel'
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
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          NumGlyphs = 2
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = btnCancelClick
        end
      end
      object DNMSpeedButton5: TDNMSpeedButton
        Left = 508
        Top = 153
        Width = 111
        Height = 27
        HelpContext = 1330074
        Caption = 'Smart Order List'
        DisableTransparent = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ModalResult = 1
        ParentFont = False
        TabOrder = 14
        TabStop = False
        OnClick = DNMSpeedButton5Click
      end
      object btnPayments: TDNMSpeedButton
        Left = 508
        Top = 112
        Width = 111
        Height = 27
        HelpContext = 1330075
        Caption = 'Sales List'
        DisableTransparent = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ModalResult = 1
        ParentFont = False
        TabOrder = 15
        TabStop = False
        OnClick = btnPaymentsClick
      end
      object DBCheckBox1: TDBCheckBox
        Left = 280
        Top = 170
        Width = 75
        Height = 15
        Hint = 'This field is updated when the Hire is converted to a Sale'
        HelpContext = 1330076
        Alignment = taLeftJustify
        Caption = 'Invoiced ?'
        DataField = 'Converted'
        DataSource = dsHire
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 16
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        OnExit = chkUseBillCustExit
      end
      object cboCreationDate: TwwDBDateTimePicker
        Left = 658
        Top = 8
        Width = 98
        Height = 23
        HelpContext = 1330077
        Anchors = [akTop, akRight]
        AutoFillDateAndTime = True
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'HireDate'
        DataSource = dsHire
        Date = 42410.000000000000000000
        Epoch = 1950
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 17
      end
      object cboEstimatedDateTime: TwwDBComboDlg
        Left = 12
        Top = 20
        Width = 157
        Height = 23
        HelpContext = 1330092
        OnCustomDlg = cboEstimatedDateTimeCustomDlg
        ShowButton = True
        Style = csDropDown
        DataField = 'DefaultHireFrom'
        DataSource = dsHire
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 18
        WordWrap = False
        UnboundDataType = wwDefault
      end
      object edtCustomerPONumber: TDBEdit
        Left = 373
        Top = 157
        Width = 117
        Height = 23
        Hint = 'Double Click For The Transaction Sequence List'
        HelpContext = 1330094
        DataField = 'CustomerPONumber'
        DataSource = dsHire
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 19
      end
      object btnPlanner: TDNMSpeedButton
        Left = 323
        Top = 20
        Width = 66
        Height = 27
        HelpContext = 1330097
        Action = actOpenPlanner
        Caption = 'Planner'
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
        TabOrder = 20
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 76
    Top = 325
  end
  inherited tmrdelay: TTimer
    Left = 42
    Top = 325
  end
  inherited popSpelling: TPopupMenu
    Left = 8
    Top = 325
  end
  inherited tmrdelayMsg: TTimer
    Left = 109
    Top = 328
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 42
    Top = 389
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 109
    Top = 357
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
    Left = 8
    Top = 119
  end
  inherited DataState: TDataState
    Left = 42
    Top = 357
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    OnPopup = popCustomiseGridPopup
    Left = 8
    Top = 389
  end
  inherited imgsort: TImageList
    Left = 76
    Top = 357
    Bitmap = {
      494C01010200D001C40210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 109
    Top = 229
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 76
    Top = 389
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 8
    Top = 357
  end
  inherited qryMemTrans: TERPQuery
    Left = 76
    Top = 229
  end
  object QryHire: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblhire')
    AfterOpen = QryHireAfterOpen
    AfterInsert = QryHireAfterInsert
    Left = 8
    Top = 157
    object QryHireHireID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'HireID'
      Origin = 'tblhire.HireID'
    end
    object QryHireGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblhire.GlobalRef'
      Size = 255
    end
    object QryHireCreatedDate: TDateField
      FieldName = 'CreatedDate'
      Origin = 'tblhire.CreatedDate'
    end
    object QryHireContactID: TIntegerField
      FieldName = 'ContactID'
      Origin = 'tblhire.ContactID'
    end
    object QryHireClassID: TIntegerField
      FieldName = 'ClassID'
      Origin = 'tblhire.ClassID'
    end
    object QryHireHiretotal: TFloatField
      FieldName = 'Hiretotal'
      Origin = 'tblhire.Hiretotal'
      currency = True
    end
    object QryHireSalesTotal: TFloatField
      FieldName = 'SalesTotal'
      Origin = 'tblhire.SalesTotal'
      currency = True
    end
    object QryHireNotes: TWideMemoField
      FieldName = 'Notes'
      Origin = 'tblhire.Notes'
      BlobType = ftWideMemo
    end
    object QryHireStatus: TWideStringField
      FieldName = 'Status'
      Origin = 'tblhire.Status'
      FixedChar = True
      Size = 1
    end
    object QryHireTermsID: TIntegerField
      FieldName = 'TermsID'
      Origin = 'tblhire.TermsID'
    end
    object QryHireTerms: TWideStringField
      FieldName = 'Terms'
      Origin = 'tblhire.Terms'
      Size = 50
    end
    object QryHiremsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblhire.msTimeStamp'
    end
    object QryHiremsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblhire.msUpdateSiteCode'
      Size = 3
    end
    object QryHireCustomerName: TWideStringField
      FieldName = 'CustomerName'
      Origin = 'tblhire.CustomerName'
      Size = 255
    end
    object QryHireCustomerID: TIntegerField
      FieldName = 'CustomerID'
      Origin = 'tblhire.CustomerID'
    end
    object QryHireEmployeeId: TIntegerField
      FieldName = 'EmployeeId'
      Origin = 'tblhire.EmployeeId'
    end
    object QryHireemployeeName: TWideStringField
      FieldName = 'employeeName'
      Origin = 'tblhire.employeeName'
      Size = 255
    end
    object QryHireBillToAddress: TWideStringField
      FieldName = 'BillToAddress'
      Origin = 'tblhire.BillToAddress'
      Size = 255
    end
    object QryHireShiptoAddress: TWideStringField
      FieldName = 'ShiptoAddress'
      Origin = 'tblhire.ShiptoAddress'
      Size = 255
    end
    object QryHireClassname: TWideStringField
      FieldName = 'Classname'
      Origin = 'tblhire.Classname'
      Size = 255
    end
    object QryHireUseBillCust: TWideStringField
      FieldName = 'UseBillCust'
      Origin = 'tblhire.UseBillCust'
      FixedChar = True
      Size = 1
    end
    object QryHireBillCustomerID: TIntegerField
      FieldName = 'BillCustomerID'
      Origin = 'tblhire.BillCustomerID'
    end
    object QryHireBillCustomerName: TWideStringField
      FieldName = 'BillCustomerName'
      Origin = 'tblhire.BillCustomerName'
      Size = 255
    end
    object QryHireShipAddressID: TIntegerField
      FieldName = 'ShipAddressID'
      Origin = 'tblhire.ShipAddressID'
    end
    object QryHireHireDate: TDateField
      FieldName = 'HireDate'
      Origin = 'tblhire.HireDate'
    end
    object QryHireTotalamount: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Totalamount'
      currency = True
      Calculated = True
    end
    object QryHireConverted: TWideStringField
      FieldName = 'Converted'
      Origin = 'tblhire.Converted'
      FixedChar = True
      Size = 1
    end
    object QryHireCustomerPONumber: TWideStringField
      FieldName = 'CustomerPONumber'
      Size = 255
    end
    object QryHireDeleted: TWideStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
    object QryHireDefaultHireFrom: TDateTimeField
      FieldName = 'DefaultHireFrom'
    end
    object QryHireDefaultHireTo: TDateTimeField
      FieldName = 'DefaultHireTo'
    end
    object QryHireDefaultDurationId: TIntegerField
      FieldName = 'DefaultDurationId'
    end
    object QryHireDefaultActualHireFrom: TDateTimeField
      FieldName = 'DefaultActualHireFrom'
    end
    object QryHireDefaultActualHireTo: TDateTimeField
      FieldName = 'DefaultActualHireTo'
    end
    object QryHireDefaultActualDurationId: TIntegerField
      FieldName = 'DefaultActualDurationId'
    end
    object QryHireDefaultDurationQty: TFloatField
      FieldName = 'DefaultDurationQty'
    end
    object QryHireDefaultAcutualDurationQty: TFloatField
      FieldName = 'DefaultAcutualDurationQty'
    end
    object QryHireClientBillPrintName: TWideStringField
      FieldName = 'ClientBillPrintName'
      Size = 255
    end
    object QryHireClientPrintName: TWideStringField
      FieldName = 'ClientPrintName'
      Size = 255
    end
  end
  object dsHire: TDataSource
    DataSet = QryHire
    Left = 144
    Top = 153
  end
  object QryHireLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT H.*'
      'FROM tblHireLines H')
    Filtered = True
    Filter = 'Deleted = '#39'F'#39
    AfterPost = QryHireLinesAfterPost
    OnCalcFields = QryHireLinesCalcFields
    Left = 42
    Top = 157
    object QryHireLinesHireFrom: TDateTimeField
      DisplayWidth = 19
      FieldName = 'HireFrom'
      Origin = 'tblhirelines.HireFrom'
    end
    object QryHireLinesHireTo: TDateTimeField
      DisplayWidth = 19
      FieldName = 'HireTo'
      Origin = 'tblhirelines.HireTo'
    end
    object QryHireLinesStatus: TWideStringField
      DisplayWidth = 10
      FieldName = 'Status'
      Origin = 'tblhirelines.Status'
      FixedChar = True
      Size = 1
    end
    object QryHireLinesDurationName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 10
      FieldName = 'DurationName'
      Origin = 'tblhirelines.DurationName'
      Size = 100
    end
    object QryHireLinesDurationQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'DurationQty'
      Origin = 'tblhirelines.DurationQty'
    end
    object QryHireLinesDurationRate: TFloatField
      DisplayLabel = 'Rate'
      DisplayWidth = 10
      FieldName = 'DurationRate'
      Origin = 'tblhirelines.DurationRate'
      currency = True
    end
    object QryHireLinesPriceEx: TFloatField
      DisplayLabel = 'Price (Ex)'
      DisplayWidth = 10
      FieldName = 'PriceEx'
      Origin = 'tblhirelines.PriceEx'
      currency = True
    end
    object QryHireLinesLineTaxCode: TWideStringField
      DisplayLabel = 'Tax Code'
      DisplayWidth = 10
      FieldName = 'LineTaxCode'
      Origin = 'tblhirelines.LineTaxCode'
      Size = 15
    end
    object QryHireLinesLineAmount: TFloatField
      DisplayLabel = 'Amount (Ex)'
      DisplayWidth = 12
      FieldName = 'LineAmount'
      Origin = 'tblhirelines.LineAmount'
      currency = True
    end
    object QryHireLinesEmployeeName: TWideStringField
      DisplayLabel = 'Employee'
      DisplayWidth = 11
      FieldName = 'EmployeeName'
      Origin = 'tblhirelines.EmployeeName'
      Size = 100
    end
    object QryHireLinesConverted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Converted'
      Origin = 'tblhirelines.Converted'
      FixedChar = True
      Size = 1
    end
    object QryHireLinesPriceInc: TFloatField
      DisplayLabel = 'Price (Inc)'
      DisplayWidth = 10
      FieldName = 'PriceInc'
      Origin = 'tblhirelines.PriceInc'
      Visible = False
      currency = True
    end
    object QryHireLinesLineAmountInc: TFloatField
      DisplayLabel = 'Amount (Inc)'
      DisplayWidth = 10
      FieldName = 'LineAmountInc'
      Origin = 'tblhirelines.LineAmountInc'
      Visible = False
      currency = True
    end
    object QryHireLinesUOM: TWideStringField
      DisplayWidth = 10
      FieldName = 'UOM'
      Origin = 'tblhirelines.UOM'
      Visible = False
      Size = 255
    end
    object QryHireLinesHireLineID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'HireLineID'
      Origin = 'tblhirelines.HireLineID'
      Visible = False
    end
    object QryHireLinesGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblhirelines.GlobalRef'
      Visible = False
      Size = 255
    end
    object QryHireLinesHireID: TIntegerField
      DisplayWidth = 10
      FieldName = 'HireID'
      Origin = 'tblhirelines.HireID'
      Visible = False
    end
    object QryHireLinesDurationId: TIntegerField
      DisplayWidth = 10
      FieldName = 'DurationId'
      Origin = 'tblhirelines.DurationID'
      Visible = False
    end
    object QryHireLinesLineTaxRate: TFloatField
      DisplayWidth = 10
      FieldName = 'LineTaxRate'
      Origin = 'tblhirelines.LineTaxRate'
      Visible = False
    end
    object QryHireLinesmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblhirelines.msTimeStamp'
      Visible = False
    end
    object QryHireLinesmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblhirelines.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
    object QryHireLinesEmployeeId: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeId'
      Origin = 'tblhirelines.EmployeeId'
      Visible = False
    end
    object QryHireLinesUOMID: TIntegerField
      DisplayWidth = 10
      FieldName = 'UOMID'
      Origin = 'tblhirelines.UOMID'
      Visible = False
    end
    object QryHireLinesUOMMult: TFloatField
      DisplayWidth = 10
      FieldName = 'UOMMult'
      Origin = 'tblhirelines.UOMMult'
      Visible = False
    end
    object QryHireLinesHireQty: TFloatField
      DisplayWidth = 10
      FieldName = 'HireQty'
      Origin = 'tblhirelines.HireQty'
      Visible = False
    end
    object QryHireLinesHireUOMQty: TFloatField
      DisplayWidth = 10
      FieldName = 'HireUOMQty'
      Origin = 'tblhirelines.HireUOMQty'
      Visible = False
    end
    object QryHireLinesDeleted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Origin = 'tblhirelines.Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryHireLinesActualHireFrom: TDateTimeField
      FieldName = 'ActualHireFrom'
      Origin = 'tblhirelines.ActualHireFrom'
    end
    object QryHireLinesActualHireTo: TDateTimeField
      FieldName = 'ActualHireTo'
      Origin = 'tblhirelines.ActualHireTo'
    end
    object QryHireLinesHireFromtime: TWideStringField
      FieldName = 'HireFromtime'
    end
    object QryHireLinesHiretoTime: TWideStringField
      FieldName = 'HiretoTime'
    end
    object QryHireLinesActualHiretoTime: TWideStringField
      FieldName = 'ActualHiretoTime'
    end
    object QryHireLinesActualHireFromtime: TWideStringField
      FieldName = 'ActualHireFromtime'
    end
    object QryHireLinesAssetId: TIntegerField
      FieldName = 'AssetId'
    end
    object QryHireLinesAssetName: TWideStringField
      FieldName = 'AssetName'
      Size = 255
    end
    object QryHireLinesIncomeAccountId: TIntegerField
      FieldName = 'IncomeAccountId'
    end
    object QryHireLinesHireProductId: TIntegerField
      FieldName = 'HireProductId'
    end
    object QryHireLinesHireProductName: TWideStringField
      FieldName = 'HireProductName'
      Size = 255
    end
    object QryHireLinesAssetCode: TWideStringField
      FieldName = 'AssetCode'
      Size = 255
    end
    object QryHireLinesAlloc: TStringField
      FieldKind = fkCalculated
      FieldName = 'Alloc'
      Size = 1
      Calculated = True
    end
    object QryHireLinesDetail: TStringField
      FieldKind = fkCalculated
      FieldName = 'Detail'
      Size = 1
      Calculated = True
    end
    object QryHireLinesProductPrintName: TWideStringField
      FieldName = 'ProductPrintName'
      Size = 255
    end
    object QryHireLinesSalesDescription: TStringField
      FieldKind = fkLookup
      FieldName = 'SalesDescription'
      LookupDataSet = QryProducts
      LookupKeyFields = 'Partname'
      LookupResultField = 'PartsDescription'
      KeyFields = 'AssetName'
      Size = 50
      Lookup = True
    end
  end
  object dsHireLines: TDataSource
    DataSet = QryHireLines
    Left = 98
    Top = 193
  end
  object QryHirePartsSales: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblhirepartssale')
    Filtered = True
    Filter = 'Deleted ='#39'F'#39
    AfterPost = QryHirePartsSalesAfterPost
    Left = 76
    Top = 157
    object QryHirePartsSalesProductName: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 15
      FieldName = 'ProductName'
      Origin = 'tblhirepartssale.ProductName'
      Size = 255
    end
    object QryHirePartsSalesDescription: TWideStringField
      DisplayWidth = 15
      FieldName = 'Description'
      Origin = 'tblhirepartssale.Description'
      Size = 255
    end
    object QryHirePartsSalesUnitofMeasure: TWideStringField
      DisplayLabel = 'UOM'
      DisplayWidth = 10
      FieldName = 'UnitofMeasure'
      Origin = 'tblhirepartssale.UnitofMeasure'
      Size = 50
    end
    object QryHirePartsSalesUOMQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'UOMQty'
      Origin = 'tblhirepartssale.UOMQty'
    end
    object QryHirePartsSalesPriceEx: TFloatField
      DisplayLabel = 'Price (Ex)'
      DisplayWidth = 10
      FieldName = 'PriceEx'
      Origin = 'tblhirepartssale.PriceEx'
      currency = True
    end
    object QryHirePartsSalesTaxCode: TWideStringField
      DisplayLabel = 'Tax Code'
      DisplayWidth = 10
      FieldName = 'TaxCode'
      Origin = 'tblhirepartssale.TaxCode'
      Size = 15
    end
    object QryHirePartsSalesLineTotalEx: TFloatField
      DisplayLabel = 'Total (Ex)'
      DisplayWidth = 10
      FieldName = 'LineTotalEx'
      Origin = 'tblhirepartssale.LineTotalEx'
      currency = True
    end
    object QryHirePartsSalesDiscount: TFloatField
      DisplayWidth = 10
      FieldName = 'Discount'
      Origin = 'tblhirepartssale.Discount'
      currency = True
    end
    object QryHirePartsSalesConverted: TWideStringField
      DisplayLabel = 'Converted ?'
      DisplayWidth = 1
      FieldName = 'Converted'
      Origin = 'tblhirepartssale.Converted'
      FixedChar = True
      Size = 1
    end
    object QryHirePartsSalesLineTotalInc: TFloatField
      DisplayLabel = 'Total (Inc)'
      DisplayWidth = 10
      FieldName = 'LineTotalInc'
      Origin = 'tblhirepartssale.LineTotalInc'
      currency = True
    end
    object QryHirePartsSalesPartIssuedOn: TDateTimeField
      DisplayLabel = 'Part Issued On'
      DisplayWidth = 12
      FieldName = 'PartIssuedOn'
      Origin = 'tblhirepartssale.PartIssuedOn'
      Visible = False
    end
    object QryHirePartsSalesPartBarcode: TWideStringField
      DisplayLabel = 'Barcode'
      DisplayWidth = 10
      FieldName = 'PartBarcode'
      Origin = 'tblhirepartssale.PartBarcode'
      Visible = False
      Size = 255
    end
    object QryHirePartsSalesPriceInc: TFloatField
      DisplayLabel = 'Price (Inc)'
      DisplayWidth = 10
      FieldName = 'PriceInc'
      Origin = 'tblhirepartssale.PriceInc'
      Visible = False
      currency = True
    end
    object QryHirePartsSalesMarkup: TFloatField
      DisplayWidth = 10
      FieldName = 'Markup'
      Origin = 'tblhirepartssale.Markup'
      Visible = False
      currency = True
    end
    object QryHirePartsSalesDiscountPercent: TFloatField
      DisplayLabel = 'Discount %'
      DisplayWidth = 10
      FieldName = 'DiscountPercent'
      Origin = 'tblhirepartssale.DiscountPercent'
      Visible = False
    end
    object QryHirePartsSalesMarkupPercent: TFloatField
      DisplayLabel = 'Markup %'
      DisplayWidth = 10
      FieldName = 'MarkupPercent'
      Origin = 'tblhirepartssale.MarkupPercent'
      Visible = False
    end
    object QryHirePartsSalesGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblhirepartssale.GlobalRef'
      Visible = False
      Size = 255
    end
    object QryHirePartsSalesHirePartsSaleID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'HirePartsSaleID'
      Origin = 'tblhirepartssale.HirePartsSaleID'
      Visible = False
    end
    object QryHirePartsSalesHireID: TIntegerField
      DisplayWidth = 10
      FieldName = 'HireID'
      Origin = 'tblhirepartssale.HireID'
      Visible = False
    end
    object QryHirePartsSalesProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'tblhirepartssale.ProductID'
      Visible = False
    end
    object QryHirePartsSalesQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
      Origin = 'tblhirepartssale.Qty'
      Visible = False
    end
    object QryHirePartsSalesUnitofMeasureID: TLargeintField
      DisplayWidth = 15
      FieldName = 'UnitofMeasureID'
      Origin = 'tblhirepartssale.UnitofMeasureID'
      Visible = False
    end
    object QryHirePartsSalesUnitofMeasureMultiplier: TFloatField
      DisplayWidth = 10
      FieldName = 'UnitofMeasureMultiplier'
      Origin = 'tblhirepartssale.UnitofMeasureMultiplier'
      Visible = False
    end
    object QryHirePartsSalesLinecost: TFloatField
      DisplayWidth = 10
      FieldName = 'Linecost'
      Origin = 'tblhirepartssale.Linecost'
      Visible = False
    end
    object QryHirePartsSalesTaxRate: TFloatField
      DisplayWidth = 10
      FieldName = 'TaxRate'
      Origin = 'tblhirepartssale.TaxRate'
      Visible = False
    end
    object QryHirePartsSalesmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblhirepartssale.msTimeStamp'
      Visible = False
    end
    object QryHirePartsSalesDeleted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Origin = 'tblhirepartssale.Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryHirePartsSalesParentProductID: TLargeintField
      DisplayWidth = 15
      FieldName = 'ParentProductID'
      Origin = 'tblhirepartssale.ParentProductID'
      Visible = False
    end
    object QryHirePartsSalesParentLineRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'ParentLineRef'
      Origin = 'tblhirepartssale.ParentLineRef'
      Visible = False
      Size = 255
    end
    object QryHirePartsSalesRelatedProductQty: TFloatField
      DisplayWidth = 10
      FieldName = 'RelatedProductQty'
      Origin = 'tblhirepartssale.RelatedProductQty'
      Visible = False
    end
    object QryHirePartsSalesIsRelatedProduct: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsRelatedProduct'
      Origin = 'tblhirepartssale.IsRelatedProduct'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryHirePartsSalesMatrixDesc: TWideMemoField
      DisplayWidth = 10
      FieldName = 'MatrixDesc'
      Origin = 'tblhirepartssale.MatrixDesc'
      Visible = False
      BlobType = ftWideMemo
    end
    object QryHirePartsSalesMatrixRef: TWideMemoField
      DisplayWidth = 10
      FieldName = 'MatrixRef'
      Origin = 'tblhirepartssale.MatrixRef'
      Visible = False
      BlobType = ftWideMemo
    end
    object QryHirePartsSalesMatrixPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'MatrixPrice'
      Origin = 'tblhirepartssale.MatrixPrice'
      Visible = False
    end
    object QryHirePartsSalesmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblhirepartssale.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
    object QryHirePartsSalesProductPrintName: TWideStringField
      DisplayWidth = 255
      FieldName = 'ProductPrintName'
      Size = 255
    end
  end
  object dsHirePartsSales: TDataSource
    DataSet = QryHirePartsSales
    Left = 132
    Top = 185
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
      'AND C1.Active = '#39'T'#39' '
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (C1.Company LIKE Concat(:SearchValue,"' +
        '%")))'
      
        'or ((:SearchMode = 2) and (C1.Company LIKE Concat("%",:SearchVal' +
        'ue,"%"))))'
      'and IfNull(:SearchValue,"") <> ""')
    Left = 192
    Top = 157
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
    object qryClientLookupCompany: TWideStringField
      DisplayWidth = 35
      FieldName = 'Company'
      Size = 80
    end
    object qryClientLookupClientId: TIntegerField
      FieldName = 'ClientId'
      Visible = False
    end
    object qryClientLookupDefaultPostAccount: TWideStringField
      FieldName = 'DefaultPostAccount'
      Visible = False
      Size = 255
    end
    object qryClientLookupDefaultPostAccountID: TIntegerField
      FieldName = 'DefaultPostAccountID'
      Visible = False
    end
    object qryClientLookupStreet: TWideStringField
      FieldName = 'Street'
      Visible = False
      Size = 255
    end
    object qryClientLookupStreet2: TWideStringField
      FieldName = 'Street2'
      Visible = False
      Size = 255
    end
    object qryClientLookupStreet3: TWideStringField
      FieldName = 'Street3'
      Visible = False
      Size = 255
    end
    object qryClientLookupSuburb: TWideStringField
      FieldName = 'Suburb'
      Visible = False
      Size = 255
    end
    object qryClientLookupState: TWideStringField
      FieldName = 'State'
      Visible = False
      Size = 255
    end
    object qryClientLookupCountry: TWideStringField
      FieldName = 'Country'
      Visible = False
      Size = 255
    end
    object qryClientLookupPostcode: TWideStringField
      FieldName = 'Postcode'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillStreet: TWideStringField
      FieldName = 'BillStreet'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillStreet2: TWideStringField
      FieldName = 'BillStreet2'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillStreet3: TWideStringField
      FieldName = 'BillStreet3'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillSuburb: TWideStringField
      FieldName = 'BillSuburb'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillState: TWideStringField
      FieldName = 'BillState'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillPostcode: TWideStringField
      FieldName = 'BillPostcode'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillCountry: TWideStringField
      FieldName = 'BillCountry'
      Visible = False
      Size = 255
    end
    object qryClientLookupTERMS: TWideStringField
      FieldName = 'TERMS'
      Visible = False
      Size = 30
    end
    object qryClientLookupTermsID: TIntegerField
      FieldName = 'TermsID'
      Visible = False
    end
    object qryClientLookupShippingMethod: TWideStringField
      FieldName = 'ShippingMethod'
      Visible = False
      Size = 30
    end
    object qryClientLookupShippingID: TIntegerField
      FieldName = 'ShippingID'
      Visible = False
    end
    object qryClientLookupRepID: TIntegerField
      FieldName = 'RepID'
      Visible = False
    end
    object qryClientLookupTaxID: TIntegerField
      FieldName = 'TaxID'
      Visible = False
    end
    object qryClientLookupPhone: TWideStringField
      FieldName = 'Phone'
      Visible = False
    end
    object qryClientLookupFax: TWideStringField
      FieldName = 'Fax'
      Visible = False
    end
    object qryClientLookupAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Visible = False
    end
    object qryClientLookupStopCredits: TWideStringField
      FieldName = 'StopCredits'
      Visible = False
      Size = 1
    end
    object qryClientLookupForcePOOnInvoice: TWideStringField
      FieldName = 'ForcePOOnInvoice'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryClientLookupUseInvBase: TWideStringField
      FieldName = 'UseInvBase'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryClientLookupInvBaseNumber: TIntegerField
      FieldName = 'InvBaseNumber'
      Visible = False
    end
    object qryClientLookupWarrantyFinishDate: TDateTimeField
      FieldName = 'WarrantyFinishDate'
      Visible = False
    end
    object qryClientLookupIsJob: TWideStringField
      FieldName = 'IsJob'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object cboClassQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName,ClassPercent'
      'FROM tblClass '
      
        'WHERE (((tblClass.ClassName) Is Not Null) And ((tblClass.Active)' +
        '<>'#39'F'#39')) '
      'ORDER BY tblClass.ClassName; ')
    Options.LongStrings = False
    Left = 42
    Top = 197
  end
  object cboTermsQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT tblTerms.TermsID, tblTerms.Terms, tblTerms.TermsAmount, t' +
        'blTerms.EOM, tblTerms.EOMPlus, tblTerms.Active '
      'FROM tblTerms '
      'WHERE (tblTerms.Active='#39'T'#39' OR tblTerms.Terms=:xTerms)'
      'ORDER BY tblTerms.Terms; ')
    CommandTimeout = 30
    Left = 40
    Top = 285
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xTerms'
      end>
    object cboTermsQryTermsID: TIntegerField
      FieldName = 'TermsID'
    end
    object cboTermsQryTerms: TWideStringField
      FieldName = 'Terms'
      Size = 50
    end
    object cboTermsQryTermsAmount: TIntegerField
      FieldName = 'TermsAmount'
    end
    object cboTermsQryEOM: TWideStringField
      FieldName = 'EOM'
      FixedChar = True
      Size = 1
    end
    object cboTermsQryEOMPlus: TWideStringField
      FieldName = 'EOMPlus'
      FixedChar = True
      Size = 1
    end
    object cboTermsQryActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
  end
  object cboEmployeeLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblEmployees.EmployeeID, EmployeeName  AS EmployeeName '
      'FROM tblEmployees '
      'WHERE (((tblEmployees.Active)<>'#39'F'#39')) '
      'ORDER BY EmployeeName;')
    AutoCalcFields = False
    Options.LongStrings = False
    Left = 74
    Top = 285
  end
  object QryProducts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select Distinct P.partsId, P.Partname , P.PartsDescription'
      
        'from tblequipment E inner join tblParts P on E.ProductID = P.par' +
        'tsId'
      'where E.active ="T" and P.active ="T" and P.discontinued ="F"'
      'Order by P.Partname')
    AutoCalcFields = False
    Options.LongStrings = False
    Left = 140
    Top = 285
    object QryProductspartsId: TIntegerField
      FieldName = 'partsId'
    end
    object QryProductsPartname: TWideStringField
      FieldName = 'Partname'
      Size = 60
    end
    object QryProductsPartsDescription: TWideStringField
      FieldName = 'PartsDescription'
      Size = 255
    end
  end
  object cboLinesEmployeeLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblEmployees.EmployeeID, EmployeeName  AS EmployeeName '
      'FROM tblEmployees '
      'WHERE (((tblEmployees.Active)<>'#39'F'#39')) '
      'ORDER BY EmployeeName;')
    AutoCalcFields = False
    Options.LongStrings = False
    Left = 181
    Top = 285
  end
  object cboAssetLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'AssetName,'
      'AssetCode,'
      'tblfixedassets.AssetID'
      'FROM tblfixedassets'
      
        'inner join tblAssetHire on tblAssetHire.AssetId = tblfixedassets' +
        '.AssetID and tblAssetHire.Active = "T"  '
      'where  (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and ((AssetName LIKE Concat(:SearchValue,"' +
        '%"))     Or  (AssetCode LIKE Concat(:SearchValue,"%"))      ))'
      
        'or ((:SearchMode = 2) and ((AssetName LIKE Concat("%",:SearchVal' +
        'ue,"%")) Or  (AssetCode LIKE Concat("%",:SearchValue,"%"))  )))'
      'and IfNull(:SearchValue,"") <> ""'
      'ORDER BY AssetName;')
    BeforeOpen = cboAssetLookupBeforeOpen
    Options.LongStrings = False
    Left = 8
    Top = 284
    ParamData = <
      item
        DataType = ftInteger
        Name = 'SearchMode'
      end
      item
        DataType = ftInteger
        Name = 'SearchMode'
      end
      item
        DataType = ftInteger
        Name = 'SearchMode'
      end
      item
        DataType = ftWideString
        Name = 'SearchValue'
      end
      item
        DataType = ftWideString
        Name = 'SearchValue'
      end
      item
        DataType = ftInteger
        Name = 'SearchMode'
      end
      item
        DataType = ftWideString
        Name = 'SearchValue'
      end
      item
        DataType = ftWideString
        Name = 'SearchValue'
      end
      item
        DataType = ftWideString
        Name = 'SearchValue'
      end>
    object cboAssetLookupAssetName: TWideStringField
      FieldName = 'AssetName'
      Size = 255
    end
    object cboAssetLookupAssetCode: TWideStringField
      FieldName = 'AssetCode'
      Size = 50
    end
    object cboAssetLookupAssetID: TIntegerField
      FieldName = 'AssetID'
    end
  end
  object qryClientInvoicetoLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT ClientID, Company, Street, Street2, Street3, Suburb, Stat' +
        'e, Postcode, Phone, AltPhone, FaxNumber,'
      
        'BillStreet, BillStreet2,BillStreet3, BillSuburb, BillState, Bill' +
        'Country, BillPostcode,mobile,'
      
        'StopCredit, jobnumber, ForcePOOnCustomer, Jobname, tblclients.Wa' +
        'rrantyFinishDate, '
      
        'tblclients.IsJob, ParentClientID, TaxID, title , firstname, last' +
        'name'
      'FROM tblclients'
      
        'WHERE tblclients.Company Is Not Null And tblclients.Active = '#39'T'#39 +
        ' And tblclients.Customer = '#39'T'#39' and JobNumber = 0'
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (Company LIKE Concat(:SearchValue,"%")' +
        '))'
      
        'or ((:SearchMode = 2) and (Company LIKE Concat("%",:SearchValue,' +
        '"%"))))'
      'and IfNull(:SearchValue,"") <> ""'
      'ORDER BY tblclients.Company')
    Filtered = True
    Left = 114
    Top = 285
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
    object qryClientInvoicetoLookupCompany: TWideStringField
      DisplayWidth = 30
      FieldName = 'Company'
      Origin = 'tblclients.Company'
      Size = 80
    end
    object qryClientInvoicetoLookupClientID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientID'
      Origin = 'tblclients.ClientID'
      Visible = False
    end
    object qryClientInvoicetoLookupStreet: TWideStringField
      FieldName = 'Street'
      Origin = 'tblclients.Street'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupStopCreditImage: TIntegerField
      DisplayWidth = 1
      FieldKind = fkCalculated
      FieldName = 'StopCreditImage'
      Visible = False
      Calculated = True
    end
    object qryClientInvoicetoLookupStreet2: TWideStringField
      FieldName = 'Street2'
      Origin = 'tblclients.Street2'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupSuburb: TWideStringField
      FieldName = 'Suburb'
      Origin = 'tblclients.Suburb'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupState: TWideStringField
      FieldName = 'State'
      Origin = 'tblclients.State'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupPostcode: TWideStringField
      FieldName = 'Postcode'
      Origin = 'tblclients.Postcode'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupPhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'tblclients.Phone'
      Visible = False
    end
    object qryClientInvoicetoLookupAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Origin = 'tblclients.AltPhone'
      Visible = False
    end
    object qryClientInvoicetoLookupFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
      Origin = 'tblclients.FaxNumber'
      Visible = False
    end
    object qryClientInvoicetoLookupmobile: TWideStringField
      FieldName = 'mobile'
      Origin = 'tblclients.Mobile'
      Visible = False
    end
    object qryClientInvoicetoLookupBillStreet: TWideStringField
      FieldName = 'BillStreet'
      Origin = 'tblclients.BillStreet'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupBillStreet2: TWideStringField
      FieldName = 'BillStreet2'
      Origin = 'tblclients.BillStreet2'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupBillSuburb: TWideStringField
      FieldName = 'BillSuburb'
      Origin = 'tblclients.BillSuburb'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupBillState: TWideStringField
      FieldName = 'BillState'
      Origin = 'tblclients.BillState'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupBillCountry: TWideStringField
      FieldName = 'BillCountry'
      Origin = 'tblclients.BillCountry'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupBillPostcode: TWideStringField
      FieldName = 'BillPostcode'
      Origin = 'tblclients.BillPostcode'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupStopCredit: TWideStringField
      FieldName = 'StopCredit'
      Origin = 'tblclients.StopCredit'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryClientInvoicetoLookupjobnumber: TIntegerField
      FieldName = 'jobnumber'
      Origin = 'tblclients.JobNumber'
      Visible = False
    end
    object qryClientInvoicetoLookupForcePOOnCustomer: TWideStringField
      FieldName = 'ForcePOOnCustomer'
      Origin = 'tblclients.ForcePOOnCustomer'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryClientInvoicetoLookupJobname: TWideStringField
      FieldName = 'Jobname'
      Origin = 'tblclients.JobName'
      Visible = False
      Size = 39
    end
    object qryClientInvoicetoLookupWarrantyFinishDate: TDateTimeField
      FieldName = 'WarrantyFinishDate'
      Origin = 'tblclients.WarrantyFinishDate'
      Visible = False
    end
    object qryClientInvoicetoLookupIsJob: TWideStringField
      FieldName = 'IsJob'
      Origin = 'tblclients.IsJob'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryClientInvoicetoLookupParentClientID: TIntegerField
      FieldName = 'ParentClientID'
      Origin = 'tblclients.ParentClientID'
      Visible = False
    end
    object qryClientInvoicetoLookupTaxID: TIntegerField
      FieldName = 'TaxID'
      Origin = 'tblclients.TAXID'
      Visible = False
    end
    object qryClientInvoicetoLookuptitle: TWideStringField
      FieldName = 'title'
      Origin = 'tblclients.Title'
      Size = 32
    end
    object qryClientInvoicetoLookupStreet3: TWideStringField
      FieldName = 'Street3'
      Origin = 'tblclients.Street3'
      Size = 255
    end
    object qryClientInvoicetoLookupBillStreet3: TWideStringField
      FieldName = 'BillStreet3'
      Origin = 'tblclients.BillStreet3'
      Size = 255
    end
    object qryClientInvoicetoLookupfirstname: TWideStringField
      FieldName = 'firstname'
      Origin = 'tblclients.FirstName'
      Size = 40
    end
    object qryClientInvoicetoLookuplastname: TWideStringField
      FieldName = 'lastname'
      Origin = 'tblclients.LastName'
      Size = 40
    end
  end
  object qryProductsUOM: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      '/*SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND (ifnull(U.PartID,0) = :xPartID or U.Pa' +
        'rtID = 0) '
      'Group By U.UnitName Desc'
      'Order By UnitID desc ,U.UnitName'
      '*/'
      'SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = :xPartID'
      'union all '
      'SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = 0 and Unitname no' +
        't  in (Select unitname from  tblunitsofmeasure where  ifnull(Par' +
        'tID,0) = :xPartID  )'
      'Order By UnitID desc ,UnitName;')
    Left = 393
    Top = 441
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPartID'
      end
      item
        DataType = ftUnknown
        Name = 'xPartID'
      end>
    object qryProductsUOMUnitID: TIntegerField
      FieldName = 'UnitID'
    end
    object qryProductsUOMUnitName: TWideStringField
      FieldName = 'UnitName'
      Size = 15
    end
    object qryProductsUOMUnitDescription: TWideStringField
      FieldName = 'UnitDescription'
      Size = 35
    end
    object qryProductsUOMMultiplier: TFloatField
      FieldName = 'Multiplier'
    end
    object qryProductsUOMBaseUnitName: TWideStringField
      FieldName = 'BaseUnitName'
      Size = 15
    end
  end
  object qryProductsParts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'Left(SUBSTRING_INDEX(P.ProductGroup,'#39'^'#39',1),255) AS Manuf  , '
      
        'Left(substring(substring_index(P.ProductGroup,'#39'^'#39',2),char_length' +
        '(substring_index(P.ProductGroup,'#39'^'#39',1))+2),255) AS Type  ,'
      
        'Left(substring(substring_index(P.ProductGroup,'#39'^'#39',3),char_length' +
        '(substring_index(P.ProductGroup,'#39'^'#39',2))+2),255) AS Dept  ,'
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
        'tPrice ,'
      'P.taxcode as TaxCode,'
      'p.LatestCost as LatestCost,'
      'p.AutoBatch as AutoBatch, '
      'p.Attrib1Sale as Attrib1Sale,'
      'p.Attrib2Sale as Attrib2Sale,'
      'p.Attrib1SaleRate as Attrib1SaleRate,'
      'P.LatestCostDate as LatestCostDate,'
      'SupplierProductCode,'
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
      'FROM `tblParts` P'
      'WHERE P.Active = "T"'
      ' AND ('
      '  ((:SearchMode = 0) or (IsNull(:SearchMode))) '
      
        'or ((:SearchMode = 1) and ((Partname  LIKE Concat(:SearchValue,"' +
        '%"))  or (PREFEREDSUPP  LIKE Concat(:SearchValue,"%"))   or (PAR' +
        'TSDESCRIPTION LIKE Concat(:SearchValue,"%"))   or (Left(SUBSTRIN' +
        'G_INDEX(P.ProductGroup,'#39'^'#39',1),255) LIKE Concat(:SearchValue,"%")' +
        ')   or (Left(substring(substring_index(P.ProductGroup,'#39'^'#39',2),cha' +
        'r_length(substring_index(P.ProductGroup,'#39'^'#39',1))+2),255) LIKE Con' +
        'cat(:SearchValue,"%"))   or (Left(substring(substring_index(P.Pr' +
        'oductGroup,'#39'^'#39',3),char_length(substring_index(P.ProductGroup,'#39'^'#39 +
        ',2))+2),255) LIKE Concat(:SearchValue,"%"))  )) '
      
        'or ((:SearchMode = 2) and (Trim(:SearchValue) <> "") and ((Partn' +
        'ame  LIKE Concat("%",:SearchValue,"%"))   or (PREFEREDSUPP  LIKE' +
        ' Concat("%",:SearchValue,"%"))   or (PARTSDESCRIPTION LIKE Conca' +
        't("%",:SearchValue,"%"))  or (Left(SUBSTRING_INDEX(P.ProductGrou' +
        'p,'#39'^'#39',1),255) LIKE Concat("%",:SearchValue,"%"))  or (Left(subst' +
        'ring(substring_index(P.ProductGroup,'#39'^'#39',2),char_length(substring' +
        '_index(P.ProductGroup,'#39'^'#39',1))+2),255) LIKE Concat("%",:SearchVal' +
        'ue,"%"))  or (Left(substring(substring_index(P.ProductGroup,'#39'^'#39',' +
        '3),char_length(substring_index(P.ProductGroup,'#39'^'#39',2))+2),255) LI' +
        'KE Concat("%",:SearchValue,"%"))  )) '
      ')'
      'and IfNull(:SearchValue,"") <> ""')
    Left = 424
    Top = 441
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
    object qryProductsPartsManuf: TWideStringField
      FieldName = 'Manuf'
      Origin = 'Manuf'
      Size = 255
    end
    object qryProductsPartsType: TWideStringField
      FieldName = 'Type'
      Origin = 'Type'
      Size = 255
    end
    object qryProductsPartsDept: TWideStringField
      FieldName = 'Dept'
      Origin = 'Dept'
      Size = 255
    end
    object qryProductsPartsPARTNAME: TWideStringField
      FieldName = 'PARTNAME'
      Origin = 'P.PARTNAME'
      Size = 60
    end
    object qryProductsPartsPARTSDESCRIPTION: TWideStringField
      FieldName = 'PARTSDESCRIPTION'
      Origin = 'P.PARTSDESCRIPTION'
      Size = 255
    end
    object qryProductsPartsPARTSID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PARTSID'
      Origin = 'P.PARTSID'
    end
    object qryProductsPartsPARTTYPE: TWideStringField
      FieldName = 'PARTTYPE'
      Origin = 'P.PARTTYPE'
      Size = 13
    end
    object qryProductsPartsPRODUCTGROUP: TWideStringField
      FieldName = 'PRODUCTGROUP'
      Origin = 'P.PRODUCTGROUP'
      Size = 255
    end
    object qryProductsPartsINCOMEACCNT: TWideStringField
      FieldName = 'INCOMEACCNT'
      Origin = 'P.INCOMEACCNT'
      Size = 50
    end
    object qryProductsPartsASSETACCNT: TWideStringField
      FieldName = 'ASSETACCNT'
      Origin = 'P.ASSETACCNT'
      Size = 50
    end
    object qryProductsPartsCOGSACCNT: TWideStringField
      FieldName = 'COGSACCNT'
      Origin = 'P.COGSACCNT'
      Size = 50
    end
    object qryProductsPartsBARCODE: TWideStringField
      FieldName = 'BARCODE'
      Origin = 'P.BARCODE'
      Size = 35
    end
    object qryProductsPartsPRODUCTCODE: TWideStringField
      FieldName = 'PRODUCTCODE'
      Origin = 'P.PRODUCTCODE'
      Size = 11
    end
    object qryProductsPartsTAXCODE: TWideStringField
      FieldName = 'TAXCODE'
      Origin = 'P.TaxCode'
      Size = 15
    end
    object qryProductsPartsSpecialDiscount: TWideStringField
      FieldName = 'SpecialDiscount'
      Origin = 'P.SpecialDiscount'
      FixedChar = True
      Size = 1
    end
    object qryProductsPartsSNTracking: TWideStringField
      FieldName = 'SNTracking'
      Origin = 'P.SNTracking'
      FixedChar = True
      Size = 1
    end
    object qryProductsPartsBuyQTY1: TIntegerField
      FieldName = 'BuyQTY1'
      Origin = 'P.BuyQTY1'
    end
    object qryProductsPartsBuyQTY2: TIntegerField
      FieldName = 'BuyQTY2'
      Origin = 'P.BuyQTY2'
    end
    object qryProductsPartsBuyQTY3: TIntegerField
      FieldName = 'BuyQTY3'
      Origin = 'P.BuyQTY3'
    end
    object qryProductsPartsCOST1: TFloatField
      FieldName = 'COST1'
      Origin = 'P.COST1'
    end
    object qryProductsPartsCOST2: TFloatField
      FieldName = 'COST2'
      Origin = 'P.COST2'
    end
    object qryProductsPartsCOST3: TFloatField
      FieldName = 'COST3'
      Origin = 'P.COST3'
    end
    object qryProductsPartsSellQTY1: TIntegerField
      FieldName = 'SellQTY1'
      Origin = 'P.SellQTY1'
    end
    object qryProductsPartsSellQTY2: TIntegerField
      FieldName = 'SellQTY2'
      Origin = 'P.SellQTY2'
    end
    object qryProductsPartsSellQTY3: TIntegerField
      FieldName = 'SellQTY3'
      Origin = 'P.SellQTY3'
    end
    object qryProductsPartsPRICE1: TFloatField
      FieldName = 'PRICE1'
      Origin = 'P.PRICE1'
    end
    object qryProductsPartsPRICE2: TFloatField
      FieldName = 'PRICE2'
      Origin = 'P.PRICE2'
    end
    object qryProductsPartsPRICE3: TFloatField
      FieldName = 'PRICE3'
      Origin = 'P.PRICE3'
    end
    object qryProductsPartsWHOLESALEPRICE: TFloatField
      FieldName = 'WHOLESALEPRICE'
      Origin = 'P.WHOLESALEPRICE'
    end
    object qryProductsPartsActive: TWideStringField
      FieldName = 'Active'
      Origin = 'P.Active'
      FixedChar = True
      Size = 1
    end
    object qryProductsPartsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'P.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryProductsPartsAvgCost: TFloatField
      FieldName = 'AvgCost'
      Origin = 'P.AvgCost'
    end
    object qryProductsPartsSupplierProductCode: TWideStringField
      FieldName = 'SupplierProductCode'
      Origin = 'P.SupplierProductCode'
      Size = 50
    end
  end
  object QryProductsTax: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT TaxCodeID, Name, Rate  '
      'FROM tbltaxcodes'
      'Where RegionID= :xRegionID;')
    BeforeOpen = QryProductsTaxBeforeOpen
    Left = 460
    Top = 441
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end>
  end
  object QrySales: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select '
      's.saleID , '
      'S.customerName , '
      'S.TotalAmountInc , '
      'S.SaleDate , '
      
        'if(S.IsInvoice ="T", "Invoice" , if(S.IsSalesOrder ="T", "Sales ' +
        'Order" , if(S.IsCashSale ="T", "Cash Sale" , if(S.IsPOS ="T", "P' +
        'OS" ,"Unknown" )))) as Salestype,'
      'S.IsInvoice,'
      'S.IsSalesOrder ,'
      'S.IsCashSale ,'
      'S.IsPOS '
      'From tblsales S'
      'where S.HireGlobalref = :QuoteglobalREf'
      'Order by saledate')
    BeforeOpen = QrySalesBeforeOpen
    Left = 8
    Top = 464
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'QuoteglobalREf'
      end>
    object QrySalessaleID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'Sale #'
      DisplayWidth = 10
      FieldName = 'saleID'
      Origin = 'S.SaleID'
    end
    object QrySalescustomerName: TWideStringField
      DisplayLabel = 'Customer'
      DisplayWidth = 34
      FieldName = 'customerName'
      Origin = 'S.CustomerName'
      Size = 255
    end
    object QrySalesTotalAmountInc: TFloatField
      DisplayLabel = 'Sale Amount'
      DisplayWidth = 20
      FieldName = 'TotalAmountInc'
      Origin = 'S.TotalAmountInc'
    end
    object QrySalesSaleDate: TDateField
      DisplayLabel = 'Sale Date'
      DisplayWidth = 18
      FieldName = 'SaleDate'
      Origin = 'S.SaleDate'
    end
    object QrySalesSalestype: TWideStringField
      DisplayLabel = 'Type'
      DisplayWidth = 14
      FieldName = 'Salestype'
      Origin = 'Salestype'
      Size = 11
    end
    object QrySalesIsInvoice: TWideStringField
      FieldName = 'IsInvoice'
      Origin = 'S.IsInvoice'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QrySalesIsSalesOrder: TWideStringField
      FieldName = 'IsSalesOrder'
      Origin = 'S.IsSalesOrder'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QrySalesIsCashSale: TWideStringField
      FieldName = 'IsCashSale'
      Origin = 'S.IsCashSale'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QrySalesIsPOS: TWideStringField
      FieldName = 'IsPOS'
      Origin = 'S.IsPOS'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object dsSales: TDataSource
    DataSet = QrySales
    Left = 8
    Top = 493
  end
  object QryhireLinescount: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select concat (count(*) , '#39' : Equipments on Hire'#39') as Descriptio' +
        'n from tblHireLines where HireID = :HireID')
    BeforeOpen = QryhireLinescountBeforeOpen
    Left = 40
    Top = 464
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'HireID'
      end>
    object QryhireLinescountDescription: TWideStringField
      FieldName = 'Description'
      Origin = 'Description'
      Size = 42
    end
  end
  object dshireLinescount: TDataSource
    DataSet = QryhireLinescount
    Left = 40
    Top = 493
  end
  object dshirepartssalecount: TDataSource
    DataSet = Qryhirepartssalecount
    Left = 72
    Top = 493
  end
  object Qryhirepartssalecount: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select concat (count(*) , '#39' : Products on Sale'#39') as Description ' +
        'from tblhirepartssale where HireID = :HireID')
    BeforeOpen = QryhirepartssalecountBeforeOpen
    Left = 72
    Top = 464
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'HireID'
      end>
    object QryhirepartssalecountDescription: TWideStringField
      FieldName = 'Description'
      Origin = 'Description'
      Size = 40
    end
  end
  object QryTax: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT TaxCodeID, Name, Rate  '
      'FROM tbltaxcodes'
      'Where RegionID= :xRegionID;')
    BeforeOpen = QryTaxBeforeOpen
    Left = 484
    Top = 441
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end>
  end
  object lsTDNMSpeedButtonActions: TActionList
    Left = 230
    Top = 26
    object actPreview: TAction
      Caption = 'Pre&view'
      HelpContext = 1330078
    end
    object actPrint: TAction
      Caption = '&Print'
      HelpContext = 1330079
    end
    object actNew: TAction
      Caption = 'New'
      HelpContext = 1330080
    end
    object actSave: TAction
      Caption = 'Save'
      HelpContext = 1330081
    end
    object actConvertToSale: TDNMAction
      Caption = 'Convert To Sales'
      HelpContext = 1330082
      OnExecute = actConvertToSaleExecute
      OnUpdate = actConvertToSaleUpdate
      buttoncolor = clWhite
    end
    object actInvoice: TDNMAction
      Caption = 'Invoice'
      HelpContext = 1330083
      OnExecute = actInvoiceExecute
      OnUpdate = OnupdateSalesActions
      buttoncolor = clWhite
    end
    object actSalesOrder: TDNMAction
      Caption = 'Sales Order'
      HelpContext = 1330084
      OnExecute = actSalesOrderExecute
      OnUpdate = OnupdateSalesActions
      buttoncolor = clWhite
    end
    object actPOS: TDNMAction
      Caption = 'POS'
      HelpContext = 1330085
      OnExecute = actPOSExecute
      OnUpdate = OnupdateSalesActions
      buttoncolor = clWhite
    end
    object actCashSale: TDNMAction
      Caption = 'Cash Sale'
      HelpContext = 1330086
      OnExecute = actCashSaleExecute
      OnUpdate = OnupdateSalesActions
      buttoncolor = clWhite
    end
    object actSmartOrder: TDNMAction
      Caption = 'Smart Order'
      HelpContext = 1330087
      OnExecute = actSmartOrderExecute
      OnUpdate = OnupdateSalesActions
      buttoncolor = clWhite
    end
    object actOpenPlanner: TDNMAction
      Caption = 'Planner'
      HelpContext = 1330098
      OnExecute = actOpenPlannerExecute
      buttoncolor = clWhite
    end
  end
  object QryDurationRates: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select Distinct D.DurationId, Durationdesc(D.durationtype) as du' +
        'rationtype, D.Qty,  HPL.DurationName , min(HPL.Rate) as Rate '
      'from tblAssetHire AH '
      
        'inner join tblhirepricinglines HPL on AH.AssetHireId = HPL.Asset' +
        'HireID  '
      'inner join tblduration D on HPL.DurationID = D.DurationId'
      'where (AH.AssetId = :AssetID) '
      'group by D.durationtype,HPL.DurationName')
    BeforeOpen = QryTaxBeforeOpen
    OnCalcFields = QryDurationRatesCalcFields
    Left = 516
    Top = 441
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AssetID'
      end>
    object QryDurationRatesDurationName: TWideStringField
      DisplayWidth = 15
      FieldName = 'DurationName'
      Size = 100
    end
    object QryDurationRatesDuration: TStringField
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'Duration'
      Size = 100
      Calculated = True
    end
    object QryDurationRatesRate: TFloatField
      DisplayWidth = 10
      FieldName = 'Rate'
      currency = True
    end
    object QryDurationRatesdurationtype: TWideStringField
      DisplayLabel = 'Desc'
      DisplayWidth = 10
      FieldName = 'durationtype'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryDurationRatesQty: TFloatField
      FieldName = 'Qty'
      Visible = False
    end
    object QryDurationRatesDurationId: TIntegerField
      FieldName = 'DurationId'
    end
  end
  object DMTextTargetHire: TDMTextTarget
    AcceptorControl = txtNotes
    AcceptTextFormats = [dtfFiles, dtfCustom]
    OnDrop = DMTextTargetHireDrop
    Left = 268
    Top = 295
  end
end
