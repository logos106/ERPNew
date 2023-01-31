object frPayTaxScaleConfigUSA: TfrPayTaxScaleConfigUSA
  Left = 0
  Top = 0
  Width = 665
  Height = 47
  TabOrder = 0
  object lblTaxName: TLabel
    Left = 8
    Top = 7
    Width = 130
    Height = 15
    AutoSize = False
    Caption = 'Tax Name'
    Transparent = True
  end
  object cboScale: TwwDBComboBox
    Left = 144
    Top = 3
    Width = 168
    Height = 23
    ShowButton = True
    Style = csDropDownList
    MapList = True
    AllowClearKey = True
    DropDownCount = 8
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      'Actors'#9'A'
      'ATO-Defined'#9'D'
      'Foreign Resident'#9'F'
      'Horticulturalists and Shearers'#9'C'
      'No TFN'#9'N'
      'Regular'#9'R'
      'Seasonal Worker Programme'#9'W'
      'Seniors and Pensioners'#9'S'
      'Voluntary Agreement'#9'V'
      'Working Holiday Makers'#9'H')
    ParentFont = False
    Sorted = False
    TabOrder = 0
    UnboundDataType = wwDefault
    OnChange = cboScaleChange
  end
  object edtAllowanceQty: TDBAdvEdit
    Left = 318
    Top = 3
    Width = 39
    Height = 23
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = '0'
    Visible = True
    OnChange = edtAllowanceQtyChange
    Version = '2.8.6.9'
  end
  object cboExpenseAccount: TwwDBComboBox
    Left = 363
    Top = 3
    Width = 139
    Height = 23
    ShowButton = True
    Style = csDropDownList
    MapList = True
    AllowClearKey = False
    DropDownCount = 8
    DropDownWidth = 200
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      'test'#9'1'
      'test 2'#9'2')
    ParentFont = False
    Sorted = False
    TabOrder = 2
    UnboundDataType = wwDefault
    OnChange = cboScaleChange
  end
  object cboLiabilityAccount: TwwDBComboBox
    Left = 509
    Top = 3
    Width = 139
    Height = 23
    ShowButton = True
    Style = csDropDownList
    MapList = True
    AllowClearKey = False
    DropDownCount = 8
    DropDownWidth = 200
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      'test'#9'1'
      'test 2'#9'2')
    ParentFont = False
    Sorted = False
    TabOrder = 3
    UnboundDataType = wwDefault
    OnChange = cboScaleChange
  end
end
