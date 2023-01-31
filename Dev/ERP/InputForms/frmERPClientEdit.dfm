inherited fmERPClientEdit: TfmERPClientEdit
  HelpContext = 1119002
  Caption = 'ERP Customer'
  ClientHeight = 568
  ClientWidth = 920
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 926
  ExplicitHeight = 597
  DesignSize = (
    920
    568)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 568
    Width = 920
    HelpContext = 1119003
    ExplicitTop = 607
    ExplicitWidth = 645
  end
  inherited shapehint: TShape
    Left = 9
    ExplicitLeft = 2
  end
  inherited imgGridWatermark: TImage
    Top = 225
    ExplicitTop = 225
  end
  inherited shapehintextra1: TShape
    Left = 51
    ExplicitLeft = 31
  end
  object btnSave: TDNMSpeedButton [5]
    Left = 262
    Top = 534
    Width = 87
    Height = 27
    HelpContext = 1119022
    Anchors = [akBottom]
    Caption = 'OK'
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
    TabOrder = 1
    AutoDisableParentOnclick = True
    OnClick = btnSaveClick
  end
  object btnCancel: TDNMSpeedButton [6]
    Left = 571
    Top = 534
    Width = 87
    Height = 27
    HelpContext = 1119023
    Anchors = [akBottom]
    Caption = 'Cancel'
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
    TabOrder = 2
    AutoDisableParentOnclick = True
    OnClick = btnCancelClick
  end
  object chkActive: TwwCheckBox [7]
    Left = 843
    Top = 15
    Width = 65
    Height = 18
    HelpContext = 1119026
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'T'
    DisplayValueUnchecked = 'F'
    NullAndBlankState = cbUnchecked
    Anchors = [akTop, akRight]
    Caption = 'Active'
    DataField = 'active'
    DataSource = dsClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object pnlTitle: TDNMPanel [8]
    Left = 306
    Top = 4
    Width = 311
    Height = 36
    HelpContext = 1119019
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
      Width = 307
      Height = 32
      HelpContext = 1119020
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
        Width = 307
        Height = 32
        HelpContext = 1119021
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Customer'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 234
      end
    end
  end
  object cmdNew: TDNMSpeedButton [9]
    Left = 416
    Top = 534
    Width = 87
    Height = 27
    HelpContext = 1119060
    Anchors = [akBottom]
    Caption = 'Make Invoice'
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
    AutoDisableParentOnclick = True
    OnClick = cmdNewClick
  end
  object pcMain: TPageControl [10]
    Left = 8
    Top = 44
    Width = 904
    Height = 484
    HelpContext = 1119061
    ActivePage = tabMain
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 5
    object tabMain: TTabSheet
      HelpContext = 1119062
      Caption = 'Main'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label5: TLabel
        Left = 656
        Top = 6
        Width = 46
        Height = 15
        HelpContext = 1119005
        Caption = 'Release'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 11
        Top = 6
        Width = 32
        Height = 15
        HelpContext = 1119004
        Caption = 'Client'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label19: TLabel
        Left = 364
        Top = 6
        Width = 52
        Height = 15
        HelpContext = 1119018
        Caption = 'ERP Cust'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 11
        Top = 35
        Width = 56
        Height = 15
        HelpContext = 1119006
        Caption = 'Computer'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblComputerCount: TLabel
        Left = 413
        Top = 35
        Width = 102
        Height = 15
        HelpContext = 1119015
        Caption = 'lblComputerCount'
      end
      object Label3: TLabel
        Left = 11
        Top = 82
        Width = 45
        Height = 15
        HelpContext = 1119007
        Caption = 'License'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblLicenceCount: TLabel
        Left = 413
        Top = 80
        Width = 91
        Height = 15
        HelpContext = 1119016
        Caption = 'lblLicenceCount'
      end
      object Label4: TLabel
        Left = 11
        Top = 109
        Width = 37
        Height = 15
        HelpContext = 1119008
        Caption = 'Status'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 236
        Top = 110
        Width = 43
        Height = 15
        HelpContext = 1119009
        Caption = 'Reason'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 10
        Top = 139
        Width = 57
        Height = 15
        HelpContext = 1119010
        Caption = 'Start Date'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 213
        Top = 139
        Width = 65
        Height = 15
        HelpContext = 1119011
        Caption = 'Expire Date'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 423
        Top = 139
        Width = 34
        Height = 15
        HelpContext = 1119012
        Caption = 'Users'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 535
        Top = 37
        Width = 33
        Height = 15
        HelpContext = 1119013
        Caption = 'Notes'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label20: TLabel
        Left = 11
        Top = 168
        Width = 44
        Height = 15
        HelpContext = 1119063
        Caption = 'Options'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cboReleaseType: TwwDBComboBox
        Left = 708
        Top = 3
        Width = 181
        Height = 23
        HelpContext = 1119025
        ShowButton = True
        Style = csDropDownList
        MapList = True
        AllowClearKey = False
        DataField = 'softwarereleasetype'
        DataSource = dsClient
        DropDownCount = 8
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          'Production'#9'Production'
          'Production10'#9'Production10'
          'Production11'#9'Production11'
          'Production12'#9'Production12'
          'Production14'#9'Production14'
          'Beta'#9'Beta'
          'Alpha'#9'Alpha'
          'Dev'#9'Dev'
          'Test'#9'Test'
          'Sandbox'#9'Sandbox')
        ParentFont = False
        Sorted = False
        TabOrder = 0
        UnboundDataType = wwDefault
      end
      object edtName: TDBEdit
        Left = 73
        Top = 3
        Width = 265
        Height = 23
        HelpContext = 1119024
        DataField = 'name'
        DataSource = dsClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object cboErpCust: TwwDBLookupCombo
        Left = 430
        Top = 3
        Width = 220
        Height = 23
        HelpContext = 1119059
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        DataField = 'erpclientname'
        DataSource = dsClient
        LookupTable = qryERPCustLookup
        LookupField = 'company'
        Style = csDropDownList
        DropDownWidth = 50
        ParentFont = False
        TabOrder = 2
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = True
        OnCloseUp = cboErpCustCloseUp
      end
      object edtComputer: TDBEdit
        Left = 73
        Top = 32
        Width = 265
        Height = 23
        HelpContext = 1119054
        DataField = 'computername'
        DataSource = dsServers
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
      object DBNavigator1: TDBNavigator
        Left = 349
        Top = 32
        Width = 48
        Height = 25
        HelpContext = 1119055
        DataSource = dsServers
        VisibleButtons = [nbPrior, nbNext]
        TabOrder = 4
      end
      object edtLicence: TDBEdit
        Left = 73
        Top = 78
        Width = 265
        Height = 23
        HelpContext = 1119056
        DataField = 'softwarename'
        DataSource = dsLicence
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
      end
      object DBNavigator2: TDBNavigator
        Left = 349
        Top = 75
        Width = 48
        Height = 25
        HelpContext = 1119057
        DataSource = dsLicence
        VisibleButtons = [nbPrior, nbNext]
        TabOrder = 6
      end
      object cboLicence: TDBComboBox
        Left = 73
        Top = 107
        Width = 149
        Height = 23
        HelpContext = 1119030
        Style = csDropDownList
        DataField = 'status'
        DataSource = dsLicence
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Items.Strings = (
          'lsUnknown'
          'lsPending'
          'lsLicenced'
          'lsHold'
          'lsCancelled'
          'lsReview'
          'lsExpired')
        ParentFont = False
        TabOrder = 7
      end
      object edtStatusReason: TDBEdit
        Left = 293
        Top = 107
        Width = 222
        Height = 23
        HelpContext = 1119031
        DataField = 'statusreason'
        DataSource = dsLicence
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object dtpStartDate: TwwDBDateTimePicker
        Left = 73
        Top = 136
        Width = 103
        Height = 23
        HelpContext = 1119032
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'startdate'
        DataSource = dsLicence
        Epoch = 1950
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 9
      end
      object dtpExpireDate: TwwDBDateTimePicker
        Left = 294
        Top = 136
        Width = 102
        Height = 23
        HelpContext = 1119033
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'expiredate'
        DataSource = dsLicence
        Epoch = 1950
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 10
      end
      object edtUsers: TwwDBEdit
        Left = 463
        Top = 136
        Width = 47
        Height = 23
        HelpContext = 1119034
        DataField = 'concurrentusers'
        DataSource = dsLicence
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object grdOptions: TAdvStringGrid
        Left = 73
        Top = 168
        Width = 456
        Height = 283
        Cursor = crDefault
        HelpContext = 1119064
        DrawingStyle = gdsClassic
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 12
        OnCanEditCell = grdOptionsCanEditCell
        OnCellValidate = grdOptionsCellValidate
        OnGetEditorType = grdOptionsGetEditorType
        OnCheckBoxClick = grdOptionsCheckBoxClick
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'Tahoma'
        ActiveCellFont.Style = [fsBold]
        ColumnHeaders.Strings = (
          'Name'
          'Option'
          'Enabled'
          'Category'
          'User')
        ControlLook.FixedGradientHoverFrom = clGray
        ControlLook.FixedGradientHoverTo = clWhite
        ControlLook.FixedGradientDownFrom = clGray
        ControlLook.FixedGradientDownTo = clSilver
        ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownHeader.Font.Color = clWindowText
        ControlLook.DropDownHeader.Font.Height = -11
        ControlLook.DropDownHeader.Font.Name = 'Tahoma'
        ControlLook.DropDownHeader.Font.Style = []
        ControlLook.DropDownHeader.Visible = True
        ControlLook.DropDownHeader.Buttons = <>
        ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownFooter.Font.Color = clWindowText
        ControlLook.DropDownFooter.Font.Height = -11
        ControlLook.DropDownFooter.Font.Name = 'Tahoma'
        ControlLook.DropDownFooter.Font.Style = []
        ControlLook.DropDownFooter.Visible = True
        ControlLook.DropDownFooter.Buttons = <>
        Filter = <>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'Tahoma'
        FilterDropDown.Font.Style = []
        FilterDropDownClear = '(All)'
        FixedRowHeight = 22
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -11
        FixedFont.Name = 'Tahoma'
        FixedFont.Style = [fsBold]
        FloatFormat = '%.2f'
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'Tahoma'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'Tahoma'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'Tahoma'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'Tahoma'
        PrintSettings.FooterFont.Style = []
        PrintSettings.PageNumSep = '/'
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'Tahoma'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurence'
        SearchFooter.HintFindPrev = 'Find previous occurence'
        SearchFooter.HintHighlight = 'Highlight occurences'
        SearchFooter.MatchCaseCaption = 'Match case'
        ShowDesignHelper = False
        Version = '5.6.0.1'
        WordWrap = False
      end
      object memNotes: TDBMemo
        Left = 535
        Top = 58
        Width = 354
        Height = 101
        HelpContext = 1119035
        DataField = 'notes'
        DataSource = dsLicence
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
      end
      object grdCloudOptions: TAdvStringGrid
        Left = 488
        Top = 168
        Width = 401
        Height = 283
        Cursor = crDefault
        HelpContext = 1119065
        ColCount = 4
        DrawingStyle = gdsClassic
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 14
        Visible = False
        OnCanEditCell = grdOptionsCanEditCell
        OnCellValidate = grdOptionsCellValidate
        OnGetEditorType = grdOptionsGetEditorType
        OnCheckBoxClick = grdOptionsCheckBoxClick
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'Tahoma'
        ActiveCellFont.Style = [fsBold]
        ColumnHeaders.Strings = (
          'Name'
          'Option'
          'Enabled'
          'Category')
        ControlLook.FixedGradientHoverFrom = clGray
        ControlLook.FixedGradientHoverTo = clWhite
        ControlLook.FixedGradientDownFrom = clGray
        ControlLook.FixedGradientDownTo = clSilver
        ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownHeader.Font.Color = clWindowText
        ControlLook.DropDownHeader.Font.Height = -11
        ControlLook.DropDownHeader.Font.Name = 'Tahoma'
        ControlLook.DropDownHeader.Font.Style = []
        ControlLook.DropDownHeader.Visible = True
        ControlLook.DropDownHeader.Buttons = <>
        ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownFooter.Font.Color = clWindowText
        ControlLook.DropDownFooter.Font.Height = -11
        ControlLook.DropDownFooter.Font.Name = 'Tahoma'
        ControlLook.DropDownFooter.Font.Style = []
        ControlLook.DropDownFooter.Visible = True
        ControlLook.DropDownFooter.Buttons = <>
        Filter = <>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'Tahoma'
        FilterDropDown.Font.Style = []
        FilterDropDownClear = '(All)'
        FixedRowHeight = 22
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -11
        FixedFont.Name = 'Tahoma'
        FixedFont.Style = [fsBold]
        FloatFormat = '%.2f'
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'Tahoma'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'Tahoma'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'Tahoma'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'Tahoma'
        PrintSettings.FooterFont.Style = []
        PrintSettings.PageNumSep = '/'
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'Tahoma'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurence'
        SearchFooter.HintFindPrev = 'Find previous occurence'
        SearchFooter.HintHighlight = 'Highlight occurences'
        SearchFooter.MatchCaseCaption = 'Match case'
        Version = '5.6.0.1'
      end
    end
    object tabDetail: TTabSheet
      HelpContext = 1119066
      Caption = 'Detail'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        896
        454)
      object Label12: TLabel
        Left = 5
        Top = 301
        Width = 36
        Height = 15
        HelpContext = 1119017
        Caption = 'Config'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel
        Left = 402
        Top = 12
        Width = 26
        Height = 15
        HelpContext = 1119014
        Caption = 'Data'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnSeletConfigAll: TDNMSpeedButton
        Left = 64
        Top = 298
        Width = 87
        Height = 18
        HelpContext = 1119058
        Caption = 'Select All'
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
        TabOrder = 0
        AutoDisableParentOnclick = True
        OnClick = btnSeletConfigAllClick
      end
      object grdConfig: TwwDBGrid
        Left = 3
        Top = 322
        Width = 885
        Height = 119
        HelpContext = 1119027
        ControlType.Strings = (
          'active;CheckBox;T;F'
          'notes;CustomEdit;edtConfigNotes;F')
        Selected.Strings = (
          'id'#9'10'#9'Id'#9'F'
          'active'#9'1'#9'Active'#9'F'
          'text'#9'10'#9'Config'#9'F'
          'notes'#9'60'#9'Notes'#9'F'
          'datetime'#9'18'#9'Date Time'#9'F'
          'user'#9'10'#9'User'#9'F')
        MemoAttributes = [mSizeable, mWordWrap, mGridShow]
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        Anchors = [akLeft, akTop, akBottom]
        DataSource = dsConfig
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
        ParentFont = False
        TabOrder = 1
        TitleAlignment = taLeftJustify
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
        UseTFields = False
        object grdConfigIButton: TwwIButton
          Left = 0
          Top = 0
          Width = 25
          Height = 25
          HelpContext = 1119028
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
          OnClick = grdConfigIButtonClick
        end
      end
      object grpSMS: TGroupBox
        Left = 3
        Top = 10
        Width = 370
        Height = 178
        HelpContext = 1119037
        Caption = 'SMS'
        TabOrder = 2
        DesignSize = (
          370
          178)
        object Label13: TLabel
          Left = 89
          Top = 64
          Width = 45
          Height = 15
          HelpContext = 1119038
          Caption = 'Number'
        end
        object edtSMSUser: TLabel
          Left = 9
          Top = 93
          Width = 27
          Height = 15
          HelpContext = 1119039
          Caption = 'User'
        end
        object Label14: TLabel
          Left = 9
          Top = 122
          Width = 29
          Height = 15
          HelpContext = 1119040
          Caption = 'Pass'
        end
        object Label15: TLabel
          Left = 12
          Top = 24
          Width = 16
          Height = 15
          HelpContext = 1119041
          Caption = 'DB'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label16: TLabel
          Left = 9
          Top = 152
          Width = 39
          Height = 15
          HelpContext = 1119042
          Caption = 'Margin'
        end
        object Label17: TLabel
          Left = 125
          Top = 152
          Width = 43
          Height = 15
          HelpContext = 1119043
          Caption = 'Min Out'
        end
        object Label18: TLabel
          Left = 245
          Top = 152
          Width = 33
          Height = 15
          HelpContext = 1119044
          Caption = 'Min In'
        end
        object chkSMSEnabled: TCheckBox
          Left = 9
          Top = 64
          Width = 74
          Height = 17
          HelpContext = 1119045
          Caption = 'Enabled'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = chkSMSEnabledClick
        end
        object edtSMSNumber: TEdit
          Left = 141
          Top = 60
          Width = 147
          Height = 23
          HelpContext = 1119046
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnChange = edtSMSNumberChange
        end
        object edtSMSName: TEdit
          Left = 44
          Top = 89
          Width = 245
          Height = 23
          HelpContext = 1119047
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = edtSMSNameChange
        end
        object edtSMSPass: TEdit
          Left = 44
          Top = 118
          Width = 244
          Height = 23
          HelpContext = 1119048
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnChange = edtSMSPassChange
        end
        object cboDbLIst: TComboBox
          Left = 56
          Top = 21
          Width = 233
          Height = 23
          HelpContext = 1119049
          Style = csDropDownList
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnChange = cboDbLIstChange
        end
        object btnSetToDefault: TDNMSpeedButton
          Left = 297
          Top = 89
          Width = 66
          Height = 51
          HelpContext = 1119050
          Anchors = [akBottom]
          Caption = 'Set to Default'
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
          TabOrder = 5
          WordWrap = True
          AutoDisableParentOnclick = True
          OnClick = btnSetToDefaultClick
        end
        object edtMargin: TAdvEdit
          Left = 56
          Top = 149
          Width = 49
          Height = 23
          HelpContext = 1119051
          EditType = etFloat
          Precision = 2
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          Lookup.Separator = ';'
          Color = clWindow
          Enabled = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          Text = '0.00'
          Visible = True
          OnChange = edtMarginChange
          Version = '2.8.6.9'
        end
        object edtMinOut: TAdvEdit
          Left = 174
          Top = 149
          Width = 49
          Height = 23
          HelpContext = 1119052
          EditType = etFloat
          Precision = 2
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          Lookup.Separator = ';'
          Color = clWindow
          Enabled = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          Text = '0.00'
          Visible = True
          OnChange = edtMinOutChange
          Version = '2.8.6.9'
        end
        object edtMinIn: TAdvEdit
          Left = 291
          Top = 149
          Width = 49
          Height = 23
          HelpContext = 1119053
          EditType = etFloat
          Precision = 2
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          Lookup.Separator = ';'
          Color = clWindow
          Enabled = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          Text = '0.00'
          Visible = True
          OnChange = edtMinInChange
          Version = '2.8.6.9'
        end
      end
      object DBMemo1: TDBMemo
        Left = 541
        Top = 3
        Width = 150
        Height = 14
        HelpContext = 1119036
        DataField = 'datatext'
        DataSource = dsLicence
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 3
        Visible = False
      end
      object memDataText: TMemo
        Left = 398
        Top = 31
        Width = 490
        Height = 274
        HelpContext = 1119067
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 4
        WordWrap = False
      end
      object edtConfigNotes: TwwDBEdit
        Left = 220
        Top = 348
        Width = 139
        Height = 23
        HelpContext = 1119029
        ShowVertScrollBar = True
        TabOrder = 5
        UnboundDataType = wwDefault
        WantReturns = True
        WordWrap = True
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 684
    Top = 8
  end
  inherited tmrdelay: TTimer
    Left = 704
    Top = 8
  end
  inherited popSpelling: TPopupMenu
    Left = 48
    Top = 0
  end
  inherited tmrdelayMsg: TTimer
    Left = 200
    Top = 65528
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 145
    Top = 8
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 173
    Top = 8
  end
  inherited MyConnection: TERPConnection
    Database = 'services'
    Connected = True
    Left = 122
    Top = 65535
  end
  inherited DataState: TDataState
    Left = 432
    Top = 38
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 83
    Top = 0
  end
  inherited imgsort: TImageList
    Left = 347
    Top = 8
    Bitmap = {
      494C010102006800240110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 65514
    Top = 0
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 822
    Top = 310
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 640
    Top = 65528
  end
  inherited qryMemTrans: TERPQuery
    Left = 13
    Top = 0
  end
  inherited tmrOnshow: TTimer
    Left = 752
    Top = 342
  end
  object qryClient: TMyQuery
    SQL.Strings = (
      'select * from tclientconfig where id = :ClientID')
    BeforePost = qryClientBeforePost
    Left = 360
    Top = 352
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ClientID'
      end>
  end
  object dsClient: TDataSource
    DataSet = qryClient
    Left = 312
    Top = 65520
  end
  object qryServers: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tcomputer where clientid = :ClientID order by id')
    BeforePost = qryServersBeforePost
    AfterScroll = qryServersAfterScroll
    Left = 360
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ClientID'
      end>
  end
  object dsServers: TDataSource
    DataSet = qryServers
    Left = 528
    Top = 65528
  end
  object qryLicence: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select * from tsoftwarelicence where computerid = :ComputerID or' +
        'der by active, id')
    BeforePost = qryLicenceBeforePost
    BeforeScroll = qryLicenceBeforeScroll
    AfterScroll = qryLicenceAfterScroll
    Left = 352
    Top = 416
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ComputerID'
      end>
    object qryLicenceid: TIntegerField
      FieldName = 'id'
    end
    object qryLicenceclientid: TIntegerField
      FieldName = 'clientid'
    end
    object qryLicencecomputerid: TIntegerField
      FieldName = 'computerid'
    end
    object qryLicenceactive: TWideStringField
      FieldName = 'active'
      FixedChar = True
      Size = 1
    end
    object qryLicencesoftwarename: TWideStringField
      FieldName = 'softwarename'
      Size = 255
    end
    object qryLicencestartdate: TDateTimeField
      FieldName = 'startdate'
    end
    object qryLicenceexpiredate: TDateTimeField
      FieldName = 'expiredate'
    end
    object qryLicenceconcurrentusers: TIntegerField
      FieldName = 'concurrentusers'
    end
    object qryLicencestatus: TWideStringField
      FieldName = 'status'
      Size = 255
    end
    object qryLicencestatusreason: TWideStringField
      FieldName = 'statusreason'
      Size = 255
    end
    object qryLicencedatatext: TWideMemoField
      FieldName = 'datatext'
      BlobType = ftWideMemo
    end
    object qryLicencenotes: TWideMemoField
      FieldName = 'notes'
      BlobType = ftWideMemo
    end
    object qryLicencedatetime: TDateTimeField
      FieldName = 'datetime'
    end
    object qryLicenceuser: TWideStringField
      FieldName = 'user'
      Size = 255
    end
  end
  object dsLicence: TDataSource
    DataSet = qryLicence
    Left = 432
    Top = 304
  end
  object qryConfig: TMyQuery
    SQL.Strings = (
      
        'select * from tcomputerconfig where computerid = :ComputerID ord' +
        'er by id')
    BeforePost = qryConfigBeforePost
    Left = 360
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ComputerID'
      end>
  end
  object dsConfig: TDataSource
    DataSet = qryConfig
    Left = 432
    Top = 248
  end
  object qryERPCustLookup: TERPQuery
    SQL.Strings = (
      'select company from tblclients where Customer ="T"'
      'order by company')
    BeforeOpen = qryERPCustLookupBeforeOpen
    Left = 792
    Top = 254
  end
end
