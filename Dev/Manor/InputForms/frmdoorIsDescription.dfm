inherited fmdoorIsDescription: TfmdoorIsDescription
  Left = 1768
  Top = 211
  Caption = 'Door Description'
  ClientHeight = 169
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 158000
  inherited DNMPanel1: TDNMPanel
    Height = 59
    HelpContext = 158002
    inherited pnlTitle: TDNMPanel
      Top = 7
      HelpContext = 158003
      inherited TitleShader: TShader
        HelpContext = 158004
        inherited TitleLabel: TLabel
          Caption = 'Door Description'
          HelpContext = 158005
        end
      end
    end
  end
  inherited DNMPanel2: TDNMPanel
    Top = 59
    Height = 64
    HelpContext = 158006
    object Label6: TLabel
      Left = 17
      Top = 10
      Width = 29
      Height = 15
      Caption = 'Code'
      Transparent = True
      HelpContext = 158007
    end
    object Label10: TLabel
      Left = 17
      Top = 41
      Width = 65
      Height = 15
      Caption = 'Description'
      Transparent = True
      HelpContext = 158008
    end
    object wwDBEdit7: TwwDBEdit
      Left = 119
      Top = 37
      Width = 324
      Height = 23
      DataField = 'Description'
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 158009
    end
    object wwDBEdit5: TwwDBEdit
      Left = 119
      Top = 6
      Width = 106
      Height = 23
      DataField = 'Code'
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 158010
    end
  end
  inherited DNMPanel3: TDNMPanel
    Top = 123
    HelpContext = 158011
    inherited Label9: TLabel
      HelpContext = 158012
    end
    inherited cmdSave: TDNMSpeedButton
      HelpContext = 158013
    end
    inherited cmdCancel: TDNMSpeedButton
      HelpContext = 158014
    end
    inherited cmdnew: TDNMSpeedButton
      HelpContext = 158015
    end
    inherited wwCheckBox1: TwwCheckBox
      HelpContext = 158016
    end
  end
  inherited imgGridWatermark: TImage
    HelpContext = 158001
  end
end
