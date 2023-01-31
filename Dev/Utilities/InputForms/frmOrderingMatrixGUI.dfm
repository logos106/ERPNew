inherited OrderingMatrixGUI: TOrderingMatrixGUI
  Left = 301
  Top = 218
  HelpContext = 404000
  Action = actFocus
  Caption = 'Ordering Matrix'
  ClientHeight = 540
  ClientWidth = 729
  KeyPreview = False
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel [0]
    Left = 111
    Top = 48
    Width = 506
    Height = 89
    HelpContext = 404002
    Anchors = [akLeft, akTop, akRight]
  end
  object Bevel2: TBevel [1]
    Left = 6
    Top = 145
    Width = 718
    Height = 358
    HelpContext = 404003
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
  end
  object lblFrom: TLabel [2]
    Left = 114
    Top = 48
    Width = 501
    Height = 21
    HelpContext = 404004
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'of Product - '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object lblYAxis: TLabel [3]
    Left = 13
    Top = 304
    Width = 46
    Height = 16
    HelpContext = 404005
    Alignment = taRightJustify
    Anchors = [akLeft]
    Caption = 'Y - axis'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label3: TLabel [4]
    Left = 123
    Top = 75
    Width = 42
    Height = 15
    HelpContext = 404006
    Caption = 'X - axis'
    Transparent = True
  end
  object Label4: TLabel [5]
    Left = 412
    Top = 75
    Width = 41
    Height = 15
    HelpContext = 404007
    Anchors = [akTop, akRight]
    Caption = 'Y - axis'
    Transparent = True
  end
  object lblXAxis: TLabel [6]
    Left = 353
    Top = 146
    Width = 47
    Height = 16
    HelpContext = 404008
    Alignment = taCenter
    Anchors = [akTop]
    Caption = 'X - axis'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    Transparent = True
  end
  object Label5: TLabel [7]
    Left = 192
    Top = 99
    Width = 86
    Height = 17
    HelpContext = 404009
    AutoSize = False
    Caption = 'Alpha Order X'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label6: TLabel [8]
    Left = 480
    Top = 99
    Width = 116
    Height = 17
    HelpContext = 404010
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 'Alpha Order Y'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label1: TLabel [9]
    Left = 673
    Top = 505
    Width = 49
    Height = 15
    HelpContext = 404011
    Anchors = [akBottom]
    Caption = 'Show &All'
    Transparent = True
  end
  object lblTitle: TLabel [10]
    Left = 114
    Top = 114
    Width = 500
    Height = 21
    HelpContext = 404012
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Allocated on Back Order'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
    WordWrap = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 404001
  end
  object cmdCancel: TDNMSpeedButton [12]
    Left = 577
    Top = 509
    Width = 87
    Height = 27
    HelpContext = 404013
    Anchors = [akBottom]
    Caption = '&Cancel'
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
    ParentFont = False
    TabOrder = 1
    OnClick = cmdCancelClick
  end
  object cmdClear: TDNMSpeedButton [13]
    Left = 320
    Top = 509
    Width = 87
    Height = 27
    HelpContext = 404014
    Anchors = [akBottom]
    Caption = 'C&lear'
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
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
    OnClick = cmdClearClick
  end
  object cboX: TwwDBLookupCombo [14]
    Left = 168
    Top = 72
    Width = 139
    Height = 24
    HelpContext = 404015
    AutoSize = False
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'ComboName'#9'30'#9'ComboName'#9'T')
    LookupTable = qryDescAttribs
    LookupField = 'ComboName'
    TabOrder = 3
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = False
    OnCloseUp = cboXCloseUp
  end
  object cboY: TwwDBLookupCombo [15]
    Left = 457
    Top = 72
    Width = 139
    Height = 24
    HelpContext = 404016
    Anchors = [akTop, akRight]
    AutoSize = False
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'ComboName'#9'30'#9'ComboName'#9'F'#9)
    DataField = 'DescAttrib2'
    LookupTable = qryDescAttribs
    LookupField = 'ComboName'
    TabOrder = 4
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = False
    OnCloseUp = cboYCloseUp
  end
  object cbShowAll: TwwCheckBox [16]
    Left = 690
    Top = 520
    Width = 16
    Height = 17
    HelpContext = 404017
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Anchors = [akBottom]
    Caption = 'Show &All '
    TabOrder = 5
    OnClick = cbShowAllClick
  end
  object ChkAlphaX: TwwCheckBox [17]
    Left = 174
    Top = 98
    Width = 15
    Height = 17
    HelpContext = 404018
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Caption = 'chkTOSLaybys'
    TabOrder = 6
    OnClick = ChkAlphaXClick
  end
  object ChkAlphaY: TwwCheckBox [18]
    Left = 462
    Top = 98
    Width = 15
    Height = 17
    HelpContext = 404019
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Anchors = [akTop, akRight]
    Caption = 'chkTOSLaybys'
    TabOrder = 7
    OnClick = ChkAlphaYClick
  end
  object cmdCreate: TDNMSpeedButton [19]
    Left = 63
    Top = 509
    Width = 87
    Height = 27
    HelpContext = 404020
    Anchors = [akBottom]
    Caption = 'C&reate'
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
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 0
    OnClick = cmdCreateClick
  end
  object btnSelectAll: TDNMSpeedButton [20]
    Left = 191
    Top = 509
    Width = 87
    Height = 27
    HelpContext = 404021
    Anchors = [akBottom]
    Caption = '&Select All'
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
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 8
    Visible = False
    OnClick = btnSelectAllClick
  end
  object grdMatrix: TAdvStringGrid [21]
    Left = 72
    Top = 164
    Width = 642
    Height = 333
    Cursor = crDefault
    HelpContext = 404022
    ColCount = 9
    DefaultRowHeight = 21
    FixedColor = 14339538
    RowCount = 14
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Options = [goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing, goEditing, goTabs]
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 10
    OnKeyDown = grdMatrixKeyDown
    OnKeyPress = grdMatrixKeyPress
    OnSelectCell = grdMatrixSelectCell
    OnCellValidate = grdMatrixCellValidate
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'MS Sans Serif'
    ActiveCellFont.Style = [fsBold]
    ActiveCellColor = clSilver
    CellNode.Color = clBlack
    CellNode.ShowTree = False
    CellNode.TreeColor = clSilver
    ControlLook.ControlStyle = csClassic
    EnhTextSize = True
    Filter = <>
    FixedFont.Charset = ANSI_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -12
    FixedFont.Name = 'Arial'
    FixedFont.Style = [fsBold]
    FloatFormat = '%.2f'
    Look = glTMS
    Navigation.AlwaysEdit = True
    Navigation.CursorWalkEditor = True
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
    ScrollSynch = True
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
    SelectionColor = 10120005
    SelectionTextColor = clHighlightText
    SortSettings.Full = False
    SortSettings.AutoFormat = False
    VAlignment = vtaCenter
    Version = '3.6.0.2'
    WordWrap = False
    ColWidths = (
      64
      62
      64
      64
      64
      64
      64
      64
      64)
    RowHeights = (
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21)
  end
  object btnClearAll: TDNMSpeedButton [22]
    Left = 448
    Top = 509
    Width = 87
    Height = 27
    HelpContext = 404023
    Anchors = [akBottom]
    Caption = '&Clear All'
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
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 9
    Visible = False
    OnClick = btnClearAllClick
  end
  object pnlTitle: TDNMPanel [23]
    Left = 83
    Top = 3
    Width = 561
    Height = 39
    HelpContext = 404024
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 557
      Height = 35
      HelpContext = 404025
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
        Width = 557
        Height = 35
        HelpContext = 404026
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Ordering Matrix'
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
  object qryDescAttribs: TMyQuery
    SQL.Strings = (
      'SELECT DescriptionAttribID, ComboName'
      'FROM tbldescriptionattribsetup Where Active='#39'T'#39';')
    Options.LongStrings = False
    Left = 136
    Top = 9
  end
  object ActionManager1: TActionManager
    Left = 40
    Top = 32
    object actFocus: TAction
      Caption = 'actFocus'
      OnUpdate = actFocusUpdate
    end
  end
end
