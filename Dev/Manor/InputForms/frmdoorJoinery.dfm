inherited fmdoorJoinery: TfmdoorJoinery
  Left = 1777
  Top = 430
  Caption = 'Door Joinery'
  ClientHeight = 203
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 159000
  inherited DNMPanel1: TDNMPanel
    Height = 59
    HelpContext = 159002
    inherited pnlTitle: TDNMPanel
      Top = 7
      HelpContext = 159003
      inherited TitleShader: TShader
        HelpContext = 159004
        inherited TitleLabel: TLabel
          Caption = 'Door Joinery'
          HelpContext = 159005
        end
      end
    end
  end
  inherited DNMPanel2: TDNMPanel
    Top = 59
    Height = 98
    HelpContext = 159006
    object Label6: TLabel
      Left = 17
      Top = 10
      Width = 26
      Height = 15
      Caption = 'Cost'
      Transparent = True
      HelpContext = 159007
    end
    object Label10: TLabel
      Left = 17
      Top = 41
      Width = 58
      Height = 15
      Caption = 'Desription'
      Transparent = True
      HelpContext = 159008
    end
    object Label1: TLabel
      Left = 17
      Top = 73
      Width = 82
      Height = 15
      Caption = 'Unit Of Charge'
      Transparent = True
      HelpContext = 159009
    end
    object wwDBEdit5: TwwDBEdit
      Left = 119
      Top = 6
      Width = 151
      Height = 23
      DataField = 'Cost'
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 159010
    end
    object wwDBEdit7: TwwDBEdit
      Left = 119
      Top = 37
      Width = 327
      Height = 23
      DataField = 'Description'
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 159011
    end
    object cboUnit: TwwDBComboBox
      Left = 119
      Top = 67
      Width = 151
      Height = 23
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'UnitOfCharge'
      DropDownCount = 8
      ItemHeight = 0
      Items.Strings = (
        'Each'
        'Per Vent'
        'One and Half Pair Hinges')
      Sorted = False
      TabOrder = 2
      UnboundDataType = wwDefault
      HelpContext = 159012
    end
  end
  inherited DNMPanel3: TDNMPanel
    Top = 157
    HelpContext = 159013
    inherited Label9: TLabel
      HelpContext = 159014
    end
    inherited cmdSave: TDNMSpeedButton
      HelpContext = 159015
    end
    inherited cmdCancel: TDNMSpeedButton
      HelpContext = 159016
    end
    inherited cmdnew: TDNMSpeedButton
      HelpContext = 159017
    end
    inherited wwCheckBox1: TwwCheckBox
      HelpContext = 159018
    end
  end
  inherited imgGridWatermark: TImage
    HelpContext = 159001
  end
end
