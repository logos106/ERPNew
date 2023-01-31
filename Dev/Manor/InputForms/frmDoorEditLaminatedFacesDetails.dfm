inherited frmDoorEditLaminatedFacesDetailsGUI: TfrmDoorEditLaminatedFacesDetailsGUI
  Left = 1681
  Top = 258
  HelpContext = 302000
  Caption = 'Laminated Faces Details'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    HelpContext = 302001
  end
  object Bevel2: TBevel [1]
    Left = 56
    Top = 112
    Width = 169
    Height = 121
    HelpContext = 302007
    Shape = bsFrame
  end
  object Label1: TLabel [2]
    Left = 56
    Top = 96
    Width = 100
    Height = 15
    HelpContext = 302008
    Caption = 'Laminated Face 1'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel [3]
    Left = 72
    Top = 128
    Width = 53
    Height = 15
    HelpContext = 302009
    Caption = 'Laminate'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel [4]
    Left = 72
    Top = 176
    Width = 90
    Height = 15
    HelpContext = 302010
    Caption = 'Lump Sum Cost'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel [5]
    Left = 240
    Top = 96
    Width = 100
    Height = 15
    HelpContext = 302011
    Caption = 'Laminated Face 2'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Bevel3: TBevel [6]
    Left = 240
    Top = 112
    Width = 169
    Height = 121
    HelpContext = 302012
    Shape = bsFrame
  end
  object Label5: TLabel [7]
    Left = 256
    Top = 128
    Width = 53
    Height = 15
    HelpContext = 302013
    Caption = 'Laminate'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label6: TLabel [8]
    Left = 256
    Top = 176
    Width = 90
    Height = 15
    HelpContext = 302014
    Caption = 'Lump Sum Cost'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label7: TLabel [9]
    Left = 104
    Top = 256
    Width = 84
    Height = 15
    HelpContext = 302015
    Caption = 'Labour Charge'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label8: TLabel [10]
    Left = 88
    Top = 288
    Width = 101
    Height = 15
    HelpContext = 302016
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
    Left = 30
    Width = 428
    HelpContext = 302002
    TabOrder = 8
    inherited TitleShader: TShader
      Width = 426
      HelpContext = 302003
      inherited TitleLabel: TLabel
        Width = 426
        HelpContext = 302004
        Caption = 'Laminated Faces Details'
      end
    end
  end
  inherited btnSave: TDNMSpeedButton
    HelpContext = 302005
    TabOrder = 6
  end
  inherited btnCancel: TDNMSpeedButton
    HelpContext = 302006
    TabOrder = 7
  end
  object edtLaminateOne: TAdvEdit
    Left = 72
    Top = 144
    Width = 137
    Height = 21
    HelpContext = 302017
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
  object edtLumpSumCostOne: TAdvEdit
    Left = 72
    Top = 192
    Width = 137
    Height = 21
    HelpContext = 302018
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
  object edtLaminateTwo: TAdvEdit
    Left = 256
    Top = 144
    Width = 137
    Height = 21
    HelpContext = 302019
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 2
    Visible = True
    Version = '2.7.5.0'
  end
  object edtLumpSumCostTwo: TAdvEdit
    Left = 256
    Top = 192
    Width = 137
    Height = 21
    HelpContext = 302020
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
  object edtLabourCharge: TAdvEdit
    Left = 200
    Top = 248
    Width = 137
    Height = 21
    HelpContext = 302021
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
  object edtTotalVeneerCost: TAdvEdit
    Left = 200
    Top = 280
    Width = 137
    Height = 21
    HelpContext = 302022
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
end
