inherited frmTerminateDetails: TfrmTerminateDetails
  Left = 1311
  Top = 385
  Width = 809
  Height = 480
  HelpContext = 582000
  Caption = 'frmTerminateDetails'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object DNMPanel1: TDNMPanel
    Left = 0
    Top = 40
    Width = 799
    Height = 283
    HelpContext = 582001
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      799
      283)
    object Bevel1: TBevel
      Left = 8
      Top = 8
      Width = 783
      Height = 268
      HelpContext = 582002
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object Label21: TLabel
      Left = 287
      Top = 61
      Width = 39
      Height = 15
      HelpContext = 582003
      Alignment = taRightJustify
      Caption = 'Name'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label56: TLabel
      Left = 223
      Top = 103
      Width = 103
      Height = 15
      HelpContext = 582004
      Caption = 'Termination Date :'
    end
    object Label8: TLabel
      Left = 181
      Top = 145
      Width = 145
      Height = 19
      HelpContext = 582005
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Reason for Termination :'
      Transparent = True
      WordWrap = True
    end
    object lblDeath: TLabel
      Left = 181
      Top = 188
      Width = 145
      Height = 19
      HelpContext = 582006
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Death Benefit Paid To :'
      Transparent = True
      Visible = False
      WordWrap = True
    end
    object Label1: TLabel
      Left = 544
      Top = 56
      Width = 196
      Height = 15
      Caption = 'Name of employee to be terminated'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      HelpContext = 582012
    end
    object Label2: TLabel
      Left = 544
      Top = 96
      Width = 135
      Height = 15
      Caption = 'Last date of employment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      HelpContext = 582013
    end
    object cboName: TwwDBLookupCombo
      Left = 343
      Top = 53
      Width = 186
      Height = 23
      HelpContext = 582007
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      DataField = 'EmployeeName'
      DataSource = DSEmpTerminate
      LookupTable = qryEmp
      LookupField = 'EmployeeName'
      Style = csDropDownList
      DropDownWidth = 40
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      OnCloseUp = cboNameCloseUp
    end
    object dtpTerminationDate: TwwDBDateTimePicker
      Left = 343
      Top = 95
      Width = 185
      Height = 23
      Hint = 'Test hint'
      HelpContext = 582008
      AutoFillDateAndTime = True
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      CalendarAttributes.PopupYearOptions.StartYear = 2000
      DataField = 'EndDate'
      DataSource = DSEmpTerminate
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 1
      UnboundDataType = wwDTEdtDate
      OnCloseUp = dtpTerminationDateCloseUp
    end
    object cboReason: TwwDBComboBox
      Left = 342
      Top = 138
      Width = 187
      Height = 23
      HelpContext = 582009
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'ReasonLeft'
      DataSource = DSEmpTerminate
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        'Death'
        'Dismissal'
        'Early Retirement'
        'Employee Left'
        'Invalidity'
        'Redundancy'
        'Retirement')
      ParentFont = False
      Sorted = False
      TabOrder = 2
      UnboundDataType = wwDefault
      OnDropDown = cboReasonDropDown
      OnCloseUp = cboReasonCloseUp
    end
    object cboDeathPaidTo: TwwDBComboBox
      Left = 343
      Top = 181
      Width = 145
      Height = 23
      HelpContext = 582010
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'TypeOfDeathBenefit'
      DataSource = DSEmpTerminate
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        'Trustee'
        'Dependant'
        'Non Dependant')
      ParentFont = False
      Sorted = False
      TabOrder = 3
      UnboundDataType = wwDefault
      Visible = False
    end
    object chkTFN: TwwCheckBox
      Left = 504
      Top = 184
      Width = 49
      Height = 17
      HelpContext = 582011
      AlwaysTransparent = False
      Frame.Enabled = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Caption = 'TFN'
      DataField = 'DeathBeneficiaryHasTFN'
      DataSource = DSEmpTerminate
      TabOrder = 4
      Visible = False
    end
  end
  object qryEmp: TERPQuery
    SQL.Strings = (
      'SELECT EmployeeID, EmployeeName '
      'FROM tblemployees'
      'WHERE Active = '#39'T'#39' AND IsTerminated = '#39'F'#39
      'ORDER BY EmployeeName')
    Left = 580
    Top = 3
  end
  object DSEmpTerminate: TDataSource
    Left = 424
    Top = 8
  end
end
