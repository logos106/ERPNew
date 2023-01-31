object fmMain: TfmMain
  Left = 95
  Top = 275
  Caption = 'Language Update Builder'
  ClientHeight = 295
  ClientWidth = 491
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
  object pcMain: TPageControl
    Left = 0
    Top = 0
    Width = 491
    Height = 295
    ActivePage = tsMain
    Align = alClient
    TabOrder = 0
    object tsMain: TTabSheet
      Caption = 'Main'
      DesignSize = (
        483
        265)
      object btnBuildUpdate: TButton
        Left = 16
        Top = 16
        Width = 105
        Height = 25
        Caption = 'Build Update'
        TabOrder = 0
        OnClick = btnBuildUpdateClick
      end
      object memLog: TMemo
        Left = 16
        Top = 56
        Width = 449
        Height = 184
        Anchors = [akLeft, akTop, akRight, akBottom]
        ScrollBars = ssBoth
        TabOrder = 1
      end
      object StatusBar: TStatusBar
        Left = 0
        Top = 246
        Width = 483
        Height = 19
        Panels = <>
        SimplePanel = True
      end
    end
    object tsConfig: TTabSheet
      Caption = 'Config'
      ImageIndex = 1
      object Label1: TLabel
        Left = 32
        Top = 16
        Width = 35
        Height = 15
        Alignment = taRightJustify
        Caption = 'Server'
      end
      object edtServerName: TEdit
        Left = 73
        Top = 13
        Width = 205
        Height = 23
        TabOrder = 0
        OnChange = edtServerNameChange
      end
    end
  end
  object dbDump: TMyDump
    OnBackupProgress = dbDumpBackupProgress
    Objects = [doTables, doData]
    Options.GenerateHeader = False
    Options.CompleteInsert = True
    Left = 256
    Top = 8
  end
  object Zipper: TAbZipper
    AutoSave = False
    DOSMode = False
    StoreOptions = [soStripDrive, soStripPath, soRemoveDots]
    Left = 216
    Top = 56
  end
  object dbConn: TERPConnection
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Left = 196
    Top = 10
  end
end
