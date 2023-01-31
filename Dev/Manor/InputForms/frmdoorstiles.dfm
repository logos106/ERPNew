inherited fmdoorstiles: Tfmdoorstiles
  Left = 1289
  Top = 772
  Caption = 'Door Stiles'
  ClientHeight = 203
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 161000
  inherited DNMPanel1: TDNMPanel
    Height = 59
    HelpContext = 161002
    inherited pnlTitle: TDNMPanel
      Top = 7
      HelpContext = 161003
      inherited TitleShader: TShader
        HelpContext = 161004
        inherited TitleLabel: TLabel
          Caption = 'Door Stiles'
          HelpContext = 161005
        end
      end
    end
  end
  inherited DNMPanel2: TDNMPanel
    Top = 59
    Height = 98
    HelpContext = 161006
    object Label6: TLabel
      Left = 17
      Top = 10
      Width = 29
      Height = 15
      Caption = 'Code'
      Transparent = True
      HelpContext = 161007
    end
    object Label10: TLabel
      Left = 17
      Top = 41
      Width = 32
      Height = 15
      Caption = 'Stiles'
      Transparent = True
      HelpContext = 161008
    end
    object Label1: TLabel
      Left = 17
      Top = 73
      Width = 85
      Height = 15
      Caption = 'Cost Per Metre'
      Transparent = True
      HelpContext = 161009
    end
    object Code: TwwDBEdit
      Left = 119
      Top = 6
      Width = 151
      Height = 23
      DataField = 'Code'
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 161010
    end
    object wwDBEdit7: TwwDBEdit
      Left = 119
      Top = 37
      Width = 327
      Height = 23
      DataField = 'Stiles'
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 161011
    end
    object wwDBEdit1: TwwDBEdit
      Left = 119
      Top = 69
      Width = 151
      Height = 23
      DataField = 'CostPerMetre'
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 161012
    end
  end
  inherited DNMPanel3: TDNMPanel
    Top = 157
    HelpContext = 161013
    inherited Label9: TLabel
      HelpContext = 161014
    end
    inherited cmdSave: TDNMSpeedButton
      HelpContext = 161015
    end
    inherited cmdCancel: TDNMSpeedButton
      HelpContext = 161016
    end
    inherited cmdnew: TDNMSpeedButton
      HelpContext = 161017
    end
    inherited wwCheckBox1: TwwCheckBox
      HelpContext = 161018
    end
  end
  inherited imgGridWatermark: TImage
    HelpContext = 161001
  end
end
