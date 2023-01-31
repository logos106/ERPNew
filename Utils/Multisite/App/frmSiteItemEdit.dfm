inherited fmSiteItemEdit: TfmSiteItemEdit
  Left = 592
  Top = 293
  VertScrollBar.Range = 0
  BorderStyle = bsSingle
  Caption = 'Remote Site'
  ClientHeight = 172
  ClientWidth = 504
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 16
    Top = 66
    Width = 77
    Height = 13
    Caption = 'Database Name'
  end
  object Label2: TLabel [1]
    Left = 16
    Top = 28
    Width = 31
    Height = 13
    Caption = 'Server'
  end
  inherited pnlBottom: TDNMPanel
    Top = 121
    Width = 504
    inherited btnOK: TDNMSpeedButton
      Left = 145
      OnClick = btnOKClick
    end
    inherited btnCancel: TDNMSpeedButton
      Left = 273
      OnClick = btnCancelClick
    end
  end
  object edtDatabaseName: TEdit
    Left = 104
    Top = 64
    Width = 353
    Height = 21
    TabOrder = 1
  end
  object edtServer: TEdit
    Left = 104
    Top = 24
    Width = 353
    Height = 21
    TabOrder = 2
  end
end
