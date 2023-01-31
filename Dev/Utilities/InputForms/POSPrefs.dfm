inherited POSPrefsGUI: TPOSPrefsGUI
  Left = 100
  Top = 100
  HelpContext = 427000
  Caption = 'POS Preferences'
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
    HelpContext = 427086
    ExplicitTop = 719
    ExplicitWidth = 760
  end
  object lblWidth: TLabel [1]
    Left = 16
    Top = 8
    Width = 863
    Height = 22
    HelpContext = 427001
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
    HelpContext = 427163
    VertScrollBar.Position = 1442
    ExplicitWidth = 938
    ExplicitHeight = 719
    object DNMPanel3: TDNMPanel
      Left = 0
      Top = -1442
      Width = 1065
      Height = 716
      HelpContext = 427025
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Bevel3: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 702
        HelpContext = 427026
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 6
        ExplicitWidth = 532
        ExplicitHeight = 604
      end
      object Bevel8: TBevel
        Left = 26
        Top = 558
        Width = 468
        Height = 44
        HelpContext = 427111
        Shape = bsFrame
      end
      object Label11: TLabel
        Left = 14
        Top = 14
        Width = 82
        Height = 15
        HelpContext = 427027
        Caption = 'Miscellaneous'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object lblPCCPath: TLabel
        Left = 24
        Top = 481
        Width = 154
        Height = 15
        HelpContext = 427043
        Caption = 'Path to PCC Visual Console'
        Enabled = False
        Transparent = True
      end
      object Label50: TLabel
        Left = 450
        Top = 451
        Width = 57
        Height = 15
        HelpContext = 427044
        Caption = 'Auto Start'
        Transparent = True
      end
      object Label57: TLabel
        Left = 24
        Top = 510
        Width = 124
        Height = 15
        HelpContext = 427089
        Caption = 'OPOS Scale Multiplier'
        Transparent = True
      end
      object Label49: TLabel
        Left = 69
        Top = 573
        Width = 97
        Height = 15
        HelpContext = 427042
        Caption = 'Round  in Lots of '
        Transparent = True
      end
      object Label51: TLabel
        Left = 24
        Top = 540
        Width = 128
        Height = 15
        HelpContext = 427117
        Caption = 'POS Rounding Options'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label48: TLabel
        Left = 226
        Top = 573
        Width = 132
        Height = 15
        HelpContext = 427118
        Alignment = taCenter
        AutoSize = False
        Caption = 'cents and Round from '
        Transparent = True
      end
      object Label52: TLabel
        Left = 420
        Top = 573
        Width = 33
        Height = 15
        HelpContext = 427119
        Caption = 'Cents'
        Transparent = True
      end
      object lblPOSBliandBalanceVarianceAccount: TLabel
        Left = 24
        Top = 451
        Width = 100
        Height = 15
        HelpContext = 427153
        Caption = 'Variance Account'
        Transparent = True
      end
      object Label55: TLabel
        Left = 46
        Top = 648
        Width = 297
        Height = 15
        HelpContext = 427157
        Caption = 
          'Use Cash Drop -  ( Cash Drop  in Lots of                        ' +
          ')'
        Transparent = True
      end
      object wwCheckBox5: TwwCheckBox
        Left = 24
        Top = 40
        Width = 255
        Height = 17
        HelpContext = 427045
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
        Caption = 'Must Select Sales Person'
        DataField = 'MultiSalesPerson'
        DataSource = dsPrefs
        TabOrder = 0
      end
      object wwCheckBox9: TwwCheckBox
        Left = 24
        Top = 69
        Width = 255
        Height = 17
        HelpContext = 427046
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
        Caption = 'Enforce Password'
        DataField = 'POSPassword'
        DataSource = dsPrefs
        TabOrder = 1
      end
      object wwCheckBox15: TwwCheckBox
        Left = 24
        Top = 98
        Width = 255
        Height = 17
        HelpContext = 427047
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
        Caption = 'Show Product Picture'
        DataField = 'POSShowProductPic'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object wwCheckBox16: TwwCheckBox
        Left = 24
        Top = 128
        Width = 255
        Height = 17
        HelpContext = 427048
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
        Caption = 'Use Alpha Numeric Barcodes'
        DataField = 'UseAlphaNumericBarcodes'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object wwCheckBox10: TwwCheckBox
        Left = 24
        Top = 157
        Width = 255
        Height = 17
        HelpContext = 427049
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
        Caption = 'Multiple Tills'
        DataField = 'MultiTills'
        DataSource = dsPrefs
        TabOrder = 4
      end
      object wwCheckBox18: TwwCheckBox
        Left = 24
        Top = 216
        Width = 255
        Height = 17
        HelpContext = 427050
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
        Caption = 'Use Traffic Monitoring (COM2)'
        DataField = 'UseTrafficMonitor'
        DataSource = dsPrefs
        TabOrder = 5
        Visible = False
      end
      object wwCheckBox19: TwwCheckBox
        Left = 24
        Top = 245
        Width = 255
        Height = 17
        HelpContext = 427051
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
        Caption = 'Integrated EFTPOS'
        DataField = 'IntegratedEFTPOS'
        DataSource = dsPrefs
        TabOrder = 6
      end
      object wwCheckBox22: TwwCheckBox
        Left = 282
        Top = 40
        Width = 222
        Height = 17
        HelpContext = 427052
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
        Caption = 'Use Process Orders in POS'
        DataField = 'POSCreateOrders'
        DataSource = dsPrefs
        TabOrder = 7
      end
      object chkUseBlindBalance: TwwCheckBox
        Left = 282
        Top = 69
        Width = 222
        Height = 17
        HelpContext = 427053
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
        Caption = 'Use Blind Balance'
        DataField = 'UseBlindBalance'
        DataSource = dsPrefs
        TabOrder = 8
      end
      object wwCheckBox24: TwwCheckBox
        Left = 282
        Top = 98
        Width = 222
        Height = 17
        HelpContext = 427054
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
        Caption = 'Enforce Refund Verification'
        DataField = 'POSRestrictRefund'
        DataSource = dsPrefs
        TabOrder = 9
      end
      object wwCheckBox25: TwwCheckBox
        Left = 282
        Top = 128
        Width = 222
        Height = 17
        HelpContext = 427055
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
        Caption = 'Auto Picking Slip for Laybys'
        DataField = 'POSLaybyPickSlip'
        DataSource = dsPrefs
        TabOrder = 10
      end
      object wwCheckBox26: TwwCheckBox
        Left = 282
        Top = 157
        Width = 222
        Height = 17
        HelpContext = 427056
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
        Caption = 'Use Numeric Key Pad'
        DataField = 'POSNumKeyPad'
        DataSource = dsPrefs
        TabOrder = 11
      end
      object wwCheckBox27: TwwCheckBox
        Left = 282
        Top = 186
        Width = 222
        Height = 17
        HelpContext = 427057
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
        Caption = 'Don'#39't Return to Primary Keypad'
        DataField = 'NoReturntoPrimaryKeypad'
        DataSource = dsPrefs
        TabOrder = 12
      end
      object wwCheckBox28: TwwCheckBox
        Left = 282
        Top = 216
        Width = 222
        Height = 17
        HelpContext = 427058
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
        Caption = 'Close Invoice After Create'
        DataField = 'POSCloseInvoiceAfterCreate'
        DataSource = dsPrefs
        TabOrder = 13
      end
      object edtPCCPathToVC: TwwDBEdit
        Left = 210
        Top = 477
        Width = 185
        Height = 23
        HelpContext = 427060
        DataField = 'PCCPathToVisualConsole'
        DataSource = dsPrefs
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object btnPCCPathSelect: TDNMSpeedButton
        Left = 398
        Top = 475
        Width = 23
        Height = 22
        HelpContext = 427061
        Color = clWhite
        DisableTransparent = False
        Enabled = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          5555555555555555555555555555555555555555555555555555555555555555
          555555555555555555555555555555555555555FFFFFFFFFF555550000000000
          55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
          B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
          000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
          555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
          55555575FFF75555555555700007555555555557777555555555555555555555
          5555555555555555555555555555555555555555555555555555}
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        NumGlyphs = 2
        ParentColor = False
        SlowDecease = True
        Style = bsModern
        TabOrder = 15
        AutoDisableParentOnclick = True
      end
      object wwCheckBox12: TwwCheckBox
        Left = 450
        Top = 478
        Width = 16
        Height = 17
        HelpContext = 427062
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
        Caption = 'Path to PCC Visual Console Auto Start'
        DataField = 'PCCVCAutoStart'
        DataSource = dsPrefs
        TabOrder = 16
      end
      object wwCheckBox11: TwwCheckBox
        Left = 282
        Top = 245
        Width = 222
        Height = 17
        HelpContext = 427120
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
        Caption = 'Must Provide Postcode'
        DataField = 'MustProvidePOSPostCode'
        DataSource = dsPrefs
        TabOrder = 17
      end
      object wwCheckBox13: TwwCheckBox
        Left = 282
        Top = 275
        Width = 222
        Height = 17
        HelpContext = 427121
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
        Caption = 'Must Provide Source'
        DataField = 'MustProvidePOSSource'
        DataSource = dsPrefs
        TabOrder = 18
      end
      object wwCheckBox14: TwwCheckBox
        Left = 24
        Top = 186
        Width = 255
        Height = 17
        HelpContext = 427122
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
        Caption = 'Must Provide Details for Cash Out'
        DataField = 'MustProvideDetailsforCashout'
        DataSource = dsPrefs
        TabOrder = 19
      end
      object wwCheckBox17: TwwCheckBox
        Left = 24
        Top = 275
        Width = 255
        Height = 17
        HelpContext = 427123
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
        Caption = 'Copy Client Details to Sales Comments'
        DataField = 'CopyClientDetailstoSalesComments'
        DataSource = dsPrefs
        TabOrder = 20
      end
      object chkPOSPrintAfterSave: TwwCheckBox
        Left = 24
        Top = 333
        Width = 333
        Height = 17
        HelpContext = 427124
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
        Caption = 'Print to the A4 Printer When Sale is Completed'
        DataField = 'POSPrintAfterSave'
        DataSource = dsPrefs
        TabOrder = 21
      end
      object edtValue: TwwDBEdit
        Left = 210
        Top = 506
        Width = 55
        Height = 23
        HelpContext = 427090
        DataField = 'OPOSScaleMultiplier'
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
      object chkRoundLotsnfrom: TwwCheckBox
        Left = 45
        Top = 572
        Width = 16
        Height = 17
        HelpContext = 427125
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
        Caption = 'POs Rounding Options'
        DataField = 'RoundLotsnRoundup'
        DataSource = dsPrefs
        TabOrder = 23
        OnExit = chkRoundLotsnfromExit
      end
      object spedtRoundLotsOf: TwwDBSpinEdit
        Left = 169
        Top = 569
        Width = 56
        Height = 23
        HelpContext = 427091
        Increment = 1.000000000000000000
        DataField = 'RoundLotsof'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 24
        UnboundDataType = wwDefault
      end
      object edtRoundUp: TwwDBSpinEdit
        Left = 358
        Top = 569
        Width = 56
        Height = 23
        HelpContext = 427092
        Increment = 1.000000000000000000
        DataField = 'RoundUp'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 25
        UnboundDataType = wwDefault
        OnEnter = cboRoundUpEnter
      end
      object wwCheckBox20: TwwCheckBox
        Left = 24
        Top = 363
        Width = 333
        Height = 17
        HelpContext = 427148
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
        Caption = 'Print Product Group Report in End of Period'
        DataField = 'PrintEOPProductGroupreport'
        DataSource = dsPrefs
        TabOrder = 26
      end
      object chkCombineQuantity: TwwCheckBox
        Left = 24
        Top = 304
        Width = 333
        Height = 17
        HelpContext = 427149
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
        Caption = 'Combine Quantities for Same Part Number'
        DataField = 'CombinePOSQuntities'
        DataSource = dsPrefs
        TabOrder = 27
      end
      object wwCheckBox21: TwwCheckBox
        Left = 24
        Top = 613
        Width = 333
        Height = 17
        HelpContext = 427151
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
        Caption = 'Disable Audit Trial In QuickPOS'
        DataField = 'DisableAuditTrialinQuickPOS'
        DataSource = dsPrefs
        TabOrder = 28
      end
      object chkPOSPostBlindBalanceVariance: TwwCheckBox
        Left = 24
        Top = 422
        Width = 333
        Height = 17
        HelpContext = 427154
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
        Caption = 'Post POS Blind Balance to Variance Account'
        DataField = 'POSPostBlindBalanceVariance'
        DataSource = dsPrefs
        TabOrder = 29
        OnClick = chkPOSPostBlindBalanceVarianceClick
      end
      object cboPOSBliandBalanceVarianceAccount: TwwDBLookupCombo
        Left = 136
        Top = 447
        Width = 243
        Height = 23
        HelpContext = 427155
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Accoun tName'#9'F'
          'AccountType'#9'15'#9'Account Type'#9'F')
        DataField = 'POSBliandBalanceVarianceAccount'
        DataSource = dsPrefs
        LookupTable = gryIncomeAccountLookup
        LookupField = 'AccountName'
        Options = [loTitles]
        ParentFont = False
        TabOrder = 30
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = True
      end
      object wwCheckBox23: TwwCheckBox
        Left = 24
        Top = 392
        Width = 333
        Height = 17
        HelpContext = 427158
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
        Caption = 'POS End of Period Report 24 Hours'
        DataField = 'EOPReportShowAlltimeSlots'
        DataSource = dsPrefs
        TabOrder = 31
      end
      object wwCheckBox29: TwwCheckBox
        Left = 24
        Top = 648
        Width = 16
        Height = 17
        HelpContext = 427159
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
        Caption = 'Use Cash Drop'
        DataField = 'UseCashDrop'
        DataSource = dsPrefs
        TabOrder = 32
        OnExit = chkRoundLotsnfromExit
      end
      object wwDBSpinEdit1: TwwDBSpinEdit
        Left = 277
        Top = 645
        Width = 56
        Height = 23
        HelpContext = 427160
        Increment = 1.000000000000000000
        DataField = 'CashDropLotsOf'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 33
        UnboundDataType = wwDefault
      end
      object wwCheckBox30: TwwCheckBox
        Left = 24
        Top = 683
        Width = 333
        Height = 17
        HelpContext = 427162
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
        Caption = 'Show PopUp To Confirm Total Payment Value On Sales'
        DataField = 'PosConfirmTotalPayment'
        DataSource = dsPrefs
        TabOrder = 34
      end
    end
    object DNMPanel2: TDNMPanel
      Left = 0
      Top = 746
      Width = 1065
      Height = 113
      HelpContext = 427018
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Bevel2: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 99
        HelpContext = 427019
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 49
        ExplicitTop = 3
        ExplicitWidth = 531
      end
      object Label8: TLabel
        Left = 14
        Top = 14
        Width = 176
        Height = 15
        HelpContext = 427020
        Caption = 'Hide Line Amounts on Receipts'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox7: TwwCheckBox
        Left = 24
        Top = 40
        Width = 222
        Height = 17
        HelpContext = 427023
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
        Caption = 'Laybys'
        DataField = 'POSHideLaybyRcptAmnt'
        DataSource = dsPrefs
        TabOrder = 0
      end
      object wwCheckBox8: TwwCheckBox
        Left = 24
        Top = 72
        Width = 222
        Height = 17
        HelpContext = 427024
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
        Caption = 'All Sales'
        DataField = 'POSHideSalesRcptAmnt'
        DataSource = dsPrefs
        TabOrder = 1
      end
    end
    object DNMPanel1: TDNMPanel
      Left = 0
      Top = 513
      Width = 1065
      Height = 233
      HelpContext = 427002
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Bevel7: TBevel
        Left = 256
        Top = 162
        Width = 268
        Height = 59
        HelpContext = 427087
      end
      object Bevel1: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 219
        HelpContext = 427003
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 3
        ExplicitTop = 9
        ExplicitWidth = 539
      end
      object Label1: TLabel
        Left = 14
        Top = 14
        Width = 85
        Height = 15
        HelpContext = 427004
        Caption = 'Receipt Printer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label6: TLabel
        Left = 256
        Top = 40
        Width = 114
        Height = 15
        HelpContext = 427010
        Caption = 'Receipt Printer Type'
        Transparent = True
      end
      object lblUSBPrinter: TLabel
        Left = 266
        Top = 174
        Width = 66
        Height = 15
        HelpContext = 427108
        Caption = 'USB Printer'
        Transparent = True
      end
      object wwCheckBox1: TwwCheckBox
        Left = 24
        Top = 40
        Width = 222
        Height = 17
        HelpContext = 427011
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
        Caption = 'Use Receipt Printer for POS'
        DataField = 'ReceiptPrinterON'
        DataSource = dsPrefs
        TabOrder = 0
      end
      object wwCheckBox2: TwwCheckBox
        Left = 24
        Top = 78
        Width = 222
        Height = 17
        HelpContext = 427012
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
        Caption = 'Use Cash Drawer from Cash Sale'
        DataField = 'OpenCashDrawerFromCashSale'
        DataSource = dsPrefs
        TabOrder = 1
      end
      object wwCheckBox3: TwwCheckBox
        Left = 24
        Top = 116
        Width = 222
        Height = 17
        HelpContext = 427013
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
        Caption = 'Cash Drawer Only'
        DataField = 'POSUseCashDrawerOnly'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object wwCheckBox6: TwwCheckBox
        Left = 24
        Top = 154
        Width = 222
        Height = 17
        HelpContext = 427014
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
        Caption = 'Print Receipts on Complete Sale'
        DataField = 'POSPrintReceiptOnlyOnCompleteSale'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object wwCheckBox4: TwwCheckBox
        Left = 24
        Top = 193
        Width = 222
        Height = 17
        HelpContext = 427015
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
        Caption = 'Multiple Lines for Description'
        DataField = 'POSPrintDescriptionMultipleLines'
        DataSource = dsPrefs
        TabOrder = 4
      end
      object cboReceiptPrinterType: TwwDBComboBox
        Left = 384
        Top = 36
        Width = 142
        Height = 23
        HelpContext = 427016
        ShowButton = True
        Style = csDropDownList
        MapList = True
        AllowClearKey = False
        DataField = 'ReceiptPrinterType'
        DataSource = dsPrefs
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          'Epson'#9'EPSON'
          'Star'#9'STAR'
          'Citizen'#9'CITIZEN'
          'Citizen iDP460'#9'CTZ460'
          'Citizen iDP3540'#9'CTZ3540'
          'Hero TH200'#9'HERO'
          'Eltron Companion'#9'COMPANION'
          'Epson TM-U220 Series on USB'#9'EPSON-TM-U220'
          'Epson TM-T82II Series on USB'#9'EPSON-TM-T82II'
          'STAR TSP-100 Series on USB'#9'STAR-TSP-100')
        ItemIndex = 0
        ParentFont = False
        Sorted = False
        TabOrder = 5
        UnboundDataType = wwDefault
        OnChange = cboReceiptPrinterTypeChange
      end
      object grpPrnPorts: TwwRadioGroup
        Left = 256
        Top = 70
        Width = 269
        Height = 91
        HelpContext = 427017
        DisableThemes = False
        TransparentActiveItem = True
        Indents.TextX = 3
        Transparent = True
        Caption = 'Receipt Printer Port'
        Columns = 4
        DataField = 'ReceiptPrinterPort'
        DataSource = dsPrefs
        Items.Strings = (
          'None'
          'Com4'
          'Com1'
          'Lpt1'
          'Com2'
          'Lpt2'
          'Com3')
        TabOrder = 6
        Values.Strings = (
          'NUL:'
          'COM4:'
          'COM1:'
          'LPT1:'
          'COM2:'
          'LPT2:'
          'COM3:')
      end
      object cboUSBPrinter: TDBComboBox
        Left = 340
        Top = 170
        Width = 177
        Height = 23
        HelpContext = 427088
        DataField = 'USBPrinterName'
        DataSource = dsPrefs
        TabOrder = 7
        OnExit = cboUSBPrinterExit
      end
      object chkPrintPOSTemplateReport: TwwCheckBox
        Left = 316
        Top = 198
        Width = 191
        Height = 17
        HelpContext = 427110
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
        Caption = 'Print the Template Report'
        DataField = 'PrintPOSTemplateReport'
        DataSource = dsPrefs
        TabOrder = 8
      end
    end
    object DNMPanel4: TDNMPanel
      Left = 0
      Top = 266
      Width = 1065
      Height = 247
      HelpContext = 427076
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Bevel5: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 233
        HelpContext = 427077
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 231
      end
      object Label33: TLabel
        Left = 14
        Top = 14
        Width = 159
        Height = 15
        HelpContext = 427078
        Caption = 'Layby Terms and Conditions'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object lblIgnore1: TLabel
        Left = 22
        Top = 44
        Width = 330
        Height = 14
        HelpContext = 427080
        Caption = 
          ' Warning: Any text typed beyond the right hand side of this box ' +
          'may '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object lblIgnore2: TLabel
        Left = 69
        Top = 56
        Width = 124
        Height = 14
        HelpContext = 427081
        Caption = 'not appear on the receipt.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object DBMemo1: TDBMemo
        Left = 24
        Top = 76
        Width = 337
        Height = 143
        HelpContext = 427084
        DataField = 'LaybyTerms'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object DNMPanel5: TDNMPanel
      Left = 0
      Top = -249
      Width = 1065
      Height = 515
      HelpContext = 427100
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      DesignSize = (
        1065
        515)
      object Bevel6: TBevel
        Left = 8
        Top = 8
        Width = 903
        Height = 499
        HelpContext = 427101
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitWidth = 529
      end
      object Label38: TLabel
        Left = 14
        Top = 14
        Width = 105
        Height = 15
        HelpContext = 427102
        Caption = 'Receipt Templates'
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
        Top = 316
        Width = 330
        Height = 14
        HelpContext = 427103
        Caption = 
          ' Warning: Any text typed beyond the right hand side of this box ' +
          'may '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label41: TLabel
        Left = 74
        Top = 328
        Width = 124
        Height = 14
        HelpContext = 427104
        Caption = 'not appear on the receipt.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label35: TLabel
        Left = 24
        Top = 52
        Width = 82
        Height = 15
        HelpContext = 427079
        Caption = 'Receipt Footer'
        Transparent = True
      end
      object lblIgnore3: TLabel
        Left = 24
        Top = 72
        Width = 330
        Height = 14
        HelpContext = 427082
        Caption = 
          ' Warning: Any text typed beyond the right hand side of this box ' +
          'may '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object lblIgnore4: TLabel
        Left = 74
        Top = 84
        Width = 124
        Height = 14
        HelpContext = 427083
        Caption = 'not appear on the receipt.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label39: TLabel
        Left = 25
        Top = 297
        Width = 140
        Height = 14
        HelpContext = 427105
        Caption = 'Right Click inside for Options.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label42: TLabel
        Left = 24
        Top = 280
        Width = 83
        Height = 15
        HelpContext = 427106
        Caption = 'Reward Points'
        Transparent = True
      end
      object POSRewardPointTemplate: TDBMemo
        Left = 24
        Top = 352
        Width = 337
        Height = 143
        HelpContext = 427107
        DataField = 'POSRewardPointTemplate'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        PopupMenu = mnuPOSRewardPointTemplate
        ScrollBars = ssBoth
        ShowHint = False
        TabOrder = 1
      end
      object DBMemo2: TDBMemo
        Left = 24
        Top = 108
        Width = 337
        Height = 143
        HelpContext = 427085
        DataField = 'ReceiptFooter'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object pnlspecialbarcode: TDNMPanel
      Left = 0
      Top = -529
      Width = 1065
      Height = 280
      HelpContext = 427063
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      object Bevel10: TBevel
        AlignWithMargins = True
        Left = 14
        Top = 177
        Width = 438
        Height = 86
        HelpContext = 427064
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Shape = bsFrame
      end
      object Bevel4: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 266
        HelpContext = 427141
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 168
      end
      object Label14: TLabel
        Left = 14
        Top = 14
        Width = 93
        Height = 15
        HelpContext = 427065
        Caption = 'Special Barcode'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label21: TLabel
        Left = 24
        Top = 72
        Width = 84
        Height = 15
        HelpContext = 427066
        Caption = 'Entire Barcode'
        Transparent = True
      end
      object Label22: TLabel
        Left = 24
        Top = 104
        Width = 96
        Height = 15
        HelpContext = 427067
        Caption = 'Product Barcode'
        Transparent = True
      end
      object Label23: TLabel
        Left = 24
        Top = 136
        Width = 44
        Height = 15
        HelpContext = 427068
        Caption = 'Amount'
        Transparent = True
      end
      object Label24: TLabel
        Left = 136
        Top = 40
        Width = 46
        Height = 15
        HelpContext = 427069
        Caption = 'Position'
        Transparent = True
      end
      object Label32: TLabel
        Left = 200
        Top = 40
        Width = 39
        Height = 15
        HelpContext = 427070
        Caption = 'Length'
        Transparent = True
      end
      object lblamounthint: TLabel
        Left = 240
        Top = 108
        Width = 289
        Height = 62
        HelpContext = 427142
        AutoSize = False
        Caption = 
          '(Please note that the Currency '#39'AUD'#39' has 2 places for '#39'Cents'#39'.  ' +
          'So 2 digits on the right side will be considered as '#39'Cents'#39
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object lblSampleCodehint: TLabel
        Left = 187
        Top = 224
        Width = 214
        Height = 36
        HelpContext = 427143
        AutoSize = False
        Caption = 'Sample Special barcode'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label56: TLabel
        Left = 43
        Top = 202
        Width = 138
        Height = 15
        HelpContext = 427144
        Caption = 'Sample Special barcode'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtSpecialBarcodeProductPos: TwwDBEdit
        Left = 140
        Top = 96
        Width = 33
        Height = 23
        HelpContext = 427071
        DataField = 'SpecialBarcodeProductPos'
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
        OnExit = edtSpecialBarcodeLenExit
      end
      object edtSpecialBarcodeAmountPos: TwwDBEdit
        Left = 140
        Top = 128
        Width = 33
        Height = 23
        HelpContext = 427072
        DataField = 'SpecialBarcodeAmountPos'
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
        OnExit = edtSpecialBarcodeLenExit
      end
      object edtSpecialBarcodeLen: TwwDBEdit
        Left = 202
        Top = 64
        Width = 33
        Height = 23
        HelpContext = 427073
        DataField = 'SpecialBarcodeLen'
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
        OnExit = edtSpecialBarcodeLenExit
      end
      object edtSpecialBarcodeProductLen: TwwDBEdit
        Left = 202
        Top = 96
        Width = 33
        Height = 23
        HelpContext = 427074
        DataField = 'SpecialBarcodeProductLen'
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
        OnExit = edtSpecialBarcodeLenExit
      end
      object edtSpecialBarcodeAmountLen: TwwDBEdit
        Left = 202
        Top = 128
        Width = 33
        Height = 23
        HelpContext = 427075
        DataField = 'SpecialBarcodeAmountLen'
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
        OnExit = edtSpecialBarcodeLenExit
      end
      object edtSampleBarCode: TEdit
        Left = 187
        Top = 198
        Width = 214
        Height = 23
        HelpContext = 427145
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
        Text = 'edtSampleBarCode'
      end
    end
    object DNMPanel6: TDNMPanel
      Left = 0
      Top = -726
      Width = 1065
      Height = 197
      HelpContext = 427126
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      Visible = False
      object Bevel9: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 183
        HelpContext = 427127
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 6
        ExplicitWidth = 532
        ExplicitHeight = 604
      end
      object Label58: TLabel
        Left = 58
        Top = 99
        Width = 164
        Height = 15
        HelpContext = 427128
        Caption = 'Round Up to 0.05 Cents from '
        Transparent = True
      end
      object Label59: TLabel
        Left = 88
        Top = 71
        Width = 17
        Height = 15
        HelpContext = 427129
        Caption = 'OR'
        Transparent = True
      end
      object Label60: TLabel
        Left = 57
        Top = 47
        Width = 84
        Height = 15
        HelpContext = 427130
        Caption = 'Round  Lots of '
        Transparent = True
      end
      object Label61: TLabel
        Left = 88
        Top = 125
        Width = 17
        Height = 15
        HelpContext = 427131
        Caption = 'OR'
        Transparent = True
      end
      object Label62: TLabel
        Left = 60
        Top = 151
        Width = 84
        Height = 15
        HelpContext = 427132
        Caption = 'Round  Lots of '
        Transparent = True
      end
      object Label63: TLabel
        Left = 25
        Top = 18
        Width = 128
        Height = 15
        HelpContext = 427133
        Caption = 'POS Rounding Options'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label64: TLabel
        Left = 204
        Top = 151
        Width = 93
        Height = 15
        HelpContext = 427134
        Caption = 'and Round from '
        Transparent = True
      end
      object Label65: TLabel
        Left = 357
        Top = 151
        Width = 33
        Height = 15
        HelpContext = 427135
        Caption = 'Cents'
        Transparent = True
      end
      object wwDBComboBox1: TwwDBComboBox
        Left = 227
        Top = 95
        Width = 49
        Height = 23
        HelpContext = 427059
        ShowButton = True
        Style = csDropDownList
        MapList = False
        AllowClearKey = False
        DataField = 'RoundUp'
        DataSource = dsPrefs
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          '1'
          '2'
          '3'
          '4')
        ItemIndex = 2
        ParentFont = False
        Sorted = False
        TabOrder = 0
        UnboundDataType = wwDefault
      end
      object wwCheckBox31: TwwCheckBox
        Left = 33
        Top = 46
        Width = 16
        Height = 17
        HelpContext = 427136
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
        Caption = 'POS Rounding Options'
        DataField = 'RoundLots'
        DataSource = dsPrefs
        TabOrder = 1
      end
      object wwDBComboBox2: TwwDBComboBox
        Left = 161
        Top = 43
        Width = 49
        Height = 23
        HelpContext = 427137
        ShowButton = True
        Style = csDropDown
        MapList = False
        AllowClearKey = False
        DataField = 'RoundLotsof'
        DataSource = dsPrefs
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          '.2'
          '.25'
          '.5')
        ItemIndex = 2
        ParentFont = False
        Picture.PictureMask = '.#[#][#][#][#]'
        Sorted = False
        TabOrder = 2
        UnboundDataType = wwDefault
      end
      object wwCheckBox32: TwwCheckBox
        Left = 34
        Top = 98
        Width = 16
        Height = 17
        HelpContext = 427138
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
        Caption = 'POS Rounding Options'
        DataField = 'Roundup5Cents'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object wwCheckBox33: TwwCheckBox
        Left = 36
        Top = 150
        Width = 16
        Height = 17
        HelpContext = 427139
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
        Caption = 'POS Rounding Options'
        DataField = 'RoundLotsnRoundup'
        DataSource = dsPrefs
        TabOrder = 4
      end
      object wwDBEdit1: TwwDBEdit
        Left = 145
        Top = 147
        Width = 55
        Height = 23
        HelpContext = 427093
        DataField = 'RoundLotsof'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Picture.PictureMask = '#.#[#][#][#][#]'
        TabOrder = 5
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBComboBox3: TwwDBComboBox
        Left = 302
        Top = 147
        Width = 49
        Height = 23
        HelpContext = 427140
        ShowButton = True
        Style = csDropDownList
        MapList = False
        AllowClearKey = False
        DataField = 'RoundUp'
        DataSource = dsPrefs
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          '1'
          '2'
          '3'
          '4')
        ItemIndex = 2
        ParentFont = False
        Sorted = False
        TabOrder = 6
        UnboundDataType = wwDefault
        OnEnter = cboRoundUpEnter
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 606
    Top = 64
  end
  inherited tmrdelay: TTimer
    Left = 668
    Top = 64
  end
  inherited popSpelling: TPopupMenu
    Left = 699
    Top = 64
  end
  inherited tmrdelayMsg: TTimer
    Left = 637
    Top = 64
  end
  object MyConnection: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Connected = True
    LoginPrompt = False
    Left = 761
    Top = 64
  end
  object dsPrefs: TDataSourcePrefs
    Connection = MyConnection
    FieldDefs = <>
    FieldNames.Strings = (
      'CashDropLotsOf'
      'CombinePOSQuntities'
      'CopyClientDetailstoSalesComments'
      'DisableAuditTrialinQuickPOS'
      'EOPReportShowAlltimeSlots'
      'IntegratedEFTPOS'
      'LaybyTerms'
      'MultiSalesPerson'
      'MultiTills'
      'MustProvideDetailsforCashout'
      'MustProvidePOSPostCode'
      'MustProvidePOSSource'
      'NoReturntoPrimaryKeypad'
      'OpenCashDrawerFromCashSale'
      'OPOSScaleMultiplier'
      'PCCPathToVisualConsole'
      'PCCVCAutoStart'
      'POSBliandBalanceVarianceAccount'
      'POSCloseInvoiceAfterCreate'
      'PosConfirmTotalPayment'
      'POSCreateOrders'
      'POSHideLaybyRcptAmnt'
      'POSHideSalesRcptAmnt'
      'POSLaybyPickSlip'
      'POSNumKeyPad'
      'POSPassword'
      'POSPostBlindBalanceVariance'
      'POSPrintAfterSave'
      'POSPrintDescriptionMultipleLines'
      'POSPrintReceiptOnlyOnCompleteSale'
      'POSRestrictRefund'
      'POSRewardPointTemplate'
      'POSShowProductPic'
      'POSUseCashDrawerOnly'
      'PrintEOPProductGroupreport'
      'PrintPOSTemplateReport'
      'ReceiptFooter'
      'ReceiptPrinterON'
      'ReceiptPrinterPort'
      'ReceiptPrinterType'
      'RoundLots'
      'RoundLotsnRoundup'
      'RoundLotsof'
      'RoundUp'
      'Roundup5Cents'
      'SpecialBarcodeAmountLen'
      'SpecialBarcodeAmountPos'
      'SpecialBarcodeLen'
      'SpecialBarcodeProductLen'
      'SpecialBarcodeProductPos'
      'USBPrinterName'
      'UseAlphaNumericBarcodes'
      'UseBlindBalance'
      'UseCashDrop'
      'UsePCC'
      'UseTrafficMonitor')
    Left = 792
    Top = 64
  end
  object mnuPOSRewardPointTemplate: TPopupMenu
    Left = 576
    Top = 64
    object CustomerName1: TMenuItem
      Caption = 'Customer Name'
      HelpContext = 427094
      OnClick = CompanyName1Click
    end
    object SaleDate1: TMenuItem
      Caption = 'SaleDate'
      HelpContext = 427095
      OnClick = CompanyName1Click
    end
    object OpeningBalancePoints1: TMenuItem
      Caption = 'OpeningBalancePoints'
      HelpContext = 427096
      OnClick = CompanyName1Click
    end
    object RedeemedPoints1: TMenuItem
      Caption = 'RedeemedPoints'
      HelpContext = 427097
      OnClick = CompanyName1Click
    end
    object SalePoints1: TMenuItem
      Caption = 'SalePoints'
      HelpContext = 427098
      OnClick = CompanyName1Click
    end
    object CompanyName1: TMenuItem
      Caption = 'CompanyName'
      HelpContext = 427099
      OnClick = CompanyName1Click
    end
  end
  object gryIncomeAccountLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select AccountName, AccountType from tblChartOfAccounts where Ac' +
        'countType = "INC" and Active = "T"')
    Left = 730
    Top = 64
  end
end
