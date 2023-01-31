inherited SalesPrefsGUI: TSalesPrefsGUI
  Left = 100
  Top = 100
  HelpContext = 484000
  Caption = 'Sales Preferences'
  ClientHeight = 861
  ClientWidth = 1084
  ExplicitLeft = 100
  ExplicitTop = 100
  ExplicitWidth = 1100
  ExplicitHeight = 900
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 861
    Width = 1084
    HelpContext = 484222
    ExplicitTop = 1002
    ExplicitWidth = 1072
  end
  object lblWidth: TLabel [1]
    Left = 117
    Top = 8
    Width = 863
    Height = 22
    HelpContext = 484001
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
    Width = 1084
    Height = 861
    HelpContext = 484427
    VertScrollBar.Position = 3498
    ExplicitWidth = 1348
    ExplicitHeight = 1026
    object DNMPanel23: TDNMPanel
      Left = 0
      Top = -3498
      Width = 1065
      Height = 160
      HelpContext = 484406
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Bevel28: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 146
        HelpContext = 484407
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 65
      end
      object Label2: TLabel
        Left = 14
        Top = 14
        Width = 100
        Height = 15
        HelpContext = 484408
        Caption = 'Shipping Address'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox16: TwwCheckBox
        Left = 21
        Top = 40
        Width = 444
        Height = 17
        HelpContext = 484352
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
        Caption = 'Auto Load Customer Name in the New Shipping Address'
        Checked = True
        DataField = 'LoadCustnameinNewshippingAddress'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 0
      end
      object wwCheckBox18: TwwCheckBox
        Left = 21
        Top = 69
        Width = 444
        Height = 17
        HelpContext = 484412
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
        Caption = 'Display contact Name in Shipping Address'
        Checked = True
        DataField = 'IncludeContactNameInSalesshippingAddress'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 1
      end
      object wwCheckBox63: TwwCheckBox
        Left = 21
        Top = 98
        Width = 444
        Height = 17
        HelpContext = 484413
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
        Caption = 'Display contact Phone Number in Shipping Address'
        Checked = True
        DataField = 'IncludeContactPhoneInSalesshippingAddress'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 2
      end
      object chkIncludeContactNameInSalesBillingAddress: TwwCheckBox
        Left = 21
        Top = 127
        Width = 444
        Height = 17
        HelpContext = 484414
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
        Caption = 'Display Contact Name in Billing Address'
        Checked = True
        DataField = 'IncludeContactNameInSalesBillingAddress'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 3
      end
    end
    object DNMPanel8: TDNMPanel
      Left = 0
      Top = -587
      Width = 1065
      Height = 318
      HelpContext = 484387
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Bevel8: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 304
        HelpContext = 484388
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 14
        ExplicitTop = 164
        ExplicitWidth = 531
        ExplicitHeight = 232
      end
      object Bevel27: TBevel
        AlignWithMargins = True
        Left = 38
        Top = 91
        Width = 345
        Height = 136
        HelpContext = 484389
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Shape = bsFrame
      end
      object Bevel26: TBevel
        AlignWithMargins = True
        Left = 39
        Top = 38
        Width = 345
        Height = 48
        HelpContext = 484390
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Shape = bsFrame
      end
      object Label3: TLabel
        Left = 14
        Top = 14
        Width = 92
        Height = 15
        HelpContext = 484391
        Caption = 'Customer Types'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label4: TLabel
        Left = 99
        Top = 53
        Width = 32
        Height = 15
        HelpContext = 484392
        Caption = 'Retail'
        Transparent = True
      end
      object Label5: TLabel
        Left = 59
        Top = 104
        Width = 72
        Height = 15
        HelpContext = 484393
        Caption = 'Wholesalers'
        Transparent = True
      end
      object wwDBLookupCombo6: TwwDBLookupCombo
        Left = 141
        Top = 197
        Width = 225
        Height = 23
        HelpContext = 484394
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ControlType.Strings = (
          'Active;CheckBox;T;F')
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'typename'#9'50'#9'Name'#9'F'
          'Active'#9'1'#9'Active'#9'F')
        DataField = 'WholeSaleCustomerType4'
        DataSource = dsPrefs
        LookupTable = qryclienttypeLookup
        LookupField = 'typename'
        ParentFont = False
        TabOrder = 0
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo5: TwwDBLookupCombo
        Left = 141
        Top = 132
        Width = 225
        Height = 23
        HelpContext = 484395
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ControlType.Strings = (
          'Active;CheckBox;T;F')
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'typename'#9'50'#9'Name'#9'F'
          'Active'#9'1'#9'Active'#9'F')
        DataField = 'WholeSaleCustomerType2'
        DataSource = dsPrefs
        LookupTable = qryclienttypeLookup
        LookupField = 'typename'
        ParentFont = False
        TabOrder = 1
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo7: TwwDBLookupCombo
        Left = 141
        Top = 164
        Width = 225
        Height = 23
        HelpContext = 484396
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ControlType.Strings = (
          'Active;CheckBox;T;F')
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'typename'#9'50'#9'Name'#9'F'
          'Active'#9'1'#9'Active'#9'F')
        DataField = 'WholeSaleCustomerType3'
        DataSource = dsPrefs
        LookupTable = qryclienttypeLookup
        LookupField = 'typename'
        ParentFont = False
        TabOrder = 2
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object cboWholeSaleCustomerType1: TwwDBLookupCombo
        Left = 141
        Top = 100
        Width = 225
        Height = 23
        HelpContext = 484397
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ControlType.Strings = (
          'Active;CheckBox;T;F')
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'typename'#9'50'#9'Name'#9'F'
          'Active'#9'1'#9'Active'#9'F')
        DataField = 'WholeSaleCustomerType1'
        DataSource = dsPrefs
        LookupTable = qryclienttypeLookup
        LookupField = 'typename'
        ParentFont = False
        TabOrder = 3
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object cboRetailcustomerType1: TwwDBLookupCombo
        Left = 141
        Top = 50
        Width = 225
        Height = 23
        HelpContext = 484398
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ControlType.Strings = (
          'Active;CheckBox;T;F')
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'typename'#9'50'#9'Name'#9'F'
          'Active'#9'1'#9'Active'#9'F')
        DataField = 'RetailcustomerType1'
        DataSource = dsPrefs
        LookupTable = qryclienttypeLookup
        LookupField = 'typename'
        ParentFont = False
        TabOrder = 4
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object chkHideCustomertypeNotSelectedinSalesCatgbyItemReport: TDBCheckBox
        Left = 24
        Top = 232
        Width = 704
        Height = 79
        HelpContext = 484422
        Caption = 
          'Sales Category By Item Report  : Hide Sales of Customers of Othe' +
          'rtype in '#39'Wholesale'#39' / '#39'Retail'#39' / '#39'Combined'#39' Templates'
        DataField = 'HideCustomertypeNotSelectedinSalesCatgbyItemReport'
        DataSource = dsPrefs
        TabOrder = 5
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        WordWrap = True
      end
    end
    object DNMPanel22: TDNMPanel
      Left = 0
      Top = 498
      Width = 1065
      Height = 174
      HelpContext = 484227
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      ExplicitTop = 469
      DesignSize = (
        1065
        174)
      object Bevel29: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 160
        HelpContext = 484228
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 10
        ExplicitWidth = 529
        ExplicitHeight = 159
      end
      object Bevel30: TBevel
        Left = 40
        Top = 48
        Width = 473
        Height = 112
        HelpContext = 484229
        Anchors = [akLeft, akTop, akBottom]
        Shape = bsFrame
        ExplicitHeight = 150
      end
      object Bevel31: TBevel
        Left = 279
        Top = 46
        Width = 10
        Height = 111
        HelpContext = 484230
        Anchors = [akLeft, akTop, akBottom]
        Shape = bsLeftLine
        ExplicitHeight = 149
      end
      object Label6: TLabel
        Left = 14
        Top = 14
        Width = 112
        Height = 15
        HelpContext = 484231
        Caption = 'Row colors in Sales'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label7: TLabel
        Left = 368
        Top = 57
        Width = 92
        Height = 16
        HelpContext = 484232
        AutoSize = False
        Caption = 'Colour'
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
        Left = 236
        Top = 56
        Width = 38
        Height = 15
        HelpContext = 484233
        Caption = 'Enable'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Bevel32: TBevel
        Left = 215
        Top = 76
        Width = 286
        Height = 12
        HelpContext = 484234
        Shape = bsTopLine
      end
      object Bevel33: TBevel
        Left = 215
        Top = 48
        Width = 10
        Height = 111
        HelpContext = 484235
        Anchors = [akLeft, akTop, akBottom]
        Shape = bsLeftLine
        ExplicitHeight = 149
      end
      object Label10: TLabel
        Left = 54
        Top = 89
        Width = 149
        Height = 15
        HelpContext = 484236
        Caption = 'Container Related Product'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label11: TLabel
        Left = 74
        Top = 127
        Width = 129
        Height = 15
        HelpContext = 484237
        Caption = 'Pallet Related Product '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object chkContainerRelatedProductColour: TwwCheckBox
        Left = 247
        Top = 88
        Width = 16
        Height = 17
        HelpContext = 484238
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
        Caption = 'Enable Container Related Product Row Colors in Sales'
        DataField = 'IndicateContainerRelatedProduct'
        DataSource = dsPrefs
        TabOrder = 0
      end
      object chkPalletRelatedProductColour: TwwCheckBox
        Left = 247
        Top = 126
        Width = 16
        Height = 17
        HelpContext = 484239
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
        Caption = 'Enable Pallet Related Product Row Colors in Sales'
        DataField = 'IndicatePalletRelatedProduct'
        DataSource = dsPrefs
        TabOrder = 1
      end
      object ContainerRelatedProductColour: TAdvOfficeColorSelector
        Left = 290
        Top = 83
        Width = 26
        Height = 26
        HelpContext = 484240
        AntiAlias = aaAntiAlias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Version = '1.3.1.1'
        TabOrder = 2
        AllowFloating = False
        CloseOnSelect = True
        CaptionAppearance.BorderColor = clNone
        CaptionAppearance.Color = 13198890
        CaptionAppearance.ColorTo = clNone
        CaptionAppearance.Direction = gdHorizontal
        CaptionAppearance.TextColor = clWhite
        CaptionAppearance.TextColorHot = clBlack
        CaptionAppearance.TextColorDown = clBlack
        CaptionAppearance.ButtonAppearance.ColorChecked = 16111818
        CaptionAppearance.ButtonAppearance.ColorCheckedTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorDisabled = 15921906
        CaptionAppearance.ButtonAppearance.ColorDisabledTo = 15921906
        CaptionAppearance.ButtonAppearance.ColorDown = 16111818
        CaptionAppearance.ButtonAppearance.ColorDownTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorHot = 16117985
        CaptionAppearance.ButtonAppearance.ColorHotTo = 16372402
        CaptionAppearance.ButtonAppearance.ColorMirrorHot = 16107693
        CaptionAppearance.ButtonAppearance.ColorMirrorHotTo = 16775412
        CaptionAppearance.ButtonAppearance.ColorMirrorDown = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorDownTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorChecked = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorCheckedTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabled = 11974326
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabledTo = 15921906
        DragGripAppearance.BorderColor = clGray
        DragGripAppearance.Color = clWhite
        DragGripAppearance.ColorTo = clWhite
        DragGripAppearance.ColorMirror = clSilver
        DragGripAppearance.ColorMirrorTo = clWhite
        DragGripAppearance.Gradient = ggVertical
        DragGripAppearance.GradientMirror = ggVertical
        DragGripAppearance.BorderColorHot = clBlue
        DragGripAppearance.ColorHot = 16117985
        DragGripAppearance.ColorHotTo = 16372402
        DragGripAppearance.ColorMirrorHot = 16107693
        DragGripAppearance.ColorMirrorHotTo = 16775412
        DragGripAppearance.GradientHot = ggRadial
        DragGripAppearance.GradientMirrorHot = ggRadial
        DragGripPosition = gpTop
        Appearance.ColorChecked = 16111818
        Appearance.ColorCheckedTo = 16367008
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 16111818
        Appearance.ColorDownTo = 16367008
        Appearance.ColorHot = 16117985
        Appearance.ColorHotTo = 16372402
        Appearance.ColorMirrorHot = 16107693
        Appearance.ColorMirrorHotTo = 16775412
        Appearance.ColorMirrorDown = 16102556
        Appearance.ColorMirrorDownTo = 16768988
        Appearance.ColorMirrorChecked = 16102556
        Appearance.ColorMirrorCheckedTo = 16768988
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        SelectedColor = clNone
        ShowRGBHint = True
        ColorDropDown = 16251129
        ColorDropDownFloating = 16374724
        SelectionAppearance.ColorChecked = 16111818
        SelectionAppearance.ColorCheckedTo = 16367008
        SelectionAppearance.ColorDisabled = 15921906
        SelectionAppearance.ColorDisabledTo = 15921906
        SelectionAppearance.ColorDown = 16111818
        SelectionAppearance.ColorDownTo = 16367008
        SelectionAppearance.ColorHot = 16117985
        SelectionAppearance.ColorHotTo = 16372402
        SelectionAppearance.ColorMirrorHot = 16107693
        SelectionAppearance.ColorMirrorHotTo = 16775412
        SelectionAppearance.ColorMirrorDown = 16102556
        SelectionAppearance.ColorMirrorDownTo = 16768988
        SelectionAppearance.ColorMirrorChecked = 16102556
        SelectionAppearance.ColorMirrorCheckedTo = 16768988
        SelectionAppearance.ColorMirrorDisabled = 11974326
        SelectionAppearance.ColorMirrorDisabledTo = 15921906
        SelectionAppearance.TextColor = clBlack
        SelectionAppearance.TextColorHot = clWhite
        SelectionAppearance.TextColorDown = clWhite
        SelectionAppearance.TextColorChecked = clBlack
        SelectionAppearance.TextColorDisabled = clGray
        SelectionAppearance.Rounded = False
        Tools = <
          item
            BackGroundColor = clBlack
            Caption = 'Automatic'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'Automatic'
            Enable = True
            ItemType = itFullWidthButton
          end
          item
            BackGroundColor = clBlack
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13209
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13107
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13056
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697728
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clNavy
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3486515
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3355443
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clMaroon
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 26367
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clOlive
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGreen
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clTeal
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clBlue
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10053222
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGray
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clRed
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 39423
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52377
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6723891
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13421619
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16737843
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clPurple
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10066329
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clFuchsia
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52479
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clYellow
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clLime
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clAqua
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16763904
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697881
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clSilver
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13408767
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10079487
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10092543
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13434828
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16777164
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16764057
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16751052
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clWhite
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            Caption = 'More Colors...'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'More Colors'
            Enable = True
            ItemType = itFullWidthButton
          end>
        OnSelectColor = ContainerRelatedProductColourSelectColor
      end
      object ContainerRelatedProductGradIntensity: TAdvTrackBar
        Left = 323
        Top = 83
        Width = 160
        Height = 27
        HelpContext = 484241
        BorderColor = clBlack
        BorderColorDisabled = clBlack
        Buttons.BorderColor = clBlack
        Buttons.BorderColorHot = 10079963
        Buttons.BorderColorDown = 4548219
        Buttons.Color = 15653832
        Buttons.ColorTo = 16178633
        Buttons.ColorHot = 15465983
        Buttons.ColorHotTo = 11332863
        Buttons.ColorDown = 7778289
        Buttons.ColorDownTo = 4296947
        Buttons.ColorMirror = 15586496
        Buttons.ColorMirrorTo = 16245200
        Buttons.ColorMirrorHot = 5888767
        Buttons.ColorMirrorHotTo = 10807807
        Buttons.ColorMirrorDown = 946929
        Buttons.ColorMirrorDownTo = 5021693
        Buttons.GradientMirror = ggVertical
        ColorTo = clWhite
        ColorDisabled = clWhite
        ColorDisabledTo = clWhite
        Direction = gdHorizontal
        Color = clWhite
        Max = 240
        Slider.BorderColor = 12752500
        Slider.BorderColorDisabled = clBlack
        Slider.Color = clWhite
        Slider.ColorTo = clBlack
        Slider.ColorDisabled = clBlack
        Slider.ColorDisabledTo = clBlack
        Slider.ColorCompleted = clNone
        Slider.ColorCompletedTo = clNone
        Slider.ColorCompletedDisabled = clNone
        Slider.ColorCompletedDisabledTo = clNone
        Slider.Direction = gdHorizontal
        TabOrder = 3
        Thumb.BorderColor = 10317632
        Thumb.BorderColorHot = 10079963
        Thumb.BorderColorDown = 4548219
        Thumb.BorderColorDisabled = clBlack
        Thumb.Color = 15653832
        Thumb.ColorTo = 16178633
        Thumb.ColorDown = 7778289
        Thumb.ColorDownTo = 4296947
        Thumb.ColorHot = 15465983
        Thumb.ColorHotTo = 11332863
        Thumb.ColorDisabled = clBlack
        Thumb.ColorDisabledTo = clBlack
        Thumb.ColorMirror = 15586496
        Thumb.ColorMirrorTo = 16245200
        Thumb.ColorMirrorHot = 5888767
        Thumb.ColorMirrorHotTo = 10807807
        Thumb.ColorMirrorDown = 946929
        Thumb.ColorMirrorDownTo = 5021693
        Thumb.ColorMirrorDisabled = clBlack
        Thumb.ColorMirrorDisabledTo = clBlack
        Thumb.Gradient = ggVertical
        Thumb.GradientMirror = ggRadial
        Thumb.Shape = tsPointer
        TickMark.Color = clWhite
        TickMark.ColorDisabled = clWhite
        TickMark.Font.Charset = DEFAULT_CHARSET
        TickMark.Font.Color = clWindowText
        TickMark.Font.Height = -11
        TickMark.Font.Name = 'Tahoma'
        TickMark.Font.Style = []
        TickMark.Line3D = True
        TickMark.ShowImageAtSteps = 15
        TickMark.Spacing = 10
        TickMark.Size = 10
        TrackHint = True
        TrackLabel.Font.Charset = DEFAULT_CHARSET
        TrackLabel.Font.Color = clWindowText
        TrackLabel.Font.Height = -11
        TrackLabel.Font.Name = 'Tahoma'
        TrackLabel.Font.Style = []
        TrackLabel.Format = 'Pos: %d'
        Transparent = False
        Version = '1.6.2.0'
      end
      object PalletRelatedProductColour: TAdvOfficeColorSelector
        Left = 290
        Top = 121
        Width = 26
        Height = 26
        HelpContext = 484242
        AntiAlias = aaAntiAlias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Version = '1.3.1.1'
        TabOrder = 4
        AllowFloating = False
        CloseOnSelect = True
        CaptionAppearance.BorderColor = clNone
        CaptionAppearance.Color = 13198890
        CaptionAppearance.ColorTo = clNone
        CaptionAppearance.Direction = gdHorizontal
        CaptionAppearance.TextColor = clWhite
        CaptionAppearance.TextColorHot = clBlack
        CaptionAppearance.TextColorDown = clBlack
        CaptionAppearance.ButtonAppearance.ColorChecked = 16111818
        CaptionAppearance.ButtonAppearance.ColorCheckedTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorDisabled = 15921906
        CaptionAppearance.ButtonAppearance.ColorDisabledTo = 15921906
        CaptionAppearance.ButtonAppearance.ColorDown = 16111818
        CaptionAppearance.ButtonAppearance.ColorDownTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorHot = 16117985
        CaptionAppearance.ButtonAppearance.ColorHotTo = 16372402
        CaptionAppearance.ButtonAppearance.ColorMirrorHot = 16107693
        CaptionAppearance.ButtonAppearance.ColorMirrorHotTo = 16775412
        CaptionAppearance.ButtonAppearance.ColorMirrorDown = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorDownTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorChecked = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorCheckedTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabled = 11974326
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabledTo = 15921906
        DragGripAppearance.BorderColor = clGray
        DragGripAppearance.Color = clWhite
        DragGripAppearance.ColorTo = clWhite
        DragGripAppearance.ColorMirror = clSilver
        DragGripAppearance.ColorMirrorTo = clWhite
        DragGripAppearance.Gradient = ggVertical
        DragGripAppearance.GradientMirror = ggVertical
        DragGripAppearance.BorderColorHot = clBlue
        DragGripAppearance.ColorHot = 16117985
        DragGripAppearance.ColorHotTo = 16372402
        DragGripAppearance.ColorMirrorHot = 16107693
        DragGripAppearance.ColorMirrorHotTo = 16775412
        DragGripAppearance.GradientHot = ggRadial
        DragGripAppearance.GradientMirrorHot = ggRadial
        DragGripPosition = gpTop
        Appearance.ColorChecked = 16111818
        Appearance.ColorCheckedTo = 16367008
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 16111818
        Appearance.ColorDownTo = 16367008
        Appearance.ColorHot = 16117985
        Appearance.ColorHotTo = 16372402
        Appearance.ColorMirrorHot = 16107693
        Appearance.ColorMirrorHotTo = 16775412
        Appearance.ColorMirrorDown = 16102556
        Appearance.ColorMirrorDownTo = 16768988
        Appearance.ColorMirrorChecked = 16102556
        Appearance.ColorMirrorCheckedTo = 16768988
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        SelectedColor = clNone
        ShowRGBHint = True
        ColorDropDown = 16251129
        ColorDropDownFloating = 16374724
        SelectionAppearance.ColorChecked = 16111818
        SelectionAppearance.ColorCheckedTo = 16367008
        SelectionAppearance.ColorDisabled = 15921906
        SelectionAppearance.ColorDisabledTo = 15921906
        SelectionAppearance.ColorDown = 16111818
        SelectionAppearance.ColorDownTo = 16367008
        SelectionAppearance.ColorHot = 16117985
        SelectionAppearance.ColorHotTo = 16372402
        SelectionAppearance.ColorMirrorHot = 16107693
        SelectionAppearance.ColorMirrorHotTo = 16775412
        SelectionAppearance.ColorMirrorDown = 16102556
        SelectionAppearance.ColorMirrorDownTo = 16768988
        SelectionAppearance.ColorMirrorChecked = 16102556
        SelectionAppearance.ColorMirrorCheckedTo = 16768988
        SelectionAppearance.ColorMirrorDisabled = 11974326
        SelectionAppearance.ColorMirrorDisabledTo = 15921906
        SelectionAppearance.TextColor = clBlack
        SelectionAppearance.TextColorHot = clWhite
        SelectionAppearance.TextColorDown = clWhite
        SelectionAppearance.TextColorChecked = clBlack
        SelectionAppearance.TextColorDisabled = clGray
        SelectionAppearance.Rounded = False
        Tools = <
          item
            BackGroundColor = clBlack
            Caption = 'Automatic'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'Automatic'
            Enable = True
            ItemType = itFullWidthButton
          end
          item
            BackGroundColor = clBlack
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13209
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13107
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13056
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697728
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clNavy
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3486515
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3355443
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clMaroon
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 26367
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clOlive
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGreen
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clTeal
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clBlue
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10053222
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGray
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clRed
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 39423
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52377
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6723891
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13421619
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16737843
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clPurple
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10066329
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clFuchsia
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52479
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clYellow
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clLime
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clAqua
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16763904
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697881
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clSilver
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13408767
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10079487
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10092543
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13434828
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16777164
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16764057
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16751052
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clWhite
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            Caption = 'More Colors...'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'More Colors'
            Enable = True
            ItemType = itFullWidthButton
          end>
        OnSelectColor = PalletRelatedProductColourSelectColor
      end
      object PalletRelatedProductGradIntensity: TAdvTrackBar
        Left = 323
        Top = 121
        Width = 160
        Height = 27
        HelpContext = 484243
        BorderColor = clBlack
        BorderColorDisabled = clBlack
        Buttons.BorderColor = clBlack
        Buttons.BorderColorHot = 10079963
        Buttons.BorderColorDown = 4548219
        Buttons.Color = 15653832
        Buttons.ColorTo = 16178633
        Buttons.ColorHot = 15465983
        Buttons.ColorHotTo = 11332863
        Buttons.ColorDown = 7778289
        Buttons.ColorDownTo = 4296947
        Buttons.ColorMirror = 15586496
        Buttons.ColorMirrorTo = 16245200
        Buttons.ColorMirrorHot = 5888767
        Buttons.ColorMirrorHotTo = 10807807
        Buttons.ColorMirrorDown = 946929
        Buttons.ColorMirrorDownTo = 5021693
        Buttons.GradientMirror = ggVertical
        ColorTo = clWhite
        ColorDisabled = clWhite
        ColorDisabledTo = clWhite
        Direction = gdHorizontal
        Color = clWhite
        Max = 240
        Slider.BorderColor = 12752500
        Slider.BorderColorDisabled = clBlack
        Slider.Color = clWhite
        Slider.ColorTo = clBlack
        Slider.ColorDisabled = clBlack
        Slider.ColorDisabledTo = clBlack
        Slider.ColorCompleted = clNone
        Slider.ColorCompletedTo = clNone
        Slider.ColorCompletedDisabled = clNone
        Slider.ColorCompletedDisabledTo = clNone
        Slider.Direction = gdHorizontal
        TabOrder = 5
        Thumb.BorderColor = 10317632
        Thumb.BorderColorHot = 10079963
        Thumb.BorderColorDown = 4548219
        Thumb.BorderColorDisabled = clBlack
        Thumb.Color = 15653832
        Thumb.ColorTo = 16178633
        Thumb.ColorDown = 7778289
        Thumb.ColorDownTo = 4296947
        Thumb.ColorHot = 15465983
        Thumb.ColorHotTo = 11332863
        Thumb.ColorDisabled = clBlack
        Thumb.ColorDisabledTo = clBlack
        Thumb.ColorMirror = 15586496
        Thumb.ColorMirrorTo = 16245200
        Thumb.ColorMirrorHot = 5888767
        Thumb.ColorMirrorHotTo = 10807807
        Thumb.ColorMirrorDown = 946929
        Thumb.ColorMirrorDownTo = 5021693
        Thumb.ColorMirrorDisabled = clBlack
        Thumb.ColorMirrorDisabledTo = clBlack
        Thumb.Gradient = ggVertical
        Thumb.GradientMirror = ggRadial
        Thumb.Shape = tsPointer
        TickMark.Color = clWhite
        TickMark.ColorDisabled = clWhite
        TickMark.Font.Charset = DEFAULT_CHARSET
        TickMark.Font.Color = clWindowText
        TickMark.Font.Height = -11
        TickMark.Font.Name = 'Tahoma'
        TickMark.Font.Style = []
        TickMark.Line3D = True
        TickMark.ShowImageAtSteps = 15
        TickMark.Spacing = 10
        TickMark.Size = 10
        TrackHint = True
        TrackLabel.Font.Charset = DEFAULT_CHARSET
        TrackLabel.Font.Color = clWindowText
        TrackLabel.Font.Height = -11
        TrackLabel.Font.Name = 'Tahoma'
        TrackLabel.Font.Style = []
        TrackLabel.Format = 'Pos: %d'
        Transparent = False
        Version = '1.6.2.0'
      end
    end
    object DNMPanel21: TDNMPanel
      Left = 0
      Top = 1801
      Width = 1065
      Height = 171
      HelpContext = 484002
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      ExplicitTop = 1772
      object Bevel24: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 157
        HelpContext = 484003
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 9
        ExplicitTop = 10
        ExplicitWidth = 529
        ExplicitHeight = 155
      end
      object Label12: TLabel
        Left = 14
        Top = 14
        Width = 129
        Height = 15
        HelpContext = 484004
        Caption = 'Discontinued Products'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label15: TLabel
        Left = 36
        Top = 72
        Width = 189
        Height = 15
        HelpContext = 484025
        Caption = 'When Alternate Product Selected'
        Transparent = True
      end
      object Bevel25: TBevel
        Left = 37
        Top = 93
        Width = 322
        Height = 63
        HelpContext = 484116
        Shape = bsFrame
      end
      object wwCheckBox29: TwwCheckBox
        Left = 33
        Top = 38
        Width = 488
        Height = 17
        HelpContext = 484018
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
        Caption = 
          'Use the Price of Discontinued Product When Alternate Product is ' +
          'Selected'
        Checked = True
        DataField = 'UseDiscontinuedProductPriceforAlternateProduct'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 0
      end
      object wwRadioGroup5: TwwRadioGroup
        Left = 48
        Top = 95
        Width = 300
        Height = 58
        HelpContext = 484223
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 5
        ShowGroupCaption = False
        Transparent = True
        NoSpacing = True
        DataField = 'AlternateProductSelection'
        DataSource = dsPrefs
        Items.Strings = (
          'Delete and Replace with the Alternate Product'
          'Add The Alternate Product')
        TabOrder = 1
        Values.Strings = (
          'R'
          'A')
      end
    end
    object DNMPanel19: TDNMPanel
      Left = 0
      Top = 2512
      Width = 1065
      Height = 370
      HelpContext = 484287
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      ExplicitTop = 2483
      object Bevel22: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 356
        HelpContext = 484288
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = -165
        ExplicitTop = 13
        ExplicitWidth = 529
        ExplicitHeight = 354
      end
      object Label16: TLabel
        Left = 14
        Top = 14
        Width = 99
        Height = 15
        HelpContext = 484289
        Caption = 'Sales Conversion'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label17: TLabel
        Left = 24
        Top = 51
        Width = 166
        Height = 15
        HelpContext = 484290
        Caption = 'Sales Order/Quote -> Repairs'
        Transparent = True
      end
      object Label18: TLabel
        Left = 63
        Top = 78
        Width = 185
        Height = 15
        HelpContext = 484291
        Caption = 'Populate Repair Addresses from'
        Transparent = True
      end
      object Bevel20: TBevel
        Left = 63
        Top = 97
        Width = 250
        Height = 96
        HelpContext = 484292
        Shape = bsFrame
      end
      object Label19: TLabel
        Left = 24
        Top = 211
        Width = 162
        Height = 15
        HelpContext = 484293
        Caption = 'Sales Order/Quote -> Invoice'
        Transparent = True
      end
      object Label20: TLabel
        Left = 63
        Top = 241
        Width = 159
        Height = 15
        HelpContext = 484132
        Caption = 'Status to Enable Conversion'
        Transparent = True
      end
      object Label21: TLabel
        Left = 63
        Top = 298
        Width = 159
        Height = 15
        HelpContext = 484294
        Caption = 'Status to Enable Conversion'
        Transparent = True
      end
      object Label23: TLabel
        Left = 24
        Top = 270
        Width = 119
        Height = 15
        HelpContext = 484295
        Caption = 'Quote -> Sales Order'
        Transparent = True
      end
      object wwRadioGroup3: TwwRadioGroup
        Left = 72
        Top = 99
        Width = 233
        Height = 89
        HelpContext = 484247
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 5
        ShowGroupCaption = False
        Transparent = True
        NoSpacing = True
        DataField = 'CopySalesOrderShiptotoRepairs'
        DataSource = dsPrefs
        Items.Strings = (
          'Sales Transaction'
          'Switch Sales Transaction'
          'Customer Card')
        TabOrder = 0
        Values.Strings = (
          'C'
          'I'
          'N')
      end
      object cboStatusforInvoice: TwwDBLookupCombo
        Left = 236
        Top = 237
        Width = 225
        Height = 23
        HelpContext = 484151
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'name'#9'20'#9'name'#9'F')
        DataField = 'StatustoMakeInvoice'
        DataSource = dsPrefs
        LookupTable = QryStatusforInvoice
        LookupField = 'name'
        ParentFont = False
        TabOrder = 1
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnEnter = cboStatusforInvoiceEnter
      end
      object cboStatusforSO: TwwDBLookupCombo
        Left = 236
        Top = 294
        Width = 225
        Height = 23
        HelpContext = 484297
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'name'#9'20'#9'name'#9'F')
        DataField = 'StatusToMakeSalesOrder'
        DataSource = dsPrefs
        LookupTable = QryStatusforSO
        LookupField = 'name'
        ParentFont = False
        TabOrder = 2
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnEnter = cboStatusforSOEnter
      end
      object wwCheckBox19: TwwCheckBox
        Left = 24
        Top = 330
        Width = 489
        Height = 17
        HelpContext = 484298
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
        Caption = 
          'Apply Sales Order Prepayment(s) to the Invoice when converted to' +
          ' Invoice'
        Checked = True
        DataField = 'ApplyPrepaymentsOnSOConversion'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 3
      end
    end
    object DNMPanel20: TDNMPanel
      Left = 0
      Top = 2185
      Width = 1065
      Height = 327
      HelpContext = 484042
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      ExplicitTop = 2156
      object Bevel21: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 313
        HelpContext = 484043
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 3
        ExplicitTop = 38
        ExplicitWidth = 531
      end
      object Label24: TLabel
        Left = 14
        Top = 14
        Width = 83
        Height = 15
        HelpContext = 484044
        Caption = 'Reward Points'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label25: TLabel
        Left = 24
        Top = 50
        Width = 153
        Height = 15
        HelpContext = 484045
        Caption = 'Value for Redeemed Points'
        Transparent = True
      end
      object Label26: TLabel
        Left = 24
        Top = 129
        Width = 157
        Height = 15
        HelpContext = 484224
        Caption = 'Decimal Places to allow for '
        Transparent = True
      end
      object Label27: TLabel
        Left = 24
        Top = 168
        Width = 179
        Height = 15
        HelpContext = 484098
        Caption = 'Account for sold Reward Points'
        Transparent = True
      end
      object Label28: TLabel
        Left = 24
        Top = 247
        Width = 204
        Height = 15
        HelpContext = 484277
        Caption = 'Expense Account for Reward Points'
        Transparent = True
      end
      object Label30: TLabel
        Left = 26
        Top = 287
        Width = 251
        Height = 15
        HelpContext = 484225
        Caption = 'Expires No of Months from Date of Purchase'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label31: TLabel
        Left = 24
        Top = 208
        Width = 198
        Height = 15
        HelpContext = 484278
        Caption = 'Account for Expired Reward Points'
        Transparent = True
      end
      object Label32: TLabel
        Left = 24
        Top = 89
        Width = 202
        Height = 15
        HelpContext = 484279
        Caption = 'Trigger Group for Redeeming Points'
        Transparent = True
      end
      object edtValue: TwwDBEdit
        Left = 304
        Top = 46
        Width = 55
        Height = 23
        HelpContext = 484051
        DataField = 'ValueforRewardPoints'
        DataSource = dsPrefs
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
      object wwDBComboBox1: TwwDBComboBox
        Left = 304
        Top = 125
        Width = 55
        Height = 23
        HelpContext = 484226
        ShowButton = True
        Style = csDropDownList
        MapList = False
        AllowClearKey = False
        DataField = 'RoundUpPoints'
        DataSource = dsPrefs
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          '0'
          '1'
          '2')
        ItemIndex = 2
        ParentFont = False
        Sorted = False
        TabOrder = 2
        UnboundDataType = wwDefault
      end
      object wwDBLookupCombo1: TwwDBLookupCombo
        Left = 304
        Top = 164
        Width = 172
        Height = 23
        HelpContext = 484102
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'RewardPointssoldAccount'
        DataSource = dsPrefs
        LookupTable = QryRewardPointssoldAccount
        LookupField = 'AccountID'
        ParentFont = False
        TabOrder = 3
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo3: TwwDBLookupCombo
        Left = 304
        Top = 243
        Width = 172
        Height = 23
        HelpContext = 484280
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'ExpenseAccountforRewardPoints'
        DataSource = dsPrefs
        LookupTable = qryExpenseAccountforRewardPoints
        LookupField = 'AccountID'
        ParentFont = False
        TabOrder = 5
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBEdit9: TwwDBEdit
        Left = 304
        Top = 283
        Width = 55
        Height = 23
        HelpContext = 484281
        DataField = 'ExpiresOnNoOfMonthsAfterPurchase'
        DataSource = dsPrefs
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
      object wwDBLookupCombo2: TwwDBLookupCombo
        Left = 304
        Top = 204
        Width = 172
        Height = 23
        HelpContext = 484282
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'RewardPointsExpiredAccount'
        DataSource = dsPrefs
        LookupTable = QryRewardPointsExpiredAccount
        LookupField = 'AccountID'
        ParentFont = False
        TabOrder = 4
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object edtMultiples: TwwDBEdit
        Left = 304
        Top = 85
        Width = 55
        Height = 23
        HelpContext = 484283
        DataField = 'MultiplesofPointstoRedeem'
        DataSource = dsPrefs
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
    end
    object DNMPanel18: TDNMPanel
      Left = 0
      Top = 2104
      Width = 1065
      Height = 81
      HelpContext = 484177
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      ExplicitTop = 2075
      object Bevel18: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 67
        HelpContext = 484178
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 65
      end
      object Label33: TLabel
        Left = 14
        Top = 14
        Width = 114
        Height = 15
        HelpContext = 484179
        Caption = 'Customer List Mode'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwRadioGroup2: TwwRadioGroup
        Left = 16
        Top = 40
        Width = 172
        Height = 25
        HelpContext = 484180
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 5
        ShowGroupCaption = False
        Transparent = True
        NoSpacing = True
        Columns = 2
        DataField = 'CustomerListMode'
        DataSource = dsPrefs
        Items.Strings = (
          'Job'
          'Related')
        TabOrder = 0
        Values.Strings = (
          'Job'
          'Related')
      end
    end
    object DNMPanel17: TDNMPanel
      Left = 0
      Top = 1972
      Width = 1065
      Height = 132
      HelpContext = 484168
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      ExplicitTop = 1943
      object Bevel17: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 118
        HelpContext = 484169
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 9
        ExplicitWidth = 531
      end
      object Label36: TLabel
        Left = 14
        Top = 14
        Width = 38
        Height = 15
        HelpContext = 484170
        Caption = 'Emails'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label42: TLabel
        Left = 288
        Top = 72
        Width = 99
        Height = 15
        HelpContext = 484172
        Caption = 'Email recipient(s)'
        Transparent = True
      end
      object wwCheckBox56: TwwCheckBox
        Left = 24
        Top = 72
        Width = 250
        Height = 17
        HelpContext = 484174
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
        Caption = 'Send email when printing Picking Slip'
        DataField = 'EmailWhenPrintingPickingSlip'
        DataSource = dsPrefs
        TabOrder = 0
      end
      object wwDBEdit8: TwwDBEdit
        Left = 288
        Top = 90
        Width = 170
        Height = 23
        HelpContext = 484175
        DataField = 'PickingSlipEmailRecipient'
        DataSource = dsPrefs
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
      object wwCheckBox59: TwwCheckBox
        Left = 24
        Top = 42
        Width = 417
        Height = 17
        HelpContext = 484176
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
        Caption = 'Send email to customer when saving invoice'
        DataField = 'EmailInvoiceInfoToCustomer'
        DataSource = dsPrefs
        TabOrder = 2
      end
    end
    object DNMPanel14: TDNMPanel
      Left = 0
      Top = 1168
      Width = 1065
      Height = 480
      HelpContext = 484114
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      ExplicitTop = 1139
      object Bevel14: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 466
        HelpContext = 484115
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 53
        ExplicitTop = 5
        ExplicitWidth = 531
      end
      object Bevel23: TBevel
        Left = 24
        Top = 424
        Width = 473
        Height = 42
        HelpContext = 484299
        Shape = bsFrame
      end
      object Bevel19: TBevel
        Left = 24
        Top = 377
        Width = 473
        Height = 42
        HelpContext = 484300
        Shape = bsFrame
      end
      object Label43: TLabel
        Left = 14
        Top = 14
        Width = 82
        Height = 15
        HelpContext = 484121
        Caption = 'Miscellaneous'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label48: TLabel
        Left = 22
        Top = 312
        Width = 171
        Height = 15
        HelpContext = 484130
        Caption = 'Begin Transactions at Number'
        Transparent = True
      end
      object Label54: TLabel
        Left = 301
        Top = 312
        Width = 122
        Height = 15
        HelpContext = 484131
        Caption = 'Quote Follow Up Days'
        Transparent = True
      end
      object Label34: TLabel
        Left = 22
        Top = 347
        Width = 219
        Height = 15
        HelpContext = 484301
        Caption = 'Default Accounts Receivables Account'
        Transparent = True
      end
      object lblFutureSalesOrders1: TLabel
        Left = 274
        Top = 391
        Width = 84
        Height = 15
        HelpContext = 484135
        Caption = 'Due Date Over '
        Transparent = True
      end
      object lblFutureSalesOrders2: TLabel
        Left = 402
        Top = 391
        Width = 36
        Height = 15
        HelpContext = 484136
        Caption = 'Day(s)'
        Transparent = True
      end
      object Label29: TLabel
        Left = 226
        Top = 438
        Width = 132
        Height = 15
        HelpContext = 484307
        Caption = 'Related Master Caption'
        Transparent = True
      end
      object wwCheckBox42: TwwCheckBox
        Left = 117
        Top = 18
        Width = 332
        Height = 17
        HelpContext = 484137
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
        Caption = 'Invoice Wholesale Toggle Always On'
        DataField = 'WholeSaleToggleON'
        DataSource = dsPrefs
        Enabled = False
        TabOrder = 0
        Visible = False
      end
      object wwCheckBox43: TwwCheckBox
        Left = 23
        Top = 59
        Width = 267
        Height = 17
        HelpContext = 484138
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
        Caption = 'Always show BO on Customer Costs'
        DataField = 'AlwaysShowBOonCustomerCost'
        DataSource = dsPrefs
        TabOrder = 1
      end
      object wwCheckBox44: TwwCheckBox
        Left = 23
        Top = 89
        Width = 267
        Height = 17
        HelpContext = 484139
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
        Caption = 'Enable Project Progress Payments'
        Checked = True
        DataField = 'ProgressPayments'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 2
      end
      object wwCheckBox46: TwwCheckBox
        Left = 23
        Top = 151
        Width = 267
        Height = 17
        HelpContext = 484140
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
        Caption = 'Recalculate Costs When Shipped'
        Checked = True
        DataField = 'RecalcCostInvBO'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 4
      end
      object wwCheckBox47: TwwCheckBox
        Left = 23
        Top = 120
        Width = 267
        Height = 17
        HelpContext = 484141
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
        Caption = 'Enforce No Modifying on Equipment Notes'
        DataField = 'EnforceNoModifyonNotes'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object wwCheckBox51: TwwCheckBox
        Left = 301
        Top = 59
        Width = 233
        Height = 17
        HelpContext = 484144
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
        Caption = 'Use Ship Date for Terms'
        DataField = 'UseShippedDateForTerms'
        DataSource = dsPrefs
        TabOrder = 8
      end
      object wwCheckBox52: TwwCheckBox
        Left = 301
        Top = 89
        Width = 233
        Height = 17
        HelpContext = 484145
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
        Caption = 'All Class On Customer List'
        Checked = True
        DataField = 'AllClassesOnCustList'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 9
      end
      object wwCheckBox53: TwwCheckBox
        Left = 301
        Top = 120
        Width = 233
        Height = 17
        HelpContext = 484146
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
        Caption = 'Barcode Pick Always On'
        DataField = 'UseBarcodePicking'
        DataSource = dsPrefs
        TabOrder = 10
      end
      object wwCheckBox54: TwwCheckBox
        Left = 301
        Top = 151
        Width = 233
        Height = 17
        HelpContext = 484147
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
        Caption = 'Cost on Sales to Purchasing'
        DataField = 'CostonSalesToPO'
        DataSource = dsPrefs
        TabOrder = 11
      end
      object wwCheckBox55: TwwCheckBox
        Left = 301
        Top = 182
        Width = 233
        Height = 17
        HelpContext = 484148
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
        Caption = 'Use TNT On Sales'
        DataField = 'UseTNTFreight'
        DataSource = dsPrefs
        TabOrder = 12
        OnClick = wwCheckBox55Click
      end
      object cboDefaultSales: TwwDBLookupCombo
        Left = 270
        Top = 343
        Width = 225
        Height = 23
        HelpContext = 484310
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'DefaultSalesAccount'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        ParentFont = False
        TabOrder = 7
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwCheckBox57: TwwCheckBox
        Left = 23
        Top = 182
        Width = 267
        Height = 17
        HelpContext = 484152
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
        Caption = 'Leave Invoice Open After Copy From SO'
        Checked = True
        DataField = 'LeaveOpenOnCopyToINV'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 5
      end
      object chkUseFutureSalesOrders: TwwCheckBox
        Left = 40
        Top = 390
        Width = 166
        Height = 17
        HelpContext = 484153
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
        Caption = 'Use Future Sales Orders'
        DataField = 'UseFutureSO'
        DataSource = dsPrefs
        TabOrder = 14
        OnClick = chkUseFutureSalesOrdersClick
      end
      object edtFutureSalesOrdersDays: TwwDBEdit
        Left = 362
        Top = 387
        Width = 33
        Height = 23
        HelpContext = 484154
        DataField = 'FutureSODays'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwCheckBox49: TwwCheckBox
        Left = 23
        Top = 244
        Width = 267
        Height = 17
        HelpContext = 484311
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
        Caption = 'Use Employee Class For AR List'
        DataField = 'UseEmployeeClassForARList'
        DataSource = dsPrefs
        TabOrder = 16
      end
      object wwDBEdit10: TwwDBEdit
        Left = 438
        Top = 308
        Width = 57
        Height = 23
        HelpContext = 484149
        DataField = 'FollowupDays'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object chkCustomerTypeRequired: TwwCheckBox
        Left = 301
        Top = 244
        Width = 233
        Height = 17
        HelpContext = 484312
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
        Caption = 'Customer Type Required'
        DataField = 'CustomerTypeRequired'
        DataSource = dsPrefs
        TabOrder = 18
      end
      object wwCheckBox64: TwwCheckBox
        Left = 23
        Top = 213
        Width = 267
        Height = 17
        HelpContext = 484313
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
        Caption = 'Customer P.O. Number Must Be Unique'
        Checked = True
        DataField = 'UniqueCustomerPONumInSale'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 19
      end
      object edtSalesStartNum: TAdvEdit
        Left = 208
        Top = 308
        Width = 81
        Height = 23
        HelpContext = 484150
        EditType = etNumeric
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'MS Sans Serif'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
      object wwCheckBox66: TwwCheckBox
        Left = 301
        Top = 275
        Width = 233
        Height = 17
        HelpContext = 484314
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
        Caption = 'Enable Quote Variation'
        Checked = True
        DataField = 'EnablequoteVariation'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 20
      end
      object wwCheckBox8: TwwCheckBox
        Left = 40
        Top = 437
        Width = 155
        Height = 17
        HelpContext = 484315
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
        Caption = 'Show Related Master'
        DataField = 'ShowRelatedMasterinSales'
        DataSource = dsPrefs
        TabOrder = 21
      end
      object wwDBEdit11: TwwDBEdit
        Left = 362
        Top = 434
        Width = 129
        Height = 23
        HelpContext = 484316
        DataField = 'RelatedMasterCaptionInSales'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 22
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwCheckBox9: TwwCheckBox
        Left = 301
        Top = 213
        Width = 233
        Height = 17
        HelpContext = 484317
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
        Caption = 'Ship To Address Editable'
        Checked = True
        DataField = 'CanEditSalesshiptoAddress'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 23
      end
      object chkCustFirstAndLastNamesRequired: TwwCheckBox
        Left = 23
        Top = 275
        Width = 267
        Height = 17
        HelpContext = 484318
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
        Caption = 'Customer First and Last Names Required'
        DataField = 'EnforceCustomerFirstAndLastName'
        DataSource = dsPrefs
        TabOrder = 13
      end
    end
    object DNMPanel13: TDNMPanel
      Left = 0
      Top = 1648
      Width = 1065
      Height = 153
      HelpContext = 484105
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      ExplicitTop = 1619
      object Bevel13: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 139
        HelpContext = 484106
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 9
        ExplicitTop = 9
        ExplicitWidth = 529
        ExplicitHeight = 137
      end
      object Label57: TLabel
        Left = 14
        Top = 14
        Width = 49
        Height = 15
        HelpContext = 484107
        Caption = 'Manifest'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label59: TLabel
        Left = 24
        Top = 112
        Width = 273
        Height = 15
        HelpContext = 484109
        Caption = 'Default Sub-contractor Payment Advice Account'
        Transparent = True
      end
      object Label61: TLabel
        Left = 24
        Top = 72
        Width = 190
        Height = 15
        HelpContext = 484110
        Caption = 'ETA Days Following Dispatch Date'
        Transparent = True
      end
      object wwCheckBox39: TwwCheckBox
        Left = 24
        Top = 40
        Width = 221
        Height = 17
        HelpContext = 484111
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
        Caption = 'Invoice Manifest Always On'
        DataField = 'UseManifest'
        DataSource = dsPrefs
        TabOrder = 0
      end
      object cboDefaultSubPayment: TwwDBLookupCombo
        Left = 312
        Top = 104
        Width = 169
        Height = 23
        HelpContext = 484112
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'DefaultSPAAccount'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        ParentFont = False
        TabOrder = 1
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBEdit7: TwwDBEdit
        Left = 232
        Top = 64
        Width = 35
        Height = 23
        HelpContext = 484113
        DataField = 'ManifestDaysAfterDespatchDate'
        DataSource = dsPrefs
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
    end
    object DNMPanel12: TDNMPanel
      Left = 0
      Top = 984
      Width = 1065
      Height = 184
      HelpContext = 484094
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      ExplicitTop = 955
      object Bevel12: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 170
        HelpContext = 484095
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 99
        ExplicitTop = 55
        ExplicitWidth = 531
      end
      object Label60: TLabel
        Left = 14
        Top = 14
        Width = 140
        Height = 15
        HelpContext = 484096
        Caption = 'Uninvoiced Sales Orders'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label62: TLabel
        Left = 24
        Top = 72
        Width = 73
        Height = 15
        HelpContext = 484285
        Caption = 'WIP Account'
        Transparent = True
      end
      object Label63: TLabel
        Left = 24
        Top = 104
        Width = 52
        Height = 15
        HelpContext = 484099
        Caption = 'WIP Type'
        Transparent = True
      end
      object Label64: TLabel
        Left = 24
        Top = 144
        Width = 66
        Height = 15
        HelpContext = 484100
        Caption = 'WIP Labour'
        Transparent = True
      end
      object chkIncludeUnInvoicedSOtoGL: TwwCheckBox
        Left = 24
        Top = 40
        Width = 284
        Height = 17
        HelpContext = 484101
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
        Caption = 'Include UnInvoiced Sales Orders to GL'
        DataField = 'IncludeUnInvoicedSOtoGL'
        DataSource = dsPrefs
        TabOrder = 0
      end
      object cboUnInvoicedSOAccount: TwwDBLookupCombo
        Left = 104
        Top = 64
        Width = 172
        Height = 23
        HelpContext = 484286
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'UnInvoicedSOAccount'
        DataSource = dsPrefs
        LookupTable = qryAccUnInvSO
        LookupField = 'AccountID'
        ParentFont = False
        TabOrder = 1
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object cboUnInvoicedSOLabourAccount: TwwDBLookupCombo
        Left = 104
        Top = 136
        Width = 172
        Height = 23
        HelpContext = 484103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'UnInvoicedSOLabourAccount'
        DataSource = dsPrefs
        LookupTable = qryAccUnInvSOLabour
        LookupField = 'AccountID'
        ParentFont = False
        TabOrder = 2
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnEnter = cboUnInvoicedSOLabourAccountEnter
      end
      object wwRadioGroup1: TwwRadioGroup
        Left = 104
        Top = 100
        Width = 172
        Height = 25
        HelpContext = 484104
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 5
        ShowGroupCaption = False
        Transparent = True
        NoSpacing = True
        Columns = 2
        DataField = 'UnInvoicedSOType'
        DataSource = dsPrefs
        Items.Strings = (
          'Income'
          'Cost')
        TabOrder = 3
        Values.Strings = (
          '0'
          '1')
      end
    end
    object DNMPanel11: TDNMPanel
      Left = 0
      Top = 834
      Width = 1065
      Height = 150
      HelpContext = 484087
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
      ExplicitTop = 805
      object Bevel11: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 136
        HelpContext = 484088
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 10
        ExplicitWidth = 529
        ExplicitHeight = 100
      end
      object Label56: TLabel
        Left = 14
        Top = 14
        Width = 67
        Height = 15
        HelpContext = 484089
        Caption = 'Backorders'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox36: TwwCheckBox
        Left = 24
        Top = 40
        Width = 333
        Height = 17
        HelpContext = 484092
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
        Caption = 'Combined Invoice Backorders'
        DataField = 'CombinedInvoiceBO'
        DataSource = dsPrefs
        TabOrder = 0
      end
      object wwCheckBox37: TwwCheckBox
        Left = 24
        Top = 78
        Width = 333
        Height = 17
        HelpContext = 484093
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
        Caption = 'Consolidate Customer BO'#39's on Invoice (F8)'
        DataField = 'ConsolidateCustBOonInvoice'
        DataSource = dsPrefs
        TabOrder = 1
      end
      object wwCheckBox61: TwwCheckBox
        Left = 24
        Top = 116
        Width = 333
        Height = 17
        HelpContext = 484269
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
        Caption = 'Combined Salesorder Backorders'
        DataField = 'CombinedSaleOrderBO'
        DataSource = dsPrefs
        TabOrder = 2
        Visible = False
      end
    end
    object DNMPanel10: TDNMPanel
      Left = 0
      Top = 672
      Width = 1065
      Height = 162
      HelpContext = 484076
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
      ExplicitTop = 643
      object Bevel10: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 148
        HelpContext = 484077
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 3
        ExplicitTop = 32
        ExplicitWidth = 531
      end
      object Label52: TLabel
        Left = 14
        Top = 14
        Width = 164
        Height = 15
        HelpContext = 484078
        Caption = 'Customisable Fields for Jobs'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label53: TLabel
        Left = 24
        Top = 40
        Width = 101
        Height = 15
        HelpContext = 484079
        Caption = 'Job Name Header'
        Transparent = True
      end
      object Label58: TLabel
        Left = 24
        Top = 96
        Width = 113
        Height = 15
        HelpContext = 484081
        Caption = 'Job Number Header'
        Transparent = True
      end
      object Label55: TLabel
        Left = 232
        Top = 96
        Width = 73
        Height = 15
        HelpContext = 484082
        Caption = 'Code Header'
        Transparent = True
        Visible = False
      end
      object wwDBEdit4: TwwDBEdit
        Left = 24
        Top = 56
        Width = 170
        Height = 23
        HelpContext = 484083
        DataField = 'JobNameHeader'
        DataSource = dsPrefs
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
      object wwDBEdit5: TwwDBEdit
        Left = 24
        Top = 112
        Width = 170
        Height = 23
        HelpContext = 484084
        DataField = 'JobNumberHeader'
        DataSource = dsPrefs
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
      object wwCheckBox35: TwwCheckBox
        Left = 232
        Top = 52
        Width = 277
        Height = 17
        HelpContext = 484085
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
        Caption = 'Show Customer Job # Column by Default'
        DataField = 'ShowCustomerJobNoByDefault'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object wwDBEdit6: TwwDBEdit
        Left = 232
        Top = 112
        Width = 170
        Height = 23
        HelpContext = 484086
        DataField = 'CodeHeader'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        UnboundDataType = wwDefault
        Visible = False
        WantReturns = False
        WordWrap = False
      end
    end
    object DNMPanel9: TDNMPanel
      Left = 0
      Top = 376
      Width = 1065
      Height = 122
      HelpContext = 484071
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 13
      object Bevel9: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 108
        HelpContext = 484072
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 23
        ExplicitWidth = 531
      end
      object Label50: TLabel
        Left = 14
        Top = 14
        Width = 79
        Height = 15
        HelpContext = 484073
        Caption = 'Invoice Footer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label51: TLabel
        Left = 24
        Top = 40
        Width = 24
        Height = 15
        HelpContext = 484074
        Caption = 'Text'
        Transparent = True
      end
      object DBMemo1: TDBMemo
        Left = 56
        Top = 40
        Width = 465
        Height = 57
        HelpContext = 484075
        DataField = 'Invoice_Footer'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object DNMPanel7: TDNMPanel
      Left = 0
      Top = 239
      Width = 1065
      Height = 137
      HelpContext = 484052
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 14
      ExplicitTop = 210
      object Bevel7: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 123
        HelpContext = 484053
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = -6
        ExplicitTop = 26
        ExplicitWidth = 529
        ExplicitHeight = 121
      end
      object Label41: TLabel
        Left = 14
        Top = 14
        Width = 151
        Height = 15
        HelpContext = 484054
        Caption = 'Warranty Fields for Invoice'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label44: TLabel
        Left = 24
        Top = 60
        Width = 55
        Height = 15
        HelpContext = 484057
        Caption = 'Date Field'
        Transparent = True
      end
      object Label45: TLabel
        Left = 24
        Top = 92
        Width = 53
        Height = 15
        HelpContext = 484058
        Caption = 'Text Field'
        Transparent = True
      end
      object Label46: TLabel
        Left = 279
        Top = 40
        Width = 35
        Height = 15
        HelpContext = 484059
        Caption = 'Active'
        Transparent = True
      end
      object Label65: TLabel
        Left = 94
        Top = 40
        Width = 43
        Height = 15
        HelpContext = 484270
        Caption = 'Caption'
        Transparent = True
      end
      object Label66: TLabel
        Left = 335
        Top = 40
        Width = 51
        Height = 15
        HelpContext = 484271
        Caption = 'Required'
        Transparent = True
      end
      object wwDBEdit2: TwwDBEdit
        Left = 94
        Top = 56
        Width = 170
        Height = 23
        HelpContext = 484060
        DataField = 'SalesWarrantyEndsOnCaption'
        DataSource = dsPrefs
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
      object wwDBEdit3: TwwDBEdit
        Left = 94
        Top = 88
        Width = 170
        Height = 23
        HelpContext = 484061
        DataField = 'SalesWarrantyPeriodCaption'
        DataSource = dsPrefs
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
      object wwCheckBox31: TwwCheckBox
        Left = 288
        Top = 59
        Width = 16
        Height = 17
        HelpContext = 484062
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
        Caption = '"Date" Warranty Field for Invoice : Active'
        Checked = True
        DataField = 'ShowSalesWarrantyEndsOn'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 2
      end
      object wwCheckBox33: TwwCheckBox
        Left = 288
        Top = 91
        Width = 16
        Height = 17
        HelpContext = 484063
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
        Caption = '"text" Warranty Field for Invoice : Active'
        Checked = True
        DataField = 'ShowSalesWarrantyPeriod'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 3
      end
      object wwCheckBox13: TwwCheckBox
        Left = 352
        Top = 59
        Width = 16
        Height = 17
        HelpContext = 484272
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
        Caption = ' "Date" Warranty Field for Invoice : Required'
        Checked = True
        DataField = 'SalesWarrantyEndsOnRequired'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 4
      end
      object wwCheckBox14: TwwCheckBox
        Left = 352
        Top = 91
        Width = 16
        Height = 17
        HelpContext = 484273
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
        Caption = '"text" Warranty Field for Invoice : Required'
        Checked = True
        DataField = 'SalesWarrantyPeriodRequired'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 5
      end
    end
    object DNMPanel6: TDNMPanel
      Left = 0
      Top = 129
      Width = 1065
      Height = 110
      HelpContext = 484047
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 15
      object Bevel6: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 96
        HelpContext = 484048
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 65
      end
      object Label39: TLabel
        Left = 14
        Top = 14
        Width = 54
        Height = 15
        HelpContext = 484049
        Caption = 'Shipment'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label40: TLabel
        Left = 24
        Top = 40
        Width = 259
        Height = 15
        HelpContext = 484050
        Alignment = taRightJustify
        Caption = 'Shipped Date ->  Days Following Creation Date'
        Transparent = True
      end
      object Label78: TLabel
        Left = 99
        Top = 73
        Width = 184
        Height = 15
        HelpContext = 372085
        Alignment = taRightJustify
        Caption = '"PICK-UP" Ship Method  For Sale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object wwDBEdit1: TwwDBEdit
        Left = 298
        Top = 36
        Width = 35
        Height = 23
        HelpContext = 484284
        DataField = 'ShippedDaysAfterCreate'
        DataSource = dsPrefs
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
      object cboVia: TwwDBLookupCombo
        Left = 298
        Top = 69
        Width = 113
        Height = 23
        HelpContext = 372100
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ShippingMethod'#9'25'#9'ShippingMethod'#9'F')
        DataField = 'PickupShipingMethod'
        DataSource = dsPrefs
        LookupTable = cboViaQry
        LookupField = 'ShippingMethod'
        ParentFont = False
        TabOrder = 1
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
    end
    object DNMPanel5: TDNMPanel
      Left = 0
      Top = -188
      Width = 1065
      Height = 317
      HelpContext = 484319
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 16
      DesignSize = (
        1065
        317)
      object Bevel5: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 303
        HelpContext = 484320
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 170
        ExplicitWidth = 531
      end
      object Bevel34: TBevel
        Left = 1122
        Top = 37
        Width = 194
        Height = 94
        HelpContext = 484423
        Anchors = [akTop, akRight, akBottom]
        ExplicitLeft = 338
      end
      object lblexplain: TLabel
        Left = 1128
        Top = 41
        Width = 186
        Height = 85
        HelpContext = 484402
        Anchors = [akTop, akRight, akBottom]
        AutoSize = False
        Caption = 
          '"Max Percentage Discount" , "MinimumMarginPercentage" and "Min R' +
          'equired Markup" can be Set For an Employee in the "Employee" pag' +
          'e .'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        ExplicitLeft = 344
      end
      object Label37: TLabel
        Left = 14
        Top = 14
        Width = 57
        Height = 15
        HelpContext = 484321
        Caption = 'Discounts'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label38: TLabel
        Left = 41
        Top = 41
        Width = 226
        Height = 15
        HelpContext = 484322
        Caption = 'Maximum Allowed Discount Percentage'
        Transparent = True
      end
      object Label13: TLabel
        Left = 22
        Top = 160
        Width = 222
        Height = 15
        HelpContext = 484323
        Caption = 'Discount Override Works in This Order '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label14: TLabel
        Left = 41
        Top = 190
        Width = 154
        Height = 15
        HelpContext = 484324
        Caption = '1.  Product Extra Sell Price '
        Transparent = True
      end
      object Label49: TLabel
        Left = 41
        Top = 219
        Width = 208
        Height = 15
        HelpContext = 484325
        Caption = '2.  Customer'#39's Special Product Price'
        Transparent = True
      end
      object Label67: TLabel
        Left = 41
        Top = 248
        Width = 172
        Height = 15
        HelpContext = 484326
        Caption = '3.  Customer'#39's Group Discount'
        Transparent = True
      end
      object Label68: TLabel
        Left = 41
        Top = 278
        Width = 10
        Height = 15
        HelpContext = 484327
        Caption = '4.'
        Transparent = True
      end
      object Label71: TLabel
        Left = 249
        Top = 160
        Width = 237
        Height = 15
        HelpContext = 484328
        Caption = '(Don'#39't Recommend  you Mix - See Help F1)'
        Transparent = True
      end
      object Label72: TLabel
        Left = 122
        Top = 76
        Width = 152
        Height = 15
        HelpContext = 484401
        Caption = 'Minimum Required Markup'
        Transparent = True
      end
      object Label73: TLabel
        Left = 122
        Top = 112
        Width = 148
        Height = 15
        HelpContext = 484424
        Caption = 'Minimum Required Margin'
        Transparent = True
      end
      object Label74: TLabel
        Left = 11
        Top = 130
        Width = 268
        Height = 15
        HelpContext = 484425
        Caption = '(When Margin % Fieldis Changed in Sales Form)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object edtMaxDiscount: TEdit
        Left = 281
        Top = 37
        Width = 55
        Height = 23
        HelpContext = 484046
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnExit = edtMaxDiscountExit
      end
      object wwCheckBox48: TwwCheckBox
        Left = 57
        Top = 277
        Width = 408
        Height = 17
        HelpContext = 484142
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
        Caption = 'Special Product Price Overrides All Discounts For All customers '
        DataField = 'SpecProd_Override_Disc'
        DataSource = dsPrefs
        TabOrder = 1
      end
      object edtMinMarkupPercentage: TEdit
        Left = 281
        Top = 72
        Width = 55
        Height = 23
        HelpContext = 484403
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnExit = edtMinMarkupPercentageExit
      end
      object edtMinimumMarginPercentage: TEdit
        Left = 281
        Top = 108
        Width = 55
        Height = 23
        HelpContext = 484426
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnExit = edtMinimumMarginPercentageExit
      end
    end
    object DNMPanel4: TDNMPanel
      Left = 0
      Top = -269
      Width = 1065
      Height = 81
      HelpContext = 484037
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 17
      object Bevel4: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 67
        HelpContext = 484038
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 10
        ExplicitWidth = 529
        ExplicitHeight = 65
      end
      object Label35: TLabel
        Left = 14
        Top = 14
        Width = 87
        Height = 15
        HelpContext = 484039
        Caption = 'Customer Jobs'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox32: TwwCheckBox
        Left = 24
        Top = 40
        Width = 292
        Height = 17
        HelpContext = 484041
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
        Caption = 'Start Job Name with Job Number'
        DataField = 'StartJobNumberField'
        DataSource = dsPrefs
        TabOrder = 0
      end
    end
    object DNMPanel3: TDNMPanel
      Left = 0
      Top = -1583
      Width = 1065
      Height = 996
      HelpContext = 484181
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 18
      DesignSize = (
        1065
        996)
      object Bevel3: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 982
        HelpContext = 484182
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 11
        ExplicitTop = 8
        ExplicitWidth = 531
        ExplicitHeight = 896
      end
      object Label22: TLabel
        Left = 14
        Top = 14
        Width = 113
        Height = 15
        HelpContext = 484190
        Caption = 'Sales Lines Options'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label75: TLabel
        Left = 40
        Top = 636
        Width = 229
        Height = 15
        Cursor = crHandPoint
        HelpContext = 484265
        Caption = 'Sales Header '#39'Area'#39' Default Value Option'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
        OnClick = Label75Click
        OnMouseUp = Label75MouseUp
      end
      object lblSortRelatedProductsinSalehint: TLabel
        Left = 48
        Top = 919
        Width = 680
        Height = 15
        Cursor = crHandPoint
        HelpContext = 484428
        Anchors = [akLeft, akTop, akRight]
        Caption = 
          '(When Selected : The Sales will have the Container Product as th' +
          'e first item and all other Products in Alphabetical Order)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object chkShowUnits: TwwCheckBox
        Left = 24
        Top = 35
        Width = 250
        Height = 17
        HelpContext = 484202
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
        Caption = 'Show Units'
        Checked = True
        DataField = 'ShowSalesUnits'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 0
      end
      object chkShowCost: TwwCheckBox
        Left = 24
        Top = 65
        Width = 250
        Height = 17
        HelpContext = 484203
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
        Caption = 'Show Cost'
        Checked = True
        DataField = 'ShowSalesCostInc'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 1
      end
      object chkShowPartsDescription: TwwCheckBox
        Left = 24
        Top = 125
        Width = 250
        Height = 17
        HelpContext = 484204
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
        Caption = 'Show Part Description'
        Checked = True
        DataField = 'ShowSalesDescription'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 2
      end
      object chkShowProfitDollers: TwwCheckBox
        Left = 24
        Top = 156
        Width = 250
        Height = 17
        HelpContext = 484205
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
        Caption = 'Show Profit $'
        Checked = True
        DataField = 'ShowSalesProfit'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 3
      end
      object chkShowMarkupProfitPercent: TwwCheckBox
        Left = 24
        Top = 186
        Width = 250
        Height = 17
        HelpContext = 484206
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
        Caption = 'Show Markup Profit %'
        Checked = True
        DataField = 'ShowSalesProfitPercent'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 4
      end
      object chkShowGrossProfitPercent: TwwCheckBox
        Left = 24
        Top = 216
        Width = 250
        Height = 17
        HelpContext = 484207
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
        Caption = 'Show Gross Profit %'
        DataField = 'ShowGrossProfitPercent'
        DataSource = dsPrefs
        TabOrder = 5
      end
      object chkShowTaxCode: TwwCheckBox
        Left = 24
        Top = 247
        Width = 250
        Height = 17
        HelpContext = 484208
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
        Caption = 'Show Tax Code'
        Checked = True
        DataField = 'ShowSalesTaxCode'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 6
      end
      object chkShowTaxAmount: TwwCheckBox
        Left = 24
        Top = 277
        Width = 250
        Height = 17
        HelpContext = 484209
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
        Caption = 'Show Tax Amount'
        Checked = True
        DataField = 'ShowSalesTaxAmount'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 7
      end
      object chkShowDiscount: TwwCheckBox
        Left = 24
        Top = 307
        Width = 250
        Height = 17
        HelpContext = 484210
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
        Caption = 'Show Discount'
        Checked = True
        DataField = 'ShowSalesDiscount'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 8
      end
      object chkShowSupplier: TwwCheckBox
        Left = 24
        Top = 337
        Width = 250
        Height = 17
        HelpContext = 484211
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
        Caption = 'Show Supplier'
        DataField = 'ShowSupplieronSO'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 9
      end
      object chkShowSupplierContact: TwwCheckBox
        Left = 24
        Top = 398
        Width = 250
        Height = 17
        HelpContext = 484212
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
        Caption = 'Show Supplier Contact'
        DataField = 'ShowSupplierContactonSO'
        DataSource = dsPrefs
        TabOrder = 10
      end
      object chkQtyOnlyOnSalesOrder: TwwCheckBox
        Left = 279
        Top = 155
        Width = 247
        Height = 17
        HelpContext = 484418
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
        Caption = 'Qty Only on Sales Order'
        DataField = 'SingleQtySO'
        DataSource = dsPrefs
        TabOrder = 15
      end
      object chkUseForeignCurrency: TwwCheckBox
        Left = 279
        Top = 246
        Width = 247
        Height = 17
        HelpContext = 484214
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
        Caption = 'Use Foreign Currency'
        DataField = 'UseForeignCurrencyonSales'
        DataSource = dsPrefs
        TabOrder = 17
      end
      object chkShowLatestProductCost: TwwCheckBox
        Left = 24
        Top = 803
        Width = 224
        Height = 17
        HelpContext = 484216
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
        Caption = 'Show Latest Product Cost in Sales'
        DataField = 'ShowLatestCost'
        DataSource = dsPrefs
        TabOrder = 21
      end
      object chkShowDocketNumberColumn: TwwCheckBox
        Left = 279
        Top = 276
        Width = 247
        Height = 17
        HelpContext = 484217
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
        Caption = 'Show Docket Number Column'
        DataField = 'ShowDocketNumberColumnOnSales'
        DataSource = dsPrefs
        TabOrder = 18
      end
      object chkEnforceMatrixAttributes: TwwCheckBox
        Left = 279
        Top = 307
        Width = 247
        Height = 17
        HelpContext = 484218
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
        Caption = 'Enforce Matrix Attributes'
        Checked = True
        DataField = 'EnforceMatrixAttributes'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 19
      end
      object chkUseProductSpecs: TwwCheckBox
        Left = 279
        Top = 337
        Width = 247
        Height = 17
        HelpContext = 484219
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
        Caption = 'Use Product Specifications'
        DataField = 'UseProductSpecsCalcsSales'
        DataSource = dsPrefs
        TabOrder = 20
      end
      object grpDiscount: TwwRadioGroup
        Left = 24
        Top = 488
        Width = 217
        Height = 83
        HelpContext = 484221
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 5
        Transparent = True
        NoSpacing = True
        Caption = 'Default Discount / Markup / Margin'
        Columns = 2
        DataField = 'DefaultDiscountMarkup'
        DataSource = dsPrefs
        Items.Strings = (
          'Discount $'
          'Markup $'
          'Discount %'
          'Markup %')
        TabOrder = 23
        Values.Strings = (
          'Discounts'
          'Markup'
          'DiscountPercent'
          'MarkupPercent')
      end
      object chkConfirmBeforeNegative: TwwCheckBox
        Left = 24
        Top = 428
        Width = 250
        Height = 17
        HelpContext = 484367
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
        Caption = 'Confirm Before Sales Stock To Negative'
        DataField = 'ConfirmBeforeInvoiceStockToNegative'
        DataSource = dsPrefs
        TabOrder = 11
      end
      object wwRadioGroup4: TwwRadioGroup
        Left = 266
        Top = 484
        Width = 261
        Height = 83
        HelpContext = 484368
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 5
        Transparent = True
        NoSpacing = True
        Caption = 'Negative Stock Check in Invoice based on'
        DataField = 'NegativeStockcheckinInvoicebasedon'
        DataSource = dsPrefs
        Items.Strings = (
          'Available Quantity'
          'In-Stock Quantity')
        TabOrder = 24
        Values.Strings = (
          'A'
          'I')
      end
      object chkConfirmBeforeReCalc: TwwCheckBox
        Left = 24
        Top = 459
        Width = 414
        Height = 17
        HelpContext = 484369
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
        Caption = 'Confirm Before Re-calculating the Price for Quantity'
        DataField = 'ConfirmBeforesalePricechange'
        DataSource = dsPrefs
        TabOrder = 12
      end
      object chkAlterDate: TDBCheckBox
        Left = 279
        Top = 31
        Width = 247
        Height = 25
        Hint = 
          'When Checked, Line'#39's '#39'Ship Date'#39' and Header'#39's '#39'Sale Date'#39' will b' +
          'e Updated to Current Date when Any product is shipped on a Sale'
        HelpContext = 484370
        Caption = 'Alter Date to '#39'Current Date'#39' When Shipped'
        DataField = 'CurrentDateforSalesshipment'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 13
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        WordWrap = True
      end
      object chkBODefaultOnSalesOrder: TwwCheckBox
        Left = 279
        Top = 186
        Width = 247
        Height = 17
        HelpContext = 484371
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
        Caption = 'BO by Default on Sales Order'
        DataField = 'BOByDefaultOnSO'
        DataSource = dsPrefs
        TabOrder = 16
      end
      object chkMatchSaleLineShipDateToHeader: TwwCheckBox
        Left = 279
        Top = 65
        Width = 247
        Height = 17
        Hint = 
          'When Checked - Changing Header'#39's '#39'Shipdate'#39' will Update al Lines' +
          ' '#39'Ship Date'#39
        HelpContext = 484372
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
        Caption = 'Match Ship Date to Header'
        DataField = 'MatchSaleLineShipDateToHeader'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 33
      end
      object chkMatchSalesLineShipdateToProductDeliveryDays: TDBCheckBox
        Left = 279
        Top = 121
        Width = 247
        Height = 25
        Hint = 
          'When Checked - Ading a Product with a '#39'Normal Delivery time'#39' wil' +
          'l Populate the ETD Date to the Header.Shipdate + Normal Delivery' +
          ' Time'#39
        HelpContext = 484429
        Caption = 'Match '#39'ETD Date'#39' to Header Ship Date + Normal Del Time'
        DataField = 'MatchSalesLineShipdateToProductDeliveryDays'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 14
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        WordWrap = True
      end
      object rgLatestProductCostBasedOn: TwwRadioGroup
        Left = 254
        Top = 733
        Width = 257
        Height = 157
        HelpContext = 484266
        DisableThemes = False
        Caption = 'Latest Product Cost Based On'
        DataField = 'SalesLineLatestCostBasedOn'
        DataSource = dsPrefs
        Items.Strings = (
          'Purchase Order'
          'Product Card'
          'Average Cost'
          'Highest Cost'
          'Lowest Cost')
        TabOrder = 22
        WordWrap = True
        Values.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5')
        OnChange = rgLatestProductCostBasedOnChange
      end
      object wwCheckBox25: TwwCheckBox
        Left = 24
        Top = 663
        Width = 321
        Height = 17
        HelpContext = 484267
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
        Caption = 'Filter Taxcode for the selected Customer'
        Checked = True
        DataField = 'filterTaxcodeforClient'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 26
      end
      object wwCheckBox26: TwwCheckBox
        Left = 279
        Top = 216
        Width = 247
        Height = 17
        HelpContext = 484374
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
        Caption = 'BO by Default on Invoice'
        DataField = 'BOByDefaultOnInvoice'
        DataSource = dsPrefs
        TabOrder = 27
      end
      object wwCheckBox30: TDBCheckBox
        Left = 24
        Top = 686
        Width = 473
        Height = 25
        HelpContext = 484380
        Caption = 
          'Prompt when enough stock is not available for a Sale in the Sale' +
          's Department and is available in other Department(s)'
        DataField = 'checkforStockinOtherDept'
        DataSource = dsPrefs
        TabOrder = 28
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        WordWrap = True
      end
      object wwCheckBox68: TwwCheckBox
        Left = 24
        Top = 95
        Width = 250
        Height = 17
        HelpContext = 484416
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
        Caption = 'Show '#39'SMO To Cost'#39
        Checked = True
        DataField = 'ShowPurchasecostinSales'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 29
      end
      object chkShowRelatedProductSelectioninSale: TDBCheckBox
        Left = 279
        Top = 364
        Width = 247
        Height = 25
        HelpContext = 484420
        Caption = 'Show Related Product Selection in Sale'
        DataField = 'ShowRelatedProductSelectioninSale'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 30
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        WordWrap = True
      end
      object optSalesDefaultValueForAreaFrom: TwwRadioGroup
        Left = 24
        Top = 577
        Width = 500
        Height = 54
        HelpContext = 484373
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 5
        Transparent = True
        NoSpacing = True
        Caption = 'Lines '#39'Area'#39' gets value by default from'
        Columns = 3
        DataField = 'SalesDefaultValueForAreaFrom'
        DataSource = dsPrefs
        Items.Strings = (
          'Customer'#39's Area'
          'Product'#39's Area'
          'None')
        TabOrder = 25
        Values.Strings = (
          'C'
          'P'
          'N')
      end
      object wwCheckBox38: TwwCheckBox
        Left = 279
        Top = 397
        Width = 247
        Height = 16
        HelpContext = 484430
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
        Caption = 'Show Related Parts on Sale'
        DataField = 'ShowRelatedProductsinSales'
        DataSource = dsPrefs
        TabOrder = 31
      end
      object chkDisableSaleLineZeroQuantityWarning: TwwCheckBox
        Left = 279
        Top = 428
        Width = 247
        Height = 16
        HelpContext = 484431
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
        Caption = 'Disable Line Zero Quantity Warning'
        DataField = 'DisableSaleLineZeroQuantityWarning'
        DataSource = dsPrefs
        TabOrder = 32
      end
      object chlShowSaleLineInStockQty: TwwCheckBox
        Left = 24
        Top = 368
        Width = 250
        Height = 17
        HelpContext = 484432
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
        Caption = 'Show In Stock and Available Quantity'
        DataField = 'ShowSaleLineInStockQty'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 34
      end
      object chkMatchInvoiceDAteToShipDate: TwwCheckBox
        Left = 279
        Top = 95
        Width = 247
        Height = 17
        Hint = 
          'When Checked - Changing Header'#39's '#39'Shipdate'#39' will Update al Lines' +
          ' '#39'Ship Date'#39
        HelpContext = 484433
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
        Caption = 'Match Sale Date to Ship Date'
        DataField = 'MatchInvoiceDAteToShipDate'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 35
      end
      object wwCheckBox69: TwwCheckBox
        Left = 24
        Top = 898
        Width = 224
        Height = 17
        HelpContext = 484434
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
        Caption = 'Sort Related Products in Sale'
        DataField = 'SortRelatedProductsinSale'
        DataSource = dsPrefs
        TabOrder = 36
      end
    end
    object DNMPanel2: TDNMPanel
      Left = 0
      Top = -1760
      Width = 1065
      Height = 177
      HelpContext = 484022
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 19
      object Bevel2: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 163
        HelpContext = 484023
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 10
        ExplicitWidth = 529
        ExplicitHeight = 121
      end
      object Label9: TLabel
        Left = 14
        Top = 14
        Width = 44
        Height = 15
        HelpContext = 484024
        Caption = 'Printing'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox10: TwwCheckBox
        Left = 24
        Top = 40
        Width = 222
        Height = 17
        HelpContext = 484031
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
        Caption = 'Print Picking Slip with Invoice'
        DataField = 'PrintPickSlipWithInvoice'
        DataSource = dsPrefs
        TabOrder = 0
      end
      object wwCheckBox11: TwwCheckBox
        Left = 24
        Top = 72
        Width = 222
        Height = 17
        HelpContext = 484032
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
        Caption = 'Print Delivery Docket with Invoices'
        DataField = 'PrintDelDocketWithInvoice'
        DataSource = dsPrefs
        TabOrder = 1
      end
      object wwCheckBox12: TwwCheckBox
        Left = 24
        Top = 104
        Width = 222
        Height = 17
        HelpContext = 484033
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
        Caption = 'Use User Defined Invoice Only'
        DataField = 'UseTemplateDefaultInvoice'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object wwCheckBox58: TwwCheckBox
        Left = 250
        Top = 72
        Width = 266
        Height = 17
        HelpContext = 484036
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Print Delivery Docket on Invoice Save'
        DataField = 'AutomaticDeliveryDocketPrint'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object wwCheckBox65: TwwCheckBox
        Left = 250
        Top = 40
        Width = 266
        Height = 17
        HelpContext = 484276
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
        Caption = 'Exclude Back-Ordered Items From Print'
        DataField = 'ExcludeBOFromPrintinSales'
        DataSource = dsPrefs
        TabOrder = 4
      end
      object chkAutomaticSODeliveryDocketPrint: TwwCheckBox
        Left = 250
        Top = 104
        Width = 266
        Height = 17
        HelpContext = 484382
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
        Caption = 'Print Delivery Docket on Sales Order Save'
        DataField = 'AutomaticSODeliveryDocketPrint'
        DataSource = dsPrefs
        TabOrder = 5
      end
      object chkExcludeZeroAllocationsFromPickingSlip: TwwCheckBox
        Left = 24
        Top = 136
        Width = 333
        Height = 17
        HelpContext = 484405
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
        Caption = 'Exclude Zero Allocations From Picking Slip'
        DataField = 'ExcludeZeroAllocationsFromPickingSlip'
        DataSource = dsPrefs
        TabOrder = 6
      end
    end
    object DNMPanel24: TDNMPanel
      Left = 0
      Top = -1992
      Width = 1065
      Height = 232
      HelpContext = 484435
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 20
      object Bevel35: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 218
        HelpContext = 484436
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 531
        ExplicitHeight = 466
      end
      object Label76: TLabel
        Left = 14
        Top = 14
        Width = 192
        Height = 15
        HelpContext = 484437
        Caption = 'Sales To Smart Order Conversion '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwRadioGroup6: TwwRadioGroup
        Left = 20
        Top = 104
        Width = 497
        Height = 111
        HelpContext = 484438
        DisableThemes = False
        Caption = 'On Convertsion , Create Purchase Order'
        DataField = 'POCreateOptiononSalesToSmartOrderconvertion'
        DataSource = dsPrefs
        Items.Strings = (
          ' Automatically - Without Confirmation'
          ' With Confirmation'
          ' Do not Create Purchase Order')
        TabOrder = 0
        Values.Strings = (
          'A'
          'C'
          'D')
        OnChange = rgLatestProductCostBasedOnChange
      end
      object wwCheckBox6: TwwCheckBox
        Left = 20
        Top = 40
        Width = 444
        Height = 17
        HelpContext = 484349
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
        Caption = 'Disable '#39'Copy to Smart'#39' on S/O when P/O Created'
        Checked = True
        DataField = 'DisableCopyToSmart'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 1
      end
      object chkDisableInvCopyToSmartIfPOCreated: TwwCheckBox
        Left = 20
        Top = 73
        Width = 444
        Height = 17
        HelpContext = 484356
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
        Caption = 'Disable '#39'Copy to Smart'#39' on Inv and BO Inv when P/O Created'
        Checked = True
        DataField = 'DisableInvCopyToSmartIfPOCreated'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 2
      end
    end
    object DNMPanel1: TDNMPanel
      Left = 0
      Top = -3338
      Width = 1065
      Height = 1000
      HelpContext = 484329
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 21
      object Bevel1: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 986
        HelpContext = 484330
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        ParentShowHint = False
        Shape = bsFrame
        ShowHint = True
        ExplicitTop = 13
        ExplicitWidth = 531
      end
      object Label1: TLabel
        Left = 14
        Top = 14
        Width = 44
        Height = 15
        HelpContext = 484331
        Caption = 'General'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label47: TLabel
        Left = 20
        Top = 400
        Width = 127
        Height = 15
        HelpContext = 484337
        Caption = 'Order by Field for Print'
      end
      object Label77: TLabel
        Left = 39
        Top = 972
        Width = 219
        Height = 15
        Cursor = crHandPoint
        HelpContext = 484439
        Caption = 'Sales Lines '#39'Area'#39' Default Value Option'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
        OnClick = Label77Click
        OnMouseUp = Label77MouseUp
      end
      object wwCheckBox1: TwwCheckBox
        Left = 20
        Top = 41
        Width = 255
        Height = 17
        HelpContext = 484013
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
        Caption = 'Logged In User equals Rep'
        DataField = 'DefaultRepUser'
        DataSource = dsPrefs
        TabOrder = 0
      end
      object wwCheckBox2: TwwCheckBox
        Left = 20
        Top = 106
        Width = 255
        Height = 17
        HelpContext = 484014
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
        Caption = 'No Qty Drill Down/Popup Menu On Sales'
        DataField = 'NoQtyDrillDownOnSales'
        DataSource = dsPersonalPreferences
        TabOrder = 1
      end
      object wwCheckBox3: TwwCheckBox
        Left = 20
        Top = 138
        Width = 255
        Height = 17
        HelpContext = 484015
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
        Caption = 'Disable Customer Source Tracking'
        Checked = True
        DataField = 'DisableCusSourceTracking'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 2
      end
      object wwCheckBox4: TwwCheckBox
        Left = 283
        Top = 136
        Width = 222
        Height = 17
        HelpContext = 484016
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
        Caption = 'Disable Add Customer Special Price'
        Checked = True
        DataField = 'NoCustSpecialPriceQuestion'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 4
      end
      object wwCheckBox5: TDBCheckBox
        Left = 283
        Top = 37
        Width = 222
        Height = 25
        HelpContext = 484017
        Caption = 'Suppress Job Names on Invoices and Sales Orders'
        DataField = 'SuppressJobNamesOnInvoices'
        DataSource = dsPrefs
        TabOrder = 3
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        WordWrap = True
      end
      object wwCheckBox7: TwwCheckBox
        Left = 20
        Top = 73
        Width = 255
        Height = 17
        HelpContext = 484019
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
        Caption = 'Auto Generate Customer Account #'
        DataField = 'AutoGenerateCustomerAccntNumber'
        DataSource = dsPrefs
        TabOrder = 5
      end
      object btnCustomerAccountNoSetup: TDNMSpeedButton
        Left = 283
        Top = 262
        Width = 185
        Height = 25
        HelpContext = 484020
        Caption = 'Customer Account No Setup'
        Color = clWhite
        DisableTransparent = False
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentColor = False
        Style = bsModern
        TabOrder = 6
        AutoDisableParentOnclick = True
        OnClick = btnCustomerAccountNoSetupClick
      end
      object wwCheckBox60: TwwCheckBox
        Left = 20
        Top = 171
        Width = 255
        Height = 17
        HelpContext = 484021
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
        Caption = 'Enable Customer Reset Prices'
        Checked = True
        DataField = 'ResetCustPrices'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 7
      end
      object chkUSeSalesCommission: TwwCheckBox
        Left = 283
        Top = 70
        Width = 222
        Height = 17
        HelpContext = 484350
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
        Caption = 'Use Sales Commission'
        DataField = 'USeSalesCommission'
        DataSource = dsPrefs
        TabOrder = 8
      end
      object wwCheckBox15: TwwCheckBox
        Left = 20
        Top = 302
        Width = 444
        Height = 17
        HelpContext = 484351
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
        Caption = 
          'Is Sales Category a Mandatory Field for Invoice, Sales Order and' +
          ' Quote? '
        Checked = True
        DataField = 'IsSalesCategoryMandatory'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 9
      end
      object chkPadQuotePricesIncTax: TwwCheckBox
        Left = 20
        Top = 204
        Width = 255
        Height = 17
        HelpContext = 484353
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
        Caption = 'Insurance Pad Prices Include Tax'
        Checked = True
        DataField = 'PadQuotePricesIncTax'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 10
      end
      object chkAllowAlocationFromOtherClasses: TwwCheckBox
        Left = 20
        Top = 236
        Width = 255
        Height = 17
        HelpContext = 484253
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
        Caption = 'Enable alloc from other Departments '
        DataField = 'AllowAlocationFromOtherClasses'
        DataSource = dsPrefs
        TabOrder = 11
      end
      object wwDBLookupCombo4: TwwDBLookupCombo
        Left = 176
        Top = 396
        Width = 345
        Height = 23
        HelpContext = 484354
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Description'#9'10'#9'Description'#9'F')
        DataField = 'SalesPrintOrderBy'
        DataSource = dsPrefs
        LookupTable = QrySaleslinesFields
        LookupField = 'Fieldname'
        ParentFont = False
        TabOrder = 12
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwCheckBox17: TwwCheckBox
        Left = 20
        Top = 498
        Width = 444
        Height = 17
        HelpContext = 484355
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
        Caption = 'Warn When Creation date is in Future'
        DataField = 'WarnWhenSalesCreationdateisfuture'
        DataSource = dsPrefs
        TabOrder = 13
      end
      object chkShowDeliveryDetailsformonDeldocketprint: TwwCheckBox
        Left = 20
        Top = 334
        Width = 444
        Height = 17
        HelpContext = 484254
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
        Caption = 'Open Delivery Details When printing Delivery Docket'
        DataField = 'ShowDeliveryDetailsformonDeldocketprint'
        DataSource = dsPrefs
        TabOrder = 14
      end
      object chkPrintAddressLabelfromDelPrint: TwwCheckBox
        Left = 20
        Top = 367
        Width = 444
        Height = 17
        HelpContext = 484255
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
        Caption = 
          'Print '#39'Address Labels'#39' When Delivery Docket printed from the '#39'De' +
          'livery Docket Audit'#39
        DataField = 'PrintAddressLabelfromDelPrint'
        DataSource = dsPrefs
        TabOrder = 15
      end
      object chkShowSalesProductAutoSelectOptions: TwwCheckBox
        Left = 20
        Top = 269
        Width = 255
        Height = 17
        HelpContext = 484256
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
        Caption = 'Show Product Auto Select Options'
        DataField = 'ShowSalesProductAutoSelectOptions'
        DataSource = dsPrefs
        TabOrder = 16
      end
      object chkShowManufacutresummarywhenchangedfromSales: TwwCheckBox
        Left = 20
        Top = 432
        Width = 444
        Height = 17
        HelpContext = 484257
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
        Caption = 'Show  '#39'Manufacture Summary'#39' When Tree Created/changed from Sales'
        DataField = 'ShowManufacutresummarywhenchangedfromSales'
        DataSource = dsPrefs
        TabOrder = 17
      end
      object chkShowAmountToAppearOnPrintout: TwwCheckBox
        Left = 20
        Top = 465
        Width = 444
        Height = 17
        HelpContext = 484258
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
        Caption = 'Show  Amount to Appear on Printout on Quote'
        DataField = 'ShowAmountToAppearOnPrintout'
        DataSource = dsPrefs
        TabOrder = 18
      end
      object chkAusEParcel: TwwCheckBox
        Left = 283
        Top = 103
        Width = 222
        Height = 17
        HelpContext = 484259
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
        Caption = 'Enable Australian E-Parcel'
        DataField = 'EnableAusEparcel'
        DataSource = dsPrefs
        TabOrder = 19
        OnClick = chkAusEParcelClick
      end
      object chkConvertConvertedSalesOrder: TwwCheckBox
        Left = 20
        Top = 530
        Width = 444
        Height = 17
        HelpContext = 484357
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
        Caption = 'Allow Conversion of a Converted Sales Order'
        DataField = 'ConvertConvertedSalesOrder'
        DataSource = dsPrefs
        TabOrder = 20
      end
      object wwCheckBox20: TwwCheckBox
        Left = 20
        Top = 563
        Width = 444
        Height = 17
        HelpContext = 484358
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
        Caption = 'Invoice : Allow change of Terms After Due Date'
        DataField = 'AllowchangeofTermAfterDueDate'
        DataSource = dsPrefs
        TabOrder = 21
      end
      object wwCheckBox21: TwwCheckBox
        Left = 20
        Top = 595
        Width = 444
        Height = 17
        HelpContext = 484359
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
        Caption = 'Split the Sales Quantity into Different Units of Measure '
        DataField = 'EnableAutoSplitQtyintoUOMinSales'
        DataSource = dsPrefs
        TabOrder = 22
      end
      object wwCheckBox22: TwwCheckBox
        Left = 20
        Top = 628
        Width = 444
        Height = 17
        HelpContext = 484260
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
        Caption = 'Enforce '#39'Refund'#39' and '#39'Customer Return'#39' Verification'
        DataField = 'RestrictRefund'
        DataSource = dsPrefs
        TabOrder = 23
      end
      object wwCheckBox23: TwwCheckBox
        Left = 20
        Top = 661
        Width = 444
        Height = 17
        HelpContext = 484261
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
        Caption = 
          #39'Invoice'#39' has to be approved before Print / Fax / Email / Paymen' +
          't'
        DataField = 'InvoiceHasToBeApproved'
        DataSource = dsPrefs
        TabOrder = 24
      end
      object wwCheckBox24: TwwCheckBox
        Left = 20
        Top = 693
        Width = 444
        Height = 17
        HelpContext = 484262
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
        Caption = 'Enable Back Order on BOM Sales Order'
        DataField = 'EnableBoinBOMsalesOrder'
        DataSource = dsPrefs
        TabOrder = 25
      end
      object wwCheckBox27: TDBCheckBox
        Left = 20
        Top = 853
        Width = 444
        Height = 25
        HelpContext = 484263
        Caption = 
          'Hide Matrix Line if Qty is 0 in '#39'Sales Order (Matrix-X/Y)'#39' / '#39'In' +
          'voice (Matrix-X/Y)'#39' templates'
        DataField = 'HideMatrixLineWithnoQty'
        DataSource = dsPrefs
        TabOrder = 26
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        WordWrap = True
      end
      object wwCheckBox28: TDBCheckBox
        Left = 20
        Top = 885
        Width = 444
        Height = 25
        HelpContext = 484264
        Caption = 
          'Hide Non Product BOM Entries in '#39'Sales Order (Matrix-X/Y)'#39' / '#39'In' +
          'voice (Matrix-X/Y)'#39' templates'
        DataField = 'HideNonProductBOMEnrties'
        DataSource = dsPrefs
        TabOrder = 27
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        WordWrap = True
      end
      object chkPreventInvoiceOnStopCredit: TwwCheckBox
        Left = 20
        Top = 726
        Width = 444
        Height = 17
        HelpContext = 484377
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
        Caption = 'Prevent Invoice Creation for Customers on Stop Credit'
        DataField = 'PreventInvoiceOnStopCredit'
        DataSource = dsPrefs
        TabOrder = 28
      end
      object chkPreventSalesOrderOnStopCredit: TwwCheckBox
        Left = 20
        Top = 759
        Width = 444
        Height = 17
        HelpContext = 484378
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
        Caption = 'Prevent Sales Order Creation for Customers on Stop Credit'
        DataField = 'PreventSalesOrderOnStopCredit'
        DataSource = dsPrefs
        TabOrder = 29
      end
      object wwCheckBox34: TwwCheckBox
        Left = 20
        Top = 791
        Width = 444
        Height = 17
        HelpContext = 484385
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
        Caption = 'Invoice Class Default All'
        DataField = 'InvoiceClassDefaultAll'
        DataSource = dsPrefs
        TabOrder = 30
      end
      object wwCheckBox62: TDBCheckBox
        Left = 283
        Top = 169
        Width = 222
        Height = 25
        HelpContext = 484386
        Caption = 'Disable Add Customer Special Price for '#39'Cash Customer '#39
        DataField = 'NoCashCustSpecialPriceQuestion'
        DataSource = dsPrefs
        TabOrder = 31
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        WordWrap = True
      end
      object wwCheckBox67: TwwCheckBox
        Left = 20
        Top = 824
        Width = 444
        Height = 17
        HelpContext = 484400
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
        Caption = 'Enforce Con Note On Sale'
        DataField = 'EnforceConNoteOnSale'
        DataSource = dsPrefs
        TabOrder = 32
      end
      object wwCheckBox70: TDBCheckBox
        Left = 20
        Top = 918
        Width = 444
        Height = 25
        HelpContext = 484213
        Caption = 
          'Ship Available Qty on Convertion of Single Sales Order to Invoic' +
          'e  (Sales Order Which doesn'#39't have a Backorder and is not a Back' +
          'order)'
        DataField = 'SoToInvShipWhenAvailable'
        DataSource = dsPrefs
        TabOrder = 33
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        WordWrap = True
      end
      object chkSalesDefaultAreaFromCustomer: TwwCheckBox
        Left = 20
        Top = 955
        Width = 444
        Height = 17
        HelpContext = 484440
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
        Caption = 'Sales '#39'Area'#39' gets value by Default from Customer'
        DataField = 'SalesDefaultAreaFromCustomer'
        DataSource = dsPrefs
        TabOrder = 34
      end
      object wwCheckBox50: TwwCheckBox
        Left = 283
        Top = 202
        Width = 222
        Height = 17
        HelpContext = 484441
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
        Caption = 'Product List Match Customer Area'
        Checked = True
        DataField = 'Sales_ProductlistMatchCustomerArea'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 35
        Visible = False
      end
      object chkSalesTaxThresholdWholeOrder: TwwCheckBox
        Left = 283
        Top = 236
        Width = 222
        Height = 17
        HelpContext = 484442
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
        Caption = 'Sales Tax Threshold Whole Order'
        Checked = True
        DataField = 'SalesTaxThresholdWholeOrder'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 36
      end
    end
    object DNMPanel15: TDNMPanel
      Left = 0
      Top = -2193
      Width = 1065
      Height = 201
      HelpContext = 484155
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 22
      Visible = False
      object Bevel15: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 187
        HelpContext = 484156
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 185
      end
      object Label69: TLabel
        Left = 14
        Top = 14
        Width = 278
        Height = 15
        HelpContext = 484157
        Caption = 'Compulsory Products for New Customer on Runs'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object grdDefaultRunParts: TwwDBGrid
        Left = 25
        Top = 41
        Width = 304
        Height = 136
        HelpContext = 484158
        ControlType.Strings = (
          'ProductName;CustomEdit;cboProduct;F'
          'FreqType;CustomEdit;cboFreqType;F')
        Selected.Strings = (
          'ProductName'#9'13'#9'Product'#9#9
          'Qty'#9'5'#9'Qty'#9#9
          'FreqInterval'#9'3'#9'Interval'#9'F'#9'Frequency'
          'FreqType'#9'10'#9'Type'#9'F'#9'Frequency')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = dsDefaultRunParts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgWordWrap]
        ParentFont = False
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 2
        TitleButtons = False
        FooterColor = clWhite
        FooterCellColor = clWhite
        object btnDelete: TwwIButton
          Left = 0
          Top = 0
          Width = 24
          Height = 33
          HelpContext = 484244
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
          OnClick = btnDeleteClick
        end
      end
      object cboProduct: TwwDBLookupCombo
        Left = 32
        Top = 104
        Width = 145
        Height = 23
        HelpContext = 484245
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        DataField = 'ProductName'
        DataSource = dsDefaultRunParts
        LookupTable = qryParts
        LookupField = 'PartName'
        ParentFont = False
        TabOrder = 1
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object cboFreqType: TwwDBComboBox
        Left = 208
        Top = 104
        Width = 89
        Height = 23
        HelpContext = 484246
        ShowButton = True
        Style = csDropDown
        MapList = False
        AllowClearKey = False
        AutoDropDown = True
        DataField = 'FreqType'
        DataSource = dsDefaultRunParts
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          'Day(s)'
          'Month(s)'
          'Time Only'
          'Week(s)'
          'Year(s)')
        ItemIndex = 2
        ParentFont = False
        Sorted = True
        TabOrder = 2
        UnboundDataType = wwDefault
      end
    end
    object DNMPanel16: TDNMPanel
      Left = 0
      Top = -2338
      Width = 1065
      Height = 145
      HelpContext = 484159
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 23
      Visible = False
      object Bevel16: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 131
        HelpContext = 484160
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitWidth = 530
      end
      object Label70: TLabel
        Left = 14
        Top = 14
        Width = 95
        Height = 15
        HelpContext = 484161
        Caption = 'Delivery Settings'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox40: TwwCheckBox
        Left = 30
        Top = 40
        Width = 333
        Height = 17
        HelpContext = 484165
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
        Caption = 'One run per customer / contact'
        DataField = 'OneRunPerCustomer'
        DataSource = dsPrefs
        TabOrder = 0
      end
      object wwCheckBox41: TwwCheckBox
        Left = 30
        Top = 76
        Width = 333
        Height = 17
        HelpContext = 484166
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
        Caption = 'Auto Correct Pricing in Run Templates / Dispatches'
        DataField = 'AutoCorrectPriceDiscountsOnDeliveries'
        DataSource = dsPrefs
        TabOrder = 1
      end
      object wwCheckBox45: TwwCheckBox
        Left = 30
        Top = 112
        Width = 333
        Height = 17
        HelpContext = 484167
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
        Caption = 'Use History in Dispatch Runs'
        DataField = 'UseHistoryOnDespatchRuns'
        DataSource = dsPrefs
        TabOrder = 2
      end
    end
  end
  inherited tmrdelayMsg: TTimer
    Left = 168
    Top = 80
  end
  object MyConnection: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Server = 'localhost'
    LoginPrompt = False
    Left = 785
    Top = 49
  end
  object dsPrefs: TDataSourcePrefs
    Connection = MyConnection
    FieldDefs = <>
    FieldNames.Strings = (
      'AllClassesOnCustList'
      'AllowAlocationFromOtherClasses'
      'AllowchangeofTermAfterDueDate'
      'AlternateProductSelection'
      'AlwaysShowBOonCustomerCost'
      'ApplyPrepaymentsOnSOConversion'
      'AutoCorrectPriceDiscountsOnDeliveries'
      'AutoGenerateCustomerAccntNumber'
      'AutomaticDeliveryDocketPrint'
      'AutomaticSODeliveryDocketPrint'
      'BOByDefaultOnInvoice'
      'BOByDefaultOnSO'
      'CanEditSalesshiptoAddress'
      'checkforStockinOtherDept'
      'CodeHeader'
      'CombinedInvoiceBO'
      'CombinedSaleOrderBO'
      'ConfirmBeforeInvoiceStockToNegative'
      'ConfirmBeforesalePricechange'
      'ConsolidateCustBOonInvoice'
      'ContainerRelatedProductColour'
      'ContainerRelatedProductGradIntensity'
      'ConvertConvertedSalesOrder'
      'CopySalesOrderShiptotoRepairs'
      'CostonSalesToPO'
      'CurrentDateforSalesshipment'
      'CustomerListMode'
      'CustomerTypeRequired'
      'DefaultDiscountMarkup'
      'DefaultRepUser'
      'DefaultSalesAccount'
      'DefaultSPAAccount'
      'DisableCopyToSmart'
      'DisableCusSourceTracking'
      'DisableInvCopyToSmartIfPOCreated'
      'DisableSaleLineZeroQuantityWarning'
      'EmailInvoiceInfoToCustomer'
      'EmailWhenPrintingPickingSlip'
      'EnableAusEparcel'
      'EnableAutoSplitQtyintoUOMinSales'
      'EnableBoinBOMsalesOrder'
      'EnableInvoiceDelMail'
      'EnableInvoiceMail'
      'EnableInvoicePickMail'
      'EnablequoteVariation'
      'EnforceConNoteOnSale'
      'EnforceCustomerFirstAndLastName'
      'EnforceMatrixAttributes'
      'EnforceNoModifyonNotes'
      'ExcludeBOFromPrintinSales'
      'ExcludeZeroAllocationsFromPickingSlip'
      'ExpenseAccountforRewardPoints'
      'ExpiresOnNoOfMonthsAfterPurchase'
      'filterTaxcodeforClient'
      'FollowupDays'
      'FutureSODays'
      'HideCustomertypeNotSelectedinSalesCatgbyItemReport'
      'HideMatrixLineWithnoQty'
      'HideNonProductBOMEnrties'
      'IncludeContactNameInSalesBillingAddress'
      'IncludeContactNameInSalesshippingAddress'
      'IncludeContactPhoneInSalesshippingAddress'
      'IncludeUnInvoicedSOtoGL'
      'IndicateContainerRelatedProduct'
      'IndicatePalletRelatedProduct'
      'Invoice_Footer'
      'InvoiceClassDefaultAll'
      'InvoiceDelMailSubject'
      'InvoiceDelMailText'
      'InvoiceHasToBeApproved'
      'InvoiceMailSubject'
      'InvoiceMailText'
      'InvoicePickMailSubject'
      'InvoicePickMailText'
      'IsSalesCategoryMandatory'
      'JobNameHeader'
      'JobNumberHeader'
      'LeaveOpenOnCopyToINV'
      'LoadCustnameinNewshippingAddress'
      'ManifestDaysAfterDespatchDate'
      'MatchInvoiceDAteToShipDate'
      'MatchSaleLineShipDateToHeader'
      'MatchSalesLineShipdateToProductDeliveryDays'
      'MaxDiscountPercentage'
      'MinimumMarginPercentage'
      'MinMarkupPercentage'
      'MultiplesofPointstoRedeem'
      'NegativeStockcheckinInvoicebasedon'
      'NoCashCustSpecialPriceQuestion'
      'NoCustSpecialPriceQuestion'
      'OneRunPerCustomer'
      'PadQuotePricesIncTax'
      'PalletRelatedProductColour'
      'PalletRelatedProductGradIntensity'
      'PickingSlipEmailRecipient'
      'PickupShipingMethod'
      'POCreateOptiononSalesToSmartOrderconvertion'
      'PreventInvoiceOnStopCredit'
      'PreventSalesOrderOnStopCredit'
      'PrintAddressLabelfromDelPrint'
      'PrintDelDocketWithInvoice'
      'PrintPickSlipWithInvoice'
      'ProgressPayments'
      'RecalcCostInvBO'
      'RelatedMasterCaptionInSales'
      'ResetCustPrices'
      'RestrictRefund'
      'RetailcustomerType1'
      'RewardPointsExpiredAccount'
      'RewardPointssoldAccount'
      'RoundUpPoints'
      'Sales_ProductlistMatchCustomerArea'
      'SalesDefaultAreaFromCustomer'
      'SalesDefaultValueForAreaFrom'
      'SalesLineLatestCostBasedOn'
      'SalesPrintOrderBy'
      'SalesTaxThresholdWholeOrder'
      'SalesWarrantyEndsOnCaption'
      'SalesWarrantyEndsOnRequired'
      'SalesWarrantyPeriodCaption'
      'SalesWarrantyPeriodRequired'
      'ShippedDaysAfterCreate'
      'ShowAmountToAppearOnPrintout'
      'ShowCustomerJobNoByDefault'
      'ShowDeliveryDetailsformonDeldocketprint'
      'ShowDocketNumberColumnOnSales'
      'ShowGrossProfitPercent'
      'ShowLatestCost'
      'ShowManufacutresummarywhenchangedfromSales'
      'ShowPurchasecostinSales'
      'ShowRelatedMasterinSales'
      'ShowRelatedProductSelectioninSale'
      'ShowRelatedProductsinSales'
      'ShowSaleLineInStockQty'
      'ShowSalesCostInc'
      'ShowSalesDescription'
      'ShowSalesDiscount'
      'ShowSalesProductAutoSelectOptions'
      'ShowSalesProfit'
      'ShowSalesProfitPercent'
      'ShowSalesTaxAmount'
      'ShowSalesTaxCode'
      'ShowSalesUnits'
      'ShowSalesWarrantyEndsOn'
      'ShowSalesWarrantyPeriod'
      'ShowSupplierContactonSO'
      'ShowSupplieronSO'
      'SingleQtySO'
      'SortRelatedProductsinSale'
      'SoToInvShipWhenAvailable'
      'SpecProd_Override_Disc'
      'StartJobNumberField'
      'StatustoMakeInvoice'
      'StatusToMakeSalesOrder'
      'SuppressJobNamesOnInvoices'
      'UnInvoicedSOAccount'
      'UnInvoicedSOLabourAccount'
      'UnInvoicedSOType'
      'UniqueCustomerPONumInSale'
      'UseBarcodePicking'
      'UseDiscontinuedProductPriceforAlternateProduct'
      'UseEmployeeClassForARList'
      'UseForeignCurrencyonSales'
      'UseFutureSO'
      'UseHistoryOnDespatchRuns'
      'UseManifest'
      'UseProductSpecsCalcsSales'
      'USeSalesCommission'
      'UseShippedDateForTerms'
      'UseTemplateDefaultInvoice'
      'UseTNTFreight'
      'ValueforRewardPoints'
      'WarnWhenSalesCreationdateisfuture'
      'WholeSaleCustomerType1'
      'WholeSaleCustomerType2'
      'WholeSaleCustomerType3'
      'WholeSaleCustomerType4'
      'WholeSaleToggleON')
    Left = 817
    Top = 49
  end
  object qryAccUnInvSO: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblChartofAccounts.*, AccDesc as Type'
      'FROM tblChartofAccounts'
      'LEFT JOIN tblacctypedesc on  AccType = AccountType'
      'WHERE IsHeader = '#39'F'#39' AND Active = '#39'T'#39
      'AND AccountType='#39'OCASSET'#39
      'ORDER BY AccDesc, AccountName;')
    Left = 849
    Top = 49
  end
  object qryAccUnInvSOLabour: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblChartofAccounts.*, AccDesc as Type'
      'FROM tblChartofAccounts'
      'LEFT JOIN tblacctypedesc on  AccType = AccountType'
      'WHERE IsHeader = '#39'F'#39' AND Active = '#39'T'#39
      'AND AccountType='#39'OCASSET'#39
      'AND AccountGroup = :xAccountGroup'
      'AND char_length(AccountGroup) > 0'
      'ORDER BY AccDesc, AccountName;')
    Left = 881
    Top = 49
    ParamData = <
      item
        DataType = ftString
        Name = 'xAccountGroup'
        Value = ''
      end>
  end
  object qryAccount: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblChartofAccounts.*, AccDesc as Type'
      'FROM tblChartofAccounts'
      'LEFT JOIN tblacctypedesc on  AccType = AccountType'
      'WHERE IsHeader = '#39'F'#39' AND Active = '#39'T'#39
      'ORDER BY AccDesc, AccountName;')
    Left = 913
    Top = 49
  end
  object dsDefaultRunParts: TDataSource
    DataSet = qryDefaultRunParts
    Left = 945
    Top = 49
  end
  object qryDefaultRunParts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * '
      'FROM tbldefaultrunparts'
      'ORDER BY ProductName;'
      '')
    Left = 977
    Top = 49
  end
  object qryParts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PartsID, PartName, TaxCode'
      'FROM tblparts'
      
        'WHERE Active = "T" AND (PARTTYPE = "INV" OR PARTTYPE = "NONINV" ' +
        'OR PARTTYPE = "OTHER");')
    Left = 817
    Top = 81
  end
  object qryColumnHeadings: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblcolumnheadings')
    Left = 849
    Top = 81
  end
  object dsPersonalPreferences: TDataSource
    DataSet = qryPersonalPreferences
    Left = 881
    Top = 81
  end
  object qryPersonalPreferences: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblpersonalpreferences'
      'WHERE EmployeeID = :EmployeeID;')
    Left = 913
    Top = 81
    ParamData = <
      item
        DataType = ftString
        Name = 'EmployeeID'
        Value = ''
      end>
  end
  object QryRewardPointssoldAccount: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblChartofAccounts.*, AccDesc as Type'
      'FROM tblChartofAccounts'
      'LEFT JOIN tblacctypedesc on  AccType = AccountType'
      'WHERE IsHeader = '#39'F'#39' AND Active = '#39'T'#39
      'AND AccountType='#39'OCLIAB'#39
      'ORDER BY AccDesc, AccountName;')
    Left = 945
    Top = 81
  end
  object qryExpenseAccountforRewardPoints: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblChartofAccounts.*, AccDesc as Type'
      'FROM tblChartofAccounts'
      'LEFT JOIN tblacctypedesc on  AccType = AccountType'
      'WHERE IsHeader = '#39'F'#39' AND Active = '#39'T'#39
      'AND AccountType='#39'COGS'#39
      'ORDER BY AccDesc, AccountName;')
    Left = 1010
    Top = 49
  end
  object QryRewardPointsExpiredAccount: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblChartofAccounts.*, AccDesc as Type'
      'FROM tblChartofAccounts'
      'LEFT JOIN tblacctypedesc on  AccType = AccountType'
      'WHERE IsHeader = '#39'F'#39' AND Active = '#39'T'#39
      'AND AccountType='#39'OCLIAB'#39
      'ORDER BY AccDesc, AccountName;')
    Left = 977
    Top = 81
  end
  object QryStatusforSO: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT id,name FROM tblsimpletypes '
      'WHERE Typecode = '#39'LeadStatusType'#39
      'ORDER BY Name')
    Left = 715
    Top = 53
    object QryStatusforSOname: TWideStringField
      DisplayWidth = 20
      FieldName = 'name'
      Size = 255
    end
    object QryStatusforSOid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
  end
  object QryStatusforInvoice: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT id,name FROM tblsimpletypes '
      'WHERE Typecode = '#39'LeadStatusType'#39
      'ORDER BY Name')
    Left = 747
    Top = 53
    object QryStatusforInvoicename: TWideStringField
      DisplayWidth = 20
      FieldName = 'name'
      Size = 255
    end
    object QryStatusforInvoiceid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
  end
  object QrySaleslinesFields: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select '#39'SaleLineId'#39' as Description, '#39'SaleLineId'#39' as fieldname'
      'union Select '#39'SaleId'#39' as Description, '#39'saleId'#39' as fieldname'
      
        'union Select '#39'Group'#39' as Description, '#39'SalesLinesCustField1'#39' as f' +
        'ieldname')
    Left = 770
    Top = 69
  end
  object mnuEmailconfigfields: TAdvPopupMenu
    Version = '2.5.3.4'
    Left = 736
    Top = 160
  end
  object qryclienttypeLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select typename  , Active  from tblclienttype order by typename')
    Left = 1010
    Top = 81
  end
  object cboViaQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ShippingMethodID, ShippingMethod, 0 AS SortID'
      
        'FROM tblShippingMethods where Active= "T" and ShippingMethod = "' +
        'Quote" '
      'union all'
      'SELECT ShippingMethodID, ShippingMethod, 1 AS SortID'
      'FROM tblShippingMethods '
      'WHERE Active= "T" and ShippingMethod <> "Quote" '
      'ORDER BY SortID, ShippingMethod;')
    Left = 679
    Top = 52
    object cboViaQryShippingMethod: TWideStringField
      DisplayWidth = 25
      FieldName = 'ShippingMethod'
      FixedChar = True
      Size = 15
    end
    object cboViaQryShippingMethodID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'ShippingMethodID'
      ReadOnly = True
      Visible = False
    end
  end
end
