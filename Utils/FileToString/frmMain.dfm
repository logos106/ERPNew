object fmMain: TfmMain
  Left = 192
  Top = 190
  Width = 770
  Height = 499
  Caption = 'File To String'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 424
    Width = 762
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnFile: TButton
      Left = 24
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Read File'
      TabOrder = 0
      OnClick = btnFileClick
    end
  end
  object memText: TMemo
    Left = 0
    Top = 0
    Width = 762
    Height = 424
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object OpenDialog: TOpenDialog
    Left = 168
    Top = 8
  end
end
