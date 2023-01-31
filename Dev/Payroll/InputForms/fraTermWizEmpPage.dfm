inherited frTermWizEmpPage: TfrTermWizEmpPage
  Width = 865
  ExplicitWidth = 865
  inherited pnlMain: TDNMPanel
    Width = 753
    ExplicitWidth = 753
    object Label21: TLabel
      Left = 133
      Top = 37
      Width = 33
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
    object Label1: TLabel
      Left = 389
      Top = 32
      Width = 196
      Height = 15
      Caption = 'Name of employee to be terminated'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label56: TLabel
      Left = 63
      Top = 79
      Width = 102
      Height = 15
      HelpContext = 582004
      Caption = 'Termination Date :'
    end
    object Label2: TLabel
      Left = 389
      Top = 74
      Width = 135
      Height = 15
      Caption = 'Last date of employment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 21
      Top = 121
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
      Left = 21
      Top = 164
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
    object cboName: TwwDBLookupCombo
      Left = 183
      Top = 29
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
      LookupField = 'EmployeeName'
      Style = csDropDownList
      DropDownWidth = 40
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object dtpTerminationDate: TwwDBDateTimePicker
      Left = 183
      Top = 71
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
      DataField = 'EndDate'
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 1
    end
    object cboReason: TwwDBComboBox
      Left = 182
      Top = 114
      Width = 187
      Height = 23
      HelpContext = 582009
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'ReasonLeft'
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
    end
    object cboDeathPaidTo: TwwDBComboBox
      Left = 183
      Top = 157
      Width = 145
      Height = 23
      HelpContext = 582010
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'TypeOfDeathBenefit'
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
  end
end
