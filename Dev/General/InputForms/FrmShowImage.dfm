inherited fmShowImage: TfmShowImage
  Caption = 'fmShowImage'
  ClientHeight = 355
  ClientWidth = 564
  Position = poMainFormCenter
  ExplicitWidth = 572
  ExplicitHeight = 382
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1054002
  inherited lblSkingroupMsg: TLabel
    Top = 305
    Width = 564
    ExplicitTop = 305
    ExplicitWidth = 564
    HelpContext = 1054003
  end
  object DNMPanel1: TDNMPanel [1]
    Left = 0
    Top = 65
    Width = 564
    Height = 240
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    HelpContext = 1054004
    object advPicture: TAdvPicture
      AlignWithMargins = True
      Left = 7
      Top = 22
      Width = 550
      Height = 196
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Animate = False
      Picture.Stretch = False
      Picture.Frame = 0
      PicturePosition = bpCenter
      Align = alClient
      StretchMode = smShrink
      Version = '1.4.0.0'
      ExplicitLeft = 232
      ExplicitTop = 72
      ExplicitWidth = 100
      ExplicitHeight = 100
      HelpContext = 1054005
    end
    object LblDescription: TLabel
      Left = 1
      Top = 1
      Width = 562
      Height = 15
      Align = alTop
      Caption = 'LblDescription'
      WordWrap = True
      ExplicitWidth = 82
      HelpContext = 1054006
    end
    object lblfooter: TLabel
      Left = 1
      Top = 224
      Width = 562
      Height = 15
      Align = alBottom
      Alignment = taRightJustify
      Caption = 'LblDescription'
      WordWrap = True
      ExplicitLeft = 481
      ExplicitWidth = 82
      HelpContext = 1054007
    end
  end
  object DNMPanel2: TDNMPanel [2]
    Left = 0
    Top = 0
    Width = 564
    Height = 65
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      564
      65)
    HelpContext = 1054008
    object pnlHeader: TPanel
      Left = 54
      Top = 8
      Width = 459
      Height = 49
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      HelpContext = 1054009
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 457
        Height = 47
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
        HelpContext = 1054010
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 457
          Height = 47
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = -1
          ExplicitTop = 3
          HelpContext = 1054011
        end
      end
    end
  end
  object DNMPanel3: TDNMPanel [3]
    Left = 0
    Top = 305
    Width = 564
    Height = 50
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      564
      50)
    HelpContext = 1054012
    object cmdClose: TDNMSpeedButton
      Left = 234
      Top = 12
      Width = 87
      Height = 27
      Hint = '"Close The List"'
      Anchors = [akBottom]
      Caption = '&Close'
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
      ModalResult = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      OnClick = cmdCloseClick
      HelpContext = 1054013
    end
  end
end
