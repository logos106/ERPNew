object frPayTaxScaleConfig: TfrPayTaxScaleConfig
  Left = 0
  Top = 0
  Width = 665
  Height = 253
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
  object Label1: TLabel
    Left = 44
    Top = 63
    Width = 170
    Height = 15
    AutoSize = False
    Caption = 'Tax Treatment'
    Transparent = True
  end
  object Label2: TLabel
    Left = 144
    Top = 63
    Width = 170
    Height = 15
    AutoSize = False
    Caption = 'Category'
    Transparent = True
  end
  object Label3: TLabel
    Left = 144
    Top = 93
    Width = 170
    Height = 15
    AutoSize = False
    Caption = 'Option'
    Transparent = True
  end
  object Label4: TLabel
    Left = 144
    Top = 123
    Width = 170
    Height = 15
    AutoSize = False
    Caption = 'Study and Training Support Loan'
    Transparent = True
  end
  object Label5: TLabel
    Left = 144
    Top = 153
    Width = 170
    Height = 15
    AutoSize = False
    Caption = 'Medicare Levy Surcharge'
    Transparent = True
  end
  object Label6: TLabel
    Left = 144
    Top = 183
    Width = 170
    Height = 15
    AutoSize = False
    Caption = 'Medicare Levy Exemption'
    Transparent = True
  end
  object Label7: TLabel
    Left = 144
    Top = 213
    Width = 170
    Height = 15
    AutoSize = False
    Caption = 'Medicare Levy Reduction'
    Transparent = True
  end
  object Label8: TLabel
    Left = 144
    Top = 40
    Width = 170
    Height = 15
    AutoSize = False
    Caption = 'Must Select Category 1 First'
    Transparent = True
  end
  object Label9: TLabel
    Left = 333
    Top = 63
    Width = 17
    Height = 15
    AutoSize = False
    Caption = '1'
    Transparent = True
  end
  object Label10: TLabel
    Left = 333
    Top = 213
    Width = 17
    Height = 15
    AutoSize = False
    Caption = '6'
    Transparent = True
  end
  object Label11: TLabel
    Left = 333
    Top = 153
    Width = 17
    Height = 15
    AutoSize = False
    Caption = '4'
    Transparent = True
  end
  object Label12: TLabel
    Left = 333
    Top = 183
    Width = 17
    Height = 15
    AutoSize = False
    Caption = '5'
    Transparent = True
  end
  object Label13: TLabel
    Left = 357
    Top = 87
    Width = 17
    Height = 15
    AutoSize = False
    Caption = '1'
    Transparent = True
  end
  object Label14: TLabel
    Left = 333
    Top = 95
    Width = 17
    Height = 15
    AutoSize = False
    Caption = '2'
    Transparent = True
  end
  object Label15: TLabel
    Left = 333
    Top = 123
    Width = 17
    Height = 15
    AutoSize = False
    Caption = '3'
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
  object cboCategory: TwwDBComboBox
    Left = 358
    Top = 59
    Width = 220
    Height = 23
    ShowButton = True
    Style = csDropDown
    MapList = True
    AllowClearKey = False
    DropDownCount = 8
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      '[Default]'#9
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
    ItemIndex = 0
    ParentFont = False
    Sorted = False
    TabOrder = 4
    UnboundDataType = wwDefault
    OnChange = cboCategoryChange
  end
  object cboOption: TwwDBComboBox
    Left = 358
    Top = 89
    Width = 220
    Height = 23
    ShowButton = True
    Style = csDropDown
    MapList = True
    AllowClearKey = False
    DropDownCount = 8
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      '[Default]'#9)
    ItemIndex = 0
    ParentFont = False
    Sorted = False
    TabOrder = 5
    UnboundDataType = wwDefault
    OnChange = cboOptionChange
  end
  object cboSTSL: TwwDBComboBox
    Left = 358
    Top = 119
    Width = 220
    Height = 23
    ShowButton = True
    Style = csDropDown
    MapList = True
    AllowClearKey = False
    DropDownCount = 8
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      '[Default]'#9)
    ItemIndex = 0
    ParentFont = False
    Sorted = False
    TabOrder = 6
    UnboundDataType = wwDefault
    OnChange = cboScaleChange
  end
  object cboMLS: TwwDBComboBox
    Left = 358
    Top = 149
    Width = 220
    Height = 23
    ShowButton = True
    Style = csDropDown
    MapList = True
    AllowClearKey = False
    DropDownCount = 8
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      '[Default]'#9)
    ItemIndex = 0
    ParentFont = False
    Sorted = False
    TabOrder = 7
    UnboundDataType = wwDefault
    OnChange = cboScaleChange
  end
  object cboMLE: TwwDBComboBox
    Left = 358
    Top = 179
    Width = 220
    Height = 23
    ShowButton = True
    Style = csDropDown
    MapList = True
    AllowClearKey = False
    DropDownCount = 8
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      '[Default]'#9)
    ItemIndex = 0
    ParentFont = False
    Sorted = False
    TabOrder = 8
    UnboundDataType = wwDefault
    OnChange = cboScaleChange
  end
  object cboMLR: TwwDBComboBox
    Left = 358
    Top = 209
    Width = 220
    Height = 23
    ShowButton = True
    Style = csDropDown
    MapList = True
    AllowClearKey = False
    DropDownCount = 8
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      '[Default]'#9)
    ItemIndex = 0
    ParentFont = False
    Sorted = False
    TabOrder = 9
    UnboundDataType = wwDefault
    OnChange = cboScaleChange
  end
end
