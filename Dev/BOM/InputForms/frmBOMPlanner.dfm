inherited fmBOMPlanner: TfmBOMPlanner
  Left = 488
  Top = 133
  HelpContext = 1422002
  Caption = 'Production Scheduler'
  ClientHeight = 531
  ExplicitLeft = 488
  ExplicitTop = 133
  ExplicitHeight = 570
  DesignSize = (
    949
    531)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 466
    ExplicitTop = 482
  end
  inherited imgGridWatermark: TImage
    Left = 457
    Top = 155
    ExplicitLeft = 457
    ExplicitTop = 155
  end
  object Horizontal1: TSplitter [5]
    Left = 0
    Top = 224
    Width = 949
    Height = 3
    Cursor = crVSplit
    Hint = 'Hold and Drag to Resize'
    HelpContext = 1422003
    Align = alTop
  end
  object lblMsg: TLabel [6]
    Left = 0
    Top = 466
    Width = 949
    Height = 15
    HelpContext = 1422004
    Align = alBottom
    Alignment = taCenter
    Caption = 'lblMsg'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
    WordWrap = True
    ExplicitWidth = 37
  end
  object pnlFooter: TDNMPanel [7]
    Left = 0
    Top = 481
    Width = 949
    Height = 50
    HelpContext = 1422014
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      949
      50)
    object btnOptions: TDNMSpeedButton
      Left = 428
      Top = 10
      Width = 93
      Height = 29
      HelpContext = 1422015
      Anchors = []
      Caption = 'Options'
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
      ModalResult = 2
      ParentFont = False
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = btnOptionsClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 625
      Top = 10
      Width = 93
      Height = 29
      HelpContext = 1422016
      Action = actCancel
      Anchors = []
      Cancel = True
      Caption = 'Close'
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
      AutoDisableParentOnclick = True
    end
    object cmdClose: TDNMSpeedButton
      Left = 231
      Top = 10
      Width = 93
      Height = 29
      HelpContext = 1422017
      Action = actSave
      Anchors = []
      Caption = 'Save'
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
      TabOrder = 2
      AutoDisableParentOnclick = True
    end
    object btnAutoSchedule: TDNMSpeedButton
      Left = 20
      Top = 11
      Width = 110
      Height = 27
      HelpContext = 1422018
      Action = actAutoSchedule
      Anchors = [akLeft, akBottom]
      Caption = 'Auto Schedule'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      TabOrder = 3
      AutoDisableParentOnclick = True
    end
  end
  object Planners: TPageControl [8]
    Left = 0
    Top = 227
    Width = 949
    Height = 239
    HelpContext = 1422019
    ActivePage = TabWeek
    Align = alClient
    TabOrder = 2
    object TabDAy: TTabSheet
      HelpContext = 1422020
      Caption = 'TabDAy'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlDay: TDNMPanel
        Left = 0
        Top = 0
        Width = 941
        Height = 209
        HelpContext = 1422021
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object plannerDay: TDBPlanner
          Left = 1
          Top = 1
          Width = 939
          Height = 207
          HelpContext = 1422022
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
          AutoThemeAdapt = True
          Caption.Title = 'TDBPlanner'
          Caption.Font.Charset = DEFAULT_CHARSET
          Caption.Font.Color = clWhite
          Caption.Font.Height = -13
          Caption.Font.Name = 'MS Sans Serif'
          Caption.Font.Style = [fsBold]
          Caption.BackgroundSteps = 32
          Caption.Visible = False
          DayNames.Strings = (
            'Sun'
            'Mon'
            'Tue'
            'Wed'
            'Thu'
            'Fri'
            'Sat')
          DefaultItem.CaptionBkgTo = clSilver
          DefaultItem.CaptionFont.Charset = DEFAULT_CHARSET
          DefaultItem.CaptionFont.Color = clWindowText
          DefaultItem.CaptionFont.Height = -11
          DefaultItem.CaptionFont.Name = 'MS Sans Serif'
          DefaultItem.CaptionFont.Style = []
          DefaultItem.CaptionType = ctText
          DefaultItem.ColorTo = 16250871
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
          DefaultItem.Shape = psRounded
          DefaultItem.ShowDeleteButton = True
          DefaultItem.SelectColor = clWhite
          DefaultItem.SelectColorTo = clInfoBk
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
          Display.DisplayScale = 28
          Display.ColorNonActive = clWhite
          Flat = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Footer.Captions.Strings = (
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            '')
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
          GridPopup = MnuItemPopup
          GridLeftCol = 0
          GridTopRow = 1
          Header.AllowResize = True
          Header.AllowPositionResize = True
          Header.AutoSize = True
          Header.Captions.Strings = (
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            '')
          Header.CustomGroups = <>
          Header.Height = 102
          Header.Font.Charset = ANSI_CHARSET
          Header.Font.Color = clBlack
          Header.Font.Height = -12
          Header.Font.Name = 'Arial'
          Header.Font.Style = [fsBold]
          Header.GroupFont.Charset = DEFAULT_CHARSET
          Header.GroupFont.Color = clWindowText
          Header.GroupFont.Height = -11
          Header.GroupFont.Name = 'MS Sans Serif'
          Header.GroupFont.Style = []
          Header.ItemHeight = 16
          Header.TextHeight = 100
          HintPause = 3000
          HTMLOptions.CellFontStyle = []
          HTMLOptions.HeaderFontStyle = []
          HTMLOptions.SidebarFontStyle = []
          InActiveDays.Sat = False
          InActiveDays.Sun = False
          ItemPopup = MnuItemPopup
          Items = <>
          Mode.Month = 8
          Mode.PeriodStartDay = 28
          Mode.PeriodStartMonth = 7
          Mode.PeriodStartYear = 2003
          Mode.PeriodEndDay = 14
          Mode.PeriodEndMonth = 9
          Mode.PeriodEndYear = 2003
          Mode.TimeLineStart = 38009.000000000000000000
          Mode.TimeLineNVUBegin = 0
          Mode.TimeLineNVUEnd = 0
          Mode.Year = 2003
          MultiSelect = True
          ShowHint = True
          Sidebar.AMPMPos = apNone
          Sidebar.DateTimeFormat = 'am/pm'
          Sidebar.Font.Charset = DEFAULT_CHARSET
          Sidebar.Font.Color = clBlack
          Sidebar.Font.Height = -12
          Sidebar.Font.Name = 'Arial'
          Sidebar.Font.Style = [fsBold]
          Sidebar.HourFontRatio = 1.700000000000000000
          Sidebar.OccupiedTo = clWhite
          Sidebar.Position = spTop
          Sidebar.TimeIndicator = True
          Positions = 20
          PositionProps = <>
          PositionWidth = 72
          PrintOptions.LineWidth = 0
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
          ShowDesignHelper = False
          URLGlyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888880000800
            0088888808F8F0F8F80888808000000000808880F070888070F0888080000000
            0080880408F8F0F8F80880CCC0000400008874CCC2222C4788887CCCC22226C0
            88887CC822222CC088887C822224642088887C888422C220888877CF8CCCC227
            888887F8F8222208888888776888208888888887777778888888}
          Version = '2.5.8.4'
          OnItemDblClick = plannerDayItemDblClick
          OnItemMoving = OnPlannerItemMoving
          OnItemHint = plannerDayItemHint
          ItemSource = DaySource
        end
      end
    end
    object TabWeek: TTabSheet
      HelpContext = 1422023
      Caption = 'TabWeek'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnnlWeek: TDNMPanel
        Left = 0
        Top = 0
        Width = 941
        Height = 209
        HelpContext = 1422024
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object PlannerWeek: TDBPlanner
          Left = 1
          Top = 1
          Width = 939
          Height = 207
          HelpContext = 1422025
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
          AutoThemeAdapt = True
          Caption.Title = 'TDBPlanner'
          Caption.Font.Charset = DEFAULT_CHARSET
          Caption.Font.Color = clWhite
          Caption.Font.Height = -13
          Caption.Font.Name = 'MS Sans Serif'
          Caption.Font.Style = [fsBold]
          Caption.BackgroundSteps = 32
          Caption.Visible = False
          DayNames.Strings = (
            'Sun'
            'Mon'
            'Tue'
            'Wed'
            'Thu'
            'Fri'
            'Sat')
          DefaultItem.CaptionBkgTo = clSilver
          DefaultItem.CaptionFont.Charset = DEFAULT_CHARSET
          DefaultItem.CaptionFont.Color = clWindowText
          DefaultItem.CaptionFont.Height = -11
          DefaultItem.CaptionFont.Name = 'MS Sans Serif'
          DefaultItem.CaptionFont.Style = []
          DefaultItem.ColorTo = 16250871
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
          DefaultItem.ReadOnly = True
          DefaultItem.Shape = psRounded
          DefaultItem.ShowDeleteButton = True
          DefaultItem.SelectColor = clWhite
          DefaultItem.SelectColorTo = clInfoBk
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
          Display.DisplayEnd = 191
          Display.DisplayScale = 12
          Display.DisplayText = 2
          Display.ColorNonActive = clWhite
          Flat = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Footer.Captions.Strings = (
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            '')
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
          GridPopup = MnuItemPopup
          GridLeftCol = 0
          GridTopRow = 1
          Header.Captions.Strings = (
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            '')
          Header.CustomGroups = <>
          Header.Height = 100
          Header.Font.Charset = ANSI_CHARSET
          Header.Font.Color = clBlack
          Header.Font.Height = -12
          Header.Font.Name = 'Arial'
          Header.Font.Style = [fsBold]
          Header.GroupFont.Charset = DEFAULT_CHARSET
          Header.GroupFont.Color = clWindowText
          Header.GroupFont.Height = -11
          Header.GroupFont.Name = 'MS Sans Serif'
          Header.GroupFont.Style = []
          Header.ItemHeight = 16
          Header.TextHeight = 100
          HTMLOptions.CellFontStyle = []
          HTMLOptions.HeaderFontStyle = []
          HTMLOptions.SidebarFontStyle = []
          InActiveDays.Sat = False
          InActiveDays.Sun = False
          ItemPopup = MnuItemPopup
          Items = <>
          Mode.DateTimeFormat = 'dd/mm/yyyy'
          Mode.Month = 8
          Mode.PeriodStartDay = 28
          Mode.PeriodStartMonth = 7
          Mode.PeriodStartYear = 2003
          Mode.PeriodEndDay = 14
          Mode.PeriodEndMonth = 9
          Mode.PeriodEndYear = 2003
          Mode.PlannerType = plTimeLine
          Mode.TimeLineStart = 42590.000000000000000000
          Mode.TimeLineNVUBegin = 0
          Mode.TimeLineNVUEnd = 0
          Mode.WeekStart = 2
          Mode.Year = 2003
          MultiSelect = True
          ShadowColor = clSilver
          Sidebar.AMPMPos = apNone
          Sidebar.DateTimeFormat = 'dd/mm/yyyy'
          Sidebar.Font.Charset = DEFAULT_CHARSET
          Sidebar.Font.Color = clBlack
          Sidebar.Font.Height = -12
          Sidebar.Font.Name = 'Arial'
          Sidebar.Font.Style = [fsBold]
          Sidebar.HourFontRatio = 1.700000000000000000
          Sidebar.OccupiedTo = clWhite
          Sidebar.Position = spTop
          Sidebar.TimeIndicator = True
          Positions = 20
          PositionProps = <>
          PositionWidth = 72
          PrintOptions.LineWidth = 0
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
          ShowDesignHelper = False
          URLGlyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888880000800
            0088888808F8F0F8F80888808000000000808880F070888070F0888080000000
            0080880408F8F0F8F80880CCC0000400008874CCC2222C4788887CCCC22226C0
            88887CC822222CC088887C822224642088887C888422C220888877CF8CCCC227
            888887F8F8222208888888776888208888888887777778888888}
          Version = '2.5.8.4'
          OnItemDblClick = plannerDayItemDblClick
          OnItemMoving = OnPlannerItemMoving
          OnItemSelect = PlannerWeekItemSelect
          ItemSource = TimeLineSource
        end
      end
    end
    object TabMonth: TTabSheet
      HelpContext = 1422026
      Caption = 'TabMonth'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlMonth: TDNMPanel
        Left = 0
        Top = 0
        Width = 941
        Height = 209
        HelpContext = 1422027
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object plannerMonth: TDBPlanner
          Left = 1
          Top = 1
          Width = 939
          Height = 207
          HelpContext = 1422028
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
          AutoThemeAdapt = True
          Caption.Title = 'TDBPlanner'
          Caption.Font.Charset = DEFAULT_CHARSET
          Caption.Font.Color = clWhite
          Caption.Font.Height = -13
          Caption.Font.Name = 'MS Sans Serif'
          Caption.Font.Style = [fsBold]
          Caption.BackgroundSteps = 32
          Caption.Visible = False
          DayNames.Strings = (
            'Sun'
            'Mon'
            'Tue'
            'Wed'
            'Thu'
            'Fri'
            'Sat')
          DefaultItem.CaptionAlign = taCenter
          DefaultItem.CaptionBkgTo = clSilver
          DefaultItem.CaptionFont.Charset = ANSI_CHARSET
          DefaultItem.CaptionFont.Color = clWindowText
          DefaultItem.CaptionFont.Height = -7
          DefaultItem.CaptionFont.Name = 'Small Fonts'
          DefaultItem.CaptionFont.Style = []
          DefaultItem.ColorTo = 16250871
          DefaultItem.Cursor = -1
          DefaultItem.Font.Charset = ANSI_CHARSET
          DefaultItem.Font.Color = clWindowText
          DefaultItem.Font.Height = -7
          DefaultItem.Font.Name = 'Small Fonts'
          DefaultItem.Font.Style = []
          DefaultItem.ItemBegin = 16
          DefaultItem.ItemEnd = 17
          DefaultItem.ItemPos = 0
          DefaultItem.Name = 'PlannerItem0'
          DefaultItem.ReadOnly = True
          DefaultItem.Shape = psRounded
          DefaultItem.ShowDeleteButton = True
          DefaultItem.SelectColor = clWhite
          DefaultItem.SelectColorTo = clInfoBk
          DefaultItem.SelectFontColor = clBlack
          DefaultItem.Shadow = False
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
          Display.ActiveEnd = 20
          Display.DisplayEnd = 63
          Display.DisplayScale = 38
          Display.ColorNonActive = clSilver
          Display.ColorCurrent = 14145535
          Flat = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Footer.Captions.Strings = (
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            '')
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
          GridPopup = MnuItemPopup
          GridLeftCol = 0
          GridTopRow = 1
          Header.Captions.Strings = (
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            '')
          Header.CustomGroups = <>
          Header.Height = 100
          Header.Font.Charset = ANSI_CHARSET
          Header.Font.Color = clBlack
          Header.Font.Height = -12
          Header.Font.Name = 'Arial'
          Header.Font.Style = [fsBold]
          Header.GroupFont.Charset = DEFAULT_CHARSET
          Header.GroupFont.Color = clWindowText
          Header.GroupFont.Height = -11
          Header.GroupFont.Name = 'MS Sans Serif'
          Header.GroupFont.Style = []
          Header.ItemHeight = 16
          Header.TextHeight = 100
          HTMLOptions.CellFontStyle = []
          HTMLOptions.HeaderFontStyle = []
          HTMLOptions.SidebarFontStyle = []
          ItemPopup = MnuItemPopup
          Items = <>
          Mode.Month = 8
          Mode.PeriodStartDay = 28
          Mode.PeriodStartMonth = 7
          Mode.PeriodStartYear = 2003
          Mode.PeriodEndDay = 14
          Mode.PeriodEndMonth = 9
          Mode.PeriodEndYear = 2003
          Mode.PlannerType = plWeek
          Mode.TimeLineStart = 38009.000000000000000000
          Mode.TimeLineNVUBegin = 0
          Mode.TimeLineNVUEnd = 0
          Mode.Year = 2003
          ShadowColor = clSilver
          Sidebar.AMPMPos = apNone
          Sidebar.DateTimeFormat = 'dd/mm/yyyy'
          Sidebar.Font.Charset = DEFAULT_CHARSET
          Sidebar.Font.Color = clBlack
          Sidebar.Font.Height = -12
          Sidebar.Font.Name = 'Arial'
          Sidebar.Font.Style = [fsBold]
          Sidebar.HourFontRatio = 1.800000000000000000
          Sidebar.OccupiedTo = clWhite
          Sidebar.Position = spTop
          Sidebar.TimeIndicator = True
          Sidebar.Width = 70
          Positions = 20
          PositionProps = <>
          PositionWidth = 72
          PrintOptions.LineWidth = 0
          PrintOptions.FooterFont.Charset = DEFAULT_CHARSET
          PrintOptions.FooterFont.Color = clWindowText
          PrintOptions.FooterFont.Height = -11
          PrintOptions.FooterFont.Name = 'MS Sans Serif'
          PrintOptions.FooterFont.Style = []
          PrintOptions.HeaderAlignment = taCenter
          PrintOptions.HeaderFont.Charset = ANSI_CHARSET
          PrintOptions.HeaderFont.Color = clWindowText
          PrintOptions.HeaderFont.Height = -21
          PrintOptions.HeaderFont.Name = 'Arial'
          PrintOptions.HeaderFont.Style = [fsBold]
          PrintOptions.HeaderSize = 500
          PrintOptions.JobName = 'Roster'
          ScrollSmooth = True
          ScrollSynch = True
          URLGlyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888880000800
            0088888808F8F0F8F80888808000000000808880F070888070F0888080000000
            0080880408F8F0F8F80880CCC0000400008874CCC2222C4788887CCCC22226C0
            88887CC822222CC088887C822224642088887C888422C220888877CF8CCCC227
            888887F8F8222208888888776888208888888887777778888888}
          Version = '2.5.8.4'
          OnItemDblClick = plannerDayItemDblClick
          OnItemMoving = OnPlannerItemMoving
          ItemSource = MonthSource
        end
      end
    end
    object tabResDays: TTabSheet
      HelpContext = 1422029
      Caption = 'tabResDays'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlResDAys: TDNMPanel
        Left = 0
        Top = 0
        Width = 941
        Height = 209
        HelpContext = 1422030
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object plannerResDay: TDBPlanner
          Left = 1
          Top = 1
          Width = 939
          Height = 207
          HelpContext = 1422031
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
          AutoThemeAdapt = True
          Caption.Title = 'TDBPlanner'
          Caption.Font.Charset = DEFAULT_CHARSET
          Caption.Font.Color = clWhite
          Caption.Font.Height = -13
          Caption.Font.Name = 'MS Sans Serif'
          Caption.Font.Style = [fsBold]
          Caption.BackgroundSteps = 32
          Caption.Visible = False
          DayNames.Strings = (
            'Sun'
            'Mon'
            'Tue'
            'Wed'
            'Thu'
            'Fri'
            'Sat')
          DefaultItem.CaptionBkgTo = clSilver
          DefaultItem.CaptionFont.Charset = DEFAULT_CHARSET
          DefaultItem.CaptionFont.Color = clWindowText
          DefaultItem.CaptionFont.Height = -11
          DefaultItem.CaptionFont.Name = 'MS Sans Serif'
          DefaultItem.CaptionFont.Style = []
          DefaultItem.CaptionType = ctText
          DefaultItem.ColorTo = 16250871
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
          DefaultItem.Shape = psRounded
          DefaultItem.ShowDeleteButton = True
          DefaultItem.SelectColor = clWhite
          DefaultItem.SelectColorTo = clInfoBk
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
          Display.DisplayScale = 28
          Display.ColorNonActive = clWhite
          Flat = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Footer.Captions.Strings = (
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            '')
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
          GridPopup = MnuItemPopup
          GridLeftCol = 0
          GridTopRow = 1
          Header.AllowResize = True
          Header.AllowPositionResize = True
          Header.AutoSize = True
          Header.Captions.Strings = (
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            '')
          Header.CustomGroups = <>
          Header.Height = 102
          Header.Font.Charset = ANSI_CHARSET
          Header.Font.Color = clBlack
          Header.Font.Height = -12
          Header.Font.Name = 'Arial'
          Header.Font.Style = [fsBold]
          Header.GroupFont.Charset = DEFAULT_CHARSET
          Header.GroupFont.Color = clWindowText
          Header.GroupFont.Height = -11
          Header.GroupFont.Name = 'MS Sans Serif'
          Header.GroupFont.Style = []
          Header.ItemHeight = 16
          Header.TextHeight = 100
          HTMLOptions.CellFontStyle = []
          HTMLOptions.HeaderFontStyle = []
          HTMLOptions.SidebarFontStyle = []
          InActiveDays.Sat = False
          InActiveDays.Sun = False
          ItemPopup = MnuItemPopup
          Items = <>
          Mode.Month = 8
          Mode.PeriodStartDay = 28
          Mode.PeriodStartMonth = 7
          Mode.PeriodStartYear = 2003
          Mode.PeriodEndDay = 14
          Mode.PeriodEndMonth = 9
          Mode.PeriodEndYear = 2003
          Mode.TimeLineStart = 38009.000000000000000000
          Mode.TimeLineNVUBegin = 0
          Mode.TimeLineNVUEnd = 0
          Mode.Year = 2003
          MultiSelect = True
          Sidebar.AMPMPos = apNone
          Sidebar.DateTimeFormat = 'am/pm'
          Sidebar.Font.Charset = DEFAULT_CHARSET
          Sidebar.Font.Color = clBlack
          Sidebar.Font.Height = -12
          Sidebar.Font.Name = 'Arial'
          Sidebar.Font.Style = [fsBold]
          Sidebar.HourFontRatio = 1.700000000000000000
          Sidebar.OccupiedTo = clWhite
          Sidebar.Position = spTop
          Sidebar.TimeIndicator = True
          Positions = 20
          PositionProps = <>
          PositionWidth = 72
          PrintOptions.LineWidth = 0
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
          ShowDesignHelper = False
          URLGlyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888880000800
            0088888808F8F0F8F80888808000000000808880F070888070F0888080000000
            0080880408F8F0F8F80880CCC0000400008874CCC2222C4788887CCCC22226C0
            88887CC822222CC088887C822224642088887C888422C220888877CF8CCCC227
            888887F8F8222208888888776888208888888887777778888888}
          Version = '2.5.8.4'
          OnItemDblClick = plannerDayItemDblClick
          OnItemMoving = OnPlannerItemMoving
          ItemSource = resDaySource
        end
      end
    end
    object TabResWeek: TTabSheet
      HelpContext = 1422032
      Caption = 'TabResWeek'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlResWeek: TDNMPanel
        Left = 0
        Top = 0
        Width = 941
        Height = 209
        HelpContext = 1422033
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object PlannerREsWeek: TDBPlanner
          Left = 1
          Top = 1
          Width = 939
          Height = 207
          HelpContext = 1422034
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
          AutoThemeAdapt = True
          Caption.Title = 'TDBPlanner'
          Caption.Font.Charset = DEFAULT_CHARSET
          Caption.Font.Color = clWhite
          Caption.Font.Height = -13
          Caption.Font.Name = 'MS Sans Serif'
          Caption.Font.Style = [fsBold]
          Caption.BackgroundSteps = 32
          Caption.Visible = False
          DayNames.Strings = (
            'Sun'
            'Mon'
            'Tue'
            'Wed'
            'Thu'
            'Fri'
            'Sat')
          DefaultItem.CaptionBkgTo = clSilver
          DefaultItem.CaptionFont.Charset = DEFAULT_CHARSET
          DefaultItem.CaptionFont.Color = clWindowText
          DefaultItem.CaptionFont.Height = -11
          DefaultItem.CaptionFont.Name = 'MS Sans Serif'
          DefaultItem.CaptionFont.Style = []
          DefaultItem.ColorTo = 16250871
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
          DefaultItem.ReadOnly = True
          DefaultItem.Shape = psRounded
          DefaultItem.ShowDeleteButton = True
          DefaultItem.SelectColor = clWhite
          DefaultItem.SelectColorTo = clInfoBk
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
          Display.DisplayEnd = 191
          Display.DisplayScale = 12
          Display.DisplayText = 2
          Display.ColorNonActive = clWhite
          Flat = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Footer.Captions.Strings = (
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            '')
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
          GridPopup = MnuItemPopup
          GridLeftCol = 0
          GridTopRow = 1
          Header.Captions.Strings = (
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            '')
          Header.CustomGroups = <>
          Header.Height = 100
          Header.Font.Charset = ANSI_CHARSET
          Header.Font.Color = clBlack
          Header.Font.Height = -12
          Header.Font.Name = 'Arial'
          Header.Font.Style = [fsBold]
          Header.GroupFont.Charset = DEFAULT_CHARSET
          Header.GroupFont.Color = clWindowText
          Header.GroupFont.Height = -11
          Header.GroupFont.Name = 'MS Sans Serif'
          Header.GroupFont.Style = []
          Header.ItemHeight = 16
          Header.TextHeight = 100
          HourType = ht12hrs
          HTMLOptions.CellFontStyle = []
          HTMLOptions.HeaderFontStyle = []
          HTMLOptions.SidebarFontStyle = []
          InActiveDays.Sat = False
          InActiveDays.Sun = False
          ItemPopup = MnuItemPopup
          Items = <>
          Mode.DateTimeFormat = 'dd/mm/yyyy'
          Mode.Month = 8
          Mode.PeriodStartDay = 28
          Mode.PeriodStartMonth = 7
          Mode.PeriodStartYear = 2003
          Mode.PeriodEndDay = 14
          Mode.PeriodEndMonth = 9
          Mode.PeriodEndYear = 2003
          Mode.PlannerType = plTimeLine
          Mode.TimeLineStart = 42590.000000000000000000
          Mode.TimeLineNVUBegin = 0
          Mode.TimeLineNVUEnd = 0
          Mode.WeekStart = 2
          Mode.Year = 2003
          MultiSelect = True
          ShadowColor = clSilver
          Sidebar.AMPMPos = apNone
          Sidebar.DateTimeFormat = 'dd/mm/yyyy'
          Sidebar.Font.Charset = DEFAULT_CHARSET
          Sidebar.Font.Color = clBlack
          Sidebar.Font.Height = -12
          Sidebar.Font.Name = 'Arial'
          Sidebar.Font.Style = [fsBold]
          Sidebar.HourFontRatio = 1.700000000000000000
          Sidebar.OccupiedTo = clWhite
          Sidebar.Position = spTop
          Sidebar.TimeIndicator = True
          Positions = 20
          PositionProps = <>
          PositionWidth = 72
          PrintOptions.LineWidth = 0
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
          ShowDesignHelper = False
          URLGlyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888880000800
            0088888808F8F0F8F80888808000000000808880F070888070F0888080000000
            0080880408F8F0F8F80880CCC0000400008874CCC2222C4788887CCCC22226C0
            88887CC822222CC088887C822224642088887C888422C220888877CF8CCCC227
            888887F8F8222208888888776888208888888887777778888888}
          Version = '2.5.8.4'
          OnItemDblClick = plannerDayItemDblClick
          OnItemMoving = OnPlannerItemMoving
          OnItemPopupPrepare = PlannerREsWeekItemPopupPrepare
          ItemSource = ResTimeLineSource
        end
      end
    end
    object TabResMonth: TTabSheet
      HelpContext = 1422035
      Caption = 'TabResMonth'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlResMonth: TDNMPanel
        Left = 0
        Top = 0
        Width = 941
        Height = 209
        HelpContext = 1422036
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object PlannerResMonth: TDBPlanner
          Left = 1
          Top = 1
          Width = 939
          Height = 207
          HelpContext = 1422037
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
          AutoThemeAdapt = True
          Caption.Title = 'TDBPlanner'
          Caption.Font.Charset = DEFAULT_CHARSET
          Caption.Font.Color = clWhite
          Caption.Font.Height = -13
          Caption.Font.Name = 'MS Sans Serif'
          Caption.Font.Style = [fsBold]
          Caption.BackgroundSteps = 32
          Caption.Visible = False
          DayNames.Strings = (
            'Sun'
            'Mon'
            'Tue'
            'Wed'
            'Thu'
            'Fri'
            'Sat')
          DefaultItem.CaptionAlign = taCenter
          DefaultItem.CaptionBkgTo = clSilver
          DefaultItem.CaptionFont.Charset = ANSI_CHARSET
          DefaultItem.CaptionFont.Color = clWindowText
          DefaultItem.CaptionFont.Height = -7
          DefaultItem.CaptionFont.Name = 'Small Fonts'
          DefaultItem.CaptionFont.Style = []
          DefaultItem.ColorTo = 16250871
          DefaultItem.Cursor = -1
          DefaultItem.Font.Charset = ANSI_CHARSET
          DefaultItem.Font.Color = clWindowText
          DefaultItem.Font.Height = -7
          DefaultItem.Font.Name = 'Small Fonts'
          DefaultItem.Font.Style = []
          DefaultItem.ItemBegin = 16
          DefaultItem.ItemEnd = 17
          DefaultItem.ItemPos = 0
          DefaultItem.Name = 'PlannerItem0'
          DefaultItem.ReadOnly = True
          DefaultItem.Shape = psRounded
          DefaultItem.ShowDeleteButton = True
          DefaultItem.SelectColor = clWhite
          DefaultItem.SelectColorTo = clInfoBk
          DefaultItem.SelectFontColor = clBlack
          DefaultItem.Shadow = False
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
          Display.ActiveEnd = 20
          Display.DisplayEnd = 63
          Display.DisplayScale = 38
          Display.ColorNonActive = clSilver
          Display.ColorCurrent = 14145535
          Flat = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Footer.Captions.Strings = (
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            '')
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
          GridPopup = MnuItemPopup
          GridLeftCol = 0
          GridTopRow = 1
          Header.Captions.Strings = (
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            ''
            '')
          Header.CustomGroups = <>
          Header.Height = 100
          Header.Font.Charset = ANSI_CHARSET
          Header.Font.Color = clBlack
          Header.Font.Height = -12
          Header.Font.Name = 'Arial'
          Header.Font.Style = [fsBold]
          Header.GroupFont.Charset = DEFAULT_CHARSET
          Header.GroupFont.Color = clWindowText
          Header.GroupFont.Height = -11
          Header.GroupFont.Name = 'MS Sans Serif'
          Header.GroupFont.Style = []
          Header.ItemHeight = 16
          Header.TextHeight = 100
          HTMLOptions.CellFontStyle = []
          HTMLOptions.HeaderFontStyle = []
          HTMLOptions.SidebarFontStyle = []
          ItemPopup = MnuItemPopup
          Items = <>
          Mode.Month = 8
          Mode.PeriodStartDay = 28
          Mode.PeriodStartMonth = 7
          Mode.PeriodStartYear = 2003
          Mode.PeriodEndDay = 14
          Mode.PeriodEndMonth = 9
          Mode.PeriodEndYear = 2003
          Mode.PlannerType = plWeek
          Mode.TimeLineStart = 38009.000000000000000000
          Mode.TimeLineNVUBegin = 0
          Mode.TimeLineNVUEnd = 0
          Mode.Year = 2003
          ShadowColor = clSilver
          Sidebar.AMPMPos = apNone
          Sidebar.DateTimeFormat = 'dd/mm/yyyy'
          Sidebar.Font.Charset = DEFAULT_CHARSET
          Sidebar.Font.Color = clBlack
          Sidebar.Font.Height = -12
          Sidebar.Font.Name = 'Arial'
          Sidebar.Font.Style = [fsBold]
          Sidebar.HourFontRatio = 1.800000000000000000
          Sidebar.OccupiedTo = clWhite
          Sidebar.Position = spTop
          Sidebar.TimeIndicator = True
          Sidebar.Width = 70
          Positions = 15
          PositionProps = <>
          PositionWidth = 72
          PrintOptions.LineWidth = 0
          PrintOptions.FooterFont.Charset = DEFAULT_CHARSET
          PrintOptions.FooterFont.Color = clWindowText
          PrintOptions.FooterFont.Height = -11
          PrintOptions.FooterFont.Name = 'MS Sans Serif'
          PrintOptions.FooterFont.Style = []
          PrintOptions.HeaderAlignment = taCenter
          PrintOptions.HeaderFont.Charset = ANSI_CHARSET
          PrintOptions.HeaderFont.Color = clWindowText
          PrintOptions.HeaderFont.Height = -21
          PrintOptions.HeaderFont.Name = 'Arial'
          PrintOptions.HeaderFont.Style = [fsBold]
          PrintOptions.HeaderSize = 500
          PrintOptions.JobName = 'Roster'
          ScrollSmooth = True
          ScrollSynch = True
          URLGlyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888880000800
            0088888808F8F0F8F80888808000000000808880F070888070F0888080000000
            0080880408F8F0F8F80880CCC0000400008874CCC2222C4788887CCCC22226C0
            88887CC822222CC088887C822224642088887C888422C220888877CF8CCCC227
            888887F8F8222208888888776888208888888887777778888888}
          Version = '2.5.8.4'
          OnItemDblClick = plannerDayItemDblClick
          OnItemMoving = OnPlannerItemMoving
          ItemSource = ResMonthSource
        end
      end
    end
  end
  object pnlGrid: TDNMPanel [9]
    Left = 0
    Top = 49
    Width = 949
    Height = 129
    HelpContext = 1422038
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object grdMain: TwwDBGrid
      Left = 1
      Top = 1
      Width = 947
      Height = 127
      HelpContext = 1422039
      Selected.Strings = (
        'SaleID'#9'10'#9'Sale#'#9#9
        'customername'#9'10'#9'Customer'#9#9
        'saledate'#9'10'#9'Sale Date'#9#9
        'ProductName'#9'10'#9'Product'#9#9
        'UnitofMeasureShipped'#9'10'#9'Shipped'#9#9
        'UOM'#9'10'#9'UOM'#9#9
        'ItemCaption'#9'10'#9'Item'#9'F'
        'Duration'#9'10'#9'Duration'#9#9
        'EmployeeName'#9'10'#9'Employee'#9#9
        'TimeStart'#9'20'#9'TimeStart'#9'F'
        'TimeEnd'#9'20'#9'TimeEnd'#9'F'
        'BuildDate'#9'20'#9'BuildDate'#9'F'
        'QtyScheduled'#9'10'#9'Scheduled'#9'F'#9'Quantity'
        'QtyBuilt'#9'10'#9'Built'#9'F'#9'Quantity'
        'QtyUsed'#9'10'#9'Used'#9'F'#9'Quantity'
        'Resource'#9'10'#9'Resource'#9'F'
        'ResourceDetail'#9'10'#9'ResourceDetail'#9'F')
      MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
      IniAttributes.SaveToRegistry = True
      IniAttributes.Delimiter = ';;'
      IniAttributes.CheckNewFields = True
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      DataSource = dsDayRoster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgRowResize]
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
      UseTFields = False
      LineColors.GroupingColor = clSilver
      FooterColor = clWhite
      FooterCellColor = clWhite
      ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
      PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
      object btnGrid: TwwIButton
        Left = 0
        Top = 0
        Width = 13
        Height = 22
        HelpContext = 1422040
        AllowAllUp = True
      end
    end
  end
  object pnlheader: TDNMPanel [10]
    Left = 0
    Top = 0
    Width = 949
    Height = 49
    HelpContext = 1422005
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnDblClick = pnlheaderDblClick
    DesignSize = (
      949
      49)
    object pnlTitle: TDNMPanel
      Left = 320
      Top = 5
      Width = 358
      Height = 39
      HelpContext = 1422006
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
        Width = 356
        Height = 37
        HelpContext = 1422007
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
          Width = 356
          Height = 37
          HelpContext = 1422008
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Production Scheduler'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = 1
        end
      end
    end
    object dtStart: TDateTimePicker
      AlignWithMargins = True
      Left = 37
      Top = 11
      Width = 123
      Height = 27
      HelpContext = 1422009
      Margins.Left = 0
      Margins.Top = 11
      Margins.Right = 0
      Margins.Bottom = 11
      Align = alLeft
      Date = 42530.563163321770000000
      Time = 42530.563163321770000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnChange = dtStartChange
      ExplicitHeight = 30
    end
    object btnPrev: TButton
      AlignWithMargins = True
      Left = 3
      Top = 11
      Width = 34
      Height = 27
      HelpContext = 1422010
      Margins.Top = 11
      Margins.Right = 0
      Margins.Bottom = 11
      Align = alLeft
      Caption = '<'
      TabOrder = 2
      OnClick = btnPrevClick
    end
    object btnNext: TButton
      AlignWithMargins = True
      Left = 160
      Top = 11
      Width = 34
      Height = 27
      HelpContext = 1422011
      Margins.Left = 0
      Margins.Top = 11
      Margins.Right = 0
      Margins.Bottom = 11
      Align = alLeft
      Caption = '>'
      TabOrder = 3
      OnClick = btnNextClick
    end
    object btnRequery: TDNMSpeedButton
      AlignWithMargins = True
      Left = 197
      Top = 11
      Width = 107
      Height = 27
      HelpContext = 1422012
      Margins.Top = 11
      Margins.Bottom = 11
      Action = actRefresh
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
      TabOrder = 4
      AutoDisableParentOnclick = True
    end
    object chkShowFinalised: TCheckBox
      Left = 838
      Top = 0
      Width = 111
      Height = 49
      HelpContext = 1422013
      Align = alRight
      Anchors = []
      Caption = 'Show Converted Orders'
      TabOrder = 5
      WordWrap = True
      OnClick = chkShowFinalisedClick
    end
  end
  object DNMPanel1: TDNMPanel [11]
    Left = 0
    Top = 178
    Width = 949
    Height = 46
    HelpContext = 1422041
    Margins.Left = 222
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object Shader1: TShader
      Left = 177
      Top = 1
      Width = 595
      Height = 44
      HelpContext = 1422042
      Margins.Left = 200
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
      object lblCaption: TLabel
        Left = 0
        Top = 0
        Width = 595
        Height = 44
        HelpContext = 1422043
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Main'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        OnDblClick = lblCaptionDblClick
        ExplicitLeft = 3
        ExplicitTop = -3
      end
    end
    object rgCateogry: TRadioGroup
      AlignWithMargins = True
      Left = 4
      Top = 3
      Width = 170
      Height = 39
      HelpContext = 1422044
      Margins.Top = 2
      Align = alLeft
      Caption = 'Category'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Employee'
        'Resource')
      TabOrder = 1
      OnClick = rgPeriodClick
    end
    object rgPeriod: TRadioGroup
      AlignWithMargins = True
      Left = 775
      Top = 3
      Width = 170
      Height = 39
      HelpContext = 1422045
      Margins.Top = 2
      Align = alRight
      Caption = 'Period'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Day'
        'Week'
        'Month')
      TabOrder = 2
      OnClick = rgPeriodClick
    end
  end
  inherited tmrProcessMessage: TTimer
    Top = 120
  end
  inherited tmrdelay: TTimer
    Top = 120
  end
  inherited popSpelling: TPopupMenu
    Left = 112
    Top = 120
  end
  inherited tmrdelayMsg: TTimer
    Left = 464
    Top = 120
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 217
    Top = 120
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 253
    Top = 120
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
    Left = 42
    Top = 87
  end
  inherited DataState: TDataState
    Left = 288
    Top = 120
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 147
    Top = 120
  end
  inherited imgsort: TImageList
    Left = 323
    Top = 120
    Bitmap = {
      494C010102008401580210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Top = 120
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 358
    Top = 120
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 182
    Top = 120
  end
  inherited qryMemTrans: TERPQuery
    Left = 77
    Top = 120
  end
  object QryProcesstime: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select * from tmp_erp_D4F1A9F6_BOMPlanner_YNDBS0W5 order by Time' +
        'Start , EmployeeName')
    AfterOpen = QryProcesstimeAfterOpen
    AfterPost = QryProcesstimeAfterPost
    BeforeDelete = QryProcesstimeBeforeDelete
    Left = 805
    Top = 120
    object QryProcesstimeSaleID: TIntegerField
      DisplayLabel = 'Sale#'
      DisplayWidth = 10
      FieldName = 'SaleID'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.SaleID'
    end
    object QryProcesstimeSaleLineId: TIntegerField
      DisplayLabel = 'Sale Line#'
      DisplayWidth = 10
      FieldName = 'SaleLineId'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.SaleLineID'
    end
    object QryProcesstimecustomername: TWideStringField
      DisplayLabel = 'Customer'
      DisplayWidth = 10
      FieldName = 'customername'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.customername'
      Size = 255
    end
    object QryProcesstimesaledate: TDateTimeField
      DisplayLabel = 'Sale Date'
      DisplayWidth = 10
      FieldName = 'saledate'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.saledate'
    end
    object QryProcesstimeProductName: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 10
      FieldName = 'ProductName'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.ProductName'
      Size = 60
    end
    object QryProcesstimeUnitofMeasureShipped: TFloatField
      DisplayLabel = 'Shipped'
      DisplayWidth = 10
      FieldName = 'UnitofMeasureShipped'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.UnitofMeasureShipped'
    end
    object QryProcesstimeProctreetotalQty: TFloatField
      DisplayLabel = 'Tree Qty'
      DisplayWidth = 10
      FieldName = 'ProctreetotalQty'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.ProctreetotalQty'
    end
    object QryProcesstimeUOM: TWideStringField
      DisplayWidth = 10
      FieldName = 'UOM'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.UOM'
      Size = 255
    end
    object QryProcesstimeSalesconverted: TWideStringField
      DisplayWidth = 10
      FieldName = 'Salesconverted'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.Salesconverted'
      Size = 1
    end
    object QryProcesstimecaption: TWideStringField
      DisplayWidth = 10
      FieldName = 'caption'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.caption'
      Size = 255
    end
    object QryProcesstimeItemCaption: TWideStringField
      DisplayWidth = 10
      FieldName = 'ItemCaption'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.ItemCaption'
      Size = 255
    end
    object QryProcesstimeProcessStep: TWideStringField
      DisplayWidth = 10
      FieldName = 'ProcessStep'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.ProcessStep'
      Size = 255
    end
    object QryProcesstimeProcessstepId: TIntegerField
      DisplayLabel = 'Process Step#'
      DisplayWidth = 10
      FieldName = 'ProcessstepId'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.ProcessstepId'
    end
    object QryProcesstimeResource: TWideStringField
      DisplayWidth = 10
      FieldName = 'Resource'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.Resource'
      Size = 255
    end
    object QryProcesstimeResourceDetail: TWideStringField
      DisplayWidth = 10
      FieldName = 'ResourceDetail'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.ResourceDetail'
      Size = 255
    end
    object QryProcesstimeEmployeeName: TWideStringField
      DisplayLabel = 'Employee'
      DisplayWidth = 10
      FieldName = 'EmployeeName'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.EmployeeName'
      Size = 255
    end
    object QryProcesstimeTimeStart: TDateTimeField
      DisplayWidth = 10
      FieldName = 'TimeStart'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.TimeStart'
    end
    object QryProcesstimeTimeEnd: TDateTimeField
      DisplayWidth = 10
      FieldName = 'TimeEnd'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.TimeEnd'
    end
    object QryProcesstimeBuildDate: TDateTimeField
      DisplayWidth = 10
      FieldName = 'BuildDate'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.BuildDate'
    end
    object QryProcesstimeQtyScheduled: TFloatField
      DisplayLabel = 'Scheduled'
      DisplayWidth = 10
      FieldName = 'QtyScheduled'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.QtyScheduled'
    end
    object QryProcesstimeQtyBuilt: TFloatField
      DisplayLabel = 'Built'
      DisplayWidth = 10
      FieldName = 'QtyBuilt'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.QtyBuilt'
    end
    object QryProcesstimeQtyUsed: TFloatField
      DisplayLabel = 'Used'
      DisplayWidth = 10
      FieldName = 'QtyUsed'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.QtyUsed'
    end
    object QryProcesstimeProcessTimeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProcessTimeID'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.ProcessTimeID'
      Visible = False
    end
    object QryProcesstimeProcessPartId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProcessPartId'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.ProcessPartId'
      Visible = False
    end
    object QryProcesstimeDuration: TWideStringField
      FieldName = 'Duration'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.Duration'
      Size = 255
    end
    object QryProcesstimeSchdDuration: TWideStringField
      FieldName = 'SchdDuration'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.SchdDuration'
      Size = 255
    end
    object QryProcesstimeProcessStatus: TWideStringField
      FieldName = 'ProcessStatus'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.ProcessStatus'
      Size = 255
    end
    object QryProcesstimeID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.ID'
    end
    object QryProcesstimeProcResourceId: TIntegerField
      FieldName = 'ProcResourceId'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.ProcResourceId'
    end
    object QryProcesstimeEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.EmployeeID'
    end
    object QryProcesstimePRDID: TIntegerField
      FieldName = 'PRDID'
      Origin = 'tmp_erp_d4f1a9f6_bomplanner_yndbs0w5.PRDID'
    end
    object QryProcesstimeEmployeeIDLookup: TIntegerField
      FieldKind = fkLookup
      FieldName = 'EmployeeIDLookup'
      LookupDataSet = QryEmployees
      LookupKeyFields = 'EmployeeID'
      LookupResultField = 'No'
      KeyFields = 'EmployeeID'
      Lookup = True
    end
    object QryProcesstimePRDIdLookup: TIntegerField
      FieldKind = fkLookup
      FieldName = 'PRDIdLookup'
      LookupDataSet = qryResourceD
      LookupKeyFields = 'PRDID'
      LookupResultField = 'No'
      KeyFields = 'PRDID'
      Lookup = True
    end
    object QryProcesstimeProductDesc: TWideStringField
      FieldName = 'ProductDesc'
      Size = 255
    end
  end
  object dsWeekRoster: TDataSource
    DataSet = QryProcesstime
    Left = 538
    Top = 88
  end
  object dsDayRoster: TDataSource
    DataSet = QryProcesstime
    Left = 504
    Top = 88
  end
  object QryEmployees: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select'
      'convert(@rownum:=@rownum+1, Signed INTEGER) as No,'
      'Details.*'
      'From('
      
        'Select Distinct EmployeeID, EmployeeName from tmp_erp_D4F1A9F6_B' +
        'OMPlanner_YNDBS0W5  '
      
        'union select distinct E.employeeId , E.employeename  from tblemp' +
        'loyeeprocesssteps PT inner join tblemployees E on PT.employeeId ' +
        '= E.employeeId '
      #9'Order by employeeName) Details'
      ',(SELECT @rownum:=-1) r')
    AfterOpen = QryEmployeesAfterOpen
    Left = 837
    Top = 120
    object QryEmployeesEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Origin = 'Details.EmployeeName'
      Size = 255
    end
    object QryEmployeesEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'Details.EmployeeID'
    end
    object QryEmployeesNo: TLargeintField
      FieldName = 'No'
      Origin = 'No'
    end
  end
  object qryResourceD: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select convert(@rownum:=@rownum+1, Signed INTEGER) as No, Detail' +
        's.* From   (Select distinct ProcResourceId , Resource, PRDID, Re' +
        'sourceDetail from tmp_erp_D4F1A9F6_BOMPlanner_YNDBS0W5 Order by ' +
        'ResourceDetail)   Details ,(SELECT @rownum:=-1) r')
    AfterOpen = qryResourceDAfterOpen
    Left = 909
    Top = 120
    object qryResourceDNo: TLargeintField
      FieldName = 'No'
      Origin = 'No'
    end
    object qryResourceDProcResourceId: TIntegerField
      FieldName = 'ProcResourceId'
      Origin = 'Details.ProcResourceId'
    end
    object qryResourceDResource: TWideStringField
      FieldName = 'Resource'
      Origin = 'Details.Resource'
      Size = 255
    end
    object qryResourceDPRDID: TIntegerField
      FieldName = 'PRDID'
      Origin = 'Details.PRDID'
    end
    object qryResourceDResourceDetail: TWideStringField
      FieldName = 'ResourceDetail'
      Origin = 'Details.ResourceDetail'
      Size = 255
    end
  end
  object sctProcesstimeList: TERPScript
    SQL.Strings = (
      'Drop table if Exists <Tablename>;'
      'CREATE TABLE <Tablename> ('
      #9'ID INT(10) NOT NULL AUTO_INCREMENT,'
      #9'SaleID INT(11) NOT NULL DEFAULT 0,'
      #9'customername VARCHAR(255) NULL DEFAULT NULL,'
      #9'saledate DATETIME NULL DEFAULT NULL,'
      #9'ProductName VARCHAR(255) NULL DEFAULT NULL,'
      #9'UnitofMeasureShipped DOUBLE NOT NULL DEFAULT 0,'
      #9'UOM VARCHAR(255) NULL DEFAULT NULL,'
      #9'caption VARCHAR(255) NULL DEFAULT NULL,'
      #9'ProcessStep VARCHAR(255) NOT NULL DEFAULT " ",'
      #9'Duration VARCHAR(255) NULL DEFAULT NULL,'
      #9'ProcResourceId int(11),'
      #9'EmployeeID int(11),'
      #9'Resource VARCHAR(255) NULL DEFAULT NULL,'
      #9'ResourceDetail VARCHAR(255) NULL DEFAULT NULL,'
      #9'EmployeeName VARCHAR(255) NULL DEFAULT NULL,'
      #9'ProcessTimeID INT(11) NOT NULL DEFAULT 0,'
      #9'ProcessPartId INT(11) NULL DEFAULT NULL,'
      #9'TimeStart DATETIME NULL DEFAULT NULL,'
      #9'TimeEnd DATETIME NULL DEFAULT NULL,'
      #9'BuildDate DATETIME NULL DEFAULT NULL,'
      #9'QtyScheduled DOUBLE NULL DEFAULT NULL,'
      #9'QtyBuilt DOUBLE NULL DEFAULT NULL,'
      #9'QtyUsed DOUBLE NULL DEFAULT NULL,'
      #9'PRIMARY KEY (ID),'
      #9'INDEX SaleID (SaleID),'
      #9'INDEX ProcessTimeID (ProcessTimeID),'
      #9'INDEX ProcessPartId (ProcessPartId)'
      ')'
      'COLLATE="utf8_general_ci"'
      'ENGINE=MyISAM'
      ';'
      ''
      ''
      'insert ignore into <Tablename> '
      
        '(SaleID,customername,saledate,ProductName,UnitofMeasureShipped,U' +
        'OM,caption,ProcessStep,Duration,ProcResourceId,Resource,Resource' +
        'Detail,EmployeeName,EmployeeId,ProcessTimeID,ProcessPartId,TimeS' +
        'tart,TimeEnd,BuildDate,QtyScheduled,QtyBuilt,QtyUsed)'
      'select '
      'S.SaleID, '
      'S.customername,'
      'S.saledate,'
      'SL.ProductName,'
      'SL.UnitofMeasureShipped,'
      
        'Concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultipl' +
        'ier , ")") as UOM,'
      'PT.caption,'
      'PS.Description as ProcessStep,'
      
        'FormatSecondsTotime((ifnull(PP.Duration,0)+ifnull(PP.SetupDurati' +
        'on,0)+ifnull(PP.BreakdownDuration,0))*PT.totalQty) as Duration,'
      'PR.ProcResourceId, '
      'PR.Description as Resource,'
      'PRD.Description as ResourceDetail,'
      'E.EmployeeName, '
      'PST.employeeId,'
      'PST.ProcessTimeID , '
      'PST.ProcessPartId , '
      'PST.TimeStart , '
      'DATE_ADD(PST.timeStart,INTERVAL PST.Duration second) TimeEnd ,'
      'PPQ.BuildDate ,'
      'PPQ.QtyScheduled,'
      'PPQ.QtyBuilt , '
      'PPQ.QtyUsed'
      'from TblSales S '
      'inner join tblsaleslines SL on S.saleId = SL.saleId '
      
        'inner join tblProcTree PT on PT.masterId = SL.saleLineId and PT.' +
        'masterType <> "mtProduct"'
      'inner join tblprocesspart PP on PT.proctreeId = PP.proctreeId'
      'inner join tblprocessstep PS on PP.ProcessStepID = PS.ID'
      'inner join tblProcesstime PST on PST.processpartId = PP.ID'
      'inner join tblemployees E on E.EmployeeID = PST.EmployeeId'
      
        'inner join tblprocresourcedetails PRD on PRD.ID= PST.Resourcedet' +
        'ailsID'
      
        'inner join tblprocresource PR on PR.ProcResourceId = PRD.ProcRes' +
        'ourceId'
      
        'Left join tblprocesspartqty PPQ  on PST.ProcesstimeID = PPQ.Proc' +
        'esstimeID and PST.ProcessPartID = PPQ.ProcessPartID'
      'Where (PST.TimeStart between :DAteFrom and :DAteto )'
      
        'or (DATE_ADD(PST.timeStart,INTERVAL PST.Duration second) between' +
        ' :DAteFrom and :DAteto )'
      
        'or (PST.TimeStart  < :Datefrom and DATE_ADD(PST.timeStart,INTERV' +
        'AL PST.Duration second) > :DAteto )'
      
        'Order by S.saleId desc , SL.ProductName, PT.sequenceDown, PST.Ti' +
        'meStart')
    Connection = MyConnection
    IgnorenContinueOnError = False
    Left = 262
    Top = 320
  end
  object MonthSource: TDBWeekSource
    Active = False
    AutoIncKey = False
    DataSource = dsMonthRoster
    ResourceMap = <>
    StartTimeField = 'TimeStart'
    EndTimeField = 'TimeEnd'
    KeyField = 'ProcessTimeID'
    ReadOnly = False
    ResourceField = 'EmployeeIDLookup'
    NotesField = 'ItemCaption'
    UpdateByQuery = False
    OnFieldsToItem = SourceFieldsToitem
    OnItemToFields = SourceItemTofields
    NumberOfResources = 20
    Month = 8
    Year = 2003
    WeekStart = 0
    Weeks = 9
    Left = 570
    Top = 120
  end
  object dsMonthRoster: TDataSource
    DataSet = QryProcesstime
    Left = 570
    Top = 88
  end
  object DaySource: TDBDaySource
    Active = False
    AutoIncKey = False
    DataSource = dsDayRoster
    ResourceMap = <>
    StartTimeField = 'TimeStart'
    EndTimeField = 'TimeEnd'
    KeyField = 'ProcessTimeID'
    ReadOnly = False
    ResourceField = 'EmployeeIDLookup'
    NotesField = 'ItemCaption'
    UpdateByQuery = False
    OnFieldsToItem = SourceFieldsToitem
    OnItemToFields = SourceItemTofields
    DateFormat = 'dd mmm yyyy'
    Day = 37846.000000000000000000
    Mode = dmMultiResource
    NumberOfResources = 20
    Left = 504
    Top = 120
  end
  object ResMonthSource: TDBWeekSource
    Active = False
    AutoIncKey = False
    DataSource = dsResMonthRoster
    ResourceMap = <>
    StartTimeField = 'TimeStart'
    EndTimeField = 'TimeEnd'
    KeyField = 'ProcessTimeID'
    ReadOnly = False
    ResourceField = 'PRDIdLookup'
    NotesField = 'ItemCaption'
    UpdateByQuery = False
    OnFieldsToItem = SourceFieldsToitem
    OnItemToFields = SourceItemTofields
    NumberOfResources = 20
    Month = 8
    Year = 2003
    WeekStart = 0
    Weeks = 9
    Left = 714
    Top = 120
  end
  object resDaySource: TDBDaySource
    Active = False
    AutoIncKey = False
    DataSource = dsResDayRoster
    ResourceMap = <>
    StartTimeField = 'TimeStart'
    EndTimeField = 'TimeEnd'
    KeyField = 'ProcessTimeID'
    ReadOnly = False
    ResourceField = 'PRDIdLookup'
    NotesField = 'ItemCaption'
    UpdateByQuery = False
    OnFieldsToItem = SourceFieldsToitem
    OnItemToFields = SourceItemTofields
    DateFormat = 'dd mmm yyyy'
    Day = 37846.000000000000000000
    Mode = dmMultiResource
    NumberOfResources = 20
    Left = 650
    Top = 122
  end
  object dsResDayRoster: TDataSource
    DataSet = QryProcesstime
    Left = 648
    Top = 88
  end
  object dsResWeekRoster: TDataSource
    DataSet = QryProcesstime
    Left = 682
    Top = 88
  end
  object dsResMonthRoster: TDataSource
    DataSet = QryProcesstime
    Left = 714
    Top = 88
  end
  object sctDataUpdate: TERPScript
    SQL.Strings = (
      'Drop table if Exists <Tablename>;'
      'CREATE TABLE <Tablename> ('
      #9'ID INT(10) NOT NULL AUTO_INCREMENT,'
      #9'SaleID INT(11) NOT NULL DEFAULT 0,'
      #9'customername VARCHAR(255) NULL DEFAULT NULL,'
      #9'saledate DATETIME NULL DEFAULT NULL,'
      #9'ProductName VARCHAR(255) NULL DEFAULT NULL,'
      #9'UnitofMeasureShipped DOUBLE NOT NULL DEFAULT 0,'
      #9'UOM VARCHAR(255) NULL DEFAULT NULL,'
      #9'caption VARCHAR(255) NULL DEFAULT NULL,'
      #9'ProcessStep VARCHAR(255) NOT NULL DEFAULT " ",'
      #9'Duration VARCHAR(255) NULL DEFAULT NULL,'
      #9'ProcResourceId int(11),'
      #9'EmployeeID int(11),'
      #9'Resource VARCHAR(255) NULL DEFAULT NULL,'
      #9'ResourceDetail VARCHAR(255) NULL DEFAULT NULL,'
      #9'EmployeeName VARCHAR(255) NULL DEFAULT NULL,'
      #9'ProcessTimeID INT(11) NOT NULL DEFAULT 0,'
      #9'ProcessPartId INT(11) NULL DEFAULT NULL,'
      #9'TimeStart DATETIME NULL DEFAULT NULL,'
      #9'TimeEnd DATETIME NULL DEFAULT NULL,'
      #9'BuildDate DATETIME NULL DEFAULT NULL,'
      #9'QtyScheduled DOUBLE NULL DEFAULT NULL,'
      #9'QtyBuilt DOUBLE NULL DEFAULT NULL,'
      #9'QtyUsed DOUBLE NULL DEFAULT NULL,'
      #9'PRIMARY KEY (ID),'
      #9'INDEX SaleID (SaleID),'
      #9'INDEX ProcessTimeID (ProcessTimeID),'
      #9'INDEX ProcessPartId (ProcessPartId)'
      ')'
      'COLLATE="utf8_general_ci"'
      'ENGINE=MyISAM'
      ';'
      ''
      ''
      'insert ignore into <Tablename> '
      
        '(SaleID,customername,saledate,ProductName,UnitofMeasureShipped,U' +
        'OM,caption,ProcessStep,Duration,ProcResourceId,Resource,Resource' +
        'Detail,EmployeeName,EmployeeId,ProcessTimeID,ProcessPartId,TimeS' +
        'tart,TimeEnd,BuildDate,QtyScheduled,QtyBuilt,QtyUsed)'
      'select '
      'S.SaleID, '
      'S.customername,'
      'S.saledate,'
      'SL.ProductName,'
      'SL.UnitofMeasureShipped,'
      
        'Concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultipl' +
        'ier , ")") as UOM,'
      'PT.caption,'
      'PS.Description as ProcessStep,'
      
        'FormatSecondsTotime((ifnull(PP.Duration,0)+ifnull(PP.SetupDurati' +
        'on,0)+ifnull(PP.BreakdownDuration,0))*PT.totalQty) as Duration,'
      'PR.ProcResourceId, '
      'PR.Description as Resource,'
      'PRD.Description as ResourceDetail,'
      'E.EmployeeName, '
      'PST.employeeId,'
      'PST.ProcessTimeID , '
      'PST.ProcessPartId , '
      'PST.TimeStart , '
      'DATE_ADD(PST.timeStart,INTERVAL PST.Duration second) TimeEnd ,'
      'PPQ.BuildDate ,'
      'PPQ.QtyScheduled,'
      'PPQ.QtyBuilt , '
      'PPQ.QtyUsed'
      'from TblSales S '
      'inner join tblsaleslines SL on S.saleId = SL.saleId '
      
        'inner join tblProcTree PT on PT.masterId = SL.saleLineId and PT.' +
        'masterType <> "mtProduct"'
      'inner join tblprocesspart PP on PT.proctreeId = PP.proctreeId'
      'inner join tblprocessstep PS on PP.ProcessStepID = PS.ID'
      'inner join tblProcesstime PST on PST.processpartId = PP.ID'
      'inner join tblemployees E on E.EmployeeID = PST.EmployeeId'
      
        'inner join tblprocresourcedetails PRD on PRD.ID= PST.Resourcedet' +
        'ailsID'
      
        'inner join tblprocresource PR on PR.ProcResourceId = PRD.ProcRes' +
        'ourceId'
      
        'Left join tblprocesspartqty PPQ  on PST.ProcesstimeID = PPQ.Proc' +
        'esstimeID and PST.ProcessPartID = PPQ.ProcessPartID'
      'Where (PST.TimeStart between :DAteFrom and :DAteto )'
      
        'or (DATE_ADD(PST.timeStart,INTERVAL PST.Duration second) between' +
        ' :DAteFrom and :DAteto )'
      
        'or (PST.TimeStart  < :Datefrom and DATE_ADD(PST.timeStart,INTERV' +
        'AL PST.Duration second) > :DAteto )'
      
        'Order by S.saleId desc , SL.ProductName, PT.sequenceDown, PST.Ti' +
        'meStart')
    Connection = MyConnection
    IgnorenContinueOnError = False
    Left = 302
    Top = 320
  end
  object QryResources: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select convert(@rownum:=@rownum+1, Signed INTEGER) as No, Detail' +
        's.*  From(Select distinct ProcResourceId , Resource from tmp_erp' +
        '_D4F1A9F6_BOMPlanner_YNDBS0W5   Order by Resource) Details ,(SEL' +
        'ECT @rownum:=-1) r')
    AfterOpen = QryResourcesAfterOpen
    Left = 869
    Top = 120
    object QryResourcesNo: TLargeintField
      FieldName = 'No'
      Origin = 'No'
    end
    object QryResourcesProcResourceId: TIntegerField
      FieldName = 'ProcResourceId'
      Origin = 'Details.ProcResourceId'
    end
    object QryResourcesResource: TWideStringField
      FieldName = 'Resource'
      Origin = 'Details.Resource'
      Size = 255
    end
  end
  object TimeLineSource: TDBTimeLineSource
    Active = False
    AutoIncKey = False
    DataSource = dsWeekRoster
    ResourceMap = <>
    StartTimeField = 'TimeStart'
    EndTimeField = 'TimeEnd'
    KeyField = 'ProcessTimeID'
    ReadOnly = False
    ResourceField = 'EmployeeIDLookup'
    NotesField = 'ItemCaption'
    UpdateByQuery = False
    OnFieldsToItem = SourceFieldsToitem
    OnItemToFields = SourceItemTofields
    NumberOfResources = 20
    StartDate = 42590.000000000000000000
    EndDate = 42593.000000000000000000
    Left = 536
    Top = 121
  end
  object ResTimeLineSource: TDBTimeLineSource
    Active = False
    AutoIncKey = False
    DataSource = dsResWeekRoster
    ResourceMap = <>
    StartTimeField = 'TimeStart'
    EndTimeField = 'TimeEnd'
    KeyField = 'ProcessTimeID'
    ReadOnly = False
    ResourceField = 'PRDIdLookup'
    NotesField = 'ItemCaption'
    UpdateByQuery = False
    OnFieldsToItem = SourceFieldsToitem
    OnItemToFields = SourceItemTofields
    NumberOfResources = 20
    StartDate = 42590.000000000000000000
    EndDate = 42593.000000000000000000
    Left = 680
    Top = 121
  end
  object ActionList: TActionList
    Left = 560
    Top = 323
    object actPrintJobDetails: TDNMAction
      Caption = 'Print Job Details'
      HelpContext = 1422046
      OnExecute = actPrintJobDetailsExecute
      buttoncolor = clWhite
    end
    object actPrintWorkSheets: TAction
      Caption = 'Production Work Sheets'
      HelpContext = 1422047
      OnExecute = actPrintWorkSheetsExecute
    end
    object actCancel: TAction
      Caption = 'Close'
      HelpContext = 1422048
      OnExecute = actCancelExecute
    end
    object actSave: TAction
      Caption = 'Save'
      HelpContext = 1422049
      OnExecute = actSaveExecute
    end
    object actOpenSale: TAction
      Caption = 'Open Sale'
      HelpContext = 1422050
      OnExecute = actOpenSaleExecute
    end
    object actProductTree: TAction
      Caption = 'Product Tree'
      HelpContext = 1422051
      OnExecute = actProductTreeExecute
    end
    object actAutoSchedule: TAction
      Caption = 'Auto Schedule'
      HelpContext = 1422052
      OnExecute = actAutoScheduleExecute
    end
    object actPrintPickingSlip: TAction
      Caption = 'Print Picking Slip'
      HelpContext = 1422053
      OnExecute = actPrintPickingSlipExecute
    end
    object actRefresh: TAction
      Caption = 'Refresh'
      HelpContext = 1422054
      OnExecute = actRefreshExecute
    end
    object actInvoiceTotOrder: TAction
      Caption = 'Complete and Invoice Total Order'
      HelpContext = 1422055
      OnExecute = actInvoiceTotOrderExecute
    end
    object actInvoice: TAction
      Caption = 'Complete and Invoice'
      HelpContext = 1422056
      OnExecute = actInvoiceExecute
    end
    object actOrderStatus: TDNMAction
      Caption = 'Order Status'
      HelpContext = 1422057
      OnExecute = actOrderStatusExecute
      buttoncolor = clWhite
    end
    object actStowAway: TDNMAction
      Caption = 'Stow Aways'
      HelpContext = 1422058
      OnExecute = actStowAwayExecute
      buttoncolor = clWhite
    end
    object actPQAllocation: TDNMAction
      Caption = 'Bin / Batch / Serial Number Allocation'
      HelpContext = 1422059
      OnExecute = actPQAllocationExecute
      buttoncolor = clWhite
    end
    object actallocPickingSlip: TDNMAction
      Caption = #39'Bin / Batch / Serial No'#39' Picking Slip'
      HelpContext = 1422060
      ImageIndex = 0
      OnExecute = actallocPickingSlipExecute
      buttoncolor = clWhite
    end
    object actUnselectAll: TDNMAction
      Caption = 'Un-Select All'
      HelpContext = 1422061
      OnExecute = SelectOrUnselect
      buttoncolor = clWhite
    end
    object actSelectAll: TDNMAction
      Caption = 'Select All'
      HelpContext = 1422062
      OnExecute = SelectOrUnselect
      buttoncolor = clWhite
    end
    object actPartialInvoice: TDNMAction
      Caption = 'Make a Partial Invoice'
      HelpContext = 1422063
      OnExecute = actPartialInvoiceExecute
      buttoncolor = clWhite
    end
  end
  object MnuItemPopup: TAdvPopupMenu
    AutoHotkeys = maManual
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 528
    Top = 328
    object PrintJobDetails1: TMenuItem
      Action = actPrintJobDetails
    end
    object ProductionWorkSheets1: TMenuItem
      Action = actPrintWorkSheets
    end
    object mnuGoodOrderStatus: TMenuItem
      Caption = 'Goods Order Status'
      HelpContext = 1422064
      OnClick = mnuGoodOrderStatusClick
    end
    object N1: TMenuItem
      Caption = '-'
      HelpContext = 1422065
    end
    object OpenSale1: TMenuItem
      Action = actOpenSale
    end
    object ProductTree1: TMenuItem
      Action = actProductTree
    end
    object CreatePickingSlip1: TMenuItem
      Action = actPrintPickingSlip
    end
    object BinBatchSerialNoPickingSlip1: TMenuItem
      Action = actallocPickingSlip
    end
    object N5: TMenuItem
      Caption = '-'
      HelpContext = 1422066
    end
    object PQAAllocation1: TMenuItem
      Action = actPQAllocation
    end
    object StowAways1: TMenuItem
      Action = actStowAway
    end
    object N4: TMenuItem
      Caption = '-'
      HelpContext = 1422067
    end
    object CompleteandInvoice1: TMenuItem
      Action = actInvoice
    end
    object CompleteandInvoiceTotalOrder1: TMenuItem
      Action = actInvoiceTotOrder
    end
    object N6: TMenuItem
      Caption = '-'
      HelpContext = 1422068
    end
    object FlagasScheduled1: TMenuItem
      Caption = 'Flag as Scheduled'
      HelpContext = 1422069
      Visible = False
    end
    object FlagasStarted1: TMenuItem
      Caption = 'Flag as Started'
      HelpContext = 1422070
      Visible = False
    end
    object FlagasComplete1: TMenuItem
      Caption = 'Flag as Complete'
      HelpContext = 1422071
      Visible = False
    end
    object FlagasCompleteandEdit1: TMenuItem
      Caption = 'Edit and Flag as Complete'
      HelpContext = 1422072
      Visible = False
    end
    object FlagasQualityAssurance1: TMenuItem
      Caption = 'Flag as Quality Assurance'
      HelpContext = 1422073
      Visible = False
    end
    object FlagasNotScheduled1: TMenuItem
      Caption = 'Flag as Not Scheduled'
      HelpContext = 1422074
      Visible = False
    end
    object N2: TMenuItem
      Caption = '-'
      HelpContext = 1422075
      Visible = False
    end
    object OrderStatus1: TMenuItem
      Action = actOrderStatus
    end
    object N3: TMenuItem
      Caption = '-'
      HelpContext = 1422076
    end
    object mnuPartialInvoice: TMenuItem
      Action = actPartialInvoice
    end
    object mnuPartialShipments: TMenuItem
      Caption = 'Partial Invoices Created'
      HelpContext = 1422077
      OnClick = mnuPartialShipmentsClick
    end
    object N7: TMenuItem
      Caption = '-'
      HelpContext = 1422078
    end
    object SelectAll1: TMenuItem
      Action = actSelectAll
    end
    object UnSelectAll1: TMenuItem
      Action = actUnselectAll
    end
  end
end
