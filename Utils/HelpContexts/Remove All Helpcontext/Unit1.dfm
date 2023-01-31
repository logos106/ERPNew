object Form1: TForm1
  Left = 294
  Top = 263
  Width = 615
  Height = 359
  Caption = 'Form1'
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
    Left = 87
    Top = 13
    Width = 115
    Height = 25
    Caption = 'Find DFM'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 393
    Top = 13
    Width = 115
    Height = 25
    Caption = 'Reset HelpContext'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 47
    Top = 57
    Width = 478
    Height = 248
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 2
    WordWrap = False
  end
end
