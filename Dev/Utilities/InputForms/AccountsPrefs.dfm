inherited AccountsPrefsGUI: TAccountsPrefsGUI
  Left = 670
  Top = 82
  HelpContext = 5000
  Caption = 'Accounts Preferences'
  ClientHeight = 931
  ClientWidth = 1088
  ExplicitWidth = 1104
  ExplicitHeight = 970
  PixelsPerInch = 96
  TextHeight = 13
  object lblWidth: TLabel [0]
    Left = 16
    Top = 8
    Width = 863
    Height = 22
    HelpContext = 5001
    Caption = 
      'All panels should have a width of 545.  Panel TabOrder is used f' +
      'or panel placement sequence.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited lblSkingroupMsg: TLabel
    Top = 931
    Width = 1088
    HelpContext = 5053
    ExplicitTop = 665
    ExplicitWidth = 912
  end
  inherited sbpanels: TAdvScrollBox
    Width = 1088
    Height = 931
    HelpContext = 5123
    VertScrollBar.Position = 263
    ExplicitWidth = 1088
    ExplicitHeight = 931
    object pnlClosingDates: TDNMPanel
      Left = 0
      Top = -263
      Width = 1069
      Height = 210
      HelpContext = 5022
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnDblClick = pnlClosingDatesDblClick
      object Bevel2: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1055
        Height = 196
        HelpContext = 5023
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 5
      end
      object lblPanelCaption_ClosingDates: TLabel
        Left = 14
        Top = 14
        Width = 78
        Height = 15
        HelpContext = 5024
        Caption = 'Closing Dates'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label7: TLabel
        Left = 248
        Top = 40
        Width = 53
        Height = 15
        HelpContext = 5025
        Caption = '(2) Global'
        Transparent = True
      end
      object Label8: TLabel
        Left = 24
        Top = 88
        Width = 137
        Height = 15
        HelpContext = 5026
        Caption = '(3) Accounts Receivable'
        Transparent = True
      end
      object Label9: TLabel
        Left = 248
        Top = 88
        Width = 120
        Height = 15
        HelpContext = 5027
        Caption = '(4) Accounts Payable'
        Transparent = True
      end
      object Label10: TLabel
        Left = 24
        Top = 40
        Width = 209
        Height = 15
        HelpContext = 5028
        Caption = '(1) Summarised Transactions Before'
        Transparent = True
      end
      object Label11: TLabel
        Left = 25
        Top = 142
        Width = 228
        Height = 15
        HelpContext = 5107
        Caption = 'Automatically Update the Closing Dates  '
        Transparent = True
      end
      object Label17: TLabel
        Left = 311
        Top = 142
        Width = 181
        Height = 15
        HelpContext = 5108
        Caption = 'Months after the Fiscal Year End'
        Transparent = True
      end
      object cboGlobal: TwwDBDateTimePicker
        Left = 248
        Top = 56
        Width = 193
        Height = 23
        HelpContext = 5029
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'ClosingDate'
        DataSource = dsPrefs
        Date = 39263.000000000000000000
        Epoch = 1950
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 1
        OnCloseUp = cboGlobalCloseUp
      end
      object cboAccountsRec: TwwDBDateTimePicker
        Left = 24
        Top = 104
        Width = 193
        Height = 23
        HelpContext = 5030
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'ClosingDateAR'
        DataSource = dsPrefs
        Date = 39263.000000000000000000
        Epoch = 1950
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 2
      end
      object cboAccountsPay: TwwDBDateTimePicker
        Left = 248
        Top = 104
        Width = 193
        Height = 23
        HelpContext = 5031
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'ClosingDateAP'
        DataSource = dsPrefs
        Date = 39263.000000000000000000
        Epoch = 1950
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 3
      end
      object cboSummarisedTransDate: TwwDBDateTimePicker
        Left = 24
        Top = 56
        Width = 193
        Height = 23
        HelpContext = 5032
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'SummarisedTransDate'
        DataSource = dsPrefs
        Date = 39263.000000000000000000
        Epoch = 1950
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 0
        OnEnter = cboSummarisedTransDateEnter
      end
      object btnRefresh: TDNMSpeedButton
        Left = 24
        Top = 167
        Width = 98
        Height = 25
        HelpContext = 5033
        Caption = 'Refresh'
        Color = clWhite
        DisableTransparent = False
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentColor = False
        Style = bsModern
        TabOrder = 4
        AutoDisableParentOnclick = True
        OnClick = btnRefreshClick
        OnEnter = btnRefreshEnter
      end
      object wwDBEdit12: TwwDBEdit
        Left = 472
        Top = 85
        Width = 57
        Height = 23
        HelpContext = 5111
        DataField = 'NoOfMonthstoChangeClosingdate'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        UnboundDataType = wwDefault
        Visible = False
        WantReturns = False
        WordWrap = False
      end
      object btnSetToStart: TDNMSpeedButton
        Left = 395
        Top = 167
        Width = 65
        Height = 25
        HelpContext = 5112
        Caption = '<<   10 yrs'
        Color = clWhite
        DisableTransparent = False
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentColor = False
        Style = bsModern
        TabOrder = 6
        AutoDisableParentOnclick = True
        OnClick = btnSetToStartClick
      end
      object chkDisableAutoUpdateclosingDate: TwwCheckBox
        Left = 537
        Top = 141
        Width = 233
        Height = 17
        HelpContext = 5113
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
        Caption = 'Disable Auto - Update the Closing Dates  '
        DataField = 'DisableAutoUpdateclosingDate'
        DataSource = dsPrefs
        TabOrder = 8
        Visible = False
      end
      object wwDBSpinEdit1: TwwDBSpinEdit
        Left = 248
        Top = 138
        Width = 57
        Height = 23
        HelpContext = 5066
        Increment = 1.000000000000000000
        MaxValue = 9.000000000000000000
        MinValue = 3.000000000000000000
        DataField = 'NoOfMonthstoChangeClosingdate'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        UnboundDataType = wwDefault
      end
      object btnSetToCurrent: TDNMSpeedButton
        Left = 466
        Top = 167
        Width = 65
        Height = 25
        HelpContext = 5122
        Caption = '10 yrs >>'
        Color = clWhite
        DisableTransparent = False
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentColor = False
        Style = bsModern
        TabOrder = 9
        AutoDisableParentOnclick = True
        OnClick = btnSetToCurrentClick
      end
    end
    object pnlNewUserDefaults: TDNMPanel
      Left = 0
      Top = 757
      Width = 1069
      Height = 446
      HelpContext = 5094
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      DesignSize = (
        1069
        446)
      object Bevel3: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1055
        Height = 432
        HelpContext = 5095
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 9
        ExplicitTop = 9
      end
      object Shape1: TShape
        Left = 24
        Top = 110
        Width = 501
        Height = 220
        HelpContext = 5124
        Brush.Style = bsClear
        Pen.Color = clGray
      end
      object lblPanelCaption_DefaultValuesForNewCustomer: TLabel
        Left = 14
        Top = 14
        Width = 189
        Height = 15
        HelpContext = 5097
        Caption = 'Default Values For New Customer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label13: TLabel
        Left = 86
        Top = 30
        Width = 36
        Height = 15
        HelpContext = 5098
        Caption = 'Terms'
        Transparent = True
      end
      object Label14: TLabel
        Left = 244
        Top = 30
        Width = 65
        Height = 15
        HelpContext = 5039
        Caption = 'Credit Limit'
        Transparent = True
      end
      object Label15: TLabel
        Left = 402
        Top = 30
        Width = 113
        Height = 15
        HelpContext = 5040
        Caption = 'Grace Period (Days)'
        Transparent = True
      end
      object Label16: TLabel
        Left = 25
        Top = 89
        Width = 121
        Height = 15
        HelpContext = 5041
        Caption = 'Apply Credit Check to'
        Transparent = True
      end
      object Label18: TLabel
        Left = 209
        Top = 118
        Width = 73
        Height = 30
        HelpContext = 5125
        Alignment = taCenter
        Caption = 'Enable Credit Check'
        Transparent = True
        WordWrap = True
      end
      object Label20: TLabel
        Left = 313
        Top = 115
        Width = 138
        Height = 15
        HelpContext = 5126
        Alignment = taCenter
        Caption = 'When Credit Check Fails'
        Transparent = True
      end
      object Label22: TLabel
        Left = 290
        Top = 140
        Width = 82
        Height = 15
        HelpContext = 5127
        Alignment = taCenter
        Caption = 'Change Terms'
        Transparent = True
        WordWrap = True
      end
      object Label23: TLabel
        Left = 380
        Top = 141
        Width = 29
        Height = 15
        HelpContext = 5128
        Alignment = taCenter
        Caption = 'Term'
        Transparent = True
        WordWrap = True
      end
      object Shape2: TShape
        Left = 289
        Top = 110
        Width = 1
        Height = 220
        HelpContext = 5129
        Pen.Color = clGray
      end
      object Shape4: TShape
        Left = 374
        Top = 135
        Width = 1
        Height = 195
        HelpContext = 5130
        Pen.Color = clGray
      end
      object Shape5: TShape
        Left = 290
        Top = 134
        Width = 236
        Height = 1
        HelpContext = 5131
        Pen.Color = clGray
      end
      object Shape6: TShape
        Left = 200
        Top = 160
        Width = 325
        Height = 1
        HelpContext = 5132
        Pen.Color = clGray
      end
      object Label36: TLabel
        Left = 15
        Top = 71
        Width = 73
        Height = 15
        HelpContext = 5133
        Caption = 'Credit Check'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Shape3: TShape
        Left = 200
        Top = 110
        Width = 1
        Height = 220
        HelpContext = 5134
        Pen.Color = clGray
      end
      object wwDBLookupCombo2: TwwDBLookupCombo
        Left = 86
        Top = 46
        Width = 121
        Height = 23
        HelpContext = 5046
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Terms'#9'30'#9'Terms'#9'T')
        DataField = 'CreditTermsID'
        DataSource = dsPrefs
        LookupTable = qryTerms
        LookupField = 'TermsID'
        ParentFont = False
        TabOrder = 0
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBEdit3: TwwDBEdit
        Left = 244
        Top = 46
        Width = 121
        Height = 23
        HelpContext = 5047
        DataField = 'CreditLimit'
        DataSource = dsPrefs
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
      object wwDBEdit4: TwwDBEdit
        Left = 402
        Top = 46
        Width = 121
        Height = 23
        HelpContext = 5102
        DataField = 'GracePeriod'
        DataSource = dsPrefs
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
      object wwCheckBox1: TwwCheckBox
        Left = 93
        Top = 268
        Width = 155
        Height = 17
        HelpContext = 5049
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
        Alignment = taLeftJustify
        Caption = 'Appointment'
        DataField = 'CreditCheckAppointment'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object wwCheckBox3: TwwCheckBox
        Left = 123
        Top = 204
        Width = 125
        Height = 17
        HelpContext = 5103
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
        Alignment = taLeftJustify
        Caption = 'Invoice'
        Checked = True
        DataField = 'CreditCheckInv'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 4
      end
      object wwCheckBox4: TwwCheckBox
        Left = 93
        Top = 172
        Width = 155
        Height = 17
        HelpContext = 5052
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
        Alignment = taLeftJustify
        Caption = 'Sales Order'
        DataField = 'CreditCheckSO'
        DataSource = dsPrefs
        TabOrder = 5
      end
      object wwCheckBox5: TwwCheckBox
        Left = 123
        Top = 236
        Width = 125
        Height = 17
        HelpContext = 5104
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
        Alignment = taLeftJustify
        Caption = 'Repair'
        Checked = True
        DataField = 'CreditCheckRepair'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 6
      end
      object chkCreditCheckPO: TwwCheckBox
        Left = 77
        Top = 300
        Width = 171
        Height = 17
        HelpContext = 5105
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
        Alignment = taLeftJustify
        Caption = 'Purchase Order'
        Checked = True
        DataField = 'CreditCheckPO'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 7
        OnClick = chkCreditCheckPOClick
      end
      object chkCreditcheckPOIncludeBO: TwwCheckBox
        Left = 27
        Top = 341
        Width = 444
        Height = 17
        HelpContext = 5106
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
        Caption = 'Include Backorder Estimated Cost in Supplier Credit'
        Checked = True
        DataField = 'CreditcheckPOIncludeBO'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 8
        OnClick = chkCreditcheckPOIncludeBOClick
        OnEnter = chkCreditcheckPOIncludeBOEnter
      end
      object chkPreventInvoiceOnStopCredit: TwwCheckBox
        Left = 27
        Top = 375
        Width = 444
        Height = 17
        HelpContext = 5118
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
        Caption = 'Prevent Invoice Creation for Customers on Stop Credit'
        DataField = 'PreventInvoiceOnStopCredit'
        DataSource = dsPrefs
        TabOrder = 9
      end
      object chkPreventSalesOrderOnStopCredit: TwwCheckBox
        Left = 27
        Top = 409
        Width = 444
        Height = 17
        HelpContext = 5119
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
        Caption = 'Prevent Sales Order Creation for Customers on Stop Credit'
        DataField = 'PreventSalesOrderOnStopCredit'
        DataSource = dsPrefs
        TabOrder = 10
      end
      object wwDBLookupCombo3: TwwDBLookupCombo
        Left = 380
        Top = 201
        Width = 121
        Height = 23
        HelpContext = 5135
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Terms'#9'30'#9'Terms'#9'T')
        DataField = 'CreditCheckTermsInv'
        DataSource = dsPrefs
        LookupTable = QryTermsCreditCheckTermsInv
        LookupField = 'Terms'
        ParentFont = False
        TabOrder = 11
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo4: TwwDBLookupCombo
        Left = 380
        Top = 169
        Width = 121
        Height = 23
        HelpContext = 5136
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Terms'#9'30'#9'Terms'#9'T')
        DataField = 'CreditCheckTermsSO'
        DataSource = dsPrefs
        LookupTable = QrytermsCreditCheckTermsSO
        LookupField = 'Terms'
        ParentFont = False
        TabOrder = 12
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwCheckBox2: TwwCheckBox
        Left = 323
        Top = 204
        Width = 16
        Height = 17
        HelpContext = 5137
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
        Caption = 'wwCheckBox1'
        Checked = True
        DataField = 'ChangeCreditCheckTermsInv'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 13
      end
      object wwCheckBox7: TwwCheckBox
        Left = 323
        Top = 172
        Width = 16
        Height = 17
        HelpContext = 5138
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
        Caption = 'wwCheckBox1'
        DataField = 'ChangeCreditCheckTermsSO'
        DataSource = dsPrefs
        TabOrder = 14
      end
    end
    object pnlBudget: TDNMPanel
      Left = 0
      Top = 1508
      Width = 1069
      Height = 99
      HelpContext = 5089
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Bevel9: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1055
        Height = 85
        HelpContext = 5090
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 83
      end
      object lblPanelCaption_Budget: TLabel
        Left = 14
        Top = 14
        Width = 40
        Height = 15
        HelpContext = 5091
        Caption = 'Budget'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox10: TwwCheckBox
        Left = 53
        Top = 42
        Width = 333
        Height = 17
        HelpContext = 5093
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
        Caption = 'Show Account No in Budget'
        DataField = 'ShowAccountNumberinBudget'
        DataSource = dsPrefs
        TabOrder = 0
      end
    end
    object pnlBASAccountingMethod: TDNMPanel
      Left = 0
      Top = 1425
      Width = 1069
      Height = 83
      HelpContext = 5067
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object Bevel10: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1055
        Height = 69
        HelpContext = 5068
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 67
      end
      object lblPanelCaption_BAS: TLabel
        Left = 14
        Top = 14
        Width = 185
        Height = 15
        HelpContext = 5069
        Caption = 'BAS : Default Accounting Method'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwRadioGroup1: TwwRadioGroup
        Left = 24
        Top = 32
        Width = 258
        Height = 33
        HelpContext = 5071
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 5
        ShowGroupCaption = False
        Transparent = True
        NoSpacing = True
        Columns = 2
        DataField = 'DefaultAccountingMethod'
        DataSource = dsPrefs
        Items.Strings = (
          'Accrual'
          'Cash')
        TabOrder = 0
        Values.Strings = (
          'Accrual'
          'Cash')
        OnChange = wwRadioGroup1Change
      end
      object chkIncludeJournalsInCashBAS: TwwCheckBox
        Left = 315
        Top = 39
        Width = 206
        Height = 17
        HelpContext = 5072
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
        Caption = 'Include Journals in Cash BAS'
        DataField = 'IncludeJournalsInCashBAS'
        DataSource = dsPrefs
        TabOrder = 1
      end
    end
    object pnlGeneral: TDNMPanel
      Left = 0
      Top = -53
      Width = 1069
      Height = 622
      HelpContext = 5002
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Bevel1: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1055
        Height = 608
        HelpContext = 5003
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 5
        ExplicitWidth = 1051
      end
      object lblPanelCaption_General: TLabel
        Left = 14
        Top = 14
        Width = 44
        Height = 15
        HelpContext = 5004
        Caption = 'General'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label2: TLabel
        Left = 24
        Top = 40
        Width = 99
        Height = 15
        HelpContext = 5005
        Caption = 'Fiscal Year Starts'
        Transparent = True
      end
      object Label3: TLabel
        Left = 24
        Top = 253
        Width = 183
        Height = 15
        HelpContext = 5006
        Caption = 'NAB CardFast Merchant Number'
        Transparent = True
      end
      object Label4: TLabel
        Left = 204
        Top = 40
        Width = 81
        Height = 15
        HelpContext = 5007
        Caption = 'Class Heading'
        Transparent = True
      end
      object Label5: TLabel
        Left = 384
        Top = 40
        Width = 75
        Height = 15
        HelpContext = 5008
        Caption = 'Default Class'
        Transparent = True
      end
      object Label32: TLabel
        Left = 25
        Top = 356
        Width = 227
        Height = 15
        HelpContext = 5012
        Caption = 'The Order that Accounts Appear in Lists'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label33: TLabel
        Left = 25
        Top = 317
        Width = 190
        Height = 15
        HelpContext = 5060
        Caption = 'Company Income Tax Percentage'
        Transparent = True
      end
      object Label34: TLabel
        Left = 24
        Top = 89
        Width = 76
        Height = 15
        HelpContext = 5114
        Caption = 'Area Heading'
        Transparent = True
      end
      object wwDBEdit1: TwwDBEdit
        Left = 204
        Top = 56
        Width = 137
        Height = 23
        HelpContext = 5013
        DataField = 'ClassHeading'
        DataSource = dsColumnHeadings
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
        Left = 24
        Top = 269
        Width = 193
        Height = 23
        HelpContext = 5014
        DataField = 'NABCardFastMerchantNumber'
        DataSource = dsPrefs
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
      object wwDBComboBox1: TwwDBComboBox
        Left = 24
        Top = 56
        Width = 137
        Height = 23
        HelpContext = 5015
        ShowButton = True
        Style = csDropDown
        MapList = False
        AllowClearKey = False
        AutoDropDown = True
        DataField = 'FiscalYearStarts'
        DataSource = dsPrefs
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          'January'
          'February'
          'March'
          'April'
          'May'
          'June'
          'July'
          'August'
          'September'
          'October'
          'November'
          'December')
        ItemIndex = 6
        ParentFont = False
        Sorted = False
        TabOrder = 0
        UnboundDataType = wwDefault
        OnCloseUp = wwDBComboBox1CloseUp
      end
      object wwDBLookupCombo1: TwwDBLookupCombo
        Left = 384
        Top = 56
        Width = 137
        Height = 23
        HelpContext = 5016
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ClassName'#9'30'#9'Class Name'#9'T')
        DataField = 'DefaultClass'
        DataSource = dsColumnHeadings
        LookupTable = qryClass
        LookupField = 'ClassName'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 2
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnBeforeDropDown = wwDBLookupCombo1BeforeDropDown
      end
      object chkShowOnlyActiveClass: TwwCheckBox
        Left = 24
        Top = 137
        Width = 333
        Height = 17
        HelpContext = 5017
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
        Caption = 'Show Only Active Class On Reports'
        Checked = True
        DataField = 'ShowActiveClassOnReports'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 3
      end
      object chkDefaultToTreeView: TwwCheckBox
        Left = 24
        Top = 165
        Width = 333
        Height = 17
        HelpContext = 5018
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
        Caption = 'Default to Tree View for Chart of Accounts List'
        DataField = 'DefaultAccountsTreeView'
        DataSource = dsPrefs
        TabOrder = 4
      end
      object chkForcePriceUpdateOnMemsTrans: TwwCheckBox
        Left = 24
        Top = 193
        Width = 333
        Height = 17
        HelpContext = 5019
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
        Caption = 'Force Price Update on Memorised Transactions '
        Checked = True
        DataField = 'MemTransPriceUpdate'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 5
      end
      object grdAccountTypes: TwwDBGrid
        Left = 25
        Top = 374
        Width = 328
        Height = 224
        HelpContext = 5020
        Selected.Strings = (
          'AccDesc'#9'30'#9'Account'#9'T'
          'SortOrder'#9'7'#9'List Order'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = dsAccountTypes
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = []
        ParentFont = False
        TabOrder = 9
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
      end
      object btnTenderAccounts: TDNMSpeedButton
        Left = 271
        Top = 269
        Width = 163
        Height = 25
        HelpContext = 5021
        Caption = 'Auto Deposit Accounts'
        Color = clWhite
        DisableTransparent = False
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentColor = False
        Style = bsModern
        TabOrder = 8
        AutoDisableParentOnclick = True
        OnClick = btnTenderAccountsClick
      end
      object wwDBSpinEdit2: TwwDBSpinEdit
        Left = 232
        Top = 311
        Width = 65
        Height = 23
        HelpContext = 5063
        Increment = 1.000000000000000000
        MaxValue = 32767.000000000000000000
        Value = 5.000000000000000000
        DataField = 'IncomeTaxPercentage'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        UnboundDataType = wwDefault
      end
      object wwCheckBox11: TwwCheckBox
        Left = 313
        Top = 315
        Width = 156
        Height = 16
        HelpContext = 5064
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
        Caption = 'Show $0.00 if Loss'
        Checked = True
        DataField = 'ZerotaxWhenLoss'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 11
      end
      object chkShowAccountNumbers: TwwCheckBox
        Left = 24
        Top = 222
        Width = 333
        Height = 17
        HelpContext = 5065
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
        Caption = 'Show Account Numbers'
        DataField = 'ShowAccountNumbers'
        DataSource = dsPrefs
        TabOrder = 6
      end
      object wwDBEdit13: TwwDBEdit
        Left = 24
        Top = 106
        Width = 137
        Height = 23
        HelpContext = 5115
        DataField = 'AreaColumnName'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
    end
    object pnlAccountComboSettings: TDNMPanel
      Tag = 11
      Left = 0
      Top = 569
      Width = 1069
      Height = 188
      HelpContext = 5139
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      object Bevel11: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1055
        Height = 174
        HelpContext = 5140
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 9
      end
      object lblPanelCaption_AccountComboDropdownWidths: TLabel
        Left = 14
        Top = 14
        Width = 194
        Height = 15
        HelpContext = 5141
        Caption = 'Account Combo Dropdown Widths'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object lblProductName: TLabel
        Left = 80
        Top = 48
        Width = 83
        Height = 15
        HelpContext = 5142
        Alignment = taRightJustify
        Caption = 'Account Name'
        Transparent = True
      end
      object lblProductfirstcolumn: TLabel
        Left = 87
        Top = 80
        Width = 76
        Height = 15
        HelpContext = 5143
        Alignment = taRightJustify
        Caption = 'Account Type'
        Transparent = True
      end
      object lblProductSecondcolumn: TLabel
        Left = 48
        Top = 112
        Width = 115
        Height = 15
        HelpContext = 5144
        Alignment = taRightJustify
        Caption = 'Account Description'
        Transparent = True
      end
      object lblProductcomboWidthHint: TLabel
        Left = 44
        Top = 139
        Width = 397
        Height = 30
        HelpContext = 5145
        Alignment = taCenter
        AutoSize = False
        Caption = 
          'Width of the Columns will not reduce less than the Length of the' +
          ' Label Associated with the Field.  '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object wwDBEdit14: TwwDBEdit
        Left = 167
        Top = 44
        Width = 66
        Height = 23
        HelpContext = 5146
        DataField = 'AccountNamecolumnDropdownWidth'
        DataSource = dsPrefs
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
      object wwDBEdit15: TwwDBEdit
        Left = 167
        Top = 76
        Width = 66
        Height = 23
        HelpContext = 5147
        DataField = 'AccountTypecolumnDropdownWidth'
        DataSource = dsPrefs
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
      object wwDBEdit16: TwwDBEdit
        Left = 168
        Top = 109
        Width = 66
        Height = 23
        HelpContext = 5148
        DataField = 'AccountDescriptioncolumnDropdownWidth'
        DataSource = dsPrefs
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
    object pnlItrastat: TDNMPanel
      Left = 0
      Top = 1607
      Width = 1069
      Height = 99
      HelpContext = 5034
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      Category = 'For later use'
      object Bevel12: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1055
        Height = 85
        HelpContext = 5035
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 83
      end
      object lblPanelCaption_IntraStat: TLabel
        Left = 14
        Top = 14
        Width = 48
        Height = 15
        HelpContext = 5037
        Caption = 'Intrastat'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox12: TwwCheckBox
        Left = 53
        Top = 40
        Width = 300
        Height = 17
        HelpContext = 5050
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
        Caption = 'Use electronic submission'
        DataField = 'UseElectronicIntrastat'
        DataSource = dsPrefs
        TabOrder = 0
      end
    end
    object DNMPanel1: TDNMPanel
      Left = 0
      Top = 1338
      Width = 1069
      Height = 87
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      object Bevel4: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1055
        Height = 73
        HelpContext = 5095
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 9
        ExplicitTop = 9
        ExplicitHeight = 432
      end
      object Label1: TLabel
        Left = 14
        Top = 14
        Width = 180
        Height = 15
        HelpContext = 5097
        Caption = 'Default Values For New Supplier'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label6: TLabel
        Left = 131
        Top = 47
        Width = 36
        Height = 15
        HelpContext = 5098
        Caption = 'Terms'
        Transparent = True
      end
      object wwDBLookupCombo5: TwwDBLookupCombo
        Left = 204
        Top = 43
        Width = 121
        Height = 23
        HelpContext = 5046
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Terms'#9'30'#9'Terms'#9'T')
        DataField = 'DebitTermsID'
        DataSource = dsPrefs
        LookupTable = QryDebitTerms
        LookupField = 'TermsID'
        ParentFont = False
        TabOrder = 0
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
    end
    object pnlVS1: TDNMPanel
      Left = 0
      Top = 1203
      Width = 1069
      Height = 135
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      object Bevel5: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1055
        Height = 121
        HelpContext = 5095
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 5
        ExplicitHeight = 208
      end
      object Label12: TLabel
        Left = 14
        Top = 14
        Width = 249
        Height = 15
        HelpContext = 5097
        Caption = 'VS1 Summary Calculation on Update Batch  '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox6: TwwCheckBox
        Left = 25
        Top = 40
        Width = 177
        Height = 17
        HelpContext = 5017
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
        Caption = 'General Summary'
        Checked = True
        DataField = 'UpdatebatchRunVS1_sum'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 0
      end
      object wwCheckBox8: TwwCheckBox
        Left = 25
        Top = 69
        Width = 177
        Height = 17
        HelpContext = 5017
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
        Caption = 'Profit And Loss Report'
        Checked = True
        DataField = 'UpdatebatchRunVS1_PnLReport'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 1
      end
      object wwCheckBox9: TwwCheckBox
        Left = 25
        Top = 99
        Width = 177
        Height = 17
        HelpContext = 5017
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
        Caption = 'Profit And Loss Summary'
        Checked = True
        DataField = 'UpdatebatchRunVS1_PnLReport_Sum'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 2
      end
      object wwCheckBox13: TwwCheckBox
        Left = 232
        Top = 40
        Width = 177
        Height = 17
        HelpContext = 5017
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
        Caption = 'Accounts  Payable Report'
        Checked = True
        DataField = 'UpdatebatchRunVS1_APReport'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 3
      end
      object wwCheckBox14: TwwCheckBox
        Left = 232
        Top = 70
        Width = 177
        Height = 17
        HelpContext = 5017
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
        Caption = 'Sales List '
        Checked = True
        DataField = 'UpdatebatchRunVS1_SalesList'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 4
      end
      object wwCheckBox15: TwwCheckBox
        Left = 232
        Top = 100
        Width = 177
        Height = 17
        HelpContext = 5017
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
        Caption = 'PQA summary'
        Checked = True
        DataField = 'UpdatebatchRunVS1_PQASumList'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 5
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 185
    Top = 65531
  end
  inherited tmrdelay: TTimer
    Left = 112
  end
  object MyConnection: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    LoginPrompt = False
    Left = 600
    Top = 50
  end
  object dsPrefs: TDataSourcePrefs
    Connection = MyConnection
    FieldDefs = <>
    FieldNames.Strings = (
      'AccountDescriptioncolumnDropdownWidth'
      'AccountNamecolumnDropdownWidth'
      'AccountTypecolumnDropdownWidth'
      'AreaColumnName'
      'AutomaticallyUpdateclosingDate'
      'ChangeCreditCheckTermsInv'
      'ChangeCreditCheckTermsSO'
      'ClosingDate'
      'ClosingDateAP'
      'ClosingDateAR'
      'CreditCheckAppointment'
      'CreditCheckInv'
      'CreditCheckPO'
      'CreditcheckPOIncludeBO'
      'CreditCheckRepair'
      'CreditCheckSO'
      'CreditCheckTermsInv'
      'CreditCheckTermsSO'
      'CreditLimit'
      'CreditTermsID'
      'DebitTermsID'
      'DefaultAccountingMethod'
      'DefaultAccountsTreeView'
      'DisableAutoUpdateclosingDate'
      'FiscalYearStarts'
      'GracePeriod'
      'IncludeJournalsInCashBAS'
      'IncomeTaxPercentage'
      'MemTransPriceUpdate'
      'NABCardFastMerchantNumber'
      'NoOfMonthstoChangeClosingdate'
      'PreventInvoiceOnStopCredit'
      'PreventSalesOrderOnStopCredit'
      'ShowAccountNumberinBudget'
      'ShowAccountNumbers'
      'ShowActiveClassOnReports'
      'SummarisedTransDate'
      'SummarisedTransDateChanged'
      'TrialBalanceAdjustAccount'
      'UKGatewayIsLive'
      'UpdatebatchRunVS1_APReport'
      'UpdatebatchRunVS1_PnLReport'
      'UpdatebatchRunVS1_PnLReport_Sum'
      'UpdatebatchRunVS1_PQASumList'
      'UpdatebatchRunVS1_SalesList'
      'UpdatebatchRunVS1_sum'
      'UseElectronicIntrastat'
      'UseElectronicVAT'
      'VATAuthentication'
      'VATCurrencyCode'
      'VATKeys'
      'VATKeyType'
      'VATMaxAttemptsPerSession'
      'VATSenderID'
      'VATVendorID'
      'ZerotaxwhenLoss')
    Left = 639
    Top = 50
  end
  object qryClass: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClassID, ClassName, ClassPercent , SiteCode'
      'FROM tblClass '
      'WHERE (ClassName Is Not Null) AND (Active <> '#39'F'#39') '
      'ORDER BY ClassName;')
    Left = 680
    Top = 48
  end
  object dsColumnHeadings: TDataSource
    DataSet = qryColumnHeadings
    Left = 720
    Top = 48
  end
  object qryColumnHeadings: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblcolumnheadings')
    AfterPost = qryColumnHeadingsAfterPost
    Left = 760
    Top = 48
  end
  object dsAccountTypes: TDataSource
    DataSet = qryAccountTypes
    Left = 800
    Top = 48
  end
  object qryAccountTypes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblacctypedesc order by SortOrder')
    AfterPost = qryAccountTypesAfterPost
    Left = 840
    Top = 48
  end
  object qryTerms: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblterms')
    Left = 640
    Top = 88
  end
  object QryTermsCreditCheckTermsInv: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblterms')
    Left = 864
    Top = 208
  end
  object QrytermsCreditCheckTermsSO: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblterms')
    Left = 864
    Top = 168
  end
  object qryAccount: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblChartofAccounts.*, AccDesc as Type'
      'FROM tblChartofAccounts'
      'LEFT JOIN tblacctypedesc on  AccType = AccountType'
      'WHERE IsHeader = '#39'F'#39' AND Active = '#39'T'#39
      'ORDER BY AccDesc, AccountName;')
    Left = 874
    Top = 56
  end
  object QryDebitTerms: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblterms')
    Left = 680
    Top = 88
  end
end
