inherited User: TUser
  Left = 354
  Top = 158
  Caption = 'User'
  ClientHeight = 402
  ClientWidth = 548
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel [0]
    Left = 57
    Top = 70
    Width = 442
    Height = 118
    Shape = bsFrame
  end
  object Bevel2: TBevel [1]
    Left = 143
    Top = 207
    Width = 262
    Height = 122
    Shape = bsFrame
  end
  object Label1: TLabel [2]
    Left = 94
    Top = 81
    Width = 63
    Height = 15
    Caption = 'User Name'
    Transparent = True
  end
  object Label2: TLabel [3]
    Left = 94
    Top = 125
    Width = 27
    Height = 15
    Caption = 'Type'
    Transparent = True
  end
  object Label4: TLabel [4]
    Left = 176
    Top = 223
    Width = 67
    Height = 15
    Caption = 'Login Name'
    Transparent = True
  end
  object Label5: TLabel [5]
    Left = 176
    Top = 267
    Width = 92
    Height = 15
    Caption = 'Login Password'
    Transparent = True
  end
  inherited pnlHeader: TPanel
    Left = 111
    inherited TitleShader: TShader
      inherited TitleLabel: TLabel
        Caption = 'User'
      end
    end
  end
  inherited Cancel: TDNMSpeedButton
    Left = 424
    Top = 361
  end
  inherited Print: TDNMSpeedButton
    Left = 298
    Top = 361
    Enabled = True
    Visible = True
  end
  inherited Save: TDNMSpeedButton
    Left = 39
    Top = 361
  end
  inherited New: TDNMSpeedButton
    Left = 169
    Top = 361
    Enabled = True
    Visible = True
  end
  object UserType: TwwDBLookupCombo [11]
    Left = 94
    Top = 141
    Width = 145
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'UserType'#9'30'#9'UserType'#9'F')
    DataField = 'UserTypeID'
    DataSource = DSMaster
    LookupTable = qryUserTypes
    LookupField = 'UserTypeID'
    Style = csDropDownList
    ParentFont = False
    TabOrder = 5
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = False
  end
  object UserName: TwwDBEdit [12]
    Left = 94
    Top = 94
    Width = 362
    Height = 23
    TabStop = False
    DataField = 'UserName'
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
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
  object LoginName: TwwDBEdit [13]
    Left = 176
    Top = 238
    Width = 196
    Height = 23
    TabStop = False
    DataField = 'LoginName'
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object LoginPassword: TwwDBEdit [14]
    Left = 176
    Top = 281
    Width = 196
    Height = 23
    TabStop = False
    DataField = 'LoginPassword'
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 8
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object pnlCheckExceptionEmails: TDNMPanel [15]
    Left = 396
    Top = 4
    Width = 150
    Height = 50
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    Visible = False
    DesignSize = (
      150
      50)
    object Label29: TLabel
      Left = 9
      Top = 6
      Width = 136
      Height = 15
      Anchors = [akRight, akBottom]
      Caption = 'Check Exception Emails'
      Transparent = True
    end
    object wwCheckBox2: TwwCheckBox
      Left = 69
      Top = 24
      Width = 15
      Height = 16
      TabStop = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Anchors = [akRight, akBottom]
      Caption = 'wwCheckBox1'
      DataField = 'CheckExceptionEmails'
      DataSource = DSMaster
      TabOrder = 0
    end
  end
  inherited DBConnection: TMyConnection
    Database = ''
  end
  inherited qryMaster: TMyQuery
    SQL.Strings = (
      'select *'
      'from users'
      'where userid= :xid;')
    ParamData = <
      item
        DataType = ftString
        Name = 'xID'
        Value = ''
      end>
    object qryMasterUserID: TLargeintField
      FieldName = 'userID'
    end
    object qryMasterUserName: TStringField
      FieldName = 'UserName'
      Size = 50
    end
    object qryMasterUserTypeID: TIntegerField
      FieldName = 'UserTypeID'
    end
    object qryMasterLoginName: TStringField
      FieldName = 'LoginName'
      Size = 50
    end
    object qryMasterLoginPassword: TStringField
      FieldName = 'LoginPassword'
      Size = 50
    end
    object qryMasterCheckExceptionEmails: TStringField
      FieldName = 'CheckExceptionEmails'
      FixedChar = True
      Size = 5
    end
  end
  object qryUserTypes: TMyQuery
    Connection = DBConnection
    SQL.Strings = (
      'SELECT * FROM `usertypes` ;')
    Left = 73
    Top = 5
  end
end
