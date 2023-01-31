inherited frmTimeSheet: TfrmTimeSheet
  Left = 807
  Top = 149
  HelpContext = 359000
  Caption = 'Time Sheet Entry'
  ClientHeight = 449
  ClientWidth = 906
  OldCreateOrder = True
  Position = poScreenCenter
  ExplicitWidth = 912
  ExplicitHeight = 478
  DesignSize = (
    906
    449)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 387
    Width = 906
    HelpContext = 359013
    ExplicitTop = 387
    ExplicitWidth = 906
  end
  inherited imgGridWatermark: TImage
    HelpContext = 359001
  end
  object pnlFooter: TDNMPanel [5]
    Left = 0
    Top = 387
    Width = 906
    Height = 62
    HelpContext = 359029
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      906
      62)
    object btnClose: TDNMSpeedButton
      Left = 700
      Top = 18
      Width = 87
      Height = 27
      HelpContext = 359004
      Anchors = [akBottom]
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = btnCloseClick
    end
    object btnServices: TDNMSpeedButton
      Left = 342
      Top = 18
      Width = 87
      Height = 27
      HelpContext = 359007
      Anchors = [akBottom]
      Caption = 'S&ervices'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333000003333333333F77777FFF333333009999900
        3333333777777777FF33330998FFF899033333777333F3777FF33099FFFCFFF9
        903337773337333777F3309FFFFFFFCF9033377333F3337377FF098FF0FFFFFF
        890377F3373F3333377F09FFFF0FFFFFF90377F3F373FFFFF77F09FCFFF90000
        F90377F733377777377F09FFFFFFFFFFF90377F333333333377F098FFFFFFFFF
        890377FF3F33333F3773309FCFFFFFCF9033377F7333F37377F33099FFFCFFF9
        90333777FF37F3377733330998FCF899033333777FF7FF777333333009999900
        3333333777777777333333333000003333333333377777333333}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = btnServicesClick
    end
    object btnSave: TDNMSpeedButton
      Left = 116
      Top = 18
      Width = 87
      Height = 27
      HelpContext = 359030
      Action = actSave
      Anchors = [akBottom]
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      AutoDisableParentOnclick = True
    end
    object btnAccept: TDNMSpeedButton
      Left = 453
      Top = 18
      Width = 87
      Height = 27
      HelpContext = 359008
      Anchors = [akBottom]
      Caption = '&Accept'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555FFFFFFFFFF5F5557777777777505555777777777757F55555555555555
        055555555555FF5575F555555550055030555555555775F7F7F55555550FB000
        005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
        B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
        305555577F555557F7F5550E0BFBFB003055557575F55577F7F550EEE0BFB0B0
        305557FF575F5757F7F5000EEE0BFBF03055777FF575FFF7F7F50000EEE00000
        30557777FF577777F7F500000E05555BB05577777F75555777F5500000555550
        3055577777555557F7F555000555555999555577755555577755}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 3
      AutoDisableParentOnclick = True
      OnClick = btnAcceptClick
    end
    object btnLoadRoster: TDNMSpeedButton
      Left = 230
      Top = 18
      Width = 87
      Height = 27
      Hint = '"Load Hours for this Pay from Roster"'
      HelpContext = 359031
      Anchors = [akBottom]
      Caption = '&Load Roster'
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
      ModalResult = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnLoadRosterClick
    end
    object btnAllocatetoRepair: TDNMSpeedButton
      Left = 565
      Top = 18
      Width = 110
      Height = 27
      Hint = 
        'Select to allocate all '#39'Repair'#39' time sheets to the '#39'Repair Recor' +
        'd'#39
      HelpContext = 359033
      Anchors = [akBottom]
      Caption = 'Allocate To Repair'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      AutoDisableParentOnclick = True
      OnClick = btnAllocatetoRepairClick
    end
  end
  object pnlheader: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 906
    Height = 87
    HelpContext = 359014
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      906
      87)
    object Label1: TLabel
      Left = 744
      Top = 23
      Width = 155
      Height = 15
      HelpContext = 359002
      Anchors = [akTop, akRight]
      Caption = 'Don'#39't Show Date Messages'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lbltype: TLabel
      Left = 8
      Top = 64
      Width = 26
      Height = 15
      HelpContext = 359015
      Caption = 'Type'
      Transparent = True
      Visible = False
    end
    object Label3: TLabel
      Left = 775
      Top = 64
      Width = 53
      Height = 15
      HelpContext = 359016
      Caption = 'Entry No :'
      Transparent = True
    end
    object pnlTitle: TDNMPanel
      Left = 318
      Top = 5
      Width = 272
      Height = 42
      HelpContext = 359009
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Invoice'
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
        Width = 270
        Height = 40
        HelpContext = 359010
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
          Width = 270
          Height = 40
          HelpContext = 359011
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Time Sheet Entry'
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
    object chkDontShowMsgs: TCheckBox
      Left = 724
      Top = 23
      Width = 14
      Height = 17
      HelpContext = 359012
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object edtType: TwwDBEdit
      Left = 48
      Top = 60
      Width = 121
      Height = 23
      HelpContext = 359017
      DataField = 'Type'
      DataSource = DSMaster
      ReadOnly = True
      TabOrder = 2
      UnboundDataType = wwDefault
      Visible = False
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit1: TwwDBEdit
      Left = 848
      Top = 60
      Width = 49
      Height = 23
      HelpContext = 359018
      DataField = 'TimesheetEntryID'
      DataSource = DSMaster
      ReadOnly = True
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  object DNMPanel2: TDNMPanel [7]
    Left = 0
    Top = 87
    Width = 906
    Height = 300
    HelpContext = 359003
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    Transparent = False
    object lblTmrMsg: TLabel
      Left = 1
      Top = 284
      Width = 904
      Height = 15
      HelpContext = 359034
      Align = alBottom
      Alignment = taCenter
      Caption = 'lblTmrMsg'
      Visible = False
      ExplicitWidth = 60
    end
    object grdTimesheets: TwwDBGrid
      Left = 1
      Top = 1
      Width = 904
      Height = 283
      HelpContext = 359006
      ControlType.Strings = (
        'Date;CustomEdit;wwDTPSelector;F'
        'Job;CustomEdit;cboJobs;F'
        'EmployeeName;CustomEdit;cboName;F'
        'ClassName;CustomEdit;cboClass;F'
        'ServiceName;CustomEdit;cboServices;F'
        'PayRateTypeName;CustomEdit;cboRateType;F'
        'SuperInc;CheckBox;T;F'
        'ServiceDate;CustomEdit;dtServiceDate;F'
        'AllowEdit;CheckBox;T;F'
        'UseTimeCost;CheckBox;T;F'
        'Equipment;CustomEdit;cboEquipmentname;F'
        'Area;CustomEdit;cboAreaCode;F'
        'RepairDocNo;CustomEdit;cboRepairDocNo;F'
        'Approved;CheckBox;T;F'
        'Done;CheckBox;T;F')
      Selected.Strings = (
        'EmployeeName'#9'9'#9'Name'#9#9
        'Area'#9'10'#9'Area'#9#9
        'timesheetDate'#9'9'#9'Date'#9#9
        'Equipment'#9'12'#9'Equipment'#9#9
        'RepairDocNo'#9'12'#9'Repair #'#9#9
        'Job'#9'12'#9'Job'#9#9
        'PayRateTypeName'#9'7'#9'Rate'#9#9
        'LabourCost'#9'9'#9'Rate/Salary'#9#9
        'Hours'#9'4'#9'Hours'#9#9
        'ServiceName'#9'16'#9'Service Name'#9#9
        'Qty'#9'6'#9'Quantity'#9#9
        'ChargeRate'#9'15'#9'Rate per Hour (Inc)'#9#9
        'ServiceDate'#9'10'#9'Service Date'#9#9
        'ClassName'#9'9'#9'Department'#9#9
        'Notes'#9'10'#9'Technical Notes'#9#9
        'InvoiceNotes'#9'10'#9'Invoice Notes'#9#9
        'AllowEdit'#9'7'#9'AllowEdit'#9#9
        'UseTimeCost'#9'10'#9'UseTimeCost'#9#9
        'Total'#9'5'#9'Total'#9#9
        'TotalServicecharge'#9'15'#9'TotalServicecharge'#9#9
        'RepairID'#9'10'#9'RepairID'#9#9
        'OverheadRate'#9'10'#9'OverheadRate'#9#9
        'TotalAdjusted'#9'10'#9'TotalAdjusted'#9'F'#9
        'Approved'#9'1'#9'Approved'#9'T'
        'Done'#9'1'#9'Done'#9'T'
        'DoneStatus'#9'50'#9'Done Status'#9'T')
      MemoAttributes = [mSizeable, mWordWrap, mGridShow, mDisableDialog]
      IniAttributes.Delimiter = ';;'
      TitleColor = clWindow
      OnRowChanged = grdTimesheetsRowChanged
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableEditorIfReadOnly]
      Align = alClient
      DataSource = DSTimesheet
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgAllowInsert]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgRowResize]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = True
      OnCalcCellColors = grdTimesheetsCalcCellColors
      OnCalcTitleAttributes = grdTimesheetsCalcTitleAttributes
      OnTitleButtonClick = grdTimesheetsTitleButtonClick
      OnColEnter = grdTimesheetsColEnter
      OnColExit = grdTimesheetsColExit
      OnDblClick = grdTimesheetsDblClick
      OnEnter = grdTimesheetsEnter
      OnCalcTitleImage = grdTimesheetsCalcTitleImage
      OnUpdateFooter = grdTimesheetsUpdateFooter
      TitleImageList = imgPopup
      FooterColor = clWindow
      object grdTimesheetsIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 26
        Height = 34
        Action = actDelRecord
        AllowAllUp = True
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033337733333333333333333F333333333333
          0000333911733333973333333377F333333F3333000033391117333911733333
          37F37F333F77F33300003339111173911117333337F337F3F7337F3300003333
          911117111117333337F3337F733337F3000033333911111111733333337F3337
          3333F7330000333333911111173333333337F333333F73330000333333311111
          7333333333337F3333373333000033333339111173333333333337F333733333
          00003333339111117333333333333733337F3333000033333911171117333333
          33337333337F333300003333911173911173333333373337F337F33300003333
          9117333911173333337F33737F337F33000033333913333391113333337FF733
          37F337F300003333333333333919333333377333337FFF730000333333333333
          3333333333333333333777330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
      end
    end
    object dtServiceDate: TwwDBDateTimePicker
      Left = 204
      Top = 43
      Width = 78
      Height = 23
      HelpContext = 359020
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'ServiceDate'
      DataSource = DSTimesheet
      Epoch = 1950
      ShowButton = True
      TabOrder = 1
      OnCloseUp = dtServiceDateExit
      OnExit = dtServiceDateExit
    end
    object cboName: TwwDBLookupCombo
      Left = 29
      Top = 43
      Width = 78
      Height = 23
      HelpContext = 359021
      DropDownAlignment = taLeftJustify
      DataField = 'EmployeeName'
      DataSource = DSTimesheet
      LookupTable = qryEmployee
      LookupField = 'EmployeeName'
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnCloseUp = cboNameCloseUp
    end
    object cboJobs: TERPDbLookupCombo
      Left = 292
      Top = 43
      Width = 78
      Height = 23
      HelpContext = 359022
      AutoSize = False
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'30'#9'Company'#9'F'
        'JobNumber'#9'10'#9'JobNumber'#9'F')
      DataField = 'Job'
      DataSource = DSTimesheet
      LookupTable = qryJobs
      LookupField = 'Company'
      Options = [loTitles]
      Style = csDropDownList
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      ShowMatchText = True
      OnCloseUp = cboJobsCloseUp
      OnExit = cboJobsExit
      OnNotInList = cboJobsNotInList
      LookupFormClassName = 'TCustomerExpressListGUI'
      EditFormClassName = 'TfrmCustomer'
      LookupFormKeyStringFieldName = 'Company'
      LookupComboType = ctCustomer
      AllowFullListSearchMode = False
      DisableNotInList = False
      AllowMultipleSelectFromList = False
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      LookupIDField = 'ClientID'
      LookupFieldAlt = 'PrintName'
    end
    object cboClass: TwwDBLookupCombo
      Left = 555
      Top = 43
      Width = 78
      Height = 23
      HelpContext = 359023
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'ClassName'#9'30'#9'Department'#9'F')
      DataField = 'ClassName'
      DataSource = DSTimesheet
      LookupTable = qryClasses
      LookupField = 'ClassName'
      TabOrder = 4
      Visible = False
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnCloseUp = cboClassCloseUp
    end
    object cboServices: TwwDBLookupCombo
      Left = 380
      Top = 43
      Width = 78
      Height = 23
      HelpContext = 359024
      DropDownAlignment = taRightJustify
      Selected.Strings = (
        'ServiceName'#9'30'#9'ServiceName'#9'F')
      DataField = 'ServiceName'
      DataSource = DSTimesheet
      LookupTable = qryServices
      LookupField = 'ServiceName'
      Style = csDropDownList
      TabOrder = 5
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnDropDown = cboServicesDropDown
      OnCloseUp = cboServicesCloseUp
      OnNotInList = cboServicesNotInList
    end
    object cboRateType: TwwDBLookupCombo
      Left = 467
      Top = 43
      Width = 78
      Height = 23
      HelpContext = 359025
      DropDownAlignment = taRightJustify
      Selected.Strings = (
        'Description'#9'30'#9'Rate Type'#9'F')
      DataField = 'PayRateTypeName'
      DataSource = DSTimesheet
      LookupTable = qryPayRates
      LookupField = 'Description'
      TabOrder = 6
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnCloseUp = cboRateTypeCloseUp
    end
    object cboEquipmentname: TwwDBLookupCombo
      Left = 116
      Top = 43
      Width = 78
      Height = 23
      HelpContext = 359026
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'EquipmentName'#9'20'#9'Name'#9'F'
        'RepairNo'#9'15'#9'Repair #'#9'F'
        'Serialno'#9'1'#9'Serial#'#9'F'
        'Quantity'#9'1'#9'Quantity'#9'F'
        'Manufacture'#9'1'#9'Manufacture'#9'F'
        'model'#9'1'#9'Model'#9'F'
        'Registration'#9'1'#9'Registration'#9'F'
        'WarantyFinishDate'#9'1'#9'Warranty Finish'#9'F'
        'WarantyPeriod'#9'1'#9'Warranty Period'#9'F')
      DataField = 'Equipment'
      DataSource = DSTimesheet
      LookupTable = qryrepairequip
      LookupField = 'EquipmentName'
      Options = [loTitles]
      TabOrder = 7
      Visible = False
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnDblClick = cboEquipmentnameDblClick
      OnBeforeDropDown = cboEquipmentnameBeforeDropDown
      OnCloseUp = cboEquipmentnameCloseUp
      OnNotInList = cboEquipmentnameNotInList
    end
    object cboRepairDocNo: TwwDBLookupCombo
      Left = 643
      Top = 43
      Width = 83
      Height = 23
      HelpContext = 359027
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'RepairDocNo'#9'20'#9'Repair #'#9'F'
        'CustomerName'#9'30'#9'Customer Name'#9'F')
      DataField = 'RepairDocNo'
      DataSource = DSTimesheet
      LookupTable = qryRepairLookup
      LookupField = 'RepairID'
      Options = [loTitles]
      TabOrder = 8
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnCloseUp = cboRepairDocNoCloseUp
      OnExit = cboRepairDocNoExit
    end
    object cboAreaCode: TwwDBLookupCombo
      Left = 731
      Top = 42
      Width = 63
      Height = 24
      HelpContext = 359028
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AreaCode'#9'10'#9'Code'#9'F'
        'AreaName'#9'20'#9'Name'#9'F')
      DataField = 'Area'
      DataSource = DSTimesheet
      LookupTable = QryAreaCodes
      LookupField = 'AreaCode'
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
  end
  inherited tmrProcessMessage: TTimer
    Top = 48
  end
  inherited tmrdelay: TTimer
    Left = 440
    Top = 40
  end
  inherited popSpelling: TPopupMenu
    Left = 64
    Top = 176
  end
  inherited tmrdelayMsg: TTimer
    Left = 80
    Top = 16
  end
  inherited dlgReportSelect: TSelectionDialog
    Top = 40
  end
  inherited ApplicationEvents1: TApplicationEvents
    Top = 40
  end
  inherited MyConnection: TERPConnection
    Database = 'aus_sample_company'
    Server = 'localhost'
    Connected = True
    Top = 7
  end
  inherited DataState: TDataState
    Top = 40
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 123
    Top = 40
  end
  inherited imgsort: TImageList
    Top = 48
    Bitmap = {
      494C010102009800C00010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited QryCustomField: TERPQuery
    Top = 40
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 334
    Top = 48
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Top = 40
  end
  inherited qryMemTrans: TERPQuery
    Left = 53
    Top = 32
  end
  object ActionList1: TActionList
    Left = 136
    Top = 8
    object actSave: TAction
      Caption = '&Save'
      HelpContext = 359032
      OnExecute = actSaveExecute
      OnUpdate = actSaveUpdate
    end
    object actDelRecord: TAction
      OnExecute = actDelRecordExecute
    end
  end
  object qryTimesheets: TERPQuery
    Connection = MyConnection
    ParamCheck = False
    SQL.Strings = (
      '##################################################'
      '# PLEASE READ!'
      
        '# If modifying this SQL statement then please keep your *WHERE* ' +
        'clause'
      
        '# on one line.  Also if ReadOnlyMode is set, then the *WHERE* cl' +
        'ause'
      '# is fully removed.'
      '#'
      '##################################################'
      ''
      'SELECT '
      '*'
      'FROM tbltimesheets'
      'WHERE Active = '#39'T'#39' and TimesheetEntryID = :TimesheetEntryID'
      'ORDER BY timesheetDate')
    AutoCalcFields = False
    AfterOpen = qryTimesheetsAfterOpen
    Left = 144
    Top = 320
    ParamData = <
      item
        DataType = ftInteger
        Name = 'TimesheetEntryID'
        Value = 0
      end>
    object qryTimesheetsEmployeeName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 9
      FieldName = 'EmployeeName'
      Origin = 'tbltimesheets.EmployeeName'
      Size = 255
    end
    object qryTimesheetsArea: TWideStringField
      DisplayWidth = 10
      FieldName = 'Area'
      Origin = 'tbltimesheets.Area'
      Size = 50
    end
    object qryTimesheetstimesheetDate: TDateTimeField
      DisplayLabel = 'Date'
      DisplayWidth = 9
      FieldName = 'timesheetDate'
      Origin = 'tbltimesheets.TimesheetDate'
    end
    object qryTimesheetsEquipment: TWideStringField
      DisplayWidth = 12
      FieldName = 'Equipment'
      Origin = 'tbltimesheets.Equipment'
      Size = 100
    end
    object qryTimesheetsRepairDocNo: TStringField
      DisplayLabel = 'Repair #'
      DisplayWidth = 12
      FieldKind = fkLookup
      FieldName = 'RepairDocNo'
      LookupDataSet = qryRepairLookup
      LookupKeyFields = 'RepairID'
      LookupResultField = 'RepairDocNo'
      KeyFields = 'RepairID'
      Size = 255
      Lookup = True
    end
    object qryTimesheetsJob: TWideStringField
      DisplayWidth = 12
      FieldName = 'Job'
      Origin = 'tbltimesheets.Job'
      Size = 255
    end
    object qryTimesheetsPayRateTypeName: TWideStringField
      DisplayLabel = 'Rate'
      DisplayWidth = 7
      FieldName = 'PayRateTypeName'
      Origin = 'tbltimesheets.PayRateTypeName'
      Size = 255
    end
    object qryTimesheetsLabourCost: TFloatField
      DisplayLabel = 'Rate/Salary'
      DisplayWidth = 9
      FieldName = 'LabourCost'
      Origin = 'tbltimesheets.LabourCost'
      currency = True
    end
    object qryTimesheetsHours: TFloatField
      DisplayWidth = 4
      FieldName = 'Hours'
      Origin = 'tbltimesheets.Hours'
    end
    object qryTimesheetsServiceName: TWideStringField
      DisplayLabel = 'Service Name'
      DisplayWidth = 16
      FieldName = 'ServiceName'
      Origin = 'tbltimesheets.ServiceName'
      Size = 255
    end
    object qryTimesheetsQty: TFloatField
      DisplayLabel = 'Quantity'
      DisplayWidth = 6
      FieldName = 'Qty'
      Origin = 'tbltimesheets.Qty'
    end
    object qryTimesheetsChargeRate: TFloatField
      DisplayLabel = 'Rate per Hour (Inc)'
      DisplayWidth = 15
      FieldName = 'ChargeRate'
      Origin = 'tbltimesheets.ChargeRate'
      currency = True
    end
    object qryTimesheetsServiceDate: TDateField
      DisplayLabel = 'Service Date'
      DisplayWidth = 10
      FieldName = 'ServiceDate'
      Origin = 'tbltimesheets.ServiceDate'
    end
    object qryTimesheetsClassName: TWideStringField
      DisplayLabel = 'Department'
      DisplayWidth = 9
      FieldName = 'ClassName'
      Origin = 'tbltimesheets.ClassName'
      Size = 255
    end
    object qryTimesheetsNotes: TWideMemoField
      DisplayLabel = 'Technical Notes'
      DisplayWidth = 10
      FieldName = 'Notes'
      Origin = 'tbltimesheets.Notes'
      BlobType = ftWideMemo
    end
    object qryTimesheetsInvoiceNotes: TWideMemoField
      DisplayLabel = 'Invoice Notes'
      DisplayWidth = 10
      FieldName = 'InvoiceNotes'
      Origin = 'tbltimesheets.InvoiceNotes'
      BlobType = ftWideMemo
    end
    object qryTimesheetsAllowEdit: TWideStringField
      DisplayWidth = 7
      FieldName = 'AllowEdit'
      Origin = 'tbltimesheets.AllowEdit'
      FixedChar = True
      Size = 1
    end
    object qryTimesheetsUseTimeCost: TWideStringField
      DisplayWidth = 10
      FieldName = 'UseTimeCost'
      Origin = 'tbltimesheets.UseTimeCost'
      FixedChar = True
      Size = 1
    end
    object qryTimesheetsTotal: TFloatField
      DisplayWidth = 5
      FieldName = 'Total'
      Origin = 'tbltimesheets.Total'
      currency = True
    end
    object qryTimesheetsTotalServicecharge: TFloatField
      DisplayWidth = 15
      FieldName = 'TotalServicecharge'
      Origin = 'tbltimesheets.TotalServicecharge'
      DisplayFormat = '$#######0.00'
      currency = True
    end
    object qryTimesheetsRepairID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RepairID'
      Origin = 'tbltimesheets.RepairID'
    end
    object qryTimesheetsOverheadRate: TFloatField
      DisplayWidth = 10
      FieldName = 'OverheadRate'
      Origin = 'tbltimesheets.OverheadRate'
    end
    object qryTimesheetsTotalAdjusted: TFloatField
      DisplayWidth = 10
      FieldName = 'TotalAdjusted'
    end
    object qryTimesheetsApproved: TWideStringField
      DisplayWidth = 1
      FieldName = 'Approved'
      FixedChar = True
      Size = 1
    end
    object qryTimesheetsDone: TWideStringField
      DisplayWidth = 1
      FieldName = 'Done'
      FixedChar = True
      Size = 1
    end
    object qryTimesheetsDoneStatus: TWideStringField
      DisplayLabel = 'Done Status'
      DisplayWidth = 50
      FieldName = 'DoneStatus'
      Size = 50
    end
    object qryTimesheetscustomerEquipmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'customerEquipmentID'
      Origin = 'tbltimesheets.CustomerEquipmentID'
      Visible = False
    end
    object qryTimesheetsTimesheetEntryID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TimesheetEntryID'
      Origin = 'tbltimesheets.TimesheetEntryID'
      Visible = False
    end
    object qryTimesheetsSuperInc: TWideStringField
      DisplayLabel = 'Super'
      DisplayWidth = 1
      FieldName = 'SuperInc'
      Origin = 'tbltimesheets.SuperInc'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryTimesheetsGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Origin = 'tbltimesheets.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryTimesheetsID: TAutoIncField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tbltimesheets.ID'
      ReadOnly = True
      Visible = False
    end
    object qryTimesheetsJobID: TIntegerField
      DisplayWidth = 10
      FieldName = 'JobID'
      Origin = 'tbltimesheets.JobID'
      Visible = False
    end
    object qryTimesheetsEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'tbltimesheets.EmployeeID'
      Visible = False
    end
    object qryTimesheetsClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
      Origin = 'tbltimesheets.ClassID'
      Visible = False
    end
    object qryTimesheetsRosterID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RosterID'
      Origin = 'tbltimesheets.RosterID'
      Visible = False
    end
    object qryTimesheetsServiceID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ServiceID'
      Origin = 'tbltimesheets.ServiceID'
      Visible = False
    end
    object qryTimesheetsPartID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PartID'
      Origin = 'tbltimesheets.PartID'
      Visible = False
    end
    object qryTimesheetsPartName: TWideStringField
      DisplayWidth = 40
      FieldName = 'PartName'
      Origin = 'tbltimesheets.PartName'
      Visible = False
      Size = 255
    end
    object qryTimesheetsPayRateTypeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PayRateTypeID'
      Origin = 'tbltimesheets.PayRateTypeID'
      Visible = False
    end
    object qryTimesheetsHourlyRate: TFloatField
      DisplayWidth = 10
      FieldName = 'HourlyRate'
      Origin = 'tbltimesheets.HourlyRate'
      Visible = False
      currency = True
    end
    object qryTimesheetsSuperAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'SuperAmount'
      Origin = 'tbltimesheets.SuperAmount'
      Visible = False
      currency = True
    end
    object qryTimesheetsActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tbltimesheets.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryTimesheetsSalesID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SalesID'
      Origin = 'tbltimesheets.SalesID'
      Visible = False
    end
    object qryTimesheetsTax: TFloatField
      DisplayWidth = 10
      FieldName = 'Tax'
      Origin = 'tbltimesheets.Tax'
      Visible = False
      currency = True
    end
    object qryTimesheetsPartsDescription: TWideStringField
      DisplayWidth = 40
      FieldName = 'PartsDescription'
      Origin = 'tbltimesheets.PartsDescription'
      Visible = False
      Size = 255
    end
    object qryTimesheetsSaleLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleLineID'
      Origin = 'tbltimesheets.SaleLineID'
      Visible = False
    end
  end
  object DSTimesheet: TDataSource
    DataSet = qryTimesheets
    Left = 144
    Top = 290
  end
  object DSJobs: TDataSource
    DataSet = qryJobs
    Left = 240
    Top = 290
  end
  object DSEmployee: TDataSource
    DataSet = qryEmployee
    Left = 208
    Top = 290
  end
  object qryEmployee: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'EmployeeID,'
      'CONCAT_WS('#39' '#39', FirstName, LastName) As EmployeeName,'
      'OverheadRate'
      'FROM tblEmployees'
      'WHERE Active = '#39'T'#39
      'ORDER BY EmployeeName')
    Left = 208
    Top = 320
    object qryEmployeeEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryEmployeeEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 81
    end
    object qryEmployeeOverheadRate: TFloatField
      FieldName = 'OverheadRate'
    end
  end
  object qryClasses: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName, tblClass.Active'
      'FROM tblClass '
      
        'WHERE (((tblClass.ClassName) Is Not Null) And ((tblClass.Active)' +
        '<>'#39'F'#39')) '
      'ORDER BY tblClass.ClassName; ')
    Left = 176
    Top = 320
  end
  object dsClasses: TDataSource
    DataSet = qryClasses
    Left = 176
    Top = 290
  end
  object DSServices: TDataSource
    Left = 272
    Top = 290
  end
  object qryServices: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'ID, ServiceName, EmployeeID, Rate, PartID, PartName'
      'FROM tblpaysemployeeservices'
      'WHERE (EmployeeID = :xEmpID)'
      'ORDER BY ServiceName')
    Left = 272
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xEmpID'
      end>
    object qryServicesServiceName: TWideStringField
      DisplayWidth = 30
      FieldName = 'ServiceName'
      Size = 255
    end
    object qryServicesID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
      Visible = False
    end
    object qryServicesEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Visible = False
    end
    object qryServicesRate: TFloatField
      FieldName = 'Rate'
      Visible = False
    end
    object qryServicesPartID: TIntegerField
      FieldName = 'PartID'
      Visible = False
    end
    object qryServicesPartName: TWideStringField
      FieldName = 'PartName'
      Visible = False
      Size = 255
    end
  end
  object qryPayRates: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'RateID, Description, Multiplier'
      'FROM tblpayrates'
      
        'WHERE (Active = "T" AND IsLeave = "F" AND Description NOT LIKE "' +
        '%Leave%" AND Description NOT LIKE "Termination%")'
      'ORDER BY Description;')
    Left = 336
    Top = 320
  end
  object qryJobs: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClientID, Company, JobNumber, DefaultClass'
      'FROM tblclients'
      
        'WHERE Active = '#39'T'#39' AND Customer='#39'T'#39' AND (Company NOT LIKE '#39'Table' +
        '%'#39')'
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and ((Company LIKE Concat(:SearchValue,"%"' +
        ')) or (JobNumber LIKE Concat(:SearchValue,"%")) ))'
      
        'or ((:SearchMode = 2) and ((Company LIKE Concat("%",:SearchValue' +
        ',"%")) or (JobNumber LIKE Concat("%",:SearchValue,"%")) )))'
      'and IfNull(:SearchValue,"") <> ""'
      'order by Company')
    AfterOpen = qryJobsAfterOpen
    Left = 240
    Top = 320
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
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
  end
  object imgPopup: TImageList
    Left = 166
    Top = 8
    Bitmap = {
      494C010102009400BC0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryMaster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tbltimesheetentry')
    Left = 88
    Top = 320
    object qryMasterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMasterTimesheetEntryID: TIntegerField
      FieldName = 'TimesheetEntryID'
    end
    object qryMasterEntryDate: TDateTimeField
      FieldName = 'EntryDate'
    end
    object qryMasterType: TWideStringField
      FieldName = 'Type'
      Size = 64
    end
    object qryMasterTypeID: TIntegerField
      FieldName = 'TypeID'
    end
    object qryMasterWhoEntered: TWideStringField
      FieldName = 'WhoEntered'
      Size = 64
    end
    object qryMastermsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
  end
  object DSMaster: TDataSource
    DataSet = qryMaster
    Left = 112
    Top = 290
  end
  object qryrepairequip: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '`RE`.`CustomerEquipmentID`,'
      '`E`.`EquipmentName`,'
      '`RE`.`RepairID`,'
      'R.RepairDocNo as RepairNo,'
      '`CE`.`Serialno`,'
      '`CE`.`Manufacture`,'
      '`CE`.`model`,'
      '`CE`.`Registration`,'
      '`CE`.`WarantyPeriod`,'
      '`CE`.`WarantyFinishDate`,'
      '`CE`.`Quantity`,'
      '`CE`.`ClientID`'
      'FROM'
      '`tblEquipmentxRef` AS `RE`'
      
        'Inner Join `tblcustomerequip` AS `CE` ON `RE`.`CustomerEquipment' +
        'ID` = `CE`.`id`'
      
        'Inner Join `tblequipment` AS `E` ON `CE`.`EquipmentID` = `E`.`Eq' +
        'uipmentID`'
      'Left Join tblRepairs as R on RE.RepairID = R.RepairID'
      
        'Where (RE.RepairID= :RepairID or :RepairID = 0) and (CE.ClientID' +
        ' = :ClientID or :ClientID = 0)')
    Left = 304
    Top = 320
    ParamData = <
      item
        DataType = ftInteger
        Name = 'RepairID'
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'RepairID'
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'ClientID'
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'ClientID'
        Value = 0
      end>
    object qryrepairequipEquipmentName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldName = 'EquipmentName'
      Size = 50
    end
    object qryrepairequipRepairNo: TWideStringField
      DisplayLabel = 'Repair #'
      DisplayWidth = 15
      FieldName = 'RepairNo'
      Size = 50
    end
    object qryrepairequipSerialno: TWideStringField
      DisplayLabel = 'Serial#'
      DisplayWidth = 1
      FieldName = 'Serialno'
      Size = 100
    end
    object qryrepairequipQuantity: TFloatField
      DisplayWidth = 1
      FieldName = 'Quantity'
    end
    object qryrepairequipManufacture: TWideStringField
      DisplayWidth = 1
      FieldName = 'Manufacture'
      Size = 100
    end
    object qryrepairequipmodel: TWideStringField
      DisplayLabel = 'Model'
      DisplayWidth = 1
      FieldName = 'model'
      Size = 100
    end
    object qryrepairequipRegistration: TWideStringField
      DisplayWidth = 1
      FieldName = 'Registration'
      Size = 100
    end
    object qryrepairequipWarantyFinishDate: TDateTimeField
      DisplayLabel = 'Warranty Finish'
      DisplayWidth = 1
      FieldName = 'WarantyFinishDate'
    end
    object qryrepairequipWarantyPeriod: TFloatField
      DisplayLabel = 'Warranty Period'
      DisplayWidth = 1
      FieldName = 'WarantyPeriod'
    end
    object qryrepairequipRepairID: TIntegerField
      DisplayLabel = 'Repair#'
      DisplayWidth = 10
      FieldName = 'RepairID'
      Visible = False
    end
    object qryrepairequipCustomerEquipmentID: TIntegerField
      FieldName = 'CustomerEquipmentID'
      Visible = False
    end
    object qryrepairequipClientID: TIntegerField
      FieldName = 'ClientID'
      Visible = False
    end
  end
  object qryRepairLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select RepairID, RepairDocNo, CustomerName from tblRepairs')
    Left = 360
    Top = 320
    object qryRepairLookupRepairDocNo: TWideStringField
      DisplayLabel = 'Repair #'
      DisplayWidth = 20
      FieldName = 'RepairDocNo'
      Origin = 'tblrepairs.RepairDocNo'
      Size = 50
    end
    object qryRepairLookupCustomerName: TWideStringField
      DisplayLabel = 'Customer Name'
      DisplayWidth = 30
      FieldName = 'CustomerName'
      Origin = 'tblrepairs.CustomerName'
      Size = 255
    end
    object qryRepairLookupRepairID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'RepairID'
      Origin = 'tblrepairs.RepairID'
      Visible = False
    end
  end
  object QryAreaCodes: TERPQuery
    SQL.Strings = (
      
        'Select AreaCode, AreaName from tblAreaCodes where active ="T" or' +
        'der by Areacode')
    Left = 392
    Top = 318
    object QryAreaCodesAreaCode: TWideStringField
      DisplayLabel = 'Code'
      DisplayWidth = 10
      FieldName = 'AreaCode'
      Size = 50
    end
    object QryAreaCodesAreaName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldName = 'AreaName'
      Size = 100
    end
  end
end
