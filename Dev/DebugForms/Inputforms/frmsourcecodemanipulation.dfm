object fmsourcecodemanipulation: Tfmsourcecodemanipulation
  Left = 0
  Top = 0
  Caption = 'Source Code  Manipulation'
  ClientHeight = 578
  ClientWidth = 801
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DNMPanel3: TDNMPanel
    Left = 0
    Top = 0
    Width = 801
    Height = 76
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    Transparent = False
    object pnlTitle: TDNMPanel
      Left = 150
      Top = 10
      Width = 484
      Height = 45
      HelpContext = 304014
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
        HelpContext = 304015
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
          HelpContext = 304016
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Source Code  Manipulation'
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
  object DNMPanel1: TDNMPanel
    Left = 0
    Top = 76
    Width = 801
    Height = 424
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 1
    Transparent = False
    ExplicitTop = 70
    ExplicitWidth = 639
    ExplicitHeight = 401
    DesignSize = (
      801
      424)
    object memdetails: TMemo
      Left = 1
      Top = 24
      Width = 799
      Height = 399
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
      ExplicitWidth = 637
      ExplicitHeight = 376
    end
    object memProjectFiles: TMemo
      Left = 208
      Top = 136
      Width = 161
      Height = 43
      Anchors = [akLeft, akTop, akRight, akBottom]
      ScrollBars = ssBoth
      TabOrder = 1
      Visible = False
      ExplicitHeight = 49
    end
    object edtProjectFile: TEdit
      Left = 1
      Top = 1
      Width = 799
      Height = 23
      Align = alTop
      TabOrder = 2
      ExplicitWidth = 637
    end
  end
  object DNMPanel2: TDNMPanel
    Left = 0
    Top = 500
    Width = 801
    Height = 78
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 2
    Transparent = False
    ExplicitTop = 471
    ExplicitWidth = 639
    object btnExportEnglishconst: TButton
      Left = 280
      Top = 40
      Width = 193
      Height = 25
      Caption = 'Replace.caption'
      TabOrder = 0
      OnClick = btnExportEnglishconstClick
    end
    object edtFilename: TEdit
      Left = 8
      Top = 8
      Width = 745
      Height = 23
      TabOrder = 1
    end
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 768
      Top = 8
      Width = 26
      Height = 21
      Caption = '. . .'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      TabOrder = 2
    end
  end
end
