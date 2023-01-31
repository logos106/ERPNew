inherited fmdoorsundry: Tfmdoorsundry
  Left = 1771
  Top = 478
  HelpContext = 163000
  Caption = 'Door Sundry'
  ClientHeight = 203
  PixelsPerInch = 96
  TextHeight = 15
  inherited imgGridWatermark: TImage
    HelpContext = 163001
  end
  inherited DNMPanel1: TDNMPanel
    Height = 59
    HelpContext = 163002
    inherited pnlTitle: TDNMPanel
      Top = 7
      HelpContext = 163003
      inherited TitleShader: TShader
        HelpContext = 163004
        inherited TitleLabel: TLabel
          HelpContext = 163005
          Caption = 'Door Sundry'
        end
      end
    end
  end
  inherited DNMPanel2: TDNMPanel
    Top = 59
    Height = 98
    HelpContext = 163006
    object Label6: TLabel
      Left = 17
      Top = 10
      Width = 29
      Height = 15
      HelpContext = 163007
      Caption = 'Code'
      Transparent = True
    end
    object Label10: TLabel
      Left = 17
      Top = 41
      Width = 65
      Height = 15
      HelpContext = 163008
      Caption = 'Description'
      Transparent = True
    end
    object Label1: TLabel
      Left = 17
      Top = 73
      Width = 26
      Height = 15
      HelpContext = 163009
      Caption = 'Cost'
      Transparent = True
    end
    object Code: TwwDBEdit
      Left = 119
      Top = 6
      Width = 119
      Height = 23
      HelpContext = 163010
      DataField = 'Code'
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit7: TwwDBEdit
      Left = 119
      Top = 37
      Width = 322
      Height = 23
      HelpContext = 163011
      DataField = 'Description'
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit1: TwwDBEdit
      Left = 119
      Top = 69
      Width = 119
      Height = 23
      HelpContext = 163012
      DataField = 'Cost'
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  inherited DNMPanel3: TDNMPanel
    Top = 157
    HelpContext = 163013
    inherited Label9: TLabel
      HelpContext = 163014
    end
    inherited cmdSave: TDNMSpeedButton
      HelpContext = 163015
    end
    inherited cmdCancel: TDNMSpeedButton
      HelpContext = 163016
    end
    inherited cmdnew: TDNMSpeedButton
      HelpContext = 163017
      Enabled = False
    end
    inherited wwCheckBox1: TwwCheckBox
      HelpContext = 163018
    end
  end
end
