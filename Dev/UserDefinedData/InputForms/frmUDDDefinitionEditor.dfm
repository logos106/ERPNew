inherited UDDDefinitionEditor: TUDDDefinitionEditor
  Left = -39
  Top = 178
  Caption = 'Scoping Definition Editor'
  ClientHeight = 564
  ClientWidth = 999
  OldCreateOrder = True
  OnResize = nil
  PixelsPerInch = 96
  TextHeight = 15
  object pnlTop: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 999
    Height = 109
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnDblClick = pnlTopDblClick
    object DNMPanel1: TDNMPanel
      Left = 1
      Top = 60
      Width = 997
      Height = 48
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 33
        Height = 15
        Caption = 'Name'
        Transparent = True
      end
      object Label2: TLabel
        Left = 376
        Top = 16
        Width = 65
        Height = 15
        Caption = 'Description'
        Transparent = True
      end
      object Label3: TLabel
        Left = 840
        Top = 16
        Width = 26
        Height = 15
        Caption = 'Date'
        Transparent = True
      end
      object edtName: TEdit
        Left = 64
        Top = 12
        Width = 297
        Height = 23
        TabOrder = 0
        OnEnter = edtNameEnter
        OnExit = edtNameExit
        OnKeyPress = edtNameKeyPress
      end
      object edtDescription: TEdit
        Left = 456
        Top = 12
        Width = 361
        Height = 23
        TabOrder = 1
        Text = 'edtDescription'
      end
      object edtDate: TDateTimePicker
        Left = 881
        Top = 12
        Width = 89
        Height = 23
        CalAlignment = dtaLeft
        Date = 38728.4249663194
        Time = 38728.4249663194
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 2
      end
    end
    object pnlTitle: TDNMPanel
      Left = 287
      Top = 6
      Width = 423
      Height = 45
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
        Width = 419
        Height = 41
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
          Width = 419
          Height = 41
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Scoping Definition Editor'
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
  end
  object UserDefinedGrid: TAdvStringGrid [2]
    Left = 0
    Top = 109
    Width = 999
    Height = 409
    Cursor = crDefault
    Align = alClient
    ColCount = 7
    DefaultColWidth = 162
    DefaultRowHeight = 22
    FixedCols = 0
    RowCount = 2
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goColMoving, goEditing, goTabs]
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
    OnKeyDown = UserDefinedGridKeyDown
    OnKeyPress = UserDefinedGridKeyPress
    OnSelectCell = UserDefinedGridSelectCell
    OnCellChanging = UserDefinedGridCellChanging
    OnCanAddRow = UserDefinedGridCanAddRow
    OnAutoAddRow = UserDefinedGridAutoAddRow
    OnCellValidate = UserDefinedGridCellValidate
    OnHasComboBox = UserDefinedGridHasComboBox
    OnGetEditorType = UserDefinedGridGetEditorType
    OnButtonClick = UserDefinedGridButtonClick
    OnCheckBoxClick = UserDefinedGridCheckBoxClick
    OnComboChange = UserDefinedGridComboChange
    OnComboCloseUp = UserDefinedGridComboCloseUp
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'Tahoma'
    ActiveCellFont.Style = [fsBold]
    ActiveCellColor = clWhite
    ActiveCellColorTo = 16767411
    CellNode.TreeColor = clSilver
    ColumnHeaders.Strings = (
      'Property Name'
      'Caption'
      'DataType'
      'Required'
      'Active'
      'Default Value')
    ControlLook.DropDownAlwaysVisible = True
    Filter = <>
    FixedColWidth = 162
    FixedRowHeight = 22
    FixedFont.Charset = ANSI_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -12
    FixedFont.Name = 'Arial'
    FixedFont.Style = [fsBold]
    FloatFormat = '%.2f'
    Navigation.AllowCtrlEnter = False
    Navigation.AppendOnArrowDown = True
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
    Version = '3.5.2.2'
  end
  object pnlBottom: TDNMPanel [3]
    Left = 0
    Top = 518
    Width = 999
    Height = 46
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      999
      46)
    object Label50: TLabel
      Left = 911
      Top = 14
      Width = 40
      Height = 18
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = 'Active'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object btnSave: TDNMSpeedButton
      Left = 272
      Top = 11
      Width = 87
      Height = 27
      Action = actMainSave
      Anchors = [akBottom]
      Caption = '&Save'
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
      TabOrder = 1
    end
    object btnNew: TDNMSpeedButton
      Left = 458
      Top = 11
      Width = 87
      Height = 27
      Action = actMainNew
      Anchors = [akBottom]
      Caption = '&New'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object btnCancel: TDNMSpeedButton
      Left = 641
      Top = 11
      Width = 87
      Height = 27
      Action = actMainCancel
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
      TabOrder = 3
    end
    object chkActive: TwwCheckBox
      Left = 951
      Top = 15
      Width = 16
      Height = 17
      AlwaysTransparent = True
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Anchors = [akRight, akBottom]
      Caption = 'chkActive'
      DataField = 'Active'
      TabOrder = 0
    end
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 58
    Top = 3
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 2
    Top = 3
  end
  inherited MyConnection: TMyConnection
    Left = 87
    Top = 3
  end
  inherited DataState: TDataState
    Left = 2
    Top = 35
  end
  object alMain: TActionList
    Left = 116
    Top = 4
    object actMainSave: TAction
      Caption = '&Save'
      OnExecute = actMainSaveExecute
    end
    object actMainNew: TAction
      Caption = '&New'
      OnExecute = actMainNewExecute
    end
    object actMainCancel: TAction
      Caption = '&Cancel'
      OnExecute = actMainCancelExecute
    end
  end
end
