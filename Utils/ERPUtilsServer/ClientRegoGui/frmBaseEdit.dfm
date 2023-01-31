inherited fmBaseEdit: TfmBaseEdit
  Left = 303
  Top = 283
  Width = 375
  Caption = 'fmBaseEdit'
  OldCreateOrder = True
  OnClose = FormClose
  OnPaint = nil
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 292
    Width = 367
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnOk: TButton
      Left = 15
      Top = 7
      Width = 65
      Height = 22
      Action = actOk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
    end
    object btnCancel: TButton
      Left = 92
      Top = 7
      Width = 65
      Height = 22
      Action = actCancel
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = False
    end
  end
  object alMain: TActionList
    Left = 48
    Top = 32
    object actOk: TAction
      Caption = 'Ok'
    end
    object actCancel: TAction
      Caption = 'Cancel'
    end
  end
  object TransConnection: TMyConnection
    Database = 'services'
    Port = 3309
    Username = 'P_One'
    Password = '1w$p&LD07'
    LoginPrompt = False
    Left = 88
    Top = 24
  end
end
