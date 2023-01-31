object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'DB Compare'
  ClientHeight = 578
  ClientWidth = 1012
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1012
    Height = 129
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 13
      Width = 77
      Height = 15
      Caption = 'Source Server'
    end
    object Label3: TLabel
      Left = 184
      Top = 13
      Width = 64
      Height = 15
      Caption = 'Dest Server'
    end
    object Label2: TLabel
      Left = 8
      Top = 69
      Width = 96
      Height = 15
      Caption = 'Source Database'
    end
    object Label4: TLabel
      Left = 184
      Top = 69
      Width = 83
      Height = 15
      Caption = 'Dest Database'
    end
    object edtSourceServer: TEdit
      Left = 8
      Top = 32
      Width = 153
      Height = 23
      TabOrder = 0
      Text = 'localhost'
      OnChange = edtSourceServerChange
    end
    object edtDestServer: TEdit
      Left = 184
      Top = 32
      Width = 153
      Height = 23
      TabOrder = 1
      Text = 'localhost'
      OnChange = edtDestServerChange
    end
    object edtSourceDatabase: TEdit
      Left = 8
      Top = 88
      Width = 153
      Height = 23
      TabOrder = 2
      Text = 'int_source'
      OnChange = edtSourceDatabaseChange
    end
    object edtDestDatabase: TEdit
      Left = 184
      Top = 88
      Width = 153
      Height = 23
      TabOrder = 3
      Text = 'int_destination'
      OnChange = edtDestDatabaseChange
    end
    object btnCompare: TButton
      Left = 360
      Top = 30
      Width = 75
      Height = 25
      Caption = 'Compare'
      TabOrder = 4
      OnClick = btnCompareClick
    end
  end
  object grdMain: TwwDBGrid
    Left = 0
    Top = 129
    Width = 1012
    Height = 430
    Selected.Strings = (
      'id'#9'8'#9'Id'
      'TableName'#9'15'#9'Table Name'
      'FieldName'#9'15'#9'Field Name'
      'GlobalRef'#9'10'#9'Global Ref'
      'SourceMsTimeStamp'#9'18'#9'Sourcc Time'
      'DestMsTimeStamp'#9'18'#9'Dest Time'
      'SourceValue'#9'25'#9'Source Value'
      'DestValue'#9'25'#9'Dest Value'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = dsMain
    TabOrder = 1
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 559
    Width = 1012
    Height = 19
    Panels = <
      item
        Text = 'Status'
        Width = 500
      end>
  end
  object SourceConn: TMyConnection
    Port = 3309
    Username = 'P_One'
    Password = '1w$p&LD07'
    Server = 'localhost'
    LoginPrompt = False
    Left = 448
    Top = 72
  end
  object DestConn: TMyConnection
    Port = 3309
    Username = 'P_One'
    Password = '1w$p&LD07'
    Server = 'localhost'
    LoginPrompt = False
    Left = 504
    Top = 72
  end
  object serviceConn: TMyConnection
    Database = 'services'
    Port = 3309
    Username = 'P_One'
    Password = '1w$p&LD07'
    Server = 'localhost'
    Connected = True
    LoginPrompt = False
    Left = 448
    Top = 24
  end
  object qryMain: TMyQuery
    Connection = serviceConn
    SQL.Strings = (
      'select * from tblDatabaseCompare'
      'order by SourceMSTimeStamp desc, TableName')
    Left = 384
    Top = 160
    object qryMainid: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'Id'
      DisplayWidth = 8
      FieldName = 'id'
      Origin = 'tbldatabasecompare.id'
    end
    object qryMainTableName: TStringField
      DisplayLabel = 'Table Name'
      DisplayWidth = 15
      FieldName = 'TableName'
      Origin = 'tbldatabasecompare.TableName'
      Size = 255
    end
    object qryMainFieldName: TStringField
      DisplayLabel = 'Field Name'
      DisplayWidth = 15
      FieldName = 'FieldName'
      Origin = 'tbldatabasecompare.FieldName'
      Size = 255
    end
    object qryMainGlobalRef: TStringField
      DisplayLabel = 'Global Ref'
      DisplayWidth = 10
      FieldName = 'GlobalRef'
      Origin = 'tbldatabasecompare.GlobalRef'
      Size = 255
    end
    object qryMainSourceMsTimeStamp: TDateTimeField
      DisplayLabel = 'Sourcc Time'
      DisplayWidth = 18
      FieldName = 'SourceMsTimeStamp'
      Origin = 'tbldatabasecompare.SourceMsTimeStamp'
    end
    object qryMainDestMsTimeStamp: TDateTimeField
      DisplayLabel = 'Dest Time'
      DisplayWidth = 18
      FieldName = 'DestMsTimeStamp'
      Origin = 'tbldatabasecompare.DestMsTimeStamp'
    end
    object qryMainSourceValue: TStringField
      DisplayLabel = 'Source Value'
      DisplayWidth = 25
      FieldName = 'SourceValue'
      Origin = 'tbldatabasecompare.SourceValue'
      Size = 255
    end
    object qryMainDestValue: TStringField
      DisplayLabel = 'Dest Value'
      DisplayWidth = 25
      FieldName = 'DestValue'
      Origin = 'tbldatabasecompare.DestValue'
      Size = 255
    end
  end
  object dsMain: TDataSource
    DataSet = qryMain
    Left = 400
    Top = 216
  end
end
