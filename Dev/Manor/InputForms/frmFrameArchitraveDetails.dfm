inherited frmFrameArchitraveDetailsGUI: TfrmFrameArchitraveDetailsGUI
  Left = 1633
  Top = 338
  HelpContext = 286000
  Caption = 'Frame Architrave Details'
  ClientHeight = 364
  ClientWidth = 485
  DesignSize = (
    485
    364)
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    Width = 452
    Height = 221
    HelpContext = 286001
  end
  object Label1: TLabel [1]
    Left = 40
    Top = 112
    Width = 65
    Height = 15
    HelpContext = 286007
    Caption = 'Description'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel [2]
    Left = 40
    Top = 168
    Width = 33
    Height = 15
    HelpContext = 286008
    Caption = 'Width'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel [3]
    Left = 168
    Top = 168
    Width = 38
    Height = 15
    HelpContext = 286009
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
    Left = 296
    Top = 168
    Width = 22
    Height = 15
    HelpContext = 286010
    Caption = 'mm'
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
    Top = 200
    Width = 36
    Height = 15
    HelpContext = 286011
    Caption = 'Height'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label6: TLabel [6]
    Left = 168
    Top = 200
    Width = 38
    Height = 15
    HelpContext = 286012
    Caption = 'inches'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label7: TLabel [7]
    Left = 296
    Top = 200
    Width = 22
    Height = 15
    HelpContext = 286013
    Caption = 'mm'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label8: TLabel [8]
    Left = 88
    Top = 144
    Width = 102
    Height = 15
    HelpContext = 286014
    Caption = 'Timber Architrave'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label10: TLabel [9]
    Left = 86
    Top = 240
    Width = 123
    Height = 15
    HelpContext = 286015
    Caption = 'Timber Cost / Cubic Ft'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label11: TLabel [10]
    Left = 135
    Top = 272
    Width = 71
    Height = 15
    HelpContext = 286016
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
    Left = 317
    Top = 272
    Width = 57
    Height = 15
    HelpContext = 286016
    Caption = 'Total Cost'
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
    Left = 33
    Width = 417
    HelpContext = 286002
    TabOrder = 12
    inherited TitleShader: TShader
      Width = 415
      HelpContext = 286003
      inherited TitleLabel: TLabel
        Width = 415
        HelpContext = 286004
        Caption = 'Frame Architrave Details'
      end
    end
  end
  inherited btnSave: TDNMSpeedButton
    Left = 133
    Top = 322
    HelpContext = 286005
    TabOrder = 10
  end
  inherited btnCancel: TDNMSpeedButton
    Left = 266
    Top = 322
    HelpContext = 286006
    TabOrder = 11
  end
  object edtDescription: TAdvEdit
    Left = 112
    Top = 104
    Width = 337
    Height = 21
    HelpContext = 286017
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
    Left = 88
    Top = 164
    Width = 73
    Height = 23
    HelpContext = 286018
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
  object edtWidthMills: TAdvEdit
    Left = 216
    Top = 164
    Width = 73
    Height = 23
    HelpContext = 286019
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
  object edtHeightInches: TAdvEdit
    Left = 88
    Top = 196
    Width = 73
    Height = 23
    HelpContext = 286020
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
  object edtHeightMills: TAdvEdit
    Left = 216
    Top = 196
    Width = 73
    Height = 23
    HelpContext = 286021
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
    Left = 216
    Top = 236
    Width = 73
    Height = 23
    HelpContext = 286022
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
  object edtCost: TAdvEdit
    Left = 216
    Top = 268
    Width = 73
    Height = 23
    HelpContext = 286023
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
    TabOrder = 8
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object rdgArchitrave: TwwRadioGroup
    Left = 336
    Top = 144
    Width = 113
    Height = 73
    HelpContext = 286024
    TransparentActiveItem = True
    Indents.TextX = 3
    Transparent = True
    Caption = 'Architrave'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Items.Strings = (
      '1 Side'
      '2 Sides')
    ParentFont = False
    TabOrder = 5
  end
  object chkFrameTopArchitrave: TwwCheckBox
    Left = 306
    Top = 238
    Width = 143
    Height = 19
    HelpContext = 286025
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
    Caption = 'Frame Top Architrave'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object edtTotalCost: TAdvEdit
    Left = 384
    Top = 268
    Width = 73
    Height = 23
    HelpContext = 286023
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
    TabOrder = 9
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
end
