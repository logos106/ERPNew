inherited frmFrameFanLightDetailsGUI: TfrmFrameFanLightDetailsGUI
  Left = 1339
  Top = 54
  HelpContext = 288000
  Caption = 'Frame Fan Light Details'
  ClientHeight = 421
  ClientWidth = 479
  DesignSize = (
    479
    421)
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    Width = 446
    Height = 278
    HelpContext = 288001
  end
  object Label1: TLabel [1]
    Left = 337
    Top = 104
    Width = 67
    Height = 15
    HelpContext = 288007
    Caption = 'Timber Size'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel [2]
    Left = 208
    Top = 128
    Width = 65
    Height = 15
    HelpContext = 288008
    Caption = 'Bead Width'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel [3]
    Left = 413
    Top = 128
    Width = 38
    Height = 15
    HelpContext = 288009
    Caption = 'inches'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel [4]
    Left = 413
    Top = 160
    Width = 38
    Height = 15
    HelpContext = 288010
    Caption = 'inches'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label5: TLabel [5]
    Left = 208
    Top = 160
    Width = 88
    Height = 15
    HelpContext = 288011
    Caption = 'Web Thickness'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label6: TLabel [6]
    Left = 208
    Top = 192
    Width = 89
    Height = 15
    HelpContext = 288012
    Caption = 'Timber Cost / cf'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label7: TLabel [7]
    Left = 208
    Top = 224
    Width = 120
    Height = 15
    HelpContext = 288013
    Caption = 'Beading Cost / lin mtr'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label8: TLabel [8]
    Left = 208
    Top = 256
    Width = 61
    Height = 15
    HelpContext = 288014
    Caption = 'Panel Cost'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label9: TLabel [9]
    Left = 208
    Top = 288
    Width = 100
    Height = 15
    HelpContext = 288015
    Caption = 'Panel Description'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  inherited pnlHeader: TPanel
    Left = 27
    Width = 425
    HelpContext = 288002
    TabOrder = 10
    inherited TitleShader: TShader
      Width = 423
      HelpContext = 288003
      inherited TitleLabel: TLabel
        Width = 423
        HelpContext = 288004
        Caption = 'Frame Fan Light Details'
      end
    end
  end
  inherited btnSave: TDNMSpeedButton
    Left = 130
    Top = 379
    HelpContext = 288005
    TabOrder = 8
  end
  inherited btnCancel: TDNMSpeedButton
    Left = 263
    Top = 379
    HelpContext = 288006
    TabOrder = 9
  end
  object rdgBeads: TwwRadioGroup
    Left = 32
    Top = 104
    Width = 153
    Height = 113
    HelpContext = 288016
    TransparentActiveItem = True
    Indents.TextX = 3
    Transparent = True
    Caption = 'Beads'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Items.Strings = (
      'No Beads'
      '1 Set of Beads'
      '2 Sets of Beads')
    ParentFont = False
    TabOrder = 0
  end
  object rdgSupplyAndFit: TwwRadioGroup
    Left = 32
    Top = 232
    Width = 153
    Height = 113
    HelpContext = 288017
    TransparentActiveItem = True
    Indents.TextX = 3
    Transparent = True
    Caption = 'Supply and Fit'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Items.Strings = (
      'No Panel'
      'Glass'
      'Ply Panel')
    ParentFont = False
    TabOrder = 1
  end
  object edtBeadWidth: TAdvEdit
    Left = 337
    Top = 120
    Width = 69
    Height = 23
    HelpContext = 288018
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
    TabOrder = 2
    Text = '0'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtWebThickness: TAdvEdit
    Left = 337
    Top = 152
    Width = 69
    Height = 23
    HelpContext = 288019
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
    TabOrder = 3
    Text = '0'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtTimberCost: TAdvEdit
    Left = 336
    Top = 184
    Width = 116
    Height = 23
    HelpContext = 288020
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
    TabOrder = 4
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtBeadingCost: TAdvEdit
    Left = 336
    Top = 216
    Width = 116
    Height = 23
    HelpContext = 288021
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
  object edtPanelCost: TAdvEdit
    Left = 336
    Top = 248
    Width = 116
    Height = 23
    HelpContext = 288022
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
    TabOrder = 6
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object memPanelDesiption: TMemo
    Left = 208
    Top = 305
    Width = 241
    Height = 40
    HelpContext = 288023
    TabOrder = 7
  end
end
