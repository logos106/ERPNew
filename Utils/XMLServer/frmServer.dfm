object fmServer: TfmServer
  Left = 431
  Top = 207
  Width = 684
  Height = 649
  Caption = 'TCP XML Server'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 676
    Height = 81
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblStatus: TLabel
      Left = 204
      Top = 21
      Width = 40
      Height = 13
      Caption = 'Stopped'
    end
    object Button1: TButton
      Left = 24
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 112
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Stop'
      TabOrder = 1
      OnClick = Button2Click
    end
    object memEvents: TMemo
      Left = 320
      Top = 3
      Width = 294
      Height = 72
      ScrollBars = ssVertical
      TabOrder = 2
    end
  end
  object memLog: TMemo
    Left = 0
    Top = 81
    Width = 676
    Height = 534
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 1
  end
end
