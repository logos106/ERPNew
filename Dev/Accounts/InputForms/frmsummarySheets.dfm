inherited fmsummarySheets: TfmsummarySheets
  Left = 751
  Top = 62
  HelpContext = 1090002
  Caption = 'Combined Companies Category'
  ClientHeight = 558
  ClientWidth = 997
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 1003
  ExplicitHeight = 586
  DesignSize = (
    997
    558)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 558
    Width = 997
    HelpContext = 1090003
    ExplicitTop = 558
    ExplicitWidth = 997
  end
  inherited shapehint: TShape
    Left = 12
    ExplicitLeft = 12
  end
  inherited shapehintextra1: TShape
    Left = 56
    ExplicitLeft = 56
  end
  object Bevel1: TBevel [4]
    Left = 177
    Top = 0
    Width = 9
    Height = 557
    HelpContext = 1090004
    Anchors = [akLeft, akTop, akBottom]
    Shape = bsLeftLine
  end
  object lblTo: TLabel [5]
    Left = 871
    Top = 28
    Width = 31
    Height = 15
    HelpContext = 1090005
    Anchors = [akTop, akRight]
    Caption = 'As Of'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Shader1: TShader [6]
    Left = 184
    Top = 58
    Width = 805
    Height = 30
    HelpContext = 1090006
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    TabOrder = 0
    FromColor = clBtnFace
    ToColor = clWhite
    FromColorMirror = clWhite
    ToColorMirror = clBtnFace
    Steps = 10
    Direction = False
    Version = '1.4.0.0'
    object pnlActiveForm: TLabel
      Left = 0
      Top = 0
      Width = 805
      Height = 30
      HelpContext = 1090007
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      ExplicitLeft = -1
      ExplicitTop = -1
    end
  end
  object pnlTitle: TDNMPanel [7]
    Left = 285
    Top = 6
    Width = 538
    Height = 45
    HelpContext = 1090008
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 534
      Height = 41
      HelpContext = 1090009
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
        Width = 534
        Height = 41
        HelpContext = 1090010
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Combined Companies Category'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 388
      end
    end
  end
  object sbButtons: TScrollBox [8]
    Left = 0
    Top = 0
    Width = 177
    Height = 557
    HelpContext = 1090011
    HorzScrollBar.Visible = False
    Anchors = [akLeft, akTop, akBottom]
    BorderStyle = bsNone
    TabOrder = 2
    object pnlButtons: TDNMPanel
      Left = 0
      Top = 0
      Width = 166
      Height = 556
      HelpContext = 1090012
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Transparent = False
      DesignSize = (
        166
        556)
      object btnGeneral: TDNMSpeedButton
        Tag = 1
        Left = 12
        Top = 156
        Width = 148
        Height = 28
        HelpContext = 1090013
        Anchors = [akBottom]
        Caption = 'General'
        Color = clWhite
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        SlowDecease = True
        Style = bsModern
        TabOrder = 0
        TabStop = False
        OnClick = Mainbuttonclick
      end
      object btnPayables: TDNMSpeedButton
        Tag = 2
        Left = 12
        Top = 190
        Width = 148
        Height = 28
        HelpContext = 1090014
        Anchors = [akBottom]
        Caption = 'Payables'
        Color = clWhite
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        SlowDecease = True
        Style = bsModern
        TabOrder = 1
        TabStop = False
        OnClick = Mainbuttonclick
      end
      object btnReceivables: TDNMSpeedButton
        Tag = 3
        Left = 12
        Top = 224
        Width = 148
        Height = 28
        HelpContext = 1090015
        Anchors = [akBottom]
        Caption = 'Receivables'
        Color = clWhite
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        SlowDecease = True
        Style = bsModern
        TabOrder = 2
        TabStop = False
        OnClick = Mainbuttonclick
      end
      object DNMSpeedButton1: TDNMSpeedButton
        Tag = 4
        Left = 12
        Top = 257
        Width = 148
        Height = 28
        HelpContext = 1090016
        Anchors = [akBottom]
        Caption = 'Last Week (Ex)'
        Color = clWhite
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        SlowDecease = True
        Style = bsModern
        TabOrder = 3
        TabStop = False
        OnClick = Mainbuttonclick
      end
      object DNMSpeedButton2: TDNMSpeedButton
        Tag = 5
        Left = 12
        Top = 291
        Width = 148
        Height = 28
        HelpContext = 1090017
        Anchors = [akBottom]
        Caption = 'Last Month (Ex)'
        Color = clWhite
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        SlowDecease = True
        Style = bsModern
        TabOrder = 4
        TabStop = False
        OnClick = Mainbuttonclick
      end
      object DNMSpeedButton3: TDNMSpeedButton
        Tag = 6
        Left = 12
        Top = 325
        Width = 148
        Height = 28
        HelpContext = 1090018
        Anchors = [akBottom]
        Caption = 'Last 3 Months (Ex)'
        Color = clWhite
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        SlowDecease = True
        Style = bsModern
        TabOrder = 5
        TabStop = False
        OnClick = Mainbuttonclick
      end
      object DNMSpeedButton4: TDNMSpeedButton
        Tag = 7
        Left = 12
        Top = 359
        Width = 148
        Height = 28
        HelpContext = 1090019
        Anchors = [akBottom]
        Caption = 'Last 12 Months (Ex)'
        Color = clWhite
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        SlowDecease = True
        Style = bsModern
        TabOrder = 6
        TabStop = False
        OnClick = Mainbuttonclick
      end
      object DNMSpeedButton6: TDNMSpeedButton
        Left = 12
        Top = 88
        Width = 148
        Height = 28
        HelpContext = 1090020
        Anchors = [akBottom]
        Caption = 'All'
        Color = clWhite
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        SlowDecease = True
        Style = bsModern
        TabOrder = 7
        TabStop = False
        OnClick = Mainbuttonclick
      end
      object btnOpenList: TDNMSpeedButton
        Tag = -1
        Left = 12
        Top = 122
        Width = 148
        Height = 28
        HelpContext = 1090021
        Anchors = [akBottom]
        Caption = 'Open all in List'
        Color = clWhite
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        SlowDecease = True
        Style = bsModern
        TabOrder = 8
        TabStop = False
        OnClick = btnOpenListClick
      end
    end
  end
  object btnSelectDbs: TDNMSpeedButton [9]
    Left = 457
    Top = 525
    Width = 87
    Height = 27
    HelpContext = 1090022
    Anchors = [akBottom]
    Caption = 'Companies'
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
    OnClick = btnSelectDbsClick
  end
  object cmdPrint: TDNMSpeedButton [10]
    Left = 586
    Top = 525
    Width = 87
    Height = 27
    Hint = '"Print The List"'
    HelpContext = 1090023
    Anchors = [akBottom]
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
    TabStop = False
    OnClick = cmdPrintClick
  end
  object cmdClose: TDNMSpeedButton [11]
    Left = 715
    Top = 525
    Width = 87
    Height = 27
    Hint = '"Close The List"'
    HelpContext = 1090024
    Anchors = [akBottom]
    Caption = '&Close'
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
    ModalResult = 1
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    TabStop = False
    OnClick = cmdCloseClick
  end
  object dtTo: TwwDBDateTimePicker [12]
    Left = 908
    Top = 26
    Width = 82
    Height = 22
    HelpContext = 1090025
    TabStop = False
    Anchors = [akTop, akRight]
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    CalendarAttributes.PopupYearOptions.NumberColumns = 6
    CalendarAttributes.PopupYearOptions.StartYear = 1980
    Date = 37432.000000000000000000
    Epoch = 1950
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    ShowButton = True
    TabOrder = 6
    UnboundDataType = wwDTEdtDate
    OnChange = dtToChange
  end
  object DNMSpeedButton7: TDNMSpeedButton [13]
    Left = 328
    Top = 525
    Width = 87
    Height = 27
    HelpContext = 1090026
    Anchors = [akBottom]
    Caption = 'Refresh'
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
    OnClick = DNMSpeedButton7Click
  end
  object DNMPanel1: TDNMPanel [14]
    Left = 184
    Top = 87
    Width = 805
    Height = 432
    HelpContext = 1090027
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    object Splitter: TAdvSplitter
      Left = 1
      Top = 274
      Width = 803
      Height = 3
      Cursor = crVSplit
      HelpContext = 1090028
      Align = alBottom
      Appearance.BorderColor = clNone
      Appearance.BorderColorHot = clNone
      Appearance.Color = clWhite
      Appearance.ColorTo = clSilver
      Appearance.ColorHot = clWhite
      Appearance.ColorHotTo = clGray
      GripStyle = sgDots
      ExplicitTop = 1
      ExplicitWidth = 276
    end
    object grdMain: TwwDBGrid
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 797
      Height = 267
      HelpContext = 1090029
      Selected.Strings = (
        'DbName'#9'20'#9'Database'
        'Amt1'#9'10'#9'Cash in~Hand'#9#9'General'
        'Amt2'#9'10'#9'Accounts~Receivable'#9#9'General'
        'Amt3'#9'10'#9'Accounts~Payable'#9#9'General'
        'Amt4'#9'10'#9'Balance~Sheet'#9#9'General'
        'Amt5'#9'10'#9'Current'#9#9'Payables'
        'Amt5Percent'#9'4'#9'%'#9#9'Payables'
        'Amt6'#9'10'#9'1 - 30'#9#9'Payables'
        'Amt6Percent'#9'4'#9'%'#9#9'Payables'
        'Amt7'#9'10'#9'31 - 60'#9#9'Payables'
        'Amt7Percent'#9'4'#9'%'#9#9'Payables'
        'Amt8'#9'10'#9'61 - 90'#9#9'Payables'
        'Amt8Percent'#9'4'#9'%'#9#9'Payables'
        'Amt9'#9'10'#9'90 +'#9#9'Payables'
        'Amt9Percent'#9'4'#9'%'#9#9'Payables'
        'APtotal'#9'12'#9'Total'#9#9'Payables'
        'Amt10'#9'10'#9'Current'#9#9'Receivables'
        'Amt10Percent'#9'4'#9'%'#9#9'Receivables'
        'Amt11'#9'10'#9'1 - 30'#9#9'Receivables'
        'Amt11Percent'#9'4'#9'%'#9#9'Receivables'
        'Amt12'#9'10'#9'31 - 60'#9#9'Receivables'
        'Amt12Percent'#9'4'#9'%'#9#9'Receivables'
        'Amt13'#9'10'#9'61 - 90'#9#9'Receivables'
        'Amt13Percent'#9'4'#9'%'#9#9'Receivables'
        'Amt14'#9'10'#9'90 +'#9#9'Receivables'
        'Amt14Percent'#9'4'#9'%'#9#9'Receivables'
        'ARtotal'#9'12'#9'Total'#9#9'Receivables'
        'Amt15'#9'10'#9'Sales'#9#9'Last Week (ex)'
        'Amt16'#9'10'#9'Cost of Goods'#9#9'Last Week (ex)'
        'Amt17'#9'10'#9'Expenses'#9#9'Last Week (ex)'
        'Amt18'#9'10'#9'Profit & Loss'#9#9'Last Week (ex)'
        'Amt19'#9'10'#9'Sales'#9#9'Last Month (ex)'
        'Amt20'#9'10'#9'ACost of Goodsmt20'#9#9'Last Month (ex)'
        'Amt21'#9'10'#9'Expenses'#9#9'Last Month (ex)'
        'Amt22'#9'10'#9'Profit & Loss'#9#9'Last Month (ex)'
        'Amt23'#9'10'#9'Sales'#9#9'Last 3 Months (ex)'
        'Amt24'#9'10'#9'Cost of Goods'#9#9'Last 3 Months (ex)'
        'Amt25'#9'10'#9'Expenses'#9#9'Last 3 Months (ex)'
        'Amt26'#9'10'#9'Profit & Loss'#9#9'Last 3 Months (ex)'
        'Amt27'#9'10'#9'Sales'#9#9'Last 12 Months (Ex)'
        'Amt28'#9'10'#9'Cost of Goods'#9#9'Last 12 Months (Ex)'
        'Amt29'#9'10'#9'Expenses'#9#9'Last 12 Months (Ex)'
        'Amt30'#9'10'#9'Profit & loss'#9#9'Last 12 Months (Ex)')
      IniAttributes.SaveToRegistry = True
      IniAttributes.Delimiter = ';;'
      IniAttributes.CheckNewFields = True
      TitleColor = clBtnFace
      FixedCols = 1
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      DataSource = dsMain
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgShowFooter, dgRowResize]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = True
      LineColors.GroupingColor = clSilver
      OnCalcCellColors = grdMainCalcCellColors
      OnDblClick = grdMainDblClick
      FooterColor = clWhite
      FooterCellColor = clWhite
      ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
      PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
      object btnGrid: TwwIButton
        Left = 0
        Top = 0
        Width = 13
        Height = 22
        HelpContext = 1090030
        AllowAllUp = True
      end
    end
    object pnlFxTrading: TDNMPanel
      Left = 1
      Top = 277
      Width = 803
      Height = 154
      HelpContext = 1090031
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
  object chkHidePercentage: TCheckBox [15]
    Left = 873
    Top = 533
    Width = 115
    Height = 17
    HelpContext = 1090032
    Alignment = taLeftJustify
    Anchors = [akRight, akBottom]
    Caption = 'Hide Percentage'
    TabOrder = 9
    OnClick = chkHidePercentageClick
  end
  inherited tmrProcessMessage: TTimer
    Left = 369
    Top = 219
  end
  inherited tmrdelay: TTimer
    Left = 586
    Top = 219
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 760
    Top = 219
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 630
    Top = 219
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 412
    Top = 219
  end
  inherited DataState: TDataState
    Left = 673
    Top = 219
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 804
    Top = 219
  end
  inherited imgsort: TImageList
    Left = 717
    Top = 219
    Bitmap = {
      494C010102009800A00010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 499
    Top = 219
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 848
    Top = 219
  end
  object qryMain: TERPQuery
    SQL.Strings = (
      'select * from tmp_SummarySheets')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    AfterOpen = qryMainAfterOpen
    Left = 456
    Top = 219
    object qryMainDbName: TWideStringField
      DisplayLabel = 'Database'
      DisplayWidth = 20
      FieldName = 'DbName'
      Origin = 'tmp_summarysheets.DbName'
      Size = 255
    end
    object qryMainAmt1: TFloatField
      DisplayLabel = 'Cash in~Hand'
      DisplayWidth = 10
      FieldName = 'Amt1'
      Origin = 'tmp_summarysheets.Amt1'
      currency = True
    end
    object qryMainAmt2: TFloatField
      DisplayLabel = 'Accounts~Receivable'
      DisplayWidth = 10
      FieldName = 'Amt2'
      Origin = 'tmp_summarysheets.Amt2'
      currency = True
    end
    object qryMainAmt3: TFloatField
      DisplayLabel = 'Accounts~Payable'
      DisplayWidth = 10
      FieldName = 'Amt3'
      Origin = 'tmp_summarysheets.Amt3'
      currency = True
    end
    object qryMainAmt4: TFloatField
      DisplayLabel = 'Balance~Sheet'
      DisplayWidth = 10
      FieldName = 'Amt4'
      Origin = 'tmp_summarysheets.Amt4'
      currency = True
    end
    object qryMainAmt5: TFloatField
      DisplayLabel = 'Current'
      DisplayWidth = 10
      FieldName = 'Amt5'
      Origin = 'tmp_summarysheets.Amt5'
      currency = True
    end
    object qryMainAmt5Percent: TFloatField
      DisplayLabel = '%'
      DisplayWidth = 4
      FieldName = 'Amt5Percent'
      Origin = 'tmp_summarysheets.Amt5Percent'
    end
    object qryMainAmt6: TFloatField
      DisplayLabel = '1 - 30'
      DisplayWidth = 10
      FieldName = 'Amt6'
      Origin = 'tmp_summarysheets.Amt6'
      currency = True
    end
    object qryMainAmt6Percent: TFloatField
      DisplayLabel = '%'
      DisplayWidth = 4
      FieldName = 'Amt6Percent'
      Origin = 'tmp_summarysheets.Amt6Percent'
    end
    object qryMainAmt7: TFloatField
      DisplayLabel = '31 - 60'
      DisplayWidth = 10
      FieldName = 'Amt7'
      Origin = 'tmp_summarysheets.Amt7'
      currency = True
    end
    object qryMainAmt7Percent: TFloatField
      DisplayLabel = '%'
      DisplayWidth = 4
      FieldName = 'Amt7Percent'
      Origin = 'tmp_summarysheets.Amt7Percent'
    end
    object qryMainAmt8: TFloatField
      DisplayLabel = '61 - 90'
      DisplayWidth = 10
      FieldName = 'Amt8'
      Origin = 'tmp_summarysheets.Amt8'
      currency = True
    end
    object qryMainAmt8Percent: TFloatField
      DisplayLabel = '%'
      DisplayWidth = 4
      FieldName = 'Amt8Percent'
      Origin = 'tmp_summarysheets.Amt8Percent'
    end
    object qryMainAmt9: TFloatField
      DisplayLabel = '90 +'
      DisplayWidth = 10
      FieldName = 'Amt9'
      Origin = 'tmp_summarysheets.Amt9'
      currency = True
    end
    object qryMainAmt9Percent: TFloatField
      DisplayLabel = '%'
      DisplayWidth = 4
      FieldName = 'Amt9Percent'
      Origin = 'tmp_summarysheets.Amt9Percent'
    end
    object qryMainAmt10: TFloatField
      DisplayLabel = 'Current'
      DisplayWidth = 10
      FieldName = 'Amt10'
      Origin = 'tmp_summarysheets.Amt10'
      currency = True
    end
    object qryMainAmt10Percent: TFloatField
      DisplayLabel = '%'
      DisplayWidth = 4
      FieldName = 'Amt10Percent'
      Origin = 'tmp_summarysheets.Amt10Percent'
    end
    object qryMainAmt11: TFloatField
      DisplayLabel = '1 - 30'
      DisplayWidth = 10
      FieldName = 'Amt11'
      Origin = 'tmp_summarysheets.Amt11'
      currency = True
    end
    object qryMainAmt11Percent: TFloatField
      DisplayLabel = '%'
      DisplayWidth = 4
      FieldName = 'Amt11Percent'
      Origin = 'tmp_summarysheets.Amt11Percent'
    end
    object qryMainAmt12: TFloatField
      DisplayLabel = '31 - 60'
      DisplayWidth = 10
      FieldName = 'Amt12'
      Origin = 'tmp_summarysheets.Amt12'
      currency = True
    end
    object qryMainAmt12Percent: TFloatField
      DisplayLabel = '%'
      DisplayWidth = 4
      FieldName = 'Amt12Percent'
      Origin = 'tmp_summarysheets.Amt12Percent'
    end
    object qryMainAmt13: TFloatField
      DisplayLabel = '61 - 90'
      DisplayWidth = 10
      FieldName = 'Amt13'
      Origin = 'tmp_summarysheets.Amt13'
      currency = True
    end
    object qryMainAmt13Percent: TFloatField
      DisplayLabel = '%'
      DisplayWidth = 4
      FieldName = 'Amt13Percent'
      Origin = 'tmp_summarysheets.Amt13Percent'
    end
    object qryMainAmt14: TFloatField
      DisplayLabel = '90 +'
      DisplayWidth = 10
      FieldName = 'Amt14'
      Origin = 'tmp_summarysheets.Amt14'
      currency = True
    end
    object qryMainAmt14Percent: TFloatField
      DisplayLabel = '%'
      DisplayWidth = 4
      FieldName = 'Amt14Percent'
      Origin = 'tmp_summarysheets.Amt14Percent'
    end
    object qryMainAmt15: TFloatField
      DisplayLabel = 'Sales'
      DisplayWidth = 10
      FieldName = 'Amt15'
      Origin = 'tmp_summarysheets.Amt15'
      currency = True
    end
    object qryMainAmt16: TFloatField
      DisplayLabel = 'Cost of Goods'
      DisplayWidth = 10
      FieldName = 'Amt16'
      Origin = 'tmp_summarysheets.Amt16'
      currency = True
    end
    object qryMainAmt17: TFloatField
      DisplayLabel = 'Expenses'
      DisplayWidth = 10
      FieldName = 'Amt17'
      Origin = 'tmp_summarysheets.Amt17'
      currency = True
    end
    object qryMainAmt18: TFloatField
      DisplayLabel = 'Profit & Loss'
      DisplayWidth = 10
      FieldName = 'Amt18'
      Origin = 'tmp_summarysheets.Amt18'
      currency = True
    end
    object qryMainAmt19: TFloatField
      DisplayLabel = 'Sales'
      DisplayWidth = 10
      FieldName = 'Amt19'
      Origin = 'tmp_summarysheets.Amt19'
      currency = True
    end
    object qryMainAmt20: TFloatField
      DisplayLabel = 'ACost of Goodsmt20'
      DisplayWidth = 10
      FieldName = 'Amt20'
      Origin = 'tmp_summarysheets.Amt20'
      currency = True
    end
    object qryMainAmt21: TFloatField
      DisplayLabel = 'Expenses'
      DisplayWidth = 10
      FieldName = 'Amt21'
      Origin = 'tmp_summarysheets.Amt21'
      currency = True
    end
    object qryMainAmt22: TFloatField
      DisplayLabel = 'Profit & Loss'
      DisplayWidth = 10
      FieldName = 'Amt22'
      Origin = 'tmp_summarysheets.Amt22'
      currency = True
    end
    object qryMainAmt23: TFloatField
      DisplayLabel = 'Sales'
      DisplayWidth = 10
      FieldName = 'Amt23'
      Origin = 'tmp_summarysheets.Amt23'
      currency = True
    end
    object qryMainAmt24: TFloatField
      DisplayLabel = 'Cost of Goods'
      DisplayWidth = 10
      FieldName = 'Amt24'
      Origin = 'tmp_summarysheets.Amt24'
      currency = True
    end
    object qryMainAmt25: TFloatField
      DisplayLabel = 'Expenses'
      DisplayWidth = 10
      FieldName = 'Amt25'
      Origin = 'tmp_summarysheets.Amt25'
      currency = True
    end
    object qryMainAmt26: TFloatField
      DisplayLabel = 'Profit & Loss'
      DisplayWidth = 10
      FieldName = 'Amt26'
      Origin = 'tmp_summarysheets.Amt26'
      currency = True
    end
    object qryMainAmt27: TFloatField
      DisplayLabel = 'Sales'
      DisplayWidth = 10
      FieldName = 'Amt27'
      Origin = 'tmp_summarysheets.Amt27'
      currency = True
    end
    object qryMainAmt28: TFloatField
      DisplayLabel = 'Cost of Goods'
      DisplayWidth = 10
      FieldName = 'Amt28'
      Origin = 'tmp_summarysheets.Amt28'
      currency = True
    end
    object qryMainAmt29: TFloatField
      DisplayLabel = 'Expenses'
      DisplayWidth = 10
      FieldName = 'Amt29'
      Origin = 'tmp_summarysheets.Amt29'
      currency = True
    end
    object qryMainAmt30: TFloatField
      DisplayLabel = 'Profit & loss'
      DisplayWidth = 10
      FieldName = 'Amt30'
      Origin = 'tmp_summarysheets.Amt30'
      currency = True
    end
    object qryMainID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tmp_summarysheets.ID'
      Visible = False
    end
    object qryMainAPtotal: TFloatField
      FieldName = 'APtotal'
      currency = True
    end
    object qryMainARTotal: TFloatField
      FieldName = 'ARTotal'
      currency = True
    end
    object qryMainExchangeRate: TFloatField
      FieldName = 'ExchangeRate'
    end
  end
  object dsMain: TDataSource
    DataSet = qryMain
    Left = 456
    Top = 190
  end
  object ScriptMain: TERPScript
    Connection = MyConnection
    IgnorenContinueOnError = False
    Left = 543
    Top = 219
  end
end
