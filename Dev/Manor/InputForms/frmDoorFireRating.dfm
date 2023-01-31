inherited fmDoorFireRating: TfmDoorFireRating
  Left = 1777
  Top = 726
  Caption = 'Door Firerating'
  ClientHeight = 206
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 155000
  inherited DNMPanel1: TDNMPanel
    Height = 59
    HelpContext = 155002
    inherited pnlTitle: TDNMPanel
      Top = 7
      HelpContext = 155003
      inherited TitleShader: TShader
        HelpContext = 155004
        inherited TitleLabel: TLabel
          Caption = 'Door Firerating'
          HelpContext = 155005
        end
      end
    end
  end
  inherited DNMPanel2: TDNMPanel
    Top = 59
    Height = 101
    HelpContext = 155006
    object Label6: TLabel
      Left = 17
      Top = 10
      Width = 60
      Height = 15
      Caption = 'Fire Rating'
      Transparent = True
      HelpContext = 155007
    end
    object Label10: TLabel
      Left = 17
      Top = 41
      Width = 102
      Height = 15
      Caption = 'Hard Wood Frame'
      Transparent = True
      HelpContext = 155008
    end
    object Label1: TLabel
      Left = 17
      Top = 73
      Width = 62
      Height = 15
      Caption = 'Quote Text'
      Transparent = True
      HelpContext = 155009
    end
    object wwDBEdit5: TwwDBEdit
      Left = 119
      Top = 6
      Width = 119
      Height = 23
      DataField = 'FireRating'
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 155010
    end
    object wwDBEdit7: TwwDBEdit
      Left = 119
      Top = 37
      Width = 120
      Height = 23
      DataField = 'HardWoodFrame'
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 155011
    end
    object wwDBEdit1: TwwDBEdit
      Left = 119
      Top = 69
      Width = 322
      Height = 23
      DataField = 'QuoteText'
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 155012
    end
  end
  inherited DNMPanel3: TDNMPanel
    Top = 160
    HelpContext = 155013
    inherited Label9: TLabel
      HelpContext = 155014
    end
    inherited cmdSave: TDNMSpeedButton
      HelpContext = 155015
    end
    inherited cmdCancel: TDNMSpeedButton
      HelpContext = 155016
    end
    inherited cmdnew: TDNMSpeedButton
      HelpContext = 155017
    end
    inherited wwCheckBox1: TwwCheckBox
      HelpContext = 155018
    end
  end
  inherited imgGridWatermark: TImage
    HelpContext = 155001
  end
end
