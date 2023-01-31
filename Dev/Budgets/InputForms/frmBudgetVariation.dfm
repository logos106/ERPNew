inherited fmBudgetVariation: TfmBudgetVariation
  Left = 313
  Top = 141
  HelpContext = 147000
  Caption = 'Budget Variations'
  ClientHeight = 526
  ClientWidth = 620
  Color = 14153215
  OldCreateOrder = True
  ExplicitLeft = 313
  ExplicitTop = 141
  ExplicitWidth = 636
  ExplicitHeight = 565
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 479
    Width = 620
    ExplicitTop = 479
    ExplicitWidth = 620
    HelpContext = 147049
  end
  inherited imgGridWatermark: TImage
    HelpContext = 147001
  end
  object DNMPanel5: TDNMPanel [5]
    Left = 0
    Top = 479
    Width = 620
    Height = 47
    HelpContext = 147002
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
    TabOrder = 1
    Transparent = False
    DesignSize = (
      620
      47)
    object Label4: TLabel
      Left = 575
      Top = 10
      Width = 35
      Height = 15
      HelpContext = 147003
      Anchors = [akRight, akBottom]
      Caption = 'Active'
      Transparent = True
    end
    object btnSave: TDNMSpeedButton
      Left = 193
      Top = 6
      Width = 87
      Height = 27
      HelpContext = 147004
      Anchors = [akBottom]
      Caption = 'Apply'
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
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object chkActive: TwwCheckBox
      Left = 555
      Top = 10
      Width = 17
      Height = 17
      HelpContext = 147005
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
      TabOrder = 2
    end
    object btnCancel: TDNMSpeedButton
      Left = 339
      Top = 6
      Width = 87
      Height = 27
      HelpContext = 147006
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
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object pnlBudget: TDNMPanel [6]
    Left = 0
    Top = 62
    Width = 620
    Height = 417
    HelpContext = 147011
    Align = alClient
    BevelOuter = bvNone
    Color = 14153215
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnEnter = rdbActionOptionEnter
    Transparent = False
    object pnlVariation: TDNMPanel
      Left = 0
      Top = 360
      Width = 620
      Height = 57
      HelpContext = 147012
      Align = alBottom
      Anchors = [akLeft, akRight]
      BevelOuter = bvNone
      Color = 14153215
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 6
      Transparent = False
      object Label3: TLabel
        Left = 522
        Top = 6
        Width = 50
        Height = 15
        HelpContext = 147013
        Caption = 'Variation'
        Transparent = True
      end
      object rdbVariationOption: TwwRadioGroup
        Left = 238
        Top = 6
        Width = 271
        Height = 45
        HelpContext = 147014
        DisableThemes = False
        ItemIndex = 0
        TransparentActiveItem = True
        Transparent = True
        Caption = ' Variation Option '
        Columns = 2
        Items.Strings = (
          'Increase By'
          'Decrease By')
        TabOrder = 1
        OnEnter = rdbActionOptionEnter
      end
      object rdbVariationType: TwwRadioGroup
        Left = 8
        Top = 6
        Width = 217
        Height = 45
        HelpContext = 147015
        DisableThemes = False
        ItemIndex = 1
        TransparentActiveItem = True
        Transparent = True
        Caption = ' Variation Type '
        Columns = 2
        Items.Strings = (
          'Dollars'
          'Percentage')
        TabOrder = 0
        OnEnter = rdbActionOptionEnter
      end
      object edtVariationAmt: TwwDBEdit
        Left = 522
        Top = 28
        Width = 89
        Height = 23
        HelpContext = 147016
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
        OnEnter = rdbActionOptionEnter
      end
    end
    object DNMPanel6: TDNMPanel
      Left = 0
      Top = 49
      Width = 620
      Height = 50
      HelpContext = 147017
      Align = alTop
      Anchors = [akLeft, akRight]
      BevelOuter = bvNone
      Color = 14153215
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 1
      OnEnter = rdbActionOptionEnter
      Transparent = False
      object rdbActionOption: TwwRadioGroup
        Left = 8
        Top = 3
        Width = 285
        Height = 42
        HelpContext = 147018
        DisableThemes = False
        TransparentActiveItem = True
        Transparent = True
        Caption = 'Action'
        Columns = 2
        Items.Strings = (
          'Change'
          'Copy')
        TabOrder = 0
        OnClick = rdbActionOption1Click
        OnEnter = rdbActionOptionEnter
      end
      object rdbBudgetOption: TwwRadioGroup
        Left = 299
        Top = 3
        Width = 313
        Height = 41
        HelpContext = 147019
        DisableThemes = False
        TransparentActiveItem = True
        Transparent = True
        Caption = 'For'
        Columns = 2
        Items.Strings = (
          'Budget'
          'Period')
        TabOrder = 1
        OnClick = rdbBudgetOptionClick
        OnEnter = rdbActionOptionEnter
      end
    end
    object DNMPanel7: TDNMPanel
      Left = 0
      Top = 0
      Width = 620
      Height = 49
      HelpContext = 147020
      Align = alTop
      Anchors = [akLeft, akRight]
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
      OnEnter = rdbActionOptionEnter
      Transparent = False
      object Label1: TLabel
        Left = 8
        Top = 0
        Width = 40
        Height = 15
        HelpContext = 147021
        Caption = 'Budget'
        Transparent = True
      end
      object Label11: TLabel
        Left = 299
        Top = 0
        Width = 42
        Height = 15
        HelpContext = 147022
        Caption = 'Interval'
        Transparent = True
      end
      object Label9: TLabel
        Left = 430
        Top = 0
        Width = 60
        Height = 15
        HelpContext = 147023
        Caption = 'Start Date '
        Transparent = True
      end
      object Label10: TLabel
        Left = 522
        Top = 0
        Width = 53
        Height = 15
        HelpContext = 147024
        Caption = 'End Date '
        Transparent = True
      end
      object cboBudget: TwwDBLookupCombo
        Left = 8
        Top = 17
        Width = 286
        Height = 23
        HelpContext = 147025
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Name'#9'26'#9'Name'#9'F'
          'IntervalPeriod'#9'14'#9'Interval'#9'F'
          'StartDAte'#9'12'#9'Start Date'#9'F'
          'EndDate'#9'8'#9'End Date'#9'F')
        LookupTable = QryBudgetDef
        LookupField = 'budgetId'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 0
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        ShowMatchText = True
        OnCloseUp = cboBudgetCloseUp
        OnEnter = rdbActionOptionEnter
      end
      object edtInterval: TwwDBEdit
        Left = 299
        Top = 17
        Width = 126
        Height = 23
        HelpContext = 147026
        DataSource = dsQryBudgetDef
        Enabled = False
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
        OnEnter = rdbActionOptionEnter
      end
      object edtStartDAte: TwwDBDateTimePicker
        Left = 430
        Top = 17
        Width = 89
        Height = 23
        HelpContext = 147027
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataSource = dsQryBudgetDef
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
        TabOrder = 3
      end
      object edtEndDate: TwwDBDateTimePicker
        Left = 522
        Top = 17
        Width = 89
        Height = 23
        HelpContext = 147028
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataSource = dsQryBudgetDef
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
        TabOrder = 2
      end
    end
    object pnlcopybudget: TDNMPanel
      Left = 0
      Top = 99
      Width = 620
      Height = 44
      HelpContext = 147029
      Align = alTop
      Anchors = [akLeft, akRight]
      BevelOuter = bvNone
      Color = 14153215
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 2
      Visible = False
      OnEnter = rdbActionOptionEnter
      Transparent = False
      object Label12: TLabel
        Left = 8
        Top = 0
        Width = 124
        Height = 15
        HelpContext = 147030
        Caption = 'Copy to Budget Name '
        Transparent = True
      end
      object Label13: TLabel
        Left = 238
        Top = 0
        Width = 68
        Height = 15
        HelpContext = 147031
        Caption = 'Description '
        Transparent = True
      end
      object Label14: TLabel
        Left = 522
        Top = 0
        Width = 57
        Height = 15
        HelpContext = 147032
        Caption = 'Start Date'
        Transparent = True
      end
      object edtBudgetName: TwwDBEdit
        Left = 8
        Top = 15
        Width = 217
        Height = 23
        HelpContext = 147033
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
      object edtBudgetDescription: TwwDBEdit
        Left = 238
        Top = 15
        Width = 273
        Height = 23
        HelpContext = 147034
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
      object dtStartDate: TwwDBDateTimePicker
        Left = 522
        Top = 15
        Width = 89
        Height = 23
        HelpContext = 147035
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
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
    end
    object DNMPanel8: TDNMPanel
      Left = 0
      Top = 151
      Width = 620
      Height = 20
      HelpContext = 147036
      Align = alBottom
      BevelOuter = bvNone
      Color = 14153215
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 3
      OnEnter = rdbActionOptionEnter
      object Label5: TLabel
        Left = 23
        Top = 3
        Width = 100
        Height = 15
        HelpContext = 147037
        Caption = 'Choose Accounts'
        Transparent = True
      end
      object chkShowAccounts: TwwCheckBox
        Left = 4
        Top = 2
        Width = 17
        Height = 17
        HelpContext = 147038
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
        Caption = 'chkActive'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = chkShowAccountsClick
      end
    end
    object DNMPanel3: TDNMPanel
      Left = 0
      Top = 171
      Width = 620
      Height = 168
      HelpContext = 147039
      Align = alBottom
      Color = 14153215
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      Transparent = False
      object wwDBGrid1: TwwDBGrid
        Left = 1
        Top = 1
        Width = 618
        Height = 166
        HelpContext = 147040
        ControlType.Strings = (
          'RecSelected;CheckBox;T;F'
          'VarType;CustomEdit;wwRadioGroup1;F'
          'IncDec;CustomEdit;wwRadioGroup2;F')
        Selected.Strings = (
          'RecSelected'#9'1'#9'Select'#9#9
          'Accountname'#9'20'#9'Account'#9'T'#9
          'IncDec'#9'24'#9'Variation Option'#9'F'#9
          'VarType'#9'20'#9'Variation Type'#9'F'#9
          'VarAmount'#9'10'#9'Amount'#9#9)
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        Align = alClient
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = []
        ParentFont = False
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
        FooterColor = clWhite
      end
      object wwRadioGroup2: TwwRadioGroup
        Left = 328
        Top = 104
        Width = 144
        Height = 18
        DisableThemes = False
        Color = clWhite
        Columns = 2
        DataField = 'IncDec'
        DataSource = DataSource1
        Items.Strings = (
          'Increase'
          'Decrease')
        ParentColor = False
        TabOrder = 2
        Values.Strings = (
          'I'
          'D')
        HelpContext = 147050
      end
      object wwRadioGroup1: TwwRadioGroup
        Left = 120
        Top = 101
        Width = 158
        Height = 18
        DisableThemes = False
        Color = clWhite
        Columns = 2
        DataField = 'VarType'
        DataSource = DataSource1
        Items.Strings = (
          'Amount'
          '%')
        ParentColor = False
        TabOrder = 1
        Values.Strings = (
          'D'
          'P')
        HelpContext = 147051
      end
    end
    object ProgressBar: TProgressBar
      Left = 0
      Top = 339
      Width = 620
      Height = 21
      HelpContext = 147041
      Align = alBottom
      Smooth = True
      Step = 1
      TabOrder = 5
      Visible = False
    end
    object pnlPeriod: TDNMPanel
      Left = 0
      Top = 143
      Width = 620
      Height = 31
      HelpContext = 147042
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
      TabOrder = 7
      Visible = False
      OnEnter = rdbActionOptionEnter
      Transparent = False
      object Label2: TLabel
        Left = 8
        Top = 9
        Width = 37
        Height = 15
        HelpContext = 147043
        Caption = 'Period'
        Transparent = True
      end
      object Label8: TLabel
        Left = 302
        Top = 9
        Width = 82
        Height = 15
        HelpContext = 147044
        Caption = 'Copy to Period'
        Transparent = True
      end
      object CboToPeriod: TwwDBComboBox
        Left = 394
        Top = 6
        Width = 216
        Height = 23
        HelpContext = 147045
        ShowButton = True
        Style = csDropDownList
        MapList = True
        AllowClearKey = False
        Column1Width = 220
        DropDownCount = 8
        DropDownWidth = 200
        ItemHeight = 0
        Sorted = False
        TabOrder = 1
        UnboundDataType = wwDefault
        TwoColumnDisplay = True
        OnCloseUp = CboToPeriodCloseUp
      end
      object cboBudgetNoDates: TwwDBComboBox
        Left = 54
        Top = 6
        Width = 212
        Height = 23
        HelpContext = 147046
        ShowButton = True
        Style = csDropDownList
        MapList = True
        AllowClearKey = False
        Column1Width = 220
        DropDownCount = 8
        DropDownWidth = 200
        ItemHeight = 0
        Sorted = False
        TabOrder = 0
        UnboundDataType = wwDefault
        TwoColumnDisplay = True
        OnCloseUp = cboBudgetNoDatesCloseUp
      end
      object edtBudgetNo: TwwDBEdit
        Left = 126
        Top = 4
        Width = 69
        Height = 19
        HelpContext = 147047
        AutoSize = False
        BorderStyle = bsNone
        DataField = 'BudgetNo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        UnboundDataType = wwDefault
        Visible = False
        WantReturns = False
        WordWrap = False
        OnEnter = edtBudgetNoEnter
      end
      object edtToPeriod: TwwDBEdit
        Left = 434
        Top = 5
        Width = 69
        Height = 19
        HelpContext = 147048
        AutoSize = False
        BorderStyle = bsNone
        DataField = 'BudgetNo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        UnboundDataType = wwDefault
        Visible = False
        WantReturns = False
        WordWrap = False
        OnEnter = edtToPeriodEnter
      end
    end
  end
  object DNMPanel1: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 620
    Height = 62
    HelpContext = 147007
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
    object pnlTitle: TDNMPanel
      Left = 167
      Top = 6
      Width = 259
      Height = 45
      HelpContext = 147008
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 257
        Height = 43
        HelpContext = 147009
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
          Width = 257
          Height = 43
          HelpContext = 147010
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Budget Variation'
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
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102005000540010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object QryBudgetDef: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select budgetId , Name, Description , StartDAte , EndDate ,'
      'if (IntervalPeriod=1 , '#39'Daily'#39' ,'
      'if (IntervalPeriod=2 , '#39'Weekly'#39' ,'
      'if (IntervalPeriod=3 , '#39'Fortnightly'#39' ,'
      'if (IntervalPeriod=4 , '#39'Monthly'#39' ,'
      'if (IntervalPeriod=5 , '#39'Quarterly'#39' ,'
      
        'if (IntervalPeriod=6 , '#39'Half Yearly'#39' ,'#39'Yearly'#39')))))) as Interval' +
        'Period'
      ' from tblBudgets where Active = '#39'T'#39' Order by Name')
    Left = 106
    Top = 64
    object QryBudgetDefName: TWideStringField
      DisplayWidth = 26
      FieldName = 'Name'
      Size = 25
    end
    object QryBudgetDefIntervalPeriod: TWideStringField
      DisplayLabel = 'Interval'
      DisplayWidth = 14
      FieldName = 'IntervalPeriod'
      Size = 11
    end
    object QryBudgetDefStartDAte: TDateTimeField
      DisplayLabel = 'Start Date'
      DisplayWidth = 12
      FieldName = 'StartDAte'
    end
    object QryBudgetDefEndDate: TDateTimeField
      DisplayLabel = 'End Date'
      DisplayWidth = 8
      FieldName = 'EndDate'
    end
    object QryBudgetDefDescription: TWideStringField
      DisplayWidth = 20
      FieldName = 'Description'
      Visible = False
      Size = 50
    end
    object QryBudgetDefbudgetId: TIntegerField
      FieldName = 'budgetId'
      Visible = False
    end
  end
  object dsQryBudgetDef: TDataSource
    DataSet = QryBudgetDef
    Left = 146
    Top = 67
  end
  object DataSource1: TDataSource
    DataSet = MyQuery1
    Left = 280
    Top = 312
  end
  object MyQuery1: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tmp_budgetvariation_Admin_53c23547')
    Left = 312
    Top = 312
    object MyQuery1RecSelected: TWideStringField
      DisplayLabel = 'Select'
      DisplayWidth = 1
      FieldName = 'RecSelected'
      Origin = 'tmp_budgetvariation_Admin_53c23547.RecSelected'
      FixedChar = True
      Size = 1
    end
    object MyQuery1Accountname: TWideStringField
      DisplayLabel = 'Account'
      DisplayWidth = 20
      FieldName = 'Accountname'
      Origin = 'tmp_budgetvariation_Admin_53c23547.Accountname'
      Size = 100
    end
    object MyQuery1IncDec: TWideStringField
      DisplayLabel = 'Variation Option'
      DisplayWidth = 24
      FieldName = 'IncDec'
      Origin = 'tmp_budgetvariation_Admin_53c23547.IncDec'
      FixedChar = True
      Size = 1
    end
    object MyQuery1VarType: TWideStringField
      DisplayLabel = 'Variation Type'
      DisplayWidth = 20
      FieldName = 'VarType'
      Origin = 'tmp_budgetvariation_Admin_53c23547.VarType'
      FixedChar = True
      Size = 1
    end
    object MyQuery1VarAmount: TFloatField
      DisplayLabel = 'Amount'
      DisplayWidth = 10
      FieldName = 'VarAmount'
      Origin = 'tmp_budgetvariation_Admin_53c23547.VarAmount'
      OnChange = MyQuery1VarAmountChange
      DisplayFormat = '0'
    end
    object MyQuery1AutoId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'AutoId'
      Origin = 'tmp_budgetvariation_Admin_53c23547.AutoId'
      Visible = False
    end
    object MyQuery1AccountID: TIntegerField
      DisplayWidth = 10
      FieldName = 'AccountID'
      Origin = 'tmp_budgetvariation_Admin_53c23547.AccountID'
      Visible = False
    end
  end
end
