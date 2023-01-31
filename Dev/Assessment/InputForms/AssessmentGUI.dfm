inherited AssessmentGUI: TAssessmentGUI
  Left = 237
  Top = 125
  HelpContext = 18000
  Caption = 'Assessment'
  ClientHeight = 564
  ClientWidth = 718
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  inherited imgGridWatermark: TImage
    HelpContext = 18001
  end
  object DNMPanel1: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 718
    Height = 321
    HelpContext = 18002
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      718
      321)
    object Bevel1: TBevel
      Left = 28
      Top = 85
      Width = 661
      Height = 228
      HelpContext = 18003
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object Label1: TLabel
      Left = 97
      Top = 94
      Width = 26
      Height = 15
      HelpContext = 18004
      Alignment = taRightJustify
      Caption = 'Date'
      Transparent = True
    end
    object Label2: TLabel
      Left = 76
      Top = 147
      Width = 47
      Height = 15
      HelpContext = 18005
      Alignment = taRightJustify
      Caption = 'Time On'
      Transparent = True
    end
    object Label3: TLabel
      Left = 75
      Top = 174
      Width = 48
      Height = 15
      HelpContext = 18006
      Alignment = taRightJustify
      Caption = 'Time Off'
      Transparent = True
    end
    object Label4: TLabel
      Left = 45
      Top = 201
      Width = 78
      Height = 15
      HelpContext = 18007
      Alignment = taRightJustify
      Caption = 'Journey From'
      FocusControl = edtDesc
      Transparent = True
    end
    object Label5: TLabel
      Left = 60
      Top = 228
      Width = 63
      Height = 15
      HelpContext = 18008
      Alignment = taRightJustify
      Caption = 'Journey To'
      FocusControl = DBEdit1
      Transparent = True
    end
    object Label6: TLabel
      Left = 34
      Top = 255
      Width = 89
      Height = 15
      HelpContext = 18009
      Alignment = taRightJustify
      Caption = 'Bus Destination'
      FocusControl = DBEdit2
      Transparent = True
    end
    object Label7: TLabel
      Left = 44
      Top = 282
      Width = 79
      Height = 15
      HelpContext = 18010
      Alignment = taRightJustify
      Caption = 'Weather Type'
      FocusControl = DBEdit2
      Transparent = True
    end
    object Label8: TLabel
      Left = 438
      Top = 94
      Width = 72
      Height = 15
      HelpContext = 18011
      Anchors = [akTop, akRight]
      Caption = 'Vehicle Type'
      FocusControl = DBEdit3
      Transparent = True
    end
    object Label9: TLabel
      Left = 415
      Top = 148
      Width = 95
      Height = 15
      HelpContext = 18012
      Anchors = [akTop, akRight]
      Caption = 'Running/Duty No.'
      FocusControl = DBEdit4
      Transparent = True
    end
    object Label10: TLabel
      Left = 440
      Top = 175
      Width = 70
      Height = 15
      HelpContext = 18013
      Anchors = [akTop, akRight]
      Caption = 'Reg Number'
      FocusControl = DBEdit5
      Transparent = True
    end
    object Label11: TLabel
      Left = 469
      Top = 202
      Width = 41
      Height = 15
      HelpContext = 18014
      Anchors = [akTop, akRight]
      Caption = 'Garage'
      FocusControl = DBEdit2
      Transparent = True
    end
    object Label12: TLabel
      Left = 477
      Top = 256
      Width = 33
      Height = 15
      HelpContext = 18015
      Anchors = [akTop, akRight]
      Caption = 'Route'
      FocusControl = DBEdit6
      Transparent = True
    end
    object Label13: TLabel
      Left = 427
      Top = 281
      Width = 71
      Height = 15
      HelpContext = 18016
      Anchors = [akTop, akRight]
      Caption = 'Covert/Overt'
      FocusControl = DBEdit6
      Transparent = True
    end
    object Label14: TLabel
      Left = 567
      Top = 283
      Width = 79
      Height = 15
      HelpContext = 18017
      Anchors = [akTop, akRight]
      Caption = 'Uniform Worn'
      FocusControl = DBEdit6
      Transparent = True
    end
    object Label15: TLabel
      Left = 534
      Top = 44
      Width = 102
      Height = 15
      HelpContext = 18018
      Anchors = [akTop, akRight]
      Caption = 'Assessment Type'
      FocusControl = DBEdit3
      Transparent = True
    end
    object Label16: TLabel
      Left = 27
      Top = 4
      Width = 90
      Height = 15
      HelpContext = 18019
      Caption = 'Assessment No'
      FocusControl = DBEdit7
      Transparent = True
    end
    object Label48: TLabel
      Left = 28
      Top = 44
      Width = 60
      Height = 15
      HelpContext = 18020
      AutoSize = False
      Caption = 'Assessor'
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
      Left = 472
      Top = 229
      Width = 38
      Height = 15
      HelpContext = 18021
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Driver'
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
      Left = 438
      Top = 121
      Width = 75
      Height = 15
      HelpContext = 18022
      Anchors = [akTop, akRight]
      Caption = 'Fleet Number'
      FocusControl = DBEdit8
      Transparent = True
    end
    object Label22: TLabel
      Left = 45
      Top = 120
      Width = 78
      Height = 15
      HelpContext = 18023
      Caption = 'Requested By'
      FocusControl = DBEdit9
      Transparent = True
    end
    object wwDBDateTimePicker1: TwwDBDateTimePicker
      Left = 125
      Top = 91
      Width = 121
      Height = 23
      HelpContext = 18024
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'Date'
      DataSource = DSMaster
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 2
      UnboundDataType = wwDTEdtDate
    end
    object wwDBDateTimePicker2: TwwDBDateTimePicker
      Left = 125
      Top = 145
      Width = 121
      Height = 23
      HelpContext = 18025
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'TimeOn'
      DataSource = DSMaster
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 3
      UnboundDataType = wwDTEdtTime
    end
    object wwDBDateTimePicker3: TwwDBDateTimePicker
      Left = 125
      Top = 172
      Width = 121
      Height = 23
      HelpContext = 18026
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'TimeOff'
      DataSource = DSMaster
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 4
      UnboundDataType = wwDTEdtTime
    end
    object edtDesc: TDBEdit
      Left = 125
      Top = 199
      Width = 161
      Height = 23
      HelpContext = 18027
      DataField = 'JourneyFrom'
      DataSource = DSMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object DBEdit1: TDBEdit
      Left = 125
      Top = 226
      Width = 161
      Height = 23
      HelpContext = 18028
      DataField = 'JourneyTo'
      DataSource = DSMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object DBEdit2: TDBEdit
      Left = 125
      Top = 253
      Width = 161
      Height = 23
      HelpContext = 18029
      DataField = 'BusDestination'
      DataSource = DSMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object wwDBLookupCombo1: TwwDBLookupCombo
      Left = 125
      Top = 280
      Width = 121
      Height = 23
      HelpContext = 18030
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      DataField = 'WeatherType'
      DataSource = DSMaster
      LookupTable = qryWeather
      LookupField = 'Description'
      ParentFont = False
      TabOrder = 8
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      OnNotInList = wwDBLookupCombo1NotInList
    end
    object DBEdit3: TDBEdit
      Left = 516
      Top = 91
      Width = 161
      Height = 23
      HelpContext = 18031
      Anchors = [akTop, akRight]
      DataField = 'VehicleType'
      DataSource = DSMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object DBEdit4: TDBEdit
      Left = 516
      Top = 145
      Width = 161
      Height = 23
      HelpContext = 18032
      Anchors = [akTop, akRight]
      DataField = 'RunningNumber'
      DataSource = DSMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
    end
    object DBEdit5: TDBEdit
      Left = 516
      Top = 172
      Width = 161
      Height = 23
      HelpContext = 18033
      Anchors = [akTop, akRight]
      DataField = 'RegNumber'
      DataSource = DSMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
    end
    object cboGarage: TwwDBLookupCombo
      Left = 516
      Top = 199
      Width = 121
      Height = 23
      HelpContext = 18034
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taRightJustify
      DataField = 'Garage'
      DataSource = DSMaster
      LookupTable = qryCust
      LookupField = 'Company'
      DropDownWidth = 200
      ParentFont = False
      TabOrder = 12
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      OnChange = cboGarageChange
      OnNotInList = cboGarageNotInList
    end
    object DBEdit6: TDBEdit
      Left = 516
      Top = 253
      Width = 161
      Height = 23
      HelpContext = 18035
      Anchors = [akTop, akRight]
      DataField = 'Route'
      DataSource = DSMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
    end
    object wwCheckBox1: TwwCheckBox
      Left = 514
      Top = 280
      Width = 16
      Height = 17
      HelpContext = 18036
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
      Anchors = [akTop, akRight]
      DataField = 'Covert'
      DataSource = DSMaster
      TabOrder = 14
    end
    object wwCheckBox2: TwwCheckBox
      Left = 649
      Top = 282
      Width = 16
      Height = 17
      HelpContext = 18037
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
      Anchors = [akTop, akRight]
      DataField = 'UniformWorn'
      DataSource = DSMaster
      TabOrder = 15
    end
    object wwRadioGroup1: TwwRadioGroup
      Left = 303
      Top = 197
      Width = 127
      Height = 72
      HelpContext = 18038
      TransparentActiveItem = True
      Indents.ButtonX = 30
      Indents.TextX = 10
      Transparent = True
      Anchors = [akTop]
      Caption = 'Assessment Today'
      DataField = 'AssessmentToday'
      DataSource = DSMaster
      Items.Strings = (
        '1st'
        '2nd')
      TabOrder = 16
      Values.Strings = (
        '1'
        '2')
    end
    object wwDBLookupCombo3: TwwDBLookupCombo
      Left = 533
      Top = 58
      Width = 153
      Height = 23
      HelpContext = 18039
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'TypeName'#9'30'#9'TypeName'#9'F')
      DataField = 'TypeID'
      DataSource = DSMaster
      LookupTable = qryAssessmentType
      LookupField = 'TypeID'
      ParentFont = False
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
      OnCloseUp = wwDBLookupCombo3CloseUp
    end
    object DBEdit7: TDBEdit
      Left = 27
      Top = 20
      Width = 82
      Height = 23
      HelpContext = 18040
      DataField = 'AssessmentID'
      DataSource = DSMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 18
    end
    object cboEmployee: TwwDBLookupCombo
      Left = 28
      Top = 58
      Width = 181
      Height = 23
      HelpContext = 18041
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'EmployeeName'#9'30'#9'EmployeeName'#9'F')
      DataField = 'AssessorID'
      DataSource = DSMaster
      LookupTable = cboEmployeeLookup
      LookupField = 'EmployeeID'
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      OnCloseUp = cboEmployeeCloseUp
    end
    object cboDrivers: TwwDBLookupCombo
      Left = 516
      Top = 226
      Width = 161
      Height = 23
      HelpContext = 18042
      Anchors = [akTop, akRight]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'DriverName'#9'20'#9'Driver'#9'F')
      DataField = 'DriverID'
      DataSource = DSMaster
      LookupTable = qryDrivers
      LookupField = 'DriverID'
      ParentFont = False
      TabOrder = 17
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      OnCloseUp = cboDriversCloseUp
    end
    object pnlTitle: TDNMPanel
      Left = 241
      Top = 6
      Width = 238
      Height = 42
      HelpContext = 18043
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 19
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 234
        Height = 38
        HelpContext = 18044
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        FromColor = clBtnFace
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = clBtnFace
        Steps = 10
        Direction = False
        Version = '1.2.1.1'
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 234
          Height = 38
          HelpContext = 18045
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Assessment'
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
    object pnlChooseRpt: TDNMPanel
      Left = 303
      Top = 57
      Width = 132
      Height = 23
      HelpContext = 18046
      Anchors = [akTop]
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 20
      object lblChooseRpt: TLabel
        Left = 28
        Top = 4
        Width = 99
        Height = 15
        HelpContext = 18047
        Caption = 'Choose Template'
        Transparent = True
      end
      object chkChooseRpt: TCheckBox
        Left = 8
        Top = 3
        Width = 14
        Height = 17
        HelpContext = 18048
        TabStop = False
        TabOrder = 0
      end
    end
    object DBEdit8: TDBEdit
      Left = 516
      Top = 118
      Width = 161
      Height = 23
      HelpContext = 18049
      Anchors = [akTop, akRight]
      DataField = 'FleetNumber'
      DataSource = DSMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 21
    end
    object DBEdit9: TDBEdit
      Left = 125
      Top = 118
      Width = 161
      Height = 23
      HelpContext = 18050
      DataField = 'RequestedBy'
      DataSource = DSMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 22
    end
  end
  object DNMPanel2: TDNMPanel [2]
    Left = 0
    Top = 321
    Width = 718
    Height = 243
    HelpContext = 18051
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      718
      243)
    object lblActive: TLabel
      Left = 674
      Top = 207
      Width = 40
      Height = 15
      HelpContext = 18052
      Alignment = taCenter
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = 'Active'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Bevel2: TBevel
      Left = 148
      Top = 162
      Width = 429
      Height = 39
      HelpContext = 18053
      Anchors = [akLeft, akRight, akBottom]
    end
    object Label17: TLabel
      Left = 168
      Top = 173
      Width = 34
      Height = 15
      HelpContext = 18054
      Anchors = [akLeft, akBottom]
      Caption = 'Score'
      Transparent = True
    end
    object Label18: TLabel
      Left = 310
      Top = 173
      Width = 79
      Height = 15
      HelpContext = 18055
      Anchors = [akBottom]
      Caption = 'Overall Rating'
      Transparent = True
    end
    object Label19: TLabel
      Left = 487
      Top = 166
      Width = 88
      Height = 15
      HelpContext = 18056
      Anchors = [akRight, akBottom]
      Caption = 'Override Rating'
      FocusControl = DBEdit6
      Transparent = True
    end
    object btnSave: TDNMSpeedButton
      Left = 98
      Top = 210
      Width = 87
      Height = 27
      HelpContext = 18057
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
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnNew: TDNMSpeedButton
      Left = 386
      Top = 210
      Width = 87
      Height = 27
      HelpContext = 18058
      Anchors = [akBottom]
      Caption = '&New'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 1
      OnClick = btnNewClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 530
      Top = 210
      Width = 85
      Height = 27
      HelpContext = 18059
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
      TabOrder = 2
      OnClick = btnCancelClick
    end
    object chkActive: TwwCheckBox
      Left = 687
      Top = 220
      Width = 13
      Height = 16
      HelpContext = 18060
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbChecked
      Anchors = [akRight, akBottom]
      Checked = True
      DataField = 'Active'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 3
    end
    object btnPrint: TDNMSpeedButton
      Left = 242
      Top = 210
      Width = 87
      Height = 27
      HelpContext = 18061
      Anchors = [akBottom]
      Caption = '&Print'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 4
      OnClick = btnPrintClick
    end
    object Score: TwwDBEdit
      Left = 206
      Top = 168
      Width = 78
      Height = 27
      HelpContext = 18062
      Anchors = [akLeft, akBottom]
      AutoFillDate = False
      AutoSelect = False
      AutoSize = False
      DataField = 'Score'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      UnboundDataType = wwDefault
      UnboundAlignment = taCenter
      WantReturns = False
      WordWrap = False
    end
    object OverrideRating: TwwCheckBox
      Left = 519
      Top = 178
      Width = 15
      Height = 17
      HelpContext = 18063
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
      Caption = 'OverrideRating'
      DataField = 'OverrideRating'
      DataSource = DSMaster
      TabOrder = 6
      OnClick = OverrideRatingClick
    end
    object Rating: TwwDBComboBox
      Left = 392
      Top = 168
      Width = 79
      Height = 27
      HelpContext = 18064
      Anchors = [akBottom]
      ShowButton = True
      Style = csDropDownList
      MapList = False
      AllowClearKey = False
      AutoDropDown = True
      AutoFillDate = False
      AutoSize = False
      DataField = 'Rating'
      DataSource = DSMaster
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ItemHeight = 0
      Items.Strings = (
        '1'
        '2'
        '3A'
        '3B'
        '4')
      ItemIndex = 0
      ParentFont = False
      Sorted = False
      TabOrder = 7
      UnboundDataType = wwDefault
      UnboundAlignment = taRightJustify
    end
    object PageControl1: TPageControl
      Left = 28
      Top = -1
      Width = 661
      Height = 156
      HelpContext = 18065
      ActivePage = TabSheet1
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabHeight = 22
      TabIndex = 0
      TabOrder = 8
      TabWidth = 219
      object TabSheet1: TTabSheet
        HelpContext = 18066
        Caption = 'Labels'
        object grdData: TwwDBGrid
          Left = 0
          Top = 0
          Width = 653
          Height = 124
          HelpContext = 18067
          ControlType.Strings = (
            'Result;CustomEdit;wwRadioGroup2;F')
          Selected.Strings = (
            'Label'#9'50'#9'Label'#9#9
            'Result'#9'17'#9'Result'#9#9)
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
          KeyOptions = []
          ParentFont = False
          TabOrder = 1
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          OnExit = grdDataExit
        end
        object wwRadioGroup2: TwwRadioGroup
          Left = 287
          Top = 15
          Width = 129
          Height = 18
          ShowBorder = False
          ShowGroupCaption = False
          ShowFocusRect = False
          Caption = 'wwRadioGroup2'
          Color = clWhite
          Columns = 4
          DataField = 'Result'
          DataSource = DSDetails
          Items.Strings = (
            '1'
            '2'
            '3'
            '4')
          ParentColor = False
          TabOrder = 0
          Values.Strings = (
            '1'
            '2'
            '3'
            '4')
        end
      end
      object TabSheet2: TTabSheet
        HelpContext = 18068
        Caption = 'Other Options'
        ImageIndex = 1
        object grdData2: TwwDBGrid
          Left = 0
          Top = 0
          Width = 653
          Height = 124
          HelpContext = 18069
          ControlType.Strings = (
            'Result;CustomEdit;chkyesno;F')
          Selected.Strings = (
            'Label'#9'50'#9'Label'#9#9
            'Result'#9'1'#9'Result'#9#9)
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          Align = alClient
          DataSource = DSDetails2
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
          OnExit = grdDataExit
        end
        object chkyesno: TwwCheckBox
          Left = 336
          Top = 43
          Width = 40
          Height = 18
          AlwaysTransparent = True
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.FocusBorders = []
          Frame.NonFocusBorders = []
          DynamicCaption = True
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          DisplayValueChecked = 'Yes'
          DisplayValueUnchecked = 'No'
          NullAndBlankState = cbUnchecked
          Caption = 'No'
          Color = clWhite
          ParentColor = False
          TabOrder = 1
        end
      end
      object TabSheet3: TTabSheet
        HelpContext = 18070
        Caption = 'Notes'
        ImageIndex = 2
        object DBMemo1: TDBMemo
          Left = 0
          Top = 0
          Width = 653
          Height = 124
          HelpContext = 18071
          Align = alClient
          DataField = 'Notes'
          DataSource = DSMaster
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
      end
    end
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 41
    Top = 444
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 84
    Top = 387
  end
  inherited MyConnection: TERPConnection
    Left = 43
    Top = 385
  end
  inherited DataState: TDataState
    Left = 86
    Top = 420
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 146
    Top = 387
  end
  object tblMaster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * '
      'FROM tblassessments'
      'WHERE AssessmentID = :xID;')
    Left = 307
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object tblMasterAssessmentID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'AssessmentID'
      Origin = 'tblassessments.AssessmentID'
    end
    object tblMasterDriverID: TIntegerField
      FieldName = 'DriverID'
      Origin = 'tblassessments.DriverID'
    end
    object tblMasterAssessorID: TIntegerField
      FieldName = 'AssessorID'
    end
    object tblMasterTypeID: TIntegerField
      FieldName = 'TypeID'
      Origin = 'tblassessments.TypeID'
    end
    object tblMasterTimeOn: TTimeField
      FieldName = 'TimeOn'
      Origin = 'tblassessments.TimeOn'
    end
    object tblMasterTimeOff: TTimeField
      FieldName = 'TimeOff'
      Origin = 'tblassessments.TimeOff'
    end
    object tblMasterJourneyFrom: TWideStringField
      FieldName = 'JourneyFrom'
      Origin = 'tblassessments.JourneyFrom'
      Size = 50
    end
    object tblMasterJourneyTo: TWideStringField
      FieldName = 'JourneyTo'
      Origin = 'tblassessments.JourneyTo'
      Size = 50
    end
    object tblMasterBusDestination: TWideStringField
      FieldName = 'BusDestination'
      Origin = 'tblassessments.BusDestination'
      Size = 50
    end
    object tblMasterWeatherType: TWideStringField
      FieldName = 'WeatherType'
      Origin = 'tblassessments.WeatherType'
      Size = 50
    end
    object tblMasterVehicleType: TWideStringField
      FieldName = 'VehicleType'
      Origin = 'tblassessments.VehicleType'
      Size = 50
    end
    object tblMasterFleetNumber: TWideStringField
      FieldName = 'FleetNumber'
      Origin = 'tblassessments.FleetNumber'
    end
    object tblMasterRunningNumber: TWideStringField
      FieldName = 'RunningNumber'
      Origin = 'tblassessments.RunningNumber'
    end
    object tblMasterRegNumber: TWideStringField
      FieldName = 'RegNumber'
      Origin = 'tblassessments.RegNumber'
    end
    object tblMasterGarage: TWideStringField
      FieldName = 'Garage'
      Origin = 'tblassessments.Garage'
      Size = 50
    end
    object tblMasterRoute: TWideStringField
      FieldName = 'Route'
      Origin = 'tblassessments.Route'
      Size = 50
    end
    object tblMasterCovert: TWideStringField
      FieldName = 'Covert'
      Origin = 'tblassessments.Covert'
      FixedChar = True
      Size = 1
    end
    object tblMasterUniformWorn: TWideStringField
      FieldName = 'UniformWorn'
      Origin = 'tblassessments.UniformWorn'
      FixedChar = True
      Size = 1
    end
    object tblMasterAssessmentToday: TIntegerField
      FieldName = 'AssessmentToday'
      Origin = 'tblassessments.AssessmentToday'
    end
    object tblMasterDate: TDateField
      FieldName = 'Date'
      Origin = 'tblassessments.Date'
    end
    object tblMasterActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblassessments.Active'
      FixedChar = True
      Size = 1
    end
    object tblMasterConverted: TWideStringField
      FieldName = 'Converted'
      Origin = 'tblassessments.Converted'
      FixedChar = True
      Size = 1
    end
    object tblMasterScore: TIntegerField
      FieldName = 'Score'
      Origin = 'tblassessments.Score'
    end
    object tblMasterRating: TWideStringField
      FieldName = 'Rating'
      Origin = 'tblassessments.Rating'
      FixedChar = True
      Size = 3
    end
    object tblMasterOverrideRating: TWideStringField
      FieldName = 'OverrideRating'
      Origin = 'tblassessments.OverrideRating'
      FixedChar = True
      Size = 1
    end
    object tblMasterNotes: TMemoField
      FieldName = 'Notes'
      BlobType = ftMemo
    end
    object tblMasterRequestedBy: TWideStringField
      FieldName = 'RequestedBy'
      Size = 255
    end
  end
  object DSMaster: TDataSource
    DataSet = tblMaster
    Left = 305
    Top = 18
  end
  object tblDetails: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * '
      'FROM tblassessmentsdetails'
      'WHERE AssessmentID = :xID;')
    BeforePost = tblDetailsBeforePost
    Left = 352
    Top = 65535
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object tblDetailsLabel: TWideStringField
      DisplayWidth = 50
      FieldName = 'Label'
      Origin = 'tblassessmentsdetails.Label'
      Size = 50
    end
    object tblDetailsResult: TIntegerField
      DisplayWidth = 17
      FieldName = 'Result'
      Origin = 'tblassessmentsdetails.Result'
      OnChange = tblDetailsResultChange
    end
    object tblDetailsAssessmentDetailsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'AssessmentDetailsID'
      Origin = 'tblassessmentsdetails.AssessmentDetailsID'
      Visible = False
    end
    object tblDetailsAssessmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'AssessmentID'
      Origin = 'tblassessmentsdetails.AssessmentID'
      Visible = False
    end
    object tblDetailsLabelID: TIntegerField
      DisplayWidth = 10
      FieldName = 'LabelID'
      Origin = 'tblassessmentsdetails.LabelID'
      Visible = False
    end
  end
  object DSDetails: TDataSource
    DataSet = tblDetails
    Left = 349
    Top = 18
  end
  object qryAssessmentType: TERPQuery
    SQL.Strings = (
      'SELECT * '
      'FROM tblassessmenttypes'
      'WHERE (Active = '#39'T'#39' OR TypeID=:xID);')
    Left = 655
    Top = 33
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
  end
  object qryWeather: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblassessmentweather Where Active = '#39'T'#39';')
    Left = 248
    Top = 279
  end
  object qryCust: TERPQuery
    SQL.Strings = (
      'SELECT'
      'C1.ClientID as ClientID,'
      'C1.Company as Company'
      'FROM tblclients as C1'
      
        'LEFT JOIN tblClientType AS CT on C1.ClientTypeID = CT.ClientType' +
        'ID'
      'LEFT JOIN tblClients as C2 on C1.ParentClientID = C2.ClientID'
      'WHERE C1.Customer='#39'T'#39' AND Length(C1.Company)>0'
      'AND (C1.Active = '#39'T'#39');')
    Left = 689
    Top = 187
  end
  object cboEmployeeLookup: TERPQuery
    SQL.Strings = (
      'SELECT tblEmployees.EmployeeID, EmployeeName  AS EmployeeName '
      'FROM tblEmployees '
      'WHERE (((tblEmployees.Active)<>'#39'F'#39')) '
      'ORDER BY EmployeeName;')
    AutoCalcFields = False
    Options.LongStrings = False
    Left = 180
    Top = 34
    object cboEmployeeLookupEmployeeName: TWideStringField
      DisplayWidth = 30
      FieldName = 'EmployeeName'
      Size = 255
    end
    object cboEmployeeLookupEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Visible = False
    end
  end
  object qryDrivers: TERPQuery
    SQL.Strings = (
      'SELECT ContactID as DriverID,'
      
        'CONCAT_WS('#39' '#39',tblContacts.ContactFirstName,tblContacts.ContactSu' +
        'rName) as DriverName'
      'FROM tblContacts'
      'WHERE CusID = :CusID'
      'ORDER BY DriverName;')
    AutoCalcFields = False
    BeforeOpen = qryDriversBeforeOpen
    Options.LongStrings = False
    Left = 687
    Top = 224
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CusID'
      end>
    object qryDriversDriverID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'DriverID'
      Origin = 'tblContacts.DriverID'
    end
    object qryDriversDriverName: TWideStringField
      DisplayLabel = 'Driver'
      DisplayWidth = 20
      FieldName = 'DriverName'
      Origin = 'tblContacts.DriverName'
      Size = 61
    end
  end
  object tblDetails2: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * '
      'FROM tblassessmentsotherdetails'
      'WHERE AssessmentID = :xID;')
    BeforePost = tblDetails2BeforePost
    Left = 387
    Top = 65534
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object tblDetails2Label: TWideStringField
      DisplayWidth = 50
      FieldName = 'Label'
      Origin = 'tblassessmentsotherdetails.Label'
      Size = 50
    end
    object tblDetails2Result: TWideStringField
      DisplayWidth = 1
      FieldName = 'Result'
      Origin = 'tblassessmentsotherdetails.Result'
      FixedChar = True
      Size = 1
    end
    object tblDetails2AssessmentotherDetailsID: TLargeintField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'AssessmentotherDetailsID'
      Origin = 'tblassessmentsotherdetails.AssessmentotherDetailsID'
      Visible = False
    end
    object tblDetails2AssessmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'AssessmentID'
      Origin = 'tblassessmentsotherdetails.AssessmentID'
      Visible = False
    end
    object tblDetails2LabelID: TIntegerField
      DisplayWidth = 10
      FieldName = 'LabelID'
      Origin = 'tblassessmentsotherdetails.LabelID'
      Visible = False
    end
  end
  object DSDetails2: TDataSource
    DataSet = tblDetails2
    Left = 386
    Top = 17
  end
end
