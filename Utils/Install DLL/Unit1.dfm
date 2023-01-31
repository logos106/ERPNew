object Form1: TForm1
  Left = 196
  Top = 107
  Width = 783
  Height = 540
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 145
    Top = 193
    Width = 75
    Height = 25
    Caption = 'BitBtn1'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object FolderDialog1: TFolderDialog
    Directory = '\\192.168.63.11'
    Options = [fdoBrowseForComputer, fdoReturnFSAncestors]
    DialogX = 0
    DialogY = 0
    Version = '1.0.1.1'
    Left = 129
    Top = 118
  end
  object IdFinger1: TIdFinger
    MaxLineAction = maException
    Port = 79
    CompleteQuery = '@'
    Left = 232
    Top = 116
  end
  object OpenDialog1: TOpenDialog
    Options = [ofShareAware, ofNoNetworkButton, ofEnableSizing, ofDontAddToRecent, ofForceShowHidden]
    Left = 184
    Top = 122
  end
end
