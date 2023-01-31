object fmDatabaseBackup: TfmDatabaseBackup
  Left = 341
  Top = 26
  HelpContext = 902001
  BorderStyle = bsDialog
  Caption = 'fmDatabaseBackup'
  ClientHeight = 434
  ClientWidth = 367
  Color = 11390876
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    367
    434)
  PixelsPerInch = 96
  TextHeight = 15
  object lblProg1: TLabel
    Left = 14
    Top = 265
    Width = 339
    Height = 19
    HelpContext = 902002
    Alignment = taCenter
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Progress'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ProgBar1: TAdvProgressBar
    Left = 38
    Top = 292
    Width = 285
    Height = 25
    HelpContext = 902003
    Anchors = [akLeft, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    Level0ColorTo = 14811105
    Level1Color = clLime
    Level1ColorTo = 13303807
    Level2Color = clLime
    Level2ColorTo = 11064319
    Level3Color = clLime
    Level3ColorTo = 13290239
    Level1Perc = 70
    Level2Perc = 90
    Position = 0
    Rounded = False
    ShowBorder = True
    Steps = 100
    Version = '1.2.0.1'
  end
  object lblProg2: TLabel
    Left = 14
    Top = 327
    Width = 339
    Height = 19
    HelpContext = 902004
    Alignment = taCenter
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Message'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ProgBar2: TAdvProgressBar
    Left = 38
    Top = 351
    Width = 285
    Height = 25
    HelpContext = 902005
    Anchors = [akLeft, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    Level0ColorTo = 14811105
    Level1Color = clLime
    Level1ColorTo = 13303807
    Level2Color = clLime
    Level2ColorTo = 11064319
    Level3Color = clLime
    Level3ColorTo = 13290239
    Level1Perc = 70
    Level2Perc = 90
    Position = 0
    Rounded = False
    ShowBorder = True
    ShowPercentage = False
    ShowPosition = False
    Steps = 20
    Version = '1.2.0.1'
  end
  object btnOK: TDNMSpeedButton
    Left = 140
    Top = 392
    Width = 87
    Height = 27
    HelpContext = 902006
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Color = clWhite
    Default = True
    DisableTransparent = False
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
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
    HotTrackColor = clBtnShadow
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    MaxTextDisplay = False
    NumGlyphs = 2
    ParentColor = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    SlowDecease = True
    Style = bsModern
    TabOrder = 0
    TabStop = False
    WordWrap = True
    AutoDisableParentOnclick = True
    OnClick = btnOKClick
  end
  object memLog: TMemo
    Left = 21
    Top = 72
    Width = 325
    Height = 177
    HelpContext = 902007
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object pnlTitle: TDNMPanel
    Left = 30
    Top = 13
    Width = 307
    Height = 41
    HelpContext = 902008
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 303
      Height = 37
      HelpContext = 902009
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
        Width = 303
        Height = 37
        HelpContext = 902010
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Database Backup'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 326
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 56
    Top = 120
  end
end
