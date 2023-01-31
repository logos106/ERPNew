inherited POSSplitAccount: TPOSSplitAccount
  Left = 139
  Top = 106
  HelpContext = 433000
  Caption = 'Split Account'
  ClientHeight = 568
  ClientWidth = 969
  Font.Style = [fsBold, fsItalic]
  OldCreateOrder = True
  OnKeyPress = FormKeyPress
  ExplicitLeft = 139
  ExplicitTop = 106
  ExplicitWidth = 977
  ExplicitHeight = 595
  DesignSize = (
    969
    568)
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel [0]
    Left = 17
    Top = 54
    Width = 160
    Height = 16
    HelpContext = 433002
    AutoSize = False
    Caption = 'From Customer Account'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label2: TLabel [1]
    Left = 518
    Top = 58
    Width = 175
    Height = 21
    HelpContext = 433003
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 'To Customer Account'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label3: TLabel [2]
    Left = 688
    Top = 9
    Width = 249
    Height = 33
    HelpContext = 433004
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 
      'To Select the "To Customer" use a Swipe Card OR the Drop Down Bo' +
      'x below.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsItalic]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 568
    Width = 969
    ExplicitTop = 568
    ExplicitWidth = 969
    HelpContext = 433016
  end
  inherited imgGridWatermark: TImage
    HelpContext = 433001
  end
  object grdToBarTab: TwwDBGrid [8]
    Left = 518
    Top = 108
    Width = 434
    Height = 413
    HelpContext = 433009
    Selected.Strings = (
      'ProductName'#9'15'#9'Product'#9'T'
      'UnitOfMeasureSaleLines'#9'10'#9'Unit'#9'T'
      'UnitOfMeasureQtySold'#9'4'#9'Qty'#9'T'
      'TotalLineAmountInc'#9'10'#9'Amount (Inc)'#9'T'
      'Product_Description'#9'25'#9'Product_Description'
      'SaleDate'#9'10'#9'SaleDate'#9'T'
      'TimeOfSale'#9'11'#9'Time of Sale'#9'T')
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akTop, akRight, akBottom]
    DataSource = DSToBarTab
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = []
    MultiSelectOptions = [msoAutoUnselect]
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgShowFooter]
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold, fsItalic]
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
    FooterColor = clWindow
    FooterCellColor = clWindow
  end
  object btnMoveItem: TDNMSpeedButton [9]
    Left = 456
    Top = 263
    Width = 58
    Height = 27
    HelpContext = 433010
    Action = MoveItem
    Anchors = [akTop]
    Caption = '> > >'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 2
  end
  object btnMoveAll: TDNMSpeedButton [10]
    Left = 456
    Top = 341
    Width = 58
    Height = 27
    HelpContext = 433011
    Anchors = [akBottom]
    Caption = ' All  > > '
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 7
    OnClick = btnMoveAllClick
  end
  object cmdSave: TDNMSpeedButton [11]
    Left = 190
    Top = 532
    Width = 87
    Height = 27
    HelpContext = 433012
    Anchors = [akBottom]
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold, fsItalic]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 3
    OnClick = cmdSaveClick
  end
  object pnlTitle: TDNMPanel [12]
    Left = 353
    Top = 6
    Width = 255
    Height = 45
    HelpContext = 433013
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 251
      Height = 41
      HelpContext = 433014
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
        Width = 251
        Height = 41
        HelpContext = 433015
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Split Account'
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
  object cboClientFrom: TwwDBLookupCombo [13]
    Left = 17
    Top = 72
    Width = 263
    Height = 23
    HelpContext = 433006
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'Company'#9'30'#9'Company'#9'T'
      'Balance'#9'10'#9'Balance ($)'#9'T')
    DataField = 'ClientID'
    LookupTable = cboClientLookup
    LookupField = 'ClientId'
    Options = [loTitles, loSearchOnBackspace]
    DropDownWidth = 300
    Enabled = False
    ParentFont = False
    TabOrder = 5
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = cboClientFromCloseUp
  end
  object cmdCancel: TDNMSpeedButton [14]
    Left = 691
    Top = 532
    Width = 87
    Height = 27
    HelpContext = 433005
    Anchors = [akBottom]
    Caption = '&Cancel'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
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
    HotTrackFont.Style = [fsBold, fsItalic]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 4
    OnClick = cmdCancelClick
  end
  object cboClient: TwwDBLookupCombo [15]
    Left = 518
    Top = 75
    Width = 263
    Height = 23
    HelpContext = 433007
    Anchors = [akTop, akRight]
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'Company'#9'30'#9'Company'#9'T'
      'Balance'#9'10'#9'Balance ($)'#9'T')
    DataField = 'ClientID'
    LookupTable = cboClientLookup
    LookupField = 'ClientId'
    Options = [loTitles, loSearchOnBackspace]
    DropDownWidth = 300
    ParentFont = False
    TabOrder = 1
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = cboClientCloseUp
  end
  object grdFromBarTab: TwwDBGrid [16]
    Left = 17
    Top = 108
    Width = 434
    Height = 413
    HelpContext = 433008
    Selected.Strings = (
      'ProductName'#9'15'#9'Product'#9'T'
      'UnitOfMeasureSaleLines'#9'10'#9'Unit'#9'T'
      'UnitOfMeasureQtySold'#9'4'#9'Qty'#9'T'
      'TotalLineAmountInc'#9'10'#9'Amount (Inc)'#9'T'
      'Product_Description'#9'25'#9'Product_Description'#9'T'
      'SaleDate'#9'10'#9'SaleDate'#9'T'
      'TimeOfSale'#9'11'#9'Time of Sale'#9'T')
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akBottom]
    DataSource = DSFromBarTab
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgShowFooter]
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold, fsItalic]
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
    FooterColor = clWindow
    FooterCellColor = clWindow
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102006400640010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryFromBarTab: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT tblsales_pos.SaleID, ProductID, ProductName, Product_Desc' +
        'ription, PARTTYPE, '
      'UnitOfMeasureQtySold, QtySold, '
      'TotalLineAmountInc, '
      
        'LinePrice, LinePriceInc, UnitOfMeasureMultiplier, LineTaxRate, I' +
        'NCOMEACCNT, '
      'ASSETACCNT, COGSACCNT, ProductGroup, LineCost, LineCostInc, '
      'LineTaxCode,'
      
        'UnitOfMeasureSaleLines, TillID, Area, SaleDate, TimeOfSale, Sale' +
        'LineID '
      'FROM tblsales_pos '
      'INNER JOIN tblsaleslines_pos USING (SaleID) '
      'WHERE ClientID = :xClientID AND IsInvoice = "T"'
      'ORDER BY tblsales_pos.SaleID;')
    Left = 47
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientID'
      end>
    object qryFromBarTabProductName: TWideStringField
      DisplayWidth = 60
      FieldName = 'ProductName'
      Size = 60
    end
    object qryFromBarTabUnitOfMeasureSaleLines: TWideStringField
      DisplayWidth = 40
      FieldName = 'UnitOfMeasureSaleLines'
      Size = 255
    end
    object qryFromBarTabUnitOfMeasureQtySold: TFloatField
      DisplayWidth = 10
      FieldName = 'UnitOfMeasureQtySold'
    end
    object qryFromBarTabProduct_Description: TWideStringField
      DisplayWidth = 40
      FieldName = 'Product_Description'
      Size = 255
    end
    object qryFromBarTabTotalLineAmountInc: TFloatField
      DisplayWidth = 10
      FieldName = 'TotalLineAmountInc'
      currency = True
    end
    object qryFromBarTabSaleDate: TDateField
      DisplayWidth = 10
      FieldName = 'SaleDate'
    end
    object qryFromBarTabTimeOfSale: TWideStringField
      DisplayWidth = 11
      FieldName = 'TimeOfSale'
      Size = 11
    end
    object qryFromBarTabSaleID: TAutoIncField
      FieldName = 'SaleID'
      ReadOnly = True
      Visible = False
    end
    object qryFromBarTabProductID: TIntegerField
      FieldName = 'ProductID'
      Visible = False
    end
    object qryFromBarTabPARTTYPE: TWideStringField
      FieldName = 'PARTTYPE'
      Visible = False
      Size = 13
    end
    object qryFromBarTabQtySold: TFloatField
      FieldName = 'QtySold'
      Visible = False
    end
    object qryFromBarTabLinePrice: TFloatField
      FieldName = 'LinePrice'
      Visible = False
      currency = True
    end
    object qryFromBarTabLinePriceInc: TFloatField
      FieldName = 'LinePriceInc'
      Visible = False
      currency = True
    end
    object qryFromBarTabUnitOfMeasureMultiplier: TFloatField
      FieldName = 'UnitOfMeasureMultiplier'
      Visible = False
    end
    object qryFromBarTabLineTaxRate: TFloatField
      FieldName = 'LineTaxRate'
      Visible = False
    end
    object qryFromBarTabINCOMEACCNT: TWideStringField
      FieldName = 'INCOMEACCNT'
      Visible = False
      Size = 50
    end
    object qryFromBarTabASSETACCNT: TWideStringField
      FieldName = 'ASSETACCNT'
      Visible = False
      Size = 50
    end
    object qryFromBarTabCOGSACCNT: TWideStringField
      FieldName = 'COGSACCNT'
      Visible = False
      Size = 50
    end
    object qryFromBarTabProductGroup: TWideStringField
      FieldName = 'ProductGroup'
      Visible = False
      Size = 255
    end
    object qryFromBarTabLineCost: TFloatField
      FieldName = 'LineCost'
      Visible = False
      currency = True
    end
    object qryFromBarTabLineCostInc: TFloatField
      FieldName = 'LineCostInc'
      Visible = False
      currency = True
    end
    object qryFromBarTabLineTaxCode: TWideStringField
      FieldName = 'LineTaxCode'
      Visible = False
      Size = 15
    end
    object qryFromBarTabTillID: TSmallintField
      FieldName = 'TillID'
      Visible = False
    end
    object qryFromBarTabArea: TWideStringField
      FieldName = 'Area'
      Visible = False
      Size = 255
    end
    object qryFromBarTabSaleLineID: TAutoIncField
      FieldName = 'SaleLineID'
      ReadOnly = True
    end
  end
  object qryToBarTab: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT tblsales_pos.SaleID, ProductID, ProductName, Product_Desc' +
        'ription, PARTTYPE, '
      'UnitOfMeasureQtySold, QtySold, '
      'TotalLineAmountInc, '
      
        'LinePrice, LinePriceInc, UnitOfMeasureMultiplier, LineTaxRate, I' +
        'NCOMEACCNT, '
      'ASSETACCNT, COGSACCNT, ProductGroup, LineCost, LineCostInc, '
      'LineTaxCode, '
      
        'UnitOfMeasureSaleLines, TillID, Area, SaleDate, TimeOfSale ,Sale' +
        'LineID'
      'FROM tblsales_pos '
      'INNER JOIN tblsaleslines_pos USING (SaleID) '
      'WHERE ClientID = :xClientID AND IsInvoice = "T"'
      'ORDER BY tblsales_pos.SaleID')
    Left = 551
    Top = 159
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientID'
      end>
    object qryToBarTabSaleID: TAutoIncField
      FieldName = 'SaleID'
      ReadOnly = True
    end
    object qryToBarTabProductID: TIntegerField
      FieldName = 'ProductID'
    end
    object qryToBarTabProductName: TWideStringField
      FieldName = 'ProductName'
      Size = 60
    end
    object qryToBarTabProduct_Description: TWideStringField
      FieldName = 'Product_Description'
      Size = 255
    end
    object qryToBarTabPARTTYPE: TWideStringField
      FieldName = 'PARTTYPE'
      Size = 13
    end
    object qryToBarTabUnitOfMeasureQtySold: TFloatField
      FieldName = 'UnitOfMeasureQtySold'
    end
    object qryToBarTabQtySold: TFloatField
      FieldName = 'QtySold'
    end
    object qryToBarTabTotalLineAmountInc: TFloatField
      FieldName = 'TotalLineAmountInc'
      currency = True
    end
    object qryToBarTabLinePrice: TFloatField
      FieldName = 'LinePrice'
      currency = True
    end
    object qryToBarTabLinePriceInc: TFloatField
      FieldName = 'LinePriceInc'
      currency = True
    end
    object qryToBarTabUnitOfMeasureMultiplier: TFloatField
      FieldName = 'UnitOfMeasureMultiplier'
    end
    object qryToBarTabLineTaxRate: TFloatField
      FieldName = 'LineTaxRate'
    end
    object qryToBarTabINCOMEACCNT: TWideStringField
      FieldName = 'INCOMEACCNT'
      Size = 50
    end
    object qryToBarTabASSETACCNT: TWideStringField
      FieldName = 'ASSETACCNT'
      Size = 50
    end
    object qryToBarTabCOGSACCNT: TWideStringField
      FieldName = 'COGSACCNT'
      Size = 50
    end
    object qryToBarTabProductGroup: TWideStringField
      FieldName = 'ProductGroup'
      Size = 255
    end
    object qryToBarTabLineCost: TFloatField
      FieldName = 'LineCost'
      currency = True
    end
    object qryToBarTabLineCostInc: TFloatField
      FieldName = 'LineCostInc'
      currency = True
    end
    object qryToBarTabLineTaxCode: TWideStringField
      FieldName = 'LineTaxCode'
      Size = 15
    end
    object qryToBarTabUnitOfMeasureSaleLines: TWideStringField
      FieldName = 'UnitOfMeasureSaleLines'
      Size = 255
    end
    object qryToBarTabTillID: TSmallintField
      FieldName = 'TillID'
    end
    object qryToBarTabArea: TWideStringField
      FieldName = 'Area'
      Size = 255
    end
    object qryToBarTabSaleDate: TDateField
      FieldName = 'SaleDate'
    end
    object qryToBarTabTimeOfSale: TWideStringField
      FieldName = 'TimeOfSale'
      Size = 11
    end
    object qryToBarTabSaleLineID: TAutoIncField
      FieldName = 'SaleLineID'
      ReadOnly = True
    end
  end
  object DSFromBarTab: TDataSource
    DataSet = qryFromBarTab
    Left = 49
    Top = 193
  end
  object DSToBarTab: TDataSource
    DataSet = qryToBarTab
    Left = 552
    Top = 192
  end
  object cboClientLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClientId,Company,Balance,PayMethodID FROM tblclients'
      
        'WHERE tblclients.Company Is Not Null And tblclients.Active <>'#39'F'#39 +
        ' And tblclients.Customer = '#39'T'#39
      'ORDER BY tblclients.Company')
    AutoCalcFields = False
    Left = 466
    Top = 80
    object cboClientLookupClientId: TAutoIncField
      FieldName = 'ClientId'
      ReadOnly = True
    end
    object cboClientLookupCompany: TWideStringField
      DisplayWidth = 30
      FieldName = 'Company'
      Size = 80
    end
    object cboClientLookupBalance: TFloatField
      DisplayLabel = 'Balance ($)'
      DisplayWidth = 10
      FieldName = 'Balance'
      currency = True
    end
    object cboClientLookupPayMethodID: TIntegerField
      FieldName = 'PayMethodID'
    end
  end
  object tblMaster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblsales_pos'
      'Where SaleID = :ID;')
    Left = 473
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
  end
  object lsTDNMSpeedButtonActions: TActionList
    Left = 137
    Top = 7
    object MoveItem: TAction
      Caption = '> > >'
      OnExecute = MoveItemExecute
      OnUpdate = MoveItemUpdate
      HelpContext = 433017
    end
  end
end
