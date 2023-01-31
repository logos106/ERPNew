inherited FmPOSInput: TFmPOSInput
  HelpContext = 966001
  Caption = 'FmPOSInput'
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 803
  ExplicitHeight = 362
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    Left = 10
    Width = 385
    HelpContext = 966002
    ExplicitLeft = 10
    ExplicitWidth = 385
  end
  inherited Bevel2: TBevel
    Left = 152
    Width = 490
    HelpContext = 966003
    ExplicitLeft = 152
    ExplicitWidth = 490
  end
  object Bevel3: TBevel [3]
    Left = 400
    Top = 96
    Width = 385
    Height = 121
    HelpContext = 966004
    Shape = bsFrame
  end
  object lbl1: TLabel [4]
    Left = 18
    Top = 105
    Width = 22
    Height = 14
    HelpContext = 966005
    Caption = 'lbl1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl2: TLabel [5]
    Left = 408
    Top = 105
    Width = 22
    Height = 14
    HelpContext = 966006
    Caption = 'lbl2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited edtInput1: TwwDBEdit
    Left = 18
    Top = 124
    Width = 356
    HelpContext = 966007
    MaxLength = 9
    ExplicitLeft = 18
    ExplicitTop = 124
    ExplicitWidth = 356
  end
  inherited OKBtn: TDNMSpeedButton
    Left = 256
    ExplicitLeft = 256
  end
  inherited CancelBtn: TDNMSpeedButton
    Left = 444
    ExplicitLeft = 444
  end
  inherited pnlNumericKeyPad: TDNMPanel
    Left = 27
    ExplicitLeft = 27
    HelpContext = 966012
  end
  inherited pnlTitle: TDNMPanel
    Left = 167
    Width = 460
    HelpContext = 966008
    ExplicitLeft = 167
    ExplicitWidth = 460
    inherited TitleShader: TShader
      Width = 456
      HelpContext = 966009
      ExplicitWidth = 456
      inherited TitleLabel: TLabel
        Width = 456
        HelpContext = 966010
        ExplicitWidth = 456
      end
    end
  end
  object edtInput2: TwwDBEdit [11]
    Left = 408
    Top = 124
    Width = 369
    Height = 89
    HelpContext = 966011
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -64
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
    OnChange = edtInput1Change
    OnEnter = edtInput1Enter
  end
end
