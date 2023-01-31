inherited fmImportDataMappingFormatBoolean: TfmImportDataMappingFormatBoolean
  Caption = 'Boolean Format'
  ClientHeight = 134
  ExplicitHeight = 166
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 850001
  object Label1: TLabel [2]
    Left = 84
    Top = 34
    Width = 40
    Height = 15
    Caption = 'Format'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    HelpContext = 850002
  end
  inherited btnSave: TDNMSpeedButton
    Top = 91
    ExplicitLeft = 100
    ExplicitTop = 91
  end
  inherited btnCancel: TDNMSpeedButton
    Top = 91
    ExplicitLeft = 204
    ExplicitTop = 91
  end
  object cboFormat: TComboBox
    Left = 136
    Top = 28
    Width = 169
    Height = 23
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Items.Strings = (
      'true/false'
      't/f'
      'yes/no'
      'y/n')
    HelpContext = 850003
  end
end
