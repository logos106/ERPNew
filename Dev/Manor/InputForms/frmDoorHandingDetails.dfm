inherited fmDoorHandingDetails: TfmDoorHandingDetails
  Left = 1611
  Top = 226
  Caption = 'Door Handing Details'
  ClientHeight = 169
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 157000
  inherited DNMPanel1: TDNMPanel
    Height = 59
    HelpContext = 157002
    inherited pnlTitle: TDNMPanel
      Top = 7
      HelpContext = 157003
      inherited TitleShader: TShader
        HelpContext = 157004
        inherited TitleLabel: TLabel
          Caption = 'Door Handing Details'
          HelpContext = 157005
        end
      end
    end
  end
  inherited DNMPanel2: TDNMPanel
    Top = 59
    Height = 64
    HelpContext = 157006
    object Label6: TLabel
      Left = 17
      Top = 10
      Width = 65
      Height = 15
      Caption = 'Description'
      Transparent = True
      HelpContext = 157007
    end
    object Label10: TLabel
      Left = 17
      Top = 41
      Width = 117
      Height = 15
      Caption = 'Handing Abbrevation'
      Transparent = True
      HelpContext = 157008
    end
    object wwDBEdit5: TwwDBEdit
      Left = 147
      Top = 6
      Width = 288
      Height = 23
      DataField = 'Description'
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 157009
    end
    object wwDBEdit7: TwwDBEdit
      Left = 147
      Top = 37
      Width = 289
      Height = 23
      DataField = 'HandingAbbrev'
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 157010
    end
  end
  inherited DNMPanel3: TDNMPanel
    Top = 123
    HelpContext = 157011
    inherited Label9: TLabel
      HelpContext = 157012
    end
    inherited cmdSave: TDNMSpeedButton
      HelpContext = 157013
    end
    inherited cmdCancel: TDNMSpeedButton
      HelpContext = 157014
    end
    inherited cmdnew: TDNMSpeedButton
      HelpContext = 157015
    end
    inherited wwCheckBox1: TwwCheckBox
      HelpContext = 157016
    end
  end
  inherited imgGridWatermark: TImage
    HelpContext = 157001
  end
end
