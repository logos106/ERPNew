inherited fmClientList: TfmClientList
  Left = 199
  Top = 241
  Caption = 'Client List'
  ClientWidth = 778
  ExplicitWidth = 794
  PixelsPerInch = 96
  TextHeight = 15
  inherited pnlTop: TPanel
    Width = 778
    ExplicitWidth = 778
    object Label1: TLabel [0]
      Left = 551
      Top = 12
      Width = 85
      Height = 15
      Caption = 'Licence Status'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited btnRefresh: TButton
      Left = 3
      TabOrder = 2
      ExplicitLeft = 3
    end
    object rgClient: TRadioGroup
      Left = 88
      Top = 0
      Width = 249
      Height = 37
      Columns = 2
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ItemIndex = 0
      Items.Strings = (
        'All Clients'
        'Unknown Clients')
      ParentFont = False
      TabOrder = 0
      OnClick = rgClientClick
    end
    object rgActive: TRadioGroup
      Left = 336
      Top = 0
      Width = 209
      Height = 37
      Columns = 3
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ItemIndex = 0
      Items.Strings = (
        'Active'
        'Inactive'
        'All')
      ParentFont = False
      TabOrder = 1
      OnClick = rgActiveClick
    end
    object cboLicence: TComboBox
      Left = 642
      Top = 9
      Width = 79
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 3
      Text = 'All'
      OnChange = cboLicenceChange
      Items.Strings = (
        'All'
        'Cancelled'
        'Expired'
        'Hold'
        'Licenced'
        'Review'
        'Unknown')
    end
  end
  inherited gdMain: TwwDBGrid
    Width = 778
    ControlType.Strings = (
      'active;CheckBox;T;F')
    Selected.Strings = (
      'id'#9'5'#9'ID'#9#9
      'active'#9'1'#9'Active'#9#9
      'name'#9'30'#9'Client Name'#9'F'
      'softwarereleasetype'#9'10'#9'Release Type'#9'F'
      'datetime'#9'20'#9'Time'#9'F'#9
      'user'#9'10'#9'User'#9#9
      'servers'#9'30'#9'Servers'#9'F')
    ReadOnly = True
    UseTFields = False
    OnDblClick = gdMainDblClick
    ExplicitWidth = 778
    object btnClientDelete: TwwIButton
      Left = 0
      Top = 0
      Width = 22
      Height = 22
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
      OnClick = btnClientDeleteClick
    end
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      'select distinct tclientconfig.* from tclientconfig'
      'left join tcomputer on tcomputer.clientid = tclientconfig.id'
      
        'left join tsoftwarelicence on tsoftwarelicence.computerid = tcom' +
        'puter.id'
      
        'where ((:LicenceStatus = "lsAll") or (tsoftwarelicence.`status` ' +
        '= :LicenceStatus))')
    OnCalcFields = qryMainCalcFields
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'LicenceStatus'
      end
      item
        DataType = ftUnknown
        Name = 'LicenceStatus'
      end>
    object qryMainid: TIntegerField
      FieldName = 'id'
    end
    object qryMainactive: TStringField
      FieldName = 'active'
      FixedChar = True
      Size = 1
    end
    object qryMainname: TStringField
      FieldName = 'name'
      Size = 255
    end
    object qryMaindatetime: TDateTimeField
      FieldName = 'datetime'
    end
    object qryMainuser: TStringField
      FieldName = 'user'
      Size = 255
    end
    object qryMainsoftwarereleasetype: TStringField
      FieldName = 'softwarereleasetype'
      Size = 255
    end
    object qryMainservers: TStringField
      FieldKind = fkCalculated
      FieldName = 'servers'
      Size = 255
      Calculated = True
    end
  end
  object qryServers: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'select * from tComputer where clientid = :clientid')
    Left = 176
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'clientid'
      end>
  end
end
