inherited fmEmpResProcScheduleVsRoster: TfmEmpResProcScheduleVsRoster
  Left = 386
  Top = 270
  HelpContext = 1367002
  Caption = 'Employee Schedule'
  ClientWidth = 998
  ExplicitLeft = 386
  ExplicitTop = 270
  ExplicitWidth = 1014
  DesignSize = (
    998
    532)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 213
    Width = 998
    HelpContext = 1367003
    ExplicitTop = 484
    ExplicitWidth = 998
  end
  inherited shapehint: TShape
    Left = 127
    ExplicitLeft = 127
  end
  inherited shapehintextra1: TShape
    Left = 267
    ExplicitLeft = 267
  end
  inherited lblMsg: TLabel
    Top = 213
    Width = 998
    HelpContext = 1367017
    Caption = '[CTRL] + [ALT] + [LEFT]/[RIGHT] to Adjust Column Width'
    Visible = True
    ExplicitTop = 213
    ExplicitWidth = 308
  end
  inherited pnltop: TDNMPanel
    Width = 998
    HelpContext = 1367004
    ExplicitWidth = 998
    DesignSize = (
      998
      59)
    inherited pnlTitle: TDNMPanel
      Anchors = [akTop]
      HelpContext = 1367028
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          HelpContext = 1367018
          Caption = 'Employee Schedule'
        end
      end
    end
  end
  inherited DNMPanel3: TDNMPanel
    Top = 485
    Width = 998
    Height = 47
    HelpContext = 1367005
    ExplicitTop = 485
    ExplicitWidth = 998
    ExplicitHeight = 47
    DesignSize = (
      998
      47)
    inherited Label1: TLabel
      Width = 996
      Height = 15
      HelpContext = 1367006
      Caption = ''
      Visible = False
      ExplicitWidth = 3
      ExplicitHeight = 15
    end
    inherited cmdClose: TDNMSpeedButton
      Left = 138
      Top = 10
      ExplicitLeft = 138
      ExplicitTop = 10
    end
    inherited cmdCancel: TDNMSpeedButton
      Left = 767
      Top = 10
      ExplicitLeft = 767
      ExplicitTop = 10
    end
    inherited btnShowResouce: TDNMSpeedButton
      Left = 274
      Top = 11
      ExplicitLeft = 274
      ExplicitTop = 11
    end
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 452
      Top = 11
      Width = 131
      Height = 27
      HelpContext = 1367007
      Anchors = [akBottom]
      Caption = 'Schedule Fields'
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
      OnClick = DNMSpeedButton1Click
    end
    object cmdPrint: TDNMSpeedButton
      Left = 633
      Top = 11
      Width = 87
      Height = 27
      Hint = '"Print The List"'
      HelpContext = 1367008
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
  end
  inherited pgeRosters: TPageControl
    Width = 745
    Height = 154
    HelpContext = 1367009
    TabWidth = 200
    ExplicitWidth = 745
    ExplicitHeight = 154
    inherited tabDaily: TTabSheet
      ExplicitWidth = 737
      ExplicitHeight = 386
      inherited pnlMain: TDNMPanel
        Width = 737
        Height = 114
        HelpContext = 1367010
        ExplicitWidth = 737
        ExplicitHeight = 386
        inherited Planner: TDBPlanner
          Width = 673
          Height = 110
          HelpContext = 1367012
          Caption.Title = '                                         Employee Schedule'
          DefaultItem.CaptionType = ctText
          Display.DisplayScale = 11
          Sidebar.Font.Height = -12
          Sidebar.Font.Style = [fsBold]
          ExplicitTop = -1
          ExplicitWidth = 673
          ExplicitHeight = 110
          DesignSize = (
            673
            110)
          inherited pnlbuttons: TDNMPanel
            Visible = False
            HelpContext = 1367029
          end
        end
        inherited btnnext: TAdvGlowButton
          Left = 706
          Top = 39
          Height = 73
          Margins.Top = 38
          ExplicitLeft = 706
          ExplicitTop = 39
          ExplicitHeight = 73
          HelpContext = 1367030
        end
        inherited btnPrevious: TAdvGlowButton
          Top = 39
          Height = 73
          Margins.Top = 38
          ExplicitTop = 39
          ExplicitHeight = 73
          HelpContext = 1367031
        end
      end
    end
    object TabWeekly: TTabSheet
      HelpContext = 1367021
      Caption = 'Weekly'
      ImageIndex = 2
      ExplicitLeft = 3
      ExplicitTop = 35
      ExplicitWidth = 0
      ExplicitHeight = 386
      object PlannerWeek: TDBPlanner
        AlignWithMargins = True
        Left = 0
        Top = 1
        Width = 737
        Height = 112
        Hint = 
          'Planner is Read Only - Shows the Employee Roster, Scheduled Jobs' +
          '  and Employee Leaves'
        HelpContext = 1367022
        Margins.Left = 0
        Margins.Top = 1
        Margins.Right = 0
        Margins.Bottom = 1
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
        Caption.Title = '                                         Employee Schedule'
        Caption.Font.Charset = ANSI_CHARSET
        Caption.Font.Color = clWhite
        Caption.Font.Height = -24
        Caption.Font.Name = 'Arial'
        Caption.Font.Style = [fsBold]
        Caption.Background = clNavy
        Caption.BackgroundSteps = 32
        Caption.GradientDirection = gdVertical
        Color = clWhite
        DayNames.Strings = (
          'Sunday'
          'Monday'
          'Tuesday'
          'Wednesday'
          'Thursday'
          'Friday'
          'Saturday')
        DefaultItem.CaptionFont.Charset = DEFAULT_CHARSET
        DefaultItem.CaptionFont.Color = clWindowText
        DefaultItem.CaptionFont.Height = -11
        DefaultItem.CaptionFont.Name = 'Tahoma'
        DefaultItem.CaptionFont.Style = []
        DefaultItem.Cursor = -1
        DefaultItem.Font.Charset = DEFAULT_CHARSET
        DefaultItem.Font.Color = clWindowText
        DefaultItem.Font.Height = -11
        DefaultItem.Font.Name = 'Tahoma'
        DefaultItem.Font.Style = []
        DefaultItem.ItemBegin = 0
        DefaultItem.ItemEnd = 0
        DefaultItem.ItemPos = 0
        DefaultItem.Name = 'PlannerItem0'
        DefaultItem.Shape = psRounded
        DefaultItem.ShowDeleteButton = True
        DefaultItem.SelectColor = 11075496
        DefaultItem.SelectColorTo = 11075496
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
        DirectMove = True
        Display.ActiveStart = 0
        Display.ActiveEnd = 0
        Display.DisplayEnd = 95
        Display.DisplayScale = 20
        Display.DisplayUnit = 60
        Display.ColorNonActive = clWhite
        Display.ColorCurrent = 15263999
        Display.ColorCurrentItem = clWhite
        EnableFlashing = True
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
        GridPopup = popPlanner
        GridLeftCol = 0
        GridTopRow = 1
        Header.AllowResize = True
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
          '')
        Header.CustomGroups = <>
        Header.Height = 102
        Header.Font.Charset = ANSI_CHARSET
        Header.Font.Color = clBlack
        Header.Font.Height = -11
        Header.Font.Name = 'Arial'
        Header.Font.Style = []
        Header.GroupFont.Charset = DEFAULT_CHARSET
        Header.GroupFont.Color = clWindowText
        Header.GroupFont.Height = -11
        Header.GroupFont.Name = 'MS Sans Serif'
        Header.GroupFont.Style = []
        Header.ItemHeight = 16
        Header.TextHeight = 100
        HintOnItemChange = False
        HourType = ht12hrs
        HTMLOptions.CellFontStyle = []
        HTMLOptions.HeaderFontStyle = []
        HTMLOptions.SidebarFontStyle = []
        ItemPopup = popupPlannerItem
        Items = <>
        Mode.Month = 6
        Mode.PeriodStartDay = 1
        Mode.PeriodStartMonth = 6
        Mode.PeriodStartYear = 2016
        Mode.PeriodEndDay = 30
        Mode.PeriodEndMonth = 6
        Mode.PeriodEndYear = 2016
        Mode.PlannerType = plTimeLine
        Mode.TimeLineStart = 42544.000000000000000000
        Mode.TimeLineNVUBegin = 0
        Mode.TimeLineNVUEnd = 0
        Mode.Year = 2016
        ShadowColor = clSilver
        ShowHint = True
        Sidebar.Alignment = taCenter
        Sidebar.Border = False
        Sidebar.Font.Charset = DEFAULT_CHARSET
        Sidebar.Font.Color = clBlack
        Sidebar.Font.Height = -12
        Sidebar.Font.Name = 'Arial'
        Sidebar.Font.Style = [fsBold]
        Sidebar.HourFontRatio = 1.800000000000000000
        Sidebar.OccupiedTo = clWhite
        Sidebar.Position = spTop
        Sidebar.RotateOnTop = False
        Sidebar.ShowDayName = False
        Sidebar.TimeIndicator = True
        Sidebar.Width = 35
        Positions = 20
        PositionProps = <>
        PositionWidth = 30
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
        PrintOptions.Orientation = poLandscape
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
        OnEnter = PlannerEnter
        OnItemRightClick = PlannerItemRightClick
        OnItemSize = PlannerItemSize
        OnItemMove = PlannerItemMove
        OnItemSizing = PlannerItemSizing
        OnItemMoving = PlannerItemMoving
        OnItemStartEdit = PlannerItemStartEdit
        OnItemSelect = PlannerItemSelect
        OnPlannerRightClick = PlannerPlannerRightClick
        ItemSource = WeekRosterSource
        ExplicitLeft = 1
        ExplicitHeight = 369
      end
    end
    object TabMonthly: TTabSheet
      AlignWithMargins = True
      Hint = 
        'Planner is Read Only - Shows the Employee Roster, Scheduled Jobs' +
        '  and Employee Leaves'
      HelpContext = 1367023
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 1
      Caption = 'Monthly'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnEnter = PlannerEnter
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object PlannerMonth: TDBPlanner
        AlignWithMargins = True
        Left = 0
        Top = 1
        Width = 737
        Height = 110
        Hint = 
          'Planner is Read Only - Shows the Employee Roster, Scheduled Jobs' +
          '  and Employee Leaves'
        HelpContext = 1367024
        Margins.Left = 0
        Margins.Top = 1
        Margins.Right = 0
        Margins.Bottom = 1
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
        Caption.Title = '                                         Employee Schedule'
        Caption.Font.Charset = ANSI_CHARSET
        Caption.Font.Color = clWhite
        Caption.Font.Height = -24
        Caption.Font.Name = 'Arial'
        Caption.Font.Style = [fsBold]
        Caption.Background = clNavy
        Caption.BackgroundSteps = 32
        Caption.GradientDirection = gdVertical
        Color = clWhite
        DayNames.Strings = (
          'Sunday'
          'Monday'
          'Tuesday'
          'Wednesday'
          'Thursday'
          'Friday'
          'Saturday')
        DefaultItem.CaptionFont.Charset = DEFAULT_CHARSET
        DefaultItem.CaptionFont.Color = clWindowText
        DefaultItem.CaptionFont.Height = -11
        DefaultItem.CaptionFont.Name = 'Tahoma'
        DefaultItem.CaptionFont.Style = []
        DefaultItem.Cursor = -1
        DefaultItem.Font.Charset = DEFAULT_CHARSET
        DefaultItem.Font.Color = clWindowText
        DefaultItem.Font.Height = -11
        DefaultItem.Font.Name = 'Tahoma'
        DefaultItem.Font.Style = []
        DefaultItem.ItemBegin = 0
        DefaultItem.ItemEnd = 0
        DefaultItem.ItemPos = 0
        DefaultItem.Name = 'PlannerItem0'
        DefaultItem.Shape = psRounded
        DefaultItem.ShowDeleteButton = True
        DefaultItem.SelectColor = 11075496
        DefaultItem.SelectColorTo = 11075496
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
        DirectMove = True
        Display.ActiveStart = 0
        Display.ActiveEnd = 0
        Display.DisplayEnd = 28
        Display.DisplayScale = 12
        Display.ColorNonActive = clWhite
        Display.ColorCurrent = 15263999
        Display.ColorCurrentItem = clWhite
        EnableFlashing = True
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
        GridPopup = popPlanner
        GridLeftCol = 0
        GridTopRow = 1
        Header.AllowResize = True
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
          '')
        Header.CustomGroups = <>
        Header.Height = 102
        Header.Font.Charset = ANSI_CHARSET
        Header.Font.Color = clBlack
        Header.Font.Height = -11
        Header.Font.Name = 'Arial'
        Header.Font.Style = []
        Header.GroupFont.Charset = DEFAULT_CHARSET
        Header.GroupFont.Color = clWindowText
        Header.GroupFont.Height = -11
        Header.GroupFont.Name = 'MS Sans Serif'
        Header.GroupFont.Style = []
        Header.ItemHeight = 16
        Header.TextHeight = 100
        HintOnItemChange = False
        HourType = ht12hrs
        HTMLOptions.CellFontStyle = []
        HTMLOptions.HeaderFontStyle = []
        HTMLOptions.SidebarFontStyle = []
        ItemPopup = popupPlannerItem
        Items = <>
        Mode.Month = 6
        Mode.PeriodStartDay = 1
        Mode.PeriodStartMonth = 6
        Mode.PeriodStartYear = 2016
        Mode.PeriodEndDay = 30
        Mode.PeriodEndMonth = 6
        Mode.PeriodEndYear = 2016
        Mode.PlannerType = plWeek
        Mode.TimeLineStart = 42522.000000000000000000
        Mode.TimeLineNVUBegin = 0
        Mode.TimeLineNVUEnd = 0
        Mode.Year = 2016
        ShadowColor = clSilver
        ShowHint = True
        Sidebar.Alignment = taCenter
        Sidebar.Border = False
        Sidebar.Font.Charset = DEFAULT_CHARSET
        Sidebar.Font.Color = clBlack
        Sidebar.Font.Height = -12
        Sidebar.Font.Name = 'Arial'
        Sidebar.Font.Style = [fsBold]
        Sidebar.HourFontRatio = 1.800000000000000000
        Sidebar.OccupiedTo = clWhite
        Sidebar.Position = spTop
        Sidebar.RotateOnTop = False
        Sidebar.ShowDayName = False
        Sidebar.Width = 35
        Positions = 15
        PositionProps = <>
        PositionWidth = 30
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
        PrintOptions.Orientation = poLandscape
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
        OnEnter = PlannerEnter
        OnItemRightClick = PlannerItemRightClick
        OnItemSize = PlannerItemSize
        OnItemMove = PlannerItemMove
        OnItemSizing = PlannerItemSizing
        OnItemMoving = PlannerItemMoving
        OnItemStartEdit = PlannerItemStartEdit
        OnItemSelect = PlannerItemSelect
        OnPlannerRightClick = PlannerPlannerRightClick
        ItemSource = MonthRosterSource
      end
    end
  end
  inherited pnlright: TDNMPanel
    Left = 745
    Height = 154
    HelpContext = 1367025
    ExplicitLeft = 745
    ExplicitHeight = 154
    inherited grdResources: TwwDBGrid
      Top = 38
      Height = 115
      HelpContext = 1367026
      ExplicitTop = 38
      ExplicitHeight = 115
    end
    object grpFilters: TwwRadioGroup
      Left = 1
      Top = 1
      Width = 251
      Height = 37
      HelpContext = 1367016
      DisableThemes = False
      ItemIndex = 0
      Align = alTop
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Items.Strings = (
        'Both'
        'Allocation'
        'Schedule')
      ParentFont = False
      TabOrder = 1
      OnClick = grpFiltersClick
    end
  end
  inherited Memo1: TMemo
    Top = 228
    Width = 998
    HelpContext = 1367027
    ExplicitTop = 228
    ExplicitWidth = 998
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102009C02AC0210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited RosterSource: TDBDaySource
    SubjectField = 'Subject'
    Left = 184
    Top = 336
  end
  inherited dsRoster: TDataSourcePrefs
    Left = 184
    Top = 303
  end
  inherited QryRoster: TERPQuery
    SQL.Strings = ()
    Left = 252
    Top = 271
    object QryRosterSeqno: TIntegerField
      FieldName = 'Seqno'
    end
    object QryRosterLeaveID: TIntegerField
      FieldName = 'LeaveID'
    end
    object QryRosterupdateSeqno: TIntegerField
      FieldName = 'updateSeqno'
    end
    object QryRosterSaleID: TIntegerField
      FieldName = 'SaleID'
    end
    object QryRostersaleLineId: TIntegerField
      FieldName = 'saleLineId'
    end
    object QryRosterProductName: TWideStringField
      FieldName = 'ProductName'
      Size = 255
    end
    object QryRosterCustomerName: TWideStringField
      FieldName = 'CustomerName'
      Size = 255
    end
    object QryRostershipped: TFloatField
      FieldName = 'shipped'
    end
    object QryRosterUOM: TWideStringField
      FieldName = 'UOM'
      Size = 255
    end
    object QryRosterShipDate: TDateTimeField
      FieldName = 'ShipDate'
    end
    object QryRosterrosterId: TIntegerField
      FieldName = 'rosterId'
    end
    object QryRosterScheduleID: TIntegerField
      FieldName = 'ScheduleID'
    end
    object QryRosterProcessPartID: TIntegerField
      FieldName = 'ProcessPartID'
    end
    object QryRosterDescription: TWideStringField
      FieldName = 'Description'
      Size = 255
    end
    object QryRosterIsChanged: TWideStringField
      FieldName = 'IsChanged'
      FixedChar = True
      Size = 1
    end
    object QryRosterDeleted: TWideStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
    object QryRosterSubject: TWideStringField
      FieldName = 'Subject'
      Size = 255
    end
  end
  object dsMonthRoster: TDataSource
    DataSet = QryRoster
    Left = 221
    Top = 304
  end
  object MonthRosterSource: TDBWeekSource
    Active = False
    AutoIncKey = False
    DataSource = dsMonthRoster
    ResourceMap = <>
    StartTimeField = 'TimeFrom'
    EndTimeField = 'TimeTo'
    KeyField = 'PlannerId'
    ReadOnly = False
    ResourceField = 'EmployeeId'
    SubjectField = 'Subject'
    NotesField = 'Notes'
    UpdateByQuery = False
    OnFieldsToItem = RosterFieldsToItem
    OnItemToFields = RosterItemToField
    OnResourceToPosition = RosterSourceResourceToPosition
    OnPositionToResource = RosterSourcePositionToResource
    NumberOfResources = 20
    Month = 6
    Year = 2016
    WeekStart = 0
    Weeks = 4
    Left = 221
    Top = 336
  end
  object dsWeekRoster: TDataSource
    DataSet = QryRoster
    Left = 141
    Top = 304
  end
  object WeekRosterSource: TDBTimeLineSource
    AutoIncKey = False
    DataSource = dsWeekRoster
    ResourceMap = <>
    StartTimeField = 'TimeFrom'
    EndTimeField = 'TimeTo'
    KeyField = 'PlannerId'
    ReadOnly = False
    ResourceField = 'EmployeeId'
    SubjectField = 'Subject'
    NotesField = 'Notes'
    UpdateByQuery = False
    OnFieldsToItem = RosterFieldsToItem
    OnItemToFields = RosterItemToField
    OnResourceToPosition = RosterSourceResourceToPosition
    OnPositionToResource = RosterSourcePositionToResource
    NumberOfResources = 20
    StartDate = 42544.000000000000000000
    EndDate = 42547.000000000000000000
    Left = 140
    Top = 344
  end
end
