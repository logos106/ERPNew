object fmCopyBackup: TfmCopyBackup
  Left = 1114
  Top = 186
  HelpContext = 1239002
  Caption = 'Copy ERP backup'
  ClientHeight = 240
  ClientWidth = 411
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblFrom: TLabel
    Left = 56
    Top = 144
    Width = 34
    Height = 13
    HelpContext = 1239003
    Caption = 'lblFrom'
  end
  object lblto: TLabel
    Left = 56
    Top = 163
    Width = 31
    Height = 13
    HelpContext = 1239004
    Caption = 'Label1'
  end
  object btnchoosefile: TButton
    Left = 96
    Top = 73
    Width = 217
    Height = 25
    HelpContext = 1239005
    Caption = 'Choose Backup file to Copy'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btnchoosefileClick
    OnMouseMove = btnchoosefileMouseMove
  end
  object ProgressBar1: TProgressBar
    Left = 96
    Top = 104
    Width = 217
    Height = 25
    HelpContext = 1239006
    TabOrder = 1
    Visible = False
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'wfs'
    Filter = 'Old Backups|*.zip|New Backups|*.7z'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Title = 'Choose the Workflow Files'
    Left = 152
    Top = 32
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 312
    Top = 64
  end
end
