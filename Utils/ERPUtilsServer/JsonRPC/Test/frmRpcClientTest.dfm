object fmRpcClientTest: TfmRpcClientTest
  Left = 695
  Top = 196
  Width = 567
  Height = 326
  Caption = 'fmRpcClientTest'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 16
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 0
    OnClick = Button1Click
  end
  object memLog: TMemo
    Left = 0
    Top = 56
    Width = 559
    Height = 236
    Align = alBottom
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object Button2: TButton
    Left = 192
    Top = 16
    Width = 89
    Height = 25
    Caption = 'Send Notiication'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 104
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Disconnect'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 288
    Top = 16
    Width = 89
    Height = 25
    Caption = 'Send Request'
    TabOrder = 4
    OnClick = Button4Click
  end
end
