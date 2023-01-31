inherited CustomFilter: TCustomFilter
  Left = 407
  Top = 205
  Caption = 'Custom Filter'
  ClientHeight = 314
  ClientWidth = 466
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel [0]
    Left = 24
    Top = 60
    Width = 64
    Height = 15
    Caption = 'Filter Name'
    Transparent = True
  end
  object Label2: TLabel [1]
    Left = 24
    Top = 118
    Width = 28
    Height = 15
    Caption = 'Filter'
    Transparent = True
  end
  object Label29: TLabel [2]
    Left = 412
    Top = 270
    Width = 40
    Height = 15
    Anchors = [akRight, akBottom]
    Caption = 'Default'
    Transparent = True
  end
  inherited Print: TDNMSpeedButton [3]
    Left = 303
    Top = 283
    Width = 11
    Height = 13
  end
  inherited New: TDNMSpeedButton [4]
    Left = 140
    Top = 279
    Width = 11
    Height = 12
  end
  inherited pnlHeader: TPanel [5]
    Left = 85
    inherited TitleShader: TShader
      inherited TitleLabel: TLabel
        Caption = 'Custom Filter'
      end
    end
  end
  inherited Cancel: TDNMSpeedButton [6]
    Left = 273
    Top = 275
  end
  inherited Save: TDNMSpeedButton [7]
    Left = 96
    Top = 276
  end
  object FilterName: TwwDBEdit [8]
    Left = 21
    Top = 76
    Width = 418
    Height = 23
    DataField = 'FilterName'
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
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
  object Filter: TDBMemo [9]
    Left = 24
    Top = 134
    Width = 417
    Height = 124
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataField = 'Filter'
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 6
  end
  object wwCheckBox2: TwwCheckBox [10]
    Left = 424
    Top = 285
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
    DataField = 'DefaultFilter'
    DataSource = DSMaster
    TabOrder = 7
  end
  inherited DSMaster: TDataSource
    Left = 70
    Top = 9
  end
  inherited DBConnection: TMyConnection
    Database = ''
    Left = 3
    Top = 5
  end
  inherited qryMaster: TMyQuery
    SQL.Strings = (
      'SELECT *'
      'FROM customfilters'
      'Where customfilterid= :xID;'
      '')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object qryMasterCustomFilterID: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'CustomFilterID'
      Origin = 'CustomFilters.CustomFilterID'
    end
    object qryMasterUserID: TIntegerField
      FieldName = 'UserID'
      Origin = 'CustomFilters.UserID'
    end
    object qryMasterFilterName: TStringField
      FieldName = 'FilterName'
      Origin = 'CustomFilters.FilterName'
      Size = 255
    end
    object qryMasterClassName: TStringField
      FieldName = 'ClassName'
      Origin = 'CustomFilters.ClassName'
      Size = 255
    end
    object qryMasterFilter: TMemoField
      FieldName = 'Filter'
      BlobType = ftMemo
    end
    object qryMasterListName: TStringField
      FieldName = 'ListName'
      Size = 255
    end
    object qryMasterDefaultFilter: TStringField
      FieldName = 'DefaultFilter'
      FixedChar = True
      Size = 5
    end
  end
end
