inherited fmDoorComp: TfmDoorComp
  Left = 416
  Top = 254
  HelpContext = 151000
  Caption = 'Door Component'
  ClientHeight = 258
  ClientWidth = 465
  PixelsPerInch = 96
  TextHeight = 15
  inherited imgGridWatermark: TImage
    HelpContext = 151001
  end
  inherited DNMPanel1: TDNMPanel
    Width = 465
    Height = 59
    HelpContext = 151002
    TabOrder = 2
    inherited pnlTitle: TDNMPanel
      Left = 41
      Top = 7
      HelpContext = 151003
      inherited TitleShader: TShader
        HelpContext = 151004
        inherited TitleLabel: TLabel
          HelpContext = 151005
          Caption = 'Door Component'
        end
      end
    end
  end
  inherited DNMPanel2: TDNMPanel
    Top = 59
    Width = 465
    Height = 153
    HelpContext = 151006
    TabOrder = 0
    object Label1: TLabel
      Left = 33
      Top = 9
      Width = 55
      Height = 15
      HelpContext = 151007
      Caption = 'Comp Ref'
      Transparent = True
    end
    object Label2: TLabel
      Left = 313
      Top = 9
      Width = 57
      Height = 15
      HelpContext = 151008
      Caption = 'Door Type'
      Transparent = True
    end
    object Label7: TLabel
      Left = 313
      Top = 107
      Width = 33
      Height = 15
      HelpContext = 151009
      Caption = 'Finish'
      Transparent = True
    end
    object Label3: TLabel
      Left = 33
      Top = 60
      Width = 67
      Height = 15
      HelpContext = 151010
      Caption = 'Height Mats'
      Transparent = True
    end
    object Label4: TLabel
      Left = 313
      Top = 60
      Width = 47
      Height = 15
      HelpContext = 151011
      Caption = 'Quantity'
      Transparent = True
    end
    object Label5: TLabel
      Left = 175
      Top = 60
      Width = 64
      Height = 15
      HelpContext = 151012
      Caption = 'Width Mats'
      Transparent = True
    end
    object Label6: TLabel
      Left = 33
      Top = 107
      Width = 46
      Height = 15
      HelpContext = 151013
      Caption = 'Position'
      Transparent = True
    end
    object cboFinish: TwwDBComboBox
      Left = 313
      Top = 122
      Width = 121
      Height = 23
      HelpContext = 151014
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'Finish'
      DropDownCount = 8
      ItemHeight = 0
      Items.Strings = (
        'Ply For Paint'
        'M.D.F.'
        'Ply For Stain'
        'MDF'
        'Plywood for paint'
        'Particleboard'
        'Wood'
        'Chipboard'
        'Plywood'
        'Chipvoard'
        'Chipcoard')
      Sorted = False
      TabOrder = 6
      UnboundDataType = wwDefault
    end
    object edtHeightMats: TwwDBEdit
      Left = 33
      Top = 76
      Width = 121
      Height = 23
      HelpContext = 151015
      DataField = 'HghtMats'
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtQuantity: TwwDBEdit
      Left = 313
      Top = 76
      Width = 121
      Height = 23
      HelpContext = 151016
      DataField = 'Quantity'
      TabOrder = 4
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtWidthMats: TwwDBEdit
      Left = 175
      Top = 76
      Width = 121
      Height = 23
      HelpContext = 151017
      DataField = 'WidMats'
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object cboPosition: TwwDBComboBox
      Left = 33
      Top = 122
      Width = 264
      Height = 23
      HelpContext = 151018
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'Position'
      DropDownCount = 8
      ItemHeight = 0
      Items.Strings = (
        'Area'
        'Core'
        'Height'
        'Width'
        'Item')
      Sorted = False
      TabOrder = 5
      UnboundDataType = wwDefault
    end
    object wwDBLookupCombo1: TwwDBLookupCombo
      Left = 32
      Top = 26
      Width = 121
      Height = 23
      HelpContext = 151019
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'CompRef'#9'30'#9'CompRef'#9'F')
      DataField = 'CompRef'
      LookupTable = qrycompRef
      LookupField = 'CompRef'
      TabOrder = 0
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
    object wwDBLookupCombo2: TwwDBLookupCombo
      Left = 312
      Top = 26
      Width = 121
      Height = 23
      HelpContext = 151020
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'DoorType'#9'30'#9'DoorType'#9'F'
        'finish'#9'30'#9'finish'#9'F')
      DataField = 'doortype'
      LookupTable = qrydoortype
      LookupField = 'DoorType'
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
  end
  inherited DNMPanel3: TDNMPanel
    Top = 212
    Width = 465
    HelpContext = 151021
    TabOrder = 1
    inherited Label9: TLabel
      Left = 409
      HelpContext = 151022
    end
    inherited cmdSave: TDNMSpeedButton
      Left = 76
      HelpContext = 151023
    end
    inherited cmdCancel: TDNMSpeedButton
      Left = 299
      HelpContext = 151024
    end
    inherited cmdnew: TDNMSpeedButton
      Left = 187
      HelpContext = 151025
    end
    inherited wwCheckBox1: TwwCheckBox
      Left = 391
      HelpContext = 151026
    end
  end
  object qrycompRef: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select CompRef from vwDoorcompDetList where ifnull(Active,'#39#39') <>' +
        ' '#39'F'#39' OR  compref = :CompRef')
    Left = 208
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CompRef'
      end>
    object qrycompRefCompRef: TStringField
      DisplayWidth = 30
      FieldName = 'CompRef'
      Origin = 'vwDoorcompDetList.CompRef'
      Size = 255
    end
  end
  object qrydoortype: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select DoorType, finish from vwdoorDetaillist where ifnull(Activ' +
        'e,'#39#39') <> '#39'F'#39'  or DoorType = :Doortype')
    Left = 272
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Doortype'
      end>
    object qrydoortypeDoorType: TStringField
      DisplayWidth = 30
      FieldName = 'DoorType'
      Size = 255
    end
    object qrydoortypefinish: TStringField
      DisplayWidth = 30
      FieldName = 'finish'
      Size = 255
    end
  end
end
