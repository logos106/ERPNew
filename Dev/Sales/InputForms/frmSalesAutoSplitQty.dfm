inherited fmSalesAutoSplitQty: TfmSalesAutoSplitQty
  Left = 579
  Top = 332
  HelpContext = 1136002
  Caption = 'Allocate Qty into UOMs'
  ClientHeight = 428
  ClientWidth = 559
  ObjectMenuItem = CustomiseGrid
  Position = poMainFormCenter
  ExplicitLeft = 579
  ExplicitTop = 332
  ExplicitWidth = 575
  ExplicitHeight = 467
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 378
    Width = 559
    HelpContext = 1136003
    ExplicitTop = 223
    ExplicitWidth = 455
  end
  inherited shapehint: TShape
    Left = 64
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
    Left = 142
    Top = 10
    ExplicitLeft = 113
    ExplicitTop = 10
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 50
    Width = 559
    Height = 328
    HelpContext = 1136008
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 11
      Top = 283
      Width = 107
      Height = 18
      HelpContext = 1136009
      Caption = 'Total Allocated '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 274
      Top = 283
      Width = 123
      Height = 18
      HelpContext = 1136010
      Caption = 'Total Unallocated'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object grdLines: TwwDBGrid
      AlignWithMargins = True
      Left = 96
      Top = 77
      Width = 367
      Height = 177
      HelpContext = 1136011
      Margins.Left = 95
      Margins.Top = 20
      Margins.Right = 95
      Margins.Bottom = 30
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
        'Area;CustomEdit;cboLinesAreaCode;F')
      Selected.Strings = (
        'UOMWithMult'#9'20'#9'UOM'#9#9
        'Qty'#9'10'#9'UOM Qty'#9#9
        'singleQty'#9'10'#9'Qty'#9#9)
      MemoAttributes = [mSizeable, mWordWrap, mGridShow]
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = False
      Align = alTop
      DataSource = dsSalesautoSplitQtylines
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgRowResize]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -15
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = True
      OnCalcCellColors = grdLinesCalcCellColors
      OnColEnter = grdLinesColEnter
      OnEnter = grdLinesEnter
      FooterColor = clWhite
      FooterCellColor = clWhite
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
    end
    object grdHeader: TwwDBGrid
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 551
      Height = 50
      HelpContext = 1136012
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
        'Area;CustomEdit;cboLinesAreaCode;F')
      Selected.Strings = (
        'Productname'#9'36'#9'Product'
        'UOMwithmult'#9'11'#9'UOM'
        'Qty'#9'11'#9'Qty')
      MemoAttributes = [mSizeable, mWordWrap, mGridShow]
      IniAttributes.Delimiter = ';;'
      TitleColor = clInfoBk
      FixedCols = 0
      ShowHorzScrollBar = False
      ShowVertScrollBar = False
      Align = alTop
      DataSource = dsSalesautoSplitQty
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgRowResize]
      ParentFont = False
      TabOrder = 1
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = True
      OnEnter = grdHeaderEnter
      FooterColor = clWhite
      FooterCellColor = clWhite
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
      object grdHeaderIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 0
        Height = 22
        HelpContext = 1136013
        AllowAllUp = True
        Visible = False
      end
    end
    object wwDBEdit1: TwwDBEdit
      Left = 124
      Top = 280
      Width = 121
      Height = 25
      HelpContext = 1136014
      DataField = 'totalAllocated'
      DataSource = dsSalesautoSplitQty
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit2: TwwDBEdit
      Left = 403
      Top = 280
      Width = 121
      Height = 25
      HelpContext = 1136015
      DataField = 'totalUnAllocated'
      DataSource = dsSalesautoSplitQty
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 378
    Width = 559
    Height = 50
    HelpContext = 1136016
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      559
      50)
    object cmdClose: TDNMSpeedButton
      Left = 81
      Top = 6
      Width = 93
      Height = 29
      HelpContext = 1136017
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
      Left = 386
      Top = 6
      Width = 93
      Height = 29
      HelpContext = 1136018
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
    object btnAutoAllocate: TDNMSpeedButton
      Left = 233
      Top = 6
      Width = 93
      Height = 29
      Hint = '"Add A New Entry"'
      HelpContext = 1136019
      Anchors = [akBottom]
      Caption = 'Auto Allocate'
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
      TabOrder = 2
      TabStop = False
      OnClick = btnAutoAllocateClick
    end
  end
  object DNMPanel1: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 559
    Height = 50
    HelpContext = 1136004
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
    DesignSize = (
      559
      50)
    object pnlTitle: TDNMPanel
      Left = 70
      Top = 4
      Width = 409
      Height = 39
      HelpContext = 1136005
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
        HelpContext = 1136006
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
          HelpContext = 1136007
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Allocate Qty into UOMs'
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
    Left = 133
    Top = 215
  end
  inherited tmrdelay: TTimer
    Left = 279
    Top = 215
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 170
    Top = 215
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 315
    Top = 215
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
    Left = 352
    Top = 215
  end
  inherited DataState: TDataState
    Left = 206
    Top = 215
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 388
    Top = 215
    inherited CustomiseGrid: TMenuItem
      Enabled = False
    end
  end
  inherited imgsort: TImageList
    Left = 243
    Top = 215
    Bitmap = {
      494C01010200A400AC0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 97
    Top = 215
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 425
    Top = 215
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 472
    Top = 248
  end
  object qrySalesautoSplitQty: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblSalesautoSplitQty')
    OnCalcFields = qrySalesautoSplitQtyCalcFields
    Left = 35
    Top = 215
    object qrySalesautoSplitQtyProductname: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 36
      FieldName = 'Productname'
      Origin = 'tblsalesautosplitqty.Productname'
      Size = 100
    end
    object qrySalesautoSplitQtyUOMwithmult: TWideStringField
      DisplayLabel = 'UOM'
      DisplayWidth = 11
      FieldKind = fkCalculated
      FieldName = 'UOMwithmult'
      Calculated = True
    end
    object qrySalesautoSplitQtyQty: TFloatField
      DisplayWidth = 11
      FieldName = 'Qty'
      Origin = 'tblsalesautosplitqty.Qty'
    end
    object qrySalesautoSplitQtyUOMMultiplier: TFloatField
      DisplayWidth = 10
      FieldName = 'UOMMultiplier'
      Origin = 'tblsalesautosplitqty.UOMMultiplier'
      Visible = False
    end
    object qrySalesautoSplitQtyUOM: TWideStringField
      DisplayWidth = 20
      FieldName = 'UOM'
      Origin = 'tblsalesautosplitqty.UOM'
      Visible = False
      Size = 100
    end
    object qrySalesautoSplitQtyID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblsalesautosplitqty.ID'
      Visible = False
    end
    object qrySalesautoSplitQtyGlobalRef: TWideStringField
      DisplayWidth = 50
      FieldName = 'GlobalRef'
      Origin = 'tblsalesautosplitqty.GlobalRef'
      Visible = False
      Size = 50
    end
    object qrySalesautoSplitQtyProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'tblsalesautosplitqty.ProductID'
      Visible = False
    end
    object qrySalesautoSplitQtyUOMID: TIntegerField
      DisplayWidth = 10
      FieldName = 'UOMID'
      Origin = 'tblsalesautosplitqty.UOMID'
      Visible = False
    end
    object qrySalesautoSplitQtymstimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'mstimeStamp'
      Origin = 'tblsalesautosplitqty.mstimeStamp'
      Visible = False
    end
    object qrySalesautoSplitQtymsUpdatesiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdatesiteCode'
      Origin = 'tblsalesautosplitqty.msUpdatesiteCode'
      Visible = False
      Size = 3
    end
    object qrySalesautoSplitQtytotalAllocated: TFloatField
      FieldKind = fkCalculated
      FieldName = 'totalAllocated'
      Visible = False
      Calculated = True
    end
    object qrySalesautoSplitQtytotalUnAllocated: TFloatField
      FieldKind = fkCalculated
      FieldName = 'totalUnAllocated'
      Visible = False
      Calculated = True
    end
    object qrySalesautoSplitQtysaleRef: TWideStringField
      FieldName = 'saleRef'
      Origin = 'tblsalesautosplitqty.saleRef'
      Visible = False
      Size = 255
    end
    object qrySalesautoSplitQtySaleLineRef: TWideStringField
      FieldName = 'SaleLineRef'
      Origin = 'tblsalesautosplitqty.SaleLineRef'
      Visible = False
      Size = 255
    end
  end
  object dsSalesautoSplitQty: TDataSource
    DataSet = qrySalesautoSplitQty
    Left = 35
    Top = 243
  end
  object qrySalesautoSplitQtylines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblSalesautoSplitQtylines')
    OnCalcFields = qrySalesautoSplitQtylinesCalcFields
    Left = 66
    Top = 215
    object qrySalesautoSplitQtylinesUOMWithMult: TWideStringField
      DisplayLabel = 'UOM'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'UOMWithMult'
      Calculated = True
    end
    object qrySalesautoSplitQtylinesQty: TFloatField
      DisplayLabel = 'UOM Qty'
      DisplayWidth = 10
      FieldName = 'Qty'
      Origin = 'tblsalesautosplitqtylines.Qty'
    end
    object qrySalesautoSplitQtylinessingleQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'singleQty'
      Calculated = True
    end
    object qrySalesautoSplitQtylinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblsalesautosplitqtylines.ID'
      Visible = False
    end
    object qrySalesautoSplitQtylinesGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblsalesautosplitqtylines.GlobalRef'
      Visible = False
      Size = 50
    end
    object qrySalesautoSplitQtylinesHeaderID: TIntegerField
      FieldName = 'HeaderID'
      Origin = 'tblsalesautosplitqtylines.HeaderID'
      Visible = False
    end
    object qrySalesautoSplitQtylinesUOMID: TIntegerField
      FieldName = 'UOMID'
      Origin = 'tblsalesautosplitqtylines.UOMID'
      Visible = False
    end
    object qrySalesautoSplitQtylinesUOMMultiplier: TFloatField
      FieldName = 'UOMMultiplier'
      Origin = 'tblsalesautosplitqtylines.UOMMultiplier'
      Visible = False
    end
    object qrySalesautoSplitQtylinesUOM: TWideStringField
      FieldName = 'UOM'
      Origin = 'tblsalesautosplitqtylines.UOM'
      Visible = False
      Size = 100
    end
    object qrySalesautoSplitQtylinesmstimeStamp: TDateTimeField
      FieldName = 'mstimeStamp'
      Origin = 'tblsalesautosplitqtylines.mstimeStamp'
      Visible = False
    end
    object qrySalesautoSplitQtylinesmsUpdatesiteCode: TWideStringField
      FieldName = 'msUpdatesiteCode'
      Origin = 'tblsalesautosplitqtylines.msUpdatesiteCode'
      Visible = False
      Size = 3
    end
    object qrySalesautoSplitQtylinesSaleLineRef: TWideStringField
      FieldName = 'SaleLineRef'
      Origin = 'tblsalesautosplitqtylines.SaleLineRef'
      Visible = False
      Size = 255
    end
  end
  object dsSalesautoSplitQtylines: TDataSource
    DataSet = qrySalesautoSplitQtylines
    Left = 66
    Top = 243
  end
end
