inherited fmDoorGlazing: TfmDoorGlazing
  Left = 148
  Top = 205
  Caption = 'Door Glazing'
  ClientHeight = 247
  ClientWidth = 566
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 156000
  inherited DNMPanel1: TDNMPanel
    Width = 566
    Height = 59
    HelpContext = 156002
    inherited pnlTitle: TDNMPanel
      Left = 92
      Top = 7
      HelpContext = 156003
      inherited TitleShader: TShader
        HelpContext = 156004
        inherited TitleLabel: TLabel
          Caption = 'Door Glazing'
          HelpContext = 156005
        end
      end
    end
  end
  inherited DNMPanel2: TDNMPanel
    Top = 59
    Width = 566
    Height = 142
    HelpContext = 156006
    object Label6: TLabel
      Left = 17
      Top = 10
      Width = 77
      Height = 15
      Caption = 'Channel Mats'
      FocusControl = cboUnit
      Transparent = True
      HelpContext = 156007
    end
    object Label10: TLabel
      Left = 17
      Top = 41
      Width = 70
      Height = 15
      Caption = 'Glazing Cost'
      Transparent = True
      HelpContext = 156008
    end
    object Label1: TLabel
      Left = 17
      Top = 65
      Width = 101
      Height = 30
      Caption = 'Glazing Performa Text'
      Transparent = True
      WordWrap = True
      HelpContext = 156009
    end
    object Label2: TLabel
      Left = 17
      Top = 105
      Width = 72
      Height = 15
      Caption = 'Manufacture'
      Transparent = True
      HelpContext = 156010
    end
    object Label7: TLabel
      Left = 312
      Top = 10
      Width = 72
      Height = 15
      Caption = 'Glazing Mats'
      Transparent = True
      HelpContext = 156011
    end
    object Label3: TLabel
      Left = 312
      Top = 41
      Width = 80
      Height = 15
      Caption = 'Glazing Shape'
      Transparent = True
      HelpContext = 156012
    end
    object Label4: TLabel
      Left = 312
      Top = 73
      Width = 71
      Height = 15
      Caption = 'Glazing Type'
      Transparent = True
      HelpContext = 156013
    end
    object Label5: TLabel
      Left = 312
      Top = 105
      Width = 66
      Height = 15
      Caption = 'Glazing Unit'
      Transparent = True
      HelpContext = 156014
    end
    object wwDBEdit5: TwwDBEdit
      Left = 119
      Top = 6
      Width = 151
      Height = 23
      DataField = 'ChannelMats'
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 156015
    end
    object wwDBEdit7: TwwDBEdit
      Left = 119
      Top = 37
      Width = 151
      Height = 23
      DataField = 'GlazingCost'
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 156016
    end
    object wwDBEdit1: TwwDBEdit
      Left = 119
      Top = 69
      Width = 151
      Height = 23
      DataField = 'GlazingProformaText'
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 156017
    end
    object wwDBEdit2: TwwDBEdit
      Left = 119
      Top = 101
      Width = 151
      Height = 23
      DataField = 'Manufacturer'
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 156018
    end
    object cboUnit: TwwDBComboBox
      Left = 396
      Top = 6
      Width = 151
      Height = 23
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'GlazingMats'
      DropDownCount = 8
      ItemHeight = 0
      Items.Strings = (
        'Beech only l.p.i.'
        'Ash'
        'Beech'
        'Iroko'
        'Oak European'
        'Oak Red'
        'Oak White'
        'Ramin'
        'Sapele'
        'Am.Cherry'
        'Maple'
        'Sycamore')
      Sorted = False
      TabOrder = 4
      UnboundDataType = wwDefault
      HelpContext = 156019
    end
    object wwDBComboBox1: TwwDBComboBox
      Left = 396
      Top = 37
      Width = 151
      Height = 23
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'GlazingShape'
      DropDownCount = 8
      ItemHeight = 0
      Items.Strings = (
        'Circular'
        'Square')
      Sorted = False
      TabOrder = 5
      UnboundDataType = wwDefault
      HelpContext = 156020
    end
    object wwDBComboBox2: TwwDBComboBox
      Left = 396
      Top = 69
      Width = 151
      Height = 23
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'GlazingType'
      DropDownCount = 8
      ItemHeight = 0
      Items.Strings = (
        '300'
        '400'
        '450'
        '500'
        'Pyroglaze 60'
        'Rebated Beading'
        'Special'
        'Standard')
      Sorted = False
      TabOrder = 6
      UnboundDataType = wwDefault
      HelpContext = 156021
    end
    object wwDBComboBox3: TwwDBComboBox
      Left = 396
      Top = 101
      Width = 151
      Height = 23
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'GlazingUnit'
      DropDownCount = 8
      ItemHeight = 0
      Items.Strings = (
        'Lin Mtr')
      Sorted = False
      TabOrder = 7
      UnboundDataType = wwDefault
      HelpContext = 156022
    end
  end
  inherited DNMPanel3: TDNMPanel
    Top = 201
    Width = 566
    HelpContext = 156023
    inherited Label9: TLabel
      Left = 515
      Anchors = [akBottom]
      HelpContext = 156024
    end
    inherited cmdSave: TDNMSpeedButton
      Left = 104
      HelpContext = 156025
    end
    inherited cmdCancel: TDNMSpeedButton
      Left = 372
      HelpContext = 156026
    end
    inherited cmdnew: TDNMSpeedButton
      Left = 238
      HelpContext = 156027
    end
    inherited wwCheckBox1: TwwCheckBox
      Left = 490
      Anchors = [akBottom]
      HelpContext = 156028
    end
  end
  inherited imgGridWatermark: TImage
    HelpContext = 156001
  end
end
