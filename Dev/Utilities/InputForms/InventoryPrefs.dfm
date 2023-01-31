inherited InventoryPrefsGUI: TInventoryPrefsGUI
  Left = 370
  Top = 54
  HelpContext = 371000
  Caption = 'Inventory Preferences'
  ClientHeight = 845
  ClientWidth = 1083
  ExplicitTop = -336
  ExplicitWidth = 1099
  ExplicitHeight = 884
  PixelsPerInch = 96
  TextHeight = 13
  object lblWidth: TLabel [0]
    Left = 8
    Top = 8
    Width = 863
    Height = 22
    HelpContext = 371001
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
  inherited lblSkingroupMsg: TLabel
    Top = 845
    Width = 1083
    HelpContext = 371093
    ExplicitTop = 822
    ExplicitWidth = 891
  end
  inherited sbpanels: TAdvScrollBox
    Width = 1083
    Height = 845
    HelpContext = 371334
    VertScrollBar.Position = 3372
    ExplicitWidth = 1083
    ExplicitHeight = 845
    object DNMPanel4: TDNMPanel
      Left = 0
      Top = 970
      Width = 1064
      Height = 209
      HelpContext = 371211
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      ExplicitTop = 1016
      object Bevel5: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1050
        Height = 195
        HelpContext = 371212
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 1
        ExplicitTop = 4
        ExplicitWidth = 543
        ExplicitHeight = 207
      end
      object Label2: TLabel
        Left = 14
        Top = 14
        Width = 93
        Height = 15
        HelpContext = 371213
        Caption = 'Barcode Picking'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox5: TwwCheckBox
        Left = 24
        Top = 40
        Width = 266
        Height = 17
        HelpContext = 371220
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
        Caption = 'Auto Modify Invoice/SO on Completion'
        Checked = True
        DataField = 'AutoEditInvoiceBarcodePick'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 0
      end
      object wwCheckBox6: TwwCheckBox
        Left = 23
        Top = 73
        Width = 266
        Height = 17
        HelpContext = 371221
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
        Caption = 'Auto Convert SO to Invoice on Completion'
        DataField = 'AutoConvertSOtoInvoiceBarcodePick'
        DataSource = dsPrefs
        TabOrder = 1
      end
      object wwCheckBox7: TwwCheckBox
        Left = 296
        Top = 73
        Width = 222
        Height = 17
        HelpContext = 371048
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
        Caption = 'Print Invoice/SO on Completion'
        Checked = True
        DataField = 'PrintConNotesBarcodePick'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 4
      end
      object wwCheckBox8: TwwCheckBox
        Left = 296
        Top = 40
        Width = 230
        Height = 17
        HelpContext = 371049
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
        Caption = 'Print Delivery Docket on Completion'
        Checked = True
        DataField = 'PrintDelDocketBarcodePick'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 3
      end
      object wwCheckBox9: TwwCheckBox
        Left = 23
        Top = 106
        Width = 266
        Height = 17
        HelpContext = 371222
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
        Caption = 'Print Consignment Note on Completion'
        Checked = True
        DataField = 'PrintInvoiceBarcodePick'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 2
      end
      object wwCheckBox19: TwwCheckBox
        Left = 23
        Top = 139
        Width = 266
        Height = 17
        HelpContext = 371223
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
        Caption = 'Allow To Pick For Other Sales In the Group'
        Checked = True
        DataField = 'AllowToPickFromOthersalesIntheGroup'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 5
      end
      object wwCheckBox21: TwwCheckBox
        Left = 23
        Top = 172
        Width = 327
        Height = 17
        HelpContext = 371224
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
        Caption = 'Allow to Ship and Pick For Backorder in the Group'
        Checked = True
        DataField = 'AllowtoshipnPickFromBackorderinthegroup'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 6
      end
      object chkUseBarcodeDispatch: TwwCheckBox
        Left = 296
        Top = 106
        Width = 222
        Height = 17
        HelpContext = 371237
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
        Caption = 'Use Barcode Dispatch'
        Checked = True
        DataField = 'UseBarcodeDispatch'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 7
      end
    end
    object DNMPanel5: TDNMPanel
      Left = 0
      Top = -3372
      Width = 1064
      Height = 1075
      HelpContext = 371051
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      DesignSize = (
        1064
        1075)
      object Bevel28: TBevel
        Left = 21
        Top = 675
        Width = 1017
        Height = 67
        HelpContext = 371134
        Anchors = [akLeft, akTop, akRight]
        Shape = bsFrame
        ExplicitWidth = 467
      end
      object Bevel6: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1050
        Height = 1061
        HelpContext = 371052
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 14
        ExplicitWidth = 530
        ExplicitHeight = 1011
      end
      object Bevel10: TBevel
        Left = 21
        Top = 343
        Width = 340
        Height = 236
        HelpContext = 371053
        Shape = bsFrame
      end
      object Bevel14: TBevel
        Left = 34
        Top = 398
        Width = 324
        Height = 62
        HelpContext = 371129
      end
      object Bevel13: TBevel
        Left = 34
        Top = 473
        Width = 319
        Height = 51
        HelpContext = 371130
      end
      object Bevel7: TBevel
        Left = 367
        Top = 497
        Width = 160
        Height = 81
        HelpContext = 371186
        Shape = bsFrame
        Visible = False
      end
      object Label9: TLabel
        Left = 14
        Top = 14
        Width = 44
        Height = 15
        HelpContext = 371054
        Caption = 'General'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label18: TLabel
        Left = 21
        Top = 624
        Width = 295
        Height = 15
        HelpContext = 371065
        Alignment = taRightJustify
        Caption = 'Wholesale Percentage ( Markup On Cost Price (Ex) )'
        Transparent = True
      end
      object Label19: TLabel
        Left = 370
        Top = 503
        Width = 153
        Height = 30
        HelpContext = 371068
        Caption = 'Minimum  Line Price Above Cost %'
        Transparent = True
        Visible = False
        WordWrap = True
      end
      object Label10: TLabel
        Left = 29
        Top = 839
        Width = 289
        Height = 15
        HelpContext = 371187
        Caption = 'Round Quantity To                    Places in Product List '
        Transparent = True
        Visible = False
      end
      object Label11: TLabel
        Left = 116
        Top = 376
        Width = 80
        Height = 15
        HelpContext = 371188
        Alignment = taRightJustify
        Caption = 'Minimum cost'
        Transparent = True
      end
      object Label12: TLabel
        Left = 48
        Top = 406
        Width = 148
        Height = 15
        HelpContext = 371189
        Alignment = taRightJustify
        Caption = 'Product Name Starts With'
        Transparent = True
      end
      object Label20: TLabel
        Left = 32
        Top = 349
        Width = 98
        Height = 15
        HelpContext = 371190
        Caption = 'Insurance Report'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label21: TLabel
        Left = 50
        Top = 537
        Width = 116
        Height = 30
        HelpContext = 371191
        Alignment = taRightJustify
        Caption = 'Product Name Order by Starts With '
        Transparent = True
        WordWrap = True
      end
      object Label22: TLabel
        Left = 201
        Top = 527
        Width = 25
        Height = 15
        HelpContext = 371192
        Caption = 'First'
        Transparent = True
      end
      object Label23: TLabel
        Left = 283
        Top = 527
        Width = 43
        Height = 15
        HelpContext = 371193
        Caption = 'Second'
        Transparent = True
      end
      object Label24: TLabel
        Left = 100
        Top = 500
        Width = 64
        Height = 15
        HelpContext = 371194
        Caption = 'Agency Ref'
        Transparent = True
      end
      object Label25: TLabel
        Left = 201
        Top = 477
        Width = 25
        Height = 15
        HelpContext = 371195
        Caption = 'First'
        Transparent = True
      end
      object Label26: TLabel
        Left = 283
        Top = 477
        Width = 43
        Height = 15
        HelpContext = 371196
        Caption = 'Second'
        Transparent = True
      end
      object Label28: TLabel
        Left = 93
        Top = 436
        Width = 103
        Height = 15
        HelpContext = 371197
        Alignment = taRightJustify
        Caption = 'Premium Charged'
        Transparent = True
      end
      object Label29: TLabel
        Left = 21
        Top = 654
        Width = 209
        Height = 15
        HelpContext = 371135
        Caption = 'Product Price (Inc) Rounding Options'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label30: TLabel
        Left = 47
        Top = 717
        Width = 254
        Height = 15
        HelpContext = 371198
        Caption = 'Product Card Price Fields must be set to '#39'Inc'#39
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label31: TLabel
        Left = 25
        Top = 786
        Width = 157
        Height = 15
        HelpContext = 371199
        Alignment = taRightJustify
        Caption = 'Product List Price Multiplier'
        Transparent = True
      end
      object Label34: TLabel
        Left = 17
        Top = 800
        Width = 157
        Height = 14
        HelpContext = 371200
        Alignment = taCenter
        AutoSize = False
        Caption = '(For '#39'Barcode'#39' Template)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Bevel29: TBevel
        Left = 21
        Top = 902
        Width = 1017
        Height = 67
        HelpContext = 371320
        Anchors = [akLeft, akTop, akRight]
        Shape = bsFrame
        ExplicitWidth = 467
      end
      object Label35: TLabel
        Left = 21
        Top = 881
        Width = 258
        Height = 15
        HelpContext = 371321
        Caption = 'Product Automatic Reorder Rounding Options'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox10: TwwCheckBox
        Left = 25
        Top = 41
        Width = 333
        Height = 17
        HelpContext = 371069
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
        Caption = 'Auto Add Barcodes'
        DataField = 'AutoAddBarcodes'
        DataSource = dsPrefs
        TabOrder = 0
      end
      object wwCheckBox11: TwwCheckBox
        Left = 25
        Top = 73
        Width = 333
        Height = 17
        HelpContext = 371070
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
        Caption = 'Auto Add Product Codes'
        DataField = 'AutoAddProdCode'
        DataSource = dsPrefs
        TabOrder = 1
      end
      object wwCheckBox14: TwwCheckBox
        Left = 22
        Top = 592
        Width = 394
        Height = 17
        HelpContext = 371201
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
        Alignment = taLeftJustify
        Caption = 'Enforce UOM Matching on Serial#/Bin/Batch  Automatic Allocation'
        DataField = 'MatchUOMinallocation'
        DataSource = dsPrefs
        TabOrder = 14
      end
      object wwCheckBox15: TwwCheckBox
        Left = 25
        Top = 201
        Width = 333
        Height = 17
        HelpContext = 371074
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
        Caption = 'Show Sold Serial Numbers'
        DataField = 'ShowSoldSerialNumbers'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object wwCheckBox16: TwwCheckBox
        Left = 25
        Top = 265
        Width = 333
        Height = 17
        HelpContext = 371075
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
        Caption = 'Enforce Bin Volume'
        DataField = 'EnforceBinvolume'
        DataSource = dsPrefs
        TabOrder = 4
      end
      object btnChangePrices: TDNMSpeedButton
        Left = 376
        Top = 548
        Width = 147
        Height = 26
        HelpContext = 371076
        Caption = 'Change Prices'
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
        TabOrder = 17
        Visible = False
        AutoDisableParentOnclick = True
        OnClick = btnChangePricesClick
      end
      object wwCheckBox17: TwwCheckBox
        Left = 25
        Top = 233
        Width = 333
        Height = 17
        HelpContext = 371077
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
        Caption = 'Product Class Default All'
        DataField = 'ProductClassDefaultAll'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object edtWholesalePercentage: TEdit
        Left = 350
        Top = 620
        Width = 66
        Height = 23
        HelpContext = 371080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        OnExit = edtWholesalePercentageExit
      end
      object edtMinAboveCost: TEdit
        Left = 440
        Top = 519
        Width = 72
        Height = 23
        HelpContext = 371083
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 16
        Visible = False
        OnExit = edtMinAboveCostExit
      end
      object wwRadioGroup1: TwwRadioGroup
        Left = 367
        Top = 209
        Width = 160
        Height = 81
        HelpContext = 371084
        DisableThemes = False
        TransparentActiveItem = True
        Transparent = True
        Caption = 'Batch Allocation (Pick)'
        DataField = 'AutoPickBatches'
        DataSource = dsPrefs
        Items.Strings = (
          ' Automatic'
          ' Manual')
        TabOrder = 12
        Values.Strings = (
          'True'
          'False')
      end
      object wwRadioGroup2: TwwRadioGroup
        Left = 367
        Top = 302
        Width = 160
        Height = 81
        HelpContext = 371085
        DisableThemes = False
        TransparentActiveItem = True
        Transparent = True
        Caption = 'Bin Allocation (Pick)'
        DataField = 'AutopickBins'
        DataSource = dsPrefs
        Items.Strings = (
          ' Automatic'
          ' Manual')
        TabOrder = 13
        Values.Strings = (
          'True'
          'False')
      end
      object wwRadioGroup4: TwwRadioGroup
        Left = 367
        Top = 23
        Width = 160
        Height = 81
        HelpContext = 371087
        DisableThemes = False
        TransparentActiveItem = True
        Transparent = True
        Caption = 'Manifest Type'
        DataField = 'ManifestType'
        DataSource = dsPrefs
        Items.Strings = (
          ' Invoice'
          ' Sales Order'
          ' Both')
        TabOrder = 10
        Values.Strings = (
          'INVOICE'
          'SALESORDER'
          'BOTH')
      end
      object wwRadioGroup5: TwwRadioGroup
        Left = 367
        Top = 116
        Width = 160
        Height = 81
        HelpContext = 371088
        DisableThemes = False
        TransparentActiveItem = True
        Transparent = True
        Caption = 'Picking Type'
        DataField = 'BarcodePickingType'
        DataSource = dsPrefs
        Items.Strings = (
          ' Invoice'
          ' Sales Order')
        TabOrder = 11
        Values.Strings = (
          'INVOICE'
          'SALESORDER')
      end
      object wwDBSpinEdit1: TwwDBSpinEdit
        Left = 137
        Top = 835
        Width = 45
        Height = 23
        HelpContext = 371136
        Increment = 1.000000000000000000
        DataField = 'QtyRoundTo'
        DataSource = dsPrefs
        TabOrder = 5
        UnboundDataType = wwDefault
        Visible = False
      end
      object wwDBEdit2: TwwDBEdit
        Left = 201
        Top = 372
        Width = 67
        Height = 23
        HelpContext = 371202
        DataField = 'InsuranceProductListMinCost'
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
      object wwDBEdit3: TwwDBEdit
        Left = 201
        Top = 402
        Width = 152
        Height = 23
        HelpContext = 371203
        DataField = 'InsuranceProductNameStartsWith'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit4: TwwDBEdit
        Left = 172
        Top = 544
        Width = 83
        Height = 23
        HelpContext = 371204
        DataField = 'InsurancereportOrderbyProductNameStartswith1'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit5: TwwDBEdit
        Left = 263
        Top = 544
        Width = 83
        Height = 23
        HelpContext = 371205
        DataField = 'InsurancereportOrderbyProductNameStartswith2'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit6: TwwDBEdit
        Left = 172
        Top = 496
        Width = 83
        Height = 23
        HelpContext = 371206
        DataField = 'InsuranceAgencyREf1'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 18
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit10: TwwDBEdit
        Left = 263
        Top = 496
        Width = 83
        Height = 23
        HelpContext = 371207
        DataField = 'InsuranceAgencyREf2'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 19
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit11: TwwDBEdit
        Left = 201
        Top = 432
        Width = 152
        Height = 23
        HelpContext = 371208
        DataField = 'InsurancePremiumcharged'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 20
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object chkRoundLotsnfrom: TwwCheckBox
        Left = 48
        Top = 691
        Width = 417
        Height = 17
        HelpContext = 371137
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
          'Round  in Lots of                        cents and Round from   ' +
          '                      Cents'
        DataField = 'ProductPriceRoundLotsnRoundup'
        DataSource = dsPrefs
        TabOrder = 21
      end
      object wwRadioGroup3: TwwRadioGroup
        Left = 277
        Top = 753
        Width = 212
        Height = 81
        HelpContext = 371209
        DisableThemes = False
        TransparentActiveItem = True
        Transparent = True
        Caption = 'Product List Price Calculated on'
        DataField = 'ProductListPriceMultiplierOn'
        DataSource = dsPrefs
        Items.Strings = (
          'Cost Ex'
          'Cost Inc')
        TabOrder = 24
        Values.Strings = (
          'CE'
          'CI')
      end
      object wwDBEdit12: TwwDBEdit
        Left = 188
        Top = 782
        Width = 83
        Height = 23
        HelpContext = 371210
        DataField = 'ProductListPriceMultiplier'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 25
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwCheckBox25: TwwCheckBox
        Left = 25
        Top = 105
        Width = 333
        Height = 17
        HelpContext = 371324
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
        Caption = 'Validate Allocation and Show Warning'
        DataField = 'ValidateAllocation'
        DataSource = dsPrefs
        TabOrder = 26
      end
      object wwCheckBox26: TwwCheckBox
        Left = 25
        Top = 137
        Width = 333
        Height = 17
        HelpContext = 371325
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
        Caption = 'Enforce Allocation Everywhere'
        DataField = 'EnforceAllocationValidation'
        DataSource = dsPrefs
        TabOrder = 27
      end
      object wwCheckBox27: TwwCheckBox
        Left = 25
        Top = 169
        Width = 333
        Height = 17
        HelpContext = 371326
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
        Caption = 'Enforce Allocation in Partial Invoicing in Sales Order'
        DataField = 'EnforceAllocationValidationinPI'
        DataSource = dsPrefs
        TabOrder = 28
      end
      object wwCheckBox30: TwwCheckBox
        Left = 25
        Top = 298
        Width = 333
        Height = 17
        HelpContext = 371330
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
        Caption = 'Count Sales Back Orders in Available'
        DataField = 'CountSOBOInAvailable'
        DataSource = dsPrefs
        TabOrder = 31
      end
      object wwCheckBox24: TwwCheckBox
        Left = 22
        Top = 988
        Width = 356
        Height = 17
        HelpContext = 371335
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
        Caption = 'Auto Locate Product when List is Opened'
        DataField = 'AutoLocateproductinList'
        DataSource = dsPrefs
        TabOrder = 33
      end
      object chkAutoLocateLastRecord: TwwCheckBox
        Left = 296
        Top = 988
        Width = 356
        Height = 17
        HelpContext = 371336
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
        Caption = 'Auto Locate Record When List is Opened'
        DataField = 'AutoLocateLastRecord'
        DataSource = dsPrefs
        TabOrder = 32
      end
      object wwCheckBox28: TwwCheckBox
        Left = 44
        Top = 924
        Width = 300
        Height = 17
        HelpContext = 371328
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'chkProductReorderRoundNearest'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Round to the nearest                                      Units'
        DataField = 'ProductReorderRoundNearest'
        DataSource = dsPrefs
        TabOrder = 30
      end
      object cbxProductReorderRoundValue: TComboBox
        Left = 190
        Top = 921
        Width = 85
        Height = 23
        HelpContext = 371327
        TabOrder = 29
        Text = 'cbxProductReorderRoundValue'
        OnChange = cbxProductReorderRoundValueChange
      end
      object edtRoundUp: TwwDBSpinEdit
        Left = 370
        Top = 688
        Width = 56
        Height = 23
        HelpContext = 371139
        Increment = 1.000000000000000000
        DataField = 'ProductPriceRoundUp'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 23
        UnboundDataType = wwDefault
      end
      object spedtRoundLotsOf: TwwDBSpinEdit
        Left = 170
        Top = 688
        Width = 56
        Height = 23
        HelpContext = 371138
        Increment = 1.000000000000000000
        DataField = 'ProductPriceRoundLotsof'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 22
        UnboundDataType = wwDefault
      end
      object wwCheckBox12: TwwCheckBox
        Left = 22
        Top = 1028
        Width = 356
        Height = 17
        HelpContext = 371337
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
        Caption = 'Do Update Product Qty Sum for API List'
        DataField = 'DoUpdateProductQtySum'
        DataSource = dsPrefs
        TabOrder = 34
      end
    end
    object DNMPanel6: TDNMPanel
      Left = 0
      Top = 812
      Width = 1064
      Height = 158
      HelpContext = 371013
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      ExplicitTop = 858
      object Bevel11: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1050
        Height = 144
        HelpContext = 371015
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 6
        ExplicitWidth = 529
        ExplicitHeight = 143
      end
      object Bevel12: TBevel
        Left = 24
        Top = 36
        Width = 502
        Height = 101
        HelpContext = 371014
        Shape = bsFrame
      end
      object Label32: TLabel
        Left = 14
        Top = 14
        Width = 89
        Height = 15
        HelpContext = 371016
        Caption = 'Unit of Measure'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label33: TLabel
        Left = 83
        Top = 57
        Width = 336
        Height = 15
        HelpContext = 371019
        Caption = 
          'Default Measure for Weight :                             (ie. Kg' +
          ', Pounds)'
        Transparent = True
      end
      object Label37: TLabel
        Left = 64
        Top = 103
        Width = 358
        Height = 15
        HelpContext = 371143
        Caption = 
          'Default Measure for Dimension :                             (ie.' +
          ' mm, inches)'
        Transparent = True
      end
      object wwDBEdit8: TwwDBEdit
        Left = 257
        Top = 53
        Width = 65
        Height = 23
        HelpContext = 371023
        DataField = 'UOMWeightUOM'
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
      object wwDBEdit9: TwwDBEdit
        Left = 257
        Top = 101
        Width = 65
        Height = 23
        HelpContext = 371144
        DataField = 'UOMVolumeDimensionUOM'
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
    object DNMPanel7: TDNMPanel
      Left = 0
      Top = 473
      Width = 1064
      Height = 339
      HelpContext = 371145
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      ExplicitTop = 519
      DesignSize = (
        1064
        339)
      object Bevel15: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1050
        Height = 325
        HelpContext = 371146
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 10
        ExplicitTop = 13
        ExplicitWidth = 529
        ExplicitHeight = 322
      end
      object Bevel16: TBevel
        Left = 80
        Top = 77
        Width = 559
        Height = 173
        HelpContext = 371148
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsLeftLine
        ExplicitWidth = 558
      end
      object Bevel17: TBevel
        Left = 31
        Top = 77
        Width = 482
        Height = 173
        HelpContext = 371147
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitWidth = 481
      end
      object Label39: TLabel
        Left = 14
        Top = 14
        Width = 216
        Height = 15
        HelpContext = 371149
        Caption = 'Products  : Fields to calculate Quantity'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label42: TLabel
        Left = 26
        Top = 258
        Width = 163
        Height = 15
        HelpContext = 371102
        Caption = 'Colour for the Order Quantity'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label43: TLabel
        Left = 316
        Top = 258
        Width = 176
        Height = 15
        HelpContext = 371103
        Caption = 'Colour for the Shipped Quantity'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label41: TLabel
        Left = 38
        Top = 55
        Width = 38
        Height = 15
        HelpContext = 371101
        Anchors = [akTop, akRight]
        Caption = 'Enable'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
        ExplicitLeft = 39
      end
      object Label40: TLabel
        Left = 146
        Top = 55
        Width = 92
        Height = 16
        HelpContext = 371100
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'Caption'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
        ExplicitLeft = 147
      end
      object chkPartCalcfield1: TwwCheckBox
        Left = 52
        Top = 88
        Width = 16
        Height = 17
        HelpContext = 371073
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
        Caption = 'Enable Product'#39's Fields to calculate Quantity - 1'
        DataField = 'PartCalcfield1'
        DataSource = dsPrefs
        TabOrder = 0
        OnExit = chkPartCalcfield1Exit
      end
      object chkPartCalcfield2: TwwCheckBox
        Left = 52
        Top = 121
        Width = 16
        Height = 17
        HelpContext = 371151
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
        Caption = 'Enable Product'#39's Fields to calculate Quantity - 2'
        DataField = 'PartCalcfield2'
        DataSource = dsPrefs
        TabOrder = 1
        OnExit = chkPartCalcfield2Exit
      end
      object chkPartCalcfield4: TwwCheckBox
        Left = 52
        Top = 188
        Width = 16
        Height = 17
        HelpContext = 371152
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
        Caption = 'Enable Product'#39's Fields to calculate Quantity - 4'
        DataField = 'PartCalcfield4'
        DataSource = dsPrefs
        TabOrder = 2
        OnExit = chkPartCalcfield4Exit
      end
      object chkPartCalcfield3: TwwCheckBox
        Left = 52
        Top = 155
        Width = 16
        Height = 17
        HelpContext = 371153
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
        Caption = 'Enable Product'#39's Fields to calculate Quantity - 3'
        DataField = 'PartCalcfield3'
        DataSource = dsPrefs
        TabOrder = 3
        OnExit = chkPartCalcfield3Exit
      end
      object chkPartCalcfield5: TwwCheckBox
        Left = 52
        Top = 222
        Width = 16
        Height = 17
        HelpContext = 371154
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
        Caption = 'Enable Product'#39's Fields to calculate Quantity - 4'
        DataField = 'PartCalcfield5'
        DataSource = dsPrefs
        TabOrder = 4
        OnExit = chkPartCalcfield5Exit
      end
      object edtPartCalcField1: TwwDBEdit
        Left = 96
        Top = 85
        Width = 400
        Height = 23
        HelpContext = 371104
        DataField = 'PartCalcField1Name'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object edtPartCalcField2: TwwDBEdit
        Left = 96
        Top = 118
        Width = 400
        Height = 23
        HelpContext = 371105
        DataField = 'PartCalcfield2Name'
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
      object edtPartCalcField3: TwwDBEdit
        Left = 96
        Top = 152
        Width = 400
        Height = 23
        HelpContext = 371106
        DataField = 'PartCalcfield3Name'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object edtPartCalcField4: TwwDBEdit
        Left = 96
        Top = 185
        Width = 400
        Height = 23
        HelpContext = 371107
        DataField = 'PartCalcfield4Name'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object edtPartCalcField5: TwwDBEdit
        Left = 96
        Top = 219
        Width = 400
        Height = 23
        HelpContext = 371108
        DataField = 'PartCalcfield5Name'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object QtysoldColorSelector: TAdvOfficeColorSelector
        Left = 26
        Top = 283
        Width = 26
        Height = 26
        HelpContext = 371109
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
        TabOrder = 10
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
        OnSelectColor = QtySoldColorSelectorSelectColor
      end
      object QtySoldGradIntensity: TAdvTrackBar
        Left = 59
        Top = 283
        Width = 160
        Height = 27
        HelpContext = 371110
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
        TabOrder = 11
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
      object QtyshippedColorSelector: TAdvOfficeColorSelector
        Left = 316
        Top = 283
        Width = 26
        Height = 26
        HelpContext = 371111
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
        TabOrder = 12
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
        OnSelectColor = QtyshippedColorSelectorSelectColor
      end
      object QtyShippedGradIntensity: TAdvTrackBar
        Left = 349
        Top = 283
        Width = 160
        Height = 27
        HelpContext = 371112
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
        TabOrder = 13
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
    object DNMPanel8: TDNMPanel
      Left = 0
      Top = -314
      Width = 1064
      Height = 593
      HelpContext = 371155
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      DesignSize = (
        1064
        593)
      object Bevel19: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1050
        Height = 579
        HelpContext = 371156
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 9
        ExplicitWidth = 1081
        ExplicitHeight = 532
      end
      object Label44: TLabel
        Left = 25
        Top = 389
        Width = 182
        Height = 15
        HelpContext = 371159
        Anchors = [akLeft, akBottom]
        Caption = 'Indicate when Allocation is done'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
        ExplicitTop = 288
      end
      object Label36: TLabel
        Left = 16
        Top = 12
        Width = 56
        Height = 15
        HelpContext = 371255
        Caption = 'Allocation'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox22: TwwCheckBox
        Left = 39
        Top = 52
        Width = 333
        Height = 17
        HelpContext = 371162
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
        Caption = 'Use Allocation Batch Expiry Date'
        DataField = 'ShowAllocationBatchExpiryDate'
        DataSource = dsPrefs
        TabOrder = 0
        OnExit = chkPartCalcfield1Exit
      end
      object wwCheckBox23: TwwCheckBox
        Left = 39
        Top = 86
        Width = 333
        Height = 17
        HelpContext = 371257
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
        Caption = 'Use Allocation Batch Truck Load Number'
        DataField = 'ShowAllocationBatchTruckLoadNo'
        DataSource = dsPrefs
        TabOrder = 1
        OnExit = chkPartCalcfield1Exit
      end
      object DNMPanel9: TDNMPanel
        Left = 24
        Top = 412
        Width = 966
        Height = 167
        HelpContext = 371258
        Anchors = [akLeft, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object Bevel21: TBevel
          Left = 176
          Top = 0
          Width = 10
          Height = 167
          HelpContext = 371158
          Shape = bsLeftLine
        end
        object Bevel22: TBevel
          Left = 112
          Top = 34
          Width = 306
          Height = 12
          HelpContext = 371160
          Shape = bsTopLine
        end
        object Bevel23: TBevel
          Left = 112
          Top = 0
          Width = 10
          Height = 167
          HelpContext = 371161
          Shape = bsLeftLine
        end
        object Label45: TLabel
          Left = 67
          Top = 51
          Width = 33
          Height = 15
          HelpContext = 371259
          Caption = 'Batch'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label46: TLabel
          Left = 23
          Top = 89
          Width = 77
          Height = 15
          HelpContext = 371116
          Caption = 'Bin Locations'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label47: TLabel
          Left = 15
          Top = 123
          Width = 81
          Height = 15
          HelpContext = 371117
          Caption = 'Serial Number'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label48: TLabel
          Left = 133
          Top = 12
          Width = 38
          Height = 15
          HelpContext = 371114
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
        object Label49: TLabel
          Left = 265
          Top = 10
          Width = 92
          Height = 16
          HelpContext = 371113
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
        object SNAllocationGradIntensity: TAdvTrackBar
          Left = 220
          Top = 117
          Width = 160
          Height = 27
          HelpContext = 371123
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
          TabOrder = 0
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
          OnChange = SNAllocationGradIntensityChange
        end
        object SNAllocationColour: TAdvOfficeColorSelector
          Left = 188
          Top = 117
          Width = 26
          Height = 26
          HelpContext = 371122
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
          TabOrder = 1
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
          OnSelectColor = SNAllocationColourSelectColor
        end
        object BinAllocationColour: TAdvOfficeColorSelector
          Left = 188
          Top = 74
          Width = 26
          Height = 26
          HelpContext = 371120
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
          OnSelectColor = BinAllocationColourSelectColor
        end
        object BinAllocationGradIntensity: TAdvTrackBar
          Left = 220
          Top = 79
          Width = 160
          Height = 27
          HelpContext = 371121
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
          OnChange = BinAllocationGradIntensityChange
        end
        object BatchAllocationGradIntensity: TAdvTrackBar
          Left = 220
          Top = 41
          Width = 160
          Height = 27
          HelpContext = 371119
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
          TabOrder = 4
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
          OnChange = BatchAllocationGradIntensityChange
        end
        object BatchAllocationColour: TAdvOfficeColorSelector
          Left = 187
          Top = 41
          Width = 26
          Height = 26
          HelpContext = 371118
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
          TabOrder = 5
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
          OnSelectColor = BatchAllocationColourSelectColor
        end
        object wwCheckBox4: TwwCheckBox
          Left = 144
          Top = 122
          Width = 16
          Height = 17
          HelpContext = 371164
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
          Caption = 'Indicate when Allocation is Done For Serial Number'
          DataField = 'IndicateifSNAllocated'
          DataSource = dsPrefs
          TabOrder = 6
          OnExit = chkPartCalcfield3Exit
        end
        object wwCheckBox2: TwwCheckBox
          Left = 144
          Top = 84
          Width = 16
          Height = 17
          HelpContext = 371163
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
          Caption = 'Indicate when Allocation is Done For Bin Location'
          DataField = 'IndicateifBinAllocated'
          DataSource = dsPrefs
          TabOrder = 7
          OnExit = chkPartCalcfield2Exit
        end
        object wwCheckBox1: TwwCheckBox
          Left = 144
          Top = 46
          Width = 16
          Height = 17
          HelpContext = 371260
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
          Caption = 'Indicate when Allocation is Done For Batch'
          DataField = 'IndicateifBatchAllocated'
          DataSource = dsPrefs
          TabOrder = 8
          OnExit = chkPartCalcfield1Exit
        end
      end
      object wwRadioGroup6: TwwRadioGroup
        Left = 40
        Top = 126
        Width = 289
        Height = 121
        HelpContext = 371261
        DisableThemes = False
        Caption = 'Batch Truck Load Number For New Record'
        DataField = 'AllocationBatchTruckLoadNoGenerateMode'
        DataSource = dsPrefs
        Items.Strings = (
          '  Next Number in Sequence'
          '  Copy the Previous Number'
          '  Blank')
        TabOrder = 3
        WordWrap = True
        Values.Strings = (
          'G'
          'S'
          'B')
      end
      object wwCheckBox31: TwwCheckBox
        Left = 39
        Top = 268
        Width = 333
        Height = 17
        HelpContext = 371338
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
        Caption = 'Allow Changing Product Allocation Flags'
        DataField = 'AllowChangingProductAllocationFlags'
        DataSource = dsPrefs
        TabOrder = 4
        OnExit = chkPartCalcfield1Exit
      end
      object DNMPanel1: TDNMPanel
        Left = 64
        Top = 284
        Width = 299
        Height = 55
        HelpContext = 371339
        BevelKind = bkFlat
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 5
        object Label3: TLabel
          AlignWithMargins = True
          Left = 1
          Top = 1
          Width = 293
          Height = 49
          HelpContext = 371256
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alClient
          Caption = 
            'When the Serial Nos / Batches / Bins already allocated For the P' +
            'roduct,  You Can Only Turn Off Batch / Bin / SN Tracking.  You C' +
            'annot Turn it back ON'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
          ExplicitHeight = 45
        end
      end
      object chkGrossWeightnQtyRelated: TwwCheckBox
        Left = 39
        Top = 352
        Width = 307
        Height = 17
        HelpContext = 371285
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
        Caption = 'Gross/Net Weight and Qty Are Related'
        Checked = True
        DataField = 'GrossWeightnQtyRelated'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 6
      end
    end
    object DNMPanel10: TDNMPanel
      Tag = 11
      Left = 0
      Top = -484
      Width = 1064
      Height = 170
      HelpContext = 371274
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      object Bevel20: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1050
        Height = 156
        HelpContext = 371275
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 8
        ExplicitWidth = 531
        ExplicitHeight = 263
      end
      object Label50: TLabel
        Left = 14
        Top = 14
        Width = 187
        Height = 15
        HelpContext = 371276
        Caption = 'Product Allocation Custom Fields'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label51: TLabel
        Left = 101
        Top = 86
        Width = 34
        Height = 15
        HelpContext = 371331
        Alignment = taRightJustify
        Caption = 'Tubes'
        Transparent = True
      end
      object Label1: TLabel
        Left = 93
        Top = 48
        Width = 42
        Height = 15
        HelpContext = 371280
        Alignment = taRightJustify
        Caption = 'Length '
        Transparent = True
      end
      object wwCheckBox33: TwwCheckBox
        Left = 56
        Top = 48
        Width = 16
        Height = 17
        HelpContext = 371340
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
        Caption = 'EnableP Length Product Allocation Custom Field'
        Checked = True
        DataField = 'EnablePQADEtailsCUSTFLD1'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 4
      end
      object edtPQADEtailsCUSTFLD1: TwwDBEdit
        Left = 148
        Top = 44
        Width = 170
        Height = 23
        HelpContext = 371286
        DataField = 'PQADEtailsCUSTFLD1'
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
        OnChange = edtPQADEtailsCUSTFLD1Change
      end
      object chkUseCustFld1ForSaleLineBatchAllocation: TwwCheckBox
        Left = 57
        Top = 125
        Width = 337
        Height = 17
        HelpContext = 371287
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
        Caption = 'Use Custom Field For Sales Line Batch Allocation'
        DataField = 'UseCustFld1ForSaleLineBatchAllocation'
        DataSource = dsPrefs
        TabOrder = 1
      end
      object wwCheckBox29: TwwCheckBox
        Left = 56
        Top = 85
        Width = 16
        Height = 17
        HelpContext = 371332
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
        Caption = 'EnableP Tube Product Allocation Custom Field'
        Checked = True
        DataField = 'EnablePQADEtailsCUSTFLD4'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 2
      end
      object wwDBEdit13: TwwDBEdit
        Left = 148
        Top = 82
        Width = 170
        Height = 23
        HelpContext = 371333
        DataField = 'PQADEtailsCUSTFLD4'
        DataSource = dsPrefs
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
        OnChange = edtPQADEtailsCUSTFLD1Change
      end
    end
    object DNMPanel12: TDNMPanel
      AlignWithMargins = True
      Left = 3
      Top = -1155
      Width = 1058
      Height = 668
      HelpContext = 371038
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      object Label52: TLabel
        AlignWithMargins = True
        Left = 13
        Top = 4
        Width = 1041
        Height = 15
        HelpContext = 371040
        Margins.Left = 12
        Align = alTop
        Caption = 'Default Value for Inventory Products'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
        ExplicitWidth = 203
      end
      object pnldefProductvalues4: TDNMPanel
        Left = 1
        Top = 527
        Width = 1056
        Height = 139
        HelpContext = 371341
        Margins.Left = 6
        Margins.Top = 0
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Bevel9: TBevel
          AlignWithMargins = True
          Left = 6
          Top = 0
          Width = 1044
          Height = 133
          HelpContext = 371342
          Margins.Left = 6
          Margins.Top = 0
          Margins.Right = 6
          Margins.Bottom = 6
          Align = alClient
          Shape = bsFrame
          ExplicitLeft = 14
          ExplicitWidth = 531
        end
        object Label4: TLabel
          Left = 14
          Top = 14
          Width = 75
          Height = 15
          HelpContext = 371266
          Caption = 'Default Class'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          Transparent = True
        end
        object grdDefaultClass: TwwDBGrid
          Left = 110
          Top = 31
          Width = 328
          Height = 93
          HelpContext = 371092
          ControlType.Strings = (
            'ClassName;CustomEdit;cboClassName;F')
          Selected.Strings = (
            'ClassName'#9'39'#9'Class Name'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          DataSource = dsPartsClassPreferences
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
          OnExit = grdDefaultClassExit
          FooterColor = clWhite
          FooterCellColor = clWhite
          object btnDelete: TwwIButton
            Left = 0
            Top = 0
            Width = 22
            Height = 23
            HelpContext = 371094
            AllowAllUp = True
            Caption = 'x'
            Glyph.Data = {
              C6030000424DC603000000000000360000002800000010000000130000000100
              18000000000090030000120B0000120B00000000000000000000CCCCCCCCCCCC
              CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
              CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC0C0C0CBCBCBCBCBCBCBCBCBCCCCCCCC
              CCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCBCBCBCBCBCBCCCCCCD7D7D7C0C0C0
              666699969696969696999999CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCB9999
              99868686999999CBCBCBDDDDDDB2B2B2333399666666777777868686C0C0C0CC
              CCCCCCCCCCCCCCCCCCCCCCCBCBCB777777666666868686CBCBCBDDDDDDB2B2B2
              333399333366666666808080969696CBCBCBCCCCCCCCCCCCD7D7D7C0C0C03333
              99777777999999CBCBCBD7D7D7CBCBCB808080333366000080333366868686C0
              C0C0CCCCCCCCCCCCC0C0C0808080333399B2B2B2D7D7D7CCCCCCCBCBCBE6E6E6
              C0C0C0333399000080333366808080999999C0C0C06666993333993333667777
              77C0C0C0D7D7D7CCCCCCC9CACBCCCCCCCCCCCC33339900008033339966666686
              8686B2B2B2333399000080333366969696CBCBCBD7D7D7CCCCCCCBCBCCCCCCCC
              B2B2B2808080333366000080333366777777777777333366000080333399C0C0
              C0CCCCCCCCCCCCCCCCCCCACACCCCCCCCCCCCCCC0C0C033339900008000008000
              0080000080000080333399C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC9C9CBCCCCCC
              CCCCD1CCCCCC9696966666660000800000800000805F5F5F969696CCCCCCCCCC
              CCCCCCCCCCCCCCCCCCCCCCCCCCC7C7C9C0C0C0C0C0C096969666666600008000
              0080333366777777999999C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC3C3CCB8B8B8
              868686808080666699333399333399000080333366666666808080969696C0C0
              C0CCCCCCCCCCCCCCCCCCA4A0A0868686333399666699B2B2B2CCCCCCC0C0C080
              8080333366333366333366777777969696C0C0C0CCCCCCCCCCCCC0C0C0C0C0C0
              B2B2B2C0C0C0CCCCCCD7D7D7D7D7D7C0C0C07777773333660000803333668080
              80868686999999CBCBCBD7D7D7D7D7D7DDDDDDDDDDDDCCCCCCCCCCCCCCCCCCCC
              CCCC999999666699333399333366777777868686999999CBCBCBCCCCCCCCCCCC
              CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCCCCCCB2B2B23333993366
              99B2B2B2CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
              CCCCCCCCCCCCCCCCCCCCCCC0C0C0C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
              CCCCCCC5C5C5CCCCCCCFCFCFCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCD7D7D7D7D7
              D7CCCCCCCCCCCCCCCCCC}
            Layout = blGlyphRight
            Margin = 1
            OnClick = btnDeleteClick
          end
        end
        object cboClassName: TwwDBLookupCombo
          Left = 169
          Top = 87
          Width = 121
          Height = 23
          HelpContext = 371095
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'ClassName'#9'60'#9'ClassName'#9#9)
          DataField = 'ClassName'
          DataSource = dsPartsClassPreferences
          LookupTable = qryClass
          LookupField = 'ClassName'
          TabOrder = 1
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          ShowMatchText = True
        end
      end
      object pnldefProductvalues3: TDNMPanel
        Left = 1
        Top = 330
        Width = 1056
        Height = 197
        HelpContext = 371343
        Margins.Left = 6
        Margins.Top = 0
        Margins.Right = 6
        Margins.Bottom = 0
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object Bevel8: TBevel
          AlignWithMargins = True
          Left = 6
          Top = 0
          Width = 1044
          Height = 197
          HelpContext = 371344
          Margins.Left = 6
          Margins.Top = 0
          Margins.Right = 6
          Margins.Bottom = 0
          Align = alClient
          Shape = bsFrame
          ExplicitLeft = 8
          ExplicitTop = 14
          ExplicitWidth = 530
          ExplicitHeight = 1011
        end
        object Label5: TLabel
          Left = 125
          Top = 132
          Width = 84
          Height = 15
          HelpContext = 371232
          Alignment = taRightJustify
          Caption = 'Stock Transfer'
          Transparent = True
        end
        object Label13: TLabel
          Left = 167
          Top = 100
          Width = 42
          Height = 15
          HelpContext = 371034
          Alignment = taRightJustify
          Caption = 'Income'
          Transparent = True
        end
        object Label15: TLabel
          Left = 176
          Top = 71
          Width = 33
          Height = 15
          HelpContext = 371033
          Alignment = taRightJustify
          Caption = 'Asset'
          Transparent = True
        end
        object Label14: TLabel
          Left = 176
          Top = 41
          Width = 33
          Height = 15
          HelpContext = 371032
          Alignment = taRightJustify
          Caption = 'COGS'
          Transparent = True
        end
        object Label16: TLabel
          Left = 14
          Top = 14
          Width = 97
          Height = 15
          HelpContext = 371270
          Caption = 'Default Accounts'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          Transparent = True
        end
        object DNMSpeedButton1: TDNMSpeedButton
          Left = 215
          Top = 157
          Width = 234
          Height = 23
          Hint = 
            'This will Update all Existing Stock Transfer'#39's Account, to the A' +
            'ccount Selected Here.'
          HelpContext = 371235
          Caption = 'Update All Existing Stock Transfers'
          DisableTransparent = False
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          TabOrder = 0
          AutoDisableParentOnclick = True
          OnClick = DNMSpeedButton1Click
        end
        object wwDBLookupCombo4: TwwDBLookupCombo
          Left = 215
          Top = 128
          Width = 234
          Height = 23
          HelpContext = 371234
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'AccountName'#9'30'#9'Account Name'#9'T'#9
            'Type'#9'20'#9'Type'#9'T'#9)
          DataField = 'DefaultStockTransferAccount'
          DataSource = dsPrefs
          LookupTable = qryAccount
          LookupField = 'AccountName'
          ParentFont = False
          TabOrder = 1
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object wwDBLookupCombo3: TwwDBLookupCombo
          Left = 215
          Top = 96
          Width = 234
          Height = 23
          HelpContext = 371037
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'AccountName'#9'30'#9'Account Name'#9'T'#9
            'Type'#9'20'#9'Type'#9'T'#9)
          DataField = 'DefPartsIncomeAccount'
          DataSource = dsPrefs
          LookupTable = qryAccount
          LookupField = 'AccountID'
          ParentFont = False
          TabOrder = 2
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object wwDBLookupCombo2: TwwDBLookupCombo
          Left = 215
          Top = 67
          Width = 234
          Height = 23
          HelpContext = 371036
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'AccountName'#9'30'#9'Account Name'#9'T'#9
            'Type'#9'20'#9'Type'#9'T'#9)
          DataField = 'DefPartsAssetAccount'
          DataSource = dsPrefs
          LookupTable = qryAccount
          LookupField = 'AccountID'
          ParentFont = False
          TabOrder = 3
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object wwDBLookupCombo1: TwwDBLookupCombo
          Left = 215
          Top = 37
          Width = 234
          Height = 23
          HelpContext = 371035
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'AccountName'#9'30'#9'Account Name'#9'T'
            'Type'#9'20'#9'Type'#9'T')
          DataField = 'DefPartsCOGSAccount'
          DataSource = dsPrefs
          LookupTable = qryAccount
          LookupField = 'AccountID'
          ParentFont = False
          TabOrder = 4
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
      end
      object pnldefProductvalues2: TDNMPanel
        Left = 1
        Top = 229
        Width = 1056
        Height = 101
        HelpContext = 371345
        Margins.Left = 6
        Margins.Top = 0
        Margins.Right = 6
        Margins.Bottom = 0
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object Bevel4: TBevel
          AlignWithMargins = True
          Left = 6
          Top = 0
          Width = 1044
          Height = 101
          HelpContext = 371346
          Margins.Left = 6
          Margins.Top = 0
          Margins.Right = 6
          Margins.Bottom = 0
          Align = alClient
          Shape = bsFrame
          ExplicitLeft = 8
          ExplicitWidth = 531
        end
        object Label8: TLabel
          Left = 14
          Top = 14
          Width = 102
          Height = 15
          HelpContext = 371267
          Caption = 'Default Tax Codes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          Transparent = True
        end
        object Label38: TLabel
          Left = 99
          Top = 42
          Width = 110
          Height = 15
          HelpContext = 371096
          Alignment = taRightJustify
          Caption = 'Purchase Tax Code'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label53: TLabel
          Left = 122
          Top = 72
          Width = 87
          Height = 15
          HelpContext = 371097
          Alignment = taRightJustify
          Caption = 'Sales Tax Code'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object cboTaxCode: TwwDBLookupCombo
          Left = 215
          Top = 69
          Width = 169
          Height = 23
          HelpContext = 371099
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taRightJustify
          Selected.Strings = (
            'Name'#9'5'#9'Tax Code'#9'F'
            'Description'#9'30'#9'Description'#9'T'
            'TaxRatePercent'#9'10'#9'Rate'#9'F')
          DataField = 'DefaultSalesTaxCode'
          DataSource = dsPrefs
          LookupTable = cbTaxCodeQry
          LookupField = 'Name'
          Options = [loColLines, loTitles, loFixedDropDownHeight, loSearchOnBackspace]
          DropDownCount = 5
          DropDownWidth = 350
          ParentFont = False
          TabOrder = 0
          AutoDropDown = True
          ShowButton = True
          OrderByDisplay = False
          PreciseEditRegion = False
          AllowClearKey = False
          OnChange = cboTaxCodeChange
        end
        object cboPURTaxCode: TwwDBLookupCombo
          Left = 215
          Top = 40
          Width = 169
          Height = 23
          HelpContext = 371098
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Name'#9'5'#9'Tax Code'#9'F'
            'Description'#9'30'#9'Description'#9'F'#9
            'TaxRatePercent'#9'10'#9'Rate'#9'F'#9)
          DataField = 'DefaultPurchaseTaxCode'
          DataSource = dsPrefs
          LookupTable = cbTaxCodeQry
          LookupField = 'Name'
          Options = [loColLines, loTitles, loFixedDropDownHeight, loSearchOnBackspace]
          DropDownCount = 5
          DropDownWidth = 350
          ParentFont = False
          TabOrder = 1
          AutoDropDown = True
          ShowButton = True
          OrderByDisplay = False
          PreciseEditRegion = False
          AllowClearKey = False
          OnChange = cboPURTaxCodeChange
        end
      end
      object pnldefProductvalues1: TDNMPanel
        Left = 1
        Top = 22
        Width = 1056
        Height = 207
        HelpContext = 371347
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 0
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        object Bevel1: TBevel
          AlignWithMargins = True
          Left = 7
          Top = 4
          Width = 1042
          Height = 202
          HelpContext = 371348
          Margins.Left = 6
          Margins.Right = 6
          Margins.Bottom = 0
          Align = alClient
          Shape = bsFrame
          ExplicitLeft = 6
          ExplicitTop = 5
          ExplicitWidth = 1041
        end
        object Label54: TLabel
          Left = 73
          Top = 177
          Width = 137
          Height = 15
          HelpContext = 371044
          Alignment = taRightJustify
          Caption = 'Product Volume per Unit'
          Transparent = True
        end
        object Label55: TLabel
          Left = 14
          Top = 12
          Width = 77
          Height = 15
          HelpContext = 371349
          Caption = 'General Flags'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object wwDBEdit1: TwwDBEdit
          Left = 217
          Top = 173
          Width = 83
          Height = 23
          HelpContext = 371169
          DataField = 'DefaultProductVolume'
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
        object wwCheckBox13: TwwCheckBox
          Left = 38
          Top = 103
          Width = 213
          Height = 17
          HelpContext = 371047
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
          Caption = 'Enable '#39'Use Bins'#39
          DataField = 'EnableBinByDefault'
          DataSource = dsPrefs
          TabOrder = 1
        end
        object wwCheckBox3: TwwCheckBox
          Left = 38
          Top = 70
          Width = 213
          Height = 17
          HelpContext = 371046
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
          Caption = 'Enable '#39'Batch Tracking'#39
          Checked = True
          DataField = 'EnableBatchByDefault'
          DataSource = dsPrefs
          State = cbChecked
          TabOrder = 2
        end
        object wwCheckBox20: TwwCheckBox
          Left = 38
          Top = 38
          Width = 213
          Height = 17
          HelpContext = 371050
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
          Caption = 'Enable '#39'Serial Number Tracking'#39
          Checked = True
          DataField = 'EnableSerialsByDefault'
          DataSource = dsPrefs
          State = cbChecked
          TabOrder = 3
        end
        object rgUOMToBeUsedInManufactureDefault: TRadioGroup
          Left = 272
          Top = 43
          Width = 233
          Height = 59
          HelpContext = 371272
          Caption = 'UOM To Be Used In Manufacture'
          Columns = 2
          Items.Strings = (
            'Purchase'
            'Sales')
          TabOrder = 4
          OnClick = rgUOMToBeUsedInManufactureDefaultClick
        end
        object wwCheckBox32: TwwCheckBox
          Left = 38
          Top = 135
          Width = 213
          Height = 17
          HelpContext = 371350
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
          Caption = 'Cost Update From Purchase'
          DataField = 'CostUpdateFromPurchase'
          DataSource = dsPrefs
          TabOrder = 5
        end
      end
    end
    object DNMPanel11: TDNMPanel
      Left = 0
      Top = -1492
      Width = 1064
      Height = 334
      HelpContext = 371165
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      DesignSize = (
        1064
        334)
      object Bevel24: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1050
        Height = 320
        HelpContext = 371166
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 8
        ExplicitWidth = 1049
        ExplicitHeight = 304
      end
      object Label56: TLabel
        Left = 14
        Top = 14
        Width = 164
        Height = 15
        HelpContext = 371167
        Caption = 'Smart Order Quantity Option '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Bevel27: TBevel
        Left = 16
        Top = 57
        Width = 278
        Height = 218
        HelpContext = 371168
        Anchors = [akLeft, akTop, akBottom]
        Shape = bsFrame
        ExplicitHeight = 202
      end
      object Label7: TLabel
        Left = 37
        Top = 299
        Width = 198
        Height = 15
        HelpContext = 371228
        Caption = '(The Rest will be taken from Stock)'
        Transparent = True
      end
      object rgoption: TwwRadioGroup
        Left = 28
        Top = 59
        Width = 261
        Height = 191
        HelpContext = 371128
        DisableThemes = False
        TransparentActiveItem = True
        ShowBorder = False
        ShowGroupCaption = False
        ShowFocusRect = False
        Caption = 'Smart Order based On Quantity Option'
        DataField = 'SmartOrderbasedOn'
        DataSource = dsPrefs
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Items.Strings = (
          'Job Quantity'
          'Available Quantity'
          'Instock Quantity'
          'Available Quantity + On Order Quantity'
          'Instock Quantity + On Order Quantity')
        ParentFont = False
        TabOrder = 0
        Values.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '')
      end
      object chkSubBOMUseAvailableQtyFromStock: TwwCheckBox
        Left = 11
        Top = 281
        Width = 530
        Height = 17
        HelpContext = 371351
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Transparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = '  For Sub BOM, Do Manufacture Based on This Quantity '
        DataField = 'SubBOMUseAvailableQtyFromStock'
        DataSource = dsPrefs
        TabOrder = 1
      end
      object Panel1: TPanel
        Left = 300
        Top = 57
        Width = 200
        Height = 38
        HelpContext = 371352
        BevelOuter = bvLowered
        ParentColor = True
        TabOrder = 2
        object lblhint1: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 2
          Width = 195
          Height = 34
          HelpContext = 371126
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 1
          Align = alClient
          AutoSize = False
          Caption = 
            'Job Quantity will Order Based on the Quantity Required for the J' +
            'ob'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
          ExplicitLeft = 7
          ExplicitTop = 8
          ExplicitWidth = 188
          ExplicitHeight = 30
        end
      end
      object Panel2: TPanel
        Left = 300
        Top = 106
        Width = 200
        Height = 84
        HelpContext = 371353
        BevelOuter = bvLowered
        ParentColor = True
        TabOrder = 3
        object lblhint2: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 2
          Width = 195
          Height = 80
          HelpContext = 371127
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 1
          Align = alClient
          AutoSize = False
          Caption = 
            'All Others will Order Based on What is Required to Reach the Pro' +
            'duct'#39's Preferred Level Quantity as Set in the Product Card'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
          ExplicitLeft = 1
          ExplicitTop = 7
          ExplicitWidth = 193
          ExplicitHeight = 82
        end
      end
      object Panel3: TPanel
        Left = 300
        Top = 201
        Width = 200
        Height = 54
        HelpContext = 371354
        BevelOuter = bvLowered
        ParentColor = True
        TabOrder = 4
        object lblhint3: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 2
          Width = 195
          Height = 50
          HelpContext = 371355
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 1
          Align = alClient
          AutoSize = False
          Caption = 
            'Unprocessed Sales Orders will not affect "Instock Quantity", wil' +
            'l affext the "Available Quantity"'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
          ExplicitLeft = 6
          ExplicitTop = 9
          ExplicitWidth = 189
          ExplicitHeight = 45
        end
      end
    end
    object pnlStandedCost: TDNMPanel
      Left = 0
      Top = -1743
      Width = 1064
      Height = 251
      HelpContext = 371288
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      object Bevel35: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1050
        Height = 237
        HelpContext = 371289
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 145
      end
      object Label59: TLabel
        Left = 14
        Top = 14
        Width = 108
        Height = 15
        HelpContext = 371290
        Caption = 'Stock Cost System'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label60: TLabel
        Left = 29
        Top = 142
        Width = 242
        Height = 15
        HelpContext = 371291
        Alignment = taRightJustify
        Caption = 'Standard Cost Purchase Variance Account'
        Transparent = True
      end
      object Label61: TLabel
        Left = 52
        Top = 177
        Width = 219
        Height = 15
        HelpContext = 371293
        Alignment = taRightJustify
        Caption = 'Standard Cost Sales Variance Account'
        Transparent = True
      end
      object cboStandardCostPurchaseAdjustmentAccountID: TwwDBLookupCombo
        Left = 287
        Top = 141
        Width = 234
        Height = 23
        HelpContext = 371294
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'#9
          'Type'#9'20'#9'Type'#9'T'#9)
        DataField = 'StandardCostPurchaseAdjustmentAccountID'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        ParentFont = False
        TabOrder = 0
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object chkUseStandardCosting: TwwCheckBox
        Left = 148
        Top = 106
        Width = 155
        Height = 17
        HelpContext = 371295
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
        Alignment = taLeftJustify
        Caption = 'Use Standard Costing'
        Checked = True
        DataField = 'UseInventoryStandardCosting'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 1
      end
      object rgStockCostSystem: TwwRadioGroup
        Left = 21
        Top = 39
        Width = 290
        Height = 55
        HelpContext = 371086
        DisableThemes = False
        TransparentActiveItem = True
        Transparent = True
        Caption = 'Cost System'
        Columns = 2
        DataField = 'StockCostSystem'
        DataSource = dsPrefs
        Items.Strings = (
          ' Average'
          ' Last')
        TabOrder = 2
        Values.Strings = (
          '2'
          '1')
        OnChange = rgStockCostSystemChange
      end
      object cboStandardCostCOGSAdjustmentAccountID: TwwDBLookupCombo
        Left = 287
        Top = 176
        Width = 234
        Height = 23
        HelpContext = 371296
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'#9
          'Type'#9'20'#9'Type'#9'T'#9)
        DataField = 'StandardCostCOGSAdjustmentAccountID'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        ParentFont = False
        TabOrder = 3
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object chkCostEditableinSales: TwwCheckBox
        Left = 148
        Top = 212
        Width = 155
        Height = 17
        HelpContext = 371356
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
        Alignment = taLeftJustify
        Caption = 'Can Alter Sales Cost? '
        Checked = True
        DataField = 'CostEditableinSales'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 4
      end
    end
    object DNMPanel13: TDNMPanel
      Left = 0
      Top = -1904
      Width = 1064
      Height = 161
      HelpContext = 371225
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      object Bevel30: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1050
        Height = 147
        HelpContext = 371226
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitWidth = 545
        ExplicitHeight = 185
      end
      object Label62: TLabel
        Left = 14
        Top = 14
        Width = 118
        Height = 15
        HelpContext = 371227
        Caption = 'Smart Order Options'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label63: TLabel
        Left = 28
        Top = 124
        Width = 380
        Height = 15
        HelpContext = 371357
        Caption = 
          'Measure for volume in Smart Order:                             (' +
          'ie. mm, inches)'
        Transparent = True
      end
      object optTotalvolumeUOMInsmartOrder: TwwRadioGroup
        Left = 16
        Top = 34
        Width = 512
        Height = 78
        HelpContext = 371229
        DisableThemes = False
        Caption = 'Divide Total Volume in Smart Order  by '
        Columns = 5
        DataField = 'TotalvolumeUOMInsmartOrder'
        DataSource = dsPrefs
        Items.Strings = (
          'None'
          '10'
          '100'
          '1,000'
          '10,000'
          '100,000'
          '1,000,000'
          '10,000,000'
          '100,000,000'
          '1,000,000,000')
        TabOrder = 0
        Values.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9')
      end
      object wwDBEdit14: TwwDBEdit
        Left = 235
        Top = 121
        Width = 65
        Height = 23
        HelpContext = 371230
        DataField = 'UOMforTotalvolumeInsmartOrder'
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
    object DNMPanel14: TDNMPanel
      Tag = 11
      Left = 0
      Top = -2136
      Width = 1064
      Height = 232
      HelpContext = 371238
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
      object Bevel33: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1050
        Height = 218
        HelpContext = 371239
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 9
        ExplicitTop = 12
        ExplicitWidth = 531
        ExplicitHeight = 252
      end
      object Label64: TLabel
        Left = 14
        Top = 14
        Width = 192
        Height = 15
        HelpContext = 371240
        Caption = 'Product Combo Dropdown Widths'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object lblProductName: TLabel
        Left = 79
        Top = 48
        Width = 84
        Height = 15
        HelpContext = 371067
        Alignment = taRightJustify
        Caption = 'Product Name '
        Transparent = True
      end
      object lblProductfirstcolumn: TLabel
        Left = 92
        Top = 80
        Width = 71
        Height = 15
        HelpContext = 371241
        Alignment = taRightJustify
        Caption = 'First Column'
        Transparent = True
      end
      object lblProductSecondcolumn: TLabel
        Left = 74
        Top = 112
        Width = 89
        Height = 15
        HelpContext = 371242
        Alignment = taRightJustify
        Caption = 'Second Column'
        Transparent = True
      end
      object lblThirdColumn: TLabel
        Left = 88
        Top = 144
        Width = 75
        Height = 15
        HelpContext = 371243
        Alignment = taRightJustify
        Caption = 'Third Column'
        Transparent = True
      end
      object lblSalesDesc: TLabel
        Left = 314
        Top = 47
        Width = 100
        Height = 15
        HelpContext = 371244
        Alignment = taRightJustify
        Caption = 'Sales Description'
        Transparent = True
      end
      object lblPODesc: TLabel
        Left = 291
        Top = 79
        Width = 123
        Height = 15
        HelpContext = 371245
        Alignment = taRightJustify
        Caption = 'Purchase Description'
        Transparent = True
      end
      object lblPreferedSupplier: TLabel
        Left = 309
        Top = 111
        Width = 105
        Height = 15
        HelpContext = 371246
        Alignment = taRightJustify
        Caption = 'Preferred Supplier'
        Transparent = True
      end
      object lblSupProductcode: TLabel
        Left = 287
        Top = 144
        Width = 127
        Height = 15
        HelpContext = 371247
        Alignment = taRightJustify
        Caption = 'Supplier Product Code'
        Transparent = True
      end
      object lblProductcomboWidthHint: TLabel
        Left = 44
        Top = 171
        Width = 457
        Height = 45
        HelpContext = 371273
        Alignment = taCenter
        AutoSize = False
        Caption = 
          'Width of the Columns will not reduce less than the Length of the' +
          ' Label Associated with the Field.  Reduce the Label Name in the ' +
          #39'Product List Headings'#39' Section (just above) as well as the Fiel' +
          'd Length.'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object wwDBEdit7: TwwDBEdit
        Left = 167
        Top = 44
        Width = 66
        Height = 23
        HelpContext = 371082
        DataField = 'ProductNameDropdownWidth'
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
      object wwDBEdit15: TwwDBEdit
        Left = 167
        Top = 76
        Width = 66
        Height = 23
        HelpContext = 371248
        DataField = 'ProductfirstcolumnDropdownWidth'
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
      object wwDBEdit17: TwwDBEdit
        Left = 167
        Top = 108
        Width = 66
        Height = 23
        HelpContext = 371249
        DataField = 'ProductsecondcolumnDropdownWidth'
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
      object wwDBEdit18: TwwDBEdit
        Left = 167
        Top = 140
        Width = 66
        Height = 23
        HelpContext = 371250
        DataField = 'ProductthirdcolumnDropdownWidth'
        DataSource = dsPrefs
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
      object wwDBEdit19: TwwDBEdit
        Left = 418
        Top = 43
        Width = 66
        Height = 23
        HelpContext = 371251
        DataField = 'ProductSalesDescDropdownWidth'
        DataSource = dsPrefs
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
      object wwDBEdit20: TwwDBEdit
        Left = 418
        Top = 75
        Width = 66
        Height = 23
        HelpContext = 371252
        DataField = 'ProductPODescDropdownWidth'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit21: TwwDBEdit
        Left = 418
        Top = 107
        Width = 66
        Height = 23
        HelpContext = 371253
        DataField = 'ProductPreferedSupDropdownWidth'
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
      object wwDBEdit22: TwwDBEdit
        Left = 418
        Top = 140
        Width = 66
        Height = 23
        HelpContext = 371254
        DataField = 'ProductSupplierProductCodeDropdownWidth'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
    end
    object DNMPanel3: TDNMPanel
      Tag = 11
      Left = 0
      Top = -2297
      Width = 1064
      Height = 161
      HelpContext = 371297
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
      object Bevel31: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1050
        Height = 147
        HelpContext = 371298
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 12
        ExplicitTop = 9
        ExplicitWidth = 531
        ExplicitHeight = 186
      end
      object Bevel32: TBevel
        AlignWithMargins = True
        Left = 30
        Top = 35
        Width = 496
        Height = 107
        HelpContext = 371306
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Shape = bsFrame
      end
      object Bevel34: TBevel
        AlignWithMargins = True
        Left = 30
        Top = 70
        Width = 496
        Height = 37
        HelpContext = 371307
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Shape = bsFrame
      end
      object Bevel36: TBevel
        AlignWithMargins = True
        Left = 93
        Top = 35
        Width = 51
        Height = 107
        HelpContext = 371308
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Shape = bsFrame
      end
      object Bevel37: TBevel
        AlignWithMargins = True
        Left = 324
        Top = 35
        Width = 202
        Height = 107
        HelpContext = 371309
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Shape = bsFrame
      end
      object Label65: TLabel
        Left = 14
        Top = 14
        Width = 72
        Height = 15
        HelpContext = 371299
        Caption = 'Pack Weight'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label66: TLabel
        Left = 48
        Top = 81
        Width = 36
        Height = 15
        HelpContext = 371300
        Alignment = taRightJustify
        Caption = 'Field 1'
        Transparent = True
      end
      object Label67: TLabel
        Left = 48
        Top = 117
        Width = 36
        Height = 15
        HelpContext = 371301
        Alignment = taRightJustify
        Caption = 'Field 2'
        Transparent = True
      end
      object Label68: TLabel
        Left = 207
        Top = 46
        Width = 43
        Height = 15
        HelpContext = 371303
        Alignment = taRightJustify
        Caption = 'Caption'
        Transparent = True
      end
      object Label69: TLabel
        Left = 332
        Top = 46
        Width = 177
        Height = 15
        HelpContext = 371304
        Alignment = taRightJustify
        Caption = 'Calculate Transaction Qty From'
        Transparent = True
      end
      object Label70: TLabel
        Left = 104
        Top = 46
        Width = 38
        Height = 15
        HelpContext = 371305
        Alignment = taRightJustify
        Caption = 'Enable'
        Transparent = True
      end
      object wwDBEdit23: TwwDBEdit
        Left = 148
        Top = 77
        Width = 170
        Height = 23
        HelpContext = 371310
        DataField = 'PackWeightField1'
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
      object wwDBEdit24: TwwDBEdit
        Left = 148
        Top = 113
        Width = 170
        Height = 23
        HelpContext = 371311
        DataField = 'PackWeightField2'
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
      object chkPackWeightQtyField1: TwwCheckBox
        Left = 334
        Top = 80
        Width = 16
        Height = 17
        HelpContext = 371313
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
        Caption = 'Calculate Transaction Qty from  Pack Weight - 1'
        TabOrder = 2
        OnClick = OnchooseQtyOption
      end
      object chkPackWeightQtyField2: TwwCheckBox
        Left = 332
        Top = 116
        Width = 16
        Height = 17
        HelpContext = 371314
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
        Caption = 'Calculate Transaction Qty from  Pack Weight - 2'
        TabOrder = 3
        OnClick = OnchooseQtyOption
      end
      object chkEnablePackWeightField1: TwwCheckBox
        Left = 112
        Top = 80
        Width = 16
        Height = 17
        HelpContext = 371315
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
        Caption = 'Enable Pack Weight - 1'
        DataField = 'EnablePackWeightField1'
        DataSource = dsPrefs
        TabOrder = 4
      end
      object chkEnablePackWeightField2: TwwCheckBox
        Left = 112
        Top = 116
        Width = 16
        Height = 17
        HelpContext = 371316
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
        Caption = 'Enable Pack Weight - 2'
        DataField = 'EnablePackWeightField2'
        DataSource = dsPrefs
        TabOrder = 5
        OnClick = chkEnablePackWeightField2Click
      end
    end
    object DNMPanel2: TDNMPanel
      Left = 0
      Top = 279
      Width = 1064
      Height = 194
      HelpContext = 371170
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Bevel2: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1050
        Height = 180
        HelpContext = 371171
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitHeight = 182
      end
      object Bevel3: TBevel
        Left = 24
        Top = 40
        Width = 502
        Height = 142
        HelpContext = 371172
        Shape = bsFrame
      end
      object Label6: TLabel
        Left = 14
        Top = 14
        Width = 104
        Height = 15
        HelpContext = 371173
        Caption = 'Product Attributes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label27: TLabel
        Left = 253
        Top = 57
        Width = 179
        Height = 15
        HelpContext = 371017
        Caption = 'No of Attributes to be displayed '
        Transparent = True
      end
      object lblAttrib1Caption: TLabel
        Left = 253
        Top = 86
        Width = 87
        Height = 15
        HelpContext = 371176
        Caption = 'Attrib 1 Caption'
        Transparent = True
      end
      object lblAttrib2caption: TLabel
        Left = 397
        Top = 86
        Width = 87
        Height = 15
        HelpContext = 371177
        Caption = 'Attrib 2 Caption'
        Transparent = True
      end
      object Label71: TLabel
        Left = 397
        Top = 133
        Width = 87
        Height = 15
        HelpContext = 371179
        Caption = 'Attrib 1 Caption'
        Transparent = True
      end
      object chkEnableAttributes: TwwCheckBox
        Left = 40
        Top = 56
        Width = 184
        Height = 17
        HelpContext = 371025
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
        Caption = 'Enable Product Attributes'
        DataField = 'ShowProductAttributes'
        DataSource = dsPrefs
        TabOrder = 0
        OnClick = chkEnableAttributesClick
      end
      object edtNoOfAttribstodisplay: TwwDBEdit
        Left = 454
        Top = 53
        Width = 65
        Height = 23
        HelpContext = 371180
        DataField = 'NoOfAttribstodisplay'
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
      object chkShowMeasurementAttributes: TwwCheckBox
        Left = 40
        Top = 103
        Width = 222
        Height = 17
        HelpContext = 371181
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
        Caption = 'Enable Measurement Attributes'
        DataField = 'ShowMeasurementAttributes'
        DataSource = dsPrefs
        TabOrder = 2
        OnClick = chkShowMeasurementAttributesClick
      end
      object edtProductAttrib1Name: TwwDBEdit
        Left = 253
        Top = 101
        Width = 120
        Height = 23
        HelpContext = 371182
        DataField = 'ProductAttrib1Name'
        DataSource = dsPrefs
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
      object edtProductAttrib2Name: TwwDBEdit
        Left = 396
        Top = 101
        Width = 120
        Height = 23
        HelpContext = 371183
        DataField = 'ProductAttrib2Name'
        DataSource = dsPrefs
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
      object wwCheckBox18: TwwCheckBox
        Left = 40
        Top = 151
        Width = 333
        Height = 17
        HelpContext = 371184
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
        Caption = 'Enable Reportable Quantity Attributes'
        DataField = 'ShowProductExtraAttributes'
        DataSource = dsPrefs
        TabOrder = 5
        OnClick = chkShowMeasurementAttributesClick
      end
      object wwDBEdit16: TwwDBEdit
        Left = 397
        Top = 148
        Width = 120
        Height = 23
        HelpContext = 371185
        DataField = 'ProductAttrib3Name'
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
      object chkEnableProductOptions: TwwCheckBox
        Left = 40
        Top = 198
        Width = 184
        Height = 17
        HelpContext = 371025
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
        Caption = 'Enable Product Options'
        DataField = 'ShowProductOptions'
        DataSource = dsPrefs
        TabOrder = 7
        Visible = False
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 657
    Top = 88
  end
  inherited tmrdelay: TTimer
    Left = 688
    Top = 88
  end
  inherited popSpelling: TPopupMenu
    Left = 352
    Top = 8
  end
  inherited tmrdelayMsg: TTimer
    Left = 719
    Top = 88
  end
  object MyConnection: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    BeforeConnect = MyConnectionBeforeConnect
    LoginPrompt = False
    Left = 750
    Top = 88
  end
  object dsPrefs: TDataSourcePrefs
    OnStateChange = dsPrefsStateChange
    Connection = MyConnection
    FieldDefs = <>
    FieldNames.Strings = (
      'AllocationBatchTruckLoadNoGenerateMode'
      'AllowChangingProductAllocationFlags'
      'AllowToPickFromOthersalesIntheGroup'
      'AllowtoshipnPickFromBackorderinthegroup'
      'AutoAddBarcodes'
      'AutoAddProdCode'
      'AutoConvertSOtoInvoiceBarcodePick'
      'AutoEditInvoiceBarcodePick'
      'AutoLocateLastRecord'
      'AutoLocateproductinList'
      'AutoPickBatches'
      'AutopickBins'
      'BarcodePickingType'
      'BatchAllocationColour'
      'BatchAllocationGradIntensity'
      'BinAllocationColour'
      'BinAllocationGradIntensity'
      'CostEditableinSales'
      'CostUpdateFromPurchase'
      'CountSOBOInAvailable'
      'DefaultProductVolume'
      'DefaultPurchaseTaxCode'
      'DefaultSalesTaxCode'
      'DefaultStockTransferAccount'
      'DefPartsAssetAccount'
      'DefPartsCOGSAccount'
      'DefPartsIncomeAccount'
      'DoUpdateProductQtySum'
      'EnableBatchByDefault'
      'EnableBinByDefault'
      'EnablePackWeightField1'
      'EnablePackWeightField2'
      'EnablePQADEtailsCUSTFLD1'
      'EnablePQADetailsCUSTFLD4'
      'EnableSerialsByDefault'
      'EnforceAllocationValidation'
      'EnforceAllocationValidationinPI'
      'EnforceBinvolume'
      'GrossWeightnQtyRelated'
      'IndicateifBatchAllocated'
      'IndicateifBinAllocated'
      'IndicateifSNAllocated'
      'InsuranceAgencyREf1'
      'InsuranceAgencyREf2'
      'InsurancePremiumcharged'
      'InsuranceProductListMinCost'
      'InsuranceProductNameStartsWith'
      'InsurancereportOrderbyProductNameStartswith1'
      'InsurancereportOrderbyProductNameStartswith2'
      'ManifestType'
      'MatchUOMinallocation'
      'MinAboveCost'
      'NoOfAttribstodisplay'
      'PackWeightField1'
      'PackWeightField2'
      'PackWeightQtyField'
      'PartCalcfield1'
      'PartCalcField1Name'
      'PartCalcfield2'
      'PartCalcfield2Name'
      'PartCalcfield3'
      'PartCalcfield3Name'
      'PartCalcfield4'
      'PartCalcfield4Name'
      'PartCalcfield5'
      'PartCalcfield5Name'
      'PQADEtailsCUSTFLD1'
      'PQADetailsCUSTFLD4'
      'PrintConNotesBarcodePick'
      'PrintDelDocketBarcodePick'
      'PrintInvoiceBarcodePick'
      'ProductAttrib1Name'
      'ProductAttrib2Name'
      'ProductAttrib3Name'
      'ProductClassDefaultAll'
      'ProductfirstcolumnDropdownWidth'
      'ProductListPriceMultiplier'
      'ProductListPriceMultiplierOn'
      'ProductNameDropdownWidth'
      'ProductPODescDropdownWidth'
      'ProductPreferedSupDropdownWidth'
      'ProductPriceRoundLotsnRoundup'
      'ProductPriceRoundLotsof'
      'ProductPriceRoundUp'
      'ProductReorderRoundNearest'
      'ProductReorderRoundValue'
      'ProductSalesDescDropdownWidth'
      'ProductsecondcolumnDropdownWidth'
      'ProductSupplierProductCodeDropdownWidth'
      'ProductthirdcolumnDropdownWidth'
      'QtyRoundTo'
      'QtyShippedColour'
      'QtyShippedGradIntensity'
      'QtySoldColour'
      'QtySoldGradIntensity'
      'ShowAllocationBatchExpiryDate'
      'ShowAllocationBatchTruckLoadNo'
      'ShowMeasurementAttributes'
      'ShowProductAttributes'
      'ShowProductExtraAttributes'
      'ShowProductOptions'
      'ShowSoldSerialNumbers'
      'SmartOrderbasedOn'
      'SNAllocationColour'
      'SNAllocationGradIntensity'
      'StandardCostCOGSAdjustmentAccountID'
      'StandardCostPurchaseAdjustmentAccountID'
      'StockCostSystem'
      'SubBOMUseAvailableQtyFromStock'
      'TotalvolumeUOMInsmartOrder'
      'UOMforTotalvolumeInsmartOrder'
      'UOMToBeUsedInManufactureDefault'
      'UOMVolumeDimensionUOM'
      'UOMWeightUOM'
      'UseBarcodeDispatch'
      'UseCustFld1ForSaleLineBatchAllocation'
      'UseInventoryStandardCosting'
      'ValidateAllocation'
      'WholesalePercentag')
    Left = 813
    Top = 88
  end
  object qryAccount: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblChartofAccounts.*, AccDesc as Type'
      'FROM tblChartofAccounts'
      'LEFT JOIN tblacctypedesc on  AccType = AccountType'
      'WHERE IsHeader = '#39'F'#39' AND Active = '#39'T'#39
      'ORDER BY AccDesc, AccountName;')
    Left = 938
    Top = 88
  end
  object dsPartsClassPreferences: TDataSource
    DataSet = qryPartsClassPreferences
    Left = 781
    Top = 88
  end
  object qryPartsClassPreferences: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ID, ClassID, ClassName '
      'FROM tblpartsclasspreferences')
    AfterPost = qryPartsClassPreferencesAfterPost
    Left = 844
    Top = 88
  end
  object qryClass: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClassID, ClassName, ClassPercent'
      'FROM tblClass '
      'WHERE (ClassName Is Not Null) AND (Active <> '#39'F'#39') '
      'ORDER BY ClassName; ')
    Left = 875
    Top = 88
  end
  object cbTaxCodeQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT TaxCodeID, Name as TaxCode, Name, Description, Rate  '
      'FROM tbltaxcodes '
      'where Active <>'#39'F'#39'  AND  RegionID= :xRegionID;')
    Left = 906
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end>
    object cbTaxCodeQryName: TWideStringField
      DisplayLabel = 'Tax Code'
      DisplayWidth = 5
      FieldName = 'Name'
      FixedChar = True
      Size = 5
    end
    object cbTaxCodeQryDescription: TWideStringField
      DisplayWidth = 30
      FieldName = 'Description'
      FixedChar = True
      Size = 255
    end
    object cbTaxCodeQryTaxRatePercent: TFloatField
      DisplayLabel = 'Rate'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TaxRatePercent'
      DisplayFormat = '#0.0'#39'%'#39
      Calculated = True
    end
    object cbTaxCodeQryRate: TFloatField
      DisplayWidth = 4
      FieldName = 'Rate'
      Visible = False
    end
    object cbTaxCodeQryTaxCodeID: TAutoIncField
      FieldName = 'TaxCodeID'
      ReadOnly = True
      Visible = False
    end
    object cbTaxCodeQryTaxCode: TWideStringField
      FieldName = 'TaxCode'
      FixedChar = True
      Size = 15
    end
  end
end
