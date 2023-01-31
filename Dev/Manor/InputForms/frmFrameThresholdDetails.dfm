inherited frmFrameThresholdDetailsGUI: TfrmFrameThresholdDetailsGUI
  Left = 559
  Top = 312
  HelpContext = 290000
  Caption = 'Frame Threshold Details'
  ClientHeight = 365
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    Height = 222
    HelpContext = 290001
  end
  object Label1: TLabel [1]
    Left = 32
    Top = 112
    Width = 65
    Height = 15
    HelpContext = 290007
    Caption = 'Description'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label8: TLabel [2]
    Left = 144
    Top = 144
    Width = 97
    Height = 15
    HelpContext = 290008
    Caption = 'Timber threshold'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel [3]
    Left = 99
    Top = 168
    Width = 33
    Height = 15
    HelpContext = 290009
    Caption = 'Width'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label5: TLabel [4]
    Left = 96
    Top = 200
    Width = 36
    Height = 15
    HelpContext = 290010
    Caption = 'Height'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label6: TLabel [5]
    Left = 224
    Top = 200
    Width = 38
    Height = 15
    HelpContext = 290011
    Caption = 'inches'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel [6]
    Left = 224
    Top = 168
    Width = 38
    Height = 15
    HelpContext = 290012
    Caption = 'inches'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel [7]
    Left = 379
    Top = 168
    Width = 22
    Height = 15
    HelpContext = 290013
    Caption = 'mm'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label7: TLabel [8]
    Left = 379
    Top = 200
    Width = 22
    Height = 15
    HelpContext = 290014
    Caption = 'mm'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label10: TLabel [9]
    Left = 54
    Top = 223
    Width = 78
    Height = 30
    HelpContext = 290015
    Alignment = taRightJustify
    Caption = 'Timber Cost / Cubic Ft'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label11: TLabel [10]
    Left = 256
    Top = 232
    Width = 71
    Height = 15
    HelpContext = 290016
    Caption = 'Cost / lin mtr'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label9: TLabel [11]
    Left = 271
    Top = 272
    Width = 56
    Height = 15
    HelpContext = 290015
    Caption = 'Total cost'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  inherited pnlHeader: TPanel
    Left = 32
    Width = 417
    HelpContext = 290002
    TabOrder = 10
    inherited TitleShader: TShader
      Width = 415
      HelpContext = 290003
      inherited TitleLabel: TLabel
        Width = 415
        HelpContext = 290004
        Caption = 'Frame Threshold Details'
      end
    end
  end
  inherited btnSave: TDNMSpeedButton
    Top = 323
    HelpContext = 290005
    TabOrder = 8
  end
  inherited btnCancel: TDNMSpeedButton
    Top = 323
    HelpContext = 290006
    TabOrder = 9
  end
  object edtDescription: TAdvEdit
    Left = 104
    Top = 104
    Width = 345
    Height = 21
    HelpContext = 290017
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 0
    Visible = True
    Version = '2.7.5.0'
  end
  object edtWidthInches: TAdvEdit
    Left = 144
    Top = 164
    Width = 73
    Height = 23
    HelpContext = 290018
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
    TabOrder = 1
    Text = '0'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtHeightInches: TAdvEdit
    Left = 144
    Top = 196
    Width = 73
    Height = 23
    HelpContext = 290019
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
  object edtWidthMills: TAdvEdit
    Left = 299
    Top = 164
    Width = 73
    Height = 23
    HelpContext = 290020
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
  object edtHeightMills: TAdvEdit
    Left = 299
    Top = 196
    Width = 73
    Height = 23
    HelpContext = 290021
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
    TabOrder = 4
    Text = '0'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtTimberCost: TAdvEdit
    Left = 144
    Top = 228
    Width = 73
    Height = 23
    HelpContext = 290022
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
  object edtCost: TAdvEdit
    Left = 344
    Top = 228
    Width = 73
    Height = 23
    HelpContext = 290023
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
  object edtTotalCost: TAdvEdit
    Left = 344
    Top = 268
    Width = 73
    Height = 23
    HelpContext = 290022
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
    TabOrder = 7
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
end
