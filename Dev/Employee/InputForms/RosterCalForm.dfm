inherited RosterCalGUI: TRosterCalGUI
  Left = 687
  Top = 150
  HelpContext = 476000
  Caption = 'Roster Calendar'
  ClientHeight = 565
  ClientWidth = 992
  Color = 12054011
  OldCreateOrder = True
  ExplicitLeft = 687
  ExplicitTop = 150
  ExplicitWidth = 1008
  ExplicitHeight = 604
  DesignSize = (
    992
    565)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 565
    Width = 992
    ExplicitTop = 565
    ExplicitWidth = 992
    HelpContext = 476020
  end
  inherited imgGridWatermark: TImage
    HelpContext = 476001
  end
  object lstLeaveColors: TListBox [5]
    Left = 553
    Top = 9
    Width = 96
    Height = 54
    HelpContext = 476016
    ItemHeight = 15
    Items.Strings = (
      '$00A9E817'
      '$001741E8'
      '$00B336C9'
      '$003CC4BD'
      '$00C4973C'
      'clBlack'
      'clsilver'
      'clGray'
      'clOlive'
      'clMaroon'
      'clPurple'
      '$00C400C4'
      'clTeal'
      'clGreen'
      '$0044C100'
      '$0000C6FF'
      'clNavy'
      '$00A4A444'
      'clBlue'
      'clred'
      ''
      '')
    TabOrder = 1
    Visible = False
  end
  object DNMPanel1: TDNMPanel [6]
    Left = 877
    Top = 50
    Width = 115
    Height = 515
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      115
      515)
    HelpContext = 476021
    object Label1: TLabel
      Left = 23
      Top = 9
      Width = 91
      Height = 15
      HelpContext = 476002
      Caption = 'All Departments'
      Transparent = True
    end
    object btnPrint: TDNMSpeedButton
      Left = 15
      Top = 399
      Width = 87
      Height = 27
      HelpContext = 476011
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
      TabOrder = 0
      OnClick = btnPrintClick
    end
    object grdClass: TAdvStringGrid
      Left = 5
      Top = 64
      Width = 106
      Height = 298
      Cursor = crDefault
      HelpContext = 476013
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
      GridLineColor = clWhite
      OnGetCellColor = grdClassGetCellColor
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
      ShowSelection = False
      Version = '5.6.0.1'
      WordWrap = False
    end
    object cboClass: TwwDBLookupCombo
      Left = 6
      Top = 35
      Width = 105
      Height = 23
      HelpContext = 476014
      DropDownAlignment = taLeftJustify
      LookupTable = qryClasses
      LookupField = 'ClassName'
      DropDownWidth = 25
      Enabled = False
      TabOrder = 2
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboClassCloseUp
    end
    object chkClasses: TCheckBox
      Left = 3
      Top = 8
      Width = 17
      Height = 17
      HelpContext = 476015
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = chkClassesClick
    end
    object btnSave: TDNMSpeedButton
      Left = 15
      Top = 364
      Width = 87
      Height = 27
      HelpContext = 476004
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
      TabOrder = 4
      OnClick = btnSaveClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 15
      Top = 469
      Width = 87
      Height = 27
      HelpContext = 476005
      Anchors = [akRight, akBottom]
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
      ModalResult = 2
      NumGlyphs = 2
      TabOrder = 5
      OnClick = btnCancelClick
    end
    object btnReport: TDNMSpeedButton
      Left = 15
      Top = 434
      Width = 87
      Height = 27
      Anchors = [akRight, akBottom]
      Caption = 'Report'
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
      TabOrder = 6
      TabStop = False
      OnClick = btnReportClick
      HelpContext = 476022
    end
  end
  object DNMPanel2: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 992
    Height = 50
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    HelpContext = 476023
    object pnlTitle: TDNMPanel
      Left = 324
      Top = 5
      Width = 238
      Height = 39
      HelpContext = 476017
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
        Width = 234
        Height = 35
        HelpContext = 476018
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
          Width = 234
          Height = 35
          HelpContext = 476019
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Roster'
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
    object dtpMonth: TwwDBDateTimePicker
      Left = 32
      Top = 13
      Width = 189
      Height = 23
      HelpContext = 476003
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      Epoch = 1950
      ShowButton = True
      TabOrder = 1
      DisplayFormat = 'mmmm yyyy'
      OnChange = dtpMonthChange
    end
    object btnPrev: TDNMSpeedButton
      Left = 5
      Top = 13
      Width = 25
      Height = 23
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF3333333333333744333333333333F773333333333337
        44473333333333F777F3333333333744444333333333F7733733333333374444
        4433333333F77333733333333744444447333333F7733337F333333744444444
        433333F77333333733333744444444443333377FFFFFFF7FFFFF999999999999
        9999733777777777777333CCCCCCCCCC33333773FF333373F3333333CCCCCCCC
        C333333773FF3337F333333333CCCCCCC33333333773FF373F3333333333CCCC
        CC333333333773FF73F33333333333CCCCC3333333333773F7F3333333333333
        CCC333333333333777FF33333333333333CC3333333333333773}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      WordWrap = True
      OnClick = btnPrevClick
      HelpContext = 476024
    end
    object btnNext: TDNMSpeedButton
      Left = 223
      Top = 13
      Width = 25
      Height = 23
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000120B0000120B00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333447333333333333374447333333333333444447333333333334444447333
        3333337444444473333333344444444473333333444444444473999999999999
        99993333CCCCCCCCCC33333CCCCCCCCC3333333CCCCCCC33333333CCCCCC3333
        33333CCCCC33333333333CCC333333333333CC33333333333333}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      Layout = blGlyphRight
      NumGlyphs = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      WordWrap = True
      OnClick = btnNextClick
      HelpContext = 476025
    end
  end
  object pnlMain: TDNMPanel [8]
    Left = 0
    Top = 50
    Width = 877
    Height = 515
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    HelpContext = 476026
    object DNMPanel3: TDNMPanel
      Left = 1
      Top = 1
      Width = 875
      Height = 513
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      HelpContext = 476027
      object PageControl1: TPageControl
        Left = 1
        Top = 1
        Width = 873
        Height = 511
        HelpContext = 476006
        ActivePage = tabDaily
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabHeight = 30
        TabOrder = 0
        TabWidth = 435
        OnChange = PageControl1Change
        object tabWeekly: TTabSheet
          HelpContext = 476007
          Caption = '&Weekly'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object plannerWeek: TDBPlanner
            Left = 0
            Top = 0
            Width = 865
            Height = 471
            HelpContext = 476008
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
            Display.DisplayScale = 22
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
            GridPopup = PopupMenu
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
            HTMLOptions.CellFontStyle = []
            HTMLOptions.HeaderFontStyle = []
            HTMLOptions.SidebarFontStyle = []
            ItemPopup = PopupMenuPlannerItem
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
            Sidebar.DateTimeFormat = 'mmm dd'
            Sidebar.Font.Charset = DEFAULT_CHARSET
            Sidebar.Font.Color = clBlack
            Sidebar.Font.Height = -11
            Sidebar.Font.Name = 'Arial'
            Sidebar.Font.Style = []
            Sidebar.HourFontRatio = 1.800000000000000000
            Sidebar.OccupiedTo = clWhite
            Sidebar.Position = spTop
            Sidebar.ShowDayName = False
            Sidebar.Width = 45
            Positions = 15
            PositionProps = <>
            PositionWidth = 26
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
            OnItemRightClick = plannerWeekItemRightClick
            OnItemMoving = plannerWeekItemMoving
            OnItemSelect = plannerWeekItemSelect
            OnPlannerRightClick = plannerWeekPlannerRightClick
            OnPlannerKeyDown = plannerWeekPlannerKeyDown
            ItemSource = WeekSource
          end
        end
        object tabDaily: TTabSheet
          HelpContext = 476009
          Caption = '&Daily'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object plannerDay: TDBPlanner
            Left = 0
            Top = 0
            Width = 865
            Height = 471
            HelpContext = 476010
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
            DefaultItem.SelectColor = clWhite
            DefaultItem.SelectColorTo = clInfoBk
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
            Display.ActiveStart = 0
            Display.ActiveEnd = 400
            Display.DisplayScale = 29
            Display.ColorNonActive = clWhite
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
            GridPopup = PopupMenu
            GridLeftCol = 21
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
            HourType = ht12hrs
            HTMLOptions.CellFontStyle = []
            HTMLOptions.HeaderFontStyle = []
            HTMLOptions.SidebarFontStyle = []
            InActiveDays.Sat = False
            InActiveDays.Sun = False
            ItemPopup = PopupMenuPlannerItem
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
            ShadowColor = clSilver
            Sidebar.AMPMPos = apNone
            Sidebar.DateTimeFormat = 'am/pm'
            Sidebar.Font.Charset = DEFAULT_CHARSET
            Sidebar.Font.Color = clBlack
            Sidebar.Font.Height = -11
            Sidebar.Font.Name = 'Arial'
            Sidebar.Font.Style = []
            Sidebar.HourFontRatio = 1.700000000000000000
            Sidebar.OccupiedTo = clWhite
            Sidebar.Position = spTop
            Positions = 20
            PositionProps = <>
            PositionWidth = 26
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
            OnItemRightClick = plannerWeekItemRightClick
            OnItemSizing = plannerDayItemSizing
            OnItemMoving = plannerWeekItemMoving
            OnItemSelect = plannerWeekItemSelect
            OnItemUnSelect = plannerDayItemUnSelect
            OnPlannerRightClick = plannerWeekPlannerRightClick
            OnPlannerKeyDown = plannerWeekPlannerKeyDown
            ItemSource = DaySource
          end
        end
      end
    end
  end
  object lstColorBox: TListBox [9]
    Left = 681
    Top = 10
    Width = 88
    Height = 56
    HelpContext = 476012
    Color = clWhite
    Columns = 1
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
    TabOrder = 0
    Visible = False
  end
  inherited tmrProcessMessage: TTimer
    Left = 430
    Top = 375
  end
  inherited tmrdelay: TTimer
    Left = 562
    Top = 375
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 496
    Top = 375
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 595
    Top = 375
  end
  inherited MyConnection: TERPConnection
    Left = 628
    Top = 375
  end
  inherited DataState: TDataState
    Left = 463
    Top = 375
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 694
    Top = 375
  end
  inherited imgsort: TImageList
    Left = 529
    Top = 375
    Bitmap = {
      494C010102007800A80010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 661
    Top = 375
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 760
    Top = 375
  end
  object WeekSource: TDBWeekSource
    Active = False
    AutoIncKey = False
    DataSource = dsWeekRoster
    ResourceMap = <>
    StartTimeField = 'StartTime'
    EndTimeField = 'EndTime'
    KeyField = 'PlannerID'
    ReadOnly = False
    ResourceField = 'ResourceIDLookup'
    NotesField = 'Notes'
    UpdateByQuery = False
    OnFieldsToItem = SourceFieldsToItem
    OnItemToFields = SourceItemToFields
    NumberOfResources = 20
    Month = 8
    Year = 2003
    WeekStart = 0
    Weeks = 9
    Left = 232
    Top = 416
  end
  object dsWeekRoster: TDataSource
    DataSet = qryWeekRoster
    Left = 232
    Top = 376
  end
  object dsDayRoster: TDataSource
    DataSet = qryWeekRoster
    Left = 168
    Top = 376
  end
  object DaySource: TDBDaySource
    Active = False
    AutoIncKey = False
    DataSource = dsDayRoster
    ResourceMap = <>
    StartTimeField = 'StartTime'
    EndTimeField = 'EndTime'
    KeyField = 'PlannerID'
    ReadOnly = False
    ResourceField = 'ResourceIDLookup'
    NotesField = 'Notes'
    UpdateByQuery = False
    OnFieldsToItem = SourceFieldsToItem
    OnItemToFields = SourceItemToFields
    DateFormat = 'dd mmm yyyy'
    Day = 37846.000000000000000000
    Mode = dmMultiResource
    NumberOfResources = 20
    Left = 168
    Top = 424
  end
  object PopupMenuPlannerItem: TAdvPopupMenu
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 364
    Top = 375
  end
  object PopupMenu: TAdvPopupMenu
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 397
    Top = 375
  end
  object qryWeekRoster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select RosterID, tblroster.GlobalRef, PlannerID, tblroster.Type,' +
        ' tblroster.EmployeeID,tblroster.Date,'
      'tblroster.ClassID, tblroster.Notes,tblroster.Hours,'
      
        'StartTime, EndTime, tblroster.EditedFlag, ClockedOff,TypeCatagor' +
        'y,IsClocked'
      'FROM tblroster'
      'INNER JOIN tblEmployees using (EmployeeID)'
      'WHERE IsOnTheRoster = '#39'T'#39' and  Active='#39'T'#39' and '
      ' (Type <> '#39'Clocked'#39' or (Type = '#39'Clocked'#39' and ClockedOff = '#39'T'#39'))'
      '')
    Left = 266
    Top = 375
    object qryWeekRosterRosterID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'RosterID'
      Origin = 'tblroster.RosterID'
    end
    object qryWeekRosterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblroster.GlobalRef'
      Size = 255
    end
    object qryWeekRosterPlannerID: TWideStringField
      FieldName = 'PlannerID'
      Origin = 'tblroster.PlannerID'
      Size = 255
    end
    object qryWeekRosterType: TWideStringField
      FieldName = 'Type'
      Origin = 'tblroster.Type'
      Size = 255
    end
    object qryWeekRosterEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblroster.EmployeeID'
    end
    object qryWeekRosterClassID: TIntegerField
      FieldName = 'ClassID'
      Origin = 'tblroster.ClassID'
    end
    object qryWeekRosterResourceIDLookup: TIntegerField
      FieldKind = fkLookup
      FieldName = 'ResourceIDLookup'
      LookupDataSet = qryResources
      LookupKeyFields = 'EmployeeID'
      LookupResultField = 'ResourceID'
      KeyFields = 'EmployeeID'
      Lookup = True
    end
    object qryWeekRosterNotes: TWideStringField
      FieldName = 'Notes'
      Origin = 'tblroster.Notes'
      Size = 255
    end
    object qryWeekRosterStartTime: TDateTimeField
      FieldName = 'StartTime'
      Origin = 'tblroster.StartTime'
    end
    object qryWeekRosterEndTime: TDateTimeField
      FieldName = 'EndTime'
      Origin = 'tblroster.EndTime'
    end
    object qryWeekRosterEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblroster.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryWeekRosterClockedOff: TWideStringField
      FieldName = 'ClockedOff'
      Origin = 'tblroster.ClockedOff'
      FixedChar = True
      Size = 1
    end
    object qryWeekRosterTypeCatagory: TWideStringField
      FieldName = 'TypeCatagory'
      FixedChar = True
      Size = 10
    end
    object qryWeekRosterHours: TFloatField
      FieldName = 'Hours'
    end
    object qryWeekRosterDate: TDateField
      FieldName = 'Date'
    end
    object qryWeekRosterIsClocked: TWideStringField
      FieldName = 'IsClocked'
      FixedChar = True
      Size = 1
    end
  end
  object qryResources: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT DISTINCT ResourceID, EmployeeID, EmployeeName'
      'FROM tblResources'
      'ORDER BY ResourceID')
    Left = 298
    Top = 375
  end
  object qryChkAppoints: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select Count(AppointID) FROM tblAppointments'
      'WHERE TrainerID = :xTrainerID'
      'AND StartTime BETWEEN :xRosteredStartTime AND :xRosteredEndTime'
      'GROUP BY AppointID')
    Left = 331
    Top = 375
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xTrainerID'
      end
      item
        DataType = ftUnknown
        Name = 'xRosteredStartTime'
      end
      item
        DataType = ftUnknown
        Name = 'xRosteredEndTime'
      end>
  end
  object PrintDialog: TPrintDialog
    Left = 727
    Top = 375
  end
  object qryClasses: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblclass')
    Left = 800
    Top = 16
    object qryClassesClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object qryClassesClassName: TWideStringField
      FieldName = 'ClassName'
      Size = 60
    end
  end
  object DSClass: TDataSource
    DataSet = qryClasses
    Left = 776
  end
end
