inherited fmProcResourceEdit: TfmProcResourceEdit
  Left = 459
  Top = 247
  HelpContext = 189000
  Caption = 'Production Resource'
  ClientHeight = 563
  ClientWidth = 833
  OldCreateOrder = True
  OnResize = FormResize
  ExplicitLeft = 459
  ExplicitTop = 247
  ExplicitWidth = 849
  ExplicitHeight = 602
  DesignSize = (
    833
    563)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel5: TBevel [0]
    Left = 6
    Top = 281
    Width = 201
    Height = 44
    HelpContext = 189031
  end
  object Bevel2: TBevel [1]
    Left = 6
    Top = 203
    Width = 201
    Height = 74
    HelpContext = 189070
  end
  object Bevel3: TBevel [2]
    Left = 6
    Top = 118
    Width = 201
    Height = 81
    HelpContext = 189030
  end
  object Bevel4: TBevel [3]
    Left = 617
    Top = 105
    Width = 212
    Height = 89
    HelpContext = 189028
  end
  object Bevel1: TBevel [4]
    Left = 211
    Top = 105
    Width = 325
    Height = 246
    HelpContext = 189029
  end
  inherited lblSkingroupMsg: TLabel
    Top = 353
    Width = 833
    HelpContext = 189033
    ExplicitTop = 347
    ExplicitWidth = 599
  end
  object Label3: TLabel [6]
    Left = 315
    Top = 105
    Width = 63
    Height = 30
    HelpContext = 189004
    Alignment = taCenter
    Caption = 'Single Res Capacity'
    Transparent = True
    WordWrap = True
  end
  object Label4: TLabel [7]
    Left = 53
    Top = 131
    Width = 64
    Height = 15
    HelpContext = 189005
    Alignment = taRightJustify
    Caption = 'Setup Time'
    Transparent = True
  end
  object Label5: TLabel [8]
    Left = 21
    Top = 171
    Width = 96
    Height = 15
    HelpContext = 189006
    Alignment = taRightJustify
    Caption = 'Breakdown Time'
    Transparent = True
  end
  object Label8: TLabel [9]
    Left = 542
    Top = 197
    Width = 142
    Height = 15
    HelpContext = 189009
    Caption = 'Resource Process Steps'
    Transparent = True
  end
  object Label9: TLabel [10]
    Left = 621
    Top = 112
    Width = 204
    Height = 75
    HelpContext = 189010
    AutoSize = False
    Caption = 
      'Note:                                                           ' +
      ' Available capacity equals capacity minus setup and breakdown.  ' +
      '                                                                ' +
      '              Capacity times are in hh:mm format'
    Transparent = True
    WordWrap = True
  end
  inherited shapehint: TShape
    Left = 22
    ExplicitLeft = 23
  end
  inherited imgGridWatermark: TImage
    Left = 570
    Top = 19
    HelpContext = 189001
    ExplicitLeft = 570
    ExplicitTop = 19
  end
  object Label6: TLabel [13]
    Left = 35
    Top = 208
    Width = 82
    Height = 30
    HelpContext = 189007
    Alignment = taRightJustify
    Caption = 'Hourly Labour Rate'
    Transparent = True
    WordWrap = True
  end
  object Label7: TLabel [14]
    Left = 23
    Top = 244
    Width = 94
    Height = 30
    HelpContext = 189008
    Alignment = taRightJustify
    Caption = 'Hourly Overhead Rate'
    Transparent = True
    WordWrap = True
  end
  object Label18: TLabel [15]
    Left = 400
    Top = 120
    Width = 43
    Height = 15
    HelpContext = 189069
    Caption = 'Start At'
    Transparent = True
  end
  inherited shapehintextra1: TShape
    Left = 80
    ExplicitLeft = 82
  end
  object Label19: TLabel [18]
    Left = 53
    Top = 290
    Width = 64
    Height = 30
    HelpContext = 189003
    Alignment = taRightJustify
    Caption = 'Number Of Resources'
    Transparent = True
    WordWrap = True
  end
  object Bevel6: TBevel [19]
    Left = 213
    Top = 137
    Width = 323
    Height = 8
    HelpContext = 189072
    Shape = bsTopLine
  end
  object Label10: TLabel [20]
    Left = 8
    Top = 338
    Width = 97
    Height = 15
    HelpContext = 189073
    Caption = 'Resource Details'
    Transparent = True
  end
  object Label11: TLabel [21]
    Left = 460
    Top = 105
    Width = 72
    Height = 30
    HelpContext = 189086
    Alignment = taCenter
    Caption = 'Tot Capacity for the day'
    Transparent = True
    WordWrap = True
  end
  object Bevel7: TBevel [22]
    Left = 307
    Top = 105
    Width = 5
    Height = 246
    HelpContext = 189087
    Shape = bsLeftLine
    Style = bsRaised
  end
  object Bevel8: TBevel [23]
    Left = 383
    Top = 105
    Width = 5
    Height = 246
    HelpContext = 189088
    Shape = bsLeftLine
    Style = bsRaised
  end
  object Bevel9: TBevel [24]
    Left = 457
    Top = 105
    Width = 5
    Height = 246
    HelpContext = 189089
    Shape = bsLeftLine
    Style = bsRaised
  end
  object grdSteps: TwwDBGrid [25]
    Left = 542
    Top = 216
    Width = 291
    Height = 135
    HelpContext = 189027
    ControlType.Strings = (
      'ProcessStepDescription;CustomEdit;cboProcessStepDesc;F'
      'ProcessStepActive;CheckBox;T;F')
    Selected.Strings = (
      'ProcessStepDescription'#9'18'#9'Process Step'#9'F'#9
      'NoOfEmployeesReqd'#9'10'#9'No of People'#9#9
      'ProcessStepActive'#9'5'#9'Active'#9#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsResourceProcessStep
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 25
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    OnEnter = grdStepsEnter
    OnExit = grdStepsExit
    FooterColor = clWhite
    object btnDelete: TwwIButton
      Left = -2
      Top = -2
      Width = 22
      Height = 22
      HelpContext = 189034
      AllowAllUp = True
      Glyph.Data = {
        C6030000424DC603000000000000360000002800000010000000130000000100
        18000000000090030000120B0000120B00000000000000000000CCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC0C0C0CBCBCBCBCBCBCBCBCBCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCBCBCBCBCBCBCCCCCCD7D7D7C0C0C0
        666699969696969696999999CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCB9999
        99868686999999CBCBCBDDDDDDB2B2B2333399666666777777868686C0C0C0CC
        CCCCCCCCCCCCCCCCCCCCCCCBCBCB777777666666868686CBCBCBDDDDDDB2B2B2
        333399333366666666808080969696CBCBCBCCCCCCCCCCCCD7D7D7C0C0C03333
        99777777999999CBCBCBD7D7D7CBCBCB808080333366000080333366868686C0
        C0C0CCCCCCCCCCCCC0C0C0808080333399B2B2B2D7D7D7CCCCCCCBCBCBE6E6E6
        C0C0C0333399000080333366808080999999C0C0C06666993333993333667777
        77C0C0C0D7D7D7CCCCCCC9CACBCCCCCCCCCCCC33339900008033339966666686
        8686B2B2B2333399000080333366969696CBCBCBD7D7D7CCCCCCCBCBCCCCCCCC
        B2B2B2808080333366000080333366777777777777333366000080333399C0C0
        C0CCCCCCCCCCCCCCCCCCCACACCCCCCCCCCCCCCC0C0C033339900008000008000
        0080000080000080333399C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC9C9CBCCCCCC
        CCCCD1CCCCCC9696966666660000800000800000805F5F5F969696CCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCC7C7C9C0C0C0C0C0C096969666666600008000
        0080333366777777999999C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC3C3CCB8B8B8
        868686808080666699333399333399000080333366666666808080969696C0C0
        C0CCCCCCCCCCCCCCCCCCA4A0A0868686333399666699B2B2B2CCCCCCC0C0C080
        8080333366333366333366777777969696C0C0C0CCCCCCCCCCCCC0C0C0C0C0C0
        B2B2B2C0C0C0CCCCCCD7D7D7D7D7D7C0C0C07777773333660000803333668080
        80868686999999CBCBCBD7D7D7D7D7D7DDDDDDDDDDDDCCCCCCCCCCCCCCCCCCCC
        CCCC999999666699333399333366777777868686999999CBCBCBCCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCCCCCCB2B2B23333993366
        99B2B2B2CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCC0C0C0C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        CCCCCCC5C5C5CCCCCCCFCFCFCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCD7D7D7D7D7
        D7CCCCCCCCCCCCCCCCCC}
      OnClick = btnDeleteClick
    end
  end
  object edtSundayCapacityHrs: TMaskEdit [26]
    Left = 312
    Top = 142
    Width = 68
    Height = 23
    HelpContext = 189036
    EditMask = '!90:00:00;1; '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 8
    ParentFont = False
    TabOrder = 5
    Text = '  :  :  '
    OnChange = edtSundayCapacityHrsChange
    OnEnter = edtSundayCapacityHrsEnter
    OnExit = edtSundayCapacityHrsExit
  end
  object edSetupHours: TMaskEdit [27]
    Left = 128
    Top = 127
    Width = 73
    Height = 23
    HelpContext = 189037
    EditMask = '!90:00:00;1; '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 8
    ParentFont = False
    TabOrder = 0
    Text = '  :  :  '
    OnEnter = edSetupHoursEnter
    OnExit = edSetupHoursExit
  end
  object edBreakdownHours: TMaskEdit [28]
    Left = 128
    Top = 167
    Width = 73
    Height = 23
    HelpContext = 189038
    EditMask = '!90:00:00;1; '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 8
    ParentFont = False
    TabOrder = 1
    Text = '  :  :  '
    OnEnter = edBreakdownHoursEnter
    OnExit = edBreakdownHoursExit
  end
  object edtHourlyRate: TwwDBEdit [29]
    Left = 128
    Top = 212
    Width = 73
    Height = 23
    HelpContext = 189025
    DataField = 'HourlyLabourRate'
    DataSource = dsProcResource
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
    OnEnter = edtHourlyRateEnter
  end
  object edtHourlyOverheadRate: TwwDBEdit [30]
    Left = 128
    Top = 248
    Width = 73
    Height = 23
    HelpContext = 189026
    DataField = 'HourlyOverheadRate'
    DataSource = dsProcResource
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
    OnEnter = edtHourlyOverheadRateEnter
  end
  object chkMonday: TwwCheckBox [31]
    Left = 215
    Top = 174
    Width = 90
    Height = 17
    HelpContext = 189039
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Alignment = taLeftJustify
    Caption = 'Monday'
    DataField = 'Monday'
    DataSource = dsProcResourcedays
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object chkTuesday: TwwCheckBox [32]
    Left = 215
    Top = 204
    Width = 90
    Height = 17
    HelpContext = 189040
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Alignment = taLeftJustify
    Caption = 'Tuesday'
    DataField = 'Tuesday'
    DataSource = dsProcResourcedays
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
  end
  object chkWednesday: TwwCheckBox [33]
    Left = 215
    Top = 234
    Width = 90
    Height = 17
    HelpContext = 189041
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Alignment = taLeftJustify
    Caption = 'Wednesday'
    DataField = 'Wednesday'
    DataSource = dsProcResourcedays
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
  end
  object chkThursday: TwwCheckBox [34]
    Left = 215
    Top = 263
    Width = 90
    Height = 17
    HelpContext = 189042
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Alignment = taLeftJustify
    Caption = 'Thursday'
    DataField = 'Thursday'
    DataSource = dsProcResourcedays
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 16
  end
  object chkSunday: TwwCheckBox [35]
    Left = 214
    Top = 145
    Width = 90
    Height = 17
    HelpContext = 189043
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Alignment = taLeftJustify
    Caption = 'Sunday'
    DataField = 'Sunday'
    DataSource = dsProcResourcedays
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 41
  end
  object chkSaturday: TwwCheckBox [36]
    Left = 215
    Top = 323
    Width = 90
    Height = 17
    HelpContext = 189044
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Alignment = taLeftJustify
    Caption = 'Saturday'
    DataField = 'Saturday'
    DataSource = dsProcResourcedays
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 22
  end
  object chkfriday: TwwCheckBox [37]
    Left = 215
    Top = 293
    Width = 90
    Height = 17
    HelpContext = 189045
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Alignment = taLeftJustify
    Caption = 'Friday'
    DataField = 'Friday'
    DataSource = dsProcResourcedays
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 19
  end
  object edtmondayCapacityHrs: TMaskEdit [38]
    Left = 312
    Top = 171
    Width = 68
    Height = 23
    HelpContext = 189046
    EditMask = '!90:00:00;1; '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 8
    ParentFont = False
    TabOrder = 8
    Text = '  :  :  '
    OnChange = edtSundayCapacityHrsChange
    OnEnter = edtSundayCapacityHrsEnter
    OnExit = edtmondayCapacityHrsExit
  end
  object edtTuesdayCapacityHrs: TMaskEdit [39]
    Left = 312
    Top = 201
    Width = 68
    Height = 23
    HelpContext = 189047
    EditMask = '!90:00:00;1; '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 8
    ParentFont = False
    TabOrder = 11
    Text = '  :  :  '
    OnChange = edtSundayCapacityHrsChange
    OnEnter = edtSundayCapacityHrsEnter
    OnExit = edtTuesdayCapacityHrsExit
  end
  object edtWednesdayCapacityHrs: TMaskEdit [40]
    Left = 312
    Top = 231
    Width = 68
    Height = 23
    HelpContext = 189048
    EditMask = '!90:00:00;1; '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 8
    ParentFont = False
    TabOrder = 14
    Text = '  :  :  '
    OnChange = edtSundayCapacityHrsChange
    OnEnter = edtSundayCapacityHrsEnter
    OnExit = edtWednesdayCapacityHrsExit
  end
  object edtThursdayCapacityHrs: TMaskEdit [41]
    Left = 312
    Top = 260
    Width = 68
    Height = 23
    HelpContext = 189049
    EditMask = '!90:00:00;1; '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 8
    ParentFont = False
    TabOrder = 17
    Text = '  :  :  '
    OnChange = edtSundayCapacityHrsChange
    OnEnter = edtSundayCapacityHrsEnter
    OnExit = edtThursdayCapacityHrsExit
  end
  object edtFridayCapacityHrs: TMaskEdit [42]
    Left = 312
    Top = 290
    Width = 68
    Height = 23
    HelpContext = 189050
    EditMask = '!90:00:00;1; '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 8
    ParentFont = False
    TabOrder = 20
    Text = '  :  :  '
    OnChange = edtSundayCapacityHrsChange
    OnEnter = edtSundayCapacityHrsEnter
    OnExit = edtFridayCapacityHrsExit
  end
  object edtSAturdayCapacityHrs: TMaskEdit [43]
    Left = 312
    Top = 320
    Width = 68
    Height = 23
    HelpContext = 189051
    EditMask = '!90:00:00;1; '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 8
    ParentFont = False
    TabOrder = 23
    Text = '  :  :  '
    OnChange = edtSundayCapacityHrsChange
    OnEnter = edtSundayCapacityHrsEnter
    OnExit = edtSAturdayCapacityHrsExit
  end
  object dtSundayStartAt: TwwDBDateTimePicker [44]
    Left = 387
    Top = 142
    Width = 68
    Height = 23
    HelpContext = 189052
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'SundayStartAt'
    DataSource = dsProcResourcedays
    Epoch = 1950
    Time = 0.354166666666666700
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 6
    DisplayFormat = 'hh:mm am/pm'
    OnDblClick = dtSundayStartAtDblClick
    OnEnter = dtSundayStartAtEnter
    OnExit = dtSundayStartAtExit
  end
  object dtTuesdayStartAt: TwwDBDateTimePicker [45]
    Left = 387
    Top = 201
    Width = 68
    Height = 23
    HelpContext = 189053
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'TuesdayStartAt'
    DataSource = dsProcResourcedays
    Epoch = 1950
    Time = 0.354166666666666700
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 12
    DisplayFormat = 'hh:mm am/pm'
    OnDblClick = dtTuesdayStartAtDblClick
    OnEnter = dtSundayStartAtEnter
    OnExit = dtTuesdayStartAtExit
  end
  object dtWednesdayStartAt: TwwDBDateTimePicker [46]
    Left = 387
    Top = 231
    Width = 68
    Height = 23
    HelpContext = 189054
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'WednesdayStartAt'
    DataSource = dsProcResourcedays
    Epoch = 1950
    Time = 0.354166666666666700
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 15
    DisplayFormat = 'hh:mm am/pm'
    OnDblClick = dtWednesdayStartAtDblClick
    OnEnter = dtSundayStartAtEnter
    OnExit = dtWednesdayStartAtExit
  end
  object dtThursdayStartAt: TwwDBDateTimePicker [47]
    Left = 387
    Top = 260
    Width = 68
    Height = 23
    HelpContext = 189055
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'ThursdayStartAt'
    DataSource = dsProcResourcedays
    Epoch = 1950
    Time = 0.354166666666666700
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 18
    DisplayFormat = 'hh:mm am/pm'
    OnDblClick = dtThursdayStartAtDblClick
    OnEnter = dtSundayStartAtEnter
    OnExit = dtThursdayStartAtExit
  end
  object dtFridayStartAt: TwwDBDateTimePicker [48]
    Left = 387
    Top = 290
    Width = 68
    Height = 23
    HelpContext = 189056
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'FridayStartAt'
    DataSource = dsProcResourcedays
    Epoch = 1950
    Time = 0.354166666666666700
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 21
    DisplayFormat = 'hh:mm am/pm'
    OnDblClick = dtFridayStartAtDblClick
    OnEnter = dtSundayStartAtEnter
    OnExit = dtFridayStartAtExit
  end
  object dtSaturdayStartAt: TwwDBDateTimePicker [49]
    Left = 387
    Top = 320
    Width = 68
    Height = 23
    HelpContext = 189057
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'SaturdayStartAt'
    DataSource = dsProcResourcedays
    Epoch = 1950
    Time = 0.354166666666666700
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 24
    DisplayFormat = 'hh:mm am/pm'
    OnDblClick = dtSaturdayStartAtDblClick
    OnEnter = dtSundayStartAtEnter
    OnExit = dtSaturdayStartAtExit
  end
  object dtMondayStartAt: TwwDBDateTimePicker [50]
    Left = 387
    Top = 171
    Width = 68
    Height = 23
    HelpContext = 189058
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'MondaystartAt'
    DataSource = dsProcResourcedays
    Epoch = 1950
    Time = 0.354166666666666700
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 9
    DisplayFormat = 'hh:mm am/pm'
    OnDblClick = dtMondayStartAtDblClick
    OnEnter = dtSundayStartAtEnter
    OnExit = dtMondayStartAtExit
  end
  object btnCopyTime: TDNMSpeedButton [51]
    Left = 540
    Top = 140
    Width = 74
    Height = 27
    HelpContext = 189075
    Caption = 'Copy to All'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 26
    AutoDisableParentOnclick = True
    OnClick = btnCopyTimeClick
  end
  object edtResourceCount: TwwDBEdit [52]
    Left = 128
    Top = 294
    Width = 73
    Height = 23
    HelpContext = 189019
    DataField = 'ResourceCount'
    DataSource = dsProcResource
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 27
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object cboFixedAsset: TwwDBLookupCombo [53]
    Left = 314
    Top = 379
    Width = 151
    Height = 23
    HelpContext = 189035
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'AssetName'#9'20'#9'Name'#9'F')
    DataField = 'FixedAsset'
    DataSource = dsProcResourceDetails
    LookupTable = qryfixedassets
    LookupField = 'AssetID'
    ParentFont = False
    TabOrder = 28
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnBeforeDropDown = cboStepDescriptionBeforeDropDown
    OnNotInList = cboStepDescriptionNotInList
  end
  object DNMPanel1: TDNMPanel [54]
    AlignWithMargins = True
    Left = 3
    Top = 356
    Width = 827
    Height = 154
    HelpContext = 189078
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 29
    object grdProcResourceDetails: TwwDBGrid
      Left = 1
      Top = 1
      Width = 409
      Height = 152
      HelpContext = 189079
      Margins.Left = 8
      Margins.Right = 8
      ControlType.Strings = (
        'ProcessStepDescription;CustomEdit;cboStepDescription;F'
        'ProcessStepActive;CheckBox;T;F'
        'Active;CheckBox;T;F'
        'ResourceAvailable;CheckBox;T;F'
        'ClosedOnPublicHolidays;CheckBox;T;F'
        'closedOnWeekends;CheckBox;T;F'
        'FixedAsset;CustomEdit;cboFixedAsset;F'
        'UOMDetails;CustomEdit;cboUnitOfMeasure;F')
      Selected.Strings = (
        'Description'#9'10'#9'Description'#9#9
        'FixedAsset'#9'10'#9'FixedAsset'#9#9
        'ResourceAvailable'#9'1'#9'Resource~Available ?'#9#9
        'ClosedOnPublicHolidays'#9'1'#9'Public Holidays?'#9#9
        'Active'#9'1'#9'Active ?'#9#9
        'NoOfResources'#9'10'#9'No'#9#9
        'UOMQty'#9'10'#9'Qty'#9#9
        'UOMDetails'#9'10'#9'Name'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      Align = alClient
      DataSource = dsProcResourceDetails
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = False
      OnEnter = grdStepsEnter
      OnExit = grdStepsExit
      FooterColor = clWhite
      object wwIButton1: TwwIButton
        Left = 0
        Top = 0
        Width = 22
        Height = 22
        HelpContext = 189080
        AllowAllUp = True
        Glyph.Data = {
          C6030000424DC603000000000000360000002800000010000000130000000100
          18000000000090030000120B0000120B00000000000000000000CCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC0C0C0CBCBCBCBCBCBCBCBCBCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCBCBCBCBCBCBCCCCCCD7D7D7C0C0C0
          666699969696969696999999CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCB9999
          99868686999999CBCBCBDDDDDDB2B2B2333399666666777777868686C0C0C0CC
          CCCCCCCCCCCCCCCCCCCCCCCBCBCB777777666666868686CBCBCBDDDDDDB2B2B2
          333399333366666666808080969696CBCBCBCCCCCCCCCCCCD7D7D7C0C0C03333
          99777777999999CBCBCBD7D7D7CBCBCB808080333366000080333366868686C0
          C0C0CCCCCCCCCCCCC0C0C0808080333399B2B2B2D7D7D7CCCCCCCBCBCBE6E6E6
          C0C0C0333399000080333366808080999999C0C0C06666993333993333667777
          77C0C0C0D7D7D7CCCCCCC9CACBCCCCCCCCCCCC33339900008033339966666686
          8686B2B2B2333399000080333366969696CBCBCBD7D7D7CCCCCCCBCBCCCCCCCC
          B2B2B2808080333366000080333366777777777777333366000080333399C0C0
          C0CCCCCCCCCCCCCCCCCCCACACCCCCCCCCCCCCCC0C0C033339900008000008000
          0080000080000080333399C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC9C9CBCCCCCC
          CCCCD1CCCCCC9696966666660000800000800000805F5F5F969696CCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCC7C7C9C0C0C0C0C0C096969666666600008000
          0080333366777777999999C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC3C3CCB8B8B8
          868686808080666699333399333399000080333366666666808080969696C0C0
          C0CCCCCCCCCCCCCCCCCCA4A0A0868686333399666699B2B2B2CCCCCCC0C0C080
          8080333366333366333366777777969696C0C0C0CCCCCCCCCCCCC0C0C0C0C0C0
          B2B2B2C0C0C0CCCCCCD7D7D7D7D7D7C0C0C07777773333660000803333668080
          80868686999999CBCBCBD7D7D7D7D7D7DDDDDDDDDDDDCCCCCCCCCCCCCCCCCCCC
          CCCC999999666699333399333366777777868686999999CBCBCBCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCCCCCCB2B2B23333993366
          99B2B2B2CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCC0C0C0C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCC5C5C5CCCCCCCFCFCFCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCD7D7D7D7D7
          D7CCCCCCCCCCCCCCCCCC}
        OnClick = wwIButton1Click
      end
    end
    object pnlResDetDet: TDNMPanel
      Left = 410
      Top = 1
      Width = 416
      Height = 152
      HelpContext = 189081
      Align = alRight
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object DBText1: TDBText
        Left = 1
        Top = 1
        Width = 414
        Height = 15
        HelpContext = 189082
        Align = alTop
        Alignment = taCenter
        AutoSize = True
        DataField = 'RDUnAvailDescriptionCaption'
        DataSource = dsProcResourceDetails
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        ExplicitWidth = 47
      end
      object pgResDetailsRelated: TPageControl
        Left = 1
        Top = 16
        Width = 414
        Height = 135
        ActivePage = tabUnavailaibility
        Align = alClient
        TabOrder = 0
        OnResize = pgResDetailsRelatedResize
        object tabUnavailaibility: TTabSheet
          Caption = 'Un-Avaiability'
          object grdUnavailaibility: TwwDBGrid
            Left = 0
            Top = 0
            Width = 406
            Height = 105
            HelpContext = 189083
            Margins.Top = 8
            Margins.Bottom = 8
            Selected.Strings = (
              'Description'#9'10'#9'Description'
              'TimeStart'#9'20'#9'TimeStart'
              'TimeEnd'#9'20'#9'TimeEnd')
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            Align = alClient
            DataSource = dsprocresourceUnavailability
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = [dgAllowInsert]
            ParentFont = False
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = False
            OnEnter = grdStepsEnter
            OnExit = grdStepsExit
            FooterColor = clWhite
            object wwIButton2: TwwIButton
              Left = 0
              Top = 0
              Width = 22
              Height = 22
              HelpContext = 189084
              AllowAllUp = True
              Glyph.Data = {
                C6030000424DC603000000000000360000002800000010000000130000000100
                18000000000090030000120B0000120B00000000000000000000CCCCCCCCCCCC
                CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
                CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC0C0C0CBCBCBCBCBCBCBCBCBCCCCCCCC
                CCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCBCBCBCBCBCBCCCCCCD7D7D7C0C0C0
                666699969696969696999999CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCB9999
                99868686999999CBCBCBDDDDDDB2B2B2333399666666777777868686C0C0C0CC
                CCCCCCCCCCCCCCCCCCCCCCCBCBCB777777666666868686CBCBCBDDDDDDB2B2B2
                333399333366666666808080969696CBCBCBCCCCCCCCCCCCD7D7D7C0C0C03333
                99777777999999CBCBCBD7D7D7CBCBCB808080333366000080333366868686C0
                C0C0CCCCCCCCCCCCC0C0C0808080333399B2B2B2D7D7D7CCCCCCCBCBCBE6E6E6
                C0C0C0333399000080333366808080999999C0C0C06666993333993333667777
                77C0C0C0D7D7D7CCCCCCC9CACBCCCCCCCCCCCC33339900008033339966666686
                8686B2B2B2333399000080333366969696CBCBCBD7D7D7CCCCCCCBCBCCCCCCCC
                B2B2B2808080333366000080333366777777777777333366000080333399C0C0
                C0CCCCCCCCCCCCCCCCCCCACACCCCCCCCCCCCCCC0C0C033339900008000008000
                0080000080000080333399C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC9C9CBCCCCCC
                CCCCD1CCCCCC9696966666660000800000800000805F5F5F969696CCCCCCCCCC
                CCCCCCCCCCCCCCCCCCCCCCCCCCC7C7C9C0C0C0C0C0C096969666666600008000
                0080333366777777999999C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC3C3CCB8B8B8
                868686808080666699333399333399000080333366666666808080969696C0C0
                C0CCCCCCCCCCCCCCCCCCA4A0A0868686333399666699B2B2B2CCCCCCC0C0C080
                8080333366333366333366777777969696C0C0C0CCCCCCCCCCCCC0C0C0C0C0C0
                B2B2B2C0C0C0CCCCCCD7D7D7D7D7D7C0C0C07777773333660000803333668080
                80868686999999CBCBCBD7D7D7D7D7D7DDDDDDDDDDDDCCCCCCCCCCCCCCCCCCCC
                CCCC999999666699333399333366777777868686999999CBCBCBCCCCCCCCCCCC
                CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCCCCCCB2B2B23333993366
                99B2B2B2CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
                CCCCCCCCCCCCCCCCCCCCCCC0C0C0C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
                CCCCCCC5C5C5CCCCCCCFCFCFCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCD7D7D7D7D7
                D7CCCCCCCCCCCCCCCCCC}
              OnClick = wwIButton2Click
            end
          end
        end
        object TabProducts: TTabSheet
          Caption = 'Products'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
      end
    end
    object cboUnitOfMeasure: TwwDBLookupCombo
      Left = 220
      Top = 36
      Width = 85
      Height = 26
      AutoSize = False
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'UnitName'#9'15'#9'UnitName'#9'F')
      DataField = 'UOMDetails'
      DataSource = dsProcResourceDetails
      LookupTable = qryUnitOfMeasure
      LookupField = 'UnitID'
      Style = csDropDownList
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboUnitOfMeasureCloseUp
      OnNotInList = cboUnitOfMeasureNotInList
    end
  end
  object edtTotSundayCapacityHrs: TEdit [55]
    Left = 462
    Top = 142
    Width = 66
    Height = 23
    HelpContext = 189090
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 30
    OnEnter = edtSundayCapacityHrsEnter
    OnExit = edtSundayCapacityHrsExit
  end
  object edtTotmondayCapacityHrs: TEdit [56]
    Left = 462
    Top = 171
    Width = 66
    Height = 23
    HelpContext = 189091
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 31
    OnEnter = edtSundayCapacityHrsEnter
    OnExit = edtmondayCapacityHrsExit
  end
  object edttotTuesdayCapacityHrs: TEdit [57]
    Left = 462
    Top = 201
    Width = 66
    Height = 23
    HelpContext = 189092
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 32
    OnEnter = edtSundayCapacityHrsEnter
    OnExit = edtTuesdayCapacityHrsExit
  end
  object edttotWednesdayCapacityHrs: TEdit [58]
    Left = 462
    Top = 231
    Width = 66
    Height = 23
    HelpContext = 189093
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 33
    OnEnter = edtSundayCapacityHrsEnter
    OnExit = edtWednesdayCapacityHrsExit
  end
  object edttotThursdayCapacityHrs: TEdit [59]
    Left = 462
    Top = 260
    Width = 66
    Height = 23
    HelpContext = 189094
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 34
    OnEnter = edtSundayCapacityHrsEnter
    OnExit = edtThursdayCapacityHrsExit
  end
  object edttotFridayCapacityHrs: TEdit [60]
    Left = 462
    Top = 290
    Width = 66
    Height = 23
    HelpContext = 189095
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 35
    OnEnter = edtSundayCapacityHrsEnter
    OnExit = edtFridayCapacityHrsExit
  end
  object edttotSAturdayCapacityHrs: TEdit [61]
    Left = 462
    Top = 320
    Width = 66
    Height = 23
    HelpContext = 189096
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 36
    OnEnter = edtSundayCapacityHrsEnter
    OnExit = edtSAturdayCapacityHrsExit
  end
  inherited pnltop: TDNMPanel
    Width = 833
    TabOrder = 37
    ExplicitWidth = 833
    object chkAvailable: TDBCheckBox
      Left = 688
      Top = 16
      Width = 137
      Height = 23
      HelpContext = 189022
      Alignment = taLeftJustify
      Caption = 'Resource Available?'
      DataField = 'ResourceAvailable'
      DataSource = dsProcResource
      TabOrder = 1
      ValueChecked = 'T'
      ValueUnchecked = 'F'
    end
    object DBCheckBox1: TDBCheckBox
      Left = 648
      Top = 36
      Width = 177
      Height = 23
      HelpContext = 189085
      Alignment = taLeftJustify
      Caption = 'Closed On Public holidays? '
      DataField = 'ClosedOnPublicHolidays'
      DataSource = dsProcResource
      TabOrder = 2
      ValueChecked = 'T'
      ValueUnchecked = 'F'
    end
  end
  inherited PnlRes: TDNMPanel
    Width = 833
    TabOrder = 38
    ExplicitWidth = 833
    inherited edtDescription: TwwDBEdit
      Width = 438
      ExplicitWidth = 438
    end
    inherited chkUsedWithProductsInSeq: TDBCheckBox
      Left = 703
      Width = 126
      ExplicitLeft = 703
      ExplicitWidth = 126
    end
  end
  inherited pnlButtons: TDNMPanel
    Top = 513
    Width = 833
    TabOrder = 39
    ExplicitTop = 513
    ExplicitWidth = 833
    DesignSize = (
      833
      50)
    inherited btnSave: TDNMSpeedButton
      Action = nil
    end
    object btnAutoSelect: TDNMSpeedButton [3]
      Left = 312
      Top = 9
      Width = 87
      Height = 27
      HelpContext = 189074
      Anchors = [akBottom]
      Caption = 'Auto Roster'
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
      TabOrder = 3
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnAutoSelectClick
    end
    inherited chkActive: TwwCheckBox
      TabOrder = 4
    end
  end
  inherited cboProcessStepDesc: TwwDBLookupCombo
    TabOrder = 40
  end
  inherited pnlcolorDetails: TDNMPanel
    Left = 759
    Top = 8
    Width = 82
    Height = 65
    ExplicitLeft = 759
    ExplicitTop = 8
    ExplicitWidth = 82
    ExplicitHeight = 65
    inherited lblNoOfResources: TLabel
      Top = 46
      Width = 48
      ExplicitLeft = 49
      ExplicitTop = 46
    end
    inherited pnlcolmove: TDNMPanel
      Left = 52
      Height = 44
      ExplicitLeft = 52
      ExplicitHeight = 44
    end
    inherited grdProcResourceProducts: TwwDBGrid
      Width = 51
      Height = 44
      ExplicitWidth = 51
      ExplicitHeight = 44
    end
  end
  inherited qryProcResourcedays: TERPQuery
    Left = 176
    object qryProcResourcedaysSundayTotCapacityHoursDay: TFloatField
      FieldKind = fkCalculated
      FieldName = 'SundayTotCapacityHoursDay'
      Origin = 'tblprocresourcedays.SundayTotCapacityHoursDay'
      Calculated = True
    end
    object qryProcResourcedaysMondayTotCapacityHoursDay: TFloatField
      FieldKind = fkCalculated
      FieldName = 'MondayTotCapacityHoursDay'
      Origin = 'tblprocresourcedays.MondayTotCapacityHoursDay'
      Calculated = True
    end
    object qryProcResourcedaysTuesdayTotCapacityHoursDay: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TuesdayTotCapacityHoursDay'
      Origin = 'tblprocresourcedays.TuesdayTotCapacityHoursDay'
      Calculated = True
    end
    object qryProcResourcedaysWednesdayTotCapacityHoursDay: TFloatField
      FieldKind = fkCalculated
      FieldName = 'WednesdayTotCapacityHoursDay'
      Origin = 'tblprocresourcedays.WednesdayTotCapacityHoursDay'
      Calculated = True
    end
    object qryProcResourcedaysThursdayTotCapacityHoursDay: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ThursdayTotCapacityHoursDay'
      Origin = 'tblprocresourcedays.ThursdayTotCapacityHoursDay'
      Calculated = True
    end
    object qryProcResourcedaysFridayTotCapacityHoursDay: TFloatField
      FieldKind = fkCalculated
      FieldName = 'FridayTotCapacityHoursDay'
      Origin = 'tblprocresourcedays.FridayTotCapacityHoursDay'
      Calculated = True
    end
    object qryProcResourcedaysSaturdayTotCapacityHoursDay: TFloatField
      FieldKind = fkCalculated
      FieldName = 'SaturdayTotCapacityHoursDay'
      Origin = 'tblprocresourcedays.SaturdayTotCapacityHoursDay'
      Calculated = True
    end
  end
  object mnuRepeatUnavailability: TAdvPopupMenu
    OnPopup = mnuRepeatUnavailabilityPopup
    Version = '2.5.3.4'
    Left = 685
    Top = 373
    object mnuRepeatUnavailabilityWeek: TMenuItem
      Caption = 'Next Week'
      HelpContext = 189097
      OnClick = RepeatUnAvailability
    end
    object mnuRepeatUnavailabilityMonth: TMenuItem
      Caption = 'Next Month'
      HelpContext = 189098
      OnClick = RepeatUnAvailability
    end
    object mnuRepeatUnavailabilityYEar: TMenuItem
      Caption = 'Next Year'
      HelpContext = 189099
      OnClick = RepeatUnAvailability
    end
  end
end
