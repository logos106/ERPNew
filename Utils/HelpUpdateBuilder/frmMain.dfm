object fmMain: TfmMain
  Left = 533
  Top = 244
  Caption = 'Help Update Builder'
  ClientHeight = 157
  ClientWidth = 461
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
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 461
    Height = 157
    ActivePage = Main
    Align = alClient
    TabOrder = 0
    object Main: TTabSheet
      Caption = 'Main'
      object pnlBottom: TPanel
        Left = 0
        Top = 88
        Width = 453
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object btnExport: TButton
          Left = 16
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Export'
          TabOrder = 0
          OnClick = btnExportClick
        end
      end
    end
    object Config: TTabSheet
      Caption = 'Config'
      ImageIndex = 1
      object Label1: TLabel
        Left = 16
        Top = 16
        Width = 31
        Height = 13
        Caption = 'Server'
      end
      object Label2: TLabel
        Left = 16
        Top = 72
        Width = 19
        Height = 13
        Caption = 'Port'
      end
      object edtServer: TEdit
        Left = 16
        Top = 32
        Width = 201
        Height = 21
        TabOrder = 0
        OnChange = edtServerChange
      end
      object edtPort: TEdit
        Left = 16
        Top = 88
        Width = 73
        Height = 21
        TabOrder = 1
        OnChange = edtPortChange
      end
    end
  end
  object dbConn: TMyConnection
    Left = 200
    Top = 8
  end
  object dbDump: TMyDump
    Objects = [doData]
    Left = 256
    Top = 8
  end
  object Zipper: TAbZipper
    AutoSave = False
    DOSMode = False
    Left = 200
    Top = 56
  end
end
