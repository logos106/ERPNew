inherited frUtilsServerConfig: TfrUtilsServerConfig
  Height = 465
  ExplicitHeight = 465
  DesignSize = (
    675
    465)
  object Bevel1: TBevel
    Left = 3
    Top = 3
    Width = 669
    Height = 459
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
    ExplicitHeight = 279
  end
  object Label9: TLabel
    Left = 14
    Top = 14
    Width = 109
    Height = 15
    HelpContext = 504027
    Caption = 'ERP Utilities Server'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    Transparent = True
  end
  object lblServerVersion: TLabel
    Left = 140
    Top = 16
    Width = 83
    Height = 15
    Caption = 'Not Connected'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblSiteIntegrationVersion: TLabel
    Left = 14
    Top = 48
    Width = 116
    Height = 15
    Caption = 'Installed Module List'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 14
    Top = 225
    Width = 110
    Height = 15
    Caption = 'Update Check Time'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 14
    Top = 254
    Width = 121
    Height = 15
    Caption = 'Current Server Tasks'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
  end
  object lvModules: TListView
    Left = 14
    Top = 69
    Width = 643
    Height = 142
    Anchors = [akLeft, akTop, akRight]
    Columns = <
      item
        Caption = 'Module Name'
        Width = 140
      end
      item
        Caption = 'Version'
        Width = 75
      end
      item
        Caption = 'Description'
        Width = 390
      end>
    TabOrder = 0
    ViewStyle = vsReport
  end
  object dtUpdateCheckTime: TDateTimePicker
    Left = 140
    Top = 222
    Width = 149
    Height = 23
    Date = 41451.622766168980000000
    Time = 41451.622766168980000000
    Color = clBtnFace
    Kind = dtkTime
    ParentColor = True
    TabOrder = 1
    OnExit = dtUpdateCheckTimeExit
  end
  object rgLoggingLevel: TwwRadioGroup
    Left = 312
    Top = 219
    Width = 345
    Height = 50
    DisableThemes = False
    Caption = 'Logging Level'
    Columns = 4
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Items.Strings = (
      'Error'
      'Warning'
      'Info'
      'Detail')
    ParentFont = False
    TabOrder = 2
    OnClick = rgLoggingLevelClick
  end
  object btnShowLog: TDNMSpeedButton
    Left = 383
    Top = 36
    Width = 87
    Height = 27
    Anchors = [akTop, akRight]
    Caption = 'Log'
    DisableTransparent = False
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Style = bsModern
    TabOrder = 3
    AutoDisableParentOnclick = True
    OnClick = btnShowLogClick
  end
  object btnCommsTest: TDNMSpeedButton
    Left = 569
    Top = 36
    Width = 87
    Height = 27
    Anchors = [akTop, akRight]
    Caption = 'Comms Test'
    DisableTransparent = False
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Style = bsModern
    TabOrder = 4
    AutoDisableParentOnclick = True
    OnClick = btnCommsTestClick
  end
  object btnLogFile: TDNMSpeedButton
    Left = 476
    Top = 36
    Width = 87
    Height = 27
    Anchors = [akTop, akRight]
    Caption = 'Log File'
    DisableTransparent = False
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Style = bsModern
    TabOrder = 5
    AutoDisableParentOnclick = True
    OnClick = btnLogFileClick
  end
  object grdTaskList: TwwDBGrid
    Left = 14
    Top = 275
    Width = 642
    Height = 174
    Selected.Strings = (
      'ModuleName'#9'15'#9'Module'#9#9
      'TaskName'#9'20'#9'Task Name'#9#9
      'StatusMessage'#9'34'#9'Details'#9'F'
      'StartTime'#9'18'#9'Start Time'#9#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight]
    Color = clWhite
    DataSource = dsTaskList
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    FooterCellColor = clWhite
  end
  object tmrServerTasks: TTimer
    Interval = 5000
    OnTimer = tmrServerTasksTimer
    Left = 368
    Top = 360
  end
  object qryTaskList: TERPQuery
    Connection = conTaskList
    SQL.Strings = (
      'select * from tblserverthreadtask where complete = "F"')
    Left = 472
    Top = 312
    object qryTaskListModuleName: TWideStringField
      DisplayLabel = 'Module'
      DisplayWidth = 15
      FieldName = 'ModuleName'
      Origin = 'tblserverthreadtask.ModuleName'
      Size = 255
    end
    object qryTaskListTaskName: TWideStringField
      DisplayLabel = 'Task Name'
      DisplayWidth = 20
      FieldName = 'TaskName'
      Origin = 'tblserverthreadtask.TaskName'
      Size = 255
    end
    object qryTaskListStatusMessage: TWideStringField
      DisplayLabel = 'Details'
      DisplayWidth = 34
      FieldName = 'StatusMessage'
      Origin = 'tblserverthreadtask.StatusMessage'
      Size = 255
    end
    object qryTaskListStartTime: TDateTimeField
      DisplayLabel = 'Start Time'
      DisplayWidth = 18
      FieldName = 'StartTime'
      Origin = 'tblserverthreadtask.StartTime'
    end
    object qryTaskListID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblserverthreadtask.ID'
      Visible = False
    end
    object qryTaskListTaskId: TWideStringField
      DisplayWidth = 255
      FieldName = 'TaskId'
      Origin = 'tblserverthreadtask.TaskId'
      Visible = False
      Size = 255
    end
    object qryTaskListComplete: TWideStringField
      DisplayWidth = 1
      FieldName = 'Complete'
      Origin = 'tblserverthreadtask.Complete'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object conTaskList: TERPConnection
    Database = 'services'
    Port = 3309
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Server = 'localhost'
    LoginPrompt = False
    Left = 384
    Top = 304
  end
  object dsTaskList: TDataSource
    DataSet = qryTaskList
    Left = 528
    Top = 320
  end
end
