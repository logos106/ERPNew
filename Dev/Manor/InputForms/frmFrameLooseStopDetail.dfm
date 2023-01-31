inherited fmFrameLoopStopDetail: TfmFrameLoopStopDetail
  Left = 1396
  Top = 79
  Caption = 'Frame Loose Stop Detail'
  ClientWidth = 586
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 562000
  object Shape1: TShape [0]
    Left = 138
    Top = 147
    Width = 250
    Height = 64
    Brush.Style = bsClear
    Pen.Color = clSilver
    HelpContext = 292029
  end
  inherited Bevel1: TBevel
    Left = 15
    Top = 80
    Width = 552
    HelpContext = 292023
  end
  object Label1: TLabel [2]
    Left = 48
    Top = 96
    Width = 65
    Height = 15
    Caption = 'Description'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    HelpContext = 292030
  end
  object Label2: TLabel [3]
    Left = 151
    Top = 128
    Width = 40
    Height = 15
    Caption = 'Timber'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    HelpContext = 292031
  end
  object Label3: TLabel [4]
    Left = 287
    Top = 128
    Width = 57
    Height = 15
    Caption = 'Threshold'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    HelpContext = 292032
  end
  object lblWidthinch: TLabel [5]
    Left = 97
    Top = 156
    Width = 33
    Height = 15
    Caption = 'Width'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    HelpContext = 292033
  end
  object lblThicknessinch: TLabel [6]
    Left = 42
    Top = 188
    Width = 88
    Height = 15
    Caption = 'Web Thickness'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    HelpContext = 292034
  end
  object lblWidthinchinch: TLabel [7]
    Left = 220
    Top = 156
    Width = 38
    Height = 15
    Caption = 'inches'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    HelpContext = 292035
  end
  object lblWidthmm: TLabel [8]
    Left = 357
    Top = 156
    Width = 22
    Height = 15
    Caption = 'mm'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    HelpContext = 292036
  end
  object lblThicknessmm: TLabel [9]
    Left = 357
    Top = 188
    Width = 22
    Height = 15
    Caption = 'mm'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    HelpContext = 292037
  end
  object lblThicknessinchinch: TLabel [10]
    Left = 220
    Top = 188
    Width = 38
    Height = 15
    Caption = 'inches'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    HelpContext = 292038
  end
  object Label10: TLabel [11]
    Left = 118
    Top = 244
    Width = 154
    Height = 30
    Alignment = taRightJustify
    Caption = 'Timber Cost Per Cubic Foot (Including Waste)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
    HelpContext = 292039
  end
  object Label12: TLabel [12]
    Left = 167
    Top = 292
    Width = 102
    Height = 15
    Caption = 'Cost Per lin metre'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    HelpContext = 292040
  end
  object Shape2: TShape [13]
    Left = 264
    Top = 146
    Width = 1
    Height = 65
    Pen.Color = clSilver
    HelpContext = 292041
  end
  object Label11: TLabel [14]
    Left = 408
    Top = 292
    Width = 59
    Height = 15
    Caption = 'Total cost '
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    HelpContext = 292042
  end
  inherited pnlHeader: TPanel
    Left = 62
    Width = 462
    TabOrder = 11
    HelpContext = 292024
    inherited TitleShader: TShader
      Width = 460
      HelpContext = 292025
      inherited TitleLabel: TLabel
        Width = 460
        Caption = 'Frame Loose Stop Detail'
        HelpContext = 292026
      end
    end
  end
  inherited btnSave: TDNMSpeedButton
    Left = 170
    TabOrder = 9
    HelpContext = 292027
  end
  inherited btnCancel: TDNMSpeedButton
    Left = 330
    TabOrder = 10
    HelpContext = 292028
  end
  object edtWidthinch: TAdvEdit
    Left = 143
    Top = 153
    Width = 73
    Height = 21
    HelpContext = 292022
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
    TabOrder = 1
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtThicknessinch: TAdvEdit
    Left = 143
    Top = 185
    Width = 73
    Height = 21
    HelpContext = 292022
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
    TabOrder = 2
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtWidthmm: TAdvEdit
    Left = 279
    Top = 153
    Width = 73
    Height = 21
    HelpContext = 292022
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
    TabOrder = 3
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtThicknessmm: TAdvEdit
    Left = 279
    Top = 185
    Width = 73
    Height = 21
    HelpContext = 292022
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
  object edtTimbercost: TAdvEdit
    Left = 279
    Top = 249
    Width = 73
    Height = 21
    HelpContext = 292022
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
  object edtCostPlm: TAdvEdit
    Left = 279
    Top = 289
    Width = 73
    Height = 21
    HelpContext = 292022
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
  object rdoshadowGap: TwwRadioGroup
    Left = 424
    Top = 144
    Width = 121
    Height = 105
    HelpContext = 265048
    TransparentActiveItem = True
    Indents.TextX = 3
    Transparent = True
    Caption = 'Shadow Gap'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Items.Strings = (
      'No Gap'
      'Gap one Side'
      'Gap two side')
    ParentFont = False
    TabOrder = 5
  end
  object edtDescription: TAdvEdit
    Left = 128
    Top = 90
    Width = 417
    Height = 21
    HelpContext = 266058
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    Color = clWindow
    Enabled = True
    TabOrder = 0
    Text = 'ssss'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtTotalCost: TAdvEdit
    Left = 474
    Top = 289
    Width = 73
    Height = 21
    HelpContext = 292022
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
end
