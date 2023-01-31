object UpdateGUI: TUpdateGUI
  Left = 1760
  Top = 392
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'MySQL Server Configuration'
  ClientHeight = 397
  ClientWidth = 488
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 488
    Height = 379
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    UseDockManager = True
    Version = '2.0.2.0'
    AutoHideChildren = False
    BorderColor = clGray
    BorderShadow = True
    Caption.Color = clHighlight
    Caption.ColorTo = clBlue
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clHighlightText
    Caption.Font.Height = -11
    Caption.Font.Name = 'Verdana'
    Caption.Font.Style = []
    Caption.Indent = 2
    Caption.ShadeLight = 255
    CollapsColor = clBtnFace
    CollapsDelay = 0
    ColorTo = 13226453
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = clSilver
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clBlack
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = 14938354
    StatusBar.ColorTo = clWhite
    StatusBar.GradientDirection = gdVertical
    Styler = AdvPanelStyler1
    DesignSize = (
      488
      379)
    FullHeight = 0
    object Bevel3: TBevel
      Left = 39
      Top = 254
      Width = 414
      Height = 75
      Anchors = [akLeft, akBottom]
      Shape = bsFrame
    end
    object Bevel2: TBevel
      Left = 39
      Top = 57
      Width = 414
      Height = 180
      Anchors = [akLeft, akBottom]
      Shape = bsFrame
    end
    object Label3: TLabel
      Left = 75
      Top = 283
      Width = 166
      Height = 30
      Alignment = taRightJustify
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Allocate Memory'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 145
      Top = 63
      Width = 166
      Height = 30
      Alignment = taRightJustify
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Total Memory'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 43
      Top = 128
      Width = 268
      Height = 30
      Alignment = taRightJustify
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Recommended Memory Allocation'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 114
      Top = 262
      Width = 135
      Height = 17
      Alignment = taRightJustify
      Anchors = [akLeft, akBottom]
      Caption = 'Is Dedicated Server'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Label7: TLabel
      Left = 43
      Top = 161
      Width = 268
      Height = 30
      Alignment = taRightJustify
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Maximum Memory Allocation'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Label8: TLabel
      Left = 43
      Top = 95
      Width = 268
      Height = 30
      Alignment = taRightJustify
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Minimum Memory Allocation'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Label9: TLabel
      Left = 373
      Top = 284
      Width = 32
      Height = 30
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'MB'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Label10: TLabel
      Left = 42
      Top = 200
      Width = 268
      Height = 30
      Alignment = taRightJustify
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Current Memory Allocated'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Bevel4: TBevel
      Left = 53
      Top = 195
      Width = 388
      Height = 2
      Anchors = [akLeft, akBottom]
      Shape = bsFrame
    end
    object Label12: TLabel
      Left = 254
      Top = 262
      Width = 141
      Height = 16
      Anchors = [akLeft, akBottom]
      Caption = ' (Just a MySQL server)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object AdvReflectionLabel1: TAdvReflectionLabel
      Left = 0
      Top = 0
      Width = 488
      Height = 60
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      HTMLText.Strings = (
        
          '<FONT  face="Arial" size="20" color="#808080">ERP </FONT><FONT f' +
          'ace="Arial" size="20"> Server Configuration</FONT><P align="cent' +
          'er"></P>')
      ParentFont = False
      ReflectionSize = 20
      URLColor = clBlue
      Version = '1.5.1.0'
    end
    object txtMem: TwwDBSpinEdit
      Left = 248
      Top = 286
      Width = 124
      Height = 26
      Anchors = [akLeft, akBottom]
      EditAlignment = eaRightAlignEditing
      Increment = 1.000000000000000000
      MinValue = 64.000000000000000000
      AutoFillDate = False
      AutoSelect = False
      AutoSize = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      UnboundDataType = wwDefault
      UsePictureMask = False
    end
    object TotalMem: TwwDBEdit
      Left = 315
      Top = 65
      Width = 121
      Height = 26
      TabStop = False
      Anchors = [akLeft, akBottom]
      AutoFillDate = False
      AutoSelect = False
      AutoSize = False
      Color = 15396334
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      UnboundDataType = wwDefault
      UnboundAlignment = taRightJustify
      WantReturns = False
      WordWrap = False
    end
    object RecommendedMem: TwwDBEdit
      Left = 315
      Top = 130
      Width = 121
      Height = 26
      TabStop = False
      Anchors = [akLeft, akBottom]
      AutoFillDate = False
      AutoSelect = False
      AutoSize = False
      Color = 15396334
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      UnboundDataType = wwDefault
      UnboundAlignment = taRightJustify
      WantReturns = False
      WordWrap = False
    end
    object chkDedicatedServer: TwwCheckBox
      Left = 93
      Top = 263
      Width = 14
      Height = 14
      TabStop = False
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Anchors = [akLeft, akBottom]
      TabOrder = 3
      OnClick = chkDedicatedServerClick
    end
    object MaxMem: TwwDBEdit
      Left = 315
      Top = 163
      Width = 121
      Height = 26
      TabStop = False
      Anchors = [akLeft, akBottom]
      AutoFillDate = False
      AutoSelect = False
      AutoSize = False
      Color = 15396334
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      UnboundDataType = wwDefault
      UnboundAlignment = taRightJustify
      WantReturns = False
      WordWrap = False
    end
    object MinMem: TwwDBEdit
      Left = 315
      Top = 97
      Width = 121
      Height = 26
      TabStop = False
      Anchors = [akLeft, akBottom]
      AutoFillDate = False
      AutoSelect = False
      AutoSize = False
      Color = 15396334
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
      UnboundDataType = wwDefault
      UnboundAlignment = taRightJustify
      WantReturns = False
      WordWrap = False
    end
    object CurrentMem: TwwDBEdit
      Left = 314
      Top = 202
      Width = 121
      Height = 26
      TabStop = False
      Anchors = [akLeft, akBottom]
      AutoFillDate = False
      AutoSelect = False
      AutoSize = False
      Color = 15396334
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
      UnboundDataType = wwDefault
      UnboundAlignment = taRightJustify
      WantReturns = False
      WordWrap = False
    end
    object UpdateBtn: TDNMSpeedButton
      Left = 62
      Top = 340
      Width = 106
      Height = 29
      Hint = '( only Platinum1 DB'#39's )'
      Anchors = [akBottom]
      Caption = 'Update'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Verdana'
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
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      SlowDecease = True
      Style = bsModern
      TabOrder = 7
      OnClick = UpdateBtnClick
    end
    object CloseBtn: TDNMSpeedButton
      Left = 317
      Top = 340
      Width = 106
      Height = 29
      Hint = '( only Platinum1 DB'#39's )'
      Anchors = [akBottom]
      Cancel = True
      Caption = 'Close'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Verdana'
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
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 2
      NumGlyphs = 2
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      SlowDecease = True
      Style = bsModern
      TabOrder = 8
      OnClick = CloseBtnClick
    end
  end
  object StatusBar: TAdvOfficeStatusBar
    Left = 0
    Top = 379
    Width = 488
    Height = 18
    AnchorHint = False
    AntiAlias = aaAntiAlias
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Panels = <
      item
        Alignment = taCenter
        AppearanceStyle = psLight
        DateFormat = 'mm/dd/yyyy'
        Progress.BackGround = clNone
        Progress.Indication = piPercentage
        Progress.Min = 0
        Progress.Max = 100
        Progress.Position = 0
        Progress.Level0Color = clLime
        Progress.Level0ColorTo = 14811105
        Progress.Level1Color = clYellow
        Progress.Level1ColorTo = 13303807
        Progress.Level2Color = 5483007
        Progress.Level2ColorTo = 11064319
        Progress.Level3Color = clRed
        Progress.Level3ColorTo = 13290239
        Progress.Level1Perc = 70
        Progress.Level2Perc = 90
        Progress.BorderColor = clBlack
        Progress.ShowBorder = False
        Progress.Stacked = False
        Style = psTime
        Text = '2:20 pm'
        TimeFormat = 'H:mm am/pm'
        Width = 65
      end
      item
        Alignment = taRightJustify
        AppearanceStyle = psLight
        DateFormat = 'mm/dd/yyyy'
        Enabled = False
        Progress.BackGround = clNone
        Progress.Indication = piPercentage
        Progress.Min = 0
        Progress.Max = 6
        Progress.Position = 0
        Progress.Level0Color = 7105644
        Progress.Level0ColorTo = clWhite
        Progress.Level1Color = 7105644
        Progress.Level1ColorTo = clWhite
        Progress.Level2Color = 7105644
        Progress.Level2ColorTo = clWhite
        Progress.Level3Color = 7105644
        Progress.Level3ColorTo = clWhite
        Progress.Level1Perc = 70
        Progress.Level2Perc = 90
        Progress.BorderColor = clBlack
        Progress.ShowBorder = False
        Progress.Stacked = False
        Progress.ShowPercentage = False
        Style = psProgress
        TimeFormat = 'hh:mm:ss'
        Width = 50
      end>
    ParentShowHint = False
    ShowHint = False
    SimplePanel = False
    URLColor = clBlue
    Styler = AdvOfficeStatusBarOfficeStyler1
    UseSystemFont = False
    Version = '1.3.0.2'
  end
  object dlgCurrentUsers: TSelectionDialog
    Caption = 'Platinum1 Users'
    Message = ' Current Platinum1 Users '
    MessageFont.Charset = ANSI_CHARSET
    MessageFont.Color = clNavy
    MessageFont.Height = -12
    MessageFont.Name = 'Arial'
    MessageFont.Style = [fsBold]
    Buttons = [sbOK]
    MultiSelect = False
    Width = 370
    Height = 250
    Color = clMoneyGreen
    Left = 5
    Top = 34
  end
  object MyConnection: TMyConnection
    Database = 'mysql'
    Port = 3309
    Username = 'P_One'
    Password = '1w$p&LD07'
    Server = 'LocalHost'
    LoginPrompt = False
    Left = 5
    Top = 4
  end
  object AdvPanelStyler1: TAdvPanelStyler
    Tag = 0
    Settings.AnchorHint = False
    Settings.AutoHideChildren = False
    Settings.BevelInner = bvNone
    Settings.BevelOuter = bvNone
    Settings.BevelWidth = 1
    Settings.BorderColor = clGray
    Settings.BorderShadow = True
    Settings.BorderStyle = bsNone
    Settings.BorderWidth = 0
    Settings.CanMove = False
    Settings.CanSize = False
    Settings.Caption.Color = clHighlight
    Settings.Caption.ColorTo = clBlue
    Settings.Caption.Font.Charset = DEFAULT_CHARSET
    Settings.Caption.Font.Color = clHighlightText
    Settings.Caption.Font.Height = -11
    Settings.Caption.Font.Name = 'Verdana'
    Settings.Caption.Font.Style = []
    Settings.Caption.Indent = 2
    Settings.Caption.ShadeLight = 255
    Settings.Caption.Visible = True
    Settings.Collaps = False
    Settings.CollapsColor = clBtnFace
    Settings.CollapsDelay = 0
    Settings.CollapsSteps = 0
    Settings.Color = clWhite
    Settings.ColorTo = 13226453
    Settings.ColorMirror = clNone
    Settings.ColorMirrorTo = clNone
    Settings.Cursor = crDefault
    Settings.Font.Charset = DEFAULT_CHARSET
    Settings.Font.Color = clWindowText
    Settings.Font.Height = -11
    Settings.Font.Name = 'Verdana'
    Settings.Font.Style = []
    Settings.FixedTop = False
    Settings.FixedLeft = False
    Settings.FixedHeight = False
    Settings.FixedWidth = False
    Settings.Height = 120
    Settings.Hover = False
    Settings.HoverColor = clNone
    Settings.HoverFontColor = clNone
    Settings.Indent = 0
    Settings.ShadowColor = clBlack
    Settings.ShadowOffset = 0
    Settings.ShowHint = False
    Settings.ShowMoveCursor = False
    Settings.StatusBar.BorderColor = clSilver
    Settings.StatusBar.BorderStyle = bsSingle
    Settings.StatusBar.Font.Charset = DEFAULT_CHARSET
    Settings.StatusBar.Font.Color = clBlack
    Settings.StatusBar.Font.Height = -11
    Settings.StatusBar.Font.Name = 'Tahoma'
    Settings.StatusBar.Font.Style = []
    Settings.StatusBar.Color = 14938354
    Settings.StatusBar.ColorTo = clWhite
    Settings.StatusBar.GradientDirection = gdVertical
    Settings.TextVAlign = tvaTop
    Settings.TopIndent = 0
    Settings.URLColor = clBlue
    Settings.Width = 0
    Style = psOffice2003Classic
    Left = 3
    Top = 65
  end
  object AdvOfficeStatusBarOfficeStyler1: TAdvOfficeStatusBarOfficeStyler
    Style = psOffice2003Classic
    BorderColor = 13226453
    PanelAppearanceLight.BorderColor = clNone
    PanelAppearanceLight.BorderColorHot = clGray
    PanelAppearanceLight.BorderColorDown = clBlack
    PanelAppearanceLight.Color = clWhite
    PanelAppearanceLight.ColorTo = 13226453
    PanelAppearanceLight.ColorHot = 13811126
    PanelAppearanceLight.ColorHotTo = 13811126
    PanelAppearanceLight.ColorDown = 14857624
    PanelAppearanceLight.ColorDownTo = 14857624
    PanelAppearanceLight.ColorMirror = clNone
    PanelAppearanceLight.ColorMirrorTo = clNone
    PanelAppearanceLight.ColorMirrorHot = 13811126
    PanelAppearanceLight.ColorMirrorHotTo = 13811126
    PanelAppearanceLight.ColorMirrorDown = clNone
    PanelAppearanceLight.ColorMirrorDownTo = clNone
    PanelAppearanceLight.TextColor = clBlack
    PanelAppearanceLight.TextColorHot = clBlack
    PanelAppearanceLight.TextColorDown = clBlack
    PanelAppearanceLight.TextStyle = []
    PanelAppearanceDark.BorderColor = clNone
    PanelAppearanceDark.BorderColorHot = clGray
    PanelAppearanceDark.BorderColorDown = clBlack
    PanelAppearanceDark.Color = clGray
    PanelAppearanceDark.ColorTo = clGray
    PanelAppearanceDark.ColorHot = 13811126
    PanelAppearanceDark.ColorHotTo = 13811126
    PanelAppearanceDark.ColorDown = 14857624
    PanelAppearanceDark.ColorDownTo = 14857624
    PanelAppearanceDark.ColorMirror = clNone
    PanelAppearanceDark.ColorMirrorTo = clNone
    PanelAppearanceDark.ColorMirrorHot = clNone
    PanelAppearanceDark.ColorMirrorHotTo = clNone
    PanelAppearanceDark.ColorMirrorDown = clNone
    PanelAppearanceDark.ColorMirrorDownTo = clNone
    PanelAppearanceDark.TextColor = clWhite
    PanelAppearanceDark.TextColorHot = clWhite
    PanelAppearanceDark.TextColorDown = clWhite
    PanelAppearanceDark.TextStyle = []
    Left = 4
    Top = 100
  end
end
