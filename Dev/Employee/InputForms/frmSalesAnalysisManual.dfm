inherited fmSalesAnalysisManual: TfmSalesAnalysisManual
  HelpContext = 995001
  Caption = 'Sales Analysis (Manual)'
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 468
    ExplicitTop = 456
  end
  object pnlMain: TDNMPanel [5]
    Left = 0
    Top = 193
    Width = 949
    Height = 275
    HelpContext = 995006
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object cboreportingEmployee: TwwDBLookupCombo
      Left = 125
      Top = 89
      Width = 111
      Height = 23
      HelpContext = 995007
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'EmployeeName'#9'25'#9'Employee'#9'F')
      DataField = 'EmployeeName'
      DataSource = DSDetails
      LookupTable = QryReportingemployee
      LookupField = 'Employeename'
      DropDownWidth = 300
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnCloseUp = cboreportingEmployeeCloseUp
    end
    object grdTransactions: TwwDBGrid
      Left = 1
      Top = 1
      Width = 947
      Height = 273
      HelpContext = 995008
      ControlType.Strings = (
        'EmployeeName;CustomEdit;cboreportingEmployee;F'
        'comments;CustomEdit;edtcomments;F'
        'Source;CustomEdit;cboSource;F')
      Selected.Strings = (
        'EmployeeName'#9'15'#9'Employee'#9#9
        'ColdCalls'#9'10'#9'Cold Calls'#9'F'#9'Count'
        'Contact'#9'10'#9'Contacts'#9'F'#9'Count'
        'FirstDemo'#9'10'#9'First Demos'#9'F'#9'Count'
        'SecondDemo'#9'10'#9'Second Demos'#9'F'#9'Count'
        'Quotes'#9'10'#9'Quotes'#9'F'#9'Count'
        'SalesOrders'#9'10'#9'Sales Orders'#9'F'#9'Count'
        'Sales'#9'10'#9'Sales'#9'F'#9'Count'
        'Budgetcost'#9'10'#9'Cost'#9'F'#9'Budget'
        'BudgetIncome'#9'10'#9'Income'#9'F'#9'Budget'
        'Ratio'#9'10'#9'Ratio'#9'F'#9
        'COS'#9'10'#9'COS'#9'F'#9
        'comments'#9'10'#9'Comments'#9'F'#9
        'Source'#9'15'#9'Source'#9'F'#9)
      MemoAttributes = [mSizeable, mGridShow]
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = DSDetails
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgAllowInsert]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgRowResize]
      ParentFont = False
      TabOrder = 1
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = True
      OnEnter = grdTransactionsEnter
      FooterColor = clWhite
      FooterCellColor = clWhite
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
      object btnDelete: TwwIButton
        Left = 0
        Top = 0
        Width = 22
        Height = 34
        HelpContext = 995009
        AllowAllUp = True
        Glyph.Data = {
          26040000424D2604000000000000360000002800000012000000120000000100
          180000000000F0030000120B0000120B00000000000000000000FFFFFFFFFFFF
          636393525293FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF555591616191FFFFFFFFFFFF0000FDFDFD6060820000D20000DA3F3F
          7DF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F741417D0000CC00
          00CE5B5B80FBFBFB00009292A40000A40000C80000F60000BA30307BE7E7E7FF
          FFFFFFFFFFFFFFFFFFFFFFE7E7E734347C0000B20000FC0000D40000A28D8DA1
          000062628D0000BE0000D80000F80000F80000BA1F1F79DBDBDBFFFFFFFFFFFF
          D9D9D91C1C790000B00000FF1717FF0000F40000CA5C5C8900007979A90000CC
          0000D20000D60000F80000F40000B0131375DFDFDFDEDEDE1212750000B00000
          FA0F0FFF0000EA0000E40000E47373AB0000EAEAEC3F3FB30000CC0000D20000
          D80000F20000EE0000A812126B11116B0000A80000F60303FF0000E80000E200
          00DE3F3FBDEAEAEC0000FFFFFFFFFFFF4949B30000CC0000CE0000CC0000E400
          00DC00008A00008A0000DE0000EE0000E00000DE0000DC5252B6FFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFF6464AF0000D00000E00000E20000F60000D60000D6
          0000F40000DC0000D40000D26A6AB4FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFF8888BB0101F60303FF0000F80000FC0000FC0000FC0505FF0303
          E89696BEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFABAB
          AB0202910000E40000FC0000F80000F80000FC0000E2050592C7C7C7FFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF94949C00005800007C0000D607
          07FF0000FC0000FC0707FF0000CC00007600004EAEAEB2FFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFF8E8E960000540000840000E00F0FFF0303FF1111FF0F0FFF
          0303FF0F0FFF0000D600007C00004CB1B1B3FFFFFFFFFFFF0000FFFFFF93939B
          00004E00007C0000EA1F1FFF1111FF1F1FFF0505EC0000F21F1FFF0F0FFF1F1F
          FF0000DC000078000044B3B3B7FFFFFF0000E0E0E100004400007E0000EC2D2D
          FF1919FF2F2FFF0101FCD8D8DDC5C5CF0B0BFF2D2DFF1919FF2929FF0000E000
          007A151547FBFBFB0000C7C7C80000820000F63535FF2525FF3D3DFF0202FFCA
          CAD3FFFFFFFFFFFFACACC11515FF3939FF2525FF3535FF0000EA00006EEAEAEA
          0000E0E0E20000EA5757FF2F2FFF4949FF0707FFCACAD3FFFFFFFFFFFFFFFFFF
          FFFFFFA6A6BF1B1BFF4343FF3333FF5151FF1414D9F7F7F70000FFFFFFB6B6CD
          1B1BFF6565FF1212FFC9C9D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFACAC
          C22929FF6565FF1616FAD3D3DCFFFFFF0000FFFFFFFFFFFFAFAFC43333E6CCCC
          D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9898BE3737E4E0
          E0E3FFFFFFFFFFFF0000}
        Layout = blGlyphBottom
      end
    end
    object edtcomments: TwwDBEdit
      Left = 544
      Top = 56
      Width = 121
      Height = 23
      HelpContext = 995010
      DataField = 'MemoLine'
      DataSource = DSDetails
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object cboSource: TwwDBLookupCombo
      Left = 699
      Top = 56
      Width = 111
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'MediaType'#9'50'#9'MediaType'#9'F'#9)
      DataField = 'Source'
      DataSource = DSDetails
      LookupTable = qryMedia
      LookupField = 'MediaType'
      DropDownWidth = 300
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnDropDown = cboSourceDropDown
      HelpContext = 995036
    end
  end
  object pnlbottom: TDNMPanel [6]
    Left = 0
    Top = 468
    Width = 949
    Height = 64
    HelpContext = 995011
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      949
      64)
    object Label5: TLabel
      Left = 862
      Top = 25
      Width = 35
      Height = 15
      HelpContext = 995012
      Caption = 'Active'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblTmr: TLabel
      Left = 1
      Top = 1
      Width = 947
      Height = 15
      HelpContext = 995013
      Align = alTop
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
      ExplicitWidth = 3
    end
    object btnNext: TDNMSpeedButton
      Left = 139
      Top = 19
      Width = 87
      Height = 27
      HelpContext = 995014
      Anchors = [akTop, akRight]
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
      TabOrder = 0
      TabStop = False
      OnClick = btnNextClick
    end
    object btnCompleted: TDNMSpeedButton
      Left = 285
      Top = 19
      Width = 87
      Height = 27
      HelpContext = 995015
      Anchors = [akTop, akRight]
      Caption = '&Save'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      TabStop = False
      OnClick = btnCompletedClick
    end
    object btnClose: TDNMSpeedButton
      Left = 723
      Top = 19
      Width = 87
      Height = 27
      HelpContext = 995016
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&Cancel'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      TabStop = False
      OnClick = btnCloseClick
    end
    object btnPreview: TDNMSpeedButton
      Left = 431
      Top = 19
      Width = 87
      Height = 27
      HelpContext = 995017
      Anchors = [akTop, akRight]
      Caption = 'Pre&view'
      DisableTransparent = False
      Enabled = False
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
      TabOrder = 3
      TabStop = False
      OnClick = btnPreviewClick
    end
    object btnPrint: TDNMSpeedButton
      Left = 577
      Top = 19
      Width = 87
      Height = 27
      HelpContext = 995018
      Anchors = [akTop, akRight]
      Caption = 'Prin&t'
      DisableTransparent = False
      Enabled = False
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
      TabOrder = 4
      TabStop = False
      OnClick = btnPrintClick
    end
    object chkActive: TwwCheckBox
      Left = 905
      Top = 25
      Width = 14
      Height = 15
      HelpContext = 995019
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Caption = 'chkActive'
      DataField = 'Active'
      DataSource = DSMaster
      TabOrder = 5
    end
  end
  object pnlheader: TDNMPanel [7]
    Left = 0
    Top = 74
    Width = 949
    Height = 119
    HelpContext = 995020
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      949
      119)
    object SaleDate_Label: TLabel
      Left = 16
      Top = 6
      Width = 98
      Height = 15
      HelpContext = 995021
      Caption = 'Date of Reporting'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label1: TLabel
      Left = 16
      Top = 54
      Width = 98
      Height = 15
      HelpContext = 995022
      Caption = 'Reporting Period '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 261
      Top = 54
      Width = 13
      Height = 15
      HelpContext = 995023
      Caption = 'To'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 52
      Top = 93
      Width = 62
      Height = 15
      HelpContext = 995024
      Caption = 'Created By'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 331
      Top = 7
      Width = 67
      Height = 18
      HelpContext = 995025
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Comments'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label6: TLabel
      Left = 411
      Top = 93
      Width = 75
      Height = 15
      HelpContext = 995026
      Caption = 'Google Count'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object dtDateofReport: TwwDBDateTimePicker
      Left = 120
      Top = 11
      Width = 116
      Height = 23
      HelpContext = 995027
      AutoFillDateAndTime = True
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'DateofReport'
      DataSource = DSMaster
      Epoch = 1950
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 0
      UnboundDataType = wwDTEdtDate
    end
    object dtDateFrom: TwwDBDateTimePicker
      Left = 120
      Top = 50
      Width = 116
      Height = 23
      HelpContext = 995028
      AutoFillDateAndTime = True
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'DateFrom'
      DataSource = DSMaster
      Epoch = 1950
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 1
      UnboundDataType = wwDTEdtDate
    end
    object dtDateTo: TwwDBDateTimePicker
      Left = 280
      Top = 50
      Width = 116
      Height = 23
      HelpContext = 995029
      AutoFillDateAndTime = True
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'DateTo'
      DataSource = DSMaster
      Epoch = 1950
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 2
      UnboundDataType = wwDTEdtDate
    end
    object cboEmployee: TwwDBLookupCombo
      Left = 120
      Top = 90
      Width = 111
      Height = 23
      HelpContext = 995030
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'EmployeeName'#9'25'#9'Employee'#9'F')
      DataField = 'CreatedByEmployee'
      DataSource = DSMaster
      LookupTable = QryEmployee
      LookupField = 'employeeId'
      DropDownWidth = 300
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object txtComments: TDBMemo
      Left = 411
      Top = 6
      Width = 524
      Height = 72
      Hint = '"Type In A Comment For The Warehouse"'
      HelpContext = 995031
      Anchors = [akLeft, akBottom]
      DataField = 'comments'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ScrollBars = ssVertical
      ShowHint = True
      TabOrder = 4
    end
    object pnlChooseRpt: TDNMPanel
      Left = 803
      Top = 90
      Width = 132
      Height = 23
      HelpContext = 995032
      BevelOuter = bvLowered
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      object lblChooseRpt: TLabel
        Left = 28
        Top = 4
        Width = 98
        Height = 15
        HelpContext = 995033
        Caption = 'Choose Template'
        Transparent = True
      end
      object chkChooseRpt: TCheckBox
        Left = 7
        Top = 4
        Width = 14
        Height = 17
        HelpContext = 995034
        TabOrder = 0
      end
    end
    object wwDBEdit1: TwwDBEdit
      Left = 504
      Top = 90
      Width = 121
      Height = 23
      HelpContext = 995035
      DataField = 'Googlevisitcount'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  object pnltop: TDNMPanel [8]
    Left = 0
    Top = 0
    Width = 949
    Height = 74
    HelpContext = 995002
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object pnlTitle: TDNMPanel
      Left = 251
      Top = 12
      Width = 445
      Height = 45
      HelpContext = 995003
      Caption = 'Cash Sale'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 443
        Height = 43
        HelpContext = 995004
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
          Width = 443
          Height = 43
          HelpContext = 995005
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Sales Analysis (Manual)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = -3
          ExplicitWidth = 298
        end
      end
    end
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C01010200A400C00010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object tblMaster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblSalesAnalysisManual'
      'Where (ID= :ID);')
    Left = 7
    Top = 299
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblMasterID: TIntegerField
      FieldName = 'ID'
    end
    object tblMasterGlobalref: TWideStringField
      FieldName = 'Globalref'
      Size = 255
    end
    object tblMasterDateofReport: TDateField
      FieldName = 'DateofReport'
    end
    object tblMasterDateFrom: TDateField
      FieldName = 'DateFrom'
    end
    object tblMasterDateTo: TDateField
      FieldName = 'DateTo'
    end
    object tblMasterCreatedby: TIntegerField
      FieldName = 'Createdby'
    end
    object tblMasterCreatedOn: TDateField
      FieldName = 'CreatedOn'
    end
    object tblMastercomments: TWideMemoField
      FieldName = 'comments'
      BlobType = ftWideMemo
    end
    object tblMastermsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object tblMastermsUpdatesiteCode: TWideStringField
      FieldName = 'msUpdatesiteCode'
      Size = 3
    end
    object tblMasterActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object tblMasterCreatedByEmployee: TStringField
      FieldKind = fkLookup
      FieldName = 'CreatedByEmployee'
      LookupDataSet = QryEmployee
      LookupKeyFields = 'employeeId'
      LookupResultField = 'Employeename'
      KeyFields = 'Createdby'
      Size = 100
      Lookup = True
    end
    object tblMasterGooglevisitcount: TIntegerField
      FieldName = 'Googlevisitcount'
    end
  end
  object DSMaster: TDataSource
    DataSet = tblMaster
    Left = 7
    Top = 379
  end
  object DSDetails: TDataSource
    DataSet = tblDetails
    Left = 67
    Top = 387
  end
  object tblDetails: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT SL.*,'
      '((SL.Sales / SL.ColdCalls) * 100) as Ratio,'
      '(ifnull(budgetcost, 0)  / ifnull(SL.Sales, 1)) as COS'
      'from tblsalesanalysismanuallines SL'
      'Where SalesAnalysisID = :ID')
    Filtered = True
    Filter = 'Deleted ="F"'
    Left = 67
    Top = 299
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblDetailsEmployeeName: TWideStringField
      DisplayLabel = 'Employee'
      DisplayWidth = 15
      FieldName = 'EmployeeName'
      Origin = 'tblSalesAnalysisManuallines.EmployeeName'
      Size = 100
    end
    object tblDetailsColdCalls: TIntegerField
      DisplayLabel = 'Cold Calls'
      DisplayWidth = 10
      FieldName = 'ColdCalls'
      Origin = 'tblSalesAnalysisManuallines.ColdCalls'
    end
    object tblDetailsContact: TIntegerField
      DisplayLabel = 'Contacts'
      DisplayWidth = 10
      FieldName = 'Contact'
      Origin = 'tblSalesAnalysisManuallines.Contact'
    end
    object tblDetailsFirstDemo: TIntegerField
      DisplayLabel = 'First Demos'
      DisplayWidth = 10
      FieldName = 'FirstDemo'
      Origin = 'tblSalesAnalysisManuallines.FirstDemo'
    end
    object tblDetailsSecondDemo: TIntegerField
      DisplayLabel = 'Second Demos'
      DisplayWidth = 10
      FieldName = 'SecondDemo'
      Origin = 'tblSalesAnalysisManuallines.SecondDemo'
    end
    object tblDetailsQuotes: TIntegerField
      DisplayWidth = 10
      FieldName = 'Quotes'
      Origin = 'tblSalesAnalysisManuallines.Quotes'
    end
    object tblDetailsSalesOrders: TIntegerField
      DisplayLabel = 'Sales Orders'
      DisplayWidth = 10
      FieldName = 'SalesOrders'
      Origin = 'tblSalesAnalysisManuallines.SalesOrders'
    end
    object tblDetailsSales: TIntegerField
      DisplayWidth = 10
      FieldName = 'Sales'
      Origin = 'tblSalesAnalysisManuallines.Sales'
    end
    object tblDetailsBudgetcost: TFloatField
      DisplayLabel = 'Cost'
      DisplayWidth = 10
      FieldName = 'Budgetcost'
      currency = True
    end
    object tblDetailsBudgetIncome: TFloatField
      DisplayLabel = 'Income'
      DisplayWidth = 10
      FieldName = 'BudgetIncome'
      currency = True
    end
    object tblDetailsRatio: TFloatField
      DisplayWidth = 10
      FieldName = 'Ratio'
      DisplayFormat = '####0.00%'
    end
    object tblDetailsCOS: TFloatField
      DisplayWidth = 10
      FieldName = 'COS'
      DisplayFormat = '####00.00##$'
    end
    object tblDetailscomments: TWideMemoField
      DisplayLabel = 'Comments'
      DisplayWidth = 10
      FieldName = 'comments'
      BlobType = ftWideMemo
    end
    object tblDetailsSource: TWideStringField
      DisplayWidth = 15
      FieldName = 'Source'
      Size = 60
    end
    object tblDetailsEmployeeId: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeId'
      Origin = 'tblSalesAnalysisManuallines.EmployeeId'
      Visible = False
    end
    object tblDetailsGlobalref: TWideStringField
      DisplayWidth = 255
      FieldName = 'Globalref'
      Origin = 'tblSalesAnalysisManuallines.Globalref'
      Visible = False
      Size = 255
    end
    object tblDetailsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblSalesAnalysisManuallines.ID'
      Visible = False
    end
    object tblDetailsmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblSalesAnalysisManuallines.msTimeStamp'
      Visible = False
    end
    object tblDetailsmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblSalesAnalysisManuallines.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
    object tblDetailsSalesAnalysisID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SalesAnalysisID'
      Origin = 'tblSalesAnalysisManuallines.SalesAnalysisID'
      Visible = False
    end
    object tblDetailsDeleted: TWideStringField
      FieldName = 'Deleted'
      Origin = 'tblSalesAnalysisManuallines.Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object QryEmployee: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select employeeId, Employeename,active from tblEmployees where A' +
        'ctive ="T" or EmployeeID = :EmployeeID'
      'order by Employeename')
    BeforeOpen = QryEmployeeBeforeOpen
    Left = 139
    Top = 339
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EmployeeID'
      end>
    object QryEmployeeEmployeename: TWideStringField
      DisplayLabel = 'Employee'
      DisplayWidth = 25
      FieldName = 'Employeename'
      Origin = 'tblemployees.EmployeeName'
      Size = 255
    end
    object QryEmployeeemployeeId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'employeeId'
      Origin = 'tblemployees.EmployeeID'
      Visible = False
    end
    object QryEmployeeactive: TWideStringField
      FieldName = 'active'
      Origin = 'tblemployees.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object QryReportingemployee: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select employeeId, Employeename,active from tblEmployees where A' +
        'ctive ="T" or EmployeeID = :EmployeeID'
      'order by Employeename')
    BeforeOpen = QryEmployeeBeforeOpen
    Left = 243
    Top = 347
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EmployeeID'
      end>
    object QryReportingemployeeemployeeId: TIntegerField
      FieldName = 'employeeId'
    end
    object QryReportingemployeeEmployeename: TWideStringField
      FieldName = 'Employeename'
      Size = 255
    end
    object QryReportingemployeeactive: TWideStringField
      FieldName = 'active'
      FixedChar = True
      Size = 1
    end
  end
  object qryMedia: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select MediaType from tblSource where (Active ="T")'
      'and MediaType <> ""'
      'order by MediaType')
    BeforeOpen = qryMediaBeforeOpen
    Left = 403
    Top = 283
    object qryMediaMediaType: TWideStringField
      DisplayWidth = 50
      FieldName = 'MediaType'
      Size = 50
    end
  end
end
