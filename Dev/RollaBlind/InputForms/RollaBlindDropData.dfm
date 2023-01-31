inherited RollaBlindDropDataGUI: TRollaBlindDropDataGUI
  Caption = 'Drop Data'
  ClientHeight = 377
  ClientWidth = 360
  PixelsPerInch = 96
  TextHeight = 15
  inherited DNMPanel1: TDNMPanel
    Width = 360
    Height = 377
    inherited Bevel1: TBevel
      Width = 328
      Height = 249
    end
    object Label1: TLabel [1]
      Left = 40
      Top = 88
      Width = 67
      Height = 15
      Caption = 'Profile Type'
      Transparent = True
    end
    object Label2: TLabel [2]
      Left = 40
      Top = 144
      Width = 76
      Height = 15
      Caption = 'Housing Type'
      Transparent = True
    end
    object Label3: TLabel [3]
      Left = 40
      Top = 200
      Width = 50
      Height = 15
      Caption = 'Min Drop'
      Transparent = True
    end
    object Label4: TLabel [4]
      Left = 40
      Top = 256
      Width = 54
      Height = 15
      Caption = 'Max Drop'
      Transparent = True
    end
    object Label5: TLabel [5]
      Left = 192
      Top = 88
      Width = 86
      Height = 15
      Caption = 'Hidden Profiles'
      Transparent = True
    end
    object Label6: TLabel [6]
      Left = 192
      Top = 144
      Width = 73
      Height = 15
      Caption = 'Profile Width'
      Transparent = True
    end
    object Label7: TLabel [7]
      Left = 192
      Top = 200
      Width = 85
      Height = 15
      Caption = 'Housing Height'
      Transparent = True
    end
    object Label8: TLabel [8]
      Left = 216
      Top = 274
      Width = 61
      Height = 15
      Caption = 'Perforated'
      Transparent = True
    end
    inherited pnlTitle: TDNMPanel
      Left = 80
      Width = 201
      TabOrder = 11
    end
    inherited btnSave: TDNMSpeedButton
      Left = 30
      Top = 336
      TabOrder = 8
    end
    inherited btnCancel: TDNMSpeedButton
      Left = 242
      Top = 336
      TabOrder = 10
    end
    inherited btnNew: TDNMSpeedButton
      Left = 136
      Top = 336
      TabOrder = 9
    end
    object cboProfileType: TwwDBLookupCombo
      Left = 40
      Top = 104
      Width = 129
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      DataField = 'ProfileType'
      DataSource = dsMain
      LookupTable = qryProfileType
      LookupField = 'ProfileType'
      Style = csDropDownList
      ParentFont = False
      TabOrder = 0
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
    object cboGuideType: TwwDBComboBox
      Left = 40
      Top = 160
      Width = 129
      Height = 23
      ShowButton = True
      Style = csDropDownList
      MapList = False
      AllowClearKey = False
      DataField = 'Category'
      DataSource = dsMain
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        'Large'
        'Micro'
        'Mini'
        'Std')
      ParentFont = False
      Sorted = False
      TabOrder = 1
      UnboundDataType = wwDefault
    end
    object edtMinDrop: TwwDBEdit
      Left = 40
      Top = 216
      Width = 129
      Height = 23
      DataField = 'MinDrop'
      DataSource = dsMain
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
    end
    object edtMaxDrop: TwwDBEdit
      Left = 40
      Top = 272
      Width = 129
      Height = 23
      DataField = 'MaxDrop'
      DataSource = dsMain
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
    end
    object edtHiddenProfiles: TwwDBEdit
      Left = 192
      Top = 104
      Width = 129
      Height = 23
      DataField = 'HiddenProfiles'
      DataSource = dsMain
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
    end
    object edtProfileWidth: TwwDBEdit
      Left = 192
      Top = 160
      Width = 129
      Height = 23
      DataField = 'ProfileWidth'
      DataSource = dsMain
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
    end
    object edtHousingHeight: TwwDBEdit
      Left = 192
      Top = 216
      Width = 129
      Height = 23
      DataField = 'HousingHeight'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object chkPerforated: TwwCheckBox
      Left = 192
      Top = 274
      Width = 17
      Height = 17
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Caption = 'Perforated'
      DataField = 'Perforated'
      DataSource = dsMain
      TabOrder = 7
    end
  end
  inherited qryMain: TMyQuery
    Connection = nil
    SQL.Strings = (
      'SELECT * FROM tblrollaprofdata')
  end
  object qryProfileType: TMyQuery
    SQL.Strings = (
      'SELECT * FROM tblrollaprofiletypes')
    Left = 72
    Top = 40
  end
end
