inherited fmAccountbudget: TfmAccountbudget
  Left = 141
  Top = 132
  HelpContext = 139000
  Caption = 'fmAccountbudget'
  ClientHeight = 553
  ClientWidth = 998
  OldCreateOrder = True
  ExplicitLeft = 141
  ExplicitTop = 132
  ExplicitWidth = 1014
  ExplicitHeight = 592
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 498
    Width = 998
    ExplicitTop = 498
    ExplicitWidth = 998
    HelpContext = 139031
  end
  inherited imgGridWatermark: TImage
    HelpContext = 139001
  end
  object DNMPanel5: TDNMPanel [5]
    Left = 0
    Top = 498
    Width = 998
    Height = 55
    HelpContext = 139006
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
    TabOrder = 1
    DesignSize = (
      998
      55)
    object Label4: TLabel
      Left = 951
      Top = 20
      Width = 35
      Height = 15
      HelpContext = 139007
      Anchors = [akRight, akBottom]
      Caption = 'Active'
      Transparent = True
      Visible = False
    end
    object Label7: TLabel
      Left = 23
      Top = 8
      Width = 167
      Height = 15
      HelpContext = 139008
      Anchors = [akLeft, akBottom]
      Caption = 'Freeze Budget Period Column'
      Transparent = True
    end
    object Label8: TLabel
      Left = 22
      Top = 32
      Width = 63
      Height = 15
      HelpContext = 139009
      Anchors = [akLeft, akBottom]
      Caption = 'Show Jobs'
      Transparent = True
    end
    object btnSave: TDNMSpeedButton
      Left = 311
      Top = 14
      Width = 87
      Height = 27
      HelpContext = 139010
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
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = btnSaveClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 608
      Top = 14
      Width = 87
      Height = 27
      HelpContext = 139011
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
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = btnCancelClick
    end
    object btnNew: TDNMSpeedButton
      Left = 459
      Top = 14
      Width = 87
      Height = 27
      HelpContext = 139012
      Anchors = [akBottom]
      Caption = '&New'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 3
      Visible = False
      AutoDisableParentOnclick = True
      OnClick = btnNewClick
    end
    object chkActive: TwwCheckBox
      Left = 931
      Top = 19
      Width = 17
      Height = 17
      HelpContext = 139013
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
      TabOrder = 1
      Visible = False
    end
    object chkFreezeColumn: TwwCheckBox
      Left = 3
      Top = 7
      Width = 17
      Height = 17
      HelpContext = 139014
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
      TabOrder = 0
      OnClick = chkFreezeColumnClick
    end
    object chkbugetforJob: TwwCheckBox
      Left = 2
      Top = 30
      Width = 17
      Height = 17
      HelpContext = 139015
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
      TabOrder = 5
      OnClick = chkbugetforJobClick
    end
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 719
      Top = 14
      Width = 186
      Height = 27
      HelpContext = 139016
      Anchors = [akBottom]
      Caption = '&Generate data(Hidden)'
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
      TabOrder = 6
      Visible = False
      AutoDisableParentOnclick = True
      OnClick = DNMSpeedButton1Click
    end
  end
  object DNMPanel1: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 998
    Height = 46
    HelpContext = 139002
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
    object pnlTitle: TDNMPanel
      Left = 125
      Top = 3
      Width = 749
      Height = 40
      HelpContext = 139003
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
        Width = 745
        Height = 36
        HelpContext = 139004
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
          Width = 745
          Height = 36
          HelpContext = 139005
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
          ExplicitWidth = 235
        end
      end
    end
  end
  object DNMPanel4: TDNMPanel [7]
    Left = 0
    Top = 46
    Width = 998
    Height = 46
    HelpContext = 139021
    Align = alTop
    BevelOuter = bvNone
    Color = 14153215
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Label1: TLabel
      Left = 5
      Top = 23
      Width = 76
      Height = 15
      HelpContext = 139022
      Caption = 'Budget Name'
      Transparent = True
    end
    object cboBudgetName: TwwDBLookupCombo
      Left = 100
      Top = 19
      Width = 174
      Height = 23
      HelpContext = 139023
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
      OnCloseUp = cboBudgetNameCloseUp
      OnEnter = cboBudgetNameEnter
      OnNotInList = cboBudgetNameNotInList
    end
    object pnlBudgetDetails: TDNMPanel
      Left = 286
      Top = 2
      Width = 337
      Height = 45
      HelpContext = 139024
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
        Top = 3
        Width = 60
        Height = 15
        HelpContext = 139025
        Caption = 'Start Date '
        Transparent = True
      end
      object Label5: TLabel
        Left = 109
        Top = 3
        Width = 53
        Height = 15
        HelpContext = 139026
        Caption = 'End Date '
        Transparent = True
      end
      object Label6: TLabel
        Left = 212
        Top = 3
        Width = 42
        Height = 15
        HelpContext = 139027
        Caption = 'Interval'
        Transparent = True
      end
      object budgetFrom: TwwDBDateTimePicker
        Left = 4
        Top = 19
        Width = 89
        Height = 23
        HelpContext = 139028
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
        Top = 19
        Width = 89
        Height = 23
        HelpContext = 139029
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
      object budgetInterval: TwwDBComboBox
        Left = 212
        Top = 19
        Width = 107
        Height = 23
        HelpContext = 139030
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
  object DNMPanel2: TDNMPanel [8]
    Left = 0
    Top = 92
    Width = 998
    Height = 406
    HelpContext = 139017
    Align = alClient
    Color = 14153215
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object grdBudgets: TwwDBGrid
      Left = 1
      Top = 1
      Width = 996
      Height = 383
      HelpContext = 139018
      ControlType.Strings = (
        'ForDate;CheckBox;T;F'
        'JobName;CustomEdit;cboJob;F'
        'BudgetDate;CustomEdit;dtBudgetDate;F'
        'PeriodDescription;CustomEdit;cboBudgetNoDates;F'
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'PeriodDescription'#9'38'#9'PeriodDescription'#9#9
        'JobName'#9'28'#9'Job Name'#9'F'#9
        'ForDate'#9'7'#9'ForDate'#9#9
        'BudgetDate'#9'18'#9'BudgetDate'#9#9
        'AllClass_Amt1'#9'19'#9'Total 1'#9'F'#9
        'AllClass_Amt2'#9'11'#9'Total 2'#9'T'#9
        'Active'#9'9'#9'Active'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      Align = alClient
      DataSource = dsLines
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgAllowInsert]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taCenter
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = False
      OnCalcCellColors = grdBudgetsCalcCellColors
      OnEnter = grdBudgetsEnter
      FooterColor = clWhite
      FooterCellColor = clWindow
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
      object grdBudgetsIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 25
        Height = 33
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
        HelpContext = 139032
      end
    end
    object cboJob: TwwDBLookupCombo
      Left = 316
      Top = 10
      Width = 98
      Height = 23
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'JobName'#9'39'#9'JobName'#9'F')
      DataField = 'JobId'
      DataSource = dsLines
      LookupTable = qryJobs
      LookupField = 'ClientID'
      Style = csDropDownList
      TabOrder = 1
      Visible = False
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboJobCloseUp
      HelpContext = 139033
    end
    object cboBudgetNoDates: TwwDBComboBox
      Left = 308
      Top = 96
      Width = 50
      Height = 23
      ShowButton = True
      Style = csDropDownList
      MapList = True
      AllowClearKey = False
      AutoDropDown = True
      ShowMatchText = True
      Column1Width = 220
      DataField = 'PeriodNo'
      DataSource = dsLines
      DropDownCount = 8
      DropDownWidth = 190
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ItemHeight = 0
      Items.Strings = (
        '01-01-2005   to   31-01-2005'#9'1'
        '01-02-2005   to   28-02-2005'#9'2'
        '01-04-2005   to   30-04-2005'#9'3'
        '01-05-2005   to   31-05-2005'#9'4'
        '01-03-2005   to   31-03-2005'#9'5')
      ParentFont = False
      Sorted = False
      TabOrder = 2
      UnboundDataType = wwDefault
      Visible = False
      TwoColumnDisplay = True
      OnCloseUp = cboBudgetNoDatesCloseUp
      HelpContext = 139034
    end
    object cboBudgetNO: TwwDBComboBox
      Left = 27
      Top = -2
      Width = 19
      Height = 23
      HelpContext = 139019
      ShowButton = True
      Style = csDropDownList
      MapList = True
      AllowClearKey = False
      Column1Width = 220
      DataField = 'BudgetNo'
      DropDownCount = 8
      DropDownWidth = 249
      ItemHeight = 0
      Sorted = False
      TabOrder = 3
      UnboundDataType = wwDefault
      Visible = False
      TwoColumnDisplay = True
    end
    object ProgressBar: TProgressBar
      Left = 1
      Top = 384
      Width = 996
      Height = 21
      HelpContext = 139020
      Align = alBottom
      Smooth = True
      Step = 1
      TabOrder = 4
      Visible = False
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C0101020048015C0210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
      
        'Select budgetId , Name, Description , StartDAte , EndDate , Amou' +
        'nt1Label, Amount2Label,IntervalPeriod'
      ''
      ' from tblBudgets where Active = '#39'T'#39' Order by Name')
    Left = 183
    Top = 80
    object QryBudgetDefbudgetId: TIntegerField
      FieldName = 'budgetId'
    end
    object QryBudgetDefName: TWideStringField
      FieldName = 'Name'
      Size = 25
    end
    object QryBudgetDefDescription: TWideStringField
      FieldName = 'Description'
      Size = 50
    end
    object QryBudgetDefStartDAte: TDateTimeField
      FieldName = 'StartDAte'
    end
    object QryBudgetDefEndDate: TDateTimeField
      FieldName = 'EndDate'
    end
    object QryBudgetDefAmount1Label: TWideStringField
      FieldName = 'Amount1Label'
      Size = 50
    end
    object QryBudgetDefAmount2Label: TWideStringField
      FieldName = 'Amount2Label'
      Size = 50
    end
    object QryBudgetDefIntervalPeriod: TSmallintField
      FieldName = 'IntervalPeriod'
    end
  end
  object dsBudgetDef: TDataSource
    DataSet = QryBudgetDef
    Left = 215
    Top = 81
  end
  object dsLines: TDataSource
    DataSet = QryTemp
    Left = 775
    Top = 113
  end
  object qryJobs: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select ClientID   , JobNumber  , JobName '
      'from tblclients where isJob = '#39'T'#39
      'Order by JobName')
    Left = 639
    Top = 248
    object qryJobsJobName: TWideStringField
      DisplayWidth = 39
      FieldName = 'JobName'
      Size = 39
    end
    object qryJobsJobNumber: TIntegerField
      DisplayWidth = 10
      FieldName = 'JobNumber'
      Visible = False
    end
    object qryJobsClientID: TIntegerField
      FieldName = 'ClientID'
      Visible = False
    end
  end
  object QryTemp: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tmp_Budget')
    Left = 31
    Top = 200
    object QryTempPeriodDescription: TWideStringField
      DisplayWidth = 38
      FieldName = 'PeriodDescription'
      Origin = 'tmp_Budget.PeriodDescription'
      Size = 50
    end
    object QryTempJobName: TWideStringField
      DisplayLabel = 'Job Name'
      DisplayWidth = 28
      FieldName = 'JobName'
      Origin = 'tmp_Budget.JobName'
      Size = 50
    end
    object QryTempForDate: TWideStringField
      DisplayWidth = 7
      FieldName = 'ForDate'
      Origin = 'tmp_Budget.ForDate'
      FixedChar = True
      Size = 1
    end
    object QryTempBudgetDate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'BudgetDate'
      Origin = 'tmp_Budget.BudgetDate'
    end
    object QryTempAllClass_Amt1: TFloatField
      DisplayLabel = 'Total 1'
      DisplayWidth = 19
      FieldName = 'AllClass_Amt1'
      Origin = 'tmp_Budget.AllClass_Amt1'
      currency = True
    end
    object QryTempAllClass_Amt2: TFloatField
      DisplayLabel = 'Total 2'
      DisplayWidth = 11
      FieldName = 'AllClass_Amt2'
      Origin = 'tmp_Budget.AllClass_Amt2'
      currency = True
    end
    object QryTempActive: TWideStringField
      DisplayWidth = 9
      FieldName = 'Active'
      Origin = 'tmp_Budget.Active'
      FixedChar = True
      Size = 1
    end
    object QryTempDefault_amt1: TFloatField
      DisplayWidth = 10
      FieldName = 'Default_amt1'
      Origin = 'tmp_Budget.Default_amt1'
      Visible = False
      currency = True
    end
    object QryTempDefault_amt2: TFloatField
      DisplayWidth = 10
      FieldName = 'Default_amt2'
      Origin = 'tmp_Budget.Default_amt2'
      Visible = False
      currency = True
    end
    object QryTempMelbourne_amt1: TFloatField
      DisplayWidth = 10
      FieldName = 'Melbourne_amt1'
      Origin = 'tmp_Budget.Melbourne_amt1'
      Visible = False
      currency = True
    end
    object QryTempMelbourne_amt2: TFloatField
      DisplayWidth = 10
      FieldName = 'Melbourne_amt2'
      Origin = 'tmp_Budget.Melbourne_amt2'
      Visible = False
      currency = True
    end
    object QryTempPeriodNo: TIntegerField
      DisplayWidth = 10
      FieldName = 'PeriodNo'
      Origin = 'tmp_Budget.PeriodNo'
      Visible = False
    end
    object QryTempJobId: TIntegerField
      DisplayWidth = 10
      FieldName = 'JobId'
      Origin = 'tmp_Budget.JobId'
      Visible = False
    end
  end
end
