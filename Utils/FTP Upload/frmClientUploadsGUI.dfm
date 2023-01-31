object ClientUploadsGUI: TClientUploadsGUI
  Left = 306
  Top = 151
  BorderStyle = bsSingle
  Caption = 'File Uploader'
  ClientHeight = 441
  ClientWidth = 651
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 651
    Height = 441
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
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
    Caption.Font.Name = 'MS Sans Serif'
    Caption.Font.Style = []
    Caption.Indent = 2
    CollapsColor = clBtnFace
    CollapsDelay = 0
    ColorTo = 14938354
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
    Styler = AdvPanelStyler1
    DesignSize = (
      651
      441)
    FullHeight = 0
    object Bevel2: TBevel
      Left = 6
      Top = 65
      Width = 639
      Height = 44
    end
    object lblUploadSummary: TLabel
      Left = 6
      Top = 325
      Width = 639
      Height = 19
      Anchors = [akLeft, akRight, akBottom]
      AutoSize = False
      Caption = ' '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Letter_Label: TLabel
      Left = 7
      Top = 115
      Width = 177
      Height = 18
      AutoSize = False
      Caption = 'Selected Files For Upload :  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object lblCompanyName: TLabel
      Left = 21
      Top = 78
      Width = 103
      Height = 18
      AutoSize = False
      Caption = 'Company Name '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object ProgressBar1: TGauge
      Left = 6
      Top = 346
      Width = 639
      Height = 22
      Color = clNone
      ForeColor = clNavy
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      Progress = 0
      ShowHint = False
    end
    object Label2: TLabel
      Left = 395
      Top = 115
      Width = 248
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = '(Drag && Drop Files OR Right Click For Menu)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object FilesList: TMemo
      Left = 6
      Top = 134
      Width = 639
      Height = 186
      Cursor = crArrow
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelKind = bkSoft
      DragCursor = crMultiDrag
      DragMode = dmAutomatic
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      OEMConvert = True
      ParentFont = False
      PopupMenu = PopupMenu
      ReadOnly = True
      TabOrder = 0
      WordWrap = False
    end
    object txtCompanyName: TEdit
      Left = 125
      Top = 76
      Width = 498
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object BtnUploadFiles: TDNMSpeedButton
      Left = 23
      Top = 380
      Width = 140
      Height = 30
      Anchors = [akLeft, akBottom]
      Caption = 'Upload Files'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
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
      ModalResult = 1
      NumGlyphs = 2
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 2
      OnClick = BtnUploadFilesClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 490
      Top = 380
      Width = 140
      Height = 30
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
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
      Kind = bkCancel
      ModalResult = 2
      NumGlyphs = 2
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 3
      OnClick = btnCancelClick
    end
    object StatusBar1: TAdvOfficeStatusBar
      Left = 0
      Top = 418
      Width = 651
      Height = 23
      AnchorHint = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInfoText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      Panels = <
        item
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
          TimeFormat = 'hh:mm:ss'
          Width = 80
        end>
      SimplePanel = False
      URLColor = clBlue
      Styler = AdvOfficeStatusBarOfficeStyler2
      UseSystemFont = False
      Version = '1.3.0.2'
    end
    object pnlHeader: TPanel
      Left = 157
      Top = 7
      Width = 336
      Height = 49
      HelpContext = 46023
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 5
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 334
        Height = 47
        HelpContext = 46024
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
          Width = 334
          Height = 47
          HelpContext = 46025
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'File Uploader'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'All Files (*.*)|*.*'
    Left = 14
    Top = 7
  end
  object PopupMenu: TPopupMenu
    Left = 11
    Top = 131
    object AddFiles1: TMenuItem
      Caption = 'Add Files'
      OnClick = AddFiles1Click
    end
    object ClearFiles1: TMenuItem
      Caption = 'Clear Files'
      OnClick = ClearFiles1Click
    end
  end
  object IdAntiFreeze1: TIdAntiFreeze
    IdleTimeOut = 50
    OnlyWhenIdle = False
    Left = 94
    Top = 5
  end
  object FtpClient: TIdFTP
    IPVersion = Id_IPv4
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 65
    Top = 6
  end
  object AdvOfficeStatusBarOfficeStyler2: TAdvOfficeStatusBarOfficeStyler
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
    Left = 609
    Top = 1
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
    Settings.Caption.Font.Name = 'MS Sans Serif'
    Settings.Caption.Font.Style = []
    Settings.Caption.Indent = 2
    Settings.Collaps = False
    Settings.CollapsColor = clBtnFace
    Settings.CollapsDelay = 0
    Settings.CollapsSteps = 0
    Settings.Color = clWhite
    Settings.ColorTo = 14938354
    Settings.ColorMirror = clNone
    Settings.ColorMirrorTo = clNone
    Settings.Cursor = crDefault
    Settings.Font.Charset = DEFAULT_CHARSET
    Settings.Font.Color = clWindowText
    Settings.Font.Height = -11
    Settings.Font.Name = 'MS Sans Serif'
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
    Settings.TextVAlign = tvaTop
    Settings.TopIndent = 0
    Settings.URLColor = clBlue
    Settings.Width = 0
    Left = 575
    Top = 1
  end
end
