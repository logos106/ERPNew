object fmServerLogList: TfmServerLogList
  Left = 0
  Top = 0
  Caption = 'Server Log List'
  ClientHeight = 555
  ClientWidth = 986
  Color = 16770790
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 986
    Height = 105
    Align = alTop
    TabOrder = 0
    DesignSize = (
      986
      105)
    object lblFrom: TLabel
      Left = 749
      Top = 36
      Width = 29
      Height = 15
      Anchors = [akTop, akRight]
      Caption = '&From'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object lblTo: TLabel
      Left = 876
      Top = 36
      Width = 13
      Height = 15
      Anchors = [akTop, akRight]
      Caption = '&To'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object label1: TLabel
      Left = 10
      Top = 11
      Width = 88
      Height = 16
      AutoSize = False
      Caption = 'Module Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label2: TLabel
      Left = 10
      Top = 40
      Width = 88
      Height = 16
      AutoSize = False
      Caption = 'Log Type'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Panel1: TPanel
      Left = 292
      Top = 5
      Width = 402
      Height = 49
      Anchors = [akTop]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 400
        Height = 47
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        FromColor = clBtnFace
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = clBtnFace
        Steps = 10
        Direction = False
        Version = '1.4.0.0'
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 400
          Height = 47
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Server Log List'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = -3
          ExplicitWidth = 548
        end
      end
    end
    object chkIgnoreDates: TCheckBox
      Left = 715
      Top = 3
      Width = 61
      Height = 29
      HelpContext = 375047
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Caption = 'Ignore Dates'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      WordWrap = True
      OnClick = chkIgnoreDatesClick
    end
    object cboDateRange: TComboBox
      Left = 785
      Top = 4
      Width = 195
      Height = 23
      AutoDropDown = True
      Style = csDropDownList
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 15
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      TabStop = False
      Text = 'Custom'
      OnCloseUp = cboDateRangeCloseUp
      Items.Strings = (
        'Today'
        'Yesterday'
        'Last Week'
        'Last Month'
        'Last Quarter'
        'Last 12 Months'
        'Previous Week'
        'Previous Month'
        'Previous Quarter'
        'Previous Financial Year'
        'This Week'
        'This Month'
        'This Quarter'
        'This Financial Year'
        'This Financial Year To Date'
        'Custom')
    end
    object dtFrom: TwwDBDateTimePicker
      Left = 785
      Top = 32
      Width = 86
      Height = 23
      TabStop = False
      Anchors = [akTop, akRight]
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      CalendarAttributes.PopupYearOptions.NumberColumns = 6
      CalendarAttributes.PopupYearOptions.StartYear = 1980
      Date = 37432.000000000000000000
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      ShowButton = True
      TabOrder = 3
      UnboundDataType = wwDTEdtDate
      OnChange = dtFromChange
    end
    object dtTo: TwwDBDateTimePicker
      Left = 894
      Top = 32
      Width = 86
      Height = 23
      TabStop = False
      Anchors = [akTop, akRight]
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      CalendarAttributes.PopupYearOptions.NumberColumns = 6
      CalendarAttributes.PopupYearOptions.StartYear = 1980
      Date = 37432.000000000000000000
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      ShowButton = True
      TabOrder = 4
      UnboundDataType = wwDTEdtDate
      OnChange = dtToChange
    end
    object cboModule: TComboBox
      Left = 105
      Top = 8
      Width = 145
      Height = 23
      Style = csDropDownList
      TabOrder = 5
      OnChange = cboModuleChange
    end
    object cboType: TComboBox
      Left = 105
      Top = 37
      Width = 145
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 6
      Text = 'All'
      OnChange = cboTypeChange
      Items.Strings = (
        'All'
        'Warning'
        'Error')
    end
    object btnRequery: TDNMSpeedButton
      Left = 10
      Top = 74
      Width = 107
      Height = 25
      Caption = 'Refresh'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337FF3333333333330003333333333333777F333333333333080333
        3333333F33777FF33F3333B33B000B33B3333373F777773F7333333BBB0B0BBB
        33333337737F7F77F333333BBB0F0BBB33333337337373F73F3333BBB0F7F0BB
        B333337F3737F73F7F3333BB0FB7BF0BB3333F737F37F37F73FFBBBB0BF7FB0B
        BBB3773F7F37337F377333BB0FBFBF0BB333337F73F333737F3333BBB0FBF0BB
        B3333373F73FF7337333333BBB000BBB33333337FF777337F333333BBBBBBBBB
        3333333773FF3F773F3333B33BBBBB33B33333733773773373333333333B3333
        333333333337F33333333333333B333333333333333733333333}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 7
      OnClick = btnRequeryClick
    end
    object chkFollowTail: TwwCheckBox
      Left = 887
      Top = 77
      Width = 87
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Anchors = [akTop, akRight]
      Caption = 'Follow Tail'
      TabOrder = 8
      OnClick = chkFollowTailClick
    end
    object btnClearLog: TDNMSpeedButton
      Left = 785
      Top = 72
      Width = 87
      Height = 27
      Hint = 'Clear the log'
      Anchors = [akTop, akRight]
      Caption = 'Clear'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      TabStop = False
      OnClick = btnClearLogClick
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 504
    Width = 986
    Height = 51
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      986
      51)
    object cmdClose: TDNMSpeedButton
      Left = 450
      Top = 11
      Width = 87
      Height = 27
      Hint = '"Close The List"'
      Anchors = [akBottom]
      Caption = '&Close'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      OnClick = cmdCloseClick
    end
  end
  object grdMain: TwwDBGrid
    Left = 0
    Top = 105
    Width = 986
    Height = 399
    Selected.Strings = (
      'LogTime'#9'18'#9'Log Time'
      'Module'#9'15'#9'Module'
      'LogType'#9'10'#9'Log Type'
      'Log'#9'90'#9'Log'#9'F')
    MemoAttributes = [mSizeable, mWordWrap, mGridShow]
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = dsMain
    TabOrder = 2
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
  end
  object dsMain: TDataSource
    DataSet = qryMain
    Left = 46
    Top = 351
  end
  object qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'select * '
      'from tblLog '
      'where LogTime between :dtFrom and :dtTo'
      'and ((:Module = "All") or (:Module = Module)) '
      
        'and ((:LogType = "All") or (:LogType = "Error" and LogType = "lt' +
        'Error") or (:LogType = "Warning" and LogType = "ltWarning")) '
      'order by LogID DESC')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Left = 43
    Top = 384
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'dtFrom'
      end
      item
        DataType = ftUnknown
        Name = 'dtTo'
      end
      item
        DataType = ftUnknown
        Name = 'Module'
      end
      item
        DataType = ftUnknown
        Name = 'Module'
      end
      item
        DataType = ftUnknown
        Name = 'LogType'
      end
      item
        DataType = ftUnknown
        Name = 'LogType'
      end
      item
        DataType = ftUnknown
        Name = 'LogType'
      end>
    object qryMainLogTime: TDateTimeField
      DisplayLabel = 'Log Time'
      DisplayWidth = 18
      FieldName = 'LogTime'
      Origin = 'tbllog.LogTime'
    end
    object qryMainModule: TWideStringField
      DisplayWidth = 15
      FieldName = 'Module'
      Origin = 'tbllog.Module'
    end
    object qryMainLogType: TWideStringField
      DisplayLabel = 'Log Type'
      DisplayWidth = 10
      FieldName = 'LogType'
      Origin = 'tbllog.LogType'
    end
    object qryMainLog: TWideMemoField
      DisplayWidth = 90
      FieldName = 'Log'
      Origin = 'tbllog.Log'
      BlobType = ftWideMemo
    end
    object qryMainLogID: TLargeintField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'LogID'
      Origin = 'tbllog.LogID'
      Visible = False
    end
  end
  object MyConnection1: TERPConnection
    Database = 'services'
    Port = 3309
    Options.UseUnicode = True
    Options.KeepDesignConnected = False
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Connected = True
    LoginPrompt = False
    Left = 9
    Top = 384
  end
  object tmrFollowTail: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = tmrFollowTailTimer
    Left = 720
    Top = 64
  end
end
