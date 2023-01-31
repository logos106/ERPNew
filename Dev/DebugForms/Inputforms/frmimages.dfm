inherited fmimages: Tfmimages
  Left = 461
  Top = 95
  Caption = 'Export ERP Images'
  ClientHeight = 191
  ClientWidth = 390
  Position = poMainFormCenter
  ExplicitLeft = 461
  ExplicitTop = 95
  ExplicitWidth = 398
  ExplicitHeight = 218
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1106002
  inherited lblSkingroupMsg: TLabel
    Top = 191
    Width = 390
    ExplicitTop = 751
    ExplicitWidth = 1142
    HelpContext = 1106003
  end
  object Image1: TImage [1]
    Left = 354
    Top = 57
    Width = 21
    Height = 28
    Visible = False
    HelpContext = 1106004
  end
  object Label1: TLabel [2]
    Left = 32
    Top = 64
    Width = 153
    Height = 15
    Caption = 'Select Path for Small icons'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    HelpContext = 1106005
  end
  object Label2: TLabel [3]
    Left = 32
    Top = 117
    Width = 154
    Height = 15
    Caption = 'Select Path for Large icons'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    HelpContext = 1106006
  end
  object lblSmall: TLabel [4]
    Left = 32
    Top = 80
    Width = 33
    Height = 13
    Caption = 'lblsmall'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    HelpContext = 1106007
  end
  object lblLarge: TLabel [5]
    Left = 32
    Top = 135
    Width = 37
    Height = 13
    Caption = 'lblLarge'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    HelpContext = 1106008
  end
  object DNMSpeedButton1: TDNMSpeedButton [6]
    Left = 130
    Top = 160
    Width = 100
    Height = 23
    Caption = 'Export'
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
    TabOrder = 0
    OnClick = DNMSpeedButton1Click
    HelpContext = 1106009
  end
  object pnlTitle: TDNMPanel [7]
    Left = 12
    Top = 6
    Width = 365
    Height = 45
    HelpContext = 1106010
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
      Width = 361
      Height = 41
      HelpContext = 1106011
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
        Width = 361
        Height = 41
        HelpContext = 1106012
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Export ERP Images'
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
  object btnsmall: TDNMSpeedButton [8]
    Left = 200
    Top = 60
    Width = 30
    Height = 23
    Caption = '. . .'
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
    OnClick = btnsmallClick
    HelpContext = 1106013
  end
  object btnlarge: TDNMSpeedButton [9]
    Left = 200
    Top = 113
    Width = 30
    Height = 23
    Caption = '. . .'
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
    OnClick = btnlargeClick
    HelpContext = 1106014
  end
  inherited tmrProcessMessage: TTimer
    Left = 273
    Top = 123
  end
  inherited tmrdelay: TTimer
    Left = 240
    Top = 120
  end
end
