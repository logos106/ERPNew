inherited frmDailyWorkRecord: TfrmDailyWorkRecord
  Left = 284
  Top = 208
  HelpContext = 260000
  Caption = 'Daily Work Record'
  ClientHeight = 485
  ClientWidth = 792
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  inherited imgGridWatermark: TImage
    HelpContext = 260001
  end
  object grdDailyrecord: TwwDBGrid [1]
    Left = 0
    Top = 118
    Width = 792
    Height = 321
    HelpContext = 260002
    ControlType.Strings = (
      'AUSCompliance;CheckBox;T;F')
    Selected.Strings = (
      'Date'#9'18'#9'Date'#9'T'#9
      'AUSCompliance'#9'1'#9'AUS Compliance'#9#9
      'AUSStandard'#9'25'#9'AUS Standard'#9#9
      'StartTime'#9'10'#9'StartTime'#9'F'#9
      'FinishTime'#9'10'#9'FinishTime'#9'F'#9
      'DownTime'#9'16'#9'Down Time'#9'F'#9
      'Comments'#9'25'#9'Comments'#9'F'#9
      'DownTimeReason'#9'25'#9'Down Time Reason'#9'F'#9
      'CustomField1'#9'25'#9'CustomField1'#9'F'#9
      'CustomField2'#9'25'#9'CustomField2'#9'F'#9
      'CustomField3'#9'25'#9'CustomField3'#9'F'#9
      'CustomField4'#9'25'#9'CustomField4'#9'F'#9
      'CustomField5'#9'25'#9'CustomField5'#9'F'#9
      'CustomField6'#9'25'#9'CustomField6'#9'F'#9
      'CustomField7'#9'25'#9'CustomField7'#9'F'#9
      'CustomField8'#9'25'#9'CustomField8'#9'F'#9
      'CustomField9'#9'25'#9'CustomField9'#9'F'#9
      'CustomField10'#9'25'#9'CustomField10'#9'F'#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clWindow
    FixedCols = 0
    ShowHorzScrollBar = True
    EditControlOptions = [ecoCheckboxSingleClick, ecoDisableEditorIfReadOnly]
    Align = alClient
    DataSource = DSDetails
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
    OnEnter = grdDailyrecordEnter
    PaintOptions.BackgroundOptions = [coBlendFixedRow]
  end
  object pnlTop: TDNMPanel [2]
    Left = 0
    Top = 0
    Width = 792
    Height = 118
    HelpContext = 260003
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object DNMPanel1: TDNMPanel
      Left = 0
      Top = 64
      Width = 792
      Height = 54
      HelpContext = 260004
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        792
        54)
      object Label2: TLabel
        Left = 6
        Top = 4
        Width = 91
        Height = 15
        HelpContext = 260005
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Employee Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label3: TLabel
        Left = 538
        Top = 4
        Width = 77
        Height = 15
        HelpContext = 260006
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Week Ending '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblIssuedTo: TLabel
        Left = 268
        Top = 4
        Width = 58
        Height = 15
        HelpContext = 260007
        Alignment = taRightJustify
        Caption = 'Issued To '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label1: TLabel
        Left = 632
        Top = 4
        Width = 79
        Height = 15
        HelpContext = 260008
        Alignment = taRightJustify
        Caption = 'Feeder / Zone '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object cboEmployee: TwwDBLookupCombo
        Left = 6
        Top = 24
        Width = 255
        Height = 23
        HelpContext = 260009
        Anchors = [akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'EmployeeName'#9'30'#9'EmployeeName'#9'F')
        DataField = 'EmployeeID'
        DataSource = DSMaster
        LookupTable = qryEmployeeID
        LookupField = 'EmployeeID'
        ParentFont = False
        TabOrder = 0
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboEmployeeCloseUp
        OnEnter = cboEmployeeEnter
        OnExit = showDetials
      end
      object dtWeekEnding: TwwDBDateTimePicker
        Left = 538
        Top = 24
        Width = 85
        Height = 23
        HelpContext = 260010
        Anchors = [akTop, akRight]
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'WeekEnding'
        DataSource = DSMaster
        Date = 38795
        Epoch = 1950
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ShowButton = True
        TabOrder = 2
        OnCloseUp = dtWeekEndingCloseUp
        OnEnter = cboEmployeeEnter
        OnExit = dtWeekEndingCloseUp
      end
      object cboIssuedTo: TwwDBLookupCombo
        Left = 265
        Top = 24
        Width = 255
        Height = 23
        HelpContext = 260011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'EmployeeName'#9'30'#9'EmployeeName'#9'F')
        DataField = 'IssuedTo'
        DataSource = DSMaster
        LookupTable = qryEmployeeID
        LookupField = 'EmployeeID'
        ParentFont = False
        TabOrder = 1
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboIssuedToCloseUp
        OnEnter = cboEmployeeEnter
        OnExit = showDetials
      end
      object edtZone: TwwDBEdit
        Left = 632
        Top = 24
        Width = 145
        Height = 23
        HelpContext = 260012
        DataField = 'Zone'
        DataSource = DSMaster
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
    end
  end
  object pnlBottom: TDNMPanel [3]
    Left = 0
    Top = 439
    Width = 792
    Height = 46
    HelpContext = 260013
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      792
      46)
    object Label50: TLabel
      Left = 704
      Top = 14
      Width = 40
      Height = 18
      HelpContext = 260014
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = 'Active'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
      WordWrap = True
    end
    object btnSave: TDNMSpeedButton
      Left = 200
      Top = 11
      Width = 87
      Height = 27
      HelpContext = 260015
      Action = actMainSave
      Anchors = [akBottom]
      Caption = '&Save'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
    end
    object btnNew: TDNMSpeedButton
      Left = 353
      Top = 11
      Width = 87
      Height = 27
      HelpContext = 260016
      Action = actMainNew
      Anchors = [akBottom]
      Caption = '&New'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object btnCancel: TDNMSpeedButton
      Left = 506
      Top = 11
      Width = 87
      Height = 27
      HelpContext = 260017
      Action = actMainCancel
      Anchors = [akBottom]
      Caption = '&Cancel'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 3
    end
    object chkActive: TwwCheckBox
      Left = 744
      Top = 15
      Width = 16
      Height = 17
      HelpContext = 260018
      AlwaysTransparent = True
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Anchors = [akRight, akBottom]
      Caption = 'chkActive'
      DataField = 'Active'
      TabOrder = 0
      Visible = False
    end
  end
  object pnlTitle: TDNMPanel [4]
    Left = 245
    Top = 6
    Width = 282
    Height = 45
    HelpContext = 260019
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 278
      Height = 41
      HelpContext = 260020
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
        Width = 278
        Height = 41
        HelpContext = 260021
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Daily Work Record'
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
    Left = 71
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 7
  end
  inherited MyConnection: TMyConnection
    Top = 8
  end
  inherited DataState: TDataState
    Left = 7
    Top = 40
  end
  object alMain: TActionList
    Left = 136
    Top = 9
    object actMainSave: TAction
      Caption = '&Save'
      OnExecute = actMainSaveExecute
    end
    object actMainNew: TAction
      Caption = '&New'
      OnExecute = actMainNewExecute
    end
    object actMainCancel: TAction
      Caption = '&Cancel'
      OnExecute = actMainCancelExecute
    end
  end
  object DSMaster: TDataSource
    DataSet = tblMaster
    Left = 40
    Top = 40
  end
  object tblMaster: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tbldailyworkrecord'
      'WHERE DailyWorkRecordID=:ID;')
    Left = 72
    Top = 40
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID'
        Value = 20
      end>
    object tblMasterGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Origin = 'tbldailyworkrecord.GlobalRef'
      Size = 255
    end
    object tblMasterDailyWorkRecordID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'DailyWorkRecordID'
      Origin = 'tbldailyworkrecord.DailyWorkRecordID'
    end
    object tblMasterIssuedTo: TIntegerField
      FieldName = 'IssuedTo'
      Origin = 'tbldailyworkrecord.IssuedTo'
    end
    object tblMasterEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tbldailyworkrecord.EmployeeID'
    end
    object tblMasterZone: TStringField
      FieldName = 'Zone'
      Origin = 'tbldailyworkrecord.Zone'
      Size = 40
    end
    object tblMasterWeekEnding: TDateField
      FieldName = 'WeekEnding'
      Origin = 'tbldailyworkrecord.WeekEnding'
    end
  end
  object tblDetails: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tbldailyworkrecordlines'
      'WHERE DailyWorkRecordID=:ID;')
    BeforeInsert = tblDetailsBeforeInsert
    AfterInsert = tblDetailsAfterInsert
    Left = 136
    Top = 40
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Value = ''
      end>
    object tblDetailsDate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'Date'
      OnChange = tblDetailsDateChange
    end
    object tblDetailsAUSCompliance: TStringField
      DisplayLabel = 'AUS Compliance'
      DisplayWidth = 1
      FieldName = 'AUSCompliance'
      FixedChar = True
      Size = 1
    end
    object tblDetailsAUSStandard: TStringField
      DisplayLabel = 'AUS Standard'
      DisplayWidth = 25
      FieldName = 'AUSStandard'
      Size = 25
    end
    object tblDetailsStartTime: TTimeField
      DisplayWidth = 10
      FieldName = 'StartTime'
      DisplayFormat = 'hh:nn:AM/PM'
    end
    object tblDetailsFinishTime: TTimeField
      DisplayWidth = 10
      FieldName = 'FinishTime'
      DisplayFormat = 'hh:nn:AM/PM'
    end
    object tblDetailsDownTime: TFloatField
      FieldName = 'DownTime'
      DisplayFormat = '#0.00'
    end
    object tblDetailsComments: TStringField
      DisplayWidth = 25
      FieldName = 'Comments'
      Size = 255
    end
    object tblDetailsDownTimeReason: TStringField
      DisplayLabel = 'Down Time Reason'
      DisplayWidth = 25
      FieldName = 'DownTimeReason'
      Size = 255
    end
    object tblDetailsCustomField1: TStringField
      DisplayWidth = 25
      FieldName = 'CustomField1'
      Size = 25
    end
    object tblDetailsCustomField2: TStringField
      DisplayWidth = 25
      FieldName = 'CustomField2'
      Size = 25
    end
    object tblDetailsCustomField3: TStringField
      DisplayWidth = 25
      FieldName = 'CustomField3'
      Size = 25
    end
    object tblDetailsCustomField4: TStringField
      DisplayWidth = 25
      FieldName = 'CustomField4'
      Size = 25
    end
    object tblDetailsCustomField5: TStringField
      DisplayWidth = 25
      FieldName = 'CustomField5'
      Size = 25
    end
    object tblDetailsCustomField6: TStringField
      DisplayWidth = 25
      FieldName = 'CustomField6'
      Size = 25
    end
    object tblDetailsCustomField7: TStringField
      DisplayWidth = 25
      FieldName = 'CustomField7'
      Size = 25
    end
    object tblDetailsCustomField8: TStringField
      DisplayWidth = 25
      FieldName = 'CustomField8'
      Size = 25
    end
    object tblDetailsCustomField9: TStringField
      DisplayWidth = 25
      FieldName = 'CustomField9'
      Size = 25
    end
    object tblDetailsCustomField10: TStringField
      DisplayWidth = 25
      FieldName = 'CustomField10'
      Size = 25
    end
    object tblDetailsGlobalRef: TStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object tblDetailsDailyWorkRecordLineID: TIntegerField
      DisplayWidth = 15
      FieldName = 'DailyWorkRecordLineID'
      Visible = False
    end
    object tblDetailsDailyWorkRecordID: TIntegerField
      DisplayWidth = 15
      FieldName = 'DailyWorkRecordID'
      Visible = False
    end
  end
  object DSDetails: TDataSource
    DataSet = tblDetails
    Left = 104
    Top = 40
  end
  object qryEmployeeID: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT EmployeeID, EmployeeName'
      'FROM tblemployees;')
    Left = 168
    Top = 40
  end
end
