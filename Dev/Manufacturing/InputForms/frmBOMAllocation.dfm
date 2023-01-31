inherited fmBOMAllocation: TfmBOMAllocation
  Left = 533
  Top = 214
  HelpContext = 1046002
  Caption = 'Build Allocation'
  ClientWidth = 810
  ExplicitLeft = 533
  ExplicitTop = 214
  ExplicitWidth = 826
  DesignSize = (
    810
    532)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 460
    Width = 810
    HelpContext = 1046003
    ExplicitTop = 467
    ExplicitWidth = 639
  end
  inherited shapehint: TShape
    Left = 7
    ExplicitLeft = 2
  end
  inherited shapehintextra1: TShape
    Left = 42
    ExplicitLeft = 30
  end
  object DNMPanel3: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 810
    Height = 115
    HelpContext = 1046012
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Bevel1: TBevel
      Left = 1
      Top = 64
      Width = 808
      Height = 50
      HelpContext = 1046024
      Align = alBottom
      ExplicitTop = 73
      ExplicitWidth = 558
    end
    object Label1: TLabel
      Left = 9
      Top = 69
      Width = 56
      Height = 15
      HelpContext = 1046013
      Caption = 'Trans ID #'
    end
    object Label2: TLabel
      Left = 105
      Top = 69
      Width = 45
      Height = 15
      HelpContext = 1046014
      Caption = 'Product'
    end
    object Label13: TLabel
      Left = 404
      Top = 69
      Width = 81
      Height = 15
      HelpContext = 1046025
      Caption = 'Receive Batch'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object pnlTitle: TDNMPanel
      Left = 227
      Top = 13
      Width = 317
      Height = 35
      HelpContext = 1046015
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
        Width = 313
        Height = 31
        HelpContext = 1046016
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
          Width = 313
          Height = 31
          HelpContext = 1046017
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Build Allocation'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = -2
        end
      end
    end
    object wwDBEdit1: TwwDBEdit
      Left = 9
      Top = 87
      Width = 71
      Height = 23
      HelpContext = 1046018
      DataField = 'SaleID'
      DataSource = DSDetails
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit2: TwwDBEdit
      Left = 105
      Top = 87
      Width = 290
      Height = 23
      HelpContext = 1046019
      DataField = 'ProductName'
      DataSource = DSDetails
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnKeyPress = wwDBEdit2KeyPress
    end
    object edtBatch: TEdit
      Left = 404
      Top = 87
      Width = 147
      Height = 23
      HelpContext = 1046026
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnKeyPress = wwDBEdit2KeyPress
    end
  end
  object DNMPanel1: TDNMPanel [6]
    Left = 0
    Top = 115
    Width = 810
    Height = 345
    HelpContext = 1046004
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object lblMsg: TLabel
      Left = 1
      Top = 329
      Width = 808
      Height = 15
      HelpContext = 1046027
      Align = alBottom
      Alignment = taCenter
      Caption = 'lblMsg'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
      ExplicitWidth = 37
    end
    object grdTransactions: TwwDBGrid
      AlignWithMargins = True
      Left = 9
      Top = 9
      Width = 792
      Height = 312
      HelpContext = 1046005
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      ControlType.Strings = (
        'Transdate;CustomEdit;dtTransDate;F')
      Selected.Strings = (
        'linecaption'#9'20'#9'Product'#9'T'
        'PQAallocation'#9'1'#9'Allocate'#9'T'
        'ManufactureUOMQty'#9'10'#9'To Build'#9'T'#9'Transaction Quantity'
        'FromStockUOMQty'#9'10'#9'From Stock'#9'T'#9'Transaction Quantity'
        'OnOrderUOMQty'#9'10'#9'On Order'#9'T'#9'Transaction Quantity'
        'DoneQty'#9'10'#9'Built / Used'#9'T'
        'InQty'#9'10'#9'To Be Built'#9'T'#9'Quantity'
        'outQty'#9'10'#9'To be Used'#9'T'#9'Quantity'
        'ManufacturedQty'#9'10'#9'Built'#9'T'#9'Quantity'
        'ManufacturingQty'#9'10'#9'Used'#9'T'#9'Quantity'
        'uomdetail'#9'10'#9'UOM'#9'T')
      MemoAttributes = [mSizeable, mWordWrap, mGridShow]
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsTree
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgRowResize]
      ParentFont = False
      PopupMenu = popMain
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
      OnCalcCellColors = grdTransactionsCalcCellColors
      OnDblClick = grdTransactionsDblClick
      OnMouseUp = grdTransactionsMouseUp
      FooterColor = clWhite
      FooterCellColor = clWhite
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
    end
    object dtTransDate: TwwDBDateTimePicker
      Left = 288
      Top = 144
      Width = 121
      Height = 23
      HelpContext = 1046006
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'Tahoma'
      CalendarAttributes.Font.Style = []
      DataField = 'Transdate'
      DataSource = dsTree
      Epoch = 1950
      PopupMenu = popMain
      ShowButton = True
      TabOrder = 1
    end
  end
  object DNMPanel2: TDNMPanel [7]
    Left = 0
    Top = 460
    Width = 810
    Height = 72
    HelpContext = 1046007
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      810
      72)
    object btncancel: TDNMSpeedButton
      Left = 702
      Top = 30
      Width = 75
      Height = 27
      HelpContext = 1046008
      Anchors = [akBottom]
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = btncancelClick
    end
    object btnclose: TDNMSpeedButton
      Left = 34
      Top = 30
      Width = 75
      Height = 27
      HelpContext = 1046009
      Anchors = [akBottom]
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = btncloseClick
    end
    object btnAutoAllocate: TDNMSpeedButton
      Left = 173
      Top = 30
      Width = 147
      Height = 27
      HelpContext = 1046010
      Anchors = [akBottom]
      Caption = 'Auto Allocate from Order'
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
      AutoDisableParentOnclick = True
      OnClick = btnAutoAllocateClick
    end
    object btnPrint: TDNMSpeedButton
      Left = 580
      Top = 30
      Width = 75
      Height = 27
      HelpContext = 1046011
      Anchors = [akBottom]
      Caption = 'Print'
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
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnPrintClick
    end
    object btnFinishedGoodLabel: TDNMSpeedButton
      Left = 396
      Top = 30
      Width = 125
      Height = 27
      HelpContext = 1046023
      Anchors = [akBottom]
      Caption = 'Finished Goods Label'
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
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnFinishedGoodLabelClick
    end
    object ChkChooseRpt: TCheckBox
      Left = 258
      Top = 8
      Width = 154
      Height = 16
      Caption = 'Choose &Template'
      TabOrder = 5
      HelpContext = 1046028
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 431
    Top = 295
  end
  inherited tmrdelay: TTimer
    Left = 464
    Top = 295
  end
  inherited popSpelling: TPopupMenu
    Left = 139
    Top = 295
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 269
    Top = 295
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 301
    Top = 295
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
    Left = 74
    Top = 295
  end
  inherited DataState: TDataState
    Left = 366
    Top = 295
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 171
    Top = 295
  end
  inherited imgsort: TImageList
    Left = 399
    Top = 295
    Bitmap = {
      494C010102000401680110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 42
    Top = 295
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 334
    Top = 295
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 204
    Top = 295
  end
  inherited qryMemTrans: TERPQuery
    Left = 106
    Top = 295
  end
  object QryTree: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tmp_BOMAllocation_Admin_FB9B95BA')
    BeforeOpen = QryTreeBeforeOpen
    Left = 56
    Top = 345
    object QryTreeuomdetail: TWideStringField
      DisplayLabel = 'UOM'
      DisplayWidth = 15
      FieldName = 'uomdetail'
      Origin = 'uomDetail'
      Size = 125
    end
    object QryTreeManufactureUOMQty: TFloatField
      DisplayWidth = 10
      FieldName = 'ManufactureUOMQty'
      Origin = 'ManufactureUOMQty'
      DisplayFormat = '#######0.00'
    end
    object QryTreeFromStockUOMQty: TFloatField
      DisplayWidth = 10
      FieldName = 'FromStockUOMQty'
      Origin = 'FromStockUOMQty'
      DisplayFormat = '#######0.00'
    end
    object QryTreeOnOrderUOMQty: TFloatField
      DisplayWidth = 10
      FieldName = 'OnOrderUOMQty'
      Origin = 'OnOrderUOMQty'
      DisplayFormat = '#######0.00'
    end
    object QryTreeInQty: TFloatField
      DisplayWidth = 10
      FieldName = 'InQty'
      Origin = 'InQty'
      DisplayFormat = '#######0.00'
    end
    object QryTreeSOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'SOQty'
      Origin = 'SOQty'
      DisplayFormat = '#######0.00'
    end
    object QryTreeDoneQty: TFloatField
      DisplayWidth = 10
      FieldName = 'DoneQty'
      Origin = 'DoneQty'
      DisplayFormat = '#######0.00'
    end
    object QryTreeoutQty: TFloatField
      DisplayWidth = 10
      FieldName = 'outQty'
      Origin = 'OutQty'
      DisplayFormat = '#######0.00'
    end
    object QryTreeManufacturingQty: TFloatField
      DisplayWidth = 10
      FieldName = 'ManufacturingQty'
      Origin = 'ManufacturingQty'
      DisplayFormat = '#######0.00'
    end
    object QryTreeManufacturedQty: TFloatField
      DisplayWidth = 10
      FieldName = 'ManufacturedQty'
      Origin = 'ManufacturedQty'
      DisplayFormat = '#######0.00'
    end
    object QryTreelevel: TIntegerField
      DisplayWidth = 10
      FieldName = 'level'
      Origin = 'Level'
      Visible = False
    end
    object QryTreeoutPQAID: TIntegerField
      DisplayWidth = 10
      FieldName = 'outPQAID'
      Origin = 'OutPQAID'
      Visible = False
    end
    object QryTreeparentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'parentID'
      Origin = 'ParentID'
      Visible = False
    end
    object QryTreeproctreeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'proctreeID'
      Origin = 'ProctreeID'
      Visible = False
    end
    object QryTreeProctreePartID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProctreePartID'
      Origin = 'ProctreePartID'
      Visible = False
    end
    object QryTreesaleId: TIntegerField
      DisplayWidth = 10
      FieldName = 'saleId'
      Origin = 'SaleID'
      Visible = False
    end
    object QryTreeSalelineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SalelineID'
      Origin = 'SalelineID'
      Visible = False
    end
    object QryTreeTransdate: TDateTimeField
      DisplayLabel = 'Date'
      DisplayWidth = 10
      FieldName = 'Transdate'
      Origin = 'TRansdate'
      OnChange = QryTreeTransdateChange
    end
    object QryTreeSequencedown: TIntegerField
      DisplayWidth = 10
      FieldName = 'Sequencedown'
      Origin = 'Sequencedown'
      Visible = False
    end
    object QryTreeSOPQAID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SOPQAID'
      Origin = 'SOPQAID'
      Visible = False
    end
    object QryTreeFromStockQty: TFloatField
      DisplayWidth = 10
      FieldName = 'FromStockQty'
      Origin = 'FromStockQty'
      Visible = False
      DisplayFormat = '#######0.00'
    end
    object QryTreeInPQAID: TIntegerField
      DisplayWidth = 10
      FieldName = 'InPQAID'
      Origin = 'InPQAID'
      Visible = False
    end
    object QryTreeManufactureQty: TFloatField
      DisplayWidth = 10
      FieldName = 'ManufactureQty'
      Origin = 'ManufactureQty'
      Visible = False
      DisplayFormat = '#######0.00'
    end
    object QryTreeOnOrderQty: TFloatField
      DisplayWidth = 10
      FieldName = 'OnOrderQty'
      Origin = 'OnOrderQty'
      Visible = False
      DisplayFormat = '#######0.00'
    end
    object QryTreeCaption: TWideStringField
      DisplayWidth = 255
      FieldName = 'Caption'
      Origin = 'Caption'
      Visible = False
      Size = 255
    end
    object QryTreepartType: TWideStringField
      DisplayWidth = 255
      FieldName = 'partType'
      Origin = 'partType'
      Visible = False
    end
    object QryTreeStockQty: TFloatField
      FieldName = 'StockQty'
      Origin = 'StockQty'
      DisplayFormat = '#######0.00'
    end
    object QryTreeuomStockQty: TFloatField
      FieldName = 'uomStockQty'
      Origin = 'uomStockQty'
      DisplayFormat = '#######0.00'
    end
    object QryTreeLineCaption: TWideStringField
      FieldName = 'LineCaption'
      Origin = 'LineCaption'
      Size = 255
    end
    object QryTreeuomid: TIntegerField
      FieldName = 'uomid'
      Origin = 'uomid'
    end
    object QryTreeuommult: TFloatField
      FieldName = 'uommult'
      Origin = 'uommult'
    end
    object QryTreeuom: TWideStringField
      FieldName = 'uom'
      Origin = 'uom'
      Size = 100
    end
    object QryTreePQAallocation: TWideStringField
      FieldName = 'PQAallocation'
      Origin = 'PQAallocation'
      Size = 1
    end
    object QryTreeBatch: TWideStringField
      FieldName = 'Batch'
      Origin = 'Batch'
      FixedChar = True
      Size = 1
    end
    object QryTreeAllocated: TWideStringField
      FieldName = 'Allocated'
      Origin = 'Allocated'
      FixedChar = True
      Size = 1
    end
    object QryTreeUSebins: TWideStringField
      FieldName = 'USebins'
      Origin = 'USebins'
      FixedChar = True
      Size = 1
    end
    object QryTreeSNTRacking: TWideStringField
      FieldName = 'SNTRacking'
      Origin = 'SNTRacking'
      FixedChar = True
      Size = 1
    end
    object QryTreeID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
    end
    object QryTreeProductId: TIntegerField
      FieldName = 'ProductId'
      Origin = 'ProductID'
    end
  end
  object dsTree: TDataSource
    DataSet = QryTree
    Left = 56
    Top = 376
  end
  object AdvPopupMenu1: TAdvPopupMenu
    Version = '2.5.3.4'
    Left = 688
    Top = 193
    object CopyAllocationFromtheReceivedOrder1: TMenuItem
      Caption = 'Copy Allocation From the Received Order'
      HelpContext = 1046020
    end
  end
  object tblMaster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblsales'
      'Where (SaleID = :ID);')
    Left = 91
    Top = 345
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblMasterSaleID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'SaleID'
      Origin = 'tblsales.SaleID'
      ReadOnly = True
    end
    object tblMasterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblsales.GlobalRef'
      Size = 255
    end
    object tblMasterInvoiceDocNumber: TWideStringField
      FieldName = 'InvoiceDocNumber'
      Origin = 'tblsales.InvoiceDocNumber'
      Size = 30
    end
    object tblMasterOriginalNo: TWideStringField
      FieldName = 'OriginalNo'
      Origin = 'tblsales.OriginalNo'
      Size = 50
    end
    object tblMasterAccount: TWideStringField
      FieldName = 'Account'
      Origin = 'tblsales.Account'
      Size = 255
    end
    object tblMasterCustomerName: TWideStringField
      FieldName = 'CustomerName'
      Origin = 'tblsales.CustomerName'
      Size = 255
    end
    object tblMasterInvoiceTo: TWideStringField
      FieldName = 'InvoiceTo'
      Origin = 'tblsales.InvoiceTo'
      Size = 255
    end
    object tblMasterShipTo: TWideStringField
      FieldName = 'ShipTo'
      Origin = 'tblsales.ShipTo'
      Size = 255
    end
    object tblMasterSaleDate: TDateField
      FieldName = 'SaleDate'
      Origin = 'tblsales.SaleDate'
    end
    object tblMasterTotalTax: TFloatField
      FieldName = 'TotalTax'
      Origin = 'tblsales.TotalTax'
      DisplayFormat = '$#0.00###'
      EditFormat = '$#0.00###'
      currency = True
    end
    object tblMasterTotalAmount: TFloatField
      FieldName = 'TotalAmount'
      Origin = 'tblsales.TotalAmount'
      currency = True
    end
    object tblMasterTotalAmountInc: TFloatField
      FieldName = 'TotalAmountInc'
      Origin = 'tblsales.TotalAmountInc'
      currency = True
    end
    object tblMasterTotalMarkup: TFloatField
      FieldName = 'TotalMarkup'
      Origin = 'tblsales.TotalMarkup'
      currency = True
    end
    object tblMasterTotalDiscount: TFloatField
      FieldName = 'TotalDiscount'
      Origin = 'tblsales.TotalDiscount'
      currency = True
    end
    object tblMasterEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Origin = 'tblsales.EmployeeName'
      Size = 255
    end
    object tblMasterClass: TWideStringField
      FieldName = 'Class'
      Origin = 'tblsales.Class'
      Size = 255
    end
    object tblMasterOrderNumber: TWideStringField
      FieldName = 'OrderNumber'
      Origin = 'tblsales.OrderNumber'
      Size = 30
    end
    object tblMasterPONumber: TWideStringField
      FieldName = 'PONumber'
      Origin = 'tblsales.PONumber'
      Size = 30
    end
    object tblMasterShipDate: TDateField
      FieldName = 'ShipDate'
      Origin = 'tblsales.ShipDate'
    end
    object tblMasterDueDate: TDateField
      FieldName = 'DueDate'
      Origin = 'tblsales.DueDate'
    end
    object tblMasterConNote: TWideStringField
      FieldName = 'ConNote'
      Origin = 'tblsales.ConNote'
      Size = 25
    end
    object tblMasterInvoicePrintDesc: TWideStringField
      FieldName = 'InvoicePrintDesc'
      Origin = 'tblsales.InvoicePrintDesc'
      Size = 255
    end
    object tblMasterPickMemo: TWideMemoField
      FieldName = 'PickMemo'
      Origin = 'tblsales.PickMemo'
      BlobType = ftWideMemo
      Size = 255
    end
    object tblMasterPrintHold: TWideStringField
      FieldName = 'PrintHold'
      Origin = 'tblsales.PrintHold'
      FixedChar = True
      Size = 1
    end
    object tblMasterShipping: TWideStringField
      FieldName = 'Shipping'
      Origin = 'tblsales.Shipping'
      Size = 255
    end
    object tblMasterTerms: TWideStringField
      FieldName = 'Terms'
      Origin = 'tblsales.Terms'
      Size = 255
    end
    object tblMasterPayMethod: TWideStringField
      FieldName = 'PayMethod'
      Origin = 'tblsales.PayMethod'
      Size = 50
    end
    object tblMasterPayDueDate: TWideStringField
      FieldName = 'PayDueDate'
      Origin = 'tblsales.PayDueDate'
      Size = 11
    end
    object tblMasterPaid: TWideStringField
      FieldName = 'Paid'
      Origin = 'tblsales.Paid'
      FixedChar = True
      Size = 1
    end
    object tblMasterBalance: TFloatField
      FieldName = 'Balance'
      Origin = 'tblsales.Balance'
      currency = True
    end
    object tblMasterPayment: TFloatField
      FieldName = 'Payment'
      Origin = 'tblsales.Payment'
    end
    object tblMasterApplyFlag: TWideStringField
      FieldName = 'ApplyFlag'
      Origin = 'tblsales.ApplyFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterAmountDue: TFloatField
      FieldName = 'AmountDue'
      Origin = 'tblsales.AmountDue'
      currency = True
    end
    object tblMasterTimeOfSale: TWideStringField
      FieldName = 'TimeOfSale'
      Origin = 'tblsales.TimeOfSale'
      Size = 11
    end
    object tblMasterPOS: TWideStringField
      FieldName = 'POS'
      Origin = 'tblsales.POS'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsCashSale: TWideStringField
      FieldName = 'IsCashSale'
      Origin = 'tblsales.IsCashSale'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsInvoice: TWideStringField
      FieldName = 'IsInvoice'
      Origin = 'tblsales.IsInvoice'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsQuote: TWideStringField
      FieldName = 'IsQuote'
      Origin = 'tblsales.IsQuote'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsSalesOrder: TWideStringField
      FieldName = 'IsSalesOrder'
      Origin = 'tblsales.IsSalesOrder'
      FixedChar = True
      Size = 1
    end
    object tblMasterDeleted: TWideStringField
      FieldName = 'Deleted'
      Origin = 'tblsales.Deleted'
      FixedChar = True
      Size = 1
    end
    object tblMasterCancelled: TWideStringField
      FieldName = 'Cancelled'
      Origin = 'tblsales.Cancelled'
      FixedChar = True
      Size = 1
    end
    object tblMasterEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblsales.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsRefund: TWideStringField
      FieldName = 'IsRefund'
      Origin = 'tblsales.IsRefund'
      FixedChar = True
      Size = 1
    end
    object tblMasterTotalQuoteAmount: TFloatField
      FieldName = 'TotalQuoteAmount'
      Origin = 'tblsales.TotalQuoteAmount'
      currency = True
    end
    object tblMasterBOID: TWideStringField
      FieldName = 'BOID'
      Origin = 'tblsales.BOID'
      Size = 255
    end
    object tblMasterClassID: TIntegerField
      FieldName = 'ClassID'
      Origin = 'tblsales.ClassID'
    end
    object tblMasterChequeNo: TWideStringField
      FieldName = 'ChequeNo'
      Origin = 'tblsales.ChequeNo'
      Size = 45
    end
    object tblMasterClientID: TIntegerField
      FieldName = 'ClientID'
      Origin = 'tblsales.ClientID'
    end
    object tblMasterAccountID: TIntegerField
      FieldName = 'AccountID'
      Origin = 'tblsales.AccountID'
    end
    object tblMasterEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblsales.EmployeeID'
    end
    object tblMasterIsLayby: TWideStringField
      FieldName = 'IsLayby'
      Origin = 'tblsales.IsLayby'
      FixedChar = True
      Size = 1
    end
    object tblMasterLaybyID: TWideStringField
      FieldName = 'LaybyID'
      Origin = 'tblsales.LaybyID'
      Size = 14
    end
    object tblMasterIsPOS: TWideStringField
      FieldName = 'IsPOS'
      Origin = 'tblsales.IsPOS'
      FixedChar = True
      Size = 1
    end
    object tblMasterDeposited: TWideStringField
      FieldName = 'Deposited'
      Origin = 'tblsales.Deposited'
      FixedChar = True
      Size = 1
    end
    object tblMasterHoldSale: TWideStringField
      FieldName = 'HoldSale'
      Origin = 'tblsales.HoldSale'
      FixedChar = True
      Size = 1
    end
    object tblMasterMemo: TWideMemoField
      FieldName = 'Memo'
      Origin = 'tblsales.Memo'
      BlobType = ftWideMemo
    end
    object tblMasterComments: TWideMemoField
      FieldName = 'Comments'
      Origin = 'tblsales.Comments'
      BlobType = ftWideMemo
    end
    object tblMasterEnteredBy: TWideStringField
      FieldName = 'EnteredBy'
      Origin = 'tblsales.EnteredBy'
      Size = 255
    end
    object tblMasterEnteredAt: TWideStringField
      FieldName = 'EnteredAt'
      Origin = 'tblsales.EnteredAt'
      Size = 255
    end
    object tblMasterSOBalance: TFloatField
      FieldName = 'SOBalance'
      Origin = 'tblsales.SOBalance'
    end
    object tblMasterFreezeQuoteAmount: TWideStringField
      FieldName = 'FreezeQuoteAmount'
      Origin = 'tblsales.FreezeQuoteAmount'
      FixedChar = True
      Size = 1
    end
    object tblMasterConverted: TWideStringField
      FieldName = 'Converted'
      Origin = 'tblsales.Converted'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsVoucher: TWideStringField
      FieldName = 'IsVoucher'
      Origin = 'tblsales.IsVoucher'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsLaybyTOS: TWideStringField
      FieldName = 'IsLaybyTOS'
      Origin = 'tblsales.IsLaybyTOS'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsLaybyPayment: TWideStringField
      FieldName = 'IsLaybyPayment'
      Origin = 'tblsales.IsLaybyPayment'
      FixedChar = True
      Size = 1
    end
    object tblMasterTillID: TSmallintField
      FieldName = 'TillID'
      Origin = 'tblsales.TillID'
    end
    object tblMasterCommissionPaid: TWideStringField
      FieldName = 'CommissionPaid'
      Origin = 'tblsales.CommissionPaid'
      FixedChar = True
      Size = 1
    end
    object tblMasterPickupFrom: TWideStringField
      FieldName = 'PickupFrom'
      Origin = 'tblsales.PickupFrom'
      Size = 255
    end
    object tblMasterIsManifest: TWideStringField
      FieldName = 'IsManifest'
      Origin = 'tblsales.IsManifest'
      FixedChar = True
      Size = 1
    end
    object tblMasterUsedOnManifest: TWideStringField
      FieldName = 'UsedOnManifest'
      Origin = 'tblsales.UsedOnManifest'
      FixedChar = True
      Size = 1
    end
    object tblMasterAddToManifest: TWideStringField
      FieldName = 'AddToManifest'
      Origin = 'tblsales.AddToManifest'
      FixedChar = True
      Size = 1
    end
    object tblMasterQuoteGlobalRef: TWideStringField
      FieldName = 'QuoteGlobalRef'
      Origin = 'tblsales.QuoteGlobalRef'
      Size = 255
    end
    object tblMasterSalesOrderGlobalRef: TWideStringField
      FieldName = 'SalesOrderGlobalRef'
      Origin = 'tblsales.SalesOrderGlobalRef'
      Size = 255
    end
    object tblMasterIsBarcodePicking: TWideStringField
      FieldName = 'IsBarcodePicking'
      Origin = 'tblsales.IsBarcodePicking'
      FixedChar = True
      Size = 1
    end
    object tblMasterBarcodePickingDone: TWideStringField
      FieldName = 'BarcodePickingDone'
      Origin = 'tblsales.BarcodePickingDone'
      FixedChar = True
      Size = 1
    end
    object tblMasterARNotes: TWideMemoField
      FieldName = 'ARNotes'
      Origin = 'tblsales.ARNotes'
      BlobType = ftWideMemo
    end
    object tblMasterOriginalCreationDate: TDateField
      FieldName = 'OriginalCreationDate'
      Origin = 'tblsales.OriginalCreationDate'
    end
    object tblMasterQuoteStatus: TWideStringField
      FieldName = 'QuoteStatus'
      Origin = 'tblsales.QuoteStatus'
      Size = 255
    end
    object tblMasterTotalWETTax: TFloatField
      FieldName = 'TotalWETTax'
      Origin = 'tblsales.TotalWETTax'
    end
    object tblMasterTotalWEGTax: TFloatField
      FieldName = 'TotalWEGTax'
      Origin = 'tblsales.TotalWEGTax'
    end
    object tblMasterLastUpdated: TDateTimeField
      FieldName = 'LastUpdated'
      Origin = 'tblsales.LastUpdated'
    end
    object tblMasterRepairGlobalRef: TWideStringField
      FieldName = 'RepairGlobalRef'
      Origin = 'tblsales.RepairGlobalRef'
      Size = 255
    end
    object tblMasterForeignExchangeCode: TWideStringField
      FieldName = 'ForeignExchangeCode'
      Origin = 'tblsales.ForeignExchangeCode'
      FixedChar = True
      Size = 3
    end
    object tblMasterForeignExchangeRate: TFloatField
      FieldName = 'ForeignExchangeRate'
      Origin = 'tblsales.ForeignExchangeRate'
    end
    object tblMasterForeignTotalAmount: TFloatField
      FieldName = 'ForeignTotalAmount'
      Origin = 'tblsales.ForeignTotalAmount'
      DisplayFormat = '###,###,###,##0.00;(###,###,###,##0.00)'
    end
    object tblMasterForeignPaidAmount: TFloatField
      FieldName = 'ForeignPaidAmount'
      Origin = 'tblsales.ForeignPaidAmount'
    end
    object tblMasterForeignBalanceAmount: TFloatField
      FieldName = 'ForeignBalanceAmount'
      Origin = 'tblsales.ForeignBalanceAmount'
    end
    object tblMasterBaseNo: TWideStringField
      FieldName = 'BaseNo'
      Origin = 'tblsales.BaseNo'
      Size = 255
    end
    object tblMasterSaleDateTime: TDateTimeField
      FieldName = 'SaleDateTime'
      Origin = 'tblsales.SaleDateTime'
    end
    object tblMasterContactID: TLargeintField
      FieldName = 'ContactID'
      Origin = 'tblsales.contactID'
    end
    object tblMasterContactName: TWideStringField
      FieldName = 'ContactName'
      Origin = 'tblsales.ContactName'
      Size = 100
    end
    object tblMasterRepairID: TLargeintField
      FieldName = 'RepairID'
      Origin = 'tblsales.RepairID'
    end
    object tblMasterPOCreated: TWideStringField
      FieldName = 'POCreated'
      Origin = 'tblsales.POCreated'
      FixedChar = True
      Size = 1
    end
    object tblMasterFutureSO: TWideStringField
      FieldName = 'FutureSO'
      Origin = 'tblsales.FutureSO'
      FixedChar = True
      Size = 1
    end
    object tblMasterAutoSmartOrderRef: TWideStringField
      FieldName = 'AutoSmartOrderRef'
      Origin = 'tblsales.AutoSmartOrderRef'
      Size = 255
    end
    object tblMasterIsInternalOrder: TWideStringField
      FieldName = 'IsInternalOrder'
      Origin = 'tblsales.IsInternalOrder'
      FixedChar = True
      Size = 1
    end
    object tblMasterNoOfBoxes: TLargeintField
      FieldName = 'NoOfBoxes'
      Origin = 'tblsales.NoOfBoxes'
    end
    object tblMasterContributionAmount: TFloatField
      FieldName = 'ContributionAmount'
      currency = True
    end
    object tblMasterSOProgressPaymentGlobalRef: TWideStringField
      FieldName = 'SOProgressPaymentGlobalRef'
      Origin = 'tblsales.SOProgressPaymentGlobalRef'
      Size = 255
    end
    object tblMasterSOProgressPaymentOriginalRef: TWideStringField
      FieldName = 'SOProgressPaymentOriginalRef'
      Origin = 'tblsales.SOProgressPaymentOriginalRef'
      Size = 255
    end
    object tblMasterShipToID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ShipToID'
      Visible = False
    end
    object tblMasterSalesCategory: TWideStringField
      FieldName = 'SalesCategory'
      Size = 255
    end
  end
  object tblDetails: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblsaleslines'
      'WHERE SaleID = :ID')
    Left = 127
    Top = 345
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblDetailsPartBarcode: TWideStringField
      DisplayLabel = 'Barcode'
      DisplayWidth = 20
      FieldName = 'PartBarcode'
      Size = 255
    end
    object tblDetailsProductName: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 17
      FieldName = 'ProductName'
      Size = 60
    end
    object tblDetailsUnitofMeasureSaleLines: TWideStringField
      DisplayLabel = 'Units'
      DisplayWidth = 10
      FieldName = 'UnitofMeasureSaleLines'
      Size = 255
    end
    object tblDetailsUnitofMeasureQtySold: TFloatField
      DisplayLabel = 'Ordered'
      DisplayWidth = 6
      FieldName = 'UnitofMeasureQtySold'
    end
    object tblDetailsUnitofMeasureShipped: TFloatField
      DisplayLabel = 'Shipped'
      DisplayWidth = 6
      FieldName = 'UnitofMeasureShipped'
    end
    object tblDetailsUnitofMeasureBackorder: TFloatField
      DisplayLabel = 'BO'
      DisplayWidth = 6
      FieldName = 'UnitofMeasureBackorder'
    end
    object tblDetailsAttrib1Sale: TFloatField
      DisplayLabel = 'Metres ?'
      DisplayWidth = 6
      FieldName = 'Attrib1Sale'
    end
    object tblDetailsAttrib2Sale: TFloatField
      DisplayLabel = 'Weight'
      DisplayWidth = 6
      FieldName = 'Attrib2Sale'
    end
    object tblDetailsAttrib1SaleRate: TFloatField
      DisplayLabel = 'Metres ? Rate'
      DisplayWidth = 10
      FieldName = 'Attrib1SaleRate'
      currency = True
    end
    object tblDetailsSpecDescription: TWideStringField
      DisplayLabel = 'Specifications'
      DisplayWidth = 17
      FieldName = 'SpecDescription'
      Size = 255
    end
    object tblDetailsSpecValue: TFloatField
      DisplayLabel = 'Spec Qty'
      DisplayWidth = 10
      FieldName = 'SpecValue'
    end
    object tblDetailsProduct_Description: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 20
      FieldName = 'Product_Description'
      Size = 255
    end
    object tblDetailsProduct_Description_Memo: TWideMemoField
      DisplayLabel = 'Product Description Memo'
      DisplayWidth = 10
      FieldName = 'Product_Description_Memo'
      BlobType = ftWideMemo
    end
    object tblDetailsLineCostInc: TFloatField
      DisplayLabel = 'Cost (Inc)'
      DisplayWidth = 10
      FieldName = 'LineCostInc'
      currency = True
    end
    object tblDetailsLinePriceInc: TFloatField
      DisplayLabel = 'Price (Inc)'
      DisplayWidth = 10
      FieldName = 'LinePriceInc'
      DisplayFormat = '$0.00###'
      EditFormat = '$0.00###'
    end
    object tblDetailsWarrantyEndsOn: TDateField
      DisplayLabel = 'Warranty Ends On'
      DisplayWidth = 10
      FieldName = 'WarrantyEndsOn'
    end
    object tblDetailsWarrantyPeriod: TWideStringField
      DisplayLabel = 'Warranty Period'
      DisplayWidth = 20
      FieldName = 'WarrantyPeriod'
      Size = 100
    end
    object tblDetailsDiscounts: TFloatField
      DisplayLabel = 'Discount ($)'
      DisplayWidth = 10
      FieldName = 'Discounts'
      DisplayFormat = '$#0.00#'
      EditFormat = '$#0.00#'
      currency = True
    end
    object tblDetailsForeignCurrencyLinePrice: TFloatField
      DisplayLabel = 'Foreign Amount'
      DisplayWidth = 10
      FieldName = 'ForeignCurrencyLinePrice'
      DisplayFormat = '0.00###'
      EditFormat = '0.00###'
    end
    object tblDetailsLineTaxCode: TWideStringField
      DisplayLabel = 'Code'
      DisplayWidth = 15
      FieldName = 'LineTaxCode'
      Size = 15
    end
    object tblDetailsLineTax: TFloatField
      DisplayLabel = 'Tax'
      DisplayWidth = 10
      FieldName = 'LineTax'
      DisplayFormat = '$#0.00###'
      EditFormat = '$#0.00###'
      currency = True
    end
    object tblDetailsTotalLineAmountInc: TFloatField
      DisplayLabel = 'Amount (Inc)'
      DisplayWidth = 14
      FieldName = 'TotalLineAmountInc'
      currency = True
    end
    object tblDetailsSupplier: TWideStringField
      DisplayWidth = 20
      FieldName = 'Supplier'
      Size = 255
    end
    object tblDetailsSupplierContact: TWideStringField
      DisplayLabel = 'Supplier Contact'
      DisplayWidth = 20
      FieldName = 'SupplierContact'
      Size = 255
    end
    object tblDetailsSalesLinesCustField1: TWideStringField
      DisplayWidth = 20
      FieldName = 'SalesLinesCustField1'
      Size = 255
    end
    object tblDetailsDocketNumber: TWideStringField
      DisplayLabel = 'Docket Number'
      DisplayWidth = 20
      FieldName = 'DocketNumber'
      Size = 255
    end
    object tblDetailsSalesLinesCustField2: TWideStringField
      DisplayWidth = 20
      FieldName = 'SalesLinesCustField2'
      Size = 255
    end
    object tblDetailsSalesLinesCustField3: TWideStringField
      DisplayWidth = 20
      FieldName = 'SalesLinesCustField3'
      Size = 255
    end
    object tblDetailsSalesLinesCustField4: TWideStringField
      DisplayWidth = 20
      FieldName = 'SalesLinesCustField4'
      Size = 255
    end
    object tblDetailsSalesLinesCustField5: TWideStringField
      DisplayWidth = 20
      FieldName = 'SalesLinesCustField5'
      Size = 255
    end
    object tblDetailsSalesLinesCustField6: TWideStringField
      DisplayWidth = 20
      FieldName = 'SalesLinesCustField6'
      Size = 255
    end
    object tblDetailsSalesLinesCustField7: TWideStringField
      DisplayWidth = 20
      FieldName = 'SalesLinesCustField7'
      Size = 255
    end
    object tblDetailsSalesLinesCustField10: TWideStringField
      DisplayWidth = 20
      FieldName = 'SalesLinesCustField10'
      Size = 255
    end
    object tblDetailsShipDate: TDateTimeField
      DisplayLabel = 'Ship Date'
      DisplayWidth = 18
      FieldName = 'ShipDate'
    end
    object tblDetailsBaseLineno: TIntegerField
      DisplayWidth = 10
      FieldName = 'BaseLineno'
    end
    object tblDetailsAutoSmartOrder: TWideStringField
      DisplayLabel = 'Auto Create Order?'
      DisplayWidth = 1
      FieldName = 'AutoSmartOrder'
      FixedChar = True
      Size = 1
    end
    object tblDetailsSmartOrderCreated: TWideStringField
      DisplayLabel = 'Ordered?'
      DisplayWidth = 1
      FieldName = 'SmartOrderCreated'
      FixedChar = True
      Size = 1
    end
    object tblDetailsSalesLinesCustField9: TWideStringField
      DisplayWidth = 20
      FieldName = 'SalesLinesCustField9'
      Size = 255
    end
    object tblDetailsMemoLine: TWideMemoField
      DisplayWidth = 10
      FieldName = 'MemoLine'
      BlobType = ftWideMemo
    end
    object tblDetailsSalesLinesCustField8: TWideStringField
      DisplayWidth = 20
      FieldName = 'SalesLinesCustField8'
      Size = 255
    end
    object tblDetailsTimecostused: TWideStringField
      DisplayWidth = 1
      FieldName = 'Timecostused'
      FixedChar = True
      Size = 1
    end
    object tblDetailsProgresspaymentRef: TWideStringField
      DisplayWidth = 10
      FieldName = 'ProgresspaymentRef'
      Size = 255
    end
    object tblDetailsForeignExchangeSellCode: TWideStringField
      DisplayLabel = 'Foreign Currency'
      DisplayWidth = 3
      FieldName = 'ForeignExchangeSellCode'
      Visible = False
      FixedChar = True
      Size = 3
    end
    object tblDetailsLineCost: TFloatField
      DisplayLabel = 'Cost (Ex)'
      DisplayWidth = 10
      FieldName = 'LineCost'
      Visible = False
      DisplayFormat = '$0.00###'
      EditFormat = '$0.00###'
    end
    object tblDetailsShipped: TFloatField
      DisplayWidth = 10
      FieldName = 'Shipped'
      Visible = False
    end
    object tblDetailsBackOrder: TFloatField
      DisplayLabel = 'BO'
      DisplayWidth = 10
      FieldName = 'BackOrder'
      Visible = False
    end
    object tblDetailsOrgLinePrice: TFloatField
      FieldName = 'OrgLinePrice'
      Visible = False
      DisplayFormat = '$#0.00#'
      EditFormat = '$#0.00#'
    end
    object tblDetailsLinePrice: TFloatField
      DisplayLabel = 'Price (Ex)'
      DisplayWidth = 10
      FieldName = 'LinePrice'
      Visible = False
      DisplayFormat = '$0.00###'
      EditFormat = '$0.00###'
    end
    object tblDetailsSaleID: TIntegerField
      DefaultExpression = '0'
      DisplayWidth = 10
      FieldName = 'SaleID'
      Visible = False
    end
    object tblDetailsSaleLineID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'SaleLineID'
      ReadOnly = True
      Visible = False
    end
    object tblDetailsSeqNo: TIntegerField
      DisplayWidth = 10
      FieldName = 'SeqNo'
      Visible = False
    end
    object tblDetailsSortId: TIntegerField
      DisplayWidth = 10
      FieldName = 'SortId'
      Visible = False
    end
    object tblDetailsMatrixDesc: TWideMemoField
      DisplayLabel = 'Matrix Details'
      DisplayWidth = 10
      FieldName = 'MatrixDesc'
      BlobType = ftWideMemo
    end
    object tblDetailsTotalLineAmount: TFloatField
      DisplayLabel = 'Amount (Ex)'
      DisplayWidth = 10
      FieldName = 'TotalLineAmount'
      Visible = False
      currency = True
    end
    object tblDetailsQtySold: TFloatField
      DisplayLabel = 'Ordered'
      DisplayWidth = 10
      FieldName = 'QtySold'
      Visible = False
    end
    object tblDetailsMatrixPrice: TFloatField
      DisplayLabel = 'Matrix Price'
      DisplayWidth = 10
      FieldName = 'MatrixPrice'
      currency = True
    end
    object tblDetailsFormulaQtySoldValue1: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue1'
    end
    object tblDetailsFormulaQtySoldValue2: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue2'
    end
    object tblDetailsFormulaQtySoldValue3: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue3'
    end
    object tblDetailsFormulaQtySoldValue4: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue4'
    end
    object tblDetailsFormulaQtySoldValue5: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue5'
    end
    object tblDetailsFormulaQtyShippedValue1: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue1'
    end
    object tblDetailsFormulaQtyShippedValue2: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue2'
    end
    object tblDetailsFormulaQtyShippedValue3: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue3'
    end
    object tblDetailsFormulaQtyShippedValue4: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue4'
    end
    object tblDetailsFormulaQtyShippedValue5: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue5'
    end
    object tblDetailsFormulaQtySoldValue: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue'
    end
    object tblDetailsFormulaQtyShippedValue: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue'
    end
    object tblDetailsGlobalRef: TWideStringField
      DisplayLabel = 'Global Ref'
      DisplayWidth = 20
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object tblDetailsProductGroup: TWideStringField
      DisplayLabel = 'Product Group'
      DisplayWidth = 20
      FieldName = 'ProductGroup'
      Visible = False
      Size = 255
    end
    object tblDetailsLineWholesalePrice: TFloatField
      DisplayLabel = 'Line Wholesale Price'
      DisplayWidth = 10
      FieldName = 'LineWholesalePrice'
      Visible = False
      currency = True
    end
    object tblDetailsLineTaxRate: TFloatField
      DisplayLabel = 'Line Tax Rate'
      DisplayWidth = 10
      FieldName = 'LineTaxRate'
      Visible = False
    end
    object tblDetailsInvoiced: TWideStringField
      DisplayWidth = 1
      FieldName = 'Invoiced'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsMarkup: TFloatField
      DisplayWidth = 10
      FieldName = 'Markup'
      Visible = False
      DisplayFormat = '$#0.00#'
      EditFormat = '$#0.00#'
      currency = True
    end
    object tblDetailsMarkupPercent: TFloatField
      DisplayLabel = 'Markup %'
      FieldName = 'MarkupPercent'
      Visible = False
      DisplayFormat = '#0.0%'
    end
    object tblDetailsDiscountPercent: TFloatField
      DisplayLabel = 'Discount Percent'
      FieldName = 'DiscountPercent'
      Visible = False
      DisplayFormat = '#0.0%'
    end
    object tblDetailsEditedFlag: TWideStringField
      DisplayLabel = 'Edited Flag'
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsDeleted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsProductID: TIntegerField
      DisplayLabel = 'Product ID'
      DisplayWidth = 10
      FieldName = 'ProductID'
      Visible = False
    end
    object tblDetailsPartType: TWideStringField
      DisplayLabel = 'Part Type'
      DisplayWidth = 13
      FieldName = 'PartType'
      Visible = False
      Size = 13
    end
    object tblDetailsRefundQty: TFloatField
      DisplayLabel = 'Refund Qty'
      DisplayWidth = 10
      FieldName = 'RefundQty'
      Visible = False
    end
    object tblDetailsLaybyID: TWideStringField
      DisplayLabel = 'Layby ID'
      DisplayWidth = 14
      FieldName = 'LaybyID'
      Visible = False
      Size = 14
    end
    object tblDetailsIncomeAccnt: TWideStringField
      DisplayLabel = 'Income Accnt'
      DisplayWidth = 50
      FieldName = 'IncomeAccnt'
      Visible = False
      Size = 50
    end
    object tblDetailsAssetAccnt: TWideStringField
      DisplayLabel = 'Asset Accnt'
      DisplayWidth = 50
      FieldName = 'AssetAccnt'
      Visible = False
      Size = 50
    end
    object tblDetailsCogsAccnt: TWideStringField
      DisplayLabel = 'Cogs Accnt'
      DisplayWidth = 50
      FieldName = 'CogsAccnt'
      Visible = False
      Size = 50
    end
    object tblDetailsLastLineID: TIntegerField
      FieldName = 'LastLineID'
      Visible = False
    end
    object tblDetailsUnitofMeasureMultiplier: TFloatField
      FieldName = 'UnitofMeasureMultiplier'
      Visible = False
    end
    object tblDetailsForeignExchangeSellRate: TFloatField
      DisplayLabel = 'Foreign Exchange Sell Rate'
      FieldName = 'ForeignExchangeSellRate'
      Visible = False
    end
    object tblDetailsForeignTotalLineAmount: TFloatField
      FieldName = 'ForeignTotalLineAmount'
      Visible = False
    end
    object tblDetailsArea: TWideStringField
      DisplayWidth = 20
      FieldName = 'Area'
      Visible = False
      Size = 255
    end
    object tblDetailsSearchFilter: TWideStringField
      FieldName = 'SearchFilter'
      Visible = False
      Size = 64
    end
    object tblDetailsSearchFilterCopy: TWideStringField
      FieldName = 'SearchFilterCopy'
      Visible = False
      Size = 64
    end
    object tblDetailsIsRelatedProduct: TWideStringField
      FieldName = 'IsRelatedProduct'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsRelatedParentProductID: TIntegerField
      FieldName = 'RelatedParentProductID'
      Visible = False
    end
    object tblDetailsCostCentreId: TIntegerField
      FieldName = 'CostCentreId'
      Visible = False
    end
    object tblDetailsUseHedging: TWideStringField
      FieldName = 'UseHedging'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsPartSpecID: TIntegerField
      FieldName = 'PartSpecID'
      Visible = False
    end
    object tblDetailsCreationDate: TDateTimeField
      FieldName = 'CreationDate'
      Visible = False
    end
    object tblDetailsSoldSerials: TWideMemoField
      FieldName = 'SoldSerials'
      Visible = False
      BlobType = ftWideMemo
    end
    object tblDetailsLineNotes: TWideMemoField
      FieldName = 'LineNotes'
      Visible = False
      BlobType = ftWideMemo
    end
    object tblDetailsCustomData: TWideMemoField
      FieldName = 'CustomData'
      Visible = False
      BlobType = ftWideMemo
    end
    object tblDetailsUnitOfMeasureID: TIntegerField
      FieldName = 'UnitOfMeasureID'
      Visible = False
    end
    object tblDetailsRelatedParentLineRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'RelatedParentLineRef'
      Visible = False
      Size = 255
    end
    object tblDetailsRelatedProductQty: TFloatField
      FieldName = 'RelatedProductQty'
      Visible = False
    end
    object tblDetailsIsFormulaRElatedProduct: TWideStringField
      FieldName = 'IsFormulaRElatedProduct'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsFormulaID: TIntegerField
      DisplayWidth = 10
      FieldName = 'FormulaID'
      Visible = False
    end
    object tblDetailsMatrixRef: TWideMemoField
      DisplayWidth = 10
      FieldName = 'MatrixRef'
      Visible = False
      BlobType = ftWideMemo
    end
    object tblDetailsmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Visible = False
    end
    object tblDetailsmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Visible = False
      Size = 3
    end
    object tblDetailsAttrib1SaleEst: TFloatField
      DisplayLabel = 'Est Metres ?'
      FieldName = 'Attrib1SaleEst'
    end
    object tblDetailsAttrib2SaleEst: TFloatField
      DisplayLabel = 'Est Weight'
      FieldName = 'Attrib2SaleEst'
    end
    object tblDetailsLastUpdated: TDateTimeField
      DisplayWidth = 18
      FieldName = 'LastUpdated'
      Visible = False
    end
    object tblDetailsIsQuote: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsQuote'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsTreeFinalized: TWideStringField
      FieldName = 'TreeFinalized'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsBOMGroupedLine: TWideStringField
      FieldName = 'BOMGroupedLine'
      FixedChar = True
      Size = 1
    end
    object tblDetailsBOMProductionLine: TWideStringField
      FieldName = 'BOMProductionLine'
      FixedChar = True
      Size = 1
    end
  end
  object DSMaster: TDataSource
    DataSet = tblMaster
    Left = 91
    Top = 377
  end
  object DSDetails: TDataSource
    DataSet = tblDetails
    Left = 127
    Top = 378
  end
  object popMain: TAdvPopupMenu
    OnPopup = popMainPopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 236
    Top = 295
    object mnuAutoAllocate: TMenuItem
      Caption = 'Auto Allocate from Order'
      HelpContext = 1046021
      OnClick = mnuAutoAllocateClick
    end
    object mnuUpdatewithcurTime: TMenuItem
      Caption = 'Update with Current time'
      HelpContext = 1046022
      OnClick = mnuUpdatewithcurTimeClick
    end
  end
end
