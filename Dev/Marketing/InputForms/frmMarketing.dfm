inherited fmMarketing: TfmMarketing
  Left = 479
  Top = 124
  HelpContext = 172000
  Caption = 'Telemarketing'
  ClientHeight = 563
  ClientWidth = 956
  DragMode = dmAutomatic
  OldCreateOrder = True
  OnResize = FormResize
  ExplicitWidth = 962
  ExplicitHeight = 592
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 525
    Width = 956
    HelpContext = 172031
    ExplicitTop = 525
    ExplicitWidth = 956
  end
  inherited imgGridWatermark: TImage
    HelpContext = 172001
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 0
    Top = 47
    Width = 956
    Height = 478
    HelpContext = 172002
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 1
    Transparent = False
    object pnlContactDetails: TDNMPanel
      Left = 0
      Top = 0
      Width = 956
      Height = 137
      HelpContext = 172033
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      Transparent = False
      DesignSize = (
        956
        137)
      object lblListSelection: TLabel
        Left = 20
        Top = 9
        Width = 82
        Height = 15
        HelpContext = 172006
        Alignment = taRightJustify
        Caption = 'Contacts Lists'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label2: TLabel
        Left = 448
        Top = 9
        Width = 185
        Height = 15
        HelpContext = 172010
        Caption = 'Disregard all that have followups'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label1: TLabel
        Left = 658
        Top = 9
        Width = 101
        Height = 15
        HelpContext = 172007
        Caption = 'Records Found : 0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label3: TLabel
        Left = 807
        Top = 9
        Width = 103
        Height = 15
        HelpContext = 172008
        Caption = 'Current Record : 0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label4: TLabel
        Left = 6
        Top = 35
        Width = 108
        Height = 18
        HelpContext = 172009
        Caption = 'Contact Details'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object cboRangeSelection: TwwDBLookupCombo
        Left = 109
        Top = 6
        Width = 300
        Height = 23
        HelpContext = 172017
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'RangeDescription'#9'40'#9'Description'#9'F')
        LookupTable = qryContactSelectionList
        LookupField = 'RangeDescription'
        ParentFont = False
        TabOrder = 0
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnCloseUp = cboRangeSelectionCloseUp
      end
      object chkDisregard: TCheckBox
        Left = 432
        Top = 9
        Width = 12
        Height = 17
        HelpContext = 172015
        TabOrder = 1
        OnClick = chkDisregardClick
      end
      object grdContacts: TwwDBGrid
        Left = 6
        Top = 53
        Width = 944
        Height = 79
        HelpContext = 172014
        TabStop = False
        ControlType.Strings = (
          'DoNotQualify;CheckBox;T;F')
        Selected.Strings = (
          'CompanyTypeName'#9'15'#9'Company Type'#9#9
          'Title'#9'1'#9'Title'#9#9
          'COMPANY'#9'15'#9'Company'#9#9
          'Phone'#9'12'#9'Phone'#9#9
          'AltPhone'#9'12'#9'Alt Phone'#9'F'#9
          'Mobile'#9'12'#9'Mobile'#9'F'
          'FirstName'#9'12'#9'First Name'#9#9
          'MiddleName'#9'11'#9'Middle Name'#9'F'#9
          'LastName'#9'12'#9'Last Name'#9#9
          'EmployeeSize'#9'1'#9'Employee Size'#9#9
          'DateOfBirth'#9'12'#9'Date Of Birth'#9#9
          'Duration'#9'1'#9'Duration'#9#9
          'DoNotQualify'#9'1'#9'DoNotQualify'#9#9)
        MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
        IniAttributes.Delimiter = ';;'
        TitleColor = 14155775
        FixedCols = 0
        ShowHorzScrollBar = True
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dsMarketingcontacts
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        TitleAlignment = taLeftJustify
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = True
        OnDblClick = grdContactsDblClick
        FooterColor = 14155775
      end
    end
    object pnlActionAndNotes: TDNMPanel
      Left = 0
      Top = 137
      Width = 956
      Height = 341
      HelpContext = 172034
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 1
      Transparent = False
      object pnlAction: TDNMPanel
        Left = 0
        Top = 0
        Width = 956
        Height = 252
        HelpContext = 172035
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        Transparent = False
        DesignSize = (
          956
          252)
        object lblFollowUpType: TLabel
          Left = 18
          Top = 7
          Width = 177
          Height = 18
          HelpContext = 172005
          Caption = 'Action / Follow up Details'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object grdFollowups: TwwDBGrid
          Left = 18
          Top = 27
          Width = 919
          Height = 218
          HelpContext = 172012
          TabStop = False
          ControlType.Strings = (
            'TypeId;CustomEdit;cboFollowUpType;F'
            'EmployeeID;CustomEdit;cboEmployee;F'
            'Done;CheckBox;T;F'
            'ResultTypeId;CustomEdit;cboFollowUpResult;F'
            'EmployeeName;CustomEdit;cboEmployee;F'
            'ResultTypeName;CustomEdit;cboActionType;F'
            'TypeName;CustomEdit;cboFollowUpType;F'
            'ActiontypeName;CustomEdit;cboActionType;F'
            'ActionDate;CustomEdit;edtActionDate;F')
          Selected.Strings = (
            'ActiontypeName'#9'15'#9'Action Type'#9#9
            'ActionDate'#9'12'#9'Action Date'#9#9
            'EmployeeName'#9'15'#9'Employee'#9#9
            'Notes'#9'75'#9'Notes'#9'F'#9
            'Done'#9'4'#9'Done'#9#9)
          MemoAttributes = [mSizeable, mWordWrap, mGridShow]
          IniAttributes.Delimiter = ';;'
          TitleColor = 14155775
          OnRowChanged = grdFollowupsRowChanged
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = dsLeadLines
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = [dgEnterToTab, dgAllowInsert]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = True
          OnCalcCellColors = grdFollowupsCalcCellColors
          OnColEnter = grdFollowupsColEnter
          FooterColor = 14155775
          FooterCellColor = clWhite
          PaintOptions.BackgroundOptions = [coBlendFixedRow]
          object grdFollowupsIButton: TwwIButton
            Left = 0
            Top = 0
            Width = 24
            Height = 19
            HelpContext = 172036
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
            OnClick = grdFollowupsIButtonClick
          end
        end
        object cboActionType: TwwDBLookupCombo
          Left = 109
          Top = 66
          Width = 121
          Height = 23
          HelpContext = 172037
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Name'#9'30'#9'Name'#9'F')
          DataField = 'ActiontypeName'
          DataSource = dsLeadLines
          LookupTable = qryActionType
          LookupField = 'Id'
          DropDownCount = 11
          TabOrder = 1
          Visible = False
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnDblClick = cboActionTypeDblClick
          OnCloseUp = cboActionTypeCloseUp
          OnNotInList = cboActionTypeNotInList
        end
        object edtActionDate: TwwDBDateTimePicker
          Left = 424
          Top = 66
          Width = 121
          Height = 23
          HelpContext = 172038
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          CalendarAttributes.PopupYearOptions.NumberColumns = 4
          DataField = 'ActionDate'
          DataSource = dsLeadLines
          Date = 39682.000000000000000000
          Epoch = 1950
          ShowButton = True
          TabOrder = 2
        end
        object cboEmployee: TwwDBLookupCombo
          Left = 253
          Top = 66
          Width = 165
          Height = 23
          HelpContext = 172039
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'EmployeeName'#9'40'#9'Employee Name'#9'F')
          DataField = 'EmployeeName'
          DataSource = dsLeadLines
          LookupTable = qryEmployee
          LookupField = 'EmployeeName'
          ParentFont = False
          TabOrder = 3
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = cboEmployeeCloseUp
        end
      end
      object pnlNotes: TDNMPanel
        Left = 0
        Top = 252
        Width = 956
        Height = 89
        HelpContext = 172040
        Align = alBottom
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 1
        Transparent = False
        DesignSize = (
          956
          89)
        object Label5: TLabel
          Left = 18
          Top = 2
          Width = 80
          Height = 15
          HelpContext = 172011
          Anchors = [akLeft, akTop, akBottom]
          Caption = 'Contact Notes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object DBMemo1: TDBMemo
          Left = 18
          Top = 18
          Width = 919
          Height = 63
          HelpContext = 172016
          TabStop = False
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataField = 'Notes'
          DataSource = dsMarketingcontacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
  end
  object pnlTop: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 956
    Height = 47
    HelpContext = 172027
    Align = alTop
    BevelOuter = bvNone
    UseDockManager = False
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    Transparent = False
    DesignSize = (
      956
      47)
    object pnlTitle: TDNMPanel
      Left = 340
      Top = 2
      Width = 276
      Height = 39
      HelpContext = 172028
      Anchors = [akLeft, akTop, akRight]
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
        Width = 272
        Height = 35
        HelpContext = 172029
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
          Width = 272
          Height = 35
          HelpContext = 172030
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Telemarketing'
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
  object pnlBottom: TDNMPanel [7]
    Left = 0
    Top = 525
    Width = 956
    Height = 38
    HelpContext = 172018
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 2
    Transparent = False
    DesignSize = (
      956
      38)
    object btnDial: TDNMSpeedButton
      Left = 536
      Top = 5
      Width = 88
      Height = 27
      HelpContext = 172019
      Anchors = [akBottom]
      Caption = 'Dial'
      DisableTransparent = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003B3000000000
        003B37F77777777777F73BB09111111110BB3777F3F3F3F3F777311098080808
        10B33777F7373737377313309999999910337F373F3F3F3F3733133309808089
        03337F3373737373733313333099999033337FFFF7FFFFF7FFFFB011B0000000
        BBBB7777777777777777B01110BBBBB0BBBB77F37777777777773011108BB333
        333337F337377F3FFFF33099111BB3010033373F33777F77773F331999100101
        11033373FFF77773337F33300099991999033337773FFFF33373333BB7100199
        113333377377773FF7F333BB333BB7011B33337733377F7777FF3BB3333BB333
        3BB3377333377F33377FBB33333BB33333BB7733333773333377}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      TabOrder = 6
      Visible = False
      AutoDisableParentOnclick = True
    end
    object btnOk: TDNMSpeedButton
      Left = 25
      Top = 5
      Width = 88
      Height = 27
      HelpContext = 172020
      Anchors = [akBottom]
      Caption = '&Save'
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = btnOkClick
    end
    object cmdClose: TDNMSpeedButton
      Left = 843
      Top = 5
      Width = 88
      Height = 27
      HelpContext = 172021
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      Kind = bkCancel
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 5
      AutoDisableParentOnclick = True
      OnClick = cmdCloseClick
    end
    object btnNext: TDNMSpeedButton
      Left = 229
      Top = 5
      Width = 88
      Height = 27
      HelpContext = 172022
      Anchors = [akBottom]
      Cancel = True
      Caption = 'Next'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333333333333333EEEEEEEEEEEEEEE333FFFFFFFFFFFFF3E00000000000
        00E337777777777777F3E0F77777777770E337F33333333337F3E0F333333333
        70E337F33333333337F3E0F33333333370E337F333FF3F3337F3E0F330030333
        70E337F3377F7FF337F3E0F33003003370E337F3377F77FF37F3E0F330030003
        70E337F3377F777337F3E0F33003003370E337F3377F773337F3E0F330030333
        70E337F33773733337F3E0F33333333370E337F33333333337F3E0F333333333
        70E337F33333333337F3E0FFFFFFFFFFF0E337FFFFFFFFFFF7F3E00000000000
        00E33777777777777733EEEEEEEEEEEEEEE33333333333333333}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = btnNextClick
    end
    object btnLead: TDNMSpeedButton
      Left = 434
      Top = 5
      Width = 88
      Height = 27
      HelpContext = 172023
      Anchors = [akBottom]
      Caption = 'Lea&d'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 3
      AutoDisableParentOnclick = True
      OnClick = btnLeadClick
    end
    object btnPrev: TDNMSpeedButton
      Left = 127
      Top = 5
      Width = 88
      Height = 27
      HelpContext = 172024
      Anchors = [akBottom]
      Cancel = True
      Caption = 'Prev'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333333333333333EEEEEEEEEEEEEEE333FFFFFFFFFFFFF3E00000000000
        00E337777777777777F3E0F77777777770E337F33333333337F3E0F333333333
        70E337F33333333337F3E0F33333333370E337F3333F3FF337F3E0F333030033
        70E337F3337F77F337F3E0F33003003370E337F3377F77F337F3E0F300030033
        70E337F3777F77F337F3E0F33003003370E337F3377F77F337F3E0F333030033
        70E337F33373773337F3E0F33333333370E337F33333333337F3E0F333333333
        70E337F33333333337F3E0FFFFFFFFFFF0E337FFFFFFFFFFF7F3E00000000000
        00E33777777777777733EEEEEEEEEEEEEEE33333333333333333}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = btnPrevClick
    end
    object btnScript: TDNMSpeedButton
      Left = 638
      Top = 5
      Width = 88
      Height = 27
      HelpContext = 172025
      Anchors = [akBottom]
      Caption = 'Scrip&t'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = btnScriptClick
    end
    object btnNoAnswer: TDNMSpeedButton
      Left = 740
      Top = 5
      Width = 88
      Height = 27
      HelpContext = 172026
      Anchors = [akBottom]
      Caption = '&No Answer '
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 7
      AutoDisableParentOnclick = True
      OnClick = btnNoAnswerClick
    end
    object btnEmail: TDNMSpeedButton
      Left = 331
      Top = 5
      Width = 88
      Height = 27
      HelpContext = 172032
      Anchors = [akBottom]
      Caption = '&Email'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 8
      AutoDisableParentOnclick = True
      OnClick = btnEmailClick
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 492
    Top = 328
  end
  inherited tmrdelay: TTimer
    Left = 637
    Top = 328
  end
  inherited popSpelling: TPopupMenu
    Left = 746
    Top = 328
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 565
    Top = 328
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 710
    Top = 328
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 20
    Top = 328
  end
  inherited DataState: TDataState
    Left = 601
    Top = 328
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 819
    Top = 328
  end
  inherited imgsort: TImageList
    Left = 528
    Top = 328
    Bitmap = {
      494C0101020040004C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 56
    Top = 328
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 856
    Top = 328
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 456
    Top = 328
  end
  inherited qryMemTrans: TERPQuery
    Left = 129
    Top = 328
  end
  object dsContactSelectionList: TDataSource
    Left = 419
    Top = 328
  end
  object dsLeadLines: TDataSource
    DataSet = qryLeadLines
    Left = 238
    Top = 296
  end
  object qryLeadLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblMarketingleadlines')
    AfterPost = qryLeadLinesAfterPost
    Left = 238
    Top = 328
    object qryLeadLinesActiontypeName: TWideStringField
      DisplayLabel = 'Action Type'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'ActiontypeName'
      LookupDataSet = qrySimpleTypes
      LookupKeyFields = 'Id'
      LookupResultField = 'Name'
      KeyFields = 'ActionType'
      Size = 100
      Lookup = True
    end
    object qryLeadLinesActionDate: TDateTimeField
      DisplayLabel = 'Action Date'
      DisplayWidth = 12
      FieldName = 'ActionDate'
      Origin = 'tblMarketingleadlines.ActionDate'
    end
    object qryLeadLinesEmployeeName: TWideStringField
      DisplayLabel = 'Employee'
      DisplayWidth = 15
      FieldName = 'EmployeeName'
      Origin = 'tblMarketingleadlines.EmployeeName'
      Size = 255
    end
    object qryLeadLinesNotes: TWideMemoField
      DisplayWidth = 75
      FieldName = 'Notes'
      Origin = 'tblMarketingleadlines.Notes'
      BlobType = ftWideMemo
    end
    object qryLeadLinesDone: TWideStringField
      DisplayWidth = 4
      FieldName = 'Done'
      Origin = 'tblMarketingleadlines.Done'
      FixedChar = True
      Size = 1
    end
    object qryLeadLinesCreationDate: TDateTimeField
      DisplayLabel = 'Action Date'
      DisplayWidth = 18
      FieldName = 'CreationDate'
      Origin = 'tblMarketingleadlines.CreationDate'
      Visible = False
    end
    object qryLeadLinesResultTypeName: TWideStringField
      DisplayLabel = 'Follow-Up'
      DisplayWidth = 22
      FieldName = 'ResultTypeName'
      Origin = 'tblMarketingleadlines.ResultTypeName'
      Visible = False
      Size = 255
    end
    object qryLeadLinesFollowUpDate: TDateTimeField
      DisplayLabel = 'Follow-Up / Action Date'
      DisplayWidth = 20
      FieldName = 'FollowUpDate'
      Origin = 'tblMarketingleadlines.FollowUpDate'
      Visible = False
    end
    object qryLeadLinesUpdateDate: TDateTimeField
      DisplayLabel = 'Last Updated'
      DisplayWidth = 17
      FieldName = 'UpdateDate'
      Origin = 'tblMarketingleadlines.UpdateDate'
      Visible = False
    end
    object qryLeadLinesGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblMarketingleadlines.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryLeadLinesLeadID: TIntegerField
      FieldName = 'LeadID'
      Origin = 'tblMarketingleadlines.LeadID'
      Visible = False
    end
    object qryLeadLinesLeadLineID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'LeadLineID'
      Origin = 'tblMarketingleadlines.LeadLineID'
      Visible = False
    end
    object qryLeadLinesActionType: TIntegerField
      FieldName = 'ActionType'
      Origin = 'tblMarketingleadlines.ActionType'
      Visible = False
    end
    object qryLeadLinesActionID: TIntegerField
      FieldName = 'ActionID'
      Origin = 'tblMarketingleadlines.ActionID'
      Visible = False
    end
    object qryLeadLinesFollowupID: TIntegerField
      FieldName = 'FollowupID'
      Origin = 'tblMarketingleadlines.FollowupID'
      Visible = False
    end
    object qryLeadLinesActionRef: TWideStringField
      FieldName = 'ActionRef'
      Origin = 'tblMarketingleadlines.ActionRef'
      Visible = False
      Size = 255
    end
    object qryLeadLinesStatusID: TIntegerField
      FieldName = 'StatusID'
      Origin = 'tblMarketingleadlines.StatusID'
      Visible = False
    end
    object qryLeadLinesPriority: TIntegerField
      FieldName = 'Priority'
      Origin = 'tblMarketingleadlines.Priority'
      Visible = False
    end
    object qryLeadLinesEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblMarketingleadlines.EmployeeID'
      Visible = False
    end
    object qryLeadLinesDuration: TWideStringField
      FieldName = 'Duration'
      Origin = 'tblMarketingleadlines.Duration'
      Visible = False
      Size = 255
    end
    object qryLeadLinesTypeId: TIntegerField
      FieldName = 'TypeId'
      Origin = 'tblMarketingleadlines.TypeId'
      Visible = False
    end
    object qryLeadLinesTypeName: TWideStringField
      FieldName = 'TypeName'
      Origin = 'tblMarketingleadlines.TypeName'
      Visible = False
      Size = 255
    end
    object qryLeadLinesHours: TFloatField
      FieldName = 'Hours'
      Origin = 'tblMarketingleadlines.Hours'
      Visible = False
    end
    object qryLeadLinesResultTypeId: TIntegerField
      FieldName = 'ResultTypeId'
      Origin = 'tblMarketingleadlines.ResultTypeId'
      Visible = False
    end
    object qryLeadLinesIsPhoneFollowUp: TWideStringField
      FieldName = 'IsPhoneFollowUp'
      Origin = 'tblMarketingleadlines.IsPhoneFollowUp'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryLeadLinesEntryCount: TIntegerField
      FieldName = 'EntryCount'
      Origin = 'tblMarketingleadlines.EntryCount'
      Visible = False
    end
    object qryLeadLinesCreatedByID: TIntegerField
      FieldName = 'CreatedByID'
      Origin = 'tblMarketingleadlines.CreatedByID'
      Visible = False
    end
    object qryLeadLinesIsMarketing: TWideStringField
      FieldName = 'IsMarketing'
      Origin = 'tblMarketingleadlines.IsMarketing'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryLeadLinesIsLead: TWideStringField
      FieldName = 'IsLead'
      Origin = 'tblMarketingleadlines.IsLead'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryLeadLinesmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblMarketingleadlines.msTimeStamp'
      Visible = False
    end
  end
  object daLeads: TDataSource
    DataSet = qryLeads
    Left = 201
    Top = 296
  end
  object qryLeads: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblMArketingLeads')
    AfterPost = qryLeadsAfterPost
    Left = 201
    Top = 328
    object qryLeadsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblMArketingLeads.GlobalRef'
      Size = 255
    end
    object qryLeadsLeadID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'LeadID'
      Origin = 'tblMArketingLeads.LeadID'
    end
    object qryLeadsMarketingContactID: TIntegerField
      FieldName = 'MarketingContactID'
      Origin = 'tblMArketingLeads.MarketingContactID'
    end
    object qryLeadsClientID: TIntegerField
      FieldName = 'ClientID'
      Origin = 'tblMArketingLeads.ClientID'
    end
    object qryLeadsRepID: TIntegerField
      FieldName = 'RepID'
      Origin = 'tblMArketingLeads.RepID'
    end
    object qryLeadsEnteredByEmployeeID: TIntegerField
      FieldName = 'EnteredByEmployeeID'
      Origin = 'tblMArketingLeads.EnteredByEmployeeID'
    end
    object qryLeadsIsLead: TWideStringField
      FieldName = 'IsLead'
      Origin = 'tblMArketingLeads.IsLead'
      FixedChar = True
      Size = 1
    end
    object qryLeadsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblMArketingLeads.msTimeStamp'
    end
    object qryLeadsCompany: TWideStringField
      FieldName = 'Company'
      Origin = 'tblMArketingLeads.Company'
      Size = 255
    end
    object qryLeadsLeadStatus: TWideStringField
      FieldName = 'LeadStatus'
      Size = 255
    end
    object qryLeadsnotes: TWideStringField
      FieldName = 'notes'
      Size = 255
    end
    object qryLeadsCreatedOn: TDateTimeField
      FieldName = 'CreatedOn'
    end
  end
  object aawMessages: TAdvAlertWindow
    AlertMessages = <>
    AlwaysOnTop = True
    AutoHide = False
    AutoSize = True
    AutoDelete = False
    BorderColor = 9841920
    BtnHoverColor = 14483455
    BtnHoverColorTo = 6013175
    BtnDownColor = 557032
    BtnDownColorTo = 8182519
    CaptionColor = 14059353
    CaptionColorTo = 9841920
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    GradientDirection = gdVertical
    HintNextBtn = 'Next'
    HintPrevBtn = 'Previous'
    HintCloseBtn = 'Close'
    HintDeleteBtn = 'Delete'
    HintPopupBtn = 'Popup'
    Hover = False
    MarginX = 4
    MarginY = 1
    PopupLeft = 0
    PopupTop = 0
    PopupWidth = 300
    PopupHeight = 100
    PositionFormat = '%d of %d'
    WindowColor = 14155775
    WindowColorTo = 14155775
    ShowScrollers = True
    ShowDelete = False
    ShowPopup = False
    AlphaEnd = 180
    AlphaStart = 0
    FadeTime = 0
    DisplayTime = 5000
    FadeStep = 2
    WindowPosition = wpRightBottom
    Version = '1.7.0.0'
    Left = 783
    Top = 328
  end
  object qryEmployee: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT EmployeeId, EmployeeName, Active FROM tblEmployees'
      'WHERE Active = '#39'T'#39)
    Left = 383
    Top = 328
  end
  object qryContactSelectionList: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT rs.RangeSelectionID, RangeDescription, XMLData, Message '
      'FROM tblMarketingrangeselection rs '
      'LEFT JOIN tblMarketingrangeselectionmessages rsm'
      'USING(RangeSelectionID)'
      'WHERE rs.Active = "T";')
    Left = 347
    Top = 328
  end
  object qryContactList: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'tblmarketingcontacts.ID,'
      'tblmarketingcontacts.company'
      'FROM tblmarketingcontacts '
      
        'WHERE ID not in (Select ifnull(marketingcontactId,0) from tblMar' +
        'ketingleads);')
    Left = 310
    Top = 328
    object qryContactListID: TIntegerField
      FieldName = 'ID'
    end
    object qryContactListcompany: TWideStringField
      FieldName = 'company'
      Size = 255
    end
  end
  object qryMarketingcontacts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblMarketingcontacts')
    Left = 274
    Top = 328
    object qryMarketingcontactsCompanyTypeName: TWideStringField
      DisplayLabel = 'Company Type'
      DisplayWidth = 15
      FieldName = 'CompanyTypeName'
      Origin = 'tblMarketingcontacts.CompanyTypeName'
      Size = 255
    end
    object qryMarketingcontactsTitle: TWideStringField
      DisplayWidth = 1
      FieldName = 'Title'
      Origin = 'tblMarketingcontacts.Title'
      Size = 16
    end
    object qryMarketingcontactsCOMPANY: TWideStringField
      DisplayLabel = 'Company'
      DisplayWidth = 15
      FieldName = 'COMPANY'
      Origin = 'tblMarketingcontacts.COMPANY'
      Size = 255
    end
    object qryMarketingcontactsPhone: TWideStringField
      DisplayWidth = 12
      FieldName = 'Phone'
      Origin = 'tblMarketingcontacts.Phone'
      Size = 255
    end
    object qryMarketingcontactsAltPhone: TWideStringField
      DisplayLabel = 'Alt Phone'
      DisplayWidth = 12
      FieldName = 'AltPhone'
      Origin = 'tblMarketingcontacts.AltPhone'
      Size = 255
    end
    object qryMarketingcontactsMobile: TWideStringField
      DisplayWidth = 12
      FieldName = 'Mobile'
      Origin = 'tblMarketingcontacts.Mobile'
      Size = 255
    end
    object qryMarketingcontactsFirstName: TWideStringField
      DisplayLabel = 'First Name'
      DisplayWidth = 12
      FieldName = 'FirstName'
      Origin = 'tblMarketingcontacts.FirstName'
      Size = 255
    end
    object qryMarketingcontactsMiddleName: TWideStringField
      DisplayLabel = 'Middle Name'
      DisplayWidth = 11
      FieldName = 'MiddleName'
      Origin = 'tblMarketingcontacts.MiddleName'
      Size = 255
    end
    object qryMarketingcontactsLastName: TWideStringField
      DisplayLabel = 'Last Name'
      DisplayWidth = 12
      FieldName = 'LastName'
      Origin = 'tblMarketingcontacts.LastName'
      Size = 255
    end
    object qryMarketingcontactsEmployeeSize: TWideStringField
      DisplayLabel = 'Employee Size'
      DisplayWidth = 1
      FieldName = 'EmployeeSize'
      Origin = 'tblMarketingcontacts.EmployeeSize'
      Size = 255
    end
    object qryMarketingcontactsDateOfBirth: TDateField
      DisplayLabel = 'Date Of Birth'
      DisplayWidth = 12
      FieldName = 'DateOfBirth'
      Origin = 'tblMarketingcontacts.DateOfBirth'
    end
    object qryMarketingcontactsDuration: TDateTimeField
      DisplayWidth = 1
      FieldName = 'Duration'
      Origin = 'tblMarketingcontacts.Duration'
    end
    object qryMarketingcontactsDoNotQualify: TWideStringField
      DisplayWidth = 1
      FieldName = 'DoNotQualify'
      Origin = 'tblMarketingcontacts.DoNotQualify'
      FixedChar = True
      Size = 1
    end
    object qryMarketingcontactsStreet: TWideStringField
      DisplayWidth = 20
      FieldName = 'Street'
      Origin = 'tblMarketingcontacts.Street'
      Visible = False
      Size = 255
    end
    object qryMarketingcontactsStreet2: TWideStringField
      DisplayWidth = 20
      FieldName = 'Street2'
      Origin = 'tblMarketingcontacts.Street2'
      Visible = False
      Size = 255
    end
    object qryMarketingcontactsStreet3: TWideStringField
      DisplayWidth = 20
      FieldName = 'Street3'
      Origin = 'tblMarketingcontacts.Street3'
      Visible = False
      Size = 255
    end
    object qryMarketingcontactsFaxNumber: TWideStringField
      DisplayWidth = 20
      FieldName = 'FaxNumber'
      Origin = 'tblMarketingcontacts.FaxNumber'
      Visible = False
      Size = 255
    end
    object qryMarketingcontactsSUBURB: TWideStringField
      DisplayWidth = 20
      FieldName = 'SUBURB'
      Origin = 'tblMarketingcontacts.SUBURB'
      Visible = False
      Size = 255
    end
    object qryMarketingcontactsSTATE: TWideStringField
      DisplayWidth = 20
      FieldName = 'STATE'
      Origin = 'tblMarketingcontacts.STATE'
      Visible = False
      Size = 255
    end
    object qryMarketingcontactsPOSTCODE: TWideStringField
      DisplayWidth = 20
      FieldName = 'POSTCODE'
      Origin = 'tblMarketingcontacts.POSTCODE'
      Visible = False
      Size = 255
    end
    object qryMarketingcontactsNotes: TWideMemoField
      DisplayWidth = 10
      FieldName = 'Notes'
      Origin = 'tblMarketingcontacts.Notes'
      Visible = False
      BlobType = ftWideMemo
    end
    object qryMarketingcontactsActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblMarketingcontacts.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryMarketingcontactsJobTitle: TWideStringField
      DisplayWidth = 20
      FieldName = 'JobTitle'
      Origin = 'tblMarketingcontacts.JobTitle'
      Visible = False
      Size = 255
    end
    object qryMarketingcontactsEmail: TWideStringField
      DisplayWidth = 20
      FieldName = 'Email'
      Origin = 'tblMarketingcontacts.Email'
      Visible = False
      Size = 255
    end
    object qryMarketingcontactsCountry: TWideStringField
      DisplayWidth = 20
      FieldName = 'Country'
      Origin = 'tblMarketingcontacts.Country'
      Visible = False
      Size = 255
    end
    object qryMarketingcontactsDateEntered: TDateTimeField
      DisplayWidth = 10
      FieldName = 'DateEntered'
      Origin = 'tblMarketingcontacts.DateEntered'
      Visible = False
    end
    object qryMarketingcontactsEnteredEmpID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EnteredEmpID'
      Origin = 'tblMarketingcontacts.EnteredEmpID'
      Visible = False
    end
    object qryMarketingcontactsSource: TWideStringField
      DisplayWidth = 40
      FieldName = 'Source'
      Origin = 'tblMarketingcontacts.Source'
      Visible = False
      Size = 255
    end
    object qryMarketingcontactsmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblMarketingcontacts.msTimeStamp'
      Visible = False
    end
    object qryMarketingcontactsNumUnansweredCalls: TIntegerField
      DisplayWidth = 10
      FieldName = 'NumUnansweredCalls'
      Origin = 'tblMarketingcontacts.NumUnansweredCalls'
      Visible = False
    end
    object qryMarketingcontactsClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Origin = 'tblMarketingcontacts.ClientID'
      Visible = False
    end
    object qryMarketingcontactsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblMarketingcontacts.ID'
      Visible = False
    end
    object qryMarketingcontactsGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Origin = 'tblMarketingcontacts.GlobalRef'
      Visible = False
      Size = 255
    end
  end
  object dsMarketingcontacts: TDataSource
    DataSet = qryMarketingcontacts
    Left = 274
    Top = 296
  end
  object qrySimpleTypes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT Id, TypeCode, Name, Active'
      'FROM tblsimpletypes')
    Left = 165
    Top = 328
    object StringField4: TWideStringField
      DisplayWidth = 30
      FieldName = 'Name'
      Origin = 'tblsimpletypes.Name'
      Size = 255
    end
    object IntegerField2: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'Id'
      Origin = 'tblsimpletypes.Id'
      Visible = False
    end
    object StringField5: TWideStringField
      DisplayWidth = 30
      FieldName = 'TypeCode'
      Origin = 'tblsimpletypes.TypeCode'
      Visible = False
      Size = 30
    end
    object StringField6: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblsimpletypes.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object qryActionType: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblSimpleTypes WHERE '
      'Active <> '#39'F'#39' '
      'AND TypeCode ='#39'LeadActiontype'#39' '
      
        'AND NOT (name in ('#39'Appointment'#39', '#39'Invoice'#39', '#39'Quote'#39', '#39'SalesOrder' +
        #39','#39'Approved'#39','#39'Not Approved'#39'))')
    Left = 92
    Top = 328
    object qryActionTypeName: TWideStringField
      DisplayWidth = 30
      FieldName = 'Name'
      Origin = 'tblsimpletypes.Name'
      Size = 255
    end
    object qryActionTypeId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'Id'
      Origin = 'tblsimpletypes.Id'
      Visible = False
    end
    object qryActionTypeTypeCode: TWideStringField
      DisplayWidth = 30
      FieldName = 'TypeCode'
      Origin = 'tblsimpletypes.TypeCode'
      Visible = False
      Size = 30
    end
    object qryActionTypeActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblsimpletypes.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object dlgMemo: TwwMemoDialog
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Caption = 'Script'
    DlgLeft = 0
    DlgTop = 0
    DlgWidth = 561
    DlgHeight = 396
    Left = 674
    Top = 328
  end
end
