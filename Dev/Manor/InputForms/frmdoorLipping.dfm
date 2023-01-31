inherited fmdoorLipping: TfmdoorLipping
  Left = 1864
  Top = 666
  Caption = 'Door Lipping'
  ClientHeight = 202
  ClientWidth = 463
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 160000
  inherited DNMPanel1: TDNMPanel
    Width = 463
    Height = 59
    HelpContext = 160002
    inherited pnlTitle: TDNMPanel
      Left = 41
      Top = 7
      HelpContext = 160003
      inherited TitleShader: TShader
        HelpContext = 160004
        inherited TitleLabel: TLabel
          Caption = 'Door Lipping'
          HelpContext = 160005
        end
      end
    end
  end
  inherited DNMPanel2: TDNMPanel
    Top = 59
    Width = 463
    Height = 97
    HelpContext = 160006
    object Label6: TLabel
      Left = 17
      Top = 10
      Width = 44
      Height = 15
      Caption = 'Lip type'
      Transparent = True
      HelpContext = 160007
    end
    object Label10: TLabel
      Left = 17
      Top = 41
      Width = 44
      Height = 15
      Caption = 'Lip Size'
      Transparent = True
      HelpContext = 160008
    end
    object Label1: TLabel
      Left = 17
      Top = 73
      Width = 46
      Height = 15
      Caption = 'Lip Cost'
      Transparent = True
      HelpContext = 160009
    end
    object wwDBEdit5: TwwDBEdit
      Left = 119
      Top = 69
      Width = 151
      Height = 23
      DataField = 'LipCost'
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 160010
    end
    object wwDBEdit7: TwwDBEdit
      Left = 119
      Top = 37
      Width = 151
      Height = 23
      DataField = 'LipSize'
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 160011
    end
    object cboUnit: TwwDBComboBox
      Left = 119
      Top = 6
      Width = 327
      Height = 23
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'LipType'
      DropDownCount = 8
      ItemHeight = 0
      Items.Strings = (
        'american walnut'
        'Ash'
        'Beech'
        'Cherry'
        'European Oak'
        'Iroko'
        'Maple'
        'Meranti/Lauan'
        'Ramin'
        'Red Oak'
        'White Oak')
      Sorted = False
      TabOrder = 0
      UnboundDataType = wwDefault
      HelpContext = 160012
    end
  end
  inherited DNMPanel3: TDNMPanel
    Top = 156
    Width = 463
    HelpContext = 160013
    inherited cmdCancel: TDNMSpeedButton
      Left = 297
      HelpContext = 160016
    end
    inherited Label9: TLabel
      HelpContext = 160014
    end
    inherited cmdSave: TDNMSpeedButton
      HelpContext = 160015
    end
    inherited cmdnew: TDNMSpeedButton
      HelpContext = 160017
    end
    inherited wwCheckBox1: TwwCheckBox
      HelpContext = 160018
    end
  end
  inherited imgGridWatermark: TImage
    HelpContext = 160001
  end
end
