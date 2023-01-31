inherited fmServerEdit: TfmServerEdit
  Left = 592
  Top = 293
  VertScrollBar.Range = 0
  BorderStyle = bsSingle
  Caption = 'Local Server'
  ClientHeight = 163
  ClientWidth = 449
  PixelsPerInch = 96
  TextHeight = 15
  object Label2: TLabel [0]
    Left = 18
    Top = 80
    Width = 38
    Height = 15
    Caption = 'Server'
  end
  inherited pnlBottom: TDNMPanel
    Top = 108
    Width = 449
    Height = 55
    inherited btnOK: TDNMSpeedButton
      Left = 123
      OnClick = btnOKClick
    end
    inherited btnCancel: TDNMSpeedButton
      Left = 239
      OnClick = btnCancelClick
    end
  end
  inherited pnlTitle: TDNMPanel
    Left = 75
    Width = 300
    TabOrder = 2
    inherited TitleShader: TShader
      Width = 298
      inherited lblTitle: TLabel
        Width = 298
        Caption = 'Local Server'
      end
    end
  end
  object edtServer: TEdit
    Left = 74
    Top = 76
    Width = 343
    Height = 22
    Hint = 'Local ERP Server Name or IP'
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
end
