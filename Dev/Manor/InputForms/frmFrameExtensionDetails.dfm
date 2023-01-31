inherited frmFrameExtensionDetailsGUI: TfrmFrameExtensionDetailsGUI
  Left = 2045
  Top = 17
  HelpContext = 287000
  Caption = 'Frame Extension Details'
  ClientHeight = 326
  DesignSize = (
    482
    326)
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    Height = 183
    HelpContext = 287001
  end
  object Label1: TLabel [1]
    Left = 144
    Top = 104
    Width = 99
    Height = 15
    HelpContext = 287007
    Caption = 'Timber Extension'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel [2]
    Left = 99
    Top = 128
    Width = 33
    Height = 15
    HelpContext = 287008
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
    Left = 224
    Top = 128
    Width = 38
    Height = 15
    HelpContext = 287009
    Caption = 'inches'
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
    Top = 162
    Width = 36
    Height = 15
    HelpContext = 287010
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
    Top = 162
    Width = 38
    Height = 15
    HelpContext = 287011
    Caption = 'inches'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label7: TLabel [6]
    Left = 352
    Top = 162
    Width = 22
    Height = 15
    HelpContext = 287012
    Caption = 'mm'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel [7]
    Left = 352
    Top = 128
    Width = 22
    Height = 15
    HelpContext = 287013
    Caption = 'mm'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label9: TLabel [8]
    Left = 60
    Top = 192
    Width = 72
    Height = 30
    HelpContext = 287014
    Alignment = taRightJustify
    Caption = 'Timber Cost/ Cubic Ft'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label10: TLabel [9]
    Left = 264
    Top = 200
    Width = 71
    Height = 15
    HelpContext = 287015
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
  object Label8: TLabel [10]
    Left = 278
    Top = 234
    Width = 57
    Height = 15
    HelpContext = 287014
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
    Left = 24
    Width = 433
    HelpContext = 287002
    TabOrder = 9
    inherited TitleShader: TShader
      Width = 431
      HelpContext = 287003
      inherited TitleLabel: TLabel
        Width = 431
        HelpContext = 287004
        Caption = 'Frame Extension Details'
      end
    end
  end
  inherited btnSave: TDNMSpeedButton
    Top = 284
    HelpContext = 287005
    TabOrder = 7
  end
  inherited btnCancel: TDNMSpeedButton
    Top = 284
    HelpContext = 287006
    TabOrder = 8
  end
  object edtWidthInches: TAdvEdit
    Left = 144
    Top = 124
    Width = 73
    Height = 23
    HelpContext = 287016
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
    TabOrder = 0
    Text = '0'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtWidthMills: TAdvEdit
    Left = 272
    Top = 124
    Width = 73
    Height = 23
    HelpContext = 287017
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
  object edtHeightInches: TAdvEdit
    Left = 144
    Top = 158
    Width = 73
    Height = 23
    HelpContext = 287018
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
  object edtHeightMills: TAdvEdit
    Left = 272
    Top = 158
    Width = 73
    Height = 23
    HelpContext = 287019
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
    Left = 144
    Top = 196
    Width = 73
    Height = 23
    HelpContext = 287020
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
  object edtCost: TAdvEdit
    Left = 344
    Top = 196
    Width = 73
    Height = 23
    HelpContext = 287021
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
    TabOrder = 5
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtTotalCost: TAdvEdit
    Left = 344
    Top = 230
    Width = 73
    Height = 23
    HelpContext = 287020
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
end
