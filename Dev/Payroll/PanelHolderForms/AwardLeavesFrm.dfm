inherited frmAwardLeaves: TfrmAwardLeaves
  Left = 237
  Top = 141
  HelpContext = 565000
  Caption = 'frmAwardLeaves'
  ClientHeight = 513
  ClientWidth = 845
  OldCreateOrder = True
  ExplicitLeft = 237
  ExplicitTop = 141
  ExplicitWidth = 853
  ExplicitHeight = 540
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 513
    Width = 845
    HelpContext = 565013
  end
  object DNMPanel1: TDNMPanel [3]
    Left = 16
    Top = 40
    Width = 799
    Height = 425
    HelpContext = 565001
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      799
      425)
    object Bevel1: TBevel
      Left = 8
      Top = 8
      Width = 783
      Height = 410
      HelpContext = 565002
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object grdLeave: TwwDBGrid
      Left = 16
      Top = 15
      Width = 765
      Height = 394
      HelpContext = 565003
      ControlType.Strings = (
        'Type;CustomEdit;cboLeave;F'
        'AccrueAfterPeriod;CustomEdit;AccrueAfterPeriod;T'
        'AccruePeriod;CustomEdit;AccruePeriod;T'
        'AwardStartDate;CustomEdit;dtpAwardStartDate;T'
        'AwardEndDate;CustomEdit;dtpAwardEndDate;T'
        'UseStartEndDates;CustomEdit;chkUseStartEndDates;T'
        'AccrueAfterNo;CustomEdit;edAccrueAfterNo;F'
        'AccrueNo;CustomEdit;edAccrueNo;F'
        'AccrueHours;CustomEdit;edAccrueHours;F')
      Selected.Strings = (
        'Type'#9'15'#9'~Leave Type'#9'F'
        'AccrueAfterNo'#9'5'#9'Number'#9'F'#9'Accrue After'
        'AccrueAfterPeriod'#9'7'#9'Period'#9'F'#9'Accrue After'
        'AccrueNo'#9'5'#9'Every'#9'F'#9'Accrue'
        'AccruePeriod'#9'8'#9'Period'#9'F'#9'Accrue'
        'AccrueHours'#9'12'#9'Hours'#9'F'#9'Accrue'
        'LeaveLoading'#9'10'#9'Loading'#9'F'
        'UseStartEndDates'#9'12'#9'Use Dates'#9'F'#9'Accrue between Dates'
        'AwardStartDate'#9'12'#9'Start'#9'F'#9'Accrue between Dates'
        'AwardEndDate'#9'9'#9'Finish'#9'F'#9'Accrue between Dates')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akBottom]
      DataSource = DSLeave
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgProportionalColResize]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taCenter
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = True
      UseTFields = False
      FooterColor = clWhite
      object btnLeave: TwwIButton
        Left = 0
        Top = 0
        Width = 25
        Height = 35
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
        OnClick = btnLeaveClick
        HelpContext = 565014
      end
    end
    object cboLeave: TwwDBLookupCombo
      Left = 56
      Top = 79
      Width = 195
      Height = 23
      HelpContext = 565004
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      DataField = 'Type'
      DataSource = DSLeave
      LookupTable = qryLeaveTypes
      LookupField = 'LeaveType'
      DropDownWidth = 40
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object AccrueAfterPeriod: TwwDBComboBox
      Left = 293
      Top = 78
      Width = 127
      Height = 23
      HelpContext = 565005
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      AutoDropDown = True
      ShowMatchText = True
      DataField = 'AccrueAfterPeriod'
      DataSource = DSLeave
      DropDownCount = 8
      DropDownWidth = 100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        'Pay'
        'Week'
        'Month'
        'Year'
        'Birthday')
      ItemIndex = 0
      ParentFont = False
      Sorted = False
      TabOrder = 2
      UnboundDataType = wwDefault
    end
    object dtpAwardStartDate: TwwDBDateTimePicker
      Left = 306
      Top = 96
      Width = 155
      Height = 23
      HelpContext = 565006
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'AwardStartDate'
      DataSource = DSLeave
      Epoch = 1950
      ShowButton = True
      TabOrder = 3
    end
    object dtpAwardEndDate: TwwDBDateTimePicker
      Left = 402
      Top = 104
      Width = 140
      Height = 23
      HelpContext = 565007
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'AwardEndDate'
      DataSource = DSLeave
      Epoch = 1950
      ShowButton = True
      TabOrder = 4
    end
    object AccruePeriod: TwwDBComboBox
      Left = 425
      Top = 80
      Width = 134
      Height = 23
      HelpContext = 565008
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      AutoDropDown = True
      ShowMatchText = True
      DataField = 'AccruePeriod'
      DataSource = DSLeave
      DropDownCount = 8
      DropDownWidth = 100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        'Hour'
        'Pay'
        'Week')
      ItemIndex = 0
      ParentFont = False
      Sorted = False
      TabOrder = 5
      UnboundDataType = wwDefault
    end
    object chkUseStartEndDates: TwwCheckBox
      Left = 476
      Top = 63
      Width = 151
      Height = 19
      HelpContext = 565009
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
      Indents.ButtonX = 29
      Color = clWhite
      DataField = 'UseStartEndDates'
      DataSource = DSLeave
      ParentColor = False
      TabOrder = 6
      Visible = False
    end
    object edAccrueAfterNo: TwwDBEdit
      Left = 232
      Top = 168
      Width = 65
      Height = 23
      HelpContext = 565010
      DataField = 'AccrueAfterNo'
      DataSource = DSLeave
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edAccrueNo: TwwDBEdit
      Left = 408
      Top = 160
      Width = 65
      Height = 23
      HelpContext = 565011
      DataField = 'AccrueNo'
      DataSource = DSLeave
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edAccrueHours: TwwDBEdit
      Left = 216
      Top = 240
      Width = 97
      Height = 23
      HelpContext = 565012
      DataField = 'AccrueHours'
      DataSource = DSLeave
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  object DSLeave: TDataSource
    Left = 147
    Top = 9
  end
  object qryLeaveTypes: TERPQuery
    SQL.Strings = (
      'SELECT '
      'LeaveTypeID AS LeaveTypeID,'
      'LeaveType AS LeaveType'
      'FROM tblLeaveTypes'
      'WHERE Active = '#39'T'#39
      'ORDER BY LeaveType')
    Left = 392
    Top = 7
  end
end
