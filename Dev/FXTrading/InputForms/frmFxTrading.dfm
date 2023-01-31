inherited fmFxTrading: TfmFxTrading
  Left = 327
  Top = 158
  HelpContext = 1086002
  Caption = 'FX Trading'
  ClientHeight = 564
  ClientWidth = 952
  ExplicitLeft = 327
  ExplicitTop = 158
  ExplicitWidth = 968
  ExplicitHeight = 603
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 514
    Width = 952
    HelpContext = 1086003
    ExplicitTop = 223
    ExplicitWidth = 455
  end
  inherited shapehint: TShape
    Left = 120
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
    Left = 254
    Top = 10
    ExplicitLeft = 113
    ExplicitTop = 10
  end
  object pnlHeader: TDNMPanel [5]
    Left = 0
    Top = 50
    Width = 952
    Height = 71
    HelpContext = 1086008
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 81
      Top = 33
      Width = 55
      Height = 15
      HelpContext = 1086009
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
    object lblBaseForeignCurrencyCode: TLabel
      Left = 446
      Top = 31
      Width = 87
      Height = 18
      HelpContext = 1086010
      AutoSize = False
      Caption = 'Currency Code'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object cboEmployee: TwwDBLookupCombo
      Left = 142
      Top = 29
      Width = 219
      Height = 23
      HelpContext = 1086011
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'EmployeeName'#9'25'#9'Name'#9'F')
      DataField = 'EmployeeName'
      DataSource = dsFXTrading
      LookupTable = cboEmployeeLookup
      LookupField = 'EmployeeName'
      DropDownWidth = 300
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object cboBaseForeignCurrencyCode: TwwDBLookupCombo
      Left = 539
      Top = 29
      Width = 111
      Height = 23
      HelpContext = 1086012
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Currency'#9'25'#9'Name'#9'F')
      DataField = 'CurrencyCode'
      DataSource = dsFXTrading
      LookupTable = qryForeignCurrency
      LookupField = 'Code'
      Enabled = False
      ParentFont = False
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 514
    Width = 952
    Height = 50
    HelpContext = 1086013
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      952
      50)
    object cmdClose: TDNMSpeedButton
      Left = 251
      Top = 9
      Width = 93
      Height = 29
      HelpContext = 1086014
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
    object cmdCancel: TDNMSpeedButton
      Left = 575
      Top = 9
      Width = 93
      Height = 29
      HelpContext = 1086015
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
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = cmdCancelClick
    end
  end
  object pnlDetails: TDNMPanel [7]
    Left = 0
    Top = 121
    Width = 952
    Height = 393
    HelpContext = 1086016
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object grdTransactions: TwwDBGrid
      Left = 1
      Top = 1
      Width = 950
      Height = 391
      HelpContext = 1086017
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
        'EmployeeName;CustomEdit;cbolinesEmployeeName;F'
        'BuyCurrencyCode;CustomEdit;cboBuyCurrencyCode;F')
      Selected.Strings = (
        'Transdate'#9'18'#9'Date'#9#9
        'BuyCurrencyCode'#9'5'#9'Currency'#9#9
        'Amount'#9'10'#9'Amount'#9#9
        'BuyRate'#9'10'#9'Rate'#9#9
        'EmployeeName'#9'50'#9'Employee'#9#9
        'inLocalcurrency'#9'10'#9'value'#9'T')
      MemoAttributes = [mSizeable, mWordWrap, mGridShow]
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsFxTradinglines
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgEnterToTab, dgAllowInsert]
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
      FooterColor = clWhite
      FooterCellColor = clWhite
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
      object btnDelete: TwwIButton
        Left = 0
        Top = 0
        Width = 22
        Height = 22
        HelpContext = 1086018
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
    object cbolinesEmployeeName: TwwDBLookupCombo
      Left = 358
      Top = 29
      Width = 219
      Height = 23
      HelpContext = 1086019
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'EmployeeName'#9'25'#9'Name'#9'F')
      DataField = 'EmployeeName'
      DataSource = dsFxTradinglines
      LookupTable = cbolinesEmployeeLookup
      LookupField = 'EmployeeName'
      DropDownWidth = 300
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnCloseUp = cbolinesEmployeeNameCloseUp
    end
    object cboBuyCurrencyCode: TwwDBLookupCombo
      Left = 152
      Top = 29
      Width = 72
      Height = 23
      HelpContext = 1086020
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Code'#9'10'#9'Code'#9'F'
        'Currency'#9'20'#9'Currency'#9'F'
        'BuyRate'#9'10'#9'Rate'#9'F')
      DataField = 'BuyCurrencyCode'
      DataSource = dsFxTradinglines
      LookupTable = qryBaseForeignCurrency
      LookupField = 'Code'
      ParentFont = False
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboBuyCurrencyCodeCloseUp
    end
  end
  object DNMPanel1: TDNMPanel [8]
    Left = 0
    Top = 0
    Width = 952
    Height = 50
    HelpContext = 1086004
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    ExplicitLeft = 432
    ExplicitTop = 72
    ExplicitWidth = 150
    object pnlTitle: TDNMPanel
      Left = 242
      Top = 4
      Width = 409
      Height = 39
      HelpContext = 1086005
      
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
        HelpContext = 1086006
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
          HelpContext = 1086007
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Fx Trading'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 171
        end
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 429
    Top = 327
  end
  inherited tmrdelay: TTimer
    Left = 575
    Top = 327
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 466
    Top = 327
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 611
    Top = 327
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
    Left = 648
    Top = 327
  end
  inherited DataState: TDataState
    Left = 502
    Top = 327
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 684
    Top = 327
  end
  inherited imgsort: TImageList
    Left = 539
    Top = 327
    Bitmap = {
      494C010102008800900010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 393
    Top = 327
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 721
    Top = 327
  end
  object qryFXTrading: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblFxTrading')
    Left = 333
    Top = 327
    object qryFXTradingID: TIntegerField
      FieldName = 'ID'
    end
    object qryFXTradingGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 50
    end
    object qryFXTradingCurrencyID: TIntegerField
      FieldName = 'CurrencyID'
    end
    object qryFXTradingCurrencyCode: TWideStringField
      FieldName = 'CurrencyCode'
      Size = 50
    end
    object qryFXTradingEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryFXTradingEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 50
    end
    object qryFXTradingmstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
    end
    object qryFXTradingMsUpdateSitecode: TWideStringField
      FieldName = 'MsUpdateSitecode'
      Size = 3
    end
  end
  object dsFXTrading: TDataSource
    DataSet = qryFXTrading
    Left = 333
    Top = 355
  end
  object qryFxTradinglines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblFxTradinglines')
    Filtered = True
    Filter = 'Deleted <> '#39'T'#39
    OnCalcFields = qryFxTradinglinesCalcFields
    Left = 365
    Top = 327
    object qryFxTradinglinesTransdate: TDateTimeField
      DisplayLabel = 'Date'
      DisplayWidth = 18
      FieldName = 'Transdate'
      Origin = 'tblfxtradinglines.Transdate'
    end
    object qryFxTradinglinesBuyCurrencyCode: TWideStringField
      DisplayLabel = 'Currency'
      DisplayWidth = 5
      FieldName = 'BuyCurrencyCode'
      Origin = 'tblfxtradinglines.BuyCurrencyCode'
      Size = 5
    end
    object qryFxTradinglinesAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
      Origin = 'tblfxtradinglines.Amount'
    end
    object qryFxTradinglinesBuyRate: TFloatField
      DisplayLabel = 'Rate'
      DisplayWidth = 10
      FieldName = 'BuyRate'
      Origin = 'tblfxtradinglines.BuyRate'
    end
    object qryFxTradinglinesEmployeeName: TWideStringField
      DisplayLabel = 'Employee'
      DisplayWidth = 50
      FieldName = 'EmployeeName'
      Origin = 'tblfxtradinglines.EmployeeName'
      Size = 50
    end
    object qryFxTradinglinesinLocalcurrency: TFloatField
      DisplayLabel = 'value'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'inLocalcurrency'
      currency = True
      Calculated = True
    end
    object qryFxTradinglinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblfxtradinglines.ID'
      Visible = False
    end
    object qryFxTradinglinesFxTradingID: TIntegerField
      DisplayWidth = 10
      FieldName = 'FxTradingID'
      Origin = 'tblfxtradinglines.FxTradingID'
      Visible = False
    end
    object qryFxTradinglinesGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblfxtradinglines.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryFxTradinglinesBuyCurrencyID: TIntegerField
      DisplayWidth = 10
      FieldName = 'BuyCurrencyID'
      Origin = 'tblfxtradinglines.BuyCurrencyID'
      Visible = False
    end
    object qryFxTradinglinesEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'tblfxtradinglines.EmployeeID'
      Visible = False
    end
    object qryFxTradinglinesmsTimestamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimestamp'
      Origin = 'tblfxtradinglines.msTimestamp'
      Visible = False
    end
    object qryFxTradinglinesmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblfxtradinglines.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
    object qryFxTradinglinesDeleted: TWideStringField
      FieldName = 'Deleted'
      Origin = 'tblfxtradinglines.Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object dsFxTradinglines: TDataSource
    DataSet = qryFxTradinglines
    Left = 365
    Top = 355
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
    Left = 267
    Top = 325
  end
  object qryForeignCurrency: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT CurrencyID, Country, Currency, Code, BuyRate , Active  '
      'FROM tblcurrencyconversion'
      'Where BuyRate <>0;')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 298
    Top = 325
  end
  object cbolinesEmployeeLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblEmployees.EmployeeID, EmployeeName  AS EmployeeName '
      'FROM tblEmployees '
      'WHERE (((tblEmployees.Active)<>'#39'F'#39')) '
      'ORDER BY EmployeeName;')
    AutoCalcFields = False
    Options.LongStrings = False
    Left = 235
    Top = 317
    object cbolinesEmployeeLookupEmployeeID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'EmployeeID'
      Origin = 'tblemployees.EmployeeID'
    end
    object cbolinesEmployeeLookupEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Origin = 'tblemployees.EmployeeName'
      Size = 255
    end
  end
  object qryBaseForeignCurrency: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT CurrencyID, Country, Currency, Code, BuyRate , Active  '
      'FROM tblcurrencyconversion'
      'Where BuyRate <>0;')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 194
    Top = 317
    object qryBaseForeignCurrencyCode: TWideStringField
      DisplayWidth = 10
      FieldName = 'Code'
      Origin = 'tblcurrencyconversion.Code'
      FixedChar = True
      Size = 3
    end
    object qryBaseForeignCurrencyCurrency: TWideStringField
      DisplayWidth = 20
      FieldName = 'Currency'
      Origin = 'tblcurrencyconversion.Currency'
      Size = 255
    end
    object qryBaseForeignCurrencyBuyRate: TFloatField
      DisplayLabel = 'Rate'
      DisplayWidth = 10
      FieldName = 'BuyRate'
      Origin = 'tblcurrencyconversion.BuyRate'
    end
    object qryBaseForeignCurrencyCurrencyID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'CurrencyID'
      Origin = 'tblcurrencyconversion.CurrencyID'
      Visible = False
    end
    object qryBaseForeignCurrencyCountry: TWideStringField
      FieldName = 'Country'
      Origin = 'tblcurrencyconversion.Country'
      Visible = False
      Size = 255
    end
    object qryBaseForeignCurrencyActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblcurrencyconversion.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
end
