inherited EmailedReportScheduleGUI: TEmailedReportScheduleGUI
  Left = 342
  Top = 117
  ActiveControl = NextSendDate
  Caption = 'Emailed Report Schedule'
  ClientHeight = 513
  ClientWidth = 588
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel2: TBevel [0]
    Left = 10
    Top = 199
    Width = 564
    Height = 271
    Shape = bsFrame
  end
  object Bevel3: TBevel [1]
    Left = 325
    Top = 206
    Width = 237
    Height = 114
  end
  object Bevel1: TBevel [2]
    Left = 75
    Top = 108
    Width = 449
    Height = 79
    Shape = bsFrame
  end
  object lblStartDate: TLabel [3]
    Left = 252
    Top = 128
    Width = 57
    Height = 15
    Caption = 'Start Date'
    Transparent = True
  end
  object lblMode: TLabel [4]
    Left = 95
    Top = 128
    Width = 31
    Height = 15
    Caption = 'Mode'
    Transparent = True
  end
  object lblTime: TLabel [5]
    Left = 395
    Top = 128
    Width = 28
    Height = 15
    Caption = 'Time'
    Transparent = True
  end
  object Label3: TLabel [6]
    Left = 98
    Top = 77
    Width = 33
    Height = 15
    Caption = 'Name'
    Transparent = True
  end
  inherited imgGridWatermark: TImage
    Left = -15
    Top = 2
  end
  object Label1: TLabel [8]
    Left = 333
    Top = 207
    Width = 224
    Height = 15
    Caption = 'Date Ranges with Respect to Send Date'
    Transparent = True
  end
  object Label2: TLabel [9]
    Left = 377
    Top = 267
    Width = 58
    Height = 15
    Caption = 'From Date'
    Transparent = True
  end
  object Label4: TLabel [10]
    Left = 467
    Top = 268
    Width = 43
    Height = 15
    Caption = 'To Date'
    Transparent = True
  end
  object Label20: TLabel [11]
    Left = 27
    Top = 217
    Width = 65
    Height = 18
    AutoSize = False
    Caption = 'Template :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label5: TLabel [12]
    Left = 27
    Top = 270
    Width = 87
    Height = 15
    Caption = 'Next Send Date'
    Transparent = True
  end
  object Label6: TLabel [13]
    Left = 27
    Top = 330
    Width = 56
    Height = 15
    Caption = 'Add Email'
    Transparent = True
  end
  object Label36: TLabel [14]
    Left = 544
    Top = 470
    Width = 37
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = 'Active'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label7: TLabel [15]
    Left = 27
    Top = 384
    Width = 112
    Height = 17
    AutoSize = False
    Caption = 'Email Sent As Bcc.'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
    WordWrap = True
  end
  object Label8: TLabel [16]
    Left = 323
    Top = 326
    Width = 55
    Height = 15
    Caption = 'Email List'
    Transparent = True
  end
  object Label9: TLabel [17]
    Left = 183
    Top = 280
    Width = 138
    Height = 30
    Alignment = taCenter
    Caption = 'Must be Tempates Type "Email Schedule"'
    Enabled = False
    Transparent = True
    WordWrap = True
  end
  object ToDate: TwwDBSpinEdit [18]
    Left = 466
    Top = 286
    Width = 50
    Height = 23
    Increment = 1
    AutoFillDate = False
    AutoSelect = False
    AutoSize = False
    DataField = 'ToDate'
    DataSource = DSEmailedReportsSchedule
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    UnboundDataType = wwDefault
    OnClick = FromDateClick
    AfterUpClick = FromDateClick
    AfterDownClick = FromDateClick
  end
  object btnCompleted: TDNMSpeedButton [19]
    Left = 124
    Top = 476
    Width = 87
    Height = 27
    Caption = '&Save'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 12
    TabStop = False
    OnClick = btnCompletedClick
  end
  object btnClose: TDNMSpeedButton [20]
    Left = 371
    Top = 477
    Width = 87
    Height = 27
    Cancel = True
    Caption = '&Cancel'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 13
    TabStop = False
    OnClick = btnCloseClick
  end
  object dpStartDate: TwwDBDateTimePicker [21]
    Left = 252
    Top = 143
    Width = 133
    Height = 23
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 2
    DisplayFormat = 'dd/mm/yyyy'
    OnChange = dpStartDateChange
  end
  object cboMode: TwwDBComboBox [22]
    Left = 94
    Top = 143
    Width = 145
    Height = 23
    ShowButton = True
    Style = csDropDownList
    MapList = False
    AllowClearKey = False
    DataField = 'Mode'
    DataSource = DSEmailedReportsSchedule
    DropDownCount = 8
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      'Once'
      'Daily'
      'Weekly'
      'Monthly')
    ParentFont = False
    Sorted = False
    TabOrder = 1
    UnboundDataType = wwDefault
  end
  object dpStartDateTime: TwwDBDateTimePicker [23]
    Left = 394
    Top = 143
    Width = 111
    Height = 23
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    Epoch = 1950
    ButtonWidth = -1
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Interval.RoundMinutes = True
    ParentFont = False
    ShowButton = True
    TabOrder = 3
    DisplayFormat = 'hh:nn am/pm'
    OnChange = dpStartDateChange
  end
  object edDescription: TwwDBEdit [24]
    Left = 135
    Top = 74
    Width = 351
    Height = 23
    DataField = 'ReportName'
    DataSource = DSEmailedReportsSchedule
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object cboTemplate: TwwDBLookupCombo [25]
    Left = 27
    Top = 233
    Width = 214
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'TemplName'#9'20'#9'TemplName'#9'T')
    DataField = 'TemplateID'
    DataSource = DSEmailedReportsSchedule
    LookupTable = qryTemplates
    LookupField = 'TemplID'
    Style = csDropDownList
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = True
    OnNotInList = cboTemplateNotInList
  end
  object FromDate: TwwDBSpinEdit [26]
    Left = 379
    Top = 286
    Width = 50
    Height = 23
    Increment = 1
    AutoFillDate = False
    AutoSelect = False
    AutoSize = False
    DataField = 'FromDate'
    DataSource = DSEmailedReportsSchedule
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    UnboundDataType = wwDefault
    OnClick = FromDateClick
    AfterUpClick = FromDateClick
    AfterDownClick = FromDateClick
  end
  object NextSendDate: TwwDBDateTimePicker [27]
    Left = 27
    Top = 285
    Width = 139
    Height = 23
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'NextSend'
    DataSource = DSEmailedReportsSchedule
    Epoch = 1950
    ButtonWidth = -1
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ShowButton = True
    TabOrder = 4
    DisplayFormat = 'dd/mm/yyyy hh:nn am/pm'
  end
  object DNMSpeedButton1: TDNMSpeedButton [28]
    Left = 281
    Top = 343
    Width = 36
    Height = 23
    Caption = '>>'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 8
    OnClick = DNMSpeedButton1Click
  end
  object DNMSpeedButton2: TDNMSpeedButton [29]
    Left = 281
    Top = 372
    Width = 36
    Height = 23
    Caption = '<<'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 9
    OnClick = DNMSpeedButton2Click
  end
  object chkActive: TwwCheckBox [30]
    Left = 555
    Top = 484
    Width = 14
    Height = 15
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbChecked
    Caption = 'chkActive'
    Checked = True
    DataField = 'Active'
    DataSource = DSEmailedReportsSchedule
    State = cbChecked
    TabOrder = 11
  end
  object wwCheckBox1: TwwCheckBox [31]
    Left = 136
    Top = 385
    Width = 16
    Height = 15
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Caption = 'chkActive'
    DataField = 'UseBcc'
    DataSource = DSEmailedReportsSchedule
    TabOrder = 10
    Visible = False
  end
  object cboEmails: TwwDBLookupCombo [32]
    Left = 27
    Top = 344
    Width = 248
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'Email'#9'30'#9'Email'#9'F'
      'EmployeeName'#9'30'#9'EmployeeName'#9'F')
    LookupTable = qryEmployeeEmail
    LookupField = 'Email'
    Style = csDropDownList
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 15
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = False
    OnNotInList = cboEmailsNotInList
  end
  object cboDateRange: TComboBox [33]
    Left = 375
    Top = 230
    Width = 146
    Height = 23
    Hint = 
      'eg '#39'This Week'#39' - The week starting on Monday that includes today' +
      '; Last Week - the last 7 days ending today; Previous Week - The ' +
      'week prior to this week'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 15
    ItemIndex = 0
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 16
    Text = 'Custom Range'
    OnChange = cboDateRangeChange
    Items.Strings = (
      'Custom Range'
      'Default Range'
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
      'This Financial Year To Date')
  end
  object EmailList: TListBox [34]
    Left = 323
    Top = 342
    Width = 237
    Height = 116
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 15
    ParentFont = False
    TabOrder = 14
  end
  object pnlTitle: TDNMPanel [35]
    Left = 91
    Top = 8
    Width = 400
    Height = 45
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 17
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 396
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
        Width = 396
        Height = 41
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Emailed Report Schedule'
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
  inherited ApplicationEvents1: TApplicationEvents
    Left = 65520
    Top = 65
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 15
    Top = 34
  end
  inherited MyConnection: TMyConnection
    Left = 552
    Top = 2
  end
  object qryEmailedReportsSchedule: TMyQuery [39]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM '
      'tblemailedreportsschedule'
      'Where EmailedReportID= :xID;')
    Left = 552
    Top = 31
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object qryEmailedReportsScheduleGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Origin = 'tblemailedreportsschedule.GlobalRef'
      Size = 255
    end
    object qryEmailedReportsScheduleEmailedReportID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'EmailedReportID'
      Origin = 'tblemailedreportsschedule.EmailedReportID'
    end
    object qryEmailedReportsScheduleReportName: TStringField
      FieldName = 'ReportName'
      Origin = 'tblemailedreportsschedule.ReportName'
      Size = 255
    end
    object qryEmailedReportsScheduleStartDate: TDateTimeField
      FieldName = 'StartDate'
      Origin = 'tblemailedreportsschedule.StartDate'
    end
    object qryEmailedReportsScheduleMode: TStringField
      FieldName = 'Mode'
      Origin = 'tblemailedreportsschedule.Mode'
      Size = 255
    end
    object qryEmailedReportsScheduleNextSend: TDateTimeField
      FieldName = 'NextSend'
      Origin = 'tblemailedreportsschedule.NextSend'
    end
    object qryEmailedReportsScheduleFromDate: TSmallintField
      FieldName = 'FromDate'
      Origin = 'tblemailedreportsschedule.FromDate'
    end
    object qryEmailedReportsScheduleToDate: TSmallintField
      FieldName = 'ToDate'
      Origin = 'tblemailedreportsschedule.ToDate'
    end
    object qryEmailedReportsScheduleUseBcc: TStringField
      FieldName = 'UseBcc'
      Origin = 'tblemailedreportsschedule.UseCc'
      FixedChar = True
      Size = 1
    end
    object qryEmailedReportsScheduleActive: TStringField
      FieldName = 'Active'
      Origin = 'tblemailedreportsschedule.Active'
      FixedChar = True
      Size = 1
    end
    object qryEmailedReportsScheduleTemplateID: TIntegerField
      FieldName = 'TemplateID'
    end
    object qryEmailedReportsScheduleEmails: TMemoField
      FieldName = 'Emails'
      BlobType = ftMemo
    end
    object qryEmailedReportsScheduleDateRangeMode: TStringField
      FieldName = 'DateRangeMode'
      Size = 255
    end
  end
  inherited DataState: TDataState
    Left = 65521
    Top = 30
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 12
    Top = 2
  end
  object DSEmailedReportsSchedule: TDataSource
    DataSet = qryEmailedReportsSchedule
    Left = 552
    Top = 60
  end
  object qryTemplates: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT TemplID,TemplName FROM `tbltemplates`  '
      'WHERE `TypeID` = 80;')
    Left = 552
    Top = 124
  end
  object qryEmployeeEmail: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT EmployeeID, Email, EmployeeName '
      'FROM tblemployees'
      'WHERE Active='#39'T'#39' AND Not IsNull(Email) AND Length(Email)>0;')
    Left = 552
    Top = 95
  end
end
