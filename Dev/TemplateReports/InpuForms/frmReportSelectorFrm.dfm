inherited frmReportSelectorGUI: TfrmReportSelectorGUI
  Left = 435
  Top = 182
  HelpContext = 344000
  Caption = 'Report Selector'
  ClientWidth = 829
  OldCreateOrder = True
  ExplicitLeft = 435
  ExplicitTop = 182
  ExplicitWidth = 845
  ExplicitHeight = 571
  DesignSize = (
    829
    532)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 490
    Width = 829
    HelpContext = 344020
    ExplicitTop = 479
    ExplicitWidth = 829
  end
  inherited imgGridWatermark: TImage
    HelpContext = 344001
  end
  object grdGroupCharts: TwwDBGrid [5]
    Left = 498
    Top = 89
    Width = 325
    Height = 336
    HelpContext = 344025
    Selected.Strings = (
      'ChartName'#9'30'#9'                                 Charts'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akBottom]
    DataSource = DSCharts
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ParentFont = False
    TabOrder = 4
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    OnDblClick = grdGroupChartsDblClick
    FooterColor = clWhite
    FooterCellColor = clWhite
    object wwIButton1: TwwIButton
      Left = 0
      Top = 0
      Width = 17
      Height = 22
      HelpContext = 344026
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
      OnClick = wwIButton1Click
    end
  end
  object DNMPanel4: TDNMPanel [6]
    Left = 499
    Top = 47
    Width = 325
    Height = 38
    HelpContext = 344027
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    DesignSize = (
      325
      38)
    object Label3: TLabel
      Left = 17
      Top = 11
      Width = 53
      Height = 16
      HelpContext = 344028
      Alignment = taRightJustify
      AutoSize = False
      Caption = '&Search '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object edtSearch2: TEdit
      Left = 78
      Top = 7
      Width = 237
      Height = 23
      Hint = '"Type In What To Filter This Column By"'
      HelpContext = 344029
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnChange = edtSearch2Change
    end
  end
  object DNMPanel5: TDNMPanel [7]
    Left = 175
    Top = 47
    Width = 325
    Height = 38
    HelpContext = 344030
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    object Label2: TLabel
      Left = 7
      Top = 10
      Width = 53
      Height = 16
      HelpContext = 344031
      Alignment = taRightJustify
      AutoSize = False
      Caption = '&Search '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object cboSearch: TwwDBComboBox
      Left = 65
      Top = 6
      Width = 249
      Height = 23
      HelpContext = 344032
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      AutoDropDown = True
      ShowMatchText = True
      Column1Width = 350
      DropDownCount = 8
      DropDownWidth = 350
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      ParentFont = False
      Sorted = True
      TabOrder = 0
      UnboundDataType = wwDefault
      TwoColumnDisplay = True
      OnCloseUp = cboSearchCloseUp
    end
  end
  object dbgReports: TwwDBGrid [8]
    Left = 175
    Top = 89
    Width = 325
    Height = 336
    HelpContext = 344004
    ControlType.Strings = (
      'charts;CustomEdit;btnExpand;F')
    Selected.Strings = (
      'Report'#9'30'#9'Reports')
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akBottom]
    DataSource = dsReportItem
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgPerfectRowFit]
    ParentFont = False
    TabOrder = 2
    TitleAlignment = taCenter
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
    OnCalcCellColors = dbgReportsCalcCellColors
    OnDblClick = dbgReportsDblClick
    FooterColor = clWhite
    FooterCellColor = clWhite
    object btnDelete: TwwIButton
      Left = 0
      Top = 0
      Width = 17
      Height = 22
      HelpContext = 344033
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
      OnClick = btnDeleteClick
    end
  end
  object DNMPanel1: TDNMPanel [9]
    Left = 6
    Top = 47
    Width = 161
    Height = 442
    HelpContext = 344002
    BevelOuter = bvLowered
    Color = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      161
      442)
    object rgGroups: TwwRadioGroup
      Left = 4
      Top = 6
      Width = 141
      Height = 428
      HelpContext = 344003
      DisableThemes = False
      TransparentActiveItem = True
      Frame.Enabled = True
      Frame.FocusStyle = efsFrameEtched
      ButtonFrame.Transparent = True
      ButtonFrame.FocusStyle = efsFrameEtched
      Transparent = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnChange = rgGroupsChange
    end
  end
  object Panel1: TDNMPanel [10]
    Left = 0
    Top = 0
    Width = 829
    Height = 46
    HelpContext = 344005
    Align = alTop
    BevelWidth = 0
    Color = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      829
      46)
    object pnlTitle: TDNMPanel
      Left = 289
      Top = 3
      Width = 252
      Height = 38
      HelpContext = 344006
      Anchors = [akTop]
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
        Width = 248
        Height = 34
        HelpContext = 344007
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
          Width = 248
          Height = 34
          HelpContext = 344008
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Report Selector'
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
    object edtSearch: TEdit
      Left = 138
      Top = 6
      Width = 127
      Height = 23
      Hint = '"Type In What To Filter This Column By"'
      HelpContext = 344034
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Visible = False
      OnChange = edtSearchChange
    end
  end
  object Panel2: TDNMPanel [11]
    Left = 173
    Top = 426
    Width = 651
    Height = 63
    HelpContext = 344009
    Align = alCustom
    Anchors = [akLeft, akRight, akBottom]
    BevelWidth = 0
    Color = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object DNMPanel2: TDNMPanel
      Left = 0
      Top = 0
      Width = 651
      Height = 63
      HelpContext = 344012
      Align = alClient
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        651
        63)
      object lblFrom: TLabel
        Left = 315
        Top = 15
        Width = 29
        Height = 15
        HelpContext = 344013
        Anchors = [akTop, akRight]
        Caption = 'From'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExplicitLeft = 288
      end
      object lblTo: TLabel
        Left = 475
        Top = 15
        Width = 13
        Height = 15
        HelpContext = 344014
        Anchors = [akTop, akRight]
        Caption = 'To'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExplicitLeft = 448
      end
      object Label1: TLabel
        Left = 149
        Top = 40
        Width = 332
        Height = 15
        HelpContext = 344015
        Caption = 'Note: Week begins on Monday  &&  Date Ranges are inclusive'
        Color = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object cboDateRange: TComboBox
        Left = 53
        Top = 10
        Width = 212
        Height = 23
        Hint = 
          'eg '#39'This Week'#39' - The week starting on Monday that includes today' +
          '; Last Week - the last 7 days ending today; Previous Week - The ' +
          'week prior to this week'
        HelpContext = 344016
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Text = 'Default Range'
        OnChange = cboDateRangeChange
        Items.Strings = (
          'Default Range'
          'Today'
          'Yesterday'
          'Last Week'
          'Last Month'
          'Last Quarter'
          'Last 12 Months'
          'Previous Week'
          'Previous Month'
          'Previous Quarter'
          'Previous Financial Year'
          'This Week'
          'This Month'
          'This Quarter'
          'This Financial Year'
          'This Financial Year To Date')
      end
      object dtFrom: TDateTimePicker
        Left = 351
        Top = 10
        Width = 88
        Height = 23
        HelpContext = 344017
        Anchors = [akTop, akRight]
        Date = 37432.721911041700000000
        Time = 37432.721911041700000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = False
      end
      object dtTo: TDateTimePicker
        Left = 496
        Top = 10
        Width = 89
        Height = 23
        HelpContext = 344018
        Anchors = [akTop, akRight]
        Date = 37432.721911041700000000
        Time = 37432.721911041700000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        TabStop = False
      end
    end
  end
  object DNMPanel3: TDNMPanel [12]
    Left = 0
    Top = 490
    Width = 829
    Height = 42
    HelpContext = 344035
    Align = alBottom
    BevelWidth = 0
    Color = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    DesignSize = (
      829
      42)
    object BevelEmail: TBevel
      Left = 371
      Top = 7
      Width = 87
      Height = 27
      HelpContext = 344021
    end
    object Bevelschedule: TBevel
      Left = 484
      Top = 7
      Width = 87
      Height = 27
      HelpContext = 344022
    end
    object btnOk: TDNMSpeedButton
      Left = 146
      Top = 7
      Width = 87
      Height = 27
      HelpContext = 344010
      Anchors = [akTop]
      Caption = 'O&K'
      Default = True
      DisableTransparent = False
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
      Kind = bkOK
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = btnOkClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 597
      Top = 7
      Width = 87
      Height = 27
      HelpContext = 344011
      Anchors = [akTop]
      Cancel = True
      Caption = '&Cancel'
      DisableTransparent = False
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
      Kind = bkCancel
      ModalResult = 2
      NumGlyphs = 2
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = btnCancelClick
    end
    object btnUpdateBatch: TDNMSpeedButton
      Left = 258
      Top = 7
      Width = 87
      Height = 27
      HelpContext = 344019
      Anchors = [akTop]
      Caption = 'Update Batch'
      Default = True
      DisableTransparent = False
      Enabled = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = btnUpdateBatchClick
    end
    object btnSchedule: TDNMSpeedButton
      Left = 484
      Top = 7
      Width = 87
      Height = 27
      HelpContext = 344036
      Anchors = [akTop]
      Caption = 'Schedule'
      Default = True
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      TabOrder = 3
      AutoDisableParentOnclick = True
      OnClick = btnScheduleClick
    end
    object btnEmail: TDNMSpeedButton
      Left = 6
      Top = 7
      Width = 87
      Height = 27
      HelpContext = 344023
      Anchors = [akBottom]
      Caption = 'Email Reports'
      Default = True
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = btnEmailClick
    end
    object btnEmailReport: TDNMSpeedButton
      Left = 371
      Top = 7
      Width = 87
      Height = 27
      HelpContext = 344024
      Anchors = [akBottom]
      Caption = 'Email'
      Default = True
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      TabOrder = 5
      AutoDisableParentOnclick = True
      OnClick = btnEmailReportClick
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 327
    Top = 112
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 395
    Top = 112
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 14
    Top = 3
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 46
    Top = 4
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C0101020084009C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object mtReportItem: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Group'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Report'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'onClickPtr'
        DataType = ftInteger
      end
      item
        Name = 'ClassName'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'GuiID'
        DataType = ftInteger
        Precision = 11
      end
      item
        Name = 'ListName'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'charts'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Emailable'
        DataType = ftBoolean
      end>
    IndexDefs = <>
    SortFields = 'Report'
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Version = '6.51.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    AfterScroll = mtReportItemAfterScroll
    OnFilterRecord = mtReportItemFilterRecord
    Left = 342
    Top = 224
  end
  object dsReportItem: TDataSource
    DataSet = mtReportItem
    Left = 342
    Top = 253
  end
  object ChkBatchMode: TTimer
    Interval = 500
    OnTimer = ChkBatchModeTimer
    Left = 200
    Top = 208
  end
  object DSCharts: TDataSource
    DataSet = qryDummy
    Left = 680
    Top = 8
  end
  object qryDummy: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * FROM tblcustomcharts')
    Left = 718
    Top = 6
    object qryDummyChartName: TWideStringField
      DisplayLabel = '                                 Charts'
      DisplayWidth = 30
      FieldName = 'ChartName'
      Size = 255
    end
  end
  object QryEmailReports: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select F.formID, F.formname from tblEmailReports ER inner join t' +
        'blForms F on ER.formId = f.formID and ER.active ="T"')
    Left = 408
    Top = 208
    object QryEmailReportsformID: TIntegerField
      FieldName = 'formID'
    end
    object QryEmailReportsformname: TWideStringField
      FieldName = 'formname'
      Size = 50
    end
  end
end
