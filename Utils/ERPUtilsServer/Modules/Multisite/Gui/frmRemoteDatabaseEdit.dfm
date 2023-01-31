inherited fmRemoteDatabaseEdit: TfmRemoteDatabaseEdit
  Left = 1450
  Top = 122
  VertScrollBar.Range = 0
  BorderStyle = bsSingle
  Caption = 'Remote Site'
  ClientHeight = 208
  ClientWidth = 463
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel [0]
    Left = 18
    Top = 124
    Width = 90
    Height = 15
    Caption = 'Database Name'
  end
  object Label2: TLabel [1]
    Left = 18
    Top = 88
    Width = 38
    Height = 15
    Caption = 'Server'
  end
  inherited pnlBottom: TDNMPanel
    Top = 162
    Width = 463
    Height = 46
    inherited btnOK: TDNMSpeedButton
      Left = 126
      Top = 7
      OnClick = btnOKClick
    end
    inherited btnCancel: TDNMSpeedButton
      Left = 250
      Top = 7
      OnClick = btnCancelClick
    end
  end
  inherited pnlTitle: TDNMPanel
    Left = 81
    Width = 300
    TabOrder = 3
    inherited TitleShader: TShader
      Width = 298
      inherited lblTitle: TLabel
        Width = 298
        Caption = 'Remote Database'
      end
    end
  end
  object edtDatabaseName: TEdit
    Left = 120
    Top = 122
    Width = 313
    Height = 23
    Hint = 'Remote Company File Name'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object edtServer: TEdit
    Left = 120
    Top = 84
    Width = 313
    Height = 23
    Hint = 'Remote ERP Server Name  or IP'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
end
