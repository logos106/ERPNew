inherited fmProductReorderPoints: TfmProductReorderPoints
  Left = 435
  Top = 170
  HelpContext = 1492002
  Caption = 'Reorder Points'
  ClientHeight = 564
  ClientWidth = 996
  ExplicitLeft = 435
  ExplicitTop = 170
  ExplicitWidth = 1012
  ExplicitHeight = 603
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 503
    Width = 996
    HelpContext = 1492003
    ExplicitTop = 504
    ExplicitWidth = 996
  end
  inherited shapehint: TShape
    Left = 9
    ExplicitLeft = 9
  end
  inherited shapehintextra1: TShape
    Left = 56
    ExplicitLeft = 56
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 503
    Width = 996
    Height = 61
    HelpContext = 1492004
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      996
      61)
    object btnOK: TDNMSpeedButton
      Left = 233
      Top = 17
      Width = 87
      Height = 27
      Hint = '"Save and Exit"'
      HelpContext = 1492005
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnOKClick
    end
    object cmdClose: TDNMSpeedButton
      Left = 675
      Top = 17
      Width = 87
      Height = 27
      Hint = '"Close The List"'
      HelpContext = 1492006
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = cmdCloseClick
    end
    object btnAdjsut: TDNMSpeedButton
      Left = 380
      Top = 17
      Width = 87
      Height = 27
      HelpContext = 1492007
      Anchors = [akBottom]
      Caption = 'Adjust'
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
      AutoDisableParentOnclick = True
      OnClick = btnAdjsutClick
    end
    object btnReorder: TDNMSpeedButton
      Left = 527
      Top = 17
      Width = 87
      Height = 27
      HelpContext = 1492008
      Anchors = [akBottom]
      Caption = '&Reorder Lvls'
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
      OnClick = btnReorderClick
    end
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 996
    Height = 61
    HelpContext = 1492009
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      996
      61)
    object lblTo: TLabel
      Left = 823
      Top = 9
      Width = 110
      Height = 15
      HelpContext = 1492010
      Anchors = [akTop, akRight]
      Caption = 'Sales History From '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object dtFrom: TwwDBDateTimePicker
      Left = 823
      Top = 30
      Width = 163
      Height = 23
      HelpContext = 1492011
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
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      ShowButton = True
      TabOrder = 0
      UnboundDataType = wwDTEdtDate
      DisplayFormat = 'MMMM - YYYY'
      OnChange = dtFromChange
    end
  end
  object pnlHeader: TPanel [7]
    Left = 263
    Top = 5
    Width = 469
    Height = 48
    HelpContext = 1492012
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -35
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 2
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 467
      Height = 46
      HelpContext = 1492013
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
        Width = 467
        Height = 46
        HelpContext = 1492014
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Reorder Points'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -35
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitLeft = 2
        ExplicitTop = 1
        ExplicitHeight = 47
      end
    end
  end
  object Panel2: TPanel [8]
    Left = 0
    Top = 61
    Width = 996
    Height = 37
    HelpContext = 1492015
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 3
    object lblcheck2: TLabel
      Left = 121
      Top = 0
      Width = 4
      Height = 37
      HelpContext = 1492016
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
      ExplicitHeight = 18
    end
    object btnRequery: TDNMSpeedButton
      AlignWithMargins = True
      Left = 11
      Top = 3
      Width = 107
      Height = 31
      HelpContext = 1492017
      Margins.Left = 11
      Align = alLeft
      Caption = 'Refresh'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337FF3333333333330003333333333333777F333333333333080333
        3333333F33777FF33F3333B33B000B33B3333373F777773F7333333BBB0B0BBB
        33333337737F7F77F333333BBB0F0BBB33333337337373F73F3333BBB0F7F0BB
        B333337F3737F73F7F3333BB0FB7BF0BB3333F737F37F37F73FFBBBB0BF7FB0B
        BBB3773F7F37337F377333BB0FBFBF0BB333337F73F333737F3333BBB0FBF0BB
        B3333373F73FF7337333333BBB000BBB33333337FF777337F333333BBBBBBBBB
        3333333773FF3F773F3333B33BBBBB33B33333733773773373333333333B3333
        333333333337F33333333333333B333333333333333733333333}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = btnRequeryClick
    end
    object Panel5: TPanel
      AlignWithMargins = True
      Left = 155
      Top = 3
      Width = 374
      Height = 31
      HelpContext = 1492018
      Margins.Left = 30
      Align = alLeft
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 1
      object Label4: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 51
        Height = 25
        HelpContext = 1492019
        Align = alLeft
        Caption = 'Product: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 15
      end
      object DBEdit2: TDBEdit
        AlignWithMargins = True
        Left = 60
        Top = 3
        Width = 288
        Height = 25
        HelpContext = 1492020
        Align = alLeft
        DataField = 'PARTNAME'
        DataSource = dsProductnClass
        Enabled = False
        TabOrder = 0
        ExplicitHeight = 23
      end
    end
    object Panel3: TPanel
      AlignWithMargins = True
      Left = 562
      Top = 3
      Width = 431
      Height = 31
      HelpContext = 1492021
      Margins.Left = 30
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 2
      object lblDepartment: TLabel
        AlignWithMargins = True
        Left = 20
        Top = 3
        Width = 73
        Height = 25
        HelpContext = 1492022
        Margins.Left = 20
        Align = alLeft
        Caption = 'Department: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 15
      end
      object DBEdit3: TDBEdit
        AlignWithMargins = True
        Left = 99
        Top = 3
        Width = 288
        Height = 25
        HelpContext = 1492023
        Align = alLeft
        DataField = 'ClassName'
        DataSource = dsProductnClass
        Enabled = False
        TabOrder = 0
        ExplicitHeight = 23
      end
    end
  end
  object Panel1: TPanel [9]
    Left = 0
    Top = 98
    Width = 996
    Height = 405
    HelpContext = 1492024
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object Label2: TLabel
      Left = 0
      Top = 0
      Width = 996
      Height = 14
      HelpContext = 1492025
      Align = alTop
      Caption = 
        '                               Double Click on Column to Use Thi' +
        's Reorder Point'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsItalic]
      ParentFont = False
      ExplicitWidth = 344
    end
    object Horizontal1: TSplitter
      Left = 0
      Top = 204
      Width = 996
      Height = 3
      Cursor = crVSplit
      HelpContext = 1492026
      Align = alBottom
      ExplicitTop = 219
    end
    object grdMain: TwwDBGrid
      Left = 0
      Top = 14
      Width = 996
      Height = 190
      HelpContext = 1492027
      Selected.Strings = (
        'Line'#9'20'#9'Month'#9'F'#9
        'January'#9'10'#9'January'#9#9
        'February'#9'10'#9'February'#9#9
        'March'#9'10'#9'March'#9#9
        'April'#9'10'#9'April'#9#9
        'May'#9'10'#9'May'#9#9
        'June'#9'10'#9'June'#9#9
        'July'#9'10'#9'July'#9#9
        'August'#9'10'#9'August'#9#9
        'September'#9'10'#9'September'#9#9
        'October'#9'10'#9'October'#9#9
        'November'#9'10'#9'November'#9#9
        'December'#9'10'#9'December'#9#9)
      MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
      IniAttributes.SaveToRegistry = True
      IniAttributes.Delimiter = ';;'
      IniAttributes.CheckNewFields = True
      TitleColor = clWhite
      FixedCols = 1
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      DataSource = dsReorderLevels
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgRowResize]
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
      TitleLines = 1
      TitleButtons = True
      LineColors.GroupingColor = clSilver
      OnTitleButtonClick = grdMainTitleButtonClick
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
        HelpContext = 1492028
        AllowAllUp = True
      end
    end
    object pnlHistory: TDNMPanel
      Left = 0
      Top = 207
      Width = 996
      Height = 198
      HelpContext = 1492029
      Align = alBottom
      Caption = 'pnlHistory'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ShowCaption = False
      TabOrder = 1
      object lblSaleshistory: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 988
        Height = 15
        HelpContext = 1492030
        Align = alTop
        Alignment = taCenter
        Caption = 'Sales Hisotry'
        ExplicitWidth = 75
      end
      object grdHistory: TwwDBGrid
        Left = 1
        Top = 22
        Width = 994
        Height = 175
        HelpContext = 1492031
        Selected.Strings = (
          'Department'#9'20'#9'Department'#9'F'
          'm0'#9'10'#9'm0'#9#9
          'm1'#9'10'#9'm1'#9#9
          'm2'#9'10'#9'm2'#9#9
          'm3'#9'10'#9'm3'#9#9
          'm4'#9'10'#9'm4'#9#9
          'm5'#9'10'#9'm5'#9#9
          'm6'#9'10'#9'm6'#9#9
          'm7'#9'10'#9'm7'#9#9
          'm8'#9'10'#9'm8'#9#9
          'm9'#9'10'#9'm9'#9#9
          'm10'#9'10'#9'm10'#9#9
          'm11'#9'10'#9'm11'#9#9)
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 1
        ShowHorzScrollBar = True
        Align = alClient
        BorderStyle = bsNone
        DataSource = dsHistory
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
        UseTFields = False
        OnCalcCellColors = grdHistoryCalcCellColors
        FooterColor = clWhite
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 392
    Top = 216
  end
  inherited tmrdelay: TTimer
    Left = 428
    Top = 216
  end
  inherited popSpelling: TPopupMenu
    Left = 463
    Top = 216
  end
  inherited tmrdelayMsg: TTimer
    Left = 357
    Top = 216
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 569
    Top = 216
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 604
    Top = 216
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
    Left = 146
    Top = 183
  end
  inherited DataState: TDataState
    Left = 639
    Top = 216
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 498
    Top = 216
  end
  inherited imgsort: TImageList
    Left = 674
    Top = 216
    Bitmap = {
      494C010102004801880110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 146
    Top = 216
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 710
    Top = 216
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 533
    Top = 216
  end
  inherited qryMemTrans: TERPQuery
    Left = 181
    Top = 216
  end
  object dsReorderLevels: TDataSource
    DataSet = QryReorderLevels
    Left = 251
    Top = 247
  end
  object QryReorderLevels: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select '
      '*'
      'from'
      'tmp_reorderpoints_Admin_31B24A11')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Left = 251
    Top = 216
    object QryReorderLevelsLine: TWideStringField
      DisplayLabel = 'Month'
      DisplayWidth = 20
      FieldName = 'Line'
      Size = 30
    end
    object QryReorderLevelsJanuary: TFloatField
      DisplayWidth = 10
      FieldName = 'January'
      DisplayFormat = '####0.00##'
    end
    object QryReorderLevelsFebruary: TFloatField
      DisplayWidth = 10
      FieldName = 'February'
      DisplayFormat = '####0.00##'
    end
    object QryReorderLevelsMarch: TFloatField
      DisplayWidth = 10
      FieldName = 'March'
    end
    object QryReorderLevelsApril: TFloatField
      DisplayWidth = 10
      FieldName = 'April'
      DisplayFormat = '####0.00##'
    end
    object QryReorderLevelsMay: TFloatField
      DisplayWidth = 10
      FieldName = 'May'
      DisplayFormat = '####0.00##'
    end
    object QryReorderLevelsJune: TFloatField
      DisplayWidth = 10
      FieldName = 'June'
      DisplayFormat = '####0.00##'
    end
    object QryReorderLevelsJuly: TFloatField
      DisplayWidth = 10
      FieldName = 'July'
      DisplayFormat = '####0.00##'
    end
    object QryReorderLevelsAugust: TFloatField
      DisplayWidth = 10
      FieldName = 'August'
      DisplayFormat = '####0.00##'
    end
    object QryReorderLevelsSeptember: TFloatField
      DisplayWidth = 10
      FieldName = 'September'
      DisplayFormat = '####0.00##'
    end
    object QryReorderLevelsOctober: TFloatField
      DisplayWidth = 10
      FieldName = 'October'
      DisplayFormat = '####0.00##'
    end
    object QryReorderLevelsNovember: TFloatField
      DisplayWidth = 10
      FieldName = 'November'
      DisplayFormat = '####0.00##'
    end
    object QryReorderLevelsDecember: TFloatField
      DisplayWidth = 10
      FieldName = 'December'
      DisplayFormat = '####0.00##'
    end
  end
  object qryHistory: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select CLS.ClassName as Department,'
      
        'sum(if(PQA.Active ="F" , 0,  if(PQA.TransType in ("TInvoiceLine"' +
        ',"TRefundSaleLine","TPOSCashSaleline","TCashSaleLine"),ifnull(If' +
        '(PQA.TransDate between "2015-10-01" and "2015-10-31",PQA.Qty,0),' +
        '0),0))) as m0'
      
        ',sum(if(PQA.Active ="F" , 0,  if(PQA.TransType in ("TInvoiceLine' +
        '","TRefundSaleLine","TPOSCashSaleline","TCashSaleLine"),ifnull(I' +
        'f(PQA.TransDate between "2015-11-01" and "2015-11-30",PQA.Qty,0)' +
        ',0),0))) as m1'
      
        ',sum(if(PQA.Active ="F" , 0,  if(PQA.TransType in ("TInvoiceLine' +
        '","TRefundSaleLine","TPOSCashSaleline","TCashSaleLine"),ifnull(I' +
        'f(PQA.TransDate between "2015-12-01" and "2015-12-31",PQA.Qty,0)' +
        ',0),0))) as m2'
      
        ',sum(if(PQA.Active ="F" , 0,  if(PQA.TransType in ("TInvoiceLine' +
        '","TRefundSaleLine","TPOSCashSaleline","TCashSaleLine"),ifnull(I' +
        'f(PQA.TransDate between "2016-01-01" and "2016-01-31",PQA.Qty,0)' +
        ',0),0))) as m3'
      
        ',sum(if(PQA.Active ="F" , 0,  if(PQA.TransType in ("TInvoiceLine' +
        '","TRefundSaleLine","TPOSCashSaleline","TCashSaleLine"),ifnull(I' +
        'f(PQA.TransDate between "2016-02-01" and "2016-02-29",PQA.Qty,0)' +
        ',0),0))) as m4'
      
        ',sum(if(PQA.Active ="F" , 0,  if(PQA.TransType in ("TInvoiceLine' +
        '","TRefundSaleLine","TPOSCashSaleline","TCashSaleLine"),ifnull(I' +
        'f(PQA.TransDate between "2016-03-01" and "2016-03-31",PQA.Qty,0)' +
        ',0),0))) as m5'
      
        ',sum(if(PQA.Active ="F" , 0,  if(PQA.TransType in ("TInvoiceLine' +
        '","TRefundSaleLine","TPOSCashSaleline","TCashSaleLine"),ifnull(I' +
        'f(PQA.TransDate between "2016-04-01" and "2016-04-30",PQA.Qty,0)' +
        ',0),0))) as m6'
      
        ',sum(if(PQA.Active ="F" , 0,  if(PQA.TransType in ("TInvoiceLine' +
        '","TRefundSaleLine","TPOSCashSaleline","TCashSaleLine"),ifnull(I' +
        'f(PQA.TransDate between "2016-05-01" and "2016-05-31",PQA.Qty,0)' +
        ',0),0))) as m7'
      
        ',sum(if(PQA.Active ="F" , 0,  if(PQA.TransType in ("TInvoiceLine' +
        '","TRefundSaleLine","TPOSCashSaleline","TCashSaleLine"),ifnull(I' +
        'f(PQA.TransDate between "2016-06-01" and "2016-06-30",PQA.Qty,0)' +
        ',0),0))) as m8'
      
        ',sum(if(PQA.Active ="F" , 0,  if(PQA.TransType in ("TInvoiceLine' +
        '","TRefundSaleLine","TPOSCashSaleline","TCashSaleLine"),ifnull(I' +
        'f(PQA.TransDate between "2016-07-01" and "2016-07-31",PQA.Qty,0)' +
        ',0),0))) as m9'
      
        ',sum(if(PQA.Active ="F" , 0,  if(PQA.TransType in ("TInvoiceLine' +
        '","TRefundSaleLine","TPOSCashSaleline","TCashSaleLine"),ifnull(I' +
        'f(PQA.TransDate between "2016-08-01" and "2016-08-31",PQA.Qty,0)' +
        ',0),0))) as m10'
      
        ',sum(if(PQA.Active ="F" , 0,  if(PQA.TransType in ("TInvoiceLine' +
        '","TRefundSaleLine","TPOSCashSaleline","TCashSaleLine"),ifnull(I' +
        'f(PQA.TransDate between "2016-09-01" and "2016-09-30",PQA.Qty,0)' +
        ',0),0))) as m11'
      ',CLS.ClassId'
      'from tblPQA PQA '
      'left join tblClass CLS on PQA.DepartmentId = CLS.ClassId'
      'where productid=698 '
      'group by PQA.DepartmentId')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    AfterOpen = qryHistoryAfterOpen
    AfterScroll = qryHistoryAfterScroll
    Left = 289
    Top = 216
    object qryHistoryDepartment: TWideStringField
      FieldName = 'Department'
      Size = 60
    end
    object qryHistorym0: TFloatField
      FieldName = 'm0'
      DisplayFormat = '####0.00##'
    end
    object qryHistorym1: TFloatField
      FieldName = 'm1'
      DisplayFormat = '####0.00##'
    end
    object qryHistorym2: TFloatField
      FieldName = 'm2'
      DisplayFormat = '####0.00##'
    end
    object qryHistorym3: TFloatField
      FieldName = 'm3'
      DisplayFormat = '####0.00##'
    end
    object qryHistorym4: TFloatField
      FieldName = 'm4'
      DisplayFormat = '####0.00##'
    end
    object qryHistorym5: TFloatField
      FieldName = 'm5'
      DisplayFormat = '####0.00##'
    end
    object qryHistorym6: TFloatField
      FieldName = 'm6'
      DisplayFormat = '####0.00##'
    end
    object qryHistorym7: TFloatField
      FieldName = 'm7'
      DisplayFormat = '####0.00##'
    end
    object qryHistorym8: TFloatField
      FieldName = 'm8'
      DisplayFormat = '####0.00##'
    end
    object qryHistorym9: TFloatField
      FieldName = 'm9'
      DisplayFormat = '####0.00##'
    end
    object qryHistorym10: TFloatField
      FieldName = 'm10'
      DisplayFormat = '####0.00##'
    end
    object qryHistorym11: TFloatField
      FieldName = 'm11'
      DisplayFormat = '####0.00##'
    end
    object qryHistoryClassId: TIntegerField
      FieldName = 'ClassId'
    end
  end
  object dsHistory: TDataSource
    DataSet = qryHistory
    Left = 289
    Top = 247
  end
  object dsProductnClass: TDataSource
    DataSet = QryProductnClass
    Left = 216
    Top = 247
  end
  object QryProductnClass: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select '
      'P.PARTNAME, '
      'PC.ClassName'
      
        'from tblparts P left join tblproductclasses PC on P.PARTSID = PC' +
        '.ProductID and PC.ClassID = :ClassId'
      'where P.partsId = :ProductId')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Left = 216
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ClassId'
      end
      item
        DataType = ftUnknown
        Name = 'ProductId'
      end>
    object QryProductnClassPARTNAME: TWideStringField
      FieldName = 'PARTNAME'
      Size = 60
    end
    object QryProductnClassClassName: TWideStringField
      FieldName = 'ClassName'
      Size = 255
    end
  end
end
