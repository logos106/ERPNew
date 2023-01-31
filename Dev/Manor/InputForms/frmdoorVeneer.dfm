inherited fmdoorVeneer: TfmdoorVeneer
  Left = 1810
  Top = 13
  Caption = 'Door Veneer'
  ClientHeight = 169
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 164000
  inherited DNMPanel1: TDNMPanel
    Height = 59
    HelpContext = 164002
    inherited pnlTitle: TDNMPanel
      Top = 7
      HelpContext = 164003
      inherited TitleShader: TShader
        HelpContext = 164004
        inherited TitleLabel: TLabel
          Caption = 'Door Veneer'
          HelpContext = 164005
        end
      end
    end
  end
  inherited DNMPanel2: TDNMPanel
    Top = 59
    Height = 64
    HelpContext = 164006
    object Label6: TLabel
      Left = 17
      Top = 10
      Width = 77
      Height = 15
      Caption = 'Veneer Name'
      Transparent = True
      HelpContext = 164007
    end
    object Label10: TLabel
      Left = 17
      Top = 41
      Width = 67
      Height = 15
      Caption = 'Cost Per Sq'
      Transparent = True
      HelpContext = 164008
    end
    object wwDBEdit5: TwwDBEdit
      Left = 119
      Top = 6
      Width = 323
      Height = 23
      DataField = 'VeneerName'
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 164009
    end
    object wwDBEdit7: TwwDBEdit
      Left = 119
      Top = 37
      Width = 324
      Height = 23
      DataField = 'CostPerSq'
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 164010
    end
  end
  inherited DNMPanel3: TDNMPanel
    Top = 123
    HelpContext = 164011
    inherited Label9: TLabel
      HelpContext = 164012
    end
    inherited cmdSave: TDNMSpeedButton
      HelpContext = 164013
    end
    inherited cmdCancel: TDNMSpeedButton
      HelpContext = 164014
    end
    inherited cmdnew: TDNMSpeedButton
      HelpContext = 164015
    end
    inherited wwCheckBox1: TwwCheckBox
      HelpContext = 164016
    end
  end
  inherited imgGridWatermark: TImage
    HelpContext = 164001
  end
end
