object fmMain: TfmMain
  Left = 297
  Top = 224
  Caption = 'Encrypted Config Edit'
  ClientHeight = 382
  ClientWidth = 594
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 341
    Width = 594
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnOpen: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Open'
      TabOrder = 0
      OnClick = btnOpenClick
    end
    object btnSave: TButton
      Left = 96
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 1
      OnClick = btnSaveClick
    end
  end
  object memEdit: TMemo
    Left = 0
    Top = 0
    Width = 594
    Height = 341
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 1
    OnChange = memEditChange
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'cfg'
    Filter = 'Config Files|*.cfg|All Files|*.*'
    Left = 216
    Top = 8
  end
end
