inherited fmDoorFinish: TfmDoorFinish
  Left = 1761
  Top = 8
  Caption = 'Door Finish'
  ClientHeight = 169
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 154000
  inherited DNMPanel1: TDNMPanel
    Height = 59
    HelpContext = 154002
    inherited pnlTitle: TDNMPanel
      Top = 7
      HelpContext = 154003
      inherited TitleShader: TShader
        HelpContext = 154004
        inherited TitleLabel: TLabel
          Caption = 'Door Finish'
          HelpContext = 154005
        end
      end
    end
  end
  inherited DNMPanel2: TDNMPanel
    Top = 59
    Height = 64
    HelpContext = 154006
    object Label6: TLabel
      Left = 17
      Top = 10
      Width = 33
      Height = 15
      Caption = 'Name'
      Transparent = True
      HelpContext = 154007
    end
    object Label10: TLabel
      Left = 17
      Top = 41
      Width = 26
      Height = 15
      Caption = 'Cost'
      Transparent = True
      HelpContext = 154008
    end
    object wwDBEdit5: TwwDBEdit
      Left = 119
      Top = 6
      Width = 322
      Height = 23
      DataField = 'FinishName'
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 154009
    end
    object wwDBEdit7: TwwDBEdit
      Left = 119
      Top = 37
      Width = 120
      Height = 23
      DataField = 'cost'
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 154010
    end
  end
  inherited DNMPanel3: TDNMPanel
    Top = 123
    HelpContext = 154011
    inherited Label9: TLabel
      HelpContext = 154012
    end
    inherited cmdSave: TDNMSpeedButton
      HelpContext = 154013
    end
    inherited cmdCancel: TDNMSpeedButton
      HelpContext = 154014
    end
    inherited cmdnew: TDNMSpeedButton
      HelpContext = 154015
    end
    inherited wwCheckBox1: TwwCheckBox
      HelpContext = 154016
    end
  end
  inherited imgGridWatermark: TImage
    HelpContext = 154001
  end
end
