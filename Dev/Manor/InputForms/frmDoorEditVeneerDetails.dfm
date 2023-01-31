inherited frmDoorEditVeneerDetailsGUI: TfrmDoorEditVeneerDetailsGUI
  Left = 1479
  Top = 214
  HelpContext = 362000
  Caption = 'Veneer Details'
  ClientHeight = 393
  ClientWidth = 586
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    Width = 553
    Height = 250
    HelpContext = 362001
  end
  object Label1: TLabel [1]
    Left = 184
    Top = 144
    Width = 81
    Height = 15
    HelpContext = 362007
    Caption = 'Veneer Face 1'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Bevel2: TBevel [2]
    Left = 184
    Top = 160
    Width = 169
    Height = 121
    HelpContext = 362008
    Shape = bsFrame
  end
  object Label2: TLabel [3]
    Left = 200
    Top = 176
    Width = 41
    Height = 15
    HelpContext = 362009
    Caption = 'Veneer'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel [4]
    Left = 200
    Top = 224
    Width = 105
    Height = 15
    HelpContext = 362010
    Caption = 'Cost per sq. metre'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel [5]
    Left = 376
    Top = 144
    Width = 81
    Height = 15
    HelpContext = 362011
    Caption = 'Veneer Face 2'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Bevel3: TBevel [6]
    Left = 376
    Top = 160
    Width = 169
    Height = 121
    HelpContext = 362012
    Shape = bsFrame
  end
  object Label5: TLabel [7]
    Left = 392
    Top = 176
    Width = 41
    Height = 15
    HelpContext = 362013
    Caption = 'Veneer'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label6: TLabel [8]
    Left = 392
    Top = 224
    Width = 105
    Height = 15
    HelpContext = 362014
    Caption = 'Cost per sq. metre'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label7: TLabel [9]
    Left = 184
    Top = 304
    Width = 101
    Height = 15
    HelpContext = 362015
    Caption = 'Total Veneer Cost'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  inherited pnlHeader: TPanel
    Left = 145
    HelpContext = 362002
    TabOrder = 10
    inherited TitleShader: TShader
      HelpContext = 362003
      inherited TitleLabel: TLabel
        HelpContext = 362004
        Caption = 'Veneer Details'
      end
    end
  end
  inherited btnSave: TDNMSpeedButton
    Left = 170
    Top = 351
    HelpContext = 362005
    TabOrder = 8
  end
  inherited btnCancel: TDNMSpeedButton
    Left = 330
    Top = 351
    HelpContext = 362006
    TabOrder = 9
  end
  object chkVeneerRequired: TwwCheckBox
    Left = 168
    Top = 105
    Width = 121
    Height = 19
    HelpContext = 362016
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
    Caption = 'Veneer Required'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object chkVeneeredOver: TwwCheckBox
    Left = 304
    Top = 105
    Width = 113
    Height = 19
    HelpContext = 362017
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
    Caption = 'Veneered Over'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object rdgCutDescription: TwwRadioGroup
    Left = 40
    Top = 144
    Width = 121
    Height = 137
    HelpContext = 362018
    TransparentActiveItem = True
    Indents.TextX = 3
    Transparent = True
    Caption = 'Cut Description'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Items.Strings = (
      'Crown'
      'Quarter'
      'Rotary'
      'None')
    ParentFont = False
    TabOrder = 2
  end
  object edtVeneerOneCost: TAdvEdit
    Left = 200
    Top = 240
    Width = 137
    Height = 21
    HelpContext = 362019
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
    Enabled = False
    TabOrder = 4
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object cboVeneerOne: TwwDBLookupCombo
    Left = 200
    Top = 192
    Width = 137
    Height = 21
    HelpContext = 362020
    DropDownAlignment = taLeftJustify
    LookupTable = qryVeneerFaceOne
    LookupField = 'VeneerName'
    Enabled = False
    TabOrder = 3
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
  end
  object cboVeneerTwo: TwwDBLookupCombo
    Left = 392
    Top = 192
    Width = 137
    Height = 21
    HelpContext = 362021
    DropDownAlignment = taLeftJustify
    LookupTable = qryVeneerFaceTwo
    LookupField = 'VeneerName'
    Enabled = False
    TabOrder = 5
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
  end
  object edtVeneerTwoCost: TAdvEdit
    Left = 392
    Top = 240
    Width = 137
    Height = 21
    HelpContext = 362022
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
    Enabled = False
    TabOrder = 6
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtTotalVeneerCost: TAdvEdit
    Left = 296
    Top = 296
    Width = 81
    Height = 21
    HelpContext = 362023
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
  object qryVeneerFaceOne: TERPQuery
    SQL.Strings = (
      'SELECT * '
      'FROM vwdoorVeneerlist')
    Left = 456
    Top = 16
  end
  object qryVeneerFaceTwo: TERPQuery
    SQL.Strings = (
      'SELECT * '
      'FROM vwdoorVeneerlist')
    Left = 488
    Top = 16
  end
end
