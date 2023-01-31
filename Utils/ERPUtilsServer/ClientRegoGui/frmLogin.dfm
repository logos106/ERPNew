inherited fmLogin: TfmLogin
  Left = 456
  Top = 325
  VertScrollBar.Range = 0
  BorderStyle = bsSingle
  Caption = 'Login'
  ClientHeight = 154
  ClientWidth = 366
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 24
    Top = 32
    Width = 46
    Height = 13
    Caption = 'Database'
  end
  object Label2: TLabel [1]
    Left = 24
    Top = 64
    Width = 31
    Height = 13
    Caption = 'Server'
  end
  inherited pnlBottom: TPanel
    Top = 118
    Width = 366
    inherited btnOk: TButton
      Left = 111
    end
    inherited btnCancel: TButton
      Left = 195
    end
  end
  object edtDatabase: TEdit [3]
    Left = 80
    Top = 30
    Width = 241
    Height = 21
    TabOrder = 1
  end
  object edtServer: TEdit [4]
    Left = 80
    Top = 62
    Width = 241
    Height = 21
    TabOrder = 2
  end
  inherited alMain: TActionList
    Left = 256
    Top = 8
    inherited actOk: TAction
      OnExecute = actOkExecute
    end
    inherited actCancel: TAction
      OnExecute = actCancelExecute
    end
  end
  inherited TransConnection: TMyConnection
    Left = 296
    Top = 0
  end
end
