inherited fmERPMessagePopup: TfmERPMessagePopup
  HelpContext = 1282002
  Caption = 'fmERPMessagePopup'
  ClientHeight = 382
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 320
  ExplicitHeight = 421
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 382
    ExplicitTop = 382
  end
  object pnlMsg: TPanel [4]
    Left = 0
    Top = 0
    Width = 284
    Height = 382
    HelpContext = 1282003
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    Padding.Left = 3
    Padding.Top = 3
    Padding.Right = 3
    Padding.Bottom = 3
    ParentFont = False
    TabOrder = 0
    object lblMsg: TLabel
      Left = 4
      Top = 4
      Width = 4
      Height = 17
      HelpContext = 1282004
      Align = alTop
      Alignment = taCenter
      WordWrap = True
    end
    object lbltime: TLabel
      Left = 4
      Top = 364
      Width = 79
      Height = 14
      HelpContext = 1282005
      Align = alBottom
      Alignment = taCenter
      Caption = '(10 Second(s))'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblLink: TLabel
      Left = 4
      Top = 21
      Width = 3
      Height = 15
      Cursor = crHandPoint
      HelpContext = 1282006
      Align = alTop
      Alignment = taCenter
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsUnderline]
      ParentFont = False
      WordWrap = True
      OnClick = lblLinkClick
    end
  end
  object popNew: TAdvSmoothPopup
    ShadowIntensity = 0.900000000000000000
    Height = 100
    Width = 300
    ArrowPosition = paBottomRight
    Buttons = <
      item
        Caption = 'Hide'
        Position = bpTopRight
      end>
    ButtonFont.Charset = DEFAULT_CHARSET
    ButtonFont.Color = clWhite
    ButtonFont.Height = -11
    ButtonFont.Name = 'Tahoma'
    ButtonFont.Style = []
    OnButtonClick = popNewButtonClick
    HeaderCaption = 'Header'
    FooterCaption = 'Footer'
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWhite
    FooterFont.Height = -16
    FooterFont.Name = 'Tahoma'
    FooterFont.Style = [fsBold]
    HeaderFont.Charset = ANSI_CHARSET
    HeaderFont.Color = clWhite
    HeaderFont.Height = -19
    HeaderFont.Name = 'Arial'
    HeaderFont.Style = [fsBold]
    Left = 240
    Top = 32
  end
  object tmrDelayMethod: TTimer
    Enabled = False
    OnTimer = tmrDelayMethodTimer
    Left = 160
    Top = 56
  end
end
