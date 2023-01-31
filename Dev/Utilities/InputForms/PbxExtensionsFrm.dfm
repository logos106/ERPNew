inherited PbxExtensionsGUI: TPbxExtensionsGUI
  Left = 287
  Top = 132
  Caption = 'PABX Extensions'
  ClientHeight = 486
  ClientWidth = 553
  OldCreateOrder = True
  OnDblClick = FormDblClick
  PixelsPerInch = 96
  TextHeight = 15
  object lblMonitorSettings: TLabel [0]
    Left = 24
    Top = 72
    Width = 93
    Height = 15
    Caption = 'Monitor Settings'
    Transparent = True
  end
  object lblDialingSettings: TLabel [1]
    Left = 24
    Top = 256
    Width = 88
    Height = 15
    Caption = 'Dialing Settings'
    Transparent = True
  end
  object btnSave: TDNMSpeedButton [3]
    Left = 160
    Top = 448
    Width = 87
    Height = 27
    Anchors = [akBottom]
    Caption = 'Save'
    Default = True
    DisableTransparent = False
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    TabOrder = 1
    OnClick = btnSaveClick
  end
  object btnCancel: TDNMSpeedButton [4]
    Left = 296
    Top = 448
    Width = 87
    Height = 27
    Anchors = [akBottom]
    Cancel = True
    Caption = 'Cancel'
    DisableTransparent = False
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object grdExtensions: TwwDBGrid [5]
    Left = 24
    Top = 88
    Width = 505
    Height = 153
    ControlType.Strings = (
      'Active;CheckBox;T;F')
    Selected.Strings = (
      'Extension'#9'12'#9'Extension'
      'PC'#9'15'#9'PC'
      'User'#9'25'#9'User'
      'Active'#9'1'#9'Active')
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight]
    DataSource = dsExtensions
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    PaintOptions.BackgroundOptions = [coBlendFixedRow]
    object grdExtensionsIButton: TwwIButton
      Left = 0
      Top = 0
      Width = 13
      Height = 22
      AllowAllUp = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      OnClick = grdExtensionsIButtonClick
    end
  end
  object grdDialingSettings: TwwDBGrid [6]
    Left = 24
    Top = 272
    Width = 505
    Height = 161
    ControlType.Strings = (
      'DeviceName;CustomEdit;cboDeviceName;F')
    Selected.Strings = (
      'UserPCName'#9'15'#9'User PC Name'#9#9
      'DeviceName'#9'25'#9'Device Name'#9'F'#9
      'DeviceAddressID'#9'15'#9'Device Address ID'#9#9
      'Prefix'#9'10'#9'Prefix'#9'F'#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsDialingSettings
    TabOrder = 3
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    PaintOptions.BackgroundOptions = [coBlendFixedRow]
  end
  object cboDeviceName: TwwDBComboBox [7]
    Left = 168
    Top = 288
    Width = 121
    Height = 23
    ShowButton = True
    Style = csDropDownList
    MapList = False
    AllowClearKey = False
    DataField = 'DeviceName'
    DataSource = dsDialingSettings
    DropDownCount = 8
    ItemHeight = 0
    Sorted = False
    TabOrder = 4
    UnboundDataType = wwDefault
  end
  object pnlTitle: TDNMPanel [8]
    Left = 136
    Top = 10
    Width = 277
    Height = 45
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 273
      Height = 41
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      FromColor = clBtnFace
      ToColor = clWhite
      FromColorMirror = clWhite
      ToColorMirror = clBtnFace
      Steps = 10
      Direction = False
      Version = '1.2.1.1'
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 273
        Height = 41
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'PABX Extensions'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
    end
  end
  object qryExtensions: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM PbxMonitor.tblextensions')
    Left = 448
    Top = 24
    object qryExtensionsExtension: TStringField
      DisplayWidth = 12
      FieldName = 'Extension'
      Size = 255
    end
    object qryExtensionsPC: TStringField
      DisplayWidth = 15
      FieldName = 'PC'
      Size = 255
    end
    object qryExtensionsUser: TStringField
      DisplayWidth = 25
      FieldName = 'User'
      Size = 255
    end
    object qryExtensionsActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryExtensionsExtID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'ExtID'
      ReadOnly = True
      Visible = False
    end
  end
  object dsExtensions: TDataSource
    DataSet = qryExtensions
    Left = 496
    Top = 24
  end
  object qryDialingSettings: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM PbxMonitor.tblDialingSettings')
    Left = 424
    Top = 336
    object qryDialingSettingsUserPCName: TStringField
      DisplayLabel = 'User PC Name'
      DisplayWidth = 15
      FieldName = 'UserPCName'
      Origin = 'tblDialingSettings.UserPCName'
      Size = 255
    end
    object qryDialingSettingsDeviceName: TStringField
      DisplayLabel = 'Device Name'
      DisplayWidth = 25
      FieldName = 'DeviceName'
      Origin = 'tblDialingSettings.DeviceName'
      Size = 255
    end
    object qryDialingSettingsDeviceAddressID: TWordField
      DisplayLabel = 'Device Address ID'
      DisplayWidth = 15
      FieldName = 'DeviceAddressID'
      Origin = 'tblDialingSettings.DeviceAddressID'
      OnSetText = qryDialingSettingsDeviceAddressIDSetText
    end
    object qryDialingSettingsPrefix: TStringField
      DisplayWidth = 10
      FieldName = 'Prefix'
      Origin = 'tblDialingSettings.Prefix'
      Size = 255
    end
    object qryDialingSettingsDialingSettingsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'DialingSettingsID'
      Origin = 'tblDialingSettings.DialingSettingsID'
      Visible = False
    end
  end
  object dsDialingSettings: TDataSource
    DataSet = qryDialingSettings
    Left = 456
    Top = 336
  end
end
