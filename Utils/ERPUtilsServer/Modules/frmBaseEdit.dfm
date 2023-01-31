inherited fmBaseEdit: TfmBaseEdit
  Caption = 'fmBaseEdit'
  OldCreateOrder = True
  OnPaint = nil
  DesignSize = (
    472
    328)
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TDNMPanel
    Left = 0
    Top = 278
    Width = 472
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    Color = clActiveBorder
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object btnOK: TDNMSpeedButton
      Left = 174
      Top = 13
      Width = 76
      Height = 23
      Caption = 'OK'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      SlowDecease = True
      Style = bsModern
      TabOrder = 0
    end
    object btnCancel: TDNMSpeedButton
      Left = 302
      Top = 13
      Width = 75
      Height = 23
      Caption = 'Cancel'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      SlowDecease = True
      Style = bsModern
      TabOrder = 1
    end
  end
  object pnlTitle: TDNMPanel
    Left = 77
    Top = 13
    Width = 369
    Height = 30
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 367
      Height = 28
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
      object lblTitle: TLabel
        Left = 0
        Top = 0
        Width = 367
        Height = 28
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -25
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
    end
  end
end
