inherited frmAwards: TfrmAwards
  Left = 1348
  Top = 149
  Caption = 'Award'
  ClientHeight = 557
  ClientWidth = 747
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object Label143: TLabel [0]
    Left = 695
    Top = 517
    Width = 35
    Height = 15
    Alignment = taCenter
    Caption = 'Active'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object btnSave: TDNMSpeedButton [2]
    Left = 143
    Top = 524
    Width = 87
    Height = 27
    Caption = '&Save'
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
    TabOrder = 3
    OnClick = btnSaveClick
  end
  object btnCancel: TDNMSpeedButton [3]
    Left = 523
    Top = 524
    Width = 87
    Height = 27
    Cancel = True
    Caption = '&Cancel'
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
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    TabOrder = 4
    OnClick = btnCancelClick
  end
  object btnNew: TDNMSpeedButton [4]
    Left = 333
    Top = 524
    Width = 87
    Height = 27
    Caption = '&New'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 5
    OnClick = btnNewClick
  end
  object PageControl1: TPageControl [5]
    Left = 13
    Top = 79
    Width = 720
    Height = 432
    ActivePage = AwardPayment
    TabHeight = 25
    TabIndex = 1
    TabOrder = 0
    TabWidth = 358
    object Standard: TTabSheet
      Caption = 'S&tandard Details'
      object DNMPanel1: TDNMPanel
        Left = 0
        Top = 0
        Width = 712
        Height = 397
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Bevel5: TBevel
          Left = 14
          Top = 332
          Width = 691
          Height = 58
          Shape = bsFrame
        end
        object Bevel2: TBevel
          Left = 15
          Top = 7
          Width = 313
          Height = 141
          Shape = bsFrame
        end
        object Bevel3: TBevel
          Left = 367
          Top = 7
          Width = 337
          Height = 140
          Shape = bsFrame
        end
        object Label1: TLabel
          Left = 21
          Top = 28
          Width = 73
          Height = 15
          Caption = 'Award Name'
          Transparent = True
        end
        object Label2: TLabel
          Left = 21
          Top = 72
          Width = 67
          Height = 15
          Caption = 'Department'
          Transparent = True
        end
        object Label3: TLabel
          Left = 21
          Top = 116
          Width = 61
          Height = 15
          Caption = 'Pay Period'
          Transparent = True
        end
        object Label4: TLabel
          Left = 395
          Top = 19
          Width = 64
          Height = 15
          Caption = 'Super Type'
          Transparent = True
        end
        object Label5: TLabel
          Left = 395
          Top = 53
          Width = 69
          Height = 15
          Caption = 'Super Value'
          Transparent = True
        end
        object Label6: TLabel
          Left = 227
          Top = 337
          Width = 136
          Height = 15
          Caption = 'Annual Leave Loading %'
          Transparent = True
        end
        object Label7: TLabel
          Left = 412
          Top = 337
          Width = 101
          Height = 15
          Caption = 'Meal Break Hours'
          Transparent = True
        end
        object Label8: TLabel
          Left = 561
          Top = 337
          Width = 124
          Height = 15
          Caption = 'Meal Break Threshold'
          Transparent = True
          WordWrap = True
        end
        object Label9: TLabel
          Left = 423
          Top = 124
          Width = 162
          Height = 15
          Alignment = taCenter
          Caption = 'Pay Super On Leave Loading'
          Transparent = True
          WordWrap = True
        end
        object Label10: TLabel
          Left = 395
          Top = 84
          Width = 94
          Height = 30
          Caption = 'Use Default    Super Threshold'
          Transparent = True
          WordWrap = True
        end
        object Label11: TLabel
          Left = 519
          Top = 96
          Width = 17
          Height = 15
          Caption = 'OR'
          Transparent = True
        end
        object Label12: TLabel
          Left = 31
          Top = 338
          Width = 145
          Height = 15
          Caption = 'Sick days leave threshold'
          Transparent = True
        end
        object Loading: TwwDBEdit
          Left = 227
          Top = 358
          Width = 68
          Height = 23
          DataField = 'AnnualLeaveLoading'
          DataSource = DSAwards
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnExit = LoadingExit
        end
        object AwardName: TDBEdit
          Left = 104
          Top = 24
          Width = 206
          Height = 23
          DataField = 'AwardName'
          DataSource = DSAwards
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnExit = AwardNameExit
        end
        object PayPeriod: TDBComboBox
          Left = 104
          Top = 112
          Width = 145
          Height = 23
          Style = csDropDownList
          DataField = 'PayPeriod'
          DataSource = DSAwards
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 15
          Items.Strings = (
            'Weekly'
            'Fortnightly'
            'Monthly')
          ParentFont = False
          TabOrder = 2
        end
        object SuperType: TDBComboBox
          Left = 548
          Top = 16
          Width = 92
          Height = 23
          Style = csDropDownList
          DataField = 'SuperType'
          DataSource = DSAwards
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 15
          Items.Strings = (
            'Percentage'
            'Amount')
          ParentFont = False
          TabOrder = 3
          OnChange = SuperTypeChange
        end
        object grdLeave: TwwDBGrid
          Left = 14
          Top = 159
          Width = 691
          Height = 165
          ControlType.Strings = (
            'Type;CustomEdit;cboLeave;F'
            'AccrueAfterPeriod;CustomEdit;AccrueAfterPeriod;T'
            'AccruePeriod;CustomEdit;AccruePeriod;T'
            'AwardStartDate;CustomEdit;dtpAwardStartDate;T'
            'AwardEndDate;CustomEdit;dtpAwardEndDate;T'
            'UseStartEndDates;CustomEdit;chkUseStartEndDates;T')
          Selected.Strings = (
            'Type'#9'14'#9'~Leave Type'#9'F'
            'AccrueAfterNo'#9'5'#9'Number'#9'F'#9'Accrue After'
            'AccrueAfterPeriod'#9'6'#9'Period'#9'F'#9'Accrue After'
            'AccrueNo'#9'5'#9'Every'#9'F'#9'Accrue'
            'AccruePeriod'#9'7'#9'Period'#9'F'#9'Accrue'
            'AccrueHours'#9'11'#9'Hours'#9'F'#9'Accrue'
            'LeaveLoading'#9'9'#9'Loading'#9'F'
            'UseStartEndDates'#9'10'#9'Use Dates'#9'F'#9'Accrue between Dates'
            'AwardStartDate'#9'10'#9'Start'#9'F'#9'Accrue between Dates'
            'AwardEndDate'#9'8'#9'Finish'#9'F'#9'Accrue between Dates')
          IniAttributes.Delimiter = ';;'
          TitleColor = 15785701
          FixedCols = 0
          ShowHorzScrollBar = True
          DataSource = DSLeave
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgProportionalColResize]
          ParentFont = False
          TabOrder = 6
          TitleAlignment = taCenter
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 2
          TitleButtons = True
          UseTFields = False
          OnExit = grdLeaveExit
          object wwDBGrid1IButton: TwwIButton
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
            OnClick = wwDBGrid1IButtonClick
          end
        end
        object AccrueAfterPeriod: TwwDBComboBox
          Left = 291
          Top = 222
          Width = 53
          Height = 23
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
          TabOrder = 7
          UnboundDataType = wwDefault
        end
        object AccruePeriod: TwwDBComboBox
          Left = 423
          Top = 224
          Width = 60
          Height = 23
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
            'Week'
            'Month'
            'Year'
            'Birthday')
          ItemIndex = 0
          ParentFont = False
          Sorted = False
          TabOrder = 8
          UnboundDataType = wwDefault
        end
        object cboDepartment: TwwDBLookupCombo
          Left = 104
          Top = 68
          Width = 209
          Height = 23
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'ClassName'#9'30'#9'ClassName'#9'F')
          DataField = 'ClassID'
          DataSource = DSAwards
          LookupTable = qryDepartments
          LookupField = 'ClassID'
          ParentFont = False
          TabOrder = 1
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
        end
        object SuperValue: TwwDBEdit
          Left = 548
          Top = 49
          Width = 68
          Height = 23
          DataField = 'SuperValue'
          DataSource = DSAwards
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object wwDBEdit1: TwwDBEdit
          Left = 412
          Top = 358
          Width = 68
          Height = 23
          DataField = 'MealBreakHours'
          DataSource = DSAwards
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
        object wwDBEdit2: TwwDBEdit
          Left = 561
          Top = 358
          Width = 68
          Height = 23
          DataField = 'MealBreakThreshold'
          DataSource = DSAwards
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object cboLeave: TwwDBLookupCombo
          Left = 54
          Top = 223
          Width = 121
          Height = 23
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          DataField = 'Type'
          LookupTable = qryLeaveTypes
          LookupField = 'LeaveType'
          DropDownWidth = 40
          ParentFont = False
          TabOrder = 11
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
          OnCloseUp = cboLeaveCloseUp
          OnNotInList = cboLeaveNotInList
        end
        object wwCheckBox2: TwwCheckBox
          Left = 495
          Top = 95
          Width = 13
          Height = 13
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
          DataField = 'UseCompanySuperThreshold'
          DataSource = DSAwards
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 12
          OnClick = wwCheckBox2Click
        end
        object txtSuperThresholdAmount: TwwDBEdit
          Left = 548
          Top = 89
          Width = 68
          Height = 23
          DataField = 'SuperThresholdAmount'
          DataSource = DSAwards
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object dtpAwardStartDate: TwwDBDateTimePicker
          Left = 304
          Top = 240
          Width = 81
          Height = 23
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          DataField = 'AwardStartDate'
          DataSource = DSLeave
          Epoch = 1950
          ShowButton = True
          TabOrder = 14
        end
        object dtpAwardEndDate: TwwDBDateTimePicker
          Left = 400
          Top = 248
          Width = 66
          Height = 23
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          DataField = 'AwardEndDate'
          DataSource = DSLeave
          Epoch = 1950
          ShowButton = True
          TabOrder = 15
        end
        object chkUseStartEndDates: TwwCheckBox
          Left = 474
          Top = 207
          Width = 77
          Height = 18
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
          TabOrder = 16
          Visible = False
        end
        object wwCheckBox1: TwwCheckBox
          Left = 395
          Top = 122
          Width = 15
          Height = 16
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
          DataField = 'PaySuperOnLeaveLoading'
          DataSource = DSAwards
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 17
        end
        object edSickDaysThreshold: TwwDBEdit
          Left = 32
          Top = 357
          Width = 80
          Height = 23
          DataField = 'SickLeaveDaysThreshold'
          DataSource = DSAwards
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 18
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
      end
    end
    object AwardPayment: TTabSheet
      Caption = '&Award Payment Details'
      ImageIndex = 1
      object DNMPanel2: TDNMPanel
        Left = 0
        Top = 0
        Width = 712
        Height = 397
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object lblClassifications: TLabel
          Left = 9
          Top = 5
          Width = 85
          Height = 15
          Caption = 'Classifications'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic, fsUnderline]
          ParentFont = False
          Transparent = True
        end
        object grdClassification: TwwDBGrid
          Tag = 1
          Left = 7
          Top = 19
          Width = 696
          Height = 170
          ControlType.Strings = (
            'Type;CustomEdit;ClassificationType;T'
            'Description;CustomEdit;AdvanceID;T'
            'Classification;CustomEdit;edClassification;F'
            'Description;CustomEdit;AdvanceID;F'
            'AdvanceID;CustomEdit;cboAdvanceID;F'
            'AdvanceIDName;CustomEdit;cboAdvanceID;F'
            'AdvanceToClassification;CustomEdit;cboNextLevel;F')
          Selected.Strings = (
            'Classification'#9'15'#9'~~Classification'#9'F'
            'Type'#9'12'#9'~~Type'#9'F'
            'FullTime'#9'8'#9'Full Time'#9'F'#9'Rates'
            'PartTime'#9'8'#9'Part Time'#9'F'#9'Rates'
            'Casual'#9'7'#9'Casual'#9'F'#9'Rates'
            'CasualLoading'#9'10'#9'~Casual~Loading %'#9'F'
            'AdvanceIDName'#9'13'#9'Advance to~Next Level from~Start Date/ DOB'#9'F'
            'AdvanceToClassification'#9'14'#9'~~Next Level'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = 15785701
          FixedCols = 0
          ShowHorzScrollBar = True
          DataSource = DSClassificationDetails
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgProportionalColResize]
          ParentFont = False
          TabOrder = 0
          TitleAlignment = taCenter
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 3
          TitleButtons = True
          UseTFields = False
          OnExit = grdClassificationExit
          object wwDBGrid2IButton: TwwIButton
            Left = 0
            Top = 0
            Width = 25
            Height = 48
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
            OnClick = wwDBGrid2IButtonClick
          end
        end
        object edClassification: TwwDBEdit
          Left = 47
          Top = 88
          Width = 110
          Height = 23
          DataField = 'Classification'
          DataSource = DSClassificationDetails
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnEnter = edClassificationEnter
        end
        object cboAdvanceID: TwwDBLookupCombo
          Left = 496
          Top = 80
          Width = 93
          Height = 23
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Description'#9'25'#9'Description'#9#9)
          DataField = 'AdvanceIDName'
          DataSource = DSClassificationDetails
          LookupTable = qryAwardAdvance
          LookupField = 'Description'
          Style = csDropDownList
          DropDownWidth = 75
          ParentFont = False
          TabOrder = 3
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = True
          OnCloseUp = cboAdvanceIDCloseUp
        end
        object ClassificationType: TwwDBLookupCombo
          Left = 163
          Top = 87
          Width = 81
          Height = 23
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Description'#9'20'#9'Description'#9'F')
          DataField = 'Type'
          DataSource = DSClassificationDetails
          LookupTable = qryPayRateType
          LookupField = 'Description'
          Style = csDropDownList
          DropDownWidth = 150
          ParentFont = False
          TabOrder = 1
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
        end
        object PageControl2: TPageControl
          Tag = 1
          Left = 10
          Top = 194
          Width = 682
          Height = 189
          ActivePage = tabClassificationAllowances
          TabHeight = 22
          TabIndex = 0
          TabOrder = 4
          TabWidth = 226
          object tabClassificationAllowances: TTabSheet
            Caption = 'Classification Allowances'
            object DNMPanel4: TDNMPanel
              Left = 0
              Top = 0
              Width = 674
              Height = 157
              Align = alClient
              BevelOuter = bvNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              object grdAllowances: TwwDBGrid
                Left = 116
                Top = 2
                Width = 452
                Height = 145
                ControlType.Strings = (
                  'Based On;CustomEdit;BasedOn;T'
                  'Allowance;CustomEdit;Allowance;T'
                  'lookupAllowance;CustomEdit;cboAllowance;F'
                  'lookupBasedOn;CustomEdit;cboBasedOn;F'
                  'CalcBy;CustomEdit;cboAllowCalcBy;F')
                Selected.Strings = (
                  'lookupAllowance'#9'20'#9'Allowance'#9'F'
                  'Amount'#9'11'#9'Amount'#9'F'
                  'CalcBy'#9'4'#9'$/%'#9'F'
                  'lookupBasedOn'#9'20'#9'Based On'#9'F')
                IniAttributes.Delimiter = ';;'
                TitleColor = 15785701
                FixedCols = 0
                ShowHorzScrollBar = True
                DataSource = DSAllowances
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgProportionalColResize]
                ParentFont = False
                TabOrder = 0
                TitleAlignment = taCenter
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -12
                TitleFont.Name = 'Arial'
                TitleFont.Style = [fsBold]
                TitleLines = 1
                TitleButtons = True
                UseTFields = False
                OnExit = grdAllowancesExit
                object grdAllowncesIButton: TwwIButton
                  Left = 0
                  Top = 0
                  Width = 24
                  Height = 22
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
                  OnClick = grdAllowncesIButtonClick
                end
              end
              object cboBasedOn: TwwDBLookupCombo
                Left = 422
                Top = 28
                Width = 66
                Height = 23
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                DropDownAlignment = taLeftJustify
                Selected.Strings = (
                  'BasedOn'#9'25'#9'BasedOn'#9#9)
                DataField = 'BasedOnID'
                DataSource = DSAllowances
                LookupTable = qryBasedOn
                LookupField = 'BasedOn'
                Style = csDropDownList
                DropDownWidth = 150
                ParentFont = False
                TabOrder = 1
                AutoDropDown = True
                ShowButton = True
                AllowClearKey = False
              end
              object cboAllowance: TwwDBLookupCombo
                Left = 159
                Top = 29
                Width = 100
                Height = 23
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                DropDownAlignment = taLeftJustify
                Selected.Strings = (
                  'Description'#9'150'#9'Description'#9#9)
                DataField = 'lookupAllowance'
                DataSource = DSAllowances
                LookupTable = qryAllowances
                LookupField = 'AllowanceID'
                Style = csDropDownList
                DropDownWidth = 150
                ParentFont = False
                TabOrder = 2
                AutoDropDown = True
                ShowButton = True
                AllowClearKey = False
                OnCloseUp = cboAllowanceCloseUp
                OnExit = cboAllowanceExit
                OnNotInList = cboAllowanceNotInList
              end
              object cboAllowCalcBy: TwwDBComboBox
                Left = 370
                Top = 29
                Width = 33
                Height = 23
                ShowButton = True
                Style = csDropDownList
                MapList = True
                AllowClearKey = False
                DataField = 'CalcBy'
                DataSource = DSAllowances
                DropDownCount = 8
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ItemHeight = 0
                Items.Strings = (
                  '$'#9'$'
                  '%'#9'%')
                ParentFont = False
                Sorted = False
                TabOrder = 3
                UnboundDataType = wwDefault
              end
            end
          end
          object tabClassificationDeductions: TTabSheet
            Caption = 'Classification Deductions'
            ImageIndex = 1
            object DNMPanel5: TDNMPanel
              Left = 0
              Top = 0
              Width = 674
              Height = 157
              Align = alClient
              BevelOuter = bvNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              object grdDeductions: TwwDBGrid
                Left = 116
                Top = 2
                Width = 452
                Height = 145
                ControlType.Strings = (
                  'DeductionLookup;CustomEdit;cboDeduction;F'
                  'BasedOnLookup;CustomEdit;cboBasedOnDeduct;F'
                  'CalcBy;CustomEdit;cboDeductCalcBy;F')
                Selected.Strings = (
                  'DeductionLookup'#9'20'#9'Deduction'#9'F'
                  'Amount'#9'11'#9'Amount'#9'F'
                  'CalcBy'#9'4'#9'$/%'#9'F'
                  'BasedOnLookup'#9'20'#9'Based On'#9'F')
                IniAttributes.Delimiter = ';;'
                TitleColor = 15785701
                FixedCols = 0
                ShowHorzScrollBar = True
                DataSource = dsClassDeductions
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
                TitleAlignment = taCenter
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -12
                TitleFont.Name = 'Arial'
                TitleFont.Style = [fsBold]
                TitleLines = 1
                TitleButtons = True
                UseTFields = False
                OnExit = grdDeductionsExit
                object grdDeductionsIButton: TwwIButton
                  Left = 0
                  Top = 0
                  Width = 24
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
                  OnClick = grdDeductionsIButtonClick
                end
              end
              object cboDeduction: TwwDBLookupCombo
                Left = 160
                Top = 28
                Width = 107
                Height = 23
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                DropDownAlignment = taLeftJustify
                Selected.Strings = (
                  'Description'#9'25'#9'Description'#9'F')
                DataField = 'DeductionLookup'
                DataSource = dsClassDeductions
                LookupTable = qryDeductions
                LookupField = 'DeductionID'
                Style = csDropDownList
                ParentFont = False
                TabOrder = 1
                AutoDropDown = True
                ShowButton = True
                AllowClearKey = False
                OnCloseUp = cboDeductionCloseUp
                OnNotInList = cboDeductionNotInList
              end
              object cboBasedOnDeduct: TwwDBLookupCombo
                Left = 408
                Top = 25
                Width = 89
                Height = 23
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                DropDownAlignment = taLeftJustify
                Selected.Strings = (
                  'BasedOn'#9'15'#9'BasedOn'#9'F')
                DataField = 'BasedOnLookup'
                DataSource = dsClassDeductions
                LookupTable = qryBasedOn
                LookupField = 'BasedOnID'
                Style = csDropDownList
                ParentFont = False
                TabOrder = 2
                AutoDropDown = True
                ShowButton = True
                AllowClearKey = False
              end
              object cboDeductCalcBy: TwwDBComboBox
                Left = 367
                Top = 26
                Width = 30
                Height = 23
                ShowButton = True
                Style = csDropDownList
                MapList = True
                AllowClearKey = False
                DataField = 'CalcBy'
                DataSource = dsClassDeductions
                DropDownCount = 8
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ItemHeight = 0
                Items.Strings = (
                  '$'#9'$'
                  '%'#9'%')
                ParentFont = False
                Sorted = False
                TabOrder = 3
                UnboundDataType = wwDefault
              end
            end
          end
          object tabClassificationExtraPayRates: TTabSheet
            Caption = 'Classification Extra Pay Rates'
            ImageIndex = 2
            object DNMPanel6: TDNMPanel
              Left = 0
              Top = 0
              Width = 674
              Height = 157
              Align = alClient
              BevelOuter = bvNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              object grdExtraPayRates: TwwDBGrid
                Left = 65
                Top = 4
                Width = 537
                Height = 145
                ControlType.Strings = (
                  'PayRateType;CustomEdit;TypeID;F'
                  'SuperInc;CheckBox;T;F'
                  'ExtraPayRate;CustomEdit;ExtraPayRate;F')
                Selected.Strings = (
                  'ExtraPayRate'#9'16'#9'Pay Rate'#9'F'
                  'PayRateType'#9'18'#9'Type'#9'F'
                  'Worked'#9'11'#9'Hours'#9'F'
                  'Amount'#9'16'#9'Amount'#9'F'
                  'SuperInc'#9'5'#9'Super'#9'F')
                IniAttributes.Delimiter = ';;'
                TitleColor = 15785701
                FixedCols = 0
                ShowHorzScrollBar = True
                DataSource = DSExtraRates
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
                TitleLines = 1
                TitleButtons = True
                UseTFields = False
                OnExit = grdExtraPayRatesExit
                object wwDBGrid5IButton: TwwIButton
                  Left = 0
                  Top = 0
                  Width = 23
                  Height = 22
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
                  OnClick = wwDBGrid5IButtonClick
                end
              end
              object TypeID: TwwDBLookupCombo
                Left = 218
                Top = 32
                Width = 61
                Height = 23
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                DropDownAlignment = taLeftJustify
                Selected.Strings = (
                  'Description'#9'50'#9'Description'#9#9)
                DataField = 'PayRateType'
                LookupTable = qryPayRateType
                LookupField = 'TypeID'
                Style = csDropDownList
                DropDownCount = 4
                DropDownWidth = 100
                ParentFont = False
                TabOrder = 1
                Visible = False
                AutoDropDown = True
                ShowButton = True
                AllowClearKey = False
              end
              object ExtraPayRate: TwwDBLookupCombo
                Left = 119
                Top = 31
                Width = 70
                Height = 23
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                DropDownAlignment = taLeftJustify
                Selected.Strings = (
                  'Description'#9'100'#9'Description'#9#9)
                DataField = 'PayRate'
                LookupTable = qryExtraPayRates
                LookupField = 'RateID'
                Style = csDropDownList
                DropDownWidth = 100
                ParentFont = False
                TabOrder = 2
                Visible = False
                AutoDropDown = True
                ShowButton = True
                AllowClearKey = False
              end
            end
          end
        end
        object cboNextLevel: TwwDBLookupCombo
          Left = 592
          Top = 80
          Width = 93
          Height = 23
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taRightJustify
          Selected.Strings = (
            'Classification'#9'30'#9'Classification'#9'T')
          DataField = 'AdvanceToClassification'
          DataSource = DSClassificationDetails
          LookupTable = cboNextClassifications
          LookupField = 'Classification'
          Style = csDropDownList
          ParentFont = False
          TabOrder = 5
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = True
          OnEnter = cboNextLevelEnter
        end
      end
    end
    object Timesheet: TTabSheet
      Caption = 'Timesheet &Payment Details'
      Enabled = False
      ImageIndex = 2
      TabVisible = False
      object DNMPanel3: TDNMPanel
        Left = 0
        Top = 0
        Width = 712
        Height = 397
        Align = alClient
        BevelOuter = bvNone
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        TabStop = True
        Visible = False
        object grdTimesheet: TwwDBGrid
          Left = 0
          Top = 0
          Width = 712
          Height = 397
          ControlType.Strings = (
            'SuperInc;CheckBox;Yes;No'
            'StartDay;CustomEdit;StartDay;T'
            'EndDay;CustomEdit;EndDay;T'
            'PayRate;CustomEdit;PayRate;T'
            'Rate1PayRate;CustomEdit;PayRate1;T'
            'Rate2PayRate;CustomEdit;PayRate2;T'
            'PayRate2;CustomEdit;PayRate2;T'
            'PayRate1;CustomEdit;PayRate1;T'
            'EndTime;CustomEdit;EndTimePicker;T')
          PictureMasks.Strings = (
            'StartTime'#9'#[#]:#[#] {AM,PM}'#9'F'#9'T'
            'EndDay'#9'#(#):#(#) {am,pm}'#9'T'#9'T'
            'EndTime'#9'#[#]:#[#] {AM,PM}'#9'T'#9'T')
          Selected.Strings = (
            'PayRate'#9'10'#9'~~Shift~Pay Rate'#9'F'
            'StartDay'#9'10'#9'~Day'#9'F'#9'Shift Start'
            'StartTime'#9'7'#9'~Time'#9'F'#9'Shift Start'
            'EndDay'#9'11'#9'~Day'#9'F'#9'Shift End'
            'EndTime'#9'7'#9'~Time'#9'F'#9'Shift End'
            'Rate1AfterHours'#9'6'#9'After~Hours'#9'F'#9'Overtime Rate 1'
            'PayRate1'#9'8'#9'Pay At~Pay Rate'#9'F'#9'Overtime Rate 1'
            'Rate2AfterHours'#9'9'#9'After~Hours'#9'F'#9'Overtime Rate 2'
            'PayRate2'#9'11'#9'Pay At~Pay Rate'#9'F'#9'Overtime Rate 2'
            'SuperInc'#9'9'#9'~Super'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = 15785701
          OnCreateDateTimePicker = grdTimesheetCreateDateTimePicker
          FixedCols = 0
          ShowHorzScrollBar = True
          Align = alClient
          DataSource = DSShifts
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgProportionalColResize]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleAlignment = taCenter
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 4
          TitleButtons = True
          UseTFields = False
          Visible = False
          OnEnter = grdTimesheetEnter
          OnExit = grdTimesheetExit
          object wwDBGrid3IButton: TwwIButton
            Left = 0
            Top = 0
            Width = 25
            Height = 64
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
            OnClick = wwDBGrid3IButtonClick
          end
        end
        object StartDay: TwwDBComboBox
          Left = 105
          Top = 70
          Width = 74
          Height = 23
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'StartDay'
          DataSource = DSShifts
          DropDownCount = 8
          DropDownWidth = 60
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 0
          Items.Strings = (
            'Mon-Fri'
            'Monday'
            'Tuesday'
            'Wednesday'
            'Thursday'
            'Friday'
            'Saturday'
            'Sunday')
          ItemIndex = 1
          ParentFont = False
          Sorted = False
          TabOrder = 1
          UnboundDataType = wwDefault
        end
        object EndDay: TwwDBComboBox
          Left = 228
          Top = 69
          Width = 81
          Height = 23
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'EndDay'
          DataSource = DSShifts
          DropDownCount = 8
          DropDownWidth = 60
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 0
          Items.Strings = (
            'Mon-Fri'
            'Monday'
            'Tuesday'
            'Wednesday'
            'Thursday'
            'Friday'
            'Saturday'
            'Sunday')
          ItemIndex = 2
          ParentFont = False
          Sorted = False
          TabOrder = 2
          UnboundDataType = wwDefault
        end
        object PayRate: TwwDBLookupCombo
          Left = 28
          Top = 70
          Width = 74
          Height = 23
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Description'#9'100'#9'Description'#9#9)
          DataField = 'PayRate'
          DataSource = DSShifts
          LookupTable = qryLimitedPayRates
          LookupField = 'RateID'
          DropDownWidth = 100
          TabOrder = 3
          AutoDropDown = False
          ShowButton = True
          AllowClearKey = False
        end
        object PayRate1: TwwDBLookupCombo
          Left = 413
          Top = 70
          Width = 60
          Height = 23
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Description'#9'100'#9'Description'#9#9)
          DataField = 'Rate1PayRate'
          DataSource = DSShifts
          LookupTable = qryPayRatesOnly
          LookupField = 'RateID'
          DropDownWidth = 100
          TabOrder = 4
          AutoDropDown = False
          ShowButton = True
          AllowClearKey = False
        end
        object PayRate2: TwwDBLookupCombo
          Left = 551
          Top = 69
          Width = 81
          Height = 23
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Description'#9'100'#9'Description'#9#9)
          DataField = 'Rate2PayRate'
          DataSource = DSShifts
          LookupTable = qryPayRatesOnly
          LookupField = 'RateID'
          DropDownWidth = 100
          TabOrder = 5
          AutoDropDown = False
          ShowButton = True
          AllowClearKey = False
        end
        object EndTimePicker: TwwDBDateTimePicker
          Left = 313
          Top = 68
          Width = 53
          Height = 23
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          DataField = 'EndTime'
          DataSource = DSShifts
          Epoch = 1950
          ShowButton = False
          TabOrder = 6
          DisplayFormat = 'hh:mm am/pm'
        end
      end
    end
  end
  object chkActive: TwwCheckBox [6]
    Left = 704
    Top = 531
    Width = 15
    Height = 16
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'T'
    DisplayValueUnchecked = 'F'
    NullAndBlankState = cbChecked
    Checked = True
    DataField = 'Active'
    DataSource = DSAwards
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 2
    OnClick = chkActiveClick
  end
  object DNMPanel7: TDNMPanel [7]
    Left = 245
    Top = 4
    Width = 253
    Height = 40
    Caption = 'Award'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 14221420
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object DBMemo1: TDBMemo [8]
    Left = 194
    Top = 47
    Width = 357
    Height = 29
    TabStop = False
    Alignment = taCenter
    DataField = 'AwardName'
    DataSource = DSAwards
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
  end
  object DSAwards: TDataSource
    DataSet = tblAwards
    Left = 144
    Top = 33
  end
  object qryDepartments: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName'
      'FROM tblClass '
      
        'WHERE ((Not IsNull(tblClass.ClassName)) And (tblClass.Active<>'#39'F' +
        #39'))'
      'OR (tblClass.ClassID= :xClassID )'
      'ORDER BY tblClass.ClassName; ')
    Left = 436
    Top = 65535
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClassID'
      end>
  end
  object DSLeave: TDataSource
    DataSet = qryAwardLeave
    Left = 171
    Top = 33
  end
  object DSClassificationDetails: TDataSource
    DataSet = qryawardclassificationdetails
    Left = 201
    Top = 32
  end
  object qryAwardAdvance: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select AdvanceID, Description'
      'FROM tblAwardAdvance')
    Left = 467
    Top = 65535
    object qryAwardAdvanceDescription: TStringField
      DisplayWidth = 25
      FieldName = 'Description'
      Size = 25
    end
    object qryAwardAdvanceAdvanceID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'AdvanceID'
      ReadOnly = True
      Visible = False
    end
  end
  object DSAllowances: TDataSource
    DataSet = qryclassificationallowances
    Left = 58
    Top = 414
  end
  object qryBasedOn: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select BasedOnID, BasedOn'
      'FROM tblAllowanceBasedOn')
    Left = 590
    Top = 65535
  end
  object qryPayRateType: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select TypeID, Description'
      'FROM tblPayRateType')
    Left = 498
    Top = 65535
  end
  object DSShifts: TDataSource
    AutoEdit = False
    DataSet = tblAwardShifts
    Enabled = False
    Left = 706
    Top = 57
  end
  object qryPayRates: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select RateID, Description, Multiplier'
      'FROM tblPayRates')
    Left = 620
    Top = 65535
    object qryPayRatesDescription: TStringField
      DisplayWidth = 100
      FieldName = 'Description'
      Size = 100
    end
    object qryPayRatesRateID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'RateID'
      ReadOnly = True
      Visible = False
    end
    object qryPayRatesMultiplier: TFloatField
      DisplayWidth = 10
      FieldName = 'Multiplier'
      Visible = False
    end
  end
  object qryAllowances: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select AllowanceID, Description, SuperInc, TaxExempt, PayrollTax' +
        'Exempt, '
      'WorkcoverExempt, DisplayIn, Amount, CalcBy, BasedOnID, Active'
      'FROM tblAllowances'
      'WHERE Active='#39'T'#39)
    Left = 559
    Top = 65535
    object qryAllowancesDescription: TStringField
      DisplayWidth = 150
      FieldName = 'Description'
      Size = 150
    end
    object qryAllowancesAllowanceID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'AllowanceID'
      ReadOnly = True
      Visible = False
    end
    object qryAllowancesSuperInc: TStringField
      DisplayWidth = 1
      FieldName = 'SuperInc'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryAllowancesTaxExempt: TStringField
      DisplayWidth = 1
      FieldName = 'TaxExempt'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryAllowancesPayrollTaxExempt: TStringField
      DisplayWidth = 1
      FieldName = 'PayrollTaxExempt'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryAllowancesWorkcoverExempt: TStringField
      DisplayWidth = 1
      FieldName = 'WorkcoverExempt'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryAllowancesDisplayIn: TStringField
      DisplayWidth = 31
      FieldName = 'DisplayIn'
      Visible = False
      FixedChar = True
      Size = 31
    end
    object qryAllowancesAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
      Visible = False
    end
    object qryAllowancesCalcBy: TStringField
      FieldName = 'CalcBy'
      FixedChar = True
      Size = 1
    end
    object qryAllowancesBasedOnID: TIntegerField
      DisplayWidth = 10
      FieldName = 'BasedOnID'
      Visible = False
    end
    object qryAllowancesActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object qryAwardLeave: TMyQuery
    SQL.Strings = (
      'select *  from tblawardsleave WHERE AwardID=:xAwardID')
    Left = 172
    Top = 4
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xAwardID'
      end>
    object qryAwardLeaveGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryAwardLeaveLeaveID: TAutoIncField
      FieldName = 'LeaveID'
      ReadOnly = True
    end
    object qryAwardLeaveAwardID: TIntegerField
      FieldName = 'AwardID'
    end
    object qryAwardLeaveType: TStringField
      FieldName = 'Type'
      OnChange = qryAwardLeaveTypeChange
      FixedChar = True
      Size = 50
    end
    object qryAwardLeaveAccrueAfterNo: TFloatField
      FieldName = 'AccrueAfterNo'
    end
    object qryAwardLeaveAccrueAfterPeriod: TStringField
      FieldName = 'AccrueAfterPeriod'
      FixedChar = True
      Size = 28
    end
    object qryAwardLeaveAccrueNo: TFloatField
      FieldName = 'AccrueNo'
    end
    object qryAwardLeaveAccruePeriod: TStringField
      FieldName = 'AccruePeriod'
      FixedChar = True
      Size = 28
    end
    object qryAwardLeaveAccrueHours: TFloatField
      FieldName = 'AccrueHours'
      DisplayFormat = '0.####'
    end
    object qryAwardLeaveEditedFlag: TStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryAwardLeaveAwardStartDate: TDateField
      FieldName = 'AwardStartDate'
    end
    object qryAwardLeaveAwardEndDate: TDateField
      FieldName = 'AwardEndDate'
    end
    object qryAwardLeaveUseStartEndDates: TStringField
      FieldName = 'UseStartEndDates'
      FixedChar = True
      Size = 1
    end
    object qryAwardLeaveLeaveLoading: TFloatField
      FieldName = 'LeaveLoading'
      OnChange = qryAwardLeaveLeaveLoadingChange
    end
  end
  object qryExtraPayRates: TMyQuery
    SQL.Strings = (
      'Select RateID, Description, Multiplier'
      'FROM tblPayRates '
      'WHERE Description <> '#39'Normal Hours'#39
      'AND Active='#39'T'#39)
    Left = 713
    Top = 65535
  end
  object qryawardclassificationdetails: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblawardclassificationdetails '
      'WHERE AwardID = :xAwardID;')
    AfterScroll = qryawardclassificationdetailsAfterScroll
    Left = 202
    Top = 3
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xAwardID'
      end>
    object qryawardclassificationdetailsGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryawardclassificationdetailsClassificationID: TAutoIncField
      FieldName = 'ClassificationID'
    end
    object qryawardclassificationdetailsAwardID: TIntegerField
      FieldName = 'AwardID'
    end
    object qryawardclassificationdetailsClassification: TStringField
      FieldName = 'Classification'
      OnChange = qryawardclassificationdetailsClassificationChange
      Size = 50
    end
    object qryawardclassificationdetailsType: TStringField
      FieldName = 'Type'
      FixedChar = True
      Size = 35
    end
    object qryawardclassificationdetailsFullTime: TFloatField
      FieldName = 'FullTime'
      DisplayFormat = '$#0.00##'
    end
    object qryawardclassificationdetailsPartTime: TFloatField
      FieldName = 'PartTime'
      DisplayFormat = '$#0.00##'
    end
    object qryawardclassificationdetailsCasual: TFloatField
      FieldName = 'Casual'
      DisplayFormat = '$#0.00##'
    end
    object qryawardclassificationdetailsCasualLoading: TFloatField
      FieldName = 'CasualLoading'
      DisplayFormat = '###0.00%'
      EditFormat = '###0.00%'
    end
    object qryawardclassificationdetailsAdvanceIDName: TStringField
      FieldName = 'AdvanceIDName'
      Size = 255
    end
    object qryawardclassificationdetailsAdvanceID: TIntegerField
      FieldName = 'AdvanceID'
    end
    object qryawardclassificationdetailsFTHourlyRate: TFloatField
      FieldName = 'FTHourlyRate'
    end
    object qryawardclassificationdetailsPTHourlyRate: TFloatField
      FieldName = 'PTHourlyRate'
    end
    object qryawardclassificationdetailsCHourlyRate: TFloatField
      FieldName = 'CHourlyRate'
    end
    object qryawardclassificationdetailsEditedFlag: TStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryawardclassificationdetailsAdvanceToClassification: TStringField
      FieldName = 'AdvanceToClassification'
      Size = 255
    end
  end
  object qryLimitedPayRates: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT RateID,Description FROM tblpayrates'
      'WHERE IsPayRate <> '#39'T'#39)
    Left = 682
    Top = 65535
  end
  object qryPayRatesOnly: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT RateID,Description FROM tblpayrates'
      'WHERE IsPayRate = '#39'T'#39)
    Left = 651
    Top = 65535
  end
  object qryClassificationDeductions: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblclassificationdeductions '
      
        'WHERE AwardID = :xAwardID AND ClassificationID = :xClassificatio' +
        'nID')
    BeforePost = qryClassificationDeductionsBeforePost
    Left = 370
    Top = 385
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xAwardID'
      end
      item
        DataType = ftUnknown
        Name = 'xClassificationID'
      end>
    object qryClassificationDeductionsAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
      DisplayFormat = '#0.00'
      EditFormat = '#0.00'
    end
    object qryClassificationDeductionsCalcBy: TStringField
      FieldName = 'CalcBy'
      FixedChar = True
      Size = 1
    end
    object qryClassificationDeductionsGlobalRef: TStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Visible = False
      FixedChar = True
      Size = 255
    end
    object qryClassificationDeductionsDeductionID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DeductionID'
      Visible = False
    end
    object qryClassificationDeductionsClassificationID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassificationID'
      Visible = False
    end
    object qryClassificationDeductionsDeductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DeductID'
      Visible = False
    end
    object qryClassificationDeductionsBasedOnID: TIntegerField
      DisplayWidth = 10
      FieldName = 'BasedOnID'
      Visible = False
      OnChange = qryClassificationDeductionsBasedOnIDChange
    end
    object qryClassificationDeductionsEditedFlag: TStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryClassificationDeductionsAwardID: TIntegerField
      DisplayWidth = 10
      FieldName = 'AwardID'
      Visible = False
    end
    object qryClassificationDeductionsDeductionLookup: TStringField
      FieldKind = fkLookup
      FieldName = 'DeductionLookup'
      LookupDataSet = qryDeductions
      LookupKeyFields = 'DeductionID'
      LookupResultField = 'Description'
      KeyFields = 'DeductID'
      Size = 25
      Lookup = True
    end
    object qryClassificationDeductionsBasedOnLookup: TStringField
      FieldKind = fkLookup
      FieldName = 'BasedOnLookup'
      LookupDataSet = qryBasedOn
      LookupKeyFields = 'BasedOnID'
      LookupResultField = 'BasedOn'
      KeyFields = 'BasedOnID'
      Size = 25
      Lookup = True
    end
  end
  object dsClassDeductions: TDataSource
    DataSet = qryClassificationDeductions
    Left = 369
    Top = 413
  end
  object qryDeductions: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tbldeductions WHERE Active = '#39'T'#39)
    Left = 528
    Top = 65535
    object qryDeductionsDescription: TStringField
      DisplayWidth = 25
      FieldName = 'Description'
      Size = 150
    end
    object qryDeductionsGlobalRef: TStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryDeductionsDeductionID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'DeductionID'
      ReadOnly = True
      Visible = False
    end
    object qryDeductionsTaxExempt: TStringField
      DisplayWidth = 1
      FieldName = 'TaxExempt'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryDeductionsUnionFees: TStringField
      DisplayWidth = 1
      FieldName = 'UnionFees'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryDeductionsEditedFlag: TStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryDeductionsActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryDeductionsDisplayIn: TStringField
      FieldName = 'DisplayIn'
      FixedChar = True
      Size = 31
    end
    object qryDeductionsAmount: TFloatField
      FieldName = 'Amount'
    end
    object qryDeductionsBasedOnID: TIntegerField
      FieldName = 'BasedOnID'
    end
    object qryDeductionsCalcBy: TStringField
      FieldName = 'CalcBy'
      FixedChar = True
      Size = 1
    end
  end
  object qryclassificationallowances: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblclassificationallowances '
      
        'WHERE AwardID=:xAwardID AND ClassificationID = :xClassificationI' +
        'D')
    BeforePost = qryclassificationallowancesBeforePost
    Left = 58
    Top = 385
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xAwardID'
      end
      item
        DataType = ftUnknown
        Name = 'xClassificationID'
      end>
    object qryclassificationallowancesGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryclassificationallowancesAllowanceID: TAutoIncField
      FieldName = 'AllowanceID'
    end
    object qryclassificationallowancesClassificationID: TIntegerField
      FieldName = 'ClassificationID'
    end
    object qryclassificationallowancesAllowID: TIntegerField
      FieldName = 'AllowID'
    end
    object qryclassificationallowancesAmount: TFloatField
      FieldName = 'Amount'
      DisplayFormat = '#0.00'
      EditFormat = '#0.00'
    end
    object qryclassificationallowancesCalcBy: TStringField
      FieldName = 'CalcBy'
      FixedChar = True
      Size = 1
    end
    object qryclassificationallowancesBasedOnID: TIntegerField
      FieldName = 'BasedOnID'
      OnChange = qryclassificationallowancesBasedOnIDChange
    end
    object qryclassificationallowancesEditedFlag: TStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryclassificationallowancesAwardID: TIntegerField
      FieldName = 'AwardID'
    end
    object qryclassificationallowanceslookupAllowance: TStringField
      FieldKind = fkLookup
      FieldName = 'lookupAllowance'
      LookupDataSet = qryAllowances
      LookupKeyFields = 'AllowanceID'
      LookupResultField = 'Description'
      KeyFields = 'AllowID'
      Size = 35
      Lookup = True
    end
    object qryclassificationallowanceslookupBasedOn: TStringField
      FieldKind = fkLookup
      FieldName = 'lookupBasedOn'
      LookupDataSet = qryBasedOn
      LookupKeyFields = 'BasedOnID'
      LookupResultField = 'BasedOn'
      KeyFields = 'BasedOnID'
      Size = 35
      Lookup = True
    end
  end
  object qryLeaveTypes: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'LeaveTypeID AS LeaveTypeID,'
      'LeaveType AS LeaveType'
      'FROM tblLeaveTypes'
      'WHERE Active = '#39'T'#39
      'ORDER BY LeaveType')
    Left = 406
    Top = 65535
  end
  object tblAwards: TMyQuery
    SQL.Strings = (
      'SELECT * FROM tblAwards'
      'WHERE AwardID=:xAwardID')
    Left = 142
    Top = 5
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xAwardID'
      end>
    object tblAwardsAwardID: TAutoIncField
      FieldName = 'AwardID'
      ReadOnly = True
    end
    object tblAwardsAwardName: TStringField
      FieldName = 'AwardName'
      Size = 150
    end
    object tblAwardsClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object tblAwardsPayPeriod: TStringField
      FieldName = 'PayPeriod'
      FixedChar = True
      Size = 37
    end
    object tblAwardsSuperType: TStringField
      FieldName = 'SuperType'
      FixedChar = True
      Size = 17
    end
    object tblAwardsAnnualLeaveLoading: TFloatField
      FieldName = 'AnnualLeaveLoading'
      DisplayFormat = '##0.00%'
    end
    object tblAwardsActive: TStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object tblAwardsEditedFlag: TStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblAwardsSuperValue: TFloatField
      FieldName = 'SuperValue'
    end
    object tblAwardsMealBreakHours: TFloatField
      FieldName = 'MealBreakHours'
    end
    object tblAwardsMealBreakThreshold: TFloatField
      FieldName = 'MealBreakThreshold'
    end
    object tblAwardsPaySuperOnLeaveLoading: TStringField
      FieldName = 'PaySuperOnLeaveLoading'
      FixedChar = True
      Size = 1
    end
    object tblAwardsUseCompanySuperThreshold: TStringField
      FieldName = 'UseCompanySuperThreshold'
      FixedChar = True
      Size = 1
    end
    object tblAwardsSuperThresholdAmount: TFloatField
      FieldName = 'SuperThresholdAmount'
      currency = True
    end
    object tblAwardsSickLeaveDaysThreshold: TIntegerField
      FieldName = 'SickLeaveDaysThreshold'
    end
  end
  object tblAwardShifts: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblAwardShifts'
      'WHERE AwardID=:xAwardID')
    BeforePost = tblAwardShiftsBeforePost
    Left = 707
    Top = 28
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xAwardID'
      end>
    object tblAwardShiftsShiftID: TAutoIncField
      FieldName = 'ShiftID'
      ReadOnly = True
    end
    object tblAwardShiftsAwardID: TIntegerField
      FieldName = 'AwardID'
      ReadOnly = True
    end
    object tblAwardShiftsPayRateID: TIntegerField
      FieldName = 'PayRateID'
      ReadOnly = True
    end
    object tblAwardShiftsStartDay: TStringField
      FieldName = 'StartDay'
      ReadOnly = True
      FixedChar = True
      Size = 68
    end
    object tblAwardShiftsEndDay: TStringField
      FieldName = 'EndDay'
      ReadOnly = True
      FixedChar = True
      Size = 68
    end
    object tblAwardShiftsRate1AfterHours: TFloatField
      FieldName = 'Rate1AfterHours'
      ReadOnly = True
    end
    object tblAwardShiftsRate1PayRate: TIntegerField
      FieldName = 'Rate1PayRate'
      ReadOnly = True
    end
    object tblAwardShiftsRate2AfterHours: TFloatField
      FieldName = 'Rate2AfterHours'
      ReadOnly = True
    end
    object tblAwardShiftsRate2PayRate: TIntegerField
      FieldName = 'Rate2PayRate'
      ReadOnly = True
    end
    object tblAwardShiftsSuperInc: TStringField
      FieldName = 'SuperInc'
      ReadOnly = True
      FixedChar = True
      Size = 45
    end
    object tblAwardShiftsPayRate: TStringField
      FieldKind = fkLookup
      FieldName = 'PayRate'
      LookupDataSet = qryPayRates
      LookupKeyFields = 'RateID'
      LookupResultField = 'Description'
      KeyFields = 'PayRateID'
      ReadOnly = True
      Lookup = True
    end
    object tblAwardShiftsPayRate1: TStringField
      FieldKind = fkLookup
      FieldName = 'PayRate1'
      LookupDataSet = qryPayRates
      LookupKeyFields = 'RateID'
      LookupResultField = 'Description'
      KeyFields = 'Rate1PayRate'
      ReadOnly = True
      Lookup = True
    end
    object tblAwardShiftsPayRate2: TStringField
      FieldKind = fkLookup
      FieldName = 'PayRate2'
      LookupDataSet = qryPayRates
      LookupKeyFields = 'RateID'
      LookupResultField = 'Description'
      KeyFields = 'Rate2PayRate'
      ReadOnly = True
      Lookup = True
    end
    object tblAwardShiftsStartTime: TTimeField
      FieldName = 'StartTime'
      ReadOnly = True
      DisplayFormat = 'hh:mm am/pm'
    end
    object tblAwardShiftsEndTime: TDateTimeField
      FieldName = 'EndTime'
      ReadOnly = True
      DisplayFormat = 'hh:mm am/pm'
    end
    object tblAwardShiftsEditedFlag: TStringField
      FieldName = 'EditedFlag'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
  end
  object DSExtraRates: TDataSource
    DataSet = tblClassificationExtraPayRates
    Left = 689
    Top = 490
  end
  object tblClassificationExtraPayRates: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'From tblClassificationExtraPayRates'
      
        'WHERE AwardID=:xAwardID AND ClassificationID = :xClassificationI' +
        'D')
    BeforePost = tblClassificationExtraPayRatesBeforePost
    Left = 659
    Top = 501
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xAwardID'
      end
      item
        DataType = ftUnknown
        Name = 'xClassificationID'
      end>
    object tblClassificationExtraPayRatesRateID: TAutoIncField
      FieldName = 'RateID'
      ReadOnly = True
    end
    object tblClassificationExtraPayRatesClassificationID: TIntegerField
      FieldName = 'ClassificationID'
    end
    object tblClassificationExtraPayRatesPayRate: TIntegerField
      FieldName = 'PayRate'
    end
    object tblClassificationExtraPayRatesTypeID: TIntegerField
      FieldName = 'TypeID'
    end
    object tblClassificationExtraPayRatesPayRateType: TStringField
      FieldKind = fkLookup
      FieldName = 'PayRateType'
      LookupDataSet = qryPayRateType
      LookupKeyFields = 'TypeID'
      LookupResultField = 'Description'
      KeyFields = 'TypeID'
      Lookup = True
    end
    object tblClassificationExtraPayRatesWorked: TFloatField
      FieldName = 'Worked'
    end
    object tblClassificationExtraPayRatesAmount: TFloatField
      FieldName = 'Amount'
      currency = True
    end
    object tblClassificationExtraPayRatesSuperInc: TStringField
      FieldName = 'SuperInc'
      FixedChar = True
      Size = 1
    end
    object tblClassificationExtraPayRatesExtraPayRate: TStringField
      FieldKind = fkLookup
      FieldName = 'ExtraPayRate'
      LookupDataSet = qryPayRates
      LookupKeyFields = 'RateID'
      LookupResultField = 'Description'
      KeyFields = 'PayRate'
      Lookup = True
    end
    object tblClassificationExtraPayRatesAwardID: TIntegerField
      FieldName = 'AwardID'
    end
    object tblClassificationExtraPayRatesEditedFlag: TStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
  end
  object cboNextClassifications: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select ClassificationID,Classification '
      'from tblawardclassificationdetails '
      'WHERE AwardID = :xAwardID'
      'AND ClassificationID<>:xClassificationID;')
    Left = 658
    Top = 39
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xAwardID'
      end
      item
        DataType = ftUnknown
        Name = 'xClassificationID'
      end>
  end
end
