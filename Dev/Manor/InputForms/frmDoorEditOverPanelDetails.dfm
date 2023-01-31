inherited frmDoorEditOverPanelDetailsGUI: TfrmDoorEditOverPanelDetailsGUI
  Left = 1624
  Top = 171
  HelpContext = 313000
  Caption = 'Overpanel Details'
  ClientHeight = 411
  ClientWidth = 435
  DesignSize = (
    435
    411)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel3: TBevel [0]
    Left = 232
    Top = 224
    Width = 169
    Height = 73
    HelpContext = 313007
    Shape = bsFrame
  end
  inherited Bevel1: TBevel
    Width = 402
    Height = 268
    HelpContext = 313001
  end
  object Label1: TLabel [2]
    Left = 232
    Top = 104
    Width = 95
    Height = 15
    HelpContext = 313008
    Caption = 'Overpanel Size 1'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Bevel2: TBevel [3]
    Left = 232
    Top = 120
    Width = 169
    Height = 73
    HelpContext = 313009
    Shape = bsFrame
  end
  object Label2: TLabel [4]
    Left = 248
    Top = 136
    Width = 33
    Height = 15
    HelpContext = 313010
    Caption = 'Width'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel [5]
    Left = 248
    Top = 168
    Width = 36
    Height = 15
    HelpContext = 313011
    Caption = 'Height'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel [6]
    Left = 368
    Top = 168
    Width = 22
    Height = 15
    HelpContext = 313012
    Caption = 'mm'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label5: TLabel [7]
    Left = 368
    Top = 136
    Width = 22
    Height = 15
    HelpContext = 313013
    Caption = 'mm'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label6: TLabel [8]
    Left = 232
    Top = 208
    Width = 95
    Height = 15
    HelpContext = 313014
    Caption = 'Overpanel Size 2'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label7: TLabel [9]
    Left = 248
    Top = 240
    Width = 33
    Height = 15
    HelpContext = 313015
    Caption = 'Width'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label8: TLabel [10]
    Left = 248
    Top = 272
    Width = 36
    Height = 15
    HelpContext = 313016
    Caption = 'Height'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label9: TLabel [11]
    Left = 368
    Top = 240
    Width = 22
    Height = 15
    HelpContext = 313017
    Caption = 'mm'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label10: TLabel [12]
    Left = 368
    Top = 272
    Width = 22
    Height = 15
    HelpContext = 313018
    Caption = 'mm'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label11: TLabel [13]
    Left = 128
    Top = 315
    Width = 87
    Height = 15
    HelpContext = 313019
    Caption = 'Overpanel Cost'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  inherited pnlHeader: TPanel
    Left = 69
    Width = 308
    HelpContext = 313002
    TabOrder = 8
    inherited TitleShader: TShader
      Width = 306
      HelpContext = 313003
      inherited TitleLabel: TLabel
        Width = 306
        HelpContext = 313004
        Caption = 'Overpanel Details'
      end
    end
  end
  inherited btnSave: TDNMSpeedButton
    Left = 115
    Top = 369
    HelpContext = 313005
    TabOrder = 6
  end
  inherited btnCancel: TDNMSpeedButton
    Left = 234
    Top = 369
    HelpContext = 313006
    TabOrder = 7
  end
  object rdgOverPanelType: TwwRadioGroup
    Left = 32
    Top = 104
    Width = 185
    Height = 193
    HelpContext = 313020
    TransparentActiveItem = True
    Indents.TextX = 3
    Transparent = True
    Caption = 'Overpanel Type'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Items.Strings = (
      'No Panel'
      'Single'
      'Pair'
      'Eccentric Pair')
    ParentFont = False
    TabOrder = 0
  end
  object edtOverPanelOneWidth: TAdvEdit
    Left = 296
    Top = 133
    Width = 65
    Height = 21
    HelpContext = 313021
    EditAlign = eaRight
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = False
    TabOrder = 1
    Text = '0'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtOverPanelOneHeight: TAdvEdit
    Left = 296
    Top = 165
    Width = 65
    Height = 21
    HelpContext = 313022
    EditAlign = eaRight
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = False
    TabOrder = 2
    Text = '0'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtOverPanelTwoWidth: TAdvEdit
    Left = 296
    Top = 237
    Width = 65
    Height = 21
    HelpContext = 313023
    EditAlign = eaRight
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = False
    TabOrder = 3
    Text = '0'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtOverPanelTwoHeight: TAdvEdit
    Left = 296
    Top = 269
    Width = 65
    Height = 21
    HelpContext = 313024
    EditAlign = eaRight
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = False
    TabOrder = 4
    Text = '0'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtOverPanelCost: TAdvEdit
    Left = 224
    Top = 312
    Width = 65
    Height = 21
    HelpContext = 313025
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
    TabOrder = 5
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object qry: TERPQuery
    SQL.Strings = (
      'SELECT DISTINCTROW *'
      'FROM vwdoorisdescriptionsList')
    Left = 386
    Top = 16
  end
end
