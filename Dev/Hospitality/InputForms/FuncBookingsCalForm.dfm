inherited FuncBookingsCalGUI: TFuncBookingsCalGUI
  Left = 170
  Top = 117
  Caption = 'Function Bookings Calendar'
  ClientHeight = 561
  ClientWidth = 961
  OldCreateOrder = True
  DesignSize = (
    961
    561)
  PixelsPerInch = 96
  TextHeight = 15
  object Label3: TLabel [0]
    Left = 779
    Top = 21
    Width = 96
    Height = 15
    Caption = 'Time Increments'
    Transparent = True
  end
  object btnPrint: TDNMSpeedButton [2]
    Left = 372
    Top = 526
    Width = 87
    Height = 27
    Anchors = [akRight, akBottom]
    Caption = 'Prin&t'
    DisableTransparent = False
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      0003377777777777777308888888888888807F33333333333337088888888888
      88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
      8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
      8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
      03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
      03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
      33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
      33333337FFFF7733333333300000033333333337777773333333}
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    TabOrder = 2
  end
  object btnCancel: TDNMSpeedButton [3]
    Left = 109
    Top = 528
    Width = 87
    Height = 27
    Anchors = [akRight, akBottom]
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
    ModalResult = 2
    NumGlyphs = 2
    TabOrder = 3
    Visible = False
    OnClick = btnCancelClick
  end
  object lstColorBox: TListBox [4]
    Left = 80
    Top = 336
    Width = 49
    Height = 129
    ItemHeight = 15
    Items.Strings = (
      'clWhite'
      'clRed'
      'clBlue'
      'clGreen'
      'clYellow'
      'clPurple'
      'clGray'
      'clAqua'
      'clNavy'
      'clLime'
      'clTeal'
      'clFuchsia'
      'clMaroon'
      'clOlive'
      'clsilver'
      'clBlack')
    TabOrder = 4
    Visible = False
  end
  object lstFontColor: TListBox [5]
    Left = 136
    Top = 336
    Width = 49
    Height = 129
    ItemHeight = 15
    Items.Strings = (
      'clBlack'
      'clWhite'
      'clWhite'
      'clWhite'
      'clBlack'
      'clWhite'
      'clWhite'
      'clBlack'
      'clWhite'
      'clBlack'
      'clBlack'
      'clWhite'
      'clWhite'
      'clWhite'
      'clBlack'
      'clWhite')
    TabOrder = 5
    Visible = False
  end
  object dtpDate: TwwDBDateTimePicker [6]
    Left = 20
    Top = 13
    Width = 189
    Height = 26
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ShowButton = True
    TabOrder = 6
    DisplayFormat = 'dd mmmm yyyy'
    OnChange = dtpDateChange
  end
  object btnClose: TDNMSpeedButton [7]
    Left = 518
    Top = 526
    Width = 87
    Height = 27
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Close'
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
    NumGlyphs = 2
    TabOrder = 7
    OnClick = btnCloseClick
  end
  object cboTimeInc: TwwDBComboBox [8]
    Left = 880
    Top = 16
    Width = 57
    Height = 23
    ShowButton = True
    Style = csDropDownList
    MapList = False
    AllowClearKey = False
    DropDownCount = 8
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      '5'
      '10'
      '15'
      '20'
      '25'
      '30'
      '35'
      '40'
      '45'
      '50'
      '55'
      '60')
    ItemIndex = 5
    ParentFont = False
    Sorted = False
    TabOrder = 8
    UnboundDataType = wwDefault
    OnCloseUp = cboTimeIncCloseUp
  end
  object PageControl1: TPageControl [9]
    Left = 16
    Top = 56
    Width = 937
    Height = 457
    ActivePage = tabDaily
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabHeight = 23
    TabIndex = 0
    TabOrder = 0
    TabWidth = 233
    OnChange = PageControl1Change
    OnChanging = PageControl1Changing
    object tabDaily: TTabSheet
      Caption = 'Daily'
      object plannerDay: TDBPlanner
        Left = 0
        Top = 0
        Width = 929
        Height = 424
        Align = alClient
        AttachementGlyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888888700078888888888708880788888888808808808888888880808080
          8888888880808080888888888080808088888888808080808888888880808080
          8888888880808080888888888080808088888888808080808888888888808080
          8888888888808880888888888888000888888888888888888888}
        Balloon.AutoHideDelay = 10000
        Balloon.InitialDelay = 100
        Balloon.ReshowDelay = 100
        Caption.Title = 'TDBPlanner'
        Caption.Font.Charset = DEFAULT_CHARSET
        Caption.Font.Color = clWhite
        Caption.Font.Height = -13
        Caption.Font.Name = 'MS Sans Serif'
        Caption.Font.Style = [fsBold]
        Caption.Visible = False
        DayNames.Strings = (
          'Sun'
          'Mon'
          'Tue'
          'Wed'
          'Thu'
          'Fri'
          'Sat')
        DefaultItem.CaptionFont.Charset = DEFAULT_CHARSET
        DefaultItem.CaptionFont.Color = clWindowText
        DefaultItem.CaptionFont.Height = -11
        DefaultItem.CaptionFont.Name = 'MS Sans Serif'
        DefaultItem.CaptionFont.Style = []
        DefaultItem.Cursor = -1
        DefaultItem.Font.Charset = DEFAULT_CHARSET
        DefaultItem.Font.Color = clWindowText
        DefaultItem.Font.Height = -11
        DefaultItem.Font.Name = 'MS Sans Serif'
        DefaultItem.Font.Style = []
        DefaultItem.ItemBegin = 16
        DefaultItem.ItemEnd = 17
        DefaultItem.ItemPos = 0
        DefaultItem.Name = 'PlannerItem0'
        DefaultItem.Shadow = True
        DeleteGlyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          0800000000000001000000000000000000000001000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A6000020400000206000002080000020A0000020C0000020E000004000000040
          20000040400000406000004080000040A0000040C0000040E000006000000060
          20000060400000606000006080000060A0000060C0000060E000008000000080
          20000080400000806000008080000080A0000080C0000080E00000A0000000A0
          200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
          200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
          200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
          20004000400040006000400080004000A0004000C0004000E000402000004020
          20004020400040206000402080004020A0004020C0004020E000404000004040
          20004040400040406000404080004040A0004040C0004040E000406000004060
          20004060400040606000406080004060A0004060C0004060E000408000004080
          20004080400040806000408080004080A0004080C0004080E00040A0000040A0
          200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
          200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
          200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
          20008000400080006000800080008000A0008000C0008000E000802000008020
          20008020400080206000802080008020A0008020C0008020E000804000008040
          20008040400080406000804080008040A0008040C0008040E000806000008060
          20008060400080606000806080008060A0008060C0008060E000808000008080
          20008080400080806000808080008080A0008080C0008080E00080A0000080A0
          200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
          200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
          200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
          2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
          2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
          2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
          2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
          2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
          2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
          2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00D9ED07070707
          0707070707070707ECD9EC5E5E5E5E5E5E5E5E5E5E5E5E5E5DED070D0E161616
          161616160E0E0E0E5E07070D161656561616161616160E0E5E07070D16AF075E
          56561657B7EF0E0E5E07070D56AFF6075F565FAFF6AF160E5E07070D565EAFF6
          075FEFF6AF17160E5E07070D5E5E5EAFF607F6AF161616165E07070D5E5E5E5E
          EFF60756161616165E07070D5E5E5FEFF6EFF6075E1616165E07070D5F5F07F6
          EF5EAFF6075616165E07070D6707F6075E5656AFF60716165E07070DA7AF075F
          5E5E5E5EAFAF56165E07070DA7A7675F5F5E5E5E5E5E56165E07EDAF0D0D0D0D
          0D0D0D0D0D0D0D0D5EECD9ED070707070707070707070707EDD1}
        Display.ActiveStart = 0
        Display.ActiveEnd = 400
        Display.ColorNonActive = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Footer.CompletionFormat = '%d%%'
        Footer.Completion.Font.Charset = DEFAULT_CHARSET
        Footer.Completion.Font.Color = clWindowText
        Footer.Completion.Font.Height = -11
        Footer.Completion.Font.Name = 'Arial'
        Footer.Completion.Font.Style = []
        Footer.Font.Charset = DEFAULT_CHARSET
        Footer.Font.Color = clWindowText
        Footer.Font.Height = -11
        Footer.Font.Name = 'MS Sans Serif'
        Footer.Font.Style = []
        GridLeftCol = 1
        GridTopRow = 17
        Header.Alignment = taCenter
        Header.CustomGroups = <>
        Header.Height = 45
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.GroupFont.Charset = DEFAULT_CHARSET
        Header.GroupFont.Color = clWindowText
        Header.GroupFont.Height = -11
        Header.GroupFont.Name = 'MS Sans Serif'
        Header.GroupFont.Style = []
        Header.ItemHeight = 45
        Header.TextHeight = 45
        HintPause = 7000
        HTMLOptions.CellFontStyle = []
        HTMLOptions.HeaderFontStyle = []
        HTMLOptions.SidebarFontStyle = []
        Items = <>
        Mode.Month = 1
        Mode.PeriodStartDay = 22
        Mode.PeriodStartMonth = 1
        Mode.PeriodStartYear = 2004
        Mode.PeriodEndDay = 10
        Mode.PeriodEndMonth = 3
        Mode.PeriodEndYear = 2004
        Mode.TimeLineStart = 38008
        Mode.TimeLineNVUBegin = 0
        Mode.TimeLineNVUEnd = 0
        Mode.Year = 2004
        ShowHint = True
        Sidebar.Font.Charset = DEFAULT_CHARSET
        Sidebar.Font.Color = clWindowText
        Sidebar.Font.Height = -11
        Sidebar.Font.Name = 'Arial'
        Sidebar.Font.Style = []
        Sidebar.HourFontRatio = 1.8
        PositionProps = <>
        PrintOptions.FooterFont.Charset = DEFAULT_CHARSET
        PrintOptions.FooterFont.Color = clWindowText
        PrintOptions.FooterFont.Height = -11
        PrintOptions.FooterFont.Name = 'MS Sans Serif'
        PrintOptions.FooterFont.Style = []
        PrintOptions.HeaderFont.Charset = DEFAULT_CHARSET
        PrintOptions.HeaderFont.Color = clWindowText
        PrintOptions.HeaderFont.Height = -11
        PrintOptions.HeaderFont.Name = 'MS Sans Serif'
        PrintOptions.HeaderFont.Style = []
        URLGlyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888880000800
          0088888808F8F0F8F80888808000000000808880F070888070F0888080000000
          0080880408F8F0F8F80880CCC0000400008874CCC2222C4788887CCCC22226C0
          88887CC822222CC088887C822224642088887C888422C220888877CF8CCCC227
          888887F8F8222208888888776888208888888887777778888888}
        Version = '2.5.3.4'
        OnItemDblClick = plannerDayItemDblClick
        OnPlannerDblClick = plannerDayPlannerDblClick
        ItemSource = DaySource
      end
    end
    object tabWeekly: TTabSheet
      Caption = 'Weekly'
      ImageIndex = 1
      object plannerWeek: TDBPlanner
        Left = 0
        Top = 0
        Width = 929
        Height = 424
        Align = alClient
        AttachementGlyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888888700078888888888708880788888888808808808888888880808080
          8888888880808080888888888080808088888888808080808888888880808080
          8888888880808080888888888080808088888888808080808888888888808080
          8888888888808880888888888888000888888888888888888888}
        Balloon.InitialDelay = 100
        Caption.Title = 'TDBPlanner'
        Caption.Font.Charset = DEFAULT_CHARSET
        Caption.Font.Color = clWhite
        Caption.Font.Height = -13
        Caption.Font.Name = 'MS Sans Serif'
        Caption.Font.Style = [fsBold]
        DayNames.Strings = (
          'Sun'
          'Mon'
          'Tue'
          'Wed'
          'Thu'
          'Fri'
          'Sat')
        DefaultItem.CaptionFont.Charset = DEFAULT_CHARSET
        DefaultItem.CaptionFont.Color = clWindowText
        DefaultItem.CaptionFont.Height = -11
        DefaultItem.CaptionFont.Name = 'MS Sans Serif'
        DefaultItem.CaptionFont.Style = []
        DefaultItem.Cursor = -1
        DefaultItem.Font.Charset = DEFAULT_CHARSET
        DefaultItem.Font.Color = clWindowText
        DefaultItem.Font.Height = -11
        DefaultItem.Font.Name = 'MS Sans Serif'
        DefaultItem.Font.Style = []
        DefaultItem.ItemBegin = 16
        DefaultItem.ItemEnd = 17
        DefaultItem.ItemPos = 0
        DefaultItem.Name = 'PlannerItem0'
        DefaultItem.Shadow = True
        DeleteGlyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          0800000000000001000000000000000000000001000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A6000020400000206000002080000020A0000020C0000020E000004000000040
          20000040400000406000004080000040A0000040C0000040E000006000000060
          20000060400000606000006080000060A0000060C0000060E000008000000080
          20000080400000806000008080000080A0000080C0000080E00000A0000000A0
          200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
          200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
          200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
          20004000400040006000400080004000A0004000C0004000E000402000004020
          20004020400040206000402080004020A0004020C0004020E000404000004040
          20004040400040406000404080004040A0004040C0004040E000406000004060
          20004060400040606000406080004060A0004060C0004060E000408000004080
          20004080400040806000408080004080A0004080C0004080E00040A0000040A0
          200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
          200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
          200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
          20008000400080006000800080008000A0008000C0008000E000802000008020
          20008020400080206000802080008020A0008020C0008020E000804000008040
          20008040400080406000804080008040A0008040C0008040E000806000008060
          20008060400080606000806080008060A0008060C0008060E000808000008080
          20008080400080806000808080008080A0008080C0008080E00080A0000080A0
          200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
          200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
          200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
          2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
          2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
          2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
          2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
          2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
          2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
          2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00D9ED07070707
          0707070707070707ECD9EC5E5E5E5E5E5E5E5E5E5E5E5E5E5DED070D0E161616
          161616160E0E0E0E5E07070D161656561616161616160E0E5E07070D16AF075E
          56561657B7EF0E0E5E07070D56AFF6075F565FAFF6AF160E5E07070D565EAFF6
          075FEFF6AF17160E5E07070D5E5E5EAFF607F6AF161616165E07070D5E5E5E5E
          EFF60756161616165E07070D5E5E5FEFF6EFF6075E1616165E07070D5F5F07F6
          EF5EAFF6075616165E07070D6707F6075E5656AFF60716165E07070DA7AF075F
          5E5E5E5EAFAF56165E07070DA7A7675F5F5E5E5E5E5E56165E07EDAF0D0D0D0D
          0D0D0D0D0D0D0D0D5EECD9ED070707070707070707070707EDD1}
        Display.ActiveStart = 0
        Display.ActiveEnd = 400
        Display.DisplayEnd = 29
        Display.DisplayScale = 25
        Display.ColorNonActive = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Footer.CompletionFormat = '%d%%'
        Footer.Completion.Font.Charset = DEFAULT_CHARSET
        Footer.Completion.Font.Color = clWindowText
        Footer.Completion.Font.Height = -11
        Footer.Completion.Font.Name = 'Arial'
        Footer.Completion.Font.Style = []
        Footer.Font.Charset = DEFAULT_CHARSET
        Footer.Font.Color = clWindowText
        Footer.Font.Height = -11
        Footer.Font.Name = 'MS Sans Serif'
        Footer.Font.Style = []
        GridLeftCol = 1
        GridTopRow = 12
        Header.CustomGroups = <>
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.GroupFont.Charset = DEFAULT_CHARSET
        Header.GroupFont.Color = clWindowText
        Header.GroupFont.Height = -11
        Header.GroupFont.Name = 'MS Sans Serif'
        Header.GroupFont.Style = []
        HintPause = 7000
        HTMLOptions.CellFontStyle = []
        HTMLOptions.HeaderFontStyle = []
        HTMLOptions.SidebarFontStyle = []
        Items = <>
        Mode.Month = 1
        Mode.PeriodStartDay = 24
        Mode.PeriodStartMonth = 1
        Mode.PeriodStartYear = 2004
        Mode.PeriodEndDay = 7
        Mode.PeriodEndMonth = 2
        Mode.PeriodEndYear = 2004
        Mode.PlannerType = plHalfDayPeriod
        Mode.TimeLineStart = 38008
        Mode.TimeLineNVUBegin = 0
        Mode.TimeLineNVUEnd = 0
        Mode.Year = 2004
        ShowHint = True
        Sidebar.Font.Charset = DEFAULT_CHARSET
        Sidebar.Font.Color = clWindowText
        Sidebar.Font.Height = -11
        Sidebar.Font.Name = 'Arial'
        Sidebar.Font.Style = []
        Sidebar.HourFontRatio = 1.8
        Sidebar.Width = 70
        PositionProps = <>
        PrintOptions.FooterFont.Charset = DEFAULT_CHARSET
        PrintOptions.FooterFont.Color = clWindowText
        PrintOptions.FooterFont.Height = -11
        PrintOptions.FooterFont.Name = 'MS Sans Serif'
        PrintOptions.FooterFont.Style = []
        PrintOptions.HeaderFont.Charset = DEFAULT_CHARSET
        PrintOptions.HeaderFont.Color = clWindowText
        PrintOptions.HeaderFont.Height = -11
        PrintOptions.HeaderFont.Name = 'MS Sans Serif'
        PrintOptions.HeaderFont.Style = []
        URLGlyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888880000800
          0088888808F8F0F8F80888808000000000808880F070888070F0888080000000
          0080880408F8F0F8F80880CCC0000400008874CCC2222C4788887CCCC22226C0
          88887CC822222CC088887C822224642088887C888422C220888877CF8CCCC227
          888887F8F8222208888888776888208888888887777778888888}
        Version = '2.5.3.4'
        OnItemDblClick = plannerDayItemDblClick
        ItemSource = WeekSource
      end
    end
    object tabMonthly: TTabSheet
      Caption = 'Monthly'
      ImageIndex = 2
      object plannerMonth: TDBPlanner
        Left = 0
        Top = 0
        Width = 929
        Height = 424
        Align = alClient
        AttachementGlyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888888700078888888888708880788888888808808808888888880808080
          8888888880808080888888888080808088888888808080808888888880808080
          8888888880808080888888888080808088888888808080808888888888808080
          8888888888808880888888888888000888888888888888888888}
        Balloon.AutoHideDelay = 10000
        Balloon.InitialDelay = 100
        Balloon.ReshowDelay = 100
        Caption.Title = 'TDBPlanner'
        Caption.Font.Charset = DEFAULT_CHARSET
        Caption.Font.Color = clWhite
        Caption.Font.Height = -13
        Caption.Font.Name = 'MS Sans Serif'
        Caption.Font.Style = [fsBold]
        DayNames.Strings = (
          'Sun'
          'Mon'
          'Tue'
          'Wed'
          'Thu'
          'Fri'
          'Sat')
        DefaultItem.CaptionFont.Charset = DEFAULT_CHARSET
        DefaultItem.CaptionFont.Color = clWindowText
        DefaultItem.CaptionFont.Height = -11
        DefaultItem.CaptionFont.Name = 'MS Sans Serif'
        DefaultItem.CaptionFont.Style = []
        DefaultItem.Cursor = -1
        DefaultItem.Font.Charset = DEFAULT_CHARSET
        DefaultItem.Font.Color = clWindowText
        DefaultItem.Font.Height = -11
        DefaultItem.Font.Name = 'MS Sans Serif'
        DefaultItem.Font.Style = []
        DefaultItem.ItemBegin = 16
        DefaultItem.ItemEnd = 17
        DefaultItem.ItemPos = 0
        DefaultItem.Name = 'PlannerItem0'
        DefaultItem.Shadow = True
        DeleteGlyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          0800000000000001000000000000000000000001000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A6000020400000206000002080000020A0000020C0000020E000004000000040
          20000040400000406000004080000040A0000040C0000040E000006000000060
          20000060400000606000006080000060A0000060C0000060E000008000000080
          20000080400000806000008080000080A0000080C0000080E00000A0000000A0
          200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
          200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
          200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
          20004000400040006000400080004000A0004000C0004000E000402000004020
          20004020400040206000402080004020A0004020C0004020E000404000004040
          20004040400040406000404080004040A0004040C0004040E000406000004060
          20004060400040606000406080004060A0004060C0004060E000408000004080
          20004080400040806000408080004080A0004080C0004080E00040A0000040A0
          200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
          200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
          200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
          20008000400080006000800080008000A0008000C0008000E000802000008020
          20008020400080206000802080008020A0008020C0008020E000804000008040
          20008040400080406000804080008040A0008040C0008040E000806000008060
          20008060400080606000806080008060A0008060C0008060E000808000008080
          20008080400080806000808080008080A0008080C0008080E00080A0000080A0
          200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
          200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
          200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
          2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
          2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
          2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
          2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
          2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
          2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
          2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00D9ED07070707
          0707070707070707ECD9EC5E5E5E5E5E5E5E5E5E5E5E5E5E5DED070D0E161616
          161616160E0E0E0E5E07070D161656561616161616160E0E5E07070D16AF075E
          56561657B7EF0E0E5E07070D56AFF6075F565FAFF6AF160E5E07070D565EAFF6
          075FEFF6AF17160E5E07070D5E5E5EAFF607F6AF161616165E07070D5E5E5E5E
          EFF60756161616165E07070D5E5E5FEFF6EFF6075E1616165E07070D5F5F07F6
          EF5EAFF6075616165E07070D6707F6075E5656AFF60716165E07070DA7AF075F
          5E5E5E5EAFAF56165E07070DA7A7675F5F5E5E5E5E5E56165E07EDAF0D0D0D0D
          0D0D0D0D0D0D0D0D5EECD9ED070707070707070707070707EDD1}
        Display.ActiveStart = 0
        Display.ActiveEnd = 400
        Display.DisplayEnd = 63
        Display.ColorNonActive = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Footer.CompletionFormat = '%d%%'
        Footer.Completion.Font.Charset = DEFAULT_CHARSET
        Footer.Completion.Font.Color = clWindowText
        Footer.Completion.Font.Height = -11
        Footer.Completion.Font.Name = 'Arial'
        Footer.Completion.Font.Style = []
        Footer.Font.Charset = DEFAULT_CHARSET
        Footer.Font.Color = clWindowText
        Footer.Font.Height = -11
        Footer.Font.Name = 'MS Sans Serif'
        Footer.Font.Style = []
        GridLeftCol = 0
        GridTopRow = 1
        Header.CustomGroups = <>
        Header.Height = 120
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.GroupFont.Charset = DEFAULT_CHARSET
        Header.GroupFont.Color = clWindowText
        Header.GroupFont.Height = -11
        Header.GroupFont.Name = 'MS Sans Serif'
        Header.GroupFont.Style = []
        HintPause = 7000
        HTMLOptions.CellFontStyle = []
        HTMLOptions.HeaderFontStyle = []
        HTMLOptions.SidebarFontStyle = []
        Items = <>
        Mode.Month = 1
        Mode.PeriodStartDay = 27
        Mode.PeriodStartMonth = 1
        Mode.PeriodStartYear = 2004
        Mode.PeriodEndDay = 15
        Mode.PeriodEndMonth = 3
        Mode.PeriodEndYear = 2004
        Mode.PlannerType = plWeek
        Mode.TimeLineStart = 38013
        Mode.TimeLineNVUBegin = 0
        Mode.TimeLineNVUEnd = 0
        Mode.Year = 2004
        ShowHint = True
        Sidebar.DateTimeFormat = 'mmm dd'
        Sidebar.Font.Charset = DEFAULT_CHARSET
        Sidebar.Font.Color = clWindowText
        Sidebar.Font.Height = -11
        Sidebar.Font.Name = 'Arial'
        Sidebar.Font.Style = []
        Sidebar.HourFontRatio = 1.8
        Sidebar.Position = spTop
        Sidebar.ShowDayName = False
        PositionProps = <>
        PrintOptions.FooterFont.Charset = DEFAULT_CHARSET
        PrintOptions.FooterFont.Color = clWindowText
        PrintOptions.FooterFont.Height = -11
        PrintOptions.FooterFont.Name = 'MS Sans Serif'
        PrintOptions.FooterFont.Style = []
        PrintOptions.HeaderFont.Charset = DEFAULT_CHARSET
        PrintOptions.HeaderFont.Color = clWindowText
        PrintOptions.HeaderFont.Height = -11
        PrintOptions.HeaderFont.Name = 'MS Sans Serif'
        PrintOptions.HeaderFont.Style = []
        URLGlyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888880000800
          0088888808F8F0F8F80888808000000000808880F070888070F0888080000000
          0080880408F8F0F8F80880CCC0000400008874CCC2222C4788887CCCC22226C0
          88887CC822222CC088887C822224642088887C888422C220888877CF8CCCC227
          888887F8F8222208888888776888208888888887777778888888}
        Version = '2.5.3.4'
        OnItemDblClick = plannerDayItemDblClick
        ItemSource = MonthSource
      end
    end
    object tabResources: TTabSheet
      Caption = 'Resources'
      ImageIndex = 3
      object PageControlRes: TPageControl
        Left = 0
        Top = 0
        Width = 929
        Height = 424
        ActivePage = tabResByRoom
        Align = alClient
        TabHeight = 23
        TabIndex = 0
        TabOrder = 0
        TabWidth = 463
        object tabResByRoom: TTabSheet
          Caption = 'Resources By Room'
          object DNMPanel3: TDNMPanel
            Left = 0
            Top = 0
            Width = 921
            Height = 391
            Align = alClient
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object Label2: TLabel
              Left = 13
              Top = 13
              Width = 33
              Height = 15
              Caption = 'Room'
            end
            object grdResByRoom: TAdvStringGrid
              Left = 8
              Top = 40
              Width = 897
              Height = 337
              Cursor = crDefault
              ColCount = 6
              DefaultColWidth = 80
              DefaultRowHeight = 21
              FixedColor = 12054011
              FixedCols = 2
              RowCount = 2
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected]
              ParentFont = False
              ScrollBars = ssBoth
              TabOrder = 0
              ActiveCellFont.Charset = DEFAULT_CHARSET
              ActiveCellFont.Color = clWindowText
              ActiveCellFont.Height = -11
              ActiveCellFont.Name = 'MS Sans Serif'
              ActiveCellFont.Style = [fsBold]
              AutoNumAlign = True
              CellNode.ShowTree = False
              CellNode.TreeColor = clSilver
              ColumnHeaders.Strings = (
                'Booking'
                'Resource'
                'Quantity'
                'From'
                'To'
                'Function')
              ControlLook.ControlStyle = csClassic
              EnhRowColMove = False
              Filter = <>
              FixedColWidth = 150
              FixedRowHeight = 30
              FixedRowAlways = True
              FixedFont.Charset = ANSI_CHARSET
              FixedFont.Color = clWindowText
              FixedFont.Height = -12
              FixedFont.Name = 'Arial'
              FixedFont.Style = [fsBold]
              FloatFormat = '%.2f'
              PrintSettings.DateFormat = 'dd/mm/yyyy'
              PrintSettings.Font.Charset = DEFAULT_CHARSET
              PrintSettings.Font.Color = clWindowText
              PrintSettings.Font.Height = -11
              PrintSettings.Font.Name = 'MS Sans Serif'
              PrintSettings.Font.Style = []
              PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
              PrintSettings.FixedFont.Color = clWindowText
              PrintSettings.FixedFont.Height = -11
              PrintSettings.FixedFont.Name = 'MS Sans Serif'
              PrintSettings.FixedFont.Style = []
              PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
              PrintSettings.HeaderFont.Color = clWindowText
              PrintSettings.HeaderFont.Height = -11
              PrintSettings.HeaderFont.Name = 'MS Sans Serif'
              PrintSettings.HeaderFont.Style = []
              PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
              PrintSettings.FooterFont.Color = clWindowText
              PrintSettings.FooterFont.Height = -11
              PrintSettings.FooterFont.Name = 'MS Sans Serif'
              PrintSettings.FooterFont.Style = []
              PrintSettings.Borders = pbNoborder
              PrintSettings.Centered = False
              PrintSettings.PageNumSep = '/'
              ScrollWidth = 16
              SearchFooter.FindNextCaption = 'Find next'
              SearchFooter.FindPrevCaption = 'Find previous'
              SearchFooter.Font.Charset = DEFAULT_CHARSET
              SearchFooter.Font.Color = clWindowText
              SearchFooter.Font.Height = -11
              SearchFooter.Font.Name = 'MS Sans Serif'
              SearchFooter.Font.Style = []
              SearchFooter.HighLightCaption = 'Highlight'
              SearchFooter.HintClose = 'Close'
              SearchFooter.HintFindNext = 'Find next occurence'
              SearchFooter.HintFindPrev = 'Find previous occurence'
              SearchFooter.HintHighlight = 'Highlight occurences'
              SearchFooter.MatchCaseCaption = 'Match case'
              SelectionColor = clHighlight
              SelectionTextColor = clHighlightText
              ShowSelection = False
              VAlignment = vtaCenter
              Version = '3.5.2.2'
              WordWrap = False
              ColWidths = (
                150
                150
                80
                80
                80
                80)
              RowHeights = (
                30
                21)
              object lblNone: TLabel
                Left = 104
                Top = 120
                Width = 690
                Height = 72
                Caption = 'No Resources Allocated'
                Font.Charset = ANSI_CHARSET
                Font.Color = clOlive
                Font.Height = -64
                Font.Name = 'Arial'
                Font.Style = []
                ParentColor = False
                ParentFont = False
              end
            end
            object cboRoom: TwwDBLookupCombo
              Left = 56
              Top = 9
              Width = 137
              Height = 23
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'Name'#9'30'#9'Room'#9'F')
              LookupTable = qryFuncRooms
              LookupField = 'Name'
              TabOrder = 1
              AutoDropDown = False
              ShowButton = True
              AllowClearKey = False
              OnCloseUp = cboRoomCloseUp
            end
          end
        end
        object tabResByHr: TTabSheet
          Caption = 'Resources By Hour'
          ImageIndex = 1
          object DNMPanel2: TDNMPanel
            Left = 0
            Top = 0
            Width = 921
            Height = 391
            Align = alClient
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object Label1: TLabel
              Left = 9
              Top = 14
              Width = 55
              Height = 15
              Caption = 'Resource'
            end
            object lblResAvailableLabel: TLabel
              Left = 225
              Top = 13
              Width = 143
              Height = 15
              Caption = 'Total Resource Available:'
              Transparent = True
              Visible = False
            end
            object lblResAvailable: TLabel
              Left = 374
              Top = 12
              Width = 86
              Height = 15
              Caption = 'lblResAvailable'
              Transparent = True
              Visible = False
            end
            object grdRes: TAdvStringGrid
              Left = 8
              Top = 40
              Width = 897
              Height = 329
              Cursor = crDefault
              ColCount = 25
              DefaultColWidth = 40
              DefaultRowHeight = 21
              FixedColor = 12054011
              RowCount = 2
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected]
              ParentFont = False
              ScrollBars = ssBoth
              TabOrder = 0
              ActiveCellFont.Charset = DEFAULT_CHARSET
              ActiveCellFont.Color = clWindowText
              ActiveCellFont.Height = -11
              ActiveCellFont.Name = 'MS Sans Serif'
              ActiveCellFont.Style = [fsBold]
              AutoNumAlign = True
              CellNode.ShowTree = False
              CellNode.TreeColor = clSilver
              ControlLook.ControlStyle = csClassic
              EnhRowColMove = False
              Filter = <>
              FixedFooters = 1
              FixedColWidth = 120
              FixedRowHeight = 30
              FixedRowAlways = True
              FixedFont.Charset = ANSI_CHARSET
              FixedFont.Color = clWindowText
              FixedFont.Height = -12
              FixedFont.Name = 'Arial'
              FixedFont.Style = [fsBold]
              FloatFormat = '%.2f'
              PrintSettings.DateFormat = 'dd/mm/yyyy'
              PrintSettings.Font.Charset = DEFAULT_CHARSET
              PrintSettings.Font.Color = clWindowText
              PrintSettings.Font.Height = -11
              PrintSettings.Font.Name = 'MS Sans Serif'
              PrintSettings.Font.Style = []
              PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
              PrintSettings.FixedFont.Color = clWindowText
              PrintSettings.FixedFont.Height = -11
              PrintSettings.FixedFont.Name = 'MS Sans Serif'
              PrintSettings.FixedFont.Style = []
              PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
              PrintSettings.HeaderFont.Color = clWindowText
              PrintSettings.HeaderFont.Height = -11
              PrintSettings.HeaderFont.Name = 'MS Sans Serif'
              PrintSettings.HeaderFont.Style = []
              PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
              PrintSettings.FooterFont.Color = clWindowText
              PrintSettings.FooterFont.Height = -11
              PrintSettings.FooterFont.Name = 'MS Sans Serif'
              PrintSettings.FooterFont.Style = []
              PrintSettings.Borders = pbNoborder
              PrintSettings.Centered = False
              PrintSettings.PageNumSep = '/'
              ScrollWidth = 16
              SearchFooter.FindNextCaption = 'Find next'
              SearchFooter.FindPrevCaption = 'Find previous'
              SearchFooter.Font.Charset = DEFAULT_CHARSET
              SearchFooter.Font.Color = clWindowText
              SearchFooter.Font.Height = -11
              SearchFooter.Font.Name = 'MS Sans Serif'
              SearchFooter.Font.Style = []
              SearchFooter.HighLightCaption = 'Highlight'
              SearchFooter.HintClose = 'Close'
              SearchFooter.HintFindNext = 'Find next occurence'
              SearchFooter.HintFindPrev = 'Find previous occurence'
              SearchFooter.HintHighlight = 'Highlight occurences'
              SearchFooter.MatchCaseCaption = 'Match case'
              SelectionColor = clHighlight
              SelectionTextColor = clHighlightText
              ShowSelection = False
              VAlignment = vtaCenter
              Version = '3.5.2.2'
              WordWrap = False
              ColWidths = (
                120
                40
                40
                40
                40
                40
                40
                40
                40
                40
                40
                40
                40
                40
                40
                40
                40
                40
                40
                40
                40
                40
                40
                40
                40)
              RowHeights = (
                30
                21)
            end
            object cboFuncRes: TwwDBLookupCombo
              Left = 68
              Top = 10
              Width = 137
              Height = 23
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'ResourceName'#9'30'#9'Resource'#9'F')
              LookupTable = qryFuncRes
              LookupField = 'ResourceName'
              TabOrder = 1
              AutoDropDown = False
              ShowButton = True
              AllowClearKey = False
              OnCloseUp = cboFuncResCloseUp
            end
          end
        end
      end
    end
  end
  object btnSave: TDNMSpeedButton [10]
    Left = 18
    Top = 524
    Width = 87
    Height = 27
    Anchors = [akRight, akBottom]
    Caption = 'Save'
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
    ModalResult = 1
    NumGlyphs = 2
    TabOrder = 1
    Visible = False
    OnClick = btnSaveClick
  end
  object pnlTitle: TDNMPanel [11]
    Left = 270
    Top = 5
    Width = 426
    Height = 41
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 422
      Height = 37
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      FromColor = clBtnFace
      ToColor = clWhite
      FromColorMirror = clWhite
      ToColorMirror = clBtnFace
      Steps = 10
      Direction = False
      Version = '1.2.1.1'
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 422
        Height = 37
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Function Bookings Calendar'
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
  inherited ApplicationEvents1: TApplicationEvents
    Left = 248
    Top = 0
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 184
    Top = 0
  end
  object DaySource: TDBDaySource
    Active = False
    OnResetFilter = DaySourceResetFilter
    AutoIncKey = False
    DataSource = dsDaySource
    ResourceMap = <>
    StartTimeField = 'Start'
    EndTimeField = 'End'
    KeyField = 'RoomAllocationID'
    ReadOnly = False
    ResourceField = 'RoomID'
    UpdateByQuery = False
    OnFieldsToItem = DaySourceFieldsToItem
    OnItemToFields = DaySourceItemToFields
    OnResourceToPosition = DaySourceResourceToPosition
    OnPositionToResource = DaySourcePositionToResource
    DateFormat = 'mm/dd/yyyy'
    Mode = dmMultiResDay
    NumberOfResources = 10
    Left = 216
    Top = 480
  end
  object qryFuncRoomAllocations: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT RoomAllocationID, tblfuncroomallocation.FuncBookingID, '
      'tblfuncroomallocation.RoomID, '
      'RoomAllocDate,  Start, End, StartDummy, EndDummy,  ResetTime '
      'FROM tblfuncroomallocation'
      'INNER JOIN tblfuncbookings'
      'WHERE Cancellation <> '#39'T'#39)
    Left = 328
    Top = 370
  end
  object dsDaySource: TDataSource
    DataSet = qryFuncRoomAllocations
    Left = 224
    Top = 420
  end
  object qryFuncRooms: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT RoomID, Name, ParentRoomID, ResetTime '
      'FROM tblFuncRooms')
    Left = 456
    Top = 65535
  end
  object qryFuncBookings: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT B.FuncBookingID, B.ClientID, C.Company, B.FuncTypeID, '
      
        'T.FuncTypeName, B.BookingDescription, B.StartBooking, B.EndBooki' +
        'ng'
      'FROM tblfuncbookings as B'
      'LEFT JOIN tblclients as C USING (ClientID)'
      'LEFT JOIN tblfunctypes as T ON B.FuncTypeID = T.FuncTypeID')
    Left = 544
    Top = 65535
  end
  object dsWeekSource: TDataSource
    DataSet = qryFuncRoomAllocations
    Left = 328
    Top = 418
  end
  object WeekSource: TDBHalfDayPeriodSource
    Active = False
    OnResetFilter = WeekSourceResetFilter
    AutoIncKey = False
    DataSource = dsWeekSource
    ResourceMap = <>
    StartTimeField = 'Start'
    EndTimeField = 'End'
    KeyField = 'RoomAllocationID'
    ReadOnly = False
    ResourceField = 'RoomID'
    UpdateByQuery = False
    OnFieldsToItem = DaySourceFieldsToItem
    OnItemToFields = DaySourceItemToFields
    OnResourceToPosition = DaySourceResourceToPosition
    OnPositionToResource = DaySourcePositionToResource
    StartDate = 38010
    EndDate = 38024
    Left = 328
    Top = 480
  end
  object dsMonthSource: TDataSource
    DataSet = qryFuncRoomAllocations
    Left = 424
    Top = 418
  end
  object MonthSource: TDBWeekSource
    Active = False
    OnResetFilter = MonthSourceResetFilter
    AutoIncKey = False
    DataSource = dsMonthSource
    ResourceMap = <>
    StartTimeField = 'Start'
    EndTimeField = 'End'
    KeyField = 'RoomAllocationID'
    ReadOnly = False
    ResourceField = 'RoomID'
    UpdateByQuery = False
    OnFieldsToItem = DaySourceFieldsToItem
    OnItemToFields = DaySourceItemToFields
    OnResourceToPosition = DaySourceResourceToPosition
    OnPositionToResource = DaySourcePositionToResource
    Month = 1
    Year = 2004
    WeekStart = 0
    Weeks = 9
    Left = 424
    Top = 480
  end
  object qryFuncRes: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT FuncResourceID, ResourceName, Qty FROM tblFuncResources '
      'WHERE Active = '#39'T'#39)
    Left = 496
    Top = 96
  end
  object qryFuncRoomPositions: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT RoomID, Name, ParentRoomID, ResetTime '
      'FROM tblFuncRooms')
    Left = 329
    Top = 227
  end
end
