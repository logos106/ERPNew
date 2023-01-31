inherited fmTranslation: TfmTranslation
  HelpContext = 796001
  Caption = 'Language Translation'
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 480
    ExplicitTop = 480
  end
  object pnlFooter: TDNMPanel [5]
    Left = 0
    Top = 480
    Width = 949
    Height = 52
    HelpContext = 796002
    Align = alBottom
    Anchors = [akLeft, akRight]
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      949
      52)
    object Label32: TLabel
      Left = 883
      Top = 18
      Width = 50
      Height = 16
      HelpContext = 796003
      Alignment = taCenter
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
    object btnCompleted: TDNMSpeedButton
      Left = 209
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 796004
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
      TabOrder = 0
      OnClick = btnCompletedClick
    end
    object btnClose: TDNMSpeedButton
      Left = 654
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 796005
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
      TabOrder = 2
      OnClick = btnCloseClick
    end
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 431
      Top = 12
      Width = 87
      Height = 27
      Hint = 'Use this to export finished translation to ERP'
      HelpContext = 796006
      Anchors = [akBottom]
      Caption = 'Export To ERP'
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
      TabOrder = 1
      OnClick = DNMSpeedButton1Click
    end
    object chkActive: TwwCheckBox
      Left = 929
      Top = 18
      Width = 15
      Height = 17
      HelpContext = 796007
      TabStop = False
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
      Caption = 'chkActive'
      DataField = 'Active'
      DataSource = dslanguages
      TabOrder = 3
    end
    object cmdNew: TDNMSpeedButton
      Left = 320
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 796008
      Anchors = [akBottom]
      Caption = '&New'
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
      OnClick = cmdNewClick
    end
    object DNMSpeedButton2: TDNMSpeedButton
      Left = 542
      Top = 12
      Width = 87
      Height = 27
      Hint = 'To allow you to export the current translation'
      HelpContext = 796009
      Anchors = [akBottom]
      Caption = 'Export'
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
      TabOrder = 5
      OnClick = DNMSpeedButton2Click
    end
  end
  object pnlMain: TDNMPanel [6]
    Left = 0
    Top = 103
    Width = 949
    Height = 377
    HelpContext = 796010
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
    OnResize = pnlMainResize
    DesignSize = (
      949
      377)
    object lblFilter: TLabel
      Left = 4
      Top = 4
      Width = 107
      Height = 15
      HelpContext = 796011
      Alignment = taCenter
      Caption = 'Search in English : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label49: TLabel
      Left = 321
      Top = 4
      Width = 378
      Height = 15
      HelpContext = 796012
      Alignment = taCenter
      Caption = 
        '(Type in the Phrase to be searched and hit ENTER key to do searc' +
        'h)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblMsg: TLabel
      Left = 0
      Top = 362
      Width = 949
      Height = 15
      HelpContext = 796013
      Align = alBottom
      Alignment = taCenter
      Caption = '(Records in Red Color Are To Be Exported and Send To ERP)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      ExplicitWidth = 332
    end
    object edtSearch: TEdit
      Left = 113
      Top = 0
      Width = 202
      Height = 23
      HelpContext = 796014
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtSearchKeyPress
    end
    object grdTranslation: TwwDBGrid
      Left = 0
      Top = 36
      Width = 952
      Height = 326
      HelpContext = 796015
      Selected.Strings = (
        'Inenglish'#9'58'#9'English'#9'T'#9
        'Translation'#9'58'#9'Translation'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsLanguageTranslate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      ParentFont = False
      TabOrder = 1
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnCalcCellColors = grdTranslationCalcCellColors
      OnColEnter = grdTranslationColEnter
      OnColExit = grdTranslationColExit
      OnEnter = grdTranslationEnter
      OnExit = grdTranslationExit
      OnKeyPress = grdTranslationKeyPress
      FooterColor = clWhite
    end
    object grpFilters: TwwRadioGroup
      Left = 706
      Top = -7
      Width = 244
      Height = 37
      HelpContext = 796016
      DisableThemes = False
      ItemIndex = 0
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Items.Strings = (
        'All'
        'Translations')
      ParentFont = False
      TabOrder = 2
      OnClick = grpFiltersClick
    end
  end
  object pnlHeader: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 949
    Height = 103
    HelpContext = 796017
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
    DesignSize = (
      949
      103)
    object Label2: TLabel
      Left = 46
      Top = 78
      Width = 62
      Height = 15
      HelpContext = 796018
      Alignment = taRightJustify
      Caption = 'Language :'
      Transparent = True
    end
    object Label48: TLabel
      Left = 347
      Top = 78
      Width = 83
      Height = 15
      HelpContext = 796019
      Caption = 'Language Font'
      Transparent = True
    end
    object lblBaseURL: TLabel
      Left = 541
      Top = 78
      Width = 55
      Height = 15
      HelpContext = 796025
      Alignment = taRightJustify
      Caption = 'Base URL'
      Transparent = True
    end
    object lblBaseUrlHint: TLabel
      Left = 601
      Top = 59
      Width = 332
      Height = 15
      Cursor = crHandPoint
      HelpContext = 796026
      Alignment = taCenter
      AutoSize = False
      Caption = '(Choose to Contact ERP Head Office to Change this)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7929856
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
      OnClick = lblBaseUrlHintClick
    end
    object pnlTitle: TDNMPanel
      Left = 302
      Top = 6
      Width = 349
      Height = 45
      HelpContext = 796020
      Anchors = [akLeft, akTop, akRight]
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
        Width = 345
        Height = 41
        HelpContext = 796021
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
          Width = 345
          Height = 41
          HelpContext = 796022
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Language Translation'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 285
        end
      end
    end
    object edtLanguage: TwwDBEdit
      Left = 113
      Top = 74
      Width = 202
      Height = 23
      HelpContext = 796023
      DataField = 'Language'
      DataSource = dslanguages
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnExit = edtLanguageExit
    end
    object btnLanguagefont: TDNMSpeedButton
      Left = 436
      Top = 72
      Width = 87
      Height = 27
      HelpContext = 796024
      Caption = 'Select'
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
      TabOrder = 2
      OnClick = btnLanguagefontClick
    end
    object edtBaseURL: TwwDBEdit
      Left = 601
      Top = 74
      Width = 332
      Height = 23
      HelpContext = 796027
      DataField = 'BaseURL'
      DataSource = dslanguages
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Message = ''
    Left = 480
    Top = 231
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 96
    Top = 231
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 184
    Top = 231
  end
  inherited DataState: TDataState
    Left = 424
    Top = 231
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 256
    Top = 231
  end
  inherited imgsort: TImageList
    Left = 380
    Top = 231
    Bitmap = {
      494C01010200A400B00010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 330
    Top = 231
  end
  object QryLanguageTranslate: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'LT.* , E.InEnglish'
      'FROM'
      '`languagetranslationlocal`  LT'
      'Left join inEnglish E on LT.EnglishID = E.ID'
      'where LT.LanguageID = :LanguageId'
      'order by InEnglish')
    Filter = 'Translation <> '#39#39
    BeforeOpen = QryLanguageTranslateBeforeOpen
    AfterOpen = QryLanguageTranslateAfterOpen
    AfterInsert = QryLanguageTranslateAfterInsert
    BeforePost = QryLanguageTranslateBeforePost
    Options.LongStrings = False
    Left = 82
    Top = 280
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'LanguageId'
      end>
    object QryLanguageTranslateInenglish: TWideStringField
      DisplayLabel = 'English'
      DisplayWidth = 58
      FieldKind = fkLookup
      FieldName = 'Inenglish'
      LookupDataSet = QryinEnglish
      LookupKeyFields = 'ID'
      LookupResultField = 'InEnglish'
      KeyFields = 'EnglishID'
      Size = 255
      Lookup = True
    end
    object QryLanguageTranslateTranslation: TWideStringField
      DisplayWidth = 58
      FieldName = 'Translation'
      Origin = 'languagetranslation.Translation'
      Size = 255
    end
    object QryLanguageTranslateID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'languagetranslation.ID'
      Visible = False
    end
    object QryLanguageTranslateLanguageID: TIntegerField
      DisplayWidth = 10
      FieldName = 'LanguageID'
      Origin = 'languagetranslation.LanguageID'
      Visible = False
    end
    object QryLanguageTranslateEnglishID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EnglishID'
      Origin = 'languagetranslation.EnglishID'
      Visible = False
    end
    object QryLanguageTranslateModified: TWideStringField
      DisplayWidth = 1
      FieldName = 'Modified'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object dsLanguageTranslate: TDataSource
    DataSet = QryLanguageTranslate
    Left = 192
    Top = 281
  end
  object QryinEnglish: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM'
      'inEnglish')
    Options.LongStrings = False
    Left = 66
    Top = 336
    object QryinEnglishID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'inenglish.ID'
    end
    object QryinEnglishInEnglish: TWideStringField
      FieldName = 'InEnglish'
      Origin = 'inenglish.InEnglish'
      Size = 255
    end
  end
  object Qrylanguages: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM'
      'languages where Id = :ID')
    AfterOpen = QrylanguagesAfterOpen
    AfterPost = QrylanguagesAfterPost
    Options.LongStrings = False
    Left = 234
    Top = 344
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object QrylanguagesLanguage: TWideStringField
      DisplayWidth = 20
      FieldName = 'Language'
      Origin = 'CF.Language'
      Size = 50
    end
    object QrylanguagesID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'CF.ID'
      Visible = False
    end
    object QrylanguagesLanguageIdentifier: TWideStringField
      FieldName = 'LanguageIdentifier'
      Size = 100
    end
    object QrylanguagesActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object QrylanguagesLanguagefont: TWideStringField
      FieldName = 'Languagefont'
      Size = 255
    end
    object QrylanguagesBaseURL: TWideStringField
      FieldName = 'BaseURL'
      Size = 255
    end
  end
  object dslanguages: TDataSource
    DataSet = Qrylanguages
    Left = 160
    Top = 337
  end
  object dlgSave: TSaveDialog
    DefaultExt = 'pdi'
    Filter = 'ERP Data Import (*.csv)|*.csv|All Files (*.*)|*.*'
    Left = 290
    Top = 289
  end
  object languagefontDialog: TFontDialog
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Left = 552
    Top = 232
  end
end
