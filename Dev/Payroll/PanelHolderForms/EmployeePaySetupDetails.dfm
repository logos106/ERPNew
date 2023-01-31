inherited EmpPaySetupDetails: TEmpPaySetupDetails
  Left = 678
  Top = 178
  HelpContext = 559000
  Caption = 'Employee Pay Details'
  ClientHeight = 438
  ClientWidth = 794
  OldCreateOrder = True
  ExplicitLeft = 678
  ExplicitTop = 178
  ExplicitWidth = 810
  ExplicitHeight = 477
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 438
    Width = 794
    HelpContext = 559040
    ExplicitTop = 486
    ExplicitWidth = 921
  end
  object DNMPanel1: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 794
    Height = 438
    HelpContext = 559002
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object DNMPanel3: TDNMPanel
      Left = 16
      Top = 16
      Width = 235
      Height = 122
      HelpContext = 559004
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label3: TLabel
        Left = 21
        Top = 17
        Width = 69
        Height = 18
        HelpContext = 559005
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Pay Period'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label16: TLabel
        Left = 12
        Top = 56
        Width = 78
        Height = 15
        HelpContext = 559006
        Alignment = taRightJustify
        Caption = 'First Pay Date'
        Transparent = True
      end
      object Label19: TLabel
        Left = 8
        Top = 96
        Width = 82
        Height = 15
        HelpContext = 559007
        Alignment = taRightJustify
        Caption = 'Last Date Paid'
        Transparent = True
      end
      object PayPeriod: TwwDBComboBox
        Left = 102
        Top = 15
        Width = 123
        Height = 23
        HelpContext = 559008
        ShowButton = True
        Style = csDropDownList
        MapList = False
        AllowClearKey = False
        AutoDropDown = True
        DataField = 'PayPeriod'
        DataSource = dsEmpPaySettings
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          'Weekly'
          'Fortnightly'
          'Monthly'
          'None')
        ParentFont = False
        Sorted = False
        TabOrder = 0
        UnboundDataType = wwDefault
      end
      object dtFirstPayDate: TwwDBDateTimePicker
        Left = 102
        Top = 53
        Width = 123
        Height = 23
        HelpContext = 559009
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'FirstPayDate'
        DataSource = dsEmpPaySettings
        Epoch = 1950
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 1
        OnCloseUp = dtFirstPayDateCloseUp
      end
      object wwDBEdit1: TwwDBEdit
        Left = 102
        Top = 92
        Width = 121
        Height = 23
        HelpContext = 559010
        DataField = 'DateLastActuallyPaid'
        DataSource = dsEmpPaySettings
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
    end
    object DNMPanel4: TDNMPanel
      Left = 257
      Top = 16
      Width = 190
      Height = 122
      HelpContext = 559011
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label4: TLabel
        Left = 64
        Top = 15
        Width = 90
        Height = 15
        HelpContext = 559012
        Alignment = taRightJustify
        Caption = 'Show on Roster'
        Transparent = True
      end
      object Label6: TLabel
        Left = 16
        Top = 55
        Width = 138
        Height = 15
        HelpContext = 559013
        Alignment = taRightJustify
        Caption = 'Load Hours From Roster'
        Transparent = True
        Visible = False
      end
      object Label7: TLabel
        Left = 16
        Top = 96
        Width = 138
        Height = 15
        HelpContext = 559014
        Alignment = taRightJustify
        Caption = 'Load Leave From Roster'
        Transparent = True
        Visible = False
      end
      object chkIsOnRoster: TwwCheckBox
        Left = 163
        Top = 16
        Width = 17
        Height = 13
        HelpContext = 559015
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
        DataField = 'IsOnTheRoster'
        DataSource = DSEmployees
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object chkLoadHoursFromRoster: TwwCheckBox
        Left = 163
        Top = 56
        Width = 15
        Height = 13
        HelpContext = 559016
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
        Color = 14155775
        DataField = 'LoadHoursFromRoster'
        DataSource = DSEmployees
        ParentColor = False
        TabOrder = 1
        Visible = False
      end
      object chkLoadLeaveFromRoster: TwwCheckBox
        Left = 163
        Top = 97
        Width = 17
        Height = 13
        HelpContext = 559017
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
        Color = 14155775
        DataField = 'LoadLeaveFromRoster'
        DataSource = DSEmployees
        ParentColor = False
        TabOrder = 2
        Visible = False
      end
    end
    object DNMPanel2: TDNMPanel
      Left = 16
      Top = 143
      Width = 234
      Height = 192
      HelpContext = 559018
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object rgBasisOfEmployment: TwwRadioGroup
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 226
        Height = 184
        HelpContext = 559019
        DisableThemes = False
        TransparentActiveItem = True
        Transparent = True
        Align = alClient
        Caption = 'Basis of Employment'
        DataField = 'BasisOfPayment'
        DataSource = DSEmployees
        Items.Strings = (
          'Full Time'
          'Part Time'
          'Casual'
          'Labour Hire'
          'Superannuation Pension or Annuity')
        TabOrder = 0
        Values.Strings = (
          'F'
          'P'
          'C'
          'L'
          'S')
      end
    end
    object DNMPanel7: TDNMPanel
      Left = 613
      Top = 143
      Width = 168
      Height = 142
      HelpContext = 559020
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Label2: TLabel
        Left = 19
        Top = 11
        Width = 125
        Height = 15
        HelpContext = 559021
        Caption = 'Payslip Send Methods'
        Transparent = True
      end
      object rgPaySlipSendVia: TwwRadioGroup
        Left = 15
        Top = 32
        Width = 97
        Height = 90
        HelpContext = 559022
        DisableThemes = False
        TransparentActiveItem = True
        Frame.Transparent = True
        Indents.TextX = 5
        Transparent = True
        DataField = 'SendPaySlipViaEmail'
        DataSource = DSEmployees
        Items.Strings = (
          'To Printer'
          'Via email'
          'Both')
        TabOrder = 0
        Values.Strings = (
          'F'
          'T'
          'B')
      end
    end
    object DNMPanel5: TDNMPanel
      Left = 257
      Top = 143
      Width = 350
      Height = 191
      HelpContext = 559023
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object Label38: TLabel
        Left = 43
        Top = 20
        Width = 43
        Height = 14
        HelpContext = 559024
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Award'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label37: TLabel
        Tag = 1
        Left = 5
        Top = 56
        Width = 81
        Height = 18
        HelpContext = 559025
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Classification'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label32: TLabel
        Tag = 1
        Left = 18
        Top = 92
        Width = 68
        Height = 14
        HelpContext = 559026
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Class'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label36: TLabel
        Left = 18
        Top = 128
        Width = 68
        Height = 14
        HelpContext = 559027
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Reports To'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Bevel2: TBevel
        Left = 89
        Top = 159
        Width = 222
        Height = 25
        HelpContext = 559028
      end
      object Label21: TLabel
        Tag = 1
        Left = 104
        Top = 164
        Width = 154
        Height = 15
        HelpContext = 559029
        Alignment = taCenter
        Caption = 'Use Classification Advance'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object ReportsTo: TwwDBLookupCombo
        Left = 89
        Top = 124
        Width = 223
        Height = 23
        HelpContext = 559030
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'EmployeeName'#9'40'#9'EmployeeName'#9'F')
        DataField = 'ReportsTo'
        DataSource = DSEmployees
        LookupTable = qryEmpNames
        LookupField = 'EmployeeID'
        Style = csDropDownList
        DropDownWidth = 237
        ParentFont = False
        TabOrder = 0
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = True
      end
      object Department: TwwDBLookupCombo
        Left = 89
        Top = 88
        Width = 223
        Height = 23
        HelpContext = 559031
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ClassName'#9'20'#9'Department'#9'F')
        DataField = 'DefaultClassID'
        DataSource = DSEmployees
        LookupTable = qryDepartment
        LookupField = 'ClassID'
        DropDownWidth = 237
        ParentFont = False
        TabOrder = 1
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnCloseUp = DepartmentCloseUp
      end
      object Classification: TwwDBLookupCombo
        Left = 89
        Top = 52
        Width = 223
        Height = 23
        HelpContext = 559032
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Classification'#9'50'#9'Classification'#9'F')
        DataField = 'Classification'
        DataSource = DSEmployees
        LookupTable = qryAwardClfn
        LookupField = 'Classification'
        Style = csDropDownList
        DropDownWidth = 240
        ParentFont = False
        TabOrder = 2
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnCloseUp = ClassificationCloseUp
      end
      object cboAward: TwwDBLookupCombo
        Left = 89
        Top = 16
        Width = 223
        Height = 23
        HelpContext = 559033
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AwardName'#9'150'#9'AwardName'#9#9)
        DataField = 'Award'
        DataSource = DSEmployees
        LookupTable = qryAward
        LookupField = 'AwardID'
        Style = csDropDownList
        DropDownWidth = 237
        ParentFont = False
        TabOrder = 3
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = True
        OnCloseUp = cboAwardCloseUp
      end
      object chkUseClassificationAdvance: TwwCheckBox
        Tag = 1
        Left = 266
        Top = 163
        Width = 15
        Height = 16
        HelpContext = 559034
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
        NullAndBlankState = cbChecked
        Caption = 'chkIsOnRoster'
        Checked = True
        DataField = 'UseClassificationAdvance'
        DataSource = DSEmployees
        State = cbChecked
        TabOrder = 4
      end
    end
    object DNMPanel8: TDNMPanel
      Left = 17
      Top = 340
      Width = 764
      Height = 70
      HelpContext = 559035
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      object Label15: TLabel
        Left = 151
        Top = 11
        Width = 109
        Height = 15
        HelpContext = 559036
        Caption = 'Meal Break (Hours)'
        Transparent = True
      end
      object Label8: TLabel
        Left = 151
        Top = 43
        Width = 169
        Height = 15
        HelpContext = 559037
        Caption = 'Meal Break Threshold (Hours)'
        Transparent = True
      end
      object Label1: TLabel
        Left = 395
        Top = 11
        Width = 111
        Height = 15
        HelpContext = 559041
        Caption = 'Overhead Rates (%)'
        Transparent = True
      end
      object edMealThreshold: TwwDBEdit
        Left = 24
        Top = 40
        Width = 121
        Height = 23
        HelpContext = 559038
        DataField = 'MealBreakThreshold'
        DataSource = DSEmployees
        Font.Charset = DEFAULT_CHARSET
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
      object edMealBreak: TwwDBEdit
        Left = 24
        Top = 8
        Width = 121
        Height = 23
        HelpContext = 559039
        DataField = 'MealBreakHours'
        DataSource = DSEmployees
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit2: TwwDBEdit
        Left = 539
        Top = 8
        Width = 48
        Height = 23
        HelpContext = 559042
        DataField = 'OverheadRate'
        DataSource = DSEmployees
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
      end
    end
    object pnlSTPJobKeepersDetails: TDNMPanel
      Left = 453
      Top = 16
      Width = 328
      Height = 122
      HelpContext = 559020
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      object Label5: TLabel
        Left = 11
        Top = 6
        Width = 228
        Height = 15
        HelpContext = 559021
        Caption = 'Single Touch Payroll - JobKeeper Details'
        Transparent = True
      end
      object Label9: TLabel
        Left = 15
        Top = 36
        Width = 81
        Height = 15
        HelpContext = 559024
        Alignment = taRightJustify
        Caption = 'Start Fortnight'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label10: TLabel
        Left = 74
        Top = 66
        Width = 22
        Height = 15
        HelpContext = 559005
        Alignment = taRightJustify
        Caption = 'Tier'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label11: TLabel
        Left = 10
        Top = 96
        Width = 86
        Height = 15
        HelpContext = 559024
        Alignment = taRightJustify
        Caption = 'Finish Fortnight'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object cboSTPJobkeeperStartFN: TwwDBLookupCombo
        Left = 102
        Top = 33
        Width = 200
        Height = 23
        HelpContext = 559033
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'OtherAllowanceStartDescription'#9'30'#9'Description'#9'F'
          'DateFrom'#9'10'#9'From'#9'F'
          'Dateto'#9'10'#9'To'#9'F')
        DataField = 'STPJobkeeperStartFN'
        DataSource = dsEmpPaySettings
        LookupTable = qrySTPJobkeeperstartFNList
        LookupField = 'FN'
        Options = [loTitles]
        Style = csDropDownList
        DropDownWidth = 400
        ParentFont = False
        TabOrder = 0
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = True
      end
      object cboSTPTier: TwwDBComboBox
        Left = 102
        Top = 62
        Width = 200
        Height = 23
        HelpContext = 559008
        ShowButton = True
        Style = csDropDownList
        MapList = True
        AllowClearKey = False
        AutoDropDown = True
        DataField = 'STPTier'
        DataSource = dsEmpPaySettings
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          '>= 80 hours / 4 Weeks'#9'1'
          ' < 80 hours / 4 Weeks'#9'2')
        ParentFont = False
        Sorted = False
        TabOrder = 1
        UnboundDataType = wwDefault
      end
      object cboSTPJobkeeperFinishFN: TwwDBLookupCombo
        Left = 102
        Top = 92
        Width = 200
        Height = 23
        Hint = 
          'The First Full Fortnight the Employee Became Ineligible for JobK' +
          'eeper Payments '
        HelpContext = 559033
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'OtherAllowanceFinishDescription'#9'30'#9'Description'#9'F'
          'DateFrom'#9'10'#9'From'#9'F'
          'Dateto'#9'10'#9'To'#9'F')
        DataField = 'STPJobkeeperFinishFN'
        DataSource = dsEmpPaySettings
        LookupTable = qrySTPJobkeeperFinishFNList
        LookupField = 'FN'
        Options = [loTitles]
        Style = csDropDownList
        DropDownWidth = 400
        ParentFont = False
        TabOrder = 2
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = True
      end
      object DNMSpeedButton1: TDNMSpeedButton
        Left = 253
        Top = 2
        Width = 68
        Height = 23
        Caption = 'ATO Ref'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentFont = False
        TabOrder = 3
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton1Click
      end
      object DNMSpeedButton2: TDNMSpeedButton
        Left = 306
        Top = 33
        Width = 18
        Height = 23
        Caption = '?'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentFont = False
        TabOrder = 4
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton2Click
      end
      object DNMSpeedButton3: TDNMSpeedButton
        Left = 306
        Top = 92
        Width = 18
        Height = 23
        Caption = '?'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentFont = False
        TabOrder = 5
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton3Click
      end
    end
  end
  object dsEmpPaySettings: TDataSource
    Left = 824
    Top = 80
  end
  object DSEmployees: TDataSource
    Left = 872
    Top = 80
  end
  object qryAward: TERPQuery
    SQL.Strings = (
      'Select AwardID, AwardName'
      'FROM tblAwards'
      'WHERE(Active = '#39'T'#39' OR AwardID=:xID) AND AwardID<>0'
      'ORDER BY AwardName;')
    Left = 863
    Top = 137
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
  end
  object qryAwardClfn: TERPQuery
    SQL.Strings = (
      'Select ClassificationID, Classification'
      'FROM tblAwardClassificationDetails'
      'WHERE AwardID=:AwardID')
    Left = 854
    Top = 188
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AwardID'
      end>
    object qryAwardClfnClassification: TWideStringField
      DisplayWidth = 40
      FieldName = 'Classification'
      Size = 255
    end
    object qryAwardClfnClassificationID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'ClassificationID'
      ReadOnly = True
      Visible = False
    end
  end
  object qryDepartment: TERPQuery
    SQL.Strings = (
      'Select ClassID, ClassName, Active'
      'FROM tblClass'
      'WHERE Active = '#39'T'#39
      'ORDER BY ClassName')
    Left = 854
    Top = 234
    object StringField1: TWideStringField
      DisplayLabel = 'Department'
      DisplayWidth = 20
      FieldName = 'ClassName'
      Size = 60
    end
    object StringField2: TWideStringField
      DisplayWidth = 5
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object AutoIncField1: TAutoIncField
      FieldName = 'ClassID'
      ReadOnly = True
      Visible = False
    end
  end
  object qryEmpNames: TERPQuery
    SQL.Strings = (
      'SELECT'
      'EmployeeID, EmployeeName, LastPaid '
      'FROM tblEmployees'
      'WHERE EmployeeID<>:KeyID AND Active="T"'
      'ORDER BY EmployeeName;')
    Left = 843
    Top = 285
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
    object qryEmpNamesEmployeeName: TWideStringField
      DisplayWidth = 40
      FieldName = 'EmployeeName'
      Size = 255
    end
    object qryEmpNamesEmployeeID: TAutoIncField
      FieldName = 'EmployeeID'
      ReadOnly = True
      Visible = False
    end
    object qryEmpNamesLastPaid: TDateField
      FieldName = 'LastPaid'
      Visible = False
    end
  end
  object qrySTPJobkeeperstartFNList: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblSTPJobkeeperFNList')
    Left = 680
    Top = 33
    object qrySTPJobkeeperstartFNListID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblstpjobkeeperfnlist.ID'
    end
    object qrySTPJobkeeperstartFNListFN: TWideStringField
      FieldName = 'FN'
      Origin = 'tblstpjobkeeperfnlist.FN'
    end
    object qrySTPJobkeeperstartFNListDateFrom: TDateField
      FieldName = 'DateFrom'
      Origin = 'tblstpjobkeeperfnlist.DateFrom'
    end
    object qrySTPJobkeeperstartFNListDateto: TDateField
      FieldName = 'Dateto'
      Origin = 'tblstpjobkeeperfnlist.Dateto'
    end
    object qrySTPJobkeeperstartFNListOtherAllowanceStartDescription: TWideStringField
      FieldName = 'OtherAllowanceStartDescription'
      Origin = 'tblstpjobkeeperfnlist.OtherAllowanceStartDescription'
      Size = 255
    end
    object qrySTPJobkeeperstartFNListOtherAllowanceFinishDescription: TWideStringField
      FieldName = 'OtherAllowanceFinishDescription'
      Origin = 'tblstpjobkeeperfnlist.OtherAllowanceFinishDescription'
      Size = 255
    end
    object qrySTPJobkeeperstartFNListmstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
      Origin = 'tblstpjobkeeperfnlist.mstimestamp'
    end
    object qrySTPJobkeeperstartFNListmsUpdateSitecode: TWideStringField
      FieldName = 'msUpdateSitecode'
      Origin = 'tblstpjobkeeperfnlist.msUpdateSitecode'
      Size = 3
    end
  end
  object qrySTPJobkeeperFinishFNList: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblSTPJobkeeperFNList')
    Left = 670
    Top = 113
    object qrySTPJobkeeperFinishFNListID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblstpjobkeeperfnlist.ID'
    end
    object qrySTPJobkeeperFinishFNListFN: TWideStringField
      FieldName = 'FN'
      Origin = 'tblstpjobkeeperfnlist.FN'
    end
    object qrySTPJobkeeperFinishFNListDateFrom: TDateField
      FieldName = 'DateFrom'
      Origin = 'tblstpjobkeeperfnlist.DateFrom'
    end
    object qrySTPJobkeeperFinishFNListDateto: TDateField
      FieldName = 'Dateto'
      Origin = 'tblstpjobkeeperfnlist.Dateto'
    end
    object qrySTPJobkeeperFinishFNListOtherAllowanceStartDescription: TWideStringField
      FieldName = 'OtherAllowanceStartDescription'
      Origin = 'tblstpjobkeeperfnlist.OtherAllowanceStartDescription'
      Size = 255
    end
    object qrySTPJobkeeperFinishFNListOtherAllowanceFinishDescription: TWideStringField
      FieldName = 'OtherAllowanceFinishDescription'
      Origin = 'tblstpjobkeeperfnlist.OtherAllowanceFinishDescription'
      Size = 255
    end
    object qrySTPJobkeeperFinishFNListmstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
      Origin = 'tblstpjobkeeperfnlist.mstimestamp'
    end
    object qrySTPJobkeeperFinishFNListmsUpdateSitecode: TWideStringField
      FieldName = 'msUpdateSitecode'
      Origin = 'tblstpjobkeeperfnlist.msUpdateSitecode'
      Size = 3
    end
  end
  object MyConnection: TERPConnection
    Database = 'madeurne_pty_ltd'
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
    Left = 266
    Top = 31
  end
end
