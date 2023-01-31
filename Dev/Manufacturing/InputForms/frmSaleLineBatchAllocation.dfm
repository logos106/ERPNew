inherited fmSaleLineBatchAllocation: TfmSaleLineBatchAllocation
  HelpContext = 1268002
  Caption = 'Sale Line Batch Allocation'
  ClientHeight = 426
  ClientWidth = 682
  ExplicitWidth = 698
  ExplicitHeight = 465
  DesignSize = (
    682
    426)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 426
    Width = 682
    HelpContext = 1268003
    ExplicitTop = 426
    ExplicitWidth = 635
  end
  inherited shapehint: TShape
    Left = 3
    ExplicitLeft = 2
  end
  inherited imgGridWatermark: TImage
    Left = 409
    Top = -5
    ExplicitLeft = 409
    ExplicitTop = -5
  end
  inherited shapehintextra1: TShape
    Left = 33
    ExplicitLeft = 30
  end
  object Label1: TLabel [5]
    Left = 28
    Top = 72
    Width = 38
    Height = 15
    HelpContext = 1268004
    Alignment = taRightJustify
    Caption = 'Sale Id'
  end
  object Label2: TLabel [6]
    Left = 194
    Top = 72
    Width = 56
    Height = 15
    HelpContext = 1268005
    Alignment = taRightJustify
    Caption = 'Customer'
  end
  object Label3: TLabel [7]
    Left = 439
    Top = 72
    Width = 54
    Height = 15
    HelpContext = 1268006
    Alignment = taRightJustify
    Caption = 'Sale Date'
  end
  object Label4: TLabel [8]
    Left = 21
    Top = 112
    Width = 45
    Height = 15
    HelpContext = 1268007
    Alignment = taRightJustify
    Caption = 'Product'
  end
  object Label5: TLabel [9]
    Left = 447
    Top = 112
    Width = 46
    Height = 15
    HelpContext = 1268008
    Alignment = taRightJustify
    Caption = 'Shipped'
  end
  object cmdClose: TDNMSpeedButton [10]
    Left = 8
    Top = 391
    Width = 112
    Height = 27
    HelpContext = 1268012
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
    TabOrder = 1
    AutoDisableParentOnclick = True
    OnClick = cmdCloseClick
  end
  object cmdCancel: TDNMSpeedButton [11]
    Left = 562
    Top = 391
    Width = 112
    Height = 27
    HelpContext = 1268013
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
    TabOrder = 2
    AutoDisableParentOnclick = True
    OnClick = cmdCancelClick
  end
  object grdBatch: TwwDBGrid [12]
    Left = 3
    Top = 145
    Width = 671
    Height = 203
    HelpContext = 1268014
    Selected.Strings = (
      'Value'#9'17'#9'Batch No'#9'F'#9
      'ExpiryDate'#9'13'#9'Expiry Date'#9'F'
      'UOMQty'#9'10'#9'Qty'#9'F'#9
      'BOUOMQty'#9'10'#9'BO Qty'#9'F'#9
      'CUSTFLD1'#9'10'#9'CUSTFLD1'#9#9
      'CUSTFLD4'#9'10'#9'CUSTFLD4'#9'F'#9
      'CUSTFLD5'#9'10'#9'Pallet'#9'F'#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsPQADetail
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgShowFooter]
    ParentFont = False
    TabOrder = 3
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    OnDblClick = grdBatchDblClick
    FooterColor = clWhite
    object wwDBGrid1IButton: TwwIButton
      Left = 0
      Top = 0
      Width = 22
      Height = 22
      HelpContext = 1268015
      AllowAllUp = True
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
      NumGlyphs = 2
      OnClick = wwDBGrid1IButtonClick
    end
  end
  object edtSaleId: TwwDBEdit [13]
    Left = 72
    Top = 69
    Width = 89
    Height = 23
    HelpContext = 1268016
    DataField = 'SaleId'
    DataSource = dsSale
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object wwDBEdit1: TwwDBEdit [14]
    Left = 256
    Top = 69
    Width = 152
    Height = 23
    HelpContext = 1268017
    DataField = 'CustomerName'
    DataSource = dsSale
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object wwDBEdit2: TwwDBEdit [15]
    Left = 499
    Top = 69
    Width = 102
    Height = 23
    HelpContext = 1268018
    DataField = 'SaleDate'
    DataSource = dsSale
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object wwDBEdit3: TwwDBEdit [16]
    Left = 72
    Top = 109
    Width = 336
    Height = 23
    HelpContext = 1268019
    DataField = 'ProductName'
    DataSource = dsSaleLine
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 7
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object wwDBEdit4: TwwDBEdit [17]
    Left = 499
    Top = 109
    Width = 102
    Height = 23
    HelpContext = 1268020
    DataField = 'UnitOfMeasureShipped'
    DataSource = dsSaleLine
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 8
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object cmdNew: TDNMSpeedButton [18]
    Left = 146
    Top = 391
    Width = 112
    Height = 27
    HelpContext = 1268021
    Anchors = [akBottom]
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
    TabOrder = 9
    TabStop = False
    AutoDisableParentOnclick = True
    OnClick = cmdNewClick
  end
  object chkAllocated: TwwCheckBox [19]
    Left = 8
    Top = 360
    Width = 78
    Height = 17
    HelpContext = 1268022
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'T'
    DisplayValueUnchecked = 'F'
    NullAndBlankState = cbUnchecked
    Anchors = [akLeft, akBottom]
    Caption = 'Allocated'
    DataField = 'BatchAllocated'
    DataSource = dsSaleLine
    TabOrder = 10
    OnClick = chkAllocatedClick
  end
  object btnPrint: TDNMSpeedButton [20]
    Left = 285
    Top = 391
    Width = 112
    Height = 27
    HelpContext = 1268023
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
    TabOrder = 11
    TabStop = False
    AutoDisableParentOnclick = True
    OnClick = btnPrintClick
  end
  object pnlAdvPrinting: TDNMPanel [21]
    Left = 209
    Top = 354
    Width = 262
    Height = 29
    HelpContext = 1268024
    Anchors = [akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 12
    Transparent = False
    object LblChooseTemplate: TLabel
      Left = 147
      Top = 6
      Width = 98
      Height = 15
      HelpContext = 1268025
      Caption = 'Choose &Template'
      Transparent = True
    end
    object LblShowPreview: TLabel
      Left = 31
      Top = 6
      Width = 81
      Height = 15
      HelpContext = 1268026
      Caption = 'Show Previe&w'
      Transparent = True
    end
    object ChkChooseRpt: TCheckBox
      Left = 130
      Top = 7
      Width = 14
      Height = 16
      HelpContext = 1268027
      TabOrder = 0
    end
    object chkPreview: TCheckBox
      Left = 15
      Top = 7
      Width = 14
      Height = 16
      HelpContext = 1268028
      TabOrder = 1
    end
  end
  object pnlTitle: TDNMPanel [22]
    Left = 82
    Top = 9
    Width = 517
    Height = 39
    HelpContext = 1268009
    Anchors = [akLeft, akTop, akRight]
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
      Width = 515
      Height = 37
      HelpContext = 1268010
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
        Width = 515
        Height = 37
        HelpContext = 1268011
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Sale Line Batch Allocation'
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
  object btnPrintunallocated: TDNMSpeedButton [23]
    Left = 423
    Top = 391
    Width = 112
    Height = 27
    HelpContext = 1268029
    Anchors = [akBottom]
    Caption = 'Print Un-Allocated'
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
    TabOrder = 13
    TabStop = False
    AutoDisableParentOnclick = True
    OnClick = btnPrintunallocatedClick
  end
  inherited tmrProcessMessage: TTimer
    Left = 448
    Top = 192
  end
  inherited tmrdelay: TTimer
    Left = 520
    Top = 192
  end
  inherited popSpelling: TPopupMenu
    Left = 161
    Top = 192
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 269
    Top = 192
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 304
    Top = 192
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 18
    Top = 192
  end
  inherited DataState: TDataState
    Left = 340
    Top = 192
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 197
    Top = 192
  end
  inherited imgsort: TImageList
    Left = 376
    Top = 192
    Bitmap = {
      494C010102002001740110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 53
    Top = 192
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 412
    Top = 192
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 233
    Top = 192
  end
  inherited qryMemTrans: TERPQuery
    Left = 89
    Top = 192
  end
  inherited tmrOnshow: TTimer
    Left = 484
    Top = 192
  end
  object qryPQADetail: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblpqadetails'
      'limit 0')
    AfterOpen = qryPQADetailAfterOpen
    Left = 125
    Top = 192
    object qryPQADetailValue: TWideStringField
      DisplayLabel = 'Batch No'
      DisplayWidth = 17
      FieldName = 'Value'
      Origin = 'tblpqadetails.Value'
      Size = 255
    end
    object qryPQADetailExpiryDate: TDateTimeField
      DisplayLabel = 'Expiry Date'
      DisplayWidth = 13
      FieldName = 'ExpiryDate'
      Origin = 'tblpqadetails.ExpiryDate'
    end
    object qryPQADetailUOMQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'UOMQty'
      Origin = 'tblpqadetails.UOMQty'
      DisplayFormat = '#0.00#'
    end
    object qryPQADetailBOUOMQty: TFloatField
      DisplayLabel = 'BO Qty'
      DisplayWidth = 10
      FieldName = 'BOUOMQty'
      Origin = 'tblpqadetails.BOUOMQty'
      DisplayFormat = '#0.00#'
    end
    object qryPQADetailCUSTFLD1: TFloatField
      DisplayWidth = 10
      FieldName = 'CUSTFLD1'
      Origin = 'tblpqadetails.CUSTFLD1'
    end
    object qryPQADetailCUSTFLD4: TIntegerField
      DisplayWidth = 10
      FieldName = 'CUSTFLD4'
      Origin = 'tblpqadetails.CUSTFLD4'
    end
    object qryPQADetailCUSTFLD5: TWideStringField
      DisplayLabel = 'Pallet'
      DisplayWidth = 10
      FieldName = 'CUSTFLD5'
      Size = 255
    end
    object qryPQADetailGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblpqadetails.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryPQADetailPQADetailID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PQADetailID'
      Origin = 'tblpqadetails.PQADetailID'
      Visible = False
    end
    object qryPQADetailPQAID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PQAID'
      Origin = 'tblpqadetails.PQAID'
      Visible = False
    end
    object qryPQADetailQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
      Origin = 'tblpqadetails.Qty'
      Visible = False
      DisplayFormat = '#0.00#'
    end
    object qryPQADetailBOQty: TFloatField
      DisplayWidth = 10
      FieldName = 'BOQty'
      Origin = 'tblpqadetails.BOQty'
      Visible = False
      DisplayFormat = '#0.00#'
    end
    object qryPQADetailPQAType: TWideStringField
      DisplayWidth = 5
      FieldName = 'PQAType'
      Origin = 'tblpqadetails.PQAType'
      Visible = False
      FixedChar = True
      Size = 5
    end
    object qryPQADetailParentRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'ParentRef'
      Origin = 'tblpqadetails.ParentRef'
      Visible = False
      Size = 255
    end
    object qryPQADetailActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblpqadetails.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryPQADetailmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblpqadetails.msTimeStamp'
      Visible = False
    end
    object qryPQADetailBinID: TIntegerField
      DisplayWidth = 10
      FieldName = 'BinID'
      Origin = 'tblpqadetails.BinID'
      Visible = False
    end
    object qryPQADetailmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblpqadetails.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
    object qryPQADetailTruckLoadNo: TWideStringField
      DisplayWidth = 10
      FieldName = 'TruckLoadNo'
      Origin = 'tblpqadetails.TruckLoadNo'
      Visible = False
      Size = 10
    end
  end
  object dsPQADetail: TDataSource
    DataSet = qryPQADetail
    Left = 125
    Top = 162
  end
  object dsSale: TDataSource
    Left = 161
    Top = 162
  end
  object dsSaleLine: TDataSource
    Left = 197
    Top = 162
  end
end
