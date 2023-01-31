inherited fmRewardPoint: TfmRewardPoint
  Left = 1532
  Top = 217
  HelpContext = 700000
  Caption = 'Single Product Rewards'
  ClientHeight = 472
  ClientWidth = 642
  OldCreateOrder = True
  ExplicitLeft = 1532
  ExplicitTop = 217
  ExplicitWidth = 650
  ExplicitHeight = 499
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 426
    Width = 642
    ExplicitTop = 426
    ExplicitWidth = 642
    HelpContext = 700077
  end
  object pnlProductPoints: TDNMPanel [4]
    Left = 0
    Top = 95
    Width = 642
    Height = 331
    HelpContext = 700048
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Bevel4: TBevel
      Left = 8
      Top = 7
      Width = 626
      Height = 122
      HelpContext = 700001
    end
    object Bevel3: TBevel
      Left = 8
      Top = 136
      Width = 226
      Height = 74
      HelpContext = 700002
    end
    object Bevel1: TBevel
      Left = 239
      Top = 136
      Width = 395
      Height = 74
      HelpContext = 700003
    end
    object Bevel2: TBevel
      Left = 8
      Top = 218
      Width = 626
      Height = 86
      HelpContext = 700004
    end
    object Label1: TLabel
      Left = 21
      Top = 21
      Width = 45
      Height = 15
      HelpContext = 700049
      Caption = 'Product'
      Transparent = True
    end
    object Label3: TLabel
      Left = 431
      Top = 21
      Width = 31
      Height = 15
      HelpContext = 700050
      Caption = 'Value'
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
      Left = 315
      Top = 21
      Width = 36
      Height = 15
      HelpContext = 700051
      Caption = 'Points'
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
      Left = 290
      Top = 148
      Width = 90
      Height = 15
      HelpContext = 700052
      Caption = 'Use Date Range'
      FocusControl = chkUseDate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblFrom: TLabel
      Left = 263
      Top = 177
      Width = 29
      Height = 15
      HelpContext = 700053
      Caption = 'From'
      FocusControl = dtFrom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblTo: TLabel
      Left = 465
      Top = 177
      Width = 13
      Height = 15
      HelpContext = 700054
      Caption = 'To'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel
      Left = 21
      Top = 252
      Width = 102
      Height = 15
      HelpContext = 700055
      Caption = 'Points Expires on '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 46
      Top = 228
      Width = 89
      Height = 15
      HelpContext = 700056
      Caption = 'Use Expiry Date'
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
      Left = 46
      Top = 148
      Width = 114
      Height = 15
      HelpContext = 700057
      Caption = 'Use Unit of Measure'
      FocusControl = wwCheckBox2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label9: TLabel
      Left = 161
      Top = 276
      Width = 17
      Height = 15
      HelpContext = 700058
      Caption = 'Or '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label10: TLabel
      Left = 225
      Top = 252
      Width = 251
      Height = 15
      HelpContext = 700059
      Caption = 'Expires no of months from Date of Purchase'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 23
      Top = 75
      Width = 90
      Height = 18
      HelpContext = 700060
      AutoSize = False
      Caption = 'Customer Type'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object btnProdList: TDNMSpeedButton
      Left = 540
      Top = 37
      Width = 87
      Height = 25
      HelpContext = 700061
      Caption = 'Product List'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 11
    end
    object edtValue: TwwDBEdit
      Left = 431
      Top = 38
      Width = 97
      Height = 23
      HelpContext = 700062
      DataField = 'Value'
      DataSource = dsProductPoints
      Font.Charset = ANSI_CHARSET
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
    object edtPoints: TwwDBEdit
      Left = 315
      Top = 38
      Width = 99
      Height = 23
      HelpContext = 700063
      DataField = 'Points'
      DataSource = dsProductPoints
      Font.Charset = ANSI_CHARSET
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
    object cboUnitOfMeasure: TwwDBLookupCombo
      Left = 21
      Top = 171
      Width = 180
      Height = 26
      Hint = 
        'Turn this on to track the Points for the selected unit of measur' +
        'e for this product.'
      HelpContext = 700005
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'UnitName'#9'15'#9'UnitName'#9'F'
        'Multiplier'#9'10'#9'Multiplier'#9'F')
      DataField = 'UOM'
      DataSource = dsProductPoints
      LookupTable = qryUnitOfMeasure
      LookupField = 'UnitName'
      Options = [loTitles]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboUnitOfMeasureCloseUp
      OnEnter = cboUnitOfMeasureEnter
    end
    object chkUseDate: TwwCheckBox
      Left = 263
      Top = 148
      Width = 15
      Height = 14
      Hint = 'Points will be allocated for any Purchases within this period.'
      HelpContext = 700064
      TabStop = False
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
      DataField = 'UseDate'
      DataSource = dsProductPoints
      TabOrder = 5
    end
    object dtFrom: TwwDBDateTimePicker
      Left = 315
      Top = 173
      Width = 98
      Height = 23
      Hint = 'Points will be allocated for any Purchases within this period.'
      HelpContext = 700065
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      CalendarAttributes.PopupYearOptions.NumberColumns = 4
      DataField = 'DateFrom'
      DataSource = dsProductPoints
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      MaxDate = 401769.000000000000000000
      MinDate = -363.000000000000000000
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      ShowButton = True
      TabOrder = 6
    end
    object dtTo: TwwDBDateTimePicker
      Left = 498
      Top = 173
      Width = 98
      Height = 23
      Hint = 'Points will be allocated for any Purchases within this period.'
      HelpContext = 700066
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      CalendarAttributes.PopupYearOptions.NumberColumns = 4
      DataField = 'DateTo'
      DataSource = dsProductPoints
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      MaxDate = 401769.000000000000000000
      MinDate = -363.000000000000000000
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      ShowButton = True
      TabOrder = 7
    end
    object wwDBDateTimePicker2: TwwDBDateTimePicker
      Left = 21
      Top = 272
      Width = 98
      Height = 23
      Hint = 'Allocated points will expire on this date.'
      HelpContext = 700067
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      CalendarAttributes.PopupYearOptions.NumberColumns = 4
      DataField = 'RewardPointExpiresOn'
      DataSource = dsProductPoints
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      MaxDate = 401769.000000000000000000
      MinDate = -363.000000000000000000
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      ShowButton = True
      TabOrder = 9
    end
    object wwCheckBox2: TwwCheckBox
      Left = 21
      Top = 148
      Width = 15
      Height = 14
      Hint = 
        'Turn this on to track the Points for the selected unit of measur' +
        'e for this product.'
      HelpContext = 700068
      TabStop = False
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
      DataField = 'UseUOM'
      DataSource = dsProductPoints
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnExit = wwCheckBox2Exit
    end
    object edtExpiresOnNoOfMonthsAfterPurchase: TwwDBEdit
      Left = 225
      Top = 272
      Width = 99
      Height = 23
      HelpContext = 700069
      DataField = 'ExpiresOnNoOfMonthsAfterPurchase'
      DataSource = dsProductPoints
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBLookupCombo1: TwwDBLookupCombo
      Left = 21
      Top = 38
      Width = 286
      Height = 23
      HelpContext = 700006
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      DataField = 'Partname'
      DataSource = dsProductPoints
      LookupTable = QryParts
      LookupField = 'PartName'
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = wwDBLookupCombo1CloseUp
    end
    object chkDiscontinued: TwwCheckBox
      Left = 21
      Top = 228
      Width = 15
      Height = 14
      HelpContext = 700070
      TabStop = False
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
      Caption = 'chkDiscontinued'
      DataField = 'UseExpiryDate'
      DataSource = dsProductPoints
      TabOrder = 8
    end
    object cboClientType: TwwDBLookupCombo
      Left = 21
      Top = 97
      Width = 188
      Height = 23
      HelpContext = 700071
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'TypeName'#9'25'#9'TypeName'#9'F')
      DataField = 'ClientTypeID'
      DataSource = dsProductPoints
      LookupTable = qryClientTypes
      LookupField = 'ClientTypeID'
      Options = [loColLines, loTitles]
      ParentFont = False
      TabOrder = 12
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
  end
  object pnlTop: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 642
    Height = 95
    HelpContext = 700072
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object btnGenerateBins: TDNMSpeedButton
      Left = 544
      Top = 63
      Width = 87
      Height = 27
      HelpContext = 700073
      Caption = 'Multiple'
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
      TabOrder = 0
      OnClick = btnGenerateBinsClick
    end
    object pnlTitle: TDNMPanel
      Left = 92
      Top = 6
      Width = 456
      Height = 45
      HelpContext = 700074
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 452
        Height = 41
        HelpContext = 700075
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
          Width = 452
          Height = 41
          HelpContext = 700076
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Single Product Loyalty Rewards'
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
  object pnlBottom: TDNMPanel [6]
    Left = 0
    Top = 426
    Width = 642
    Height = 46
    HelpContext = 700044
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      642
      46)
    object Label50: TLabel
      Left = 596
      Top = 7
      Width = 38
      Height = 17
      HelpContext = 700045
      Anchors = [akTop, akRight]
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
    object btnMail: TDNMSpeedButton
      Left = 208
      Top = 11
      Width = 87
      Height = 27
      HelpContext = 700046
      Anchors = []
      Caption = '&Mail...'
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
        3333333333333333333333333333333333333FFFFFFFFFFFFFFF000000000000
        000077777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
        FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF777777F
        FFF07F33377777733FF70FFFFFFFFFFF99907F3FFF33333377770F777FFFFFFF
        9CA07F77733333337F370FFFFFFFFFFF9A907FFFFFFFFFFF7FF7000000000000
        0000777777777777777733333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      TabStop = False
      OnClick = btnMailClick
    end
    object btnSave: TDNMSpeedButton
      Left = 78
      Top = 11
      Width = 87
      Height = 27
      HelpContext = 700007
      Action = actMainSave
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
      TabOrder = 0
    end
    object btnNew: TDNMSpeedButton
      Left = 338
      Top = 11
      Width = 87
      Height = 27
      HelpContext = 700008
      Action = actMainNew
      Anchors = [akBottom]
      Caption = '&New'
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
      TabOrder = 2
    end
    object btnCancel: TDNMSpeedButton
      Left = 469
      Top = 11
      Width = 87
      Height = 27
      HelpContext = 700009
      Action = actMainCancel
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
      TabOrder = 3
    end
    object wwCheckBox1: TwwCheckBox
      Left = 605
      Top = 24
      Width = 15
      Height = 14
      HelpContext = 700047
      TabStop = False
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
      Anchors = []
      Caption = 'chkDiscontinued'
      DataField = 'Active'
      DataSource = dsProductPoints
      TabOrder = 4
    end
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 337
    Top = 65533
  end
  inherited dlgReportSelect: TSelectionDialog
    Top = 65533
  end
  inherited MyConnection: TERPConnection
    Left = 384
    Top = 65533
  end
  inherited DataState: TDataState
    Left = 55
    Top = 65533
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    HelpContext = 700014
    Left = 431
    Top = 65533
  end
  inherited imgsort: TImageList
    Left = 102
    Top = 65533
    Bitmap = {
      494C010102001400140010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryProductPoints: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PP.*'
      'FROM tblProductREwardPoints PP')
    Left = 196
    Top = 65533
    object qryProductPointsProductRewardPointsId: TIntegerField
      FieldName = 'ProductRewardPointsId'
    end
    object qryProductPointsPartsId: TIntegerField
      FieldName = 'PartsId'
    end
    object qryProductPointsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryProductPointsPoints: TFloatField
      FieldName = 'Points'
    end
    object qryProductPointsValue: TFloatField
      FieldName = 'Value'
      DisplayFormat = '"$"####,###,###,##0.00'
    end
    object qryProductPointsUseDate: TWideStringField
      FieldName = 'UseDate'
      FixedChar = True
      Size = 1
    end
    object qryProductPointsDateFrom: TDateField
      FieldName = 'DateFrom'
    end
    object qryProductPointsDateTo: TDateField
      FieldName = 'DateTo'
    end
    object qryProductPointsActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryProductPointsDateCreated: TDateTimeField
      FieldName = 'DateCreated'
    end
    object qryProductPointsUseExpiryDate: TWideStringField
      FieldName = 'UseExpiryDate'
      FixedChar = True
      Size = 1
    end
    object qryProductPointsRewardPointExpiresOn: TDateField
      FieldName = 'RewardPointExpiresOn'
    end
    object qryProductPointsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryProductPointsPartname: TWideStringField
      FieldName = 'Partname'
      Size = 100
    end
    object qryProductPointsUOMID: TIntegerField
      FieldName = 'UOMID'
    end
    object qryProductPointsUOM: TWideStringField
      FieldName = 'UOM'
      Size = 60
    end
    object qryProductPointsUseUOM: TWideStringField
      FieldName = 'UseUOM'
      FixedChar = True
      Size = 1
    end
    object qryProductPointsUOMMultiplier: TFloatField
      FieldName = 'UOMMultiplier'
    end
    object qryProductPointsExpiresOnNoOfMonthsAfterPurchase: TIntegerField
      FieldName = 'ExpiresOnNoOfMonthsAfterPurchase'
    end
    object qryProductPointsClientTypeID: TLargeintField
      FieldName = 'ClientTypeID'
    end
  end
  object dsProductPoints: TDataSource
    DataSet = qryProductPoints
    Left = 290
    Top = 65533
  end
  object alMain: TActionList
    Left = 149
    Top = 65533
    object actMainSave: TAction
      Caption = '&Save'
      HelpContext = 700039
      OnExecute = actMainSaveExecute
    end
    object actMainNew: TAction
      Caption = '&New'
      HelpContext = 700040
      OnExecute = actMainNewExecute
    end
    object actMainCancel: TAction
      Caption = '&Cancel'
      HelpContext = 700041
      OnExecute = actMainCancelExecute
    end
    object actProductList: TAction
      Caption = 'Product List'
      HelpContext = 700042
      OnExecute = actProductListExecute
    end
    object actProduct: TAction
      Caption = 'Product'
      HelpContext = 700043
      OnExecute = actProductExecute
    end
  end
  object qryUnitOfMeasure: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      '/*SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND (ifnull(U.PartID,0) = :xPartID or U.Pa' +
        'rtID = 0) '
      'Group By U.UnitName Desc'
      'Order By UnitID desc ,U.UnitName'
      '*/'
      'SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = :xPartID'
      'union all '
      'SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = 0 and Unitname no' +
        't  in (Select unitname from  tblunitsofmeasure where  ifnull(Par' +
        'tID,0) = :xPartID  )'
      'Order By UnitID desc ,UnitName;')
    Left = 243
    Top = 65533
    ParamData = <
      item
        DataType = ftInteger
        Name = 'xPartID'
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'xPartID'
        Value = 0
      end>
    object qryUnitOfMeasureUnitID: TIntegerField
      FieldName = 'UnitID'
    end
    object qryUnitOfMeasureUnitName: TWideStringField
      FieldName = 'UnitName'
      Size = 15
    end
    object qryUnitOfMeasureUnitDescription: TWideStringField
      FieldName = 'UnitDescription'
      Size = 35
    end
    object qryUnitOfMeasureMultiplier: TFloatField
      FieldName = 'Multiplier'
    end
    object qryUnitOfMeasureBaseUnitName: TWideStringField
      FieldName = 'BaseUnitName'
      Size = 15
    end
  end
  object QryParts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select PartsId, PartName From tblParts order by Partname')
    Left = 479
    Top = 65533
    object QryPartsPartsId: TIntegerField
      FieldName = 'PartsId'
    end
    object QryPartsPartName: TWideStringField
      FieldName = 'PartName'
      Size = 60
    end
  end
  object qryClientTypes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT TypeName, TypeDescription , TermsID, CreditLimit,'
      'GracePeriod, ClientTypeID'
      'FROM tblClientType'
      'WHERE Active = '#39'T'#39
      'Order By TypeName;')
    Options.LongStrings = False
    Left = 530
    Top = 1
  end
end
