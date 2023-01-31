object fmModuleTest: TfmModuleTest
  Left = 0
  Top = 0
  Caption = 'Module Test'
  ClientHeight = 300
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 14
  object Button1: TButton
    Left = 8
    Top = 16
    Width = 113
    Height = 25
    Caption = 'Load Module'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 47
    Width = 113
    Height = 25
    Caption = 'Unload Module'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 160
    Top = 18
    Width = 297
    Height = 22
    TabOrder = 2
    Text = 'Edit1'
  end
  object Button3: TButton
    Left = 472
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Send'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 78
    Width = 113
    Height = 25
    Caption = 'Restart'
    TabOrder = 4
    OnClick = Button4Click
  end
end
