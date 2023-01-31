inherited fmBudget: TfmBudget
  Left = 176
  Top = 261
  HelpContext = 143000
  Caption = 'Budget'
  ClientHeight = 554
  ClientWidth = 1001
  Color = 14153215
  OldCreateOrder = True
  ExplicitLeft = 176
  ExplicitTop = 261
  ExplicitWidth = 1017
  ExplicitHeight = 593
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 482
    Width = 1001
    ExplicitTop = 482
    ExplicitWidth = 1001
    HelpContext = 143044
  end
  inherited imgGridWatermark: TImage
    HelpContext = 143001
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 1001
    Height = 45
    HelpContext = 143040
    Align = alTop
    BevelOuter = bvNone
    Color = 14153215
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Locked = True
    ParentFont = False
    TabOrder = 0
    Transparent = False
  end
  object pnlTitle: TDNMPanel [6]
    Left = 381
    Top = 2
    Width = 238
    Height = 45
    HelpContext = 143041
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 234
      Height = 41
      HelpContext = 143042
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
        Width = 234
        Height = 41
        HelpContext = 143043
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Budget '
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
  object DNMPanel5: TDNMPanel [7]
    Left = 0
    Top = 482
    Width = 1001
    Height = 72
    HelpContext = 143012
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Locked = True
    ParentColor = True
    ParentFont = False
    TabOrder = 4
    Transparent = False
    DesignSize = (
      1001
      72)
    object Label4: TLabel
      Left = 954
      Top = 41
      Width = 35
      Height = 15
      HelpContext = 143013
      Anchors = [akRight, akBottom]
      Caption = 'Active'
      Transparent = True
    end
    object Label7: TLabel
      Left = 23
      Top = 25
      Width = 169
      Height = 15
      HelpContext = 143014
      Anchors = [akLeft, akBottom]
      Caption = 'Freeze Account Name column'
      Transparent = True
    end
    object Label8: TLabel
      Left = 22
      Top = 47
      Width = 63
      Height = 15
      HelpContext = 143015
      Anchors = [akLeft, akBottom]
      Caption = 'Show Jobs'
      Transparent = True
    end
    object Label9: TLabel
      Left = 0
      Top = 4
      Width = 1001
      Height = 15
      HelpContext = 143016
      Alignment = taCenter
      AutoSize = False
      Caption = 
        '"Double Click on any Field to get the full budget of the account' +
        ' selected in the current record"'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object btnSave: TDNMSpeedButton
      Left = 207
      Top = 31
      Width = 87
      Height = 27
      HelpContext = 143017
      Anchors = [akBottom]
      Caption = '&Save'
      Default = True
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
      AutoDisableParentOnclick = True
      OnClick = btnSaveClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 783
      Top = 31
      Width = 87
      Height = 27
      HelpContext = 143018
      Anchors = [akBottom]
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
      NumGlyphs = 2
      TabOrder = 8
      AutoDisableParentOnclick = True
      OnClick = btnCancelClick
    end
    object btnNew: TDNMSpeedButton
      Left = 317
      Top = 31
      Width = 87
      Height = 27
      HelpContext = 143019
      Anchors = [akBottom]
      Caption = '&Next Period'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = btnNewClick
    end
    object chkActive: TwwCheckBox
      Left = 934
      Top = 39
      Width = 17
      Height = 17
      HelpContext = 143020
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
      Anchors = [akRight, akBottom]
      Caption = 'chkActive'
      DataField = 'Active'
      DataSource = dsBudget
      TabOrder = 2
      OnEnter = chkActiveEnter
    end
    object chkFreezeColumn: TwwCheckBox
      Left = 3
      Top = 23
      Width = 17
      Height = 17
      HelpContext = 143021
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
      Caption = '&Add To Filter'
      TabOrder = 0
      OnClick = chkFreezeColumnClick
    end
    object chkbugetforJob: TwwCheckBox
      Left = 2
      Top = 45
      Width = 17
      Height = 17
      HelpContext = 143022
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
      Caption = 'chkActive'
      TabOrder = 1
      OnClick = chkbugetforJobClick
    end
    object btnCopy: TDNMSpeedButton
      Left = 647
      Top = 31
      Width = 121
      Height = 27
      HelpContext = 143023
      Anchors = [akBottom]
      Cancel = True
      Caption = 'Copy to All Periods'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      TabOrder = 7
      AutoDisableParentOnclick = True
      OnClick = btnCopyClick
    end
    object btnExport: TDNMSpeedButton
      Left = 427
      Top = 31
      Width = 87
      Height = 27
      Anchors = [akRight, akBottom]
      Caption = 'Export'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 5
      AutoDisableParentOnclick = True
      OnClick = btnExportClick
      HelpContext = 143045
    end
    object btnImport: TDNMSpeedButton
      Left = 537
      Top = 31
      Width = 87
      Height = 27
      Anchors = [akRight, akBottom]
      Caption = 'Import'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 6
      AutoDisableParentOnclick = True
      OnClick = btnImportClick
      HelpContext = 143046
    end
  end
  object DNMPanel4: TDNMPanel [8]
    Left = 0
    Top = 45
    Width = 1001
    Height = 48
    HelpContext = 143002
    Align = alTop
    BevelOuter = bvNone
    Color = 14153215
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    Transparent = False
    object Label1: TLabel
      Left = 5
      Top = 26
      Width = 76
      Height = 15
      HelpContext = 143003
      Caption = 'Budget Name'
      Transparent = True
    end
    object cboBudgetName: TwwDBLookupCombo
      Left = 100
      Top = 22
      Width = 174
      Height = 23
      HelpContext = 143004
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Name'#9'25'#9'Name'#9'F')
      LookupTable = QryBudgetDef
      LookupField = 'budgetId'
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      ShowMatchText = True
      OnChange = cboBudgetNameChange
      OnDropDown = cboBudgetNameDropDown
      OnCloseUp = cboBudgetNameCloseUp
      OnEnter = cboBudgetNameEnter
      OnExit = cboBudgetNameExit
      OnNotInList = cboBudgetNameNotInList
    end
    object pnlBudgetDetails: TDNMPanel
      Left = 286
      Top = 0
      Width = 337
      Height = 48
      HelpContext = 143005
      BevelOuter = bvNone
      Color = 14153215
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label2: TLabel
        Left = 4
        Top = 2
        Width = 60
        Height = 15
        HelpContext = 143006
        Caption = 'Start Date '
        Transparent = True
      end
      object Label5: TLabel
        Left = 109
        Top = 2
        Width = 53
        Height = 15
        HelpContext = 143007
        Caption = 'End Date '
        Transparent = True
      end
      object Label6: TLabel
        Left = 212
        Top = 2
        Width = 42
        Height = 15
        HelpContext = 143008
        Caption = 'Interval'
        Transparent = True
      end
      object budgetFrom: TwwDBDateTimePicker
        Left = 4
        Top = 22
        Width = 89
        Height = 23
        HelpContext = 143009
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataSource = dsBudgetDef
        Date = 38353.000000000000000000
        Epoch = 1950
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 0
      end
      object budgetTo: TwwDBDateTimePicker
        Left = 109
        Top = 22
        Width = 89
        Height = 23
        HelpContext = 143010
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataSource = dsBudgetDef
        Date = 38717.000000000000000000
        Epoch = 1950
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 1
      end
      object BudgetInterval: TwwDBComboBox
        Left = 212
        Top = 22
        Width = 107
        Height = 23
        HelpContext = 143011
        ShowButton = True
        Style = csDropDown
        MapList = True
        AllowClearKey = False
        DataSource = dsBudgetDef
        DropDownCount = 8
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          'Daily'#9'1'
          'Weekly'#9'2'
          'Fortnightly'#9'3'
          'Monthly'#9'4'
          'Quarterly'#9'5'
          'Half Yearly'#9'6'
          'Yearly'#9'7')
        ParentFont = False
        Sorted = False
        TabOrder = 2
        UnboundDataType = wwDefault
      end
    end
  end
  object DNMPanel2: TDNMPanel [9]
    Left = 0
    Top = 130
    Width = 1001
    Height = 352
    HelpContext = 143024
    Align = alClient
    Color = 14153215
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    Transparent = False
    DesignSize = (
      1001
      352)
    object Label10: TLabel
      Left = 8
      Top = 280
      Width = 33
      Height = 15
      HelpContext = 143025
      Anchors = [akLeft, akBottom]
      Caption = 'Notes'
      Transparent = True
    end
    object grdBudgets: TwwDBGrid
      Left = 1
      Top = 1
      Width = 999
      Height = 272
      HelpContext = 143026
      ControlType.Strings = (
        'AccountName;CustomEdit;cboAccountname;F'
        'JobName;CustomEdit;cboJob;F'
        'BudgetDate;CustomEdit;dtBudgetDate;F'
        'ForDate;CheckBox;T;F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsBudgetLines_Dataset
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgAllowInsert]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter]
      ParentFont = False
      PopupMenu = mnuFreezegrdcol
      TabOrder = 0
      TitleAlignment = taCenter
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = True
      OnCalcCellColors = grdBudgetsCalcCellColors
      OnColWidthChanged = grdBudgetsColWidthChanged
      OnDblClick = grdBudgetsDblClick
      OnEnter = grdBudgetsEnter
      OnKeyPress = grdBudgetsKeyPress
      FooterColor = clWhite
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
      object grdBudgetsIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 26
        Height = 34
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
        OnClick = grdBudgetsIButtonClick
        HelpContext = 143047
      end
    end
    object cboAccountname: TwwDBLookupCombo
      Left = 140
      Top = 2
      Width = 98
      Height = 23
      HelpContext = 143027
      AutoSize = False
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Accountname'#9'30'#9'Accountname'#9'F'
        'AccountType'#9'30'#9'AccountType'#9'F')
      DataField = 'AccountName'
      DataSource = dsBudgetLines_Dataset
      LookupTable = qryAccounts
      LookupField = 'AccountId'
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnDblClick = grdBudgetsDblClick
      OnDropDown = cboAccountnameDropDown
      OnCloseUp = cboAccountnameCloseUp
      OnEnter = cboAccountnameEnter
    end
    object cboJob: TwwDBLookupCombo
      Left = 236
      Top = 2
      Width = 98
      Height = 23
      HelpContext = 143028
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'80'#9'Company'#9'F'
        'JobName'#9'20'#9'Job Name'#9'F'
        'JobNumber'#9'10'#9'Job Number'#9'F')
      LookupTable = qryJobs
      LookupField = 'ClientID'
      Style = csDropDownList
      TabOrder = 3
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnDropDown = cboJobDropDown
      OnCloseUp = cboJobCloseUp
    end
    object dtBudgetDate: TwwDBDateTimePicker
      Left = 109
      Top = 28
      Width = 89
      Height = 23
      HelpContext = 143029
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'BudgetDate'
      DataSource = dsBudgetLines_Dataset
      Epoch = 1950
      ShowButton = True
      TabOrder = 4
      Visible = False
      OnEnter = dtBudgetDateEnter
    end
    object ProgressBar: TProgressBar
      Left = 1
      Top = 330
      Width = 999
      Height = 21
      HelpContext = 143030
      Align = alBottom
      Smooth = True
      Step = 1
      TabOrder = 5
      Visible = False
    end
    object dbmNotes: TDBMemo
      Left = 48
      Top = 280
      Width = 369
      Height = 49
      HelpContext = 143031
      Anchors = [akLeft, akBottom]
      DataField = 'Notes'
      DataSource = dsBudget
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  object pnlPeriod: TDNMPanel [10]
    Left = 0
    Top = 93
    Width = 1001
    Height = 37
    HelpContext = 143032
    Align = alTop
    BevelOuter = bvNone
    Color = 14153215
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    Transparent = False
    object Label3: TLabel
      Left = 6
      Top = 12
      Width = 55
      Height = 15
      HelpContext = 143033
      Caption = 'Period No'
      Transparent = True
    end
    object cboBudgetNoDates: TwwDBComboBox
      Left = 100
      Top = 8
      Width = 92
      Height = 23
      HelpContext = 143034
      ShowButton = True
      Style = csDropDownList
      MapList = True
      AllowClearKey = False
      AutoDropDown = True
      ShowMatchText = True
      Column1Width = 220
      DataField = 'BudgetNo'
      DataSource = dsBudget
      DropDownCount = 8
      DropDownWidth = 249
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ItemHeight = 0
      ParentFont = False
      Sorted = False
      TabOrder = 1
      UnboundDataType = wwDefault
      Visible = False
      TwoColumnDisplay = True
      OnCloseUp = cboBudgetNoDatesCloseUp
      OnEnter = cboBudgetNoDatesEnter
    end
    object pnlPeriods: TDNMPanel
      Left = 286
      Top = 0
      Width = 715
      Height = 37
      HelpContext = 143035
      Align = alRight
      BevelOuter = bvNone
      Color = 14153215
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      Transparent = False
      object wwDBDateTimePicker3: TwwDBDateTimePicker
        Left = 4
        Top = 8
        Width = 89
        Height = 23
        HelpContext = 143036
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'StartDate'
        DataSource = dsBudget
        Epoch = 1950
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 0
      end
      object wwDBDateTimePicker4: TwwDBDateTimePicker
        Left = 109
        Top = 8
        Width = 89
        Height = 23
        HelpContext = 143037
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'EndDate'
        DataSource = dsBudget
        Epoch = 1950
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 1
      end
    end
    object edtBudgetNo: TwwDBEdit
      Left = 100
      Top = 8
      Width = 121
      Height = 23
      HelpContext = 143038
      DataField = 'BudgetNo'
      DataSource = dsBudget
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object cboBudgetNO: TwwDBComboBox
      Left = 795
      Top = -10
      Width = 19
      Height = 23
      HelpContext = 143039
      ShowButton = True
      Style = csDropDownList
      MapList = True
      AllowClearKey = False
      Column1Width = 220
      DataField = 'BudgetNo'
      DataSource = dsBudget
      DropDownCount = 8
      DropDownWidth = 249
      ItemHeight = 0
      Sorted = False
      TabOrder = 3
      UnboundDataType = wwDefault
      Visible = False
      TwoColumnDisplay = True
      OnCloseUp = cboBudgetNoDatesCloseUp
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 316
    Top = 423
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 384
    Top = 423
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 418
    Top = 422
  end
  inherited DataState: TDataState
    Left = 248
    Top = 426
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102004400540010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object dsBudget: TDataSource
    DataSet = Budget_Dataset
    Left = 598
    Top = 455
  end
  object qryAccounts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select distinct tblChartofAccounts.AccountID  , IFNULL(tblacctyp' +
        'edesc.AccDesc, tblChartofAccounts.AccountType)  as AccountType, ' +
        'tblChartofAccounts.Accountname , '
      
        'if(tblBudgetperiodlines.AccountId  = 0 or isnull(tblBudgetperiod' +
        'lines.AccountId ) , if(tmp.AccountId = 0 or isnull(tmp.accountId' +
        '), '#39'T'#39', '#39'F'#39') , '#39'F'#39' ) as NewAccount'
      'from tblChartofAccounts'
      
        'Left join tblBudgetperiodlines  on tblChartofAccounts.AccountId ' +
        '= tblBudgetperiodlines.AccountID and BudgetId = :BudgetID '
      
        'left join tmp_budgets as tmp on tmp.AccountId = tblChartofAccoun' +
        'ts.AccountId'
      
        'LEFT JOIN tblacctypedesc ON tblacctypedesc.AccType=tblChartofAcc' +
        'ounts.AccountType'
      'ORDER By AccountName')
    Left = 663
    Top = 424
    ParamData = <
      item
        DataType = ftInteger
        Name = 'BudgetID'
      end>
    object qryAccountsAccountname: TWideStringField
      DisplayWidth = 30
      FieldName = 'Accountname'
      Origin = 'tblChartofAccounts.Accountname'
      Size = 50
    end
    object qryAccountsAccountType: TWideStringField
      DisplayWidth = 10
      FieldName = 'AccountType'
      Size = 50
    end
    object qryAccountsAccountId: TIntegerField
      FieldName = 'AccountId'
      Origin = 'tblChartofAccounts.AccountID'
      Visible = False
    end
    object qryAccountsNewAccount: TWideStringField
      FieldName = 'NewAccount'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object QryBudgetDef: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select budgetId , Name, Description , StartDAte , EndDate , Amou' +
        'nt1Label, Amount2Label,IntervalPeriod'
      ''
      ' from tblBudgets where Active = '#39'T'#39' Order by Name')
    Left = 631
    Top = 424
  end
  object dsBudgetDef: TDataSource
    DataSet = QryBudgetDef
    Left = 631
    Top = 456
  end
  object Budget_Dataset: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblbudgetPeriods')
    Left = 598
    Top = 423
    object Budget_DatasetBudgetPeriodID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'BudgetPeriodID'
      Origin = 'tblbudgetPeriods.BudgetPeriodID'
    end
    object Budget_DatasetBudgetId: TIntegerField
      FieldName = 'BudgetId'
      Origin = 'tblbudgetPeriods.BudgetId'
    end
    object Budget_DatasetBudgetDate: TDateTimeField
      FieldName = 'BudgetDate'
      Origin = 'tblbudgetPeriods.BudgetDate'
    end
    object Budget_DatasetBudgetNo: TIntegerField
      FieldName = 'BudgetNo'
      Origin = 'tblbudgetPeriods.BudgetNo'
    end
    object Budget_DatasetStartDate: TDateTimeField
      FieldName = 'StartDate'
      Origin = 'tblbudgetPeriods.StartDate'
    end
    object Budget_DatasetEndDate: TDateTimeField
      FieldName = 'EndDate'
      Origin = 'tblbudgetPeriods.EndDate'
    end
    object Budget_DatasetNotes: TWideMemoField
      FieldName = 'Notes'
      BlobType = ftWideMemo
    end
    object Budget_DatasetActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblbudgetPeriods.Active'
      FixedChar = True
      Size = 1
    end
    object Budget_DatasetEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblbudgetPeriods.EditedFlag'
      FixedChar = True
      Size = 1
    end
  end
  object mnuFreezegrdcol: TAdvPopupMenu
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 283
    Top = 423
    object mnuFreezecol: TMenuItem
      Caption = 'Freee Account'
      HelpContext = 143048
    end
  end
  object BudgetLines_Dataset: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tmp_Budget_Admin_324707B0')
    Left = 568
    Top = 423
  end
  object dsBudgetLines_Dataset: TDataSource
    DataSet = BudgetLines_Dataset
    Left = 568
    Top = 455
  end
  object qryJobs: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select ClientID   , JobNumber  , JobName ,  Company'
      'from tblclients where isJob = '#39'T'#39
      'Order by JobName')
    Left = 695
    Top = 424
    object qryJobsCompany: TWideStringField
      DisplayWidth = 80
      FieldName = 'Company'
      Size = 80
    end
    object qryJobsJobName: TWideStringField
      DisplayLabel = 'Job Name'
      DisplayWidth = 20
      FieldName = 'JobName'
      Size = 39
    end
    object qryJobsJobNumber: TIntegerField
      DisplayLabel = 'Job Number'
      DisplayWidth = 10
      FieldName = 'JobNumber'
    end
    object qryJobsClientID: TIntegerField
      FieldName = 'ClientID'
      Visible = False
    end
  end
end
