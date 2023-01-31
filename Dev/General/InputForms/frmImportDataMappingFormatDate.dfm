inherited fmImportDataMappingFormatDate: TfmImportDataMappingFormatDate
  Caption = 'Date / Time Format'
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 849001
  object Label1: TLabel [2]
    Left = 112
    Top = 34
    Width = 57
    Height = 15
    Caption = 'Separator'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    HelpContext = 849002
  end
  object lblSep1: TLabel [3]
    Left = 82
    Top = 68
    Width = 5
    Height = 19
    Caption = '-'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    HelpContext = 849003
  end
  object lblSep2: TLabel [4]
    Left = 164
    Top = 68
    Width = 5
    Height = 19
    Caption = '-'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    HelpContext = 849004
  end
  inherited btnSave: TDNMSpeedButton
    ExplicitLeft = 100
    ExplicitTop = 124
  end
  inherited btnCancel: TDNMSpeedButton
    ExplicitLeft = 204
    ExplicitTop = 124
  end
  object cboSeparator: TComboBox [8]
    Left = 175
    Top = 28
    Width = 42
    Height = 27
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ItemIndex = 0
    ParentFont = False
    TabOrder = 2
    Text = '-'
    OnChange = cboSeparatorChange
    Items.Strings = (
      '-'
      '/')
    HelpContext = 849005
  end
  object cboPart1: TComboBox [9]
    Left = 13
    Top = 68
    Width = 63
    Height = 23
    Style = csDropDownList
    ItemIndex = 3
    TabOrder = 3
    Text = 'yyyy'
    Items.Strings = (
      'dd'
      'mm'
      'yy'
      'yyyy')
    HelpContext = 849006
  end
  object cboPart2: TComboBox [10]
    Left = 93
    Top = 68
    Width = 63
    Height = 23
    Style = csDropDownList
    ItemIndex = 1
    TabOrder = 4
    Text = 'mm'
    Items.Strings = (
      'dd'
      'mm'
      'yy'
      'yyyy')
    HelpContext = 849007
  end
  object cboPart3: TComboBox [11]
    Left = 175
    Top = 68
    Width = 63
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 5
    Text = 'dd'
    Items.Strings = (
      'dd'
      'mm'
      'yy'
      'yyyy')
    HelpContext = 849008
  end
  object cboTime: TComboBox [12]
    Left = 255
    Top = 68
    Width = 106
    Height = 23
    Style = csDropDownList
    TabOrder = 6
    Items.Strings = (
      ''
      'hh:mm'
      'hh:mm am/pm'
      'hh:mm:ss'
      'hh:mm:ss am/pm')
    HelpContext = 849009
  end
end
