object fmLanguageConstants: TfmLanguageConstants
  Left = 277
  Top = 188
  HelpContext = 794001
  Caption = 'Export English Constants'
  ClientHeight = 549
  ClientWidth = 639
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object DNMPanel1: TDNMPanel
    Left = 0
    Top = 70
    Width = 639
    Height = 401
    HelpContext = 794002
    Align = alClient
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
      639
      401)
    object memDetails: TMemo
      Left = 1
      Top = 24
      Width = 637
      Height = 376
      HelpContext = 794003
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Lines.Strings = (
        '')
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object edtProjectFile: TEdit
      Left = 1
      Top = 1
      Width = 637
      Height = 23
      HelpContext = 794004
      Align = alTop
      TabOrder = 1
    end
    object memProjectFiles: TMemo
      Left = 208
      Top = 136
      Width = 161
      Height = 49
      HelpContext = 794005
      Anchors = [akLeft, akTop, akRight, akBottom]
      ScrollBars = ssBoth
      TabOrder = 2
      Visible = False
    end
    object memSQL: TMemo
      Left = 398
      Top = 136
      Width = 161
      Height = 49
      HelpContext = 794006
      Anchors = [akLeft, akTop, akRight, akBottom]
      ScrollBars = ssBoth
      TabOrder = 3
      Visible = False
    end
  end
  object DNMPanel2: TDNMPanel
    Left = 0
    Top = 471
    Width = 639
    Height = 78
    HelpContext = 794007
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 1
    Transparent = False
    object btnExportEnglishconst: TButton
      Left = 280
      Top = 40
      Width = 75
      Height = 25
      HelpContext = 794008
      Caption = 'Export'
      TabOrder = 0
      OnClick = btnExportEnglishconstClick
    end
    object edtFilename: TEdit
      Left = 8
      Top = 8
      Width = 596
      Height = 23
      HelpContext = 794009
      TabOrder = 1
    end
    object btnfilename: TDNMSpeedButton
      Left = 609
      Top = 8
      Width = 26
      Height = 21
      HelpContext = 794010
      Caption = '. . .'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      TabOrder = 2
      OnClick = btnfilenameClick
    end
    object Button1: TButton
      Left = 361
      Top = 40
      Width = 128
      Height = 25
      HelpContext = 794011
      Caption = 'help context IDs'
      TabOrder = 3
      OnClick = Button1Click
    end
  end
  object DNMPanel3: TDNMPanel
    Left = 0
    Top = 0
    Width = 639
    Height = 70
    HelpContext = 794012
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 2
    Transparent = False
    object pnlTitle: TDNMPanel
      Left = 77
      Top = 10
      Width = 484
      Height = 45
      HelpContext = 794013
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
        Width = 480
        Height = 41
        HelpContext = 794014
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
          Width = 480
          Height = 41
          HelpContext = 794015
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Export English Constants'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 234
        end
      end
    end
  end
  object OpenDialog: TOpenDialog
    Left = 256
    Top = 16
  end
end
