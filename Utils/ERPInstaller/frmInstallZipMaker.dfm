object fmInstallZipMaker: TfmInstallZipMaker
  Left = 510
  Top = 356
  Width = 637
  Height = 457
  Caption = 'Install  Zip Maker'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 382
    Width = 629
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnMakeZip: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Make Zip'
      TabOrder = 0
      OnClick = btnMakeZipClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 629
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 49
      Height = 13
      Caption = 'Config File'
    end
    object Label2: TLabel
      Left = 200
      Top = 8
      Width = 65
      Height = 13
      Caption = 'Zip File Name'
    end
    object edtConfigFile: TEdit
      Left = 16
      Top = 24
      Width = 170
      Height = 21
      TabOrder = 0
      Text = 'InstallInfo.txt'
    end
    object edtZipName: TEdit
      Left = 200
      Top = 24
      Width = 170
      Height = 21
      TabOrder = 1
      Text = 'ErpInstallFiles.zip'
    end
  end
  object memLog: TMemo
    Left = 0
    Top = 65
    Width = 629
    Height = 317
    Align = alClient
    TabOrder = 2
  end
  object ZipKit: TAbZipKit
    AutoSave = False
    DOSMode = False
    ExtractOptions = []
    Left = 80
    Top = 64
  end
end
