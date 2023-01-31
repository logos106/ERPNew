inherited fmTerminationWizard: TfmTerminationWizard
  HelpContext = 924001
  Caption = 'Termination Wizard'
  ClientHeight = 573
  ClientWidth = 897
  ExplicitWidth = 913
  ExplicitHeight = 612
  DesignSize = (
    897
    573)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 573
    Width = 897
    ExplicitTop = 573
    ExplicitWidth = 897
    HelpContext = 924056
  end
  object btnCancel: TDNMSpeedButton [5]
    Left = 515
    Top = 538
    Width = 87
    Height = 27
    HelpContext = 924006
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object sbMain: TScrollBox [6]
    Left = 8
    Top = 67
    Width = 881
    Height = 454
    HelpContext = 924007
    HorzScrollBar.Visible = False
    VertScrollBar.Position = 95
    VertScrollBar.Tracking = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvNone
    BevelKind = bkSoft
    BorderStyle = bsNone
    TabOrder = 3
    object pnlWizEmployee: TDNMPanel
      Left = 0
      Top = -95
      Width = 862
      Height = 193
      HelpContext = 924008
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object Label21: TLabel
        Left = 137
        Top = 15
        Width = 39
        Height = 15
        HelpContext = 924009
        Alignment = taRightJustify
        Caption = 'Name :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label1: TLabel
        Left = 355
        Top = 13
        Width = 196
        Height = 15
        HelpContext = 924010
        Caption = 'Name of employee to be terminated'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label56: TLabel
        Left = 73
        Top = 132
        Width = 102
        Height = 15
        HelpContext = 924011
        Caption = 'Termination Date :'
      end
      object Label2: TLabel
        Left = 355
        Top = 132
        Width = 135
        Height = 15
        HelpContext = 924012
        Caption = 'Last date of employment'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 32
        Top = 162
        Width = 145
        Height = 19
        HelpContext = 924013
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Reason for Termination :'
        Transparent = True
        WordWrap = True
      end
      object lblReasonNote: TLabel
        Left = 356
        Top = 162
        Width = 71
        Height = 15
        HelpContext = 924014
        Caption = 'Reason note'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label17: TLabel
        Left = 114
        Top = 103
        Width = 63
        Height = 15
        HelpContext = 924015
        Alignment = taRightJustify
        Caption = 'Start Date :'
      end
      object cboName: TwwDBLookupCombo
        Left = 182
        Top = 10
        Width = 150
        Height = 23
        HelpContext = 924016
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        DataField = 'EmployeeName'
        DataSource = dsTermination
        LookupTable = qryEmployees
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
        Top = 129
        Width = 150
        Height = 23
        Hint = 'Test hint'
        HelpContext = 924017
        AutoFillDateAndTime = True
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'EndDate'
        DataSource = dsTermination
        Date = 41053.000000000000000000
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
        Left = 183
        Top = 158
        Width = 150
        Height = 23
        HelpContext = 924018
        ShowButton = True
        Style = csDropDownList
        MapList = False
        AllowClearKey = False
        DataField = 'ReasonLeft'
        DataSource = dsTermination
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
        ItemIndex = 3
        ParentFont = False
        Sorted = False
        TabOrder = 2
        UnboundDataType = wwDefault
        OnChange = cboReasonChange
      end
      object rgTFNSupplied: TwwRadioGroup
        Left = 183
        Top = 44
        Width = 168
        Height = 43
        HelpContext = 924019
        DisableThemes = False
        Caption = 'Tax File Number Supplied'
        Columns = 2
        Items.Strings = (
          'Yes'
          'No')
        ReadOnly = True
        TabOrder = 3
      end
      object rgResident: TwwRadioGroup
        Left = 375
        Top = 42
        Width = 168
        Height = 43
        HelpContext = 924020
        DisableThemes = False
        Caption = 'Resident'
        Columns = 2
        Items.Strings = (
          'Yes'
          'No')
        ReadOnly = True
        TabOrder = 4
      end
      object dtStartDate: TwwDBDateTimePicker
        Left = 183
        Top = 100
        Width = 150
        Height = 23
        Hint = 'Test hint'
        HelpContext = 924021
        AutoFillDateAndTime = True
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'StartDate'
        DataSource = dsTermination
        Date = 41053.000000000000000000
        Epoch = 1950
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ShowButton = True
        TabOrder = 5
      end
    end
    object pnlWizDeath: TDNMPanel
      Left = 0
      Top = 98
      Width = 862
      Height = 37
      HelpContext = 924022
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object lblDeath: TLabel
        Left = 21
        Top = 11
        Width = 145
        Height = 19
        HelpContext = 924023
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Death Benefit Paid To :'
        Transparent = True
        WordWrap = True
      end
      object cboDeathPaidTo: TwwDBComboBox
        Left = 183
        Top = 6
        Width = 145
        Height = 23
        HelpContext = 924024
        ShowButton = True
        Style = csDropDown
        MapList = False
        AllowClearKey = False
        DataField = 'TypeOfDeathBenefit'
        DataSource = dsTermination
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
        TabOrder = 0
        UnboundDataType = wwDefault
      end
    end
    object pnlWizPay: TDNMPanel
      Left = 0
      Top = 135
      Width = 862
      Height = 144
      HelpContext = 924025
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label11: TLabel
        Left = 392
        Top = 19
        Width = 352
        Height = 49
        HelpContext = 924026
        AutoSize = False
        Caption = 
          'If the employee has not been paid for current work done, then pl' +
          'ease select "Pay Employee".  Otherwise select "Do not Pay Employ' +
          'ee".'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object lblPrepare: TLabel
        Left = 392
        Top = 98
        Width = 337
        Height = 35
        HelpContext = 924027
        AutoSize = False
        Caption = 
          'Please only adjust hours worked as the wizard will calculate the' +
          ' balance including leave.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object rgPayStatus: TwwRadioGroup
        Left = 183
        Top = 19
        Width = 178
        Height = 70
        HelpContext = 924028
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 5
        Transparent = True
        Caption = 'Payments for Unpaid Work'
        DataField = 'IsPayEntitled'
        DataSource = dsTermination
        Items.Strings = (
          'Pay Employee'
          'Do Not Pay Employee')
        TabOrder = 0
        Values.Strings = (
          'T'
          'F')
        OnChange = rgPayStatusChange
        OnClick = rgPayStatusClick
      end
      object btnPay: TDNMSpeedButton
        Left = 182
        Top = 98
        Width = 105
        Height = 27
        HelpContext = 924029
        Caption = '&View/Edit Pay'
        DisableTransparent = False
        Enabled = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 1
      end
    end
    object pnlWizUnusedAnnualLeaveDetail: TDNMPanel
      Left = 0
      Top = 279
      Width = 862
      Height = 96
      HelpContext = 924030
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Label3: TLabel
        Left = 33
        Top = 36
        Width = 145
        Height = 19
        HelpContext = 924031
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Pre 18 Aug 1993 :'
        Transparent = True
        WordWrap = True
      end
      object Label4: TLabel
        Left = 21
        Top = 11
        Width = 145
        Height = 19
        HelpContext = 924032
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Unused Annual Leave'
        Transparent = True
        WordWrap = True
      end
      object Label5: TLabel
        Left = 32
        Top = 63
        Width = 145
        Height = 19
        HelpContext = 924033
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'On or After 18 Aug 1993 :'
        Transparent = True
        WordWrap = True
      end
      object Label6: TLabel
        Left = 183
        Top = 10
        Width = 44
        Height = 15
        HelpContext = 924034
        Caption = 'Amount'
        Transparent = True
        WordWrap = True
      end
      object Label7: TLabel
        Left = 289
        Top = 10
        Width = 82
        Height = 15
        HelpContext = 924035
        Caption = 'Leave Loading'
        Transparent = True
      end
      object Label9: TLabel
        Left = 393
        Top = 10
        Width = 27
        Height = 15
        HelpContext = 924036
        Caption = 'Total'
        Transparent = True
      end
      object Label10: TLabel
        Left = 495
        Top = 10
        Width = 90
        Height = 15
        HelpContext = 924037
        Caption = 'Tax Withholding'
        Transparent = True
      end
      object edtAnnualLeaveAmount1: TDBAdvEdit
        Left = 182
        Top = 31
        Width = 81
        Height = 23
        HelpContext = 924038
        EditType = etMoney
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
      object edtAnnualLeaveLoading1: TDBAdvEdit
        Left = 286
        Top = 31
        Width = 81
        Height = 23
        HelpContext = 924039
        EditType = etMoney
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
      object edtAnnualLeaveTotal1: TDBAdvEdit
        Left = 392
        Top = 31
        Width = 81
        Height = 23
        HelpContext = 924040
        EditType = etMoney
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
      object edtAnnualLeaveTax1: TDBAdvEdit
        Left = 494
        Top = 31
        Width = 81
        Height = 23
        HelpContext = 924041
        EditType = etMoney
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
      object edtAnnualLeaveAmount2: TDBAdvEdit
        Left = 183
        Top = 60
        Width = 81
        Height = 23
        HelpContext = 924042
        EditType = etMoney
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
      object edtAnnualLeaveLoading2: TDBAdvEdit
        Left = 287
        Top = 60
        Width = 81
        Height = 23
        HelpContext = 924043
        EditType = etMoney
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
      object edtAnnualLeaveTotal2: TDBAdvEdit
        Left = 393
        Top = 60
        Width = 81
        Height = 23
        HelpContext = 924044
        EditType = etMoney
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
      object edtAnnualLeaveTax2: TDBAdvEdit
        Left = 495
        Top = 60
        Width = 81
        Height = 23
        HelpContext = 924045
        EditType = etMoney
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
    end
    object pnlWizUnusedAnnualLeaveTotal: TDNMPanel
      Left = 0
      Top = 375
      Width = 862
      Height = 77
      HelpContext = 924046
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Label12: TLabel
        Left = 11
        Top = 34
        Width = 165
        Height = 19
        HelpContext = 924047
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Total Unused Annual Leave :'
        Transparent = True
      end
      object Label13: TLabel
        Left = 183
        Top = 10
        Width = 44
        Height = 15
        HelpContext = 924048
        Caption = 'Amount'
        Transparent = True
        WordWrap = True
      end
      object Label14: TLabel
        Left = 289
        Top = 10
        Width = 82
        Height = 15
        HelpContext = 924049
        Caption = 'Leave Loading'
        Transparent = True
      end
      object Label15: TLabel
        Left = 393
        Top = 10
        Width = 27
        Height = 15
        HelpContext = 924050
        Caption = 'Total'
        Transparent = True
      end
      object Label16: TLabel
        Left = 495
        Top = 10
        Width = 90
        Height = 15
        HelpContext = 924051
        Caption = 'Tax Withholding'
        Transparent = True
      end
      object edtAnnualLeaveAmount: TDBAdvEdit
        Left = 182
        Top = 31
        Width = 81
        Height = 23
        HelpContext = 924052
        EditType = etMoney
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
      object edtAnnualLeaveLoading: TDBAdvEdit
        Left = 286
        Top = 31
        Width = 81
        Height = 23
        HelpContext = 924053
        EditType = etMoney
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
      object edtAnnualLeaveTotal: TDBAdvEdit
        Left = 392
        Top = 31
        Width = 81
        Height = 23
        HelpContext = 924054
        EditType = etMoney
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
      object edtAnnualLeaveTax: TDBAdvEdit
        Left = 494
        Top = 31
        Width = 81
        Height = 23
        HelpContext = 924055
        EditType = etMoney
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
    end
  end
  object btnOK: TDNMSpeedButton [7]
    Left = 327
    Top = 538
    Width = 87
    Height = 27
    HelpContext = 924005
    Anchors = [akBottom]
    Caption = 'Save'
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
    OnClick = btnOKClick
  end
  object pnlTitle: TDNMPanel [8]
    Left = 210
    Top = 6
    Width = 479
    Height = 45
    HelpContext = 924002
    Anchors = [akTop]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 475
      Height = 41
      HelpContext = 924003
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      FromColor = clBtnFace
      ToColor = clWhite
      FromColorMirror = clWhite
      ToColorMirror = clBtnFace
      Steps = 10
      Direction = False
      Version = '1.4.0.0'
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 475
        Height = 41
        HelpContext = 924004
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Termination Wizard'
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
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C0101020004003C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryTermination: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblEmployeeTerminations')
    Left = 32
    Top = 96
  end
  object dsTermination: TDataSource
    DataSet = qryTermination
    Left = 24
    Top = 144
  end
  object qryEmployees: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select EmployeeName, TFN, Resident, DateStarted from tblEmployee' +
        's where IsTerminated = "F"')
    Left = 296
    Top = 56
  end
end
