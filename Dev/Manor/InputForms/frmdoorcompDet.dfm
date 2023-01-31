inherited fmDoorcompDet: TfmDoorcompDet
  Left = 1285
  Top = 0
  Caption = 'Door Component Details'
  ClientHeight = 258
  ClientWidth = 465
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 152000
  inherited DNMPanel1: TDNMPanel
    Width = 465
    Height = 59
    HelpContext = 152002
    inherited pnlTitle: TDNMPanel
      Left = 41
      Top = 7
      HelpContext = 152003
      inherited TitleShader: TShader
        HelpContext = 152004
        inherited TitleLabel: TLabel
          Caption = 'Door Component Details'
          HelpContext = 152005
        end
      end
    end
  end
  inherited DNMPanel2: TDNMPanel
    Top = 59
    Width = 465
    Height = 153
    HelpContext = 152006
    object Label1: TLabel
      Left = 33
      Top = 10
      Width = 54
      Height = 15
      Caption = 'comp Ref'
      Transparent = True
      HelpContext = 152007
    end
    object Label2: TLabel
      Left = 313
      Top = 10
      Width = 41
      Height = 15
      Caption = 'Size no'
      Transparent = True
      HelpContext = 152008
    end
    object Label3: TLabel
      Left = 33
      Top = 58
      Width = 36
      Height = 15
      Caption = 'Height'
      Transparent = True
      HelpContext = 152009
    end
    object Label4: TLabel
      Left = 173
      Top = 58
      Width = 33
      Height = 15
      Caption = 'Width'
      Transparent = True
      HelpContext = 152010
    end
    object Label5: TLabel
      Left = 313
      Top = 58
      Width = 59
      Height = 15
      Caption = 'Thickness'
      Transparent = True
      HelpContext = 152011
    end
    object Label6: TLabel
      Left = 33
      Top = 109
      Width = 57
      Height = 15
      Caption = 'Tolerance'
      Transparent = True
      HelpContext = 152012
    end
    object Label7: TLabel
      Left = 173
      Top = 109
      Width = 22
      Height = 15
      Caption = 'Unit'
      Transparent = True
      HelpContext = 152013
    end
    object Label8: TLabel
      Left = 313
      Top = 109
      Width = 26
      Height = 15
      Caption = 'Cost'
      Transparent = True
      HelpContext = 152014
    end
    object edtcompRef: TwwDBEdit
      Left = 33
      Top = 25
      Width = 258
      Height = 23
      DataField = 'CompRef'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 152015
    end
    object edtHeight: TwwDBEdit
      Left = 33
      Top = 73
      Width = 121
      Height = 23
      DataField = 'Height'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 152016
    end
    object edtWidth: TwwDBEdit
      Left = 173
      Top = 73
      Width = 121
      Height = 23
      DataField = 'Width'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 152017
    end
    object edtsizeno: TwwDBEdit
      Left = 313
      Top = 25
      Width = 121
      Height = 23
      DataField = 'SizeNo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 152018
    end
    object edtthickness: TwwDBEdit
      Left = 313
      Top = 73
      Width = 121
      Height = 23
      DataField = 'Thickness'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 152019
    end
    object edtTolerance: TwwDBEdit
      Left = 33
      Top = 122
      Width = 121
      Height = 23
      DataField = 'Tolerance'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 152020
    end
    object edtcost: TwwDBEdit
      Left = 313
      Top = 122
      Width = 121
      Height = 23
      DataField = 'Cost'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 152021
    end
    object cboUnit: TwwDBComboBox
      Left = 173
      Top = 122
      Width = 121
      Height = 23
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'compDetUnit'
      DropDownCount = 8
      ItemHeight = 0
      Items.Strings = (
        'sq m'
        'each'
        'lin m')
      Sorted = False
      TabOrder = 6
      UnboundDataType = wwDefault
      HelpContext = 152022
    end
  end
  inherited DNMPanel3: TDNMPanel
    Top = 212
    Width = 465
    HelpContext = 152023
    inherited cmdSave: TDNMSpeedButton
      Left = 89
      HelpContext = 152025
    end
    inherited cmdCancel: TDNMSpeedButton
      Left = 278
      HelpContext = 152026
    end
    inherited cmdnew: TDNMSpeedButton
      Left = 183
      Glyph.Data = {00000000}
      NumGlyphs = 0
      HelpContext = 152027
    end
    inherited Label9: TLabel
      HelpContext = 152024
    end
    inherited wwCheckBox1: TwwCheckBox
      HelpContext = 152028
    end
  end
  inherited imgGridWatermark: TImage
    HelpContext = 152001
  end
end
