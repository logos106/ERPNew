inherited EmpPaySetupLeave: TEmpPaySetupLeave
  Left = 595
  Top = 153
  HelpContext = 561000
  Caption = 'EmpPaySetupLeave'
  ClientHeight = 419
  ClientWidth = 942
  OldCreateOrder = True
  ExplicitLeft = 595
  ExplicitTop = 153
  ExplicitWidth = 958
  ExplicitHeight = 458
  DesignSize = (
    942
    419)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 419
    Width = 942
    HelpContext = 561015
    ExplicitTop = 590
    ExplicitWidth = 1063
  end
  inherited shapehintextra1: TShape
    Left = 45
    ExplicitLeft = 45
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 942
    Height = 419
    HelpContext = 561002
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      942
      419)
    object lblSuper: TLabel
      Left = 18
      Top = 384
      Width = 185
      Height = 16
      HelpContext = 561004
      Anchors = [akLeft, akBottom]
      Caption = 'Pay Super on Leave Loading'
      ExplicitTop = 452
    end
    object grdLeave: TwwDBGrid
      AlignWithMargins = True
      Left = 11
      Top = 11
      Width = 920
      Height = 359
      HelpContext = 561005
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 0
      ControlType.Strings = (
        'Type;CustomEdit;cboLeaveType;F'
        'AccrueAfterPeriod;CustomEdit;AccrueAfter;F'
        'ClassName;CustomEdit;cboLeaveDepartment;F'
        'StartDate;CustomEdit;StartPicker;F'
        'EndDate;CustomEdit;EndPicker;F'
        'UseStartEndDates;CustomEdit;chkUseDates;F'
        'AccrueHours;CustomEdit;edtAccruedHours;F'
        'AccruePeriod;CustomEdit;AccruePeriod;F'
        'Type;CustomEdit;Type;F'
        'AccruedDate;CustomEdit;dpAccruedDate;F')
      Selected.Strings = (
        'Type'#9'20'#9'Type'#9'F'
        'AccrueAfterNo'#9'6'#9'Number'#9'F'#9'Accrue After'
        'AccrueAfterPeriod'#9'9'#9'Period'#9'F'#9'Accrue After'
        'AccrueNo'#9'6'#9'Every'#9'F'#9'Accrue'
        'AccruePeriod'#9'9'#9'Period'#9'F'#9'Accrue'
        'AccrueHours'#9'7'#9'Hours'#9'F'#9'Accrue'
        'OpenningBalanceHrs'#9'10'#9'Hours'#9'F'#9'Opening Accrued'
        'OpenningBalanceDate'#9'10'#9'Date'#9'F'#9'Opening Accrued'
        'AccruedHours'#9'9'#9'Hours'#9'T'#9'Total Accrued'
        'AccruedDate'#9'11'#9'Date'#9'T'#9'Total Accrued'
        'LeaveLoading'#9'5'#9'Loading %'#9'F'
        'ClassName'#9'20'#9'ClassName'#9'F'#9
        'UseStartEndDates'#9'1'#9'Use Start End Dates'#9'F'#9'Accrue between Dates'
        'StartDate'#9'10'#9'Start Date'#9'F'#9'Accrue between Dates'
        'EndDate'#9'10'#9'End Date'#9'F'#9'Accrue between Dates')
      IniAttributes.Delimiter = ';;'
      TitleColor = 14155775
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alTop
      DataSource = DSLeave
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
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
      FooterColor = 14155775
      FooterCellColor = 14155775
      object grdLeaveIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 23
        Height = 39
        HelpContext = 561016
        AllowAllUp = True
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033337733333333333333333F333333333333
          0000333911733333973333333377F333333F3333000033391117333911733333
          37F37F333F77F33300003339111173911117333337F337F3F7337F3300003333
          911117111117333337F3337F733337F3000033333911111111733333337F3337
          3333F7330000333333911111173333333337F333333F73330000333333311111
          7333333333337F3333373333000033333339111173333333333337F333733333
          00003333339111117333333333333733337F3333000033333911171117333333
          33337333337F333300003333911173911173333333373337F337F33300003333
          9117333911173333337F33737F337F33000033333913333391113333337FF733
          37F337F300003333333333333919333333377333337FFF730000333333333333
          3333333333333333333777330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        OnClick = grdLeaveIButtonClick
      end
    end
    object cboLeaveType: TwwDBLookupCombo
      Left = 43
      Top = 147
      Width = 123
      Height = 24
      HelpContext = 561006
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      DataField = 'Type'
      DataSource = DSLeave
      LookupTable = qryLeaveTypes
      LookupField = 'LeaveType'
      DropDownWidth = 144
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnChange = cboLeaveTypeChange
    end
    object AccrueAfter: TwwDBComboBox
      Left = 216
      Top = 145
      Width = 53
      Height = 24
      HelpContext = 561007
      ShowButton = True
      Style = csDropDownList
      MapList = False
      AllowClearKey = False
      AutoDropDown = True
      DataField = 'AccrueAfterNo'
      DataSource = DSLeave
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        'Pay'
        'Week'
        'Month'
        'Year')
      ParentFont = False
      Sorted = False
      TabOrder = 2
      UnboundDataType = wwDefault
    end
    object AccruePeriod: TwwDBComboBox
      Left = 327
      Top = 145
      Width = 53
      Height = 24
      HelpContext = 561008
      ShowButton = True
      Style = csDropDownList
      MapList = False
      AllowClearKey = False
      AutoDropDown = True
      DataField = 'AccruePeriod'
      DataSource = DSLeave
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        'Hour'
        'Pay'
        'Week')
      ParentFont = False
      Sorted = False
      TabOrder = 3
      UnboundDataType = wwDefault
    end
    object StartPicker: TwwDBDateTimePicker
      Left = 517
      Top = 175
      Width = 130
      Height = 24
      HelpContext = 561010
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'StartDate'
      DataSource = DSLeave
      Epoch = 1950
      ShowButton = True
      TabOrder = 4
    end
    object cboLeaveDepartment: TwwDBLookupCombo
      Left = 540
      Top = 140
      Width = 142
      Height = 24
      HelpContext = 561011
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'ClassName'#9'15'#9'Department'#9'F')
      DataField = 'ClassName'
      DataSource = DSLeave
      LookupTable = qryDepartment
      LookupField = 'ClassName'
      Options = [loColLines, loTitles, loFixedDropDownHeight]
      Style = csDropDownList
      DropDownWidth = 170
      ParentFont = False
      TabOrder = 5
      Visible = False
      AutoDropDown = True
      ShowButton = True
      OrderByDisplay = False
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object EndPicker: TwwDBDateTimePicker
      Left = 588
      Top = 238
      Width = 122
      Height = 24
      HelpContext = 561012
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'EndDate'
      DataSource = DSLeave
      Epoch = 1950
      ShowButton = True
      TabOrder = 7
    end
    object chkNICsOnLoading: TwwCheckBox
      Left = 213
      Top = 385
      Width = 19
      Height = 18
      HelpContext = 561013
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Anchors = [akLeft, akBottom]
      DataField = 'PaySuperOnLeaveLoading'
      DataSource = DSEmployee
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
    end
    object chkUseDates: TwwCheckBox
      Left = 672
      Top = 194
      Width = 19
      Height = 19
      HelpContext = 561014
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      DataField = 'UseStartEndDates'
      DataSource = DSLeave
      TabOrder = 6
      Visible = False
    end
    object dpAccruedDate: TwwDBDateTimePicker
      Left = 478
      Top = 299
      Width = 130
      Height = 24
      HelpContext = 561017
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'AccruedDate'
      DataSource = DSLeave
      Epoch = 1950
      ReadOnly = True
      ShowButton = False
      TabOrder = 9
      UnboundDataType = wwDTEdtDate
    end
    object btnFixAccruals: TDNMSpeedButton
      Left = 407
      Top = 380
      Width = 149
      Height = 26
      HelpContext = 561018
      Anchors = [akBottom]
      Caption = 'Confirm Accruals'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      TabOrder = 10
      AutoDisableParentOnclick = True
      OnClick = btnFixAccrualsClick
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102009800A00010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  object DSLeave: TDataSource
    Left = 816
    Top = 242
  end
  object qryLeaveTypes: TERPQuery
    SQL.Strings = (
      
        'SELECT LeaveTypeID, LeaveType FROM tblleavetypes WHERE Active = ' +
        #39'T'#39)
    Left = 842
    Top = 163
  end
  object qryemployeepayrates: TERPQuery
    SQL.Strings = (
      'Select * '
      'From tblemployeepayrates'
      'Where EmployeeID=:xID;')
    Left = 843
    Top = 131
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object qryemployeepayratesPayRate: TWideStringField
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'PayRate'
      LookupDataSet = qryPayRates
      LookupKeyFields = 'RateID'
      LookupResultField = 'Description'
      KeyFields = 'PayRateID'
      Size = 100
      Lookup = True
    end
    object qryemployeepayratesRateType: TWideStringField
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'RateType'
      LookupDataSet = qryPayRateType
      LookupKeyFields = 'TypeID'
      LookupResultField = 'Description'
      KeyFields = 'TypeID'
      Lookup = True
    end
    object qryemployeepayratesQty: TFloatField
      DisplayLabel = 'Hours'
      DisplayWidth = 10
      FieldName = 'Qty'
      DisplayFormat = '#0.00##'
      EditFormat = '#0.00##'
    end
    object qryemployeepayratesHourlyRate: TFloatField
      DisplayLabel = 'Rate/Salary'
      DisplayWidth = 10
      FieldName = 'HourlyRate'
      DisplayFormat = '#0.00##'
    end
    object qryemployeepayratesAmount: TFloatField
      DisplayLabel = 'Wages'
      DisplayWidth = 10
      FieldName = 'Amount'
      currency = True
    end
    object qryemployeepayratesRateJob: TWideStringField
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'RateJob'
      LookupDataSet = qryJobs
      LookupKeyFields = 'ClientID'
      LookupResultField = 'Company'
      KeyFields = 'ClientID'
      Lookup = True
    end
    object qryemployeepayratesClassName: TWideStringField
      DisplayWidth = 15
      FieldName = 'ClassName'
      Size = 255
    end
    object qryemployeepayratesSuper: TWideStringField
      DisplayWidth = 1
      FieldName = 'Super'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryemployeepayratesLineTotal: TFloatField
      DisplayWidth = 10
      FieldName = 'LineTotal'
      Visible = False
    end
    object qryemployeepayratesClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Visible = False
    end
    object qryemployeepayratesClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
      Visible = False
    end
    object qryemployeepayratesEmployeeRateID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'EmployeeRateID'
      ReadOnly = True
      Visible = False
    end
    object qryemployeepayratesEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Visible = False
    end
    object qryemployeepayratesPayRateID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PayRateID'
      Visible = False
    end
    object qryemployeepayratesTypeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TypeID'
      Visible = False
    end
    object qryemployeepayratesNICs: TWideStringField
      DisplayWidth = 1
      FieldName = 'NICs'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object qryPayRates: TERPQuery
    SQL.Strings = (
      'Select RateID, Description'
      'FROM tblPayRates'
      'WHERE Active = '#39'T'#39' AND IsLeave <> '#39'T'#39
      'ORDER BY Description'
      '')
    Left = 827
    Top = 104
    object qryPayRatesDescription: TWideStringField
      DisplayWidth = 25
      FieldName = 'Description'
      Size = 100
    end
    object qryPayRatesRateID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'RateID'
      ReadOnly = True
      Visible = False
    end
  end
  object qryPayRateType: TERPQuery
    SQL.Strings = (
      'Select TypeID,Description'
      'FROM tblPayRateType')
    Left = 854
    Top = 106
  end
  object qryJobs: TERPQuery
    SQL.Strings = (
      'SELECT ClientID, Company, JobNumber, DefaultClass'
      'FROM tblclients'
      
        'WHERE Active = '#39'T'#39' AND Customer='#39'T'#39' AND (Company NOT LIKE '#39'Table' +
        '%'#39')'
      'ORDER BY Company')
    Left = 884
    Top = 106
  end
  object qryDepartment: TERPQuery
    SQL.Strings = (
      'Select ClassID, ClassName, Active'
      'FROM tblClass WHERE Active = "T"'
      'ORDER BY ClassName')
    Left = 872
    Top = 163
  end
  object DSEmployee: TDataSource
    Left = 264
    Top = 328
  end
end
