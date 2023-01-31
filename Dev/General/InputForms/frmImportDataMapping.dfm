inherited fmImportDataMapping: TfmImportDataMapping
  Left = 828
  Top = 193
  HelpContext = 845001
  Caption = 'Import Data Mapping'
  ClientHeight = 565
  ClientWidth = 998
  ExplicitLeft = 828
  ExplicitTop = 193
  ExplicitWidth = 1014
  ExplicitHeight = 604
  DesignSize = (
    998
    565)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 515
    Width = 998
    HelpContext = 845002
    ExplicitTop = 564
    ExplicitWidth = 998
  end
  object pnlGrid: TDNMPanel [5]
    Left = 0
    Top = 209
    Width = 998
    Height = 306
    HelpContext = 845003
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 1
    Transparent = False
    object grdMap: TAdvStringGrid
      Left = 0
      Top = 0
      Width = 998
      Height = 306
      Cursor = crDefault
      HelpContext = 845004
      Align = alClient
      ColCount = 7
      DrawingStyle = gdsClassic
      RowCount = 2
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 0
      OnDblClickCell = grdMapDblClickCell
      OnCanEditCell = grdMapCanEditCell
      OnGetEditorType = grdMapGetEditorType
      OnComboChange = grdMapComboChange
      ActiveCellFont.Charset = DEFAULT_CHARSET
      ActiveCellFont.Color = clWindowText
      ActiveCellFont.Height = -11
      ActiveCellFont.Name = 'Tahoma'
      ActiveCellFont.Style = [fsBold]
      AutoFilterUpdate = False
      ColumnHeaders.Strings = (
        'Column'
        'Width'
        'Example from file'
        'Field Name from file'
        'Map to Field (or Blank)'
        'Data Type'
        'Format')
      ControlLook.FixedGradientHoverFrom = clGray
      ControlLook.FixedGradientHoverTo = clWhite
      ControlLook.FixedGradientDownFrom = clGray
      ControlLook.FixedGradientDownTo = clSilver
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
      Filter = <>
      FilterDropDown.Font.Charset = DEFAULT_CHARSET
      FilterDropDown.Font.Color = clWindowText
      FilterDropDown.Font.Height = -11
      FilterDropDown.Font.Name = 'Tahoma'
      FilterDropDown.Font.Style = []
      FilterDropDownClear = '(All)'
      FixedColWidth = 50
      FixedRowHeight = 22
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -11
      FixedFont.Name = 'Tahoma'
      FixedFont.Style = [fsBold]
      FloatFormat = '%.2f'
      PrintSettings.DateFormat = 'dd/mm/yyyy'
      PrintSettings.Font.Charset = DEFAULT_CHARSET
      PrintSettings.Font.Color = clWindowText
      PrintSettings.Font.Height = -11
      PrintSettings.Font.Name = 'Tahoma'
      PrintSettings.Font.Style = []
      PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
      PrintSettings.FixedFont.Color = clWindowText
      PrintSettings.FixedFont.Height = -11
      PrintSettings.FixedFont.Name = 'Tahoma'
      PrintSettings.FixedFont.Style = []
      PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
      PrintSettings.HeaderFont.Color = clWindowText
      PrintSettings.HeaderFont.Height = -11
      PrintSettings.HeaderFont.Name = 'Tahoma'
      PrintSettings.HeaderFont.Style = []
      PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
      PrintSettings.FooterFont.Color = clWindowText
      PrintSettings.FooterFont.Height = -11
      PrintSettings.FooterFont.Name = 'Tahoma'
      PrintSettings.FooterFont.Style = []
      PrintSettings.PageNumSep = '/'
      ScrollWidth = 16
      SearchFooter.FindNextCaption = 'Find &next'
      SearchFooter.FindPrevCaption = 'Find &previous'
      SearchFooter.Font.Charset = DEFAULT_CHARSET
      SearchFooter.Font.Color = clWindowText
      SearchFooter.Font.Height = -11
      SearchFooter.Font.Name = 'Tahoma'
      SearchFooter.Font.Style = []
      SearchFooter.HighLightCaption = 'Highlight'
      SearchFooter.HintClose = 'Close'
      SearchFooter.HintFindNext = 'Find next occurence'
      SearchFooter.HintFindPrev = 'Find previous occurence'
      SearchFooter.HintHighlight = 'Highlight occurences'
      SearchFooter.MatchCaseCaption = 'Match case'
      Version = '5.6.0.1'
      ColWidths = (
        50
        45
        380
        124
        136
        91
        130)
    end
  end
  object pnlFooter: TDNMPanel [6]
    Left = 0
    Top = 515
    Width = 998
    Height = 50
    HelpContext = 845038
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      998
      50)
    object btnSave: TDNMSpeedButton
      Left = 219
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 845032
      Action = actSave
      Anchors = [akBottom]
      Caption = 'Save'
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      AutoDisableParentOnclick = True
    end
    object btnNew: TDNMSpeedButton
      Left = 340
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 845034
      Action = actNew
      Anchors = [akBottom]
      Caption = 'New'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      TabOrder = 1
      AutoDisableParentOnclick = True
    end
    object btnImport: TDNMSpeedButton
      Left = 460
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 845036
      Action = actImport
      Anchors = [akBottom]
      Caption = 'Import'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      TabOrder = 2
      AutoDisableParentOnclick = True
    end
    object btnTest: TDNMSpeedButton
      Left = 580
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 845037
      Action = actTestImport
      Anchors = [akBottom]
      Caption = 'Test Import'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      TabOrder = 3
      AutoDisableParentOnclick = True
    end
    object btnCancel: TDNMSpeedButton
      Left = 702
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 845033
      Action = actCancel
      Anchors = [akBottom]
      Caption = 'Cancel'
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
    object chkActive: TwwCheckBox
      Left = 925
      Top = 22
      Width = 65
      Height = 17
      HelpContext = 845010
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Anchors = [akRight, akBottom]
      Caption = 'Active'
      DataField = 'Active'
      DataSource = dsImportDataMap
      TabOrder = 5
    end
  end
  object pnlTop: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 998
    Height = 209
    HelpContext = 845011
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    Transparent = False
    DesignSize = (
      998
      209)
    object Name: TLabel
      Left = 80
      Top = 64
      Width = 33
      Height = 15
      HelpContext = 845012
      Caption = 'Name'
      Transparent = True
    end
    object Label1: TLabel
      Left = 632
      Top = 64
      Width = 66
      Height = 15
      HelpContext = 845013
      Caption = 'Import Type'
      Transparent = True
    end
    object Label2: TLabel
      Left = 58
      Top = 97
      Width = 55
      Height = 15
      HelpContext = 845014
      Caption = 'File Name'
      Transparent = True
    end
    object Label3: TLabel
      Left = 700
      Top = 124
      Width = 77
      Height = 15
      HelpContext = 845015
      Caption = 'Text delimiter'
      Transparent = True
    end
    object lblColumnCount: TLabel
      Left = 700
      Top = 153
      Width = 79
      Height = 15
      HelpContext = 845016
      Caption = 'Column Count'
      Transparent = True
    end
    object Label4: TLabel
      Left = 119
      Top = 192
      Width = 674
      Height = 15
      HelpContext = 845017
      Caption = 
        'Note: Importing the ID field will edit existing records. Leaving' +
        ' the ID field blank (but not the header) will add new records.'
    end
    object pnlTitle: TDNMPanel
      Left = 303
      Top = 7
      Width = 409
      Height = 45
      HelpContext = 845018
      Anchors = [akTop]
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
        Width = 407
        Height = 43
        HelpContext = 845019
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
          Width = 407
          Height = 43
          HelpContext = 845020
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Import Data Mapping'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 303
        end
      end
    end
    object edtName: TwwDBEdit
      Left = 119
      Top = 61
      Width = 487
      Height = 23
      HelpContext = 845021
      DataField = 'ImportName'
      DataSource = dsImportDataMap
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object cboImportType: TwwDBComboBox
      Left = 705
      Top = 61
      Width = 200
      Height = 23
      HelpContext = 845022
      ShowButton = True
      Style = csDropDownList
      MapList = False
      AllowClearKey = False
      DataField = 'TypeName'
      DataSource = dsImportDataMap
      DropDownCount = 8
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      ParentFont = False
      Sorted = False
      TabOrder = 2
      UnboundDataType = wwDefault
      OnChange = cboImportTypeChange
    end
    object edtImportFileName: TwwDBEdit
      Left = 119
      Top = 94
      Width = 530
      Height = 23
      HelpContext = 845023
      DataField = 'ImportFileName'
      DataSource = dsImportDataMap
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnChange = edtImportFileNameChange
    end
    object chkFirstLineNames: TwwCheckBox
      Left = 705
      Top = 97
      Width = 202
      Height = 17
      HelpContext = 845024
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Caption = 'First Line Contains Field Names'
      TabOrder = 4
      OnClick = chkFirstLineNamesClick
    end
    object btnRefresh: TDNMSpeedButton
      Left = 10
      Top = 178
      Width = 87
      Height = 27
      HelpContext = 845025
      Action = actRefresh
      Caption = 'Refresh'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      TabOrder = 5
      AutoDisableParentOnclick = True
    end
    object rgSeparatorType: TwwRadioGroup
      Left = 119
      Top = 121
      Width = 228
      Height = 49
      HelpContext = 845026
      DisableThemes = False
      Transparent = True
      Caption = ' Options '
      Columns = 2
      Items.Strings = (
        ' Fixed Width'
        ' Separated by')
      TabOrder = 6
      OnChange = rgSeparatorTypeChange
    end
    object rgSeparatorValue: TwwRadioGroup
      Left = 353
      Top = 121
      Width = 324
      Height = 70
      HelpContext = 845027
      DisableThemes = False
      ItemIndex = 3
      Transparent = True
      Caption = ' Format '
      Columns = 3
      Items.Strings = (
        ' Tab'
        ' Comma'
        ' Semicolon'
        ' Space'
        ' Other')
      TabOrder = 7
      OnChange = rgSeparatorValueChange
    end
    object edtSeparator: TEdit
      Left = 585
      Top = 161
      Width = 49
      Height = 23
      HelpContext = 845028
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnChange = edtSeparatorChange
    end
    object cboTextDelimiter: TComboBox
      Left = 783
      Top = 121
      Width = 73
      Height = 23
      HelpContext = 845029
      Style = csDropDownList
      TabOrder = 9
      OnChange = cboTextDelimiterChange
      Items.Strings = (
        '"'
        #39
        '')
    end
    object edtColumnCount: TAdvEdit
      Left = 784
      Top = 150
      Width = 73
      Height = 23
      HelpContext = 845030
      EditType = etNumeric
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      Enabled = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      Text = '0'
      Visible = True
      OnChange = edtColumnCountChange
      Version = '2.8.6.9'
    end
    object btnFile: TDNMSpeedButton
      Left = 649
      Top = 94
      Width = 28
      Height = 23
      HelpContext = 845031
      DisableTransparent = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555555555555555555555555555555555555555555555555555555555555555
        555555555555555555555555555555555555555FFFFFFFFFF555550000000000
        55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
        B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
        000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
        555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
        55555575FFF75555555555700007555555555557777555555555555555555555
        5555555555555555555555555555555555555555555555555555}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      TabOrder = 11
      AutoDisableParentOnclick = True
      OnClick = btnFileClick
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 64
    Top = 259
  end
  inherited tmrdelay: TTimer
    Left = 441
    Top = 259
  end
  inherited popSpelling: TPopupMenu
    Left = 177
    Top = 259
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 139
    Top = 259
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 101
    Top = 259
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 64
    Top = 290
  end
  inherited DataState: TDataState
    Left = 214
    Top = 259
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 252
    Top = 259
  end
  inherited imgsort: TImageList
    Left = 365
    Top = 259
    Bitmap = {
      494C010102005C008C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 177
    Top = 290
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 328
    Top = 259
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 403
    Top = 259
  end
  inherited qryMemTrans: TERPQuery
    Left = 139
    Top = 290
  end
  object qryImportDataMap: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblImportDataMap where ImportDataMapID = :ID')
    Left = 101
    Top = 290
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object qryImportDataMapGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryImportDataMapImportDataMapID: TIntegerField
      FieldName = 'ImportDataMapID'
    end
    object qryImportDataMapImportName: TWideStringField
      FieldName = 'ImportName'
      Size = 255
    end
    object qryImportDataMapImportFileName: TWideStringField
      FieldName = 'ImportFileName'
      Size = 255
    end
    object qryImportDataMapTypeName: TWideStringField
      FieldName = 'TypeName'
      Size = 255
    end
    object qryImportDataMapMapping: TWideMemoField
      FieldName = 'Mapping'
      BlobType = ftWideMemo
    end
    object qryImportDataMapActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryImportDataMapmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
  end
  object dsImportDataMap: TDataSource
    DataSet = qryImportDataMap
    Left = 101
    Top = 320
  end
  object dlgOpen: TOpenDialog
    Left = 479
    Top = 259
  end
  object ActionList: TActionList
    OnUpdate = ActionListUpdate
    Left = 290
    Top = 259
    object actSave: TAction
      Caption = 'Save'
      HelpContext = 845039
      OnExecute = actSaveExecute
    end
    object actCancel: TAction
      Caption = 'Cancel'
      HelpContext = 845040
      OnExecute = actCancelExecute
    end
    object actNew: TAction
      Caption = 'New'
      HelpContext = 845041
      OnExecute = actNewExecute
    end
    object actRefresh: TAction
      Caption = 'Refresh'
      HelpContext = 845035
      OnExecute = actRefreshExecute
    end
    object actImport: TAction
      Caption = 'Import'
      HelpContext = 845042
      OnExecute = actImportExecute
    end
    object actTestImport: TAction
      Caption = 'Test Import'
      HelpContext = 845043
      OnExecute = actTestImportExecute
    end
  end
end
