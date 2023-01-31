object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'True ERP Messages Uploader'
  ClientHeight = 300
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 35
      Height = 15
      Caption = 'Server'
    end
    object Label2: TLabel
      Left = 16
      Top = 45
      Width = 54
      Height = 15
      Caption = 'Database'
    end
    object edtServer: TEdit
      Left = 88
      Top = 13
      Width = 153
      Height = 23
      TabOrder = 0
      Text = 'edtServer'
      OnChange = edtServerChange
    end
    object edtDatabase: TEdit
      Left = 88
      Top = 42
      Width = 153
      Height = 23
      TabOrder = 1
      Text = 'edtDatabase'
      OnChange = edtDatabaseChange
    end
    object btnUploadUpdates: TButton
      Left = 264
      Top = 12
      Width = 121
      Height = 25
      Caption = 'Upload Updates'
      TabOrder = 2
      OnClick = btnUploadUpdatesClick
    end
  end
  object memLog: TMemo
    Left = 0
    Top = 73
    Width = 635
    Height = 208
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 281
    Width = 635
    Height = 19
    Panels = <
      item
        Width = 300
      end>
  end
  object Zipper: TAbZipper
    AutoSave = False
    DOSMode = False
    StoreOptions = [soStripDrive, soStripPath, soRemoveDots]
    Left = 432
    Top = 8
  end
  object FtpClient: TIdFTP
    IPVersion = Id_IPv4
    TransferType = ftBinary
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 497
    Top = 6
  end
  object IdAntiFreeze1: TIdAntiFreeze
    IdleTimeOut = 50
    OnlyWhenIdle = False
    Left = 526
    Top = 5
  end
end
