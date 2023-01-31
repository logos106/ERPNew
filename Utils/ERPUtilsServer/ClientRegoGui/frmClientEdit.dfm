inherited fmClientEdit: TfmClientEdit
  Left = 354
  Top = 398
  Caption = 'Client'
  ClientHeight = 459
  ClientWidth = 706
  ExplicitWidth = 722
  ExplicitHeight = 497
  PixelsPerInch = 96
  TextHeight = 15
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 172
    Width = 706
    Height = 5
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 622
  end
  object Splitter2: TSplitter [1]
    Left = 0
    Top = 283
    Width = 706
    Height = 4
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 622
  end
  inherited pnlBottom: TPanel
    Top = 418
    Width = 706
    ExplicitTop = 418
    ExplicitWidth = 706
    inherited btnOk: TButton
      Left = 16
      Top = 6
      ExplicitLeft = 16
      ExplicitTop = 6
    end
  end
  object pnlClient: TPanel [3]
    Left = 0
    Top = 0
    Width = 706
    Height = 66
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 13
      Width = 32
      Height = 15
      Caption = 'Client'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 462
      Top = 13
      Width = 75
      Height = 15
      Caption = 'Release Type'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtName: TDBEdit
      Left = 57
      Top = 10
      Width = 369
      Height = 23
      DataField = 'name'
      DataSource = dsClient
      TabOrder = 0
    end
    object chkActive: TwwCheckBox
      Left = 625
      Top = 40
      Width = 65
      Height = 18
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Caption = 'Active'
      DataField = 'active'
      DataSource = dsClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object cboReleaseType: TwwDBComboBox
      Left = 554
      Top = 9
      Width = 139
      Height = 23
      ShowButton = True
      Style = csDropDownList
      MapList = True
      AllowClearKey = False
      DataField = 'softwarereleasetype'
      DataSource = dsClient
      DropDownCount = 8
      ItemHeight = 0
      Items.Strings = (
        'Production'#9'Production'
        'Production10'#9'Production10'
        'Production11'#9'Production11'
        'Production12'#9'Production12'
        'Production14'#9'Production14'
        'Production15'#9'Production15'
        'Beta'#9'Beta'
        'Alpha'#9'Alpha'
        'Dev'#9'Dev'
        'Test'#9'Test')
      Sorted = False
      TabOrder = 2
      UnboundDataType = wwDefault
    end
  end
  object pnlServer: TPanel [4]
    Left = 0
    Top = 66
    Width = 706
    Height = 106
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object grdServers: TwwDBGrid
      Left = 0
      Top = 23
      Width = 706
      Height = 83
      ControlType.Strings = (
        'active;CheckBox;T;F')
      Selected.Strings = (
        'active'#9'1'#9'Active'#9'F'#9
        'computername'#9'20'#9'Computer Name'#9#9
        'notes'#9'10'#9'Notes'#9#9
        'datetime'#9'18'#9'Date Time'#9#9
        'user'#9'10'#9'User'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      OnRowChanged = grdServersRowChanged
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsServers
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      UseTFields = False
      object grdServersIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 25
        Height = 25
        AllowAllUp = True
        Glyph.Data = {
          26040000424D2604000000000000360000002800000012000000120000000100
          180000000000F0030000120B0000120B00000000000000000000FFFFFFFFFFFF
          636393525293FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF555591616191FFFFFFFFFFFF0000FDFDFD6060820000D20000DA3F3F
          7DF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F741417D0000CC00
          00CE5B5B80FBFBFB00009292A40000A40000C80000F60000BA30307BE7E7E7FF
          FFFFFFFFFFFFFFFFFFFFFFE7E7E734347C0000B20000FC0000D40000A28D8DA1
          000062628D0000BE0000D80000F80000F80000BA1F1F79DBDBDBFFFFFFFFFFFF
          D9D9D91C1C790000B00000FF1717FF0000F40000CA5C5C8900007979A90000CC
          0000D20000D60000F80000F40000B0131375DFDFDFDEDEDE1212750000B00000
          FA0F0FFF0000EA0000E40000E47373AB0000EAEAEC3F3FB30000CC0000D20000
          D80000F20000EE0000A812126B11116B0000A80000F60303FF0000E80000E200
          00DE3F3FBDEAEAEC0000FFFFFFFFFFFF4949B30000CC0000CE0000CC0000E400
          00DC00008A00008A0000DE0000EE0000E00000DE0000DC5252B6FFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFF6464AF0000D00000E00000E20000F60000D60000D6
          0000F40000DC0000D40000D26A6AB4FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFF8888BB0101F60303FF0000F80000FC0000FC0000FC0505FF0303
          E89696BEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFABAB
          AB0202910000E40000FC0000F80000F80000FC0000E2050592C7C7C7FFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF94949C00005800007C0000D607
          07FF0000FC0000FC0707FF0000CC00007600004EAEAEB2FFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFF8E8E960000540000840000E00F0FFF0303FF1111FF0F0FFF
          0303FF0F0FFF0000D600007C00004CB1B1B3FFFFFFFFFFFF0000FFFFFF93939B
          00004E00007C0000EA1F1FFF1111FF1F1FFF0505EC0000F21F1FFF0F0FFF1F1F
          FF0000DC000078000044B3B3B7FFFFFF0000E0E0E100004400007E0000EC2D2D
          FF1919FF2F2FFF0101FCD8D8DDC5C5CF0B0BFF2D2DFF1919FF2929FF0000E000
          007A151547FBFBFB0000C7C7C80000820000F63535FF2525FF3D3DFF0202FFCA
          CAD3FFFFFFFFFFFFACACC11515FF3939FF2525FF3535FF0000EA00006EEAEAEA
          0000E0E0E20000EA5757FF2F2FFF4949FF0707FFCACAD3FFFFFFFFFFFFFFFFFF
          FFFFFFA6A6BF1B1BFF4343FF3333FF5151FF1414D9F7F7F70000FFFFFFB6B6CD
          1B1BFF6565FF1212FFC9C9D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFACAC
          C22929FF6565FF1616FAD3D3DCFFFFFF0000FFFFFFFFFFFFAFAFC43333E6CCCC
          D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9898BE3737E4E0
          E0E3FFFFFFFFFFFF0000}
        OnClick = grdServersIButtonClick
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 706
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label2: TLabel
        Left = 7
        Top = 3
        Width = 45
        Height = 15
        Caption = 'Servers'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object pnlLicence: TPanel [5]
    Left = 0
    Top = 177
    Width = 706
    Height = 106
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object grdLicence: TwwDBGrid
      Left = 0
      Top = 23
      Width = 706
      Height = 83
      ControlType.Strings = (
        'active;CheckBox;T;F')
      Selected.Strings = (
        'active'#9'1'#9'Active'#9#9
        'softwarename'#9'15'#9'Software'#9#9
        'startdate'#9'18'#9'Start Date'#9#9
        'expiredate'#9'18'#9'Expire Date'#9#9
        'concurrentusers'#9'10'#9'Users'#9#9
        'status'#9'15'#9'Status'#9#9
        'statusreason'#9'15'#9'Status Reason'#9#9
        'datatext'#9'10'#9'Data Text'#9#9
        'notes'#9'10'#9'Notes'#9#9
        'datetime'#9'18'#9'Date Time'#9#9
        'user'#9'10'#9'User'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsLicence
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      UseTFields = False
      OnDblClick = grdLicenceDblClick
      object grdLicenceIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 25
        Height = 25
        AllowAllUp = True
        Glyph.Data = {
          26040000424D2604000000000000360000002800000012000000120000000100
          180000000000F0030000120B0000120B00000000000000000000FFFFFFFFFFFF
          636393525293FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF555591616191FFFFFFFFFFFF0000FDFDFD6060820000D20000DA3F3F
          7DF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F741417D0000CC00
          00CE5B5B80FBFBFB00009292A40000A40000C80000F60000BA30307BE7E7E7FF
          FFFFFFFFFFFFFFFFFFFFFFE7E7E734347C0000B20000FC0000D40000A28D8DA1
          000062628D0000BE0000D80000F80000F80000BA1F1F79DBDBDBFFFFFFFFFFFF
          D9D9D91C1C790000B00000FF1717FF0000F40000CA5C5C8900007979A90000CC
          0000D20000D60000F80000F40000B0131375DFDFDFDEDEDE1212750000B00000
          FA0F0FFF0000EA0000E40000E47373AB0000EAEAEC3F3FB30000CC0000D20000
          D80000F20000EE0000A812126B11116B0000A80000F60303FF0000E80000E200
          00DE3F3FBDEAEAEC0000FFFFFFFFFFFF4949B30000CC0000CE0000CC0000E400
          00DC00008A00008A0000DE0000EE0000E00000DE0000DC5252B6FFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFF6464AF0000D00000E00000E20000F60000D60000D6
          0000F40000DC0000D40000D26A6AB4FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFF8888BB0101F60303FF0000F80000FC0000FC0000FC0505FF0303
          E89696BEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFABAB
          AB0202910000E40000FC0000F80000F80000FC0000E2050592C7C7C7FFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF94949C00005800007C0000D607
          07FF0000FC0000FC0707FF0000CC00007600004EAEAEB2FFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFF8E8E960000540000840000E00F0FFF0303FF1111FF0F0FFF
          0303FF0F0FFF0000D600007C00004CB1B1B3FFFFFFFFFFFF0000FFFFFF93939B
          00004E00007C0000EA1F1FFF1111FF1F1FFF0505EC0000F21F1FFF0F0FFF1F1F
          FF0000DC000078000044B3B3B7FFFFFF0000E0E0E100004400007E0000EC2D2D
          FF1919FF2F2FFF0101FCD8D8DDC5C5CF0B0BFF2D2DFF1919FF2929FF0000E000
          007A151547FBFBFB0000C7C7C80000820000F63535FF2525FF3D3DFF0202FFCA
          CAD3FFFFFFFFFFFFACACC11515FF3939FF2525FF3535FF0000EA00006EEAEAEA
          0000E0E0E20000EA5757FF2F2FFF4949FF0707FFCACAD3FFFFFFFFFFFFFFFFFF
          FFFFFFA6A6BF1B1BFF4343FF3333FF5151FF1414D9F7F7F70000FFFFFFB6B6CD
          1B1BFF6565FF1212FFC9C9D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFACAC
          C22929FF6565FF1616FAD3D3DCFFFFFF0000FFFFFFFFFFFFAFAFC43333E6CCCC
          D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9898BE3737E4E0
          E0E3FFFFFFFFFFFF0000}
        OnClick = grdLicenceIButtonClick
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 706
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label3: TLabel
        Left = 7
        Top = 3
        Width = 45
        Height = 15
        Caption = 'Licence'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object pnlConfig: TPanel [6]
    Left = 0
    Top = 287
    Width = 706
    Height = 131
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 706
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label4: TLabel
        Left = 7
        Top = 3
        Width = 36
        Height = 15
        Caption = 'Config'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object grdConfig: TwwDBGrid
      Left = 0
      Top = 23
      Width = 706
      Height = 108
      ControlType.Strings = (
        'active;CheckBox;T;F'
        'notes;CustomEdit;edtConfigNotes;F')
      Selected.Strings = (
        'id'#9'10'#9'Id'#9'F'
        'active'#9'1'#9'Active'#9'F'
        'text'#9'10'#9'Config'#9'F'
        'notes'#9'20'#9'Notes'#9'F'
        'datetime'#9'18'#9'Date Time'#9'F'
        'user'#9'10'#9'User'#9'F')
      MemoAttributes = [mSizeable, mWordWrap, mGridShow]
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsConfig
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TitleAlignment = taLeftJustify
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      UseTFields = False
      object grdConfigIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 25
        Height = 25
        AllowAllUp = True
        Glyph.Data = {
          26040000424D2604000000000000360000002800000012000000120000000100
          180000000000F0030000120B0000120B00000000000000000000FFFFFFFFFFFF
          636393525293FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF555591616191FFFFFFFFFFFF0000FDFDFD6060820000D20000DA3F3F
          7DF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F741417D0000CC00
          00CE5B5B80FBFBFB00009292A40000A40000C80000F60000BA30307BE7E7E7FF
          FFFFFFFFFFFFFFFFFFFFFFE7E7E734347C0000B20000FC0000D40000A28D8DA1
          000062628D0000BE0000D80000F80000F80000BA1F1F79DBDBDBFFFFFFFFFFFF
          D9D9D91C1C790000B00000FF1717FF0000F40000CA5C5C8900007979A90000CC
          0000D20000D60000F80000F40000B0131375DFDFDFDEDEDE1212750000B00000
          FA0F0FFF0000EA0000E40000E47373AB0000EAEAEC3F3FB30000CC0000D20000
          D80000F20000EE0000A812126B11116B0000A80000F60303FF0000E80000E200
          00DE3F3FBDEAEAEC0000FFFFFFFFFFFF4949B30000CC0000CE0000CC0000E400
          00DC00008A00008A0000DE0000EE0000E00000DE0000DC5252B6FFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFF6464AF0000D00000E00000E20000F60000D60000D6
          0000F40000DC0000D40000D26A6AB4FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFF8888BB0101F60303FF0000F80000FC0000FC0000FC0505FF0303
          E89696BEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFABAB
          AB0202910000E40000FC0000F80000F80000FC0000E2050592C7C7C7FFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF94949C00005800007C0000D607
          07FF0000FC0000FC0707FF0000CC00007600004EAEAEB2FFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFF8E8E960000540000840000E00F0FFF0303FF1111FF0F0FFF
          0303FF0F0FFF0000D600007C00004CB1B1B3FFFFFFFFFFFF0000FFFFFF93939B
          00004E00007C0000EA1F1FFF1111FF1F1FFF0505EC0000F21F1FFF0F0FFF1F1F
          FF0000DC000078000044B3B3B7FFFFFF0000E0E0E100004400007E0000EC2D2D
          FF1919FF2F2FFF0101FCD8D8DDC5C5CF0B0BFF2D2DFF1919FF2929FF0000E000
          007A151547FBFBFB0000C7C7C80000820000F63535FF2525FF3D3DFF0202FFCA
          CAD3FFFFFFFFFFFFACACC11515FF3939FF2525FF3535FF0000EA00006EEAEAEA
          0000E0E0E20000EA5757FF2F2FFF4949FF0707FFCACAD3FFFFFFFFFFFFFFFFFF
          FFFFFFA6A6BF1B1BFF4343FF3333FF5151FF1414D9F7F7F70000FFFFFFB6B6CD
          1B1BFF6565FF1212FFC9C9D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFACAC
          C22929FF6565FF1616FAD3D3DCFFFFFF0000FFFFFFFFFFFFAFAFC43333E6CCCC
          D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9898BE3737E4E0
          E0E3FFFFFFFFFFFF0000}
        OnClick = grdConfigIButtonClick
      end
    end
    object edtConfigNotes: TwwDBEdit
      Left = 222
      Top = 102
      Width = 139
      Height = 23
      ShowVertScrollBar = True
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = True
      WordWrap = True
    end
  end
  inherited alMain: TActionList
    Left = 168
    inherited actOk: TAction
      OnExecute = actOkExecute
    end
    inherited actCancel: TAction
      OnExecute = actCancelExecute
    end
  end
  inherited TransConnection: TMyConnection
    Left = 208
  end
  object qryClient: TMyQuery
    Connection = TransConnection
    SQL.Strings = (
      'select * from tclientconfig where id = :KeyID')
    BeforePost = qryClientBeforePost
    Left = 336
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
  end
  object dsClient: TDataSource
    DataSet = qryClient
    Left = 360
    Top = 16
  end
  object qryServers: TMyQuery
    Connection = TransConnection
    SQL.Strings = (
      'select * from tcomputer where clientid = :ClientID order by id')
    Left = 336
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ClientID'
      end>
  end
  object dsServers: TDataSource
    DataSet = qryServers
    Left = 360
    Top = 96
  end
  object dsLicence: TDataSource
    DataSet = qryLicence
    Left = 336
    Top = 208
  end
  object qryLicence: TMyQuery
    Connection = TransConnection
    SQL.Strings = (
      
        'select * from tsoftwarelicence where computerid = :ComputerID or' +
        'der by active, id')
    Left = 312
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ComputerID'
      end>
  end
  object qryConfig: TMyQuery
    Connection = TransConnection
    SQL.Strings = (
      
        'select * from tcomputerconfig where computerid = :ComputerID ord' +
        'er by id')
    Left = 296
    Top = 312
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ComputerID'
      end>
  end
  object dsConfig: TDataSource
    DataSet = qryConfig
    Left = 320
    Top = 320
  end
end
