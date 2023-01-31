inherited HirePrefsGUI: THirePrefsGUI
  HelpContext = 1427002
  Caption = 'HirePrefsGUI'
  ClientHeight = 723
  ClientWidth = 888
  ExplicitWidth = 904
  ExplicitHeight = 762
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 723
    Width = 888
    HelpContext = 1427003
    ExplicitTop = 521
    ExplicitWidth = 910
  end
  object lblWidth: TLabel [3]
    Left = 16
    Top = 8
    Width = 863
    Height = 22
    HelpContext = 1427004
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
  inherited sbpanels: TAdvScrollBox
    Width = 888
    Height = 723
    ExplicitTop = -6
    ExplicitWidth = 888
    ExplicitHeight = 723
    HelpContext = 1427030
    object pnlDayWeekInfo: TDNMPanel
      Left = 0
      Top = 0
      Width = 886
      Height = 258
      HelpContext = 1427012
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = 24
      ExplicitTop = 311
      ExplicitWidth = 545
      object Bevel1: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 872
        Height = 244
        HelpContext = 1427013
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitWidth = 529
        ExplicitHeight = 134
      end
      object Label2: TLabel
        Left = 14
        Top = 14
        Width = 63
        Height = 15
        HelpContext = 1427014
        Caption = 'Day / Week'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label3: TLabel
        Left = 24
        Top = 40
        Width = 153
        Height = 15
        HelpContext = 1427015
        Caption = 'Start Day of Working Week'
        Transparent = True
      end
      object Label4: TLabel
        Left = 248
        Top = 40
        Width = 99
        Height = 15
        HelpContext = 1427016
        Caption = 'Start Of Day Time'
        Transparent = True
      end
      object Label5: TLabel
        Left = 392
        Top = 40
        Width = 92
        Height = 15
        HelpContext = 1427017
        Caption = 'End Of Day Time'
        Transparent = True
      end
      object Label6: TLabel
        Left = 26
        Top = 108
        Width = 117
        Height = 15
        HelpContext = 1427018
        Caption = 'No of Weekend Days'
        Transparent = True
      end
      object lblHours: TLabel
        Left = 248
        Top = 108
        Width = 90
        Height = 15
        HelpContext = 1427019
        Caption = 'Hours In a Day : '
        Transparent = True
      end
      object Label7: TLabel
        Left = 26
        Top = 151
        Width = 69
        Height = 15
        HelpContext = 1427020
        Caption = 'Hire Caption'
        Transparent = True
      end
      object Label8: TLabel
        Left = 26
        Top = 181
        Width = 147
        Height = 15
        HelpContext = 1427021
        Caption = 'Default Hire Income Accnt'
        Transparent = True
      end
      object Label9: TLabel
        Left = 26
        Top = 211
        Width = 150
        Height = 15
        HelpContext = 1427022
        Caption = 'Default Hire Product Name'
        Transparent = True
      end
      object wwDBComboBox1: TwwDBComboBox
        Left = 24
        Top = 56
        Width = 201
        Height = 23
        HelpContext = 1427023
        ShowButton = True
        Style = csDropDown
        MapList = False
        AllowClearKey = False
        AutoDropDown = True
        DataField = 'StartWorkWeek'
        DataSource = dsPrefs
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
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
        TabOrder = 0
        UnboundDataType = wwDefault
      end
      object wwDBDateTimePicker1: TwwDBDateTimePicker
        Left = 248
        Top = 56
        Width = 121
        Height = 23
        HelpContext = 1427024
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'StartOfDay'
        DataSource = dsPrefs
        Epoch = 1950
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 1
        DisplayFormat = 'hh:mm am/pm'
        OnChange = wwDBDateTimePicker1Change
      end
      object wwDBDateTimePicker2: TwwDBDateTimePicker
        Left = 392
        Top = 56
        Width = 121
        Height = 23
        HelpContext = 1427025
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'EndOfDay'
        DataSource = dsPrefs
        Epoch = 1950
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 2
        DisplayFormat = 'hh:mm am/pm'
        OnChange = wwDBDateTimePicker1Change
      end
      object wwDBSpinEdit1: TwwDBSpinEdit
        Left = 149
        Top = 104
        Width = 65
        Height = 23
        HelpContext = 1427026
        Increment = 1.000000000000000000
        MaxValue = 7.000000000000000000
        Value = 5.000000000000000000
        DataField = 'NoofWeekendDays'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        UnboundDataType = wwDefault
      end
      object wwDBEdit1: TwwDBEdit
        Left = 191
        Top = 148
        Width = 170
        Height = 23
        HelpContext = 1427027
        DataField = 'HireName'
        DataSource = dsColumnHeadings
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
      object cboHireIncomeAccountName: TERPDbLookupCombo
        Left = 191
        Top = 178
        Width = 218
        Height = 23
        HelpContext = 1427028
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Accountname'#9'30'#9'Account Name'#9'F'
          'AccountType'#9'10'#9'Type'#9'F')
        DataField = 'DefaultHireIncomeAccount'
        DataSource = dsPrefs
        LookupTable = qryIncomeAccountLookup
        LookupField = 'Accountname'
        Options = [loTitles]
        ParentFont = False
        TabOrder = 5
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = True
        LookupFormClassName = 'TChartOfAccountsListLookupGUI'
        EditFormClassName = 'TfrmChartOfAccounts'
        LookupFormKeyStringFieldName = 'AccountName'
        LookupComboType = ctAccount
        AllowFullListSearchMode = False
        DisableNotInList = False
        AllowMultipleSelectFromList = False
        OpenListinF6WhenNotinList = False
        DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
        LookupIDField = 'AccountID'
      end
      object cboHireProduct: TERPDbLookupCombo
        Left = 191
        Top = 208
        Width = 218
        Height = 23
        HelpContext = 1427029
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'PARTNAME'#9'60'#9'Product Name'#9'F')
        DataField = 'DefaultHireProductName'
        DataSource = dsPrefs
        LookupTable = qryProductLookup
        LookupField = 'Partname'
        ParentFont = False
        TabOrder = 6
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        LookupFormClassName = 'TProductListExpressGUI'
        EditFormClassName = 'TfrmParts'
        LookupFormKeyStringFieldName = 'ProductName'
        LookupComboType = ctProduct
        AllowFullListSearchMode = False
        DisableNotInList = False
        AllowMultipleSelectFromList = False
        OpenListinF6WhenNotinList = False
        DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
        LookupIDField = 'PartsID'
        LookupFieldAlt = 'ProductPrintName'
      end
    end
    object DNMPanel1: TDNMPanel
      Left = 0
      Top = 258
      Width = 886
      Height = 269
      HelpContext = 1427005
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        886
        269)
      object Bevel2: TBevel
        Left = 7
        Top = 7
        Width = 871
        Height = 253
        HelpContext = 1427006
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitWidth = 530
        ExplicitHeight = 330
      end
      object Label10: TLabel
        Left = 14
        Top = 14
        Width = 26
        Height = 15
        HelpContext = 1427007
        Caption = 'Hire '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label1: TLabel
        Left = 14
        Top = 37
        Width = 81
        Height = 15
        HelpContext = 1427008
        Caption = 'Hire Durations'
        Transparent = True
      end
      object grdMain: TwwDBGrid
        Left = 14
        Top = 56
        Width = 515
        Height = 161
        HelpContext = 1427009
        ControlType.Strings = (
          'Active;CheckBox;T;F')
        Selected.Strings = (
          'Description'#9'20'#9'Description'#9'F'#9
          'Duration'#9'13'#9'Duration'#9#9
          'StepDuration'#9'13'#9'Step Duration'#9#9
          'GraceDuration'#9'13'#9'Grace Period'#9'F'
          'Active'#9'1'#9'Active'#9#9)
        MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
        IniAttributes.SaveToRegistry = True
        IniAttributes.Delimiter = ';;'
        IniAttributes.CheckNewFields = True
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
        Color = clWhite
        DataSource = dsDuration
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgRowResize]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = True
        LineColors.GroupingColor = clSilver
        OnDblClick = grdMainDblClick
        FooterCellColor = clWhite
        ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
        PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
        object btnGrid: TwwIButton
          Left = 0
          Top = 0
          Width = 13
          Height = 22
          HelpContext = 1427010
          AllowAllUp = True
        end
      end
      object cmdNew: TDNMSpeedButton
        Left = 399
        Top = 225
        Width = 87
        Height = 27
        Hint = '"Add A New Entry"'
        HelpContext = 1427011
        Anchors = [akBottom]
        Caption = '&New'
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
        TabOrder = 1
        TabStop = False
        AutoDisableParentOnclick = True
        OnClick = cmdNewClick
      end
    end
  end
  inherited popSpelling: TPopupMenu
    Left = 344
    Top = 56
  end
  inherited tmrdelayMsg: TTimer
    Left = 280
  end
  object dsPrefs: TDataSourcePrefs
    FieldDefs = <>
    FieldNames.Strings = (
      'DefaultHireIncomeAccount'
      'DefaultHireProductName'
      'EndOfDay'
      'NoofWeekendDays'
      'StartOfDay'
      'StartWorkWeek')
    Left = 594
    Top = 56
  end
  object qryColumnHeadings: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblcolumnheadings')
    Left = 600
    Top = 112
  end
  object dsColumnHeadings: TDataSource
    DataSet = qryColumnHeadings
    Left = 648
    Top = 120
  end
  object qryDuration: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'Select '
      'DurationId as DurationId,'
      'Description as Description , '
      
        'if (Qty > 0, concat (Qty , '#39' '#39' , DurationtypeToDescription(Durat' +
        'ionType)),"") as Duration,'
      
        'if (StepQty > 0,concat (StepQty , '#39' '#39' , DurationtypeToDescriptio' +
        'n(StepDurationType)),"") as StepDuration,'
      
        'if (GraceQty > 0, concat (GraceQty , '#39' '#39' , DurationtypeToDescrip' +
        'tion(GraceDurationType)),"") as GraceDuration,'
      'Active as Active'
      'From tblDuration'
      'Order by Description')
    Left = 584
    Top = 176
    object qryDurationDescription: TWideStringField
      DisplayWidth = 20
      FieldName = 'Description'
      Origin = 'tblduration.Description'
      Size = 100
    end
    object qryDurationDuration: TWideStringField
      DisplayWidth = 13
      FieldName = 'Duration'
      Origin = 'Duration'
      Size = 73
    end
    object qryDurationStepDuration: TWideStringField
      DisplayLabel = 'Step Duration'
      DisplayWidth = 13
      FieldName = 'StepDuration'
      Origin = 'StepDuration'
      Size = 73
    end
    object qryDurationGraceDuration: TWideStringField
      DisplayLabel = 'Grace Period'
      DisplayWidth = 13
      FieldName = 'GraceDuration'
      Origin = 'GraceDuration'
      Size = 73
    end
    object qryDurationActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblduration.Active'
      FixedChar = True
      Size = 1
    end
    object qryDurationDurationId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'DurationId'
      Origin = 'tblduration.DurationId'
      Visible = False
    end
  end
  object MyConnection1: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    Options.KeepDesignConnected = False
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Server = 'localhost'
    LoginPrompt = False
    Left = 641
    Top = 184
  end
  object dsDuration: TDataSource
    DataSet = qryDuration
    Left = 640
    Top = 256
  end
  object qryIncomeAccountLookup: TERPQuery
    SQL.Strings = (
      
        'select AccountId, Accountname, AccountType from tblchartofaccoun' +
        'ts'
      'WHERE Active = "T" and IsHeader = "F" and AccountType="INC"'
      '  and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        '  or ((:SearchMode=1) and (AccountName like Concat(:SearchValue,' +
        ' "%")))'
      
        '  or ((:SearchMode = 2) and ((AccountName LIKE Concat("%",:Searc' +
        'hValue,"%")))))'
      'and IfNull(:SearchValue,"") <> ""'
      'ORDER BY AccountName')
    Left = 474
    Top = 402
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
    object qryIncomeAccountLookupAccountname: TWideStringField
      DisplayLabel = 'Account Name'
      DisplayWidth = 30
      FieldName = 'Accountname'
      Origin = 'tblchartofaccounts.AccountName'
      Size = 50
    end
    object qryIncomeAccountLookupAccountType: TWideStringField
      DisplayLabel = 'Type'
      DisplayWidth = 10
      FieldName = 'AccountType'
      Size = 50
    end
    object qryIncomeAccountLookupAccountId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'AccountId'
      Origin = 'tblchartofaccounts.AccountID'
      Visible = False
    end
  end
  object qryProductLookup: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT'
      'if((LOCATE('#39'^'#39',p.PRODUCTGROUP,InStr(p.PRODUCTGROUP,'#39'^'#39')+1)) >0,'
      'MID(p.PRODUCTGROUP,LOCATE('#39'^'#39',p.PRODUCTGROUP,'
      'InStr(p.PRODUCTGROUP,'#39'^'#39')+1)+1,char_length(p.PRODUCTGROUP)-'
      
        'LOCATE('#39'^'#39',p.PRODUCTGROUP,InStr(p.PRODUCTGROUP,'#39'^'#39')+1)),  Null) ' +
        ' AS '#39'Manuf'#39'  ,'
      'MID(p.PRODUCTGROUP, InStr(p.PRODUCTGROUP,'#39'^'#39')+1 ,'
      'If(LOCATE('#39'^'#39',p.PRODUCTGROUP,'
      'InStr(p.PRODUCTGROUP,'#39'^'#39')+1) - InStr(p.PRODUCTGROUP,'#39'^'#39') >0,'
      'LOCATE('#39'^'#39',p.PRODUCTGROUP,'
      'InStr(p.PRODUCTGROUP,'#39'^'#39')+1)-1 - InStr(p.PRODUCTGROUP,'#39'^'#39'),'
      'IF(InStr(p.PRODUCTGROUP,'#39'^'#39')<>0,'
      
        'char_length(p.PRODUCTGROUP) - InStr(p.PRODUCTGROUP,'#39'^'#39'),0))) AS ' +
        #39'Type'#39' ,'
      'If(InStr(p.PRODUCTGROUP,'#39'^'#39') -1 >0,'
      'Left(p.PRODUCTGROUP,InStr(p.PRODUCTGROUP,'#39'^'#39')-1),'
      'p.PRODUCTGROUP)   AS '#39'Dept'#39','
      'SupplierProductCode,'
      'p.PARTSID,p.PARTTYPE, p.PRODUCTGROUP, p.PARTNAME,'
      'p.PARTSDESCRIPTION, p.INCOMEACCNT,'
      'p.ASSETACCNT, p.COGSACCNT, p.BARCODE, p.PRODUCTCODE,'
      'p.TAXCODE, p.Batch, p.AutoBatch, p.MultipleBins,'
      'p.SpecialDiscount, p.SNTracking,  p.BuyQTY1, p.BuyQTY2,'
      
        'p.BuyQTY3, p.COST1, p.COST2, p.COST3, p.SellQTY1, p.SellQTY2, p.' +
        'SellQTY3,'
      
        'p.PRICE1, p.PRICE2, p.PRICE3, p.WHOLESALEPRICE, p.Active, p.Edit' +
        'edFlag,AvgCost,'
      'p.Discontinued, p.LatestCost'
      'FROM tblparts p'
      'WHERE p.Active = '#39'T'#39
      'ORDER BY p.PARTNAME')
    Left = 480
    Top = 448
  end
end
