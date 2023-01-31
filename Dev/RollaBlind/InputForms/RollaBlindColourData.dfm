inherited RollaBlindColourDataGUI: TRollaBlindColourDataGUI
  Left = 247
  Top = 182
  Caption = 'Colour Data'
  ClientHeight = 443
  ClientWidth = 488
  PixelsPerInch = 96
  TextHeight = 15
  inherited DNMPanel1: TDNMPanel
    Width = 488
    Height = 443
    inherited Bevel1: TBevel
      Width = 460
      Height = 317
    end
    object Bevel2: TBevel [1]
      Left = 32
      Top = 104
      Width = 249
      Height = 265
      Shape = bsFrame
    end
    object Bevel3: TBevel [2]
      Left = 296
      Top = 104
      Width = 161
      Height = 265
      Shape = bsFrame
    end
    object Label3: TLabel [3]
      Left = 32
      Top = 88
      Width = 36
      Height = 15
      Caption = 'Select'
      Transparent = True
    end
    object Label4: TLabel [4]
      Left = 296
      Top = 88
      Width = 21
      Height = 15
      Caption = 'Edit'
      Transparent = True
    end
    object Label1: TLabel [5]
      Left = 48
      Top = 120
      Width = 67
      Height = 15
      Caption = 'Profile Type'
      Transparent = True
    end
    object Label2: TLabel [6]
      Left = 184
      Top = 120
      Width = 69
      Height = 15
      Caption = 'Colour Code'
      Transparent = True
    end
    object Label5: TLabel [7]
      Left = 312
      Top = 120
      Width = 67
      Height = 15
      Caption = 'Profile Type'
      Transparent = True
    end
    object Label6: TLabel [8]
      Left = 312
      Top = 200
      Width = 69
      Height = 15
      Caption = 'Colour Code'
      Transparent = True
    end
    inherited pnlTitle: TDNMPanel
      Left = 128
      Width = 225
      TabOrder = 8
    end
    inherited btnSave: TDNMSpeedButton
      Left = 95
      Top = 402
      TabOrder = 5
    end
    inherited btnCancel: TDNMSpeedButton
      Left = 297
      Top = 402
      TabOrder = 7
    end
    inherited btnNew: TDNMSpeedButton
      Left = 196
      Top = 402
      TabOrder = 6
    end
    object grpStandard: TwwRadioGroup
      Left = 312
      Top = 280
      Width = 129
      Height = 73
      TransparentActiveItem = True
      ShowGroupCaption = False
      Transparent = True
      Caption = 'Standard'
      DataField = 'Standard'
      DataSource = dsMain
      Items.Strings = (
        ' Standard'
        ' Reverse')
      TabOrder = 4
      Values.Strings = (
        'T'
        'F')
    end
    object lstProfileType: TDBLookupListBox
      Left = 48
      Top = 136
      Width = 121
      Height = 214
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyField = 'ProfileType'
      ListField = 'ProfileType'
      ListSource = dsProfileType
      ParentFont = False
      TabOrder = 0
      OnClick = lstProfileTypeClick
    end
    object lstColourCode: TDBLookupListBox
      Left = 184
      Top = 136
      Width = 81
      Height = 214
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyField = 'ColourCode'
      ListField = 'ColourCode'
      ListSource = dsProfileColours
      ParentFont = False
      TabOrder = 1
      OnClick = lstColourCodeClick
    end
    object cboProfileType: TwwDBLookupCombo
      Left = 312
      Top = 136
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
      TabOrder = 2
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
    object cboColourCode: TwwDBLookupCombo
      Left = 312
      Top = 216
      Width = 129
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      DataField = 'ColourCode'
      DataSource = dsMain
      LookupTable = qryColourCode
      LookupField = 'ColourCode'
      Style = csDropDownList
      ParentFont = False
      TabOrder = 3
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      'SELECT * FROM tblrollaprofilecolours')
  end
  object qryProfileType: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblrollaprofiletypes')
    Left = 72
    Top = 40
    object qryProfileTypeProfileType: TStringField
      FieldName = 'ProfileType'
      Size = 50
    end
  end
  object qryProfileColours: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * '
      'FROM tblrollaprofilecolours'
      'GROUP BY ColourCode'
      '')
    Left = 104
    Top = 40
    object qryProfileColoursColourCode: TStringField
      FieldName = 'ColourCode'
      Size = 50
    end
  end
  object dsProfileType: TDataSource
    DataSet = qryProfileType
    Left = 392
    Top = 24
  end
  object dsProfileColours: TDataSource
    DataSet = qryProfileColours
    Left = 424
    Top = 24
  end
  object qryColourCode: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * '
      'FROM tblrollacolourcodes'
      'WHERE HeavyDuty = '#39'F'#39
      '')
    Left = 360
    Top = 24
    object StringField1: TStringField
      FieldName = 'ColourCode'
      Size = 50
    end
  end
end
