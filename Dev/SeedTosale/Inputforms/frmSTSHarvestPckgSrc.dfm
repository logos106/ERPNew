object fmHarvestPckgSrc: TfmHarvestPckgSrc
  Left = 0
  Top = 0
  Width = 451
  Height = 304
  Align = alClient
  TabOrder = 0
  object lblHarvestName: TLabel
    Left = 20
    Top = 19
    Width = 100
    Height = 16
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Harvest name'
    FocusControl = cbbHarvestName
  end
  object lbQty: TLabel
    Left = 21
    Top = 49
    Width = 100
    Height = 16
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Harvest Quantity'
    FocusControl = edtHarvestQty
  end
  object lb1: TLabel
    Left = 21
    Top = 100
    Width = 100
    Height = 16
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Package Quantity'
    FocusControl = edtPackgQty
  end
  object lb2: TLabel
    Left = 24
    Top = 119
    Width = 100
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = '(calculated)'
  end
  object lbInfo: TLabel
    Left = 127
    Top = 71
    Width = 49
    Height = 13
    Caption = 'Max value'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbHarvestUnits: TLabel
    Left = 234
    Top = 49
    Width = 3
    Height = 13
  end
  object Label1: TLabel
    Left = 375
    Top = 100
    Width = 32
    Height = 16
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Package Quantity'
    FocusControl = cbbPackgUnits
    Visible = False
  end
  object cbbHarvestName: TComboBox
    Left = 127
    Top = 16
    Width = 256
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 0
    Text = '2021-09-21-Storage1'
    OnChange = cbbHarvestNameChange
    Items.Strings = (
      '2021-09-21-Storage1')
  end
  object edtPackgQty: TEdit
    Left = 127
    Top = 97
    Width = 100
    Height = 21
    TabStop = False
    ReadOnly = True
    TabOrder = 2
  end
  object edtHarvestQty: TEdit
    Left = 127
    Top = 46
    Width = 100
    Height = 21
    TabOrder = 1
    OnChange = edtHarvestQtyChange
    OnExit = edtHarvestQtyExit
    OnKeyPress = edtHarvestQtyKeyPress
  end
  object cbbPackgUnits: TwwDBLookupCombo
    Left = 233
    Top = 97
    Width = 121
    Height = 21
    DropDownAlignment = taLeftJustify
    LookupField = 'UnitName'
    Style = csDropDownList
    TabOrder = 3
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    ShowMatchText = True
  end
end
