inherited fmdoorStoptype: TfmdoorStoptype
  Left = 1804
  Top = 294
  Caption = 'Door Stop Type'
  ClientHeight = 138
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 162000
  inherited DNMPanel1: TDNMPanel
    Height = 59
    HelpContext = 162002
    inherited pnlTitle: TDNMPanel
      Top = 7
      HelpContext = 162003
      inherited TitleShader: TShader
        HelpContext = 162004
        inherited TitleLabel: TLabel
          Caption = 'Door Stop Type'
          HelpContext = 162005
        end
      end
    end
  end
  inherited DNMPanel2: TDNMPanel
    Top = 59
    Height = 33
    HelpContext = 162006
    object Label10: TLabel
      Left = 25
      Top = 9
      Width = 53
      Height = 15
      Caption = 'Stop type'
      Transparent = True
      HelpContext = 162007
    end
    object wwDBEdit7: TwwDBEdit
      Left = 127
      Top = 5
      Width = 298
      Height = 23
      DataField = 'StopType'
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 162008
    end
  end
  inherited DNMPanel3: TDNMPanel
    Top = 92
    HelpContext = 162009
    inherited Label9: TLabel
      HelpContext = 162010
    end
    inherited cmdSave: TDNMSpeedButton
      HelpContext = 162011
    end
    inherited cmdCancel: TDNMSpeedButton
      HelpContext = 162012
    end
    inherited cmdnew: TDNMSpeedButton
      HelpContext = 162013
    end
    inherited wwCheckBox1: TwwCheckBox
      HelpContext = 162014
    end
  end
  inherited imgGridWatermark: TImage
    HelpContext = 162001
  end
end
