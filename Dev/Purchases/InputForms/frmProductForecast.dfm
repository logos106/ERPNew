inherited ProductForecastGUI: TProductForecastGUI
  Left = 677
  Top = 112
  HelpContext = 442000
  Caption = 'Product Forecast Formula'
  ClientHeight = 601
  ClientWidth = 699
  OldCreateOrder = True
  ExplicitLeft = 677
  ExplicitTop = 112
  ExplicitWidth = 715
  ExplicitHeight = 640
  DesignSize = (
    699
    601)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 551
    Width = 699
    HelpContext = 442030
    ExplicitTop = 324
    ExplicitWidth = 601
  end
  inherited shapehint: TShape
    Left = 12
    ExplicitLeft = 30
  end
  inherited imgGridWatermark: TImage
    Left = 355
    Top = 61
    Width = 38
    HelpContext = 442001
    ExplicitLeft = 355
    ExplicitTop = 61
    ExplicitWidth = 38
  end
  inherited shapehintextra1: TShape
    Left = 65
    ExplicitLeft = 117
  end
  object pnlHistory: TDNMPanel [5]
    AlignWithMargins = True
    Left = 3
    Top = 198
    Width = 693
    Height = 197
    HelpContext = 442031
    Margins.Top = 1
    Margins.Bottom = 1
    Align = alTop
    BevelKind = bkFlat
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    TabStop = True
    object chkUseReorderAmount: TwwCheckBox
      Left = 7
      Top = 174
      Width = 198
      Height = 17
      HelpContext = 442015
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
      Caption = 'Use Reorder Amt For Rounding'
      DataField = 'UseReorderAmount'
      DataSource = dsMain
      TabOrder = 3
      OnClick = DelayedPreviewForProductEvent
    end
    object gbHistory: TAdvGroupBox
      Left = 215
      Top = 4
      Width = 458
      Height = 138
      HelpContext = 442032
      BorderColor = clGray
      Caption = 'Historical Data'
      TabOrder = 4
      TabStop = True
      object lblFromDate: TLabel
        Left = 6
        Top = 116
        Width = 70
        Height = 15
        HelpContext = 442004
        Caption = 'From Month:'
        Transparent = True
      end
      object lblToDate: TLabel
        Left = 237
        Top = 116
        Width = 54
        Height = 15
        HelpContext = 442005
        Caption = 'To Month:'
        Transparent = True
      end
      object Bevel2: TBevel
        Left = 2
        Top = 49
        Width = 454
        Height = 31
        HelpContext = 442033
        Align = alTop
        Shape = bsBottomLine
      end
      object Bevel4: TBevel
        Left = 2
        Top = 80
        Width = 454
        Height = 31
        HelpContext = 442034
        Align = alTop
        Shape = bsBottomLine
        ExplicitLeft = 140
        ExplicitWidth = 316
      end
      object Bevel5: TBevel
        Left = 2
        Top = 18
        Width = 454
        Height = 31
        HelpContext = 442035
        Align = alTop
        Shape = bsBottomLine
      end
      object chkQuotes: TwwCheckBox
        Left = 6
        Top = 25
        Width = 65
        Height = 17
        HelpContext = 442016
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
        Caption = 'Quotes'
        DataField = 'Quotes'
        DataSource = dsMain
        TabOrder = 0
        OnClick = DelayedPreviewForProductEvent
      end
      object chkSalesOrders: TwwCheckBox
        Left = 155
        Top = 25
        Width = 97
        Height = 17
        HelpContext = 442017
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
        Caption = 'Sales Orders'
        DataField = 'SalesOrders'
        DataSource = dsMain
        TabOrder = 1
        OnClick = DelayedPreviewForProductEvent
      end
      object chkInvoices: TwwCheckBox
        Left = 305
        Top = 25
        Width = 97
        Height = 17
        HelpContext = 442018
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
        Caption = 'Sales History'
        DataField = 'Invoices'
        DataSource = dsMain
        TabOrder = 2
        OnClick = DelayedPreviewForProductEvent
      end
      object dtFromDate: TwwDBDateTimePicker
        Left = 86
        Top = 112
        Width = 107
        Height = 23
        HelpContext = 442019
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'DateFrom'
        DataSource = dsMain
        Epoch = 1950
        ShowButton = True
        TabOrder = 8
        DisplayFormat = 'MMM yyyy'
        OnCloseUp = DelayedPreviewForProductEvent
        OnChange = dtFromDateChange
        OnKeyDown = dtFromDateKeyDown
      end
      object dtToDate: TwwDBDateTimePicker
        Left = 305
        Top = 112
        Width = 107
        Height = 23
        HelpContext = 442020
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'DateTo'
        DataSource = dsMain
        Epoch = 1950
        ShowButton = True
        TabOrder = 9
        DisplayFormat = 'MMM yyyy'
        OnCloseUp = DelayedPreviewForProductEvent
        OnChange = dtToDateChange
        OnKeyDown = dtFromDateKeyDown
      end
      object rbUseAvgDailySales: TRadioButton
        Left = 6
        Top = 85
        Width = 109
        Height = 17
        HelpContext = 442036
        Caption = 'Avg Daily Sales'
        Checked = True
        TabOrder = 3
        TabStop = True
        Visible = False
        OnClick = rbUseAvgDailySalesClick
      end
      object rbUseAvgMonthlySales: TRadioButton
        Left = 155
        Top = 86
        Width = 123
        Height = 17
        HelpContext = 442037
        Caption = 'Avg Monthly Sales'
        TabOrder = 4
        OnClick = rbUseAvgMonthlySalesClick
      end
      object rbUseActualMonthlySales: TRadioButton
        Left = 305
        Top = 86
        Width = 137
        Height = 17
        HelpContext = 442038
        Caption = 'Actual Monthly Sales'
        TabOrder = 5
        OnClick = rbUseActualMonthlySalesClick
      end
      object chkUseNonERPsales: TwwCheckBox
        Left = 6
        Top = 56
        Width = 198
        Height = 17
        HelpContext = 442039
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
        Caption = 'Use Non ERP Sales'
        DataField = 'UseNonERPsales'
        DataSource = dsMain
        TabOrder = 6
      end
      object btnFromPeriodSales: TDNMSpeedButton
        AlignWithMargins = True
        Left = 422
        Top = 114
        Width = 23
        Height = 19
        Hint = 'Report'
        Margins.Left = 0
        Margins.Right = 11
        Align = alRight
        Caption = 'btnFromPeriodSales'
        DisableTransparent = False
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDAD4D0A0836881614561
          6D9D6F4324916339AC9784F0EFEEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FDFDFDB8957AA25008AE55048C5B355679C7814521AD5504A14F069A5519CCC0
          B7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB08765A45005B35706BA5906945F3456
          79C7884822B85906B05602A14F06904809C9BDB4FFFFFFFFFFFFFFFFFFC6B7AB
          AD8157C1A284C5A484C7A584B9A795A3B1CBB59F8EC2A181C3A484C0A385AC7F
          54894C16ECEBEAFFFFFFFFFFFF9D612FBFA388CCCFCDC1C4C2AFB2B0A0A3A199
          9C9AA4A7A5A2A5A3BEC1BFD0D3D1BEA2858B4404AA927FFFFFFFDFDBD9914705
          B5997CC1C4C2D5D8D6D7DAD8D6D9D7D5D9D7D1D4D2B7BBB9C3C6C4CACDCBB599
          7B8E460288572EFFFFFFC2B8B0914703AE9174BDC1BFD8DBD9DDE0DEE4E7E5D8
          DBD9D3D6D95D65AA979CB9C9CDCBAE93758D4602733A08FAFAFABFB5AD8C4504
          B09579CDD0CEE8EBE9E5E8E6E0E3E1E8EBE9B3B8D700119B505CBCD8DBD9AF94
          778943056C3504F3F2F2CDC7C2824004B59C82E3E6E4F0F4F1F0F4F1F3F7F4F3
          F7F4F2F6F4636DC1D7DBEAE8EBE9B1987E803F046E3F17FFFFFFF5F5F57A410E
          A68F78DBDEDCE5E8E6E6E9E7E6E9E7E6E9E7E6E9E77D85C3E5E8E7E1E4E2A58E
          76733903886B54FFFFFFFFFFFF9D836D98846FE1E4E2E1E4E2E1E4E2E1E4E2E1
          E4E2E1E4E2737AB8E0E3E2E3E6E497836D603003C8C2BEFFFFFFFFFFFFEDECEC
          7149286F3E0F7A4311814710854910864A13844A13251F6C77430E6D3D0F5F33
          0B866F5BFFFFFFFFFFFFFFFFFFFFFFFFDAD6D46C421D6D3603773C037C3E017E
          3F01793D020E13826B36045C2E03785F49F7F7F7FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFEBEAEA8D77635B30085F2F036131035D2F050B12825C391AA49A90FDFD
          FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F1F1BFB9B5A6
          9D96ABA29CCCC9C8FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        NumGlyphs = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnClick = btnFromPeriodSalesClick
        HelpContext = 442073
      end
    end
    object AdvGroupBox2: TAdvGroupBox
      Left = 215
      Top = 146
      Width = 458
      Height = 45
      HelpContext = 442040
      BorderColor = clGray
      Caption = 'Apply To'
      TabOrder = 5
      object Label2: TLabel
        Left = 10
        Top = 23
        Width = 70
        Height = 15
        HelpContext = 442041
        Caption = 'From Month:'
        Transparent = True
      end
      object Label3: TLabel
        Left = 237
        Top = 23
        Width = 54
        Height = 15
        HelpContext = 442042
        Caption = 'To Month:'
        Transparent = True
      end
      object dtApplyToFrom: TwwDBDateTimePicker
        Left = 86
        Top = 19
        Width = 107
        Height = 23
        HelpContext = 442043
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'Tahoma'
        CalendarAttributes.Font.Style = []
        Date = 42681.000000000000000000
        Epoch = 1950
        Time = 0.406545682868454600
        ShowButton = True
        TabOrder = 0
        DisplayFormat = 'MMM yyyy'
        OnChange = dtApplyToFromChange
      end
      object dtApplyToTo: TwwDBDateTimePicker
        Left = 305
        Top = 19
        Width = 107
        Height = 23
        HelpContext = 442044
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'Tahoma'
        CalendarAttributes.Font.Style = []
        Date = 42681.000000000000000000
        Epoch = 1950
        Time = 0.406545682868454600
        ShowButton = True
        TabOrder = 1
        DisplayFormat = 'MMM yyyy'
        OnChange = dtApplyToToChange
      end
    end
    object gbFormula: TGroupBox
      Left = 7
      Top = 61
      Width = 201
      Height = 81
      HelpContext = 442045
      Caption = 'Formula'
      TabOrder = 2
      object txtFormula: TwwDBEdit
        Left = 8
        Top = 22
        Width = 162
        Height = 23
        HelpContext = 442021
        DataField = 'Formula'
        DataSource = dsMain
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object btnFormulaHelp: TDNMSpeedButton
        Tag = 7
        Left = 174
        Top = 22
        Width = 24
        Height = 23
        HelpContext = 442028
        Caption = '?'
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
        TabOrder = 1
        OnClick = btnFormulaHelpClick
      end
      object btnValidate: TDNMSpeedButton
        Left = 8
        Top = 52
        Width = 80
        Height = 25
        HelpContext = 442029
        Caption = '&Validate'
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
        TabOrder = 2
        OnClick = btnValidateClick
      end
    end
    object chkUseFormula: TwwCheckBox
      Left = 7
      Top = 31
      Width = 159
      Height = 17
      HelpContext = 442046
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
      Caption = 'Use Formula'
      DataField = 'UseFormula'
      DataSource = dsMain
      TabOrder = 1
      OnClick = chkUseFormulaClick
    end
    object chkUseHistory: TwwCheckBox
      Left = 7
      Top = 3
      Width = 198
      Height = 17
      HelpContext = 442047
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
      Caption = 'Use Historical Data'
      DataField = 'UseHistoryData'
      DataSource = dsMain
      TabOrder = 0
      OnClick = chkUseHistoryClick
    end
    object chkUseAvailQty: TwwCheckBox
      Left = 7
      Top = 145
      Width = 198
      Height = 17
      HelpContext = 442048
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
      Caption = 'Use Avail. Qty In Smart Orders'
      DataField = 'UseAvailQty'
      DataSource = dsMain
      TabOrder = 6
      OnClick = DelayedPreviewForProductEvent
    end
  end
  object pnlLevels: TDNMPanel [6]
    AlignWithMargins = True
    Left = 3
    Top = 397
    Width = 693
    Height = 152
    HelpContext = 442049
    Margins.Top = 1
    Margins.Bottom = 1
    Align = alTop
    BevelKind = bkFlat
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object lblDescription: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 681
      Height = 37
      HelpContext = 442050
      Align = alTop
      AutoSize = False
      Caption = 
        'This Section Will Adjust the Re-Order Levels. When You Select "S' +
        'tart" on The "Auto Re-Order" Screen,These Levels Will Be Used To' +
        ' Make Smart Orders'
      Layout = tlCenter
      WordWrap = True
      ExplicitWidth = 671
    end
    object Bevel3: TBevel
      AlignWithMargins = True
      Left = 4
      Top = 47
      Width = 681
      Height = 2
      HelpContext = 442051
      Margins.Bottom = 0
      Align = alTop
      ExplicitTop = 38
      ExplicitWidth = 671
    end
    object btnReorderPoint: TDNMSpeedButton
      Left = 10
      Top = 60
      Width = 108
      Height = 45
      HelpContext = 442052
      Caption = 'ReorderPoint     %'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 0
      WordWrap = True
      OnClick = btnReorderPointClick
    end
    object btnPreferredLevel: TDNMSpeedButton
      Left = 143
      Top = 60
      Width = 108
      Height = 45
      HelpContext = 442053
      Caption = 'PreferredLevel  %'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 2
      WordWrap = True
      OnClick = btnPreferredLevelClick
    end
    object btnReorderAmount: TDNMSpeedButton
      Left = 276
      Top = 60
      Width = 108
      Height = 45
      HelpContext = 442054
      Caption = 'ReorderAmount %'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 4
      WordWrap = True
      OnClick = btnReorderAmountClick
    end
    object spReorderAmount: TSpinEdit
      Left = 306
      Top = 111
      Width = 49
      Height = 24
      HelpContext = 442055
      MaxValue = 0
      MinValue = 0
      TabOrder = 5
      Value = 0
    end
    object spPreferredLevel: TSpinEdit
      Left = 173
      Top = 111
      Width = 49
      Height = 24
      HelpContext = 442056
      MaxValue = 0
      MinValue = 0
      TabOrder = 3
      Value = 0
    end
    object spReorderPoint: TSpinEdit
      Left = 40
      Top = 111
      Width = 49
      Height = 24
      HelpContext = 442057
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
    object DNMPanel3: TDNMPanel
      Left = 405
      Top = 49
      Width = 283
      Height = 98
      HelpContext = 442058
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      object lblMonth: TLabel
        AlignWithMargins = True
        Left = 133
        Top = 9
        Width = 18
        Height = 15
        HelpContext = 442006
        Margins.Top = 5
        Margins.Right = 222
        Margins.Bottom = 5
        Caption = 'For'
        Transparent = True
      end
      object lblRounding: TLabel
        Left = 10
        Top = 73
        Width = 141
        Height = 15
        HelpContext = 442059
        Alignment = taRightJustify
        Caption = 'Rounding To The Nearest'
        Transparent = True
        WordWrap = True
      end
      object chkDoRound: TCheckBox
        Left = 27
        Top = 41
        Width = 152
        Height = 15
        HelpContext = 442060
        Alignment = taLeftJustify
        Caption = 'Round Reorder Points'
        TabOrder = 1
        OnClick = chkDoRoundClick
      end
      object cbRounding: TComboBox
        Left = 166
        Top = 69
        Width = 113
        Height = 23
        HelpContext = 442061
        TabOrder = 2
        Text = '0 : No Rounding'
      end
      object cbMonth: TComboBox
        Left = 166
        Top = 5
        Width = 117
        Height = 23
        HelpContext = 442062
        TabOrder = 0
        Text = 'cbMonth'
      end
    end
  end
  object rgApplyTo: TRadioGroup [7]
    AlignWithMargins = True
    Left = 3
    Top = 56
    Width = 693
    Height = 47
    HelpContext = 442063
    Margins.Top = 1
    Margins.Bottom = 1
    Align = alTop
    Caption = 'Apply To'
    Columns = 3
    Items.Strings = (
      'Reorder Points'
      'Smart Order'
      'Do Both')
    TabOrder = 1
    TabStop = True
    OnClick = rgApplyToClick
  end
  object pnlProducts: TDNMPanel [8]
    AlignWithMargins = True
    Left = 3
    Top = 105
    Width = 693
    Height = 91
    HelpContext = 442064
    Margins.Top = 1
    Margins.Bottom = 1
    Align = alTop
    BevelKind = bkFlat
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    TabStop = True
    object rgProducts: TRadioGroup
      Left = 3
      Top = 6
      Width = 167
      Height = 77
      HelpContext = 442065
      Caption = 'Apply To'
      Items.Strings = (
        'All Products'
        'Selected Products')
      TabOrder = 0
      TabStop = True
    end
    object rgDepartments: TRadioGroup
      Left = 280
      Top = 7
      Width = 393
      Height = 41
      HelpContext = 442066
      Caption = 'Apply To'
      Columns = 2
      Items.Strings = (
        'All Departments'
        'Selected Department')
      TabOrder = 2
      TabStop = True
      OnClick = rgDepartmentsClick
    end
    object cbDepartments: TCheckComboBox
      Left = 280
      Top = 54
      Width = 393
      Height = 22
      HelpContext = 442067
      AutoComplete = False
      TabOrder = 3
      Text = 'Departments'
    end
    object btnProdList: TDNMSpeedButton
      Left = 176
      Top = 54
      Width = 87
      Height = 22
      HelpContext = 442068
      Caption = '&Product List'
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
      TabOrder = 1
      OnClick = btnProdListClick
    end
  end
  object pnlButtons: TDNMPanel [9]
    Left = 0
    Top = 551
    Width = 699
    Height = 50
    HelpContext = 442069
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    DesignSize = (
      699
      50)
    object btnHowTo: TDNMSpeedButton
      Left = 360
      Top = 11
      Width = 100
      Height = 27
      HelpContext = 442070
      Anchors = [akBottom]
      Caption = 'How To'
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
      OnClick = btnHowToClick
    end
    object btnOk: TDNMSpeedButton
      Left = 114
      Top = 11
      Width = 100
      Height = 27
      HelpContext = 442024
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
      OnClick = btnOkClick
    end
    object cmdClose: TDNMSpeedButton
      Left = 484
      Top = 11
      Width = 100
      Height = 27
      HelpContext = 442025
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
      TabOrder = 2
      OnClick = cmdCloseClick
    end
    object btnReorderLevels: TDNMSpeedButton
      Left = 237
      Top = 11
      Width = 100
      Height = 27
      HelpContext = 442071
      Caption = '&Reorder Lvls'
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
      TabOrder = 3
      TabStop = False
      OnClick = btnReorderLevelsClick
    end
  end
  object pnlCaption: TDNMPanel [10]
    Left = 0
    Top = 0
    Width = 699
    Height = 55
    HelpContext = 442072
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      699
      55)
    object pnlTitle: TDNMPanel
      Left = 132
      Top = 5
      Width = 436
      Height = 45
      HelpContext = 442012
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
        Width = 432
        Height = 41
        HelpContext = 442013
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
          Width = 432
          Height = 41
          HelpContext = 442014
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Product Forecast Formula'
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
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102004801740210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryMain: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblproductforecastformula')
    AfterOpen = qryMainAfterOpen
    Left = 40
    Top = 8
  end
  object dsMain: TDataSource
    DataSet = qryMain
    Left = 96
    Top = 32
  end
  object qryDepartment: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT ClassID, ClassName FROM tblClass WHERE Active = "T" order' +
        ' by ClassId')
    Left = 600
    Top = 152
    object qryDepartmentClassName: TWideStringField
      DisplayWidth = 60
      FieldName = 'ClassName'
      Origin = 'tblClass.ClassName'
      Size = 60
    end
    object qryDepartmentClassID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ClassID'
      Origin = 'tblClass.ClassID'
      Visible = False
    end
  end
end
