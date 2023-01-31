inherited fmDatabaseEdit: TfmDatabaseEdit
  Left = 308
  Top = 265
  VertScrollBar.Range = 0
  BorderStyle = bsSingle
  Caption = 'Database'
  ClientHeight = 183
  ClientWidth = 464
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 32
    Top = 26
    Width = 77
    Height = 13
    Caption = 'Database Name'
  end
  object Label2: TLabel [1]
    Left = 32
    Top = 58
    Width = 69
    Height = 13
    Caption = 'Check Interval'
  end
  inherited pnlBottom: TDNMPanel
    Top = 132
    Width = 464
    inherited btnOK: TDNMSpeedButton
      Left = 125
      OnClick = btnOKClick
    end
    inherited btnCancel: TDNMSpeedButton
      Left = 253
      OnClick = btnCancelClick
    end
  end
  object edtDatabaseName: TEdit
    Left = 120
    Top = 24
    Width = 305
    Height = 21
    TabOrder = 1
  end
  object edtInterval: TMaskEdit
    Left = 120
    Top = 56
    Width = 49
    Height = 21
    EditMask = '!00:00;1;_'
    MaxLength = 5
    TabOrder = 2
    Text = '  :  '
  end
  object chkSyncActive: TCheckBox
    Left = 120
    Top = 88
    Width = 201
    Height = 17
    Caption = 'Synchronization Active'
    TabOrder = 3
  end
end
