inherited fmEmployeeInfo: TfmEmployeeInfo
  Left = 758
  Top = 192
  HelpContext = 775001
  Caption = 'Employee'
  ClientHeight = 514
  OldCreateOrder = True
  ExplicitLeft = 758
  ExplicitTop = 192
  ExplicitHeight = 553
  DesignSize = (
    949
    514)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 398
    ExplicitTop = 399
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 949
    Height = 66
    HelpContext = 775054
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    ExplicitWidth = 952
    object pnlTitle: TDNMPanel
      Left = 306
      Top = 16
      Width = 345
      Height = 39
      HelpContext = 775055
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
        Width = 343
        Height = 37
        HelpContext = 775056
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
          Width = 343
          Height = 37
          HelpContext = 775057
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Employee'
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
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 398
    Width = 949
    Height = 66
    HelpContext = 775002
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    ExplicitLeft = 18
    ExplicitTop = 354
    DesignSize = (
      949
      66)
    object btnCompleted: TDNMSpeedButton
      Left = 306
      Top = 17
      Width = 87
      Height = 27
      HelpContext = 775003
      Anchors = [akTop, akRight]
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnCompletedClick
    end
    object btnClose: TDNMSpeedButton
      Left = 560
      Top = 17
      Width = 87
      Height = 27
      HelpContext = 775004
      Anchors = [akTop, akRight]
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
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnCloseClick
    end
    object btnNew: TDNMSpeedButton
      Left = 433
      Top = 17
      Width = 87
      Height = 27
      HelpContext = 775005
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'New'
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
      TabOrder = 1
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnNewClick
    end
  end
  object DNMPanel4: TDNMPanel [7]
    Left = 0
    Top = 66
    Width = 949
    Height = 332
    HelpContext = 775006
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
    ExplicitWidth = 952
    ExplicitHeight = 333
    object DNMPanel5: TDNMPanel
      Left = 11
      Top = 16
      Width = 331
      Height = 177
      HelpContext = 775007
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      Transparent = False
      object Label5: TLabel
        Left = 18
        Top = 10
        Width = 60
        Height = 18
        HelpContext = 775008
        AutoSize = False
        Caption = 'Mr./Mrs/...'
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
        Left = 150
        Top = 9
        Width = 61
        Height = 18
        HelpContext = 775009
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Initials:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label7: TLabel
        Left = 18
        Top = 46
        Width = 69
        Height = 18
        HelpContext = 775010
        AutoSize = False
        Caption = 'First Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label8: TLabel
        Left = 18
        Top = 83
        Width = 78
        Height = 18
        HelpContext = 775011
        AutoSize = False
        Caption = 'Middle Name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label9: TLabel
        Left = 18
        Top = 120
        Width = 69
        Height = 18
        HelpContext = 775012
        AutoSize = False
        Caption = 'Last Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label19: TLabel
        Left = 15
        Top = 152
        Width = 76
        Height = 15
        HelpContext = 775013
        Caption = 'Employee No:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label3: TLabel
        Left = 166
        Top = 152
        Width = 72
        Height = 15
        HelpContext = 775014
        Caption = 'Employee ID:'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Title: TDBEdit
        Left = 100
        Top = 7
        Width = 55
        Height = 23
        HelpContext = 775015
        DataField = 'Title'
        DataSource = dsemployee
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object Initials: TDBEdit
        Left = 215
        Top = 6
        Width = 37
        Height = 23
        HelpContext = 775016
        TabStop = False
        DataField = 'Initials'
        DataSource = dsemployee
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object FirstName: TDBEdit
        Left = 100
        Top = 43
        Width = 225
        Height = 23
        HelpContext = 775017
        DataField = 'FirstName'
        DataSource = dsemployee
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object MiddleName: TDBEdit
        Left = 100
        Top = 80
        Width = 225
        Height = 23
        HelpContext = 775018
        DataField = 'MiddleName'
        DataSource = dsemployee
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object LastName: TDBEdit
        Left = 100
        Top = 117
        Width = 225
        Height = 23
        HelpContext = 775019
        DataField = 'LastName'
        DataSource = dsemployee
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object EmployeeNo: TDBEdit
        Left = 100
        Top = 148
        Width = 51
        Height = 23
        HelpContext = 775020
        DataField = 'EmployeeNo'
        DataSource = dsemployee
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object DBEdit2: TDBEdit
        Left = 247
        Top = 148
        Width = 51
        Height = 23
        HelpContext = 775021
        DataField = 'EmployeeID'
        DataSource = dsemployee
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
      end
    end
    object DNMPanel6: TDNMPanel
      Left = 348
      Top = 16
      Width = 331
      Height = 177
      HelpContext = 775022
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label10: TLabel
        Left = 33
        Top = 12
        Width = 92
        Height = 18
        HelpContext = 775023
        AutoSize = False
        Caption = 'Phone Number'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label11: TLabel
        Left = 33
        Top = 67
        Width = 76
        Height = 18
        HelpContext = 775024
        AutoSize = False
        Caption = 'Fax Number'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label12: TLabel
        Left = 33
        Top = 94
        Width = 45
        Height = 18
        HelpContext = 775025
        AutoSize = False
        Caption = 'Mobile'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label13: TLabel
        Left = 33
        Top = 122
        Width = 70
        Height = 18
        HelpContext = 775026
        AutoSize = False
        Caption = 'Alt Contact:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label1: TLabel
        Left = 33
        Top = 39
        Width = 92
        Height = 18
        HelpContext = 775027
        AutoSize = False
        Caption = 'Alt Phone'
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
        Left = 33
        Top = 150
        Width = 76
        Height = 17
        HelpContext = 775028
        AutoSize = False
        Caption = 'Work Phone:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Phone: TwwDBEdit
        Left = 125
        Top = 9
        Width = 180
        Height = 23
        HelpContext = 775029
        DataField = 'Phone'
        DataSource = dsemployee
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
      object FaxNumber: TwwDBEdit
        Left = 125
        Top = 64
        Width = 180
        Height = 23
        HelpContext = 775030
        DataField = 'FaxNumber'
        DataSource = dsemployee
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
      object Mobile: TwwDBEdit
        Left = 125
        Top = 91
        Width = 180
        Height = 23
        HelpContext = 775031
        DataField = 'Mobile'
        DataSource = dsemployee
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object AltContact: TDBEdit
        Left = 125
        Top = 119
        Width = 180
        Height = 23
        HelpContext = 775032
        DataField = 'AltContact'
        DataSource = dsemployee
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object AltPhone: TwwDBEdit
        Left = 125
        Top = 36
        Width = 180
        Height = 23
        HelpContext = 775033
        DataField = 'AltPhone'
        DataSource = dsemployee
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
      object DBEdit1: TDBEdit
        Left = 125
        Top = 147
        Width = 180
        Height = 23
        HelpContext = 775034
        DataField = 'WorkPhone'
        DataSource = dsemployee
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
    end
    object DNMPanel8: TDNMPanel
      Left = 11
      Top = 196
      Width = 574
      Height = 133
      HelpContext = 775035
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Label18: TLabel
        Left = 353
        Top = 97
        Width = 77
        Height = 15
        HelpContext = 775036
        AutoSize = False
        Caption = 'Date of Birth:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label21: TLabel
        Left = 74
        Top = 58
        Width = 49
        Height = 15
        HelpContext = 775037
        Caption = 'Position:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label4: TLabel
        Left = 356
        Top = 61
        Width = 74
        Height = 15
        HelpContext = 775038
        Caption = 'Date Started:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label14: TLabel
        Left = 7
        Top = 98
        Width = 116
        Height = 15
        HelpContext = 775039
        Alignment = taRightJustify
        Caption = 'Default Department :'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label20: TLabel
        Left = 24
        Top = 19
        Width = 99
        Height = 18
        HelpContext = 775040
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Call Priority'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object DOB: TwwDBDateTimePicker
        Left = 439
        Top = 93
        Width = 121
        Height = 23
        HelpContext = 775041
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        CalendarAttributes.PopupYearOptions.NumberColumns = 6
        CalendarAttributes.PopupYearOptions.StartYear = 1935
        DataField = 'DOB'
        DataSource = dsemployee
        Date = 29866.000000000000000000
        Epoch = 1930
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 4
      end
      object rgSex: TwwRadioGroup
        Left = 356
        Top = 5
        Width = 204
        Height = 46
        HelpContext = 775042
        DisableThemes = False
        TransparentActiveItem = True
        Transparent = True
        Caption = 'Sex'
        Columns = 2
        DataField = 'Sex'
        DataSource = dsemployee
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Items.Strings = (
          'Male'
          'Female')
        ParentFont = False
        TabOrder = 2
        Values.Strings = (
          'Male'
          'Female')
      end
      object Position: TDBEdit
        Left = 132
        Top = 53
        Width = 199
        Height = 23
        HelpContext = 775043
        DataField = 'Position'
        DataSource = dsemployee
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object DateStarted: TwwDBDateTimePicker
        Left = 439
        Top = 57
        Width = 121
        Height = 23
        HelpContext = 775044
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        CalendarAttributes.PopupYearOptions.NumberColumns = 6
        CalendarAttributes.PopupYearOptions.StartYear = 1980
        DataField = 'DateStarted'
        DataSource = dsemployee
        Date = 39367.000000000000000000
        Epoch = 1930
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 3
      end
      object DBEdit3: TDBEdit
        Left = 132
        Top = 93
        Width = 199
        Height = 23
        HelpContext = 775045
        DataField = 'DefaultClassName'
        DataSource = dsemployee
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object wwDBComboBox1: TwwDBComboBox
        Left = 132
        Top = 14
        Width = 199
        Height = 23
        HelpContext = 775046
        ShowButton = True
        Style = csDropDownList
        MapList = True
        AllowClearKey = False
        AutoDropDown = True
        AutoFillDate = False
        DataField = 'callpriority'
        DataSource = dsemployee
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          '10 - High'#9'10'
          '9'#9'9'
          '8'#9'8'
          '7'#9'7'
          '6'#9'6'
          '5  - Standard'#9'5'
          '4'#9'4'
          '3'#9'3'
          '2'#9'2'
          '1'#9'1'
          '0  - Low'#9'0')
        ParentFont = False
        Sorted = False
        TabOrder = 5
        UnboundDataType = wwDefault
        UnboundAlignment = taCenter
      end
    end
    object rgBasisOfEmployment: TwwRadioGroup
      Left = 685
      Top = 10
      Width = 262
      Height = 184
      HelpContext = 775047
      DisableThemes = False
      TransparentActiveItem = True
      Transparent = True
      Caption = 'Basis of Employment'
      DataField = 'BasisOfPayment'
      DataSource = dsemployee
      Items.Strings = (
        'Full Time'
        'Part Time'
        'Casual'
        'Labour Hire'
        'Superannuation Pension or Annuity')
      TabOrder = 2
      Values.Strings = (
        'F'
        'P'
        'C'
        'L'
        'S')
    end
    object DNMPanel2: TDNMPanel
      Left = 590
      Top = 196
      Width = 357
      Height = 133
      HelpContext = 775048
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object Label15: TLabel
        Left = 25
        Top = 36
        Width = 48
        Height = 15
        HelpContext = 775049
        Caption = 'Address'
        Transparent = True
      end
      object Label16: TLabel
        Left = 12
        Top = 84
        Width = 64
        Height = 15
        HelpContext = 775050
        Caption = 'Send From:'
        Transparent = True
      end
      object Label17: TLabel
        Left = 12
        Top = 7
        Width = 38
        Height = 15
        HelpContext = 775051
        Caption = 'Emails'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Email: TDBEdit
        Left = 92
        Top = 32
        Width = 255
        Height = 23
        HelpContext = 775052
        DataField = 'Email'
        DataSource = dsemployee
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object rgEmailsFrom: TwwRadioGroup
        Left = 83
        Top = 57
        Width = 269
        Height = 69
        HelpContext = 775053
        DisableThemes = False
        TransparentActiveItem = True
        Transparent = True
        DataField = 'EmailsFromEmployeeAddress'
        Items.Strings = (
          'Employee address'
          'System address')
        TabOrder = 1
        Values.Strings = (
          'T'
          'F')
      end
    end
  end
  object pnlDevComments: TDNMPanel [8]
    Left = 0
    Top = 464
    Width = 949
    Height = 50
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    Visible = False
    ExplicitTop = 422
    ExplicitWidth = 800
    object Label22: TLabel
      Left = 1
      Top = 1
      Width = 947
      Height = 48
      HelpContext = 118025
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 'This form is used in Main Employee Form'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -39
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      ExplicitLeft = 271
      ExplicitTop = 14
      ExplicitWidth = 69
      ExplicitHeight = 17
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C0101020070007C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object Qryemployee: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select Title ,Initials , FirstName , MiddleName , LastName , '
      'Phone , AltPhone  , FaxNumber, Mobile, AltContact, WorkPhone , '
      'DefaultClassName ,  DefaultClassID ,'
      'EmployeeNo, EmployeeID, '
      
        'Position, DOB, Sex, NextOfKin, NextOfKinRelationship, NextOfKinP' +
        'hone, DateStarted,'
      'BasisOfPayment , employeeName, email,callpriority'
      'from tblemployees')
    Options.LongStrings = False
    Left = 194
    Top = 56
    object QryemployeeTitle: TWideStringField
      FieldName = 'Title'
      Origin = 'tblemployees.Title'
      Size = 5
    end
    object QryemployeeInitials: TWideStringField
      FieldName = 'Initials'
      Origin = 'tblemployees.Initials'
      FixedChar = True
      Size = 3
    end
    object QryemployeeFirstName: TWideStringField
      FieldName = 'FirstName'
      Origin = 'tblemployees.FirstName'
      Size = 40
    end
    object QryemployeeMiddleName: TWideStringField
      FieldName = 'MiddleName'
      Origin = 'tblemployees.MiddleName'
      Size = 40
    end
    object QryemployeeLastName: TWideStringField
      FieldName = 'LastName'
      Origin = 'tblemployees.LastName'
      Size = 40
    end
    object QryemployeePhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'tblemployees.Phone'
      Size = 255
    end
    object QryemployeeAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Origin = 'tblemployees.AltPhone'
      Size = 255
    end
    object QryemployeeFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
      Origin = 'tblemployees.FaxNumber'
      Size = 255
    end
    object QryemployeeMobile: TWideStringField
      FieldName = 'Mobile'
      Origin = 'tblemployees.Mobile'
      Size = 255
    end
    object QryemployeeAltContact: TWideStringField
      FieldName = 'AltContact'
      Origin = 'tblemployees.AltContact'
      Size = 255
    end
    object QryemployeeWorkPhone: TWideStringField
      FieldName = 'WorkPhone'
      Origin = 'tblemployees.WorkPhone'
      Size = 255
    end
    object QryemployeeDefaultClassName: TWideStringField
      FieldName = 'DefaultClassName'
      Origin = 'tblemployees.DefaultClassName'
      Size = 255
    end
    object QryemployeeEmployeeNo: TIntegerField
      FieldName = 'EmployeeNo'
      Origin = 'tblemployees.EmployeeNo'
    end
    object QryemployeeEmployeeID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'EmployeeID'
      Origin = 'tblemployees.EmployeeID'
    end
    object QryemployeePosition: TWideStringField
      FieldName = 'Position'
      Origin = 'tblemployees.Position'
      Size = 30
    end
    object QryemployeeDOB: TDateField
      FieldName = 'DOB'
      Origin = 'tblemployees.DOB'
    end
    object QryemployeeSex: TWideStringField
      FieldName = 'Sex'
      Origin = 'tblemployees.Sex'
      Size = 32
    end
    object QryemployeeNextOfKin: TWideStringField
      FieldName = 'NextOfKin'
      Origin = 'tblemployees.NextOfKin'
      Size = 150
    end
    object QryemployeeNextOfKinRelationship: TWideStringField
      FieldName = 'NextOfKinRelationship'
      Origin = 'tblemployees.NextOfKinRelationship'
      Size = 100
    end
    object QryemployeeNextOfKinPhone: TWideStringField
      FieldName = 'NextOfKinPhone'
      Origin = 'tblemployees.NextOfKinPhone'
    end
    object QryemployeeDefaultClassID: TIntegerField
      FieldName = 'DefaultClassID'
      Origin = 'tblemployees.DefaultClassID'
    end
    object QryemployeeDateStarted: TDateField
      FieldName = 'DateStarted'
      Origin = 'tblemployees.DateStarted'
    end
    object QryemployeeBasisOfPayment: TWideStringField
      FieldName = 'BasisOfPayment'
      Origin = 'tblemployees.BasisOfPayment'
      FixedChar = True
      Size = 1
    end
    object QryemployeeemployeeName: TWideStringField
      FieldName = 'employeeName'
      Origin = 'tblemployees.EmployeeName'
      Size = 255
    end
    object Qryemployeeemail: TWideStringField
      FieldName = 'email'
      Origin = 'tblemployees.Email'
      Size = 80
    end
    object Qryemployeecallpriority: TIntegerField
      FieldName = 'callpriority'
    end
  end
  object dsemployee: TDataSource
    DataSet = Qryemployee
    Left = 232
    Top = 64
  end
end
