inherited fmServerConnect: TfmServerConnect
  Left = 424
  Top = 239
  VertScrollBar.Range = 0
  BorderStyle = bsSingle
  Caption = 'Connect To Server'
  ClientHeight = 172
  ClientWidth = 412
  ParentFont = True
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel [0]
    Left = 26
    Top = 86
    Width = 42
    Height = 16
    Caption = 'Server'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel [1]
    Left = 26
    Top = 122
    Width = 26
    Height = 16
    Caption = 'Port'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  inherited pnlBottom: TDNMPanel
    Top = 128
    Width = 412
    Height = 44
    TabOrder = 2
    inherited btnOK: TDNMSpeedButton
      Left = 105
      Top = 8
      ModalResult = 1
    end
    inherited btnCancel: TDNMSpeedButton
      Left = 219
      Top = 8
      ModalResult = 2
    end
  end
  inherited pnlTitle: TDNMPanel
    Left = 83
    Top = 20
    Width = 247
    TabOrder = 3
    inherited TitleShader: TShader
      Width = 245
      inherited lblTitle: TLabel
        Width = 245
        Caption = 'Connect'
      end
    end
  end
  object edtServer: TEdit
    Left = 82
    Top = 83
    Width = 297
    Height = 23
    Hint = 'Utilities Service Server Name or IP'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object edtPort: TAdvEdit
    Left = 82
    Top = 120
    Width = 75
    Height = 23
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = '0'
    Visible = False
    Version = '2.7.5.0'
  end
end
