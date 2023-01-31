object fmModuleLog: TfmModuleLog
  Left = 352
  Top = 294
  Caption = 'Log'
  ClientHeight = 527
  ClientWidth = 679
  Color = 16770790
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    679
    527)
  PixelsPerInch = 96
  TextHeight = 15
  object pnlTitle: TDNMPanel
    Left = 137
    Top = 15
    Width = 405
    Height = 35
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 403
      Height = 33
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
      object lblTitle: TLabel
        Left = 0
        Top = 0
        Width = 403
        Height = 33
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Log'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 448
      end
    end
  end
  object btnClose: TDNMSpeedButton
    Left = 296
    Top = 493
    Width = 87
    Height = 27
    Anchors = [akBottom]
    Caption = 'Close'
    DisableTransparent = False
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Style = bsModern
    TabOrder = 1
    AutoDisableParentOnclick = True
    OnClick = btnCloseClick
  end
  object memLog: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 66
    Width = 673
    Height = 353
    Margins.Top = 66
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object optLog: TRadioGroup
    AlignWithMargins = True
    Left = 111
    Top = 425
    Width = 457
    Height = 47
    Margins.Left = 111
    Margins.Right = 111
    Margins.Bottom = 55
    Align = alBottom
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      'Full Log'
      'Short Log'
      'Clear Large Log')
    TabOrder = 3
    OnClick = optLogClick
  end
end
