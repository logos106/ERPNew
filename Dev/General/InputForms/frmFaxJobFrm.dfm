inherited FaxJobGUI: TFaxJobGUI
  Left = 300
  Top = 130
  HelpContext = 131000
  ActiveControl = cboPickingPriority
  Caption = 'Fax Job'
  ClientHeight = 555
  ClientWidth = 688
  OldCreateOrder = True
  DesignSize = (
    688
    555)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel4: TBevel [0]
    Left = 12
    Top = 264
    Width = 659
    Height = 244
    HelpContext = 131002
    Shape = bsFrame
  end
  object Bevel5: TBevel [1]
    Left = 389
    Top = 408
    Width = 278
    Height = 52
    HelpContext = 131003
    Style = bsRaised
  end
  object Bevel2: TBevel [2]
    Left = 13
    Top = 125
    Width = 659
    Height = 73
    HelpContext = 131004
    Shape = bsFrame
  end
  object Bevel3: TBevel [3]
    Left = 13
    Top = 204
    Width = 659
    Height = 54
    HelpContext = 131005
    Shape = bsFrame
  end
  object Bevel1: TBevel [4]
    Left = 13
    Top = 60
    Width = 659
    Height = 60
    HelpContext = 131006
    Shape = bsFrame
  end
  object Label1: TLabel [5]
    Left = 521
    Top = 464
    Width = 56
    Height = 15
    HelpContext = 131007
    Caption = 'Cancelled'
    Transparent = True
  end
  object Label2: TLabel [6]
    Left = 594
    Top = 464
    Width = 45
    Height = 15
    HelpContext = 131008
    Caption = 'Sent Ok'
    Transparent = True
  end
  object Label3: TLabel [7]
    Left = 233
    Top = 461
    Width = 59
    Height = 15
    HelpContext = 131009
    Caption = 'Retry Wait'
    FocusControl = DBEdit3
    Transparent = True
  end
  object Label4: TLabel [8]
    Left = 233
    Top = 412
    Width = 76
    Height = 15
    HelpContext = 131010
    Caption = 'Dial Attempts'
    FocusControl = DBEdit4
    Transparent = True
  end
  object Label5: TLabel [9]
    Left = 27
    Top = 69
    Width = 108
    Height = 15
    HelpContext = 131011
    Caption = 'Faxed by Employee'
    FocusControl = DBEdit5
    Transparent = True
  end
  object Label6: TLabel [10]
    Left = 549
    Top = 16
    Width = 69
    Height = 15
    HelpContext = 131012
    Caption = 'Job Number'
    FocusControl = DBEdit6
    Transparent = True
  end
  object Label7: TLabel [11]
    Left = 377
    Top = 69
    Width = 68
    Height = 15
    HelpContext = 131013
    Caption = 'Fax Number'
    FocusControl = DBEdit7
    Transparent = True
  end
  object Label8: TLabel [12]
    Left = 521
    Top = 69
    Width = 60
    Height = 15
    HelpContext = 131014
    Caption = 'Spooled at'
    Transparent = True
  end
  object Label9: TLabel [13]
    Left = 400
    Top = 409
    Width = 106
    Height = 15
    HelpContext = 131015
    Caption = 'Current Fax Status'
    FocusControl = DBEdit9
    Transparent = True
  end
  object Label10: TLabel [14]
    Left = 168
    Top = 69
    Width = 32
    Height = 15
    HelpContext = 131016
    Caption = 'Client'
    FocusControl = DBEdit10
    Transparent = True
  end
  object Label11: TLabel [15]
    Left = 391
    Top = 460
    Width = 41
    Height = 15
    HelpContext = 131017
    Caption = 'Priority'
    Transparent = True
  end
  object Label12: TLabel [16]
    Left = 29
    Top = 210
    Width = 98
    Height = 15
    HelpContext = 131018
    Caption = 'Transaction Type'
    FocusControl = DBEdit12
    Transparent = True
  end
  object Label13: TLabel [17]
    Left = 185
    Top = 210
    Width = 60
    Height = 15
    HelpContext = 131019
    Caption = 'Global Ref '
    FocusControl = DBEdit13
    Transparent = True
  end
  object Label14: TLabel [18]
    Left = 31
    Top = 272
    Width = 44
    Height = 15
    HelpContext = 131020
    Caption = 'Fax Log'
    Transparent = True
  end
  object Label15: TLabel [19]
    Left = 30
    Top = 412
    Width = 91
    Height = 15
    HelpContext = 131021
    Caption = 'Started Sending'
    Transparent = True
  end
  object Label16: TLabel [20]
    Left = 30
    Top = 461
    Width = 110
    Height = 15
    HelpContext = 131022
    Caption = 'Completed Sending'
    Transparent = True
  end
  object Label17: TLabel [21]
    Left = 300
    Top = 482
    Width = 51
    Height = 15
    HelpContext = 131023
    Caption = ' Minutes '
    FocusControl = DBEdit3
    Transparent = True
  end
  object Label18: TLabel [22]
    Left = 28
    Top = 139
    Width = 91
    Height = 15
    HelpContext = 131024
    Caption = 'Use CoverSheet'
    Transparent = True
  end
  object Label19: TLabel [23]
    Left = 137
    Top = 131
    Width = 102
    Height = 15
    HelpContext = 131025
    Caption = 'CoverSheet Notes'
    Transparent = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 131001
  end
  object cmdCancel: TDNMSpeedButton [25]
    Left = 471
    Top = 518
    Width = 87
    Height = 27
    HelpContext = 131026
    Anchors = [akBottom]
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
    OnClick = cmdCancelClick
  end
  object DBEdit3: TDBEdit [26]
    Left = 233
    Top = 477
    Width = 65
    Height = 23
    HelpContext = 131027
    DataField = 'RetryInMins'
    DataSource = DSFaxJob
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object DBEdit4: TDBEdit [27]
    Left = 233
    Top = 429
    Width = 64
    Height = 23
    HelpContext = 131028
    DataField = 'RetryCount'
    DataSource = DSFaxJob
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
  end
  object DBEdit5: TDBEdit [28]
    Left = 27
    Top = 83
    Width = 118
    Height = 23
    HelpContext = 131029
    DataField = 'EmployeeName'
    DataSource = DSFaxJob
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
  end
  object DBEdit6: TDBEdit [29]
    Left = 548
    Top = 31
    Width = 90
    Height = 23
    HelpContext = 131030
    DataField = 'FaxSpoolID'
    DataSource = DSFaxJob
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
  end
  object DBEdit7: TDBEdit [30]
    Left = 377
    Top = 83
    Width = 123
    Height = 23
    HelpContext = 131031
    DataField = 'FaxNumber'
    DataSource = DSFaxJob
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object DBEdit9: TDBEdit [31]
    Left = 399
    Top = 425
    Width = 256
    Height = 27
    HelpContext = 131032
    BevelOuter = bvNone
    BevelKind = bkSoft
    DataField = 'Status'
    DataSource = DSFaxJob
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 7
  end
  object DBEdit10: TDBEdit [32]
    Left = 167
    Top = 83
    Width = 188
    Height = 23
    HelpContext = 131033
    DataField = 'ClientName'
    DataSource = DSFaxJob
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 8
  end
  object DBEdit12: TDBEdit [33]
    Left = 29
    Top = 226
    Width = 123
    Height = 23
    HelpContext = 131034
    DataField = 'TransType'
    DataSource = DSFaxJob
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 9
  end
  object DBEdit13: TDBEdit [34]
    Left = 184
    Top = 226
    Width = 123
    Height = 23
    HelpContext = 131035
    DataField = 'TransGlobal'
    DataSource = DSFaxJob
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 10
  end
  object wwDBDateTimePicker1: TwwDBDateTimePicker [35]
    Left = 521
    Top = 83
    Width = 134
    Height = 23
    HelpContext = 131036
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    ButtonStyle = cbsCustom
    DataField = 'DateSpooled'
    DataSource = DSFaxJob
    Epoch = 1950
    ButtonWidth = -1
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ShowButton = True
    TabOrder = 11
    DisplayFormat = 'd mmm yyyy h:nn am/pm'
  end
  object wwDBDateTimePicker2: TwwDBDateTimePicker [36]
    Left = 30
    Top = 429
    Width = 134
    Height = 23
    HelpContext = 131037
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    ButtonStyle = cbsCustom
    DataField = 'DateStarted'
    DataSource = DSFaxJob
    Epoch = 1950
    ButtonWidth = -1
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ShowButton = True
    TabOrder = 12
    DisplayFormat = 'd mmm yyyy h:nn am/pm'
  end
  object wwDBDateTimePicker3: TwwDBDateTimePicker [37]
    Left = 30
    Top = 477
    Width = 134
    Height = 23
    HelpContext = 131038
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    ButtonStyle = cbsCustom
    DataField = 'DateCompleted'
    DataSource = DSFaxJob
    Epoch = 1950
    ButtonWidth = -1
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ShowButton = True
    TabOrder = 13
    DisplayFormat = 'd mmm yyyy h:nn am/pm'
  end
  object cboPickingPriority: TwwDBComboBox [38]
    Left = 391
    Top = 477
    Width = 104
    Height = 23
    HelpContext = 131039
    ShowButton = True
    Style = csDropDownList
    MapList = True
    AllowClearKey = False
    AutoDropDown = True
    AutoFillDate = False
    DataField = 'Priority'
    DataSource = DSFaxJob
    DropDownCount = 8
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      '10 - High'#9'10'
      '9'#9'9'
      '8'#9'8'
      '7'#9'7'
      '6'#9'6'
      '5  - Standard'#9'5'
      '4'#9'4'
      '3'#9'3'
      '2'#9'2'
      '1'#9'1'
      '0  - Low'#9'0')
    ParentFont = False
    Sorted = False
    TabOrder = 14
    UnboundDataType = wwDefault
    UnboundAlignment = taCenter
  end
  object wwCheckBox2: TwwCheckBox [39]
    Left = 541
    Top = 481
    Width = 15
    Height = 17
    HelpContext = 131040
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
    Caption = 'wwCheckBox1'
    DataField = 'Cancelled'
    DataSource = DSFaxJob
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 15
  end
  object FaxLog: TDBMemo [40]
    Left = 30
    Top = 286
    Width = 634
    Height = 117
    HelpContext = 131041
    DataField = 'Description'
    DataSource = DSFaxJob
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 17
  end
  object DBMemo2: TDBMemo [41]
    Left = 136
    Top = 145
    Width = 519
    Height = 45
    HelpContext = 131042
    DataField = 'CoverSheetNotes'
    DataSource = DSFaxJob
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 18
  end
  object wwCheckBox3: TwwCheckBox [42]
    Left = 66
    Top = 157
    Width = 15
    Height = 17
    HelpContext = 131043
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
    Caption = 'wwCheckBox1'
    DataField = 'UseCoverSheet'
    DataSource = DSFaxJob
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 19
  end
  object BitBtn1: TDNMSpeedButton [43]
    Left = 301
    Top = 518
    Width = 87
    Height = 27
    HelpContext = 131044
    Anchors = [akBottom]
    Caption = 'Reset'
    Default = True
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 20
    OnClick = BitBtn1Click
  end
  object wwCheckBox1: TwwCheckBox [44]
    Left = 609
    Top = 481
    Width = 15
    Height = 17
    HelpContext = 131045
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
    Caption = 'wwCheckBox1'
    DataField = 'SentOk'
    DataSource = DSFaxJob
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 16
  end
  object cmdOK: TDNMSpeedButton [45]
    Left = 132
    Top = 518
    Width = 87
    Height = 27
    HelpContext = 131046
    Anchors = [akBottom]
    Caption = '&Save'
    Default = True
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 0
    OnClick = cmdOKClick
  end
  object pnlTitle: TDNMPanel [46]
    Left = 224
    Top = 6
    Width = 238
    Height = 45
    HelpContext = 131047
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 21
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 234
      Height = 41
      HelpContext = 131048
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
        Width = 234
        Height = 41
        HelpContext = 131049
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Fax Job'
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
  object qryFaxJob: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblfaxspool'
      'Where FaxSpoolID = :ID;')
    Left = 124
    Top = 5
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Size = 255
      end>
    object qryFaxJobFaxSpoolID: TAutoIncField
      FieldName = 'FaxSpoolID'
      ReadOnly = True
    end
    object qryFaxJobEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 255
    end
    object qryFaxJobFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
      Size = 255
    end
    object qryFaxJobDateSpooled: TDateTimeField
      FieldName = 'DateSpooled'
    end
    object qryFaxJobTransType: TWideStringField
      FieldName = 'TransType'
      Size = 255
    end
    object qryFaxJobTransGlobal: TWideStringField
      FieldName = 'TransGlobal'
      Size = 255
    end
    object qryFaxJobDateStarted: TDateTimeField
      FieldName = 'DateStarted'
    end
    object qryFaxJobStatus: TWideStringField
      FieldName = 'Status'
      Size = 255
    end
    object qryFaxJobDateCompleted: TDateTimeField
      FieldName = 'DateCompleted'
    end
    object qryFaxJobRetryCount: TIntegerField
      FieldName = 'RetryCount'
    end
    object qryFaxJobRetryInMins: TIntegerField
      FieldName = 'RetryInMins'
    end
    object qryFaxJobPriority: TIntegerField
      FieldName = 'Priority'
    end
    object qryFaxJobCancelled: TWideStringField
      FieldName = 'Cancelled'
      FixedChar = True
      Size = 1
    end
    object qryFaxJobSentOk: TWideStringField
      FieldName = 'SentOk'
      FixedChar = True
      Size = 1
    end
    object qryFaxJobClientName: TWideStringField
      FieldName = 'ClientName'
      Size = 255
    end
    object qryFaxJobDescription: TWideMemoField
      FieldName = 'Description'
      BlobType = ftWideMemo
    end
    object qryFaxJobUseCoverSheet: TWideStringField
      FieldName = 'UseCoverSheet'
      FixedChar = True
      Size = 1
    end
    object qryFaxJobCoverSheetNotes: TWideMemoField
      FieldName = 'CoverSheetNotes'
      BlobType = ftWideMemo
    end
  end
  object DSFaxJob: TDataSource
    DataSet = qryFaxJob
    Left = 157
    Top = 10
  end
end
