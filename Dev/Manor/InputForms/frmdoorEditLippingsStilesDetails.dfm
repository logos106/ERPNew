inherited frmDoorEditLippingsStilesDetailsGUI: TfrmDoorEditLippingsStilesDetailsGUI
  Left = 1441
  Top = 98
  HelpContext = 303000
  Caption = 'Lippings and Stiles Details'
  ClientHeight = 463
  ClientWidth = 682
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    Width = 649
    Height = 320
    HelpContext = 303001
  end
  object Label1: TLabel [1]
    Left = 305
    Top = 123
    Width = 103
    Height = 15
    HelpContext = 303007
    Caption = 'Lipping Thickness'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel [2]
    Left = 305
    Top = 153
    Width = 71
    Height = 15
    HelpContext = 303008
    Caption = 'Lipping Type'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel [3]
    Left = 305
    Top = 212
    Width = 156
    Height = 15
    HelpContext = 303009
    Caption = 'Lipping Cost (per 2135 mm)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel [4]
    Left = 305
    Top = 94
    Width = 46
    Height = 15
    HelpContext = 303010
    Caption = 'Handing'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label5: TLabel [5]
    Left = 40
    Top = 261
    Width = 157
    Height = 15
    HelpContext = 303011
    Caption = 'Special Lipping Instructions'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label6: TLabel [6]
    Left = 305
    Top = 328
    Width = 90
    Height = 30
    HelpContext = 303012
    Caption = 'Lipping Material Cost'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label7: TLabel [7]
    Left = 305
    Top = 365
    Width = 89
    Height = 30
    HelpContext = 303013
    Caption = 'Material Labour Cost'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label8: TLabel [8]
    Left = 488
    Top = 365
    Width = 100
    Height = 30
    HelpContext = 303014
    Caption = 'Total Lipping/Stile Cost'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label9: TLabel [9]
    Left = 305
    Top = 241
    Width = 67
    Height = 15
    HelpContext = 303015
    Caption = 'Rebate Size'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label10: TLabel [10]
    Left = 305
    Top = 271
    Width = 131
    Height = 15
    HelpContext = 303016
    Caption = 'Stile Lipping Thickness'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label11: TLabel [11]
    Left = 305
    Top = 301
    Width = 99
    Height = 15
    HelpContext = 303017
    Caption = 'Stile Lipping Type'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label12: TLabel [12]
    Left = 488
    Top = 328
    Width = 72
    Height = 30
    HelpContext = 303018
    Caption = 'Stile Lipping Cost '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label13: TLabel [13]
    Left = 553
    Top = 241
    Width = 22
    Height = 15
    HelpContext = 303019
    Caption = 'mm'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label14: TLabel [14]
    Left = 305
    Top = 182
    Width = 97
    Height = 15
    HelpContext = 303020
    Caption = 'Lipping All Sites?'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  inherited pnlHeader: TPanel
    Left = 115
    Width = 460
    HelpContext = 303002
    TabOrder = 17
    inherited TitleShader: TShader
      Width = 458
      HelpContext = 303003
      inherited TitleLabel: TLabel
        Width = 458
        HelpContext = 303004
        Caption = 'Lippings and Stiles Details'
      end
    end
  end
  inherited btnSave: TDNMSpeedButton
    Left = 205
    Top = 421
    HelpContext = 303005
    TabOrder = 15
  end
  inherited btnCancel: TDNMSpeedButton
    Left = 391
    Top = 421
    HelpContext = 303006
    TabOrder = 16
  end
  object rdgEdgeNumber: TwwRadioGroup
    Left = 40
    Top = 104
    Width = 105
    Height = 137
    HelpContext = 303021
    TransparentActiveItem = True
    Indents.TextX = 3
    Transparent = True
    Caption = 'Edge Number'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Items.Strings = (
      '1 Edge'
      '2 Edges'
      '3 Edges'
      '4 Edges')
    ParentFont = False
    TabOrder = 0
  end
  object rdgStileType: TwwRadioGroup
    Left = 168
    Top = 104
    Width = 105
    Height = 137
    HelpContext = 303022
    TransparentActiveItem = True
    Indents.TextX = 3
    Transparent = True
    Caption = 'Stile Type'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Items.Strings = (
      'Square'
      'Rebated'
      'Rounded'
      'None')
    ParentFont = False
    TabOrder = 1
  end
  object cboLippingThickness: TwwDBLookupCombo
    Left = 488
    Top = 120
    Width = 161
    Height = 21
    HelpContext = 303023
    DropDownAlignment = taLeftJustify
    LookupTable = qryLippingThickness
    LookupField = 'LipSize'
    TabOrder = 4
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
  end
  object cboLippingType: TwwDBLookupCombo
    Left = 488
    Top = 150
    Width = 161
    Height = 21
    HelpContext = 303024
    DropDownAlignment = taLeftJustify
    LookupTable = qryLippingType
    LookupField = 'LipType'
    DropDownWidth = 161
    TabOrder = 5
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
  end
  object edtLippingCost: TAdvEdit
    Left = 488
    Top = 209
    Width = 161
    Height = 21
    HelpContext = 303025
    EditAlign = eaRight
    EditType = etFloat
    Precision = 2
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 7
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object cboHanding: TwwDBLookupCombo
    Left = 488
    Top = 91
    Width = 161
    Height = 21
    HelpContext = 303026
    DropDownAlignment = taLeftJustify
    LookupTable = qryHanding
    LookupField = 'HandingAbbrev'
    TabOrder = 3
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
  end
  object memSpecialLippingInstructions: TMemo
    Left = 40
    Top = 277
    Width = 209
    Height = 108
    HelpContext = 303027
    TabOrder = 2
  end
  object edtLippingMaterialCost: TAdvEdit
    Left = 408
    Top = 332
    Width = 57
    Height = 21
    HelpContext = 303028
    EditAlign = eaRight
    EditType = etFloat
    Precision = 2
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 11
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtMaterialLabourCost: TAdvEdit
    Left = 408
    Top = 369
    Width = 57
    Height = 21
    HelpContext = 303029
    EditAlign = eaRight
    EditType = etFloat
    Precision = 2
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 13
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtTotalLippingStileCost: TAdvEdit
    Left = 592
    Top = 369
    Width = 57
    Height = 21
    HelpContext = 303030
    EditAlign = eaRight
    EditType = etFloat
    Precision = 2
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 14
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtRebateSize: TAdvEdit
    Left = 488
    Top = 238
    Width = 57
    Height = 21
    HelpContext = 303031
    EditAlign = eaRight
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 8
    Text = '0'
    Visible = True
    Version = '2.7.5.0'
  end
  object cboStileLippingThickness: TwwDBLookupCombo
    Left = 488
    Top = 268
    Width = 161
    Height = 21
    HelpContext = 303032
    DropDownAlignment = taLeftJustify
    LookupTable = qryStileLippingThickness
    LookupField = 'LipSize'
    TabOrder = 9
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
  end
  object cboStileLippingType: TwwDBLookupCombo
    Left = 488
    Top = 298
    Width = 161
    Height = 21
    HelpContext = 303033
    DropDownAlignment = taLeftJustify
    LookupTable = qryStileLippingType
    LookupField = 'LipType'
    DropDownWidth = 161
    TabOrder = 10
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
  end
  object edtStileLippingCost: TAdvEdit
    Left = 592
    Top = 332
    Width = 57
    Height = 21
    HelpContext = 303034
    EditAlign = eaRight
    EditType = etFloat
    Precision = 2
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 12
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object chkAllStiles: TwwCheckBox
    Left = 488
    Top = 179
    Width = 16
    Height = 19
    HelpContext = 303035
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Alignment = taLeftJustify
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object qryLippingThickness: TERPQuery
    SQL.Strings = (
      'SELECT DISTINCTROW LipSize '
      'FROM vwDoorlippingsList')
    Left = 584
    Top = 16
  end
  object qryLippingType: TERPQuery
    SQL.Strings = (
      'SELECT DISTINCTROW LipType '
      'FROM vwDoorlippingsList'
      'WHERE LipSize = :LipSize'
      'ORDER BY LipType')
    Left = 616
    Top = 16
    ParamData = <
      item
        DataType = ftString
        Name = 'LipSize'
      end>
  end
  object qryStileLippingThickness: TERPQuery
    SQL.Strings = (
      'SELECT DISTINCTROW LipSize '
      'FROM vwDoorlippingsList')
    Left = 584
    Top = 48
  end
  object qryStileLippingType: TERPQuery
    SQL.Strings = (
      'SELECT DISTINCTROW LipType '
      'FROM vwDoorlippingsList'
      'WHERE LipSize = :LipSize'
      'ORDER BY LipType')
    Left = 616
    Top = 48
    ParamData = <
      item
        DataType = ftString
        Name = 'LipSize'
      end>
  end
  object qryHanding: TERPQuery
    SQL.Strings = (
      'SELECT DISTINCTROW HandingAbbrev, Description'
      'FROM vwDoorhandingdetailslist')
    Left = 648
    Top = 16
  end
end
