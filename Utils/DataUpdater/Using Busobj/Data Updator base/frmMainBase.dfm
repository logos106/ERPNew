object fmMainBase: TfmMainBase
  Left = 231
  Top = 211
  Caption = 'Data Updater'
  ClientHeight = 471
  ClientWidth = 565
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 565
    Height = 105
    Align = alTop
    BevelOuter = bvNone
    Color = clSilver
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 16
      Width = 71
      Height = 16
      Alignment = taRightJustify
      Caption = 'Description:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblDescription: TLabel
      Left = 104
      Top = 16
      Width = 433
      Height = 73
      AutoSize = False
      Caption = 'Data update.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 421
    Width = 565
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    Color = clSilver
    TabOrder = 1
    object btnStartUpdate: TDNMSpeedButton
      Left = 15
      Top = 8
      Width = 100
      Height = 33
      Caption = 'Start Update'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      SlowDecease = True
      Style = bsModern
      TabOrder = 0
      OnClick = btnStartUpdateClick
    end
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 105
    Width = 17
    Height = 316
    Align = alLeft
    BevelOuter = bvNone
    Color = clSilver
    TabOrder = 2
  end
  object pnlRight: TPanel
    Left = 548
    Top = 105
    Width = 17
    Height = 316
    Align = alRight
    BevelOuter = bvNone
    Color = clSilver
    TabOrder = 3
  end
  object memLog: TMemo
    Left = 17
    Top = 105
    Width = 531
    Height = 316
    Align = alClient
    Color = clScrollBar
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 4
    WordWrap = False
  end
  object DbConn: TMyConnection
    Left = 192
    Top = 48
  end
  object Script: TMyScript
    Left = 248
    Top = 48
  end
end
