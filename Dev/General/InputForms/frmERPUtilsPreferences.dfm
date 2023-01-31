object fmERPUtilsPreferences: TfmERPUtilsPreferences
  Left = 101
  Top = 234
  Caption = 'fmERPUtilsPreferences'
  ClientHeight = 636
  ClientWidth = 765
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = [fsBold]
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    765
    636)
  PixelsPerInch = 96
  TextHeight = 15
  object pnlUtilsconf: TDNMPanel
    Left = 18
    Top = 50
    Width = 543
    Height = 447
    HelpContext = 1686003
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      543
      447)
    object Bevel1: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 529
      Height = 433
      HelpContext = 1686004
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Shape = bsFrame
      ExplicitLeft = 9
      ExplicitTop = 14
      ExplicitWidth = 537
      ExplicitHeight = 185
    end
    object lblTitle: TLabel
      Left = 14
      Top = 14
      Width = 140
      Height = 15
      HelpContext = 1686005
      Caption = 'ERP Utilies Configuration'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object wwDBGrid1: TwwDBGrid
      Left = 14
      Top = 35
      Width = 515
      Height = 398
      ControlType.Strings = (
        'EnableOnStartup;CheckBox;T;F'
        'EnableOntimer;CheckBox;T;F'
        'timerinterval;CustomEdit;cboInterval;F'
        'timerStartupDelay;CustomEdit;cboStartupdelay;F')
      Selected.Strings = (
        'Description'#9'25'#9'Task'#9'F'
        'EnableOnStartup'#9'8'#9'   Startup'#9'F'#9'Enable Check On'
        'EnableOntimer'#9'8'#9'    Timer'#9'F'#9'Enable Check On'
        'timerStartupDelay'#9'15'#9'On Startup'#9'F'#9'Interval~(In Min)'
        'timerinterval'#9'15'#9'Timer'#9'F'#9'Interval~(In Min)')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsERPUtils
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = False
      UseTFields = False
    end
    object cboInterval: TwwDBComboBox
      Left = 384
      Top = 216
      Width = 121
      Height = 23
      ShowButton = True
      Style = csDropDown
      MapList = True
      AllowClearKey = False
      DataField = 'timerinterval'
      DataSource = dsERPUtils
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        ' 1 Min'#9'1'
        ' 2 Min'#9'2'
        ' 3 Min'#9'3'
        ' 5 Min'#9'5'
        '10 Min'#9'10'
        '15 Min'#9'15'
        '20 Min'#9'20'
        '30 Min'#9'30'
        '40 Min'#9'40'
        '50 Min'#9'50'
        ' 1 Hour'#9'60'
        ' 2 Hour'#9'120'
        ' 3 Hour'#9'180'
        ' 4 Hour'#9'240'
        ' 5 Hour'#9'300'
        ' 1 Day'#9'1440'
        ' 2 Hour'#9'2880')
      ParentFont = False
      Sorted = False
      TabOrder = 2
      UnboundDataType = wwDefault
    end
    object cboStartupdelay: TwwDBComboBox
      Left = 400
      Top = 176
      Width = 121
      Height = 23
      ShowButton = True
      Style = csDropDown
      MapList = True
      AllowClearKey = False
      DataField = 'timerStartupDelay'
      DataSource = dsERPUtils
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        ' 1 Min'#9'1'
        ' 2 Min'#9'2'
        ' 3 Min'#9'3'
        ' 5 Min'#9'5'
        '10 Min'#9'10'
        '15 Min'#9'15'
        '20 Min'#9'20'
        '30 Min'#9'30'
        '40 Min'#9'40'
        '50 Min'#9'50'
        ' 1 Hour'#9'60'
        ' 2 Hour'#9'120'
        ' 3 Hour'#9'180'
        ' 4 Hour'#9'240'
        ' 5 Hour'#9'300'
        ' 1 Day'#9'1440'
        ' 2 Hour'#9'2880')
      ParentFont = False
      Sorted = False
      TabOrder = 1
      UnboundDataType = wwDefault
    end
  end
  object QryERPUtils: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'select * from tmp_1')
    Left = 281
    Top = 317
    object QryERPUtilsID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tmp_1.ID'
    end
    object QryERPUtilsDescription: TWideStringField
      FieldName = 'Description'
      Origin = 'tmp_1.Description'
      Size = 255
    end
    object QryERPUtilsEnableOnStartup: TWideStringField
      FieldName = 'EnableOnStartup'
      Origin = 'tmp_1.EnableOnStartup'
      FixedChar = True
      Size = 1
    end
    object QryERPUtilsEnableOntimer: TWideStringField
      FieldName = 'EnableOntimer'
      Origin = 'tmp_1.EnableOntimer'
      FixedChar = True
      Size = 1
    end
    object QryERPUtilstimerinterval: TIntegerField
      FieldName = 'timerinterval'
    end
    object QryERPUtilstimerStartupDelay: TIntegerField
      FieldName = 'timerStartupDelay'
    end
  end
  object dsERPUtils: TDataSource
    DataSet = QryERPUtils
    Left = 324
    Top = 317
  end
  object MyConnection1: TERPConnection
    Database = 'avalara_sample'
    Port = 3309
    Options.UseUnicode = True
    Options.KeepDesignConnected = False
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Server = 'localhost'
    Connected = True
    LoginPrompt = False
    Left = 177
    Top = 288
  end
end
