inherited CalendarGUI: TCalendarGUI
  Left = 271
  Top = 153
  HelpContext = 54000
  Caption = 'Appointments'
  ClientHeight = 530
  ClientWidth = 954
  Color = 16759737
  Font.Charset = DEFAULT_CHARSET
  Font.Style = []
  OldCreateOrder = True
  OnResize = FormResize
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 960
  ExplicitHeight = 558
  DesignSize = (
    954
    530)
  PixelsPerInch = 96
  TextHeight = 15
  object lblDatePicker1: TLabel [0]
    Left = 210
    Top = 5
    Width = 67
    Height = 18
    HelpContext = 54002
    AutoSize = False
    Caption = 'Date Select'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object lblTimeIncrement: TLabel [1]
    Left = 11
    Top = 5
    Width = 100
    Height = 18
    HelpContext = 54003
    AutoSize = False
    Caption = 'Time Increments'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object lblFromDate: TLabel [2]
    Left = 708
    Top = 5
    Width = 61
    Height = 18
    HelpContext = 54004
    AutoSize = False
    Caption = 'Date From'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
    WordWrap = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 530
    Width = 954
    HelpContext = 54025
    ExplicitTop = 570
    ExplicitWidth = 953
  end
  inherited shapehint: TShape
    Left = 90
    Top = 202
    ExplicitLeft = 90
    ExplicitTop = 202
  end
  inherited imgGridWatermark: TImage
    HelpContext = 54001
  end
  object lblAppointmentStatus: TLabel [6]
    Left = 457
    Top = 5
    Width = 115
    Height = 18
    HelpContext = 54037
    AutoSize = False
    Caption = 'Appointment Status'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object lblfilter: TLabel [7]
    Left = 12
    Top = 487
    Width = 928
    Height = 16
    HelpContext = 54026
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    ExplicitWidth = 925
  end
  inherited shapehintextra1: TShape
    Left = 130
    Top = 202
    ExplicitLeft = 130
    ExplicitTop = 202
  end
  object lstColorBox: TListBox [10]
    Left = 548
    Top = 75
    Width = 96
    Height = 29
    HelpContext = 54019
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 12845252
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 15
    Items.Strings = (
      'clRed'
      'clBlue'
      'clBlack'
      '$0000C6FF'
      '$0044C100'
      '$00C400C4'
      'clMaroon'
      'clMoneyGreen'
      '$007D7DFF'
      '$00FFA4A4'
      '$00AAECFF'
      '$00A4A444'
      'clOlive'
      'clNavy'
      'clPurple'
      'clSilver'
      '$00D28B6C'
      '$00DDDDAC'
      'clTeal'
      'clGreen'
      'clGray'
      'clAqua'
      'clLime'
      'clYellow')
    ParentFont = False
    TabOrder = 5
    Visible = False
  end
  object btnCustomize: TDNMSpeedButton [11]
    Left = 535
    Top = 493
    Width = 87
    Height = 27
    HelpContext = 54020
    Anchors = [akBottom]
    Caption = 'C&ustomise'
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
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnCustomizeClick
  end
  object DatePicker1: TwwDBDateTimePicker [12]
    Left = 283
    Top = 2
    Width = 158
    Height = 23
    HelpContext = 54021
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    CalendarAttributes.PopupYearOptions.NumberColumns = 4
    Epoch = 1950
    ButtonWidth = 16
    ShowButton = True
    TabOrder = 6
    UnboundDataType = wwDTEdtDate
    OnCloseUp = DatePicker1CloseUp
    OnChange = DatePicker1Change
    OnEnter = DatePicker1Enter
  end
  object dtpFromDate: TwwDBDateTimePicker [13]
    Left = 770
    Top = 3
    Width = 161
    Height = 23
    HelpContext = 54022
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    Epoch = 1950
    ButtonWidth = 16
    ShowButton = True
    TabOrder = 7
    UnboundDataType = wwDTEdtDate
    Visible = False
    OnChange = dtpFromDateChange
  end
  object btnHolidays: TDNMSpeedButton [14]
    Left = 331
    Top = 493
    Width = 87
    Height = 27
    HelpContext = 54023
    Anchors = [akBottom]
    Caption = '&Holidays'
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
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = btnHolidaysClick
  end
  object cmdClose: TDNMSpeedButton [15]
    Left = 739
    Top = 493
    Width = 87
    Height = 27
    HelpContext = 54024
    Anchors = [akBottom]
    Cancel = True
    Caption = '&Close'
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
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = cmdCloseClick
  end
  object cmdMedia: TDNMSpeedButton [16]
    Left = 127
    Top = 493
    Width = 87
    Height = 27
    HelpContext = 54006
    Anchors = [akBottom]
    Caption = '&Source List'
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
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = cmdMediaClick
  end
  object cmdPrint: TDNMSpeedButton [17]
    Left = 433
    Top = 493
    Width = 87
    Height = 27
    HelpContext = 54005
    Anchors = [akBottom]
    Caption = '&Print'
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
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = cmdPrintClick
  end
  object cboFollowUpResult: TwwDBLookupCombo [18]
    Left = 578
    Top = 3
    Width = 124
    Height = 23
    HelpContext = 54027
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'Name'#9'30'#9'Name'#9'F')
    LookupTable = qryStatusType
    LookupField = 'Name'
    Style = csDropDownList
    ParentFont = False
    TabOrder = 9
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = cboFollowUpResultCloseUp
  end
  object btnRequery: TDNMSpeedButton [19]
    Left = 229
    Top = 493
    Width = 87
    Height = 27
    HelpContext = 54028
    Anchors = [akBottom]
    Caption = 'Refresh'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    ParentFont = False
    TabOrder = 11
    OnClick = btnRequeryClick
  end
  object pnlMain: TDNMPanel [20]
    Left = 8
    Top = 32
    Width = 929
    Height = 447
    HelpContext = 54029
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 927
      Height = 445
      HelpContext = 54007
      ActivePage = TabSheet2
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      RaggedRight = True
      TabHeight = 24
      TabOrder = 0
      TabStop = False
      TabWidth = 307
      OnChange = PageControl1Change
      OnChanging = PageControl1Changing
      object TabSheet1: TTabSheet
        HelpContext = 54008
        Caption = '&Day Mode'
        object DBPlanner1: TDBPlanner
          Left = 0
          Top = 0
          Width = 919
          Height = 411
          HelpContext = 54009
          ActiveDisplay = True
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
          Caption.Title = 'Daily Appointments'
          Caption.Font.Charset = DEFAULT_CHARSET
          Caption.Font.Color = clWhite
          Caption.Font.Height = -13
          Caption.Font.Name = 'MS Sans Serif'
          Caption.Font.Style = [fsBold]
          Caption.Alignment = taCenter
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
          DefaultItem.CaptionType = ctTime
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
          DefaultItem.SelectColor = clWhite
          DefaultItem.SelectColorTo = clInfoBk
          DefaultItem.Shadow = True
          DefaultItem.TrackColor = clBlack
          DefaultItem.TrackLinkColor = clMaroon
          DefaultItem.TrackSelectColor = clBlack
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
          Display.CurrentPosFrom = 804940
          Display.CurrentPosTo = 804959
          Display.DisplayScale = 19
          Display.ColorCurrent = 8978431
          Display.ColorCurrentItem = clRed
          Display.ShowCurrent = True
          Display.ShowCurrentItem = True
          DragItem = True
          EditDirect = True
          EnableAlarms = True
          EnableFlashing = True
          FlashFontColor = clBlue
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Footer.Alignment = taCenter
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
          Footer.CompletionType = ctActiveTime
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
          GridTopRow = 4
          Header.Alignment = taCenter
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
            '')
          Header.CustomGroups = <>
          Header.DragDrop = True
          Header.Height = 47
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clBlack
          Header.Font.Height = -12
          Header.Font.Name = 'Arial'
          Header.Font.Style = [fsBold]
          Header.GroupFont.Charset = DEFAULT_CHARSET
          Header.GroupFont.Color = clWindowText
          Header.GroupFont.Height = -11
          Header.GroupFont.Name = 'MS Sans Serif'
          Header.GroupFont.Style = []
          Header.GroupCaptions.Strings = (
            '30/12/1899')
          Header.ItemColor = clWhite
          Header.ItemHeight = 90
          Header.TextHeight = 45
          HintPause = 3000
          HourType = ht12hrs
          HTMLOptions.CellFontStyle = []
          HTMLOptions.HeaderFontStyle = []
          HTMLOptions.SidebarFontStyle = []
          InActiveDays.Sat = False
          ItemGap = 1
          Items = <>
          Mode.Month = 4
          Mode.PeriodStartDay = 4
          Mode.PeriodStartMonth = 4
          Mode.PeriodStartYear = 2002
          Mode.PeriodEndDay = 22
          Mode.PeriodEndMonth = 5
          Mode.PeriodEndYear = 2002
          Mode.TimeLineStart = 37991.000000000000000000
          Mode.TimeLineNVUBegin = 0
          Mode.TimeLineNVUEnd = 0
          Mode.Year = 2002
          MultiSelect = True
          ShadowColor = clSilver
          ShowHint = True
          Sidebar.Alignment = taCenter
          Sidebar.DateTimeFormat = 'hh:mm AM/PM'
          Sidebar.Font.Charset = DEFAULT_CHARSET
          Sidebar.Font.Color = clBlack
          Sidebar.Font.Height = -11
          Sidebar.Font.Name = 'Arial'
          Sidebar.Font.Style = []
          Sidebar.HourFontRatio = 1.700000000000000000
          Sidebar.OccupiedTo = clWhite
          Sidebar.RotateOnTop = False
          Sidebar.Width = 45
          Positions = 20
          PositionGroup = 20
          PositionProps = <>
          PositionWidth = 43
          PrintOptions.CellWidth = 20
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
          PrintOptions.Orientation = poLandscape
          ScrollSmooth = True
          ScrollBarStyle.Style = ssEncarta
          ShowDesignHelper = False
          TrackBump = True
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
          OnEndDrag = DBPlanner1EndDrag
          OnItemDblClick = DBPlanner1ItemDblClick
          OnItemMove = DBPlanner1ItemMove
          OnItemHint = DBPlanner1ItemHint
          OnPlannerDblClick = DBPlanner1PlannerDblClick
          OnPlannerSideDrawAfter = DBPlanner2PlannerSideDrawAfter
          OnPlannerBkgDraw = DBPlanner2PlannerBkgDraw
          OnPlannerNext = DBPlanner1PlannerNext
          OnPlannerPrev = DBPlanner1PlannerPrev
          OnDragDrop = DBPlanner1DragDrop
          OnDragDropCell = DBPlanner1DragDropCell
          OnDragDropHeader = DBPlanner1DragDropHeader
          OnDragDropItem = DBPlanner1DragDropItem
          Skin.SkinCaptionX = 4
          Skin.SkinX = 4
          Skin.SkinY = 4
          ItemSource = DBDaySource1
        end
      end
      object TabSheet2: TTabSheet
        HelpContext = 54010
        Caption = '&Week Mode'
        ImageIndex = 1
        DesignSize = (
          919
          411)
        object Label3: TLabel
          Left = 773
          Top = 360
          Width = 56
          Height = 28
          HelpContext = 54011
          Alignment = taCenter
          Anchors = [akRight, akBottom]
          Caption = 'Day Mode Widths'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
          ExplicitLeft = 772
          ExplicitTop = 383
        end
        object Label5: TLabel
          Left = 851
          Top = 360
          Width = 68
          Height = 28
          HelpContext = 54012
          Alignment = taCenter
          Anchors = [akRight, akBottom]
          Caption = 'Week Mode Widths'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
          ExplicitLeft = 850
          ExplicitTop = 383
        end
        object DBPlanner2: TDBPlanner
          Left = 0
          Top = 0
          Width = 766
          Height = 411
          HelpContext = 54013
          ActiveDisplay = True
          Align = alLeft
          AttachementGlyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            8888888888700078888888888708880788888888808808808888888880808080
            8888888880808080888888888080808088888888808080808888888880808080
            8888888880808080888888888080808088888888808080808888888888808080
            8888888888808880888888888888000888888888888888888888}
          Anchors = [akLeft, akTop, akRight, akBottom]
          Caption.Title = 'Daily Appointments'
          Caption.Font.Charset = DEFAULT_CHARSET
          Caption.Font.Color = clWhite
          Caption.Font.Height = -13
          Caption.Font.Name = 'MS Sans Serif'
          Caption.Font.Style = [fsBold]
          Caption.BackgroundSteps = 32
          Caption.Visible = False
          Color = clWhite
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
          DefaultItem.CaptionType = ctTime
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
          DefaultItem.SelectColor = clWhite
          DefaultItem.SelectColorTo = clInfoBk
          DefaultItem.Shadow = True
          DefaultItem.TrackColor = clBlack
          DefaultItem.TrackLinkColor = clMaroon
          DefaultItem.TrackSelectColor = clBlack
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
          Display.CurrentPosFrom = 804940
          Display.CurrentPosTo = 804959
          Display.DisplayScale = 18
          Display.ColorCurrent = 8978431
          Display.ColorCurrentItem = clRed
          Display.ShowCurrent = True
          Display.ShowCurrentItem = True
          DragItem = True
          EditDirect = True
          EnableAlarms = True
          EnableFlashing = True
          FlashFontColor = clBlue
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
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
          GridTopRow = 0
          GroupGapOnly = True
          Header.Alignment = taCenter
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
          Header.Height = 49
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clBlack
          Header.Font.Height = -12
          Header.Font.Name = 'Arial'
          Header.Font.Style = [fsBold]
          Header.GroupFont.Charset = DEFAULT_CHARSET
          Header.GroupFont.Color = clWindowText
          Header.GroupFont.Height = -11
          Header.GroupFont.Name = 'MS Sans Serif'
          Header.GroupFont.Style = []
          Header.GroupCaptions.Strings = (
            '30/12/1899'
            '31/12/1899'
            '01/01/1900'
            '02/01/1900'
            '03/01/1900'
            '04/01/1900'
            '05/01/1900')
          Header.ItemColor = clWhite
          Header.ItemHeight = 0
          Header.TextHeight = 47
          Header.VAlignment = vtaTop
          HintPause = 3000
          HourType = ht12hrs
          HTMLOptions.CellFontStyle = []
          HTMLOptions.HeaderFontStyle = []
          HTMLOptions.SidebarFontStyle = []
          InActiveDays.Sat = False
          ItemGap = 1
          Items = <>
          Mode.Month = 4
          Mode.PeriodStartDay = 4
          Mode.PeriodStartMonth = 4
          Mode.PeriodStartYear = 2002
          Mode.PeriodEndDay = 22
          Mode.PeriodEndMonth = 5
          Mode.PeriodEndYear = 2002
          Mode.TimeLineStart = 37991.000000000000000000
          Mode.TimeLineNVUBegin = 0
          Mode.TimeLineNVUEnd = 0
          Mode.Year = 2002
          MultiSelect = True
          ShadowColor = clSilver
          ShowHint = True
          Sidebar.Alignment = taRightJustify
          Sidebar.DateTimeFormat = 'hh:mm AM/PM'
          Sidebar.Font.Charset = DEFAULT_CHARSET
          Sidebar.Font.Color = clBlack
          Sidebar.Font.Height = -11
          Sidebar.Font.Name = 'Arial'
          Sidebar.Font.Style = []
          Sidebar.HourFontRatio = 1.700000000000000000
          Sidebar.OccupiedTo = clWhite
          Sidebar.Width = 45
          Positions = 140
          PositionGroup = 20
          PositionProps = <>
          PositionWidth = 5
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
          PrintOptions.Orientation = poLandscape
          ScrollSmooth = True
          ScrollBarStyle.Style = ssEncarta
          TrackBump = True
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
          OnItemDblClick = DBPlanner1ItemDblClick
          OnItemMove = DBPlanner2ItemMove
          OnItemHint = DBPlanner2ItemHint
          OnPlannerDblClick = DBPlanner1PlannerDblClick
          OnPlannerSideDrawAfter = DBPlanner2PlannerSideDrawAfter
          OnPlannerBkgDraw = DBPlanner2PlannerBkgDraw
          OnPlannerNext = DBPlanner2PlannerNext
          OnPlannerPrev = DBPlanner2PlannerPrev
          Skin.SkinTop.Data = {
            560A0000424D560A000000000000360000002800000024000000180000000100
            180000000000200A0000C30E0000C30E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFFB0ABFFACA9FFB0ADFFAFACFFB0ADFFB1AEFFB0ADFFAFACFFB1
            AEFFAFACFFAFACFFAFACFFAFACFFAFACFFAFACFFAFACFFAFACFFAFACFFAFACFF
            AFACFFAFACFFAFACFFB0ADFFB0ADFFB0ADFFB0ADFFB0ADFFB0ADFFB0ADFFB0AD
            FFB0ADFFB0A2FFACA7FFB1B2FFADAEFFB0ABFFC6C2FFC9C6FFCDCAFFCAC7FFCA
            C7FFCAC7FFCBC8FFCBC8FFCBC8FFCBC8FFCBC8FFCBC8FFCBC8FFCBC8FFCBC8FF
            CBC8FFCBC8FFCBC8FFCBC8FFCBC8FFCBC8FFCBC8FFCAC7FFCAC7FFCBC8FFCBC8
            FFCBC8FFCBC8FFCBC8FFCBC8FFCBC8FFD3CBFFCCC8FFC6C4FFCDC9FFC5BEFFCD
            C9FFD0CDFFCFCCFFCDCAFFCBC8FFCAC7FFCBC8FFCCC9FFCCC9FFCCC9FFCCC9FF
            CCC9FFCCC9FFCCC9FFCCC9FFCCC9FFCCC9FFCCC9FFCCC9FFCCC9FFCCC9FFCCC9
            FFCECBFFCECBFFCCC9FFCCC9FFCCC9FFCCC9FFCCC9FFCCC9FFCCC9FFCBCBFFCA
            CAFFCCC7FFCFC6FFCEC7FFCAC6FFCCC9FFC8C5FFCFCCFFCDCAFFCBC8FFCCC9FF
            CCC9FFCCC9FFCCC9FFCCC9FFCCC9FFCDCAFFCDCAFFCDCAFFCDCAFFCDCAFFCDCA
            FFCDCAFFCDCAFFCCC9FFCCC9FFCCC9FFCCC9FFCDCAFFCDCAFFCDCAFFCDCAFFCD
            CAFFCDCAFFCDCAFFC9CBFFCBCBFFCBC8FFD2CDFFCCC5FFCDC9FFD4D1FFD3D0FF
            CFCCFFD1CEFFCFCCFFD1CEFFD1CEFFD1CEFFD1CEFFD1CEFFD1CEFFCFCCFFCFCC
            FFCFCCFFCFCCFFCFCCFFCFCCFFCFCCFFCFCCFFD1CEFFD1CEFFD1CEFFD1CEFFD0
            CDFFD0CDFFD0CDFFD0CDFFD0CDFFD0CDFFD0CDFFCFCBFFD0D0FFCFCFFFCFD0FF
            CFC8FFCFCBFFD5D2FFD2CFFFCFCCFFD6D3FFD6D3FFD3D0FFD3D0FFD3D0FFD3D0
            FFD3D0FFD3D0FFD4D1FFD4D1FFD4D1FFD4D1FFD4D1FFD4D1FFD4D1FFD4D1FFD3
            D0FFD3D0FFD3D0FFD3D0FFD5D2FFD5D2FFD5D2FFD5D2FFD5D2FFD5D2FFD5D2FF
            D6CEFFD0CEFFD2D4FFD1CFFFD5CEFFD2CEFFD4D1FFC6C3FFC8C5FFD5D2FFD7D4
            FFD6D3FFD6D3FFD6D3FFD6D3FFD6D3FFD6D3FFD5D2FFD5D2FFD5D2FFD5D2FFD5
            D2FFD5D2FFD5D2FFD5D2FFD6D3FFD6D3FFD6D3FFD6D3FFD5D2FFD5D2FFD5D2FF
            D5D2FFD5D2FFD5D2FFD5D2FFDAD0FFC5C6FFC4C6FFD8CFFFD8D1FFDBD7FFDDDA
            FFC9C6FFC8C5FFD9D6FFDDDAFFDBD8FFDBD8FFDBD8FFDBD8FFDBD8FFDBD8FFDB
            D8FFDBD8FFDBD8FFDBD8FFDBD8FFDBD8FFDBD8FFDBD8FFDBD8FFDBD8FFDBD8FF
            DBD8FFDBD8FFDBD8FFDBD8FFDBD8FFDBD8FFDBD8FFDBD8FFDDD0FFC4C6FFCBCC
            FFE3D0FFDBD4FFE1DCFFE0DDFFE0E0FFE0DDFFE0DDFFDCD9FFDFDCFFDFDCFFDF
            DCFFDFDCFFDFDCFFDFDCFFDFDCFFDFDCFFDFDCFFDFDCFFDFDCFFDFDCFFDFDCFF
            DFDCFFDFDCFFDFDCFFDFDCFFDFDCFFDFDCFFDFDCFFDFDCFFDFDCFFDFDCFFDFDC
            FFDFDCFFE3DEFFDCD9FFE2D5FFDADCFFE1DAFFE5E0FFDEDBFFDDDDFFDEDBFFDE
            DBFFE2DFFFE1DEFFE1DEFFE1DEFFE1DEFFE1DEFFE1DEFFE2DFFFE2DFFFE2DFFF
            E2DFFFE2DFFFE2DFFFE2DFFFE2DFFFE1DEFFE1DEFFE1DEFFE1DEFFE1DEFFE1DE
            FFE1DEFFE1DEFFE1DEFFE1DEFFE1DEFFE1DEFFDEDDFFE3D8FFE2E4FFE3DCFFE6
            E1FFE5E2FFE8E8FFEAE7FFE6E3FFE5E2FFE5E2FFE5E2FFE5E2FFE5E2FFE5E2FF
            E5E2FFE5E2FFE5E2FFE5E2FFE5E2FFE5E2FFE5E2FFE5E2FFE5E2FFE5E2FFE5E2
            FFE5E2FFE5E2FFE5E2FFE5E2FFE5E2FFE5E2FFE5E2FFE5E2FFE5E2FFE4E5FFE9
            E9FFE9E0FFE4E4FFE5DEFFEAE5FFEBE8FFE4E4FFE7E4FFEBE8FFEAE7FFE9E6FF
            E9E6FFE9E6FFE9E6FFE9E6FFE9E6FFE9E6FFE9E6FFE9E6FFE9E6FFE9E6FFE9E6
            FFE9E6FFE9E6FFE9E6FFE9E6FFE9E6FFE9E6FFE9E6FFE9E6FFE9E6FFE9E6FFE9
            E6FFE9E6FFE9E6FFE7EAFFE9E9FFE7E2FFEAE8FFE9E2FFF1ECFFEBE8FFCECEFF
            D0CDFFE9E6FFF0EDFFECE9FFECE9FFECE9FFECE9FFECE9FFECE9FFECE9FFECE9
            FFECE9FFECE9FFECE9FFECE9FFECE9FFECE9FFECE9FFECE9FFECE9FFECE9FFEC
            E9FFECE9FFECE9FFECE9FFECE9FFECE9FFECE9FFE8EBFFD3D2FFD2D2FFEDEAFF
            EDE6FFF2EDFFF0EDFFD5D5FFD6D3FFEDEAFFF2EFFFEFECFFEFECFFEFECFFEFEC
            FFEFECFFEFECFFEFECFFEFECFFEFECFFEFECFFEFECFFEFECFFEFECFFEFECFFEF
            ECFFEFECFFEFECFFEFECFFEFECFFEFECFFEFECFFEFECFFEFECFFEFECFFEFECFF
            EFF0FFD5D0FFD5D6FFEDEAFFF0E9FFF1ECFFF7F4FFEFEFFFF1EEFFF3F0FFF2EF
            FFF2EFFFF2EFFFF2EFFFF2EFFFF2EFFFF2EFFFF3F0FFF3F0FFF3F0FFF3F0FFF3
            F0FFF3F0FFF3F0FFF3F0FFF2EFFFF2EFFFF2EFFFF2EFFFF2EFFFF2EFFFF2EFFF
            F2EFFFF2EFFFF2EFFFF2EFFFF9F4FFEFE7FFEEF1FFF6F2FFF3ECFFF3EEFFF4F1
            FFF5F5FFF8F5FFF1EEFFF4F1FFF5F2FFF5F2FFF5F2FFF5F2FFF5F2FFF5F2FFF5
            F2FFF5F2FFF5F2FFF5F2FFF5F2FFF5F2FFF5F2FFF5F2FFF5F2FFF5F2FFF5F2FF
            F5F2FFF5F2FFF5F2FFF5F2FFF5F2FFF5F2FFF5F2FFF5F2FFF9F2FFF7EEFFF5F8
            FFF3EFFFF4EDFFF6F3FFF4F1FFFBFAFFF9F6FFF4F1FFF5F2FFF6F3FFF6F3FFF6
            F3FFF6F3FFF6F3FFF6F3FFF6F3FFF6F3FFF6F3FFF6F3FFF6F3FFF6F3FFF6F3FF
            F6F3FFF6F3FFF6F3FFF6F3FFF6F3FFF6F3FFF6F3FFF6F3FFF6F3FFF6F3FFF6F3
            FFF6F3FFF6F3FFF8F5FFF9F6FFF9F6FFF7F0FFFAF7FFFBF8FFF3F2FFF4F1FFFB
            F8FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FF
            F7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4
            FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFFAF7FFF7F4FFF0EDFFFBF4FFFC
            F7FFF8F5FFD7D4FFD9D6FFF6F3FFFAF7FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FF
            F8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5
            FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF5F4FFD8
            D7FFD5D4FFFBFAFFFCF5FFF4EFFFF8F3FFD7D4FFD7D4FFF5F2FFFBF8FFF7F4FF
            F7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4
            FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7F4FFF7
            F4FFF7F4FFF7F4FFF9F8FFDDDCFFD5D4FFF6F5FFF2EBFFE5E0FFFEF9FFF9F4FF
            F5F2FFFBF8FFF7F4FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5
            FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8
            F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF4F3FFF4F3FFF7F6FFFAF9FF
            E1DAFFD9D2FFF1EAFFFAF3FFFCF7FFF9F4FFF5F0FFF8F3FFF9F4FFF8F3FFFAF5
            FFF5F0FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9
            F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FF
            F9F6FFF8F5FFF8F5FFF5F2FFD5CEFF00FFFFDCD5FFDFD8FFF5F0FFF8F3FFF9F4
            FFFCF7FFFAF5FFF7F2FFFAF5FFF9F4FFF8F3FFF8F3FFF8F3FFF8F3FFF8F3FFF8
            F3FFF8F3FFF8F3FFF8F3FFF8F3FFF8F3FFF8F3FFF8F3FFF8F3FFF8F3FFF8F3FF
            F8F3FFF8F3FFF8F3FFF8F3FFFCF7FFF6F1FFE3DEFFD5D0FF00FF}
          Skin.SkinCenter.Data = {
            46050000424D46050000000000003600000028000000240000000C0000000100
            18000000000010050000C30E0000C30E00000000000000000000B6B0ABECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4B6B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0
            ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4B6B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0ABECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6
            B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0ABECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4B6B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0
            ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4B6B0AB}
          Skin.SkinBottom.Data = {
            6E040000424D6E040000000000003600000028000000240000000A0000000100
            18000000000038040000C30E0000C30E00000000000000000000FF00FFBDB7B2
            B7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1
            ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7
            B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1AC
            B7B1ACFF00FFB6B0ABBDB7B2ECE7E4ECE7E4ECE7E4ECE7E4EEE7E4EEE7E4EEE7
            E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EE
            E7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4
            EEE7E4EEE7E4EEE7E4EEE7E4BDB7B2B6B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0
            ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4B6B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0ABECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6
            B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0ABECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4B6B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6B0AB}
          Skin.SkinSelectTop.Data = {
            560A0000424D560A000000000000360000002800000024000000180000000100
            180000000000200A0000C30E0000C30E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFB6B0ABB5ACA9B9B0ADB8AFACB9B0ADBAB1AEB9B0ADB8AFACBAB1
            AEB8AFACB8AFACB8AFACB8AFACB8AFACB8AFACB8AFACB8AFACB8AFACB8AFACB8
            AFACB8AFACB8AFACB9B0ADB9B0ADB9B0ADB9B0ADB9B0ADB9B0ADB9B0ADB9B0AD
            B9B0ADB3B0A2BFACA7C3B1B2B2ADAEB6B0ABCFC6C2D2C9C6D6CDCAD3CAC7D3CA
            C7D3CAC7D4CBC8D4CBC8D4CBC8D4CBC8D4CBC8D4CBC8D4CBC8D4CBC8D4CBC8D4
            CBC8D4CBC8D4CBC8D4CBC8D4CBC8D4CBC8D4CBC8D3CAC7D3CAC7D4CBC8D4CBC8
            D4CBC8D4CBC8D4CBC8D4CBC8D4CBC8D6D3CBD8CCC8D2C6C4CCCDC9CDC5BED6CD
            C9D9D0CDD8CFCCD6CDCAD4CBC8D3CAC7D4CBC8D5CCC9D5CCC9D5CCC9D5CCC9D5
            CCC9D5CCC9D5CCC9D5CCC9D5CCC9D5CCC9D5CCC9D5CCC9D5CCC9D5CCC9D5CCC9
            D7CECBD7CECBD5CCC9D5CCC9D5CCC9D5CCC9D5CCC9D5CCC9D5CCC9D3CBCBD4CA
            CAD0CCC7CCCFC6D6CEC7D3CAC6D5CCC9D1C8C5D8CFCCD6CDCAD4CBC8D5CCC9D5
            CCC9D5CCC9D5CCC9D5CCC9D5CCC9D6CDCAD6CDCAD6CDCAD6CDCAD6CDCAD6CDCA
            D6CDCAD6CDCAD5CCC9D5CCC9D5CCC9D5CCC9D6CDCAD6CDCAD6CDCAD6CDCAD6CD
            CAD6CDCAD6CDCAD4C9CBD3CBCBD2CBC8D6D2CDD4CCC5D6CDC9DDD4D1DCD3D0D8
            CFCCDAD1CED8CFCCDAD1CEDAD1CEDAD1CEDAD1CEDAD1CEDAD1CED8CFCCD8CFCC
            D8CFCCD8CFCCD8CFCCD8CFCCD8CFCCD8CFCCDAD1CEDAD1CEDAD1CEDAD1CED9D0
            CDD9D0CDD9D0CDD9D0CDD9D0CDD9D0CDD9D0CDDBCFCBDCD0D0DBCFCFDDCFD0D7
            CFC8D8CFCBDED5D2DBD2CFD8CFCCDFD6D3DFD6D3DCD3D0DCD3D0DCD3D0DCD3D0
            DCD3D0DCD3D0DDD4D1DDD4D1DDD4D1DDD4D1DDD4D1DDD4D1DDD4D1DDD4D1DCD3
            D0DCD3D0DCD3D0DCD3D0DED5D2DED5D2DED5D2DED5D2DED5D2DED5D2DED5D2E1
            D6CEDDD0CEE0D2D4E0D1CFDDD5CEDBD2CEDDD4D1CFC6C3D1C8C5DED5D2E0D7D4
            DFD6D3DFD6D3DFD6D3DFD6D3DFD6D3DFD6D3DED5D2DED5D2DED5D2DED5D2DED5
            D2DED5D2DED5D2DED5D2DFD6D3DFD6D3DFD6D3DFD6D3DED5D2DED5D2DED5D2DE
            D5D2DED5D2DED5D2DED5D2E4DAD0D3C5C6CFC4C6DFD8CFE0D8D1E4DBD7E6DDDA
            D2C9C6D1C8C5E2D9D6E6DDDAE4DBD8E4DBD8E4DBD8E4DBD8E4DBD8E4DBD8E4DB
            D8E4DBD8E4DBD8E4DBD8E4DBD8E4DBD8E4DBD8E4DBD8E4DBD8E4DBD8E4DBD8E4
            DBD8E4DBD8E4DBD8E4DBD8E4DBD8E4DBD8E4DBD8E4DBD8E5DDD0D1C4C6D0CBCC
            DDE3D0E3DBD4E7E1DCE7E0DDE8E0E0E9E0DDE9E0DDE5DCD9E6DFDCE6DFDCE6DF
            DCE6DFDCE6DFDCE6DFDCE8DFDCE8DFDCE8DFDCE8DFDCE8DFDCE8DFDCE8DFDCE8
            DFDCE6DFDCE6DFDCE6DFDCE6DFDCE6DFDCE6DFDCE6DFDCE6DFDCE6DFDCE6DFDC
            E6DFDCE6E3DEE3DCD9EAE2D5E7DADCE9E1DAEBE5E0E5DEDBE5DDDDE7DEDBE7DE
            DBEBE2DFE8E1DEE8E1DEE8E1DEE8E1DEE8E1DEE8E1DEEBE2DFEBE2DFEBE2DFEB
            E2DFEBE2DFEBE2DFEBE2DFEBE2DFE8E1DEE8E1DEE8E1DEE8E1DEE8E1DEE8E1DE
            E8E1DEE8E1DEE8E1DEE8E1DEE8E1DEE6E1DEE3DEDDE9E3D8EFE2E4EBE3DCECE6
            E1ECE5E2F0E8E8F1EAE7EDE6E3ECE5E2ECE5E2ECE5E2ECE5E2ECE5E2ECE5E2EC
            E5E2ECE5E2ECE5E2ECE5E2ECE5E2ECE5E2ECE5E2ECE5E2ECE5E2ECE5E2ECE5E2
            ECE5E2ECE5E2ECE5E2ECE5E2ECE5E2ECE5E2ECE5E2ECE5E2ECE5E2ECE4E5EBE9
            E9F0E9E0F0E4E4EDE5DEF0EAE5F2EBE8ECE4E4EEE7E4F2EBE8F1EAE7F0E9E6F0
            E9E6F0E9E6F0E9E6F0E9E6F0E9E6F0E9E6F0E9E6F0E9E6F0E9E6F0E9E6F0E9E6
            F0E9E6F0E9E6F0E9E6F0E9E6F0E9E6F0E9E6F0E9E6F0E9E6F0E9E6F0E9E6F0E9
            E6F0E9E6F0E9E6F0E7EAE9E9E9EDE7E2F6EAE8F1E9E2F7F1ECF2EBE8D6CECED7
            D0CDF0E9E6F7F0EDF3ECE9F3ECE9F3ECE9F3ECE9F3ECE9F3ECE9F3ECE9F3ECE9
            F3ECE9F3ECE9F3ECE9F3ECE9F3ECE9F3ECE9F3ECE9F3ECE9F3ECE9F3ECE9F3EC
            E9F3ECE9F3ECE9F3ECE9F3ECE9F3ECE9F3ECE9F1E8EBD5D3D2DAD2D2F6EDEAF5
            EDE6F8F2EDF7F0EDDDD5D5DDD6D3F4EDEAF9F2EFF4EFECF4EFECF4EFECF4EFEC
            F4EFECF4EFECF6EFECF6EFECF6EFECF6EFECF6EFECF6EFECF6EFECF6EFECF4EF
            ECF4EFECF4EFECF4EFECF4EFECF4EFECF4EFECF4EFECF4EFECF4EFECF4EFECF4
            EFF0DBD5D0DDD5D6F2EDEAF8F0E9F7F1ECFEF7F4F7EFEFF8F1EEFAF3F0F9F2EF
            F7F2EFF7F2EFF7F2EFF7F2EFF7F2EFF7F2EFFAF3F0FAF3F0FAF3F0FAF3F0FAF3
            F0FAF3F0FAF3F0FAF3F0F7F2EFF7F2EFF7F2EFF7F2EFF7F2EFF7F2EFF7F2EFF7
            F2EFF7F2EFF7F2EFF7F2EFF5F9F4FCEFE7F9EEF1F9F6F2FBF3ECF9F3EEFBF4F1
            FDF5F5FFF8F5F8F1EEFBF4F1FAF5F2FAF5F2FAF5F2FAF5F2FAF5F2FAF5F2FCF5
            F2FCF5F2FCF5F2FCF5F2FCF5F2FCF5F2FCF5F2FCF5F2FAF5F2FAF5F2FAF5F2FA
            F5F2FAF5F2FAF5F2FAF5F2FAF5F2FAF5F2FAF5F2FAF5F2F2F9F2FFF7EEFFF5F8
            F4F3EFFCF4EDFDF6F3F9F4F1FFFBFAFEF9F6F9F4F1FAF5F2FBF6F3FBF6F3FBF6
            F3FBF6F3FBF6F3FBF6F3FBF6F3FBF6F3FBF6F3FBF6F3FBF6F3FBF6F3FBF6F3FB
            F6F3FBF6F3FBF6F3FBF6F3FBF6F3FBF6F3FBF6F3FBF6F3FBF6F3FBF6F3FBF6F3
            FBF6F3FBF6F3FDF8F5FEF9F6FEF9F6FFF7F0FFFAF7FFFBF8F8F3F2F9F4F1FFFB
            F8FCF7F4FCF7F4FCF7F4FCF7F4FCF7F4FCF7F4FCF7F4FCF7F4FCF7F4FCF7F4FC
            F7F4FCF7F4FCF7F4FCF7F4FCF7F4FCF7F4FCF7F4FCF7F4FCF7F4FCF7F4FCF7F4
            FCF7F4FCF7F4FCF7F4FCF7F4FCF7F4FCF7F4FFFAF7FCF7F4F5F0EDFFFBF4FFFC
            F7FFF8F5DED7D4DED9D6FBF6F3FFFAF7FDF8F5FDF8F5FDF8F5FDF8F5FDF8F5FD
            F8F5FDF8F5FDF8F5FDF8F5FDF8F5FDF8F5FDF8F5FDF8F5FDF8F5FDF8F5FDF8F5
            FDF8F5FDF8F5FDF8F5FDF8F5FDF8F5FDF8F5FDF8F5FDF8F5FDF8F5FAF5F4DDD8
            D7DAD5D4FFFBFAFFFCF5FAF4EFFEF8F3DED7D4DCD7D4FAF5F2FFFBF8FEF7F4FE
            F7F4FEF7F4FEF7F4FEF7F4FEF7F4FEF7F4FEF7F4FEF7F4FEF7F4FEF7F4FEF7F4
            FEF7F4FEF7F4FEF7F4FEF7F4FEF7F4FEF7F4FEF7F4FEF7F4FEF7F4FEF7F4FEF7
            F4FEF7F4FEF7F4FEF9F8E2DDDCDAD5D4FBF6F5FAF2EBEBE5E0FFFEF9FFF9F4FA
            F5F2FFFBF8FCF7F4FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5
            FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8
            F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5FFF8F5F9F4F3F9F4F3FCF7F6FFFAF9E9
            E1DAE1D9D2F7F1EAFFFAF3FFFCF7FFF9F4FBF5F0FEF8F3FFF9F4FEF8F3FFFAF5
            FBF5F0FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9
            F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FFF9F4FF
            F9F6FFF8F5FFF8F5FCF5F2DDD5CEFF00FFE2DCD5E5DFD8FBF5F0FEF8F3FFF9F4
            FFFCF7FFFAF5FDF7F2FFFAF5FFF9F4FEF8F3FEF8F3FEF8F3FEF8F3FEF8F3FEF8
            F3FEF8F3FEF8F3FEF8F3FEF8F3FEF8F3FEF8F3FEF8F3FEF8F3FEF8F3FEF8F3FE
            F8F3FEF8F3FEF8F3FEF8F3FFFCF7FCF6F1E9E3DEDBD5D0FF00FF}
          Skin.SkinSelectCenter.Data = {
            46050000424D46050000000000003600000028000000240000000C0000000100
            18000000000010050000C30E0000C30E00000000000000000000B6B0ABECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4B6B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0
            ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4B6B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0ABECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6
            B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0ABECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4B6B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0
            ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4B6B0AB}
          Skin.SkinSelectBottom.Data = {
            6E040000424D6E040000000000003600000028000000240000000A0000000100
            18000000000038040000C30E0000C30E00000000000000000000FF00FFBDB7B2
            B7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1
            ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7
            B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1ACB7B1AC
            B7B1ACFF00FFB6B0ABBDB7B2ECE7E4ECE7E4ECE7E4ECE7E4EEE7E4EEE7E4EEE7
            E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EE
            E7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4EEE7E4
            EEE7E4EEE7E4EEE7E4EEE7E4BDB7B2B6B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0
            ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4B6B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0ABECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6
            B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6B0ABB6B0ABECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4B6B0ABB6B0ABECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7
            E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4EC
            E7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4
            ECE7E4ECE7E4ECE7E4ECE7E4ECE7E4B6B0AB}
          Skin.SkinCaptionX = 4
          Skin.SkinX = 4
          Skin.SkinY = 4
          ItemSource = DBDaySource2
        end
        object grdResources: TAdvStringGrid
          Left = 768
          Top = 1
          Width = 152
          Height = 330
          Cursor = crDefault
          HelpContext = 54014
          Anchors = [akTop, akRight, akBottom]
          ColCount = 2
          DefaultRowHeight = 21
          DrawingStyle = gdsClassic
          FixedCols = 0
          RowCount = 5
          FixedRows = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSelect]
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 1
          OnClick = grdResourcesClick
          GridLineColor = clWhite
          OnGetCellColor = grdResourcesGetCellColor
          OnDblClickCell = grdResourcesDblClickCell
          ActiveCellFont.Charset = DEFAULT_CHARSET
          ActiveCellFont.Color = clWindowText
          ActiveCellFont.Height = -11
          ActiveCellFont.Name = 'MS Sans Serif'
          ActiveCellFont.Style = [fsBold]
          CellNode.ShowTree = False
          CellNode.TreeColor = clSilver
          ControlLook.FixedGradientHoverFrom = clGray
          ControlLook.FixedGradientHoverTo = clWhite
          ControlLook.FixedGradientDownFrom = clGray
          ControlLook.FixedGradientDownTo = clSilver
          ControlLook.ControlStyle = csClassic
          ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
          ControlLook.DropDownHeader.Font.Color = clWindowText
          ControlLook.DropDownHeader.Font.Height = -11
          ControlLook.DropDownHeader.Font.Name = 'Tahoma'
          ControlLook.DropDownHeader.Font.Style = []
          ControlLook.DropDownHeader.Visible = True
          ControlLook.DropDownHeader.Buttons = <>
          ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
          ControlLook.DropDownFooter.Font.Color = clWindowText
          ControlLook.DropDownFooter.Font.Height = -11
          ControlLook.DropDownFooter.Font.Name = 'Tahoma'
          ControlLook.DropDownFooter.Font.Style = []
          ControlLook.DropDownFooter.Visible = True
          ControlLook.DropDownFooter.Buttons = <>
          EnhRowColMove = False
          Filter = <>
          FilterDropDown.Font.Charset = DEFAULT_CHARSET
          FilterDropDown.Font.Color = clWindowText
          FilterDropDown.Font.Height = -11
          FilterDropDown.Font.Name = 'Tahoma'
          FilterDropDown.Font.Style = []
          FilterDropDownClear = '(All)'
          FixedFont.Charset = DEFAULT_CHARSET
          FixedFont.Color = clWindowText
          FixedFont.Height = -11
          FixedFont.Name = 'Tahoma'
          FixedFont.Style = []
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
          SelectionColor = clWhite
          SelectionTextColor = clRed
          Version = '5.6.0.1'
          WordWrap = False
        end
        object Button1: TDNMSpeedButton
          Left = 799
          Top = 332
          Width = 87
          Height = 26
          HelpContext = 54015
          Anchors = [akRight, akBottom]
          Caption = 'Reset'
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
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = Button1Click
        end
        object txtwidthDay: TwwDBSpinEdit
          Left = 776
          Top = 388
          Width = 55
          Height = 23
          HelpContext = 54016
          Anchors = [akRight, akBottom]
          Increment = 10.000000000000000000
          MaxValue = 1000.000000000000000000
          AutoFillDate = False
          AutoSelect = False
          AutoSize = False
          DataField = 'DayWidth'
          DataSource = DSTimeInc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          LimitEditRect = True
          ParentFont = False
          TabOrder = 3
          UnboundDataType = wwDefault
          OnChange = txtwidthDayChange
        end
        object txtwidthWeek: TwwDBSpinEdit
          Left = 860
          Top = 388
          Width = 55
          Height = 23
          HelpContext = 54017
          Anchors = [akRight, akBottom]
          Increment = 10.000000000000000000
          MaxValue = 1000.000000000000000000
          AutoFillDate = False
          AutoSelect = False
          AutoSize = False
          DataField = 'WeekWidth'
          DataSource = DSTimeInc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          LimitEditRect = True
          ParentFont = False
          TabOrder = 4
          UnboundDataType = wwDefault
          OnChange = txtwidthWeekChange
        end
      end
      object TabSheet3: TTabSheet
        HelpContext = 54030
        Caption = '&Month Mode'
        ImageIndex = 2
        object DBPlannerMonthView: TDBPlannerMonthView
          Left = 0
          Top = 32
          Width = 919
          Height = 379
          Cursor = crDefault
          HelpContext = 54031
          Align = alClient
          AllowItemEdit = False
          AttachementGlyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            8888888888700078888888888708880788888888808808808888888880808080
            8888888880808080888888888080808088888888808080808888888880808080
            8888888880808080888888888080808088888888808080808888888888808080
            8888888888808880888888888888000888888888888888888888}
          BevelOuter = bvNone
          BorderWidth = 1
          BorderStyle = bsSingle
          CaptionFont.Charset = DEFAULT_CHARSET
          CaptionFont.Color = clBlack
          CaptionFont.Height = -11
          CaptionFont.Name = 'MS Sans Serif'
          CaptionFont.Style = [fsBold]
          CaptionHeight = 11
          Color = clWhite
          Completion.Font.Charset = DEFAULT_CHARSET
          Completion.Font.Color = clWindowText
          Completion.Font.Height = -11
          Completion.Font.Name = 'Arial'
          Completion.Font.Style = []
          DateFormat = 'dd/mm/yyyy'
          DayFont.Charset = DEFAULT_CHARSET
          DayFont.Color = clBlack
          DayFont.Height = -11
          DayFont.Name = 'MS Sans Serif'
          DayFont.Style = []
          DefaultItem.CaptionBkgTo = clSilver
          DefaultItem.CaptionFont.Charset = DEFAULT_CHARSET
          DefaultItem.CaptionFont.Color = clWindowText
          DefaultItem.CaptionFont.Height = -11
          DefaultItem.CaptionFont.Name = 'MS Sans Serif'
          DefaultItem.CaptionFont.Style = []
          DefaultItem.CaptionType = ctText
          DefaultItem.ColorTo = 14803425
          DefaultItem.Completion = 1
          DefaultItem.Cursor = -1
          DefaultItem.Font.Charset = DEFAULT_CHARSET
          DefaultItem.Font.Color = clWindowText
          DefaultItem.Font.Height = -11
          DefaultItem.Font.Name = 'MS Sans Serif'
          DefaultItem.Font.Style = []
          DefaultItem.InplaceEdit = peCustom
          DefaultItem.ItemBegin = 16
          DefaultItem.ItemEnd = 17
          DefaultItem.ItemPos = 0
          DefaultItem.Name = 'PlannerItem0'
          DefaultItem.Shape = psRounded
          DefaultItem.SelectColor = clWhite
          DefaultItem.SelectColorTo = clInfoBk
          DefaultItem.Shadow = True
          DefaultItem.TrackColor = clBlack
          DefaultItem.TrackLinkColor = clMaroon
          DefaultItem.TrackSelectColor = clBlack
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
          DragItem = True
          FocusColor = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial Unicode MS'
          Font.Style = [fsBold]
          Glyphs.NextMonth.Data = {
            660F0000424D660F000000000000360000002800000024000000240000000100
            180000000000300F0000202E0000202E00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFEEE6DCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFEEE6E5FFFFFEFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDECEB5B58C6B845A39FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6BDADC6A58C7B5231
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDECEBDBD
            946B9C63298C52219C7B63FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            EFDED6BD9C739C63298C5221A58C6BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFDECEB5C6A5849C63299C63299C63298C5221846339FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFDEC6ADCEAD8C9C63299C63299C63298C52217B5A31FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFCEB594CEAD8C9C63299C63299C63299C6329
            9C63298C5221845A39FFFFFFFFFFFFFFFFFFE7DECECEAD8CA563299C63299C63
            299C63299C63298C5A21846342FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBD9473C6A584
            9C63299C63299C63299C63299C63299C63298C52219C7B5AFFFFFFFFFFFFD6BD
            ADC6A5849C63299C63299C63299C63299C63299C63298C5221845A31FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFCEAD94C6A57B9C63299C63299C63299C63299C63299C63
            298C5221845A39FFFFFFFFFFFFCEAD8CCEAD949C63299C63299C63299C63299C
            63299C63299452218C6342FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBD946BC6A5849C63
            299C63299C63299C63299C63299C63298C52219C7B63FFFFFFFFFFFFC6A584C6
            A57B9C63299C63299C63299C63299C63299C63298C52218C6342FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFD6C6ADC6A5849C63299C63299C63299C63299C63299C63298C
            52217B5229FFFFFFFFFFFFD6B59CCEAD8C9C63299C63299C63299C63299C6329
            9C63298C5221845A31FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB58C63C69C7B9C63299C
            63299C63299C63299C63299C63298C52219C7B5AFFFFFFFFFFFFC69C7BC6A57B
            9C63299C63299C63299C63299C63299C63298C52218C6342FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFC6AD8CC6A5849C63299C63299C63299C63299C63299C63298C5221
            845A39FFFFFFFFFFFFD6BD9CC6A57B9C63299C63299C63299C63299C63299C63
            298C52217B5229FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB58C6BC69C7B9C63299C6329
            9C63299C63299C63299C63298C52219C7B63FFFFFFFFFFFFB5845AC6A57B9C63
            299C63299C63299C63299C63299C63298C52219C846BFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFC6A584C6A5849C63299C63299C63299C63299C63299C63298C5221845A
            39FFFFFFFFFFFFD6B59CC6A57B9C63299C63299C63299C63299C63299C63298C
            5221845A39FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6A584C69C7B9C63299C63299C63
            299C63299C63299C63298C5221845A39FFFFFFFFFFFFC69C7BCEAD8C9C63299C
            63299C63299C63299C63299C63298C5A218C6342FFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFBD946BC6A5849C63299C63299C63299C63299C63299C63298C5221947B5AFF
            FFFFFFFFFFD6BDA5C6A57B9C63299C63299C63299C63299C63299C63298C5221
            7B5229FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBD946B9C63299C63299C63299C63299C
            63299C6329945A216B4218FFF7F7FFFFFFFFFFFFB5845A9C63299C63299C6329
            9C63299C63299C6329945A21734218EFEFE7FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB58C5AC6A5849C
            63299C63299C63299C63299C6329945A21734218FFFFFFFFFFFFFFFFFFCEB594
            C6A57B9C63299C63299C63299C63299C6329945A21734218F7F7F7FFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFB5845ABD946B9C63299C63299C63299C63299C6329945A216B4210FFFFFF
            FFFFFFFFFFFFAD7B52C69C7B9C63299C63299C63299C63299C6329945A217342
            18FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFBD9C73C6A57B9C63299C63299C63299C63299C6329
            945A21734218FFFFFFFFFFFFFFFFFFCEAD94C69C7B9C63299C63299C63299C63
            299C6329945A21734218F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB58C63C6A57B9C63299C6329
            9C63299C63299C6329945A21734210FFFFFFFFFFFFFFFFFFAD7B52C6A57B9C63
            299C63299C63299C63299C6329945A21734218FFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6A584
            C6A5849C63299C63299C63299C63299C63299C5A21734218FFFFFFFFFFFFFFFF
            FFD6B59CC6A5849C63299C63299C63299C63299C6329945A217B4A18F7F7F7FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFB58C63C6A57B9C63299C63299C63299C63299C6329945A217342
            18FFFFFFFFFFFFFFFFFFC6A57BC6A5849C63299C63299C63299C63299C632994
            5A21734A18FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCEAD94C6A584A563299C63299C63299C63
            299C6329945A21734210FFFFFFFFFFFFFFFFFFC6A57BCEB5949C63299C63299C
            63299C63299C6329945A21734210FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBD946BC6A5849C63
            299C63299C63299C63299C6329945A21734218FFFFFFFFFFFFFFFFFFC69C7BC6
            A5849C63299C63299C63299C63299C6329945A21734218FFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFC6A58CC6A5849C63299C63299C63299C63299C6329945A21734210FFFFFFFF
            FFFFFFFFFFC6A584CEB5949C63299C63299C63299C63299C6329945A21734218
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFBD9C73C6A5849C63299C63299C63299C63299C632994
            5A21734210FFFFFFFFFFFFFFFFFFDEC6B5C6A5849C63299C63299C63299C6329
            9C6329945A21734210F7F7EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB58452B58C639C
            63299C63299C6329945A216B4210FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAD7B52
            BD946B9C63299C63299C6329945A21734210FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFA56B31BD8C639C6329945A21734210FFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFF9C6329B58C5A9C6329945A21734218F7F7F7FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB5845AA57B4A6B4210
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAD7B52B584
            5A734218FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFA5846BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFB59C8CF7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF}
          Glyphs.PrevMonth.Data = {
            660F0000424D660F000000000000360000002800000024000000240000000100
            180000000000300F0000202E0000202E00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEEEEEFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBBBBBB
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF938B8B1F1F1FFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFBCBBBB000000F5F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFF7B6342AD8C634A2910080808FFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBDBDBDBD9473734A18000000E7E7E7FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF84736BCEAD8CA563298C5221
            523110000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADADA5AD7B4AA563
            31945A21734A18000000F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF735A42
            C6A57B9C63299C63299C63298C5221523110080808FFFFFFFFFFFFFFFFFFFFFF
            FFBDBDBDB58C63A56B319C63299C6329945A21734218000000E7E7E7FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF634A29CEAD8C9C63299C63299C63299C63299C63298C52215A39
            10F7F7F7FFFFFFFFFFFFA59C94B58452A563319C63299C63299C63299C632994
            5A21734A18BDBDBDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B634ACEAD8C9C63299C63299C63299C63
            299C63299C63297B4A18D6CEC6FFFFFFFFFFFFADADA5BD8C63A56B319C63299C
            63299C63299C63299C632984522194846BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF634A31CEAD8CA563
            299C63299C63299C63299C63299C6329844A18EFE7E7FFFFFFFFFFFF9C9C94B5
            8C63A563319C63299C63299C63299C63299C63298C52219C8C73FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF735A42CEAD8C9C63299C63299C63299C63299C63299C63297B4A18DED6CEFF
            FFFFFFFFFFA59C9CBD946BA563319C63299C63299C63299C63299C6329845221
            A58C7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF735231C69C7B9C63299C63299C63299C63299C632994
            5A217B4A18F7EFEFFFFFFFFFFFFF8C847BC6A57B9C63299C63299C63299C6329
            9C63299C6329844A18B5A594FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF73634ACEAD8C9C63299C63299C
            63299C63299C63299C63297B4A18DECEC6FFFFFFFFFFFFA5A5A5B58C5AA56329
            9C63299C63299C63299C63299C63298C5221B5A594FFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF845221C6
            9C7B9C63299C63299C63299C63299C6329945A217B4A18F7F7EFFFFFFFFFFFFF
            8C847BC6A5849C63299C63299C63299C63299C63299C6329844A18BDAD9CFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFF7B5229BD9C739C63299C63299C63299C63299C6329945A217B4A18
            EFEFE7FFFFFFFFFFFF736352C6A5849C63299C63299C63299C63299C63299C63
            29845221CEC6BDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF7B5229C6A5849C63299C63299C63299C6329
            9C6329945A217B4A18F7EFEFFFFFFFFFFFFF948C7BC6A57B9C63299C63299C63
            299C63299C63299C6329844A18B5A594FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF734A29C69C7B9C6329
            9C63299C63299C63299C63299C5A217B4A18FFFFFFFFFFFFFFFFFF7B6B52C69C
            7B9C63299C63299C63299C63299C63299C6329845221CEC6B5FFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            734218C6A57B9C63299C63299C63299C63299C63299C63297B4A187B736BFFFF
            FFFFFFFFB5A59CC6A5849C63299C63299C63299C63299C63299C6329844A1829
            2118FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFDEC6B5AD7B4AA56B319C63299C63299C63299C63299C63
            299C63297B4A18100800737373FFFFFFA56B31AD73429C63299C63299C63299C
            63299C63299C6329845221312108212121FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7EFAD7B4AA56B
            319C63299C63299C63299C63299C63299C63297B4A180808007B7B7BFFFFFFA5
            6B31B584529C63299C63299C63299C63299C63299C6329845221312108101010
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFAD7B4AAD73429C63299C63299C63299C63299C63299C
            6329844A18181008313131FFFFFFAD7B4AB584529C63299C63299C63299C6329
            9C63299C63298C52215A3110101010FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7EFAD7B42A56B319C
            63299C63299C63299C63299C63299C63297B4A18211008737373FFFFFFA56B39
            B584529C63299C63299C63299C63299C63299C63298C5221392108101010FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFAD7B4AA573399C63299C63299C63299C63299C63299C6329
            845218181008393939FFFFFFAD7B4AB58C5A9C63299C63299C63299C63299C63
            299C63298C5221523110101010FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7EFAD7B4AA56B319C6329
            9C63299C63299C63299C63299C63297B4A181810086B6B6BFFFFFF9C6329B584
            529C63299C63299C63299C63299C63299C63298C5221392108101010FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF9C6329A573429C63299C63299C63299C63299C63299C63298452
            18211008313131FFFFFFAD7B52BD8C639C63299C63299C63299C63299C63299C
            63298C52215A3910000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA56B31A56B319C63299C63
            299C63299C63299C63299C6329844A18291808212121FFFFFF9C6329B58C5A9C
            63299C63299C63299C63299C63299C63298C52215A3910000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFA56B31A573429C63299C63299C63299C63299C63299C632984521829
            1808292929FFFFFFAD7B4ABD8C639C63299C63299C63299C63299C63299C6329
            8C5221523110000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9C6329A56B399C63299C63299C
            63299C63299C63299C6329845221311808101010FFFFFFA57339BD8C639C6329
            9C63299C63299C63299C63299C63298C52216B4218000000FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFA56B31A573399C63299C63299C63299C63299C6329945A21734218FFFFFF
            FFFFFFFFFFFFAD7B4ABD946B9C63299C63299C63299C63299C63299C63297B4A
            18AD9484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA56B39B5845A9C63299C63299C6329
            945A21734A18F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFC69C7BBD9C739C63299C63
            299C63299C63297B4A18D6CEC6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            A56B31AD73429C6329945A217B4A18F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFAD7B52BD9C739C63299C6329844A21CEBDB5FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA56B39A5734A734A21F7F7F7FFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6A584BD946B844A18DED6CEFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA584
            63F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFAD9473CEBDADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF}
          GradientEndColor = 15921906
          HintPrevYear = 'Previous Year'
          HintPrevMonth = 'Previous Month'
          HintNextMonth = 'Next Month'
          HintNextYear = 'Next Year'
          InActiveColor = clTeal
          Items = <>
          ItemSpace = -20
          MaxItemsDisplayed = 50
          NameOfDays.Monday = 'Mon'
          NameOfDays.Tuesday = 'Tue'
          NameOfDays.Wednesday = 'Wed'
          NameOfDays.Thursday = 'Thu'
          NameOfDays.Friday = 'Fri'
          NameOfDays.Saturday = 'Sat'
          NameOfDays.Sunday = 'Sun'
          NameOfDays.UseIntlNames = True
          NameOfMonths.January = 'January'
          NameOfMonths.February = 'February'
          NameOfMonths.March = 'March'
          NameOfMonths.April = 'April'
          NameOfMonths.May = 'May'
          NameOfMonths.June = 'June'
          NameOfMonths.July = 'July'
          NameOfMonths.August = 'August'
          NameOfMonths.September = 'September'
          NameOfMonths.October = 'October'
          NameOfMonths.November = 'November'
          NameOfMonths.December = 'December'
          NameOfMonths.UseIntlNames = False
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
          PrintOptions.Orientation = poLandscape
          SelectColor = clHighlight
          ShadowColor = clSilver
          ShowHint = True
          ParentShowHint = False
          ShowCurrent = True
          ShowCurrentItem = True
          ShowScrollColumn = True
          ShowSelectionFull = False
          TabOrder = 0
          TodayColor = clWhite
          TodayColorTo = clBtnFace
          TodayStyle = tsCaption
          URLGlyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888880000800
            0088888808F8F0F8F80888808000000000808880F070888070F0888080000000
            0080880408F8F0F8F80880CCC0000400008874CCC2222C4788887CCCC22226C0
            88887CC822222CC088887C822224642088887C888422C220888877CF8CCCC227
            888887F8F8222208888888776888208888888887777778888888}
          WeekFont.Charset = DEFAULT_CHARSET
          WeekFont.Color = clWindowText
          WeekFont.Height = -11
          WeekFont.Name = 'MS Sans Serif'
          WeekFont.Style = []
          WeekName = 'Wk'
          Day = 17
          Month = 3
          Year = 2008
          Version = '2.5.10.1'
          OnItemDblClick = DBPlanner1ItemDblClick
          OnItemHint = DBPlannerMonthViewItemHint
          OnGetDayProp = DBPlannerMonthViewGetDayProp
          OnDblClick = DBPlannerMonthViewDblClick
          OnDateChange = DBPlannerMonthViewDateChange
          DataBinding.StartTimeField = 'STARTTIME'
          DataBinding.EndTimeField = 'ENDTIME'
          DataBinding.KeyField = 'AppointID'
          DataSource = AppointmentsDS
          OnFieldsToItem = DBDaySource1FieldsToItem
          OnItemToFields = DBPlannerMonthViewItemToFields
        end
        object DNMPanel1: TDNMPanel
          Left = 0
          Top = 0
          Width = 919
          Height = 32
          HelpContext = 54032
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object Label48: TLabel
            Left = 12
            Top = 7
            Width = 28
            Height = 18
            HelpContext = 54033
            AutoSize = False
            Caption = 'Rep'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label4: TLabel
            Left = 205
            Top = 8
            Width = 23
            Height = 15
            HelpContext = 54034
            AutoSize = False
            Caption = 'A&ll'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object cboEmployee: TwwDBLookupCombo
            Left = 40
            Top = 4
            Width = 150
            Height = 23
            HelpContext = 54035
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'FullName'#9'30'#9'FullName'#9'F')
            LookupTable = qryResources
            LookupField = 'EmployeeID'
            ParentFont = False
            TabOrder = 0
            AutoDropDown = True
            ShowButton = True
            UseTFields = False
            PreciseEditRegion = False
            AllowClearKey = False
            OnCloseUp = cboEmployeeCloseUp
          end
          object chkAllReps: TwwCheckBox
            Left = 231
            Top = 7
            Width = 15
            Height = 17
            HelpContext = 54036
            DisableThemes = False
            AlwaysTransparent = True
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            DisplayValueChecked = 'T'
            DisplayValueUnchecked = 'F'
            NullAndBlankState = cbUnchecked
            Caption = 'All'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ShowText = False
            TabOrder = 1
            OnClick = chkAllRepsClick
          end
        end
      end
    end
  end
  object cbTimeIncs: TDBComboBox [21]
    Left = 120
    Top = 3
    Width = 70
    Height = 23
    HelpContext = 54018
    DataField = 'TimeInc'
    DataSource = DSTimeInc
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
    TabOrder = 0
    TabStop = False
    OnChange = cbTimeIncsChange
  end
  object DNMSpeedButton1: TDNMSpeedButton [22]
    Left = 637
    Top = 493
    Width = 87
    Height = 27
    HelpContext = 54038
    Anchors = [akBottom]
    Caption = 'PM Roster'
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
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    OnClick = DNMSpeedButton1Click
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 696
    Top = 271
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 110
    Top = 271
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited DataState: TDataState
    Left = 864
    Top = 264
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 800
    Top = 271
  end
  inherited imgsort: TImageList
    Left = 76
    Top = 271
    Bitmap = {
      494C01010200AC00B80010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 213
    Top = 271
  end
  object AppointmentsDS: TDataSource
    DataSet = qryAppointments
    Left = 593
    Top = 271
  end
  object DBDaySource1: TDBDaySource
    OnCreateKey = DBDaySource1CreateKey
    OnResetFilter = DBDaySource1ResetFilter
    AutoIncKey = False
    DataSource = AppointmentsDS
    ResourceMap = <>
    StartTimeField = 'STARTTIME'
    EndTimeField = 'ENDTIME'
    KeyField = 'AppointID'
    ReadOnly = False
    ResourceField = 'TrainerToResourceCalc'
    UpdateByQuery = False
    OnFieldsToItem = DBDaySource1FieldsToItem
    OnItemToFields = DBDaySource1ItemToFields
    AutoHeaderUpdate = True
    DateFormat = 'mm/dd/yyyy'
    Mode = dmMultiResDay
    NumberOfDays = 1
    NumberOfResources = 20
    Left = 662
    Top = 271
  end
  object DBDaySource2: TDBDaySource
    OnCreateKey = DBDaySource1CreateKey
    OnResetFilter = DBDaySource1ResetFilter
    AutoIncKey = False
    DataSource = AppointmentsDS
    ResourceMap = <>
    StartTimeField = 'STARTTIME'
    EndTimeField = 'ENDTIME'
    KeyField = 'AppointID'
    ReadOnly = False
    ResourceField = 'TrainerToResourceCalc'
    UpdateByQuery = False
    OnFieldsToItem = DBDaySource1FieldsToItem
    OnItemToFields = DBDaySource2ItemToFields
    AutoHeaderUpdate = True
    DateFormat = 'mm/dd/yyyy'
    Mode = dmMultiResDay
    NumberOfResources = 20
    Left = 627
    Top = 271
  end
  object qryDeleteResources: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'DROP TABLE IF EXISTS tblResources')
    Left = 248
    Top = 271
  end
  object qryCreateResources: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'CREATE TABLE IF NOT EXISTS `tblResources` ('
      '  `ResourceID` int(11) unsigned NOT NULL auto_increment,'
      '  `EmployeeID` int(11) unsigned NOT NULL,'
      '  `FirstName` varchar(30) default NULL,'
      '  `LastName` varchar(50) default NULL,'
      '  PRIMARY KEY  (`ResourceID`)) ENGINE=InnoDB')
    Left = 282
    Top = 271
  end
  object qryAddResources: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT DISTINCT tblEmployees.EmployeeID, FirstName, LastName'
      'FROM tblEmployees'
      'WHERE tblEmployees.Active='#39'T'#39' and tblEmployees.Rep='#39'T'#39
      'ORDER BY tblEmployees.EmployeeID')
    Left = 351
    Top = 271
  end
  object qryResources: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT DISTINCT'
      'tblresources.ResourceID,'
      'tblresources.EmployeeID,'
      'tblresources.FirstName,'
      'tblresources.LastName,'
      'Concat(FirstName,'#39' '#39',LastName) AS FullName'
      'FROM tblResources'
      'ORDER BY'
      'tblresources.EmployeeID ASC')
    Left = 386
    Top = 271
  end
  object qryChkResources: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblResources where EmployeeID = :ID')
    Left = 317
    Top = 271
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
  end
  object qryCalPrefs: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select PPID , EmployeeID ,CalendarReps '
      'FROM tblpersonalpreferences'
      'WHERE EmployeeID = :xEmployeeID')
    Left = 489
    Top = 271
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xEmployeeID'
      end>
  end
  object qryAppointments: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT tblappointments.CusID, tblappointments.AppointID, tblappo' +
        'intments.AppDate,'
      
        'tblappointments.ENDTIME, tblappointments.STARTTIME, tblappointme' +
        'nts.ResourceID,'
      'tblappointments.TrainerID, tblappointments.Notes, Cancellation,'
      'tblappointments.Status,'
      '#Service1, Service2, Service3, Service4, Service5, Service6, '
      'Unavailable,'
      'Start_Time,End_Time, ServiceDesc , tblappointments.RepairId , '
      
        'tblclients.Company, tblclients.Suburb, tblclients.Street, tblcli' +
        'ents.Street2, tblclients.Street3, tblclients.State, tblclients.P' +
        'ostcode,'
      'tblclients.Country,'
      'tblappointments.CustomerDetails,'
      'tblappointments.GoogleId, '
      'tblappointments.SynchWithGoogle'
      'FROM tblappointments'
      
        '/*LEFT OUTER*/ LEFT  JOIN tblclients ON  (tblappointments.CusID ' +
        '= tblclients.ClientID)'
      
        '/*LEFT*/INNER  JOIN tblemployees ON (tblappointments.TrainerID =' +
        ' tblemployees.EmployeeID)'
      'WHERE tblappointments.Cancellation <> '#39'T'#39
      'AND tblemployees.Rep = '#39'T'#39
      'AND tblemployees.Active = '#39'T'#39
      'AND tblappointments.AppDate >= :xDateFrom'
      'AND ((:xDateTo = "") or (tblappointments.AppDate <= :xDateTo))'
      
        'And ((:xTrainerID=0) or (tblappointments.TrainerID = :xTrainerID' +
        '))'
      'And ((:xStatus='#39#39') or (tblappointments.Status = :xStatus))'
      'AND tblappointments.Active = '#39'T'#39
      '#GROUP BY AppointID'
      'ORDER BY tblappointments.AppDate;')
    FetchRows = 1
    AfterOpen = qryAppointmentsAfterOpen
    BeforePost = qryAppointmentsBeforePost
    AfterScroll = qryAppointmentsAfterScroll
    OnCalcFields = qryAppointmentsCalcFields
    Options.LongStrings = False
    Options.StrictUpdate = False
    Left = 558
    Top = 271
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xDateFrom'
      end
      item
        DataType = ftUnknown
        Name = 'xDateTo'
      end
      item
        DataType = ftUnknown
        Name = 'xDateTo'
      end
      item
        DataType = ftUnknown
        Name = 'xTrainerID'
      end
      item
        DataType = ftUnknown
        Name = 'xTrainerID'
      end
      item
        DataType = ftUnknown
        Name = 'xStatus'
      end
      item
        DataType = ftUnknown
        Name = 'xStatus'
      end>
    object qryAppointmentsCusID: TIntegerField
      FieldName = 'CusID'
      Origin = 'tblappointments.CusID'
    end
    object qryAppointmentsAppointID: TIntegerField
      FieldName = 'AppointID'
      Origin = 'tblappointments.AppointID'
    end
    object qryAppointmentsAppDate: TDateField
      FieldName = 'AppDate'
      Origin = 'tblappointments.AppDate'
    end
    object qryAppointmentsENDTIME: TDateTimeField
      FieldName = 'ENDTIME'
      Origin = 'tblappointments.ENDTIME'
    end
    object qryAppointmentsSTARTTIME: TDateTimeField
      FieldName = 'STARTTIME'
      Origin = 'tblappointments.STARTTIME'
    end
    object qryAppointmentsResourceID: TWordField
      FieldName = 'ResourceID'
      Origin = 'tblappointments.ResourceID'
    end
    object qryAppointmentsTrainerID: TIntegerField
      FieldName = 'TrainerID'
      Origin = 'tblappointments.TrainerID'
    end
    object qryAppointmentsCancellation: TWideStringField
      FieldName = 'Cancellation'
      Origin = 'tblappointments.Cancellation'
      FixedChar = True
      Size = 1
    end
    object qryAppointmentsTrainerToResourceCalc: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'TrainerToResourceCalc'
      Calculated = True
    end
    object qryAppointmentsUnavailable: TWideStringField
      FieldName = 'Unavailable'
      Origin = 'tblappointments.Unavailable'
      FixedChar = True
      Size = 1
    end
    object qryAppointmentsNotes: TWideMemoField
      FieldName = 'Notes'
      Origin = 'tblappointments.Notes'
      BlobType = ftWideMemo
    end
    object qryAppointmentsStart_Time: TWideStringField
      FieldName = 'Start_Time'
      Origin = 'tblappointments.Start_Time'
      Size = 50
    end
    object qryAppointmentsEnd_Time: TWideStringField
      FieldName = 'End_Time'
      Origin = 'tblappointments.End_Time'
      Size = 50
    end
    object qryAppointmentsServiceDesc: TWideStringField
      FieldName = 'ServiceDesc'
      Origin = 'tblappointments.ServiceDesc'
      Size = 50
    end
    object qryAppointmentsRepairId: TIntegerField
      FieldName = 'RepairId'
      Origin = 'tblappointments.RepairID'
    end
    object qryAppointmentsCompany: TWideStringField
      FieldName = 'Company'
      Size = 80
    end
    object qryAppointmentsSuburb: TWideStringField
      FieldName = 'Suburb'
      Size = 255
    end
    object qryAppointmentsStreet: TWideStringField
      FieldName = 'Street'
      Size = 255
    end
    object qryAppointmentsStreet2: TWideStringField
      FieldName = 'Street2'
      Size = 255
    end
    object qryAppointmentsState: TWideStringField
      FieldName = 'State'
      Size = 255
    end
    object qryAppointmentsPostcode: TWideStringField
      FieldName = 'Postcode'
      Size = 255
    end
    object qryAppointmentsStatus: TWideStringField
      FieldName = 'Status'
      Size = 255
    end
    object qryAppointmentsStreet3: TWideStringField
      FieldName = 'Street3'
      Size = 255
    end
    object qryAppointmentsCountry: TWideStringField
      FieldName = 'Country'
      Size = 255
    end
    object qryAppointmentsCustomerDetails: TWideStringField
      FieldName = 'CustomerDetails'
      Size = 255
    end
    object qryAppointmentsGoogleId: TWideStringField
      FieldName = 'GoogleId'
      Size = 255
    end
    object qryAppointmentsSynchWithGoogle: TWideStringField
      FieldName = 'SynchWithGoogle'
      FixedChar = True
      Size = 1
    end
  end
  object qryServices: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblServices.ServiceID,'
      'tblServices.ServiceDesc'
      'FROM tblTrainerRates  '
      
        'LEFT JOIN tblServices oN tblServices.ServiceID = tblTrainerRates' +
        '.ServiceID  '
      'WHERE tblTrainerRates.EmployeeID = :xEmpID'
      'ORDER BY tblTrainerRates.TrainRateID')
    Left = 420
    Top = 271
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xEmpID'
      end>
  end
  object qryNotes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT ClientID, Company, Suburb, Street, Street2, State, Postco' +
        'de'
      'FROM tblClients where ClientID = :ID;')
    Left = 455
    Top = 271
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
  end
  object DSTimeInc: TDataSource
    DataSet = tbTimeInc
    Left = 731
    Top = 271
  end
  object tbTimeInc: TMyTable
    TableName = 'tbltimeinc'
    Connection = MyConnection
    Left = 179
    Top = 271
  end
  object qryPublicHolidays: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select Day, Description  from tblPublicholidays')
    FetchRows = 1
    Options.LongStrings = False
    Options.StrictUpdate = False
    Left = 524
    Top = 271
    object qryPublicHolidaysDay: TDateField
      FieldName = 'Day'
    end
    object qryPublicHolidaysDescription: TWideStringField
      FieldName = 'Description'
      Size = 255
    end
  end
  object tmrProgress: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = tmrProgressTimer
    Left = 765
    Top = 271
  end
  object qryStatusType: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblSimpleTypes '
      'where Active <> "F" and TypeCode = '#39'AppointmentStatusType'#39
      '')
    Left = 836
    Top = 266
  end
end
