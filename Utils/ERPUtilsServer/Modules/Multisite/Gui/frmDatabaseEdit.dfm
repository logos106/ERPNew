inherited fmDatabaseEdit: TfmDatabaseEdit
  Left = 1589
  Top = 199
  VertScrollBar.Range = 0
  BorderStyle = bsSingle
  Caption = 'Local Database'
  ClientHeight = 224
  ClientWidth = 486
  ParentFont = True
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel [0]
    Left = 37
    Top = 78
    Width = 90
    Height = 15
    Caption = 'Database Name'
  end
  object Label2: TLabel [1]
    Left = 37
    Top = 115
    Width = 81
    Height = 15
    Caption = 'Check Interval'
  end
  inherited pnlBottom: TDNMPanel
    Top = 182
    Width = 486
    Height = 42
    inherited btnOK: TDNMSpeedButton
      Left = 134
      Top = 6
      OnClick = btnOKClick
    end
    inherited btnCancel: TDNMSpeedButton
      Left = 266
      Top = 6
      OnClick = btnCancelClick
    end
  end
  inherited pnlTitle: TDNMPanel
    Left = 93
    Width = 300
    TabOrder = 4
    inherited TitleShader: TShader
      Width = 298
      inherited lblTitle: TLabel
        Width = 298
        Caption = 'Local Database'
      end
    end
  end
  object edtDatabaseName: TEdit
    Left = 138
    Top = 76
    Width = 311
    Height = 23
    Hint = 'Enter your Company File Name'
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
  object edtInterval: TMaskEdit
    Left = 138
    Top = 113
    Width = 63
    Height = 23
    Hint = 'Enter the Time Between Each Cycle'
    EditMask = '!00:00:00;1;_'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 8
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Text = '  :  :  '
  end
  object chkSyncActive: TCheckBox
    Left = 138
    Top = 150
    Width = 232
    Height = 19
    Hint = 'Check here to Enable Synchronization '
    Caption = 'Synchronization Active'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
end
