inherited fmWorkflow: TfmWorkflow
  Left = 447
  Top = 282
  HelpContext = 1200002
  Caption = 'Work Flow'
  ClientHeight = 564
  ClientWidth = 719
  Position = poMainFormCenter
  ExplicitLeft = 447
  ExplicitTop = 282
  ExplicitWidth = 735
  ExplicitHeight = 603
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 504
    Width = 719
    HelpContext = 1200003
    ExplicitTop = 223
    ExplicitWidth = 455
  end
  inherited shapehint: TShape
    Left = 87
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
    Left = 188
    Top = 10
    ExplicitLeft = 113
    ExplicitTop = 10
  end
  object DNMPanel2: TDNMPanel [5]
    AlignWithMargins = True
    Left = 3
    Top = 53
    Width = 713
    Height = 87
    HelpContext = 1200008
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 12
      Width = 68
      Height = 15
      HelpContext = 1200010
      Caption = 'Description '
    end
    object lblVideo: TLabel
      Left = 521
      Top = 12
      Width = 68
      Height = 15
      HelpContext = 1200011
      Alignment = taRightJustify
      Caption = 'Video Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 271
      Top = 12
      Width = 34
      Height = 15
      HelpContext = 1200012
      Alignment = taRightJustify
      Caption = 'Group'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label5: TLabel
      Left = 396
      Top = 12
      Width = 51
      Height = 15
      HelpContext = 1200014
      Alignment = taRightJustify
      Caption = 'Category'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label3: TLabel
      Left = 8
      Top = 58
      Width = 89
      Height = 15
      HelpContext = 1200027
      Caption = 'Company Name'
    end
    object Label4: TLabel
      Left = 526
      Top = 60
      Width = 62
      Height = 15
      HelpContext = 1200031
      Caption = 'Created By'
    end
    object edtDescription: TwwDBEdit
      Left = 8
      Top = 26
      Width = 254
      Height = 23
      HelpContext = 1200015
      DataField = 'Description'
      DataSource = dsworkflow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object cboCategory: TwwDBLookupCombo
      Left = 396
      Top = 26
      Width = 119
      Height = 23
      HelpContext = 1200019
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Category'#9'20'#9'Category'#9'F')
      DataField = 'Category'
      DataSource = dsworkflow
      LookupTable = QryCategory
      LookupField = 'Category'
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnNotInList = cboCategoryNotInList
    end
    object cboSkinsGroup: TwwDBComboBox
      Left = 271
      Top = 26
      Width = 121
      Height = 23
      HelpContext = 1200028
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'SkinsGroup'
      DataSource = dsworkflow
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      ParentFont = False
      Sorted = False
      TabOrder = 1
      UnboundDataType = wwDefault
      OnCloseUp = cboSkinsGroupCloseUp
    end
    object wwDBEdit1: TwwDBEdit
      Left = 103
      Top = 55
      Width = 412
      Height = 23
      HelpContext = 1200029
      DataField = 'CompanyName'
      DataSource = dsworkflow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object cboVideos: TwwDBLookupCombo
      Left = 521
      Top = 26
      Width = 187
      Height = 23
      HelpContext = 1200030
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PageCaption'#9'30'#9'PageCaption'#9'F')
      DataField = 'VideoName'
      DataSource = dsworkflow
      LookupTable = QryVideos
      LookupField = 'PageCaption'
      Style = csDropDownList
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnEnter = cboVideosEnter
      OnNotInList = cboVideosNotInList
    end
    object wwDBEdit2: TwwDBEdit
      Left = 595
      Top = 55
      Width = 113
      Height = 23
      HelpContext = 1200032
      DataField = 'CreatedByName'
      DataSource = dsworkflow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 504
    Width = 719
    Height = 60
    HelpContext = 1200020
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      719
      60)
    object Shape1: TShape
      Left = 619
      Top = 1
      Width = 99
      Height = 43
      Hint = 
        'Make the workflow readonly if you don'#39't want any one change it. ' +
        'You also will not be allowed to change it once made Read-only'
      HelpContext = 1200009
      Align = alRight
      Brush.Style = bsClear
      ParentShowHint = False
      Pen.Color = clGray
      ShowHint = True
      ExplicitLeft = 618
    end
    object lblMsg: TLabel
      Left = 1
      Top = 44
      Width = 717
      Height = 15
      HelpContext = 1200021
      Align = alBottom
      Alignment = taCenter
      Caption = 'lblMsg'
      Transparent = True
      Visible = False
      ExplicitWidth = 37
    end
    object cmdClose: TDNMSpeedButton
      Left = 234
      Top = 14
      Width = 93
      Height = 29
      HelpContext = 1200022
      Anchors = [akBottom]
      Caption = '&Save'
      Default = True
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
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = cmdCloseClick
    end
    object chkActive: TwwCheckBox
      Left = 627
      Top = 26
      Width = 87
      Height = 15
      HelpContext = 1200023
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Caption = 'Active ? '
      DataField = 'Active'
      DataSource = dsworkflow
      TabOrder = 1
    end
    object cmdCancel: TDNMSpeedButton
      Left = 392
      Top = 14
      Width = 93
      Height = 29
      HelpContext = 1200024
      Anchors = [akBottom]
      Cancel = True
      Caption = '&Cancel'
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      OnClick = cmdCancelClick
    end
    object wwCheckBox1: TwwCheckBox
      Left = 627
      Top = 3
      Width = 87
      Height = 21
      HelpContext = 1200017
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Read-only?'
      DataField = 'IsERpWorkflow'
      DataSource = dsworkflow
      TabOrder = 3
    end
  end
  object grdworkflowlines: TwwDBGrid [7]
    AlignWithMargins = True
    Left = 3
    Top = 146
    Width = 713
    Height = 355
    HelpContext = 1200025
    ControlType.Strings = (
      'ProductName;CustomEdit;cboProductR;F'
      'LineTaxCode;CustomEdit;cboTaxCode;F'
      'UnitofMeasureSaleLines;CustomEdit;cboUnitOfMeasure;F'
      'ForeignExchangeSellCode;CustomEdit;cboForeignCurrencyCode;F'
      'Supplier;CustomEdit;cboSupplier;F'
      'SearchFilter;CustomEdit;txtSearchFilter;T'
      'CostCentreName;CustomEdit;cboCostCentre;F'
      'HireQty;CustomEdit;edtHireQty;T'
      'SpecDescription;CustomEdit;cboPartSpecs;F'
      'SmartOrderCreated;CheckBox;T;F'
      'AutoSmartOrder;CheckBox;T;F'
      'ProviderNum;CustomEdit;cboPrescriber;T'
      'ShipContainerETA;CustomEdit;dtShipContainerETA;T'
      'MemoLine;CustomEdit;edtMemoLine;F'
      'Area;CustomEdit;cboLinesAreaCode;F'
      'showhint;CheckBox;T;F'
      'showPoint;CheckBox;T;F')
    Selected.Strings = (
      'Seqno'#9'1'#9'Seqno'#9'T'#9
      'EventName'#9'60'#9'Event Name'#9'F'#9
      'formName'#9'15'#9'Form'#9'T'#9
      'Controlname'#9'15'#9'Control'#9'T'#9
      'fieldname'#9'15'#9'Field Name'#9'T'#9)
    MemoAttributes = [mSizeable, mWordWrap, mGridShow]
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
    Align = alClient
    DataSource = dsworkflowLines
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgRowResize]
    ParentFont = False
    TabOrder = 2
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = True
    OnCalcCellColors = grdworkflowlinesCalcCellColors
    FooterColor = clWhite
    FooterCellColor = clWhite
    PaintOptions.BackgroundOptions = [coBlendFixedRow]
    object btnDelete: TwwIButton
      Left = -1
      Top = 0
      Width = 22
      Height = 22
      HelpContext = 1200026
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
  object DNMPanel1: TDNMPanel [8]
    Left = 0
    Top = 0
    Width = 719
    Height = 50
    HelpContext = 1200004
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      719
      50)
    object pnlTitle: TDNMPanel
      Left = 149
      Top = 4
      Width = 409
      Height = 39
      HelpContext = 1200005
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
        Width = 407
        Height = 37
        HelpContext = 1200006
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
          Width = 407
          Height = 37
          HelpContext = 1200007
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Work Flow'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = 2
        end
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 69
    Top = 135
  end
  inherited tmrdelay: TTimer
    Left = 215
    Top = 135
  end
  inherited popSpelling: TPopupMenu
    Left = 392
    Top = 136
  end
  inherited tmrdelayMsg: TTimer
    Left = 80
    Top = 48
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 106
    Top = 135
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 251
    Top = 135
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
    Left = 64
    Top = 167
  end
  inherited DataState: TDataState
    Left = 142
    Top = 135
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 284
    Top = 135
  end
  inherited imgsort: TImageList
    Left = 179
    Top = 135
    Bitmap = {
      494C010102001801280110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 232
    Top = 168
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 321
    Top = 135
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 360
    Top = 136
  end
  inherited qryMemTrans: TERPQuery
    Left = 198
    Top = 168
  end
  object qryworkflow: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select'
      '* '
      'from tblworkflow')
    AfterOpen = qryworkflowAfterOpen
    Left = 97
    Top = 168
    object qryworkflowID: TIntegerField
      FieldName = 'ID'
    end
    object qryworkflowDescription: TWideStringField
      FieldName = 'Description'
      Size = 255
    end
    object qryworkflowActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryworkflowIsERpWorkflow: TWideStringField
      FieldName = 'IsERpWorkflow'
      FixedChar = True
      Size = 1
    end
    object qryworkflowCreatedBy: TIntegerField
      FieldName = 'CreatedBy'
    end
    object qryworkflowmstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
    end
    object qryworkflowmsupdateSitecode: TWideStringField
      FieldName = 'msupdateSitecode'
      Size = 3
    end
    object qryworkflowLanguageID: TIntegerField
      FieldName = 'LanguageID'
    end
    object qryworkflowTabGroup: TIntegerField
      FieldName = 'TabGroup'
    end
    object qryworkflowSkinsGroup: TWideStringField
      FieldName = 'SkinsGroup'
      Size = 50
    end
    object qryworkflowCategory: TWideStringField
      FieldName = 'Category'
      Size = 100
    end
    object qryworkflowVideoName: TWideStringField
      FieldName = 'VideoName'
      Size = 255
    end
    object qryworkflowCompanyName: TWideStringField
      FieldName = 'CompanyName'
      Size = 255
    end
    object qryworkflowCreatedByName: TWideStringField
      FieldName = 'CreatedByName'
      Size = 255
    end
  end
  object dsworkflow: TDataSource
    DataSet = qryworkflow
    Left = 97
    Top = 201
  end
  object qryworkflowLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT * , if(eventtype ="H" or eventtype="B" , "T" , "F") as sh' +
        'owhint, if(eventtype ="P" or eventtype="B" , "T" , "F") as showP' +
        'oint FROM tblworkflowlines')
    Left = 131
    Top = 168
    object qryworkflowLinesSeqno: TIntegerField
      DisplayWidth = 1
      FieldName = 'Seqno'
      Origin = 'tblworkflowlines.Seqno'
    end
    object qryworkflowLinesEventName: TWideStringField
      DisplayLabel = 'Event Name'
      DisplayWidth = 60
      FieldName = 'EventName'
      Origin = 'tblworkflowlines.EventName'
      Size = 255
    end
    object qryworkflowLinesformName: TWideStringField
      DisplayLabel = 'Form'
      DisplayWidth = 15
      FieldName = 'formName'
      Origin = 'tblworkflowlines.formName'
      ReadOnly = True
      Size = 255
    end
    object qryworkflowLinesControlname: TWideStringField
      DisplayLabel = 'Control'
      DisplayWidth = 15
      FieldName = 'Controlname'
      Origin = 'tblworkflowlines.Controlname'
      ReadOnly = True
      Size = 255
    end
    object qryworkflowLinesfieldname: TWideStringField
      DisplayLabel = 'Field Name'
      DisplayWidth = 15
      FieldName = 'fieldname'
      Origin = 'tblworkflowlines.fieldname'
      ReadOnly = True
      Size = 255
    end
    object qryworkflowLinesshowhint: TWideStringField
      DisplayLabel = 'Hint?'
      DisplayWidth = 1
      FieldName = 'showhint'
      Origin = 'showhint'
      Visible = False
      OnSetText = qryworkflowLinesshowhintSetText
      Size = 1
    end
    object qryworkflowLinesshowPoint: TWideStringField
      DisplayLabel = 'Point?'
      DisplayWidth = 1
      FieldName = 'showPoint'
      Origin = 'showPoint'
      Visible = False
      OnSetText = qryworkflowLinesshowPointSetText
      Size = 1
    end
    object qryworkflowLinesGridcomboname: TWideStringField
      DisplayLabel = 'Combo'
      DisplayWidth = 15
      FieldName = 'Gridcomboname'
      Origin = 'tblworkflowlines.Gridcomboname'
      Visible = False
      Size = 255
    end
    object qryworkflowLinesPropname: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 10
      FieldName = 'Propname'
      Origin = 'tblworkflowlines.Propname'
      Visible = False
      Size = 255
    end
    object qryworkflowLinesvalue: TWideStringField
      DisplayWidth = 15
      FieldName = 'value'
      Origin = 'tblworkflowlines.value'
      Visible = False
      Size = 255
    end
    object qryworkflowLinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblworkflowlines.ID'
      Visible = False
    end
    object qryworkflowLinesWorkflowID: TIntegerField
      DisplayWidth = 10
      FieldName = 'WorkflowID'
      Origin = 'tblworkflowlines.WorkflowID'
      Visible = False
    end
    object qryworkflowLinesControlParent: TWideStringField
      DisplayWidth = 20
      FieldName = 'ControlParent'
      Origin = 'tblworkflowlines.ControlParent'
      Visible = False
      Size = 3000
    end
    object qryworkflowLineseventtype: TWideStringField
      FieldName = 'eventtype'
      Origin = 'tblworkflowlines.eventtype'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryworkflowLinesFormClassName: TWideStringField
      FieldName = 'FormClassName'
      Origin = 'tblworkflowlines.FormClassName'
      Visible = False
      Size = 255
    end
    object qryworkflowLinesmstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
      Origin = 'tblworkflowlines.mstimestamp'
      Visible = False
    end
    object qryworkflowLinesmsupdateSitecode: TWideStringField
      FieldName = 'msupdateSitecode'
      Origin = 'tblworkflowlines.msupdateSitecode'
      Visible = False
      Size = 3
    end
  end
  object dsworkflowLines: TDataSource
    DataSet = qryworkflowLines
    Left = 131
    Top = 201
  end
  object QryCategory: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select distinct Category from tblworkFlow where ifnull(Category,' +
        #39#39')<> '#39#39' order by Category')
    Options.LongStrings = False
    Left = 296
    Top = 168
  end
  object ERPQuery1: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select distinct Category from tblworkFlow where ifnull(Category,' +
        #39#39')<> '#39#39' order by Category')
    Options.LongStrings = False
    Left = 488
    Top = 176
  end
  object QryVideos: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select '
      'distinct V.PageCaption '
      'from erpdocumentaion.tblvideos V'
      
        'inner join erpdocumentaion.tblvideospages VP on V.ID = VP.VideoI' +
        'D '
      'Where V.videotype ='#39'vtTraining'#39' and  VP.PageName = :PageNAme '
      'order by PageCaption')
    BeforeOpen = QryVideosBeforeOpen
    Options.LongStrings = False
    Left = 336
    Top = 168
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PageNAme'
      end>
  end
end
